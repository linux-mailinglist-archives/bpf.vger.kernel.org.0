Return-Path: <bpf+bounces-54376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED068A6936A
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 16:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992CB1BA34DD
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADD921B9C0;
	Wed, 19 Mar 2025 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDaDc+xj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925251DEFD7;
	Wed, 19 Mar 2025 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396153; cv=none; b=t4smvNPzQmxUI+uet5S+LddicLtkoXUdk87oU+7qeYwwdt+VA9UacE+LNmaRndEqfBUj4iOHgCyd0aGlfnxXJT9EaXnELNZhLTnD1pApPk5O1HaPc8/njZCUaKfTW419MzYIxIPFKcOhthdQIYu9OBmPMYASH7uvTnjaMAP0u84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396153; c=relaxed/simple;
	bh=cqlvzY55RcwBDFprNdjw52JF3DSZ7waUI40/fMoYc1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLP9AVdDsZEhjfuPnfwyJqCNV2L/ss6obFdprMydiTS786Qhe7ZbpJv+HAK4IE9e+xuaEDPmDyvnN88tTmdgB/2w6guP1m8b+lZsmhhxBv5gxRdoW0ueKf2t2H5FWnHso7FMz6KBL8BzlbA/Ok61BJhiEqInDGu6XTHoQ8/mnXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDaDc+xj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so31478885e9.3;
        Wed, 19 Mar 2025 07:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742396150; x=1743000950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqlvzY55RcwBDFprNdjw52JF3DSZ7waUI40/fMoYc1E=;
        b=iDaDc+xjqcmW12fdXmNfysGPv9rHR8V6Gt3jU+Vj9tQiidGInxfb5bO9vl9oo/m4Ry
         LhH2Ip1IgzJ7zvUgV5JDKE8DMF4Xa3amrKjqvWqM5h+SQIs+AzuSl+dBWezf3Rv/4nxs
         z1zP2NEJ7jfYzuezTKPoQcuqb4g7If0HYkPbe94hZJtQjmUKRDkPcqtrhQXFuIPstcr9
         GutAgGbiwK1L5n9T3e0Y1eR3j5S+iThWmbKP0T0ugAS/VV3T+IFOutPgYBZFqoVVTv0T
         YFJv2XJ0voKBNK7SAG01vTJKpxPBt4CAb1yeKdNbpEe7fs72pJBVAaIsMaqA4lHrTm5F
         lIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742396150; x=1743000950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqlvzY55RcwBDFprNdjw52JF3DSZ7waUI40/fMoYc1E=;
        b=mw8kEwzgjFwpZhrJ8eb4JZ0yUqXPAYVUetmzsUDoAh1ioNvrOZfCnI0V3ReogqPzEp
         6YutrD+EOBpwIWMupSX3Oej1BOmzc/RiCYCP6yGqKcO4ZuvHRq1D0etnTYEdpJBVmy15
         eV3HAM2+ygWkoxUy5lHBQNyRj7odhBfvz5YClwOsCn7eLLsEGcK0yodbVX5UpSQ+tQlF
         VkJZQX9YaciZZFJLCl3kgPm4qNdTlAUWS5YsRPyqL+b3f9zRpU+Znk0PHvB5gQILVLTf
         63qtHAjLBmxdmkaik4KYyuzB4N+e0eDIVSmzvTlrVNFjB1o5W4fJ64ve04WdmIN6Xcu8
         ffIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7UhxPc2mEDTR0F2k5NvdNjj5Vj1KV4nUWqr5NfNcKP5QmbmY9rNUpcoSf2QngaQ1HGo3OQcznnzlq9w==@vger.kernel.org, AJvYcCVHV5BSE445FJw6KSV+jX8R27IiHu6v+FabQMytefA3V7R8flHfaigJoiFevEqaueBLe+M=@vger.kernel.org, AJvYcCWL6OfAaCQcawx+G9RbcQmXcLrVP3Q6k/mnxGYYyNU8OdaemECCeEU8Nlw5w1WLmYltHD3itNeMTvfNKCe1@vger.kernel.org, AJvYcCWmJmtQo/X89AZah0t/a8fEnkWCgfeMsLg+92aIH21d9gYPSnEB70xecvLOS8s4YHuGbSHW07Op@vger.kernel.org
X-Gm-Message-State: AOJu0YyoVN/5w4gtacK1hzGySVME2TKTCQVYoZE3lMd+qrkTXv1jn9th
	eA/FQfn0sNFw9OECFuHTpHkbsjFjb1s+Z4GTBf6VmN3+7UKmsM8RWnoke/xzQ5CqESlhezTS7wH
	WOdB1AhdPYYQAKzcFnU11O03OGfg=
X-Gm-Gg: ASbGnctBe0PN9PVxAzUpltHy1oBcGHAXrQf/2ZK1U6Vz4LoYni3NYhyvMEwVaRiZfk1
	8LqtQbHsBBywfAh5b4AH74zuovA5Wz34IV/SFY4IVP2aBVQF/6BipHTYAt52sLnru8zKOf/n7Mh
	G4MgDamOAfh0A+IIptgRukLtcqejP5WJv4s4tbVPHC272uaMPkNi9f32HnBhY=
X-Google-Smtp-Source: AGHT+IFYLJulgyA42kMSpPcMFV1BLWkjwnsRvgCvCmWo2WTkZJgZ47MI8MQWGFGPtZ9EU0QvFVF22Njp4qnWSDBleeU=
X-Received: by 2002:a05:600c:1d15:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-43d4378b3ddmr23619225e9.10.1742396149442; Wed, 19 Mar 2025
 07:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319133309.6fce6404@canb.auug.org.au> <CAADnVQKotSrp8CkVpFw-y800NJ_R7An-iw-twrQZaOdYUeRtqQ@mail.gmail.com>
 <CAP01T76CqOxzEiMLKJ2y_YD=qDgWq+Fq5Zy-fnKP4AAyS30Dwg@mail.gmail.com>
 <CAP01T77_qMiMmyeyizud=-sbBH5q1jvY_Jkj-QLZqM1zh0a2hg@mail.gmail.com> <CAP01T77St7cpkvJ7w+5d3Ji-ULdz04QhZDxQWdNSBX9W7vXJCw@mail.gmail.com>
In-Reply-To: <CAP01T77St7cpkvJ7w+5d3Ji-ULdz04QhZDxQWdNSBX9W7vXJCw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 19 Mar 2025 07:55:37 -0700
X-Gm-Features: AQ5f1JrUGFyb55SOF2EzAAJYS9bLqfvB0QpPJ5iTTYTfSGUGnuhAmOsJWefBzbE
Message-ID: <CAADnVQ+8apdQtyvMO=SKXCE_HWpQEo3CaTUwd39ekYEj-D4TQA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Uros Bizjak <ubizjak@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 7:36=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> > >
> > > I've sent a fix [0], but unfortunately I was unable to reproduce the
> > > problem with an LLVM >=3D 19 build, idk why. I will try with GCC >=3D=
 14
> > > as the patches require to confirm, but based on the error I am 99%
> > > sure it will fix the problem.
> >
> > Probably because __seg_gs has CC_HAS_NAMED_AS depends on CC_IS_GCC.
> > Let me give it a go with GCC.
> >
>
> Can confirm now that this fixes it, I just did a build with GCC 14
> where Uros's __percpu checks kick in.

Great. Thanks for checking and quick fix.

btw clang supports it with __attribute__((address_space(256))),
so CC_IS_GCC probably should be relaxed.

