Return-Path: <bpf+bounces-31291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FA68FAC4E
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 09:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 265C31C20C89
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 07:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9C2140E5B;
	Tue,  4 Jun 2024 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BX273j6L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE9213E888
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717486949; cv=none; b=Kn32K6dsNe9sWDtN2S+JUT4PZfNWWxVYs6DbZVjvKTCiBDVZ95OnYacrmLdedTNwx4mkpnHTsVarqRYqw/qGcgBUiqKfdX82sxpfHTjIysNol29wSi/Gh3TWGlZoNb4zSBI9jfBRMvqrL5JRy0dvG+RDU+75nrxVdYEXN8HMtL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717486949; c=relaxed/simple;
	bh=gSlJvYvq7l766YN6f/WHgoWGynnUXRIxmIUBxSDkM1g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTQZ+6jotdBbwLYSdNUwhRwxju0JgpvABYfxtQaCS8Z5CiNva8Wsd+Lz+poD3NU0aEm4rlrTcBVHksu9IbXnUebJ5Szi+egHEe2hnLxTjolqPqudhMHlSRgqnh3fhd8eCyNz2Dsv+Z/Xra0XqWU9C93dwV8k1eHlyt3Jwm3klRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BX273j6L; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eaad2c670aso7858271fa.1
        for <bpf@vger.kernel.org>; Tue, 04 Jun 2024 00:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717486945; x=1718091745; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JawoabPgxScGBG3pTtS7BAuxbAtr+7QqrMbL5g0OdYk=;
        b=BX273j6LuhJTIKi34caiTVu+IrfXeQ5LVpm4fSpKPLAwY5iB4/n2BMfchyqgOtd97m
         0foE1TAYefEuuGC17uGyzz1Ajd+/b7VovyyYI5d89vS0AiDVjJ0ZSdJDMQ7lRe36KrZ1
         uQWJfy0bWAkXZBONgWdqP3ZCywDsH9849rtOVylPMzciBhq+vCEUUWH+drr5MEGZWOEF
         aZPS95OqdHT95NqRYULC268NbYtrgJZpjt0hRx8pehPq6Ql8IPqxZE4R5xci3fJhrC3x
         j6p0WeQwMAcjflgX8vty8wPY7/XIcuJO7HYHvUsYQfhwk+cjkYctquaIF6++29I91QXx
         ayUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717486945; x=1718091745;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JawoabPgxScGBG3pTtS7BAuxbAtr+7QqrMbL5g0OdYk=;
        b=K0cHGp/ySJIrkcW55MhZ4yctuM3uCffagx1gtJP4aMKKnrkdJq6OCqCu8amOlJG6vB
         w1rEVcHCOsStuph2Eu9KZB+mQUFlNuIFUvz5AGMpQWXJuJlTme/iM6GBr7zjUgjQj5+A
         1RPXXPXNAWs1m5zPRUG3QO+AHeyjLkAlr5R5OderAVHTUrPaurtnTGA6/vDO0EcgyleJ
         UQgY+Y0hp7xNj82z8y7IGzia/T+0j498J2KxBBPMkHv79zJyH7Tuv2Vj2/dO/ZJPvI5T
         2C/2VlH/Wr06GyY2nG45244wJRgjDeV0/2+OW1sHKP6G9VQYDt4jMbm10REd+h0cO5sU
         LNWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgrU37DY8QNAs3mnsM1DoONQqVGyZp/3miSpQiC+LG1bZ7QtGSl4Abc/Ci0VOI9z2mixanOpOae+AxqYl6foMPXxMF
X-Gm-Message-State: AOJu0YxPCjILPywOiHecvOpTxlUOZTR5VOPRwL6Iuq/CcZ7XUHcoQ4BD
	TDrJ2Gx3EYMrSzrVNkHHfw7fdFvwa0Ulxxa3hRYGx+ZwZPFyeVk8
X-Google-Smtp-Source: AGHT+IGIgyTOpdOo/nAQNexy0tIK9NWIBzlQgvYM4aTYoBMKwqtYIKnAsyuJ63jmj4x3Qxx72EEYCg==
X-Received: by 2002:a2e:9dd9:0:b0:2ea:8f59:efc8 with SMTP id 38308e7fff4ca-2ea9519b6b0mr73631941fa.40.1717486945228;
        Tue, 04 Jun 2024 00:42:25 -0700 (PDT)
Received: from krava ([212.20.115.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b2bc975sm144903635e9.29.2024.06.04.00.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 00:42:24 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 4 Jun 2024 09:42:21 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	syzbot+3ab78ff125b7979e45f9@syzkaller.appspotmail.com,
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH bpf] bpf: Set run context for rawtp test_run callback
Message-ID: <Zl7FXWhrBg2j-uDR@krava>
References: <20240603111408.3981087-1-jolsa@kernel.org>
 <CAADnVQJVSTywwCseE_9u9JmsxKowL119yUUmp+w+eYNS=1T73A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJVSTywwCseE_9u9JmsxKowL119yUUmp+w+eYNS=1T73A@mail.gmail.com>

On Mon, Jun 03, 2024 at 09:25:47AM -0700, Alexei Starovoitov wrote:
> On Mon, Jun 3, 2024 at 4:14 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > syzbot reported crash when rawtp program executed through the
> > test_run interface calls bpf_get_attach_cookie helper or any
> > other helper that touches task->bpf_ctx pointer.
> >
> > We need to setup bpf_ctx pointer in rawtp test_run as well,
> > so fixing this by moving __bpf_trace_run in header file and
> > using it in test_run callback.
> >
> > Also renaming __bpf_trace_run to bpf_prog_run_trace.
> >
> > Fixes: 7adfc6c9b315 ("bpf: Add bpf_get_attach_cookie() BPF helper to access bpf_cookie value")
> > Reported-by: syzbot+3ab78ff125b7979e45f9@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3ab78ff125b7979e45f9
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/bpf.h      | 27 +++++++++++++++++++++++++++
> >  kernel/trace/bpf_trace.c | 28 ++--------------------------
> >  net/bpf/test_run.c       |  4 +---
> >  3 files changed, 30 insertions(+), 29 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 5e694a308081..4eb803b1d308 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2914,6 +2914,33 @@ static inline void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr)
> >  }
> >  #endif /* CONFIG_BPF_SYSCALL */
> >
> > +static __always_inline int
> > +bpf_prog_run_trace(struct bpf_prog *prog, u64 cookie, u64 *ctx,
> > +                  bpf_prog_run_fn run_prog)
> > +{
> > +       struct bpf_run_ctx *old_run_ctx;
> > +       struct bpf_trace_run_ctx run_ctx;
> > +       int ret = -1;
> > +
> > +       cant_sleep();
> 
> I suspect you should see a splat with that.

hum, __bpf_prog_test_run_raw_tp is called with preempt_disable,
so I think it should be fine

> 
> Overall I think it's better to add empty run_ctx to
> __bpf_prog_test_run_raw_tp()
> instead of moving such a big function to .h
> 
> No need for prog->active increments. test_run is running
> from syscall. If the same prog is attached somewhere as well
> it may recurse once and it's fine imo.

heh, it was my first change, then I was thinking let's not duplicate the
code and re-use the existing function.. but it's true that there's no
use for the prog->active intest_run interface

jirka

> 
> pw-bot: cr
> 
> > +       if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
> > +               bpf_prog_inc_misses_counter(prog);
> > +               goto out;
> > +       }
> > +
> > +       run_ctx.bpf_cookie = cookie;
> > +       old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> > +
> > +       rcu_read_lock();
> > +       ret = run_prog(prog, ctx);
> > +       rcu_read_unlock();
> > +
> > +       bpf_reset_run_ctx(old_run_ctx);
> > +out:
> > +       this_cpu_dec(*(prog->active));
> > +       return ret;
> > +}
> > +
> >  static __always_inline int
> >  bpf_probe_read_kernel_common(void *dst, u32 size, const void *unsafe_ptr)
> >  {
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index d1daeab1bbc1..8a23ef42b76b 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2383,31 +2383,6 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
> >         preempt_enable();
> >  }
> >
> > -static __always_inline
> > -void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
> > -{
> > -       struct bpf_prog *prog = link->link.prog;
> > -       struct bpf_run_ctx *old_run_ctx;
> > -       struct bpf_trace_run_ctx run_ctx;
> > -
> > -       cant_sleep();
> > -       if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
> > -               bpf_prog_inc_misses_counter(prog);
> > -               goto out;
> > -       }
> > -
> > -       run_ctx.bpf_cookie = link->cookie;
> > -       old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> > -
> > -       rcu_read_lock();
> > -       (void) bpf_prog_run(prog, args);
> > -       rcu_read_unlock();
> > -
> > -       bpf_reset_run_ctx(old_run_ctx);
> > -out:
> > -       this_cpu_dec(*(prog->active));
> > -}
> > -
> >  #define UNPACK(...)                    __VA_ARGS__
> >  #define REPEAT_1(FN, DL, X, ...)       FN(X)
> >  #define REPEAT_2(FN, DL, X, ...)       FN(X) UNPACK DL REPEAT_1(FN, DL, __VA_ARGS__)
> > @@ -2437,7 +2412,8 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
> >         {                                                               \
> >                 u64 args[x];                                            \
> >                 REPEAT(x, COPY, __DL_SEM, __SEQ_0_11);                  \
> > -               __bpf_trace_run(link, args);                            \
> > +               (void) bpf_prog_run_trace(link->link.prog, link->cookie,\
> > +                                         args, bpf_prog_run);          \
> >         }                                                               \
> >         EXPORT_SYMBOL_GPL(bpf_trace_run##x)
> >  BPF_TRACE_DEFN_x(1);
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index f6aad4ed2ab2..84d1c91b01ab 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -728,9 +728,7 @@ __bpf_prog_test_run_raw_tp(void *data)
> >  {
> >         struct bpf_raw_tp_test_run_info *info = data;
> >
> > -       rcu_read_lock();
> > -       info->retval = bpf_prog_run(info->prog, info->ctx);
> > -       rcu_read_unlock();
> > +       info->retval = bpf_prog_run_trace(info->prog, 0, info->ctx, bpf_prog_run);
> >  }
> >
> >  int bpf_prog_test_run_raw_tp(struct bpf_prog *prog,
> > --
> > 2.45.1
> >

