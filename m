Return-Path: <bpf+bounces-76949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1A8CC9ED4
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 01:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DCBD3027DB1
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 00:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9411822156A;
	Thu, 18 Dec 2025 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBRbAgva"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC301DE3AD
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766019032; cv=none; b=FdgObrp6Ku6L37XvrTto0CpruYcWmECa1wWLhIxbBgD1wfyt03wcg8rwYeh9zQpAGZVsHlQn0+4dmkKPf+Va5Ub8ZGhUH9eN/5H+pigDXek5j1bx3FuvWFgZkrpZbMFRZWM/EP2zG3g+k3MczyJ8a2Qpts24hq9fbaY2zShoYW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766019032; c=relaxed/simple;
	bh=sR8Fo0TrtjFimjXE8D9VpLl8lg94CcGaxoNzY1fHccw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RC9eg7UuLLElrvKyDqywBqASd5LLnYV63GJYwGMxgOm2wtk+RVHiecJ/oSvXoWYXKOz+GTsRa4P0Y1Bat34B83YZ2omjKfopAUd0M9myNz856FeHS/OOCWsAfjLjUeMimhQMNf2DJyqkj+PYn6pP/dZORa02uKhMlUKQdqa1huQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBRbAgva; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0834769f0so696125ad.2
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 16:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766019030; x=1766623830; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TO4bldqvAZgUyF1R1COWtqCBDgiUqOhIeZ63l7KXOwI=;
        b=nBRbAgvaSQggeMsBDcSUWAA7Hjpy4SXeWpoGolSAq3PhhSx9K3Qm6xHOjob7Km69M9
         7NDfSEfWak7EW/xafbe9x3GT+uwLxlAQz7gbUAJOJI9ExUa7m8TvcgHwWyR2PjTKPolJ
         gMFoiEFMCeEuWFkXdTqy6qGqJRUFGlmW8KwzKE9zEhVxkDP4YuJT9N5Qyyg2E+r/mPI/
         NoO0Mqah+ygblWksurOkiA7IMoemf1LhPSR2V8lM3mUj0sAgntkGN/Not2Cew7MvosTM
         ZhM6i7HtCIGjtezy2a8C2E998eTWGjCpPF5cEi5eTSONfvRJy9Ih6YLi/zEbiMhLC34l
         1A4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766019030; x=1766623830;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TO4bldqvAZgUyF1R1COWtqCBDgiUqOhIeZ63l7KXOwI=;
        b=meR5lsCuoFbAhnB20t5sWvMSDGJMEsGhYy0d+vEiI0N0mB7PBAw9KuqDNjvDUdVMMp
         F8q3nX9pAJ6fly1W5rouZRyS6zed00jdwtYA9aX8IXtBsaar7nTqSljtaOLGH+nIGYjg
         zjXXfrIGiqQ5DmOnMz08yovfyXe51/XCKRKfWlG9G2y+dbKPR8hgEUMzeBxw0noFrY6G
         J/HlTZDcGTDifcsNbDgXRbDTHwJFUqGvzN6yUMsrRAdjRg1rIbmLhwyBWW6z/mE5RLoe
         ef5krHhn6R3wk3VBGthg4xUgNrleJiKyXKbybgG18YF9jc5U0NzPqkpoROFteIU2ZCQK
         PJZA==
X-Forwarded-Encrypted: i=1; AJvYcCVskObTdwj9Q/9xGUWK4uaklLR+KG0JGN1/IyFSKHUxjFPlDcKovDizOKk8OxdH+AoSFAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFRXfe1CS51a6BGEHzUSxz/S8ezkdKjYUAlj7fjvBpysQ9nlR2
	z4OfU+x9DMmJ99uQq2O/rPWL1mL+xHsh07CzywTUUkjCm/vob7mu3Gr5
X-Gm-Gg: AY/fxX7/ea1fG/MqzMGE3oU1VaNgPdoDyZrPlsaZSKssI+O25L8z2XB8iH4zxkUrCl9
	nh/6S0Dr1MKwpie+rLVdehBvKmE6rTxBrfp151TO1sdE3g4bzj70IwryFdtZK9L4I9mZT+9a3Wl
	Z8ZP3xfJOo+mgqs6KlwEHXTDDfQ9GL4101OOk05d8xcxzQhkUhyIfUdcgace3cq0eSfNUSSLgQ5
	wzPQfvO18Tk1Oop31+j2YqdM1yMtO8rKNXcUp5pRU7S2b1nJnt/NVgMgJumyoIvB252e11kW3RE
	RzEoLQUkOy0ZnnTwSPuGT0um54I2we/2oKjJf7Z105fazEYvlas/bIhkns+HAg3BepsNvemuRbu
	VBN9KVAsV3I9KmQKzeWCnK7Mh3DUSii9KAh/oI9+tnOeBJlJUd33eHDNtGCKhQVKh+Lyl605xzd
	0nnaeAHJhAn96PhBoTX5zi9BC97zqLYuz4v605
X-Google-Smtp-Source: AGHT+IGCpoGtHY2B5gj6LXqUoga5R2dUsHWWXSCy0lSpoaZ9+S/bEVisGuQPbWF4WHVftlFITIqf6w==
X-Received: by 2002:a05:7022:3b8a:b0:11b:9b9f:4283 with SMTP id a92af1059eb24-11f34bf8ba3mr16743123c88.24.1766019029819;
        Wed, 17 Dec 2025 16:50:29 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:9f95:2f12:bb69:e3e6? ([2620:10d:c090:500::7:a4ff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12061fceec2sm2819930c88.13.2025.12.17.16.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 16:50:29 -0800 (PST)
Message-ID: <de69362d96c6ec09480500607f9dcf4ff1003739.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add option to force-anonymize
 nested structs for BTF dump
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire	
 <alan.maguire@oracle.com>, Quentin Monnet <qmo@kernel.org>, Andrii Nakryiko
	 <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann	
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu	
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, bpf	 <bpf@vger.kernel.org>
Date: Wed, 17 Dec 2025 16:50:27 -0800
In-Reply-To: <CAADnVQKN7ijzWA6JdSMi_XecPfvjtCKRo9nNZv5LTKq9FO973Q@mail.gmail.com>
References: <20251216171854.2291424-1-alan.maguire@oracle.com>
	 <20251216171854.2291424-2-alan.maguire@oracle.com>
	 <d5a578c01f8a2d4d95ca16e0a9ee5b9bfce1c30e.camel@gmail.com>
	 <9a096b2a16d552031a12f3f4f5a2c725212df5e6.camel@gmail.com>
	 <b535b47a-519e-4138-861b-c16ed7fa0bcd@oracle.com>
	 <CAADnVQ+EyYO+aOZewNQwETr5rphOCp6jJQH_fw9GqjVFdQd19A@mail.gmail.com>
	 <CAEf4BzbWZtRdKCGwhjRV9MOufTC-coWFSU5sRtk4gdm9S_bg+w@mail.gmail.com>
	 <6ae6dfd8-3f73-4318-93c1-97541d267a28@oracle.com>
	 <CAADnVQ+wNPbbA0e4+6kx+LtOH=09jJyiYcEKZfc8kt6UPnq=EQ@mail.gmail.com>
	 <535846f7-4cc7-4b12-aab4-52e530d04706@oracle.com>
	 <ae6c6e50b3176d4ee4cce4cda09807a05d103fbf.camel@gmail.com>
	 <3071012cc1e8d6bdf16b13d371a12cb201c502a7.camel@gmail.com>
	 <b65fd7dc-fbad-4a96-8eb8-f36f8f518d44@oracle.com>
	 <CAEf4Bzb+3cryZAEwC_O7xgm3=cthZU-SNsUWfGH8OpSwc+3vaw@mail.gmail.com>
	 <CAADnVQJ1V1vwPVnhyE4OfOSQt_BnB3wRW9g9_bhkdu-QZyuQkQ@mail.gmail.com>
	 <5022ccaf5591e5bb88fe3d7a08dbb3c4fb6c3132.camel@gmail.com>
	 <aeeae7e13ce401726ddce756268c0686d30eb3a9.camel@gmail.com>
	 <CAADnVQL=2m9NHjr0zbMoDyha=6sBFd69=1QRdxSCKYhEONTmaw@mail.gmail.com>
	 <4d3972ec6951b3c02f79def0215e5bb4fc70aba4.camel@gmail.com>
	 <CAADnVQKN7ijzWA6JdSMi_XecPfvjtCKRo9nNZv5LTKq9FO973Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-17 at 16:39 -0800, Alexei Starovoitov wrote:
> On Wed, Dec 17, 2025 at 4:19=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Wed, 2025-12-17 at 15:34 -0800, Alexei Starovoitov wrote:
> > > On Wed, Dec 17, 2025 at 2:47=E2=80=AFPM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> > > >=20
> > > > >   $ cat ms-ext-test2.c
> > > > >   struct foo {
> > > > >     int a;
> > > > >   } __attribute__((preserve_access_index));
> > > > >=20
> > > > >   struct bar {
> > > > >     struct foo;
> > > > >   } __attribute__((preserve_access_index));
> > > > >=20
> > > > >   int buz(struct bar *bar) {
> > > > >     return bar->a;
> > > > >   }
> > > > >=20
> > > > >   $ clang -O2 -g -fms-extensions --target=3Dbpf -c ms-ext-test2.c
> > > > >   ms-ext-test2.c:6:3: warning: anonymous structs are a Microsoft =
extension [-Wmicrosoft-anon-tag]
> > > > >       6 |   struct foo;
> > > > >         |   ^~~~~~~~~~
> > > > >   1 warning generated.
> > > > >=20
> > > > >   $ llvm-objdump -Sdr ms-ext-test2.o
> > > > >=20
> > > > >   ms-ext-test2.o: file format elf64-bpf
> > > > >=20
> > > > >   Disassembly of section .text:
> > > > >=20
> > > > >   0000000000000000 <buz>:
> > > > >   ;   return bar->a;
> > > > >          0:       61 10 00 00 00 00 00 00 w0 =3D *(u32 *)(r1 + 0x=
0)
> > > > >                   0000000000000000:  CO-RE <byte_off> [2] struct =
bar::<anon 0>.a (0:0:0)
> > > > >          1:       95 00 00 00 00 00 00 00 exit
> > > > >=20
> > > > > Note the "<anon 0>" in the relocation.
> > > > > It appears that we loose no information if structures are unrolle=
d.
> > >=20
> > > Forgot to mention the CORE concern earlier...
> > > Does the above work with current logic in relo_core.c ?
> > > If not, we should definitely unconditionally unroll
> > > to avoid fixing CORE.
> >=20
> > I think there might be an issue with CO-RE.
> > Here is an example:
> >=20
> >   struct foo {
> >     int a;
> >   } __attribute__((preserve_access_index));
> >=20
> >   struct bar {
> >   #ifdef USE_MS
> >     struct foo;
> >   #else
> >     struct { int a; };
> >   #endif
> >   } __attribute__((preserve_access_index));
> >=20
> >   int buz(struct bar *bar) {
> >     return bar->a;
> >   }
> >=20
> > Here is what I get with USE_MS:
> >=20
> >   $ llvm-objdump -Sdr ms-ext-test2.o
> >=20
> >   ms-ext-test2.o: file format elf64-bpf
> >=20
> >   Disassembly of section .text:
> >=20
> >   0000000000000000 <buz>:
> >   ;   return bar->a;
> >          0:       61 10 00 00 00 00 00 00 w0 =3D *(u32 *)(r1 + 0x0)
> >                   0000000000000000:  CO-RE <byte_off> [2] struct bar::<=
anon 0>.a (0:0:0)
> >          1:       95 00 00 00 00 00 00 00 exit
> >=20
> >   $ bpftool btf dump file ms-ext-test2.o
> >   [1] PTR '(anon)' type_id=3D2
> >   [2] STRUCT 'bar' size=3D4 vlen=3D1
> >           '(anon)' type_id=3D3 bits_offset=3D0
> >   [3] STRUCT 'foo' size=3D4 vlen=3D1
> >           'a' type_id=3D4 bits_offset=3D0
> >   [4] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
> >   [5] FUNC_PROTO '(anon)' ret_type_id=3D4 vlen=3D1
> >           'bar' type_id=3D1
> >   [6] FUNC 'buz' type_id=3D5 linkage=3Dglobal
> >=20
> > And here is without USE_MS:
> >=20
> >   $ llvm-objdump -Sdr ms-ext-test2.o
> >=20
> >   ms-ext-test2.o: file format elf64-bpf
> >=20
> >   Disassembly of section .text:
> >=20
> >   0000000000000000 <buz>:
> >   ;   return bar->a;
> >          0:       61 10 00 00 00 00 00 00 w0 =3D *(u32 *)(r1 + 0x0)
> >                   0000000000000000:  CO-RE <byte_off> [2] struct bar::<=
anon 0>.a (0:0:0)
> >          1:       95 00 00 00 00 00 00 00 exit
> >=20
> >   $ bpftool btf dump file ms-ext-test2.o
> >   [1] PTR '(anon)' type_id=3D2
> >   [2] STRUCT 'bar' size=3D4 vlen=3D1
> >           '(anon)' type_id=3D3 bits_offset=3D0
> >   [3] STRUCT '(anon)' size=3D4 vlen=3D1
> >           'a' type_id=3D4 bits_offset=3D0
> >   [4] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
> >   [5] FUNC_PROTO '(anon)' ret_type_id=3D4 vlen=3D1
> >           'bar' type_id=3D1
> >   [6] FUNC 'buz' type_id=3D5 linkage=3Dglobal
> >=20
> > So, with USE_MS the relocation captures the offset inside 'struct foo'.
> > And this is important for CO-RE offsets resolution.
> > So unrolling structures is actually a problem.
>=20
> Sounds like we should silence the warning the way Song proposed and
> tell all users to add -fms-extension to their builds.

Sounds like it.

