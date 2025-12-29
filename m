Return-Path: <bpf+bounces-77475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B4CCE7F67
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 19:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5509E300E834
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 18:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048F628D8D1;
	Mon, 29 Dec 2025 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyPb/GSo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B880928CF77
	for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767034106; cv=none; b=XqgL0WFkbNO1PgTMvzhZpLzbheEsTPs+cystPj6aJAecxAPS+B9Af0+mSTjxHiH2uLMCQfui4MJ+eey/lD1BllYPeZ2ZBkqCcAQ3LHm09lLSbO2byQw+QcabfkO6aZXim4FL0AF5kT67PENLpOUzi5t7J3ntLxDzV2Y8QKOYLJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767034106; c=relaxed/simple;
	bh=1x2lMzZQZOImb3U5g+rs/Anap2/ORuaq/0DrfpdesKk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C5vHJ0mukf97wjbIG5MEqkMiE3dUbJj1nG4n51OXGJS6BQ4SErCg4DISbBN8n4VJ+SoK5bGui2Or77eYwXQ4v+iWix/kPAJ43hQo9+f49nDRsr2oxc+h9cKvks7VVOcNXKNFmW3g0LPLveSWcIbLEvYLHl0DS10lF/jcFZO6Rr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyPb/GSo; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so9249498b3a.2
        for <bpf@vger.kernel.org>; Mon, 29 Dec 2025 10:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767034104; x=1767638904; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4+brUiVPF9FCEHtC0D1+7PX7vWAP58LXDpYRjKPZCFg=;
        b=jyPb/GSo1lD/AhuIfdKXaLOrXQxl/FcAD2NfXhYM4o8oRu0KufkP50ZtjoM7sIzFVi
         7T3ymCORbGY1MfwZXE3/18H4qF6/O855u6IitftW1EUCEq0zf8snctJ68vsGe9NDizGy
         J78Fpw7M1wipd4iMJl1bDaNZa/BAte1CDG7DK88RIAJa+C8yPoq1/P0spoQ2BpIyUftz
         YDBwFfnAWIC2YI8zL+2++C1hx7F4ptEVd+c3a4GZpsbZ+tj/bjfzhGfZYiDt5CdKobB+
         yg8khmnze92nc6YPPjbF8IdNtRC9Hg1Hq7fgH78e2IHcvxx7gA/cJVhKiHg7WNwNBxVc
         ZqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767034104; x=1767638904;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+brUiVPF9FCEHtC0D1+7PX7vWAP58LXDpYRjKPZCFg=;
        b=S90L42fPXEBVWc1M4KDOiFOIMHaQLh/xRaWrj8ldQ7YsLrwnmHKbKOS10WShgZTBWh
         oAbn7IHg75ajsbhltLXoMCkcz3GFXuXsx6h3zJFofVgkZ/7SQzoCYC1OzHiQoi2e11vD
         waXq6xxIRDvd7cuBEIho2aYkcaQtDZEdkkvmH5RkWiuTLC8PDaEykp8OJPsWG97M4jfl
         kA9xNzEhHF1nmKsizB50uCTBqShZ0FbqX7YchLIu/XZvPMF3cmfPcGIPM+RVrByuzeTS
         O9/jzkT4x+DCdlJpplLhjOusZtJqmtXmP39SyAHFmE6C4Z1/RCbucwKyiSQr2SwXt375
         /U2A==
X-Gm-Message-State: AOJu0YyTpBbu9OXccxVHks8S1qgAi3zvA3oECnS4i6taKkkaoovA1L6c
	6La3+TvIRmhgpW+2XKpBVUXeVkbrQE/T/bZfNbfgH6DjbTRZ0Zl+oXt6
X-Gm-Gg: AY/fxX47anyVZ2Lf/tBHjS6oDWHioigix+Av7UgZQmD86MMhgyPX3WxsEWWqVjuVP6o
	w/WbcEYOPBS8DkQlN3zIGiHYaanQtsQALtSQ8BDSXBpLPNCGlnJ3B7FRSoQv1r52DnPhFm7WCVQ
	92ChZfzdZTKScq2+eymoA2k1qImU4BcDpdc05//DXhvOpN5CvFBcr5aTjRELjxX668GhTUzepxZ
	dbak8BY3okT/7dVlk6lW/j6BXQEgrLpN03Z9iAwcJO4NALjoPp/GtSiMeKpwIoFmtu7vsB04PSx
	XtEBZAUv1otS6cOhXph1exjBmnfxLm7lxxGm/i3iM61N7fF5CnNyPp0mZUslNfUwfhhIhbvqmd5
	ro5h6m0Np/9xsmOwiGkNuZrZcRLAE7qzCx3rbtCUgxPQqRYQNFpTT3DnFbHqOh31QDaBsJwt7bR
	9st/gN4cG1bx2gQ+jvlcIzvfztUHyFfosDBkHF
X-Google-Smtp-Source: AGHT+IGqHW3bK8Vv/8Y2eEZ0oz5CBFs/VfWu7R9luOoifAG3d+weEQZ4q2gb73a53UjDA4E8bQQTjg==
X-Received: by 2002:a05:6a20:7d9b:b0:35e:4b35:3669 with SMTP id adf61e73a8af0-376a88cb6b0mr29227885637.31.1767034103740;
        Mon, 29 Dec 2025 10:48:23 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:ac6b:d5ad:83fe:6cca? ([2620:10d:c090:500::2:1bc9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7c14747csm25863306a12.27.2025.12.29.10.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:48:23 -0800 (PST)
Message-ID: <4eec6b7605d007c6f906bf9a4cd95f2423781b0a.camel@gmail.com>
Subject: Re: [PATCH bpf-next] verifier: add prune points to live registers
 print
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko	 <andrii@kernel.org>, Paul Chaignon
 <paul.chaignon@gmail.com>
Date: Mon, 29 Dec 2025 10:48:21 -0800
In-Reply-To: <aUprAOkSFgHyUMfB@gmail.com>
References: <20251222185813.150505-1-mahe.tardy@gmail.com>
	 <CAADnVQLF+ihK16J3x5pQcJY0t2_gUHiur7ENZNqJdazzr+f8Pg@mail.gmail.com>
	 <aUprAOkSFgHyUMfB@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-23 at 11:12 +0100, Mahe Tardy wrote:
> On Mon, Dec 22, 2025 at 08:32:57PM -1000, Alexei Starovoitov wrote:
> > On Mon, Dec 22, 2025 at 8:58=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.co=
m> wrote:
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index d6b8a77fbe3b..a82702405c12 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -24892,7 +24892,7 @@ static int compute_live_registers(struct bpf_=
verifier_env *env)
> > >                 insn_aux[i].live_regs_before =3D state[i].in;
> > >=20
> > >         if (env->log.level & BPF_LOG_LEVEL2) {
> > > -               verbose(env, "Live regs before insn:\n");
> > > +               verbose(env, "Live regs before insn, pruning points (=
p), and force checkpoints (P):\n");
> > >                 for (i =3D 0; i < insn_cnt; ++i) {
> > >                         if (env->insn_aux_data[i].scc)
> > >                                 verbose(env, "%3d ", env->insn_aux_da=
ta[i].scc);
> > > @@ -24904,7 +24904,12 @@ static int compute_live_registers(struct bpf=
_verifier_env *env)
> > >                                         verbose(env, "%d", j);
> > >                                 else
> > >                                         verbose(env, ".");
> > > -                       verbose(env, " ");
> > > +                       if (is_force_checkpoint(env, i))
> > > +                               verbose(env, " P ");
> > > +                       else if (is_prune_point(env, i))
> > > +                               verbose(env, " p ");
> > > +                       else
> > > +                               verbose(env, "   ");
> >=20
> > tbh I don't quite see the value. I never needed to know
> > the exact pruning points while working on the verifier.
> > It has to work with existing pruning heuristics and with
> > BPF_F_TEST_STATE_FREQ. So pruning points shouldn't matter
> > to the verifier algorithms. If they are we have a bigger problem
> > to solve than show them in the verifier log to users
> > who won't be able to make much sense of them.
>=20
> Yeah I think we would agree with Paul on that. And as you mention, with
> the addition of the heuristics on top of prune points, it would maybe be
> more useful to know when the verifier actually saves a new state (but
> that would increase log verbosity).
>=20
> > It's my .02. If other folks feel that it's definitely
> > useful we can introduce this extra verbosity,
> > but all the churn in the selftests is another indication
> > of a feature that "nice, but..."
>=20
> Tbh that's also when I realized that indeed it was "nice, but..." since
> because of those changes, all those liveness tests would depend on the
> position of prune points.=20
>=20
> At the same time, the new print would allow us to write a series of
> tests to check for all the possible cases of prune points as presented
> in the talk, not sure it's actually useful as well...

Hi Everyone,

Sorry, a bit late to the discussion, here are another .02 cents.
Tbh, I'm neither for nor against printing these marks.
Knowing where exactly the checkpoints are is helpful to me sometimes
when I'd like to construct a specific test. On the other hand,
I can always add debug prints locally + you do learn the rules for
checkpoints after some time.  If we go for it, we should probably
distinguish between prune points and "force checkpoints" ('f'?).

Imo, it would be indeed more interesting to print where checkpoint
match had been attempted and why it failed, e.g. as I do in [1].
Here is a sample:

  cache miss at (140, 5389): frame=3D1, reg=3D0, spi=3D-1, loop=3D0 (cur: 1=
) vs (old: P0)
  from 5387 to 5389: frame1: R0=3D1 R1=3D0xffffffff ...

However, in the current form it slows down log level 2 output
significantly (~5 times). Okay for my debugging purposes but is not
good for upstream submission.

Thanks,
Eduard.

[1] https://github.com/kernel-patches/bpf/commit/65fcd66d03ad9d6979df79628e=
569b90563d5368

