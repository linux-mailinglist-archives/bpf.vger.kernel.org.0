Return-Path: <bpf+bounces-4742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7684674E9D0
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E4F1C20CEF
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 09:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B306917745;
	Tue, 11 Jul 2023 09:05:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E8317723
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:05:14 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC97F93
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:05:12 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e278e344bso6606511a12.0
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689066311; x=1691658311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lx0Yjuk2FbTQ4UZLGPgsX41sHECQCuOSOliIJwwK+U0=;
        b=f8GXLGEAxal36qQM6sunFVQexBNIDQjmh9E0YTUFo9+s7Pxx5CBJzHAye+FB+vFoFk
         7a+yWQ+x2uqQSvGoM2KuZisEIu2evlgC1FN3oupABSHp0Wd9OkbCUAWI9zJqXQSa49xi
         h3c3Lemwr2L8nvY6pdzL1N5PXEkHAh1pJifiQQk8YSukMYR13NKWcvarlVOJHFjkUkl5
         GkQsrAQbOn8FnkN4aDeI9BOGP5E5SF734F6bKBuzMVt2gztiInPY3qy4fiRwA8VcYHTa
         xjYMWLr7ninOkdgeRhkXFhR2258qZGYZONdYGvQg1BjAkjg8miuT7vofwFfLb4zIt0uc
         OXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066311; x=1691658311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lx0Yjuk2FbTQ4UZLGPgsX41sHECQCuOSOliIJwwK+U0=;
        b=d4++SFi49VTD7YfbRDqBXUg73YZmF0G6GUZwlmEyZ27b2FxmJTgQgnKCqBl0PkJFhq
         ZiVdNmaKBhvvFWVt/BUAehY0wKwapTYtn7xkTMSTa30PYdVIL1ccejFwuVWjma0ZRdwH
         ljAgzqnnz73iaU2z7mwnT4mactjmWCdliZ8D2eIWNsdi9TUMS3PJvo/T/Qwc2Vm0RQW0
         VdRGjEWATE1pJGoyzp1/POu/0ExtfsQ0cXSipX3UfkTcSSIujkNi8CvsQmWjuQfEBxWM
         7S6vw40f+ReFJPiawxgQmbctpvWrjFw416eUx57EnQ3JZrkfBcUYJy4TMltfd6ltgox6
         xueg==
X-Gm-Message-State: ABy/qLb9dwVUF76LCDTtsd22XIknd+77y2cHPDVh882lHsO/zRP6IbeQ
	2Qz2eNYhy3pL6s0zon6g3cg=
X-Google-Smtp-Source: APBJJlHvDGkZXOEkNoV71/p5qGvlOQ25XSRP6oupjY4SY5a0Y0Y6Vz8GVW3pMu+RDWPsCRsuT3Fjiw==
X-Received: by 2002:aa7:ca4f:0:b0:51d:d615:19af with SMTP id j15-20020aa7ca4f000000b0051dd61519afmr12536018edt.28.1689066311129;
        Tue, 11 Jul 2023 02:05:11 -0700 (PDT)
Received: from krava (net-109-116-206-239.cust.vodafonedsl.it. [109.116.206.239])
        by smtp.gmail.com with ESMTPSA id s11-20020aa7c54b000000b0050cc4461fc5sm921238edr.92.2023.07.11.02.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:05:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 11 Jul 2023 11:05:07 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf-next 13/26] libbpf: Add
 bpf_program__attach_uprobe_multi function
Message-ID: <ZK0bQ5pqKeaAxEUQ@krava>
References: <20230630083344.984305-1-jolsa@kernel.org>
 <20230630083344.984305-14-jolsa@kernel.org>
 <CAEf4Bza16nwKNkktW+r-5OoCsAtPhMkRLedWdrQo+2WDvOR8xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bza16nwKNkktW+r-5OoCsAtPhMkRLedWdrQo+2WDvOR8xA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 09:05:23PM -0700, Andrii Nakryiko wrote:

SNIP

> > +       if (!OPTS_VALID(opts, bpf_uprobe_multi_opts))
> > +               return libbpf_err_ptr(-EINVAL);
> > +
> > +       syms = OPTS_GET(opts, syms, NULL);
> > +       offsets = OPTS_GET(opts, offsets, NULL);
> > +       ref_ctr_offsets = OPTS_GET(opts, ref_ctr_offsets, NULL);
> > +       cookies = OPTS_GET(opts, cookies, NULL);
> > +       cnt = OPTS_GET(opts, cnt, 0);
> > +
> > +       /*
> > +        * User can specify 2 mutually exclusive set of inputs:
> > +        *
> > +        * 1) use only path/func_pattern/pid arguments
> > +        *
> > +        * 2) use path/pid with allowed combinations of:
> > +        *    syms/offsets/ref_ctr_offsets/cookies/cnt
> > +        *
> > +        *    - syms and offsets are mutually exclusive
> > +        *    - ref_ctr_offsets and cookies are optional
> > +        *
> > +        * Any other usage results in error.
> > +        */
> > +
> > +       if (!path && !func_pattern && !cnt)
> 
> weird, I'd expect separate if (!path) return error (already bad,
> regardless of func_pattern or cnt)
> 
> then if (!func_pattern && cnt == 0) return error
> 
> > +               return libbpf_err_ptr(-EINVAL);
> > +       if (func_pattern && !path)
> > +               return libbpf_err_ptr(-EINVAL);
> > +
> > +       has_pattern = path && func_pattern;
> 
> this and above check must be some leftovers from previous version.
> path should always be present. and so you don't need has_pattern
> variable, just use "func_pattern" check

hum, right, previous version had 2 paths, now there's just one,
I'll change that together with the suggested change above

> 
> > +
> > +       if (has_pattern) {
> > +               if (syms || offsets || ref_ctr_offsets || cookies || cnt)
> > +                       return libbpf_err_ptr(-EINVAL);
> > +       } else {
> > +               if (!cnt)
> > +                       return libbpf_err_ptr(-EINVAL);
> > +               if (!!syms == !!offsets)
> > +                       return libbpf_err_ptr(-EINVAL);
> > +       }
> > +
> > +       if (has_pattern) {
> > +               if (!strchr(path, '/')) {
> > +                       err = resolve_full_path(path, full_path, sizeof(full_path));
> > +                       if (err) {
> > +                               pr_warn("prog '%s': failed to resolve full path for '%s': %d\n",
> > +                                       prog->name, path, err);
> > +                               return libbpf_err_ptr(err);
> > +                       }
> > +                       path = full_path;
> > +               }
> > +
> > +               err = elf_resolve_pattern_offsets(path, func_pattern,
> > +                                                 &resolved_offsets, &cnt);
> > +               if (err < 0)
> > +                       return libbpf_err_ptr(err);
> > +               offsets = resolved_offsets;
> > +       } else if (syms) {
> > +               err = elf_resolve_syms_offsets(path, cnt, syms, &resolved_offsets);
> > +               if (err < 0)
> > +                       return libbpf_err_ptr(err);
> > +               offsets = resolved_offsets;
> 
> you can extract this common error checking and `offsets =
> resolved_offsets;` to after if, it's common for both branches

not sure what you mean in here, offsets can be also provided
by OPTS_GET(opts, offsets, NULL) earlier

> > +       }
> > +
> > +       retprobe = OPTS_GET(opts, retprobe, false);
> > +
> > +       lopts.uprobe_multi.path = path;
> > +       lopts.uprobe_multi.offsets = offsets;
> > +       lopts.uprobe_multi.ref_ctr_offsets = ref_ctr_offsets;
> > +       lopts.uprobe_multi.cookies = cookies;
> > +       lopts.uprobe_multi.cnt = cnt;
> > +       lopts.uprobe_multi.flags = retprobe ? BPF_F_UPROBE_MULTI_RETURN : 0;
> 
> retprobe is another unnecessary var, just inline check here to keep it simpler

ok

> 
> > +
> > +       if (pid == 0)
> > +               pid = getpid();
> > +       if (pid > 0)
> > +               lopts.uprobe_multi.pid = pid;
> > +
> > +       link = calloc(1, sizeof(*link));
> > +       if (!link) {
> > +               err = -ENOMEM;
> > +               goto error;
> > +       }
> > +       link->detach = &bpf_link__detach_fd;
> > +
> > +       prog_fd = bpf_program__fd(prog);
> > +       link_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_UPROBE_MULTI, &lopts);
> > +       if (link_fd < 0) {
> > +               err = -errno;
> > +               pr_warn("prog '%s': failed to attach: %s\n",
> 
> "failed to attach multi-uprobe"? We probably should have added "failed
> to attach multi-kprobe" in bpf_program__attach_kprobe_multi_opts as
> well?

ook, will add

> 
> > +                       prog->name, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> > +               goto error;
> > +       }
> > +       link->fd = link_fd;
> > +       free(resolved_offsets);
> > +       return link;
> > +
> > +error:
> > +       free(resolved_offsets);
> > +       free(link);
> > +       return libbpf_err_ptr(err);
> > +}
> > +
> >  LIBBPF_API struct bpf_link *
> >  bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
> >                                 const char *binary_path, size_t func_offset,
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 754da73c643b..7c218f610210 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -529,6 +529,33 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> >                                       const char *pattern,
> >                                       const struct bpf_kprobe_multi_opts *opts);
> >
> > +struct bpf_uprobe_multi_opts {
> > +       /* size of this struct, for forward/backward compatibility */
> > +       size_t sz;
> > +       /* array of function symbols to attach */
> 
> attach to?

ok

> 
> > +       const char **syms;
> > +       /* array of function addresses to attach */
> 
> attach to?

ook

> 
> > +       const unsigned long *offsets;
> > +       /* array of refctr offsets to attach */
> 
> we don't really attach to ref counters, so maybe "optional, array of
> associated ref counter offsets" or something along those lines ?

ok

> 
> > +       const unsigned long *ref_ctr_offsets;
> > +       /* array of user-provided values fetchable through bpf_get_attach_cookie */
> 
> "array of associated BPF cookies"? we can't keep explaining what BPF
> cookie is in every possible API :)

ook

> 
> > +       const __u64 *cookies;
> > +       /* number of elements in syms/addrs/cookies arrays */
> > +       size_t cnt;
> > +       /* create return uprobes */
> > +       bool retprobe;
> > +       size_t :0;
> > +};
> > +
> > +#define bpf_uprobe_multi_opts__last_field retprobe
> > +
> > +LIBBPF_API struct bpf_link *
> > +bpf_program__attach_uprobe_multi(const struct bpf_program *prog,
> > +                                pid_t pid,
> > +                                const char *binary_path,
> > +                                const char *func_pattern,
> > +                                const struct bpf_uprobe_multi_opts *opts);
> > +
> 
> ok, let's be good citizens and add documentation for this new API.
> Those comments about valid combinations belong here as well. Please
> take a look at existing doccomments for the format and conventions.
> Thanks!

ok, will add

thanks,
jirka

