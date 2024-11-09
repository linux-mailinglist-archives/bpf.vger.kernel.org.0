Return-Path: <bpf+bounces-44439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BB69C2FB6
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 23:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E98281D64
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 22:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3369819DF52;
	Sat,  9 Nov 2024 22:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mP6gfuDo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1715A42069
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 22:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731189771; cv=none; b=eoxnHuIQRo4sCfIjggvws+u4n3cV63gUBtcwBZxHDV81/qKsYH+JGlWrKD6OvjC6O3oZdk90mBUgk2F1r8YQEp6lINhmDpNwu8GchF96ox3g6WWWPf16am2r1HguknoBAsqOIj59gJ4LALMGqhATYYDIkLNlJNi0MJoqLVy+TXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731189771; c=relaxed/simple;
	bh=qvAosAedpd+8sMhgU/NQWnRD3N3syDDPeBp9kUPoz0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSGbZJSMB6E0lWfPboxk0yuNoXiznuChORAzVUfbPt5g04BJv3jUFUyQ1jldMTgP3T4s6Oa6GVk0dlNTDOB03jT5ERV30KIIMD1ApUpoLK14QdN+KmoMP7GWSW2EDYaKyJ2nP4uEjA+xA2xblXuMG5qbP1iYfpd8c+YtY24T7fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mP6gfuDo; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315eac969aso19082325e9.1
        for <bpf@vger.kernel.org>; Sat, 09 Nov 2024 14:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731189768; x=1731794568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQUnq7U+NCbWqwE5VBx3I+elLgPAfQauqCIGBB+2F6c=;
        b=mP6gfuDopwjGgpRMKD0Iu7J9B9D0BZuZMk+XYvsTPf7G0AaLhNd2Ovugi+uidjJGOV
         ERaidPWhxpwBiuctqy6a8xkru91lHFIQvubANh/KbpYRQeqlsbPDYFz7hbOVhUY69dUE
         7goQOEFhi1Grhn6vuu6QbGTIx5njVHioc8SPRbTD2Dg35cohEdHr1M468083Zg/H6+1Y
         OU1WlSgV14qHdmEsRdGxT0w4fXQmI5fgYLEKulAVbAFUuQSuyjsJrbBUOYDDXahD5rFO
         2g3OT59MAa17GUeepZ4VDUhFepzGCkVoBif625yj6fZUCbNel+SFG7ObmC3YUUz0urx/
         Xdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731189768; x=1731794568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQUnq7U+NCbWqwE5VBx3I+elLgPAfQauqCIGBB+2F6c=;
        b=K99gdrn4G3BoY8uLt0/dAA5T3j+aYlJYBdFKxYSEejCoj+xBqZAWBEEjKWXKZ8BwXD
         wUYQWV+bMNEt86gfuMNGTbR4IFM3+tV40/ZStKQBHvOfx34Z4tJKxsfP8WxwKrOf8s3F
         HE3aEo8EQgMoZ0oF61JCkxhrRsInHbe6ztzXnZgkj1pgYNQMfigcPi7tt9Lva2ic7/Gk
         Z/WUwt79l4aHh+zVp5Oqxg978bBM3lRC7tqLXJnGFPNmE7wugM1d/BgN1AYg3zIZ+Img
         bHX6TxUV/e4lSVbtOLP7g15M2KtzcdpfUZJj9fYaly58J2nzvrhNIzjiG2+dx5CyXkuO
         Z5Iw==
X-Gm-Message-State: AOJu0Yw7rO1+mFeDBMfZ4qSREVpBFluLTf3IvkJHU78+33pPkOz/oi2e
	nYLUL3+zYYt/TTFSoKED2CgcTqg0O5UxFrv5+KlyiBVraa0QlYkjc3DGxrAjI6sTe462Bt7yzp0
	iIB4mkPL5eGiY+5tgBpyyFzyR7VU=
X-Google-Smtp-Source: AGHT+IHS/KSOKgfviK//euSUj+sj68+wq1pN5vgt8CTa9QflHmzrmcdtUe/Y7nDrs82nW0PhTNqRu/cmB+IKFCVxAwc=
X-Received: by 2002:a05:600c:a085:b0:431:559d:4103 with SMTP id
 5b1f17b1804b1-432b747dc59mr64336435e9.7.1731189768271; Sat, 09 Nov 2024
 14:02:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109074347.1434011-1-memxor@gmail.com> <CAADnVQKnYwooCPe5uku5yE1_VXxFiKrH=UW45SRUzRUb5TwmXg@mail.gmail.com>
 <CAP01T74MkwO9TA1zU1RzrFR+LYnd+1oyNEidWm0HU1e88LpJNQ@mail.gmail.com>
In-Reply-To: <CAP01T74MkwO9TA1zU1RzrFR+LYnd+1oyNEidWm0HU1e88LpJNQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 9 Nov 2024 14:02:37 -0800
Message-ID: <CAADnVQKxgE7=WhjNckvMDTZ5GZujPuT3Dqd+sY=pW8CWoaF9FA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpf: Refactor active lock management
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 1:38=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> On Sat, 9 Nov 2024 at 22:30, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Nov 8, 2024 at 11:43=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >  struct bpf_retval_range {
> > > @@ -434,7 +431,7 @@ struct bpf_verifier_state {
> > >         u32 insn_idx;
> > >         u32 curframe;
> > >
> > > -       struct bpf_active_lock active_lock;
> > > +       int active_lock;
> >
> > What about this comment from v3:
> > > +       bool active_lock;
> >
> > In the next patch it becomes 'int',
> > so let's make it 'int' right away and move it to bpf_func_state
> > next to:
> >         int acquired_refs;
> >         struct bpf_reference_state *refs;
> >
> > ?
>
> Ah, sorry, I somehow missed this part of the comment (twice). Mea culpa.
>
> >
> > wouldn't it be cleaner to keep the count of locks in bpf_func_state
> > next to refs
> >
> > acquire_lock_state() would increment it and release will dec it.
> >
> > check_resource_leak() will
> > instead of:
> > env->cur_state->active_lock
> > do:
> > cur_func(env)->active_lock
> >
> > so behavior is the same, but counting of locks is clean.
> >
> > Since in this patch it's kinda counting locks across all frames
> > which is a bit odd.
>
> It would work, but we'd need to copy it over to a new frame's
> bpf_func_state and copy it back on exit.
> None of that would matter currently as only one lock can be held, but
> it would become relevant later.
>
> It's the same situation with reference states. It is inherited from
> the parent frame for every new frame, and then possibly changed, and
> then copied back to parent frame.

Exactly, but since we're unifying held locks as references
would it make sense to treat them the same way everywhere?
active_lock is just a count of held locks in ref state.
For refs we do:
if (!exception_exit && state->in_callback_fn &&
state->refs[i].callback_ref !=3D state->frameno)

so that
  task =3D task_acquire().
  bpf_loop(cb)
  task_release(task)
doesn't trip.

Wouldn't we want the same for locks eventually ?

Just if (env->cur_state->active_lock) will change obviously.
We may even need two counters for regular and resilient locks ?
And in that case two counters in bpf_verifier_state looks even more odd.
While two counters in bpf_func_state feels more logical.

Just trying to anticipate the future changes...

