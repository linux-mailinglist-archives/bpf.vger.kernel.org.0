Return-Path: <bpf+bounces-44438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E619C2FA5
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 22:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF355282477
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 21:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771A819EED0;
	Sat,  9 Nov 2024 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NymPuv+r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E2E2BB09
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731188331; cv=none; b=qijH6Sd4v/Awjj+YHDzeDmSArGIYObtbf6qoHO1Nn/uYSFG3UzNNwZkemzDt0i1yTNGXjBtwtaCfFAhmMeStc0A7Da5jGQIwe1OOfoIFLgaFCJ2VmIiUYucxU/1g+5uRCUIoaoi+fIJVRATtNxAzrBuwpgFxS8LIfFgDDoxuKzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731188331; c=relaxed/simple;
	bh=rJ8GLX3Qer6J34/nd00wO4jgv5A7D/TseP0CyQ1bRAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKJFqMJClDqM2QbtnTti8S3VztqXk02dQP9UiNCfJm6mN0K9dDxmmxgGBPtCzC1HeHInrue3p91SXLukShbQ0M45JzRvgMZW9jIRJDA8VcUqA6bg3+tXInrLH2ragHTc6suCF7UnUMU+vPsSfGGIwBZzybUYSBT/4qtg1jG6FRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NymPuv+r; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a9aa8895facso615338466b.2
        for <bpf@vger.kernel.org>; Sat, 09 Nov 2024 13:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731188327; x=1731793127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFYf5SoWz92LzcMuiGAF63/HvmQtRM50q2UYWO6SsIU=;
        b=NymPuv+rnOaSRF9v3rbAU8fhdaFZugS6UOuMvrez4/iIhTLU8jTvxFWuaouU1haoS+
         XoVf6ZbVJ0QjX1LZnPGyzwCuHM+pxaFnZH0oqA16iXTSCvJy+LpRUxFBUqR879VhsPZU
         Tayt+pnIuqB0vihbxSOYn1WBc4BkoowhnR259cmgYiQytm+2vfhwEUUByb4KDZ3k7Xzc
         X8/ZroJ1VZ6fitk7Wwh5S6Q/LuV+LSrUyVeythLyyNn9J2epf+HnG46D5Rgjs5jZR7vY
         LWZp8Tbrh1sNACeGCPJZ+x561SxXvHEmnDSfYIh2oPJ4zXk/29Nbhy3XmQhKuujCNGWR
         HLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731188327; x=1731793127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFYf5SoWz92LzcMuiGAF63/HvmQtRM50q2UYWO6SsIU=;
        b=IrsUjpOVdgv2jmTnSfjoR4rJk56CqoDrUCHms7RatBlyP5XqWbLKoSBbySxOlRvPCN
         sgr0D5hNtalGKQUrBOmNbJOqHAepK4B/HTqQwMzsUzWdGJ4Z0Br41A6dbL4ritsMtPMV
         6vtocRVUX1Rxadw4wGWCsOw1V3YP2BD2+KtGaimyxpgdPddpJ9kShEUYWexN3i0ke26M
         4+sIpKg206hUk8/wtDcVOvRzwbTvQfeK3DspZhsNcVX1FiHUFa86G59LUnTR1EBTuTRW
         08Q9ULMN9AyZwvNetiYOzBI/GkNIo3YIo3eIIDzMATwt8GtuLdwlEf01DFaHkTfq92Dm
         VNJA==
X-Gm-Message-State: AOJu0YzU2fcTO6mnK3KwQZmZb6uO/YLTYGzd0Sx5VJKfo6UUpok34wcb
	kz553mWoabbxR96ZMroHK0cNksidLpykoY16Yn067jFSAtL/hsgcRs0Vqajdo3XI6bqeyXB04p2
	qOwzHlWqUnbVxKSajnCelS1XKrpI=
X-Google-Smtp-Source: AGHT+IHLSo6CBdaH6vWKh7VF3cMxtdW/BHAZ1DulvuFGLulmtGPkB91I8U3pslQ6yb532GO4WwQI46Nvak1LpvoEWAE=
X-Received: by 2002:a17:906:ef0e:b0:a9a:8034:3644 with SMTP id
 a640c23a62f3a-a9eefee4555mr698216066b.14.1731188327296; Sat, 09 Nov 2024
 13:38:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109074347.1434011-1-memxor@gmail.com> <CAADnVQKnYwooCPe5uku5yE1_VXxFiKrH=UW45SRUzRUb5TwmXg@mail.gmail.com>
In-Reply-To: <CAADnVQKnYwooCPe5uku5yE1_VXxFiKrH=UW45SRUzRUb5TwmXg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 9 Nov 2024 22:38:10 +0100
Message-ID: <CAP01T74MkwO9TA1zU1RzrFR+LYnd+1oyNEidWm0HU1e88LpJNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpf: Refactor active lock management
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 9 Nov 2024 at 22:30, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 8, 2024 at 11:43=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >  struct bpf_retval_range {
> > @@ -434,7 +431,7 @@ struct bpf_verifier_state {
> >         u32 insn_idx;
> >         u32 curframe;
> >
> > -       struct bpf_active_lock active_lock;
> > +       int active_lock;
>
> What about this comment from v3:
> > +       bool active_lock;
>
> In the next patch it becomes 'int',
> so let's make it 'int' right away and move it to bpf_func_state
> next to:
>         int acquired_refs;
>         struct bpf_reference_state *refs;
>
> ?

Ah, sorry, I somehow missed this part of the comment (twice). Mea culpa.

>
> wouldn't it be cleaner to keep the count of locks in bpf_func_state
> next to refs
>
> acquire_lock_state() would increment it and release will dec it.
>
> check_resource_leak() will
> instead of:
> env->cur_state->active_lock
> do:
> cur_func(env)->active_lock
>
> so behavior is the same, but counting of locks is clean.
>
> Since in this patch it's kinda counting locks across all frames
> which is a bit odd.

It would work, but we'd need to copy it over to a new frame's
bpf_func_state and copy it back on exit.
None of that would matter currently as only one lock can be held, but
it would become relevant later.

It's the same situation with reference states. It is inherited from
the parent frame for every new frame, and then possibly changed, and
then copied back to parent frame.

I have no preference either way, but if you think maintaining it as
part of func state is better I can make that change.

