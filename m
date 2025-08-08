Return-Path: <bpf+bounces-65265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D89B1EA95
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 16:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D85D31776E7
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 14:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE43027EFFB;
	Fri,  8 Aug 2025 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LTKcvDeu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IvqW2DwJ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E10A274B50;
	Fri,  8 Aug 2025 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664349; cv=fail; b=Dv5Pis8c8Sw+JbsM5rU1j9oMl/7cuZuAg1m2efDV+w8//gdu/OYv90gvvrQR9jEmneCrNpNPyu5uFvbmJbBKfN8OqGWX/AFmwVx3OjyWuzbRz0Sug+dPOEgwSh9ULvTcHRQQ2oBbiH4Yyb4Fp94YlUFfnB7SKiSWhCM596ULWTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664349; c=relaxed/simple;
	bh=K1VZVZOfGETAF2M+nUKrRgY8tMFY30NTf6TYGK8xlbM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 Content-Type:MIME-Version; b=mCsDZAzkqCkPbbFcg6+g6YrTcfiEb6a6TmmdiX4qgccbsZdgeS1Sqoz53MFdGUTBUcZ1aB/oe+nEOs3aporkZyBOxG94a6nR3++SCODyyxMUjHgvEAY4Q8zFEuMzqNNOU+OuxXe4aOdxNuegbpZdcyufm1h3LQlnNxh4KI0PGE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LTKcvDeu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IvqW2DwJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578DNTAt003315;
	Fri, 8 Aug 2025 14:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=K1VZVZOfGETAF2M+nUKrRgY8tMFY30NTf6TYGK8xlbM=; b=
	LTKcvDeuNDIKin0Z3dZzchT1SgpYMJrxIhJteMU/gV8/S81uS5uMnhkgykQ3iJ4D
	8cFoCK2Eiz7obU9ROIEh+e5Lhr3hkIAqZ8MaU+iULnrykclNTmi9O7F8OhuGiHxu
	20hc4EpLiUg3Kka4zpMzEFPw7+HRbK/PKBJBCKKq5ywTSQvXLShvNYJ0YnZsa4oD
	otzavZ2Ya8rCfsUNEUsPSSAyNC4RdqrL+OzxTh8EnxhRnwOXGft8vCVqsWkAx2fZ
	zCREgnwWped9Q3kB3AgRs86dCw/Z51+sUR9pA4KzXndB0Y4ALBbv3IogZCV/qw1I
	g0M0nUv8974y0Nmup+deSw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvjxb9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 14:45:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 578EfFcA027119;
	Fri, 8 Aug 2025 14:45:33 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwqtuys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 14:45:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVG7Y6FyK6DuWdEol8yQiRmp8HOREXRfL914298HcV+4PWndxypxiU4cQvv26vB+oMABqx3JG997B0i7q/fpFTAsSwxgPfGJi5wvT5eKENVsJ1nHmiCPG0OqapN8pkLgBNixWHB1gQWWzDh2D+y6hWX2Ws8nObcSF/TRdf+8sGnSSXiIxobnqRte/0ICcEq32Pwgza/M/GeGBJkvi47yBpcrSEmgj1iBNk1d4Bd0Gcg691LB73a087T4lJZ9Ehg/tDj1nj2oEJGtie/AzIibNb3mds4lRspBdkMoANkS9ms/OQpxkWQFhlZYqTIMnCUAV36rHLeV7mMw2Ewm36kFDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1VZVZOfGETAF2M+nUKrRgY8tMFY30NTf6TYGK8xlbM=;
 b=aCTCgK9y0Nc5pc1fOKpKQpG0L96yIaw943AYpYzUAzX2mHW3dTfSY92uglC9HCXTtW22PhOKiddyIw/6+lkOyxMIEubkEnK1a84r/KH/x8y1M7qX5v95Nh2YkAxrmJ2A/rMBZv1IHlfZMCbyCf/Sd5/ryWdhE5WVT8IEgE3XpvJ7nqjO3+nk2dnwbw0Ab+7onu9v3E2TStMtCSdniBwtI2lCQlNgdDqQ+tZ9oqYjfR4pd1PyCrOgxtRTy2Z4oB9EuzbeGM0buM4oKXtNPf1TmyXLNrFrqxoRLEoX/EWroy8za5K1jnMCIBg6RCdCzTuytEUNn9H3AtCQPFnMnPYG/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1VZVZOfGETAF2M+nUKrRgY8tMFY30NTf6TYGK8xlbM=;
 b=IvqW2DwJIIsAZZ+3u6y1O6gt7K9rkJDavVqOKJlpC33bj7vC0JQlj+vwNc8jMSvJPMJ9YVZd3TRzcbKPWTdzw0dw+AOrDnWRhK7g+0Y6xivfh4raDVLBEx2tzza9Pd8Q2E/oM4bjQQQtD3vua6IqegkHoeRZpWCd7HCYgOVIBXY=
Received: from PH3PPFA3184E4F2.namprd10.prod.outlook.com
 (2603:10b6:518:1::7bb) by SA1PR10MB5760.namprd10.prod.outlook.com
 (2603:10b6:806:23f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Fri, 8 Aug
 2025 14:45:30 +0000
Received: from PH3PPFA3184E4F2.namprd10.prod.outlook.com
 ([fe80::815c:d94d:29c8:ecb3]) by PH3PPFA3184E4F2.namprd10.prod.outlook.com
 ([fe80::815c:d94d:29c8:ecb3%8]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 14:45:30 +0000
From: Nick Alcock <nick.alcock@oracle.com>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alan Maguire
 <alan.maguire@oracle.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Yonghong
 Song <yonghong.song@linux.dev>, dwarves@vger.kernel.org,
        Nick Alcock
 <nick.alcock@oracle.com>,
        Kate Carcia <kcarcia@redhat.com>,
        "Jose E.
 Marchesi" <jose.marchesi@oracle.com>
Subject: Re: [RFC 0/4] BTF archive with unmodified pahole+toolchain
References: <20250807182538.136498-1-acme@kernel.org>
	<CAADnVQ+cvvHN9CunLP03yRFKz2YJirmF0j80-fZ0A-8aVVopPg@mail.gmail.com>
	<CA+JHD92DODDESCfwiiCs_ZQ5bGesK5NC+xe5EvONF5g+-Bg+9Q@mail.gmail.com>
	<CAADnVQLr=-E1isAGDH1+U9h4Dta7hgzi==9SnWpKpCWtHQxa5g@mail.gmail.com>
	<7F061596-C814-42DA-AD6A-F766B21A188A@gmail.com>
Emacs: no job too big... no job.
Date: Fri, 08 Aug 2025 15:45:24 +0100
In-Reply-To: <7F061596-C814-42DA-AD6A-F766B21A188A@gmail.com> (Arnaldo
	Carvalho de Melo's message of "Fri, 08 Aug 2025 00:25:46 -0300")
Message-ID: <87bjopj2ij.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO0P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::6) To PH3PPFA3184E4F2.namprd10.prod.outlook.com
 (2603:10b6:518:1::7bb)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFA3184E4F2:EE_|SA1PR10MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b19924-68ca-43f5-b19f-08ddd68a3893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bi8xZk1kUmZTcThtVDRvV2NNTU8xaWwzYnN3L2x1bDF1Q0Vkd3hFMDRoQVEz?=
 =?utf-8?B?VXRiN09GN2pBbjBFQTh6WEdKalJXYnNnOGFya3c3ejkrNHhtNEdQcFYvQnBQ?=
 =?utf-8?B?bXNzQ1FPMGhLQkpHeUg5TGNvMmUvTnJJdWlGY0g5YlY4NnBOUmpqVHkwc3pm?=
 =?utf-8?B?NkpYUEg1aUtTUzZLQmJHTUZUQ1B2Z0NlTEt6ZHk5SUx1aFZ1VmZSdmN0Q0s3?=
 =?utf-8?B?VjZpTzhuWWhtUngxeVpqYzgvRFZhZEdxODJNamd6ZmR1eUV5WXhJcC9XeWVn?=
 =?utf-8?B?YnJudllPWFU1aEU1WGh6RWxyb2VBS2J2aHo3S1BMdHBmQW50bkhXK1hBcVhL?=
 =?utf-8?B?UEN0T0sycTF6a29qN3FxYjdmSEkyZHZxVzVSaDAwblRuTzB0a1VqaFNtSjYx?=
 =?utf-8?B?QWcyeGt4dFcxOXlqaU9EdFdJOUx1MHpXWnZDalpFTDZ4ajJ5L0wzTFlBRHZp?=
 =?utf-8?B?VDdNSlE1aVBtVlgrNjdlK2c1NmxTMnNIQzhnd3k4dXFienBuMmtnSlNJYjNB?=
 =?utf-8?B?dlBVaTYrNDc1dVZQY04vY0Z6ejRjK2tvU21zTHZHVzNBU3hQVXh4VUsrb0Rl?=
 =?utf-8?B?VmxvYmpkcG1TclVRdE5SV2pSaitPazJtaC9RMXI2YXVhcDlHYlBNcGY3NExo?=
 =?utf-8?B?QmdUTUNMNWVwaGt3ZUk0ZWRFbm5mM3ZqS0RxVDJCQ1llM3ZObCtwYUlJNlV0?=
 =?utf-8?B?czlFcFN3VklDdUNEUlorM2dFN0pNUUxrNXAxS1ByZElQdjMwaWlUZnl5VVdW?=
 =?utf-8?B?R1YvWHZJTUhZRnBjbDhWZEJibzlLN0FTdGg0K1hQenpJTkE4Wk5tbGJCM0V2?=
 =?utf-8?B?MzUwanpZVDlMS0Jra1FOQlJqOGc1NFc3TnNvbE15STFHUEZOaXZHQm5GVTRZ?=
 =?utf-8?B?UjBNY1RISWt4SVFlQ2ZWTjlMbTAwTUh4YmZRdnl5NkE4VnFvZG8yTlhJSG0v?=
 =?utf-8?B?UHhZaUVaUXJ3TjVFZURnTlRjNFJ4OWhTL1p2QjdqM0Q0T1ZXL0ltOUZNNkFX?=
 =?utf-8?B?RWEwaG9HaWw5WDY0dzNsL1NEYVk3WDRUVXdJMGFTbE1SUm55OTVSSVpGRVda?=
 =?utf-8?B?eTl5MEN1SDhqVUVRbjZJak1RR0Rxa1hYWGlrRUFjMUNET1F5UjZmRjVVK0Jw?=
 =?utf-8?B?Rzc5ZkIzWHRWbEJ4SWMvKzZVOG03Y1hsbjUwd0diYWcreVN1MExIanNPVndS?=
 =?utf-8?B?ek9xNzhlUUhqbFV3U1lzamRPS1AyazlkenZIcXlDbEJjb255cnowaWVJNDkw?=
 =?utf-8?B?VGZyMHNPR2tsSHhLSHdwZm9tVmxzSng2dXpBVXcrRGw2bUIzRndSdUR2K21Z?=
 =?utf-8?B?aHRMeXdFekRvU0JTRFZMcGhsZXN3b2xIWk5pQTVRRm8rSy84Zk5ZTUpCS3FM?=
 =?utf-8?B?UDFGRXJyMUZORS9yM1F2TGd3VXdxbzgwc0ZCZ3RrOGU5ZWo5M09MU0kzY24v?=
 =?utf-8?B?L1dlMys0WjU5aEpFZkc5NmtNRjB6UFZ2QnQ3blZobWN6Yis3Q204UjdrSDl2?=
 =?utf-8?B?YnJzWEU4cGZGNm1JVFdhcTUzcG83VlZWa25PNkNvcHFKM3ZDbUNDcGp2ZkxH?=
 =?utf-8?B?aDc5YjJWcE1GYzlja2N3bWJXeTd6VUNkNGFHaEliQ2I1cVJTWVcreUFJNEpP?=
 =?utf-8?B?UkhYaThVNmZIQ1gvSk1oamd2WXVFaVNOejdGUURudFdTNnRzcWZha0RVNUdu?=
 =?utf-8?B?T1NYeHBKbi8ydi94Y1VhaFk0Q3ZyeStPSE53YzhrVjBaWHpWU01qeWRKMWE1?=
 =?utf-8?B?VXJIcmpuNGN1bW9hZzdsN3VZWWZaK2xYRXV6LzZLYU1aUXBiZ1VsR0x1UWYx?=
 =?utf-8?B?ak51Wks0L3JvQ1dMdEJ4c1lKWVRIQ280T1NCSy94T1N4YWRUNG0zeUdTMm43?=
 =?utf-8?B?OW1JQ0pWSkJPMlBjRlNRdDdrNXIxbXlJMithanhBNUZtOTB0R2pDcGQwTlM5?=
 =?utf-8?Q?VezVIfDTnuw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPFA3184E4F2.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0NZcG1LeDVxdnZhU2s2Nzhsbm42VWhCUnJSUWc0U21IZzlLOGNyVjMyL3R4?=
 =?utf-8?B?N3h6WG5adjRMTFpCbUpmRFVjblEwUkNxL1kvVmJKRjR2TkxhT3JVaGxvalFC?=
 =?utf-8?B?eGRHcEc5c1FxNkN2bDRmSmZXWTVVa0I1dE55S3h6bVRJbTY4MElKQVVXV3g1?=
 =?utf-8?B?cHhXckpJeW5IdXc1TW1SN2hHWlBYMUpaWHcrZE1NWHQwUVlwVnQvQmtUNXVY?=
 =?utf-8?B?dk5WdGt3QWVDelRqZ3RMaVFNVzVoaHl2b3o3enpxa2JBTDA2VWQ5MHNDTnpH?=
 =?utf-8?B?MDRUdTNIU0hGZXVybXVFVkhackZVSUVPMmZoT3JRNjQ4MHM1bU5SQmFvc1dj?=
 =?utf-8?B?R3dyT29nNzRzd2pHMDg0Q0lCd1h3MGNpRDFDQVBRQ2tFL256UDBFai84RHQ3?=
 =?utf-8?B?d0ltVUJrUkprQm9kSjgzR2Raa3NEN0FaS0FCckYxaW9nSmh3VVN2QU42KzBa?=
 =?utf-8?B?TVFRVUxQTjN1WEJvZUNHWWZZQkl2QTUzNGg2amZ3b0Q5MEdnWGdPb3hxeXVh?=
 =?utf-8?B?Y1BkVHpZTlA3MHdzd2RVUEdNMTViNXU2cDBJbFRIdUZPR0xjV2J5VFZBN3FN?=
 =?utf-8?B?NldXSnRLUGhhelFLdmliU0FpMHpaamNHQzJCeVBSYTNFWDVYa3ZSQ0t5RVU2?=
 =?utf-8?B?LzRjd1FuT3IvRmtwS01BNjduQ3Q1OWdjbGlOeWlOKzh4VVFhTFpNWE9oTWdv?=
 =?utf-8?B?cHNPKzN4RmhEaHJDUU0za2pudWdmSi9kOVI0YjdzakNVMmFRRXhGZ0RzQldN?=
 =?utf-8?B?SDV2TmRMZVdlMU1VK29DLzZjVlZkVTBHS1ptbS9SQ05MWVJHaWFWNjRZWWtn?=
 =?utf-8?B?VWMyV3lSYU8ycWpPajVDYmlPa0t1SENBUS82NjQ1QWFPSUtPNVZxbWkwRFRT?=
 =?utf-8?B?ODJuYTUrTmQrSzg0SEtEWTZHZEl1azZlbit0WGM4T3hzeFZ0ay8wTXpYVkFq?=
 =?utf-8?B?a2haZXRYbkdSRHpXTC9KemJWMTZvdGM5VzBPbVVidTNjM2xSWXRZMmpIaHZu?=
 =?utf-8?B?am1QN1VlaDdzOEpTcDBpK3MvNk1iajFxaFRBL3VwZFZnZ0RsQnNsREEydlUy?=
 =?utf-8?B?Q0ZMTEk5NGdtTDF2YllsTmt2a1VpcXIrVFhjSFdHbmZjRXJkRW9iM1Z6Y2Mz?=
 =?utf-8?B?ZmhieDZpSm1KdDFBdXZKRU0xRjJsRVArbTZ3bTlIMUZnTTQxbVJjcE04ZHgv?=
 =?utf-8?B?V3A0QSt3Y3Vqbnh5dnd0bUtibjlzSzBGUFBoR2c3by9JMkcyN0dBMjZUYk5l?=
 =?utf-8?B?L1d1UlJYTG9yaitub0hSb1pWNXVJeWk3VkJlYnVjdEV3Y0RuZ3JzWDhEZTNz?=
 =?utf-8?B?QlUrSDhzc1pLdCs3Uy8xUjAzajBpcmlLRGIrY0hVdjhYUHlWNllGaVBwbkdD?=
 =?utf-8?B?OGJYaDQ1UE5QM1NYNzA3bThoMlI4Ty9tL0NtUkFycHZlTVZJdSt2Ny9leWo4?=
 =?utf-8?B?bVlYOE9qYmdQdlJuNi8yUzVhakM3M1poSWpzVnp6cEtrWVNTRmRkRFh3UWNJ?=
 =?utf-8?B?NGFDNm5PRTFXV09tckhpd0ZoT0lLaWhVclFTWUE2RVptVTVrTDVGWUx1bDJ5?=
 =?utf-8?B?UDY0b0l2MXd6dUJnVnE3ZFJQVWdCVk1tbkU4K1BiUDRTK1BjWEFQejRKakIv?=
 =?utf-8?B?OXdVMHJ5WUtCWnRmbUFjcVV1MTZWdkdIZVM2TGxPVGd0OG1LaStWOC85QVZ1?=
 =?utf-8?B?MnJQMHR0OWZ1MWh2NFhhbGdSZ01qbVYxQmdKajczOTJsdjdRM25mSldhR0JO?=
 =?utf-8?B?bys4eHdRK2IrTnh0SkdZMjR2UUlOemtjbUI3SksrUGVkdEtNS2xnc3hBTDhk?=
 =?utf-8?B?d0FVUWxkeUo3amQ4dE14aXVrNXZpZ05JNnIwY2lGUm40M0FibzE0ZFovUW1y?=
 =?utf-8?B?ZVFtVWNWeVptVTJDNmN3emUzcVc1b3hNVFkxa2V1S2U5YlU5MHRyQ2VGQWND?=
 =?utf-8?B?TE8wK0p0VEdmdEUzaEsvSy9YMnJuWjJkQ0F3VVpFZnBoZk01TzJVQjdHQ2V0?=
 =?utf-8?B?dUljWXNXT1ROV3VtNStxNGdhUVUrbVJpdU80VGw5cWJOd0N6MWJMZ3ZYSFh1?=
 =?utf-8?B?eC91b09JY3ZKNm5Vd2xTUENIa1lDMnFmbitPazVWamxncmluZ3Nzb2QzV3ly?=
 =?utf-8?B?clpLekplYTNibnVIcGwxZTJiUTlRejNBSjFNaVJXRGUyRjUyNmF0UGo2Qm10?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	noK4417nYmYeui78E++U4BfVEVVtGnl7OgRXRiZYv1ZseVuF4AWE5RaengrerxuQVcIZoN3bxpcJHEsaxlOezj7Gba1jdvRDNa5kMBMb/tbRrVxH4/kpn3yxBrmpIQsuLBY0T1F7bkYYaB9JMdAtp/0O0G4kBByPUgjqd7mqcGMnaZ7swJm7C2cM++cRV27hTvlhTFkMzuk0FHSutLhUTHYqQ4F/BERERrbEghu64o0QV2fPc8LsHV2hZA5q9N6DOnIhPkzTFhCmZkoMVMrMEd4KHU923mZFuEg/HcBa4/plxwpNWCizXzD8YY2IyK4Z7gUsrK2iwEGH+oJnhvUbP+6sFgVBaYKlzBTp6+EV2pxDEtdpaqDBL/QTobKZ+e7gDW4Gake9tQa41pAWfnRgkVudeW5+JdwduBsd4ZTo3vY081ZJeJiwQ3+AECe32KlQ7ztIEd3ztHubBZ9hnFRrcHwuLUbB6n7edqyJkJSRe814anlyEl52gZf2uHJfKBqHvyfKGpmWFGArJJjtswONZ4QKP9PHO0be0IYn9/311AbA4t9os8skKeROU6P6O7LP+iZLH/iqhwAjUnXNVJxznAkxn3i10uMCL1lkX1UUUnc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b19924-68ca-43f5-b19f-08ddd68a3893
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFA3184E4F2.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 14:45:30.4077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ioznJ+QKDAuiTm7vBDU2HdbQg36Yk28cvMhF4yRL5EIjvXvUIgueO/VwIln708TvLM4IeTpUHy53pKdidgKwSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508080119
X-Proofpoint-ORIG-GUID: chneP5zYHePxtlyhXxfBnaRzNT-7GaOZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDExOSBTYWx0ZWRfX37fRYCc3rVyl
 Gr+zELJJYRmKlOBZQcOfaXHA+Uj7Z4e6FXTwj5LMAU0Apcu28fk4khWZamUeCvswIqqupfizsgN
 TXryejV3qOmoNvVU8t1s5JwMATrP9Q2lI+pFclzUm0HDh0a21yVlQwDIkcVh73953zDgwze0+j6
 h24xRV/jc3v4xkWXaOZsaidin2/5OcOK9oRVbF7dN+CGBTNfYHuKaoCKpxZreHc0f5PE1FvP96d
 3hffsPhjJL2o0fhPkF9DWYZQAylHCvOP0piNPbPdja3YbstRg4ByWeBnIqsR2arsFa/bXhJFtK9
 ZbL4/Mn9FeMgQtBDt4aGCTZzo4D7ZiKp2/NYVP4aHmVNO+0XTgX/R7WPx+lmNc6N6EwUdJ4uqOV
 iV8YlnwprcG70kW7D6o2uKP03XhVPjNsUQLYJWc75FSOOpeHNbsJkEiHjb0p9/H3g4QibVrw
X-Authority-Analysis: v=2.4 cv=dobbC0g4 c=1 sm=1 tr=0 ts=68960d8e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=vbyJIY8eAAAA:8
 a=pGLkceISAAAA:8 a=SmM0FeT10rj5ZlpAxSUA:9 a=QEXdDO2ut3YA:10
 a=UXyj_mcEdvtx2GLQwyJ1:22
X-Proofpoint-GUID: chneP5zYHePxtlyhXxfBnaRzNT-7GaOZ

On 8 Aug 2025, Arnaldo Carvalho de Melo said:

> On August 7, 2025 11:52:51 PM GMT-03:00, Alexei Starovoitov <alexei.staro=
voitov@gmail.com> wrote:
>>On Thu, Aug 7, 2025 at 7:36=E2=80=AFPM Arnaldo Carvalho de Melo <arnaldo.=
melo@gmail.com> wrote:
>
>>> On Thu, Aug 7, 2025, 11:09=E2=80=AFPM Alexei Starovoitov <alexei.starov=
oitov@gmail.com> wrote:
>
>>Agree with that as well, but I'm just not easy about "BTF archives" :)
>>The name is too ambitious. Concatenated BTF sections is fine,
>>but let's not make a big deal out of it.
>
> Well, other proposals being discussed would add more metadata to
> traverse these archives, I was just tagging along on the jargon being
> created :-)

We don't actually need *much* more. I think concatenation is less than
ideal simply because it's hard to tell when to stop looking for more
archive members in a concatenated stream.

In the model Jose proposed (more or less the model split BTF is
basically already using), the first member is special, being the parent
and holding most of the shared types, vmlinux etc. Because it's special,
I think we want to be able to identify it even if you, say, take two
sections full of concatenated members and concatenate *them*. Just
relying on straight concat would have all the tools treating the second
vmlinux in that concatenated stream as if it were a module! If there was
a link field (or just a "stop here" bit), it could say "there are no
more members" reliably, or you could ask tools to hunt through
concatenated streams of BTF and tell you which ones in that stream look
like they're vmlinuxes (and all the non-vmlinuxes after those are
modules).

e.g. if you accidentally concatenated

vmlinux -> a -> b -> c

and

vmlinux -> d -> e -> f

You would get

vmlinux -> a -> b -> c -> vmlinux -> d -> e -> f

and it would be nice if the format could at least *tell* that the second
vmlinux *was* a vmlinux without relying on awful hacks like "oh it
contains basic integer or mm types, it must be vmlinux". We can do that
with a link field, or with one single bit saying "stop here", or with a
bit saying "this is the parent, start here". I don't mind which.

We could also do with a single field (long-existing in CTF, which calls
it "cuname") which lets you tell the source of types in different BTF
members. The first, the vmlinux/shared one, is easily identifiable, it's
first: but all the others need to be told apart somehow. Since each
corresponds to a module (in vmlinux) or a compilation unit containing
conflicted types (in userspace CTF), giving it *some* sort of optional
name field in the header seems necessary. I don't really mind what we
call the field: cuname, btf_name, member_name, file_name, anything.

> It was just convenient that an unmodified linker was concatenating
> everything and that from the existing BTF headers I could use a
> preexisting libbpf API, btf__add_btf() merge everything to then use
> another preexisting API, btf__dedup() to get to the same end result.

Yeah.

> I don't see, so far, any other use for a "BTF archive", only as a
> happy intermediate step from a one line change to the kernel to get
> the linker to have the BTF "Compile Units" put together in the same
> order as the DWARF ones for the final merge+dedup.

We use them in userspace. (I think I can converge enough, without BTF
format changes beyond this one, to completely eliminate .ctf in
userspace and just let us use BTF everywhere: but as described in
https://lore.kernel.org/dwarves/87bjpkmak2.fsf@esperi.org.uk/, the BTF
we're using will usually be archives of BTF stuck into a single ELF
section, whether we use a link field or concatenation or some weird
archive format like I used to, it's going to be multiple BTFs-full in a
great many programs).

--=20
NULL && (void)

