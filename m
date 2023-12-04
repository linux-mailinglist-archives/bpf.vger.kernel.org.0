Return-Path: <bpf+bounces-16596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00628039A8
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 17:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0AB1C20BA7
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 16:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170512D62E;
	Mon,  4 Dec 2023 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="aL+XXb5Q"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CAACA;
	Mon,  4 Dec 2023 08:07:39 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4CxuPc022087;
	Mon, 4 Dec 2023 08:06:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pfpt0220;
 bh=UxGwEKMqb77hSj2gwUSJa6e+ATYUziz0FtksrLEqbDc=;
 b=aL+XXb5QHCpAsH44dhOEFE9kyihBRMnyEqQTS4uv+EVfGFJ5Pl55D0OMMantvZrk4aij
 MZLeQ8FZUuKO6IFisV+MG2QPPxgEnU6OXmPFvvtf1m403X85LT4KRcrRhz9DLus8PANI
 /s6il0mqas8CXq49KYf11D8E5WvamZr6lCF+jmzrMcCpsAAaQF2hhYWjK7vstV8fwQOM
 x1Map7hQpR0RiItiUz3vwHRfX4qcqyYudtDc/dVRLSh7J2MI6dF6mwLGBnr5dayFkz0Z
 ArUZ0FY96KIzXZ9rW9sfaKRe8V6DmAskD8O31FlAOLcxdE1JXUtDgxiRTz3uUIw2rx0p GQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ur2tvdxt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 08:06:51 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 4 Dec
 2023 08:06:50 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 4 Dec 2023 08:06:50 -0800
Received: from [10.9.8.90] (OBi302.marvell.com [10.9.8.90])
	by maili.marvell.com (Postfix) with ESMTP id DA6AA3F7057;
	Mon,  4 Dec 2023 08:06:46 -0800 (PST)
Message-ID: <08ae0a18-669e-b479-94d4-450a7a12efe9@marvell.com>
Date: Mon, 4 Dec 2023 17:06:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] [PATCH] net: atlantic: Fix NULL dereference of skb pointer
 in
To: Daniil Maximov <daniil31415it@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper
 Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
References: <20231204085810.1681386-1-daniil31415it@gmail.com>
Content-Language: en-US
From: Igor Russkikh <irusskikh@marvell.com>
In-Reply-To: <20231204085810.1681386-1-daniil31415it@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4kUdbOM2gkTdP-w4txwaAiQJ8EVdSGKm
X-Proofpoint-GUID: 4kUdbOM2gkTdP-w4txwaAiQJ8EVdSGKm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_15,2023-12-04_01,2023-05-22_02


Hi Daniil,

> If is_ptp_ring == true in the loop of __aq_ring_xdp_clean function,
> then a timestamp is stored from a packet in a field of skb object,
> which is not allocated at the moment of the call (skb == NULL).
> 
> Generalize aq_ptp_extract_ts and other affected functions so they don't
> work with struct sk_buff*, but with struct skb_shared_hwtstamps*.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE

Thanks for finding this and working on this.

Have you reproduced it in wild, or this just comes out of static analysis?

I'm asking because looking into the flow you described - it looks like XDP
mode should immediately fail with null pointer access on any rx traffic.
But that was never reported.

I will try to debug and validate the fix, but this may take some time.

So for now 

Reviewed-by: Igor Russkikh <irusskikh@marvell.com>


Thanks
  Igor

