Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F4E34954C
	for <lists+bpf@lfdr.de>; Thu, 25 Mar 2021 16:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhCYPWw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Mar 2021 11:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhCYPWe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Mar 2021 11:22:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AFEC06175F
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 08:22:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v4so2648732wrp.13
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 08:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ijnZ7UHj2HrGdWORqKGVBo/w2HVLEGIEyGldZdaNcc=;
        b=ohCl3mcgx9MJD83BZNCDXICb17bkmYPA4J6WXFpObzECY0l+4fBGN8NJLRohXRzKQy
         6Tr4OoS6Od7Pynjui91t92UKlZmTp1jttEy2O0+v0lA02XFpelHq6nqof3fS6g3WOV2A
         NhVeYNyQoz7XEc1LeBej7MAUZU866l4kdWjwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ijnZ7UHj2HrGdWORqKGVBo/w2HVLEGIEyGldZdaNcc=;
        b=eKAhN2JQym68iLfbX8vC5v+Vw2/gZyErQFFnTcndfjWx5m5tP8js6s6bGgckNMyK4+
         TrrQkYzIkv70A6amUh1oJJCkaIjWGI2JP2tyXP/5dJt2fYEHewewWY+uqF3uXeTSwOna
         BZcOSN6dlbT45Tb9Vp4WAy7hIh6EmsnBlTnOMFceB4RF9UI3CKn6YMajKMy/qU9V5hEy
         rnaa/L7Z2BzFH8wHrZu9LPpjKayOitbZTkFAI8j91vzxtvXpHt49JwpGvcgyLTIvY8zu
         pWVKO5J1VrMej5eHueJmuH700lxNwPau0S6e4NgJbslUA+/clJCjeDXkJry9C2WgfYeE
         nbHA==
X-Gm-Message-State: AOAM531HwzGUctfcfoijeAGRbBohTIel4haot0nMOmKvmkzISSoIfneP
        zpur9xJuHgEU8bWPU2Xdd7F9hglZrRVbiQ==
X-Google-Smtp-Source: ABdhPJyvlBy5lSgL81rUOvbztdfWbEzKoftUxGhFnfW8XJCVt4d6WNQLPjN0Xb1ZKZfYoEAnd6RYQQ==
X-Received: by 2002:adf:e485:: with SMTP id i5mr9653697wrm.26.1616685752802;
        Thu, 25 Mar 2021 08:22:32 -0700 (PDT)
Received: from localhost.localdomain (9.8.d.9.4.e.4.3.c.b.8.8.6.1.c.9.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:9c16:88bc:34e4:9d89])
        by smtp.gmail.com with ESMTPSA id a6sm7183120wmm.0.2021.03.25.08.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:22:32 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: link: refuse non-zero file_flags in BPF_OBJ_GET
Date:   Thu, 25 Mar 2021 15:21:46 +0000
Message-Id: <20210325152146.188654-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Invoking BPF_OBJ_GET on a pinned bpf_link checks the path access
permissions based on file_flags, but the returned fd ignores flags.
This means that any user can acquire a "read-write" fd for a pinned
link with mode 0664 by invoking BPF_OBJ_GET with BPF_F_RDONLY in
file_flags. The fd can be used to invoke BPF_LINK_DETACH, etc.

Fix this by refusing non-zero flags in BPF_OBJ_GET. Since zero flags
imply O_RDWR this requires users to have read-write access to the
pinned file, which matches the behaviour of the link primitive.

libbpf doesn't expose a way to set file_flags for links, so this
change is unlikely to break users.

Fixes: 70ed506c3bbc ("bpf: Introduce pinnable bpf_link abstraction")
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 kernel/bpf/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 1576ff331ee4..2f9e8115ad58 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -547,7 +547,7 @@ int bpf_obj_get_user(const char __user *pathname, int flags)
 	else if (type == BPF_TYPE_MAP)
 		ret = bpf_map_new_fd(raw, f_flags);
 	else if (type == BPF_TYPE_LINK)
-		ret = bpf_link_new_fd(raw);
+		ret = (flags) ? -EINVAL : bpf_link_new_fd(raw);
 	else
 		return -ENOENT;
 
-- 
2.27.0

