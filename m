Return-Path: <bpf+bounces-62317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E1FAF7F6C
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 19:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A90583D75
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA39259CAF;
	Thu,  3 Jul 2025 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H20+Y8UF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D85230BC2
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751565098; cv=none; b=eWwokaWGhS9SsdjYrUQuTsZSDCNYFmrmf5wdzrHN0GhVwIGTNq6+lbTAh5BFXIrTufy07aeWH4cylvrBPoMCKHiR12mD9qx62NiQ/vQNnZWS1BCFrVEjc0iADgX6eONivkyJZjq6RlDDmasXhYyWP04JOYv0YfdB7TK7gFej7Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751565098; c=relaxed/simple;
	bh=qf3NWq23TLUo9qqfjFIv/GgB/b63nbFHem3xLjexgy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JvB+Aam+JxPRdAt0KPwsQOTTyD8LqQbklDSt9ztVPLZvtgic4idbM77goHccbYVKftvVVUDTJnund1N6WECJJevR49+hNScKgz/kyG7Az3HGQ/v6BwcF2qfutWYfn1hB+dn9ykl9vXmYyzRjmQpTkrfWuMUYKmSXBFyDtxbB/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H20+Y8UF; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ae0ccfd5ca5so18669566b.3
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 10:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751565094; x=1752169894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O15j53oaFPmBODkQy4ouYp5e1HBg1Le7Vf7w8u32jsk=;
        b=H20+Y8UFU6szT5GexhIWkaGSiLf5tQcy6MSTgOOjF7FLvwPlOt60fN6QYJkxDCsNX9
         rGm7nSqy2yc7RlwN1Hi878PNdA9yrLOfNuhHPDzAWhuomNjFW1MC473hChE+RJw5Dqgk
         AiY9eDSsp/Ar/kEQt9ScoMUGyIhevKp1tgHH1VnegbXlm0NwmKbcIEGQTkxKpN5d2I/S
         XOYNpHAd1V2YbjmrfSpQkWemNW/ECdv0Iy8tHVF37z8gHgUO0r24kUqphrNNZ3IQtC7u
         wn9zZpWO2/b2YVq+Pfamb4KtHstNoyzxDW/+LHrECuLDxsyzI/v3CV42FIyX0HKIHnMx
         txEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751565094; x=1752169894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O15j53oaFPmBODkQy4ouYp5e1HBg1Le7Vf7w8u32jsk=;
        b=Hx4tj1ZMBoh0SXzesH7QNYt83OpypCRXuVAKhez/uyKeQ7VBwNrgH8LLoc3vl/0EpQ
         sPUFEu3x/iKfHMCypnNB0YxlHTTJYtMtRUOgv8XR5cCfZ+Ubq4aDTibV1HA8UXdQ99sO
         JlpUoYO8znYmnr2iZ/hb6gWmN4XA3hndd9DFkztRlGOXvFOFVDYEUQGfnx8p5Wa2Pk5R
         Le7Ipb/yoo4u70OG7r2Z96aKbYsG+cHvnBbh3QipY40iPlRg528cqelXJi4zZHfwZqVP
         Z/gZJgjZLopxDhtZkzvDzu0WlZfPoBXBfsmJWGlK21uhJIurAEb61R0Xq0oL8mqZGpjn
         QALg==
X-Gm-Message-State: AOJu0YxH1avdCqdivGgzkUw/hfx0qGqEnV/Fx5ZvIMcZHv6DFdiN4Bdl
	v+LZrb1eWBV7crTAnHv1WSs1bKn+n5wxCaEjbUAgSjwSDiKcmMFWfQS0xDxyhaXvO9H54fARf4B
	xcJSJhrts0l2S72MDpHwAs93pZEkZVqE=
X-Gm-Gg: ASbGncsGsS9QiGYPQw/aWhhOdi0m+zGRwIuttUntH/ATiJDCfWlunk212oGqlvNAlM/
	qqkGdYBm2TvVVvJwf/9tRBb/kinCfkJEiQijC+Ij0cn3ts/DWG+cV9z0GKRrjL5z1O+XgXT8Aow
	76FC0oT0uuBNNbif2A4EC64dmdrMrQa/+PHoLQug2Op2TqbU7Mg6zMLEv4t1qCNDwBlRt1xOeWc
	ec=
X-Google-Smtp-Source: AGHT+IHm/qTO9vFMbYjwSZsm4OtaTJD6UkOsGjwE3CFfppBBdtmRzg8Bco1k9EAUhjgYJa4G+ep6KOr4oJL3UDJqycg=
X-Received: by 2002:a17:907:9612:b0:ae3:b532:6fe8 with SMTP id
 a640c23a62f3a-ae3c2e34187mr818940966b.57.1751565093578; Thu, 03 Jul 2025
 10:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702031737.407548-1-memxor@gmail.com> <20250702031737.407548-7-memxor@gmail.com>
 <CABFh=a6iWx9wjxYARijv=Vd5UeU=Qiy1DKf93Gs+J+izE35dsQ@mail.gmail.com>
In-Reply-To: <CABFh=a6iWx9wjxYARijv=Vd5UeU=Qiy1DKf93Gs+J+izE35dsQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 3 Jul 2025 19:50:56 +0200
X-Gm-Features: Ac12FXwnUDspc1tvNaR1aaMT261QkTRuMUXGyRA5GnJnlf0RsUjM6ZNfGUwkQ-o
Message-ID: <CAP01T74ikfq184skYnKzXzfKtX0=JwTK-s4DPkfnqtVs848fQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 06/12] bpf: Add dump_stack() analogue to print
 to BPF stderr
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Jul 2025 at 18:26, Emil Tsalapatis <emil@etsalapatis.com> wrote:
>
> On Tue, Jul 1, 2025 at 11:17=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Introduce a kernel function which is the analogue of dump_stack()
> > printing some useful information and the stack trace. This is not
> > exposed to BPF programs yet, but can be made available in the future.
> >
> > When we have a program counter for a BPF program in the stack trace,
> > also additionally output the filename and line number to make the trace
> > helpful. The rest of the trace can be passed into ./decode_stacktrace.s=
h
> > to obtain the line numbers for kernel symbols.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h |  2 ++
> >  kernel/bpf/stream.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> >
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 4d577352f3e6..18f8e4066e20 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -3615,8 +3615,10 @@ __printf(2, 3)
> >  int bpf_stream_stage_printk(struct bpf_stream_stage *ss, const char *f=
mt, ...);
> >  int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_pr=
og *prog,
> >                             enum bpf_stream_id stream_id);
> > +int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss);
> >
> >  #define bpf_stream_printk(ss, ...) bpf_stream_stage_printk(&ss, __VA_A=
RGS__)
> > +#define bpf_stream_dump_stack(ss) bpf_stream_stage_dump_stack(&ss)
> >
> >  #define bpf_stream_stage(ss, prog, stream_id, expr)            \
> >         ({                                                     \
> > diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> > index c4925f8d275f..370eae669300 100644
> > --- a/kernel/bpf/stream.c
> > +++ b/kernel/bpf/stream.c
> > @@ -2,6 +2,7 @@
> >  /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> >
> >  #include <linux/bpf.h>
> > +#include <linux/filter.h>
> >  #include <linux/bpf_mem_alloc.h>
> >  #include <linux/percpu.h>
> >  #include <linux/refcount.h>
> > @@ -476,3 +477,46 @@ int bpf_stream_stage_commit(struct bpf_stream_stag=
e *ss, struct bpf_prog *prog,
> >         llist_add_batch(head, tail, &stream->log);
> >         return 0;
> >  }
> > +
> > +struct dump_stack_ctx {
> > +       struct bpf_stream_stage *ss;
> > +       int err;
> > +};
> > +
> > +static bool dump_stack_cb(void *cookie, u64 ip, u64 sp, u64 bp)
> > +{
> > +       struct dump_stack_ctx *ctxp =3D cookie;
> > +       const char *file =3D "", *line =3D "";
> > +       struct bpf_prog *prog;
> > +       int num, ret;
> > +
> > +       rcu_read_lock();
> > +       prog =3D bpf_prog_ksym_find(ip);
> > +       rcu_read_unlock();
> > +       if (prog) {
> > +               ret =3D bpf_prog_get_file_line(prog, ip, &file, &line, =
&num);
> > +               if (ret < 0)
> > +                       goto end;
>
> I assume that this is by design that if we cannot resolve the IP to a
> source line
> we just dump the IP and continue the stack walk.

Right, we fall back to what we do for non-bpf frames.

>
> > +               ctxp->err =3D bpf_stream_stage_printk(ctxp->ss, "%pS\n =
 %s @ %s:%d\n",
> > +                                                   (void *)ip, line, f=
ile, num);
> > +               return !ctxp->err;
> > +       }
> > +end:
> > +       ctxp->err =3D bpf_stream_stage_printk(ctxp->ss, "%pS\n", (void =
*)ip);
> > +       return !ctxp->err;
> > +}
> > +
> > +int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss)
> > +{
> > +       struct dump_stack_ctx ctx =3D { .ss =3D ss };
> > +       int ret;
> > +
> > +       ret =3D bpf_stream_stage_printk(ss, "CPU: %d UID: %d PID: %d Co=
mm: %s\n",
> > +                                     raw_smp_processor_id(), __kuid_va=
l(current_real_cred()->euid),
> > +                                     current->pid, current->comm);
> > +       ret =3D ret ?: bpf_stream_stage_printk(ss, "Call trace:\n");
> > +       if (!ret)
>
> Nit: Can we flip this and just do
>     if (ret)
>         return ret;
> ? I get using ?: for brevity but it makes the code less obvious, and
> this specific check
> isn't even shorter than the more straightforward alternative.

Makes sense, will rework.

>
> > +               arch_bpf_stack_walk(dump_stack_cb, &ctx);
> > +       ret =3D ret ?: ctx.err;
> > +       return ret ?: bpf_stream_stage_printk(ss, "\n");
> > +}
> > --
> > 2.47.1
> >

