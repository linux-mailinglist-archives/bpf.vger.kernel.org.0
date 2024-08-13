Return-Path: <bpf+bounces-37063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9489B950B30
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 19:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16FCD1F21F76
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 17:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4E21A38DF;
	Tue, 13 Aug 2024 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsylJmIm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F8A1A2577;
	Tue, 13 Aug 2024 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568817; cv=none; b=FLFMoPqj3N8Ph7kfcHaQKbD6kC9rIRxNT2tfShWDcwSxkXKGQkkQg1yH/tsoe99IF8zayfMVK1fVxZSs9OjV5JMCVoRXmtlet25U0VCpKdkLp92NVf2dCVSmdRJYZMab78KC9okDSZ7Pga9id2PrwO5QVZ6/5nB5dG9n8a9kFgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568817; c=relaxed/simple;
	bh=DbTs+6qUSxM/zQtbMATbgJnGl+ENAqWdNNjHdEwF6DE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBmcyrqfBV14/Xk6+ITCboQaOmmFsVfZcD6/CiPJwkLrIJycNBkGy03hX3smwe159nna+OyLSBRspdMswDbTJ4MC33wwDYUqOU5XbUmx/D14FC2o9N7nx9lzZkKjIJiL11/eTMu16WzHlBsvcb9LleptM27D7IZPhgzVuJCOuIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsylJmIm; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44fee8813c3so34230441cf.2;
        Tue, 13 Aug 2024 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723568815; x=1724173615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2i/rjbVHkUl3elxDfPidCteOPniWSNb8rDJSw5+dOgQ=;
        b=HsylJmIm7FfYP5eQ+dT8Y/58J0OdyJZ/Icp9x3iF167AM3Bhjto/tERV9/ZdGWww3f
         dVpEcueI6mBv9ETKEuT7Gt3mWwQBhR+7vfooWzCko9+qliVSBubb0pP7n99Xdf9bPW4X
         JiebKH9J99U91wBJCjNzNtNyMmlx0XX+f+zJ85rDvsFBw8pp74AAZXuwQJxZ97gq5tM/
         0gRWNT5yDg/YdrONwUmob7Lryz+Vh1vEJ1Ku9Tr5o6tqA0GEenCZNlhHcJXULgsiPWBO
         M+8OgUXcAui4FMbOuaKt1soySmyKHj/6KFTrAID0KZqrp8MExPjAVTexCSZNTK5wOqV8
         5iTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568815; x=1724173615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2i/rjbVHkUl3elxDfPidCteOPniWSNb8rDJSw5+dOgQ=;
        b=wyJAfUjLhGNsJz5SEKSpO0nlQAxmegGsmjZaJ7LSbuOnszIIlQ0GVveWjNRDEFLQTo
         CBrJSTtyOM8m1vc0e4wL8Up9Rrc2qZdBIP6wlGLZ/DodzRy9Mm85jLXKa0eKKhjOa5hi
         HoxIZrJeBBW7j4mcOFOULYnzWEMwL2biTPsg9hbvEBGprpJDuInQxP7fd2+mL4cZ+ljc
         IMuGf15Tvsug4/+JLKStUC6D/YDe0PQ+U2ZLaQy4v5K5PIK26h8oZ5NEYcs1c64G8TK9
         NIw12TBTuww2FzPDoB1UPMjEsGU3UIJfXu+lMF0MRyJLu1YvE2OgTjAYYCWsoCFtb32x
         ecfg==
X-Forwarded-Encrypted: i=1; AJvYcCUioA8x+rIJ5JNMQyiS9x0d04YF+T52V/dtj0HZPzQYmNqzi/K2aZXZhPEFYETIMsUmkktlOTsTquFF2F0WmXi4QjuIaSSt55J4eGv/3jqm92D3aeRwOaLcEPlwF2+RdBtErug01dJ/Eq51osp0B+cL94tobTzVhQ3LXOMflHKK2lE/M6Cp
X-Gm-Message-State: AOJu0Yw9XG+M4JgJ+vZwcDt2MnSmw7qNTHPytOfKGml82VAIty/3ByTl
	AvIDcDs3ICui6cfeGL5N+z8SB8FUnGfGOLGaLAuwCKfyoeE8/B9oK9FhoM0whjugkcsUnUTN1Ub
	aqq/vajZ3UCl0dgvmZHxzvEu9nOO7QA==
X-Google-Smtp-Source: AGHT+IEBuCVr/hLGN/Rndh5a/GKEbP2oA+HSkbMf9t7jLqYr/5kJ+ETG2zaUTGtw3I0ir3CzebnigjOR7XD9xalig2U=
X-Received: by 2002:a17:90a:4811:b0:2c9:7aa6:e15d with SMTP id
 98e67ed59e1d1-2d3aaabea62mr150642a91.20.1723568766613; Tue, 13 Aug 2024
 10:06:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809192357.4061484-1-andrii@kernel.org> <20240813145002.GB31977@redhat.com>
In-Reply-To: <20240813145002.GB31977@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Aug 2024 10:05:54 -0700
Message-ID: <CAEf4BzZmaH4y82DemPqmS-Eho-4iX91fQ2z=bhauhiDOb=98cg@mail.gmail.com>
Subject: Re: [PATCH v2] uprobes: make trace_uprobe->nhit counter a per-CPU one
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, peterz@infradead.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 7:50=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 08/09, Andrii Nakryiko wrote:
> >
> > @@ -815,13 +824,21 @@ static int probes_profile_seq_show(struct seq_fil=
e *m, void *v)
> >  {
> >       struct dyn_event *ev =3D v;
> >       struct trace_uprobe *tu;
> > +     unsigned long nhits;
> > +     int cpu;
> >
> >       if (!is_trace_uprobe(ev))
> >               return 0;
> >
> >       tu =3D to_trace_uprobe(ev);
> > +
> > +     nhits =3D 0;
> > +     for_each_possible_cpu(cpu) {
> > +             nhits +=3D READ_ONCE(*per_cpu_ptr(tu->nhits, cpu));
>
> why not
>
>                 nhits +=3D per_cpu(*tu->nhits, cpu);
>
> ?
>
> See for example per_cpu_sum() or nr_processes(), per_cpu() should work ju=
st fine...
>

I just monkeyed it from some existing code somewhere in the BPF code
base. I like per_cpu, will send a v3 and rebase it onto a linux-trace
tree.

> Other than that
>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
>

