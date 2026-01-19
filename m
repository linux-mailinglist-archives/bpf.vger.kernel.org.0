Return-Path: <bpf+bounces-79427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BDED3A0E9
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 09:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB45330011BD
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 08:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2B433AD99;
	Mon, 19 Jan 2026 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I1E+ApcD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LIam7ZDx"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7F9330B2E;
	Mon, 19 Jan 2026 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768809828; cv=fail; b=oJVkNbiUJjb6Dv5sfo1Xc6vonCSLMh2He1CpT0yMtKN9fHL7ojhHleWpB6vMM6agQiUX91jkrDv/B0EfBW/LVqKyHgPpJZFfUXu52poAFiJ6JhLO4JHo/IJFDn70SaaJ6mP5JfmZAa1DQRHXs6N1mwYNPXk9fqHEKTeA+BWWkEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768809828; c=relaxed/simple;
	bh=xNkukupBg3dc4k8vhAL0ld+0RIrk3YrGvk0p2yVRFOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PlGewSkB1e8Mo2Wu4JTPjqM6ZirkkFDFobmzkyifZiXCI+xOTUMk5z41HPBR3f59GLiNjfGnAovArMOevjK7eFsndEo0s7xKM8cja2Vtt1/8tAMJ55bc6Gfw7HcS2wWsWI980uVjHpB/64SE7fkXh4Rnt1AlO9mG8BAITpnXFc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I1E+ApcD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LIam7ZDx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J0Xx4e487848;
	Mon, 19 Jan 2026 08:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Pmua6qgn3Asw91hQ6R
	wRG/f530S6mLcJCtt6hduM2KM=; b=I1E+ApcDy3EiIX/2JlFg6cRCtY0i554R/W
	nr7mqsom/Fx/Ft+n4/UPE0Sx2CejNXMY8IGtqPmX1nEUOvX5pL8pSzp90R6+ISjR
	ZycqYq44nR+nDKzxJGrVaEywI9HnhTYaR9KLAFh7qeKJXpTSipmIQNFJz4Nk30WN
	rg7js052F5q1HpyX2lbU8zJ7/PyUNLSeWs2BQLTNsfB7//SM7c/XP4UOGQka43JO
	3Ahk4kaphn0F2laKJjvIZ8MbukLOyg4PyN7WZdldYCVZgdAXg+tIJ9XSBhX5aFzp
	IXsHaRaNt+TdzWGW8kTW8rv/tOddsaq5WhD8l/xUYNJhjchxvmkA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br21q9uv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 08:03:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60J6ORGl015779;
	Mon, 19 Jan 2026 08:03:18 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012069.outbound.protection.outlook.com [40.107.200.69])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v82d8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 08:03:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QaGssqk2wGcypvOHgrzpcQSEfdXkmKyFIYw1GFqV7Vn7t2zaY7oNJJ6FIfK7EDgJ1eofChbA0tsc+qsFwW/tRaW/6YnD+Og87cFi45CXKED59v6Mv2zlR9y+beUvtINWw25LFZz4EZ0Vjb4ivRMOBjRSXL9Z0Z7CXbcrAcgDE2e2uToLl5oCLmoI/UiJQVew8GQWtDlV5EmXiqFNCojU1yrQ2RPgYfMfhiXxeTDpGHnQHqbDDuurfjVOTVudajgFlRiK29IRCSHIemcXVjBvs1shxCXVTYxw1sXiOEvE2oBJlw2PYO2Auuak0Dp3RLiNJIeg6s5qbGPwmy1wHFoKKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pmua6qgn3Asw91hQ6RwRG/f530S6mLcJCtt6hduM2KM=;
 b=X/mlfZdE9DSHDT8cMmW544uvqlNQr+XlzB75Jqm4OXVs/Xih272KeOBvmc67pzkQj4Ly2l4xuQKTxlcvQsmGEKDdiFUWpLPWpsQ8hmFpp4IzCGtVtfDlI0Tg6U1e7XbornvzjFwz2VNCqLgLkqapHwHz3N2IL3j+wBqhsFqeiGfDwk44V6w1WEirOPV/NZ5RvcKHGqHproMmfzQ9re2m+BF2erDa8yT9+BWMpUgbebFY8PwYnaJDkd6FfNwAMGtMrHrq55jHujPMGXmfu7pJIDNHzBm58F1T6drC4O2qhAXoqM2ifL4hRRJYkquqQVwlkHb/kYF8LeCol2JkCd96PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pmua6qgn3Asw91hQ6RwRG/f530S6mLcJCtt6hduM2KM=;
 b=LIam7ZDx+LaDay4S+TXYtNpWUDjpM2UrBA61sLTOdGJuz836s58NwIyYyZCm17ZBqHH/wVLXpuvxfIRJL1y3nZOVLu5KhhSWa0rrWz1oRzSekjOWnDkRtvGpXV2WSJAI/A6MA5jDT/Jn4rbFywstw4I66RsYoQFGE83wMIqYER4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ2PR10MB7109.namprd10.prod.outlook.com (2603:10b6:a03:4cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 08:02:45 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 08:02:45 +0000
Date: Mon, 19 Jan 2026 17:02:37 +0900
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
Subject: Re: [PATCH v3 09/21] slab: add optimized sheaf refill from partial
 list
Message-ID: <aW3lHVyRUZ-lSq9r@hyeyoo>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-9-5595cb000772@suse.cz>
 <aW3SJBR1BcDor-ya@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW3SJBR1BcDor-ya@hyeyoo>
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
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ2PR10MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: aec3baee-5744-49f3-54b1-08de573120e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3TDbfYFYK8gfKnrrPVoDbiaXFM2YlQvRA4FVIY0UcSn12/vofQQ4KTsqcXLo?=
 =?us-ascii?Q?CUtR6Qc48RIn330l4GoBSb4SWe9G5VJPRKXrykfNpfRg9RNp5p8hYEpfAY35?=
 =?us-ascii?Q?ZFg4NbTO2w6ZbwaWV43xyjC6AXMp6CI8IcENy/TL8LfRmYGuY2S9Vk20OMe7?=
 =?us-ascii?Q?scWzH9OVDjzv8mgxKNlj7hDbPkOLOwCyV8/NnJk0nQp4zsw25krMkUgqAsJr?=
 =?us-ascii?Q?sJ1VomoEk0StRuaXhe7Hak7Qdsy47yA5mFNQSAxLrvqNHTTZE17LdRt+6M9s?=
 =?us-ascii?Q?fHCTXcXKoqKDr7rqv6++CKrKnFbAqlCpRfLpe8ySbNfY5QNoyxpamFjhreQz?=
 =?us-ascii?Q?8Aofwl216pDY1S0RxxhV2EP7wZdsjVJIhWURSaOHy4ln24yX7mx2fulCd90k?=
 =?us-ascii?Q?fmGhjlkq0fTdiZwcaKJ0E6UfA0si/NM2PD3x2IV5paUvwJtNvhAtw5yAL4Cc?=
 =?us-ascii?Q?yvam8bdbqOuRnVGxMoBsEqcIsYj94Fs72OgyLG6ETly2M632rx3SHDzmvpZ3?=
 =?us-ascii?Q?J1Fx/kp9P13hbyFJbLhnANaQSX3o4k6JibbS43F23yddJJ0eiXroBugg8BIK?=
 =?us-ascii?Q?x/ko6foOtzUkYFUr17Yk5oL0qIPXc5FuHV4OKEz76vxgEVZoIuABvzUgxypk?=
 =?us-ascii?Q?2ohRuNTR1g9d0CWZSsUsiVuS+gHp6NMhUhHutZmNbCfZa7lhoCtePbWm7853?=
 =?us-ascii?Q?m8FQd2T1saVZYdEHd69hGA5PMyVkntLwBscACzzjfHwjzDcqBBTYdunZXsnI?=
 =?us-ascii?Q?473eiHMSmoHLvH3HV9+q2eWF98+ldlKe1S3vA7whPLiqDdUeeS/+UKY876Dy?=
 =?us-ascii?Q?XGsZDmAij4QvTGqawbtiQQmACilnNWidNJuVfa1e4Sa0CwjhSv3ydM4iHGR9?=
 =?us-ascii?Q?bruvnRMHona33Yjfkau8gCZZhMRYhc/RdSDcvhTGdZLGZ5WIjVvgegipG7Mr?=
 =?us-ascii?Q?ZjMlkiWsGDOvJ1aKILjnmdr8bNHheuF+OkZv9PHLkxMU/PQHxYYdyfdE8X3+?=
 =?us-ascii?Q?dRjd8zFrKh7FVyIjnlMRZqgke42EDn6kiTRyOsvPQw1s7QxqociRE9eESGdb?=
 =?us-ascii?Q?LSxOegFE3bW1t9iBdE81tOLhUx3Ue7MPVoMrlmogd+gqCLCVF2tFXvmgbO+j?=
 =?us-ascii?Q?RDTbSL/YFn547mmc5eBdjvToHsjyq2gczAu7x9G8BdG/RTw54NzbsAJcnUoq?=
 =?us-ascii?Q?D6AD9gBSVfA5JYr2gqPhWmIuTLqc+c9WacyGhWCD16PSi8LUZY3X8ZeTyz04?=
 =?us-ascii?Q?5d4CLAmutAlQHuq1CCQN1TgFDcD7mEqk5Z+wmKo70Il4jRfBkeZyGT21XcAx?=
 =?us-ascii?Q?faj0afzMUgg5TzvbD5R/kPwB9LT1NM9SkQMb7+b/QMQaQXOvpbKaZbuO+9Ar?=
 =?us-ascii?Q?cdFbmyrj4B5Ub6L+dkAcS3k2dTk/2n+reWGlHUz81GaASbs0JMX1SZGFWUnT?=
 =?us-ascii?Q?ughIweA0ctfM7URYzHlzQO9IScu6Bs0OSwvRaCcsE7UkuBwq5+QkuZlqX631?=
 =?us-ascii?Q?VLEK9fr3IuEZ0syv14+tRc56TN9pvQlHThHT27eQpaqXL3pmKImee18TUklL?=
 =?us-ascii?Q?wIz75FQ75detW6oIG/U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BaiDZTdWvNFx8dAH90jKqEi46RemHGTI3p53XOG27J+wpOw1mOYF1bFvUMzl?=
 =?us-ascii?Q?gTzlCodKgEQL2cXQAQypwchDNFB5BNpPDjVoyFc1Nu/6tBT25SGkBYDY0LC/?=
 =?us-ascii?Q?2AekiDWd1Z6T/QJCZd24Zkw43Sz/MkNPKf8IhfdL5Nej0ygDNRfvedoFtnUw?=
 =?us-ascii?Q?CBtDV5GoYqbQ8KJuP8AcmcJTgmtJ3rbGri5uX0pe0w63g64NsgALfM92eVUp?=
 =?us-ascii?Q?QhdA00ZrGwzhpd46oma2GD5oE+W4VY6PB7YOxGnr7GCVrAXOxB6PorhvD12O?=
 =?us-ascii?Q?4wsPB7EbIVNt27ci2fwLraLKGzsvqSylYDYSMLrqO05vUCvhdsJeEJQku0Lm?=
 =?us-ascii?Q?8HLfvIU/S6rohoeSJyuZ2LHfU+Dczh2VDyDynMrQq+uffbjQvDBlUuJTtgKc?=
 =?us-ascii?Q?upDuhW/xBXa1Y2QsSLsF3twKsOuuclp0DsZsPUbzGLFadVFr8uHA32DLsH9E?=
 =?us-ascii?Q?8OtURkChA+8DNE4c/HkU32IVFPm+1eRBUdxhVE6RzGzyUgy1c1k3TZfhQwhx?=
 =?us-ascii?Q?l9swRoO0/2iyHmUj6GLZBHDQ1Ty3H+vj1ERfQVJ3IaHTWZlHpGnSv2Ir7hiS?=
 =?us-ascii?Q?eiN3xaUZCBGuywQDTxfZ7DRHoayRg2Dw6K6VwcBXlT786Bt3Tbp4nyHOPMxf?=
 =?us-ascii?Q?FirxY84CU3v2z4TduYh8bPiTePhY1HXHyc4NDwV2o3GlCjqGgtY1I61jy2yc?=
 =?us-ascii?Q?lKDRW9yXWyxEExLHxraM7Eih6x3gur6NYOfPhTejjtfgNSQfLQsZJuWEdFW2?=
 =?us-ascii?Q?MiVD2sCC0i/Phmypq3jS0uz/neunYhgY6mSkEmbvUqHs1M55IBp8VphQDqVl?=
 =?us-ascii?Q?UupbMZh4dp4bjgHj0bl1reYPZt291wPsWP3NZRJgHtd438YLG0AVAjpkvLuv?=
 =?us-ascii?Q?v93hy2z/xAAlVS1GnNEO8nKvUKm3Xs46Ld3B+31+zlIrEexwSCLDyl7uUckW?=
 =?us-ascii?Q?KMDDj6KpRVxoQfyT56CPbgEzVA49g8pu+R8x2KdvKfjmI6WMsaLMGdY316Xb?=
 =?us-ascii?Q?KI6dRczA6R9Yu2CAypxIV70/7p5ZsjVEIW+q9pTJjez3U6THDNxdUt5syAJq?=
 =?us-ascii?Q?L63YlguOk9Gkc3bVkiDV86ucodYT1/bnjuV7eCFijmwrAzkvGHJfpnNB2Yt2?=
 =?us-ascii?Q?FXNdMdGvGsUedAsCFcriYvxzdykJa+mYGqizmajhsNFj15Q38b0RU3jOn+nG?=
 =?us-ascii?Q?DBp4K4e4+tiMMQj4CjHpa459GKNpfv9Pf8E+Rr3zH8DrJAtObpCPZk/XGX92?=
 =?us-ascii?Q?MV8+N+Zx3WWQqYNMrl7SsMJ2kRuk/67cGR5dZic8DA5UVWWhKRF22z2AHHHO?=
 =?us-ascii?Q?+XERYd4F2IEUJqgFYWDdcw+BKGt921Yr09Urju6JDlTX8emV41Dst1V06OjH?=
 =?us-ascii?Q?EFRmZLJFgbP4FEo47eFGJ23rl0IB6z08cunmA6i7LhnH6mec0vfXiMnbNPKz?=
 =?us-ascii?Q?uVCaMrPk/53NHFP5SG3S8hzLI0ZFoQqoS+K4OjqaJhk4jqynvBAmLqztz/9M?=
 =?us-ascii?Q?WmO8xm/sj5+OCYacS/TWeUweqRfUsTVrakBu7WhoPJZXE1pLTLJAz1AzLbcw?=
 =?us-ascii?Q?xAI603JW5OSz8+3fdYNDuPpU0E7bvs3cGdQq90MW6p2PKh59uGt4jtREhWQC?=
 =?us-ascii?Q?zokgzCG6kfQna7YNalCUiBioB1ZQZDePqWM356tzHAhl5npjT55ZQP63JPS8?=
 =?us-ascii?Q?WZZASdPryJtVEonfx1OdOX2VnhnzF1MmpsyY8jWxbOut3rEAYP2r+wxcAO1T?=
 =?us-ascii?Q?C0hmrIqL4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FYoe7Z/mRKDb4/HfmbSWdj1EiZc4h0fD8YilJXamTUi8c+m5yj8R5Rt6KW7aqbe6tSglOygxsqFnHIULvGYiDqIGkTFZwvcKU37gdQweJntq5aK9yhWElwon2JDqZ33S/WGtZFj0tPEvjuFrToc8RjaWCd3oL8QHdejfZz72U6nULDDvdVRbxvPHz378mXbnwMsWx1BFQYeJPgvAZdLYYyzF+B1TU0L4EEn9VQic1tdRAnEvKiLKmgUqc5jIzz7LMG1fvhPMvMHYiRGB6QPE0Ki4qGWb0SJiTuXpDwtRxz4dPx7mTiVUikdeOOKHuBVtcEw6vZwvQpTDzxN6rv6ngEzBb8WTWk2KKbqhmqiLyjifi0NlJKXA25dmuS+JVOdy6uPsNu1OHBWZZj2culO+ZZN6yV+oAtFm6mfxIEi9mMSE7I8jShVL0zWE+8MM9u4tJoSWbaATOdqPYKjNHKuN0YNpN4GGj3sUFXK5XEoeTF+OD54eTDC74Zhs3OjCFhbvtJ99OMaen6zBsGdvy5vuspOzuf3GEseGDXdo5YAG67SrJfK61lsPYsi+O5Bqbm92+kV2KdyGSW5/5jp8R2ZlvH20Zgwz/IwOhs9oB+XCriQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec3baee-5744-49f3-54b1-08de573120e7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 08:02:45.3767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kl0LXFNQv9jT59bbchOKmYruuBa994L3WFXxp8sfteI5p0XP6eikZBE0UDeW8vEVSrb6RS3ClW8c/OK9b5Vtxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7109
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_01,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190065
X-Proofpoint-GUID: 0Y3l8-F-cpbGGEbYFliDrpSdJ35Zh85v
X-Proofpoint-ORIG-GUID: 0Y3l8-F-cpbGGEbYFliDrpSdJ35Zh85v
X-Authority-Analysis: v=2.4 cv=QdJrf8bv c=1 sm=1 tr=0 ts=696de547 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ubGn6r4w6hh7XaXUDWYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA2NSBTYWx0ZWRfXzeqLuWYlpoVH
 QUvMfezvpDffyO+5xnzeatGdbUjVzKnaqrojuaEPmPT4dkfPo4sPlDrvM2u15+gmkK8jbTbNlf0
 n9r4YYO17/L2z1iDpXphUMPT1GT8CIRcvL9pYaypQHm/MBmEyV/Bxk8+9zysDDAL9xZnP7v4ykk
 cIBjASZU3dthUOivZavwxZokMvpeNhmclgielbYOS0Bvv9w+zXPk9sJqLQMOIB30X4dfQWVbld6
 HEUz8xyJep/WUcPyVJL0lC1oq3Erer+Z4L3OaTDFGoLX1Su7yp7G7JooEht9ZWM7bcIv5CI4KnN
 YFMqatSjxS8KxdjNuyKqcVmVuQCoIQa5mb/gCG/kcBFI+tHpgtWdTR8AsWNk51eDdvk2btTcevN
 w10Y0nUq/F0TSxeCZrGoEg4yUOQCDrFsFKKKaQFnvlRvGEF4ynr5T4ms8kU0DBsxKYWc8tx/s+B
 E+YG9R9c/yBdxdENFqg==

On Mon, Jan 19, 2026 at 03:41:40PM +0900, Harry Yoo wrote:
> On Fri, Jan 16, 2026 at 03:40:29PM +0100, Vlastimil Babka wrote:
> > At this point we have sheaves enabled for all caches, but their refill
> > is done via __kmem_cache_alloc_bulk() which relies on cpu (partial)
> > slabs - now a redundant caching layer that we are about to remove.
> > 
> > The refill will thus be done from slabs on the node partial list.
> > Introduce new functions that can do that in an optimized way as it's
> > easier than modifying the __kmem_cache_alloc_bulk() call chain.
> > 
> > Extend struct partial_context so it can return a list of slabs from the
> > partial list with the sum of free objects in them within the requested
> > min and max.
> > 
> > Introduce get_partial_node_bulk() that removes the slabs from freelist
> > and returns them in the list.
> > 
> > Introduce get_freelist_nofreeze() which grabs the freelist without
> > freezing the slab.
> > 
> > Introduce alloc_from_new_slab() which can allocate multiple objects from
> > a newly allocated slab where we don't need to synchronize with freeing.
> > In some aspects it's similar to alloc_single_from_new_slab() but assumes
> > the cache is a non-debug one so it can avoid some actions.
> > 
> > Introduce __refill_objects() that uses the functions above to fill an
> > array of objects. It has to handle the possibility that the slabs will
> > contain more objects that were requested, due to concurrent freeing of
> > objects to those slabs. When no more slabs on partial lists are
> > available, it will allocate new slabs. It is intended to be only used
> > in context where spinning is allowed, so add a WARN_ON_ONCE check there.
> > 
> > Finally, switch refill_sheaf() to use __refill_objects(). Sheaves are
> > only refilled from contexts that allow spinning, or even blocking.
> > 
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  mm/slub.c | 284 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 264 insertions(+), 20 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 9bea8a65e510..dce80463f92c 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -7463,6 +7597,116 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
> >  }
> >  EXPORT_SYMBOL(kmem_cache_free_bulk);
> >  
> > +static unsigned int
> > +__refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
> > +		 unsigned int max)
> > +{
> > +	struct slab *slab, *slab2;
> > +	struct partial_context pc;
> > +	unsigned int refilled = 0;
> > +	unsigned long flags;
> > +	void *object;
> > +	int node;
> > +
> > +	pc.flags = gfp;
> > +	pc.min_objects = min;
> > +	pc.max_objects = max;
> > +
> > +	node = numa_mem_id();
> > +
> > +	if (WARN_ON_ONCE(!gfpflags_allow_spinning(gfp)))
> > +		return 0;
> > +
> > +	/* TODO: consider also other nodes? */
> > +	if (!get_partial_node_bulk(s, get_node(s, node), &pc))
> > +		goto new_slab;
> > +
> > +	list_for_each_entry_safe(slab, slab2, &pc.slabs, slab_list) {
> > +
> > +		list_del(&slab->slab_list);
> 
> When a slab is removed from the list,
> 
> > +		object = get_freelist_nofreeze(s, slab);
> > +
> > +		while (object && refilled < max) {
> > +			p[refilled] = object;
> > +			object = get_freepointer(s, object);
> > +			maybe_wipe_obj_freeptr(s, p[refilled]);
> > +
> > +			refilled++;
> > +		}
> > +
> > +		/*
> > +		 * Freelist had more objects than we can accommodate, we need to
> > +		 * free them back. We can treat it like a detached freelist, just
> > +		 * need to find the tail object.
> > +		 */
> > +		if (unlikely(object)) {
> 
> And the freelist had more objects than requested,
> 
> > +			void *head = object;
> > +			void *tail;
> > +			int cnt = 0;
> > +
> > +			do {
> > +				tail = object;
> > +				cnt++;
> > +				object = get_freepointer(s, object);
> > +			} while (object);
> > +			do_slab_free(s, slab, head, tail, cnt, _RET_IP_);
> 
> objects are freed to the slab but the slab may or may not be added back to
> n->partial?

No, since the slab becomes a full slab after get_freelist_nofreeze(),
do_slab_free() should add it back to n->partial list!

-- 
Cheers,
Harry / Hyeonggon

