Return-Path: <bpf+bounces-67017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4C7B3C181
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 19:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E8C25883C1
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 17:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84E23376BA;
	Fri, 29 Aug 2025 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XK4z6s6j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4263A334371
	for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756487302; cv=none; b=pvEU0ycHhoazN0iCBDD50comkb77OChto9vLLVuLXEfTX6BV8t56UCJD6hZr0NViBNI4W5Kc78pLg5/H/GIIg27GY9MeL7QKkuzyZnydO2X4AqBvI/XlL4Gbq8KLQkIHYkdjCGitkRXr+yuTC4uQaI5KJgit6GagUeEc9dlP3VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756487302; c=relaxed/simple;
	bh=fD4739ZL8XX1stZE9Og6p4xwwcsU6Q7KYj3wGwFxT7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zx1aWDtSyNMGy9HkXHNCcEQeCWv8ESJuyPOKZkJ2MLU9/44D2ewloOR18+0lcsjQcM4i1Z20VqM1jDo5biLBqg5fjaWCjs1XDxOc81lTKLE1J+Xalx+zrMiacs4yNEjqIDpoJkd9+166ZQwr2eqPPZGexFuJgM2b48Q1JT0LTok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XK4z6s6j; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61cbe5cef28so4578715a12.0
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756487298; x=1757092098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ad3L86iH5Z7fm1hgP7OBtRKFsr713rsXkiJ6RmeN8+s=;
        b=XK4z6s6jBNNs9PeK1y4XMviwJd21XObvV99wPdOYkz6GnvfjvigT8ejk+0e6ZpUia3
         Tw2Zbaw/ODTImBZMXxL5a41d6qjVFpAhK6Em2EjqDXkLJgk4s7zynC88mmsH8WrV43kO
         paTiDNJGlk+46rMcSCyGDGzcYkpOEC20pNEVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756487298; x=1757092098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ad3L86iH5Z7fm1hgP7OBtRKFsr713rsXkiJ6RmeN8+s=;
        b=uHRwVqgHKg09Dd+kBNYiuaLh04baRDgA3xyPACkH1F+kKUNCM2mPATmyGD+PIRCa65
         kyl8USBq0pSjemsLTkFLcCgmoBAPE0FxurBLx9jAOKeTm7EIBsaJf5ufF+hMENNPqi5c
         YMAF4GBvAdaeOZRhcp53vz5tL5LQZ7a/tqjReyWsWraVtBQJosAAdXOaAOZkkrrY5TA4
         4K4zLJAMDsO/9CTuDUYzlsd157IDK01vQ50SvhDkJagl6EHdjX9je7u/0FBzVL/XwDhq
         ezK/jjh+OdhgvBRnoASrT8DZRbmQZ/19EmjFcoesaYm33Bcm7Vg/B/6oHkEDWHmCkIHQ
         vwGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAckeOUAVMdSLxiHB3/wZLCXy0uZUMoZNXptsigZMHlY22lRTLX+Nw3PPIr8FZL2ONX3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbp18TPryc6TfD7dKoE8if+lLCm0EcOK/usiy9KBEUBVShYh8A
	LNdGo0Zgb3AnKR4g/YQeekP0Cf0AbmrYxCBxns1LulYXk3oU5pLQDdRnKwCfKX6TDNttaiogfVq
	XeWRdiahqnw==
X-Gm-Gg: ASbGncuWMbULpRO0aK0gSzEf72nk2kM3LR/Pe9Fwt6ESb15QPBaP5iO0E8kcilgofL1
	3ZHuKAAXe/dnWSgFrKAPClIAPhvULtNMyKqTZr0+v0EGRJEx1eRRj0b8y57/qw3/hKKVKml/+am
	S8Sl/1S4ZnDCalL07Pt/3tfWV4fyqh52mK5r3QVP2Wozgzwtho8CUvww8R+iVExBGtAgfi3pB7r
	NZgXK6BLsIxFxeabaIrP771Lshb39PdC4gZMOtBYBeRk2ICSJrqCrk8Y0h6KW3n8BgUwxHRmARG
	C3tt+ydPZLsQr/q5uiaMk8E/IP6/OJYHES2WjH2nhXmgSZcXgW5tsmJYx+RGVx1p74DjSkmpLnq
	p5frcpDNdq/vsiLV+wQbdvcUtjUtELSK/Ll8sLsLmeBsM9KKJo1VhOMDdhFktpL2YbfJKJgmF
X-Google-Smtp-Source: AGHT+IEzUqIHP7uMjQRD9og1/m9P5QJt/7u1aJuDf5z8CVgcqDmCKLSsx5mb+cFHcVR+UQmzu/zKkA==
X-Received: by 2002:a05:6402:274e:b0:615:5f47:8873 with SMTP id 4fb4d7f45d1cf-61c983b7f74mr14051005a12.14.1756487298288;
        Fri, 29 Aug 2025 10:08:18 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c775fsm2106227a12.4.2025.08.29.10.08.17
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 10:08:17 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb6856dfbso422408466b.1
        for <bpf@vger.kernel.org>; Fri, 29 Aug 2025 10:08:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUME7x7FpqVwDaDi/EtrL5FGbHKxNdNtcFnm+aym+gJw5FSu68jZQvr6WozWGT5QPclkb0=@vger.kernel.org
X-Received: by 2002:a17:907:6eab:b0:afe:ef8a:a48c with SMTP id
 a640c23a62f3a-afeef8ac7f9mr611238166b.8.1756486976814; Fri, 29 Aug 2025
 10:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com>
 <20250829123321.63c9f525@gandalf.local.home> <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
 <20250829125756.2be2a3c3@gandalf.local.home>
In-Reply-To: <20250829125756.2be2a3c3@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 10:02:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-ZfHXfXKtSNKoRXhNz10Do+mqDyUumEkx8H8OqVYP-A@mail.gmail.com>
X-Gm-Features: Ac12FXypzub4sT_YQp3-NVQ4K7fOdzCL-9SS4ZE75x9Zoqx6YPOM5EIXszDBXRM
Message-ID: <CAHk-=wj-ZfHXfXKtSNKoRXhNz10Do+mqDyUumEkx8H8OqVYP-A@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Aug 2025 at 09:57, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The reason is to keep from triggering the event that records the pathname
> for every look up.

BUT THAT WAS NEVER THE POINT.

There is only a single 64-bit number. No lookup. No pointer following.
No nothing.

The whole point of hashing was to get an *opaque* thing very quickly.
Not a pathname. No reference counting. No verifying whether you have
seen it before.

Literally just something that you can match up in the trace file much
much later.

(And, honestly, the likely thing is that you never match it up at all
- you can delay the "match it up" until a human actually looks at a
trace, which is presumably going to be a "one in a million" case).

              Linus

