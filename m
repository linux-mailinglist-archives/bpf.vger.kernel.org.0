Return-Path: <bpf+bounces-4618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B466F74DCD9
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 19:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD5128127D
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 17:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137B314289;
	Mon, 10 Jul 2023 17:55:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21A613AF9
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 17:55:52 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE87AD
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 10:55:50 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9922d6f003cso637370266b.0
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 10:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689011748; x=1691603748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/D8o7SiCKE/PYKZ7iYoMAEplKgVy8ocJUZrklp1ZT/c=;
        b=FpNjLfYN95LmD7fi1yPMibS2FP2M5CbENaVMvIJKzzPX+ZB1QL2DRz0A2szKWZC9sD
         a1bbu+m5Dy4R01AB980lkAcYfQNaUrVxRps/KTleLhD5eOdUGr2x8KIO/ttqkBQGhqII
         ID/s6AMo8JXqGXMmD5W+Kr0ioOepHDacNWs6YIv4E8CRjS39fDnwQd1SARWLYBuAD4fP
         GdTSGsP6w3YInf5ZyqaCZVaGtzu8rPKqFHaftQ/it8iu2E9tnkvpUQ4ST9G5PTedYHC3
         0UBZK2IPe0Td/DZfaLagzUwJz4RLjhxWgZS09aTRylg52RYc0uq4xmNk6SOaXpZU4hPF
         lvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689011748; x=1691603748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/D8o7SiCKE/PYKZ7iYoMAEplKgVy8ocJUZrklp1ZT/c=;
        b=ZjhVEP0C8UtkonpwTBnJlB8wv5BmKh2Jxr13FIiHv/EEd4l7jddgRY9dZVwJFIxWXY
         7G2bGz0cdfEzZ231CcMteNqisUTSRWGPg824qswt5rqm7CzxDlGRlEco8wZoIzBPBSY+
         wduHxMOYFkqeFDCbbKtkBAMxz4SIrbjbAPyfbJWvbWFNKjQu9UHvz34LtJCqkT6lEmDp
         +sN8ZayLyI4U4vx0OLh1EfG8oDobbH832GEcBULLOre7puxWCVhADst+yghnIaZisWb3
         oK47Ffka4wF80FRKPE2yWYmIkaULg6mpQc29q6fWzvRGeBZPERQdUEqEDb/UEzO7xBTn
         OGDg==
X-Gm-Message-State: ABy/qLbELk12EaSH0OzdASXM6sTBtU1lYACrJkIOABA7z6pcv75JMSZ3
	OxwSHy85SQuNwCEeogVj8Z87TCJBGGbYS+Jcskk=
X-Google-Smtp-Source: APBJJlFnOauukilbKROtdtfPuEQKoGE795NOCGs+qOpLkRsTkwzWAoI0RKVJE8z0a/aWbrfat1Dck//2KX6Pb7cidhE=
X-Received: by 2002:a50:ee16:0:b0:51e:527:3c64 with SMTP id
 g22-20020a50ee16000000b0051e05273c64mr13537528eds.16.1689011748432; Mon, 10
 Jul 2023 10:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-6-jolsa@kernel.org>
 <CAEf4BzZ=xLVkG5eurEuvLU79wAMtwho7ReR+XJAgwhFF4M-7Cg@mail.gmail.com> <ZKuyKj8jrEPzWYMM@krava>
In-Reply-To: <ZKuyKj8jrEPzWYMM@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 10 Jul 2023 10:55:36 -0700
Message-ID: <CAEf4Bzb5TFkFfbeCQ_CwLc2mPtYBXE-v61dhQNkYHQbHHrDncg@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 05/26] bpf: Add bpf_get_func_ip helper support
 for uprobe link
To: Jiri Olsa <olsajiri@gmail.com>
Cc: "jordalgo@meta.com" <jordalgo@meta.com>, "ajor@meta.com" <ajor@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 12:24=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
>
> On Thu, Jul 06, 2023 at 03:29:08PM -0700, Andrii Nakryiko wrote:
> > On Fri, Jun 30, 2023 at 1:34=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Adding support for bpf_get_func_ip helper being called from
> > > ebpf program attached by uprobe_multi link.
> > >
> > > It returns the ip of the uprobe.
> > >
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  kernel/trace/bpf_trace.c | 33 ++++++++++++++++++++++++++++++---
> > >  1 file changed, 30 insertions(+), 3 deletions(-)
> > >
> >
> > A slight aside related to bpf_get_func_ip() support in
> > uprobe/uretprobe. We just had a conversation with Alastair and Jordan
> > (cc'ed) about bpftrace and using bpf_get_func_ip() there with
> > uretprobes, and it seems like it doesn't work.
> >
> > Is that intentional or we just missed that bpf_get_func_ip() doesn't
> > work with uprobes/uretprobes? Do you think it would be hard to add
> > support for them for bpf_get_func_ip()? It's a very useful helper,
> > would be nice to have it working in all cases where it has meaningful
> > behavior (and I think it does for uprobe and uretprobe).
>
> I'm not sure we discussed at the time we added this helper,
> but I see same problem as we had with kprobes where we need
> to know if the probe is on the start of the symbol
>
> we use KPROBE_FLAG_ON_FUNC_ENTRY flag for that in kprobe's
> get_func_ip helper version:
>
>         BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
>         {
>                 struct kprobe *kp =3D kprobe_running();
>
>                 if (!kp || !(kp->flags & KPROBE_FLAG_ON_FUNC_ENTRY))
>                         return 0;
>
>                 return get_entry_ip((uintptr_t)kp->addr);
>         }
>
> I don't think we can have same flag for uprobe, we don't have
> the binary symbol data as we have for kernel

what if we just return whatever was the IP where uprobe/uretprobe
interrupt instruction was installed at? I haven't tried what does
regs->ip contain for u*ret*probe, though, if it already has the IP
where we installed uprobe itself, it might be ok as is. But still,
feels like it would be nice to have bpf_get_func_ip() working for
uprobe/uretprobe (even if semantics might differ for uprobes not at
the entry of the function).

>
> I guess the app needs to store regs->ip and match it against symbol
> addresses in user space
>
> jirka
>
>
> >
> > Thanks!
> >
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index 4ef51fd0497f..f5a41c1604b8 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -88,6 +88,7 @@ static u64 bpf_kprobe_multi_cookie(struct bpf_run_c=
tx *ctx);
> > >  static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx);
> > >
> >
> > [...]

