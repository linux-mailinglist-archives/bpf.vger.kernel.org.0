Return-Path: <bpf+bounces-74056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 765C6C45C50
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 10:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A602F3ACA56
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 09:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4000302CA2;
	Mon, 10 Nov 2025 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oydbHTQP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eGDmh4jw"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C58302158;
	Mon, 10 Nov 2025 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768465; cv=fail; b=i7CkP8G4owATZWng/cJ1gm9b6pDT5WuEzcFAvezvu1+Uu6YGn1RquH44zgOlb1GC5GQibj9lVePrEBZ5BMLOW1I5II//RT2xPpWUwKHNQhW3NjBUu4IGejifrxqBR0Kg3NP8vug4uQyqbLj09SDm2gnLQ2rVTCRwewLSPspjDHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768465; c=relaxed/simple;
	bh=LtBDqzEtAA+6pW3o2tLdNQOj4/XxPyVevLgvHRBybAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=InNrNkjuNARe7DdoSL+NO2InbrOaR8bIbq6BHuuYA2G4IwLQI0WhF7Ypp1VxU/Wjntyuig34XCaRzekrU7TCp0Y8FaF9eMJ7cPex+/b8zCOJyYkoUCVHNlIozjfkxjwMfpxkn8Mm1jYenCjhq7CeWtYTwQp3XrzS8Z6yt5ToH4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oydbHTQP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eGDmh4jw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA9NbuL010590;
	Mon, 10 Nov 2025 09:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=IfGibePj8O7QTRpwz0
	RBLnLO32n7MD+f0y5RLmU7uzM=; b=oydbHTQPEWdUGheiRr+yjW3ej61K+GjuXK
	npF/ptnke9QQNV5JZzE5FBYR0jE/6hFniA2GaGOYYyy71q7XBFegFCWBbHupNBmb
	pP8c/Mbh3uPoT+8cI2nbQWwM2sT0NtVfWGilvG2Hrq3L7ssb7OatYtcoP8CLwLbI
	CpWrpzS7n2yN/2/mitJeBNLchKx2VkvDAOXbbcb+JotiloZe7P3GYvIeM+2Ogwwa
	Ajl4Gci7R/I8pu/MIfUYt8yC1q1hNDr5rHQHlhpH0t9q2Tq2ZGGIlTVvEPNEO85A
	CPjLiRCJHWCNRtpxAqETdZ18/I1p+iPILX5b4hleran3Pa+7subw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abbss09gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 09:54:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA7eVhq007388;
	Mon, 10 Nov 2025 09:54:07 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va8eshm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 09:54:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmFa4y4jJ/UjzH6Rpb1ooF35gwm0041+DpWGqfpetNcLMoR0ajKo+Ikfgj7GMzqa1sXH1Ylvo6dkjAaINcffKgh/mlVDjjKQgzDt+KKJUBXt5O2WcVH91l87vyVxyFI3hc0aJ3FM/NW1gqFGiJJZ6nkMTfzNdEVpj6MoauiOWTaGCLyG2S6Oxan8LzUSO1KfrRUDxdqWFUwJoM5hSFUJP8HuPOCdYmTIoF5FTtbapAGGsMNqSQ7lM6oOBDCxO0EK1zUHY2BOnJfTcnrxrSx7l/resGZWi/zphQE2DjwG0thV4xu/DTXGcTRatK+USvHmu3iTk4hgUhnMu170L0WSOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfGibePj8O7QTRpwz0RBLnLO32n7MD+f0y5RLmU7uzM=;
 b=cypoiJQ2tFiSKhgVAjQg8DLbw01V0GyNd7CJ1LKBZGfgX95nzN+FQqWiqrrXzkglK7A5gGyV3DurPuHMThgfqj88JO/Me+gSc78IYQ8LfGK8q1tQCG6dbzTXVFF34Tm3cfjxtgW8obWI/MOxmmli8UZhUofn3sWviIBh29kNP73PJ6DmphLxQ30VDg5OLZlsXUEpZUVdXI/MRM0Q7J8theJZ1xST2Bearjv/okc17flcbURUruXqtp14rZopVoKnKLzrYGn4FSlMZA0Uldx5xI/0EVGm/QVBbe7+fIj+A9Y/HgGIFYsZ4VXL7HxsB7vo3YMD7Os6uk7kFdCHkIz31Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfGibePj8O7QTRpwz0RBLnLO32n7MD+f0y5RLmU7uzM=;
 b=eGDmh4jwnntPTLib+BYP30zEvqzGEBokSfrRFbEY7s/v5rL7yskOYPMZk9oH6tXPl3Cd8i7gHqf2oB3OugkSLHavRee37lq374q9l4p81+MqWJ1tfey+HuBCDf8yVIPEjJqgG+6adS6Bf97kc4iylH6S4Ip5omw5s6Pf/ySvgRE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB6903.namprd10.prod.outlook.com (2603:10b6:610:151::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:53:54 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 09:53:54 +0000
Date: Mon, 10 Nov 2025 18:53:47 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH 3/5] slab: handle pfmemalloc slabs properly with sheaves
Message-ID: <aRG2K8YCqCZa2Yfx@hyeyoo>
References: <20251105-sheaves-cleanups-v1-0-b8218e1ac7ef@suse.cz>
 <20251105-sheaves-cleanups-v1-3-b8218e1ac7ef@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-sheaves-cleanups-v1-3-b8218e1ac7ef@suse.cz>
X-ClientProxiedBy: SE2P216CA0036.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:116::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: b265e0b0-ad35-413f-1fc6-08de203f0ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ecfb9c3SQGSsVXENOeU7fk/wzFGX7UKlebO9d0wo/bCigB8kb1PluWoSKOHG?=
 =?us-ascii?Q?DnKB5M91CHNnFBPyYH7oWTlgnU+ZabVsIAfZYGDT9EvVUU+OL0VhFI+FMrwy?=
 =?us-ascii?Q?PPdEVIk00G8qfVkI2sQLX8Ug7fH6ztli2XQMnjmxszsbNuYl+TIM6/3ERyds?=
 =?us-ascii?Q?c/bEvTuhq3kDfKSyflMBCfqFSTzVb4zyuFo7wLQ3Bcsro9ubKyFtnhalnhQm?=
 =?us-ascii?Q?68gxHxRF8yq0oUPxbYmlazX8UNwBzbG3Ev4D+J9HDs4p/OJOABEXfxX4vKxk?=
 =?us-ascii?Q?2mrY30VcIORxKQ5eeP1Q3geNiYYeCoV4T3ZJ7s4zikdzuzmsB87O+IWR0DE8?=
 =?us-ascii?Q?+XXIKoWS0iZGNJxUXqohQUOY52hUnSNMZgBRpznW8kiLsG3sPaGhGSKg2vmD?=
 =?us-ascii?Q?1v9tBcQ0xF7LFxgLuJ8nXY8i/joyH58+wCx8QIpn4ZyCwrdYV8Pawmx8OGYP?=
 =?us-ascii?Q?z52DLOpJ6xirHt1wY/8Ugdc/grPG4+FXa1rf2DqyttAE2HdbuNrDmtakf9Jz?=
 =?us-ascii?Q?BrubDseHaUCzCMQbyzE9hMz8BKi4+ctmnnsY3B5FVm7gwaHGMhfRc/5NWbqS?=
 =?us-ascii?Q?ZtLxNt8qbDpMdybQu0FVjPxBZw6Kx3d//3uYyNp/geos53owOQvThZGPYdv6?=
 =?us-ascii?Q?amPFBD/WMO6NIwCIeqJq1C70RHSfDLXfvM7U3KF+v4cSEmeiqlv/0EJYAs0E?=
 =?us-ascii?Q?28TBfIa072WQ46FgpHPRGn0H+09HB1XJYdX+EAR0ThwJcP6r2I+X7nLe44zN?=
 =?us-ascii?Q?3JOYPAlXGN9cGJMON3RXc17Z83bc1kKhTT837uzwpTauXyKx6C/kAjVTz3z3?=
 =?us-ascii?Q?EULiDgmpZ1jKj98dF/PoF0kuSYzIDJTp0kSYMxPze/I23F/Hwywjn2B9Huo+?=
 =?us-ascii?Q?cmm9DTzS+dPLE0EZ8ql83iBrjAsCYCnWldKjGxaG7+UyHyTne8dHcycAibum?=
 =?us-ascii?Q?g2s5DmoSOYKuvnJaDFw9MKEalpQNinRVnAPP94oIysWQL/oaZMRAxpF4ePsy?=
 =?us-ascii?Q?J61H2zN1JvddpBhl/QTDme8C3DGFj/jyzru4YTiME11dH7tQEjtICLp6AYCj?=
 =?us-ascii?Q?WfUx87gqIH2m2/MWEMYswqmAtrv8aEvAlYxEisF+hRmnsf5zDnCvF9IJh8td?=
 =?us-ascii?Q?C/o3D/gnq1PjqSwJetF7J9nNQEyj5piAi+fom1HID9Kkwb9tdHR1jSAw1okr?=
 =?us-ascii?Q?dpkWzI0skaBs15a2nDvweu1xnWuIl5STWskW/NL0lj1oMJSIJTxvsxcnYd+C?=
 =?us-ascii?Q?Gpyaf2cXd9/DjvHMtor4DVVNJJJZ/viiSO75B0T8tqiJUlSkDWwjIdRoc72z?=
 =?us-ascii?Q?uo6csHGPHXPa0EKXNsTu9/jryqyetQoTmnUzLNZeY9uvtV08dKhNxypD97g+?=
 =?us-ascii?Q?0AoaQ/t0tHf1bVWP0dblkRaFKCkPNuuracHKsRabjCNO51O3QZPOJHCSE3g3?=
 =?us-ascii?Q?tDv3Z1zJNOwujAMOHOk7oo8NsoLa/eDO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QJgi0468xbEVaUw9gyAjOsr2Zh8ZcbN5aQPmTfp+G5Rwf+G/VUnxQEowr5XU?=
 =?us-ascii?Q?HElPVeaA2Cf4hB96spGirs5GZOJ/0dlJJuRPAmKwPtwgyM7Q+08B40rF6sg0?=
 =?us-ascii?Q?FzhGX3JK9YELSlEIT7IxseClXvFr8nzYf+aXwSeOzD4+YDY0M9kBsV0AGaY/?=
 =?us-ascii?Q?F0ZpQqmX2zHTgGS5lSmviHljmBghIT1PEezLgfIjAK4ItHvWIOTdQjGDFTvE?=
 =?us-ascii?Q?PhtifQYvoT22XAMV776ZFokHck7nt1xi1mlf5mllxc9Cjo6kK1zWueybrJBp?=
 =?us-ascii?Q?y5/3mHogthZC/DDIBh66Li9ADr9wV5ev1ngRsfIx3rdxWlHtnexicslP44c2?=
 =?us-ascii?Q?VE81GInmXjOsj5vyAMa7fogqhp+NEoZW9A+7DRQUx1KItRoVuemWVMwaHlDQ?=
 =?us-ascii?Q?f78dP1vcH/quXhEkHAv2FQ9kugFeuPAzVPhFZnEenuwM8yfXddV8qsf6qqHp?=
 =?us-ascii?Q?tjwTnN63c47N7Z26fQhyOR18xmTcrQAiRqMRt5NofXItJgTK3ma8ODG46RIw?=
 =?us-ascii?Q?fTbsBxQZaOHikpfvwyZoeVcyvZYkkg7f9vvoMxuaa8Fx3OBTQB2hhCAKhm9/?=
 =?us-ascii?Q?hCYpZ2QVwra/SeGquuuVvjCNc0GcEmPq7K22lklR6glVz8rNWg1/JKu6shBL?=
 =?us-ascii?Q?CtXWSP2oNb9glcObP62Io7LLNIheH9LbT4LM8S0DDTqRa61mQy9rna5q0KSw?=
 =?us-ascii?Q?CTlxGvtU5W3ze3Rc8zRcnkq+GZvh5AlmjtffQZ5UXqnQOr+5no01vE9W928F?=
 =?us-ascii?Q?70WOjsgNmQLWshAdF+yYeXzwPnTSch1eiPNx/TrHZzSUd0YwT9c5rlraF3lr?=
 =?us-ascii?Q?BykvDcu36Os+CI6V09fzx7av97kQ419txKFL92n5Xda0BIVE71iduwFFHMbV?=
 =?us-ascii?Q?GA1fmbB4TDHs8hqZG4OfEIGGtqgaXeeQEmSFCYElZ3O7SObPJq5cvxzFMfPN?=
 =?us-ascii?Q?54wTPHvsVx/LBTr/+Fhimdl+v/xPGxsfXXdS2yLqG/I4dZF7+tS13lxm4iw1?=
 =?us-ascii?Q?pHp+xCuiTteIsU4YAKfS2m/5FUtqTGCn94HC1Da55+oXwJY3MomBUsHCkMQP?=
 =?us-ascii?Q?71ejIDGZqsZS5gJP3WDnMQfYl5UDfr8vXjabmvOr6c4+1S9dQUZ/SGMRJrud?=
 =?us-ascii?Q?WB0taRtPyRG/vZ9v9Z/L5PFeejbXrA335yn0RbrUyKQaQY3sX8AcVEPzv1v4?=
 =?us-ascii?Q?TwOnsCrpjmQyWbSvDfnCv+0RKd53G08v6eUsJdVp6wCaBLG0VDz+q2SeAn+R?=
 =?us-ascii?Q?x6O0PaEYw8WC/9UwxZGCtAftMuozYt4ybZcnnXqcyisqICjQUFGhfoAzElVd?=
 =?us-ascii?Q?NVbjNklu9UbyK/BWOFqVzIBoZCpPeRUskdRj6GrDDht6yP0TJrIEZ+ztVRjA?=
 =?us-ascii?Q?2zDm9muFC7P+f6qJycBeVIY/QltRe68u+TcOAMaCHRS6mrM7NcrPsN2yTvzy?=
 =?us-ascii?Q?smc3MuMTqMU7jiTtzbGQ7XSDmn4NNQGtBeQNO9L2uVpJ34GmFF68hr1r4CXJ?=
 =?us-ascii?Q?9W0ysp7LHfUUZ/4zucR2IU8fmkWL5FS/jOeDN42sgNg6Bm1WBFubYJuAIWdM?=
 =?us-ascii?Q?csDot+XCK8PydcGJlfQ3KDj1GmO5lW7YJWu2+1tt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f8vZ/ZFLd+qI+S5W+c8UVxXT69foYD2JC5yHcf5mBdVMRrnsSzQRBKYPf6ZMWqH4ixGY1RfbuYNEUPxQBUhG4igRBIoM/SKQDVed6U0f/scF1jPn99AidKdNVVkHuLy5E/0nyQUxRa5G4IXbr5CmzXWAfNvJkOyzZ/XgIajDNyC78QDs1HyJI7sBNHMcvmSGeuXEMT0umDrKJGuvFvUstyapwweR4keadZvIOcjvaOCzjEyqOqzDbhm/Dq6cW2+gplGPU+jfq6b6GHrPSkbuwaY2jN+AdbqPLb84Br65H1HxMNLiHoDwAElfTuRAZvpb6eeGLv1QYnVsT/+T4NUmjeyZJiXXCti0fdMeLZPDAUS4F1E5SNOI2KsT/CUwF+gBqVUyAHAliV36GpH4/C13S3lXKsnFI6qW9TvchjSSqMlaROcUGy0v8V6pX2UiHMrNHBJssClYE6YgZ3se2n4cW3QSloUTA2isy3nk0/ASTev+cU01psgq/7IbOYkFW04MWVPPEMgKVdAGxUgNoemza+qBScyXvSUmCOWNojHR6c4cYGyOC0i6ZFIuzCzn4M+CmUGV0IVwmv67V1cgdoW/it+VxE2gdZjIuwYPblTW+og=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b265e0b0-ad35-413f-1fc6-08de203f0ec9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:53:54.1554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwopuvu71u01svUlGSoD1Dx6oNBUTIieLlHsKPp6zOrP7R1OMHV/+E6gjD0qZ9pnUZu5x/iKk9hfa1VxiYk9lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6903
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=924 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100086
X-Proofpoint-ORIG-GUID: avIVK6MeXggzdI4ey0PDGhG7gOfsgRgK
X-Proofpoint-GUID: avIVK6MeXggzdI4ey0PDGhG7gOfsgRgK
X-Authority-Analysis: v=2.4 cv=f+tFxeyM c=1 sm=1 tr=0 ts=6911b640 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=HqxLjavZxCgagS_tWHYA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA2NSBTYWx0ZWRfX2tB7iniY8jMw
 zinHLodhV9OyNhQlKrlHX2PfKsmS0Kqk9xRUIN13cO1ixaXx5wuA3xriN1EvJamCcLpwjSrA97v
 12iDoMgAwwNeFDIzi9oscOJbaB9jiExYrEDCEjeDBEhjgLyWVshA1Z4KiXoGGlnztIemf5vg6X9
 ikD1wlzP9JAu146CgH6bHv73wDSNEW0E6fToy10nR+yijZYsDR4hsQaDHtoaOVQewDXIsaeRDuS
 RqtZ5HM1MObIRXyMetAQE/exirWvSP+3TJaYaM7/d2/rwWd9I02x7aoJANRcUn+7aStgKcydJJM
 AaMjlTRwdHPcJjXcm8F7ZzlP/t/BTHByfxQoVuB+VfKQtOzSC1BEs9WOyHCP9n3er96X8ZdVdK/
 Bhix79bwnm2ZKkZ2b7lvPWbpunUVDQ==

On Wed, Nov 05, 2025 at 10:05:31AM +0100, Vlastimil Babka wrote:
> When a pfmemalloc allocation actually dips into reserves, the slab is
> marked accordingly and non-pfmemalloc allocations should not be allowed
> to allocate from it. The sheaves percpu caching currently doesn't follow
> this rule, so implement it before we expand sheaves usage to all caches.
> 
> Make sure objects from pfmemalloc slabs don't end up in percpu sheaves.
> When freeing, skip sheaves when freeing an object from pfmemalloc slab.
> When refilling sheaves, use __GFP_NOMEMALLOC to override any pfmemalloc
> context - the allocation will fallback to regular slab allocations when
> sheaves are depleted and can't be refilled because of the override.
> 
> For kfree_rcu(), detect pfmemalloc slabs after processing the rcu_sheaf
> after the grace period in __rcu_free_sheaf_prepare() and simply flush
> it if any object is from pfmemalloc slabs.
>
> For prefilled sheaves, try to refill them first with __GFP_NOMEMALLOC
> and if it fails, retry without __GFP_NOMEMALLOC but then mark the sheaf
> pfmemalloc, which makes it flushed back to slabs when returned.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

