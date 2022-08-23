Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FCC59E81D
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 18:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245381AbiHWQyc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 12:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245461AbiHWQyH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 12:54:07 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D96D134904;
        Tue, 23 Aug 2022 06:22:58 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u14so16979292wrq.9;
        Tue, 23 Aug 2022 06:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=GfXTxlj3CGiZoSTXh5Xk1RxK1PDeJcnOOY0/EAwNICQ=;
        b=OnCCH8Q+hvA+4yfvt0G7Ccp2mKh7ihOVxSghP0rV+aZ/lX6DRPkftJSwpq3ptFIr/F
         /jV1/7JMrVV02niB7wsnYxIRNnTdF1vBhdhuf0HeFE6bEp4fww2M5WMNueUjVssr1O8I
         nOfk9JkFmL75AapIp9d08pLWarCgYjZ6R6sgC1EoIz42mtDsgDkXFBBp9+Ro0a/+PBb7
         oVuDhR5I2rotRjxnKHQ6rVoEiIUmC5587rktKCxTa46TMQZGwtsj6hxyyO4H//fxIBNz
         Kco/zPmrEDL2edPaaZa5xhy6kcX6sAjU53nkSx5cT8yb75ytmmtjH6nHbR5C8TULmECm
         8nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=GfXTxlj3CGiZoSTXh5Xk1RxK1PDeJcnOOY0/EAwNICQ=;
        b=SAQzJn8vMGTefjmAUCoQOIW+CHdk4kKuCD+2x4h9c9+FiOEEP/12w3N60rcE7p5G1D
         hUx5fyVG0Yv2Hpwn2LIV5LYMLAKLNRrQunwPou/3MIVkuqyM3QCNKltPMH569yi+2Hpj
         ppHH+t0EjGilZTCzCY7Q0MQ+F/d+A5F+U2O5UDocFC5GhFE5cdeDi0g95PzHzhthK9lP
         JTgoqM+85bugOyMcST1CxYRfwz9dynxJvHd15DET5ZULPaK2n73Az5mAZhg6LPE0zldW
         mgY/x5PZNiD4MjKXX7RvFGub719GuQub6f2NjgGykgjG1a6T3OpYLyfgxgCUu5rHiIc4
         SK3Q==
X-Gm-Message-State: ACgBeo1x2dQEG3WvwtRxPQS6zxrLGog4my+/aaTYpuCXQvFUuFiYApKl
        VM/e4H06y9jx1dWjQPMfFGKVTDtg6kS2sA==
X-Google-Smtp-Source: AA6agR7wvYKMFgaz1ALfRuJ6hgCFJRhgD1g1SoJPosvmNuoVWSs1N5CnHG2cTGeRq/LzdLR6940VsA==
X-Received: by 2002:adf:ff84:0:b0:225:5880:c0c8 with SMTP id j4-20020adfff84000000b002255880c0c8mr5844585wrr.9.1661260976011;
        Tue, 23 Aug 2022 06:22:56 -0700 (PDT)
Received: from imac.redhat.com ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d4207000000b002253fd19a6asm13099338wrq.18.2022.08.23.06.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 06:22:55 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next] Add table of BPF program types to docs
Date:   Tue, 23 Aug 2022 14:22:36 +0100
Message-Id: <20220823132236.65122-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend the BPF program types documentation with a table of
program types, attach points and ELF section names.

The program_types.csv file is generated from tools/lib/bpf/libbpf.c
and a script is included for regenerating the .csv file.

I have not integrated the script into the doc build but if that
is desirable then please suggest the preferred way to do so.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/bpf/program_types.csv | 82 +++++++++++++++++++++++++++++
 Documentation/bpf/programs.rst      | 15 ++++++
 scripts/gen-bpf-progtypes.sh        | 21 ++++++++
 3 files changed, 118 insertions(+)
 create mode 100644 Documentation/bpf/program_types.csv
 create mode 100755 scripts/gen-bpf-progtypes.sh

diff --git a/Documentation/bpf/program_types.csv b/Documentation/bpf/program_types.csv
new file mode 100644
index 000000000000..adec046b0bde
--- /dev/null
+++ b/Documentation/bpf/program_types.csv
@@ -0,0 +1,82 @@
+Program Type,Attach Type,ELF Section Name,Sleepable
+``BPF_PROG_TYPE_SOCKET_FILTER``,,``socket``,
+``BPF_PROG_TYPE_SK_REUSEPORT``,``BPF_SK_REUSEPORT_SELECT_OR_MIGRATE``,``sk_reuseport/migrate``,
+``BPF_PROG_TYPE_SK_REUSEPORT``,``BPF_SK_REUSEPORT_SELECT``,``sk_reuseport``,
+``BPF_PROG_TYPE_KPROBE``,,``kprobe+``,
+``BPF_PROG_TYPE_KPROBE``,,``uprobe+``,
+``BPF_PROG_TYPE_KPROBE``,,``uprobe.s+``,Yes
+``BPF_PROG_TYPE_KPROBE``,,``kretprobe+``,
+``BPF_PROG_TYPE_KPROBE``,,``uretprobe+``,
+``BPF_PROG_TYPE_KPROBE``,,``uretprobe.s+``,Yes
+``BPF_PROG_TYPE_KPROBE``,``BPF_TRACE_KPROBE_MULTI``,``kprobe.multi+``,
+``BPF_PROG_TYPE_KPROBE``,``BPF_TRACE_KPROBE_MULTI``,``kretprobe.multi+``,
+``BPF_PROG_TYPE_KPROBE``,,``ksyscall+``,
+``BPF_PROG_TYPE_KPROBE``,,``kretsyscall+``,
+``BPF_PROG_TYPE_KPROBE``,,``usdt+``,
+``BPF_PROG_TYPE_SCHED_CLS``,,``tc``,
+``BPF_PROG_TYPE_SCHED_CLS``,,``classifier``,
+``BPF_PROG_TYPE_SCHED_ACT``,,``action``,
+``BPF_PROG_TYPE_TRACEPOINT``,,``tracepoint+``,
+``BPF_PROG_TYPE_TRACEPOINT``,,``tp+``,
+``BPF_PROG_TYPE_RAW_TRACEPOINT``,,``raw_tracepoint+``,
+``BPF_PROG_TYPE_RAW_TRACEPOINT``,,``raw_tp+``,
+``BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE``,,``raw_tracepoint.w+``,
+``BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE``,,``raw_tp.w+``,
+``BPF_PROG_TYPE_TRACING``,``BPF_TRACE_RAW_TP``,``tp_btf+``,
+``BPF_PROG_TYPE_TRACING``,``BPF_TRACE_FENTRY``,``fentry+``,
+``BPF_PROG_TYPE_TRACING``,``BPF_MODIFY_RETURN``,``fmod_ret+``,
+``BPF_PROG_TYPE_TRACING``,``BPF_TRACE_FEXIT``,``fexit+``,
+``BPF_PROG_TYPE_TRACING``,``BPF_TRACE_FENTRY``,``fentry.s+``,Yes
+``BPF_PROG_TYPE_TRACING``,``BPF_MODIFY_RETURN``,``fmod_ret.s+``,Yes
+``BPF_PROG_TYPE_TRACING``,``BPF_TRACE_FEXIT``,``fexit.s+``,Yes
+``BPF_PROG_TYPE_EXT``,,``freplace+``,
+``BPF_PROG_TYPE_LSM``,``BPF_LSM_MAC``,``lsm+``,
+``BPF_PROG_TYPE_LSM``,``BPF_LSM_MAC``,``lsm.s+``,Yes
+``BPF_PROG_TYPE_LSM``,``BPF_LSM_CGROUP``,``lsm_cgroup+``,
+``BPF_PROG_TYPE_TRACING``,``BPF_TRACE_ITER``,``iter+``,
+``BPF_PROG_TYPE_TRACING``,``BPF_TRACE_ITER``,``iter.s+``,Yes
+``BPF_PROG_TYPE_SYSCALL``,,``syscall``,Yes
+``BPF_PROG_TYPE_XDP``,``BPF_XDP_DEVMAP``,``xdp.frags/devmap``,
+``BPF_PROG_TYPE_XDP``,``BPF_XDP_DEVMAP``,``xdp/devmap``,
+``BPF_PROG_TYPE_XDP``,``BPF_XDP_CPUMAP``,``xdp.frags/cpumap``,
+``BPF_PROG_TYPE_XDP``,``BPF_XDP_CPUMAP``,``xdp/cpumap``,
+``BPF_PROG_TYPE_XDP``,``BPF_XDP``,``xdp.frags``,
+``BPF_PROG_TYPE_XDP``,``BPF_XDP``,``xdp``,
+``BPF_PROG_TYPE_PERF_EVENT``,,``perf_event``,
+``BPF_PROG_TYPE_LWT_IN``,,``lwt_in``,
+``BPF_PROG_TYPE_LWT_OUT``,,``lwt_out``,
+``BPF_PROG_TYPE_LWT_XMIT``,,``lwt_xmit``,
+``BPF_PROG_TYPE_LWT_SEG6LOCAL``,,``lwt_seg6local``,
+``BPF_PROG_TYPE_SOCK_OPS``,``BPF_CGROUP_SOCK_OPS``,``sockops``,
+``BPF_PROG_TYPE_SK_SKB``,``BPF_SK_SKB_STREAM_PARSER``,``sk_skb/stream_parser``,
+``BPF_PROG_TYPE_SK_SKB``,``BPF_SK_SKB_STREAM_VERDICT``,``sk_skb/stream_verdict``,
+``BPF_PROG_TYPE_SK_SKB``,,``sk_skb``,
+``BPF_PROG_TYPE_SK_MSG``,``BPF_SK_MSG_VERDICT``,``sk_msg``,
+``BPF_PROG_TYPE_LIRC_MODE2``,``BPF_LIRC_MODE2``,``lirc_mode2``,
+``BPF_PROG_TYPE_FLOW_DISSECTOR``,``BPF_FLOW_DISSECTOR``,``flow_dissector``,
+``BPF_PROG_TYPE_CGROUP_SKB``,``BPF_CGROUP_INET_INGRESS``,``cgroup_skb/ingress``,
+``BPF_PROG_TYPE_CGROUP_SKB``,``BPF_CGROUP_INET_EGRESS``,``cgroup_skb/egress``,
+``BPF_PROG_TYPE_CGROUP_SKB``,,``cgroup/skb``,
+``BPF_PROG_TYPE_CGROUP_SOCK``,``BPF_CGROUP_INET_SOCK_CREATE``,``cgroup/sock_create``,
+``BPF_PROG_TYPE_CGROUP_SOCK``,``BPF_CGROUP_INET_SOCK_RELEASE``,``cgroup/sock_release``,
+``BPF_PROG_TYPE_CGROUP_SOCK``,``BPF_CGROUP_INET_SOCK_CREATE``,``cgroup/sock``,
+``BPF_PROG_TYPE_CGROUP_SOCK``,``BPF_CGROUP_INET4_POST_BIND``,``cgroup/post_bind4``,
+``BPF_PROG_TYPE_CGROUP_SOCK``,``BPF_CGROUP_INET6_POST_BIND``,``cgroup/post_bind6``,
+``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_INET4_BIND``,``cgroup/bind4``,
+``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_INET6_BIND``,``cgroup/bind6``,
+``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_INET4_CONNECT``,``cgroup/connect4``,
+``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_INET6_CONNECT``,``cgroup/connect6``,
+``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_UDP4_SENDMSG``,``cgroup/sendmsg4``,
+``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_UDP6_SENDMSG``,``cgroup/sendmsg6``,
+``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_UDP4_RECVMSG``,``cgroup/recvmsg4``,
+``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_UDP6_RECVMSG``,``cgroup/recvmsg6``,
+``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_INET4_GETPEERNAME``,``cgroup/getpeername4``,
+``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_INET6_GETPEERNAME``,``cgroup/getpeername6``,
+``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_INET4_GETSOCKNAME``,``cgroup/getsockname4``,
+``BPF_PROG_TYPE_CGROUP_SOCK_ADDR``,``BPF_CGROUP_INET6_GETSOCKNAME``,``cgroup/getsockname6``,
+``BPF_PROG_TYPE_CGROUP_SYSCTL``,``BPF_CGROUP_SYSCTL``,``cgroup/sysctl``,
+``BPF_PROG_TYPE_CGROUP_SOCKOPT``,``BPF_CGROUP_GETSOCKOPT``,``cgroup/getsockopt``,
+``BPF_PROG_TYPE_CGROUP_SOCKOPT``,``BPF_CGROUP_SETSOCKOPT``,``cgroup/setsockopt``,
+``BPF_PROG_TYPE_CGROUP_DEVICE``,``BPF_CGROUP_DEVICE``,``cgroup/dev``,
+``BPF_PROG_TYPE_STRUCT_OPS``,,``struct_ops+``,
+``BPF_PROG_TYPE_SK_LOOKUP``,``BPF_SK_LOOKUP``,``sk_lookup``,
diff --git a/Documentation/bpf/programs.rst b/Documentation/bpf/programs.rst
index 620eb667ac7a..71448fe0b955 100644
--- a/Documentation/bpf/programs.rst
+++ b/Documentation/bpf/programs.rst
@@ -7,3 +7,18 @@ Program Types
    :glob:
 
    prog_*
+
+Program Types and libbpf
+========================
+
+The table below lists the program types, their attach types where relevant and the ELF section
+names supported by libbpf for them. The ELF section names follow these rules:
+
+- ``type`` is an exact match, e.g. ``SEC("socket")``
+- ``type+`` means it can be either exact ``SEC("type")`` or well-formed ``SEC("type/extras")``
+  with a ‘``/``’ separator, e.g. ``SEC("tracepoint/syscalls/sys_enter_open")``
+
+.. csv-table:: Program Types and Their ELF Section Names
+   :file: program_types.csv
+   :widths: 40 30 20 10
+   :header-rows: 1
diff --git a/scripts/gen-bpf-progtypes.sh b/scripts/gen-bpf-progtypes.sh
new file mode 100755
index 000000000000..fb9650bd5c1b
--- /dev/null
+++ b/scripts/gen-bpf-progtypes.sh
@@ -0,0 +1,21 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) Red Hat.
+#
+# Generate a .csv table of BPF program types
+
+if ! [ -d "tools/lib/bpf" -a -d "Documentation" ]; then
+    echo "Run from top level of kernel tree"
+    exit 1
+fi
+
+awk -F'[",[:space:]]+' \
+    'BEGIN { print "Program Type,Attach Type,ELF Section Name,Sleepable" }
+    /SEC_DEF\(\"/ && !/SEC_DEPRECATED/ {
+    type = "``BPF_PROG_TYPE_" $4 "``"
+    attach = index($5, "0") ? "" : "``" $5 "``";
+    section = "``" $3 "``"
+    sleepable = index($0, "SEC_SLEEPABLE") ? "Yes" : "";
+    print type "," attach "," section "," sleepable }' \
+tools/lib/bpf/libbpf.c > Documentation/bpf/program_types.csv
-- 
2.35.1

