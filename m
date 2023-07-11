Return-Path: <bpf+bounces-4780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E0E74F639
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 18:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731EA281177
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 16:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3461DDD6;
	Tue, 11 Jul 2023 16:57:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A983D19BBF
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 16:57:23 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C910495
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:57:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51e5e4c6026so2461737a12.0
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689094640; x=1691686640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgM6tm6oYEaiBTSa7NlW59KF01ra1/AbDz+FMHPsNvI=;
        b=nnYE1nSUxFIlT0yipVH0E+pSVvQKxxr1ijQJF/rM1zxpb63+CpIpNmK7uZN7ovzqaO
         zBCdildl1OqWZGf62BgVXvrhALx42DvkJa9B03YN/+YDlTVUC2WpBc5bCvfah1MzXWUM
         bokBWyALRGjY2RP+PGVuyjzoaNyKneQanzVYQXFtzdNg4d8vqMWOHeuPgCaytek8SC/6
         Xa+Is5e/K1AYyziZF5dBr73N/Yin9tadcgreX6XoIIJwWLanKa5kMiSznUEzguKRV6qL
         5dw9ngW8gq2tskmsf0dga6Z5cXnpgR7KL1I9xIv5oWU5YY1EQszUM2pxd6ZI5XatvcC9
         lq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689094640; x=1691686640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgM6tm6oYEaiBTSa7NlW59KF01ra1/AbDz+FMHPsNvI=;
        b=T2dZvrzwvv3522Syxo3kkLM+obSuK7IElmCTxoShnRbf/mX9mhybilAiSYCbtxRWD4
         VGWkhHLKLMYFmi5r9Z0JeixMt8/rtB5OgIUinwnRVJiZxeS/BZS5amxz+LX6JeU0/8/t
         FZLfttdWwQJVixbNgV0PVVsIN4otP8u8JtRP1UMU0GSE/OZS6i2Pz5hbiJqmDFy9l2F4
         I7enhGSL1BITC3dWffvwrqnfv3oAfnNToxpBHGhg75LDAOEjfZeWGqulFjaFUmrl02fx
         bImq2AGa5jddPTajVe8ZJWqeMYutGLj/CAWV9HNyAfN97lwQc8fV9Au8BQwWChnhU1Ew
         x55g==
X-Gm-Message-State: ABy/qLYBtlgY40Eq37G4Jf+MaA1WirPTlhIv6wgh/w/pVNnBAZ6l9h4e
	/PCXFTzmhvOYIgogBZbJHDB1cke8L46TT0wQgyI=
X-Google-Smtp-Source: APBJJlGSvESN6/cdhlrSKeR4+DbOr1G3bIhOXeXfI8e4pohpXpuwLj0P4GGQ28AbFl6rE3sPW++vUKtClDfTi/IwZko=
X-Received: by 2002:aa7:cd5a:0:b0:51d:8a68:ed33 with SMTP id
 v26-20020aa7cd5a000000b0051d8a68ed33mr15730468edw.30.1689094639813; Tue, 11
 Jul 2023 09:57:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-6-jolsa@kernel.org>
 <CAEf4BzZ=xLVkG5eurEuvLU79wAMtwho7ReR+XJAgwhFF4M-7Cg@mail.gmail.com>
 <ZKuyKj8jrEPzWYMM@krava> <CAEf4Bzb5TFkFfbeCQ_CwLc2mPtYBXE-v61dhQNkYHQbHHrDncg@mail.gmail.com>
 <ZK0SkyzGr/MJsJP0@krava>
In-Reply-To: <ZK0SkyzGr/MJsJP0@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 11 Jul 2023 09:57:07 -0700
Message-ID: <CAEf4Bza_rbvSbYpUFQHvUbSTMARcyJgNWuO+Qyh6j1jgfWFnzw@mail.gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 1:28=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Jul 10, 2023 at 10:55:36AM -0700, Andrii Nakryiko wrote:
> > On Mon, Jul 10, 2023 at 12:24=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com>=
 wrote:
> > >
> > > On Thu, Jul 06, 2023 at 03:29:08PM -0700, Andrii Nakryiko wrote:
> > > > On Fri, Jun 30, 2023 at 1:34=E2=80=AFAM Jiri Olsa <jolsa@kernel.org=
> wrote:
> > > > >
> > > > > Adding support for bpf_get_func_ip helper being called from
> > > > > ebpf program attached by uprobe_multi link.
> > > > >
> > > > > It returns the ip of the uprobe.
> > > > >
> > > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > ---
> > > > >  kernel/trace/bpf_trace.c | 33 ++++++++++++++++++++++++++++++---
> > > > >  1 file changed, 30 insertions(+), 3 deletions(-)
> > > > >
> > > >
> > > > A slight aside related to bpf_get_func_ip() support in
> > > > uprobe/uretprobe. We just had a conversation with Alastair and Jord=
an
> > > > (cc'ed) about bpftrace and using bpf_get_func_ip() there with
> > > > uretprobes, and it seems like it doesn't work.
> > > >
> > > > Is that intentional or we just missed that bpf_get_func_ip() doesn'=
t
> > > > work with uprobes/uretprobes? Do you think it would be hard to add
> > > > support for them for bpf_get_func_ip()? It's a very useful helper,
> > > > would be nice to have it working in all cases where it has meaningf=
ul
> > > > behavior (and I think it does for uprobe and uretprobe).
> > >
> > > I'm not sure we discussed at the time we added this helper,
> > > but I see same problem as we had with kprobes where we need
> > > to know if the probe is on the start of the symbol
> > >
> > > we use KPROBE_FLAG_ON_FUNC_ENTRY flag for that in kprobe's
> > > get_func_ip helper version:
> > >
> > >         BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
> > >         {
> > >                 struct kprobe *kp =3D kprobe_running();
> > >
> > >                 if (!kp || !(kp->flags & KPROBE_FLAG_ON_FUNC_ENTRY))
> > >                         return 0;
> > >
> > >                 return get_entry_ip((uintptr_t)kp->addr);
> > >         }
> > >
> > > I don't think we can have same flag for uprobe, we don't have
> > > the binary symbol data as we have for kernel
> >
> > what if we just return whatever was the IP where uprobe/uretprobe
> > interrupt instruction was installed at? I haven't tried what does
> > regs->ip contain for u*ret*probe, though, if it already has the IP
> > where we installed uprobe itself, it might be ok as is. But still,
>
> the entry uprobe gets the IP of the probed instruction, but the uretprobe
> gets IP of the next instruction after probed func retun - like 4c57f0 in
> the example below when uprobe is placed on trigger_func_get_func_ip
>
>           4c57eb:       e8 4b fe ff ff          call   4c563b <trigger_fu=
nc_get_func_ip>
>           4c57f0:       eb 01                   jmp    4c57f3 <test_uprob=
e+0x1b1>
>
> > feels like it would be nice to have bpf_get_func_ip() working for
> > uprobe/uretprobe (even if semantics might differ for uprobes not at
> > the entry of the function).
>
> but it looks like we actually have the original uprobe address stored in
> current->utask->vaddr before bpf program is executed (in uretprobe_dispat=
cher)
> so we should be able to get that address from there in uretprobe's get_fu=
nc_ip
> helper function, I'll check

ok, sounds great, seems like we have a pretty logical behavior for
both uprobe and uretprobe.

>
> I don't mind the semantic change for uprobe's get_func_ip, because I thin=
k
> it's unlikely we will be able to change it in future to return the real
> function entry
>

Yep, I don't think kernel can easily know where the function even
begins. But that's ok. We can clarify helper's behavior in UAPI
comments: uprobe/uretprobe always work, but return not function IP,
but the traced location. Thanks!


> jirka
>
> >
> > >
> > > I guess the app needs to store regs->ip and match it against symbol
> > > addresses in user space
> > >
> > > jirka
> > >
> > >
> > > >
> > > > Thanks!
> > > >
> > > > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > > > index 4ef51fd0497f..f5a41c1604b8 100644
> > > > > --- a/kernel/trace/bpf_trace.c
> > > > > +++ b/kernel/trace/bpf_trace.c
> > > > > @@ -88,6 +88,7 @@ static u64 bpf_kprobe_multi_cookie(struct bpf_r=
un_ctx *ctx);
> > > > >  static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx);
> > > > >
> > > >
> > > > [...]

