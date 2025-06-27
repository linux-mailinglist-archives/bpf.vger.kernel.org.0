Return-Path: <bpf+bounces-61720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4A3AEACD1
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 04:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB37A565A45
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 02:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4555F18DB35;
	Fri, 27 Jun 2025 02:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+bkreYg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5171362
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750991322; cv=none; b=g9EJBfIcywhq+GMw7JNCZO+JsbES9VxSd4k7fHQ3IW1KyvZvZSEnsjcsXJZQaFAt/Ml2G5c96lcH6nwL+uDnch4MLThgzTSOXn3qKcdLzrJTUg3pJSkGItjs0u/qwpg9j7GvV4SPDMQEq2FXo3ocMuNz0uRe66sGFtBH45+n4Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750991322; c=relaxed/simple;
	bh=v2PigAy4qTQhetrQzTYMucimHm0NTWiYPpS6Gyp5wo8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=deqx5uFRvuGVT0p9+fibLfSmR3nqAlFrF+orZsvZMCrDuVsHlcm4CigJ3WblEM4tU+bD4OLVYQZT5DQIyr0BQ0kBCprGgSshLqazkDqi+mWzEy4CmG0rG69zhH5bfFcrjMxIT0SJs5wNdVECVYZhI3C2JAAh3nzGv1u82JJonUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+bkreYg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234b440afa7so19491965ad.0
        for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 19:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750991321; x=1751596121; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nav68CwimIl2QY6Y0Km446abdsOFkG5niGRl9qo8wek=;
        b=A+bkreYg1h36/MmMlA3igWeDC1eeENxwN5TeRsuMEd0s1185EsCrUwMfR/9hyr/Jfd
         si1ePnWcRfNUt3NSlR8PpPF1/mpOVXn0b4CPHruiDJ8zjnihMwdqthlXbhIDCBJI1etj
         UqGDpTxuvxAAptyuuqlxN4P1x7wH/T3ccTxlcI0o5/Wj3Sq3jE+CUjvRkn3w46fc1eal
         ov/AI9SH/JF86AcrpGHaV387KCMqKRf0BTfAVRESex65OaVBTwLQC+wivYoXq5GHEB+W
         3nPvR8fZZY2rbeD0W3bG94eH58YwQBPc+BArzj5af4s1tboj3usx8zzzdrkfC3sk72UG
         kQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750991321; x=1751596121;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nav68CwimIl2QY6Y0Km446abdsOFkG5niGRl9qo8wek=;
        b=fMJUIPkwyycCmEQ8HNxzvuFUHZagQZiRmfFeuoCH0ybOVJa3Hx4zQeOvvDPJ0/5tra
         Zz8fE3Rwxm+Yh54fxGMXP5W8TJ2Kh4t1t9w93iLE+GgvjK233WMH4N63arZbiD1TEJvk
         mdBcvgWEYHp0SwVltXf0FZ+E6leEWE2wmq0RDa+lQ9DgHpioORThwkhw/y1WTk97pg8N
         TBViQHX6qUM+yjZ2xBCnYqsXtPtP9bLb25w3bNleTBXA7FgdwQZYiJ7MkyTWivMQoucT
         VVg0CC+K6tec4rcAuMN2zxyaNGNADgTDbsN3e+FBQl0a+OaxyGpo239LHdgcTaZ49sJS
         zfhw==
X-Forwarded-Encrypted: i=1; AJvYcCXzwF6ZVdvYdk7S2oOjQwki7HAJ50XShq88Mq2yJcMHkMhNpSbGSekKoMxR1egKxP2M3Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLjgAHRj1R8u/xkPLpGoeeQ1gEw9wnkWKbcNlxmlAtusKm8t/i
	Z1kmxftpkQ++hqf0FjNICpPaMTMHRDhYoq81WsqJbL/+pP92YOqV3cYu
X-Gm-Gg: ASbGncsXd1aCZtJBvsq4iGckI7jzNoPyUSc1gvYAcv8miYsEpwDhar2G8R6q8aaxFAP
	z6ILoEEpb4saWExwxKjZj3PvlMEX4L5IknLxqfzjvFafm6hUh+W0z6hG08ENSW31QzcHlDZFyux
	ZPm2j9lDfeaUyrImGdz5hqb+19wU/NVsrjWJsKFjYfKOtScF0aUCxCWrhWCJ3sru2c5K/p9qDr4
	BOI1YIjuHGyltmsB/AVr1dcp/onzj7BuZSD/6ABwXxh1tjEVSkst4iOb7jZOoG9r48/zQZTNfna
	Z4nWgNXsf3Jdef+ss4mSCOWOOWyPAH7C4vO8LeVoKlSUWck9Z9m8nVpyE2Q=
X-Google-Smtp-Source: AGHT+IFwIha81vGvSoLqOSGeQ9KKXkuFTmzR/0DLyO2oxKJFsQYJARLr5r5kMFgDxAGD4zIIX5ORRQ==
X-Received: by 2002:a17:903:28c:b0:235:f1e4:3383 with SMTP id d9443c01a7336-23ac3bffb88mr22332095ad.7.1750991320644;
        Thu, 26 Jun 2025 19:28:40 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bf26sm3893905ad.107.2025.06.26.19.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 19:28:40 -0700 (PDT)
Message-ID: <f8bc4e5469e73b99943ff7783fbe4a7758bbbe32.camel@gmail.com>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Thu, 26 Jun 2025 19:28:38 -0700
In-Reply-To: <1c17cd755a3e8865ad06baad86d42e42e289439a.camel@gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
		 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
	 <1c17cd755a3e8865ad06baad86d42e42e289439a.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-18 at 12:49 -0700, Eduard Zingerman wrote:
> On Sun, 2025-06-15 at 08:59 +0000, Anton Protopopov wrote:
>=20
> [...]
>=20
> > @@ -698,6 +712,14 @@ struct bpf_object {
> >  	bool has_subcalls;
> >  	bool has_rodata;
> > =20
> > +	const void *rodata;
> > +	size_t rodata_size;
> > +	int rodata_map_fd;
>=20
> This is sort-of strange, that jump table metadata resides in one
> section, while jump section itself is in .rodata. Wouldn't it be
> simpler make LLVM emit all jump tables info in one section?
> Also note that Elf_Sym has name, section index, value and size,
> hence symbols defined for jump table section can encode jump tables.
> E.g. the following implementation seems more intuitive:
>=20
>   .jumptables
>     <subprog-rel-off-0>
>     <subprog-rel-off-1> | <--- jump table #1 symbol:
>     <subprog-rel-off-2> |        .size =3D 2   // number of entries in th=
e jump table
>     ...                          .value =3D 1  // offset within .jumptabl=
es
>     <subprog-rel-off-N>                          ^
>                                                  |
>   .text                                          |
>     ...                                          |
>     <insn-N>     <------ relocation referencing -'
>     ...                  jump table #1 symbol

Anton, Yonghong,

I talked to Alexei about this yesterday and we agreed that the above
arrangement (separate jump tables section, separate symbols for each
individual jump table) makes sense on two counts:
- there is no need for jump table to occupy space in .rodata at
  runtime, actual offsets are read from map object;
- it simplifies processing on libbpf side, as there is no need to
  visit both .rodata and jump table size sections.

Wdyt?

> > +
> > +	/* Jump Tables */
> > +	struct jt **jt;
> > +	size_t jt_cnt;
> > +
> >  	struct bpf_gen *gen_loader;
> > =20
> >  	/* Information when doing ELF related work. Only valid if efile.elf i=
s not NULL */
>=20
> [...]

