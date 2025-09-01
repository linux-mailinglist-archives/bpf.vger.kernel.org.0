Return-Path: <bpf+bounces-67118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC16FB3EA52
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 17:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4C34820F3
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C9B34AAFE;
	Mon,  1 Sep 2025 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c+GuKIHC"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9100734AAF1
	for <bpf@vger.kernel.org>; Mon,  1 Sep 2025 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739546; cv=none; b=mtAPrIBAfHKFkxW9KC0/Bm3QRes0D7Id2Xt6DkN51DSBB3snFfVttglKqihzFzPkA2D5jy6I5MLuasLNw7rn+wR5BgZXcqNg8m9ZkUqJFoSLx1l+k/DA6ElgKVMVVYt1rOQUUV2k0ZT7Ja61b63CwFRi3BGPbTFdqY6CkN/aQPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739546; c=relaxed/simple;
	bh=NxJQEuFi+OtMxYSrBxFfD+R61TqbIP4KR2fynxZBgII=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=D7TjmUTSC81Yoa7ovhgpte4Xsw/2DUwubVE2cTfyaz1jR5D7E2lyhfRDAFkMo23FIHAe0IJM2MrJ4/CJUNHDpA3SsPfLA5MP6WsMrdv2yr9h+3RrC/a9/xbWPt6R+jJgDHUkrVy6IxArAg0MfJQPAEerFhNrCQuFJlk60+fhxXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c+GuKIHC; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756739542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHRSWTj/p9wav7QqWiS7E/EIU6jyyncA3AmffwCcf7U=;
	b=c+GuKIHCCN3US+l8kMgf51t6gGW90reMTs7BIQVpz62qFNfFXhUMK3DQToMHiVbPVgWily
	bnxQVLv+zl8BdZyvloddYegpyvWpQEBF7BgTnvoqxOYK0SDCeyDTfFXpQCk5sG1tImYcYY
	y59j3db2yLKKJIRw1K8M05bA/S6vLuA=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Sep 2025 23:12:06 +0800
Message-Id: <DCHK6T0A6T94.9CMWYIYTG79@linux.dev>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Introduce bpf_in_interrupt kfunc
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Leon Hwang" <leon.hwang@linux.dev>
References: <20250825131502.54269-1-leon.hwang@linux.dev>
 <20250825131502.54269-2-leon.hwang@linux.dev>
 <CAADnVQLdmjApwAbrGca2VLQ-SK-3EdQTyd0prEy0BQGrW4Fr6A@mail.gmail.com>
 <d7ca66b9-c8a5-47c4-9feb-d7814efcce0a@linux.dev>
 <CAADnVQKkEk=uZ6LBW2yXSAB2huYwpeOdDggaUAzd74_bs_6dcQ@mail.gmail.com>
In-Reply-To: <CAADnVQKkEk=uZ6LBW2yXSAB2huYwpeOdDggaUAzd74_bs_6dcQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed Aug 27, 2025 at 6:18 AM +08, Alexei Starovoitov wrote:
> On Mon, Aug 25, 2025 at 8:00=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev>=
 wrote:
>>
>>
>>
>> On 25/8/25 23:17, Alexei Starovoitov wrote:
>> > On Mon, Aug 25, 2025 at 6:15=E2=80=AFAM Leon Hwang <leon.hwang@linux.d=
ev> wrote:

[...]

>> >
>> > It doesn't scale. Next thing people will ask for hard vs soft irq.
>> >
>>
>> How about adding a 'flags'?
>>
>> Here are the values for 'flags':
>>
>> * 0: return in_interrupt();
>> * 1(NMI): return in_nmi();
>> * 2(HARDIRQ): return in_hardirq();
>> * 3(SOFTIRQ): return in_softirq();
>
> That's an option, but before we argue whether to do as one kfunc with enu=
m
> vs N kfuncs let's explore bpf only option that doesn't involve changing
> the kernel.
>
>> >> +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>> >> +               insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, (u32)(unsign=
ed long)&__preempt_count);
>> >
>> > I think bpf_per_cpu_ptr() should already be able to read that per cpu =
var.
>> >
>>
>> Correct. bpf_per_cpu_ptr() and bpf_this_cpu_ptr() are helpful to read it=
.
>
> Can you add them as static inline functions to bpf_experimental.h
> and a selftest to make sure it's all working?
> At least for x86 and !PREEMPT_RT.
> Like:
> bool bpf_in_interrupt()
> {
>   bpf_this_cpu_ptr(...preempt_count..) &  (NMI_MASK | HARDIRQ_MASK |
> SOFTIRQ_MASK);
> }
>
> Of course, there is a danger that kernel implementation might
> diverge from bpf-only bit, but it's a risk we're taking all the time.

I do a PoC of adding bpf_in_interrupt() to bpf_experimental.h.

It works:

extern bool CONFIG_PREEMPT_RT __kconfig __weak;
#ifdef bpf_target_x86
extern const int __preempt_count __ksym;
#endif

struct task_struct__preempt_rt {
	int softirq_disable_cnt;
} __attribute__((preserve_access_index));

/* Description
 *      Report whether it is in interrupt context. Only works on x86.
 */
static inline int bpf_in_interrupt(void)
{
#ifdef bpf_target_x86
	int pcnt;

	pcnt =3D *(int *) bpf_this_cpu_ptr(&__preempt_count);
	if (!CONFIG_PREEMPT_RT) {
		return pcnt & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_MASK);
	} else {
		struct task_struct__preempt_rt *tsk;

		tsk =3D (void *) bpf_get_current_task_btf();
		return (pcnt & (NMI_MASK | HARDIRQ_MASK)) |
		       (tsk->softirq_disable_cnt | SOFTIRQ_MASK);
	}
#else
	return 0;
#endif
}

However, I only test it for !PREEMPT_RT on x86.

I'd like to respin the patchset by moving bpf_in_interrupt() to
bpf_experimental.h.

Thanks,
Leon

