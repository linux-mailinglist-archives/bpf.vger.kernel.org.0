Return-Path: <bpf+bounces-40096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8DF97C85E
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 13:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29DE1C252A4
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 11:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187FD19D88D;
	Thu, 19 Sep 2024 11:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="K4sa8IFl"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0617E19D069;
	Thu, 19 Sep 2024 11:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726744392; cv=none; b=XMPYXgoJiSp3CEea8qiO67c10hIX6IM0N22OeKwACUL+mL1KnKjq29/8vfgnz55/0WEGUqLPKz1yniBsp428FxscU1FF7nH0kLoe1dzhs32Mnaro7p7IQBs6LmgH3vYLfngdktWXc0Zq1iiKRjo7CjIeuZCbNnc2mU76BsRO824=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726744392; c=relaxed/simple;
	bh=mSW5lrlRXkBe3hdDmc5mspa++Cwa8m7fyWTdlSWbjLI=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XS9u58WSsh4IbiRKS5T5IITVbYOCK8wgmFaiMjoAFdofcUZ/udZA8K5+rvsnnHP62P5W0WgSDUZ9z4nP1fjAq3kKsIUWNSlhf/DxEY3mXaBOlwd7HEE98reqdi2DK3AsEz7lbz4sxztWv7kzcS+97Ivfytmk4sw03zJ7INt72Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=K4sa8IFl; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48J9FxlA010349;
	Thu, 19 Sep 2024 04:12:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=4VXw//KqD9XDky/B2uSXxs9gq021yHn+0xx/I/0/7RU=; b=K4s
	a8IFl/tTqP/Ew7Xa4hxhUpdzxy7pzKBkroAO1MrD4djWPjDfwPdrdGGlDBpSQL7C
	fBiiZiidy5NQo/2OUVn9esxm+8YnDnTG32cJDUKX3o2I8GX0MLWgy0ucLOlYImh9
	TD6xzZb2iO+6MPgS9oM3Yaz4iEDACYWmdtNaZb2sDMxmyauk3qGqklNoH6j0F7Gg
	tv61SzaWbLDBRB6cQMNleDKbx+QaTUrl4JLsaw9H2eDRmU3/x+5e5GqGcq/de+q2
	yoi1bfB3xkFAoiQ6FIo5mf/xj0FWF1VtCQ2x5UzDRG6l3sdWTVmOOJrfw9x3n+X7
	up0o54XWcn7ZGm87jAw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 41rh5mgg18-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 04:12:44 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 19 Sep 2024 04:12:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 19 Sep 2024 04:12:37 -0700
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id BD9FB3F7088;
	Thu, 19 Sep 2024 04:12:32 -0700 (PDT)
Date: Thu, 19 Sep 2024 16:42:31 +0530
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Wei Fang <wei.fang@nxp.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <claudiu.manoil@nxp.com>,
        <vladimir.oltean@nxp.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <stable@vger.kernel.org>, <imx@lists.linux.dev>
Subject: Re: [PATCH net 3/3] net: enetc: reset xdp_tx_in_flight when updating
 bpf program
Message-ID: <ZuwHHx2HiRlRipkw@test-OptiPlex-Tower-Plus-7010>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: 9N_ww12_J25Yyry8OhKS8Urjg7gQOvsI
X-Proofpoint-GUID: 9N_ww12_J25Yyry8OhKS8Urjg7gQOvsI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

On 2024-09-19 at 14:11:04, Wei Fang (wei.fang@nxp.com) wrote:
> When running "xdp-bench tx eno0" to test the XDP_TX feature of ENETC
> on LS1028A, it was found that if the command was re-run multiple times,
> Rx could not receive the frames, and the result of xdo-bench showed
> that the rx rate was 0.
> 
> root@ls1028ardb:~# ./xdp-bench tx eno0
> Hairpinning (XDP_TX) packets on eno0 (ifindex 3; driver fsl_enetc)
> Summary                      2046 rx/s                  0 err,drop/s
> Summary                         0 rx/s                  0 err,drop/s
> Summary                         0 rx/s                  0 err,drop/s
> Summary                         0 rx/s                  0 err,drop/s
> 
> By observing the Rx PIR and CIR registers, we found that CIR is always
> equal to 0x7FF and PIR is always 0x7FE, which means that the Rx ring
> is full and can no longer accommodate other Rx frames. Therefore, it
> is obvious that the RX BD ring has not been cleaned up.
> 
> Further analysis of the code revealed that the Rx BD ring will only
> be cleaned if the "cleaned_cnt > xdp_tx_in_flight" condition is met.
> Therefore, some debug logs were added to the driver and the current
> values of cleaned_cnt and xdp_tx_in_flight were printed when the Rx
> BD ring was full. The logs are as follows.
> 
> [  178.762419] [XDP TX] >> cleaned_cnt:1728, xdp_tx_in_flight:2140
> [  178.771387] [XDP TX] >> cleaned_cnt:1941, xdp_tx_in_flight:2110
> [  178.776058] [XDP TX] >> cleaned_cnt:1792, xdp_tx_in_flight:2110
> 
> From the results, we can see that the maximum value of xdp_tx_in_flight
> has reached 2140. However, the size of the Rx BD ring is only 2048. This
> is incredible, so checked the code again and found that the driver did
> not reset xdp_tx_in_flight when installing or uninstalling bpf program,
> resulting in xdp_tx_in_flight still retaining the value after the last
> command was run.
> 
> Fixes: c33bfaf91c4c ("net: enetc: set up XDP program under enetc_reconfigure()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Thanks,
Sundeep

