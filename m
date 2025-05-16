Return-Path: <bpf+bounces-58426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4E8ABA4E7
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 22:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69651BC1932
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 20:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0FA280011;
	Fri, 16 May 2025 20:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kJkHe68M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yO9eVQmo"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94449221273;
	Fri, 16 May 2025 20:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747429085; cv=fail; b=sAyHTA+JkFgazY7fbutlIciFFIcD6k/atlxKuGRTUb5ivvxohGdTRoxQX9kV0LbVwKHjj33UPaFOtq8Crf810j+YV5Zb78nrrSQWbzXte+N8XABbWPfRSrMVNgwSN4Gf968hRKwqor1HmIawQ6k5RwMC+6QDFb+TEAnhnOdWCso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747429085; c=relaxed/simple;
	bh=QLaWGDsGE2ix4rdPEWNLBqNZVKlyLXyTss+ga7COw7Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XS8hAQstQDJeWr4MtoN0/d3Iq5GtXBFXh5T8L8NgTGpFY/rZJB+Z0OvPjInbn7RkuSTadveJsIgTIP9beHR3ihfhQEh45rv+PSefnWqdriFnVm8UOxLdxbUeUcQd3Z+P+hqQr5G8Zpmk4QLSP5ocA6T8SxKW1DcGFEA2ZmLJAOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kJkHe68M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yO9eVQmo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GK9xqS012928;
	Fri, 16 May 2025 20:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bcB6RxmKC3U17rxSJXLkre3D//LlRSYraagXjbIUQNI=; b=
	kJkHe68MTLxiS08SCwnPfEuPqBPRfhQUf6Aw2QAbLBOoBfK7Dx3d2SuIIBPPGnJL
	aKQL2dHt6zz1zDxKxV5PoXEHmPTMR2FJkT4P6YtsN9YTefb2BzmwCknwzgfRihdJ
	NK9SA7pBY18LNvHDdG838qTl61N4GF3lK9bu2c5ReRxFQHMDAzOS9aP14nyp9hNq
	n//VPbEuGBNJN5x8JguunkQxiylzfUD2s9z9SdzGMCZSQBFu0jYAE3gb9qBEJU61
	VeadhOsLyCu+xXphcKcaM/H8d6/Y7paN90Luq9GYze/l4ki+SOuO56HhfqQ4TMi8
	JPiSQ+I8jBAbsjgJkNd/eA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbdj7s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 20:57:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54GIkVT2004281;
	Fri, 16 May 2025 20:57:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mrmfstpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 20:57:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hO6bdpjgGib6TadMTpMsvxx7JWwLfC04pPxB1gKH+QtPvXIGdDdcgQuRGKrjSRXaQ8tmnfOIOKZB5ot48AM+eXGxbGAh3G/loc0+ytdUTlpi2lLwsoWhshFJc5dHclrJFtkv47vN7Ll3Wya+tUXYDbqtILbs8b7PkUbhumofG7j+4Fgq5GqS5mMacVatpzlwUzCQzEbcSB4mTTpr1RsUcj/QB4CmxL91o5L33ewsJwOzaw4rjfXtPDBKB+kqrZyLruCkr8w9N1ijM0XJMBv/VYYl5kBGPH9KNmx4IkwtEKkJey8bYgMmn/TnMoXZ8GVT3duqG5tRnXPQboz2ENARXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcB6RxmKC3U17rxSJXLkre3D//LlRSYraagXjbIUQNI=;
 b=MAaGBRfigiPShK3GICW3OweTIEHoWjlzfQi1TkK/58v8gqJVLYfRFdJ4OEwgWSkKZi2XuaVfRXL+00CqbnYq9u9enH2dbCYT50z1ekTphPEtIRqf/61xmHdm/xjugCnOon46iYgGWu1gb9iwpNyx9OKoeT2reudvt4gtvr8JuMxKFNLMlPS7Io6JI4ElxLMqfZdLCyJvEtgbyvPi/2wge9jwra5otOEPOO5gqKlppRLKgGCcZP2IWbvsoijyN7ADhFJ6lLaynSdp9e66NOQOBpDx+0/pCxtvsx2hKPf2abH8qIlOGBfUYXi6l66o7nJ1wGzUkCk9sHXTRfpYlKf5iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcB6RxmKC3U17rxSJXLkre3D//LlRSYraagXjbIUQNI=;
 b=yO9eVQmoEzyaQVMsuiRNokDW9uyIMaMcu0XtbpZJIP4cFepJmDtdTDAjovUtXLkMeGa0LhrjJurrzf7EpYELEZSZH/g949lCDmSsXROmZSDi7WJnHRCzuSQ8UExRELodQF/lT1Q3GLLnK+PgS5vuIaoPx6ImMTC95OBnmK90Br8=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM4PR10MB6232.namprd10.prod.outlook.com (2603:10b6:8:8f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Fri, 16 May
 2025 20:57:21 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Fri, 16 May 2025
 20:57:21 +0000
Message-ID: <71e89f06-872f-470c-86bc-c1429c1b8666@oracle.com>
Date: Sat, 17 May 2025 02:27:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mana: Add support for Multi Vports on Bare
 metal
To: Haiyang Zhang <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org
Cc: decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
        paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
        davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
        longli@microsoft.com, ssengar@linux.microsoft.com,
        linux-rdma@vger.kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
        hawk@kernel.org, tglx@linutronix.de, shradhagupta@linux.microsoft.com,
        andrew+netdev@lunn.ch, kotaranov@microsoft.com, horms@kernel.org,
        linux-kernel@vger.kernel.org
References: <1747425099-25830-1-git-send-email-haiyangz@microsoft.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <1747425099-25830-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4P301CA0003.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::14) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM4PR10MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: 0189606c-16a4-4a38-643e-08dd94bc4077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1lLSWJ4UWJkVVQ4Sjh2akhpR29EVWtTbzl4dVlKNUxwazFESENIc1VXdlRV?=
 =?utf-8?B?cUdMZzE0U1ZFandHSXhGMXgweVZsWTZGMkRVZ3NmTXFYWVRZeUtFdHVwbEFa?=
 =?utf-8?B?VGorRnNGTUx4dXp0M3FjbGV4M1ppZmVMK3ovMXJGeUpNQ0lsNXBYQ2hndGVJ?=
 =?utf-8?B?eTRIdEU5SUFlRGdmR0h6cmFJYW9HVnV0Sy9IcjBkanVwUkRWam9pdjZiUnQv?=
 =?utf-8?B?eDlESDRPRHdUT2NvcWovUEFsWjFxVkVRMGV4alV6N1U5QkV3UTdMNEcrTHI1?=
 =?utf-8?B?Q2ErbUprSDBheTNTMmliSVhsN3VwZUo3ZGgzQ3VaOXVQL3pMU1JJNStINVRh?=
 =?utf-8?B?VmZ0bkdKRTNaNDlQMVNoaFU5UU5nK1BGNEt0MlhIYWxPK3lYdC9Da0V2UC9B?=
 =?utf-8?B?OEl0RTI3ZE11SC9TSExFK0VUUGUwVjdSa1VrZUFOTlU3OC9jQWlMbnZ2cHVX?=
 =?utf-8?B?ZWlua2dPYitjMEZMN29pb2RhZk9OYzg3ZUZjNnRrWHhwV2dWM2dwOGhSK3hl?=
 =?utf-8?B?dFlhUERLcmFycGxPZ09KVitDSzd5UWNJY0NQcXU4U3l1ZTRJUkUxSGZvd3FH?=
 =?utf-8?B?aGw4c09OUVF0Wng4ZHdjbDFjYmpUNzhFUXdaOFNCbzFUZzFsTG5SakpjUGhM?=
 =?utf-8?B?bUhJWHVMazJtYVVCOU5Wd3gvZjMvQzdyS1lNMy9ZK1Z2RFUvRkg5SVh5OG5i?=
 =?utf-8?B?WnpyMnVaTWl4b1dZQ2JhU3RZd1VJeDcwejgxd2hFSWdtM3lNSmkyTzVhbFZV?=
 =?utf-8?B?TWRZTnFZVHFKRFRjUFFyWVdyUVluRTEzSVJvMEZIdDRTWW5kMnorYWtPVCtI?=
 =?utf-8?B?dElCSU80R05LWENLenAzVlJMd0dkK2lZMDArTkhIY09kbWw5YTUvZE53QWJp?=
 =?utf-8?B?a1hGc0Q5cm9Tek1OOXI2eHdFcWJYK2pnWHNSTkYvS2VVYk5ibnhsYmZzclRk?=
 =?utf-8?B?d0paTWNKK3lJUEFWVHV6ekFiNzVmVmR2YVJocERQV2FPaUg1Sk5SK1dDNFFj?=
 =?utf-8?B?dDdZYmszUWFOY08ydEpmSjVkRkZjNGJBdFNQdFQzN25xUkxtcWJOUWptcmRJ?=
 =?utf-8?B?OEUxRHNpNjFJRkl2RFA2VnQwZEQxODc5UzZwa0hSYTk3WHF3N3ZsZW9sWHlJ?=
 =?utf-8?B?QndNOTVMcFpBQ0JNTE56Q0gwU0dMaHRnc2c1Z2t6UmdHSkFLaHdKbCtVOTk3?=
 =?utf-8?B?RldIQ3pSRGxTRWZTRHFUZTdFTVhDUm5wRThMQ1VmTnFMNlhLQlA0SEoydkUx?=
 =?utf-8?B?dkg3NzM2cGNlNFBMcGkxUDJDcXdiaHF3czZTY205dGF6UXlpVUF0WTl0ZHY2?=
 =?utf-8?B?elBCSExoclZTSzJ0cTBTZXQ1L3Nic0lKZGNYVWI0cnl4SlVFZVRub0szdkVM?=
 =?utf-8?B?eGtCeWNTZGM2aitnRnJpZm4wM3h1cXB3UUNMTEhUdEh1N3lqVU9BOVY1c1h3?=
 =?utf-8?B?UjNSekNpMFNrUHJFTnFiMU1kclkvOTJzMDlQN3Zlb0V4NjVLbVl4Mm5zWWZv?=
 =?utf-8?B?UlhaUThZZFF6MkVuRUtDb0twcWdRcENvNGthcnRabzJxM3hTRW9aV1pqcUM1?=
 =?utf-8?B?SE4zbVlrUnBpUmZlVzVITHBhQURPVmdrK2dJeGlkQUl5SnVCSnlKY3VYTHNC?=
 =?utf-8?B?YWJtWVZtU1dpM3BVRVZiWlo0NFZKcU96a1NNeGxXOHdYelhyeXltYmgveDZE?=
 =?utf-8?B?QVdBTVpPdDI3ejVwMW9SeXlYZ0JZOHRvYU1XYnNEVXN3NThrUVl1ZGtmb0Nl?=
 =?utf-8?B?ZXBMSGVvUHBWL1pMbVRuWEYzc0thTFFkM2lVSFk4WEEzb3I0TGd4OWFxMkhM?=
 =?utf-8?B?M1NPUDBsYVc5SnpjUE4zcFJVWWExZDFsNE9zUDlvN1hOamlCZ3BSbG0vNUtV?=
 =?utf-8?B?a29MbzljNmIwaEpmamVVc3lDWHZ4RndTWDV1ak4xbC9JNVpqL3JDTHkwai96?=
 =?utf-8?Q?i5vXkHxtDKg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVJTYm04c2NQQTB1ZlRLeDFmUUVSUW9ZakVLSUJ4QnI0WUlYTXRZeTlwSENa?=
 =?utf-8?B?RW40bExReEdFdHNKVDRyQ0N4Tlo0bE13VDFBU3ZRZkZCU0FvbnpHZ3lPc0FW?=
 =?utf-8?B?SW8zQU81bmpDRTNtNGRlYzRHcVBFc0pCOTVUdFV4RFJkUGhMYlJJeXBjVWxs?=
 =?utf-8?B?YmtVdkRhb1lmN0lwV09vM2oyNlVIaGlsVXFKdlozWm8wMnE1S1IzejhMUzRt?=
 =?utf-8?B?cURvbUZHT29lMFVMSTlpVTEwNStsNHRYdEFuYmFEbWdDMStHb3FFTTQ2YlR1?=
 =?utf-8?B?SmJwNmhYQzZRTHkxcGR3Tnh6VGpIckZhU29GV0xGYThUMmJFMldrS2twN2hr?=
 =?utf-8?B?Y2k3QllQZzh5Z2ZIWkc2eHlPUTY0Y0xLY2c5UHMyZXp6NEI1VjE4bno5MU0y?=
 =?utf-8?B?NE1TS1U3WVNObXJibUdSdEx1bDFrY1hXVHc4WHBydkpmYlZZT2p0aWgzVVlT?=
 =?utf-8?B?emlOc1kybWF6SUNrRzJtL1lwcjd3dGJQZ3Z2NTAzVWsyVDRtdXBsczdBWUlS?=
 =?utf-8?B?TzFadDZXSEllcVVOMHJObld4NDREeWhEeW9SaDJwejBhOGI4Q0doVG9Sdk9n?=
 =?utf-8?B?Y1RBWG8vMWZ3bUFiS3hwaGRXY0lIU3d4d2dEbnQydVBCeTlPQWdMdWdXSzVK?=
 =?utf-8?B?VkpHeHdJRTg0ckxyMHN2M0NuQzJFcm4rdjlxK2R6SkpodGpQTllRak1DWElU?=
 =?utf-8?B?VElLd25pZnIzSUxBbDdMSzhHRlJuWUxPU2RTYzBvemo2dFd1TVZ4NkRYbThK?=
 =?utf-8?B?akdVZndERlNoVWpiVFFqcS83VnhQeCtPakNnTjMwTmtSc2RSQlpxSGJUOE1u?=
 =?utf-8?B?S1hrUmV4OUJUdjVDZVhVTkpnMWIrdUVpZE9ZeGN6SFR5eHVEb0JKSG1pUTVR?=
 =?utf-8?B?cFdlK05kMWE3cFA0b1Zaakx6OWlCL2hPRXNrbU5TVXFncGliczlyQllNQk9i?=
 =?utf-8?B?a042RmZMVW1Md29NbUEvS1AvYzA4TXhjV09nYzdZOENnRkRNOFBsT1RlTXAz?=
 =?utf-8?B?UFJTdDBmSEdZNzdDZVFIOG9tNzJqWEdZQmZtSHhvaDkvUkxjRzB5aVpIcVNl?=
 =?utf-8?B?RjJZSGQyWmZDOVNUVzNJTStYU0xCTGliVm95TUpGSklkZ3EyUGtxMndkajVD?=
 =?utf-8?B?SWlDQ3ZWSGxiSnNGNU5iWCtCKy9tTEF2emg1bXNUQk1La1FoQ2NTRmxMZSto?=
 =?utf-8?B?YW1sN0c1S0tRVjIwbkpESjN6VmZWUWExTXBLMnhTUDhvd3FFOFNtSS9pdDVa?=
 =?utf-8?B?M0NJM3RmalFGTm04NXM4Y1JHWXNFRy9uNzVOVWV2R0lqMG1QRy9sRVNseVdM?=
 =?utf-8?B?VmgvTEJqU3k2TTJUV2RBdDB0YWZ5aHhnSWhEUm80aTBZaTVTRDQwTWprQ0xF?=
 =?utf-8?B?QUk0ZTlkQTZJVWgxRlpnYzcwdWpsSUZqMVMySnVqSjVuek4vSWMyVkZpREZK?=
 =?utf-8?B?R0NiaG1VSnlhekFHTEFGcE5NNW5ZL3k5NkI0SmJBcTlMNzdUdk1CaVlLQm1Y?=
 =?utf-8?B?ZitSVWVXUzJkTSs3V1dTUnpPZDdpR0JPVGppTC96Y3UvaGMyN25UclZOanZK?=
 =?utf-8?B?VTVvNldXSEtyd0lyU0x6bHU5TVhUaDdqWnh4RG8xREk2eTU1amk2NStZeFRq?=
 =?utf-8?B?ZXlpMUFpemhjY1RMdGlPK3lBRkZXYnhYV3JpZnprSmVSdlA1eThNL1Z5N0wr?=
 =?utf-8?B?WjlxWkJ0Zk5yeWRlbjFnTjI2ZENzNjFib0trRGJjWHBkUDNEYnhRWHdYemRW?=
 =?utf-8?B?d3NwMEk4ZENxZ2VpbzNVaHBxQ1Q4NFdlSnN0R3M4NnVmdXF0YldHUFNZajhI?=
 =?utf-8?B?OUREc0JQT2R1cERKMFNFdmNCWmozT2h3cTBXbTdTM0FQU3VWbXUvWFNmSzdK?=
 =?utf-8?B?UWNHVURBbkU2UTVEcDBWYk9SMWJ2KzdYdTEwMmQ1TmozeU9UUnlMazVWQXJy?=
 =?utf-8?B?RDQ0QjRudGdFc3VFdGhnVTJ4ejhNRGVDZU9JcFZiemowOXVCRWlaOFB2UDlp?=
 =?utf-8?B?SHd2Zk1iQ1FiYXpjYVJIK280bmJ0U0hSSXlRSWdjZUwvSzdWR1ZwWmZSNFRu?=
 =?utf-8?B?ZDRyRUtPOUYyYjh3NTQ1NXB5MFdlKzhqelMzajlvekkxWUd2NlNzR2FBdVcv?=
 =?utf-8?B?emtVQXZpckFoNGR5bmdVSXl0WlZqVUI5bUFGWW5sVXpBZjZSRXJZUVJMRHlv?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5VVffNQWnwBVMkiAH3Y4AbVWnGzOemrUnG+oYEGBPWQnWbv4RmIEEMSR0OUl6bhRhG2Z3xDsP7DT7UJ0Ab6AgxvbOZlIR17Z2uSzjv+N4MXrqn9CfcRZ2hWdX/BX1XpSI10vlijkkwBcxJFNbfBVvHIauHn+JlCAATNdy0Z9fu4K+89iieF99gFX+3sdSDf2V/cvKU3Wjqvqas1C2eJxK/XPjvBLVSx0FRragl79GrSuEu3P88D9tVYF2/+91kwkS4aas0KL4nO9jNQ7Z2iyR7ANLcsk970MYBPswtdZZgTedO6erYmNqEBwrRKrNk+G1NqFPDBd4uH1z1R1aGyZu893BGXYVbgN4tAyDz/cOBExO/mLHXt55sJaDowQOIl/h1dP5keTMqXABk/5xWLs4sWitCpnEt9A+kshOz5PeXMuiQ37bleI6DWly7HxR6svYOphoc0dY9Q0zltB6ap4VRDhYF9wgsnhB/ZsxP602jgT3rvwSDnKzXP4pgTedL6w2znI9kGycAkRK4YU5dTMxShFf/FgDO3MnltTk4EfE7x+FIhoXfKJKA2FkrVc8ULEivNB2c9Q4v2hYM0WmDCoO3zp5fMtXQHiQ+2a8s3zU5Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0189606c-16a4-4a38-643e-08dd94bc4077
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 20:57:21.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TcQ4cvuC4JcQUXrKd8kBjhx1fx9qiD/6mT+YQgLf4qXX3eqRRmuwtf9Yhh35IYa7d2dJH/MgDaJWOejtdLAgCj/4Mkzg0nBOGpl0lZmGn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505160204
X-Proofpoint-GUID: XsiWYHm7s7w1gOXpVtCQMgZ1OhbhDtGB
X-Proofpoint-ORIG-GUID: XsiWYHm7s7w1gOXpVtCQMgZ1OhbhDtGB
X-Authority-Analysis: v=2.4 cv=G/McE8k5 c=1 sm=1 tr=0 ts=6827a6b5 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yMhMjlubAAAA:8 a=35hxx62rv_MEpGq416gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDIwNSBTYWx0ZWRfXyzo160tXUlib zN8VDcoIZI9S1LYbi6ZwQZZKAAk1l7SXnTeVAjg3ylbhv0nS6O5v281RPYDgp7zEoBtBEaavj+v fuyPurzawv6jYlY8eWpnr7wjZHc21seUeon1bGZGVSiAWve66diiiRTq7FoWzozqMZMZAeMhQvv
 FEalCeCUnqG6/E32n8TiEQllGV7zszwzHJaz07bFGPeNRrCLbSCR0zMnraPIPHGS+RwCD3E3xQc e0ablhnDY7pcGYd1gXB2gMwGxdcyYVkRLDtJ1VYZxX3+7yNlJgaRUOqvgm117/MfIcATfTguHMa hdY9uayAFVKEC7hSsEejw+MNA3VfRgDinyQF9pXNv9LbQ6kwbSH0o4RBuf8gvv2N2LtmrUTQy4S
 us48BbuCqKOHaKq71B0xA7oQjKF8EiA/25/ghXvvYRQ8fmrkVBfNyTwk2DmX2Xwm92Vu1edA



On 17-05-2025 01:21, Haiyang Zhang wrote:
> To support Multi Vports on Bare metal, increase the device config response
> version. And, skip the register HW vport, and register filter steps, when
> the Bare metal hostmode is set.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>   drivers/net/ethernet/microsoft/mana/mana_en.c | 22 +++++++++++++------
>   include/net/mana/mana.h                       |  4 +++-
>   2 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 2bac6be8f6a0..0273696d254b 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -921,7 +921,7 @@ static void mana_pf_deregister_filter(struct mana_port_context *apc)
>   
[snip]
> +	u8 bm_hostmode = 0;
>   	u16 num_ports = 0;
>   	int err;
>   	int i;
> @@ -3026,10 +3032,12 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
>   	}
>   
>   	err = mana_query_device_cfg(ac, MANA_MAJOR_VERSION, MANA_MINOR_VERSION,
> -				    MANA_MICRO_VERSION, &num_ports);
> +				    MANA_MICRO_VERSION, &num_ports, &bm_hostmode);
>   	if (err)
>   		goto out;
>   
> +	ac->bm_hostmode = bm_hostmode;
> +
>   	if (!resuming) {
>   		ac->num_ports = num_ports;
>   	} else {
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 0f78065de8fe..b352d2a7118e 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -408,6 +408,7 @@ struct mana_context {
>   	struct gdma_dev *gdma_dev;
>   
>   	u16 num_ports;
> +	u8 bm_hostmode; /* Bare Metal Host Mode Enabled */

what about maintaining natural alignment, +u8 reserved0 ?

/* +response v3: Bare Metal Host Mode Enabled */ for consistency.
Even though this comment is optional here.
>   
>   	struct mana_eq *eqs;
>   	struct dentry *mana_eqs_debugfs;
> @@ -557,7 +558,8 @@ struct mana_query_device_cfg_resp {
>   	u64 pf_cap_flags4;
>   
>   	u16 max_num_vports;
> -	u16 reserved;
> +	u8 bm_hostmode; /* response v3: Bare Metal Host Mode Enabled */
> +	u8 reserved;
>   	u32 max_num_eqs;
>   
>   	/* response v2: */


Thanks,
Alok

