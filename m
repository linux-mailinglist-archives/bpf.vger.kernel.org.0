Return-Path: <bpf+bounces-40464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A29988EF9
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 12:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE79281F78
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 10:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C017919DF98;
	Sat, 28 Sep 2024 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGbiHrip"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C683618A930
	for <bpf@vger.kernel.org>; Sat, 28 Sep 2024 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727519185; cv=none; b=BrvTliOvCIKi1Q8f0ncSxmtjqM77jQrC5mgl72k2PWmNkk7Tm1skFRnh0O3qC/T4GEc9B50BDu3zCEmzDV8eG9eN4rDQXO/4Vwfl3oQ0xCwY0ku9CXAkn1qErjtsXxj69DOy0L5TYjYx80czjUgUJWcKRP6vnVlxNE8qeLd4SDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727519185; c=relaxed/simple;
	bh=aujNBCX9wYKOh3R6OTuqCljh2e/WzhKXk/tMgUuahbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3FFvJjjlt0uMxoH7xfYY9P1t3Osjbzdsdu9y4+pTyxqFxxXLVm2fzQtnGz/EneGVGP18t8T20qp/GkpGxDbsSFrCQjIqsYui9B3odOpOKxNBkqG41kFyfSoW1NQMu2nlshvIcvz8gk8aTLBuJTE6D7cgPA4w+ZwIrv05rTpzpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGbiHrip; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so27011945e9.3
        for <bpf@vger.kernel.org>; Sat, 28 Sep 2024 03:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727519182; x=1728123982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aujNBCX9wYKOh3R6OTuqCljh2e/WzhKXk/tMgUuahbo=;
        b=mGbiHriphg/dlZW/V2y6Thc6erjCNC92O5aNMjrtilIEVwT3zwhXsq9AsdA0sNhcuJ
         7HcxyXl06QNRYe1zJ0H2etVMeOIfZRXiwnuTIhM/xuD74S/y41InM4BR12B3xm4rWu6u
         K0DOjmW2VhktQoLFcRCRx29aa19WtV707GtvsNodmErALwTUJs6nUxiOh8oVt/LIMfWq
         INbObw3PULXROMQwJztw4hVKxg/fbzs27ATf51CZAGa2BrDzWe3J6rVEe/k8S9mv4ptj
         Jr4xBc11dxJJk+03bIkw2gZ7rcI+Nqp2Xe9W38tkVgOb3rU05V2HMGc6XGUg+nFBK8UH
         jxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727519182; x=1728123982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aujNBCX9wYKOh3R6OTuqCljh2e/WzhKXk/tMgUuahbo=;
        b=Mth659mzdC9OcAEwtehZMUOBYAlL7DcfX4wJb3igxX03SecWRPS5qma0azh7G+75T8
         uDYtT71W0j9iyBhc9McJ4iOFtlFQMvy0zOo3u79POMzo852mCBiSq7UjhLEn/U4m3ST/
         +358mmGJWWqs0XP7O33g/Aix5LZqdVtIZ6f7rRYzxmd6y6lUoFvbfckHB+1RlYeF8L4y
         +U6mSCQXUWZ9OrplsZdrlSffiD1V3PV/3xXOyAyvIqxPcdft4xgcRRctIFlQD2V4fx24
         WyMwivQOCB3Q7zIjpIeernusC3bCkxf1Yh5AmmBnSoKAXrerMOuB6CWUFSpgCZBuJot1
         xAcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk6tvBIlFfniB/C8jCzHrt+MB7U06+suWIFneRx2OwL96Hrh8PtdMZDkiGb7wwfI3iFus=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFEtAMoaJPeaWIVDPiuwM5ByUpgE2dc0dy8uaRe4d5SO8kWnTT
	U+Q2UPh8yTCP00kjHXFr01XdfyMCkLmmgjY8tkRHyuxTpJbbf8Op42h0s4OPdWJdbrix+bo9OXe
	tdT7ye4TtUtUtX47fYr1jYxhyOwysZ5OpW9k=
X-Google-Smtp-Source: AGHT+IFpx9V1qwNymzTjv8qcPL6WcW3aAHn5lmcqfHj9iJZd184Qq8t7r/JzqEwJHe0ii3oVZhQhwT3WCxRPvc8z+TI=
X-Received: by 2002:a5d:45cb:0:b0:35f:d70:6193 with SMTP id
 ffacd0b85a97d-37cd5b106aamr4078811f8f.41.1727519182017; Sat, 28 Sep 2024
 03:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPPBnEajj+DMfiR_WRWU5=6A7KKULdB5Rob_NJopFLWF+i9gCA@mail.gmail.com>
In-Reply-To: <CAPPBnEajj+DMfiR_WRWU5=6A7KKULdB5Rob_NJopFLWF+i9gCA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 28 Sep 2024 12:26:11 +0200
Message-ID: <CAADnVQJzkf7ur2Xe=6AoEt6FXQNMMJQnyN=LeJAg6jWWEz0+5w@mail.gmail.com>
Subject: Re: Possible deadlock in bpf_common_lru_push_free
To: Priya Bala Govindasamy <pgovind2@uci.edu>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Hsin-Wei Hung <hsinweih@uci.edu>, Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2024 at 4:10=E2=80=AFAM Priya Bala Govindasamy <pgovind2@uc=
i.edu> wrote:
>
> SEC("kprobe/bpf_lru_push_free+0x2a1")
> int test_prog2(void *ctx){

Nothing new here. Pls make it "noinstr".

