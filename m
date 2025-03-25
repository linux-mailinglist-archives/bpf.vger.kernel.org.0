Return-Path: <bpf+bounces-54631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED9EA6F540
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 12:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB508170202
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 11:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253A9256C87;
	Tue, 25 Mar 2025 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjIcrAY7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929AE2561AD;
	Tue, 25 Mar 2025 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902902; cv=none; b=HMbkwCziffKMCQK5pNVcBBsi4awYQ2PBZ4BeZBF6uzuMeZGTrVYhz+r5T/CgOBWyZZk1CI3md2wP9x9mqzAYYgKYf+9tXr8b0RKSfTLNHBvqEc43kvDSfmGHrDKIbXf+wZ4a8usjRlGTvFFQcllnMeJzPbt6UgnJaZdKKdMHJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902902; c=relaxed/simple;
	bh=zUelcqDDriz9SHJ6HG975vlFXTHLgPVDZutVhZothAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Duj84mPmdTH4cXHKp2KuasO9je9J5x3KLqhO6nQGo1jxI5WyAOh5ZSLuK2teP6BzyO1gLGRXUg6Q/+To0ZSFZqnQx8TpKA3VyOd/fRuLPjaYWCiZvgUkFOWR2yytHLQjchE5MYBAL0gcAycYKUWceQKUNjM5gsyF1E4/FwEa90M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjIcrAY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078DFC4CEE4;
	Tue, 25 Mar 2025 11:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902902;
	bh=zUelcqDDriz9SHJ6HG975vlFXTHLgPVDZutVhZothAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UjIcrAY75aMFN3vXVfik+OFX0Uy5JnrBVRd5fjFX94lL3SFrNbHkKgQcaIA2VC/uF
	 c2d7+SrvjPHqi3AbZvmgxIvY1UxRQw1jAJGd9d3ejma7XAkMJ9jHVUr0VdOT7lBd3B
	 7FPhJeSfb/hWEt/mJCtOzTE4a5iZPKQyCm1dsixrg+kYQkSNd82p/JF1V6m1cUw/ZC
	 Lcg/MJdd6r8tQjuNkSp6keZMt6LC86vUeKhTm2Ohaw2PdtTPuxtGB0ImPQpkjXtbmf
	 H5elHwkT2m/vYSAJ7IqPJXyDiyrnd51xugQZFl94GUFuKOXJFsN97DLbXN66xX352G
	 iZxetGKtfiGvQ==
Date: Tue, 25 Mar 2025 04:41:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Marcin Wojtas <marcin.s.wojtas@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Russell King <linux@armlinux.org.uk>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Masahisa Kojima
 <kojima.masahisa@socionext.com>, Sunil Goutham <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, Bharat Bhushan
 <bbhushan2@marvell.com>, Felix Fietkau <nbd@nbd.name>, Sean Wang
 <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "K.
 Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Siddharth
 Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-omap@vger.kernel.org, Michal Kubiak
 <michal.kubiak@intel.com>
Subject: Re: [PATCH net-next v2 4/7] net: octeontx2: Add metadata support
 for xdp mode
Message-ID: <20250325044126.1c0f9b83@kernel.org>
In-Reply-To: <20250318-mvneta-xdp-meta-v2-4-b6075778f61f@kernel.org>
References: <20250318-mvneta-xdp-meta-v2-0-b6075778f61f@kernel.org>
	<20250318-mvneta-xdp-meta-v2-4-b6075778f61f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 12:46:08 +0100 Lorenzo Bianconi wrote:
> @@ -1514,13 +1518,14 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
>  
>  	hard_start = (unsigned char *)phys_to_virt(pa);
>  	xdp_prepare_buff(&xdp, hard_start, OTX2_HEAD_ROOM,
> -			 cqe->sg.seg_size, false);
> +			 cqe->sg.seg_size, true);
>  
>  	act = bpf_prog_run_xdp(prog, &xdp);
>  
>  handle_xdp_verdict:
>  	switch (act) {
>  	case XDP_PASS:
> +		*metasize = xdp.data - xdp.data_meta;
>  		break;
>  	case XDP_TX:
>  		qidx += pfvf->hw.tx_queues;

This one handles ABORT and invalid return codes as PASS not DROP.
That should probably be fixed separately?

