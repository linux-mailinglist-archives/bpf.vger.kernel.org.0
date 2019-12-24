Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFE1129BFD
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2019 01:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfLXAJb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Dec 2019 19:09:31 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33420 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfLXAJb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Dec 2019 19:09:31 -0500
Received: by mail-qk1-f195.google.com with SMTP id d71so7018862qkc.0;
        Mon, 23 Dec 2019 16:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pu5L+bxTE30ryYIOBF83rHNPUsWCI2dbAcOYhYtXBw0=;
        b=Cyu37PyLyS5hhxm1elgprP9KOsSQl3RuQfogWOF5+EiHiD2u4Pqpwvou54PxHJIJ32
         I9DmfUQBLGoRZUSZAAY708JKYEO1xFfKZh58wAa2zEPGvel1s2lDWsjFLClVtzNoIvnB
         kriTCnledocn8pe5xJNCHHMQEihHL5PIhlg1htlCcdIImqkgnZkqCdB3dcsz++9czLm2
         PKetWR5zlHpamP0Bo7xVl8lz/gXwRhGGBfdrHILWFnmpKrAyYfLd8c7k2byOoa3/+kc9
         k4tJcQ81pVbrHQ23s2jbL9PatqpYoRxsoLsiyXeLpuA5VQSOy2A3nBfrvUF0/voxu1Na
         7kWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pu5L+bxTE30ryYIOBF83rHNPUsWCI2dbAcOYhYtXBw0=;
        b=ij1JLgZ3zKHQni/Daz2n/HJPDbcHFrPVlk2QCBUsAXtwMDre5eBQzkTAHmnZfK4oFQ
         aYmn9IDhp8XUL3JhDGKJefjdWR0+djMJkj1tNkoFUgfG9s+07OIItwsJPY+XXaMwpCis
         DVGrLA6fUCpHXTUF94QtpA0v63NyvGr+foDV5lusNOquvoTt4B2+R8BPjFh8wMmKOCsp
         2SMHnvfAv/05tGdu4ldDEkq05vUDPCrMsHnLdh8M85A3K/dfhpzFKVayTy23gqwN+thh
         1Tc5/sG7hFyUNUc9vhLZCi+vzl4X20JEkDqt4VkmRG3VZ52qr8LCr1qCSNEbWZlV79jv
         0XIw==
X-Gm-Message-State: APjAAAXDEjRS17izLZKvS3f3Ab4QIRFUXkqCAqI9fxhHDbMy+IWSUuFp
        8JLEMy5Vc3jevoX6A0yUkvRhRdU8nP90ZWLOMbo=
X-Google-Smtp-Source: APXvYqz63+VdPLFcx7mCtf4DjdEsJKLeMa3Gud8cm3sua6KMJNfDXAm3YJT68HbwTZIBeIe4+roY92UI4S/wb+JLBZA=
X-Received: by 2002:a05:620a:14a2:: with SMTP id x2mr29113651qkj.36.1577146169824;
 Mon, 23 Dec 2019 16:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20191220154208.15895-1-kpsingh@chromium.org> <20191220154208.15895-6-kpsingh@chromium.org>
 <CAEf4BzYz6wswhr+byP_xabLoWyA2ah8P2a-STOgqXzuiNkHShw@mail.gmail.com>
In-Reply-To: <CAEf4BzYz6wswhr+byP_xabLoWyA2ah8P2a-STOgqXzuiNkHShw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 Dec 2019 16:09:18 -0800
Message-ID: <CAEf4Bza2gpeQSy-Eo-DXk1UsVkhRXSq5NmL7ra-grWq5FJCmVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 05/13] tools/libbpf: Add support in libbpf for BPF_PROG_TYPE_LSM
To:     KP Singh <kpsingh@chromium.org>
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
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 23, 2019 at 4:07 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
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
>

ah, haven't gotten to patch 11 yet, disregard this.

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
>
> > +       return btf__find_by_name_kind(btf, btf_type_name, BTF_KIND_TYPEDEF);
> > +}
> > +
> > +#define BTF_TRACE_PREFIX "btf_trace_"
> > +#define BTF_LSM_PREFIX "lsm_btf_"
> > +
>
> [...]
