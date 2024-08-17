Return-Path: <bpf+bounces-37428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F4B9558ED
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2024 18:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E831B1C20E29
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2024 16:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE2015539A;
	Sat, 17 Aug 2024 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Wb8Qxq0Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B41155300
	for <bpf@vger.kernel.org>; Sat, 17 Aug 2024 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723912004; cv=none; b=E6v9kwgfqnMWviC5hu/lrx/N9xMgyLKTUU+ef7N0LlGqmBO53hdW+PeN3V0dxGupFGPs4K+GqKGwRFkPHfEpglfM/px2SsJSii2uGjbybYY0GuiQJmAsiEPDdpd5n//hgCi2UVzcLRZuPb+biezKcSc7WJvOmLX8M2+dOpolq+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723912004; c=relaxed/simple;
	bh=9dkMY8jFzFQfn6EKGYFPV4tiA60zbFODArOLJ5YzeIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbV+smICeRpt9gCWNS3PMN+t1IZAsBohaI1acNeKf5VOlKBvAk7WLmkpEZg/NBz6ycg9InUu7vbef1CwfO1VBxKW3kPUOniM/dG2KNPFXm+7XDS4DvyUL6+keHpH+PrGU7xvilN+UYr8KZuMUeYfiqgMWxmw79+DMdfKmUnwplc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Wb8Qxq0Q; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f3bfcc2727so31121661fa.0
        for <bpf@vger.kernel.org>; Sat, 17 Aug 2024 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723912001; x=1724516801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bJUpF+ZilJ5tJUWYdG1B4XodSC5itu+LywsKXdFMvvc=;
        b=Wb8Qxq0Q6QlvbrL4LYHVdGcdP1ReqQ6RM71H9fGG7sYMu2jIALrtu4opf2UmjB/bDW
         EttNaZssMQoiZ5rBDaPL3jPPV56ajuJx59Z98XGZWo/EZ8HZEjBVvp1SZxOwQcJnm5HH
         bUJgmTz4wZmxQT05vumNN2OOUSwr6LKhmtKYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723912001; x=1724516801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJUpF+ZilJ5tJUWYdG1B4XodSC5itu+LywsKXdFMvvc=;
        b=GBm9gamMtWPDBgcBLPjN+gNCyrTUogzvUyw8zlWPcjPR6qukkgIvGpYfXqZW8ryFaL
         pgXEhCJ1Jl12ZZTRkBIy6hFgdMrd3enUJbKQvSoilhxaguF5w+gau1AQReVDbgZN9TiQ
         1H82TRRyCBkaVtlMvZPk4MNettiqpE+7rF8UuKUJpPA2AOhEYHAIBP2fMgciV6SJPe3t
         CZWm2wUjMB/ssCjspmPk5teFRydHoozSff+EgtAER+AS9Dx/QXlbeAyjP2b5JykUOe+A
         v5Ja06jj0mZS87TWzuhBPR+RwtIdULFlHiw8B/vhFoOOCr0v0xpkVplGNqfRyBzRXr2p
         DLJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWShlRwu2y3RRgJOdy0yTArPOq55az8Ek3OSUK1k65eMwAsOx+nLGhJmulQyFqF1uouZPAOR0xgr70s+1SF182Ww9Gj
X-Gm-Message-State: AOJu0YwQU/0hUImrLxlvOSQFaIyZxbOC6YxltR4Hw3ssF9BZKIxiBK0c
	R+7ls34XJJyn7xnQJkxg2DwYfd9GiLACem3eF34RBf/SiL7td1o12l9/9XBlIsIdB3qv3uLZued
	W1f6hjw==
X-Google-Smtp-Source: AGHT+IGKYx8iCJQOPptvDHk5wnwh9Nn91vABQKnXZp2Ooe5wj5++ly+JER1mU9I9vyVZ+WLie6ukeQ==
X-Received: by 2002:a2e:a9a8:0:b0:2ef:2c68:a776 with SMTP id 38308e7fff4ca-2f3be5d9f6bmr62177941fa.37.1723912000589;
        Sat, 17 Aug 2024 09:26:40 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934116sm417846566b.109.2024.08.17.09.26.38
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Aug 2024 09:26:39 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8384750ca7so113339966b.3
        for <bpf@vger.kernel.org>; Sat, 17 Aug 2024 09:26:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnjBpfJl3/1wqqAMi4OuB+zL0C0d7tO5DjqG8rkH4+m3VqNTaWR7IaHxS0WkkuHRMkk3g3jycRH5gjQwUUHZStFV5K
X-Received: by 2002:a05:6402:278b:b0:5a1:b6d8:b561 with SMTP id
 4fb4d7f45d1cf-5beca527ec4mr6027442a12.9.1723911998605; Sat, 17 Aug 2024
 09:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817025624.13157-1-laoar.shao@gmail.com> <20240817025624.13157-6-laoar.shao@gmail.com>
 <w6fx3gozq73slfpge4xucpezffrdioauzvoscdw2is5xf7viea@a4doumg264s4>
In-Reply-To: <w6fx3gozq73slfpge4xucpezffrdioauzvoscdw2is5xf7viea@a4doumg264s4>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 17 Aug 2024 09:26:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_U7S=R2ptr3dN21fOVbDGimY3-qpkSebeGtYh6pDCKA@mail.gmail.com>
Message-ID: <CAHk-=wi_U7S=R2ptr3dN21fOVbDGimY3-qpkSebeGtYh6pDCKA@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] mm/util: Fix possible race condition in kstrdup()
To: Alejandro Colomar <alx@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, justinstitt@google.com, 
	ebiederm@xmission.com, alexei.starovoitov@gmail.com, rostedt@goodmis.org, 
	catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Aug 2024 at 01:48, Alejandro Colomar <alx@kernel.org> wrote:
>
> I would compact the above to:
>
>         len = strlen(s);
>         buf = kmalloc_track_caller(len + 1, gfp);
>         if (buf)
>                 strcpy(mempcpy(buf, s, len), "");

No, we're not doing this kind of horror.

If _FORTIFY_SOURCE has problems with a simple "memcpy and add NUL",
then _FORTIFY_SOURCE needs to be fixed.

We don't replace a "buf[len] = 0" with strcpy(,""). Yes, compilers may
simplify it, but dammit, it's an unreadable incomprehensible mess to
humans, and humans still matter a LOT more.

                Linus

