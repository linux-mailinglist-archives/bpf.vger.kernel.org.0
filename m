Return-Path: <bpf+bounces-45950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE359E0CBB
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 21:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8049F165571
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 20:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467B91DE893;
	Mon,  2 Dec 2024 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7xjkTCv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDFB1DD863
	for <bpf@vger.kernel.org>; Mon,  2 Dec 2024 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733169811; cv=none; b=nD1drMhW9w6vyAQqMfMR93qNMd7Ma80oCwIcv+ZkhSQmQKjQpgRuufU3opU7tfwDaRrj39BbPnvu5CacLvRQIRb+Nxzl+3BJMe+BYpcHzQ1Si299cRTMNSO9dni1vmjVWBjrMtXvN5k4EJl/dHKQCFhVHNbDhTFhdskrCT55Yxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733169811; c=relaxed/simple;
	bh=R3sLE2paJtfoSpmD5nxVmPBCiuxP10ehZXz0alPlZ8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WS19Ew8s6PvSZUiNoTgqypaBTjgY6uCFfiXIbXJnWbt9c46K4Zh2IgnUjkjnQyRxRQjma2W2WSjVn7OhyKYQqhPyodEatSqJS4CDXn1H/96D2n4D33g+XqEporoZbOVC8s/ELUuIRVe05ibj7P0w0YxAbgz1qCWX0kpRyoTOpwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7xjkTCv; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385de59c1a0so3325053f8f.2
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 12:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733169808; x=1733774608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pu5fku6yZw1mhfm6TGAL7GjUFYumCDdtrRSQVcItkGA=;
        b=c7xjkTCvErNCQZoFjFxFT/zZfk3aZ9sy2UDoVE3irhE1gyNK2xbX+QdYSsLiP0Dthm
         Nsmh+1uI1PVh8aIv4amCdOXzoxHlBRfz3ILb57BOBxP+fd2dafgR76t4W8x+JiUvTBNX
         bqfJY10F/xpdKnDf5is9h911Tu9eiZfaNlCz660vz4pGllVfbCZZK+gSgDh0Ato0QOWD
         vRLZifsYO5+xK52EudH/7N/LEzbeb5Jxc5JZlzMGhxaZf9bGLDwowuIdngsqy418wzNu
         vlR0/NaSy72motEKHnLrm1sb0yDzhacos8zXwF4og793Rfu3Kc9xbLsYhoDY7k/MvYVA
         kAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733169808; x=1733774608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pu5fku6yZw1mhfm6TGAL7GjUFYumCDdtrRSQVcItkGA=;
        b=TLx1yEh932WHreR+YT6TJalHYlysMJmkfv5WwYOEEus0SGCGqjmvXQXfK6D2kJ6MYy
         lmYOIe1qRrrj8WZntfsOTFM3uX85TcYpq50s9PMqsAUWeJk0mlRg9SStGOHDM/05YI9Q
         f4OoAwI/qOFoyBu5svNRlH4RM279q+OF5FPNyAy8Gr8IDqnTptc2xW7pXn5pyG2NLlmo
         rsxGvBSL/lRhI76bpa0hG9D9baJEVSHrZCEMyypp+HD2YiKFX8q++GtXlTqtL1NAR4ar
         /9cqzCPMbSoK6uBv/LxGMDmhOJdBblhucFEFjWx/u2vzCsNS0KFfYEG04Iq1cMkGAPd5
         AMIw==
X-Gm-Message-State: AOJu0YxOQOAZcjMZg6xE1VUhA+HREXbwf4dpMUpoHxVXudetdcWN6mm9
	mJ5CEldnI3i3xYPqCZFFSXnHMVt51tpoyLTbl77mM2iUvwvQ9hPqTIAO/CYh5fM68S/t1RYk0PI
	e/irJs6YbVQU4JxG1NagpX64H5d/xGkLw
X-Gm-Gg: ASbGncsi9LHCrqi+BIropMd8qD1IdRBYBBdhoaJS22cK7RogOPPb/pxZAi4C0rQnN1X
	nQsmGkjXXCfDyDffAeIA13qrMu8U+GKnjob7VJUkHldu9+0M=
X-Google-Smtp-Source: AGHT+IHB/DqwqP6DCE8areHI5CKFvjwew+/Zts6Ln7pxC2BrEf3gKnpxE22NOEdWAw3ZCOhNr+SSf2rqcH+1ebDaWkE=
X-Received: by 2002:a05:6000:2a1:b0:385:e3c1:50d5 with SMTP id
 ffacd0b85a97d-385e3c15410mr7419831f8f.48.1733169808100; Mon, 02 Dec 2024
 12:03:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP01T768+4FkNC=nw6qnUP3NqQ3+0G_O+LLbMnyWQpkW100RNg@mail.gmail.com>
In-Reply-To: <CAP01T768+4FkNC=nw6qnUP3NqQ3+0G_O+LLbMnyWQpkW100RNg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Dec 2024 12:03:16 -0800
Message-ID: <CAADnVQLY7Vy8SrF-cWzY0bG3zQ-DWsncghwb08nOOahbaFJMmw@mail.gmail.com>
Subject: Re: Improve precision loss when doing <8-bytes spill to stack slot?
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Mathias Payer <mathias.payer@nebelwelt.net>, Meng Xu <meng.xu.cs@uwaterloo.ca>, 
	Kashyap Sanidhya <sanidhya.kashyap@epfl.ch>, Lyu Tao <tao.lyu@epfl.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 12:32=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Hello,
> For the following program,
>
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
>
> This is a reduced test case from a real world sched-ext scheduler when
> a 32-byte array was maintained on the stack to store some values,
> whose values were then used in bounds checking. A known constant was
> stored in the array and later refilled into a reg to perform a bounds
> check, similar to the example above.
>
> Like in the example, the verifier loses precision for the value r1,
> i.e. when it is loaded back from the 4-byte aligned stack slot, the
> precise value is lost.
> For the actual program, this meant that bounds check produced an
> error, as after the fill of the u32 from the u32[N] array, the
> verifier didn't see the exact value.
>
> I understand why the verifier has to behave this way, since each
> spilled bpf_reg_state maps to one stack slot, and the stack slot maps
> to an 8-byte region.
> My question is whether this is something that people are interested in
> improving longer term, or is it better to suggest people to workaround
> such cases?

I think we need to consider improving the verifier if we can
come up with a reasonable path to implement it.

The stack_state memory consumption can be mitigated as:
 struct bpf_stack_state {
        struct bpf_reg_state spilled_ptr;
+       struct bpf_reg_state *spilled_ptr_off4;
        u8 slot_type[BPF_REG_SIZE];
 };

but I suspect plenty of code would need to be touched to support
such spill/fill.

And then the next question is whether support for u16 is needed too.

Without seeing an actual code it's hard to judge whether full bpf_reg_state
is needed with tnum and ranges.
It may be the case that only constants are needed to be tracked.
Then we can approach it from the angle of generalizing STACK_ZERO.
Like replace STACK_ZERO with STACK_CONST_VAL and let every byte
remember the actual value written.
 0: (b7) r1 =3D 1024                     ; R1_w=3D1024
 1: (63) *(u32 *)(r10 -12) =3D r1        ; R1_w=3D1024 R10=3Dfp0 fp-16=3Dmm=
mm????

will populate four constants 00 00 04 00

and *(u32 *)(r10 -12) will read it back as 1024.

Pretty much what mark_reg_stack_read() is doing today
with a special case of zero, but for all u8 consts.

