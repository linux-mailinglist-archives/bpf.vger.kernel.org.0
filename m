Return-Path: <bpf+bounces-79241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EA7D310A7
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 13:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4F3D30590ED
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 12:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE441A4F3C;
	Fri, 16 Jan 2026 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y1cQ3WCP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X2X/0Lcj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2161199931;
	Fri, 16 Jan 2026 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768566295; cv=fail; b=dpCQuV/q7pkDNO3DJ1v640poHk6KEUH/pozF+UfUW0Vtregdi2lLDXOuFyA/1C3kR9wevwvKsdoHISs6ZxH64e7Vvdhd7PlqoGbNh5V1591QNOnBffR79L9x0ypzKuyqaqGEN2KKimjCvWH4gcm9iZ8OBc2bgxAQz/rQ9EGpInI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768566295; c=relaxed/simple;
	bh=selTf7KFJ9q3SwazdUfertzeHnjUsrehX7IuPR+lLnI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FGMf2Cwz+srvMnlFst90jlesP7yfGnJoqqmkltcPWKxGV5GFSr9M7DSXoVxzGV+S8GoSCp0Vz7JUfqWcXephvPYBOMe3WDY2aXdWunDNnV4+yRhVYGwk/E57uESZ0mAWY5pvAb+aM3U2iGXgMsdEB9u7Tr1oEFh/IIKS2I46Ycs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y1cQ3WCP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X2X/0Lcj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FNNEBa1737536;
	Fri, 16 Jan 2026 12:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QoeulXDoNur3qfEKdbiu2OEmTRmp253ti5aupFzWJhE=; b=
	Y1cQ3WCPJhCoorFiDlcYAMjapuPMiUz61AteclVoRpmr2QLDlkMoOY9/63IJIlc8
	36IUQR7ubXoGpv5MWICj2kpHn0gBYCPal5XuC3EPvU1Jx3jBpKLtW9Xn9ZLc9nQa
	YJ0D3b+5uZrRJRFXg/2YqV1g27HSf9PZRtm7og7NZJPtb79W504I+WcDKW5lopOm
	HcBcmYyYokdKVWK1lSp+Xbq1656sldPNmoMUWCljSUh3TrE/tMZN9h5uoFzclwqY
	CPqgXVpvrN14mtot/07q6VK/zxES8kXacXbjHWqvfZVDdT1uSSVBBItZ2XfaHiM6
	/GXKl11MVaeZnG7EScXsaA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkntb9v6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 12:24:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60GCFRDs004464;
	Fri, 16 Jan 2026 12:24:46 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012034.outbound.protection.outlook.com [40.93.195.34])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7pmr5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 12:24:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmC3eKVLvnikWIzdn5uUlCd2xavuYcc+ThcN4bGIXA138yDSmflyy2OfHih5W+F7SxEUHdnKYnr9ddsMQdxj3RO+PfUrqRfdniFwwYqPTs/9ujewadyLHANLptz1EggALrGdarjN3uqFcEYhZlAsZoPv+SkR2hllk47kfBspNcVhFlnReaMEHykzJtw2i6AGzfTxl8oGGcUD7dk7R1tCBNwLKAUHUmd/uA6F5nN+8csnHKgvRi4IFsiP5UqX9M3kMk8gR1vapl+32jYwWn8Lcij6Y02kUtJJilrE/zNriU9GcBrirTvy/XIz4OtA3qhURAw2r2W67uvSNJoXKuI+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoeulXDoNur3qfEKdbiu2OEmTRmp253ti5aupFzWJhE=;
 b=LR2hC76CisvAJrb/SlhX4CaKhin9OsX/e1l7l9r9aRImH+e1cQYwgcqOcUrG8BFg8cgRCXf3xbqBi0v4UbZNmQVblhMDcsEGHZdCuSJsadzj7hBUFFmom3KuRXllDWvBbXQ48a6xPbcIhJ/+YcXBxOlSd5bi9CtmMDhQ1TMvGTn+ZdytwSPqf94zbmjXbpKv9X21OP7eukgwiWGp6FPwt3tLB+G0pzFyEGcrCuDWGeJUEBgyJBxb2b8aBrCwHE5c9yl7WWDhz5rjEm3r0TYlx004y1CsuenaBXasgMsUpbZNMSRd6pjXo690vBUP6pO/RFmZMMZDBpU4MF6BZFRZNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoeulXDoNur3qfEKdbiu2OEmTRmp253ti5aupFzWJhE=;
 b=X2X/0LcjwXq5cCQwQsj/gWTeZKhRn3PywrcF3DtOAFclQtwhqXF8vx4Khxm5o0xX1QSGttYbuiEPGDBaaE5R3PrKCtl0/cT67qBFeQhTvcMZntqYnyxZg7PaXID7axS0rmGaCHJ+KaUUyc5pSPJvchKW1DkfXfY9K4KB6Tv6rrc=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DS7PR10MB5008.namprd10.prod.outlook.com (2603:10b6:5:3b1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.4; Fri, 16 Jan 2026 12:24:44 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Fri, 16 Jan 2026
 12:24:44 +0000
Message-ID: <581a5f8d-df3d-44e1-bdc3-86005568b64a@oracle.com>
Date: Fri, 16 Jan 2026 12:24:39 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf_encoder: Fix a verbose output issue
To: Yonghong Song <yonghong.song@linux.dev>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20260116020206.2154622-1-yonghong.song@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260116020206.2154622-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0191.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::19) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DS7PR10MB5008:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ce5864-a948-456d-654c-08de54fa3acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnZCS2dyRzM3dFdWK1M2aDhtZ0krdVpXWGxmMEVnTE0wYTYxa1ZacU8yRzlu?=
 =?utf-8?B?VGJ6Wml5ak5EVjdvSzNCWVJSVEU5QlovYlNZeVlLMGpRU1F5a1BIWHZmeVN2?=
 =?utf-8?B?WngxZi9aSmVrMWRhcEQ0VTFTM3dyWVFMb0lZdGtuUGN4bW5pZFR1YXh1QkJ1?=
 =?utf-8?B?WFdmRVhYMGp0SXRxdUtidXNYUG9QcnM0eVgrVjZHNnhxR0RvR3dhVGtwWjFw?=
 =?utf-8?B?YThYR0RyV2NOUVEzRFM0QTllK3QvWk5oTzRMRi96aU9CQjRSaTNzeUNZekRx?=
 =?utf-8?B?cFRtWWF2ckFRS1g1MWpKTzNQVjNZL3ZNWkZJZnpPNVprdXVtVFVjK09SM2Y4?=
 =?utf-8?B?dS9CV25ucFBrSXZRdzlsZTF3ZER3eFZGSXFhS3kvYS9wSFJxNHNBdnBmWUcv?=
 =?utf-8?B?bWM2S0ZTNkxWamxwSnlqaisyWStrOGV3ZmRwTWlNQ1VSTjJqNS8welRsK1Jq?=
 =?utf-8?B?UDhNNjJYQnJCQVFTK05KbkRQOFFJVkkybEx6Y0x5MWZ0K0xRQzVvZnRjQkJi?=
 =?utf-8?B?OHk0OFI2RzFIa2dSdWRHSFRjbmprTDdHbE5Sd0F2OWxGdFJZRDVveUJmRTVr?=
 =?utf-8?B?NTNhZjg0MmZlSncrVHVmMmE0NU1zL280NVViQzN2RVFaK3lPV3dFTlYxQzFa?=
 =?utf-8?B?QU1LZmJYUjZyclhTY3NVQ1VZTVpoODFJdlRmbTBXSyt5bmwwakJtV0dPZDJM?=
 =?utf-8?B?UXE4R1d5bEwvclZ6dHB5YVBhb1RFdU9CaWY0eGZzaStPSUprMXpkNGhidVpU?=
 =?utf-8?B?R3h1Yy93a3dJQUZSYnBBV3lZbW1aeFBSMC9JcVlNcS9NUGZQSGRFamEyMkxN?=
 =?utf-8?B?R0RzdVBLMEVoK2hmdk1NdkIrNjBLSkNEQkZhSHJxdEZqanJXR2JtcXhROWtx?=
 =?utf-8?B?Z3dGcW9wU3dzMFZ3bFQzWTMvSUttOFpwZXpMNFdYYTBRUTkrVkd2cFpXU2c4?=
 =?utf-8?B?RWFvK1RzMDhLYTV0OHc3VTBWeEtKZXdBekxBRjV4VGJqMVRna1RZZVcxT1M3?=
 =?utf-8?B?RGFqMHN1TlZKSkNQV1pZRW9YQS9ocktPVmZRR01hQ05BTXRyZUlkd1hjb2lU?=
 =?utf-8?B?VGkydHJhUkNhMGt4VHZVeGEvR0NtWW1JSnZzSFRaYVpYYmpHWHY3dUI3MFEy?=
 =?utf-8?B?N29yVXNDWGZkUXNUM0tDK0FBaVlRRkg4ZGV5aGNaM29WVG03eDZ0MjhTbDNC?=
 =?utf-8?B?a3FwZG9zc1UvV1gwRDEvckRQZ29ORHdMRTNab2RVek16R0tjM1lmZXk4aXhx?=
 =?utf-8?B?TnhQd0IvZTFJTWhDZktIOVUzS0lwczJxQnhKRzAzeWIzZC96YnQxQmI5dHJI?=
 =?utf-8?B?b1VGazZoVURPZ3dETW94K0U5d0VYTDQ0TEJQNFRDYnR6ZTArNzU2NEpwcGtZ?=
 =?utf-8?B?V3dicDBlM0YzS2xFMUdpOGgzUU5PTUc0ZW5Cc0hub0xXdkthR2ZTanlwaUdk?=
 =?utf-8?B?aXR2NmUrODZpWHBncjVZaGpHQkd4QzR3QVJ6TWYzWVRDSkxLUDlWUVozdWhs?=
 =?utf-8?B?aE8wRFhuT01ZUG5mYk9Sd2RVTEhUVVYreWZZb0hQNlpVOE91Q2ZOL3krd2Fs?=
 =?utf-8?B?R2JUSEVPQWt5Qm9KRDE5ZWJNNjNCeEQ2dWdwTEk5VzBXenpDTjRoT2duclM4?=
 =?utf-8?B?NnNWalBEaEdkbjYxbGpLYzJzVzE2QmM0MUN0VUd5VDJ4WjMwbnV5NGQrOFo1?=
 =?utf-8?B?OFVsNjRWZzg1czg4eUF1U2wrVytyOFZPa0x2d1NvalZnS05MUXZyTjNucXor?=
 =?utf-8?B?OGFmOTZBWk12T1hlcDg4VmtIN2NsSUdUY083SldTYTdncmh5UWJEQlBFSHYy?=
 =?utf-8?B?bld2aEhSNWdKYjFNZzJpR1FnY0pLd1hOdWo3NWJiaUFJVFY4OVhQdjBueFJl?=
 =?utf-8?B?ak1rME1McXpCK3huSENZK0tUN3d1Y21qWmdSRTlsOVQrRnVLeFJ4eklVMEh5?=
 =?utf-8?B?RzNRVGF4OTMvV1RTSHdlR0lvTTRzOHA4Rzd5YVpKYnkyeGwweGl5Z2o4SklB?=
 =?utf-8?B?b3UxM2hYQWNNNlhyVVhVcHpQZzhXdXU4aDNVK08vSWlrVllZQVpRd3RSUUto?=
 =?utf-8?B?MGRVcWxKRmFqOWZ1T1J5MXlFTFRzS3pjSkpoZnpWYm1hOXZJKzNGL05wZDFq?=
 =?utf-8?Q?/qUY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDNZcUk5TGlldTFmb0ZzOUVralNxTXFwWWgvZTk2Z1hWRjR3cGZVRHlqTG9v?=
 =?utf-8?B?cUNrdUNFbENlU3FzYWNtTVMyaFdnZ0x4SEo0aEhiRlNiMkFWaG5FSDRSSVJP?=
 =?utf-8?B?NXhocmRCZ3hYakhHQ1hFZzVteSt4YkVGZHBUenBRRlgxZW41Sm5sMk9mRUZH?=
 =?utf-8?B?Q1k1dTd0ZDZEL05iNkhqS2RjWnIrR01KdnFwZHl5TlJMcjRRbzhwall0dHpi?=
 =?utf-8?B?UlR1ZWhzSzdVT0YvcEdxOXJVSDhXcVg4eVBDcDAzZm5MSjJLRHMxMjFlTkc1?=
 =?utf-8?B?OU1kUm9KTzVuUWRONWpBSThGWVgzb1grUXBCR2h3SENoS0UzOHAyM3FiYVFI?=
 =?utf-8?B?aUtGUkRhQmVheUEwWVJ3eXg0dGI4L0tZenFQelRSM01acGpkYU90ZnRnS0dL?=
 =?utf-8?B?cE9GRUpJMi9hWkdtajRJSmJxbWFrL2IwSkpucURQNFpKa0VWK01YcDZsMWhz?=
 =?utf-8?B?RkxHMGZhcitxR2lGQ0RxUnplQko4dXZwS21hWmNydGxlNFFzczR6eTgraDlX?=
 =?utf-8?B?czMvM2JRT0d6K3kwQ1RpTWZhQ000UXpTNHdnVHpKQlNhSERoaXJmMGFtQVcy?=
 =?utf-8?B?NnZ4NDlFTTZUanY0VWxVLzlLaUlOWm5IMU5NajE4N2NWSTI5OHd3RUZRMFNP?=
 =?utf-8?B?VE1SUGY1czlaNVplMS84OUdrdEdKZmd3UHBiL0hVZFlhbnFWNUNFU2t4ejR1?=
 =?utf-8?B?a2drRXNwME5BSmZEV1hxdVowNkJDUDNjWkVRb2hiaDlzUlluYnlFT3ZoMGoy?=
 =?utf-8?B?ZjhxS2w2L0pEM2NZRS96RFlVS1ZRcDlRQ0xGWnE5VnFVa0E3UllWcnRaMlNY?=
 =?utf-8?B?RzVRdCtFNGlBUGYremEyMTJheDVSSFhlY1ZSK0FCNWtRajNoZGRZUG90M1BN?=
 =?utf-8?B?YzJ5SVZjVk5wUm90bmRqV0p6S0xmVXVyU011a0hBbUIxSk81am9VNFNTZW1V?=
 =?utf-8?B?YThvRFRGU0RkNzl1TjRBemdNb09tRmNBRnJrcG1zdWRsd003VEpGeHF3bHlX?=
 =?utf-8?B?aHFacTF4dldMeHJwdmo2RDQrMEV6SnVQS2NkTkN3U3VMMHJpVjRoN1hrZmNP?=
 =?utf-8?B?RlBqdFZEWnVkaGZNTmV3VDBNK090RWxSWXZJL1FhNzZQNGd1NkNHVG50QUE2?=
 =?utf-8?B?amVIWjNYMUQ0ZHBpRzE4T3o2Y3E5U2l1V0NMMWZLVzlUcmN2MWtSZXhVaEty?=
 =?utf-8?B?UU5EWUViSzZQZlNNa3BvYjJqdXhLWjRaRkZEMTNGcmpXdmVBZE1PeGJZRFUv?=
 =?utf-8?B?cDIzaXlFaFMyNkFuQlk2VDYraEoybUFLeStLeHR5OEdWU28wTUxic3dyTDlH?=
 =?utf-8?B?azMrSGdtSENOYUk1UXgwVkdYc3Q3ZzdSUEdBM3kwa2RZVStZVDVQR3BpeWw2?=
 =?utf-8?B?L1U3L0VWTFVKZ0FiZEhWcXNYNXFsRitYeHdVckpOOGhENlFvZU5uSjcvYXlL?=
 =?utf-8?B?UkFDT1RoeWZtcjU2eWVnSWlGbldvM1dza0lzMVkvcGh5SStVQjgySms3TzdH?=
 =?utf-8?B?R2NhZDBPblZpT1Byb0N3UytPZTN0K0J1R1VUYXZXa0pFaDNHaUo1cXRYTkRs?=
 =?utf-8?B?QWZxZ3FaTlNxYitTNFNEKzNiSURuT2gzbWlWUWwvelFTVk5sTUJHaS8ybWdB?=
 =?utf-8?B?VlVtRTFPK0lnRE5NTUVDeDBlNGFsSUtJTmR6cWZxc2psK1o5bW1HK2xhYnJm?=
 =?utf-8?B?UjIzZ3ErdEFvMjhBRWV3VDk4VUFzcEl2dDdiYUFJWlEyYjBtL3E5RFd0R0dP?=
 =?utf-8?B?TDkrNTN4TDBSZnFzWGdkK2YvMkoxcm1DYnVySEZRZjlJOVdBWmlGbWErcWNP?=
 =?utf-8?B?cTNrMzA3aERuUm5xNWYwaFExMEFGS0VmSXdBQVhjcFZ3V3hrMFUwSmNlVFI1?=
 =?utf-8?B?ekZZY2YzKzBYWWVDTmxyVXBhczVTNnZjSkFYd0ZkZGVqZUVCQVR4V0doa0Ex?=
 =?utf-8?B?YngwWUYwREIzaVpNeUxWWUhQM1dCNHYvbXJPM3lhdUdrRStOSndyS0xFNThv?=
 =?utf-8?B?eWtuUlo1VURJZ3dFSC8xK2lOb0F0dHBBeXRiVEVQdUJOVnAzKzdaUDA1Q3py?=
 =?utf-8?B?ZXRjL0VrUkpSTGwvMUxHcHdMenhBOGkyMURHODVYVzFsUjVyY3QvQmdkYllj?=
 =?utf-8?B?bjBiQ3djWnJOZkdBZ0MvODBZYXlMdmcyLzI5dmxHb3Z4Wkx3UmNEV28ySEJW?=
 =?utf-8?B?cmNWREp2d2c5R2RBTGloOFBGa3RBVm5aM2NFZGV6dFZFUjkzcWp6Q0wzU0Ux?=
 =?utf-8?B?S3VUVG9FcGdUNmZsU3dWMDluWnJWNmNmUURORENuOWJ2TlFFQmNIa1dOYWoy?=
 =?utf-8?B?ZUZSN1Jjak1kdXBXcDFaTGJpcy9wYVBDc2lyK3ZmRVNoOTVmQlN6dz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GnpDQFayTA+2w1m18zkcxtNDCwMYlXKVMFWQsu7gUycAtSCwA3bqUkQypzNKYEjD3h/VuqzqcOJXnmRPZww/7mZO6UFaNasLoi3/7U/RY2JQKr6H06r2tvLRY/QqynUAdGgXM6DKHjvkzW9NCQ8Jj1dssMGhRWo4IdRz2a/y2f4msqOnkbRJHmnopKmcv9Bx3N3AeNQIcr+Xhf98UGNy7oKGH4fNWoBmn/KbVRjcLA/de78Qw1He9W1uHlUHjR0jA7H3ehGH2sR1ZeLneH8t6SbTXwe9gYggJDfZQRrpqY/aBnD4GYor8wvUIuWF3zVpNvvsTqsGAVP0qTPc1/kO/UqaaCh6JeNi577YpemcXJQXV6OvOHhpirvJu05KjVxmWKyqemRoVlBvGGihnE+hwzKVRszWrTCaCVY3G1beDqtJjx0ONa+AVKXu8D9HVEaodtia4qmlBOcKSDsxT2T8r5k4c8IVzGgvwJzjgWGOkDdkC7g6Q/F58b/83Dll7tn17hozXeV66sZXwUObasNR8khfAbZ32y1029iN6n6Ahh67LtZYMXT87mRU/cNnpgtwQZegjpLwN6jaNkE6/TqR53/peqmZ9eYAMxJDKnr/l0Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ce5864-a948-456d-654c-08de54fa3acb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 12:24:44.0904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NkcwWs0qT3T+vmxvpDsMcZqaXojJCLxJw5BLOb7wQg/hle+CBf0ghkve57Dk4Z2tbF+6By/DsjpZOIW6fWyRgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_04,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601160087
X-Proofpoint-GUID: 5IJd10B62AJcbIpbpjUnbWqU-DHvfrb5
X-Proofpoint-ORIG-GUID: 5IJd10B62AJcbIpbpjUnbWqU-DHvfrb5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA4NyBTYWx0ZWRfX/8EXt8el0Ose
 X4wQVjSdbDuVTcr2PsezbGtAVuPBV+WPXY94GPMvotNsnBveX4fBXXAKNiNbhSCPxIK6NkR2VMX
 hNRFtFqQNPUvGrpUB6FxlnwuHyL2AonBPp5axMfCorWWcYt90zoi1/V5KJyo18j/1jPTImU51o+
 YQ90xNUBHmsoQmPaRIn0vpLZpG0CuNHvWNoqUPRBzj2ntXLVRnsGKiwVlDBY+q9yCH5dJ+ycF8c
 k0KZOwUO36zhVlTiyiKTYenHoqL5eVIBdso5mmEnkct2rmqvXaNJkcUIrg1eNQZuPHaH+zfCijX
 5KFVTLMGlQZ7ACb9hIGh9rP99XFMQk4K/I7oxdmskyy6JV9ZNeprz3FW/lm0FeR28DO071B1Mvr
 D+KZ3a7ooHAQC0upJ8NN63QmtNBCYYEymFJgQ166iNdBwDEvLKq+/iIYSm4w5oy5ndlK/biE1CB
 C4+pBuPr6/64KJ698h5vw98rNGuXpg7E+fRRLwZw=
X-Authority-Analysis: v=2.4 cv=fIc0HJae c=1 sm=1 tr=0 ts=696a2e0f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FjvPlppEExrovW7axckA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12110

On 16/01/2026 02:02, Yonghong Song wrote:
> For the following test.c:
>   $ cat test.c
>   unsigned tar(int a);
>   __attribute__((noinline)) static int foo(int a, int b)
>   {
>     return tar(a) + tar(a + 1);
>   }
>   __attribute__((noinline)) int bar(int a)
>   {
>     foo(a, 1);
>     return 0;
>   }
> The llvm compilation:
>   $ clang -O2 -g -c test.c
> And then
>   $ pahole -JV test.o
>   btf_encoder__new: 'test.o' doesn't have '.data..percpu' sectio  n
>   File test.o:
>   [1] INT unsigned int size=4 nr_bits=32 encoding=(none)
>   [2] INT int size=4 nr_bits=32 encoding=SIGNED
>   search cu 'test.c' for percpu global variables.
>   [3] FUNC_PROTO (anon) return=2 args=(2 a, [4] FUNC bar type_id=3
>   [5] FUNC_PROTO (anon) return=2 args=(2 a, 2 b, [6] FUNC foo type_id=5
> 
> The above confused format is due to btf_encoder__add_func_proto_for_state().
> The "is_last = param_idx == nr_params" is always false since param_idx
> starts from 0. The below change fixed the issue:
>   is_last = param_idx == (nr_params - 1)
> 
> With the fix, 'pahole -JV test.o' will produce the following:
>   ...
>   [3] FUNC_PROTO (anon) return=2 args=(2 a)
>   [4] FUNC bar type_id=3
>   [5] FUNC_PROTO (anon) return=2 args=(2 a, 2 b)
>   [6] FUNC foo type_id=5
>   ...
> 
> In addition, in btf_encoder__add_func_proto_for_ftype(), we have
>   ++param_idx;
>   if (ftype->unspec_parms) { ... }
> This is correct but it is misleading since '++param_idx' is only needed
> inside the above 'if' condition. So put '++param_idx' inside the
> 'if' condition to make code cleaner.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

applied, thanks!

Alan

