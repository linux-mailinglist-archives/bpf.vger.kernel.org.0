Return-Path: <bpf+bounces-62575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 457D6AFBEDA
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02CC1AA59FD
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 00:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B15E3C01;
	Tue,  8 Jul 2025 00:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQCWtX/N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AB3801
	for <bpf@vger.kernel.org>; Tue,  8 Jul 2025 00:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751932914; cv=none; b=q+DiCRUkADuAtsxY0KgKNcom9CwBUa3KCtmh6L4GlpUJ3Kb2znO65JEAh9XTsSTKc48yTzQLarbLtFG+MaicsF3T450yYFe0aqzyv8GkKhPy79HtmfIo4ZApLESYQEJ43TCp6agf6/yiCy7wY3qgDRh+6uvEZMEzBYirPXGQTAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751932914; c=relaxed/simple;
	bh=JxCd76S0YQHzlPKl4q4KG1fkVQZQvcBGvcPhTlZeRxs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T80gnphQPDRYSS02YQaNUH32MYPGrXFcnoMHLx1ucxE3H2BFtNmxUyRDeT22HEJS7n0QnD/olfFwjSZJOMjdBn4qC1cu06BHK2oZsceEdp7FO0yD6hF5SYtJzMVigQKZNjZmqsBBPF+Y0sNqLU2JDXV0vZdONsUymWcDR9+tjYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQCWtX/N; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b31e076f714so3903098a12.0
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 17:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751932912; x=1752537712; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rmhiBNJzr1KlLo3rJbMJgu8OEJr8JsUUFNdKtCq4MsI=;
        b=NQCWtX/Nn/4Yc5AnHO3NShSIgfNB6U+eZYE1ElPTGJyKpTIQMciOyczIU6gsNGHhto
         2b7xSUzeNR8STnNiIfnS+/ZPt54VADE208HnbXJtwWL2F2VYc0fOw3mkCDtmJy1ocURk
         fGlrDSR85UZDonHi6w8bTMaqIq0tLnwU0Waa52Lldgd45px7z9pv9N+pyOosZS0Hh11C
         O/Ti6UeDGplJdFbV316iMs8tVIRlUmeRXK5aVjYoqZekCKACkgepEOcW9kIlFvfA83Hv
         Dkbwguas3ux+WDJ+OFe8tYn4HIbN8CTf7U8rg5bMwipXUBwN88XJc+4qT0rIrrimUG2w
         7xNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751932912; x=1752537712;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rmhiBNJzr1KlLo3rJbMJgu8OEJr8JsUUFNdKtCq4MsI=;
        b=tq97Ez6tjsIKn/NOEa9EbRmCE9xr4r6f9nC9Js6F3wPQbnTFbJZGjxG+inaIPOZpq2
         +MKY4283Ce5DJ6SUD8ADFq0n5ECyUH7ogSNXMbWNiZjIFOkPMFTKVacBlhAFPrxKIwhv
         l1EpfdE9gPGV327ZOkQZ4569gZKvjChtcS3eJkmEt4HoUkeiJIsaPHyYCeneTAuszJMn
         mK3NfwvaMm206cmABtjiqKNxSd3RnQa2bSve1EoZtxKUwqhEOO5m29nwA+X3SjDzAU0A
         Xb7gj98Pl1j7jjLbC0JYGLiuxw0/Y5cxYN698vmmsjFMNo61Y2u+Jp5Ul4zcD5oTIUmG
         rOhw==
X-Forwarded-Encrypted: i=1; AJvYcCVtdHahjOTuSR2GckBfKb7Avxlv9BU3rr8j4dUNNhSJv7jb9+AsGGn9u4FofEJzOuoT5WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfYA3k8GdSu03LstZx00VzDRg7+06aUGNauw4W7895mfGw4BZm
	efkv9Ff3Snx5r51pDj/KmUrJaX8yzTAXZ9oN07UitiWh+j70nTMyR7J4
X-Gm-Gg: ASbGncvEnt1JMMFFBweC6i746m/OrwJHS0r6BqZKmd749/MeVLIuh7Yjbp2i6lY0kee
	T+IiHXVKDKDf1OTuX83jvza3i//9XPaQ3CHlGAZ9h3wK+Hywqqo4dY4906FqI5tIYwkWzSmodoS
	ujqhDejYOgphj9TwAkNaG5zZNgkUAEdEA+RJJ7rmpgOJinM3/esP2JyyHw/KnFN8DYpo1Y1rnce
	1VuwV0QAlFJVyyk+kOXrvH4z2LXWo3OrNEa1rExm1ljdws8cY1jHHdNXKjGqxfIJUwUrh6zjDUN
	CRzpVP8NizQAplJcYlnp3aeEDOOxtIZVQnkC0DfuBETwSCbb6FgRBPx9GG9KLnRnHzk=
X-Google-Smtp-Source: AGHT+IExgaagyIg/kQ55r2r8Vgy7QmfBCKClXci5OYjnFEiu6oMYMnfUpIF1aNiMr/dlENfUjb+Nrg==
X-Received: by 2002:a17:90b:3c8f:b0:311:1617:5bc4 with SMTP id 98e67ed59e1d1-31c2274c1b7mr820170a91.12.1751932911899;
        Mon, 07 Jul 2025 17:01:51 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::647? ([2620:10d:c090:600::1:6ad])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c21d27f45sm510796a91.6.2025.07.07.17.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 17:01:51 -0700 (PDT)
Message-ID: <88c63c574dfd7d3845ac4e558643ab52e77f81dc.camel@gmail.com>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>, bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Anton Protopopov	 <aspsk@isovalent.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Quentin Monnet	 <qmo@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>
Date: Mon, 07 Jul 2025 17:01:50 -0700
In-Reply-To: <CAADnVQLaBuDYBoQvVtug63MJO+2=oqb9PYap8Jv+U8HB4ETe9Q@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
	 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
	 <CAADnVQKhVyh4WqjUgxYLZwn5VMY6hSMWyLoQPxt4TJG1812DcA@mail.gmail.com>
	 <aFLWaNSsV7M2gV98@mail.gmail.com>
	 <e726d778a3cf75e3ceec54f5f43b9d5d66ba5e97.camel@gmail.com>
	 <CAADnVQLaBuDYBoQvVtug63MJO+2=oqb9PYap8Jv+U8HB4ETe9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-07 at 16:49 -0700, Alexei Starovoitov wrote:
> On Mon, Jul 7, 2025 at 4:45=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Wed, 2025-06-18 at 15:08 +0000, Anton Protopopov wrote:
> > > On 25/06/17 08:22PM, Alexei Starovoitov wrote:
> > > > On Sun, Jun 15, 2025 at 1:55=E2=80=AFAM Anton Protopopov
> > > > <a.s.protopopov@gmail.com> wrote:
> > > > >=20
> > > > > The final line generates an indirect jump. The
> > > > > format of the indirect jump instruction supported by BPF is
> > > > >=20
> > > > >     BPF_JMP|BPF_X|BPF_JA, SRC=3D0, DST=3DRx, off=3D0, imm=3Dfd(M)
> > > > >=20
> > > > > and, obviously, the map M must be the same map which was used to
> > > > > init the register rX. This patch implements this in the following=
,
> > > > > hacky, but so far suitable for all existing use-cases, way. On
> > > > > encountering a `gotox` instruction libbpf tracks back to the
> > > > > previous direct load from map and stores this map file descriptor
> > > > > in the gotox instruction.
> > > >=20
> > > > ...

[...]

> > > >=20
> > > > This is obviously broken and cannot be made smarter in libbpf.
> > > > It won't be doing data flow analysis.
> > > >=20
> > > > The only option I see is to teach llvm to tag jmp_table in gotox.
> > > > Probably the simplest way is to add the same relo to gotox insn
> > > > as for ld_imm64. Then libbpf has a direct way to assign
> > > > the same map_fd into both ld_imm64 and gotox.
> > >=20
> > > This would be nice.
> >=20
> > I did not implement this is a change for jt section + jt symbols.
> > It can be added, but thinking about it again, are you sure it is
> > necessary to have map fd in the gotox?
> >=20
> > Verifier should be smart enough already to track what map the rX in
> > the `gotox rX` is a derivative of. It can make use of
> > bpf_insn_aux_data->map_index to enforce that only one map is used with
> > a particular gotox instruction.
>=20
> How would it associate gotox with map (set of IPs) at check_cfg() stage?
> llvm needs to help.

check_cfg(), right, thank you.
But still, this feels like an artificial limitation.
Just because we have a check_cfg() pass as a separate thing we need
this hint.

