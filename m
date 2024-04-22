Return-Path: <bpf+bounces-27431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036778ACFEF
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 16:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3C41F21C05
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 14:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9964A152190;
	Mon, 22 Apr 2024 14:53:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886491E49F;
	Mon, 22 Apr 2024 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713797585; cv=none; b=LDzRT8OnsCFS1IvohZqeZ0hAIsHQStezvagUUbCd05S7C5Za5yoUc18WZDO6dRj9QEQiPc1pDXb7SptOpqc/Dojm0HrdaBEZTnypEdOC58SeRfWa4EcIw1johEEaomXygeO7zU+5zskefbxIo92a75brZQ+TwVHuw7SIb0ssiXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713797585; c=relaxed/simple;
	bh=/ZmiNT3Ti61s/9U83aeDaAzv7pg7v8kBefpWb9Hqwkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVn7m+iu8BBFCXwomTNEUzhZXATG87O2XmQVi1i0qWz009lS0gHAEb7e9eMFithGnBSuJGpozPYS7FjqGDirq2HFoUkQofSqOrlpbkVn0RRY6vmUgJq2KOyyeROB+nzHrt+gZFvZ/KNUPM/7ffaQvTA5qBopY5y7EfmR1lBHWXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1ryv2N-0000Rk-5J; Mon, 22 Apr 2024 16:52:55 +0200
Date: Mon, 22 Apr 2024 16:52:55 +0200
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: syzbot <syzbot+0c4150bff9fff3bf023c@syzkaller.appspotmail.com>,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
	fw@strlen.de, haoluo@google.com, horms@kernel.org,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [net?] WARNING in skb_ensure_writable
Message-ID: <20240422145255.GA13918@breakpoint.cc>
References: <000000000000eac28e0616b026d1@google.com>
 <CANn89iKr4pY3wcMb=ONr8f5DU1X300XG8RoX7HU4_FEWSAJ9_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iKr4pY3wcMb=ONr8f5DU1X300XG8RoX7HU4_FEWSAJ9_w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Eric Dumazet <edumazet@google.com> wrote:
> Hmm... Not sure how to deal with this one... this is a 'false positive'
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 58e8e1a70aa752a2c045117e00d8797478da4738..a7cea6d717ef321215bc4cf9ab3b83535c4eec98
> 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -1662,6 +1662,11 @@ static DEFINE_PER_CPU(struct bpf_scratchpad, bpf_sp);
>  static inline int __bpf_try_make_writable(struct sk_buff *skb,
>                                           unsigned int write_len)
>  {
> +#if defined(CONFIG_DEBUG_NET)
> +       /* Avoid a splat in pskb_may_pull_reason() */
> +       if (write_len > INT_MAX)
> +               return -EINVAL;
> +#endif
>         return skb_ensure_writable(skb, write_len);
>  }
> 

LGTM, thanks Eric.  I think the current 'warn on > INT_MAX' makes sense
for normal (non-bpf) callers.

