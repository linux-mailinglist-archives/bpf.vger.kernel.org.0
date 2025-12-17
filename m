Return-Path: <bpf+bounces-76904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 863A1CC9532
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 19:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9E0030688CA
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 18:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DF3274B53;
	Wed, 17 Dec 2025 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aynrvuft"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15566261B9C
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765997272; cv=none; b=WPVHW/5y+a1W/NoEENFc7L6NO9MGhWSqwYBVGmk3MTeaDsABv/VCWEfVeTqHgzTQQj/gWL1PtjTWeZ2+21rdkFnHChRh6codhm5maxnsKw4VoFo1QIXhH5s/UpbrlgTK3LXNIA95mmgOWMoK3Dr+BtiGAIaYU463RbLfZjCjak0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765997272; c=relaxed/simple;
	bh=uUPGRT5fVPfZAIk8LQJYCeoslhbMnNe814ivjjuDVys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2ppf3oi7ry3FRJzZS7jdZo4UXy3DWLb5Z0Nr4ttBdhjDGIFf6uurB+8gyvIZhWwHNfgFVYPCvD7G7he5uafKiGnDUGWF6rEWw1HtsVOPTRg0HDbYHFynR7NfXcT8dGkjfUffoilRS+tmph+I+d5PXdnL/5CxiFB2QCgnkdlLaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aynrvuft; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42e2e628f8aso2655199f8f.1
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 10:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765997269; x=1766602069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkxIo5NSMrkuDEwiHD51bssSH7j42qmURAvChq3iZZY=;
        b=AynrvuftUVW+aW4IA/IYmnjEpmcu/Mvvy1J9csypXyL87WWTs0UycbS8FEjPrXvt0/
         yP21IyghhRJFS7U5t1Y7J8Y20au8siAKMPMo+i2D7ddyEM9M7ESnFME33fIYjdSZYkK/
         5rIcOYuhfKYQ6jyaKzs7is8DUZbW8dIJwwslo7IpU28UxxI2CB2l9hokDe72/szNEsqq
         J044cjmghPu3NnPBR50q3FQGwIncutcsBmwhKWW5V0Qf2UfpRsTviW9toKNu+ycaBMAi
         Ni+ysnyh8hXnvReyZrqexZXUn23AScPqJ+l8K+xvoH2y3LkAKilw1K/OtrcZIpwf+e3j
         AbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765997269; x=1766602069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TkxIo5NSMrkuDEwiHD51bssSH7j42qmURAvChq3iZZY=;
        b=lq60xUXBVD1fwWyve2tm71pCEl0YKO4tRtwrtFi3p7+snouHOXaHtMFtYdcOW5g0/q
         TPlF0Li/NCvulVcjfFtiY24sqPc4HWjtLebgmIJ1ZwH2jom5p0mJfjNLH0gwt6Zndp37
         6Bj9WPmxeLK/EPjpFWjADhJBfv5odZZpxY5nfb6lg2N4fO9taD77RsBPEDvMj2uazoOi
         51hONDUhIIYXgCXTqfP3fKw2/yX98R4oKUdQkSFtvIVVm9xrNLRTFCjFc2XKVPQ9Otb9
         zkNNsGpG4o7UC8RDIkt9UPEjQcUU19+ECzxBKbi/pL2exSeilsDjfBFd6M6+JmKRIYUb
         6vdA==
X-Forwarded-Encrypted: i=1; AJvYcCVYd7YeBBbQYcsJQt8XYjq0i8hqmLMMvYSQA2g140aYodhRp4ggkwdhNC3vkJwC3TwWKP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfruoPV2wVU/e+5V2Unl+K+RqCoXX8g1lzYlBv7t0RYfmmuyv4
	11PMr25LIR2EOz3vvrOr5L3j+EwOIiOE1kdQpitbJAbmkTODC1n8UgTsdIaTjEHZ6SJj7ZwG4ZY
	weCcIe3eLB1afcq8Si0MkVdElAtV4aeE=
X-Gm-Gg: AY/fxX47uSJ0Q7fHCV9s6Zkwn+DZeQliu3AW15PlgOiVQ6MU2uTPvYaFtHefLKvs7RK
	OatuPdFyFLDKF+aMI3XDrLcZ1g05zA3vjfn3CT2F5Yq7IMUYHwdF7cSj5/fRG40RC3RfqBKmYVV
	v8zbS126g5RTPsMlxu3+nWC9kVEJmgMbHJ+jCRn2751Wf5UOsPyDfE6kaGKRQ4fPSMtx5x04EQC
	cCjlZA3puHQYm6S+z5dX9dyDSv6YuSbFy5gDHt3QykwqbTVVBX+mdiE2QqfOx1rib/mf0EAuG1s
	3PSlMhAbEVA+nka4SWGJsGLwbPDi
X-Google-Smtp-Source: AGHT+IFJsiqlYVX0KDiIUIaDkJwxHD+X80ySLs2ZH2r5tBXwDTydMS9bE1uXqgABAnskb4owz0cbfD5+DrOIQiAyWWw=
X-Received: by 2002:a05:6000:220b:b0:431:9d7:5c2e with SMTP id
 ffacd0b85a97d-43109d76385mr6099590f8f.35.1765997269254; Wed, 17 Dec 2025
 10:47:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217162830.2597286-3-puranjay@kernel.org> <f144fd46b602b74fc4c1c2664082fbe893e7ec9c274fcc5fdf13d65151749e9c@mail.kernel.org>
 <51466fd3-c837-46a6-af50-28a8336fd8cd@linux.dev> <CANk7y0irgYcHLH_e9ozjX3wTeDb3GH-PA+6UiLRSBFzpYs8eVQ@mail.gmail.com>
In-Reply-To: <CANk7y0irgYcHLH_e9ozjX3wTeDb3GH-PA+6UiLRSBFzpYs8eVQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 Dec 2025 10:47:38 -0800
X-Gm-Features: AQt7F2rEhaRGbBhp4Z1T9bFxXJdusQFOZSY_kCb_Mfspu8QsbHtWNCGE_29KUyI
Message-ID: <CAADnVQKHXDcTFB5sJJH6mQpymCY7K10zGSKssQetDc-tfy8eZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: arm64: Optimize recursion detection by
 not using atomics
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>, bot+bpf-ci@kernel.org, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 10:44=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
>
> On Wed, Dec 17, 2025 at 6:24=E2=80=AFPM Yonghong Song <yonghong.song@linu=
x.dev> wrote:
> >
> >
> >
> > On 12/17/25 8:56 AM, bot+bpf-ci@kernel.org wrote:
> > >> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > >> index 2da986136d26..654fb94bf60c 100644
> > >> --- a/include/linux/bpf.h
> > >> +++ b/include/linux/bpf.h
> > > [ ... ]
> > >
> > >> @@ -2006,12 +2009,32 @@ struct bpf_struct_ops_common_value {
> > >>
> > >>   static inline bool bpf_prog_get_recursion_context(struct bpf_prog =
*prog)
> > >>   {
> > >> +#ifdef CONFIG_ARM64
> > >> +    u8 rctx =3D interrupt_context_level();
> > >> +    u8 *active =3D this_cpu_ptr(prog->active);
> > >> +
> > >> +    active[rctx]++;
> > >> +    barrier();
> > >> +    if (get_unaligned_le32(active) !=3D BIT(rctx * 8))
> > >> +            return false;
> > >> +
> > >> +    return true;
> > >> +#else
> > >>      return this_cpu_inc_return(*(prog->active)) =3D=3D 1;
> > >> +#endif
> > >>   }
> > > Can preemption between the increment and check cause a counter leak o=
n
> > > CONFIG_PREEMPT_RCU systems? The trampoline calls this function under
> > > rcu_read_lock_dont_migrate() which allows preemption on PREEMPT_RCU
> > > (documented at include/linux/rcupdate.h:856).
> > >
> > > Consider this scenario on an ARM64 system with PREEMPT_RCU:
> > >
> > > 1. Thread A increments active[0] to 1
> > > 2. Preemption occurs before Thread A reaches the check
> > > 3. Thread B on same CPU increments active[0] to 2
> > > 4. Thread B checks: sees 2 !=3D BIT(0), returns false
> > > 5. Thread A resumes, checks: sees 2 !=3D BIT(0), returns false
> > > 6. Both threads return false, neither runs BPF
> > > 7. Neither calls bpf_prog_put_recursion_context() (see
> > >     __bpf_prog_enter_recur() at kernel/bpf/trampoline.c:952)
> > > 8. Counter permanently stuck at 2, all future BPF on this CPU fails
> > >
> > > The old atomic code handled this correctly because this_cpu_inc_retur=
n()
> > > completes atomically, ensuring Thread A reads the value 1 before Thre=
ad B
> > > can interfere. With non-atomic operations, Thread A increments but ha=
sn't
> > > read the value yet, allowing Thread B to interfere and cause both thr=
eads
> > > to see the modified value.
> > >
> > > Is there a guarantee that same-context preemption cannot occur in the=
 BPF
> > > execution path on ARM64, or does this need additional synchronization=
?
> >
> > AI is correct here. See below for another thread:
> >    https://lore.kernel.org/bpf/20251217093326.1745307-1-chen.dylane@lin=
ux.dev/T/#m906fd4502fbbedd4609c586122a393363003312a
> > where preempt_disable is necessary to prevent the above scenario.
>
> See my other reply, the above scenario presented by AI is wrong
> because step 7 is wrong.

yep. preempt_disable is not necessary here. perf buffers being
reused is a different issue.

