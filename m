Return-Path: <bpf+bounces-69497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BF1B97EA3
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 02:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755C94C16FC
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 00:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039B419F421;
	Wed, 24 Sep 2025 00:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CWRUQWDn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rX1K4XxG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BDCC2E0
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 00:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674492; cv=fail; b=oTTFuYH0VObuKd3hC5m6b7tnpsHrYyNiuvXmWuCNRMtAV8BP+74RFSLkLi/6OT82cF+D27mEOlTLzFG06xC2Gz0wmS4h33xKwa/wJQNNFyY7hnRo7I2YFlYRHviRVJTNpr317DFc6TDefONmfAlGLNSgKZjgszPP3yZWu5ecYr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674492; c=relaxed/simple;
	bh=tgBoypGd2oTPQ7HCrKf8e4BL3sWgh5OKPZYVEZ0hcGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PqUowPZZK1Q65h5nvRkN91eVQpg+jzkgZf7PT8yxVcGWhJk9kQudGVQE6qURC3IMujnn3zA0ZL/A6sctAK/NZ1IaHyNUjb9ZfsPUfzR1lTEs5RwqPNiPXlRJAyrDeGxCOegXTltboU4bxCGnhGdeMS4uqLfgL9oyvweIZmVRUig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CWRUQWDn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rX1K4XxG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NLbJ50025564;
	Wed, 24 Sep 2025 00:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=f1ayP4gN/atYVSCArX
	C4+TeIrO4CXWOeLRxY34loMv8=; b=CWRUQWDnehPnvKqY0j4kCAv7VZ7QHeOBdA
	CGBHSGR4pi/FW9kMcE6HpOFw1O9g8oPwaGHWrccaACHRLHJAW0cjeKsrP6//t+sy
	Zwx/t9XJEzJZ5Ie1BA9pB1xHHJBrP+PieAfH8oX7IMrohJ6mvqUAxTdS1Zrf7xf9
	uoNhqaMXUvqHcQo92Z7t0J7s15A26aVsrHQG5PZFWy5ekw01rmhKJBINOaitieBF
	ymoN4owswiRxAGk6Bir/O5OnwYNZBXTeNCwtUEIv44Z65HebPerBhXntRYNGFBpt
	CH9IjxZddCNal5viwyEy4swUsvaXiLKo3onbK1M2jqUnx43LxoVg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jv15x6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 00:41:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58O0PCsZ031265;
	Wed, 24 Sep 2025 00:41:03 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010025.outbound.protection.outlook.com [40.93.198.25])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49a95026wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 00:41:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZxwTi8R5Sud9qiDeHVOQj/h2kfDQ1NW8CokTpKJwp2cRWMb2SEVdy5mmIpPO5jSwmHeEs4iLXlUKav4uYZC2cwE+QOgAv4ThQWSuvrMcGAIq+wU9kpaVZ8+58Q2SFVk2mVCGvLwnlkOkMGs4Giarr5ckqdWDJq9UV1PP7w8J1VxfZ9Gv5t5D0FaIJhVL8uk3lQoRPfDW/Bme7g2FxMB/GuWbe1xzAcEvaxDUJYUCzYfhrISGnXJOd7vMWrw8LqX2cq1XXaUWkJUb4O8GZT2BBanOmtHRMlkCCso21HfbnyuE7XNgDjgy4gKKXRrew6O/Z5OdAMFhh9FQ2ak2UbmOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1ayP4gN/atYVSCArXC4+TeIrO4CXWOeLRxY34loMv8=;
 b=v0KnzdRbur5Bx2zTczv7Dni3uJv8znBwKvZtJi6FoBOWO6BQSdmT8POxZWK0y5RvRGfpfKRw2PYZRRNT5DRvpWcKmrc75M3+kLeMqvfxa9fy3m4phhI4J0Qak4l9DumcVJTEHTxS4GT24iuYMbH9JqEJSndaXVafg6AkPXNu2Qq1fmyl3Fnqwt7rwT39uLcYnKOWg+2uZXXQP7GBb90Mhr5zkmtjVZw5HppKKBU7bz1jBX+Re9FCWnFZUcUjsWV5jHXUWxR1FvnislVSX+nDE4xPoUKhO19sYVKYEMh5FzmAW+9Ku6jyi4iT+Smq9q/Cy75Ml93tqF8imptzQiAJfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1ayP4gN/atYVSCArXC4+TeIrO4CXWOeLRxY34loMv8=;
 b=rX1K4XxGUknp1NJvD6+7IbBddWoOnqdyPxBf1UoueYACaBbjnZz2lIQyDpYDvEczp8OQhbxOP8Nax7uDXmXYJhgLd2SJBxDlpyRUPTSeUoneMDacxgcVy3XNX5LnGO95NHe65/SbiHkYAc6Gp2oqOEu9qwDqFWSpFr0ZknxjbgU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7283.namprd10.prod.outlook.com (2603:10b6:610:12f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 00:41:00 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 00:40:59 +0000
Date: Wed, 24 Sep 2025 09:40:50 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        shakeel.butt@linux.dev, mhocko@suse.com, bigeasy@linutronix.de,
        andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
        peterz@infradead.org, rostedt@goodmis.org, hannes@cmpxchg.org
Subject: Re: [PATCH slab v5 6/6] slab: Introduce kmalloc_nolock() and
 kfree_nolock().
Message-ID: <aNM-Esr0v_95qmEa@hyeyoo>
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909010007.1660-7-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: SEWP216CA0109.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bb::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ba5da3-a0e7-4f2f-3868-08ddfb0307e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/hKDR6mlxcGdIlP0yRRsLKM6Jpnlc4zONSHMEPUDGAmqsG2rfiVlUwBJSj3m?=
 =?us-ascii?Q?/fFMSK+25GTkC6rtjPCl299pZYFg8FQgnvDbhvj7u4smppA4Yygpzv0zlFQa?=
 =?us-ascii?Q?BjiVdTeYBynGyltIwCf/CY6DrmItqpCpW61Jo/3utORtfqbFKO+CbDi+poag?=
 =?us-ascii?Q?4EE/arFjE11+PhvcM6ky+9WseQLk9sUsxsIRVqUuWm7xmyMxdr4BP0UgQWWJ?=
 =?us-ascii?Q?Bs3Q3Ql7GxOYLqUE+za5le4LgtP5xFFOpEErhtzyfWa5akJZVLF03nS/MZjq?=
 =?us-ascii?Q?QUxhRMqL+Gke7hlazXWWueuzIApn5epsy59msQ61QxC11kW+qGlAbnGqtlTL?=
 =?us-ascii?Q?YsxTtHG9XGGE7L3cAAdvEkfQcREcx8t4GvZc4rgYXA/w0GmYVBgTW6y5GwyT?=
 =?us-ascii?Q?bNpvJ97PBkkEgwpkhBK2cj9gpeCR/WLcaV7b5gRyxaaAfj7Xuk/tzjJG9QbS?=
 =?us-ascii?Q?3t9fwKAvg3lGSxTsnbKlECUkMl7JUDmpuXJZqo+tUsHZVLnfkbP/VBOn1dyT?=
 =?us-ascii?Q?LFwm2BkKO7uJgx2wL3M//bkouVYMYL83n0tDXGF5WDx3SU5VPpOKJS/N2gpq?=
 =?us-ascii?Q?YjGc3DAFR2RvuM776NfR9Y1jIM6l/c4mKEvPsFS2LWJh9neLNtGJPDlVXnCa?=
 =?us-ascii?Q?b4Y9qtIDPch7AkW6/hS7HXMch6Su514l2YkXvAn/YmvZ6p7NpEz1kSkIBvUR?=
 =?us-ascii?Q?/rMud5w+KDCMY02R3Vz/eGvq0wtB38FZ73QtXDydbgfwauroyESyRHiQhktY?=
 =?us-ascii?Q?3WvWIW2e4JcH/e3U79rDYmyI2WkvpGqJbHgFbC+EtEUy0I7af20LyGMpDz2D?=
 =?us-ascii?Q?WJbS43menIeqzysIkVf+iH5gay04eb0ACIsi86PdlmnoItc5lD1FIeONnevU?=
 =?us-ascii?Q?KBtn3+ZHNDUcFu4X+t5xkJ9PYn93viup/n1DoXRCo4fmCvsCb/gR7L0e4vbJ?=
 =?us-ascii?Q?qq5QYsCPJovjr1YritqlY5nxctE/wBhffcsI6XutLyr0pYgfIIT3ZoMjqT+D?=
 =?us-ascii?Q?4+KxDD0y2MmT6lu8xN8jmugYJuhtEBwQP05MY78VsNRXkwNmI7Kj56sCXHwk?=
 =?us-ascii?Q?e0B33Wf8cLnhK/cOyMQfKW15o3sQbis1P0R122jZF+CyvG3z9gMM7tVRAQ8A?=
 =?us-ascii?Q?FrQm1++XRBUQqyp74Fb/AkmX+LD5l+HNH/vq6h++2DOEJuaWTa3P3w/hQpfo?=
 =?us-ascii?Q?1voxUk2lAhMpjBK8tRxUbJeskO6QsNItzzkV9a15H6qlfi9sLae7CgOtvuI5?=
 =?us-ascii?Q?ywBgGWUPRJ2KM+4uYUIGMtZ/NzIGhCrZXb6atog+lrU3jeYPacjVNzSEPXN2?=
 =?us-ascii?Q?2IQECQoXgjQYzJifzIP9faNeP66TOaNWlmuEAFC1zjyzJR3HvB+tAjSPf1HK?=
 =?us-ascii?Q?OFGWlsLSP1sTdv9jIs8U3Hz3HWSUvM/Eztb3YOygh4HbX1nYILMRAG/50mCx?=
 =?us-ascii?Q?bEuzxgiNBUw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lb8rS9FYAqw+59W1UA4QGaKKc1N4AQGI+UnASqDTqm9B5dGfmu6rtc6NZFhs?=
 =?us-ascii?Q?P8KVJuGxW3aYgradhXDc43Eej8yITcDEDBW/5ZHg3QEknCdOSM1Ggf05yBZ2?=
 =?us-ascii?Q?f3LQay1AHbZ5Roa1+9v2yDFmzp67KjXR5MNpQXAZCki0Ak8hhW0y6FLiqsZP?=
 =?us-ascii?Q?ARVl9cDtSGbAcq79Z+QwS2r4zyg3MM4tqcBRsuM53DXa7/hhJhh4sU8n+4bC?=
 =?us-ascii?Q?Ngquf5ss5mxYeCuNJJ9jc4Xw9FATrRAdE+bIWXYF73zBuQkd/jWzL3VBSMd0?=
 =?us-ascii?Q?lWfliim8dbbXICdvFQxGd1qCuAQ79A/lri9slkUWrT2c+AzAXOmGFwVsbcgZ?=
 =?us-ascii?Q?I7xzfuG33mTJxPTi5sn2HxJXgu+XIEp/XAZGTk6kC6a9j5zT0tFepPByfh7H?=
 =?us-ascii?Q?WD27T5hAkayNA9NkWbNjy2M1M/LzAoxiWG5ZnOGdAyyvxtnzUn+ARsDTvBvY?=
 =?us-ascii?Q?G5RNCIbixOqHQSCBopGNjKG2vMRbF27G37uJzN/Ttj2ttlLGTAQzfcPhl0/x?=
 =?us-ascii?Q?DdIod/3gpbjKkc93z3WcHzYKX86XAQPt3JK4V8VuvoU7UVooYSA7liRtCKOP?=
 =?us-ascii?Q?D1zJwA/xTZ2lCxIu6HWM56T5eT3Pmxg9RuBFQjsBbnQ2V2IgrTgQSFSaXeim?=
 =?us-ascii?Q?V2h2GgyIQINMxa3pKKhKLCpPA91Juh283uYSbfbObp3nkEx/u4Css+xwh+jS?=
 =?us-ascii?Q?86oaLkNtm2mNZ/daUR/d+ebrBCgI/LKDI0mTcFwYa7bc3pXujycWxVS4umve?=
 =?us-ascii?Q?vjc/x3Mc2Fz8ZYXZKPc3CC4YRf9/oI/fzTlYvENIuSO1/opR1R3gIu9z9/Gp?=
 =?us-ascii?Q?icKU7E+UG8Okj8ZljmU4Ed9fRyCiPtd0HCK3rN2iYPzGz7GWD8gBU8AA64Ax?=
 =?us-ascii?Q?uPFh7LyufgM0XLI5ezNJRbcfY0pSOLydxeMgrWpdnzUOJ1Q+1gcinUNv8p7A?=
 =?us-ascii?Q?1fBR9X7J8yhvLixuA0WEPYGXbblH5N2sB83xzYZYnNP+CiJE89jburvvixSK?=
 =?us-ascii?Q?klCxYIzSEvO09LkByaJYFkli9DI7cnXiHzdgE4a6X7ccqqUjprCilgHu3ncs?=
 =?us-ascii?Q?4ECEuEnN9srzZ77juT/Dhq5gZikie/LhpqcpSbBVBkphfFZi7FYZ6W0F5cMK?=
 =?us-ascii?Q?/cgCnV2ppzYEuqxXNvfN+0Krdx7gWRH7fLBceZouQcScR4L2vfUfj4p4OwrY?=
 =?us-ascii?Q?yOmSAICwe+urxHGEK/5dZavsv+a6xzmK0nbstdVfk5+pS+lYBU7Dkj9gkFEs?=
 =?us-ascii?Q?EvN0XRyY4RhMml43vQDtPwXfyBbLmM0yB9HGxIkSs/AbWk28q2eY8lMyKD2P?=
 =?us-ascii?Q?KcTJRkwMT5/ZL/MPr7HQfSmUMz5v89nw0X65bHPW835J1tbgXqwqWQSRvljj?=
 =?us-ascii?Q?PoQGTM4pzuan1Wpa8ZeAmRWcM7P8mjNQbgZkQ6PBaWhohQV6zTgb6tIC7TxN?=
 =?us-ascii?Q?66bxWDQAIhlrFbvkNFgOIj9hD+gjg6Hux/PilatG99YPfLPIPNYL7pNL5wC5?=
 =?us-ascii?Q?cRTxHgr8y0GNMSb6jGfAQr/by4DEje8rWb/JtY7/4vApG1atUNIdkvAV3ay/?=
 =?us-ascii?Q?LGtUdVug8gNLkDSzlcm6Rp6tAcTDL5dpgn3ziX7s?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6BQn1edp0MZfAEjYWOPeW9l0YporsscmuUM+NcJ5t84rjPZsJirzxfXD/3AXNtYkF7UVlW7Szb7pb3vvHctqOEgmmEiF/qxs1SYYzs9a5NAWZzcKi+alClbsOlqdiclIX58heGqM4DW6omlwi+MA+gNwOH2ov4hdlJyQEZyImf27JbsQhb1WGNiQuydQBgosf+6SoXzye9EfuSiKBIr1a1JQhiC7iOp/UPsjp+Wr26LAGfIMFVKra3wmyvMZ1pqnVgLjx9qMeX932nbmFli2hrdoGIGU7ktGMXkOAar7pS6RV8qg5eGNdegFF9Y0aUIJYcyqvY8H782JypGYxB2iql3wGU4uugJf+28dod01UvBvLR3LEVLXFpJ6nsC9QIbRKKOff0+mhFXZ1QzU933en6f7IAXXkkM6b42Pf/nGYJumMzCPFmiYAVlHltKSej8JLNKUy9NBoulT0pIMvCRmX/UIMBDZCAcud7m1BrKbhD39tD4qUfZGtqwC/uDK7o6iYL/XGs62CwyaE8eZP6cEUcsCYgrIzSyygQkDG1//5OshMS2+DhahG4yxf5ikecoDAIMWfEArs7IXw/iYWOZQweN5hgUiEd56H9jc2S44MzA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ba5da3-a0e7-4f2f-3868-08ddfb0307e5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 00:40:59.6475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AnEn7UI6iid8ePPfCQWuw9Z61kl4RD/QhvAXd/3dVei6fCxYPLd0OO2wuiAsmxca3L/b0awoAQRSODf0vDh6Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7283
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_07,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509240002
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMyBTYWx0ZWRfX6jUUsRdk7X8b
 tNchHxH2hmPIm96xLYeJIpFm9kGRYPfHa00wMhENRmaDs7WGxSRBCSA6kjHUdNwamoyryhS3heD
 Xod4rm0GAQILVcy8pN3VGSbJU4a/2Wj8yqIj+xSNe+DOprTrf5TltJHIpO3JWocPJX7GMxcX3Kt
 B7VRfMPPoYMRE6GMUOnviaa7Yuru02tAmBHSsCLL2YUJDaIGrpmdJN1Fk3GrRHfPu8igL5MR50t
 8IFBZAgIPJccI2+ecy0ja8XB4lzN9NnHDSojKPtpY3ZGwvBmaEiDgAHaRtzPxH6qv0Q8ud7bbXI
 NsWM+IFfpiRM+Y5t9+GKhGP9aMqH1ygIO6OTKGDsZhuWB+yfQGVQYzMMnU0XT1xL4UUVboVxodB
 UB1UW3Yuf/NWsaYhWVjjhuyYM0/Pcw==
X-Proofpoint-GUID: IossevwGn4xerumCJdXKJ-lNdg1YxMcc
X-Authority-Analysis: v=2.4 cv=YrMPR5YX c=1 sm=1 tr=0 ts=68d33e21 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=NOuP8FVHbp74LnvuggkA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12086
X-Proofpoint-ORIG-GUID: IossevwGn4xerumCJdXKJ-lNdg1YxMcc

On Mon, Sep 08, 2025 at 06:00:07PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> kmalloc_nolock() relies on ability of local_trylock_t to detect
> the situation when per-cpu kmem_cache is locked.
> 
> In !PREEMPT_RT local_(try)lock_irqsave(&s->cpu_slab->lock, flags)
> disables IRQs and marks s->cpu_slab->lock as acquired.
> local_lock_is_locked(&s->cpu_slab->lock) returns true when
> slab is in the middle of manipulating per-cpu cache
> of that specific kmem_cache.
> 
> kmalloc_nolock() can be called from any context and can re-enter
> into ___slab_alloc():
>   kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> NMI -> bpf ->
>     kmalloc_nolock() -> ___slab_alloc(cache_B)
> or
>   kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> tracepoint/kprobe -> bpf ->
>     kmalloc_nolock() -> ___slab_alloc(cache_B)
> 
> Hence the caller of ___slab_alloc() checks if &s->cpu_slab->lock
> can be acquired without a deadlock before invoking the function.
> If that specific per-cpu kmem_cache is busy the kmalloc_nolock()
> retries in a different kmalloc bucket. The second attempt will
> likely succeed, since this cpu locked different kmem_cache.
> 
> Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
> per-cpu rt_spin_lock is locked by current _task_. In this case
> re-entrance into the same kmalloc bucket is unsafe, and
> kmalloc_nolock() tries a different bucket that is most likely is
> not locked by the current task. Though it may be locked by a
> different task it's safe to rt_spin_lock() and sleep on it.
> 
> Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
> immediately if called from hard irq or NMI in PREEMPT_RT.
> 
> kfree_nolock() defers freeing to irq_work when local_lock_is_locked()
> and (in_nmi() or in PREEMPT_RT).
> 
> SLUB_TINY config doesn't use local_lock_is_locked() and relies on
> spin_trylock_irqsave(&n->list_lock) to allocate,
> while kfree_nolock() always defers to irq_work.
> 
> Note, kfree_nolock() must be called _only_ for objects allocated
> with kmalloc_nolock(). Debug checks (like kmemleak and kfence)
> were skipped on allocation, hence obj = kmalloc(); kfree_nolock(obj);
> will miss kmemleak/kfence book keeping and will cause false positives.
> large_kmalloc is not supported by either kmalloc_nolock()
> or kfree_nolock().
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

On the up-to-date version [1] of this patch,
I tried my best to find flaws in the code, but came up empty this time.

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

[1] https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/commit/?h=slab/for-6.18/kmalloc_nolock&id=b374424ce98fc9e03270ca1c4abb3aa82c939b5c

-- 
Cheers,
Harry / Hyeonggon

