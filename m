Return-Path: <bpf+bounces-30976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E7C8D5424
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 23:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A221C249BA
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 21:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76BE84FA5;
	Thu, 30 May 2024 21:05:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71811C6A7;
	Thu, 30 May 2024 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103109; cv=fail; b=jbj2c+DaOG+MMd9W4xzPU20qugpSV9TSDD2FIfyMzTv9pv/TSWI3dVsi9z6sSddejVXCh9pAI9AsoRUw7jsfDrOuZv+8p9lMTrPS4xoeubSVvUVPhdn6Vk9Nf/BNE/tRkfDIxjKJspGFxPvArsLn0jehNJOEcIpzEpgVPHsv5Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103109; c=relaxed/simple;
	bh=AacAggv6cB7yA3QUcMik3UsM3IDbrZoLgMgPdDN3+Tg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G3Hbah6372srKmlWLM2jtNefFNeqOuRXizyiw5a5zR2fLQYbvheLqC22SruCU8hcAC7pAWyL2qaRhP7PoVSCNsP70098j28Ed+ghcLgjGipAXd3ZVtAFgZFuVau2ENe7vLwk3GV2j5/wWaxBvCjUyV+usKOrNwix2/X51Sg7vP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UFIa4M005689;
	Thu, 30 May 2024 21:04:59 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DG8gS1yYjj8rWoJIEb4jPxqg6usRodx6ZpCSvi6U7rZo=3D;_b?=
 =?UTF-8?Q?=3DnbNYO/FO8YcwDhf5n5xii7n9QS7YAj4pOMH4Boo4rLmMAXpdDkU4l7DC0fJn?=
 =?UTF-8?Q?Cx128vEa_u7OKQsDFMC+CGIbJ21XyhZ7kYUIfJ2APg6Zyh09jW4czVw6OnuNZAl?=
 =?UTF-8?Q?ytW2kgJGFDSleP_RT5EcuoL9ggUQ/8xfBG7lQj7WljeLlowjzUHFxk1/2ReLiLW?=
 =?UTF-8?Q?2+NH05Qz6XI3nR9V4GXx_OYVr1ffAdXBHkLNqW+4OL9rY4rdmg/VIARpldaOj6K?=
 =?UTF-8?Q?3hQOo/JXSAH4bmagTWvjoBXlGh_0TEXnAmZYcGPtum+BItdOLJT4U4DySvwHxjY?=
 =?UTF-8?Q?c3tW7qjurormP8JgVlxxopcu9oGOtyj4_AA=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g49ysh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 21:04:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44UKRgsn006234;
	Thu, 30 May 2024 21:04:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yd7c7h7cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 21:04:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPHyvpCKEn1fJMiPiUF02Gon46bn1LQYlyzBseOsAZVM504MEhHnh9nEr3BRbf+LtAJkHOCg6prLT/BDCIo9HlZA5zOF1sA3qC12nlF6EpU4RNPEUg8Ly5JZjj/hbZ/8iRj4mCXowPVIPBAkvq0rw9L5EId0aVNeuUcM+e1vdedJ6hR7wPNHD9ck74RtAnFjAoiUGGHWmk3UgHpCxq1PweEB+OXcVUiuvi37NFfhNxPPkHFOrK7BWIHY71SKasnbG0xIroz1sGK3qGmbfAzPOwqXUptSX8yn/YoMPnxg0wCq80C6siJWINUAYZjHU22D+xrLqSjhNPI947gFnNrSDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8gS1yYjj8rWoJIEb4jPxqg6usRodx6ZpCSvi6U7rZo=;
 b=LhlPb89YM5OxR+vSM6EpN9bnkIAf3ZNgXN5N08sCJBBH9nipfmEzXfmKdv+AYzeEGQpiSV2JBJZK3rdTmcDZK56PkAkCFKxxVhH3s2MSF9KYtAb3JZ1zXCSrpOez4/5/y5x1Y3N3krq++oCwdGeJ8ZzIzMA9kXeqsL8XIeYE5R2hctfPzeENRIBYJgpvKe8MPIscRMwJPi9rwqMTL0ewpJi3U+SPVC3bFvszt+AES+Zx80LWrExTujJS6OiNsRwnvNREzo9nSYCexKat1gMyE3zYMyIvA1YpJf4Lu5xWQG+wbs6syK+7E0coZQAFT8IdXpQd9qZy0S43qREyoc59BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8gS1yYjj8rWoJIEb4jPxqg6usRodx6ZpCSvi6U7rZo=;
 b=tH9F6ypav9qh/0y28q6pCReewfXlAMEaAUQYeYjQhCU5otWws5WYmrkoVuz+i7wHk/dI5Xto4TEECDxPwn5ZLaEslsYAQ3ej5bG9DxDmU1Ovn0Se0cCyVOIzcZmr4tehVSuNV1ahN5VFcyXnTgSFI2xkGOixU/Wo+MoxvrsSaAQ=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SA1PR10MB7633.namprd10.prod.outlook.com (2603:10b6:806:375::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 21:04:53 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%6]) with mapi id 15.20.7633.017; Thu, 30 May 2024
 21:04:51 +0000
Message-ID: <490d42c8-5361-4db4-a5d1-3f992f4b8003@oracle.com>
Date: Thu, 30 May 2024 14:04:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: tap: validate metadata and length for XDP buff
 before building up skb
To: Jason Wang <jasowang@redhat.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, mst@redhat.com,
        boris.ostrovsky@oracle.com
References: <1717026141-25716-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEugdcKjxMA_3+-gfh4wKOP5vTvYOb2V+MP7VxDiZ6EhiA@mail.gmail.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEugdcKjxMA_3+-gfh4wKOP5vTvYOb2V+MP7VxDiZ6EhiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:208:236::31) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SA1PR10MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a40810-d433-484a-048b-08dc80ec25d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZWJzUU05OVJaYlovRlh0dzZ2dnJ5Z0wwZ3FHVXBpZmpTMEVtZk0yMFNnSlpM?=
 =?utf-8?B?WksxUTNlZEEvVm9lRkRLWHBaQjIvSjk0WlZhejJmZ1I1TmtITHRMZStEdWhk?=
 =?utf-8?B?bTZucDdWZEJTS2lqSUhKcy9ISDRxSWN3MUVjdmVPT2hZVFRTRjJCWm1VaFkv?=
 =?utf-8?B?a2xjOGFWblQ2MFowS005Sm9QeFQxUXorNEtxeU5mcnNTdUpneUs3cHR0NDJK?=
 =?utf-8?B?N3U4VjBNUHNIQ09peHBUTTlRY3NmdnBjL2hrK1V5ZkFlMGJOZzV1eE8zREdh?=
 =?utf-8?B?K3lhZnVTbVpLbExvM1pITi8wTXhycjdlL3l3NGhjb25qajYxM1pTclUyMHlY?=
 =?utf-8?B?Vm1zQmI0VFN2OGl2c0RyRWtRSUhFMmJEbFl1aWwyNUxjaHlidVQvdmxheTNo?=
 =?utf-8?B?SCswci9uTGExZ1dRZVA3czJJWmNRWDFWOVBDM3o2dklSYzhJZi9GcDZybTdE?=
 =?utf-8?B?RVpoSW1BUW92SUVFa3FJQU90bnVBR25YeE1DaTRJSzMwNzRITnRuWDJVMGFU?=
 =?utf-8?B?T3BueGk2V0pMdFVsdWdlVHdPdWJ2UWRqT0VXU2hsVjRHVlJQZWVXTy9wek9K?=
 =?utf-8?B?K0p3YXdVeEN0VWQzcHhEU1I5Qzk4NTlvVTVaK0Z5S1VHcHRpWGZVWkhYZFU1?=
 =?utf-8?B?VzlPencyU3o4b2wwb2F5SnlTSnYvN25pSGtmV2VFcXdEc1dXNDVTclllWEFC?=
 =?utf-8?B?T2N2UEdIRjc3aUc5TE1zSXArNERtMFFuN2V3K0ZsOFEvU1NFWUUxZ3ZRZUpi?=
 =?utf-8?B?RFlDNWcrZTYzZHJDUTM1RHlQS1h1M2JtQTc2clVIRkk5VEZzRXVwU29JU0V4?=
 =?utf-8?B?bmVYK29hZWwwNjFjTmtVNzJCYktOYzZmcUxKWjJ2VnBuYVJUZWZlWFdQRVBl?=
 =?utf-8?B?OGlUWWVYOFV2TjJib1dncW8zaEJGMmdDWkJnYTltUS9yT2tlcjVoeVJHd25s?=
 =?utf-8?B?Z0JlMFZrOTFlMnlhTUJsQjJjUDZBWXdpSHhJaDJPMXRibE8zNDJwL0UxVVV5?=
 =?utf-8?B?VUp5NGVrMWpkYW5TVWRxT2FxQmNXK0VtdUFJM3FpTHpvZDQwNjRVcHRHanFT?=
 =?utf-8?B?UmREaGpBZnRISytOTG1pSVhrbllOYkRoeWxEVVNQM2IwKzkxcnl1VTNHcWlD?=
 =?utf-8?B?dXNDN3ZjV0JwUDNTTUpjcDl3ekdCRW5MMlVlRGo3ZThvZVlZNlFQQy9PL0RF?=
 =?utf-8?B?OWtWdTZ6VXVqSzNSWXRoaHQ4LzNXWlBXbXRMZTlCOFJ1UXNDQlo0U1lpcmg1?=
 =?utf-8?B?R0hZZGxVLzVmQnF2SXdPcVlaNzVqQ0hkSnQ5MmwyRGJndjZnT0psZmhMajZi?=
 =?utf-8?B?NTY3Z2ZFRXhCVEpGV0kwRkg0VDBiQngrazFycjREMldjQ0NsYnhNNDRiUDk1?=
 =?utf-8?B?b1psdjZDQXJ4N0hIRXZmZjRJSTM2eXNnSjEyZ09mZkwyY0JLWjF3bkQ3aFcz?=
 =?utf-8?B?Zmx5RzlVUXZBVkFBSzB4bmxiY2lhOUFTczJEcWFGQUh2Q2pxTm9zakdRTWgz?=
 =?utf-8?B?RVR5S0VLSnc5T3o2NklrQnphYWYxWlFaMExJOEUxaWx4ZklRTWJEQnVQcWZ0?=
 =?utf-8?B?OTBFM0J1bXVacWQwNDRFWS9YNDdsTDJCVHB5RG5NMy9RMlhlcmVxc05PeXM1?=
 =?utf-8?B?d0xza2lYVm9iWlNBWmhFNEhEb2ZZbkloSE04cTlnejBUMWJTWER0L1ZrVm9X?=
 =?utf-8?B?SkhzV2diNU1EYkVsNXBIYUV3N0l5WWZDRTgzMzk1ZmI4Wm9neExqT1l3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bktmd1dJbnE5ZXY3dHBDM2x0a3M3WkZhcC85QjhaWDNsVU1YWS9vbkJQSFFL?=
 =?utf-8?B?R2VnWXh0S2xuQnVvaGMyRWdTbThVSy8wZTFpTFdXNFR1aEx2a1hlSDdsM1U5?=
 =?utf-8?B?MEpHdW55RmFhcE1vblhsVzNJOVEwNFNoMWNpUklBRnZxRmphd1QrRWYwNGdK?=
 =?utf-8?B?RUw5T0piN3dwVmk4cDJrMEZMSXVQdDVBWXlYalpWdWtRcVZIT2tWWWdkcDlZ?=
 =?utf-8?B?OVI0K1BNQTNmRmdMWEYyUVdvNDkzSURwZmYvdTZOMXRTS3VEbGFra1NlaC9o?=
 =?utf-8?B?Vk9oMVZZZFBQdERIR0Ira1FuTFhrVDVzTWZHeTZFQTVZeFkxREFReUVRalFM?=
 =?utf-8?B?dnY4WlFaK0NFYW5SbHovZUducElTZTBrZk5xNDlydHdvVnZXTWpJajZ2N2dk?=
 =?utf-8?B?aGliNy9ic2lNM1NnUGhoQ3pkaGNMdXptM3lnR1pwQVdnWTdoZXVnbGRCRUtJ?=
 =?utf-8?B?VzJHSHMwN2lVV3A4L24yeEprNk9GOWIyejg3cGJtY2hKMTVaZkVQS2JyWnA3?=
 =?utf-8?B?VkdyemVvYzhROTVyQVJBN2duaWgxMFp4eEozeTVxbnNabkN6SEdGZlg1RDFB?=
 =?utf-8?B?U1lMRWw0YTBycGJaUW04WUkrM0NmZVl0ZlhzS1FwejF3MDVHTmhLVlVjYm1N?=
 =?utf-8?B?MU9pZVRQaXA2eitxc1kwbytzZ3h0eHhlMlBtZnBQaWpGQWpIQStMY2x1bGor?=
 =?utf-8?B?cGpoZkxzbkxEcThsbEtXMEM1OEptcWIwVldHYk82TTd1ZjI5V0lRRzd5U2o0?=
 =?utf-8?B?VHdNU3gzNkVyL0EvMUFJbEl2RGg3eUNGSHErQ1doVHo4ME9SRnJFNGx4am1R?=
 =?utf-8?B?bmtId0FKVVk4L0pVUzNsSTdwZHVoR3VielJ3ZFpZMVNkZmVSOTJNVld2dVRs?=
 =?utf-8?B?R0Y0M2FwL1drMFkrbldBNi96czlUNExZWCttb0tWc1hxSGMxWWw3bHdvUUlR?=
 =?utf-8?B?M2lPUGwzUnp4MzRxc0hZRkx2aEFIdnBHc0dqZCt3d3RCS3dFc0ZsUFMvalEz?=
 =?utf-8?B?RUl4L3B5K3huZFRBZlRVd0xyNy80YTJkSlRRMnFEUEhPa0hQQnBURVNIU3Z0?=
 =?utf-8?B?SFpKbDN2alg3cnNKUm90YkpCdG9YRTVjdDU3K1h1MEI1dWZBcHNmamwwTGhH?=
 =?utf-8?B?UVJFVHB0bUpKNUQ3RmZSQ1h1NzA3ekYzcVpyQkNOeTJ6TW9LRzBHc2lBSXQr?=
 =?utf-8?B?L21ieGQwa0xHWW1tejd0d1lOQlp3dm94NVVxZGtTTFBlRlQ4WHdraU5nWWor?=
 =?utf-8?B?Ymc1ZkIrNDdBQ0owdjJJMDlOOWFIWmhPaWx4a210d3hoeGFBM0tZMmt0UGhn?=
 =?utf-8?B?Y1ZQNm1wQnYzaGJoczVmNFVULzROQmxxYUZJZ1VWV1NQelJKSXczY21Vdzlx?=
 =?utf-8?B?SzJ1OWdnN3d4dU83aURqc28vcjBhK3AzMDdCL0hIekxhQnBjNGxCVEx6bjgw?=
 =?utf-8?B?Yzd4T0ZtUWZucEdnVkJ5YXpLTE8vUzk1OW14RmdiTHNORklsOFl0aFBRZXFt?=
 =?utf-8?B?VEdxWnZrczZQNFJDN2tsQWxKd0FTcENzT1YyVHdMbmt5bFoxVVZMTVBEY0dP?=
 =?utf-8?B?TWFsRFd6c1k2cW5VK0tldXdQNWR4NXcvK2w2OU1GU1NhOUczZzFydElrWlVJ?=
 =?utf-8?B?aFpqQ2RxWmNDWGYxczJYbnZlSGkwQTlsSVZKdGNWRm9JMHYyby8rWXJPYlVM?=
 =?utf-8?B?UnM5NTUrZWpCd3l1TzV4eDN5OUlnRHAzdVlYOHA2QkRqUmozT01ISVVlT0Vs?=
 =?utf-8?B?M2RDdEdNWnYyVUxGMEhhV0lpK213eEcxMWtCUVpNTTROQ2pTdXVpcGVWRCta?=
 =?utf-8?B?SjBZWUlUenRhSEJPOEtJNHpUZ2hHUHlML2VZenRGWXhBRUdpQW0ya1ovOHhq?=
 =?utf-8?B?UXBsSGdEZ3IxQXp2ZnczQ3gvd0hqS3pra2hJT0VKd3gySjBKQWZGNHJjN3dS?=
 =?utf-8?B?RDVISnhBbHdsakoyam12NksyRkhHMkp3eUhOcDlpZkcvOVhpeDBXV1BEdTYr?=
 =?utf-8?B?blZoRGlmRUJhSGNXLytuYzBZdDhNSkw5UEJ3Q0dqanZ2MmVhSGZVWUp6bzBJ?=
 =?utf-8?B?M2ZUam1PcDJMWTNpNkRFVHZqd1pGREpGczBUYXhXV1hVcTdkanRlRkJ2YldS?=
 =?utf-8?Q?IIrBCb4uTtLtTM85e+Xem5g8l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tI9Lw6Jax9jKnwPJWeHDeRdvktwltXA5D++Ezc/55cOnhXnyTYsxrCLtrYo4471DquGpm/dWZISkVOVYlk2Hqy6OKRsA+AM81wIAZQRDlM/oQEnn10cTd9RB8PZ6ZACOVT8leeq1O/WtakcIHLHG1d9O4sw9HHI6U691QFx8Np27CCQ1C/dh7OEa+Zyy/ipnI8rSfcYYe5S6aguOMY1td4OaKNZobywRwRgv7N5p/8rGHGnt2Glq6UKmLLYya+C8cU4lH6F5S2AbqWcXn/NaivqdJCkyDocJzoF2ISgMkZ3jo4nuTVUEOvMpDamwhLnulBopaqCOgBydxjiT/2aBMVPZm4lJBgw+rklZDWa6WX7dn06dR200MqZxPmVIj22JtQm4neUe/GZQ9oBH5mH34or4yBlRBcZGIhQROmBUbQq1m9n0WfTrqZWgoj06bnh8hkO4Z1SGlBQUEaSUWNU2OgYlHLDvVVxzem4OKVtx6tmAwDf9SzD85OVNgp38ZcR3Efi5LjZkIoky76fPS30y+T85OYta5iExzDoocVX31cxs2jUMrmY3XbhMtp68Fq+MYkJrO2NFLgFOf9pD7SbaF8kma5i7gIg1mJ1QKVFefKM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a40810-d433-484a-048b-08dc80ec25d5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 21:04:51.7581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBIchD0he2RMLGCjsQnb1MuyuRvMLToGkqQrpCWsGYxqX7n5lWbBWmqJXIwpacqpOdM3yxc9vVY8YLBnv87dmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7633
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_17,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405300158
X-Proofpoint-GUID: m6ufJLZu-cHdP3zTKTntZEA9JHiKp13X
X-Proofpoint-ORIG-GUID: m6ufJLZu-cHdP3zTKTntZEA9JHiKp13X



On 5/29/2024 7:26 PM, Jason Wang wrote:
> On Thu, May 30, 2024 at 8:54 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> The cited commit missed to check against the validity of the length
>> and various pointers on the XDP buff metadata in the tap_get_user_xdp()
>> path, which could cause a corrupted skb to be sent downstack. For
>> instance, tap_get_user() prohibits short frame which has the length
>> less than Ethernet header size from being transmitted, while the
>> skb_set_network_header() in tap_get_user_xdp() would set skb's
>> network_header regardless of the actual XDP buff data size. This
>> could either cause out-of-bound access beyond the actual length, or
>> confuse the underlayer with incorrect or inconsistent header length
>> in the skb metadata.
>>
>> Propose to drop any frame shorter than the Ethernet header size just
>> like how tap_get_user() does. While at it, validate the pointers in
>> XDP buff to avoid potential size overrun.
>>
>> Fixes: 0efac27791ee ("tap: accept an array of XDP buffs through sendmsg()")
>> Cc: jasowang@redhat.com
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>>   drivers/net/tap.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
>> index bfdd3875fe86..69596479536f 100644
>> --- a/drivers/net/tap.c
>> +++ b/drivers/net/tap.c
>> @@ -1177,6 +1177,13 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
>>          struct sk_buff *skb;
>>          int err, depth;
>>
>> +       if (unlikely(xdp->data < xdp->data_hard_start ||
>> +                    xdp->data_end < xdp->data ||
>> +                    xdp->data_end - xdp->data < ETH_HLEN)) {
>> +               err = -EINVAL;
>> +               goto err;
>> +       }
> For ETH_HLEN check, is it better to do it in vhost-net?
Not sure. Initially I thought about this as well, but changed mind. 
Although the TUN_MSG_PTR interface was specifically customized for 
vhost-net in the kernel, could there be any userspace app do sendmsg() 
also with customized TUN_MSG_PTR control message over tap's fd? If 
that's possible in reality, I guess limiting the fix to only vhost-net 
in the kernel is narrow scoped.

Additionally, it seems just the skb delivery path in the tap driver (or 
tuntap) that populates the relevant skb field needs the ETH_HLEN check, 
the XDP fast path can just transmit or forward xdp buff as-is without 
having to check the (header) length of payload data. That said, it may 
break some guest applications that intentionally send out short frames 
(for test purpose?) if unconditionally drop all of them from the vhost-net.

> It seems tuntap suffers from this as well.
True, theoretically I can fix tuntap as well, but I don't have a setup 
to test out the code change thoroughly. Any volunteer here to do so 
(test it or fix it)?

>
> And for the check for other xdp fields, it deserves a BUG_ON() or at
> least WARN_ON() as they are set by vhost-net.
Hmmm, WARN_ON may be fine (I don't see userspace is prevented from 
fabricating such invalid addresses through the TUN_MSG_PTR uAPI).

-Siwei
>
> Thanks
>
>> +
>>          if (q->flags & IFF_VNET_HDR)
>>                  vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
>>
>> --
>> 2.39.3
>>


