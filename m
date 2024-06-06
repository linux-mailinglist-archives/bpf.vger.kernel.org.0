Return-Path: <bpf+bounces-31547-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D71478FF831
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2024 01:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88FC11F216A4
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 23:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F3C13F42B;
	Thu,  6 Jun 2024 23:28:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A81C13E8BE;
	Thu,  6 Jun 2024 23:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717716485; cv=none; b=ItLGfhkw/bZ01DoI7o21KDHUZzjxZSMz4HV0R2YdTOPvEiTmuZnYBOBxEpDCX71eq14/EuEqALE1x4ATPbgSvMs6ZChROIS7vhn0oRnY2IEZKkByJQKVBEQUb7ZIc6gTZQncTd2LRUP6F4KvnY3yFBb925SGj/fxEquhs8Rw75Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717716485; c=relaxed/simple;
	bh=nAjgE39YpiFL9x9R8xH5bStsiNkkwcXAPiGTXqoKAe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9nz5fpBWpjlDzYdMGQnLEip1klyTWCH147CQT5r61ToAOrNDpm+c5LVwtDoxhgB9h5UwVMD3SOF9w58GtjcHoS118p0l5Xx9zskoSmz2N5dFWzWrOcym2p+zVSkSR12F71oQLoP94088GxJFit6zYWx5rlkjHhgKOjoMXvBgC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sFMWJ-00071t-KB; Fri, 07 Jun 2024 01:27:47 +0200
Date: Fri, 7 Jun 2024 01:27:47 +0200
From: Florian Westphal <fw@strlen.de>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>,
	syzbot+0c4150bff9fff3bf023c@syzkaller.appspotmail.com,
	Florian Westphal <fw@strlen.de>
Subject: Re: [Patch net] net: remove the bogus overflow debug check in
 pskb_may_pull()
Message-ID: <20240606232747.GE9890@breakpoint.cc>
References: <20240606221531.255224-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606221531.255224-1-xiyou.wangcong@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Cong Wang <xiyou.wangcong@gmail.com> wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> Commit 219eee9c0d16 ("net: skbuff: add overflow debug check to pull/push
> helpers") introduced an overflow debug check for pull/push helpers.
> For __skb_pull() this makes sense because its callers rarely check its
> return value. But for pskb_may_pull() it does not make sense, since its
> return value is properly taken care of. Remove the one in
> pskb_may_pull(), we can continue rely on its return value.

See 025f8ad20f2e3264d11683aa9cbbf0083eefbdcd which would not exist
without this check, I would not give up yet.

bpf_try_make_writable() could do an explicit check vs. skb->len.

If anyone needs it, splat is at
https://syzkaller.appspot.com/bug?extid=0c4150bff9fff3bf023c

