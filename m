Return-Path: <bpf+bounces-55202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB1DA79AA0
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 05:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B0F16F291
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 03:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207D0193086;
	Thu,  3 Apr 2025 03:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDoV4msK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18201632C8;
	Thu,  3 Apr 2025 03:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743652134; cv=none; b=qxPlHouOvuBsntodosWk9fOOONuyc/x3lYRBCgqoBDWJaEwjq5+EcJ13EfzXOQtmjCI2o6xvrsZS8rSWtuGEKmJIuApxciEsofLnspr2nlrbFEp63XiyJVxFLv8g81lGMdpBHeHtw6+spCmN0lK4BGVGjva12XNdUXEipv3aP8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743652134; c=relaxed/simple;
	bh=nQsffHB85D3ZdvJ1iGaLJP3iXAutWcm/wOTfqKIhpVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFK0KOpBKmcXPIqU3r9jsfFbgvTpC78fu1sdn9e/oXQi4RKwKRCW6p6bifV/swSd7kZL5P5OVSfmiiJ2aqQJR5oqNajgxo4oFyCVlZC5flv5wVFiUFimDxQp4cLg1/iXSyjp63q0GRtiPTFdjIHanIMefN07+eumEGRX/+7eoRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDoV4msK; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf848528aso2798265e9.2;
        Wed, 02 Apr 2025 20:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743652131; x=1744256931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jc94mRlC9jV6xS8JzhLYqXI7SHfqDbj2Tw2Yylylsk=;
        b=jDoV4msKrhpvBwjkc3atbheFgZg2nJBmNFUWOoGX9e5KlwgzkicExhYaB3x8oxnc8o
         6LX57N9gbygO3sl3iLXTnW+4b4MKkECvKW3PzlUd0K227RQJQ480E3DQG/HmupGvw4CL
         sbelBcCFKz6cgmdyLZMFDoyUC+E3l9qfvBq1QvIVJbz+tpC0RaZvJn8aTm5UcuurqhC2
         R0a1+b06YyvZAFSV3qCrLnD9PwuHEuc+l+XZjuPzw3OGWlsyOw41J4cUceackWg57d42
         LUevaJk1n9B9MdLCF8BFqcGFw4YhkkIBSFMHy51kjChKOzjFJRvem5T384v1vm+HEQZ5
         DsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743652131; x=1744256931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jc94mRlC9jV6xS8JzhLYqXI7SHfqDbj2Tw2Yylylsk=;
        b=lMJ8+EM/noPL0Cu9juC7vmHPKxpgEs95a2//kPWtxinx/J3EtAmX6wkpU5MyAibyqu
         amb1v9OmrO3ekjP103TDKtRfgV6XxPYZKcdjhvJZ1IWqdzF6wGreliW4gBYDqfdq8P1z
         amW5oGtWZE4tX0ZBgo6uZkrK+DoPlunN3tpYh3lCZgQmOlvBXSJRPwN7ZYymCFx+3bXW
         ZDrbp2uhWJZuoy0dgHuo0eTO7q2MPe1n3P5aWUIpJD4YM242vrKW95ozHzFbGgzr4ArH
         C5VBInQX6LaXwhJR9izDFsgoYpW1ir+qHGIulfwmvviPMdGTwYu7/SIAOlVLbdQDcuAQ
         v5cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP9x5GGWOoGAqVeEct7OoShvXN4SEqLXUBTqz0t2B7kMUbmybRTbNyPAu5yB6C3JCypmo6EoU/F0SkTuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG7CZmMAw1rnqfbmDRVN8ccPdGtFJzYC4RveD6jGKMsUGxL/w3
	ec9ycPqnFIyj+tMSF4XHaf7D9DJowUB3/Frbtrz2DNnq9ql2acKo9kySMLJ0Q6OIDbS/AOLhehw
	3dJOAiA80YYX0ayXTXIe0N6hA/hxNAYQT
X-Gm-Gg: ASbGnctsaeA2pOEbX/jzXWpCK3cZs6Xco99ftRyAhvDYhpZhRW/HaHkTxfQ6hdrgljg
	azUvyS83H+3MmrmqzyXEu4xQxunHLy/zPVdm8S6ChXmFLJFLeFhE78eD3uHTRLOVPlTI1d8fEAZ
	60uj8M5/B4woM6j2dV7xBz0pqcnzI0ZYOLLNIckEh33P4JyCz5Q5bb
X-Google-Smtp-Source: AGHT+IEdKia2hHGcNebu4xjqUqFuxpX3KUAd5XBr9m+mg2qKCJlK/lkaqdG0lNnDFGWxGfmwx/cyFN5y11yGDkj4ycs=
X-Received: by 2002:a05:6000:1a89:b0:39c:1258:7e19 with SMTP id
 ffacd0b85a97d-39c2980a18fmr3078830f8f.58.1743652131047; Wed, 02 Apr 2025
 20:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403025514.41186-1-alexei.starovoitov@gmail.com> <20250402201252.8926c547a327ce91c61fd620@linux-foundation.org>
In-Reply-To: <20250402201252.8926c547a327ce91c61fd620@linux-foundation.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 2 Apr 2025 20:48:39 -0700
X-Gm-Features: ATxdqUEdMaYxpb-nMIHBSdqMPKo17lPBVgJom9Ls--fu9Rhqk2F36cE6qD6dAk8
Message-ID: <CAADnVQ+Uy_sctUkEFN4P6GEO_=5Q6n2XNonWaJYfz7uW90QWTQ@mail.gmail.com>
Subject: Re: [PATCH v3] locking/local_lock, mm: Replace localtry_ helpers with
 local_trylock_t type
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 8:12=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed,  2 Apr 2025 19:55:14 -0700 Alexei Starovoitov <alexei.starovoitov=
@gmail.com> wrote:
>
> > Partially revert commit 0aaddfb06882 ("locking/local_lock: Introduce lo=
caltry_lock_t").
> > Remove localtry_*() helpers, since localtry_lock() name might
> > be misinterpreted as "try lock".
> >
>
> So many macros grumble.
>
> +#define local_trylock_init(lock)       __local_trylock_init(lock)
> +#define local_trylock(lock)            __local_trylock(lock)
> +#define local_trylock_irqsave(lock, flags)                     \
> +#define __local_trylock_init(lock) __local_lock_init(lock.llock)
> +#define __local_lock_acquire(lock)                                     \
> +#define __local_trylock(lock)                                  \
> +#define __local_trylock_irqsave(lock, flags)                   \
> +#define __local_lock_release(lock)                                     \
> +#define __local_unlock(lock)                                   \
> +#define __local_unlock_irq(lock)                               \
> +#define __local_unlock_irqrestore(lock, flags)                 \
> +#define __local_lock_nested_bh(lock)                           \
> +#define __local_unlock_nested_bh(lock)                         \
> +#define __local_trylock_init(l)                        __local_lock_init=
(l)
> +#define __local_trylock(lock)                                  \
> +#define __local_trylock_irqsave(lock, flags)                   \
>
> I expect many of these could have been implemented as static inlines.
>
> Oh well, that's a separate project for someone sometime.

They need to be macroses otherwise _Generic() trick won't work.

Thanks for applying v3.

Do you want to take "mm/page_alloc: Avoid second trylock of zone->lock"
fix as well ?

https://lore.kernel.org/all/20250331002809.94758-1-alexei.starovoitov@gmail=
.com/

or should I ?

