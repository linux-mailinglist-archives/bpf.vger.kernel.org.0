Return-Path: <bpf+bounces-3386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D0E73CDC9
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 03:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A5D280FC6
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 01:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA8462C;
	Sun, 25 Jun 2023 01:19:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EFB7F
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 01:19:58 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA9EF2
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 18:19:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f90b4ac529so26238395e9.0
        for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 18:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687655995; x=1690247995;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SMrB7uz43/QBPZSIUcdGjMeloD2epJqDj3FiTYm+hgY=;
        b=nC/8rL9bZjtqulJhkuIBf833PmDIYT9U11WNCcGF2SoxjFn0ouzMsz5sLv4fsJdb1O
         lAJykTsxEyJ908gxOpYJKSvftYK/y2QOYD5Aw4UmUOwdzm5bDpYixkV4XGR2toZu1Huk
         DbtozVge9uJg03ZE6jGU4BOWDLEFVlrxBcHIlzhr6fZGYbPbolCCbvmdv6D5H4qKvyPg
         8elJNuNgMHNTVLr/FncDbae9GTv6SDy7n5TKwlyo7mqGfF+QKXV9zB+u2BUen6Q/+Ix6
         PyFSdYRtOaDejkXmyk3srj7Vi/RJwwQdlY9VQEm2XUOlDV6Ah03mCoWX3rqBtkgS2/+i
         jd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687655995; x=1690247995;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMrB7uz43/QBPZSIUcdGjMeloD2epJqDj3FiTYm+hgY=;
        b=jaT9XyLK5mdNOGHe7ePWskm57K5uglRrMQ3xtn4I9Pq7ec/hWmlXBWMetNAHPsoB4B
         0QKeayUGVmZzadQZdMqT+F7gnrvu0oiF5QSkSbEh1e2qu00mUuMcwBDH4Fo9YoV+OEuF
         fATH8V/RPbdkgstNWnLglUO7JBvIQTZnN0UlQWDXuh6++JwbZLxr42M35ZMtJe2rjbmS
         3U2ZPwd/fAMNFGi67Tc0z5io6/oo0SiHBj36zjvgFhIsTOQkGV4KO2btPqLkelzwSX0g
         YKd+w6ttEy/3xPw4aOAIoCS39RzSmiCZ8aO+EL7T/GZLN+UWlUKLzhWgNacmkS4l91QB
         49zQ==
X-Gm-Message-State: AC+VfDxkXlb3+yyv4tjRsXLLtGfa0VpnzDqiYG9akX4ay4j3+zeMfbok
	O0p0gL3MuqfQTFbKw6C59YmfCFRTs5g=
X-Google-Smtp-Source: ACHHUZ7ChPsWI9282k1Yw4tcr5asjqgsEUgjQIPhhUL0ejnPHcQoomSB8il16rTef5lwFLUkNJ9u8w==
X-Received: by 2002:a5d:63c5:0:b0:30f:cf93:4bb8 with SMTP id c5-20020a5d63c5000000b0030fcf934bb8mr19296051wrw.57.1687655994799;
        Sat, 24 Jun 2023 18:19:54 -0700 (PDT)
Received: from krava (brn-rj-tbond05.sa.cz. [185.94.55.134])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d5682000000b00313ec7dd652sm464328wrv.44.2023.06.24.18.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 18:19:54 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 25 Jun 2023 03:19:51 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf-next 11/24] libbpf: Add
 bpf_program__attach_uprobe_multi_opts function
Message-ID: <ZJeWN5yAA/XnKL+i@krava>
References: <20230620083550.690426-1-jolsa@kernel.org>
 <20230620083550.690426-12-jolsa@kernel.org>
 <CAEf4BzbqLTfBmGkogfVhTsunCvaX_VdNb46PqXAx8Sff1u_Ahg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbqLTfBmGkogfVhTsunCvaX_VdNb46PqXAx8Sff1u_Ahg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 01:40:08PM -0700, Andrii Nakryiko wrote:
> On Tue, Jun 20, 2023 at 1:37 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding bpf_program__attach_uprobe_multi_opts function that
> > allows to attach multiple uprobes with uprobe_multi link.
> >
> > The user can specify uprobes with direct arguments:
> >
> >   binary_path/func_pattern
> >
> > or with struct bpf_uprobe_multi_opts opts argument fields:
> >
> >   const char *path;
> >   const char **syms;
> >   const unsigned long *offsets;
> >   const unsigned long *ref_ctr_offsets;
> >
> > User can specify 3 mutually exclusive set of incputs:
> 
> typo: inputs
> 
> >
> >  1) use only binary_path/func_pattern aruments
> 
> typo: arguments

ok

> 
> >
> >  2) use only opts argument with allowed combinations of:
> >     path/offsets/ref_ctr_offsets/cookies/cnt
> >
> >  3) use binary_path with allowed combinations of:
> >     syms/offsets/ref_ctr_offsets/cookies/cnt
> >
> 
> why do we need this duplication of binary_path and opts.path? same for
> pid and opts.pid?

right, will remove opts.path|pid

> 
> > Any other usage results in error.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c   | 131 +++++++++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/libbpf.h   |  31 +++++++++
> >  tools/lib/bpf/libbpf.map |   1 +
> >  3 files changed, 163 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 3e5c88caf5d5..d972cea4c658 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -11402,6 +11402,137 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
> >         return -ENOENT;
> >  }
> >
> > +struct bpf_link *
> > +bpf_program__attach_uprobe_multi_opts(const struct bpf_program *prog,
> 
> let's call it just bpf_program__attach_uprobe_multi()
> 
> we should have done that with bpf_program__attach_kprobe_multi_opts()
> as well. Generally, if the only variant of API is the one with opts,
> then there is no point in adding "_opts" suffix to the API name, IMO

ok

> 
> 
> > +                                     pid_t pid,
> > +                                     const char *binary_path,
> > +                                     const char *func_pattern,
> > +                                     const struct bpf_uprobe_multi_opts *opts)
> > +{
> > +       const unsigned long *ref_ctr_offsets = NULL, *offsets = NULL;
> > +       LIBBPF_OPTS(bpf_link_create_opts, lopts);
> > +       unsigned long *resolved_offsets = NULL;
> > +       const char **resolved_symbols = NULL;
> > +       int err = 0, link_fd, prog_fd;
> > +       struct bpf_link *link = NULL;
> > +       char errmsg[STRERR_BUFSIZE];
> > +       const char *path, **syms;
> > +       char full_path[PATH_MAX];
> > +       const __u64 *cookies;
> > +       bool has_pattern;
> > +       bool retprobe;
> > +       size_t cnt;
> > +
> > +       if (!OPTS_VALID(opts, bpf_uprobe_multi_opts))
> > +               return libbpf_err_ptr(-EINVAL);
> > +
> > +       path = OPTS_GET(opts, path, NULL);
> > +       syms = OPTS_GET(opts, syms, NULL);
> > +       offsets = OPTS_GET(opts, offsets, NULL);
> > +       ref_ctr_offsets = OPTS_GET(opts, ref_ctr_offsets, NULL);
> > +       cookies = OPTS_GET(opts, cookies, NULL);
> > +       cnt = OPTS_GET(opts, cnt, 0);
> > +
> > +       /*
> > +        * User can specify 3 mutually exclusive set of incputs:
> > +        *
> > +        * 1) use only binary_path/func_pattern aruments
> 
> same typos
> 
> > +        *
> > +        * 2) use only opts argument with allowed combinations of:
> > +        *    path/offsets/ref_ctr_offsets/cookies/cnt
> > +        *
> > +        * 3) use binary_path with allowed combinations of:
> > +        *    syms/offsets/ref_ctr_offsets/cookies/cnt
> > +        *
> > +        * Any other usage results in error.
> > +        */
> > +
> 
> 
> Looking at this part (sorry, I already trimmed reply before realizing
> I want to comment on this):
> 
> 
> +               err = elf_find_pattern_func_offset(binary_path, func_pattern,
> +                                                  &resolved_symbols,
> &resolved_offsets,
> +                                                  &cnt);
> +               if (err < 0)
> +                       return libbpf_err_ptr(err);
> +               offsets = resolved_offsets;
> +       } else if (syms) {
> +               err = elf_find_multi_func_offset(binary_path, cnt,
> syms, &resolved_offsets);
> 
> Few thoughts.
> 
> First, we are not using resolved_symbols returned from
> elf_find_pattern_func_offset(), do we? If not, let's drop it.

I think I used that in bpftrace with the RFC version,
where I wanted to display found symbols.. but there's
no use for it in libbpf for now.. will remove it

> 
> Second, I'm not a big fan of chosen naming. Maybe something like
> elf_resolve_{pattern,syms}_offsets?

sure

SNIP

> > +LIBBPF_API struct bpf_link *
> > +bpf_program__attach_uprobe_multi_opts(const struct bpf_program *prog,
> > +                                     pid_t pid,
> > +                                     const char *binary_path,
> > +                                     const char *func_pattern,
> > +                                     const struct bpf_uprobe_multi_opts *opts);
> > +
> >  struct bpf_ksyscall_opts {
> >         /* size of this struct, for forward/backward compatibility */
> >         size_t sz;
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index 7521a2fb7626..81558ef1bc38 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -390,6 +390,7 @@ LIBBPF_1.2.0 {
> >                 bpf_link_get_info_by_fd;
> >                 bpf_map_get_info_by_fd;
> >                 bpf_prog_get_info_by_fd;
> > +               bpf_program__attach_uprobe_multi_opts;
> 
> should be in 1.3.0?

yes, will fix

thanks,
jirka

