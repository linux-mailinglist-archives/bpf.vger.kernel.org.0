Return-Path: <bpf+bounces-73693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA569C376E3
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 20:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B967189E726
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 19:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8E8314B74;
	Wed,  5 Nov 2025 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9sJtu6b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BC02C11CD
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369694; cv=none; b=V5YYNkItxq5M3y7TOn8RZ17KuFND69iPphrwtQECZ+cDWYXIgLlMQKHCpKTqr+3JEKxIinHKImsDP6WHN8LI4sND6Ez0ptgGYwR2MgyCKsUKq9id911O0EJu2ZjGH6ILxd0J4qShaYE9EPSoZRFX5+F2KcUxHNK3nUidG0GG1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369694; c=relaxed/simple;
	bh=b2Kf6t/fW+MZZmxKG9YZjfPsSp7oLP1jmU9Vrkk3HUw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rhWDk32GokQRkqpPF8fOO/ll2LOyFMYmAesRiEz8rfeq217qjX+oViC20A1wgahzWGRfBpriYb1TZDPakGHieUA6RcvN4pMEI61CO1mjDbKweWSrZSVJ3cfQf8U+mT7OE9J9e3tG+wzGJLcBmjsOfYaLNNSYCgYoflh6Olg7Zew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9sJtu6b; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27c369f8986so1831335ad.3
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 11:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762369692; x=1762974492; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XTVG0T6LYwkzsGGYIZw6XRuf3SdiqVqdYm81QePLchU=;
        b=K9sJtu6bmGiHbZ9WkoEJQPEu9cDjysuiTmLDtVXIHhjSUMGrh8hsECJIDAb9yo4MYa
         7PPHm/jsZ+ih7b4LVIupv6irnCfhE7sGWyI2iYeviDBJsKJ3piuDLq52Rb6c5CJ0UQbZ
         r6uumiCXMFdfNrxmg0o/HhErk3bYljuRid7K3Uu36ZM/u0EINu8uYa5Qe8Ft5Xr2N38f
         uYGeno9aO343mcYNJhZ6AIy6lJn2oo+I7KAgWbYcAhNdyRLElOm6TQmeG60ilSxfTvh8
         BS4LDXFWeSXi8n9O0jQWjrSMxQJlt0sPIScxsrBAJkmFKpVDb0MburIcJNfjsnZV76J2
         hLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369692; x=1762974492;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XTVG0T6LYwkzsGGYIZw6XRuf3SdiqVqdYm81QePLchU=;
        b=gmlYIAxpqzHtCIXaBQlFyceUTiKZyUbYq5IfBKixQ7oXW/q6rFAtQicldl8PAiulKP
         wVBdeMcylXcwzDPzSBr+cLierwvMPZt6EL2NrieRY6HanshZXxl+0QKgkFyQPasWJ2oX
         DRXlMvdnzSeos7w6da1A+cUCVbVSzWh49gCdqElTxbMmryy2bNkaWErA6IXqW/sFsBIB
         jiINsOt645v686kOInvwWUlSR2iPUBbnU5dWOAz1LE2jxfEtdp7V7Dngw00Yi+837o23
         UmB8Mn4D/+YDgg6bL/iMjRFoLfbY3PQhOBODIaFYEgH2RlCBPCxslGGhEc3jVLjLwgE9
         KeDg==
X-Forwarded-Encrypted: i=1; AJvYcCU+KRNO6tE7Gzf7/GyO24BGNHubQkuu5PNLl5NXDfqy1kNuKXNer5aOywZaxcNUzYSmj1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGrkht7fBihya9zf3zOGkvEI9v5M7ALfH2WQMHEbI8G9GzPcNb
	DqStlcavWPsok+8Mjojjvqye1DIC43qKyew6rhtAux2Xg6cPKboIPATu
X-Gm-Gg: ASbGncv5a8BjKOXUNvhy7viwKSJMocx+UUtHDLgZagz928/mfMfqcUAcyt3E0cwjDfA
	k5MdMv7wn/MeFUZB6E56GWp+64KgpOupggsJyMk8Bhkmh91UpxqNMZgA5sQQdZMaMqT3Kb0P1Xj
	euFNlRvw2qWmPGM7Xrh4SlbA5HjSpuD7XESkqGoQnIOe0mYhGZOtndkmx3XpsdibhfTejhipbvD
	wBkwi9gc0MvhPY64PGzP5q+zGLOY8oGfAVEtJJpBUNpsoj+oZF+dVHj5LF0Rc0MJnCz03arLhqF
	6TUkUTrGAYAuFJMnqRYJA6ULZFPR1lpmQLBPj17TQqD4HxN1GrDnz722AzOgumevwFt4RXOzwlx
	GtAVVx2es/nDfQ24iUxYbohYUkKpWhxMEFVMLaNYtLhP4RhpYI1OzsyYFq9j4P5y8QeoQpwwxKn
	aZbmmHzjFiNz8A+6nicKLpu583elmL2GlQMcc=
X-Google-Smtp-Source: AGHT+IGrXHt8SeACynriOm61BKCSi+bo8IlbMXNNk0e26iQ7ocsiftgpy9nshNfQwBVY9v4+8KVMpg==
X-Received: by 2002:a17:903:1a87:b0:27d:69de:edd3 with SMTP id d9443c01a7336-2962ad1f02emr70906185ad.20.1762369691559;
        Wed, 05 Nov 2025 11:08:11 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:cdf2:29c1:f331:3e1? ([2620:10d:c090:500::6:8aee])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5f94fsm2934505ad.40.2025.11.05.11.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:08:11 -0800 (PST)
Message-ID: <c571ab7af853a3f775be3a518f99ec809f49797f.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/2] bpf: properly verify tail call behavior
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin Teichmann <martin.teichmann@xfel.eu>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org
Date: Wed, 05 Nov 2025 11:08:10 -0800
In-Reply-To: <20251105174031.2801707-1-martin.teichmann@xfel.eu>
References: <ec29fa64723036f672afd18686454d02857ea4e9.camel@gmail.com>
	 <20251105174031.2801707-1-martin.teichmann@xfel.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 18:40 +0100, Martin Teichmann wrote:
> I added the changes you proposed.
>=20
> regarding bpf_insn_successors(), nothing needs to be done, call
> already have the next instruction as successor by default, and this
> is all we need. The fact that a tail call can also be an exit in
> disguise is handled by calling bpf_update_live_stack().

Consider the following scenario:

main:
  int a;
  int b[10] =3D { 1, 2, ... };
  if <random>:
    a =3D 100500;
  foo(&a);
  return b[a];

foo(int *a):
  tail call;
  *a =3D 0;
  return;

W/o bpf_insn_successors() knowing that tail call can jump directly to
return, verifier will assume that write to *a always happens, and
accept the above program.

While trying to create a reproducer for the above scenario I found an
issue with current patch-set and precision tracking.
Consider a modifier version of you test case:

  SEC("socket")
  __log_level(2)
  __flag(BPF_F_TEST_STATE_FREQ)
  __naked unsigned long caller_stack_write_tail_call(void)
  {
        asm volatile (
        "r6 =3D r1;"
        "*(u64 *)(r10 - 8) =3D -8;"
        "call %[bpf_get_prandom_u32];"
        "if r0 !=3D 42 goto 1f;"
        "goto 2f;"
  "1:"
        "*(u64 *)(r10 - 8) =3D -1024;"
  "2:"
        "r1 =3D r6;"
        "r2 =3D r10;"
        "r2 +=3D -8;"
        "call write_tail_call;"
        "r1 =3D *(u64 *)(r10 - 8);"
        "r2 =3D r10;"
        "r2 +=3D r1;"
        "r0 =3D *(u64 *)(r2 + 0);"
        "exit;"
        :: __imm(bpf_get_prandom_u32)
        : __clobber_all);
  }

  static __used __naked unsigned long write_tail_call(void)
  {
        asm volatile (
        "r6 =3D r2;"
        "r2 =3D %[map_array] ll;"
        "r3 =3D 0;"
        "call %[bpf_tail_call];"
        "*(u64 *)(r6 + 0) =3D -16;"
        "r0 =3D 0;"
        "exit;"
        :
        : __imm(bpf_tail_call),
          __imm_addr(map_array)
        : __clobber_all);
  }

Currently, it hits the following error:

  10: (79) r1 =3D *(u64 *)(r10 -8)        ; R1=3D-8 R10=3Dfp0 fp-8=3D-8
  11: (bf) r2 =3D r10                     ; R2=3Dfp0 R10=3Dfp0
  12: (0f) r2 +=3D r1
  mark_precise: frame0: last_idx 12 first_idx 10 subseq_idx -1=20
  mark_precise: frame0: regs=3Dr1 stack=3D before 11: (bf) r2 =3D r10
  mark_precise: frame0: regs=3Dr1 stack=3D before 10: (79) r1 =3D *(u64 *)(=
r10 -8)
  mark_precise: frame0: parent state regs=3D stack=3D-8:  R0=3Dscalar() R6=
=3Dctx() R10=3Dfp0 fp-8=3DP-8
  mark_precise: frame0: last_idx 19 first_idx 15 subseq_idx 10=20
  mark_precise: frame0: regs=3D stack=3D-8 before 19: (85) call bpf_tail_ca=
ll#12
  mark_precise: frame0: regs=3D stack=3D-8 before 18: (b7) r3 =3D 0
  mark_precise: frame0: regs=3D stack=3D-8 before 16: (18) r2 =3D 0xff11000=
109035000
  mark_precise: frame0: regs=3D stack=3D-8 before 15: (bf) r6 =3D r2
  mark_precise: frame0: parent state regs=3D stack=3D-8:  R6=3Dctx() R10=3D=
fp0 fp-8=3DP-8
  mark_precise: frame0: last_idx 9 first_idx 9 subseq_idx 15=20
  mark_precise: frame0: regs=3D stack=3D-8 before 9: (85) call pc+5
  verifier bug: static subprog leftover stack slots 1
  processed 16 insns (limit 1000000) max_states_per_insn 0 total_states 5 p=
eak_states 5 mark_read 0
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This happens, because __mark_chain_precision() moves from a history
entry with frame index 0, to a history entry with frame index 1.
backtrack_insn() assumes that such changes are impossible, because
there always would be an EXIT instruction for a subprogram, where it
would adjust bt->frame by +1. Which is not the case with patch-set.

So, one needs to track frame index in struct bpf_jmp_history_entry,
or fake a jump from tail call to EXIT, instead of directly leaving
subprogram.

After that is resolved, I think that bpf_insn_successors() issue
described above will manifest itself.

> In total, this patch now fixed three bugs: a regression wheras
> programs that modify packet data after a tail call are unnecessarily
> rejected, proper treatment of precision propagation and live stack
> tracking.
>=20
> Martin Teichmann (2):
>   bpf: properly verify tail call behavior
>   bpf: test the proper verification of tail calls
>=20
>  kernel/bpf/verifier.c                         | 26 ++++++++--
>  .../selftests/bpf/progs/verifier_live_stack.c | 46 ++++++++++++++++++
>  .../selftests/bpf/progs/verifier_sock.c       | 39 ++++++++++++++-
>  .../bpf/progs/verifier_subprog_precision.c    | 47 +++++++++++++++++++
>  4 files changed, 153 insertions(+), 5 deletions(-)

