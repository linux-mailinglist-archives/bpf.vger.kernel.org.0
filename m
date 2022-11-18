Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1884762F947
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 16:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241364AbiKRP3N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 10:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241331AbiKRP3L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 10:29:11 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216DE11C0E;
        Fri, 18 Nov 2022 07:29:09 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso7772206wme.5;
        Fri, 18 Nov 2022 07:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cHyU2wFl3CdjAuqi6mJgk8RnsaLhgVOeTGOsHo1FQAk=;
        b=ksScvMgso2LCOIHtkpg8SMGkSrV0DgGZHrBwOk/P8FdDLvgyX1U3Gh1drNRObguXX8
         s1XV7Zr8fWwxJER4IMD2pqbSj4gpllynWsn9FsMgPkLDUyfJW7d1YsJJ9c/ElvS1qqGr
         gfUCM0/qZhuYpm7ncItqLZxINB4x5R1QV9uAXUjWSCp5BMPjCYkpketmqToMo3WZCR+y
         K8Qr0kIGpnQYO8GbGtbCULlQ25pwvLE65Z3eshWLFq7h2ZaLGdCdZ3HH69aKJiaV5Jqy
         RmtsIX4QurljVpEL7c+2GrhLXfAAIUMFa65524kdGtHpAHVpRSZ0ikvHGaYuYiIUcXbh
         oF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHyU2wFl3CdjAuqi6mJgk8RnsaLhgVOeTGOsHo1FQAk=;
        b=EOaYGW8EYpTSq9XaV5P0fG2tXdiY+B+fxSCPR3kkhbb0XSoeneMbIW6dAmh+9A3s08
         L9VD3FHf2zEnB5B2nORpqntYIbGnPe8suyIklA+uDwCNjATszTjnALBNJYg2cX9nuOMd
         agm30bGsCiG9wBd1tYuNP078SLGag65sxeVMm8ZMitY5jMC9J53QLSTRLbPQYpSBqpFy
         qdMo++xZX0yAtCsrvo8fXhH5mJC6kgCxTzGAwulqpq19IWGCD4WPVl+BvAHyH8fSTbxN
         cKwxjjpDj49PgJimajQgKjCl+y0YxilK2So1t70cYRWhtjHKS2TInPdjwxG9F9iHQhFD
         xHrg==
X-Gm-Message-State: ANoB5pl01jlSrrwylwQms97AeeSm9RPCulJ4LZzq/S1vN34hS7EbxNgP
        dKUQ1V1ZuitZI8SUjqHJsi1G6HpvU38b5w==
X-Google-Smtp-Source: AA0mqf4CNAGkcGoXkbI6asQ4A1TKwIxG+AwhIrlVh6AjaVeKTuy+PG9UDSsZHDZLXsy/0sWjgj/shw==
X-Received: by 2002:a05:600c:6545:b0:3cf:baef:e92a with SMTP id dn5-20020a05600c654500b003cfbaefe92amr5128132wmb.178.1668785346814;
        Fri, 18 Nov 2022 07:29:06 -0800 (PST)
Received: from imac.redhat.com ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c4fd200b003cf6a55d8e8sm5473972wmq.7.2022.11.18.07.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 07:29:05 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v5] docs/bpf: Add table of BPF program types to libbpf docs
Date:   Fri, 18 Nov 2022 15:28:59 +0000
Message-Id: <20221118152859.69645-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend the libbpf documentation with a table of program types,
attach points and ELF section names.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/bpf/libbpf/index.rst         |   3 +
 Documentation/bpf/libbpf/program_types.rst | 203 +++++++++++++++++++++
 Documentation/bpf/programs.rst             |   3 +
 3 files changed, 209 insertions(+)
 create mode 100644 Documentation/bpf/libbpf/program_types.rst

diff --git a/Documentation/bpf/libbpf/index.rst b/Documentation/bpf/libbpf/index.rst
index 3722537d1384..f9b3b252e28f 100644
--- a/Documentation/bpf/libbpf/index.rst
+++ b/Documentation/bpf/libbpf/index.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 
+.. _libbpf:
+
 libbpf
 ======
 
@@ -7,6 +9,7 @@ libbpf
    :maxdepth: 1
 
    API Documentation <https://libbpf.readthedocs.io/en/latest/api.html>
+   program_types
    libbpf_naming_convention
    libbpf_build
 
diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/bpf/libbpf/program_types.rst
new file mode 100644
index 000000000000..544e1597ff5f
--- /dev/null
+++ b/Documentation/bpf/libbpf/program_types.rst
@@ -0,0 +1,203 @@
+.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+.. _program_types_and_elf:
+
+Program Types and ELF Sections
+==============================
+
+The table below lists the program types, their attach types where relevant and the ELF section
+names supported by libbpf for them. The ELF section names follow these rules:
+
+- ``type`` is an exact match, e.g. ``SEC("socket")``
+- ``type+`` means it can be either exact ``SEC("type")`` or well-formed ``SEC("type/extras")``
+  with a '``/``' separator between ``type`` and ``extras``.
+
+When ``extras`` are specified, they provide details of how to auto-attach the BPF program.  The
+format of ``extras`` depends on the program type, e.g. ``SEC("tracepoint/<category>/<name>")``
+for tracepoints or ``SEC("usdt/<path>:<provider>:<name>")`` for USDT probes. The extras are
+described in more detail in the footnotes.
+
+
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| Program Type                              | Attach Type                            | ELF Section Name                 | Sleepable |
++===========================================+========================================+==================================+===========+
+| ``BPF_PROG_TYPE_CGROUP_DEVICE``           | ``BPF_CGROUP_DEVICE``                  | ``cgroup/dev``                   |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_CGROUP_SKB``              |                                        | ``cgroup/skb``                   |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_INET_EGRESS``             | ``cgroup_skb/egress``            |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_INET_INGRESS``            | ``cgroup_skb/ingress``           |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_CGROUP_SOCKOPT``          | ``BPF_CGROUP_GETSOCKOPT``              | ``cgroup/getsockopt``            |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_SETSOCKOPT``              | ``cgroup/setsockopt``            |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``        | ``BPF_CGROUP_INET4_BIND``              | ``cgroup/bind4``                 |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_INET4_CONNECT``           | ``cgroup/connect4``              |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_INET4_GETPEERNAME``       | ``cgroup/getpeername4``          |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_INET4_GETSOCKNAME``       | ``cgroup/getsockname4``          |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_INET6_BIND``              | ``cgroup/bind6``                 |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_INET6_CONNECT``           | ``cgroup/connect6``              |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_INET6_GETPEERNAME``       | ``cgroup/getpeername6``          |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_INET6_GETSOCKNAME``       | ``cgroup/getsockname6``          |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UDP4_RECVMSG``            | ``cgroup/recvmsg4``              |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UDP4_SENDMSG``            | ``cgroup/sendmsg4``              |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UDP6_RECVMSG``            | ``cgroup/recvmsg6``              |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UDP6_SENDMSG``            | ``cgroup/sendmsg6``              |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_CGROUP_SOCK``             | ``BPF_CGROUP_INET4_POST_BIND``         | ``cgroup/post_bind4``            |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_INET6_POST_BIND``         | ``cgroup/post_bind6``            |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_INET_SOCK_CREATE``        | ``cgroup/sock_create``           |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``cgroup/sock``                  |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_INET_SOCK_RELEASE``       | ``cgroup/sock_release``          |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_CGROUP_SYSCTL``           | ``BPF_CGROUP_SYSCTL``                  | ``cgroup/sysctl``                |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_EXT``                     |                                        | ``freplace+`` [#fentry]_         |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_FLOW_DISSECTOR``          | ``BPF_FLOW_DISSECTOR``                 | ``flow_dissector``               |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_KPROBE``                  |                                        | ``kprobe+`` [#kprobe]_           |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``kretprobe+`` [#kprobe]_        |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``ksyscall+`` [#ksyscall]_       |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        |  ``kretsyscall+`` [#ksyscall]_   |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``uprobe+`` [#uprobe]_           |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``uprobe.s+`` [#uprobe]_         | Yes       |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``uretprobe+`` [#uprobe]_        |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``uretprobe.s+`` [#uprobe]_      | Yes       |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``usdt+`` [#usdt]_               |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_TRACE_KPROBE_MULTI``             | ``kprobe.multi+`` [#kpmulti]_    |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``kretprobe.multi+`` [#kpmulti]_ |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_LIRC_MODE2``              | ``BPF_LIRC_MODE2``                     | ``lirc_mode2``                   |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_LSM``                     | ``BPF_LSM_CGROUP``                     | ``lsm_cgroup+``                  |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_LSM_MAC``                        | ``lsm+`` [#lsm]_                 |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``lsm.s+`` [#lsm]_               | Yes       |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_LWT_IN``                  |                                        | ``lwt_in``                       |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_LWT_OUT``                 |                                        | ``lwt_out``                      |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_LWT_SEG6LOCAL``           |                                        | ``lwt_seg6local``                |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_LWT_XMIT``                |                                        | ``lwt_xmit``                     |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_PERF_EVENT``              |                                        | ``perf_event``                   |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE`` |                                        | ``raw_tp.w+`` [#rawtp]_          |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``raw_tracepoint.w+``            |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_RAW_TRACEPOINT``          |                                        | ``raw_tp+`` [#rawtp]_            |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``raw_tracepoint+``              |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_SCHED_ACT``               |                                        | ``action``                       |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_SCHED_CLS``               |                                        | ``classifier``                   |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``tc``                           |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_SK_LOOKUP``               | ``BPF_SK_LOOKUP``                      | ``sk_lookup``                    |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_SK_MSG``                  | ``BPF_SK_MSG_VERDICT``                 | ``sk_msg``                       |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_SK_REUSEPORT``            | ``BPF_SK_REUSEPORT_SELECT_OR_MIGRATE`` | ``sk_reuseport/migrate``         |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_SK_REUSEPORT_SELECT``            | ``sk_reuseport``                 |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_SK_SKB``                  |                                        | ``sk_skb``                       |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_SK_SKB_STREAM_PARSER``           | ``sk_skb/stream_parser``         |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_SK_SKB_STREAM_VERDICT``          | ``sk_skb/stream_verdict``        |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_SOCKET_FILTER``           |                                        | ``socket``                       |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_SOCK_OPS``                | ``BPF_CGROUP_SOCK_OPS``                | ``sockops``                      |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_STRUCT_OPS``              |                                        | ``struct_ops+``                  |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_SYSCALL``                 |                                        | ``syscall``                      | Yes       |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_TRACEPOINT``              |                                        | ``tp+`` [#tp]_                   |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``tracepoint+`` [#tp]_           |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_TRACING``                 | ``BPF_MODIFY_RETURN``                  | ``fmod_ret+`` [#fentry]_         |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``fmod_ret.s+`` [#fentry]_       | Yes       |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_TRACE_FENTRY``                   | ``fentry+`` [#fentry]_           |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``fentry.s+`` [#fentry]_         | Yes       |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_TRACE_FEXIT``                    | ``fexit+`` [#fentry]_            |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``fexit.s+`` [#fentry]_          | Yes       |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_TRACE_ITER``                     | ``iter+`` [#iter]_               |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``iter.s+`` [#iter]_             | Yes       |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_TRACE_RAW_TP``                   | ``tp_btf+`` [#fentry]_           |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+| ``BPF_PROG_TYPE_XDP``                     | ``BPF_XDP_CPUMAP``                     | ``xdp.frags/cpumap``             |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``xdp/cpumap``                   |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_XDP_DEVMAP``                     | ``xdp.frags/devmap``             |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``xdp/devmap``                   |           |
++                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_XDP``                            | ``xdp.frags``                    |           |
++                                           +                                        +----------------------------------+-----------+
+|                                           |                                        | ``xdp``                          |           |
++-------------------------------------------+----------------------------------------+----------------------------------+-----------+
+
+
+.. rubric:: Footnotes
+
+.. [#fentry] The ``fentry`` attach format is ``fentry[.s]/<function>``.
+.. [#kprobe] The ``kprobe`` attach format is ``kprobe/<function>[+<offset>]``. Valid
+             characters for ``function`` are ``a-zA-Z0-9_.`` and ``offset`` must be a valid
+             integer.
+.. [#ksyscall] The ``ksyscall`` attach format is ``ksyscall/<syscall>``.
+.. [#uprobe] The ``uprobe`` attach format is ``uprobe[.s]/<path>:<function>[+<offset>]``.
+.. [#usdt] The ``usdt`` attach format is ``usdt/<path>:<provider>:<name>``.
+.. [#kpmulti] The ``kprobe.multi`` attach format is ``kprobe.multi/<pattern>`` where ``pattern``
+              supports ``*`` and ``?`` wildcards. Valid characters for pattern are
+              ``a-zA-Z0-9_.*?``.
+.. [#lsm] The ``lsm`` attachment format is ``lsm[.s]/<hook>``.
+.. [#rawtp] The ``raw_tp`` attach format is ``raw_tracepoint[.w]/<tracepoint>``.
+.. [#tp] The ``tracepoint`` attach format is ``tracepoint/<category>/<name>``.
+.. [#iter] The ``iter`` attach format is ``iter[.s]/<struct-name>``.
diff --git a/Documentation/bpf/programs.rst b/Documentation/bpf/programs.rst
index 620eb667ac7a..c99000ab6d9b 100644
--- a/Documentation/bpf/programs.rst
+++ b/Documentation/bpf/programs.rst
@@ -7,3 +7,6 @@ Program Types
    :glob:
 
    prog_*
+
+For a list of all program types, see :ref:`program_types_and_elf` in
+the :ref:`libbpf` documentation.
-- 
2.35.1

