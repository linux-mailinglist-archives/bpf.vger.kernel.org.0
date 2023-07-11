Return-Path: <bpf+bounces-4732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E52774E917
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 10:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B06281634
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 08:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91447174F9;
	Tue, 11 Jul 2023 08:28:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6661B174CC
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 08:28:32 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B039E1980
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 01:28:09 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-991ef0b464cso1307877166b.0
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 01:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689064087; x=1691656087;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7we8vfUl7WzIGlVbdglWZoVdfWHxMLobQMk9bxuGVzs=;
        b=knEXnqWu0mYKyg5j/P2SqEF3BUTSmZ1vP1FLMN4SEItyrw3QGh1WfiRma33ph7OXsQ
         gOfHXN7XdLi9k/uHLk4hB4sz9p3ysFwJgbx9yp0X6V0D76CCfxpqFT6FIzC6Ozu93l2u
         Y89nCWd/idKFH5u02uKnvi+9de1lnnSFEqRmIDcKiMU9/Gyn5L4UpmUPaowxEpy8yUO8
         Ga6FGomEaASxxr7oAhjOUDcOWB2LrUYVEvcJhvysGrZJJ0NdnuUewsHbLz7Pdf5Y22LD
         JqPaIxtpRTDr/fr/006bRTHeXUeTcXCW0hRHFecDSWnVaBKLcHdUDjW7gs6pqNlO4cj7
         j0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689064087; x=1691656087;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7we8vfUl7WzIGlVbdglWZoVdfWHxMLobQMk9bxuGVzs=;
        b=XMRVllPLtEndJdV09bLTX/1DWXusBqWSuMEO9ZoR7wILaZ04CAgU8HfzaH/TH6qIro
         pDrEoKH3NM7Za0DycHq8TaNtlDEbrZ6VVyrf9zUsUo/uJpnT0QVoPSx2iUtV3W98fwVE
         sxA3T9DCK30BiVJhVWfVlMAXRjzTcmQ5hWyky0FAVc+qhEesKtwqMp0JCNjVt3jwFx+a
         5v0804jdG1aMzWDIez/FgHVJECXPHHOsseUUxpBk+M8ru6Y12xfoVbEdaPXgen3Zc24F
         ujm0PvK1rqgCtUHOM0r0L7AcZNuGf4v1uWNYGdkHxRvpSg03StfqPEXOg9abex5N0FoK
         Oi/w==
X-Gm-Message-State: ABy/qLauYMFD4sPe3JdOR3TaulDGX3dvDgI6xsJlmTyJADps36mOuvqT
	dKSB1ECHbb3mQ0GXQFL7lEg=
X-Google-Smtp-Source: APBJJlHxPhjockHrXd6dvhrEgZPFnAwKCSADpea/az5uzBfSKRuUfrqliX8ZiscaTem2/fkJwLYrAg==
X-Received: by 2002:a17:906:2319:b0:98e:1a0c:12c0 with SMTP id l25-20020a170906231900b0098e1a0c12c0mr17316352eja.7.1689064087345;
        Tue, 11 Jul 2023 01:28:07 -0700 (PDT)
Received: from krava (net-109-116-206-239.cust.vodafonedsl.it. [109.116.206.239])
        by smtp.gmail.com with ESMTPSA id r11-20020a17090638cb00b00992f309cfe8sm829710ejd.178.2023.07.11.01.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 01:28:06 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 11 Jul 2023 10:28:03 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, "jordalgo@meta.com" <jordalgo@meta.com>,
	"ajor@meta.com" <ajor@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf-next 05/26] bpf: Add bpf_get_func_ip helper support
 for uprobe link
Message-ID: <ZK0SkyzGr/MJsJP0@krava>
References: <20230630083344.984305-1-jolsa@kernel.org>
 <20230630083344.984305-6-jolsa@kernel.org>
 <CAEf4BzZ=xLVkG5eurEuvLU79wAMtwho7ReR+XJAgwhFF4M-7Cg@mail.gmail.com>
 <ZKuyKj8jrEPzWYMM@krava>
 <CAEf4Bzb5TFkFfbeCQ_CwLc2mPtYBXE-v61dhQNkYHQbHHrDncg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb5TFkFfbeCQ_CwLc2mPtYBXE-v61dhQNkYHQbHHrDncg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 10:55:36AM -0700, Andrii Nakryiko wrote:
> On Mon, Jul 10, 2023 at 12:24 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Jul 06, 2023 at 03:29:08PM -0700, Andrii Nakryiko wrote:
> > > On Fri, Jun 30, 2023 at 1:34 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > Adding support for bpf_get_func_ip helper being called from
> > > > ebpf program attached by uprobe_multi link.
> > > >
> > > > It returns the ip of the uprobe.
> > > >
> > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  kernel/trace/bpf_trace.c | 33 ++++++++++++++++++++++++++++++---
> > > >  1 file changed, 30 insertions(+), 3 deletions(-)
> > > >
> > >
> > > A slight aside related to bpf_get_func_ip() support in
> > > uprobe/uretprobe. We just had a conversation with Alastair and Jordan
> > > (cc'ed) about bpftrace and using bpf_get_func_ip() there with
> > > uretprobes, and it seems like it doesn't work.
> > >
> > > Is that intentional or we just missed that bpf_get_func_ip() doesn't
> > > work with uprobes/uretprobes? Do you think it would be hard to add
> > > support for them for bpf_get_func_ip()? It's a very useful helper,
> > > would be nice to have it working in all cases where it has meaningful
> > > behavior (and I think it does for uprobe and uretprobe).
> >
> > I'm not sure we discussed at the time we added this helper,
> > but I see same problem as we had with kprobes where we need
> > to know if the probe is on the start of the symbol
> >
> > we use KPROBE_FLAG_ON_FUNC_ENTRY flag for that in kprobe's
> > get_func_ip helper version:
> >
> >         BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
> >         {
> >                 struct kprobe *kp = kprobe_running();
> >
> >                 if (!kp || !(kp->flags & KPROBE_FLAG_ON_FUNC_ENTRY))
> >                         return 0;
> >
> >                 return get_entry_ip((uintptr_t)kp->addr);
> >         }
> >
> > I don't think we can have same flag for uprobe, we don't have
> > the binary symbol data as we have for kernel
> 
> what if we just return whatever was the IP where uprobe/uretprobe
> interrupt instruction was installed at? I haven't tried what does
> regs->ip contain for u*ret*probe, though, if it already has the IP
> where we installed uprobe itself, it might be ok as is. But still,

the entry uprobe gets the IP of the probed instruction, but the uretprobe
gets IP of the next instruction after probed func retun - like 4c57f0 in
the example below when uprobe is placed on trigger_func_get_func_ip

	  4c57eb:       e8 4b fe ff ff          call   4c563b <trigger_func_get_func_ip>
	  4c57f0:       eb 01                   jmp    4c57f3 <test_uprobe+0x1b1>

> feels like it would be nice to have bpf_get_func_ip() working for
> uprobe/uretprobe (even if semantics might differ for uprobes not at
> the entry of the function).

but it looks like we actually have the original uprobe address stored in
current->utask->vaddr before bpf program is executed (in uretprobe_dispatcher)
so we should be able to get that address from there in uretprobe's get_func_ip
helper function, I'll check

I don't mind the semantic change for uprobe's get_func_ip, because I think
it's unlikely we will be able to change it in future to return the real
function entry

jirka

> 
> >
> > I guess the app needs to store regs->ip and match it against symbol
> > addresses in user space
> >
> > jirka
> >
> >
> > >
> > > Thanks!
> > >
> > > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > > index 4ef51fd0497f..f5a41c1604b8 100644
> > > > --- a/kernel/trace/bpf_trace.c
> > > > +++ b/kernel/trace/bpf_trace.c
> > > > @@ -88,6 +88,7 @@ static u64 bpf_kprobe_multi_cookie(struct bpf_run_ctx *ctx);
> > > >  static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx);
> > > >
> > >
> > > [...]

