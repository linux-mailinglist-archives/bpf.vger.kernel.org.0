Return-Path: <bpf+bounces-43170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F369B0943
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 18:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C663C1C218AE
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 16:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AFE175D46;
	Fri, 25 Oct 2024 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiU4LIyN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050A917333D
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872592; cv=none; b=mT6L4IeBthEbtWZr9DXYfRt0jG+QX+AAWatalWkTXKD9cTqLvkGPKO2k3lXZGESA4Fyb3mwVKL0FBA6hLmUrp4ZBVv6LozsznaqTIFedofH1HJAsCGWFlNrdE/YeCW+HnTPHQmYdaYV4kSQ61DP59nY3lW+pZ0Ji4GmFxHxXYuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872592; c=relaxed/simple;
	bh=THLt/9u2EIBUAFt4OMXJJhicOUPZ2gTJKGarMedmnsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NspR9sLwM2PzB0DDXgaVIwuk3p9rdev8ELRPROXXyirXq8zGaIAgUuST8gBfnUs3J5dqd7mn3tAZW03543/0DvkUCNY/KTSYToXWFfUjQgvYctRcTfG1D4KADYLwYuLe4U6rCEJSMu2gudNus+1Xrq+5QI609DI6r1UVLTPWg8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiU4LIyN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so22290385e9.1
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729872588; x=1730477388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7QTO7noEjyP6b29wJEP462ykCCSSx1jpRAqHddoNmo=;
        b=hiU4LIyNLIs9EYO8xQSJNa5/cxuKvNy/kch2NHHaH4NszlDPypUmywpEzBz9mw359b
         j26AcOthMmwcCQ3K+X5t8OMGasWFvrO16ozry8ZJCyEETS3XEJNUvYxK2c+2UR+2YPQ4
         rVlRQrKfO+rjxtVQtXCmatfbgZyJOtVxJ+qlIITgvmXhN5XwEicJbF64o6+GUkUkpECz
         vu+eFA4IAnnP0Y6+IAyOsZcKU/lCyxAYVOJkJf97hhOT5pXEhD0jbKEh2A0RoLbOYoJg
         sY5WjotR489amm/WOpRqZlIcyKmXcsjrrLVeXCUTh43zuw0hCOH8Ix3JowUmCG5df5qK
         QOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729872588; x=1730477388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7QTO7noEjyP6b29wJEP462ykCCSSx1jpRAqHddoNmo=;
        b=h4xj/bUjAxsMItlOlMXtxQ4UAFRv4jR+aCBN8sVSzdSRQtqxbYv7v71RRQ+xAKV73b
         ZStu16QbEPOBUTEWPmcSGDoOUyJD1R3cqCohojip951M4gy2w/fbCEQweMDTvNhnXQGc
         Xh/DdJF9EylOnM59vFO6kzcMGFFAd2PxPLHrdAfYVlS+jGcrcYx+WqAPABZqjlH29/Ma
         iZjxZJI2aad0YC1LzmLQb95tE5TUV1LZbVSCJldaeeihs9mXfV8Dh7pkLuTIcchjNZpA
         CnOJ1kvO8meATuq5swVQJ5lQ6wBqrhoYJyMJHBm1iHzyq8FllBh39tLy6ZNa0leQiKCI
         jBkw==
X-Forwarded-Encrypted: i=1; AJvYcCXo9BxWUS1mKYWhvG6j2QG4Z+eDlH2oy7vlDm687TVJpnqOvJwYdXlH5wLI1AJql4plNkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YztpTsVsTmDmOsFs1Zd0YzetOe3uQ/m2Y1ogGuajFzCsbBTHXkG
	uaIT6dGu0EJaObMWLpnibN+ZF5t2s8skbK8Pk64rfn8Xr1P88Ku7/KLyUYFMarSAthdgE6gzty+
	5odbrb8scSM0Y2yrydW0Y/GikZ44=
X-Google-Smtp-Source: AGHT+IEzGViJTvUpJbhHJGW14G8GAacPIQOVlkX2fvlGBoZVsyi4Z8gP84hdhy9dXxGlKf04RH5/tT8qY4WzIceyLgk=
X-Received: by 2002:a05:600c:46d0:b0:431:57e5:b251 with SMTP id
 5b1f17b1804b1-4318424ea03mr88342145e9.28.1729872587879; Fri, 25 Oct 2024
 09:09:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzYYZa3m5ttEgfPnZUBdYpgoq3JS0GCedXgeoWLgvr9YPQ@mail.gmail.com>
 <b58c8ae4-3a5c-44b3-bc85-2dd7dcea397b@oracle.com> <CAEf4Bzbv4SrQd=Yt7Z2PNQLT+1VkLKMaERFwfE8d=8s7QQ-_bQ@mail.gmail.com>
 <16877742-7f15-4fd9-95b4-228538decda0@oracle.com> <CAEf4Bza6pL1-2AmX-zfuv5-mEk=b6yhhGRtb7DrkUTsArvEO6Q@mail.gmail.com>
In-Reply-To: <CAEf4Bza6pL1-2AmX-zfuv5-mEk=b6yhhGRtb7DrkUTsArvEO6Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 25 Oct 2024 09:09:36 -0700
Message-ID: <CAADnVQL2CNSMi1NoNTVePw_VaqHYZJ4pLLX25wJjD1R66ezYXw@mail.gmail.com>
Subject: Re: Questions about the state of some BTF features
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 4:26=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> >
> > The good news is that already happens, provided you have the updated
> > pahole to handle distilled base generation. After building selftests I =
see
> >
> > $ objdump -h bpf_testmod.ko |grep BTF
> >   7 .BTF_ids      000001c8  0000000000000000  0000000000000000  00002c5=
0
> >  2**0
> >  50 .BTF          000036f4  0000000000000000  0000000000000000  0006e04=
8
> >  2**0
> >  51 .BTF.base     000004cc  0000000000000000  0000000000000000  0007173=
c
> >  2**0
> >
>
> Indeed, after updating to the latest pahole master now I get
> .BTF.base, very nice.

I pulled the latest pahole, rebuilt everything,
but still cannot get it to generate BTF.base.

Any special trick needed?

