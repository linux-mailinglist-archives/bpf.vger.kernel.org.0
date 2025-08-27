Return-Path: <bpf+bounces-66732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF58B38BB7
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 23:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36077168415
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 21:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A2330DEDD;
	Wed, 27 Aug 2025 21:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVBDrdAh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566B130C373;
	Wed, 27 Aug 2025 21:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756331620; cv=none; b=KsbrR6ZzgyqPBCopaRCs3r4NSN9ZgxM3nUD1yxi5EDR80pASQro49VflHSISoYExp6Ukgnu66Sk4iSdXvj1ulgwtZDncRhpeURlZXQ3aORXEKwJ1dJyfRh6maz70Ibx++YAiXFy2mwbow6Ih51FIlxYhIDntp4556FMb/zUpJMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756331620; c=relaxed/simple;
	bh=3tptuK9MJ+A2cSfFO09aFBfjOgh9RXe3a1vByS5pMcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W5eTD8ReIwqpodmSBNabcfE/K/JW3Iiyg+VaixB9QsndykoseOv97bNGS5/OltIr/xqNBvt9TzDGQ8yTz3Jtbvt9pDUPaTFPeL4PtsAzfw/ndjHPPXVNKFmUL4SRrZuAw9u1g8eCJvQ0ZATOPloECFldMO0DhD/r2S8UHAxFQnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVBDrdAh; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4717543ed9so271700a12.3;
        Wed, 27 Aug 2025 14:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756331618; x=1756936418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEn8Ne3HB2072aJnQokk4sDSCwEXESgtPT8cGQBeL/A=;
        b=UVBDrdAhifvMNXhrwbecq3xZkjmCcS31PSWct0pNuqQH7EvBK8KxRSt4ycl3spQ9GS
         vYjaKLYdIGclrVF5RVK3dAzZAmvCPj7u1hPEdavSY5cH5xTta+lQh9Gjgg+wDPrpP7B1
         QnD5pramvymYOW7YEddanmt4NkixYWx1RMuX1z+cVAnQqWq7nwK77Wmgc+c+FdOOws0S
         lt7T0X9J9af1cQmmPESnOHsSQYlXo0/5YMYlFOnwRrTZ1dMaFGUunOjoTNvdLEXJpgk1
         bpsw+SvBNZBKw4lBuHTLIXdsoauexNvb94q7rX4r0JHtQ+1OS+JXvBQbg4mDwgYe4QoH
         cWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756331618; x=1756936418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEn8Ne3HB2072aJnQokk4sDSCwEXESgtPT8cGQBeL/A=;
        b=g0S7G/iWtR7CisiIpIOAVpAiK+AVxL/tg/JmrfA+vZoxZyQJTNZ7gios+S8cGp3CIX
         koN7IwR6GL2+tfPcqa/SPm976I3ciIAVwDDPKvBZM2/KcXG8TR4viuRihYHI54ynlvqP
         jL/3+L+ThFLB9WyI3U8w70xT6zmJviMfIL4xRebdigXwDsheulqFEQGRAg6M2QObyGYz
         i6gtS9xxkrYYBilwb8LaEzOKj8BZg2O2SY2fxgLRFebXnWwKZRnKaLlq1+nNVQYoVyS4
         0MRr/tq62iK77VBHvTUmP7vRn7YTgrsCAD8T75aRcnVbE0ptbEVa/FOG2rrXtpxdxZAh
         oMQg==
X-Forwarded-Encrypted: i=1; AJvYcCVay2V3gW43d6Y8FE7Hp50TZwCaMhzVjC8VEhFRUe82y+oOxpoO/ce9IZBFc3f/+p1/s1/HjFq43xyOeAsM@vger.kernel.org, AJvYcCXnp/4M5DX9e6G5HXKbWAHx+WlDH2QfhGf9MlO6XwzgYD5ru1Ikc+pkTIyemeQGE+XJwP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys1hlDtxVVAIYpAWfkErHJ0GSj+EQ+/Q804U6yhsXI8JNKTWYe
	+dgwd36OhzWbv+nXuMUpSQmylmyH5uHw6SnKlSYyNp4MBgJm+bz7XYOI0wO6xix/sj4WVIX+CXE
	89PI9xeoJPHpoAEwvq9LMrEZRjcVhXdA=
X-Gm-Gg: ASbGncvq+fPxlj+Mf9mZCx/etcv+9ZvdnPEW6adaUZIxoIPW/thXpd4D4nb+pOIo8Cm
	akGAAjf9i9N4XA3ESpiykVI60u4Del/T6wPzrbwD8xj3dNUEViEnEK6Bxvt7M/2PIZb0HzSeuxx
	ZUtzJIJv0WKFJiws8horWVwodHo3qOe5CSplu2inbvQCNT54VYmm+HhIT4f8TwJ/FgbelOTAtst
	uVF1V8EFPrqH4UW+xLOmaTiY1BFAq1FeA==
X-Google-Smtp-Source: AGHT+IFX+b/ZzJ/SDmHZZwblb9nDhHueYMW0fUFQI0bQkr+xbXuQM60D9SPj5WjZsST5/RhRxSHcIKQvzNHUkFqd5Iw=
X-Received: by 2002:a17:90b:1c02:b0:327:6f34:3771 with SMTP id
 98e67ed59e1d1-3276f3438damr5616329a91.17.1756331618471; Wed, 27 Aug 2025
 14:53:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKL4rB3x8Cd4uUvb@krava> <20250825022002.13760-1-chenyuan_fl@163.com>
In-Reply-To: <20250825022002.13760-1-chenyuan_fl@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Aug 2025 14:53:23 -0700
X-Gm-Features: Ac12FXxhPGx8AcHhTJQydBJdsPEWkebZKCwzY5tOcU6thRSn2MpqZPeIsxme8R8
Message-ID: <CAEf4Bzb_3ac0dPnkuMqs-dCrTEWqjVt-fsGWGyHAai_bUxubNA@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] bpftool: Refactor config parsing and add CET
 symbol matching
To: chenyuan_fl@163.com, Quentin Monnet <qmo@kernel.org>
Cc: olsajiri@gmail.com, aef2617b-ce03-4830-96a7-39df0c93aaad@kernel.org, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, chenyuan@kylinos.cn, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 7:20=E2=80=AFPM <chenyuan_fl@163.com> wrote:
>
> From: Yuan CHen <chenyuan@kylinos.cn>
>
> 1. **Refactor kernel config parsing**
>    - Moves duplicate config file handling from feature.c to common.c
>    - Keeps all existing functionality while enabling code reuse
>
> 2. **Add CET-aware symbol matching**
>    - Adjusts kprobe hook detection for x86_64 CET (endbr32/64 prefixes)
>    - Matches symbols at both original and CET-adjusted addresses
>

Quentin, can you please take a quick look at this patch set, when you
get a chance? Thanks!

> Changed in PATCH v4:
> * Refactor repeated code into a function.
> * Add detection for the x86 architecture.
>
> Changed int PATH v5:
> * Remove detection for the x86 architecture.
>
>  Changed in PATCH v6:
> * Add new helper patch (1/2) to refactor kernel config reading
> * Use the new read_kernel_config() in CET symbol matching (2/2) to check =
CONFIG_X86_KERNEL_IBT
>
> Changed in PATCH v7:
> * Display actual kprobe attachment addresses instead of symbol addresses
>
> Yuan Chen (2):
>   bpftool: Refactor kernel config reading into common helper
>   bpftool: Add CET-aware symbol matching for x86_64 architectures
>
>  tools/bpf/bpftool/common.c  | 93 +++++++++++++++++++++++++++++++++++++
>  tools/bpf/bpftool/feature.c | 86 ++--------------------------------
>  tools/bpf/bpftool/link.c    | 38 ++++++++++++++-
>  tools/bpf/bpftool/main.h    |  9 ++++
>  4 files changed, 142 insertions(+), 84 deletions(-)
>
> --
> 2.39.5
>

