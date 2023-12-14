Return-Path: <bpf+bounces-17751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3358123F6
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 01:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CD52820EC
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 00:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C5E634;
	Thu, 14 Dec 2023 00:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mijrqFO3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5804EB0;
	Wed, 13 Dec 2023 16:36:48 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9fa2714e828so981414566b.1;
        Wed, 13 Dec 2023 16:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702514207; x=1703119007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4/cg7NnZrD+0jLGfKo4qZyvj9UTKzYk6re95esi4sQ=;
        b=mijrqFO3EoJa4IVWofcrrhjWCFUt9OGmzUo56B7MnJ9i5xFIUw1Hc3LKWhUP2BCdn6
         q2XjUKG5cZ4Xy5NwIBdr+jvEtWry82okM0Rfo1loIBwcwGMASb5Xvnd0NKKuBr/MmVx0
         XKY8V3UXg6vf9WCJxTxJN19w7xUAG8znlmvy8SvD+WCu1ckcU33VPlc+vN1s8Spk760N
         aq9mQj4/rY5EfcqaEUOP1L0LIuzvkHq33O6cVbG6WTnIBsIk/c4inisZDUUILDhlcRYu
         3j8I5dBbAfn5WPgvm/RMnV+SzAZ5102OMayy8JqQWdw2HwCsALsdonm1Ef1QEKb/+t6P
         jJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702514207; x=1703119007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4/cg7NnZrD+0jLGfKo4qZyvj9UTKzYk6re95esi4sQ=;
        b=ijuV25tRujZSnBJkvsCudQCO9XymD8hv0sUypfAeWlxsAo/71ngS8NSXr1F8TSa2NF
         YDG6is17naVrNkxcwT8J0tZE58Xs//bppwtWa7c3Zl8UKYEfFP22RtMJokh//8msKS5N
         KkNryYI5N2CaLXdFRTROXDGEGn/C2eciiC3AYgRVGCTU+fV+TbacFCtO/iIIShtWpkT1
         1QJRWdGCjzUWVZoWKWqzVAuNeVmzl9f0Okkpm81+A8g2czfSR+S1OrIuWKg0S43aKOd0
         yrScrMyfXJ9IPIMqqQOS8ricAgDN7nz0qe/PVfFsXFUCinNG6SXh8iCJcMvckMo/l/VW
         oUKw==
X-Gm-Message-State: AOJu0Yzchyako1OcgkYiUmgoyCIUFypxQ8gTKBkn3XfU8tCaUVdxnsAi
	NlVRYQ9dywDl2dePYTTTE28WWpyuafkA4pwKwxo=
X-Google-Smtp-Source: AGHT+IEZIJ6EmNROX5ipvPf5YbEnCt7fbA9/NkEfEn/5k6Z/aNsWMC+eGTLaU0t3NOlrYDfesLdLG4wrX4LWEtRMkwc=
X-Received: by 2002:a17:906:82:b0:a1f:99e1:8a61 with SMTP id
 2-20020a170906008200b00a1f99e18a61mr2845709ejc.24.1702514206384; Wed, 13 Dec
 2023 16:36:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsbj4y4EhqpV-ZVt645UtERJRTxfEab21jXD1ahPyzH4_g@mail.gmail.com>
 <CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com>
 <CACkBjsaEQxCaZ0ERRnBXduBqdw3MXB5r7naJx_anqxi0Wa-M_Q@mail.gmail.com>
 <CAEf4BzbGSrU4NgM1Ps0g_ch8G68CWEsP50Y+Wy8-SfYnpHwVGA@mail.gmail.com> <35be3c5f29ee0e9a49ed29e71044f0ad25d97d9d.camel@gmail.com>
In-Reply-To: <35be3c5f29ee0e9a49ed29e71044f0ad25d97d9d.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Dec 2023 16:36:33 -0800
Message-ID: <CAEf4BzZ783F4DV0Mq-xtSph-vTvF-O8AyZpnwOC=6hw=N3x1vw@mail.gmail.com>
Subject: Re: [Bug Report] bpf: incorrectly pruning runtime execution path
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Hao Sun <sunhao.th@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 4:08=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2023-12-13 at 15:30 -0800, Andrii Nakryiko wrote:
> [...]
> > Yes, thanks, the execution trace above was helpful. Let's try to
> > minimize the example here, I'll keep original instruction indices,
> > though:
> >
> >    23: (bf) r5 =3D r8                   ; here we link r5 and r8 togeth=
er
> >    26: (7e) if w8 s>=3D w0 goto pc+5    ; here it's not always/never
> > taken, so w8 and w0 remain imprecise
> >    28: (0f) r8 +=3D r8                  ; here link between r8 and r5 i=
s broken
> >    29: (d6) if w5 s<=3D 0x1d goto pc+2  ; here we know value of w5 and
> > so it's always/never taken, r5 is marked precise
> >
> > Now, if we look at r5's precision log at this instruction:
> >
> > 29: (d6) if w5 s<=3D 0x1d goto pc+2
> > mark_precise: frame0: last_idx 29 first_idx 26 subseq_idx -1
> > mark_precise: frame0: regs=3Dr5 stack=3D before 28: (0f) r8 +=3D r8
> > mark_precise: frame0: regs=3Dr5 stack=3D before 27: (4f) r8 |=3D r8
> > mark_precise: frame0: regs=3Dr5 stack=3D before 26: (7e) if w8 s>=3D w0=
 goto pc+5
>
> Sorry, maybe it's time for me to get some sleep, but I don't see an
> issue here. The "before" log is printed by backtrack_insn() before
> instruction is backtracked. So the following:
>
> > mark_precise: frame0: regs=3Dr5 stack=3D before 26: (7e) if w8 s>=3D w0=
 goto pc+5
>
> Is a state of backtracker before "if w8 s>=3D w0 ..." is processed.
> But running the test case I've shared wider precision trace for
> this instruction looks as follows:
>
>   26: (7e) if w8 s>=3D w0 goto pc+5       ; R0=3Dscalar(smin=3Dsmin32=3D0=
,smax=3Dumax=3Dsmax32=3Dumax32=3D2,var_off=3D(0x0; 0x3))
>                                           R8=3Dscalar(id=3D2,smax32=3D1)
>   27: (4f) r8 |=3D r8                     ; R8_w=3Dscalar()
>   28: (0f) r8 +=3D r8                     ; R8_w=3Dscalar()
>   29: (d6) if w5 s<=3D 0x1d goto pc+2
>   mark_precise: frame0: last_idx 29 first_idx 26 subseq_idx -1
>   mark_precise: frame0: regs=3Dr5 stack=3D before 28: (0f) r8 +=3D r8

What if we had a checkpoint here and not have a checkpoint at
conditional jump instruction?

The general point is that the checkpoint has information about linked
registers at the very end of the instruction span that it represents,
but any intermediate changes will be lost.

It's a similar issue to stack access tracking. At some point we know
that r3 is actually fp-8, but we will lose it by the time we actually
get to the checkpoint. Yet this information is important in the
context of some instruction before the checkpoint.

I might be missing something as well, my brain is fried from all these
verifier issues.

>   mark_precise: frame0: regs=3Dr5 stack=3D before 27: (4f) r8 |=3D r8
>   mark_precise: frame0: regs=3Dr5 stack=3D before 26: (7e) if w8 s>=3D w0=
 goto pc+5
>   mark_precise: frame0: parent state regs=3Dr5 stack=3D:
>      R0_rw=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D2,v=
ar_off=3D(0x0; 0x3))
>      R2_w=3D4
>      R3_w=3D0x1f00000034
>      R4_w=3Dscalar(smin=3D0,smax=3Dumax=3D0x3fffffffc,smax32=3D0x7ffffffc=
,umax32=3D0xfffffffc,
>                  var_off=3D(0x0; 0x3fffffffc))
>      R5_rw=3DPscalar(id=3D2)
>      R8_rw=3Dscalar(id=3D2) R10=3Dfp0
>   mark_precise: frame0: last_idx 24 first_idx 11 subseq_idx 26

would this all work if we didn't have a checkpoint here?

>   mark_precise: frame0: regs=3Dr5,r8 stack=3D before 24: (18) r2 =3D 0x4 =
    <------ !!!
>   mark_precise: frame0: regs=3Dr5,r8 stack=3D before 23: (bf) r5 =3D r8
>   mark_precise: frame0: regs=3Dr8 stack=3D before 22: (67) r4 <<=3D 2
>   ...
>
> Note, that right after "if w8 s>=3D w0 goto pc+5" is processed the
> backtracker state is:
>
>   mark_precise: frame0: regs=3Dr5,r8 stack=3D before 24: (18) r2 =3D 0x4
>
> So both r5 and r8 are accounted for.
>
> > Note how at this instruction r5 and r8 *WERE* linked together, but we
> > already lost this information for backtracking. So we don't mark w8 as
> > precise. That's one part of the problem.
> >
> > The second part is that even if we knew that w8/r8 is precise, should
> > we mark w0/r0 as precise? I actually need to think about this some
> > more. Right now for conditional jumps we eagerly mark precision for
> > both registers only in always/never taken scenarios.
> >
> > For now just narrowing down the issue, as I'm sure not many people
> > followed all the above stuff carefully.
> >
> >
> > P.S. For solving tracking of linked registers we can probably utilize
> > instruction history, though technically they can be spread across
> > multiple frames, between registers and stack slots, so that's a bit
> > tricky.
>
> For precision back-propagation we currently rely on id values stored
> in the parent state, when moving up from child to parent boundary.

Everything might be good with linked IDs. But there is a real issue
here, let's find what it is.

