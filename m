Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0596C9361
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 11:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjCZJWU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 05:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCZJWT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 05:22:19 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D464540EE;
        Sun, 26 Mar 2023 02:22:18 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id qh28so4870902qvb.7;
        Sun, 26 Mar 2023 02:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679822538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwHHUn2KJ1qVHrX1VAd8snE/lpVIPkRNAfXb0ctK8EA=;
        b=VmnNzVvbOE2xFNfHTtV8ssb2ax9uq2cUpvbAsBKyuOhvL/pKhQHH5D1N1paKdpk2pZ
         OrYkUh/mTYLLSE/Xc5KjyO1ELmj2oWzNAaiZCEJv3U6CYvBEwJ3iMsy20Z8r4pT/Hd8B
         57KvlQz2ZAgauzaPME5YjeGKXdwLsAyK6i+rPGxCfOGdfuPqAfPQ4xootiof17ZxCdDE
         JVq+cfd0qguE9m5enVYLoD2qHmmeS081/qldllbut0vVaOsjHuKBvafUAL+zVdvoEpOY
         k55CWTKkJZ+BxKWDCZVTDVX8LwvomU+0kHNxuCrtbj5j36Np1AUgHHyUQxMeRpBxmykK
         efzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679822538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwHHUn2KJ1qVHrX1VAd8snE/lpVIPkRNAfXb0ctK8EA=;
        b=kxhx5/QutIxIiaCHeB6iif09i7bicAhwIVnQSU6dufEMkV9Y0dlnIjrWYiGkmi7tS6
         oIyhXRmoKhkrMqhCS9GHNBv2n0TNJqv7Aza0n+nqmcwxDimSeldoR9vUmntVF98HF6BL
         QCF2VEWL2J3WoIXw0/1ELOocmtPvm/dMmY97B01/MfzsJFbnQLIqmKu/dcq3Kv38QxTD
         fZbsK6D1CrrGI96xieMLULqPsjUzBpLh0eazlUgBbAdkjLLURjvIGRrqNHQ0OS5uRq4O
         R52n1LMY0wbg05QtRBVWTl58YpWwi0JQbaC6gzOSsLeIkUk9HERvBF2jckdaNxErhpSx
         Peqw==
X-Gm-Message-State: AAQBX9dJ0/8u59H0OYEwL3zAcNkVw1LV9FmCCJcMtFaLFyv2Zu2d5KF7
        N+50vV/3NNjfnuVSJ5e64Ek=
X-Google-Smtp-Source: AKy350bM+eTpjT6YC/4vhOCRdBwtCCa0Ktv98B2UHSYV2R+F2nF83kYyHhD6zO1xGb9E6pY3wmDMZA==
X-Received: by 2002:a05:6214:1c45:b0:5bd:14f9:650f with SMTP id if5-20020a0562141c4500b005bd14f9650fmr14305482qvb.45.1679822537938;
        Sun, 26 Mar 2023 02:22:17 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:1a1f:5400:4ff:fe5e:1d32])
        by smtp.gmail.com with ESMTPSA id y5-20020ac87085000000b003e014845d9esm10257987qto.74.2023.03.26.02.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 02:22:17 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 01/13] fork: New clone3 flag for BPF namespace
Date:   Sun, 26 Mar 2023 09:21:56 +0000
Message-Id: <20230326092208.13613-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230326092208.13613-1-laoar.shao@gmail.com>
References: <20230326092208.13613-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A new clone3 flag CLONE_NEWBPF is introduced to create a new BPF
namespace.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/uapi/linux/sched.h | 1 +
 kernel/fork.c              | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8..ace31df 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -36,6 +36,7 @@
 /* Flags for the clone3() syscall. */
 #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
 #define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
+#define CLONE_NEWBPF		0x400000000ULL /* New BPF namespace */
 
 /*
  * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
diff --git a/kernel/fork.c b/kernel/fork.c
index f68954d..db0abd4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2929,7 +2929,8 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
 {
 	/* Verify that no unknown flags are passed along. */
 	if (kargs->flags &
-	    ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP))
+	    ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP |
+		  CLONE_NEWBPF))
 		return false;
 
 	/*
@@ -3080,7 +3081,7 @@ static int check_unshare_flags(unsigned long unshare_flags)
 				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM|
 				CLONE_NEWUTS|CLONE_NEWIPC|CLONE_NEWNET|
 				CLONE_NEWUSER|CLONE_NEWPID|CLONE_NEWCGROUP|
-				CLONE_NEWTIME))
+				CLONE_NEWTIME|CLONE_NEWBPF))
 		return -EINVAL;
 	/*
 	 * Not implemented, but pretend it works if there is nothing
-- 
1.8.3.1

