Return-Path: <bpf+bounces-57603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A618CAAD2C9
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 03:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D1116F602
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 01:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263C413D8B1;
	Wed,  7 May 2025 01:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENAq49tR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0439942A83
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 01:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746581155; cv=none; b=qjRa1Zf9MnyJDoGx57DSr5DlYcfo6g6dV03ssIPnvfGOr1WSZI5OFUkDGcFBCG+2h85oA9LyB1syKExwemEP1uxP/Su1HfAsQZ2J4+O8OE6kLzgM/LxbCW3ptkfzZh4MS4aKQEF+acKmlXg9qZM0aJEWt/axgVK3XQkD4hORcBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746581155; c=relaxed/simple;
	bh=iDLqNOiZ6X5IuLOFAsq0Bs2WkFy2qrwehUrS40nImCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=at/mtkg2//Q/KsEnVDeh9MaOuniq9WagE2b6n3HiWrz9941NMPpNwcwacvcZWdqkp2fBJIeY5MQU9aMkaO554N+dcFAM97rb4H7qJjrpNekYH62LEp9E2JvBeLRhPlfMoiAXtKZGPwyPxLmS7bimbRKx0XeRcZqDLlFYdWraVsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENAq49tR; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso271730f8f.1
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 18:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746581152; x=1747185952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mp6h0mXWLqOSoyEmt4D7rmRcGyjeYpketPR55zn1Xuw=;
        b=ENAq49tR4/6BMMmUb42CkdXR2nFjHpipisfpHHvhhW6V3qqlpUgKHwBukYigRCPq/A
         QfsE9omnhgGzOmOpNHreuPDHc060b5jD7QqgFN+VZ9bDH3twiD+K0wQbmbMQVp69RYm+
         1t8kR9dsAx7XZrE0n1RrJrvTNVeuzoNlKOn75ambqeMK76Srdigo+L22rmmef/N/z9ms
         zMv3sgOsFh98Yw6PFWZWQ6/vaDAFDocSukG0BO2En7G6d6XV6rfgmi5xUMzGgbDF7unQ
         Pwu/EFYHML5Fcr6mKm3vYgpJz9AGbiahMNXTjju4+Tg+htkH6KGVWIzBs7lvXhFPj52v
         b32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746581152; x=1747185952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mp6h0mXWLqOSoyEmt4D7rmRcGyjeYpketPR55zn1Xuw=;
        b=WMutvDn5BEHoDZhTfXgVW00q9MGV8uU7/IGYgbhRQy/p0S3cSE5VZXW87Sjjl+mhLh
         pHiy0+kF+dYVufYNAuw5yJim6tyWCpT+tACgnKhQDCRfu4dQ8aiU43vVa9wXMP93exh8
         5CzEwutHYKxzAwgkULtpQKWhaURyv1qROZVZ6IFCKncNZwtNmnDY2523xagqTT4Sje9v
         fy+k5xGC+CJC1PTX4QXS9wYuDBVLiJ5vREVoiYA4PahoS0pvJxjVaJaYTqhsO9RNesee
         xsEBQXrq5Rdo/fDs0bYji3x5UvkoAAtgCKd9QLzDGjrD66Z5G/+IGzbYZNOockGB2MOc
         8iTw==
X-Gm-Message-State: AOJu0Yz/2djAh7qdpJ6OsAM5psPwCk1NGWdlNaSFJ7hhUMOuj2v2tCnu
	sREWQoW+ufkdrPgIGz3s8K4SUkFrOOotOGQxUY90dyeL8YxkIfb2hDgkUeM7kpwXe+ex15lM5Se
	HKo3XjNwwevoB/Dxr8YacmZL5tF8=
X-Gm-Gg: ASbGnctyzqHHTMJr2Axt3Dw9LVWRl66H0do/sBEmlqjEb03VxpGQi48RE/BwgwE4eu2
	DKexbcgiYz2yjKFLFRE8rx5kn1sZkUL186qaBKM/gRl8p7tSFgMyuf156ErRhRKj5DpVIMhsvrt
	d7s+Szk+t4hDwlIlhLgMZs9MWFlSF8FRYWSooy1E5r1PfSEiLJXw==
X-Google-Smtp-Source: AGHT+IHjRxqbuC6EWjG3w8Gjmy0g4xOqQcGK9GiSNAgLNFH1wYnmaZTW/evmeNmFuGppCwke7Ey/4Sm6ct+zw0Xt+1k=
X-Received: by 2002:a05:6000:184f:b0:3a0:92d9:da4 with SMTP id
 ffacd0b85a97d-3a0b43afb7amr1554946f8f.6.1746581152230; Tue, 06 May 2025
 18:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-3-alexei.starovoitov@gmail.com> <9e19b706-4c3c-4d62-b7f2-5936ca842060@suse.cz>
 <1fd89e00-2d26-4f84-b8a3-5add508608c8@suse.cz>
In-Reply-To: <1fd89e00-2d26-4f84-b8a3-5add508608c8@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 May 2025 18:25:41 -0700
X-Gm-Features: ATxdqUEJOSFOsiS3_A46OBaAuxrRJkkwJWKCpum10HyqXndyjSQQvLSwCXc_EMM
Message-ID: <CAADnVQLHxONa3TuybG748AbkvHjEdQMQnWmRptRyBfCHO+4sgA@mail.gmail.com>
Subject: Re: [PATCH 2/6] locking/local_lock: Expose dep_map in local_trylock_t.
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 7:55=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 5/6/25 14:56, Vlastimil Babka wrote:
> > On 5/1/25 05:27, Alexei Starovoitov wrote:
> >> @@ -81,7 +84,7 @@ do {                                                =
               \
> >>      local_lock_debug_init(lock);                            \
> >>  } while (0)
> >>
> >> -#define __local_trylock_init(lock) __local_lock_init(lock.llock)
> >> +#define __local_trylock_init(lock) __local_lock_init((local_lock_t *)=
lock)
> >
> > This cast seems unnecessary. Better not hide mistakes when using the
> > local_trylock_init() macro.
>
> Nevermind, tested the wrong config, it's necessary. Sigh.

Yep. lockdep assumption is deep.
I see no other way of doing it.

