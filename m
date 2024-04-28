Return-Path: <bpf+bounces-28049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 096778B4DC1
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 22:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966021F212E1
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 20:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8410E745FA;
	Sun, 28 Apr 2024 20:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LNVdFvlY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337E21DFC7
	for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 20:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714335768; cv=none; b=utoZfhflNJ+7ZwM6EY13EiVBsLv/Wu3cNW7hNsPHEoADsHTFEDeH3gHkVf3mGZrDyBjzFPxuFp1uMdsc67PdqCJFnwZ1Po+733BinOv8IxO9VhHuUG3kGx1JiuLMAF79/GaXtkyQ175loENRN5wLCvbdjOMXK6jNZ1cY9Rbw9h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714335768; c=relaxed/simple;
	bh=H71Tv2dUxdSU6L0QrBYX2j1pl48rzgL4H1/kXqthOD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TosgaTGDLGzmr+JUQfxSRvM3SbtBUCH1oEIxBv8qYd808oblz0R+xVDNogMYvTAjLPuQUyNhrERYUEvDBg1kJGBe+g2vqvFjNX8ybDlT70frx3+ZiqrQK0bvVbgmQi4AwMe0+PbJT3Qh/pF95xM8Zvo+szRCI021MVIXphnd+GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LNVdFvlY; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a58872c07d8so860297166b.0
        for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 13:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714335764; x=1714940564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qNIV9pJKRQ0bK2019WbvTNRu1m1w296Oj9c68XnoHTQ=;
        b=LNVdFvlYt3jhy1z81Dj21uiB8CbhCD6yi9O0SMUv6XspmSCCK7Mn3tiQLhtZDip0NR
         xBo78b3zyWpgC36WezkH1Z5hPmKE8IaCmF9RSSko90yyuCFDGWntvQk2aEyUNZOHMXAm
         whdl0h5yNkQskhT7z07FUGJYRhFz3JDrHXVwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714335764; x=1714940564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNIV9pJKRQ0bK2019WbvTNRu1m1w296Oj9c68XnoHTQ=;
        b=BdoVHU1TK17x5IRsAFpnSxJ/67V6XNFBovEgt1bWfzVrMcFvPt4icBUeJEEsCtOhKn
         QMbz4vVrk8JHFofGatNFh1hMk7WFmmU9VFsIXcafYtC2q+7B3SHjgQBNX+59RTP6P/Ou
         f2PfsKSwF2IKlHdRxS7FrOzIJotTJsDzPBgalBP82tQITYOtSVzva9DZgLVFYAEd2xtt
         Qe92jyKAIsxX1lU3f9BlFifIjbKsUePkan3hoYg6HO+tbn7QV0Wh3WxftJaN3KhQFq2t
         QH9/Nmdl+iSOvLt9WPAL1txYu1JGhqGB3puJMQ51fimtP0MUWh/nwfoQX1hZFnuN8Blz
         WMfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6R0XC0XHfSP1hBrJHl0rlOqSDItzLK58lQ8uMAI2Xb827O739tYFxyXCtlDvIC58Sk/fO529JSdkhlJFm3W/U6VVy
X-Gm-Message-State: AOJu0YwfYUhoVrHF7Ve1XCXQoNcZN5Jk1Op9j+5YorIlUfQv4hAd7/Ar
	QUBP0yc0gK7EwV+R4dT2aaxxK8H2+CLcODTffI2Am46QrXwBgaUxI5u/V+9G7uwz27OWx6sex4s
	NeM4zXA==
X-Google-Smtp-Source: AGHT+IEnLUF7IbaCXD8fXgecFaL5EsHydtoWTdAcrGYnBDeJ/4+8BWNkLhXpmLGS7oqwJ3M2jl9lqw==
X-Received: by 2002:a17:906:81ce:b0:a55:b67c:bd04 with SMTP id e14-20020a17090681ce00b00a55b67cbd04mr4077146ejx.4.1714335764269;
        Sun, 28 Apr 2024 13:22:44 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id z13-20020a170906434d00b00a51e5813f4fsm13300520ejm.19.2024.04.28.13.22.43
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 13:22:43 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a58e787130fso196287766b.0
        for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 13:22:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgg4uWmyzmngRMgNkrhQL98DzahJH7JtEkK7k9G9JRdiHuZvzf8UN3qxNCj9sWrkSnUOOI0g4/aPINtvMF39Q70EGW
X-Received: by 2002:a17:906:370f:b0:a58:eb0d:f2a6 with SMTP id
 d15-20020a170906370f00b00a58eb0df2a6mr3640636ejc.31.1714335763076; Sun, 28
 Apr 2024 13:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000009dfa6d0617197994@google.com> <20240427231321.3978-1-hdanton@sina.com>
 <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Apr 2024 13:22:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi8U1PjW_L6Ng9_A80L_1keyEOKud3PVh-8bwPL9W0CNg@mail.gmail.com>
Message-ID: <CAHk-=wi8U1PjW_L6Ng9_A80L_1keyEOKud3PVh-8bwPL9W0CNg@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [trace?] possible deadlock in force_sig_info_to_task
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>, 
	andrii@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Apr 2024 at 13:01, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The *problem* here is that the page fault doesn't actually happen on a
> user access, it happens on the *ret* instruction in
> rep_movs_alternative itself (which doesn't have a exception fixup,
> obviously, because no exception is supposed to happen there!):

Actually, there's another page fault deeper in that call chain:

   asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
  RIP: 0010:__put_user_handle_exception+0x0/0x10 arch/x86/lib/putuser.S:125
  Code: 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 01 cb 48 89 01 31
c9 0f 01 ca c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 <0f> 01
ca b9 f2 ff ff ff c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90
  RSP: 0000:ffffc90004137d98 EFLAGS: 00050202
  RAX: 00000000662d5943 RBX: 0000000000000000 RCX: 0000000000000019
  RDX: 0000000000000000 RSI: ffffffff8bcaca20 RDI: ffffffff8c1eaba0
  RBP: ffffc90004137e50 R08: ffffffff8fa7cd6f R09: 1ffffffff1f4f9ad
  R10: dffffc0000000000 R11: fffffbfff1f4f9ae R12: ffffc90004137de0
  R13: dffffc0000000000 R14: 1ffff92000826fb8 R15: 0000000000000019
   __do_sys_gettimeofday kernel/time/time.c:147 [inline]
   __se_sys_gettimeofday+0xd9/0x240 kernel/time/time.c:140

which is also nonsensical, since that "<0f> 01 ca" code is just the
"CLAC" instruction (which is the first instruction of
__put_user_handle_exception, which is the exception fixup for the
__put_user() functions.

So that seems to be the *first* problem spot, actually. It too is
incomprehensible to me. I must be missing something. A "clac"
instruction cannot take a page fault (except for the instruction fetch
itself, of course).

So if the page fault on the 'RET' instruction was odd, the page fault
on the CLAC is *really* odd.

That original page fault looks like it's just from one of the
put_user() calls in gettimeofday():

                if (put_user(ts.tv_sec, &tv->tv_sec) ||
                    put_user(ts.tv_nsec / 1000, &tv->tv_usec))

and yes, they can fault, but I'm not seeing how that then points to
the CLAC in the exception handler.

                Linus

