Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59F76E6FAF
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 00:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjDRWxx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 18:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjDRWxw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 18:53:52 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CA349C6
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 15:53:51 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-51b121871ecso1367536a12.3
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 15:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681858430; x=1684450430;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kpnHjZxuddE6H3TcHpUie3NL1Iwb3twryCOTZMDA77E=;
        b=m2h3J7X4hHWS2rH6bUuI69mG0jY4t56iAviiKN9oZN9Cq6aFTYkjJ4c5nNMbpbR56B
         7hLZwRmsPHE7t6nnyYzJaJJSCkOma2LQ4gCkB+R35/2tldcogQdIi8EzqeuVYcU7KyHk
         OIpSN3Awa5Qm/c+nUrFZWzNHt+gFv8CFMBUSTl+O1MW80XPosXdZkT2kNRlpZH3UH2AO
         kf3q90PDQniRjSXSldqGmTeU3bOvn8nVjg5I3m/wnmuYOgGTK99aJWNgvZOnFyWe8dZ+
         pSKQTJu/6ZhTB7zMVU+XqkZ67EX26T3lYGwEpgHO7DRcBAbieCPU732RkK9xIhzdDnBS
         i5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681858430; x=1684450430;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kpnHjZxuddE6H3TcHpUie3NL1Iwb3twryCOTZMDA77E=;
        b=BRBpXoCxrXKXKh345zLYUwG5MHPcynSF9f4yRS+XUEpxVftGu64OGIq3+81a7E2B8S
         mEseTHIefYloYoOy8g1OkIPukAUMt3TXIGxGJdCjjzIo50XJU6rV1LbibquVMUw9bMZ7
         Fy3+9c7ybm8vNAz5YV4tXadEH6fwAGVXzDGsYdazheg1S7llJgPKofSxIY/yb1UpscFo
         ci1tUDkF+3wuwgXm45owoKfYIMzVuFyc9bfmB5mi91GH+paftceiZwF6wgglvbspT1BK
         cn6CDlys7ZTnf5jns/0/YibkkZbs3yYWiBxaykVwMOmnj7P72g2gj6dstlpUiJaZeO0Q
         9X4g==
X-Gm-Message-State: AAQBX9fR6wd6stmgrmY4XpWuv6BIezVUlZcCzb/gicyH8xd3LRTQLo1y
        En74fEWCrYh0+FyRLeejyXC0eP5jDsAkJD9wKoe0BpwaYCCDJbJ3TC4Bmeg+WdOFjnnSNpdqqWA
        LSIEh3qKOC0X+6KHDxeoElOkk0l/I7RNaicovzJNhS7o1/nfmGg==
X-Google-Smtp-Source: AKy350YrwVuGMKpOCq7f1X46khuH3WfonVSTEAP+riGAPbBpFJlNNSzUKdZToTN+NBlU3wSq/6DAs1A=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a65:6645:0:b0:513:c7d:6ed3 with SMTP id
 z5-20020a656645000000b005130c7d6ed3mr1067751pgv.4.1681858430416; Tue, 18 Apr
 2023 15:53:50 -0700 (PDT)
Date:   Tue, 18 Apr 2023 15:53:40 -0700
In-Reply-To: <20230418225343.553806-1-sdf@google.com>
Mime-Version: 1.0
References: <20230418225343.553806-1-sdf@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418225343.553806-4-sdf@google.com>
Subject: [PATCH bpf-next 3/6] bpf: Don't EFAULT for {g,s}setsockopt with wrong optlen
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

Over time, we've found out several special socket option cases which need
special treatment. And if BPF program doesn't handle them correctly, this
might EFAULT perfectly valid {g,s}setsockopt calls.

The intention of the EFAULT was to make it apparent to the
developers that the program is doing something wrong.
However, this inadvertently might affect production workloads
with the BPF programs that are not too careful.

Let's try to minimize the chance of BPF program screwing up userspace
by ignoring the output of those BPF programs (instead of returning
EFAULT to the userspace). pr_info_ratelimited those cases to
the dmesg to help with figuring out what's going wrong.

Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/cgroup.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index a06e118a9be5..af4d20864fb4 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1826,7 +1826,9 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 		ret = 1;
 	} else if (ctx.optlen > max_optlen || ctx.optlen < -1) {
 		/* optlen is out of bounds */
-		ret = -EFAULT;
+		pr_info_ratelimited(
+			"bpf setsockopt returned unexpected optlen=%d (max_optlen=%d)\n",
+			ctx.optlen, max_optlen);
 	} else {
 		/* optlen within bounds, run kernel handler */
 		ret = 0;
@@ -1922,7 +1924,9 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 		goto out;
 
 	if (optval && (ctx.optlen > max_optlen || ctx.optlen < 0)) {
-		ret = -EFAULT;
+		pr_info_ratelimited(
+			"bpf getsockopt returned unexpected optlen=%d (max_optlen=%d)\n",
+			ctx.optlen, max_optlen);
 		goto out;
 	}
 
-- 
2.40.0.634.g4ca3ef3211-goog

