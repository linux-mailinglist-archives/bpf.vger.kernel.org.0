Return-Path: <bpf+bounces-16081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E32E37FCA97
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 00:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60639B217A9
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 23:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF96B5732C;
	Tue, 28 Nov 2023 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzrGOSga"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0852140BF1;
	Tue, 28 Nov 2023 23:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB78C433C7;
	Tue, 28 Nov 2023 23:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701213029;
	bh=hOvPICTHCMGIggNE4RN58Am2oDfVbGfBjHWQRSMRYxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nzrGOSgapTj35SLsT3qSDoLK4aJHuInx0TEn1D34sFbXsGKUxBnNI1FUTS8ngIvqq
	 jX3WHmphiXxTqf0oMk0fPAN4j4wPWBgbD5OTLPFXewBFgGIT3rKhK5nKWYfp3Pq/AC
	 ZZOn3PDW9qvZZY3g11VDoyjuC5coQE361TGvY4JyIKLAO/Ta3P8n4djt0Ilu36Gbqe
	 ZYrAdT/vD5qg1dUXc/HVsHaNZjFm4UGkZ+4Z94hXKkS6/1qFc+O74XHF87C8o0FKiP
	 izasnkofXevNzf6K/XRHZ9SmZ9u02rKLG9rLUaP4Dq/OHxBK5bkuh09h5/89S331pg
	 3MTUEt2+vSPIg==
Date: Tue, 28 Nov 2023 15:10:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bpf@vger.kernel.org, hawk@kernel.org, toke@redhat.com
Subject: Re: [PATCH net-next] xdp: add multi-buff support for xdp running in
 generic mode
Message-ID: <20231128151028.168e7a13@kernel.org>
In-Reply-To: <ZWZpUaYbgMELGtL8@lore-desk>
References: <c928f7c698de070b33d38f230081fd4f993f2567.1701128026.git.lorenzo@kernel.org>
	<ZWYjcNlo7RAX8M0T@lore-desk>
	<20231128105145.7b39db7d@kernel.org>
	<ZWZpUaYbgMELGtL8@lore-desk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Nov 2023 23:27:29 +0100 Lorenzo Bianconi wrote:
> > Yes, don't we allow writes to fragments in XDP based on the assumption
> > that it runs on Rx so that paged data must not be zero copy?
> > bpf_xdp_store_bytes() doesn't seem to have any checks which would
> > stop it from writing fragments, as far as I can see.  
> 
> do you mean in the skb use-case we could write to fragments (without copying
> them) if the skb is not cloned and the paged area is not 'zero-copied'?

The zero-copy thing is a red herring. If application uses
sendpage/sendfile/splice the frag may be a page cache page
of a file. Or something completely read only.

IIUC you're trying to avoid the copy if the prog is mbuf capable.
So I was saying that can't work for forms of XDP which actually 
deal with skbs. But that wasn't really your question, sorry :)

> With respect to this patch it would mean we can rely on pskb_expand_head() to
> reallocate the skb and to covert it to a xdp_buff and we do not need to explicitly
> reallocate fragments as we currently do for veth in veth_convert_skb_to_xdp_buff() [0].
> Is my understanding correct or am I missing something?

The difference is that pskb_expand_head() will give you a linear skb,
potentially triggering an order 5 allocation. Expensive and likely to
fail under memory pressure.

veth_convert_skb_to_xdp_buff() tries to allocate pages, and keep
the skb fragmented.

