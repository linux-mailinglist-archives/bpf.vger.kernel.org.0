Return-Path: <bpf+bounces-42716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C54B79A9526
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 02:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B231C22B0F
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 00:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E3A12C549;
	Tue, 22 Oct 2024 00:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYOf2Drw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DF949652
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 00:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729558086; cv=none; b=ODi/bLBu2LTMs0+pRxoAWEpPEzISe1TBO6SzSmJZ1oBlVsHW7IAPfcEOPB9UTgpkBS/OFOHdzbPsVORJb/f8D7L5RTv9FPS0U6AOaX+ng2YSohwVNhbEwaWFpp+xju3N0q/RG6aPQ1hgC4+EFCwug0t3AlmYs02UodHh6zKkUaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729558086; c=relaxed/simple;
	bh=NGpUR3iwFfa/pQFhvTVTIIry6AGOA1qsU+SXhmiK+aA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTfKlXc2QXTFrTzSbhxvSbrbevs0ThDkmv/Yc/0deKu0b1gU8BxqG8mmwf9DHH4C0cEASUVJ/vaba0A479Sk2YLX3cyEKX3MtIz43z4as28vWv2ZyMAh4d4c7UV/JMiYgLoYvEW3XtuIKcx/hYg/5r819iWDL3zbOpYr89mFCDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYOf2Drw; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-37ec4e349f4so2714681f8f.0
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 17:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729558083; x=1730162883; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zTQ5obBBD6fqm+MyYQe4tcmj1qeV04em5CyVvLrOHTU=;
        b=fYOf2Drwid+bmeccVM5G4ok0ycxJkrP1rIiC9grXom3ouRCfctBjfmMWBhq4WMn5Rh
         AwQ+GQleXtbtHdKTTpVAZX8h9qXFWSBZznmbs8bRZBGBUtYpYd3EoCgvXjbtrFEwQ7e5
         Oj2g1Otosp9Z228aLlI0wLzx5UWzR7KTGkzsFVfMyAIMObq3Cu3YZ9UsJvhbL8MKhg4/
         Kk0f6HE4clntv5UcQaUASDaWyS81wqIc7/8xAYzGrtzcqYmmTdgko7m7q4ChiBez/yZx
         fUXKvj9P+6myl/h8Z6NuJ0iXvCDeHuDKc/o0d1Pyt1asbp8j3hHaxC1aiVCjFLCYZSvW
         dV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729558083; x=1730162883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTQ5obBBD6fqm+MyYQe4tcmj1qeV04em5CyVvLrOHTU=;
        b=GvxCtGkHjPfuIZNYPECU+NsbcnepD6yKsb0E2+iHhqH4BZm+afd1v4JHWVwTaCPzA5
         nmAsLdfygS/HfbZdM4lgGrR3qq++AyNUU2RbWn4SMiEj2/KtXPmfn6ZFjTTtGn2EZfb7
         uKRkjhRELZn5GojmaWOpTSbr51LI0007aRx9ycS2xK0rH0zA6ABumsEHNCEp7pg1o6/E
         TP7XbWjTxVWaStlNjcMy9u/hwdIK9GPEkepTPjkXQsg0U2Z1jQYuQbzR4kFul+8OOtx/
         kiz8BRiK+hfn0D7xSFOCEvNEgCunjcPBxMndjHYvWRCl66/tvqtvOYANFKdDE7Cbiqya
         bE8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVafBz1Y2tNo79QUDYd0a0I77u6PSSUKhlyDcZYDLYeAYMf3gP3KJgwHu8qnEcane8fSQU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2JeeG7TiBzOMH6z57N5sBpr0Dq3YzVIJ9gdw9oKZkXwxkvDl9
	BfrFQq2VESHGiEH3FyNK8Qtw5+Eo6nLV5Urr1cudTSiIJMLedg2rHE1Js/n6APr1fZlCT+ku3T9
	USwoZoR+ykOlV5FT2PyLOyLEiybs=
X-Google-Smtp-Source: AGHT+IFsxuS+QO31YxBF7pvsuZnGHD45cXmIaua32M1ajhTa0au6LeUN7cnLeyc5cRapSbltPHQowNDb37A8Hc9Ea8A=
X-Received: by 2002:a05:6000:d08:b0:37c:d53a:6132 with SMTP id
 ffacd0b85a97d-37ea21b6bd1mr7802843f8f.31.1729558082640; Mon, 21 Oct 2024
 17:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021152809.33343-1-daniel@iogearbox.net> <20241021152809.33343-5-daniel@iogearbox.net>
In-Reply-To: <20241021152809.33343-5-daniel@iogearbox.net>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Oct 2024 02:47:26 +0200
Message-ID: <CAP01T75xs51s79-3A7mdU5O_65fd3gohKEwnW-9Au7LVfuO7dQ@mail.gmail.com>
Subject: Re: [PATCH bpf 5/5] selftests/bpf: Add test for passing in uninit mtu_len
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, andrii@kernel.org, kongln9170@gmail.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 17:28, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> Add a small test to pass an uninitialized mtu_len to the bpf_check_mtu()
> helper to probe whether the verifier rejects it under !CAP_PERFMON.
>
>   # ./vmtest.sh -- ./test_progs -t verifier_mtu
>   [...]
>   ./test_progs -t verifier_mtu
>   [    1.414712] tsc: Refined TSC clocksource calibration: 3407.993 MHz
>   [    1.415327] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fcd52370, max_idle_ns: 440795242006 ns
>   [    1.416463] clocksource: Switched to clocksource tsc
>   [    1.429842] bpf_testmod: loading out-of-tree module taints kernel.
>   [    1.430283] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
>   #510/1   verifier_mtu/uninit/mtu: write rejected:OK
>   #510     verifier_mtu:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

