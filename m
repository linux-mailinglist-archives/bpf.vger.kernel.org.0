Return-Path: <bpf+bounces-68140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1328CB53628
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 16:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D5537ABE70
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 14:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2853734DCDE;
	Thu, 11 Sep 2025 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fb31oMtr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KUpNdxB0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E8631353F;
	Thu, 11 Sep 2025 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601972; cv=fail; b=aqMXCXkOo6hkzLC5sTpjFwVie8sQ6K6booSuXJ2k3yCmLr7xMZAmjZaK9ABAGnRPlKmcRU8aM9/8O58fgQN9xBlrgGZY1E/8Iy3H2Yl5I5HZyTCK03Gsb8Vv3pwWWQTemzqVGHeUSQZB39OMfOHDEc/TAYVh0T0408wN08isCrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601972; c=relaxed/simple;
	bh=8TK6J+4y98L90hhWFN5ds/Pmb+1hCAXz2oKTMZzl8dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sYWhqLA3oeZVsruTT8xY/J7vH/mn/1ztXsxwc4LV6wbQLXm/6v9A/T2wO0btmepnjLXtK1emBYvaVB2S4w+un5/2cc3m92BXoAEQENk0PJqn5JBVRFQe5BhFBflkMIt+xbR6xgApnif4noVTWTbB0JQziGwla9bPm3zI8FmH5hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fb31oMtr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KUpNdxB0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDtrcR015762;
	Thu, 11 Sep 2025 14:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WssuL/vKwEy4FprTO+Ayodb8U71Lklay2e33Yeq2B8E=; b=
	Fb31oMtrE/hiEdSd1u4TNzPlrSobTfBAD6sLA9bTeWC4+JqGrPwhXEyjv3Rf25nO
	69D+7TfMY6i/QA8IDR2fq9idCBl65u9H8WyrR8zhOHSZYbJS5AATm9WwrZfA2c82
	KnrrYwTpNMy92Rt9NXSCtzJLs0La9E+WxvXyIJ+Bnd5KrKX8OfmCKW8P3gvWRPe1
	c1Jrd+ZujMwfEDITbtWf9F2y7B7NboHAZm0dwFT3dZO2oZzs8T45apKIisD390Gg
	2hn7ok7NYLvzrHqDcdINzkIv4IJ2R0hWtxzZNL7vOys9H+3rdsS+GtkUdbhqcDXH
	zFd3+bXFi483V+D8qkbREA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921peef9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 14:45:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BE1MJ7038836;
	Thu, 11 Sep 2025 14:45:18 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdcj60b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 14:45:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwa/NrPcsBcWZS9vV5GfWOoxu1x44QZUmpxWcRoi7ed1SdnKlg371wFs70V3ig8WfOqSsirrjza+woIonY68q01K9ReSy6qDZ5huxUY8Y4mkO7T7TwgKPM6oBomWq4AJDwyKbymmBvLyPsRTESwP9wopT9o57cWPTSg5p558SWBK5i8X7lt8YL8Fs5XxhL8z1CZ9C3+ENjcbtc8n9fAx4XATOcFxaQkndZ+ObwoJ4oGE0cjDeWqt32dwyR9bheudAMYkqABd5m5KPqzVIYpU9lq0tONcISOAYzxq4CQtu/6t7sD4eGJe2giGZ7OVa8rl3b44QSekdaMD78U6m+g42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WssuL/vKwEy4FprTO+Ayodb8U71Lklay2e33Yeq2B8E=;
 b=pR0WYIhsedSZiJ2ICENglZ/AX82ultKEG6gVdw0ODrFui1QDcjQF2uwNV9vBM/CGSXt1oW79HfspKY+0qotk+mJ9eq/8FfXBbSbbfAn+X6gx8bX4m3kYZEEo2sg6O1fiKKu0UU9H1esk1WUli35lJAcq+SloRz84Myw4ANS4OeRTRmKj2t8ZP9nmOxwP7qaZZevmg9ujy7aMJsLyQ9DLthZp0uF6Qywlv8m+AytIiJb6bB8VhUolR9Hs/NTLS7CU1p2mzeaGZ3eKPeMUTPL+CSwLQCykmcmSieq8bc4FbNpKsSopC/3BVPqkUVXAUO7yqkogpGrqp5VTBbhvOOu7Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WssuL/vKwEy4FprTO+Ayodb8U71Lklay2e33Yeq2B8E=;
 b=KUpNdxB0hw71YYthmedPuCl3E4AhWhbqFx69mx8CkHVQsAJhdMv0UIgpcuCKy5fyu2QDVTldWfX9oTT/i7hUR2Og4zk3Oul7peDvrWGD180a9zH2tPhW9bvyB0oCHoVlIQKE5zSz9ieL29uNmjvV3LbmdSKT7tVBNifcOoxwbt0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB6651.namprd10.prod.outlook.com (2603:10b6:510:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:45:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 14:45:12 +0000
Date: Thu, 11 Sep 2025 15:45:10 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
        dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        21cnbao@gmail.com, shakeel.butt@linux.dev, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 mm-new 02/10] mm: thp: add support for BPF based THP
 order selection
Message-ID: <8dee8bf5-e868-424c-af39-9d58e9edc1e5@lucifer.local>
References: <20250910024447.64788-1-laoar.shao@gmail.com>
 <20250910024447.64788-3-laoar.shao@gmail.com>
 <CABzRoyZm32HT2fDpSy_PRDxeXZVJD35+9YqRpn9XWix8jG6w8g@mail.gmail.com>
 <CABzRoyYqGsABGVgXbH3Sts3yBsk7ED=BsKbcP3Skc-oWeFsN_w@mail.gmail.com>
 <ac633edf-4744-4215-b105-c168d3a734ce@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac633edf-4744-4215-b105-c168d3a734ce@linux.dev>
X-ClientProxiedBy: LO4P265CA0211.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bf0f870-2ff2-47b6-4367-08ddf141d02d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NndnRGFNTXdKb3FiTTEreHFGd3p1L2FqN3dwY3B5eXAwaU84dFRCbDBEOUxJ?=
 =?utf-8?B?TXNMUlhhNndqMXdiOXU2ZS9xcWVCaENyUU9wcmphcisvUnAzREFCZlJLWGQ1?=
 =?utf-8?B?VXJJZnZQd2xWaDU0R1llT1ZHWWJiVG1uWmtaTWluMVUzbXlWUXUrdHd4aDBZ?=
 =?utf-8?B?bG9uYzFVeUFpb28yekhNMDJZZTNmcmVXeTR4aCtVZG9iR0dSOVlSY1R4RVBT?=
 =?utf-8?B?UjJmcmpndFhKUnZRVWkwZlp3WTVSem9xd0NIdWsraHh6UzVzS1VNK2RTcGg5?=
 =?utf-8?B?TFdxeU9yeWQwcUV3SnpUTE1ueDFlampPcDNNK3ZWRkpXbkRvVnNPVks5SjRZ?=
 =?utf-8?B?K1J5MTg2ZUw2ekFYR1FQdVgzdFFKaXYyTUNMZnZlYno2YThtSEtSNmlaRjU4?=
 =?utf-8?B?dEhETFE5bzh1U05RUnRvdVFKODVGdEgvSk1LTzR5NnRFMGZGczZwSU54OGdt?=
 =?utf-8?B?ZUlhQ1EyTmROODhkRnJKYVArQ2RNOHNHcS8raEtSbmE4ZTVqUExtOUJjZk5y?=
 =?utf-8?B?K2dwaUxvNk9oNHFiUVc5OUMxbTFvY3RXN1ppUHY0M2NnVTNONlozaEM1RVFp?=
 =?utf-8?B?RVhTU2tqR3MxQWRhV2xiSUZlbk81Z2VQNXhEbGVXbmUwZXFyY0RCeU9QTE1i?=
 =?utf-8?B?dlY1WUVlZU4rREl0ZmZlcCtqNEp4YzlZa1ZBL0x6Z3N5U1BvU3BGa0N2bm8r?=
 =?utf-8?B?NE51NUI3Vzk5RWsyUG5SdVVmWExUTzZOZ1MxVHVoTSsvVHduaFpEOXlrOEF3?=
 =?utf-8?B?Z0dCU0xLWUF1MjVNQlBOVC94NWhwSm1NUE82NlhjaU9iK1NURWFuNTBNQWZ0?=
 =?utf-8?B?ZFZVKzhxdmFIakJodTJkR04yWGNwQ0h2c3JRNEZubkxRaEFlMDRVYk5uaXR5?=
 =?utf-8?B?MCs1TnFLTnYrODkzS1M3VGRicEExdWIxNjNQKzFRQlFPcHBXR0VPVGhHUlNO?=
 =?utf-8?B?OTlsbGNWSHZZa1lVMnRwYnZWSjVWV0l4bmRVZzlycmhWVVk5SnVyVVA2R0JE?=
 =?utf-8?B?eHJTRFdobVVHc01TSk00RU5jVXVTeTV0MmtPam8zTVNIM01iVUx5eWdRVzJ0?=
 =?utf-8?B?VHFiREpKYlFtTVU5c0tuSXlYUVBCdStDclE3QWtDY0w4RWFMbUxpdTJJOXBL?=
 =?utf-8?B?Ri9WSHJlWURScWZjbVVHeFJyMWIzYkgvM0V2YldIMlZlTjJwQVBWdG5nRG03?=
 =?utf-8?B?cXVXNDkrYWExekt6N0ZXc1JXMjZPNlZzNUpuTk1BV0w2WS9JdHdYb0Q4VFpw?=
 =?utf-8?B?UWpxSFFYTGtUd2h4bU1abGlHdy9nMy8yTWVaVWFzaXl6aHNvWmdlTjFOZ1J6?=
 =?utf-8?B?K2lmdkdvbXBmd2pqbFJCT3N2cHJGekZXVGpUTFB1cEFTNm5WbU53TUI5Y0J5?=
 =?utf-8?B?blloc3dUTnVEbHR1a1UxSXROQkFkVTFzbnRmWnBGR1drc0hJeUJJTFJHRnRh?=
 =?utf-8?B?TmNqTkxvRmRhOXlTc1krL0dLN1NiTTNEcCtVOGcyUm9CR3Jid0oyQitaeE5n?=
 =?utf-8?B?UEYzdUxjOUdnRWJVNWFpMWEvemxWalV5NFduSkdBcTVzeitsTFNraFVkcjBQ?=
 =?utf-8?B?cjYxcnliMlhGM3ZtMkdJcEcrTnVvQ3dpdWtDV0FZQ1lLQ0d3N01WbjVrTUxy?=
 =?utf-8?B?RGllV3Y0TFpycG5rdGpDWUIyWUlCdVErTVVPUC9GQmNlMytSd2c0ZGVCSk40?=
 =?utf-8?B?Yzh3a2JKNjM4Uk5SYWhkSW9hTEhKTGYvYnFsNVZLVG1NTGxxemxUSjJBZ0h5?=
 =?utf-8?B?MFNWNzkyK3JadWJYU0cwQm5nVVNBd3pjRFBRbzZNVFBzWDdTVlorVHc0RDB2?=
 =?utf-8?B?MFBzNWJmbElPMFViWkNETnV6K0NYNUY1bWpyM2c0cHVGYXdrVzNqY2hHSTFl?=
 =?utf-8?B?T1JmVnRSMUI4N0tvWElBLzZjOTNXVXMxR3BrRmhyTDdhMCsrb0dEaUFMRXIz?=
 =?utf-8?Q?6c5WLX7TZMQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y08rbjV2UzdXNENhKzAycFBQNEhVWmo5bW5zM2d1RTh5bmdjRHgvUVVRenh5?=
 =?utf-8?B?RmVlcVYzcFdPWFVYL1BIUkFUenBHN1FJUmkxcXdnbU4xRUYreTNtdHJQRSt4?=
 =?utf-8?B?aXExT21CWGVSNHpVU0ZJZnBRSCtON051djNvTUxsQTVsV2dDS0VidkZJL09Z?=
 =?utf-8?B?SEFjbTEzMTZEWTNMbHB1c0tnVHdBTzhqdnd2eEpsSXd5KytQajBQQ0Fiak9p?=
 =?utf-8?B?NG1nVzBiazRvYVFBaUgreEc3alBhbUtPb21nRW00WVRPRjIvcjB0bTRSYmln?=
 =?utf-8?B?Tm00VmdXVE0wekU4Tm5xdGdxMkVPZkJwMVJ4a0x2Z2w3ZTY0MXdhc0h6a3JK?=
 =?utf-8?B?Vmw3STVTWER4QUZXcDlKUFhveW9pOFVrNHY3bEZ6MUpZUXMvWWJuTmYwNjNo?=
 =?utf-8?B?OVpLdWYvQktZUUo3M1ZEL3RvZWJvNFZOVEhKWngwUUhZTEQ0TmxoaWZrVzdW?=
 =?utf-8?B?c2YvVGEvMStKOWJUM01zSWsrc3FTT29sN09CTlgrMDhwYjRKd3JjbzM5Y0Za?=
 =?utf-8?B?UktNOFBhTWxoZ0h3aTRIM2w2RlEwMm02Mzl3bEdXNFNNRUlrMW1hUjl4WlAr?=
 =?utf-8?B?ckpMZEZIVUhDZzVIdFMvY25KUlJ3aHlPbUJacVRPZDZ5aUY4T1Y4Nm9wU25u?=
 =?utf-8?B?S2J3QUk3UkNEUmFqeXI1K3F2QlNwNk9HdnN0M1hHeDFyZEZ0ZHVhdDRjM3pR?=
 =?utf-8?B?Q1F4UUdRc0FnV09VQmRLcWUyL2pYMVRRakpiUitpSkMydFR0SDk5VGxPUmdl?=
 =?utf-8?B?cHRiNjhVNnpnRXZ3SXJoZnQ5UkxpQmlzZXJCYmQ2Q1k5bmdrYnJOSkk2YkxS?=
 =?utf-8?B?b0ZIY3VDSXB1cG1kT3J1OWhMY2dkV3hmeW14NTRncmp2MFI2QkNQQTZVYWVK?=
 =?utf-8?B?YlBFLy85YnBDQW4wVDYra1QxeENlcHRMN1lFL2FvbmpvSVplZnZ4SXhsOTQr?=
 =?utf-8?B?M203T2tQUVI1T2ptekczQ0hITCtuQ0tXS0RrM21QQ2M0LzNUQlJOSm1icDho?=
 =?utf-8?B?SWJ4aHQ2K24rREpyaHVoZTFrVnFEZ0VsUGsxa3FnZE5IbGVFNWxYRVl3SU1j?=
 =?utf-8?B?TFI3bjVXSE12YWczZWNRWVI0eHVKSVRDUy8vaFByVlI2d2pCRmlXUnRyVytY?=
 =?utf-8?B?MmZjMnFJTk00OUhhdkorcnZQNGNYUU1MMGdjZ2tQbWRRbEwyOExxTmYyNUVl?=
 =?utf-8?B?dCtqK0FoZktKUTN3TjNiZTdsNXNSNUVSSjRWelBSd3R4ekJrTnF5Y3RrVU8r?=
 =?utf-8?B?ZmVSNU9pYXhFZkZDL09rU09ER0RWV2NLYXRybmJWN1YrN1ROSGI5aklEZXkr?=
 =?utf-8?B?NFdTSldORzk4V0U5bHdrMXhtaDExTG9TUXNGRVRaRjJwUlZwTXdlak04eWc1?=
 =?utf-8?B?SFllbzRySG1XeVlaQXowN0lQQWpuRnYvK2EyZm5ZTGtWMHlmK2p3Q3plR1NG?=
 =?utf-8?B?R2VELzJyZll6bGVBRDIvdkdTYTZnWWZiU3p5bHdkMVRpblZod01EbTFnYm1o?=
 =?utf-8?B?TDBlWHA1V1dhSUpQV2R1M1Bibm1SOFNpdGZzQVl0dko0WWZaQThKNm9FNEpv?=
 =?utf-8?B?YWtielF4MnVYMDFSWGhlZTQ3My9KVkZycFVQOVcvZWpVTmZrUExuTFFWNWhz?=
 =?utf-8?B?bk9NKyszQWdSTEVZUGFORFR3ZE1Yc1prWVJ1SHFrRkJZdWJPUG8vWFNWdG9H?=
 =?utf-8?B?dUd2YzdyenQrQU5XUGhVV095RVJBRFdDU2ZzMTBTZVptdm05TDJiRk4vcFY4?=
 =?utf-8?B?dXBERmhWai9NTFMyZjJKUVhrSGgwdTRzYUhaNkoxeTQ2d0RWaHR4Q21DYlpa?=
 =?utf-8?B?ZHZ4QTNMRnVKU1NGV2I1dVZ4UUZBS3RXOFYyejZKQ2phMzFoSmZoeWFsQXkw?=
 =?utf-8?B?VzdFdVlHcnlCTkdoZHFHNWI0Sm5GcWdKb1dPKytjaS9TZUJBdlJ5Qng1RWU1?=
 =?utf-8?B?enAvNjFLc2lFWjNVVmphQ0VLWm1NZ21vVnhNbm9rYlVCemd4elpSTUdaM24y?=
 =?utf-8?B?SmtPRmRFcysxOXBYWC91azAwenpaRzlyd3dndUtha2ZvVldvcTRUSXNQVWpM?=
 =?utf-8?B?am5WVXQyUHRIblpHNWdEQm9lMjdvQ2p0dk85a0VjdWhnOUxNaTVkWXV2dTJv?=
 =?utf-8?B?d0p5ZmpMUTBWaTZSaFlYQ3hGemNoMXhaaHMvYXMyUmJCR2ZVRndkMnI2a3pa?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rpYhF8Of0ATmv9nSOsijmy+g1EtGkI/0M1t3K+j4+Bpf9FBlsLrMbOlHXicpnhL/NwFPsiv3+uk7KfztrCmMXdQkBj0CVHBCU9cd8Q+yCR8s7jWN7r3CiNpWo7DXoHSBfmBHbBxuJJg8QaFeLMdzeX8WL9ZaWNwyHyum/yUk3fF9byGB6Ymn6YIMnBtpFHLTT0BW8TNYncWZVNklekx6yrUtxA8Yx97GZYxr5TJBI4vM6Sl4f9O4WcQgaC9u2OynNduQZgbzr2KqJ0q1291mfy9AgMqsAlEnOqeKxvWXdiHbqAKUVLshYxmm4Rq0zUgzPJhU1UfDrbk3YHsierUbBPhWzDGRHLGc9T1psL95DiGzbUYGJuggKAsL0Afr8MtydGNi4FbFCbV7J8F3Yi5zzcN7eFz5dp7KZDKNqIvrcchaM9ELhhOx/FdC7FBduMSAFjBvC5OJNUHDJMTKTkU61vT/TUEggW+sutDYbPVDSc9VGWG8eYi3LF6fOP57IyxcWGiOrJO+iZMb7527f/XKt5pXzT72UGYTf5dHlfiHg/9jd4FwiPeBmeD9/je/mAUr3Cyx3h+o4Kz11FbaRti1UQgbHDz0n3s21XDMKe/XB7o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf0f870-2ff2-47b6-4367-08ddf141d02d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:45:12.4985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQpSYF3ormSlVvxXUCoOgQWaK6SLeZi6CStFURBAouWpGjcNW3ZqT34Fsy72mw0LcskB0/KLBeBw4ff/pcwaxrQuZdgynPbWfONj3Grfw8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110130
X-Proofpoint-GUID: TdSwCKfSHzeMAkS0wlPrIY7a-1NA0ugP
X-Proofpoint-ORIG-GUID: TdSwCKfSHzeMAkS0wlPrIY7a-1NA0ugP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MiBTYWx0ZWRfX2TV/8WQO1M7P
 p1+LMRgQt5+gyFjo6XQ/wT7aBge857oYvlLUieImoxbFnoz0s+VkDZgwppqp4pSQrrLzOgK+xal
 0389LUF84F5CYOW6B8yOfVdp1TzcF2wcxlVhnfVQjgu2ouY44zoPWOqGTkg3KIQik95OL9wJl86
 svD9CSf0YBkzj8xrLK+4F9NQ+U2SlpTkY20hLSCpxrINZ9kPbi7wykzZ5WYnMWtUy8DeGqi5h2l
 ceOVTA3GZpm8XP+4WSxZodMc7YABfdlLBHL4CavlupYbNNrJVep379EvcXGcEZcAM9JtTF4MrIb
 6lHk6SW+lPs1AW1xV3VgfCsWn0oKuc2rLfJriJofK/x6Ku4EPbTq12bwSZeyeyvLvm1ev7gafeY
 UziNIYEtG16WGfqcRGqGZH5BM4gL5Q==
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68c2e080 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=d44SL-O27lfbaZlFGTIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12083

On Wed, Sep 10, 2025 at 09:56:47PM +0800, Lance Yang wrote:
>
>
> On 2025/9/10 20:54, Lance Yang wrote:
> > On Wed, Sep 10, 2025 at 8:42 PM Lance Yang <lance.yang@linux.dev> wrote:
> > >
> > > Hey Yafang,
> > >
> > > On Wed, Sep 10, 2025 at 10:53 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > >
> > > > This patch introduces a new BPF struct_ops called bpf_thp_ops for dynamic
> > > > THP tuning. It includes a hook bpf_hook_thp_get_order(), allowing BPF
> > > > programs to influence THP order selection based on factors such as:
> > > > - Workload identity
> > > >    For example, workloads running in specific containers or cgroups.
> > > > - Allocation context
> > > >    Whether the allocation occurs during a page fault, khugepaged, swap or
> > > >    other paths.
> > > > - VMA's memory advice settings
> > > >    MADV_HUGEPAGE or MADV_NOHUGEPAGE
> > > > - Memory pressure
> > > >    PSI system data or associated cgroup PSI metrics
> > > >
> > > > The kernel API of this new BPF hook is as follows,
> > > >
> > > > /**
> > > >   * @thp_order_fn_t: Get the suggested THP orders from a BPF program for allocation
> > > >   * @vma: vm_area_struct associated with the THP allocation
> > > >   * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE is set
> > > >   *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP_VM_NONE if
> > > >   *            neither is set.
> > > >   * @tva_type: TVA type for current @vma
> > > >   * @orders: Bitmask of requested THP orders for this allocation
> > > >   *          - PMD-mapped allocation if PMD_ORDER is set
> > > >   *          - mTHP allocation otherwise
> > > >   *
> > > >   * Return: The suggested THP order from the BPF program for allocation. It will
> > > >   *         not exceed the highest requested order in @orders. Return -1 to
> > > >   *         indicate that the original requested @orders should remain unchanged.
> > > >   */
> > > > typedef int thp_order_fn_t(struct vm_area_struct *vma,
> > > >                             enum bpf_thp_vma_type vma_type,
> > > >                             enum tva_type tva_type,
> > > >                             unsigned long orders);
> > > >
> > > > Only a single BPF program can be attached at any given time, though it can
> > > > be dynamically updated to adjust the policy. The implementation supports
> > > > anonymous THP, shmem THP, and mTHP, with future extensions planned for
> > > > file-backed THP.
> > > >
> > > > This functionality is only active when system-wide THP is configured to
> > > > madvise or always mode. It remains disabled in never mode. Additionally,
> > > > if THP is explicitly disabled for a specific task via prctl(), this BPF
> > > > functionality will also be unavailable for that task.
> > > >
> > > > This feature requires CONFIG_BPF_GET_THP_ORDER (marked EXPERIMENTAL) to be
> > > > enabled. Note that this capability is currently unstable and may undergo
> > > > significant changes—including potential removal—in future kernel versions.
> > > >
> > > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > > Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > ---
> > > [...]
> > > > diff --git a/mm/huge_memory_bpf.c b/mm/huge_memory_bpf.c
> > > > new file mode 100644
> > > > index 000000000000..525ee22ab598
> > > > --- /dev/null
> > > > +++ b/mm/huge_memory_bpf.c
> > > > @@ -0,0 +1,243 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * BPF-based THP policy management
> > > > + *
> > > > + * Author: Yafang Shao <laoar.shao@gmail.com>
> > > > + */
> > > > +
> > > > +#include <linux/bpf.h>
> > > > +#include <linux/btf.h>
> > > > +#include <linux/huge_mm.h>
> > > > +#include <linux/khugepaged.h>
> > > > +
> > > > +enum bpf_thp_vma_type {
> > > > +       BPF_THP_VM_NONE = 0,
> > > > +       BPF_THP_VM_HUGEPAGE,    /* VM_HUGEPAGE */
> > > > +       BPF_THP_VM_NOHUGEPAGE,  /* VM_NOHUGEPAGE */
> > > > +};
> > > > +
> > > > +/**
> > > > + * @thp_order_fn_t: Get the suggested THP orders from a BPF program for allocation
> > > > + * @vma: vm_area_struct associated with the THP allocation
> > > > + * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE is set
> > > > + *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP_VM_NONE if
> > > > + *            neither is set.
> > > > + * @tva_type: TVA type for current @vma
> > > > + * @orders: Bitmask of requested THP orders for this allocation
> > > > + *          - PMD-mapped allocation if PMD_ORDER is set
> > > > + *          - mTHP allocation otherwise
> > > > + *
> > > > + * Return: The suggested THP order from the BPF program for allocation. It will
> > > > + *         not exceed the highest requested order in @orders. Return -1 to
> > > > + *         indicate that the original requested @orders should remain unchanged.
> > >
> > > A minor documentation nit: the comment says "Return -1 to indicate that the
> > > original requested @orders should remain unchanged". It might be slightly
> > > clearer to say "Return a negative value to fall back to the original
> > > behavior". This would cover all error codes as well ;)
> > >
> > > > + */
> > > > +typedef int thp_order_fn_t(struct vm_area_struct *vma,
> > > > +                          enum bpf_thp_vma_type vma_type,
> > > > +                          enum tva_type tva_type,
> > > > +                          unsigned long orders);
> > >
> > > Sorry if I'm missing some context here since I haven't tracked the whole
> > > series closely.
> > >
> > > Regarding the return value for thp_order_fn_t: right now it returns a
> > > single int order. I was thinking, what if we let it return an unsigned
> > > long bitmask of orders instead? This seems like it would be more flexible
> > > down the road, especially if we get more mTHP sizes to choose from. It
> > > would also make the API more consistent, as bpf_hook_thp_get_orders()
> > > itself returns an unsigned long ;)
> >
> > I just realized a flaw in my previous suggestion :(
> >
> > Changing the return type of thp_order_fn_t to unsigned long for consistency
> > and flexibility. However, I completely overlooked that this would prevent
> > the BPF program from returning negative error codes ...
> >
> > Thanks,
> > Lance
> >
> > >
> > > Also, for future extensions, it might be a good idea to add a reserved
> > > flags argument to the thp_order_fn_t signature.
> > >
> > > For example thp_order_fn_t(..., unsigned long flags).
> > >
> > > This would give us aforward-compatible way to add new semantics later
> > > without breaking the ABI and needing a v2. We could just require it to be
> > > 0 for now.
> > >
> > > Thanks for the great work!
> > > Lance
>
>
> Forgot to add:
>
> Noticed that if the hook returns 0, bpf_hook_thp_get_orders() falls
> back to 'orders', preventing us from dynamically disabling mTHP
> allocations.
>
> Honoring a return of 0 is critical for our use case, which is to
> dynamically disable mTHP for low-priority containers when memory gets
> low in mixed workloads.

Right, yeah we shouldn't just default back to orders should we. The user _knows_
what orders are available and should select one.

Actually that logic is a bit weird overall let me reply again to patch...

>
> And then re-enable it for them when memory is back above the low
> watermark.

