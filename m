Return-Path: <bpf+bounces-72167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613DDC083F0
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 00:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9C03B5FDE
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 22:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FB62FE591;
	Fri, 24 Oct 2025 22:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqEiHaIk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F04A26562D
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761345150; cv=none; b=n6shWoBBTkltkaCrWKNVW++CGoiUgYdJOQQ3sLvQIFcVCJEJryWB314ZCSNlOLhiGkNXJlAocMyMMyAv8pywMJ3lJIyjEODvlYCKdkdzmxheUGWmrO7CRz/9g5JyPVQ03hiD9mGR2BCeTWorYkTvkJ0ZEZjvER395SRVdfkOTgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761345150; c=relaxed/simple;
	bh=HPGTvP3gKXChLNxuAJRLhDCCzuFV1GUXxkrKedc94G0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POdEzfy+0Ri01R0ulsdIAMcmX1hUi/e8P7Ftx850+Q29vWyZBiuJYTq27yFNpiE1pj6IHkvWVNkNQxpVSIl7zsz3irpULOMxft7ztIzphp1qotm3uDB2Pt4HCZsEluGm5Ymz0RXBnxv2cX+gij+4cIoDg/2te90N7RR3q6hCjTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqEiHaIk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-426fd62bfeaso1283061f8f.2
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 15:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761345146; x=1761949946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUfYp53fu94dUtqrZRLYGe5gVG2u++6KcY9W1vIJxhk=;
        b=RqEiHaIkxFz9Dx8hDR1beXLBZi3UwdD1OJYyVxhZDz9vIru5gwYKv9U9fJBTJyxQ2w
         YGILFxPHHT+dlUOaapUAkra4JzA1coxO+OTExZcSHJHPaG7VKAvf6GttuA1DLQpFs2Ml
         NEFOI62dbzknzrmtW2duAvH7vTKJ/de6M9YDYfAbe6PTMuaxie6vF5PGlTmsj18AlTt5
         Vip+B/xdnXAA39jpd7oPGquJRFr0xDxp9ELyn9uUiH7hOH9Rhlx7USj8n4fo9QTgIk0m
         TndUnZ/3Qgis9gF+EiXqPrLse3HPJcHU9iuIYcUUsioQEVT1c4iUJ4g2FqBxNAmg1M71
         786A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761345146; x=1761949946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUfYp53fu94dUtqrZRLYGe5gVG2u++6KcY9W1vIJxhk=;
        b=KlZkEE6nTfLbTsYyCuL+SQsk/6cW2btX7AR95xfsJiU8hwrSBQinc2oxrXUjIPHHSc
         xV0h8Tcw7e4eZX0MC66Kz2JlGXauI29MpNvtyy7hgfirGijIrOomeHrcbUSlmPZteiYT
         1t4/QwazRFMU7KoB1vjw4Tg0TTx4TcaVbULaOYN9iyur975j11HNaE/obrc80zSUqoaj
         bRxTC2GLB3oLBCRuiySZvUiLq+Izo+oBjj5zD7zHW7Zzm22dE682ToC6KcWw3bfz9CXC
         RzXrImPPvwytoJlwMkCty0p08CbM2WuHVra9Nyukdkv6xrjMbMYMs/5uyjIf3DmGcdb7
         VYvg==
X-Forwarded-Encrypted: i=1; AJvYcCXbrS73llksn0NRMjfFEJ4ey618vydetALTKguOYVFvPd2DcNaBGG+VGOj5iiPbOrMdHY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0fdywHv4ISR4hoQ7PPyYEZWq400atS6oFXcTIztXTZYaouekA
	olyeBD04l+DYGyFGlfWMiP2q1IDpV81XBN2ulr4o4awUd7vnfveV3auNB22pnXmvUZmDXRijce2
	wyNQ+TOIfIpFisloPQD60vCOTxgzdqMI=
X-Gm-Gg: ASbGncsHb3khyPacPPgj4Dgfqfl/wK+2tPiVCZiZKwAJOtkr61vt9KGPE8mUEKg+eHH
	ZtnZGJLhZFLLPKfXP0dGJzzfazHkE61V8jhqGLq4sHf8HfyZfFx8LSrLC1uxdGRMe9j+0z3adcO
	M25NEyQrOBbJ7HCIvHAlbwHSfSwHuWV4X0O1tdqZ7k+IpoGjoDfG6M77QXqToq2u4X/OE5MuZ9C
	B5WQxl4+KHNqBbXAF6BBnOP8i7yFhyUJORANVWzFrbVko5mOII0wAVQcGp/iSvJEygyp+QDtJdl
	mqoSLUDv/rkT/RQvDQ==
X-Google-Smtp-Source: AGHT+IEk6kGBtRPTTE7UK+dCfFed6KOoSdQT4rrIfK18Wcd+iW19phRfPOMaAHllUvSpuZUGkBdwBVCywmTCWEggRpM=
X-Received: by 2002:a05:6000:200c:b0:428:3ef4:9a10 with SMTP id
 ffacd0b85a97d-4283ef49ddamr18538286f8f.54.1761345146453; Fri, 24 Oct 2025
 15:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz> <20251023-sheaves-for-all-v1-12-6ffa2c9941c0@suse.cz>
In-Reply-To: <20251023-sheaves-for-all-v1-12-6ffa2c9941c0@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Oct 2025 15:32:14 -0700
X-Gm-Features: AWmQ_bmYxy3mKLZGuaPpnI1v7zjS22cZzV3kwSBj_coWNlSrdgc_1YOXiQjgS1Y
Message-ID: <CAADnVQ+nAA5OeCbjskbrtgYbPR4Mp-MtOfeXoQE5LUgcZOawEQ@mail.gmail.com>
Subject: Re: [PATCH RFC 12/19] slab: remove the do_slab_free() fastpath
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 6:53=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
> @@ -6444,8 +6316,13 @@ void kfree_nolock(const void *object)
>          * since kasan quarantine takes locks and not supported from NMI.
>          */
>         kasan_slab_free(s, x, false, false, /* skip quarantine */true);
> +       /*
> +        * __slab_free() can locklessly cmpxchg16 into a slab, but then i=
t might
> +        * need to take spin_lock for further processing.
> +        * Avoid the complexity and simply add to a deferred list.
> +        */
>         if (!free_to_pcs(s, x, false))
> -               do_slab_free(s, slab, x, x, 0, _RET_IP_);
> +               defer_free(s, x);

That should be rare, right?
free_to_pcs() should have good chances to succeed,
and pcs->spare should be there for kmalloc sheaves?
So trylock failure due to contention in barn_get_empty_sheaf()
and in barn_replace_full_sheaf() should be rare.

But needs to be benchmarked, of course.
The current fast path cmpxchg16 in !RT is very reliable
in my tests. Hopefully this doesn't regress.

