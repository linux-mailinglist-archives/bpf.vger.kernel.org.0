Return-Path: <bpf+bounces-22955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C36A86BC32
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998FB1F22DEE
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D902261D;
	Wed, 28 Feb 2024 23:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9wQSxph"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F9A13D2E7
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 23:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162960; cv=none; b=bSY587ZnOJYC5swzU7QBEEP0ULCQpLwpUIGk0qMoZfJcjxJ7enwsQoUeAzAhFIuoFkDzQ1nQvKXb5cDtF+iMJ3Ge1g/RJ+rUzNySssvWzDg4ljMpiiLU4PKjdmUXjRz7tgFLCIz5WKdmHRZrPe9EvTzRSvX6xTvmEU2xvGoTfUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162960; c=relaxed/simple;
	bh=HVxa+x7BuWgFavmq+n2h9L0+pb+D0txMnl3/yRZhsBY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M1s5qz5Po9cf00jEzA+6ZHCVfCHxRZcR9BL9NHhJE1P9A2W6WSwUfm5A/LFlkbbPubIOXNClcakhbCHDW3GvAcoX6CAXptABD9S+7ymphit5EpgsFotHFMWQ3x8Nag7A/89beNwjOyqaLSD/2NRd5lv+3zHnqpMY5zJJHdHXtxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9wQSxph; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5131bec457eso304600e87.0
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 15:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709162955; x=1709767755; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yI9lNqTY6ASnjzodX6IQ/yrfiN6MIbE7+xkATfeJTMI=;
        b=Q9wQSxphFDeNSFeUQYv15XCOvZafTCx5fHmbtz3OXi/3AQ/wXBkNQ4FvnKaglnwTLV
         DXuW0g7KqFIMQD605RMcigWfqbU0cMCbRQxB7/QBmSYadXWLC+M5BuNM7xPGLW2ggu3M
         tsaezOcH4Nx0qj8L4rPKMQ357f2rPm4TzyZKED/NZB2a3RU6qvUdLcA29ROWpw1cqWFU
         ThbfxfH4Zj7un6K2ee+VOlZo0NaRCbFE0ZgsufEa5T+fuxhkYHpOPgfHsFU1pfgUoAYV
         eLCGaX3Ywq2A+wOU9b/uo0ZgaypyPRFcXQgNxImifQcyH/wh5nk2OJiXLB+WK0cJhRLe
         IGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709162955; x=1709767755;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yI9lNqTY6ASnjzodX6IQ/yrfiN6MIbE7+xkATfeJTMI=;
        b=FrMt6NYX802pzUCDwBN5pZRqYd3PHh5Oo0C04O5SQqHJGnOYPYMe0f33JX/5e/dEJf
         lT5TlQOR8RpAMS7IkXN/H/HPUPSOe0m0+S/sPp2Wu0FG9YhsU/wGXZ8VcaYHHKbKCA07
         h+OBXeFKfc/jFoIPtdt7THpGNZyGV6fbhsIXf25+0z/FHE98EAnzENAwk8dmlbZxP/B8
         LO4fvf7ttjIaJNFBQf7h8qxYcToK+eqOgNhyN3r8nPvQh57ZKD/dLqA0QCkY3pdrm1ii
         Z/mcnENAT0S8cECG3NYLkxyHX3svL3SHrd8ITznzlYX8LmCYui0gfj2GrydYFX/vPsQm
         m4ng==
X-Gm-Message-State: AOJu0YwORsDDolHY8CtnaprWQ29cw7IagHCRGxQDv5SoTZBj4kkk2NwG
	mr4zf2vILY1U3W8rA2XF733tAQFtYs7c/26Cn+UJe2lHjt84yHHE
X-Google-Smtp-Source: AGHT+IFouDyaRKG69TwxHeITsXB2jylPEYPCtxS+2eEmBFs0hs1I1ndYRN/qIgATEL8/sSUL7UnouA==
X-Received: by 2002:ac2:5235:0:b0:513:2052:6430 with SMTP id i21-20020ac25235000000b0051320526430mr79595lfl.1.1709162955114;
        Wed, 28 Feb 2024 15:29:15 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id w12-20020a05651204cc00b005131e8befeasm27092lfq.243.2024.02.28.15.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 15:29:14 -0800 (PST)
Message-ID: <b1b259639635e9328bbbbc8e0683b14242f177e2.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: track find_equal_scalars history on
 per-instruction level
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  sunhao.th@gmail.com
Date: Thu, 29 Feb 2024 01:29:08 +0200
In-Reply-To: <CAEf4BzZdDoaVw28RahC+8hV+kReYjTdfJQdaMXJEkUUgih8j2Q@mail.gmail.com>
References: <20240222005005.31784-1-eddyz87@gmail.com>
	 <20240222005005.31784-3-eddyz87@gmail.com>
	 <CAEf4BzZdDoaVw28RahC+8hV+kReYjTdfJQdaMXJEkUUgih8j2Q@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-28 at 15:01 -0800, Andrii Nakryiko wrote:
[...]

> > @@ -3332,6 +3402,12 @@ static int push_jmp_history(struct bpf_verifier_=
env *env, struct bpf_verifier_st
> >                           "verifier insn history bug: insn_idx %d cur f=
lags %x new flags %x\n",
> >                           env->insn_idx, cur_hist_ent->flags, insn_flag=
s);
> >                 cur_hist_ent->flags |=3D insn_flags;
> > +               if (cur_hist_ent->equal_scalars !=3D 0) {
> > +                       verbose(env, "verifier bug: insn_idx %d equal_s=
calars !=3D 0: %#llx\n",
> > +                               env->insn_idx, cur_hist_ent->equal_scal=
ars);
> > +                       return -EFAULT;
> > +               }
>=20
> let's do WARN_ONCE() just like we do for flags? why deviating?

Ok

[...]

> >  /* For given verifier state backtrack_insn() is called from the last i=
nsn to
> > @@ -3802,6 +3917,7 @@ static int backtrack_insn(struct bpf_verifier_env=
 *env, int idx, int subseq_idx,
> >                          */
> >                         return 0;
> >                 } else if (BPF_SRC(insn->code) =3D=3D BPF_X) {
> > +                       bt_set_equal_scalars(bt, hist);
> >                         if (!bt_is_reg_set(bt, dreg) && !bt_is_reg_set(=
bt, sreg))
> >                                 return 0;
> >                         /* dreg <cond> sreg
> > @@ -3812,6 +3928,9 @@ static int backtrack_insn(struct bpf_verifier_env=
 *env, int idx, int subseq_idx,
> >                          */
> >                         bt_set_reg(bt, dreg);
> >                         bt_set_reg(bt, sreg);
> > +                       bt_set_equal_scalars(bt, hist);
> > +               } else if (BPF_SRC(insn->code) =3D=3D BPF_K) {
> > +                       bt_set_equal_scalars(bt, hist);
>=20
> Can you please elaborate why we are doing bt_set_equal_scalars() in
> these three places and not everywhere else? I'm trying to understand
> whether we should do it more generically for any instruction either
> before or after all the bt_set_xxx() calls...

The before call for BPF_X is for situation when dreg/sreg are not yet
tracked precise but one of the registers that gained range because of
this 'if' is already tracked.

The after call for BPF_X is for situation when say dreg is already
tracked precise but sreg is not and there are some registers had same
id as sreg, that gained range when this 'if' was processed.
The equal_scalars_bpf_x_dst() test case covers this situation.
Here it is for your convenience:

    /* Registers r{0,1,2} share same ID when 'if r1 > r3' insn is processed=
,
     * check that verifier marks r{0,1,2} as precise while backtracking
     * 'if r1 > r3' with r3 already marked.
     */
    SEC("socket")
    __success __log_level(2)
    __flag(BPF_F_TEST_STATE_FREQ)
    __msg("frame0: regs=3Dr3 stack=3D before 5: (2d) if r1 > r3 goto pc+0")
    __msg("frame0: parent state regs=3Dr0,r1,r2,r3 stack=3D:")
    __msg("frame0: regs=3Dr0,r1,r2,r3 stack=3D before 4: (b7) r3 =3D 7")
    __naked void equal_scalars_bpf_x_dst(void)
    {
    	asm volatile (
    	/* r0 =3D random number up to 0xff */
    	"call %[bpf_ktime_get_ns];"
    	"r0 &=3D 0xff;"
    	/* tie r0.id =3D=3D r1.id =3D=3D r2.id */
    	"r1 =3D r0;"
    	"r2 =3D r0;"
    	"r3 =3D 7;"
    	"if r1 > r3 goto +0;"
    	/* force r0 to be precise, this eventually marks r1 and r2 as
    	 * precise as well because of shared IDs
    	 */
    	"r4 =3D r10;"
    	"r4 +=3D r3;"
    	"r0 =3D 0;"
    	"exit;"
    	:
    	: __imm(bpf_ktime_get_ns)
    	: __clobber_all);
    }

The before call for BPF_K is the same as before call for BPF_X: for
situation when dreg is not yet tracked precise, but one of the
registers that gained range because of this 'if' is already tracked.

The calls are placed at point where conditional jumps are processed
because 'equal_scalars' are only recorded for conditional jumps.

>=20
> >                          /* else dreg <cond> K
> >                           * Only dreg still needs precision before
> >                           * this insn, so for the K-based conditional

[...]

