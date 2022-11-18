Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62602630829
	for <lists+bpf@lfdr.de>; Sat, 19 Nov 2022 01:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbiKSA5L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 19:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237714AbiKSA44 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 19:56:56 -0500
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CFD13C71E;
        Fri, 18 Nov 2022 15:55:40 -0800 (PST)
Received: by mail-qv1-f53.google.com with SMTP id c8so4400205qvn.10;
        Fri, 18 Nov 2022 15:55:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHVOM8ZcC+RXXR1+3G0T8DRs+enZvY6gtMzHZbxTHmw=;
        b=oEONeEVLG7tgPzdjp3J2YLg2gsA33beDR8qMl8Ta3NbfCaSTYKxrKcoH2bqWr2vry4
         89GIydGj26TydHGsr9mZsWYBNRaLow/fhWjVZdUA4bJhK0fyplN6YlBt/R7MvsPGDfNa
         ibtg+C1Rw1m64qdr0OuUQdzUWd6WfaisVShcRyqe1tpIcWpmtE8r1MtmSFbUOD+9llBM
         jXPuiBFJ+yWLQnmXz9pbru96UAT0F0VXMKOLHXD/0KD0uB8Hpoc9bJ0c64HuicUFHvEH
         XdJrGqVtKSGOajxQsyz6U/70vvad+lhnTlfJGFQ75yUiacQG/9vd/zGlL0cCmGLSMG0F
         483w==
X-Gm-Message-State: ANoB5pkUr8EaR1WIrtkCW0Cs5VujuDG3yNavu/zpQDxcMTJqTmj22q25
        zAp3KE4n0BuWrjbKcBY5YtU=
X-Google-Smtp-Source: AA0mqf5ucVGwk+Xqb8DlahZTWk/+gW9OqiExEU0/eGKgGTDALXO29fr/Mbwwct0R3Voyvex+nNd7eg==
X-Received: by 2002:ad4:4482:0:b0:4b1:9daa:b53e with SMTP id m2-20020ad44482000000b004b19daab53emr8954948qvt.79.1668815723253;
        Fri, 18 Nov 2022 15:55:23 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:cf15])
        by smtp.gmail.com with ESMTPSA id v10-20020a05620a440a00b006fab416015csm3456854qkp.25.2022.11.18.15.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 15:55:22 -0800 (PST)
Date:   Fri, 18 Nov 2022 17:55:26 -0600
From:   David Vernet <void@manifault.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH bpf-next v5] docs/bpf: Add table of BPF program types to
 libbpf docs
Message-ID: <Y3gbbqwwL7GUydzb@maniforge.lan>
References: <20221118152859.69645-1-donald.hunter@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118152859.69645-1-donald.hunter@gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 03:28:59PM +0000, Donald Hunter wrote:
> Extend the libbpf documentation with a table of program types,
> attach points and ELF section names.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---

This looks great, thanks for writing it up. Just left one suggestion
below.

Acked-by: David Vernet <void@manifault.com>

>  Documentation/bpf/libbpf/index.rst         |   3 +
>  Documentation/bpf/libbpf/program_types.rst | 203 +++++++++++++++++++++
>  Documentation/bpf/programs.rst             |   3 +
>  3 files changed, 209 insertions(+)
>  create mode 100644 Documentation/bpf/libbpf/program_types.rst
> 
> diff --git a/Documentation/bpf/libbpf/index.rst b/Documentation/bpf/libbpf/index.rst
> index 3722537d1384..f9b3b252e28f 100644
> --- a/Documentation/bpf/libbpf/index.rst
> +++ b/Documentation/bpf/libbpf/index.rst
> @@ -1,5 +1,7 @@
>  .. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>  
> +.. _libbpf:
> +
>  libbpf
>  ======
>  
> @@ -7,6 +9,7 @@ libbpf
>     :maxdepth: 1
>  
>     API Documentation <https://libbpf.readthedocs.io/en/latest/api.html>
> +   program_types
>     libbpf_naming_convention
>     libbpf_build
>  
> diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/bpf/libbpf/program_types.rst
> new file mode 100644
> index 000000000000..544e1597ff5f
> --- /dev/null
> +++ b/Documentation/bpf/libbpf/program_types.rst
> @@ -0,0 +1,203 @@
> +.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +
> +.. _program_types_and_elf:
> +
> +Program Types and ELF Sections
> +==============================
> +
> +The table below lists the program types, their attach types where relevant and the ELF section
> +names supported by libbpf for them. The ELF section names follow these rules:
> +
> +- ``type`` is an exact match, e.g. ``SEC("socket")``
> +- ``type+`` means it can be either exact ``SEC("type")`` or well-formed ``SEC("type/extras")``
> +  with a '``/``' separator between ``type`` and ``extras``.
> +
> +When ``extras`` are specified, they provide details of how to auto-attach the BPF program.  The
> +format of ``extras`` depends on the program type, e.g. ``SEC("tracepoint/<category>/<name>")``
> +for tracepoints or ``SEC("usdt/<path>:<provider>:<name>")`` for USDT probes. The extras are
> +described in more detail in the footnotes.
> +
> +
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| Program Type                              | Attach Type                            | ELF Section Name                 | Sleepable |
> ++===========================================+========================================+==================================+===========+
> +| ``BPF_PROG_TYPE_CGROUP_DEVICE``           | ``BPF_CGROUP_DEVICE``                  | ``cgroup/dev``                   |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_CGROUP_SKB``              |                                        | ``cgroup/skb``                   |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET_EGRESS``             | ``cgroup_skb/egress``            |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET_INGRESS``            | ``cgroup_skb/ingress``           |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_CGROUP_SOCKOPT``          | ``BPF_CGROUP_GETSOCKOPT``              | ``cgroup/getsockopt``            |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_SETSOCKOPT``              | ``cgroup/setsockopt``            |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``        | ``BPF_CGROUP_INET4_BIND``              | ``cgroup/bind4``                 |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET4_CONNECT``           | ``cgroup/connect4``              |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET4_GETPEERNAME``       | ``cgroup/getpeername4``          |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET4_GETSOCKNAME``       | ``cgroup/getsockname4``          |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET6_BIND``              | ``cgroup/bind6``                 |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET6_CONNECT``           | ``cgroup/connect6``              |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET6_GETPEERNAME``       | ``cgroup/getpeername6``          |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET6_GETSOCKNAME``       | ``cgroup/getsockname6``          |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_UDP4_RECVMSG``            | ``cgroup/recvmsg4``              |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_UDP4_SENDMSG``            | ``cgroup/sendmsg4``              |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_UDP6_RECVMSG``            | ``cgroup/recvmsg6``              |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_UDP6_SENDMSG``            | ``cgroup/sendmsg6``              |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_CGROUP_SOCK``             | ``BPF_CGROUP_INET4_POST_BIND``         | ``cgroup/post_bind4``            |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET6_POST_BIND``         | ``cgroup/post_bind6``            |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET_SOCK_CREATE``        | ``cgroup/sock_create``           |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``cgroup/sock``                  |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET_SOCK_RELEASE``       | ``cgroup/sock_release``          |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_CGROUP_SYSCTL``           | ``BPF_CGROUP_SYSCTL``                  | ``cgroup/sysctl``                |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_EXT``                     |                                        | ``freplace+`` [#fentry]_         |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_FLOW_DISSECTOR``          | ``BPF_FLOW_DISSECTOR``                 | ``flow_dissector``               |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_KPROBE``                  |                                        | ``kprobe+`` [#kprobe]_           |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``kretprobe+`` [#kprobe]_        |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``ksyscall+`` [#ksyscall]_       |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        |  ``kretsyscall+`` [#ksyscall]_   |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``uprobe+`` [#uprobe]_           |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``uprobe.s+`` [#uprobe]_         | Yes       |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``uretprobe+`` [#uprobe]_        |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``uretprobe.s+`` [#uprobe]_      | Yes       |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``usdt+`` [#usdt]_               |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_TRACE_KPROBE_MULTI``             | ``kprobe.multi+`` [#kpmulti]_    |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``kretprobe.multi+`` [#kpmulti]_ |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_LIRC_MODE2``              | ``BPF_LIRC_MODE2``                     | ``lirc_mode2``                   |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_LSM``                     | ``BPF_LSM_CGROUP``                     | ``lsm_cgroup+``                  |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_LSM_MAC``                        | ``lsm+`` [#lsm]_                 |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``lsm.s+`` [#lsm]_               | Yes       |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_LWT_IN``                  |                                        | ``lwt_in``                       |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_LWT_OUT``                 |                                        | ``lwt_out``                      |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_LWT_SEG6LOCAL``           |                                        | ``lwt_seg6local``                |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_LWT_XMIT``                |                                        | ``lwt_xmit``                     |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_PERF_EVENT``              |                                        | ``perf_event``                   |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE`` |                                        | ``raw_tp.w+`` [#rawtp]_          |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``raw_tracepoint.w+``            |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_RAW_TRACEPOINT``          |                                        | ``raw_tp+`` [#rawtp]_            |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``raw_tracepoint+``              |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_SCHED_ACT``               |                                        | ``action``                       |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_SCHED_CLS``               |                                        | ``classifier``                   |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``tc``                           |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_SK_LOOKUP``               | ``BPF_SK_LOOKUP``                      | ``sk_lookup``                    |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_SK_MSG``                  | ``BPF_SK_MSG_VERDICT``                 | ``sk_msg``                       |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_SK_REUSEPORT``            | ``BPF_SK_REUSEPORT_SELECT_OR_MIGRATE`` | ``sk_reuseport/migrate``         |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_SK_REUSEPORT_SELECT``            | ``sk_reuseport``                 |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_SK_SKB``                  |                                        | ``sk_skb``                       |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_SK_SKB_STREAM_PARSER``           | ``sk_skb/stream_parser``         |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_SK_SKB_STREAM_VERDICT``          | ``sk_skb/stream_verdict``        |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_SOCKET_FILTER``           |                                        | ``socket``                       |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_SOCK_OPS``                | ``BPF_CGROUP_SOCK_OPS``                | ``sockops``                      |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_STRUCT_OPS``              |                                        | ``struct_ops+``                  |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_SYSCALL``                 |                                        | ``syscall``                      | Yes       |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_TRACEPOINT``              |                                        | ``tp+`` [#tp]_                   |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``tracepoint+`` [#tp]_           |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_TRACING``                 | ``BPF_MODIFY_RETURN``                  | ``fmod_ret+`` [#fentry]_         |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``fmod_ret.s+`` [#fentry]_       | Yes       |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_TRACE_FENTRY``                   | ``fentry+`` [#fentry]_           |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``fentry.s+`` [#fentry]_         | Yes       |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_TRACE_FEXIT``                    | ``fexit+`` [#fentry]_            |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``fexit.s+`` [#fentry]_          | Yes       |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_TRACE_ITER``                     | ``iter+`` [#iter]_               |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``iter.s+`` [#iter]_             | Yes       |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_TRACE_RAW_TP``                   | ``tp_btf+`` [#fentry]_           |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_XDP``                     | ``BPF_XDP_CPUMAP``                     | ``xdp.frags/cpumap``             |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``xdp/cpumap``                   |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_XDP_DEVMAP``                     | ``xdp.frags/devmap``             |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``xdp/devmap``                   |           |
> ++                                           +----------------------------------------+----------------------------------+-----------+
> +|                                           | ``BPF_XDP``                            | ``xdp.frags``                    |           |
> ++                                           +                                        +----------------------------------+-----------+
> +|                                           |                                        | ``xdp``                          |           |
> ++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
> +
> +
> +.. rubric:: Footnotes
> +
> +.. [#fentry] The ``fentry`` attach format is ``fentry[.s]/<function>``.
> +.. [#kprobe] The ``kprobe`` attach format is ``kprobe/<function>[+<offset>]``. Valid
> +             characters for ``function`` are ``a-zA-Z0-9_.`` and ``offset`` must be a valid
> +             integer.

Perhaps "nonnegative integer" is slightly more precise here?

> +.. [#ksyscall] The ``ksyscall`` attach format is ``ksyscall/<syscall>``.
> +.. [#uprobe] The ``uprobe`` attach format is ``uprobe[.s]/<path>:<function>[+<offset>]``.
> +.. [#usdt] The ``usdt`` attach format is ``usdt/<path>:<provider>:<name>``.
> +.. [#kpmulti] The ``kprobe.multi`` attach format is ``kprobe.multi/<pattern>`` where ``pattern``
> +              supports ``*`` and ``?`` wildcards. Valid characters for pattern are
> +              ``a-zA-Z0-9_.*?``.
> +.. [#lsm] The ``lsm`` attachment format is ``lsm[.s]/<hook>``.
> +.. [#rawtp] The ``raw_tp`` attach format is ``raw_tracepoint[.w]/<tracepoint>``.
> +.. [#tp] The ``tracepoint`` attach format is ``tracepoint/<category>/<name>``.
> +.. [#iter] The ``iter`` attach format is ``iter[.s]/<struct-name>``.
> diff --git a/Documentation/bpf/programs.rst b/Documentation/bpf/programs.rst
> index 620eb667ac7a..c99000ab6d9b 100644
> --- a/Documentation/bpf/programs.rst
> +++ b/Documentation/bpf/programs.rst
> @@ -7,3 +7,6 @@ Program Types
>     :glob:
>  
>     prog_*
> +
> +For a list of all program types, see :ref:`program_types_and_elf` in
> +the :ref:`libbpf` documentation.
> -- 
> 2.35.1
> 
