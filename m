Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E49768F2B7
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 17:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjBHQDv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 11:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjBHQDt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 11:03:49 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387B046D56;
        Wed,  8 Feb 2023 08:03:25 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1pPmuo-0006gm-0Z; Wed, 08 Feb 2023 17:03:22 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <bpf@vger.kernel.org>
Cc:     <netfilter-devel@vger.kernel.org>, Florian Westphal <fw@strlen.de>
Subject: [RFC nf-next 0/3] bpf, netfilter: minimal support for bpf progs
Date:   Wed,  8 Feb 2023 17:03:04 +0100
Message-Id: <20230208160307.27534-1-fw@strlen.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add minimal support to hook bpf programs to netfilter hooks,
e.g. PREROUTING or FORWARD.

Hooking is currently possible for all supprted protocols, i.e.
arp, bridge, ip, ip6 and inet (both ipv4/ipv6) pseudo-family.

For this the most relevant parts for registering a netfilter
hook via the in-kernel api are exposed to userspace via bpf_link.

With this its possible to build a small test program such as:

SEC("netfilter")
int nf_test(struct __sk_buff *skb)
{
	const struct iphdr *iph = (void *)skb->data;

	if (iph + 1 < skb->data_end)
		bpf_printk("%x,%x\n", iph->saddr, iph->daddr);
	else
		return NF_DROP;

        return NF_ACCEPT;
}

(output can be observed via /sys/kernel/tracing/trace_pipe).

The prototype is wrong, future versions will instead expose
'struct bpf_nf_ctx' via btf, so programs will have to use

SEC("netfilter")
int nf_test(struct bpf_nf_ctx *ctx)
{
	struct sk_buff *skb = ctx->skb; ...


I will work on this next but thought it was better to send
a current snapshot.

This series no longer depends on the proposed in-kernel
nf_hook_slow bpf translator.

Feedback welcome.

Florian Westphal (3):
  bpf: add bpf_link support for BPF_NETFILTER programs
  libbpf: sync header file, add nf prog section name
  bpf: minimal support for programs hooked into netfilter framework

 include/linux/bpf_types.h           |   4 +
 include/linux/netfilter.h           |   1 +
 include/net/netfilter/nf_hook_bpf.h |  10 ++
 include/uapi/linux/bpf.h            |  13 ++
 kernel/bpf/btf.c                    |   3 +
 kernel/bpf/syscall.c                |   7 +
 kernel/bpf/verifier.c               |   3 +
 net/netfilter/Kconfig               |   3 +
 net/netfilter/Makefile              |   1 +
 net/netfilter/nf_bpf_link.c         | 242 ++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h      |  13 ++
 tools/lib/bpf/libbpf.c              |   1 +
 12 files changed, 301 insertions(+)
 create mode 100644 include/net/netfilter/nf_hook_bpf.h
 create mode 100644 net/netfilter/nf_bpf_link.c

-- 
2.39.1

