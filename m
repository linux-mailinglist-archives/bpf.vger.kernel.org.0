Return-Path: <bpf+bounces-37782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F3B95A7F9
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 00:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CA81C21499
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 22:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE61F17BB32;
	Wed, 21 Aug 2024 22:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="kGpSLr6I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF84168497
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724281001; cv=none; b=C0J8DWboYchfPT5JM8INHs56DcRorfn/JFdvEjsfScarLdOtF5u28cMME22cUT2TpomQpIk6xxfCeFJ3AcACgs6O98c+BvWW4fYjggaiEg7k9CC29KmfJkFazj6CmTAqQkRvPkpsDc9t+ILuuoxxVSDneTSJEoFSyeRHuSRSjOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724281001; c=relaxed/simple;
	bh=s9PnuoDlbhrfnH3gkUwqjL/e1XZzE9jxyWSO5/kREJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G86MY3EX3LVrp0eeu7nfb3Q3JTY2vFVOwGVugp9j9boLTaK7hkmnFZkMJkY8/8od/Je6cCjVftKeG5bMacZVcswkmC0iqlJ02vd1L+u99lsDXF5AR3zxeUMHVx9ui3aQdQcHXIa9rY79giAWIlZ/TJuw2eWneqdIvuxRLFXT90k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=kGpSLr6I; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53346132365so228228e87.1
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 15:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1724280997; x=1724885797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9PnuoDlbhrfnH3gkUwqjL/e1XZzE9jxyWSO5/kREJQ=;
        b=kGpSLr6IP4JfzJlUmraY6R22njIyih+wc5EVlZjKHVq9NZ2pp+3g+1yFphzPDUDkSN
         UOLoqyaZ9vu/wCZ2FTDkRWR3yC0pYzCkU8CMFvfjcP74sw83H5jJyfbplR0zcA4+L5G5
         Fm04NdPBOTL1/gESCfcemkrju2NcZieL+6DqYOa0XJ7cJi6+QLQcBn16Bg8j9q4DBDKf
         7Al7W7Hu7oNoXHaGU4DYWYmliA+wmr994dKHDwlpd8CdYrM/FP/tgjdnFX1+hhg8XYpW
         EK4+xMSVf1MPhsoqGBTjLE9PzWoFHn9Cd6/s4lzb2xTJLljIDr/bjkVTzrlnJvzqu1J+
         lCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724280997; x=1724885797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9PnuoDlbhrfnH3gkUwqjL/e1XZzE9jxyWSO5/kREJQ=;
        b=tFzBNJmBvDs42IxOQOjiPZUFvabhOVRq0Y5YTpgzer1I3B6DDltoiaSlA3bXUlgcJR
         Ye62FtMY5C9tFeMhjJYkqJZ+OCZiEYekU/yMyeKcQg4PyRToMOO3dE+htg5TLdnaMmZa
         i4EzwptKnsTSPBNZvTyRxNP6YMjqWGd3epamsLxUVaW+eEgU+wwDXLOYsfLKyau1DvcE
         tA15lqBqWYLXIV8yELEH2D5SdrGBxZQ34vNIoDA3G3Q1dR4UJ0C+Z83/T3NiTacnPjnz
         7b9vr8ZcEI6TITu19prFoLVcQUsj3UmSNGXOT0ll8xJd/a0B96EvGxxb0ffjt85UYnh+
         c/sA==
X-Forwarded-Encrypted: i=1; AJvYcCUauoRBFQbXMjVz4FTBuUzAx16Qa6O9yyD/FNqCrWNk4pjt7wSWx4bhhgeiK+jxn1wEY9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuSvwzhAATc6axes/BQ6155HXjy7pAa36yNRK8dPYGZiK7RMta
	UxR7O54iOrnfC2JewaFq5fwS/EHuNHOGmiWSNS49fXxKLudAxTUi3N0XgxqZGiA3dq50QvWomWe
	SvNa0Wte0w+M/FK1mjAoB0unCV9sbyHmvM2WR/2vAENz8TRinXEA=
X-Google-Smtp-Source: AGHT+IGvr6gaQ5c6GurAkZ2XGslDYa6NFJYmS1nKTBuxspBjyuUUz+zttTjJZBOLyqYaxaoDn+dwY04Km3hJZ9nsjuc=
X-Received: by 2002:a05:6512:3da8:b0:530:ae0a:ab7a with SMTP id
 2adb3069b0e04-53348590efbmr2153986e87.17.1724280997389; Wed, 21 Aug 2024
 15:56:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPPBnEZmFA3ab8Uc=PEm0bdojZy=7T_F5_+eyZSHyZR3MBG4Vw@mail.gmail.com>
 <CAADnVQJA0WjoX3SGLccUvczUaKaLqajz2rj7=d2H-xrDXmQFkg@mail.gmail.com>
In-Reply-To: <CAADnVQJA0WjoX3SGLccUvczUaKaLqajz2rj7=d2H-xrDXmQFkg@mail.gmail.com>
From: Priya Bala Govindasamy <pgovind2@uci.edu>
Date: Wed, 21 Aug 2024 15:56:26 -0700
Message-ID: <CAPPBnEZjm7fguaRF=VdaehHhcLCkSWZBaekPBSaNU4V84SVxeg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf/bpf_lru_list: make bpf_common_lru_pop_free
 safe in NMI
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Ardalan Amiri Sani <ardalan@uci.edu>, Hsin-Wei Hung <hsinweih@uci.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We observed that the lock being taken in this instance is for the LRU
list of the map, which is taken before the bucket lock in
htab_lock_bucket. Hence, htab_lock_bucket does not prevent this
deadlock. Additionally, bpf prog recursion protection logic does not
necessarily prevent bpf perf event programs, which can run in NMI,
from executing in tandem with programs of other types that could be
using the same map.

We thought that returning early would be acceptable here since there
are other circumstances in which htab_lru_map_update_elem can return
an error. But as you say, the map behavior would become random with
this patch. However, we are unsure how to fix this issue properly. It
would be great to receive feedback on how we can fix it and we'll send
a new patch with that in mind.

On Wed, Aug 21, 2024 at 2:38=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 21, 2024 at 2:30=E2=80=AFPM Priya Bala Govindasamy <pgovind2@=
uci.edu> wrote:
> >
> > bpf_common_lru_pop_free uses raw_spin_lock_irqsave. This function is
> > used by htab_lru_map_update_elem() which can be called from an
> > NMI. A deadlock can happen if a bpf program holding the lock is
> > interrupted by the same program in NMI. Use raw_spin_trylock_irqsave if
> > in NMI.
> >
> > Fixes: 3a08c2fd7634 (bpf: LRU list)
> > Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
>
> Nothing changed since last time exact same patch was posted,
> so same nack as before.
> pw-bot: cr

