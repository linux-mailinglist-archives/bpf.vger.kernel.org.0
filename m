Return-Path: <bpf+bounces-74668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA55C60DFF
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 01:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F3E523565A0
	for <lists+bpf@lfdr.de>; Sun, 16 Nov 2025 00:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3C916A395;
	Sun, 16 Nov 2025 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L38YzQiZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285F827462
	for <bpf@vger.kernel.org>; Sun, 16 Nov 2025 00:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763252622; cv=none; b=bP5PqKBe/vqe/fieWvLurDXI49j0os+2jAQ6FmGZnjjbJx1MgClFcxAeZHopeEwStftpJqk3W90T5R8SxO8Yyf323LmWwIQayYi9d+sfzKBTXeDffVXn5/aZOPYeAPlkMfDZHZeYfhYxrcz15Rjx0OP97Am7OVXUrXKtRwUSXTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763252622; c=relaxed/simple;
	bh=LMXdVCuIr/5CALBNrAvDaeQ+LEubLMGgnHLZJrM8VTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQDVhA4U1VO9pTn42fslzn02VSbrHf3ntLDNuGc3Rx8asmEBOvZSMImcmso7CUPBeoLlvtAhCIsn5tMzZAUNy/Zvj8eAa6O44WLet1otOJkMczt7V4nIFAaMTsr8++fuLImP7qGAG74Mf2EmDp3dQqi++2Zsyc2AsTeRQs7n6Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L38YzQiZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477770019e4so36705645e9.3
        for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 16:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763252618; x=1763857418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cu2ULdfpyzQ1PJCkMTtukoM5PeQ4Azs8plSo6tiQKxI=;
        b=L38YzQiZWpo/Gg08SYul8sMvfO+swL9TT5nDZLQ1hUf+SAxnSHAU5kRBpIo10flZlJ
         F8imtFViEv+g4yK6i1TOp0ewxKbzavgcy5WSfL8/8EobN/3RzntrnyXwwH4EQ5jGE2n7
         fGyzwPr+riSTiETBJ4TyjEk4BJjpuycSsV6xVk1y+DDOHE2uVeUPfQ96fA9iKFY2tk5j
         sxy13dbK7sH8mJn8kc1YgxyXArXHhVDJuHVpcj3HyAzgmApq2xq3X6jeR9qMdBbaQYTu
         JQ2bMvElrCk6M9yPMLAK4FngFdWNH0n2/9PuDLrmQImNldfGMk1Hsr4uP4/cTCpjsO4J
         oZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763252618; x=1763857418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cu2ULdfpyzQ1PJCkMTtukoM5PeQ4Azs8plSo6tiQKxI=;
        b=dtfZajBuWTcZetN6saGFA778xMgOx2ih4HJshQeovnb5TxjhNHiiJQCAcPDSFd+CHX
         sfyd2D1s4EzwnnqinQ9TX8N9xCmTB0f14K+bgmfhIfHdyUKZalE/9w4BK1bxCH+TVAb3
         fQCVYS8ljtCqWLb25Ll6lxknZA2opsfBo89qQP/EKlsoSiPbvjvqREGA4x56V9Q5opmn
         lDlHrnzioVz/jpwlDM/M2xyVCosHNm+9JTmdTP+rgU2A2J3/DRqvcU5AZRQexjCgclzK
         jCEuoS80F+GMk1WB6EbWNKLEYrnWnGX/qJlgpdvmK9K/b7WvyrEoDSW7/glJoT4u6lV3
         xtEg==
X-Forwarded-Encrypted: i=1; AJvYcCXEzIfgjaj0eVEFeLxN4osE2pU1mysq+akZqkpVg9RjZ7rP2SQpw9LydWZh/pNgXsw5/Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHn0rS/vi0CTMFd9kBND30QzN6SZbLEM6dlPm1aPAuPun3fnMk
	0rEmgwXqYLiXA4PsXYtXLe5lyjaq+2GEHm3y1GMvgbx3cbwG9p4MoTgoSgLnG909ledb7roY6lw
	YAtwL+NSQk67iUQvbXMWp4uYZk/b+CPwtNw==
X-Gm-Gg: ASbGncvwcFRrwIUux0mzvGqtzU/VubsB699kZ1BJs8HfMuTWLS+CYPC2mJ0brI53n3a
	bWYooV8iV5jQNHhCuPY4ZB9iocOkMTxV2ZA4uQgj+rh9XHSnDeaTZ9sZU1uQYojwCBt0lJpuHqz
	SXawIeMllaT56vtzEs2NPc3k1kHpx3a5eQ3af3izg8WvQ2IXIlpGirtxYREEHWJHBCwgDQRLa9Z
	1Qd2T+dhYlcsxBWob8dDDbDILuGyr6QvISGxKfDGrQ7Sw/J1wckyPxeMW3MmooSLrGvuYn+QhNF
	gahbwn5OuQAxOf3EnkWK5H0bwoMReU5esg5cF80=
X-Google-Smtp-Source: AGHT+IHSPfItdy3QBtfD/mxJPZ6ZMNd50xJsZqd2RaHSWInKR8roltnXyyg23zH+CCQFJRrxxaxvApf5Mn+c0QLYkZA=
X-Received: by 2002:a05:600c:3b12:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-4778fe89ed9mr66707975e9.28.1763252618142; Sat, 15 Nov 2025
 16:23:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH6OuBTjG+N=+GGwcpOUbeDN563oz4iVcU3rbse68egp9wj9_A@mail.gmail.com>
 <CAADnVQLXJyMhfqr=ZEUWsov3TC155OkGvuaOHL5j+aK5Pv=F7A@mail.gmail.com> <CAH6OuBTXwW9WKHRNS53kRgZ3Y5GdH3n0EY4YogOGGSTGnYL9og@mail.gmail.com>
In-Reply-To: <CAH6OuBTXwW9WKHRNS53kRgZ3Y5GdH3n0EY4YogOGGSTGnYL9og@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 15 Nov 2025 16:23:27 -0800
X-Gm-Features: AWmQ_bmKyR3twUvpX8ZAM7b4vLp2w_OUi89JAy6YxDODaZobc7wRiGrM0uMzxac
Message-ID: <CAADnVQ+DycJQ7eW_FDE59Qc1SzJseYy2f8yniqh0C354ruLdCw@mail.gmail.com>
Subject: Re: bpf: system freezes due to recursive lock in bpf_ringbuf_reserve()
 caused by commit a650d38 ("bpf: Convert ringbuf map to rqspinlock")
To: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Jiri Olsa <olsajiri@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Jelle van der Beek <jelle@superluminal.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 3:04=E2=80=AFPM Ritesh Oedayrajsingh Varma
<ritesh@superluminal.eu> wrote:
>
> Hi Alexei,
>
> Thanks for the info! I wasn't aware of that fix, but I just checked,
> and my kernel *does* have that fix. I'm on 6.17.1-300.fc43.x86_64.
>
> I just installed the kernel sources locally to make sure, and the code
> for rqspinlock matches that of the commit you linked (i.e. the
> is_nmi() check added in the commit is there). The code for the related
> commit  164c246 ("rqspinlock: Protect waiters in queue from stalls")
> is also present. You can verify this yourself on Fedora's 6.17.1 git
> tree: https://gitlab.com/cki-project/kernel-ark/-/blob/kernel-6.17.1-1/ke=
rnel/bpf/rqspinlock.c#L474
>
> So it's good to know issues have already been fixed in this area since
> the original commit, but it looks like there's still something lurking
> here. To clarify, I'm not exactly sure which of the various timeout
> cases in raw_res_spin_lock_irqsave() this recursive lock situation is
> hitting.

Ohh. Interesting. It's a new issue then. We thought that
that commit fixed it for good.
How quickly does your reproducer hit it ?

Kumar,
please take a look.

