Return-Path: <bpf+bounces-48239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BA0A0598A
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 12:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23258160690
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 11:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D17D1F890B;
	Wed,  8 Jan 2025 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AX/KBT9E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MiKqabGZ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86371F427A;
	Wed,  8 Jan 2025 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736335218; cv=fail; b=MYfM7XR0PSygGL64qKAJzx99Iu46VQfgbHQI60AHRRWBla+i7lKC91renM3oZtoJXBcepfunIVcw6G3NVQ3hG1OrLNCzpuLgRtDCmEOly3jFZJVMo2Vp3ta1+5JHeSSHhnSRoPVP6t9Y1+7rbS6sdgmy1pqSaxg6CgBB/ZynLCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736335218; c=relaxed/simple;
	bh=22N7Lf3mYMxg+nt99EciMVPCR2YDYmhmYw7UAE2CNG8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RUBmt16ofknRNCoCcCZ034SujVsmC5oW0NyS3SkEsUNw4yiA1g7Vz9HexFGfP6fnESmMeR4bamUCh1bk5qFmumJVcyuEmnPomrTSX3gbzS0qMR0z/sLGT+dFN9+t3FLVQwNAhLW2h4h8aatcwOPvkmJ1GbMjNhW+zGPuFX/SGHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AX/KBT9E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MiKqabGZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5081tptE005917;
	Wed, 8 Jan 2025 11:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QRwFKmgftlWAOdWCfWyPbZ8YjgWan3xxdqUGaEUXwkE=; b=
	AX/KBT9E5AXxaV6tsjOEicfZhXgqeAcwenWmGT3SJnGdqItHn0vFSmgH96OfawJb
	EvlKPuT7fbhSOQ//nFjJhy0xGzPlkyHxaANrCTFXsCf7fOzRR45OuhyDKeFSY3py
	RdzNycJQx+NmBiLe2XpdEqg/0nq4rlR2OACYPs8/tdoIj1FyHrfMAkNObL1jHpwY
	F9uHuPLtiVkMZ/U1DdpiUaq2p9uCHHogPW0g8W9tk4QPwYKAYGZDglKrpU3CayMh
	sIIWb8Wd6BH+edwZ8am8FTU/C7uikFjiFRnA2F63zs0YjRGxCctGbjnh9f/RnY5G
	HBgSKJGwp+pntChuo3hP3g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xwhspebr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 11:19:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508AnkDT020210;
	Wed, 8 Jan 2025 11:19:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xuefyj9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 11:19:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVADOFiEz9oRmtp2JuiRVgNtq34TooJAO0IgOiIxzkuHd0Habsbp38Dqm7UJGOt7xL6ydP9p7dYQ5Lk1Xpo8rfI0tFiWk9295qVO0Hn02HeVhMHrnYOG6XbYIEo/W47Nn7189dD6wvu6f3jVl81/hYq2S8tyvlhjmHbacjk1V56AtTHlxadtW9iv0I3bQwxblk1V00pR1zoOXIKd2CGNv4gUTo1pLGOplbjVZZDqZa0GPt+wHN/UW7BnsYNzQrMmA2ajQWg5Z28MFMTBqDrkcxdN+v8iihLdSTf+wyj0o6G+F26s8fV73WDqdnjSjtkMYnKQLVPIyB6nu0WowRiKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRwFKmgftlWAOdWCfWyPbZ8YjgWan3xxdqUGaEUXwkE=;
 b=BOqeBSKbInwFjL4oYutvNWJ/a+HvQO/yfF6fX84N+KSchMBpknAr/ynbLDXdZNUz2XpZzQdz+W5mc2Y1fGfcElcTXLjc+DX2reC5D5txs9i3GjDXhifaUGFqnh2NX9By7DCXL6tyfQkNh125SvXbxzuAoRg3g7qMK/oMucUv0cvKyl3RFj80Lx0ydyts8cdEe/CHWNAlgXibv7Tp2sS3ZURl/vlNBTlbkd4Z1MS6FOJtMDeL4/zNWbMk2+NMuRN+L+KDxOTDPUnszHAJItVNtV6Hr4/B5/F1ZF5l+abFiYdFeWyf4g3DPcsFbywifEubNo2EXwmXlP6pZT0gFOnEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRwFKmgftlWAOdWCfWyPbZ8YjgWan3xxdqUGaEUXwkE=;
 b=MiKqabGZT8Ps+Zpu8oAwYXY3uG6RFNJ3oVdBBiyjIC8bW1wcfxc8Rhm/8184ueldWMFchK96HJhVmh2v4/pvbMQ3nxBqHXDgJ4CJ6Rjn+e3CsNiUHy+zzXNsszp1xAnrYnZQKAi0+DywOxZA8fOzlOEgnFZh2SfGZtIz7jGLRXU=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB5880.namprd10.prod.outlook.com (2603:10b6:510:127::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 11:19:17 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 11:19:17 +0000
Message-ID: <41a44111-fa49-460a-afa3-2bad7758c60e@oracle.com>
Date: Wed, 8 Jan 2025 11:19:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] ftrace: Add print_function_args()
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Donglin Peng <dolinux.peng@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paul Walmsley
 <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Guo Ren <guoren@kernel.org>,
        Zheng Yejian <zhengyejian@huaweicloud.com>, bpf@vger.kernel.org
References: <20241223201347.609298489@goodmis.org>
 <20241223201541.898496620@goodmis.org>
 <CAErzpms4g8=3486Uv-PPxiA0GSkNQQm1Ez67eo-H3LtAhTAJCA@mail.gmail.com>
 <20250108135217.9db8d131835acfb6ce4baa88@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250108135217.9db8d131835acfb6ce4baa88@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0664.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::8) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c16a5f-4b2c-4043-441f-08dd2fd64a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sk5JYmZmOCsxdXNLRUtXQnB3dExxZWNSYUkvS2RGd2tIaFdQcmErNXhGcGZi?=
 =?utf-8?B?NmpFOXh1czlvMUlSZ3luSkkxRHRHclp5eURFc2tHaHFHdW04bmhQUHBHK0tS?=
 =?utf-8?B?eVJyYTZxRFA1TlNVMjEzbDVtelBGMkQ5WjBsRWlQWExQNmxWZjVzL3JZbzU0?=
 =?utf-8?B?Zk1BSmtIQ3E3cnozd0NMOGpGOHFTdFRUSDRkMXhjRzlucWJyVE9yWUpJSGZo?=
 =?utf-8?B?Q2g3VklDSWwyYXpHYzhQMkh1VUhKQ3phR3pubjAvaVlZNGpKSzJKWUtwOVQx?=
 =?utf-8?B?NjNLWnhQc0ptTGxvREplWldXaDhTK0xINkFTbThZclFndXdnMzVaVEJjdUty?=
 =?utf-8?B?REJrREEyb1VPaGRRdEF2ekVKVndUOGV4S09qZHB1a2tlK04ybkU1SUpyL1hp?=
 =?utf-8?B?TUMrT1lJUGlwMkNNRFZOUmwvUWduSDNEUWk5VkNrVGdVaUpaWGxOSXVlMktY?=
 =?utf-8?B?dk1walBweUVUUi9RdVRjVHFOUjkwZ2lNd2Z4SjBFbVNEcnFHaXJSNkRvbll3?=
 =?utf-8?B?RTZjdDg0Q045U0gxd0t5Ti82ZXJOR3NjYU8rb294bDZvU1E4dWlBNUZCUzll?=
 =?utf-8?B?Z2hzZk5qNVBySHN5RFVZaEtLWXoraG52SFVrckpvRWJPRVB4VVdPZkpSL0dJ?=
 =?utf-8?B?d3JVQU5YTlQ0Slh2THhxNmwxNnFMNWZTSnlQY3RmLys4Y0FIakZZVG4yaWs3?=
 =?utf-8?B?VDRsMEVSdVhnNUkzODczcU9sdUYzZ29rdHJJRStiWTErRGlrRTY0LzYzbE5p?=
 =?utf-8?B?NFhSdFpkam1xWGN5VWszVEdHVktCN3AzSGpQcXFQczZPbFBzc1VtM1QzbmNj?=
 =?utf-8?B?U1dSYTZNVmxhaUVZSy9HaC9UTGdtOEJjWDZvVHhGekJMZ2p0NHFhSExCZkJr?=
 =?utf-8?B?SkRWUFE3N2xOT0c1WXNJTGozdTlzOUpzREY5SHAvZHd4bHhOcm1hNkIwU1dq?=
 =?utf-8?B?RDk0dEMreEo5OFBWNjRtNzIwR0dxcWdnRnZSUVRibnE1RENxQjFhTXZUSWUv?=
 =?utf-8?B?ZW5QVUlYblJwWGs2S0hUdFYzcTBKNFAvVC9lc3dySEs5NVhQci9tUU55eURQ?=
 =?utf-8?B?WUtwa2t6SklsVnBvUUs2TjlTcjhzako4K2NTUVVXT2xERTdiMjkyb3czQ0di?=
 =?utf-8?B?UHJmV1BaRXhpVEZhVVlnQVBxOFFxaHhQdkZIL1RYZ1QzSzYzeVRyWGNscDht?=
 =?utf-8?B?SndEdWlObC9sd2liajhFR2piUzBFUGlCWW96cDVaTVgzc05xQUxtY3FlLytR?=
 =?utf-8?B?SllqOTU4QnlObDNtOHZsVGY5Y1o5TTdRS3RrWWNvb2g5Y1h0cWFHeUl5ZjBk?=
 =?utf-8?B?d1JMOUhCZGxjTDhxWlpyMlZJQVB3bTVuRTFpY2NVZkNtRzZnbVpkQ2hKL0Zu?=
 =?utf-8?B?YmhlN1Z0U1d0dDlMdTRXdEdsTkdTWVdCTm1sSTNvbHh6K21sL1dXY1Q4YW9u?=
 =?utf-8?B?VHNJdFpuclMxZXQzdVplV2xEYVVLV2J0UkZEUzNqMTY5bFBjKzhIc2dsdjU0?=
 =?utf-8?B?L2JMR0sxd2hiMUJNeEFwc0w0TXg4OEduVDB4ZUltY09hOHRLSjRncXA4TzJW?=
 =?utf-8?B?aVNmZFRXVUZPaldZRTMwdFZ5ZWpuN1RRSXFkMTN3ZjVScHBEK0taWVVOUzBQ?=
 =?utf-8?B?SmxmeDMwb2dBTDY5UTlsbkZ1Rk1tVmoyT1lyV2dpQURlR1R3RTE1dTVaNW1v?=
 =?utf-8?B?UTNiKyt5cEI3MnJnM0d3RjlmWDIxU3JPbFZ1T2Ntamk2bXE1d3pSV3ZCZFVN?=
 =?utf-8?B?N3NrQklvMmhCZXVJSjVkSzZHUkFkTVIzSnB6N3lLdmxQbktTYnoyTDVNK1R3?=
 =?utf-8?B?MEZ3eTRRUzR3ODVOWWhaU2FtVnAvTkFwUk0vYzlMcDgwU0Z2MzRGMmorUWMr?=
 =?utf-8?Q?DV4Q6rvCqlqhl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1UrSXRScFZJV01LKzlNUldCbzJmd3JZS0JaRklUM21wZDc1WUY2VWJja3BT?=
 =?utf-8?B?RkZzdDcwVkJJblFqZFNDU3Z5bVBnRm16bExxNU5FOU9lUjBoNmlXbk9RQ3ls?=
 =?utf-8?B?V0VxOUtMdTZYbzBESU5ObVltOHpzSHhxK2VDMGxWYjFIZFN1Mml0amFDQUhl?=
 =?utf-8?B?TGVXZ3lOZFhOc056bHpVNEZpdnI5MmFkQ3lmekZ2YzMzSjlldkhUdGNKdkZS?=
 =?utf-8?B?RUx1SHdzNGtKWDJBNDdFaGtSMExtTWhDQXE0Z29FaDkydnh3SSt0K0Z5TVNJ?=
 =?utf-8?B?bnA3Q2Nxa3JWU1V2QUVsaTBNZmRyN05PYkJ3bU1jUVgyS21BNTA0NzM2eExI?=
 =?utf-8?B?TEpIcnFsR05JUmI0WUM3ZHNkeVVRL29iMTZWRlUrU29ObTFyYnRiVlEvcHpK?=
 =?utf-8?B?b25IRkhaRjFLdURMYjgzVjdJUXJIKzM3VnN2eS9iVmtTTGRvUU5YTmdjM3BX?=
 =?utf-8?B?VUF5N1JITjJCb1VNeXVTUVo3dHNCUjI1T2EvRkRoKzIwcGZRUmNQMWxLZ2Y2?=
 =?utf-8?B?V1FLUE5IQmx6YU5pQmdVbE1DS0hHbzE3cW9iYWRWWVNiaHZtM25aMTJxc1d4?=
 =?utf-8?B?ZUFGRDR2a2lrNmVnYzhSWXRTRGVQWVpvUEFrd3FHQlFuNS8rV3dKcmwvdFFY?=
 =?utf-8?B?UmwydHp1aUd4eGZHVGwyVTF1YmtZUjR5TmZtUmVYRFl3Ym4vdUJ4TzlGMkpU?=
 =?utf-8?B?WWttOFpRaDk1SlFiREZEeFR5RmdmNm1JV0hRbVhVWXQ1MDdXeWtlNWduSEpF?=
 =?utf-8?B?d0pkL3BxUUhXMXNWcmk1S1JZbDZxYlBvRURINy9HUWNmeHBaVHpNeFpBYWJ2?=
 =?utf-8?B?Q29ZRUlWSHRVelg3RHZmOW4rK0FiT1dsSVdveERQWnVQTjFqVkhmayt0TFl1?=
 =?utf-8?B?UDgxK2xONlppL20ySjNmcEdSajE0TysrRHJKZ2hyaHVSYmdSUTVxN3dmY1NI?=
 =?utf-8?B?NXA4QUdtUzM1YTZCMnc0eFJIM3RXdmo1dGVwR2tWcENxbHFVbmd6eElWc28y?=
 =?utf-8?B?UzRHTWFjSHNtdURRV3hoY0crQXVlcjhSL3Z3OFgvL1M1NDhUZTZ6T0t3RzMr?=
 =?utf-8?B?TURzaEkwNEdUbkl6eGpLbktvdEVSRjBTQ3BHM3p0RWFJSFVuRmFUWllaMndX?=
 =?utf-8?B?Mzd3NXZPTElaVnpjVGlSWU1PQlFNTzVoV2ZodU9MUEp6OFdpT3U3bnhqcXJI?=
 =?utf-8?B?ZHA4Tm44aktsMDhBVUdTM1VtblV0eWdDVnhadWcxc0ZQemJUWFkyOTM4Vzht?=
 =?utf-8?B?MklqY2t3THZJdTJ6QkwyR2FrOTNBNHRWc3pBdEEvMUp3dWdlcFlQbk1YaHBk?=
 =?utf-8?B?R1A0dWRIenlLNWNVTmdybmErSXlvQk40SHhwcGtPS0lGRmk5a0QzUEZCRlBY?=
 =?utf-8?B?OHppemNzWVhDMWFMeHduYXIxQjdLY0gwZnFTajNkZ3NFelJ2ek5JQUlISzRn?=
 =?utf-8?B?V2ptcllZUDlYbkkyQXhXSW9PeFlGZmk4SitKN3YvOGlUeEQ1anA0NFdxWms4?=
 =?utf-8?B?eG45TUpXSlBCdnVMdjVQZ0ZJWERnNnJ0QVpVWHRGcUk3TUR0eEZxY0RBZ1U0?=
 =?utf-8?B?RHU2QmpLRFZYakRPbXNrQTlWbkRLQTVVSjhORlNFN3Z3RGZOWUhQS1JlSU9C?=
 =?utf-8?B?OGk4NlFueVdGV2Rqcm1nYk0vMnM5dVBnbkZ0eHljRUhrZ0tLNmh0VzZSaVlN?=
 =?utf-8?B?R1BoZ2p6N2o2MmFYMzhiZnMvYVZ6V2drRzg0dGZEMkFrNk1CQStDZW9aMW1s?=
 =?utf-8?B?bDRiekI4YWpPNDlVUXI1dGl6U1I5QmxxRHNMVVJkS3JnWm1ZdG43OEJ1dloy?=
 =?utf-8?B?bDhjU2N4SEVlWGZhMWI5U3FuS3Iva29SemVDV3BoVyswRGNUN2lWMzZFZ0pZ?=
 =?utf-8?B?ajZJMmVDeVFyZHhNMVBhWnFTU2NxVEZoby9OZW40bytGNGFxbEI3Um52Mmtm?=
 =?utf-8?B?MlovNHdSQVc2TU5MUWF1c1VTblFxMXRRWDFsajVpZURJbXRhSVFoMkZEQ3dB?=
 =?utf-8?B?NC84YWtDL0hOeDQ1OVNKUFFBWGNxWjdwc3gxWU12VWh5ZUlXRHltM0dCdkFa?=
 =?utf-8?B?Myt0a3dsWmNEd0JBdjUxTG1TTlNmMVNKNldTZHdkOGk4TW9hTlVic0RaNzZL?=
 =?utf-8?B?akF1OWhLVUZ5Qm5wWmJHRXR1YnVZRklxS3lVOUp2TUJDR2VDNURYTk13azFG?=
 =?utf-8?Q?w1dghA2npu82PyMPefhHWrE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xW2DIOmXzgtevU7YPqRM4x2Jgp8DuXI7dc7I89JS+JiovZW2go5SG06rUw7qQ1kokvMFP+a6K1ZRa3Cfsab6G1Vinv3Rm7tn6p8E5hFLKqZ/o7EpXqudrt2AMIW9qMFFaJnmVZKeHY6iSGeIq+1qBxd+H3ujCpFLGxaxDkzv4tAqLI3JD4tm7tV+TfzWQ01JQrNFDD0z8TryQjznpc49OC4A4cQ1Xu3LsBSF0TP2VCY0yw0j+furuF92IVE/uORhPcKCoCrPYBz08IBQMM6xa77h6K+WzbceuKMHXjqk/eQDTVpc87esxZomCFZJ6RqpAm8AzzIf90Gh5ZbXZuSzCiIPRYszhhPV2skJDKnZEtxjlHMDg5ctTqiU6IQEJaeuNBybuodkqKe4fUxRMb/ugQwZ2JFWTv5dR1QIPLcaOs+kQ+TCTFUPLz/BvFkYADrf03TLJEQyGUXP0Epv814/Ad1JSOeInH6C+Iqrvp0+DDe3YFz02ySSEXadscKhE01cO7sbHMD+Vckdch1Zf+JXkVhk2fAjakdkNq6WeBTGpXy0Jjsy/cqQzlzvkF0h8u0mrTewhHmxkMydZhMv7aXnl4X5v6oURtF6pr6k5yF26A8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c16a5f-4b2c-4043-441f-08dd2fd64a81
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:19:17.7003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rkU5CrcVnIj9LPomIJxeSA7qktuwDLBcEXn/HDDvPsQvCg/NCEuMLeNaj3kMOQkLjg/PcsaXW/VOyFk89vSOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5880
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_02,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080092
X-Proofpoint-GUID: iQhk_mz7xbIeQjytHVJ-EJWALcbo_Erh
X-Proofpoint-ORIG-GUID: iQhk_mz7xbIeQjytHVJ-EJWALcbo_Erh

On 08/01/2025 04:52, Masami Hiramatsu (Google) wrote:
> On Wed, 8 Jan 2025 10:30:08 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
> 
>> Steven Rostedt <rostedt@goodmis.org>于2024年12月24日 周二04:14写道：
>>
>>> From: Sven Schnelle <svens@linux.ibm.com>
>>>
>>> Add a function to decode argument types with the help of BTF. Will
>>> be used to display arguments in the function and function graph
>>> tracer.
>>>
>>> It can only handle simply arguments and up to FTRACE_REGS_MAX_ARGS number
>>> of arguments. When it hits a max, it will print ", ...":
>>>
>>>    page_to_skb(vi=0xffff8d53842dc980, rq=0xffff8d53843a0800,
>>> page=0xfffffc2e04337c00, offset=6160, len=64, truesize=1536, ...)
>>>
>>> And if it hits an argument that is not recognized, it will print the raw
>>> value and the type of argument it is:
>>>
>>>    make_vfsuid(idmap=0xffffffff87f99db8, fs_userns=0xffffffff87e543c0,
>>> kuid=0x0 (STRUCT))
>>>    __pti_set_user_pgtbl(pgdp=0xffff8d5384ab47f8, pgd=0x110e74067 (STRUCT))
>>>
>>> Co-developed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>> ---
>>> Changes since v1:
>>> https://lore.kernel.org/20240904065908.1009086-5-svens@linux.ibm.com
>>>
>>>  - Added Config option FUNCTION_TRACE_ARGS to this patch
>>>   (unconditional if dependencies are met)
>>>
>>>  - Changed the print_function_args() function to take an array of
>>>    unsigned long args and not the ftrace_regs pointer. The ftrace_regs
>>>    should be opaque from generic code.
>>>
>>>  - Have the function print the name of an BTF type that is not supported.
>>>
>>>  - Added FTRACE_REGS_MAX_ARGS as the number of arguments saved in
>>>    the event and printed out.
>>>
>>>  - Print "...," if the number of arguments goes past FTRACE_REGS_MAX_ARGS.
>>>
>>>  include/linux/ftrace_regs.h |  5 +++
>>>  kernel/trace/Kconfig        |  6 +++
>>>  kernel/trace/trace_output.c | 78 +++++++++++++++++++++++++++++++++++++
>>>  kernel/trace/trace_output.h |  9 +++++
>>>  4 files changed, 98 insertions(+)
>>>
>>> diff --git a/include/linux/ftrace_regs.h b/include/linux/ftrace_regs.h
>>> index bbc1873ca6b8..15627ceea9bc 100644
>>> --- a/include/linux/ftrace_regs.h
>>> +++ b/include/linux/ftrace_regs.h
>>> @@ -35,4 +35,9 @@ struct ftrace_regs;
>>>
>>>  #endif /* HAVE_ARCH_FTRACE_REGS */
>>>
>>> +/* This can be overridden by the architectures */
>>> +#ifndef FTRACE_REGS_MAX_ARGS
>>> +# define FTRACE_REGS_MAX_ARGS  6
>>> +#endif
>>> +
>>>  #endif /* _LINUX_FTRACE_REGS_H */
>>> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
>>> index d570b8b9c0a9..60412c1012ef 100644
>>> --- a/kernel/trace/Kconfig
>>> +++ b/kernel/trace/Kconfig
>>> @@ -263,6 +263,12 @@ config FUNCTION_GRAPH_RETADDR
>>>           the function is called. This feature is off by default, and you
>>> can
>>>           enable it via the trace option funcgraph-retaddr.
>>>
>>> +config FUNCTION_TRACE_ARGS
>>> +       bool
>>> +       depends on HAVE_FUNCTION_ARG_ACCESS_API
>>> +       depends on DEBUG_INFO_BTF
>>> +       default y
>>> +
>>>  config DYNAMIC_FTRACE
>>>         bool "enable/disable function tracing dynamically"
>>>         depends on FUNCTION_TRACER
>>> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
>>> index da748b7cbc4d..40d6c7a9e0c4 100644
>>> --- a/kernel/trace/trace_output.c
>>> +++ b/kernel/trace/trace_output.c
>>> @@ -12,8 +12,11 @@
>>>  #include <linux/sched/clock.h>
>>>  #include <linux/sched/mm.h>
>>>  #include <linux/idr.h>
>>> +#include <linux/btf.h>
>>> +#include <linux/bpf.h>
>>>
>>>  #include "trace_output.h"
>>> +#include "trace_btf.h"
>>>
>>>  /* must be a power of 2 */
>>>  #define EVENT_HASHSIZE 128
>>> @@ -680,6 +683,81 @@ int trace_print_lat_context(struct trace_iterator
>>> *iter)
>>>         return !trace_seq_has_overflowed(s);
>>>  }
>>>
>>> +#ifdef CONFIG_FUNCTION_TRACE_ARGS
>>> +void print_function_args(struct trace_seq *s, unsigned long *args,
>>> +                        unsigned long func)
>>> +{
>>> +       const struct btf_param *param;
>>> +       const struct btf_type *t;
>>> +       const char *param_name;
>>> +       char name[KSYM_NAME_LEN];
>>> +       unsigned long arg;
>>> +       struct btf *btf;
>>> +       s32 tid, nr = 0;
>>> +       int i;
>>> +
>>> +       trace_seq_printf(s, "(");
>>> +
>>> +       if (!args)
>>> +               goto out;
>>> +       if (lookup_symbol_name(func, name))
>>> +               goto out;
>>> +
>>> +       btf = bpf_get_btf_vmlinux();
>>> +       if (IS_ERR_OR_NULL(btf))
>>> +               goto out;
>>
>>
>> There is no need to the retrieve the BTF of vmlinux, as btf_find_func_proto
>> will return the correct BTF via its second parameter.
> 
> Good catch! The second parameter of btf_find_func_proto() is output.
>

One thought here - with btf_find_func_proto(), we will try kernel BTF
and then proceed to module BTF, iterating over all modules to find the
function prototype. So where we are tracing module functions this could
get expensive if such a function is frequently encountered, and it also
opens up the risk that we end up using the wrong function prototype from
the wrong module that just happens to match on function name.

So I wonder if we could use the function address to do a more guided
lookup. Perhaps we could use kallsyms_lookup(), retrieving the
(potential) module name. Then maybe modify the signature of
btf_find_func_proto() to take an optional module name parameter to avoid
iteration? None of this is strictly needed, but it may speed things up a
bit and give us more accurate parameter info for those few cases with
name clashes, so could be done as a follow-up if needed. Thanks!

Alan

> Thank you,
> 
>>
>> — donglin
>>
>>
>>> +
>>> +       t = btf_find_func_proto(name, &btf);
>>> +       if (IS_ERR_OR_NULL(t))
>>> +               goto out;
>>> +
>>> +       param = btf_get_func_param(t, &nr);
>>> +       if (!param)
>>> +               goto out_put;
>>> +
>>> +       for (i = 0; i < nr; i++) {
>>> +               /* This only prints what the arch allows (6 args by
>>> default) */
>>> +               if (i == FTRACE_REGS_MAX_ARGS) {
>>> +                       trace_seq_puts(s, "...");
>>> +                       break;
>>> +               }
>>> +
>>> +               arg = args[i];
>>> +
>>> +               param_name = btf_name_by_offset(btf, param[i].name_off);
>>> +               if (param_name)
>>> +                       trace_seq_printf(s, "%s=", param_name);
>>> +               t = btf_type_skip_modifiers(btf, param[i].type, &tid);
>>> +
>>> +               switch (t ? BTF_INFO_KIND(t->info) : BTF_KIND_UNKN) {
>>> +               case BTF_KIND_UNKN:
>>> +                       trace_seq_putc(s, '?');
>>> +                       /* Still print unknown type values */
>>> +                       fallthrough;
>>> +               case BTF_KIND_PTR:
>>> +                       trace_seq_printf(s, "0x%lx", arg);
>>> +                       break;
>>> +               case BTF_KIND_INT:
>>> +                       trace_seq_printf(s, "%ld", arg);
>>> +                       break;
>>> +               case BTF_KIND_ENUM:
>>> +                       trace_seq_printf(s, "%ld", arg);
>>> +                       break;
>>> +               default:
>>> +                       /* This does not handle complex arguments */
>>> +                       trace_seq_printf(s, "0x%lx (%s)", arg,
>>> btf_type_str(t));
>>> +                       break;
>>> +               }
>>> +               if (i < nr - 1)
>>> +                       trace_seq_printf(s, ", ");
>>> +       }
>>> +out_put:
>>> +       btf_put(btf);
>>> +out:
>>> +       trace_seq_printf(s, ")");
>>> +}
>>> +#endif
>>> +
>>>  /**
>>>   * ftrace_find_event - find a registered event
>>>   * @type: the type of event to look for
>>> diff --git a/kernel/trace/trace_output.h b/kernel/trace/trace_output.h
>>> index dca40f1f1da4..2e305364f2a9 100644
>>> --- a/kernel/trace/trace_output.h
>>> +++ b/kernel/trace/trace_output.h
>>> @@ -41,5 +41,14 @@ extern struct rw_semaphore trace_event_sem;
>>>  #define SEQ_PUT_HEX_FIELD(s, x)                                \
>>>         trace_seq_putmem_hex(s, &(x), sizeof(x))
>>>
>>> +#ifdef CONFIG_FUNCTION_TRACE_ARGS
>>> +void print_function_args(struct trace_seq *s, unsigned long *args,
>>> +                        unsigned long func);
>>> +#else
>>> +static inline void print_function_args(struct trace_seq *s, unsigned long
>>> *args,
>>> +                                      unsigned long func) {
>>> +       trace_seq_puts(s, "()");
>>> +}
>>> +#endif
>>>  #endif
>>>
>>> --
>>> 2.45.2
>>>
>>>
>>>
> 
> 


