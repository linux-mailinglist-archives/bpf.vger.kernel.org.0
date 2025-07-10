Return-Path: <bpf+bounces-62906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603E3AFFF19
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 12:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BDA5A2D6C
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 10:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202242D6618;
	Thu, 10 Jul 2025 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aqVxGK7S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YCBo7D9n"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0EB2D63E7
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 10:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752142935; cv=fail; b=rPXIBuRzUh81sAjK/wlbvI1/987ChyKOmPXOQsl6exeyIsH+vqJd3A5N8dclU3pt+BRJgtzmVkS/L/9QdKSpEcFrxBumk0zLpaqZJUYp2kkJwWBhMXtfDs17k0mS0yrAvbI+eTjlMXsTnJWG7GA9M5nAtW9GrHBDc02UKOWsRSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752142935; c=relaxed/simple;
	bh=wxkFdLgiW8hp6TvfGukCq/o3tCKcL2I+XTxaLsxaeXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CHVzzcs+CEVsnNUk8gqAoJ6ZNvkDo/+HvU3Bgfoty6IA9g9/1k2OBct3EbMswen/zQiwioWbNXQOhTZN3cRe2Hz+bHWa87GIOOc7/YE5ISqI0Zl7loB2t0rVVVC2yCNzG0Owwjn36r5uVPUJxFF//Z9DUSC5JbSlkZd/pmu0LDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aqVxGK7S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YCBo7D9n; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AADBSR016987;
	Thu, 10 Jul 2025 10:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Tv30tLCCQ0FUMtXel9
	hParUHsfqDOkFzrrjh+eq54eQ=; b=aqVxGK7SLB2rnQwPZR2vKTml6DkDrR++tO
	zz2i41fJ9mxJiMDQJ57WlTSnF9UlUjKCAFpAnp8wjKtpNL7hwcci6G482m8gz/N+
	BSCBrT/OAs70Msl+Ql3fGCj20s6G2D8JXLlCmMw358ei2Lpt7n6ta6l7+lSLytUo
	/RpMKT/H9WAHffRHl/XL5SCBfV5+sxWRhKCYLWHO9u71nEs+CC6aQnWuuvLQs5yF
	C5qzmvm6++OFTgyyPCbBZoR9BI0wKwIH0PPPOBuYNbnmA2puKgLE1K0dCO62v0Si
	t30+qlBvcb7VoDvgQaIpdJ0yXog5P97jmu0i6trfHZcDAkzOVj4Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tbj7g0h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 10:21:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9tnew040481;
	Thu, 10 Jul 2025 10:21:49 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgcawtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 10:21:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbBUJQtkv2C1JePg1qIiEceJzkTR+ryxMJhZRAwzI7Onuv5/ysX6kqF7PBfmvB2k9crlNtr8ylnyAKY0WCXmisqcEQ0RQjELSnZQY/Yhf/5EKMX4zrQ+/uHW3cqp2H28AxHq0jbujOlzvfqQHASGS/u/gtlnrCFZdfwZjBPw1OUsC+tUj+BfXXAvS2qCjNGtwHnc+4WVzsb/6eQBOLtlRrdb/jzMpUzsiEpFt4GU6bHC8+Fbjcs3b03NHoD2ERjlu7sNJn+yej2eEU4c7K5p431bgOKMj2nudoHKIMmoFP+i7sureBCxoRgcjx+d3vJp0k6Ldc0Sl8gGdZRq+2znqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tv30tLCCQ0FUMtXel9hParUHsfqDOkFzrrjh+eq54eQ=;
 b=FJ6XbcTxfWsvd8QlnVzJhWV/Jxy7ekn+25d6/B43VXqQsZZaer1+93lF90HdPSnZsjuvWTU5gCrRYu3NOENVp7nXS89GbO0saTI75fAo6WmiRtgXIoRJ9ziYrjr6w4WmZhLCKR9tOdGBnD+Q7Ij0CxDuT6z9vRz6hlYh3i35UuA+Cqo/WkFC1Kf8VgRgwY1YnB1d/PCmNECo29HGO9ubWMjlEbP1+xY6Pn2Af7O/eZvtDrnlxTYjMcAFTH3bc8LmVgNmCANA4YfUqQbVlGh4w2lIvcT/tEO42ErMVknk2DbQ0p8fFQDxbBhzyVA5v8OgwP0atvMzcnkjjs0gHZztwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tv30tLCCQ0FUMtXel9hParUHsfqDOkFzrrjh+eq54eQ=;
 b=YCBo7D9neMN4iMnROUjjP7QXTMSOlqOiJ5BPT2vmJToyRS0iryXgYelDSOQpOcc3/PsbeWXAiofkWpo4IEm3ef9MtpF5ueD1gVyzwq8GmAfA5X7leq/Z0kMPqSF1dATTnOQU3Fq/TtllfIuNMZRFpMxDfuiRDzrDvmALv5azRJA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW6PR10MB7637.namprd10.prod.outlook.com (2603:10b6:303:246::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 10:21:45 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 10:21:45 +0000
Date: Thu, 10 Jul 2025 19:21:38 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
        linux-mm@kvack.org, shakeel.butt@linux.dev, mhocko@suse.com,
        bigeasy@linutronix.de, andrii@kernel.org, memxor@gmail.com,
        akpm@linux-foundation.org, peterz@infradead.org, rostedt@goodmis.org,
        hannes@cmpxchg.org
Subject: Re: [PATCH v2 6/6] slab: Introduce kmalloc_nolock() and
 kfree_nolock().
Message-ID: <aG-UMkt-AQpu8mKq@hyeyoo>
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-7-alexei.starovoitov@gmail.com>
 <683189c3-934e-4398-b970-34584ac70a69@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <683189c3-934e-4398-b970-34584ac70a69@suse.cz>
X-ClientProxiedBy: SL2P216CA0085.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW6PR10MB7637:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce2779b-04ba-487c-0938-08ddbf9b921a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4J+e4JuTu5kiXqfVt3dTnpUlbmcIj9h3A5JMcvyhR0QEJ0lbcEmXU1jbtwie?=
 =?us-ascii?Q?B5+eWN/CvT8cyxyc/VMRIL42cJWVeppNqZgKGts7On03dzWKbVEvhMnDp5vZ?=
 =?us-ascii?Q?dAH0A7tSbn6wPiRRTHEByMwp0dxFPwK/N5lGDZPUp1dikDno2Xmt8n7ENjvu?=
 =?us-ascii?Q?jZONuGtXe2MAeJo3WjjTSHBrfE013uD+Tu5nkH0uS/j1S7YEimciyhKSLnl+?=
 =?us-ascii?Q?DoxY5i4Ay1bddSSf9Ha9rAScgm+YauG6v+8ADiqHc7rwRT95TJZLFtkoblay?=
 =?us-ascii?Q?SUGamFokrTuJtD6c+OcO0ruQkvpvjvwfq7co8dlECiYcnN6I+iVKq3qbJe6R?=
 =?us-ascii?Q?p2mTCN7DU7EB6V2hMov9c4GMAiEj+eZSvMh2RwIL9giv/oGIndGzLK+wNL4c?=
 =?us-ascii?Q?M4wRb+Z94qz1qq7hVZ+3WgP2aRD8wOMQvKwPN74HcVae1TtLF2kKSiTUTj3n?=
 =?us-ascii?Q?FPB/q098XN/SEu42zBcSSKYx3w3JEwOpPNu7Zw7tS/saeYxMcC9A8XV43RmI?=
 =?us-ascii?Q?sSdW57BT5siC48Dh71rYLleyBJUrj+48G5voQ4rsmuUjkQu7alF5qDTKSBPu?=
 =?us-ascii?Q?9MU/wOze33qiRHeb87cSvR9gZNq44E5+/xJT5JxPj3xqlL5tFJBP6TB2tCnl?=
 =?us-ascii?Q?j+YJRlB1WHEh1iNUkMSVBS+6jyQ05vYNswkdSOrVhIFsLEm7C0Xx99s6NcnR?=
 =?us-ascii?Q?u8NhHgr0MtvnjINFQBP3tcA+psNSICoVjrbL8sYWJdMmZX8jpmmC32XLe/Ki?=
 =?us-ascii?Q?tJ3FOJXxjivXl99kUvme9o8D1wIH4XnmNKPTEoRDzGSwaVy9XwVbNnhWUDnc?=
 =?us-ascii?Q?U+gFw8okDhtMlxmaCHN13Vo8SVqxOxA7dRLbesaSlThKGXeZamefkUL/60d9?=
 =?us-ascii?Q?OCCTaQPX+yeKD2ogVWD7VjaSgcmf04msraEda0mw5sK7BqcQ1gECR7iO/xXF?=
 =?us-ascii?Q?aRaSC7MBo+iFZvRtz1Tj1PusGRWqHntWJk0jXMle/lqp9zwgeXsN1vVfeVa7?=
 =?us-ascii?Q?diMBMffFehZRkoxJfLc3d5ZaK+k+GRBdhkEftb+8cC0+HBhnkNYr5piUqVAU?=
 =?us-ascii?Q?52LwnMCw5MJjfa6fl02uWT5sqaX5iuuuK5W0p51pJDJg3ETyF+JiQMenWLx0?=
 =?us-ascii?Q?ba29uxlek5m9JNbl7HQE7NFDiGAu8vwZYY2GnTdX5u+wPUTP5lZ7WB6PLU79?=
 =?us-ascii?Q?sUQ3UKC+vfmNK3IJ9QQzexQKD6lzmi+HqrJwjob0ePuWJsB1ubTbo8ghOojt?=
 =?us-ascii?Q?8J+lK5wqCASXRH94ozQMoMlwlr1/InkWxC5bSB2ofPlzw+WLGzL18QycdUEG?=
 =?us-ascii?Q?eirXxx4FAPKWcHz+//h3tHhPVSCcpgcVoaK912aOtxAOzM7A/IVqcvnmUQkE?=
 =?us-ascii?Q?8CVU0EQng1p7fMaVvYpTh8PPI/beMqdmOGgrDMyHtYiPAnp3jfUoCNyEiVpN?=
 =?us-ascii?Q?+IaeS3axbCk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qCeRYzo/oIGJGPih7YNBsvimemTIZUO8iFd9CwNFdJi5SQwKMf4EENEENTLl?=
 =?us-ascii?Q?AHASSdVAksG3TKEIMHYR84Nbo6sE1ra1YRaVR+6tF2TBe8CgEuHnVtZjnFL1?=
 =?us-ascii?Q?Prlr+IIHoyamGT7oKzems0l4jxMw1RM5EfMVFYuq8Avy8zexeYwOOe6tQZ4R?=
 =?us-ascii?Q?PCo55gHR2UUgKomJCeezHc+zXqQyaQ/fgDXrC41QEeMBa/PJesvLwyQn4eTN?=
 =?us-ascii?Q?9kjISQlR2ViLofcN474+Loi08OCn97DnrNOPcmCokd5OLdFJH/7UF0ZJUcJL?=
 =?us-ascii?Q?H57vM/9z6ENqaytxzkHJcweAvjKoJf25IjAAVNkmn5OD9qpOElTPpZwNIlMj?=
 =?us-ascii?Q?4HMb0RYDrsMfIL4X4R2z/ZwYf6pPGUsLFqzYFU2UOxOjVhuGuITIHIrPQNcm?=
 =?us-ascii?Q?yNST1c4DAp2/FkaoqjP6jXQC5sjTnA9kTVJOJZWtuJdltU/oqWzN1BV9Wl1H?=
 =?us-ascii?Q?F+5HrY6cgYurFKK+y5Wz+3Tr9yOvrP/CaLzD7oGM1zOjvXnhbsTgnD9moIOm?=
 =?us-ascii?Q?E9RVdvvZoe16EWhs5F0OJ9md+BDkgnYAF7KT5g03rW9lqS+ivD1HPSJOAn9w?=
 =?us-ascii?Q?t0GDVTO9EZnpT2QMGiMsy2gI0uFbYfouzJu/fN+5uxt3ruCi+fH4befcIHeR?=
 =?us-ascii?Q?EhqLOU6MZ20QUQXzLVnVQAhCg8dcl70bbKoyxK4lKG5QoEzHkXtdadND/sMF?=
 =?us-ascii?Q?aaAKd10J1b35cXbEndrFnCXwegvUyGzl1sPPR9JfVFDdLKobFI88HVVGb0Nz?=
 =?us-ascii?Q?z4pmdJGdBX039/dx21+W3wIjpXU5rmvPNdOyxgj7XsTT989YugxnpIUl2bRW?=
 =?us-ascii?Q?tFyKWR7PJ5EweO5hRjFl3T12f6CxPdW5lfpT4IkJ/KTup8XzttH2Gvqc6gRC?=
 =?us-ascii?Q?nXl2Y6jW1xoQ7SN+AtnrvwscfrOjcMXQzyCaV/oYsc11Ct2IRiMV3+lfEddP?=
 =?us-ascii?Q?kgX6i/U32No6JNzLxqXxtcvFsn4CluKQ+oBV2fvHIbdpVHCfN4pWL2AHX293?=
 =?us-ascii?Q?BuWyWnCq8UIy3SdasgG5RJKIyn2dh9yM3uyy1w/cRrtv6s5DfNLUd54BnTbA?=
 =?us-ascii?Q?p3/fbdQD65PM38Pq+NBJ43VXjQoI3Bf+Zn+1RdK245bUf49vy2pSqpuPwVdT?=
 =?us-ascii?Q?a4Sza1w/3qjFnAvhJsWdfiRxVbhrsF+0cRmye2ZgKyfAP/pQqN2i+KD+HhTU?=
 =?us-ascii?Q?+Du47jZYWFdEapS1e6h4Pu+bUvKotXRQ6HhecauB6IXtx5PxscVwzf6TlDw8?=
 =?us-ascii?Q?TWXPbOsGmnuyiHoa/NhHhUI8qR2biFe9wtsJtWMCb/VLiFvap7+Ai8iD/xqk?=
 =?us-ascii?Q?PHIk1qbCRu3vc5JkL/i/AnLn/3zirCZdJHKfT+SPwr2RXrsT4wg6HkjAs4el?=
 =?us-ascii?Q?QVr7yHAAARuEd6g86vxS0t0gTayJLxa8fGX6zjPeAaQAeV5rdEYVnXnN+RQK?=
 =?us-ascii?Q?tDP/eApO5NRxhuzPGi2QztuOV+9JtoidKBvjNdl3SObqhUV/nhM37zWFyj3C?=
 =?us-ascii?Q?69lvUKWIVuhGEn3/aEouFsrhXDFxvEW2wM4MNdzYh0GCuFJQKZRTnIA5CpQw?=
 =?us-ascii?Q?t+/wq0ra5aJMQXZi9sQs1XhSXnmen4itsBtVqlMY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s76ZPskdAC224iIldB8SaI0yZEgaGd/mHoRXZZBcDcS39FJty8sklIVJ2sa7vI3Y03KLysjjEQ6xgU2gdJWYrmcliBO30iRVAyKwgGkKFqzHspcw1XJzaHsKWcXn2dBniQuG5Qj2o+S5onXndZkrtpaflK/tjCdRRmD86y6XzG3e0XlrVYBR/8ljM6PuhX1QuIG13+drbXtdk+mO2jEVhd/UETnodg5ViQ/h8p131Ou4TVScUoZ7kFr9BSmy0O0/5kqNzsRj7kEc0pxxX67/P4lCWYWAhx06PDd1Uyqck7U6ZenemKGh8sOy7sIN2j9yUrnXtL/CA4bCct56ElcuPsiEKxKTv0KA9nHiJD2VHH+80FsCoO9i92xiBn7Ei1wCEKV58HB8gdlx8GEP6pJunfRrsnFcDZobXUn8pQ1XfRUn3Fyw/oVPKcTW1/wfTjX0/coEMnSCnsrb+zwv72LN1iC/mSmzrkXVPxxfdX5J3OX/JPQM2p1I8IGK17JQrfvI4dQzAKBgjLJbHwoovqdQlU2zcQiYLAmF1k9rwSticoefTu3MTWpzpYJq2PtKGUejQ2TturllgJhrZjOWZpIKHAsoqzyroe2w/vgFU7BhM1I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce2779b-04ba-487c-0938-08ddbf9b921a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 10:21:45.0618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMGedGPdwFuSmYbV/YH1U853fxECLRHueyf1a1x04uw/uZM0u0KaVW54U5+ylWGXp22zTTmivCtzeHzVsC50eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100088
X-Proofpoint-GUID: EPZEBQfQORECp7o9gYCphb5RV6ebuqSC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA4OCBTYWx0ZWRfX3+OxS0N3X61k gDQ4479hBIcccdNYughdVIep3GHsw3evz+nuN843iI9DrmjfdTQoxMYemVf0y6yEMQdm3e+YD/i lyk3WF2lOaujDGaghwpG9BfOZrJEcBuKB32tywqUmYOw4z2NvFbumgeYicPI93yLEadF5r1AXmf
 crwIEhjEhHgf+uyTf4WzfO/c9KzkwF5upPBOEnPvi+9BBJj8K2ay/5opWVlPXA+pCJF6OtQYdXF vqSqQz1X5BZFC1ZKTaTW2GKbRJGaMWScJP4TDr4yH79SWUs4kQlfN5JcB8e2qoWp9LhdIkANIcY zoxDHR0ZPl9TnfT/luLmm++8qjkdLAjLZapinnu1iztyl1BOD7MwZ9N0P/ouv/yxIaoUJ83Ozkg
 6HhdM5iGROBZQc25lbvBtanNrlqARz+6zPFKF6EDy9baQoNZjz4Q/a/hd75uqjQEtyWOHzY9
X-Authority-Analysis: v=2.4 cv=SrmQ6OO0 c=1 sm=1 tr=0 ts=686f943e cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=wO4Sz9BzVJhQODiX1xoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: EPZEBQfQORECp7o9gYCphb5RV6ebuqSC

On Thu, Jul 10, 2025 at 11:36:02AM +0200, Vlastimil Babka wrote:
> On 7/9/25 03:53, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> > 
> > kmalloc_nolock() relies on ability of local_lock to detect the situation
> > when it's locked.
> > In !PREEMPT_RT local_lock_is_locked() is true only when NMI happened in
> > irq saved region that protects _that specific_ per-cpu kmem_cache_cpu.
> > In that case retry the operation in a different kmalloc bucket.
> > The second attempt will likely succeed, since this cpu locked
> > different kmem_cache_cpu.
> > 
> > Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
> > per-cpu rt_spin_lock is locked by current task. In this case re-entrance
> > into the same kmalloc bucket is unsafe, and kmalloc_nolock() tries
> > a different bucket that is most likely is not locked by the current
> > task. Though it may be locked by a different task it's safe to
> > rt_spin_lock() on it.
> > 
> > Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
> > immediately if called from hard irq or NMI in PREEMPT_RT.
> > 
> > kfree_nolock() defers freeing to irq_work when local_lock_is_locked()
> > and in_nmi() or in PREEMPT_RT.
> > 
> > SLUB_TINY config doesn't use local_lock_is_locked() and relies on
> > spin_trylock_irqsave(&n->list_lock) to allocate while kfree_nolock()
> > always defers to irq_work.
> > 
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > @@ -3911,6 +3953,12 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> >  		void *flush_freelist = c->freelist;
> >  		struct slab *flush_slab = c->slab;
> >  
> > +		if (unlikely(!allow_spin))
> > +			/*
> > +			 * Reentrant slub cannot take locks
> > +			 * necessary for deactivate_slab()
> > +			 */
> > +			return NULL;
> 
> Hm but this is leaking the slab we allocated and have in the "slab"
> variable, we need to free it back in that case.

But it might be a partial slab taken from the list?
Then we need to trylock n->list_lock and if that fails, oh...

> >  		c->slab = NULL;
> >  		c->freelist = NULL;
> >  		c->tid = next_tid(c->tid);

-- 
Cheers,
Harry / Hyeonggon

