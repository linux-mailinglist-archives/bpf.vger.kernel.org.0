Return-Path: <bpf+bounces-57596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6321BAAD255
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 02:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98294A7ABE
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 00:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3AC28691;
	Wed,  7 May 2025 00:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l4bembDd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P+dEKLuO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A329728EA
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 00:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746577962; cv=fail; b=D+7L41+3ALlQZmAwDgOju9dDzduB5pYaHoWZYL7mL+i/vrxRKD+6BkuJgL3x5rJfzcLg3YE+9C58VVwaduzFwwJslRMWqQrB+rxfJwwAPXIh5WOmMyU6YghsUpHqVMebk33z7r7KRNaQKip+LgmP9k+uXcxizDo+r9k9M6imVKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746577962; c=relaxed/simple;
	bh=e0mgoSv7k85mWJtc7/gA+3ySs/l/djAp9QzttQcLpG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=trGaFdLlDKG1V3uvv3Zvrv9CzJTYB2pI3VDbqlVCv+hSv+aUjsMq2a44efbHs4it6tfejE97NeKpIZ194gzQyHE38jgWoKT6XsAkg7ttBK/8Clr8iOPj+GiuA5Zenej8OnSrdDbQiDDTwZaZkBmICfiXmvUckOp/egWT+YkrQUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l4bembDd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P+dEKLuO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5470MOJS001876;
	Wed, 7 May 2025 00:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=YathwzPgngnFIgnDBF
	CctFyHoKFiHcyHNPKd9mH2MrM=; b=l4bembDd4F6A1h71zRynkUZjrnqbEuAB8A
	jxi9iMRpf2dtGe8/IibrPpo2P8N/RywLnQTyBQ/hp2txLO8rC1TyMDNfh4D55Erz
	4JeUygPO/FQlCs8LskWgXp4fTCbVPM44qxYvOX/2a9HZXiYi0vHEb9Lsc/KmrZQG
	slyrPGSRU60wHdZCbQf512VYaEho8FyXp48ZKrVj3yxb+lb4JnhAcunDoM2USZEk
	JMkz1W+0S49OzmkSBVe2Yf40MOIYPNxtPC/cpfW4YBR/fPEk7/gPDmpmPBC2h9CX
	G6Ssn66O6TWrDKopn5fATWnDZwiLd9nrSUsx2hicNqFm34pzW2DQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46fvwrg0n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 00:31:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54708BbO036150;
	Wed, 7 May 2025 00:31:33 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010007.outbound.protection.outlook.com [40.93.20.7])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k9rum3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 00:31:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRyTNI0DYLZ8MvgfmcVK+12ObY25Zvthfp6SM9NVOJu3QFObzjUC0U+RWeRbp5m7BOYEtjo1ctpi4xm7X/CU1L2cor778SCa3sf4Dfs/S59k64IV0ZNpIAzjFl3jyi4/4g+il9E3cBTIy2urldieOEPwktjtyDF4arqpU8gj3CZq/2U95k0pHWcn5NmEzQS3RLwH/IXfgMBjk7jFFdVYjEKZqcuElvIBNJAfGB2oqpXlfduiTh4OjFZE5ATWnMXihXOAc5CMXzzInfq1h+kszhQvZf0wpw8pHsjj+vsTYJY6ve9gc0yD306B/xOmrY1qLyQIpLVXQkEKZlsJm3XzZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YathwzPgngnFIgnDBFCctFyHoKFiHcyHNPKd9mH2MrM=;
 b=a1G5umlYyT3Bpn4kZ5Eap8i6VyKPfl+oa6BVpl5YZWYzSJWE77ZLg8/rxV5Y1FjGMx1VmAUfz0MZ9THcbbeJf62PFprY8qRwvjMNZtclN46GXqwLhN7hAMdmg11B4MhaGGHu/rYPS99qk0Y6XpS17PPcChrhQ8fMZYI22KSy3s0m9ikCfi1p2QZoWlBPOpAd0gQXdMQ1n92+/4OfSuzjVoAFEj5jtgc00wn3pS5Pn3GBipf+pZHbVlPqCEIDANRQnC6AoiR3cXzuy56oHdoOeztaLy2FwDqh8Y890XiU+xtWsCZeKBnZeHNd30tRxAU6TfZ4mwHo/K/69eSutEAb1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YathwzPgngnFIgnDBFCctFyHoKFiHcyHNPKd9mH2MrM=;
 b=P+dEKLuONhGTaGHCapd2hhl+VtmZNrecl1IrFWg7q+PkTlWhz7gmQuxNfEkUKjPNkGZ1oCakAHNz5u9l/eUzvujJ/xvBaUYqyvc2kebZY35ewBTSnS6CeA+Uq5zqpaV0G/zdB8see7r9rFpdNPTl1RArIIB4oDrdAlUqo9XpLqM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SN4PR10MB5544.namprd10.prod.outlook.com (2603:10b6:806:1eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 7 May
 2025 00:31:26 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 00:31:26 +0000
Date: Wed, 7 May 2025 09:31:17 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
        linux-mm@kvack.org, shakeel.butt@linux.dev, mhocko@suse.com,
        bigeasy@linutronix.de, andrii@kernel.org, memxor@gmail.com,
        akpm@linux-foundation.org, peterz@infradead.org, rostedt@goodmis.org,
        hannes@cmpxchg.org, willy@infradead.org
Subject: Re: [PATCH 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
Message-ID: <aBqp1ScxaTznSf36@harry>
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-7-alexei.starovoitov@gmail.com>
 <4d3e5d4b-502b-459b-9779-c0bf55ef2a03@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d3e5d4b-502b-459b-9779-c0bf55ef2a03@suse.cz>
X-ClientProxiedBy: SEWP216CA0041.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b5::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SN4PR10MB5544:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b3e06f-3806-40cc-417f-08dd8cfe8044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k1hDiVz4sfsBBaz87SkysmNgiPqdD91SSQuPd3PvqwYJ0OBO6ZLdJefxu9uO?=
 =?us-ascii?Q?cHvVbp14Z9OfJZKXpiyMgWpo3PL29d0Y0PkIP/NMFkBv1aqScGk1a5xvsofB?=
 =?us-ascii?Q?v5h219DguTECaJQ5tvTbzwkbYLl5DIjNDfxeM94E8ANRSYjrr94fshTrj4hy?=
 =?us-ascii?Q?74cOXrGGuKSD5VNhSbeVsFsziN+CxAQqnNL3pvNj92cyVlMGmyM4GWqAvtUh?=
 =?us-ascii?Q?TS4xrOZEwsbo0o5LYdrNJEAbUcI/OTYisduQwWBYUlc6V36+/PMcRH3B2PJj?=
 =?us-ascii?Q?V3LQpheST2o8gCi16Yz5iaqJa8c7Hv8VCuFuPm2AC0CaVlNyOnfHRddaa9a9?=
 =?us-ascii?Q?Oa0RQXRFmGTXi0JZylVcO3sze8VkeYHHU12zdIKdW/BmDu6IkJNEW9XPlQsU?=
 =?us-ascii?Q?oCqwzL9mAHLnMOZc9q/L2iEewjsd/8ZUm+5bPzXrHATJ1BW5e8RucWPj0Nxm?=
 =?us-ascii?Q?PnMYaTS3+c6YoHUcx3ybaC2A2iVUOqo8F8iTJFGQlyTBgZ+xDFLYjHllD1at?=
 =?us-ascii?Q?fdu3Yd6vHz7LJXMWjNjZedsdEEnvCzT3L++TNdJlM2hqj8wv5ti1t0ZuIxUw?=
 =?us-ascii?Q?KEH5i8WvrVi09HvOhjEWpxxEFqPwHW/bHRrthck1eGie0Op33IB6QZtoq7gM?=
 =?us-ascii?Q?ZJ8V7mHtH4JkeRbbkhxftrdIsrbs7mYUn4FopEd28UtBkuGxDWvomjKQPAWl?=
 =?us-ascii?Q?Yu9jXVN3ZbbxQhqXl0+jfzKSEYtbcSsc9SsQ6dkaW2tBlz1UmiFWGdsxJSs3?=
 =?us-ascii?Q?VCZv2y7+lC6o2oLNxT+xm+8marnqqS8tN48mDgbPoT2gF2d4i8b1HN0EIu4c?=
 =?us-ascii?Q?ezx6qyaeMP2SOmJWhH8unOW41GwF2NBqRDiftDIZx2EZZWIiB7IVROl8uiNV?=
 =?us-ascii?Q?es4ZKg+QxILMHo34VmhqyKRCL7rfz0TiLDcb8zgRAE8Z5N85wPfK/oTjhZSg?=
 =?us-ascii?Q?HxnZR87r6tIsxMtrk68ANJoDfElVQSsz37XOURj8lb5Es0FPLsP467aMSihF?=
 =?us-ascii?Q?cs83wghoMy6GtbhZuAv2kH4MeBsnhqQZzHMfRfwVqyZkfccLcujcc6IAYbgB?=
 =?us-ascii?Q?S7Tpd46yC8vOO3PzdlPhYLywPsLh9j3dzCqjbCaScSwCTEl3yhyOe9jCIf6d?=
 =?us-ascii?Q?8DO/FjFUsOt8UizGzYTCtqFCiGO5MElqUPNcKGulJXH6666PCfzZZerX3yB/?=
 =?us-ascii?Q?pw3t/VjuSY2ch/AiRgCHX3ZKfn6zW0I5TCOtDobxFgSzww4bZCzCdfk2eCqX?=
 =?us-ascii?Q?4OXhYBqrwDhrVJJEtaY/PGLs1U1rljKE9HU4B7Sj9Yo4MNJPaQO1Q7koCzOz?=
 =?us-ascii?Q?ueaa55p61pmvwNqm3845TPguKVPNmtmdko3Y1YlrVKeO5YcCtFCIPBq8RBn0?=
 =?us-ascii?Q?Z+ZtkIGQksXUvQNehzAE9wjdy7KJ/rRIlxB/XvY5gdUVwVzB5+7p44hIPFiH?=
 =?us-ascii?Q?dUMuFmHKFZY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jVp9BtBHcpdbF/8ts6dxVObjtxUUg70qVfkVgaEnxzcgR3tkh8JCxuVYP0WU?=
 =?us-ascii?Q?c3gXZmsi38WPeaQRycQQhCFK89ILNuUxYindSN/F6q68dcO7fXC6V+rmvSNV?=
 =?us-ascii?Q?bICxvxmqEvoGzWkcV+M9WI3kJ9gPEOvbnL2eBLUf8cvtTZhN5k1sCIFbCQK5?=
 =?us-ascii?Q?vYo+YnEaba0Ywv2rP+BJV5XNodoL7Plx61PWDs8OfLaP3U+Q2QepE+CMaflN?=
 =?us-ascii?Q?4yqo48H41r7mD+iG2rot5vOQOw0SJlYboaZ3IVYQwSsOVYmJJTZAXMoer7LQ?=
 =?us-ascii?Q?nTr/4RKfeMJiwlseWRYr6J87DMrMWXCjnlNY6PdPhK1Bb2n9MjvmJw4BPbUW?=
 =?us-ascii?Q?Kc0Q/fMdrAKZEWxaNqsQL/xvYBdFyce8OhBOhDeG/0TMxFHh7bTsRRPhDwVD?=
 =?us-ascii?Q?bzmX04ITWIFwvvwmdg5LFzam4h0YjCsGlRz2c3BiZ2AFqEPFNC9dP+o9JTn8?=
 =?us-ascii?Q?9xRSIw8yxpapOwFguCQuINoQoCwcscL/gFDhvZEoNFrKHRpn/y5RUmdjThEg?=
 =?us-ascii?Q?/1czyrywSoVG4H4AflyS8cWXG3UmfK7FjwjLoPkP/D7cF/87oQI5AtOpAygo?=
 =?us-ascii?Q?6XHYPCjH4L1L6yLyhKQa7R770dFgb/vZ5jQxRtKZ7To91y/MFoOaduPSAdVw?=
 =?us-ascii?Q?nYfLVPYYVEj74mXobeQ+YpVqasvPk7m6b/6nTpKtfgnT13MSbC7CSuAjQsGB?=
 =?us-ascii?Q?VW7FGTKZXIRf0zdnHmZzE2kOI7er8VIMPxRKNZs3FkTAGAIrlQE/n5nhZBO1?=
 =?us-ascii?Q?YnIP6QRZRwSs21HX8ruVSBNnJMWHC+xM2u7xYLZK8TkjA0j8fE7/et1nigAq?=
 =?us-ascii?Q?Q8isGz6z78ktC8vnqDF6ht39jccr8jACU4vf9859eqdeX5KEc+oAJq8gAlZi?=
 =?us-ascii?Q?Rgn5ZfgNCQcdmsb+0HPMaJcNkKofiy/gpr6zgGe2yh/eBmZD8SNUKszPxT6b?=
 =?us-ascii?Q?gt0m0Q59V+YJG74+DS1lqz0oJhEIBLjJAp9+PRKZGlT5SNLUhur0xIlVJiRC?=
 =?us-ascii?Q?GU98QPuHspeUtFfZRFYqZjGkAcI7QeRZzneL8phZDbU0xDC9mEBDXDIrXT1c?=
 =?us-ascii?Q?YPjDLhMlPVCMQPZeXan43Q4w/+3fSgJ+8c3wVFn8d17BhtHM0mQwSPgwgDFY?=
 =?us-ascii?Q?x6M5QxQrHDglCsDgWceIRooiMwix4hAuXMojrGN7+gL33ytRueDlagMOInr5?=
 =?us-ascii?Q?+eQLO+WT66vMFToP6KKtKo53C+ilX9BMcR7+UueIL11KTzbK5/TiHMFLUSme?=
 =?us-ascii?Q?aJdynz5dIdXALabTdUdQYOBwh8UDW0RZD4gMzwnm8O28+ECv4IrrwYGExLx/?=
 =?us-ascii?Q?28QbjB3Hpeian1r6KWbBAHsZnlxUsiA1nHqUd70M0gKNeGXgmTJ4u8nWN+Wu?=
 =?us-ascii?Q?ETwfSdYssyE4y7fZjMJtExTXkHqqRKpX2fj41auwLhfrJA9+TZ1jusfGV8AT?=
 =?us-ascii?Q?UhHokQPZlEl1gS7b16zgIR4Dp7QhtswGYeMGHuGtCyR9UnsWvdAh+66k4WFt?=
 =?us-ascii?Q?GEIkcyIT7UpAOQbxCrx/6Twu8sV40AIi3kk+FVk7dY9aNRn36pfXU2fVOIZX?=
 =?us-ascii?Q?l13cOztOfBH7odEB5wDDbMpEbdIMa26QJMiTZX0y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R4XzHy6DH96qnbFNon9M0vVKwxWlyDAkkOviB0QU8/1ouNIg6R/8iICqCs2O3HmOpuxecprtDXLEFTGU43WIkkAjq4z8/YSVI9iNykPnTV+0km8wz8boyTvhs+wagGT81VxFvbuQocEBckF2BGyw8aEcRnKhbBUWJdXQjQkHEdqY6NfzbYAOYaqL3zK4rRFXNAsfXVGrY+yrk0K6Wixx0PfGhBoAZs00ZGxnZaQanRP0gUt8o1lzIG6jUXak5JgzDFK5OfUaOUPRqW64cPpLfC4j18Omcxhx59EY170sf2aX5bjfN80zJacwSjXFAFy1o5VPvkMNwgFjDxmLgIucXoKayb4OlWlng/7uKDbyOGYyDq+Wc2bnZXX3JRWN2jccXMG13iUZ2sRRD8iZEyu8usUsdfEtv+zJw1QOieSLxu5fSOkaJFtTqT7zAs4wKcV6GswCaMx9wZHcMqL9nx2hCNEwjPMDpKWrp/TOn7RnfRH21EgE2zB1EqZ3bxforpUGC94+DPdDmGhfOU5TpNOxMt6+bZROm77TkBg2/Np5S5k5MgHXKbmYyFc9dhavatInTWaL1H2DPxsxcz/FBmo0mEQqVFD2R6Qym/3z7PoRDz0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b3e06f-3806-40cc-417f-08dd8cfe8044
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 00:31:26.1414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ebWO7wFwq0TrAd5rYScm9AAiFojmhLm/tvEvUwoL2FFawRJjoOLjQ9T4s3Z6C9yn9PgXU+u8bkW76WJqn1bMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_09,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=905 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505070003
X-Authority-Analysis: v=2.4 cv=f+dIBPyM c=1 sm=1 tr=0 ts=681aa9f3 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Q5MygImJ9EEM9c2vatsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: wFozsx9q8A-6O86ZkfNxzFuPndBKbWJH
X-Proofpoint-GUID: wFozsx9q8A-6O86ZkfNxzFuPndBKbWJH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDAwMiBTYWx0ZWRfX4OTSQC3+zMPz bDWBRRH+C+jgt8y1DHNMz4qT/ppnLa7MRrB3IxzZvnxukuP+0P2BLzV3g96z9NAqeLHfctbtVBK ygkGCEduhxJFPZoZcoRQ9MdfvxRrUa3V/JBYRCwJ0deyeliVlC/C9EbCmMg22VdVJVTnipCvJPD
 Kl9FIOqjYw1HNplH+EQKyOafsQmdw+czt5PRXvW3KFQjsc9yEjQWlEq2PjMWfBMx6evtr/uZJOj FGCEUXBJSYHYvIhRVdhHAJlQP2dMKqI19pOMcebASR5xaAFryYvSxW/U5hfDzVCeYdSpJ2rGOnA DnAsG4qwyRWFSu+oZZGc08UGMDc/qTuoegTOi8PBPnBtUBj3gtMJXmIdKJ+3iffgQpED0pgCQRd
 kx6zrUOXGRTwUMrm3NM3b8HmKuKJiJf/x1h44C9wbmyU8L+R8altKzU2g6YG5V6O7yym3nws

On Tue, May 06, 2025 at 02:01:48PM +0200, Vlastimil Babka wrote:
> On 5/1/25 05:27, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> > 
> > kmalloc_nolock() relies on ability of local_lock to detect the situation
> > when it's locked.
> > In !PREEMPT_RT local_lock_is_locked() is true only when NMI happened in
> > irq saved region that protects _that specific_ per-cpu kmem_cache_cpu.
> > In that case retry the operation in a different kmalloc bucket.
> > The second attempt will likely succeed, since this cpu locked
> > different kmem_cache_cpu.
> > When lock_local_is_locked() sees locked memcg_stock.stock_lock
> > fallback to atomic operations.
> > 
> > Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
> > per-cpu rt_spin_lock is locked by current task. In this case re-entrance
> > into the same kmalloc bucket is unsafe, and kmalloc_nolock() tries
> > a different bucket that is most likely is not locked by current
> > task. Though it may be locked by a different task it's safe to
> > rt_spin_lock() on it.
> > 
> > Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
> > immediately if called from hard irq or NMI in PREEMPT_RT.
> > 
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> 

... snip ...

> > @@ -4354,6 +4406,88 @@ void *__kmalloc_noprof(size_t size, gfp_t flags)
> >  }
> >  EXPORT_SYMBOL(__kmalloc_noprof);
> >  
> > +/**
> > + * kmalloc_nolock - Allocate an object of given size from any context.
> > + * @size: size to allocate
> > + * @gfp_flags: GFP flags. Only __GFP_ACCOUNT, __GFP_ZERO allowed.
> > + * @node: node number of the target node.
> > + *
> > + * Return: pointer to the new object or NULL in case of error.
> > + * NULL does not mean EBUSY or EAGAIN. It means ENOMEM.
> > + * There is no reason to call it again and expect !NULL.
> > + */
> > +void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
> > +{
> > +	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
> > +	struct kmem_cache *s;
> > +	bool can_retry = true;
> > +	void *ret = ERR_PTR(-EBUSY);
> > +
> > +	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO));
> > +
> > +	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
> > +		return NULL;
> > +	if (unlikely(!size))
> > +		return ZERO_SIZE_PTR;
> > +
> > +	if (!USE_LOCKLESS_FAST_PATH() && (in_nmi() || in_hardirq()))
> > +		/* kmalloc_nolock() in PREEMPT_RT is not supported from irq */
> > +		return NULL;
> > +retry:
> > +	s = kmalloc_slab(size, NULL, alloc_gfp, _RET_IP_);
> 
> The idea of retrying on different bucket is based on wrong assumptions and
> thus won't work as you expect. kmalloc_slab() doesn't select buckets truly
> randomly, but deterministically via hashing from a random per-boot seed and
> the _RET_IP_, as the security hardening goal is to make different kmalloc()
> callsites get different caches with high probability.

It's not retrying with the same size, so I don't think it's relying on any
assumption about random kmalloc caches. (yeah, it wastes some memory if
allocated from the next size bucket)

	if (PTR_ERR(ret) == -EBUSY) {
		if (can_retry) {
			/* pick the next kmalloc bucket */
			size = s->object_size + 1;
			/*
			 * Another alternative is to
			 * if (memcg) alloc_gfp &= ~__GFP_ACCOUNT;
			 * else if (!memcg) alloc_gfp |= __GFP_ACCOUNT;
			 * to retry from bucket of the same size.
			 */
			can_retry = false;
			goto retry;
		}
		ret = NULL;
	}

By the way, it doesn't check if a kmalloc cache that can serve
(s->object_size + 1) allocations actually exists, which is not true for
the largest kmalloc cache?

-- 
Cheers,
Harry / Hyeonggon

