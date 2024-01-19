Return-Path: <bpf+bounces-19867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BC88322CD
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 01:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63CC61F238DB
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 00:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20143A23;
	Fri, 19 Jan 2024 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQOKP+u/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EB71362
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 00:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625646; cv=none; b=OVlmJCjV0eci9CL2oPtBYSih9F2u91tpAHzwKT7yrXZ/fvAfD8HHIc4EWjjFsfRiEvitQMvshRQLXRWPjd7c+TjflLrhgzMV9o7Ulj1VWi3UgKByRnCHleRbwjm35LfciARPCyLARMQ86w1VFCOT4BRyxzpKISwbbcy37FaD3n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625646; c=relaxed/simple;
	bh=++h7uHjzctQZVDB0zfZMz1ozf2kcauHqQvsbSi+NgLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7uPappplEv9FDVLkidLSMVMQcwihNHz03aeUv4erP0uREcW+LatufXk0Z3P6Waw5e98VYpVyhKmafkY10RpIcKK3CiaB4/8fmXBOvNEAonUA75ru9uaF5njB3dkU6c5xY4t8fi48iPLGZyPtjlYPWnAxETIabrco6PmGGgk57Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQOKP+u/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d9af1f52bcso245487b3a.3
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 16:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705625644; x=1706230444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ptj1pScdK/DEc1VZYYvpL2hDMIGK7Bbi70ZJIjrwEI=;
        b=hQOKP+u/blu76c0hfRpPNP6rooiOclM+2X3a57davHqYi8AKY+52XI0Vc2rpNu77DD
         /qv+mwtiKyba6qY1jvA5ZXvTMXxqtLWL4pMLwETHv2kSzw00ijDCM9Vq6hc8eyUGbR9u
         cfUqT7XbdffP6C0Vx7dn/aUwsREYpCGoOAmIx9y0mprcx3Wc6gQB63T2Muf8AqYSZ7g+
         +dsz6KKYFb7kzUM66TKZGS6gX29Ad/FcGCXYrpQZOBzH/XdPuRJ1LaERlLHaeplMs4Yf
         qkozUtlsf0y+HwTrmRk1t5/hJ5RMBEFd/hsaiIDSFroyRxVYTVDREfzeTpGtyPUGyl28
         aHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705625645; x=1706230445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ptj1pScdK/DEc1VZYYvpL2hDMIGK7Bbi70ZJIjrwEI=;
        b=cmQMHNXblMpZbEqVj/0OEfFZI2OGRs+VZ0eUgnirCVwUTkFs1Ps7fzsshJSpzXEToZ
         iyIqZvXrZYndyL/g2XdGsji8qmE1IBRHcu3ittuS9McQ0I7XFkfCz87vAaMY6LTdNQCD
         M29e9TlhOErcb562x6cbQWh7/TQVUaod0Z/wQ8iOjNdxlu6DteKRnRSpiGwf/QelLOIG
         maSxdjrnz1QdGIoUqs/TCZgTmMdEQfTTE7OHtlsgOfu67g+JK1lS3OA2GwVbUy+PYPVa
         DfowMzXq6HKJsSjjh2IIoSmsxdpXcGZTChUHgir5V6FFKD0xKKtbND9baNHlvqs6UVDW
         2WKw==
X-Gm-Message-State: AOJu0YwEv66hhlK3QPVAL/WWDHG6uIYXuL5StqMTGsw1qS8dC5rc/Mna
	A5A+avGtypEYOfbiWzjs9XuoLup8QsoKerYulgbdvrUIA2JicSJ2081oY1pAZyo36pLcixq7eZb
	l6tITxYp/Min7O73rpZazujJuNjitJ6Aom54=
X-Google-Smtp-Source: AGHT+IHd0fX32HaRF0/vstZun9HE9jIKAJG5rwg9HqYu7nLqWDVqPVs7BraL9tZ7Hvg3Hj57oQV97cvR3J0sGmBe+2g=
X-Received: by 2002:a05:6a00:2d01:b0:6d9:b8e3:8f28 with SMTP id
 fa1-20020a056a002d0100b006d9b8e38f28mr2050360pfb.44.1705625644637; Thu, 18
 Jan 2024 16:54:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117223340.1733595-1-andrii@kernel.org> <20240117223340.1733595-6-andrii@kernel.org>
 <e4a6106a0b4247cbf83c2311e60f69b10ef1517b.camel@gmail.com>
In-Reply-To: <e4a6106a0b4247cbf83c2311e60f69b10ef1517b.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Jan 2024 16:53:52 -0800
Message-ID: <CAEf4BzbRfMx5s9YvjHkQ+yjAd8EB43Lk_jg3Jg8oEnt=pjr8FQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 5/5] libbpf: warn on unexpected __arg_ctx type when
 rewriting BTF
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 11:50=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Wed, 2024-01-17 at 14:33 -0800, Andrii Nakryiko wrote:
> [...]
>
> > +     /* special cases */
> > +     switch (prog->type) {
> > +     case BPF_PROG_TYPE_KPROBE:
> > +     case BPF_PROG_TYPE_PERF_EVENT:
> > +             /* `struct pt_regs *` is expected, but we need to fix up =
*/
> > +             if (btf_is_struct(t) && strcmp(tname, "pt_regs") =3D=3D 0=
)
> > +                     return true;
> > +             break;
>
> Just to double-check my understanding, in patch #3 you say:
>
> > for perf_event kernel allows `struct {pt_regs,user_pt_regs,user_regs_st=
ruct} *`.
>
> Here `true` is returned only for `pt_regs`,
> meaning that arch specific types "user_pt_regs" and "user_regs_struct"
> would not be converted to "bpf_perf_event_data" but "pt_regs" would, righ=
t?

yes, it's a slight deviation from what I ended up doing in the kernel,
because I initially didn't know how to deal with arch-specific
definitions of bpf_user_pt_regs_t. But at the last moment I figured
out that __builtin_types_compatible_p and forward declaring structs
works, so I'll do a small follow up to libbpf to match kernel logic
completely

>
> [...]
>
>

