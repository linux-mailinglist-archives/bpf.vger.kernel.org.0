Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F10B10F13F
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2019 21:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfLBUBq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Dec 2019 15:01:46 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:33951 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfLBUBq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Dec 2019 15:01:46 -0500
Received: by mail-pj1-f74.google.com with SMTP id n4so564602pjb.1
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2019 12:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GT/6yNTmwD2DOGMzJN+K06ArW/qq3ZcQJhVAAjmKf88=;
        b=YmV4wMb/n7Fb319BdP58R2AvCRoVBxqIEdzFmSwkDfZLIpzTQRSv+bV3NFXAYO4KOY
         gV/+OiYdkz/yH8UqOTOj9Pz7hFuRSnsn2RcfR37M1+4Mybpvila7IpC6tOpYYPTyC5Hg
         hCMh4dC9NKGeLPviPR8zsUv9QLlQTY9rTWSXzePLiF9h+t+05BSL9YFZET47fIf5h+Ik
         u8njatgJI0kBWzWmrY3RSu52MIs/EgmM7AzOAuODgz19Y/0JAKs29u+GKdPMywUfx1BT
         wDrk6IyFxjAgkfAveXPTiqxZ/Ho8PcMObAkSg8tWkBCHu8BmvKmvcqE32jmZDRj6GLwp
         RnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GT/6yNTmwD2DOGMzJN+K06ArW/qq3ZcQJhVAAjmKf88=;
        b=PX03f04ObgypEQ7OJTxJyGcHFTCCAm5k3m+HxzFtN9cwIPXksS5aLEdFs5Y51kJstL
         jPBVq0Y+6Ea6uUAowBwEsmXhqmUt3pRzNqgBRUni5m6CQC1j1olYr0Lh0DbqgVi2FAkK
         5S+yBn9unlbccZbIEk9N9uRgzVfltK91WNx4xz+OS9t/c1spD8LOFclZ+nCuwfeFuoFY
         24pY6pNGWXCJPCzPdfknSq7OgyosKantDE0nSjyL6wfezW3RbnwSEVssTI/vFQAtTxyd
         Y15D6h1Lk/G6TqRWOfEP0qA4K75T2IbIcR06MsMcHFncEvN2Ds2zf39COwlRSnb+c3JA
         a4pQ==
X-Gm-Message-State: APjAAAU9yidoRhIrP/YcujR9lwAHdBfvbb83x+cFRB660qpzsxMFpJBL
        jeZuYgtt3t6cnABeIDkcZnW8XYA=
X-Google-Smtp-Source: APXvYqyfL3WMPuMU62jzHHia9uleekwukeoPmqPsS0qyG/NclIpzWze0qehbhz2/MAkbqSYILQnlVWg=
X-Received: by 2002:a65:4242:: with SMTP id d2mr927290pgq.166.1575316905445;
 Mon, 02 Dec 2019 12:01:45 -0800 (PST)
Date:   Mon,  2 Dec 2019 12:01:43 -0800
Message-Id: <20191202200143.250793-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH bpf] selftests/bpf: don't hard-code root cgroup id
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 40430452fd5d ("kernfs: use 64bit inos if ino_t is 64bit") changed
the way cgroup ids are exposed to the userspace. Instead of assuming
fixed root id, let's query it.

Fixes: 40430452fd5d ("kernfs: use 64bit inos if ino_t is 64bit")
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_skb_cgroup_id_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_skb_cgroup_id_user.c b/tools/testing/selftests/bpf/test_skb_cgroup_id_user.c
index 9220747c069d..356351c0ac28 100644
--- a/tools/testing/selftests/bpf/test_skb_cgroup_id_user.c
+++ b/tools/testing/selftests/bpf/test_skb_cgroup_id_user.c
@@ -120,7 +120,7 @@ int check_ancestor_cgroup_ids(int prog_id)
 	int err = 0;
 	int map_fd;
 
-	expected_ids[0] = 0x100000001;	/* root cgroup */
+	expected_ids[0] = get_cgroup_id("/..");	/* root cgroup */
 	expected_ids[1] = get_cgroup_id("");
 	expected_ids[2] = get_cgroup_id(CGROUP_PATH);
 	expected_ids[3] = 0; /* non-existent cgroup */
-- 
2.24.0.393.g34dc348eaf-goog

