Return-Path: <bpf+bounces-3732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D231374273B
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 15:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD75280CB6
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 13:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BE71096A;
	Thu, 29 Jun 2023 13:21:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDAC258D;
	Thu, 29 Jun 2023 13:21:49 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4258F2707;
	Thu, 29 Jun 2023 06:21:47 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qEraf-0006iS-KY; Thu, 29 Jun 2023 15:21:41 +0200
Date: Thu, 29 Jun 2023 15:21:41 +0200
From: Florian Westphal <fw@strlen.de>
To: Toke =?iso-8859-15?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, Daniel Xu <dxu@dxuuu.xyz>,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
	daniel@iogearbox.net, dsahern@kernel.org
Subject: Re: [PATCH bpf-next 0/7] Support defragmenting IPv(4|6) packets in
 BPF
Message-ID: <20230629132141.GA10165@breakpoint.cc>
References: <cover.1687819413.git.dxu@dxuuu.xyz>
 <874jmthtiu.fsf@toke.dk>
 <20230627154439.GA18285@breakpoint.cc>
 <87o7kyfoqf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o7kyfoqf.fsf@toke.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> Florian Westphal <fw@strlen.de> writes:
> > For bpf a flag during link attachment seemed like the best way
> > to go.
> 
> Right, I wasn't disputing that having a flag to load a module was a good
> idea. On the contrary, I was thinking we'd need many more of these
> if/when BPF wants to take advantage of more netfilter code. Say, if a
> BPF module wants to call into TPROXY, that module would also need go be
> loaded and kept around, no?

That seems to be a different topic that has nothing to do with
either bpf_link or netfilter?

If the program calls into say, TPROXY, then I'd expect that this needs
to be handled via kfuncs, no? Or if I misunderstand, what do you mean
by "call into TPROXY"?

And if so, thats already handled at bpf_prog load time, not
at link creation time, or do I miss something here?

AFAIU, if prog uses such kfuncs, verifier will grab needed module ref
and if module isn't loaded the kfuncs won't be found and program load
fails.

> I was thinking something along the lines of just having a field
> 'netfilter_modules[]' where userspace could put an arbitrary number of
> module names into, and we'd load all of them and put a ref into the
> bpf_link.

Why?  I fail to understand the connection between bpf_link, netfilter
and modules.  What makes netfilter so special that we need such a
module array, and what does that have to do with bpf_link interface?

> In principle, we could just have that be a string array f
> module names, but that's probably a bit cumbersome (and, well, building
> a generic module loader interface into the bpf_like API is not
> desirable either). But maybe with an explicit ENUM?

What functionality does that provide? I can't think of a single module
where this functionality is needed.

Either we're talking about future kfuncs, then, as far as i understand
how kfuncs work, this is handled at bpf_prog load time, not when the
bpf_link is created.

Or we are talking about implicit dependencies, where program doesn't
call function X but needs functionality handled earlier in the pipeline?

The only two instances I know where this is the case for netfilter
is defrag + conntrack.

> > For conntrack, we MIGHT be able to not need a flag but
> > maybe verifier could "guess" based on kfuncs used.
> 
> If the verifier can just identify the modules from the kfuncs and do the
> whole thing automatically, that would of course be even better from an
> ease-of-use PoV. Not sure what that would take, though? I seem to recall
> having discussions around these lines before that fell down on various
> points.

AFAICS the conntrack kfuncs are wired to nf_conntrack already, so I
would expect that the module has to be loaded already for the verifier
to accept the program.

Those kfuncs are not yet exposed to NETFILTER program types.
Once they are, all that would be needed is for the netfilter bpf_link
to be able tp detect that the prog is calling into those kfuncs, and
then make the needed register/unregister calls to enable the conntrack
hooks.

Wheter thats better than using an explicit "please turn on conntrack for
me", I don't know.  Perhaps future bpf programs could access skb->_nfct
directly without kfuncs so I'd say the flag is a better approach
from an uapi point of view.

