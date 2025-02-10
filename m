Return-Path: <bpf+bounces-51042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834BEA2F868
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 20:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AABAA7A25A2
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 19:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9A419DF8D;
	Mon, 10 Feb 2025 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C9FWTsla";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qDac+hcF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554E825E468;
	Mon, 10 Feb 2025 19:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215008; cv=fail; b=POV01VgeyjUaI1k1oLnXQn3gT2ScqAWtZP7ypD+7ebhWddWtw1mTP/hTV+fjJa5/723Jjb7Xk0EWJuFcmGP9zrf0ROAz0CDRjEkPAoCi7LwyNI6GggqahF/GQ7sitIOTwL3HZZbvMxIIP+BbihqZozTR9Buy+Uib7r1cAsI/rqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215008; c=relaxed/simple;
	bh=w93APXfzjJo21be1QTyBDQl2mes3LZvt9chcjUWYhZI=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=VyX2AxUWiosi7lAa6fPItRLuO6FDVkkOfBgtBwRhybx1METUXWM1bCZ5t6RZW2ePPRTXmbhclC7iW49fwa5uTj9WKgfDXbskAyIF34InmE70Hzyaw9RSMDlowsT+jvnNPnfA089SeRwiPeAEBc0diSr6zYC6HOn3Ml22vdYL3ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C9FWTsla; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qDac+hcF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AHMWox031930;
	Mon, 10 Feb 2025 19:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=02NwbrV5TuiFUi09yA
	qlqCT/IIaJiiuf7J6gjxrVWAo=; b=C9FWTslaP5fXdua2tCxIWZCkzdA8pnzWeT
	zwck2HdZC1YiAPxc8qeDtAwPRPM8WW6HqFK4gxARIwO+N8LHTdc9tqW+juoGWS+I
	ppzG3EavjH/UVLzvfkVM2UXcNttLOT6TBg+3u0l2Cc3fOW7ebneU01EZ8uenGS2Y
	fmalVJUgF3sGOnvD72EFDbrVFa5FENiOS1n2paJDdZ4kGfTUA/5Pr7Xsb3HVvZUf
	6FIEmjK9xWriR64ILipEAp+JeAb7V+fXjbcKmx+zlQyPm9yEo9bwq0/MF0q+VWI8
	7gzvptJJUp82k2+JxnfzWHSzllG4pKM9En2NCQPCyIEESrj+0tCw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tn3qck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 19:16:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51AJ2C03026980;
	Mon, 10 Feb 2025 19:16:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwq7tpm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 19:16:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNZg3SdJVYhYbRJ0Djfe4g5TQmlRGGEssiIa+CjikWUmlsqvQHDe3VHTV6xgRC/EYzxV85Mr2h2RBzuKQbOz0L0DGKwAOMiWPe2jj/WIByl4PDqfIMOP3Q8hoxBBYDnNG9ygbtI6mut3kxz/iSv/1fOP9JvYbx/OeAJo1R38G/vpPZE7HcVYKYGoNhf0MvIaXaCi0aYPcHsPUv3bgUQqqTLxMH/2nPcvt++ZD0t0bArywUvGu63OGkhGCjNMnwwg+z7OOxOj7lNpc64c4jhf/wN8vf2yPADTzyskgbgPPYAD500SgjQd1tSq8Ha9sBqdTMzLVlqgYp0NGR1Y4kjWtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02NwbrV5TuiFUi09yAqlqCT/IIaJiiuf7J6gjxrVWAo=;
 b=oE17MXY/SkncgUO7ChZcJMmogp17gWghM3ALu5uSvQ9yIwKx+MHWdM9S81Q/TFBkjeJ3/609HjDK9fGJ6ci2bLO0d2HDiEsK/0LsoRsROI+MHWk3OK83gq0rzN7Wan3z3XLQvjZUFwmsIitHoeV3FdbUN2Eyc+uqbM+N9S3SjR4lSdIB18w63/nPr4OkSUHlxnYoQqnCgwEHk8CpQC2KxoaoIj1AkrYJBmqa0gbwQ7wtjdM5WSm+4oDupQxpZwc7IyRmwHLPU+GWK7f6yxlVkCRCsQghFguZMnXTc1aCWY7nBwCHbUSk38amRNiMRVjmKHlVedYPKNx950h6mOW+XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02NwbrV5TuiFUi09yAqlqCT/IIaJiiuf7J6gjxrVWAo=;
 b=qDac+hcF7sk+DQzmbKgXKZUoGYSOY8Hj9taxuOkEdnRiHM4FqYR+bRpVUKJIOki77h3hBDZUyx+T1FQ+dheqhvU4f6WjYBxeE3VKGzMaur1qsEjFqqx5Pt/J9UVQNr+ArkRVqP3fYxs0QsAZHb+Dctzg4O5iwatsIeiWLhrq7L4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA1PR10MB7588.namprd10.prod.outlook.com (2603:10b6:806:376::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Mon, 10 Feb
 2025 19:16:11 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%6]) with mapi id 15.20.8422.010; Mon, 10 Feb 2025
 19:16:11 +0000
References: <20250206105435.2159977-1-memxor@gmail.com>
 <20250210094918.GF10324@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds
 <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Waiman
 Long <llong@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Eduard Zingerman
 <eddyz87@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo
 <tj@kernel.org>,
        Barret Rhoden <brho@google.com>, Josh Don
 <joshdon@google.com>,
        Dohyun Kim <dohyunkim@google.com>,
        linux-arm-kernel@lists.infradead.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 00/26] Resilient Queued Spin Lock
In-reply-to: <20250210094918.GF10324@noisy.programming.kicks-ass.net>
Date: Mon, 10 Feb 2025 11:16:10 -0800
Message-ID: <87pljp391h.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0168.namprd04.prod.outlook.com
 (2603:10b6:303:85::23) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA1PR10MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 6747eb80-fa78-44f9-1222-08dd4a076139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hzxxWp7GAjyWCiWuEI5IghfyAYg5gXjk5p9ujWT/HAOnGuAq/OIQ1cvDDwI6?=
 =?us-ascii?Q?e7aL/IVBkvQ+6LLYhW47jJhDmPOVGZpPI9LVxYpr7Xfb2/PP8ZC4PuN0S4qA?=
 =?us-ascii?Q?eBVxVv6zYI7b4lV+K33d6hgY5WQq8mDwh5ZZfVjVUd5FEj4c2elxTm23TxEW?=
 =?us-ascii?Q?PvB5NDSgvhLhMtEGsIHirxuD74CaKip5iaTYQzx5F9CKJ0MT5OeVyJ3TtMO7?=
 =?us-ascii?Q?gE4SUrztTuopHP65DjFVI2ysMK1E9pZ0KoM4yQmBT1jCHhleEy1oQe6IwNvq?=
 =?us-ascii?Q?MmouI7r85gf6YeF1mPX7rNryK/qaiRBCCbgQltg9MSuou7+IWnnCY8nvByqa?=
 =?us-ascii?Q?IB94S/IWK+2Y46GxTbA+ew4KZcc5rlq0NGT5J+SUCOGggrXITlwJuwpNYsMV?=
 =?us-ascii?Q?R6QjZE6hofnRt6ezXenqeSPa6LAvrvmGhbkZZts3JJnqfcUdxk6uT7Isrv+4?=
 =?us-ascii?Q?vnw+kYWhdydWz3fswzfsjBE7/cTOWJiNIIctMJsApnnYXq3tq9ekFkN5vAzl?=
 =?us-ascii?Q?u1dJRpLVXg7iu+qUc7XUBCAEXXLml8wBSmZ+WNSQ82O9h7OeKjmlBzMCy9ug?=
 =?us-ascii?Q?G3RwxU9QZmsjyZJARVlxlF/Zm/E99HdAOik+bQaJ+8pTEpNkqMZj8K1q2SKY?=
 =?us-ascii?Q?fo9xL8gL1HLb5RIDGC58A2OyktRNEJUaR70vjy2L1GwT+GZrW0cKZjFMGquc?=
 =?us-ascii?Q?ejJhpOPHYICcJBdUy9NTXS83tbsta7Trs11anLGtq24HmfW1Tvv7gn+/e7wh?=
 =?us-ascii?Q?0gBDX0oM75Fe+jir3PrkCJ4H3oLV8mJNGft2uq0XjS7KDpl/qiSo130CYnHo?=
 =?us-ascii?Q?Br26mEGX7unvvESwOWjkaet2sASHqW+nPVNiqMQOkzR2Y4ZJyquYINMW4Qj4?=
 =?us-ascii?Q?32MZT5NbaaWmasmVlG7R5eUoCy3mv4QAtQizN0Wri0NEpcsH9b9CLjxz4UyP?=
 =?us-ascii?Q?gu9f0SPNf5dMMfc1BuGFDsSa6LnXk0EVR78DD3puAzlSnK7NFYu5MwCYnBjf?=
 =?us-ascii?Q?ZXVbL6WVCqHQuTtXIJh6SAoDxr/yWrceBcdHsYuqKT8AswhasNAcyI4LXQOW?=
 =?us-ascii?Q?UCbOBDRf2BzBrLSA+dp9qcBUtTFiPPvAutfkG6c7F0WyIe7Oxf33ZdN7DmOU?=
 =?us-ascii?Q?j0DNtqC6DS9HQmbkQhkxKp2fwlND+48euduwnb6/0CEgbRz+F/8K5ZoBE9gJ?=
 =?us-ascii?Q?LNPikYffHhoKTbiqfJKi/BqUBSdI/77V92ww/7A1iTNkQl4DDghRSVm1PBC9?=
 =?us-ascii?Q?JpSUIhMbhs0Z1rUl0wTXye7CpOlicud8NdVmmGwm0Vf0Ai2lY6gWYmUp6VyF?=
 =?us-ascii?Q?Iki4bc8QPaz6a8Kxshw435Rsw3MV5yOe7mpXHnUS/Ahu6TLandQvUcMs4kBd?=
 =?us-ascii?Q?KibuTxyMuU6xhk9cWbiGkVSksegqGPigKHG/3rDN+9lC+pDj0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gjgv/5hI0RnZxliB8epM5aZ2nfiZ4inwfM9q/+4JNQhXDkW4E7pe8uJkR7SK?=
 =?us-ascii?Q?EWbelDcTxYKeGYMQiOO7/qY40BVaNaKWzGAiKL1glnRZayZAaCGAy3XVReL2?=
 =?us-ascii?Q?MmUEuwFd/6eCmycz0wfx9QTDJ89/zGGIm5Exe+MCR6/aiFWP3SLX81ZBZev+?=
 =?us-ascii?Q?h6qWIQyk156WVzi+ayKR249CBsz+HjI1xNwBan1LAT5eiRWI7X2ElHO2nmPJ?=
 =?us-ascii?Q?5+jngO3NfNtXxA6cTP3+P/ufKEqyOfn+8z67SZ3uHNz9hCnYuG9IaEfJIMuy?=
 =?us-ascii?Q?cPnm7fpoBSeI6TZFvqH/L/HGlK3ShLyaetR23otGYxaYObR6SM0S2RuJVlYu?=
 =?us-ascii?Q?WcffINbwag1X4HIr5j9CUQazYESMbw1OGdVxYf7IuGWKgfLrOsbVh+LuSMBA?=
 =?us-ascii?Q?QcFabxe0Ueef5+wEJwoC3169ZTMcdrCsJmi+kRePOEcIUzcntjbWdzOZ2QEl?=
 =?us-ascii?Q?s3wIBlLt1LDuRQVR59V7ANTBLEpb1YeXStSCMysPmbDJYrgWRDcRn/XhzNP8?=
 =?us-ascii?Q?yNu4oZX7nX2DSCoLaDen6vzXwExtiJHUfAH7E1QgT+UGPmOrbkrYQYu9wwe+?=
 =?us-ascii?Q?vLNLk6mONJaeQVfZog90YEgRgDGETaAB59nlktxgZEniXBTQH3vEyzAdcCBJ?=
 =?us-ascii?Q?TKSRrpHQ/XD0UGeaPQSgZi178O2CMzNTsPwnN6kWeqqtXWzGw8Yh27JeBr4o?=
 =?us-ascii?Q?H9Iww6iPPUwIgIGbmlF3ZZ/ldIPp54nD7LQ35UzwFRJ7g1PHNQCK75G4OvZK?=
 =?us-ascii?Q?6ZLgFUlKJrqglUagZVCJDxe5xQod1voJe1osMiA4wR0uYlKsDo+0/ctswvYF?=
 =?us-ascii?Q?XRxAivLgCybkU+zvM5JH5pop/RBV630f6IoPPMusRwSL2+f5/yKd6CzRbmhm?=
 =?us-ascii?Q?Widv8vYzO0qXxZ0rkW07f7SNPKcANxZ2ACvs0RTwnJ99c2swA2in1HHg0gll?=
 =?us-ascii?Q?XbfZwg9cyJKKcGetRXtD3VQQUSpjPmjAiTWvK3id2OgZ5V48AVay6bjuvVBi?=
 =?us-ascii?Q?AOXmo7IclR+JfOYiJNGm+OtSwVNmuL0t0dom+/hYEbKvJk1xSd5MvwEDc0O8?=
 =?us-ascii?Q?QHtVIxDcWzEP9T8Zmk6kgVJWeBUOtocsZ/Zrs5V9lvO35Fv8SH7LCKGYipea?=
 =?us-ascii?Q?GnwHhFc/n5sKkTecUmkUezfguX/h1bDR39/fWOn7YE1U4QST1VpaDGogEoID?=
 =?us-ascii?Q?P3J2GG9BUHaXg/Qjms2cX1V4VJVBreTGQjWeXEfW193gOIRQBJLmr0WiJIff?=
 =?us-ascii?Q?pOrTYwUMjc0jHTs35uljCm7q/gGAoWe7R8tAO7zybdw0lmXLnCIV13qCWow8?=
 =?us-ascii?Q?q6n0Z4ksEOD0O4Wwbz+PB3CHJoEz9jYW/SYZ5FsL4fYwMg5Y5ixnAUAY7wxp?=
 =?us-ascii?Q?YkOQmYGxYnV0Ko2Wr3RIrr2EA1FZg6lth+gexE+zNWQse27GQunqi+4nWf1x?=
 =?us-ascii?Q?tAkjWTqfLktiftyuToFTcqykTjrK++Vig3k0oA1plq3AjukR+Vtz3PvCTwq7?=
 =?us-ascii?Q?YmVtIrVEVwXCDUNHQlS41zXj3daNUy/8BXO5t40nvGPA0U7Y/D5mJNcmAga5?=
 =?us-ascii?Q?HTm1siuHJl79+7L2r9O6NhNf6wx4Sax/EMZ1f7ERsuc5HWo9ZfpHVvJ5kKBd?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LXFTlljncWd8ms80tVuj99tA200iR2Scx+Ib66R2XykqI7BpiYjFk9x+EW5V957IfFWbrxnB48l06JiqoQwxiE47tNhFJOMKArswLZmwhruhGvqjfa68oBD5i0V+0m/nDW/v4xPNTpQ0bJ/FmVz8ihKVtmYVKCzc7skM3tYMMzYJxbUsjAj2Pj0XKbjpu1Q5MUceOdRSxPVXgr5N23APsIq92Tw432cs45RJsJKtb0Rm88PFvIh7uO3g7FUydbjhkTYkkPjZKp1b1mjQYaz5cjaGyO07JBGjOAsx/EkV1ZCu2hWa8F/Ec9WK5rZOuX/lM5Fg2OyqcHmRDWyqBeZ22ZGb+38fz/r60CFxXS4etZAQcIn49YQXdvOKrPPMCeYE8LZfpEtoFQOlKCNbGP3BWc5syG17iVoSKcKTTHxFeudLi+N3SaWXSQEBgEwu6LRRTXkRJQYxmS93O9AaoXzk3ys7Ls0kBOZdBqCuj/vw9k1IDg+OrnsDaMI90Nlsws66CqZ3P3vs4/daBVjETIpxcIOkCkQW2PKwbhcpLbJdIetnwFx9vNFxo9AXsSct/anBqUL+1yrYvuRiSimYtY9OX7YNexxPGoDIM3aWN7/VOP4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6747eb80-fa78-44f9-1222-08dd4a076139
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 19:16:11.4072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOo5yVrI1JplbnpWAav4PEGgEvylMG8hox1TZmgYbYd7zu/+DtyQSaNJBHwrzhRCe0vlUlhX8pEW5M5mYC+Wn5awAhl+lB00FVwSDAsrTjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_10,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502100155
X-Proofpoint-GUID: HjuqSUf-fhGpNNATvrR08MdbyS8kT99J
X-Proofpoint-ORIG-GUID: HjuqSUf-fhGpNNATvrR08MdbyS8kT99J


Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, Feb 06, 2025 at 02:54:08AM -0800, Kumar Kartikeya Dwivedi wrote:
>> Changelog:
>> ----------
>> v1 -> v2
>> v1: https://lore.kernel.org/bpf/20250107140004.2732830-1-memxor@gmail.com
>>
>>  * Address nits from Waiman and Peter
>>  * Fix arm64 WFE bug pointed out by Peter.
>
> What's the state of that smp_cond_relaxed_timeout() patch-set?

Just waiting for review comments: https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/

--
ankur

