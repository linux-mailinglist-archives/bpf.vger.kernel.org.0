Return-Path: <bpf+bounces-47753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F969FFE0C
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 19:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 616357A1899
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 18:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF1318EFCC;
	Thu,  2 Jan 2025 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WZDP9SZb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CGNWKaDH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23370183CD1
	for <bpf@vger.kernel.org>; Thu,  2 Jan 2025 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735842287; cv=fail; b=pcqDQc2FENrBXuqOtuGuG45rCehY9cyGo2W6NJrNyHu6/v0udMurejXtCHTPkjJCOmQhxof6OtDzG3pN6hPY2SrqJOQgdHMZpTAODBKScVVFrSwbXXMAKnflBZsbjUv1QcbgBaldWb0SuX7SGp62gzYt/U6YoEfvA3syooIjx1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735842287; c=relaxed/simple;
	bh=PNADOg1WfG22i5DpDCdAwXec5emP/us+8Xa0hQDS/lc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=B0kEQ0q1AdSIRr/KzzPgfefoKaL5pmNX6CjhcRrL1Zhj9N7YlPfkgsnfj4R0xe0LaqZbb/3v2IhGUAHP3Fi+4jNwKdXqmPaaHg9QBo+yZDwJPBft0tDM8s/k7Qcej4R/Qoep1PyeZESG6fofwgai7MAZV8UrSeXqNw+wilHyxpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WZDP9SZb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CGNWKaDH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502HXos8023837;
	Thu, 2 Jan 2025 18:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=pFrr9aa7nbHg/IkxhummD+r5Fi1fFFDVLRV3EGZdiM0=; b=
	WZDP9SZbAh3bZTWR1kUOLX4j25PNW5arUotAgpNm4y7OB3WEDt1esX1n1bNL02nX
	FDSi+o9XL25TOim6nP+Scg52KPGmuRqeaKaDoXzUi1hRPunorWqnKVCYy0Dlg1Ck
	Vl18EASkjtho5pDR/cH9IyvBKegK1X77YzHiHcf00dYsypSV55jEQXy4TX0EVr1Z
	R3PKfq6VdM3wtHXPfPjOTzQYOg6fsb7NbGvT1B5OxuydMP+ghkAUnx/CEMk8kUgr
	sQUc00HuWjk5YdAdWpZZM1RP/2Ap/rTy1Sl2AwLDgyaT1Gusc542ZslFYNjKTtr5
	kMjoNOXkOTiA7G53HEcLmA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t9checxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 18:24:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502HK27R009133;
	Thu, 2 Jan 2025 18:24:27 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s945s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 18:24:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hy/MmhEqWyeyJA3pfenAkE8vp80JRGK5KYO4+77otSZ+8dwghJJoVArBi390gEEKdlJBH6PPMGIUUkftyum44pjHHMy4avrXWOlvEzOC7LtUSmKD4MDG4B5v83VoNfF7VDd/kb7ujoGKl61nXohcRVPWsOzhmVnjuhSu7YXbLDTT7vOOvgaOW+ujcRtq5lDH7teuDlGbCFl3KfRxHt0a5KxL+bM+FFwuW0c1mgG6Tu2sjPNqeBzO5ceFSfLWO4fv0ONLNq6SpNFwaOasdmtFsUI4WThonSb/VxDSXF592EuQu2xuG9vLr/3re4o0Mmjf36eW7MFU3ordRkChCSMPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFrr9aa7nbHg/IkxhummD+r5Fi1fFFDVLRV3EGZdiM0=;
 b=RM8WFdlggLVuL/UU93q4QXUL8hvV6IOGvyX6EY3neMO55vEvHKMN19NiXzOu7ggoybIedIXKNKu/TmzNZR99Iy/zJALem1SkYl8l6QMIHz4MTWo17UpITFpUjd3Y4uuX3R/aWewD/+zCBwLBGMRKZzf2TMsVNXkXeMrrvChPMM0+26R01nlmy9+B4pST4RZnM5foml8aUaMqR8Hq6twRpYmDK76J2zZK1bfDJRVcK3c9adSEoNd2Wn1jl+NNlY+n9VOJq1GzGN3aq4nBFmRLj4B/c0grmd6ZL34tkuvkW0/4qyvvOjghHZWTYZbtt8Z7TkMGzYWG75vJrOGNbQYzvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFrr9aa7nbHg/IkxhummD+r5Fi1fFFDVLRV3EGZdiM0=;
 b=CGNWKaDHSboh/90CE631ToFWz/363oNunbxNokkpqKO8Mx1XgjdHNIx1u5uI1rlUwTEU5+fX5V00k4R5AH6OnpdZEP76/dF77JW3XHDLuWqPlNVZbZeORhrpD55Fj+9Q5HehdFetu5KuPzcz0Dg1C7BWffcRpgcgdK1CUMs+1+U=
Received: from LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6)
 by CY8PR10MB6659.namprd10.prod.outlook.com (2603:10b6:930:53::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 18:24:21 +0000
Received: from LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e]) by LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e%4]) with mapi id 15.20.8293.000; Thu, 2 Jan 2025
 18:24:20 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>,
        Cupertino Miranda
 <cupertino.miranda@oracle.com>,
        David Faust <david.faust@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>,
        Alexei Starovoitov
 <alexei.starovoitov@gmail.com>,
        Manu Bretelle <chantra@meta.com>,
        Eduard
 Zingerman <eddyz87@gmail.com>,
        Mykola Lysenko <mykolal@meta.com>,
        Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: Errors compiling BPF programs from Linux selftests/bpf with GCC
In-Reply-To: <HfONx8uvT8UvgKSa4GGd2dyrUNHSFTv6VHMDSeCw0849N7REwVvl5MGyyvEmVIIQRcQIEf_-fyr6TcLJodeWdczujiEqrUZKJzX3sfhrPwA=@pm.me>
	(Ihor Solodrai's message of "Thu, 02 Jan 2025 17:35:14 +0000")
References: <ZryncitpWOFICUSCu4HLsMIZ7zOuiH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLotteNbQ9I=@pm.me>
	<87jzbdim3j.fsf@oracle.com>
	<HfONx8uvT8UvgKSa4GGd2dyrUNHSFTv6VHMDSeCw0849N7REwVvl5MGyyvEmVIIQRcQIEf_-fyr6TcLJodeWdczujiEqrUZKJzX3sfhrPwA=@pm.me>
Date: Thu, 02 Jan 2025 19:24:17 +0100
Message-ID: <877c7daxbi.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DB7PR03CA0098.eurprd03.prod.outlook.com
 (2603:10a6:10:72::39) To LV8PR10MB7822.namprd10.prod.outlook.com
 (2603:10b6:408:1e8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7822:EE_|CY8PR10MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ebef16-39f4-4178-33c8-08dd2b5aad0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlZqeVBib1ZIcXRXc21DMDR4djZ1UGRxRnJkUFdlMnE2QkhTeVVZYTh2bE4x?=
 =?utf-8?B?YlpwY3pCVGR3S3J1T3Q2RkwweFJvODc2YXljdEZKbnozbTRkWnN1aUEzSThu?=
 =?utf-8?B?U0Vaa0t0YWcvV0dmdFYyNFlLaDFQQkZ0T1hTM3NSTEFYSmFaY1E0TGhaRjBk?=
 =?utf-8?B?VEdERlVrbTZrMzc3dzR6VWZESUYvZjVHdkpINlFEUis2bDNWdENQTFJ0WUF6?=
 =?utf-8?B?ME9mNHpDN3FsVGVSL3IvaW1PSmRTWEdZK2daTnJwdXY4b1NvQ0l0T2hqaGNL?=
 =?utf-8?B?V01wNlRXcjM1S0FYZlcwcWV6cmtMLzBKVFNRaGRnelFUNEdwcmNvOWp1b0F1?=
 =?utf-8?B?T21sT1pKY3dNaVZjU0hSd1dOOVNYKzRMYmRFc2JTNlFvZEZQRHZUWk9WR21X?=
 =?utf-8?B?ZnR6OEdwSVAzemxnYU05STU2S3dMT1pid3FzMW82MEhDTEM4MENNNEl2UzdM?=
 =?utf-8?B?aXhMNFAzckh4bjZpcVlUMEZNZUVSSUh6TGF4b1JKd0JLOGRkc0I4YmRDK1A5?=
 =?utf-8?B?WlZlWkFIOEZIb3orQVJ3Q1Ztc1RpWEdMNnNUMkJOOWVkWU0yVERvMVV5RXhh?=
 =?utf-8?B?bDRtTElPdHNOVWZrakI0VWZ4Mm03bXAwVU5BTlExTWtaR0ZXbHdqQlA4aEt4?=
 =?utf-8?B?ODMxN1BnTmJyTGVWQUF2OUVvSDZPaVFyWFBZb2RLaDZ3Nk9rZHNWUXhHWnFF?=
 =?utf-8?B?RjVhcUdyMU9Wa1E5REliNll0cjNhTS8yWnVhQi9Jc09BMlIvelFaQmhLdFVn?=
 =?utf-8?B?aUMyaTFDcjJnaldSQUo0c0t2dXRqR1hNSUpzWVdlQi82ZG5yd2gvY2JJbFlq?=
 =?utf-8?B?azcvYkgrejVRQmk5b1oyT1J2UGdKcmMreFBlcm4ydCtUbUxncDcxbUJCanNT?=
 =?utf-8?B?L3ZXYlY5bFNLNG0yWnltS1Z0Z1BBdDljZDhuNlQ0dU12bmxZTnN6cTZUVHk2?=
 =?utf-8?B?KzdXR0ozUzEzc3JrQmZWVC9SOWR4SDB1dUEvWnVVbWVsT2lRMnB1NE5TUThv?=
 =?utf-8?B?Ymg5K2k2cXJPMC9yaTF5U1hrNjhmWU4yVUtOMlNWRW9EOUx4RHZSb0lMSXRO?=
 =?utf-8?B?NTRyT0ZPcmY2eWlnMUthWURySUJhdXlRWjMyY2xZaXV6bGNJRGVSdXR3N2ZB?=
 =?utf-8?B?TFJZUXh5VWUvN29KM0NLLzE1bmF3UE84a3ppNmRUMFFDYWZHTmFHeW5USzdk?=
 =?utf-8?B?engrTVFKcS9WSmp1SU93NllXQ2JQZUZXWWxvaWpiN3lqWFBTNW4vT1dlRVow?=
 =?utf-8?B?N25udlhEcjhsMTBoU2RwWXRIaVNuOTZ3SXRROC9MWGg4QTJoeFJYRUwzOVNx?=
 =?utf-8?B?MTBhaVBTM1k0dndEZHNtSUJVUU5CSzA5ejl6YnV3V0p5cUpUcVZ1M2NCV3cw?=
 =?utf-8?B?SWR0OURUUUwzUnh5MXN2b3hkbk1Qc2J4MGxnUGs4TElVWk5vaXpYM1E1cGU0?=
 =?utf-8?B?aWF6ZHpuUys5T0VtNXp5aFkyL0tJY1ZEZWYwRU1hcm1LckVXcU96WkJDRWE4?=
 =?utf-8?B?NXVOd1g0YjRwK1JRUVlaS2dycGZzUkFuM29panMvZlo3aldVVVJEZzJhQmFo?=
 =?utf-8?B?MXZDSjFtaVhLMDFoNVZHMjI1U2dFNGVrYTQ1MDNsMGtKc3Y4WTlCZmFxNW1u?=
 =?utf-8?B?T0xBaTgyT29GZUhsSUVKcDRaVWdlQ1poWjhuTDRtK2s2L1NnRHp6T2lJekdi?=
 =?utf-8?B?N2dpV2VIeEp3b2RiellQZFhDSzZGNjF3VTllNk8rSlJFQTRGUndtOU9yNHgx?=
 =?utf-8?B?b1ZjaEZMSzNqRmpRTmo3WC9qTC9MMjg1UHZUT0hGUUJUWTUwU2xNVTA2UWFY?=
 =?utf-8?B?OGwwSmNUZ3UwamlLd1FXanJ3MWNKWW9GdURGejJhNmZRVkM1YlJnNFpYekY4?=
 =?utf-8?Q?3W4Cp2jwtGYFv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHdmZ2RuSjRqUnd1bzRhWTRvbUpjcWo5enhFT0EranhlamNHOTJlZTBzQlBU?=
 =?utf-8?B?ZVp0Z3QzVmlPM2lBMUwrc2ZDUjdKN0EwRjRydk01czlxVjQwQ2dpWHVMSGdm?=
 =?utf-8?B?d2FFalROUkcxZDlFdTVsV1MrVmErb21hTkFUcU4vWi93NDVBNzdqYTJac1VH?=
 =?utf-8?B?dHo4SmJCWGRZeURMZjkxZEJRYjNSSDMwell1U3ZvV1FHZVdoMHVYVUV2ZDky?=
 =?utf-8?B?bU9WVkJBd0J4WWlESDByYnRESllkTUtScjZwMm4walJXYkg2Ykd6ZUxUZ04w?=
 =?utf-8?B?ZUZOQ2pGQ0t1djB3TWFSUm1UY01CR3JieWtYc0hhR1hoV3F3TGZ1dkVrZDdp?=
 =?utf-8?B?NlJsTTZCeHlLei9MODhtVDFnTnZPYUNRcEdnN0xHQzJDNGNtQ1FPVkZqajJX?=
 =?utf-8?B?UG11QzR1MnQ5YTNmVkVFSDNiUitrNHVFM1gxRnl4djZYMy9OdUdDYmNTYnpn?=
 =?utf-8?B?MU16YlhSU1ZQSlZnNkZ2MHljcVAyWG1pdFpmQVo0ZXBDNDZXTzJPRFFlekc0?=
 =?utf-8?B?dGEvQ2J3RGxKRmNzRDJWdVcrVnQvcUZvT0pBakNrUmlnUFp1QTFBU2tFQWN4?=
 =?utf-8?B?dXpMa3ZNQ0VyRkdsZUFTcldMTEFoaHNyL01IQ0hDbTVVZ0l3TFFZczBFMGYv?=
 =?utf-8?B?dWZnMHkyODZuTmdRd3BpekdpaFNuSi9pMklWQWovdkllNjlTYTkwVytJK1FX?=
 =?utf-8?B?U0RPelNSdGVMVSt1MzdZZEFKN1NjYzJNcUlVeHhicVRIeC80N3N0TUluZ2oy?=
 =?utf-8?B?Zk9SREVSUjNRMFlMRWhXcE9LdmdxV1BJOHBsZW9mZVBsYUZqa1FnM0J6K2xL?=
 =?utf-8?B?SFQyZ1Q4RzdHZ2x2dXNQVDlRd3VpRUorRmg5TWp6N2doSGdUTFpONnFxQis0?=
 =?utf-8?B?bFVudTJ4YWVvMy84ZTBZV3Y5MUNKelJVMkF6aW5KaTZ6SU4zdlNKMXpoSWNF?=
 =?utf-8?B?cXhWTXNCWVpjcGNNUUNTWC9UY2tROXFYVmJ6SnRtb3Y1Vllnc0RwVEhPYUsv?=
 =?utf-8?B?dFZjZWFZNndPSFVKai9LK0xCZ2VIKzhDVUFydFZWbkRWdWQvS2M0VTh0WGti?=
 =?utf-8?B?UU9GVFpLUWFWdlpXOEx2TXRNTnpNZDYwYlI4cjBiUHlhRFI0WnNuSXpPQWMr?=
 =?utf-8?B?NG9SNVgvd21PWE42dTgwQjNzdXVRbW56SXE3TkpZcmlOeC8wNnIwdFVvOUVY?=
 =?utf-8?B?TGdXcnNvU0RYN0RpVlJMVFNVcWRxTkx2OVN0d2dicU5kVGZOcHNMUjh3UE1z?=
 =?utf-8?B?VXZRZU1CblJoVGwzT2U4OXBSM203RFlRcXNxNXlkdXFLcjA2T1NIZG1FeWpD?=
 =?utf-8?B?NG9PbW5nZFJrOWw1N1RsOTVjZUNvMlRnTDBkSTAzdHFtRVdKaDIvelhldTF0?=
 =?utf-8?B?NUwyeitGaDhZcitwcytqd3FYci9uUXluaUx5a1BhbEVuZWlTTCtqOVppbFZM?=
 =?utf-8?B?VXc4K0RaTDVIdy9jb0Nwc3Rma0R3U01IUng5Uk56d1RKYzFTaGo4Rm9rbE1k?=
 =?utf-8?B?VHVOc2hRZWRxd0dCbDdoOWtNVG1WSUVYVmpXdUNiOURkVW9EWFBUSFZPWmJw?=
 =?utf-8?B?c1c4YUdXY1UvRzhNdnNkRExMR3JibkljTTBPTXBFaHZEb003VkNtRWxyUlF4?=
 =?utf-8?B?SCttUGZuRUZFdi9XbTBNWVVULzMzUm9zb1hRcVE3NlVDa1dFM2hyYzc0VWhw?=
 =?utf-8?B?RUJQNEpKWHh5bVFkY3k3L0FwNUdWNFNXWkx5UytpRmE3R1J6RS9JcHdzQllS?=
 =?utf-8?B?UFdVR1J4b0pNeGxuTWx5eHo5VU0ySFpIWkVYU0xLekxGMnd2WlFSWG1kMm9y?=
 =?utf-8?B?YjhyNlhZRTNPVEVERkI1SjdtRnZrQTZHUlNFOUE5UWR0cFdvVVc1WWlrYlFs?=
 =?utf-8?B?RWxqVWdVTmJrRkxsVGl6YlZjWm1NbkFWSVAyN09rM3NxbFZma1JERm05MUtY?=
 =?utf-8?B?dkFVUkFnWUdVYjRscWNDRGhuSmp5em1jWGowek1DVllidGtPU1l5b2JGSVpX?=
 =?utf-8?B?Z3RCODhDL2s2Z3k4bjJZcmFmUnZOOGVUeDFQTWlwVTNXcUhxdUpxeDYzK2t3?=
 =?utf-8?B?eG11TU0rdFBpUkRNeFRIcUJjSGRpVUZqL2drWjZOODhoWlIvOCs2QkU5N2Vh?=
 =?utf-8?B?S0JxWVpFM1BOa2l3N0h1bUI0WjdNVFdIMGhFUGN4aHNBcmRSUVlzODBVR3Nw?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Tj21ZXuH0uyi69gSy4bzz3OPO2zitoQtIaerisvHyON5BhLUBFnfXgrY/488hr5/EaVEdrjDdtKjh+ApvgVp6HwAwyPoE64MJBrFZ4QPx2GtzRVhibs4yazkWULvS+eVYPUwZwACuiC9NBb4DG7zIcb+suF47+f2z2g37q0sdfuhrsi8Gb28DYnHB1hl+DUVj7jMk6Zwk8hx2WKqgf5BqJRFSKjFpT4mExf66giax0OeDM09gaYrPKdpr3UdiCb3+mNUIATb6WZaFizzBNJA5v1iTP/VYyPFIdjYBl5H6KnSb34BpXE6FR8tyE+NlBQ4l9R8IeaA4wJThfOl3jrk/YB3O7R/wszex0yetK4n/QlNRz/yV0mnURh9tNOWXK4J1uKiRpJNuCacnZ5c1h4LAik9Na2fSGTNbslkZ+DF9ov2qkZ7/dq4tssJKUL+qa/CUtED5qusiRXasy64Kpd4/Fx72EswdVmnraQiiIivCJkBlGEvngpsQssEiwIV0cP2+RiFfz9o88AAnxg+ypiCPuhJmaM5o1cplAbHz4xpnCMs+zUYxE2MZ60nZ+tMkhKhxDLwKNmayvXrmHpNRmWC1j26dazsBUFn39eXV04P6F4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ebef16-39f4-4178-33c8-08dd2b5aad0f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:24:20.9244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aelPZd8T7sLhqkIpQ2DRs5cEDtPMbHDEGmDy63lNwxfK7iStF7Ste45kQq8ZMYNSuuODEBU+9PEJLgtR2Wuh45y+0txmrmvCYaOHDGoyns4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6659
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020161
X-Proofpoint-GUID: 0xZtU78Khn60trIp5II0TYCJf49KgmOq
X-Proofpoint-ORIG-GUID: 0xZtU78Khn60trIp5II0TYCJf49KgmOq


> On Thursday, January 2nd, 2025 at 1:47 AM, Jose E. Marchesi <jose.marches=
i@oracle.com> wrote:
>
>> Hi Ihor.
>> Thanks for working on this! :)
>>=20
>> > [...]
>> > Older versions compile the dummy program without errors, however on
>> > attempt to build the selftests there is a different issue: conflicting
>> > int64 definitions (full log at [6]).
>> >=20
>> > In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
>> > from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
>> > from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
>> > from /usr/include/linux/if.h:28,
>> > from /usr/include/linux/icmp.h:23,
>> > from progs/test_cls_redirect_dynptr.c:10:
>> > /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: error:
>> > conflicting types for =E2=80=98int64_t=E2=80=99; have =E2=80=98__int64=
_t=E2=80=99 {aka =E2=80=98long long
>> > int=E2=80=99}
>> > 27 | typedef __int64_t int64_t;
>> > | ^~~~~~~
>> > In file included from progs/test_cls_redirect_dynptr.c:6:
>> > /ci/workspace/bpfgcc.20240922/lib/gcc/bpf-unknown-none/15.0.0/include/=
stdint.h:43:24:
>> > note: previous declaration of =E2=80=98int64_t=E2=80=99 with type =E2=
=80=98int64_t=E2=80=99 {aka =E2=80=98long
>> > int=E2=80=99}
>> > 43 | typedef INT64_TYPE int64_t;
>> > | ^~~~~~~
>>=20
>>=20
>> I think this is what is going on:
>>=20
>> The BPF selftest is indirectly including glibc headers from the host
>> where it is being compiled. In this case your x86_64 ubuntu system.
>>=20
>> Many glibc headers include bits/wordsize.h, which in the case of x86_64
>> is:
>>=20
>> #if defined x86_64 && !defined ILP32
>> # define __WORDSIZE 64
>> #else
>> # define __WORDSIZE 32
>> #define __WORDSIZE32_SIZE_ULONG 0
>> #define __WORDSIZE32_PTRDIFF_LONG 0
>> #endif
>>=20
>> and then in bits/types.h:
>>=20
>> #if __WORDSIZE =3D=3D 64
>> typedef signed long int __int64_t;
>> typedef unsigned long int __uint64_t;
>> #else
>> extension typedef signed long long int __int64_t;
>> extension typedef unsigned long long int __uint64_t;
>> #endif
>>=20
>> i.e. your BPF program ends using __WORDSIZE 32. This eventually leads
>> to int64_t being defined as `signed long long int' in stdint-intn.h, as
>> it would correspond to a x86_64 program running in 32-bit mode.
>>=20
>> GCC BPF, on the other hand, is a "baremetal" compiler and it provides a
>> small set of headers (including stdint.h) that implement standard C99
>> types like int64_t, adjusted to the BPF architecture.
>>=20
>> In this case there is a conflict between the 32-bit x86_64 definition of
>> int64_t and the one of BPF.
>
> Hi Jose, thanks for breaking this down.
>
> I was able to mitigate int64_t declaration conflict by passing
> -nostdinc to gcc.
>
> Currently system-installed headers are being passed via -idirafter in
> a compilation command:
>
>     /ci/workspace/bpfgcc.20241229/bin/bpf-unknown-none-gcc \
>         -g -Wall -Werror -D__TARGET_ARCH_x86 -mlittle-endian \
>         -I/ci/workspace/tools/testing/selftests/bpf/tools/include
>         -I/ci/workspace/tools/testing/selftests/bpf \
>         -I/ci/workspace/tools/include/uapi \
>         -I/ci/workspace/tools/testing/selftests/usr/include \
>         -Wno-compare-distinct-pointer-types \
>         -idirafter /usr/lib/gcc/x86_64-linux-gnu/13/include \
>         -idirafter /usr/local/include \
>         -idirafter /usr/include/x86_64-linux-gnu \
>         -idirafter /usr/include \
>         -DBPF_NO_PRESERVE_ACCESS_INDEX \
>         -Wno-attributes \
>         -O2 -std=3Dgnu17 \                  # -nostdinc here helps
>         -c progs/test_cls_redirect.c \
>         -o /ci/workspace/tools/testing/selftests/bpf/bpf_gcc/test_cls_red=
irect.bpf.o
>
> Passing -nostdinc makes gcc to pick compiler-installed header, if I
> understand correctly.

I think that passing -nostdinc is having the opposite effect: it makes
GCC to not use its own distributed stdint.h, so it finds the host's
stdint.h via idirafter.

With that option GCC BPF behaves like clang BPF, include-wise.

>>=20
>> PS: the other headers installed by GCC BPF are:
>> float.h iso646.h limits.h stdalign.h stdarg.h stdatomic.h stdbool.h
>> stdckdint.h stddef.h stdfix.h stdint.h stdnoreturn.h syslimits.h
>> tgmath.h unwind.h varargs.h
>
> From your comments, it seems that BPF programs *must not* include
> system glibc headers when compiled with GCC. Or is this only true for
> the headers you listed above?
>
> I wonder what is the proper way to build BPF programs with gcc then.
> In the source code the includes are what you'd expect:
>
>     #include <stdbool.h>
>     #include <stddef.h>
>     #include <stdint.h>       // conflict is between this
>     #include <string.h>
>
>     #include <linux/bpf.h>
>     #include <linux/icmp.h>   // and this
>     #include <linux/icmpv6.h>
>     ...
>
> Any suggestions?

IMO the BPP selftest (and BPF programs in general) must not include host
glibc headers at all, regardless of what BPF compiler is used.  The
glibc headers installed in the host are tailored to some particular
architecture, be it x86_64 or whatever, not necessarily compatible with
what the compilers assume for the BPF target.

This particular case shows the problem well: all the glibc headers
included by that BPF selftest assume that `long' is 32 bits, not 64
bits, because x86_64 is not defined.  This conflicts with both clang's
and GCC's assumption that in BPF a `long' is 64 bits.  This may or may
not be a problem, depending on whether the BPF program uses the stuff
defined in the headers and how it uses it.  Had you be using an arm or
sparc host instead of x86_64, you may be including macros and stuff that
assume chars are unsigned.  But chars are signed in bpf.

>
> Thanks.

