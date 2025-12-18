Return-Path: <bpf+bounces-76946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF083CC9E98
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 01:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1877C30275CB
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 00:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638DD21B196;
	Thu, 18 Dec 2025 00:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3G7Qgnf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3908681ACA
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 00:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766018390; cv=none; b=FKIHSMAmAiV5TKpG56dIFdGeHBrbeSP5NJOXQuKyoEkuJbN+XsjjsztdDndUD1iMgRF/0VQwR+Z4GfrjtbRq3FTEOKtejOd/t6TuH0YehvWwkPGEpFpvyQW77mFdCrsEgi+tBMqfi2kfIO5Ue7W/kuRBfKU5M11m3fsbksDq3ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766018390; c=relaxed/simple;
	bh=OMMeFSO3tEp62+nlq516wb8A2FNxXhlYW8J+8uSS7uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCiSfv/0Ynm1OzF2KBCHnsM1AWapXJ4gp/qqf0rxluZc+GHwbXPGk4bmjDg2L2+b9l+105otruhrtC5Q38lBXm1ImCAMmCBYOqiRtt8j/kjnbz+TYPgFOa2T0K72Mk4uiYpdMc13S26dni0ZfQCm0L4zjc5tXUaqPC/qZlkWmQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3G7Qgnf; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fbc3056afso17680f8f.2
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 16:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766018387; x=1766623187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cf2mWuy77SjueBs85v+KhB47SD7iGqhYfzQP/bkaCcU=;
        b=L3G7Qgnfb6gPYdmXijtPqA11D6xhAg359c7DIEUaS091xmYCHyaYgKG+8yxg8RhO+B
         6u/XHLcc32ge3Kut9sxhSwIxTjK9eScyp36WHZG0VrCifFIPKXHcfHbpMSAJoswtKiLt
         6SjsOxxD4ffNKxsm6R+WCt4cFMaZPA/4r3Mass/dhiV7saIAiuu3BDs6sVsLlqVtGAqP
         tp+hPg8vzg4VKtOPJtaLJLgECnpgTJy117ZRqK7fneIZn8j/cNB0aiFHTH+YYbDJXvAS
         VXjEN+yJf+euuP3aeWoXx5z4PvIKePrvzwYPc36+W/q5hwlfbt7emn0PwjqA86ZShNQm
         hyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766018387; x=1766623187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cf2mWuy77SjueBs85v+KhB47SD7iGqhYfzQP/bkaCcU=;
        b=uw3lNrcsITOIIqe1UYXakOd6sjg0aBNEAOMcG51mYq7E3yZGay3Vc6VK9j1/kKEv0r
         0pg5FU57QGHcnRrb0SRZCt0pMkvy91J7d8HBC57wLHaADNGu+PpF5a1HuhvuR/AmAXZQ
         BhvZ/eYHxLOJKYOnNda+ozx3j36GIhU/ywzshRWnOBNbhYyp8Mv8/aNF6hzW2/BbzGPJ
         gTqebVynlQLIHHd74QGcObSrYi5jt3wOIjj3hxi7b2EczPzhSohXVpM1OIowBh9hbgq4
         wC+RqmzKjlCYi3MGGc/9BE7ka1D2Fx3jWzZixuKq9vTY4DwNGcy8s4WFNqt5K4bIKkPy
         z4uw==
X-Forwarded-Encrypted: i=1; AJvYcCUIDQC1QUnOxDLK1KE9lU0VSfhgwFF1/ahdNCI574uPpTveZokQ4lnleBaTuVi9Lf5dJ4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4KNx0Xr1GEPogys3UWJAVFFJL5n+wq6gvkqvVoq45BAfF1zbq
	PvAYzZI4JmN+TXzEquwf14OjGzkfhXdMSE0d8d2027IiOybgxOO6yYpusHdgtx1zreIYEsPPW5m
	7bOu6opXbkW8gDe5RTL7ooDwk4RCeNYcpjw==
X-Gm-Gg: AY/fxX656i4kanL+TqImzDuvMd7268DUdGQqGSlRdo3TgtC3R15+XlxdB+e5Ylsk1WF
	OyFWqR/YVqnFvU9GoO7luZNsmFpL3HTpMi7T1ozOGxw6WDc/OELQOk+QlZW66Xg2KTvhTvy5AE1
	yXVGHb2JRr+m3vzlbsBuwiyh3RIbnSM39qDV3872IRAEz98pfOMDWNkN9X1aVOCSnjLRo/wY4M2
	6un50D4albe7LxM/SZa/2SZz9lNZFu3UStR9GHQykePNccQhSGAttl1a32qIw87wEJFI+eoGJqv
	WuAbr5Et6bV1o6HNHL5rNcOeaS//XKhFCiWeHIU=
X-Google-Smtp-Source: AGHT+IFvxMVMKkEs9DUlsIXw4hHMbI2uuApxrd+ZZdzmghurN7/6+atYLgsmFI5qNqCzM94lIdxe5Z0roLosFSXxyeA=
X-Received: by 2002:a5d:6a11:0:b0:42f:bc6d:e468 with SMTP id
 ffacd0b85a97d-42fbc6de571mr12942684f8f.55.1766018387370; Wed, 17 Dec 2025
 16:39:47 -0800 (PST)
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
 <5022ccaf5591e5bb88fe3d7a08dbb3c4fb6c3132.camel@gmail.com>
 <aeeae7e13ce401726ddce756268c0686d30eb3a9.camel@gmail.com>
 <CAADnVQL=2m9NHjr0zbMoDyha=6sBFd69=1QRdxSCKYhEONTmaw@mail.gmail.com> <4d3972ec6951b3c02f79def0215e5bb4fc70aba4.camel@gmail.com>
In-Reply-To: <4d3972ec6951b3c02f79def0215e5bb4fc70aba4.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 Dec 2025 16:39:36 -0800
X-Gm-Features: AQt7F2qxZQkh4P-7PPhi-UBO4cSPxIu2PeZp9g2_0JSHpGgLpzkNK9f27k0z3Zs
Message-ID: <CAADnVQKN7ijzWA6JdSMi_XecPfvjtCKRo9nNZv5LTKq9FO973Q@mail.gmail.com>
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

On Wed, Dec 17, 2025 at 4:19=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-12-17 at 15:34 -0800, Alexei Starovoitov wrote:
> > On Wed, Dec 17, 2025 at 2:47=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > >   $ cat ms-ext-test2.c
> > > >   struct foo {
> > > >     int a;
> > > >   } __attribute__((preserve_access_index));
> > > >
> > > >   struct bar {
> > > >     struct foo;
> > > >   } __attribute__((preserve_access_index));
> > > >
> > > >   int buz(struct bar *bar) {
> > > >     return bar->a;
> > > >   }
> > > >
> > > >   $ clang -O2 -g -fms-extensions --target=3Dbpf -c ms-ext-test2.c
> > > >   ms-ext-test2.c:6:3: warning: anonymous structs are a Microsoft ex=
tension [-Wmicrosoft-anon-tag]
> > > >       6 |   struct foo;
> > > >         |   ^~~~~~~~~~
> > > >   1 warning generated.
> > > >
> > > >   $ llvm-objdump -Sdr ms-ext-test2.o
> > > >
> > > >   ms-ext-test2.o: file format elf64-bpf
> > > >
> > > >   Disassembly of section .text:
> > > >
> > > >   0000000000000000 <buz>:
> > > >   ;   return bar->a;
> > > >          0:       61 10 00 00 00 00 00 00 w0 =3D *(u32 *)(r1 + 0x0)
> > > >                   0000000000000000:  CO-RE <byte_off> [2] struct ba=
r::<anon 0>.a (0:0:0)
> > > >          1:       95 00 00 00 00 00 00 00 exit
> > > >
> > > > Note the "<anon 0>" in the relocation.
> > > > It appears that we loose no information if structures are unrolled.
> >
> > Forgot to mention the CORE concern earlier...
> > Does the above work with current logic in relo_core.c ?
> > If not, we should definitely unconditionally unroll
> > to avoid fixing CORE.
>
> I think there might be an issue with CO-RE.
> Here is an example:
>
>   struct foo {
>     int a;
>   } __attribute__((preserve_access_index));
>
>   struct bar {
>   #ifdef USE_MS
>     struct foo;
>   #else
>     struct { int a; };
>   #endif
>   } __attribute__((preserve_access_index));
>
>   int buz(struct bar *bar) {
>     return bar->a;
>   }
>
> Here is what I get with USE_MS:
>
>   $ llvm-objdump -Sdr ms-ext-test2.o
>
>   ms-ext-test2.o: file format elf64-bpf
>
>   Disassembly of section .text:
>
>   0000000000000000 <buz>:
>   ;   return bar->a;
>          0:       61 10 00 00 00 00 00 00 w0 =3D *(u32 *)(r1 + 0x0)
>                   0000000000000000:  CO-RE <byte_off> [2] struct bar::<an=
on 0>.a (0:0:0)
>          1:       95 00 00 00 00 00 00 00 exit
>
>   $ bpftool btf dump file ms-ext-test2.o
>   [1] PTR '(anon)' type_id=3D2
>   [2] STRUCT 'bar' size=3D4 vlen=3D1
>           '(anon)' type_id=3D3 bits_offset=3D0
>   [3] STRUCT 'foo' size=3D4 vlen=3D1
>           'a' type_id=3D4 bits_offset=3D0
>   [4] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
>   [5] FUNC_PROTO '(anon)' ret_type_id=3D4 vlen=3D1
>           'bar' type_id=3D1
>   [6] FUNC 'buz' type_id=3D5 linkage=3Dglobal
>
> And here is without USE_MS:
>
>   $ llvm-objdump -Sdr ms-ext-test2.o
>
>   ms-ext-test2.o: file format elf64-bpf
>
>   Disassembly of section .text:
>
>   0000000000000000 <buz>:
>   ;   return bar->a;
>          0:       61 10 00 00 00 00 00 00 w0 =3D *(u32 *)(r1 + 0x0)
>                   0000000000000000:  CO-RE <byte_off> [2] struct bar::<an=
on 0>.a (0:0:0)
>          1:       95 00 00 00 00 00 00 00 exit
>
>   $ bpftool btf dump file ms-ext-test2.o
>   [1] PTR '(anon)' type_id=3D2
>   [2] STRUCT 'bar' size=3D4 vlen=3D1
>           '(anon)' type_id=3D3 bits_offset=3D0
>   [3] STRUCT '(anon)' size=3D4 vlen=3D1
>           'a' type_id=3D4 bits_offset=3D0
>   [4] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
>   [5] FUNC_PROTO '(anon)' ret_type_id=3D4 vlen=3D1
>           'bar' type_id=3D1
>   [6] FUNC 'buz' type_id=3D5 linkage=3Dglobal
>
> So, with USE_MS the relocation captures the offset inside 'struct foo'.
> And this is important for CO-RE offsets resolution.
> So unrolling structures is actually a problem.

Sounds like we should silence the warning the way Song proposed and
tell all users to add -fms-extension to their builds.

