Return-Path: <bpf+bounces-76916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B11ECC98A9
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 22:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 212C23028327
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 21:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D777530DD10;
	Wed, 17 Dec 2025 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDD6ZQ5B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14312EF652
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 21:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766005354; cv=none; b=eJieN0eQM1BEo8ZgSSkoDsHD0D4ZV9j0tX3AZDfYrBLUGmdrILT4nyRXNaz/FPm7wzKqbM38LQVRUhqCnj1StdMQittltFefBvjGlevI3QBUNlz+a2r9nIMhMhCpSgWNts2xeCcLNR+Cnu8qyfV6gTce1metcf65BleSArpKdmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766005354; c=relaxed/simple;
	bh=FGOWm+hvr4Kd8i81wzrzdeFjdJ5MmSrUwJsa0FjfR78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQnAdOEaiMYhErygcmuQJ6UczzHjQwK/gSxo59JJuXtnKZkbOf2m07tOjwnMpbKEqm211deahJRuV04kyZII+GDLtNtqg20YOBeJ8d2OVrtpZtGRxfIMK2ad4j/mmPdb7LufdOf1e32EPevhdlDjZQ3hOuJoq+zbOBWMyXRI8hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDD6ZQ5B; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b73161849e1so1482175666b.2
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 13:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766005351; x=1766610151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGOWm+hvr4Kd8i81wzrzdeFjdJ5MmSrUwJsa0FjfR78=;
        b=TDD6ZQ5BlAzfyACXCbcD8W5Ll/VFmzYc1xOdDiXyY/Teep+OGmVcIVp1YKzxKEgQID
         FvhecDbW6LxDd4fs7FjzkchnrtDAqY/aRpriZNOEY3Ulc8obfvdwuoFegtGw/8nvUaqs
         +jxZ2wclDKq6I1Qj4kjMm5uzLiNt1ZcrZAeVC1eyWQlKBUX0bZxKH0nwlrde46cu2aPb
         W7XGcUwnqtNDhURFo/ReaswXy0C8e0OC6EfJ8pmGjAKgEVA6Nq5pr1S+OcX1XrKEYxxw
         QumRpaj/l0JZy7pl377s8+BWEz524Sekc4wKrsbQTd8r0IYZ7/cWH8WZQKm3rYW87WXJ
         ixqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766005351; x=1766610151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FGOWm+hvr4Kd8i81wzrzdeFjdJ5MmSrUwJsa0FjfR78=;
        b=EHooL9PNcCS9qnC/JbhNby9YZIr4DPMDwSNZ5IGHzZZGa3U2Vwp71uAFbFgeXX8jGL
         4Ox8Sbz3Am+OZrBx5sFZA+q7WuxDq4Ia2vUK1I1IjZZCvPaklhpbdZFGbborpJaOZL0L
         Nt8ti0QFrgSbaoyL1UgSiJ/KEzsvDDGhrh8zjHRTFSea43UBwIcQI++lQkw58mcwzY7N
         BfrG+J7F30pgG3dX3fW6iMM/JLDTrRXKWACuqjpyQvc9eiC/NTPmPobebVrPYHjt01XG
         mXGZxMIXxX9O0Au5+dXZmMagQHMiczzgG6xqj5M8O3+YTQw1ggO0+1MEdWcsewtlaiKV
         C5nw==
X-Forwarded-Encrypted: i=1; AJvYcCVqN4kbXp7kmQ/R1n+lfVuHgV1bfovAsjoeTYLMTOJrCE2x06RLqqIGWMrEII6jY29nFxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBluZUCW02ymaNGLC3OijlNpAz12+EslwZJc01slLCw/dSQa7o
	h7i7jLBZqKI3NA4Xb7gME1yAW0ded2twifJPqUah7aQazkEtNB/jOEz35/BReQ4tXJ0BwAA0fdT
	V+Sva7xjdpBCNyhb9ZThqt2y1qyjtV7Y=
X-Gm-Gg: AY/fxX4kUHNLuEUHRJKqdtCEiVb1/Xs4ckNIqjRWEphTOaisRBF1Abn8LRJxUvNRqBm
	lj2MfCoxaeHT62zW0ueFZi05zB9OOYPevMIIMaziittLnT5lStHwskKfO9rqcJcpYbDbur/drnD
	ttzUf0fhDZUWSYMrx/fW7EVIcnd26kNuJ4aoWHSEPGGaKL7i8GxeD+6RCkqoYBRKZzFkWuScd8z
	hK/rdwMFIErmbQjFZkoga5pOYAzaeKI9SLn1Bkiu5I9a3sRMkik+SBBsOb43+teRmIMVSw=
X-Google-Smtp-Source: AGHT+IGPvdbUCbdHYyRI95AJTQ0Ca909Eb1uysz/w6+pVYh5M1l+QJhz1TyC+Ps0T4ESRGmbzJLOufWK5I7Xyp8jWcw=
X-Received: by 2002:a17:907:db03:b0:b73:1634:6d71 with SMTP id
 a640c23a62f3a-b7d23693326mr1987783566b.26.1766005350861; Wed, 17 Dec 2025
 13:02:30 -0800 (PST)
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
 <3071012cc1e8d6bdf16b13d371a12cb201c502a7.camel@gmail.com> <b65fd7dc-fbad-4a96-8eb8-f36f8f518d44@oracle.com>
In-Reply-To: <b65fd7dc-fbad-4a96-8eb8-f36f8f518d44@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 17 Dec 2025 13:02:12 -0800
X-Gm-Features: AQt7F2otvhC33XYO3ASUH67LBFOiHauFP0xrh82MbfEwDO3brWH6AMUmqOj20ZA
Message-ID: <CAEf4Bzb+3cryZAEwC_O7xgm3=cthZU-SNsUWfGH8OpSwc+3vaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add option to force-anonymize nested
 structs for BTF dump
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 12:50=E2=80=AFPM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> On 17/12/2025 19:35, Eduard Zingerman wrote:
> > On Wed, 2025-12-17 at 11:34 -0800, Eduard Zingerman wrote:
> >> On Wed, 2025-12-17 at 18:41 +0000, Alan Maguire wrote:
> >>
> >> [...]
> >>
> >>> So maybe the best we can do here is something like the following at t=
he top
> >>> of vmlinux.h:
> >>>
> >>> #ifndef BPF_USE_MS_EXTENSIONS
> >>> #if __has_builtin(__builtin_FUNCSIG) || defined(_MSC_EXTENSIONS)
> >>> #define BPF_USE_MS_EXTENSIONS
> >>> #endif
> >>> #endif
> >>>
> >>> ...and then guard using #ifdef BPF_USE_MS_EXTENSIONS
> >>>
> >>> That will work on clang and perhaps at some point work on gcc, but al=
so
> >>> gives the user the option to supply a macro to force use in cases whe=
re
> >>> there is no detection available.
> >>
> >> Are we sure we need such flexibility?
> >> Maybe just stick with current implementation and unroll the structures
> >> unconditionally?
> >
> > I mean, the point of the extension is to make the code smaller.
> > But here we are expanding it instead, so why bother?
>
> Yeah, I'm happy either way; if we have agreement that we just use the nes=
ted anon
> struct without macro complications I'll send an updated patch.

There is a little bit of semantic meaning being lost when we inline
the struct, but I guess that can't be helped. Let's just
unconditionally inline then. Still better than having extra emit
option, IMO.

>
> Alan

