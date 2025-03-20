Return-Path: <bpf+bounces-54499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C679A6B04B
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 23:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7162416607F
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 22:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F0F221F02;
	Thu, 20 Mar 2025 22:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z5ZEHGzb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CF9214223
	for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742508496; cv=none; b=Sd4bTkkS5JAqBLVBAY1a0KnMH/nwDptdKIE10HhDSohdZdjoM7NQ0f/FyO/RkMIpITym0ii/9j6O0GRQlxJPs288MB+UcPxuJfL5SqqzsA2xxja6bjlD0+ZnNsGMg24exZ3Kg0zJX95YEDgD4TJDQyfcXUY/eDFKikNGlKpvcAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742508496; c=relaxed/simple;
	bh=LNJBkeztccnUGdSFNTCKHMpe1NBW3yewsHYARTHwKgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQhkPjs2r+4g8ANSKf3CllU70drvJISZuCQwKhFf/Y6EOibmb2J+4mYSCPuqXDOsHRReskhBs7VQURNzb/+afMyvGEVBjpYQVIyaf+0mAkjJ6CH3nKBHcSILSRFwFBMP3nDHlozmZfN9pBG2j3XXb6PRwuSk5eiFa/8rN0e1OY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z5ZEHGzb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2242ac37caeso27715ad.1
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 15:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742508495; x=1743113295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNJBkeztccnUGdSFNTCKHMpe1NBW3yewsHYARTHwKgw=;
        b=Z5ZEHGzbd1z78ljly8LB1Lrn7p6YfFw2N4ZCefKnVgUUUXGhCV/e5vpcwe59+c2MJt
         AOhSRONDRs489Ctg4Fn0O/EZpUQdy32tcu7vqJyY73vMnc3ecNGNrrIHemG5EqJVjWEg
         +Fqof9apMnHr48+Ov4AvT6bqACPkHsEfotWy1h0ECSGfVBo8C6+6CoN8dgCIh7M+shYZ
         FEWAniQP/Hecy6sQ1qbeuSjmDmOYrKfJaBDiYg5a0wddeQETI/d1BVri1/hUNHJofMWK
         aBrBuvugzZOT3b5m1FhqTAfmp/7NLiPUbltd9n18yCe6zY4xkVGTiNe/qJOV/OfxtuWI
         I4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742508495; x=1743113295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNJBkeztccnUGdSFNTCKHMpe1NBW3yewsHYARTHwKgw=;
        b=cH8GMWse6zxP8Omh48OQ3okWYYb2eC1ybkjvW0s7fTkWy6vrGP1dFqVEEJLlPGM+cu
         A2Qb15xvduwqmiNTZQDJY/NoG3aArtbPlPoHBIsHcHSl/KRAXANaTEwicFw/Suax2BmZ
         asrFcv9Fy0r6w93ZeOvKOtunOwXByC/qA+S5JO5zuarZtgaB2Gt4cWmfTGd/58222G5H
         vYqBDox5hzjSWbPuM6FinnIjY0Vce5bNhSLhGkODB2YBLaAv+ChVyYepS5Wp76tTxF0c
         OnSq1c43WrN27LnFXHqgpRTLS8nLIGPMqTBj+MHDd+ngGM/S7TfAWWgOVZDCDG0j/6yu
         25ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVPjmjTOZwAGt3mjVfn7zWrb4aHYLP+8WzNdLQE9/ENOb/YYl5oO4pWKUYWiLX2OBVmXxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzW/+jS/2NPLKT+dL+8ifKxGcjUlT01s67T7hUsbL9MS+tWyoT
	KMiO5K4d7HgltvCmUF2XFouec6jXgL7IsBrj2JGQas02TZxSOya/0cLttAEBtLHuHU/fyhehcIl
	R8w7DRIR5aWkBfTQ+bf+UzFCyPjO1f4bJiFGe
X-Gm-Gg: ASbGncs7s3byXAya9a3GoFUkXI9S2p2hx1EffcZmgpzQ4EoHQ5ysi7kNZyvoVVCV643
	4oIHAJeH+xgC3CNNMimySQnvJ8OXpucWzvK8yZaHK7soQeZZk1lW7lbhPLdyf/uUcwkCARMoFU+
	BbweDBXC/Y6DTK1l1gEyEk0wnwQQFLXU7FDf1ljdN0MnQKERjtF+CYdy0=
X-Google-Smtp-Source: AGHT+IH9UD36zb4z/rqqyTMfzuudB/0Vms8vaWNVXQ8hF61k9eXPkEoYMXmUDWRQNJAA1D5y1EHBvFnB6gV+vW/t9Gg=
X-Received: by 2002:a17:903:228f:b0:224:38a:bd39 with SMTP id
 d9443c01a7336-22781d28abamr790055ad.20.1742508494214; Thu, 20 Mar 2025
 15:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320175951.1265274-1-irogers@google.com> <CAEf4BzYPx-shzhex4CvE=P7bYBudU5GVMK1fNq6Azz=sfBXK3g@mail.gmail.com>
In-Reply-To: <CAEf4BzYPx-shzhex4CvE=P7bYBudU5GVMK1fNq6Azz=sfBXK3g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 20 Mar 2025 15:08:02 -0700
X-Gm-Features: AQ5f1JpqEM2FRi5SeWGbxKXewfp4pp_nMVONie4nJ4pRZhM0d9CVaWiiLSJqKsc
Message-ID: <CAP-5=fVjeDzJOGsDeVxtc=DFLpNPCi3KW4-3VkZENTkT=G6ZGg@mail.gmail.com>
Subject: Re: [PATCH v1] libbpf: Add namespace for errstr making it libbpf_errstr
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 2:37=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Mar 20, 2025 at 11:00=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > When statically linking symbols can be replaced with those from other
> > statically linked libraries depending on the link order and the hoped
> > for "multiple definition" error may not appear. To avoid conflicts it
> > is good practice to namespace symbols, this change renames errstr to
> > libbpf_errstr.
> >
> > Fixes: 1633a83bf993 ("libbpf: Introduce errstr() for stringifying errno=
")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > I feel like this patch shouldn't be strictly necessary, it turned out
> > for a use-case it was and people who know better than me say the
> > linker is working as intended. The conflicting errstr was from:
> > https://sourceforge.net/projects/linuxquota/
> > The fixes tag may not be strictly necessary.
> > ---
>
> sigh, I do like short errstr(). How about we avoid all this churn by
> naming the function libbpf_errstr() as you did, but then also
> defining:
>
> #define errstr(err) libbpf_errstr(err)
>
> and leaving all existing invocations as is
>
> ?

Works for me. I'll send a v2.

Thanks,
Ian

