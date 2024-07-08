Return-Path: <bpf+bounces-34164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBEF92AC66
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 01:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD88E1F220C2
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 23:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C46152799;
	Mon,  8 Jul 2024 23:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqHiSSEW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419E3152786;
	Mon,  8 Jul 2024 23:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720480075; cv=none; b=cCdlPv+VaMcMMMcuUIV9h8HZgZcn4h/yKbg4DOleAO8q/BvPVcVz1YeGW1URy82Q4Yzn7kPbanWPYfleafL+qmVw4J2uKAEG+gOBUbQu+zB+3+dkGyiEmOQFi761wh7hUXy4fFZDtsXn+2a19lqv+Z5R/DqpLY/jd6VGW1TJL0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720480075; c=relaxed/simple;
	bh=H8CSN4/T3nQXfh1+RA+MR9bjuKS8ZJ2QJ6XUMZc8/pY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bAnFyLPe1LyAvVwjsjxTEz5zqdGrTtLUDzACe9I0gdJ/58YlIUPWvyx5qaAuY2drENdiabiwJDBTz279LhIyz9z896VOgQUZJjC4Hlvt1P4fFta5mpmZzDMt8WthwpiR9d+p2S+gQstJ4JIffGYSqOU/1uOBRFl9inGrcqYTJAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqHiSSEW; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2c96187b3d1so2540066a91.3;
        Mon, 08 Jul 2024 16:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720480073; x=1721084873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkkjqlkKsOnXHPkz5QEsrE7yBqoT/wiu44Pa237OHw0=;
        b=VqHiSSEWvyTiPUmNN+Uh7HozjL4euM3i4Bm8fMERmUg2YHnwk702dpGww5DscqNqmU
         V3B5Osvd7+mPynl15Mjywxhq7N2DWXs/g2g8W97aTHD/P+6FUKvxaDGLz8IxKBqgclRs
         Eb1RaBE7gWTz/copWQihG4zsIwjSo5zMsw4szVix1dhR9u7470+tjAWBGk/DPhIoO03i
         /hbBcxi7Os9hdrwbLViWeKqGR7sRUIIqZgSZLHsjEqzP4t2lhtYGxKsm65x9AAuH2sRU
         zc8+B3yRppzZIZBkGgctIGy2B7XkgRIAg99O6AsVuJcT7/dcCX7m8zDESZeWcvY9zycy
         S6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720480073; x=1721084873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkkjqlkKsOnXHPkz5QEsrE7yBqoT/wiu44Pa237OHw0=;
        b=w+z0pjQy2aCHA0cvjROgO1UniL7UqQo1NHQjLP9pBvyFP0TFuUYd1cVp6qHISrcuks
         mID5Rg4AtQ+Ilhmvk0+Ri28Yv5wgI3bPjGsE4KrNnPxuIo5v6n8ojeS6m/ATF9hmS9Zy
         OyeoGbH+/gGHIZBRSdwfkbPCoj8gFRcLIdTKUVAmzvU0VU7/AHLrqEjYoOrvJW0T2MgH
         AkdMq5r0LuKj54HXuZ1KIYG5Z2OsKA/KTah+Qhbj2kKgV7Ydbwz+qbgsQ7mcvJKMTRin
         EOx8zeyZVp097rnkm99axfal/gn/+9WfmrvYfl4xbzhZ0hfjKchu6pu+pOIkzHSwjdBa
         INZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD7BIJO4AbaFSp77mmIit5Mq11NQPb0IF4xs0nb2Zi08yf8qovf8GiuStyyBiEv4kTsEpiYThfCwZf/spwZHXQ0SFlUXojFZ0mniG0VStQZHtr2agz1Livzsw8oCyRrgUcsew=
X-Gm-Message-State: AOJu0Yzz38iQofZ7CiBbT5rpl485fPlvnpqZpYTITL7miEq2+k+oC+6g
	GKapu6nieYxM3siMRrcoSD94ybwy0yC3wYqcSs6KqvpygrR+n8VhXh6r1PGXlDyxoP51OAX63Jy
	Dvb+E1CbkfA/vShQ/aaTRZWwM4+0=
X-Google-Smtp-Source: AGHT+IGCbxoTKZ4bOpJ0NuQ44hnBKOxxfPu1MixKOmIoyzvzOz5POT6RBTncFKN+6XooqZ0a78zMqu/soFwu9eCbIz8=
X-Received: by 2002:a17:90b:1018:b0:2c9:8b33:3195 with SMTP id
 98e67ed59e1d1-2ca35bdfce6mr914225a91.4.1720480073380; Mon, 08 Jul 2024
 16:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f80acb84-1d98-44d3-84b7-d976de77d8ce@gtucker.io>
In-Reply-To: <f80acb84-1d98-44d3-84b7-d976de77d8ce@gtucker.io>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Jul 2024 01:07:41 +0200
Message-ID: <CANiq72mgTiOsnnLUP-JewoFsScV668WstP0bP2Lj+LGxd7L3sg@mail.gmail.com>
Subject: Re: Plumbers Testing MC potential topic: specialised toolchains
To: Guillaume Tucker <gtucker@gtucker.io>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Arnd Bergmann <arnd@arndb.de>, llvm@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, yurinnick@meta.com, bpf@vger.kernel.org, 
	Sasha Levin <sashal@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guillaume, all,

A couple of comments on the Rust bits for context.

On Tue, Jul 9, 2024 at 12:10=E2=80=AFAM Guillaume Tucker <gtucker@gtucker.i=
o> wrote:
>
> Then Rust support in the kernel is still work-in-progress, so the
> rustc compiler version has to closely follow the kernel revision.

I wouldn't say the reason is that the support in the kernel is
work-in-progress, but rather that `rustc` does not have all the
features the kernel needs (and "stable").

In any case, the version pinning will soon be over -- we are likely
going to have a minimum in v6.11:

    https://lore.kernel.org/rust-for-linux/20240701183625.665574-1-ojeda@ke=
rnel.org/

We are starting small, but it is already enough to cover the major
rolling distributions: Arch, Fedora, Debian Sid (outside the freeze
period) and perhaps Testing too, Gentoo, Nix unstable, openSUSE
Slowroll and Tumbleweed...

So, for some distributions, the Rust toolchain for the kernel can
already be directly from the distribution. So maybe it doesn't count
as "specialised" anymore? (at least for some distributions)

Of course, I know that you include cutting-edge too :)

> The current state of the art are the kernel.org toolchains:
>
>   https://mirrors.edge.kernel.org/pub/tools/
>
> These are for LLVM and cross-compilers, and they already solve a
> large part of the issue described above.  However, they don't
> include Rust (yet), and all the dependencies need to be installed
> manually which can have a significant impact on the build

Rust is there thanks to Nathan! :) Please see:

    https://mirrors.edge.kernel.org/pub/tools/llvm/rust/

Cheers,
Miguel

