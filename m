Return-Path: <bpf+bounces-67024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A076FB3C222
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 19:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2C0E7AC785
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 17:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4680340DB8;
	Fri, 29 Aug 2025 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZiFrf6e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAF233A02B;
	Fri, 29 Aug 2025 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756490285; cv=none; b=MRsq5MVaGqSPgM+PNeaxHftnWinbDDhRfmLHLKs4bQhpGfMmnubdRjPZNRv412c5OLIZbGZCb/LTMrs4nEVqVAQ5WZOc/hjZPXak0JzAbFaEFqzbNXntVugXbQ0+TOYdWLWTpW+0OIq7HDc8qiEc/RLhqmPJBmyRLsgMAJWzvHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756490285; c=relaxed/simple;
	bh=I5OY4LFNqLLPDVxAMmWT8dvCgWbSg5IxhOzBtc0iMzg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=p4pg10kBXksLAD5fz639JohnFxnAoGi8mdgR2yB/cIof5ipQDfFoRHUmXTBAbrW1WlGjgJXWfJv3AfQQDpf5SOn8Ja1d/7kkMavujMfLoZ9wN0dpclZa+hqg9NSZYhu7HTRAHq31bJYMxA9l/UwVKzVzMdlwYe+XB22IPpsPcnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZiFrf6e; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb72d5409so411527966b.0;
        Fri, 29 Aug 2025 10:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756490282; x=1757095082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=awljRsOqs8zmeNHYRoc+5rBvpq/dx6uCVPg6gUVT0+I=;
        b=OZiFrf6e9Jjn1530oCX4PWJlu9/iro3fcM412I8cluZ1EozinH4nTgzRFbO/nHyEWx
         pXg5QuBbzCj5CpSJsiewYzrNUY5iLSn26vbXSEkna9kxcuGPYpk+9wpU6at0xxyna/Bk
         eDEDQNgzWQVDV2C4DkNfN/190TvjtIXI/3oKRcsK1TwWsyFh4KUnHXCdu9NBNhQaZTOk
         gvzV/2xUOZKhWNjs9T6CsARvr//vil+PIBqE5XaIoBgoZaSH5unPvNe//r44uzUXASre
         1ys1IJBx7PMpHVeC2wA7FkRlnAGCLuADnFtvWT++DVu9nZ5RRKTyWPD7BhOfvpKpI+oY
         yRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756490282; x=1757095082;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=awljRsOqs8zmeNHYRoc+5rBvpq/dx6uCVPg6gUVT0+I=;
        b=cJ7DFfltFN4t9I7mwC7vLLNAqu8of52/g7VBJNZ/LQ6BdRVNmTUvrWR1rT6QsS2jmg
         hT4OtdUxRDFepR4VMzOery9iNUstlm0xE1U6Op4skMzm5VK+1xe3lTSTimoAT9bOL/3e
         xldbv3VlOWG3DrQV0MloS0qxY8D5d1lb7ZzmpyoV+XAvAFHh5zFI6ID8cBzSK4OjKHzq
         +v3M0e0irGw/nQdHDTpn6zSzKc+x3rUS699MdoEn68IxL71ALUYHYp09CQrTHiX+Tugb
         FjsoCMA5jBNpsDPfihlP9p+45d6YvjNN+nG2Ue6Cuaj5KQPgSuIf7/FZ2J9K+XXuWwjR
         UulA==
X-Forwarded-Encrypted: i=1; AJvYcCVJX6qRnCVj1hwHNuelIVqzwHVLwztj39k0uuLyt7ETkAz3Z56ZnNgS3WmfpSbOwrVzPxfOrGnbSgxpRctjHyiT8QA/@vger.kernel.org, AJvYcCVa741gtauBJCM4FWuwN/p/56ds7TyiKSDIbS/T4JRDMUfSO27A4YH1ru7giEiatPhm1II=@vger.kernel.org, AJvYcCVvxFeAp1wyf7rSp4qm7WUMGWH68Qy4gGk1G4/wRZyDRQyekHRk9egxHw7VNG+Wx8MO68snQm6GQj3xRlle@vger.kernel.org
X-Gm-Message-State: AOJu0YzjftVK4idqkx1j8oLa9guMb2SsuM7tfx3JYdpoQ/IZrJBppt2g
	zPE5esrDJF5Ii+25Du4h/fxwRTL2aHSM9ULYa1rJkTVHyTLUiU/zmlCe
X-Gm-Gg: ASbGnctuNxVoHOcVhdRxc+JY9H7V8WR9Lc6CIRctRGV3MclYDlBqVfvVjeWngO0PsWS
	dCrRXjEla+MW4OFwQUExnZwHsQmir1Dy1V/gqfQG+nSSgUlEjNUqNsfmgLjS/gMSyU/h2zJpS+N
	JKLsKD1xg/tAfRAIvDfJ0GWJVqmJdW9g2U1TgWe1Yz5R8fYB//fTqKKTSDN6rrLQNE7Ib6eieSA
	Uoa235OEUhXC8n8JDWSxwPZJBnJu1YNGFT90pAxOK7KbJSgOH9tkG0WcVYK6Ha6waU1A5fuksBU
	ElDi8zx12YrywJJ1iE37R7bV8CBvTcVQQAGNAUCDziHPULjDbIG6y4AeYIcvJo2d2CG26mh+wqt
	I/zBpFcZ8XNCBLcPHEIvp28C7ZLGJdW4rA0QW20QJwWKP1jNMmt+uQfU=
X-Google-Smtp-Source: AGHT+IFFhvEUCgb8MdiqB5hU668wQfYZA1otaPB+NgmfFMTUA8Ozb1vwvDCyI7yEpIjBDdG+r6qzzA==
X-Received: by 2002:a17:907:e915:b0:afe:63ae:c337 with SMTP id a640c23a62f3a-afe63af7fd3mr2115252566b.57.1756490281728;
        Fri, 29 Aug 2025 10:58:01 -0700 (PDT)
Received: from ehlo.thunderbird.net ([31.40.215.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefca0e5e2sm242172766b.38.2025.08.29.10.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 10:58:00 -0700 (PDT)
Date: Fri, 29 Aug 2025 14:57:57 -0300
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>
CC: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
 Kees Cook <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_5/6=5D_tracing=3A_Show_inode_and_devi?=
 =?US-ASCII?Q?ce_major=3Aminor_in_deferred_user_space_stacktrace?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAHk-=wi3muqW7XAEawu+xvvqADMmoqyvmDPYUC_64aCnqz-WLg@mail.gmail.com>
References: <20250828180300.591225320@kernel.org> <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com> <20250828161718.77cb6e61@batman.local.home> <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com> <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com> <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com> <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com> <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com> <20250829123321.63c9f525@gandalf.local.home> <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com> <CAHk-=whbHyKvJ5VSvObfmGSSEukYhv5DZVhR3_-smu_1_b54mg@mail.gmail.com> <20250829130239.61e25379@gandalf.local.home> <CAHk-=wi3muqW7XAEawu+xvvqADMmoqyvmDPYUC_64aCnqz-WLg@mail.gmail.com>
Message-ID: <24E50A07-EC58-4864-9DB3-E5DB869AD030@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On August 29, 2025 2:13:33 PM GMT-03:00, Linus Torvalds <torvalds@linux-fo=
undation=2Eorg> wrote:
>On Fri, 29 Aug 2025 at 10:02, Steven Rostedt <rostedt@goodmis=2Eorg> wrot=
e:
>>
>> Note, the ring buffer can be mapped to user space=2E So anything writte=
n into
>> the buffer is already exposed=2E
>
>Oh, good point=2E Yeah, that means that you have to do the hashing
>immediately=2E Too bad=2E Because while 'vma->vm_file' is basically free
>(since you have to access the vma for other reasons anyway), a good
>hash isn't=2E


Can't we continue with that idea by using some VMA sequential number that =
don't expose anything critical to user space but allows us to match stack e=
ntries to mmap records?

Deferring the heavily lift to when needed is great=2E

- Arnaldo=20

>
>siphash is good and fast for being what it is, but it's not completely
>free=2E It's something like 50 shift/xor pairs, and it obviously needs
>to also access that secret hash value that is likely behind a cache
>miss=2E=2E
>
>Still, I suspect it's the best we've got=2E
>
>(If hashing is noticeable, it *might* be worth it to use
>'siphash_1u32()' and only hash 32 bits of the pointers=2E That makes the
>hashing slightly cheaper, and since the low bits of the pointer will
>be zero anyway due to alignment, and the high bits don't have a lot of
>information in them either, it doesn't actually remove much
>information=2E You might get collissions if the two pointers are exactly
>32 GB apart or whatever, but that sounds really really unlucky)
>
>                Linus

- Arnaldo 

