Return-Path: <bpf+bounces-61366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B251AE63E3
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 13:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619E73AC29E
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 11:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1E728C864;
	Tue, 24 Jun 2025 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGMwRVzo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5275422CBF9
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750765809; cv=none; b=g1e659QLL28+LXBUbxLfrg4HNYifFKMlldB2mshYmPRho2vrztZ/uU29Shux+/mVi3mzWRP3pdAXxPYWx8zf0qBsJL2MGwrLVVlteMuHamz1AKsNi7WA3E/H3p2fnltFSvUB04Mi0FBWmOF6eCO+Y2wJJvSGs0JDrkWn1X2SZ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750765809; c=relaxed/simple;
	bh=cJTHrSk9wN8IzAE6LwZnoFPtveZIQEjzvkTWX0QnRbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7SfTW49+F2zu65eFVpV/StLW3Pnrt8ieeqfMk94sN1zm1nWsryQz88B/ck96zqm39oPVGPneUs7G99y7j+q8LHUyTCNA+uSjYxFTRE7xawwGcp4HmA6+nSi/7rsf1pDoM5EYb2bDz0vEhMC4LQXR72nWAsoyEIGqF2AbOUNLaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGMwRVzo; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-60c01f70092so543829a12.3
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 04:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750765805; x=1751370605; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vfKxy4paMErPO/QGjvni1F33jnL80RR0ffWPIayQVik=;
        b=TGMwRVzoReut7ALPgCtZfFuEcXNtv/1LllZB6noO5iMqpFtsE0STUW6DINl7fW+v0t
         d69Qq1Aepo7iyUBA/RzMmGUeTleIo/K2XLu83PKsnL93zgg6UmO7eGlcE8awn3NxdSq2
         0iE0teQxqH31IFKGrHgvoYmNh9QMuw5oTw+aaFwfG5OgR3LEYJMNxotyM1AI+sqboHm/
         CrRW9iBUZSSNMZuv20Duar3ShT5i6jgbCp79aW/jSBOL4VT2ncteLjoqZOi9F+sJsVbL
         S8LxQZD0tIaB2uavSi5s5NtRRQnFgCwYDpgp4DL5T3483WgTlpZyu6WP5u8xmz1FE0iK
         gr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750765805; x=1751370605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfKxy4paMErPO/QGjvni1F33jnL80RR0ffWPIayQVik=;
        b=Wt5v5A07BBuArXg6Lgdfc/PtBm/GmmVWFkpG12l3qa3aJI03PnQ0gYDGI25mbchhXn
         skq9qvC5o7pay3762jhYFkNR26UhvFLu6Ve8ArhfQ3eel/+RCue+Lp4UcfXY8OAR/jze
         0L16cLOYcCtzNswV0fakWhPuNPY14Dc6iMrB65wNl1p+iBm9fy9nU559hkjnoehz3rBB
         IUEVGlN/svs69EcfZTKWkbux9UYwvEBuIuNN9gZvUpXlo/Iy/o2TcHtPDAeChub779Px
         t31uZQaWiVKQBVrsqRptBBb96GJi906H3iJc/OUrNTKJlCQBcdYp/5rE09f4Lk1CR5k3
         CC2A==
X-Gm-Message-State: AOJu0YyQUpXYY7ZSm46A37NbPjJZLZrzA0wwRrz4X88ku38u9zDrmnNe
	URl9ky6qbFNtWzLY4L1tSB2i3VohBBf343Z69M13r+hoY6D+xRfe91CDyW3VbFA+htW1HRyrb9t
	oCKBkXTjWKYypchnITj+Kk9g2aXSs4EE=
X-Gm-Gg: ASbGnctKVA/CEXwOq//bmX1jXVmftDwkA35PJ6sTlX8DcmWrr8a6VXSE0I48ZHOok1d
	SLd31BHfQ8HoIaYIO09M1fXMBejskOrReEaq/f9GQrKkzH4cZ3ZpAgSoP9/1Xg/0RDqwKLiUmPZ
	7TsLvjbhB1wiR7i3piyaPWDDH+y7yoOftX5rzW+OQwDPS+
X-Google-Smtp-Source: AGHT+IGgtcKo+nrEz5dUAH+HMEeomQITe0jDnmcdam+dNuH6eRfX9V8bC7LEdyPGjsKMgNWoMHyu/FTYETMzoc/nnnY=
X-Received: by 2002:a17:907:d2cf:b0:ad5:7bc4:84b5 with SMTP id
 a640c23a62f3a-ae057c3ecb4mr1612504266b.57.1750765805258; Tue, 24 Jun 2025
 04:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624031252.2966759-1-memxor@gmail.com> <20250624031252.2966759-7-memxor@gmail.com>
 <aFqOHariTJvjyJwX@krava>
In-Reply-To: <aFqOHariTJvjyJwX@krava>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 24 Jun 2025 13:49:28 +0200
X-Gm-Features: Ac12FXxeYhBbfX7cSS741W1XTbeb4SQ5hwe_9UPGCRh377KFdKd-tQlZJwMfHT0
Message-ID: <CAP01T75sqm+VqePRyjRkpgtpb3n+8553rBqwTQdgeBS=dOg32g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 06/12] bpf: Add dump_stack() analogue to print
 to BPF stderr
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Jun 2025 at 13:38, Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Jun 23, 2025 at 08:12:46PM -0700, Kumar Kartikeya Dwivedi wrote:
>
> SNIP
>
> > diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> > index 75ceb6379368..5fb11202ab9c 100644
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
> > @@ -483,3 +484,46 @@ bool bpf_prog_stream_error_limit(struct bpf_prog *prog)
> >  {
> >       return atomic_fetch_add(1, &prog->aux->stream_error_cnt) >= BPF_PROG_STREAM_ERROR_CNT;
> >  }
> > +
> > +struct dump_stack_ctx {
> > +     struct bpf_stream_stage *ss;
> > +     int err;
> > +};
> > +
> > +static bool dump_stack_cb(void *cookie, u64 ip, u64 sp, u64 bp)
> > +{
> > +     struct dump_stack_ctx *ctxp = cookie;
> > +     const char *file = "", *line = "";
> > +     struct bpf_prog *prog;
> > +     int num, ret;
> > +
> > +     if (is_bpf_text_address(ip)) {
> > +             rcu_read_lock();
> > +             prog = bpf_prog_ksym_find(ip);
> > +             rcu_read_unlock();
>
> do you need to check prog != NULL ?

I think it should be non-NULL, given we're walking IPs of progs with
an active stack frame so they're not going away.

>
> also is_bpf_text_address calls bpf_ksym_find and bpf_prog_ksym_find calls it again,
> I think it'd be better just to call bpf_prog_ksym_find from here
>

Good point, I will fix that. Then just check it for NULL once and
continue using it.

Thanks!

> jirka
>
>
> > +             ret = bpf_prog_get_file_line(prog, ip, &file, &line, &num);
> > +             if (ret < 0)
> > +                     goto end;
> > +             ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n  %s @ %s:%d\n",
> > +                                                 (void *)ip, line, file, num);
> > +             return !ctxp->err;
> > +     }
> > +end:
> > +     ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n", (void *)ip);
> > +     return !ctxp->err;
> > +}
> > +
> > +int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss)
> > +{
> > +     struct dump_stack_ctx ctx = { .ss = ss };
> > +     int ret;
> > +
> > +     ret = bpf_stream_stage_printk(ss, "CPU: %d UID: %d PID: %d Comm: %s\n",
> > +                                   raw_smp_processor_id(), __kuid_val(current_real_cred()->euid),
> > +                                   current->pid, current->comm);
> > +     ret = ret ?: bpf_stream_stage_printk(ss, "Call trace:\n");
> > +     if (!ret)
> > +             arch_bpf_stack_walk(dump_stack_cb, &ctx);
> > +     ret = ret ?: ctx.err;
> > +     return ret ?: bpf_stream_stage_printk(ss, "\n");
> > +}
> > --
> > 2.47.1
> >
> >

