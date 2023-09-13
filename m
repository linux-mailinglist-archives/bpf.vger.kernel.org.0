Return-Path: <bpf+bounces-9963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC45679F3FA
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 23:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881C5280EDF
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 21:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ACB22F09;
	Wed, 13 Sep 2023 21:46:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D238B667
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 21:46:12 +0000 (UTC)
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FF4199F;
	Wed, 13 Sep 2023 14:46:11 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,144,1688428800"; 
   d="scan'208";a="238514835"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 21:46:08 +0000
Received: from EX19MTAUEC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com (Postfix) with ESMTPS id 6D00360DE4;
	Wed, 13 Sep 2023 21:46:07 +0000 (UTC)
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 13 Sep 2023 21:45:54 +0000
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (10.15.97.110) by
 mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Wed, 13 Sep 2023 21:45:54 +0000
Received: by dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (Postfix, from userid 22993570)
	id 9CB32207F8; Wed, 13 Sep 2023 21:45:54 +0000 (UTC)
From: Puranjay Mohan <puranjay12@gmail.com>
To: <puranjaymohan@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim
	<zlim.lnx@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
	<will@kernel.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH bpf-next 0/1] bpf, arm64: support exceptions
Date: Wed, 13 Sep 2023 21:45:54 +0000
Message-ID: <20230913214554.97356-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Kumar is working on adding exceptions to BPF and enabling it on x86 [1].
I am working with him to enable it on ARM64 and will later do it for
other architectures when the basic exceptions support is upstream.

This patch enables the support on ARM64, all sefltests are passing:

# ./test_progs -a exceptions
#74/1    exceptions/exception_throw_always_1:OK
#74/2    exceptions/exception_throw_always_2:OK
#74/3    exceptions/exception_throw_unwind_1:OK
#74/4    exceptions/exception_throw_unwind_2:OK
#74/5    exceptions/exception_throw_default:OK
#74/6    exceptions/exception_throw_default_value:OK
#74/7    exceptions/exception_tail_call:OK
#74/8    exceptions/exception_ext:OK
#74/9    exceptions/exception_ext_mod_cb_runtime:OK
#74/10   exceptions/exception_throw_subprog:OK
#74/11   exceptions/exception_assert_nz_gfunc:OK
#74/12   exceptions/exception_assert_zero_gfunc:OK
#74/13   exceptions/exception_assert_neg_gfunc:OK
#74/14   exceptions/exception_assert_pos_gfunc:OK
#74/15   exceptions/exception_assert_negeq_gfunc:OK
#74/16   exceptions/exception_assert_poseq_gfunc:OK
#74/17   exceptions/exception_assert_nz_gfunc_with:OK
#74/18   exceptions/exception_assert_zero_gfunc_with:OK
#74/19   exceptions/exception_assert_neg_gfunc_with:OK
#74/20   exceptions/exception_assert_pos_gfunc_with:OK
#74/21   exceptions/exception_assert_negeq_gfunc_with:OK
#74/22   exceptions/exception_assert_poseq_gfunc_with:OK
#74/23   exceptions/exception_bad_assert_nz_gfunc:OK
#74/24   exceptions/exception_bad_assert_zero_gfunc:OK
#74/25   exceptions/exception_bad_assert_neg_gfunc:OK
#74/26   exceptions/exception_bad_assert_pos_gfunc:OK
#74/27   exceptions/exception_bad_assert_negeq_gfunc:OK
#74/28   exceptions/exception_bad_assert_poseq_gfunc:OK
#74/29   exceptions/exception_bad_assert_nz_gfunc_with:OK
#74/30   exceptions/exception_bad_assert_zero_gfunc_with:OK
#74/31   exceptions/exception_bad_assert_neg_gfunc_with:OK
#74/32   exceptions/exception_bad_assert_pos_gfunc_with:OK
#74/33   exceptions/exception_bad_assert_negeq_gfunc_with:OK
#74/34   exceptions/exception_bad_assert_poseq_gfunc_with:OK
#74/35   exceptions/exception_assert_range:OK
#74/36   exceptions/exception_assert_range_with:OK
#74/37   exceptions/exception_bad_assert_range:OK
#74/38   exceptions/exception_bad_assert_range_with:OK
#74/39   exceptions/non-throwing fentry -> exception_cb:OK
#74/40   exceptions/throwing fentry -> exception_cb:OK
#74/41   exceptions/non-throwing fexit -> exception_cb:OK
#74/42   exceptions/throwing fexit -> exception_cb:OK
#74/43   exceptions/throwing extension (with custom cb) -> exception_cb:OK
#74/44   exceptions/throwing extension -> global func in exception_cb:OK
#74/45   exceptions/exception_ext_mod_cb_runtime:OK
#74/46   exceptions/throwing extension (with custom cb) -> global func in exception_cb:OK
#74/47   exceptions/exception_ext:OK
#74/48   exceptions/non-throwing fentry -> non-throwing subprog:OK
#74/49   exceptions/throwing fentry -> non-throwing subprog:OK
#74/50   exceptions/non-throwing fentry -> throwing subprog:OK
#74/51   exceptions/throwing fentry -> throwing subprog:OK
#74/52   exceptions/non-throwing fexit -> non-throwing subprog:OK
#74/53   exceptions/throwing fexit -> non-throwing subprog:OK
#74/54   exceptions/non-throwing fexit -> throwing subprog:OK
#74/55   exceptions/throwing fexit -> throwing subprog:OK
#74/56   exceptions/non-throwing fmod_ret -> non-throwing subprog:OK
#74/57   exceptions/non-throwing fmod_ret -> non-throwing global subprog:OK
#74/58   exceptions/non-throwing extension -> non-throwing subprog:OK
#74/59   exceptions/non-throwing extension -> throwing subprog:OK
#74/60   exceptions/non-throwing extension -> non-throwing subprog:OK
#74/61   exceptions/non-throwing extension -> throwing global subprog:OK
#74/62   exceptions/throwing extension -> throwing global subprog:OK
#74/63   exceptions/throwing extension -> non-throwing global subprog:OK
#74/64   exceptions/non-throwing extension -> main subprog:OK
#74/65   exceptions/throwing extension -> main subprog:OK
#74/66   exceptions/reject_exception_cb_type_1:OK
#74/67   exceptions/reject_exception_cb_type_2:OK
#74/68   exceptions/reject_exception_cb_type_3:OK
#74/69   exceptions/reject_exception_cb_type_4:OK
#74/70   exceptions/reject_async_callback_throw:OK
#74/71   exceptions/reject_with_lock:OK
#74/72   exceptions/reject_subprog_with_lock:OK
#74/73   exceptions/reject_with_rcu_read_lock:OK
#74/74   exceptions/reject_subprog_with_rcu_read_lock:OK
#74/75   exceptions/reject_with_rbtree_add_throw:OK
#74/76   exceptions/reject_with_reference:OK
#74/77   exceptions/reject_with_cb_reference:OK
#74/78   exceptions/reject_with_cb:OK
#74/79   exceptions/reject_with_subprog_reference:OK
#74/80   exceptions/reject_throwing_exception_cb:OK
#74/81   exceptions/reject_exception_cb_call_global_func:OK
#74/82   exceptions/reject_exception_cb_call_static_func:OK
#74/83   exceptions/reject_multiple_exception_cb:OK
#74/84   exceptions/reject_exception_throw_cb:OK
#74/85   exceptions/reject_exception_throw_cb_diff:OK
#74/86   exceptions/reject_set_exception_cb_bad_ret1:OK
#74/87   exceptions/reject_set_exception_cb_bad_ret2:OK
#74/88   exceptions/check_assert_eq_int_min:OK
#74/89   exceptions/check_assert_eq_int_max:OK
#74/90   exceptions/check_assert_eq_zero:OK
#74/91   exceptions/check_assert_eq_llong_min:OK
#74/92   exceptions/check_assert_eq_llong_max:OK
#74/93   exceptions/check_assert_lt_pos:OK
#74/94   exceptions/check_assert_lt_zero:OK
#74/95   exceptions/check_assert_lt_neg:OK
#74/96   exceptions/check_assert_le_pos:OK
#74/97   exceptions/check_assert_le_zero:OK
#74/98   exceptions/check_assert_le_neg:OK
#74/99   exceptions/check_assert_gt_pos:OK
#74/100  exceptions/check_assert_gt_zero:OK
#74/101  exceptions/check_assert_gt_neg:OK
#74/102  exceptions/check_assert_ge_pos:OK
#74/103  exceptions/check_assert_ge_zero:OK
#74/104  exceptions/check_assert_ge_neg:OK
#74/105  exceptions/check_assert_range_s64:OK
#74/106  exceptions/check_assert_range_u64:OK
#74/107  exceptions/check_assert_single_range_s64:OK
#74/108  exceptions/check_assert_single_range_u64:OK
#74/109  exceptions/check_assert_generic:OK
#74/110  exceptions/check_assert_with_return:OK
#74      exceptions:OK
Summary: 1/110 PASSED, 0 SKIPPED, 0 FAILED

[1] https://lore.kernel.org/bpf/20230912233214.1518551-1-memxor@gmail.com/

Puranjay Mohan (1):
  bpf, arm64: support exceptions

 arch/arm64/net/bpf_jit_comp.c | 98 ++++++++++++++++++++++++++++-------
 1 file changed, 79 insertions(+), 19 deletions(-)

-- 
2.40.1


