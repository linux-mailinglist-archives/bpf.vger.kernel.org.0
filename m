Return-Path: <bpf+bounces-69943-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6B0BA8DEE
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 12:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4ED43B742A
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 10:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE462FB978;
	Mon, 29 Sep 2025 10:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsK3VsXb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE892FB963
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759141254; cv=none; b=qUa8JVte9+OI4JH54DXsIz7mj+GpPoCjMDN4j+44MvZCqVSm/zFuGWJYg4TZM4TiLVmzVbQJbjYPXs8Eiu8OCuNdrQL/7IOmUw5IVswH3cxwhUoRKfDI3NrJpfxEySHYm5jMXptCDPN+zNmt3r9iGOox//94XG2pVVL8/30gw9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759141254; c=relaxed/simple;
	bh=NqbO2fW3IzBaRd5vj5jPQUnlRGc4DRwwaAiqwsgxWQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nc0FONYx61rfqz2GSfIPn508EXuswdeGC8/tEXArZEDwitG4YgZqpp2hd4K0a+GiraIHGr/dxO7Sj0wHQvnyT+ur9d4SHpSwmAmnhmbua725+crN+Uwg4WYD9lnqObjB00j3VFwG1Smasj1Jd5YsVW5r7CMdH/ubf4bXz0YK0TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsK3VsXb; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-414f48bd785so2216263f8f.1
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 03:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759141250; x=1759746050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8K9+u/3NSk+4oSXrn7Rl/uRQZvAMBBF5y8XURaOpiQ=;
        b=GsK3VsXb1/Rjlkzgd1gVZUM4ajyNDG6bJuEt5hDdNAplNQ8NIPvRAWZUrqjPjLj+zr
         RQs9XfL8+pVDq5XbOQ+jJjTVd/Eojx/A6YdaEEYN60J4yOz14PlcgcR6XumUtLzJJTjt
         CMkYHvBPYVl/eNvlVp9XJ73yvgQoarr6onfYR0+0Hb1WI3JvtYB5KjfVcoRn7JPJM0be
         WL2qsDJynCorZyD+wk0jfiMmj9ucLbyVSo/2WB8I8v0QhtPvfIIy0vmDH/0WIRjn2b9k
         crIiTqtomfUQokglhIE67YHNI+qOVhZAkys8lqm3EqLtQtYR7KekYBr9JhxpCv9r+TdN
         Qt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759141250; x=1759746050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8K9+u/3NSk+4oSXrn7Rl/uRQZvAMBBF5y8XURaOpiQ=;
        b=YrabpBKIc38lqJ0uiG6vjdmZSm5j4f1jAL+dM5/hB7uydYrSWBPGsInBmHk/G6qsqP
         CWk8Y/LwEk8t+1Jtp9+irRlA2j5KTwHvpsEaBn9hJMJdvLpW78jnz0w+/KyfsO3n4KIT
         ix6tFRleEsGAs0HNaUCz9cR/DU5mTtQZjve/46RqYMGlD/oUeZGFn2uYyPdNpE1yeDz/
         qmny0G8dTDptt7ECvs477V5ERMKUqdYoh+S1Fee9K9U+ZNPvd3OTxlyyuvWNxm9m8Psw
         vSo2JKBEh2nxN5+JezeIqaEk+vVDrr3ZhDfH6jveBiZsTIJRQG5eAqUOJinyLs2yae9M
         RyfA==
X-Forwarded-Encrypted: i=1; AJvYcCU90K+DBGPRDDw/JowPo9/FZVqV1mqRYMJ/wpxRPG8iH2hmWqzxxtCxgdEWIAIV9XNyYnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFO1t4gTE/nRl1aksL8CKei34ASYHClai8aXt2yyLt79FKJGrW
	R5YQh9oR78C5UhCd4dxbBX7LIeNDO7FGKcBvqLhxFaHgt8YwdGe/FNC6JjQU3qaITIuCD5Lib4M
	MZtPX1pJOdyov25nLYpCdYkOSp6wJZTM=
X-Gm-Gg: ASbGncv4XFHbEYOqhreh/QGUUblpJa2xm1o+4nklkwxsVCmbXzFD+b8M9x7tR8FoZP2
	ipd9l6m8EN0WK3uGLgUPNOs9dkLZuF4TDVsd1aS03UL/UvQh6345YxmG1VrE4RgEHLa9KLgBaIg
	A5z5PmJ4Ik+WLhR/M5YoBZgQFRePMJTV/6avSf1/CHSenaHa4uGFv/UVUcZZPtty7B/0j7zK00w
	t5+Zrv14u5QZ3Za
X-Google-Smtp-Source: AGHT+IF4EsFb57HZmYQn8PcRkIfQLTQLwGRjLecA8K81Z3M0EnPzYRWKqn44S8LuqiLH/X5e8Gl3tCUcu0baVQteKdc=
X-Received: by 2002:a05:6000:2285:b0:3ed:e1d8:bd72 with SMTP id
 ffacd0b85a97d-40e4364289amr14744217f8f.17.1759141250166; Mon, 29 Sep 2025
 03:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921132503.9384-1-mejedi@gmail.com> <20250921132503.9384-2-mejedi@gmail.com>
 <fccfa1f1-75a6-4094-9389-7e01b20833b2@kernel.org> <3EB389B2-437D-40AF-8D6A-9332795C0587@gmail.com>
 <0140f268-7590-4cb8-84a6-67972e2bd28e@kernel.org>
In-Reply-To: <0140f268-7590-4cb8-84a6-67972e2bd28e@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 29 Sep 2025 11:20:38 +0100
X-Gm-Features: AS18NWDM6Vqdi9w5_xRbppswUXBnmdyRE1WBRNZv7CQxkEMpkqv0nvn9423qbmc
Message-ID: <CAADnVQKi4oSvF9VQn1enU4=Ew6r_SiSSFJ8QLSFitPR==mPnjg@mail.gmail.com>
Subject: Re: [PATCH 1/1] bpftool: Formatting defined by user:fmt: decl tag
To: Quentin Monnet <qmo@kernel.org>
Cc: Nick Zavaritsky <mejedi@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 10:49=E2=80=AFAM Quentin Monnet <qmo@kernel.org> wr=
ote:
>
> 2025-09-25 13:11 UTC+0200 ~ Nick Zavaritsky <mejedi@gmail.com>
> >
> >
> >> On 23. Sep 2025, at 13:22, Quentin Monnet <qmo@kernel.org> wrote:
> >>
> >> Note: For future submissions please make sure to add the maintainers i=
n
> >> copy for your message, "./scripts/get_maintainer.pl tools/bpf/bpftool/=
"
> >> will give you the list.
> >>
> >>
> >> 2025-09-21 13:24 UTC+0000 ~ Nick Zavaritsky <mejedi@gmail.com>
> >>> Certain data types get exceptionally unwieldy when formatted by bpfto=
ol,
> >>> e.g. IP6 addresses.
> >>>
> >>> Introduce custom formatting in bpftool driven by user:fmt: decl tag.
> >>> When a type is tagged user:fmt:ip, the value is formatted as IP4 or I=
P6
> >>> address depending on the value size.
> >>>
> >>> When a type is tagged user:fmt:be, the value is interpreted as a
> >>> big-endian integer (2, 4 or 8 bytes).
> >>
> >>
> >> Hi, thanks for this!
> >>
> >> I'm not sure I understand correctly. The 'user:fmt:*' tags are not use=
d
> >> yet, correct? So you're proposing to add it to existing code to get a
> >> fancier bpftool output. Do you mean adding it to your own executables?
> >> Or to existing kernel structures/types?
> >
> > I don=E2=80=99t intend to touch existing kernel types. This feature tar=
gets ebpf
> > projects that wish to make it easier for humans to process bpftool dump=
s
> > of their maps.
> >
> > By having it in bpftool, we eliminate the need for custom post
> > processing. Bpftool can =E2=80=9Cmake it easier for humans=E2=80=9D mor=
e reliably since
> > it has access to BTF (and tags). It is hard to write a generic post
> > processor that improves the presentation of e.g. IP addresses.
> > Pattern-matching will work for IPv6 addresses. For ports and IPv4
> > addresses not so much, unless wrapper structures are introduced (e.g.
> > struct{__be32 ip4addr;}). Wrapper structures will make ebpf code using
> > them look funny.
> >
> > How can this feature get discovered? Having annotated types declared in
> > bpftool headers will surely help.
>
>
> Yes, discoverability is one of my main concerns here. I'm not convinced
> it's a good idea to introduce a new convention for tags just for
> bpftool. If this gets adopted, this should be documented at a larger
> scale for other tooling to pick it up, too; and the defined formats
> should probably not be proper to bpftool. What "bpftool headers" are you
> talking about, exactly?
>
> (My other concern would be security and the risk of obfuscating map
> contents from bpftool dumps, but given that formatting strings are
> defined in bpftool - not in user programs - and you have checks on
> lengths to associate format strings to pieces of data, I think we're
> good and I don't see a way for users to exploit this and hide some bytes
> from the formatted output.)

I share these concerns.

Instead of introducing a new tag convention can we teach bpftool
to pretty print fields when their type is uapi struct?
Like, instead of adding:
typedef struct in6_addr bpf_in6_addr
    __attribute__((__btf_decl_tag__("user:fmt:ip")));
bpf_in6_addr in6;

just use "typedef struct in6_addr foo; foo in6;" or "struct in6_addr in6;"
to define a field in a map and bpftool can print it as an ipv6 address?
in6_addr semantics is fixed.
So we can pretty print it and similar structs.
Probably with an additional command line flag
to keep backward compat by default.

