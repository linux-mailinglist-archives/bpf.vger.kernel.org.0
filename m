Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF956321B9
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 13:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiKUMSP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 07:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiKUMSN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 07:18:13 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000B229803;
        Mon, 21 Nov 2022 04:18:11 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso12604899wme.5;
        Mon, 21 Nov 2022 04:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2tMdapKpzCXrAnQZv8wcs0o1+fIXYvKheAdIgSxVaAY=;
        b=Au+/1TE4xfIy/Rx44gp7B+XdJ5ha7+SzWqAtzcVvD0JLdul7FKP/3gJAGjkdsg0uug
         eBIi1mdcgyoSp2MREYdInTAqDjBEUgB48QpmtTVsVb+qBor8PdB99bqXEsffac74MRxV
         AGuYM0weAkMrBTkN+D5xE9QyuL+xAPvEyvrmZ6rNPQ+L8C4QAUyX1lisk4xRoEk5ypHV
         y2ClPyst+BXzH2m+GJVN6i7QS02Dz4Z1j8F1BD3c+F0krZhM4omvJRcsq0CtBog8ZiXh
         3oB+WCeOyWKJx1WB2RcRpIr8f5L1Ond/QNaK8f8k4HyjBIvdxs8M7bfzRZ6K3LWyDYgx
         x2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tMdapKpzCXrAnQZv8wcs0o1+fIXYvKheAdIgSxVaAY=;
        b=vQlwGtZET2NxgbjxwQu5ZK8YGwKFfYOw4o/sLbYBGtPb8UzTF+WuIRxh7+JrNHOgpo
         nTFdtu8sod9Lb5bOL2QNZcAqB+MvRLA5XZdic1tkiTBwt8jnyNWHt6COV3R/STVekks7
         r7XseRUvb5kmJcppB4oYD9yE/+OQ+LYsoCIEi/Tno5+SYYQxFbUQre2C+pJFd9mOwjvB
         X9Kc7+UTwU/R157G8QVKWyYXcllnE3ZFgVGM9TV+ns0Y0a4Rylt22LxUPxMEzB9Ol9F6
         ceRkaZAU68Bk1Z3pVVuU4v0CrrsWVuyRRS6Z4i3ENueTeuO5SFKeea/E33kW8AUNVPUx
         6HQg==
X-Gm-Message-State: ANoB5pk7trJ2t2mD56P83lua1c7kvjsGj/xrVlyARKdmwrI5IxH/YWv6
        oiunMfX8zDXJ9KUSSlhI9zjy2RcXF5IjaQ==
X-Google-Smtp-Source: AA0mqf6DRZTqlR09Zuo/3ypZCZWWFdzxdxORvn6uEyJaLbpg48DYu/clzcBRcnTj9FDzaliPyRKrIg==
X-Received: by 2002:a05:600c:444b:b0:3cf:c56c:1db2 with SMTP id v11-20020a05600c444b00b003cfc56c1db2mr3560017wmn.136.1669033089698;
        Mon, 21 Nov 2022 04:18:09 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:2da2:55d0:e0b2:b6b0])
        by smtp.gmail.com with ESMTPSA id z5-20020a056000110500b0022cc3e67fc5sm11141416wrw.65.2022.11.21.04.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 04:18:08 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Vernet <void@manifault.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v6] docs/bpf: Add table of BPF program types to libbpf docs
Date:   Mon, 21 Nov 2022 12:17:34 +0000
Message-Id: <20221121121734.98329-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.38.1
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
Acked-by: David Vernet <void@manifault.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
This latest version of the patchset uses an inline table that is
formatted by hand. The section name extras are documented in footnotes
with cross references from within the table.

v5 -> v6:
- Mention non-negative offset for kprobe, suggested by David Vernet
- Include this version history that was missing in v5

v4 -> v5:
- Use inline grid table format and add footnotes for section name extras
- Drop the generator script and makefile changes from the patchset

v3 -> v4:
- Fix typo reported by Jesper Brouer
- Move the generator from the Makefile to a separate script

v2 -> v3:
- Put program_types after API docs in TOC as suggested by Andrii Nakryiko
- Fix formatting as reported by Andrii Nakryiko
- Include USDT extras example as suggested by Andrii Nakryiko
- Include sample of program_types.csv as suggested by Andrii Nakryiko

v1 -> v2:
- Automate the generation of program_types.csv as suggested by
- Andrii Nakryiko.

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
index 000000000000..ad4d4d5eecb0
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
+             non-negative integer.
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
2.38.1

