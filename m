Return-Path: <bpf+bounces-22874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BB086B190
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 15:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B1F289EC1
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 14:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3043E14D452;
	Wed, 28 Feb 2024 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gly3jKWC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257B9151CD3;
	Wed, 28 Feb 2024 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130059; cv=none; b=pAZVLNmhToNM8hPTGU9kLE0L+qlybEG44HmSEO8ZGCZuShaobtv80daVYcp56rWiFIeSvOm4v57ALJWeJl8ESwzOy8PFBFf3MRw3HQK5hgoZ9kXKW6pKH8ZmkXwAns45RNjczpoiRFblBO28XSWUk6K4mWCpiosw8hjpfI0n8tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130059; c=relaxed/simple;
	bh=w93xgiTSz8WMLoXVP73QtrANXz+6jeMOsJP3UROC3NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcIMJR1KK4UClPHzO+RpSg88vHPw1090kZEyxoZum9PhOt2wvVHWjwTUmlYvwl3A7enMnO5HRPS/UyKKj540e5x/vFiUuCCqhCihzgs9AN2DJqa07zMu3uUlrZExxEOfdkREkQgIwqD/Qym5cA8wP0T05hppsklJANp1KAQFn9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gly3jKWC; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so77239411fa.1;
        Wed, 28 Feb 2024 06:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709130056; x=1709734856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HG4LXQMb011a2hWJZFC66jLZG8yR8DZQAQGZx8gHs/Q=;
        b=gly3jKWCLEhz1aEcGdWczckDabMXIADj2HZzo8xSo1XsnD61NmLgoP1UgrXsjy5yS0
         R1zX17XZLENAr5UnuQA1jNtq6OEiGydsoNTzzb5jUibznoFrePsi/QfOJ0Xo63bAWMOO
         ek95jU6bdD8VGLOPZ9rX9mw067H+KU1zcP6Ou+X6vkv41vIEEjF+t0iEpiGzb/uzpaBv
         qSZIQSm0CIj8DBP/Z5XN+Mj69zQxGxat3QQrQFIQSstC4ddZsGYAtLF7r0731Z2ghb6S
         djRW6TS7mhn7RH6bAmbhl0B8laXX9f9i1MNTIngLM/PD3BAvwwAdKLyjdsx2WGQ4DE8A
         TosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709130056; x=1709734856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HG4LXQMb011a2hWJZFC66jLZG8yR8DZQAQGZx8gHs/Q=;
        b=pQxo1DGfH9RD+8Q0mx7FrIOdQ7ua1wdXGv/dSfgDTmuAZTLWVLlVWJcEMo+lLlR29G
         5ly8pnK5OiyM9q77myKfxYTqLbCxAjRa4ae0M9QkygUnAZNfGYvflDJR7nh+2keosNhi
         DgGnGk/SNqdA+sHUmXPlwdi/lXR/6gAl4drUzq8Fcl1KXTDPFCRhLdKzgY1K/hdb3oRu
         sGWZyMLTJEVUUFT5B+twx5P7KjlRzYw8vYMPdVIaV5LrWTK+p/7zeaMq4qT+d7UFLN9/
         uL0zEh3gDtG3j+kaDikbxKIMjeZePP/+++xZ3A5oqOJHynG4qzIjrxHYASXFGNRTfFN3
         412w==
X-Forwarded-Encrypted: i=1; AJvYcCWNe3o8yEGkr0bRc5K4D8+z3iQcwtV/LYydJ81oI2bQ8BU+lS3IL2hVXuXRZvqZa0LwMTqTvbbhEyMuKTnLOXrLRL1BCx5TuWLsPH2yCe31IEZoMeYrEz6o68YkQlajMFD1
X-Gm-Message-State: AOJu0Yzqys4Fl82D+iFJgQPdC1ARdRVWMxNReL6d5k0pk2QJL8a0fs64
	V4diYgjaB+OfKHdasXDj72k814ZJvypYtp5rY1nCPYicHfAS4+SZ18natamZJDwAs7ejv1rFRML
	85JKLjYHwv1qymVPm3QlsHDrqUUY=
X-Google-Smtp-Source: AGHT+IGoB9fzjmAUpE5Wy01ochJJl6h85zawn128bKAr7m48GTTParSdIvqv4lNO3Zh7uSmvPuqSL71C3j9qZzdcvbA=
X-Received: by 2002:a2e:b7c7:0:b0:2d2:6693:d49f with SMTP id
 p7-20020a2eb7c7000000b002d26693d49fmr8137243ljo.31.1709130055555; Wed, 28 Feb
 2024 06:20:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221145106.105995-1-puranjay12@gmail.com> <Zd8o__ow2F6-ENVh@arm.com>
 <7b4588ff-c769-c185-3b4c-aab4a472d872@iogearbox.net>
In-Reply-To: <7b4588ff-c769-c185-3b4c-aab4a472d872@iogearbox.net>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 28 Feb 2024 15:20:44 +0100
Message-ID: <CANk7y0jakcUOvSsTbsZ-VK8VWP2wJsoiFtf1Ymeh6hQnsQAxqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 0/2] bpf, arm64: use BPF prog pack allocator
 in BPF JIT
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, ast@kernel.org, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, mark.rutland@arm.com, 
	bpf@vger.kernel.org, kpsingh@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, xukuohai@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 2:34=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 2/28/24 1:37 PM, Catalin Marinas wrote:
> > On Wed, Feb 21, 2024 at 02:51:04PM +0000, Puranjay Mohan wrote:
> >> Puranjay Mohan (2):
> >>    arm64: patching: implement text_poke API
> >>    bpf, arm64: use bpf_prog_pack for memory management
> >>
> >>   arch/arm64/include/asm/patching.h |   2 +
> >>   arch/arm64/kernel/patching.c      |  75 ++++++++++++++++
> >>   arch/arm64/net/bpf_jit_comp.c     | 139 ++++++++++++++++++++++++----=
--
> >>   3 files changed, 192 insertions(+), 24 deletions(-)
> >
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> >
> > Feel free to take it through the bpf tree.
>
> Thanks for the review, Catalin!
>
> Puranjay, this needs a rebase before it can be merged into bpf-next,
> please take a look and resubmit.

Thanks for the review.

Rebased and sent V9:
https://lore.kernel.org/bpf/20240228141824.119877-1-puranjay12@gmail.com/

Thanks,
Puranjay

