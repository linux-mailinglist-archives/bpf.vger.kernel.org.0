Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 840C712FF59
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2020 00:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgACX7W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jan 2020 18:59:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35488 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgACX7W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jan 2020 18:59:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so43852557wro.2
        for <bpf@vger.kernel.org>; Fri, 03 Jan 2020 15:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SARyQFhSxJsQE3l2/qodYJx8iLHDoBHeNPf8Xo1zveE=;
        b=NedTeI+eLfUgKK9t2j11TEYartJIJDyTi4XhYywMMUSQV/wAgaHINPJ/+GftuMB3M3
         S4tczh3TzB7gLPTsI+5m3yaPGnN8RSi5jR1kJZFW4uNJg7HLECYAGEaVHKx+NPJgE/fV
         0+JkxyN+uXBTpjTbjU8Wtt8o4To0shtFpuGjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SARyQFhSxJsQE3l2/qodYJx8iLHDoBHeNPf8Xo1zveE=;
        b=dPH9iCdmqT9QiAi2ZjYdo3JmhWX0FRujskHQoytIGzt3D1JP1q7GL/rqiU8c2rmG9c
         sgyVUTpcUCp9cqZTQETlf9IRHTKRNXLQ15Uj6WWox0LJeMGD6TjlkRPNlZfU6hAIZnOv
         vhLzZsHSNuzcLunQkz4Rsl70rde1pjHzHJu61ZlrhdsLn9Df60KdGTmuNkA8JDdwFLDo
         AUdx65B/G+hdrdPOV68JyTTbHYk9RMjwR8CgaUUGObPEP0E8AXZiR+DJ5yEonWH9Pvei
         Y32Izmnnc9HyWO9ixfHGh8y+dbmVVh9jRRWPfcPmOCB3A9SfD6I8R90EchXdAus65wkN
         U6Yw==
X-Gm-Message-State: APjAAAV3AlxWVzrm3CXp2PugSXOfNl7iqOKfGhUuQ+FSIUSfCjfWkwgk
        YbgpQ+6zvNHeZQYawgB5GJUCMw==
X-Google-Smtp-Source: APXvYqzODuq6TXhV0g7v23aDXosT9z0iazuXvi+9LK0nMZzxtHmkMZw7jYCf4uNpzzAxXrRFxuyUOA==
X-Received: by 2002:adf:9c8f:: with SMTP id d15mr91319380wre.390.1578095960065;
        Fri, 03 Jan 2020 15:59:20 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id z11sm62493271wrt.82.2020.01.03.15.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 15:59:19 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Sat, 4 Jan 2020 00:59:33 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v1 05/13] tools/libbpf: Add support in libbpf
 for BPF_PROG_TYPE_LSM
Message-ID: <20200103235933.GA23487@chromium.org>
References: <20191220154208.15895-1-kpsingh@chromium.org>
 <20191220154208.15895-6-kpsingh@chromium.org>
 <CAEf4BzYz6wswhr+byP_xabLoWyA2ah8P2a-STOgqXzuiNkHShw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYz6wswhr+byP_xabLoWyA2ah8P2a-STOgqXzuiNkHShw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23-Dez 16:07, Andrii Nakryiko wrote:
> On Fri, Dec 20, 2019 at 7:43 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > Update the libbpf library with functionality to load and
> > attach a program type BPF_PROG_TYPE_LSM, currently with
> > only one expected attach type BPF_LSM_MAC.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  tools/lib/bpf/bpf.c           |  2 +-
> >  tools/lib/bpf/bpf.h           |  6 +++++
> >  tools/lib/bpf/libbpf.c        | 44 +++++++++++++++++++++--------------
> >  tools/lib/bpf/libbpf.h        |  2 ++
> >  tools/lib/bpf/libbpf.map      |  6 +++++
> >  tools/lib/bpf/libbpf_probes.c |  1 +
> >  6 files changed, 43 insertions(+), 18 deletions(-)
> >
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index 98596e15390f..9c6fb083f7de 100644
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
> > @@ -228,7 +228,7 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
> >         memset(&attr, 0, sizeof(attr));
> >         attr.prog_type = load_attr->prog_type;
> >         attr.expected_attach_type = load_attr->expected_attach_type;
> > -       if (attr.prog_type == BPF_PROG_TYPE_TRACING) {
> > +       if (needs_btf_attach(attr.prog_type)) {
> >                 attr.attach_btf_id = load_attr->attach_btf_id;
> >                 attr.attach_prog_fd = load_attr->attach_prog_fd;
> >         } else {
> > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > index 3c791fa8e68e..df2a00ff349f 100644
> > --- a/tools/lib/bpf/bpf.h
> > +++ b/tools/lib/bpf/bpf.h
> > @@ -177,6 +177,12 @@ LIBBPF_API int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf,
> >                                  __u32 *buf_len, __u32 *prog_id, __u32 *fd_type,
> >                                  __u64 *probe_offset, __u64 *probe_addr);
> >
> > +static inline bool needs_btf_attach(enum bpf_prog_type prog_type)
> > +{
> > +       return (prog_type == BPF_PROG_TYPE_TRACING ||
> > +               prog_type == BPF_PROG_TYPE_LSM);
> > +}
> > +
> 
> This doesn't have to be a public API, right? It also doesn't follow
> naming conventions of libbpf APIs. Let's just move it into
> libbpf_internal.h, given it's used in few files.
> 
> Also, Martin's patches add STRUCT_OPS, which do need btf_attach, but
> don't set attach_prog_fd. So maybe something like
> libbpf_need_attach_prog_btf() for a name to be a bit more specific?

Updated for the next revision. Thanks!

> 
> 
> >  #ifdef __cplusplus
> >  } /* extern "C" */
> >  #endif
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index b20f82e58989..b0b27d8e5a37 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -3738,7 +3738,7 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
> >         load_attr.insns = insns;
> >         load_attr.insns_cnt = insns_cnt;
> >         load_attr.license = license;
> > -       if (prog->type == BPF_PROG_TYPE_TRACING) {
> > +       if (needs_btf_attach(prog->type)) {
> >                 load_attr.attach_prog_fd = prog->attach_prog_fd;
> >                 load_attr.attach_btf_id = prog->attach_btf_id;
> >         } else {
> > @@ -3983,7 +3983,7 @@ __bpf_object__open(const char *path, const void *obj_buf, size_t obj_buf_sz,
> >
> >                 bpf_program__set_type(prog, prog_type);
> >                 bpf_program__set_expected_attach_type(prog, attach_type);
> > -               if (prog_type == BPF_PROG_TYPE_TRACING) {
> > +               if (needs_btf_attach(prog_type)) {
> >                         err = libbpf_find_attach_btf_id(prog->section_name,
> >                                                         attach_type,
> >                                                         attach_prog_fd);
> > @@ -4933,6 +4933,7 @@ bool bpf_program__is_##NAME(const struct bpf_program *prog)       \
> >  }                                                              \
> >
> >  BPF_PROG_TYPE_FNS(socket_filter, BPF_PROG_TYPE_SOCKET_FILTER);
> > +BPF_PROG_TYPE_FNS(lsm, BPF_PROG_TYPE_LSM);
> >  BPF_PROG_TYPE_FNS(kprobe, BPF_PROG_TYPE_KPROBE);
> >  BPF_PROG_TYPE_FNS(sched_cls, BPF_PROG_TYPE_SCHED_CLS);
> >  BPF_PROG_TYPE_FNS(sched_act, BPF_PROG_TYPE_SCHED_ACT);
> > @@ -5009,6 +5010,8 @@ static const struct {
> >         BPF_PROG_SEC("lwt_out",                 BPF_PROG_TYPE_LWT_OUT),
> >         BPF_PROG_SEC("lwt_xmit",                BPF_PROG_TYPE_LWT_XMIT),
> >         BPF_PROG_SEC("lwt_seg6local",           BPF_PROG_TYPE_LWT_SEG6LOCAL),
> > +       BPF_PROG_BTF("lsm/",                    BPF_PROG_TYPE_LSM,
> > +                                               BPF_LSM_MAC),
> 
> Is is supposed to be attachable same as BPF_PROG_TYPE_TRACING
> programs? If yes, please define auto-attaching function, similar to
> SEC_DEF("raw_tp") few lines below this one.

Nice! rebased and updated. 

> 
> >         BPF_APROG_SEC("cgroup_skb/ingress",     BPF_PROG_TYPE_CGROUP_SKB,
> >                                                 BPF_CGROUP_INET_INGRESS),
> >         BPF_APROG_SEC("cgroup_skb/egress",      BPF_PROG_TYPE_CGROUP_SKB,
> > @@ -5119,32 +5122,39 @@ int libbpf_prog_type_by_name(const char *name, enum bpf_prog_type *prog_type,
> >         return -ESRCH;
> >  }
> >
> > -#define BTF_PREFIX "btf_trace_"
> > +static inline int __btf__typdef_with_prefix(struct btf *btf, const char *name,
> 
> typo: typdef -> typedef
> 
> But actually let's generalize it to pass BTF_KIND as another param, I
> think I have a need for this (we might want to do that for structs,
> not just typedef->func_proto).
> Following btf__find_by_name_kind() naming, it probably should be
> called btf__find_by_prefix_kind()?

Thanks! Good idea, updated. Should this be moved to btf.c?

> 
> > +                                           const char *prefix)
> > +{
> > +
> > +       size_t prefix_len = strlen(prefix);
> > +       char btf_type_name[128];
> > +
> > +       strcpy(btf_type_name, prefix);
> > +       strncat(btf_type_name, name, sizeof(btf_type_name) - (prefix_len + 1));
> 
> at this point snprintf(btf_type_name, "%s%.*%s", prefix,
> sizeof(btf_type_name) - prefix_len - 1, name) looks like a better and
> cleaner alternative.

I just changed it to:

  snprintf(btf_type_name, sizeof(btf_type_name), "%s%s", prefix, name);
 
- KP

> 
> > +       return btf__find_by_name_kind(btf, btf_type_name, BTF_KIND_TYPEDEF);
> > +}
> > +
> > +#define BTF_TRACE_PREFIX "btf_trace_"
> > +#define BTF_LSM_PREFIX "lsm_btf_"
> > +
> 
> [...]
