Return-Path: <bpf+bounces-4738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBC474E9C6
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E401C20C49
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 09:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA91E17741;
	Tue, 11 Jul 2023 09:03:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED2217731
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:03:38 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0AE83
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:03:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-992acf67388so627562666b.1
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689066215; x=1691658215;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A6BNMWHnghYazT7P+ILrQmUp5DK6NMw3ZlVB9TutqRc=;
        b=MLmyaf+3jpO7uugakS+f+ngFf0uEfwfx1Z5+ASCx+upJzZfz7yWWotbcRj9nyRvcwI
         mL049oGh1Ypfk5pBGMqbuVbzXhHgon8NCbgustoVV85ggIrAHqFl3ZRiYWVXzw6OJeF+
         Vw2kmdYkzZ3M1YnWVOHLYky0QW8KOHlWeTXuLM3l+1e3kzu9sXQLXMEY0TYPlFppScAd
         IoS11yMrqQXN+eaYW0R8zOx9RP3is94WcPwVAohgzM27fNjSMdZzkY7ZyHaRrdZx8+0g
         z3lmzGRfNHe9BmkdDDIcN3Q16tLnWt7RKsOYX259+L5NGPRggQ3q/X3shMIYl5SgkLB3
         Zu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066215; x=1691658215;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6BNMWHnghYazT7P+ILrQmUp5DK6NMw3ZlVB9TutqRc=;
        b=eLrU+1+qikmzDDT5xiO/sl+DQt8m9n8OvR71+CZLcW+GsqtBfZNJQG15VHuwPdMN+f
         XpHBJhxsY2HyZ0CehIt6qy7cjCTi+CwS8gJqLFUe0Bdq89IGhiMI48WgpCpdTbc1oYMW
         OY+QsKJjjzo9MXQxOX7+4vNwFD/iPObmMTn+rUBQCb8uBvjTy65QCZRI6Y687aiKZhtF
         FFxYz3k4pN3Alc+Sgw3Gg/06dpcrL5Ds0F3ZPWsttHBYv7TwWxH8qFi0n9GOSFSAPhA2
         iiNVL6/kCHta+5fv1RLsZLbz1t5fRAaQ431Y+6cXHYn8D0gF5Xs2HMxwas9UI8gQLHOZ
         9KEg==
X-Gm-Message-State: ABy/qLbh/SmxNZQ+dXUs21cpNV3p+tO9KUqk3OkV4zezqKHKMctiHeoF
	cRliWAn7ZNGQqzbOxhJhKB8=
X-Google-Smtp-Source: APBJJlG8O56ouZGALAPFqyoV0MaKJ/TpAaI79lAF6k4a9bcEjYJsqnFs38rJKJatt34qnCyU1QB2bw==
X-Received: by 2002:a17:906:7a59:b0:993:eddd:6df0 with SMTP id i25-20020a1709067a5900b00993eddd6df0mr9842699ejo.28.1689066215135;
        Tue, 11 Jul 2023 02:03:35 -0700 (PDT)
Received: from krava (net-109-116-206-239.cust.vodafonedsl.it. [109.116.206.239])
        by smtp.gmail.com with ESMTPSA id h19-20020a170906719300b00993cc1242d4sm865606ejk.151.2023.07.11.02.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:03:34 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 11 Jul 2023 11:03:31 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf-next 15/26] libbpf: Add uprobe multi link detection
Message-ID: <ZK0a4xXtL1oPQ37s@krava>
References: <20230630083344.984305-1-jolsa@kernel.org>
 <20230630083344.984305-16-jolsa@kernel.org>
 <CAEf4BzZtmfxFrvvEG+7ZhsSnDGR20u+bjjbQsG5pn0zDQZC9yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZtmfxFrvvEG+7ZhsSnDGR20u+bjjbQsG5pn0zDQZC9yg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 09:20:42PM -0700, Andrii Nakryiko wrote:
> On Fri, Jun 30, 2023 at 1:36 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding uprobe-multi link detection. It will be used later in
> > bpf_program__attach_usdt function to check and use uprobe_multi
> > link over standard uprobe links.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c          | 35 +++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/libbpf_internal.h |  2 ++
> >  2 files changed, 37 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 06092b9752f1..4f61f9dc1748 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -4817,6 +4817,38 @@ static int probe_perf_link(void)
> >         return link_fd < 0 && err == -EBADF;
> >  }
> >
> > +static int probe_uprobe_multi_link(void)
> > +{
> > +       LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
> > +               .expected_attach_type = BPF_TRACE_UPROBE_MULTI,
> > +       );
> > +       LIBBPF_OPTS(bpf_link_create_opts, link_opts);
> > +       struct bpf_insn insns[] = {
> > +               BPF_MOV64_IMM(BPF_REG_0, 0),
> > +               BPF_EXIT_INSN(),
> > +       };
> > +       unsigned long offset = 0;
> > +       int prog_fd, link_fd;
> > +
> > +       prog_fd = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL",
> > +                               insns, ARRAY_SIZE(insns), &load_opts);
> > +       if (prog_fd < 0)
> > +               return -errno;
> > +
> > +       /* create single uprobe on offset 0 in current process */
> > +       link_opts.uprobe_multi.path = "/proc/self/exe";
> > +       link_opts.uprobe_multi.offsets = &offset;
> > +       link_opts.uprobe_multi.cnt = 1;
> > +
> > +       link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI, &link_opts);
> > +
> 
> so I'd like us to avoid successfully attaching anything. This might
> have unintended consequences (e.g., unintentionally breaking backing
> huge pages into normal pages, just because we happen to successfully
> attach briefly). So let's work on feature detection that fails to
> create a link, but does it in a way that we know that the feature
> itself is supported by the kernel
> 
> Some ideas we could do:
> 
> 1. Pass invalid file (e.g., just root, "/" as path), but modify
> kernel-side logic to return not -EINVAL, but -EBADF (and I think it
> would be good to do this anyway). Then expect -EBADF as a signal that
> the feature is supported.

ah ok, so -EBADF from inside uprobe_multi link setup code would mean
it's supported, anything else means it's not.. should work also for
old kernels, I don't think we have -EBADF in related paths, will check

> 
> 2. Also, we can return -EPROTO instead of -EINVAL on invalid
> combination of paramers or something like that
> 
> I'd start with -EBADF change.
> 
> In general, we should write kernel-side code in such a way that allows
> simple and efficient feature-detection. We shouldn't repeat the
> nightmare of memcg-based mem accounting :(
> 
> > +       if (link_fd >= 0)
> > +               close(link_fd);
> > +       close(prog_fd);
> > +
> > +       return link_fd >= 0;
> > +}
> > +
> >  static int probe_kern_bpf_cookie(void)
> >  {
> >         struct bpf_insn insns[] = {
> > @@ -4913,6 +4945,9 @@ static struct kern_feature_desc {
> >         [FEAT_SYSCALL_WRAPPER] = {
> >                 "Kernel using syscall wrapper", probe_kern_syscall_wrapper,
> >         },
> > +       [FEAT_UPROBE_MULTI_LINK] = {
> > +               "BPF uprobe multi link support", probe_uprobe_multi_link,
> 
> nit: BPF multi-uprobe link support
> 
> > +       },
> >  };
> >
> >  bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
> > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> > index 7d75b92e531a..9c04b3fe1207 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -354,6 +354,8 @@ enum kern_feature_id {
> >         FEAT_BTF_ENUM64,
> >         /* Kernel uses syscall wrapper (CONFIG_ARCH_HAS_SYSCALL_WRAPPER) */
> >         FEAT_SYSCALL_WRAPPER,
> > +       /* BPF uprobe_multi link support */
> 
> same, multi-uprobe link support

ok, thanks

jirka

> 
> 
> 
> > +       FEAT_UPROBE_MULTI_LINK,
> >         __FEAT_CNT,
> >  };
> >
> > --
> > 2.41.0
> >

