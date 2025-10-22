Return-Path: <bpf+bounces-71655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEADBF98E0
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 03:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F89462415
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 01:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272811A8F97;
	Wed, 22 Oct 2025 01:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aegie7Ov"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA703EA8D;
	Wed, 22 Oct 2025 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761094898; cv=none; b=fc3ofImkRL4UwyV5B3D50k9lPLmEh+n00f8ey+pboXvGaEPGmXNVw5JVI1rskgnRBJJqCaDrpsBneIUPJJD4WBTEaP6qyN4Eu/TJ6+kzZxIHftnrf8kr4wtbibPToRfv/SMTnslAFYb0tuYb/cWMhRuziPnrYCCHG46uQbY9r8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761094898; c=relaxed/simple;
	bh=7IKRMTP4CJIKPwBwo+6TW7HvgNmAIjrOCbnjXmxq4us=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KwDSVCkhE7MBBxptG6PKY+S0BJAbCYDBNixs950r6AA2K8YqDSQhsiiQ4Z8e6s4I8uehItKLcCu20lB+xekXDQS5udtbdTRQVEGPqMpirgpimtaw2HO53purIRjHP26xQqsurQnI+R+xVDdtU/C7JB/lCxClGHUKHfrJEEko0UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aegie7Ov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5331BC4CEF1;
	Wed, 22 Oct 2025 01:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761094898;
	bh=7IKRMTP4CJIKPwBwo+6TW7HvgNmAIjrOCbnjXmxq4us=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aegie7Ov08g7CjEUqDN5JrHnw5VbVrp7FDxMbO1PNyuHQsO//sCCU1Tsn+zHhwQZl
	 TstUOvksXonHVqDTHJbhtTwFnorS7Az1CdjF5F47Ml2h+DEa9FKMxSg23t/fWHO6aN
	 eLQFMFUQnuPcVdMS5zayhJqx0kSgaS/rO3/odVDENVZheuLkPa6QQKbaPnzKbo+1AQ
	 hA758shauILDZPK2b+lM7T2tEpJJf4fHAcnLELpmj5oFpbgD509CZ2e5tAF2DWwHqd
	 6298nsVCdw+O547MpwjA6vn6MKogV/VlT5WAS4mQ6rKuQwI0pp7BFXgUyPlO/sRjjg
	 HUsZ1r6n083MQ==
Date: Tue, 21 Oct 2025 18:01:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <ilias.apalodimas@linaro.org>, <toke@redhat.com>,
 <lorenzo@kernel.org>, <netdev@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <andrii@kernel.org>, <stfomichev@gmail.com>,
 <syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Octavian Purdila <tavip@google.com>
Subject: Re: [PATCH v2 bpf 1/2] xdp: update xdp_rxq_info's mem type in XDP
 generic hook
Message-ID: <20251021180136.39431ed3@kernel.org>
In-Reply-To: <aPZ3FvcIVOPVxQum@boxer>
References: <20251017143103.2620164-1-maciej.fijalkowski@intel.com>
	<20251017143103.2620164-2-maciej.fijalkowski@intel.com>
	<50cbda75-9e0c-4d04-8d01-75dc533b8bb9@kernel.org>
	<025d2281-caf0-4f88-8f31-b0bfa5596aec@intel.com>
	<aPZ3FvcIVOPVxQum@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Oct 2025 19:53:26 +0200 Maciej Fijalkowski wrote:
> > > The SKB should be marked via skb->pp_recycle, but I guess you are try=
ing
> > > to catch code that doesn't set this correctly?
> > > (Slightly worried this will "paper-over" some other buggy code?)
> > >  =20
> > >> +=C2=A0=C2=A0=C2=A0 xdp->rxq->mem.type =3D page_pool_page_is_pp(virt=
_to_page(xdp->data)) ? =20
> >=20
> > BTW this may return incorrect results if the page is not order-0.
> > IIRC system PPs always return order-0 pages, what about veth code etc? =
=20
>=20
> veth's pp works on order-0 pages well, however I agree it would be better
> to use virt_to_head_page() here.

In this case the mem.type update is for consuming frags only, right?
We can't free the head itself since the skb is attached to it.
So running the predicates on xdp->data is probably wrong.

Is it possible to get to bpf_prog_run_generic_xdp() (with frags)
and without going thru netif_skb_check_for_xdp() ? If no then
frags must have come from skb_pp_cow().=20
And the type is always MEM_TYPE_PAGE_POOL ?

