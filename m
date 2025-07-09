Return-Path: <bpf+bounces-62827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC26AFF14B
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 21:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646F64811FF
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 19:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF41D23D28E;
	Wed,  9 Jul 2025 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fe2kVKR5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NrPxdmJT"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4271F63D9;
	Wed,  9 Jul 2025 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087743; cv=fail; b=d2EsEc42yrSe2L3ryQjlltApQkJ64sspzwgs4s0RsJbPmtsUxRGY9cmIQ6//BcvPDAIReLLHIs/bfcKBwlnF0boxapuywftIiQCbUQO2n4Oiymm+3SXW0w/YjpT/IcdCvAeDFifPVzlup7qSuxIYInOG4prhPagBbTtq5m2l7+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087743; c=relaxed/simple;
	bh=clnCS9UX7fYod/Kg+U28kHexLELDUrlZT9wCT7RIhvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nnyb480MN9LLMInMgJL6mjAbsWEg4NQyrKWIhD+sOeD/81UbZa2zAO5Ekp4NfKbwUXDSp3JLu74Hv1jlio5g6bG3WQepO5aZHJiF2VoFBfz3UwSgJksZEfAY4/ZwzudK5kO2y9lsOYSqleY1FAJN6wYYEoVufOLhuNGEA+O5R2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fe2kVKR5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NrPxdmJT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569Hr08A027471;
	Wed, 9 Jul 2025 19:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=qYZgN44GQnwUdZsJEV
	ghUrdeIGFsL6Xvd0j5qTmEfKM=; b=fe2kVKR5dg4jTTHBIiOeB+QmcaIId5l3p4
	A9w4nM884eEIA69OoZmpkDvZcya+QlyDrAkgHG/vm6E9z1Fp99UkcpxhxD2U7gGF
	+oQTNsVAPy7bzF1gYRslnTc/Mcp877fpNROviElJPPPzABCImHXnwDjZQ+XCS97D
	d3eqofRXaDvyrVtwXD9bSlIY1GCCsJ8rnfWftUQEebcE0bwPoMObpc8zC6gdvLQy
	CR09tfvwFYZq8gVs9+oryX0gKzGXpr0shqu2EQAr/y0iRGq1wJX+rxriI03t6/LG
	Yf3zb6KfdtSsdpPut6lheNpYHX/Zf5TNJ1ueiS8jsekNZ4orVGZg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47sw6t04jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 19:01:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569HKqZ4013978;
	Wed, 9 Jul 2025 19:01:47 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgbc5bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 19:01:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fePU1I17Y/JwpVY1JO4lpxM4PLoA1oi1St8YiAvNXeIaMZhX18gbocS68wkgEe7Zi0ooEmKrtcRDDtjeLvu8Hjv6qnaX/bThez6sPsZwNOMbn1bOAvrLZC20fBPu+02uNHPAQu8195/52M+e+19lwXHbi7qdXDdQgTiow53GDVRXOjR7Bj3nbE9GBFiWEoMncrby4480oSN0dyt3XaEZ5ri8MjTkdnjEsAgVRDIdUXFW4awNF25MYxYtMR6XqFHDK1IFzKA2VH0PKbc/0/CV4xv78bwQLUqKKb6+VouYR47Syaq9l6K/xdW3ogLoBwPoBaqPXh+gWZHdvl2i5y0mcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYZgN44GQnwUdZsJEVghUrdeIGFsL6Xvd0j5qTmEfKM=;
 b=F9MBS+UM7A8d+5CHsI5CrWzkJDNhSVQ6mZJM2nN/Q3kRUjzxoDih/i/2mXTdUgLL/tMzHcK+Y2pMO4f7UEUmFCiKm0jr8HDbMoYeYx+zwj8PSKVeDjFkSfkYRVK7EwPIH9ihOCYroAZA3FCevxjqy9bWASj0Y+X3XNMqxLhJKFteGBAzF3gAZw9X4fn8XWq2ElDdyuLpMaDUaY5c0c2zjdBaWD8e86dRXbnkvLjIjX5unfAqJbeWVN20N7kbDKb964RUBqyhqQMRsORG/1ZOZ+Y24EGnxU/b88ar+nW0gum2wPWvihTk5QAvxZm+1abMAadhgbPlZ5Z0CoT9fYBZ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYZgN44GQnwUdZsJEVghUrdeIGFsL6Xvd0j5qTmEfKM=;
 b=NrPxdmJTje1wB+rzGynFn6+n4H9wxfLAUBQbDzesptUsaE6JHJnUwEGElYjU2fIVQ4bHWK1iCcghBbLJVZNOfQI6/AvhsWavjGevScb1JZ51dXCJj20RVa4QWE51mRshUuxM9lAMeMnWgqvReDKEBTqNcVzSm0xzIABD9j29qc0=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by MN0PR10MB5936.namprd10.prod.outlook.com (2603:10b6:208:3cc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 19:01:43 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Wed, 9 Jul 2025
 19:01:43 +0000
Date: Wed, 9 Jul 2025 15:01:39 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
        Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, bpf@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v12 1/4] mm/vmalloc: allow to set node and align in
 vrealloc
Message-ID: <nsacpwgldqdidsqkqalxdhwptikk7srnhjncmjaulnzcf6nsmu@fisb5w4aamhl>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vitaly Wool <vitaly.wool@konsulko.se>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, rust-for-linux@vger.kernel.org, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-bcachefs@vger.kernel.org, bpf@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
References: <20250709172345.1031907-1-vitaly.wool@konsulko.se>
 <20250709172416.1031970-1-vitaly.wool@konsulko.se>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709172416.1031970-1-vitaly.wool@konsulko.se>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4P288CA0028.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::14) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|MN0PR10MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f99ea3-1cd2-498a-ec55-08ddbf1b0b86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cx4/3QWDVucwohpg70/m4U6bhkFVdST2/IZwipN4hf5pjqOaU0qZS6ulSyaw?=
 =?us-ascii?Q?69QA3yLtvYGb/hku9zuEfJM7YzrSEkVrxB36AIF41+JpV8rIvOOLc/GPQfh8?=
 =?us-ascii?Q?Eu76y66G2IUoM4cFCdicGqPUDHx0D+oCd9lL/Z2XH4nzy8vtuEoyQhyNtVmg?=
 =?us-ascii?Q?jR7o5v5D1HBthvIDarv+rAqBfoGW2ryWqNtLbqoz1EEBJcW2risaGNTEuPO5?=
 =?us-ascii?Q?RNGoPzYTYnG4V9Q9a8RZOsyrWyDtDBMWgmMZHjajvCETmhDj6mTwcBtD1T9J?=
 =?us-ascii?Q?TgAQm7e/LoeCUmJfbEnNzIYm+EWwnh+GeCeQyYgB75U/mMon1kNbQu/V2Q/P?=
 =?us-ascii?Q?2Msn4Y3x4TG7mkDlf0P4Gj8guVkeW0jysBdiD7gMw+dMVw1w2dt0ukEvtmCV?=
 =?us-ascii?Q?KN+b2Y0cmu1OD7r3crOtBSw+WQTNTWgbvxKC6Lg4PrLgvdAv/BfMFspG3H22?=
 =?us-ascii?Q?oeMgQyYbEZb0HEhRqUJMKkCqVuVMgmb5sJgdcTPGxidSIBGj+T4X90p5BiYb?=
 =?us-ascii?Q?EqfGwXIdY5H2qzbh8SW6TviGbiEUxKjw/w9N/qlqtWEdLskGcLF7ZuOno+o6?=
 =?us-ascii?Q?nUZ13qL/9FvHWFyIp+F7kmM8y9dRVRiJWtTytCuS6p4GfswMpIJVfdJXKGep?=
 =?us-ascii?Q?HlLr8YIPUhG7F/THv+2mQMEUWj/8briiUExaKmfIy/vOMvCCUQZKMp49WQzq?=
 =?us-ascii?Q?vPG+79qA4oBVwuw9No2QyZmg8PfQ0c8VpZ9nWFIL8cG89E2Wg9gPF7/dmT/G?=
 =?us-ascii?Q?h+v3B4f+9aexHGyNoJrqdyNijcdT82qZ5Fb/kQZVrNXXS7h2n7E7hA3NJ6/T?=
 =?us-ascii?Q?QBMk4UO9lY+m4uI4UPnSThHKMZ1B5UCGMjx1ZbzqnPmpp6XN68WclIw8IdBx?=
 =?us-ascii?Q?tE6jz5ZcO1XkkISVxQ0BFbVfmiYP3TCThTuki0BFEm/MwYtoG/4QhG7V5+rq?=
 =?us-ascii?Q?VPwst6Gk3AB7SHK+z5+UJT4vJms7wkRS8zOO/lJ0JmsJT0uvcY96vxb9QFW5?=
 =?us-ascii?Q?iQuPseEVTrVJ8vqt6mMG/U0HJPFlsWaQGgKJrogBMnNFLJfjIsn44FYnL24A?=
 =?us-ascii?Q?eS49nB3jZFJenrm/WPE/OdNyL4x1cf89D/R66fLYjQi+0t/hfT4M1v9Ois9V?=
 =?us-ascii?Q?8dy8R7KPBWONezvA2/u4edl/5URuTnC1UIohRUoJlsXC+z6HmWTCf++R4hQH?=
 =?us-ascii?Q?4Kw10wrjKuj1+A64kCMr8tGLc4fuE5aiMZ3qp/RTG8dEWfR9tIPAhi+KUtL1?=
 =?us-ascii?Q?5vocSu6H6qwYo+dnLMxoL7qLqBVo9VlFvGGtg7mleazbrIslPZQd/OIOyduY?=
 =?us-ascii?Q?KSaU8jmSwf3TK02el0Oky92OGClVdtU/ygR0gH3WzVkYnMXw8hUO57Ds0BZm?=
 =?us-ascii?Q?hGldG5gBrkzTB82tvL2jjX5XaZBiEpPewSA8w1aDq9Dv+L+uTalZNmL+7Abs?=
 =?us-ascii?Q?BsOnd310B3M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kNp8rc7Esc0J8J+yC0bJfPT9NzOdlaq4Xrw7g7ngRBrmjFNziDFH5w8dygnG?=
 =?us-ascii?Q?N6Iha7hR9TrU2lE919jU0gndXkR8rYFN51+J2xx/LpPYd5CTY0LJdPUCJ2iY?=
 =?us-ascii?Q?7GhPDCC1POr84XRYNdAWnBGxx14vnzzEZ5Je4hNuGROqTaPmVN26BaY4v8ek?=
 =?us-ascii?Q?M/LQCVaLkgOQOWjNrF2zs1/iuxFt3R8E5Lfdzne+vYXQgAu1X4ktSO+V52iS?=
 =?us-ascii?Q?XfjYxjuBlLJ8I59dHyufvh0cKh06FXqEAltwiQtuog2iNf3al/8HhCbsGbWg?=
 =?us-ascii?Q?VaRDit6/BZBK/Op8cQHhDnTsJQIdu2Xf3OR8YHnyuzgdf9UKpIhIIa6/ry5A?=
 =?us-ascii?Q?ADYdlTpcIXVlvrjDHw5WCpEcR5ZAnDx99Px+C6HXHLAUbPNnYky8t9u/uSCz?=
 =?us-ascii?Q?9KULM4GqgxF6bFm84A361R231xEnChK1hDQwykiG9tUb1rVudLg/i+wEEM3q?=
 =?us-ascii?Q?PJKBn+OdQNvVJTYtch8O+tlWMYZMmr/4OMpXuSXX3p3uMeNU47S82VL4n4kz?=
 =?us-ascii?Q?VLwbgfCTwcwYikFHT5oRqeP3PooYw2luw0DGwvM1avDzFSNndBBjuHkvxEvx?=
 =?us-ascii?Q?aL4TlRXV/4EBkrtazfpd7ObshA85z+5+zhq1g3byIyIry6r/mMGJE2OUKObW?=
 =?us-ascii?Q?KYBCmNH67eCDoSV/SxFLxanGdGVgRnOZPEiaIDZ3FGNdR4OpE9LGJq95WR0U?=
 =?us-ascii?Q?xdQ0o5ZoQbOArWJasPvmm56QFVSCM1yo5aDd2yNWYov1dD0mY0zCzrefc3U+?=
 =?us-ascii?Q?Ckk/ChgGS/5W0Usdlks3UgY8CRxdERO8tjtvzcdq/YeDlu3HQF5MG5nkeJPI?=
 =?us-ascii?Q?E4v2Q4Q5zD/qNoLtb68GDvCjg+N6px8mxaAz2XptcKLww9YzyW1hKfnhH/wK?=
 =?us-ascii?Q?+Ew8iSOZkitrjWGOX0tWdcBtJfnX6yqeJDp5a0Cwf64do30DNyOkvJuoGOuY?=
 =?us-ascii?Q?cPI3i77wBh72uX2b/6gusAzRZnYS8T8FM54IOq0UVwHkjA0set7yA7n28KF/?=
 =?us-ascii?Q?saDfjZ0VIwXtMJHtzsjHzQdFSu5QoNN9m+kFgKhJ9rZld/KA8rh0c6Q+guY1?=
 =?us-ascii?Q?cuWt00aXKLaEOdcmlRytHzGLV5s4x1jP2LPSUb2Eu7xPghLaWUnyZxt/vHyF?=
 =?us-ascii?Q?73zcqwFqgsQADfYbVRPVh/d60a3z7lz3gJmBFv3MdAnK8idflgAuVk8K9P/8?=
 =?us-ascii?Q?b3Eysuhodz6+CIO+9aiDnInWnTecMpJTrk9cI0nY+X9ckVeaYyhwSF/nY/FS?=
 =?us-ascii?Q?/FJE60spgnjO7TptYoGvqcFzqn9KYhv1igvWsC57Mk0R1IAnkp5iQU0IsArD?=
 =?us-ascii?Q?hO1MBP7n7SVMUFnshpUpANDmshPudv8YulTpU5dAdDb1IM2gpc9Y93Y820dM?=
 =?us-ascii?Q?yC72+PxN3tobWyNUlyRZBsAmjr8He0jFHUI26qai0+tuh+JO8Zi6ovfhwtSV?=
 =?us-ascii?Q?A5rKqKb2//pTgDknC5mte+haBnsrgWqY6zeRsNfTVjLEppGJuE7zvZZCitnr?=
 =?us-ascii?Q?Jj7Ohsl6kHcCyQeKvia7c/aAqmk0JYCf3sf8EjicojHK0397SqirEeqFDVij?=
 =?us-ascii?Q?b2kRB2gWPkB5sTvHyLWGlJ/ZbYaAg1DNBWzk2LEg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OREaKV0Okin7lN8Z9cOp206MVJ0XzE+C4RvLloGG+sgos1du9yP0xNsTLifVJ3yfqKTm0nliSL0q+KOhw3QxZUNkHFr7Tz9FcJfmV0VxqTKhzTRNWWvFRETsuCexfiQYeNkSe0UM493KOLkgqWuo+LNetjkFtuaP5LdVzcJn0LdZWApX1IEzHgYKTo9tuYOI28vw34JIc9VEa2yLpYP5GNI/BlrkRQFnxq+Gx1XLbHHzE5b//ULXoSUZXUFjhhJTynW6eOdwI77DbPEd/po8CaJsOnvEQMspOqqc0EuSiGcul6xqyhzHu1WVjq9MNN55x7IMkx3ZjIHNtkBOVxG4zciQ11XnP1tUUmN4uLro+dMecmfR8TYFC/Y81JfxOVGLK/7XI3cL69p3c+Tmy5BBjDnyGnWgs5X5Zhd4D7EC6tWCHP+tPgBeYvdJTnTAukrEBBl3LjKJeK66eqFC6F9cX3dfI4Uysqd8CqQkRqGj5F0c1HkacrcWSNckTrkJ5nbZPXTCfD+VrRFmsnK7pkuoIuKy93LQdsN0lWMiXV6wVUTZGMEIdr77c2Wshr+gi4KH6P2SCDvB4+vwmZ/jut691RFy9brQx7lkxxjjavJwaX8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f99ea3-1cd2-498a-ec55-08ddbf1b0b86
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 19:01:43.6442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NerYdokQLN4UfC5tTDTwaaUegeqJOVZxfiyHobk2hQzY1VTAPST2TsWjqtsGJEp3BmG1/QlS83iU/lHFQv7wbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5936
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507090170
X-Authority-Analysis: v=2.4 cv=UPvdHDfy c=1 sm=1 tr=0 ts=686ebc9c b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=A0BLgDPCf4KvOeyUQaQA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12058
X-Proofpoint-ORIG-GUID: L5TZXIR4L8ppaL8Eihf4F7JpEdCgKl6t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE3MCBTYWx0ZWRfX9iyi79QyMGP+ RgoyxugBatwQhUF0BCqkZFwNibXA9JmDSvQg6SDEdka1sth3vbvNDoMbHyHpb4m8I06TnVIWEMV SxhGfzsA7Wf5rydKbzHWzqgiGDD+BzWWrr/cxT90sSlhpacprfWpABNQGlLNfMarUGKDBjcHZbF
 /aOmFAUf0Q4JrMdIL7Ome3/jhb8YLrE89vect6LFcV5JiZg+YwPL0+thgc8/ejflb1GtL+CaEs8 uH8kX/N/8/oh0wU1tEvkoUboYaD2Xq2ABPn9zgRxPYniqhbMg+8jFkn0XKndDfnndVDElegtzGz sA286x8FowXo/OmVcZ8mUCZ9gfS9NBZb8XjC04wuy92jhngXXZQEFXgbS02n4WSwFV5pkPNofJN
 4T4rLCjAO06rnfvG620MSUvQ2KZlRhSOCevLL6/NhrYtw/zVUNJ33A8QcAEk7bBfQyqtU2Bx
X-Proofpoint-GUID: L5TZXIR4L8ppaL8Eihf4F7JpEdCgKl6t

* Vitaly Wool <vitaly.wool@konsulko.se> [250709 13:24]:
> Reimplement vrealloc() to be able to set node and alignment should
> a user need to do so. Rename the function to vrealloc_node_align()
> to better match what it actually does now and introduce macros for
> vrealloc() and friends for backward compatibility.
> 
> With that change we also provide the ability for the Rust part of
> the kernel to set node and alignment in its allocations.
> 
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/vmalloc.h | 12 +++++++++---
>  mm/nommu.c              |  3 ++-
>  mm/vmalloc.c            | 31 ++++++++++++++++++++++++++-----
>  3 files changed, 37 insertions(+), 9 deletions(-)
> 
...

> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6dbcdceecae1..03dd06097b25 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4089,19 +4089,31 @@ void *vzalloc_node_noprof(unsigned long size, int node)
>  EXPORT_SYMBOL(vzalloc_node_noprof);
>  
>  /**
> - * vrealloc - reallocate virtually contiguous memory; contents remain unchanged
> + * vrealloc_node_align_noprof - reallocate virtually contiguous memory; contents
> + * remain unchanged
>   * @p: object to reallocate memory for
>   * @size: the size to reallocate
> + * @align: requested alignment
>   * @flags: the flags for the page level allocator
> + * @nid: node number of the target node
> + *
> + * If @p is %NULL, vrealloc_XXX() behaves exactly like vmalloc(). If @size is
> + * 0 and @p is not a %NULL pointer, the object pointed to is freed.
>   *
> - * If @p is %NULL, vrealloc() behaves exactly like vmalloc(). If @size is 0 and
> - * @p is not a %NULL pointer, the object pointed to is freed.
> + * if @nid is not NUMA_NO_NODE, this function will try to allocate memory on
> + * the given node. If reallocation is not necessary (e. g. the new size is less
> + * than the current allocated size), the current allocation will be preserved
> + * unless __GFP_THISNODE is set. In the latter case a new allocation on the
> + * requested node will be attempted.

I am having a very hard time understanding what you mean here.  What is
the latter case?

If @nis is !NUMA_NO_NODE, the allocation will be attempted on the given
node.  Then things sort of get confusing.  What is the latter case?

>   *
>   * If __GFP_ZERO logic is requested, callers must ensure that, starting with the
>   * initial memory allocation, every subsequent call to this API for the same
>   * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
>   * __GFP_ZERO is not fully honored by this API.
>   *
> + * If the requested alignment is bigger than the one the *existing* allocation
> + * has, this function will fail.
> + *

It might be better to say something like:
Requesting an alignment that is bigger than the alignment of the
*existing* allocation will fail.

...

Thanks,
Liam

