Return-Path: <bpf+bounces-68945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D27B8AA40
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 18:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30FE97B77DF
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFF4271475;
	Fri, 19 Sep 2025 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZ2x+d/k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8C326A1A3
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 16:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300547; cv=none; b=F9RhIJb9SaVS0floVYKCWzQSlRUywtg0ShzrN62s08hIZtQ/+XkwYi3oLeI5jxhP9Rvk5CgH5Du2KkUgBp1EtYjk5VrDxab3a0dp0X6OZNSRwcQ4s/1pQsewWptygIhA5s+L2JddB+XZl6RcxoUd1w7hL14yLGRG82oB2x2jAFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300547; c=relaxed/simple;
	bh=wJOHbS0RuP99kJ1LE9gfoiEk3Tgok44b8Xixp4Wyp9w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fnHyleQ9wJ4jDGxMN0zct2Zd/CIsc9C/nf7m+ct0TyRObAHDVxaEEm3MmNO1LOm8skudHl1gNxCbhEr18e6Q68iKBSpcVBXGfsWhNu+Eymclb6Ka2d7xLBRT8PQwGdILJDB1OdzXcmaU+iaiozHxcb3y5yzBx0svYp5/ieRN6HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZ2x+d/k; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32e715cbad3so2396520a91.3
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 09:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758300545; x=1758905345; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wJOHbS0RuP99kJ1LE9gfoiEk3Tgok44b8Xixp4Wyp9w=;
        b=NZ2x+d/kExccsvf6bvnXqIvybSZFPB6TL1XGWKqom3YarqY/IKExqEHB2UONkSR846
         0LVpdteAdRuyyOVi9qUM2MOpU0Cr21ioR5hE/LTGYOVFD3EljU9fNVb0ZrER6QluIeb+
         VXOvsn57+4d0qatYZsaK7sri2x4jIvPC2dNBvtme2jYJiwmNwxnVh8Ly+rW+AqVW42bd
         hvdXBam6tyA0DiBrTDjgwaKDLlALZgQaxV8HLfPLRxdPk7Y24ic9Um+5+eXkB9lkLkKf
         37sLXbehnJ8OpVGyC88hcrLvVlPMCf2OzWGWx2L5lzymrQad5KhfQrU3JwvvlIOpNsrr
         H4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758300545; x=1758905345;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJOHbS0RuP99kJ1LE9gfoiEk3Tgok44b8Xixp4Wyp9w=;
        b=SJvtJG2f2GV7P9PjWCKqX6A49ObY43jjT7fsanyzTSIW3Os+y4HLh+MagwCce9qBeE
         Z7gXMKm0D51vDLf3izBRxvUAy+fuXc1PlvafjCAAgNHZP1HHuwcJANhM0eQWKkUy18Ci
         j0dEIjajX1gIyHaY2bq7MmFfELKgjwfCEpMqFydnzdcz8iX7OlJtTmLgHRF9cdfvlJs+
         7r5IlYmJea8iilWwUOi6CgwIghQ1XWYsJeem//1g1tp5pGxlpLFqaUMI4yXpDewWCdgy
         gXR+WRIqHQpBxQ9faVq2S3hsyqkRDEArROedxPOrdkkTE9cr5+GScCNV4zXqfIS0KcB1
         +exA==
X-Gm-Message-State: AOJu0Ywb2MrPjUN6gc0d4jc+jwOfy+VJ9vMV22Oc5czBNGjObBdAkPhg
	NN/+6fjpSGDyGv6xqH9dRtpEh3fcqrgIxBdmQrsQCmRwbICohG3jRKeI
X-Gm-Gg: ASbGnctwHoqHxQtJMY2KbM94YyPlSs4iWubSqP/qTcoduy476ZHFl+E0cpt1O/PN8NZ
	2+MllRJwHKYivqdw01cgAw4QMPFxDY3cJMlpxyYPui0Jyx4XN+BffsJFyInOT4X0MYN/7xqz0A4
	yKldJGQxDRZd+MBNqfKhc7KZm9lkvwQGMa6GloxMWFztcF8fS0xq34SMXdZBqA/CHWstWJTPoxy
	pv7wAq9h2UO01EmwVjde5P3VWnHLugi/wRNSvsU3eCEr/cHM47pkiqsC6UFXT7PzVLFxG2l8rng
	74nHDfxZfwGaHg+zS+uz7Cxv5YR2MGF1PvNi1Iv92wOauYNZ19Cx/sDKQWWEc/PYCwZw1+XHgKi
	IOF4Hd9TadreBvaVIl6w=
X-Google-Smtp-Source: AGHT+IEcCnAi2aGbGpKwDCCi4EDpA6HQfjDOKm8eUkfofuTekYo7akO+hTfs9Vp3XQmORlA1GQ7+kg==
X-Received: by 2002:a17:90b:48ce:b0:32e:d16c:a8c6 with SMTP id 98e67ed59e1d1-3309800002cmr5419031a91.16.1758300544834;
        Fri, 19 Sep 2025 09:49:04 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3303ffa1531sm4005524a91.4.2025.09.19.09.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 09:49:04 -0700 (PDT)
Message-ID: <ba545b6a019458b80f345656b4b4f9f6c398e43d.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 00/13] BPF indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Fri, 19 Sep 2025 09:49:01 -0700
In-Reply-To: <aM1vcrxBSbyQrdq1@mail.gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
	 <938446871de1d0b91ca7eb56dd75442b1d58b4b4.camel@gmail.com>
	 <aM1vcrxBSbyQrdq1@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-so/VrFHP4fNBajvfE8RC"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-so/VrFHP4fNBajvfE8RC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-09-19 at 14:57 +0000, Anton Protopopov wrote:
> 25/09/18 11:46PM, Eduard Zingerman wrote:
> > On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
> > > This patchset implements a new type of map, instruction set, and uses
> > > it to build support for indirect branches in BPF (on x86). (The same
> > > map will be later used to provide support for indirect calls and stat=
ic
> > > keys.) See [1], [2] for more context.
> >=20
> > With this patch-set on top of the bpf-next at commit [1],
> > I get a KASAN bug report [2] when running `./test_progs -t tailcalls`.
> > Does not happen w/o this series applied.
> > Kernel is compiled with gcc 15.2.1, selftests are compiled with clang
> > 20.1.8 (w/o gotox support).
> >=20
> > [1] 3547a61ee2fe ("Merge branch 'update-kf_rcu_protected'")
> > [2] https://gist.github.com/eddyz87/8f82545db32223d8a80d2ca69a47bbc2
> >=20
> > [...]
>=20
> Can't reproduce on my setup yet (but with the other set of compilers,
> will try to reproduce with ~ your versions).

Double-checked with `git clean -xfd` between retries, see same outcome
as before. Attaching script I use for kernel configuration.

--=-so/VrFHP4fNBajvfE8RC
Content-Disposition: attachment; filename="kernel-config-addons"
Content-Transfer-Encoding: base64
Content-Type: text/plain; name="kernel-config-addons"; charset="UTF-8"

IyBuZWVkIGV0aGVybmV0IGRldmljZSBmb3Igc3NoIGNvbm5lY3Rpb24KQ09ORklHX0UxMDAwPXkK
CiMgdXNlIHNkYSBhcyBib290IGRldmljZQpDT05GSUdfQVRBPXkKQ09ORklHX1NBVEFfQUhDST15
CkNPTkZJR19TQ1NJPXkKQ09ORklHX0JMS19ERVZfU0Q9eQoKIyBhbGxvdyB1c2luZyBnZGIgZnJv
bSBvdXRzaWRlIHRoZSBWTQpDT05GSUdfR0RCX1NDUklQVFM9eQpDT05GSUdfREVCVUdfUFJFRU1Q
VD15CkNPTkZJR19LR0RCPXkKQ09ORklHX1VOV0lOREVSX0ZSQU1FX1BPSU5URVI9eQpDT05GSUdf
RlJBTUVfUE9JTlRFUj15CgojIHNob3VsZCBiZSB1c2VmdWwsIGJ1dCBpZGsKQ09ORklHX0hZUEVS
VklTT1JfR1VFU1Q9eQpDT05GSUdfUEFSQVZJUlQ9eQpDT05GSUdfS1ZNX0dVRVNUPXkKCiMgdXNl
ZCBieSBCUEYgZXhjZXB0aW9ucwpDT05GSUdfVU5XSU5ERVJfT1JDPXkKCiMgYm9vdCBmcm9tIHZt
bGludXgKQ09ORklHX1BWSD15CgojIHRvIGF2b2lkIGtlcm5lbCBidWlsZCBlcnJvciBhYm91dCBs
ZWdhY3kgb3BlbnNzbCBzaGlwaGVycwpDT05GSUdfTU9EVUxFX1NJR19TSEE1MTI9eQoKIyBzY2hl
ZF9leHQKQ09ORklHX1NDSEVEX0NMQVNTX0VYVD15CgojIGFkZHJlc3Mgc2FuaXRpemVyCiNDT05G
SUdfSEFWRV9BUkNIX0tBU0FOPXkKI0NPTkZJR19IQVZFX0FSQ0hfS0FTQU5fVk1BTExPQz15CiND
T05GSUdfQ0NfSEFTX0tBU0FOX0dFTkVSSUM9eQojQ09ORklHX0NDX0hBU19LQVNBTl9TV19UQUdT
PXkKI0NPTkZJR19DQ19IQVNfV09SS0lOR19OT1NBTklUSVpFX0FERFJFU1M9eQpDT05GSUdfS0FT
QU49eQojQ09ORklHX0NDX0hBU19LQVNBTl9NRU1JTlRSSU5TSUNfUFJFRklYPXkKI0NPTkZJR19L
QVNBTl9HRU5FUklDPXkKI0NPTkZJR19LQVNBTl9JTkxJTkU9eQojQ09ORklHX0tBU0FOX1NUQUNL
PXkKI0NPTkZJR19LQVNBTl9WTUFMTE9DPXkK


--=-so/VrFHP4fNBajvfE8RC
Content-Type: application/x-shellscript; name="make-kernel-config.sh"
Content-Disposition: attachment; filename="make-kernel-config.sh"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKCnNldCAtZQoKc2VsZmRpcj0kKHJlYWxwYXRoICQoZGlybmFtZSAkMCkpCmtl
cm5lbD0kMQoKaWYgW1sgIiRrZXJuZWwiID09ICIiIF1dOyB0aGVuCiAgICBpZiBbWyAtZSBLY29u
ZmlnICYmIC1lIE1BSU5UQUlORVJTIF1dOyB0aGVuCiAgICAgICAga2VybmVsPSQocHdkKQogICAg
ZWxzZQogICAgICAgIGVjaG8gIlVzYWdlOiAkMCA8a2VybmVsLXNyYy1yb290PiIKICAgICAgICBl
eGl0IDEKICAgIGZpCmZpCgpjb25maWdfdm09dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL2Nv
bmZpZy52bQppZiBbWyAhIC1mIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9jb25maWcudm0g
XV07IHRoZW4KICAgIGNvbmZpZ192bT0KZmkgIAoKT1VUPSIiCmlmIFtbICIkTyIgIT0gIiIgXV07
IHRoZW4KICAgIE9VVD0iLU8gJE8iCmZpCgpjZCAke2tlcm5lbH0KLi9zY3JpcHRzL2tjb25maWcv
bWVyZ2VfY29uZmlnLnNoICRPVVQgXAogICAgICAgICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9i
cGYvY29uZmlnIFwKICAgICAgICAgJHtjb25maWdfdm19IFwKICAgICAgICAgdG9vbHMvdGVzdGlu
Zy9zZWxmdGVzdHMvYnBmL2NvbmZpZy54ODZfNjQgXAogICAgICAgICAke3NlbGZkaXJ9L2tlcm5l
bC1jb25maWctYWRkb25zCg==


--=-so/VrFHP4fNBajvfE8RC--

