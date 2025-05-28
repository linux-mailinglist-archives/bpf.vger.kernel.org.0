Return-Path: <bpf+bounces-59165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DD8AC66D1
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 12:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A020618995A8
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 10:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295992798E6;
	Wed, 28 May 2025 10:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gKTnRNRA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kzCrm7An"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71D42749C2;
	Wed, 28 May 2025 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748427270; cv=fail; b=qgO0S37uin+/MDk6rTh++kOd+pPcrYrCbr1pMjqBMTdFCceyhzJ+qdQ+9Srz2FFzPMX8shgMELzVv4Eja5VV0FVW8n3ClVmS6ql+JUjQ9F1RPvllyap2eJFNdHDzIRO4JY4N3rCwlg36G9pxs6RPN8Km2KMqDGUOAwk8Y0Oq/I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748427270; c=relaxed/simple;
	bh=T0kEnFRdFr0QEe5F5j1Sb8ZtyAuoN5IlI2bKZPSOYqI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YkOMpMcU+Qwtwk9CIXi15tLGfUfYQwWXSfsgmt7oJdaOldC9Gsfed5u37Utrnm1QZ/7hXJ2hGgJwO6ccU9YfOPGfR9vpDilMMhxtGpayVlh9On6ZQJrxnvszpwPCQEzUMZjQtKn1R+/3SbiTD3lH5CHepdBRxedGLzg7X7DN8Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gKTnRNRA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kzCrm7An; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S1h893011936;
	Wed, 28 May 2025 10:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rwS7XdAWyb1v9chifZsJxbGCwTwxMLWD+BXodoCjU7M=; b=
	gKTnRNRARNKj72tb9ezSF+CdHK966Ho2p2xdXMJH/LVhUiSyBg+yGgo6ZspmeG+d
	NXUGxqtvLWXIbmbdDLuatpJ357Mf2TAKYz+meXNSzPmkuRFlXpWQncqYO4ECuKKp
	RLH45ZCE80lxCP0aNtpn0Hj/0eXyIgtNem3GuKr2yqfrNuyq23ZJT/NkJnqhmnnz
	VTg8TjesLDaaFdxCxz/7iD3Hs78o/eKI92RUdytUZAyrDKD22sWb4RCfqZfIGOTL
	Gy2sp95ZfDN7rd3oWe5wr2gLRy+/YsF6gBawY/EKKvWx3gntj6/afs4Sa2D7JeZ8
	EosY/nY2ZIa2g3e5lF/FWw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd5a3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 10:14:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54S9qLta021108;
	Wed, 28 May 2025 10:14:19 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jgq0cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 10:14:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BI38O37ah9WV2BExctWn7xZI6joqcsxqs2qEoPPq+JBDa22UwqioQn3Sd2cBsjHNFEIJAx5HZc6f1FnzrVPOXWUPf6x/Gdbtefk6sytT27GxtNCnlxobNLZ1+TMEJcYzFKaUuN+64/MHF+Vix7kIZYOvOMppcWFlblKBWOV1EVTswtlN+8OBdUWrh5ei2Zk02RNGlHe/sZmGTNdRTSsoudzesF1N9I6QGMUDW0NzZ5SpNcB/ZrSAyIUIQrf4VV6flZ7G3wkrYOkSskBrkK4MTxtakeAQr2P5YxtvcPeIgfpTsoCFRO2YWD+Cl/uahfXnHDe+VRQPTqMHOR3GuNUkkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwS7XdAWyb1v9chifZsJxbGCwTwxMLWD+BXodoCjU7M=;
 b=c8XY7lTHlCeWXGFskBZs5O49gQHqWCl/u8LpUKkOYXP+A8uk99GtOB5yHR1l/TVPc/8a8DuMUbut7AwXbA81N0pqxRB3Bj8xML3l1I9qHLtkigWkP/H/4Gyf7peITA/BkE0Q0mtYzQlyQE8SFObv6798jkHNIKgph/p/Vh2YgQazbxlZMQHOtz94BEski10m5OYkZ23KEZoddO7K5BL8ryTqDxdvVSNHLqNoG0hEGFfsFksdfOccjczfHlaUTNJ24z4rE2oZLWTCCHIErb7SBAcRlajZhqE5wuVXpvTZTZ07K9cDIyNsz7yauYACF+6AJzxTuiYi5W0wwXKdenvfMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwS7XdAWyb1v9chifZsJxbGCwTwxMLWD+BXodoCjU7M=;
 b=kzCrm7AnffBKYzV/XZLZeZUSm25gBV61qhf3pvXtuZNWPu0bdFbv+P0Elu+MHV8GTBPrcD4d/dkp2joRMiJcqn2tIJXpAx+Im4MTSzGKxTcNJQuoMrVH5440rms9vlW/pCu4FZ+QJEjNFfBd8ytDIGo78x3n2l6w9xKVAC0QmT8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN0PR10MB5959.namprd10.prod.outlook.com (2603:10b6:208:3cd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Wed, 28 May
 2025 10:14:16 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8746.032; Wed, 28 May 2025
 10:14:16 +0000
Message-ID: <8ae5370b-1e31-490c-98f7-d414ddf21cfc@oracle.com>
Date: Wed, 28 May 2025 11:14:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] list inline expansions in .BTF.inline
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Thierry Treyer <ttreyer@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>, "ast@kernel.org" <ast@kernel.org>,
        Yonghong Song <yhs@meta.com>, "andrii@kernel.org" <andrii@kernel.org>,
        "ihor.solodrai@linux.dev" <ihor.solodrai@linux.dev>,
        Song Liu <songliubraving@meta.com>, Mykola Lysenko <mykolal@meta.com>,
        Daniel Xu <dlxu@meta.com>
References: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
 <d39e456b-20ed-48cf-90c0-c0b0b03dabe6@oracle.com>
 <09366E0A-0819-4C0A-9179-F40F8F46ECE0@meta.com>
 <CAEf4BzZxccvWcGJ06hSnrVh6jJO-gdCLUitc7qNE-2oO8iK+og@mail.gmail.com>
 <bfb120452de9d9ce0868485bc41fa8cf56edf4cf.camel@gmail.com>
 <530F1115-7836-4F1F-A14D-F1A7B49EF299@meta.com>
 <6428960b-a1a7-4b1f-8975-5a85e2b8697d@oracle.com>
 <CAEf4BzaG-GtJwVXNyZKqYnZFqq210uLFSHPArZYXyS+fab5Dmg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzaG-GtJwVXNyZKqYnZFqq210uLFSHPArZYXyS+fab5Dmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0081.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MN0PR10MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: b0327a7f-9223-477c-4c30-08dd9dd066dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzI4ZUR5dExvT2V1eFpLYWFLT09tZURsSlB5Q29EWjBYbkFWcFB4VXM2WHZH?=
 =?utf-8?B?a2l1TDhYUXNPZ3V3d2FMcW1uRkFOZ3RqOWxwUjI0bzdZVjJCYTBoNzRNVFYr?=
 =?utf-8?B?Z2hhdlhQWUFZYmdtTlhucW5TZk9CSjNvMm1USG1uYmZLY2JjMU9pNXRiT3Z0?=
 =?utf-8?B?SVQ5OUw2YTJuMHhXR1lQWkRuYVR5bWU1OXlOM05pNTNTMXBZQm93NkZDM3Yz?=
 =?utf-8?B?YnYxbHdtRGt0cjNwK01tZlNEWXN4ZGxQNVZTa1NqQjlyK3lobDBDa3ZWY2JK?=
 =?utf-8?B?dGNHTHNRdVcvYUNRaTZNQjcwNk9ZK3BXU0YrWG5uRWt5U0NLZ09lVUNKQkNl?=
 =?utf-8?B?TFBPTzljRzJBNjRZL2I4cmYxK0tIbmk1ZkovSWYvS0Qzb0RGUm0yT0w1c0xp?=
 =?utf-8?B?NUcxaitpMHpyaVU4cmFaMG5wd1VTakNFZDRWdGVVQW9mSUpPQXdKSE1uODlS?=
 =?utf-8?B?eVNYYmlTdkVwUmJQbEd4dkJ0TmtFVDdFaEhreTBsejF6Y1J2Ny9RR2JGb0tV?=
 =?utf-8?B?bUo5KzVxbTgzOXdUMWswNnJPSjlCbldsMSswVGpTWlFkeEFGTTF4eldmRUpi?=
 =?utf-8?B?TEZzclg1TXFpWml0bEY2WlZaLzQrcjlPS1lvbzBxU0VWcUJJcFZtN0JFTytm?=
 =?utf-8?B?T1p1djQ2cXZrem4vSkdjOWg2TFIzYmF0Y3N0NEdKVVJsTy95S3g3ejZHdWor?=
 =?utf-8?B?R09Ca2NNYldudEpmZzN5M29kcnZQWUhUY0lpZ1BXc1FVZnIzSU9yVkhQcnpw?=
 =?utf-8?B?VHk2ZXp4SHAyOXp6QTlWUHdTUHJmM3oyMUtnekNNNWI0QUxXTk84eXYzTHBu?=
 =?utf-8?B?RGZtaWhMbnMrL2F4Z2RhZzV6aTdUcCtqNXI3V2VLQ2ZlT1hqcytSK1NkY01S?=
 =?utf-8?B?MDMyUVRXZGdZK3hDUXlISHQ5M0FrY0c3MUl5VkpWS1dOcFlVWlBqMTFEVDJo?=
 =?utf-8?B?ZjFZY21vNDJrMUlxQmVvTXYyT3dqMXhlZ1R0Mjh6b0NWWmh5WE40Q2ttdlVw?=
 =?utf-8?B?Z2o5djV3MDZTMys2UDQ2Vm9GcXJiNTFoUUJMTzRUZFNSc2lrMzJIWXdoTHpa?=
 =?utf-8?B?aWpnS0c1WDBmUng4b0xVaXlScW9aeG9tWUhpNFRKN0hXTm8wTkxWOStFYmVO?=
 =?utf-8?B?OXVuNnNoUFcyVUFNMVNYK2xQNjQ5cFJDd2tRRCtEWTE4cStLaVd6SEMxeERi?=
 =?utf-8?B?L3NuZkVWNU9jaG5keWF5Ylg4NEFWYW9MZmp6QzFtcFE2cVh1bUlaeGs4MVJm?=
 =?utf-8?B?M2VaMFBSU2hoQ1RvenZZMG9sN2hRYTNJVndES0l0ZVFNSHFtRS9UZkJGb0xO?=
 =?utf-8?B?aS9CcFRoTllDanBVajBGMG1YSmNYRmlCdjhrUG1teVk4eFRGUHdlKzR5WStw?=
 =?utf-8?B?SE9Edmk2TjVSQjYzdVZlMVVDM0tkdm9jd080L2UzcmErRHFpSkxFMTk1eFNQ?=
 =?utf-8?B?RFNrVGlqTEtxRlNhcWQzYjk3Q0tkVHNQcjNaZnBDRzErL1hyZTJYVS9uMSth?=
 =?utf-8?B?Nktod2s3Q0l6Qnl1bURjWE1BZWk3U2xGS0V1WjdUejNLU0Z1dWx1dE1zQ2N4?=
 =?utf-8?B?N0ZrMWtOUC8zUkNMTFdkMEMvRC81NERPc1h5NDg5Qy9qSmI4OVFZZ1RMSi9a?=
 =?utf-8?B?c1R4YkFBNXBQS2FKNDFTeFFncElicFdPRXAxeUU0QVBrbEtNZStkb2pnMG14?=
 =?utf-8?B?ZGZHN3RzbTBPMHZUN3R6c0JoMTBhMGVwa3pYazZGYnQweUZueE1VdjFBK2t1?=
 =?utf-8?B?clorOU1lTUUyTnJqa0ZTUEhtVXJIVlhiV2JxVW81MTJpdkI0K003QWtlbnJv?=
 =?utf-8?B?ekdQam1jQXBUVkU0VlhwYXZQWnNLNmZzenNrQ2psZHNPeWc2UFdtVE5HNFdx?=
 =?utf-8?B?VXF6enZSNnBrQkFSZE1RYzRpd2VhcnBRNTZTVU9LZWRaYThNQVgzL09rYXFY?=
 =?utf-8?Q?8hAm90ijSm5N+PfJ5UivsQWqBInT4dVb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1ZrOFl1SjRmZ0Q3SzhNQ29EQy9zL3ZUUlJrRUN0aE5tSFIva2I3UE5KMjRm?=
 =?utf-8?B?UHdNbTN6OE1QNm1uajZmcS9wKzNXajJYUVFuSkJNTlJobE5qcllnNlFCVE1L?=
 =?utf-8?B?N1Y1d1d3bHcyVDhhSVUyMG00M3RqUDViWjJXd0hiN2RUZlV3OEtHVDNlZVRl?=
 =?utf-8?B?MUZnck9jbkoxMWNjenpkOC9lalJuUWhjUVpQRWFGZm1mWHdJOXVwellGMUwr?=
 =?utf-8?B?dzYxeEswZXJhb080NGorVUhjTHd0RFNEdjlKRmJqSHBiNVBOR0sydGtpcHRm?=
 =?utf-8?B?QVc2QzYzQWx5cUVjaGtlVFVBZlU4MytLa2M0Nll2NjBqZWI3ME5FWUFZTHJI?=
 =?utf-8?B?RUpiNXZyejh3bW9TOHBJU2ZMVTkwVHJXUjNTcjZJbHh3VHZYY2w2QmJHWjc4?=
 =?utf-8?B?Nk5SS29tdWZPK3RUTDFwMGZ3ZnJ4ZERxZkQwUGhta0F1dTBFS2xoQ05MY0c4?=
 =?utf-8?B?K1BqSkFES2pJWGJSeXRJcUY5NmRBUGFIRzRKT0twcnlTT0tHYmY1ZEFmdmpz?=
 =?utf-8?B?d0J4cWNmRDhwSDVyV01vTll0Nk1CUW90aExaY2FMK0JTM25Ib054M1VicnNB?=
 =?utf-8?B?NXdVM3pvb1JBdzJVRXU2eGZ3THFjaWVzWUE0SytCYWErVTh5dkVsQ2hUZnBP?=
 =?utf-8?B?RTQ5U3lHRjJaMkVIOWdLRitTTTUwa0k3YVphc2t1VElpSTJucWNSRUNsWk43?=
 =?utf-8?B?amFVaG5jYlptL2VPQlFuRmdQMThmUjVmdUhPd081ejhmUklJbytqaHZVV2Jo?=
 =?utf-8?B?V243Qk1Xa1pNMitSazVmeWRidGYzNFNYbEVqQi8wSmRHcXRiblgvWm9IQUJ5?=
 =?utf-8?B?aVQ2RWFJVyt1bGptbkpBRWdUSjkxOURhblJBWDRFN1d0Q1M2VG1iT3g1STJT?=
 =?utf-8?B?aXdTMWNvbEpkSWJWV0xNQm1Id3hPYlhiYVZxVUpmQllRUGZEd1lsdGJzNW5s?=
 =?utf-8?B?KytRTUU5WjZHUGhuQnVlMW1NWTg1S3lLL2tlMG1BSWQ0OURGVHhVc0NZYkxi?=
 =?utf-8?B?blFHazVjd0hjbGhnT1d4MlpuUm5GVERFbXNQckFZdzBHWXhWcFBIVUN2OTh0?=
 =?utf-8?B?ajNRSDRUa2haVjc0T2lETzU0K1V3SGUzS0V4d25GbnJRZUh0Q09rb2RDeWdK?=
 =?utf-8?B?Rk1NRFdWOVd3WmV4ajB1WHF4a3lTOWxyYUNnY213WXYwbEpWVzFseUhVbzU0?=
 =?utf-8?B?Q3dENDVwaHB1bDFFak5yMVdPczlWejdWeDlncFBoc2VyRTZrWXoweHdpZUxk?=
 =?utf-8?B?NkJydWs3M01YRVg0dUNPNjN4ejdBQ2MyeUN3QVNHQ3UwZG0xdndvbGZqalFT?=
 =?utf-8?B?a2NobHEyT1NycW9LMkdNMENEakJsN2Z2VWFrVFhFMXo4T2hrK3Y0dFFiZTg2?=
 =?utf-8?B?eWJJQk9sYURselFqYkNOSUlaR3lOd1RXdEFNd29nRWdOUzRwWm8xWUpaWmhQ?=
 =?utf-8?B?NFpXd3Q1eWIzNzZoV0xtdW5KZ3J5akNFdzRTM25qcURNayt0bXdPYXMvcmVR?=
 =?utf-8?B?Nm1NNXBrcnZURXNJUEYwTnJZY2VkRVpLS1NVUkZNRVhPZTFMb29DckZNalYx?=
 =?utf-8?B?NVF3d242cVhNbFJkeVBpM0ZzK29PRHYwaGE2VmhGUTRlK2F3YnVRODFZcUdi?=
 =?utf-8?B?L1lHWUprRHlicXpQT2VPMWxsNklVY1RwbW5KbWc2VUpiMitRZjBtMmhEMG5I?=
 =?utf-8?B?MENETTAwV3BUZEpXR2FTNGE4cjVSUEVkdjRsR2c4L0V5WnhaS2ZKSHdKQzZz?=
 =?utf-8?B?djQ1TE8rU04wUXA5SlgwSlpKdzBHY2MwZjhJcW9SUzdMaTBhUHdLL2ZQb1Z3?=
 =?utf-8?B?aSt2cW5JN1JTUEdGVUM1MXJsd2Vha0w1NjdBRHExWitCZldmK3hKbUtkYm1k?=
 =?utf-8?B?S0pDb2UwM2wxelV1anREaGEwbS9OcXJ4ZVN2YkphWkFPT0wvbkgvQ1VSMjhY?=
 =?utf-8?B?OXBaOUFZOUpxZzRwZEc5bUZSQ3BRR1pMRWMwdHpIRThBT2dPSk9hamZ2akZQ?=
 =?utf-8?B?QVRyZ1E3bkdlbG03M1lQUDN4SGUrNmF4Q2pxUFZtNnQ1Y2Y3UjVzR3dlRDFq?=
 =?utf-8?B?S3grYUkwVTRodks5eWdXN3Y0M1V4cldrSEhoaFlCbHhKcXFuSk9LTk5vUlor?=
 =?utf-8?B?QmxGOUJuRWpZVitaNi9rWHBJRmFFRjlkUFFuMkhjZllmNVlmcTNQMk1rcWNN?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tbANygjpjzOXpTgQRH5GpYfu5G57a9JN6lLVqFenIvqg4RZkwkw7CIEYgedpnLVsjGvoFlp3TGrSDsxY0poSsRKsXDo8MvVeZtvQp2xi7Jwr/AO9a7InJ8WDel/wzCFdfxVs7caT7Fx7GxTlo1U3mLIKTZELnaacGwWuk43B67Vl+AaMdD7py3kDCXu5I7YC2KCcvcAHDGzsygVFuP4Gcvn7wT3VgVG8tC8aKYoogqWszJM9kcsObtEztNNGDbR8vlrBSMHG/N1vBH72ZLeNImaLiNQueNs1eu3EMrAJ1iMHkaVqtyfgLhRt1AwEDJVizaTYRPOH0+3N/rAOx6jSLguEr0UAECdLHdowpsYukfQP9iR+cUx7wmqUv1oAIhGSaL+xHCZ+nQVEHtefISRhKQhRZ864jNKXuX4NF9jtWwOU4ryCTdTPBGCxQPRhx/rFady2Zp+kMCZ05zbQD7h/ft5Es/YEWsSGLtKyA48gTj8ftWB+RZWL/yHOLxUoMciF9DpaMEDYsaLH5vp3fOl+uP3W93auc5WXgoJ8aIVFeAa2V5wziZan35HZigOXTl+2KSWlQP5jeLG9Cvb8zKI4ViqXZHfFOqCKpV9+6Xd9KhA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0327a7f-9223-477c-4c30-08dd9dd066dd
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 10:14:16.3363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFmnPxvlE9lOKPP4hZC/o7p/qtbofU6F5vT9bvuTd7cGM2O+wjVc8mlDD22CxAWMCrjnyjMET2+94ci9DHI8VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_05,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280089
X-Proofpoint-ORIG-GUID: jendn_Am6SQNxvVH5uOhjXoGczJXMcPt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDA4OSBTYWx0ZWRfX9M7dCuxWfH4u GbcSXEoP9GsP9O66CDIJscn3U3+a1VKErSA8CJKFmPDALLwBUVxViGxqgnnlziVDsohd4sQju8T D9OdNDmHySxnYsMFvgMt+S5QNBeI5s3+6+5HbKQko2pWahp97gLc5eIZOuR/cd0qoBzwuWj2L8p
 hna8Q0MryJJrGYdnDUJqRDqr64+ZigDhjaZIOZlrug69vdllPCezfbUXSkWb7la6DR0as1Nq/+1 69f5v7z36hHFlM3GhuJLSZd48Z+DGFBxN+7KTd0tC1+t2LL96arnTioOQhh95XO3fTJDl99PDiO 8YDMDg1gyLKVWbY+QBm7Ri//WlCucTMKfYHJkmf4+REMzOtL0LQsnpwcUYa8/ZGwlQOB587BMfX
 ehIxgqgGfH0+pS3EE+4VCD3hbMLtmjSmlbpm4YTqwmDt8BgAArRt/gAiNZPDVZxStsSIdc0o
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=6836e1fd b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=hfeZBPPEeLFfK5SkM5MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207
X-Proofpoint-GUID: jendn_Am6SQNxvVH5uOhjXoGczJXMcPt

On 27/05/2025 22:41, Andrii Nakryiko wrote:
> On Mon, May 26, 2025 at 7:30 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 23/05/2025 19:57, Thierry Treyer wrote:
>>>>>>  2) // param_offsets point to each parameters' location
>>>>>>     struct fn_info { u32 type_id, offset; u16 param_offsets[proto.arglen]; };
>>>>>>  [...]
>>>>>>  (2) param offsets, w/ dedup         14,526      4,808,838    4,823,364
>>>>>
>>>>> This one is almost as good as (3) below, but fits better into the
>>>>> existing kind+vlen model where there is a variable number of fixed
>>>>> sized elements (but locations can still be variable-sized and keep
>>>>> evolving much more easily). I'd go with this one, unless I'm missing
>>>>> some important benefit of other representations.
>>>>
>>>> Thierry, could you please provide some details for the representation
>>>> of both fn_info and parameters for this case?
>>>
>>> The locations are stored in their own sub-section, like strings, using the
>>> encoding described previously. A location is a tagged union of an operation
>>> and its operands describing how to find to parameter’s value.
>>>
>>> The locations for nil, ’%rdi’ and ’*(%rdi + 32)’ are encoded as follow:
>>>
>>>   [0x00] [0x09 0x05] [0x0a 0x05 0x00000020]
>>> #  `NIL   `REG   #5   |    `Reg#5        `Offset added to Reg’s value
>>> #                     `ADDR_REG_OFF
>>>
>>> The funcsec table starts with a `struct btf_type` of type FUNCSEC, followed by
>>> vlen `struct btf_func_secinfo` (referred previously as fn_info):
>>>
>>>   .align(4)
>>>   struct btf_func_secinfo {
>>>     __u32 type_id;                       // Type ID of FUNC
>>>     __u32 offset;                        // Offset in section
>>>     __u16 parameter_offsets[proto.vlen]; // Offsets to params’ location
>>>   };
>>>
>>> To know how many parameters a function has, you’d use its type_id to retrieve
>>> its FUNC, then its FUNC_PROTO to finally get the FUNC_PROTO vlen.
>>> Optimized out parameters won’t have a location, so we need a NIL to skip them.
>>>
>>>
>>> Given a function with arg0 optimized out, arg1 at *(%rdi + 32) and arg2 in %rdi.
>>> You’d get the following encoding:
>>>
>>>   [1] FUNC_PROTO, vlen=3
>>>       ...args
>>>   [2] FUNC 'foo' type_id=1
>>>   [3] FUNCSEC '.text', vlen=1           # ,NIL   ,*(%rdi + 32)
>>>       - type_id=n, offset=0x1234, params=[0x0, 0x3, 0x1]
>>>                                         #             `%rdi
>>>
>>> # Regular BTF encoding for 1 and 2
>>>   ...
>>> # ,FUNCSEC ’.text’, vlen=1
>>>   [0x000001 0x14000001 0x00000000]
>>> # ,btf_func_secinfo      ,params=[0x0, 0x3, 0x1] + extra nil for alignment
>>>   [0x00000002 0x00001234 0x0000 0x0003 0x0001 0x0000]
>>>
>>> Note: I didn’t take into account the 4-bytes padding requirement of BTF.
>>>       I’ve sent the correct numbers when responding to Alexei.
>>>
>>>> I'm curious how far this version is from exhausting u16 limit.
>>>
>>>
>>> We’re already using 22% of the 64 kiB addressable by u16.
>>>
>>>> Why abuse DATASEC if we are extending BTF with new types anyways? I'd
>>>> go with a dedicated FUNCSEC (or FUNCSET, maybe?..)
>>>
>>> I'm not sure that a 'set' describes the table best, since a function
>>> can have multiple entries in the table.
>>> FUNCSEC is ugly, but it conveys that the offsets are from a section’s base.
>>
>>
>> I totally agree that we have more freedom to define new representations
>> here, so don't feel too constrained by existing representations like
>> DATASEC if they are not helpful.
>>
>> One thing I hadn't really thought about before you suggested it is
>> having the locations in a separate section from types as we have for
>> strings. Do we need that? Or could we have a BTF_KIND_LOC_SEC that is
>> associated with the FUNC_SEC via a type id (loc sec points at the type
>> of the associated func sec) and contains the packed location info?
>>
>> In other words
>>
>> [3] FUNCSEC '.text', vlen= ...
>> <func_id, offset, param_location_offsets[]>
>> ...
>> [4] LOCSEC '.text', type_id=3
>> <packed locations>
> 
> LOCSEC pointing to FUNCSEC isn't that useful, no? You'd want to go
> from FUNCSEC to LOCSEC quickly, not the other way around, no? But I
> also don't see the need to have a per-ELF-section set of locations,
> tbh... One set ought to be enough across all FUNCSECs?
>

I can't think of scenario where we'd need more than one (aside from
below) and as you say since FUNCSECs refer to LOCSEC offsets, if we did
want to relate them it'd make more sense to have FUNCSEC point at the
LOCSEC it uses.

BTW thanks for the reminder on the kind layout stuff; I cleaned it up
and sent a v5 [1] along with pahole support [2]. I guess it's a bit
hypocritical that I'm arguing against adding an additional section here
while trying to add one for kind layouts, but the kind layout stuff does
raise how a BTF type might represent a packed set of locations.
Traditionally we've had a singular element or a vlen-specified number of
elements (or both), so for LOCSEC we have the problem that vlen is 16
bits. We could I suppose have the vlen-associated size be 4 bytes which
would mean we'd support up to 262144 bytes of location information.
However it is a bit of an abuse of the vlen * size model since each
location isn't necessarily contained in the 4 bytes. I guess that in
fact might be one possible justification for multiple LOCSECs; hitting
size limitations. Or indeed a justification for using a separate
location section since it doesn't fit well into the existing btf_type model.

Anyway these are all things we should weigh up when deciding whether to
use a separate location section versus a LOCSEC kind. Thanks!

Alan


[1]
https://lore.kernel.org/bpf/20250528095743.791722-1-alan.maguire@oracle.com/
[2]
https://lore.kernel.org/dwarves/20250528095349.788793-1-alan.maguire@oracle.com/


