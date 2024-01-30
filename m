Return-Path: <bpf+bounces-20651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E97758418CA
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 03:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84842B2254B
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 02:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BBC364CD;
	Tue, 30 Jan 2024 02:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBVG57rU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35BE364A9;
	Tue, 30 Jan 2024 02:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706580529; cv=none; b=SrnYWWYuwdt//OPFE+GZLIbRBKQPdsM+L0GjvuUpS4R15+GSYRUjX6+K8zfPlufUR/E5vsdYSlcciC9qJ3gn559secdjWrP3tqQSJFowqPChrVIFRNBumye4ghrSJJM253mKEWuQgHNpjLx6dA5u+aqW2H08SBUrKsPSHEgG0Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706580529; c=relaxed/simple;
	bh=9rbN2HvYm15Z2jwGzV6r+HBEJq7Isl2UPLyDTEbxcjM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdP2KmYgF+4aYCE9NAH7urAPMhnusF56Es2mvrFizOiqYLaKpgwQtKf9gLJgqil8VxR9gjU0MKHGR4Mcbdd0fzhO46KOiV0Ig9lHwy+0BUPAB3oGJWHtfJxN9ZTnrJriV8S0b0IAjv0guS5FZl8jvKbcJ7wZasBd74XBVu6aQ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBVG57rU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41EFC433F1;
	Tue, 30 Jan 2024 02:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706580528;
	bh=9rbN2HvYm15Z2jwGzV6r+HBEJq7Isl2UPLyDTEbxcjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UBVG57rUvVFDePmvUcPAd+PIDQANfElIL1ePro+BBViUpKJ/HTkpE5y+oZ5Eukrt/
	 JEm+qIOOGnDf4jqxB0kqK0pwNOnwBMYtM47azf4GIKyw02aZWYbbo5ii6kTZ/xOr6h
	 XDK+vHOhHR34NJZowx5ckdxhcA6Fugqk1iJJsmIGwBtg9uOv+tV85O0BgrzviuGV2k
	 OskNhrEDxptrz3K75gqGAAq7rE2Zf10aOoKBQ8yI7BUIcsZEKuYQNsY2dGg7ug3q43
	 1/L811yqtyystB+COy/Ta3HfQP9suund893FsdIQa35x/kdQWOEnJ8XSDN9h8wKPiU
	 4CPcffBZb8jeA==
Date: Mon, 29 Jan 2024 18:08:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <bpf@vger.kernel.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next v3 0/5] remove page frag implementation in
 vhost_net
Message-ID: <20240129180846.28937389@kernel.org>
In-Reply-To: <65eb8581-5cd8-8759-d598-c6711608b0c7@huawei.com>
References: <20240123104250.9103-1-linyunsheng@huawei.com>
	<65eb8581-5cd8-8759-d598-c6711608b0c7@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 20:40:37 +0800 Yunsheng Lin wrote:
> Is this patchset supposed to go through vhost tree instead of net-next?
> As the state is changed to 'Not applicable' in the netdevbpf patchwork,
> according to maintainer-netdev.rst:
> 
> Not applicable     patch is expected to be applied outside of the networking
>                    subsystem

Sorry about the confusion, DaveM changed the way he uses the states
since they were documented. There were concurrent changes to the gve
driver, patches no longer apply. Could you rebase?

