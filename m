Return-Path: <bpf+bounces-77145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6869DCCF46A
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 11:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B52EA301B807
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 10:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D2B3009E2;
	Fri, 19 Dec 2025 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GZkYxcI3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656CC2FF679;
	Fri, 19 Dec 2025 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766138721; cv=none; b=jVrDHUI9yN2reoZMW2UNYvB05Wsorkkfvi9si929wq7FFB+T/7VH1ICR8URpImoVUQ5THAPfb67I41tl4uMsAPFEJtNhYjrHBQi3Nn37RYyYoGd3nzdJ8ozYR0bohqnsCs7uTg0WwnddJvJ4/tOz0yuRGoLrnLzhP7H5Mr1LQZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766138721; c=relaxed/simple;
	bh=qvTbJcH39/BFQ9aHwMDRIzLhdc64pAOoaNQwNrs00CY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrLCMWUb5N4jqE5+YQG+5Yi0BLhyS0aSIhF7ShPwizFeziATG5lTZJFx+rq7oi8dmWtU6tl9hzl/8UAl0XNSolkAYsQH1a90GV+KBIdzqpoFy5ESesV80Bk8BKIOklkusYgELlsxGIuhpmTEoe4EVgWxq2GcWYeAfnEoTqmq0h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GZkYxcI3; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BIJjX7F680014;
	Fri, 19 Dec 2025 02:04:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=PBVYq6yiFYv4b2SACgENr1E4a
	Ni8XV0ZxgX0rcrPAGk=; b=GZkYxcI32MsTUBg2UvzK5NVBdaP9s6EUH2N7B5ULg
	ftMRdepOnYCwhmb1D1RXEG/z94J2UNi17ZBGYk28TpW0oORIqIg3saITvRnKp8RK
	7EZoFdFD5egHgU+aZ/WxjeCr8Ux+kb2SP3cs1irViVgC9xb0gAl+EbG2zojCS6Fs
	0WrOzctKwU4hcHMpCr5MbjrBUExFskEMMJX/ztKVZ148IWHraZV4SfKD6xtWKl+R
	MRBW2xfokm20sRFIwXgdAS+u9U0SKtwI096vrEOD53NC6Rqhbw+5vb38U7OubhBC
	eEBr/DcwMrgFSxHQuD4/2tCqmxNwa7DMlLtHWqOdcZvNg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4b4r241eu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 02:04:27 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 19 Dec 2025 02:04:40 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 19 Dec 2025 02:04:40 -0800
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 56EA15B695F;
	Fri, 19 Dec 2025 02:04:21 -0800 (PST)
Date: Fri, 19 Dec 2025 15:34:20 +0530
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
Message-ID: <aUUjJH1tQkN1UcYL@test-OptiPlex-Tower-Plus-7010>
References: <20251204071332.1907111-1-wei.fang@nxp.com>
 <aUKPHdtAPDnMqB7X@test-OptiPlex-Tower-Plus-7010>
 <AS8PR04MB849779A6392D543049A3F5BE88ABA@AS8PR04MB8497.eurprd04.prod.outlook.com>
 <aUOddielBMkrmwhd@test-OptiPlex-Tower-Plus-7010>
 <PAXPR04MB8510499B65301187736D511088A8A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510499B65301187736D511088A8A@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA4MiBTYWx0ZWRfX9GQmj9XB3SQL
 oH49VqzVFggN9rADC22341hevpvUlzCz5zG1MrgQuOsIMCNzc3+yjg5UdZhOVtkK4q6l8G3zdXY
 0YrrsVUl2BmGnuRzGZujnJcMgtei4YwiBarLbJV7IJV9b3uwcAAOyOVhouAm9Inr25xZLPjTA+a
 JaPOlv+y1Gydv5xSuOc6A4/xsj4bYcDmU9v7F0q9bL8PwuMdzTX2C3QcpqTaNESo6ESjdLGnSQC
 UDOuFH5DTivmNSZA2j3S1tkFyrkRoKC4HpGf2brlqlFV0CzjrhplEEo1houxaNc50opKnfnSY0P
 UOGOX5Hnn5YvpB6OVT8DIQY93acypB0IZys4mklgv0j2nCVseYUkFi2ga82EOKJE72itirstiHr
 rEg3oD15Mm+229wHkEpCPXIGfjXRkwFgOKUVvMEJpIfH3pl71JKD/3c/WDzv6H5popQK4puDPER
 +Dd2qK9AGNJtDewE/Tg==
X-Proofpoint-ORIG-GUID: lly9dLQ9twDymCjIyijl416JTD7HhVSR
X-Authority-Analysis: v=2.4 cv=T4uBjvKQ c=1 sm=1 tr=0 ts=6945232b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=w373o-ZMvzc93a0z:21 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8AirrxEcAAAA:8 a=M5GUcnROAAAA:8
 a=DZSnwkNSkk__NUsnbCUA:9 a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: lly9dLQ9twDymCjIyijl416JTD7HhVSR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01

On 2025-12-18 at 12:06:47, Wei Fang (wei.fang@nxp.com) wrote:
> > On 2025-12-17 at 18:19:19, Wei Fang (wei.fang@nxp.com) wrote:
> > > > > -	res = stmmac_xdp_xmit_xdpf(priv, queue, xdpf, false);
> > > > > -	if (res == STMMAC_XDP_TX)
> > > > > +	/* For zero copy XDP_TX action, dma_map is true */
> > > > > +	res = stmmac_xdp_xmit_xdpf(priv, queue, xdpf, zc);
> > > > 	Seems stmmac_xdp_xmit_xdpf is using dma_map_single if we pass zc is
> > > > true.
> > > >         Ideally in case of zc, driver can use
> > > > page_pool_get_dma_addr, may be you
> > > >         need pass zc param as false. Please check
> > > >
> > >
> > > No, the memory type of xdpf->data is MEM_TYPE_PAGE_ORDER0 rather than
> > > MEM_TYPE_PAGE_POOL, so we should use dma_map_single().
> > > Otherwise, it will lead to invalid mappings and cause the crash.
> > >
> > >
> >  ACK, found below code bit confusing
> > 		case STMMAC_XDP_CONSUMED:
> >  			xsk_buff_free(buf->xdp);
> > +			fallthrough;
> > +		case STMMAC_XSK_CONSUMED:
> >  			rx_dropped++;
> > 
> >      Ideally in case of STMMAC_XSK_CONSUMED, driver needs to call
> > xsk_buff_free.
> >      And in case of STMMAC_XDP_CONSUMED, driver needs to call
> > xdp_return_frame.
> >      May be you can move all buffer free logic to stmmac_rx_zc with above
> > suggested
> >      changes.
> 
> For zero copy, the xdp_buff is freed by xdp_convert_buff_to_frame()
> when converting the xdp_xdp to xdp_frame. So STMMAC_XSK_CONSUMED
> means the xdp_buff has been freed, it tells stmmac_rx_zc() no to free a
> xdp_buff that has been freed.
> 
> I have added a comment for STMMAC_XSK_CONSUMED, see
> 
> +       } else if (res == STMMAC_XDP_CONSUMED && zc) {
> +               /* xdp has been freed by xdp_convert_buff_to_frame(),
> +                * no need to call xsk_buff_free() again, so return
> +                * STMMAC_XSK_CONSUMED.
> +                */
> +               res = STMMAC_XSK_CONSUMED;
> +               xdp_return_frame(xdpf);
> +       }
> 
>
 ACK. 
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com> 

