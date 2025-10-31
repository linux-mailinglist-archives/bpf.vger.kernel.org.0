Return-Path: <bpf+bounces-73158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9445C25556
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 14:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9268C423E6E
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 13:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1576238D52;
	Fri, 31 Oct 2025 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="t7r8d3OO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8491552FD;
	Fri, 31 Oct 2025 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918368; cv=fail; b=VCMZnosdzTpnCrFU5szXVyTPwV7cVZ22a6BT6DtE2+tnB+jCKI43JSVXFImhYVL/WFZEtFJFH4h+VOOg4n9SKY01yyymzJ8n8xhxFvQrxMGztnHzOxDTvSsZEEo7prHOif846cPVr06cRBYiDdaquY11CkA9A6eO++89FS/Rwo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918368; c=relaxed/simple;
	bh=aXpycxgqnymLcE1lFXUpxb1N+zLP6s6QM297GKOQ74Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dsTo0agzoGImdsX5t+WqU+6Sno2OlP1uN+xrm5q1/zBI95VVq447rlwIJlE1Ai+DrGGftSt8SlaFcp8vCPn+oPkggPyps+k6d1XE3wm0Fq7rTl1WN42rqxPmeEXAws4dWdiaGOOFPyg4xzaUIQip+ANbzdpfsDcY6PpYAnmvLik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=t7r8d3OO; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VDArSZ3811491;
	Fri, 31 Oct 2025 06:45:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Ebyt/pnajPmPpmMb7vF4LzHaH+S2qHLtgPt7tNcsCx8=; b=t7r8d3OOmR8B
	eNoBKaUjqt8BZrtezcsu/NZZ9hyY5eJv6kXymkwLbZUJxL/oxAuq8fQha71RSa6R
	LO+0Y1lXg0sYj/JNT/ONsDubxs0x49Ue6PArYUNEWtjeg+RVcTNlJhLpKV0Ob+6z
	znojs/EYyDrOGmkaeM2D2DYyqFDlZfH93Vs9NqUTZ8kZnK6P30IM18xjaOO2gsM5
	89INwg5CmSwXLKQu37IBq4mXqcBVBGSaHjlr8nXfZlwyJkdn32jnXggrlnJIbpo7
	p3MHFX+ODwfA/NWrb9s0ei7yU/MuGp5bJNFqsuAA+OZ5qjC7PLTcwM9qsr18Z/7P
	8JGLZ8zPOg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011043.outbound.protection.outlook.com [40.93.194.43])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a4hgpuwp1-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 06:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrmfMj+MlpwQr9Waul+NKfMqetSA18yk2bFrA3uInSsh+bYsqbBm6ctiuy9m0oF/swxFcS+jdvlURQhTzPiorhLkjM1iv1ddK/vhMF+qfXjsf4rAcVe/xYZJXDDF8IvnvLjDIw7PxiKgTDDZjIINSF0EZ+sNT17DoHZ/kZYKAxhkr3atdTbJp6c9x16Y+YtK2wBi70IH1Fv6blH9+hsKNtICL1/VJLDG3oSz0RJQEB0uwXeMRSrYz3fOWX+INU+cNECdaVu3ZjvsxlJs8voj0Z80Sd4ZjQATY2PfMiMP5XEZvMdlatfKuK0k07YDC/nbI8aJlyfYuOUmmTT07sQnog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ebyt/pnajPmPpmMb7vF4LzHaH+S2qHLtgPt7tNcsCx8=;
 b=LQ20FfPsXyrWlMAECjxuDT6Wmfg6AQfWIZe1mRXiHqBaXjKunqkRZBrDXCj13I72EJgzHSTuF5H7I/a6xhm8Ee5EE7Uloo2U4cOLRUJqKOvB9nA/zaJUuAhpbychxV+TsLYESRLE+Oy4GRXA2dczquiMywWnmb1Bc2q1SQijtnHTIExGV6b1OYbXjHPXNREEMicxy5ncEWVDpGsvizZBTAHg4HNZNbR5sJsHnkk7KndfU7IbllrT9aTrWs2MtGlrHM8Q8KlTy9AJq2WcRbW4mwj1ii/7EHmCCD45eYx/0LpgsLSXjZjbVh+GG6BHTMBBdBWKtqD3bpXZwuvRrxEmiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by BL3PR15MB5409.namprd15.prod.outlook.com (2603:10b6:208:3b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 13:45:42 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 13:45:41 +0000
Message-ID: <2212b2f7-d426-4f2f-abe5-3746dbb31631@meta.com>
Date: Fri, 31 Oct 2025 09:45:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 bpf 2/2] veth: update mem type in xdp_buff
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        netdev@vger.kernel.org, magnus.karlsson@intel.com,
        aleksander.lobakin@intel.com, ilias.apalodimas@linaro.org,
        toke@redhat.com, lorenzo@kernel.org, kuba@kernel.org,
        andrii@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
        yonghong.song@linux.dev, ihor.solodrai@linux.dev
References: <20251029221315.2694841-3-maciej.fijalkowski@intel.com>
 <e9f13992d679d08d193cb40c15c70fbf4adfe9d94a6235b20858fbe161be58a1@mail.kernel.org>
 <aQSvuMWDMyMYRI+W@boxer>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <aQSvuMWDMyMYRI+W@boxer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0009.namprd12.prod.outlook.com
 (2603:10b6:208:a8::22) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|BL3PR15MB5409:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ded489-aaa1-420c-c3de-08de1883c804
X-LD-Processed: 8ae927fe-1255-47a7-a2af-5f3a069daaa2,ExtAddr
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MTdKa3lXY1JSa3ZydjlMM0h3MSs5QmFrR3d1WThYNnFJYWQ5aVVSVXpDU1Jz?=
 =?utf-8?B?RGtFRURtY0ZsV09RN1lYMHRNSGlQNmVXY0o2WWEydGo1ZzNOYXFlTmRjQ1hW?=
 =?utf-8?B?dXFLdmlTcHlMbnNJT2dlSmdnK29ENXdlUEltbVhRWXVucGl2ZkgvcnZZbXEy?=
 =?utf-8?B?dEUrdjdTZkVYQit1V1FXYk5UZG5JbVM2UWZWUnBKNnBvTC82M1hLZGcrd2c1?=
 =?utf-8?B?MWJuUXI3QTc1UGNGNmlCcG9UTVF0cWNzL1I5SGF5Z0JpWWdNdmZrOFI1aGpK?=
 =?utf-8?B?UHJzZS9NRFRIR1pSZTFaOVJKclpWQ3NMM2dSdWNVaStLMlFtelRDbmhnSUJi?=
 =?utf-8?B?aHBNNTZvM2RnQVdzVytMNlQ0eDB2K2hVYkM0L2d0cnVxV1FtR29wZTdQN1Ra?=
 =?utf-8?B?OFpJMFJEZjhzaXhwQnFjejFKelVpMlJHZVFlNHlLbzJWUTNwTXRkYUdyemU0?=
 =?utf-8?B?RCthbHYrdW1aVXBkNWZNNDJ0bzdoVmFJVVBIbThHRkpHNWw0TnRwaWFCcnNl?=
 =?utf-8?B?TUFEdk9ZQTNreEVIUmN5WEQyZXR2VzlESEUzTENMckd6MGdDS1RrQkdIYUN6?=
 =?utf-8?B?Y2NPK2RyUU1EbFkvaENUVUV5SmRVdDNBWkYrTDRhVFdTZHJPVFBSdEMzamNG?=
 =?utf-8?B?bitueFd6UlhPK092NHErU1FBL0tpeloyT2J1eU1QT09NdEZ6citHWlZzclBW?=
 =?utf-8?B?d0RTdXVqQytPT09pU0NwTytpc2k5MHpLQmFVRkpaRWpaK1oyRU40MGUyN3lw?=
 =?utf-8?B?MVU1bjZiRVMySmF5aUZ3NlY1WjVCV05QcGM1M2hKcFQwWGJYNzhkKzBucDVl?=
 =?utf-8?B?UFgwbTNaMmpsSG5Qc3ZQa1ZpUkFRaGpQcHQ4R3lObTA1S3MxWFNKVS9wR3RI?=
 =?utf-8?B?b0xhMlN0RkFnRmFBQUNLM2E5cWs5b1l4SjR3Z05malZ5Rm85NW9udmpuOEhM?=
 =?utf-8?B?L1ZOZkU1Qy8wZ0s2WHZubW8zeFBYdVdqaklQOXdDVHVzNUxVYStiUjJSSWRn?=
 =?utf-8?B?YUpXdVB2TlhnQ0F0SDNjY1I4a1FQQnd0R250K0VZME80MVgxaWtiRzIrOHBM?=
 =?utf-8?B?UmhVMCtEQms4dFFaTUJwWDZpR24vUXg1K1VJNkxNWXNtVE42Z1NhVjZqRmly?=
 =?utf-8?B?VUREL1NLVjh5c09yd2FWR3QzdmlRUkE2QlJrdm40RjlJVGdvSy9Pa0dUUFlq?=
 =?utf-8?B?MkpaSENsc1FFcmtCL0Q1WmlZT0ptcWgvekZkcXNzMSthaGo0TCtWejRKeTN5?=
 =?utf-8?B?ZVRNVlY1Z0p3OFRzUWYvTVVtYXlWZnNYZ1NkajhjUTk3aENCOXA1VVo4Wnhu?=
 =?utf-8?B?MExJWHUzMTRNbFV4Uys3SDZCTDFrZHoxdlRUQ0FJZUhxZnJyM2xLUzlqbVBZ?=
 =?utf-8?B?d0J5SzcvSjlCWExXckJyQU42QmVEMDEyM29HWDBVYjBOS3RmNklWYzBqUGlj?=
 =?utf-8?B?ZTlkWVhQQXZBWGc3U0J1b1ljUVI4dTlIa29Rc3N2S0VoNGNPWm93TlZ4OUZk?=
 =?utf-8?B?NW5xb09JRjAvOGhNNTB4NmhYSDdBOC9iSW9SUTJUTC9rOEFNUmJaSDdkYTFz?=
 =?utf-8?B?UUFxWW0vcG1qbng5QUUzUVRBOThCSG9FbE1PMVMrM0NoMXV4WU5UMnV1aytK?=
 =?utf-8?B?YXBueHF2QjJ0TnlDRk1TSzdjL0xpMW9WcXdPZ2gvcEVZdkI0RmpLYjhnZ0Ir?=
 =?utf-8?B?eXZvQXN0UWk4UEV2MGlXOUxoVkRlZllLbllReTRuWW9FUDVVRmY2VmxCdmJv?=
 =?utf-8?B?ZVhEOG0vM3cyeGl0akFtVElRSW9EbTFUSWZZTDRiZjNOWnkyZVhQdmJOK0du?=
 =?utf-8?B?V2ptc2lEenJ4a1M1RGRSWURWcEVINjZBK0VkRTViVnpnS0w1Z0RrTGF1UFJp?=
 =?utf-8?B?M3dFWVlWZ3VvMEd3VFdXRmVROG12UTFMdVRDcEFFeVdJWnc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QzFWcTNiWU1iNkNWTnFIOXNUemNuUU82UEVOZXFScWEyL2FzR2M5YjZBNjQ5?=
 =?utf-8?B?eitHOUp0RTcwbW1NazNSeFd3RmpUeUorbDE3UDhkbWlySlRwUEhHR2poWFVn?=
 =?utf-8?B?aXF3UVh4UVJ1TzhoRlgvUDQ2R001S2ZnT1AwL3JWZlUvS20yYXFTRzRlRHdz?=
 =?utf-8?B?WTA5cUFMS1dNcktVdFlrcmRsU2NTWUc4Q2Q1YTg5ekdlL2RSNCtwdXUvQmFj?=
 =?utf-8?B?bHlWcFNzVFBpZVlkL0FxYWlKbVhsYW1RT3dQR3p6Q2I2SjVIQndMUlVadW5y?=
 =?utf-8?B?bjY0VHFpdUwyanptNlVZVnJ0ZVFLWlZLSC9JaHlsa3B2Q0RRempMZTBCOUkr?=
 =?utf-8?B?dGxESERvcVFjdW1lR2ZzbXNwKzNSMzRFOHJkT1MyZXc1TDlBc3BnSzBNZU9a?=
 =?utf-8?B?Y1JZblFCbHhmaFhObnBVbVduV1JWYnZOM1lYM0ZYd3ZvZGV4WDNHWHpVZGtB?=
 =?utf-8?B?WWJnSHJra08vMEVtaWF2RkpwMDV6MFkwU2J6QVIzOEhvTUhoR2VLNm5yN2FP?=
 =?utf-8?B?LzBUVStGMlZHNTJhQ3VsL1pYNFhTMDd3SUxkdkNBZDhvMVRiSTVPWUp5dGdQ?=
 =?utf-8?B?N2hBNEJQM1V2bGFrZDR6RzV1SU54T2JHcEdrZzlCM2NtK29uWnFrKzd4NmRX?=
 =?utf-8?B?eDJJUEZJN2ZWRXAzTHFSTnkvR1gxMmxDbjZONUFha3dlMFN4c2VVWmR2bDVL?=
 =?utf-8?B?NUNQRE1wazFsdktMaTlwUW5sWTFRa3p5MFBZRlpQWDUvQnJXWWJoNDVLRWNm?=
 =?utf-8?B?TG9XL1NocGdQTms3bFVZTlQ1TjIvWWJRZlRMSjVYMGdMa1FDWU1LSGloeStQ?=
 =?utf-8?B?b3hncHJsNmFub3pRUFVxOHNwSTljVTRJbEt2SW55ZUEwRWVLYlNFaGVGQU1W?=
 =?utf-8?B?amg4NHJjM3E5clc1ajc1WVZnbitmK2V4Z3NJbGdLN1FNc3pscGdOYW90TUhU?=
 =?utf-8?B?cUJ1RjJmR2VlM3NtZGhsSTJEdHRzQ3p2WU8wNXZvSi9VeGJycStmQUVHVUth?=
 =?utf-8?B?MlQrcy94ZG1OUXRqUHM2QjlFNXBMVjBxbTZXdlRZVmlLZDBzZFlWelB4NE9s?=
 =?utf-8?B?QmJYNllPQ3YzMElvTjR1QURCTXNlQWdNb1JvbUYxVndtUzVteWxIanRSU0Fi?=
 =?utf-8?B?VXpudlZOOTNjeGZZTC9CbjRhc0IrekpKTktVWnVYdUs2WUw2Nk9jc0IrdjRZ?=
 =?utf-8?B?Ri91SzRlNVZXSXN0Q1ppV1c5SEwyV0JtakxydzRPbFo1aWNwNldSTlFqbFk4?=
 =?utf-8?B?TGxtb1NwazVteVQxbmU1STl5Ym9SYThmVkVVWlNEVml5Tno3bUtvSUpwMkNP?=
 =?utf-8?B?RkZIZmh2aE5BK1l0YlRiZUNaS0o0R1ppUjhQazBXRmVzNldpVGZMdVlJano1?=
 =?utf-8?B?NkpxS1JtS0IvZjY0NkZjRlgzSGNIQ09qWUdaNFUwM1pLNTlWcWlXRUxvb0Ft?=
 =?utf-8?B?a1FtTjFVOGFibjRaSTcrNW9YK0pTS1JuV0xrWXo3RmdyUUppOWRXanhtZndM?=
 =?utf-8?B?Z2FwRGtMK3lpSlNKeEZUM0c5VEJmN1NtTjhBYmNPZ0dGT2RLVE93Y05waVJ5?=
 =?utf-8?B?cWlEQ1lQOTdpRU5FYVZRS2ptMUNOd1d1amtTRjUxTm9LTHJzYlk3YmlISEtD?=
 =?utf-8?B?WTIyenEydmt4RkJhQmhkQ0dId21FNXFoNVN6OWQvcDBtaEo2dEg4WGFoNWJN?=
 =?utf-8?B?bGt5S3Y5cG0yZHhLcmZPNEw3ZzQ5bnkvWS9zTDQxSkh3QktONzdhY1d5U2Ft?=
 =?utf-8?B?b3hjK2dFZjRteGVTYWpjMW5WSFQ1QnFRVG1mTmNMYVoxbEJ6aGJJbDB4QXpu?=
 =?utf-8?B?YVZHdHpHRW1JNVRhRzF4c2xWZHhmbmRSUyt4SWlKOEk1RVphUlg2aFFVNXI1?=
 =?utf-8?B?WUNKdTN0RDk4TDFuUHdqQjZEdE5GWE4rOUdIMUc0VEh4amhXdUlPditoeFFE?=
 =?utf-8?B?NHZnblhUZm1JOU11VktVd1d1YnlBVWZuS0NyY1VwdVFtNE9aSyt5Y3FFcGtv?=
 =?utf-8?B?Mys3ZEh6QWZVQkcvZ0xKS3R5bGc2Sk0rekJ6enV0ak1yQmNhLzFRSnMwVVpV?=
 =?utf-8?B?OU1VVVFab1NMUXdKeVNaeHpvYUd1UlhrczJkODc0ZmViNzdzSFo4U0Z2emdC?=
 =?utf-8?Q?tHsM=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ded489-aaa1-420c-c3de-08de1883c804
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 13:45:41.2125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYJ8CeYDZ0GeqzobS917Css7Vr3Gls1sJE7XTaPCJga7+7EaOk6uRtoUJ+k1NIdk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR15MB5409
X-Proofpoint-ORIG-GUID: jHGqludz6jb51xMKqRl2_3C-plG2xctG
X-Proofpoint-GUID: jHGqludz6jb51xMKqRl2_3C-plG2xctG
X-Authority-Analysis: v=2.4 cv=MpBfKmae c=1 sm=1 tr=0 ts=6904bd89 cx=c_pps
 a=CM6yQ3ajfX3ct242QRRZiw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8
 a=Gruxskt2gxcQ3cAXq6wA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEyMyBTYWx0ZWRfXzyU3WudIJH0A
 zeoqi7cdWGVHB2J2P0qItv2cauHesv7O1N4jTlMCwhOQ68h86mzKGXsexs/jIyhkoBWrhu3d7g2
 ZjS9dHxN7l4+MbdJUW4m5kfcNY4+UFKu74hRiHa8cTd9+/en3ENuVX9FuM3j6NRyeIStoYM/J+q
 86Ild7fqTMEAKJEPpNvBSiGNMPv27bmC93kX/N9LPMbDoFf0F90zMdRQmueZHpbZNsgco/BGMGc
 ht3KEqrNSVKSLNn23kzi1fHkHLIkRW7RMWDR5m2JAaeCenI5RRkSfewdlzqdem4GzuoTQKzYAR4
 gjrYbCW+jMUmsVfkpo9s2eYQw7diudo5ZOMlOBFMZueN+yGV1ytEifTKkLJLDohuupfmtCYPZZF
 K4kAHnZ0k1CWwxdETrjpJ07l0gfdzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01

On 10/31/25 8:46 AM, Maciej Fijalkowski wrote:
> On Wed, Oct 29, 2025 at 10:59:36PM +0000, bot+bpf-ci@kernel.org wrote:
>>
>> ```
>> commit 96d6e22337a81e8606de33d22173ff80ab961bc8
>> Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>>
>> veth: update mem type in xdp_buff
>>
>> The commit fixes a page_pool leak by properly detecting page_pool memory
>> and using appropriate reference counting APIs. The xdp_buff mem type is
>> now dynamically set based on skb->pp_recycle instead of always using
>> MEM_TYPE_PAGE_SHARED.
>>
>> Closes: https://lore.kernel.org/bpf/CAADnVQ+bBofJDfieyOYzSmSujSfJwDTQhiz3aJw7hE+4E2_iPA@mail.gmail.com/ 
>>
>>> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
>>> index a3046142c..187f30e2c 100644
>>> --- a/drivers/net/veth.c
>>> +++ b/drivers/net/veth.c
>>
>> [ ... ]
>>
>>> @@ -733,7 +733,7 @@ static void veth_xdp_rcv_bulk_skb(struct veth_rq *rq, void **frames,
>>>  	}
>>>  }
>>>
>>> -static void veth_xdp_get(struct xdp_buff *xdp)
>>> +static void veth_xdp_get_shared(struct xdp_buff *xdp)
>>>  {
>>>  	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
>>>  	int i;
>>> @@ -746,12 +746,33 @@ static void veth_xdp_get(struct xdp_buff *xdp)
>>>  		__skb_frag_ref(&sinfo->frags[i]);
>>>  }
>>>
>>> +static void veth_xdp_get_pp(struct xdp_buff *xdp)
>>> +{
>>> +	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
>>> +	int i;
>>> +
>>> +	page_pool_ref_page(virt_to_page(xdp->data));
>>> +	if (likely(!xdp_buff_has_frags(xdp)))
>>> +		return;
>>> +
>>> +	for (i = 0; i < sinfo->nr_frags; i++) {
>>> +		skb_frag_t *frag = &sinfo->frags[i];
>>> +
>>> +		page_pool_ref_page(netmem_to_page(frag->netmem));
>>> +	}
>>> +}
>>> +
>>> +static void veth_xdp_get(struct xdp_buff *xdp)
>>> +{
>>> +	xdp->rxq->mem.type == MEM_TYPE_PAGE_POOL ?
>>> +		veth_xdp_get_pp(xdp) : veth_xdp_get_shared(xdp);
>>> +}
>>> +
>>
>> [ ... ]
>>
>>> @@ -822,24 +831,24 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
>>>  	case XDP_TX:
>>>  		veth_xdp_get(xdp);
>>>  		consume_skb(skb);
>>> -		xdp->rxq->mem = rq->xdp_mem;
>>>  		if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
>>>  			trace_xdp_exception(rq->dev, xdp_prog, act);
>>>  			stats->rx_drops++;
>>>  			goto err_xdp;
>>>  		}
>>
>> Can veth_xdp_rcv_skb() leak page references in the XDP_TX error path?
>> When veth_xdp_tx() fails, the code jumps to err_xdp without releasing
>> the page references acquired by veth_xdp_get(). The skb was already
>> consumed, so the pages still have the extra references from either
>> veth_xdp_get_pp() or veth_xdp_get_shared().
> 
> You're missing xdp_return_buff() on err_xdp path.

Thanks, looking at the logs, that's exactly what happened.  AI thinks
the goto code looks like this:

drop:
    stats->rx_drops++;
xdp_drop:
    rcu_read_unlock();
    kfree_skb(skb);
err_xdp:
    return NULL;

Since I can't find this code snippet elsewhere in the kernel, I think it
just made it up.  I'll add some language that forces it to confirm the
snippets are correct.

-chris


