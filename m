Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0BD6F3875
	for <lists+bpf@lfdr.de>; Mon,  1 May 2023 21:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjEATsb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 May 2023 15:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjEATsa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 15:48:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90C01FCE
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 12:48:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a6eeea78cso28818342276.0
        for <bpf@vger.kernel.org>; Mon, 01 May 2023 12:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682970508; x=1685562508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A7d8BZCLJAQcgyhTBz+Dgb0+EC6ehU2qiKsRrRK7gcs=;
        b=eLywRKiAp4TzYV1w1dXzUou/IuAsuH8wBxpNypjoZqJlDRCbppTySxyUI+m6g0CwnX
         QVbhlNX/mDqu2492pap8jvWZep8pwvD3in+Kf01xLr/rKSyrTXujm/mrNiZMDJ1pxA34
         49kBpeG44E0RJfnnRo0Z6QGwlXbPWswYdkuOOCTIsZpvAT1kPfJrK5p01n0Xsp7SGvrh
         7yk3I0Pmn7zfez58HjhSK5EAX24vVg0j0pgZISMqeDp4pgnk9Adl3dvqYMHJDvcoCIsl
         aBXncStEevfnZ0vqhodplyAtxphId0rK0pFcTfWCrzzOPBbXb83/orZeP29Tz9mH+a6G
         lBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682970508; x=1685562508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7d8BZCLJAQcgyhTBz+Dgb0+EC6ehU2qiKsRrRK7gcs=;
        b=BGNfW6U6zgc1hSCRE2ANbx8AaEk5VxIVcYu3dGYy2fGmyj1FRLhoFwvH3z+37DMMEh
         FdOOUds7SX9Ea35T2OPtINsmiyf/RO25QsghwJThhmgOWAhFiO1e0NRq2/O8kvLa2/xQ
         Cyu2J0FuDysyhI1wcyvm51o3PKNA6SdqZkwCwU2k/1A0mc/0nbEERUUoMdtGA6x3zcH6
         2IEis/gjm/W0UquXlM+JiYhnDEOHn2WzKVra2dlGPS+sj9BAo7hOCsEWUkcs/viGwXo+
         MiLRLHxZy3aNuA5JfiRbgG2/XrlUc1hjYqgQDnhmMOxVveJ0ESkHiCfQ3s8tWgnxymbp
         d0vw==
X-Gm-Message-State: AC+VfDzxKtVGuJbc4T0K9TLUIBnayzl+GQtKUQ4zyUXrpYPtsmXtCMfU
        rVvZqVNsnMR+9u1aqwwbSUI9vtsFdYfEILbHC6x5/uo9/v93LVgts+RXhfTNxcw4e9wPSgIchlQ
        hBClqfxtRS/s8bUeG0+Kcn0FFJgR8rLkUz0UHWPeRKK39mOc1hA==
X-Google-Smtp-Source: ACHHUZ5emvL2K4aG/4yppqbYKd+bZXemK3BGSj96miPw2G8eex3NWSaAS3mGZgGpBMnqaT8G2cKG0C8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:c0d0:0:b0:b9a:672d:23c9 with SMTP id
 c199-20020a25c0d0000000b00b9a672d23c9mr8981347ybf.0.1682970508598; Mon, 01
 May 2023 12:48:28 -0700 (PDT)
Date:   Mon,  1 May 2023 12:48:22 -0700
In-Reply-To: <20230501194825.2864150-1-sdf@google.com>
Mime-Version: 1.0
References: <20230501194825.2864150-1-sdf@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501194825.2864150-2-sdf@google.com>
Subject: [PATCH bpf-next v3 1/4] bpf: Don't EFAULT for {g,s}setsockopt with
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

v3:
- don't hard-code PAGE_SIZE (Martin)
- reset orig_optlen in getsockopt when kernel part succeeds (Martin)

Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/cgroup.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index a06e118a9be5..88aeb0716a21 100644
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
@@ -1905,6 +1912,7 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 			ret = -EFAULT;
 			goto out;
 		}
+		orig_optlen = ctx.optlen;
 
 		if (copy_from_user(ctx.optval, optval,
 				   min(ctx.optlen, max_optlen)) != 0) {
@@ -1922,6 +1930,11 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
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

