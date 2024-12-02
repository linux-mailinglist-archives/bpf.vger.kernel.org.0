Return-Path: <bpf+bounces-45956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5939E0EA0
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 23:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01DCCB2736C
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 22:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953AC1DF725;
	Mon,  2 Dec 2024 22:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwZqFONQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03541DA103
	for <bpf@vger.kernel.org>; Mon,  2 Dec 2024 22:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733176920; cv=none; b=bAAbonGWCAJza/2nu14IlicfpHOlvwgCt8MGpCIMzSetDsnSCxXbL4KA3yy1zTdkwVosu5YgGpIjn7Sc9rS+ehKegW1TS3WOKWnruHRaHOqfbCnkJFZaGrv+UqYzZMGw5HIaij9/Bho6DK6LX7VwOVFiNiTZuxRjdLhTZAv/I9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733176920; c=relaxed/simple;
	bh=5WSLZrr4cpLHjqKkEm/8R1dIuaRitNV7ET5lnzqj/Qg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dEQvC3zTm+qDlq9y6Gz0Uhgn5SHt4RxoPpJvSynaGkRc2mcTsYpsJBgdWRJgNLMbeK2EZgXx6IC4iY8a4H2uLKoI2XipmCvGFmOp2tD5MW8QYeWnTYcAKcdyY4l2TIN4/22qKCv1OCkljs4TmqRwBZaVaLtmBDdJ9UKl9Q6ETmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwZqFONQ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7256a7a3d98so1801252b3a.3
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 14:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733176918; x=1733781718; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bBjd2zRNRMMstlgkddP8oAZB6nmjCmlmjYPHCEIfM4M=;
        b=SwZqFONQtm+bPDft+8LysN4RgUtXCgrohs5uRRif12lRqz+QxjgP8FaAsZMt8/qgw2
         AdIhGtQUlWuIc7slE/iLDb/h6Se+qyPKdaBx1uGh+pCR/39q6czuWvvOhMH5ODuIwnr/
         qzdFDtSy/uRzWkM4I/pyXP2mrvLeI4oOKsNP0lm2vJPjUDs5RmPu0m+Njn1TSb/AsuPJ
         TRytqYGHYHO37mJgyO1FBdYdp/5QpVBV9IiC7W1dLcw48EMLltqQwk6i1gSOW2RaQOHE
         KcIuKsEhw9D9QCZq22cEOpgrZtN+XItJN8NUmNzB7oBUFcG4FfKdKm78xQEBl/N+ypRY
         uY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733176918; x=1733781718;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bBjd2zRNRMMstlgkddP8oAZB6nmjCmlmjYPHCEIfM4M=;
        b=n4CN9LyYZRFWXr7tF6LfGwoknTNL5TW/69DAldJXiaffrTZB7oNpsmyArufQsSoLCs
         BiC/HNZq1SiewYHnu4HxbZ2czFiTcdaLJmo8UOoNgWiCFW6E7XFf9a0xACj8NpaNIV3N
         f88K+VGqjT2k+s9aemQN35EZVqVj0w0KubpAq0ourXIdlQmLkFKV1b3X0nvtcAOOjBWB
         85NnwUHRlkBtsEQE2cukUMRIhMvuWysw6JbhU7HY8tsznwixynMkdZ/y+ZtYpZ6b2OQD
         GwWqIod0QBdhGdSSsyTcm/dyzagTY7Gl9N99B69zb9c7oYMz+xHWRdgrTXJxPA+MfG+S
         ZtGw==
X-Forwarded-Encrypted: i=1; AJvYcCU4KI8UDQWeyddTbgwaINcfO0U+9AMy/BhPDaMSYIkDBPSi1PaU+fObgT7fF8/chL9yIxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzglwY30fvVgNxeCxwvL4JCB2izZG/7CCL9s6/z5moEahMfMeEM
	78dpP2m4Ub5vGa6yEPrUQUGwHehMs4qsDfJwAFA7t0rkPAzcGhZn
X-Gm-Gg: ASbGncvS79j/Ff/xyG0PhYLo2He2iwVjz8D00JCl0N/p5YB+HuMi/eP0nyyujS6jq5a
	AlA7k0MaE5PJYVPPfJQMTK3AAYB42VvgGKt9BoQvs26QRRo9D0LdtL9hfgAHEFzjmBwcHNlQksb
	OCYNB5nMp0dq8WY0TmwkbDuar//XmJkPw+ycAIcNm7iIbwo29+OM3xlcuvvz1FHKsRX7KES/XhA
	4uo+el+vAeOdhFBZRvTLWSv6St66zORhJEM1ltWF//hHpk=
X-Google-Smtp-Source: AGHT+IErf8a9cxGtm9r58XfvFL6ffLeK85wxFG38/uu+HLBf9E8nx4+oXXjLiRp4Jm8/W1k2EZGcxw==
X-Received: by 2002:aa7:88c3:0:b0:71e:db72:3c87 with SMTP id d2e1a72fcca58-72530103f57mr38769146b3a.20.1733176917088;
        Mon, 02 Dec 2024 14:01:57 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725418149absm9318467b3a.146.2024.12.02.14.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 14:01:56 -0800 (PST)
Message-ID: <86da73e3700275da6f3fa845baf83c52bd46508c.camel@gmail.com>
Subject: Re: Improve precision loss when doing <8-bytes spill to stack slot?
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Mathias Payer	 <mathias.payer@nebelwelt.net>,
 Meng Xu <meng.xu.cs@uwaterloo.ca>, Kashyap Sanidhya
 <sanidhya.kashyap@epfl.ch>, Lyu Tao <tao.lyu@epfl.ch>
Date: Mon, 02 Dec 2024 14:01:51 -0800
In-Reply-To: <CAP01T768+4FkNC=nw6qnUP3NqQ3+0G_O+LLbMnyWQpkW100RNg@mail.gmail.com>
References: 
	<CAP01T768+4FkNC=nw6qnUP3NqQ3+0G_O+LLbMnyWQpkW100RNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-02 at 09:32 +0100, Kumar Kartikeya Dwivedi wrote:
> Hello,
> For the following program,
>=20
> 0: R1=3Dctx() R10=3Dfp0
> ; asm volatile ("                                       \ @
> verifier_spill_fill.c:19
> 0: (b7) r1 =3D 1024                     ; R1_w=3D1024
> 1: (63) *(u32 *)(r10 -12) =3D r1        ; R1_w=3D1024 R10=3Dfp0 fp-16=3Dm=
mmm????
> 2: (61) r1 =3D *(u32 *)(r10 -12)        ;
> R1_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xfffffff=
f))
> R10=3Dfp0 fp-16=3Dmmmm????
> 3: (95) exit
> R0 !read_ok
> processed 4 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
>=20
> This is a reduced test case from a real world sched-ext scheduler when
> a 32-byte array was maintained on the stack to store some values,
> whose values were then used in bounds checking. A known constant was
> stored in the array and later refilled into a reg to perform a bounds
> check, similar to the example above.
>=20
> Like in the example, the verifier loses precision for the value r1,
> i.e. when it is loaded back from the 4-byte aligned stack slot, the
> precise value is lost.
> For the actual program, this meant that bounds check produced an
> error, as after the fill of the u32 from the u32[N] array, the
> verifier didn't see the exact value.
>=20
> I understand why the verifier has to behave this way, since each
> spilled bpf_reg_state maps to one stack slot, and the stack slot maps
> to an 8-byte region.
> My question is whether this is something that people are interested in
> improving longer term, or is it better to suggest people to workaround
> such cases?

I'd start by trying to measure how much precision we leave on the table.
E.g. modify fixed offset stack read/write routines to count the number
of aligned u8/u16/u32 reads/writes, expose this information in
verifier statistics, aggregate it in varistat, and then run on the selftest=
s.
Of-course, the test cases are tuned to be verifiable, so the signal
would be biased, but still, u32 is pretty common in the source tree.

As Alexei says in the sibling thread, there are multiple ways to
integrate u32 spill/fill tracking, e.g.:
- treat bpf_stack_state->spilled_ptr as a union of 64-bit register
  or two 32-bit registers;
- treat u32 writes as 64-bit writes that don't change tnum
  representation of the other spilled_ptr half (but invalidate the
  range information).

The former seems to be a cleaner approach, but would need more work
(and might benefit from [0] to save some space). The latter seems
easier to implement but might frustrate end user by having different
tracking power for u32 and u64 values.

Do you have some specific implementation in mind?

[0] https://lore.kernel.org/bpf/ZTZxoDJJbX9mrQ9w@u94a/


