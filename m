Return-Path: <bpf+bounces-63449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7903EB07A9F
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 18:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C592E7A508D
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 16:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5CB2F531B;
	Wed, 16 Jul 2025 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dntEMyKB"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECD41A238C
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681924; cv=none; b=u5JAJlRMe+d25cM0qBSbWb1utQ6Bv3A3KlBLTSHW/M2OhJDFsK3DWgcyb6vd3qrwfC5N/mXslidsW3gucaHuejha0LnsM5pAqxz6zidMDQ9gpMj0Pi6eYXXtcfgtkcZVej+wvtBfRzVNXldPIPHuas7CPPZ4Bu8hRvWhXPLE9Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681924; c=relaxed/simple;
	bh=wRRCUNbWnyKy2Hpmvrbgoq7o1QqOfvzi2Xqp++0fABY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oPEv94aRKJoxbcfiID1lFer2eDvfJePYaBqwgCGd5Pyu7ISHfDtepP8SwrDi+vmk5DLWaF7oykbftZZnV4eKwbdGaAIwA6ZwcUXJj9I/mIjTcfbFxCzbslUZfoZAB3lHwnqF/ZVbV6mi8NPJM8Bez6VxyXWvKOuDqujiseWTJeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dntEMyKB; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9b41f9f5-396f-47e0-9a12-46c52087df6c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752681910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gFkj+dcLTyPkcrHAQwjqQzmOpLBhzP4CPtROubMCqJs=;
	b=dntEMyKBBID3TFof0pknd4Ktq8oRtqJ+eoEu7Tf6rZA7vlqDson7+VUi+LIt7Kv7eofIoV
	42neJ6VYJYy1QIow5xFj2rWkSYQtRaq/8dHZTs6GpkEq/DSsKrgTZ21j0Ap5Y8Uc3DqALt
	1MleAQRBvCcWo358aSpQIBdBAyDn7CM=
Date: Wed, 16 Jul 2025 09:05:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Add tests with stack ptr
 register in conditional jmp
Content-Language: en-GB
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>, stable@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
References: <20250524041335.4046126-1-yonghong.song@linux.dev>
 <20250524041340.4046304-1-yonghong.song@linux.dev>
 <4goguotzo5jh4224ox7oaan5l4mh2mt4y54j2bpbeba45umzws@7is5vdizr6m3>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <4goguotzo5jh4224ox7oaan5l4mh2mt4y54j2bpbeba45umzws@7is5vdizr6m3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/16/25 3:13 AM, Shung-Hsi Yu wrote:
> Hi Andrii and Yonghong,
>
> On Fri, May 23, 2025 at 09:13:40PM -0700, Yonghong Song wrote:
>> Add two tests:
>>    - one test has 'rX <op> r10' where rX is not r10, and
>>    - another test has 'rX <op> rY' where rX and rY are not r10
>>      but there is an early insn 'rX = r10'.
>>
>> Without previous verifier change, both tests will fail.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   .../selftests/bpf/progs/verifier_precision.c  | 53 +++++++++++++++++++
>>   1 file changed, 53 insertions(+)
> I was looking this commit (5ffb537e416e) since it was a BPF selftest
> test for CVE-2025-38279, but upon looking I found that the commit
> differs from the patch, there is an extra hunk that changed
> kernel/bpf/verifier.c that wasn't found the Yonghong's original patch.
>
> I suppose it was meant to be squashed into the previous commit
> e2d2115e56c4 "bpf: Do not include stack ptr register in precision
> backtracking bookkeeping"?

Andrii made some change to my original patch for easy understanding.
See
   https://lore.kernel.org/bpf/20250524041335.4046126-1-yonghong.song@linux.dev
Quoted below:
"
I've moved it inside the preceding if/else (twice), so it's more
obvious that BPF_X deal with both src_reg and dst_reg, and BPF_K case
deals only with BPF_K. The end result is the same, but I found this
way a bit easier to follow. Applied to bpf-next, thanks.

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c index 
831c2eff56e1..c9a372ca7830 100644 --- a/kernel/bpf/verifier.c +++ 
b/kernel/bpf/verifier.c @@ -16471,6 +16471,8 @@ static int 
check_cond_jmp_op(struct bpf_verifier_env *env,

                 if (src_reg->type == PTR_TO_STACK)
                         insn_flags |= INSN_F_SRC_REG_STACK;
+ if (dst_reg->type == PTR_TO_STACK) + insn_flags |= INSN_F_DST_REG_STACK;         } else {
                 if (insn->src_reg != BPF_REG_0) {
                         verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
@@ -16480,10 +16482,11 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
                 memset(src_reg, 0, sizeof(*src_reg));
                 src_reg->type = SCALAR_VALUE;
                 __mark_reg_known(src_reg, insn->imm);
+ + if (dst_reg->type == PTR_TO_STACK) + insn_flags |= 
INSN_F_DST_REG_STACK;         }

- if (dst_reg->type == PTR_TO_STACK) - insn_flags |= INSN_F_DST_REG_STACK;         if (insn_flags) {
                 err = push_insn_history(env, this_branch, insn_flags, 0);
                 if (err)
...
"

>
> Since stable backports got only e2d2115e56c4, but not the 5ffb537e416e
> here with the extra change for kernel/bpf/verifier.c, I'd guess the
> backtracking logic in the stable kernel isn't correct at the moment,
> so I'll send 5ffb537e416e "selftests/bpf: Add tests with stack ptr
> register in conditional jmp" to stable as well. Let me know if that's
> not the right thing to do.
>
> Shung-Hsi
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 98c52829936e..a7d6e0c5928b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16456,6 +16456,8 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>   
>   		if (src_reg->type == PTR_TO_STACK)
>   			insn_flags |= INSN_F_SRC_REG_STACK;
> +		if (dst_reg->type == PTR_TO_STACK)
> +			insn_flags |= INSN_F_DST_REG_STACK;
>   	} else {
>   		if (insn->src_reg != BPF_REG_0) {
>   			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
> @@ -16465,10 +16467,11 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>   		memset(src_reg, 0, sizeof(*src_reg));
>   		src_reg->type = SCALAR_VALUE;
>   		__mark_reg_known(src_reg, insn->imm);
> +
> +		if (dst_reg->type == PTR_TO_STACK)
> +			insn_flags |= INSN_F_DST_REG_STACK;
>   	}
>   
> -	if (dst_reg->type == PTR_TO_STACK)
> -		insn_flags |= INSN_F_DST_REG_STACK;
>   	if (insn_flags) {
>   		err = push_insn_history(env, this_branch, insn_flags, 0);
>   		if (err)
>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
> ...
>


