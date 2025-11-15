Return-Path: <bpf+bounces-74650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDA0C60439
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 12:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B664A3AFD38
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 11:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5114296BCF;
	Sat, 15 Nov 2025 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VmvEc6qb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gh/DvLN/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ECB284682
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763207237; cv=fail; b=KMsGXAe2pddbIOkKvrg6cTAqjcUxzCWyjSPHhNt59OvG8wMIMzfT+a+r37vPXIlbnvi9WIh7jZ0kIGJBiGS5KdH46xkxPf1OfO1w1ZhOwQNVTYRHyJDrpzZVCJfUzayX/3dx4EXlHmT6m+RZAN2W8OuQy1Q766rxjKkwiFDsYBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763207237; c=relaxed/simple;
	bh=HL6KmOUZgT///gRUzfdBWmkeKrdCu7oQvfcbzbht1XI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y4PldAYjr1/VjbMVxRJBXz9ICr/0MF9l9u84s9aSId9yk4CpJfha8yYnF1TS5atNXZtz0JhgO9c0+qBa60ffVZ53qjBoPUQt54FbwZbiH7wDlMz5ohWGYsav/nXhZpXfoC6iI77qf261mfGlwuIZvYzu7O+9X6xe65w7144Cies=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VmvEc6qb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gh/DvLN/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AF79Wlc004570;
	Sat, 15 Nov 2025 11:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aPWLtCCTj2VSm0w+IE31cIai50ZknzI4JhQjDYcCExw=; b=
	VmvEc6qbhCW78Rr0xzg5rBXJawkWGNZxZd99tujJFjJhq57XrARN6FJlHu/kuEGS
	3jXQQkK6ScKfR6Sqm//taBeCI4r0ymAnbLib9mTVzPN/UdRwoEovPglcG2sWGozN
	KHB8jgnL0OYJH2Q6iQb8LYjUDgDfv2XVp08HIFvFRtSewbIxmgjZ0bEN9Edp/phO
	wtWI6magSv4awjhagXDaNgNMPrOxauxqf8djOINGZOhM7Up/Jn9/3+2cVA0WjYPH
	LcqCjqI4s2IOOc8gB8Telgn/SNX7e89uqBQCQZ4Aa2nDfTRDKuccrAgJ5YAeWr9/
	8jsVK2TpXIByxBrgVRabPg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbb88fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Nov 2025 11:46:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AF78F1t039885;
	Sat, 15 Nov 2025 11:46:41 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010041.outbound.protection.outlook.com [40.93.198.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyga067-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Nov 2025 11:46:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAweWqdBMq+FBh7QIicZ3E5zNOskzmjyowGDRVgKIb96RFxmhxe31WQAa+Pv4GRKlWyaULeb9mCt7n+JHqWyPeX+QjFw+es0QD8tGeQEAuH3Luch9ZN6Dq+TS8u4ORdUFUVaesUfBnRrRLNLJCongz3T5U37PKOqQMyCoDvVgQWMgv44XL/JuRUqhKnFvR0fXB5cPcLkd1/ied+VBJboOi52XwnYQ+/xU2u33Cyab5WIMZqrJqA6M/l7+9sHebKm6Xk4JcqrspLThuYNlYx6KXCItfhd3kQ4jA7HE46OkWT8BOZtEu/SvYqrbe4OagG8P+cR1VjM020plXSqHKQNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPWLtCCTj2VSm0w+IE31cIai50ZknzI4JhQjDYcCExw=;
 b=L8WschC+dBSGKz2hQWbDHgbrZOwNPgBxHWEeqiDwc4514zIEx11AZ1tQ7s5JaFisYTTuOdZ3n6OhGsLiqDhuJaf1Liis3BpwMBseS2wzx1n7LHMSe3h0XXP72dkpnhTd4PUa/mC/6z8TPY/Jqmki/397UBYO8+6XIEWkPcqlOcZAgUsL8CjENwStGe1k2bwEdzoZOXJAJsDTvXFn8BPc4XrqJYs6sw8qyL+7UsLHqc9S9dKe2iW48uquE/HCE27ooBPxKmgY5GRjKZe8mz4xc0Dhbs3BpOSIaddY0uq2EEZckLCMteRyhHCkDhdZEkO/DXpiLW5zIFdx45fLLt0ebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPWLtCCTj2VSm0w+IE31cIai50ZknzI4JhQjDYcCExw=;
 b=gh/DvLN/Skl7C7J9N0boytNOz3Ywm6NNpVeYIIWaNPlLSb2ukcZTlHMy0YvdQl4kAP+K+AfU34lApEKX5+IAxqZZ7CvCao8yki9vbZVvGBOhd2L+LX6FfjCb8R7yyXBUlZ37qKm+vZaUmP/MwCyZvCBwyriAwuLNPHgis8M4/LY=
Received: from CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22)
 by SJ0PR10MB5719.namprd10.prod.outlook.com (2603:10b6:a03:3ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Sat, 15 Nov
 2025 11:46:37 +0000
Received: from CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884]) by CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884%2]) with mapi id 15.20.9320.013; Sat, 15 Nov 2025
 11:46:37 +0000
Message-ID: <a1a17528-cfcc-42e4-91b1-1004a1487f6e@oracle.com>
Date: Sat, 15 Nov 2025 11:46:26 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Allow selftests to build with
 older xxd
To: bot+bpf-ci@kernel.org, qmo@kernel.org
Cc: kpsingh@kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, martin.lau@kernel.org, clm@meta.com,
        ihor.solodrai@linux.dev
References: <20251114222249.30122-3-alan.maguire@oracle.com>
 <ab8f0f2626eea5beee45b6c6418f976a3cf060aba80320d0d9f13ebb814a9436@mail.kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ab8f0f2626eea5beee45b6c6418f976a3cf060aba80320d0d9f13ebb814a9436@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::11) To CY5PR10MB6261.namprd10.prod.outlook.com
 (2603:10b6:930:43::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6261:EE_|SJ0PR10MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d51a309-83ca-4849-7ffe-08de243ca229
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aE5pc0NydmxzbURLOXE0SE5acmFTdzVrd0t3SnFxUEdjb29ETHNrcWNLdERv?=
 =?utf-8?B?ZXJnNTZ0ekJMd0l1d0FPVW9YSkp4ayt0Zm1BNHRIblJXblpSVFNUN3d0alI1?=
 =?utf-8?B?MFlPaTlYTHFNZ2ZSYXBaQU5uZHBiUTIvWU84djhXN1Bjak9TK0xwYktMRS9H?=
 =?utf-8?B?elhFT2xyVXQzWDdTK3lRY3BJQW9MZTRmRGZkc0Q1RVAxUVJZdzhQSnQvMHpN?=
 =?utf-8?B?aFVJYmE2Q1c0TFc1Y3cwc2Q1WDV4N0dCWFM1VGtHT2YyQm9oTHR6Z0lRRjlk?=
 =?utf-8?B?ZnNwbTlVeVZwZ0wyR0RkYUgrUlo3dkJDckRXTUhTYnZiTFhhaWgxUmJKSEpm?=
 =?utf-8?B?UEhEOWVteVl0cW41ZDV5L20vczlaZm5ScXd2TlFjM0s3VkU0QWFFUndTRWZU?=
 =?utf-8?B?SW0xdDlDVnpWcWpDMnd5QUZ0YmZJWGhtQ0dPVzUrVU1TMFVMYUZDR1dvNXFx?=
 =?utf-8?B?U3F4WUh4clA5UTF0Y2RqRy9XSzVPQklkREpEa1pkUk5oTnBwS25MS3gydm9R?=
 =?utf-8?B?NjBkdHFqVW9GY2YyaW1uS2c1Nk1lbFJhTS8zV25VSkhTeERnUWx4a3FrSWl0?=
 =?utf-8?B?NnJ3QU5RaXE1eXQ4azdVMklHK3BlaWVDc3hrYjZydmZEekhJWjFueWFlS3pQ?=
 =?utf-8?B?cUsvc2hxSUM0VVRyQ0F6QnZtRzBZVmpVaHZCcE5PYUh4NmV5dzh0cDVmS3dj?=
 =?utf-8?B?V3N2TGhhRnF4QmZibUx6cHBlakxuYTFoVnJxdVlETXBvdEhxeUx6N1dZMlps?=
 =?utf-8?B?RDNHUWd2MThJam8rbWhyWm9WS0taMXVDUlh1OHZOVXp0WHVXNktJREkvemZE?=
 =?utf-8?B?Sm1sQThVSTNvaFpVK1lUQ2tQMEp2QjZPRzJ3ejArUGdZUlNYTWE4bnZQLzJW?=
 =?utf-8?B?UWRpSmRzSkFoSkxwaGMwWkl5dWlxSHFnc1h1VFJnbFBBaWFTMC9YbGEwOXVD?=
 =?utf-8?B?QkFtcGNOMnUyaldwQy81cStLM1pzbzYySnkxWGl4K2V5UXM3VkwzMzAxRm1y?=
 =?utf-8?B?WjFwd1lMWUE4bEc2ZjVqUXBjNDY1TGduU3Z3WXZSR2xpOEFNaS9LRHBod2FB?=
 =?utf-8?B?UlRQc0M4emxoSFdDdjFKMVF1Z3hWR3UxV2FoZmlBS3NaZnVqTnZUK1o0MlQ0?=
 =?utf-8?B?WGVTQzM4Q1BxVVVBSm8xc0pVR1hEWjR4bkVWZVRXK2tjbEZSempPVnhoekx4?=
 =?utf-8?B?c1ViR1J0SHdmWmNvOE1lOGtVbzJGd2VURHI2dUtBT0lFVVJLeGNpazZ0SXFD?=
 =?utf-8?B?WWphbjFoUTRrQVF0UHdsdkYzekhyK2REMm1pVVZDKzVsSlZBZ2xIWEFGTWtJ?=
 =?utf-8?B?Q0JCNGFUd2tyOEw5TW1Kb1FXbHRxdDN2aDYwTFM1anVYYm5TNUZCNU52WElo?=
 =?utf-8?B?Uml3MEZCVGJPRnZkVkwvZnR4eXpvL2hxRWhSUm5COGdKZjdDVmd5ZW5GenAz?=
 =?utf-8?B?NXk0amcxdVdYbHdyT3lTRk1kYnBXaW4reC9lRHR4N2p4czhsREdkL1lHREth?=
 =?utf-8?B?eWV6VW53THZMU3VKTmF3OFRsaXdBODIycHhjYkw2dFpnM0p1Tnhoelc4S2FG?=
 =?utf-8?B?aGpGSVg2bmxpVU5hazZSd3dFR1NoWkFwK0JLT1lDVkpwT0dUZzJXZytVRGcx?=
 =?utf-8?B?aUxrUEVtdnpwdTY0N1ZOSXh5STgydU1WUlUzajhsVlRtSTB3cU9TYzJWMlNB?=
 =?utf-8?B?UHBxUVRwczZIMC9YcUczbHNSMUIxaVBDSjBmcncwZG9wWkhRWE5zRThZWFNB?=
 =?utf-8?B?RGFSZDFPSXVEeGsyTVIyck5OSzByT1c2citTVndHRzB4cTZFdi9XNnpoK3FS?=
 =?utf-8?B?b1ppYlNWdENXS2tqMWoxT2F2SFgycGdFaE9iRnl5SHp5ZVozRkRjclhPenY0?=
 =?utf-8?B?SHNHT2hQTzI1RUMwa0lxM0hYU3phaUlTRy9ETUlDTndtdUlRS283NWY5WFRq?=
 =?utf-8?B?d3A3K2UyRis1UjYwWnc4aFpnNTRaTHYrMDVXaWdNY2REK3ZjTzBpS21JZnJo?=
 =?utf-8?B?R0xFNnlHV1lBPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6261.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RUY0U01pRkx3bXhWZVh1bEozVEp6OUorK3YyRy9Nb3BZVlU0MktFRDF2S01Z?=
 =?utf-8?B?OFl1Z0t0bDZGUDl1WWFVOUlJdGw2bk53NmtEaE92TFhVS1g4V25tL0ExZnkz?=
 =?utf-8?B?Wkw0VkRLcGEvZGFaeTgydDZiN0xTZ0owNjV4NEVCTDJCc2FJeWdTV3daOFBC?=
 =?utf-8?B?WmlnVUZZYXJod2RyVzJkTHZXT0U3bk9rZWlFUDNCK2JHMTYxWGZyN1hiV1JM?=
 =?utf-8?B?Rld3ZTZwNUlPYVJmL2ovanNmcUFibVBvRWlBcCtFQ05EaDk0ZVhwa3M3WG9L?=
 =?utf-8?B?YTNrRUlOVWJhbldCL2NUNFVuK1ZmaUdPTlBpcDZKTE9vSzdnaDJZRmxYWlo4?=
 =?utf-8?B?aGNoR0tmU0ZibW5FVHB4cG9kZEk5Uml0U0VrQXgrcFltbFVpclB6ZE1LUll4?=
 =?utf-8?B?OHVyYzloK0U5NG1zQUo0WjJPb1Q1WmU2clkyamNBZ3Evb2trSUJqWXpCYTE4?=
 =?utf-8?B?Y1pLZHJKcUFjSWw2dHplQ0dlcXhweFdvYkV3cFFtQXpNVndDdWJtKzl4Ykd3?=
 =?utf-8?B?aUNvVVIyYzBHdmZlYk1XSGdBb3Fya2FBQU03d0JiWTR4REs4Rk9GTTBZSTQx?=
 =?utf-8?B?M1VDVFJCK1B5eUc0WXJRdjdkSXZTTExjVUpwaXl2Qkx5Q0x6Z0RZOU1jYzdQ?=
 =?utf-8?B?RGRtWUVqUGpXeVBsV0RDUGVNY0JxT016SkFTMzBybUlNNElLTnY3MDhQM3hM?=
 =?utf-8?B?YzN2QllNdUlyZDUrZUdhT2RJQmlQN1VNeFVkOElEVDIwVStld0Rkc0hWZGJo?=
 =?utf-8?B?am1NYzRkTkFOcERZQnA5Tkt0WloxSTd5NXJIbWVGZ2tZWjJZQ0lSQldNU2pL?=
 =?utf-8?B?UEwyVVZXeDdIeVkzcitqUlhJUWk4eWJ2cElQaGNQa2l3US9oVWhUOUZsbTBy?=
 =?utf-8?B?dHF6RGtRQnYzNVN1ZmVCYTlZdzQwUG9FNGx2eWtFMGFwOVFyMnpvczZtcUwy?=
 =?utf-8?B?YXVaSmc0UE13dXhRb1pmRlV6YmxzRWt1SW5zYzZvN2k5bjlOQTlUdjl1ZWJU?=
 =?utf-8?B?Ym11TzhKamNDVWdyenZOWlc2RGJNaU41ZzdsUU9pYktxdkNIMjhyenNpcmRT?=
 =?utf-8?B?cStpMTZpcUUxdHJXR05sZzA4MnpxQWlQcWxXbGZZWEZNeEREbk5kOVE1MmVC?=
 =?utf-8?B?cVVHc2daRW12RndCYTBmaU45R2RTaXBqeWN1Rm8vQ084UENpRXhKTzM4QnNU?=
 =?utf-8?B?ak54VFVwVTFpUU5PQk95UlBlczIvVlpQUTQ2SzM1U1dQTzVtREt0dkJaYUta?=
 =?utf-8?B?amxrSnJZQjBCOUx6V2dtQ1VIdWplaUFoSnRoZjRET1RhenhsRitJeWZ3bThL?=
 =?utf-8?B?TE1EVktFb0xIMElTTUlMNHp6OElLQllaSEkzVDFiTFFKSnNpSndjS0I4UXV5?=
 =?utf-8?B?K3l0Mi9DaThET1N6aUVnYjNwbE96V2EwMVRCTWcyOGRhVXFoczYzVG5wZWpW?=
 =?utf-8?B?L3BCU1FFclpzYTZ0UWxpeElCQlhPNkFWQVBlS1JzUlJITEUrbEhCa2pLeHVJ?=
 =?utf-8?B?aFZQcUZUbzAyOENLdW84SFZPSWdRNnBUYkp3T3ZwdlcrZ2llT3hYRmZXWWxq?=
 =?utf-8?B?QUhISStuZjZ2c2RnS0pxeENhaFVReTBTYllZY0xOZ0VRL1c1N0U4QS9QcEZE?=
 =?utf-8?B?ZGxMVFhXVFRYVFZHMkRoNFRZamFkY2NpUHVnUW9OQWFlMTRiVFNqZ1YvRVFS?=
 =?utf-8?B?K1FqbzA2SC95bUlmSTNNQXd2N2RPOVJranhIclNuNmdWcDQrN2l3N1UxaGNy?=
 =?utf-8?B?dDQ1MW5Iak1OS2RnaFdGSkMxQUo3RWkvSkhDWmFuOGtEVEtySC9yV0JZNXJM?=
 =?utf-8?B?MFRyWmhKSHZRd2h4azZON0pYTk1NeVZtSUFNLzNoeFZ5SHVYeXZSUVc1SktV?=
 =?utf-8?B?UmVNZDRwSGl3SGF3aldoMEs2QkxDdk1Idkd0S3d1eTNDTXRLWGtaUUN2RHpX?=
 =?utf-8?B?aWh3SVd6OU9ySm5ZN2piZEFGVU1VUWFua0tSYXNVei93V0lCOGROeUdRNElH?=
 =?utf-8?B?elVWWlRZTis1SHhUbFVRQUxNblU2YXhDQVdwMmZPVHAySFV5VG9NZjdRR1du?=
 =?utf-8?B?aTYzZ2ZwWm1SMi9LQXhYbjRtRm5weFUzUHlrRno4TzdFSXZIUVh0ais0NmlE?=
 =?utf-8?B?aUxJeW0yUXdudHNuSlFBcU9hK0VuOHU4UnhRUHRCbWpUaEtDL3BlN0M1TVlT?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/0lUiHwDqzQKp7Xp7VO2WpBqpD/WZLTq/3BLcAHTgs2B0tvNqtav2kkrbQsSOvuZ/Vy7qq8I2MQXLJYhdeSrLsHHV0YxuwfZjAv7fP9M2hB9kFTsi5x7BjLSygEoCebcUnslFmWLSuKbmv6yh7nZuMhQw1zK2Ba+nPA6NJbdR/YfiBt+tbJOMmRFDC3/02wRxn3zM0BDTLRCqwy8I4gpCOhGRQFVrO7UeRRW1Lg+wvGnfUBD280W8qPOLZ0w5yAjz0vww5FQ6Ft28bnNF8xFOtLcJY0NBcocUUHmYlSM6RiPwpWROqKk+NJLkCQhu7SP0bVhZ3RWIDxeHXf9WvAsVRUmc26XSC3NAcFSYgX8ASTt2/nA3G8IP4kVooi7hvWeKvIVCojU7ZUOuk615b4mZpJa3UoaE8gImc0RP8/KoM8HCwa5K5n28noPUSCi843CIPpx67QNKtI1DqzoSv/sOeHYDWpAl7rsZ5Qq82nLJqJIm0ZioA23FePJHrP2BMFe3ckssBtK7VSWDweNVF203iG+oQsMHioTg8rId1NIU59LlgbUjvhNWIfoyAfbcqud+OFDHAcNDVbiSoVWLbjgpRyM0yMCnB2kobnWV92eBTw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d51a309-83ca-4849-7ffe-08de243ca229
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6261.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2025 11:46:37.3663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07Bt5/7OhRdk9SSS35RU0tgI90Tq5hwLjuE5kqNe8bzbaNj3C3B9Z8LAgHtlA5Nolr9dBwyBzVDokilvcqiqcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-15_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511150096
X-Authority-Analysis: v=2.4 cv=BoqQAIX5 c=1 sm=1 tr=0 ts=69186822 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iFABrAoMAAAA:20 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=2KBfq5OqsSkSw8uMTxsA:9
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: iB1BkQO-EVcFDQpn9jzgnl8qXh9qyBa1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXx22ZGfJqxWP7
 suZBYqeOV6LdS427eDzUPMyt9nXLpgg1Sxs0qMn0Q5imMm4wP47ZOxZ57VlLauINN68//vpZj9l
 mu90aVgBY+BQdctlTta2yCyzSEpTUYDS6DWJah8a+lBw3AD+phabHkgtcM7qHQcn998I6W/04CB
 BIUz11F78l7fGMdeyfSfqCIlDLRaUF11qFElMxV9LoCpvyvsuyI21uztrElxYyG6G/PEM9IZcjK
 Nn+ZfhIq5AiTQu5vNKWHrBHAsZNg/J2OvNPDq25Oju0PsOFos3YfWt6dKdTbdgzlJ37b1vgPS6F
 JnlVHCd8Cibf+hGDmExSemR3zELaFPqfvsqdXiTcRGZTUNKd+7zZgU4MwzuuYHp6coYKBMlkwuG
 fCCc8sf4tHXoFI1u7haZXbZLSyKBxkrLkzhdyLz0Ey/S2ZnIUvs=
X-Proofpoint-GUID: iB1BkQO-EVcFDQpn9jzgnl8qXh9qyBa1

On 14/11/2025 23:06, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index 34ea23c63..8687c17c5 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -731,7 +731,8 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
>>  	$(Q)$(VERIFY_SIG_SETUP) genkey $(BUILD_DIR)
>>
>>  $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
>> -	$(Q)xxd -i -n test_progs_verification_cert $< > $@
>> +	$(Q)ln -fs $< test_progs_verification_cert && \
>> +	xxd -i test_progs_verification_cert > $@
> 
> Should the symlink test_progs_verification_cert be added to the cleanup
> targets? Currently it's not included in EXTRA_CLEAN (lines 903-909), so
> after running "make clean" the symlink will remain as a dangling link in
> the source tree. This will appear as an untracked file in git status and
> is not present in .gitignore.
> 

yep, adding the symlink to EXTRA_CLEAN in Makefile and .gitignore is a
good catch; I'll wait to see if there's additional feedback before
sending a v2 with those changes.

Alan

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19379374420


