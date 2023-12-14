Return-Path: <bpf+bounces-17745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3E98123B5
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 01:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396961F217FB
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 00:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3FF381;
	Thu, 14 Dec 2023 00:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ni9u3NPV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB7B85;
	Wed, 13 Dec 2023 16:09:00 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-336437ae847so645410f8f.2;
        Wed, 13 Dec 2023 16:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702512538; x=1703117338; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q5/M47CiHwU265p/4DazyjJg2apbPY8v/ugoyTcBk3c=;
        b=ni9u3NPVj2NL2iWwcHdKB0RYICXhF6pCvqmGJSW0kJsl+hZS0OoVF2xJRjYY4LK+Bf
         yXMWGF0VzKGam9K80hE2hgdX3ex55OOTDuwFil54ZyChs9SvcauC/uptpYHEwPrVzuww
         wEoFIgYbavBy7PbVHnGxE+V/5wuMPWfUT1XAdaNZwZbytIaY/FbqyU7Tw4L3ri5vf68E
         pWW3+4QNSJgWgX8twhZuttXcSbPYV2M0QmMiCaUlEomdFr6HKwrNTelqTm5WF6hbMuRS
         947hr8Rt5s8vHJCTpPa8ECZmc8gtUH+e4EMIxnYRxDISXaJq3GndwvPSjHYyHYEhjPNq
         puwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702512538; x=1703117338;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5/M47CiHwU265p/4DazyjJg2apbPY8v/ugoyTcBk3c=;
        b=UsDbBdIDOum8Rcb2r75cl80he5eExj2l0h72EJXMMDXV/G0TI3NNxhdTz1ab6o/pPa
         WQ2ZMUiRdOVJ+w7zXE9HB5sv5Vq2f08GkN8UqS7V4g08Zq0AvpWVCYiEyjWqHlkKZa7H
         uqT02s9HM+pxAseP20VDaZkVNvDba4bnYiT3C64/GJ+BaXShswiUbAwwFuXUPJcyGssq
         C76wJfFjgrkWX448bxt7xIkp6ckJCDYQ529qak5Yog+HhqOxvS/owgzDZgxCKDEY7czI
         5m/fAZJieB1PUeEyWg0Y6J405WewWo9wdv/RUFMFq+31OTQCJDhuwwCe3lt4AWZVuUYR
         EJBQ==
X-Gm-Message-State: AOJu0YxrmkVtYQASLgHDJrMyA/kgtmLN0jmkTTPJGvP1oBj/IBG4npRA
	dzkfFTWvMsk0Ie2jFAK8BDE=
X-Google-Smtp-Source: AGHT+IFaFslENLfjBBN50kKA4B3LRuLG8ZpbGkzeUvfUvfoj0qlRLDQNmS2baKQq3xatQsKhhqBDgQ==
X-Received: by 2002:a5d:5cc5:0:b0:333:2f1e:cbc4 with SMTP id cg5-20020a5d5cc5000000b003332f1ecbc4mr5131223wrb.13.1702512538293;
        Wed, 13 Dec 2023 16:08:58 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h6-20020a5d6886000000b00336430ad57csm1475334wru.106.2023.12.13.16.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 16:08:57 -0800 (PST)
Message-ID: <35be3c5f29ee0e9a49ed29e71044f0ad25d97d9d.camel@gmail.com>
Subject: Re: [Bug Report] bpf: incorrectly pruning runtime execution path
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Hao Sun
 <sunhao.th@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, bpf
 <bpf@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Date: Thu, 14 Dec 2023 02:08:56 +0200
In-Reply-To: <CAEf4BzbGSrU4NgM1Ps0g_ch8G68CWEsP50Y+Wy8-SfYnpHwVGA@mail.gmail.com>
References: 
	<CACkBjsbj4y4EhqpV-ZVt645UtERJRTxfEab21jXD1ahPyzH4_g@mail.gmail.com>
	 <CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com>
	 <CACkBjsaEQxCaZ0ERRnBXduBqdw3MXB5r7naJx_anqxi0Wa-M_Q@mail.gmail.com>
	 <CAEf4BzbGSrU4NgM1Ps0g_ch8G68CWEsP50Y+Wy8-SfYnpHwVGA@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-13 at 15:30 -0800, Andrii Nakryiko wrote:
[...]
> Yes, thanks, the execution trace above was helpful. Let's try to
> minimize the example here, I'll keep original instruction indices,
> though:
>=20
>    23: (bf) r5 =3D r8                   ; here we link r5 and r8 together
>    26: (7e) if w8 s>=3D w0 goto pc+5    ; here it's not always/never
> taken, so w8 and w0 remain imprecise
>    28: (0f) r8 +=3D r8                  ; here link between r8 and r5 is =
broken
>    29: (d6) if w5 s<=3D 0x1d goto pc+2  ; here we know value of w5 and
> so it's always/never taken, r5 is marked precise
>=20
> Now, if we look at r5's precision log at this instruction:
>=20
> 29: (d6) if w5 s<=3D 0x1d goto pc+2
> mark_precise: frame0: last_idx 29 first_idx 26 subseq_idx -1
> mark_precise: frame0: regs=3Dr5 stack=3D before 28: (0f) r8 +=3D r8
> mark_precise: frame0: regs=3Dr5 stack=3D before 27: (4f) r8 |=3D r8
> mark_precise: frame0: regs=3Dr5 stack=3D before 26: (7e) if w8 s>=3D w0 g=
oto pc+5

Sorry, maybe it's time for me to get some sleep, but I don't see an
issue here. The "before" log is printed by backtrack_insn() before
instruction is backtracked. So the following:

> mark_precise: frame0: regs=3Dr5 stack=3D before 26: (7e) if w8 s>=3D w0 g=
oto pc+5

Is a state of backtracker before "if w8 s>=3D w0 ..." is processed.
But running the test case I've shared wider precision trace for
this instruction looks as follows:

  26: (7e) if w8 s>=3D w0 goto pc+5       ; R0=3Dscalar(smin=3Dsmin32=3D0,s=
max=3Dumax=3Dsmax32=3Dumax32=3D2,var_off=3D(0x0; 0x3))
                                          R8=3Dscalar(id=3D2,smax32=3D1)
  27: (4f) r8 |=3D r8                     ; R8_w=3Dscalar()
  28: (0f) r8 +=3D r8                     ; R8_w=3Dscalar()
  29: (d6) if w5 s<=3D 0x1d goto pc+2
  mark_precise: frame0: last_idx 29 first_idx 26 subseq_idx -1=20
  mark_precise: frame0: regs=3Dr5 stack=3D before 28: (0f) r8 +=3D r8
  mark_precise: frame0: regs=3Dr5 stack=3D before 27: (4f) r8 |=3D r8
  mark_precise: frame0: regs=3Dr5 stack=3D before 26: (7e) if w8 s>=3D w0 g=
oto pc+5
  mark_precise: frame0: parent state regs=3Dr5 stack=3D:=20
     R0_rw=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D2,var=
_off=3D(0x0; 0x3))
     R2_w=3D4
     R3_w=3D0x1f00000034
     R4_w=3Dscalar(smin=3D0,smax=3Dumax=3D0x3fffffffc,smax32=3D0x7ffffffc,u=
max32=3D0xfffffffc,
                 var_off=3D(0x0; 0x3fffffffc))
     R5_rw=3DPscalar(id=3D2)
     R8_rw=3Dscalar(id=3D2) R10=3Dfp0
  mark_precise: frame0: last_idx 24 first_idx 11 subseq_idx 26=20
  mark_precise: frame0: regs=3Dr5,r8 stack=3D before 24: (18) r2 =3D 0x4   =
  <------ !!!
  mark_precise: frame0: regs=3Dr5,r8 stack=3D before 23: (bf) r5 =3D r8
  mark_precise: frame0: regs=3Dr8 stack=3D before 22: (67) r4 <<=3D 2
  ...

Note, that right after "if w8 s>=3D w0 goto pc+5" is processed the
backtracker state is:

  mark_precise: frame0: regs=3Dr5,r8 stack=3D before 24: (18) r2 =3D 0x4

So both r5 and r8 are accounted for.

> Note how at this instruction r5 and r8 *WERE* linked together, but we
> already lost this information for backtracking. So we don't mark w8 as
> precise. That's one part of the problem.
>=20
> The second part is that even if we knew that w8/r8 is precise, should
> we mark w0/r0 as precise? I actually need to think about this some
> more. Right now for conditional jumps we eagerly mark precision for
> both registers only in always/never taken scenarios.
>=20
> For now just narrowing down the issue, as I'm sure not many people
> followed all the above stuff carefully.
>=20
>=20
> P.S. For solving tracking of linked registers we can probably utilize
> instruction history, though technically they can be spread across
> multiple frames, between registers and stack slots, so that's a bit
> tricky.

For precision back-propagation we currently rely on id values stored
in the parent state, when moving up from child to parent boundary.

