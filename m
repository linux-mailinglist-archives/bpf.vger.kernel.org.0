Return-Path: <bpf+bounces-32528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3E490F474
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 18:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF05428377F
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 16:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37B6154C1E;
	Wed, 19 Jun 2024 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eDsTNmnj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yeWEDK58"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3FF15696E
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718815604; cv=fail; b=WHR7/eDp2qgc23rYRaZnde+HlneJw81PdixYTyWOVpsTFu/o3nWkojJtVv8HD8KqUuEBdfAtaz2j+Ba87yfuzP4Rh/czXQKm30IWL/Kz7EiG572zVDfa3j+iRYF3LiX5b+eGsxT1B5IJN+lWigZqsGixUS6edCkxeYKwgkan7mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718815604; c=relaxed/simple;
	bh=Ck9K5bObwsf/gCW+6CJOM7oqZybP/sW8i7KEmG6cBo0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jP16VrEVXe15f8923un4uYP6IABTeGHbjpTYFEVF9d96ehfsalmIfSWRjYFUvmzNY38rTufhmt3XtkKH6jsdaywH2ZsxwN72r/VaMfXS0X1b1A8Cno3UzVobmq1StY9O6JxWLlccX8xS52bb1gaplDBWVi2s1mDi2ZjqqWRHhm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eDsTNmnj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yeWEDK58; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JFBPnM016333;
	Wed, 19 Jun 2024 16:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=l8BzErwbcotWBc32t6Fej8nbJOc5O/fCDHkdTAEosVQ=; b=
	eDsTNmnjTA1aKa7vW/9FDfsJUTjVsnm52GZd9ltZKDYnKANrkC2lrMZkNj3y4Tnb
	hFAx69zJegU2vJFslTNdnCnzNCuOBospu8sJIhThVcSbpLWctklvWUwu0L0IsR0M
	8XapqAI6AG6AMPUKAb2qgm+BO0wxp8+TzfjgVQkhfijShg4FDpdDxPkISSenqn9R
	yQZBInwwCQdcup2CY4RI+FhC5vZfrdFkngFLwT+3i5qxTKxb6/jawl6IMZzcEB9R
	g7RT0AAXDcPOZq8T4dFmLsS8/cX7f0KPH6VawpmaSltrSfLzPgMv/ZKI283+1vNd
	U+O3x+5NXp6OH0d0xJaQbg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9j9njc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 16:45:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45JGAvj8006847;
	Wed, 19 Jun 2024 16:45:56 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ytp8g39tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 16:45:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2oT4sewhtS1XovuQriyX7kVn7f/VDmPjtfFsqGyvXn+XRAAlz/myWP3K8lqQf4lGWlTMyFKb8tuRvyPeJB9zthriCWzs5048w+Q04TwvyRcDGKxWouDFKwjgJANm45ECzj04v2L0MhlAh5+9V1Xw1QXlNUAFyYx5IqaYu5A6Wx84xsE93T+fYfwXuvFymD4FsnPBNua8kJKKvMGRe/F1QzMs2IjaG8XiVdrssHnK/ZbsvE1lqekwpcM//uKYROVw9TGShwKuON168RyEPkt6dYalqC50kd0IA9UXM1uYg0gHNlrbvsYOtd4KeycQZlNtxNruotMWEgeAOHBuaHiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8BzErwbcotWBc32t6Fej8nbJOc5O/fCDHkdTAEosVQ=;
 b=AVTC4Eo/8wWc59j047K8ssh7vWWoL4tEOEtZVp7CAx3HBKTbKA8a8GDRszZm/s6AF0nlqCtVP0e/+EXrT92QXMRVsr3yq9b/qA7jh86ypOtFgrQegIcCqC5XpY4pnaAIxw13x177mCYkjLBHyRUSiI6FamesF97c0gUaztWWK3Qe+m0pyteGK5NZTsWUVYlGaVQoF4e0NOZFc3ETo4YUC6pkaOCTZLZtHRCjST9kJDH4LVSoQ8SceFMH98IPdsJ2IC/OsQ91AHL0gxe5H44lU7C1rnAi0Rmky4074V9h1CsVYYGVNpwvCzEXelo4vvYKVtC6lvkcrUAFTpwU+1Iu6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8BzErwbcotWBc32t6Fej8nbJOc5O/fCDHkdTAEosVQ=;
 b=yeWEDK58MxABykTAWBZntVTO8xTRf10VHUewZdge3KmlNUOa6Auao6koIMcYJYE9ujZOElnxbTkEqnCZKE+n0smbcSSWiDEUP8WQ4bhvmCPqbIQwZhBtInbAba9RanbzPd68b3zJo67YUvhjibssKitGrOqcEw0Rc1JoQMVxT6E=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA2PR10MB4779.namprd10.prod.outlook.com (2603:10b6:806:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 16:45:53 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 16:45:53 +0000
Message-ID: <44779d5f-6d54-43cb-b556-d62201765c9d@oracle.com>
Date: Wed, 19 Jun 2024 17:45:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: add kfunc_call test for
 simple dtor in bpf_testmod
To: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org
Cc: acme@redhat.com, ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, mykolal@fb.com, thinker.li@gmail.com,
        bentiss@kernel.org, tanggeliang@kylinos.cn, bpf <bpf@vger.kernel.org>
References: <20240618160454.801527-1-alan.maguire@oracle.com>
 <20240618160454.801527-6-alan.maguire@oracle.com>
 <4321b99db5b362e278b1f37d6bd9b9a43d859d63.camel@gmail.com>
 <76509fc5411e35a4820c333abca155b3fa4e5b84.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <76509fc5411e35a4820c333abca155b3fa4e5b84.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0240.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::20) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA2PR10MB4779:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df0a5b9-832a-43af-f8e5-08dc907f48c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dlFubmdMYVhmeGdZTTNhZHJZZzNFWExFMzZlWDNUdmY4djMwNFpkNWRXNlU0?=
 =?utf-8?B?Uk5taTBPWjRFU3ZmdzFXaVNGMmIzakI3cnRZOENxVyszdm1NTHlqYTdIM0U1?=
 =?utf-8?B?M0RuU1JidWdlZ1U3Y1NlNHFiRk95WWJlYm05Y2NHNWpJVGF5OEluSzYrVzdt?=
 =?utf-8?B?alJaZFZ2RUpmeGxSRG8zTkJxOU1kQmo2TjFEYno5WnBBVlo1OEtGaFN6T3Jq?=
 =?utf-8?B?aUNLSGlWdVk4bVBBRXJiNkJIMlk5djNRSWg3YkFyYVFQS2FGNWdLSUJub3Vy?=
 =?utf-8?B?ckhoRmU5ay9jeHFZY21jSHZsTmd4ZFloalNYdG0xQ21wYmtITjRKODkzekZ5?=
 =?utf-8?B?STRPUE13ZFFQc1d6NnB5TlN4U29wcFQrY3NvMm1hRjlGNHdaUUo1MWxXTnJq?=
 =?utf-8?B?TTlsdjJpN01YTTMxTHBiT1Uwdi9ZeitwbWZacERNOVhSdFo5QzJweUtIL204?=
 =?utf-8?B?dUMvQUVtQzRxeWdQL1ZZRTMzd3BIcWNxdHlKUFBIUG5ybkRVUW5jdEU3M05Z?=
 =?utf-8?B?Z2tVREhmc3l5Vk9rZjhBNHJvT1lxWEYzUUhDajBOMk9YYWk1aDZ4OGpRTWJ2?=
 =?utf-8?B?UDg4YkpaUHduZklFa0t6UmRhcG5YL2ZqVUVNUCtQbEV3M3djZlljaEJLLzFF?=
 =?utf-8?B?YTZGU010UUtrNFZ4bWFnSWYydE91RXgrYk9BU283aC9PWUhWbGNTZi9LZEFT?=
 =?utf-8?B?NVl4eXBYZWFPalFuMWlxWURxZjVmZlBtTndNcG4rWm5HVUZzSm9qWUlmT0wz?=
 =?utf-8?B?aDh4WTNXOFdETU5HcmZIQURyZVFVb0VjZjRLTkFxSjlQMkpKemEvbFhGQVdn?=
 =?utf-8?B?OStkOExoelNmWG1vVTQzak52aUxNendMMTJhUUl4anc0azQ4TmNsRnJqNUpo?=
 =?utf-8?B?RXI4cDRaVzdqNUpQR0Z6RjZQSHB5MEUzWllGc1gxSGFORTZVa0kyanh4SUFj?=
 =?utf-8?B?MERlMWFVYXc5dnhnZ0tyOVEyS3R4c3BibFh4NkJuZUVzcmNjeWtpNkplZ0hi?=
 =?utf-8?B?YUFZL0JWTmJJS255eURPb01wZG5pUmZQcm9PWGZ1UXowKy95SjdtTUliWHA2?=
 =?utf-8?B?MGpEMTQvNFVXU2MwQlYxZkt2bDhXT0ZUcE11R0p2RHlvQnNlNkJpWDJjcHM3?=
 =?utf-8?B?NXp6ck5naVFNaVRKN2dONENJV2lLV0xUMmwxR3Q0dEJuekhPQkhNZExBaXNI?=
 =?utf-8?B?WnlJbkhKKzhyeHY0V0RqMGpqNEhLSkpLWE1mdjQvNTZXWXQxSlhIYmFEZ3FC?=
 =?utf-8?B?eEo3eHRlYXQ1eUM2OUdKalBQM1gyVGNmMFRxaGdZUTFRRTFPVXZQRkVXSG9B?=
 =?utf-8?B?dlhyN2Y1R3BMVjR0MTZxOGg4d280Ri8wR0o5Vm1MU05WbFlHWjN0NUlTRGV3?=
 =?utf-8?B?ay9OUnBQbjc0dGY3YXZSUm1wV0w1bVlwU0I5RGlUcUVQRUhGWmFMaFhwVmRt?=
 =?utf-8?B?RU1NSllXSjJaZ3Q5VzFwZElQbUJ3ZGFybUdyckVQQWtuMG5LZDJMVmg2NUln?=
 =?utf-8?B?WVN5RjlYYmYyTDEwcThBSS9NdnI5Y1VzeEFzOHArWW81aXFZVzdmRU1JdEpZ?=
 =?utf-8?B?a2tDMGs4RFYyQURMNWdWRWVkYnhjZU1mVjFaa085VEdxV0FZc2cvTjBPL21n?=
 =?utf-8?B?eXR0TkpNazJoUmZHQXBvS0cvaTJ3YmRJbjZUYUthM1IzSG1mWno5Vk1UMmpi?=
 =?utf-8?B?Z2M5MFlNVnl4cE0vK3ZKR3E1aXBVUHpVcjgrZWNMajJFeVd1TE5hQmlwYkJZ?=
 =?utf-8?Q?BereQb5MYrKMAxr7P3aY4Z6rVtYwR2HDDjGSiRP?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T05zK3loOEZXdWVleU5FZlJTNlFYUUxsbzUycC9SRXJ4dnU1dkVFUEcwMmxy?=
 =?utf-8?B?VVZoL2xOY2hISEkwckVSRWJEREpFeko1Q1RKQUN0UzlmMVFwZ2NkV2FkbnQx?=
 =?utf-8?B?ZWV5dVBJRVNWWmMxaVFCUzlhTlVNNENJV0VuM3JSS0tFcHA4V0REWjN0U3Q4?=
 =?utf-8?B?RWRFUUZzZmE0MVZ3K1FxV3FSazdBSXNibkpCT2laTzg1SENYdkRwWWl3cHlL?=
 =?utf-8?B?MW5qU1dpMzFWT3h1V2FnemJWRDdEcTM1MTBYeDhRZlRONUZ5OTBXZUZiU1BN?=
 =?utf-8?B?TmplMDVqLzhCY2pUY3ZBdklPUTJ3bjc4cWxDaVJhSWI5WTJ6U0dHRzZ6QnlD?=
 =?utf-8?B?ZHRUSVZqNnQyYWNiUGlZWUl0VWNLL0Q5Tm56elVEeGxMa0VGTlh3SFhiRDVs?=
 =?utf-8?B?YzRtUHdvODBjbXhvY2twTDhIS3hhVTBydldqZ21nMk00dXVhekpyQ1NZNU1F?=
 =?utf-8?B?aVRwTHFsOE5aZHMwTmFVRzcwTWpnYkQ1RHA2ZTREaHArT1VBeWg5Q2t5am5s?=
 =?utf-8?B?NXJKUkNNdVo4eDllNVdXQWxpNXQ3d0RLRVVhTWlqZW04Q2toY3JuLzhtMzk5?=
 =?utf-8?B?QUpSRkIvNzRkWmh0ZUYwRVBTblFnNFdlM1JBOFRyc2hPbXRLcFB4YzdMSjJq?=
 =?utf-8?B?TXVtR25OK2tJeVgrMFpGdXhUNExxdWR4eVRBYWl6ZlZDa0VMc3FPd1ZKOWM3?=
 =?utf-8?B?NHlVSUZmZ09VU1JiK0dLZ1FmU2N4UEpjK2dwTFBuTWVHbnI5L0gxbUhVNEFh?=
 =?utf-8?B?Q0MyajF5Qi9NR0NiWkZSVlA1WUFjSnBHajZ5aUtMaDBSWDE1L0FkR3MyZlRu?=
 =?utf-8?B?TktGcXVrMTRzSlFjZFZMSHVOb0tnaXdRVDhWQnhEbGIxbjFySFVJN2N3dGsz?=
 =?utf-8?B?a3BoZEpWM1c1b2dJc2tSZTZTVGlkRFk5WnVNZml1Q2swVkpnejNHemZBc1Qz?=
 =?utf-8?B?cjlNWlRCYXJua29VYXBkRi9zcVVMdUZTckszc3R6SWhPR3dhTzlSNEFsZjdv?=
 =?utf-8?B?bFgvME5GS2hTR29TWHNBWXRqbHZ1bmtnVXp3NGJpdFJXbTc2eHVqMjhsU2FP?=
 =?utf-8?B?Qi8zb1Y0eDBTaGM1anRYODNSQ2xJeWh4YnZFYzZjaXJTVitGN1MwT05ZbWN4?=
 =?utf-8?B?K3kyZy9xWC9iQ0NsdUVLZnpzbVN5Smo5MkEwVDNObUVlTlpoUllJRlgwbWtr?=
 =?utf-8?B?N2szTmpVcEpzaFg3SDQ4cXg0aGFZU3kxNmpZMmU3eU5qeEdoTURDTWp6UnNT?=
 =?utf-8?B?NzRmUDRtaGJxYUxXUkJwVU5aYzNKVmg3TDFpbXhsV0ZPaGwrR25OWW83Ty95?=
 =?utf-8?B?dXc1d1IzOG0wYTNBRFJKclBPOWIyNkp3VmpnK2Y1ZnphSlRWTitPRFhDOXo2?=
 =?utf-8?B?bHZpdVFiQTB2aTQ5ZnFKOVY2R011VnlGazlIdUhyZzVud3ZKWk9nNXFwT2Jl?=
 =?utf-8?B?ZFd3bElzMDN0VnM5ZW5rS1IyM1ViUmxhbDdzY3pYS1NTYm14M3dvemZWbTc1?=
 =?utf-8?B?MW1UZ1VPV3A4b1h1NGtQWVdILzEzelZJclkrS1ZlN3R5YVRwL2ptZnRPL2o1?=
 =?utf-8?B?ZlhZREt1QUorZUdkemlMckRkcHo2WXUxZW9mcm5zM1J0SEEzaGljMVFrVzVs?=
 =?utf-8?B?THZNaHpmaDJ3eWlWdjFSS1grRkpxQkluMXYyWXhCdFVnSnkvMjd5UlUvcXF6?=
 =?utf-8?B?SHlKV2pHOUhrYmZnRzJuY2RlUitmbWlIMEZRTmVQaC9FMCtNWU5oOWt1Y0R2?=
 =?utf-8?B?ZWtLeGJvTVhBWHdFbGxuTEF4N1dFYWFvR0xadzM3V0dUQVYrR2ZJRVdDV0JM?=
 =?utf-8?B?OUc2WHR3dDJPUkwvNmdrQWt4TXhadXlCQTF2c2VzMGZPRkQxZS9SZnF2M1Nj?=
 =?utf-8?B?V1ZvWjA0c3JhT1dTTWduSzlockJ2eUxFejcyVjdJVFA0Y1RaWW82NlZKYVBu?=
 =?utf-8?B?SW9UbTBadEdDcitic2RYVjg5cGhBYTZJYnRDTERSaStWUEFQd1dJcFdjVGpx?=
 =?utf-8?B?R1J0Y1dabXZwWERrMEVjZjRMMk1hYzRlRlp3aWNBZWxWM2lMcnpXY2d1MTh5?=
 =?utf-8?B?L2dLZVUweXNSQ0RxRGtFSkJlUjY5MFBKL3pGTFlVL0FWcXNNOVNRckR1eUJ0?=
 =?utf-8?B?SUY0YVA1OXZvRldhSEI4VTBQR3FHWlJsOGp2TjIyaUtvbURKODdDZmdlVlNn?=
 =?utf-8?Q?WQ9ei9fev/ZFM5zoxNtVUk4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	k6XEFnMjjvzh73GmpQU4ca8K4ArnY8KReKGwjbXccoURK2QPFjLvZJmaBXpz7PgKgl5PQZpk2KETtfcltg0qUzXLqZJSV3UhT5HEUtwb8xVaxMryTiCgN0vXJggwAALbaB07hk48vAD3HX4DReXyB0M3MwbibbPZiDYJDZy074qGFtosJHoMVvWwJMHTKrqTbrr2FrlhALX/COZXeCwZThRmsDqtxLPalYskp8cbfFRoVtDtMPGJwuzXzpLdDjExC3kjmpaEVd9B4HNIqQnScWNrdpVvxZvRCTvYO9SRHjSIm5e1rUs9zJiUEaNVtqrUq4pYRXD9nF3pUpN31kBftBrBFiB5OtepjzgfwZyBgzuVSnWxid9saGii+t811t9KyTnvw2DRlIUp2r6EANBV7t0NZoNFBuu1dICvyaKh1GD6XWtlaAbxBAkdu3gH+V8almbIX3lmwfpFbO03k8wOSpu0nw8qstFM/aBlh9l2fCemQw0xRBdn/mlQhbjJ8fRE78VtzFjtgCyrpTsMapJoYpA4p5iDHbAt1CYc8pnx5MqLjrDJP0CIgjc1zMk41NVG/WpTTXP25eR2g03VRsU8sB6AIALoXET+dnxgkqi6igc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df0a5b9-832a-43af-f8e5-08dc907f48c1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 16:45:53.7336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0HBZ7pvQwUR6m2+1R4RTJaib52Oyj7CMRL+NIq3gBA++0wu43mCPgOQBflStrExHs7NWGTBFJJSW+XsGc3KPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406190126
X-Proofpoint-GUID: nzOFI8bgYyZOvwDt1NMJW8dinCrzLHzx
X-Proofpoint-ORIG-GUID: nzOFI8bgYyZOvwDt1NMJW8dinCrzLHzx

On 18/06/2024 23:27, Eduard Zingerman wrote:
> On Tue, 2024-06-18 at 17:04 +0100, Alan Maguire wrote:
>> add simple kfuncs to create/destroy a context type to bpf_testmod,
>> register them and add a kfunc_call test to use them.  This provides
>> test coverage for registration of dtor kfuncs from modules.
>>
>> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>
> Hi Alan,
>
> Thank you for adding this test, I think it is fine except one defect
below.
>
>>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 46 +++++++++++++++++++
>>  .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |  9 ++++
>>  .../selftests/bpf/prog_tests/kfunc_call.c     |  1 +
>>  .../selftests/bpf/progs/kfunc_call_test.c     | 14 ++++++
>>  4 files changed, 70 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> index 49f9a311e49b..894cb31f906b 100644
>> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> @@ -159,6 +159,37 @@ __bpf_kfunc void bpf_kfunc_dynptr_test(struct
bpf_dynptr *ptr,
>>  {
>>  }
>>
>> +__bpf_kfunc struct bpf_testmod_ctx *
>> +bpf_testmod_ctx_create(int *err)
>> +{
>> +	struct bpf_testmod_ctx *ctx;
>> +
>> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>
> Note: I get the following message in the kernel log when I run this test:
>
> [   34.168244] BUG: sleeping function called from invalid context at
include/linux/sched/mm.h:337
> [   34.168633] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
185, name: test_progs
> [   34.168838] preempt_count: 200, expected: 0
> [   34.168926] RCU nest depth: 1, expected: 0
> [   34.168989] 1 lock held by test_progs/185:
> [   34.169056]  #0: ffffffff83198a60 (rcu_read_lock){....}-{1:2}, at:
bpf_test_timer_enter+0x1d/0xb0
> [   34.169056] Preemption disabled at:
> [   34.169056] [<ffffffff81a0eeea>] bpf_test_run+0x16a/0x300
> [   34.169397] CPU: 0 PID: 185 Comm: test_progs Tainted: G
OE      6.10.0-rc2-00763-g6dba637e3bf3-dirty #31
> [   34.169557] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.15.0-1 04/01/2014
> [   34.169679] Call Trace:
> [   34.169731]  <TASK>
> [   34.169767]  dump_stack_lvl+0x83/0xa0
> [   34.169828]  __might_resched+0x199/0x2b0
> [   34.169884]  kmalloc_trace_noprof+0x273/0x320
> [   34.169954]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   34.170034]  ? bpf_test_run+0xc0/0x300
> [   34.170096]  ? bpf_testmod_ctx_create+0x23/0x50 [bpf_testmod]
> [   34.170169]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   34.170241]  bpf_testmod_ctx_create+0x23/0x50 [bpf_testmod]
> [   34.170328]  bpf_prog_9591c1d0a1bb3a0f_kfunc_call_ctx+0x2b/0x58
> [   34.170394]  bpf_test_run+0x198/0x300
> [   34.170394]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   34.170394]  ? lockdep_init_map_type+0x4b/0x250
> [   34.170394]  bpf_prog_test_run_skb+0x381/0x7f0
> [   34.170394]  __sys_bpf+0xc4f/0x2e00
> [   34.170394]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   34.170394]  ? reacquire_held_locks+0xcf/0x1f0
> [   34.170394]  __x64_sys_bpf+0x1e/0x30
> [   34.170394]  do_syscall_64+0x68/0x140
> [   34.170394]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   34.170394] RIP: 0033:0x7ff25a1161bd
>


oops, missed a GFP_ATOMIC here to avoid possible sleeping. To use
existing kfunc call test structure it's simpler to do this than add a
sleepable test context I think, especially since the focus here is on
adding a basic test. More below..

On 19/06/2024 00:28, Eduard Zingerman wrote:
> On Tue, 2024-06-18 at 15:27 -0700, Eduard Zingerman wrote:
>> On Tue, 2024-06-18 at 17:04 +0100, Alan Maguire wrote:
> 
> [...]
> >>> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>>> index 49f9a311e49b..894cb31f906b 100644
>>> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>>> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>>> @@ -159,6 +159,37 @@ __bpf_kfunc void bpf_kfunc_dynptr_test(struct bpf_dynptr *ptr,
>>>  {
>>>  }
>>>   
>>> +__bpf_kfunc struct bpf_testmod_ctx *
>>> +bpf_testmod_ctx_create(int *err)
>>> +{
>>> +	struct bpf_testmod_ctx *ctx;
>>> +
>>> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>>> +	if (!ctx) {
>>> +		*err = -ENOMEM;
>>> +		return NULL;
>>> +	}
>>> +	refcount_set(&ctx->usage, 1);
>>> +
>>> +	return ctx;
>>> +}
> 
> One more note:
> As far as I understand, we only test the logic inside
> register_btf_id_dtor_kfuncs() in this test case.
> The dtor logic seem to be triggered only for fields of structures that
> reside in certain types of objects, e.g. arraymap or other places
> where bpf_obj_free_fields() is called.
> So, the full dtor test might look as follows:
> - allocate such map and put an object there;
> - deallocate the map and verify that dtor kfunc was really called.
> If we consider this too much of a hassle (which it probably is),
> the body of both kfunc and accompanying bpf program could be empty.
> Please correct me if I'm wrong.

Yeah, my focus here was testing the registration to be honest and
thankfully as you noted it caught a case where I had forgotten to do id
relocation, so thanks for suggesting this!

To trigger the dtor cleanup via a map, I came up with the following:

- call bpf_testmod_ctx_create()
- do bpf_kptr_xchg(&ctx_val->ctx, ctx) to transfer the ctx kptr into the
map value;
- only release the reference if the kptr exchange fails
- and then it gets cleaned up on exit.

I haven't used kptrs much so hopefully that's right.

Tracing I confirmed cleanup happens via:

$ sudo dtrace -n 'fbt::bpf_testmod_ctx_release:entry { stack(); }'
dtrace: description 'fbt::bpf_testmod_ctx_release:entry ' matched 1 probe
CPU     ID                    FUNCTION:NAME
  3 113779    bpf_testmod_ctx_release:entry
              vmlinux`array_map_free+0x69
              vmlinux`bpf_map_free_deferred+0x62
              vmlinux`process_one_work+0x192
              vmlinux`worker_thread+0x27a
              vmlinux`kthread+0xf7
              vmlinux`ret_from_fork+0x41
              vmlinux`ret_from_fork_asm+0x1a

Does the above sound right? Thanks!

Alan

