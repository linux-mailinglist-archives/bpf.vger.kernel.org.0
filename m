Return-Path: <bpf+bounces-21478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 769B284DA14
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 07:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8EBE1C21FB5
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 06:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6EC6A33A;
	Thu,  8 Feb 2024 06:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3ThmWE9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1997169DE4
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373592; cv=none; b=hYlvWR7h0yN6MPdSyNCDDHAHzAbcPXyBUsjApGh262/Y6IVCAAvvIRpRxe1NZgb2qPSyrJX9frK4zv8uqpFMHPHIuqo6Q7/gKvHLZi+tswQsvMw762gbb4pIZS417jqCDX3v0Ir/zimfucs+Xh3awRCXmw6cxNSv+/Ivl8UN410=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373592; c=relaxed/simple;
	bh=fYcknECTUEzcJNXm11ecSU5OOkVrRFseVprUPP4YCp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UC+AND3m+DHhr9SO6wCILdk9gB7Xf7ztOo/0SJcUiH3uEw0WxZGZyPqmsbCZ/h1seFP1ugi6xogzwF2IYEQVLehQyHq388yULn7i3zBShRCGxZKQrr4kC7Bai8l12ntOAC2zUawbZMcG65w7hqBGxYCA1z3vpQVO6kEaMZLKEJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3ThmWE9; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33b4b121e28so739228f8f.1
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 22:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707373588; x=1707978388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yg5N2eIHVjcFb6EdgGwasaePa68HmUdXgO4Zy+pbjUU=;
        b=Y3ThmWE9Y4/zmb777zp7Vdz2e2xEz8NiprLKHRF4/fQxOYO674k4XBeNeVPQJ/e/+2
         v4dEYZPjQQxL9tx6KIyEdV4qHquiQVkseJdHAQuOpso7Uf47QEQoOqXGmtlShh8ffpP6
         wbHws7ywhJbCKdGviH5LcA7YCurZveZcbkd9n0DhpCZvIuwxLuoTE7Mxg1+eq9rWEg/F
         fhwdMlULA2qHJw06DWK+mIPTWVbvJqaFQQt7fHdVNADTbwLqiLt0oEasERAIsQapDuCT
         w1tvOjZklL/lia7FsLvmS7CBDr4sbK2sLoaAVuUaHxW/0jkfx3mNAJnxbrzGMuiaKa6A
         hSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707373588; x=1707978388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yg5N2eIHVjcFb6EdgGwasaePa68HmUdXgO4Zy+pbjUU=;
        b=VeGp5p9xyYgloGQ+l2mrUJoFZrO8w6jZPZ4juuKr+bbISaLVID15gsmkprlP5celhr
         t6nltAYeVcax8AkO2dTtLPG/tC0mTHmFbqNw0NSS/xmNoJ8Bs+UHt9lp+5i57QtsQZe/
         /0UtP+C2Wq/Vi6+mkhjizcIWqWJPqGTU4Bmf3ZrrenyHp45W0+evszLgctOi5c9ANwzT
         kTIdWETCzelj9IRe6pCTI1M21og+guubcMH+Q1EgA8dyCeFWl6tM8JkLW0tzCChdamPu
         VceY3e34LeLqzEmQdk43Af7GXBcMidpK1GNMK3xs7Rgw/T8UL6mgsnAbtviXUHNJ1yEt
         +D9Q==
X-Gm-Message-State: AOJu0YyRPqUpBqPp34m0R7juiy7KvyWKx+P8b/XFfGgLQ+EbmUQ4FYKK
	1kDhxHy7980/6TkUXRugHQjuPf+NRaTFr3VgZPV6pR4Z8qSTiurFbWo19kV6klnzNJlbSUUVZ+Q
	sHVQIbGV8yUJv/zNAawXHibA+ADo=
X-Google-Smtp-Source: AGHT+IEfuDDkWCOCdAV74FSgXyGdtuHKcvod6mNhhGMphYcOnx0Mk/aOkKB3hqQaHQnXW97bWlN7gtDzF/IDv711mvo=
X-Received: by 2002:a5d:5265:0:b0:33a:fafa:8cdc with SMTP id
 l5-20020a5d5265000000b0033afafa8cdcmr4937349wrc.32.1707373588109; Wed, 07 Feb
 2024 22:26:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-5-alexei.starovoitov@gmail.com> <c9001d70-a6ae-46b1-b20e-1aaf4a06ffd1@google.com>
 <CAADnVQJJ7M+OHnygbuN4qapCS8_r-mimM6CLw5oee8ixvmqg4Q@mail.gmail.com> <d4024acf-97c9-4a16-ac70-739d0bf81a45@google.com>
In-Reply-To: <d4024acf-97c9-4a16-ac70-739d0bf81a45@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 Feb 2024 22:26:16 -0800
Message-ID: <CAADnVQKejmHGDUAuRA+G2Ex0=+FcmTpVZ67DEZJHLjCMckx2xw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/16] bpf: Introduce bpf_arena.
To: Barret Rhoden <brho@google.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 1:12=E2=80=AFPM Barret Rhoden <brho@google.com> wrot=
e:
>
> On 2/7/24 15:55, Alexei Starovoitov wrote:
> >> instead of uaddr, can you change this to take an address relative to t=
he
> >> arena ("arena virtual address"?)?  the caller of this is in BPF, and
> >> they don't easily know the user virtual address.  maybe even just pgof=
f
> >> directly.
> > I thought about it, but it doesn't quite make sense.
> > bpf prog only sees user addresses.
> > All load/store returns them. If it bpf_printk-s an address it will be
> > user address.
> > bpf_arena_alloc_pages() also returns a user address.
>
> Yeah, makes sense to keep them all in the same address space.
>
> >
> > Kernel addresses are not seen by bpf prog at all.
> > kern_vm_base is completely hidden.
> > Only at JIT time, it's added to pointers.
> > So passing uaddr to arena_alloc_pages() matches mmap style.
> >
> > uaddr =3D bpf_arena_alloc_pages(... uaddr ...)
> > uaddr =3D mmap(uaddr, ...MAP_FIXED)
> >
> > Passing pgoff would be weird.
> > Also note that there is no extra flag for bpf_arena_alloc_pages().
> > uaddr =3D=3D full 64-bit of zeros is not a valid addr to use.
>
> The problem I had with uaddr was that when I'm writing a BPF program, I
> don't know which address to use for a given page, e.g. the beginning of
> the arena.  I needed some way to tell me the user address "base" of the
> arena.  Though now that I can specify the user_vm_start through the
> map_extra, I think I'm ok.
>
> Specifically, say I want to break up my arena into two, 2GB chunks, one
> for each numa node, and I want to bump-allocate from each chunk.  When I
> want to allocate the first page from either segment, I'll need to know
> what user address is offset 0 or offset 2GB.

bump allocate... you mean like page_frag alloc does?
I've implemented one on top of arena:
https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/tree/tools/test=
ing/selftests/bpf/bpf_arena_alloc.h?h=3Darena&id=3D36d78b0f1c14c959d907d68c=
d7d54439b9213d0c

Also I believe I addressed all issues with missing mutex and wrap around,
and pushed to:
https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?h=3Dare=
na&id=3De1cb522fee661e7346e8be567eade9cf607eaf11
Please take a look.

Including the wrap around test in the last commit:
https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?h=3Dare=
na&id=3D01653c393a4167ccca23dc5a69aa9cf34a46eabd

Will wait a bit before sending v2.

