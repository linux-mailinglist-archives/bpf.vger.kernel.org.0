Return-Path: <bpf+bounces-56571-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFB0A99EDA
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 04:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550A25A45CD
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 02:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D9B19CCF5;
	Thu, 24 Apr 2025 02:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbmL8+/Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DD02FB6;
	Thu, 24 Apr 2025 02:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745462047; cv=none; b=OlBM3F3FwdbZXCfgsFlo38QAHFfctPEMtMdjbNkFzIPGROx1zxf6TqEvCxrZe0aSha5IOEOuraZWJpfmj42ffKZCa7DZW8+ZE1j2GUWwLfcMQ6g0athNFQCOO2/e+1O7n4/9JhuxI3RI4GChUu7wgGlyxK4fgo52M4HmOFlgkpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745462047; c=relaxed/simple;
	bh=pxteP8c9nih6FWtnz3T9WLQSW/Z3uyVlypeiNd3IH00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lzn1v13nN+OXsY+rOZkKLCnCJ8gHwnFFUhczMh7AaY+5aZNJWWZ77oKBmxVuP1U7N5cR6Ltq8Pqq7evmCGtkR6LW6qokIotgf20S7N+B6/YPZ83fJZrEFjBpr8uPJKytxpmfJu1WVS3P7BY4uL/xG9rJNBjBqZCHkh4X8BOjzQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbmL8+/Q; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-440685d6afcso4738405e9.0;
        Wed, 23 Apr 2025 19:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745462043; x=1746066843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFTaVhD7rf7VbkXiFfyg/2sZb+zmUP6BdApymTTnxnc=;
        b=AbmL8+/Q8lxCQF9hBaYzgMZZUBypu5MJNSGPOhe/MhyVcBX3IZviCyZZKySr5ICMA6
         E7qDQeKxLtSlXELzpW6ZVqmqg37MCJP30NSO/8Bwr90zk6uUtfi7VohhzY1Qbx/sG91+
         yWuxmMne9Mr9UZG0/OUH0flbqjM4QcmxAiYIzuy+BkgnO0NsyFsZ/Tqoswnvb99f2hzI
         0/bh7xy56auQYTNnv5G0x9XecvolxfF+SkZTZFdHW+ddy2LwZNXJxrxB3NGQMxebE0y4
         KvWhV4bJzQfXiDsr6PruUaf7qyMskGgruMo6FGNFd6OeGy2xWNfWf1CFK+43yQOQg3gY
         jyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745462043; x=1746066843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFTaVhD7rf7VbkXiFfyg/2sZb+zmUP6BdApymTTnxnc=;
        b=Y2j7ZpBh/uTFTNoPI5oNcUCeSf+QkZwgyygKOVm2wKeZ2WDcjaC9XFnmLu8uiPUBCE
         EPcn7+IyACAd4Dq/HwS6lB01HrhtutNC+B9luzBPqek3R683krt4DvAA+DIEP7YVfvXP
         c6Ruu8WVXtw310zhZDSmY/+h3NhEbEadW2dUgUXoD3N+Dj+In9somMfhp7VTZh8uB/7C
         dYogj7IMunUzIO1+eRwSN34t3lA7RS/D/pfDdRRZBuOsfb4VzqvILEjrrvXWBVxf3mYn
         45lBEaPI+XeRlKP/Pt5beQn9LlB7q3nUv1SaDsokqKA2yE0lWp+O09AX7PuwqD+izMTL
         6Q1w==
X-Forwarded-Encrypted: i=1; AJvYcCVP3mrArYzj0CJr3hqGIKmhv44ZRRO1SVxxvDvE4GDaQQa3SvfSTLzX7kRkm27WjvsrFJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Mt8u8XrgJ06L5/ebXnfgE4OtiDi37TkFSK2NcF8++nRsZIjR
	WgINs3kkBttZzUoayFNUYTGzkqqkBv0jLC6a/JsnrIAJX7BsDZ4kglxLcoE5g8JMfCnKPo6h75/
	3mIlMC8s6geQ6Tce0jm9KvYWRYM4=
X-Gm-Gg: ASbGncvqt9J78QiHrmEDrglWVmpRImynauELLtHvzqjNga3N1HBHnEkdn1bTZli5RFU
	JsGDrM6mkjGQeQLjr1yHhbNuaPu9ahXW3Kkcz2LtnfxrjC4lDO97OZekckLZeIh8FSF0c+i0s34
	sQ2psBNw/0pXkaJ/judiYPQEZ3mQS/dkNhQr4XUQ==
X-Google-Smtp-Source: AGHT+IF8TvFmJ33FpLgpqCFNu87qzE8ifA3YVnDAq7z6lp8KPe5Zd3izxQWlagoPBTJpy3OrEPLlBptvSq4OeyKd63w=
X-Received: by 2002:a5d:6d8a:0:b0:391:2c0c:1247 with SMTP id
 ffacd0b85a97d-3a06cf4b81cmr438595f8f.1.1745462043263; Wed, 23 Apr 2025
 19:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423235115.1885611-1-jordan@jrife.io> <20250423235115.1885611-3-jordan@jrife.io>
In-Reply-To: <20250423235115.1885611-3-jordan@jrife.io>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 23 Apr 2025 19:33:52 -0700
X-Gm-Features: ATxdqUHBYB6MUtTMz5OmejU3qdoInVgdbtNZc6mKe7JQ4mHwoKVMZEjlewA0Vxc
Message-ID: <CAADnVQLTJt5zxuuuF9WZBd9Ui8r0ixvo37ohySX8X9U4kk9XbA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/6] bpf: udp: Make sure iter->batch always
 contains a full bucket snapshot
To: Jordan Rife <jordan@jrife.io>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Aditi Ghag <aditi.ghag@isovalent.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 4:51=E2=80=AFPM Jordan Rife <jordan@jrife.io> wrote=
:
>
> Require that iter->batch always contains a full bucket snapshot. This
> invariant is important to avoid skipping or repeating sockets during
> iteration when combined with the next few patches. Before, there were
> two cases where a call to bpf_iter_udp_batch may only capture part of a
> bucket:
>
> 1. When bpf_iter_udp_realloc_batch() returns -ENOMEM [1].
> 2. When more sockets are added to the bucket while calling
>    bpf_iter_udp_realloc_batch(), making the updated batch size
>    insufficient [2].
>
> In cases where the batch size only covers part of a bucket, it is
> possible to forget which sockets were already visited, especially if we
> have to process a bucket in more than two batches. This forces us to
> choose between repeating or skipping sockets, so don't allow this:
>
> 1. Stop iteration and propagate -ENOMEM up to userspace if reallocation
>    fails instead of continuing with a partial batch.
> 2. Retry bpf_iter_udp_realloc_batch() two times without holding onto the
>    bucket lock (hslot2->lock) so that we can use GFP_USER and maximize
>    the chances that memory allocation succeeds. On the third attempt, if
>    we still haven't been able to capture a full bucket snapshot, hold
>    onto the bucket lock through bpf_iter_udp_realloc_batch() to
>    guarantee that the bucket size doesn't change while we allocate more
>    memory and fill the batch. On the last pass, we must use GFP_ATOMIC
>    since we hold onto the spin lock.
>
> Introduce the udp_portaddr_for_each_entry_from macro and use it instead
> of udp_portaddr_for_each_entry to make it possible to continue iteration
> from an arbitrary socket. This is required for this patch in the
> GFP_ATOMIC case to allow us to fill the rest of a batch starting from
> the middle of a bucket and the later patch which skips sockets that were
> already seen.
>
> Testing all scenarios directly is a bit difficult, but I did some manual
> testing to exercise the code paths where GFP_ATOMIC is used and where
> where ERR_PTR(err) is returned. I used the realloc test case included
> later in this series to trigger a scenario where a realloc happens
> inside bpf_iter_udp_batch and made a small code tweak to force the first
> two realloc attempts to allocate a too-small buffer, thus requiring
> another attempt until the GFP_ATOMIC case is hit. Some printks showed
> three reallocs with the tests passing:
>
> Apr 16 00:08:32 crow kernel: go again (mem_flags=3DGFP_USER)
> Apr 16 00:08:32 crow kernel: go again (mem_flags=3DGFP_USER)
> Apr 16 00:08:32 crow kernel: go again (mem_flags=3DGFP_ATOMIC)

It looks like overdesign.
I think it would be much simpler to do GFP_USER once,
grab the lock and follow with GFP_NOWAIT|__GFP_NOWARN.
GFP_ATOMIC will deplete memory reserves.
bpf iterator is certainly not a critical operation, so use GFP_NOWAIT.

pw-bot: cr

