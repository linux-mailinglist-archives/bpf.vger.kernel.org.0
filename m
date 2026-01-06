Return-Path: <bpf+bounces-77960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6B3CF89EB
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 14:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D461C30136CC
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 13:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E944346FB8;
	Tue,  6 Jan 2026 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kSsEb4ol";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y0KrR1ZC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338EB1F0E29;
	Tue,  6 Jan 2026 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767707745; cv=fail; b=Yh8U0CABp/m8aWGzICKlBbXEmjIjWwPBJZJgw7SHn7qmG4gyaKFPkMmv45ZdtqXq7678rrTM5FKResV+KvdVLvi3nU1eHgRn4FrQ7VWqKp1lfN9kC12Bi8hhObxLp0lpyN2qcS1l1iK3kBPuh+JL8F5kMVsjMIeUuco1Zqbebvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767707745; c=relaxed/simple;
	bh=qIn/vpMSJFt66/a5is3TH68sS0yxaE2VJ5w8edynFx0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d9e/N/FtG5zzC+AmuR7GmEpBqGx3rdLPaE4FgX/Y2kGzjd5LNDMIOzTfL7IxD+w8Cn13rlJimn/CV7Q00Dm8Axgd7R2Rp7rkytORZMm0J+cY+EoyGehciJaFOhYSJCS6Mssvkkvr0xB6JPBuyovWx6ojApIV2H0ygZO36bkdwRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kSsEb4ol; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y0KrR1ZC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606DJRJ73612391;
	Tue, 6 Jan 2026 13:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Y4i0ijr9Tx0cHdbpdYKSO+H04+Vit50nyS2aITNAOeE=; b=
	kSsEb4olM9BeqKnuGGRCZoGhW+Ul8p3nPwTpj0NRGbLnspBM0qhVAFJlHtv+ezNi
	CmU+iD0webQvbSKdTF7qCmSf3Df7uMDVzRhdFK3ix2aYmSM6Vq7Xk2ng/pSnjjup
	/VzcQzYN17oYHRSJZZLy/fAAMGnGrHeYKKoLXev9QFMxwyYPOEo8y3+Y5ATZ7DbH
	liM58y0jiwpVJGooNF0gBgwa8INkyAcXRS7llJYuNIW7Ct4zgu7vgO8lpnjVN4G5
	eJQo2i667RYTwekqojNeWd783sFAJjixPlU9cUQMD/Nh/4hsfkc8AUXV5acX7AaP
	eIIOnnf83FDEwRmQ3waTrg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bh35xg1gp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 13:55:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 606CAOsH020359;
	Tue, 6 Jan 2026 13:55:31 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjjmjby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 13:55:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XV9iRdcXJoRBXb/MOly553nQYHT/S0xRRr90WWVAxemGhFlBD02gz4IVNOmt4O7tIGKDOmHgCT6R9TXu9W6WZm6tmV5LqEhdWLVqE83RM3826pyXEkMFUhqEYQFJZyI/JdEtClb+iWDt0VZ9AXwNgvSw71/JXNkiVGR1lgGbxFrZEbVShgVKNp/NBtj9VHBJYmt/Vlv+xstmTf2OlWt5rfowyEc0BJBkF7zEXaph0oMfFhb7RW6ab6+hZ2mBEaMGoVnURr1QsFkVVS5W46D7/fyeRqGq7hPr1pqfknZlP6sMV0IoohyHldMD+klZk1bUhcoEYYb6yFFuK52hiEswRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4i0ijr9Tx0cHdbpdYKSO+H04+Vit50nyS2aITNAOeE=;
 b=ep1qvqNV8l3AcL0ckyLIh4pqWvDfgu3zzh07h06CtvczQs3fYXwei1RZV4xfH9rUBPBIpRgfhpaXrHn1WMQY1S5XbT8G3+iEKklVsfyb5PirXI1jOBVuLBMsXFMKtNJj/eMMHfgrXQuHslzU4+p6xca9yN/CzqtaRGTJb/1+rwbisBa5+UkppGSlygXxYYx9RNExn7NAupFjaWaMduYB5GlNtZzQBLynn61uWGCLqswhYDHsbSA5eBOP5J/PTccs91qXXVzgNecQzpQqRlUoQE6SkDVr835A0W0l7MtTq4ehbc0tr3euwZ6+l5esacFuVO3xeCcNAuadz6fyKm+wAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4i0ijr9Tx0cHdbpdYKSO+H04+Vit50nyS2aITNAOeE=;
 b=Y0KrR1ZCulBvfwzfgxOGZKrsv07+A1yYWKwkemCN++cSjcTxy3+/eW/MVnRsE3xYOOaO6EvPZYlTEqz85SJR3izWS5bkvahYtdAB4xNfP7zupNdyLCrEYCjNL8/WzA0Pqfk1t+cRg27KdrIheSAOVi3DoSBKjDh+GKJXfRGtYjA=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DS0PR10MB7019.namprd10.prod.outlook.com (2603:10b6:8:14c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4; Tue, 6 Jan 2026 13:55:20 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 13:55:20 +0000
Message-ID: <69e4d6a1-3726-4372-b457-ca7847988fc8@oracle.com>
Date: Tue, 6 Jan 2026 13:55:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v2] dwarf_loader: Handle DW_AT_location attrs
 containing DW_OP_plus_uconst
To: Yonghong Song <yonghong.song@linux.dev>, Yao Zi <me@ziyao.cc>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org, q66 <me@q66.moe>
References: <20251213082721.51017-2-me@ziyao.cc>
 <3b3c5b4b-b4a3-402b-8d5d-507edaf4a814@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <3b3c5b4b-b4a3-402b-8d5d-507edaf4a814@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0124.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::14) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DS0PR10MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1fcf56-5267-4a92-6dd6-08de4d2b3af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkZIMzBnNFlMQUxQdWdoZkR6aTdmbitOaW0rM1BsV0Y3RmJUdmhINlUvVUN4?=
 =?utf-8?B?R2tZY2YwcXR2WmVBZlgza2Y4TmRXYXREbWlaSW1saUlXenBSaldzZ0xJL29p?=
 =?utf-8?B?UlZ3WWtsMlpFRmw1WWgwdmNsNU5FbXpHMDZvMlJGTm5Hc1BIWEprakVocG94?=
 =?utf-8?B?dnN0R0o2MFNQWjBvalljaWNGUU1WYXhFL05CdjNJQzdEeWZMVU1sWTNLY0Qr?=
 =?utf-8?B?aEhyaVRyWFJrNjlRaGlrRWkzRHkyOUtVZTJjZkVYVThPWG11ZjNLQmFoeXQ4?=
 =?utf-8?B?QXRJdXowejR4MzBtS24rTStobGVjL3NBVVdOeXRVTjdUemxBSVJ0N2JiOHNH?=
 =?utf-8?B?Q1NlS1AxWG9LSDZmdHdPdzlhb3ZCM1lrdTA2T2R4VEpJcUxMZkxsb3FDdUhi?=
 =?utf-8?B?Ty9MMTNUNnByTFpqVUpjbkloZm5YTVpPbWh4R2loOVlERWp2UE1xanZ5NFMy?=
 =?utf-8?B?UVZlaEFleG5XdWk0Y29ERTYzTXVQUHV3RDg5QWRiMkVFYjY4TXNvbVBMUER6?=
 =?utf-8?B?ZjBKeXd4NkUvRDBFVG5DU3VNVkRzajRCSjVtV0gyZTA3dGVzbUhCL1BVQ0p2?=
 =?utf-8?B?UUF3RVBZQ3kyazQwNWwvZzdXUXAxWlJrckw5VVVXL0FoS2VXM3hTbHp2NHV2?=
 =?utf-8?B?aVdVNzBWdXFWbU1YTm00emlNWVQvSkQ0NTE2T29TWm5LM3d3eHpSeXVUcmdH?=
 =?utf-8?B?OEJqOW5EYnBlK1REY3JxbExTc0dZK3VHY0dEaHFqTy8wWVpybDZxTEtyc1dV?=
 =?utf-8?B?a3NvNjF2RHFUN25IeGJyb0NXYityOFd2bHg1THp5TTh3VlFDLzlyZmU2LzBp?=
 =?utf-8?B?WHdPKzlRNmhRT3N1aE05WVZ6cW9OQzNaUkJ4NCtFUDIxQkhBc0N5S2dJUGRG?=
 =?utf-8?B?bDVOYUNFQTNDVGlZbndQbm9Bb0F5dDFrUCszd1BVcFpMRGxXNnhiSFdqV1Nj?=
 =?utf-8?B?RjNXM3NUazNkK1pONWo2VlRNUWI1Mjc0alRmT2Jpa2xUajJaTHZ6bzF0WkdT?=
 =?utf-8?B?SUVESzhCM0F1WHIzNnpYcEIvRXFmcGNxQUNnUndEd2hHczVlZUJZU05ObXY1?=
 =?utf-8?B?Smc0bXRtczV3TFJwYkZjUloxektEUSs5bUUvd1BWd2JkdUNiVUJmdmxEa1pv?=
 =?utf-8?B?c0hJTCtQWDE2ZXZic01BZGZwQkw1V3ViS1BKbzBjMi9kL3F4R0ZqRmdtK0kw?=
 =?utf-8?B?S24zUkJlbWwrMmlrMVRNUS9oTU5hRmwrRDI5ZUkwdHc5eWxXZzVFZWlpcjQ0?=
 =?utf-8?B?cjhyZEZqSVVheUZLNWZ6QmdibnRQYnMxaU9WNnR6VktyQjV4U0pSVG5SZlQ4?=
 =?utf-8?B?bnBBYlRLYXlnMjZoUTdmRlRydUROWTNGYU8vakZObDd6RjdsR2xrZnNIczc1?=
 =?utf-8?B?emxvR2Vmd0lNK3pHaUZwT2hSTElrUDF2K0ZiWjc3RDNvajdjcmd0RkdDdkNl?=
 =?utf-8?B?dnQ2Ui96OG1iS3F5QThoN1loRm5XMklFWWVtOHNlazNsSG5NV1VON2lBenF3?=
 =?utf-8?B?clhvZXlXc0trZjFDcno2aVJXbmxCT1l2YmpZRk43c2pJZnBLMEJpc0RsbXZs?=
 =?utf-8?B?cW1STkxpNWloZG1HR2pxbmlZYnZZOUVsb05jTmpSNndaOTlzSy84d3ovOEpa?=
 =?utf-8?B?RWlKRmVpY3RVbVJzTEViclRVOUU0Vi82YTN2WG9UU0NjN3VDbURHTlZDbUk4?=
 =?utf-8?B?Q3hJekZRa0xpYzhBSU5Od2JicFhOVGJCUXNtY011WDk5QmN3ZGZ2V1NPYUZi?=
 =?utf-8?B?MWxxVmZnck1lQ0UzejB0S1hiQ2w1SHFtM3RHY0c4VzJVZWg2QmUrR2djNjRm?=
 =?utf-8?B?aTFCa0xJWXlicGdtd244dzFiTUV4NWJIYzd1WENUdTI2OThkb2FiaVJYQkZp?=
 =?utf-8?B?UXo1NmloM3JaWUdHR0N3RWM2aGhVKzNiWVZPQTc4L0t2L0E4SnpMa2xCQ2VO?=
 =?utf-8?B?N3MrbCtuKzFpaVc4MnlQdHIzTCt1ODhnd0wzUGRiMUd5M2VrRzE1U3B1SFpz?=
 =?utf-8?B?NytnZjlFakVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkRzV1JWU25GcmJQTmhoUVRZZ0hRQ0N3dzgyaHUyOEtUeWhwdnJFNEUzb1lN?=
 =?utf-8?B?Wm9Nc1Blc2RnZ1RNZ3V1elI2YUZsUDgzWHIwR2l6dG9PTTVCalZXeFc5dkQv?=
 =?utf-8?B?M1duSElNUXkraHFjUEFjcit3YnJESCswVUN2L2p6c0VjZ1lmS3NwSFdIMmpY?=
 =?utf-8?B?aUxQUzBaTS9FUFBQZUhiZFRQSlphRzdnT2pSU2tkbE93MXRjNW1rNm93OHJF?=
 =?utf-8?B?a3JQbnNheDU4eDVSN0ZmK3BEeUN5ZHhXNXpmbEd4ZEY3SGNtOTlOS3VyNlho?=
 =?utf-8?B?T1JFZGw5OVFyU1oyeStYZ2d0elRQU1lBcXVqQmhMSWJrWHdrSFBaNEpObTV2?=
 =?utf-8?B?TDkrY0JYWGFTRzl3V3k5a2oyckhwQUVsZVZhVUdNUkRVSjYwZHFaMVpIdmhJ?=
 =?utf-8?B?eTd5dDhwMitaYVVEZm1ESjhPN1JCbnRRUEtNSmNKVTd2Ri92K3lNY1hiMHlC?=
 =?utf-8?B?b3FhQVlSRFc2a0tRQ2NGemtZUk9RVjBVVzI2eUVkbkM2d2ZXeTJ3V1dPUThB?=
 =?utf-8?B?NDJGdlJwU0x5bHdocmgvNnk0NVRUZVdVZGVGSWhJalNnMUZHM1BlSzFLTkhR?=
 =?utf-8?B?M0dpQVZJM3RodjBHMThVRmNsdCswZUJlZEI0WWo4c1gvQURZaWphTnZ5YkNk?=
 =?utf-8?B?MDNTSGxUY003aTRrZHlNelBsNEdSY3BiOFdha0NjMERWVXRTbERJQStxbURE?=
 =?utf-8?B?M3JSMXhFUGJEd0dOSTdrN0NBRTdJeWFrT1JCai9RbEVXOW8wOEw1dkpURlVT?=
 =?utf-8?B?Qktaa3YwdGRheVJxNXZnelgyV2Y5UXNQWjFDT1MxR2M2eitlUm44YXBEaURt?=
 =?utf-8?B?K0IyNGd3Q21TU0QrRWp5S3V5TkNBWWxkek5ZVEFPVnBVVzQ0MkozNmFzejNn?=
 =?utf-8?B?b3VnRjlXemtyTW5iODlxTW1nNzVtWHBIek5FaDRZM01UWmdURDE4VmdlbXVY?=
 =?utf-8?B?OTFjQTFqS0hCL1VUSUxWWDMvd21jQlVlTnRUd3dBckRTTzdRNnM5Qis1U3Nm?=
 =?utf-8?B?L3VKYVArQzNENkk5NVRweER2a25tL1lBL2VvWkVINHduZHhSNmpuOExkeG5C?=
 =?utf-8?B?eVRNWENBOGQveGNOcUUrWGd1VWdQT0E4TFhNa0tSUHFEbkFMWGFXWmNTdGxy?=
 =?utf-8?B?VzhvUzdiYzljSldYYkszMmtpN1UxdytRTW04alFpbWxNU050am9sNkNaeENU?=
 =?utf-8?B?QTdPRURBSlNuYTNXYVpnbzNVUnM5cDk0eDN0ZE13Y2s4ZXVoTkpnVUtROU96?=
 =?utf-8?B?VlJJbGpiS01GWXlIalBXWGFwYlh6blF1Z0w3a2RvMmZTSDRVVkFPTWcrSzVJ?=
 =?utf-8?B?ZDArMnVBcGtFeGpQTUVJNlpkVlh4MnZOUUprcWsyZjR4dFhMMjd4UlcyNlEy?=
 =?utf-8?B?MG1XcGErNFhzVVpaRGFJSkw5UkxqbURYR2hkR2xnZzY2UUxJRE1zY2hwWmZZ?=
 =?utf-8?B?Njk3YlhUdHRsRVc0ZWJJcy9CYjBCQ2V5ZVc1eXZIcXRHYkVwQXFSSHhKdW05?=
 =?utf-8?B?Q285KzZGN2hyUTIrbWdHekQ2cU9pZmpkUVhDQmI0eDBXb1dmVWlNeitXcEZY?=
 =?utf-8?B?Q0pwbmRDY3ZCNUdwNGlPa2hkSnZRdXl6ZjJLQ3ZrelJxWHc2RVhDVnFCRURh?=
 =?utf-8?B?M0o1Sk5kanBraFk1TGl0L01sSmtQaXNwQ2diVzRSaWhFNXlUZXR6UEhmTkxw?=
 =?utf-8?B?OXJ2L1duUTlxL3IzQ3JpUFI5cktXUmRqRUQ2L0JVajFnK3VCc2lheHAwdmJI?=
 =?utf-8?B?NHI5UXRDQmtxTldubnpUcGtUaVFDSzdlOHFaM05vUlkzOHF5VDFIU0ozeGx5?=
 =?utf-8?B?eFFwUEl5QzluZlRWcEJZVVNNa21VbTZSQ3dqc2xhbG1EWWVUNzNBUWpqVmF4?=
 =?utf-8?B?L0EvTHlvRFRFUWl4NGFIWG1mQVdScERMNk05czM0dFVEQlUvM3czS0ZNZEJ1?=
 =?utf-8?B?bFRLTDBJZkM2dm5ERGJyUGgrSnJRZit6eDFEaUZjbW9TQnZLRzZkLy9ob3pr?=
 =?utf-8?B?VkVYMU1IMXl1MWlJSjVSTkpnc1JhanpKb2ZXYUh1ZElKRlJMUW0yM2hNbm5G?=
 =?utf-8?B?NHg4MUw4ZkJGWTBETm9jdDh4ejdZM1ZkalRZeUlxSUhwZk95YngwT2p5QVhM?=
 =?utf-8?B?OUpGbnoxZ3JLVVVoWll3MmlpYkxwclBoRUNRb2dHNmtaY3k2TWllcVRwVTFE?=
 =?utf-8?B?YStyZlUzM1Zhd3YxOWdYYkE4WmtlTHUrZGI1SUZYeS9FTytFbTBjNGJUQWpF?=
 =?utf-8?B?SmtaTUFUWFV1N3BJU1dNVTlvRys4dk5WZUtLVE4vOXJNTWcxNStzOXU5eFBo?=
 =?utf-8?B?Z1lUcFh1VkxORWNFR1RQRDJSWTkwWkNaamEvVVhtQy9MQ3B3Q2Mzdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	keKGzObiyEqZ3ZP6SQCpqfWWNTlQR/GI1ZPfacWP8i/rvaSI0JS6jrE4jpHicXGs/3S93KByvz/VTztLMeKxIVQhp9cVuHuOKReYu6zU8cGKzGPowPEsPMs/5HiaxPot0G8WYjUE1pRCF2Y29vqczNi66C2FHdgFDgbDwbiwn86tqGZVYHuaUksKp8oOd18VGLWGp+8SyPpnci6GU/gJSb9YDfa4MfKlkDVSHlXHttl83jHpRKTJpeyjnsrfuQaEH9WP+744LlwyqJEUF+4ac4RUGvRpRY6MpALoE6vB4TnE8HO6a26OYxdI4MiI87f4ifNSv4exvrJXYiA7UwgQW/kGvseeiuo6MGuY4FkDem1QIkkGqvhRwoYz3Oc0BZPZKE6gfOW9/hQpUZJosU17w9Uxu23X4UdaMOfi2v9UhkMWXHmqZTA3GOBQprjClkqS9TVqqUGsuet+0omPcwZUc85eoFMFaEBKWGNY8ICBCxb7SM42CKifArkAB4VS0lRfA+lbC0nm9IrAmWZlnpYdgG1gFlVAvOb3+7WLLcPcvoOO9RuqZhJ1lexHAPM7qRVLTzw/ylAaih3WYbCfeaThdAVYk/9g2O/F+NNcFkh8ZgU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1fcf56-5267-4a92-6dd6-08de4d2b3af5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 13:55:20.4097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXujXDaqSINLlxWIVtbW1JlO1XgMR+CoQSXJ3VP05nFjNhefMphSbm79kqrpib7/A4EYLlFld6eOGZUZ1Nejgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7019
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601060120
X-Proofpoint-ORIG-GUID: 0XQgTcha4sUrWik1n9FKNpBobRpMW_FW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEyMSBTYWx0ZWRfX3yaO4cjbkTPO
 F7q6CTq2PiI7C0zjqEGJE1Aaz42yl8LgSjjlDL/L6fCcPb4CV4bXc2bFhz1GnqTYaZoAujT7Rde
 3kySZT6JcFghlMV5p+Prvysg0baWC+uzO5NJ8Q/hUdiMbbOg8Eu4lWJScULlcllb3wMrlF8E15y
 oVapv79Gd5Llj5ppz9nVXcWN5U05xdwLG6uMU/f4zmccEybajqJM0JLnklJZphi295xDoVDnouJ
 fbs906OGb9gP80fVP8RQgZu4tPeNYeswLiTjJaC0GGaWbVwnbszyGFB3jYliLHyv2W2tgLe255c
 3SEVZLfupYWBI/Oy4x0lKIEjljpLFQGwsEODCeTCH0wMq3fn+szsnO1i4K6WOsP8mVjJmtbhiby
 ar+M+KoTSlkJ4u1DbpL8oN+bA3bWKbteB+1EVx1+eHMQlVQ60siCxqx3X1Z9IGBbnoumJBiOr4v
 PpXuYWQzA8PCCQYX4CcQz1vt5W0DYuhtEvuoZuZI=
X-Authority-Analysis: v=2.4 cv=A+Vh/qWG c=1 sm=1 tr=0 ts=695d1454 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=Pww0aMKsBU7VkPqB4k0A:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12109
X-Proofpoint-GUID: 0XQgTcha4sUrWik1n9FKNpBobRpMW_FW

On 17/12/2025 04:14, Yonghong Song wrote:
> 
> 
> On 12/13/25 12:27 AM, Yao Zi wrote:
>> LLVM has a GlobalMerge pass, which tries to group multiple global
>> variables together and address them with through a single register with
>> offsets coded in instructions, to reduce register pressure. Address of
>> symbols transformed by the pass may be represented by an DWARF
>> expression consisting of DW_OP_addrx and DW_OP_plus_uconst, which
>> naturally matches the way a merged variable is addressed.
>>
>> However, our dwarf_loader currently ignores anything but the first in
>> the location expression, including the DW_OP_plus_uconst atom, which
>> appears the second operation in this case. This could result in broken
>> BTF information produced by pahole, where several merged symbols are
>> given the same offset, even though in fact they don't overlap.
>>
>> LLVM has enabled MergeGlobal pass for PowerPC[1] and RISC-V[2] by
>> default since version 20, let's handle DW_OP_plus_uconst operations in
>> DW_AT_location attributes correctly to ensure correct BTF could be
>> produced for LLVM-built kernels.
>>
>> Fixes: a6ea527aab91 ("variable: Add ->addr member")
>> Reported-by: q66 <me@q66.moe>
>> Closes: https://github.com/ClangBuiltLinux/linux/issues/2089
>> Link: https://github.com/llvm/llvm-project/commit/aaa37d6755e6 # [1]
>> Link: https://github.com/llvm/llvm-project/commit/9d02264b03ea # [2]
>> Signed-off-by: Yao Zi <me@ziyao.cc>
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> 

Tested using dwarves CI [1]; change looks good, applied. Thanks!

Alan

[1] https://github.com/alan-maguire/dwarves/actions/runs/20747914338

