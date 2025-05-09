Return-Path: <bpf+bounces-57870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EBFAB1AE3
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 18:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AA9501695
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 16:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C592C2367DF;
	Fri,  9 May 2025 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsrO3R38"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909B5F9C1
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746809477; cv=none; b=UqV4F6EDh+OSSh2WaChHS6S4OLqhyoRhlQeaQtme65QWhsVgOT2Dqyx51Z2p3N0EOrnfhcnk7CMv7xMcRijgYqyYFC5z2GuTZxtVfO1eXt4a7SdIyoQdHgVMjdOlald+3cTVthiSgP+70kXeSZcc/7+nLhaZPBLpg+ZFPU1MMFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746809477; c=relaxed/simple;
	bh=E1aKUNVu5gOmNFnC1DhtiPE0HgYTSz1URgkQlc+nzj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8oVoREaZQlBvYSkjqaxcFARuQPeCmV9PryWeSp0HpPELu8Y2axkFNfeGuaTzF+JMp1b2v3YJEC9RHn4pS8DAoUNm9+VMiCQ65+yx4e5s+KS1dS5TgRDY7XeGAFDDcbQKMTv4HaZSzM8CrVDIWdK/+xxvsdlcjUHeXrVchLUAvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsrO3R38; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so24659885e9.3
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746809474; x=1747414274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVH46qfX+JOXsh2TaIe0nMV6RT+fa3rQegZmUAwilms=;
        b=KsrO3R38qCqCnXerhve9m2bnyuO5+VYc5zs+7m30m7D9iVf0S8vZLdZNQrej9H1QNf
         qBFOe7sI+FRFcxfmDzbMqz61qArcMlJs8KVbnoypvLnXJuMqGaC4cKltwqGQo10GK+UG
         75ffF1K8RtmN1Dy5HOP61DV+ylzEfE8iMxZ+j4JvCoAzHEdJCAproZYBSL3nw2vhKYiV
         2veG5ue/nqLHo+6+HqTxM4H1NO2XTvZ7e1hMa8uXUHb90huyj5Q5YVrTmDF1rcvgAj0P
         F6JRyoOuES2G2Ko16CBpG8vYBDxeZlWHXiyaITDhVFpbxxZIHLkaKJyD/I+Fr3UQENu3
         wW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746809474; x=1747414274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVH46qfX+JOXsh2TaIe0nMV6RT+fa3rQegZmUAwilms=;
        b=i6JByFyYwJWYFZFOEElHFtEd3BWiAz9xIz2SNhydLrZ4vTSL17sRXuwrnaiBoKiQMB
         uGJoRp2/h8LOWfVf+gUS3UQLRU3qlwddergv+MxrwwzDIOCn69aRAWz1zV4hfRMZ0Crr
         d5DoAxOTfNpwOr95r+xON/8ABDmKSo/Zrf8m9fdbF66GJBHjcuwS0/rgemTON7wn0jKs
         69AZId7SMv3cIHxFO/7u/w2AhY6cKTtn7jAW9v/TIE9R4Y+GEFM3xoEAiE1n9xJD/nIW
         TpwVxD1oeTnhuPxzxh97rZqGQHI/6OqRMY96JMhnEPp/h5CNynr7xjQGHtcANYVRI1KP
         JYRw==
X-Forwarded-Encrypted: i=1; AJvYcCUY7X/3wRldSeu8jxwLwESfGSBhvVPiXBlLpmL6ncSQ3JNDFaCqgNdNnrQlitfGwdT9rWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMegll3ymbte8UpTe9QypINjJ+vBjNyc2DJcBDcxYq/YP4j1cC
	AbE4BE+pV2uqrnbkfkJN2dgxzC5Y73vvduWCDE5XJ1k98VBFqfstZgvYwXMaAxLwyquf+SzpWCj
	bk6J1wDWAF+B+GlySUe+u0e8OI/k=
X-Gm-Gg: ASbGncv1SHn7KcgP3jIoYZVZoKnO/xRX1WN1cIegdkexZ1SqL5WgR+yUuSNnaYwGO50
	R8eKn86CXMZ8mV5bF3ja7ha/L1s4zdBsbveZFOUTBD0yt5zlOggqcOQm+jYs4hasXNrs5CeG0og
	T9iH1Gw1bQQcJHgJWoK9pBM7Hq7kJx18s8uKQSDw==
X-Google-Smtp-Source: AGHT+IGwCAOJDZOrrbPl/TxzoTpsmOFpOHEBSjd2Vi5/PiwqwTJNUE9cJ1+5M9N2kd6NILhzjcR5eMe8Ot5o+9PGkvY=
X-Received: by 2002:a05:6000:2289:b0:391:3406:b4e2 with SMTP id
 ffacd0b85a97d-3a1f64ab40emr3219771f8f.49.1746809473686; Fri, 09 May 2025
 09:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508113804.304665-1-iii@linux.ibm.com> <CAADnVQ+kGcRrLOaA5ic6cYG+1vHJm0bBD1GRfUaYpaOGa3Vx0g@mail.gmail.com>
 <15bf9a71b8185006c8d19a3aefb331a2765629c5.camel@linux.ibm.com>
In-Reply-To: <15bf9a71b8185006c8d19a3aefb331a2765629c5.camel@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 May 2025 09:51:02 -0700
X-Gm-Features: AX0GCFtCJdYMbzVyljbd5Q_1G15HFkBpun-o8GSncsn3WLxjH7j-UDFynFt2RX0
Message-ID: <CAADnVQL6Q+QRv3_JwEd26biwGpFYcwD_=BjBJWLAtpgOP9CKRw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix "expression result unused" warnings
To: Ilya Leoshkevich <iii@linux.ibm.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 12:21=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> On Thu, 2025-05-08 at 11:38 -0700, Alexei Starovoitov wrote:
> > On Thu, May 8, 2025 at 4:38=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.=
com>
> > wrote:
> > >
> > > clang-21 complains about unused expressions in a few progs.
> > > Fix by explicitly casting the respective expressions to void.
> >
> > ...
> > >         if (val & _Q_LOCKED_MASK)
> > > -               smp_cond_load_acquire_label(&lock->locked, !VAL,
> > > release_err);
> > > +               (void)smp_cond_load_acquire_label(&lock->locked,
> > > !VAL, release_err);
> >
> > Hmm. I'm on clang-21 too and I don't see them.
> > What warnings do you see ?
>
> In file included from progs/arena_spin_lock.c:7:
> progs/bpf_arena_spin_lock.h:305:1756: error: expression result unused
> [-Werror,-Wunused-value]
>   305 |   ({ typeof(_Generic((*&lock->locked), char: (char)0, unsigned
> char : (unsigned char)0, signed char : (signed char)0, unsigned short :
> (unsigned short)0, signed short : (signed short)0, unsigned int :
> (unsigned int)0, signed int : (signed int)0, unsigned long : (unsigned
> long)0, signed long : (signed long)0, unsigned long long : (unsigned
> long long)0, signed long long : (signed long long)0, default:
> (typeof(*&lock->locked))0)) __val =3D ({ typeof(&lock->locked) __ptr =3D
> (&lock->locked); typeof(_Generic((*(&lock->locked)), char: (char)0,
> unsigned char : (unsigned char)0, signed char : (signed char)0,
> unsigned short : (unsigned short)0, signed short : (signed short)0,
> unsigned int : (unsigned int)0, signed int : (signed int)0, unsigned
> long : (unsigned long)0, signed long : (signed long)0, unsigned long
> long : (unsigned long long)0, signed long long : (signed long long)0,
> default: (typeof(*(&lock->locked)))0)) VAL; for (;;) { VAL =3D
> (typeof(_Generic((*(&lock->locked)), char: (char)0, unsigned char :
> (unsigned char)0, signed char : (signed char)0, unsigned short :
> (unsigned short)0, signed short : (signed short)0, unsigned int :
> (unsigned int)0, signed int : (signed int)0, unsigned long : (unsigned
> long)0, signed long : (signed long)0, unsigned long long : (unsigned
> long long)0, signed long long : (signed long long)0, default:
> (typeof(*(&lock->locked)))0)))(*(volatile typeof(*__ptr) *)&(*__ptr));
> if (!VAL) break; ({ __label__ l_break, l_continue; asm volatile
> goto("may_goto %l[l_break]" :::: l_break); goto l_continue; l_break:
> goto release_err; l_continue:; }); ({}); } (typeof(*(&lock-
> >locked)))VAL; }); ({ ({ if (!CONFIG_X86_64) ({ unsigned long __val;
> __sync_fetch_and_add(&__val, 0); }); else asm volatile("" :::
> "memory"); }); }); (typeof(*(&lock->locked)))__val; });
>       |
> ^                         ~~~~~
> 1 error generated.

hmm. The error is impossible to read.

Kumar,

Do you see a way to silence it differently ?

Without adding (void)...

Things like:
-       bpf_obj_new(..
+       (void)bpf_obj_new(..

are good to fix, and if we could annotate
bpf_obj_new_impl kfunc with __must_check we would have done it,

but
-               arch_mcs_spin_lock...
+               (void)arch_mcs_spin_lock...

is odd.

> It started today.
> Here is the full compiler version:
>
> $ clang-21 --version
> Debian clang version 21.0.0 (++20250501112544+75d1cceb9486-
> 1~exp1~20250501112558.1422)
> Target: s390x-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /usr/lib/llvm-21/bin
>
> Best regards,
> Ilya

