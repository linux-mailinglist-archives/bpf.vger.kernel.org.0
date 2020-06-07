Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F851F0FE4
	for <lists+bpf@lfdr.de>; Sun,  7 Jun 2020 22:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgFGUwf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Jun 2020 16:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgFGUwe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Jun 2020 16:52:34 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC298C08C5C6
        for <bpf@vger.kernel.org>; Sun,  7 Jun 2020 13:52:33 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id mb16so16031946ejb.4
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2020 13:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JgSg0nUmjgU7sByp0wJKY7SPiU8/MgItWfiEExjWy+I=;
        b=bst6Qrr+8cvaCJRT5lTVeil1E4WF+sgR80+lIKAajiO7CiASklqbSLebGuADp3C2Ix
         diYLkfqFW4r9FTPRBJfna5NHDRE+aQFyp0PMGCp268rr1O4w8DaG1v+BvtHBw+EDZ++E
         eG7+qWekpRSqvFWZnVVShe+DPXQ31X5Ld0VBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JgSg0nUmjgU7sByp0wJKY7SPiU8/MgItWfiEExjWy+I=;
        b=BYN9NsXSXoyImaJolkPNALuoryR7lootdMKaMpb19lIXRXK6U6oiWV7EBBcYrcjhGu
         jPwou1obTLOgK5MeERiuGilsvhDLUWqN/fhTGwyYLvVpF7KdTuPm97059Sh9cTjJm/tV
         3qer/lXye04ceCCui3dHoIaaKMWPjARoE0jGlgr1nf1tRj5lX+yiv10TMqnuNKCNuo3s
         xc9I3grtT3J3Jx7aWF4DDV21prEUd6holf+qD50Sa3BRGUrQ+8KhL4KOmD8AcZMVfKXZ
         BYK1gGNuRmvDAn77LbPyivxF6l8xEhDptAL36O1HSS42Ug0uRMgM2Q7JCGWjIKSb7gzy
         kB8w==
X-Gm-Message-State: AOAM533XST41RxUHrZeuWF/T40ss39lL8gK3JVMN8sfdKPtpIpbDJCIv
        CPfojwIvtHCqTVti8G2pluN8slIfI28=
X-Google-Smtp-Source: ABdhPJzYx1DgAxhfXWT8T4sUg1Zg9kTBrRhrupVTP3xgDcAuBZsaP0TigOau1PUlvKZNfyS8QpXPCA==
X-Received: by 2002:a17:906:ce2f:: with SMTP id sd15mr17895848ejb.445.1591563152353;
        Sun, 07 Jun 2020 13:52:32 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id bs1sm10415316edb.43.2020.06.07.13.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 13:52:31 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com
Subject: [PATCH bpf 1/2] bpf, sockhash: Fix memory leak when unlinking sockets in sock_hash_free
Date:   Sun,  7 Jun 2020 22:52:28 +0200
Message-Id: <20200607205229.2389672-2-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200607205229.2389672-1-jakub@cloudflare.com>
References: <20200607205229.2389672-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When sockhash gets destroyed while sockets are still linked to it, we will
walk the bucket lists and delete the links. However, we are not freeing the
list elements after processing them, leaking the memory.

The leak can be triggered by close()'ing a sockhash map when it still
contains sockets, and observed with kmemleak:

  unreferenced object 0xffff888116e86f00 (size 64):
    comm "race_sock_unlin", pid 223, jiffies 4294731063 (age 217.404s)
    hex dump (first 32 bytes):
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
      81 de e8 41 00 00 00 00 c0 69 2f 15 81 88 ff ff  ...A.....i/.....
    backtrace:
      [<00000000dd089ebb>] sock_hash_update_common+0x4ca/0x760
      [<00000000b8219bd5>] sock_hash_update_elem+0x1d2/0x200
      [<000000005e2c23de>] __do_sys_bpf+0x2046/0x2990
      [<00000000d0084618>] do_syscall_64+0xad/0x9a0
      [<000000000d96f263>] entry_SYSCALL_64_after_hwframe+0x49/0xb3

Fix it by freeing the list element when we're done with it.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock_map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 00a26cf2cfe9..ea46f07a22d8 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1031,6 +1031,7 @@ static void sock_hash_free(struct bpf_map *map)
 			sock_map_unref(elem->sk, elem);
 			rcu_read_unlock();
 			release_sock(elem->sk);
+			sock_hash_free_elem(htab, elem);
 		}
 	}
 
-- 
2.25.4

