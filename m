Return-Path: <bpf+bounces-74092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D78CC485A6
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 18:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B2D3AC329
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 17:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D2F2D8370;
	Mon, 10 Nov 2025 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Egvdc/Jz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42874277C9E
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795931; cv=none; b=uwmH6D4uwfJIn7/wIeLUoGJZ7ZxhTCtSFiuCwykK9i7vQAW12NtwrbAFFtDuBkhfLXu1Ag+SrLlgL8LyZ+mlAiUGPmKiwW2hu75sYqTsONiwn2O5qoIarjW685y7h3xe4S+ZMa297mzF/GxZHYDbak6IC1X2MFOYq9WkapDJAIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795931; c=relaxed/simple;
	bh=r3zTC7qghH6nyQQ1rq/etXGZP7RGAg0Siw9ee7Orbag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qq2FeX6A16c/K6aCdJg6MqINUsR85+ZLkMPcIs2INlOiRkEUp2OiE1NpGNeQ5C2pF73vdBr0fliRHEMDPn2k9NWGB33UdfnsDOJDx/3HGC1Z43XyQYynrj/qr6oETKlZyOpHhvRlsfpTt5sT9RWY/IbwDPZy2UlFGq/c3Mg6BM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Egvdc/Jz; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e89de04d62so27749891cf.0
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 09:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762795922; x=1763400722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8TTgWgBBbji+1m4gmho+4hLr3aZiAPu0ycay2BHGMo=;
        b=Egvdc/Jz7SL/Gc5zxbpXmHX9DH6lbadXC94vKQoV1qsG7bxol6trfsyolagHmDv/IA
         QBjwbTWLFW55LAq56zKji7+P5rX8wrfNeK7O7aMlZNEyX6Ap9quAWDg5mz7rARd0UL0Z
         uIfGEKiHpBvk6CmqX5fZkeViBs7YZgHtv1S8kKVdl0dmJOgk4d9Np1LdrMQHh6W8OTq5
         rv0y9BNnkC9cJc82LKxx5bd4JEbzJHiI6ag/5QOTDupHJNur/lV79I4h7uXHrDuOcSZo
         OlXwIKl/BPm8Auo32JJEnjM9SjlrGn8afQ19ubWyDk5hOtH+/fk2TJMcuH0TdE903Prz
         vJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762795922; x=1763400722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t8TTgWgBBbji+1m4gmho+4hLr3aZiAPu0ycay2BHGMo=;
        b=Ko9ExoxojGAMeTLrtDnkYGd+LJrMy+Du7DZm+dMmXHQ28z/bXj9NoIqzBVNTLP8rZD
         FBDGqER9oJhyjYREDq2Ut/7XzxOl99U4pc6pnePI/m1iMeK1BdxL8KtFiMk3QqRZwDYS
         0nCQI5MQz6rnDAZXzDY6rPzqHJH3+jzJaXfroTNZ+JuoLSlLw1LbTL3EbPMDfwiR+mVY
         r55p/q9UtMfyaBvQZ09Px2JxUVtruDzDuo42r3kChfwExToXND4F8TLfS5HCpZwiJVDI
         zIjGK5msptcsytijWzkA/3wACrC+Phagk62svuAy/zTwWolwijB7iFlGKB+tXUBEtnP0
         PctA==
X-Gm-Message-State: AOJu0Yw7xzTewpTPH+yoffZUi9rjBl90Rh0lFzaEyPK/kGdk4uKZ0+EF
	quJPdZ+7XfxXk0hFUvTwm/6dxYYpnF4B2pjvYe8vG/PzyaIhoO11+1EB6aZ2GlYYbSMa/dx1RHf
	SN9gj/Lu3mzk4zVusZcoXkm8hD6P/AaQ=
X-Gm-Gg: ASbGncu9VKfdLw9xInrCD3Aldu4YGpU/5KniYHqUW0yvOq8nMIhhe4oxl3n/dmrQ+AN
	/TtACXR37YWS1KbZVRixdgfMdFn6qilqDQGdGstAoEP9/A0IjWfJQoNMu6apNX9AGR4rWWtuFDH
	4n2GDiwv2A6+imH87RoAjcFKuotjYmK5Tq8F5n1kTYFZp565KrrikvFqY8/iDIaTNVmwVwCZGZW
	xJ/O7VyOjE+uD2N1JgzqoOmEzRtd0E5/Yi7vuUj2PvPfqyEL/BUoDduiP8cifczuPxo56W00V2m
	Ywiv/C2WPnmPtM9ASw==
X-Google-Smtp-Source: AGHT+IEnxw83ZSwU3yBsIFTWt/9ClFy39ZslLx3kDLyeXTyEVtgjsZUkJJU04esHrM5AXWUOvztY1OyFw9jGfE1DdVU=
X-Received: by 2002:a05:622a:1a27:b0:4eb:771e:1669 with SMTP id
 d75a77b69052e-4eda4fa29dbmr113476281cf.54.1762795921803; Mon, 10 Nov 2025
 09:32:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3+h2yuppeOisqT+G6pf9zsP7sTbbbgKWpMe6s5TL6fZ-coWg@mail.gmail.com>
 <893afb17-aac2-47d6-8651-e07ccc37995b@linux.dev> <CAK3+h2yZ=RS1SM_NvycfiBM_16HEc5apZdKiCv6_75Ts8Ps6=g@mail.gmail.com>
In-Reply-To: <CAK3+h2yZ=RS1SM_NvycfiBM_16HEc5apZdKiCv6_75Ts8Ps6=g@mail.gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Mon, 10 Nov 2025 09:31:51 -0800
X-Gm-Features: AWmQ_bkBRRoWwtt2AGIGsnzFeEK71OHXpGD9e79AfqaHviCB72JPE7iXObwt_GU
Message-ID: <CAK3+h2yx_ruaJmkQj4kysDq2J7U3paGZjXAvKn-3Y_4SCDjO1w@mail.gmail.com>
Subject: Re: [BPF selftests]:bpf_arena_common.h: error: conflicting types for 'bpf_arena_alloc_pages'
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, ast <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 4:44=E2=80=AFPM Vincent Li <vincent.mc.li@gmail.com>=
 wrote:
>
> On Sun, Nov 9, 2025 at 11:50=E2=80=AFAM Yonghong Song <yonghong.song@linu=
x.dev> wrote:
> >
> >
> >
> > On 11/9/25 9:09 AM, Vincent Li wrote:
> > > Hi,
> > >
> > > Sorry if this is a known issue,  but I could not find it.  my build e=
nvironment:
> > >
> > > [root@fedora linux-loongson]# pahole --version
> > > v1.30
> > > [root@fedora linux-loongson]# clang --version
> > > clang version 21.1.5
> > > Target: loongarch64-redhat-linux
> > > Thread model: posix
> > > InstalledDir: /usr/bin
> > >
> > > [root@fedora linux-loongson]# bpftool version
> > > bpftool v7.6.0
> > > using libbpf v1.6
> > > features: llvm, skeletons
> > >
> > > I got errors below while building bpf selftests with bpf-next branch,
> > > I had to comment out the bpf_arena_alloc_pages,
> > > bpf_arena_reserve_pages, bpf_arena_free_pages in
> > > tools/include/vmlinux.h, then progs/stream.c build succeeded. It look=
s
> > > like these functions in tools/include/vmlinux.h generated by bpftool
> > > are not the same as in bpf_arena_common.h. is there something wrong i=
n
> > > my build environment?
> >
> > Could you try pahole master branch? See the conversion in
> >    https://lore.kernel.org/bpf/8a94c764c5fa4ff04fa7dd69ed47fcdf782b814e=
@linux.dev/
> >
>
> Thanks Yonghong! I just tried the pahole master branch which shows
> 1.30 version, and pahole next branch which shows 1.31 version, same
> problem.
>
> [root@fedora dwarves]# pahole --version
> v1.31
>
> [root@fedora build]# cd /usr/src/linux-loongson/tools/testing/selftests/b=
pf/
> [root@fedora bpf]# make clean
>   CLEAN
>   CLEAN   Module.symvers
>   CLEAN   eBPF_helpers-manpage
>   CLEAN   eBPF_syscall-manpage
> [root@fedora bpf]# make -j6
>
> Auto-detecting system features:
> ...                                    llvm: [ on  ]
> ...
>   INSTALL bpftool
>   GEN      vmlinux.h
> ...
> CLNG-BPF [test_progs] strobemeta.bpf.o
> In file included from progs/stream.c:8:
> /usr/src/linux-loongson/tools/testing/selftests/bpf/bpf_arena_common.h:47=
:15:
> error: conflicting types for 'bpf_arena_alloc_pages'
>    47 | void __arena* bpf_arena_alloc_pages(void *map, void __arena
> *addr, __u32 page_cnt,
>

I had an issue with kernel 6.18.0-rc4+, 6.18.0-rc5+ is fixed

> > >
> > >
> > > In file included from progs/stream.c:8:
> > > /usr/src/linux-loongson/tools/testing/selftests/bpf/bpf_arena_common.=
h:47:15:
> > > error:
> > >        conflicting types for 'bpf_arena_alloc_pages'
> > >     47 | void __arena* bpf_arena_alloc_pages(void *map, void __arena
> > > *addr, __u32 page_cnt,
> > >        |               ^
> > > /usr/src/linux-loongson/tools/testing/selftests/bpf/tools/include/vml=
inux.h:180401:14:
> > > note:
> > >        previous declaration is here
> > >   180401 | extern void *bpf_arena_alloc_pages(void *p__map, void
> > > *addr__ign, u32 page_cnt, int node_i...
> > >          |              ^
> > > In file included from progs/stream.c:8:
> > > /usr/src/linux-loongson/tools/testing/selftests/bpf/bpf_arena_common.=
h:49:5:
> > > error:
> > >        conflicting types for 'bpf_arena_reserve_pages'
> > >     49 | int bpf_arena_reserve_pages(void *map, void __arena *addr,
> > > __u32 page_cnt) __ksym __weak;
> > >        |     ^
> > > /usr/src/linux-loongson/tools/testing/selftests/bpf/tools/include/vml=
inux.h:180403:12:
> > > note:
> > >        previous declaration is here
> > >   180403 | extern int bpf_arena_reserve_pages(void *p__map, void
> > > *ptr__ign, u32 page_cnt) __weak __ksym;
> > >          |            ^
> > > In file included from progs/stream.c:8:
> > > /usr/src/linux-loongson/tools/testing/selftests/bpf/bpf_arena_common.=
h:50:6:
> > > error:
> > >        conflicting types for 'bpf_arena_free_pages'
> > >     50 | void bpf_arena_free_pages(void *map, void __arena *ptr, __u3=
2
> > > page_cnt) __ksym __weak;
> > >        |      ^
> > > /usr/src/linux-loongson/tools/testing/selftests/bpf/tools/include/vml=
inux.h:180402:13:
> > > note:
> > >        previous declaration is here
> > >   180402 | extern void bpf_arena_free_pages(void *p__map, void
> > > *ptr__ign, u32 page_cnt) __weak __ksym;
> > >          |             ^
> > > 3 errors generated.
> > >
> > > Vincent
> >

