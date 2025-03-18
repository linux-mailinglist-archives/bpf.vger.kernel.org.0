Return-Path: <bpf+bounces-54339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF60A67C7F
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 20:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCFA9882271
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 19:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C28B1DE884;
	Tue, 18 Mar 2025 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l+pjQufN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WlAewHTR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77F6154425
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324470; cv=fail; b=Eyda01ePxIlRfa8ijuIFcoyo5jvGy4wvFNBv6+dz8dEYoX4mdXklDrsd7Ri2Im/qW37ueUQfhKOYkt0e5ryaUrhRfkKawHJw5Cder2oauayeO6jFnk7S7NHwqV36yXhg1h3btsB7I7urvyaHQu+0pCfpwYcdca8JFkD00oRPprs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324470; c=relaxed/simple;
	bh=5K9K0y+SivPBT0sfEVYaK6dIoxY5I60wU9nJAXgjdXw=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=ijkS++CF5kYNpnK9lk3rpRGoLOMjYypfmqbSe+n59rjceAu8qDJtCJbLb2Sm551JPju9YaRuKirhwmZHqsqAb/J8yQ4XX9RY1wQ4SbZCfLReHdhy7kEl8m+YyLexr+HhpiNB9b9+3O3fNMXrsWnC9O1y6p/sy+M0km9oP+dw1hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l+pjQufN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WlAewHTR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IItt5e028831;
	Tue, 18 Mar 2025 19:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=pBl8O18QZP0fwV1lVP0baW3HRABZBhHEuPYSbt7P4ZU=; b=
	l+pjQufNfes0qWsVEgqmoYcfCY6Js705CAlFQhAklSoaRBDPvCI7M3s70o7/C/+y
	FOFtez4JVP62XVw5sDVksqRJoxK+eRAIneR3lWKK1xIw03xz5bySZ/lrm6GQ6H4d
	cAB8YTsSzM9VNGl+MAL2iTiCVr+V71TerEmCkxHIA+ZZhsMqh2KD9eRUUWDARryn
	2uEBqbPCJz4+UQGkZ1rqEGT2h7nJ3WQanaxceYO3vSHj2swpQzbtKWV6Mn1lsuxU
	9CoXaKXq47xJ1mJAWfQIh2kyjIBFUtsiIkPjqRwOtUcpyB7n6OnejEQVxuANIMsH
	2HU+CObXe5LUa6a6gmrB6w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d23rwwyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 19:00:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52IHf8wi023000;
	Tue, 18 Mar 2025 19:00:45 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxefsrra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 19:00:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wI0hGgDpLdIbqW1MsiAK+qBax/jbIfwmNDyOWCpr4Ec6jO/+Z/qktmQ0DYiZM73nnOrG92qcjaQg+OwqRfHVhb3FdsPvv/Z4Xc0wXQK9mkMsDSg2BGjj1xPvuYUDQowognKZIRjeM1LdslyxqGTtQjJGGZkO/YwP/+n3E+FacN6t75OAxoyiFV/YNUhOeoo7WcRl9wpjz3Spof312kNZ5LHkDfvwTXDNydIj0uI8Y4LzBmmYroa7mYvZH9TMaBWKViHteCpPmxAzAdNNV+JaoD4Y/Wbe5MID0vBNhoBbuedZmd2GcPTo5gyyVPev9Va/QAtqUJmo2K4WE3kjVerbfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBl8O18QZP0fwV1lVP0baW3HRABZBhHEuPYSbt7P4ZU=;
 b=mwm7tWl9SrBBZJC2ptpAax6Vroi0E3KG9xFAyfncDwxV6gXMqfQsGACJEgSI2XK+YI4+La9eN4KoOZDs4fyw3Jke5iLNdEmm0HbZayS4SJcJAlhcEAtNr3IiIkhvgazAsG4/6EJg2i2In3prQ9DfJWKs4pZxd7onGALe3Tr8FzHH5xvokRrjI8WQiQl/L/FDYgsMNb6J8pNYdLvdG3leU8SDGdx69uYgbMCnLnhnd5pju/vnjGQPKuhIJJEt51ayLeXt/hmbGgpwxHgjihl6Zwytxu8/iXEHYr24pRtRSwnq+j9e1n+GptVRLCvR6p+Pv1xbHC9OFqPu/MNosME1dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBl8O18QZP0fwV1lVP0baW3HRABZBhHEuPYSbt7P4ZU=;
 b=WlAewHTR8kPjcR0aj2csj94GqFSH0u4M2DXq3wNKGZ4aYk6Sn0Im1wWVG5FhQrNJV3tIEnsLIjOjiL5axh2pM0Hl3zRaB6NLPGtiRPq1JcJAorUvrna4pDwRZeTls3iHD/Qe+qh/rj6+bbsHdDb+SpReqoj7bvJiVtt3MNKwVCI=
Received: from IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19)
 by CY5PR10MB6011.namprd10.prod.outlook.com (2603:10b6:930:28::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 19:00:42 +0000
Received: from IA0PR10MB7622.namprd10.prod.outlook.com
 ([fe80::2a07:dfe3:d6e0:abdb]) by IA0PR10MB7622.namprd10.prod.outlook.com
 ([fe80::2a07:dfe3:d6e0:abdb%6]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 19:00:42 +0000
Message-ID: <f25a61cc-e2aa-42f0-9173-d4ab3b5a91b5@oracle.com>
Date: Tue, 18 Mar 2025 12:00:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 04/14] bpf: add support for an extended JA
 instruction
To: Anton Protopopov <aspsk@isovalent.com>, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Yonghong Song
 <yonghong.song@linux.dev>,
        Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>
References: <20250318143318.656785-1-aspsk@isovalent.com>
 <20250318143318.656785-5-aspsk@isovalent.com>
Content-Language: en-US
From: David Faust <david.faust@oracle.com>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>
In-Reply-To: <20250318143318.656785-5-aspsk@isovalent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0195.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::15) To IA0PR10MB7622.namprd10.prod.outlook.com
 (2603:10b6:208:483::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7622:EE_|CY5PR10MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: d958e92d-059f-49ce-f70c-08dd664f2e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUZSbHBrOGpoNitTWFZXNW5ETUU4eHFRZlQ3dFBtYmdZNVo0cy9pL1lGNEIx?=
 =?utf-8?B?ZTFGZ3ViMmxOMUVSSWtUOUYxQzZGaTh3QzkrcExqd2F4VHAvNXlWWk5YUm1U?=
 =?utf-8?B?QXZkNFo3YWJrZ05vTjhJMTZFbi9iMGUxZVlaMWxON211NkNJZ1BrVVpNVVlP?=
 =?utf-8?B?V0JMT1Rid09rWHFpWGZrT0phcG0waHY2MHd2cVUwMjcwZXloMVlxVXNua3JJ?=
 =?utf-8?B?TEU5S0VYNWw3b2RwdU5kSndGMmM4cklzTjMzRnJoeWZyV2d4dml0N3R0QWxh?=
 =?utf-8?B?OHQySlJhbG9rWEtZamVyOUJXclRlR3VlMkFKY1J5eVdIdG9tSkd2RUlQdktR?=
 =?utf-8?B?UWRSVHF2NmRhNUdTUUFzNVpnTHR2Ry9PcjRTekU3cGN3NG5hemJjL0tHZnlX?=
 =?utf-8?B?WjRMRjR2U2h3TTJjV3ZsSnNwbUc2QWNoMVZoYXJHTHNnclN6bTJYTWt1Sktu?=
 =?utf-8?B?bDErNzBHVm1KRERhc29tYjRLSmdhNUhCV2lHRWlRSDlNVFBQWmthVUMxL3BE?=
 =?utf-8?B?UUEzbThmK1YrNFFlRWxIdXFicnhHK1VRZUE1bmQzUWxQa3ZzTDlVNGZjemVK?=
 =?utf-8?B?RGVJdGU3bFlsMmw1Z0RlWm9VUDJqemVtbU44Q1g3VTMzWnhoVTMzS05Md294?=
 =?utf-8?B?SWhNN2tubmJDWWVhTDMyU3YwU3JJMnRrMk82R2hBQTFLSFFwQ3BlWEJGdXUy?=
 =?utf-8?B?RC9BalhyMnl1UDhZMlo4bUlkaDlQRjdFWktLRk1ncHhMS0NGaDJmemYvdXh3?=
 =?utf-8?B?d3pxTXhuTmJwcU44ZEtXaW93eXVWUDdENyswLzRIb1VTbENhSUl4TWRNOXI3?=
 =?utf-8?B?UWpmRGpBMUFqYWxlMDJ2aUhkRVJHY09SOEJuSUh2UGx6WlJ4SDJ1QnF0amNq?=
 =?utf-8?B?SEM1TkZ5UHRYZTJJbktGK0x6MWVXdU05Tkh3UWRYdGREYU93M21OMmliZUQ3?=
 =?utf-8?B?SkE3UHNsakVUeDVRazlEbStGaURjZ3JFdVpiQVRudlR2a1c5am13RGl2OUgx?=
 =?utf-8?B?dkRnZXhzOHBNVnRxMndoeTVqUmwyVFF2d0RBN2dMQThMaGpsOEtxL2JQUVBK?=
 =?utf-8?B?RGlyZjJFeDV0TnFyNlRHUEVIUmpXaTNmTmNPOHNYOUFPUnhqNVd4WkpvUG8y?=
 =?utf-8?B?M2hHU3J4S1dwYnpEVkVRWkx0SzU4WWcxWWVHM1FDRVNmWDR0UE9tUWtJVUk0?=
 =?utf-8?B?MDZVU1lFSkJQY1cyN0k0RVZtRDlJVCtjSklQV0MrMEFjN09zOGZtb3I1S3Jj?=
 =?utf-8?B?bE42SjEwUVBaZUtlbXVWOUpWVGJqbkxMbmUyUHNtZUtoQll4QjBPVlVxUjM3?=
 =?utf-8?B?Rkxua1czVEtWWEpJMm9aZmE5NU9wTm5VYUFiTGVWNXZGS0pCYmJXR0Z1NDV5?=
 =?utf-8?B?SkkvSkhaS203WXZsWk10b1ljaU45UFlDQXQ4RWw4cFhUaVMyOTFReFpPeDQ1?=
 =?utf-8?B?SnQxSlZMNkZXV0FTazBTVnBwdVNXODBXSUJBUGxmVnFLMkx1U0hLUU1QVnpE?=
 =?utf-8?B?Q3UxQzB6aUp6NEdEdG9Wd2xrYXBlUHNycHRDSzRaa3VKM3ZLdlVWc0svT2R4?=
 =?utf-8?B?U2pKTGNtSFFxVWU3NlNxd1lxQ0tBaVJwamthUHNWVDdpbmVWT2U5TDVIOTR6?=
 =?utf-8?B?TE1rMHBJZVozVjFOc0pzQ1NnK0FTeGd0QnJWVGFGUWk2eW9uYzhFWXAvNGdU?=
 =?utf-8?B?S3ROb0pXYkxZK1FvWUt0eU1pL2s4WWNZMk11UFg2OExDWGZ5a0crdmRDTmhi?=
 =?utf-8?B?d2JQRW1pS0s5Tk5SbzhmNGlIRTRKRXlDai9TajUwUll4MTdpYnIvalVCQXhx?=
 =?utf-8?B?bm5Canpsd1JqRi9taGczemV1ZzRZRzBkRkFOMGFlYkNFVXJmSWhpd29kL2hT?=
 =?utf-8?Q?PMVEySV1arTgB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1lVTkxDMmRHM3NjcVIwUFZkbnI2L0t2cUtqSUFvOVo0bVNVdUErSzV4ZUFn?=
 =?utf-8?B?YnBhY3B2N0ZwblRYZHNKZlhPcE9wYnlBcGg2bkFIM3pqamNiYUNpamhaY284?=
 =?utf-8?B?NXpQYld2TXVNTG02bFlYTW01dURoZ29md3dQMGswUGlVdFBUQWpUWGVtRXpi?=
 =?utf-8?B?NEpUNGkwdEtMYVVHLzd3Y29rR3EvSENVZE45OC9rK0FuMmZJbDdvQTFjRkk0?=
 =?utf-8?B?ZjltUE04OXdiOUg3c3pNaFhrY1BNRWVJUHdwWHNrK0JsTVNHRCtwaUEwQmFQ?=
 =?utf-8?B?RWtTdFlienZHWkgrU0pnblVUZnVwL2pSL29aNXdyUFhzWHBOeXBZcDdTcFNv?=
 =?utf-8?B?b2wwSVZVQ09TU3BNZFpOSE1aVGJMNTUxL3dwdW5kRU83Ynd5bkxuZm9kWm9p?=
 =?utf-8?B?dUE1TjhmRDZpNktBa1BzVDBGVXVIMnR0UG53dGQ5bzlxaWVYMS9pQTY4UWZt?=
 =?utf-8?B?QzJxTE51Rjl4Kys0OVJjWGdWQU9JVE55V0crbGU2UUwvenBNa0IwSkdjc2JG?=
 =?utf-8?B?aEVaR3oycDRRVWhZbGhnZDNNL3YwNnl3bERlNW5lTlRVQjJPNkNTTlNhRjRX?=
 =?utf-8?B?SmxWMno3UjZLOVREa0ovdmR4K3pMREtPTmp0dDNIanh6em1JM1AyczVZQmlT?=
 =?utf-8?B?R2d5WGdTdHRDT0dkVW1pRjJsS1REbnlhVGhEOGdtVWdMY0lBaFhnTzI2b2xJ?=
 =?utf-8?B?aWFQMmQ2YldKNmhmdUd1U252dXJ5ZEVzQVUxTjRhTS9scC93WENnOTVFWklV?=
 =?utf-8?B?RXk5V1I2RmJCcC9KYS9NcUZLQ1AxdmVSbHNEMEFHTElZZmJsSDdTek4rRDRY?=
 =?utf-8?B?TXQ3ejRYNHVqVEt3ZjlzNG1IdDVXQ2dnYVJBUU5nUUpwUlRjZUJTMU1TWjk2?=
 =?utf-8?B?V2R2a2dNRDZqdFYwbmg0V0dUUm9VdFNsLzByODF4QStBWlZEUHVyUXU5dEJx?=
 =?utf-8?B?bGpubkpvRkxUL2lsUTFhaGF2MTFsNEdmM3F6MHhzLzByVGUwTFFGdVhWSXN1?=
 =?utf-8?B?a0RWQUsydmd0dmF5V1RFbDRMRy9ZektwM283QldSSU5jSXJXUGNWZFZjOFF5?=
 =?utf-8?B?dHg5TWNBb01BZzNtSURJM3BGMkZZZXF2cC9GdG1FeklodEtzaHBWeGFkK2pO?=
 =?utf-8?B?WGhNaHR3MUF5YWJHVzNFTnhRYnhsVGJZN280Zmc1QjBwWVRZMVRjaDEzcVdw?=
 =?utf-8?B?cWNTNkpJZG5aODRIWlVQejdFaE9QemZ4UDluYnAzQlI2aVdGNWUySlA1NytL?=
 =?utf-8?B?WFV4MnhMd0tHOGZEU2RJQ1VsYkFtUnlremxVSTJ5dDlwdk82M0R3UHZGMUhG?=
 =?utf-8?B?UE0xcTNlOVBzMVdIZ01mWTE3VzhrVFdubEQxZi9UVjFzQ1pPTVphODlwRnpJ?=
 =?utf-8?B?V05QSDFJZ0xwRWtBRDdUMFNINUkvOGhQYkZkZFlHcFZVQ1JCeXoxRmY1ZDJu?=
 =?utf-8?B?WkwwajlRWU5jNm1hQ3NPNG5oOC9MZHJCMXU0NDRTYXVENVh0dlpTS1FDNTZI?=
 =?utf-8?B?NCtjczlCVVhLaEZZRGJKcDBOOXJDRWM4dmhxaVdpank4a3VEZE00NktEbmI4?=
 =?utf-8?B?ZUU0dEkzT2ttQ2lzVFFqdG16VzRpemN0K3pSNDcxcUJ5bDVKL0pwNGkxaFBv?=
 =?utf-8?B?dld0NmhSeXcxS2psTVFGaTRUa25NWDJRM3FnaUNUbThIUjIzWklEMHpvblVa?=
 =?utf-8?B?blFqN3Fvc0JNWTZsYy9lWk1KYjhseVErZW1seTBsOHcrdEY0K05xL0tiSXFF?=
 =?utf-8?B?d0VRK2pMUlZpQzFhSmVabmtMV3RWdDg5aXhjK1lzbDc3RWNxdDNwd0V1azVE?=
 =?utf-8?B?RjU3WHJUNGpzeFFzSEtHalZNUGwzZG1aazZPRVl2WkNOYW5Kd1NkaEdUR09F?=
 =?utf-8?B?cVh1ZlpmQ3JSSVhLOGhZN3dkUjExOStkYno2ZTdOKytobmZrNVBsU05JNU1K?=
 =?utf-8?B?b3d0Z2ZlZkRwWEI5cTRObTJWelU4QWNtbWpnYVhwYWI3cE1BeHdHWVZtQmhJ?=
 =?utf-8?B?dFdSSlZWeUlGUDhaWllvaUpCRUp5SWNlMFhCYjVKTVlKM1NNalNIUnltN2po?=
 =?utf-8?B?bGFReVVhS0tQL05ySENqTUZFbStCRVppTTY2MDhuTXlyMzJvTFZwbWJESHps?=
 =?utf-8?Q?tIwENN3LDptWJPy1GqQOzNi4r?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZitDjIEs6fh39utCVj2RI5RXj6fQoh1YLRStC41zcZn9HdL0JXhIo/QSgtHctq7H1C5vL00fFf57ggh35zuDD/MBCnCbdNc8pYmlhISmc5UZ1RrG2DpxTelowLPejR2DPjdVoD5ysH3wuXNJlXuXQMjtTlD1JbOA6pxlT8SJOzaYvB0dJ4e2Va9tFe6zK5RsUegxf0vIRdZSH3VsMgTayM8FCe+kGUAI9i0YrCHv6myosmHBJbm31g73zEbwE4B5ysT0lInY2hUW3hm9MxU4mW2DXYtn+ClwMUQZU77/4gfMl8aMWZ6BsqvOR05hutiX8ohtqAav/c/w4lzbpqP3w6N3fovRxV/iQRk04et2kv0RWcDChearYppqRh0ArFqJ4lfXQ1XZ/foKGHwMp3YoT0bsRqg9+/hbi5DQ7yShYzlG4VsCUrOPsibVcYyMb8rjfh1SGI9M5xCKwYwQ9eKjktMiTSBNBvD01571QcXDs/McGx0HqpxQG8NbKsrECvfo8QCy0Ov90bNQl96nzZwIfVwW3tIKU+KwSr+gFIhcAc9vk+obg4n1thmDslnTpSrYWc1szT/WxeSCdUqpDfWr8rw6Lbn0aAQh2WBplxfgsvo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d958e92d-059f-49ce-f70c-08dd664f2e20
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 19:00:42.0071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MguDwWhjJ6oKC//m5IRyC9DjRqbkEe4d5oPKRXGDZZoF8nWhg6OGPgOOhdT71xLVfMtX6RY5VivGCW2+GU918Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6011
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_08,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503180137
X-Proofpoint-GUID: flj1lZAZ66Pb6uTUdd5NcyAquVy3Zt2n
X-Proofpoint-ORIG-GUID: flj1lZAZ66Pb6uTUdd5NcyAquVy3Zt2n



On 3/18/25 07:33, Anton Protopopov wrote:
> Add support for a new version of JA instruction, a static branch JA. Such
> instructions may either jump to the specified offset or act as nops. To
> distinguish such instructions from normal JA the BPF_STATIC_BRANCH_JA flag
> should be set for the SRC register.
> 
> By default on program load such instructions are jitted as a normal JA.
> However, if the BPF_STATIC_BRANCH_NOP flag is set in the SRC register,
> then the instruction is jitted to a NOP.

[adding context from the cover letter:]
> 3) Patch 4 adds support for a new BPF instruction. It looks
> reasonable to use an extended BPF_JMP|BPF_JA instruction, and not
> may_goto. Reasons: a follow up will add support for
> BPF_JMP|BPF_JA|BPF_X (indirect jumps), which also utilizes INSN_SET maps (see [2]).
> Then another follow up will add support CALL|BPF_X, for which there's
> no corresponding magic instruction (to be discussed at the following
> LSF/MM/BPF).

I don't understand the reasoning to extend JA rather than JCOND.

Couldn't the followup for indirect jumps also use JCOND, with BPF_SRC_X
set to distinguish from the absolute jumps here?
If the problem is that the indirect version will need both reigster
fields and JCOND is using SRC to encode the operation (0 for may_goto),
aren't you going to have exactly the same problem with BPF_JA|BPF_X and
the BPF_STATIC_BRANCH flag?  Or is the plan to stick the flag in another
different field of BPF_JA|BPF_X instruction...?

It seems like the general problem here that there is a growing class of
statically-decided-post-compiler conditional jumps, but no more free
insn class bits to use.  I suggest we try hard to encapsulate them as
much as possible under JCOND rather than (ab)using different fields of
different JMP insns to encode the 'maybe' versions on a case-by-case
basis.

To put it another way, why not make BPF_JMP|BPF_JCOND its own "class"
of insn and encode all of these conditional pseudo-jumps under it?

As far as I am aware (I may be out of date), the only JCOND insn
currently is may_goto (src_reg == 0), and may_goto only uses the 16-bit
offset. That seems to leave a lot of room (and bits) to design a whole
sub-class of JMP|JCOND instructions in a backwards compatible way...

> 
> In order to generate BPF_STATIC_BRANCH_JA instructions using llvm two new
> instructions will be added:
> 
> 	asm volatile goto ("nop_or_gotol %l[label]" :::: label);
> 
> will generate the BPF_STATIC_BRANCH_JA|BPF_STATIC_BRANCH_NOP instuction and
> 
> 	asm volatile goto ("gotol_or_nop %l[label]" :::: label);
> 
> will generate a BPF_STATIC_BRANCH_JA instruction, without an extra bit set.
> The reason for adding two instructions is that both are required to implement
> static keys functionality for BPF, namely, to distinguish between likely and
> unlikely branches.
> 
> The verifier logic is extended to check both possible paths: jump and nop.
> 
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  arch/x86/net/bpf_jit_comp.c    | 19 +++++++++++++--
>  include/uapi/linux/bpf.h       | 10 ++++++++
>  kernel/bpf/verifier.c          | 43 +++++++++++++++++++++++++++-------
>  tools/include/uapi/linux/bpf.h | 10 ++++++++
>  4 files changed, 71 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index d3491cc0898b..5856ac1aab80 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1482,6 +1482,15 @@ static void emit_priv_frame_ptr(u8 **pprog, void __percpu *priv_frame_ptr)
>  	*pprog = prog;
>  }
>  
> +static bool is_static_ja_nop(const struct bpf_insn *insn)
> +{
> +	u8 code = insn->code;
> +
> +	return (code == (BPF_JMP | BPF_JA) || code == (BPF_JMP32 | BPF_JA)) &&
> +	       (insn->src_reg & BPF_STATIC_BRANCH_JA) &&
> +	       (insn->src_reg & BPF_STATIC_BRANCH_NOP);
> +}
> +
>  #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
>  
>  #define __LOAD_TCC_PTR(off)			\
> @@ -2519,9 +2528,15 @@ st:			if (is_imm8(insn->off))
>  					}
>  					emit_nops(&prog, INSN_SZ_DIFF - 2);
>  				}
> -				EMIT2(0xEB, jmp_offset);
> +				if (is_static_ja_nop(insn))
> +					emit_nops(&prog, 2);
> +				else
> +					EMIT2(0xEB, jmp_offset);
>  			} else if (is_simm32(jmp_offset)) {
> -				EMIT1_off32(0xE9, jmp_offset);
> +				if (is_static_ja_nop(insn))
> +					emit_nops(&prog, 5);
> +				else
> +					EMIT1_off32(0xE9, jmp_offset);
>  			} else {
>  				pr_err("jmp gen bug %llx\n", jmp_offset);
>  				return -EFAULT;
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index b8e588ed6406..57e0fd636a27 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1462,6 +1462,16 @@ struct bpf_stack_build_id {
>  	};
>  };
>  
> +/* Flags for JA insn, passed in SRC_REG */
> +enum {
> +	BPF_STATIC_BRANCH_JA  = 1 << 0,
> +	BPF_STATIC_BRANCH_NOP = 1 << 1,
> +};
> +
> +#define BPF_STATIC_BRANCH_MASK (BPF_STATIC_BRANCH_JA | \
> +				BPF_STATIC_BRANCH_NOP)
> +
> +
>  #define BPF_OBJ_NAME_LEN 16U
>  
>  union bpf_attr {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6554f7aea0d8..0860ef57d5af 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17374,14 +17374,24 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
>  		else
>  			off = insn->imm;
>  
> -		/* unconditional jump with single edge */
> -		ret = push_insn(t, t + off + 1, FALLTHROUGH, env);
> -		if (ret)
> -			return ret;
> +		if (insn->src_reg & BPF_STATIC_BRANCH_JA) {
> +			/* static branch - jump with two edges */
> +			mark_prune_point(env, t);
>  
> -		mark_prune_point(env, t + off + 1);
> -		mark_jmp_point(env, t + off + 1);
> +			ret = push_insn(t, t + 1, FALLTHROUGH, env);
> +			if (ret)
> +				return ret;
> +
> +			ret = push_insn(t, t + off + 1, BRANCH, env);
> +		} else {
> +			/* unconditional jump with single edge */
> +			ret = push_insn(t, t + off + 1, FALLTHROUGH, env);
> +			if (ret)
> +				return ret;
>  
> +			mark_prune_point(env, t + off + 1);
> +			mark_jmp_point(env, t + off + 1);
> +		}
>  		return ret;
>  
>  	default:
> @@ -19414,8 +19424,11 @@ static int do_check(struct bpf_verifier_env *env)
>  
>  				mark_reg_scratched(env, BPF_REG_0);
>  			} else if (opcode == BPF_JA) {
> +				struct bpf_verifier_state *other_branch;
> +				u32 jmp_offset;
> +
>  				if (BPF_SRC(insn->code) != BPF_K ||
> -				    insn->src_reg != BPF_REG_0 ||
> +				    (insn->src_reg & ~BPF_STATIC_BRANCH_MASK) ||
>  				    insn->dst_reg != BPF_REG_0 ||
>  				    (class == BPF_JMP && insn->imm != 0) ||
>  				    (class == BPF_JMP32 && insn->off != 0)) {
> @@ -19424,9 +19437,21 @@ static int do_check(struct bpf_verifier_env *env)
>  				}
>  
>  				if (class == BPF_JMP)
> -					env->insn_idx += insn->off + 1;
> +					jmp_offset = insn->off + 1;
>  				else
> -					env->insn_idx += insn->imm + 1;
> +					jmp_offset = insn->imm + 1;
> +
> +				/* Staic branch can either jump to +off or +0 */
> +				if (insn->src_reg & BPF_STATIC_BRANCH_JA) {
> +					other_branch = push_stack(env, env->insn_idx + jmp_offset,
> +							env->insn_idx, false);
> +					if (!other_branch)
> +						return -EFAULT;
> +
> +					jmp_offset = 1;
> +				}
> +
> +				env->insn_idx += jmp_offset;
>  				continue;
>  
>  			} else if (opcode == BPF_EXIT) {
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index b8e588ed6406..57e0fd636a27 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1462,6 +1462,16 @@ struct bpf_stack_build_id {
>  	};
>  };
>  
> +/* Flags for JA insn, passed in SRC_REG */
> +enum {
> +	BPF_STATIC_BRANCH_JA  = 1 << 0,
> +	BPF_STATIC_BRANCH_NOP = 1 << 1,
> +};
> +
> +#define BPF_STATIC_BRANCH_MASK (BPF_STATIC_BRANCH_JA | \
> +				BPF_STATIC_BRANCH_NOP)
> +
> +
>  #define BPF_OBJ_NAME_LEN 16U
>  
>  union bpf_attr {


