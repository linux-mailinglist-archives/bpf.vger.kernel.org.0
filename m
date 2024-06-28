Return-Path: <bpf+bounces-33384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC89A91C91D
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 00:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A4D2872C5
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 22:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084A48172D;
	Fri, 28 Jun 2024 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcqTidOD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D641C20;
	Fri, 28 Jun 2024 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719614055; cv=none; b=lu+dlmfeM2uvZ6mWgoMES23bAk2JR1oIcnFv7KLy7zYR+N1x8W8wRUshGrg/zX8n35WWTofl6LZV5XJY9bdKnWnUJFJoKzx+sj282wDqmtQ4tqlaUYjDWrPx57/NX/nW24LohaHJ1fyTw3sTv4S/sWi+eMaL3CNk9zEgO1xfsHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719614055; c=relaxed/simple;
	bh=Ys4CQ1Ee2XYd9Z+q+G+O2Q2yPZBTN4YABcJ7Izhsah0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSMAneV3aoDJ6fnDr8R4Gr3lT7muNOFvoXhJ099SWb2nXXrKV1260xNrTptOzxQkYT/9nFD3FSoC9IN8VzPZw1vrk4tvrz1axVyBDEjK3kqa9zwyscH6x6OkPuTpj4n3Vn89FqqQsRGZ6fj0HrsZ7Pz9mmJQb8Avrak8bn+PPa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcqTidOD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-706a1711ee5so774928b3a.0;
        Fri, 28 Jun 2024 15:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719614053; x=1720218853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQBqKzyhVeiycVhfYsHaCb9v2lQ1K0Xn265nIuEvVp0=;
        b=YcqTidODzPkXd9/yCmy9L6bRGYvcXeo6YduEbqmxcrhCRVUeErUfZMWIdx1UAKiZLP
         C0KNuLlSJCcdAiJZpsWP5/bm6LQZkTpbJt2KZPRRYvqXMPeujYDYupUAVHyMr0M+RTom
         TL9iOoOx9LKs7PRMTtUuvSnMxq84CndrXLiJjhxWNwnA/2EOvhisDi2vxdmYywz1EG7t
         4fJxRlFBChjDL2tJwGln1HNSQW79THn9QW4xZBI0OcJhV3r5jwkxr0KZjmwv/9Ip/Fn2
         XAElhVOy9RDAC4sr0lYEDLhziy/P0+auiFfAFTXAWZe8T59Uy9qnExSRE0CydG9XFLy2
         luwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719614053; x=1720218853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQBqKzyhVeiycVhfYsHaCb9v2lQ1K0Xn265nIuEvVp0=;
        b=hLitysttOoSJrUQ3tRxMrM6ETol0blymCrcDOFsRLuoDeNEMnYH+pXPasmHjbjhVqb
         58ExeMc4NjtAjZBiX6p207RQuv7sGsRjHrZsBY04zDeSlPq3AYKO9aCdT+EdEvgDBYkD
         kj2AmwIwzZGF9rP9mMJXo+bxuJeygqg/FHK4Z64kXNF5VlCXlcXLuJzwFmYi2TCJMEAm
         Ty+vZ3aM07/Vzi3iSp5HMG5+2rPxX+B8DmA/tMTau+aV8ySIIJtpiKTXRsEWd/qOI4FW
         CiYsJBvDbb6ENI62VXSILXtqXI4M+gQ1pODLqUExt4syJQHL9C5494cHGfyYPRR94Wwc
         2gug==
X-Forwarded-Encrypted: i=1; AJvYcCWbyuH4SbT7RD6dxghNva8eotPO4Gp6q4SBNZSEip1x6jiRFItbkSwZoawfbbyrmvZ1xUGnZ4DM6O6bAL9LXoiAelYf3xg0mf+JYAIMLHGUoacTdY1nvbrCVtnt5kxDzPYR
X-Gm-Message-State: AOJu0Yx74wwoctpTeyq78PIuIbyD1LNDoOuBXQFNBQlFPVEpPFWFGLvN
	qKNeF1aAoKdimfCDMrjXBr2BW/nVgvvPwFCi+0aaflMjih/bDTFXHq028fZ5Q4f6c9NZSjMq6ju
	eArW612ykUHX7T2I6UjIo72oqkQ8=
X-Google-Smtp-Source: AGHT+IHTY9Owf6xC5jDO6UPJdtqx50t9WifUnOdpzkHoj9aogzuhEeIZynfa0rooaNoAygxxbhxYmkWzBmP2pnkBAPQ=
X-Received: by 2002:a62:e70b:0:b0:706:5a4a:dcd0 with SMTP id
 d2e1a72fcca58-7067475f15bmr16864830b3a.34.1719614053427; Fri, 28 Jun 2024
 15:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zn4BupVa65CVayqQ@slm.duckdns.org> <Zn4Cw4FDTmvXnhaf@slm.duckdns.org>
 <CAADnVQJym9sDF1xo1hw3NCn9XVPJzC1RfqtS4m2yY+YMOZEJYA@mail.gmail.com> <Zn8xzgG4f8vByVL3@slm.duckdns.org>
In-Reply-To: <Zn8xzgG4f8vByVL3@slm.duckdns.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Jun 2024 15:34:01 -0700
Message-ID: <CAEf4BzbVorxvJdGA0eLviRhboaisxe4Ng=VErZVh3MG9YrRaKw@mail.gmail.com>
Subject: Re: [PATCH sched_ext/for-6.11 2/2] sched_ext: Implement scx_bpf_consume_task()
To: Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 3:08=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Alexei.
>
> On Thu, Jun 27, 2024 at 06:34:14PM -0700, Alexei Starovoitov wrote:
> ...
> > > +__bpf_kfunc bool __scx_bpf_consume_task(unsigned long it, struct tas=
k_struct *p)
> > > +{
> > > +       struct bpf_iter_scx_dsq_kern *kit =3D (void *)it;
> > > +       struct scx_dispatch_q *dsq, *kit_dsq;
> > > +       struct scx_dsp_ctx *dspc =3D this_cpu_ptr(scx_dsp_ctx);
> > > +       struct rq *task_rq;
> > > +       u64 kit_dsq_seq;
> > > +
> > > +       /* can't trust @kit, carefully fetch the values we need */
> > > +       if (get_kernel_nofault(kit_dsq, &kit->dsq) ||
> > > +           get_kernel_nofault(kit_dsq_seq, &kit->dsq_seq)) {
> > > +               scx_ops_error("invalid @it 0x%lx", it);
> > > +               return false;
> > > +       }
> >
> > With scx_bpf_consume_task() it's only a compile time protection from bu=
gs.
> > Since kfunc doesn't dereference any field in kit_dsq it won't crash
> > immediately, but let's figure out how to make it work properly.
> >
> > Since kit_dsq and kit_dsq_seq are pretty much anything in this implemen=
tation
> > can they be passed as two scalars instead ?
> > I guess not, since tricking dsq !=3D kit_dsq and
> > time_after64(..,kit_dsq_seq) can lead to real issues ?
>
> That actually should be okay. It can lead to real but not crashing issues=
.
> The system integrity is going to be fine no matter what the passed in seq
> value is. It can just lead to confusing behaviors from the BPF scheduler'=
s
> POV, so it's fine to put the onus on the BPF scheduler.
>
> > Can some of it be mitigated by passing dsq into kfunc that
> > was used to init the iter ?
> > Then kfunc will read dsq->seq from it instead of kit->dsq_seq ?
>
> I don't quite follow this part. bpf_iter_scx_dsq_new() takes @dsq_id. The
> function looks up the matching DSQ and then the iterator remembers the
> current dsq->seq which serves as the threshold (tasks queued afterwards a=
re
> ignored). ie. The value needs to be copied at that point to guarantee tha=
t
> iteration ignores tasks that are queued after the iteration started.
>
> > > +       /*
> > > +        * Did someone else get to it? @p could have already left $ds=
q, got
> > > +        * re-enqueud, or be in the process of being consumed by some=
one else.
> > > +        */
> > > +       if (unlikely(p->scx.dsq !=3D dsq ||
> > > +                    time_after64(p->scx.dsq_seq, kit_dsq_seq) ||
> >
> > In the previous patch you do:
> > (s32)(p->scx.dsq_seq - kit->dsq_seq) > 0
> > and here
> > time_after64().
> > Close enough, but 32 vs 64 and equality difference?
>
> Sorry about the sloppiness. It was originally u64 and then I forgot to
> update here after changing them to u32. I'll add a helper for the compari=
son
> and update both sites.
>
> Going back to the sequence number barrier, it's a sort of scoping and one
> way to solve it is adding an explicit helper to fetch the target DSQ's
> sequence number and then pass it to the consume_task function. ie. sth li=
ke:
>
>         barrier_seq =3D scx_bpf_dsq_seq(dsq_id);
>         bpf_for_each(scx_dsq, p, dsq_id, 0) {
>                 ...
>                 scx_bpf_consume_task(p, dsq_id, barrier_seq);
>         }
>
> This should work but it's not as neat in that it now involves three dsq_i=
d
> -> DSQ lookups. Also, there's extra subtlety arising from @barrier_seq be=
ing
> different from the barrier seq that the scx_dsq iterator would be using.

maybe a stupid question, but why scx_dsq iterator cannot accept
scx_dispatch_q pointer directly instead of dsq_id and then doing
lookup? I.e., what if you had a kfunc to do dsq_id -> scx_dispatch_q
lookup (returning PTR_TRUSTED instance), and then you can pass that to
iterator, you can pass that to scx_bpf_consume_task() kfunc.

Technically, you can also have another kfunc accepting scx_dispatch_q
and returning current "timestamp" as some special type (TRUSTED and
all), which will be passed into consume_task() as well.

Is this too explicit in terms of types?

>
> As a DSQ iteration needs to have its own barrier sequence, maybe the answ=
er
> is to require passing it in as an explicit parameter. ie.:
>
>         barrier_seq =3D scx_bpf_dsq_seq(dsq_id);
>         bpf_for_each(scx_dsq, p, dsq_id, barrier_seq, 0) {
>                 ...
>                 scx_bpf_consume_task(p, dsq_id, barrier_seq);
>         }
>
> There still are three dsq_id lookups but at least there is just one seque=
nce
> number in play. It is more cumbersome tho compared to the current interfa=
ce:
>
>         bpf_for_each(scx_dsq, p, dsq_id, 0) {
>                 ...
>                 scx_bpf_consume_task(BPF_FOR_EACH_ITER, p);
>         }
>
> What do you think?
>
> Thanks.
>
> --
> tejun
>

