Return-Path: <bpf+bounces-27022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B638A7C45
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 08:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF771C22197
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 06:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8368C56464;
	Wed, 17 Apr 2024 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2d1MAgi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE0329D06;
	Wed, 17 Apr 2024 06:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335178; cv=none; b=i6/ftHx6bceRA9K7BbX5/ry16nrZyBD4rjKIFQ8ghQXf5ITJ1T9RhyiRA/Bgfg8YB+mUo+VeMK8SCnCOxENnTF5hS7cnDUXtzgX7+c8Lt+un1VyIMWVlUzYqc1oJL3HLzrIn1nXR3BYSbHR+tZLKvxI5D0tlo8JDXi+YqSELbdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335178; c=relaxed/simple;
	bh=R8Sytcd0zdOKyMmrxcQ5ptLPbB+DTVIfGCrBabF5ANY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbOEhTyh9UhLeMCi/qKg4uLaxR1H6BMDVGxEggw1JGS8GUCTrCzrB784mL7uZgXE/MJAyCKUDBbMDrLmHkGEOiYmRI0ZHUtbFMpU8dJ/m6T75lIVrz4iFpdPwo6Lof/8uL4TczJAT3NlrhIaSJ8sZgD2miArwxe14pqhsepe1N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2d1MAgi; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d94fde45deso25240139f.1;
        Tue, 16 Apr 2024 23:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713335175; x=1713939975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8Sytcd0zdOKyMmrxcQ5ptLPbB+DTVIfGCrBabF5ANY=;
        b=I2d1MAgisLhTuWw4urKMuFYOLKtM0QZZHlYO18SPl5xeogKsuZAMY0vGXIoNNLN/5E
         w2UV+r8Xyka+HQG64JrI9BKSJfQlPz8pfct7VH768PojoaRvCM2JTjtA5g3aix5N5Gmr
         nvUn93P/cTuNXZglnIFkkntlV6W4Ol85E7N0laJ4b5nXAEBrzZ9VfsnHxFFoeMKktOcr
         vL506xrQNbQlv2RJzr3dQEEgn5wb/Rw33PxYDpAFlOLlL8lc3Du7GsSDHUy/3OWKifbX
         SETqDKM4XU+b3tKg1roljht4pCqwekSpuUN603S6OJfeAlmxnoTjuVICHk85+C87BZu/
         SsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713335175; x=1713939975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8Sytcd0zdOKyMmrxcQ5ptLPbB+DTVIfGCrBabF5ANY=;
        b=tBvlTMo4EpfAz71kICX02Q7SBV80cXy5AwC8vYfT7JS96+XmqsZv29j4pqA9u9OvHT
         B0ZaVAbMcQifZerB6wW6N3nmPQeipBHdpQ+hz3CZY+QZZrgAxsM/FYXfoLL4k+DxKQPA
         mnDL0Ccr4/hCWV57y2HHhcx5aKgV6P3+BKDoEvlavXw7D4a3z3Cf/20BEnCgm/3OGCzV
         QZwoQLi1glOndedKtQVAdREWJI80i+c1c8cpi00zeuXg5lwAELylvhTZhLQFstifXV1/
         2idU9zfW4jUbIs+a7cxJKGU196wW7flmUreTS61pbS6bBUMpD/BXMJ2ABWU2Mn4DGfPE
         HrFA==
X-Forwarded-Encrypted: i=1; AJvYcCVux6PUPTZtO7QpxlCFXzGsmuHHw9OmSDVUahGub0gGtCgN4WVqpjaiIGgUjmYxgv48R6zsjmAVWA1GFWM1tMjGhtlNFgKm+imJmuoM+LCneOy4hMmxsI15P6E6Az8OvzFl
X-Gm-Message-State: AOJu0YzHhwmMZsX2RkrRYD7f0IZwn1go7oAxEDrreKdbCD3QT49l/9Pd
	edONEDupXmdZnvBQ0hYs/WSnE0QLc+VrdBTV67hilr+yZTTcoNaaR09+zIJNMc2tq7lZjF/cxMB
	OpgoqC0OTAOEfMmer7l4iysOb8pE=
X-Google-Smtp-Source: AGHT+IGwbrnBPuuGW3fDaUnHH3zdP9PR1lsn/gkIcmftimODj6RqHyVul1zeySTkUj80e3azBaobyXEPZDzHh5LifWg=
X-Received: by 2002:a05:6e02:1748:b0:36a:fba4:ec45 with SMTP id
 y8-20020a056e02174800b0036afba4ec45mr18817708ill.3.1713335175168; Tue, 16 Apr
 2024 23:26:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414045124.3098560-1-dmitrii.bundin.a@gmail.com>
 <Zh0ZhEU1xhndl2k8@krava> <CANXV_Xwmf-VH5EfNdv=wcv8J=2W5L5RtOs8n-Uh5jm5a1yiMKw@mail.gmail.com>
 <Zh4ojsD-aV2vHROI@krava> <ddc0ac5b-9bd4-f31a-a7ec-83f7a10e6ab1@iogearbox.net>
In-Reply-To: <ddc0ac5b-9bd4-f31a-a7ec-83f7a10e6ab1@iogearbox.net>
From: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Date: Wed, 17 Apr 2024 09:26:03 +0300
Message-ID: <CANXV_XwGhdV7v05Xjjp-g9yW4E0FjA=84M8jZ6bcf7yuooDkig@mail.gmail.com>
Subject: Re: [PATCH] bpf: btf: include linux/types.h for u32
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	haoluo@google.com, sdf@google.com, kpsingh@kernel.org, 
	john.fastabend@gmail.com, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, andrii@kernel.org, ast@kernel.org, martin.lau@linux.dev, 
	khazhy@chromium.org, vmalik@redhat.com, ndesaulniers@google.com, 
	ncopa@alpinelinux.org, dxu@dxuuu.xyz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 5:47=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
> Please add the error description as motivation aka "why" into the commit
> description, otherwise it's not really obvious looking at it at a later
> point in time why the include was needed.

Doesn't the comment /* for u32 */ following the include explain the
purpose? I thought the include was actually missing since relying on
indirect declaration of u32 is relatively fragile.

