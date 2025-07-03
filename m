Return-Path: <bpf+bounces-62343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B586AF8294
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 23:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3778B7AEA28
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 21:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63862BD595;
	Thu,  3 Jul 2025 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R70/mwLK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F4E1C6FE9
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751577936; cv=none; b=pbTDgwmQu60KhVGvzsStfiy5GyUjsak5/MBDoBs2I5d086uFTyj9x29eTwHnBM+fo2KTdBc3fNpZ178dBH96K1l4PsE+ZZiom8D9zskBfiydTllftWsiOUImkkHpuA02i/Dmc+K7RtFxnTxpO5i2KDZOq+Yt1+n9y6Q0GzeeYi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751577936; c=relaxed/simple;
	bh=I2LiXzad/RapwcCe1ASUPpdQNnm7ORSSUQGsUvOfKkU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t0zMTFh0GCZARf80GAgGN/6Hfor0hoeXHkeUa38wRg/8slgZBoJCfbwiNdYMdYff/Xd4ZEcmDKlyjtgZ9QI63kronztt+m/d5LuPjX46kxMmnZA2NMW/IVXMXFlG0ciNPrinbkFsLJqzctQc/lB726rxfzXCV32NjOYTzmNhZhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R70/mwLK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so518378b3a.0
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 14:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751577934; x=1752182734; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iJS/SeN/MIGaX2KxPpxlHub0/CreqQjSnF48YoIaiII=;
        b=R70/mwLKnhOcsmafmKvKtObDlXJ/AILZl5beDJNSPjjlEDedWta8z2ju6Zpb2v5rBv
         eUuoat512/VJl60XJQy/CyGlVQXw5khJY5DRPoXevP+PTU9uC67FLUCQolKQvs62ABph
         GC11cT9eVcdYwaG+hZSEaSyiv1UZjDuiKUtMGu2F5Adl1PRIEi/lj94NNg0dtx7cSPgp
         uRRhG1aiBIJvWgmh0VCwgOaI1q8LQwiysF2zylqRIWxKnGXWz/z5BmbG4bFRvcp1H84I
         mYJw8Nctwrcrq6VjHdQUFax/Sh28pLFZMss/hW/gyLP13Y6tgdJpklwosGug6fyG9ib6
         Y9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751577934; x=1752182734;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJS/SeN/MIGaX2KxPpxlHub0/CreqQjSnF48YoIaiII=;
        b=wt+Nk87gF8JsPrCscaNjRohT3LB1+yU1EBv6OdzHAToSFBLf7jlNpM6FSetn/FG5Qh
         hMH+59Jy0PkTFzPmjEvRUG2jeY1FOdflJtkVbqJKHircQidG5Axq3be6y8JRCJKpxMC9
         hAceNpGJe04f7r9Y2Edrxn4dHLHf/ZTZSNkz8SjA26htgvvM+NZUuxOUkXpq4CauJH2l
         9emVBlcFSg01HFPHwtrPjrAdkldQXMliNET5CWRwCRNWix9Uj+/WBjLDlILcd88bNRtt
         /ksROxj9XSztUzspuxSwDkEDCjbs4Qf7JAxzioikAaUHkT9aYJm+0NUgYWE7MFcDbgyc
         9+zw==
X-Gm-Message-State: AOJu0YyZOU3Nkdm9RdWd9+ljF0ykOn+YvVn6yMCgxlMVSKsdbxtmw+gV
	hrjRsNOQrwa1UpiiuB5eAJiB4+Ixfxr4Pb1AsEXLNldcez6fipXZ+CHE
X-Gm-Gg: ASbGnctvHiwc8mHeXZ3DPBF0YrJLykTJwQFIqDtFw46/yhg8Q+a5QzWpzzVli1FBMnP
	FR9aIR59Yw8ZfIFDTg182JBhAaCqKJ/8nzB4ijDoh59jy34LkU1wNUIojkh2MuOnGDxuoddDTrU
	4GAS3BbNuTOu/c3nuWBPtwmLTsY3h1LCEslSt/MGsQwpE0oSua04hVdBO9fiGppUNfdvcF8zHnV
	vKuHCeLA+xZpga0wYGSbboCx42dtRk6wuUygpNZTKCJM803ofkp2EGWR2zSqDO4qKbqBACOtbC+
	4OZbSBVMvuR7TF4d5PY9Tqh3mxtB+bImjAna4dIWWToZMKz4n+dfGEUCVgOWLEFQ7kk4
X-Google-Smtp-Source: AGHT+IH6eYqjQ0RJkSFtT7AjdrLaXlKwXUTViOgRlNUtcZ9OXLVCrrYKehdLiHt6gJPDiyNeeJZJAw==
X-Received: by 2002:a05:6a00:4b52:b0:736:a8db:93bb with SMTP id d2e1a72fcca58-74ce68cfb98mr287274b3a.5.1751577934350;
        Thu, 03 Jul 2025 14:25:34 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::647? ([2620:10d:c090:600::1:90c4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce359e90asm399487b3a.6.2025.07.03.14.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 14:25:33 -0700 (PDT)
Message-ID: <7e8e074d1b76565acf251033fcb963cd7417741e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 4/8] bpf: attribute __arg_untrusted for
 global function parameters
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Thu, 03 Jul 2025 14:25:32 -0700
In-Reply-To: <CAADnVQLRL8Vuh_VGAqSF_MhcsHhOvfYFurGoGiC9RfAiGJcbZQ@mail.gmail.com>
References: <20250702224209.3300396-1-eddyz87@gmail.com>
	 <20250702224209.3300396-5-eddyz87@gmail.com>
	 <CAADnVQLRL8Vuh_VGAqSF_MhcsHhOvfYFurGoGiC9RfAiGJcbZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-02 at 20:18 -0700, Alexei Starovoitov wrote:
> On Wed, Jul 2, 2025 at 3:42=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:

[...]

> > @@ -7818,6 +7821,22 @@ int btf_prepare_func_args(struct bpf_verifier_en=
v *env, int subprog)
> >                         sub->args[i].btf_id =3D kern_type_id;
> >                         continue;
> >                 }
> > +               if (tags & ARG_TAG_UNTRUSTED) {
> > +                       int kern_type_id;
> > +
> > +                       if (tags & ~ARG_TAG_UNTRUSTED) {
> > +                               bpf_log(log, "arg#%d untrusted cannot b=
e combined with any other tags\n", i);
> > +                               return -EINVAL;
> > +                       }
> > +
> > +                       kern_type_id =3D btf_get_ptr_to_btf_id(log, i, =
btf, t);
> > +                       if (kern_type_id < 0)
> > +                               return kern_type_id;
> > +
> > +                       sub->args[i].arg_type =3D ARG_PTR_TO_BTF_ID | P=
TR_UNTRUSTED;
> > +                       sub->args[i].btf_id =3D kern_type_id;
> > +                       continue;
> > +               }
>=20
> Looking at this hunk standalone (without patch 7) one might get
> an impression that odd ptr_to_btf_id is allowed that points
> to non-struct type,
> but patch 7 sort-of fixes it by handling primitive types first.
>=20
> Still, I think it would be good to add a check here that kern_type_id
> is a struct kind.

I'm adding this check, but it will go w/o a test:
- unions are allowed by btf_struct_walk, so need to be accepted
- function types are anonymous and candidates search wants types with names
- float -- no candidate in kernel btf
- func/var/datasec -- need a corrupt BTF to sneak these in.

[...]

