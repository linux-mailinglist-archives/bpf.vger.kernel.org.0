Return-Path: <bpf+bounces-34014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 480F8929754
	for <lists+bpf@lfdr.de>; Sun,  7 Jul 2024 11:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC6B1C20C30
	for <lists+bpf@lfdr.de>; Sun,  7 Jul 2024 09:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D49817722;
	Sun,  7 Jul 2024 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ISueMKA/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i9jQ6sI9"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC88117997;
	Sun,  7 Jul 2024 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720345449; cv=fail; b=HqjwUAwlaUOmn3u8uiPUrxkDdYWoiGW0j3jp0XuhI25siVBrzhPqr/+sFbNyGe/nFArFbH5mNDg/TcakGpJ0j/L7GeEHORVD/f+DIzpdU4TqmZo6ryupV/ymf8THqs/j4sAnEk1OU9+BvGz8Cj19NnOvCvnL7+WrvUue/fREJl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720345449; c=relaxed/simple;
	bh=xq+Sj4yhRAfKsQb4iyu9zcOGN4smlslGYoKCf3yK39Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FECan+tfQxf0BY7QG9VyF4H2+jHcfuQjUL7Agc/R+3K61ZJsT1Y7B2zcCir3PxAOWIQluFDIPo+woBI1CZQhnJNnSa1fORZbSJTrd0mHqtD+JggX8m3rVPuRgxeG3xQHIfqQjxsaOCHbq7af0zb8uL6XUZRQG//2nGe2beB26y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ISueMKA/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i9jQ6sI9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4675jQQT016241;
	Sun, 7 Jul 2024 09:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=MITGLjiJuHh1S2zXqYBap1MYKkHUIYA4em13k7rfYeI=; b=
	ISueMKA/Qe2pTUHkQ6k99ehF1xefEwxiWDX//W2iLPg8H+9OGilk7jYtaCm5yHRT
	+QafrkOWkk4+/2UoZ2z7OoKIaxBOUgN8rQSlklHB9V9cqZdgBBvBkhIKS5uVMao3
	sHmMEAH3zJhqE4PNm5VcyZiPk7VcHYUMQyd9AnhCTZZLes8Do/gyV59vLuL0Lot7
	x6OjDLj04czQ/WvVY0CH4u4bIrzIm6bkttL1u+m6RmTJowigEQTVMmWeJkMoOlZS
	5SREmDjT1Fpj983WBnZlmarG1ikrKvZK/qftfeQOGlLfvfPhy+UMY+bLS+3x/g1w
	fgjerx0L1hnEHz7Wk4ZuLw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt893wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Jul 2024 09:43:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4676sX4w017857;
	Sun, 7 Jul 2024 09:43:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 406vc59817-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 07 Jul 2024 09:43:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPIKOdjcC6Om/+caOmqKMO9rdy2EToVyPTJ7rf1qN+U1cEwTB+Pl/sVIGFb13nx0Tw7R51Lgn6BMkCy720/mmcA0m8dE7MgT3XsqeLjEUh/b0yIlgrZeA12wvZbJva1m0uJCegSugfiwTPyqIHNFTmF8iqKVWKPEZZGZxXxEYdkdgdXrAniFcPeYUvGNRaMyW3tJ5tEi09aOStQxtLsvgAB4DoRxb+A2bUDZUECCEt5ejaeaC/MoM2eq3iOtD7BULCLP+a9qac4ze67iJLKbt4+N4HVUQiRzaDWeQDz1MCklkhxAVVTJOGoAopqBxnAZ5bz+aKjIXRkE0THLBnTshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MITGLjiJuHh1S2zXqYBap1MYKkHUIYA4em13k7rfYeI=;
 b=JJkF7nutAzucja/zN8NWfMPp1FwyW5dNLTe2oj/R3wOV+MaJTzBo1sqekgORRfqpLw7S2zwnhHuJUT03GnTxK0l+08p1UpVZH3GIBYJDcDTgBItslT5dSZ0g8UUxLzmTz99tfYRXK94DzTk1pEsxEIVbozayPgwF7wfLw8YKun3/K0L94W3wuXzaRxzLqZnx7ZSukjkVYa2C3b+NwO/DBHm4jOpx2MG+SrrE50mrSa+wPfYASrx28bz3M8KrcT0uE0QgRIUI/7drb+yuhsg1hfhWK6LLO4XF5yQ/Q2CYWg87UJIbYVHPXZVZM45B4nKoZvh/sVPxBON3dBIpsqRRqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MITGLjiJuHh1S2zXqYBap1MYKkHUIYA4em13k7rfYeI=;
 b=i9jQ6sI954PYmxZ51V4YQ+DyBlGfN4VzHXDL/xrzFoAz8ChHyzwtPiKKvUssUQ6QMBM5OfY5IeOVkEzoH1CYGYg0p2ubRYZ45jC6pwtmWwf0A4UeqPeL6t+4mrtgi23RSX4gKCmK3Bob+qojZA1xUkAt4z5Ngz4VyMT54+6eEyM=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by CH3PR10MB7630.namprd10.prod.outlook.com (2603:10b6:610:178::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Sun, 7 Jul
 2024 09:43:39 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%7]) with mapi id 15.20.7741.033; Sun, 7 Jul 2024
 09:43:39 +0000
Message-ID: <484eb16f-bb4f-4ecf-a63c-295bf2ca163b@oracle.com>
Date: Sat, 6 Jul 2024 02:42:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] af_unix: Disable MSG_OOB handling for sockets in
 sockmap/sockhash
To: Jakub Sitnicki <jakub@cloudflare.com>, Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        john.fastabend@gmail.com, kuniyu@amazon.com,
        Cong Wang <cong.wang@bytedance.com>
References: <20240622223324.3337956-1-mhal@rbox.co>
 <874j9ijuju.fsf@cloudflare.com>
 <2301f9fb-dab5-4db7-8e69-309e7c7186b7@rbox.co>
 <87tthej0jj.fsf@cloudflare.com>
Content-Language: en-US
From: Rao Shoaib <rao.shoaib@oracle.com>
In-Reply-To: <87tthej0jj.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0199.namprd05.prod.outlook.com
 (2603:10b6:a03:330::24) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|CH3PR10MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9d0b23-c9f2-4652-e693-08dc9e6947f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SzVaZzMwSk9nazVhWS93SDFxWTR4S24wS2pjVEZVY0NxRDJYb3NCYlNRV1cv?=
 =?utf-8?B?MWxsemkwR05zMUhWTDVicTJJaEtwaTE5V0xhTUg3ZzRhbURZL3UvRWMyekM0?=
 =?utf-8?B?aW5nRzJnd2w0M2tQdEVFOW55SnZkdlNOVHBxNjRFY0hiOTBkRFhpSktsQ3Mv?=
 =?utf-8?B?cUo2N1lnNnJOSEdYNnN0VS9obldvb004a3MrL1pMajhFSllYdEZhdDR5bUh5?=
 =?utf-8?B?VGYySFFodmkxL0lKejQ0anhZeHRsdVYyQVNxTlI4U3Rlem5rZVF6QW1UZmdy?=
 =?utf-8?B?dW54cENQejFGckxnV3JNZDV2Sy83L2dsQTJ3WTRQNDN2TUJQckFpNjBwOGR3?=
 =?utf-8?B?UXhRc25mZmY4VVpRREVWWUdrZ3NDYVlqMWZhTWRQUXBPR0hiSThjdjZWTWFG?=
 =?utf-8?B?b3ppSlNGbG5Wbm16bi8yRjhSV2tqUmlyZkxmZHlEaStpMzU3bXk3N1ZicGZt?=
 =?utf-8?B?ckY5d1pRaThzSXVLRzhabmpRM2Y5T3FtU2JYNHNSUnZqOU9mQ3NUemF2SEd5?=
 =?utf-8?B?aXV5RmlJYWJEa0FuZ3BwTjRxTTBPQ0Nla3F4cEJ4MDFzOUR3R3l1Um51aElL?=
 =?utf-8?B?TGVaYWtJekhKeFAvQktLYzdnV3Nnb09DTjZ5OFBWSlVtaTNTdUpYbzBrYzBJ?=
 =?utf-8?B?NGl6VWhHUVZCNWpBY0c3SXJNSENpZ1RzaTVtbDlLM292RGIxSCs3R0M5NE1a?=
 =?utf-8?B?T3prSnllc0MyaXhkcXhxTnJobTJpMUxDdmlFcXJZTXUzbHMzbnRmb2ZDVWRZ?=
 =?utf-8?B?MTRDNUcvQk91amhxekIyNlhmYUJvL3VuZ1Y0N1lCd01XaWJ5bmw4ZUFkREVr?=
 =?utf-8?B?WGorS2pTTUNLbUFBekIvUUszUTZIT25EUGFTelhLa2E0emJvTzNoTHpEeGlW?=
 =?utf-8?B?dkdsb2IyQ0tsWmFLYllEcUZYVkw1RUtFbHorNVF1a1ZQWUl5VnhkZXg0WmFU?=
 =?utf-8?B?bS9GTVVLWE1CZTI2ZU5PSVIybmVVaEwzbXJaUGVkNU9wMjBIUW9nVnNRMlNP?=
 =?utf-8?B?cUMvekx1dTE4ejUwOUhlcjNBdkxDbU5lYUY3MWhSOXNEN3ViKzlDaTBLVkdL?=
 =?utf-8?B?R2ZoQi9mUm9JV0Izb0NKMVZ2bDNwcVprMGxlRlJaRGJWaVJVelFuS2dIQ09x?=
 =?utf-8?B?SFdqSWRuWHo4Zlp0dHhHdDN6T2pWSEUxRnJGa3FiNXllZ212ZDNLQVRnUDd6?=
 =?utf-8?B?bGxTeVVMSVZzbHBzNVY4SXB2L0h4dFV6YzBVdGpnK1NFVjFic0NSUWhkUnVS?=
 =?utf-8?B?ZkIrRkVlckt6bnpaeSswWmpUaG1QajZWRWsraDBIS3M3ZkQ1Z2FhSlVMQWZT?=
 =?utf-8?B?ZFB6RDdpaTZyc00welZ2c1JPdG5aNVNZSUlESS83YXVhNEM2U2tBQ0NvMHlm?=
 =?utf-8?B?cklHcmovTXNLYmhHYUxsUllGTEVzd2F5S2wxaVd5Q243eG5lUmZyTkFuSTBu?=
 =?utf-8?B?SWNMRlcwWjd6dTc1ZzExb0pHRUh3RG5EUzdnVGxjdlN4Z2xiMWFsT09mM1FC?=
 =?utf-8?B?RnBBSlROc0c5WS9rRTNhRkpEOEpmdUJ6UkdWNE1NaHplVzMwWno0ZVNmSWVl?=
 =?utf-8?B?RGlUdzgwSVdnK1oyNjl3eGVwTjFrbThEaW4zVmdYY1U1cjRUOVdPZXZJQ0pk?=
 =?utf-8?B?UnZzUitqZXdLRjhxT1hRWE5oOENDczhNUjNQek8wbVV3Vi83dHlvR05sZHh3?=
 =?utf-8?B?L2NubGVnZnRkUkRKN0FZREFlakgzY3RLYjAzdDZDSURhREVycE5LR3dSRm02?=
 =?utf-8?Q?jT4u1cqb269AaRybic=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WnVhUi9PazR5L3VXTUNWK3NmYlM4TG04K05UU05mb01kZlRxdkpZMVBPMUpl?=
 =?utf-8?B?Y0x2alNIMi9Mb09UOEdDZFQ1Y2paN0wvZXVDazI5TSs4WnZ4d3NaRzYyVW9T?=
 =?utf-8?B?V2hpVlRjelBocmlyWjVxMHlUVnoxRXIyM1VXRnlQK3pnRTRCaHdxR2hseGdz?=
 =?utf-8?B?dElWak9XdGNZWUFxYWFNajBJOUZNK1hJdUNla2F2SGJwUkdzclR6azJaVFJ6?=
 =?utf-8?B?ZFJWVXVOZWIyaGlBb3lQMEpoOWYzT0NVNnRqRG9QamVFSCszcmZ3aHBFTUFu?=
 =?utf-8?B?WXVCbnRvUkx6dld6STlha2Z4VVFtQTdVZnUrbEN1bEVOeWxUbFhxdTdHODlH?=
 =?utf-8?B?VC9mRElTczBPdXk0VjJRVnY4NXVBS1NCSVpOdzVaSXRsUU5mVE5GU29YUVNY?=
 =?utf-8?B?OXk5dGErdU5UTENtTUVsS1MxazVXNUhRb2dBYVdTWm44ZzRwOFZUTzc3YmFQ?=
 =?utf-8?B?MGFYNVV1Z3NvS2RGMkgvOUk5cGxzblV3ZkE0THA1RklnYW83RmZNOGlpRjFN?=
 =?utf-8?B?WkVvNnB6TlZTaFNRMVkwT00rQTlpT24zMmp3ZzFjc2V6MUFOMU5VMm5DUTMv?=
 =?utf-8?B?SVcyY2JLY0pqbmk2RXJsZWsvZS9ZUE9hWndCRXBtNEFjVXJzaFBFM2x3OC9P?=
 =?utf-8?B?ekRBNVJMN0R4NndvVXRaeFlCNVZzYTZEalMxeVl2Yjhycnk3c2dnZGVpM1p1?=
 =?utf-8?B?aW5BUEhaKzJObGdhSW5vNzQwbnBqZ3dQVmJPMUxyT0N6bDR2WkhUWGlMSHBI?=
 =?utf-8?B?djV2dmNMcHYwNFUrNWlNKzh2K2VzNEZlVFBKMzliTTVlY0ErSzNwRGxxNG9j?=
 =?utf-8?B?dFEyVTVMRTg5c2ZXSS9NR2g0eHlNV1BzdHRiMC9CNGRHekJtSURaa0QrTmV5?=
 =?utf-8?B?WnpvV0Y3aGNqeWptWWNxdndJN0lDaUdFalhrbmJ3YU9ULzJ2SkhrK0ZxTjRr?=
 =?utf-8?B?VnF4UG9DS2RCT2Z0SXpnN2NGclFZU2hBK1ozTHlvNnB3L21JcU5ORUVmWEQz?=
 =?utf-8?B?MWJoZzNITXF0YjlVbWxIUzEwdEpubzFmT2pHTC9GNU4wdmZKRnUwQzQwMWdn?=
 =?utf-8?B?Uks1ZFhEUzVJTE04em9jNWZGUEg3SnJ5MkYwd3k1eXpXUlh0RnVZYkpKUGgr?=
 =?utf-8?B?dWJ3R2QxNDA4ZkhmSldlTEVzaDQxeWdLODNwVis4ZmFVYUczWFdMWlgvK2xG?=
 =?utf-8?B?NDNRT3dQd2RwV29Oa0xkVHdpalZBbFNSUDhmQVVRZkk5K1FFeEZSTEJRbG1p?=
 =?utf-8?B?d093L1hqc2xyMWlqbVdhdGRBemhHUmFVNVZmSldYWlF0bHE0eTN6WDVFMGlK?=
 =?utf-8?B?S1l0ZW5wZEx3dXBidnRxUUdWS0l2TmN1MmNJbUJjc2l1dEJ0c1N2enoybk04?=
 =?utf-8?B?bnBzVTF3aTlBRVkycldmS2RXdGQvdDFubTc2dEE5TTRib2FrNGdncCsyWjhB?=
 =?utf-8?B?M3NBdjVKQTBZdlFFMHNHU2JZTHFFbW9WeW5Va0wyMEptMzlvM1krOHZWYm5l?=
 =?utf-8?B?QXlrL1g5SWZ2aTBIOTAwMkFZaEdpR2YyeGova1lUM0lPbW50b09TallGN3Fh?=
 =?utf-8?B?R21SSU9PK054a0xuY2FEZHQzTGE5RU5GV2U0MElNZmp5Szl3WGdIQ05uQjkv?=
 =?utf-8?B?cnU2ZDNKUDh0NXd6VE1UeStGdnBYMEZVZ29Scnk5aXMvSWQvcjBGM1FYR2JI?=
 =?utf-8?B?ZlNLUWFhQU4zTjBTUG1ONmhhNDNlWEFaTUtyWVdaajNUM3RoUnFHRUVrbzd5?=
 =?utf-8?B?VWYvVlkvU0UvVDJ0c0p6OEV0dHR3Y2svNG1sSnhSWUh6QlZIa0FYR2I3OTJ6?=
 =?utf-8?B?TFJoSms4NXBleWxsdTR1UHpCSVdyM3VMNmgrRXZ5azZrL0JvZUhBTzliVEM2?=
 =?utf-8?B?QTNJbEF2R2xpQlk5ME9ZS1ZyV3h5em84cGdNb3F4c0xtWWlvMDVseFdXOFV3?=
 =?utf-8?B?MnZIZ3RNeUMxSG1ib2RKQnp0QjBQdmpaYjJzWURXV0E2dXhvNXZtUHB5ZE42?=
 =?utf-8?B?Yk84cnAxUzIzYWZVSENFMUxrbmpGM1JUU2o0cnpZdk51d0drckhaYzNyNEhv?=
 =?utf-8?B?Z3NIWVdCY0U2ME05V2djT1RYSWJUdDA1QjZTRTdzMk1YQ213OUtSa1hZMEIx?=
 =?utf-8?Q?CiD2E65xpbamFOk34x0VteGsb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	y0NfT3qsz543O8x23RuQa4uKSBIlWgcpp4Uk8uaMzFgJ5oeGlR/97Q4Wx3oD7IrOobyx6NNagS2bj/THlrQtcaZXb64tKvMs19RvQ+OIrPC7SC2FJ0rSeCSLMSth3WVfyKHjP06IsJsygvbi5LH0Uwl2PmM4zzkwmtcniYyqsir/MxyObRgWfdX/rcMn/pSGqZQYIY67eSLxcFOhWE3Rtn90LSe/izRZUy6OKfmUueZ636qaizE+hP6lMxt/X5rW57Pe7GkO1HCdjjrE2hUziZl1E8LfUFlJaI7xvy4BonF8KCrAXbiJG/RRLWE9F8KvF5Zj+9GziAjFSLGqsqvjhPrNGa1zollH8pLZ73ObD8Bpx49qtYtuatrPaLLMAGLgFglS09eEkTgqvqTvtRY/0JFCzpptJLZuR2e+uWG5fDHPtLfq+rx3dgtw5PMbb9CkvtpMMbqemXZbqdLQ70S7BtisQlUSWAIy2Gblnag6RHiNR+P4Wo8jrlidZdXBUZj8Frl0PjOcXjgItfU3lctWrMqv1qAZZAqJ6WUGhRSW9CYjfzF+/ROfyc4dzghVIzr4yI2dIrof5BkwKONmEtxiUC3p05ZhD8V334rf4vuzd1E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9d0b23-c9f2-4652-e693-08dc9e6947f0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2024 09:43:39.6932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1oWGT4FuU12y1BCf155g+/eYQZz0PRw2dmeDaBLtBVq806TuBkb0jroigzEX8ZTMQ8xI9H7ClvJkXiefXvJwWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7630
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_06,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407070078
X-Proofpoint-GUID: uUauF0mb0XpxUL83wAm0ZzWH9iI7qfZA
X-Proofpoint-ORIG-GUID: uUauF0mb0XpxUL83wAm0ZzWH9iI7qfZA



On 6/27/24 12:40, Jakub Sitnicki wrote:
> On Wed, Jun 26, 2024 at 12:19 PM +02, Michal Luczaj wrote:
>> On 6/24/24 16:15, Jakub Sitnicki wrote:
>>> On Sun, Jun 23, 2024 at 12:25 AM +02, Michal Luczaj wrote:
>>>> AF_UNIX socket tracks the most recent OOB packet (in its receive queue)
>>>> with an `oob_skb` pointer. BPF redirecting does not account for that: when
>>>> an OOB packet is moved between sockets, `oob_skb` is left outdated. This
>>>> results in a single skb that may be accessed from two different sockets.
>>>>
>>>> Take the easy way out: silently drop MSG_OOB data targeting any socket that
>>>> is in a sockmap or a sockhash. Note that such silent drop is akin to the
>>>> fate of redirected skb's scm_fp_list (SCM_RIGHTS, SCM_CREDENTIALS).
>>>>
>>>> For symmetry, forbid MSG_OOB in unix_bpf_recvmsg().
>>>>
>>>> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>>>> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>> ---
>>>
>>> [+CC Cong who authored ->read_skb]
>>>
>>> I'm guessing you have a test program that you're developing the fix
>>> against. Would you like to extend the test case for sockmap redirect
>>> from unix stream [1] to incorporate it?
>>>
>>> Sadly unix_inet_redir_to_connected needs a fix first because it
>>> hardcodes sotype to SOCK_DGRAM.
>>
>> Ugh, my last two replies got silently dropped by vger. Is there any way to
>> tell what went wrong?
> 
> Not sure if it was vger or lore archive. Your reply hit my inbox but is
> nowhere to be found in the archive:
> 
> https://urldefense.com/v3/__https://lore.kernel.org/r/4bac0a8a-eeaa-48ef-aeba-2a6e73c0b982@rbox.co__;!!ACWV5N9M2RV99hQ!INUzIF25cVLOogl5HVn1FemXyw-iTBF358Wi77LDaYGg2UY3mi7Q1sTnZiUhkZhEc1qGZgUEGnRhkq4C$ 
> 
> I think we can reach out to Konstantin Ryabitsev at
> konstantin@linuxfoundation.org. AFAIK he maintains the lore.kernel.org
> archive.
> 
>> So, again, sure, I'll extend the sockmap redirect test.
> 
> Appreciate the help with adding a regression test, if time allows.
> Fixes are of course very welcome even without them.
> 
>> And regarding Rao's comment, I took a look and I think sockmap'ed TCP OOB
>> does indeed act the same way. I'll try to add that into selftest as well.n
> 
> Right, it does sound like we're not clearing the offset kept in
> tcp_sock::urg_data when skb is redirected.
> 

I am fine if the behavior is same as TCP. Thanks a lot for looking into
this.

Regards,

Shoaib

> 
> 
> 

