Return-Path: <bpf+bounces-35081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920AD9376EB
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 12:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA621C218AC
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 10:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512F684A4C;
	Fri, 19 Jul 2024 10:55:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C8584A32;
	Fri, 19 Jul 2024 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721386559; cv=none; b=r2RA+2HXpDlkgUCH7sXVEhibczVrWnPovgvXdsTO7PhtDc0nGK2nfurPfb2zSxAAGwRGr81n0o0B4ver6DmMvcxNlySIr8Sj7RG7JA+ng1UqYLbty2EOEn2kALJCFMDcGQpmrrGTwFSvHffTX/JfdEei/A9FKRkLNgJwYTDAqq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721386559; c=relaxed/simple;
	bh=zlqLgd6GZc0VkrNvoIBa6GFAHFPcWJh7iCT2Nln+fM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wmjx1LOxvjbbCLKL3JOXyJrLOyM+Bktp5JONN/inu7GsEmATm0+36FYRzOvCaAzLl6g3oCZnjRepyPitYVffFxu/aLO7WPRyLgC0qk1bQqsTeC8qSD31hjLCmBMpg9SAhnYo0f0AymaTDplIlD4Q0XlMcMZ6MFL+GAwIiu83Bfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WQRRH2Jhqz4f3l1r;
	Fri, 19 Jul 2024 18:55:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9F1091A11E8;
	Fri, 19 Jul 2024 18:55:52 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP3 (Coremail) with SMTP id _Ch0CgD3BVE0RppmM3cvAg--.11767S6;
	Fri, 19 Jul 2024 18:55:52 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Florent Revest <revest@google.com>
Subject: [PATCH bpf-next v2 4/9] bpf: Fix compare error in function retval_range_within
Date: Fri, 19 Jul 2024 19:00:54 +0800
Message-Id: <20240719110059.797546-5-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240719110059.797546-1-xukuohai@huaweicloud.com>
References: <20240719110059.797546-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgD3BVE0RppmM3cvAg--.11767S6
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4kWF4rtw1kZw4rtw4UCFg_yoWrXw4rpr
	4rG34qyr1DtF43ua12yan5A34FyF1aqayIkrWkJ3sYyw45trWDXFW2kw4Y9ayFyrW8Gw1I
	vF4jva15Gw1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07jIPfQUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

After checking lsm hook return range in verifier, the test case
"test_progs -t test_lsm" failed, and the failure log says:

libbpf: prog 'test_int_hook': BPF program load failed: Invalid argument
libbpf: prog 'test_int_hook': -- BEGIN PROG LOAD LOG --
0: R1=ctx() R10=fp0
; int BPF_PROG(test_int_hook, struct vm_area_struct *vma, @ lsm.c:89
0: (79) r0 = *(u64 *)(r1 +24)         ; R0_w=scalar(smin=smin32=-4095,smax=smax32=0) R1=ctx()

[...]

24: (b4) w0 = -1                      ; R0_w=0xffffffff
; int BPF_PROG(test_int_hook, struct vm_area_struct *vma, @ lsm.c:89
25: (95) exit
At program exit the register R0 has smin=4294967295 smax=4294967295 should have been in [-4095, 0]

It can be seen that instruction "w0 = -1" zero extended -1 to 64-bit
register r0, setting both smin and smax values of r0 to 4294967295.
This resulted in a false reject when r0 was checked with range [-4095, 0].

Given bpf lsm does not return 64-bit values, this patch fixes it by changing
the compare between r0 and return range from 64-bit operation to 32-bit
operation for bpf lsm.

Fixes: 8fa4ecd49b81 ("bpf: enforce exact retval range on subprog/callback exit")
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fefa1d5d2faa..78104bd85274 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9964,9 +9964,13 @@ static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env)
 	return is_rbtree_lock_required_kfunc(kfunc_btf_id);
 }
 
-static bool retval_range_within(struct bpf_retval_range range, const struct bpf_reg_state *reg)
+static bool retval_range_within(struct bpf_retval_range range, const struct bpf_reg_state *reg,
+				bool return_32bit)
 {
-	return range.minval <= reg->smin_value && reg->smax_value <= range.maxval;
+	if (return_32bit)
+		return range.minval <= reg->s32_min_value && reg->s32_max_value <= range.maxval;
+	else
+		return range.minval <= reg->smin_value && reg->smax_value <= range.maxval;
 }
 
 static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
@@ -10003,8 +10007,8 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 		if (err)
 			return err;
 
-		/* enforce R0 return value range */
-		if (!retval_range_within(callee->callback_ret_range, r0)) {
+		/* enforce R0 return value range, and bpf_callback_t returns 64bit */
+		if (!retval_range_within(callee->callback_ret_range, r0, false)) {
 			verbose_invalid_scalar(env, r0, callee->callback_ret_range,
 					       "At callback return", "R0");
 			return -EINVAL;
@@ -15610,6 +15614,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	int err;
 	struct bpf_func_state *frame = env->cur_state->frame[0];
 	const bool is_subprog = frame->subprogno;
+	bool return_32bit = false;
 
 	/* LSM and struct_ops func-ptr's return type could be "void" */
 	if (!is_subprog || frame->in_exception_callback_fn) {
@@ -15721,6 +15726,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 			/* no restricted range, any return value is allowed */
 			if (range.minval == S32_MIN && range.maxval == S32_MAX)
 				return 0;
+			return_32bit = true;
 		} else if (!env->prog->aux->attach_func_proto->type) {
 			/* Make sure programs that attach to void
 			 * hooks don't try to modify return value.
@@ -15751,7 +15757,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	if (err)
 		return err;
 
-	if (!retval_range_within(range, reg)) {
+	if (!retval_range_within(range, reg, return_32bit)) {
 		verbose_invalid_scalar(env, reg, range, exit_ctx, reg_name);
 		if (!is_subprog &&
 		    prog->expected_attach_type == BPF_LSM_CGROUP &&
-- 
2.30.2


