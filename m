Return-Path: <bpf+bounces-50421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B847DA276A2
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 16:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D631670EA
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771E521481D;
	Tue,  4 Feb 2025 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n+Ev8LoT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bb7bRRfR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099332147FE
	for <bpf@vger.kernel.org>; Tue,  4 Feb 2025 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684776; cv=fail; b=XiTaNgwh2kLHw1fQDCUVWBgP+16tdF4S+bgvhk4EfooullkMCx3/DqqXonibII1CW+WEn/vxzLQzfs+swdd6lWSAwhxdlTiP8c/6BXqcLfRIru/xtdQxs6vpY4jPcrDkqdgYKJAqpigq4jqhLuiuywhCHM7sQP3achiwCiHUYqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684776; c=relaxed/simple;
	bh=zEKoYXX3Js60Q6YeiKSjt2ew1r8XRu8p4Bg4PZD0oR0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tORhyT+coMAHRPAWiTRvp332Vs3xnOGy/N8GyDKA7DRGGKooGqgCeYt5qWxt7Y73u6Rbm9lBgkOq2JNBNKmxVKFdN0nZROKmrVJwFd/j0/K5IG06s61UkEd2zY94M0Z3+7RqE4nHUJdAN6PC0PAcClKmFaU19XSetQSKcmhCkRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n+Ev8LoT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bb7bRRfR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514DRfaF017243;
	Tue, 4 Feb 2025 15:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QaE4wblc3n/EBmGeVve1DYSntUo9TnMKxSKf9/oBpXM=; b=
	n+Ev8LoT7ftGgDyCQLJQtZFbqRtEDKRl9ghwPRH7udmF1joS1XtNEfXyGDlSpmSY
	mekaOsKyxBG0ooqRa5LmS5U+rcBlWD6z4p9VntL19IQ0VGCMBpZ8IRB4YyKul6Bo
	/MAph/3Zlk5+aB6At1lSF4EBTZBVLy0JdMnP3mtljuD1R6D8jyo57p1R2WN6jNRb
	1gzHQrQOwrY0VNId1QTp9HYVQM6iKRN+4bG6Aj8FIV3beCfowd2j4oxY1/UwUjO3
	3DQS307NrFmpSTte2mXm4RwnI1TcjeMIs+IeCjz9hWwGOgSvGvZIG3rqpFJ2/FCu
	wSkYlvMVp1NLKML+6c+Mdw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hh73mx76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 15:59:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 514Eh3cA029134;
	Tue, 4 Feb 2025 15:59:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8p35nvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 15:59:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEcGNMyIH2DyoJmShnsPUUs/nyjRh5SVhg1jPuk5TolLnl5gk4FY3dVJX6oQ7xJ9Zj31ErfY1u1ja3xRllew43e0lRZlCB612qXdC7I4rGeuxgpiuwMmUEWrzul3bD6nCUk1Tzw8Mt6f9P8DwZyutljgcIBQaXzqWNxI8H7Qm9M5rh/XVXDvXK8l7+Lu59TI/5ajBbkqXlpW7NqdtZ6+74JeHxu9tJjeLR/im1BKbo0JqXszqLhF3l+ojfrHsyW4z9jiQl/+9DyWu+gxsBTJZ21BVp37ZtRg0a+mddAmLz8NbTmaalX506WNU4yNmeQVirgTF5M+IuVzsZ++8wod1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaE4wblc3n/EBmGeVve1DYSntUo9TnMKxSKf9/oBpXM=;
 b=NmsminlMICkorgjnqjZG8BJBPRnVj25PDq+Cu4fS4Pev4uD07TSsUv97tDJzz6eJ4TU03gDUi/4RAsOtrmhipwzCzz5R1tod12YChK2B329b71WZauW1tlrazjIPcp9gC+VjQqMxpTCC9Au892tMiB0gRRM8JzwErlCf6ZAR3LHUvnAlbU8TmJMyKVqGgpGxYvh+hZmrShVNfsUlX7+3EGXzv41I0fIfK20jS3Uq9NeOAmmC/bh8msQwdIGKeFeRlsv7YtvzZoqYivSZV85SuiDuirqq7k/xTuOOALovQAtWGFT6ygYRfzxD4OPAvdF2kmd0VnxN2CWFhS1l0vb7cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaE4wblc3n/EBmGeVve1DYSntUo9TnMKxSKf9/oBpXM=;
 b=Bb7bRRfR7Fag0Nf5i9FpRBGYzVgQvlf0s4miQ6qmUJ5j4ztGznfEhkliNHwx3P//elvIhKT7y74FhEgYYlclYf3otyQSby4d3NlKnU5C5C0xYHz0EI6cO5R3tB3VHpbF9hgnvJ/XZRyWl3KWj0RNp+3mwFCxGuhiTRyW6Bk2KWU=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM4PR10MB6277.namprd10.prod.outlook.com (2603:10b6:8:b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 15:58:02 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 15:58:02 +0000
Message-ID: <b84f9ad6-7c1c-4451-b6f8-3717019c16ba@oracle.com>
Date: Tue, 4 Feb 2025 15:53:23 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf/arena: fix softlockup in arena_map_free on 64k
 page kernel
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Colm Harrington <colm.harrington@oracle.com>
References: <20250204092455.3693003-1-alan.maguire@oracle.com>
 <CAADnVQLPMphk-5RyYfJ5E=UxkkUDdoigLWD7trmLRfT37zG26w@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQLPMphk-5RyYfJ5E=UxkkUDdoigLWD7trmLRfT37zG26w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0032.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM4PR10MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 608b7c58-aee6-425d-6ff3-08dd4534b45c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzlSU2pFYmRJbVpmSW8vNnVkRmo3enBzWUVROGFlUUU4ZTErd0h6ZGlSRVNv?=
 =?utf-8?B?MnoveFN0VHpsR0RrS1ExbGNBTzI2UGM2WDlQV1JOdEpVWXlZUHQzNFlGYkdM?=
 =?utf-8?B?TEZ5MFdyVHg2NXJyYThrY3pQUjZaS3Nnb2NxN1BsQVJCUm1QT3kraE9zaGh1?=
 =?utf-8?B?aERZZTlVeGQ5ajE3VDY4U284b2dHM0RvekxkZjdGRUpRY3lSWnVIdmJ4MGkv?=
 =?utf-8?B?dVA4UVJWaUUvL2h5ZS93ZFpncDN6ZVdjcWdueG1tbythZTB0YTVNKzBjc3VX?=
 =?utf-8?B?WHY0NUwxaldHV0toZ2d2elpDNUJTV0RaZkM1K1ptK3FUUDc3d1VoK2ZnWGYz?=
 =?utf-8?B?cXE3eTZ2V2YrZzlBQXhobTM3MGQ3eVhkdG0xQnZ5d3NJc1A2am9WdURmRFpO?=
 =?utf-8?B?eG9aMjFuVTBGVmNvbGVQdUpHejZva29lUVE3UGt4RnAyNkR0cG9pdzlZQUd2?=
 =?utf-8?B?aE41S2RPbUZ6Nzg3QVI2dVBzY3liOTNUY3FIVDYrNW8vZkNnbFc1T05UOHgw?=
 =?utf-8?B?Q0lFM2x4VFpSQlVHZFFiRWxpaDBrc1pEY2ZURzBKMVo1Z1kxaWEvT2NmWGZu?=
 =?utf-8?B?cUlvWHdNSFNMWFR4NVVEQzVaNGJHNzdEUFJsYTJ1SHlITklZRTQzT3pnY2hx?=
 =?utf-8?B?MHJxa0N0eU11VnlLaHhFYUxYYWNZT2pjOTE3S0tHbGN2djR5cVhUTnpRa1Jj?=
 =?utf-8?B?K2wvUFY0eDI2Y3EvR1QyTUJYQjc2a0EvR3YrUmRCQjNacUJ2Ri9LZWJLUisz?=
 =?utf-8?B?S01VenVHOVZKbXlvaGhnemg2MURQb0VYUVJnSDdsVVNjSXA4RFd2Njg0WjRm?=
 =?utf-8?B?TXM3N05HWHJzN3lGRGxMYXRmRkFoN3duQUdqeEsvVEk1bWlJNDhhWWgydVg3?=
 =?utf-8?B?dFJDSDM2N0J6c1pndkxqSENVZlJhbmowc1ZBTHVYTVA0c0VQVXRpVnhyVm9J?=
 =?utf-8?B?NExaY0lEMmJ4cGdIOWxkVTF1bGNDYVNpWFY4MVRnVXc3UkhRSmdEQXg0d1Zw?=
 =?utf-8?B?WS85THhKWmJxaDlPcWpLN3IvaHVSbkE4ZUU5RUQxZ2gxbW5uUE40RkY2ZnFk?=
 =?utf-8?B?bUlWMEdWRG5sQ1BSZkg3M2xDTjFiVmRCOXBhYm9oOVpPcXUra0Z5U1R2ZENo?=
 =?utf-8?B?TG1vZU5lNUxKRlRORDYzUG5QeThIRzdRVkZRWHN6TXdUSzJjUHFaUm5sbUxU?=
 =?utf-8?B?c0I1VTdseHZRM2JDTjB4anAvMHFBeWFUWmRpN2FqQWU3cmNEQUFLdWZPY2E0?=
 =?utf-8?B?d0ZIbFpoTGs3RGppNHB1eG1uVmpUbEtZWmROZ0ExOWNZR3F5Y2hpNTg3c1lO?=
 =?utf-8?B?NlVnKzQvRnF6TlUrN3J0bG1Xd2V4c3JWaUNTK29ySEtWMTZCWXdSNlhVbUFl?=
 =?utf-8?B?TlBNWlRVdlY3dm9FcGVSeXEvQTFWS1BJOTVsWCtaOE1EVEhtajJKRzEzSFJq?=
 =?utf-8?B?amdKM3M4S1paTkNRaXJXSERMZWErSjhHcDh6eWpSSS9ldTRMd2hTQ3NYeTBu?=
 =?utf-8?B?OHRwcFhkUVdGUWIxVEhJNVFJRngraVpVL0NoSVkxZUMzOTNuaGpwUlQ1Mnh5?=
 =?utf-8?B?MFJYM3FaRGQrU1I4NDFGRVJiNThVUkI4REdMUEhQajUwMXgwOHcrSXpMbWd0?=
 =?utf-8?B?ekdOcWM1bkFvR0FNa3RsVTZKbWMyRnpiZnczeFhFeGVkUTBWNzRqWmNNUzZu?=
 =?utf-8?B?RmZ0b3FFU3JkVWZSVXY2aWVCaFpyU05zT1NVT2U4b2hoYmpWcjVNd3NUQmo2?=
 =?utf-8?B?bjlyam85UGZ2L3h4TEEyaUM3amhHQVRpeE54Y0cxZldYcmNOdis0K0JLeEht?=
 =?utf-8?B?SWlRaTk1MTFxVlEwOXZEWk1DYVN6bWtYK0pTbEk4MUp5NU9JQjNRbU13ZVJu?=
 =?utf-8?Q?Gb12mhEhZiilw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUlxWUhmY0ZCOU02aVh4cjJBTnVXMmhwRU5lZHVKRy9jQ1JkNUZDV3NzTlNt?=
 =?utf-8?B?NG1JQVpBY3Nrd0VXQWUvYkZ5bkp4RzJzekxuS2FXengvL1o1YmlzYW5uYjFQ?=
 =?utf-8?B?L3A3RW9wU3g3dEdYQTNWeDlGQndhUnVHT2s4cjM2b2lQV3ZVK0oxeGhiSXZq?=
 =?utf-8?B?UElmdnlVRnBxUElSdU0ydTlZUXdsMjhta2UySW5ETkpqZG1yL3FSbFFwMjNs?=
 =?utf-8?B?WlM4OSt3ck5LQUlPRkx0Rm5Ga3J6WmsrOExwczFhd1VTNDh6VDRhVmdzMTJ6?=
 =?utf-8?B?VWtiTmgzaDI0c2ZyV001S3EyOTk4OVJuOXhKWDBHaHRuSCtxVTV0SS9TVGY0?=
 =?utf-8?B?ZFpUSi8xRk9nQ3pRVEhYczhoZ2c4WWFjVno5eDllNGp3Wnlsb3p1MXcvUkgr?=
 =?utf-8?B?N0l1dDBKWU0zYy8vMGl4eUxkelRrRk9uSVJRUmNsQjRXNG9GYUZsRzc0cWcw?=
 =?utf-8?B?ZHBsNlJ2S3I1aWZKWWdENFJobnovNStGei8zT29BZU0zM09wU0h5YWxXWTBQ?=
 =?utf-8?B?QmV1QTlsNGhxOTM5UFViZXRyZXcwVXlINktBOUkxOXRZeWFPY2F5R3U5ZVhz?=
 =?utf-8?B?M2plYkVDbmtWbE0rbUNQbjQ0WGZrN0FmUlhFUVNJZ0d2ajVrenovajJrd2J5?=
 =?utf-8?B?STdRVGs2Vm5DRUROajhJVnlWNGxWamMvRmlBRldha09jK25haW5wbnFUNnZF?=
 =?utf-8?B?UGNiOCtOUHRlck9BakU0RmhLWHBGZFozaXY2Uk56bUhTejV4OVA5d29pWmEv?=
 =?utf-8?B?eXNoRFNSQTZVMFI0SXV4TW1YdUs5T2VONjRTS3dpUjFlc1BJK2FqbzEzdFJQ?=
 =?utf-8?B?cDdDR0RSaXFhMWVveFNqakV1N1krUWd2YXoxc1NjSEVNWTJnTDRhZDBNNmYv?=
 =?utf-8?B?R3ZUUFdGa1M5bmZkcnp6TGlwbWg3MVpYT3NZbEdzS3F1QkpJRm1HYy90NXVw?=
 =?utf-8?B?ckY3bmdSV3ZPRC94SHI0N2UvSlcrci9jNmdFUDhEOGZmMFlBZDZIRFFQRjRV?=
 =?utf-8?B?MzREc3FTNUFOOVZuZWJ6YmdHOFJiVy9aRzcwWTBEclJKMTFGYnErS1ZPem5E?=
 =?utf-8?B?REI1TjhmNWF0djVVM25XSTBoQzNqQ2dRdElCbzlSZGNPVHZkdEZ3aklBSmYx?=
 =?utf-8?B?Mi9yOHlsTWNCVkRhaWcxeGxmd0NXQ1p1eGNmckZzcjhRdmxoZE5WdlhTRmZp?=
 =?utf-8?B?WjlocnY4Y1Q1OUVock9UOVM0VnJ1ckcvRjIvTWNJR0hLcnRSL0taNW5mcEJG?=
 =?utf-8?B?emh2MmtiRXpjdTl6Y2ZOTTVEaXR0RjhpRTg5OUhDMXpiK3c5cW8xMzRuaTl2?=
 =?utf-8?B?cWRxUDVFVG1NME9aMHNOYUNVWUoxUkYxMUZhNmhXbWY0QW9EbjgxRDRmbkxp?=
 =?utf-8?B?emtHdHhuNG15dFJUUGl2cENNc01MOFFhelVNQTZqS3EyK1dDdUYzdkpZWXBj?=
 =?utf-8?B?aktOZWNQZGMzL3FwcUdneVNHUlFoZ0xIWGxzTEM4YXlMV0RidTZIeEN6clZu?=
 =?utf-8?B?OVZHYUQxdE1yR3prS2Y5MWs4Y2FhVFZQUGp2ejBXc21Gc1lFVkkwWDJLODdr?=
 =?utf-8?B?OTJIYW9RdzY0M2h1cG52bjhoUFZsaWRVUWo5ZnVSN3F5eUxKUzNGdDRmT0lr?=
 =?utf-8?B?NE5PcWh5NG9hNnY0SnBONXQ3YkdKck8yRCtCMFkrV3lYTlBhTEExTmVXR3cz?=
 =?utf-8?B?UkY5WktVc1YzTUNXUnJ5cGErTnVpcWlGRjQvN2RGMEhqOEM1SE44dFpIc1Vu?=
 =?utf-8?B?bVNpWDVXK2liRUM1UzJxaThhNHM0SU5FVElqRTRIWmpmU04vaWkyWEt1WGhN?=
 =?utf-8?B?Y29CWWI5V2Q3Zk93ODZ2MTR6SW4yaWhMZEY4Z0VZWEZyY05VRlJLandRNkRW?=
 =?utf-8?B?SDlMTlVZM2lNSTdoR01iTEI1MmN5a0gyQWlGaUlYcUwyUHVYWkIxeFJBTjBy?=
 =?utf-8?B?SXVpYkQxOC9neFVXR3RXMEpZQjJrWjBZa0lvV2ZQZGpJZ0YzSjE1dGFaRFI1?=
 =?utf-8?B?MmNZVXZ1cWdQNm9UenNMcVhNVlR4QkIxTTlRQTRwMlJ2eTc1TEh5QzFTWUFS?=
 =?utf-8?B?Q3J1N05zc0QzcHlId0tNcmJTR3VnVmpxM2xmT3Q3RGpMU0FBeDZkRGtlV054?=
 =?utf-8?B?UDI1RzFGY1ZWNkh1Q3d4TWwreHg4YlBHSSt6Y0hIQXdXZDZicmJFNlhqRWNh?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Mr0X2Km5F9AWAoE3oCIQw990eENd6MBYIvncSKo0fYvcjwc8M0XbY/J5A78AzZcK0IrdrJsMciofzc04ppg9cU/hmg1FL3muPi4ViTvoh829AsNPzu3bn0okg//3DIMGspZnOyzYyHj0KG09Cxfbm0bSsYUkq1YSa995iB1Ya5SqWCDUsXUSyCAsTooDE4FyA44oHx27Q5/X5F9mXJfUtvvSsRBDRXzNJ0TnWCFPyVT929xfwYQUVoGbN9urvb58YHrwXIfvnEimb7XD88sszJz7037yy9lhY7VndtazpTQe+D8+4Tvhz36VXLU9SgKiNhApmfdUjwGe3xdh0uRh7pddKecTTYMqRKPC7FK6xgPG8UCQf6WeRiwEnfla4axzpaaozt1G/91/gf5HzVWlROlOqlmhc2BZXxdoD+pEiB9uF6GfNtCbSeLwsMR99PS0q9ziObW8cLeQWF1EnHFZqgQr5FuN7KP6ExjDADCFa6CfLKQtojTEmtIrG4fGRSpUYZLA5cIKgaCaZuY44omce7qU8v+x02tK4hWydAez1eO2jmp4JPreEB/eId8FUsCoRcDGbx7cTcSkBvuzeQsNj5tABEIoIgADCZQ5qTqHLX0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 608b7c58-aee6-425d-6ff3-08dd4534b45c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 15:58:02.5465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSw/o+fGEDaJ8Mhz+riokhz0kE+BCW8fZT92VVCTaKAGnxHcsOzVQmqrJLjXoK2r6usz+/bNQ+7v/gXJFsUtsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_07,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040124
X-Proofpoint-ORIG-GUID: lyphoKkXowsmLRiNSKzuPuJ-EegexKVz
X-Proofpoint-GUID: lyphoKkXowsmLRiNSKzuPuJ-EegexKVz

On 04/02/2025 10:10, Alexei Starovoitov wrote:
> On Tue, Feb 4, 2025 at 9:25 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On an aarch64 kernel with CONFIG_PAGE_SIZE_64KB=y (64k pages),
>> arena_htab tests cause a segmentation fault and soft lockup.
>>
>> $ sudo ./test_progs -t arena_htab
>> Caught signal #11!
>> Stack trace:
>> ./test_progs(crash_handler+0x1c)[0x7bd4d8]
>> linux-vdso.so.1(__kernel_rt_sigreturn+0x0)[0xffffb34a0968]
>> ./test_progs[0x420f74]
>> ./test_progs(htab_lookup_elem+0x3c)[0x421090]
>> ./test_progs[0x421320]
>> ./test_progs[0x421bb8]
>> ./test_progs(test_arena_htab+0x40)[0x421c14]
>> ./test_progs[0x7bda84]
>> ./test_progs(main+0x65c)[0x7bf670]
>> /usr/lib64/libc.so.6(+0x2caa0)[0xffffb31ecaa0]
>> /usr/lib64/libc.so.6(__libc_start_main+0x98)[0xffffb31ecb78]
>> ./test_progs(_start+0x30)[0x41b4f0]
>>
>> Message from syslogd@bpfol9aarch64 at Feb  4 08:50:09 ...
>>  kernel:watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [kworker/u8:4:7589]
>>
>> The same failure is not observed with 4k pages on aarch64.
>>
>> Investigating further, it turns out arena_map_free() was calling
>> apply_to_existing_page_range() with the address returned by
>> bpf_arena_get_kern_vm_start().  If this address is not page-aligned -
>> as is the case for a 64k page kernel - we wind up calling apply_to_pte_range()
>> with that unaligned address.  The problem is apply_to_pte_range() implicitly
>> assumes that the addr passed in is page-aligned, specifically in this loop:
>>
>>                 do {
>>                         if (create || !pte_none(ptep_get(pte))) {
>>                                 err = fn(pte++, addr, data);
>>                                 if (err)
>>                                         break;
>>                         }
>>                 } while (addr += PAGE_SIZE, addr != end);
>>
>> If addr is _not_ page-aligned, it will never equal end exactly.
>>
>> One solution is to round up the address returned by bpf_arena_get_kern_vm_start()
>> to a page-aligned value.  With that change in place the test passes:
>>
>> $ sudo ./test_progs -t arena_htab
>> Summary: 1/1 PASSED, 1 SKIPPED, 0 FAILED
>>
>> Reported-by: Colm Harrington <colm.harrington@oracle.com>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  kernel/bpf/arena.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> index 870aeb51d70a..07395c55833e 100644
>> --- a/kernel/bpf/arena.c
>> +++ b/kernel/bpf/arena.c
>> @@ -54,7 +54,7 @@ struct bpf_arena {
>>
>>  u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
>>  {
>> -       return arena ? (u64) (long) arena->kern_vm->addr + GUARD_SZ / 2 : 0;
>> +       return arena ? (u64) round_up((long) arena->kern_vm->addr + GUARD_SZ / 2, PAGE_SIZE) : 0;
> 
> Thanks for the report. The fix is incorrect though.
> GUARD_SZ/2 is 32k,
> so with roundup the upper guard is gone.
> We probably need to:
> -#define GUARD_SZ (1ull << sizeof_field(struct bpf_insn, off) * 8)
> +#define GUARD_SZ round_up(1ull << sizeof_field(struct bpf_insn, off)
> * 8, PAGE_SIZE << 1)
>

I tested this and it also resolves the test failure/softlockup. I'll
wait for a bit but can follow up with v2 incorporating your fix if there
are no further suggestions for refinements. Thanks!

Alan

> Better ideas?
> 
> pw-bot: cr
> 


