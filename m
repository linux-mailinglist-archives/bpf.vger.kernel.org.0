Return-Path: <bpf+bounces-49617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8737FA1ACA6
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 23:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 100277A2F6A
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 22:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BD41D14E2;
	Thu, 23 Jan 2025 22:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kwvNcTbC"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86571B0F2F;
	Thu, 23 Jan 2025 22:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737671212; cv=fail; b=b/oemW+qhJeyDUcpxk+1OcGbZp8BKnH9GYjnP+rvgGryQtLFet5EOBLJOqe7CWfFNlxi4li4GivN0mCcLY9BOM8rs5PHY1hxrEaAxIr+m2g2d3EMaSZ1UEmk2BSGyBKGfL1wGqffqkOYmQGr4L7lfZTvD4+O5CYXVw4cM4Tdi64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737671212; c=relaxed/simple;
	bh=Ab0G8XgsoTLxm5BiNaUb+fzycQbwOyKVuw1NBgdxTa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XJAFm0AnjX5GINgpg1TOc+i5kGopJXrg3PgKljwNRaxzL5lmPtDQiJUiuSaSc5BDqiF+2MQzx+QbRJzhwNYFA8fB1h2CRHoiGT/GzZM+HBgJeo3pibWqdpz3shJlVXqJ6/ypKyxrf4+qPegf2uDHOp7R+ApymySX5+f2JLQJ7rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kwvNcTbC; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNbNAPtfIUfODMjfX49maZxdeIUf1J7UEphtSQoGxhxL13zqrNSMOhYzwjZIOAiO6Cl2zbO6leUK5ZvXdXwM0pGfY2mExWyk1puifOnKi6LfeRan1fXeury9mbjcyg1EUOCDId/HmeXouEjSs1LhJM1Ktx20LFBvxCOrjSfRGnOd903DYTEqLoSaUlSC9agKfKAE77oCKtVefsCVOpIS8PFg1LWswmiMaE2tNkhd8FlpN8kAwYxJfCcnEzqA+G4/8rj8l8/tiVDW/zkXUz0EC5HzIW519WmrIqShHBBidfo0P1gfJbT4VJRS6MGHNZn22j7IgxbWYlBSZxCcuFvrDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEYWmz+XEmtdY93WIwJ93iwJEZZl4aXugddWx9Grtck=;
 b=cUtElsb8+627423xyX5d+iCBxgN3QiYm+I4E+7SS1aYo6/mSMFZcYGA2WUhrdy/laR72JXMrcmPQIuFLwUJZJcaqWrRCms/0YIUxvlUEWFfghsOlVYWNkfetbGxi6qVu/sbtKrVPP7fBLjAfdTUPLMCXHTepQMgMUJnpjV6lM2OOAwe5kGhFkSK4ZSd8wk0aJ5QFTk0BYUnumgs9l5T/dSfyJphgBn3h4MAYoxgof3O1KPAsG0euDkF6T6HWv40Ho28kDHE7EWTHgUl207mcQLf7Av+6fRSkfhd7Gtz9svjyh4K0AeytVDPXfaJrxnxe3Cj/p5bCO6H9KQZjeFpTjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEYWmz+XEmtdY93WIwJ93iwJEZZl4aXugddWx9Grtck=;
 b=kwvNcTbCdlrTZ8CcrkB81EVihaaS2ut3kGzlJzlDCMnqKuDQNWS/8AU8DuT0R9spRMDq9BRz5fp4iQ4Mq0KzVBIXgbDyO4Gh8bFjZ8WL2AWJcW+PfgmX+UMjD+p4U/OehdCRmu8Is/9P+gTsKFWcrVfowx+/6EDr4vlG2DBzcZq53YjHGpO3CZfBkNQHuixMvKmFCN6yHdqLo2w6ztIioQbNNo/Yy8WRsAFHd6ekjDo/q/XAyvcBKxO9gdYAsGi+Na0SOmS5EmwuFRZZm5UB6kgbNvPrOq6kuK/tawTt+E/Z/qpFPBqX086nqoAfANebQ4CUPqeWALVeaPbanCRqZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB7787.namprd12.prod.outlook.com (2603:10b6:806:347::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 22:26:41 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 22:26:41 +0000
Date: Thu, 23 Jan 2025 23:26:37 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, sched-ext@meta.com,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH sched_ext/for-6.13-fixes] sched_ext: Fix dsq_local_on
 selftest
Message-ID: <Z5LCHVHZPl2fjPyc@gpd3>
References: <HdoCQccNk3GZdnPx5w1vuAfOMMgtWeUgrUhn_e8B-hyRrWoOPakTGcoI3Q4-QmK_44msuvivoRUykxxeB82uR-S3enkmFaQl2t6Zgu-Nq6Y=@pm.me>
 <Z2MV001RfiG7DNqj@slm.duckdns.org>
 <ouIylyHgXTVZ9RiyVeHZ26YXQLKMEKHoOVPWIgpWRDD2FL2RDwwUEocaj4LMpMR3PjbwpPuxEnJAjMeD4e7LnWIAYvIbGC5BPvPGtzyumYk=@pm.me>
 <Z2tNK2oFDX1OPp8C@slm.duckdns.org>
 <QHB1r-3fBPQIaDS8iz26J-zoMbn3O6VLlwlZP1NQdkMzlQTsCX_xrfTPBoGt6SQOGgtg6vN7aXles4CndepTvjIVQ7bVXDBrvPaiRH5R8tc=@pm.me>
 <Z5BMkyJ8I7cth1GH@slm.duckdns.org>
 <m94EAn-xiPWJ1dRFTqcm6urBNNOPza94BmyYvp_5ti06uAZF0Izg2mBC9rpbc3PEfWWvDf7UyDt1x_2gB-7y3esTH3f54s05QBxcTXh4YhQ=@pm.me>
 <Z5IOpOD9cs2fLaIg@gpd3>
 <Z5J1Ft2YwSRpedzx@slm.duckdns.org>
 <Z5KOLqwLq96HjkwH@gpd3>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5KOLqwLq96HjkwH@gpd3>
X-ClientProxiedBy: FR4P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::16) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: b13f59e7-c438-426f-1e9e-08dd3bfd0266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWc2Zm9MVk9Ka3dEQnBHdWpFTk1iU3A1QVFoUU5KRzR4Y2RBUVRUT1JWdElF?=
 =?utf-8?B?cVlOM3Z2SDhNblFoTS8wN3FUZ213bG01WXJSdU0xM0FmVjZWbDQ4Y3hSc3dR?=
 =?utf-8?B?Z0RnbHBodU12dXJrUTBFN1dKRG1ibmFuRkxMWXBxdHZVOXFwV3VvRUE5WUg5?=
 =?utf-8?B?eFU4VnZZenliMFRBL2ZSb2Z2WEliTzVkL1M2TzMzSHgyTkxMdmFhcVdsUGk2?=
 =?utf-8?B?MmpQUGNvd0dycCsyRmpaamdZczhZTVZ5ekgzc2RIVm80eCtYVTlTMFk5dFRu?=
 =?utf-8?B?NU50WWJzaGdoWHlCaVZJTXAxcEFNa1ZFS1pHZnNrdjlzalB3eHJnT0szTTkw?=
 =?utf-8?B?M3Nudk5SalNUZWZ5ajNmVFZwOHluSGxCREk5NE4vbXhPSHIrM3FUeVE4Mnl4?=
 =?utf-8?B?alN3QjQrQmMyai9kVElkWTFxc2lEVEVNem5VTDFJSXBaR3h0bVM5ejR0dzFU?=
 =?utf-8?B?RlJpaFR2Zkp0VWVFV1lhbWEvbUszOVNWRmlMNGlGT3VyaHNSNDRURFhiZFBm?=
 =?utf-8?B?Ti9wZlc3Nkkvc0RHZnNQUW5iUG9uM0wxMUlNUWFFb1JaekRPeGVSd3NOcXpp?=
 =?utf-8?B?U2o1ZEpzb0I5R3JWWElXQkVhbkJURzdQSzJQeTgzbnZRQnQwaUtMV2ZRdWht?=
 =?utf-8?B?b2xzaHNLelNzRnVQYTJvMXJ1R2pLMkhNSXhHTGtPcG5GR2gxUVowTDltWStk?=
 =?utf-8?B?KzNYaThvNkhDbVc0d0NrdDFBanVqOFNVVm04MllvK040UExzOWQ2YUNBbXhB?=
 =?utf-8?B?VHVGcWtsTEhSRDRyQTBrNTdXL0kveE1SaThRUTlVcnQxZmVCc1VCSkRkZlJV?=
 =?utf-8?B?V1lFVnYrUmRCaHBkVFhuSDAybFZvdEt5b2poSTVRaWkyRnEwL2R6Y29XeUVL?=
 =?utf-8?B?TnZnQlBXMTk4RzNrNDRJaXhmMkQxaDlndGttTlZmK242SmlHbFpxWXRnaUlk?=
 =?utf-8?B?dFVoSUJWTUdXUEhzN3JnWHNQTnJlMkNUbHpJLzNvekRFQWgvTEVqVVJiQklM?=
 =?utf-8?B?Y1k3alREWTBiQm5NQXFOTWlFT3RLNUFZUTluaG9nSHFVWDIxMmJhNFExR2pB?=
 =?utf-8?B?Z1VGUkVTU3gzOTVuUWh3cjJ2V05ScUR1M3dBMGw3VEo4cW5UdVJuSkhkOU5a?=
 =?utf-8?B?aUVxTi84c1BBS0d2aTNrSXNXUzg1STNETFk4bzl0NEpuUDlSbk9Rd1hOckY5?=
 =?utf-8?B?Y2ZjVWQ4bjVwWWcrZWdVN2JyNTU3UVIwMEhhWS8zMmZVaHZ4RHdBS0ErZTlB?=
 =?utf-8?B?N1ZMWVZPUzNKK2tkZlBITFg1Qzl4WEVxMGdPMGg5bmZqNzY2STBqUmRiTEhs?=
 =?utf-8?B?Wi95Ky9VTHhjb0UzWnN5RmZjUkZWdkxqcWxnRUYwWmJkeG55dEkzTjhaM2FC?=
 =?utf-8?B?dFVqWXlBN1B2WVdod3NvR2diRWZDRExxSnVEWG41S2R5ZDdIZlJOemlYRFIz?=
 =?utf-8?B?MDZ6eGcxbFBkNnEvK2dJY3lSYmNUMklZMDBnWUxFeHo5Nk0vb1hiSUE0ZGQ5?=
 =?utf-8?B?b1R6MEt6QkQ2MUxRWlZ3SEYrMzgwNXFrRmErRG1FQ1MyeCs1MXdJeG05aCsz?=
 =?utf-8?B?ZUFYbUVMOUlaY29IUGZDelJ1bjlOQVk5a3NZTVIwMUxNRU9ncUI5alFrMUZV?=
 =?utf-8?B?YVRsS3VtTzZ0SnAvWFhIL01EaDY2TS8xNGoranNjbHhlVTQxdUh1cXZhYkcw?=
 =?utf-8?B?VXJ2Z3QvYVMwS0VMNk43UFRHSWg3SWswQkFEWTNoOWZORDhDMTY3Z1JMLytO?=
 =?utf-8?B?bFVRNU9LUGpDMTlqOTBuNkpZeWxGN05USDlJUzJMdEUwdkR0ZEI5L1lNSWp3?=
 =?utf-8?B?a0pVTU5KbTlGd3A2bWRYZTMrbVJlTGpzdnd5R1B1d0gyTzBNb2RvN3dJb3JI?=
 =?utf-8?Q?lJHtsF8NG+ocy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0lmekpPNWVEeDlJOTE4aDVFQ0Zhd1FtTjVhU01Rajh2RVRIbGtxY0dITjVJ?=
 =?utf-8?B?Rk9GMDhjUWQ5eVMxZkliNTlQK0lFd21CZm5VYmRVQzFxQldEc1dlMkpBRkNz?=
 =?utf-8?B?WThrL2hmUkVjNm1sNlU5bVIwTW01Vlg0NnhUUFVhbEUwNmM3elVuVnpJUExE?=
 =?utf-8?B?SVMxRS91VkFCcmw5VWJPaEV6TmV0NEdtN2NwY29mV2NvUiszWS9DMU5iUXM3?=
 =?utf-8?B?VEtXSnhpekJ3ek41WXBNS1FlN2F2cmxFT3YzVmg0c2g1R2duL3E3NUszR1dQ?=
 =?utf-8?B?K2RvYU5icDJJWkFGYStFc1N2cmtlOXNuZTFLR1dDRFpiWWVuRkIyNG90Z3RR?=
 =?utf-8?B?MkxmQ1Fid0VNbUZtMWZlb2NoVUZrTnFoNU9LbXNRSDhhSGZKYmtTamZZcDk3?=
 =?utf-8?B?TjlJVEc2ZTlZVEN6MG5wSXpmbXRyR0xaREF4TmdFMFpicjFmMzNIR2ZCZ0Fi?=
 =?utf-8?B?aVdHSWl5SVhvWk5pVjBWa2RCZzRSMVFpZUZVREZtSXd3NXpVMGFTbkhQR2Fz?=
 =?utf-8?B?TE1sbWM4RjROYXpmYnlFbWNhdmJ3RHFSbUNqRCthdnM2V3V3Z0tSVGdTUmJF?=
 =?utf-8?B?YzNZak5pYUQrQ0dpVDlVM05ienA0TnFGSW9TUS9nR2tPWkV3UGNoRkI1U05x?=
 =?utf-8?B?M3ZmMUZVT0c1clorb0s0c1hxQzNYcEp6NGFvRmpuWk1SZmVzVFNaZUZKUlFV?=
 =?utf-8?B?U1V4SkhMM3RVZURVNmdTWk5FTE5xQW1IcVJLYmw0Q0s0TUtpZXpJS0lhcWNQ?=
 =?utf-8?B?MzZDQjhPSWMzYnlsK1RzdUJhcXlwTlU5aHZXZzZDb2k2c1pMa3pGQ0w2WFJX?=
 =?utf-8?B?R1FQU2dCOUQwY1pnRE5KRnJ6RnIwUElDS2hGemxjQ2wwRWZpM3UvMHN4Q3BS?=
 =?utf-8?B?UDEwMWYvSTB3YXRlbkJWZjZHM213S0pzV0dmMXptdi9PVXRHWEtLaEFXN21M?=
 =?utf-8?B?SWVjaVd1UE1VQVNFY2tPeWZWNXEweDBLdnZKb2I3WkdPWndkQXc0bXREb0tV?=
 =?utf-8?B?SXQ2STU1cDR5alV6RTg4dGFPYks4Wlgxc3VPL0FoVDBrMlRhR3o2TkltMFd4?=
 =?utf-8?B?Q0xiZEhHeW5nNUEvTW50WU5NdHU1VmYvNEVNcEFyTjQ5NzRwMmlXWldGcHBo?=
 =?utf-8?B?c3lsWi9QdTFPR3ZWb0Q4Y1lkRUpGRG9wSWluWExheGRSOEVaTnRPSjdicWlp?=
 =?utf-8?B?cU5lU1o4K0QzYmdPcWlyYW8xRi9uRTIzejg5TE5PWHlUUjVsT2hLaGs1eWhW?=
 =?utf-8?B?QlNiNGM2SkFPVTMzcXhIMU8reG9tTGZGZkJoV0tFTFpvQVZGemV4UkRlTjhM?=
 =?utf-8?B?eFhzT1lTVXg3bzBGRzAzVkozbkN5aGY1WHI1UmNCdURIZU9HNDJjU0lsTWxG?=
 =?utf-8?B?TnFnMkpjSXlYOWNDN0o1V1phSkgyQlo4YTd5YkI3dE1sN0J0NnFaWlltckNz?=
 =?utf-8?B?NDU0eEFqRGYxWlZGSHZOVVcwMnhWSDZaZ3ZQYmdKNlRlaHA2cFIyZWFuTWhw?=
 =?utf-8?B?YVVLdzNNUU5xMm8rMTJTdzJpZWpqRVB0bnVLbnF3RFZWeVcxUjFtUmxLcThG?=
 =?utf-8?B?dmZIMis3SDRaRXppVzFaUERadmJXK0Y2RW9DWDhFbnJtSHJGQ3ppV3J2R080?=
 =?utf-8?B?b1Z3cGZvbXppSTNkOG05dkZkeE9Bak5nSTNVRzdwMWFXNjd2QTZtMjhoRXYz?=
 =?utf-8?B?MHMvNTdQOEhSbGhMK3B4Ny94M3VQeVk0bkhBZngzb2N6V21DYWZtVHg4MHpu?=
 =?utf-8?B?b0tXOU9xbTQwZ0RmZmoyTUhqNnA0QnZLb2JtaXk5VXRYOTVKNHgrS0NKeWlO?=
 =?utf-8?B?N2oxclVVcWs2a1BIRVJEcytJY1JPSzdmQkhUaDNEMndrTnl1UVNwRXNRMGJp?=
 =?utf-8?B?VzNJRXh3bWNVaFVsZmovOUFSM1MyNk01S2djWStCWlM5RlRwLzhOckZ1K1JY?=
 =?utf-8?B?NDZ1RXNiSWEzV1JuT2p5Z3d6YmNWMmFVMVh5MGQzWVdtY24vZkFKeUNrVXJk?=
 =?utf-8?B?K1hZVUdpSlZvQ2ZRWnBMVzhxajlZUnpwTnRFODFrR3VtelFRQzdROUxXelFm?=
 =?utf-8?B?QVFuekZKNVcrMUcyQmpsVi9pcUkvTUg4YnJRVmEzaElCL3hpN0Iwb1B2dWhw?=
 =?utf-8?Q?efFmsjrH53XNehnm3UJ5IWVsS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13f59e7-c438-426f-1e9e-08dd3bfd0266
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 22:26:41.0876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snV6Y/UvmN5qyhzoVmlrfc7HiIcf5u6SGngaZGO4ugZNsSFmImlnSTrVfWtgdBxAxwPnqtQYkyPNnPDqFROCNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7787

On Thu, Jan 23, 2025 at 07:45:08PM +0100, Andrea Righi wrote:
> On Thu, Jan 23, 2025 at 06:57:58AM -1000, Tejun Heo wrote:
> > On Thu, Jan 23, 2025 at 10:40:52AM +0100, Andrea Righi wrote:
> > > On Wed, Jan 22, 2025 at 07:10:00PM +0000, Ihor Solodrai wrote:
> > > > 
> > > > On Tuesday, January 21st, 2025 at 5:40 PM, Tejun Heo <tj@kernel.org> wrote:
> > > > 
> > > > > 
> > > > > 
> > > > > Hello, sorry about the delay.
> > > > > 
> > > > > On Wed, Jan 15, 2025 at 11:50:37PM +0000, Ihor Solodrai wrote:
> > > > > ...
> > > > > 
> > > > > > 2025-01-15T23:28:55.8238375Z [ 5.334631] sched_ext: BPF scheduler "dsp_local_on" disabled (runtime error)
> > > > > > 2025-01-15T23:28:55.8243034Z [ 5.335420] sched_ext: dsp_local_on: SCX_DSQ_LOCAL[_ON] verdict target cpu 1 not allowed for kworker/u8:1[33]
> > > > > 
> > > > > 
> > > > > That's a head scratcher. It's a single node 2 cpu instance and all unbound
> > > > > kworkers should be allowed on all CPUs. I'll update the test to test the
> > > > > actual cpumask but can you see whether this failure is consistent or flaky?
> > > > 
> > > > I re-ran all the jobs, and all sched_ext jobs have failed (3/3).
> > > > Previous time only 1 of 3 runs failed.
> > > > 
> > > > https://github.com/kernel-patches/vmtest/actions/runs/12798804552/job/36016405680
> > > 
> > > Oh I see what happens, SCX_DSQ_LOCAL_ON is (incorrectly) resolved to 0.
> > > 
> > > More exactly, none of the enum values are being resolved correctly, likely
> > > due to the CO:RE enum refactoring. There’s probably something broken in
> > > tools/testing/selftests/sched_ext/Makefile, I’ll take a look.
> > 
> > Yeah, we need to add SCX_ENUM_INIT() to each test. Will do that once the
> > pending pull request is merged. The original report is a separate issue tho.
> > I'm still a bit baffled by it.
> 
> For the enum part: https://lore.kernel.org/all/20250123124606.242115-1-arighi@nvidia.com/
> 
> And yeah, I missed that the original bug report was about the unbound
> kworker not allowed to be dispatched on cpu 1. Weird... I'm wondering if we
> need to do the cpumask_cnt / scx_bpf_dsq_cancel() game, like we did with
> scx_rustland to handle concurrent affinity changes, but in this case the
> kworker shouldn't have its affinity changed...

Thinking more about this, scx_bpf_task_cpu(p) returns the last known CPU
where the task p was running, but it doesn't necessarily give a CPU where
the task can run at any time. In general it's probably a safer choice to
rely on p->cpus_ptr, maybe doing bpf_cpumask_any_distribute(p->cpus_ptr)
for this test case.

However, I still don't see why the unbound kworker couldn't be dispatched
on cpu 1 in this particular case...

-Andrea

