Return-Path: <bpf+bounces-38618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A964966C56
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 00:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58B23B230E9
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 22:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BEE1C1AAD;
	Fri, 30 Aug 2024 22:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HhMrjP61";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I6T/zkqT"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138F3136337;
	Fri, 30 Aug 2024 22:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725056869; cv=fail; b=Fphc6RPoKMm3deLxMadVvDasT/jknIJC1eTJCywZhnZcEpEWuZJQpqISfIgUKvOVvRlKAF20QzRjwkLkU+ldCjF157GzCyAUXNFWMFymmTp3m/t0ptuVA5elDoyr1w7/LxaEt7vwr5QEgya9BUcayml8vBKYSkyEAfiduHyD2rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725056869; c=relaxed/simple;
	bh=RMVLKob/4/kQLBH2EGUVV8RRJRULUBzeWs4AzJKckS8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hsrHJOBvGMAVS3uYLPB/jR74csWfp3c+s5jgC32+97H22u8zFtXaYRYfXhQKe9/CzbkuZ/Nxqbfrb+aVjaBJpSYzxbzgWalb+AcbncK1hgVKROovjV0Ypc4/Q7EBHkb9OFqNQaR0/fIIMLd2vOypGxDyrg7freR4eFnKzl8/GSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HhMrjP61; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I6T/zkqT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UMNgm2027558;
	Fri, 30 Aug 2024 22:27:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=BKjW+eOrYD12rVRHgbqUt00uEUQG6Tx7VZBoMgM0GYY=; b=
	HhMrjP61HvGQhcE1k/lyPbKsicKKEkHh12MuYY4UT7cmz/X+NEUZxjsdguCZ8hV9
	N593jnALjMxb93UtLAPMpMKWST9pZj76E1PRGr/bw8I4gUig9m2yhMaJ6Ubhmzhh
	aSn5RxJozhOpoYK6JOjlsLVvayaJeHHRHGSN6SKHYdY4zm0AmI3AYZUvSdaJdqIj
	mSZPnYkQvN6nXpEPYCi3mQFWCoavqo+KVn+eJc9cp0aTn3xskUcjOlrdBjSN4QU9
	M6RiWWWXlmKx7hs6BZV2ihGfhz/NGUmyng6IDIjCq50wFviRUAzaU+dKGUiyAkrk
	jsEfhmMBUa9fm9URW4XVQA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bptkr05k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 22:27:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47ULpPcM016853;
	Fri, 30 Aug 2024 22:23:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5wy7a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 22:23:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/u2wJ9ySKZQ6MP/egO0VHiE2d54l3g3zZG/9BCLXQI5uDBp9nZGbW+GeBQko8w2lceoLuAK3rUHC5hkSDCAPdDLCg8NlSaMZ49Jv3adFC3zk6Pmv8xD+vIcxlDJa+xgzWu51edDtEeko/K6DbFCPfX5cjUUiv1rV4O39o+iIVoY3MgvDUfPgNi4UGAya7lzqBtzsrniTbr+2qG0XfJCq48Yaajz6Fm5GJPa74SNKUMFlT34Key/dPYfUmx7yfgP0X3uL/3rMA1QhSv8L9eSFiQb9Q4LspNO3GCMS4SHYt5bI/AA84j7uwJKg6m/UP7fQkzea1mqkEvWZfYi3H6o6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKjW+eOrYD12rVRHgbqUt00uEUQG6Tx7VZBoMgM0GYY=;
 b=virOl8gXc4TmdDh50Y6QRU29NROQU/tz+1TPTyvezBnpQ/f8pdkPyn0fw03+jF/Q9hwyZ9YqcKi5jkv4yoSlOY7NG7krmwInXYKZMzQphVZT/4J6N4npngS3wFlCWImLdcXCAFOn9A9QWzY5oXUtskR5stZTAKoBDFrzVD+wTl5yIClGDRUuv8hR3ER+wl1312FUq9xrJ45C+wKL+65cwIVwDCV22aAVq8qgLOA7Jt6/x9NicUb8VL5l3GpiAM1I0rxNX3O5v5BDdN25KR5NM+kgWnE1eSe8YnXqYReITmtygsA30TP04zwGBWBnLXBVNzke9yabajlhvh2q3Cjpgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKjW+eOrYD12rVRHgbqUt00uEUQG6Tx7VZBoMgM0GYY=;
 b=I6T/zkqT8U4CFeqv4Pl5BdRjdw6gNflNI51t+K1HincJDoz75yB25VEyoqkogLYWWgIuNKt3uOk/dcTuWpgBJiXthLOsfGA2kj0lT57WuZ3WljulCW2pRdxW//tftrfG5YCNN1wmCwIwKpZmHW/WC0hCG5noePxSgQ/+KrRxdqw=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.20; Fri, 30 Aug 2024 22:22:50 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 22:22:50 +0000
Message-ID: <8e2d2d34-74d1-4298-a43a-47ea813da45f@oracle.com>
Date: Fri, 30 Aug 2024 23:22:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: FYI: CI regression on big-endian arch (s390) after recent pahole
 changes
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>,
        Song Liu <songliubraving@meta.com>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
References: <6358db36c5f68b07873a0a5be2d062b1af5ea5f8.camel@gmail.com>
 <442C7AEC-2919-4307-8700-F7A0B60B5565@fb.com>
 <322d9bac47bc3732b77cf2cf23d69f2c4665bc36.camel@gmail.com>
 <860fe244-157b-46cf-9b41-ee9fd36f9c1e@oracle.com> <ZtHG9YwwG5kwiRFt@x1>
 <CAEf4Bza9OJckdJ4=nask2m+bJsiDszvoLoaf+GhVFu8CNarb=g@mail.gmail.com>
 <ZtIwXdl_WyYmdLFx@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZtIwXdl_WyYmdLFx@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::7) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 2624d709-9e6e-4876-3b3e-08dcc9424874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmtTK01oNmU5TThLdXRKODR2Z2pKMjROT3RSNmpXWGdZRGlEZEpOWE1GMGp0?=
 =?utf-8?B?RmJIanhjbk5jcTFySGU2OUtQN0VGdzNOc3U1NElRVk10RDdVdjRvTzArc1FI?=
 =?utf-8?B?R1l2RzFncEFpWHV3a2R1N0VjVnlURnVRdUEvdm5MNW9qRjBGbC9FaFB3aWRs?=
 =?utf-8?B?UUxTS0FOSTB5NzdSUEp0M0xqb0pCTUhUM1pBRm1nWlR6bmtwVUtsV20yc2FH?=
 =?utf-8?B?a0s5amxFOS82WDkzN2N3ZlNEYStzMHNHZlQzcktxUUVpUWlTcTY4VDlDYzF2?=
 =?utf-8?B?UXRDRDlDSFYzVHRmWWo3S1htRHNaLzBRWVEvL09qejdoSC9GTnNZbFZpWjEv?=
 =?utf-8?B?emJOWUZ4alowUk1oa2o2bmYyNXZNcG5semVhSE5pMUpuM09qbGswVEFraktO?=
 =?utf-8?B?V2dBdVYvcTdKanVNYU8xS3RPdmMxQ29yTm5ZMmlmOHR1RkR2dlo4QnhSMkhT?=
 =?utf-8?B?dlZBQmlyVk9KYlBLMnZUc0tpRmVvTDlvOUtFVWs0TGxQbUhUTHltcnlOWktV?=
 =?utf-8?B?TU50bUx0Ujc3Q3pSdHM4aS8wTFJRQ2MwZGhBRDRCbDV0VWdKckN2bTdLWUlZ?=
 =?utf-8?B?YjZXWGt4cFl5OGdWRm9LbXY5U3VhUHIyZTFZaXpaTGpmQnN6cFppeUxXZ2l1?=
 =?utf-8?B?ODdmN1Bha0NSUFptaUc3cWdtOXN1dHN4aFFKWndkZVhMaUQyMWtiemI0cHcx?=
 =?utf-8?B?Wkt2cXcxSjI1REhjOW9xZ1hKajNVZ1pwVkwwd0Y5Z282a0tLdnI5dUtyNE9Z?=
 =?utf-8?B?eTR0aXZKTU1QZ0Q5VzZwUGU1VitKZGFRZEtDTGwybHdJdjdXVkh0UWwyTjRa?=
 =?utf-8?B?NlBENkhxdUx0ekc3VWlnWVVyeW8xdXpQR0lveGRYdVpXU3RuU3RvbkZDbGVQ?=
 =?utf-8?B?Z2IvTFNWM29Vb1pRZFRqR0VSMzRpVTRraEtFaVpSZTdPTkplTVpuVjVjY0JM?=
 =?utf-8?B?YVA5MzJRWEhBaDVubHJCTi83R0YyZWVjTWxWWGthdTUzMUVVOFhtYlZwYjE2?=
 =?utf-8?B?eEhrZkJRMXhRd3F4b0FpZWhCZnRiamhQaXFZaWVUWktIblFUajV6LzJDZ212?=
 =?utf-8?B?K29QZ1Q0aHVTaDJoME14ODBnV05yQTIrTXgxOE1qWncyTWNUSnJZY20rNW9q?=
 =?utf-8?B?WDBZVEttWHFLTTVGTk12YnB6L0RIMEFjYjFmOWZENXkvL0ZrOWNleHJFanFl?=
 =?utf-8?B?R05VZWdkTC9qaDAxQnB0cVJ6MTRMaVRvTmZleU10ZkQrRDhVeXI1S0hONFVL?=
 =?utf-8?B?OHVDY3c4NUIrTUxEKzJOWmljTXdRR0dQbHBUaGhsNjFnTzNaNTBWRXNZT2l3?=
 =?utf-8?B?bzNFN2xpQ0lmT3lmL3NvOWJpbFVtejNwOGtlazYxVnhkTXBPN2MxUkMxNmpv?=
 =?utf-8?B?TkErd29NZ0JqYTRleDJ6b3B1SGk1VUxnU09Eb2lDUllKYStxV0FHMmNxaHZG?=
 =?utf-8?B?WXB2cERuMFhZRURQNG40b1hUZXdNM3EyT20zTWw4aU9ZbDdaUU91UHdDQmZ5?=
 =?utf-8?B?TkxYY1RDQkY4UitxZHl0cStwZmRhYnBVbDdwQTFZcFJveTZ6WE1uRHk2QWpK?=
 =?utf-8?B?ZjFTQmxkWm10dWdjUHFHZXRXZzJDVGhSNkxjMGJGZG0wOThDK0xidENPWTJY?=
 =?utf-8?B?ek5BMXhndGZDMHVDODFUOU5vRUJNMzQyYXpJVTkyZGh4S0tRL2RlU3VyYnNh?=
 =?utf-8?B?TFFDYnVmV3hDSXJmZmowNFYwL1pHS0NUY3BybXpFQ245dWRJZCtKZ29YaGkz?=
 =?utf-8?B?S3VldW5KYUZYNkozUllabjlSQWdMMFJNcmFMTW1acW1HNFYwditkK0l2UzVH?=
 =?utf-8?Q?8hjE4m+2e/QXBucl5U9xpk6tb8qfvpGn2pqik=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXg5b1BJQktHZzJ1TGJkYUgvakdRRHJBdnRiQ25pYmREZ3drSWNFOUJDOHgy?=
 =?utf-8?B?SU9Rd3NQNG1QRUxOa1ZYREYxWC9JdGI0NFo1bnBuQ1B0Z3M0TklSMnVydVZk?=
 =?utf-8?B?MDBlQmJvS05PUng4Z0hOZHh0K3hiRk5wUXZHaHpFRmZJM0VzdytTdUZMcUtO?=
 =?utf-8?B?WGFhei9RODVzNzFXS25DeVQrdmZwQlM2MGZEVk9PaCtYYXpoY1ZwbHFDM1JI?=
 =?utf-8?B?emJYMDV2ZU9pZ0c5QlBIb1A1TXVMYXZxcTduYmtZajV0Z0l6ZWNPcWJvNlRm?=
 =?utf-8?B?TU5KSGI5Zm9RNTRpVVp5SDhLa1ZuRmpUMXRTRExYRm1MZTc4YnNlSWJqUkI0?=
 =?utf-8?B?anhDSzBaWDkvQ2t0b0lwZUw0N0EwdlF5WjJDZllEMmpFSFlzSXpEWXV1SUYw?=
 =?utf-8?B?b0pTWDUzc1VLSlFpRUVkM2tmYk9HL09oTm1zeXRYUGJ3Z1puTzJ6MXhYSE93?=
 =?utf-8?B?bWtySmR5NzBYdURPeml5Rkd0YUphZHYyMVNCVDNPOUhLOXRIMWZtNEdsWWM4?=
 =?utf-8?B?RnZBcmVqdkR5SVJ2WmVHUVpjbmNRLzFRbjc4QW9EZ0ErVXA4dVpaWmJaN200?=
 =?utf-8?B?VEVqN2o4RXpNQUJTZGZCTE90SEY2Q3VsT1RyNEtrRFk0dzN5RmNDa3ZFMzFT?=
 =?utf-8?B?WHpMVmUwNHR6SzNwNDZQckc1TE5FZk4yYWJ3OHZwMms0bW96WmdrRGNLV0Vw?=
 =?utf-8?B?WTRWME9FZXJiS244NG93Y0Y5amJvK1U0M0hMaGtEeXZjOTYvNXVGUzN1QlR4?=
 =?utf-8?B?N3dCeWdwWTZ3WU1aY0wyMzFSOWxPTmQyZEQrdXVIa2JBbzd6Q3dwSmdBK0Vo?=
 =?utf-8?B?MnE0bDNnS292Y081L09jbHI3dGtiUFlrWmFIT2VkbTRYQ00wVWFCcEJwWGhQ?=
 =?utf-8?B?c2F0bzhuNndZeVJkTEJFL0s1VHpzWUhyV0t1MnFDTlM0S2M5MnRQcE5kUmtp?=
 =?utf-8?B?d1kyc1BoR3ltTXJrTWErZXlZZW5LVzIzUWRXWEIwZ1hZTzgrbGdxMGlYM3Ay?=
 =?utf-8?B?eUJibHE5KzlEWHhWU0VVYTQ0WEZuODVhazVlc2tCM3lyTTBpYlQrNXZzbDBn?=
 =?utf-8?B?cmFHOEk4cWFIQXlJNzlBZjUraHhkSjJOT05jUGd4MEZrTG82ZnB3OHFYUEkw?=
 =?utf-8?B?SWtuT0d5VWNWTi94Wkw4MUUyQ2FDQThzbytzU3lXRS8zRTYvVi8ycXFqdmR4?=
 =?utf-8?B?U3VhaGNWSVFDZmlUZktuTEpXVmFXekZDckt2ZFhhVHV2b2VKdFhwT1NiVmNV?=
 =?utf-8?B?dE9IcGVRaVNqdlFvTmRRY3YxQkl6clAyd2Nib2hUekZYcVZRc3ZIMDVhM2sy?=
 =?utf-8?B?MVBMNkVBUEl1NmlOMnYwNCtZeGE0YmFka0UxQjg4U21VOGNJdWwzNGdxNFpN?=
 =?utf-8?B?MHRxNUVnd2syMnl5UjA1WXV0STVPNzVKL0w2bE8rb1YyK0MyUzk3YzJpWGdo?=
 =?utf-8?B?T08vWlNMYjNwaGlhS1pWTTRmSFIwTG1GbHZwQnR6eUgxSy9aTlRGUnh4NVA4?=
 =?utf-8?B?Z1VKc08wZStLOXNtMUtValQyUlI1a2d4aDhPQVZQV3hsZGFzWVc2UGRRZmJz?=
 =?utf-8?B?bTBpdldQdFM0WE13bVhmSU1yUnVHUkk2dWlibDNDTWdVYlpZRjh0dmtMTUdW?=
 =?utf-8?B?TjN6a0xrNG1Va0RIUzV6ZVR4SW1zb2F6QzBQUllrY0U2cHh2K0YzeHdtTVdh?=
 =?utf-8?B?WWFFYmdlNlBGR1Q1TS9ld1ozY3RDZ2dlM2lDRXNBSzRCQm5GV3dFOGhLRU5I?=
 =?utf-8?B?V0lpamVCYnF3RE0yRjVlZ2R3Y2xKUWk0cEZ2S2psdDFQOHQvSUNCQUpPL3hr?=
 =?utf-8?B?SDRCV0JoQm8yY1lJK1JIbE5iNEpZVVpNU0UrejJ5YXlHTzVrUFdmNDlIblR4?=
 =?utf-8?B?QzNEblRjVlNNbC91UmRCMmo0Y3pXS2c0NnJLMzFhNW1CVzRDNW0zb1FrRCtO?=
 =?utf-8?B?RVpBWlpscER2QXA1TWFwdGFhUE1SUjVvbzZNbFFKSldPM0FOM25Ec0pDc1NB?=
 =?utf-8?B?RVdYSjJ4eWRJakZsTElUQUpvck55L2pjU1ZxOVQ3UU13Nm9wNy9CbWNrZlFY?=
 =?utf-8?B?TkE4NmtVT2VmcEdHbnRtUzJoUUYrU3ZDMk1ZNFBkdVZoMk81UFJ0UzVxa08v?=
 =?utf-8?B?ZmYyMkNYTFgwSytUYXFvOXp1c3MrSWZOYTJVdXEwVkNaRThIZW1tc3dlSnFY?=
 =?utf-8?Q?Hal/m+iMYVxCMhE7sNYQVNM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OV5sMKuOoslemjRuUZz10nhKWqfMiOfB+X1cFov6l4990ZD0tdh9XaYd9C+Xf2zcHt4fh3LfC+tpIQxelfjLb5O/amukxOVoLS8YwvxZJaByB2bR4f4vjVwf2Fwom+N7iOZyvhSQbfMG0R+4PpH9OgLbw9JE2BlhM0X8TTH4nL9VLaZPoMzoou7CXpzxJJNW9clG2a/gA2WTTkWV3oLfnHM9ahj9RRBk5CqEwdBKpqugsAs8CB16gewm7kZPPZsLKixsKsCGY2Lnb8i0/N1lyAX57i6S5VpJlyUU2yjgjJvzWkGLcFXHX7jfR92ozh5x0cmXfU2sNMj0cMWx/ttCq8KdVIl7i+iuIY7XhPGwB2QcZ2pnKG7aowFIvgBklOdmPmMFEkZA2vArxsRXc9iNKaX+T719HU1rKhniXmX1ZOHcXwsOjAW4WKmLXDMo/uVzKyfkfcodOSfbFQXcswVi9d88S2LJ38N7PXLD/fG/fD3ZZkuo0O0i547FNX9T9OFoa6SakV2j4b0ib1E93sAquU7Pq/bzf77LEdivYD5ygUwiwSlG/ph6C9lvkue8Z2c6VMXj1E/RlLvxcVj1S1+pEE250J1G91AUqZj2FV4Jui0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2624d709-9e6e-4876-3b3e-08dcc9424874
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 22:22:50.1209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VI0vDlm6T9mXVClLK17J7cb4XlOCPOdE9jOAibXCCll1M6nLk3GGcOlc8AaKyiBmbdGTbKFlyIul4BIMcfI6vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7364
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_12,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300174
X-Proofpoint-GUID: dE-3bFxFT6HBFTbFYwGWKlKJnM0_H8nB
X-Proofpoint-ORIG-GUID: dE-3bFxFT6HBFTbFYwGWKlKJnM0_H8nB

On 30/08/2024 21:49, Arnaldo Carvalho de Melo wrote:
> On Fri, Aug 30, 2024 at 08:56:08AM -0700, Andrii Nakryiko wrote:
>> On Fri, Aug 30, 2024 at 6:19 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>> On Fri, Aug 30, 2024 at 11:05:30AM +0100, Alan Maguire wrote:
>>>> Arnaldo: apologies but I think we'll either need to back out the
>>>> distilled stuff for 1.28 or have a new libbpf resync that captures the
>>>> fixes for endian issues once they land. Let me know what works best for
>>>> you. Thanks!
>>>
>>> It was useful, we got it tested more widely and caught this one.
>>>
>>> Andrii, what do you think? Can we get a 1.5.1 with this soon so that we
>>> do a resying in pahole and then release 1.28?
>>
>> Did you mean 1.4.6? We haven't released v1.5 just yet.
>>
>> But yes, I'm going to cut a new set of bugfix releases to libbpf
>> anyways, there is one more skeleton-related fix I have to backport.
>>
>> So I'll try to review, land, and backport the fix ASAP.
> 
> Well, Alan sent patches updating libbpf to 1.5.0, so I misunderstood, I
> think he meant what is to become 1.5.0, so even better, I think its just
> a matter of updating the submodule sha:

yep, sorry I should have been clearer here; at the start of a new libbpf
cycle the version is updated, but the sha I specified in my changes
wasn't an official libbpf 1.5 release; the goal was to pull in the
changes we needed for BTF relocation so we'd be in a position to test
pahole + libbpf together and shake out issues prior to syncing to an
official libbpf release.

> 
> ⬢[acme@toolbox pahole]$ git show b6def578aa4a631f870568e13bfd647312718e7f
> commit b6def578aa4a631f870568e13bfd647312718e7f
> Author: Alan Maguire <alan.maguire@oracle.com>
> Date:   Mon Jul 29 12:13:16 2024 +0100
> 
>     pahole: Sync with libbpf-1.5
>     
>     This will pull in BTF support for distilled base BTF.
>     
>     Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>     Cc: Alexei Starovoitov <ast@kernel.org>
>     Cc: Andrii Nakryiko <andrii@kernel.org>
>     Cc: Eduard Zingerman <eddyz87@gmail.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: bpf@vger.kernel.org
>     Cc: dwarves@vger.kernel.org
>     Link: https://lore.kernel.org/r/20240729111317.140816-2-alan.maguire@oracle.com
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/lib/bpf b/lib/bpf
> index 6597330c45d18538..686f600bca59e107 160000
> --- a/lib/bpf
> +++ b/lib/bpf
> @@ -1 +1 @@
> -Subproject commit 6597330c45d185381900037f0130712cd326ae59
> +Subproject commit 686f600bca59e107af4040d0838ca2b02c14ff50
> ⬢[acme@toolbox pahole]$
> 
> Right?

yep; tho the above sha doesn't have the endianness fixes yet. Those have
landed in bpf-next, but are not in libbpf github yet. So we'd want to
pull those in too for the pahole release I think. Thanks!

Alan

