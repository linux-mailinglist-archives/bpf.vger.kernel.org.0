Return-Path: <bpf+bounces-57099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D07CAA57F1
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 00:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33AD50168E
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 22:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF022253A7;
	Wed, 30 Apr 2025 22:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBpAk7LL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413AA224B08;
	Wed, 30 Apr 2025 22:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746051808; cv=none; b=Ns9YsFiZEvGEFGX0njosJZ4jtUGE2MMFP1iEnf/QcrdtSNExFoSKP2HT40Fkm9oZah02zu6BOwVsa0HZ2UazQ0/4wPcgnKqHcSGdAKMypR9+Dlejgqa7hTteFzKvjpPw44bETNsGf7azoiLsm6L3prJ8WrZQGdQXGnPdVBqLkfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746051808; c=relaxed/simple;
	bh=VZuKXxzGldX9LzIaU6VctUQqnQ8tlMc4yK/+gYxDzoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxvUSj2SEwh+3lzA0cHaCWb36OxIZScVzv1B3DVNgT4SFHoR3DLZdeSkLmw1dRJztQ+kPKYVqpnqYDfr5QTUvneT4F0rzAVHH+bO96L0H97xY0xQ5FjhhqUvMLDPPkop+PMRP2VnP9Sh1pwwOUqGEFrFE+1M/oMU5iiMOv58y/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBpAk7LL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3913d129c1aso275123f8f.0;
        Wed, 30 Apr 2025 15:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746051805; x=1746656605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rg0uI63O02c4p1iLFOA5sNNvoK/KA8q0xPwjloWtPkQ=;
        b=cBpAk7LLEIVKo3+/2mS6/KRTi9nCm3Qx/6q3VLs78tUy+v72riDtmkpuknvS8JVNpT
         ccK1qGwBx9r+VHUqfkFjHDgwBpRTYavR4Y1VMgba2KWsiwRvHNjJwlGo5Kgs8nwIS6md
         XyZTbfzzOFLEbrU4GXtbOl9Uf5HAeVE36T+RJJTB7aoeMcrPNFd0DudAbybpueuIiPzX
         F/X7MAz8o/E+1ERixz3rvEq3O09Pc2bH18AKu/yb5oZ6s4qb9ixlzWQ0gIlA6193O1dj
         r2/cgHjAPXPOWWGp6WSGbcfvsyTmvi0A25gv28l/eSIApm0FnShOZA1d+PTzUw5ficSa
         C3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746051805; x=1746656605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rg0uI63O02c4p1iLFOA5sNNvoK/KA8q0xPwjloWtPkQ=;
        b=W12TUoYnfnD3IMArSEQu2g6yinP5yJtseZY/2wU7PRXR7b0Z0y4Uwz1U9R+Ww5Mbgu
         3HRe9lFSasgfhnesPMZ/9fn62xP+jqpNpB62Y1ytyHCVjMm7Bv0xwTsO/iWxxA4j1Diu
         VRMJde6Vr5y06t5NX9LpT9KpDA1qWwxgvFeZ7Bn14PnOFtncWe5PmoyzFbP6u5scsO66
         kwURQ23N/JzbyHkDAXOc3s3IKFRGMjZ32mutzD0SsMdKVEoNFXtU4v5ZkXkA8cGwY5jC
         F/Oyct6hVh/Rk9ILgVIRqXRTccbW7HMD4kNHiNQHOSjL6uwvOxNBCQ0lzYFiHIhquBD1
         P5sw==
X-Forwarded-Encrypted: i=1; AJvYcCVhRwnQ/nwF2+NDHf/RaGdz4mpszv2G6/4xQqGewIvJYzk+dTaWF9e97GygKnijJELiPyI=@vger.kernel.org, AJvYcCVt/a3Y6fjyQWuu4xNsp9AbIAkJtL6gsbN6NseLiPteL0bm74AQB61/fmhoIEhRwGnMOoKV1JEpWj3MG3bO@vger.kernel.org
X-Gm-Message-State: AOJu0YzC6xxsgmFnKAmTwgkhoFJRjuPRZ6zJIpVNn40V8n/Unmd1H8Zt
	OTQFRIMbKXdeFUvqK9dvJkA1Xl2jo6FNKJepb8BDvlexyu+DyCo3ZUevpyukz/CZAgV37abrH8T
	nWH390/RKh4oAutaRW7z/wUcnL6g=
X-Gm-Gg: ASbGncsGfYOiSOnXD5mfe80Bz0UDOdl8E000EWLxRBsNklDT4PIC7d9tPC87UL0gVo4
	K8fMCk7CPZtmf4y3r0464TAZ2OZqh/AEs978L6jMxCqxuWS6ziUfhS05KBB71Au3mfgpo2e3v2r
	A9Oh4dfJkOLkk4MJn78CyCghs+rX6OibJjthyNYw==
X-Google-Smtp-Source: AGHT+IGG+ERnGBJDsqMmUKI+z3+e6TKmbtoa8e1pOeIPXcVWLGApDN892M/K5ZLlVJHpeA4YTuSuAAp910s9QJ1uPUE=
X-Received: by 2002:a5d:5141:0:b0:39c:30f7:b6ad with SMTP id
 ffacd0b85a97d-3a0941d0e2amr73815f8f.18.1746051805238; Wed, 30 Apr 2025
 15:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430164608.3790552-1-chen.dylane@linux.dev>
 <20250430164608.3790552-3-chen.dylane@linux.dev> <4cabeaa5-0a6f-4be0-89c8-b7d0552b0dd0@oracle.com>
In-Reply-To: <4cabeaa5-0a6f-4be0-89c8-b7d0552b0dd0@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 30 Apr 2025 15:23:13 -0700
X-Gm-Features: ATxdqUGMrbdUTVhckpjhHQmx8C1KMqLLH-63CvU0GOSOJBqE-qFUAuM0Llfyoxk
Message-ID: <CAADnVQKPLH7q2KcJM_Nkgc1z=OZmOPZes-0c8A-5gty1xEOKzA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/2] bpf: Get fentry func addr from user when
 BTF info invalid
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Tao Chen <chen.dylane@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 10:57=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
> > +
> > +                     if (!addr && (prog->expected_attach_type =3D=3D B=
PF_TRACE_FENTRY ||
> > +                                     prog->expected_attach_type =3D=3D=
 BPF_TRACE_FEXIT)) {
> > +                             fname =3D kallsyms_lookup((unsigned long)=
prog->aux->fentry_func,
> > +                                                     NULL, NULL, NULL,=
 trace_symbol);
> > +                             if (fname)
> > +                                     addr =3D (long)prog->aux->fentry_=
func;
>
>
> We should do some validation that the fname we get back matches the BTF
> func name prefix (fname "foo.isra.0" matches "foo") I think?

I don't think that will be enough.
User space should not be able to pass a random kernel address
and convince the kernel that it matches a particular btf_id.
As discussed in the other thread matching based on name is
breaking apart.
pahole does all the safety check to make sure name/addr/btf_id
are consistent.
We shouldn't be adding workarounds like this because
pahole/btf/kernel build is not smart enough.

pw-bot: cr

