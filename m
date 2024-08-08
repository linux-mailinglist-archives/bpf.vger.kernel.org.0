Return-Path: <bpf+bounces-36675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1418194BB8B
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 12:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CBF5B23C49
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 10:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C528B18A6CC;
	Thu,  8 Aug 2024 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNyK+biA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53657489;
	Thu,  8 Aug 2024 10:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113974; cv=none; b=ZGJ8gitz23ckAHKFPUVdlNolnXOxtYVW2FI+GXCoL0Cb64SKJKvEXo+S8gRBo7AikShYbk8P8nJJQRwcxoHUfjvPtH+flTTQTc4CaQxz37q8VFn5Rc5uTNjoWoNoHsuM/13tV9XWlqFrEYG+0CPOetDOQXMJlIoNHXZFn3Pr5Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113974; c=relaxed/simple;
	bh=mtPWdaeQ0bQhe3SB1Eeh+IeYnHIKJ7H7jdPYy47irvo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HumfQfB2+9UTE49pZyAIXoKdiEIzQYxrWcCa9C4L/EaI4zBtsxYtn9jnWWzH8x30PmS4yYBNsIPHLumytuJfvRA4MMnlRR2++3OQvP/iNRIIbIjW6pDIn7KmVDuySX+8VbnrPonmFWg6apyiLJUpEdf32bLDHE5d9+htEvfZR+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNyK+biA; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bb477e3a6dso789470a12.0;
        Thu, 08 Aug 2024 03:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723113971; x=1723718771; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IHKi9ykob8PgDZOZwwLhrIOPSlG3JYxeUgugXLSxsbs=;
        b=QNyK+biAnhYAQSUshe2FApjgp1FvKk++oKK405kzeqfuBgv7fGVfEuhtuliN4NEJmS
         yUB1BShXHItkT3Smp3rGx/tJ+3ZHnynfTlz/SWQ9YRJiMI62InywOWgSq1fHEsVeIByk
         gpPnSbvDmVdbrpBsmrwXU2nE8t8rOeX/8PklpcHdxE7vLdWuRcg5+8X6rCY7gKaSS+UG
         7UeV92l5Re00KeKcVcM8T/RoBNviKZDvE/tapZBrzgOO1wbfrqVJNgw/8ZAaQTvSXSqn
         kBmXM69aLRjmKP/sAoqXW9wsBM+ISmv+KWwD+1IkTw+nSbP14bY1wi436crsapTdqXC6
         1F+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723113971; x=1723718771;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHKi9ykob8PgDZOZwwLhrIOPSlG3JYxeUgugXLSxsbs=;
        b=LmLlsQq5X+5+r1ejgO381w8lVK+RqSsF1greZ90b5997I+3jac0va2WszGCATDwQ6y
         xO+vSzOfjGAEx/REZ9WKsHU+vjvMguBaJ8PikxEMcpDs4PgvqVAWvkPNBp4BK42seVb9
         JvlMV8BQ+unGSkZevS4OJAgBPXFXyBBifpfpCi+fiuuve9a3Grcxou0P25WbDkjDSFfY
         amJF5exZ9nCx7zVyW1Bu2GLvU+OLkIBmSiSe2bVAQQc3IKrmht6paTBMsQnu+Y/4TmEh
         UZhsxG2by7Xyq4zYP/32HgipC0+OVVzLL3x4V6AZ6/lbwHjIqo/tg27bae7rU4HQUZzi
         7tdw==
X-Forwarded-Encrypted: i=1; AJvYcCUNiZ5XpWVGHah9NrJfSbWVITgdpHKZpcwkjiqpGcnherQftc6uKOEr9nTETUax3YkHP0PzsBLsf840fb7iYiuhSnScoL97joJkElKaq6kiJoGfYay8KVoZLIMoRObosKVG
X-Gm-Message-State: AOJu0YzAGkQq+qnU8dF7Zxq9Tbkfoy7FxRj1pu6xBigY0KMIdyKjMS8m
	kwlIaiEds5Z7qzYNI5vo1LD7kF00J5Dix7K2iWVaPBZsHsooSRja
X-Google-Smtp-Source: AGHT+IFRoXbTHp8kxNWqUxzdJ7TjIrYaauE7JYMyv6BlWpx8THWcPrznEMWjs6KZu1qW2slwMINqew==
X-Received: by 2002:a17:907:da0:b0:a7a:c106:3647 with SMTP id a640c23a62f3a-a8090f04205mr139163666b.58.1723113970508;
        Thu, 08 Aug 2024 03:46:10 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec755bsm728987766b.200.2024.08.08.03.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 03:46:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 8 Aug 2024 12:46:08 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Juri Lelli <juri.lelli@redhat.com>,
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Artem Savkov <asavkov@redhat.com>
Subject: Re: NULL pointer deref when running BPF monitor program (6.11.0-rc1)
Message-ID: <ZrSh8AuV21AKHfNg@krava>
References: <ZrCZS6nisraEqehw@jlelli-thinkpadt14gen4.remote.csb>
 <ZrECsnSJWDS7jFUu@krava>
 <CAADnVQLMPPavJQR6JFsi3dtaaLHB816JN4HCV_TFWohJ61D+wQ@mail.gmail.com>
 <ZrIj9jkXqpKXRuS7@krava>
 <CAADnVQ+NpPtFOrvD0o2F8npCpZwPrLf4dX8h8Rt96uwM+crQcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+NpPtFOrvD0o2F8npCpZwPrLf4dX8h8Rt96uwM+crQcQ@mail.gmail.com>

On Tue, Aug 06, 2024 at 11:44:52AM -0700, Alexei Starovoitov wrote:
> On Tue, Aug 6, 2024 at 6:24 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > > Jiri,
> > >
> > > the verifier removes the check because it assumes that pointers
> > > passed by the kernel into tracepoint are valid and trusted.
> > > In this case:
> > >         trace_sched_pi_setprio(p, pi_task);
> > >
> > > pi_task can be NULL.
> > >
> > > We cannot make all tracepoint pointers to be PTR_TRUSTED | PTR_MAYBE_NULL
> > > by default, since it will break a bunch of progs.
> > > Instead we can annotate this tracepoint arg as __nullable and
> > > teach the verifier to recognize such special arguments of tracepoints.
> >
> > ok, so you mean to be able to mark it in event header like:
> >
> >   TRACE_EVENT(sched_pi_setprio,
> >         TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task __nullable),
> >
> > I guess we could make pahole to emit DECL_TAG for that argument,
> > but I'm not sure how to propagate that __nullable info to pahole
> >
> > while wondering about that, I tried the direct fix below ;-)
> 
> We don't need to rush such a hack below.
> No need to add decl_tag and change pahole either.
> The arg name is already vmlinux BTF:
> [51371] FUNC_PROTO '(anon)' ret_type_id=0 vlen=3
>         '__data' type_id=61
>         'tsk' type_id=77
>         'pi_task' type_id=77
> [51372] FUNC '__bpf_trace_sched_pi_setprio' type_id=51371 linkage=static
> 
> just need to rename "pi_task" to "pi_task__nullable"
> and teach the verifier.

the problem is that btf_trace_<xxx> is typedef 

  typedef void (*btf_trace_##call)(void *__data, proto);

and dwarf does not store argument names for subroutine type entry,
so it's not in BTF's TYPEDEF either

it's the btf_trace_##call typedef ID that verifier has to work with,
I wonder we could somehow associate that ID with __bpf_trace_##call
subroutine entry which has the argument names

we could store __bpf_trace_##call's BTF_ID in __bpf_raw_tp_map record,
but we'd need to do the lookup based on the tracepoint name when loading
the program .. ATM we do the lookup __bpf_raw_tp_map record only when
doing attach, so we would need to move it to program load time

or we could 'fix' the argument names in pahole, but that'd probably
mean extra setup and hash lookup, so also not great

jirka


> 
> 
> > jirka
> >
> >
> > ---
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 95426d5b634e..1a20bbdead64 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6377,6 +6377,25 @@ int btf_ctx_arg_offset(const struct btf *btf, const struct btf_type *func_proto,
> >         return off;
> >  }
> >
> > +static bool is_tracing_prog_raw_tp(const struct bpf_prog *prog, const char *name)
> > +{
> > +       struct btf *btf = prog->aux->attach_btf;
> > +       const struct btf_type *t;
> > +       const char *tname;
> > +
> > +       if (prog->expected_attach_type != BPF_TRACE_RAW_TP)
> > +               return false;
> > +
> > +       t = btf_type_by_id(btf, prog->aux->attach_btf_id);
> > +       if (!t)
> > +               return false;
> > +
> > +       tname = btf_name_by_offset(btf, t->name_off);
> > +       if (!tname)
> > +               return false;
> > +       return !strcmp(tname, name);
> > +}
> > +
> >  bool btf_ctx_access(int off, int size, enum bpf_access_type type,
> >                     const struct bpf_prog *prog,
> >                     struct bpf_insn_access_aux *info)
> > @@ -6544,6 +6563,10 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
> >                 }
> >         }
> >
> > +       /* Second argument of sched_pi_setprio tracepoint can be null */
> > +       if (is_tracing_prog_raw_tp(prog, "btf_trace_sched_pi_setprio") && arg == 1)
> > +               info->reg_type |= PTR_MAYBE_NULL;
> > +
> >         info->btf = btf;
> >         info->btf_id = t->type;
> >         t = btf_type_by_id(btf, t->type);

