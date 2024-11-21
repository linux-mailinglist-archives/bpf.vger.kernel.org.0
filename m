Return-Path: <bpf+bounces-45395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D21F9D517C
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 18:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 293092821C8
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 17:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A164014387B;
	Thu, 21 Nov 2024 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdiu0XiJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DDF55C29
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732209519; cv=none; b=df2qoDuRgxFi51JRoE7Mxv0DI+9VKAA+FMjFi477WolLzUMabRvm9VOCgl8mzBphYvX/f+QzkQx8aFGFfTeUP1rumVnDlVbi9CxIXJEM5SexSARoerz90sbidDRRDoXKBh1iZXi4HbuYK++/IVDQziL+91YLs3bfYkesNCUK4vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732209519; c=relaxed/simple;
	bh=gPms+ol+l1Y262IWP9Lptx/KZWuLYPncPsybnMvCVzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krwS8gkxGcXNsD0IBKpa+D+Kh7wRwQKwWBwdVmz7TPaq9HX3KoHnroXpVmPibqhYxwh3nMLHkVcEmmIz34tCyocYwM0MVcOi6gJ4NsHuBbSBReIc5OqOrva+Zkr0I4oTU8UOpTWZkkp1xR67GlQOuZEfygmgHqxGhlfbTgmWugk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdiu0XiJ; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5cfcd99846fso1535195a12.1
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 09:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732209516; x=1732814316; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2SxgaasyGZapOLcEXJgqTqj7Ne2T/GsN18KVIUWu0oo=;
        b=bdiu0XiJeu6HqS386Bnb/YEAkMCOaJH3pxYGhMZ68ViTm9g9ihsYJ/ECugGGxHKPia
         AFp7cMOfO/sditxknTb5Dr2cLqQFRAysTqy8iE/3nxnaeS5g/wulP/DSRB/jlBjXhnxT
         8uM5LqEFTL5fl0xM0Y4/Dvc6NlLbeligKwtW6zv2XCtcaOyuQDn3qmcNHF4i08Z2+fp+
         xYriTbMBZBdd711dKOh0bMfQkyZlS2QRv4JzdhuCGbN6NwU3p+Ec+iNf/XYioe+UkTLm
         JQ8LqqLEzqz0md332d8xt/oPg6Roh9RsF0L4PmmquHDTHrB0Pu1huam9pFP4Yx2TxFD/
         uOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732209516; x=1732814316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SxgaasyGZapOLcEXJgqTqj7Ne2T/GsN18KVIUWu0oo=;
        b=b2ZpSy982vzT1O16DzUWesXSPIpwFOzxqNJJei1/YMJQcLDUz1nIP7w18J1ejFVD2L
         zoR4uPOPAiaPNOsk189o1/XnyNj/NfDrAi8faUv9ppI91/B4Ix6kBAGqTczOwjt5qN1+
         8N5xR3ZAXc6InK50MnfnQUQp7Ph/Aywks/tIimi/p/W38HOmw4c1npkelFG7Fh0N/sdr
         HeO2hdpOJw6d4B7pEcZ2Qy5VEfpSfOAcMd5RCKEaReq+EvERT5yFpr8KE1l7jyJcCSq6
         aL1H5iQ/jdnnFxi2OwrKD1aInRirQJn1HWxSNBBPoNZjFbvEz7xEgS1VAiTmGdVhpOvh
         WKpA==
X-Gm-Message-State: AOJu0YzDJbSRXiV9pGA1Q/4k5Rb26ygLbPIma38AYLuxRD+KwzjaVzVB
	TTiJ89Y/jTXSuML4mFf4l8T6zuRGDuD6/z64/B5WAkN5mcxr4WJIUHkX7PHFfimcJQVaGqXn16A
	Sr+f1hUg/ww/zpqvkDNcLrF+2ljI=
X-Gm-Gg: ASbGncuduJfJ2P2fOKgS4j6f+uxvysL+ThlCHnESPdyo5MkXet8t1+fu73JV3AuNY/A
	ebdV0+9TJ/aRb6dxhwKA9N27MMZIgGjY/vw==
X-Google-Smtp-Source: AGHT+IFFy1XKl6KNfSZ91/CpUlToVs/V0Q67ZsBL2zbkc+EI62T5fatrjtI6A2hpZk4GgWScOkOhKy/NGYRQhgMy5oA=
X-Received: by 2002:a05:6402:4404:b0:5cf:d5ad:2809 with SMTP id
 4fb4d7f45d1cf-5cff4cb51c3mr5770515a12.24.1732209515499; Thu, 21 Nov 2024
 09:18:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121005329.408873-1-memxor@gmail.com> <20241121005329.408873-2-memxor@gmail.com>
 <4be3db522e31ea88119751d4e2d64a9e90397f6c.camel@gmail.com>
In-Reply-To: <4be3db522e31ea88119751d4e2d64a9e90397f6c.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 21 Nov 2024 18:17:59 +0100
Message-ID: <CAP01T74rEk=L471JwTqfEJ_WVrLb=wtBdvE6xFUofTux3V=JGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/7] bpf: Refactor and rename resource management
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 17:57, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2024-11-20 at 16:53 -0800, Kumar Kartikeya Dwivedi wrote:
> > With the commit f6b9a69a9e56 ("bpf: Refactor active lock management"),
> > we have begun using the acquired_refs array to also store active lock
> > metadata, as a way to consolidate and manage all kernel resources that
> > the program may acquire.
> >
> > This is beginning to cause some confusion and duplication in existing
> > code, where the terms references now both mean lock reference state and
> > the references for acquired kernel object pointers. To clarify and
> > improve the current state of affairs, as well as reduce code duplication,
> > make the following changes:
> >
> > Rename bpf_reference_state to bpf_resource_state, and begin using
> > resource as the umbrella term. This terminology matches what we use in
> > check_resource_leak. Next, "reference" now only means RES_TYPE_PTR, and
> > the usage and meaning is updated accordingly.
> >
> > Next, factor out common code paths for managing addition and removal of
> > resource state in acquire_resource_state and erase_resource_state, and
> > then implement type specific resource handling on top of these common
> > functions. Overall, this patch improves upon the confusion and minimizes
> > code duplication, as we prepare to introduce new resource types in
> > subsequent patches.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> Tbh, I like the old name a bit more.
> The patch itself looks good.
>

I am happy for suggestions on better naming, but it would be better to
make a distinction somehow.

> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > @@ -1342,6 +1342,25 @@ static int grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state
> >       return 0;
> >  }
> >
> > +static struct bpf_resource_state *acquire_resource_state(struct bpf_verifier_env *env, int insn_idx, int *id)
>
> Nit: there is no need to pass `int *id`, as it is available as (returned)->id.
>

Replaced with a bool alloc_id to decide whether it generates a new id
or not, and fixed.

> > +{
> > +     struct bpf_func_state *state = cur_func(env);
> > +     int new_ofs = state->acquired_res;
> > +     struct bpf_resource_state *s;
> > +     int err;
> > +
> > +     err = resize_resource_state(state, state->acquired_res + 1);
> > +     if (err)
> > +             return NULL;
> > +     s = &state->res[new_ofs];
> > +     s->type = RES_TYPE_INV;
> > +     if (id)
> > +             *id = s->id = ++env->id_gen;
> > +     s->insn_idx = insn_idx;
> > +
> > +     return s;
> > +}
> > +
> >  /* Acquire a pointer id from the env and update the state->refs to include
> >   * this new pointer reference.
> >   * On success, returns a valid pointer id to associate with the register
>
> [...]
>
> > @@ -1349,55 +1368,52 @@ static int grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state
>
> [...]
>
> > -/* release function corresponding to acquire_reference_state(). Idempotent. */
> > +static void erase_resource_state(struct bpf_func_state *state, int res_idx)
>
> Nit: why not "release_..." to be consistent with the rest of the functions?
>

This was a subset of what "release_resource_state" would have done,
since it erases a res_idx,
but on second thought, it's probably better to rename, so fixed as well.

Thanks for the review.

> > +{
> > +     int last_idx = state->acquired_res - 1;
> > +
> > +     if (last_idx && res_idx != last_idx)
> > +             memcpy(&state->res[res_idx], &state->res[last_idx], sizeof(*state->res));
> > +     memset(&state->res[last_idx], 0, sizeof(*state->res));
> > +     state->acquired_res--;
> > +}
> > +
> >  static int release_reference_state(struct bpf_func_state *state, int ptr_id)
> >  {
> > -     int i, last_idx;
> > +     int i;
> >
> > -     last_idx = state->acquired_refs - 1;
> > -     for (i = 0; i < state->acquired_refs; i++) {
> > -             if (state->refs[i].type != REF_TYPE_PTR)
> > +     for (i = 0; i < state->acquired_res; i++) {
> > +             if (state->res[i].type != RES_TYPE_PTR)
> >                       continue;
> > -             if (state->refs[i].id == ptr_id) {
> > -                     if (last_idx && i != last_idx)
> > -                             memcpy(&state->refs[i], &state->refs[last_idx],
> > -                                    sizeof(*state->refs));
> > -                     memset(&state->refs[last_idx], 0, sizeof(*state->refs));
> > -                     state->acquired_refs--;
> > +             if (state->res[i].id == ptr_id) {
> > +                     erase_resource_state(state, i);
> >                       return 0;
> >               }
> >       }
>
> [...]
>

