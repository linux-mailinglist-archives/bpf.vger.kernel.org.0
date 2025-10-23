Return-Path: <bpf+bounces-71873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D32DBFFD3C
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 10:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D20B3A8208
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 08:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3092D2EE5FC;
	Thu, 23 Oct 2025 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YT5sRM8R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UT8d+VR+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFD6C2E0
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207475; cv=fail; b=W8tHRLztpFaeo4WbMK+76lKa3QUGbp4Er3Wob8Yo8+3xZm0LaV+S6s35grXhZiKvenUsdg8MadIm/4N420X0/rufJ6kpvfhMF5KBZQD1GxtRKSC2QWzZGceG82+8j0AAvzn7IBRfra7BHVCzYnVS/6D48a9/hBbsyglSRK7JdkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207475; c=relaxed/simple;
	bh=qoiQ/DpYKQUtKYF8pCRLc/qDCxYkxp3mSN3zFHKwMOA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J1tq+SI+vInegE2Q9xegv6IiRhNCSsFQDsd8DIaOA8yD6rr4/0K3SvmiNFvW2X6IXzaD9d34TrrPEYYeziQzBypWOxBQJHoQJJCEtxdaXD2acZxNoHoKkA2ujdtnVURRNQFGdSzx26svaZAL+udfhLfVZMf/5xS8UKSL27WXEQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YT5sRM8R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UT8d+VR+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7uL5t002246;
	Thu, 23 Oct 2025 08:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gz+J+MoxBZnKO7WrbXmh2/r+KHDACWmqnCqyXkwaiSA=; b=
	YT5sRM8RhONo3+p0tMVN/RHx/xLYzIIwvpKvijB3oqt+usvxPvcL9vQCT3zvvjp1
	8H5NyUGSoyEFZfcZ4MK6p9r3gZGQLm65fbRZbd+9BzmPt4NKrsvJQGXaWIrevK2C
	PVWDbHZ0//ehbMJNoOkz+PMxAK4JucdkRjsdxajz5Mw0byjnn+8FPF2HPWirMjmI
	ZgAckoz3w2Z/pQDoob9oALvS7eBVNi11fWJVp/2NRq8+HBxVLX3B8l2QscMX0dem
	O+yFB2MjVSYJOLP9wJTXfm8p6w67b7SpVwSJ/ndiV9yMUSjQJ+OF8+u3oS7kAJ8o
	v+vISaN3LPtYXrdqNC0WhA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49w1vdrcxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 08:17:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7Ns6f022182;
	Thu, 23 Oct 2025 08:17:26 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011013.outbound.protection.outlook.com [40.93.194.13])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bfa85p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 08:17:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIvymtusRpV/QkFEhG28+PLM4gyr28rHndVnSfrkV+Aceme/2cZlKvGdnSDAr8qfMl2KXliQoSUwt8ynVzSwBmDdTgIn1ollh+ZwfzISnDGdcjo9kioGMEOKzP82/Yafv25dBiLf3/NaZMS3s0f61K9wiPq/ufV7nLmDbxLloudyQy9y5JwPIQS8gHSLCXBnthswKLYHTjTMRZ/4dUXGcIiSxZXb5M6Zc2t9yP51il/z9xdTKDcMrLKf0TCbkhokd150LVk5Lz9V6zSI5d33QiQI+shJ/el6fBGe9ZPtvZACxHLBGOkoDaPnDVFDLxLXV4pAeczUqIdMt4a3xmcQLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gz+J+MoxBZnKO7WrbXmh2/r+KHDACWmqnCqyXkwaiSA=;
 b=om78xHHG6ijvDX8WEGns0KekHXrQItBKdYAez761KC8HIQlwFPVAeyfH2LJFcxtU5m9Ra7SQIwIDvC19RJ7MFVIo7rhUZOFQ8pfc/r3vy60LqgmbABVHBCM1S+VWX1mnn4h3QqA8w6uMeoeUnGcNS/g6i+uDRAG+rqGT8N1RAbs1j9sFGEfzpxaebTWdmycOuPgUODPR+WGP+8oLSf9mvfSiCTgBujaoMyQKcPCoel8ivpHGrh6PapRU6i//uFhkPQcPt/K3RzgawMnm/e7NixDDGnl023J+8Tf9EyXDsWj3pStSRJiqZpo1cymHcwWmpPvi1aOHIrbKeU7WTvoVmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gz+J+MoxBZnKO7WrbXmh2/r+KHDACWmqnCqyXkwaiSA=;
 b=UT8d+VR+8TRqar1yQN3d+nxsfThYNBM5nHr5ahB0m4sWMuhsRw9Ll04QzGhTy36MdBqqtq7WOLh/82qwaw4zeEM7pNME5/LZMDLwfyXohQtPTCMiDwaOUrLjcfDdScgi/qT/FDHiN4OSNBtVQ1F00eTGuKkGA3Fk+7rEAqiJTqk=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 BN0PR10MB4918.namprd10.prod.outlook.com (2603:10b6:408:12e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.12; Thu, 23 Oct 2025 08:17:21 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 08:17:20 +0000
Message-ID: <3bcad9a2-5765-4db8-9488-f9cdaed7719a@oracle.com>
Date: Thu, 23 Oct 2025 09:17:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 01/15] bpf: Extend UAPI to support location
 information
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <20251008173512.731801-2-alan.maguire@oracle.com>
 <CAEf4BzZ-0POy7UyFbyN37Y6zx+_2Q0kKR3hrQffq+KW6MOkZ1w@mail.gmail.com>
 <f2e1fd61-7d3a-4aa6-9d36-a74987d040fe@oracle.com>
 <CAEf4Bza+zCKVHPHFDnNtKoYNGfeq+y7Oi96-+GGWOb8kop8tHA@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4Bza+zCKVHPHFDnNtKoYNGfeq+y7Oi96-+GGWOb8kop8tHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0279.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::11) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|BN0PR10MB4918:EE_
X-MS-Office365-Filtering-Correlation-Id: 80cae006-e9c5-40a0-38d9-08de120c9663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzdVY3BmZjlPYnJxU3l4VEIyU3M3dkhVNlMzVm9tZld2Mkd1U3FLL1BJL2J0?=
 =?utf-8?B?bG9OYkYxbTI1eTBRdnhKbWl3M3I4SUpFQlRIZzNJVnk2alRSVjJDOWo5WXc1?=
 =?utf-8?B?NDU3dmZ2WVRLNDFUYzZkSldIWEUrQXoxeEc1VWtGWXNzNitqeW1iU01aQlN6?=
 =?utf-8?B?SVZGOWo1N3RBeEUwcXVvY3hnbGFIUjYxdWYrSWs2MlNzMlViTEdwUEFjWkI1?=
 =?utf-8?B?ajhJN1dVWXhtWlVTVVJDMjROMyt2TiszQnBUdzRlSTRiQmFWbXNnTzJQNnlO?=
 =?utf-8?B?Z29taUFmOFh3SEFxQzZvTXYwbHJjR01JL3ZQMEZjOXZ3S0kzNlhuMGJnUngz?=
 =?utf-8?B?ZXlDdFpHRlRNaE1EQnVhNUV1V2xQamk5bzlrWlBpL0JEdFFwWDRFWVpxbFhy?=
 =?utf-8?B?YVMwcSt4T093aW4xYmR5a0p5cmNaZ1ZkZjZiZkZUVWdhdGVISTVYNXErdk4y?=
 =?utf-8?B?bm1zR2dpaWZZNVliYkFDSzFUbkdOejYxQnlCdkJrRnlBNlpRT3BZbS8yV3Uz?=
 =?utf-8?B?UXlrdGFsQlV0ODRpRmpJaUViRG13TFBXRU1Kc21iRTdtaVNUWDVrdDQwUTEx?=
 =?utf-8?B?RVNGcXJseW4zbEZDRE11LzFRYmFqVTV1RVl3NHZKaHRqemNBRyt5R2wxQy9l?=
 =?utf-8?B?eWVCcmpDRW56M1VzZ1BSajhwTFMzdkw4VkRQT1EwMzd2bnh1dkFkNTNGZ0tx?=
 =?utf-8?B?MENJVzgwbDAzY09ldlVwd2NBKzZtVFNKUTJxZHhwb1VNd1VMeEpYU3BkWkMx?=
 =?utf-8?B?dHRQQVNZSmcxSElGay9veXB3REZPSWdiMmVBb3RyQVd0QlIzUmNDcE8zc2t2?=
 =?utf-8?B?TUduK2lqU084MGgzT2t5eU01UnpVNVdhMkUwQnNHdjI0blk1OGlFRExOelJ3?=
 =?utf-8?B?bVFUcFdjZC9FcHpESzd4UEFJYVptRjhwTCtQbis2WVM3SDBDWGlSb0hJbnVF?=
 =?utf-8?B?QmQ1NERTNHlyYy9KTHdaSC8vNE9lR2R1NHcrYnBFdlQ5aFE2UkdtOHpweFR1?=
 =?utf-8?B?dXlGMmJrVDJTQXI4WWFidng2YSs3NmZiKy81WUUxbE9BMDdiUkJhZWZZR0dn?=
 =?utf-8?B?UGIrS2pPeEhwL3F3REZCWHFvRlpyc0loRW82MU41MFdQNEdUWnJJSG9kWFl2?=
 =?utf-8?B?SVYyaTRWNEp1ZjhJN1o1elNIcVpQZHNoVU1QQ3BqaWlwQjhoTUFqTDkybnBw?=
 =?utf-8?B?Z3lQbmtMdnRlOXMyRFJlQytjSGhQTnFiTjBNRkxZOG14QStFN3FTeXhSSWNx?=
 =?utf-8?B?TExlSWxSbEJzTkt0d09EU0dFMmtpazQ0aWxWM21XbjRSaSs0SGRxN2dyaVhS?=
 =?utf-8?B?cGtlM1RmMWxzV1djdHY1UThwbkpEOU11NmFwN0MvY3ByZTlxYlVjVHMyZGpT?=
 =?utf-8?B?OC9wZ05hNjZxUmx4dXg5Ym0vQkZiVjR6R2FFTjU3K3dERy9ZdnN0dm01Y1hZ?=
 =?utf-8?B?TmUvZ1NqczFxbGFrOXpFOUUzcjZSTWR3OElEVVBhSzMrSVhEaERDVk84NHZH?=
 =?utf-8?B?azlmT0ZoVHZoV2NCZitjcUMycFN3N3dmNXo0Mm9PMG84bWhQQ0dZaEU4ak1N?=
 =?utf-8?B?WU1SNGUwY2pWWS8zdnArdjZ2K0dKeE1heGF2dHFHamJibFl3Sm4yQmU5V1o2?=
 =?utf-8?B?cFRvcE9DcjJLNkRuZFRsZCtZUU4vWEVYSEV6Q0EycVlTbmxScDlIY1ArK1M1?=
 =?utf-8?B?ZkQ3N1ExT3N1eHJHQWFZVU5UZ1Z1L1NOZXNud3o4RWZ0b0FrN2NmV1d1NjJZ?=
 =?utf-8?B?MSt5R1ZQMFJhbjdkRHc3T01JYy9QVHV6V3hsZERodys3Nk1WbXUzUGNUblZp?=
 =?utf-8?B?dWNNRFlRN3p4MTRDWjVPbU9kejdkS0ZtdHpkcTRrUFo2OTViT3hPZlNhaTBp?=
 =?utf-8?B?am5tTit6a3ZPZHZrdTFVOGgzbHIrcUhGekxlbFE5S3FFeWJVT0trOWpkd0k1?=
 =?utf-8?Q?tVCl3IoggUOCkGQv7hTCsaKMZG/u0nDQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVBmWXdLV25OLzZDNnhBcW5LenJpOXZyOGNmdDc0SFNvZnZ6MXZrNjlUTy9T?=
 =?utf-8?B?UUlMS1cwU0M0Y0hzeXRBakFMWVVIY2pubTBhVkUrQy9VTzlYVE1YWWdYQkJi?=
 =?utf-8?B?UWVFUXdST0FaQTNhellDcm9Od1cwZ1JGQ3BXZWREc0lMb0c0OTJTaUEzQ1dQ?=
 =?utf-8?B?b2w3T3ZMdEhXOWpCRlI2S3dmZk54MlNKTzRiSWpXUXJEMCswVi9FYTZpeXdn?=
 =?utf-8?B?blZsdlFhK0JjN1ZhZi9nQzlvTERjNnZPRXBGVVFYSXJpNkM4eFFxKzA4R2x2?=
 =?utf-8?B?UTd0VFhzU2VMaXFKY2JFaFV5cGEvVFBucUg1KzFoMGxHUmhoSENTL1E3ckRI?=
 =?utf-8?B?MExkS2k1Sy9VK284N1ZQTVZ1MXZ5MFVZalJpRUxNTTBVM2RRQ2JXM1FjU2dZ?=
 =?utf-8?B?T3I3SC9RYytyaVJ1SFphdzdSaS9hazNSTnU1TkRadWsrdWtNaUh1NmpnY2FW?=
 =?utf-8?B?Y1ZWNktZdUFrSjFEUDgzZExpL24xN2dhUzlOWWpMWDJlYmR6Q290aE1Pa0F6?=
 =?utf-8?B?YTU2UlVZUGRVMis4Ri96aWtqTHQ1TmhwSjYzUGNBZUZvMHpQMUQ4ZlZxOEcw?=
 =?utf-8?B?S2dBeXQrU2tBNjdXcmhPL3Z1VFdnaXYxRmdTT2lWenlIM2VIaUZ4Q0xvS0da?=
 =?utf-8?B?ZVF2eEJpMUl5V0Y0Ny9sbVZiTTBSdHBEQncvcW85YzFxTzhQZWlESmxWak1r?=
 =?utf-8?B?b1FlaFMrQm0wb3ppTG1RUlBQdktsWjVlY2lqYU9Cd1dqeGRIcUFxOXVyRWJt?=
 =?utf-8?B?RlpHOTFqR2Y0cVN2ZTNlY3hJWEhDaWFtdmtpaElIV2NSbk9ubGdvTEVTeFZG?=
 =?utf-8?B?cVBkdTRkT3ZMR2NmSUgxamZydDNZTXRFU3BUclRIUzhJU0R3anF0djNiQ0Yw?=
 =?utf-8?B?YU1IaFBLNzkwOHpnckkwQWNZdXJydEVXZmlZOCtlVE5iVXJZVWM3T0hkaTRW?=
 =?utf-8?B?VlpLSkIwNmkxWWtlK2VMdzVwZ1VYaWhmZ2RwTkVwa2t1cHRKV2tuTC9tanY3?=
 =?utf-8?B?NkVMa1dYa3VzajAwWjJkLzNLVmFhaXVQMnI2ejR0ZkpjTHlFaW9GWlF5S0RT?=
 =?utf-8?B?MFNEYkJJQzc3T3JwbDkxVGtKMEhnOXdQZWdLU0Y3TUhJc2VSTkZwVk5TbGVv?=
 =?utf-8?B?RW5heXhLaVRvSkVVVEY3WFArM0dKdE53dWpWR1pRajY4T1paOUNYN012NmVt?=
 =?utf-8?B?R3lpOC8zcmhyUTR2ZEsybWtnVEpsMFlqdTlUTGQwWjJLcHpFYitpSjBGL3E5?=
 =?utf-8?B?VVRHcXIrWHBiMjkvMkx3Q2hJalZ2TENVbHhONDJzeTJ4SXZTd09NNE1DUm1R?=
 =?utf-8?B?SjVyK3RFcWRCUzB1b2M2S2o0VDV1eE9xdnRhblExa0t2VHdBOUFaSkhvWFpx?=
 =?utf-8?B?eklKQnhSd25xMG1GMytZWi9GQ3QxSU9Dak52NzF2ZGUzL3JhZzVxWGxVM2hq?=
 =?utf-8?B?dXJEamw5NzEvVU44ZWNaYktWeHd0a3YwRnJWTWNCL1hWcmVmWGpPZ29JOGRJ?=
 =?utf-8?B?RmFJU2UrcWFvcXYzNFBBOGhuMTVIcSt6ekJsd0NuTDJCeXVhYnd0T1pZdUxZ?=
 =?utf-8?B?Q0poM01rYjhPZ2NHT1BSMlNJZ3Q0eVZ2S2RhYmJoOG5aRkt2VDdidWVESzFI?=
 =?utf-8?B?YzZlc2hPSFVmTFQ2ZWJ5OHJuWURXRURkcjBPaTZva0JmanozeUU2dG9ncHNh?=
 =?utf-8?B?MlRsb3BNWFZRbVVSdVhRdXlJZHdJUE4zZVozbjdIUmNHSUdKa2ZPYzN0cGNz?=
 =?utf-8?B?aHBFKzVaaVFzbUV1Mkp2bVFlb0E5U1pHZ1ZiZncwQ3RnQWxDZnZrUS80OGxY?=
 =?utf-8?B?SHl4TXJsUk1KMW1LVEM0MnFqSFBCd1E0MFJzYzc0RWZSaHNEbkFhS0VPSnF6?=
 =?utf-8?B?VzFleHE2MDJST0NiSlRuZXVJbE5rbW9SQUVUUVZCUzZoZXY2ZHZYejN6UFd6?=
 =?utf-8?B?UWh4Ui9jdkYyVmI2N3Z6WUhUMlhES1RHTU8yek1MOWZVRlpUaUs0eHFmZ3Ew?=
 =?utf-8?B?Mjc0RXVDOUZFNDE1UjFndXdvWWRNdzVycXFCSG9ncHRoZUFPS1FMczI0d1Bh?=
 =?utf-8?B?SmRoTnlSdm5hMFExVHhDOHlkcWMybldRbW1ES2x3K1RSMS8xN0RIYnJJd2R5?=
 =?utf-8?B?RjV5OGgxbkhJdnRKMDZWWnB4TG5MRkNWd01sazNZQTZzREppV1RVM2kvZzFx?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2VwITh9Jf3VBARl6eNPmDXfu1Gxr7kuFFXM1khv560eIJlfqjRcagblPaDkp8H7iVnx4/TKq/e4xtIEcpMYUD9SC40q9ULpUQ+8Nn8uUAnvR3ON2CHQSEgnWYaw35jMWdGJor9J8vjxILhbuhRallPBg4MJD1m1rn66GFi7B2Nja6+in6q1qerZjwNBOkLG0raf5+7F5H7slLjKuoN1mCyrDwTnR0cnMiyhmh4nr3smczNh7XRv3ipqrxaVMs5geg8VGU9OGUEtNQGSvAEUJ7Eukwy4PFfMu43FfGZT6v7wNCvh5BF0Cw7c8nemw6L0m0AreL41Q9wKX0xLb2vZkSTeuUETkJaNLpnGPwGNjTAbi0+mguwPpW+jZ9S1UnpeTxfdhmrwdxAzu+laqECcgo8TPuAYs9otuN63DCN8BkLA9jUSiV2GmCvpp+ir9daibHOlblKGmAEBp2MgowuBN1rQXFxt8K5Qb8oM8ghgjUcp3YHOYkBiZdi1MbvNJxTeL/UQYqAi+8brkGqQ0/itTIJv3ekxJtPMikSPPw1a5tmapHcFgeKihtalOd+6/s/CAphBXAlRqACcVjBlWBH/rFu/Rtvu233pfeeSXRDGlX7g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cae006-e9c5-40a0-38d9-08de120c9663
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 08:17:20.7554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKpqfDGalbi7Rlizj8dWuR6RRsz3zmyAGS8XMXpUSfoHnKPLiPji/biT/X/ukdT/vHe1TOaYpiiXsXCjGxzjSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510230072
X-Proofpoint-GUID: 0k3IN8C5pTzU7v2aC1fMo6hfZN4JBuyD
X-Proofpoint-ORIG-GUID: 0k3IN8C5pTzU7v2aC1fMo6hfZN4JBuyD
X-Authority-Analysis: v=2.4 cv=WaEBqkhX c=1 sm=1 tr=0 ts=68f9e497 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=_CfD_HyPFm8pTZJAa9sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDEwNSBTYWx0ZWRfX4xTjCDjsPEBx
 nEe3tkXbYF/ukGF/wsqkyubqbQGnsBUqzz2Gk9JAawPcJqq0CHMfZV0UDj6BPQjB+rwcIlY1CxJ
 Lp15oVKjW5VxRim2K52Q2BX6XQQLp9HoGKGB8duFahzQgRozxo9fTk/JB8ux7pqayLA1eLuLOwa
 briFhkYPuZ6tHizEvOtXd92g9nBijy1RjJtzYwvur8th83u6aTKTY2JPdtzRf6CNQM5YDn/YdJ8
 03ad6ksFUa9SbqUW4pN0CzSCNwAZOwqQWkpx6ZTFGFKc3VNaBWwolBuVSrea4xVB+rbyXm8egbZ
 jG0aUBEyfgK0dCosjcp+njxVUphvipesoADhDk/Z89/iIZoZQ/A7dd8iNVcwpLA6xxVOnZZjFiU
 6CKzCR+Oh91xCeJWNPdV2C519gVNLjED12TP/bQz1lDMMrEOuuw=

On 20/10/2025 21:57, Andrii Nakryiko wrote:
> On Fri, Oct 17, 2025 at 1:43 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 16/10/2025 19:36, Andrii Nakryiko wrote:
>>> On Wed, Oct 8, 2025 at 10:35 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>> Add BTF_KIND_LOC_PARAM, BTF_KIND_LOC_PROTO and BTF_KIND_LOCSEC
>>>> to help represent location information for functions.
>>>>
>>>> BTF_KIND_LOC_PARAM is used to represent how we retrieve data at a
>>>> location; either via a register, or register+offset or a
>>>> constant value.
>>>>
>>>> BTF_KIND_LOC_PROTO represents location information about a location
>>>> with multiple BTF_KIND_LOC_PARAMs.
>>>>
>>>> And finally BTF_KIND_LOCSEC is a set of location sites, each
>>>> of which has
>>>>
>>>> - a name (function name)
>>>> - a function prototype specifying which types are associated
>>>>   with parameters
>>>> - a location prototype specifying where to find those parameters
>>>> - an address offset
>>>>
>>>> This can be used to represent
>>>>
>>>> - a fully-inlined function
>>>> - a partially-inlined function where some _LOC_PROTOs represent
>>>>   inlined sites as above and others have normal _FUNC representations
>>>> - a function with optimized parameters; again the FUNC_PROTO
>>>>   represents the original function, with LOC info telling us
>>>>   where to obtain each parameter (or 0 if the parameter is
>>>>   unobtainable)
>>>>
>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>> ---
>>>>  include/linux/btf.h            |  29 +++++-
>>>>  include/uapi/linux/btf.h       |  85 ++++++++++++++++-
>>>>  kernel/bpf/btf.c               | 168 ++++++++++++++++++++++++++++++++-
>>>>  tools/include/uapi/linux/btf.h |  85 ++++++++++++++++-
>>>>  4 files changed, 359 insertions(+), 8 deletions(-)
>>>>
>>>
>>> [...]
>>>
>>>> @@ -78,6 +80,9 @@ enum {
>>>>         BTF_KIND_DECL_TAG       = 17,   /* Decl Tag */
>>>>         BTF_KIND_TYPE_TAG       = 18,   /* Type Tag */
>>>>         BTF_KIND_ENUM64         = 19,   /* Enumeration up to 64-bit values */
>>>> +       BTF_KIND_LOC_PARAM      = 20,   /* Location parameter information */
>>>> +       BTF_KIND_LOC_PROTO      = 21,   /* Location prototype for site */
>>>> +       BTF_KIND_LOCSEC         = 22,   /* Location section */
>>>>
>>>>         NR_BTF_KINDS,
>>>>         BTF_KIND_MAX            = NR_BTF_KINDS - 1,
>>>> @@ -198,4 +203,78 @@ struct btf_enum64 {
>>>>         __u32   val_hi32;
>>>>  };
>>>>
>>>> +/* BTF_KIND_LOC_PARAM consists a btf_type specifying a vlen of 0, name_off is 0
>>>
>>> what if we make LOC_PARAM variable-length (i.e., use vlen). We can
>>> always have a fixed 4 bytes value that will contain an arg size, maybe
>>> some flags, and an enum representing what kind of location spec it is
>>> (constant, register, reg-deref, reg+off, reg+off-deref, etc). And then
>>> depending on that enum we'll know how to interpret those vlen * 4
>>> bytes. This will give us extensibility to support more complicated
>>> expressions, when we will be ready to tackle them. Still nicely
>>> dedupable, though. WDYT?
>>>
>>
>> It's a great idea; extensibility is really important here as I hope we
>> can learn to cover some of the additional location cases we don't
>> currently. Also we can retire the whole "continue" flag thing for cases
>> like multi-register representations of structs; we can instead have a
>> vlen 2 representation with registers in each slot. What's also nice
>> about that is that it lines up the LOC_PROTO and FUNC_PROTO indices for
>> parameters so the same index in LOC_PROTO has its type in FUNC_PROTO.
>>
>> In terms of specifics, I think removing the arg size from the type/size
>> btf_type field is a good thing as you suggest; having to reinterpret
>> negative values there is messy. So what about
>>
>> /* BTF_KIND_LOC_PARAM consists a btf_type specifying a vlen of 0,
>> name_off and type/size are 0.
>>  * It is followed by a singular "struct btf_loc_param" and a
>> vlen-specified set of "struct btf_loc_param_data".
>>  */
>>
>> enum {
> 
> nit: name this enum, so we can refer to it from comments
> 
>>         BTF_LOC_PARAM_REG_DATA,
>>         BTF_LOC_PARAM_CONST_DATA,
>> };
>>
>> struct btf_loc_param {
>>         __u8 size;      /* signed size; negative values represent signed
>>                          * values of the specified size, for example -8
>>                          * is an 8-byte signed value.
>>                          */
>>         __u8 data;      /* interpret struct btf_loc_param_data */
> 
> e.g., this will mention that this is enum btf_loc_param_kind from the above
> 
>>         __u16 flags;
>> };
>>
>> struct btf_loc_param_data {
>>         union {
>>                 struct {
>>                         __u16   reg;            /* register number */
>>                         __u16   flags;          /* register dereference */
>>                         __s32   offset;         /* offset from
>> register-stored address */
>>                 };
>>                 struct {
>>                         __u32 val_lo32;         /* lo 32 bits of 64-bit
>> value */
>>                         __u32 val_hi32;         /* hi 32 bits of 64-bit
>> value */
>>                 };
>>         };
>> };
> 
> I'd actually specify that each vlen element is 4 byte long (that's
> minimal reasonable size we can use to keep everything aligned well),
> and then just specify how to interpret those values depending on that
> loc_param_kind. I.e., for register we can use vlen=1, and say that
> those 4 bytes define register number (or whatever we will use to
> identify the register). But for reg+offset we have vlen=2, where first
> is register as before, second is offset value. And so on.
> 
>>
>> I realize we have flags in two places (loc_param and loc_param_data for
>> registers); just in case we needed some sort of mix of register value
>> and register dereference I think that makes sense; haven't seen that in
>> practice yet though. Let me know if the above is what you have in mind.
> 
> see above, I think having spec for each kind of param location and
> using minimal amount of data will give us this future-proof approach.
> We don't even have to define flags until we have them, just specify
> that all unused bits/bytes should be zero, until used in the future.
>

Sounds good on the enum+vlen specification. I've managed to cover all
but ~2100 locations in the kernel DWARF with the existing scheme, and
all those would work well for this approach too. I did a bit of
investigation and the remainder that aren't covered have between 2 and
20 location ops/values associated with them. A few are of the uncovered
cases are of the form (register_value & const_mask), ~register_value,
that sort of thing. I think we could cover some of the easier ones like
that with this scheme too, e.g. have a enum btf_loc_param_kind of
REG__WITH_CONST_OP or similar which has vlen 4 (reg#, op, 64 bits for
const). I think anything more complex than that we probably don't want
to worry about.

>>
>>
>>>> + * and is followed by a singular "struct btf_loc_param". type/size specifies
>>>> + * the size of the associated location value.  The size value should be
>>>> + * cast to a __s32 as negative sizes can be specified; -8 to indicate a signed
>>>> + * 8 byte value for example.
>>>> + *
>>>> + * If kind_flag is 1 the btf_loc is a constant value, otherwise it represents
>>>> + * a register, possibly dereferencing it with the specified offset.
>>>> + *
>>>> + * "struct btf_type" is followed by a "struct btf_loc_param" which consists
>>>> + * of either the 64-bit value or the register number, offset etc.
>>>> + * Interpretation depends on whether the kind_flag is set as described above.
>>>> + */
>>>> +
>>>> +/* BTF_KIND_LOC_PARAM specifies a signed size; negative values represent signed
>>>> + * values of the specific size, for example -8 is an 8-byte signed value.
>>>> + */
>>>> +#define BTF_TYPE_LOC_PARAM_SIZE(t)     ((__s32)((t)->size))
>>>> +
>>>> +/* location param specified by reg + offset is a dereference */
>>>> +#define BTF_LOC_FLAG_REG_DEREF         0x1
>>>> +/* next location param is needed to specify parameter location also; for example
>>>> + * when two registers are used to store a 16-byte struct by value.
>>>> + */
>>>> +#define BTF_LOC_FLAG_CONTINUE          0x2
>>>> +
>>>> +struct btf_loc_param {
>>>> +       union {
>>>> +               struct {
>>>> +                       __u16   reg;            /* register number */
>>>> +                       __u16   flags;          /* register dereference */
>>>> +                       __s32   offset;         /* offset from register-stored address */
>>>> +               };
>>>> +               struct {
>>>> +                       __u32 val_lo32;         /* lo 32 bits of 64-bit value */
>>>> +                       __u32 val_hi32;         /* hi 32 bits of 64-bit value */
>>>> +               };
>>>> +       };
>>>> +};
>>>> +
>>>> +/* BTF_KIND_LOC_PROTO specifies location prototypes; i.e. how locations relate
>>>> + * to parameters; a struct btf_type of BTF_KIND_LOC_PROTO is followed by a
>>>> + * a vlen-specified number of __u32 which specify the associated
>>>> + * BTF_KIND_LOC_PARAM for each function parameter associated with the
>>>> + * location.  The type should either be 0 (no location info) or point at
>>>> + * a BTF_KIND_LOC_PARAM.  Multiple BTF_KIND_LOC_PARAMs can be used to
>>>> + * represent a single function parameter; in such a case each should specify
>>>> + * BTF_LOC_FLAG_CONTINUE.
>>>> + *
>>>> + * The type field in the associated "struct btf_type" should point at an
>>>> + * associated BTF_KIND_FUNC_PROTO.
>>>> + */
>>>> +
>>>> +/* BTF_KIND_LOCSEC consists of vlen-specified number of "struct btf_loc"
>>>> + * containing location site-specific information;
>>>> + *
>>>> + * - name associated with the location (name_off)
>>>> + * - function prototype type id (func_proto)
>>>> + * - location prototype type id (loc_proto)
>>>> + * - address offset (offset)
>>>> + */
>>>> +
>>>> +struct btf_loc {
>>>> +       __u32 name_off;
>>>> +       __u32 func_proto;
>>>> +       __u32 loc_proto;
>>>> +       __u32 offset;
>>>> +};
>>>
>>> What is that offset relative to? Offset within the function in which
>>> we were inlined? Do we know what that function is? I might have missed
>>> how we represent that.
>>
>> The offset is relative to kernel base address (at compile-time the
>> address of .text, at runtime the address of _start). The reasoning is we
>> have to deal with kASLR which means any compile-time absolute address
>> will likely change when the kernel is loaded. So we cannot deal in raw
>> addresses, and to fixup the addresses we then gather kernel/module base
>> address at runtime to compute the actual location of the inline site.
>> See get_base_addr() in tools/lib/bpf/loc.c in patch 14 for an example of
>> how this is done.
> 
> this makes sense, but this should be documented, IMO
> 

Definitely. Will do next time.

>>
>> Given this, it might make sense to have a convention where the LOCSEC
>> specifies the section name also, something like
>>
>> "inline.text"
>>
>> What do you think?
> 
> hm... I'd specify offsets relative to the KASLR base, uniformly.
> Section name is a somewhat superficial detail in terms of tracing
> kernel functions, I don't know if it's that important to group
> functions by ELF section. (unless I'm missing where this would be
> important for correctness?)
>

There are cases where the code lives in a different section from .text
but I think the main case I came across here was stuff like .init
sections in modules that don't hang around after module initialization,
so there's probably no need to handle them specially.

>>
>>>
>>>> +
>>>> +/* helps libbpf know that location declarations are present; libbpf
>>>> + * can then work around absence if this value is not set.
>>>> + */
>>>> +#define BTF_KIND_LOC_UAPI_DEFINED 1
>>>> +
>>>
>>> you don't mention that in the commit, I'll have to figure this out
>>> from subsequent patches, but it would be nice to give an overview of
>>> the purpose of this in this patch
>>>
>>
>> This is a bit ugly, but is intended to help deal with the situation -
>> which happens a lot with distros where we might want to build libbpf
>> without latest UAPI headers (some distros may not get new UAPI headers
>> for a while). The libbpf patches check if the above is defined, and if
>> not supply their own location-related definitions. If in turn libbpf
>> needs to define them, it defines BTF_KIND_LOC_LIBBPF_DEFINED. Finally
>> pahole - which needs to compile both with a checkpointed libbpf commit
>> and a libbpf that may be older and not have location definitions -
>> checks for either, and if not present does a similar set of declarations
>> to ensure compilation still succeeds. We use weak declarations of libbpf
>> location-related functions locally to check if they are available at
>> runtime; this dynamically determines if the inline feature is available.
>>
>> Not pretty, but it will help avioid some of the issues we had with BTF
>> enum64 and compilation.
> 
> um... all this is completely unnecessary because libbpf is supplying
> its own freshest UAPI headers it needs in Github mirror under
> include/uapi/linux subdir. Distros should use those UAPI headers to
> build libbpf from source.
> 
> So the above BTF_KIND_LOC_UAPI_DEFINED hack is not necessary.
> 

Ok sounds good, but we do still have a problem for pahole; it can be
built against an external shared library (i.e. non-embedded) libbpf. It
might make more sense for pahole to include uapi headers from the synced
commit in case it is using non-embedded libbpf (in the non-embedded
libbpf case we don't even pull the libbpf git submodule so might need a
local copy).

Thanks!

Alan

