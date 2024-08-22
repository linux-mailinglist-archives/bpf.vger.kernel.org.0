Return-Path: <bpf+bounces-37880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C19895BCAD
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 19:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8A01C232DC
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 17:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072E81CEAD6;
	Thu, 22 Aug 2024 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mvbnnTbG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Tf9ZV98I"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB25A1CCB4D
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346204; cv=fail; b=nJJO7Fr14QxbEXpLr6PpLD7dNEVyNkkf/NO3SGdptu9usLrvhabNTbWinuUd/uPfSAUkvIEBzda5RY0eQTnbeGJBvqO0nOU40jpKRMzk1tG5btqxPoI5TqOUQKvea6cLNgUIpdbRGKmbnMH+X+5wxlsF24hJCUnPGHE6GBLqEs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346204; c=relaxed/simple;
	bh=NV2u1PHkINEF9twXkb8ZFLTMogsYPX2acU+n/Q7F0W4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=idduMWqSQSSv6/5Oe+lUN9cQlJydTH8UvpdOHvmPzeF/UFFrBV45YXBe6yXurUIOjQtIFW+REHijchttdfGg9xMQzhopH2UC1ntKjPa0fry+nyKUKMZAJpsRVsNonttutTIqbuO+30kJJoHWL0KDELZTtjD1s1x9sD8PU8gSTIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mvbnnTbG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Tf9ZV98I; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MEQl7H022427;
	Thu, 22 Aug 2024 17:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=lCwyGh7vdlarQIezrphkHG4ryazJXnvxwQ9UdybA0j0=; b=
	mvbnnTbGi8a4WsYsvMOKDLxam870ModDG7+p0YOXGS6p4vBQPE8vWuuqPIKP3toE
	kJX9CB//qwsWlK4MfWRIDbJF7rd8w8fORtPHAf9f40gkEC9xAIS9455KpHuwVZu+
	p6NUvZ3rxOeKjDm8u0TgcHZcadJQeKYcGuLJ/ifbY/v6fT68Zfx6mfntly0r2FXw
	sPA36uHQbGqmZee2i6xW6cbBetw7t9PZ0iwjKjYkgxnLBZSePKc5grV/Tl+MvhvV
	u/uBvHUX8/IZXxlfxJn63nsA2Hr5Xe8ViFcDeQ5OF1rzR5qLh8mJ7oC4NSSw7Xgx
	WGVqiYbVKqjPBwNEwEk6bg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m45jk33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 17:03:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MGwxlx018849;
	Thu, 22 Aug 2024 17:03:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4169b4g8n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 17:03:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huVbo/UPxd61Zt419M8zoFTFVFHAFp6lIQTP377yfEOWxYOs5VxWpweFsZibQvdnMAx/07DqrPGnypaa7B8P8BJuoibbBTJYxfPgDUI7jAEf8r76UlMCme9vePJG3w1otdo/Kpd3Q9eF3f+8AB3BQsBq4kXMnpv14XYsyYLwnXYWgrTOnSsEedlF8KuZG7kAgmCCwXmP2FKLw0ZoUWabDqDoEHn2gXFlRj47uOVVfTzEhO0D6swZCOn84oF+y4J83CA16ytZ+0apZQd2eVfWCupE+fDQThUl53cvhx1ZZp1bfcxmllR0g9C4So2i/XDGIUulR7lWQesQ46qLPNHHHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCwyGh7vdlarQIezrphkHG4ryazJXnvxwQ9UdybA0j0=;
 b=jWJIZ9Y5okddX6DBFcx0dkALcrQKBW2798I8lXoC9+gzr41mprWsxAhyN7kUsWJNUpjRvnuYxojFAoG2gVjJVcPhR/mLP2h17H8qJFpsAi4FQ5+1D/cFUnXMxU4GiVwo0fBPEa1jD5OVZesRfNK21kGBRkeY62PEfE07hMsvqMDqeS7UNZp1plsN7C2jm14ShqZQl66/+jAfqM1E8CzfmsCjptzkOnlzvVvUFucOcshnL2W4fBjyYJrEu2+S1UWoE7pAeY2e98de+6+HKWLtxCUsEXoApfKp93XumGqkUiJAenN9wZVI9+RUCB6X3nRfHUapqLt0d7SockGqev1bow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCwyGh7vdlarQIezrphkHG4ryazJXnvxwQ9UdybA0j0=;
 b=Tf9ZV98Ic6fD9Byot1nzeJybQEYVlBY3VxkxznCKM/KfoxteJ8VIw30W16FpBzEyE1ByNQdXM/uLfJa6UqEfXZKu/cF8P80CMFgSIiEq3mjSWze0Joj/0mQlNJvvltF2BQazHEvs27cKjHB3fAoQZQzW2CJN8j3i0tCiHKKM0J0=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by CO1PR10MB4466.namprd10.prod.outlook.com (2603:10b6:303:9b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Thu, 22 Aug
 2024 17:02:52 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%2]) with mapi id 15.20.7875.016; Thu, 22 Aug 2024
 17:02:52 +0000
Message-ID: <53eb5273-6a10-460d-a525-8f56b8fc4f8e@oracle.com>
Date: Thu, 22 Aug 2024 18:02:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Correct recent GCC incompatible changes.
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
References: <20240819151129.1366484-1-cupertino.miranda@oracle.com>
 <6c07765b-952f-4132-aa99-b31010eea598@linux.dev>
Content-Language: en-US
From: Cupertino Miranda <cupertino.miranda@oracle.com>
In-Reply-To: <6c07765b-952f-4132-aa99-b31010eea598@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0106.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c::11) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|CO1PR10MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 245bcbc0-4247-4031-76bb-08dcc2cc4288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWlTNDFhbWJHQjFrOUFVWTZpc2habTIvL3VLU1YxNWcrTXVFQ0NCamphM1hC?=
 =?utf-8?B?Rmg2ejV5bjdZeStoU3NXTjdrVHBEMWhsYjBoVENESGtLUkhWdnpEdUVtMmxU?=
 =?utf-8?B?c0ZaSndNR0FaL05nQ1dXQTFWQ0F4N1JSOUI5eDNYdHYxWVBMSXVOOWF0OGRx?=
 =?utf-8?B?OGlOU3RYbXJmTTNCZFgwdkZRU0NPa1BNbFdhdDhpaGtGcmgzaXJCRnE1STl5?=
 =?utf-8?B?Ykc1cDNVazVpYXFwdkJ1WlArQXR6WS9WOERMQlJDVlNGN05aMkNFSEFjR0lH?=
 =?utf-8?B?U3NnZzJXQlorNHRMOG5PZ0MzNEhvblFlVFRoOXVuREgzM3RrLzF1VW92RVRU?=
 =?utf-8?B?ZnBlWlUwN2R6aHZPWlBTVWZsSDlCUUZtcmpKam42cHdMRU1iZ05wRENGeXc3?=
 =?utf-8?B?LzBiK3BVc0MrUlo2TENUS0wwWEtPUTQ3TjlLOWhUc2pyRk54ci9vK2VUV0pt?=
 =?utf-8?B?dW1YanB0TUEyT2Y3UC9mN2RiUVRkZVYxRjh4cDB0eVEwdFBzck1MeVZQRlVa?=
 =?utf-8?B?YTA5S0ttYjh2cTdFd012TVBlNC85OFJBRDZXcFpIVEFoYUczc25ILzNjRjd2?=
 =?utf-8?B?cm96N0xuTE5mK2hGSWpNYzNsWnVETDEvSnIzRDhDL1JRbnZidHp0UCs5bHZZ?=
 =?utf-8?B?UzhVZjJ2V0Yrazd4UUtoeWl3Zjl1anE0eXg4NSsxU1RjYXE4azJLWTZCZ2xT?=
 =?utf-8?B?SjRXWG1SY0dHNjE4Wm5LaDFQcWRTTkF5akZKenUzMFJoNDlZL3RHTGNwbDRB?=
 =?utf-8?B?VGxoUWF6THRhc0gyZ3c0bjVSejArTlkramhnYjkxNWVYdDlPTkZlUWhMQ3NS?=
 =?utf-8?B?QmpZTzlqK2tZdjNCcTMvcmhhekhEY3BwN09ZL1pqOGFPSHBYdnVDMWZ5Zmo5?=
 =?utf-8?B?bFBSWnpMYU9Db3hjYzRLaHV0UEEwMCs0cUNtbTYvWTVCbjNPMVF3WmJpT1hC?=
 =?utf-8?B?TWVFVlpvWTBVVGp0ZkwrMXlxcjJlcmRLWjJpaFNhWGQvVkNLajJxVFhNdkZT?=
 =?utf-8?B?cE9WWlhGTjNjejUxKzlZLzN2VDRkdmk0QWFsdlhURTdDaTg3ZXRYLzB3Rmt6?=
 =?utf-8?B?a3Q5VS9RcmhMU2U1OUNaZkw5U1cycE5WdDFLM2ZaY201OExRbVcvaEUwTWc3?=
 =?utf-8?B?ZEJDa0g1bktUYTdqdzRpYkcwZVZqaEpoQ0x1Uml2YisvWU5OY1U0b1hVaktP?=
 =?utf-8?B?WStkTG1qQkJIa1kyZ25PVjR2TWw5T3FvczJIeUVDNEEvT21RbEk5RVRzSUk5?=
 =?utf-8?B?eHBoazRMdHdVOW5PN0ZUbTg4NEthMXFoYlIyaERhemh2TnJmaHhmWWtNMEE3?=
 =?utf-8?B?alpKeWd4SzFoUHFIYzJRSFFjcWk5ekhTbC9xYlpRMkRIakZGblo1MXc2TlB4?=
 =?utf-8?B?ampBY2FLOHQvOWZiVVpDbXdaaGhLMVYyOHhmRGc3OXE0SERKUWlBYmxQeUFT?=
 =?utf-8?B?K3ByS2hvYWI5Qjh2NXIwTFNSajNDaWlwd3Q5YVF2eFJTSXptTVdzd3FxbWpu?=
 =?utf-8?B?WXhTU3k3aFNVT005eVZHNUdEcDFqR3BOTVNSOFhQQUFJTVozSzFEWUJxM3NF?=
 =?utf-8?B?ZUh2Z3lod1FNbkttT3E0bjljeHNUV2QxN3JuZFgrLzRDME5HRFRZa1dPdzl6?=
 =?utf-8?B?QmkxZEdIaEhUM0VncExpMFovUEFpMzZicnUwQS9UdlJpd3JYNjQvTFVZYTVw?=
 =?utf-8?B?bERTTlNQemVzUXlDZjJhZ1BqOVVSNEo1dTgycU9lcHYrMnZKN1k5TnM2cldR?=
 =?utf-8?B?N1hoakFIVGRDYnFOVEtFRGJiTy9Nd01IUVM1aFZLZmxadmE3Sm9sckt0L0ZY?=
 =?utf-8?B?eVQwSFE0V0VCY3JXV0xadz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkVWbHBrUENlbFZhNEt6MEs2RTRrTlV6V3ZjSVVtUHozSzFFeW9lKzgwTThv?=
 =?utf-8?B?VmlDTUdzVHJ6dzNsZnZqRkdHNDhJeWs0UE0xODlqMGxrS0lhK0xKd3Q0SDVB?=
 =?utf-8?B?RkdQZXRqR1Q0ZC8rVmxURytvek1HdnhDZjNuQlJTMUxOa0oxdDI1SW1HZTN6?=
 =?utf-8?B?Tjg3dDg5Q29PNnBRTUlaMWthV2ZvSUZ1ZkpDak5sVDJqZmhMN2RMMFl1MXlP?=
 =?utf-8?B?ODQ4V2p0ci91QWhGTTVFUk9tTVY1bnY4U0ZTdFNsbzlka0xVakZXRUZZTnNw?=
 =?utf-8?B?eXEwdm1LbEdWS1dTb2NNUnhoNW5oK2dDelJ5b21qb1VmNHpmMjV5NitvdGRJ?=
 =?utf-8?B?M1pZVDBpQXBrUXNYWFF5REovZGVPNXVQZi9BWlBLUmZDSHZkR1hFUXE3Z0Vv?=
 =?utf-8?B?NjZCN21NVm9HL0VPZ2lxK2FJbWV3M1FzSmR2blBCbGdlYXZKWlIxRk5NUVpV?=
 =?utf-8?B?MTBoKytUWFZSakxId3MrWEs1eHlmRjFPdEFweDhrdU4wU2REVld4bjdyUTZH?=
 =?utf-8?B?Q3NaaWcrRTlUSjEyYkZVWkZxNmtRcDh6UGlrYit6Zk5CeS9IOW9hM0FqUjBw?=
 =?utf-8?B?QTdxZk1QQTlXSW9QNEhrRytlQkRUeHozTHNlL3JiWjZmUFJtNTNVWGFkQ2xT?=
 =?utf-8?B?N1JkRE1kbWIzZm1oMFFIbzFtZDZHZjZGbTVMV3VjcVlZSzdKcFRXbXU4SFFF?=
 =?utf-8?B?ZFhGSEphaC8vN0VGaXFHZXRPNWs4QzR2NzlyOXl3MFpiVXlRNzVoZkREYlZ5?=
 =?utf-8?B?YXVHNmNINTM4NGZuTlZtZzRTaDZSQWdhTFdqV0p1ZEJmR2RzdUxGTlNwaHo0?=
 =?utf-8?B?NVhMaEVGYjZTQnM5STY5aTQ3TThqYjJOSnIvcWlUbG1Zc2NSaE5sZFhSWUVI?=
 =?utf-8?B?TzBlcG45RDd6SEd2SVZZakhPUVFxeDlyeVAwOWV5N3F0c1Z3c1F6d1hxU09l?=
 =?utf-8?B?bXNwNVp1aXZQZVZ4ZFFuMlhsRGI3cTQvWVJBaWZWQmhoQ2hUancxZFNYdk9B?=
 =?utf-8?B?Q1lRallrcFVKbGJrd1BxdVhNRVluc0FBQ085eC83UmliKzJ1Z0JEWGhrMG1o?=
 =?utf-8?B?OHpobXgydjNCeStFY2toSmM4NHNwenpFczdpc1REU3JXdE05SE9oNVFnMkRT?=
 =?utf-8?B?R1p5cUF3ZTJuOVJYK0RRZVJ0bWtzTFRaNzY3bzNsREp4Mmt0cXFrSTlyaGJ2?=
 =?utf-8?B?ZytGZkkvUTJNN0MrR3Z3dC92aWNvYmlDNUVMTGxXMitCYXlTMHFRdC9jdUo4?=
 =?utf-8?B?dG5FRDI1S0ROcGJtdXlCbk1DcmxGVGM0ckNMdEFnblNsQmRhNEFqeGpjcWxv?=
 =?utf-8?B?c0M0NDVyRVdvVnNsdllRbTN0SWgzbVYzbitJYnQ3VS95K2hleVRJNTNJa3RX?=
 =?utf-8?B?Sy9vdFhlWWsrMXpXZ1hnRkFGQndjN3BSTCsxZ1gwMC9vdXM1dE42RExwVjRL?=
 =?utf-8?B?WEdlQ2hKa2RyQVo3a2piSHkvRkVmcnc5S3YyOHZCOEtlZzZPUm5RR2tQSFYr?=
 =?utf-8?B?WWNvaVFIMlh0T1RYdzduS25GeDFrVlIvalFXMlMyREVjRWUwZkZQNmNINElB?=
 =?utf-8?B?TW5tY2kxSysyNXBxN2c0QzBQQ3Vadms5bVJYN0FlWW9OQ1hjT1pLMHZXK1Nu?=
 =?utf-8?B?bG1tYTlZS2twTHl3UnU1MExYaERubDdBT0lzR1ZpOUpnSzRlbDN2RVZlbGdn?=
 =?utf-8?B?YmhzbGFvZWZLVXhIaDUzRWJHMjh5U2ZtZGhzZjVwSnBKRDdJSldoMk0wMG9z?=
 =?utf-8?B?WTJKWEZGaTFuNG5aQU5Tb3Z6c3pjSlVFcVg5NXJGTEpNUE9QTzFXdWhDcmxT?=
 =?utf-8?B?YVAreGVZbUJoNlEwbndWR3ljbk51Tm5yemcyU1kwSVhvQlRFblV1czlmbXlu?=
 =?utf-8?B?a2ZFa0dTTlgxeTZhT0JEVDBLRXlGbkV4ZDVFbDZqUjdoMUtXbzFYRTVDYWdI?=
 =?utf-8?B?T0VST2JsUFpTRDYxZG5TdFY1SVUwSk8rbHZoRmJNRExkaXhNbU94S0hiYmg2?=
 =?utf-8?B?d0JYYllHNnEweXhjSjlCY3ljbTA5VXZ6dk1BaFlVUm44NmZBang1ZlVwbzNO?=
 =?utf-8?B?eWx3TEd5RVNUNVRJUDNDMnpoZm8xZW5TL05id1FaUjZEbDUrZEpxTVNDMGpL?=
 =?utf-8?B?ckZLdzFGd0haeVR0T2FkZUdWVGlIMnd0dEpsTkk1UjBYUUNPN2JoWUgzVTMy?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VK6HRaRd2ARciGuEXWWRwwr2w23xu+6Q7a7bahIfmtIV26hRU2NQH2TjjwPEFt/T/Op2ldUJilP3PkbU/BexpX/FoBfRdKfWjieG8YM6wDXZ1HNJX9aGvgojLIS3iS9FYYqGeE/PrvOpkwPpeO9w15fmfAXTo3wCpddglswu+6aa4YnacGiYraE+IY4A9nnwQRHm2rBeVId9apmBtMqmxZkOomBAAuQp21FNooh+bxVoWJL2bf2DnMubKWEd9IV1+ud1/F92YZ4+TPpOQJV4QUtxnGtvMeHNM8fqeAbQPr1B6TTN9F0DlluucL0NcPJu0Q+8Mz9sbyYxKGrzqzTFUav/dEHb8pwr5j2fT7G6XwnbvV+OsUTM3lljYPUOufpkhH+vrlPvBh04bGpim84u8x3PYgyilmxpoOnkDddQsHmHuy2w7QavHOxKIdcrb0yDM0SWZIlqr+mkdLkhGqGE6ZV/BdjeOnK5Nn4zpAcR5VQ3M+wiNKvl2RUCz+GnMsAja7AdDEZu/H7kJuf167K2ypv4nZ7pFCYhXuiOxEjVRMsHcpZgLN3ISansZ4kpjCiSWUZgGBDpkFxeSH4LbHcLF/i4UzgKurDf5hx06qw8BoI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 245bcbc0-4247-4031-76bb-08dcc2cc4288
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 17:02:52.8416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9YLtWGFYQjYqDQ8mhVaCLvDhZU5U/Q1p/IPV3d/JNYPFCLRI8YqFso+NgCh/h9mBxiHOuN6UpcX/NDKgYAHeQ3Ezb9zjDJKEcQMD+KN5P8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4466
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_10,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220128
X-Proofpoint-ORIG-GUID: Ahp7FFdzSRnAob-apm-5zHiUqlEY0O64
X-Proofpoint-GUID: Ahp7FFdzSRnAob-apm-5zHiUqlEY0O64

Hi Yonghong,

Working on it. I am almost done!

Cupertino

On 20-08-2024 20:42, Yonghong Song wrote:
> 
> On 8/19/24 8:11 AM, Cupertino Miranda wrote:
>> Hi everyone,
>>
>> Apologies for the previous patches which did not include a cover letter.
>> My wish was to send 3 indepepdent patches but after the initial 
>> mistake lets keep
>> this as a series although they are all independent from themselves.
>>
>> The changes in this patch series is related to recovering GCC support to
>> build the selftests.
>> A few tests and a makefile change have broken the support for GCC in the
>> last few months.
> 
> Cupertino, it would be great if we can speed up to add CI test with 
> gcc-bpf, even
> just for compilation only.
> 

