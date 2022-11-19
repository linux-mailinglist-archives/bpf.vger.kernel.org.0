Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AB5630AE9
	for <lists+bpf@lfdr.de>; Sat, 19 Nov 2022 04:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiKSDAb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 22:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiKSDAa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 22:00:30 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27521A4653;
        Fri, 18 Nov 2022 19:00:29 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d192so6622526pfd.0;
        Fri, 18 Nov 2022 19:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=etLGnw2OMt9eI36D0sxpDHeZERvGJG9x4prtGYl1hlw=;
        b=Gl3dUJ5MhqKzzR2t3XL9fMztRR9RzPTYWLKf22ebbilt0zLXIVAWBAWhsVxvn5DqLc
         v9JTVSvSS5lDSPU81BglZ9w9bbOnrEHICXduPA6QPqMahXaP4a/xdn8Og1yV7EzsZ736
         vWO23LYM/WHQxHT1unvTCP2FkUpXoZsu+/xhHt3TDLStMtgwdAWbeSELXNSA5cV2Brzx
         GkcLjSM2V2pJafYDVMZL0p81EsLWMQ8S2w+A01lDJyagn2szy18YK1pELsAzQzm/gtTH
         0b4Ov7CGoxG0vgvU8q75r4m/XugF/+41zLPmtAH9AAWNtK2c6IT4NQS+f7lOG3HyWIEM
         Zvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etLGnw2OMt9eI36D0sxpDHeZERvGJG9x4prtGYl1hlw=;
        b=RrO2my2SELMgYDlS4B64yrhQpkaUt7K5l5QPsqhwc4FnJpZLyBjB55QoUCk7LZ79gq
         bTLno0BGT11SD7c62SMf3PKBYKfSERNKwrUqbhbx8HMkTBtKbEHP+ug9+v/jUy+9JOT0
         4qMIp3tFFMnp8QVy84rOwpX5xeTcWuaYhpk36zAK5kxBel8b32bRrHPNbc5mULQ5M9FQ
         YOh4IJqaVp2tLRwrqh3+q9hOyU+uc95Bes61eO+vXPkJRfXA0itauqv5Vy7v9J6ydJQ6
         woVBGE4USSeK42snj5lUhVcbghkuhQSNXTAkCWd8PYPAuwH5zxxvrwi8nt4c7EvWgvHE
         l1xA==
X-Gm-Message-State: ANoB5pm60sZqU9G2IDk5OitFSsKCp38mGQRCO8Ocz+Zf53P4UGaR5Aav
        a7ZouvLl1Jt1pZA4Zio8DyonZeCUKfI=
X-Google-Smtp-Source: AA0mqf7obYmF8GZTQtkqhTJ2PVUxU/0Vdy8nU/xeEuGGZKmTCBjH2HKJFJN3RyAu4Ql94VB163Qv9w==
X-Received: by 2002:aa7:8092:0:b0:561:ada0:69d7 with SMTP id v18-20020aa78092000000b00561ada069d7mr10815416pff.9.1668826828437;
        Fri, 18 Nov 2022 19:00:28 -0800 (PST)
Received: from debian.me (subs03-180-214-233-79.three.co.id. [180.214.233.79])
        by smtp.gmail.com with ESMTPSA id g8-20020a17090a640800b0020a81cf4a9asm6106030pjj.14.2022.11.18.19.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:00:27 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 075B410434B; Sat, 19 Nov 2022 10:00:23 +0700 (WIB)
Date:   Sat, 19 Nov 2022 10:00:23 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH bpf-next v5] docs/bpf: Add table of BPF program types to
 libbpf docs
Message-ID: <Y3hGx1CovMeb/1MN@debian.me>
References: <20221118152859.69645-1-donald.hunter@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6TR2Pzw3ZpEkZAuV"
Content-Disposition: inline
In-Reply-To: <20221118152859.69645-1-donald.hunter@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--6TR2Pzw3ZpEkZAuV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 18, 2022 at 03:28:59PM +0000, Donald Hunter wrote:
> Extend the libbpf documentation with a table of program types,
> attach points and ELF section names.
>=20
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/bpf/libbpf/index.rst         |   3 +
>  Documentation/bpf/libbpf/program_types.rst | 203 +++++++++++++++++++++
>  Documentation/bpf/programs.rst             |   3 +
>  3 files changed, 209 insertions(+)
>  create mode 100644 Documentation/bpf/libbpf/program_types.rst
>=20
> diff --git a/Documentation/bpf/libbpf/index.rst b/Documentation/bpf/libbp=
f/index.rst
> index 3722537d1384..f9b3b252e28f 100644
> --- a/Documentation/bpf/libbpf/index.rst
> +++ b/Documentation/bpf/libbpf/index.rst
> @@ -1,5 +1,7 @@
>  .. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> =20
> +.. _libbpf:
> +
>  libbpf
>  =3D=3D=3D=3D=3D=3D
> =20
> @@ -7,6 +9,7 @@ libbpf
>     :maxdepth: 1
> =20
>     API Documentation <https://libbpf.readthedocs.io/en/latest/api.html>
> +   program_types
>     libbpf_naming_convention
>     libbpf_build
> =20
> diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/b=
pf/libbpf/program_types.rst
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
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +The table below lists the program types, their attach types where releva=
nt and the ELF section
> +names supported by libbpf for them. The ELF section names follow these r=
ules:
> +
> +- ``type`` is an exact match, e.g. ``SEC("socket")``
> +- ``type+`` means it can be either exact ``SEC("type")`` or well-formed =
``SEC("type/extras")``
> +  with a '``/``' separator between ``type`` and ``extras``.
> +
> +When ``extras`` are specified, they provide details of how to auto-attac=
h the BPF program.  The
> +format of ``extras`` depends on the program type, e.g. ``SEC("tracepoint=
/<category>/<name>")``
> +for tracepoints or ``SEC("usdt/<path>:<provider>:<name>")`` for USDT pro=
bes. The extras are
> +described in more detail in the footnotes.
> +
> +
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| Program Type                              | Attach Type               =
             | ELF Section Name                 | Sleepable |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D+
> +| ``BPF_PROG_TYPE_CGROUP_DEVICE``           | ``BPF_CGROUP_DEVICE``     =
             | ``cgroup/dev``                   |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_CGROUP_SKB``              |                           =
             | ``cgroup/skb``                   |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET_EGRESS``=
             | ``cgroup_skb/egress``            |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET_INGRESS`=
`            | ``cgroup_skb/ingress``           |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_CGROUP_SOCKOPT``          | ``BPF_CGROUP_GETSOCKOPT`` =
             | ``cgroup/getsockopt``            |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_SETSOCKOPT`` =
             | ``cgroup/setsockopt``            |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``        | ``BPF_CGROUP_INET4_BIND`` =
             | ``cgroup/bind4``                 |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET4_CONNECT=
``           | ``cgroup/connect4``              |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET4_GETPEER=
NAME``       | ``cgroup/getpeername4``          |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET4_GETSOCK=
NAME``       | ``cgroup/getsockname4``          |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET6_BIND`` =
             | ``cgroup/bind6``                 |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET6_CONNECT=
``           | ``cgroup/connect6``              |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET6_GETPEER=
NAME``       | ``cgroup/getpeername6``          |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET6_GETSOCK=
NAME``       | ``cgroup/getsockname6``          |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_UDP4_RECVMSG`=
`            | ``cgroup/recvmsg4``              |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_UDP4_SENDMSG`=
`            | ``cgroup/sendmsg4``              |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_UDP6_RECVMSG`=
`            | ``cgroup/recvmsg6``              |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_UDP6_SENDMSG`=
`            | ``cgroup/sendmsg6``              |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_CGROUP_SOCK``             | ``BPF_CGROUP_INET4_POST_BI=
ND``         | ``cgroup/post_bind4``            |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET6_POST_BI=
ND``         | ``cgroup/post_bind6``            |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET_SOCK_CRE=
ATE``        | ``cgroup/sock_create``           |           |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             | ``cgroup/sock``                  |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_CGROUP_INET_SOCK_REL=
EASE``       | ``cgroup/sock_release``          |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_CGROUP_SYSCTL``           | ``BPF_CGROUP_SYSCTL``     =
             | ``cgroup/sysctl``                |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_EXT``                     |                           =
             | ``freplace+`` [#fentry]_         |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_FLOW_DISSECTOR``          | ``BPF_FLOW_DISSECTOR``    =
             | ``flow_dissector``               |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_KPROBE``                  |                           =
             | ``kprobe+`` [#kprobe]_           |           |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             | ``kretprobe+`` [#kprobe]_        |           |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             | ``ksyscall+`` [#ksyscall]_       |           |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             |  ``kretsyscall+`` [#ksyscall]_   |           |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             | ``uprobe+`` [#uprobe]_           |           |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             | ``uprobe.s+`` [#uprobe]_         | Yes       |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             | ``uretprobe+`` [#uprobe]_        |           |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             | ``uretprobe.s+`` [#uprobe]_      | Yes       |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             | ``usdt+`` [#usdt]_               |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_TRACE_KPROBE_MULTI``=
             | ``kprobe.multi+`` [#kpmulti]_    |           |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             | ``kretprobe.multi+`` [#kpmulti]_ |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_LIRC_MODE2``              | ``BPF_LIRC_MODE2``        =
             | ``lirc_mode2``                   |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_LSM``                     | ``BPF_LSM_CGROUP``        =
             | ``lsm_cgroup+``                  |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_LSM_MAC``           =
             | ``lsm+`` [#lsm]_                 |           |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             | ``lsm.s+`` [#lsm]_               | Yes       |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_LWT_IN``                  |                           =
             | ``lwt_in``                       |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_LWT_OUT``                 |                           =
             | ``lwt_out``                      |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_LWT_SEG6LOCAL``           |                           =
             | ``lwt_seg6local``                |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_LWT_XMIT``                |                           =
             | ``lwt_xmit``                     |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_PERF_EVENT``              |                           =
             | ``perf_event``                   |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE`` |                           =
             | ``raw_tp.w+`` [#rawtp]_          |           |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             | ``raw_tracepoint.w+``            |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_RAW_TRACEPOINT``          |                           =
             | ``raw_tp+`` [#rawtp]_            |           |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             | ``raw_tracepoint+``              |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_SCHED_ACT``               |                           =
             | ``action``                       |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_SCHED_CLS``               |                           =
             | ``classifier``                   |           |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             | ``tc``                           |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_SK_LOOKUP``               | ``BPF_SK_LOOKUP``         =
             | ``sk_lookup``                    |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_SK_MSG``                  | ``BPF_SK_MSG_VERDICT``    =
             | ``sk_msg``                       |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_SK_REUSEPORT``            | ``BPF_SK_REUSEPORT_SELECT_=
OR_MIGRATE`` | ``sk_reuseport/migrate``         |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_SK_REUSEPORT_SELECT`=
`            | ``sk_reuseport``                 |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_SK_SKB``                  |                           =
             | ``sk_skb``                       |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_SK_SKB_STREAM_PARSER=
``           | ``sk_skb/stream_parser``         |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_SK_SKB_STREAM_VERDIC=
T``          | ``sk_skb/stream_verdict``        |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_SOCKET_FILTER``           |                           =
             | ``socket``                       |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_SOCK_OPS``                | ``BPF_CGROUP_SOCK_OPS``   =
             | ``sockops``                      |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_STRUCT_OPS``              |                           =
             | ``struct_ops+``                  |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_SYSCALL``                 |                           =
             | ``syscall``                      | Yes       |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_TRACEPOINT``              |                           =
             | ``tp+`` [#tp]_                   |           |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             | ``tracepoint+`` [#tp]_           |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_TRACING``                 | ``BPF_MODIFY_RETURN``     =
             | ``fmod_ret+`` [#fentry]_         |           |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             | ``fmod_ret.s+`` [#fentry]_       | Yes       |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_TRACE_FENTRY``      =
             | ``fentry+`` [#fentry]_           |           |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             | ``fentry.s+`` [#fentry]_         | Yes       |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_TRACE_FEXIT``       =
             | ``fexit+`` [#fentry]_            |           |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             | ``fexit.s+`` [#fentry]_          | Yes       |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_TRACE_ITER``        =
             | ``iter+`` [#iter]_               |           |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             | ``iter.s+`` [#iter]_             | Yes       |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_TRACE_RAW_TP``      =
             | ``tp_btf+`` [#fentry]_           |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +| ``BPF_PROG_TYPE_XDP``                     | ``BPF_XDP_CPUMAP``        =
             | ``xdp.frags/cpumap``             |           |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             | ``xdp/cpumap``                   |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_XDP_DEVMAP``        =
             | ``xdp.frags/devmap``             |           |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             | ``xdp/devmap``                   |           |
> ++                                           +---------------------------=
-------------+----------------------------------+-----------+
> +|                                           | ``BPF_XDP``               =
             | ``xdp.frags``                    |           |
> ++                                           +                           =
             +----------------------------------+-----------+
> +|                                           |                           =
             | ``xdp``                          |           |
> ++-------------------------------------------+---------------------------=
-------------+----------------------------------+-----------+
> +
> +
> +.. rubric:: Footnotes
> +
> +.. [#fentry] The ``fentry`` attach format is ``fentry[.s]/<function>``.
> +.. [#kprobe] The ``kprobe`` attach format is ``kprobe/<function>[+<offse=
t>]``. Valid
> +             characters for ``function`` are ``a-zA-Z0-9_.`` and ``offse=
t`` must be a valid
> +             integer.
> +.. [#ksyscall] The ``ksyscall`` attach format is ``ksyscall/<syscall>``.
> +.. [#uprobe] The ``uprobe`` attach format is ``uprobe[.s]/<path>:<functi=
on>[+<offset>]``.
> +.. [#usdt] The ``usdt`` attach format is ``usdt/<path>:<provider>:<name>=
``.
> +.. [#kpmulti] The ``kprobe.multi`` attach format is ``kprobe.multi/<patt=
ern>`` where ``pattern``
> +              supports ``*`` and ``?`` wildcards. Valid characters for p=
attern are
> +              ``a-zA-Z0-9_.*?``.
> +.. [#lsm] The ``lsm`` attachment format is ``lsm[.s]/<hook>``.
> +.. [#rawtp] The ``raw_tp`` attach format is ``raw_tracepoint[.w]/<tracep=
oint>``.
> +.. [#tp] The ``tracepoint`` attach format is ``tracepoint/<category>/<na=
me>``.
> +.. [#iter] The ``iter`` attach format is ``iter[.s]/<struct-name>``.
> diff --git a/Documentation/bpf/programs.rst b/Documentation/bpf/programs.=
rst
> index 620eb667ac7a..c99000ab6d9b 100644
> --- a/Documentation/bpf/programs.rst
> +++ b/Documentation/bpf/programs.rst
> @@ -7,3 +7,6 @@ Program Types
>     :glob:
> =20
>     prog_*
> +
> +For a list of all program types, see :ref:`program_types_and_elf` in
> +the :ref:`libbpf` documentation.

The doc LGTM, thanks.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--6TR2Pzw3ZpEkZAuV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY3hGwwAKCRD2uYlJVVFO
o3VBAQDXLlD+HY4hKaBVWINkbWKq2O5Nl+8x81C5IIdetly47QD/adl1joZTvrif
rngCvkmmM3zf0ixfCLypVWr9Nll63wY=
=zZXt
-----END PGP SIGNATURE-----

--6TR2Pzw3ZpEkZAuV--
