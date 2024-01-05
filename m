Return-Path: <bpf+bounces-19154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEDF825D40
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 00:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 904C9B227DF
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 23:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06B9360B7;
	Fri,  5 Jan 2024 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFPj/Dyx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99360364A2
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e766937ddso80757e87.3
        for <bpf@vger.kernel.org>; Fri, 05 Jan 2024 15:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704498743; x=1705103543; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DrTJMRgA1+YsRq2DkddSxu4KSatMWLFRDGJOn5uUV2E=;
        b=QFPj/Dyx6qN4q/wQw8Xi3RnWVvyK0AnqVlT4kD3xKjliecbnHlCbnx05KHVJXVUyNR
         ST1s7dtdtsPfrXzQP6gCFo8TeGzLC3JcGojcZJzxKCsYLCP53gugWhGSK9H/Le5KIFC0
         q4wLWOXDGRqxgzIZvvgau4es7JrKYZHAqeZ9Hcama2EJOvjOs7CT1vXqueuKB92a6W8+
         1iaNY3KkTR5MiN0owplbfgbgDvTqF/osVeWw4V/JiRTbP+V0gProSOwJoWPCo2Nz2JrX
         vsjGYLPDnQXOmXSeReGxH83LHdst5BElwCjl+lsAhFpf2tZWIjAU2cYDUXta+AD30sC3
         FL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704498743; x=1705103543;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DrTJMRgA1+YsRq2DkddSxu4KSatMWLFRDGJOn5uUV2E=;
        b=VHdOdwroY1sZfA9Bm5MpjI1G5N/wJNtvNcG+nsr6pOhTq2etVT305lljScXHFYP/pl
         KAWgtJIuuD0evLrSGwF1uefxIPQOymU7GrU0IF2TEFaAWJ3/pNgg5PJj9oRA2vn0TOB2
         0GAofqAja27KLj/1ouzBYnD32r96QkRyS9pcM8G7+ypnnfGH6dxDxUp8f13f/MmdxS8y
         DFTdRf7MGOQGPyJgaNF1ke06uKadQLAAdxbnYJw/vC0YWvUIe+OGrg04M+rdl/DD02ku
         QZb91StOEbm48Vyul+YrU6Hp1gCpmqsQGxgnsn1WPg1qMymDIcYXNvu4QrwsVR0xQ3/c
         R91w==
X-Gm-Message-State: AOJu0YwbRm1Swm3gsXGXHUL0dvv051cw0p/fhzBORAxGBsZlDtodo20f
	S7rT0++xdr150xz83FbWY3I=
X-Google-Smtp-Source: AGHT+IGX6T5OEPs5BqBKkVNZ2FedE97MxpGIHJ9Pa7tSGv5zMP9exTHs0uxn2rzKnu5uMW5hPP7arQ==
X-Received: by 2002:a05:6512:6c8:b0:50e:7ade:d394 with SMTP id u8-20020a05651206c800b0050e7aded394mr119088lff.0.1704498743378;
        Fri, 05 Jan 2024 15:52:23 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id o22-20020ac24bd6000000b0050e76978865sm365428lfq.178.2024.01.05.15.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 15:52:22 -0800 (PST)
Message-ID: <1c2e09212c4ac27345083a3c374dd82b0bbfdf2f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Track aligned st store as
 imprecise spilled registers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>,  kernel-team@fb.com, Martin KaFai Lau
 <martin.lau@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Martin
 KaFai Lau <kafai@fb.com>
Date: Sat, 06 Jan 2024 01:52:20 +0200
In-Reply-To: <CAEf4BzZ8tAXQtCvUEEELy8S26Wf7OEO6APSprQFEBND7M_FXrQ@mail.gmail.com>
References: <20240103232617.3770727-1-yonghong.song@linux.dev>
	 <f4c1ebf73ccf4099f44045e8a5b053b7acdffeed.camel@gmail.com>
	 <cbff1224-39c0-4555-a688-53e921065b97@linux.dev>
	 <69410e766d68f4e69400ba9b1c3b4c56feaa2ca2.camel@gmail.com>
	 <CAEf4Bzb0LdSPnFZ-kPRftofA6LsaOkxXLN4_fr9BLR3iG-te-g@mail.gmail.com>
	 <67a4b5b8bdb24a80c1289711c7c156b6c8247403.camel@gmail.com>
	 <CAEf4BzZ8tAXQtCvUEEELy8S26Wf7OEO6APSprQFEBND7M_FXrQ@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-04 at 17:05 -0800, Andrii Nakryiko wrote:
[...]
> > The test is actually quite minimal, the longest part is conjuring of
> > varying offset pointer in r2, here it is with additional comments:
> >=20
> >     /* Write 0 or 100500 to fp-16, 0 is on the first verification pass =
*/
> >     "call %[bpf_get_prandom_u32];"
> >     "r9 =3D 100500;"
> >     "if r0 > 42 goto +1;"
> >     "r9 =3D 0;"
> >     "*(u64 *)(r10 - 16) =3D r9;"
> >     /* prepare a variable length access */
> >     "call %[bpf_get_prandom_u32];"
> >     "r0 &=3D 0xf;" /* r0 range is [0; 15] */
> >     "r1 =3D -1;"
> >     "r1 -=3D r0;"  /* r1 range is [-16; -1] */
> >     "r2 =3D r10;"
> >     "r2 +=3D r1;"  /* r2 range is [fp-16; fp-1] */
> >     /* do a variable length write of constant 0 */
> >     "r0 =3D 0;"
> >     "*(u8 *)(r2 + 0) =3D r0;"
[...]
> Yes, and the test fails, but if you read the log, you'll see that fp-8
> is never marked precise, but it should. So we need more elaborate test
> that would somehow exploit fp-8 imprecision.

Sorry, I don't understand why fp-8 should be precise for this particular te=
st.
Only value read from fp-16 is used in precise context.

[...]
> So keep both read and write as variable offset. And we are saved by
> some missing logic in read_var_off that would set r2 as known zero
> (because it should be for the branch where both fp-8 and fp-16 are
> zero). But that fails in the branch that should succeed, and if that
> branch actually succeeds, I suspect the branch where we initialize
> with non-zero r9 will erroneously succeed.
>=20
> Anyways, I still claim that we are mishandling a precision of spilled
> register when doing zero var_off writes.

Currently check_stack_read_var_off() has two possible outcomes:
- if all bytes at varying offset are STACK_ZERO destination register
  is set to zero;
- otherwise destination register is set to unbound scalar.

Unless I missed something, STACK_ZERO is assigned to .slot_type only
in check_stack_write_fixed_off(), and there the source register is
marked as precise immediately.

So, it appears to me that current state of patch #1 is ok.

In case if check_stack_read_var_off() would be modified to check not
only for STACK_ZERO, but also for zero spills, I think that all such
spills would have to be marked precise at the time of read,
as backtracking would not be able to find those later.
But that is not related to change in check_stack_write_var_off()
introduced by this patch.

