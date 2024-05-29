Return-Path: <bpf+bounces-30817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CB98D2B6B
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 05:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D36A281550
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 03:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010B715B139;
	Wed, 29 May 2024 03:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIThhyBu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6F88BE0
	for <bpf@vger.kernel.org>; Wed, 29 May 2024 03:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716952963; cv=none; b=d53NImZVAHWjbju28vmnc+3Gg1ZSN9V+xgHd8kg17r+i9cy+ebdBkZFtoTttO8ZSY8TGnMZJ7fl4xzl8NMixCeWb1X3hIRewpl3RlREgn0on+mIgXwRJzkda071Z6TFS4CuAzM0fmtAQdt1NoIuwEQ0F0yAvhOfFYrJ62FEg2iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716952963; c=relaxed/simple;
	bh=klY5aej4OkVI8Xn6SUv1wKWwO2JtnPBxCjqaSGTN/fI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3VKadvVLEti6QiCrH8rkiKrpMplWCej9HM43irt9KOsmsmPY03fUxc6mZgiKs+daiT290eL1Br8ut9zwo+WZj0d5nIncsgXr/kSs6TyLOyWk7YKHG0JaE7j8QRZ6WRfnpU3F/5xoTAYeyl/wCMb3H1RBD/cq9Lb6u4vk6cEysU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIThhyBu; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35bf77ba951so928676f8f.3
        for <bpf@vger.kernel.org>; Tue, 28 May 2024 20:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716952959; x=1717557759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SD6AK/ciAHwy0G708EJRipvT2MyQUyQcbsG0UsO02zw=;
        b=kIThhyBunLJJtqTqM0sOpdnW+xoRirU9RpehjXMiXmKV5oFF7D4WsezhmrGkjFJbO2
         NbguCYMHlhUIr1k6VOve8LyrQ/QvFkWJLdngOYVer4Em5oLA0yqo9nExKARquuQxqnA9
         IcEalQziu3GRAtXVslegSXiakmapGtx6eNAcaUpsEp6UoQQnEIGAYZC3fXPcxzPgVgAW
         HUGpAAWPeBGSlZVUOebxhzOfxu02eRu06isvDq6lCHrwwTx0mTmg1uBGQeLdc33XDgDB
         VYxVVNhAjOqGDFPSODsYFAzihvLoFs0GTTTk6rQe2imNTZ8Qh4ALNr8ZLHeofgOKw8xY
         sXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716952959; x=1717557759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SD6AK/ciAHwy0G708EJRipvT2MyQUyQcbsG0UsO02zw=;
        b=k1XRjNoZqdBuL5FS15xGXpoeKYBLkXgFgeH/Fr2Algi0AYeVgDBn2C2EE3p+Ejp1BG
         4i5gO0nT1PcBZ5tUlAuZedeYK/uhHzmKOyq5nYlefmCEFu+jKcUxfFnLhNU9dYNTfkJM
         yqn4ed8uEwIgKNCPkd0VDmZ73VdHo7ypb9q/2llGRVbKu09zOBivw8tkSjRA3aH4CMAq
         vyJLWQcVymm0h+SrW+9KKjZD4cQ3xk9QG28mPle9DCD45hI0j/GWI6Xm2Yui+mqeEi7b
         finBuaJ0KFfzz6/yxyVdEP/Rp57nWjXrQLyW4QluaD36M4VB8Gad+I34zkNGj94qczRY
         o8FA==
X-Gm-Message-State: AOJu0YwN092iYQLL2BLNOZ9et3RmHXPkOofpESA2JAP5AibMzTlei5Xq
	iKJDoAdrtl/iJ+u2rIyINArtHKPFarW21Uxb0wy6Mzo6JTQ+ZaqLiDO4EpXCEqMzcjPijnG6BoE
	yEOFxVTb+YpL/j85L7ByLPNExxks=
X-Google-Smtp-Source: AGHT+IE0D05FlrVdyoFmQ9/c+s3NF2bPUJj+nDwIBT45crAZPvaiS9EiXjYo38LwJbn1KNvzgNFNGDGnv9Z+R4kp1EQ=
X-Received: by 2002:a05:6000:1105:b0:354:c934:efa0 with SMTP id
 ffacd0b85a97d-3552fdfa4e8mr9783421f8f.48.1716952959266; Tue, 28 May 2024
 20:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525031156.13545-1-alexei.starovoitov@gmail.com>
 <90874d4e32e7fe937c6774ad34d1617592b8abc8.camel@gmail.com>
 <CAADnVQJdaQT_KPEjvmniCTeUed3jY0mzDNLUhKbFjpbjApMJrA@mail.gmail.com>
 <ceec0883544b6855b7d1fda2884de775414a56c4.camel@gmail.com> <a8612f7bada4cf00d47e74c1507f9ad262e8a08f.camel@gmail.com>
In-Reply-To: <a8612f7bada4cf00d47e74c1507f9ad262e8a08f.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 28 May 2024 20:22:27 -0700
Message-ID: <CAADnVQKczx0pNt7f8vYmknyg7cBxrr8raOpVKmxfnSjT3UO1OQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Relax precision marking in open
 coded iters and may_goto loop.
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 7:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-05-28 at 18:08 -0700, Eduard Zingerman wrote:
>
> [...]
>
> > > Because your guess at the reason for the verifier reject is not corre=
ct.
> > > It's signed stuff that is causing issues.
> > > s/int i/__u32 i/
> > > and this test is passing the verifier with just 143 insn processed.
> >
> > I'm reading through verifier log, will get back shortly.
>
> Ok, so it is a bit more subtle than I thought.
> Comparing verification log for master and v3 here is the state in
> which they diverge and v3 rejects the program:
>
>     from 14 to 15: R0=3Drdonly_mem(id=3D6,ref_obj_id=3D1,sz=3D4) R6=3Dsca=
lar(id=3D5) R7=3D2
>                    R10=3Dfp0 fp-8=3Diter_num(ref_id=3D1,state=3Dactive,de=
pth=3D3) refs=3D1
>     15: R0=3Drdonly_mem(id=3D6,ref_obj_id=3D1,sz=3D4) R6=3Dscalar(id=3D5)
>         R7=3D2 R10=3Dfp0 fp-8=3Diter_num(ref_id=3D1,state=3Dactive,depth=
=3D3) refs=3D1
>     15: (55) if r0 !=3D 0x0 goto pc+5       ; R0=3Drdonly_mem(id=3D6,ref_=
obj_id=3D1,sz=3D4) refs=3D1
>     ; if (i < 5) @ verifier_loops1.c:298
> 0-> 21: (65) if r7 s> 0x4 goto pc-10      ; R7=3D2 refs=3D1
>     21: refs=3D1
>     ; sum +=3D arr[i++]; @ verifier_loops1.c:299
> 1-> 22: (bf) r1 =3D r7                      ; R1_w=3Dscalar(id=3D7,smax=
=3D4) R7=3Dscalar(id=3D7,smax=3D4) refs=3D1
> 2-> 23: (67) r1 <<=3D 3                     ; R1_w=3Dscalar(smax=3D0x7fff=
fffffffffff8,
>                                                         umax=3D0xffffffff=
fffffff8,
>                                                         smax32=3D0x7fffff=
f8,
>                                                         umax32=3D0xffffff=
f8,
>                                                         var_off=3D(0x0; 0=
xfffffffffffffff8)) refs=3D1
>     24: (18) r2 =3D 0xffffc900000f6000      ; R2_w=3Dmap_value(map=3Dveri=
fier.bss,ks=3D4,vs=3D80) refs=3D1
>     26: (0f) r2 +=3D r1
>     mark_precise: frame0: last_idx 26 first_idx 21 subseq_idx -1
>     ...
>     math between map_value pointer and register with unbounded min value =
is not allowed
>
> At point (0) the r7 is tracked as 2, at point (1) it is widened by the
> following code in the falltrhough branch processing:
>
> +               if (ignore_pred) {
> +                       if (opcode !=3D BPF_JEQ && opcode !=3D BPF_JNE) {
> +                               widen_reg(dst_reg);
> +                               if (has_src_reg)
> +                                       widen_reg(src_reg);
> +                       }
> +                       widen_reg(other_dst_reg);
> +                       if (has_src_reg)
> +                               widen_reg(other_src_reg);
> +               } else {
>
> Here src_reg is a fake register set to 4,
> because comparison instruction is BPF_K it does not get widened.
> So, reg_set_min_max() produces range [-SMIN,+4] for R7.
> And at (2) all goes south because of the "<<" logic.
> Switch to unsigned values helps because umax range is computed
> instead of smax at point (1).

Exactly. Unsigned is the answer (as I mentioned in the previous email).
The heuristic of _not_ doing bounded loop inside open iter
is that step back that may cause pain.
But really, doing bpf_for() { for(i; i < ..;i++) ..}
is asking for trouble, since it's mixing two concepts.

And in this case the compiler is confused too,
since it cannot normalize i < 5 into i !=3D 5 as it would
do for a canonical loop.

>
> However, below is an example where if comparison is BPF_X.
> Note that I obfuscated constant 5 as a volatile variable.
> And here is what happens when verifier rejects the program:

Sounds pretty much like: doctor it hurts when I do that.

> +      volatile unsigned long five =3D 5;
> +      unsigned long sum =3D 0, i =3D 0;
> +      struct bpf_iter_num it;
> +      int *v;
> +
> +      bpf_iter_num_new(&it, 0, 10);
> +      while ((v =3D bpf_iter_num_next(&it))) {
> +              if (i < five)
> +                      sum +=3D arr[i++];

If you're saying that the verifier should accept that
no matter what then I have to disagree.
Not interested in avoiding issues in programs that
are actively looking to explore a verifier implementation detail.

I'll add this test with __u64 i =3D 0;
to demo how such mixed loop constructs can be used.
-no_alu32, default and -cpuv4 all pass.

