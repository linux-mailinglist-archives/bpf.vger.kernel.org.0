Return-Path: <bpf+bounces-58719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3A9AC07AB
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 10:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566E53B75F2
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 08:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C11221FAB;
	Thu, 22 May 2025 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XeioRezM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i8jaZhU5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A6521579C
	for <bpf@vger.kernel.org>; Thu, 22 May 2025 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903750; cv=fail; b=Ayw9myztdviCW4bURVBSkkG3+WdF1OZ1NcO2biVWqHLNlk0hfvXhWBXFGTyixKRIlmie7/zW64N0AEYb743PM21YWvd9W6eu5JVG5GMpDSrISkqyCPgFZaTMn5DZ4O8a1FdNaJ4rbZ5VgELzq+NT//lZxVeDZApxHAY//nNDodU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903750; c=relaxed/simple;
	bh=qaVJZLF+kQJvYi3jZ30jYvgDt5AShnzU/VlrPilGvLs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sFHE4EV/rAD9nbQQKGOYh23ZxbtUdylHTFrP5EQm696upHP756oWVRPcA5uNNlC8meag+0hHFPbbUmnPs0F3lJK9g3uBjZsD3SGWJxAzwHAD93XHHKWnc6DlcF42TDVFVhqaIaBn2qtoO6l5wKEiO5WvpX/8S4Rw3TqaKoNHHwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XeioRezM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i8jaZhU5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M7Bso4011258;
	Thu, 22 May 2025 08:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lxG6pxI5oE4fVBSRnaiMxjzvvFqahmrqKCecC8jOfFI=; b=
	XeioRezMdtQIM9JCOYsWIqlxVF/s0GvhfoYBqZRxsGQ4Si2X3BjtzrnSGm3v7Kaz
	9GEqueNBRes6eOJCWmDIgWQgyqc8Q+4oGWWB2DCJ0dSAqoVhc3Gzqw8XZi9loasQ
	NLoBRWRxfXRi7CV/FC5MT4P0ll9YA+5O1P6dkeT2LRf6IoMrLuWauSxsCMV2d1PL
	ybz021Zcp1w9LEJcdbZc8dXzGODgxsb9u0imJ7mMa8basWvKcNq0HA6kXfNlD6N4
	/DY8u0s+HhPB6MtzCNt25yFQsOepxAtPrrNpjHcAbwwnIxwKUG8EUyay5Id/mXUc
	GMEqDM4p2cvE2NtLuZkGBw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46syatg6p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 08:48:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54M8K8F3032146;
	Thu, 22 May 2025 08:48:48 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwendbuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 08:48:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbc5uOFy4whRVFEOCn5V+d++6X3HrZIS87VnneelAVSwzIB6EBBmKTRJmYY6nRJcW/EueOixUh1LQ+F46apFkpjYjjoQl2+V768n4/p+iHDYgwkqEp/RGpLEvg5MWRmysS2gv49ZClvgyr4lbbB7NYS0oW2cQ9mr4oLTBhEp5zjAqSp7Ach0FWdB78Ku2LWz+I87NwpNyrFHRgH1Xzcvs7D6nuqV6ppyDSoC+W7K1Bm5mbCw48Ha7jX5Icxa49Y1mJjWrfU6PsCLhuj6rApq3xVJHGds9SwNrk7V8dFZ2968K1ThwG31ASvfk2aBktgsqvsXSjcjw0dpWx1ja6pEMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxG6pxI5oE4fVBSRnaiMxjzvvFqahmrqKCecC8jOfFI=;
 b=H+wWTjXB84mN5baOxjnPLLw9K6DP8NWRSZxHlmwXdh99gQdyIaxnMStXdhJVz/shSh+iLrIjd9nvugc+Ub29IluSOs4oZGC854TMGV8onARXvpHpRRbbhxyoVD13D4Sh58secJwKM7MvMDbtQEpkRp0rHue/wUNafWglrOVDACyeumnvZIGWXnnQfBgSTtMVX0A8LEVTB1D9yVUUI1RYnKLrelFRnBPpnKjpB5xav73oem81S8G0GKQpjV0IB6zQnZPANeDCrpf3DLSjuQWgwhoHT/FfTNlXpUwi5bttSrOgbrweck6DqCfORnL/WNVVbTb0BcSbWXVsNxuIM6k3Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxG6pxI5oE4fVBSRnaiMxjzvvFqahmrqKCecC8jOfFI=;
 b=i8jaZhU5z245plWGAfrfv0namk43vxK3uMmnOFzSIJy/CAFXno9DKCplFbq6Rfx5sRz0nZy7Ktg1hiSLYeJGKkSEbb6YJOyluvq9FrxAO/1hzkVTTWAx0vy7/iYP+eV+/YwmultVe4RLyf37gFj8mB/ZXP/uBvbU7SrWBR2/hII=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM4PR10MB7507.namprd10.prod.outlook.com (2603:10b6:8:187::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Thu, 22 May
 2025 08:48:37 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 08:48:37 +0000
Message-ID: <2160a4ad-b09c-4dfb-98c8-5d3b78a6788a@oracle.com>
Date: Thu, 22 May 2025 09:48:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1] libbpf: Fix inheritance of BTF pointer size
To: Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20250522062116.1885601-1-tony.ambardar@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250522062116.1885601-1-tony.ambardar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0346.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::9) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM4PR10MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: d2880678-f56c-4583-fc19-08dd990d7158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mjk4T2tER2FPME1LNzB5ODkwY2UxTGg1ZUxqaldEVDFQZHlqZWpjSExadGlX?=
 =?utf-8?B?NzNqOHlvSUhVeFRMdWUvRzhzL01oamNLWkR2MHNzRDNNa040ZVpWK29BNG9r?=
 =?utf-8?B?SU5HV3pJSjJlb2dWcElWOEdxN1Q1VkJzZzFwZk9sN1R2ZU5XOUZ5T0FEWi80?=
 =?utf-8?B?YXVjYStMNkNmeUIzSDhrNDUzMFN3RnJCWk84cFBMRUJYNkZVYXg5VTlab3lY?=
 =?utf-8?B?cXRoZlprRDhkOU43alVCS1YzOFJOL3FvYWROYmVOb1J4RFhTeHVCQW1SYUlr?=
 =?utf-8?B?R0g3Z1dtRlJ2Ylg5S3laa0MzOTNUajBpZXh5bE1EaUVuNjNld2UvLzlWakEz?=
 =?utf-8?B?bXVrWmhhQkVUSVZVUW0vZG1PZnZCYnJjQXJJSWN6Zkdzd2lCZ2pPV1hLS08w?=
 =?utf-8?B?SXJJUkFLbUtsbE5kSDJlZy9xeFY4MkZvZDdxTW9LS21FSUN1UFZpMWl0bFlV?=
 =?utf-8?B?RWpaMkZ3UmdBQ1ZvWWZqOEJEekVZMEd0UVB1ekl4alBEamErakJMZ01nbXFF?=
 =?utf-8?B?ejUwWVU3S1pSN1Q4dk9BclFzWlpWcmVhdnIvUC91elBIMit0NDRPdmIreUxS?=
 =?utf-8?B?QytYNXlHazBldERLRTBDK2IzOS94bHdSS25BWko4R21xaTBDeU1yRXRkRitp?=
 =?utf-8?B?QkR3ZmREcW11dGN4K0R4aW5oYVVvWmdITDJxN0xSU2QxOGVGZlEvTlZ1NW8r?=
 =?utf-8?B?K0MxQjNudEZCN2N5UUZQYVhlWHpucUZic3VNd2tZQlc2cWF6NFRiRzdCNUZl?=
 =?utf-8?B?WGlKUnlXamI4YWRUVUxvdHBBNFdHNlpkbzJ3dVg4ejZvTHRKRWlzdFdoUmxY?=
 =?utf-8?B?OWhkR0NjZkdrdHlYQk1CVVhiMHYwMVZSWFZIREJtMGducUxpY0xWN2drWGxw?=
 =?utf-8?B?ZUVoNVBLTGxtSksrMlE5aG9CR2hpRkJMUlhzZXJVNEFwZ0VMZkwzdTNTZW9R?=
 =?utf-8?B?elJXekdydFJQeEtrb1JHbWFMQmJHU0lvQlpsOGRQb0t2LzNzUVg1UEQ0blFY?=
 =?utf-8?B?WWUxR0x0RDJzK1hIdnZXYjhYb0F0blhFU3NDeHRWZXI5NTdKNVZkamhvU1Jw?=
 =?utf-8?B?Q2lIajFOMUVUdEczYzRWUkZYUmw4K0FnK3I4NG4rME1NNUlPemJldVlyaEt5?=
 =?utf-8?B?QjYzVzhmTXlNT3lURDF3a1hScFRkc3BXZjl1WjdtK2I5SUJyZGUvMTVOdVJF?=
 =?utf-8?B?bFp2eUJXcTNHdmtrSlQ2azhwL3RPQmtNUHJOTnA0OXMrK1BKb0xtcTlzcE9C?=
 =?utf-8?B?dVovcWlaMGpVUlpHM09IYW5rWkp0UVk5eHAvK3ppTWlabU1LRjRmc2hXVWVi?=
 =?utf-8?B?UW1YZzFGR2liNTNiVWRJSXFOc2JXMDNiUXc5aHpVc2tUWndsZnRUTmR5L0F2?=
 =?utf-8?B?SHRLaTRWMVNLL0g1QVVBZFRxM1VSNzhuaHJoL0xROGdka2FCbUN3bWtLMEl0?=
 =?utf-8?B?dUhvbFhyNkV1QUVGT2ZWMkNKWFdkaEZibUlScmlGdDhHNC80YnhCV2ZySm9X?=
 =?utf-8?B?UkhSc3lwVnhiSVlMRTVsS05md0ZNUUZoOGtnWmtPNDBwNGhSN1JadDBnYTRp?=
 =?utf-8?B?d01NNDZaUEpxNmhTN0NFVUQ4dmpQL1F4T2p5OSs0OVlUbHNTRnZXY0ZrOTFp?=
 =?utf-8?B?L0FLWU1FVisrdERGNFJtN0Y2TC8rN0g2dlhVWTMzbG8relBQdGVEcjJkMGhs?=
 =?utf-8?B?dGpJSFNnRnpIV0c1SVFxQzU5YzlCdFdIRWRzVlBBdTNuaFFZeDJzaWZ3ZGVo?=
 =?utf-8?B?UlpEcDFhWmZwUDI4Vm5XUTNsWFJrMmttYUp0QmdPMXRzUUQxbHZURWxOTm01?=
 =?utf-8?B?ZFRNMHFOZ0hXM3pHeS95V0lsWnllM3VGTTBYemhqbEpYUmordTYrZW93SDRx?=
 =?utf-8?B?c21Fc1hHZ3lQNnRjbncxVkorSGw2a3NwU2JiVURKZG96dnJST0VkUXh0d3Bn?=
 =?utf-8?Q?34i4lFC99IE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzhZOWd2VTNFaFJKWFFZckNWejhMMmhpNzNYSlgvYm84WE9QWHRCL01aSGQ2?=
 =?utf-8?B?ZXJ6RlFWTGtOQVVqZURXRjJ1V0RCQTJKTm14TjlGM3ZIaUpYM2xlRXpHWENJ?=
 =?utf-8?B?RWNyK0J1djJHYXVFZ1dNUXZIY3gwMTlJVG5iQ24ydFZIZ3F5QThlN05sdTBC?=
 =?utf-8?B?R2NabGcwTVlmV1ZyZ3BMR2s1TjZITDJicXFycmJWamNVRTJnRUd4K0xrNXJX?=
 =?utf-8?B?bGFRZHJaVGxrcUZIM2xBdGE3MUc0MzUxeEVsQlZvODNKcU1nakpTT0Vvbmt2?=
 =?utf-8?B?SlpKM29lc3RoWFpLNC96eWFjZGd1QnpHVTZsR0RCSmg4ZEFUTWVmWkdvaE1Q?=
 =?utf-8?B?QkRTcTc0TFZCNDFEWmpUZnMzL3hXYmlPVVhOV2UzQWJ3anFkQWozb01JTCtZ?=
 =?utf-8?B?Ny9rMXlWcFZDcHNzWExMd0JSalJDUTFiSHhEK1lxSXlDbVFCYUZHWmxvWDBZ?=
 =?utf-8?B?Q1JHcTRSSFZtTE1ocE9ad01tV2MxT1FaY0lhWXF0UGZCYXpTMFZnZ0d6Zm12?=
 =?utf-8?B?NTd5b25TTVV6Slk2Y2tzRS9hVUt1cGtGVGRDNUEwS0lvejNXSWV2SldaYkZY?=
 =?utf-8?B?Z2VFTHEvanJkNjdZVW1ucGFWdE84K2JKa1p0b3JjdlFSTklXbUUxNzBkZ2Uy?=
 =?utf-8?B?eWdzTTQ4YXdjeTVSMnk2bUJua2JWN290VThkOXBlMHFZemppajlBZTByZ0hR?=
 =?utf-8?B?ckxDYjdhWDQzNmtsblg2cWdNMHVlNmxaM3l3M1p5Si9PMzNuR1ZzaGhza085?=
 =?utf-8?B?R1B2eEp1L1g1NWNYaEN4VUlwTWhSdmhBc201aDE1Lzh0ekcyRUJjaHMzWmpU?=
 =?utf-8?B?MVpheCtpYW12MGNreXgwQVVEWWRjTTdpTjhqaDNxRkNwdUdwZ2JrWi9kVEZS?=
 =?utf-8?B?b05vRktRSzA0N3RlaWNERkRhS2VVUUpJRUxzMnhPSjN2a1daQ0krUEdpTm5C?=
 =?utf-8?B?UjF6TDYvRTVtM3NEd2NzUnJNY3drNWhSVXlXd04wM3pHdjQ4MTBQVUJuVElG?=
 =?utf-8?B?bEJlRlgrSEhsWHFmclFJVTIxY0VVbXRQMlY1cEpRWW1PaU0vZ0I2TUhCTHJZ?=
 =?utf-8?B?SGR5MmI3REhjazZRZU1VbzFtRCtpVU13WEZmRU1KTGd6RXB6UUlpVndBalM1?=
 =?utf-8?B?YzAxVUFydm91UkM2Y1paRmFjNlhveERyY0FPUDI2dTRPNWZXNzhMS1lZNHZs?=
 =?utf-8?B?eVZ2T1Nsb1ZTalJXTzBYNW1oMnc1VjFyVEd5YkFKSlJ1ZjFzbnd2eG01WmE4?=
 =?utf-8?B?Zm5GdVYvV3pkQU4yMmpyM1NINzBHZnlxMjd5aUN0djhsQUxXK3VHZ3orTDNm?=
 =?utf-8?B?QUdPSzk1a0diNUlFczMrb3B6VXk0MHpsMFVSenZLaWtGaVlxdGR1WTRISk11?=
 =?utf-8?B?RjBaNmVualVERUpwVThpQnY1YmlReTU5M1RsVmk4c2hDd2NZQXU4RktMemox?=
 =?utf-8?B?aVNhcTVnbjljR1ZlblBYT2ZlSE44NkZKVE5Nb3NsQnFHb0hJQlFiUWg1TkVq?=
 =?utf-8?B?YzFTaGpIMXVjckhiVmxiZElmYVp1UlVjSFZ0Y0VFREptTkU1Ti8rdDZGdWhx?=
 =?utf-8?B?c012bDFFUHJmMk9nZk41aGFkbDdzQllhREZqRVlhK01kS2NoN0RmVlVZYnlB?=
 =?utf-8?B?MURVOEtJaXA0aGYydmM5dG9ibDNrMVN0V0Ewbm5LY1d2RlBuQ2RqNDhYN1o1?=
 =?utf-8?B?SXlIa01yejlBWnNNeXhDaTR3My93SHhkTTBPSEtVcHVxSjNhTUZ6SmNXK3Zs?=
 =?utf-8?B?Q2dmR0dtOWFWMVdkTW1rNGRPUCtYQ2gyY0VWQXdHM3BvMWNMUG9tdGVnUUxl?=
 =?utf-8?B?S21jQmRjSEJJRkxYSDJrd0pTN0xUME9hR29vcTFsODNnMmRiazAzK1FJdlpK?=
 =?utf-8?B?M0ZQay9xdUs5ejlUUXhuajN0ZnlSem90TStZTWxONmlMSXR0aXdxeXdoZXla?=
 =?utf-8?B?Qnl6T0lRYzUzbTFyOE1YcXhSS3NZenFUNlNxZnE4dmE1OTI3TUxteGhDNzgz?=
 =?utf-8?B?eFdVN21VdnNGQ1BRdklSeWpYbjdsZ2tYTXNadUlnYURUS0s1RmdJTG1OaUJF?=
 =?utf-8?B?aWl3TjNYNHZDUVV0MjBXRG1oUDl6U3Z0UTJoMFMyWDZpeFo4SStnSG4yNkls?=
 =?utf-8?B?ODZDT2JSeVJqaC9STlY3d2oyS01RODl6TW5Ba1lmUkhyWmN6eGc0TlNpNFlu?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z/NLjwCujxuofrPsfDULZnzoDKYUcqyqjNTxjmJF7DtqEVQrB8ZZ9WMwsHuKyUA/l8+hQLJG32jARGxOyi7i9f3J+TdYW3LcZ3UaUyPO6PCwWlbaJR2oWTOY7gULAfnRAWZwTPhi31Ln3UA1Wt/afh89jFhEVHgOVkc1h2HKJKOHCkYfQuMF4+9bhlIAHo7SBOoUAdxla2y3506vvi2VW9f2WaAzoj9UfWXu5r/ofg8KrvH8oR5o2LOjtQOqHy3d0vC2qodszcw07MSTTLfVeMYmapfg26uuR7fnxw1kp2mZpY1Wt/UmrKBOahv5LyQepHzlzFZ79HTclCtekK0fVH+0doPqZ2r8PhUAGmwqshGn9pelZYgSdXS7xvS9LRxLm0zq0Ir9I26NhKahjHLdkjhUPW7oT3grUbjASXdqSmd/q0Guv/4OolHZEk/q9NVRBN2YOFDQbrTjnnGzDorD5mmhNw/JAaA64Bx/psbUE6CLgfcDsHJYA6IlvHhq9KlKWhGh5IkGzoAjX2XMCbWUaqa1EtSDqieNncmwgd3A9adU4Rcu3Iw9G9k+WZE7hB0fMT4deo2rDu/5TrazzrAhrC24Tb0P8/4fizy8/NTLvOQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2880678-f56c-4583-fc19-08dd990d7158
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 08:48:37.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GdT+mMtJY/BvhJlR3x3yhulf9tTR9qMzglt7LzaL+HodtkMcwdIZPP3rRXTFesN0fq8oEd1XUQJTg6Zfqgdbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505220088
X-Proofpoint-ORIG-GUID: zksNkkhXtpVgqLiIWTIq21RG6nnqtgr4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA4OCBTYWx0ZWRfX4jMJbahIM3Ox iXFq13xG4Lgr3fKYygGXAiX56Vkm65HCM1jWJvhLJIbieoMVigYV3aazrEAlhM0ojUCtaLrMddX RhxkF8SKNV+Z+6QVrTluPDp8JHicS+nnSI45GwHBdeXSkREg6+iikCW8ckw9R696YykjRRpOHlf
 e3/AN1vLht0uRS40R7YlAKu1aaERU/m+YfqGRu21LEbSJORfp+ytN36Z2/iY2YdapdxGH+Jxz2G d0aflbyBW4Aei2NseQfTFclYlKA6iYOlNG+4Qz1kTj+q56k2J4T8NLqDaqDzy6/hhmlhLXUH99b rYdc/W3B647AUj0zG4amqUlFMsF1i3eJoes1W1/R3ibFopZp7RHL4v6FDbZfezQKCTSVnN+C0TK
 VIBLaGtq2FjyIbva1XE4YcT/vyWtPGDUUr8s9a6Ne1Uwh3S+/5nQVV7fvL8UjpITblhO7KOk
X-Proofpoint-GUID: zksNkkhXtpVgqLiIWTIq21RG6nnqtgr4
X-Authority-Analysis: v=2.4 cv=HesUTjE8 c=1 sm=1 tr=0 ts=682ee4f1 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=Jaw-fTsDVI281xZFXmQA:9 a=QEXdDO2ut3YA:10

On 22/05/2025 07:21, Tony Ambardar wrote:
> Update btf_new_empty() to copy the pointer size from a provided base BTF.
> This ensures split BTF works properly and fixes test failures seen on
> 32-bit targets:
> 
>   root@qemu-armhf:/usr/libexec/kselftests-bpf# ./test_progs -a btf_split
>   __test_btf_split:PASS:empty_main_btf 0 nsec
>   __test_btf_split:PASS:main_ptr_sz 0 nsec
>   __test_btf_split:PASS:empty_split_btf 0 nsec
>   __test_btf_split:FAIL:inherit_ptr_sz unexpected inherit_ptr_sz: actual 4 != expected 8
>   [...]
>   #41/1    btf_split/single_split:FAIL
> 
> Fixes: ba451366bf44 ("libbpf: Implement basic split BTF support")
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>

Great catch! Nit: should we use the btf_ptr_sz(base_btf) helper here?
That would cover the edge case where base BTF does not have ptr_sz set,
as in the absence of a base pointer size this will then determine the
pointer size from the BTF itself. The reason I ask is it seems like the
BTF raw parsing codepath may not set the pointer size, and we will use
that raw parsing to parse vmlinux BTF from /sys/kernel/btf/vmlinux (ELF
parsing uses the ELF class to set pointer size so we are good there I think)

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/lib/bpf/btf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 8d0d0b645a75..b1977888b35e 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -995,6 +995,7 @@ static struct btf *btf_new_empty(struct btf *base_btf)
>  
>  	if (base_btf) {
>  		btf->base_btf = base_btf;
> +		btf->ptr_sz = base_btf->ptr_sz;
>  		btf->start_id = btf__type_cnt(base_btf);
>  		btf->start_str_off = base_btf->hdr->str_len + base_btf->start_str_off;
>  		btf->swapped_endian = base_btf->swapped_endian;


