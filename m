Return-Path: <bpf+bounces-76959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B1ECCA704
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 07:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A2DB3018767
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 06:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD8A320A32;
	Thu, 18 Dec 2025 06:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="f2CfZn3o"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E622BEC3A;
	Thu, 18 Dec 2025 06:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766038967; cv=none; b=AZ5ffQ4p9hqJagJMnJyhv3lboTYNCn5DcTTFscHbenpiq4VvBERAte/WKpaC8hjwxX7BPT388QQ9/MzlQofpc79dF5wTALinO07lzl529SCuMsljGAfvAJD3D2hdIsvGLNRE558YOx4pGJ23uWMjJKqYhASMnyfllBw3/8uwchQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766038967; c=relaxed/simple;
	bh=NRaRIsDGwjEfXMSjZC/NFMUG4kypo6Es9lBDiFQ10qs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3gjRTdcWOn+yKeSFcepbsnp1o+J8KQ/FAvryixTxY83jen80IA/sbwdwwLJwi2poMP7dt9/5hROxcOG8QEdvbFqQ5ifUIXhs2O31BTBHtHrqFqcZsuXeqCW7SRKuoCPOQCQTVVxsAxTQqLfcU7iX7V6GT0WACgZuwoVFK6WKYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=f2CfZn3o; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHNW1xA238011;
	Wed, 17 Dec 2025 22:21:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=QnU9W7deeMrcvpR9ljaEaTJJv
	JbQij1DQub+QTx1CYs=; b=f2CfZn3oBtXySP0x5i/PJl4htTdJqX8wloWnZvOqU
	L4apeJ7lWzwsdpyIi9aPBkG7S00oJUpxS7uO2JFDGCPRsMTiMMuFg6bV1iMkngbt
	T7Zmq7cwZLrStHo5pIl1rh/tYxt/cLwQ7EwR7J7v6aUrvGs2/unRFZUE8yPPqCnM
	9bGoEKfvHGQjrTtH3sSPcQewDQlrZ9rsYvTf1/ksDwzftxWJVilnU4j70n9sp5Mf
	AAbHkptOnY5PcORBdLd6jGMuS3VcWmPf3geMfteJZIdkdYn60d3W8qrmojtZGLiO
	JXySOmppc+Anm4cc+AW7FbquKyGVfkdOADtXOD04eFFgg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4b3w5s1yju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 22:21:51 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 17 Dec 2025 22:22:03 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 17 Dec 2025 22:22:03 -0800
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id D412B3F70C1;
	Wed, 17 Dec 2025 22:21:43 -0800 (PST)
Date: Thu, 18 Dec 2025 11:51:42 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Wei Fang <wei.fang@nxp.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net"
	<daniel@iogearbox.net>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "sdf@fomichev.me"
	<sdf@fomichev.me>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
        "0x1207@gmail.com" <0x1207@gmail.com>,
        "hayashi.kunihiko@socionext.com"
	<hayashi.kunihiko@socionext.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "boon.leong.ong@intel.com" <boon.leong.ong@intel.com>,
        "imx@lists.linux.dev"
	<imx@lists.linux.dev>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
Subject: Re: [PATCH net] net: stmmac: fix the crash issue for zero copy
 XDP_TX action
Message-ID: <aUOddielBMkrmwhd@test-OptiPlex-Tower-Plus-7010>
References: <20251204071332.1907111-1-wei.fang@nxp.com>
 <aUKPHdtAPDnMqB7X@test-OptiPlex-Tower-Plus-7010>
 <AS8PR04MB849779A6392D543049A3F5BE88ABA@AS8PR04MB8497.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <AS8PR04MB849779A6392D543049A3F5BE88ABA@AS8PR04MB8497.eurprd04.prod.outlook.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA1MCBTYWx0ZWRfX58H1lLqEekM7
 GAUAaaNMq92E4QYI6TfFDXq0fJJqIS59lalZ5uiZH9wNP/NncPI2UmdOu9Z2tvqtv4ZGNQRmuTR
 iwd0TGRySBMwD/0/cpLUUdS0ZF866dcE2BOqhDtc5VwFsEIPgH9fXxYJsHx/sqN7fFVgZFamETQ
 x+ZgiZjftcnNNiGd08amDKjaTLQfjZg621kK6aplA2/vPHM6NkSCLp+ZXD7zNbFW+zQGaxOiDED
 y0YYNXwcYzsoYNLswpV95c8TfWARaqi+gnu7cnVdKYCVXvO9NUGML5W9uiHdD1V7fk4sRzzXuLr
 uVRRjABUGpUGo8nx4kyWOHKq3iq6D/DrC0tPdwhHC5y/CHcD1C0geHW3pBcVCoajui7ccUx90fK
 L6hn/qoQ9qj0Rf2Gzn4cYrmKc2iR3A==
X-Proofpoint-GUID: jUik8wHEQLBJBYXI0BOoajfYtHppzs5j
X-Proofpoint-ORIG-GUID: jUik8wHEQLBJBYXI0BOoajfYtHppzs5j
X-Authority-Analysis: v=2.4 cv=Zpvg6t7G c=1 sm=1 tr=0 ts=69439d7f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=w373o-ZMvzc93a0z:21 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8AirrxEcAAAA:8 a=XlXf_pu8Z8fFeJWwk6sA:9
 a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22 a=gFKHwRTsc5ICqspHuaiD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01

On 2025-12-17 at 18:19:19, Wei Fang (wei.fang@nxp.com) wrote:
> > > -	res = stmmac_xdp_xmit_xdpf(priv, queue, xdpf, false);
> > > -	if (res == STMMAC_XDP_TX)
> > > +	/* For zero copy XDP_TX action, dma_map is true */
> > > +	res = stmmac_xdp_xmit_xdpf(priv, queue, xdpf, zc);
> > 	Seems stmmac_xdp_xmit_xdpf is using dma_map_single if we pass zc is
> > true.
> >         Ideally in case of zc, driver can use page_pool_get_dma_addr, may be
> > you
> >         need pass zc param as false. Please check
> > 
> 
> No, the memory type of xdpf->data is MEM_TYPE_PAGE_ORDER0 rather
> than MEM_TYPE_PAGE_POOL, so we should use dma_map_single().
> Otherwise, it will lead to invalid mappings and cause the crash.
> 
>
 ACK, found below code bit confusing
		case STMMAC_XDP_CONSUMED:
 			xsk_buff_free(buf->xdp);
+			fallthrough;
+		case STMMAC_XSK_CONSUMED:
 			rx_dropped++; 
              
     Ideally in case of STMMAC_XSK_CONSUMED, driver needs to call xsk_buff_free.
     And in case of STMMAC_XDP_CONSUMED, driver needs to call xdp_return_frame.
     May be you can move all buffer free logic to stmmac_rx_zc with above suggested
     changes.

