Return-Path: <bpf+bounces-31671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B30EA9013E4
	for <lists+bpf@lfdr.de>; Sun,  9 Jun 2024 00:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35091C20C14
	for <lists+bpf@lfdr.de>; Sat,  8 Jun 2024 22:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B512538DC3;
	Sat,  8 Jun 2024 22:24:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E261C698;
	Sat,  8 Jun 2024 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717885468; cv=none; b=q2IZ7LnxbkMzJM15au5mecAIddp6ei/BOL36oHiiUTbuBgCwQ0+4zJ5MguIZVgygONK/E3rEf3UvTjV7s2F2VIQ+puyR80fnLohlOWbykmhCiHic0vJHKVhaUzArUvyJjlvrm1x5RZw2v9/oJGlfomHOtj0/bIS3gSARij0w5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717885468; c=relaxed/simple;
	bh=v8nfbbSC3BTfCfb5rVRK0g13gnFm1X2cjki+n2bljg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClFdDSoqt3G8lcVN6fq6wKltRGzXqVIcYyecj6QKO7eeFDaEiU7+rUun0YIKuJEdxVsddsGlKe4wDiJMeEtatETX4Ry8V+G7G+TVD/u/CtqNnzWQj4ooEncOsT5E8zejZJ/wU6l8GSwDi8ktfMCDnr6Kuq4/AUUPtylAi7nM4ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sG4U1-0003k8-Md; Sun, 09 Jun 2024 00:24:21 +0200
Date: Sun, 9 Jun 2024 00:24:21 +0200
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, xiyou.wangcong@gmail.com,
	bpf@vger.kernel.org, cong.wang@bytedance.com, fw@strlen.de,
	netdev@vger.kernel.org,
	syzbot+0c4150bff9fff3bf023c@syzkaller.appspotmail.com
Subject: Re: [Patch net] net: remove the bogus overflow debug check in
 pskb_may_pull()
Message-ID: <20240608222421.GB13159@breakpoint.cc>
References: <ZmMxzPoDTNu06itR@pop-os.localdomain>
 <20240607213229.97602-1-kuniyu@amazon.com>
 <9f254c96-54f2-4457-b7ab-1d9f6187939c@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f254c96-54f2-4457-b7ab-1d9f6187939c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Eric Dumazet <eric.dumazet@gmail.com> wrote:
> On 6/7/24 23:32, Kuniyuki Iwashima wrote:
> > From: Cong Wang <xiyou.wangcong@gmail.com>
> > Date: Fri, 7 Jun 2024 09:14:04 -0700
> > > On Fri, Jun 07, 2024 at 01:27:47AM +0200, Florian Westphal wrote:
> > > > Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > > > > From: Cong Wang <cong.wang@bytedance.com>
> > > > > 
> > > > > Commit 219eee9c0d16 ("net: skbuff: add overflow debug check to pull/push
> > > > > helpers") introduced an overflow debug check for pull/push helpers.
> > > > > For __skb_pull() this makes sense because its callers rarely check its
> > > > > return value. But for pskb_may_pull() it does not make sense, since its
> > > > > return value is properly taken care of. Remove the one in
> > > > > pskb_may_pull(), we can continue rely on its return value.
> > > > See 025f8ad20f2e3264d11683aa9cbbf0083eefbdcd which would not exist
> > > > without this check, I would not give up yet.
> > > What's the point of that commit?
> > 4b911a9690d7 would be better example.  The warning actually found a
> > bug in NSH GSO.
> > 
> > Here's splats triggered by syzkaller using NSH over various tunnels.
> > https://lore.kernel.org/netdev/20240415222041.18537-2-kuniyu@amazon.com/
> 
> 
> Right. We discussed this before. I guess I forgot to send the fix.
> Florian could you submit the suggestion I made before ?
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 358870408a51e61f3cbc552736806e4dfee1ec39..da7aae6fd8ba557c66699d1cfebd47f18f442aa2
> 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -1662,6 +1662,11 @@ static DEFINE_PER_CPU(struct bpf_scratchpad, bpf_sp);
>  static inline int __bpf_try_make_writable(struct sk_buff *skb,
>                        unsigned int write_len)
>  {
> +#if defined(CONFIG_DEBUG_NET)
> +    /* Avoid a splat in pskb_may_pull_reason() */
> +    if (write_len > INT_MAX)
> +        return -EINVAL;
> +#endif
>      return skb_ensure_writable(skb, write_len);
>  }

Makes sense, I'll probably not get to this before Friday though, so if
anyone else wants to do this: go right ahead.

