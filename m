Return-Path: <bpf+bounces-7904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CF277E4A6
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 17:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26371C210B7
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 15:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4066B156CD;
	Wed, 16 Aug 2023 15:06:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1347C101DA
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 15:06:42 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77ED1B2;
	Wed, 16 Aug 2023 08:06:40 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-76c8dd2ce79so576805185a.1;
        Wed, 16 Aug 2023 08:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692198399; x=1692803199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jqc6aMsBDwBmUNU3rpDBpCQQ7XOglMYzfoxP1qWU7c=;
        b=g9P8esmroviBMY7U2EiZWy+SJRbgn6qgYpZ7U/shkKjiYgGJklPLg38V29wddiTROz
         7Lkshoh0vk5841+mVhL7NGDV3q8/yq79mZX5kWqBQ6dVpxW8+fC3bRpB0X5OTLCYN+Ch
         95+VzDb+gZW8c5OfT9CODZw2avlub+oNLva6hVhv9Gkg9QTouBtmFBees/SGCCi7XRNA
         wmvuwICAKF5xuUGbhTed0gv7PimV/ZpfqWDw0uh/ugBUQPKaYN7GpQRPrp5yno9JTYBi
         FrwuVJdKEQdEJbjbaKnq0yygJ59MMO4V432bhWr9syoi5IIUgtBlLylIL1bNPD0JQ0vD
         ezqw==
X-Gm-Message-State: AOJu0YzhmCYH302vsTx+sfMaj9mLWZRrtGqMMdAoHNBRS2Ij5b6lSvFW
	mBL36UDbvlEpin4Svyo1Ckx8+gkhFjpF+FgA
X-Google-Smtp-Source: AGHT+IHMXDbnFK1oON4WwW5wW59PgJKtV3UWTSir6qLDhl6lh3I1+7fSHlKwjfPioVNCeg+4aK6p5w==
X-Received: by 2002:a37:e115:0:b0:76d:3558:6e8d with SMTP id c21-20020a37e115000000b0076d35586e8dmr2344824qkm.69.1692198399612;
        Wed, 16 Aug 2023 08:06:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:6eb])
        by smtp.gmail.com with ESMTPSA id k19-20020ac84793000000b004055c555d2dsm4530388qtq.21.2023.08.16.08.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:06:39 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next] bpf: Disable -Wmissing-declarations for globally-linked kfuncs
Date: Wed, 16 Aug 2023 10:06:34 -0500
Message-ID: <20230816150634.1162838-1-void@manifault.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We recently got an lkp warning about missing declarations, as in e.g.
[0]. This warning is largely redundant with -Wmissing-prototypes, which
we already disable for kfuncs that have global linkage and are meant to
be exported in BTF, and called from BPF programs. Let's also disable
-Wmissing-declarations for kfuncs. For what it's worth, I wasn't able to
reproduce the warning even on W <= 3, so I can't actually be 100% sure
this fixes the issue.

[0]: https://lore.kernel.org/all/202308162115.Hn23vv3n-lkp@intel.com/

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308162115.Hn23vv3n-lkp@intel.com/
Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/kfuncs.rst                          | 4 +++-
 kernel/bpf/bpf_iter.c                                 | 2 ++
 kernel/bpf/cpumask.c                                  | 2 ++
 kernel/bpf/helpers.c                                  | 2 ++
 kernel/bpf/map_iter.c                                 | 2 ++
 kernel/cgroup/rstat.c                                 | 2 ++
 kernel/trace/bpf_trace.c                              | 2 ++
 net/bpf/test_run.c                                    | 2 ++
 net/core/filter.c                                     | 4 ++++
 net/core/xdp.c                                        | 2 ++
 net/ipv4/fou_bpf.c                                    | 2 ++
 net/netfilter/nf_conntrack_bpf.c                      | 2 ++
 net/netfilter/nf_nat_bpf.c                            | 2 ++
 net/xfrm/xfrm_interface_bpf.c                         | 2 ++
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 2 ++
 15 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 0d2647fb358d..62ce5a7b92b4 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -36,10 +36,12 @@ prototype in a header for the wrapper kfunc.
 
 An example is given below::
 
-        /* Disables missing prototype warnings */
+        /* Disables missing prototypes and declarations warnings */
         __diag_push();
         __diag_ignore_all("-Wmissing-prototypes",
                           "Global kfuncs as their definitions will be in BTF");
+        __diag_ignore_all("-Wmissing-declarations",
+                          "Global kfuncs as their definitions will be in BTF");
 
         __bpf_kfunc struct task_struct *bpf_find_get_task_by_vpid(pid_t nr)
         {
diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 96856f130cbf..b8def6e4e5e8 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -785,6 +785,8 @@ struct bpf_iter_num_kern {
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
+__diag_ignore_all("-Wmissing-declarations",
+		  "Global functions as their definitions will be in vmlinux BTF");
 
 __bpf_kfunc int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end)
 {
diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 6983af8e093c..111b0e062e7f 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -37,6 +37,8 @@ static bool cpu_valid(u32 cpu)
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global kfuncs as their definitions will be in BTF");
+__diag_ignore_all("-Wmissing-declarations",
+		  "Global kfuncs as their definitions will be in BTF");
 
 /**
  * bpf_cpumask_create() - Create a mutable BPF cpumask.
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index eb91cae0612a..6d2f84371892 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1885,6 +1885,8 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
+__diag_ignore_all("-Wmissing-declarations",
+		  "Global functions as their definitions will be in vmlinux BTF");
 
 __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
 {
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index 6fc9dae9edc8..f7c7c5044630 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -196,6 +196,8 @@ late_initcall(bpf_map_iter_init);
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
+__diag_ignore_all("-Wmissing-declarations",
+		  "Global functions as their definitions will be in vmlinux BTF");
 
 __bpf_kfunc s64 bpf_map_sum_elem_count(const struct bpf_map *map)
 {
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 2542c21b6b6d..f5231a58ad3c 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -162,6 +162,8 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "kfuncs which will be used in BPF programs");
+__diag_ignore_all("-Wmissing-declarations",
+		  "kfuncs which will be used in BPF programs");
 
 __weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
 				     struct cgroup *parent, int cpu)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 792445e1f3f0..1fa197aa428c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1224,6 +1224,8 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "kfuncs which will be used in BPF programs");
+__diag_ignore_all("-Wmissing-declarations",
+		  "kfuncs which will be used in BPF programs");
 
 /**
  * bpf_lookup_user_key - lookup a key by its serial
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 57a7a64b84ed..38aedb720a52 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -506,6 +506,8 @@ static int bpf_test_finish(const union bpf_attr *kattr,
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
+__diag_ignore_all("-Wmissing-declarations",
+		  "Global functions as their definitions will be in vmlinux BTF");
 __bpf_kfunc int bpf_fentry_test1(int a)
 {
 	return a + 1;
diff --git a/net/core/filter.c b/net/core/filter.c
index a094694899c9..c2b32b94c6bd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11727,6 +11727,8 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id)
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
+__diag_ignore_all("-Wmissing-declarations",
+		  "Global functions as their definitions will be in vmlinux BTF");
 __bpf_kfunc int bpf_dynptr_from_skb(struct sk_buff *skb, u64 flags,
 				    struct bpf_dynptr_kern *ptr__uninit)
 {
@@ -11808,6 +11810,8 @@ late_initcall(bpf_kfunc_init);
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
+__diag_ignore_all("-Wmissing-declarations",
+		  "Global functions as their definitions will be in vmlinux BTF");
 
 /* bpf_sock_destroy: Destroy the given socket with ECONNABORTED error code.
  *
diff --git a/net/core/xdp.c b/net/core/xdp.c
index a70670fe9a2d..3d14e7be411d 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -699,6 +699,8 @@ struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf)
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in vmlinux BTF");
+__diag_ignore_all("-Wmissing-declarations",
+		  "Global functions as their definitions will be in vmlinux BTF");
 
 /**
  * bpf_xdp_metadata_rx_timestamp - Read XDP frame RX timestamp.
diff --git a/net/ipv4/fou_bpf.c b/net/ipv4/fou_bpf.c
index 3760a14b6b57..2b394703770a 100644
--- a/net/ipv4/fou_bpf.c
+++ b/net/ipv4/fou_bpf.c
@@ -25,6 +25,8 @@ enum bpf_fou_encap_type {
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in BTF");
+__diag_ignore_all("-Wmissing-declarations",
+		  "Global functions as their definitions will be in BTF");
 
 /* bpf_skb_set_fou_encap - Set FOU encap parameters
  *
diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index c7a6114091ae..e24e2e4b2d49 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -233,6 +233,8 @@ static int _nf_conntrack_btf_struct_access(struct bpf_verifier_log *log,
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in nf_conntrack BTF");
+__diag_ignore_all("-Wmissing-declarations",
+		  "Global functions as their definitions will be in nf_conntrack BTF");
 
 /* bpf_xdp_ct_alloc - Allocate a new CT entry
  *
diff --git a/net/netfilter/nf_nat_bpf.c b/net/netfilter/nf_nat_bpf.c
index 141ee7783223..e903a6eb732e 100644
--- a/net/netfilter/nf_nat_bpf.c
+++ b/net/netfilter/nf_nat_bpf.c
@@ -15,6 +15,8 @@
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in nf_nat BTF");
+__diag_ignore_all("-Wmissing-declarations",
+		  "Global functions as their definitions will be in nf_nat BTF");
 
 /* bpf_ct_set_nat_info - Set source or destination nat address
  *
diff --git a/net/xfrm/xfrm_interface_bpf.c b/net/xfrm/xfrm_interface_bpf.c
index d74f3fd20f2b..d40060bcc398 100644
--- a/net/xfrm/xfrm_interface_bpf.c
+++ b/net/xfrm/xfrm_interface_bpf.c
@@ -30,6 +30,8 @@ struct bpf_xfrm_info {
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in xfrm_interface BTF");
+__diag_ignore_all("-Wmissing-declarations",
+		  "Global functions as their definitions will be in xfrm_interface BTF");
 
 /* bpf_skb_get_xfrm_info - Get XFRM metadata
  *
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index cefc5dd72573..201a41cd47e5 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -42,6 +42,8 @@ struct bpf_testmod_struct_arg_4 {
 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in bpf_testmod.ko BTF");
+__diag_ignore_all("-Wmissing-declarations",
+		  "Global functions as their definitions will be in bpf_testmod.ko BTF");
 
 noinline int
 bpf_testmod_test_struct_arg_1(struct bpf_testmod_struct_arg_2 a, int b, int c) {
-- 
2.41.0


