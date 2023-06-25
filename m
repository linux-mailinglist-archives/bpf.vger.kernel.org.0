Return-Path: <bpf+bounces-3380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A291E73CDC3
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 03:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56149280FA4
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 01:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D652962C;
	Sun, 25 Jun 2023 01:18:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840927F
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 01:18:35 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDA1EA
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 18:18:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f9b4bf99c2so26421585e9.3
        for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 18:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687655912; x=1690247912;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1TV0gBf5sOMxQ0HgaoLZ3mYP057dkXG+pCwLANHYTqU=;
        b=YPY24mNDeTrxFhV/IgBlz689OYonx9vaUepi9l/b6vngUr8iUrKC31DQkveREA1eM4
         IX2dMfAcabxHNQjmN35zWKggyoksPJGDv1qwAiYALBxR4Msf5OHc2CvMm1u0Cx9Ditzu
         RyTkKt+LzJ/Ch3wjfUfud9BRfmY91dnNB9jOyyDlSwUvVS5Z1Jk1x5/ZjFoId5GGgJ7+
         BFaBjYjPJIzbWVgO2lLGY1oV9Nl1CRvkCexQ2LdaxrZe0VNDy3V6Hw1IWQFYCui2iy9C
         CLiNPuahc5aBRkzV7dZTKJul+Fe66YbSH2xkw8b/dsm5WpUYty5G377SGbR+lJGuA9v+
         upkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687655912; x=1690247912;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1TV0gBf5sOMxQ0HgaoLZ3mYP057dkXG+pCwLANHYTqU=;
        b=UO5YNOPiqABKOJUVzCNpexOAWFwR/raLQy4W0yIBcN3MmzK5iOFCul3fjrfLgBvRAo
         Sia3L66FXsoQY4GcP0HEk7C4Jy8k1KEiOmnUMfgT2IbLbLek0pPFCUwXcKsTeIiNlMbN
         V41UHaMdak0wEHncU1uUijaYhWasVrF2k61aAsGnpoHUasn3fYk+7EcdzzcgIJS0gMLt
         jVMEVo+6kBA8ZnyoqYoH4TnIsE6++al9ykQbTDJqbr1PBxXw0vXlUK5KsMbK2KZK97SU
         +/IGxo9j/NzZsP0CE/yis8nv2QQ4JE7xV32CowL2jm2jyKSnkSQZOtVSJ+I01pcsXu6N
         3VqA==
X-Gm-Message-State: AC+VfDyLk741r/k96z5aYNoiv4KAo6nqZWeOFiRFlriFcJfwgPJR3877
	AeQRLfIxASkkqZwP5k8jWsQ=
X-Google-Smtp-Source: ACHHUZ602LLTnWiWM929TIIEAoEcg4kKaczWcZZQijuQQARve6OGJuR0oRxc3OoN2KWbu2GXCbUWHg==
X-Received: by 2002:a1c:6a1a:0:b0:3fa:8a5b:b963 with SMTP id f26-20020a1c6a1a000000b003fa8a5bb963mr347148wmc.34.1687655911486;
        Sat, 24 Jun 2023 18:18:31 -0700 (PDT)
Received: from krava (brn-rj-tbond05.sa.cz. [185.94.55.134])
        by smtp.gmail.com with ESMTPSA id e3-20020a05600c218300b003f9a6f3f240sm6340688wme.14.2023.06.24.18.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 18:18:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 25 Jun 2023 03:18:27 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf-next 13/24] libbpf: Add uprobe multi link detection
Message-ID: <ZJeV48zw9C1h/mYs@krava>
References: <20230620083550.690426-1-jolsa@kernel.org>
 <20230620083550.690426-14-jolsa@kernel.org>
 <CAEf4BzZpq96QUsWitv+TBuaE2ehy0PKuEvq0rYgjOQj6jegTGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZpq96QUsWitv+TBuaE2ehy0PKuEvq0rYgjOQj6jegTGQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 01:40:20PM -0700, Andrii Nakryiko wrote:
> On Tue, Jun 20, 2023 at 1:38 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding uprobe-multi link detection. It will be used later in
> > bpf_program__attach_usdt function to check and use uprobe_multi
> > link over standard uprobe links.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c          | 29 +++++++++++++++++++++++++++++
> >  tools/lib/bpf/libbpf_internal.h |  2 ++
> >  2 files changed, 31 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index e42080258ec7..3d570898459e 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -4815,6 +4815,32 @@ static int probe_perf_link(void)
> >         return link_fd < 0 && err == -EBADF;
> >  }
> >
> > +static int probe_uprobe_multi_link(void)
> > +{
> > +       struct bpf_insn insns[] = {
> > +               BPF_MOV64_IMM(BPF_REG_0, 0),
> > +               BPF_EXIT_INSN(),
> > +       };
> > +       int prog_fd, link_fd, err;
> > +
> > +       prog_fd = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL",
> > +                               insns, ARRAY_SIZE(insns), NULL);
> 
> I thought we needed to specify expected_attach_type (BPF_TRACE_UPROBE_MULTI)?

hm it should.. I guess it worked because of the KPROBE/UPROBE
typo you found in the patch earlier, will check

> 
> > +       if (prog_fd < 0)
> > +               return -errno;
> > +
> > +       /* No need to specify attach function. If the link is not supported
> > +        * we will get -EOPNOTSUPP error before any other check is performed.
> 
> what will actually return this -EOPNOTSUPP? I couldn't find this in
> the code quickly, can you please point me where?

	#else /* !CONFIG_UPROBES */
	int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
	{
		return -EOPNOTSUPP;
	}

> 
> > +        */
> > +       link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI, NULL);
> > +       err = -errno; /* close() can clobber errno */
> > +
> > +       if (link_fd >= 0)
> > +               close(link_fd);
> > +       close(prog_fd);
> > +
> > +       return link_fd < 0 && err != -EOPNOTSUPP;
> > +}
> > +
> >  static int probe_kern_bpf_cookie(void)
> >  {
> >         struct bpf_insn insns[] = {
> > @@ -4911,6 +4937,9 @@ static struct kern_feature_desc {
> >         [FEAT_SYSCALL_WRAPPER] = {
> >                 "Kernel using syscall wrapper", probe_kern_syscall_wrapper,
> >         },
> > +       [FEAT_UPROBE_LINK] = {
> > +               "BPF uprobe multi link support", probe_uprobe_multi_link,
> > +       },
> >  };
> >
> >  bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
> > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> > index 22b0834e7fe1..a257eb81af25 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -354,6 +354,8 @@ enum kern_feature_id {
> >         FEAT_BTF_ENUM64,
> >         /* Kernel uses syscall wrapper (CONFIG_ARCH_HAS_SYSCALL_WRAPPER) */
> >         FEAT_SYSCALL_WRAPPER,
> > +       /* BPF uprobe_multi link support */
> > +       FEAT_UPROBE_LINK,
> 
> UPROBE_MULTI_LINK, we might have non-multi link in the future as well

ok

thanks,
jirka

