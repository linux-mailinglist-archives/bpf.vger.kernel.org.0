Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B5C59EF7D
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 00:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiHWWxw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 18:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiHWWxv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 18:53:51 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DA28D3EE;
        Tue, 23 Aug 2022 15:53:49 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u6so14792286eda.12;
        Tue, 23 Aug 2022 15:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=xp1as+ZwL89RLaGZ5z5pRX0IjTfa8idSlDW2zlHuHi0=;
        b=NA37RZefX4IzQ+daAni3/oFcsl4upenAqYq9pCi9Zb7nyoJREn1KIWhv5lQ20mV/2Y
         r1dT6RRS9HBvk9Jvt+JifdLMmS0qzajO5ApiX0WUbJnUUeiV1wDDKXULIi1nvKp078ov
         kF7JsobxRh+rgd7hItGrsfYz4b1mP1iqDc0V52fD1Wst9YCBDXB69Nek3YhOfWjOVbb/
         PZO7zwndWZi5VrFu8W45YRtNjZIHXLqb+vi8dB7WzSi0y+rlz6r8bHe6Id9sBsMITIE6
         7r20bFna4gPTwU7a/CLvLyZ4skCw58M3ywcjT5P2SOKXNFawrW7KLo9X3eLw/teYPFWv
         Sy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=xp1as+ZwL89RLaGZ5z5pRX0IjTfa8idSlDW2zlHuHi0=;
        b=hIf8N9V0rDsPQ1juA8d3/zrYmjBMLwF1NTb+m0/CwA99rRpD57OBrXZ66Tj5zbylMx
         IWy7JRAtlmo9bCio9sr5HP14V+ZNCYzf0vV14Wt/1pEENT1gP5xaSxdqcsVLpNZ2tPLW
         NkmIbwGqaOPj492qL215MiU1MXgp2/acCOyw6+tWR1TUVliidDsXhLEZd54g0QxoXySr
         ZWZJHkf8Cpq5khZCcHI8YYOk5FehWC5AXEYFJf7cSkWjv1aj05ADxcRS9UnRnhWzBwTm
         zHlj8uSYj+elSHAHNgl4TmweJ0bWci6rDTb22IyYcZFpjQfhkB6FjCoBbBwq05V0IJmo
         IPcA==
X-Gm-Message-State: ACgBeo3MsLlDHl8VVOiOUNykPx+7opCWZSuzjzIXNAn9eo4eSDNKX7mt
        LjdcUGsE/vu26KpS3QEMiCAzpu69QEzu4Q+PIZc=
X-Google-Smtp-Source: AA6agR5p99Bsw3dhNjoE3vQ8m5HSaxwpif9aesl/KqvA1sCdtwCl27xpCOFMAmPgS3hwcv19OORUGdMJ9bDr722LoiU=
X-Received: by 2002:a05:6402:1704:b0:447:811f:1eef with SMTP id
 y4-20020a056402170400b00447811f1eefmr70604edu.14.1661295227316; Tue, 23 Aug
 2022 15:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220823132236.65122-1-donald.hunter@gmail.com>
In-Reply-To: <20220823132236.65122-1-donald.hunter@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 23 Aug 2022 15:53:36 -0700
Message-ID: <CAEf4BzaujwgDXm+05MuGr_ouAseGGFg50Cxb83hHeWHX7bCk6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Add table of BPF program types to docs
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        grantseltzer <grantseltzer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 23, 2022 at 9:56 AM Donald Hunter <donald.hunter@gmail.com> wro=
te:
>
> Extend the BPF program types documentation with a table of
> program types, attach points and ELF section names.
>
> The program_types.csv file is generated from tools/lib/bpf/libbpf.c
> and a script is included for regenerating the .csv file.
>
> I have not integrated the script into the doc build but if that
> is desirable then please suggest the preferred way to do so.
>
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---

It does seem cleaner to generate this .csv during docs build, instead
of having to manually regenerate it all the time? Should we also put
it under Documentation/bpf/libbpf/ as it's libbpf-specific? Having it
under libbpf subdir would also make it simpler to expose it in libbpf
docs at libbpf.readthedocs.io/

We can probably also establish some special comment format next to
SEC_DEF() to specify the format of those "extras", I think it would be
useful for users. WDYT?

CC'ing Grant as well, who worked on building libbpf docs.

>  Documentation/bpf/program_types.csv | 82 +++++++++++++++++++++++++++++
>  Documentation/bpf/programs.rst      | 15 ++++++
>  scripts/gen-bpf-progtypes.sh        | 21 ++++++++
>  3 files changed, 118 insertions(+)
>  create mode 100644 Documentation/bpf/program_types.csv
>  create mode 100755 scripts/gen-bpf-progtypes.sh
>
> diff --git a/Documentation/bpf/program_types.csv b/Documentation/bpf/prog=
ram_types.csv
> new file mode 100644
> index 000000000000..adec046b0bde
> --- /dev/null
> +++ b/Documentation/bpf/program_types.csv
> @@ -0,0 +1,82 @@
> +Program Type,Attach Type,ELF Section Name,Sleepable
> +``BPF_PROG_TYPE_SOCKET_FILTER``,,``socket``,
> +``BPF_PROG_TYPE_SK_REUSEPORT``,``BPF_SK_REUSEPORT_SELECT_OR_MIGRATE``,``=
sk_reuseport/migrate``,
> +``BPF_PROG_TYPE_SK_REUSEPORT``,``BPF_SK_REUSEPORT_SELECT``,``sk_reusepor=
t``,
> +``BPF_PROG_TYPE_KPROBE``,,``kprobe+``,
> +``BPF_PROG_TYPE_KPROBE``,,``uprobe+``,
> +``BPF_PROG_TYPE_KPROBE``,,``uprobe.s+``,Yes
> +``BPF_PROG_TYPE_KPROBE``,,``kretprobe+``,
> +``BPF_PROG_TYPE_KPROBE``,,``uretprobe+``,
> +``BPF_PROG_TYPE_KPROBE``,,``uretprobe.s+``,Yes
> +``BPF_PROG_TYPE_KPROBE``,``BPF_TRACE_KPROBE_MULTI``,``kprobe.multi+``,
> +``BPF_PROG_TYPE_KPROBE``,``BPF_TRACE_KPROBE_MULTI``,``kretprobe.multi+``=
,
> +``BPF_PROG_TYPE_KPROBE``,,``ksyscall+``,
> +``BPF_PROG_TYPE_KPROBE``,,``kretsyscall+``,
> +``BPF_PROG_TYPE_KPROBE``,,``usdt+``,
> +``BPF_PROG_TYPE_SCHED_CLS``,,``tc``,
> +``BPF_PROG_TYPE_SCHED_CLS``,,``classifier``,
> +``BPF_PROG_TYPE_SCHED_ACT``,,``action``,
> +``BPF_PROG_TYPE_TRACEPOINT``,,``tracepoint+``,
> +``BPF_PROG_TYPE_TRACEPOINT``,,``tp+``,
> +``BPF_PROG_TYPE_RAW_TRACEPOINT``,,``raw_tracepoint+``,
> +``BPF_PROG_TYPE_RAW_TRACEPOINT``,,``raw_tp+``,
> +``BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE``,,``raw_tracepoint.w+``,
> +``BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE``,,``raw_tp.w+``,
> +``BPF_PROG_TYPE_TRACING``,``BPF_TRACE_RAW_TP``,``tp_btf+``,
> +``BPF_PROG_TYPE_TRACING``,``BPF_TRACE_FENTRY``,``fentry+``,
> +``BPF_PROG_TYPE_TRACING``,``BPF_MODIFY_RETURN``,``fmod_ret+``,
> +``BPF_PROG_TYPE_TRACING``,``BPF_TRACE_FEXIT``,``fexit+``,
> +``BPF_PROG_TYPE_TRACING``,``BPF_TRACE_FENTRY``,``fentry.s+``,Yes
> +``BPF_PROG_TYPE_TRACING``,``BPF_MODIFY_RETURN``,``fmod_ret.s+``,Yes
> +``BPF_PROG_TYPE_TRACING``,``BPF_TRACE_FEXIT``,``fexit.s+``,Yes
> +``BPF_PROG_TYPE_EXT``,,``freplace+``,
> +``BPF_PROG_TYPE_LSM``,``BPF_LSM_MAC``,``lsm+``,
> +``BPF_PROG_TYPE_LSM``,``BPF_LSM_MAC``,``lsm.s+``,Yes
> +``BPF_PROG_TYPE_LSM``,``BPF_LSM_CGROUP``,``lsm_cgroup+``,
> +``BPF_PROG_TYPE_TRACING``,``BPF_TRACE_ITER``,``iter+``,
> +``BPF_PROG_TYPE_TRACING``,``BPF_TRACE_ITER``,``iter.s+``,Yes
> +``BPF_PROG_TYPE_SYSCALL``,,``syscall``,Yes
> +``BPF_PROG_TYPE_XDP``,``BPF_XDP_DEVMAP``,``xdp.frags/devmap``,
> +``BPF_PROG_TYPE_XDP``,``BPF_XDP_DEVMAP``,``xdp/devmap``,
> +``BPF_PROG_TYPE_XDP``,``BPF_XDP_CPUMAP``,``xdp.frags/cpumap``,
> +``BPF_PROG_TYPE_XDP``,``BPF_XDP_CPUMAP``,``xdp/cpumap``,
> +``BPF_PROG_TYPE_XDP``,``BPF_XDP``,``xdp.frags``,
> +``BPF_PROG_TYPE_XDP``,``BPF_XDP``,``xdp``,
> +``BPF_PROG_TYPE_PERF_EVENT``,,``perf_event``,
> +``BPF_PROG_TYPE_LWT_IN``,,``lwt_in``,
> +``BPF_PROG_TYPE_LWT_OUT``,,``lwt_out``,
> +``BPF_PROG_TYPE_LWT_XMIT``,,``lwt_xmit``,
> +``BPF_PROG_TYPE_LWT_SEG6LOCAL``,,``lwt_seg6local``,
> +``BPF_PROG_TYPE_SOCK_OPS``,``BPF_CGROUP_SOCK_OPS``,``sockops``,
> +``BPF_PROG_TYPE_SK_SKB``,``BPF_SK_SKB_STREAM_PARSER``,``sk_skb/stream_pa=
rser``,
> +``BPF_PROG_TYPE_SK_SKB``,``BPF_SK_SKB_STREAM_VERDICT``,``sk_skb/stream_v=
erdict``,
> +``BPF_PROG_TYPE_SK_SKB``,,``sk_skb``,
> +``BPF_PROG_TYPE_SK_MSG``,``BPF_SK_MSG_VERDICT``,``sk_msg``,
> +``BPF_PROG_TYPE_LIRC_MODE2``,``BPF_LIRC_MODE2``,``lirc_mode2``,
> +``BPF_PROG_TYPE_FLOW_DISSECTOR``,``BPF_FLOW_DISSECTOR``,``flow_dissector=
``,
> +``BPF_PROG_TYPE_CGROUP_SKB``,``BPF_CGROUP_INET_INGRESS``,``cgroup_skb/in=
gress``,
> +``BPF_PROG_TYPE_CGROUP_SKB``,``BPF_CGROUP_INET_EGRESS``,``cgroup_skb/egr=
ess``,
> +``BPF_PROG_TYPE_CGROUP_SKB``,,``cgroup/skb``,
> +``BPF_PROG_TYPE_CGROUP_SOCK``,``BPF_CGROUP_INET_SOCK_CREATE``,``cgroup/s=
ock_create``,
> +``BPF_PROG_TYPE_CGROUP_SOCK``,``BPF_CGROUP_INET_SOCK_RELEASE``,``cgroup/=
sock_release``,
> +``BPF_PROG_TYPE_CGROUP_SOCK``,``BPF_CGROUP_INET_SOCK_CREATE``,``cgroup/s=
ock``,
> +``BPF_PROG_TYPE_CGROUP_SOCK``,``BPF_CGROUP_INET4_POST_BIND``,``cgroup/po=
st_bind4``,
> +``BPF_PROG_TYPE_CGROUP_SOCK``,``BPF_CGROUP_INET6_POST_BIND``,``cgroup/po=
st_bind6``,
> +``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_INET4_BIND``,``cgroup/bi=
nd4``,
> +``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_INET6_BIND``,``cgroup/bi=
nd6``,
> +``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_INET4_CONNECT``,``cgroup=
/connect4``,
> +``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_INET6_CONNECT``,``cgroup=
/connect6``,
> +``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_UDP4_SENDMSG``,``cgroup/=
sendmsg4``,
> +``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_UDP6_SENDMSG``,``cgroup/=
sendmsg6``,
> +``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_UDP4_RECVMSG``,``cgroup/=
recvmsg4``,
> +``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_UDP6_RECVMSG``,``cgroup/=
recvmsg6``,
> +``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_INET4_GETPEERNAME``,``cg=
roup/getpeername4``,
> +``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_INET6_GETPEERNAME``,``cg=
roup/getpeername6``,
> +``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_INET4_GETSOCKNAME``,``cg=
roup/getsockname4``,
> +``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_INET6_GETSOCKNAME``,``cg=
roup/getsockname6``,
> +``BPF_PROG_TYPE_CGROUP_SYSCTL``,``BPF_CGROUP_SYSCTL``,``cgroup/sysctl``,
> +``BPF_PROG_TYPE_CGROUP_SOCKOPT``,``BPF_CGROUP_GETSOCKOPT``,``cgroup/gets=
ockopt``,
> +``BPF_PROG_TYPE_CGROUP_SOCKOPT``,``BPF_CGROUP_SETSOCKOPT``,``cgroup/sets=
ockopt``,
> +``BPF_PROG_TYPE_CGROUP_DEVICE``,``BPF_CGROUP_DEVICE``,``cgroup/dev``,
> +``BPF_PROG_TYPE_STRUCT_OPS``,,``struct_ops+``,
> +``BPF_PROG_TYPE_SK_LOOKUP``,``BPF_SK_LOOKUP``,``sk_lookup``,
> diff --git a/Documentation/bpf/programs.rst b/Documentation/bpf/programs.=
rst
> index 620eb667ac7a..71448fe0b955 100644
> --- a/Documentation/bpf/programs.rst
> +++ b/Documentation/bpf/programs.rst
> @@ -7,3 +7,18 @@ Program Types
>     :glob:
>
>     prog_*
> +
> +Program Types and libbpf
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The table below lists the program types, their attach types where releva=
nt and the ELF section
> +names supported by libbpf for them. The ELF section names follow these r=
ules:
> +
> +- ``type`` is an exact match, e.g. ``SEC("socket")``
> +- ``type+`` means it can be either exact ``SEC("type")`` or well-formed =
``SEC("type/extras")``
> +  with a =E2=80=98``/``=E2=80=99 separator, e.g. ``SEC("tracepoint/sysca=
lls/sys_enter_open")``
> +
> +.. csv-table:: Program Types and Their ELF Section Names
> +   :file: program_types.csv
> +   :widths: 40 30 20 10
> +   :header-rows: 1
> diff --git a/scripts/gen-bpf-progtypes.sh b/scripts/gen-bpf-progtypes.sh
> new file mode 100755
> index 000000000000..fb9650bd5c1b
> --- /dev/null
> +++ b/scripts/gen-bpf-progtypes.sh
> @@ -0,0 +1,21 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Copyright (C) Red Hat.
> +#
> +# Generate a .csv table of BPF program types
> +
> +if ! [ -d "tools/lib/bpf" -a -d "Documentation" ]; then
> +    echo "Run from top level of kernel tree"
> +    exit 1
> +fi
> +
> +awk -F'[",[:space:]]+' \
> +    'BEGIN { print "Program Type,Attach Type,ELF Section Name,Sleepable"=
 }
> +    /SEC_DEF\(\"/ && !/SEC_DEPRECATED/ {
> +    type =3D "``BPF_PROG_TYPE_" $4 "``"
> +    attach =3D index($5, "0") ? "" : "``" $5 "``";
> +    section =3D "``" $3 "``"
> +    sleepable =3D index($0, "SEC_SLEEPABLE") ? "Yes" : "";
> +    print type "," attach "," section "," sleepable }' \
> +tools/lib/bpf/libbpf.c > Documentation/bpf/program_types.csv
> --
> 2.35.1
>
