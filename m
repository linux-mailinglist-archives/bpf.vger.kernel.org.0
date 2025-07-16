Return-Path: <bpf+bounces-63445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C3FB07952
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 17:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 184F87B9120
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 15:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E521DE892;
	Wed, 16 Jul 2025 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r5vmAEKk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PPvW4pd9"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C5199EAD;
	Wed, 16 Jul 2025 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678936; cv=fail; b=abhP2shZ3j0gGCKLXMH1tsr6u/l6vPDOs2oX9W/JXBin2lzW2peY1/QpGXWZ4gMkV8A7lqpTx427iJPBVIk/Vt1BB/PvuU0H4OZ8Eww7CY4qqmNIIoohwJLv+Tj24ucilyAskq10yMqUY8mY8lSz1ISdvICEC+ew+AGYD3n9XqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678936; c=relaxed/simple;
	bh=oQsq2QcdijC4BSVEGmhV0+3pZ2MLGe3BvaflgNt48zw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BFoU925sfKSuMZmnamwkHeQV0qhLyal5jOKA1AB2dAFo/lbNhnToHUzkyYIQZLFhNpu46tWJZOrMakjc+R82bWnRKAs2pswwnlrv5iMRCP8eMNpgJ1ZYnjQydQ9ojfLutycF5OmsKLhos4yp8oQOsJYgAUOAodhFYW8FCdstVcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r5vmAEKk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PPvW4pd9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GEtpDA016307;
	Wed, 16 Jul 2025 15:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	corp-2025-04-25; bh=kHDmHRd/IGtDArDqccE+e7Tf9UBk59DTqDLitx20O/M=; b=
	r5vmAEKkj3fQrKMEgIPjNXqCi3Zn81h8ezARrt2Vp1jvmz53vSspYXe/2HNV09oJ
	sg+UkChacHDIuI45qgWdCH2OtUKv/KAO2Pk7H/DxIoq2ORteI+yP+c+ZCXffLDyn
	171XJ3rtIaKGgHQPB+8Qk2j861CNMCqLQ3GmXbaGxoNqNvSHJluZWKBhQLQ7a19+
	H+HnvGi2F7p1LK0N77k0rZXoVsgJdHviU4sMRpf7BWxAPDagIVVheZM1wLWqCMlD
	TrHmZo+quDQYx1Hem/AxONw8lB9Ed0JZATcIF8Pw+PCzxRH846aOVMJIMsldyhqB
	oOjVOEgSX6RvfgQCucgvUw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr1126q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 15:15:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GEinZY039724;
	Wed, 16 Jul 2025 15:15:30 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11012021.outbound.protection.outlook.com [40.93.200.21])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5bgcg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 15:15:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ri6k+oedlW9f8P6+3uQ6HjwlCaA92Tm+5FksZfAdmuXr4dFySN1XojYV6hk1FIIzcq4qakLbZXpVY1kPAs8WoEK7+HH1/jeYECz4/uNfM+Oc5BqTHKCJ1nofPeNuLYli+g3e3hBRqoqqoJJBy380OhpvYO0lu3eU6pXgXawdwyVLuxL8kj73z6m2hcmSTc5iVOC5kyV05MYzK+b0L/LJbSFLJn4s3ceoFtzSuVeyFd+PtYG6SqFUiULKWTXO02/KENLTD2FrMv/uIUtrqZ2jQjbnrV5wexalA3e+Se/gyP6GgeiYWS8ThnDLBM+yRe2kolXCkfmfAEsY1mAlgoncPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHDmHRd/IGtDArDqccE+e7Tf9UBk59DTqDLitx20O/M=;
 b=pqU4tRaTF6Ya77Ip0Q7BKX0BpJd/pagTNZ5/7ahkU8pYOyUgIgV8gN/P8nYNy8XGOzsiMrV9JoQ0xV+zG/gfEe7pa6VnS04//qT1CqnK44DCHvTRAGBsYXqFtJdsabI2sElmMLs9zc9xqAwJajIyUq2dK2auULuLBbkRXZMh/QrQwBN+3SroOrW4O+xTPHW0lvlLd8qJdasugdNVYiwf0SKO/Z23L5ULL+YvIRhTmotQw5mm3thXccqMqhOaFgxDc0mFYt+OGjabGZfOUFgJJ0mYlbulqWo179uQ5kQ9oL+Gsj6j+hRkrzobSIvnT40+W14oKKC+lf5sxmJiQmh6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHDmHRd/IGtDArDqccE+e7Tf9UBk59DTqDLitx20O/M=;
 b=PPvW4pd9kqGbZs3kkW+dpD4w0LdBHWA/9GgKJ9ZPzyEdFd3bMaB6DaE/MML2HOXI4rNfe3Hy+iCWSXBWP7qB2MboOekmtnIJ3BurAERekhAhThyp+cSpMu3owssL5AwJ5alilmIXSfaVOSVrlL7SdluMt2lVyrbz84S7fbibcqM=
Received: from BN0PR10MB5029.namprd10.prod.outlook.com (2603:10b6:408:115::16)
 by SA1PR10MB5844.namprd10.prod.outlook.com (2603:10b6:806:22b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Wed, 16 Jul
 2025 15:15:27 +0000
Received: from BN0PR10MB5029.namprd10.prod.outlook.com
 ([fe80::b85a:c2fa:6a79:393f]) by BN0PR10MB5029.namprd10.prod.outlook.com
 ([fe80::b85a:c2fa:6a79:393f%6]) with mapi id 15.20.8922.035; Wed, 16 Jul 2025
 15:15:27 +0000
From: Nick Alcock <nick.alcock@oracle.com>
To: dwarves <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Arnaldo
 Carvalho de Melo <acme@kernel.org>,
        alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
        alan.maguire@oracle.com, stephen.brennan@oracle.com,
        jose.marchesi@oracle.com, david.faust@oracle.com,
        elena.zannoni@oracle.com, bruce.mcculloch@oracle.com
Subject: Linking BTF
Emacs: because idle RAM is the Devil's playground.
Date: Wed, 16 Jul 2025 16:15:25 +0100
Message-ID: <87bjpkmak2.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0153.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::16) To BN0PR10MB5029.namprd10.prod.outlook.com
 (2603:10b6:408:115::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5029:EE_|SA1PR10MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: fe739074-da9c-4b9b-c07d-08ddc47b984d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MEBZciRwn+9qW9NrWoNpdv0rr51cvmyhxpNWVQut6+YiWrxeN7NHmAYBwj4z?=
 =?us-ascii?Q?3meym/zedcEtAM1OgMtlh+tgTYLWzr+mqU0XiwKTLuqh4HoWiRGGGqLvcloc?=
 =?us-ascii?Q?651N1GoJJIV6bG8GOA01H5RbjFBU+XfHmrs1zOv85xSG1vyXefMXdalqz1Id?=
 =?us-ascii?Q?YQwh9MjhBaLcxu6bHzaICdrGIpOm8CGUdyFUGh29rjv3pfpMqBkhjlcNe4mR?=
 =?us-ascii?Q?bTgW57GFxuXD1eDqvKjPMJ9VO7MNOcBHNgukWm6fsjA4ReCRxxMr+OFig7pj?=
 =?us-ascii?Q?cU8mIH9nMjYgOngSUfyuzITqdg3GjbMg3Hx0xEKf0rOfz01eMX1816qxEnNR?=
 =?us-ascii?Q?kVq2A/8og2gmp5IBtaVlRUWTUdJmO8vbFXuG+zf1xTCXBScklNkngmPEU+vx?=
 =?us-ascii?Q?cd6eOxYpb/XI3psSlhcDB7+3qWs/YTD2rq3BAnA8ppn6zh6OvtVDYOAf9V2N?=
 =?us-ascii?Q?tEPVGZfjRntDKYW4RaUxci+SBsWPh1nj39lvWlOOQTha+Nq5SQwUEKB2GwoX?=
 =?us-ascii?Q?+6affLPnfJ4o8xvwz0hW07okKtrLlDYrPozeraFIlWBwfh8dpmYlH1EFsb1z?=
 =?us-ascii?Q?B6nVK8oBP6ZzRNYmxru09SnMXPoOMm69DNgj6gcCXbPIJYyIj6oP4vcvVXRw?=
 =?us-ascii?Q?VhtVYTpFGe404oXnoHmcJfkPv/06fG5nheUK25phc9rVc+jm8kZ4v8AFXNax?=
 =?us-ascii?Q?urYGLjkfILQOK185VpTmplD64DbNeKrMDbRVPMjPTWOzCn95C7gAzdKAoAmW?=
 =?us-ascii?Q?/Avu9kRKByoEF43mOwXOzVKP07Zs5TcGe51+cPiieYOM1NiVO8qilBvJikus?=
 =?us-ascii?Q?QrFErPSROOc05ugFSoJpTUECs1JCBJJecavAi/6WE3n8XNHAGm9pvjl9ImfW?=
 =?us-ascii?Q?I6TYAexzH67iYgBEADmx3T8aJYQoBASXBNvEj5rl11Cnt1EGUNM8mGi3KmbB?=
 =?us-ascii?Q?wAoZZp23R9k1WqL8ieUMp4hMb6K9BREDyz1I2fZ5jGZAqgVXb/2ROA7V2Tif?=
 =?us-ascii?Q?ARrKJm9W23wtG2Lvgi4547gINaTpkaH4tgDqPWgaMqmnM2EKt42v4EGSb6L+?=
 =?us-ascii?Q?AWll6/jl/mjH+7Wlt1KsZtjOq/24si5Os6q4D44f89MakjWS57cUELLSNYMW?=
 =?us-ascii?Q?KkeFtnQFhifNekGE9X2eGPjiQ84KbVcczBB9WeMUjEPMTda4dwa3SoFf3wRq?=
 =?us-ascii?Q?JrnM+wH/gJlkx78wVjOzMHIdbXMgXNisUHlPqFnz1z+3f5r9W+pQ490zQT8s?=
 =?us-ascii?Q?SjfXqX1nMW2jOnysiugGMVLWVlh8YtsFUDsuQ4QxQaI/UQEVixMQpvn3dxnL?=
 =?us-ascii?Q?aUj9AbRM1o/tTd/2U2F98zUHOb40wqMtDN9EvXpspO+jT1FCSXpcgWDWOQMW?=
 =?us-ascii?Q?TTT40KTJKusZB3R6abLxtzHG59G54EfrETHCwMroyIXijQCejicwlmRPNoOq?=
 =?us-ascii?Q?hvapWw2d2fQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5029.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?La8RWwtOXRMzz3J46/vyMe/K7cugPHNhOqzMh7vuPiGsJMFs0rUq4uh8Yq5B?=
 =?us-ascii?Q?yxcZTFSHZ1vVCCtYqyXpRexF66xk+ruro2jFzrYgvpfpI2dbfH+6J+jVx0nP?=
 =?us-ascii?Q?R4ZWDTTZu6a/n23FgZToAWNKMERS3YEuc4RmTFpjRssfHOhziEJ4NQ3isxYG?=
 =?us-ascii?Q?oFHGq87kx+SBpGRyXOPkvZH6yOE/43Kh1YWdIo3YbEkwy/7uXnu8L29oNfdt?=
 =?us-ascii?Q?WOPb+AIJMvP6JETVq/KHn1l5vAcjrj3l6sNlgFX6gHi6GY2H4/cQuNJ83g3h?=
 =?us-ascii?Q?kVElci/8iBayhc9B9AR9zc3Iu3SuWEJaUNiNjDDxiTUTVal76H8WwCbyItHm?=
 =?us-ascii?Q?t7qk7WjnwDOfJEXjIy8W3YaT6t3MvUNr9tpq8VHPuHDJgMAXVt53zsEEotY2?=
 =?us-ascii?Q?GGrauzE2+IkKMW8DuwHM7PbZFVQWKATm5TYI2DX2yoY/c+CT1NYB4LFyR2er?=
 =?us-ascii?Q?vpGrZjM7MDMvbFyYVlzyC5Wpg6QNCO4d2X4uf945k0Q1Fe0lI+bR+qVg33QA?=
 =?us-ascii?Q?vuok/lQzwvPqavYEMEoqlnXGji4HKmVl7R8mW0OJFXfxBlvRwnUfSWIU97hk?=
 =?us-ascii?Q?4K6Rms/CEsiglUBH/MQscmbJ/k5ZCAh4KyCRatPtcL1FMfV9aK7bsBpYWa7i?=
 =?us-ascii?Q?/hoGLngDKmb35+N6GER7EpEQ0QOK17NBiyD7svd944HBIG3PADdJUZjkzYS4?=
 =?us-ascii?Q?iDEv2zA+QwqMJm6NU7QwZ89IDMl3qd5GKc6VFDgsvv/EY0GXINWdF/q0pxsA?=
 =?us-ascii?Q?v+WwD8ORV5/JD6ZKMYOZSvwbCIsDol3knwPO+KQheg8pCLvy62vDxD42qejm?=
 =?us-ascii?Q?Ep4wn9rJYVDR3cgcnpiKevBiQFjCkovGYwS7fYmaIyJKfGHavmrBUWvvgUuK?=
 =?us-ascii?Q?uCtmVhQBe20o91Hrh1ybrU6Ierq7/XV2ohzHU4YRj0q7tCgG+MRt87UhTMuq?=
 =?us-ascii?Q?z1vPLpHl1cyer92vK9smrnaaUxUqIXnQJCoP61SuYYMvllhGtULw0uxYewqm?=
 =?us-ascii?Q?LlINh9jTwG+6Vbd7DbVHEtilFoRJH87IF7Z/bFSvZQI94T3HeWu4sKPGAO9m?=
 =?us-ascii?Q?SWGH+HbRS0vzo84pCnKCILuRXltrLEaJpUMwTolXt/N+OfnuEilJo5Z4Ro3C?=
 =?us-ascii?Q?q6mONkn3RhJDvfoGZhXHWly1d2NfEZJ57g/Cl5Zu2Tp0uheialezfpSnpiIN?=
 =?us-ascii?Q?RDap3ZMIfeFJzIC7Zsc1nWfWObL9/vG2tsVykFGtb71ZkLE+hcToGAGgCpRc?=
 =?us-ascii?Q?x/DFm9fY2o0JnH/1EU8BEFpN66DaAofJOubax3M1Hkv9AO+yJ7iScdkJNzxI?=
 =?us-ascii?Q?PQwmZttNbyOXEfDb9w0lBcpkBwsstnEFyK5eWl6K3vbWVdp9h+YTsGwYI7hv?=
 =?us-ascii?Q?DjF7u5WeFz9Ofmnq+v3wP/yCNPI+1SpdmEqDUXsHC15045x8wJNeVVxaXUOo?=
 =?us-ascii?Q?rn5bS6rb4kfzhV+AXn6mOWTxxSz9DcCxj/+pEy4agTzt34eYlMhr0He3p3SA?=
 =?us-ascii?Q?whQJe+Tcx7iIDsQhSQOuQi/ISQa3Z4sTFOme4q5qlLqhiX5gWDoLYrVKYeQD?=
 =?us-ascii?Q?Riw0ajuC7qFZODxcLDYAwYkpoNfd4WHurKbZe09N5WcOpU9I/Lvwyra2W3u4?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XnqnIwsp2VqszdgI8S0EfR9xvNhTZ75mE0EcdasDmTuGoOrbUHMTWCad2cRt2yTVw442qAlH5wQaWnefnnF50aIDd9Ok48ksKALTM+NfFCdfM3c7l3SuKOQ/lQpKsdGDbcb5bJQdBbZe7D20/IgVHjNBVE+qBA6Vzc2JWz2eJrDVxrtKLccHkCFbJIrwOvO/5iUSH5PTDAD4qQCiVmhQ7gWlWkjOC4q46BuuBbTwiIljo3iggLHaca0c/LJV6HvDvzUAXX6NKbIGXFnm83SR4HtbNf8z6Rzukxa7iQedIGIXPqBwz3mh7Y0OSY55FXsctOniXJHoPn4RRrkVIfPlnJvMwRr5fHZ5irgUsPapslUAEu67v2hAMpLzn/GqsllZ0y5ChU35PLvaFnb8hc+KGoTDPMNv8gl2+F/0rT1DHEQx+w4hF02NoHEIELlTt7WudRBTdpIzY1oysjsc3PuveEcPIaKH/IYf8DE9VChHI4FMQQ1bq/f14MhUDbGCnvRpHwjiCDz1bGW63rvb9jMa/3XWias3fUbRXBoOW6seGf1bU9OsmU6AIv9u+lcnzZI0p45a/58n9DKSD40FU5IJELwNkReJR6vwo6UjTbYVxFA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe739074-da9c-4b9b-c07d-08ddc47b984d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5029.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 15:15:27.4079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2tyCC4LQKmj9ER3zFNWT1KTHsba1nIWCaI/y53A9Gr2EDUGIMKQAKRmXuru9YXfYkjG4+V/lp5tX1ZRitHaDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5844
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160137
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=6877c212 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=CCpqsmhAAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=vbyJIY8eAAAA:8 a=-VvpyFImkEDQCw_eWb0A:9 a=ul9cdbp4aOFLsgKbc677:22 a=UXyj_mcEdvtx2GLQwyJ1:22 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: LFDPYKfA0Xf1OXvvVEEtr1fdlU5ZUqEa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzNyBTYWx0ZWRfXytaitdlHTJga rmuDKFQ5xgnRaXZY7cFv9Nn4fyjkP0qzINvXR9nVancZX8pAJo8cvXeY/d2lvy1AkdXFnRZXHeD bG/mHrtmFZ/ccEIZF0DlT3VgcidlJNkovkU9yyOKPauba+4EIOkmdy5h0IS15EcoKd5S89xWsYG
 BVergXQnKibBgKJsXzDTPBXSSJ+lUatFo07B4NoCGUNzGs/tRdT7AzJ5bBdJigWBNpdInPVlInl aAcxngbYfiPz9JPMy9c80xXrHSPy0yJ0Gqj9VbrYc1G3JxD9ya+rIzjsPgcHZqCVS77rNQkXO8b fO+hMkwVIpuSZeD1DSvgCa4Sztv+TmY3a5WKaKBXpWLlhk9jlE8jWGFRFyIquTOe91OhLFNchtC
 L0d81jSsDxvI0mKga1gP8WoYVrOzO+8jaIqkaaCz0hEGYf/4Vh3bjKAS9SaBcUCg0T44rP3v
X-Proofpoint-GUID: LFDPYKfA0Xf1OXvvVEEtr1fdlU5ZUqEa

So I'm working on a scheme where the compiler generates BTF for object files
it generates, for later consumption by pahole after deduplication. (And I
have a proof of concept[1], already posted[2]). But doing this sort of thing
rather than post-facto generation from DWARF raises one obvious question: if
we're emitting BTF into multiple object files, what do we do with it when we
link them together?

There seem to me to be three options: an ugly but simple one, a maximally
ELFish one and a third option that is a sort of middle route. Based on some
investigations we did, I think I know which one makes the most sense, but I
could well be wrong: please critique.

 - The simple route is just to let the linker do its thing like it does for
   every other section it doesn't know about, and blindly concatenate the
   contents. I hope it's obvious why this is less than ideal: the result
   would soon get enormous, and every BTF-reading tool would need adjusting
   to allow for the fact that rather than one pile of BTF in a .BTF section,
   you might have many concatenated together, with no way to tell which
   input file each one referred to! You can't even save much space by
   compressing the result compared to compressing the inputs' .BTF
   individually (I tried it, the individual input files' chunks are usually
   too far apart to be caught by the same compression dictionary).

 - The maximally ELFish one is to put each .BTF into its own per-input-file
   section, named after the input file. Since this requires at least a bit
   of special linker handling anyway you can make it do more, and
   deduplicate at the same time, turning the result into split BTF and
   putting shared things into a .BTF section.

   This... feels like it would be really nice, and I tried to implement it,
   but at least in GNU ld falls foul of a deeply embedded architectural
   limitation, and as far as I can see from a brief look at lld, it shares
   this. You don't get an output section to deduplicate anything into until
   after the linker has figured out what output sections exist, and it only
   does this in one place: you can't go back and add more after the
   fact. This means that we could only deduplicate and add sections freely
   before the output sections are laid out -- when we have nowhere to put
   it, and honestly we might not even have acquired all the input sections
   at this point, since that is partly interleaved with output section
   layout. Essentially, it is incredibly hard to have output sections whose
   names depend on the contents of more than one input section, and that's
   what any plausible deduplicator is going to want to do.

   So this is really only useful if we're doing what ELF usually does, which
   is to copy input sections into output sections without modification, or
   with at most small changes (like relocs) that don't change sizes.

   I note that DWARF emission is special-cased in ld in part for this
   reason, and even *that* only emits a fixed set of sections rather than a
   potentially unbounded one. We should probably try to emit a fixed set
   too.

 - So... a third option, which is probably the most BTFish because it's
   something BTF already does, in a sense: put everything in one section,
   call it .BTF or .BTFA or whatever, and make that section an archive of
   named BTF members, and then stuff however many BTF outputs the
   deduplication generates (or none, if we're just stuffing inputs into
   outputs without dedupping) into archive members.

So, here's a possibility which seems to provide the latter option while
still letting existing tools read the first member (likely vmlinux):

The idea is that we add a *next member link field* in the BTF header, and a
name (a strtab offset).  The next member link field is an end-of-header-
relative offset just like most of the other header fields, which chains BTF
members together in a linked list:

parent     BTF
            |
            v
children   BTF -> BTF -> BTF -> ... -> BTF

The parent is always first in the list.

This has the notable advantage that existing BTF tools understand it without
change: they see only the parent (but since the parent is vmlinux, this is
probably enough for most existing tools that don't have to deal with
modules, and of course that's enough for existing tools working over actual
modules, which won't need archives at all).  We give members a name because
with the exception of the parent we do want to be able to distinguish the
members from each other: we need to know which module, or translation unit,
or whatever each individual member relates to.  The parent probably doesn't
need a name (it's always "vmlinux" or "shared types" or something), so it
can just use 0.

The proof of concept I posted earlier does not understand this format yet,
but only an earlier version of the archive format used in the
proof-of-concept; the scheme above was invented later.  Of course I plan to
teach the proof of concept (and upstream binutils) about the new format too,
once we agree.


There is one big change caused by using any format that involves more than
one BTF dictionary like this: external references to types become harder. If
all you have is a straight .BTF section, you can refer to a type with its ID
and it is unambiguous. If you have a bunch of them, suddenly you need a pair
of (member, type ID)!  The ability to refer to types via a small fixed-size
native-type token of some kind is extremely desirable and I do not want to
lose it. But if we consider the linked list above to be an array (and
looking members by integer is something libctf will make easy in the near
future), we can just make 64-bit "archive BTF IDs" where the top 32 bits is
the index of the individual BTF: types in the parent, with an index of 0,
just get a bigger type with no change in value. The kernel apparently does
something like this internally already.

Doing this means we keep the ability to refer to BTF types *in any module*
from other sections, even if they're stored together as an archive like this,
which is how nearly all extensions to BTF are structured anyway and which
seems like obviously the right way to do things: I'm thinking up ways to
turn most remaining CTF extensions to BTF into that sort of external table
already.


[1] The proof-of-concept is here:
    (binutils) https://sourceware.org/git/?p=binutils-gdb.git;a=log;h=refs/heads/users/nalcock/archive-v2/road-to-ctfv4

    (kernel) https://github.com/nickalcock/linux/tree/nix/btfa

[2] mail about it: https://lore.kernel.org/dwarves/87ldqf1i19.fsf@esperi.org.uk/T/#u
    (note that the branch name in this mail is out of date)

