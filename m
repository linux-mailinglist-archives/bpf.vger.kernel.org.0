Return-Path: <bpf+bounces-59530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CE1ACCCD3
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 20:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068493A32DA
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 18:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DCD288C0E;
	Tue,  3 Jun 2025 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dVOpRlVH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4F71D63DD
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975042; cv=none; b=MCwDUk4Ue3I0hy/Iyb+IQr3WY0+jNqu6dWyPrXWaSXWjUNzhNSYTNEA6SS283iUDwqW1UEHuoFqP88pK+fbEJTws6PW2JvzV/WQw7aEGi4xZuCKmvhttmitU2keHByN2jwlTHTQsHVsyl4PPRQmALEe0UaSZJPMW7KHC9cQxKkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975042; c=relaxed/simple;
	bh=eiutlgQbbFswcPoUKxtmnu9MmBbg4ONzk6H4t4P4Txs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jebtoqxQRIB3fnq1sL61stiWoXHWdwNc7w0islugsXLZvrDTa1GYlpPQdim7fEklC/i9LMJTuI1VyZfWRRPmeWSrYtOrET3IBb0i0OYNNezeiWB7+VNZ4lZF8BnASWZzKikRDGO68EtEN+CXO8ihkLEbEcMVQcGYz5HE6h7LQv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dVOpRlVH; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-87de8a14cd7so1619967241.1
        for <bpf@vger.kernel.org>; Tue, 03 Jun 2025 11:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748975040; x=1749579840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiutlgQbbFswcPoUKxtmnu9MmBbg4ONzk6H4t4P4Txs=;
        b=dVOpRlVHAcBXHpJQhH4vcXcBNz/Ol0E20S1mx2ADnDuicz5BYNsak535bHcfiUILTZ
         TozmzIR1z9aQYODGbJFlBuervl8Pzid/5R6W1DgQcxFgwOinOVXQgt/0/1w6ZSQQ+ful
         r5h0rB0lAX2nVuhtosyRRiee6ocD7tOSdIgDXNeVkvmCaS/pk4ZYUpTXwRfUwMLJioxt
         UtCa4K357gfvhwoTARf2BHM3fBrvPig2HIn9pVIM3yjrP/kO3PACF+I857lGwVylPySc
         PxVEPlFNZLpeAbCsgQzQiWK5F5u9D0YTINMaD4lfB+x8O+iTgRAqvG4BTrfKIWsg3J3Q
         sglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748975040; x=1749579840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiutlgQbbFswcPoUKxtmnu9MmBbg4ONzk6H4t4P4Txs=;
        b=IWhkgaV/WPwDiHDRYUhAABZUGfZuiOZHqYzE4CLN/mKUJMmlHdeEycFvHEkdcRSQS3
         8sxQMOkjdPWu1H7+AXOpvx+LR+KDxBb9jKDZhrUBJ9XAbd1bs9wI3dhWGemOQwSgNQEI
         qU/xUsNA1KixGF0FKF3QxzwUEg/dhG/3BvOD9FIEfS5B+o8uOtxm8y2RmdXnVYe+Ldpb
         CQaEZ00Wixvlv8PuzBdOC/Us354+EPSrG5YvFX0HvSjxmhp/36WPsXhTpgaEplnexduo
         OtQDX5SFhuQYC+yYE12tqv7GAVKskKq9WvrKjx18UeyauRKDvHn34gYO9EIZc7Eaur2b
         WE+A==
X-Forwarded-Encrypted: i=1; AJvYcCUDGv2P5wDK45H50RSvGCBohpxd3SDKEjJLSD8RbMn1HFVPuXdD1SMVF5le1r7OuDWQ3Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbOujEO9YDvLAqc4uwfTxIY3s8BV5qU80ogLS0bQ6GRS2YeUmW
	YPLYY6a52zpfnLA/mLd0586fFObVs4viSbeMdNr3M4Vbza6U5nc/dFVCrl6VKCSdczUEv/hdmGH
	qhKk9PzNlzeDyHD/vOMN1cigb+vDvFN5JoybvuOnJ
X-Gm-Gg: ASbGnctNY0sc798Ogqy04uoAAaToz0DIPSwhazxFDPBdImv3u1mTgBh+CwX7bAeC8x7
	/E2M8nL5Nw7ZjHLKTUzWcCWrGl45apKc4VNEaPr0RlB0mmmKgaSU9BVql377ZhH1BfbKfkXCOsd
	Spvd7v5mDFtmcHnZbaMPJp5YpaD6CgBNyz6m5TbgoKoL+51vmDEW34043A25TQwjSsRxCIyY8dH
	bjLy2UWrUA=
X-Google-Smtp-Source: AGHT+IGu3iGfbqqsG3F9IVzijCh7yIShG1fCIQdA9Dgix1KcAW3sFId+iZ1kuCoUZV8YX2AkrDLGqQebTSC/08SGhzM=
X-Received: by 2002:a05:6102:ccf:b0:4c5:1c2e:79f5 with SMTP id
 ada2fe7eead31-4e701b94cecmr9613373137.16.1748975039606; Tue, 03 Jun 2025
 11:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521222725.3895192-1-blakejones@google.com>
 <20250521222725.3895192-2-blakejones@google.com> <aC9iF4_eASPkPxXd@x1>
 <CAP_z_Cg_vH1+BAm87U4gYQ0hDRGtHkkYb2DHtTRSd_QNvg3ZLQ@mail.gmail.com>
 <CAP_z_ChErhmooT5rhyXH8L-Ltkz3xdJ7PG20UKDpn9usMUgqTA@mail.gmail.com>
 <aDntjJcJsrQWfPkB@google.com> <CAP_z_CjLtMq_FvmijnFUQbD5UUw=T9jP_pHWCw5fS=38dgSh9g@mail.gmail.com>
In-Reply-To: <CAP_z_CjLtMq_FvmijnFUQbD5UUw=T9jP_pHWCw5fS=38dgSh9g@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Tue, 3 Jun 2025 11:23:48 -0700
X-Gm-Features: AX0GCFszGyqeZR0Dklu6vwdsbGkQkC3kk6Dhkl4_uVAGYzvPlnmcKX43Rvyctf4
Message-ID: <CAP_z_Ch8hKvGvot7140ShuCZOxkb+7M7Wpa4AY-D-Arp9P5ffg@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf: add support for printing BTF character arrays
 as strings
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	James Clark <james.clark@linaro.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The libbpf patch set is under discussion right now. Once it converges,
is there a way to include those patches in the perf tree without
waiting for them to go up to the main tree and then back down? Could I
resend them here, or include them as the first part of my next patch
series?

Thanks in advance for the guidance.

Blake

On Sat, May 31, 2025 at 12:26=E2=80=AFAM Blake Jones <blakejones@google.com=
> wrote:
>
> Hi Namhyung,
>
> On Fri, May 30, 2025 at 10:40=E2=80=AFAM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > I think it's better to go to the bpf tree although it'd take longer to
> > get your perf patches.
>
> Thanks for the suggestion. I've sent this patch to the bpf tree, and I'll
> resend the rest of this series once that change makes its way to this tre=
e.
>
> Blake

