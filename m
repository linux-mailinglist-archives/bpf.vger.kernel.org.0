Return-Path: <bpf+bounces-56964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1507AAA110B
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 17:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4196F1BA1550
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F4A23FC41;
	Tue, 29 Apr 2025 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qu1ubu2E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tJjVqmNh"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A7322A811;
	Tue, 29 Apr 2025 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745942128; cv=fail; b=plEXQZ28UjtDnQlsd6hIFfFW01vame/jO454WuMN9rinhLu2th3HmdZnmvefpzatlvatZ1ZRiEe7Rba2sD2OjdMfl0yiHs4DlAlcB/ZBkfpu5NdKIhGEPwDancfy16qzVWBXS2Zo8hTbocJLwVA0g0AuSBshc0LUnVzNzn04M0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745942128; c=relaxed/simple;
	bh=PHvykIZdlZv5eMHe5VXni1fS9X474j2FuIyK3RpZhOQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sUjOJMoajJbrKz8wcu7u8p8b9WG9uozdQl/QVo1IFj+wjqmBBMwppabiUJr17PHki92ai24zLFEOnffPHZbBB2TFkPcfMEyqf3ZsvAfja5xJ0g7YbQmpj7ujWNxFma+/IM7oMnSCJmJOKwE56sph6BLBkeJnsYDemGW+Z4F8FCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qu1ubu2E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tJjVqmNh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TF26Yq021823;
	Tue, 29 Apr 2025 15:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nQuj4tFMhaRpAK+rJGTNZ50+Z6JR740I4bhKL8v1CPc=; b=
	Qu1ubu2E9iwhml99+62+NTKZ9EzHBInxwYUtr/SvhAFyuhfsOtu4B2tvpsWQzQbS
	7jZY3CevtNWREPibp6QFkS2mCsqRiPCmIYK+UELkbfnrObyaPj8KMUwU0Sdex7mZ
	VyIY+miasdR/274iS04oshhqFMii8aM29FdFz98Dc/Tj6s/d8tUhtKvwN+fHyh3P
	ZlJC+PhH/EXo2j3/I75PPzT9oWiB7lvP6KnDudfeTLp0uSnaUgBMsZP+F690Rbk7
	2Q7nZQfrod+3hNiEXTT7DWJnZ4uGEkSXt5QouyU/oMUaQXPceEzqRBbU/gPOscuv
	Jk8Lz4H5xb/RJPqr6GDS6Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b1278541-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 15:55:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53TFZSDT023749;
	Tue, 29 Apr 2025 15:55:13 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013077.outbound.protection.outlook.com [40.93.1.77])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxgapwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 15:55:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwoEitGMmO0aKt7Bs62w/liGmFFT0ASopMhKrQJpgybmlJudVa8FA9wkOnI6IK16tSZoOi5++9AGNlMU6zeP/k0VSHOoNPj1vjtH5nyLpxSVjNxwQoCvSJ81KxJhiiu/qZT9P/ThWp3Up3xV7uGKKNFpKwk2dmSW+Z2VdUJpA2NvP9pDK1lHxxzaObUHnJsenTRP2IdWJZOjIjEMCvLFYm74W3mpXNm1m2dyKzxDrTr/6OHAJv4mTg/902t04OosBod5By1u9Euzikzzt7BSy8P+eaneyQGp4Gu6+wCMTa5EFg0q0amPjMMhxZYZu0Ts0f1wsLRBTn0cEfmra+BLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQuj4tFMhaRpAK+rJGTNZ50+Z6JR740I4bhKL8v1CPc=;
 b=T3PsPPd9NQrwDKFYT8WGtlEZpPdIbSqFok5UiM+xVpBMPtlwnRoXdC/FL4cdl0PIYrKnLhQTTt5N10zzfQsdihSAye+8P+N2ThaPLCE3k/SvewNAnq4qao8QGR+9tRxeVrJ/SVZ25twtogHP2Qyca2FffyeNQV0RMFswR7x4EoT0/7wGDxOs1qOCO17Oz5pQUpNsuaxWeXQq766z1IoupSC0ldSJf7VnU5usPpaUiKqn8fok1lpiksi4p77wT+9Q9X9Hy8F0O4cnI+qv2DtJlC3QWWOQLDd01YZHRqKmsE9b6HjS1TwDc41qXX9W/wapCO24/qjgkdBQsEYglVp67Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQuj4tFMhaRpAK+rJGTNZ50+Z6JR740I4bhKL8v1CPc=;
 b=tJjVqmNhoSh1OaqD+CwBGmdW+hX8DEiMR9uueeEQKVrJw8zeWluozBeRbG8KlpIh5XUHD7afGAmmFkCEU7v22CcYRMCRH/HOrSAdjElUw3EWvKgLxrR8e9N6++ZJb2GUxXS4Ko+s3lbIMbiGfuOchi/FFyIDbD6kTEjBQTdSLWk=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BLAPR10MB4884.namprd10.prod.outlook.com (2603:10b6:208:30c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 15:55:09 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 15:55:08 +0000
Message-ID: <3a3f86e2-c697-4b56-aef8-c66ea79053c1@oracle.com>
Date: Tue, 29 Apr 2025 16:55:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: pahole and gcc-14 issues
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>,
        Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>,
        dwarves@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
 <076e52f6-248a-4a41-a199-3c705cb3d3c5@oracle.com>
 <CAEf4Bzb9ozx056hm3=zh=4Sh_62EydK_wtJkNpgH9Yy0cuSsUQ@mail.gmail.com>
 <4aa02e25-7231-40f4-a0ba-e10db3833d81@oracle.com>
 <CAEf4BzYRnNGGafWS8XoXRHd3zje=8xY1o5_8aVw6vxrUSbEehg@mail.gmail.com>
 <c8c4dc05-7fa3-4c1f-a652-a470dd6985c7@oracle.com>
 <e279abde-f4c1-42d2-bcc0-4df174057431@oracle.com>
 <CAADnVQKi4DARfzQJguZyDQsfXHq7A=QM2FwRwpZe-LJzj+Ujrg@mail.gmail.com>
 <CAEf4BzYt2sUxRPAR5AbAAXVcOeC2UqgkR24WDEZAAd+kEz=g-w@mail.gmail.com>
 <CAEf4Bzays+8g7kj4fNS0rBLPTQWzYb_maFkyHyij4ky1xm_GAg@mail.gmail.com>
 <CAEf4BzZgQMV+Gtiob_K-uuizyuqajyLjnGbKOJLyiGB=DxmY2Q@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzZgQMV+Gtiob_K-uuizyuqajyLjnGbKOJLyiGB=DxmY2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::20) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BLAPR10MB4884:EE_
X-MS-Office365-Filtering-Correlation-Id: ccbc68f9-29ed-4f6b-722d-08dd87363767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M01VVWhQU2hWOFhySFhzK2ozL1lIbDAzNlg5aGlYVENCUEhvRVhvaVI3ZkRh?=
 =?utf-8?B?NmZwY2VSMXZIQlN4dDRja3VKYTBERHRad1hFQlQxZ2w1WGJvYTVSUS9WMmtj?=
 =?utf-8?B?R29YTDBzc0hxSDFGTDNNZXNTUDE3bSsxMUVIdnYzcVc1dHZPRWVrMFFNcEJl?=
 =?utf-8?B?ZUVrMVJhUUVMeEYvR2hicTNjdnR0cmN5UVZ5ZWdnd3JRMENhdkxIY08vMk1O?=
 =?utf-8?B?L0Z1Qkp3YU1rcDFyZk0zNThValh2VkJVMVBCQW4wcDVMY1RWNjJTTkwvempJ?=
 =?utf-8?B?MnlFU1RwM1JZTDIzcW51MHVsNUVKN3FDU1d1L3B3eU1YcW82NnFPeStjVkFI?=
 =?utf-8?B?SVVYR0NpL1p3SnZ2bSsyZjVaV21neW5xRloyZXFZaFRxR1NUckFoMUUzUWV0?=
 =?utf-8?B?SnVXTlY5OTF0R0lWYkdaUWpSSVFwbnYxNnYvc0x4NkxGZk1Zc24ySkVSaE5m?=
 =?utf-8?B?TjZBdXNqRXNSZUJ5L1pPa2h1MVdNQUFFZ2dhbGcrdE93ajR4dThQSlp3bW5R?=
 =?utf-8?B?N2N6Tk03OWVTeXBQUmZXc1hCcThldkFoaFNoTmVHc2J6dEE4WjY2WVRFQnBW?=
 =?utf-8?B?dktURUordHFyZ2FVRU1NMXRLNlZWYldUSkJ6a0QvSEhiUHFFaGVXcFFKZkJC?=
 =?utf-8?B?dVJIdFVMZVFYUU1WSTFEckhqRDdVMDl4SHVmSlNEM3BRVXkwSHNhQkRTTUpJ?=
 =?utf-8?B?enBGWWV6aWVpS0piQk5CN2FObjRDV2t6QWdPQXlFTGdkNXBPcmt5WTlqeFBt?=
 =?utf-8?B?WWlFUWI4SVdKY2tCajBWUVJtS3U0Z2hqa2dqb2RPcjBiTVNmUHNyallrZURj?=
 =?utf-8?B?cWFVV2JEK1ZZeDh1YW9xZlVXSXRFSDBXZVlEVmU5cVdZR0JLYlNmY01uazB1?=
 =?utf-8?B?WS92a0FvVlpLL0hUZG84NUF6RzVDZUVnNDlWWi9pWUVDU1YwdFZVR0p6TGd4?=
 =?utf-8?B?ZUdZU3YxRnJJYW9zRzN4V0RZcFpRc2psK3RmSUYrMHpWZzdjTW96TCtpTFJC?=
 =?utf-8?B?QUdKaThSZmNOU21wRzdiTmtNZ09GVXdiYzFLWW52MExVRmhhTlAxbXArdFJx?=
 =?utf-8?B?R3hmLzZPSGpqV3ZNMTVUVVFxRFRaZ3l2SDArNW5rZTJrNG9LbWY4dDBndnBj?=
 =?utf-8?B?MkZCaDRwdFlnNGhyempqakFwZS9Ka1V4NjQzSGxGcFpDNHBUVk9LM1BBeWhV?=
 =?utf-8?B?MUducDE3N3hva1hiRVE5R2swTFlWaXhRREZQQmZEVEtvWXY4UVZTS0E3ZGpj?=
 =?utf-8?B?NlBUdTA1SlBFMFhTazVoUkVyVGs2aDZqTzhQdVB1Vlg0cmJOZ2F3and2U0cr?=
 =?utf-8?B?RERmVmxMOUt5dW1mdXRCbm8zVEp1THFEbEVQUkk1ZFJQSjFTYkUxMFBOYTN3?=
 =?utf-8?B?RVl3bjhhUk9wNTlmNnBPWEROVDhOMGFzSXNxVFZNODJkNTk5dXYzRnh1cFNL?=
 =?utf-8?B?TytYSjJtV0E4eE9xUW12cTZJMWlEaytmamZxQlJqdWFWOVVYMFZDQkM0Qm9k?=
 =?utf-8?B?Tk0rTUlVdm9hRm9nQ2xCSFlxcE0vSURtVzh6eWxMaGwvdFlSQzJkdzJZL2Y2?=
 =?utf-8?B?Z2lxK2cxNzB5aWZza25GbHJUMVdhcWM3b09PUEJRemRmLzNYaGJJcnVlNkpr?=
 =?utf-8?B?blovL1B0OEE2d2twSXF6cXhOQ0JZME1iQW1jcW1ReHgwd3liNndYNW9wL2Qy?=
 =?utf-8?B?TTJoa25GeThzREZSdFRpc1oxN2s3U2ZDT2ZUT1I2Q2Q3eVNoNE5POEVqaXBN?=
 =?utf-8?B?alVwa3JTWm9jZXkrc1V5K2dZQ1lNT1lIYkxzTzY5RE1rZUFDcHA2Y0l6aU1Y?=
 =?utf-8?B?cXhLV0FEeDhEOHFWUHc3TmNudDVqL0gySGJFT1BEbC8xckxsVEJXMkRTaEZT?=
 =?utf-8?B?aWQ4WCt3dFYySTBZcjJWc1oxVE5xQ2I0Y3ZuYlNvSnd3VmdJVEw0WVJsVjVt?=
 =?utf-8?Q?GYm9eRhMj50=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3N6UUNpQWVxdnBQZDRQSzEzRkQ5Qkk5ZWV2UXR6T1NiMFdoVElMdndDZlM3?=
 =?utf-8?B?SklMU0dXc1MyRWtoMmxUa1kxRTdDaUhQOXBtelFzcWJKVFpOWFRBTWFqd2gx?=
 =?utf-8?B?VmVZMnVLcTUrWFg1T3lPSXhsSkV5c2lvL3haWGZFSFJmc1ZCSUVDNGVIREUw?=
 =?utf-8?B?aktZUWJUVSt2Z2tBSWxjZXlSelJQdnlQV1phWk9oV25IVUpCbnJNY0NTa0lU?=
 =?utf-8?B?SHJvT01zWXFhK3M0b0F3d0Fud2JYY3gwSmZ1ckdIM3NHWVVlMEtiKzVHdmN6?=
 =?utf-8?B?SGQyWU9mWTVVamxBYVdmVVFSMGtHWm03S1RkN1IzRXpVV1htTm91eENDMHhV?=
 =?utf-8?B?U1F0VkM2RWZZWXEvVDdiT1h3NWRtSXYrWG5waHFJQ0F6elRXaCt5VUo5T0Uz?=
 =?utf-8?B?MWIweEZOcVZlb1ZQSytzMkc5Rk9oa2xBRi85N0srYXQ0dHRFSUlublZpOWpQ?=
 =?utf-8?B?am44QUgwaktWUjdLNXNha0p1QjJQRE93cDk3SlVsYVdqamJNOUlqTnVNVm9N?=
 =?utf-8?B?Ti9TeGZlbGRmRVVmWHRrZEpRdVZ3TFJFcWg1dmp4M1N0S0RJM0d0aGxzVVdL?=
 =?utf-8?B?bXpnMnIxajNGSFI2dndSazhMMG80VmZVdnZvTVdDeGovUGdCNHg5ZW1yb2V6?=
 =?utf-8?B?Z1YzaXBhNzhsR3gvUFNCcFRnMC8zdjFJZ0lPWTFyQS81NEdPTVB1ZE1FZ2FD?=
 =?utf-8?B?dmR4bVNiS3BNSkNtcngwbytYVXY1YVk3RytJS2FNOWo4Tk1ma0dxVE1SdUZm?=
 =?utf-8?B?WmpaRlN6bW9yQkN6SldiSUVTRXd6VzFlem00amtCd2tLcy90YjN4Uk5JYkU5?=
 =?utf-8?B?KzNPZEVJV2dlMVdjTjlmQkUxSHIvZGJHQm1OemlqcTlPTmJpTDFmNXBvTHhv?=
 =?utf-8?B?a3hsNjVwcEd0QnVMNWwwQ1FCYUIzeDdxeWVtL012MWIrdWZTeVJoTk9pWmFQ?=
 =?utf-8?B?eW1EbHFsWlVhQ0F2TVJHQUN5MGdKMTRiRlBmZ0FPbmE1d1RDOXlHUmQ5eHd3?=
 =?utf-8?B?eVFxWU5EVFI5UFNuc0llK0ZWY3ExVXpkL3lvRWEwQzFhRjJwNEFOMkxvUm5M?=
 =?utf-8?B?THpCMTgrVHNkRFIwOGJhbndkNGxuWFBKMlVpM1c2dUNxMnFBTmc5WHlTOFN0?=
 =?utf-8?B?VTNhOGUvQkJWdVNsRU1SUzlXSnpJcCswZWR5V1Bua2p3eGN2eGtlYVdqVHJL?=
 =?utf-8?B?R3RleVFRVXhTWnlPR29qY1BwRGRaaHlvUjRzSVBUVFhKVTJvZkVEQ2VhN29q?=
 =?utf-8?B?QlF4cTUvR1hPelVOVDFPNUxKREpNODh6WVYxNzNuTEJOMDkxQ3lDS2NQRnd1?=
 =?utf-8?B?Nndwc2RsTmNxeGZHcitTbTRKVXArSmYwdW80SWozdXkyVG1va25MYzdkdSti?=
 =?utf-8?B?eU0rOCtrY1h4MHFFZ2loVE01NzJtY3ZtaG8xMGRxamlUVzRLaEJUTjZ5RCtp?=
 =?utf-8?B?U2g1aks0eWwwNGxMK1hwVERYU3VMQ1BaYXdCc1dMbTQ2RTFmVjhYTkM4UHBL?=
 =?utf-8?B?WUpod1M0QXdpYlNYSXZDb1pYZ2RpejU5SjF4OWR3TmFTTU9hU0E4MDZ0N2hi?=
 =?utf-8?B?TXVlZUM0eTZGNW1SK0NKTDJJa2FwVFdIc1BMMm8zYjl0eHFOZERmVU1Pdmkx?=
 =?utf-8?B?dW9kcHF3eWtpWlJ2empnaW9CZjl6MXc3RjZtdlVLZmhuaFNsMXFVUXRmVktx?=
 =?utf-8?B?Mk1VREhwNU83cVpMTVNHcEdQbTdrQTZZRUdhVjlaVzFnUE5HYkFUMEYxamxl?=
 =?utf-8?B?VTJJVUg5eWlWWVpVc05HdTcrSk5aSVE0c3ZTVlZKWDIxTER5b1FOb0tFQnBU?=
 =?utf-8?B?OUtsb1RlYTV2Tms4ZW02Z2dIejJnQ3paMm9Fa05pZ0Vsa2dOcUkra0lzTUx1?=
 =?utf-8?B?WTR1dHgrQ09OWlFDRVpjSGh5MTN0TkZJNUpQYmwxbGR6VG1mVDd2SHF1eFR6?=
 =?utf-8?B?TTBuVjFhK2FwaWlDQmtKTlRoQjgyZFpsVDZXUlpGdW5WQi9vR2svQXVTL2V4?=
 =?utf-8?B?dW1SUU5XVlgzWG4yNkJ0VXcxNkdvMjIwRFlEQXdTeGNvdlkxTUxoZlRSSStx?=
 =?utf-8?B?YXpLUzNITUxIUWlieGZDNmR0ZnB6N1ByNmIxd29FZ0xyRlh4bmNlenQ3MHpv?=
 =?utf-8?B?bkVYN0VOZFM4Q3dDemUrTCtBa29RUU5Gek9tbnBQMHFMa1BPR2o5RnhWNXRP?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Tpzflx1BUlKpwmtL0boe4XTVxOyVCGR+AQUNcYiM+BLZpLwqBccUf7cNQbCvN/HS2ySLCTpOo1akqGHhBt0URIGs42IknuidBz7IYGeWIaxxoRNpagGNp3R/UCyrBoPTD0VkdKndjYi0Bt9UeB9VWZhte9iXgA1aVJfTerGRMpen/T/Z4DopK5y+cMX7qxVHafotxTNVZiFPl4H4Tvdax1b/C2cng26B2uLZEJrAqmYqZ+57O13uimzcgX1JceckWzDCaKinQK7GWZlArVw+rQzV6u9DeWBfQfkb9XQBIq61az14Ejpjh0qfnMQiTC1F/YLsVzmQ3sleDYmdTrDxl8ulSaH58ZzDx1wpIGKBP4+Pwt2glGFgaCl8Twqu8fDZexUL4U5BdSD5QDBWGX16hKwHdEmPVthLC5zhQB0j1GSMkUJJCKRyzZJL7k8UJS1IqBz7/YhnDGSCx3xSuVaKiyn4uGimVcToTQIY4MPqPvcg2gXIVpOFms4KVXB8kJ+x8/flm+vFsGPIxXHuKkdR6HGhHUR06pMN44gWJiWrb/elkY2O3phKfl+Ilr6JJMU6FLYDiPxE+kyDqGiXXECxXGjJUxCuwaenQOqzcXS2Amg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbc68f9-29ed-4f6b-722d-08dd87363767
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 15:55:08.5685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8AoS0I7EcOovl+0Yrbk3J2fdt9ktbYPAleycbUJzAwGocRmrHkhRkAJxpwn5kD3awZCRsAyhVtm+GrGFMxsSCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504290119
X-Proofpoint-ORIG-GUID: 8nZ8jrHisRW-CqGHNbBJWX2qPkDZ_tn-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDExOCBTYWx0ZWRfX2ovhBNMz9/Jj FERs3rwCzEwUKazvScYV1AxgnawyJ8FQj8hcoe+YWySIS3W6zzk4SfhXDUhcyfiiifVh2q6Azib V5JBvUK3OulaQ3kuCZGGqTLtWq/rYZXf1pkl60wRs2N+qL5XO+5e06gN7PVncVWe0JiJJyM79l9
 +QX+43v7I3yNZ3lqI4zv4ZbG6qAGY5Q9sVlSq7rlCVxP03gVb/Kv1Hq4S1xw+pQrX6Z/C9bsHhV 3H/q7ZDs/yUcpuv2JQ/1wTbB3ERSXlsl+m7GaA53DPKd+U0bvRzdHA+Lgfhv732iiNvxcglJ0xx 9/hsjvgdkD39vB4vBB21MdKoUh7B1Vdw9vgzvBs1+EJPuvEJuwzJWqyZ6yC4tFUfaAIfEehF7Kp PNOmpRoy
X-Proofpoint-GUID: 8nZ8jrHisRW-CqGHNbBJWX2qPkDZ_tn-
X-Authority-Analysis: v=2.4 cv=BoqdwZX5 c=1 sm=1 tr=0 ts=6810f662 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=12ntFZgRktft8stFDeQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13130

On 29/04/2025 16:37, Andrii Nakryiko wrote:
> On Mon, Apr 28, 2025 at 11:59 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Mon, Apr 28, 2025 at 5:33 PM Andrii Nakryiko
>> <andrii.nakryiko@gmail.com> wrote:
>>>
>>> On Mon, Apr 28, 2025 at 3:12 PM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>>
>>>> On Mon, Apr 28, 2025 at 8:21 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>
>>>>>  <1><4bd05>: Abbrev Number: 58 (DW_TAG_pointer_type)
>>>>>     <4bd06>   DW_AT_byte_size   : 8
>>>>>     <4bd07>   DW_AT_address_class: 2
>>>>>     <4bd08>   DW_AT_type        : <0x301cd>
>>>>>
>>>>> ...which points at an int
>>>>>
>>>>>  <1><301cd>: Abbrev Number: 214 (DW_TAG_base_type)
>>>>>     <301cf>   DW_AT_byte_size   : 4
>>>>>     <301d0>   DW_AT_encoding    : 5     (signed)
>>>>>     <301d1>   DW_AT_name        : int
>>>>>     <301d5>   DW_AT_name        : int
>>>>>
>>>>> ...but note the the DW_AT_address_class attribute in the latter case and
>>>>> the two DW_AT_name values. We don't use that address attribute in pahole
>>>>> as far as I can see, but it might be enough to cause problems.
>>>>
>>>> DW_AT_address_class is there because it's an actual address space
>>>> qualifier in C. The dwarf is correct, but I thought pahole
>>>> will ignore it while converting to BTF, so it shouldn't matter
>>>> from dedup pov.
>>>>
>>>> And since dedup is working for vmlinux BTF, I doubt there are CUs
>>>> where the same type is represented with different dwarf id-s.
>>>> Otherwise dedup wouldn't have worked for vmlinux.
>>>>
>>>> DW_AT_name is concerning. Sounds like it's a gcc bug, but it
>>>> shouldn't be causing dedup issues for modules.
>>>>
>>>> So what is the workaround?
>>>
>>> I'm thinking of generalizing Alan's proposed fix so that all our
>>> existing special equality cases (arrays, identical structs, and now
>>> pointers to identical types) are handled a bit more generically. I'll
>>> try to get a patch out later tonight.
>>
>> So I ran out of time, but I'm thinking something like below. It
>> results in identical bpf_testmod.ko compared to Alan's proposed fix,
>> so perhaps we should just go with the simpler approach. But this one
>> should stand the test of time a bit better.
>>
>> In any case, I'd like to be able to handle not just PTR -> TYPE chain,
>> but also some PTR -> MODIFIER* -> TYPE chains at the very least.
>> Because any const in the chain will throw off Alan's heuristic.
>>
> 
> Ok, so sleeping on this a bit more, I'm hesitant to do this more
> generic approach, as now we'll be running a risk of potentially
> looping indefinitely (the max_depth check I added doesn't completely
> prevent this).
> 
> So, Alan, do you mind sending your proposed patch for formal review
> and BPF CI testing? Just please use btf_is_ptr() check instead of
> explicit kind equality, thanks!
>

Sure, will do! Was about to reply that I'd tested your patch and all
worked well. I'm a bit worried we may end up playing whack-a-mole with
issues in this area so I do like the idea of a more generic approach,
but that doesn't have to happen immediately.

Note that the missing kfunc issue that Alexei also reported appears to
be a separate problem, and I'm seeing that despite having dedup-related
fixes. My suspicion that the associated .cold functions were triggering
our inconsistent function detection in pahole seems more likely given
that the following change:

diff --git a/btf_encoder.c b/btf_encoder.c
index 0bc2334..a72c9c3 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1456,7 +1456,7 @@ static void elf_functions__collect_function(struct
elf_functions *functions, GEl
                return;

        name = elf_sym__name(sym, functions->symtab);
-       if (!name)
+       if (!name || strstr(name, ".cold"))
                return;

        func = &functions->entries[functions->cnt];


...appears to be enough to make those kfuncs reappear in BTF.

I think ideally we should have a better means of mapping from ELF
function -> DWARF rather than purely via name prefix. That part requires
a bit more thought, hopefuly we can get that fixed ASAP too.

Alan


>> I'll try to benchmark and polish the patch tomorrow and post it for
>> proper review.
>>
>>
>> diff --git a/src/btf.c b/src/btf.c
>> index e9673c0ecbe7..e4a3e3183742 100644
>> --- a/src/btf.c
>> +++ b/src/btf.c
>> @@ -4310,6 +4310,8 @@ static bool btf_dedup_identical_arrays(struct
>> btf_dedup *d, __u32 id1, __u32 id2
>>   return btf_equal_array(t1, t2);
>>  }
>>
>> +static bool btf_dedup_identical_types(struct btf_dedup *d, __u32 id1,
>> __u32 id2);
>> +
>>  /* Check if given two types are identical STRUCT/UNION definitions */
>>  static bool btf_dedup_identical_structs(struct btf_dedup *d, __u32
>> id1, __u32 id2)
>>  {
>> @@ -4329,14 +4331,93 @@ static bool btf_dedup_identical_structs(struct
>> btf_dedup *d, __u32 id1, __u32 id
>>   m1 = btf_members(t1);
>>   m2 = btf_members(t2);
>>   for (i = 0, n = btf_vlen(t1); i < n; i++, m1++, m2++) {
>> - if (m1->type != m2->type &&
>> -     !btf_dedup_identical_arrays(d, m1->type, m2->type) &&
>> -     !btf_dedup_identical_structs(d, m1->type, m2->type))
>> + if (m1->type != m2->type && !btf_dedup_identical_types(d, m1->type, m2->type))
>> + return false;
>> + }
>> + return true;
>> +}
>> +
>> +static bool btf_dedup_identical_fnprotos(struct btf_dedup *d, __u32
>> id1, __u32 id2)
>> +{
>> + const struct btf_param *p1, *p2;
>> + struct btf_type *t1, *t2;
>> + int n, i;
>> +
>> + t1 = btf_type_by_id(d->btf, id1);
>> + t2 = btf_type_by_id(d->btf, id2);
>> +
>> + if (!btf_is_func_proto(t1) || !btf_is_func_proto(t2))
>> + return false;
>> +
>> + if (!btf_compat_fnproto(t1, t2))
>> + return false;
>> +
>> + if (!btf_dedup_identical_types(d, t1->type, t2->type))
>> + return false;
>> +
>> + p1 = btf_params(t1);
>> + p2 = btf_params(t2);
>> + for (i = 0, n = btf_vlen(t1); i < n; i++, p1++, p2++) {
>> + if (p1->type != p2->type && !btf_dedup_identical_types(d, p1->type, p2->type))
>>   return false;
>>   }
>>   return true;
>>  }
>>
>> +static bool btf_dedup_identical_types(struct btf_dedup *d, __u32 id1,
>> __u32 id2)
>> +{
>> + int max_depth = 32;
>> +
>> + while (max_depth-- > 0) {
>> + struct btf_type *t1, *t2;
>> + int k1, k2;
>> +
>> + t1 = btf_type_by_id(d->btf, id1);
>> + t2 = btf_type_by_id(d->btf, id2);
>> +
>> + k1 = btf_kind(t1);
>> + k2 = btf_kind(t2);
>> + if (k1 != k2)
>> + return false;
>> +
>> + switch (k1) {
>> + case BTF_KIND_UNKN: /* VOID */
>> + return true;
>> + case BTF_KIND_INT:
>> + return btf_equal_int_tag(t1, t2);
>> + case BTF_KIND_ENUM:
>> + case BTF_KIND_ENUM64:
>> + return btf_compat_enum(t1, t2);
>> + case BTF_KIND_FWD:
>> + case BTF_KIND_FLOAT:
>> + return btf_equal_common(t1, t2);
>> + case BTF_KIND_CONST:
>> + case BTF_KIND_VOLATILE:
>> + case BTF_KIND_RESTRICT:
>> + case BTF_KIND_PTR:
>> + case BTF_KIND_TYPEDEF:
>> + case BTF_KIND_FUNC:
>> + case BTF_KIND_TYPE_TAG:
>> + if (t1->info != t2->info)
>> + return 0;
>> + id1 = t1->type;
>> + id2 = t2->type;
>> + continue;
>> + case BTF_KIND_ARRAY:
>> + return btf_equal_array(t1, t2);
>> + case BTF_KIND_STRUCT:
>> + case BTF_KIND_UNION:
>> + return btf_dedup_identical_structs(d, id1, id2);
>> + case BTF_KIND_FUNC_PROTO:
>> + return btf_dedup_identical_fnprotos(d, id1, id2);
>> + default:
>> + return false;
>> + }
>> + }
>> + return false;
>> +}
>> +
>> +
>>  /*
>>   * Check equivalence of BTF type graph formed by candidate struct/union (we'll
>>   * call it "candidate graph" in this description for brevity) to a type graph
>> @@ -4458,8 +4539,6 @@ static int btf_dedup_is_equiv(struct btf_dedup
>> *d, __u32 cand_id,
>>   * types within a single CU. So work around that by explicitly
>>   * allowing identical array types here.
>>   */
>> - if (btf_dedup_identical_arrays(d, hypot_type_id, cand_id))
>> - return 1;
>>   /* It turns out that similar situation can happen with
>>   * struct/union sometimes, sigh... Handle the case where
>>   * structs/unions are exactly the same, down to the referenced
>> @@ -4467,7 +4546,7 @@ static int btf_dedup_is_equiv(struct btf_dedup
>> *d, __u32 cand_id,
>>   * types are different, but equivalent) is *way more*
>>   * complicated and requires a many-to-many equivalence mapping.
>>   */
>> - if (btf_dedup_identical_structs(d, hypot_type_id, cand_id))
>> + if (btf_dedup_identical_types(d, hypot_type_id, cand_id))
>>   return 1;
>>   return 0;
>>   }
>>
>>>
>>>>
>>>> We need to find it asap. Since at present we cannot build
>>>> kernels with gcc-14, since modules won't dedup BTF.
>>>> Hence a bunch of selftests/bpf are failing.
>>>> We want to upgrade BPF CI to gcc-14 to catch nginx-like issues,
>>>> but we cannot until this pahole/dedup issue is resolved.
> 


