Return-Path: <bpf+bounces-19251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFC2827E46
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 06:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D417B22777
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 05:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81888A5C;
	Tue,  9 Jan 2024 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mnImytZ9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E750639
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 05:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704777312; x=1736313312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b85RG/h8762SpNiGDsbksn7Kwei1js8j2lhvhK9+4A4=;
  b=mnImytZ9Lcfm8rfVahpATuzogHL/z+cbjXUZWJBJtXgBD8bSK7Lxt1UR
   zCntawkbCnfg4E8Rh4E3KtTQos9mDfWHTvWBU29gyu0LPLF5rBrJXCYdV
   T8o5Y4k0uW9cmE581w2xlkrUks9CKraAGv0kP9VIQxcaQaEwsAtfiKt79
   o=;
X-IronPort-AV: E=Sophos;i="6.04,181,1695686400"; 
   d="scan'208";a="695903490"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 05:15:06 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-1box-2bm6-32cf6363.us-west-2.amazon.com (Postfix) with ESMTPS id 5AF838981D;
	Tue,  9 Jan 2024 05:15:06 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:54263]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.136:2525] with esmtp (Farcaster)
 id 5c956bf1-c080-4729-8a57-576975e16973; Tue, 9 Jan 2024 05:15:05 +0000 (UTC)
X-Farcaster-Flow-ID: 5c956bf1-c080-4729-8a57-576975e16973
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 05:15:04 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Tue, 9 Jan 2024 05:15:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <yonghong.song@linux.dev>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <kafai@fb.com>, <kernel-team@fb.com>,
	<kuniyu@amazon.com>, <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Track aligned st store as imprecise spilled registers
Date: Mon, 8 Jan 2024 21:14:50 -0800
Message-ID: <20240109051450.59089-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240109040524.2313448-1-yonghong.song@linux.dev>
References: <20240109040524.2313448-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Yonghong Song <yonghong.song@linux.dev>
Date: Mon,  8 Jan 2024 20:05:24 -0800
> With patch set [1], precision backtracing supports register spill/fill
> to/from the stack. The patch [2] allows initial imprecise register spill
> with content 0. This is a common case for cpuv3 and lower for
> initializing the stack variables with pattern
>   r1 = 0
>   *(u64 *)(r10 - 8) = r1
> and the [2] has demonstrated good verification improvement.
> 
> For cpuv4, the initialization could be
>   *(u64 *)(r10 - 8) = 0
> The current verifier marks the r10-8 contents with STACK_ZERO.
> Similar to [2], let us permit the above insn to behave like
> imprecise register spill which can reduce number of verified states.
> The change is in function check_stack_write_fixed_off().
> 
> Before this patch, spilled zero will be marked as STACK_ZERO
> which can provide precise values. In check_stack_write_var_off(),
> STACK_ZERO will be maintained if writing a const zero
> so later it can provide precise values if needed.
> 
> The above handling of '*(u64 *)(r10 - 8) = 0' as a spill
> will have issues in check_stack_write_var_off() as the spill
> will be converted to STACK_MISC and the precise value 0
> is lost. To fix this issue, if the spill slots with const
> zero and the BPF_ST write also with const zero, the spill slots
> are preserved, which can later provide precise values
> if needed. Without the change in check_stack_write_var_off(),
> the test_verifier subtest 'BPF_ST_MEM stack imm zero, variable offset'
> will fail.
> 
> I checked cpuv3 and cpuv4 with and without this patch with veristat.
> There is no state change for cpuv3 since '*(u64 *)(r10 - 8) = 0'
> is only generated with cpuv4.
> 
> For cpuv4:
> $ ../veristat -C old.cpuv4.csv new.cpuv4.csv -e file,prog,insns,states -f 'insns_diff!=0'
> File                                        Program              Insns (A)  Insns (B)  Insns    (DIFF)  States (A)  States (B)  States (DIFF)
> ------------------------------------------  -------------------  ---------  ---------  ---------------  ----------  ----------  -------------
> local_storage_bench.bpf.linked3.o           get_local                  228        168    -60 (-26.32%)          17          14   -3 (-17.65%)
> pyperf600_bpf_loop.bpf.linked3.o            on_event                  6066       4889  -1177 (-19.40%)         403         321  -82 (-20.35%)
> test_cls_redirect.bpf.linked3.o             cls_redirect             35483      35387     -96 (-0.27%)        2179        2177    -2 (-0.09%)
> test_l4lb_noinline.bpf.linked3.o            balancer_ingress          4494       4522     +28 (+0.62%)         217         219    +2 (+0.92%)
> test_l4lb_noinline_dynptr.bpf.linked3.o     balancer_ingress          1432       1455     +23 (+1.61%)          92          94    +2 (+2.17%)
> test_xdp_noinline.bpf.linked3.o             balancer_ingress_v6       3462       3458      -4 (-0.12%)         216         216    +0 (+0.00%)
> verifier_iterating_callbacks.bpf.linked3.o  widening                    52         41    -11 (-21.15%)           4           3   -1 (-25.00%)
> xdp_synproxy_kern.bpf.linked3.o             syncookie_tc             12412      11719    -693 (-5.58%)         345         330   -15 (-4.35%)
> xdp_synproxy_kern.bpf.linked3.o             syncookie_xdp            12478      11794    -684 (-5.48%)         346         331   -15 (-4.34%)
> 
> test_l4lb_noinline and test_l4lb_noinline_dynptr has minor regression, but
> pyperf600_bpf_loop and local_storage_bench gets pretty good improvement.
> 
>   [1] https://lore.kernel.org/all/20231205184248.1502704-1-andrii@kernel.org/
>   [2] https://lore.kernel.org/all/20231205184248.1502704-9-andrii@kernel.org/
> 
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Tested-by: Kuniyuki Iwashima <kuniyu@amazon.com>

I confirmed that the selftest of synproxy kfunc ran successfully
for cpuv4 with your patch.

https://lore.kernel.org/bpf/20231221012806.37137-7-kuniyu@amazon.com/

---8<---
$ sudo ./test_progs-cpuv4 -t tcp_custom
#349/1   tcp_custom_syncookie/IPv4 TCP  :OK
#349/2   tcp_custom_syncookie/IPv6 TCP  :OK
#349     tcp_custom_syncookie:OK
Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
---8<---

Thank you so much!


> ---
>  kernel/bpf/verifier.c                            | 16 ++++++++++++++--
>  .../selftests/bpf/progs/verifier_spill_fill.c    | 16 ++++++++--------
>  2 files changed, 22 insertions(+), 10 deletions(-)
> 
> Changelogs:
>   v2 -> v3:
>     - add precision checking to the spilled zero value register in
>       check_stack_write_var_off().
>     - check spill slot-by-slot instead of in a bunch within a spi.
>   v1 -> v2:
>     - Preserve with-const-zero spill if writing is also zero
>       in check_stack_write_var_off().
>     - Add a test with not-8-byte-aligned BPF_ST store.
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index adbf330d364b..54da1045e078 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4493,7 +4493,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
>  		if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
>  			state->stack[spi].spilled_ptr.id = 0;
>  	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
> -		   insn->imm != 0 && env->bpf_capable) {
> +		   env->bpf_capable) {
>  		struct bpf_reg_state fake_reg = {};
>  
>  		__mark_reg_known(&fake_reg, insn->imm);
> @@ -4615,6 +4615,7 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
>  
>  	/* Variable offset writes destroy any spilled pointers in range. */
>  	for (i = min_off; i < max_off; i++) {
> +		struct bpf_reg_state *spill_reg;
>  		u8 new_type, *stype;
>  		int slot, spi;
>  
> @@ -4640,7 +4641,18 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
>  			return -EINVAL;
>  		}
>  
> -		/* Erase all spilled pointers. */
> +		/* If writing_zero and the the spi slot contains a spill of value 0,
> +		 * maintain the spill type.
> +		 */
> +		if (writing_zero && is_spilled_scalar_reg(&state->stack[spi])) {
> +			spill_reg = &state->stack[spi].spilled_ptr;
> +			if (tnum_is_const(spill_reg->var_off) && spill_reg->var_off.value == 0) {
> +				zero_used = true;
> +				continue;
> +			}
> +		}
> +
> +		/* Erase all other spilled pointers. */
>  		state->stack[spi].spilled_ptr.type = NOT_INIT;
>  
>  		/* Update the slot type. */
> diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> index 39fe3372e0e0..d4b3188afe07 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> @@ -495,14 +495,14 @@ char single_byte_buf[1] SEC(".data.single_byte_buf");
>  SEC("raw_tp")
>  __log_level(2)
>  __success
> -/* make sure fp-8 is all STACK_ZERO */
> -__msg("2: (7a) *(u64 *)(r10 -8) = 0          ; R10=fp0 fp-8_w=00000000")
> +/* fp-8 is spilled IMPRECISE value zero (represented by a zero value fake reg) */
> +__msg("2: (7a) *(u64 *)(r10 -8) = 0          ; R10=fp0 fp-8_w=0")
>  /* but fp-16 is spilled IMPRECISE zero const reg */
>  __msg("4: (7b) *(u64 *)(r10 -16) = r0        ; R0_w=0 R10=fp0 fp-16_w=0")
> -/* validate that assigning R2 from STACK_ZERO doesn't mark register
> +/* validate that assigning R2 from STACK_SPILL with zero value  doesn't mark register
>   * precise immediately; if necessary, it will be marked precise later
>   */
> -__msg("6: (71) r2 = *(u8 *)(r10 -1)          ; R2_w=0 R10=fp0 fp-8_w=00000000")
> +__msg("6: (71) r2 = *(u8 *)(r10 -1)          ; R2_w=0 R10=fp0 fp-8_w=0")
>  /* similarly, when R2 is assigned from spilled register, it is initially
>   * imprecise, but will be marked precise later once it is used in precise context
>   */
> @@ -520,14 +520,14 @@ __msg("mark_precise: frame0: regs=r0 stack= before 3: (b7) r0 = 0")
>  __naked void partial_stack_load_preserves_zeros(void)
>  {
>  	asm volatile (
> -		/* fp-8 is all STACK_ZERO */
> +		/* fp-8 is value zero (represented by a zero value fake reg) */
>  		".8byte %[fp8_st_zero];" /* LLVM-18+: *(u64 *)(r10 -8) = 0; */
>  
>  		/* fp-16 is const zero register */
>  		"r0 = 0;"
>  		"*(u64 *)(r10 -16) = r0;"
>  
> -		/* load single U8 from non-aligned STACK_ZERO slot */
> +		/* load single U8 from non-aligned spilled value zero slot */
>  		"r1 = %[single_byte_buf];"
>  		"r2 = *(u8 *)(r10 -1);"
>  		"r1 += r2;"
> @@ -539,7 +539,7 @@ __naked void partial_stack_load_preserves_zeros(void)
>  		"r1 += r2;"
>  		"*(u8 *)(r1 + 0) = r2;" /* this should be fine */
>  
> -		/* load single U16 from non-aligned STACK_ZERO slot */
> +		/* load single U16 from non-aligned spilled value zero slot */
>  		"r1 = %[single_byte_buf];"
>  		"r2 = *(u16 *)(r10 -2);"
>  		"r1 += r2;"
> @@ -551,7 +551,7 @@ __naked void partial_stack_load_preserves_zeros(void)
>  		"r1 += r2;"
>  		"*(u8 *)(r1 + 0) = r2;" /* this should be fine */
>  
> -		/* load single U32 from non-aligned STACK_ZERO slot */
> +		/* load single U32 from non-aligned spilled value zero slot */
>  		"r1 = %[single_byte_buf];"
>  		"r2 = *(u32 *)(r10 -4);"
>  		"r1 += r2;"
> -- 
> 2.34.1

