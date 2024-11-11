Return-Path: <bpf+bounces-44548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 274689C4901
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 23:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE0F8B2B7CB
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 21:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3971BBBE0;
	Mon, 11 Nov 2024 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmyMykK3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078851B07AE
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 21:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731362002; cv=none; b=iTDcVgcei8OqGjn8pb5l8GLQcRx7Zj6hnFghWglqPb61bybZJclMxaoAlwqvlpt1X9T7qHHrIUlyvo11PYOlBJ4JT8faCkEhO0v/kz7xRmUNFKx1k3GlgPiGhXlX9mrcxKjlkWSkYmRhhZUkTyo0QJMvXXmA2FapWfYrlLyuZgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731362002; c=relaxed/simple;
	bh=DGxdqGvNMkHZFBzM+WZu+QhY4kw9QPjFLBYpr0Blw7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Av3eW/c/1GihfPh7NL8IHtm3okZR9DCp1VbasDx5RgwuSd3aUE5dTsa+1naHxoLhl3ELNDQ7hPHHmnd1qjBmvMnpWZDUyPH+hFmEcSEaH8DLGELAsT2I20knW5PZpDeAMTDJ9InBE3Ba9d7IrvsYju9MNwoI2mtGIsIw4YmKiAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmyMykK3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e31af47681so4012946a91.2
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 13:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731362000; x=1731966800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVBCUxEpHVUy2ZD/pMI1cthKhEWgZug8tgK47VkEhns=;
        b=RmyMykK3Cu2NMUG5YshMsofrao648YKcHBnQRuHMx2RiKXxHl5Md/ua1Ji0y44cxG1
         PbtZ8f8V43lsyZFoWPKejBu9soaQfjP1Wk12FYmnsxxT1JkO2HFHeHBC3bpU7CLh5DXL
         QkuEi57KnLZKX/oXWJBa9xen7AmwGK28V7jPN8SF2Tn2e5eYn9nYrYuQNXsB0X4HA6xE
         hhf24KgnXF1+35OKODgBcgiYVjTt98Vqy9e7RXMJN7mglOSixcyW7OqIpbmrvG06ORPu
         tYaBmd6uizM8y2UpI7JISHaoq/iceo2fgosmmrwf8WdR9j9V3uFPzsAkgKV1xVulwKnE
         84UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731362000; x=1731966800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVBCUxEpHVUy2ZD/pMI1cthKhEWgZug8tgK47VkEhns=;
        b=s7oCMDxSBvSi7PoRWE80BcPsoSWVgPQSonws4NcYUKzQyx4WwtB1FccNnrkIi0c6Uv
         2O1dl3SsVmmLHsoqfQy7HlAM8OGk83vOtQxtEjdI6idZFR4q/5Om2H3C24z4CYC4/5Wy
         JActA6MCrm+RBle0i2BNsvfv8blpGiKXvGRcdrizsVxTX2LtiAIq4xGY4WCyZ6wSUuFJ
         5MK7BezqoJlB9LBA7bz55gsjmDmSkVOQDY2FWgsL5hPsTvFRqR3KfJOhSEyYmg2KxG8W
         rBdvoxCIIYLsTSHvzrnm0h99Mh8Zx4PRnjP3eXkwIeKE1BLNZEvUzmX+s321SGkmVigo
         1Etw==
X-Forwarded-Encrypted: i=1; AJvYcCX+8TjGN6w3MmpG+KYhYz5QOvA3IdOxV/jc3YpLfBAPq3Ps+qy1L5tmwXJbTjzWxSMBvt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNbk7KewkXw05JYVWq29802fZZ8OP/aRnBGMVndaH7E3eLDz+7
	zmJsBI/GRT2QVTtFsunVntWBslShovgbJAx+0cz/wG68ZmNWPiEHHRJ4ij0wnhUShVLPU7Fyu+t
	qeZ1cz/li3VkRN/1wkOQwh4k5onU=
X-Google-Smtp-Source: AGHT+IF5eiAQevtENgCPa89yexyqwdCnYjYJPu3k+mjzRjPwyfj72b5SQHT/tCgdyxVyYP0vTAjQAfwFve9UJJqqJek=
X-Received: by 2002:a17:90b:4ac8:b0:2e2:bd7a:71ea with SMTP id
 98e67ed59e1d1-2e9b16558admr17302573a91.8.1731362000216; Mon, 11 Nov 2024
 13:53:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030235057.1984848-1-andrii@kernel.org> <CAADnVQ+pShXOS9WnDSA5CjrGvNRC7NS-MQrgr_X_Obo5zLs8yA@mail.gmail.com>
In-Reply-To: <CAADnVQ+pShXOS9WnDSA5CjrGvNRC7NS-MQrgr_X_Obo5zLs8yA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Nov 2024 13:53:08 -0800
Message-ID: <CAEf4BzZMObcOs5NzHqY-v3scjv7zHL2oKf=zn36LsAXhYuwn8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: use common instruction history across all states
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 10:46=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Oct 30, 2024 at 4:51=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> > Async callback state enqueing, while logically detached from parent
>
> typo. enqueuing

yep, tricky word :) should be "enqueueing", fixed

>
> > -static int get_prev_insn_idx(struct bpf_verifier_state *st, int i,
> > -                            u32 *history)
> > +static int get_prev_insn_idx(const struct bpf_verifier_env *env,
> > +                            struct bpf_verifier_state *st,
> > +                            int insn_idx, u32 hist_start, u32 *hist_en=
dp)
> >  {
> > -       u32 cnt =3D *history;
> > +       u32 hist_end =3D *hist_endp;
> > +       u32 cnt =3D hist_end - hist_start;
> >
> > -       if (i =3D=3D st->first_insn_idx) {
> > +       if (insn_idx =3D=3D st->first_insn_idx) {
> >                 if (cnt =3D=3D 0)
> >                         return -ENOENT;
> > -               if (cnt =3D=3D 1 && st->jmp_history[0].idx =3D=3D i)
> > +               if (cnt =3D=3D 1 && env->insn_hist[hist_end - 1].idx =
=3D=3D insn_idx)
> >                         return -ENOENT;
> >         }
>
> I think the above bit would be easier to understand if it was
> env->insn_hist[hist_start].
>
> When cnt=3D=3D1 it's the same as hist_end-1, but it took me more time
> to grok that part. With [hist_start] would have been easier.
> Not a big deal.

yep, I agree. Originally I didn't pass hist_start directly, so I would
have to use st->insn_hist_start, and it felt too verbose. But now
that's not a problem, I'll use hist_start everywhere.

>
> Another minor suggestion...
> wouldn't it be cleaner to take hist_start/end from 'st' both
> in get_prev_insn_idx() and in get_insn_hist_entry() ?
>
> So that __mark_chain_precision() doesn't need to reach out into
> details of 'st' just to pass hist_start/end values into other helpers.

Note that for get_prev_insn_idx() we modify (but only locally!)
hist_end, as we process instruction history for the currently
processed state (we do a virtual stack pop for each entry). So we
can't just use st->insn_hist_end, we need a local copy for hist_end
that will be updated without touching the actual insn_hist_end. That's
the reason I have `u32 hist_end =3D st->insn_hist_end;`, to pass
&hist_end into get_prev_insn_idx().

Having said that, if you prefer, I can fetch insn_hist_{start, end}
from st, always, but then maintain local hist_cnt as input argument
for get_insn_hist_enrty() and in/out argument for get_prev_insn_idx().
Would you prefer that? something like below:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 15245206d883..34bed6be7449 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3586,10 +3586,14 @@ static int push_insn_history(struct
bpf_verifier_env *env, struct bpf_verifier_s
 }

 static struct bpf_insn_hist_entry *get_insn_hist_entry(struct
bpf_verifier_env *env,
-                                                      u32 hist_start,
u32 hist_end, int insn_idx)
+                                                      struct
bpf_verifier_state *st,
+                                                      u32 hist_cnt,
int insn_idx)
 {
-       if (hist_end > hist_start && env->insn_hist[hist_end - 1].idx
=3D=3D insn_idx)
-               return &env->insn_hist[hist_end - 1];
+       u32 hist_idx =3D st->insn_hist_start + hist_cnt - 1;
+
+       if (hist_cnt > 0 && env->insn_hist[hist_idx].idx =3D=3D insn_idx)
+               return &env->insn_hist[hist_idx];
+
        return NULL;
 }

@@ -3608,21 +3612,20 @@ static struct bpf_insn_hist_entry
*get_insn_hist_entry(struct bpf_verifier_env *
  */
 static int get_prev_insn_idx(const struct bpf_verifier_env *env,
                             struct bpf_verifier_state *st,
-                            int insn_idx, u32 hist_start, u32 *hist_endp)
+                            int insn_idx, u32 *hist_cntp)
 {
-       u32 hist_end =3D *hist_endp;
-       u32 cnt =3D hist_end - hist_start;
+       u32 cnt =3D *hist_cntp;

        if (insn_idx =3D=3D st->first_insn_idx) {
                if (cnt =3D=3D 0)
                        return -ENOENT;
-               if (cnt =3D=3D 1 && env->insn_hist[hist_start].idx =3D=3D i=
nsn_idx)
+               if (cnt =3D=3D 1 &&
env->insn_hist[st->insn_hist_start].idx =3D=3D insn_idx)
                        return -ENOENT;
        }

-       if (cnt && env->insn_hist[hist_start].idx =3D=3D insn_idx) {
-               (*hist_endp)--;
-               return env->insn_hist[hist_start].prev_idx;
+       if (cnt && env->insn_hist[st->insn_hist_start].idx =3D=3D insn_idx)=
 {
+               *hist_cntp =3D cnt - 1;
+               return env->insn_hist[st->insn_hist_start].prev_idx;
        } else {
                return insn_idx - 1;
        }
@@ -4378,8 +4381,7 @@ static int __mark_chain_precision(struct
bpf_verifier_env *env, int regno)

        for (;;) {
                DECLARE_BITMAP(mask, 64);
-               u32 hist_start =3D st->insn_hist_start;
-               u32 hist_end =3D st->insn_hist_end;
+               u32 hist_cnt =3D st->insn_hist_end - st->insn_hist_start;
                struct bpf_insn_hist_entry *hist;

                if (env->log.level & BPF_LOG_LEVEL2) {
@@ -4419,7 +4421,7 @@ static int __mark_chain_precision(struct
bpf_verifier_env *env, int regno)
                                err =3D 0;
                                skip_first =3D false;
                        } else {
-                               hist =3D get_insn_hist_entry(env,
hist_start, hist_end, i);
+                               hist =3D get_insn_hist_entry(env, st,
hist_cnt, i);
                                err =3D backtrack_insn(env, i,
subseq_idx, hist, bt);
                        }
                        if (err =3D=3D -ENOTSUPP) {
@@ -4436,7 +4438,7 @@ static int __mark_chain_precision(struct
bpf_verifier_env *env, int regno)
                                 */
                                return 0;
                        subseq_idx =3D i;
-                       i =3D get_prev_insn_idx(env, st, i, hist_start,
&hist_end);
+                       i =3D get_prev_insn_idx(env, st, i, &hist_cnt);
                        if (i =3D=3D -ENOENT)
                                break;
                        if (i >=3D env->prog->len) {

