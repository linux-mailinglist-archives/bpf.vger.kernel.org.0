Return-Path: <bpf+bounces-52935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62D1A4A694
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 00:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D68A67A5AB8
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AF21DE8AB;
	Fri, 28 Feb 2025 23:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ip8Yxnsi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B385F1C5F18
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 23:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740785008; cv=none; b=j3tJ3Ipnu75kmLp5T4/AY+subx/PmdTne73S+lQ79hK+e5f1GDJQ3KWj1Wh9cGU29xBr3lmxcs5IB9X5Aa90fH1ld6kLXvYNnALsIGYxAzpd4KOgAAC53SnK5Aofy9QHyYVx4F8SBfYQqX6S3izxlB791wCPH3OrFW+inL8LTtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740785008; c=relaxed/simple;
	bh=n7Q8OCFieRVMtHYXh+PulmuznImjY/9V+QGIHAX//Go=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lhe4IhanhtfRWxa4IjIsYqjCnfZucKc/ssLAO2TOx5XJYaMFTCkQ1eDg9TuJHMZjTJIz2sXONAMeGBwli7kZ/dBidH9ITc5KO4Ty1x5zoJXJdLOBgLu61ILR5V2WaKScCpAidFrhGtYSM6HujVnIeRKyORf/lXodIru1QtKl0lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ip8Yxnsi; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2feb91a2492so2598709a91.2
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 15:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740785006; x=1741389806; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qlYHDQDoaNESwPXpnctkUCxa6Ctw0NjupTxUR1ecrkI=;
        b=ip8YxnsiNcpwPMoaBlwlZWl1uaJvs1vMWBAHzkYUtIADuc5jUd97OhI+fshCUh3sgU
         1YFdSotI5vfIF6hZgPR7kC5tj8vI0w3vdGr4JUFRrU+G81VR0dpD15ywnEUZFpUkp79W
         JbWOcb7qeUHLOrToXopb8IcrHo1W4Xr6BVlZVb9PXxs/p22PEeu9EDZJmN4z08+4hBwK
         6UrtpanH7tYYN9hix5nCryHJm1ZIA+9iSy1GupIRfCsBg1Mi/iqL2bHiGKRe1ZBLRv4X
         evIZdNhNIvZKLRN/6Ny0SLE56NhFeSX8Bqcg1f/2I65HGx75bXthtVrwTxzRHQ3s9n3Q
         DvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740785006; x=1741389806;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qlYHDQDoaNESwPXpnctkUCxa6Ctw0NjupTxUR1ecrkI=;
        b=ArhHygdOXwkEOKIRpTdcDeIgK+g+3m1YXzZMV65959W67Agh3tAm28RYuFU70AfI2k
         Nd3+uD7ZgVox8F74sHcgrq45/Aa5DbGJ7siHOoRvl0n/kIT6gp2tkjv11/zeK1f9Yx7+
         TezLf3N88L/sclha8Xt5e7dK7+GBc8nMmpkxAsTbE6L8+j0XOgb2wkpJWVyMcIdQ4Voi
         5j99ryC7sw7hCEdDwPcm8hrraXT4dw0a06KyhYLFb8wKGmM3gCdAos0aGGjRc8zN8kgk
         GBbJGvUV5sIqf9RR9uPL6+ZQW1M6hgCyWcKg66JRz7ge7qEYGYkLYRm9DCA/YyTRFvfY
         6FQg==
X-Gm-Message-State: AOJu0Yz8KWd5Aug0rDwoLUEkOzX6xdPE18qRP/vIOTKMkwlbkLrCD9TV
	1ziUFWLLsYgJ4p5WmIwqIdw+zhmDWwq+H8fLX8OShvx2W8pwEeMk
X-Gm-Gg: ASbGncvPv178GvjnoPYOkUZy2IuW+hSSXEfojXqS01o6oVt7GNxAFUEUd4XZc9RhNSt
	wwoftfWUPYTInf+xbcCQjTGKbLe+WkTU/YNGtqwJhiTNt3NaF+Y4rHRzUEHBHDR9WEmJbZX9F2i
	ArSdhT25LEaa2R66c7a7PPhTIHOWDfpOSTGsABKuARC4aRG5jJfRx4YSP71c3msKsj8lLWmqWXL
	fQvV9Up0NzGa2Dh8dBeUnTzgpl7ZWFNuayRAS5feq5nwnYVWSEZDngMUBiN9g0xveVHUVpyJf28
	o3qgzaUQhSD5gl31jhqdoQ9X8lGHglurP+yLix8ZSw==
X-Google-Smtp-Source: AGHT+IEW2WBZGKZRz0JxZAzmPahMzb3Ix4d/whYxzUjJrVUcvizFUaz/HK1OEIpqCby6cEVcn6ZnFg==
X-Received: by 2002:a17:90b:1b47:b0:2f6:d266:f45e with SMTP id 98e67ed59e1d1-2febab2ebdamr8989624a91.2.1740785005876;
        Fri, 28 Feb 2025 15:23:25 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d27eesm38958965ad.31.2025.02.28.15.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 15:23:25 -0800 (PST)
Message-ID: <3736b28f9266bf8b9c227998e80eb08253aef43e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Summarize sleepable global subprogs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Kumar Kartikeya Dwivedi
	 <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@kernel.org>, kkd@meta.com,
 kernel-team@meta.com
Date: Fri, 28 Feb 2025 15:23:20 -0800
In-Reply-To: <CAEf4BzZ_UQVtOhE3SRvHBE3NyCwfdFCxmiAPPNbLArZVQT6oZg@mail.gmail.com>
References: <20250228162858.1073529-1-memxor@gmail.com>
	 <20250228162858.1073529-2-memxor@gmail.com>
	 <CAEf4BzZ_UQVtOhE3SRvHBE3NyCwfdFCxmiAPPNbLArZVQT6oZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-28 at 15:18 -0800, Andrii Nakryiko wrote:

[...]

> >  /* non-recursive DFS pseudo code
> > @@ -17183,9 +17187,20 @@ static int visit_insn(int t, struct bpf_verifi=
er_env *env)
> >                         mark_prune_point(env, t);
> >                         mark_jmp_point(env, t);
> >                 }
> > -               if (bpf_helper_call(insn) && bpf_helper_changes_pkt_dat=
a(insn->imm))
> > -                       mark_subprog_changes_pkt_data(env, t);
> > -               if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
> > +               if (bpf_helper_call(insn)) {
> > +                       const struct bpf_func_proto *fp;
> > +
> > +                       ret =3D get_helper_proto(env, insn->imm, &fp);
> > +                       /* If called in a non-sleepable context program=
 will be
> > +                        * rejected anyway, so we should end up with pr=
ecise
> > +                        * sleepable marks on subprogs, except for dead=
 code
> > +                        * elimination.
>=20
> TBH, I'm worried that we are regressing to doing all these side effect
> analyses disregarding dead code elimination. It's not something
> hypothetical to have an .rodata variable controlling whether, say, to
> do bpf_probe_read_user() (non-sleepable) vs bpf_copy_from_user()
> (sleepable) inside global subprog, depending on some outside
> configuration (e.g., whether we'll be doing SEC("iter.s/task") or it's
> actually profiler logic called inside SEC("perf_event"), all
> controlled by user-space). We do have use cases like this in
> production already, and this dead code elimination is important in
> such cases. Probably can be worked around with more global functions
> and stuff like that, but still, it's worrying we are giving up on such
> an important part of the BPF CO-RE approach - disabling parts of code
> "dynamically" before loading BPF programs.

There were two alternatives on the table last time:
- add support for tags on global functions;
- verify global subprogram call tree in post-order,
  in order to have the flags ready when needed.

Both were rejected back than.
But we still can reconsider :)

> > +                        */
> > +                       if (ret =3D=3D 0 && fp->might_sleep)
> > +                               mark_subprog_sleepable(env, t);
> > +                       if (bpf_helper_changes_pkt_data(insn->imm))
> > +                               mark_subprog_changes_pkt_data(env, t);
> > +               } else if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) =
{
> >                         struct bpf_kfunc_call_arg_meta meta;
> >=20
> >                         ret =3D fetch_kfunc_meta(env, insn, &meta, NULL=
);

[...]


