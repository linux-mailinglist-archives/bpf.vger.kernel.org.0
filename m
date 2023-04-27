Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545736F0CCF
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 22:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344052AbjD0UER (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 16:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0UEQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 16:04:16 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA773595
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 13:04:13 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-51bb4164162so8004243a12.2
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 13:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682625853; x=1685217853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=heydORlx8T15rvgU8Yk1jGEI7xIKLNNxTYW35qTk5Hs=;
        b=0KEHb6TFvgmeSplF5jADOJq2NyjcXuTIoKrUVJYObqFiriO8r0GACbnxKNB97xFqSz
         0VdRFiapKbQjLNLaKp59yaMfM7vwCBJbN7c4EyKtgqcP++oYL1+uxvTojzkXWkMNVa5O
         I3zCIsjAeSjyFyUDMc02hqdKD1NgRcvP8UHXBROTRThoXNua1DutzGpnZb+l9ye8r3j1
         Fbyz7SL2FmQizweQ+2t1uLNS/pWBcfJSHhQFUa6Zkfzz5KG/i8ivqxYEwLGyw60zvSR+
         ymzNuZ8/vq0RLueSrqjJOU+hwP3bqbglvL0Q/vt/rdYXlgOwUPHz4/D/cR71StUStFvP
         AfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682625853; x=1685217853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=heydORlx8T15rvgU8Yk1jGEI7xIKLNNxTYW35qTk5Hs=;
        b=Xy/T+nMfRiUg4Pqo0egiTO6H06MozXk3ZCGoJ9Ec245fjOgx9wV2yxEUTO+qPTqIyo
         +Uc6dAwRhw2Ln88kOb/SQzRXjEvaxBMMaBYBV/ydw6q2wuZQElE0aBWr235A+3TX9Uoy
         nVHHwMSYNHI0B7wlZ0T654Q1DH2zE98koDc9YI00vZmBf+7qNZt440YmD5Qn/RaSG471
         m7xNGPwO7Pbx3XeZc7m8qXyLsQZxjOg87y/ZMi0UYn+PtgXXdOSv2jvKi/agvxXuLawT
         EtOX4erlHbaTYL1KeEg0UnpCzNBanKnm8ve8Anrxrg+AicPbGRazBkPv0Gs0wgPc5zdq
         Qthg==
X-Gm-Message-State: AC+VfDwE8oQbJz06EjaofDzcxk+euBNzhoS8nK9aXkZ9/+ux0IDJEzAR
        9/MmsP95ayYrvQc/Vc8l4GTekBAHY5/Vn0rOUtTbeSq1B0bMORMh9HRjZd+lkqKzB0qy+VwbfUP
        VmT4nxxY5dS2fJlFuJyV48r0SiFtVDyXypnxwj0WVtV7VTSNLug==
X-Google-Smtp-Source: ACHHUZ6d0ZpkSGLWxs0F7EpCAUY0VqArK9d7/aRKUwUACgqpazrdkPvyHlDhsVu6V/syVU5tnTJiWbI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:6bc9:0:b0:524:bc58:5e5c with SMTP id
 g192-20020a636bc9000000b00524bc585e5cmr659177pgc.8.1682625852851; Thu, 27 Apr
 2023 13:04:12 -0700 (PDT)
Date:   Thu, 27 Apr 2023 13:04:06 -0700
In-Reply-To: <20230427200409.1785263-1-sdf@google.com>
Mime-Version: 1.0
References: <20230427200409.1785263-1-sdf@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230427200409.1785263-2-sdf@google.com>
Subject: [PATCH bpf-next v2 1/4] bpf: Don't EFAULT for {g,s}setsockopt with
 wrong optlen
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With the way the hooks implemented right now, we have a special
condition: optval larger than PAGE_SIZE will expose only first 4k into
BPF; any modifications to the optval are ignored. If the BPF program
doesn't handle this condition by resetting optlen to 0,
the userspace will get EFAULT.

The intention of the EFAULT was to make it apparent to the
developers that the program is doing something wrong.
However, this inadvertently might affect production workloads
with the BPF programs that are not too careful (i.e., returning EFAULT
for perfectly valid setsockopt/getsockopt calls).

Let's try to minimize the chance of BPF program screwing up userspace
by ignoring the output of those BPF programs (instead of returning
EFAULT to the userspace). pr_info_once those cases to
the dmesg to help with figuring out what's going wrong.

Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/cgroup.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index a06e118a9be5..e041159a1ce0 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1826,6 +1826,11 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 		ret = 1;
 	} else if (ctx.optlen > max_optlen || ctx.optlen < -1) {
 		/* optlen is out of bounds */
+		if (*optlen > PAGE_SIZE && ctx.optlen >= 0) {
+			pr_info_once("bpf setsockopt: ignoring program buffer with optlen=%d (max_optlen=%d)\n",
+				     ctx.optlen, max_optlen);
+			goto out;
+		}
 		ret = -EFAULT;
 	} else {
 		/* optlen within bounds, run kernel handler */
@@ -1881,8 +1886,10 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 		.optname = optname,
 		.current_task = current,
 	};
+	int orig_optlen;
 	int ret;
 
+	orig_optlen = max_optlen;
 	ctx.optlen = max_optlen;
 	max_optlen = sockopt_alloc_buf(&ctx, max_optlen, &buf);
 	if (max_optlen < 0)
@@ -1922,6 +1929,11 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 		goto out;
 
 	if (optval && (ctx.optlen > max_optlen || ctx.optlen < 0)) {
+		if (orig_optlen > PAGE_SIZE && ctx.optlen >= 0) {
+			pr_info_once("bpf getsockopt: ignoring program buffer with optlen=%d (max_optlen=%d)\n",
+				     ctx.optlen, max_optlen);
+			goto out;
+		}
 		ret = -EFAULT;
 		goto out;
 	}
-- 
2.40.1.495.gc816e09b53d-goog

