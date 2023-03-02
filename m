Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1F46A89FE
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 21:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCBUEm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 15:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCBUEl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 15:04:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7385E12842;
        Thu,  2 Mar 2023 12:04:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4FC7B8136A;
        Thu,  2 Mar 2023 19:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDADC433D2;
        Thu,  2 Mar 2023 19:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677787176;
        bh=p5Hsu6hru7ieYF+LxBOIzWArD7/DClISDg/NrbauDgA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DSh3MwADcSTj1p/yW9DCRrubH3dJI1E4CZ5DfhctOZ/dp++WyJejexClg2x61Ebz6
         GUyd/miJuU3qEyZT4FRcI+pyiQR29xNv4F06UpAxl6Ki0Pa7caX1BZnoP1OCqaXmMa
         aGVOVpd6WJe3fq0btfvHXwEm+z5fo+0zpXTab833K+GZ4uBLpJU9K0v/8v9b0pXGAd
         rh7Xu1DxgOs3tlCQNL/4DkUdtER0aoemwai1o/moUQwRn0XpZLN6FA5ZBP4iMHdpo5
         9fTVOTGONW3TsyI7cVm2Qwhb9aRw89NoU8U5rNXXgJlVecTLg+HbnybQOlztwZfQlT
         /IPGip3dj54Ng==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 473D4976267; Thu,  2 Mar 2023 20:59:34 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Florian Westphal <fw@strlen.de>, bpf@vger.kernel.org
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH RFC v2 bpf-next 0/3] bpf: add netfilter program type
In-Reply-To: <20230302172757.9548-1-fw@strlen.de>
References: <20230302172757.9548-1-fw@strlen.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 02 Mar 2023 20:59:34 +0100
Message-ID: <87r0u6exg9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Florian Westphal <fw@strlen.de> writes:

> Add minimal support to hook bpf programs to netfilter hooks,
> e.g. PREROUTING or FORWARD.
>
> For this the most relevant parts for registering a netfilter
> hook via the in-kernel api are exposed to userspace via bpf_link.
>
> The new program type is 'tracing style' and assumes skb dynptrs are used
> rather than 'direct packet access'.
>
> With this its possible to build a small test program such as:
>
> #include "vmlinux.h"
>
> extern int bpf_dynptr_from_skb(struct __sk_buff *skb, __u64 flags,
>                                struct bpf_dynptr *ptr__uninit) __ksym;
> extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, uint32_t offset,
>                                    void *buffer, uint32_t buffer__sz) __ksym;
>
> SEC("netfilter")
> int nf_test(struct bpf_nf_ctx *ctx)
> {
> 	struct nf_hook_state *state = ctx->state;
> 	struct sk_buff *skb = ctx->skb;
> 	const struct iphdr *iph, _iph;
> 	const struct tcphdr *th, _th;
> 	struct bpf_dynptr ptr;
>
> 	if (bpf_dynptr_from_skb(skb, 0, &ptr))
> 		return NF_DROP;
>
> 	iph = bpf_dynptr_slice(&ptr, 0, &_iph, sizeof(_iph));
> 	if (!iph)
> 		return NF_DROP;
>
> 	th = bpf_dynptr_slice(&ptr, iph->ihl << 2, &_th, sizeof(_th));
> 	if (!th)
> 		return NF_DROP;
>
> 	bpf_printk("accept %x:%d->%x:%d, hook %d ifin %d\n", iph->saddr, bpf_ntohs(th->source), iph->daddr, bpf_ntohs(th->dest), state->hook, state->in->ifindex);
>         return NF_ACCEPT;
> }
>
> (output can be observed via /sys/kernel/tracing/trace_pipe).
>
> At this point I think its fairly complete.  Known problems are:
> - no test cases, I will look into this.  Might take some time
>   though because I might have to extend libbpf first.
> - nfnetlink_hook needs minor work so that it can dump the bpf
>   program id. As-is, userspace could see that a bpf program
>   is attached to e.g. forward and output, but it cannot tell
>   which program.  This is fairly simple and doesn't need changes
>   on bpf side.
>
> I will work on these address those two next unless anyone spots
> a fundamental issue with this rfc set.

I only spotted one small nit on the third patch, which I replied to
separately. Otherwise I think it looks pretty good, in fact I'm amazed
at how little code it takes to enable this; nice work! :)

-Toke
