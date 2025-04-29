Return-Path: <bpf+bounces-56878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64655A9FE47
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 02:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C80DC17B12F
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 00:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6373594D;
	Tue, 29 Apr 2025 00:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALL+Px5H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1A4134AB;
	Tue, 29 Apr 2025 00:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745886843; cv=none; b=J7eOZ8f4xTcd60ZIEP2lBFb4FJqFVitblJSTe5yw5poxOANDc7PymWGLn8xx/nhPzSfp2wjGytxB2AyV0oIR0ylRZzsCC/L/gp4hjS7E6jOw8CFHYsnLwNcp/Jg/9mMidjrjZcH7fgLr53MP6/DAa+D6dyVaTBl9+YAJA7GLU6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745886843; c=relaxed/simple;
	bh=6+YgWzE94f6DFKArKvw57NHkCdoZS7XElwKISdI97WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8CCSEsdoUTVBmSUFxnP9q+JmxaGBl+gt7pA/syGaX8j1bj/w2gFqkDGFrTxUHUs7w6kAtHHtHRD9DTbz3+HK39dGeS+qqIP3JgJcgnETLeTo1rm3DkE83IAh6//yzBljZHNVDLAlnVKA/Dw/XPnYV9Qdo3fGQFEz9lu+dKGuf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALL+Px5H; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736aaeed234so4556472b3a.0;
        Mon, 28 Apr 2025 17:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745886841; x=1746491641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PV2GiOZFtKQXLm59tApkwOLisNpG3bGPbYcr4d5QzH8=;
        b=ALL+Px5HXSNy0Ed7KeHGuo8rCAHutQAk7XHU8NiVY35kvHLB9nym2OojVq77KVU5ZD
         jPUX05mCSgQx10J507MdJDBK/Pnh3UiHFGTdibR4Y9er8FHELJp9xMQvoE0czSTk7Ufr
         oFjy4KrDhWx1q0sH0ouXNV2fgOA1Ov94wI2gev3FPH1kSFbdGbc5d+dN0WgAeo3nBNgi
         R1odKg/MR7hKKNe1wJ5pqnW8SEwZQkVDnJXFfS/MkOFwJuBCQYmEZk6XyhJExjx9nfYT
         00j1BN38Fng0ZyNHViqN3PxcXJVsR0cfEN3EEkCvPOpfijfEv055b4tfIV2PktKZyvQR
         kH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745886841; x=1746491641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PV2GiOZFtKQXLm59tApkwOLisNpG3bGPbYcr4d5QzH8=;
        b=WW/WxeGfUAMM0UBJLU9CzMzsEcxrzj5ciC3IuCoKIsAQ1A/WbkMtmnOyUeqPBvxOhE
         HpvIH6h7ssWh2p3lZKTFAbFBJ+KvNvUToQlh0ylA7+aGjSmsvkDlPlCbUXxPXcuQmgLI
         qAzsUUcN4Yn7cIOWUzhw3+s2QXDlOv9+6XdmuE64tv4cpNDXw24DqKszzrVleBqsxHtA
         rSK2xxN8TH4Qk4elFOvocb7YceXDTwbUlNUjMDCyh9zbnbGqKCUzRJDdKM2x/7vboyH4
         SnA+dWxfV6ocTiC/pUH1/z9ejzUt5C2HMs4uRAxVZhlabvBRCFsx+rl8bSF+RFQUgaam
         Zu7w==
X-Forwarded-Encrypted: i=1; AJvYcCU00e2JqX7hQ44+CenvdmMz6eDlVOvoPvhaGqh8PKgiV3rMtcfTTNEdyIOEOgPz6jx43jI=@vger.kernel.org, AJvYcCVl4Kn1cA2fjvbmRcwAD/mSTAseDpWJHf4oYvKVniDIvzQ/NepyZmD8MzWZ582OfjP1+Ghhc4nxlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSO+XtWRxiFN1pqFKCrVnT2NHQgA0pO2zRCETFoKQcTr5oFeuO
	aNbl+zhOYtmXPc8encc20UQEMbu/5S5NCQpxjdlOejnDlI9PbIcU8rNZ/xQ6eWeGyOqkre6dZWW
	I9GbyP5eqqLVmgwKhzLTlgFRoGLIJP2KM
X-Gm-Gg: ASbGncuDqc3gugmBLZVJqUk2YII1yyynv/UOTr0NC6VZLZzqC+x9SprVdM70/tgOl9t
	mIbXWBo1OkRBLRk8UerPX05F3rUL2PoECY2tsjEAq/3vf6jU4Ja9NepMoqQ2HnoqhGKVcNpLVH3
	ugdVp24DWwG0lu4qyzyGhH
X-Google-Smtp-Source: AGHT+IFRlE1MytSDRz0rZzuiCCUMZ0W4Eisz97ON28ZSh/CjrnHHASN8wiDF8au1WzdnAWJGawvF9Nvg9IiE8RJhAbk=
X-Received: by 2002:a17:90b:394d:b0:2fe:8282:cb9d with SMTP id
 98e67ed59e1d1-30a2158ec37mr2800349a91.28.1745886840529; Mon, 28 Apr 2025
 17:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
 <076e52f6-248a-4a41-a199-3c705cb3d3c5@oracle.com> <CAEf4Bzb9ozx056hm3=zh=4Sh_62EydK_wtJkNpgH9Yy0cuSsUQ@mail.gmail.com>
 <4aa02e25-7231-40f4-a0ba-e10db3833d81@oracle.com> <CAEf4BzYRnNGGafWS8XoXRHd3zje=8xY1o5_8aVw6vxrUSbEehg@mail.gmail.com>
 <c8c4dc05-7fa3-4c1f-a652-a470dd6985c7@oracle.com> <e279abde-f4c1-42d2-bcc0-4df174057431@oracle.com>
 <CAADnVQKi4DARfzQJguZyDQsfXHq7A=QM2FwRwpZe-LJzj+Ujrg@mail.gmail.com>
In-Reply-To: <CAADnVQKi4DARfzQJguZyDQsfXHq7A=QM2FwRwpZe-LJzj+Ujrg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 28 Apr 2025 17:33:47 -0700
X-Gm-Features: ATxdqUFxWXf3fdlvv5q_xlGtBjqIbdgROGAgac2Wpqm2-tPDXBnmXyk2JUvToO4
Message-ID: <CAEf4BzYt2sUxRPAR5AbAAXVcOeC2UqgkR24WDEZAAd+kEz=g-w@mail.gmail.com>
Subject: Re: pahole and gcc-14 issues
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 3:12=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 28, 2025 at 8:21=E2=80=AFAM Alan Maguire <alan.maguire@oracle=
.com> wrote:
> >
> >  <1><4bd05>: Abbrev Number: 58 (DW_TAG_pointer_type)
> >     <4bd06>   DW_AT_byte_size   : 8
> >     <4bd07>   DW_AT_address_class: 2
> >     <4bd08>   DW_AT_type        : <0x301cd>
> >
> > ...which points at an int
> >
> >  <1><301cd>: Abbrev Number: 214 (DW_TAG_base_type)
> >     <301cf>   DW_AT_byte_size   : 4
> >     <301d0>   DW_AT_encoding    : 5     (signed)
> >     <301d1>   DW_AT_name        : int
> >     <301d5>   DW_AT_name        : int
> >
> > ...but note the the DW_AT_address_class attribute in the latter case an=
d
> > the two DW_AT_name values. We don't use that address attribute in pahol=
e
> > as far as I can see, but it might be enough to cause problems.
>
> DW_AT_address_class is there because it's an actual address space
> qualifier in C. The dwarf is correct, but I thought pahole
> will ignore it while converting to BTF, so it shouldn't matter
> from dedup pov.
>
> And since dedup is working for vmlinux BTF, I doubt there are CUs
> where the same type is represented with different dwarf id-s.
> Otherwise dedup wouldn't have worked for vmlinux.
>
> DW_AT_name is concerning. Sounds like it's a gcc bug, but it
> shouldn't be causing dedup issues for modules.
>
> So what is the workaround?

I'm thinking of generalizing Alan's proposed fix so that all our
existing special equality cases (arrays, identical structs, and now
pointers to identical types) are handled a bit more generically. I'll
try to get a patch out later tonight.

>
> We need to find it asap. Since at present we cannot build
> kernels with gcc-14, since modules won't dedup BTF.
> Hence a bunch of selftests/bpf are failing.
> We want to upgrade BPF CI to gcc-14 to catch nginx-like issues,
> but we cannot until this pahole/dedup issue is resolved.

