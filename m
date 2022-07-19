Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3EC57A5FD
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 20:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbiGSSDA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 14:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239337AbiGSSC7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 14:02:59 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D70154CA3
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 11:02:57 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 65CC1240127
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 20:02:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1658253776; bh=etPsYuHNmU8PbhQqIO5IFE8zz9rdpu5xXifZMS4qbfs=;
        h=From:To:Cc:Subject:Date:From;
        b=mwJMYoY9z38YM6LvHvA1mMcAraxHLrpq9OL3XFAvtdoVGjUdoYYELJ/VD1jDjidjI
         sPfasiGOHpqDL3Y5MrLsICXrFMEAWW3I0xV+Wa6+GmtNTByBh1bpd6nd+uHCVeM7x4
         f/kgtQB07ZLtCy0AbEr5y1vfdJQu9j7U+eUlFpLOeV9x8RHed+oJuYPMBCUDb3w29h
         TnQeulKEissSesHOsEyNKd0LJTpPXCiMPX572SSuoc0bxIszqvXsz8FE7sDr8ZoPDX
         Sk2yBso1S15YrrN6tgCUKF0ObsvOspQp1cFLojeRTrCGJHl+0LoXMVuf5E3xM3nAAo
         vHFagWgwRBprg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LnRWg4SqXz9rxG;
        Tue, 19 Jul 2022 20:02:55 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     mykolal@fb.com
Subject: [PATCH bpf-next v2 1/3] selftests/bpf: Sort configuration
Date:   Tue, 19 Jul 2022 18:02:49 +0000
Message-Id: <20220719180251.836588-2-deso@posteo.net>
In-Reply-To: <20220719180251.836588-1-deso@posteo.net>
References: <20220719180251.836588-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change makes sure to sort the existing minimal kernel configuration
containing options required for running BPF selftests alphabetically.
Doing so will make it easier to diff it against other configurations,
which in turn helps with maintaining disjunct config files that build on
top of each other. It also helped identify the CONFIG_IPV6_GRE being set
twice and removes one of the occurrences.
Lastly, we change NET_CLS_BPF from 'm' to 'y'. Having this option as 'm'
will cause failures of the btf_skc_cls_ingress selftest.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/testing/selftests/bpf/config | 101 ++++++++++++++---------------
 1 file changed, 50 insertions(+), 51 deletions(-)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index c05904d..fabf0c 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -1,65 +1,64 @@
+CONFIG_BLK_DEV_LOOP=y
 CONFIG_BPF=y
-CONFIG_BPF_SYSCALL=y
-CONFIG_NET_CLS_BPF=m
 CONFIG_BPF_EVENTS=y
-CONFIG_TEST_BPF=m
+CONFIG_BPF_JIT=y
+CONFIG_BPF_LIRC_MODE2=y
+CONFIG_BPF_LSM=y
+CONFIG_BPF_STREAM_PARSER=y
+CONFIG_BPF_SYSCALL=y
 CONFIG_CGROUP_BPF=y
-CONFIG_NETDEVSIM=m
-CONFIG_NET_CLS_ACT=y
-CONFIG_NET_SCHED=y
-CONFIG_NET_SCH_INGRESS=y
-CONFIG_NET_IPIP=y
-CONFIG_IPV6=y
-CONFIG_NET_IPGRE_DEMUX=y
-CONFIG_NET_IPGRE=y
-CONFIG_IPV6_GRE=y
-CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_HMAC=m
 CONFIG_CRYPTO_SHA256=m
-CONFIG_VXLAN=y
-CONFIG_GENEVE=y
-CONFIG_NET_CLS_FLOWER=m
-CONFIG_LWTUNNEL=y
-CONFIG_BPF_STREAM_PARSER=y
-CONFIG_XDP_SOCKETS=y
+CONFIG_CRYPTO_USER_API_HASH=m
+CONFIG_DYNAMIC_FTRACE=y
+CONFIG_FPROBE=y
 CONFIG_FTRACE_SYSCALLS=y
-CONFIG_IPV6_TUNNEL=y
-CONFIG_IPV6_GRE=y
-CONFIG_IPV6_SEG6_BPF=y
-CONFIG_NET_FOU=m
-CONFIG_NET_FOU_IP_TUNNELS=y
+CONFIG_FUNCTION_TRACER=y
+CONFIG_GENEVE=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_IMA=y
+CONFIG_IMA_READ_POLICY=y
+CONFIG_IMA_WRITE_POLICY=y
+CONFIG_IP_NF_FILTER=y
+CONFIG_IP_NF_RAW=y
+CONFIG_IP_NF_TARGET_SYNPROXY=y
+CONFIG_IPV6=y
 CONFIG_IPV6_FOU=m
 CONFIG_IPV6_FOU_TUNNEL=m
-CONFIG_MPLS=y
-CONFIG_NET_MPLS_GSO=m
-CONFIG_MPLS_ROUTING=m
-CONFIG_MPLS_IPTUNNEL=m
+CONFIG_IPV6_GRE=y
+CONFIG_IPV6_SEG6_BPF=y
 CONFIG_IPV6_SIT=m
-CONFIG_BPF_JIT=y
-CONFIG_BPF_LSM=y
-CONFIG_SECURITY=y
-CONFIG_RC_CORE=y
+CONFIG_IPV6_TUNNEL=y
 CONFIG_LIRC=y
-CONFIG_BPF_LIRC_MODE2=y
-CONFIG_IMA=y
-CONFIG_SECURITYFS=y
-CONFIG_IMA_WRITE_POLICY=y
-CONFIG_IMA_READ_POLICY=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_FUNCTION_TRACER=y
-CONFIG_DYNAMIC_FTRACE=y
+CONFIG_LWTUNNEL=y
+CONFIG_MPLS=y
+CONFIG_MPLS_IPTUNNEL=m
+CONFIG_MPLS_ROUTING=m
+CONFIG_MPTCP=y
+CONFIG_NET_CLS_ACT=y
+CONFIG_NET_CLS_BPF=y
+CONFIG_NET_CLS_FLOWER=m
+CONFIG_NET_FOU=m
+CONFIG_NET_FOU_IP_TUNNELS=y
+CONFIG_NET_IPGRE=y
+CONFIG_NET_IPGRE_DEMUX=y
+CONFIG_NET_IPIP=y
+CONFIG_NET_MPLS_GSO=m
+CONFIG_NET_SCH_INGRESS=y
+CONFIG_NET_SCHED=y
+CONFIG_NETDEVSIM=m
 CONFIG_NETFILTER=y
+CONFIG_NETFILTER_SYNPROXY=y
+CONFIG_NETFILTER_XT_MATCH_STATE=y
+CONFIG_NETFILTER_XT_TARGET_CT=y
+CONFIG_NF_CONNTRACK=y
 CONFIG_NF_DEFRAG_IPV4=y
 CONFIG_NF_DEFRAG_IPV6=y
-CONFIG_NF_CONNTRACK=y
+CONFIG_RC_CORE=y
+CONFIG_SECURITY=y
+CONFIG_SECURITYFS=y
+CONFIG_TEST_BPF=m
 CONFIG_USERFAULTFD=y
-CONFIG_FPROBE=y
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_MPTCP=y
-CONFIG_NETFILTER_SYNPROXY=y
-CONFIG_NETFILTER_XT_TARGET_CT=y
-CONFIG_NETFILTER_XT_MATCH_STATE=y
-CONFIG_IP_NF_FILTER=y
-CONFIG_IP_NF_TARGET_SYNPROXY=y
-CONFIG_IP_NF_RAW=y
+CONFIG_VXLAN=y
+CONFIG_XDP_SOCKETS=y
-- 
2.30.2

