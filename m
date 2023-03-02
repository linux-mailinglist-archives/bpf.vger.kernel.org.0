Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96596A87E1
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 18:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjCBR2Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 12:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCBR2O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 12:28:14 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD25231F6;
        Thu,  2 Mar 2023 09:28:11 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1pXmiv-0002bd-PC; Thu, 02 Mar 2023 18:28:09 +0100
From:   Florian Westphal <fw@strlen.de>
To:     bpf@vger.kernel.org
Cc:     <netfilter-devel@vger.kernel.org>, Florian Westphal <fw@strlen.de>
Subject: [PATCH RFC v2 bpf-next 0/3] bpf: add netfilter program type
Date:   Thu,  2 Mar 2023 18:27:54 +0100
Message-Id: <20230302172757.9548-1-fw@strlen.de>
X-Mailer: git-send-email 2.39.2
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

For this the most relevant parts for registering a netfilter
hook via the in-kernel api are exposed to userspace via bpf_link.

The new program type is 'tracing style' and assumes skb dynptrs are used
rather than 'direct packet access'.

With this its possible to build a small test program such as:

#include "vmlinux.h"

extern int bpf_dynptr_from_skb(struct __sk_buff *skb, __u64 flags,
                               struct bpf_dynptr *ptr__uninit) __ksym;
extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, uint32_t offset,
                                   void *buffer, uint32_t buffer__sz) __ksym;

SEC("netfilter")
int nf_test(struct bpf_nf_ctx *ctx)
{
	struct nf_hook_state *state = ctx->state;
	struct sk_buff *skb = ctx->skb;
	const struct iphdr *iph, _iph;
	const struct tcphdr *th, _th;
	struct bpf_dynptr ptr;

	if (bpf_dynptr_from_skb(skb, 0, &ptr))
		return NF_DROP;

	iph = bpf_dynptr_slice(&ptr, 0, &_iph, sizeof(_iph));
	if (!iph)
		return NF_DROP;

	th = bpf_dynptr_slice(&ptr, iph->ihl << 2, &_th, sizeof(_th));
	if (!th)
		return NF_DROP;

	bpf_printk("accept %x:%d->%x:%d, hook %d ifin %d\n", iph->saddr, bpf_ntohs(th->source), iph->daddr, bpf_ntohs(th->dest), state->hook, state->in->ifindex);
        return NF_ACCEPT;
}

(output can be observed via /sys/kernel/tracing/trace_pipe).

At this point I think its fairly complete.  Known problems are:
- no test cases, I will look into this.  Might take some time
  though because I might have to extend libbpf first.
- nfnetlink_hook needs minor work so that it can dump the bpf
  program id. As-is, userspace could see that a bpf program
  is attached to e.g. forward and output, but it cannot tell
  which program.  This is fairly simple and doesn't need changes
  on bpf side.

I will work on these address those two next unless anyone spots
a fundamental issue with this rfc set.

Florian Westphal (3):
  bpf: add bpf_link support for BPF_NETFILTER programs
  libbpf: sync header file, add nf prog section name
  bpf: minimal support for programs hooked into netfilter framework

 include/linux/bpf_types.h           |   4 +
 include/linux/netfilter.h           |   1 +
 include/net/netfilter/nf_hook_bpf.h |   8 ++
 include/uapi/linux/bpf.h            |  12 ++
 kernel/bpf/btf.c                    |   5 +
 kernel/bpf/syscall.c                |   6 +
 kernel/bpf/verifier.c               |   3 +
 net/netfilter/Kconfig               |   3 +
 net/netfilter/Makefile              |   1 +
 net/netfilter/nf_bpf_link.c         | 192 ++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h      |  12 ++
 tools/lib/bpf/libbpf.c              |   1 +
 12 files changed, 248 insertions(+)
 create mode 100644 include/net/netfilter/nf_hook_bpf.h
 create mode 100644 net/netfilter/nf_bpf_link.c
-- 
2.39.2

