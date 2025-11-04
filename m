Return-Path: <bpf+bounces-73488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2038C32AB5
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 19:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADFC01894F01
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 18:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0CB33F8A5;
	Tue,  4 Nov 2025 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMWIS7oN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7433533E365
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 18:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281071; cv=none; b=WQ7SxQ96Jw/bsRrnHE1funq+RRYP1SH3UNwddjKZqjlbgX63WeDkUAljtz8s4aGtFGvyJvcXJqTF0UnlFYujuYv8belpM8+/D5Ic1+YylvjJx0rFel/rknC7ZFpRlH6iSenrso/mmj9dLcHOF9WAXN9vMcbLX/uN5Um5CiDn3lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281071; c=relaxed/simple;
	bh=wcHSIsQskU66h3dqTB9easTVeZNgVchyfFTZTh1G9Z0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KcYU/b6sVJ9ly9cQdqOtQn81h4X6q5qySJD5+WvpwLxhc7UXRJLsQwu1i2/0vDDOY6rMN87nF2aG38/xviR5BWxzHQZy7bJRAGJqbgmB6J+hnuLg6vYszs6qCa+ZAbrAlJWQN85cBL1NjUYmit1Zet7FRKkyr8F8M02BvFA5Wo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMWIS7oN; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34182b1c64bso614930a91.3
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 10:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762281069; x=1762885869; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z/upeeekYKOSQ5Dz2NB27KkesBU+xEnSN5IRldAj6Gc=;
        b=HMWIS7oNnTnZu2x2BrNKlqhiqtUdykmdPpqVQ202dQ5gy5fFmu8zcTgEMPygIiGn/1
         /9nkB7QEjNGwyNxWiUMiWHL6Eirf4CIf+3cyNb6j6YDkfL59b53WFogZulNkZ+xYoKJ+
         VlEgkId1qd6HUi2Wfn+y79quJl9EBuVWUqDLCD4P7tuKQwqrpo1vUMZkfAnT2dJI6c4K
         1VRzbsOEYthnn3AgIm9CqgIjNTWhCzManMhJZn0h2UBErdIGfDC34cf85Ee94hUD8eeU
         spNJf4bq0rGaQGSS6dR+R5LjBApGKBeg45zRg5YHnHSO5xsCPdzH5mVNaXnOkkxkQ657
         YP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762281069; x=1762885869;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/upeeekYKOSQ5Dz2NB27KkesBU+xEnSN5IRldAj6Gc=;
        b=SbcmXpqnPcACi40ViTEo/QSxYk8OmP4C6QKnDM9dJrqfkol8iqg4HH2HrLPTxgxOBt
         1pd3CLJa1w6lNrU9SoqBYvmIjuikGrsU6YP0rAEBQyMzOkg5egGgVO6xKLkeKllQNqt6
         KwM7EygeI8sgBL6AF4bPtRXyvzCOQyuCg8SF13Vp0gDPCwr98Kg1DL5GEgjPz9IvRr2a
         7Zl01HejunFAoXFCztdxBg+XtiRPEwta6oyN6e5ze5DssEkolwzP2GeuflNsrgzSl8Yu
         /6PMLWc+v6hoHg5F2T04C1lliFXMIABOv0cPTH614HmH/3JUeOLmauL2SInLtQHt/MJ0
         Pwgw==
X-Gm-Message-State: AOJu0Yz5qJmvuymiiNwAIrl66Oh9NIMJzK7f8ujIODBrdT8neMCCNNcF
	K55lrjytV9L21IftsgjFKOHNd7FF9Ap4DMzpsQVNrX8IXIk6XhUXOVF2eEOdh4ve
X-Gm-Gg: ASbGncsdqz92ON0tQrIH3CIUeYBKb1dFa8TpCXZknSeS6/k0dlL70odhpYWG/7NTKU8
	pd75K//3eqZuNCi/+NZhF+ILoR0jnWCqosJanK6McBoQhXcZl4aUj3u+FIHXJ1VQ3nv/pf6fMkE
	dWPGCVUEzl58owZD9DEZ+JdWMNRLEWeKPYl86uTYkEVEklRmR3uvbUCJ0V79oq34NVhihD01pSO
	pbTZNG7MOmfY2bRTSUo56LvsZZk2EbfrcACW1nP539Di7d3SoyNcb7w0unVC0DBBBI+o+8TnzQX
	uWAKjtXu4EBHwa2gEqNZH1/4U5iOz6uZDhOqUnJmpOCgdFFuX6kWZUc+4u2FiJh9mHCzqcpX5ZL
	bMyrF/Q7houQEwVfK8t8fN8myr74lvmLLC6d+Meh4SosDlyS2Gc5lFCGGApV8y7LDSMX60MizK8
	ajQdSYjcFsHty8bJR+yQyFod4=
X-Google-Smtp-Source: AGHT+IEDtHuCNZ2aBh8VUw/0Cf5nSnDZH55I+Xv166uOD8Kuwt2Uk3uO4cpRTOhCRIfCshqd+Pnxwg==
X-Received: by 2002:a17:90b:3a48:b0:340:ff7d:c2e with SMTP id 98e67ed59e1d1-341a6dd9cccmr188832a91.29.1762281068580;
        Tue, 04 Nov 2025 10:31:08 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417d4098cbsm1835761a91.5.2025.11.04.10.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:31:08 -0800 (PST)
Message-ID: <4c4ecade1a8297dada4c398a10aaa965ddf08399.camel@gmail.com>
Subject: Re: [PATCH v10 bpf-next 08/11] libbpf: support llvm-generated
 indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Anton Protopopov
	 <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>
Date: Tue, 04 Nov 2025 10:31:06 -0800
In-Reply-To: <45c6e54a-d715-424e-b9c8-ad53956686da@linux.dev>
References: <20251102205722.3266908-1-a.s.protopopov@gmail.com>
	 <20251102205722.3266908-9-a.s.protopopov@gmail.com>
	 <4c9b089ea2c24b12d0d83f507c986d544f2c4e75.camel@gmail.com>
	 <45c6e54a-d715-424e-b9c8-ad53956686da@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-03 at 21:26 -0800, Yonghong Song wrote:

[...]

> > > +		if (subprog_idx >=3D 0) {
> > > +			insn_off -=3D prog->subprogs[subprog_idx].sec_insn_off;
> > > +			insn_off +=3D prog->subprogs[subprog_idx].sub_insn_off;
> > I'd like to reiterate my point about relocation related warnings [1]:
> >=20
> >    > I'm seeing the following messages when rebuilding bpf_gotox using
> >    > llvm main, where Yonghong added __BPF_FEATURE_GOTOX.
> >    >
> >    >     CLNG-BPF [test_progs-cpuv4] bpf_gotox.bpf.o
> >    >     GEN-SKEL [test_progs-cpuv4] bpf_gotox.skel.h
> >    >   libbpf: elf: skipping relo section(13) .rel.jumptables for secti=
on(6) .jumptables
> >    >   libbpf: elf: skipping relo section(13) .rel.jumptables for secti=
on(6) .jumptables
> >=20
> > In the context of Yonghong's reply [2].
> >=20
> > I inserted some debug prints and confirm that these relocations are
> > generated for basic block labels, e.g.:
> >=20
> >    .S file corresponding to shortened bpf_gotox.c:
> >        ...
> >               gotox r1
> >       .Ltmp25:
> >       .Ltmp26:
> >       .Ltmp27:                                # Block address taken
> >       LBB0_5:                                 # %l1
> >               #DEBUG_LABEL: one_jump_two_maps:l1
> >               .loc    0 36 10 is_stmt 1               # progs/bpf_gotox=
.c:36:10
> >       .Ltmp28:
> >               w1 =3D *(u32 *)(r10 - 4)
> >        ...
> >               .section        .jumptables,"",@progbits
> >      BPF.JT.0.0:
> >              .quad   LBB0_5
> >=20
> >    objdump --symbols, corresponding to same shortened bpf_gotox.c:
> >=20
> >      Symbol table '.symtab' contains 18 entries:
> >         Num:    Value          Size Type    Bind   Vis       Ndx Name
> >           ...
> >           2: 0000000000000000     0 SECTION LOCAL  DEFAULT     3 syscal=
l
> >=20
> >    objdump --relocations, corresponding to same shortened bpf_gotox.c:
> >=20
> >      Relocation section '.rel.jumptables' at offset 0xde8 contains 4 en=
tries:
> >           Offset             Info             Type               Symbol=
's Value  Symbol's Name
> >       0000000000000000  0000000200000002 R_BPF_64_ABS64         0000000=
000000000 syscall
> >       ...
> >=20
> > Here the first entry corresponds to LBB0_5 symbol, specifically:
> >=20
> >                           Relocation type (R_BPF_64_ABS64).
> >                               vvvvvvvv
> >     0000000000000000  0000000200000002 R_BPF_64_ABS64         000000000=
0000000 syscall
> >     ^^^^^^^^^^^^^^^^  ^^^^^^^^                                ^^^^^^^^^=
^^^^^^^
> >     Offset at which   Section                                 Given tha=
t relocation type is
> >     to apply the      index                                   R_BPF_64_=
ABS64, this is the value
> >     relocation,       for 'syscall'.                          which has=
 to be written at offset.
> >     first jumptables                                          (See [3])=
.
> >     record.
> >=20
> > Given above, I conclude that:
> >=20
> > - [to Anton] libbpf has to apply the relocations from .rel.jumptables
> >    in order to assign correct the sec_insn_off for records in the jump
> >    table.  Right now we imply that each record in the table corresponds
> >    to a section where jump table is referenced from, but that is not
> >    true.
> >=20
> > - [to Yonghong] LLVM should generate a different relocation kind,
> >    or a different "Symbol's Value", otherwise applying relocations as
> >    instructed in [3] will lead to zeroes in the jump table:
> >   =20
> >    > In another case, R_BPF_64_ABS64 relocation type is used for normal
> >    > 64-bit data. The actual to-be-relocated data is stored at
> >    > r_offset and the read/write data bitsize is 64 (8 bytes). The
> >    > relocation can be resolved with the symbol value plus implicit
> >    > addend.
>=20
> I think the following llvm patch
>     https://github.com/llvm/llvm-project/pull/166301
> should avoid jumptable relocation. The idea is originated from one of
> Eduard's idea which put the label difference in the jump table entry.
> Please give a try. I think it should work.

I tried Yonghong's llvm change, and it solves the issue.
Relocations are no longer generated for .jumptables section.
So, nothing to change on the libbpf side.

[...]

