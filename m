Return-Path: <bpf+bounces-79420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9B1D39DBD
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 06:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58FD03012DF1
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 05:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ECB33067D;
	Mon, 19 Jan 2026 05:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UdT/oLKJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hPOYcsjK"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F0327FD48;
	Mon, 19 Jan 2026 05:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768800333; cv=fail; b=BOJTb/78S5q3Awc+DaYfK6wl9uCu6XnFNL+hHJFT5KHPYCrlgGNx3Jl3QRuOp4aFHz6IUn75DPJ4/Uk9OUfxVhd+iAXxhYNpbHkxEHVKKhNBBwEYpL/tMYRcqdGN/9vJ7f6ccUx+wiUIEs8lTxrz795W2gwKCQqa04YGJPM2q0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768800333; c=relaxed/simple;
	bh=2bqICwXhzCZYFDdAFft2pryYWJ+rwlw6LINikL8mU1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jk9sMEgQcbeqXE+ZGdg0F7iDKPctiThWaqbZIUleYFCBUQdRzgDrV3C+n/ucXUCIcFvTYrYlSpHCbfNYax02iJj2TiFH3J4HGwPDpIFh6tuDUcY1iCntdnfcmsa9rsufRhB+ohkOTeglrINVnStIW/+7puHh8nh7LZl0xKHrfPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UdT/oLKJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hPOYcsjK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60INj2UK4130755;
	Mon, 19 Jan 2026 05:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=yQd8tGNhMEoO1zYbFn
	r2kU6aQZgjET0iEv5wGZojYvg=; b=UdT/oLKJX4kFLkTNUy5Bg4cL8kDtdya/Fq
	2mNgBEoCb4WB0hMTkGpAWlzL0RLU4uGAhhPJdboX/V0Bwqn9l59DmsswjZMIi/Pl
	a8Ab0ZTsTrk5Z1wmaNynJtroYgwkbv4cT/OwnaYza4d7gYqQ0YI2OBKS7RES9Uk3
	RWOU65ZDpwSx2kPVcYVK7jdHW4HU8lQhCujjhojQJpRd2t+YG+9yslBbLAIM9eJg
	cUeW/7H8Vr/q8qJFP6O8PKlzSHOkeSUTH8RFRFNbwzEdN0Z3Z5e0/v0a99IMsl7l
	7BNjdYUdBYtA4YfV6f7oSwGAT1VsWlp1+ap+VuT9tvIQGn5cfLwA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2ypsmwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 05:24:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60J2tw5H008423;
	Mon, 19 Jan 2026 05:24:05 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v7wufu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 05:24:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UaMWx86tDkg6auWrZntrbirSzlYvAlotFagbCocIQ7zEnt2MNK0FuFAjwSTLe9mOwdAK15mFmxuzwlTrX7nJYLvHIk34t6MilL6wTB9NosktRYDao+/QMKoBDgX2R3w4FbpcMN1JIXYW6efc9/mkg6DO6Q3tHyddaoH506aCpZnMi95b5diAtECs6DMp+yXGoo7IwI7U9KrWNeqCYr6tl7rw0gh/5366lpLzpBPsnzYvCF0qjCaJ3N/+X6829vhsyVpU0tu3PNjnDIRmtOX5nxmAZ7dj67TtYC74e/t6qahSrFLRwG78P3wdnJXNb6t/UbevpzDj9HlfSRKugIdeRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQd8tGNhMEoO1zYbFnr2kU6aQZgjET0iEv5wGZojYvg=;
 b=YtuTn8ixqjfeeH8WnXErJooV8CuGdGiU8SvTPkk9xhk6Jk9/rD1jJ6D50LWwPaEFTXucMFSmcTuLj6cJSlSU7LCJ9ERbYEqz/9bGy6eqcTAdDNCzDKF+dEmCQkP+Or0HL13ckN1qdflivxrywWHWEZEG0zNXR0LMqCfbfYPX20/KmMRI2lOeGuschB0qobvPKKcMXjCfFZTDRNlMkRw0N8z10mSjENi52u0kCO2WpgfM2g/gn0aAradhlERSf/83HNVhfw7Q9xPMYDnVVHmx8crSKxPMnCDklRXiEKSCL4D+remuvrxPdpWMa7c2y6W5g0sFSMY98I1TNj4t/aAgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQd8tGNhMEoO1zYbFnr2kU6aQZgjET0iEv5wGZojYvg=;
 b=hPOYcsjKemVOU34z4SUCaGMsOeaPJW4QL1LfUQpBUE9oYLOpIkt6jXEmmgcX+J6CmtNyxQGxr+VB3rYF1fJOqbGqjcHlF2wDwx0om/SSyIf7Src9agkDXMaCifa5dc/DaC1WCNCCucX6M1TMrVcx5Sh/+imJRpinoivbBANQRd4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB4702.namprd10.prod.outlook.com (2603:10b6:a03:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Mon, 19 Jan
 2026 05:23:57 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 05:23:57 +0000
Date: Mon, 19 Jan 2026 14:23:48 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 08/21] slab: handle kmalloc sheaves bootstrap
Message-ID: <aW2_5LW5HgqdU4rr@hyeyoo>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-8-5595cb000772@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-sheaves-for-all-v3-8-5595cb000772@suse.cz>
X-ClientProxiedBy: SE2P216CA0095.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c2::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB4702:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b7ad3b-04b3-4636-9e33-08de571af1ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?06J+KCReRB58nWPc4ZvSOwUNhHfElKeDbE8pfNEXPwd2qtB4Mo5szOdO0dyH?=
 =?us-ascii?Q?9LoQeGLcCWxLNmRVyPPMut527YWVdpRHvxGTwwmhEyim3+aoOl9zSSANyS0h?=
 =?us-ascii?Q?9QoVPxPcq+ilCSRVg3MN/ULDxRhpdx7FeOf0xjrTdsm5eyyYjBLe+GNk9qKF?=
 =?us-ascii?Q?KrJHoktiUreHKn5xd+2JWTxovPFRDl9nofh4Fs1T78wakxGkXR1IA/YEHlg0?=
 =?us-ascii?Q?RqWTTQHa+9qBKnPlUukFSTx1q6+5gPuFOCRPurKfoDWCEag0ITv15cFCwjG2?=
 =?us-ascii?Q?L/OdADAfT9arXvyq5NalZMF6LupHSVriRAPcGbzttpGNlwIQ782TO3FLae4q?=
 =?us-ascii?Q?YjK7HcKtN9Clc9vQIHeT+WIJS7oMJAUAuLOJWtgkcibNXVavyyrpjcvHPZB1?=
 =?us-ascii?Q?GtRRQ3Ct8vCAMyprLIpiL/asAUmCDvhiQt4iIMIeo/8wksnKDnpfatxq+vY8?=
 =?us-ascii?Q?JECs/c/DqUA/KMXxGlOSHcvX4v6WGafL56gJUSfbtkInY4T0rqDC3lnroSMa?=
 =?us-ascii?Q?XPhUybxSAgRvpV4Ry919B0GJmqo99u25HtU1f1p8WollaNi0Zh1diDgyuMc0?=
 =?us-ascii?Q?YXBEufM0EBwn/JxwRyvMyQVOln5nLS79iX0W9IX4OKhClDslBaa1YOKUiJTn?=
 =?us-ascii?Q?jyn5cNL/MN7AtIIhiZ32F1iypj+zLQlQ0R/qjcuUf5zCIEehLTQmVnxM1IdH?=
 =?us-ascii?Q?2wEoqe0MpQSaHuxjOqjzkIRBvAJzkorTD1DAMe4GjFm+jLE5Bu5sQwvL8WeQ?=
 =?us-ascii?Q?bypPNT0h2TVDkk6i8+r+q6zYdGIKltQW0l8Ir64dkiFraFsRLiSXC2aBt2R7?=
 =?us-ascii?Q?hswD3rCI6+Ka5GLk3iZ1Ikm0km4Exh4ErxlRGQWC+8tHMfCxsZ04Z1Sjx52Y?=
 =?us-ascii?Q?tq5VycT7PIGn/UE2hK+Bf52ZFC8k1YxNiVyKk66qtUPZe199OU6wmp5F4EzL?=
 =?us-ascii?Q?bxR9mufkY+Q0dupxj7jSnMtfY8e9VUq77+qNy0kHgIpoElnaGnnJuRFA4BfY?=
 =?us-ascii?Q?eCHTD/jKoUs43UoN84AqMgNc6xMVfOOCmp+mHMQu+1ePEgst3e34VutpE7Px?=
 =?us-ascii?Q?i812ZxUiDlvLXcrIUwt4GJjRF4Uh34Wliwrg/nACE5smZihbU74sg2CnEH1T?=
 =?us-ascii?Q?jyFozlMQxoXy0gVu79WQ9U6IPHOPOGmmGC8QT+Ql8koa+E+gqnRqeOYHxEAt?=
 =?us-ascii?Q?8Sveov0VtRBbIb7/Sddkd5e+jAMMBTsJtazdBmk5NoanT9QQuvk1Q6Ag9Dbj?=
 =?us-ascii?Q?/x3QNfqRWWkis5yvp04xrPY9hXHuvAPDewKQgpbrYIFQHJsI9+U3MIaxjDzx?=
 =?us-ascii?Q?NjoOcjqTA9zFrqfZJhsYvoSbi+FSuVyYS1fV5my2Mqi8Tyj10fvKzAJCvMEn?=
 =?us-ascii?Q?+5jkbw+3XQxlYolRX5nzXpfWs9Wj5lqZO6bYlgSK0FJc6nYbrn3J38aZ1iAi?=
 =?us-ascii?Q?fs6rzhYNE75GStOOUn+zmCWVoeoVVqdf3Sphax45XEIiKUroawHKfIaFmN1c?=
 =?us-ascii?Q?2HtVE2t5O+PQ7kqEq8Y7BHpcIYzlrVH+0Q3es501hE0S7qQuPBFlJt15X5+a?=
 =?us-ascii?Q?uybUjCoNl77r2CcE/bc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zSnmQxD5iymFZ+nfboKMuqjarAyMBE227dC/ynacVOHSlWhe2ie/zd+V2N6X?=
 =?us-ascii?Q?OKF0sYWbUlrWnEV8DRIz2qS9iGtWCoEZkeKuJ4z0MvL7pBppQ5Hu1wmquBYm?=
 =?us-ascii?Q?d7opkKEm6U31eRg+NUVq3jtkItsqplqLgSKv9ANHe4mhv7ou2VaYv6q8XVuD?=
 =?us-ascii?Q?+vgJ9vdawUZKqyUDf1kUHeyWGFkh9DLUBKvZfqn5B4bFu4peNDZ7xncAXBkB?=
 =?us-ascii?Q?WRpmQBr74QoZCKKnYYtmjduCkCu92x6+A8vG4dH1KfAlrwVNRYPZ/8ZzVp6+?=
 =?us-ascii?Q?GTGkUJ03hrvKcInGbEq0kJ+jDIqts6VzeqgsNbua380sFs35YrhczdbLUoIA?=
 =?us-ascii?Q?zw/wmPmTBMJoCQfvpag8cHgzfiUAC6cZkn1Lq5EvvwuWKM2yRJWfQnsreV2u?=
 =?us-ascii?Q?1uHK9TGptRFWtvbadeQsYshV+9qLWkRXMAIwtmpHiCLVlfh7P0tpvTiqDdta?=
 =?us-ascii?Q?c3Bm7+eo5O2E/2E7ENyzjc/VNMJFBduflfRH//xSrdS37KKz4Kh2a1wVNCOP?=
 =?us-ascii?Q?m3zshzW2i8TDI/aLBRRgIHkdN1nA6vp8RwRKlt3m9M63F8/Tq3JEB3cMuXsX?=
 =?us-ascii?Q?I+on5fqzWs12RjwhSXno9R2FPF2FDkcUVSksMeh2nS3F7rrGOFBsD/qHtrhL?=
 =?us-ascii?Q?8Y4iOm9baFzntsNuMPjlGj9oYO8Cfs52KOQ27Cbn/0XLr5L3gMAyfF+tsDkA?=
 =?us-ascii?Q?ipXxMfQYHAv2+E3GH9vg6TmAGS4SWLFBVAZYdGDcTNvH50wz4PfRWrHUoNW3?=
 =?us-ascii?Q?rZ25y0tK1BBUyMDAT8bSeF1FkudYGbocgzIJPyZlNFUH+LKJBHquwKoXfasC?=
 =?us-ascii?Q?CasvpCVkWv6qYczffhhyV7Cwmo/RCC18Cgu4POy6TlYrYDVyDO7gC65KXkX+?=
 =?us-ascii?Q?SAMWUSCsRzIdAnVcvYXxdMqReeaG3DBdxoo76FjWVu3EGjAzbMdJZPM7RB4j?=
 =?us-ascii?Q?g3tyOx1WAdXrz9a8uH6lmBKXY3A1haRlXLYfv2lyHgwggRavISfUX+E68Tvj?=
 =?us-ascii?Q?igmp0bJp+MJ+KdGDpRgjTn+UqjTiYUDBwmUy+pngCzZNfBf/YWSNt5LqRgXl?=
 =?us-ascii?Q?3WJeAlXW9QSCYFiXnKPJxsZxjTt6g2FSka9ZIpeyaiqnzDXngkGMvSGjCo3Y?=
 =?us-ascii?Q?Sv8CEPDPq+VYf6YaCJmIdYdveECi/Pa/bPImuaghdPoYdyRF10sx0Jq8seJU?=
 =?us-ascii?Q?HA+EY6q47kra2RFBm5ieSykwUvFDJUkombz4BcY+uf6cCYmqEFkuhB5pZDbU?=
 =?us-ascii?Q?x39WVjlo7ltLsmeEt3LENlGWDnj9dQ4guatZN7eAdcp1XiUWwF48LgyvEtq8?=
 =?us-ascii?Q?AgS4fzKj7ZvCPGYyoenLsLMZFJDIm6rQF46VbjRx+2OIrDZXjmxxqNIYtbUU?=
 =?us-ascii?Q?lhB8QKOvRaxxJOpKg9JVl3v4Sz/NVzvAQJVVIFq906ci1SEEnB9cidVsB/3W?=
 =?us-ascii?Q?2h5ngGhF8xZXoGALOXawx/tvi2IcQDgzwtRf7YwUt3iyfZh3347fQVkwjQTc?=
 =?us-ascii?Q?YLRCuEVqQTle9c0qLgaiXjG/7DtO1zMk8kU6X2GTUMsbTWZ08ucTaz1844W/?=
 =?us-ascii?Q?e8wJuWvzEg9CME2kxbpE4OkJ9fgf+aZBJEsdC/OxEeWLdquxBCtfz8Py8GGe?=
 =?us-ascii?Q?i9F8HtGs8PSAn8f6BHUtYCRr4xrx0G4203VnFjZCtRZkUOJTeVOTWy94MJN3?=
 =?us-ascii?Q?i3i2OOvl17DXkvRvfuFroIza/86sLyl7Biyr3UXMXbueZHkhPlEmYdXtEQBp?=
 =?us-ascii?Q?N7w2Kuu0BA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pTxv2f6atCw6Ux0f+ZBxN+FKAC4dFNTsFCHzwlGtkirw7oB998pgUaGy6FUaiPmvIDrsksLXW7Lsg1lMppUTP7M7D/abXtRjsZUgMy/yECE6sZGTXa6RZKsOBCKbRy/quERflbe3m+0nG7lJ0fqLcG/kSwCKtKfy2MJo6OsI0c7MoXNlnJG3MUfA9WVY36TMnkj4iWUMxcCvOZDWOR8PUXRgXZuzIqlrSoPs8soXiC4qf3CIA916y9WsmIqb8mG8Ez3YGwA8jv3XBeYRSgtEU1+KRwUiSh4H02JADIalqKBsxVmA7koec/EsR5q70np9lmOXEZjoEzcvBV52osHUO/IX/rVbfuEweEMI9dtLv+xJabNBk3j/gK8G6yz7AUqCZ1NehEZZkw/dE+eVNI3HqBqxUiexQ+Y9khAKoX4RkpeN3mpfP6sCYLgawh7LPWAv7w8c+K6EZd0iEi9ZzQ08MXqdnotyUNe3CgIhFDDkDd4lscrtkFGyGDg+r8XlDwbqi6dBSHMy1HtZ4LblXlwPAg0YyX57Me0K9Q4/7E/M2lO7KRYaRmiUADQMPt90FyDUpY2glOANkBoYDywua5ND2pSksjYtLVxNYi/YdEyv21k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b7ad3b-04b3-4636-9e33-08de571af1ef
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 05:23:57.4806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyb8wDXH9Z7o8VgtW4Qcd20QUfBDPqhGohKt13Ba6+VzMpGowr97hSt1Qo1r5hbNLXZak+FdoDrd6HBIXtVJ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4702
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190042
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA0MiBTYWx0ZWRfX8lFaO9ykdjHS
 VIGwN7pyNMCmJ6NfA/2k77KVFKM2rzXQ7JKMkBGQXorQz0qzZdnBxsIiu+K2STiClpGxdSiUJ2v
 dAxr0L5lSBhV3hILst5rhAToi8Y7pr0l9aOykxoTdmZJAGGnm2PdOdT6PHijPLS2p6/9YXDJriQ
 CNNZiUcFFUA8AHlax0SJ+c97ljxdy+66+Gowu0LpTJ1i17bbtZkKvmsd9p8+U1KTd2TIFIA0coz
 cvfZxNmgoAo3rlnxYf3sS/c2/TV430pIe7m124+C6pEWPftSsl0sFRgMYbzdusSWDbrddBYbm18
 yDYhu4VBIdcZAbziIoRf4m8ovy3xs8fUfUvMa2pNRM3yIHp3F15hf9ZyNj3iZdnntI/ncJr78I1
 Jqg03AvjUJ6+Td9Q+0kUAD400W0N8v7IfOPIsWXECQopWvP15dvFDypgc49HhsQIlWHwVsXnLEM
 EpVQhbrKIKffpQylT8A==
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=696dbff6 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=CtFNG391Hm7LJwxQceIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 1x8UId_OGlfQDmFveKIk3aiugLk9C6w7
X-Proofpoint-GUID: 1x8UId_OGlfQDmFveKIk3aiugLk9C6w7

On Fri, Jan 16, 2026 at 03:40:28PM +0100, Vlastimil Babka wrote:
> Enable sheaves for kmalloc caches. For other types than KMALLOC_NORMAL,
> we can simply allow them in calculate_sizes() as they are created later
> than KMALLOC_NORMAL caches and can allocate sheaves and barns from
> those.
> 
> For KMALLOC_NORMAL caches we perform additional step after first
> creating them without sheaves. Then bootstrap_cache_sheaves() simply
> allocates and initializes barns and sheaves and finally sets
> s->sheaf_capacity to make them actually used.
> 
> Afterwards the only caches left without sheaves (unless SLUB_TINY or
> debugging is enabled) are kmem_cache and kmem_cache_node. These are only
> used when creating or destroying other kmem_caches. Thus they are not
> performance critical and we can simply leave it that way.
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

