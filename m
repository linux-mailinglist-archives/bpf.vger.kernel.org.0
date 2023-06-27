Return-Path: <bpf+bounces-3575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733ED73FFFB
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 17:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F26928101A
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 15:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F69C19BB0;
	Tue, 27 Jun 2023 15:44:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5CD182AB;
	Tue, 27 Jun 2023 15:44:47 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34E4E68;
	Tue, 27 Jun 2023 08:44:45 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qEArv-00056u-Ur; Tue, 27 Jun 2023 17:44:39 +0200
Date: Tue, 27 Jun 2023 17:44:39 +0200
From: Florian Westphal <fw@strlen.de>
To: Toke =?iso-8859-15?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
	fw@strlen.de, daniel@iogearbox.net, dsahern@kernel.org
Subject: Re: [PATCH bpf-next 0/7] Support defragmenting IPv(4|6) packets in
 BPF
Message-ID: <20230627154439.GA18285@breakpoint.cc>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
 <874jmthtiu.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874jmthtiu.fsf@toke.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> > The basic idea is we bump a refcnt on the netfilter defrag module and
> > then run the bpf prog after the defrag module runs. This allows bpf
> > progs to transparently see full, reassembled packets. The nice thing
> > about this is that progs don't have to carry around logic to detect
> > fragments.
> 
> One high-level comment after glancing through the series: Instead of
> allocating a flag specifically for the defrag module, why not support
> loading (and holding) arbitrary netfilter modules in the UAPI?

How would that work/look like?

defrag (and conntrack) need special handling because loading these
modules has no effect on the datapath.

Traditionally, yes, loading was enough, but now with netns being
ubiquitous we don't want these to get enabled unless needed.

Ignoring bpf, this happens when user adds nftables/iptables rules
that check for conntrack state, use some form of NAT or use e.g. tproxy.

For bpf a flag during link attachment seemed like the best way
to go.

At the moment I only see two flags for this, namely
"need defrag" and "need conntrack".

For conntrack, we MIGHT be able to not need a flag but
maybe verifier could "guess" based on kfuncs used.

But for defrag, I don't think its good to add a dummy do-nothing
kfunc just for expressing the dependency on bpf prog side.

