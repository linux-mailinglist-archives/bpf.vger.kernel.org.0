Return-Path: <bpf+bounces-76929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A81DCC9CEC
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 00:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80D023030FE2
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 23:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83497320A14;
	Wed, 17 Dec 2025 23:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ime/xHVM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A60926ED3D
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 23:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766014476; cv=none; b=I22XuTTNKEimWFkVvEHEMplq7R4rq64qyuM7jvTFzD1zE7vWeg0i6eCEdWa7jCOBR0gDJQx+bZF0M1xaWCISd5Kc9lmNX2Y2e1HJYoF7H4ptSj3p96KNKG4y2Y2CRqyyEzzMFLOAgbECBFRZKcwRaRychoKoKN8C/NJ8upQtR9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766014476; c=relaxed/simple;
	bh=SN20CF30K26blt2XfwzlhhfBNTVBSH6jFnY/UYsnd84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWt037vvTZtAP17ADB8rXx4zlLg0H+XgDfi++mduE4febNk36D75+Adqr/XU2ZM1HiWbEtI57EGA9YT3nqDB4/Xe922Lxm7U7BMc2gyIhoiBRKBHlILBNNuZIM3Zvr5qIKVtH/awpga3uCBM1Gc74tqImzV7ZSqmtervfeZ/uMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ime/xHVM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3c5defb2so1653f8f.2
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 15:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766014473; x=1766619273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IThrBwz2FSqWuUK/aZhhWl4ygxrcq5vyqc8K9S9WoY=;
        b=ime/xHVMeTRx+Nk6lQNEbAymQDbwHpUs8sGCqyalPQNiaywCurIMLlcgY0HQgLWhtH
         iDVdo+WZdExzAhHjY0b8dFBmt1uReLn2L1y1qLOUMh616VKfWUKs6yt6/SRkY5Xf+F5n
         axBWEvlIke6TEqP5zqQyvbKyHSsdvBaqGS3NslvZRAA0h7izKcAm5dbgglLpHvF7/T5E
         U7W2MPakOWmgMXAxEoVNOA1ZQfoa/+ajpFHOh1ml/d4UtD/w9QAYJwUJ3Khn0d3vivrR
         zJ1Ex2AHokb3VsPAhrvLHlxHZwjczi84qk/nKRganR1InZGHp20szYGx67uznz/Rmx7A
         uIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766014473; x=1766619273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2IThrBwz2FSqWuUK/aZhhWl4ygxrcq5vyqc8K9S9WoY=;
        b=DQHQTfZhoqSFMT/vUX7hv2k/3/O8fzGxlWBIQ5WHj2VVuLJI8YWVBNEW+LbWE/LrWz
         5wFeHE0dnm6c00LaS1fbJjbaiSsv3ssYMnRDHS+zQD2/ckwNRGWnPz187gdK/gf80T8K
         DTkfzyy4ZMgvgE1ilmBdL/bxHMcLKh3xbB8VFYa+/x6qP13Pg7FQBiMyV36nQBQEgTCP
         vaDK+7IXR3yS9syVV8oDWRltrOWthg1NcL/yka3rY/hFInGezRhYxPV1Km7uRHM8sGWE
         n21BqA/pz0eS7vfn4J+HuCuWJYy4A7c6CRwvozjkejpxYLHEG3fQJPTyJQBRWN8lSGOv
         kLMA==
X-Forwarded-Encrypted: i=1; AJvYcCX/Y4wbo2ANrs1jzNmA4aM2EI7QXwXYupIan15G18dwsathnvGPQp3xN9dkaKamzVj2/eE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3dXmv1v0OiQ/FQJeVaND02bGjCe5ZfAwWg35Kx0PKlW7eQY6f
	paxpbb4IZDfUk5IQAjOPyUbCkCZvf2VmXHzYQPeGDg6Gers2qsNQY4iyxQxKt9655w7nWXkheS1
	gZX/OJm3+6vHbKvU9L0JPtCglztMBSk4=
X-Gm-Gg: AY/fxX5zR5Yl6YL8tJyg1WYgqzMIDvAabQAF8igQyrm4O7nCiM6VdGezuk+qJt4wKrD
	owhjab/0fE0kKimesFqK3ddm/73moPy6jLnfO5Ek0KHIx07FnEgNrNGn1d2GEZQttRceH8QhPWw
	mtwGnWgzoYmiKBtmwzx/1z6Mmngmbn7dpPXW4hEAtq6Xfyzu4eQwXSd0ZaxogtbMnS0hZ+CJ4h3
	CbxcLSsdaCOybjxJF6Fs9+/7r7Yar/GSlaYz7EdsdNVu4qATwV76G7u7nzVvpWfarRIB6rZ6Eun
	pQg28fZaCL9bzelezsp3csObUxWF
X-Google-Smtp-Source: AGHT+IGDme3m23MwQPmWNrthSwIhT2gMk3PuN23X755tyn597j7shNrqywEzfgW/cIcAAEbWmuc+HJgNJaYrTCTB+1w=
X-Received: by 2002:a5d:64e8:0:b0:430:f6bc:2f8b with SMTP id
 ffacd0b85a97d-430f6bc3221mr15778635f8f.45.1766014472527; Wed, 17 Dec 2025
 15:34:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216171854.2291424-1-alan.maguire@oracle.com>
 <20251216171854.2291424-2-alan.maguire@oracle.com> <d5a578c01f8a2d4d95ca16e0a9ee5b9bfce1c30e.camel@gmail.com>
 <9a096b2a16d552031a12f3f4f5a2c725212df5e6.camel@gmail.com>
 <b535b47a-519e-4138-861b-c16ed7fa0bcd@oracle.com> <CAADnVQ+EyYO+aOZewNQwETr5rphOCp6jJQH_fw9GqjVFdQd19A@mail.gmail.com>
 <CAEf4BzbWZtRdKCGwhjRV9MOufTC-coWFSU5sRtk4gdm9S_bg+w@mail.gmail.com>
 <6ae6dfd8-3f73-4318-93c1-97541d267a28@oracle.com> <CAADnVQ+wNPbbA0e4+6kx+LtOH=09jJyiYcEKZfc8kt6UPnq=EQ@mail.gmail.com>
 <535846f7-4cc7-4b12-aab4-52e530d04706@oracle.com> <ae6c6e50b3176d4ee4cce4cda09807a05d103fbf.camel@gmail.com>
 <3071012cc1e8d6bdf16b13d371a12cb201c502a7.camel@gmail.com>
 <b65fd7dc-fbad-4a96-8eb8-f36f8f518d44@oracle.com> <CAEf4Bzb+3cryZAEwC_O7xgm3=cthZU-SNsUWfGH8OpSwc+3vaw@mail.gmail.com>
 <CAADnVQJ1V1vwPVnhyE4OfOSQt_BnB3wRW9g9_bhkdu-QZyuQkQ@mail.gmail.com>
 <5022ccaf5591e5bb88fe3d7a08dbb3c4fb6c3132.camel@gmail.com> <aeeae7e13ce401726ddce756268c0686d30eb3a9.camel@gmail.com>
In-Reply-To: <aeeae7e13ce401726ddce756268c0686d30eb3a9.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 Dec 2025 15:34:19 -0800
X-Gm-Features: AQt7F2o1ZWGlACYvxUgrk8qtC7j-8K8f8VZdNeJ0b41nXT1WwcOu1NSe_EJlNVs
Message-ID: <CAADnVQL=2m9NHjr0zbMoDyha=6sBFd69=1QRdxSCKYhEONTmaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add option to force-anonymize nested
 structs for BTF dump
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Quentin Monnet <qmo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 2:47=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> >   $ cat ms-ext-test2.c
> >   struct foo {
> >     int a;
> >   } __attribute__((preserve_access_index));
> >
> >   struct bar {
> >     struct foo;
> >   } __attribute__((preserve_access_index));
> >
> >   int buz(struct bar *bar) {
> >     return bar->a;
> >   }
> >
> >   $ clang -O2 -g -fms-extensions --target=3Dbpf -c ms-ext-test2.c
> >   ms-ext-test2.c:6:3: warning: anonymous structs are a Microsoft extens=
ion [-Wmicrosoft-anon-tag]
> >       6 |   struct foo;
> >         |   ^~~~~~~~~~
> >   1 warning generated.
> >
> >   $ llvm-objdump -Sdr ms-ext-test2.o
> >
> >   ms-ext-test2.o: file format elf64-bpf
> >
> >   Disassembly of section .text:
> >
> >   0000000000000000 <buz>:
> >   ;   return bar->a;
> >          0:       61 10 00 00 00 00 00 00 w0 =3D *(u32 *)(r1 + 0x0)
> >                   0000000000000000:  CO-RE <byte_off> [2] struct bar::<=
anon 0>.a (0:0:0)
> >          1:       95 00 00 00 00 00 00 00 exit
> >
> > Note the "<anon 0>" in the relocation.
> > It appears that we loose no information if structures are unrolled.

Forgot to mention the CORE concern earlier...
Does the above work with current logic in relo_core.c ?
If not, we should definitely unconditionally unroll
to avoid fixing CORE.

