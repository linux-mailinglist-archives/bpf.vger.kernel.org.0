Return-Path: <bpf+bounces-30357-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFFE8CCAC3
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 04:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3759D281EC1
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 02:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF0913AD31;
	Thu, 23 May 2024 02:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7R9Jhi1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CF213AD0D
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 02:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716431531; cv=none; b=kmKrbTH3UQMrNgVu/uhrVs7EU+fPBWgyJRBXGP0jC0eDudlW5ZoYoe+Ersn1zrvlab6w/oVsmM6vKHKZMlXh3U548x7tC1w1Kw+pUjazBFcWdVu5zt+WW3mi6exeYufKMJTECnna7j7O/49g00GAPgnw0rzd1/maJQJClmg3OQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716431531; c=relaxed/simple;
	bh=oF1bWw2URxXrpYBpVRIgUnmX4mZEmq50YtKBNSTcwgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qC0V8KiXDf+5n3C0kNMs9WM0tBp3UdF0K9UazKsar43N1CaYgSq3JLX8XDtBHfOU/Y0DNUXT49dhY6zT4J5JTJNInyhI4dwd1rFDfZ+R8TeLLSBBhp00VehxuK7VJ74r8+D8CqxGiQBB9CjQ5k2AH+cA65hX03qqEcNAd1pWTVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7R9Jhi1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-354f8a0cd08so450985f8f.2
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 19:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716431528; x=1717036328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sz3lWCUar1jpVGocpj1Lgnbxz6jeZMljCIFx4rYuFDo=;
        b=k7R9Jhi1DXzk2Fp9TQ4UiM70HUISVk6C8RpgthUdjeewu2KDh0UJMk+cRtONPwwyy2
         0LuXtdnG4nMC6DsPPZCLAB8dVUGyu0yAPLk1gYKf5WqYklWBK+DtJGPiE1/6O3gb+4z4
         0aG6kgLkQpJbx+Uj+STTVQhf+/aMiW6vo7x9sNBd+o9n+S5AQpS7luIlf5RT4irn6WdD
         kwc/XzJ484MjWnvICWzywl3V6R9hC6i5rNE6rg1jkqHmqlSaeT5PdXqJdjbRJobRONew
         6l4rdEW18gJsUdDnnJvUdadgb4i3UHuM/3k85EnYUdI5jnPze/cxNgWwu2KXCdyrmY5w
         BZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716431528; x=1717036328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sz3lWCUar1jpVGocpj1Lgnbxz6jeZMljCIFx4rYuFDo=;
        b=HxC21lh0sPqmzaSyK8fhwbh9dPBUfQFEaGO2ey48Dzcnt9ZOAi38HNDZwBXktpjRtv
         hBw2S3dpaUA4JRaIGF9mJRrPjbKWyfvKEHInP9WD8hx7FRTI0yA1CYogsf5RMeeW29MB
         gRiV46045CwbvrbTYZQc57FlHPgQOE2GHPpDOnpzHsmVSsprDBnkNRWrx2i7Qn5/6ykr
         /1KH1VHbd2R99ILqX98YfIag/9CTFGJWTj4yXUIao1WxnXJhEbUcXhz2XEB+S26aj3Z5
         FFHvm5bc9Wyhrklv7KI79jZ4asON6wximRAg+RumeDBhTHNTiJ5QlWEW6qds2x11tAkE
         I7+Q==
X-Gm-Message-State: AOJu0YzEFg3aNIGPg3bN/3tj+YizsL6y5DgveOhQ4ZUF8pJK4XrUM9Lj
	pePlZ25Z6mv7xvpR0c5ZvgdkwuhWdDLu69h/33MwLpeMXK+GiDqM5lcykWc9+fgdPCkEbjajEmu
	PBhb/tL0lx2sY0BvJoeRxX5Hfmpo=
X-Google-Smtp-Source: AGHT+IH91P3Wt0vkfopQDpnu9WIflJRJVYIpmLl8d3mWopH4B7+ALDAv4xLO5n40pF636Ilo/MiDWHH4ti9BA/Wy1ts=
X-Received: by 2002:a5d:45d1:0:b0:352:5f74:6998 with SMTP id
 ffacd0b85a97d-354d8cf8f82mr3092482f8f.18.1716431528138; Wed, 22 May 2024
 19:32:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522024713.59136-1-alexei.starovoitov@gmail.com> <15a3deb272983d2d165dd1ac0d1a7750b200a922.camel@gmail.com>
In-Reply-To: <15a3deb272983d2d165dd1ac0d1a7750b200a922.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 May 2024 19:31:56 -0700
Message-ID: <CAADnVQK4iERDy8AC1ZbOLB3ZxQCGaiTEEZsH=Ojdxfqi=xWAwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Relax precision marking in open coded iters
 and may_goto loop.
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 5:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-05-21 at 19:47 -0700, Alexei Starovoitov wrote:
>
> [...]
>
> > Skipping precision mark at if (i > 1000) keeps 'i' imprecise,
> > but arr[i] will mark 'i' as precise anyway, because 'arr' is a map.
> > On the next iteration of the loop the patch does copy_precision()
> > that copies precision markings for top of the loop into next state
> > of the loop. So on the next iteration 'i' will be seen as precise.
>
> Could you please elaborate a bit on why copy_precision() is necessary?
> In general, the main idea of the patch is to skip precision marks in
> certain cases, meaning that strictly more branches would be explored,
> and it does not seem that copy_precision() is needed for safety reasons.
>
> I tried turning copy_precision() off and see a single test failing:
>
>     $ ./test_progs -vvv -a iters/task_vma
>     ...
>     ; bpf_for_each(task_vma, vma, task, 0) { @ iters_task_vma.c:30
>     35: (55) if r0 !=3D 0x0 goto pc-15 21: R0_w=3Dptr_vm_area_struct(id=
=3D1002) R6=3D1000 R10=3Dfp0 fp-8=3Diter_task_vma(ref_id=3D1,state=3Dactive=
,depth=3D1001) refs=3D1
>     ; if (bpf_cmp_unlikely(seen, >=3D, 1000)) @ iters_task_vma.c:31
>     21: (35) if r6 >=3D 0x3e8 goto pc+14    ; R6=3D1000 refs=3D1
>     ; vm_ranges[seen].vm_start =3D vma->vm_start; @ iters_task_vma.c:34
>     22: (bf) r1 =3D r6
>     REG INVARIANTS VIOLATION (alu): range bounds violation u64=3D[0x3e8, =
0x3e7] s64=3D[0x3e8, 0x3e7] u32=3D[0x3e8, 0x3e7] s32=3D[0x3e8, 0x3e8] var_o=
ff=3D(0x3e8, 0x0)
>     23: R1_w=3D1000 R6=3D1000 refs=3D1
>     23: (67) r1 <<=3D 4                     ; R1_w=3D16000 refs=3D1
>     24: (18) r2 =3D 0xffffc90000342008      ; R2_w=3Dmap_value(map=3Diter=
s_ta.bss,ks=3D4,vs=3D16008,off=3D8) refs=3D1
>     26: (0f) r2 +=3D r1                     ; R1_w=3D16000 R2_w=3Dmap_val=
ue(map=3Diters_ta.bss,ks=3D4,vs=3D16008,off=3D16008) refs=3D1
>     27: (79) r1 =3D *(u64 *)(r0 +0)         ; R0_w=3Dptr_vm_area_struct(i=
d=3D1002) R1_w=3Dscalar() refs=3D1
>     28: (7b) *(u64 *)(r2 +0) =3D r1
>     invalid access to map value, value_size=3D16008 off=3D16008 size=3D8
>     R2 min value is outside of the allowed memory range
>     processed 27035 insns (limit 1000000) max_states_per_insn 65 total_st=
ates 2003 peak_states 1008 mark_read 2

Exactly. It's failing without copy_precision().
I didn't add an additional selftest, but I tried to explain
the idea in the commit log.

That's the case where the verifier processes open coded iter
with a bounded loop logic.
Try:
-               if (bpf_cmp_unlikely(seen, >=3D, 1000))
+               if (bpf_cmp_unlikely(seen, =3D=3D, 1000))

and it will also pass.
In both cases there will be 27038 processed insn.
All 1k iterations will be checked by the verifier.

That's the main idea.
Let users right normal loops for (i=3D0; i < 1000 && can_loop; ...)
and if there is no map value access through 'i' the loop
will converge quickly as may_goto.
If not bounded loop logic will quick in for arr[i].
Just like it did for vm_ranges[seen] in this test.

> I wonder, what if we forgo the 'ignore_bad_range' flag and instead
> consider branches with invalid range as impossible?
> E.g. when pred =3D=3D -2. Or when prediction says that branch would be
> taken and another branch leads to invalid range.

That sounds pretty much like is_branch_taken.
If we don't explore another branch we have to mark the register as precise.

> I'll give it a try later this evening, but still curious about the
> reasoning behind copy_precision().

copy_precision() is kinda the main idea.
Once loop iteration copies precision from header of the loop
the if (dst_reg->precise || src_reg->precise) logic kicks in and
is_branch_taken() starts to work and it becomes bounded loop like
where every iteration states are different.

