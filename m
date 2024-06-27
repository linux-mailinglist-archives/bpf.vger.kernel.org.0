Return-Path: <bpf+bounces-33295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A9C91B19C
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 23:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA4A281FA5
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 21:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F1A1A01AB;
	Thu, 27 Jun 2024 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XcJ1lHTa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF2F249F9
	for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719524553; cv=none; b=mtwB3sO1N84eabqrXxy74VyPTYPtT/v/o/695LYbAxwycjIZDkJUsZpfVfaNMnYfWxjFhogrg6vZy6wAo5W0lYDzZRN2/2TcuCEWyj5y7PFFXrCiMdrApGAcwUuP8rj5f9KUkciG8eKZxT6ngRWK8l6vqz7bjqxZTBXKOvhWe4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719524553; c=relaxed/simple;
	bh=yIjlLV3+Gh46EqUdFTilZy9i2teaCcKHPXQwTDwoHLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTUDtOLOxzr7RtcnK0lcSKzUgQoVoKvB/hBcIUxR302XNl/5MXUdfCY3d+vZHFzphURQ0Xo6reZsFJBbtTmU7e6NyvaJMOEbkonimHt2gUMWATbGOEyjcXOEzdblCT/nmNvFDoXMMENR1gxtaMGLkOmPyuuBcNVVrrYUg/qzc0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XcJ1lHTa; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3636c572257so6806991f8f.0
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 14:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719524550; x=1720129350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIjlLV3+Gh46EqUdFTilZy9i2teaCcKHPXQwTDwoHLw=;
        b=XcJ1lHTa8FUkgKfUoHqPR6iSpegP1dsI7IbL5VkIEfeW2VftWCQllA+2KlYk3v2Od/
         +U47l4HE9X12AcNmVporwMC1QOg+Twz2UZOxnbDNylnWsUn+p4QslU3THbwQP/KNNRXC
         gzZD1vaV/OUumjJ5o0FlNuLOe6XO9btPAT6NDLBpIB7hW1NBWObGdKyf6e/1upLtJsZW
         ohPSv/Y/CsUbT2qVFOwqPqPi9lJTmeUWXkhGsfUWVHx+XaE/41ZI7bYNOxCZu7vIxwnA
         LfmPurLfVmoI4uu7ibAA86APgdAle7lTZ5hrnamKin+3443K3PLhfj4mrU0lFsniLwWj
         quTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719524550; x=1720129350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIjlLV3+Gh46EqUdFTilZy9i2teaCcKHPXQwTDwoHLw=;
        b=PX7lOWfuA//69E/CufNnIhJHFu1+CuSDqtIj8sqnEpEEctf4BQprC5czGSrSf6Njuk
         y3q1aYmHOoNUO8G0yg8zay2dfLjxoTTyY/YHOrqMlKTMIC2WzNBfEFwxdKWntxDTezWG
         W+iTCrW1EFSFQMiAnOeHwcH2nAtIp2xvzigHOBXF3DzsW3eO4KCdYVWz8W+7oYPS5GI/
         K4e9Oo8CoYRJRUg0JoZRAbLH2vhElN5FERwMtVK8hwN2PyMrw62TEe5hkdq73RTrsxJK
         nScCMisUJ6HGG6k6oMvCi+l1v3RzML7y0xNhIy1u5zqdOrmivamuJfT+/exdFVV9EHu/
         WpQg==
X-Gm-Message-State: AOJu0YwCJnXD2NEt5ZXvpgQH8AtQX597HPjZW2XQriGH5XrOaFsUZYvu
	MhF6vWqEnBlm36mPlTB5vs7RtfdUR3LB0fbEw+uS9KeO/yobv7QcLcKk7zExycZatw3YNIYfx6t
	q8Qb7TK4jgk4INBMs6HiS+x0UjaqEKsqYiH14erAr/m2C27YudX2A
X-Google-Smtp-Source: AGHT+IFqKcZjrBqDZxphr6WtcE3CcU/enUigjZklXRpwMJNBGBhuMM1g1fWCr028B2gZnKgiwIq3tDnZ1lacMhNhsNQ=
X-Received: by 2002:a05:6000:2a2:b0:366:eb45:6d54 with SMTP id
 ffacd0b85a97d-366eb456e70mr15954495f8f.48.1719524549539; Thu, 27 Jun 2024
 14:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ef22d289-eadb-4ed9-863b-fbc922b33d8d@I-love.SAKURA.ne.jp>
 <CAJHvVcgfgjPQMxRn09+QKV0G-6AOS6UA7hMbtu2azMquMW4JCA@mail.gmail.com> <1a48d05c-539b-4d5d-9375-f2aaa5fa0dd4@I-love.SAKURA.ne.jp>
In-Reply-To: <1a48d05c-539b-4d5d-9375-f2aaa5fa0dd4@I-love.SAKURA.ne.jp>
From: Axel Rasmussen <axelrasmussen@google.com>
Date: Thu, 27 Jun 2024 14:41:53 -0700
Message-ID: <CAJHvVcgMd9=oXwB_cnyP2_aBKAXSx4+PDryLPn=R_-b6LeGehw@mail.gmail.com>
Subject: Re: [PATCH] mm: mmap_lock: replace get_memcg_path_buf() with on-stack buffer
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nicolas Saenz Julienne <nsaenzju@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 10:57=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/06/22 8:03, Axel Rasmussen wrote:
> > No objections. Looking back all the way to the first version [1] the
> > buffers were already percpu, instead of on the stack like this. IOW,
> > there was no on-list discussion about why this shouldn't go on the
> > stack. It has been a while, but if memory serves I opted to do it that
> > way just out of paranoia around putting large buffers on the stack.
> > But, I agree 256 bytes isn't all that large.
> >
> > That v1 patch wasn't all that complex, but then again it didn't deal
> > with various edge cases properly :) so it has grown significantly more
> > complex over time. Reconsidering the approach seems reasonable now,
> > given how much code this removes.
> >
> > This change looks straightforwardly correct to me. You can take:
> >
> > Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
>
> Thank you. One question. CONTEXT_COUNT was defined as below.
>
> >> -/*
> >> - * How many contexts our trace events might be called in: normal, sof=
tirq, irq,
> >> - * and NMI.
> >> - */
> >> -#define CONTEXT_COUNT 4
>
> Is there possibility that this function (or in general, trace events) is =
called from NMI
> context? If yes, I worry that functions called from get_mm_memcg_path() a=
re not NMI-safe.
> Original change at
> https://lkml.kernel.org/r/3e9b2a54-73d4-48cb-a510-d17984c97a45@I-love.SAK=
URA.ne.jp was
> posted due to worrying about NMI safety.

I think it's unlikely, but I'm not certain. Although trace events *in
general* can be called from NMI context.

This code was added based on the discussion here [1] from v4 of this
patchset. At the time I don't think we had any certainty that this
*was* called from NMI context, but rather just that if CONTEXT_COUNT
was 4 when it only had to be 3 in practice, it wasn't a huge deal, but
getting it wrong the other way would be much worse.

[1]: https://lore.kernel.org/r/20201020184746.300555-2-axelrasmussen@google=
.com

>

