Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00672603267
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 20:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiJRS0n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 14:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJRS0m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 14:26:42 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F84CB7EB;
        Tue, 18 Oct 2022 11:26:40 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1okrIT-0002Yh-EO; Tue, 18 Oct 2022 20:26:37 +0200
Date:   Tue, 18 Oct 2022 20:26:37 +0200
From:   Florian Westphal <fw@strlen.de>
To:     bpf@vger.kernel.org
Cc:     netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: netfilter+bpf road ahead
Message-ID: <20221018182637.GA4631@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

This is a summary of what Alexei Starovoitov and myself talked about
in our meeting in Zurich.  Most of this was written by Alexei, with
minor edits and additions from me.

- Alexei and Florian met in Zurich to discuss netfilter and bpf.
  netfilter (core, ipables, ebtables, nftables ...) all take heavy
  performance hits on retpoline enabled kernels due to
  indiscriminate use of indirect calls.
  Over the years nftables grew a large number of workarounds to keep
acceptable performance for common case.
  In few places indirect calls were replaced with large if (tgt ==
&fn1) fn1(); else if (tgt == &fn2) fn2(); else ...
  [link1](https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/net/netfilter/nf_tables_core.c#n256)
  [link2](https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/net/netfilter/nf_tables_core.c#n198)
  In other place a set of giant switch statements were used.
  [link](https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/net/netfilter/nft_meta.c#n309)
  The 3rd bottleneck couldn't be done with either if-s or switch and
Florian proposed to accelerate it with [generated bpf
code](https://lore.kernel.org/bpf/20221005141309.31758-1-fw@strlen.de/).
  The NFT VM wasn't flexible enough either. Despite large engineering
investment it still lacks some abilities that are needed for feature
parity with iptables.
RHEL and Fedora changed the iptables default to iptables-nft, but
iptables-nft implements feature parity with ipables by calling into the
x_tables modules.  This needs two indirect calls for each match
(call to nft_compat expression, then call to the xtables target or
 match function).
iptables-nft can be changed gradually to replace matches with nft-native
expressions to avoid this.
But in some cases the modules/targets have a feature that
cannot be emulated with the existing nft vm.

One example is ability to only store parts of skb->mark.
The nft grammar would allow to do:

ct mark set (ct mark & 0xffffff00) | (meta mark & 0xff)

... which would stash the lower 8bit of skb->mark while keeping
the upper 24 bits of the connmark intact.

But neither frontend or backend (kernel) can handle it, because it needs
support for:

  regA = regB | regC

nf_tables only allows
  regA = regB BINOP VALUE.

In the example given above, the problem is the right hand side
of the OR -- its not a constant value.

ct mark set (ct mark & 0xffffff00) | 1

... would work.

Patches that allow two source registers are floating around on mailing
list but have not been applied so far.

Some customers use xt_bpf with either classic_bf or ebpf, so Florian proposed
nft->ebpf, but Daniel Borkmann and Alexei argued against.
The key promise of NFT was flexible packet parsing. Turns out that there
are users that would benefit from programmable parsing, e.g. to extract
sni from certificates or hostnames from DNS replies.

After many hours of brainstorming we came up with the plan:
 - cleanup and land bpf generator to accelerate one of nf bottlenecks.
 - introduce new stable BPF_PROG_TYPE_NETFILTER. Alexeis preference
was to avoid new prog types and use unstable hooks,
but iptables are scoped by network namespaces. We could use
xdp_dispatcher-like generator to demux bpf prog per netns,
but netns removal automatically flushes iptable rules, so netns
would need to know about this bpf dispatcher and unload
bpf-netfilter prog. At that point the amount of user facing
"implementation details" becomes so large that calling
such hooks "unstable" isn't realistic.
- return values from this prog type will be existing netfilter codes
except NF_STOLEN.
- allow BPF_PROG_TYPE_NETFILTER to attach to all netfilter/iptables
hooks where program context will be uapi 'struct bpf_netfilter'
At that point the stable part of the interface ends. From input
context the program will be able to access skb, socket, nents, netdev
pointers and read them with the help of CO-RE and BTF.
- attach uapi will be done either with bpf_link and FD or with
netlink using a tuple (netns, nf_family, nf_hook, bpf_prog)
- introduce a set of kfuncs to access conntrack, nat, nft sets and maps,
nf_queue and so on.
- in addition to existing two iptables rules converters in user
space (iptables->nft text-to-text and iptables->nft text-to-netlink)
the latter will be augmented to generate BPF_PROG_TYPE_NETFILTER
prog as well.  bpf-aware nft frontend would pass both the nft instructions
(for netfilter monitor and netlink query purposes) and a bpf_prog, but will execute
bpf program in run-time.
The bpf prog doesn't have to have 100% feature parity. It can fall
back to NFT core for not-yet-implemented expressions.
- nft_set_pipapo.c is an efficient classification map for arbitrary ranges
represented as 'nft set' from uapi pov.
bpf side might interface to it directly via kfuncs.
- lots of details to be figured out, but if netfilter core folks
agree to this plan it will be one of the most exciting
projects in the linux networking. iptables will see significant
performance boost and major feature addition.
Blending bpf and netfilter worlds would be fantastic.

Florian will rework the last RFC patchset and will re-run
benchmarks with both RETPOLINE=n|y, results should be available
mid-november-ish.
