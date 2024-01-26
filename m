Return-Path: <bpf+bounces-20434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9A783E563
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 23:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4118285EA9
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 22:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAA024B22;
	Fri, 26 Jan 2024 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lfAejkz9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62152511E
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 22:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308037; cv=none; b=nnkXEeof0zm5tvUBzLfIWlihqTx7PDPUaxq0XAvvihcLee8SOzPiH/D5UJzRoEA/qV9tKJBann3FMmJWD0ETrDo/LAq5qF25eNEkHao66AB/1yhBpl+uEr9apwQsJwxc/s5TizZsSrMEQUrQcut1ec7wHX9dXlFAdmJ8IWRQbR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308037; c=relaxed/simple;
	bh=FxhH3dz6ExCsPI3NdWrAnPN66l5b7bwYVETJ0+LCZqY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=BrIrSPa9/IGJ+2q7BkVDN6Lt+K/9wG4qMyYAyHjie5RC0JulNWEaTO1JvKTXPpRf6qoTGIMe+rwsj686nxv5Sjzs0XPrJ90AsqVGK9w1Vpnh6O9DPHQxb0/eM25NkZPo3i1iTqD35FEJnkv1d1uR0jwfhiodYr+CC3R6q03Kq6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lfAejkz9; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d8b276979aso246026a12.2
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 14:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706308035; x=1706912835; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jUtFzxEXad4F85Weuilo5A/gdxKABzI+tPFWTtBxOPQ=;
        b=lfAejkz9R6UXMwnxnNomYcMLZKg0KD2qs3n1IFlaXWqP+ot30iss5AYHMenPeHGX9J
         /VMO2vy64BDduiGXq2pPol8oOobH0dYCbJosW0qkc/N8vXBVNO0CiVWTihUWPs5BlslK
         PjWZK76UDam49vu7iu712CEeU8CBlVwGmyUS6FU3OsYeCg5GaYasOAx3SwO6FvPNcTgs
         DWzu/PlNSui9QPqq7memFERlUdl0EAx7B5ZQ7INSPaYsX7tNwo9Ljqhoy7v9gLGrrabf
         ebHxqt/JngpRmsKIbWjNmXHXjeYOMcQSmNmW1BTMB5s98Dsuju1vP9si1vPrgiwZHOXf
         SXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308035; x=1706912835;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jUtFzxEXad4F85Weuilo5A/gdxKABzI+tPFWTtBxOPQ=;
        b=f2CiNEbobfnRmkQhVYE9jSHO5w9YyRaZkaEJnrwkzPscX0+9RTCz6fB5cNkV8/soRk
         wz8dZSM/CdBdnV8A6nGnrJ0h59AMjGALzbrHvwzeYnHs1pX80TstaeqZ/OoduDZSN2xV
         cJAhRoJkf7nDK3uyf5oiRL7AXYeD91/o4qCo7G0fDZpHlsaFECdhtYdZonbfBL9UVGeN
         1OOFvLQOobhbkuyfVJ8bMRrI3kRgt3tACI/+sGzoOWkyMY/T9Ef3QVjcNWjKVT62KRh0
         XM3/38x8f78GU6U5cHkrOiakftCtWo6nTSLDvk8SaDJDDva4XeUwXVOHfqXIJnzEOHaN
         ZeSw==
X-Gm-Message-State: AOJu0YxbFtJ3+5Hzqcq1Vdi0PPeBpMICayRYaDvCzI4Zftuh0KnhgY1E
	dkB1XUyDQLHQOeHCZ6g+3LA7kPn/ns9eUQ9sQ3QROiQZSA1EZFUBunOSaN+CohM=
X-Google-Smtp-Source: AGHT+IGQVfPtPOMLv9m7WEb+mB6I/8QNfvyBUXlevIiFsSKZADnKJVPY/lx1aavFbXx8t0dFHuH3CQ==
X-Received: by 2002:a17:90a:1fcc:b0:290:1464:e994 with SMTP id z12-20020a17090a1fcc00b002901464e994mr509579pjz.46.1706308035092;
        Fri, 26 Jan 2024 14:27:15 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id c92-20020a17090a496500b0029102d936casm4034619pjh.47.2024.01.26.14.27.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jan 2024 14:27:14 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Yonghong Song'" <yonghong.song@linux.dev>
Cc: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
References: <085f01da48bb$fe0c3cb0$fa24b610$@gmail.com> <08ab01da48be$603541a0$209fc4e0$@gmail.com> <829aa552-b04e-4f08-9874-b3f929741852@linux.dev> <095f01da48e8$611687d0$23439770$@gmail.com> <4dfb0d6a-aa48-4d96-82f0-09a960b1012f@linux.dev> <1fc001da4e6a$2848cad0$78da6070$@gmail.com> <9d077ed4-6a30-49db-8160-83d8c525ff3e@linux.dev> <259a01da4ff4$adfe9c50$09fbd4f0$@gmail.com> <dc839efe-2382-440d-bcf6-b9ddc252f35e@linux.dev>
In-Reply-To: <dc839efe-2382-440d-bcf6-b9ddc252f35e@linux.dev>
Subject: RE: 64-bit immediate instructions clarification
Date: Fri, 26 Jan 2024 14:27:10 -0800
Message-ID: <294f01da50a6$ce3d0670$6ab71350$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGkwaT1bS2nmU/D6EzqCIA6r6THFAGlkngPAiWOVp0CBJjXigIgg/ivAZjEuOEC/rKUjQJO4XhxARE1PEaw2ImpwA==
Content-Language: en-us

Yonghong Song <yonghong.song@linux.dev> wrote:=20
> On 1/25/24 5:12 PM, dthaler1968@googlemail.com wrote:
> > The spec defines:
> >> As discussed below in `64-bit immediate instructions`_, a 64-bit
> >> immediate instruction uses a 64-bit immediate value that is =
constructed as
> follows.
> >> The 64 bits following the basic instruction contain a pseudo
> >> instruction using the same format but with opcode, dst_reg, =
src_reg,
> >> and offset all set to zero, and imm containing the high 32 bits of =
the
> immediate value.
> > [...]
> >> imm64 =3D (next_imm << 32) | imm
> > The 64-bit immediate instructions section then says:
> >> Instructions with the ``BPF_IMM`` 'mode' modifier use the wide
> >> instruction encoding defined in `Instruction encoding`_, and use =
the
> >> 'src' field of the basic instruction to hold an opcode subtype.
> > Some instructions then nicely state how to use the full 64 bit
> > immediate value, such as
> >> BPF_IMM | BPF_DW | BPF_LD  0x18    0x0  dst =3D imm64
> integer      integer
> >> BPF_IMM | BPF_DW | BPF_LD  0x18    0x2  dst =3D =
map_val(map_by_fd(imm))
> + next_imm   map fd       data pointer
> >> BPF_IMM | BPF_DW | BPF_LD  0x18    0x6  dst =3D =
map_val(map_by_idx(imm))
> + next_imm  map index    data pointer
> > Others don't:
> >> BPF_IMM | BPF_DW | BPF_LD  0x18    0x1  dst =3D map_by_fd(imm)
> map fd       map
> >> BPF_IMM | BPF_DW | BPF_LD  0x18    0x3  dst =3D var_addr(imm)
> variable id  data pointer
> >> BPF_IMM | BPF_DW | BPF_LD  0x18    0x4  dst =3D code_addr(imm)
> integer      code pointer
> >> BPF_IMM | BPF_DW | BPF_LD  0x18    0x5  dst =3D map_by_idx(imm)
> map index    map
> > How is next_imm used in those four?  Must it be 0?  Or can it be =
anything and
> it's ignored?
> > Or is it used for something?
>=20
> The other four must have next_imm to be 0. No use of next_imm in thee =
four
> insns kindly implies this.
> See uapi bpf.h for details (search BPF_PSEUDO_MAP_FD).

Thanks for confirming.  The "Instruction encoding" section has =
misleading text
in my opinion.

It nicely says:
> Note that most instructions do not use all of the fields. Unused =
fields shall be cleared to zero.

But then goes on to say:
> As discussed below in 64-bit immediate instructions (Section 4.4), a =
64-bit immediate instruction
> uses a 64-bit immediate value that is constructed as follows.
[...]
> imm64 =3D (next_imm << 32) | imm

Under a normal English reading, that could imply that all 64-bit =
immediate instructions use imm64,
which is not the case.  The whole imm64 discussion there only applies =
today to src=3D0 (though I
suppose it could be used by future 64-bit immediate instructions).   =
Minimally I think
"a 64-bit immediate instruction uses" should be "some 64-bit immediate =
instructions use"
but at present there's only one.

It would actually be simpler to remove the imm64 text and just have the
definition of src 0x0 change from: "dst =3D imm64" to "dst =3D (next_imm =
<< 32) | imm".

What do you think?

Dave


