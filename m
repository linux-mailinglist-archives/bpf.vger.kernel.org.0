Return-Path: <bpf+bounces-21930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 534898540DA
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 01:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E931F23B03
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D263385;
	Wed, 14 Feb 2024 00:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmFtFUGa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA774688
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 00:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707870597; cv=none; b=KonBj5k0ps/g2+XCWTJmbLbBUiLZQDWAE0QM55URk+FgFQwMgOfxKkkKiebf4SKrm83+MlKP+3aqHO8GreikNiLl2RHm8cnIhdU72Gw6a7gGmWCcKL3prL483U2Nndyn9kAYiW/jI2fAh+90CyM+8CzYOrq5ys25YDkt4yKHn54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707870597; c=relaxed/simple;
	bh=5fux2eg+/xiPmeQA+sAKohz2TvVs026HnNubH/qW0Io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9Jr1Ac358tcAm/lwfOzs+z/0hvVweuFkqj5RqtQmsfsOc9qj1inzSMXKi2kVk/scBMXdsCjByWridkwfQ6jqK86eLYSPSeMa2R3akjke7hi6cXbPcLmjkALijkevHNiCNhfAyhlFutiERjHcXSZESHga9a1E9IilFomiTjxct8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmFtFUGa; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-296cca9169bso3024266a91.3
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 16:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707870595; x=1708475395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fux2eg+/xiPmeQA+sAKohz2TvVs026HnNubH/qW0Io=;
        b=OmFtFUGakGobacTPRhSGoY7SK+YIQNpJY5mVb5yUQBb/V69SABGl5rudA9VypRsBd5
         m8yLKjoor5NH5Z4BFzJiUgfMWEEfGOq6JXQGF72XbvuOeKH21EcRpgUjDA79Uzg+PLAJ
         WFokiRtv+3bB/RxMTpzek14jkPVjaoh4JLUPT+Yf3z1lP9+Gn6NTmTXK1Z868xSRXegs
         BL28FF/hpKJoQNeFvYjKiccq44QZ3AcPRd3ZbsQL9CcpxV+nz2C0h/3DH8j4OaGKDoWm
         8UQSTo5O20WYgalaHHrII1R7ktk4yAtZ1kftZGjpdx7ox4SuVJVZEIIk90ZOtd7sA2/I
         M1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707870595; x=1708475395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fux2eg+/xiPmeQA+sAKohz2TvVs026HnNubH/qW0Io=;
        b=fA3Utx0co37OgLAXhKk0Ha7uHEdMNRqNkRnIKoWW7tPBLfXqg4O8qmVYmyS92CUseJ
         u4QzgSmfLXFNXgMjpeFuXJQX2UGyBl3jaQGNVDP8jufe+bM+Hl0RNOnVTBWgjgRlrn8V
         niCOWUpZZQ594XADBN05mAFw8ZN51ulR2/Q+oUiSJI/4gDZaNIENKPDxXkKzJLsDMgOE
         PmRw9WOSsV5LgogyVeVjBqgS+b/TuLpv1yQkt1LwubNWuqQN5sOkykFT/hWYBjuRjWru
         9kgx1aNg+IXhIn44ZpsZ7X3UwN+6YkJXktRFcx/iaAW7Ezd4rS1BJt2yKni3bFIBSxN3
         U3LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxnNQVFKRxVu8JyzoZfmHSDW26vudtm6CxJocJwSNPmm1Ydl/jIlO2nnUZLhqSpzjL+PkXsJb8g6VYS7GZ3TsM1iVs
X-Gm-Message-State: AOJu0YwCb5VI34FhHSgftTuHWpD8pFCyc3dVO+hn/cgdZK017lppQGGy
	iV6gtfCMrMrU0nvgHs4C64ILNUsKOVte9nvbB/fA8VTemfFSrEJwxJt9GDFP9vRW66KQW0tnWQA
	DoQCch5udiRiTBAAxhJmEJiUd+Ek=
X-Google-Smtp-Source: AGHT+IE+v7yJbxaSsKt94A+5QCquxuqInjdOBaGqge2m9ZHyWfFqhEW6nZsCuTM3G/VkJGuLfjB4TRS/15NNUOOtnoQ=
X-Received: by 2002:a17:90a:f40c:b0:296:15ed:b220 with SMTP id
 ch12-20020a17090af40c00b0029615edb220mr885759pjb.45.1707870595471; Tue, 13
 Feb 2024 16:29:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-15-alexei.starovoitov@gmail.com> <e9fbe163f0273448142ba70b2cf8a13b6cca57ad.camel@gmail.com>
 <CAEf4BzYbkqhrPCY1RfyHHY1nq-fmpxP2O-n0gMzWoDFe4Msofw@mail.gmail.com>
 <7af0d2e0cc168eb8f57be0fe185d7fa9caf87824.camel@gmail.com>
 <CAEf4BzZyPDdtV8xyFxpLmPQpKrtO-affGrEfyDkodr_BDHVZcA@mail.gmail.com> <978e656fb27850b002194f0cfdbe603997ef70e1.camel@gmail.com>
In-Reply-To: <978e656fb27850b002194f0cfdbe603997ef70e1.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Feb 2024 16:29:43 -0800
Message-ID: <CAEf4BzaXgFK6Bwkhzw3=2EOETvJK1-23GtucmTLMFi-QH5Sb4Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 14/20] libbpf: Recognize __arena global varaibles.
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, memxor@gmail.com, tj@kernel.org, brho@google.com, 
	hannes@cmpxchg.org, lstoakes@gmail.com, akpm@linux-foundation.org, 
	urezki@gmail.com, hch@infradead.org, linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 4:16=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-02-13 at 16:09 -0800, Andrii Nakryiko wrote:
> [...]
>
> > The "fake" bpf_map for __arena_internal is user-visible and requires
> > autocreate=3Dfalse tricks, etc. I feel like it's a worse tradeoff from =
a
> > user API perspective than a few extra ARENA-specific internal checks
> > (which we already have a few anyways, ARENA is not completely
> > transparent internally anyways).
>
> By user-visible you mean when doing "bpf_object__for_each_map()", right?
> Shouldn't users ignore bpf_map__is_internal() maps?

no, not really, they are valid maps, and you can
bpf_map__set_value_size() on them (for example). Similarly for
bpf_map__initial_value(). And here it will be interesting that before
load you should use bpf_map__initial_value(__arena_internal) if you
want to tune something, and after load it will be
bpf_map__initial_value(real_arena).

While if we combine them, it actually will work more naturally.

> But I agree that having one map might be a bit cleaner.

+1

