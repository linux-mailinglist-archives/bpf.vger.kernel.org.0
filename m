Return-Path: <bpf+bounces-71201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C95CEBE907E
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 15:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C00EB624E3A
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 13:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4600234AB09;
	Fri, 17 Oct 2025 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DmDDtKdU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xzt+levS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5053F331A60
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760708929; cv=fail; b=PDcDW/Y28aog+ldFuUVnpvVPoKO+sR50aJZIxErU3GG67WbCdKXffqb+La2W7BtOBwSzsWmlhm+bpWB/lz7GM6Gcvw3pEzQJc6+1Ynfwfz3g4BctrMne1fB1eLvZknaknA+QJvVESb4aPg2svmJpQze4cR1T8xxI2Q3kMX2K5cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760708929; c=relaxed/simple;
	bh=KvNi/F/bdPcE9ubqF8C5Q4hfgs5CoMNvO7a+K06CwxU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TJOUuujGO+8TZ0svTiH5QV/Val4sey+mu4bqUjaSHMnpDKecZ4238Q2xe4o1fc1PvylbqgnVZ3jHGmWFD9l/l5LUo6Chva8ShmuVqQVOla8RpOXw+1CbFdxFVcXUV0Hr2RzOtcSnnjMXkfZZ0UqsmNldIDthqIXCO69HTQX3DrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DmDDtKdU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xzt+levS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HCdkpi006580;
	Fri, 17 Oct 2025 13:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OkXEo9xTjqz5cnnShk+/UJJpM076+4lsiWSrCjY1tlo=; b=
	DmDDtKdU4mLZV2uO4Z/6B8KisZQM4i0HIMWpfwYy1XSA21mRNN9qdJmMuYpHg3oj
	+IM4vf9RmP7qnphEA2R3UFkbtqNsPEl+DqjMzqQkUCqHnPmJginU64CPKRMF1vCh
	49BcfuxwDIGpU3sGfQZEYtjfXqARuP3S1skmyj4+MFSCAJvv5jwv5tmYl1i7K+By
	NtYWSLcJDZwHn18cAfW/rIiiYThHzOtkl7C5q1L0thRiXR7vAwadUarIeIyrADh0
	tzbSlEMbHPCIIwpQQenl1WJsNClbwXupOCkt9PRILV0ly2ip6pP/dIWWkmWT4tqD
	LL5wcgdzXDzLZasHVl3E0w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdtyu0qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 13:48:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59HC8kFT000697;
	Fri, 17 Oct 2025 13:48:19 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpd3pju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 13:48:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rc5jvLDYL/ZOutjLmSpNhM02bGlk9AcbU804Z9y56L1C9Ma66D/ULSN3/Pjpf6MT9AqcDdGcVe4QrA5U61YPrrYxfNCvCDzzZGA1cOpALw2fidor/khjhj3FWpMffV+yBct9ZgGOV3cZJPLtguHFyNdD9aZuJU3r9EV0bHbLn2rlmzBV4QeKagRqDdojnReSG7+Lu0+eaWIot836YFxrxDODrkpwLq4ax6a9HI7UuoYkT4hC1L55xcot05LGq7Hl8ktbku/20bIInzIrUg42Xr9o+EviNUBgukzCHRv9MWFS/PLhoKim3NiJAlnGdptkZTS0A9QLHLKpZEwc5I1uiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkXEo9xTjqz5cnnShk+/UJJpM076+4lsiWSrCjY1tlo=;
 b=Sy368QiLyfmFA1qwdkQu6+/b1kwKHSL0mjuGsGzjZFmauWNjCdIGe/HGi/wnsT7LjE2Z49lWIpgGZiPHrQ96aKC2NI+j6bbCyYKhU4MHrReAOZ+KdgHuBLGJhnLWs1ktZ1qbQSa4xhX7CMxWpS4WsoXuD+nW5GCcwxvOwkqmtRmwXGto09FVXmZOY78cl2O3B8SBL018hDe4g6SZPOa7v2PXWLQXqzryCP8JaAT1D1lEqjYcmXyhpdjU162f4Sn8OPMQDGvFpOmZvsE796s8pDsmsTMGOlaq/yT8zy67Sa3FjZttKmZlMWsnP5xg6WPYL1xm+9Xexxw5r7v3b4JVVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkXEo9xTjqz5cnnShk+/UJJpM076+4lsiWSrCjY1tlo=;
 b=Xzt+levSpAyG6UgL7ldqEHRUZNiQVWb3OD8peer3g53K6YdIhmdX0xbju/Lve5HdHG3cVMdHfcirIwotLfA+GfWFMR8Pn6SrurVjDrObA+nAN+5L923EmLI3a+ZjvqkhrU6V/YPbREL1aQWg1guTHrKlWV+ifAoV5qCpn9nUuYA=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CY8PR10MB7171.namprd10.prod.outlook.com (2603:10b6:930:75::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.12; Fri, 17 Oct 2025 13:48:06 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 13:48:06 +0000
Message-ID: <b8c6d85e-e593-4909-9add-68ddec01c863@oracle.com>
Date: Fri, 17 Oct 2025 14:47:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 06/15] bpftool: Handle multi-split BTF by
 supporting multiple base BTFs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <20251008173512.731801-7-alan.maguire@oracle.com>
 <CAEf4BzYMsLc+BHHEOg7iXj_DqCMoj1WR_gBk_8MYUdd1+WnpKQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzYMsLc+BHHEOg7iXj_DqCMoj1WR_gBk_8MYUdd1+WnpKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::10) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CY8PR10MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: e07adb8d-8c49-4256-621f-08de0d83ccb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1QwdUt3OFJEK1gvNWtpUGVQYU5SSG5MNUVkWkRWLzdtL2p5U3V3K3pWbk50?=
 =?utf-8?B?dlJmeWZweHRxTUVFaDYvbVIxN1dUQU5GNWRIV050ZHZLQkMzeFNYYXdPUHBK?=
 =?utf-8?B?TmxaS3pSK0R1K0svaXVwUTZsVDdJVHFLSDhkRTQ5UzRaSDREd2V3TjM1V3Q0?=
 =?utf-8?B?dzZXRFNHc05WL0FPTnRORTN2UWh1c3hvd202K0Y0aFNXNkdoUC83cHhoUWFM?=
 =?utf-8?B?V0FIY2M3Um1vWjlwSCswT0xrQ0ZmU0YrN0dsdnRYQUxvTGpoR01jOGt1OS9o?=
 =?utf-8?B?REdWSmZyTHRvMHRGNFlRcjhZZGR3V1NJVmVLVXR6Q2xnREFabGQyb0ZYYVYx?=
 =?utf-8?B?QmVMNEkvSTJRUVg0MjE2cHJNbUQwQnREQVV6WU9DVFVWd1lvdURTQzJnbGM4?=
 =?utf-8?B?MURCWFBsZ08rT0JndzJsbDNPa0FTRDNkZ0F1Rzg4aXZhcktCcTRQYVlKRTlV?=
 =?utf-8?B?TDFuTkZXVSs3dXRpNTFJTW9aRERndGhmem5Rb0t4L3dNNUVmYTkzVisyYU9B?=
 =?utf-8?B?ZlZnQWJDWlBmcUZYaTJZUGp0SUpHaEVrRFpMTHdIQ2FvQkZtRkZaUDR3WEFR?=
 =?utf-8?B?ZWUvbHlDckJSU3pKeEJmMkViajBJYWFtVDFvdVpncXVwTGZkOE03MFN4d1ZE?=
 =?utf-8?B?elFLaE1jOVVOakxLWTNweEhZditlNnFxcnRaZnpuWkRHbVFrOW5Mei9iUm50?=
 =?utf-8?B?YjVhUTZ0VUlna3JvdWZEa3VYNklFTlNIejZkb1NXdFNURnhRR21sclJrdjAr?=
 =?utf-8?B?Y1NJWFkwZnRaVU1DWkd4ZXJwN0JmM3dobjR5Z295T1o4TlZoSkxsVDZadlI0?=
 =?utf-8?B?TzhQSkFPM2FzMXpocmFjcWRoNkNKaVZ3WE80RUVOdnV4dm1ZWXRTUklJSmhz?=
 =?utf-8?B?MHpYNGRIN3RSNkZiOGlRMDdZYURHaThiUmZlZW5Uc1pOOFpHUy9MVkI4WjYv?=
 =?utf-8?B?S0taMzU1Tng0dytjU3FnbFgwRG51NDdNMHVoZFlqcWZhT2MvVlI4VEhwSDZo?=
 =?utf-8?B?aU1QQ0wzUW9LaVlOSGRZSDVWRksyQmI3MkFSYkVwNENJZjdCRkFHalB0Y1VL?=
 =?utf-8?B?c2sxVjVkSnIvNXA0ZEZqSVBTN1RYRlMwZDJWTTFVYnVDZGMzdTBHMmRnSlhH?=
 =?utf-8?B?eDVDZ01oSEQwWmRhMGpXSFBRNTJJa2pQSEtQajNKamFoSU9JVjRnWFo1Y1VE?=
 =?utf-8?B?bWE4UmxYVTVvY2pvaURtSXhrK1o0VS9XaVlpbTc3M2Q5dXhzeVVhQWYvcStx?=
 =?utf-8?B?TGtUcTk5QkxLRkRaUFFMSTl1QXNFV01hZ3Baa1prL3d6WGtWQ1FBM0t2L2Rz?=
 =?utf-8?B?b2xSc2ZVLytJSFNBYzFPTTFGZERTUXRDSUI1c0VhS0FUd3d1UGtnVW1nN1d5?=
 =?utf-8?B?YUwwbDJrMEtvWUVjVGMraEROdm5lN1l6KzBJWlZBYW9lNEpTbE56SEl0VUF2?=
 =?utf-8?B?QmpEaGZKVHJzMWhpbXhUNUhlNGlwTFhJWHpNR2NEdXcvNmJyL2xVMndlT0Ux?=
 =?utf-8?B?c2dqODNwRjZEbnVWQmg0VkM3T0dkQndibGJ5d2Vhaks5OVlYWkZQV0FhV0Z5?=
 =?utf-8?B?Nm9xbVo1YVZpRHNITzZ1c045Nmk4eGlBRG1EUGhGd1ZkbEgwTkVRMmVIdjQx?=
 =?utf-8?B?S09RYnNQRGZwRGZSVnZGRXZtNVJsTTNPbUJDdm5WditkRDV0Z0NWd2JBdFdq?=
 =?utf-8?B?clphUWRrMmlCMVRwQS9ZZmZWT3ErZWgxTHpqRTNNZGxZQmhPVW80anVVWFR4?=
 =?utf-8?B?Ny80MTdrb0VhRzRERmZZbCtzMU9Eb1RFL21Rb1l5eStWTkNPZEdtN2F2cU5L?=
 =?utf-8?B?MERoWVp3eUZqU3JPaG1xb1hVWTY0M2dqTDR6WS90ZnAwT0F0M3psbWRJbHlu?=
 =?utf-8?B?eWlaZndNWmYydG92Z0EwK0ljREdlZWRFK0UxZmd6NHZ4NlIyZHNFRUNZSU5j?=
 =?utf-8?Q?GNs483MNkKQNuApHbSHrgNFyL4L724HX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFFmSFpVdUloc0dVbGxMUDFwKzkwampzOGxWZm9nYmR1YmJuWGhMbTdSbHRM?=
 =?utf-8?B?TmlzL3MwZEJMT21ETlFDRHZGeUJ5aUg5WitGK1BZWjFydFc1U0wvWFVqL3BS?=
 =?utf-8?B?a1VZWlptZGlQaDIycUpQWVZDL2JLU0xEclYrTFN5TXJsYllEaWpBUkl2ZGls?=
 =?utf-8?B?NHFmNHFuRzhtRjFRbVI5QXJobXFSdW52dTFhdlFmbmlMcjVZYmdTZ1FpOUg4?=
 =?utf-8?B?elhqcXhTUno5RTZReVNxZzg4MWd2aG5IN1VkbU5DaUcvaEFQR2tzemFldnN0?=
 =?utf-8?B?d3lXYmZyMitObmpVbkF2T05hMFlrZGs1ZWZMZlVKMko2S1lGUGxHQTFDdWps?=
 =?utf-8?B?UTVNU3pPc2pwdjNVV2YwbW5qZ1QrMUtvamZoY2dZUEtpK2hPRTg2NEFTVjdh?=
 =?utf-8?B?Q1YvNWxaVGN1eHN3eU9wZjRxVm9jdkpmbmJGaytQck96V0F6Z0JxbUhyQUQ0?=
 =?utf-8?B?SzFXUzBqcktjZEwvZU5lNHNGL0EvUWNUNmdGL2hQNGtjUW5MUkluMzZMUXl1?=
 =?utf-8?B?bDBON25sTzBGRk5mMXBERjZYTUxIZys2VktnYWpIazJvQkNFblEwSE9yckZM?=
 =?utf-8?B?QzE4MUxDaktWOHlRS2Q5VUVvckdkSXBLTlJHUXRwR0JFMDBqcUpGWE1haXQ2?=
 =?utf-8?B?YzFnTVRNSG9GRENNS201MFBwV1grZmNMK3NRaWJDc2pUcHNLLzVnMW1Od09x?=
 =?utf-8?B?S01xVTNjR1UvOTZrellxOVllQXVlUVdZVURNZUJDWG9GWnI1R3Z2TG83aGJl?=
 =?utf-8?B?SGV4aXg5cjRZT2JUYTFoY3NRZUNsU3d0c2UzclVwb2d6aWxzdjNJcmM4Z1k2?=
 =?utf-8?B?aERmS00yN2JzTUlmMkl5WEM4MG5PR1FRcEFBUjkyZE16amN4ZW91d3Y3bzhI?=
 =?utf-8?B?Mk04cTVEVWorT0oxSHZ5ZWNHbm1lZWFuTTEwWVBQOU1Bc3pjK2xsRzBoOWpy?=
 =?utf-8?B?VXpaWmVSLzFrc2IzcVUrUVNHdW9FUTExRWFSZlBaRmhYaXZtSDVONHcwQzlC?=
 =?utf-8?B?Rzc1MUhpVWRmMTNxd1BDTnJMY2t1S3dtd0ZzVTUyVkdCbUhPazRINS85SVBr?=
 =?utf-8?B?MVZEZjc3U21pLzJ4YzFyeTlCYUJId2RTcTRrdlBoaDV3akcrcTZRaHFOUWxy?=
 =?utf-8?B?alNvT3JlN3ZERitQU09keDFKcUgvM050NTFScFVIanNiOUwwb2g5amN6a3RF?=
 =?utf-8?B?OGhiYlovcWprUjZxU0hRWEZMaWdjY3VobzlEcERTazRBMFNyZXFSeExKVVlQ?=
 =?utf-8?B?cHp6ZlNEcmpCVjcyUXVNVGppRjhuTURGeFA4VDZaZlRhVDFMYlhBaGhDRHJF?=
 =?utf-8?B?SU1kVDM5WmxiRDRNZ3R2d0k0dHFRQzlQSEhYU1djZ2FDUEdZbVVFYzBzL3lD?=
 =?utf-8?B?aHBLYzkrd0RkZlZZcHdyODljV2RBOTNPUEdiT2NiYWE2RkNwZGI3R3IyNGox?=
 =?utf-8?B?KzFtbkdxV09WU3ZlOUJreTZ6Ky9hdjVwd3VQY3BXZTFHYmV1MUtlK043V2tm?=
 =?utf-8?B?Umc1cGU2aGNBUzVtQmJuK2t2OU0rQjRMYWN2VmcxS2UvcUhFVUZXSmVlWlNh?=
 =?utf-8?B?bTdKUDEvOCtpVjNPRkkxRDROWDFHWGIvSFc5SFNzckMvM0lhZU1aWWVYK2R5?=
 =?utf-8?B?dTBPT3pFaGdoRlhtREd1clVKSm1MTWs5cW1CZ243am42TjNvOVVIQVg5cU5l?=
 =?utf-8?B?bHc2ckYzRHNuek5aTnBCSEVlditqUWJSRURaSlZmVVl5Z3ZXZmpGMkZ1V3FE?=
 =?utf-8?B?OXJQb1orbUw4Q1pPZWJKTmh3VzJ6ekNHRnpENGJhUFhsUzlqb3hVYk5vcGdx?=
 =?utf-8?B?Tzh5TEtYQzZyc1BtTDVyVVhsSlNibDRIc3J0dWszd2VKdGJyZjNFT2k5YWZD?=
 =?utf-8?B?WFROUWR6L0gxMnhqbVZndGJOcEZuRmVvR3dLTERic2hSSWMzLzBVTUdEQ2Rj?=
 =?utf-8?B?SnlxWEh0bFA2b3kxYUZhWUNBd1dOdVBtSFgrTXQvaVMwM29VekVDY1RtRmNy?=
 =?utf-8?B?WEJqZ200SHB6bXJuY2ZjOVdkRVIzallxSnBtaXVZV0Nkbm9mYytNV2cvWEg0?=
 =?utf-8?B?em4vOHR4bC94YTJreWFYdXZjMnJQUnhpLy9ROHFyS0NMQ00yazN2L0hibXZv?=
 =?utf-8?B?d01pZTRpK1J2ZkViZHQzQ2prSFQ5eFR6T1hTYTZDZUJRMWpDV1JCcXA2QkpL?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T4wBcOUMNkKDKPHh5cvu5jA3GoFzkWcWKUuJblHfKvYzjt6mNwCWkDtoBGfpHd66jxGEQli8Yk+XTsJhFFsYl97H4HGQw5fmQK4A+/+Ht2jTTuB6Dyxns03QS+ZTRSnhCC6tzpCkPCedqXe5mFzlfjIJ3VdITvmhA/K6SkA3uEncgR9I1kYF3ClWp6rzBcyi9es+VwgJ2MBRSkvpjyYVKMyI6ZZyASCLHLoV3p424IGbNZYZCEpArZuljO2EZCN3wMxqB1iNf6EzFOcAR/cJJ+ROADj1Xd3M9iT44mF/Y27K/Kkha5JNUwnuHxzTZISivks5F6evCWZYI7hQRkJg9VMfG6g6XTLP7+JY+nphvk4r/OaRZOf5HHT7i74gy4CzWDDNZS9QqrGFTowHtFGWCxQ6/xnfcwQ+mg4GEZ+T+pIQdrfLF93qVU4dMaOfs4AaETDeEk/NdBqbulLwO+ZsWmg3mfAj4QICHrzecqWBqZ+SpwjouEbIc3XBIVvsn4JPp9NhIkt2OlQYWNjLd+NHD4lwbdpAIDqQ7MnU5PE2CwxoGxGCjQFEOcBKL4WSMJByCl8CrJbuerP/vjw7A2/7XcRsljLPCfCsx+ke2wWBVlA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07adb8d-8c49-4256-621f-08de0d83ccb4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 13:48:06.3338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmcHltKNE0SxFQLLnMDWD066Gh+SFIvUQmWA6skEr01s/eGFmX14Y4RN7a7CHoH6n3Lt9FpW8+ogpd+gf6V79g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510170102
X-Proofpoint-GUID: u7QGdWKEcF7rU4xeqxlwkGONy2lbipkH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNyBTYWx0ZWRfX1hsA35/vx9Yh
 VegZ1kEpmthtgKAbsr2dzN0kvfYph5TO7H+aBMA+h8hsvQJd0Ge8S2fveyLn2NsIG7qVlRGmbq6
 gDmY2/6bzX85lvRwkFZqlKitpxvF4HCh2XM837e4B/pBRa3kZjKUJ685SzwDgW+xMXHVLfAK2Jn
 jRB26/xnv+Ybo45KtKgOaiK0OSeZ7vR1UCZZr/rsQdnmHkq4n4ur4//z2arjBgOOAEBWdDcT4l3
 Be3itkfoLJqccA3eEosDFy+dZBFi9vgC7ro01OiGOlL4UPhYY6MKr8MM65jUtUigdoNdMBzLDe/
 0F24arDmA1D5519EUOsPe8oliQsRJKrPnC0/fxeEZDkuk1S3/VlhXgaJMTgIy6S2S6MuF9cqnRP
 u1V+R5JUaLEDM+S7HmMa+iZ4xYlNyQ==
X-Authority-Analysis: v=2.4 cv=OolCCi/t c=1 sm=1 tr=0 ts=68f24924 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=527d6MHusW6bfAtwWrUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: u7QGdWKEcF7rU4xeqxlwkGONy2lbipkH

On 16/10/2025 19:36, Andrii Nakryiko wrote:
> On Wed, Oct 8, 2025 at 10:35 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> For bpftool to be able to dump .BTF.extra data in /sys/kernel/btf_extra
>> for modules, it needs to support multi-split BTF because the
>> parent-child relationship of BTF extra data for modules is
>>
>> vmlinux BTF data
>>         module BTF data
>>                 module BTF extra data
>>
>> So for example to dump BTF extra info for xfs we would run
>>
>> $ bpftool btf dump -B /sys/kernel/btf/vmlinux -B /sys/kernel/btf/xfs file /sys/kernel/btf_extra/xfs
>>
>> Multiple bases are specified with the vmlinux base BTF first (parent)
>> followed by the xfs BTF (child), and finally the XFS BTF extra.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/bpf/bpftool/main.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
> 
> we'll need to update documentation to mention that order of -B matters
> and how it is treated
>

yep, good point, I'll add a documentation patch in the next round.

> 
>> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
>> index a829a6a49037..aa16560b4157 100644
>> --- a/tools/bpf/bpftool/main.c
>> +++ b/tools/bpf/bpftool/main.c
>> @@ -514,7 +514,8 @@ int main(int argc, char **argv)
>>                         verifier_logs = true;
>>                         break;
>>                 case 'B':
>> -                       base_btf = btf__parse(optarg, NULL);
>> +                       /* handle multi-split BTF */
>> +                       base_btf = btf__parse_split(optarg, base_btf);
>>                         if (!base_btf) {
>>                                 p_err("failed to parse base BTF at '%s': %d\n",
>>                                       optarg, -errno);
>> --
>> 2.39.3
>>


