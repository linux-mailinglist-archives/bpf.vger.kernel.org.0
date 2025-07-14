Return-Path: <bpf+bounces-63199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97451B040D3
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 16:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42C86163D75
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 13:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457FC25487C;
	Mon, 14 Jul 2025 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QjFd4q1a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j1w1EspS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89451EEE0;
	Mon, 14 Jul 2025 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501572; cv=fail; b=DyadUGhWhUhx800S1HfWTpo7Z/Pxt8v7miYnoTXx9NhXGTTXZSJscrvF/LQ7YJIMh9z5IU3B5zYdgA/o7Ok5DImePMDvyXvSkLpEYB90HA2wD/MWFdfYKjMyRTs6xh1DL5+jaw8ucINQJkvi7PTGKAsryeABeRRqdKTZ7nDE5jE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501572; c=relaxed/simple;
	bh=dLysXv0DIHnZkMFZoq8WyasgU89TQAg/GtiByKtpVZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qznJxyR0xUODVzddVDc8VzRPYSJOsrsgFQb56IgQRcTQ135RloHOpI+4N3+9LxTeRl9vD/nd26N3tLteFvr+6td3M7txykSmAlL5Gvc6mpbFDVKt5gHWqCYxdqmNTncJA1sYQ5K+NYmHDqEkZx83xoB3rtuIZBXJ1X5g41y6Ezs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QjFd4q1a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j1w1EspS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z5Z8031144;
	Mon, 14 Jul 2025 13:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=A38G0MrORo18geTI8/
	cDyHXhDUFuCPbLY/m4zbtwRMw=; b=QjFd4q1attRb4gC4K66qIR6q6tH/iL8VoB
	cSTCpXC3Yjj7rvH75DNGMkmw6R0JZmWJBBAnlbwW8XYLn3B4YwWZH4AQOxP09cYD
	5hQbW6sgUyzHVQta0EtVF46HnWrKZHJcQ9F+w2uXzUPPD4mLl7rxbAOvACmsEjI6
	SJ/9xiUt8z20u3gaX8JMx4ijAvi/i0bqIhw0ieANHvBm3bZXfCz8/Ndu5yG2BQeS
	LZnRlzZAVdX55cq59LtTDMtfNIgHyV0nyUA3TjmjnzUxisX9LtpePL1X18+ZNI8L
	F0bNQ046PTtDkQCy9zARq3l16sR3Ub2X2cAkLMrTeiVOy+jJhvhg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr0v5sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:58:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EBrApE011645;
	Mon, 14 Jul 2025 13:58:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue58jq8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 13:58:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlzbH0bRXjfu1QjEMkxamm1OWoD4racUy/ldUtGJrVH6eTuN5lXTOoRHX4xnv7rsuRvkWVMh9z/MPWvE7vVGjJk0zBN0pJ0bbzMo4vFMuWdKKyPO4o2SG8LlceHWohuDsXuc6LLwENMUTzgPegW+Z89NkJfE/PNYsYpeiZ/GqOsAKW9QiYvEO9K+W3C9spZWQDYp6lyDAy1PIbqZA7QrzBcG3kQGXUz0XEYMebuOZTrHtBP0JafCev5wzB/rXr+N9HimlsHeECrJaG41wiP9iq+xyh7kozjKnX7pGE684jUW/Zk6NC1C6H/Awwu03lyzGHrl3EJNBQ31x2JKn0OD/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A38G0MrORo18geTI8/cDyHXhDUFuCPbLY/m4zbtwRMw=;
 b=a5MYPH5A7uFRtPsqzZ/4mpqHgcDeFyuO6tfXjogdBnQ4z/d0PlpYI5yIvDCw0RVUdq69UbjRB7e9RvbMZ36/t9G40lpGtYItiRWBS3AWYRwWVlsO3KTAlJNpeLJS6coRSm2yW8ti3IUqmjdY64BtTyZTf2oPng3gF4B7zdYkbTGLqx7kgAXGR6eIvEv9uTAZxgoDAqO6I96sUH9nBvj+BHLQULl0keLI7v4ALUnabG1exVZLRUZwQH6TRMnnGidK+PsF9LwCTCSE9zoIlcvhBw0oVgTxNBkLhxLoZoKDafm9nRXppRtcklwYHMUpqS2dGRXmnaGY2iPf/rS3TBwQXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A38G0MrORo18geTI8/cDyHXhDUFuCPbLY/m4zbtwRMw=;
 b=j1w1EspSQHzoS5HokGYuhKPS4FwmYywznf5EDf5b0sxCjdWcBMiz5Skxp2Pp1k5USdKyNSGpMgrNUs+wcBUJ1SV4cUQyntQWasSvyIWWTOyhfOlIl2gJI5JBYN21vR5hKrzLlNZdI+3CP8/J8KOocn/83g/gXgjpG9ohUhIQQGg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MN6PR10MB8117.namprd10.prod.outlook.com (2603:10b6:208:4f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 13:58:46 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8901.033; Mon, 14 Jul 2025
 13:58:46 +0000
Date: Mon, 14 Jul 2025 22:58:31 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Jakub Kicinski <kuba@kernel.org>, Byungchul Park <byungchul@sk.com>,
        willy@infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel_team@skhynix.com, almasrymina@google.com,
        ilias.apalodimas@linaro.org, hawk@kernel.org,
        akpm@linux-foundation.org, davem@davemloft.net,
        john.fastabend@gmail.com, andrew+netdev@lunn.ch,
        asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
        edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
        leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
        linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
        vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
        jackmanb@google.com
Subject: Re: [PATCH net-next v7 1/7] netmem: introduce struct netmem_desc
 mirroring struct page
Message-ID: <aHUMwHft71cB8PFY@hyeyoo>
References: <20250625043350.7939-1-byungchul@sk.com>
 <20250625043350.7939-2-byungchul@sk.com>
 <20250626174904.4a6125c9@kernel.org>
 <20250627035405.GA4276@system.software.com>
 <20250627173730.15b25a8c@kernel.org>
 <aGHNmKRng9H6kTqz@hyeyoo>
 <20250701164508.0738f00f@kernel.org>
 <aHTQrso2Klvcwasf@hyeyoo>
 <92073822-ab60-40ca-9ff5-a41119c0ad3d@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92073822-ab60-40ca-9ff5-a41119c0ad3d@suse.cz>
X-ClientProxiedBy: SEWP216CA0082.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MN6PR10MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: 530d1970-2418-48a3-18d0-08ddc2de8cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DexulKLUswVS+DLMNEfqk3pW6Ttt9WH/CJyd24nbjcRnUvZeNCKMZyPyUFym?=
 =?us-ascii?Q?nMimVN0ksv5qRJc144kCUikSBni5MzCt+233VHmdUsRF6ImIsDL61UxFnIax?=
 =?us-ascii?Q?ynLVua0FsKGJyZH0Re3ymijxwBkvBKaDEdIHg97ZzGa7ObTRj/0cgma4iE8q?=
 =?us-ascii?Q?Zl4BXG0gBNyF+xUeYIHTtWaxfYKsHo1DV2fCKmXkKUtS7sJJjCHScT8VAJ8p?=
 =?us-ascii?Q?xskscZMOX6r3BTpiVIcrZirj2DnaKrYqyTq87aU2OHj0EMGorNB2qgooRz0G?=
 =?us-ascii?Q?M4r/2S1E5SaZ7eTqgjVxXUZYShYVDJw7rnlcpmgc9GElG0YhheVw/RlVYDdF?=
 =?us-ascii?Q?BNTwjFTOwmcACw89UvLoe6FWTBLwABJezk6u3ROcSeSxzrPJlU5O5kE9jSRd?=
 =?us-ascii?Q?VULKnDszVDolYfWpsLbjHXH+mOU1nIMhb2UTqncTXnrdfv6OZJhxTR8aDmTM?=
 =?us-ascii?Q?R23p6zgz8rV5OCutOIRsQ0pkiChrjfxD1+eY5nZlEkxIqEsEL2TpeoEkrlaj?=
 =?us-ascii?Q?LrrNPcCRDACDWpwqHRA2LZLarptTWjiDgvyeFoGHPvpnujkfx2QGV++WVluC?=
 =?us-ascii?Q?ueVGtXC6vkkdjGdRbFiZuU94x+cxSUVUEXAokLHQpoyLC+/sdbiGWH5DHQ69?=
 =?us-ascii?Q?E+QcCW7ugFwOGAr6He5d/ymCJV2IZcADDZxd8y96AysEhik4l7DTtTXUySgW?=
 =?us-ascii?Q?bP6JiMNjv53873BGPsroBnKu2quuu09MFQrqO1oiNRCsqS+Oop+CKYN3qFSy?=
 =?us-ascii?Q?kTNUbdpg/Md1sB3dD0dXXnN6EpQVXXYkvlfhMHrRuUQFQwFb1kBgGCnqvh9/?=
 =?us-ascii?Q?TfDdUuVBv2r86zG/Ie2YzpoosAmyC/kq3t9tf8bGy8SV+5JXNrm1Tvu7XXtV?=
 =?us-ascii?Q?MHpyzXUlggdvVvCPvJPlDhrjnlkytsbLUdDgNCYT6zfDnDLo6HM2dHYck6hM?=
 =?us-ascii?Q?tg2u4h5UUh9n4T28ToN8O7L6fpgPz7EvYC65lE7BkFXW9doTMoVgGyJCX48U?=
 =?us-ascii?Q?Tg7zkqN8OjgMq7yvxle0L6tfdTrBtO1V71XCFA+CbCfnvYvQ3ZVNcUCIBfSY?=
 =?us-ascii?Q?eu2BtAsB5Pa/04SjfXw08V00PuRsdfAddtCZpIEltMigLjXiaBkAmARnqZu3?=
 =?us-ascii?Q?J/8U2C2ryScH7YNo6Xg3Jk/FmvxylHEfFcP9wjUzvwR/JkK9RMdr1OVF9ze+?=
 =?us-ascii?Q?T2qWfS1BjtT56YJj4IfV77YPJs+VdCleWOd1ZHGNk3VMjONl/yCwXWeomPvq?=
 =?us-ascii?Q?qqHaESzCa+BKr6XNz+UxLnDAVfMECq9txfb3UP1f11KVh4yDhXgPSHr7JIuW?=
 =?us-ascii?Q?RlbPGvUxhbNjRk+LnL/950KEv08Ng/WNoDxrzSL2Zz3nCEYoxlAAznHBDNvQ?=
 =?us-ascii?Q?2J/u9EnY9X6wcZGEDeTjC3if/e2NLR6CjxhQ8cetWqxaWB+9SWgp/kocB8wK?=
 =?us-ascii?Q?LYINtoC6wnI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I+JXUYhyqbfmhjpifA5SU0HU2DNOmIMR1E2ggZCwWqUTWv/h9pWLYPspRXeD?=
 =?us-ascii?Q?Z9ABp3OakTAL+xZXetxV5BuX0H22Akvv2wfkg0ykGWmFPzhtJPW4Hy/+6XsC?=
 =?us-ascii?Q?zzxYV6wVoOJe7bXO34qChghHENBhaujSpVY08y5YfZ648Ao1tJSA39IlCVzy?=
 =?us-ascii?Q?/U1cB9I+wypwaEAOwnbu0xlDVvSLTKsWVB+Um0DOrvzE9U06qgSiJAk/CC6G?=
 =?us-ascii?Q?hIeAfx19HCnofhwYYTxgP2DQQyO372NXcGA1cWSCQ9fla/vZutlAb+Gev+vF?=
 =?us-ascii?Q?l2NqLwSiFoBtbjOLLqxRObiP+PO91fj2Z6mZoB+TRAK+U0HtVXpQn/j+xhbk?=
 =?us-ascii?Q?z83GQtfqngnXkdgwCm+p7SbnJQJkw/V+SX70q3JwfI5DVRjWIh/v6b0epfDR?=
 =?us-ascii?Q?f73HYUdsZMD8FJmYIs3oHBEbIG314n2eiF1sYjTsCkl4W7db+mOhDv6xAnbk?=
 =?us-ascii?Q?nYYjfKH7nB314UqCjJDFwjAbOI7lzKVYlbzxsFlq+cru0gk2KX0N3uYIzmWF?=
 =?us-ascii?Q?ARTgEltIi1GdDtL6u7B/CJ3+/unClEnzwx8l9sNrPwXH3euu+dyiIP37r9Dt?=
 =?us-ascii?Q?Ui6dYmQBb6OmG7EkAZ5qCZGw9r2YjwAhvioAYTvzk8G9wz9H+JnRQjoFHQn9?=
 =?us-ascii?Q?3jmxlISZOb0JFwN9PgJ1Xo1399ot0VL3WATJXBgsispCLeYvfDb5lOS7udse?=
 =?us-ascii?Q?3AcbBigdT1HTQF6H6c8RbloddVKcKlVLudZM7fKTRODvjKXQW0njmi7cPhfz?=
 =?us-ascii?Q?Q75PM0+obqoDT9DMkTax+mImZZ5E4qzZew3+AuVujvTf1l9ushAUHcxXTjyb?=
 =?us-ascii?Q?ohVT0MeWPh+pE+T7pqctxxH+Pzz1p0cZGfVBaDURJC7IH5IUr5zrJGl++4NB?=
 =?us-ascii?Q?f26McgTIuJiAiqN0qaQDVJ3O0EqkrpIneaomaa7swpjgtIHDvDXOak6RVHle?=
 =?us-ascii?Q?jY6jjcZDlxx2kI6NEIqv6N7tvwSdpmk0hXLLW77sbD1QMksZnS2nuvDtNLoY?=
 =?us-ascii?Q?yS5xfb5X2hhD6/k4gy2uLePKL9Lo3TTYvNA4XOOGX6U+5Am3KnhAWJdEha5h?=
 =?us-ascii?Q?QTnDnvTI9LDrLskFwhi2NMAdEGnxeuvsicMCgJn8MKRy3VaFWuiT5TurYaqR?=
 =?us-ascii?Q?Q4l1Krb3A4uSPSYMVjowVoD/YKRMPYmubNcVhAgIODL6NqSvo/yBMgXlGLos?=
 =?us-ascii?Q?jU92xDILkQoNs3Wuebg3w2cawZlcNpbkciWwISW6b+FAirgE+6doxbAQuyxJ?=
 =?us-ascii?Q?i107Juxej5V8FqIRPWy7OWBEQ9N+vbCsJHReDXezrpHqB188W9ifns+oLM66?=
 =?us-ascii?Q?AMc7Sdb0MTG1mdi4revOiyjecBY/UdIadLnqsuuQ6DgcDxiZUKrTL9Ws4ABW?=
 =?us-ascii?Q?aiFuCYThY1DaRJQ+92AfMFLGJyAiEy/03AKrqjntqjQGyLK8RiPf8KL56uyR?=
 =?us-ascii?Q?HjLgLv1X8dhkmklIBmHkEmdiA3bGz0Io6U6HfICDBN5Cp1HtzIf9N/P6vt9t?=
 =?us-ascii?Q?pWCqtQaEvjqwVsIOsHfxvKyC84v7SrkHs32eAJrGEc4H7WT3djB7kU0pVXrg?=
 =?us-ascii?Q?FaA23yBLzRuiHYtkS/vkUD/mcChekl6dGidDMA6X?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RGtq6o4Q/ymq0m37d9OaLzDoTQOEJVDTxpGMuHk8BkiPy5lV8IgaFgxj9oRZhCGEIlF/EgIYa8lbA4WT5EGuT5w8mh3idwSeiQnK7RuHJfmx1pboHZ91fRyfeT3SxQHZmvXeVFnQ9sxaBgqBySSUn/wBDTVwC6QJzsSn7+LXmGXU5VoTOlVjzItoUDQ6mJ84clFTfWd29GUJbuc8LWgB1DcUZO71x93MTxmhGr1wD40Btj2cmY0K3caxUCyDgd4zHriNu5ImPvuJTNWb4f8jPL3bGgM89gl9zkAlNmHKuPNV6nIdsKvFjKm0Bja8Z5AqYfUdO28Cb7x4F3OYzkmroxOJEXR2l6NOt9dut4cSQ/TAEtaXLPS4kEfN0oTWNHy1LFkbtugDakz4sHrgnvVsjeZh+mG1VYjgQL/WPPKKzdL7vCTw+XXBhCFHIVul/gsc7JR1IOlnan/z4auFPy8s9YRfxEimxglDq8TxfJPd4DDgkwBgBVEjzP6NSoWpQMCkSgILkPFQ41YHvb6JBWO7jIPgECfhzndDh5ErA8/kIl6jZiKXqI118zXB+frWqf8MV+Z0P4f0PA4RFMASnfut8a76WZDDu05j8UKIgvrhnPc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530d1970-2418-48a3-18d0-08ddc2de8cf7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:58:46.1756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CjU5v2XKpFH//XLNV9yFo776RV66Yp5J01e1belf9jk+b8gn5GENHw7tSRMeN2LMANVQXFEKYvUNBiodorNwHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140082
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=68750d1a b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=DhO6VexiiUVxDGFLv94A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12062
X-Proofpoint-ORIG-GUID: K0FswzTkHeVSTk6s29qoekUYPJflmDV8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4MiBTYWx0ZWRfX0PtExuUlKnMx 7arceVC80u17OgodyjzBPcQ1vBC0qZzfsOW2+VgbY2cEadxIZQ7tLclbRJzhHMhBatoWjgIjpjZ 08oGH/hSQxE2hIFISYQZHKkeBtxZ3Ul/A8uZyJ1hu7B3TE8BrC/72atIG9JjfTarohNJqLwycgq
 ZnMEBwHerOcnNPW387jO4NRSuMUNlbQhiRh/Ab9MEh0gDF8rWYltcKzNwDAYdrNQOXX611FPnXl /M2+L3v/3oRySNcjxQZa7fP0+PO/XsxL3C/556/5XXI0Dz3+hYufrRhsFBhYHDkIvak9TZz9tCE Lh+RdW83NjawVhZ6YtWduR4hkDUA+9YEdqE6elY+KPUmItoCgfJY+EVIqAEfrphPkq2txUb4L7T
 AXSNlnZAsXCjs/AIesXH5s+pF2Iog3Yj2b4FSBR6WCRmq1kM496XWmF5ewVHKPFuEDbIpT65
X-Proofpoint-GUID: K0FswzTkHeVSTk6s29qoekUYPJflmDV8

On Mon, Jul 14, 2025 at 03:24:02PM +0200, Vlastimil Babka wrote:
> On 7/14/25 11:42, Harry Yoo wrote:
> > On Tue, Jul 01, 2025 at 04:45:08PM -0700, Jakub Kicinski wrote:
> >> Thanks a lot, this clarifies things for me.
> > 
> > You're welcome :)
> > 
> >> Unfortunately, I still think that it's hard to judge patches 1 and 7 
> >> in context limited to this series, so let's proceed to reposting just
> >> the "middle 5" patches.
> > 
> > Could you please share your thoughts on why it's hard to judge them and
> > what's missing from the series, such as in the comments, changelog, or
> > the cover letter?
> 
> I think we moved on in the discussion since then? "middle 5" patches are now
> merged, and 1+7 was, along with more patches (that make the context less
> limited hopefully), posted as v9/v10 now?

On v7 Jakub asked [1] [2] few questions about the patch series
and I answered [3].

[1] https://lore.kernel.org/linux-mm/20250626174904.4a6125c9@kernel.org
[2] https://lore.kernel.org/linux-mm/20250627173730.15b25a8c@kernel.org 
[3] https://lore.kernel.org/linux-mm/aGHNmKRng9H6kTqz@hyeyoo

To me Jakub's comment "Thanks a lot, this clarifies things for me"
and still "hard to judge patches 1 and 7 in context limited to this series"
after reading my clarification (which wasn't part of the series)
sounded like he wants some of the clarification to be added to
later versions of the patchset.

But I don't speak for Jakub, I'll leave the answer to him.
Maybe I just misinterpreted his reply.

-- 
Cheers,
Harry / Hyeonggon

