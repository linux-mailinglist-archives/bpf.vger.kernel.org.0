Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65661BC859
	for <lists+bpf@lfdr.de>; Tue, 28 Apr 2020 20:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbgD1Sbs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 14:31:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36969 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729719AbgD1Sbr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Apr 2020 14:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588098705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k2r2nHjLmGfNXD/LczZ0iHarWiphaosQioLS/Vz6VWs=;
        b=BdvuPgICO+oqqqDmoNC11uBgbYjtFLgUO/HEKizj3X2mY4Xgxp7Ue0UtMAt0uuIw2Hjq+Y
        lX4qDF1h4UEcvrAW8ZZD0Szl0Z6UDuhAjuCGEMhSnVK9onnVDFaDXl5ot1OJdLD0W6Ps89
        mvtAkkEVbwgsijitN8WHJlSnewE9yoA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-c_QnVC8IN_eb5wTmDd3JIw-1; Tue, 28 Apr 2020 14:31:41 -0400
X-MC-Unique: c_QnVC8IN_eb5wTmDd3JIw-1
Received: by mail-lj1-f198.google.com with SMTP id z1so3782116ljk.9
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2020 11:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=k2r2nHjLmGfNXD/LczZ0iHarWiphaosQioLS/Vz6VWs=;
        b=se/PIjkbBJ7hailx1TlI9n77yhgRh05OSQAXdnVTyXc2Lv7i0ar/jDS46b8IP0DQ0R
         CK3DxCwqzU6bkPbFoNPK9eLppP5+XgapH9zojCHGKeSY1NgJc4JTQhaQrSoH0yUKmCVq
         e4SWGP2Vd/kC/2DLUrglfcUmIstChhJGOzKNWpvgkv4A3tkrdis/PmFsc2no0Ut4IoQb
         HwpJ0TpLM/FJ+86qxTwi1V5TKNqEHgmELvWrB/Yt58pLuWZ5qC4db5fSf05zEXZPasj9
         mtdVk3tRLb7SGMs7M2QeuElyrSZFSlbyXcqsgi7Nzgh8qIiuragRDoQgm65GvR2hv6OC
         Z9Tw==
X-Gm-Message-State: AGi0PuY/dDQgmE4M5+3uPzKWN4mAeAdyqOD0YpY+lm0lH/lKJh9MpQQh
        swZE3R5fkbErSR+8Bzeh+R/at+9FNpGHvio/okgx1i9gPifAlWup3l0pQsHGg1iNSFrHWwadx5e
        oWuvf4mpDRos+
X-Received: by 2002:a2e:98c4:: with SMTP id s4mr18337208ljj.97.1588098698006;
        Tue, 28 Apr 2020 11:31:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypJEZmPIZYdVxiXiIV1g1z8hyevnlrHXRrjhb35wCkqJmNR5q97rgUzomwebpQY40acDcQ0K9Q==
X-Received: by 2002:a2e:98c4:: with SMTP id s4mr18337187ljj.97.1588098697647;
        Tue, 28 Apr 2020 11:31:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d23sm14692884ljg.90.2020.04.28.11.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 11:31:36 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 87A941814FF; Tue, 28 Apr 2020 20:31:35 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 04/10] bpf: add support for BPF_OBJ_GET_INFO_BY_FD for bpf_link
In-Reply-To: <CAEf4BzabqYMRDzn0ztHQithWJ56o_CWZCWotnkyhJ6D7nuNG1Q@mail.gmail.com>
References: <20200428054944.4015462-1-andriin@fb.com> <20200428054944.4015462-5-andriin@fb.com> <87mu6wvt6t.fsf@toke.dk> <CAEf4BzabqYMRDzn0ztHQithWJ56o_CWZCWotnkyhJ6D7nuNG1Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 28 Apr 2020 20:31:35 +0200
Message-ID: <87v9ljv4vs.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Apr 28, 2020 at 2:46 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Andrii Nakryiko <andriin@fb.com> writes:
>>
>> > Add ability to fetch bpf_link details through BPF_OBJ_GET_INFO_BY_FD c=
ommand.
>> > Also enhance show_fdinfo to potentially include bpf_link type-specific
>> > information (similarly to obj_info).
>> >
>> > Also introduce enum bpf_link_type stored in bpf_link itself and expose=
 it in
>> > UAPI. bpf_link_tracing also now will store and return bpf_attach_type.
>> >
>> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
>> > ---
>> >  include/linux/bpf-cgroup.h     |   2 -
>> >  include/linux/bpf.h            |  10 +-
>> >  include/linux/bpf_types.h      |   6 ++
>> >  include/uapi/linux/bpf.h       |  28 ++++++
>> >  kernel/bpf/btf.c               |   2 +
>> >  kernel/bpf/cgroup.c            |  45 ++++++++-
>> >  kernel/bpf/syscall.c           | 164 +++++++++++++++++++++++++++++----
>> >  kernel/bpf/verifier.c          |   2 +
>> >  tools/include/uapi/linux/bpf.h |  31 +++++++
>> >  9 files changed, 266 insertions(+), 24 deletions(-)
>> >
>> > diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
>> > index d2d969669564..ab95824a1d99 100644
>> > --- a/include/linux/bpf-cgroup.h
>> > +++ b/include/linux/bpf-cgroup.h
>> > @@ -57,8 +57,6 @@ struct bpf_cgroup_link {
>> >       enum bpf_attach_type type;
>> >  };
>> >
>> > -extern const struct bpf_link_ops bpf_cgroup_link_lops;
>> > -
>> >  struct bpf_prog_list {
>> >       struct list_head node;
>> >       struct bpf_prog *prog;
>> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> > index 875d1f0af803..701c4387c711 100644
>> > --- a/include/linux/bpf.h
>> > +++ b/include/linux/bpf.h
>> > @@ -1026,9 +1026,11 @@ extern const struct file_operations bpf_prog_fo=
ps;
>> >       extern const struct bpf_verifier_ops _name ## _verifier_ops;
>> >  #define BPF_MAP_TYPE(_id, _ops) \
>> >       extern const struct bpf_map_ops _ops;
>> > +#define BPF_LINK_TYPE(_id, _name)
>> >  #include <linux/bpf_types.h>
>> >  #undef BPF_PROG_TYPE
>> >  #undef BPF_MAP_TYPE
>> > +#undef BPF_LINK_TYPE
>> >
>> >  extern const struct bpf_prog_ops bpf_offload_prog_ops;
>> >  extern const struct bpf_verifier_ops tc_cls_act_analyzer_ops;
>> > @@ -1086,6 +1088,7 @@ int bpf_prog_new_fd(struct bpf_prog *prog);
>> >  struct bpf_link {
>> >       atomic64_t refcnt;
>> >       u32 id;
>> > +     enum bpf_link_type type;
>> >       const struct bpf_link_ops *ops;
>> >       struct bpf_prog *prog;
>> >       struct work_struct work;
>> > @@ -1103,9 +1106,14 @@ struct bpf_link_ops {
>> >       void (*dealloc)(struct bpf_link *link);
>> >       int (*update_prog)(struct bpf_link *link, struct bpf_prog *new_p=
rog,
>> >                          struct bpf_prog *old_prog);
>> > +     void (*show_fdinfo)(const struct bpf_link *link, struct seq_file=
 *seq);
>> > +     int (*fill_link_info)(const struct bpf_link *link,
>> > +                           struct bpf_link_info *info,
>> > +                           const struct bpf_link_info *uinfo,
>> > +                           u32 info_len);
>> >  };
>> >
>> > -void bpf_link_init(struct bpf_link *link,
>> > +void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
>> >                  const struct bpf_link_ops *ops, struct bpf_prog *prog=
);
>> >  int bpf_link_prime(struct bpf_link *link, struct bpf_link_primer *pri=
mer);
>> >  int bpf_link_settle(struct bpf_link_primer *primer);
>> > diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
>> > index ba0c2d56f8a3..8345cdf553b8 100644
>> > --- a/include/linux/bpf_types.h
>> > +++ b/include/linux/bpf_types.h
>> > @@ -118,3 +118,9 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_STACK, stack_map_ops)
>> >  #if defined(CONFIG_BPF_JIT)
>> >  BPF_MAP_TYPE(BPF_MAP_TYPE_STRUCT_OPS, bpf_struct_ops_map_ops)
>> >  #endif
>> > +
>> > +BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
>> > +BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
>> > +#ifdef CONFIG_CGROUP_BPF
>> > +BPF_LINK_TYPE(BPF_LINK_TYPE_CGROUP, cgroup)
>> > +#endif
>> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> > index 7e6541fceade..0eccafae55bb 100644
>> > --- a/include/uapi/linux/bpf.h
>> > +++ b/include/uapi/linux/bpf.h
>> > @@ -222,6 +222,15 @@ enum bpf_attach_type {
>> >
>> >  #define MAX_BPF_ATTACH_TYPE __MAX_BPF_ATTACH_TYPE
>> >
>> > +enum bpf_link_type {
>> > +     BPF_LINK_TYPE_UNSPEC =3D 0,
>> > +     BPF_LINK_TYPE_RAW_TRACEPOINT =3D 1,
>> > +     BPF_LINK_TYPE_TRACING =3D 2,
>> > +     BPF_LINK_TYPE_CGROUP =3D 3,
>> > +
>> > +     MAX_BPF_LINK_TYPE,
>> > +};
>> > +
>> >  /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
>> >   *
>> >   * NONE(default): No further bpf programs allowed in the subtree.
>> > @@ -3612,6 +3621,25 @@ struct bpf_btf_info {
>> >       __u32 id;
>> >  } __attribute__((aligned(8)));
>> >
>> > +struct bpf_link_info {
>> > +     __u32 type;
>> > +     __u32 id;
>> > +     __u32 prog_id;
>> > +     union {
>> > +             struct {
>> > +                     __aligned_u64 tp_name; /* in/out: tp_name buffer=
 ptr */
>> > +                     __u32 tp_name_len;     /* in/out: tp_name buffer=
 len */
>> > +             } raw_tracepoint;
>> > +             struct {
>> > +                     __u32 attach_type;
>> > +             } tracing;
>>
>> On the RFC I asked whether we could get the attach target here as well.
>> You said you'd look into it; what happened to that? :)
>>
>
> Right, sorry, forgot to mention this. I did take a look, but tracing
> links are quite diverse, so I didn't see one clear way to structure
> such "target" information, so I'd say we should push it into a
> separate patch/discussion. E.g., fentry/fexit/fmod_exit are attached
> to kernel functions (how do we represent that), freplace are attached
> to another BPF program (this is a bit clearer how to represent, but
> how do we combine that with fentry/fexit info?). LSM is also attached
> to kernel function, but who knows, maybe we want slightly more
> extended semantics for it. Either way, I don't see one best way to
> structure this information and would want to avoid blocking on this
> for this series. Also bpf_link_info is extensible, so it's not a
> problem to extend it in follow up patches.
>
> Does it make sense?

Yup, fair enough, I can live with deferring this to a later series :)

-Toke

