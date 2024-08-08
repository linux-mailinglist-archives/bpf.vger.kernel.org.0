Return-Path: <bpf+bounces-36690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150D294C2CB
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 18:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3FFBB26217
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 16:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12DE190068;
	Thu,  8 Aug 2024 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQ1vqVw9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8EC18EFDC
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134826; cv=none; b=KxfX4IGmcrBTFyCdNHYTNZqyFS1PQqMa5JtxNs586WG63hYNlUCsJwBKBLsDheEV+KQJIlDTdKP0QpFp21WuyYIE9x88p2KYhNY0AztcCQxUVP4UoQ+sT8dDFoCkKJDqh/U02qX4jkXx1Nse6FIayCa3nX4+P7EZHodNgOSx9yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134826; c=relaxed/simple;
	bh=/3R72wJ1A+AGGJP4XCAFzEg+snHwAOrMapYGXpnLzYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJoUQEDrLINGi9puEWVoXttkA5Pdkw1KJhv4yItU+e4ASU5pqWJmP5si4Ytfw3NyaQrz8zeYML41oaEoX5mcySznCg5U+tQr8NFI+4DY7tH0q6r7lihXVg/rpXJziKShrajbVk5IIoLIK2ib4H3OysMvpHOICcJTR1KmVNoSJYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQ1vqVw9; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-368440b073bso712580f8f.0
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2024 09:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723134823; x=1723739623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5gYvgSr3rS0nFox1U76kZVTkVtOUfosQ/tcyQ4wBP0=;
        b=HQ1vqVw9VEWM+HSaRrVDmVKD+j3KpHR1itcDfs2frYqCUIJ7UEEbMFN6DpXx8vrIy1
         4Iybm4McWPGz/m/IlSvn0QD6c4Waa6Z/vi6bZZ3qInkB9w3QiA1qpg9p86nJdjh6stfE
         jl/lRCVxdwUNUjs2wDhD0te8v5fVvMewZhd6iTRWr6fcf3dRF9Nq4a7g2QXpKrTq35fD
         AXxG9rKcuLXP5LYGUo9NHc76T+XOCjBV6P+Br03hRq0rIqwI8nolYaBkZjMZ9fzcpQFP
         EkGGJIV7JplGNZVBS5oQIGO+YZW2yIPpRz1ay9xM9u6w2qsUhYFJ/bnyU09K+r47aYNg
         vkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723134823; x=1723739623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5gYvgSr3rS0nFox1U76kZVTkVtOUfosQ/tcyQ4wBP0=;
        b=Jk40vuDCfFcDzFDBWSB4CCcA3djlkN0yGySXk2wK1vMTQNnH9i3udI9RudGCEmU2zA
         RRXwGCaOsSx/1lMtO43o5NKfwtrf7jIazCiOWuRgy6Rdqnb4RqYmBrRsEmgCzkAmb2dU
         FRqTWt8/Wmiua5uhjuTKANh5IDJM0JiKZ8u2F4yT2IYm4e9Yuj5LW5aDOHCkHM7YuGUW
         noZWowiuUM4/Adcbp0EKiKIfxn/CLeSmtuKd9AiDdOXaiGDyazDRgF9auFdZ6bYMhhpA
         52dvR7EcGqoZ+fRiHYRft11jUX1lOBeWN4qJo8wkW59s3l4bSat3mdpwuyueUpek3uOP
         gyHA==
X-Forwarded-Encrypted: i=1; AJvYcCWfgBzLEEWqs9uy5Zn4ZDFxjaSLQ1aqjWJvsiAroOTfav0sewSr9mlkdegOa6lQ7A1DDikbG1jzR8sIKiPx9aIkGyBd
X-Gm-Message-State: AOJu0YwKRjz4uORwHgStfIkN5G5DVobpP0eDbdmuIIJDeT1WUWEZ6G+k
	t2Qxmb9pTof4Lqwni9tAFkQxlcmtXh8n9fqm1Q0gk1gzFLAUiQnmCOVxYKUjwktIChe0ToBHdS2
	GdddUW8attSG5CUAZUWiesHAgZQE=
X-Google-Smtp-Source: AGHT+IEDHz/RnDaj5wS6EYep1WW2P77kudPb7Glid/sbpmHEuHIM5mCyuQcnYEiPmMMKGJKSo288ZuUa7GUwmFD2mCI=
X-Received: by 2002:a5d:4404:0:b0:366:595c:ca0c with SMTP id
 ffacd0b85a97d-36d28174d64mr1870190f8f.24.1723134822608; Thu, 08 Aug 2024
 09:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729183246.4110549-1-yepeilin@google.com> <CAADnVQJqGzH+iT9M8ajT62H9+kAw1RXAdB42G3pvcLKPVmy8tg@mail.gmail.com>
 <ZrJ3_esc7nBb6k9_@google.com>
In-Reply-To: <ZrJ3_esc7nBb6k9_@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 Aug 2024 09:33:31 -0700
Message-ID: <CAADnVQJDki9GCxDAaGJWb+HrKT2EnzYXM8K3238XxPtHkhU0Ag@mail.gmail.com>
Subject: Re: Supporting New Memory Barrier Types in BPF
To: Peilin Ye <yepeilin@google.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, "Jose E. Marchesi" <jemarch@gnu.org>, bpf <bpf@vger.kernel.org>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, David Vernet <dvernet@meta.com>, 
	Dave Marchevsky <davemarchevsky@meta.com>, Eddy Z <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 12:22=E2=80=AFPM Peilin Ye <yepeilin@google.com> wro=
te:
>
> Hi Alexei,
>
> Thanks for all the suggestions!  Some questions:
>
> On Mon, Jul 29, 2024 at 06:28:16PM -0700, Alexei Starovoitov wrote:
> > On Mon, Jul 29, 2024 at 11:33=E2=80=AFAM Peilin Ye <yepeilin@google.com=
> wrote:
> > > We need more.  During offline discussion with Paul, we agreed we can =
start
> > > from:
> > >
> > >   * load-acquire: __atomic_load_n(... memorder=3D__ATOMIC_ACQUIRE);
> > >   * store-release: __atomic_store_n(... memorder=3D__ATOMIC_RELEASE);
> >
> > we would need inline asm equivalent too. Similar to kernel
> > smp_load_acquire() macro.
>
> I see, so something like:
>
>     asm volatile("%0 =3D load_acquire((u64 *)(%1 + 0x0))" :
>                  "=3Dr"(ret) : "r"(&foo) : "memory");
>
> and e.g. this in disassembly:
>
>     r0 =3D load_acquire((u64 *)(r1 + 0x0))

yes.

> I agree that we'd better not put the entire e.g.
> "r0 =3D __atomic_load_n((u64 *)(r1 + 0x0), __ATOMIC_ACQUIRE)" into
> disassembly.

exactly. That's too verbose.

> > > Theoretically, the BPF JIT compiler could also reorder instructions j=
ust like
> > > Clang or GCC, though it might not currently do so.  If we ever develo=
ped a more
> > > optimizing BPF JIT compiler, it would also be nice to have an optimiz=
ation
> > > barrier for it.  However, Alexei Starovoitov has expressed that defin=
ing a BPF
> > > instruction with 'asm volatile ("" ::: "memory");' semantics might be=
 tricky.
> >
> > It can be a standalone insn that is a compiler barrier only but that fe=
els like
> > a waste of an instruction. So depending how we end up encoding various
> > real barriers
> > there may be a bit to spend in such a barrier insn that is only a
> > compiler barrier.
> > In this case optimizing JIT barrier.
>
> [...]
>
> > > Roughly, the scope of this work includes:
> > >
> > >   * decide how to extend the BPF ISA (add new instructions and/or ext=
end
> > >     current ones)
> >
> > ldx/stx insns support MEM and MEMSX modifiers.
> > Adding MEM_ACQ_REL feels like a natural fit. Better name?
>
> Do we allow aliases?  E.g., can we have "MEMACQ" for LDX and "MEMREL"
> for STX, but let them share the same numeric value?

yes. See
#define BPF_ATOMIC      0xc0    /* atomic memory ops - op type in immediate=
 */
#define BPF_XADD        0xc0    /* exclusive add - legacy name */

but it has to be backward compatible.

> Speaking of numeric value, out of curiosity:
>
>     IMM    0
>     ABS    1
>     IND    2
>     MEM    3
>     MEMSX  4
>     ATOMIC 6
>
> Was there a reason that we skipped 5?  Is 5 reserved?

See
/* unused opcode to mark special load instruction. Same as BPF_ABS */
#define BPF_PROBE_MEM   0x20

/* unused opcode to mark special ldsx instruction. Same as BPF_IND */
#define BPF_PROBE_MEMSX 0x40

/* unused opcode to mark special load instruction. Same as BPF_MSH */
#define BPF_PROBE_MEM32 0xa0

it's used by the verifier when it remaps opcode to tell JIT.
It can be used, but then the internal opcode needs to change too.

> > For barriers we would need a new insn. Not sure which class would fit t=
he best.
> > Maybe BPF_LD ?
> >
> > Another alternative for barriers is to use nocsr kfuncs.
> > Then we have the freedom to make mistakes and fix them later.
> > One kfunc per barrier would do.
> > JITs would inline them into appropriate insns.
> > In bpf progs they will be used just like in the kernel code smp_mb(),
> > smp_rmb(), etc.
> >
> > I don't think compilers have to emit barriers from C code, so my
> > preference is kfuncs atm.
>
> Ah, I see; we recently supported [1] nocsr BPF helper functions.  The
> cover letter says:
>
>   """
>   This patch-set seeks to allow using no_caller_saved_registers
>   gcc/clang attribute with some BPF helper functions (and kfuncs in the
>   future).
>   """
>
> It seems that nocsr BPF kfuncs are not supported yet.  Do we have a
> schedule for it?

Support for nocsr for kfuncs is being added.
Assume it's already available :)
It's not a blocker to add barrier kfuncs.

