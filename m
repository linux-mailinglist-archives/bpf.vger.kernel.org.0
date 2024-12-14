Return-Path: <bpf+bounces-46985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083919F1E7D
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 13:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12FD9167312
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 12:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789C718FDC5;
	Sat, 14 Dec 2024 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DTlmaaCS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zZSJq9Eq"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C210914884D;
	Sat, 14 Dec 2024 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734178536; cv=fail; b=JiJFj1iv8rCusfWRU4iHxdnj542nsWLQnjJqpe7AjT9cjY9eP0zCDyOn6ykk3eAAogkt8LsPcgOgoy0o5CVkvrYLDsLhCOYqln8Rdbeot6cRA+QBsZpyClGaokmdsKDkyKWZ2mVAj5pElc2oehf9SY9s3rQLdbODPrsA7w6ptUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734178536; c=relaxed/simple;
	bh=UH9NLWgL89G4i1K4LF4xy1OaIeC+AUH7TqRk7pDGErc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zg49YC4RQsTM0B4MAuzFHXiAckq+FBV2uY8Bo7Y4Kx3I+Odrri+cMgaSGpm70O/t2yBP7xSyI5h2n3NuFahHEPha6/fjutd0CC/cr5iljCiZnmUNBti8qv2KgBuiHFFVFQa3lsBKcM/A30Wa8ZQueCQk1yH4PjUz7pXvo9ROePA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DTlmaaCS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zZSJq9Eq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BE7hvcc019087;
	Sat, 14 Dec 2024 12:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=k2gT3hqdXDwn5RnXqJ2mbc6HFZKwxeEm6jstfGvGthQ=; b=
	DTlmaaCSUpi2u9xlByBvS4cKnWsSQghEEfLqdASYFw1y7BuueqJvFzGZIcl8Zcpd
	YllUkiociSiDDy9QzwKVpiFeuuX9dKeUIN7ArsDpi0PQSr5f7MLk2dQHxuLVyFdn
	gsazj9dk1pCl7yDwcfgSGpcxyIkIaByXyJr1wD2a/FLjw7E/zMVl/b/+5cL7MBEZ
	RyH2WC1uCFW83eKLX+hEfpE+vDeQSFxoSZqBhVQfTLjbb8zdaNygyH3lznvjQYO8
	HvoZPil1F/2adBNXxuCEIpC7ZJ/hqgw3RK2NVfz2bySzMw/MKAdeRG4JoAoTfmmc
	4+9YLBeYR5LaTmEpg8c9jQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0xardmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Dec 2024 12:15:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BEAGqU7035486;
	Sat, 14 Dec 2024 12:15:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f5j0bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Dec 2024 12:15:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asBLYRYXUqbUcdc2qXekE0+iJ0E49KmWj4BqciXiuP/NMJNlTudvmlcfHj6YJMy3V7LT3Wr0dm7LIwhcvNegkzSR8S3Ss4pnip0gHSwliu5pVfTAt8xVf4nUdbOQ/Vp6EaRA5DrPWR3M1EWK47JkDObZTL44G6VkFRCAJLUiR1AJHjo7G21FxFa00sG10MY4E9lThHmBRqCjaUfpxD6i/9LqUFq+G+d0XDddMRrgLQ2LZmhqR8RJn3gJ5VvUYXq8S2usY5Yg5WqNXPXWbI02hMgoz0Dok7Vvc+MPclZMbJuwSCcv5L8KJWIPjtp39qQeEebWweojrSXoMLpcRQ6QqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2gT3hqdXDwn5RnXqJ2mbc6HFZKwxeEm6jstfGvGthQ=;
 b=qb3dew6G+/iy0xUu1e4wqnP35JhuZr09hUXsk4OyjEHBV6sntg3fFDiIcNEZJod3QRi8nrytMIg/bcyUzQrwAjXFb1o3KyhGXtkzseadw/oPnnRjYrOBNAkVmW7p+aPn6hsa4qRXLOsV0grwef3x1Gs/kxJWWI8qg+DTZvb/SaJQlsiztxxZFpW/BDXAqu5mNE3alaA8usHRrIoBzo8Cd0cRZDHcSa55vYfNNPu+EzZA9IAj+z8QNvrpjUcg0h575+NOIVgn8a3vFGfVBqG6uvrsL2Z/zkDRMhyjoo8lAioYarrdv5JuvLDLfEaad8fo04sXDxgZdOc/fwB6hEXGqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2gT3hqdXDwn5RnXqJ2mbc6HFZKwxeEm6jstfGvGthQ=;
 b=zZSJq9EqcAdwuIW2H/FOAyoGz/R+GoQx3479z0DcUR3YA3lKgCtjWhODPHAyeg3eT+NPxehSVjgmbyWonjX6l3nviBAi2ciSiA3fDYcbVuc0SK586mamQ9EMMFa+sUYgKtOaN6lk9eaoQnwNWd8YR5Ua5yqUpbckFnrpaXDPY1Y=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CYXPR10MB7951.namprd10.prod.outlook.com (2603:10b6:930:dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Sat, 14 Dec
 2024 12:15:28 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%3]) with mapi id 15.20.8251.015; Sat, 14 Dec 2024
 12:15:28 +0000
Message-ID: <3be0346a-8bc9-4be1-8418-b26c7aa4a862@oracle.com>
Date: Sat, 14 Dec 2024 12:15:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] module BTF validation failure (Error -22) on next
To: Cong Wang <xiyou.wangcong@gmail.com>, Uros Bizjak <ubizjak@gmail.com>
Cc: Laura Nao <laura.nao@collabora.com>, bpf@vger.kernel.org,
        chrome-platform@lists.linux.dev, kernel@collabora.com,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>
References: <20241115171712.427535-1-laura.nao@collabora.com>
 <20241204155305.444280-1-laura.nao@collabora.com>
 <CAFULd4a+GjfN5EgPM-utJNfwo5vQ9Sq+uqXJ62eP9ed7bBJ50w@mail.gmail.com>
 <Z10MkXtzyY9RDqSp@pop-os.localdomain>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Z10MkXtzyY9RDqSp@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:3:17::33) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CYXPR10MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba7cc1c-0aca-4e11-2048-08dd1c38ff02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXZyWEJkWDlYdC8ySTkzRGg4MTIrMlo5TjVNQlpPeHg2UU9sK3hyQ3psRmRT?=
 =?utf-8?B?ejRRZ2krTldHUm9CTzg2NDNHcVRwUzBVVEg4em9oSEZDUUVoS2dRdTVUbTFN?=
 =?utf-8?B?L2thZmttTlZVVTNCTk9BZ3BOYkZHOTdpNVY0Y3B0Uno3bmN5d1pJT3VKZVl1?=
 =?utf-8?B?NEJqWFFIaG96YmpoV0JCLzBPK2MzejJ6QVZsNkJMNTByMWN4T0IrS0JmZmVX?=
 =?utf-8?B?dExOZ01XZm15OEZXMzZkSW5tTEV3Y1dvNWF0bEJ4MG1UUFpkK2FNUEFmVUt3?=
 =?utf-8?B?bmRIbzBJTnQyVkdldUxaYjM2NWcvUG5pR1RrM0Y3TUVqbzAwQXZIUFhXU0Rk?=
 =?utf-8?B?THpXZ3NqQmNaL2V2SEN4SXMwaHQrRVV2ZDdMYTRueGJ4YURlT2swYjRDUXJI?=
 =?utf-8?B?ZzlQZFJndlRVc0hTeEFJcmgrTDRkOFpoYUFKMjAxcXMwMlIvMTNqenNDKzgx?=
 =?utf-8?B?NHlXTXh0WVlSdDl6Rm9kV2k2TkNkNGY5dmZyU2FzWHJxSURvbFR1TnFTWjNm?=
 =?utf-8?B?S0RPWmo5Z0NHYnpuR2hlWTBURkdaUW1zRzBrSndnMGFtYm1FZzdYa29qNHRu?=
 =?utf-8?B?UGFYTU1sQmp2a3ZoSHB2dGJtYTJJK0twdHF0dUFUa3NBcFhYdnlQZTRXQjg3?=
 =?utf-8?B?azN1eDRrTmZQTkhsNGh4RFlhaEx2b0lORzNWL0l6V05SU3R2Q3BkbnAwOWFI?=
 =?utf-8?B?SnBBRDY5SzM5c1g4cExjcWYxUm52bzBnVVl1RTREZVJHWGRPVE1kWGJHclVK?=
 =?utf-8?B?YTdCZ2MrUitocEJGUHYzWGpxQmhpNWk2QkZQVmtJV010cGtLc0lvNWYzS3lW?=
 =?utf-8?B?d0tWT2FURXV2ZWtRTENFTHY1RThPM0hMdFJ1TllQbjlqaXdKQm1JKzRueGtH?=
 =?utf-8?B?aHVMZFBybEVYQ3ZpSUZaOEM3TGdRZWNTMFoySDMvenVrRE04UG9rM0FGSCsv?=
 =?utf-8?B?MFIzMXN6TnJnNDZQYjdPWlVKb1VtelM3NzQyRWxzTVpyczlEOEUvZ3lPYVFI?=
 =?utf-8?B?czVLTCthUHF4RG5YanZsQnFFQ1FyOGRSSWxBd3RrdHpSMjlZQ2REazZZdW80?=
 =?utf-8?B?N1RjbC9BZnlNd2hLYUh2U0d5anZWaXZmT3hMcE5UU1E3UTV5aGJyZCtHU2FV?=
 =?utf-8?B?NWU2bmRNbVpuMEhQTGVBdjdQUE1nQXhrMDNOUjFxN2JIaitOY3owVjRkSkNB?=
 =?utf-8?B?Q3pyRFJWWk5pOUZYYU9WMGViSWtsK0o2K3p5ellwbjh6aTRIVFpCY21wUERo?=
 =?utf-8?B?TEt0MWZDRkFoU3NBTUlZS29RamVHUkRRUDdHN3VPTlNjcjhKYTdSWG1WTFYv?=
 =?utf-8?B?WDhQTW1wSnFVNy9XaU5xY2dzYm5rdTlrUktZcFdQOXQwaWdWWHZIUGx5U1ll?=
 =?utf-8?B?d05ha3RxWkJKUHdGTVdHcVBOc1dXVW42L3NxbTdINE5BNHZBRXhiUDBjczE4?=
 =?utf-8?B?TS9DSWlFS3FoUzYyM2svb000SG5xdWJWSlRsN3hGSnljOUNXNXQ2WDZENVFz?=
 =?utf-8?B?QTB4bFBDTWgvWFViVUwxWGRxZzY3SmVRTmh1SlFOYjZrMmoxN0l6eUtiRlNU?=
 =?utf-8?B?ZmVrU1htNzVQM0g3Qkk2ZFhYUENNb3JwSUJwOW90SGJvdTJzR0pPZ3VNalNR?=
 =?utf-8?B?Z0dscStrdUdqdCtkU3ZEUkFLcE5MVGdmcFpkbS9LRHdveVlLSnVKeU54Rmpi?=
 =?utf-8?B?Wkt0RHhyT013MEtoNGdmdXgrSlBMUVNpOUdrMTBHcDNaSFQ2Mmh1alNGRE5r?=
 =?utf-8?B?R01NVGRlblJ6bkRHSGJqZWZzT0pDY0NzYzkvb3J0OWo3eThlWkV4M1hxZTlJ?=
 =?utf-8?Q?02jcuLX0sFQnd1th+r17XyFQyduvD3CfMnyKE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUk4WnRUK2t0aFZkWWcvV3BMNys1ZEliM2F4R1pVbXk1dDFhQURiQytEMGps?=
 =?utf-8?B?TW5nc1R0MVFrcGg3UWFDL0FrcG9xOWRnWUpTY3luK3JvZ21xWmxhR1Y2bExq?=
 =?utf-8?B?Sk5zY1FjOGNLL3gzSVJDdWZGQys0aDZ1WGRab1J6L2laMTE1eGlxRVc1c0Jk?=
 =?utf-8?B?UGtGTTdBWXRGNHllYjcyMjRkSmhDNFV5R2ZLQXp0eWpWNFlheEZiK3BGTnJW?=
 =?utf-8?B?Ti9jZHkyVHZBTXRZRFFXZVE2NUROdTVXR21SWW1mSDVabTFkTFBjMEE4dGx0?=
 =?utf-8?B?cWk0T045UTZMZXJWNUxKTU9sZnQ2ZGcxNFNEdHVqaXJRODhoSjRBVzl6Z1Zl?=
 =?utf-8?B?OHpnVi9tVklVQ3BjY0ZJVUYzMGFmTWI2S1NhMjRrMHFnYWJjUm1JclFVRHBS?=
 =?utf-8?B?WGRadkxTZC93WExKZDQ3SzdBd0VDbFh3YXBuV0R1dGRoTHpDYkJadDViY0hr?=
 =?utf-8?B?RWd2cXg0d0MxSklKMmZ5RlBMUHNQTDZlOHNSNE1HMVVYd0ZKdFBlaWhwSlJl?=
 =?utf-8?B?S1F0WnFTL1F4ejB0d25VT1hMK1pkeUJLdjdoUWxzWHk2N1lrYTlVdTlXZ21F?=
 =?utf-8?B?eXgvcjM3QzdtNzN6RnVGMDFpK1BuMzVmR2ovY0p3ZWF5RStsK1ZRWW1qSUhq?=
 =?utf-8?B?Z0dMcEhVK1VTTkdoWi82cFg1Z21GM3V5Z25PUG9WOStnbXlrT1NCOUduWHZr?=
 =?utf-8?B?ZTU2L2MxR0pjTHluNUU3REN3dUtsTklxcElVR3IwbU5BYTR2dVNDaFNxYWIr?=
 =?utf-8?B?Tnl2eWUyYzlRcnlTTXQ2OS9CbS9QelZoN1JIblR0MG9VTXNmK0dQNWVyK0ZV?=
 =?utf-8?B?bnRwUjBkU1pBNC83bk54dGl5ZTJWeHZyeEphdHViQ1ZJT1FBQ0VoM2lUaWpL?=
 =?utf-8?B?Ym43dlZBNUhQNGVVQmowaE5mZE05T2hKcWtZSTVYdDdMYnk2dzhYNTJxRzE1?=
 =?utf-8?B?MWtUSEdwMm9ueUtlTlZ4QW0rOE5NNE81aFkyY2N6OXFBU2ZwSjMxZGlLN3dG?=
 =?utf-8?B?dHVEaUcwd1ZrTlJUQU1zSUVWcmNqaDdTSitVLzB2eHd3ZnNKOXNLZVh5eUd4?=
 =?utf-8?B?eU9tcjVtRldoZ1BETXU4UUJ5WlJjdWNBaHVaWGtsanhlN0k5ZmZrWFJmUm1y?=
 =?utf-8?B?dUM2Um1pOTA4WU05cWlIclFrVG95T3JGWm9YbzEybFFnTUpXQVliR2VUSm5w?=
 =?utf-8?B?ZmIvSzBaQ0RGWDI5WjMzWWFneHVWRzN1RWNUSGFUOEJFbkRjbEx3Q3dWUzM2?=
 =?utf-8?B?WXIxQ2RhSWltSCs4aGU4Z1ViQzZNTllJMmM1Wk5LeFF1MlFUOUxEdVVIK3Jz?=
 =?utf-8?B?b0NBdFBFZHhtRUlhc01odzhuc3pvbXpudTc0T24rbWRFVVBaNkF6dERUY0w3?=
 =?utf-8?B?YVNCSDEyOGhPMklIV2UrRklmMjhmRWo1TzcxeWJiYjdhaE5GRGNpOFA2Z0F5?=
 =?utf-8?B?bWdHOVF3VXcwWlBUeU0rQlU2c0ZrbzIrTFY4cWdUN092cWt6K21WYzRPTmll?=
 =?utf-8?B?dnlPcU84ZGlLQ2JuOUkvblBYMm1DWVd3Q2xDQ0pha202ak5kNnZYME1wcFp5?=
 =?utf-8?B?VFVsMkIvbkswQUd0T2ZrdHM4aHNHODRmR1RXVmM2OUtkeUNvOW5qZTRMb1pU?=
 =?utf-8?B?dGJ3ZlM3VkpuNVQ4MjQwVkpwcEdLVXdRQ1NFZVdvc0tsTmVLbWdBTUt2OXor?=
 =?utf-8?B?VmVnbkIzdlZQQjZvVG51b1ZTUWhDcVdXb2lNTXBSaEJwbEtESEVMbEIvazZj?=
 =?utf-8?B?ZHlnVjZ5bUJPcWplSG1JNVBsQ1h5WlJoTkR3aXB1Ym13cm5oYVJoeEs3T1lG?=
 =?utf-8?B?VDNzalZNSFoxaW1qbW1aNXdBeXB1ajRkSmdOWTZSRjEwcjFIME1Ba2wzRWpZ?=
 =?utf-8?B?NUJSeDM5TktjZVlZQXE3by9JRTlyNGo1dmJQZ01QdmhXaStlcG9vZDZwSmJo?=
 =?utf-8?B?NHM4NXMyVHkwa2NteEx3S3RWcEp6cmEzbVFGN3NkSktTa2hrY3h1NEViWS9T?=
 =?utf-8?B?dE91L29EWHdXVGFiM0pnRFAyYWUyS0gyUnBYZktwL2UxU2JKSXRVQUxOTVpY?=
 =?utf-8?B?MEp3MHk5bjNYVWR6WWJyM0tqWUtXSit1T1RGV1hCU3ZJVlNuZ1pScTBCbWFx?=
 =?utf-8?B?R2k2WVBvdjB5bmFZVENieHRHWWdvMGk3WlR5MEVKNHpRWkFyUW04V3pGN1ZH?=
 =?utf-8?Q?6AUi/0f/QLcdJVslbpDQ+TY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	45AwcCK2vL6yxVIMvyIwMYt6LUlemDdss0gJWfTQdOF8i1a3JiGQlvKye0iUC/JP/dXckcoSNeX9d3tuBnWwBeJAIYfsItZ1NkCmE0z3D41DxC+rMyVcvYpQg4vJCQqjm/SnIGe4h78Y1OMSKUHFx82SfTDlTxBVmKtU4WR3mLa4kHLmMVEGVgzt2Sg7YTuaGm0xRzbuXCnm3A3gZb6PcSd+CkM3FC44JCl8ZaWhabTNtXjlDFeCEEE5gRE68gEZbzJvYA0FDpzhhq3dDUAPitxPlIPnukTDcbt4GLbHUbcXoFTXVHmuXYSSEfix6naE1sQlettieVk1X6Jw79wng5UeK2czaQHrmup1sKHY5puOZL2neviUePtSA83q0sDtBP7n9OF+AvpXRBWjUNLOMQy64u8TXLo1ONJA2eW5O+kMk7KMI+b4eGIlcJBmIfKO6AF4qGt33H0IUBbhbYKfl/m5/yosQ2h+/KXWMk180jdSsqoBDLGevjmS69cAmnNFyPlvSYF0oelxB7YAdEac9IztNs/LaYPHVHeZ82jN2lVG6wYMfappDJk4z9ISS9xc5kLFFz8GfigwngsaJoT0nVbeZQW3e+zdxLubUSDLHWI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba7cc1c-0aca-4e11-2048-08dd1c38ff02
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2024 12:15:28.2102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zwxOpxiFym/UBrYjamQQPTilE44Ek1UC+y63rLtp/VqZp/ldAmvxTNtKgwTg9sZU2aCs2NohQPwswvYMySkJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-14_05,2024-12-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412140101
X-Proofpoint-GUID: kXDCvJZKVE8Fm-usunkBWadjpRGF4UV7
X-Proofpoint-ORIG-GUID: kXDCvJZKVE8Fm-usunkBWadjpRGF4UV7

On 14/12/2024 04:41, Cong Wang wrote:
> On Thu, Dec 05, 2024 at 08:36:33AM +0100, Uros Bizjak wrote:
>> On Wed, Dec 4, 2024 at 4:52 PM Laura Nao <laura.nao@collabora.com> wrote:
>>>
>>> On 11/15/24 18:17, Laura Nao wrote:
>>>> I managed to reproduce the issue locally and I've uploaded the vmlinux[1]
>>>> (stripped of DWARF data) and vmlinux.raw[2] files, as well as one of the
>>>> modules[3] and its btf data[4] extracted with:
>>>>
>>>> bpftool -B vmlinux btf dump file cros_kbd_led_backlight.ko > cros_kbd_led_backlight.ko.raw
>>>>
>>>> Looking again at the logs[5], I've noticed the following is reported:
>>>>
>>>> [    0.415885] BPF:    type_id=115803 offset=177920 size=1152
>>>> [    0.416029] BPF:
>>>> [    0.416083] BPF: Invalid offset
>>>> [    0.416165] BPF:
>>>>
>>>> There are two different definitions of rcu_data in '.data..percpu', one
>>>> is a struct and the other is an integer:
>>>>
>>>> type_id=115801 offset=177920 size=1152 (VAR 'rcu_data')
>>>> type_id=115803 offset=177920 size=1152 (VAR 'rcu_data')
>>>>
>>>> [115801] VAR 'rcu_data' type_id=115572, linkage=static
>>>> [115803] VAR 'rcu_data' type_id=1, linkage=static
>>>>
>>>> [115572] STRUCT 'rcu_data' size=1152 vlen=69
>>>> [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
>>>>
>>>> I assume that's not expected, correct?
>>>>
>>>> I'll dig a bit deeper and report back if I can find anything else.
>>>
>>> I ran a bisection, and it appears the culprit commit is:
>>> https://lore.kernel.org/all/20241021080856.48746-2-ubizjak@gmail.com/
>>>
>>> Hi Uros, do you have any suggestions or insights on resolving this issue?
>>
>> There is a stray ";" at the end of the #define, perhaps this makes a difference:
>>
>> +#define PERCPU_PTR(__p) \
>> + (typeof(*(__p)) __force __kernel *)(__p);
>> +
>>
>> and SHIFT_PERCPU_PTR macro now expands to:
>>
>> RELOC_HIDE((typeof(*(p)) __force __kernel *)(p);, (offset))
>>
>> A follow-up patch in the series changes PERCPU_PTR macro to:
>>
>> #define PERCPU_PTR(__p) \
>> ({ \
>> unsigned long __pcpu_ptr = (__force unsigned long)(__p); \
>> (typeof(*(__p)) __force __kernel *)(__pcpu_ptr); \
>> })
>>
>> so this should again correctly cast the value.
> 
> Hm, I saw a similar bug but with pahole 1.28. My kernel complains about
> BTF invalid offset:
> 
> [    7.785788] BPF: 	 type_id=2394 offset=0 size=1
> [    7.786411] BPF:
> [    7.786703] BPF: Invalid offset
> [    7.787119] BPF:
> 
> Dumping the vmlinux (there is no module invovled), I saw it is related to
> percpu pointer too:
> 
> [2394] VAR '__pcpu_unique_cpu_hw_events' type_id=2, linkage=global
> ...
> [163643] DATASEC '.data..percpu' size=2123280 vlen=808
>         type_id=2393 offset=0 size=1 (VAR '__pcpu_scope_cpu_hw_events')
>         type_id=2394 offset=0 size=1 (VAR '__pcpu_unique_cpu_hw_events')
> ...
> 
> I compiled and installed the latest pahole from its git repo:
> 
> $ pahole --version
> v1.28
> 
> Thanks.

Thanks for the report! Looking at percpu-defs.h it looks like the
existence of such variables requires either

#if defined(ARCH_NEEDS_WEAK_PER_CPU) ||
defined(CONFIG_DEBUG_FORCE_WEAK_PER_CPU)

...

#define DEFINE_PER_CPU_SECTION(type, name, sec)                         \
        __PCPU_DUMMY_ATTRS char __pcpu_scope_##name;                    \
        extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;            \
        __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;                   \
        extern __PCPU_ATTRS(sec) __typeof__(type) name;                 \
        __PCPU_ATTRS(sec) __weak __typeof__(type) name


I'm guessing your .config has CONFIG_DEBUG_FORCE_WEAK_PER_CPU, or are
you building on s390/alpha?

I've reproduced this on bpf-next with CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y,
pahole v1.28 and gcc-12; I see ~900 __pcpu_ variables and get the same
BTF errors since multipe __pcpu_ vars share the offset 0.

A simple workaround in dwarves - and I verified this resolved the issue
for me - would be

diff --git a/btf_encoder.c b/btf_encoder.c
index 3754884..4a1799a 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2174,7 +2174,8 @@ static bool filter_variable_name(const char *name)
                X("__UNIQUE_ID"),
                X("__tpstrtab_"),
                X("__exitcall_"),
-               X("__func_stack_frame_non_standard_")
+               X("__func_stack_frame_non_standard_"),
+               X("__pcpu_")
                #undef X
        };
        int i;

...but I'd like us to understand further why variables which were
supposed to be in a .discard section end up being encoded as there may
be other problems lurking here aside from this one. More soon hopefully...

Alan

