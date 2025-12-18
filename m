Return-Path: <bpf+bounces-76936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7457CC9E08
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 01:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C10430204B4
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 00:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827A420299B;
	Thu, 18 Dec 2025 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxErq4K8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BE81F419A
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 00:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766017177; cv=none; b=Y41rNVoypLPFYcK/pWGOalEfk7WzXZ1n1BHCluuRqP4YhD158vkuKKpYOg5aFVgJiPkoafmVI2oY8wI3AYgVavDllZlkxIPny/G7tOFxPVVCw9nkOAk72IPxjU6QoFnjyvmSr69tJ5FYDlbZPyVZfE+uOMwj0Xo7rrC6Cb5Q750=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766017177; c=relaxed/simple;
	bh=NYtJj7MACEwQVNSg6WLxMS5r3csFS2IpS4/WAZ4dSWs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gy3sOlGuv4Rm5EzRhDvYemEmGlvbwDlzyepZrtuAG9YU7dBCPOKDb7Uuipnlmdp26eQ4rinC/oL3ie9VFTf7ZluDQHtJEZZnOtNOvTxCngrxBY22RM9oq9Krk3N7JzqScDyUOUkZE1Ct4f6Sei7b06RP7GCW5ADc+A/LF8CXDU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxErq4K8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a07fac8aa1so677925ad.1
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 16:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766017175; x=1766621975; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z8TnZPTnmlyiVYaZILuzu0ATjWmWudqQFT7szM4c45U=;
        b=hxErq4K8zRkc4FahVdbYvh74k9ICJXIYJJC5pCniJQykIGnCwlmRdLbbgc+0oJJD6l
         A1sD0YDXY60iieFJYkdRWA/tNwZHZFwC6WnI8CV7CPQCz/ayTmJRt34y8z1m2tL97Viv
         +2z8fc5pW0TPhRcxvk1O12nPIeg3Sc/TVSuqatlsk2hkmwOWW2/NtPWzwXtgY099cDWL
         lCRulOM8I857CLewLYALJySETbJctR8O+23yTE3TMfqS8R4Cv0WvCzX3yd6GqxrxaO1M
         YUtNZm7NCEGlTryg+RG+rTAuxSDMPbtdI5rLB6Mi9LFu5Bi9LxQPTWQhp8jNdj68ngx6
         x49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766017175; x=1766621975;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8TnZPTnmlyiVYaZILuzu0ATjWmWudqQFT7szM4c45U=;
        b=LyCG/F50CSCERfYnpSRN4q/aLw6yFF0hlrXii27k6ZBoM7FO5CQqxIhkBnoE7rBQK4
         byYDre6O0BEVoxZBVPaqLOuzfBj9RSwELOtZyTcVtaM10vjv5lY1EniyBvMfAlzQftaS
         M2QRyvNOiDgyOgzbRm/CKnQE8CD4EwRIJntBPH6gOcd2DJXH7/UbN6StaaTeEnTeI9bM
         OiB1/DgD3TZ/coF5I9WgLJaxpSKWQBUNW6dygcll11dtFyvZmh4kGB+oKr9QDj6s0GtI
         6v+yvlRdYZAIC0A5oc1kelSdTjvx1Wtu4PQV0yvx0h5hWCMZZzeST/44kYgXMlH6QCDQ
         uyzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtZOyo5OMh2OFmFvEPAbP47LblXONDHngVxIs68Tm783oyMmpwdQYjDlVeFVK88MH0cfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLAraubQn5XxRCkSMYp7vPysUTf72UfE7dv2ukZRLO8xpdgVDj
	Bssev/BVaISRsSjK3HRfhUTbJnCH3vRlzaIIlbJ7n0zALiUyG7FtNLru
X-Gm-Gg: AY/fxX4AuOa/ScN5RmscUo4sG9U3n1xDVHD3aK97z4it93u0vYPaq6yokr5ZdWoGrtp
	Hyqe8tL4yl+NK+7vcR9LrPXFNgJNar1LZ5E9vVwqCXiGei2FM1EQmdAeA3xT21tFUC0q7QlBJS6
	ghFLqR+Fi9BHAEefZ0WlRSacFX9Sf6y/boKZovK3CHZYgTyO8fYbijjOIlitAD8F1oFO56B+8yA
	Vvvjaj7iUUiWsiWF8ADQgvkq5PyAxYNfNJgD6V8aiK4XHs4hLe9rTkN13Ec3XyHvopAD54ZL3Mb
	7FC6AieOIKQml9Can/gmIMcdTx9uMsWVzVTPzbUkEuVkX7lQo0tRPWkLsR3H863wab00HwOYskO
	9TOaTFltpMIOrBC8zA405Moo7CAUCOQ0niMtVWghJYki64GSDJ4t1Rx2FLuyO9yl4zDGCAVG1LK
	z06llSoS9zzAPO/WbCRARZyL74SLko50aprhg5
X-Google-Smtp-Source: AGHT+IEbgUHsWBbueeIVC5f6VDsD+QcBoXONMKT14s6HZ0vMEY8vlFlNa21OSLLj09rO0ft9XId2hw==
X-Received: by 2002:a05:7022:1702:b0:11e:3e9:3e8c with SMTP id a92af1059eb24-11f34c7180emr10889720c88.49.1766017174189;
        Wed, 17 Dec 2025 16:19:34 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:9f95:2f12:bb69:e3e6? ([2620:10d:c090:500::7:a4ff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12061f58ba0sm2648129c88.8.2025.12.17.16.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 16:19:33 -0800 (PST)
Message-ID: <4d3972ec6951b3c02f79def0215e5bb4fc70aba4.camel@gmail.com>
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
Date: Wed, 17 Dec 2025 16:19:31 -0800
In-Reply-To: <CAADnVQL=2m9NHjr0zbMoDyha=6sBFd69=1QRdxSCKYhEONTmaw@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-17 at 15:34 -0800, Alexei Starovoitov wrote:
> On Wed, Dec 17, 2025 at 2:47=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > >   $ cat ms-ext-test2.c
> > >   struct foo {
> > >     int a;
> > >   } __attribute__((preserve_access_index));
> > >
> > >   struct bar {
> > >     struct foo;
> > >   } __attribute__((preserve_access_index));
> > >
> > >   int buz(struct bar *bar) {
> > >     return bar->a;
> > >   }
> > >
> > >   $ clang -O2 -g -fms-extensions --target=3Dbpf -c ms-ext-test2.c
> > >   ms-ext-test2.c:6:3: warning: anonymous structs are a Microsoft exte=
nsion [-Wmicrosoft-anon-tag]
> > >       6 |   struct foo;
> > >         |   ^~~~~~~~~~
> > >   1 warning generated.
> > >
> > >   $ llvm-objdump -Sdr ms-ext-test2.o
> > >
> > >   ms-ext-test2.o: file format elf64-bpf
> > >
> > >   Disassembly of section .text:
> > >
> > >   0000000000000000 <buz>:
> > >   ;   return bar->a;
> > >          0:       61 10 00 00 00 00 00 00 w0 =3D *(u32 *)(r1 + 0x0)
> > >                   0000000000000000:  CO-RE <byte_off> [2] struct bar:=
:<anon 0>.a (0:0:0)
> > >          1:       95 00 00 00 00 00 00 00 exit
> > >
> > > Note the "<anon 0>" in the relocation.
> > > It appears that we loose no information if structures are unrolled.
>
> Forgot to mention the CORE concern earlier...
> Does the above work with current logic in relo_core.c ?
> If not, we should definitely unconditionally unroll
> to avoid fixing CORE.

I think there might be an issue with CO-RE.
Here is an example:

  struct foo {
    int a;
  } __attribute__((preserve_access_index));

  struct bar {
  #ifdef USE_MS
    struct foo;
  #else
    struct { int a; };
  #endif
  } __attribute__((preserve_access_index));

  int buz(struct bar *bar) {
    return bar->a;
  }

Here is what I get with USE_MS:

  $ llvm-objdump -Sdr ms-ext-test2.o

  ms-ext-test2.o: file format elf64-bpf

  Disassembly of section .text:

  0000000000000000 <buz>:
  ;   return bar->a;
         0:       61 10 00 00 00 00 00 00 w0 =3D *(u32 *)(r1 + 0x0)
                  0000000000000000:  CO-RE <byte_off> [2] struct bar::<anon=
 0>.a (0:0:0)
         1:       95 00 00 00 00 00 00 00 exit

  $ bpftool btf dump file ms-ext-test2.o
  [1] PTR '(anon)' type_id=3D2
  [2] STRUCT 'bar' size=3D4 vlen=3D1
          '(anon)' type_id=3D3 bits_offset=3D0
  [3] STRUCT 'foo' size=3D4 vlen=3D1
          'a' type_id=3D4 bits_offset=3D0
  [4] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
  [5] FUNC_PROTO '(anon)' ret_type_id=3D4 vlen=3D1
          'bar' type_id=3D1
  [6] FUNC 'buz' type_id=3D5 linkage=3Dglobal

And here is without USE_MS:

  $ llvm-objdump -Sdr ms-ext-test2.o

  ms-ext-test2.o: file format elf64-bpf

  Disassembly of section .text:

  0000000000000000 <buz>:
  ;   return bar->a;
         0:       61 10 00 00 00 00 00 00 w0 =3D *(u32 *)(r1 + 0x0)
                  0000000000000000:  CO-RE <byte_off> [2] struct bar::<anon=
 0>.a (0:0:0)
         1:       95 00 00 00 00 00 00 00 exit

  $ bpftool btf dump file ms-ext-test2.o
  [1] PTR '(anon)' type_id=3D2
  [2] STRUCT 'bar' size=3D4 vlen=3D1
          '(anon)' type_id=3D3 bits_offset=3D0
  [3] STRUCT '(anon)' size=3D4 vlen=3D1
          'a' type_id=3D4 bits_offset=3D0
  [4] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
  [5] FUNC_PROTO '(anon)' ret_type_id=3D4 vlen=3D1
          'bar' type_id=3D1
  [6] FUNC 'buz' type_id=3D5 linkage=3Dglobal

So, with USE_MS the relocation captures the offset inside 'struct foo'.
And this is important for CO-RE offsets resolution.
So unrolling structures is actually a problem.

