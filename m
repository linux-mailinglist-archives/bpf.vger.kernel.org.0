Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69C0581AC2
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 22:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiGZULn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 16:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiGZULm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 16:11:42 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC07232477
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 13:11:41 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 56C6224002C
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 22:11:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1658866300; bh=VV0yRDiZjhUvH758oRG2wx5h4A/N+VkahJhn+w80DTY=;
        h=From:To:Cc:Subject:Date:From;
        b=BeVk6lIGxysfM/U7V55hk5sv/6U1uXI+dFrc4Jq3Aa1Ik/9mY4pLnGTeAxIPPm9iK
         F6VJyNCf/jKA+2WrU6AQhaYnE1C0uo5M1EzdDTI4/QiLBDu6jH2gHCrPd0dAUyOG/Z
         RmJ5OVzetmvW1xCkATqGngI/eKrPGo3//w6wT96K/ZQ0dXoEB3+M0zBdfp90C+FyqY
         JsXcDQm1cEgdD/zVQLAsXhdPMENLaOjZWHLoIABhKfHwMS6Y19qbMuLCGGlHBVsyUp
         VF+RkAVyzG8vOf82Obxua7smUPiEZxct4R3GSZ+rH81vyeN9kn/siqlhkX54caBnJv
         XH9X9GQ7QwoPw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Lsp2z45Ryz6tm6;
        Tue, 26 Jul 2022 22:11:39 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     mykolal@fb.com, Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v3 1/3] selftests/bpf: Sort configuration
Date:   Tue, 26 Jul 2022 20:11:24 +0000
Message-Id: <20220726201126.2486635-2-deso@posteo.net>
In-Reply-To: <20220726201126.2486635-1-deso@posteo.net>
References: <20220726201126.2486635-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Martin KaFai Lau <kafai@fb.com>
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

