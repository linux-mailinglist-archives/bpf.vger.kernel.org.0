Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8419940FF0E
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 20:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239009AbhIQSOo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 14:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbhIQSOn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 14:14:43 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4124DC061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 11:13:21 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c10so20120464qko.11
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 11:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5qzz7bz1pnwZOYOXUX9ktz0GSlfwABzZt25R5ZZyb9Y=;
        b=cJeNEVNTRxAvT8+B9o1UNnTU4S39Yib81HjImxz99g3sJLC2SXrrOskB2JcRNzbwMe
         flfemueJq4kTv2qcB4x+P4Jw5y1sQnZUwaxnLTY4d9faE1GYOamlQUT/dnQDSpS53g2T
         tmJKpDli8/CgbIQJh6lYCc0dYgLcKAq2RPuFyQJoH3NTbMPovbKSZvxm2XyohsRZd1jD
         xcssX/n8Iwtk62V3v6v9y0pyrZd6+EB0nxOBaoO1oQTsVf76qkqV7zE7bS5BECMPxrGh
         uDBHIA51SoXMJqkgazp0FMkOkCGTgfw4TT1mTfPsW4VwDmRQ57tH7vDbSfXebuSwKDA2
         cmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5qzz7bz1pnwZOYOXUX9ktz0GSlfwABzZt25R5ZZyb9Y=;
        b=aAOj0vJ2A9RC/RSPwkwWcd9eOpJnas5aQy2dKiWOV1dQ0TdzM1lJXBQe8kFujWXJ9A
         rVNcxLe/p4l16B9e7gLF8Fx6GpWzlZkvJtRK333tq0fN2Qet0jM2n91+Pju4TwgWdMME
         ocGcPEKALR1Jtl0liI533wxw+IGdsspwgRcF7hDniTfcV8iyUT2zPlYktte43c15Z8WP
         UiEQFfByPkaN+5kS4mB8Am6lOd/4ywC/VA3fw2s82vFnO1i2RQeQZysrlSvDR005RyRe
         N7613Qm9Dk493dNUovROZ1ugIby6AOoAashUcUcKSY1C+RIAYxphJXy93b50N0Z2p22B
         PUmg==
X-Gm-Message-State: AOAM530rWM2/1Mq29zWnURIip1Rkhmu0M0N2Nmg0N0CH9b7TAAov1Q+8
        Hn01/oInOzg8OMZok3kDbw3+zU1HX/qM2MQkWFI=
X-Google-Smtp-Source: ABdhPJwuJ6bpsIYfT6og0pCHVQg5rfjjWupxt16VFJNkNbbgFtqivvP1ibpJ9acTXNfNAeWGRW73z6k05AN3R8eKatY=
X-Received: by 2002:a05:6902:724:: with SMTP id l4mr13834383ybt.433.1631902400338;
 Fri, 17 Sep 2021 11:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210917061020.821711-1-andrii@kernel.org> <20210917061020.821711-9-andrii@kernel.org>
 <YUTP20fF5wx0LbxQ@google.com>
In-Reply-To: <YUTP20fF5wx0LbxQ@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Sep 2021 11:13:09 -0700
Message-ID: <CAEf4BzYV1YpYojN4STU=wB9G19n_JdXoMsxFeSkM43GeS6ATMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 8/9] libbpf: add opt-in strict BPF program
 section name handling logic
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 17, 2021 at 10:26 AM <sdf@google.com> wrote:
>
> On 09/16, Andrii Nakryiko wrote:
> > Implement strict ELF section name handling for BPF programs. It utilize=
s
> > `libbpf_set_strict_mode()` framework and adds new flag:
> > LIBBPF_STRICT_SEC_NAME.
>
> > If this flag is set, libbpf will enforce exact section name matching fo=
r
> > a lot of program types that previously allowed just partial prefix
> > match. E.g., if previously SEC("xdp_whatever_i_want") was allowed, now
> > in strict mode only SEC("xdp") will be accepted, which makes SEC("")
> > definitions cleaner and more structured. SEC() now won't be used as yet
> > another way to uniquely encode BPF program identifier (for that
> > C function name is better and is guaranteed to be unique within
> > bpf_object). Now SEC() is strictly BPF program type and, depending on
> > program type, extra load/attach parameter specification.
>
> > Libbpf completely supports multiple BPF programs in the same ELF
> > section, so multiple BPF programs of the same type/specification easily
> > co-exist together within the same bpf_object scope.
>
> > Additionally, a new (for now internal) convention is introduced: sectio=
n
> > name that can be a stand-alone exact BPF program type specificator, but
> > also could have extra parameters after '/' delimiter. An example of suc=
h
> > section is "struct_ops", which can be specified by itself, but also
> > allows to specify the intended operation to be attached to, e.g.,
> > "struct_ops/dctcp_init". Note, that "struct_ops_some_op" is not allowed=
.
> > Such section definition is specified as "struct_ops+".
>
> > This change is part of libbpf 1.0 effort ([0], [1]).
>
> >    [0] Closes: https://github.com/libbpf/libbpf/issues/271
> >    [1]
> > https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0#stricter=
-and-more-uniform-bpf-program-section-name-sec-handling
>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >   tools/lib/bpf/libbpf.c        | 135 ++++++++++++++++++++++-----------=
-
> >   tools/lib/bpf/libbpf_legacy.h |   9 +++
> >   2 files changed, 98 insertions(+), 46 deletions(-)
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 56082865ceff..f0846f609e26 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -232,6 +232,7 @@ enum sec_def_flags {
> >       SEC_ATTACHABLE_OPT =3D SEC_ATTACHABLE | SEC_EXP_ATTACH_OPT,
> >       SEC_ATTACH_BTF =3D 4,
> >       SEC_SLEEPABLE =3D 8,
> > +     SEC_SLOPPY_PFX =3D 16, /* allow non-strict prefix matching */
> >   };
>
> >   struct bpf_sec_def {
> > @@ -7976,15 +7977,15 @@ static struct bpf_link *attach_lsm(const struct
> > bpf_program *prog, long cookie);
> >   static struct bpf_link *attach_iter(const struct bpf_program *prog, l=
ong
> > cookie);
>
> >   static const struct bpf_sec_def section_defs[] =3D {
> > -     SEC_DEF("socket",               SOCKET_FILTER, 0, SEC_NONE),
> > -     SEC_DEF("sk_reuseport/migrate", SK_REUSEPORT,
> > BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE),
> > -     SEC_DEF("sk_reuseport",         SK_REUSEPORT, BPF_SK_REUSEPORT_SE=
LECT,
> > SEC_ATTACHABLE),
> > +     SEC_DEF("socket",               SOCKET_FILTER, 0, SEC_SLOPPY_PFX)=
,
> > +     SEC_DEF("sk_reuseport/migrate", SK_REUSEPORT,
> > BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> > +     SEC_DEF("sk_reuseport",         SK_REUSEPORT, BPF_SK_REUSEPORT_SE=
LECT,
> > SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> >       SEC_DEF("kprobe/",              KPROBE, 0, SEC_NONE, attach_kprob=
e),
> >       SEC_DEF("uprobe/",              KPROBE, 0, SEC_NONE),
> >       SEC_DEF("kretprobe/",           KPROBE, 0, SEC_NONE, attach_kprob=
e),
> >       SEC_DEF("uretprobe/",           KPROBE, 0, SEC_NONE),
> > -     SEC_DEF("classifier",           SCHED_CLS, 0, SEC_NONE),
> > -     SEC_DEF("action",               SCHED_ACT, 0, SEC_NONE),
> > +     SEC_DEF("classifier",           SCHED_CLS, 0, SEC_SLOPPY_PFX),
> > +     SEC_DEF("action",               SCHED_ACT, 0, SEC_SLOPPY_PFX),
> >       SEC_DEF("tracepoint/",          TRACEPOINT, 0, SEC_NONE, attach_t=
p),
> >       SEC_DEF("tp/",                  TRACEPOINT, 0, SEC_NONE, attach_t=
p),
> >       SEC_DEF("raw_tracepoint/",      RAW_TRACEPOINT, 0, SEC_NONE, atta=
ch_raw_tp),
> > @@ -8003,44 +8004,44 @@ static const struct bpf_sec_def section_defs[] =
=3D {
> >       SEC_DEF("syscall",              SYSCALL, 0, SEC_SLEEPABLE),
> >       SEC_DEF("xdp_devmap/",          XDP, BPF_XDP_DEVMAP, SEC_ATTACHAB=
LE),
> >       SEC_DEF("xdp_cpumap/",          XDP, BPF_XDP_CPUMAP, SEC_ATTACHAB=
LE),
> > -     SEC_DEF("xdp",                  XDP, BPF_XDP, SEC_ATTACHABLE_OPT)=
,
> > -     SEC_DEF("perf_event",           PERF_EVENT, 0, SEC_NONE),
> > -     SEC_DEF("lwt_in",               LWT_IN, 0, SEC_NONE),
> > -     SEC_DEF("lwt_out",              LWT_OUT, 0, SEC_NONE),
> > -     SEC_DEF("lwt_xmit",             LWT_XMIT, 0, SEC_NONE),
> > -     SEC_DEF("lwt_seg6local",        LWT_SEG6LOCAL, 0, SEC_NONE),
> > -     SEC_DEF("cgroup_skb/ingress",   CGROUP_SKB, BPF_CGROUP_INET_INGRE=
SS,
> > SEC_ATTACHABLE_OPT),
> > -     SEC_DEF("cgroup_skb/egress",    CGROUP_SKB, BPF_CGROUP_INET_EGRES=
S,
> > SEC_ATTACHABLE_OPT),
> > -     SEC_DEF("cgroup/skb",           CGROUP_SKB, 0, SEC_NONE),
> > -     SEC_DEF("cgroup/sock_create",   CGROUP_SOCK, BPF_CGROUP_INET_SOCK=
_CREATE,
> > SEC_ATTACHABLE),
> > -     SEC_DEF("cgroup/sock_release",  CGROUP_SOCK,
> > BPF_CGROUP_INET_SOCK_RELEASE, SEC_ATTACHABLE),
> > -     SEC_DEF("cgroup/sock",          CGROUP_SOCK, BPF_CGROUP_INET_SOCK=
_CREATE,
> > SEC_ATTACHABLE_OPT),
> > -     SEC_DEF("cgroup/post_bind4",    CGROUP_SOCK, BPF_CGROUP_INET4_POS=
T_BIND,
> > SEC_ATTACHABLE),
> > -     SEC_DEF("cgroup/post_bind6",    CGROUP_SOCK, BPF_CGROUP_INET6_POS=
T_BIND,
> > SEC_ATTACHABLE),
> > -     SEC_DEF("cgroup/dev",           CGROUP_DEVICE, BPF_CGROUP_DEVICE,
> > SEC_ATTACHABLE_OPT),
> > -     SEC_DEF("sockops",              SOCK_OPS, BPF_CGROUP_SOCK_OPS, SE=
C_ATTACHABLE_OPT),
> > -     SEC_DEF("sk_skb/stream_parser", SK_SKB, BPF_SK_SKB_STREAM_PARSER,
> > SEC_ATTACHABLE_OPT),
> > -     SEC_DEF("sk_skb/stream_verdict",SK_SKB, BPF_SK_SKB_STREAM_VERDICT=
,
> > SEC_ATTACHABLE_OPT),
> > -     SEC_DEF("sk_skb",               SK_SKB, 0, SEC_NONE),
> > -     SEC_DEF("sk_msg",               SK_MSG, BPF_SK_MSG_VERDICT, SEC_A=
TTACHABLE_OPT),
> > -     SEC_DEF("lirc_mode2",           LIRC_MODE2, BPF_LIRC_MODE2, SEC_A=
TTACHABLE_OPT),
> > -     SEC_DEF("flow_dissector",       FLOW_DISSECTOR, BPF_FLOW_DISSECTO=
R,
> > SEC_ATTACHABLE_OPT),
> > -     SEC_DEF("cgroup/bind4",         CGROUP_SOCK_ADDR, BPF_CGROUP_INET=
4_BIND,
> > SEC_ATTACHABLE),
> > -     SEC_DEF("cgroup/bind6",         CGROUP_SOCK_ADDR, BPF_CGROUP_INET=
6_BIND,
> > SEC_ATTACHABLE),
> > -     SEC_DEF("cgroup/connect4",      CGROUP_SOCK_ADDR, BPF_CGROUP_INET=
4_CONNECT,
> > SEC_ATTACHABLE),
> > -     SEC_DEF("cgroup/connect6",      CGROUP_SOCK_ADDR, BPF_CGROUP_INET=
6_CONNECT,
> > SEC_ATTACHABLE),
> > -     SEC_DEF("cgroup/sendmsg4",      CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4=
_SENDMSG,
> > SEC_ATTACHABLE),
> > -     SEC_DEF("cgroup/sendmsg6",      CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6=
_SENDMSG,
> > SEC_ATTACHABLE),
> > -     SEC_DEF("cgroup/recvmsg4",      CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4=
_RECVMSG,
> > SEC_ATTACHABLE),
> > -     SEC_DEF("cgroup/recvmsg6",      CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6=
_RECVMSG,
> > SEC_ATTACHABLE),
> > -     SEC_DEF("cgroup/getpeername4",  CGROUP_SOCK_ADDR,
> > BPF_CGROUP_INET4_GETPEERNAME, SEC_ATTACHABLE),
> > -     SEC_DEF("cgroup/getpeername6",  CGROUP_SOCK_ADDR,
> > BPF_CGROUP_INET6_GETPEERNAME, SEC_ATTACHABLE),
> > -     SEC_DEF("cgroup/getsockname4",  CGROUP_SOCK_ADDR,
> > BPF_CGROUP_INET4_GETSOCKNAME, SEC_ATTACHABLE),
> > -     SEC_DEF("cgroup/getsockname6",  CGROUP_SOCK_ADDR,
> > BPF_CGROUP_INET6_GETSOCKNAME, SEC_ATTACHABLE),
> > -     SEC_DEF("cgroup/sysctl",        CGROUP_SYSCTL, BPF_CGROUP_SYSCTL,
> > SEC_ATTACHABLE),
> > -     SEC_DEF("cgroup/getsockopt",    CGROUP_SOCKOPT, BPF_CGROUP_GETSOC=
KOPT,
> > SEC_ATTACHABLE),
> > -     SEC_DEF("cgroup/setsockopt",    CGROUP_SOCKOPT, BPF_CGROUP_SETSOC=
KOPT,
> > SEC_ATTACHABLE),
> > -     SEC_DEF("struct_ops",           STRUCT_OPS, 0, SEC_NONE),
> > +     SEC_DEF("xdp",                  XDP, BPF_XDP, SEC_ATTACHABLE_OPT =
| SEC_SLOPPY_PFX),
> > +     SEC_DEF("perf_event",           PERF_EVENT, 0, SEC_SLOPPY_PFX),
> > +     SEC_DEF("lwt_in",               LWT_IN, 0, SEC_SLOPPY_PFX),
> > +     SEC_DEF("lwt_out",              LWT_OUT, 0, SEC_SLOPPY_PFX),
> > +     SEC_DEF("lwt_xmit",             LWT_XMIT, 0, SEC_SLOPPY_PFX),
> > +     SEC_DEF("lwt_seg6local",        LWT_SEG6LOCAL, 0, SEC_SLOPPY_PFX)=
,
> > +     SEC_DEF("cgroup_skb/ingress",   CGROUP_SKB, BPF_CGROUP_INET_INGRE=
SS,
> > SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup_skb/egress",    CGROUP_SKB, BPF_CGROUP_INET_EGRES=
S,
> > SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup/skb",           CGROUP_SKB, 0, SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup/sock_create",   CGROUP_SOCK, BPF_CGROUP_INET_SOCK=
_CREATE,
> > SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup/sock_release",  CGROUP_SOCK,
> > BPF_CGROUP_INET_SOCK_RELEASE, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup/sock",          CGROUP_SOCK, BPF_CGROUP_INET_SOCK=
_CREATE,
> > SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup/post_bind4",    CGROUP_SOCK, BPF_CGROUP_INET4_POS=
T_BIND,
> > SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup/post_bind6",    CGROUP_SOCK, BPF_CGROUP_INET6_POS=
T_BIND,
> > SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup/dev",           CGROUP_DEVICE, BPF_CGROUP_DEVICE,
> > SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
> > +     SEC_DEF("sockops",              SOCK_OPS, BPF_CGROUP_SOCK_OPS, SE=
C_ATTACHABLE_OPT |
> > SEC_SLOPPY_PFX),
> > +     SEC_DEF("sk_skb/stream_parser", SK_SKB, BPF_SK_SKB_STREAM_PARSER,
> > SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
> > +     SEC_DEF("sk_skb/stream_verdict",SK_SKB, BPF_SK_SKB_STREAM_VERDICT=
,
> > SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
> > +     SEC_DEF("sk_skb",               SK_SKB, 0, SEC_SLOPPY_PFX),
> > +     SEC_DEF("sk_msg",               SK_MSG, BPF_SK_MSG_VERDICT, SEC_A=
TTACHABLE_OPT |
> > SEC_SLOPPY_PFX),
> > +     SEC_DEF("lirc_mode2",           LIRC_MODE2, BPF_LIRC_MODE2, SEC_A=
TTACHABLE_OPT |
> > SEC_SLOPPY_PFX),
> > +     SEC_DEF("flow_dissector",       FLOW_DISSECTOR, BPF_FLOW_DISSECTO=
R,
> > SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup/bind4",         CGROUP_SOCK_ADDR, BPF_CGROUP_INET=
4_BIND,
> > SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup/bind6",         CGROUP_SOCK_ADDR, BPF_CGROUP_INET=
6_BIND,
> > SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup/connect4",      CGROUP_SOCK_ADDR, BPF_CGROUP_INET=
4_CONNECT,
> > SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup/connect6",      CGROUP_SOCK_ADDR, BPF_CGROUP_INET=
6_CONNECT,
> > SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup/sendmsg4",      CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4=
_SENDMSG,
> > SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup/sendmsg6",      CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6=
_SENDMSG,
> > SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup/recvmsg4",      CGROUP_SOCK_ADDR, BPF_CGROUP_UDP4=
_RECVMSG,
> > SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup/recvmsg6",      CGROUP_SOCK_ADDR, BPF_CGROUP_UDP6=
_RECVMSG,
> > SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup/getpeername4",  CGROUP_SOCK_ADDR,
> > BPF_CGROUP_INET4_GETPEERNAME, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup/getpeername6",  CGROUP_SOCK_ADDR,
> > BPF_CGROUP_INET6_GETPEERNAME, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup/getsockname4",  CGROUP_SOCK_ADDR,
> > BPF_CGROUP_INET4_GETSOCKNAME, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup/getsockname6",  CGROUP_SOCK_ADDR,
> > BPF_CGROUP_INET6_GETSOCKNAME, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup/sysctl",        CGROUP_SYSCTL, BPF_CGROUP_SYSCTL,
> > SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup/getsockopt",    CGROUP_SOCKOPT, BPF_CGROUP_GETSOC=
KOPT,
> > SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> > +     SEC_DEF("cgroup/setsockopt",    CGROUP_SOCKOPT, BPF_CGROUP_SETSOC=
KOPT,
> > SEC_ATTACHABLE | SEC_SLOPPY_PFX),
> > +     SEC_DEF("struct_ops+",          STRUCT_OPS, 0, SEC_NONE),
> >       SEC_DEF("sk_lookup/",           SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATT=
ACHABLE),
> >   };
>
> > @@ -8048,11 +8049,53 @@ static const struct bpf_sec_def section_defs[] =
=3D {
>
> >   static const struct bpf_sec_def *find_sec_def(const char *sec_name)
> >   {
> > -     int i, n =3D ARRAY_SIZE(section_defs);
> > +     const struct bpf_sec_def *sec_def;
> > +     enum sec_def_flags sec_flags;
> > +     int i, n =3D ARRAY_SIZE(section_defs), len;
> > +     bool strict =3D libbpf_mode & LIBBPF_STRICT_SEC_NAME;
>
> >       for (i =3D 0; i < n; i++) {
> > -             if (str_has_pfx(sec_name, section_defs[i].sec))
> > -                     return &section_defs[i];
> > +             sec_def =3D &section_defs[i];
> > +             sec_flags =3D sec_def->cookie;
> > +             len =3D strlen(sec_def->sec);
> > +
> > +             /* "type/" always has to have proper SEC("type/extras") f=
orm */
> > +             if (sec_def->sec[len - 1] =3D=3D '/') {
> > +                     if (str_has_pfx(sec_name, sec_def->sec))
> > +                             return sec_def;
> > +                     continue;
> > +             }
> > +
> > +             /* "type+" means it can be either exact SEC("type") or
> > +              * well-formed SEC("type/extras") with proper '/' separat=
or
> > +              */
> > +             if (sec_def->sec[len - 1] =3D=3D '+') {
> > +                     len--;
> > +                     /* not even a prefix */
> > +                     if (strncmp(sec_name, sec_def->sec, len) !=3D 0)
> > +                             continue;
> > +                     /* exact match or has '/' separator */
> > +                     if (sec_name[len] =3D=3D '\0' || sec_name[len] =
=3D=3D '/')
> > +                             return sec_def;
> > +                     continue;
> > +             }
> > +
> > +             /* SEC_SLOPPY_PFX definitions are allowed to be just pref=
ix
> > +              * matches, unless strict section name mode
> > +              * (LIBBPF_STRICT_SEC_NAME) is enabled, in which case the
> > +              * match has to be exact.
> > +              */
> > +             if ((sec_flags & SEC_SLOPPY_PFX) && !strict)  {
> > +                     if (str_has_pfx(sec_name, sec_def->sec))
> > +                             return sec_def;
> > +                     continue;
> > +             }
> > +
> > +             /* Definitions not marked SEC_SLOPPY_PFX (e.g.,
> > +              * SEC("syscall")) are exact matches in both modes.
> > +              */
> > +             if (strcmp(sec_name, sec_def->sec) =3D=3D 0)
> > +                     return sec_def;
> >       }
> >       return NULL;
> >   }
> > diff --git a/tools/lib/bpf/libbpf_legacy.h b/tools/lib/bpf/libbpf_legac=
y.h
> > index df0d03dcffab..74e6f860f703 100644
> > --- a/tools/lib/bpf/libbpf_legacy.h
> > +++ b/tools/lib/bpf/libbpf_legacy.h
> > @@ -46,6 +46,15 @@ enum libbpf_strict_mode {
> >        */
> >       LIBBPF_STRICT_DIRECT_ERRS =3D 0x02,
>
> > +     /*
> > +      * Enforce strict BPF program section (SEC()) names.
> > +      * E.g., while prefiously SEC("xdp_whatever") or SEC("perf_event_=
blah")
> > were
> > +      * allowed, with LIBBPF_STRICT_SEC_PREFIX this will become
> > +      * unrecognized by libbpf and would have to be just SEC("xdp") an=
d
> > +      * SEC("xdp") and SEC("perf_event").
> > +      */
> > +     LIBBPF_STRICT_SEC_NAME =3D 0x04,
>
> To clarify: I'm assuming, as discussed, we'll still support that old,
> non-conforming naming in libbpf 1.0, right? It just won't be enabled
> by default.

No, we won't. All those opt-in strict flags will be turned on
permanently in libbpf 1.0. But I'm adding an ability to provide custom
callbacks to handle whatever (reasonable) BPF program section names.
So if someone has a real important case needing custom handling, it's
not a big problem to implement that logic on their own. If someone is
just resisting making their code conforming, well... Stay on the old
fixed version, write a callback, or just do the mechanical rename, how
hard can that be? We are dropping bpf_program__find_program_by_title()
in libbpf 1.0, that API is meaningless with multiple programs per
section, so you'd have to update your logic to either skeleton or
bpf_program__find_program_by_name() anyways.

>
> Btw, forgot to update you, I've enabled LIBBPF_STRICT_DIRECT_ERRS and
> LIBBPF_STRICT_CLEAN_PTRS and everything seems to be working fine =F0=9F=
=A4=9E

Great! The problem is that you would see the difference only when
actual runtime failure happens. So I'd still recommend auditing the
code, if possible.
