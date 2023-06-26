Return-Path: <bpf+bounces-3483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C363E73EB28
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 21:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7241C209C7
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 19:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCD713AD2;
	Mon, 26 Jun 2023 19:22:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F212B13AC4
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 19:22:52 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656BEE74
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 12:22:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-991da766865so134372366b.0
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 12:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687807370; x=1690399370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=THSTck89SV3KkhjM5RmZoYrGhxvcLJfi1aJ69bbzCLA=;
        b=DWomjeEYXqazYWoLGiWXlHQpmgLODgLbZcI5+9qms8z/Tl/6Fj/kPOL9b0JIIJwhLd
         7O+R5Q5+nlXtDew94YagJmSXqL4mpSSq+JR5kmj1brXJ2ynv/ENeSBA4tgyn6FCe6Jek
         YJr2uSpQWKEpdymtgzm9xZV54Q1kqW3aI/mQfq1129p97/yG3IjTDM+yAH9IsY4m//H5
         q61vD4d2DColeGJT1qddZ3e0Cyg6eNGx96upOatFqkKDEWvn4nEqMz5lWQ+4j2vKcXSj
         TwO32rfYWM8qt1Uh/zydcQ912CsyCI+G+LSLDk0l1pMvdlJik1660Pdlv/ETvHUwRBY8
         w4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687807370; x=1690399370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THSTck89SV3KkhjM5RmZoYrGhxvcLJfi1aJ69bbzCLA=;
        b=ixgi3LTfEFX/FCVSiACLfKaqT6SrAz/qY2IVl2CP68BOmWTL2vrf4i1pcqOhhhZBAS
         rvYuDyLHsQ4dZEoC+7ijP32FOIyToUr3qYLTh7/GwR7iIIdaXcdJXvY37yGKra9M/NoS
         U4MeXlCEGkMZatGvcDVzyfWpEmav6/f4SBRdXybZ8MvRcl2HhKYETqqOjNha6+gtAwox
         7sv0H7t9/coyOjgkp5TDLhWU9XyNp/hcLMEWky7Sl/sXwko/MQl7Fz/Yt3q8Wy/4luo4
         EsfC9YvkodmmqzUDKCqStsopBnAaMBV2lVqQNk0dsKK1jFG4c6No9nt7hYk4zpoqljWC
         xLeg==
X-Gm-Message-State: AC+VfDzBkw4wE8nmrec098GW69AVvvBrP9fOuxoOTrekQ5ltcamJe1nP
	xaEibz4jfyl1c/fKXO8xl9c=
X-Google-Smtp-Source: ACHHUZ4NRvIa1y+s2JIYgYaFDkuXyJVNQiiWzmAIQ47jzkeXJIxmocWCsMG//RoJRCZBF+pKpWPYTg==
X-Received: by 2002:a17:906:dacb:b0:94e:e6b9:fef2 with SMTP id xi11-20020a170906dacb00b0094ee6b9fef2mr25143142ejb.67.1687807369605;
        Mon, 26 Jun 2023 12:22:49 -0700 (PDT)
Received: from krava (net-93-65-241-219.cust.vodafonedsl.it. [93.65.241.219])
        by smtp.gmail.com with ESMTPSA id pv18-20020a170907209200b00987cd2db33fsm3565032ejb.131.2023.06.26.12.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 12:22:48 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 26 Jun 2023 21:22:43 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf-next 13/24] libbpf: Add uprobe multi link detection
Message-ID: <ZJnlg/FwfUSDZXCJ@krava>
References: <20230620083550.690426-1-jolsa@kernel.org>
 <20230620083550.690426-14-jolsa@kernel.org>
 <CAEf4BzZpq96QUsWitv+TBuaE2ehy0PKuEvq0rYgjOQj6jegTGQ@mail.gmail.com>
 <ZJeV48zw9C1h/mYs@krava>
 <CAEf4BzZ_n14aXgqEjv2=hFUHMLOseZ2WdtHfiBD1VeGaBspi4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ_n14aXgqEjv2=hFUHMLOseZ2WdtHfiBD1VeGaBspi4w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 11:21:40AM -0700, Andrii Nakryiko wrote:

SNIP

> > >
> > > > +       if (prog_fd < 0)
> > > > +               return -errno;
> > > > +
> > > > +       /* No need to specify attach function. If the link is not supported
> > > > +        * we will get -EOPNOTSUPP error before any other check is performed.
> > >
> > > what will actually return this -EOPNOTSUPP? I couldn't find this in
> > > the code quickly, can you please point me where?
> >
> >         #else /* !CONFIG_UPROBES */
> >         int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> >         {
> >                 return -EOPNOTSUPP;
> >         }
> 
> that's a new code in new kernel that doesn't have CONFIG_UPROBES. What
> about old kernels? They will return -EINVAL, no? Which we will assume
> means "yep, multi-uprobe BPF link is supported", which would be wrong.
> Or am I missing something?

ah nope, I'm missing old kernel case.. will check and fix that

jirka

> 
> >
> > >
> > > > +        */
> > > > +       link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI, NULL);
> > > > +       err = -errno; /* close() can clobber errno */
> > > > +
> > > > +       if (link_fd >= 0)
> > > > +               close(link_fd);
> > > > +       close(prog_fd);
> > > > +
> > > > +       return link_fd < 0 && err != -EOPNOTSUPP;
> > > > +}
> > > > +
> > > >  static int probe_kern_bpf_cookie(void)
> > > >  {
> > > >         struct bpf_insn insns[] = {
> > > > @@ -4911,6 +4937,9 @@ static struct kern_feature_desc {
> > > >         [FEAT_SYSCALL_WRAPPER] = {
> > > >                 "Kernel using syscall wrapper", probe_kern_syscall_wrapper,
> > > >         },
> > > > +       [FEAT_UPROBE_LINK] = {
> > > > +               "BPF uprobe multi link support", probe_uprobe_multi_link,
> > > > +       },
> > > >  };
> > > >
> > > >  bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
> > > > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> > > > index 22b0834e7fe1..a257eb81af25 100644
> > > > --- a/tools/lib/bpf/libbpf_internal.h
> > > > +++ b/tools/lib/bpf/libbpf_internal.h
> > > > @@ -354,6 +354,8 @@ enum kern_feature_id {
> > > >         FEAT_BTF_ENUM64,
> > > >         /* Kernel uses syscall wrapper (CONFIG_ARCH_HAS_SYSCALL_WRAPPER) */
> > > >         FEAT_SYSCALL_WRAPPER,
> > > > +       /* BPF uprobe_multi link support */
> > > > +       FEAT_UPROBE_LINK,
> > >
> > > UPROBE_MULTI_LINK, we might have non-multi link in the future as well
> >
> > ok
> >
> > thanks,
> > jirka

