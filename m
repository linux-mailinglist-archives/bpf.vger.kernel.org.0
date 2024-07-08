Return-Path: <bpf+bounces-34159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDE292ABFE
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 00:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7523A1F23012
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 22:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73BB150986;
	Mon,  8 Jul 2024 22:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GNerUHl0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C41D14F9E7
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720477336; cv=none; b=pLnQ1NPuj0XykmWWD4LQVciEvOJ76VRf3e6OhyURQZDcLpnnlOnM5oQm5deXcAn+4/SzSuVI83/ZkCcfmQPm4BspAs/SDtxKDZLeFRIlE5z2gVOUVzsEah5hlf+qis1Oliwy2v4dZ7bSIEVTV9sdLk9MFnC8AaIW7pmsj2ZMkd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720477336; c=relaxed/simple;
	bh=/klr4pal0zQ+qkbOyt3Sy9bpPlhmD8yV7byDM6Ourbw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VV+I8Aua1Tzz4tUi2QaNdg2M2uE2KAqnqjSEB/N5y7tNDJY2UTCFmtPA41D3Rlwzl4brQG3PJ/OI/vkAvBJ9mn3WkpnUc2e1i5MalFR3+OVGCWkpt+9o9lo37qaDHN73EQyfJlUGJtHDfebFHmfWFBhpiGFs0kh/kCIUfuMmfQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GNerUHl0; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ee8911b451so55398861fa.2
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 15:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720477332; x=1721082132; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/klr4pal0zQ+qkbOyt3Sy9bpPlhmD8yV7byDM6Ourbw=;
        b=GNerUHl0ajDjvWkF7YbwA/1JVXWRZTevJXGf0HtD50JNLXrKRjzDmv+XwkjTBnyL88
         aplr2xXXl03B0EP2KnQ/tcex9Dyxd5h4E3UvXGnA0T21oC2vMRdpPb3hV4aiGZ8gm7OX
         6/xVjHuPBQUC7K5gth3BNnkoYgqTK5iyabdY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720477332; x=1721082132;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/klr4pal0zQ+qkbOyt3Sy9bpPlhmD8yV7byDM6Ourbw=;
        b=qPtgshhDhcay/a0nYW4lSmGrcfDlPHaoGNNLB6jtSKye7K4QRgogYKmZK36e0KrKPl
         IbvSN29TKUGTJi6UsM9PEMi6yrfZHPyBUfFV1YrtpwNiDAxmNBE5lE62rZ8onlrHGIVx
         nXnQBYEHH0UNBgsdR4yza7UgS46Wkn0xl1AoA/ImyI3KWw9v0nXs+Hd4RRFN8W5VW3cb
         lCZDjpSNoknLn37W5Wdn9xaguR94cwHzn95Nof1X5td63SmvZyozqgNh0Lbr6XL73PaG
         PulkYVSh3mDty2EHUyqKZgaKLjc7UKiLf342uCXsAgkbAYBoLvpKYPeIUF0OYaEwBz+0
         L/+w==
X-Forwarded-Encrypted: i=1; AJvYcCXSGuvdRqBt3qKV6UCwj930KYNI7wCcV5bsEx4LEQeUJBFyMjzTpb4Hzc2hfMPzXJoV8sAwP6E5zWY1IC9G6JayOR34
X-Gm-Message-State: AOJu0Yzbf30Y6QxHHGpeA+PC7N/CzIwNdVybAJA1ZJ41vbaS71hpAtLX
	kc+ze/Se9+ZXi+uPoB6IGSlfslnwa0kMJjE2JKVL8OS65yQEm3Kr2D9GNKgzFWQ=
X-Google-Smtp-Source: AGHT+IFII0Z4k5zO4+WVg6UOmIJTwUe1aRNvrkRm8kXkSN7SHLYkIk+Hq6VsR3UW4MiC3Amoj70LAw==
X-Received: by 2002:a2e:9807:0:b0:2ee:7b93:5209 with SMTP id 38308e7fff4ca-2eeb318ab22mr4721111fa.45.1720477331537;
        Mon, 08 Jul 2024 15:22:11 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:6c1e:b1f8:4156:8a30? ([2001:8b0:aba:5f3c:6c1e:b1f8:4156:8a30])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eeb3488b35sm527791fa.128.2024.07.08.15.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 15:22:11 -0700 (PDT)
Message-ID: <141a4ba7c3645594de636985d3300f3914a160f1.camel@linuxfoundation.org>
Subject: Re: [Automated-testing] Plumbers Testing MC potential topic:
 specialised toolchains
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: gtucker@gtucker.io, Nick Desaulniers <ndesaulniers@google.com>, Miguel
 Ojeda <ojeda@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>
Cc: llvm@lists.linux.dev, rust-for-linux@vger.kernel.org,
 yurinnick@meta.com,  bpf@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 automated-testing@lists.yoctoproject.org
Date: Mon, 08 Jul 2024 23:22:09 +0100
In-Reply-To: <f80acb84-1d98-44d3-84b7-d976de77d8ce@gtucker.io>
References: <f80acb84-1d98-44d3-84b7-d976de77d8ce@gtucker.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-09 at 00:10 +0200, Guillaume Tucker via
lists.yoctoproject.org wrote:
> Based on these assumptions, the issue is about reproducibility -
> yet alone setting up a toolchain that can build the code at all.
> For an automated system to cover these use-cases, or for any
> developer wanting to work on these particular areas of the
> kernel, having the ability to reliably build it in a reproducible
> way using a reference toolchain adds a lot of value.=C2=A0 It means
> better quality control, less scope for errors and unexpected
> behaviour with different code paths being executed or built
> differently.
>=20
> The current state of the art are the kernel.org toolchains:
>=20
> =C2=A0 https://mirrors.edge.kernel.org/pub/tools/
>=20
> These are for LLVM and cross-compilers, and they already solve a
> large part of the issue described above.=C2=A0 However, they don't
> include Rust (yet), and all the dependencies need to be installed
> manually which can have a significant impact on the build
> result (gcc, binutils...).=C2=A0 One step further are the Linaro
> TuxMake Docker images[2] which got some very recent blog
> coverage[3].=C2=A0 The issues then are that not all the toolchains are
> necessarily available in Docker images, they're tailored to
> TuxMake use-cases, and I'm not sure to which extent upstream
> kernel maintainers rely on them.
>=20
>=20
> Now, I might have missed some other important aspects so please
> correct me if this reasoning seems flawed in any way.=C2=A0 I have
> however seen how hard it can be for automated systems to build
> kernels correctly and in a way that developers can reproduce, so
> this is no trivial issue.=C2=A0 Then for the Testing MC, I would be
> very interested to hear whether people feel it would be
> beneficial to work towards a more exhaustive solution supported
> upstream: kernel.org Docker images or something close such as
> Dockerfiles in Git or another type of images with all the
> dependencies included.=C2=A0 How does that sound?

Sadly I can't be at plumbers however I wanted to mention that Yocto
Project's SDKs are effectively standalone toolchains. They can be
configured to contain all their dependencies and whatever tools are
desirable (e.g. git, python etc.), are fully reproducible, installable
at any location and we have working rust compilers in the SDKs if
configured to include them.

I just want to make sure people know that capability exists!

Cheers,

Richard


