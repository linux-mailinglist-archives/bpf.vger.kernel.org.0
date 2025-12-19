Return-Path: <bpf+bounces-77152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC42CD0144
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 14:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBA90300A1DB
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 13:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41EF303C9E;
	Fri, 19 Dec 2025 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iQgqolQJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sA8qEEaE"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5E22135B8;
	Fri, 19 Dec 2025 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766151303; cv=fail; b=K5NCFvS4zqjiXvAUj0T843HVglKBigQ7YAuW+GCEDP8NEnMJHUqYUijOd/d2ula5TYLITkYKDEnzDK5M/+uWdSkJTeor4fipxfEQAxsUc+nnk14aO42pEKP2tG6j8WaC5TMYfUN4cY+n0lqPR12v/uUL0XhTeDWA9Pn3ffVxbWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766151303; c=relaxed/simple;
	bh=qIlBRw+vieSdOroYArviiRFycCZ2qGXQ66YjL/AUKmA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xt8Un9g6BmCCkAuzkDwW/RUbXS1vatRh4NXpluPSz8Nwosx4REBhr1AH22+/JdlqnQNz7jTSYpIBF8SSrukPpX2B8HTPrVBEeS9vDar0EEJOGaOsBDRDKnDf56zDNLn1xSGuikz+/7rJP0/3Gx3y99R6QrGkIpmoEzTPzGPRNXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iQgqolQJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sA8qEEaE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ3EYJM2823155;
	Fri, 19 Dec 2025 13:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OchlR88HMaAesBgTM5NV10IplVFH2h0oH3uBrqLQG2o=; b=
	iQgqolQJI4zdmlOI4UmlIPxHQOl1oxabYEGXQUX1LlYxFLeMrb1r8W43G5SPnlvc
	hpG1szbqVhUxj+K8OTvTHahd2CAgqR7GzpEXANCMBk4wva4yO4ZtGCkzr7j4BoxI
	rcMWb3Kx8iAqzXMSyipnPkofy5gXgcSX9u9DWrFsCnwZMATGyuVdRTWndRTTCEiC
	pvTAkLKBDYeos2dZHG7uClcAlttjXCXK4UmzO01o2J4su+7YkwztFbFPQKHxAA3s
	zqxZ67fQa4yTyJgk/Cla+L0AM1JODkaYlDseuC7j/PBPGiljOds4cF+NfP1NX0Es
	kx58vFKg6FJ8rS/hGPIOXw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b4r2a93vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 13:34:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJCpkhK023985;
	Fri, 19 Dec 2025 13:34:31 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b4qte6m6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 13:34:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTWOkFDH3G3/tqkVpLXT5AUwxz/YBdmQ3KDzN8V+/Z5nstdXitoo9MGL6EMO3g+xJmJ6F81FO/Psua6Yf6Dyp2NM6JHb5XgMUvrA+j9qbLteJYDvobX6vJouGAysFg/mizLi2W4m2WA9lmE2mIibxo9MRCBjFQL6JzWaivuFRzIJa7itmfScM3Ec5V33B72rKG6AmqVT3LgmuCLqHC8k0CTDav5up3COyN6aIhxv3vUVYK9WEGlAs9gIJKiw21S4SDzRx2WFLK6wnEsTWXZ1P9J3gxA1/xO7TpxbayyXEbBYODn+rAUke3ymwCQ/PAC2X59MvscfHu15GFSNrlp4cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OchlR88HMaAesBgTM5NV10IplVFH2h0oH3uBrqLQG2o=;
 b=UwZWbE0P6SYyZjtDAsKtSpOk5yx/f4/HHOS4K8qZYUuoOtRdqlKiao/tJkocEkAcHeAP2AlNTKix3EENVgbllkpgQVbxl4cY3co6NifD7akm5Xfd1MLruI5rtiNR7tMtwomA/13GLydmkFcTaRQDbVAMavQiOUGShjdJ+Jdhov5uRSf+InR/Q5irCtXULxYwGo+JdsO8K7x1GGXWmDo/fR0c/7bREA6VpJZLSpCjGNhGDXjrf2Q81vu40qy+hcx9fY5M45oFGG8TliNVIKKViBTIv19t/+TKNGqy0VMFcJTrhO71SWXGR+e3rvhze6Ape1+DnJti0SN+JR3S8jjumQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OchlR88HMaAesBgTM5NV10IplVFH2h0oH3uBrqLQG2o=;
 b=sA8qEEaE5GuOVLAxFpAG2xpeUC/nY4vPvVvc8MK2DekAZtJPH3cFvP88AhqVGalTIhg+sP6sg0e6Y6fbHKlON6FUbAJNXF8wbrzJTZeGh2wh72VbJDMCZzO8juV4hVoNmzDS6+CfnCn2fUhGoTUvneDLSOBD7sWCffUoZGlLcg8=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SA1PR10MB997739.namprd10.prod.outlook.com (2603:10b6:806:4bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 13:34:27 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 13:34:26 +0000
Message-ID: <db38bb39-7d16-41b6-968d-61e3b7681440@oracle.com>
Date: Fri, 19 Dec 2025 13:34:20 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 bpf-next 02/10] libbpf: Support kind layout section
 handling in BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org,
        ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org,
        ttreyer@meta.com, mykyta.yatsenko5@gmail.com
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-3-alan.maguire@oracle.com>
 <CAEf4Bza+C7nRxFDHS0dNDk5XF79nE6y4GqEu0bmtJPTMoFrNvQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4Bza+C7nRxFDHS0dNDk5XF79nE6y4GqEu0bmtJPTMoFrNvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0581.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::11) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SA1PR10MB997739:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b66541-b374-4197-70a1-08de3f03546b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHU0VlFhUUVDUWRuSlZEUnhUT0ZSWnM2WmNYRlhLdnpMS3NUYmRCRGM0eGxq?=
 =?utf-8?B?MjFUWHJvc09UcUhRRTdURzJRTG9BTUtKRGFGRXdWaDRuMEVPQWVuV2F6K2Q3?=
 =?utf-8?B?NXZUdzhsYkpvTDhjSTJZKzVOZjFDS0p0UndFbWhZSUpTeEJsbGZYdWxTUlFK?=
 =?utf-8?B?R01jMThVSHZLSE1xaTl4SUptZm4xOGI4L1NrQktkRldkTU9kTlYvbzdjRkJy?=
 =?utf-8?B?YXZFSEpsOStDTWNUN25YQUdWZi9nalRIREFKTlJzV0dqZlkrWnAxbUlPVktZ?=
 =?utf-8?B?aFN6N0IwL0tjQ3VSN084anFZUFhiRzlPMXR6TzFlTkUrTkNGS0tQa0s0MFJF?=
 =?utf-8?B?RXRKS0RJK1J4RnBjWWEvejNvUkxIZldYQTh4K2hXN1pGOG43dUJ5ekpLUGhX?=
 =?utf-8?B?bFFsbFQveXZoZzNLSDdxaVQ3ZmRYMktKUmFiL1VrcXNpb3Nqa0pDcjQvQ2N3?=
 =?utf-8?B?SFN5bEJpQXJQMjRidzQ4YzMzeEJ4RE5ieStaZ1UraC9xWDliMDZpVE1MZXpE?=
 =?utf-8?B?MEtJLzdrVzA0NjkyTVlvZUc3V0V6Vm96OEpReEpDVjI0eEtBbFNKWFh1amJ2?=
 =?utf-8?B?VTFWaFU4N0FkRUI4anBLM2djTWp6b0RRQXk4S1RZTkhmS29oU0VDTlVyWVp6?=
 =?utf-8?B?WDMxSjBFeStCblVIQ3JSQ0lMTU9oVkZwMWVBTWVscmFoUnNvbmtEbXpZdlRC?=
 =?utf-8?B?RnVEaHJ3ZmlIZ0xHWXpLSmZ1TXBFR3ZmdXpobHhKQ29NM1pZZFpKdmJPbndj?=
 =?utf-8?B?N1hQTDhWSmFpN1MrTEM0a1VxeS9uMXNIajBGbmozcmJaNitwMlA2OVc5Sm1K?=
 =?utf-8?B?cmZ5REdsYnJUK2ZMNThpMlJ2ZmxOZzhmZ2kxQWVubXhnL0ZPeE9WaktwVkJR?=
 =?utf-8?B?OXZhWkJZSEMyRnZzU0N4WHpXOTRRVWsyWkNuVUliRjdrZTI5ZnV4UlVIRDgx?=
 =?utf-8?B?aVJIaE1jV2RabU5kS0x0bWJrODNySnFZeStkTGlzSVoyMjBLSmJZUjZiMitB?=
 =?utf-8?B?T0x1eFl3QWhRaXFHMzl2a2prNE1VY0tNOFhwQnlxRzUyeElSYjlWK0l4cmdU?=
 =?utf-8?B?RG1GSUp3TVNSeFAvbnhJMWRZUk5UQXBEZXMxN0JjdU1LQjQxL3BWQ24venVZ?=
 =?utf-8?B?aFVpWFlCUDZCcEI3Q2U3K3dZS2xNM0tibGxxUEJBWXEvOU9wVFhGY0wyL3Rl?=
 =?utf-8?B?Zm9DdThaOUZwQXVONjhCMmtoc3YrYWNVY3F5U2UvcDRtVHFwamVmTEpEQUpn?=
 =?utf-8?B?a3VPc3prenEyZmtjbUFWV2w4VzhqU01Hb280QzltUEpva2R1VitMdUpvUnVK?=
 =?utf-8?B?bnZFTlNxZzFLb0FXVGlCcDdwanpUMS80aEx0K1NWYnoybEhpamtwYkJqMjRF?=
 =?utf-8?B?UHhVNTI1dzRDUlVDZHlCVU9LOUo0eUxreUVBNHB3UmJKSGxjUU9UTVBXVUo4?=
 =?utf-8?B?dzFBclh1OVFHQ0Z4N1RabFUzOHE0Ym5acFBIekc5NHg3em5ZRG5ZcGgvMVRl?=
 =?utf-8?B?dzRBcUFuMXNPN3FLcThNaDk5YmVJK2d1WkNNNjFEYWlhVnBheHg4Mk53OVV1?=
 =?utf-8?B?VitMMUJQYlltcFFRc1ZqeWtCOHJUMTRWRDRoQ0g0Lys0UWtpTWpUV0hBZlFt?=
 =?utf-8?B?UTEzUHYrbjJXUVpCMzJRc1RlL0lub2hHM0JDZHRJdGpBQjFmL0JTdW5oKzQ2?=
 =?utf-8?B?SHBacTVBb2lBTkRtSXE2QUxFbjFRTFRXc1JnZXNZVklRYjBlbkVmRnFKeTd3?=
 =?utf-8?B?YnBKc0NCZ0wvMUNKWTdnNTNFb0RsOGMyK25lSXo2YVZBNHVNSnNRWjRpQlVx?=
 =?utf-8?B?b3A5ZUVJVUsvcjZqNDRqN2F2V1dvang1ekk2a21rZ0o5SldwTVRtU3BWRkxQ?=
 =?utf-8?B?bzNpMlkyNTk5aWZTS2JNWWxWNFVLcHp6Y0JiUnhCMDE5MTAvZU0xTXdETFl2?=
 =?utf-8?Q?FSNedV3zB8HZfSAvsYSNuCwK+SaqLerR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2R6RSttL2t6dE10SnBqNlRVUUM3d3UycmxPU2k2dlczOFA5L1gveEcwNmlj?=
 =?utf-8?B?eXN3bjRBM3Y5LzhtVG5aekxhcVpZTGFac0RxNW5mcGFqM2ttK1hmY2IxU3hj?=
 =?utf-8?B?Z1k1alhTUldoMTRNMUt0N3BERVJyWXVKYU1RMERCZm5XYlNSaVQzV05BaWRZ?=
 =?utf-8?B?UkhRSFhpdXpJeURtM1Z6UVNXYWNPUnBoZW92QlB6Q0pJc1N3V3I0YUh2cEVk?=
 =?utf-8?B?ZWloZ2JQeHVPMGZDTmU4cTFBeXo0cTZubnVHU1ZvMlRFMHNtemJudExBelJL?=
 =?utf-8?B?UWxGZVNndVYrUGVtNUpJenZpOEFwZVdETjhWMk1uY09uVFBMcXoxTnlwdFoz?=
 =?utf-8?B?dkEzL1BxbjhxbXREUlVtQTdDbzVrTjdkam51T0Rkb1JsZVgrbGQzdk1qUGZt?=
 =?utf-8?B?dlREZlZSK2ZDbVArVm16MVM1dDhOS3RybnliTVVyR2x2dmk0cTNOS1N6a1U1?=
 =?utf-8?B?Y2RjOE91S0tidkJMTk5GQ0grS2EvQTBRd3B5RnpHMFdILzlyMmM1REZsVGFT?=
 =?utf-8?B?d1E3Y0x0YmJwbmV5dnREdnVxL1owbDRqclZzMDV1c3F6ODJHdDJkQlExdG4v?=
 =?utf-8?B?SFdHK0I2YWRUNmlYckRCQlMxZERvNjkrYmx4Tk9qdmdWeUIvOUl1TFYzdjJJ?=
 =?utf-8?B?WkdmNFRXT2I2MDFHaUVQZ1dwbm54eEVKOXlWMnZTeGcyVW9PS1Bzb3NXLzJq?=
 =?utf-8?B?bktUMWZPU3UzcGhRc1ZFQlNvSGF4K1JDMWpuR1FZN1NQRFg4M2VXemk0dXVR?=
 =?utf-8?B?SXYvdi96cmh3b1NTM290THlyaDN0aHZHVWdBa1Z6Rms3RjBKeTU0TVo1QzU1?=
 =?utf-8?B?WEFkRXp0dkpkUmZqamtjaWdkbW94MFBYbWxMYTg2NFRWQTZRS0lkYndjTVdq?=
 =?utf-8?B?R0tHQzFKeGl4YWZId0dDbi81RFFLeklhS2NQLzV5M3M4aHFwYS9lc3lpWVQ3?=
 =?utf-8?B?dGk3MHRwWXJXcXNzWlg0L29NUHF1a1NKQ0NLRlkyZHhoV0ViaTJCT0k1bFE5?=
 =?utf-8?B?eEJLU3Z6aEVvUTZTY2N4TllrOWpWTGhIVmh1L3o5VllWSTJRWFl0dGFzUHdn?=
 =?utf-8?B?WFRJOUhNSnNCUmpoakxEYmkrZXh3NTg2eFRHaUJoU2U0QkxEZHA5Uzc1MU5R?=
 =?utf-8?B?eWcrOFNiVlJ3ZXJyTmttMmhnM3daTVh6N3k5M2NkZ1QvSkt4ZmZ0NTFqZ2JW?=
 =?utf-8?B?UFYzYk1HUStWWEdFQ1d0NjAxY1BvQlEzZFRLbDM2WVR4d3NGMHJieE84U0JV?=
 =?utf-8?B?NHE5ZnZlbGNDTHAyZWVRUXA3SFNGbDNFN2JxdHNwaFh5NmVsQ0RBb002YUhC?=
 =?utf-8?B?VHl5NldPQkQzcEdXMGpsZmVlaE9hZkhaR01xZ2pQaTYrWEljcThSdk9zbFdl?=
 =?utf-8?B?cUxkVis2THl5UGtOTjM3OFBRZmpDQzJPbVRwMlRCUjJjNzFFLzVXUzFvazJG?=
 =?utf-8?B?WEY4ZkluUVU3SGdZWnEybTAwRm13dTBWRDdCMzRlS0txczNFYXZ1TGRJTFhM?=
 =?utf-8?B?ZllqaFBJRW01U3JjTElnd2xSbk5WRllSNktMa01pZzlKWDZ0ZFAxRjJZNnJo?=
 =?utf-8?B?NmxqYTlrN1lWclRSRkxtTlgvTkdrTG9ObHlxK0NaMEFZeHMwYVRpdlFZKzBy?=
 =?utf-8?B?TXVXbFA3Rk44ZHhhdWFkL0lDMVhpaS9sZ2pFbUNlaWMwNThBVXU0NWMxUkxW?=
 =?utf-8?B?MmY2YkdIdEtQSjFlbmsvbXUwOGxlZDcrQ3IxQTJ4aTR5UDJWTFNCMjEyQnNL?=
 =?utf-8?B?TnRHNHlGYU0yYzUvQWtjeU1lcks3U1JFRm11Y3lkU2pEUHlkN21HQUxOa21R?=
 =?utf-8?B?S3l1WmhWb01Wc0pZdUhHOUthRkphTHQzVDhCbURjSVB6c0hMQ1hxSTJiYTVC?=
 =?utf-8?B?L2J3N2R2SjlmK0hTMGVrcFo4Zk0yWmpYTWlFYmhsK1ZoQ1RHNEdpTjJYS1NC?=
 =?utf-8?B?enBOeXE4OXJBSndOUkJYNi90Q2ZFdFFCczA3bkFFWE9NbUNvSEZiOUVyZ1lt?=
 =?utf-8?B?VktUS1gxaVExdE84cjZ0R1J1b29FYnRuOU1BWXBhVjE5MkxMT0h0Mm9QcjA3?=
 =?utf-8?B?UjloTFYvSGlTcWM5UFFPL3RtWGVNVG9pZldYYzJEM21KTmcrU3ZpN3ZEVTND?=
 =?utf-8?B?anFjajNBTStnT2M4YTN2dnBmYzVzbnhyWk1vZ09Tb2tYVEU3SDNmdVF1RmZn?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i305lSQyJJ422P9MWdt0W2/fnf/BuhYG77DbQB0RPEy/gKZB7NDCvFmWmTK/7mC2S8p4qIrMDKXrWZA6SX81FiSzsTwBL5vbTh9ERyPyeb9Kgg106VaWMT8qDxVwmY2K0T7kv/L/nSsU3GutqqioiiriSYPp8IC2XZbJKngtUh1epjufHQzvjV+r/WgbJtu7k7TW6XTa6aJkr6ZCZn4mjUIHNI7AmU6phRIBBRhOYb53z9IwfxfvM+NRt5FhfQgwbgDCcYxnXz5qvlC5O4Gmi2gl4KkNYqiYtK1kEgNuu1cwC0dyP6dETcdyyDaxIRQ5Qk4iOrFnxsPKRCZ3EHtzvzttt4y9Yytc/TB9XqY+V7fqXafFfIMyxPV4jer+uPdVEQEL18clbJoI+tpWbm8x9dmcnu+qHTYQU3a7S8L0C2RWpOWbzt4eQzACGRts6M+eChfB4txwtWg09lvZKYBvTr97+u+z/tJl3gZsbwre31PfCFWfEQiQpLCreiH+SfS4iW1KCNmKvFtRt5kPbl8OK6hLI9XdYULMNtt2kr68quKWBruPhU7M40fCwiEaHmTJVbFxSzELHI2FU+MgqGbATokUuYPsvhUD9s2rwEEnAYI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b66541-b374-4197-70a1-08de3f03546b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 13:34:26.7908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: maFTEicRKDl0AEfL/+qzDyEAxmtT0uqahUJaz77lWe0ljEZMHBNLmLOmFtaokc0BlAQpyE/OV+0XbR4kV8pqWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997739
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_04,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512190113
X-Proofpoint-GUID: fBD6FzS1TKxp3B051aelB3oIyrBlLmnx
X-Authority-Analysis: v=2.4 cv=bdVmkePB c=1 sm=1 tr=0 ts=69455467 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=sX207dYFrVVYPs9-YgQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDExMyBTYWx0ZWRfX58obA6ko14bW
 LpgAS8X8nFkjmXDj6H4xUHrHvqiuQrIGos7t8qGl1PlaNDvo9RR0Z4cBIiG8CesjxotfxGNPUQv
 G7UFJpsCRjJMpWW6jYAS7uE+n+EXEKLNaaupCQ+NxNB5rdo3qxfF5fj9KE1uanur6xH8ATvivC8
 u5AkCO/taib1PNI+hbY/oCq2pHSnPBYxA25dFnuUSC4QsWysskk4il6xpfuoCPfD4Sax+HHt8mV
 bUmgtrrRvxX+WGZHYeSpORjmFldLnWWGOTj95u7AQ+6JJ/Jek8BhBKCZCiB9r6tonF3fyeAQnuz
 eZaqLXNBU3aMGJ/2ksrqTOMEa/V4RNbOCsNaQ2TjqwfECH168Mp4T9JTXcmSjIPjTQkFhX/JPmS
 5I6Y+2FR+PsJa02D0ZjkOW78uJzD3sX5xzic3g93lKt7cw8neWL8n3m53GKxYEcSHEuQYvYqiBO
 Tw+vGVys0KIuCTYYBDA==
X-Proofpoint-ORIG-GUID: fBD6FzS1TKxp3B051aelB3oIyrBlLmnx

On 16/12/2025 19:34, Andrii Nakryiko wrote:
> On Mon, Dec 15, 2025 at 1:18 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> Support reading in kind layout fixing endian issues on reading;
>> also support writing kind layout section to raw BTF object.
>> There is not yet an API to populate the kind layout with meaningful
>> information.
>>
>> As part of this, we need to consider multiple valid BTF header
>> sizes; the original or the kind layout-extended headers.
>> So to support this, the "struct btf" representation is modified
>> to always allocate a "struct btf_header" and copy the valid
>> portion from the raw data to it; this means we can always safely
>> check fields like btf->hdr->kind_layout_len.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/lib/bpf/btf.c | 260 +++++++++++++++++++++++++++++++-------------
>>  1 file changed, 183 insertions(+), 77 deletions(-)
>>
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index b136572e889a..8835aee6ee84 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -40,42 +40,53 @@ struct btf {
>>
>>         /*
>>          * When BTF is loaded from an ELF or raw memory it is stored
>> -        * in a contiguous memory block. The hdr, type_data, and, strs_data
>> +        * in a contiguous memory block. The  type_data, and, strs_data
> 
> nit: two spaces, and so many commas around and ;) let's leave Oxford
> comma, but comma after and is weird
> 
>>          * point inside that memory region to their respective parts of BTF
>>          * representation:
>>          *
>> -        * +--------------------------------+
>> -        * |  Header  |  Types  |  Strings  |
>> -        * +--------------------------------+
>> -        * ^          ^         ^
>> -        * |          |         |
>> -        * hdr        |         |
>> -        * types_data-+         |
>> -        * strs_data------------+
>> +        * +--------------------------------+---------------------+
>> +        * |  Header  |  Types  |  Strings  |Optional kind layout |
> 
> Space missing, boo. Keep diagrams beautiful!..
> 
>> +        * +--------------------------------+---------------------+
>> +        * ^          ^         ^           ^
>> +        * |          |         |           |
>> +        * raw_data   |         |           |
>> +        * types_data-+         |           |
>> +        * strs_data------------+           |
>> +        * kind_layout----------------------+
>> +        *
>> +        * A separate struct btf_header is allocated for btf->hdr,
>> +        * and header information is copied into it.  This allows us
>> +        * to handle header data for various header formats; the original,
>> +        * the extended header with kind layout, etc.
>>          *
>>          * If BTF data is later modified, e.g., due to types added or
>>          * removed, BTF deduplication performed, etc, this contiguous
>> -        * representation is broken up into three independently allocated
>> -        * memory regions to be able to modify them independently.
>> +        * representation is broken up into four independent memory
>> +        * regions.
>> +        *
>>          * raw_data is nulled out at that point, but can be later allocated
>>          * and cached again if user calls btf__raw_data(), at which point
>> -        * raw_data will contain a contiguous copy of header, types, and
>> -        * strings:
>> +        * raw_data will contain a contiguous copy of header, types, strings
>> +        * and optionally kind_layout.  kind_layout optionally points to a
>> +        * kind_layout array - this allows us to encode information about
>> +        * the kinds known at encoding time.  If kind_layout is NULL no
>> +        * kind information is encoded.
>>          *
>> -        * +----------+  +---------+  +-----------+
>> -        * |  Header  |  |  Types  |  |  Strings  |
>> -        * +----------+  +---------+  +-----------+
>> -        * ^             ^            ^
>> -        * |             |            |
>> -        * hdr           |            |
>> -        * types_data----+            |
>> -        * strset__data(strs_set)-----+
>> +        * +----------+  +---------+  +-----------+   +-----------+
>> +        * |  Header  |  |  Types  |  |  Strings  |   |kind_layout|
>> +        * +----------+  +---------+  +-----------+   +-----------+
> 
> nit: spaces (and if we go with "layout" naming, this will be short and
> beautiful " Layout " ;)
> 
>> +        * ^             ^            ^               ^
>> +        * |             |            |               |
>> +        * hdr           |            |               |
>> +        * types_data----+            |               |
>> +        * strset__data(strs_set)-----+               |
>> +        * kind_layout--------------------------------+
> 
> [...]
> 
>> @@ -3888,7 +3989,7 @@ static int btf_dedup_strings(struct btf_dedup *d)
>>
>>         /* replace BTF string data and hash with deduped ones */
>>         strset__free(d->btf->strs_set);
>> -       d->btf->hdr->str_len = strset__data_size(d->strs_set);
>> +       btf_hdr_update_str_len(d->btf, strset__data_size(d->strs_set));
>>         d->btf->strs_set = d->strs_set;
>>         d->strs_set = NULL;
>>         d->btf->strs_deduped = true;
>> @@ -5343,6 +5444,11 @@ static int btf_dedup_compact_types(struct btf_dedup *d)
>>         d->btf->type_offs = new_offs;
>>         d->btf->hdr->str_off = d->btf->hdr->type_len;
>>         d->btf->raw_size = d->btf->hdr->hdr_len + d->btf->hdr->type_len + d->btf->hdr->str_len;
>> +       if (d->btf->kind_layout) {
>> +               d->btf->hdr->kind_layout_off = d->btf->hdr->str_off + roundup(d->btf->hdr->str_len,
>> +                                                                             4);
>> +               d->btf->raw_size = roundup(d->btf->raw_size, 4) + d->btf->hdr->kind_layout_len;
> 
> maybe put layout data after type data, but before strings? rounding up
> string section which is byte-based feels weird. I think old libbpf
> implementations should handle all this well, because btf_header
> explicitly specifies string section offset, no?
>

That sounds good, but I think there are some strictness issues with how we parse
BTF on the kernel side that we may need to think about, especially if we want to
make kind layout always available. In that case we'd need to think how old kernels
built with newer pahole might handle newer headers with layout info.

First in btf_parse_hdr() the kernel rejects BTF with non-zero unsupported fields.
So trying to load vmlinux BTF generated by a pahole that adds layout info will 
fail for such a kernel.

Second when validating section info in btf_check_sec_info() we check for overlaps
between known sections, and we also check for gaps between known sections. Finally we
also check for any additional data other than the known section data.

For layout info stored between type+strings we'd wind up rejecting it for a few reasons:

1. we'd find non-zero data in the header (layout offset/len)
2. we'd find a "gap" between types+strings (the layout data)

Similarly with layout at the end

1. we'd find non-zero data in the header (kind layout offset/len)
2. we'd find unaccounted-for data after the string data (the kind layout data)

So either way we'd wind up with unsupported headers. One approach would be to
do stable backports relaxing these header tests; I think we could relax them to
simply ensure no overlap between sections and that sections don't overrun data
length without risking having unusable BTF. Then a newer BTF header with additional
layout info wouldn't get rejected. What do you think?

Alan

