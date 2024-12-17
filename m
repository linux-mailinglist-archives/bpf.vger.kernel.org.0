Return-Path: <bpf+bounces-47140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D05E59F58CF
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 22:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 555697A327F
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 21:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1F71F9EAA;
	Tue, 17 Dec 2024 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VwAwjqpD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o9Uce7iB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CBD14A0A3;
	Tue, 17 Dec 2024 21:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734471373; cv=fail; b=hkHm5vQM6m2ROYD2kQatfIV9bhuisAveR9X+YTjG4Ccsfto6t6ZRpFV0UiW3gsJqOukk1eiIOMivSxwFJNW/Bi096ePGE5i7Q1OJjzeBuW5IVPGzXw6WN6Wrix7Kog33tPmrwndGADVLddUQQv0tlixS+gHjocrtqY/tgtWtF/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734471373; c=relaxed/simple;
	bh=GRfOIMvQ4LHrVU+aof0bRzzSfREJIfvAgzZcx7Gdtw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=APClkKnXMSqXWS42ysTp5WyUH26GGRrBcFhcm5ckVAvZ58+5FSm++xhxrrIKPt+Q7LKX+4K1grqfOw3/nehBkw6SpPjwTF3pWmglEKAw6LMujdh+35QT1mXE7jW8ELcPsm1PHRurgzJF4XCbG106UvjI+ghFWVoePJdiLW7cegM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VwAwjqpD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o9Uce7iB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHKtfAd014434;
	Tue, 17 Dec 2024 21:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=bhfaLcAMQkSLuTlyRU
	Ltgkct14xE4uEHWCTzqf09CNo=; b=VwAwjqpDZyjuTtw9A4HfmdBN+8vSEOwyYy
	GKWyDbXEG9742U2uhEDK0yY15kWuLLrEnb4Dmo58p00wTqvwzTt56navmKx5GxOl
	cCJV3iJcT/SOTIZtXDlAu4xJx7WffFvt8X4BrUzo4JhAbwQw8e6ZPz8/AdFVCnwJ
	LijJNjQ13IMtFecA8rD+VSBbmedj0RyOzukhe5upNrcXkby5E0n/lJX63ftAb3qD
	t+dcSKAQu+nMLF928dn2edRGJfgkJZDl3f/71qFjLMhTAhuwgDSWXPqglA23otr+
	DyOfrF+eDhZp8zts4QuBw1qlyDfedLktI+XDhL+QaTFGpeJb8SGw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h22cq5y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 21:35:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHK12bC035471;
	Tue, 17 Dec 2024 21:35:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f910xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 21:35:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKYf0ot2eT9xlR4B1K21Xz/xMKZ4ykB31NFYvoBWeLYLnT2WVGLckh3wrrGQ4ONZbNiByAYOl8I3DXQbhTmOyAZij4t89jne1Y7/1AfiCbcnE4w9X/KVPtxhhE63u8FShyjiudF0TS3qV/qW4T+dhF6ymY4NqE8VakAOgwGsd57Dtr6QdX5vGV+l6xVoHXlLZtZfxaEX/ASEBP6fokxC2BmFtgA42CkJtDSvx06Z/z87Uf4TIWVBhfKIhHEvI6fwfwxqDW3fP6Rf0XWRAExt+YCLHh+Ppb6lJIwbyP7LdG6gSu9MM3tF5gElBJTq/7hhii6itSRJOeW9Zxmn2nykXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhfaLcAMQkSLuTlyRULtgkct14xE4uEHWCTzqf09CNo=;
 b=Nn2VX86HIRXM9u/URr96+b0XC5H0LLSxuiwp4C5tvhCnEW6TRCkXN2bQIs3frAk/dNN+wDNvAuFIkz6qt8rjY7dGn49S4WfSIc3muI4qWSEjtfpWy7lDBPVsxBtV8wz3EdTp06XQVSKYPcpg07LNZt0AWwAVa+yC1SX8zbV1ny6eCq3fpijlTDK7mcaThaIo4HB0m4xaEcp+y6+INpo01vVLylnLAFR/9TJd93SZoucZHYpNX7lkzQjY1Q7LpuUYrzt9ByBRpPuTcnagf9vt3ese7/MEbY4fStU8FGycPxzaVUtJubou8D0BPwFl8isgF1dJwc9nvtVG7sf1SNU28w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhfaLcAMQkSLuTlyRULtgkct14xE4uEHWCTzqf09CNo=;
 b=o9Uce7iBToyqLs5a0XSpH1yU2kkTdO15fEWAT5DzZuDiW2ie9Qlj/F7m07T6vQo/RIG5CZiXPFVx9kdI95aDKr4YZLsxwlADpQdbNSH+dUSUXvjGAArNUz/TCxW5I1revJq5qeXzxfYMTU+/08DmljzFbjs8dTfFn5Dm9c8Oyz8=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by DS7PR10MB5216.namprd10.prod.outlook.com (2603:10b6:5:38e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 21:35:39 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%4]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 21:35:39 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org
Cc: yonghong.song@linux.dev, dwarves@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        song@kernel.org, eddyz87@gmail.com, olsajiri@gmail.com,
        laura.nao@collabora.com, ubizjak@gmail.com,
        Alan Maguire
 <alan.maguire@oracle.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH dwarves] btf_encoder: verify 0 address DWARF variables
 are really in ELF section
In-Reply-To: <20241217103629.2383809-1-alan.maguire@oracle.com>
References: <20241217103629.2383809-1-alan.maguire@oracle.com>
Date: Tue, 17 Dec 2024 13:35:36 -0800
Message-ID: <87r066m1qv.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::34) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|DS7PR10MB5216:EE_
X-MS-Office365-Filtering-Correlation-Id: 259fcd44-dbc9-4499-92ae-08dd1ee2c003
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wRVQhWPQTFhIxgObOPGk3P48JEDaumvfVdplfO9Z9rLRTMHCGYT7HrrW/jvh?=
 =?us-ascii?Q?Np0lNt3+6AWtnysJ3rI7qWYJaJyQY/pMrCZUtzqKCpxOD5uwr/CCldamjdEA?=
 =?us-ascii?Q?dNhK9Vgjg+aCMDLx6GQXd8uUIkoW58HCp+vuomf8pAQ1qLXoS668iOrQTj6n?=
 =?us-ascii?Q?MyW950ufo4u9pURFKagJnxjyi/RF1kHkbzvoWhgruhdPxnwHyRjCqj/mVgCh?=
 =?us-ascii?Q?J9ojUD4E5evYizdWYhdngS9+auxv4E02oc0NYoUSLalFero8hXLMramiQS/6?=
 =?us-ascii?Q?F/xAXWjHk4QP/wCwfXRKF5cH6l8gzKtxWmmKro2ViDcXVP//dynp1zTL6iBd?=
 =?us-ascii?Q?N4YynCiIBnDkN5qMAXF4n2k6HXVyqNWE10rw6ugH9WPohX14RfZ3frsG5G7W?=
 =?us-ascii?Q?PvS60Os/n4K9OqLoEGz80ht9TmhjjPL7ONupv5m5lflC//FCttkVZwZ7is2O?=
 =?us-ascii?Q?cfhznp1fGNBdvoygyVqrP7l3X62p685i1/+D9HJIVqtiGKfOBe+VY+Sxuo77?=
 =?us-ascii?Q?Zf0QJS0NaFM3XBcPybC6fGXQ8yCHWUoJg9ANlvCHyMbgj9dFtsMQB0q2ceST?=
 =?us-ascii?Q?IIV5LfbwqzIb6cWBqX4h1x6jrGsiITZHu2TMEohu+vH5vwWJVF6kO6Emd3Vr?=
 =?us-ascii?Q?XpCN8f1NPxIWk2VUvAwbayegxMF4qEApuKcUtnESkKZJAuFdvSay1rrmXEYX?=
 =?us-ascii?Q?BFWaN2d6+oh8afxdTxZPTVllZYGfSKQe6tK3Lzp4r0y54Yzl0LfqjH68p9uD?=
 =?us-ascii?Q?DWUIsP/T/1JYYFzcqWFxcGEgizepJEdXrrP1fAu4OhklrQIp4S2wPfsE2Efr?=
 =?us-ascii?Q?o2OCdy1YR0ZBdpx20TzsDaGmf6ervDblDGXvnZOkePyjVCXKAl+u4Jei3vAE?=
 =?us-ascii?Q?sqqMiw+x2wv91UctUMn12/vGinkVRzVa4aIPWO1fghwm+jsMjULjMG/OubvU?=
 =?us-ascii?Q?ZORrCSbrN/g/vSR4Xg5zlOljlKFCilq7OyJNKwCqB30AxcLzcXh1udRaZQ4O?=
 =?us-ascii?Q?GjyFYEjRKrRXN2YmHN9aQOfeE2H1n9RWSBvR7oSY5bwNMIlJFi7AGdR13TmS?=
 =?us-ascii?Q?9lQpbfqvDVe6AHGfJj/NJEJQacLnR9+pAwGvi1YdXax2MmomCTOKTO6yjkW2?=
 =?us-ascii?Q?9RZhsPdN06H2fkBdtXwBD/Uto9/hvCrMyminV2X2CrRygRTv3f89zsZN0y96?=
 =?us-ascii?Q?G3/Qri3c7rY08zxSOppDvarRF3+XPTgXOZC4QxUSLUho0E37a71s/u27MBAD?=
 =?us-ascii?Q?oQYpfriD/rcne1bl+qRsKAeWKTwrg6a1a0EYLJiG1g01IuAmQkP1Jgp66MJQ?=
 =?us-ascii?Q?nkAluaf/bBr2AZs0Errz0KJ1pbqfmKGqe1IBB9xFJjZZ92YMjPwTzAosUjCL?=
 =?us-ascii?Q?8fQ/+233NuF+bLhzar+q/rbf+jIy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fkvyEvGqoTlcc2B/WUCFL+5QkcTumqWBEHCMitnBci1mUu8IFT1E35qxzqgp?=
 =?us-ascii?Q?RqXn4te/Wtv+GmBp3vF5DrBtgkpUD3tWDQ/cOpivbfnUbCTVSMe9cXJPILEL?=
 =?us-ascii?Q?J9DN+IWQ4ad2eaqjtDl/Ld8ihX1M01fxRHitixTHMXkXllUVndZN6wmN62mP?=
 =?us-ascii?Q?j+1p67bbc9scv/mVbk26CAqlODR3zaa2crn5lVZyYcc7OPLFqaCWZ9+uoMoo?=
 =?us-ascii?Q?2RHjRM4lauj3lJRufYRrkwHS9MYDoHhyDd6Fq4GU0sEpVWgZ9sBfd1ZX/FLr?=
 =?us-ascii?Q?W/B4o6PE10hOuh9P/IupfWdEoUnL5axyOIosbnz2mU3ScW42eMTalVjdTS/1?=
 =?us-ascii?Q?IH5u0Ij1QhUEQbo3dibMUpd4K6YPBH3SgnAvktnEVzStPQNiJl549XRDNk8x?=
 =?us-ascii?Q?hjK78UZlyItLTRACghpVC/WnE+OvHfSfDlCcLCpxRfzSXi9Z0hpTFmHChzH1?=
 =?us-ascii?Q?5qx0VB0oXqmYwT4nZ48TvIu7QDvG6nT3UgjjEaycm20hCvmeA0462dgfF89B?=
 =?us-ascii?Q?3Z2uqqka6nJBhlcomE9XjbAF4qCBJg0GvmrOd29pTrotE6raZFhE6FVJddgU?=
 =?us-ascii?Q?nU54nAXKe/cyCHWK8VgWTkmL0b95j9ptejxzRZbn7EJWEqbw9OEUsf5ghEDj?=
 =?us-ascii?Q?Pw1LarRxkfzdRBfKiRCfbnLtO5c+3pBdCQxzM1eir9jqq3IB0gEVMLOXVF2F?=
 =?us-ascii?Q?eio9VyguTfUgnhaWfA3K3LrZnPzjhHgjZyq8mxat1KQ+B6w5L7PMkeuZ6ngo?=
 =?us-ascii?Q?eZH39ZhxdK41SZJGUgZOe1YqTRi4fp2IzdMVj1EKcyr0H98hSi9vFPBe8fPd?=
 =?us-ascii?Q?T0dc2p7lUg0G1y880lEuBvFOrCmElDNghBrtOFQfgWmyEofvR/gw1Boo70Yr?=
 =?us-ascii?Q?WIaV21x+aM6x6BlVozJdrRHb6kjFmmc/89H2+59u86W7lROvf2QFInjj6PNw?=
 =?us-ascii?Q?fnVM51MObOo1Mo2cqCt0e8cgTwhNHvD6FtIDBzVHjO7nQr22siRpEhVfOedO?=
 =?us-ascii?Q?L4eO/jxg6JdU8AZ3kMBdqIlrrH/FRfRKjM/UaqOcDzm2YeLlpRdYujIHVYSG?=
 =?us-ascii?Q?wNPsw67JH/DaPSJ++fm97L5SCbyNtfs76jhfUCVJcBSIufkW+4fXn6ntIIP7?=
 =?us-ascii?Q?I8272/yvQ9hmU7GpWHTstmHd/BPmW9bmE6izu8l9ZPCh3jeppbkPzNDgXdD6?=
 =?us-ascii?Q?m9+zrhxUa8T9vugwvWjTLcTDvZPbsbQ1xB5sx0BsWWpVeWSshBXkIylDeWlj?=
 =?us-ascii?Q?Z97t5EO6YIMZ3tfhG3MOFVKqw847ue2E1NGeJ9QaWWRFNIIEh6LL1kMdCb8u?=
 =?us-ascii?Q?dOQdr/NhP+ROeqsHomXOMCDsBoQ00TaIIlgGwDO/Tiwvt6rjDzBehrojd2ww?=
 =?us-ascii?Q?BUOvO0ZIrkBKxgIu+2vQK06nEJx1e+5U2QJGEgkYy1Wb25wSvL55VYHO9LGL?=
 =?us-ascii?Q?MPaezDm5H4bOHnwkpRpOxxwEwANn/jpyVrf3h6aJO1NQDR9EFhzwEvPJjFl7?=
 =?us-ascii?Q?Qv1bUvvfttBMKyv20ZBCmhhVQQHBHYhwFrAfVeGGdmeEHDx1zs8i/JzW+aIF?=
 =?us-ascii?Q?TsnWG4WHxGiQvpcDM/QdHwEt3hQRc2lJCvP1ahfMp8i9SmG8lbRTuvBv2eU5?=
 =?us-ascii?Q?s2/1X6itB7Knx6MIhWnJ8FY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e6Lkt/HtS6TtyLW1zFjw8+R63AiMQFR57SJcceIMk2bBbNJU+ag05fGr5ftu6Q+t6nTsN/SuX27wHGXOVaQyoPm5AD2KxF8xYiR46aUVv9UNf3Wl+Fv0lTu37iIlg8VpkCBi0ic0cnLciPi/kLhtXXhvhXGbHgj+IbLiMsEYy/t57ovYXBlOyyB70AUtrV5jABN2Fw45op56YV3AZgZ21raXWjZRv+E34B7nJBQJ3/C39QRe8uPamhkw0+psoD5yHrKQOhv4Mdlxh8TSooIxUBbAZKwJF1WSX9B+/mVlHN63mR7a4QY96Rg+4sg3yeROYrzSdt9JSOVCQtazgF7K1zV2s7BxUj41YQy9ivi3Y/8KWOfW309pN0DWzKeKVWPVXl+G5ZKSeAlb0hjeOA6PLaj3IgBMuGgNsf5GWs/C3DxWSaCVxwozAxotMrU+zk4uzakW6/GsMSv4tMUltrJ1SKh6HriS42v0lfMbGdjp5UrMnuXBgkuxFIDS+6UN5ymE7QnCH7Vde6r9EGxpAb1ZJSaQUAWKNXU/AnDnU6Pp8/yhbb8SQgwnSLBK/7tSY1mUHXDCLjhYWJWOBEaiAMr49AsIi0T9kBxF8o7+gK1H/Rw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259fcd44-dbc9-4499-92ae-08dd1ee2c003
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 21:35:39.1713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NkPIx+MOdTEPyA2itHIFefiNDTGz25WtHeLTnPbItx8g8Q9Y2x/KEfgMK9+BfRpxyfE13VH00gBKsycs/WBH0LYlF33qQaHb5/QY0q2iL7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_11,2024-12-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412170163
X-Proofpoint-GUID: ANT5yoxlEHWhIZCYQ_olFiFe2RSCvvj7
X-Proofpoint-ORIG-GUID: ANT5yoxlEHWhIZCYQ_olFiFe2RSCvvj7

Alan Maguire <alan.maguire@oracle.com> writes:

> We use the DWARF location information to match a variable with its
> associated ELF section.  In the case of per-CPU variables their
> ELF section address range starts at 0, so any 0 address variables will
> appear to belong in that ELF section.  However, for "discard" sections
> DWARF encodes the associated variables with address location 0 so
> we need to double-check that address 0 variables really are in the
> associated section by checking the ELF symbol table.
>
> This resolves an issue exposed by CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
> kernel builds where __pcpu_* dummary variables in a .discard section
> get misclassified as belonging in the per-CPU variable section since
> they specify location address 0.
>
> Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>

> ---
>  btf_encoder.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 3754884..04f547c 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -2189,6 +2189,26 @@ static bool filter_variable_name(const char *name)
>  	return false;
>  }
>  
> +bool variable_in_sec(struct btf_encoder *encoder, const char *name, size_t shndx)
> +{
> +	uint32_t sym_sec_idx;
> +	uint32_t core_id;
> +	GElf_Sym sym;
> +
> +	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_sec_idx) {
> +		const char *sym_name;
> +
> +		if (sym_sec_idx != shndx || elf_sym__type(&sym) != STT_OBJECT)
> +			continue;
> +		sym_name = elf_sym__name(&sym, encoder->symtab);
> +		if (!sym_name)
> +			continue;
> +		if (strcmp(name, sym_name) == 0)
> +			return true;
> +	}
> +	return false;
> +}
> +
>  static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  {
>  	struct cu *cu = encoder->cu;
> @@ -2258,6 +2278,13 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  		if (filter_variable_name(name))
>  			continue;
>  
> +		/* A 0 address may be in a "discard" section; DWARF provides
> +		 * location information with address 0 for such variables.
> +		 * Ensure the variable really is in this section by checking
> +		 * the ELF symtab.
> +		 */
> +		if (addr == 0 && !variable_in_sec(encoder, name, shndx))
> +			continue;
>  		/* Check for invalid BTF names */
>  		if (!btf_name_valid(name)) {
>  			dump_invalid_symbol("Found invalid variable name when encoding btf",
> -- 
> 2.31.1

