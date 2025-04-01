Return-Path: <bpf+bounces-55027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98921A7730D
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 05:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4224C16B89A
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 03:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4D81BFE00;
	Tue,  1 Apr 2025 03:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U15OdGcJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PJylxrAY"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6815126C03;
	Tue,  1 Apr 2025 03:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743478953; cv=fail; b=bBtC9PRaVuzBlWnK/eDXouLqUXTTRCfnuGnToCHKYHXQ0dJq3qVTYUE5cDMiIDgtZBxzkk2/5qmQGfS0aciVGXJlZTAodJo0EIUH8jHWxtIMjaTg+cIMqDBMw+3hd1NDMZN+9AFBqEcxmbbHjCkvYLtRwUueLVGf6Q77N4xz0ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743478953; c=relaxed/simple;
	bh=1suoCLy0WUgOxAeU5sBO1DshGFgVNDGfXpLMHTc3sTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bStzqkVvX3/RYl52QZxfNPAQT50ydpaX2KFk5tJGGpgwY3wn8NFdOCl9YElXHGP1ml43Pd2XiYS0VB7M1NXdUbj1SFxZDEjjKrUH8kUMoOdrGDaSlXuimqsbw0EPPePgBcZLzS12dcVbuA/z48+tLLInJtoZsyq/l/GBy29ZbTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U15OdGcJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PJylxrAY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5312wMxV019969;
	Tue, 1 Apr 2025 03:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=AZOq6twVXAIan3sPBI
	BXLQleBPdnwYGi6cu4RJsoFMQ=; b=U15OdGcJpawqF+pa+6sdESCzw/VxO3hklk
	D82uWYmfSzrIUNIzm4o3YiGC2jkPMyjd6YfSaXBvnW+2egOHwCLfpJbjFPlK/GLY
	/y1+LWwXAAqmmNKIQDUL1zmCfAqH/0uQZjZa4bWUTZc6Q2ZdvFh/yfC+x19qXjXx
	CRS2JZYJw6c8aZVwNiqfgkbnrAxuqqYLPOL+79lxoIO75T7mLola/dCynvL635GO
	P7ecdPaS4uQR8TVZokirjvph+gXI3uKZ//I7FEFglnRJhwim4+M1Z050fNWCi/e1
	EYiPU3vnNJVnEC8034cofZrqJ7AP4tr3D9GxKp7F1/oHdPxpkEYA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8fs5bsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Apr 2025 03:42:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5313A1FB032578;
	Tue, 1 Apr 2025 03:41:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45p7a8qr54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Apr 2025 03:41:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEhVzfyHbG2K8vBJhqcwMALvSzrDyJ9ndLdc/txB6YtvHUIypqa7EXVZYr+ZPTrNMYXRTvF7TvVHvHaDZbZbMgpgx8nRHZsvKBVS4RlQaotl9QWS8hBh2TGuJeGycrHmdCI+06C+LOs3fEi3zZCjAHpQWQHU4hhTsxyxGGLtWYjEFp7ngOPV4tP/aUfv//+cKsq8w4IZ4Cny20U2CAtzPNBDnczDyBjM+9pplQyIvLVuKALhXKUdnJRpVPbNhg3cxKCbMhE6O3EWCpsrG0HvU+gkn7CE2LKTnr7UemjsaTf+85p6NSC2HWcdFx37oxkQmUIbEEhyWo1wicEZKUQ+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZOq6twVXAIan3sPBIBXLQleBPdnwYGi6cu4RJsoFMQ=;
 b=knwwVLEkEP6oHIPcNdB2oQWzF0KUz91fdN8pvHF6jajZg3Ru1uFDrmbtFQ2pocGdAafXFNX8ID+0ETZbIxCBLesAyKlR18O4s2CQun4pCeBq6J8aR8w06PbUDVW20xqJjy4shAAj8hnrxyaNS2dpMSdyqidtbZCmsK92ZiLDz0vDmBBseQzgozIj7tpIsu2TYotFCk4U0MwLY/o4gJmAaIVkvQxzqENCQEOKZv5LpD14WjnycAkREgOtGyiNE3cR++3tIds6w4mdLwQul+/FzpGebVzYa3m4TXZa26GK8te8H67GWO8OjqK5tegX0tBJgY4Xd2NriUEk32hlc/IBOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZOq6twVXAIan3sPBIBXLQleBPdnwYGi6cu4RJsoFMQ=;
 b=PJylxrAYLxO0+OycASOKAYl+mHv4j5nMQ+dZOalNFPidI7NyqkUXAgGAt90fJW+SS9lX6itXYBSN6Uu3+AoWdI8uC2yZzlN3RFIJ/5VezayxR0vGckom9yEONqhanDHXPaGxzgsxTLRsgR7KjmjACmrxw3cJ2jG5LY/vdlYqCjQ=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH8PR10MB6502.namprd10.prod.outlook.com (2603:10b6:510:22a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Tue, 1 Apr
 2025 03:41:55 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8583.038; Tue, 1 Apr 2025
 03:41:55 +0000
Date: Tue, 1 Apr 2025 12:41:47 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
        bigeasy@linutronix.de, rostedt@goodmis.org, shakeel.butt@linux.dev,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Fix try_alloc_pages
Message-ID: <Z-tgeza8rrZONGJD@harry>
References: <20250401032336.39657-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401032336.39657-1-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: SEWP216CA0076.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH8PR10MB6502:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e9b32ed-1f46-4e7c-f0db-08dd70cf25b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?raA31bk73ODgpsy6pkijUXbPJQEEBh3dYWEyq2GUXEg5wBpNwWOJQbBnyI4J?=
 =?us-ascii?Q?bydnzrAYLa3va/b0Wmjc1C5wYIGiU80u1BxSUFefzIcG/2gNeeZOdMPKZx1u?=
 =?us-ascii?Q?LsRPAb3bN5ncJIpBWt6ksqrp6lwdyTGVOFCQsV7p2V/ooF81Bg1ecJvaAgT0?=
 =?us-ascii?Q?qVr5oqC39ovPeA06D2c9SQLM5iw23n/KFnt27IjbYa2WWYMPRrekEe/BPGEE?=
 =?us-ascii?Q?OgFaZOZnq4VLlv7i51Z+N+YVBfXBjISK9jFdhEyseYtmsxqiyCZs9DjZXJlv?=
 =?us-ascii?Q?AYutY6Lov9ccwXVeM+83hz7INzYErfCfKHwbWrEN2zVwdCLHZRPhLeJ3gAjm?=
 =?us-ascii?Q?nFZGBimzha4GUg5SQyc0wrpNFF5idnVrkujYueXUvBY2J3J8Ij7/Mqc0R1Pi?=
 =?us-ascii?Q?noOVfpqNi0lmrT1djkhYXmR1kzm3hiWkBhLYL7u+OmhxQPTuDVaKvtJCFrZW?=
 =?us-ascii?Q?R6dHOzuDW1kTl+JUMRFHLZRGl4RcHPxFeBTHHGf92X/5OAb06XbeWDnC1loo?=
 =?us-ascii?Q?PuAAJkDtJleMDwrc8hlNjqqHY2o0/0w41bR8cGB/k2pGCH1QGjwP1fTJui7k?=
 =?us-ascii?Q?tmMWV3TpwDHmJgzkrBFmn3qaa5814cDqNpbKyBvaDiWazpAixNHmcYk2w1vX?=
 =?us-ascii?Q?iAm1ftLFbEy2B2GXQIAqtt2AoPV+ULEmUJgas++oNZbnPkc7VupdtyVJZ5u8?=
 =?us-ascii?Q?DBB9qLyTyzONG2ofBImpNt/6s+e84OTpJcYKUdVH7Q4kr67K1SdoSw0Lst6n?=
 =?us-ascii?Q?L372j0jbCm0qcev4fvIc8AvwkQtW1yT9FaxMJKMxy3wXT+0E8OmpLGk+6WLl?=
 =?us-ascii?Q?3mQdPBZgPq9uJJQVBGewmBuTInq9MLEuUYN8ZMzas1eMf61C0vRtSiE6TkPI?=
 =?us-ascii?Q?pzYSAqxY8hvWNnv0//3k6YZeFt3SbcZ3HhWXUa1tYq28MRVemYBEPpfyapfZ?=
 =?us-ascii?Q?pe0ZAqel4jfNwhr1QmjF89CG9m6B15Uv1Cx+qKWtPVCzh4fC9wyfiT7lGHDZ?=
 =?us-ascii?Q?BrtYYmL3CD88+3u+jRaAqF+WR19x71UgvGMogTSmJrVkn7zdDHZKFs5aKHUD?=
 =?us-ascii?Q?xhnIhEMfyq1wpqJlZrfqvmhxxwZPtVvIUZNCjy2YE/z+C6jj09fE/UZXgTlj?=
 =?us-ascii?Q?HLYBjk2PxCKl6dg150m0AKVlGCFwE+Et6GOjzwKztlnFpL9I309nNvFyNsr3?=
 =?us-ascii?Q?4roZS8ee4RzKXMekOecYvyQ4Bou11tMZVIFvicGLCjmPqEsSFiZkW/ijIkH8?=
 =?us-ascii?Q?eo9mvg8qLFG2LsoNkL0ZHdfSZkb480LizLZ2r4moecw8ZRkY62P6PGrjaxSe?=
 =?us-ascii?Q?5EDPgXpx71u5BYPALC/xyXd+/Z3/Y6wuNx5vaCBs44XtGMDeSNxxLIax5L8D?=
 =?us-ascii?Q?UWslg2JkN8ugDdaAg3an3fPqDJbH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T6YE7K5luCpzHvZyHwQ5hQxFEBB40RMxFBCh2EPm8dJ0jdqGc+iPN0GjQ76y?=
 =?us-ascii?Q?a9G30Nr8WFaQkVof2+R5SyqXjW+VEcBVU/6wCTWelVfkaHDpbvEOckqAdZo5?=
 =?us-ascii?Q?hwQKGhrXUD8reSJfut95CljvwUiKmkW/feFHBvbzxRlrCs+MufRYtsQO7/MW?=
 =?us-ascii?Q?/oGDbYH5ahP+VquKykOaoufmERMbC3qLH8m6HxuSlNVQVSC80khaCti9sNU3?=
 =?us-ascii?Q?Mo1zkzpXg8pcfYtwQDhqHsaCqeVW2Mj80sSs3KB6FTbegaXL0+3pmz8sBT+X?=
 =?us-ascii?Q?6hLMcpnoL6ud0QJzZmDJUkMquVWTUZYB2EmHguBtmLEemzTkE26vrtwcC6T1?=
 =?us-ascii?Q?k52kQPJDerS+z9bNOYsI0O3QSK5xeQupAd+kjneBLvb0hmAp5zMoJ/H8Bbe8?=
 =?us-ascii?Q?sb5EXU4SjPiQi4SRwVOlTYZyc5c59lyxEqjoQm8XpWVW+lIi1j8YUv0q1qMD?=
 =?us-ascii?Q?Q1BqAqi5dzzniBKypU6zMZ+dFYiqpiU07jusX5eudPHMfZWtRYKSXCvTEyhf?=
 =?us-ascii?Q?toPWxO4ihOqFA0rczKp5ibewNIirbSNMKYZO+m0W29l/0HhIrlvj3IjGhH3n?=
 =?us-ascii?Q?4mw+dlT6Xb7r0SVIdvtRF9BCID0wZprh0UCZVOIWY00e4impdInUwG7njjJM?=
 =?us-ascii?Q?wUJYEVYuGUTLJ/3KKvzvhr4lasCtJ3/fK5okvB2zkRR9O6Xzw37K2jjbAGgo?=
 =?us-ascii?Q?nHAggVr0DO2L0T1WbJdecP+60joSWZpVIOmqoWMzqqNLVSro0RG1weh2jjT0?=
 =?us-ascii?Q?39rDo758d1mngAyxlcIAWas01fHNSvJA2wsblZN9Ru1YVMytt/6sHkXq52Fv?=
 =?us-ascii?Q?JIOFhhm2WU3f0Bo8Qfh9eLyQGoUwQ4Bd+ROuCgNqdi+9z5VIV8rQpH4IaMt6?=
 =?us-ascii?Q?Hc2jKJ4bKmOGoGBNRjH918Q6aKQzpSFT1M+f1JcycBTLyzdnTTEAYSXq2/RZ?=
 =?us-ascii?Q?HcG0xBgFgmFv+mvd4wk7Ad8pa62RnPMnqmmW3bzsn4RUJ5yQOfAKzBPj7ybK?=
 =?us-ascii?Q?FGYSyd7jeQFOgUxyJ5GhcW2vMo1woULRvjvOsJIbiJFI1bEi0HqurhHFfrj/?=
 =?us-ascii?Q?XYmf0f5oTxSXHTY08DCJj+2RVPW4uAq9UhSamIBFM7x3VWsFsOEW6TSlmHhP?=
 =?us-ascii?Q?9e/JHTa8CR47Gwxh7y9pTp6AQGXfYNwintBocjw8UoTdKjgs05KZ6yoQ1JYn?=
 =?us-ascii?Q?x5UfJq1z3qawR/D8aJHu61Em8QVXLfU/AYjbyPe/WBAOai27kixwo6HUeZ8n?=
 =?us-ascii?Q?kwSoPOCB1GoZYzjwivJk+Nb3Yn5eBGXwoHYkjWmOiiPvybOC4KpIaL9qjQlw?=
 =?us-ascii?Q?tymVU5wM+XGF2caPo/jy/Zi3fD9M3/0q/Z/EHKecJbp6jR5CLTAPNmBqulPe?=
 =?us-ascii?Q?3/erl6BP+0utf6+G8tqH9HjiZzshz2J1jluJDdUMD1Nleege0QZZwPToffDB?=
 =?us-ascii?Q?A+CAreAcKtortjrN4NV5lLJ4+tY7G+jB9XRtRc+4qpglwvxGzmktCv5wxBwU?=
 =?us-ascii?Q?3plFfLoVFW81ZK+AdPlwGoK/533WNpzrS9NiK+CXh7F5xIu2XKHGMiaMaEPT?=
 =?us-ascii?Q?KmlHjveuEkLDhM6yDu9kFBgUDxr1YSBRyGMOigQS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rDduGvYJCgZsoOCpCDLkD/QrMxGIyHxV2k7MJ/2KU/Fm2VFqCq+puz8uaJeKzl4dbfqLRTRk00Ipme2F3wMOWPyiwiVNZFMBacvGV3LhPQ6TrNz6rD7QlQ5nB0nS7Sg69Uqgp/P4+B0JOkUCJQKOiE7XqNd/I4HQq3djJSVPmxrQer16HgDNdghEdP5mTHsOS/wTNlvqUXnoOS4rYa9xEDLJt/M+4FXTXOsO21C5YCfVA7vys0jKHoo/DJBpMZkVVkM+DaXB94uefzQoM/dhY77fcDx3QBzqGcILmqssUwIf0IOSTOzvPggCAjnpdA1XQVFKZZanB0/sXhZGsTzifaj6VjOupUaWwZCOzMNzMXtcsoNnQmjb8dGhoPUdXI+Sw5o/VE7+YKiqDr+Lm8zAOZAlXovEsMp970zDnreNU+k4mDH/b9FWiPJ7pcs8x6uc07jwc6EGODZxFaYtcbAbBqnRStTg6kqXR7MtXFbj03n4OyrXD2TkgfvODLVeuH2z+7yoWR7/Kc4aGh7mXNWU3njIDA9zpgKg7wfH5Zcuy0qPB86nogPXwGFQjl8UrsTA8+7IGmhxQz9ZEmdUUc7LPSB3TCX4RQzN/k2cv1ADB+E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9b32ed-1f46-4e7c-f0db-08dd70cf25b3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 03:41:55.0861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWj6T0X7SycZqwvCwJA59wSaQ3HahNRaDJKO8T/pWyGXOBiUisECH2ORAzZ0wZnjYkJg+PZ+pWpecFygpUhc5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6502
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504010021
X-Proofpoint-ORIG-GUID: 4tKgqGgbzh_4YAeny2VVF5YT7Rr6YStc
X-Proofpoint-GUID: 4tKgqGgbzh_4YAeny2VVF5YT7Rr6YStc

On Mon, Mar 31, 2025 at 08:23:36PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Fix an obvious bug. try_alloc_pages() should set_page_refcounted.
> 
> Fixes: 97769a53f117 ("mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
> 
> As soon as I fast forwarded and rerun the tests the bug was
> seen immediately.
> I'm completely baffled how I managed to lose this hunk.
> I'm pretty sure I manually tested various code paths of
> trylock logic with CONFIG_DEBUG_VM=y.
> Pure incompetence :(
> Shame.

Better now than later... :)

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

> ---
>  mm/page_alloc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index ffbb5678bc2f..c0bcfe9d0dd9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7248,6 +7248,9 @@ struct page *try_alloc_pages_noprof(int nid, unsigned int order)
>  
>  	/* Unlike regular alloc_pages() there is no __alloc_pages_slowpath(). */
>  
> +	if (page)
> +		set_page_refcounted(page);
> +
>  	if (memcg_kmem_online() && page &&
>  	    unlikely(__memcg_kmem_charge_page(page, alloc_gfp, order) != 0)) {
>  		free_pages_nolock(page, order);
> -- 
> 2.47.1

-- 
Cheers,
Harry (formerly known as Hyeonggon)

