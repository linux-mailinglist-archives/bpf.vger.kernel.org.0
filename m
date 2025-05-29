Return-Path: <bpf+bounces-59292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D97AC7E2F
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 14:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D554E4DBA
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 12:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662B62248BD;
	Thu, 29 May 2025 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o0eiDSS4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r1mnVrQk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2048121421E;
	Thu, 29 May 2025 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748523236; cv=fail; b=THZctAsyxiZbW6yxlhzYt/Wcu4Bx+E3reY8al8HJal5kpQtFfUZQd8+Y/28E3nEiAl0zRd74vELPqVKAZ8InGv3O0e/mhNVxlTfPljXxtrwn9H7XaVcmBtuhRPxKGUaAxhXKaIyiPDr33HYHiJTrNzrVOo9X/NjfZbdTZqPMOKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748523236; c=relaxed/simple;
	bh=naeOxa0qfv/bDIretGfDKB6r/cfygYj6yl69ECJVuL8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MOU2vYys92Ruax4eRx52JKpslNottxMbo/JVJgKKDEypo6tOPFbaSyYse6CmGXt6rb1GaMRO6OYh1GuWPkXgN6U/fANoLYnHWa7TTYguDixUtdTZ9m/fOQNPBpxqhPBSgJYcbKVNRR8l/1XnSZxaONJgoiaI8jZ2ruLZRHGZTtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o0eiDSS4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r1mnVrQk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T7tsEW013042;
	Thu, 29 May 2025 12:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nUTpAAczDH2s28JXEzhxVj0LHsyUTPNre0+W5x41tx8=; b=
	o0eiDSS4VZKjpHExvDtCII2VgYqCElO6eG8W51xMWDh7YlC3P6tiKO+5m07UXa6h
	+ojXA+W4ipe6YOK/Lvy6boVKawiFlvknN/XZIIx3Ib5XUeqcYevdVNOuZaq4Neju
	jzkMnv4xYXIBSL8JfRcf2RMo0hTHfCtatSfI80sBfXXisJhJbfkOGsUXBbJiRZ4k
	OCZ1WsqjO1dkrL/5oSLu5TRART3H9j1pXm2E79uXjNaGB0TK51FjpfeHYzdp2X5m
	LunDgIWT8vsO6yzPwnKJrIcIY+nyDlxYWDwX5VJy/SN/dNjlTDnIc5SiqdliwMix
	UpEc+NwSA+8Q9NqJzEmsyg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0g2g7m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 12:53:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54TAg1ut035716;
	Thu, 29 May 2025 12:53:27 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013027.outbound.protection.outlook.com [40.93.201.27])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jcnk3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 12:53:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5Ic58aIraJdw1L2LlGOqYeVH4eZxAgaXzUZufeGOf9qihKvifBgk4j42nXGOfoMhqKpNFCIlGwB3l2K0g3T4j4nYOHYgWADwcWfadDu2igVAgCNMTKBvBeanOXygxnf8IqKdj+fhUEnRrlUDsROxMs1ZLmKIhW0ND1fNYvNBswyzqnECrK9OYg//NF/r59/4fhwCCcDiJUWYPCbWpBlJUIZtAHh97US+OY+yxkeZJYdvwrR8UtXi7JLgE7BBmYTtBguKdbr8UVQQfmrlNCvaC7OkLASgYdzxW++wC6hupdXZLih88eKHOAUuexL1GFFjNew4XAxbV3WY87O5FNpGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUTpAAczDH2s28JXEzhxVj0LHsyUTPNre0+W5x41tx8=;
 b=aaOzh81P+39tfgFCu2OwlcONTUyZhKkp/5kDJSw0db/hNO0hfo/echcALQ7otfkJOR7dxr/zIrkK/VrZ4hAHtGOPtMX377T7aMrDJh17/aCI6Yor89IjpnT+iob9FQz7GwbUV1PIkZcp88zYAtartaWRMjhF/DNWfDUTInGl/GERJUxe/rur2TOZOl5UDK8VF+qmmvg7Ua0ON+osrmj41/FymoQ/uTJdiNXKfQ/kxW6H0jV9hkyphQdtIaDxEdtWLquG+JtgjHSCvVoD91oGl5WZzCZwgBmiuYgwhVRrr2UZvuUnWBN1dJ9x/69YsEimwEGTHs5dPAAEewDkmKu7Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUTpAAczDH2s28JXEzhxVj0LHsyUTPNre0+W5x41tx8=;
 b=r1mnVrQkD3AKTREqjsj0eNz7Y1IYFhaW5+gr83yxTo0fWNk8a0X7MVBgb9lOhW2ISjxJToMxQfNGihFnnG5YsjT0NWabIlcPVYiwH+xd5L1WYKGNVviqMZ9cRtPvBxWHaG1jR0iRqEPyrV+4MlFIq1Z3yFcl9Vwz7/xKv3xCggM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN6PR10MB7518.namprd10.prod.outlook.com (2603:10b6:208:47c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 29 May
 2025 12:53:16 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8746.035; Thu, 29 May 2025
 12:53:14 +0000
Message-ID: <4cc43d09-50d3-4d92-8785-056cae97808d@oracle.com>
Date: Thu, 29 May 2025 13:53:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 bpf-next 3/9] libbpf: use kind layout to compute an
 unknown kind size
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Quentin Monnet <qmo@kernel.org>,
        Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Thierry Treyer <ttreyer@meta.com>
References: <20250528095743.791722-1-alan.maguire@oracle.com>
 <20250528095743.791722-4-alan.maguire@oracle.com>
 <CAADnVQ+GDezR0e+SgqDB5h885Gd500cGYpFs4_LiXpLuD5gYFg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQ+GDezR0e+SgqDB5h885Gd500cGYpFs4_LiXpLuD5gYFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::32) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MN6PR10MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e66e3d-34ad-4b2a-d78d-08dd9eafc66b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnhQb21zY1NDd3RHcTZXd2ZKTm9XNFJYS3ZicE1xejdpaUxtYzRCNmN3bHJr?=
 =?utf-8?B?S3BhejZET216RHlLb2tyWTdLbGptOERGU0s2RW5VdlZ0NFNJVXowMFhHRFRq?=
 =?utf-8?B?Rll0VGNmT0ZnQVk2OEZXelpUU1NBS0cxZ2JzWjA5bTZCbFU1VzJ2S05SSHRm?=
 =?utf-8?B?aFJEeWdzdG53TjRJZFdkN3J2OGpudjBCVjhpeEtnRXRTbk9hUHBkWFdCdjhj?=
 =?utf-8?B?QnRXd0hNYUxPNU5jdDZab1NHUzBmZEtOaHQwUTVXYk0vcENEMGYraGZnRDU2?=
 =?utf-8?B?NlV6N29WMUgrSUN4eWcyRmhodVhwK0FoWkc3enM4VXk1cFUya0tKZS9iSUxN?=
 =?utf-8?B?NEt3Yy9jZVdEcnB2RWlYZTllZDNGZGNBZFowSFMwdVVZdEJWbVdHNGRERU93?=
 =?utf-8?B?YjVRN2pOYUE0YUc1NVFEYmtud3NncGVKVnQ5Qk1ld09Bd3JBSGRpN3ZZVmpW?=
 =?utf-8?B?bW1lMUJQSmNRL1N6UFZyaElEd201UVVJOEY1V2Jmc1dMOVM5SFdqNE81WHdE?=
 =?utf-8?B?WmdSM2I3Qml1WnR2Z0ExakF1TG5YbDhRWmdhT05kN3VYdmhyTjFnV0w4RWth?=
 =?utf-8?B?NFp4VzZYWnQwM3FuTWpINmdiQWVacG8rUTN4N2NYTEQwOWhUMlA3MnROTk9B?=
 =?utf-8?B?SUdHYWxkelF5WUJOTWZwMUIwcmtOaE9xYTlDV3ZGREdTdmw3MmE1ZGx2MTVa?=
 =?utf-8?B?K1FQVjNHRUUvbVQyOFVSTzNOcThQK3J3THExSHVYbUFRb3FvcE8rbHFvWExJ?=
 =?utf-8?B?eEVzY2gzK2dvL0Ryb3FwNzFuak5lOTR5SUMrZUtaaGVuc1ZMVUlxOFZaNjNI?=
 =?utf-8?B?R1ZIcm1LSEx5ZWlwdjhSNXZmcEVmQVZrMnFMczRPVkEzVHM1RmpxQ04wUEJ5?=
 =?utf-8?B?TUJPNURoeEpSRllmclBIZkVGaUJpY1BYK2tOY0F4bG9NTFBaYVR4OUpjM2Ny?=
 =?utf-8?B?bmFiNWdzV09zb1RFSVJ5RDVaVDU4c1RuMzBIeEJzRjE0SVdiUW82SWtpS2hn?=
 =?utf-8?B?azJRdlR0ZVlLbllKaHlVVDFSUXdxUEl4OUNqMjdkRVkxUGd0ZUV2YVQ3RDFS?=
 =?utf-8?B?TnBDV0dmelBIVm1GZFJaakdHKzcveXpUbEFYQktCc2l4VlZDQVRlUkpzL2Er?=
 =?utf-8?B?a3hBZ09nK2xoV3lieUlTUzlVcktoS1JhanJiZjVJMkp0M2JpNkJwTERkTVlB?=
 =?utf-8?B?dnIxdFBnek1XSkNPYTNaSTRja25yYVY3SHZOb2RZQlhWaE1SeGJ3U2FIOSt2?=
 =?utf-8?B?MGwvUkxPTE1FTnEvbUl1RVZqWW95NVMrZlJzZG1PeFQyOTVZNC9oUmVKRllY?=
 =?utf-8?B?US9pbUNTdmJPZURPdFFLZnRKMDQ3ZHlScng1ZVlUVi91QUZGR1RGVjh6OG1v?=
 =?utf-8?B?U2NmdFZDaEMyQi9ITWs0NGI5YzIwRER0YVJhTEZrODZ1ZmYyTTZUS2wrV0ZB?=
 =?utf-8?B?SWt6cnRkeldoUmYxQU02SmRaYWwrWlYvanRUZm5RUUdvSE9pL1BaQmJGRWl5?=
 =?utf-8?B?TjVZYzRqa2xKalZIVTJwRmpsVjdHSDZycFQzODlYdHZmU29DdmpPSmFXNmsy?=
 =?utf-8?B?aXdlZitBb253aDRkeGU3QnJNbEFCWldyajBsellIdXBrMTA1N0hQN00yL0Q4?=
 =?utf-8?B?Q0poL1RQNWwwYU9Tdi9kOUpRbmJZL0ZDNktNamJTUlZuV216TWlmZ0NzYkxl?=
 =?utf-8?B?eDdqOXdPbTAvTkI5MmRBTVY5MytETjBjNStEN1kxYzVPZXZ1WExLeDBNYTBL?=
 =?utf-8?B?K2tROUR5SkJDWDVBYzZkQU5OSXEyVEwvL3c4YXV4TzBaUEIxeTdhaTRBaFNM?=
 =?utf-8?B?clk5UFVEWTR0T0k0N09qWVhRTTZvLzBQL3lERUJnMDNwMDFySmh4cDVsOTdk?=
 =?utf-8?B?TXF0bng4SklVTzFvR3hzbTQ3bThobHk5N0xkWUs1azhXSHBnU2o0S0J3OUxl?=
 =?utf-8?Q?yY04z7boGFI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUQ0Q2pNd3J5N2tKMXp6aGhIbEFIcFVrY0ZQcFhLV2pEeDN1cE9YK1pXR0hE?=
 =?utf-8?B?czBWSThhRS9ZWjk0VUY3S0ZmbmVWU3JGb3JNeXBULzRrcFRITkhiUy9UWkdI?=
 =?utf-8?B?QWtydnFKL3hibVFJVzhESkFlSGs4RHZPajM0bmZ2NkpVbXpqVU1qNjh0dFhG?=
 =?utf-8?B?b3lLYi9FcHpGczZYMk5SR2U5TTNFdVpwbTZ3a2l0N1JCRmR5MCs3aENKN0V4?=
 =?utf-8?B?L1liaitWUWRwWmpoT0dqSHBiVExRVkRMbzRRTVhLKzMvRy9ENGpSeDB1WDdN?=
 =?utf-8?B?NjVHaDR3TXhmYkgxV01IUWkwMExIbzRmTnBsVy9mb1UvcW9PRTRvcW52SmUv?=
 =?utf-8?B?SGlwY0phM1hkUklPM2t0UllqN2NEa3huNUlvMm1ESjVuREVJZ0RYZDlVUEdx?=
 =?utf-8?B?WEl1ZmxlblRnSmd3ZnA0cmlwYkp6cG5LTE5Teko5bGRXbkZsS0JteDl1MVEw?=
 =?utf-8?B?NlROMTRMN1hiVEYyUmpZTWlzbk1scHhWV3R4UlV6aVhTQ0RlNG55eDl6ajJL?=
 =?utf-8?B?Z2E4TGMvVFpFY2FoWGVGRVpWWVVjc2RlbE9rUWgxSXhXc09ZMGZ4Nkt3aFN4?=
 =?utf-8?B?STd6TTlNU0dvempQaGVYc3RJZWhpTHZEVzd5UG5PRFhNWngycDhnLzlPbEFm?=
 =?utf-8?B?dnJWV01CMXFEZWFBdk5vM2dOckNNYWhNZEJ0Z2Y2a2dFK25SeUxCY0xsdjgz?=
 =?utf-8?B?UkYyRkdESnF3SnBZdFhoUE5JWGlkenZoOHorZi9FTFNsV1B0dFdyeUdsNCt1?=
 =?utf-8?B?KzdYRDBObnZvbk56L2JSRHF3OE81TWJhWEdPajNTVmhGd0NISzdvWGhCcnVW?=
 =?utf-8?B?ZXJ5eTYwM2xBVmVRY2xlRkpPNUp1UnUyU0dtT0R4NGVoeURXRGJmS1ExalBR?=
 =?utf-8?B?QitTc2o5eVQ4eHZhV2luTXA2UlZSZ3JUYWtnVGplYVlzY1dRcFY2alBUcnVl?=
 =?utf-8?B?aUJOKzZuT3F6aURVVGxZM2VReGMrTkpJZlpJa1l1Z09SQU91S0RXTlFyQkRC?=
 =?utf-8?B?clNsNHVnMEJlSlFnZDFEZFlkMi9qTzFjMnBncEhNT3dvSFBLY0dERFROdVV2?=
 =?utf-8?B?a3VMM3Q4aXBnbG5WYmFiUXkvMFVjcHZjeWh3RTVzMWszZ2Q0UnFtZ0lOaTJk?=
 =?utf-8?B?bzRNMXJTY29CWHJtRnZWdzB1L1cwb2I4VGJuMHFIV1NhMzd5cS9RQnJ3NEdP?=
 =?utf-8?B?d3c2U3hkN1hWZFpkeWN1SWNGZmFsdkNQQmZIeVNMNUF0bmloOFJVdDhJcGQ4?=
 =?utf-8?B?aXdLUVpUdlVjNVRNeEtYSGtyVFVmY1NhZy91bHNzcGlHL2RvRE9NbW4xekZ2?=
 =?utf-8?B?QWZadzhaRjJkWWRYYXgza2p6NVdpN3ZNbXQzNVJwS2pYNkUzWDMrclkvL1dy?=
 =?utf-8?B?c29jSkdpT1ZLWWpsNWRkeU5waFl0cHlmL2pOeGZPeXZOTVZydVZiV3JSRDlJ?=
 =?utf-8?B?ZHFZTkZ0bWJIUjNlbHp6TGYvOWtoQkx2bXBpYmt5clBRUFJnN3orbDZqME5p?=
 =?utf-8?B?Uk1UYWZUYkpTWGZoaVNUL2J4MHJxZmcxMHZWeEZkTnhMeVFmTzdLWU9vNytt?=
 =?utf-8?B?cVhJcEk5NVBiVU1rQ3ROL3BmTm8yZVd0TTgzcWpHLzdGOGN1YVkrdlBqK0g5?=
 =?utf-8?B?VTVBbHUrdmJxcXdVREE2MzdNWVhGK01yTmNkclZFdm9sZHlwV2IvKzIvQjZE?=
 =?utf-8?B?d1VjdzJja2d6enM5V3QxRFRxSmsrRUdMS0R6RDFLOWhIUkVWTTZndzl6VGNP?=
 =?utf-8?B?NUs1ekVBeUtkdWRrRzMza3BpSmhyTHhCVUtmako1Wmpmclp5Q1pZSXdBWEpl?=
 =?utf-8?B?QzNkN09nU1U3OU5kTG5LZkJnSW1WTlE0UCtwR01MRmtpUnUzVXViY3lBbTJ2?=
 =?utf-8?B?aXQ4d3duZ2J5Z3VWMmxsQmJYUlJma0RTeXJQelVFMzB6ZGJnR1lTQlNqUUll?=
 =?utf-8?B?YlY0NWY5Mlk5ekoycUM5Wi9JRXpXV0ljTHg0UWFJUmY0L29QZHZaWGN5aldt?=
 =?utf-8?B?NzVyRlByVmdFcjRkRU5VTU1QU2swWmtiS2xUL05DOXdobFl5VnFsdkNESllm?=
 =?utf-8?B?b0U1WTZmNm1xRHBPZjRVUVVYWVVYZ3JwcjRJZlhjZUR2NFNpQzdLM2lIN2xa?=
 =?utf-8?B?RlNZS2h5Yy96ayt5RHc4c2dVclp2QkpVN3pjdjRuZEVhc3JJaFd5K0hPYmZa?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eDHQVcznOI2iqshiAg8OKq+zSj37uRDbYc81UnBN5kXO/tEOug/sl/PN5iq1PzbNZsv9lFa+bg3s7GSzwB4l9hjEWMqEIAr6QxvFS7g8+ZunHXGynmvQek8rFZykEnbmESFsJbA66EhhrpgFfOnTPNvl4ARAfk6ao51MR4XI+eIOEX896BaMCl3OeKXLC1YNbLuuRdWKtIodxLOY/Hdjq2xHegn0+SoT00nFm3JC7cocHz1pRoJSF5wZq+2ZJzMCFDL4rBKl/JQMXQLnrzDuC0cDV9WSFDwwqDbidBprtVoxjzGS76n9l/V1GjdnHe5hCPh59vLM2J/Rw0S3WuuMRAdp9amX0I6iPADjUtjVDcjXLRq2+MhnkvKdZJhq2hyw7zN+mCq1tiKhE1EQcgvo5amfYowEPfOHwtoaAW7C3zBndNwVpM79LRHCYHW9gd1HSECLsH5ejr+D1LEdKe6SPqJAOrrGak8aYTTb0A7m+lkB6OU5Hc8gfCF4OihDl5vS72Rhq77u77BFLHlSGUdj2v6tGoqneiS3RSMqA0EuTZyOtky/z2tQGfOqpOsM5Rr+BBZNjDIuNxHufedgVT1L/edWw2WGokDQ6BGfE+gAXb8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e66e3d-34ad-4b2a-d78d-08dd9eafc66b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 12:53:14.4725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NNFE/VgZI+S51wOlobV0OnHA6NRu4XDeZOi1PipBYnVCU7bvMk+zq7UE6gWqSkSdSQTjt5XHD4mjiqm0XuWjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_07,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505290125
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDEyNSBTYWx0ZWRfX4CtMCFF5E8HS 8vjQMDy6F1Yw3/Zu05r8gOudPFH5J20tJ0ROUByDoBqXHDro54nOUdDsnxLQFoRT/G0sM6yZuHo BJzwMJt0jwQOqoYK5KV5OAANq9cNtCNPVgF+u3MTga1wDNBuuXVYMXYhPizI6siVwCehyK4Dh+Y
 e7Bp9KkL8vmkKF+180r4HGupk2hMEg39M0U+eesP/0Z0a1dE2SbOL4l1AvTKR7rhnkD4iYCx8Ae bNLZfgSKgpDNC8C4Qwg65ZGjm06mHSm1jVwIXzAf744bdeeu6/GEnWmHLPD9oehBwDE+YSNgd4w yLofZ3qrVMa17EvkQjBQ+o7icKTk79cceVwCuny1R+pLmv2F5idM0hbADEDSn+813X663oX95fn
 FN2opAIplL7CvmAZ32Q+1xSRUPHKJV4uRJP95IRm0MlFjeBdAtUQL+yHzrhXHICoKKSwPx+U
X-Authority-Analysis: v=2.4 cv=NJLV+16g c=1 sm=1 tr=0 ts=683858c8 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Gxz1WMOlVs9KecIwve8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MaKSzj29uWzMjxPToHsHUvgKR59cbeki
X-Proofpoint-GUID: MaKSzj29uWzMjxPToHsHUvgKR59cbeki

On 29/05/2025 06:35, Alexei Starovoitov wrote:
> On Wed, May 28, 2025 at 2:58 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> This allows BTF parsing to proceed even if we do not know the
>> kind.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/lib/bpf/btf.c | 35 ++++++++++++++++++++++++++++-------
>>  1 file changed, 28 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index 43d1fce8977c..7a197dbfc689 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -355,7 +355,29 @@ static int btf_parse_kind_layout_sec(struct btf *btf)
>>         return 0;
>>  }
>>
>> -static int btf_type_size(const struct btf_type *t)
>> +/* for unknown kinds, consult kind layout. */
>> +static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t)
>> +{
>> +       int size = sizeof(struct btf_type);
>> +       struct btf_kind_layout *k = NULL;
>> +       __u16 vlen = btf_vlen(t);
>> +       __u8 kind = btf_kind(t);
>> +
>> +       if (btf->kind_layout)
>> +               k = &((struct btf_kind_layout *)btf->kind_layout)[kind];
>> +
>> +       if (!k || (void *)k > ((void *)btf->kind_layout + btf->hdr->kind_layout_len)) {
>> +               pr_debug("Unsupported BTF_KIND: %u\n", btf_kind(t));
>> +               return -EINVAL;
> 
> I'm missing the point around kind_layout->flags.
> I was expecting that this helper and others at least
> would check that flags == 0, but none of it is happening.
> The patches say that flags is unused and do nothing.
> Why add flags field at all?
>

The intent of the flags field is to provide space to add additional
information about BTF kind encoding that may prove useful. E.g. at time
of encoding for this kind, was the kind flag supported? Perhaps if the
size/type field specifies a type or a size might be another useful flag
setting. But basically the idea is to provide space for additional
information around kind encoding for future use.

So in that context, should we check that flags are 0 now? I'm not sure,
because in some cases we'd like to have older libbpf be able to handle
newer kind layouts which might make use of flags.

>> +       }
>> +
>> +       size += k->info_sz;
>> +       size += vlen * k->elem_sz;
>> +
>> +       return size;
>> +}


