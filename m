Return-Path: <bpf+bounces-59820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E95ACFA6D
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 02:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC6416CABE
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 00:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E79610942;
	Fri,  6 Jun 2025 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfQlCg4n"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D510F136A;
	Fri,  6 Jun 2025 00:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749169906; cv=none; b=NA3tVJnrQBp+tpMcuuw4RCMtzS5vkzPcz7DvjiVkALf9axq0ci/HPYeMOGM5sUlnlNQNl2vFtZNyREkbTTqYGar5oBcLShcCNsvZ3d8t5TkfeN4IUIdZThQFxkI9OejkvSeCkuM0m/ieLG0NOjeL9DQwH9ael1VM+T7mZAKMl2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749169906; c=relaxed/simple;
	bh=z9+pJwlg7l/xWx9Us3YaK6Toh3Aj6JbFhW2MZ3BKAe4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kROriOHyG0ZMkDn7e4wQpZxYvbBLw+XLQDhGekQMAQS8oP76i65eY8edZeMG0HFTxYKe9lGR826KrC3fDzLGyIY7MBx4unOzj7fAsA50zRPurGttL6wzWBNCiqM/OdwwhNqnX3cYDq5tL1olYy+s86lR2jCeGS22h30lFg4mMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfQlCg4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B568C4CEE7;
	Fri,  6 Jun 2025 00:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749169904;
	bh=z9+pJwlg7l/xWx9Us3YaK6Toh3Aj6JbFhW2MZ3BKAe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MfQlCg4nOE/TLj16dV15ObSSInuNP2HeePwbL9QovH4D0ExQuBlqtVlt3txNxB6km
	 /T9picVSfR45kHKUD4Em+uuhVWzWtS7c5QXCP2gdNYEpopVBmDOMuczDbnZb4eaPqE
	 iJO0rDqdUFX4ZEzybkLGy1zmkqM1Jzp/OyVJzpNSHSOuUzi04SdDZw/rdhig3ExnS+
	 Ia2/Co2S3n7gXcgh5e3aHMxVxW0f/qbrlmPPsQpNb8mEsgyfenRVqdjAgTRinA0qmk
	 GOSnvti3qUfyEGdSOkbaOv3aMokP505vu1B/04izwx19draY1akaUbkQLeqUHedHj/
	 gcwFthgsUZq7Q==
Date: Thu, 5 Jun 2025 17:31:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <maze@google.com>,
 davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 martin.lau@linux.dev, daniel@iogearbox.net, john.fastabend@gmail.com,
 eddyz87@gmail.com, sdf@fomichev.me, haoluo@google.com, willemb@google.com,
 william.xuanziyang@huawei.com, alan.maguire@oracle.com, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: clear the dst when changing skb protocol
Message-ID: <20250605173142.1c370506@kernel.org>
In-Reply-To: <684231d3bb907_208a5f2945f@willemb.c.googlers.com.notmuch>
References: <20250604210604.257036-1-kuba@kernel.org>
	<CANP3RGfRaYwve_xgxH6Tp2zenzKn2-DjZ9tg023WVzfdJF3p_w@mail.gmail.com>
	<20250605062234.1df7e74a@kernel.org>
	<CANP3RGc=U4g7aGfX9Hmi24FGQ0daBXLVv_S=Srk288x57amVDg@mail.gmail.com>
	<20250605070131.53d870f6@kernel.org>
	<684231d3bb907_208a5f2945f@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Jun 2025 20:09:55 -0400 Willem de Bruijn wrote:
> > > It does make a fair bit of sense.
> > > Question: does calling it as a kfunc require kernel BTF?
> > > Specifically some ram limited devices want to disable CONFIG_DEBUG_INFO_BTF...
> > > I know normal bpf helpers don't need that...
> > > I guess you could always convert ipv4 -> ipv6 -> ipv4 ;-)  
> > 
> > Not sure how BPF folks feel about that, but technically we could
> > also add a flag to bpf_skb_adjust_room() or bpf_skb_change_proto().  
> 
> To invert the question: what is the value in keeping the dst?

I guess simplicity defined as "how many English words are needed to
explain the semantics".

The semantics I have in mind would be - dst is dropped if (1) proto 
is changed (this patch), or (2) "CLEAR_DST" flag is explicitly set
(future extension).

If we drop on encap (which I supposed is the counter proposal)
we may end up with: dst is dropped if (1) proto is changed, 
(2) encap flags are set (1+2 = alternative patch), or (3) "CLEAR_DST"
flag is explicitly set (future extension). 

Don't think we can rule out the need for a CLEAR_DST flag as not all
re-routings are encaps.

But both you and Maciej consider dropping for all encaps more
intuitive, so I'll do that in v2 unless someone objects.

> The test refers to a nat6to4.bpf.o, but this is not included.

I reused an existing BPF prog, it does what we need -
it turns a v4 packet into a v6 one :)

