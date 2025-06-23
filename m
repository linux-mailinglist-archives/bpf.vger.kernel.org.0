Return-Path: <bpf+bounces-61282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F0CAE3FDF
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 14:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5959B16FEB7
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 12:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3E524887E;
	Mon, 23 Jun 2025 12:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZTFWZTJL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MN6peV7Z"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8494213C9D4;
	Mon, 23 Jun 2025 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750681158; cv=fail; b=olWuor/878TtUrs3O4jMDkMzFY1mmh3dHCbBjuzEW579wMJt81A2RPsxELUrKU/C5i0Cpdm82fX5uHI0661quq7ZcXxsJ4j/1r61hZOjeAeD7HCE+QbnGqrG2KOzC+kgJIBJcQslYx8veMgKfNVBA1FgbpdvDDI7r9u0jVa/cYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750681158; c=relaxed/simple;
	bh=0F0wPdyfULlVcc8cklgs2eys2XHl3/pV7gjlQ33mctU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z0QsT4tAxxgZFfDaep5A+IsNiRnldR6btrcOdPviu6EeMM8V4j141ex+GsildiqDldiH4wB3AhGu2s/jvWLiLb6w94vzbzVVtS0pamnZK4cIBBIOzrqhNNwURK1c4XW0yIWgUgrWC1u8exkqCXTBPyi+M8qQeLh93AMNYem0H8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZTFWZTJL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MN6peV7Z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N8pPAx000840;
	Mon, 23 Jun 2025 12:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=dlbExU0fZSSiAzZ8na
	BM6J+lWy1bFAGkYwa9BnDv+zc=; b=ZTFWZTJLu0pSvIR0H7x+ah7a0DqXFssZU2
	hbxGEMSdMX0pyQfCVUwYZpZGcmJiY6Jo0jyxSADV/mIGuY9HKRM5Ut7vaUw1qJ4h
	DE1MyBnollWDBT2S+ddUtcQSard8C446RL0Vc7jYBOx2+tiOj8/CSIZWQOnL0h2W
	grUXNTjTcatkjxRJO0LTPgp9+GIEzxrjhzABcnuNhtkm3E7S1ltXnPoKSdGdZGtj
	ThaCLoN4P9jj/SJf0rYMc/zxPBtDDvBVVtS5fk0rVuwcyrRrmVJokwkaCkktLteE
	YTZz8asLtOyo7VLGnuAJWOWs7I8uhMpgDqQQGycpo+WoqiAB5pqw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt79f43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 12:18:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55NBgUHt002086;
	Mon, 23 Jun 2025 12:18:34 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpbrn1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 12:18:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/izZlxbLQZsyodEVklKDeMx5gA8lex34Gp6DCTI/yWVb8MzsRjqvC4nAZs7+STOUdToJ3yGYexKvihITMaSw/zY9VvQ2VFgeAlfUteLxPcDkEPmNy/8ZwhrAgvv/tes49hgXdIXajcSOreqCWITfPd2GsGqbMgRcd8JiWE5sPwq70U364DIC6KYpZ78PlHM1KSSgi+1jTnCrZ+TwDafbYciez24+vXpvaKsCCkhds9Q2wEP9eJRknbnQPAWmy35Onm7zO0uEjYjafl+rPxQ6qJV4bq5OH2L9CX2q5XumGzn7doBXlc9HAgQ+KhyTFTxw05J4G0aVtejQLdcVhnyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlbExU0fZSSiAzZ8naBM6J+lWy1bFAGkYwa9BnDv+zc=;
 b=sPGiKvP7zlKQZquUyuDVjTL00+lTtVZeBex048PPd9LOVQO+uog/PfXNOklw91meISCvLwY3ylLjkMsW43pA/cdL1LO0MkASB0wrJ8ygpoCHRRkuCyEAvA9d/h1OVbAS8zXq9jhZqTKrepxmvl+nuYayEIM1cVhuU4wU2QUB69kX+SWpNJ4vZY+5mf+0qMyP2Rb1rDVHgWafbGYeLUAXy7v3hG3AbVIlU9d/5fNkEqTCToMUs/o39CwYNq5tQQcf7JGSFcvbQnR1BhYG0LI9+BzfJLKL0KVXk7/gXSI0yt7q76sUOE7A/OOIVx3PigVu+kIlb7TcKlvJ+sX6+dNWAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlbExU0fZSSiAzZ8naBM6J+lWy1bFAGkYwa9BnDv+zc=;
 b=MN6peV7Zoj7sJ+lZCo2sR2/oKJd1PRMsJXeqjU39p3tLQH6pB+KzejZcMIbKYeDRKZxUC9SgK35RqPISNmnB0VYRt1kEPO2SabakiAwAQKo5kf3G8zOTSM0FgmKCOk55JnX749afq4GHWrTO3LQUebRNZdZrJoURGHVK2W59cQI=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH7PR10MB7731.namprd10.prod.outlook.com (2603:10b6:510:30c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 12:18:30 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8857.025; Mon, 23 Jun 2025
 12:18:30 +0000
Date: Mon, 23 Jun 2025 21:18:17 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Byungchul Park <byungchul@sk.com>
Cc: David Hildenbrand <david@redhat.com>, willy@infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
        almasrymina@google.com, ilias.apalodimas@linaro.org, hawk@kernel.org,
        akpm@linux-foundation.org, davem@davemloft.net,
        john.fastabend@gmail.com, andrew+netdev@lunn.ch,
        asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
        edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
        leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
        linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
        vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
        jackmanb@google.com
Subject: Re: [PATCH net-next v6 1/9] netmem: introduce struct netmem_desc
 mirroring struct page
Message-ID: <aFlGCam4_FnkGQYT@hyeyoo>
References: <20250620041224.46646-1-byungchul@sk.com>
 <20250620041224.46646-2-byungchul@sk.com>
 <8eaf52bf-4c3c-4007-afe5-a22da9f228f9@redhat.com>
 <20250623102821.GC3199@system.software.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623102821.GC3199@system.software.com>
X-ClientProxiedBy: SE2P216CA0085.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c6::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH7PR10MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e8f886-2e30-44ff-878e-08ddb250103a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u3KUazk1hT+sfJz9/lBSDh/3fa++ITkczhtDsj0+yqaBB0DNawGez5vGcGHn?=
 =?us-ascii?Q?7r8r3AioDc3+zuOFyeGPW7078//RZBxstM0qbyqKpy3BX0aK34XP8rJJIBTG?=
 =?us-ascii?Q?ETQgNnxkIgcMCToVtYxaJyBuN/PGeiE4x2Q6mY+4wuCj6RyF7KJXdWuqN1yE?=
 =?us-ascii?Q?LkhSnzW6HpF/4BvwvNJtDxWA3RVeTV3n6Rwl8ymO+01YpVtK/FAx7vsa29Nu?=
 =?us-ascii?Q?typRNViEUKJvWvrZnjG9QnfM1n2PA6FZ/f4smh7b4Ejjt/bea1Vpp3hHnLYA?=
 =?us-ascii?Q?eK/14Q4R4jFm5cXkGQYUSIzDpozqV5R732dhH8FULuYvNaHv0p/Z/WjuK6g+?=
 =?us-ascii?Q?boNNI1kLnz3/7oALeJgNK+JYE0x/XYIkdTIKYIqitKMXZ9benuTJrYws14Ek?=
 =?us-ascii?Q?OfE0y7DMZArmWHF4uil9VdBBLrr0uNedVXvvGYx42vjzZThqDOKwi8YQJR2R?=
 =?us-ascii?Q?gV5QH6zEo5vd3HT36+4RgNu1CPjjrpLR+3vxN/FHxa0FiivVFYH/lxsvKID1?=
 =?us-ascii?Q?kZESH800EEEjPem0tosDoMNHSn1wAOY5i7zEONAVcKAxaelRCs6Ry0bcQNTm?=
 =?us-ascii?Q?P5IGrTT8wo7l+hXWwZP5NUXHANB0/Qd9xiFnz7A9LpFzSX5it8wrNn8Wboke?=
 =?us-ascii?Q?34ckL/cH5lBEh+pL4SaJHw5rZYuFOYtvCkPQ77S3tGQA/BGanvnBRahj1ZmO?=
 =?us-ascii?Q?D4goFRL0lHWfeyYELF8/PZiQictgtT+/z/FFryvTBe7/VOtOESian424K7nk?=
 =?us-ascii?Q?LKZjR1ILViu8woyMTbzGfjKzkX68R/hHf/0xA/cK0tKHnFsWXutedA0bmtCg?=
 =?us-ascii?Q?g5qrDQ9PsbmBzEBs7YhKTX+rClsOKIR/Pq6XEJ40U02fpI8zId/dQvUpSfbe?=
 =?us-ascii?Q?3g3XYL47/MbWGkvYCnDGPpujl6svrrpMhfonVYsrqvBrbVCJ0nvkHioWL5tN?=
 =?us-ascii?Q?1QKieC7BSHf+e9PEa2OrxWNpa4PgtUUK7iJTK0AlaX6R3oZNUitO6LmJNRbS?=
 =?us-ascii?Q?ZIR65e0/hK+aeDAqIbn4XFqnMF/vdPV6q+y1l2YuHJcVV/YPMg2zIssiEge8?=
 =?us-ascii?Q?v9rcFKvCqfbfOBBAMpFE2tvZ8fcnThZWumohMqng2GSdtjH+fS4/snmtv7Og?=
 =?us-ascii?Q?1uUxGgwB8jm2N43E4uTCD96cpmNqCB9PRyizYbF34eya+C7odiRBKtEU4/Hi?=
 =?us-ascii?Q?xjeNau7AuOdjYgaalgLsh4WmAGPGqEzkooTYIvdqPOTpm3DKweABWGbJ3A4T?=
 =?us-ascii?Q?718anlYlIapRDtbA6t/drlqh62f2ZXh2JuAwUeVbnmbVqwUasYYjQrkbBjQ3?=
 =?us-ascii?Q?7M/pv/7V1vIDDbrB82JWKXVf98Aka5zTptwqlzuU2qdt+qjKHpx9KMWg1plD?=
 =?us-ascii?Q?1O0FF9IM9E7oERuui0QpVi2S/njl9wQ58Uq4xbPCxXMfDGxmUC4BGIYODNii?=
 =?us-ascii?Q?KZx/Rm3aL0s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4IUPeEdh6BkmT/FbGcxZI44KxH45z8k9lO5LuQXqjs5+qbXxoDS7WXX1c43r?=
 =?us-ascii?Q?eiMJiFRl0V8TDX6NsYXTZfCfwUwikcf1GtrmC5kQ3UrPak40fCuYSQJnTanI?=
 =?us-ascii?Q?G3Tg1iqbSYMZgGLW2AmUy60oXSE4A0BG/wHygEgZ0bvxIlW2F5y+tpRpRbjN?=
 =?us-ascii?Q?A5lu6zIJttJs5N1efgTo9nWXg6IJrJvSsq/I0xC4d9ylMHEj8VG0Cxi+998M?=
 =?us-ascii?Q?BTBr0TbnrYBTEbhplGY5meexceEzHpRL8JUIbRDVM9XBWYqFuMZH7nC9vbhj?=
 =?us-ascii?Q?LaqIbK1BjEapvk/OfUauwZtIMVi7DX6tuU3WJ5EtgeZPYkTZmvjqBzEpDnKq?=
 =?us-ascii?Q?yA3/oExYZVmOUf4fUrq//lAlWk8UFzot/jR+mCRLGv2zsxsfcLRWMdTviEoI?=
 =?us-ascii?Q?fbuzzfQHMBt1raYfqiguO3nWasKLsgmzuhfH3LtRNu6GeAMSiAcDoOsCkci9?=
 =?us-ascii?Q?eEUqevrkEDHXURhTxgF0KrHNyij77U/EmdllUNkkY69sNQA8W9DD+EzA1waW?=
 =?us-ascii?Q?Too2ax/dou4XkZTCVnYqsIlpqm3OxckcaFwlxBJ96PN6Lf05s0JjYAvTqJEJ?=
 =?us-ascii?Q?koMBMVtesYVDs6yyVX80sD7iZZWP4iIPnQZfd5BvRck86lYgSk4ee3nPCkNT?=
 =?us-ascii?Q?ze9xu2pizawAni/07ELCkU9n++v/4tT80gmpqZZa/BVrjWY9bJmmj685Gu5z?=
 =?us-ascii?Q?SIjfpD4mQzYJawJKvqtFuZGIQn0kIYcrVL0QwmT4vBjDfGyaR7BTV9k7GbAs?=
 =?us-ascii?Q?tkk3ni1Wym5ugtu2c6jZpy2288lGwDeiohdo52MQqStNV4rFpFk9bA5tFp+W?=
 =?us-ascii?Q?pBn0MW/6RFu2uGgUXUDL+5FIy0V0RjvztoIutSiFSWf/ljJWVYyjQNzescId?=
 =?us-ascii?Q?6bR0bf4lPB4n6qYBxIiDM11b/7ns4l89xMyspy24A6TNRDnaBWxKQ8SjYLqL?=
 =?us-ascii?Q?fVISf3ChHcKTqWdWbkfxopHsO4jppSiyTRQ3fALCus7mFYkonG+1tjK1VFro?=
 =?us-ascii?Q?6j4xpkJFPHcSGEzhqw9rV5HfzzYgUg3AcoR+aoPazSQuHeDAl8eSiJp9QAtX?=
 =?us-ascii?Q?0uUuGUhMXO7FmFCiIpGOMx0xEOM+woSQYzF11sN+/DNcu0MwNGkR7jaZMtT5?=
 =?us-ascii?Q?S+++Ii6idPYI833Yk7Czqouvc7NTStetojkh7toYY2yYIpV/pQ/1a12DSujE?=
 =?us-ascii?Q?LEjxgZL3AJ94IAFLN0Y+VQBKCtjnC8zvUQCRsIZdg/vzZHBK2Y1Ldyka37s3?=
 =?us-ascii?Q?JPPe4c+q8qpezp4TXHTi9Rof6G02vJFpKbkqutpoAB4MidmnQPtnr3mmVzOG?=
 =?us-ascii?Q?3hEXxVu3atDpFEWq5APLDwQhm+VC1dSEXDQtUg0ydB6VRrjNVjcSli7+F3Wv?=
 =?us-ascii?Q?QxICcwR2MKV6pRLY1dAiHHPVJuzfdG60CwHfE02BfHojrb+Q9hVWGHAcwoII?=
 =?us-ascii?Q?hmzWLRtJakp0tr8cyBaMcaC5B8jfSn5EXsax9pYv0bwy1aWx3FLWD5Cbdths?=
 =?us-ascii?Q?opqFSdADqZX22VaV8VXrs+mIU7EkoVb8yt8DFMxwPrXghKkfaCnMSlS1xNYL?=
 =?us-ascii?Q?3rBA/ejpuICR/o2nfWa7YOhVJPoaEX5YxPQ2v3pj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o/GbQo/xkuxOiTBZxkKBmVqL0V5nLc2aT+qwHeSePK/TY7T2Cmy2380Klo8bEy1DmrO6rd4v1GlKaGOgDmyQ7radHmn3B7IukuRz8+UfdnyIS7lmHhzkEwYpK+jV4FqHHWAO54wt1gtPCfXEMqWbLL9Mv+Mn5YnLFzR44PrMO1URLiMlf3RU13cWXO9GCopdMMf2uU8N9tIX2Wvjgg9Ym3KYD6uMcWuyEFm4YFx3/A32kfGDWNJvBchKpdzuCiFWxzuBga79VBOVfHjwfIdsNBkLzLmmVQ6xIrhk6T4mMivUbuVrCoy70dkG+0QYNTgX1WgjBVZ33Ckfihtn9I7gyRxbgN+n6FR8ZFeSRR3FooaxTGvQFpbzCYFLIDqlBahssd7yG1a6GvDn4vAOxQUF99XFKmKOITMcXF9mahn5EPNMHe4ZkleiaX4wsB9H//PO084Ua1QqobPyFdAg0XGDJ/cgGwG4ZvSde5A4qoApE/UksP7HIk442MeEWIbOXfH8j8YJX1Fwr83WAJgUo5z74luG7635KPvbRKcag29bAyohpUKy/fJZiJY06GKznMNKzwzR58A+Z+cCqTAC9cjS1n5CruvlhsIdUrnfeWFHcw0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e8f886-2e30-44ff-878e-08ddb250103a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:18:29.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYbYrDD725zCChssanB1zLeFR67n14xerIUAevUPdamiOSVm2lyXcIYcgl6I1FQstlOrtlo453naol4spKp7tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7731
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506230074
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA3NCBTYWx0ZWRfX6/B+qTJB84q9 QiAjZFevHk8mDa0d7acKnoTyf/lc5/sRINlPbvNCvqgOUmeXRMTd9ZBWlbUk5Zx4SZoLelHSug1 Hh+eEukgYxi3NKOqRZZc60vp33I/kD2isrOiAYFNbNDQK+/baMl+sQbeKArotFV2nUV/pssFjhj
 1OSCbML8rOFsUXU9KfiKuRQaiDw3FkFGrPy6U2lGCN9xes+dQ3xaXVks+VZWKaBg6DbjpmECrFa eIrL2jYV86b8j7q/FDFHlTf6rtf8x0Y14RGNxfiyCRakwVHRR2PCAnOTc0BRUsXtGn/SfRga9Bj hxR8ODixWzD5Q/nfHSsuhHA3bEz4cEnvZLC7IfHsYBNxdgtejR4AscI69Nn6V+EAkrZjpo8Oerh
 nlBmdxyu5Q2l9Ed0GgR+4agr4RQPmp3GOaAEeKx/s68ORWhkL8Pdhynah6Y81+Gsb1XPlJKv
X-Proofpoint-GUID: syhjktEHiG9PpXe4-i2wosITvndSvmhb
X-Authority-Analysis: v=2.4 cv=QNpoRhLL c=1 sm=1 tr=0 ts=6859461b b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=ElTu3praijgQyxyD9nAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: syhjktEHiG9PpXe4-i2wosITvndSvmhb

On Mon, Jun 23, 2025 at 07:28:21PM +0900, Byungchul Park wrote:
> On Mon, Jun 23, 2025 at 11:32:16AM +0200, David Hildenbrand wrote:
> > On 20.06.25 06:12, Byungchul Park wrote:
> > > To simplify struct page, the page pool members of struct page should be
> > > moved to other, allowing these members to be removed from struct page.
> > > 
> > > Introduce a network memory descriptor to store the members, struct
> > > netmem_desc, and make it union'ed with the existing fields in struct
> > > net_iov, allowing to organize the fields of struct net_iov.
> > 
> > It would be great adding some result from the previous discussions in
> > here, such as that the layout of "struct net_iov" can be changed because
> > it is not a "struct page" overlay, what the next steps based on this
> 
> I think the network folks already know how to use and interpret their
> data struct, struct net_iov for sure.. but I will add the comment if it
> you think is needed.  Thanks for the comment.

I agree with David - it's not immediately obvious at first glance.
That was my feedback on the previous version as well :)

I think it'd be great to add that explanation, since this is where MM and
networking intersect.

> 	Byungchul
> 
> > patch are etc.
> > 
> > --
> > Cheers,
> > 
> > David / dhildenb

-- 
Cheers,
Harry / Hyeonggon

