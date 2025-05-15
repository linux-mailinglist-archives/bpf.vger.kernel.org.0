Return-Path: <bpf+bounces-58284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A4CAB846B
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 12:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2553B86A2
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 10:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC852980BA;
	Thu, 15 May 2025 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K0WwLP9h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QqVa5xyr"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F792980A3;
	Thu, 15 May 2025 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747306590; cv=fail; b=MTrJQklaznVyCNNM3KosbDhItRgM/E19JWVTWnpu5sKk5ELCchf7LA2EfMRYTgpSg48yY8e6bF/IcvlPbKIV4GxzJ59vD/o+fWEhYVgSvvVTFvBUzXA7wIvuuGkEYtNyct4nEnhYknAZlElhb9vA8Wh2z/SatcfLk23YywjvZkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747306590; c=relaxed/simple;
	bh=jQwI4cSuHT/DelTY7xKtvObnDHGQGmlVo/vXkBHL3D8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YytVdafJDLmFnysLxrBKXtokmxlYmLwvi7uWqZJfsSZqKhhPN0JKjG/p+mq5R5nc1WPbaVIpTguWxekjI9E+jwQgfcX8L1cWRw9GD2MKJIUZbmIBsaGAlwBXtFAUA3FKAL+jggTOkSbWcfbYXMIFldtxQz+GncZmeyy67QE76AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K0WwLP9h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QqVa5xyr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7Bmu5016032;
	Thu, 15 May 2025 10:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=m/yM0SwsopT9qU7a6Y9AYImH91v1+jRLciFD2Rie+IY=; b=
	K0WwLP9hf3YSuJt5nEb+L+9ohgHnpoaB1l16NHAPiatT0GPLR2A4Tkmj8SFhP/ub
	SC6xa/pXJY/IjO7YLbjeMmPzhvncUe3HcG1TmRIbl4TBMu39xYgmoKNpQXg6h+WL
	zT1daiqtTSYnPkQ2h0+pdsHvOTl//R/42QLVyb3C8yDnDjwTEqjssk6DrmoW8qW3
	O6zDK5nJrehm/WWpmKn5s0tURDpOepijUNMz/wWXPEtFYZ4iZxPA/vCOQjkbfl34
	6om8z5Wdv1Ml5aN/oiq/agovMgkHH6vsr7AdbII/n3zx8L7ZhK+Luxt6JjFGmixm
	dKEZCBfzLeYV4ByJzRNh+A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcm3qsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 10:56:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54F8e1ut004251;
	Thu, 15 May 2025 10:56:09 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011030.outbound.protection.outlook.com [40.93.12.30])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mrmdx11j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 10:56:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmeP/SqcSUrUfnGbW2p3IKmkZH8pIgcRXP42NFejwcVcrydz9NgOJGCvqrKgb1tj2DVb8B/dF0BRxIaLXba+vZVDO+35bahElE5UaUaYQn97pSypcdO8C4kJGYunGfOjZyfNwm7uzyIMrDytdpw9wslc6Kz1Yh19bH4idCj43HBqmBhgiOMAMYY5lCue58EKXDzxT46QkHSGHJztruFxigK13VwWNamHsSlCDDhD7g72+i+EOPSJVr1J4Kb8VrpgljSYz0zds20wq3OvaiGKCer6NHWSeGT3U05lIepIRFyU22fG5w0akGnAYYUe686LnnfgTc2nd5X0FXfkZDRMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/yM0SwsopT9qU7a6Y9AYImH91v1+jRLciFD2Rie+IY=;
 b=G38EL9ROtds7l+geU85bO8RcBWEBKxawaTG3yyNjRjamIVEWPkdX54QZc+PIGPjKwNJ8URZ/7/deEdbVHYBKuzlGOOjlCUIbxXZSrGQgpdYj2bfIcrCxy2YXhD0dev7Jtg5LO1bshMu94RxphXfDSChljFEkccLEfj1Kj2jQkYWFWSmr7aHEnjuI3/Jax3PA98du0TDnedvm5Icx7uK9ecH+MsS5Zpuqtd1z0WWSRHd8xDnf5HbOQMRI7kqk7wWglCAmDPB9dTeKX9+PqQEyEkYVztckPdNKnRksI2c9N1noV8tjnIVvYXzvTiphg2j0jQNJn9heI1eRu57/TT99sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/yM0SwsopT9qU7a6Y9AYImH91v1+jRLciFD2Rie+IY=;
 b=QqVa5xyr526QctXLMMw219zPp6QTWzt5CTI0cHlwLPbvNz4MYJwd6TJdDFJRYEKONZrRqZGnb/N7CHO1EfrlQ7IRFcc5HE+BARqOkxfP9oN2MevUOtTz3OyXPPtx5hwWBfk0kMzTnwAJcoeZrLWUUYz3hDPra0WmFM05Yoib78s=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ2PR10MB7057.namprd10.prod.outlook.com (2603:10b6:a03:4c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 10:56:07 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8699.022; Thu, 15 May 2025
 10:56:06 +0000
Message-ID: <8faae89d-3515-480c-9abe-4d0e7514e41b@oracle.com>
Date: Thu, 15 May 2025 11:56:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 0/3] bpf: handle 0-sized structs properly
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
        tony.ambardar@gmail.com, alexis.lothore@bootlin.com, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org,
        dwarves@vger.kernel.org
References: <20250508132237.1817317-1-alan.maguire@oracle.com>
 <CAEf4BzZfFixwy4vQG8jrUBtAOUFx=t1KG2F+AtKPVNCsMz0vQw@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzZfFixwy4vQG8jrUBtAOUFx=t1KG2F+AtKPVNCsMz0vQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0194.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ2PR10MB7057:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6c7537-28bd-43e2-3231-08dd939f178d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0Nna1RnL0U4Yk51bkVtZThKajVTQVpuTkpzd29mbk5aeGNyTUpHc3VUVy95?=
 =?utf-8?B?S1huWnYzWmJLWWpDa2JFMmNjRDNSTmgycDhJWUx2MU1LWlFaRm9NdzZYZHpx?=
 =?utf-8?B?eVhsUXZWZytHazNIa0o2ODlIbUduUWM5aWNreTF0dDR3VDk2SHM3eUJ6dnVN?=
 =?utf-8?B?M2dORjMxUkdUNHRTRG1LN1orakZMek5uVjZuQkNadmt5N2x2cXhoZHJPRDhW?=
 =?utf-8?B?K0dPR0xiRWpkOTRaU1F6RS91TWxPaGk1SUpxY25CWjFNd2N2TmozL0hmQXlk?=
 =?utf-8?B?WDNsRGpNMUJEM0hIYlFucVJrbnAzajJ2M0xnZ3o1OUM5c0lQNkU2QnB2VkVI?=
 =?utf-8?B?NnhTbm5CRW5HcVNNYUhJUE04NTNLQW9CN2xTenpHZkRmcFdhRHBKZnAyMUxt?=
 =?utf-8?B?T1JGS2M3M2JIVzZOZ3ZnR0xLSjFWK05FUm8yaDF4d094aFZqVFMveHVMWTVD?=
 =?utf-8?B?OXQxaEdBMmhLU1FXSmYxRHhvOXNDSUJrRXZBRG0yT3IvMmtWSVpjOW5uUDBy?=
 =?utf-8?B?aE1NVXBqUGw3VmlWUmx3UjFXR1dSczhZOWVzMDZLUllDaVltU1hpOHYrUHFD?=
 =?utf-8?B?WUlEMHdpb0R3SHdzdDJqM2pueE1OaXQyWVY3UW5sTk5jR2k2a01HWXFQTmty?=
 =?utf-8?B?elF2VWxuK0FjRk1rakVib3dLMHAvUVkzZjZTdkt6SnBEUG5FVjlsNDNSL1FF?=
 =?utf-8?B?SjBSM0YwMVErNlgyc01FdHpwUUtwRGFSUDlHS0JsSk5Rd25FcDNCNks3d0Iw?=
 =?utf-8?B?Qk1Wb0d1akpJTjkwV09wc0MvR21WemFCcVlvd1IxdUNNWW9oc25OTFhWdm0v?=
 =?utf-8?B?NGNwbW5rUWlWMjR1TnFWMXpvWDhoSnFGVFZkTHVaNUN4bWFDL3lDRmpMZ0tB?=
 =?utf-8?B?Qy93NU1JcjlLdGJGYXBicVJheWFjR1dNaE9TYUJGT1lKMDY1U040T1N6TytP?=
 =?utf-8?B?ZXU5SkZMZFEwSDE5QXhxcDlvTU54eENCQ0ZXMERsM3dPdWZMazRrU3U1aDRq?=
 =?utf-8?B?WlJqd1pLdy9yaWZRNWd3YTRzNkZ1TzZGWWdHNEVRZHVBOTVQNWpUQTM0NUd4?=
 =?utf-8?B?aE5wS0NJVW9RWnFBcmNhSno3REEyNjhYNzZxSjZKSUZ4TzJSR1VFVGhBUWhy?=
 =?utf-8?B?cjUxK2s5TG1YelZBSXQ1YkJoWkJGZ2tqNEgzMXhCV1JrVGtrY000V3JzSXhx?=
 =?utf-8?B?YW9INkhBOEc5ZHRtRUM4ZlBheGtmVnp3aGFPejd2MGc3RExNaEE2S0lIUzNs?=
 =?utf-8?B?Z3hNZ1d1K05kMS9Rall5N0NCQmJuNHE5UkV5d0RNTXB3Z3JrUktudmFvWCtM?=
 =?utf-8?B?WGxtSnZwamdZTm45a0duMTkyWFJqZHg2U05MMm1adG1xbll1dHVxdndoamxU?=
 =?utf-8?B?SDF0amIxdC83TG1uOWJ5c2cyTGswKzZVekYwaktFOUlQa01JZVpicXB1V0Zm?=
 =?utf-8?B?cXZWV0haN1pEbCtpbzJOaFpmWFBTbmx5SVRoZ0lWYitNNWdicnFwZFB5OENF?=
 =?utf-8?B?RlhDZGhYaDZMVllFZFFvZ1hxOERzeUlSUitza2w1a1JscllLR3hrR3dHU2xP?=
 =?utf-8?B?c2h0Q0dDZFRtc1U1cGswbE8xbzMraUtuVlYxQjJzeXVxbjJ2MVR4YmpzL0xI?=
 =?utf-8?B?dDVvRURTTjVUY2FrWm5GdlZmTXBISDJyQWdlZU81R3planplREFjbGlXdUVl?=
 =?utf-8?B?MzNxWWNPckJEVzM1b25xSjZJK1FnVStvOW16ek9hcmlacDlDZyt0YVdNd2VL?=
 =?utf-8?B?RkhMUUJ0dXVaN0xCOUpHZ2NrbkZvdFF0NFBMTkJyYS9vc2I0cjMzMlBST1F0?=
 =?utf-8?B?czJCUDZxTVAxSlFBM2lDT2NpTEtuQnN0Z0hnNTRrc1VSYlpjUjZnTTdVUjRv?=
 =?utf-8?B?NzdMLzNHSGQ1TUxsV0xIamJMaHFRQmh1VVVzWWJWeDF4eEV6VEZTSEo1ZEgz?=
 =?utf-8?Q?QxqMuy6OhnY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0dLa0JzQ3VPWnpIUDJjL1pIUUpJSitRUkVkQVprYzZqK3VjVHNUb1JaaTlX?=
 =?utf-8?B?b0VtRkh2L1JYbXl4MzhtK3hLMzlTTWc0NklVRXREQjA3bW53OFBhdDM4aTh1?=
 =?utf-8?B?UUtvQ0FTbko5RllpUjFTb3NNZ1RRQUlJWmRzRit1U3k2bm5FQkR4MHd5REgx?=
 =?utf-8?B?bW5vclRvOTE1cWxpSGhNbDg0R0gwTmdqRVJFS2VCcTA0V1lOVitKUVBVTDNM?=
 =?utf-8?B?d212V3RCSW40NHMvdDg1ZmxZYUtrUGRtd0ZKdEI4N1MxNDRUM2E0V2kxUGI2?=
 =?utf-8?B?bnV5WWtFa0x2L3RvMUJDWFd0RkNhRU15ZW1IbEExQ3J1VnNkT1ZzS0k1WXln?=
 =?utf-8?B?aENyMis3Qjc0NFR3N2xLanFhQWdrUjNOMGJlV2EwRHlrZTZTc0hGazg4Vngy?=
 =?utf-8?B?Z1AzZ1IvaTVTVjdRanNxWDVIZWRPUVA2VldWWC9SRXRsVTJZZEF3WFBMNEVG?=
 =?utf-8?B?ZFZBM2xEUko4T3I3UnVIVzZxYVVNMWVkMDRSd0cvdG5WZ0hPZnRYZlVZYllt?=
 =?utf-8?B?eXY0QTROZ1Q1ckFwUmNZTnplQzMrd2puaWFOSFZ2RW5Yb3JxWWRoMmtmVU15?=
 =?utf-8?B?Qkhacnp4Q3NvdTVwRzhOWFlpZTBtdE4yRXpyTEw4MzN5Vi93aWxVTUozWENz?=
 =?utf-8?B?N0FPUlhiMTRDcElRWng1SXdrQXFKeWtPY1cyd0J5Q2dZK2YwQitINTRSVlQx?=
 =?utf-8?B?eUxSdnl4ck42U0dxdDRTbVlnWEZCdHQ5N3dqcld4VjlncHJNeG1Fazdwbm9l?=
 =?utf-8?B?dGlraENqR1ZJM1drS1BPa2lKei9MU3EvMjEvZWkvQ3g4YVhEbEhYUWUxME1p?=
 =?utf-8?B?bG9TdUdENXhKY0dOOEFWMHhzM0xRd2JQNTFvMXR3UEcrdGtUbXEydjI3VG9y?=
 =?utf-8?B?VjNrS2lKckV2YjMzNnVtKytxVVZxbVVCanpuQW56U29kNmZnTmJKbWpBb3lV?=
 =?utf-8?B?bjh4WTQ4ODl3aURQUmZyTkx2OVpDZDVPOHlKVFhMWG92Lzc0Q21DaWRqNWFX?=
 =?utf-8?B?M0t2eTNiNi93dEFaM3A4NGNuSGd1M3FtR1hZYTBNamJOTUZESzlZMnRjNE1k?=
 =?utf-8?B?Q0FMUndPWTc0ajU2UVlERzBXM3o3UjBlY040ZVdJSmpxL1QwYitrTFI1T2dz?=
 =?utf-8?B?ek4wcUJzT0RhLzVkNjJIdWEzMTlzdHRpNGg0OEl2NHJzYmNpampXeE4yVWh1?=
 =?utf-8?B?MHVxUCt2ckJMR1Brd0FFdEJvUThKYko4bUZhWlY2YU80NXJOUDZ4K0ttZE5u?=
 =?utf-8?B?RkVCR1Vla043b0RzY3Rvek54eERmSUpWYWlvZFY3MWFCcklUZkZDMDVxTFF0?=
 =?utf-8?B?Z2hVcVhPNkszbzBxQlhzQm5KaVRwd2R3L3Fnb1BkNDZkTHhGRWQ0aVhDR2d2?=
 =?utf-8?B?b2c5SEcyc0ZUZmdmTGI3OUpVbjYxK0tsYnZIYUMyOGMyRFUxMDNlOGdiWHBJ?=
 =?utf-8?B?SVB3Zkt2anFzQ0NTcUhhV1ZvcTBvcldzL3ZtUzhwcU5mc2dncCsvZFQwVTJQ?=
 =?utf-8?B?Vlg2WFJaeU81Y3RuSVpxS3VwR1pGYURiTlpDbm15V3llbHRjSU03ajVGdFlF?=
 =?utf-8?B?ZGNZM2JFUHh3a3AxdGRXbHVmTmNYVklNSE5QQnZOZS9nbG1rR3dNdnE3TCtK?=
 =?utf-8?B?VEVGRlo1QTljVC85S000azZMTXRrZmJ3QjZhZGF6WXRYdXZQTzhkSjBKZXNC?=
 =?utf-8?B?cXYrQVRVdTJQMEp0OGpPU3B4MGUzZW9jd3dQR3l4NlFSWXM4aXU1S3JVbDRr?=
 =?utf-8?B?OENIRzF5YTB1dUV0eGpkbXJzT05PU3dPZWM3eGVlaENLQXZRY2dDTUl2QVJj?=
 =?utf-8?B?SDlmZnBFd2doOUZ2RkJwTXNDUTc0c2UxQzZmY25TalBVNU5LRUF2am5iQ1E3?=
 =?utf-8?B?K3hVTjZIeXIxczZ4UVhNbkU0NkhmejA3eVhPZTRFVkNTOTFpSkRIUnYyZG44?=
 =?utf-8?B?eC85YUlhN0lNUlJYQlhLei81WU84QTlwbEJxamtNMlc2aFhJcTJoVDZMZWg1?=
 =?utf-8?B?UjllQ3p6S1RtWUdXT3FCa3dyZ2QzWlFNejA4cGl4VDJRcDlqR2F5WEJ2UVlV?=
 =?utf-8?B?dHZMOXo1Q2ZTRlJ6MUphMU53cHVPNjZPSzN5cEVYMWgvY2FPZEV6b0RFQVZw?=
 =?utf-8?B?bXJ0RW45OVp4RGdQYkJKTXArSnpYTEFjOHJtWjI3WDgwVVM4SFE3bWZlTmVC?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jGEwFJ2r0jQjkLSeZQSGTbkGH19DgfB8++Q+sA/sUV6/RjfVjc5krvvVmqYrF/XlANE4UlyVDuqHmLrtEtvkJZoMwi/m/MMxZqx/jnJeHPJf8Jtkz7DU/HWtfz1YzF3dFMiEUBeSNkr3mPUsSfcDP+I4EXGr4+YEH948pPzkGt7gFQoEd9uq/VXp6ZQ2qECMRiIxKl+L0i+pe2cjBMsW4mFntYwkoL7+Z0BIbsNE/DpzNnDk/PjJB1Krw7JBFWbVRV/DU96aSNoncZG+/TVZh2+ba0zTib0qNgkoFW2vZq6hDW/OSWXzM/hVzlPajnRaKqh324qrpAY3TD3DED9Wo+ktdNVyejye1bm160fn9Ii2UZDROi/Wv2GGMt8+LJ5omhWaHhkuyhAfjN8Ycj13Jja+AJCQv/AcO38rCHtOPP6SDXJ148ZevAWKihCGv9k1kpyj1OXwUjDgRB+nW9DD5kKrRjd4ZqwVoMVkdzR50QLW2LysR7ao4VLHik4rL2ohhoQDRjmTAUyb9Qrx8rtZlH1EGzAiP6i/7+4/MNDX83bD6LZzeMQ74vnbB2IiM3mxQEqS4Smelvm6iBoxrY3XwWN5g2/DldTwMXYG0AbCwBk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6c7537-28bd-43e2-3231-08dd939f178d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 10:56:06.7131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeVyZtAIfh3jA98ZJB9946llnU93s+jZcfkyy4SQNxQLUWdsDW7bU4LAKOKvpZ9DMV8EoV4CsEN9TtLfvT28yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7057
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_04,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505150106
X-Authority-Analysis: v=2.4 cv=DZAXqutW c=1 sm=1 tr=0 ts=6825c84a cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=m-bTEz1X52bi6cj5lS8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDEwNSBTYWx0ZWRfX25OqYKT+Z9IG eFfVXy7GB0yQGNhwPFLtjy4ikol/Cw3XyMlPGvjKIJmZDhSevUfKQKi0NHPAn8kCuFsCI2U8R++ lKdsc6dGgqy/vcUM5lydEKXXHTBHw7lefUPuBkI3i519T/xeQpR44uh+iztGSnnvdgfISZrs6hf
 i3ZpQLpaESaTKEQYqmMIhb/41VCt5WksHPkkuZ9pPUzVBcGVXf4tqz9jLk6ixJ1bK9j3HsF17IB 2BxnuNMk6egagWPfIEtw6JKLwUHIaHbtW9TO3rTHGjCVVigBxDWd54xn07SEYxLSa1+NSVEiV2T KinEl7ix3Dl9ZgqMP4nRF1Nx7kio7iHvWvuTD7ZcmVFOhqm5AKXCgatNab7Iv942SAUkcyiWgeP
 GrcnAKif9oOt9qJtrEy6ktu9kxB2WkLL+rm2A4HABPT2TxgEb3Ea9pfE//pD6klIudl9e7+/
X-Proofpoint-GUID: hUxbs1oQ4vymrUJjbivqkP6L7jdFeGdx
X-Proofpoint-ORIG-GUID: hUxbs1oQ4vymrUJjbivqkP6L7jdFeGdx

On 09/05/2025 19:40, Andrii Nakryiko wrote:
> On Thu, May 8, 2025 at 6:22 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> When testing v1 of [1] we noticed that functions with 0-sized structs
>> as parameters were not part of BTF encoding; this was fixed in v2.
>> However we need to make sure we handle such zero-sized structs
>> correctly since they confound the calling convention expectations -
>> no registers are used for the empty struct so this has knock-on effects
>> for subsequent register-parameter matching.
> 
> Do you have a list (or at least an example) of the function we are
> talking about, just curious to see what's that.
> 
> The question I have is whether it's safe to assume that regardless of
> architecture we can assume that zero-sized struct has no effect on
> register allocation (which would seem logical, but is that true for
> all ABIs).
>

I've been investigating this a bit, specifically in the context of s390
where we saw the test failure. The actual kernel function where I first
observed the zero-sized struct in practice is

static int __io_run_local_work(struct io_ring_ctx *ctx, io_tw_token_t
tw, int min_events, int max_events);

In s390 DWARF, we see the following representation for it:

 <1><6f7f788>: Abbrev Number: 104 (DW_TAG_subprogram)
    <6f7f789>   DW_AT_name        : (indirect string, offset: 0x2c47f5):
__io_run_local_work
    <6f7f78d>   DW_AT_decl_file   : 1
    <6f7f78e>   DW_AT_decl_line   : 1301
    <6f7f790>   DW_AT_decl_column : 12
    <6f7f791>   DW_AT_prototyped  : 1
    <6f7f791>   DW_AT_type        : <0x6f413a2>
    <6f7f795>   DW_AT_low_pc      : 0x99c850
    <6f7f79d>   DW_AT_high_pc     : 0x2b2
    <6f7f7a5>   DW_AT_frame_base  : 1 byte block: 9c
(DW_OP_call_frame_cfa)
    <6f7f7a7>   DW_AT_GNU_all_call_sites: 1
    <6f7f7a7>   DW_AT_sibling     : <0x6f802e6>
 <2><6f7f7ab>: Abbrev Number: 53 (DW_TAG_formal_parameter)
    <6f7f7ac>   DW_AT_name        : ctx
    <6f7f7b0>   DW_AT_decl_file   : 1
    <6f7f7b1>   DW_AT_decl_line   : 1301
    <6f7f7b3>   DW_AT_decl_column : 52
    <6f7f7b4>   DW_AT_type        : <0x6f6882b>
    <6f7f7b8>   DW_AT_location    : 0x2babcbe (location list)
    <6f7f7bc>   DW_AT_GNU_locviews: 0x2babcac
 <2><6f7f7c0>: Abbrev Number: 135 (DW_TAG_formal_parameter)
    <6f7f7c2>   DW_AT_name        : tw
    <6f7f7c5>   DW_AT_decl_file   : 1
    <6f7f7c6>   DW_AT_decl_line   : 1301
    <6f7f7c8>   DW_AT_decl_column : 71
    <6f7f7c9>   DW_AT_type        : <0x6f6833e>
    <6f7f7cd>   DW_AT_location    : 2 byte block: 73 0  (DW_OP_breg3
(r3): 0)


..i.e. we are using the expected calling-convention register (r3) here
for the zero-sized struct parameter.

Contrast this with x86_64 and aarch64, where regardless of -O level we
appear to use an offset from the frame ptr to reference the zero-sized
struct. As a result the next parameter after the zero-sized struct uses
the next available calling-convention register (%rdi if the zero-sized
struct is the first arg, %rsi if it was the second etc) that was unused
by the zero-sized struct parameter.

I don't see anything in the ABI specs which covers this scenario
exactly; I suspect the 0-sized object handling in cases other than s390
is just using the usual > register size aggregate object handling
(passing a large struct as a parameter), and in s390 it's not.

So long story short, we may need to take an arch-specific approach here
unfortunately. Great that CI flagged this as an issue too!

Alan




> BTW, while looking at patch #2, I noticed that
> btf_distill_func_proto() disallows functions returning
> struct-by-value, which seems overly aggressive, at least for structs
> of up to 8 bytes. So maybe if we can validate that both cases are not
> introducing any new quirks across all supported architectures, we can
> solve both limitations?
> 
> P.S., oh, and s390x selftest (test_struct_args) isn't happy, please check.
> 
> 
>>
>> Patch 1 updates BPF_PROG2() to handle the zero-sized struct case.
>> Patch 2 makes 0-sized structs a special case, allowing them to exist
>> as parameter representations in BTF without failing verification.
>> Patch 3 is a selftest that ensures the parameters after the 0-sized
>> struct are represented correctly.
>>
>> [1] https://lore.kernel.org/dwarves/20250502070318.1561924-1-tony.ambardar@gmail.com/
>>
>> Alan Maguire (3):
>>   libbpf: update BPF_PROG2() to handle empty structs
>>   bpf: allow 0-sized structs as function parameters
>>   selftests/bpf: add 0-length struct testing to tracing_struct tests
>>
>>  kernel/bpf/btf.c                                     |  2 +-
>>  tools/lib/bpf/bpf_tracing.h                          |  6 ++++--
>>  .../selftests/bpf/prog_tests/tracing_struct.c        |  2 ++
>>  tools/testing/selftests/bpf/progs/tracing_struct.c   | 11 +++++++++++
>>  tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 12 ++++++++++++
>>  5 files changed, 30 insertions(+), 3 deletions(-)
>>
>> --
>> 2.39.3
>>


