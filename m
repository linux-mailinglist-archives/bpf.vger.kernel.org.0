Return-Path: <bpf+bounces-75246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CD9C7B4CD
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 19:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962983A55F0
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 18:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658573502A0;
	Fri, 21 Nov 2025 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rAItYthZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CfIl91GR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BD920C463
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748946; cv=fail; b=opHEtzdtfyMiC66TtBWb0gU8lJI1QyYRjRn3BP2BviC5kUm5B3s5lXaMTwH+p8ybM0qgVYz5SjnmY2EkFS0iAziFppMGocWn/F1yeFU8iE8ExInBfwLEZRqVZZe8GNvZo5Wq9eP2Gh39/frguYSgLyscrmQ1B5E2xz3QIUl90WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748946; c=relaxed/simple;
	bh=Jmhi9slJoF2b/mQLqjFO2IRkzK6+oedpnV7QIhIyB0o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=McaceEkXNqAygve3GjJlnN0x9/LPCHM6eq77wczmb0y6HDTii+RA1sC5PUUpIlBZwYBZayvca4eiEYAnhMadNOYtWO4kSI2JN0MqKuZ7jZir8znvBKNtr/DouRWqiX6zklWeolL4lpNWOo4wB3yKiP8WB5zbjM+7nCT5K15Xsac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rAItYthZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CfIl91GR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALEhN2J008271;
	Fri, 21 Nov 2025 18:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Bet54RRhouBb2jThkFtroHaRcuTx03jFTWrUj/nNc6c=; b=
	rAItYthZy2AZ+fEDlrto8D1is57cepKJQPq7/nXyCWLUOXOlcYvLSpeUbiPkTCXH
	nTdWhAI7lrCfYQVZqjsOqFzJ0SwjzlD2hbQJ6O48TnTHLUr54MwjDOXXiPeG0VL/
	kwbd+NF/p9JEDkwtfka7tTeZuYggNWVzjdlGo9cEMk9txeoBU4hyxbvz7N5ymae6
	K/BA/RDhjAuf95UDW/hREIDzXdHrWF4oEfN9wG8xXRf7NFXrEQP7hHBJvmCY41yz
	/qGlKaiCMePfTlgC7c1BKonINkwNXw7rllm6F4P7GBP7jfuARsgwgdCIYauzYLco
	T8u6hn0Pn10rztGLloP3zg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aj5dttwm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 18:15:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALH1oOg009651;
	Fri, 21 Nov 2025 18:15:24 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyj1skm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 18:15:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/iPBA6gnoLYJLNp0/zBUszJZJQjWjS2UEbqHtSXiNGlH1qiLnEEH4bu84XiOl3zGy2wZy9JCOTaC2AVYhUqF6NPTD7Txc5r5OXYl77Kw1dlVX4i0YhfO4dzy9hBVQ8t3/r+NROgRBoeZj4LqKLHzQN0WpQdw67TRpZoy1KUrfYpG502ook5li+/4n/P2JGCM04AgRvMk2nJr9QFAXmRPVBieGP9B2yf+GZK/QVIJcOm/iG5rHwioVEAsZgRdhyjrqD0a+XDeNdOXfSGn8HR55oBDUZswBHQMYtrFEFCi7SkiYSHF1Eq+901AuKWEAemKagkJ4LIiLOEQr+7AaVKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bet54RRhouBb2jThkFtroHaRcuTx03jFTWrUj/nNc6c=;
 b=KM/J87xsKJRn8JjLRmHetdEKcV+2VQ9can3fIeS3RBme8s8SD2/zi7lr+2sm0SMDsObwI9nOejhGDGbzRP/yKK/b085M5BOOyBRtQNU8xGjhRrRrpSnekQdGAwUFK5Opbzks8Xwh+4+6D/tPpGvX9WkJQs7IOUj+Jx+gC+TueGsgnTu4gvUQefaAzSXWmTUns5diAmjmKJ25JBG4zZVMgW8hs6VQvIuy4NK9zaabR5IiiddZBI5W8e6nvb9hKU9q63e96X7QuyO3U4JXv7Yjs97EyJ/JmJmFYQfsn078k1P6DtBfful6T5xP8a39lGvMrgCGuMd1HYvNRza/1HtB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bet54RRhouBb2jThkFtroHaRcuTx03jFTWrUj/nNc6c=;
 b=CfIl91GRouVd0IXA/e7wrbdIkmMeFsf/ODmRzARgXCpPXlyhut3LphOKv3GUZYmjwHiOfP4sAQu8vlNPkUHATdCUlWJJjlMELZ5fxbgWgDMm2ylsmgizfAoWRTj3OI+7kfAOSUucajYtpxUeh2RCraIHVydumPZVNf95tA3J7Dg=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.13; Fri, 21 Nov 2025 18:15:19 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 18:15:19 +0000
Message-ID: <b427abf4-9bba-4ecd-b3a2-dcb220d51f98@oracle.com>
Date: Fri, 21 Nov 2025 18:15:03 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel build fails if both CONFIG_DEBUG_INFO_BTF and
 CONFIG_CHELSIO_T4=y (was CONFIG_KCSAN)
To: Bart Van Assche <bvanassche@acm.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Nilay Shroff <nilay@linux.ibm.com>
References: <2412725b-916c-47bd-91c3-c2d57e3e6c7b@acm.org>
 <d296ec97-933a-4b19-aa75-714e69b3ac4f@oracle.com>
 <7161e3e3-7bd0-47ec-892d-72a58b06df33@acm.org>
 <87641066-a837-41ff-acbc-9f4453d0ae58@oracle.com>
 <b8e8b560-bce5-414b-846d-0da6d22a9983@oracle.com>
 <aR9YasvOhnSI564i@chelsio.com>
 <bc54daab-3b01-4a25-8032-52a123fa823f@oracle.com>
 <452a2c4c-e9eb-40a0-922b-a1b99048ee08@acm.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <452a2c4c-e9eb-40a0-922b-a1b99048ee08@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0410.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::19) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CH2PR10MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ae871c-134e-420d-7607-08de2929ed96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzFLRzVKUURYRjRiU1pBY2FuWlczNjExaUdvT05LTzErTUpRVHVEUVZwenBs?=
 =?utf-8?B?T09aMHlkQURqdEZmc1JhL3NrVGFJVkk5TmZaYmdIdGxXaU5KMTYxRUhXaGZD?=
 =?utf-8?B?SUFkcTRycjFOcnlXMWl2NE91M2dXb3dLbmNkQlkvQlllZzZWTnZieEs0djla?=
 =?utf-8?B?aWNCVnRSSFY2OE0vM3dIb2k0bitYaXVRV2ZPcVp0Y3ZJWkpJOGM2WEJ4Zm5S?=
 =?utf-8?B?VlZReWtjMiswMk9QeDFjY1EySEplams5VFB0WGVlaUtFbWora3dXZ3VKeXo2?=
 =?utf-8?B?U0kzUFFSZnVZdUpjVStDNGVqV3pRc2J5QXZHZGY2SjRHYUI3eFZwNzJVeThw?=
 =?utf-8?B?ay9XaVRqUjc1V2JOd2Rjd3Z1UFFqZ1pIem9MbVk1SVRpM0lWa3V1VWZqcTNE?=
 =?utf-8?B?U1dTUklTZzcrTXE2cXJQblk2NkRCUnp3OExnL1NuejV5M3Q2dFNMeUNJQ01N?=
 =?utf-8?B?dnYxMlNzdC9vOU9ZcjhNZERRS1VvQVQ1aXdTbTB5dHZkUVlpR0xpcjJzMlM3?=
 =?utf-8?B?T2hmOGZZdGQzZUlQVzhIZ1VoMkJadjcyL09DdGlXRGw3TlpKVldhWnVadHNF?=
 =?utf-8?B?MVNOeDZLUjAxVGFVdUdCZXpmaEM0ZTloV1FsOHJPQmZ6OUZhWUprNk1QNGpG?=
 =?utf-8?B?UkI0VkdOZmtSaEFmd1prWUMrTXc4ZEtXTXltTk91bllxUTkvUmE5aXRvTDU4?=
 =?utf-8?B?VlNUTGlibkV2ZVBaUmtyMHMyYlBYUlljNnlSQ0ZyS2cvKzIrS0huRWE5aDlz?=
 =?utf-8?B?MjAzV25XWXZvQXJad1h2bTVFU1k2VXZlS2JJN1hDNmR6TmsxYW42ajlwd3Vt?=
 =?utf-8?B?SkMwRytCOHlLazYzWmJ3SGtUUTYzSk9Mc2NGcFBMY0pyUlpvWHFqRHkrVXpt?=
 =?utf-8?B?aSs0VnZjMC8vcjVFamcvVE5HbDRKRWtiemF4NjlhdzZ3V0xHcUYzZEthTk4w?=
 =?utf-8?B?UlhPWERPb2o0S0lDM0V3UFowY09ONnFhQTBvT3JJVnUvMGhzRnhWcW8reW9a?=
 =?utf-8?B?YnNYR01XdEdKamxGbVVnYmxIR3NOcGZtQmpjT0tWK3cxNHBGQzN3UzJVcWtU?=
 =?utf-8?B?NHJjTGttaXgwMGpYcGhNVVBYNDVPSlBWcHNpN2hFMHkxeU4xdkJqMGVIVVp0?=
 =?utf-8?B?N3BEK1lFWXcxQlZwLzRCZ3FSdkFMOGtxWnAwOTVWUXdZdUlUajBreUhQc3k0?=
 =?utf-8?B?UGtpRyt2RGd0ZzhwbkZoZ1haQVgrOUZpcXVJQUwyRXN1R2JEbzNER2FXREo4?=
 =?utf-8?B?Ui9kTzZxUjZ1dlVGSldycjltWDZSbzNaK2NhTFZiZWhNNzhpZG1XUDYvc3Np?=
 =?utf-8?B?dUdBMEJ0L0ZIWTFxSE8rUk5rUTlFV0tNclNzN0NmWjlQV0N3WHQ1eW0wNnVZ?=
 =?utf-8?B?WWJtRmhLWDNMY3RydGJoRklGUTR1Y1pSQ0FIbG9WSjFQcmxuMllzbkVQRHRW?=
 =?utf-8?B?THBNWGZabVRLVy80OW14RktnaU93N3luMVRpS3JabTlEdlM1ZDdxNkd0Z3F1?=
 =?utf-8?B?ZG1FdEtSbk1GeVVsYUxlb0hnb1YwakxVd3Jvd1ZnZlNlWG5UM3N2dmFRNGxt?=
 =?utf-8?B?d0RXVE9ZVzFsS0c0MmFuTGZpa0prck9GOHBzNW0yWUF4QjFGQ1ozaHNLcXBO?=
 =?utf-8?B?aDBDQUgzWWg4TERTQ01xQnoxN1NVOE9iQk9pcWpYaDNqOG9JMjMvd0RHQlRh?=
 =?utf-8?B?cW5UNnVmRDRNUm54WkMydkF0YjVocFhRK0FiWFV6QzhHckFFeTBzY2ZOTjNO?=
 =?utf-8?B?ZTdVWHc1YysxRHFQQ2dWUWNiYkR5MkNXOTg5eVpUaUFBMlFJdUYyL1hsaG5j?=
 =?utf-8?B?a1BNZE9qZ1B3N1FKRVRGMjZWekZHZTdSZ2twTDQwQngvSWx6Y1Y0cXhnNVVC?=
 =?utf-8?B?cWd4Tzc3NDJOaTQxLzFLbXBSZWhqK3g4Nm43dzdMa3p4SFlJS3F4bGhCeVRC?=
 =?utf-8?Q?wAgb4aOzdjKImX0D8JOw4KxkDTJ+41Gd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHY5aXNZODFIb1pOemt0ck8zMHdEUVRHblR1TWlqdEMwR2ZQVHR0MGtEVXpL?=
 =?utf-8?B?QnptRndYNkU1T015K0Y4Ni9kM3dEeXZuNDZ4KzVzNEpQb2lpd09ZVDBoNUN0?=
 =?utf-8?B?dXJ5NHVuWDZjaloxTkhDUW1ENitqMDlrejJqMU02dUlMdFNtSklhdDk2eVFT?=
 =?utf-8?B?UnNxRk9rMGtwK2JJNDVjVHdtYzRYeWRmOWtYelgzamxlRXhNbDV6RjhvTHRE?=
 =?utf-8?B?U2wxSDZkNlE3OFRTLzdMNmZnVzhjcWtrYWVyZHRiTFptVWxoOVpuc2xKQ1F4?=
 =?utf-8?B?bVJjenJ6eCsveENnSHNURTJSd01iaXhpajU4ZS84YnZDT01QUm5iS3M0VmJE?=
 =?utf-8?B?RjdFS1hGY3VZbkVaWmVWbjFJYjYyQnVqTDI1ZVhaZ2Y0QTkzeHNwTjF3ZE8v?=
 =?utf-8?B?RUR6aENWQWRMeEdLTytDbFVJN0JidU5GTVNURUVvMjZVdDlUT01VN3F5UzBQ?=
 =?utf-8?B?bmx6bDI5b2tub1hPVkhrTFRCSVNXQ2Y2Sjg0ZS8wRCsxUC9CSnpIS3piY2Vo?=
 =?utf-8?B?MVdxTkFNdVVxOXpVMmVKZmplQmtnM09BWkV3WU1RbDJyc0wzaitBdmszNUJH?=
 =?utf-8?B?YkZ6WnBHaHVBeDhycmJoNWJEbmpjQzUzMUxGb0xBNlBpbXJ4bmVaSktTVk5T?=
 =?utf-8?B?TThCT0Vmak1lK3B4cnkvaDJTUUd5RmIxZ2V6eHA0TllUUEtHMWtxSVpGZUI0?=
 =?utf-8?B?U1RWTTYxY3g2Y0ZXdEJDcko4L2RDRFE4TDhHR1ZGZXlxM1Q5S0x1b1U0R0FD?=
 =?utf-8?B?NCtwWWk2eEhJZUlnblVOV0dhU0RZNDFncHRCSW5ydmRTZUs5a3Z4cFJMWWkr?=
 =?utf-8?B?elBiZDR3SWpCdVd3d05oVkJPa1RFbThZcDZpZWY4R3Rqb3EvME0xcnJXLzgv?=
 =?utf-8?B?Q1dpUjhzZ0l3V2NlcEF1SWV6cFRoVXBabHVwZ0FGWWsxZ00vTUowLzhZdGJK?=
 =?utf-8?B?S0d0MkNmVUh6S0ZSaGZkYjFpbktHZmY4ZUJrVlp5MHN4QnFvaDJCUHJORHZO?=
 =?utf-8?B?cWNHeHlncTdrdzZ4U1NhSnRNNFZvVzVKRnpqYmVwZkZSSjZJcHQ0TEhVZ0dk?=
 =?utf-8?B?NXhiZE1MdExCZkdFc0VvTlJXb0FXbnJDREd4YUdpM1VKZWF0TDNmWmRGSnRU?=
 =?utf-8?B?QXNKcHNkV0oxVStCSmhldlBTQi9ZdnQ3RzZlTW5sUU00ZDFOb2U1Q09uM2tp?=
 =?utf-8?B?cGpwd2xKS3FiTUFLTG9rb0F5am83dlFFU2NlVHFFQ0NjSUU2SGp2OXlERll0?=
 =?utf-8?B?NGtnNlVEamxGeHZMV0U5T2RBMjd5cGNxTzY1Q0lGeDI2MC8rUHEzQ21xMEk2?=
 =?utf-8?B?c25Rakh4eHRaUXVudU5SRmVHRGJrVktWVEMzTEhUUlJKUUdJUkd3VzYwWXVJ?=
 =?utf-8?B?MXNNQVFGbEp3cmZQOHpCb1h3Q29Ya3BUM213S2lTbHhycS9IZFUxbmx1dEc4?=
 =?utf-8?B?aFFrcWxOcDlsZWdzTXhJR0E3TVd2Sjg2aHRuL1RVU2VGV3BTR1k4Y0hOaGh6?=
 =?utf-8?B?bWp0aVUxajlIQ0V6T0V5MkJtWktNaGthNEpsZlVhRjVrZHhiU2xlUjk2b0hF?=
 =?utf-8?B?Zzg4QUlXbWhtRWZRUEl0VlYwR3FSQTBCeHFQTmM0V3VIVVp2elIyc1hZRzZD?=
 =?utf-8?B?TTJJeHBPMWpNTy9DaWQyczJ2RXAxSk9md2dKUWV2Q05BTUw5SzMyMEZrNmVO?=
 =?utf-8?B?UzBydmkyL29aNkhtTlNudHJITEk2cEZ5N2VVa1p6V29sSEExKzYyQW1NRko0?=
 =?utf-8?B?dSsvZHQyU3Nub3VHVHlPOFJQRzJZS3QzdFNMamZrSDZrckJoWTVsMzdvVzR4?=
 =?utf-8?B?WkZNaGlyaHhRRkR1K0NkSDAwQ29tZ1hxajUyMWpGS1dhcHUrTWdnK2I0dG9s?=
 =?utf-8?B?cmZESVU4T1BOa2JLVFYvSHVRdVd0Z0pzTnhPU3VWMXVETVEvblpQL1dhczRC?=
 =?utf-8?B?QjJsc2VpdVJ5cGlLdTRlQWlHMUk1djhvd2ltT3Z2NjVHbHMyZXMyLzFFblVK?=
 =?utf-8?B?TlRzeHpkS3lWWEg3Y0kxeEc5YUc0VjloUDRER2xRbWVRQzJNMmQ2OHdUb0RZ?=
 =?utf-8?B?MEt6VEZJYis1SjFWQkFQRW91bUppQ2Y5eGkxbGswQkkzTWVrSXNUU3Q5cUNC?=
 =?utf-8?B?ZTZHRFF0SjZ1SUdrVHBaaEZQM2FRZ2QrK21JYTJFSnljVWhCTy8weTVsUDZK?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GZz2PZtwyvlAH7rBhho6MOnbgsvtGejMAGYtUDApU5lYwFLnj7OAhahB2zLV1UPqV/fRujKtK0ZHhvETdRh6gNRTT+m7MAU6bOJctGLHpvPBMvBf16EpMkhDudoqJ3nYh18IGzrBTy1SuQ5/ZXvOgyWxmmhMLyjU4ymyxAxxrX+B8+31YqSuv+el61Ezu+1Yxw6kM66pYzyeI793Asy9rPefCdc8eholF5uSBGdJFbVa9100HQJ8M3gpEVAnAcBO26U3O32U+rBmExAKdDD9fHJIvVrYdWrQ7vAMW9T268vRC/QOb4I4tM8gXIGRGEu1RJE89cvQ7pqGJE1ZQ6XVbXbVyD3cgMm3UA/c4nRMyTyk7q5wUwi1dQb/kPxHX8YO0YSiY5JwcpMdAsnx++o5J/rovuG5/GS99JGEieVq6T21O0W70rx/MNlEW29APzRgsazcBm2nask8ZJ9nlabD9oKl7DCAt8mj2sVtJzRi25OGQPjpD9B6T3pW9PE5V4S701XyUJiO8NWPjU6BlGDAqe4OcZ0ibtZ8JgMwumeztFTOF6eGU6RkVIbx+9OQYGx+E54v3EO+HNU1Z6DlzwNlLW4zWoQjM3f4oHUmtNJe040=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ae871c-134e-420d-7607-08de2929ed96
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 18:15:19.1755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMpzXCm37NL/bpxL5z+2p6l04moMjCCI7IHtLLyQ8WY4Gn+cqQid7vtnKyNn9V4IzMuxn++srqvhdIIxiNZLmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_05,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511210137
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDA5OSBTYWx0ZWRfX+pyPNEM9uqcT
 2Sc7En/qA/R97Dq1mb+L/OiXPdAZQET9z743cMpAvH8pFqU6TfZ8yYtteBaq/+FRZADcEk0Yb/m
 JdjaOHg2RVfiBhnMMfl7kg5odP9jXOZGOmeM4zzToQ3Y2GmH5EdMQkBTf/gZQ5Gl2Hq0ODnsS0w
 oFGci3chvkkP6xRmOaGFr4XAoPU6frhj6DR/0l4jg9e4C/sAVOzbsH5OjUMn7hUkWNKfOSRBTSn
 zv1RlsfB1nLUf+SUNP4OxjTiAWdxXKmRzM4t3SPYYFIJwkcOT4VPs1iBrUWoHUhsYZOEFeO1UUi
 LHiEYQb8LqJafzc287wO2x9HZ/fezdwWPYhxLCYG/4OyDqwniYn4IPsrdN5gTuFJ7JF/OTMV265
 xqRvsfdwZqbLJ41hIg0bk6/dmyUmbozZrEc4cFJGQ3Inptq1d+M=
X-Authority-Analysis: v=2.4 cv=Dckaa/tW c=1 sm=1 tr=0 ts=6920ac3c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=N54-gffFAAAA:8 a=LKIYONUO8-OzvxMLHXwA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13642
X-Proofpoint-GUID: 4v18MOfROn_DNv7L7UpaqQKzAzSU_IHE
X-Proofpoint-ORIG-GUID: 4v18MOfROn_DNv7L7UpaqQKzAzSU_IHE

On 21/11/2025 17:22, Bart Van Assche wrote:
> On 11/20/25 2:18 PM, Alan Maguire wrote:
>> FYI I verified that changing sched_class to ch_sched_class like the
>> following resolves the build issue:
> 
> Since the Chelsio cxgb4 maintainer has not yet responded, how about
> posting these changes as a formal patch? If this change is posted as
> a formal patch, feel free to add:
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> 

Sure, sent [1]. Thanks!

Alan

[1]
https://lore.kernel.org/netdev/20251121181231.64337-1-alan.maguire@oracle.com/

> Thanks,
> 
> Bart.


