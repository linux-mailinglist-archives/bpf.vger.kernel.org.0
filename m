Return-Path: <bpf+bounces-71387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C3DBF0AEE
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 12:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDF0E4EFD36
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 10:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEE325228D;
	Mon, 20 Oct 2025 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LyYDU+2g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g9aTSaOg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D520A23507E;
	Mon, 20 Oct 2025 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760957638; cv=fail; b=i+zUYU6u8oWdfH27ah7igUvcIP8dqabmFJRUT/nYvjomjLm/nNVSvc8wUKUrFsJeYpr4zpv3imGI/MXGc41qsS/CdpYGjSOQi15KnYlXo7hYEIQHzJU93LVy5E04chFcX8JuOYpoD0I5BqIlQ7nlRsbuQalbhDi4hInuo3e1dLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760957638; c=relaxed/simple;
	bh=Nnn3ox7egjJrpx0w+5fkjD24zAzl+cNaxBiKsOhzxew=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MszkV3xorij+309kCrbIl0bkZriEPJC147lDrU7R5qcwvsu1ZB/n67vB6f+D0bSzT2SHfDBJDCJrdxgEszv1zjwpnEjvm0vsPg+Rs9qVTAfE7ZFyAQQ6Ji/SWZoyZv0gArZ0QZoBU9mUf4IYZHf55oRQQxRZaLOBE0aoNQZZ71k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LyYDU+2g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g9aTSaOg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K8RmTL025511;
	Mon, 20 Oct 2025 10:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AdI1cMpO6IVhYzp6pet1HUNv1dHmYRWP+P4C+R463ds=; b=
	LyYDU+2gGB57MpqEezXvMREM3tvhj06wkB4F8MrHKsQQ+JoEjI/37z3eV6Waxy16
	qndZgNQTnPOMiMSi0KV5AqwfaXooPaBafmHk6GIBZZSO90sKAMjXh3isnSufKwmB
	PtDmIwAAYqfcCFpEHFEuuzOICRBtCR2TQNmw1/Hs2CgkLFZdBlYo7hIqZYAmxMFw
	rS3R62+xSR+h7lRCC/ecSzcY1xpDryeUsigNV/qG/bercg8hvEc0vpcHjFAg/BUx
	oibmWCbZ7CDJrlv219i6xwJZFCO2VmCKGpAGqIbyL+f8I8KQ5s+FATMnDR4M13Fx
	ztDBKm7l9eib7V+eQc7drQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v3esj09u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 10:53:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KAANw1009365;
	Mon, 20 Oct 2025 10:53:29 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011018.outbound.protection.outlook.com [52.101.52.18])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bbte3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 10:53:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWy76bR2pnwx8XzNXT3rVuhlG6NyDiUcKNBkOumTnXroAzQ+lRsovhNAQ3rpna0sUzOi9awAhJbvCDO96hs0r7TPUHogMZG4R/OpRCh7shMn5O6UcFP7+yYck3MySgNwWXiGPi/J/kkfXGNPcFM6jTRVHQedtOqRfuRvBAL9ni9/j+XzIly/LZrNMspAiRILyiXZpwNP+gcx1WJaO6xToXn3zIMinwkTsWDrrfSocunEPDBgCxxxO8Ypn0aAMU3sjtgL0mjYmukgHYu3heaVgDBfxfQnNeWjf9NDVSpwXB9Hw2no9rvATB0LxQlr+k303kuQECa1cB4GXk371UwYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdI1cMpO6IVhYzp6pet1HUNv1dHmYRWP+P4C+R463ds=;
 b=HZGjJQIqQDMTwku70kkEeQCRDBUNODZ4GCU/IzEgRFQGxIHX2gk2KpOD1ySlhokZliyeriuebc1K6yFdnSIIts/ceA0fHpBobWNSiq9au1S3W7OSW0gNQHlt3lr2ISWQKVZFlEMKUra+V+qkZzPFN8JPnXBWyjQYscpRxPfBvjBoTGZr3JuCzzPiV8g2tq0bkbpYpJC13Hcf9vi5Hx4+yTzD/oAbpGbSj6X2UsoBqVEx3v2CUmbtC/+flO0VCP/DSozQc5UhY10EoIXorsMGstGf2pfEvGC+iZFJ6b92NKRDVgrf3vNlM14U4NkQUcEOAHMLjnICmUo1jaV/Ux1syw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdI1cMpO6IVhYzp6pet1HUNv1dHmYRWP+P4C+R463ds=;
 b=g9aTSaOgzDYtKAF7FgJ5vWUIVajSrFffvIIfvHVqzkEhH5Zo+QPrzXLnB+04My48tO1AZvyqBDKMJ16KaIPRdF4gdY2vPD+eCmy0I5dHp2eeY4sXl2joz8EYsMFyJU7gH1G2qqXi/7xOwr3/7I4dtmwwBcxhw4zwMbqHzNmjGMQ=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 MW5PR10MB5665.namprd10.prod.outlook.com (2603:10b6:303:19a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 10:53:19 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 10:53:19 +0000
Message-ID: <2dce0093-9376-4c06-b306-7e7d5660aadf@oracle.com>
Date: Mon, 20 Oct 2025 11:53:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] pahole: Avoid generating artificial inlined
 functions for BTF
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@fb.com
References: <20251003173620.2892942-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20251003173620.2892942-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0071.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::35) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|MW5PR10MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: b115849d-27fb-4ac4-d2bf-08de0fc6e12d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGM0VW03TGFXNFduZUp5eXdYVmhWSHF5b05TOTR2b1lkTDM2NHp0OUgvV3BG?=
 =?utf-8?B?S1M3WXB2WHBpdFNZSFlQa0l5ZW5HWWpMdHZSd1AxM2JKbUlyaTlFWXJWWXlr?=
 =?utf-8?B?TU41RDdycE5RdTlTQ1NuOHJ1aWYvODRlT2NWNGcxYktpbm5yZiszczQ1VTFa?=
 =?utf-8?B?ZGNJYkZWTUxmS29Ec3JyQ0l6SS9VUEI2dGcrYU9wcjZDd0h5MjV1ZFFnS2h6?=
 =?utf-8?B?aEpPaElURm9xQWpJMlRlN2RzUDJWNnpYTCtQOWo2ZkIxeFRUTWNuQ3pWSENB?=
 =?utf-8?B?blhmYzdsWjBlZHU2cjg3NS92TS9rQmZVM0c2RVZIRndLSk9GbmYzanlrL09o?=
 =?utf-8?B?UlFDcVpjaW1nVFh5MXdPYWFlRUw1ZnVkT2FPeFdFNk5uWElzdmFVbDlJN2lC?=
 =?utf-8?B?WmtuaEEwdUFJZzBZbXdhVytOQlNjMnJjN1Y0UmoxbW5kMUZJbXhudkszcm84?=
 =?utf-8?B?S1lMVXlSS2JOZHpZWHR4UWsrTHNybUw1TWRPSVlkcGpIOWdDUGVEYVVKcGdK?=
 =?utf-8?B?ZGN3OTJNUm5MN2M0Y1JiQThsL0k1bzVIYS81QlVpSmxvdjhGMHBOOVkzWDFj?=
 =?utf-8?B?d3VEUzQ3bFp6NVVwb0R6S2Q1dFF3c0w4cldLeURyM1BIdlNWUHZrek1qNEpu?=
 =?utf-8?B?NXl2NEN6MTdZNGN5eitoeGhscE5DdkRlcTIwc2ZjREZEWDJRQzd0K2dqWGlp?=
 =?utf-8?B?eVNtVVVJOWFkeDVQbk9DVDdHd2JXUFQwdG9lVVpMNzYySmhKckdzU0lmNG9O?=
 =?utf-8?B?cytFTGhrcnlQemJLOWJsMEpFakgzWGtYNlFMSnozRXBzMjlKR1VIeVRrZmdw?=
 =?utf-8?B?UlExUTdoa1k4T3J2aGNjN002aXhMNXcxY2kzc0p0NVdsNHJGWE0vNVlLQ3ho?=
 =?utf-8?B?THFsZmxHZzNJQWRMV1N4T1BEMmNyN0VxY3IrdTlXTWlFUmNhK0w4eVRmeG83?=
 =?utf-8?B?ek5YSStTVDQyUTl3ZjFOWEhad3NZR1lib0E5Mk9YdE5zaGlhd21URkpUL1Bp?=
 =?utf-8?B?UXd6dmtZSFd6MjhiN3JHVVQvVEI3d2ltcEdTSU1QM0w5bkdEMm5hWk9RK1V2?=
 =?utf-8?B?VWo0dWVXSURTamRFYXFDeWlIenRXdGVBZVRTUmlUNlNWYUZIbUJFZ1dMbEkx?=
 =?utf-8?B?Z0xFcGlCVWRnTlpwUE9xOXo2OWNFS1YrTTZtOWxLQWJqeVV3MFdaMlduQWZD?=
 =?utf-8?B?YjFkZEszUm55OFJ4bG9JcjlyOUM4TnlYbW1tMDM0UjB3YlJOYkpxd003UEVY?=
 =?utf-8?B?QjJta3NsQ09vUDhocDl0RENURGNqd1g5TUhtVnE0TWJ4eTdEUy9rNWFNUW1Y?=
 =?utf-8?B?a3J3NDF6RnMzeXhlTjBoemFUNE5ObTR3Tmp5c1NEVy9IanZsSTRiK0s4ckVN?=
 =?utf-8?B?bGhuNjgxS2IvOVhCOVdQcFBmUlFZaUFmelVsOUlVL29LSFYwMHhRcDhCN1hX?=
 =?utf-8?B?QlFxMU9UMGRnQ0JrU3lFUDNsVnNYSGcxODhYWkNZODNTb1BZNWFTcWwrUWsz?=
 =?utf-8?B?RXplNW45NFhjK01WdWNiU3FsTmlZb0kyN3NtMnZEbzJ1cG5NSktiem54WWRy?=
 =?utf-8?B?bnRiTTZGajFtc3gzRFFER2h1TXo3ck4zck9mU2VVZUNLaE8xdytnTkxNekYx?=
 =?utf-8?B?MTlsR0ZOSjZ6aTA0a1lLQ011ZVpqQVhmVm9jSG5KZjlEcmdhQnQweU9kS09V?=
 =?utf-8?B?VmFjb3pMZ0FVdGJpYmwzYXNVQkZ5b0RWNHlQTzluOEUvMFQvRUZKeWVYanli?=
 =?utf-8?B?SkE1anhONHRaVkl6ZE9BZ3R0eG5OdzFyNWNRWHBKbmVpbnlESDZhcHFaR2tw?=
 =?utf-8?B?M2M5eU5zcVJReW5aQUNNQm9VMmpWVlRyMUswNUhjQTdaakN5bmRmdWE0RGNR?=
 =?utf-8?B?MTVoWm5uNTZ2eUNTQTZ0ZFVLbXZIbldycXRmeHFTekdhNGVmOS9iRk8zOUZW?=
 =?utf-8?B?N3Z5N1g4TFBiMFZGQnQyOXJPMzNvb3lxTTlFNzB5Y1NGc3hDQzhnUWdLSUhO?=
 =?utf-8?B?UExaR0VsbHNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VG8vL3g0dVpsS25ybU0vcWZnYyt3RFZTY2NOQ3ZjUE9ZanJibnIrYzBLckVR?=
 =?utf-8?B?ZTJuWVN6MjdQNncvZ2w4UVZ1d1d0Y3pHTitkNUxKb3I3aTdFWjROajc1Z2px?=
 =?utf-8?B?UmN3M3NaQXZQRVBXMW5nTUFTdXJuUDQxR0JhQUhodEdqMDBPdFdPMkthcmZ1?=
 =?utf-8?B?THoycEFBWVZzbjA4di8wbTExeFRGay9YUEpVWVJjc3JSNzZ3QTcvTVAwdHZ5?=
 =?utf-8?B?TzB6VzMzc3NVanUxdk94MldTcmc0VXZGR1ppOTBKd1dteW9iVWFCWHZHS1N6?=
 =?utf-8?B?NVZDQTBYL1Vkd0dqOTRab3NmNlRSeHE1RzZ5Rjk4d0Y3Ulc0R05VWkFLNG1C?=
 =?utf-8?B?Ynk2L0toWnFjRFF3d2pGZXFyeFVUTkZxUk9lb0EvK0E4UGtqRC9Tazh4NTM2?=
 =?utf-8?B?cUd4SEFrWEkzeXc2RVh6USt6aUVRblhUdFAyckVqOVpvWTI0Ykp4cVQxMnNt?=
 =?utf-8?B?SFM2bzZKQ3kwdkRtUmtGaC9LLzl2Vk8zeVFtYVBPRzZjL3FFV3M5VEx5MVcr?=
 =?utf-8?B?QTQ4MlVKQ01JdFlyODk5aVBBbjYzWlBrS3RnaHJlb3BWbW5nQ3hpYXJVRkxi?=
 =?utf-8?B?TjduQklWMlJkajhPNGNiMVh4dHJJUVJlWnd0OStQUWVTdHBxVzQrYzkvU2da?=
 =?utf-8?B?d2lXQ3BGaFlobTZmY1R0dU1OMkdnU292RCtiUlNyWVRsQ2FDUHdOaWRjb1VR?=
 =?utf-8?B?UC9OLyt6V1hIMWxvd0o1ektxMEIwb3hhT0RFdGcyZGhkdkhzTnF4MnBjNXNL?=
 =?utf-8?B?c0gwbngzb001ZG50ZTFEcW5GRXdjVkxzQ3duak5ZeHd6cXJIZXpOTUpFTGdS?=
 =?utf-8?B?SzJTeDV2ekNTUnZZQ3dkYTF0L2szQkM3b2pKSlZIZStHcXlQWVlsOWdQMFVs?=
 =?utf-8?B?S2tPcFdTRjFQVVZqbi9hVXQxN2NLaXo4d3piRHlnRkxLOWJpYjBVTkU4ZjBG?=
 =?utf-8?B?T2VlajdrWFNqblBLZzhaM2VDZzdpRFFOVWkyUnNicTJuckZPZTRPVEdIbFNV?=
 =?utf-8?B?bmtlTytVZVY3TVFyWjdWZTNwd2RpSDhaaEg1U1kyS2djMVNtY0FFYUZGR29M?=
 =?utf-8?B?NVBmZnFnK2xpYlovQmVXUTNLVlVCQUxGWWlJbXYvOHpVMW1GQ1FNc3RhUEVw?=
 =?utf-8?B?SnV4a1dLREZvSHlxQzhZaVVDejRMdkVMbC9MczZsazc3ekFPbmw2OHZKSXhU?=
 =?utf-8?B?eXd2R0g2dDFIV3ZpZWtZK3BYaWlOc3pKODlJc1dRR1h0RkQ5anYwWnViVWZI?=
 =?utf-8?B?ejYvN3dESXBPTVplRjdLV3NpbzExU3RSMmMyaVoxNk4xWTczUDdibnhQS3Fa?=
 =?utf-8?B?SElLQVdlQ0Q0RWZ6bEFaM0kxUzAwSUVTakQ1cVhlTXFTSjFKMmRQS2dTMnE3?=
 =?utf-8?B?c1o5Ukp0Ni8zNG1VR3gyTjE4Z0k0MmpXanFkT3VpYW9BR28rd1d5NzVONU93?=
 =?utf-8?B?NkxaOTlqR1d1Rm03dG9jWnQ5VTVhMjVOSExBT096U2hHMXNZSTJVV09qNTN0?=
 =?utf-8?B?YldJSUE0Z1R2YXZ4ZGpOWFFXNkd1dmI2RW1Cdjl4MWVVU3dOZUtiOWtPckFz?=
 =?utf-8?B?ajQzWjBDTGR0cnlNbUFmSlJzOWdCejdObktQSFFpMmZvKzJ5bnB2bW5uSzFW?=
 =?utf-8?B?MlF2NWRIL1ErMWhCSzBpOUhzZE16VnVrNGJSeGRPL0syZDludWhPbWNrTzN5?=
 =?utf-8?B?UTZjalNDTk13VjhmWXYyc2gzang3WnVuREJmalpvdW55V2VRTEVvK2xnMXNu?=
 =?utf-8?B?S0w2R0FOcVl3M2piRHBCRi8zOUVFdUQ3TW1xWjNOdFhnVFBwUmNNeUtxZzFj?=
 =?utf-8?B?MVBrRHRnQUVBZGdFWVhENSsxS1dxMngrc3JLUDl5Y0R2amVyeFJycTVyK0Fi?=
 =?utf-8?B?WHNWUzV4R1Z3V2NzeG9tSmxsN21RR2ZOejJ5MC9MRkxqK2ZNN1dENWRMcjJX?=
 =?utf-8?B?NEdHdlhqMmE5bmxXY2g1UzIzUkdjeUZHaWM4dEpMSWY0ak80Y0orT1pJdm1t?=
 =?utf-8?B?TVlTaTgycllvZDRvS2dGZ2MvbXlTd09DUFBuSWxtcG5EdXA1ZzJGL2Q4Q3Fj?=
 =?utf-8?B?blgyVUNWcVdhTWMxRTVDV1Q2aGNMTWNRQm1RUlpIMDZXWnJ0aVpPamFJVFZ2?=
 =?utf-8?B?ZmV6aWRoN2NHYmJ0ZTE4NzRwdWJGazNtOG5EV2F2K2l5cjdHMitJOUF4TXNx?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FjNilORbUXLW/VnQYYCsXHOBo/SOvbYwhDuIXAweV2ySh9XK70wYPriTkv+/oumwDFATxNgwECcHTzcyJ1vyXaMMX2KMPzwmGLlQqDppAWVD6y3JAnNFpmrdc3j3ll64H+SjBe0TtxzFHx7/vBNSk3+5f6BRXI0x2oFFtAsWTrSsN5CHUFAifcrys1WW4f++6X/PUziV10UOiw8drD1oJb01c01OlMRCn02RlvVlQ+DjyWmVL2IwwW8KoCvRDCuKP0rwILC31AaOapolPZaGHlS6r+FRDvg6rO5xETfpJOSPZKD4ZdeI/VcfKjtCx+tTfEMSFr0LTLkUXUZoV8oFCAkZPjpYwtCRlm9PpzaI5vBYWms9GNLr1eNz89OBI+TnvHvabYIOV52lMXm3xkjJXCr1pH7s6tbrcDi8FAxb8Hm8/k8+zsMpA8Se7XunuX6bAFtq/eVkMppdnqTFR8PbVIfEoE2qrJFPwG6zD5QW99WlOQLQ3IBR/I1PoWZtk/haRt7szBhdsYwDp4dP+DtT7U5DI/iVdzuNTpyHy3+BDIYySxJDnBBHlH8ABGs3MopCoAjLeP2BUdXAdImqNhIQFQECZ2WZ/vkBO2bVPXj9HZ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b115849d-27fb-4ac4-d2bf-08de0fc6e12d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 10:53:19.1798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ypa7kynZCNP6epFbHLdv+HeuWUoydn0hXE8UlpMkKQRJ7GjeCxlhmSQlmlkcbHlX0WbyInBeP1HM0zdACzhT1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5665
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510200090
X-Authority-Analysis: v=2.4 cv=N8Mk1m9B c=1 sm=1 tr=0 ts=68f614aa b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=h-_jadSY8-GYbqd8pdIA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12092
X-Proofpoint-ORIG-GUID: WCPkvc5i2UCsVTHcHiBubfGd2xOCopKr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNSBTYWx0ZWRfXyy7mg1ApREPm
 wVCwhdUtaaDxadLM3fSgZwkYdKXpau/sT1Rq1H/dNJ4SxPhDKwUPpNqTVQSOKMdyWiow7ON/atG
 W0ncaM/m1UpKfYi/9svVS+zoPO2gDw3MEDLTQ5yONCvNKaE9nBwPTDDPh72OlV0aUJjohLF738S
 KbV7zgqeKX8Y7hl48wUc4ibwU1ncBxZzXoVHJVAzwb26J9k7F2Wfi5QUQBoZ2eCzjKWLHtlAsTA
 VA3q0/NkRFyPKXs0neCAon0uR+pLg5JgZcqbjYxOtD8E04snUnmxF1vfzAKPjx0sYjxSPfdJIx0
 JFntmxHCPpBwULttU3lzC1Ctz0yy27vfJQquMX2ak5LHKNn+r2Eqh2c6SykPqFbnUqmS1Bg8M+C
 rAzynIzpmeX/wEKgpeuYg/RPZ1JYK4/JVr3B48MkBOX+2rIby/U=
X-Proofpoint-GUID: WCPkvc5i2UCsVTHcHiBubfGd2xOCopKr

On 03/10/2025 18:36, Yonghong Song wrote:
> In llvm pull request [1], the dwarf is changed to accommodate functions
> whose signatures are different from source level although they have
> the same name. Other non-source functions are also included in dwarf.
> 
> The following is an example:
> 
> The source:
> ====
>   $ cat test.c
>   struct t { int a; };
>   char *tar(struct t *a, struct t *d);
>   __attribute__((noinline)) static char * foo(struct t *a, struct t *d, int b)
>   {
>     return tar(a, d);
>   }
>   char *bar(struct t *a, struct t *d)
>   {
>     return foo(a, d, 1);
>   }
> ====
> 
> Part of generated dwarf:
> ====
> 0x0000005c:   DW_TAG_subprogram
>                 DW_AT_low_pc    (0x0000000000000010)
>                 DW_AT_high_pc   (0x0000000000000015)
>                 DW_AT_frame_base        (DW_OP_reg7 RSP)
>                 DW_AT_linkage_name      ("foo")
>                 DW_AT_name      ("foo")
>                 DW_AT_decl_file ("/home/yhs/tests/sig-change/deadarg/test.c")
>                 DW_AT_decl_line (3)
>                 DW_AT_type      (0x000000bb "char *")
>                 DW_AT_artificial        (true)
>                 DW_AT_external  (true)
> 
> 0x0000006c:     DW_TAG_formal_parameter
>                   DW_AT_location        (DW_OP_reg5 RDI)
>                   DW_AT_decl_file       ("/home/yhs/tests/sig-change/deadarg/test.c")
>                   DW_AT_decl_line       (3)
>                   DW_AT_type    (0x000000c4 "t *")
> 
> 0x00000075:     DW_TAG_formal_parameter
>                   DW_AT_location        (DW_OP_reg4 RSI)
>                   DW_AT_decl_file       ("/home/yhs/tests/sig-change/deadarg/test.c")
>                   DW_AT_decl_line       (3)
>                   DW_AT_type    (0x000000c4 "t *")
> 
> 0x0000007e:     DW_TAG_inlined_subroutine
>                   DW_AT_abstract_origin (0x0000009a "foo")
>                   DW_AT_low_pc  (0x0000000000000010)
>                   DW_AT_high_pc (0x0000000000000015)
>                   DW_AT_call_file       ("/home/yhs/tests/sig-change/deadarg/test.c")
>                   DW_AT_call_line       (0)
> 
> 0x0000008a:       DW_TAG_formal_parameter
>                     DW_AT_location      (DW_OP_reg5 RDI)
>                     DW_AT_abstract_origin       (0x000000a2 "a")
> 
> 0x00000091:       DW_TAG_formal_parameter
>                     DW_AT_location      (DW_OP_reg4 RSI)
>                     DW_AT_abstract_origin       (0x000000aa "d")
> 
> 0x00000098:       NULL
> 
> 0x00000099:     NULL
> 
> 0x0000009a:   DW_TAG_subprogram
>                 DW_AT_name      ("foo")
>                 DW_AT_decl_file ("/home/yhs/tests/sig-change/deadarg/test.c")
>                 DW_AT_decl_line (3)
>                 DW_AT_prototyped        (true)
>                 DW_AT_type      (0x000000bb "char *")
>                 DW_AT_inline    (DW_INL_inlined)
> 
> 0x000000a2:     DW_TAG_formal_parameter
>                   DW_AT_name    ("a")
>                   DW_AT_decl_file       ("/home/yhs/tests/sig-change/deadarg/test.c")
>                   DW_AT_decl_line       (3)
>                   DW_AT_type    (0x000000c4 "t *")
> 
> 0x000000aa:     DW_TAG_formal_parameter
>                   DW_AT_name    ("d")
>                   DW_AT_decl_file       ("/home/yhs/tests/sig-change/deadarg/test.c")
>                   DW_AT_decl_line       (3)
>                   DW_AT_type    (0x000000c4 "t *")
> 
> 0x000000b2:     DW_TAG_formal_parameter
>                   DW_AT_name    ("b")
>                   DW_AT_decl_file       ("/home/yhs/tests/sig-change/deadarg/test.c")
>                   DW_AT_decl_line       (3)
>                   DW_AT_type    (0x000000d8 "int")
> 
> 0x000000ba:     NULL
> ====
> 
> In the above, there are two subprograms with the same name 'foo'.
> Currently btf encoder will consider both functions as ELF functions.
> Since two subprograms have different signature, the funciton will
> be ignored.
> 
> But actually, one of function 'foo' is marked as DW_INL_inlined which means
> we should not treat it as an elf funciton. The patch fixed this issue
> by filtering subprograms if the corresponding function__inlined() is true.
> 
> This will fix the issue for [1]. But it should work fine without [1] too.
> 
>   [1] https://github.com/llvm/llvm-project/pull/157349

The change itself looks fine on the surface but it has some odd
consequences that we need to find a solution for.

Specifically in CI I was seeing an error in BTF-to-DWARF function
comparison:

https://github.com/alan-maguire/dwarves/actions/runs/18376819644/job/52352757287#step:7:40

1: Validation of BTF encoding of functions; this may take some time:
ERROR: mismatch : BTF '__be32 ip6_make_flowlabel(struct net *, struct
sk_buff *, __be32, struct flowi6 *, bool);' not found; DWARF ''

Further investigation reveals the problem; there is a constprop variant
of ip6_make_flowlabel():

ffffffff81ecf390 t ip6_make_flowlabel.constprop.0

..and the problem is it has a different function signature:

__be32 ip6_make_flowlabel(struct net *, struct sk_buff *, __be32, struct
flowi6 *, bool);

The "real" function (that was inlined, other than the constprop variant)
looks like this:

static inline __be32 ip6_make_flowlabel(struct net *net, struct sk_buff
*skb,
 					__be32 flowlabel, bool autolabel,
 					struct flowi6 *fl6);

i.e. the last two parameters are in a different order.

Digging into the DWARF representation, the .constprop function uses an
abstract origin reference to the original function. In the case prior to
your change, we would have compared function signatures across both
representations and found the inconsistency and then avoided emitting
BTF for the function.

However with your change, we no longer add a function representation for
the inline case to contrast with and detect that inconsistency.

So that's the core problem; your change is trying to avoid comparing
across inlined and uninlined functions with the same name/prefix, but
sometimes we need to do exactly that to detect inconsistent
representations when they really are inlined/uninlined instances of the
same function. I don't see an easy answer here since it seems to me both
are legitimate cases.

I'm hoping we can use BTF location info [1] to cover cases like this
where we have inconsistencies between types in parameters. Rather than
having to decide which case is correct we simply use location
representations for the cases where we are unsure. This will make such
cases safely traceable since we have info about where parameters are stored.

[1]
https://lore.kernel.org/bpf/20251008173512.731801-1-alan.maguire@oracle.com/


