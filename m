Return-Path: <bpf+bounces-47835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7436CA007C1
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 11:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416DA1642E4
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 10:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC89E1C878E;
	Fri,  3 Jan 2025 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FFhgXd0n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wSxklP7V"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DF81F8EEB
	for <bpf@vger.kernel.org>; Fri,  3 Jan 2025 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735899476; cv=fail; b=Pd7g6kn+qzJ6REkkWBY6OB66WnHZTuR3Egc4CGSXvtIjjNK1kPNCfvCjG0Q/S5mH8BBXy7yC8dNDFcQaq9ZpYTYSIsY712Cjf0GWrGoN3iDlN9ut+B6yyDVqZ5ORVb6akA179nSR97P5QDLQxDLwsunwALb3Y17M/PqerQG0VN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735899476; c=relaxed/simple;
	bh=GIy6ArI5b3/1bb+7Ryc1ajQIC+5jAUjfS/KTi/8mrAE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=JgndIT/Fz1FO/xj1bS8CMyZIAMopRMiQa8VVGdDkcu1fSe0Xq/LcXaPPx+TkC0tO5aLcX1Ih2ChaxvWoQKwlYesSu/3zlRw2HUj2Wqz4KFcqk5pTv8bPf6cJrWP3h1EDShjiyMzsQDSXgCo53g5J7XiXV/G4p/rtNwbS6d7R63U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FFhgXd0n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wSxklP7V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5032NVRV028801;
	Fri, 3 Jan 2025 10:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RGXFHCqLHA2jCT4VntjWFG7J9vGWe2+bwL/0LwJ+m9E=; b=
	FFhgXd0n1btqlF8NJGuoSsFoC2N3cL1yib5UPlNwtqhXRyltSKlB4BI0zAcveo6R
	r07WI/0scH4iaS2rwIbsHfpC6OJSzS+4QMLKYvoT7TH+cgOLeDtcfZMhPG1BfyeT
	zVf6o6dGwcNN9bpooHAgCYcnUOibhHJayC2JOL7Rgiu4HtR2PxXv+2UvPzmGkkNd
	Z1UuyQv/KhhFIGp0vdkP5RfppTOIlVhKRdtDU2ygSVzfY60B2qAtMosGS1kxtQbi
	mOx+0lqa+S3QH7jjcntQEih/lJCOCmZUYM+IfYhFsfDE9xdZJo8Vph4n36AfpwZH
	LS7iQXK8EYB1kIx2VDGPQA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t9vt7vvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 10:17:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50381bRd027878;
	Fri, 3 Jan 2025 10:17:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43vry2m2q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 10:17:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGVzwOtXQTlnS8pq8JpzKgrqSvSICzyqwzb/sCsthyYwZHXFD9ztvD/Adx/kX8lEIekH1ELCqWYsDThJ4nUJSYTadrAJwqQ5P59pv1GpQArnn8ZjaIelVKHT9y19wELfQfPFAVFLwvGmQg3FxLbLO7DvKtXedsZ/YGrSLMcaobGiPdRIrodF0d9pkjgLvjP4h2ISvk1ZpTsqYNgf25PE9VTCCh8uIFVTlodjIBO8wjn/2sHoIHziH76UqEUpnXGgSbtSKircnzPyw4CC9S8IQPaKrP1POML3ThasppwVmrJEf5lrJsl1dU2hjO+hgkc0wlM+OuAdW0ydNyQCindwmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGXFHCqLHA2jCT4VntjWFG7J9vGWe2+bwL/0LwJ+m9E=;
 b=WhKkP/mPVxezILgE4U52LNGqLTEkvhS9bltNntzQlpxN64aFe+DPBon56KkAKDk5rBuxMm+lrcgGVdNv9sRUpg30Hk5uG4IPlpbvC7MpNzZoW7sALbmJwxXCmmM5Q+mR3e/JsQMMo4sD+KOGm6TY3BwgPhKIb2gSdpceA8uMwhdwhVEBpbVpsd1zRJEeEceMiGrGs2qM4bR897OdFHzBBBx6ZXcwoizO4UwFxctBZdbR5aJMHwSdFUsK+C+K7488OqcIcErGb2uq9w9sH55nbIbeKEOgCX2+052itc6NEYKDsVnWGMyJgUncf/tJfSlOvU+ZViwZy2tNLiFZwx5xzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGXFHCqLHA2jCT4VntjWFG7J9vGWe2+bwL/0LwJ+m9E=;
 b=wSxklP7VtLvKTWt+GPf+pfe7WuwgCrV27zdHocf4Mfl474OU3FlosUyuT+U0/SxmkBPIycqPYDZcyUfQIxLbJ53Y2josAv4Ez2rFMzCCVUPuVcxHqh+B4PCA3+lZHlNGt5RyEC5+ctzUicINA4JhmCS7VHLzKRf8Xrz8O7WhTbk=
Received: from LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6)
 by IA1PR10MB7238.namprd10.prod.outlook.com (2603:10b6:208:3f6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Fri, 3 Jan
 2025 10:17:16 +0000
Received: from LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e]) by LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e%4]) with mapi id 15.20.8293.000; Fri, 3 Jan 2025
 10:17:16 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, "gcc@gcc.gnu.org"
 <gcc@gcc.gnu.org>,
        Cupertino Miranda <cupertino.miranda@oracle.com>,
        David Faust <david.faust@oracle.com>,
        Elena Zannoni
 <elena.zannoni@oracle.com>,
        Alexei Starovoitov
 <alexei.starovoitov@gmail.com>,
        Manu Bretelle <chantra@meta.com>, Mykola
 Lysenko <mykolal@meta.com>,
        Yonghong Song <yonghong.song@linux.dev>, bpf
 <bpf@vger.kernel.org>
Subject: Re: Errors compiling BPF programs from Linux selftests/bpf with GCC
In-Reply-To: <4accd577b1486fb8074e7913c3e81d76174ad3d6.camel@gmail.com>
	(Eduard Zingerman's message of "Thu, 02 Jan 2025 16:46:27 -0800")
References: <ZryncitpWOFICUSCu4HLsMIZ7zOuiH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLotteNbQ9I=@pm.me>
	<87jzbdim3j.fsf@oracle.com>
	<64d8a1a7037c9bf1057799c04f2d5bb6bdad3bad.camel@gmail.com>
	<87v7uw21lj.fsf@oracle.com>
	<4accd577b1486fb8074e7913c3e81d76174ad3d6.camel@gmail.com>
Date: Fri, 03 Jan 2025 11:17:13 +0100
Message-ID: <87pll4xkuu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0286.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::13) To LV8PR10MB7822.namprd10.prod.outlook.com
 (2603:10b6:408:1e8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7822:EE_|IA1PR10MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: 0318b696-369f-4cc3-95c4-08dd2bdfcc8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVBEbGttWS8ybUN1ZXBxeUVuSUZpaFYxRTZTb2JKREE0TUZNN3htaTNwVXBl?=
 =?utf-8?B?K21vcHptWHpoakJZdmsvNklJYnJFS1Fodlc1QkxtenU1TE1rTCs5czg0NG4v?=
 =?utf-8?B?UGlCQkNKSkZYSjFycmdaM3RmN0RuQXFXQlBmYUdKSHdJSThHREh1VFNMNjUx?=
 =?utf-8?B?eEF6RHZjZGU3N0grSkdMVWRTQlYvM2tSSjVpZEVzbTdHS1E3bGNSMS9LWU5u?=
 =?utf-8?B?TVF2M2NKNG1TMExQVTdOYmFwWm1oV2diSEJKbWpLUDFUZXF1bnRXdjR1Ykph?=
 =?utf-8?B?bVYyT2lUbXBjdkttbkVNdnFEZnBoaDRmY25YOWVwUm5CUHBuWmxQQ3BRK3Nr?=
 =?utf-8?B?eHZvUHdxVExXNUJMNkJxSmhpZUJXTlFxNE9NekRjOVBJdlRPWDB4QWNraGg2?=
 =?utf-8?B?OWw3bWd3ekg2OVd1K042Tnd2NnJzY2tNRnY0S0xCbHU5bmJLdCt0NGVwR0pa?=
 =?utf-8?B?UkdQZnIzYW5peGwrbjRJTTJ0SHdLeklaZGxreTlkR3VOQVphVHNuNzZWNnNN?=
 =?utf-8?B?SWlpVGVTRmx5QmVWZ2NKcE1Ja1hOSkVZOEtHUThsdTRya1o4cEtlRUJCOGpD?=
 =?utf-8?B?NWdxSkhMbWNXbVJEK3lmUFpvSTdDeE01RUFha2pINk1wYk9mT0dydTZwZUd4?=
 =?utf-8?B?ZUtuRWtYSTliNWZ6R3JzbXdPRnR5ZE4xdjNZOTAwalJqakl3RFE5OHNzNVph?=
 =?utf-8?B?Y1ZIbk9jbERJSUs2RitycUJwK1lsZzJKeHlWbmx2dFhpdGhtbkpXaGE2U0ZM?=
 =?utf-8?B?Q1p3SG5LNGdBRG8zMnZiRnJSMGgzOUN4NHBaTUlEblJoaGEvYkJhRjFjUGxK?=
 =?utf-8?B?WVdyQk4zcmR1SSt1K0VIMFNyWDBxbHRHV21GdWpjYi9hNWs2V3hNUWVhb1c1?=
 =?utf-8?B?NnF0cnNORkZCVmxCK25CVkFOM0lLRnRLSkFnSmdpQmhZZkJtVTE0RlQvTzln?=
 =?utf-8?B?bUZqMWRTRTJqb0toRmxobHNFOC9oeHRFVTFuMXRqdTZzb1kvV2dxZU1iekFr?=
 =?utf-8?B?NVBBRTdQNlJqRlFnREJVdm9HekVqWmQ1Q0VqaGEvcWE4Q2hvY2FTa1VqaHJR?=
 =?utf-8?B?cHl1N0dJYnZaVG1Nc0ZGUWVCa0tuUjBPRm1iMTFST1Yvc04rbk1wN3p1NmZP?=
 =?utf-8?B?dW9ybzVBc1RsOTlONjFQVVkvZXBJYmg2NmNOVmdGV2ROKzdDM0hhellvdWQz?=
 =?utf-8?B?L3hadUdoZ1FuV3YrVm12QUxkUUxTVzkwekxjZVlsWU1WcEpBS1NTOGhKMVVD?=
 =?utf-8?B?eC9INWJZVFh2MHhHSFB1aHoxMTVEYXg2S0M3NzNwUktZZE9XbkRabXoyRkxL?=
 =?utf-8?B?RzYwbE53SlNQQmpIQkJIbW9MWUFoS0JweXM0QW5DcG9uNis4aFdyN0tYUCs5?=
 =?utf-8?B?SmVUVTVib2hPRVI0TlphaVFXTzllWWFTNW1FVDVhbWN4VXhlR3Nic25oNm9Z?=
 =?utf-8?B?U2Y3QlpaNnIrenBMNGx1YWdyQklTVzNrWjNvQjFyK1hRTGZmdDd6Z0NPWG93?=
 =?utf-8?B?S2MweGJjT1ZPOXYxUGc5M3QxeWJLR3UwWkc5dFM2eDhtZy9wcm9mYmhzc2ta?=
 =?utf-8?B?R0x1alpiMzkxZFlBQWs1UXdma0pleWRFQjl0dk5TL250dEZ0QVhNdjlNVGpS?=
 =?utf-8?B?T0JDUTZQVFVDOVo4TldpZktuSnQ1YzNKdDROUTlzYnBqbFJobkF4K29tb3Rz?=
 =?utf-8?B?aVNHNDMwckFUWWJ1OExHWjB0eDBrUkFrR0NyMXlKNXRuZGxnM1FGd1RpVUxN?=
 =?utf-8?B?Mk1IUXRsVVpIeEhWK2x5TUFrU0xuQmhwdGxDUzBUMlVUNXdETitWOGx3MEw3?=
 =?utf-8?B?QlRTS2xRZWxxRGN6NENMb3J3VHE4Rk0yTzZHbnZmT3ptRFNCN1k0L0hXa0VE?=
 =?utf-8?Q?1kH6Zb9+NwQzM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEpvd3Q4MHRrcklDMHprb0Z1dzhYbUF1SVV6Z0NDRTZtVjZyMnVQYWFEOE9O?=
 =?utf-8?B?bzlVOTM5L0x0V3ZnaXhtZVUxNVhJUUUxU01tUy9ocnF4eTF4aU9xQUgzM2dW?=
 =?utf-8?B?UEw0bTZPY1FpMUttWW5oTnpGNUkrcW1Ba1UwOEg2OCtianJkeFRwMWl1YkRI?=
 =?utf-8?B?TE9pL3pyTmpaU1V1SVZWK1U3SXFsQVZ1Vk1kRjZQMUFvMi9KdDZZYTN4UVIy?=
 =?utf-8?B?MGJ4U3hPUk9zUko5ZW9ZVlVQeFZidnJPL3o2aEoySFRDUUxWRlR2N1FPdlht?=
 =?utf-8?B?MHF4d2IxTXNSL0FKS3dBUjdrQUVxRmtGN01OSytXTjA0MFFqcnJ2L1JpWEMz?=
 =?utf-8?B?aU9OeksvaDlFQkoxamc0S1cwYVRHK1dZbEZwQmZCZ1MvUXR1eS9rWHNZMzhx?=
 =?utf-8?B?Znd1MFJUV3MyQWhNK1VGQ1ZpY0hTaTV3RFNuTThuek9QK0VVTzBhZkRUdERr?=
 =?utf-8?B?c20xL1BwY1lybUZLS1VJQ1ZHNzNkYlU2YmJFNjlEVUJLVTkvNHAzWDF6c0lX?=
 =?utf-8?B?Q1BNdVZpSDlCMnl0eUJKNFRNYkNPOWtxVFdBUGIveVZyVVA4NGMxSDc3UjRy?=
 =?utf-8?B?U1A4cnh5TVdZSW9NbnRYS1MxTXdycW5qc2lJc0NhT01vTUZDenhwbDA4YXNw?=
 =?utf-8?B?RW42YzFSdmNmRlQ2aFRTbGVFcGtFeUdoTXB3c2lYeld1N2FxYzdQS1IwVVZE?=
 =?utf-8?B?NHhUbmV2L1VudkZoOGIyMVF4c1BZRmllSFVDTUErSk91L3N2TGRhN3pzZWM4?=
 =?utf-8?B?SlZjWXdKcUcvN2c0L3FRU1pKTCtKRjhqd1VMVFVob2JJNWJ3VUhUVXBQUmZQ?=
 =?utf-8?B?M3Ywb1hzQ0kvajM3M1h6MXFWL0JiNGFnS1VHT2hFb01IdHFnODAyMXFSaGo1?=
 =?utf-8?B?YjRpV21vbkRWZVRxank4R0kxNHkwMFF1angram1KeWRDZGp5bXVDbVlQYzB4?=
 =?utf-8?B?V0E0VjNrUkRBWUlwYUxyek1FdGxUWStabmNoMk11RUlKN0RtSkdxSzVVTzNy?=
 =?utf-8?B?VkpEb25SZ2ticnFGL054UFdpWTlDRXBxd0N2alJWdUtNUXNzV3NJNytCK2Va?=
 =?utf-8?B?MFVOR3BYVld4cnNUZ0RmN2EySkpkT2d3aDFLWVdYUjh2YlpIeGhhbEVCNENG?=
 =?utf-8?B?bFhsdEtGSmlxR0hDU2dRcHUwNS9PbGJFSm9GUGp1dGhvWUU1WkhieHh4d2lT?=
 =?utf-8?B?djJDV3RCakhob1ErRFdSUWlJVFFiRGlmVGoyWnpTeS9NYVE1ZTlJVHhBeXR3?=
 =?utf-8?B?YjAwSzNaNG0vR0hxTUp6bWprdFJqMVUyb0h0TU5XbU1jT3M4S2VWRXJxSU5q?=
 =?utf-8?B?SjBHNENuNTByN2g1RHZjOWRmRnoyekV4L3RMSVdyVHl2WkE5SUdrYlVJWXkr?=
 =?utf-8?B?SnFxcDRNOWlMTHJaWHFaSGlPS2JqNnRhNTh1b0NYak1idU0wR3RJRWoweWJh?=
 =?utf-8?B?dGJEaHZBYXRtR3NkdjdxbXFYeHVReFhJemYwQWZHUUF0N0d1azJ0WTgvb1I3?=
 =?utf-8?B?THIvVUdWNm85Ty9LTk9nY09hVk5ZeGJGZitxKy9QaExPY2F0aXE5bEVTNFRO?=
 =?utf-8?B?ck9rcitEQkZzYUd1VnhGbWZyanRzZnRuUGtEU0tSVW5TTGtIN3NWcFU1VUJz?=
 =?utf-8?B?Z2t3akw4WHh6L1EydHJ5WHFOM0RFN1luR1JHSDFycmdNQTR5VUNXMkFobGRN?=
 =?utf-8?B?NVBkM08ybTNKbTZDVURISFJpNUpja2tiWnY2Nm9uRmxFTk82RWk3a2FyTGtl?=
 =?utf-8?B?RUt1ZFY1TlNvR3dhWUpDNEZKcGJLc2lBMzhmVjFDeTBPZDRvQlJWQ3Jjdmxx?=
 =?utf-8?B?azlNc3NHb0ZJUUxaNEhTRlJjRmpLQnNpU3F6cENBbDlIZ042em40eGJxVVNj?=
 =?utf-8?B?Y29TZGppdzV2dGN1ZnkzWVY4V2FFVUFVcmI0SWlVNnhKdEJRNVJTOFF3YVVr?=
 =?utf-8?B?dWI5WFNqc1gxS3c3Y3Btdy8xcjRydEJ2cFZ5MDdNTEtjQmcxRVJmclhoazU0?=
 =?utf-8?B?TnlmcE9HZDVqWkJXbjNFQVlLMGVGNlBoSFp4alhxdTZvdTcrK2JlM1VZaWRy?=
 =?utf-8?B?dzJZZ29HVUJ2UlFndXJOd3J3Q08wNldWTzVYN0hQdERSbHBKV1hTYVZoL0d6?=
 =?utf-8?B?Z0ljMXZqbnZ2WHpzVFF5eWl6TXpNREJrT2taMW5LVjd4QUM5WHJxTDkvSTNL?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0YzecmG8wTP4kWKuTIHDk1DsLAUW2hNodtzKJRj+lO3jjWgQTzS3tO7f5do9s+Y/0As3nK/0WDhj4oamwI2nTpeQEzIzRo/xB7Qe+E12DpSDWiIfZTjBvNJ3kzKAAYMM6hDnTcR2eH0kwllXWsgXUZrzqaIfGRjvj74nfPltM2BEe6s9P1dUor78RcSW/901WhrrB3OoPpEp6T1B4RnDUVAa3B/kEO8/SoYid4+4DoPuSkQY/YckIEXgcapro6YV4W8FYCuEhX+aEVL86ZpgYMuvoI19AeNNUrDi8bj3SKuIaSH6Tc5J7c8x9Ct+JpjYuiQaBu0IrkcEKa++tywl5MylLwTZucUu8oJmZleQoVk40rujN0UmjdW6LBqmlFrItw8eOHekoScQOcuTq3agy8qUXWaiWq+dVdEaffaviaMQZ1nefW13vWYhz3ihqj1te1+6GVmln+C5YOjXQIZ/OQ1/4hppdWiZrw+C0s97tVKAIFoXphSeBl3qJj5E0mbnYdF2IGZqJ0kKVohj/CT5dnuoH7IXIaBu+URjkBSy7t2qNduxhnYrrMtuv/c7pzi3GgCUCNyp0ZVkrT2Xr4ryZjAwho76LgwjPmzN8DkRZyU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0318b696-369f-4cc3-95c4-08dd2bdfcc8c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 10:17:16.7483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdKzggUaZ0Zct35zE11jatPF/uaw+dlENK5R1fasbrOW/PGeZsGadl01O7Fmac95b04gzEv26FV5kITUVTTNRfmExLlfN6oEfpHRZ1MtpLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7238
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 mlxlogscore=863 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501030089
X-Proofpoint-GUID: vB5sQgykoXgwRxkFotk-V6mCUJ6cE_8M
X-Proofpoint-ORIG-GUID: vB5sQgykoXgwRxkFotk-V6mCUJ6cE_8M


> On Fri, 2025-01-03 at 01:16 +0100, Jose E. Marchesi wrote:
>
> [...]
>
>> Yes, in the GCC BPF backend we are using
>>=20
>> =C2=A0=C2=A0use_gcc_stdint=3Dprovide
>>=20
>> which makes GCC to provide the version of stdint.h that assumes
>> freestanding ("baremetal") mode.  If we changed it to use
>>=20
>> =C2=A0=C2=A0use_gcc_stdint=3Dwrap
>>=20
>> then it would install a stdint.h that does somethins similar to what
>> clang does, at least in hosts providing C99 headers (note the lack of
>> __has_include_next):
>>=20
>> =C2=A0=C2=A0#ifndef _GCC_WRAP_STDINT_H
>> =C2=A0=C2=A0#if __STDC_HOSTED__
>> =C2=A0=C2=A0# if defined __cplusplus && __cplusplus >=3D 201103L
>> =C2=A0=C2=A0#  undef __STDC_LIMIT_MACROS
>> =C2=A0=C2=A0#  define __STDC_LIMIT_MACROS
>> =C2=A0=C2=A0#  undef __STDC_CONSTANT_MACROS
>> =C2=A0=C2=A0#  define __STDC_CONSTANT_MACROS
>> =C2=A0=C2=A0# endif
>> =C2=A0=C2=A0#pragma GCC diagnostic push
>> =C2=A0=C2=A0#pragma GCC diagnostic ignored "-Wpedantic" // include_next
>> =C2=A0=C2=A0# include_next <stdint.h>
>> =C2=A0=C2=A0#pragma GCC diagnostic pop
>> =C2=A0=C2=A0#else
>> =C2=A0=C2=A0# include "stdint-gcc.h"
>> =C2=A0=C2=A0#endif
>> =C2=A0=C2=A0#define _GCC_WRAP_STDINT_H
>> =C2=A0=C2=A0#endif
>>=20
>> We could switch to "wrap" to align with clang, but in that case it would
>> be up to the user to provide a "host" stdint.h that contains sensible
>> definitions for BPF.  The kernel selftests, for example, would need to
>> do so to avoid including /usr/include/stdint.h that more likely than not
>> will provide incorrect definitions for int64_t and friends...
>
> Would it be possible to push a branch that uses '=3Dwrap' thing
> somewhere?  So that it could be further tested to see if there are
> more issues with selftests.

No need.  After reflecting a bit I can't see why the requirements on the
"host" stdint.h must be different for BPF than for any other target: its
contents must match the expectations of the compiler for the arch.  If
it doesn't... well, it is not the responsibility of the compiler to
assure that.  I will install a patch to switch to the wrapper stdint.h.

