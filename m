Return-Path: <bpf+bounces-40182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822C997E588
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 06:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12777B20E6F
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 04:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7211119A;
	Mon, 23 Sep 2024 04:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dtO4zpYV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9AF1C3D;
	Mon, 23 Sep 2024 04:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727067415; cv=none; b=B2aNDNUHPfleVCqHIZiZvovcySJjXwhi3Tkf7K5ce9rhdSzip0qa29Re7hf9tD1a5SAfMN0Gt9OXekVAHOq63SaD6pGWOYQCBfNMa7XtupW2swiuH9UwNGvS/gBSIUTBZeApcq+mn3OgPXfJE3UcCqxCX08ReafgeUUSWnunSl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727067415; c=relaxed/simple;
	bh=YAiad1qYqEGFsiRIlikGn17OKrMiJQfqenYiwTY676c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhSmJ9scxueDiN42xlWtn76IfKHdqsXzBY5+UfrIPKARKCVCax6Na/zqTsuTeTJZ/5HRcaFKBAktmUdibV0eFSv0OWR5ygiyAzgMm9HLQv5BtPjuFW4Gie89HG502db5kWlV9F/yhQqAeYezEPPtvQosac1rlgLjArSNUe30ocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dtO4zpYV; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48MLSRqx005697;
	Sun, 22 Sep 2024 21:56:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=YAiad1qYqEGFsiRIlikGn17OK
	rMiJQfqenYiwTY676c=; b=dtO4zpYV6YIioK0/nikgJiahoZmLUo918osBnMmNM
	x187ssBQqwSoggDt2xiU5p/s+dVanElakMdSntKulW+g9DT3D1Fn/RRXmjPmVnrK
	3o/kIbVvPcEGk++lMbm/KDyffHIzwEHgEpmP/Ja7CQ3gU4cQRlAwIyNSqm9bQMVL
	TEH4A5eOHova1qofpho1LLMzYj1ZINmdJHaO5t8K8bfmx0AWtJxksddRFGDgTpWT
	H5vMDvRSkUJeYHcHnwdelpXzrwKkBdZHyLuudXd7xYMqhXeP09yxEqkeOwnnh64t
	7VNconNoEackhTrS36uwpDRlKdTjTARFjCazi1sbvhy1A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41swnjnx7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Sep 2024 21:56:26 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 22 Sep 2024 21:56:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 22 Sep 2024 21:56:25 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 3CF003F706C;
	Sun, 22 Sep 2024 21:56:20 -0700 (PDT)
Date: Mon, 23 Sep 2024 10:26:20 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Wei Fang <wei.fang@nxp.com>
CC: Vladimir Oltean <vladimir.oltean@nxp.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "hawk@kernel.org"
	<hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH net 3/3] net: enetc: reset xdp_tx_in_flight when updating
 bpf program
Message-ID: <20240923045620.GA3287263@maili.marvell.com>
References: <20240919084104.661180-1-wei.fang@nxp.com>
 <20240919084104.661180-4-wei.fang@nxp.com>
 <20240919132154.czugz52nirmijohe@skbuf>
 <PAXPR04MB8510727BD7B77261491B4D31886C2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510727BD7B77261491B4D31886C2@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-Proofpoint-GUID: O5Q2zY0SoljxqKQI_b0351QPVuYjwCSZ
X-Proofpoint-ORIG-GUID: O5Q2zY0SoljxqKQI_b0351QPVuYjwCSZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

On 2024-09-20 at 08:42:06, Wei Fang (wei.fang@nxp.com) wrote:
> enetc_recycle_xdp_tx_buff() will not be called. Actually all XDP_TX frames are
> sent out and XDP_TX buffers will be freed by enetc_free_rxtx_rings().
why didn't you choose enetc_free_rxtx_rings() to reset inflight count to 0 ?

