Return-Path: <bpf+bounces-48577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6EFA09994
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 19:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 226467A46D9
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 18:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F03D2139B6;
	Fri, 10 Jan 2025 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb6cDN9U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA3E2080CF
	for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534438; cv=none; b=DCJaXhkLhqWHyTccrYb2P2EJQ+Jye9aBuUut0nCkP3ftmwUfekTs1Gin6n6KE+uqzvRrLZSELbAbJhj2bPGv9cEWa8zmjiZcgDPdG8SwEnZsVnRXAJ/Xm3m52TD6NFOxhdPnj1y0rsc1X49XvMNm8xD+zmwsExtl8vMY39V1f8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534438; c=relaxed/simple;
	bh=1IN2aQehgUUXlx+zDuAHlhOZu9yVRP++t4KE1fpm5yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oApC+B3SNzObHUKd5ta/TEa58MpQ9usnmOJCAXp1DwvapV5RoyBGF/IVXLFROkghlD4GfIKmMI6HH7COIsqlhUXBjFfFazam7BCiLZmWZsbbVOKNqIRLLRYejMGm9jQlw3zrDO36mW2nTpRByW28Mxhsv5TK/F1RXAxYWazYxOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jb6cDN9U; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385e3621518so1353825f8f.1
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2025 10:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736534435; x=1737139235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IN2aQehgUUXlx+zDuAHlhOZu9yVRP++t4KE1fpm5yc=;
        b=Jb6cDN9UKqzE8dx7hlP5zY9fO/FiEDIYcBHglINtn3dXlHcSZwhWq24SRJMe43mrdL
         S0l/pLXaKx7CSsLUMnXxTlMUswm0E+7qjdYQ5lyhSPaLwYzxcocKOkh0/2LSrKJrMDht
         4ryCpkl0fDIbwRMWs5V/rt+E3HXKGBKmuhvzWawmDDKIKP91vsQNiEUTh8btUgLY9YAr
         0zLeKWZLA7CYEcDV48XZTbg33NEneYtTlCbxCefWkuKZYSGxDKyfqf3R0IUcGovCfdHI
         xMctgc8fZbBNH4hlVMEiRuteH4TLhBYAfy/Mqa2rsTqOfHGYvF5awyNR0ZB+hP1j4mhw
         x6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534435; x=1737139235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IN2aQehgUUXlx+zDuAHlhOZu9yVRP++t4KE1fpm5yc=;
        b=MtaFEYSu+kDIbzQbYTqbqXGujKcnScK2AAQC1+VNPai38WonGd0RoGUDjP0iaDx1E2
         44c2p/gxy7BMpZjwiY/V2PAUao2FWdHCVS72MJxVfoO9h2YuE0iLynfttes9f+GV9Eo+
         kJwTXTwfwTRzmgw+CNmjxNmqwxUMVHkAJ+bgacF8Gy3SE/0ziwzFUMwi39d6f1lfqjx1
         HY/n7l6f3EGnAew3vDCRvzmkNcDqxQtvheoSDF77N2w8k2PkhrEJA/hlVHKRRcOYeuZH
         8fFuoxh2rslAUR70JkD6guQTsT/QphsPgeuGW2rbVmN7HyWYHEhykNW2/xhpWeMCzS12
         fUJg==
X-Gm-Message-State: AOJu0YxiPOjp4Bl32GjxhHfWq8gBvD5uz1eXK1WPLnQiNiL8i3e7VEqc
	3gDWOJo+478DqFgZgFki0CxIopXOO0H0H+l2zg3WAjmet4l9cJ88BEy1mI8R7BFv8VsuNTohbq4
	yt7aDZqftSr6H4LWJmXNMlHGwe6c=
X-Gm-Gg: ASbGncsW/++mLccZjKjKAhE8EjZlK5J0Krmg87jT0hGCE8z0ysqa6nd0XsB7cnmE3Pc
	D8YPVsupWPBRZ4KeFov3HElJWgQaxhBuOE2hys507hBsgwY4PwkCz0A==
X-Google-Smtp-Source: AGHT+IH6uQrNLk5QcvCnqGTMa4iILjcJXQGrSwVMfEt5a2cy0K+l9b2s7Ti8g4qeWfQiUBxssteAi1Tt2DT+vAkxCKs=
X-Received: by 2002:a05:6000:709:b0:385:ec6e:e872 with SMTP id
 ffacd0b85a97d-38a87336ecbmr12384435f8f.38.1736534435117; Fri, 10 Jan 2025
 10:40:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 10 Jan 2025 10:40:24 -0800
X-Gm-Features: AbW1kvbL1wgIMJIfh7mOFmMOpZQVIr3oQkb0YesmKTm7sAIeLGtBZ6rto1sGa9k
Message-ID: <CAADnVQLxgD_7GYWZZ49aY2LqVYOy4uGvK2ikm7MJ1Cj60VPNaw@mail.gmail.com>
Subject: Re: [POC][RFC][PATCH] bpf: in-kernel bpf relocations on raw elf files
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: bpf <bpf@vger.kernel.org>, nkapron@google.com, 
	Matteo Croce <teknoraver@meta.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Moore <paul@paul-moore.com>, code@tyhicks.com, 
	Francis Laniel <flaniel@linux.microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 1:47=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
>
> This is a proof-of-concept, based off of bpf-next-6.13. The
> implementation will need additional work. The goal of this prototype was
> to be able load raw elf object files directly into the kernel and have
> the kernel perform all the necessary instruction rewriting and
> relocation calculations. Having a file descriptor tied to a bpf program
> allowed us to have tighter integration with the existing LSM
> infrastructure. Additionally, it opens the door for signature and provena=
nce
> checking, along with loading programs without a functioning userspace.
>
> The main goal of this RFC is to get some feedback on the overall
> approach and feasibility of this design.

It's not feasible.

libbpf.a is mainly a loader of bpf ELF files.
There is a specific format of ELF files, a convention on section names,
a protocol between LLVM and libbpf, etc.
These things are stable api from libbpf 1.x pov.
There is a chance that they will change in libbpf 2.x.
There are no plans to do so now, but because it's all user space
there is room for changes.
The kernel doesn't have such luxury.
Hence we cannot copy paste libbpf into the kernel and make
it parse the same ELF data, since it will force us to support
this exact format forever.
Hence the design is not feasible.

This was discussed multiple times on the list and at LSFMMBPF, LPC
conferences over the years.

But if the real goal of these patches to:

> open the door for signature and provenance
> checking, along with loading programs without a functioning userspace.

then please take a look at the light skeleton.
There is an existing mechanism to load bpf ELF files without libbpf
and without user space.
Search for 'bpftool gen skeleton -L'.

Also there were prototype patches to add signature checking on
top of the light skeleton,
and long discussions on the list and conferences about 'gate keeper' concep=
t.

