Return-Path: <bpf+bounces-64694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E54BB15F2B
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 13:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A2816714B
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 11:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2177287512;
	Wed, 30 Jul 2025 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQJXWQw6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7127925761;
	Wed, 30 Jul 2025 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753874398; cv=none; b=iYsIyFAJ2bz5cDUSOwrXH8Sb9k98jXeD6b1aHQKrBzfiCPmJAeB22SRq+GSXMvGYGkB0aYW/cEAnFOOLEO2oJ4DFffsrRz73ChUsemuFZDT0QIJuibnijM4QMJuaGfVfI51as1tX2kOgUQGhmUdJgy0BXx0tAOGu8PAdfl++gaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753874398; c=relaxed/simple;
	bh=2YfyJTR1RQIdzBAGVF2wCKxoeT6+u6I1cJVUDJkkRc8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kC2JkM/r5qaj26Lj4mMInOODPjUqroRp7imU+gqJJLdhBSZQI1CmuRXNaASwcg6kzSinyi9glyuUsesRtYBAQKOpdsylzAdwlJxetwQtzuVn5EZijb2kcFSu0egL47NM58i/v94NWIQu9g95TtwNOsW8Q8l3jI5sTwtdWMA+AAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQJXWQw6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4589180b266so5563175e9.3;
        Wed, 30 Jul 2025 04:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753874395; x=1754479195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yJXz1taZeMqAcIikmCjKmMy9sKu4coVbhTtZqnXW6zE=;
        b=DQJXWQw6hiaHRgyerE1rwv4atLFYZfHnLj21DIZca68stPg2AyAiAu0G52yhyB5cep
         h9oSyrRGD3OxTdDA5pna75rdZxqx09qp/w4XT9T/J36b02ek41AxtFiS6oVlvfmHiaaD
         FkBJ/+/WuiyuKWmSxslXGsn4DgAwMYkKs1F0sieChsU8xXnL28pVMPm+94TmypFeHXHi
         AWYtpzzfP8a+JlSWgLcF7TgUHhBRO0oxeCjg/HwEm7hn8aC+XN8HSVfjRdcrfm13i3bA
         4xgYcho95HKqfekdaLFCn4FrUBpvSPV/4WjO8pCc3gh/SDUtVp8WRG7dKqyCVV51+Xp1
         86/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753874395; x=1754479195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJXz1taZeMqAcIikmCjKmMy9sKu4coVbhTtZqnXW6zE=;
        b=jd3Xy5ctTNvz058nxcryI1mVjYZ2oXT2bRrLcZdEA3wKex2UTUQvOD/SxOWT88gF+K
         DNNwy/fjGJT+oeKIqvpGdqLVPR8YtBDrJpD6WmWCUDbXikI2b616fyw/ndvjAz8ROBro
         76py6B2GdczOOETm5pczGs1rk3gVe9U/lIYKcZ5aY9ZNbSx23uD+avtXJ+C7JpHEs1VO
         huxn/0wizQSkcuuQyHfhSuBt4tlp0EK/G7bMp5yLCqiEpD+M7AMuH4yP05xbrvYsMLJT
         y+FzzILmYlAjujnBscNKhG/k6HC+hw4jiI16DoyE/z+GniN9QfC+XTfiDMa6i+XgoiPG
         Dnjg==
X-Forwarded-Encrypted: i=1; AJvYcCW9YS9YaZPJJwBjnPzopOqC3POGZRXrDlz+NG41SbT316N6uk/d8WgcofDtrwcG8+cpgwM=@vger.kernel.org, AJvYcCXOCh9RAoaxkjmgc2ppRPH2WrWpafgd/wvmSnNPjfcugOdberDq1PaxNxQ878z+7dvO4fL8Mq2u65fnV6jPbUS6owHW@vger.kernel.org, AJvYcCXPeyRDtK7gYHoN6qm4V9u32MQcsM+d3BlQWwCPgGtjMmTZizj3jez4OXUcbcWYw+Du2cU9yrl/BuicllM/@vger.kernel.org
X-Gm-Message-State: AOJu0YyjmGzGYUMdvhrCB2AdqdbrFm1tNr+lV/CWUlix4mLYwPGchG9R
	cgs4XDqSN4hurg5PJQzJSWS9sfjETuptpZXXxXs3pwzX4IvcPEJJWMVm
X-Gm-Gg: ASbGncuxPasd2FX2rbzzMChkwa79FEODRHMe7g3iP/r3Ne/N7QC4expDiQR+cZ5ud5W
	/uZo4i0AHob55hyyYbVPTeWP581WV0L88htiz3OzH5THc3OpgFcIAO6TvxFU5ywVjfws5EoBQ8H
	tk7hqURwCH4SJSA/y58tgBP3nL0KBKXkVnLifKXC1cb3uiy4YAL4sYz2rQyfDVjcsH+U3C0qDp7
	+AQhkGxCLsHfmO37r7Q39SWIDOK6ncMB5xWgJnOtPYyqmXeHFisI3kyNBvgGnl3I88PKSc1oTle
	Vlx/F9BKxz2tzfeNM35ZqtFUBhDxIAdhmIsO81kbIfT1Ge18+91CGslc2yRO4VaOrnTvbwHjpvG
	gZCjG+Pk6E1X7TrpwQc1576Uz5Mntsfo=
X-Google-Smtp-Source: AGHT+IHS1hFJmenJMvbQ32NXUNrJjyDKifQkLe7CXSiHbDwUb6p0CnZ4mgpK2sqmbd7w0QSQjYebrQ==
X-Received: by 2002:a05:600c:8812:b0:455:ed48:144f with SMTP id 5b1f17b1804b1-458930ec808mr19828185e9.14.1753874394307;
        Wed, 30 Jul 2025 04:19:54 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45899fb191fsm18863345e9.21.2025.07.30.04.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 04:19:53 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 30 Jul 2025 13:19:51 +0200
To: Mark Rutland <mark.rutland@arm.com>
Cc: Steven Rostedt <rostedt@kernel.org>, Florent Revest <revest@google.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [RFC 00/10] ftrace,bpf: Use single direct ops for bpf trampolines
Message-ID: <aIn_12KHz7ikF2t1@krava>
References: <20250729102813.1531457-1-jolsa@kernel.org>
 <aIkLlB7Z7V--BeGi@J2N7QTR9R3.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIkLlB7Z7V--BeGi@J2N7QTR9R3.cambridge.arm.com>

On Tue, Jul 29, 2025 at 06:57:40PM +0100, Mark Rutland wrote:
> Hi Jiri,
> 
> [adding some powerpc and riscv folk, see below]
> 
> On Tue, Jul 29, 2025 at 12:28:03PM +0200, Jiri Olsa wrote:
> > hi,
> > while poking the multi-tracing interface I ended up with just one
> > ftrace_ops object to attach all trampolines.
> > 
> > This change allows to use less direct API calls during the attachment
> > changes in the future code, so in effect speeding up the attachment.
> 
> How important is that, and what sort of speedup does this result in? I
> ask due to potential performance hits noted below, and I'm lacking
> context as to why we want to do this in the first place -- what is this
> intended to enable/improve?

so it's all work on PoC stage, the idea is to be able to attach many
(like 20,30,40k) functions to their trampolines quickly, which at the
moment is slow because all the involved interfaces work with just single
function/tracempoline relation

there's ongoing development by Menglong [1] to organize such attachment
for multiple functions and trampolines, but still at the end we have to use
ftrace direct interface to do the attachment for each involved ftrace_ops 

so at the point of attachment it helps to have as few ftrace_ops objects
as possible, in my test code I ended up with just single ftrace_ops object
and I see attachment time for 20k functions to be around 3 seconds

IIUC Menglong's change needs 12 ftrace_ops objects so we need to do around
12 direct ftrace_ops direct calls .. so probably not that bad, but still
it would be faster with just single ftrace_ops involved

[1] https://lore.kernel.org/bpf/20250703121521.1874196-1-dongml2@chinatelecom.cn/

> 
> > However having just single ftrace_ops object removes direct_call
> > field from direct_call, which is needed by arm, so I'm not sure
> > it's the right path forward.
> 
> It's also needed by powerpc and riscv since commits:
> 
>   a52f6043a2238d65 ("powerpc/ftrace: Add support for DYNAMIC_FTRACE_WITH_DIRECT_CALLS")
>   b21cdb9523e5561b ("riscv: ftrace: support direct call using call_ops")
> 
> > Mark, Florent,
> > any idea how hard would it be to for arm to get rid of direct_call field?
> 
> For architectures which follow the arm64 style of implementation, it's
> pretty hard to get rid of it without introducing a performance hit to
> the call and/or a hit to attachment/detachment/modification. It would
> also end up being a fair amount more complicated.
> 
> There's some historical rationale at:
> 
>   https://lore.kernel.org/lkml/ZfBbxPDd0rz6FN2T@FVFF77S0Q05N/
> 
> ... but the gist is that for several reasons we want the ops pointer in
> the callsite, and for atomic modification of this to switch everything
> dependent on that ops atomically, as this keeps the call logic and
> attachment/detachment/modification logic simple and pretty fast.
> 
> If we remove the direct_call pointer from the ftrace_ops, then IIUC our
> options include:
> 
> * Point the callsite pointer at some intermediate structure which points
>   to the ops (e.g. the dyn_ftrace for the callsite). That introduces an
>   additional dependent load per call that needs the ops, and introduces
>   potential incoherency with other fields in that structure, requiring
>   more synchronization overhead for attachment/detachment/modification.
> 
> * Point the callsite pointer at a trampoline which can generate the ops
>   pointer. This requires that every ops has a trampoline even for
>   non-direct usage, which then requires more memory / I$, has more
>   potential failure points, and is generally more complicated. The
>   performance here will vary by architecture and platform, on some this
>   might be faster, on some it might be slower.
> 
>   Note that we probably still need to bounce through an intermediary
>   trampoline here to actually load from the callsite pointer and
>   indirectly branch to it.
> 
> ... but I'm not really keen on either unless we really have to remove 
> the ftrace_ops::direct_call field, since they come with a substantial
> jump in complexity.

ok, that sounds bad.. thanks for the details

Steven, please correct me if/when I'm wrong ;-)

IIUC in x86_64, IF there's just single ftrace_ops defined for the function,
it will bypass ftrace trampoline and call directly the direct trampoline
for the function, like:

   <foo>:
     call direct_trampoline
     ...

IF there are other ftrace_ops 'users' on the same function, we execute
each of them like:

  <foo>:
    call ftrace_trampoline
      call ftrace_ops_1->func
      call ftrace_ops_2->func
      ...

with our direct ftrace_ops->func currently using ftrace_ops->direct_call
to return direct trampoline for the function:

	-static void call_direct_funcs(unsigned long ip, unsigned long pip,
	-                             struct ftrace_ops *ops, struct ftrace_regs *fregs)
	-{
	-       unsigned long addr = READ_ONCE(ops->direct_call);
	-
	-       if (!addr)
	-               return;
	-
	-       arch_ftrace_set_direct_caller(fregs, addr);
	-}

in the new changes it will do hash lookup (based on ip) for the direct
trampoline we want to execute:

	+static void call_direct_funcs_hash(unsigned long ip, unsigned long pip,
	+                                  struct ftrace_ops *ops, struct ftrace_regs *fregs)
	+{
	+       unsigned long addr;
	+
	+       addr = ftrace_find_rec_direct(ip);
	+       if (!addr)
	+               return;
	+
	+       arch_ftrace_set_direct_caller(fregs, addr);
	+}

still this is the slow path for the case where multiple ftrace_ops objects use
same function.. for the fast path we have the direct attachment as described above

sorry I probably forgot/missed discussion on this, but doing the fast path like in
x86_64 is not an option in arm, right?


thanks,
jirka

