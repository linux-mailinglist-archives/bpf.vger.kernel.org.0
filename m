Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AEC6F720E
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 20:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjEDSnz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 14:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjEDSny (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 14:43:54 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10DF3C33
        for <bpf@vger.kernel.org>; Thu,  4 May 2023 11:43:53 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-517baf1bc93so623585a12.0
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 11:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683225833; x=1685817833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U9qI0nq5QzBcYkUt0DhCTgiaghbG11tcfglp9KLW4s0=;
        b=Avnr/92oBi/fjD7P9Vhoit1KfXkjjwf2jz/7slHrwhJvSOHMUF60Zw7CBckU7oTg0A
         8NrsQb3zN4lbWK0HK66h/Tx49ajkUGINBlI2EgXLE18GrF+wa3IEJjNxBY2tffVnguhV
         orYYjBUn3Q7n/7yqF5CnHqx2HRNWodGyfpMbYKluJPKEHGDYUUwRvTPuzA4JeuWWnq9g
         V/qbYMCm5GUQlrvb6EaEGlU/xfj2dGsYD/4im7mcj63HEO8zo2Z4PRl7f+Y4Bg9a1XOA
         uJ3n0NsGwqv4T8GrbuKTMPmvR7+gdLfxmuh47ms1KFVNdMx+rSHD4pZl1XvNudqRSewM
         Y3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683225833; x=1685817833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9qI0nq5QzBcYkUt0DhCTgiaghbG11tcfglp9KLW4s0=;
        b=CbhUpVjNdonS5SSICmNVy4x0YxhMGDYblU1Ho6uDfDv8tSv6qYn3WNtKgND/YyoGu2
         +1yCwUFqAopUic2axM3DLT/7aUVJxhB4pHBvm38iDRmULyGvd7fpNXAtBzYRPKTG8sSA
         9lmmllD2/PHTyutOjiUGqmEr0xjmT2q3t+5ltUazev3MwoipDUP+UEgMNsNrQ/YpO4hc
         EvTl/BYahJIxjSqB8YSzMLgiwbo6+gl4Q3myO5y6gQ8BPkriLg/Nk94dsvzXvknKal8F
         b6F3PzNGLR+nVxmfw+9K+DxKPSZH2h/4ZMM1TqRQFPRSn02KsZ71tKoLGxX03xgS0Ea0
         oVHw==
X-Gm-Message-State: AC+VfDwJCQyICpI++QIuWYO67pDeIMTC8E490gPNEWnakMLcog6XJKKL
        9V7wCz+IjnHMTn5uq0Z+czGGTkFVoYePGmFGN23dXhldenr38tpOaNdntk9cr0k6l1pxyF4pOHV
        wOPX1vT0mNNMto/eLdvhJMaze0cD4JSHlIWELcjRv5Ayb+ILgvA==
X-Google-Smtp-Source: ACHHUZ62dNWyBPVSSXM986BIZkpw9Mz/b3CPh+YWBx2pGNkH57BqtPyK+07MQ2C4YplFM0rPBzx+CH4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:2bd2:0:b0:52c:63a3:9f23 with SMTP id
 r201-20020a632bd2000000b0052c63a39f23mr242318pgr.0.1683225833340; Thu, 04 May
 2023 11:43:53 -0700 (PDT)
Date:   Thu,  4 May 2023 11:43:46 -0700
In-Reply-To: <20230504184349.3632259-1-sdf@google.com>
Mime-Version: 1.0
References: <20230504184349.3632259-1-sdf@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230504184349.3632259-2-sdf@google.com>
Subject: [PATCH bpf-next v4 1/4] bpf: Don't EFAULT for {g,s}setsockopt with
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
 kernel/bpf/cgroup.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index a06e118a9be5..14c870595428 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1826,6 +1826,12 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 		ret = 1;
 	} else if (ctx.optlen > max_optlen || ctx.optlen < -1) {
 		/* optlen is out of bounds */
+		if (*optlen > PAGE_SIZE && ctx.optlen >= 0) {
+			pr_info_once("bpf setsockopt: ignoring program buffer with optlen=%d (max_optlen=%d)\n",
+				     ctx.optlen, max_optlen);
+			ret = 0;
+			goto out;
+		}
 		ret = -EFAULT;
 	} else {
 		/* optlen within bounds, run kernel handler */
@@ -1881,8 +1887,10 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 		.optname = optname,
 		.current_task = current,
 	};
+	int orig_optlen;
 	int ret;
 
+	orig_optlen = max_optlen;
 	ctx.optlen = max_optlen;
 	max_optlen = sockopt_alloc_buf(&ctx, max_optlen, &buf);
 	if (max_optlen < 0)
@@ -1905,6 +1913,7 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 			ret = -EFAULT;
 			goto out;
 		}
+		orig_optlen = ctx.optlen;
 
 		if (copy_from_user(ctx.optval, optval,
 				   min(ctx.optlen, max_optlen)) != 0) {
@@ -1922,6 +1931,12 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 		goto out;
 
 	if (optval && (ctx.optlen > max_optlen || ctx.optlen < 0)) {
+		if (orig_optlen > PAGE_SIZE && ctx.optlen >= 0) {
+			pr_info_once("bpf getsockopt: ignoring program buffer with optlen=%d (max_optlen=%d)\n",
+				     ctx.optlen, max_optlen);
+			ret = retval;
+			goto out;
+		}
 		ret = -EFAULT;
 		goto out;
 	}
-- 
2.40.1.521.gf1e218fcd8-goog

