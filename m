Return-Path: <bpf+bounces-52928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC13DA4A650
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 00:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFDD3A5D86
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198421DE4FE;
	Fri, 28 Feb 2025 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvaaT/tP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA8E157A55
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 23:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783651; cv=none; b=mnTY9cb1p7/RiZI4u1Qck7nii+pUb2d7M/nd3MvoILr3CNQWlDAlf1NbFHWZdaOQgKLJ1eRSQWc1sAmCSIGME6a7rWg+i6HFnp+vNS+v7g1p0U6Pbq6ZCXEcxUWG9iXKCfHWrsoHBsx1a0EDgQMDZXCzWwKxHFvEP3dldVUIyl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783651; c=relaxed/simple;
	bh=XMdGQkgHYiXXyuXpyZPWWEP7Pihi6sQ/lE5/d0yMWmo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pGc+2pvdotlJI/oq/xIpq78SDr8FxujCphq8miUWZG1/NrgxB8pUFaShlRGsDxoE9TAPOFTWNl5KcSvdwnWXrDNGRoahZgYcfE242gugAiDkCgCj04aN1WkM3iF5IUfD0rS9Qd50xEwNR35ZvM5Rb+fZNOyFr63gb7CkDRelLlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvaaT/tP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2211cd4463cso52893265ad.2
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 15:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740783649; x=1741388449; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=INmqYdyVOlFUTLcblxSN8xR7Snpu+fT5ltE+F5VThCo=;
        b=EvaaT/tP9X8MVdm9A/3NPUxItG10mLYBb/4ZULioknaMRKhugE5QvRp8AUzAXsuszs
         YeExMcBWqD0kE2dg0D1oR8sjBzlEfciBiy5Wz3TXvNJE9ROTeSAoGUKnv16+AIAJKgVD
         tAtOiYnofH1lf2voPiiJrUikdVKzCXBF+T2N8MpZK7+/wIGMv/4OZeZEEldOuF5J5xBN
         kPnc53tH55BzUdBh3OTyNSphOS/5k1tAvFXAS11FM2bQiD3lMJAOmiAqVak7DFTb4XY8
         mAytKtY3VboYt4vhoznJg4bXq58YvLNAw1XRcdgWH5sXKriwMMki20fONm3kax6zPP6K
         oUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740783649; x=1741388449;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=INmqYdyVOlFUTLcblxSN8xR7Snpu+fT5ltE+F5VThCo=;
        b=FBuTYn6TenF6iIwVpmWjA/YLLCelbEvfte1IsHy9dEtXbj6QhVqeP5FjQXFataTqAZ
         C3svC48Jhkf8IfkC1gKQaTeBNBOAkbRE3UXlyrX8Ss3K+Gf2k0Gz1DPhC3YxgEZEKVRZ
         /YCZ+Qzh11wmZoGdhfgp6fY4YBPndc452sluXZvISIuikBiKOOnr+RKR7bSZBvJyp2wm
         D2/Nmt3b87B34FljoT4xce9d1dylOVzKV/or9NAs7KYazm1G+zi8UrkXRelovLBJESNv
         3lsz8GI2p78o6dUjt4GT4NLb8vVrBk07Bldb4do+uBSr9uZBB6S6HNI0smHMi9J9hu1D
         3rvw==
X-Gm-Message-State: AOJu0YzUyus4FqMCYAIGRe3/IgKICvhuvHozp1oLrHYACjhtqgOpLEnr
	9qXuZuVVkp86fd2jxgvqydH/A3HP1iNcY9xUJvDN35UBPXtiwUO8
X-Gm-Gg: ASbGncvqL3N+MPY4nFenCmK1uZu3/itIazrNnohUyQGN5sepfkcMLg1Lgwp4fd+5SHU
	djOrU00TCmoiyWyTJyD3OzFwaNX+rT5lrREKr6eJpTR2k2f+bzWqC1l0r0NHSFzsxoHhQBHKWz2
	JQNvx//Rr1DY4yBZzHsyRT8zP/AkRIZijnZlMc9IonCuqFzcovJz1vza7ccEiyqzutuBeJ7w8OH
	NOPgWsuKXO1M5OaN8g7ACqYnrC4VCWn8AwLoNh4Of6XL1vsDtFs6IE6KruzGGa9g70d4TE97Wx0
	KPDRhbj0bLiaNW8oyJpdcmbvnF7m6hVLSPZvRJjEww==
X-Google-Smtp-Source: AGHT+IEt0PsjTYpG1oQju/gGOH71XwC+G9+MmUp2t3tAPOsLwZiN9PK0iOE/GAXRILiZhpnFZMDGWA==
X-Received: by 2002:a17:902:f90b:b0:223:58ff:bfe7 with SMTP id d9443c01a7336-22368f61b94mr44246335ad.8.1740783649405;
        Fri, 28 Feb 2025 15:00:49 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003ec44sm4292868b3a.126.2025.02.28.15.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 15:00:49 -0800 (PST)
Message-ID: <72b29dccf20ac55e2c1652f9a3ca917719eefdce.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] veristat: @files-list.txt notation for
 object files list
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
Date: Fri, 28 Feb 2025 15:00:45 -0800
In-Reply-To: <CAEf4BzY77xkTjKvNE-T0emQWWMuNN-Z6uq16BWs1Waxzx-i-7w@mail.gmail.com>
References: <20250228191220.1488438-1-eddyz87@gmail.com>
	 <CAEf4BzY77xkTjKvNE-T0emQWWMuNN-Z6uq16BWs1Waxzx-i-7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-28 at 14:47 -0800, Andrii Nakryiko wrote:
> On Fri, Feb 28, 2025 at 11:13=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >=20
> > A few small veristat improvements:
> > - It is possible to hit command line parameters number limit,
> >   e.g. when running veristat for all object files generated for
> >   test_progs. This patch-set adds an option to read objects files list
> >   from a file.
> > - Correct usage of strerror() function.
> > - Avoid printing log lines to CSV output.
> >=20
>=20
> All makes sense, and superficially LGTM, but I'd like Mykyta to take a
> look when he gets a chance, as he's been working with veristat quite a
> lot recently.

Thanks. I'll wait for Mykytas comments before sending v2 with -err.

> One thing I wanted to propose/ask. Do you think it would be useful to
> allow <object>:<program> pattern to be specified to allow picking just
> one program out of the object file? I normally do `veristat <object>
> -f<program>` for this, but being able to do `veristat <obj1>:<prog1>
> <obj2>:<prog2> ...` seems useful, no? (-f<program> would apply to all
> objects, btw, which isn't a big problem in practice, but still). Oh,
> and we could allow globbing in `veristat <obj>:<blah*>`.
>=20
> Thoughts?

Tbh I don't remember myself ever needing this, -f was sufficient.
Every time I used -f, it was to do <object>:<program> for a single program.
On the other hand, this looks like a nice generalization.
This does not seem to be too complicated, so I'd say lets add it,
the use case will find us eventually.

One thing I do want is multi-threading.
E.g. it takes about 2 minutes to process all .bpf.o from
selftests/bpf/cpuv4/, and it can be slashed to 10s of seconds.
Per-object this should be straightforward.
Per-program this would need to wait for Mykyta's work on prepare object,
as far as I understand.
I can add the per-object version over the weekend if you are ok with
such granularity.


