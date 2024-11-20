Return-Path: <bpf+bounces-45300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90CC9D429D
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 20:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19B7DB25151
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 19:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C821BC088;
	Wed, 20 Nov 2024 19:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF0CW4lC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853A4146A6B
	for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 19:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732131546; cv=none; b=lZjwVK6JVpOv7rd1HOIhcmP0ajBOB6RdxDyR4jFbSdAqc9Xb5zqlCx5En77g5vk4QkpCLCK3/rJvho+PQKikkqFA9MclTGtt2OYZrfKj4mvq7liCuNWv122n2JxkfrBZRdcYB6OIRDYvXXRtIG4ogXgSTciEhF5Gz1SkxxpjEhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732131546; c=relaxed/simple;
	bh=BswoRCjKKXweS/WtphnFG/PL2RNKbELKMOgtRgJVRJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzr/hhZ/Rqe2oZMot7ULuaxaYRQBIe73nIdk3rkZtjrVX33HUvy/vOCYC1yybV2tQeClEng8cE0rhkLz4SGQgeVIHkAggniqf4686EEVObAPQiocH0Nran49jTiTGC4JtOx04mqxj8Vgb6Iba+DD31xv0ny3G0EhxmcjQAa9VOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bF0CW4lC; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-382378f359dso35844f8f.1
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 11:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732131543; x=1732736343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RM11PzLq5ceMIy3smOrg2SVjZbre2Fy4EJMh/VAMmF4=;
        b=bF0CW4lC1K9XQn4iwtfqLrRrLNWFmTw4p50sEbKdqlHeoPZCswU+jWmJe70W5uJJxE
         79nDye09/7d7AvHI9YM474CVbvRIPNl4F395OagvzzF5b9c/sqXWn4rpIOdQ1inQqqRM
         gWfTCUOjkYuvch77ZgjHYNsKs+6lenGM/5umbGurhi6vxL0IPLE+VXbEQH9l7S15OOxA
         7Vd/2vBpWqWNlSF0rpU/0PY/cx2wVFQr20Y96xL895aO8d4w+zVhaNghDeAe0gV5OfPx
         vYWk2IteKKWOt3vODRL/okqXVxHEarST2nQkghOpKTyLhphrU39C6K7p+ELkvPhS9CPJ
         gaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732131543; x=1732736343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RM11PzLq5ceMIy3smOrg2SVjZbre2Fy4EJMh/VAMmF4=;
        b=mX+A0m/SOgKn+YHzw6R1w2v2xocxGo2Bb0nE4C0KNjl7X0DJVQnMYb3BW5YR6et+yJ
         EOTMhU6AxgHOl3RDIzZUhX24AHez14u4x1CTnfxUkcL8wroaAabgpqXJFJ8FV/9QIZRh
         nzVl+A2Xy8ZFPAF+tklocaw8vRupZnnSVHDQv1fK5CLihAqLzsuZsCkqP83e0P4BY4iC
         hzF2a5gyocoRlyuwR223tEd5mO21mYd67NcPSZ1Y8qx32MLdyi6vTTjiAiPoFfnkCPKd
         fd9zzpjYUfszkGGxQ5+FP7rM/yTAaSX8f2HUBzJw06Nf1yrOOJ2Ury5wPqQs6x+xZXpu
         ol2A==
X-Forwarded-Encrypted: i=1; AJvYcCVp+kMOamNtecsXHfU1Lk85pRHmcWAV7AQXPIg3aHNHUxCE15mLktAiHv35bIpIumE63sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwysrjYLeX6CzrY4Wn6eORqtiBhq2fqlKidx81+N6kcEDAw1wQR
	GoCQvlddhnUeG/fOU5l1lDZbu4ftQZ6rtsAnf9tSVDbIGI8FzM3fuyJCdpC5HS8J+1xAKP6oCMd
	qyGDmJLIwibpfoPil1fwfRASzp1I0zw==
X-Google-Smtp-Source: AGHT+IGgBqgjEi6jGzOm381ZlEqxW1i1ntNqY6RtdC5veD+WMJh/KWv+Opjkka003N/jFVb7f99b5V4v0Nh8WOhaPCg=
X-Received: by 2002:a5d:584f:0:b0:37d:5134:fe1 with SMTP id
 ffacd0b85a97d-38254ae4400mr3108720f8f.17.1732131542714; Wed, 20 Nov 2024
 11:39:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119114023.397450-1-shung-hsi.yu@suse.com>
 <20241119114023.397450-4-shung-hsi.yu@suse.com> <9eb3de07-6802-426a-b59c-bb412d70ccfc@huaweicloud.com>
In-Reply-To: <9eb3de07-6802-426a-b59c-bb412d70ccfc@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 20 Nov 2024 11:38:51 -0800
Message-ID: <CAADnVQKp54gnSjw-MqGORuxpJ8Ju_JT1jQqADRkWE-ZSrSeAGQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 3/3] selftests/bpf: add more verifier tests for
 signed range deduction of BPF_AND
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 4:16=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> On 11/19/2024 7:40 PM, Shung-Hsi Yu wrote:
> > Add more specific test cases into verifier_and.c to test against signed
> > range deduction.
> >
> > WIP, Test failing.
> > ---
> > The GitHub action is at https://github.com/kernel-patches/bpf/actions/r=
uns/11909088689/
> >
> > For and_mixed_range_vs_neg_const()
> >
> >    Error: #432/8 verifier_and/[-1,0] range vs negative constant @unpriv
> >    ...
> >    VERIFIER LOG:
> >    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0: R1=3Dctx() R10=3Dfp0
> >    0: (85) call bpf_get_prandom_u32#7    ; R0_w=3DPscalar()
> >    1: (67) r0 <<=3D 63                     ; R0_w=3DPscalar(smax=3Dsmax=
32=3Dumax32=3D0,umax=3D0x8000000000000000,smin32=3D0,var_off=3D(0x0; 0x8000=
000000000000))
> >    2: (c7) r0 s>>=3D 63                    ; R0_w=3DPscalar(smin=3Dsmin=
32=3D-1,smax=3Dsmax32=3D0)
> >    3: (b7) r1 =3D -13                      ; R1_w=3DP-13
> >    4: (5f) r0 &=3D r1                      ; R0_w=3DPscalar(smin=3Dsmin=
32=3D-16,smax=3Dsmax32=3D0,umax=3D0xfffffffffffffff3,umax32=3D0xfffffff3,va=
r_off=3D(0x0; 0xfffffffffffffff3)) R1_w=3DP-13
> >    5: (b7) r2 =3D 0                        ; R2_w=3DP0
> >    6: (6d) if r0 s> r2 goto pc+4         ; R0_w=3DPscalar(smin=3Dsmin32=
=3D-16,smax=3Dsmax32=3D0,umax=3D0xfffffffffffffff3,umax32=3D0xfffffff3,var_=
off=3D(0x0; 0xfffffffffffffff3)) R2_w=3DP0
> >    7: (b7) r2 =3D -16                      ; R2=3DP-16
> >    8: (cd) if r0 s< r2 goto pc+2 11: R0=3DPscalar() R1=3DP-13 R2=3DPsca=
lar() R10=3Dfp0
> >
> >       Somehow despite the verifier knows that r0's smin=3D-16 and smax=
=3D0,
> >       and r2's smin=3D-16 and smax=3D-16, it does determine that
> >       [-16, 0] s< -16 is always false.
> >
> >    11: (61) r1 =3D *(u32 *)(r1 +0)
> >    R1 invalid mem access 'scalar'
> >
>
> Interesting, CI reported failure in unpriv test, while the priv
> test ran well. It seems to be related to some security policy.
> I think it is bypass_spec_v1, which makes the verifier to check
> the unreachable target instruction.

Correct. See speculative path in the verifier.

The patch is missing SOB too.

pw-bot: cr

