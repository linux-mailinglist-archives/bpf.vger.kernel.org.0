Return-Path: <bpf+bounces-68374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78036B5701D
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 08:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1652A3A617B
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 06:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE912773F0;
	Mon, 15 Sep 2025 06:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lcUO1fbt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ne4KEMRn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01E8278771
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 06:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757916912; cv=fail; b=L27o+axmUQfSjcta06UyQNOG16PnFZXYEgUnOGHG3zaTav0vdGmSQGpxm0I5SUfY0faIh4wMvIEdyFglBetcUNcWJaTu0LIeJNZd+nVj0X9y330D01vJCNTCQGF37c6zew01gMrGS1w78aHtCYcKJ/MfNZw9DZ9HYin5cC+yiQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757916912; c=relaxed/simple;
	bh=O9DKJ1WDE4YglFqOc91Qd5h8/09LmrU7e6C1eVynu18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k7wEG9s6P+q6Yj80N+8HpAMmqMlRehpxeZ0fee3Z9GjQFO2tiaNruKu/2FMKyTGdAoVD0ZYdlktEHp55tcNhSY5kfSEn+L97y04PFO6ari5qfkidkkpWVTzqUuzjnpUnB8SP78rtJwTq44gYH58op4Fjg9ljm90QUXs9rRMe+Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lcUO1fbt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ne4KEMRn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EMqWk6001745;
	Mon, 15 Sep 2025 06:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=I7hdbDaAR9yKiW5/he
	FP087iphyGjpy7XNi8XeEogOI=; b=lcUO1fbtnvC/J12cBq5fme6cPvBi6vXFeC
	yQTDlv+MvtLr1yl5e/2k5TiTfm9FCithAQ+SKGsDll/uAgFQPqUMOfXLb6/9eJ40
	s8bXbwzRkgyGPjbbKsZo2a+IyhB2WqJa7SgayOF+H6SUYIbeYFWkKxdkWwjKUzUB
	yvh2zBgsf3/foZU99T9BAuGE+MCkV1nDYCHt1TKZWXJd+aWXP13cY3m1S45FBDRB
	Zp1qNVydstgUIPqGhPKKRW+4/Xg3qGSh7FCaJZIjtw6JRQLw+iJfXmB8ZBtrA324
	5bGTTpp9V8CCwrDJKCl7/lic+w7S1YXG0s+SAg4tgMTXFyfV1USQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49507w1kxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 06:14:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58F2g5S3015609;
	Mon, 15 Sep 2025 06:14:52 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013041.outbound.protection.outlook.com [40.93.196.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2aktq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 06:14:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVpavG2/O0X7BGM+SiujZ1BabOYQgZNfabTu0S84skgNbT08s4UHYhdgW1tQJuEp8wDjJB8vzZbnFmhVrFilSCaFUiW/WJ1LLWxq4W/NV5re/UmcT2DJPaLhfmo+EDHSc40TfgmMvP0860/cDUV/Sof53nhdMSFAWZxUEcGpKqW3egZus1fRBuR9iJSeOPb3xg62276SHzTfzeiyJx6nasxxQ/P3O6J9GPhdiqsBWmdDFPFCi6cQiPehsam4Jk0LqqhLtdUaNPgZa40Spbho6D9/DSTMcLVgUaBk5HCCd+PbmnccSZSSJHdQFmhASsUEFR9jQp9SFpm9MW5B7w7Otw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7hdbDaAR9yKiW5/heFP087iphyGjpy7XNi8XeEogOI=;
 b=OPuSJyE2O7QZkkDB5jLhtdR9Q16JD2+/7TlwATAxfWKLq1gprjGVKgs494pMTStOAiy3MvQXjyn5xC4Aazd6efosoZqk0yT7SYpltlFAZt0Rj2sSoBNQzbj5ZKyIORlpcusC9Bfdg7qF7x/Tjg8AIqCYEakfsW6c0zAELD+K3aX2boj2vGb4SWx6vAPX7QYI59+pH1YdT5lJJuBMDrHgnFi/ZG1pHyWsgGBAJNiigTfweH6P6da+B+NHatXLtxTWw8VNkShPqF7bixzEmBU8ZhI7fXwFmtOxL8sufwAfTmGtztamFA8S30LDFS0nJx8+oYvQ0CpfVAntvdMG4cO0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7hdbDaAR9yKiW5/heFP087iphyGjpy7XNi8XeEogOI=;
 b=ne4KEMRnvBOJoGYPucLoSk+817UmjY0q6lvXtdPtUdG6n6//yBisC/PfmJYrOwUoVhmQfOrK4AeojNJU+3HCQKmfsEpR3VUrLnez+9Ah+rTDSKakGLX60eLLWHQDbFmH01LBBJeWqcscDHSsFhrhn/D2TsME9i+QSrD8kVh+el8=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS7PR10MB5133.namprd10.prod.outlook.com (2603:10b6:5:3a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 06:14:43 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 06:14:42 +0000
Date: Mon, 15 Sep 2025 15:14:32 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        shakeel.butt@linux.dev, mhocko@suse.com, bigeasy@linutronix.de,
        andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
        peterz@infradead.org, rostedt@goodmis.org, hannes@cmpxchg.org
Subject: Re: [PATCH slab v5 5/6] slab: Reuse first bit for OBJEXTS_ALLOC_FAIL
Message-ID: <aMeuyGJTADzvbx0a@hyeyoo>
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-6-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909010007.1660-6-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: SL2P216CA0211.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:19::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS7PR10MB5133:EE_
X-MS-Office365-Filtering-Correlation-Id: ec494e34-26ca-48f0-e443-08ddf41f28f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QwtznoTLZqnh9zq3k3ELioD7Zi3UaBhl9ympBL0Q0uuB2tjtTfmnVdF1JRQO?=
 =?us-ascii?Q?4qnYAr+Yiv8a4WB/6+lDwc9GA3PHkuFd/SFBO1y2Hq2vDAlgdtGDUlq1E6rb?=
 =?us-ascii?Q?A2W8YXWFdPkb6vSnvfqY4P3urp9vnrojpqhu8YYRYqro67k7zZfUU334CpUu?=
 =?us-ascii?Q?VTkuWZ4+cySI5wRhnZmLkvyCegZVZqpdZX/d2zMRVpaZpjs5bx0yGI+fwi9E?=
 =?us-ascii?Q?qLpd+LDbPbv5+FNRZoiJPUc2bHdkpUVW6ebS7R84G26J2f6XUTZr0jmXaMvL?=
 =?us-ascii?Q?iBD11YKcb7mQyCaVh5FyeAOhR/NGt51XswrlASs8x0jOvQHyLRQ4De7CT1b9?=
 =?us-ascii?Q?fBmV4mvfm6skuNbLdEhkjWbFGvZlE/+K+TpfRwUJY/T+6m7JqLRlfAEb8YBk?=
 =?us-ascii?Q?u4vHu7RendwgqjAMMcapVtpC54MMX+H35Nuxc3KJmm7YKdg+0JOCymRJXhqX?=
 =?us-ascii?Q?TO2UYEH8g/hmx6ZhqEms15Q8anknXbvClfswMKLfwXRwlY/DKIVRzdPxf2a0?=
 =?us-ascii?Q?ijNygMp57dfPrVi4W79HnjqPa0lfRbVpfF/8KK42wpFF6pEbfur1ksoZVByI?=
 =?us-ascii?Q?cDcuxpwBEKHp8P7YfOyTr6vflq/oaJVWwb1FyvwiGJxRuG/a8ryJrIvzgiHJ?=
 =?us-ascii?Q?rU70LiCKb0htxyxvtH+Sz8xMmVOMzTxenytN+Mhl509nDkBD6yVK5AycgKj9?=
 =?us-ascii?Q?hEVGYOZ2Ew+LVBcGNaf0MBAQIHL8M/P664I3g01APV5Kq4QWONK90DBysVHQ?=
 =?us-ascii?Q?yQ4Jsf/zSM6+nFpd/LUB7LKpgxkdi1IBD5XznvFLr/Wao0DlBg4/nfRzhvnn?=
 =?us-ascii?Q?yKNY37T2x4BHGFPHhS76JCaRhfKgUz7jGPiygO3Q/niZWbNATtL0FjIpubv/?=
 =?us-ascii?Q?F/wUvV6RXgRzP/xqMrpZgEyeMW4S1CGjI/Wa/YhP5m+32xpacW4JyODD+gfv?=
 =?us-ascii?Q?jzihilK0rE/VLTvHl3ytS8KIBbLYjJT86ERrdqe7K+ZPc1a+XGDa/kj4YO2H?=
 =?us-ascii?Q?u44FfKsFj2iwmP/ZTzrcT89Xz9zlvRbqSVm46vg33btrZ09xew56YJkkS2tG?=
 =?us-ascii?Q?BNZMSvoFnoeQC4x7Yfsd+EXDYKYSivg1CRn9ylgYsXLsKsjv9RQRDVtz27+2?=
 =?us-ascii?Q?nioB1Z3NOVQtAFWGRmIQQdrAhxyxmVVEGPQTdQjA7fSn2Sj4i8/Mnwe4tlbE?=
 =?us-ascii?Q?Qt+iOOjwD/KS4G1YfoFo/OTUkRAp2FR7G8nXtckjYO/hysUEBJZ6fYq10ZTk?=
 =?us-ascii?Q?BxpqIoVJDKONayQUrWazbDGDsplUYNJfhXGmnSWRxHwRCatDC0ZuTXVbMhw0?=
 =?us-ascii?Q?WTwAOyIqvtNmlmCDn8ikkoTjaW5KN2GpSVvWhOqURgp2WgZAPddGmedcOP5O?=
 =?us-ascii?Q?MJ7mikkpjjBWte0jLV6UonkdflvRE8FhVdxJc/k9fVh80dx77ozd8Bg9exSp?=
 =?us-ascii?Q?M9GDks3H5GY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eFEZde3sS4dt0cnTq6NU8OrYT5ju5rpBTY7nWshwDMMxGoNugzegATpIbws1?=
 =?us-ascii?Q?ajpjcX7wxQ1GDnFmEzlaU7JHLL3ykF0yV/j+eWp+3J21+CHhVIx55Y2GrvnY?=
 =?us-ascii?Q?5XIwhLkcaTebu9HkxsZ59e+UXNqVpgQvhDAxn8Ghgk07+lD12uk+mTvu8prL?=
 =?us-ascii?Q?jFjF57LES7HEXjFiNEb1HSuYYHFeVhWmYPn9X1DaP2Fy8bc7sxMElIudzwkA?=
 =?us-ascii?Q?XdEHy/onXWHKbE+3/5JEsiurHc1h8ZIITFlRjrvTdZJBeO/+2dDm7P40+5EA?=
 =?us-ascii?Q?IcXOLqFksdc8SksCi4NPq6xrOi5S0dDsbAy8Ee1b2HFCqJUJFtUgRrTI9xEs?=
 =?us-ascii?Q?HUJ/Nr3X1BhEEr4qU0LKKxSHUkp6EaslW/GF8gq+7lSSVepqveTBFPE2JQw1?=
 =?us-ascii?Q?MDVscNo71E03k8KQHdkQ1G5kdYK2CKwgDOHaWn6QycB3KsJlFksLDte9mJrL?=
 =?us-ascii?Q?LuzNj9p7I5m6e9jHD6T0jl9qV2k0FrVXZT9l6SnkNWYJxqYbXCdFYELVacCX?=
 =?us-ascii?Q?8AAbGkgrk65d7PWBaTabFGJZIXiNMQ/AiYW0tJDkEQzH05eeShWDGRuQEY8Y?=
 =?us-ascii?Q?BbEEgcNoCcQuiSEYBq2ImjkHIUb7s2W1wQyE++5C5/ywsUsbiKfOLO1xSjSE?=
 =?us-ascii?Q?gcknI5RBoFi/toP0LvAocaHu8KRrMibqPjLidiatC9LpHh7wg4br8HyUr5Vj?=
 =?us-ascii?Q?wX/yIAH+h0N3Ycw963dGjeD0xxCWOfMqij8O5nNysvDg0mIOIRoTzim2/Mfl?=
 =?us-ascii?Q?8NKj5tQCLKu0gc/manSBr39X4oF+wKPs7xw2X15dHfojX7fy+IHNSAFOB02C?=
 =?us-ascii?Q?L1TL3d3Unsd1RZ4ehPupla26P9eTQvPCoLNnjPfSMPo7ubGI7+dd3f2382l+?=
 =?us-ascii?Q?fWxRylu09nTNcFMx3DHbsBpGbiDRxQzV4NEW4oswrpQTJJzQkG67Fr3XBh9B?=
 =?us-ascii?Q?j7oV7yE8AAfFp9QG6hKwzSjIWO9pNi5DKOpAblEa5CcwZOBxSosBPzjx4TG5?=
 =?us-ascii?Q?nAz80bT4ruAEL+ixNxot4Bl4SMj/1grOM3bfEmsG0tewIv0DfBbxem51ORHL?=
 =?us-ascii?Q?nZaPTWfVupfQrbdGS6Ek8Br3Yn9LQBW2+4f8U4YjhnLT2qCyuTb5nPqjN0J4?=
 =?us-ascii?Q?bX5PedsET5VlLf4l3YlGYaTmJ77JxcARvYRCbz83vP8z0uQf7zXZQb/5QEWo?=
 =?us-ascii?Q?/+ey96YZH7dZ7ynylrsuYtTgcfG9V4fPS8xw9sNIaqRrfcAC7E/AJSOrSMZ8?=
 =?us-ascii?Q?X2l9x6SFVilLIkdBj/V/XPrR0aGLxtFOYq3udmxkGEjVz0isoryaZ2w8ZFjq?=
 =?us-ascii?Q?YKc9DYrirdieLvbPwZhFd4xECrP043J41r7NnrDjvbrI/ce3cl1+mQNR6pgB?=
 =?us-ascii?Q?08VEyUILaK/7zI2LK4IEsUXEWC+8IVT1WMPahxVBdKtaL90M/dZI4oRizjqK?=
 =?us-ascii?Q?dQ0NOmPs7zdGHCr3ZJxPx9ijUqsMen8d0aQW1TZKLbPib+OdkjBLyURd3EAr?=
 =?us-ascii?Q?4DPLRM/z1vYt6MkKBedJpydIYYNSh3WhDBDNLwkDtsGOCFVhrngIxPsJv54m?=
 =?us-ascii?Q?PQ6MYb0KUsLyVIsepxAqVpqLFzZfPTv35s2iHZjI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YekbFCjSDMlZ4DlMCu/u8c40Y19v+lCPsHWT4kvkJTF1JBdGiHgjvTWbh9AfXnShq7K0shDey6JRZZ1zt1u+k3hCfb9s0YkzANG0PqARMZuXNjyy/niompzAgBn6BXZOy4K4cmPz3GsmAJsra5lgDEpWNtljDHS124CHfwlXOBpAs+MFG9gNW752rlwZHQUeVY1GSB3LcveNBZJUn1XTM1tit5Y7rIlpryOsa/V2u+KKD2J9svhP6iqXoFp9Os07IrAI+yoc6kfSIKRaJEOV+wwPzysJhywPH1QDtqvffKk+euq9xbLYzctCHf4OAh1mLqWrgEhBLivB5ovfqMGWE+SWzZICwskKz3Sy57Q2HZoED7/fBQq2R/XLHHYuB0DLN7a7IQWsa2HVtvcthp+S8KPlNp5k1MCp8tt4vYjgiGYnJ4stD5WAk4TqozHsB505txJ3ZEuCpEBKdpl4Holb19+MBUvLvh9Xpmfpqy3dVK29sOk3Qb487Y+hw3UPgYCAej03P+VTznF/9kEKOFwvm7Fkt0RDJg4aRCkFOLFje7u6gDjyFK2QcjLaZP3ttK5HWVTaYeH0sY53enIu96Ohi7XYVX1NcZYLLwlTpM7Ff6U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec494e34-26ca-48f0-e443-08ddf41f28f6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 06:14:42.7430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7+RDtmqEYXFMZiH6uIWtS65OJcbvX1D14LwoNFPgmw/muKMDlF+I6sYhEx9wyY88k/Mtw1NHIJHH1oPAuW7mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509150056
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX+NBByqsk3T4u
 cOyh42Cq/uMfJg3ViAniMpCmMSf5sgpvcsOJMdkpuO/KQdA5ZWcCB8HNEMpLFOHmCRupYIYd6cb
 3aJDUcn54tpf/xGy596u8HdBYLshFmQJ85WpDA3DpmbQW76MRNqYidoJwu4AYDi9zclQbSC/esb
 043rHgcQcC5/ab2n1BNarpOK/2+GonEOv+28wiInvIJUaX0Peop95zfW7MKqchnSik83cFm9ZNg
 3Xrm6oGGgSxTcmu+jCNhDE9uQn9so9C2vHH3S/x55zZGkZf0KISIY3nXNBU2bhNGqTY62LrMupg
 XQib8pOL2OhwPayO9mOBY49Z/iqwksYjIeaZfwwGWczt5nZ2fCwwNyOjOpb9msgR+MfJUiP+QSR
 P96gng0maMsrdDXzP+3w+uCUNm7zzw==
X-Proofpoint-ORIG-GUID: q8JzL7zPA8XWA0-2EjY5b5jkpmWmjr7W
X-Authority-Analysis: v=2.4 cv=RtPFLDmK c=1 sm=1 tr=0 ts=68c7aedc b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=AuFHrS4SMvOuZaLcczAA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12084
X-Proofpoint-GUID: q8JzL7zPA8XWA0-2EjY5b5jkpmWmjr7W

On Mon, Sep 08, 2025 at 06:00:06PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Since the combination of valid upper bits in slab->obj_exts with
> OBJEXTS_ALLOC_FAIL bit can never happen,
> use OBJEXTS_ALLOC_FAIL == (1ull << 0) as a magic sentinel
> instead of (1ull << 2) to free up bit 2.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

>  include/linux/memcontrol.h | 10 ++++++++--
>  mm/slub.c                  |  2 +-
>  2 files changed, 9 insertions(+), 3 deletions(-)

-- 
Cheers,
Harry / Hyeonggon

