Return-Path: <bpf+bounces-65280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 597DAB1EEC7
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 21:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 168FC7A5E8F
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 19:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691E328000A;
	Fri,  8 Aug 2025 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6MV9Ehg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353E71F4289;
	Fri,  8 Aug 2025 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754680248; cv=none; b=BOBep2Ka+EKpox2Aooywl54dVc7Yj0E4Q3F7l63uqYDMYy1TUU+P2dQq+Ued5FuZKFR6Y7KE5FQr5DJMEX5PMhlxpkrfdiZRr8xCv865vCKEml4ngPE7EpCyuSVUHlGqgkJhW0tID5Ab+wmBEMq8o5P7KEUvE4Vfu3s12nlJJLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754680248; c=relaxed/simple;
	bh=YUu+6Ucu465K4/Z7682r2DI0XYkfqLXnLtKeFVBqNos=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sa+Vbxs9GDyhtYBkjYbRQEbl4BWBpAYml5Da/G3uygKpE+Lh+OiUL0BlSEZwm9GqHCk7FAjsoI01Yl+00m2rBM9jpDgfp8Bw3v0CyDvA6RzfoZVEMc61Qc3g9MLi3lbjm2wzrjzXuXZOpvhpmPghpwmZEJJVpR5bqdaTBN2oggE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6MV9Ehg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-af949bdf36cso439245666b.0;
        Fri, 08 Aug 2025 12:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754680244; x=1755285044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7veoJNoglO3OrVbIWF5kTjeyJnzqFqH82O8hYzbxC08=;
        b=i6MV9EhgtxkuZ1Ro4eAzrbfFo4pmnjvsZr2zDbYwrQh952r5h8V7izStTfqta6rioJ
         JzEYlLmNu6hN+GfoMNgePoWUv4q0cUo3XOfxCuRVeGO/n9ATKAOtQzemDQu+QmhgrCt9
         2UHg8CfpeMpXITTi91QnEm+uUY12iUnrXvqo1+AAZT+Knd/5nVHZgC1CLLMwVmWGTXab
         yb8Ur39HgoNuEsqXtHmd5yfmglm0XXy/YLrebtxjHEQssH8N3jvWOsw8dO5pdK2wbjdA
         P95tUwzQM6qO/XtfSekKrCgqTQmxYIdL8HK1PaWSPz/phJ2cc6i1x4PucPCWmx958376
         a+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754680244; x=1755285044;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7veoJNoglO3OrVbIWF5kTjeyJnzqFqH82O8hYzbxC08=;
        b=BJKHQkOGxTWUT9DutBd8xOMjgaILl1CbrX7nFCrGWGSJjIFxMuLU28tEVaco9AFiYb
         UZpkfX3XVBzs2+6+Bpe6DVK9GLjaWfBhCHvzkLD5DFuxuxEqjO0aC4P09e11wOLFf0yE
         pi5dEDbRUI8XWbzMkLSwNdJKe7VqGenUeJRiLGuAGd3Lg93WCUlRDO2ZeIt3P5PJTgOY
         KL8CMyycAu/0m8g8GDQhZnAaKayEB5fzl9EMt7IkcQRFNJ86A8MYbzSqM/jnXMoeX/Eq
         qNT9vIDubRyv8FITQ1VfCdTYPWabB+bXxhMQFYpF3ibTkodGfzvqXZJDjEb1K4dvze29
         SFIw==
X-Forwarded-Encrypted: i=1; AJvYcCVn5pkwPhbapRr+UZAksDedRujYrNh/c1duBGJajTMLXA/iIpldnEy1bpcV4jTouTd146PadptsiQ==@vger.kernel.org, AJvYcCW1DQR4n6DYqeUF5kdEardlLbARsd75viw/eYYNX9V2PLxy1uq3c/p9Rxf8LzC7xc2ToiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKKdocEyFQg82Tol0ZapIpDaQVLvWk3GQUJ2u7SnnXnvxoTbPQ
	derlPGj8J7eDYNNdacZmE/jqFVPPhXCozgi1Okg06FPBW3gcD3mCw5zO
X-Gm-Gg: ASbGnctsZKsqhRs1tT57UyOd6xKM4Tt1mLkVj/SjmiMyeS55XO3/EpRXnVQTbtECeUN
	pZUyde084n4KPBrckW8kLevkjm80ZM4nY0OvOs6HJRqGxp95+i59MXpz3CPio50P+OGyYuLpemv
	U/go1EwLw3xS6Gmyis/4xUS7uYKptMiSvBua2QeElyVNVXR3XrLars2rPfqswy5H9qmumu4fN5k
	ORoqBHbRavkhgyvWgnbT3aIgba26AvLAmJfThwlOvbEQMCv0xqOn5DQuprshi7P0nkY3ibKnQtR
	Xc2qFTLfMbMTleA3C5/su3Vyr5bBBCZqWDotQ1c+xGBLE7dpnqS5BcCnQQWH2mnJgFKVl1Kdb1Y
	6z+1T0lYKimfu+ZBt8uW5ZkQmZleD0kQGsRewgw==
X-Google-Smtp-Source: AGHT+IECj1V4YLnR+GEmVwloM2Qnf9XP5ISvsdoQyxgBX8H5ewaW8WzYqh0lXUZ5ARynUHwm8Eh6Gw==
X-Received: by 2002:a17:907:6d13:b0:ae0:c7b4:b797 with SMTP id a640c23a62f3a-af9c6517c11mr392070866b.45.1754680244262;
        Fri, 08 Aug 2025 12:10:44 -0700 (PDT)
Received: from ehlo.thunderbird.net ([176.223.173.152])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8efffa5sm13722143a12.12.2025.08.08.12.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 12:10:43 -0700 (PDT)
Date: Fri, 08 Aug 2025 16:10:38 -0300
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, nick.alcock@oracle.com,
 Alan Maguire <alan.maguire@oracle.com>
CC: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
 Kate Carcia <kcarcia@redhat.com>, dwarves <dwarves@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>,
 "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 Nick Alcock <nick.alcock@oracle.com>, Namhyung Kim <namhyung@kernel.org>,
 bpf <bpf@vger.kernel.org>
Subject: Re: [RFC 0/4] BTF archive with unmodified pahole+toolchain
User-Agent: Thunderbird for Android
In-Reply-To: <b297444e23c42caeab254c90fa91f46f75212e29.camel@gmail.com>
References: <20250807182538.136498-1-acme@kernel.org> <CAADnVQ+cvvHN9CunLP03yRFKz2YJirmF0j80-fZ0A-8aVVopPg@mail.gmail.com> <b297444e23c42caeab254c90fa91f46f75212e29.camel@gmail.com>
Message-ID: <8EEC78FB-CBFA-4DFD-827D-3D5E809ACA0F@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On August 8, 2025 3:28:13 PM GMT-03:00, Eduard Zingerman <eddyz87@gmail=2E=
com> wrote:
>On Thu, 2025-08-07 at 19:09 -0700, Alexei Starovoitov wrote:
>
>[=2E=2E=2E]
>
>> Before you jump into 1,2,3 let's discuss the end goal=2E
>> I think the assumption here is that this btf-for-each-=2Eo approach
>> is supposed to speed up the build, right ?
>> pahole step on vmlinux is noticeable, but it's still a fraction
>> of three vmlinux linking steps=2E
>> How much are we realistically thinking to shave off of that pahole dedu=
p time?
>
>Hi Alan, Arnaldo, Nick,
>
>I'd like to second Alexei's question=2E
>In the cover letter Arnaldo points out that un-deduplicated BTF
>amounts for 325Mb, while total DWARF size is 365Mb=2E
>I tried measuring total amount of DWARF in my kernel building directory:
>
>  for f in $(find =2E -name "*=2Eo" | grep -Ev '(scripts|vmlinux|tools|mo=
dule-common)'); do \
>    readelf -SW $f | grep "\=2Edebug";
>  done \
>  | awk 'BEGIN {val=3D0} {val +=3D strtonum("0x"$6)} END {printf("%d", va=
l)}' \
>  | numfmt --to=3Dsi
>
>And it says 845M=2E
>The size of DWARF sections in the final vmlinux is comparable to yours: 3=
07Mb=2E
>The total size of the generated binaries is 905Mb=2E
>So, unless the above calculations are messed up, the total gain here is:
>- save ~500Mb generated during build
>- save some time on pahole not needing to parse/convert DWARF


Well, this 845M number includes modules, that I didn't take into account i=
n my quick calculation for both DWARF and BTF=2E

>Is this is what you are trying to achieve?

>In theory, having BTF handled completely by compiler and linker makes
>sense to me=2E =20

It looks right, no? But it's not efficient as BTF, as you point out in you=
r next paragraph, can be generated from DWARF, so better do it as a final s=
tep if we want to have DWARF _and_ BTF=2E

> However, pahole is already here and it does the job=2E
>So, I see several drawbacks:
>- As you note, there would be two avenues to generate BTF now:
>  - DWARF + pahole
>  - BTF + pahole (replaced by BTF + ld at some point?)
>  This is a potential source of bugs=2E
>  Is the goal to forgo DWARF+pahole at some point in the future?

I think the goal is to allow DWARF less builds, which can probably save ti=
me even if we do use pahole to convert DWARF generated from the compiler in=
to BTF and right away strip DWARF=2E

This is for use cases where DWARF isn't needed and we want to for example =
have CI systems running faster=2E

My initial interest was to do minimal changes to pave the way for BTF gene=
rated for vmlinux directly from the compiler, but the realization that DWAR=
F still has a lot of mileage, meaning distros will continue to enable it fo=
r the foreseeable future makes me think that maybe doing nothing and contin=
ue to use the current method is the sensible thing to do=2E

>- I assume that it is much faster to land changes in pahole compared
>  to changes in gcc, so future btf modifications/features might be a
>  bit harder to execute=2E Wdyt?

Right, that too, even if we enable generation of BTF for native =2Eo files=
 by the compiler we would still want to use pahole to augment it with new f=
eatures or to fixup compiler BTF generation bugs=2E And maybe for generatin=
g tags that are only possible to have the necessary info at the last moment=
=2E

So something that looked like a hack seems not to really be one=2E

Then there's Gentoo, the one that likes the idea of a DWARF less build=2E=
=2E=2E I like that too, so will continue working on this 8-)

Now if we could have hooks in the linker associated with a given ELF secti=
on name (=2EBTF) to use instead of just concatenating, and then at the end =
have another hook that would finish the process by doing the dedup, just li=
ke I do in this series, that would save one of those linker calls=2E

I did some quick research and couldn't find such infrastructure in the lin=
kers, I think this is a sensible path, use the minimal changes in my patch =
series to have a =2Eso plugin to use with a linker that supports this, but =
then this, again, would make sense only for a BTF only build=2E


- Arnaldo 

