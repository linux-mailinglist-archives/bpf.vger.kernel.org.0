Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAB9F190378
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 02:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgCXB5w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 21:57:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46708 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgCXB5t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Mar 2020 21:57:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id j17so16181364wru.13
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2020 18:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RpQdqQckgGm2WWiyueiHb411K6FB188eTrmc1Bc7jgg=;
        b=HaKAJuSB9JP5Kv50IBxAaSFwwu5uPS1eyVpWruScPBSuG+kSdtycBaHewsLi6LrqqY
         MgGig39UPW/hBekx2ykhxf0GgmG5GNKUPqvA7jv8W092E5BtHtp+Kjb+B1MUEep4fOjU
         V9cXX1Y0xDrdzHtMZF28YzPI6GW0hPYI56Hxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RpQdqQckgGm2WWiyueiHb411K6FB188eTrmc1Bc7jgg=;
        b=oN5KOggYXBJnCVHZgNSnk8SQsk6pItqv6Y/euWydsEI5R5O28oDXbftLPhb0CrME+Y
         /K7vDye8y9Bpb8zMgG+irzxz51hSbMu7WnDFlsMHIFtpdMvvj205X7QmYsCAmvNTOnlP
         Zkk3xjMtASkyLCMF+SE7kCuzQN/2nH2ZJS0gWbpPV2u0IX9cXDnIaUlwuOPbQVI69Z5m
         ylEyMNo/vJDzjKimroEMj5jZTRhquZYnCd6amI6giW4PLBS1jnslA66U6NphIVGUmfXr
         HdvxoQ+2qFaRsbuI9FqY4s8cR1NbLLVt4spZjsx5ME/54fobOzsbbgDliXbhOo0MDthD
         hOWg==
X-Gm-Message-State: ANhLgQ2XjG5d1feIl4fy65pW/x5cLD28cLC511ZalDE8AuwmIV8Ue8Lh
        520FywGENznQxbk2d/aWc/IP8A==
X-Google-Smtp-Source: ADFU+vv51KLIgLWH30sFZvEOOp0VIp4+x2gRC/a6+KOPVdLoqOaBEgn1tDuifXEUYSmYO0YQHCPdIg==
X-Received: by 2002:a5d:53ce:: with SMTP id a14mr909797wrw.129.1585015065421;
        Mon, 23 Mar 2020 18:57:45 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id y5sm2029387wmi.34.2020.03.23.18.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 18:57:44 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 24 Mar 2020 02:57:42 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v5 6/7] tools/libbpf: Add support for
 BPF_PROG_TYPE_LSM
Message-ID: <20200324015742.GC28487@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-7-kpsingh@chromium.org>
 <CAEf4BzYr+SMdGKGN-MCRzaS3e2MEQeQFSbuOZ55Vd-gK9RwDPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYr+SMdGKGN-MCRzaS3e2MEQeQFSbuOZ55Vd-gK9RwDPA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 23-Mär 13:25, Andrii Nakryiko wrote:
> On Mon, Mar 23, 2020 at 9:45 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > Since BPF_PROG_TYPE_LSM uses the same attaching mechanism as
> > BPF_PROG_TYPE_TRACING, the common logic is refactored into a static
> > function bpf_program__attach_btf.
> >
> > A new API call bpf_program__attach_lsm is still added to avoid userspace
> > conflicts if this ever changes in the future.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > Reviewed-by: Florent Revest <revest@google.com>
> > ---
> >  tools/lib/bpf/bpf.c      |  3 ++-
> >  tools/lib/bpf/libbpf.c   | 41 +++++++++++++++++++++++++++++++++++-----
> >  tools/lib/bpf/libbpf.h   |  4 ++++
> >  tools/lib/bpf/libbpf.map |  3 +++
> >  4 files changed, 45 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index c6dafe563176..73220176728d 100644
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
> > @@ -235,7 +235,8 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
> >         memset(&attr, 0, sizeof(attr));
> >         attr.prog_type = load_attr->prog_type;
> >         attr.expected_attach_type = load_attr->expected_attach_type;
> > -       if (attr.prog_type == BPF_PROG_TYPE_STRUCT_OPS) {
> > +       if (attr.prog_type == BPF_PROG_TYPE_STRUCT_OPS ||
> > +           attr.prog_type == BPF_PROG_TYPE_LSM) {
> >                 attr.attach_btf_id = load_attr->attach_btf_id;
> >         } else if (attr.prog_type == BPF_PROG_TYPE_TRACING ||
> >                    attr.prog_type == BPF_PROG_TYPE_EXT) {
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 085e41f9b68e..da8bee78e1ce 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -2362,7 +2362,8 @@ static int bpf_object__finalize_btf(struct bpf_object *obj)
> >
> >  static inline bool libbpf_prog_needs_vmlinux_btf(struct bpf_program *prog)
> >  {
> > -       if (prog->type == BPF_PROG_TYPE_STRUCT_OPS)
> > +       if (prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
> > +           prog->type == BPF_PROG_TYPE_LSM)
> >                 return true;
> >
> >         /* BPF_PROG_TYPE_TRACING programs which do not attach to other programs
> > @@ -4870,7 +4871,8 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
> >         load_attr.insns = insns;
> >         load_attr.insns_cnt = insns_cnt;
> >         load_attr.license = license;
> > -       if (prog->type == BPF_PROG_TYPE_STRUCT_OPS) {
> > +       if (prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
> > +           prog->type == BPF_PROG_TYPE_LSM) {
> >                 load_attr.attach_btf_id = prog->attach_btf_id;
> >         } else if (prog->type == BPF_PROG_TYPE_TRACING ||
> >                    prog->type == BPF_PROG_TYPE_EXT) {
> > @@ -4955,6 +4957,7 @@ int bpf_program__load(struct bpf_program *prog, char *license, __u32 kern_ver)
> >         int err = 0, fd, i, btf_id;
> >
> >         if ((prog->type == BPF_PROG_TYPE_TRACING ||
> > +            prog->type == BPF_PROG_TYPE_LSM ||
> >              prog->type == BPF_PROG_TYPE_EXT) && !prog->attach_btf_id) {
> >                 btf_id = libbpf_find_attach_btf_id(prog);
> >                 if (btf_id <= 0)
> > @@ -6194,6 +6197,7 @@ bool bpf_program__is_##NAME(const struct bpf_program *prog)       \
> >  }                                                              \
> >
> >  BPF_PROG_TYPE_FNS(socket_filter, BPF_PROG_TYPE_SOCKET_FILTER);
> > +BPF_PROG_TYPE_FNS(lsm, BPF_PROG_TYPE_LSM);
> >  BPF_PROG_TYPE_FNS(kprobe, BPF_PROG_TYPE_KPROBE);
> >  BPF_PROG_TYPE_FNS(sched_cls, BPF_PROG_TYPE_SCHED_CLS);
> >  BPF_PROG_TYPE_FNS(sched_act, BPF_PROG_TYPE_SCHED_ACT);
> > @@ -6260,6 +6264,8 @@ static struct bpf_link *attach_raw_tp(const struct bpf_sec_def *sec,
> >                                       struct bpf_program *prog);
> >  static struct bpf_link *attach_trace(const struct bpf_sec_def *sec,
> >                                      struct bpf_program *prog);
> > +static struct bpf_link *attach_lsm(const struct bpf_sec_def *sec,
> > +                                  struct bpf_program *prog);
> >
> >  struct bpf_sec_def {
> >         const char *sec;
> > @@ -6310,6 +6316,10 @@ static const struct bpf_sec_def section_defs[] = {
> >         SEC_DEF("freplace/", EXT,
> >                 .is_attach_btf = true,
> >                 .attach_fn = attach_trace),
> > +       SEC_DEF("lsm/", LSM,
> > +               .is_attach_btf = true,
> > +               .expected_attach_type = BPF_LSM_MAC,
> > +               .attach_fn = attach_lsm),
> >         BPF_PROG_SEC("xdp",                     BPF_PROG_TYPE_XDP),
> >         BPF_PROG_SEC("perf_event",              BPF_PROG_TYPE_PERF_EVENT),
> >         BPF_PROG_SEC("lwt_in",                  BPF_PROG_TYPE_LWT_IN),
> > @@ -6572,6 +6582,7 @@ static int bpf_object__collect_struct_ops_map_reloc(struct bpf_object *obj,
> >  }
> >
> >  #define BTF_TRACE_PREFIX "btf_trace_"
> > +#define BTF_LSM_PREFIX "bpf_lsm_"
> >  #define BTF_MAX_NAME_SIZE 128
> >
> >  static int find_btf_by_prefix_kind(const struct btf *btf, const char *prefix,
> > @@ -6599,6 +6610,9 @@ static inline int __find_vmlinux_btf_id(struct btf *btf, const char *name,
> >         if (attach_type == BPF_TRACE_RAW_TP)
> >                 err = find_btf_by_prefix_kind(btf, BTF_TRACE_PREFIX, name,
> >                                               BTF_KIND_TYPEDEF);
> > +       else if (attach_type == BPF_LSM_MAC)
> > +               err = find_btf_by_prefix_kind(btf, BTF_LSM_PREFIX, name,
> > +                                             BTF_KIND_FUNC);
> >         else
> >                 err = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
> >
> > @@ -7452,7 +7466,8 @@ static struct bpf_link *attach_raw_tp(const struct bpf_sec_def *sec,
> >         return bpf_program__attach_raw_tracepoint(prog, tp_name);
> >  }
> >
> > -struct bpf_link *bpf_program__attach_trace(struct bpf_program *prog)
> > +/* Common logic for all BPF program types that attach to a btf_id */
> > +static struct bpf_link *bpf_program__attach_btf(struct bpf_program *prog)
> 
> bpf_program__attach_btf_id() would be a bit more precise name

Agreed, Updated.

> 
> >  {
> >         char errmsg[STRERR_BUFSIZE];
> >         struct bpf_link *link;
> > @@ -7474,7 +7489,7 @@ struct bpf_link *bpf_program__attach_trace(struct bpf_program *prog)
> >         if (pfd < 0) {
> >                 pfd = -errno;
> >                 free(link);
> > -               pr_warn("program '%s': failed to attach to trace: %s\n",
> > +               pr_warn("program '%s': failed to attach: %s\n",
> >                         bpf_program__title(prog, false),
> >                         libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
> >                 return ERR_PTR(pfd);
> > @@ -7483,10 +7498,26 @@ struct bpf_link *bpf_program__attach_trace(struct bpf_program *prog)
> >         return (struct bpf_link *)link;
> >  }
> >
> > +struct bpf_link *bpf_program__attach_trace(struct bpf_program *prog)
> > +{
> > +       return bpf_program__attach_btf(prog);
> > +}
> > +
> > +struct bpf_link *bpf_program__attach_lsm(struct bpf_program *prog)
> > +{
> > +       return bpf_program__attach_btf(prog);
> > +}
> > +
> >  static struct bpf_link *attach_trace(const struct bpf_sec_def *sec,
> >                                      struct bpf_program *prog)
> >  {
> > -       return bpf_program__attach_trace(prog);
> > +       return bpf_program__attach_btf(prog);
> 
> well, no, it should call bpf_program__attach_trace()

You are right, the static helper should not be called directly.

Updated this and the LSM call to call their respective functions.

> 
> > +}
> > +
> > +static struct bpf_link *attach_lsm(const struct bpf_sec_def *sec,
> > +                                  struct bpf_program *prog)
> > +{
> > +       return bpf_program__attach_btf(prog);
> 
> and bpf_program__attach_lsm() here, don't shortcut invocation (you
> argued yourself above, what if something about LSM changes, why
> updating this invocation as well?)

Makes sense.

- KP

> 
> >  }
> >
> >  struct bpf_link *bpf_program__attach(struct bpf_program *prog)

[...]

> > +               bpf_program__is_lsm;
> >                 bpf_program__set_attach_target;
> > +               bpf_program__set_lsm;
> >  } LIBBPF_0.0.7;
> > --
> > 2.20.1
> >
