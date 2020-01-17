Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAE31412B5
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2020 22:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgAQVT0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jan 2020 16:19:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34459 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgAQVT0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jan 2020 16:19:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id i6so12508921pfc.1
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2020 13:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xQ1cLk8AoXeuMnKaeWOsZO8UOMouGKhMSseZSkEh3GE=;
        b=TkemZIodaalJY7NhP8tqKO8FcrHui0ykeJnmEu0rE/fbHzNyBS4V9bBJ46T5sEREG5
         Yl6uPvIvEYkYH+Q/0loq+RaQpLIyjDHRu/Uz0+q6dCKQuLBmFwYW0HMs7rA9dTuT2+wJ
         AgJNy6RrszArjB9DsPScMNZr4c/3hXNVacSow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xQ1cLk8AoXeuMnKaeWOsZO8UOMouGKhMSseZSkEh3GE=;
        b=XTbCFaWeJ4UjWdTAq+3jyoD5DOyouUnjFvsOsAI6rkdyPAwJzlU7R+HDqAWADx3ywT
         7zUhbu/RufzntJQF0U3bdG/D/4U92G2btHFHYINAYoMsdPdj/yxC+wSHs5lnX1BRBhyl
         6mRlBcfePcIaH9av2ENZlpBrrp3J04sNJMI//PPH8WxDKCKDkh7o4xfHI76ZrxSiBeSv
         5WEM7XiyZ5f3VY/KeCCo3QptVzBC9SGeCVkkR9j0gytMqO1VhNrbdTHE4bDe8gwYnX34
         xEe13j1viOB/AnKbqKYGkbIlFv2rk2xt1FSTYwXuRfBDsSrTBdl6LW1h7rk//4KGymf+
         BcyQ==
X-Gm-Message-State: APjAAAWTizPUOKWZTGKiyiChUQ1W+ZpqIZVlZYNfM67qaj4qOCCPZiBw
        1OG4MeJw/B51qpRK+jg4e5Zv0A==
X-Google-Smtp-Source: APXvYqxklwQN4hb4h7rQyUp+FqWvLu9tWtd2vCg8YQ9W2WZ8ZQXBY7Gogl25eaHpTd4/WozJVoUhhA==
X-Received: by 2002:aa7:9115:: with SMTP id 21mr5002360pfh.224.1579295965102;
        Fri, 17 Jan 2020 13:19:25 -0800 (PST)
Received: from chromium.org ([165.231.253.166])
        by smtp.gmail.com with ESMTPSA id 81sm31092889pfx.30.2020.01.17.13.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:19:24 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Fri, 17 Jan 2020 22:19:32 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Anton Protopopov <a.s.protopopov@gmail.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next] libbpf: Load btf_vmlinux only once per object.
Message-ID: <20200117211932.GA6256@chromium.org>
References: <20200117165821.21482-1-kpsingh@chromium.org>
 <CAEf4Bzazg0HQt7dSXMBdGTePL+zrTxVP5v5WpSYKk8PFpF4iYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzazg0HQt7dSXMBdGTePL+zrTxVP5v5WpSYKk8PFpF4iYg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks for taking a look. Sending out a v2 with the fixes.

On 17-Jan 11:02, Andrii Nakryiko wrote:
> On Fri, Jan 17, 2020 at 8:58 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > As more programs (TRACING, STRUCT_OPS, and upcoming LSM) use vmlinux
> > BTF information, loading the BTF vmlinux information for every program
> > in an object is sub-optimal. The fix was originally proposed in:
> >
> >    https://lore.kernel.org/bpf/CAEf4BzZodr3LKJuM7QwD38BiEH02Cc1UbtnGpVkCJ00Mf+V_Qg@mail.gmail.com/
> >
> > The btf_vmlinux is populated in the object if any of the programs in
> > the object requires it just before the programs are loaded and freed
> > after the programs finish loading.
> >
> > Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Reviewed-by: Brendan Jackman <jackmanb@chromium.org>
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> 
> Thanks for the clean up! Few issues, but overall I like this.

Thanks!

> 
> >  tools/lib/bpf/libbpf.c | 148 +++++++++++++++++++++++++++--------------
> >  1 file changed, 97 insertions(+), 51 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 3afaca9bce1d..db0e93882a3b 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -385,6 +385,10 @@ struct bpf_object {
> 
> [...]
> 
> > @@ -2364,6 +2357,38 @@ static int bpf_object__finalize_btf(struct bpf_object *obj)
> >         return 0;
> >  }
> >
> > +static inline bool libbpf_prog_needs_vmlinux_btf(struct bpf_program *prog)
> > +{
> 
> I suspect that at some point this approach won't be flexible enough,
> but it simplifies error handling right now, so I'm ok with it.

Acknowledged.

> 
> > +       if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
> > +               return true;
> > +
> > +       /* BPF_PROG_TYPE_TRACING programs which do not attach to other programs
> > +        * also need vmlinux BTF
> > +        */
> > +       if (prog->type == BPF_PROG_TYPE_TRACING && !prog->attach_prog_fd)
> > +               return true;
> > +
> > +       return false;
> > +}
> > +
> > +static int bpf_object__load_vmlinux_btf(struct bpf_object *obj)
> > +{
> > +       struct bpf_program *prog;
> > +
> > +       bpf_object__for_each_program(prog, obj) {
> > +               if (libbpf_prog_needs_vmlinux_btf(prog)) {
> > +                       obj->btf_vmlinux = libbpf_find_kernel_btf();
> > +                       if (IS_ERR(obj->btf_vmlinux)) {
> > +                               pr_warn("vmlinux BTF is not found\n");
> 
> please, emit error code as well
> 
> also, clear out btf_vmlinux, otherwise your code will attempt to free
> invalid pointer later on

Done, also changed it so that the error code does not get clobbered.
 
> > +                               return -EINVAL;
> > +                       }
> > +                       return 0;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> 
> [...]
> 
> > @@ -5280,10 +5301,17 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
> >         err = err ? : bpf_object__resolve_externs(obj, obj->kconfig);
> >         err = err ? : bpf_object__sanitize_and_load_btf(obj);
> >         err = err ? : bpf_object__sanitize_maps(obj);
> > +       err = err ? : bpf_object__load_vmlinux_btf(obj);
> >         err = err ? : bpf_object__init_kern_struct_ops_maps(obj);
> >         err = err ? : bpf_object__create_maps(obj);
> >         err = err ? : bpf_object__relocate(obj, attr->target_btf_path);
> >         err = err ? : bpf_object__load_progs(obj, attr->log_level);
> > +
> > +       if (obj->btf_vmlinux) {
> 
> you can skip this check, btf__free(NULL) is handled properly as noop

Done. Skipped.

> 
> > +               btf__free(obj->btf_vmlinux);
> > +               obj->btf_vmlinux = NULL;
> > +       }
> > +
> >         if (err)
> >                 goto out;
> 
> [...]
> 
> > +
> > +static inline int __find_vmlinux_btf_id(struct btf *btf, const char *name,
> > +                                       enum bpf_attach_type attach_type)
> > +{
> > +       int err;
> > +
> > +       if (attach_type == BPF_TRACE_RAW_TP)
> > +               err = find_btf_by_prefix_kind(btf, BTF_TRACE_PREFIX, name,
> > +                                             BTF_KIND_TYPEDEF);
> > +       else
> > +               err = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
> > +
> > +       return err;
> > +}
> > +
> >  int libbpf_find_vmlinux_btf_id(const char *name,
> >                                enum bpf_attach_type attach_type)
> >  {
> >         struct btf *btf = libbpf_find_kernel_btf();
> 
> I had complaints previously about doing too much heavy-lifting in
> variable assignment, not sure why this slipped through. Can you please
> split this into variable declaration and separate assignment below?

Done.

> 
> > -       char raw_tp_btf[128] = BTF_PREFIX;
> > -       char *dst = raw_tp_btf + sizeof(BTF_PREFIX) - 1;
> > -       const char *btf_name;
> > -       int err = -EINVAL;
> > -       __u32 kind;
> >
> >         if (IS_ERR(btf)) {
> >                 pr_warn("vmlinux BTF is not found\n");
> >                 return -EINVAL;
> >         }
> >
> > -       if (attach_type == BPF_TRACE_RAW_TP) {
> > -               /* prepend "btf_trace_" prefix per kernel convention */
> > -               strncat(dst, name, sizeof(raw_tp_btf) - sizeof(BTF_PREFIX));
> > -               btf_name = raw_tp_btf;
> > -               kind = BTF_KIND_TYPEDEF;
> > -       } else {
> > -               btf_name = name;
> > -               kind = BTF_KIND_FUNC;
> > -       }
> > -       err = btf__find_by_name_kind(btf, btf_name, kind);
> > -       btf__free(btf);
> > -       return err;
> > +       return __find_vmlinux_btf_id(btf, name, attach_type);
> >  }
> >
> >  static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
> > @@ -6567,10 +6612,11 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
> >         return err;
> >  }
> >
> > -static int libbpf_find_attach_btf_id(const char *name,
> > -                                    enum bpf_attach_type attach_type,
> > -                                    __u32 attach_prog_fd)
> > +static int libbpf_find_attach_btf_id(struct bpf_program *prog)
> >  {
> > +       enum bpf_attach_type attach_type = prog->expected_attach_type;
> > +       __u32 attach_prog_fd = prog->attach_prog_fd;
> > +       const char *name = prog->section_name;
> >         int i, err;
> >
> >         if (!name)
> > @@ -6585,8 +6631,8 @@ static int libbpf_find_attach_btf_id(const char *name,
> >                         err = libbpf_find_prog_btf_id(name + section_defs[i].len,
> >                                                       attach_prog_fd);
> >                 else
> > -                       err = libbpf_find_vmlinux_btf_id(name + section_defs[i].len,
> > -                                                        attach_type);
> > +                       err = __find_vmlinux_btf_id(prog->obj->btf_vmlinux,
> > +                               name + section_defs[i].len, attach_type);
> 
> argument indentation is off here, please fix

Fixed.

- KP
> 
> >                 if (err <= 0)
> >                         pr_warn("%s is not found in vmlinux BTF\n", name);
> >                 return err;
> > --
> > 2.20.1
> >
