Return-Path: <bpf+bounces-68178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DC5B53A98
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 19:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F063B086B
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 17:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7DD362088;
	Thu, 11 Sep 2025 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TqejiH8W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="poTepj0p"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592AA35FC3C;
	Thu, 11 Sep 2025 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757612712; cv=fail; b=aIcx7kPnT5eV+Fwc4+cb06K/Gyz0MLoY9BaG59ztT1T//FjBs5KTvVjARj+QacYB1B8ZJy9BIGG1fcLIPAsjsYm9Z3NkyW/SdwZ/E8Q7NVMTGeX8ph3eNmJ+WggAIbS/XzN5X/EhQpQZ7xpEBt8otMkUQ2JK70vywzXjo4y5lwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757612712; c=relaxed/simple;
	bh=b5EZofqREnQhFS61RiV8XTGY0glsrWQ3OGXdiRXt+8w=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fsAv/q9S+pi3xQbhxHq9Y9JAKankcqFkq2RxE8+ZeLzmYRAc1fYL/eV4Ac/uHeOd3FOHKqjQnTo+2w+RIHjk185uKfLeJST2LZ5ja9BUYzgJfpUuE+URHl4zJsgjo0xgcLTpOZvz8IsBCA+2y4uLiyhb8xG9CaUcwXD6kZJnwvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TqejiH8W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=poTepj0p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BHBjvP028414;
	Thu, 11 Sep 2025 17:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=g1bXgBpmHDJ03z7Ure
	Jj4X3G3CAPBSWQQ6xTCHzQZBo=; b=TqejiH8WrbkmdtAu8lTL1eWMJAPaSuFy4F
	PHlyjnwwDYDtc/n9kXhVmSow8w2KVmHbvgC+WH6u0MYvQvAg1APnRK/gcFn7qlAm
	UvArhjYtiUDOK1UhXnZQ3AJbtxE/JGvEjA1E8TAbEVe+NRdD710pOpEvwcqhDJQP
	ZyVQb802oe6XA6GCMcfX9cJQ0Q7RBVrPsa5YBVOavIFFWMGNop5OLuTsGJYCDJJP
	sLQa4j6f5rnWYNDz8AEaBuNNr07gEuyLQvX5Zj6nJtVdwDB6CikoQbaMHxppI7n/
	osgv/y2VNBrc0XGG7ZrhUlA65ZPiJp/IN1kWUNuqT6sb/wuQKYWw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921peetng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 17:44:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BGfCte032848;
	Thu, 11 Sep 2025 17:44:26 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bddr20v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 17:44:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vgl/pM6sp2fz2Ab0lKXNO5k3XnHbO/b8Y/Ov7eAmpzzTQx3qslcHFp7cAtt/kGQ0AMEvv8RbDFLtdST9KBgK6nUzuEYCxVsN0EJF7/reTE+509QPIXtip8AD436+b22vufqLkp6KEGQ/cRhZ/AWSpznlvaJtpQ+NwPi0GbfwA9wSeIi4J7s6g8LrRtvct2vYVeKXspODl6MpIbGoXtJKRGhBxmlm7gTt7rPXuvvLSpHfDTO10baqzjrCbpjQ6PWsZ+bR+mgGDJD8xu6z59TZsP+zZVcKwgTPEyOUYkDU18GWVU7cCbBH7Bcr80Fvn/wGXUqwLxUZjdO6Vqh6tD2X2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1bXgBpmHDJ03z7UreJj4X3G3CAPBSWQQ6xTCHzQZBo=;
 b=dxcedqIXjXVHDxbrkMKJJKm/1MR/XehZSNOZJ04HZzjAbd4UErVLH04VNus47IGagEwGSJ8nvsFjMxq10cLTJ+C2n6tBMSsIy/cG6o1MEiGE41bpAmAIHmcblulOvvjDBYPVMltjlz3bHcqBYNlTC5YIlVkXeVOPuXCWIjNG5/cTTN6G7pHdGQ4XMK7bwyeTo4DVXWRPiFhlffd90HDI8q8E+RXQTwN/JwZij0Dvc6qWfd1EMm1g9CEhdEGCJH3bPoDV6rpgdnbKx4h54qkB51U0r4cyIjHAtwNoLIFB+edmxzg3UTOSdDBES77cKRqKKlUUjF8mq+TzImzQGyrEvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1bXgBpmHDJ03z7UreJj4X3G3CAPBSWQQ6xTCHzQZBo=;
 b=poTepj0pUHXbUnA47NB+PWcrcZ4KuV3nOO/L8tLiuHu2dbv3I3X7pOqra0EGCBrYlci+YzFhvPW8E2yk0ixBGxrTU1dYBybb0uZtJ4mLFhf8VSps4UCzVdDw8Cqj25r9PDJ+6478+QV2DBGXIUNCBYEN7465ztGoJflb0SSUwtc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CYXPR10MB7923.namprd10.prod.outlook.com (2603:10b6:930:e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 17:44:21 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 17:44:19 +0000
Date: Thu, 11 Sep 2025 18:44:16 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        21cnbao@gmail.com, shakeel.butt@linux.dev, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 mm-new 06/10] bpf: mark vma->vm_mm as
 __safe_trusted_or_null
Message-ID: <aabd3a2c-0527-490c-a562-95a293a849ae@lucifer.local>
References: <20250910024447.64788-1-laoar.shao@gmail.com>
 <20250910024447.64788-7-laoar.shao@gmail.com>
 <mi5gf7wvm3hjnfm3gkrye5mpzcxlmfkzy55oqhaqdbsnnwxjfc@teia7omm3ujl>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mi5gf7wvm3hjnfm3gkrye5mpzcxlmfkzy55oqhaqdbsnnwxjfc@teia7omm3ujl>
X-ClientProxiedBy: LO4P302CA0022.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CYXPR10MB7923:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e39d01-16a1-4be4-3c36-08ddf15ad5bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3AguUp8fkx+Jzh6dzyuDl+r7AYr8mUFYQvT4PgE3ZSc25PNPwmlR8UBKCQdn?=
 =?us-ascii?Q?1wp1+U76dGK72BR4gYL+yHVJ67vr6VKGeg3J+WhjACvR0gnaXLgTmk1S+cmw?=
 =?us-ascii?Q?BOKjaYlxxL0xmXUc6EHrbXdXqp5Pgt0qI5p4RzWpClvv6wBTjJF8YQ8zX8cN?=
 =?us-ascii?Q?HByGDOH5CAfS0jhuGPiGC7zGej7HrR5ovAVaQgw9TMW0ti2ciOh1Qj6YUrVS?=
 =?us-ascii?Q?1Rb6UM+Uew5q4lKrab7FNIhcVFaEymgjsOaQJ1cmF7We0UcXtzPMhc/vbFfu?=
 =?us-ascii?Q?1qYT59XM1PkoXEhSn7UN878UblcqBe29AJfbeyvy1zNAENzbh4Ph05ybRuRf?=
 =?us-ascii?Q?ToTFsLIteue3YMMpXqaGerB6TS09Z+6xwtQ8l75hOJWbe+V96QfgAmCA/Fh3?=
 =?us-ascii?Q?+rU8wDSDEn9EXsoZg6/gHFGC065qyYcZNZ6HdORWhqQ0uTQ7VbRW/8YE5As3?=
 =?us-ascii?Q?n+WryXKzjy0iq96uYhVd/9G2JW6PZL29tMMadapUktrLax7EdB9onkS5Z4Jx?=
 =?us-ascii?Q?vTh+/sydM1mqnAg+WQsjnKFEb4753tJoXC8nTDu49CsTejAPELHHYYgg+QGe?=
 =?us-ascii?Q?xPjiSm+6KfzoMz1Zlxeddbp30AbL3KRq64J99VVzuYjNVqddyTPjIFoPOTjA?=
 =?us-ascii?Q?3orskCzU6uFniZHjakAERT9BbAiAa6Fm6vf4SqpLXHRH7L8zw1NeC24ieTVP?=
 =?us-ascii?Q?xUtvX9FngCxoNJC71w+PcaXRAbCmjIC9uNYFD9ZFWSE6hNl3HIcS5lTYsvCE?=
 =?us-ascii?Q?jF7509cqQEQ3EyGvnpyJXdW0MOaixXiZLp/7Ykga+CHgKuofFlqaXFdCvA24?=
 =?us-ascii?Q?TBflV8SgRPHhrNKKvALYztZgUZRQxVhEgy1SFEWg+5mce8Stafn2fA1JxLCG?=
 =?us-ascii?Q?l6obYvc9DBQ92U1LzAmfVOG+ZeeWD2ieKM3NeE64GJ72is1LDTBV7CLFJ1Jz?=
 =?us-ascii?Q?B+m4XQSRR++J09zsoF3RrL9mskSD/w346NL3pXtrsO1JHy7FKDvV7N3WNbDW?=
 =?us-ascii?Q?SLv1GI1LMbdZ57XF14+N0naLHjugc3Kb4QfRkFiEO+gHDZb2fgoA6Yf8/oJU?=
 =?us-ascii?Q?s0dqhzWaYyIjmsazZs88mefZJWIw0//AdiFJIU6WN+TlUnNnEdvnt4aOToRx?=
 =?us-ascii?Q?803AbqhQsOsI8z3kCF3C/4oo/lrA/B5elzov0zmDpacYAn6e/DC2zGEgUrKz?=
 =?us-ascii?Q?lV4DRkGJ91HqvL+u+VV4ExK9jYTom96RIcp+iFy4Ed9CSfw2Gh25QKcpm0mM?=
 =?us-ascii?Q?3++PpGgTRtszCIG1fALkwGfRtu+rYL2k5capUbkse86gk/TifMbvYaUWYry1?=
 =?us-ascii?Q?ED4SJNb5br39WFhXXy1cHGkI9grfbCRxj1ektdS95tTJYYEvFa5AVk2qKA3i?=
 =?us-ascii?Q?1f+TTLqj1kRcg4EfY3pclgEu3UyyZxhko9URJDw04a2hjflvKru59ZDxwhK+?=
 =?us-ascii?Q?Aey4b2zgpaklUTT4fTcx+ECpfYtyT27ILFScDc+mCFVyRv3DM3dr3jFFpkJm?=
 =?us-ascii?Q?mxFvJQXQuyvECqY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lWVz/c/hOKkgM5e6PhG/JZLRROlt6XpSd7E9DiRk5G8AqNnQGF3qBQo8OfLU?=
 =?us-ascii?Q?cjbzFQdBEu9ZxUN/UtYgjOYWDtKxGo2XUDQ5GNBl00HJKgvlHS1cdJu95dJb?=
 =?us-ascii?Q?TjQMk7ipu39uGxZJm0i5h1htCV+sgTdoYGsCl5WyTGFjB+QjtXXx76DuyI/s?=
 =?us-ascii?Q?d1jZefQR/kGFTkgTqy55uQpnMw7LeUwPRnJfVbXm/aa9yLf/MYOzJsicEw/V?=
 =?us-ascii?Q?z226mVCgx55IJIcpGr4pw6gGulrhWTeaT9tOperKck6pBctQzFlVnEt44MFB?=
 =?us-ascii?Q?WpDShOJTsctX3Ri6TdFm6oM+81jUkLmhW5w3vwQvaHtyHeWmKSaGuBY3MCsn?=
 =?us-ascii?Q?orIJKKQUiSOB6nKIA4dJTSmlxcSw842Zy0VBjuR5dyTlj66oTZHjZFaYFlzN?=
 =?us-ascii?Q?yRypPfiqx5fDNzMA/IRyFoztXg5c9FDS81B4aruxhoQuv3zBGiBYtgbIpyWl?=
 =?us-ascii?Q?ZJWm2XMMpnKt5rdqkHuNG/iJoE712pbauTvBvds1/9Wvfi9D817/cQqyGPGQ?=
 =?us-ascii?Q?ZdyQHVrWuJ+wGr4RAF8gZLmEQjutl3o51F9j+jA5f1bbiLYG0xm4Qct0jJex?=
 =?us-ascii?Q?b9IWupRRJdccLPGkGUYVzMnuf8SFNFMUMpzNFqRw4mPHWOlV1hhSD6Gyn35r?=
 =?us-ascii?Q?7eCKvBIPXlB0LlOjR8U8ChtZ7AuMktUAeDffI6+znkrECiwE26+3cIBGHciE?=
 =?us-ascii?Q?d/YirwtH9d2JdOjChvmAWCVUcGxZHuuIvALorFkx2A1iVtpEncK2jy+iVg5B?=
 =?us-ascii?Q?A7mSTTs6jS93ibyexEdEGQUUn1QG0BWEbQMD4gfW+yKnZbCLEKGV6r1AOGM9?=
 =?us-ascii?Q?wafCQPqoq9mL7AmQI78Q99t7X4mNfyT4gNWXzp1CUGxU6dHkpD88dff+dpBG?=
 =?us-ascii?Q?e2Cx7TclnWFe7LqsGmOcligF9YbLpi5/gIqh13Dvd+FZ1Ll8iKT8oc3aLsy8?=
 =?us-ascii?Q?NHa60B7KeUPnrEet+oVlKNoqribfe0PaqmFHBC0bwxkADtuOKdMtBFCnt7k0?=
 =?us-ascii?Q?b4LxVrjy16M4WB+azkdMCg4e9DgY3LgYiYySDhR3LPl14XrnqwmEtjwAkcha?=
 =?us-ascii?Q?Z0Ivma0sttc4UsbsOeMFQHJzgijyZl6yYS8ACNNQ+nvQ0TyCDbjW/K7QScse?=
 =?us-ascii?Q?/AhVgs7EQmT0R85zgJsOZNziNPOFYC43d8f9YnhnMTlux6gO0szFgsbfZkJ5?=
 =?us-ascii?Q?I+A790Da0wtdmy2MIpHjvdP2ylbDqN3o/oIgMEmDK2ygnUHKjHRIRfoSzei1?=
 =?us-ascii?Q?+F9ycwkT9TuiKNpWfIDaECHs6ml/spx50EviFtv4kKoFHfA44YI9r1OUhi3f?=
 =?us-ascii?Q?FgLwmHhBtOKGJuL0fLRRHA00ZK154P0dnBLIpsi6go7M9tQrDBTGd/EtxwIA?=
 =?us-ascii?Q?ssz30PUfR13Eq73sxmNlS+CFTB+6VssgH0GUVqGJzJcfN97XwymqrUMYsMYk?=
 =?us-ascii?Q?IuavU+RZEhH0NJqnwYT6J7z5bT1NxGjq8ZRsgLOU5P0wIw9oUksdBhAS6Fxk?=
 =?us-ascii?Q?ca9Vf218fiG0OanuyhlLoF+CAovpj5OBZQs8J+znEjhfkakR4p47ZZL9WGk4?=
 =?us-ascii?Q?WscWKHmqK9oCUKlRNp4kfaaQda+1OuS/QcU4oWI9y9leyxQpB2JIMo3mTHlD?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZV9L32RBpGIkrjOsUFsZPOmGVXPTFukxFk0FTQHTay7imGAKTtDXVerdZ475NJZMFx5QjEwsLSOoTLxvt7CiNLt6OPVYeTgZml5fF1htB7aocLhrhswFhORUoJG06HG7Pcq+RJk4ONez7jkjbqTNa7eW8yEHXbtsJCudHU+la7iI2EPNAOxNsQxf0hIS57veEmykjyUKN0GjI7bDOmcgoju91alqVOIWLEi990O6yL2CXjRvmKCHX0YIYD6i/JtOiNZuttAbvX/P292fc7LgQMRrB0RHxAPFV2MogLuubOSGy+A+EtZTLwaZangLmU+nQ5X/4JyHZNOUb0LBYmnCp3BSzG809oVY2Fbyjlcia7mIoVrlEzkR3KB3f2N9oZmka0lV3Arn3aWSMWVjJpNSIWTYpYrNPLla3eTD1hqkDSr+EEubZTV2+QZz0o6qXQ+qHA9FH7+gbDWcQpYJskKsTKWSuUNb9ZOqFrzPwsuci8TAzac3Ip/lOID47E1q3NS1e4kw2uqGQlsBArzi5Qr3L6cdwIXazqQF5/3rroPnZQORpCceNV0tE9tKr2sYgeGpoU3MUWQXdlkkB9A4g4zFQHY3KMP8YkqYHZBhduKMPos=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e39d01-16a1-4be4-3c36-08ddf15ad5bb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 17:44:19.3362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ffIJdhSlGOm6MKjoDKn7Ng9NUdMtqKHCt24SpFsUXehlxzB4ey8JilEmMFc1HSuZVY6GHj0gshvkwQJkfzTbdhE8Rw8HNn4a9erI8XUvYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7923
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110158
X-Proofpoint-GUID: -Bao0Bv6gmqI1fTQkv8vRBsKhVrxVy84
X-Proofpoint-ORIG-GUID: -Bao0Bv6gmqI1fTQkv8vRBsKhVrxVy84
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MiBTYWx0ZWRfX6AuwJDtLuOMo
 KFBr3VE8HD7YVMfRtLpZz8WbRJJ2bsyx91Gn95SG0QkkiPgzkjWtBkfSwsFuPlAh55CnG7K+gAy
 BtBW+XtBNIBnGXvGmPfCcuI3cxtarI1qNhIlAohyCCAWqb2Z2UHvrKwdGvyCZQ4rmq59sB9jVqB
 85BWiRZeZUNvuUkeFJV2SKSB8NWCB9SzTvgZLqW3wK7lvhMCZpxeOV578biJLjRSD4i3ghvvsJR
 62G6GyY9+1PFkQRIoCfD9yhrf7hNuQnUtVdz9048384oAxDU3ObS00cZiG1cAfJPlphnHCjmzFl
 kGnGs9BOmAHwnQ3o/xVg7HzCFKeIpyHuqXOtAQINiXa2k8tDOHzh+lKXIEMcKXZi8AnNeKMJAkr
 cAf/zWoY
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68c30a7a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=dExjuAVxDyyso_DsH9UA:9 a=CjuIK1q_8ugA:10

On Thu, Sep 11, 2025 at 01:30:52PM -0400, Liam R. Howlett wrote:
> * Yafang Shao <laoar.shao@gmail.com> [250909 22:46]:
> > The vma->vm_mm might be NULL and it can be accessed outside of RCU. Thus,
> > we can mark it as trusted_or_null. With this change, BPF helpers can safely
> > access vma->vm_mm to retrieve the associated mm_struct from the VMA.
> > Then we can make policy decision from the VMA.
>
> I don't agree with any of that statement.
>
> How are you getting a vma outside an rcu lock safely?

I'm guessing he means that kernel code might access it outside of RCU?

vma->vm_mm can be NULL for 'special' mappings, no not that special, not the
other special, the VDSO special, yeah that one.

get_vma_name() in fs/proc/task_mmu.c does:

	if (!vma->vm_mm) {
		*name = "[vdso]";
		return;
	}

Not sure you'd ever find a way to bump into that in THP code paths though ofc.

I was reassured in the last version of the series that the MM is definitely safe
to access safe to access

E.g. https://lore.kernel.org/linux-mm/299e12dc-259b-45c2-8662-2f3863479939@lucifer.local/
https://lore.kernel.org/linux-mm/5fb8bd8d-cdd9-42e0-b62d-eb5a517a35c2@lucifer.local/

And it _seems_ BPF can already access VMA's.

I think everything's under RCU, and there's automatically an RCU lock applied
for anything BPF-ish.

So my A-b was all baed on this kind of hand waving...

>
> vmas are RCU type safe so I don't think you can make the statement of
> null or trusted.  You can get a vma that has moved to another mm if you
> are not careful.
>
> What am I missing?  Surely there is more context to add to this commit
> message.

Suspect it's the BPF-magic that's the confusing bit...

>
> >
> > The lsm selftest must be modified because it directly accesses vma->vm_mm
> > without a NULL pointer check; otherwise it will break due to this
> > change.
> >
> > For the VMA based THP policy, the use case is as follows,
> >
> >   @mm = @vma->vm_mm; // vm_area_struct::vm_mm is trusted or null
> >   if (!@mm)
> >       return;
> >   bpf_rcu_read_lock(); // rcu lock must be held to dereference the owner
> >   @owner = @mm->owner; // mm_struct::owner is rcu trusted or null
> >   if (!@owner)
> >     goto out;
> >   @cgroup1 = bpf_task_get_cgroup1(@owner, MEMCG_HIERARCHY_ID);
> >
> >   /* make the decision based on the @cgroup1 attribute */
> >
> >   bpf_cgroup_release(@cgroup1); // release the associated cgroup
> > out:
> >   bpf_rcu_read_unlock();
> >
> > PSI memory information can be obtained from the associated cgroup to inform
> > policy decisions. Since upstream PSI support is currently limited to cgroup
> > v2, the following example demonstrates cgroup v2 implementation:
> >
> >   @owner = @mm->owner;
> >   if (@owner) {
> >       // @ancestor_cgid is user-configured
> >       @ancestor = bpf_cgroup_from_id(@ancestor_cgid);
> >       if (bpf_task_under_cgroup(@owner, @ancestor)) {
> >           @psi_group = @ancestor->psi;
> >
> >         /* Extract PSI metrics from @psi_group and
> >          * implement policy logic based on the values
> >          */
> >
> >       }
> >   }
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  kernel/bpf/verifier.c                   | 5 +++++
> >  tools/testing/selftests/bpf/progs/lsm.c | 8 +++++---
> >  2 files changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index d400e18ee31e..b708b98f796c 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -7165,6 +7165,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
> >  	struct sock *sk;
> >  };
> >
> > +BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
> > +	struct mm_struct *vm_mm;
> > +};
> > +
> >  static bool type_is_rcu(struct bpf_verifier_env *env,
> >  			struct bpf_reg_state *reg,
> >  			const char *field_name, u32 btf_id)
> > @@ -7206,6 +7210,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
> >  {
> >  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
> >  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
> > +	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
> >
> >  	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
> >  					  "__safe_trusted_or_null");
> > diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
> > index 0c13b7409947..7de173daf27b 100644
> > --- a/tools/testing/selftests/bpf/progs/lsm.c
> > +++ b/tools/testing/selftests/bpf/progs/lsm.c
> > @@ -89,14 +89,16 @@ SEC("lsm/file_mprotect")
> >  int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
> >  	     unsigned long reqprot, unsigned long prot, int ret)
> >  {
> > -	if (ret != 0)
> > +	struct mm_struct *mm = vma->vm_mm;
> > +
> > +	if (ret != 0 || !mm)
> >  		return ret;
> >
> >  	__s32 pid = bpf_get_current_pid_tgid() >> 32;
> >  	int is_stack = 0;
> >
> > -	is_stack = (vma->vm_start <= vma->vm_mm->start_stack &&
> > -		    vma->vm_end >= vma->vm_mm->start_stack);
> > +	is_stack = (vma->vm_start <= mm->start_stack &&
> > +		    vma->vm_end >= mm->start_stack);
> >
> >  	if (is_stack && monitored_pid == pid) {
> >  		mprotect_count++;
> > --
> > 2.47.3
> >
> >

