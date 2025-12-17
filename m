Return-Path: <bpf+bounces-76914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BB4CC9854
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 21:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 457CD300F320
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 20:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359F0279327;
	Wed, 17 Dec 2025 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r9ScZAIn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E/Uacp0/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274DB16A956
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 20:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766004681; cv=fail; b=SBJi/jH9lDEsOlKcebqPxvs5UfWkT3E69wuSRBunBJQJ8g5JZVZJMmIehgG9cOljGoTDrWpdu9+4klUk9w9NKRVvX8e1/hZB9xPJDNynYwNCEN2vr56Saw5fawmtA8ySlD+gdmZQl3iwK2+PsDy2L4T4Dn9YSBkdaTPgJU8BVp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766004681; c=relaxed/simple;
	bh=JAc/p0nEmEl86UTSbGss2V1vmHGltnk5+2XA8PhGvNY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WbZjr+dnKo+4M3VQV1z5SvczKodwVMy+q3flqsD465q0LJAUbUFMMN4NF1PjZ460x14trR8TSE0WjGyxJXjL0QqX8oibotQ4cOiq94OMn9bDfcTvKwLwKXFnHslaqVHILTPSiVVYH1MxMBPKgYZj5ajYRo1C7rOeW1WLlFJZaKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r9ScZAIn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E/Uacp0/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHJQaiU3377663;
	Wed, 17 Dec 2025 20:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yajmK6N37h1JuD+whiAPSpB1eR86RVf+a55czHSLJIQ=; b=
	r9ScZAInvXAq5IAjdvVvuK1sIiK5cwm4dPIYAb9Eqm0BOm2zWFMvwmdSQ0n5b56L
	NbeY878jeHomczojZq6431JfQMQEYjsw9ylos3/aBBYdxRipttoqTDowlxawHkX6
	lxtC49v/KIVO0EkEubXlkomndliWLgGYq55OXZLkFKwNQ9Lq2blLi1YtDT4r8tQM
	zeRPOPvjYz1n0dio8RDGD7kJfY2Veh+ZjlkDyNc/4jwJ9UVhwiYuWT5CTvGiJHfN
	qfb6PGw5TEYm1vi7apFMp1EAeWk5gkaFcvFLCJoXZzCxO11NXny1QzjbZcM+Jp39
	uFYPUpx178Rw40SIzT4NQQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b3xc8rnhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 20:50:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHKHxpo022457;
	Wed, 17 Dec 2025 20:50:51 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkn2n3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 20:50:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYBZKu2nekuPFzyaZqHqlH6IQ8wgLCOuFTFSgVyty+66xDzNrPWSWVEsD1th2bCAKVDD3B1WeJotkWf6ZGa+PeUXDpnie9xJN4R5Z6RLmHucNg8QHwuS0fDf7vMNcxd1h+FYdKgLnTTKCrwbGsIcdxS8vpST1hFa0//r1l5pysNTxPlTVaL+7myaUzCbQ89Go622WkY7Dadd8fLRnIRGpN5rIyvoEiiApupzjQlhB5pkl5VkgSAjHlCv2tzpyAWkVpflTBpPQ8dXU7cayjZo0T7Gv6Hc+wOwVw6Zgh1b3zwImCAPhUAtk95Z36vZV5KP7Q841UJTTU2I4/oD9R7tGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yajmK6N37h1JuD+whiAPSpB1eR86RVf+a55czHSLJIQ=;
 b=XrMJHVU2OGZw4qOVgZsgfhS1oy7CXLnCqDziUB9fGu6V5inDNhfjO7vzmlq/J7OZQN3FDw2+PWBIuvrfUjilUtAexDaKSLs4TIMNyRwUwm65Hk6slviIOhP4WaRT5ZDV03XVru0VWhRCwjPVg5GJXk4mbRTMIuqYccNX0tEnthLu8APuVvFyXBS09fIIoJ/CuR/PqyxjymK6xP0UHmrp5lSSk+0lF29M5X2iIgprgCST9hdkToClw2TNMscjd6fU6/y7JLvA0jnqca9HWQfXd1xhSGQbi762oQrmcjMr+QW8B0VrdD/XM9FiIGvpHvkN0ep2R8iK0VQq/JKFDVJfSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yajmK6N37h1JuD+whiAPSpB1eR86RVf+a55czHSLJIQ=;
 b=E/Uacp0/Yi0w9odPXSV0/7UnFbISwEtXDJ4QHm2uhygTVTElJVHcbq7k0ugEO1uMowbXI11fDZ2XRB7yfhyQj7xWI8vnRA5r/iA3IzkMz4KVJQhTIrXsDBY1lc1QpLMWmCNSfs1PINczrqG3oh0BKegkm2VF5N0xeHPUueHwrrE=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 PH3PPF1189AF8C5.namprd10.prod.outlook.com (2603:10b6:518:1::78a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 20:50:47 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 20:50:47 +0000
Message-ID: <b65fd7dc-fbad-4a96-8eb8-f36f8f518d44@oracle.com>
Date: Wed, 17 Dec 2025 20:50:41 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] libbpf: add option to force-anonymize nested
 structs for BTF dump
To: Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Quentin Monnet <qmo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <20251216171854.2291424-1-alan.maguire@oracle.com>
 <20251216171854.2291424-2-alan.maguire@oracle.com>
 <d5a578c01f8a2d4d95ca16e0a9ee5b9bfce1c30e.camel@gmail.com>
 <9a096b2a16d552031a12f3f4f5a2c725212df5e6.camel@gmail.com>
 <b535b47a-519e-4138-861b-c16ed7fa0bcd@oracle.com>
 <CAADnVQ+EyYO+aOZewNQwETr5rphOCp6jJQH_fw9GqjVFdQd19A@mail.gmail.com>
 <CAEf4BzbWZtRdKCGwhjRV9MOufTC-coWFSU5sRtk4gdm9S_bg+w@mail.gmail.com>
 <6ae6dfd8-3f73-4318-93c1-97541d267a28@oracle.com>
 <CAADnVQ+wNPbbA0e4+6kx+LtOH=09jJyiYcEKZfc8kt6UPnq=EQ@mail.gmail.com>
 <535846f7-4cc7-4b12-aab4-52e530d04706@oracle.com>
 <ae6c6e50b3176d4ee4cce4cda09807a05d103fbf.camel@gmail.com>
 <3071012cc1e8d6bdf16b13d371a12cb201c502a7.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <3071012cc1e8d6bdf16b13d371a12cb201c502a7.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0496.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::21) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|PH3PPF1189AF8C5:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a41220-0be6-455a-e2ca-08de3dadf463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmY2Wms3bzJxZnFPU2t3WGMrTGRaSklnSVRGazEzakFQTUI4dlBuRTllb0VO?=
 =?utf-8?B?WVFNd01NZFBRWDFnNEU3VzRPSmIvUEFaR3QwUS9jOGJMb05QemdRWUhFazRY?=
 =?utf-8?B?dlJYSDFScTh1MTlMM3dWZ0Z3YjMxa0Z2eTlEaFkwaXgyMCsyZzNNYWYrbXRH?=
 =?utf-8?B?SHdTVWVzMDdhNXpTK3RkVldpVjd5VEtuQVljdFhWcWl4djVwY0ZWbGxCNTdV?=
 =?utf-8?B?bERSYUNvWW1XSlRCNHpRRms2UlFOaXppaTRCMzIrd3k4VnlRYzV5QTBWLzFI?=
 =?utf-8?B?TVFONDhpR05vdEhqUDNJR2ZvSitwRUl4bU9HU3h4WVNMWUNMQVRBZjY5T1FF?=
 =?utf-8?B?ekdHeWV6U1FxeWkzVjZESEM3TXFQNGJ3TEFTdlFVUDVtOGZqblExSFBQMjRk?=
 =?utf-8?B?UmcyVnZVV1JsUmVCTmVINUxwSDJYRWh1VktsbVI0SjRkSkc0UVRYZUtwcUlP?=
 =?utf-8?B?Z09FeXREY2RNSEUwMldUZkNpTTlJREVQUm9ibmhlWW8wWDRIU3BaeTJDYlc0?=
 =?utf-8?B?VksrUGNSOWZ2VHpJallrQ1BkRjRtc2t2R3Y0NWpNc0R1dzc2MjRueXpLWlZ2?=
 =?utf-8?B?UEJxVWc4bVB6cXB5UlgxN2tnNDZHNnYwMFZlNlZ1d2Fwd1FrUnNxVHJ1YVVo?=
 =?utf-8?B?R09zU0ZFaDZkM1BxOCt2dXB4emtqVlJYWi9oTzNKQThoVFYyT0dsczNRekUw?=
 =?utf-8?B?RGNNU2lXT2swZTJQNlhpWWRXb1FHZExSSm90SGYrU2RWTE5aQmUwR3NxWnVa?=
 =?utf-8?B?bGhRa2pEa3VLZWc2bWswejAxQVdNM1JWMktKbkhmWWFUSEtJTGJzMWFOdkJi?=
 =?utf-8?B?dERTdUFsdUJHdjVEQW1VT2NKVlNzVTZ1RXVsL3ZsdkVGUktDbG9URVlrdXNp?=
 =?utf-8?B?bEtpRWo2dDhNdlpDdlYxaDkzdmNLOVE2dFowYy91VHR4SVZjbWhPOFRacDB6?=
 =?utf-8?B?eE1CTDJOREwrMUJ3RnpDSTFNV1RIYnlZZVZVY2JSUFkxRGVtYXA1ZkZiZU9i?=
 =?utf-8?B?ZEllOWJIRnZ4K2RDdVNNN1JwWHRGMCt5T0RLdTJRNERWdHliNmZOK01DMjFz?=
 =?utf-8?B?MWJTZkFtTG9teXJEV3dNTUVDajlweHYxS1pKVzR1bGx3cHpCWWJLS0xnVTRl?=
 =?utf-8?B?emtzWGdjd0RIL1pRRVdxMWg0U1h3TGRNdTFSQ2NlWE5UTk9NREdTL1ZpenQz?=
 =?utf-8?B?UGQ1cDhkbC8rSWk3ZWt5WENtRTBjTWxaRWE2d0hqVzNzLzFEeUwyV3loQ3Zz?=
 =?utf-8?B?d0JoT1RxRm5yZXBFQWFxVHpRQyt3UmlrdEYzbTNQNjZXZzRSbVA1cXRmRkFy?=
 =?utf-8?B?QjlxV3FCUlBqRGQ0eW0za0xkNml6T3VCK1lzZ0kwc3RHTE1TaG9mOW1tN1cv?=
 =?utf-8?B?eHFWbHM2aUtGcTFYZVFPenREYWhablVKTGszbFV3MEt2cUhERWw2M1k0VHp6?=
 =?utf-8?B?R202R0gxbHFLRFV4d3F5QitqeFIwLzFLNUFXeTY0Vy9tU2l5aHZpWWZ4WkdP?=
 =?utf-8?B?cVQ2WFVUbVcrT0luSXF3aU50dmlzWnRGMFY2OU1lTisrQ01NRnB1bXdxVitn?=
 =?utf-8?B?UVdMOFMrN1FPRVVoZ1g2a2VBWUpiSVNaN012YlhwMHBPcU9LVEFkRXNueC8y?=
 =?utf-8?B?enhFdEFRTkMxRVdsWVh4OStjWWRvcCs2Skpxcy9INXRNK1NBV2p4VjRXME9r?=
 =?utf-8?B?VmxOWG5laEdqSGpSZWlaOFlDTmVqdTBhM1lsb1Z3bDZGZDlnd3JlOUVGRGQx?=
 =?utf-8?B?cHZwSEFiSXZoTGpBa3NXSzZydC8yTEtBNHZTUlZ1UXdXcVpGYUU2VlBIMU9R?=
 =?utf-8?B?OVF6cnNrS2h2bExFWUxsYmV4NitHRlZETVFNOFdwLzUybVZ0S0JhZEt4WnNx?=
 =?utf-8?B?VHpTSGNJY0hMNFRrTnJSVlpWVlFlcGpWNDBxNFpGOFB4K1Zhd0QxTlcwU1Yv?=
 =?utf-8?Q?AA9MTZTuBXMcFYrSCqv4+wDBfQM1NKbL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFlQLzhBclprRUJmNXNJeS9sSVU0bUlvM0FEL2dwRSswWU1DU0ZBSkRiazF5?=
 =?utf-8?B?MUIyY1Q2QUdvWHJLelFScjREbS9MbkxMSEE0WStETnlVVDh1eWJVM2hxUFk3?=
 =?utf-8?B?a2Q0Z0RpL29DRVc5TS9zb3BOM2gvblUrYkZJZXA1bkIzN2M4SWV4TUJacVp4?=
 =?utf-8?B?QUNFS0RPUGI5cjBZMjRiQnRPdkZDeW9kdmV0YkdiUFF1bnV4Wm5aRFFJTUU1?=
 =?utf-8?B?QXkwd3RHWWZxNWovZnRuVytEQ0ZubkJRdnBDT0p2cGFFL3NWZkVUMXJXOEln?=
 =?utf-8?B?WjI3YUFwYUdDNEZDVG5NZEJmdnRDUU5CL3RuNFd1NzZMbWRydFJZdEovYldR?=
 =?utf-8?B?bkUzTjRxK3NVblJmTEkxRXJETjh6WmRaZVRKaUEvWjhEajI3b0tDQVBRdnhy?=
 =?utf-8?B?ck0yYXg3SExDV3hRR2poK3lES0d6cStHajkrdWJOWmFyWHdXZE11clRxYWhi?=
 =?utf-8?B?ZmdCU1VkdEJ1MTZJNEpLYzFKNEZValZpTWFGd2FMOGdKNVFYMTlSLzNaVERi?=
 =?utf-8?B?OWxoQThCR1RCZlB1Q0RSZi9YUE5UajJ0eVFsLzJGMm1ibis3REVWdnFZWXVH?=
 =?utf-8?B?cVZJaEZsU25IOStaTmg3TmR0elgrN1paR09mMXBjV2ZzWlVpZXYxMm1YQVRr?=
 =?utf-8?B?eStlUUtSbGw4YXB3SjdFOWkxb0pWZ2ppcWVYdmkreG9RL3gvcld6VTFaRSs2?=
 =?utf-8?B?Mjg3alhaakFCKzJnQjhzWmI3ZWwzMzNDVFJNYmNycXZKUnpnbmFpVUkyb3Bj?=
 =?utf-8?B?Rm1OSDlKdU9aZEdBQ1VWbjV3dFFxL3g3czBWYVJWUmN2ZGRuaWc0dnFJSzdI?=
 =?utf-8?B?ajhHMVk3RUlrWjRZMlZmMHF5aURXVjRCU3JmdXdIRHJkNUFVQk41R1d6UDMy?=
 =?utf-8?B?bEtwWWdHSmR2ZmU1ZEV5dFJkeXEvWWFvNHJXRlpES05UeGROVVh3RFNROGRu?=
 =?utf-8?B?ZWFXZ2RYUFZENVpIcnNqcnlObTJUQ3hUN1VsTmo5UVpEYXJPVkVHaE1WdjFm?=
 =?utf-8?B?QzdDcEhiVS83dlQzemFtd1A5YzdEMis3T0lTZzFSWXBaMUNrTWJxVlNvTFM3?=
 =?utf-8?B?VWNFWUtMNW1mRHJ1OVlFNWRwTHRkd3dBVmtHdXpId3VFelBuM3FmeXgvbmMz?=
 =?utf-8?B?TVY1U3ZzeWcweFNxc2p2Z3FXV1NOWWxuU2I2dHVFNGpwR2ord1MyK00rVUJD?=
 =?utf-8?B?WmNLRmhyOUpNbDZSTHBid21yYU8yNVJtYmVvUDJFSWFUdkJCbmFXb1dwa1RF?=
 =?utf-8?B?T1Z6V3NOeVE3b2RiM2dpT3ljWmtFTmVzYlhBeWtZOFd2dVFpUk9LUkIvaFM5?=
 =?utf-8?B?RllEekEvdWp1eE14clVSd1ZQZGVVbll6Z0RIR1VSOEpJRlpRa3cxSEFNaGZK?=
 =?utf-8?B?Q2NzYUFZZWdITFFLTGtoUlZacHVYU2hBd3AvNVJ2NW5wOHcrVEhLVXlkQUxj?=
 =?utf-8?B?VUU5WTVKbGhTODhXTVdEcHlVTXN5bG1lb1Q1Q2xPQ2l2cVQwSlpsM2t1Y2ZJ?=
 =?utf-8?B?RjRTd2doVlNDT0ttVzRYLzMrZnF4TTVNV1MzNTg3OFEyODcydHlKZnNTd3R0?=
 =?utf-8?B?eEtCYm4rait5cWZ4eUdZbFpkbjFxTEQ2UFoyc2ZBZjBYVjBsbzhDaUdra1ha?=
 =?utf-8?B?QTM2dFE0VjFJL2E3YWpUdWRIRVdXL2pzWEFSSFJ1c0RDWEw3UUI5VGVJQjVX?=
 =?utf-8?B?R2toaHVaYThkTUxtMlF3Vk45TUJZTmZDWU5PUVZodmpzTzlTNTM4b1g5WEtt?=
 =?utf-8?B?cU1sK3ByR2tnc0FrUDZDOFNIb3FQNlZwZEZYNFVWaHo4N2crcWRIT0Jmc1kw?=
 =?utf-8?B?djhXU1V2ZUJqNkVVZEdMQjZpUFQ5UEhBR2xhL0F5VGpwNnJOWjNXYStzNFN2?=
 =?utf-8?B?eDFoem4wbTlLaG95NTlDcXRuaTkvNVpEa3dKZ2J1N21oUTVkQkpGR2F1Yncy?=
 =?utf-8?B?cTBQb2pMODdDR0xrWDJOaTlKNHJOd1hVTmlYSmNTZGFWSGZjUk0wQmtjc21F?=
 =?utf-8?B?OFNVdHZuRFlQK1lCV2RxUlpmQmp3eFUyVnNkcEdiZEtrbkIwQlE5UDZNbzVl?=
 =?utf-8?B?V2RVMklFQVV0NDVRMnl6Mk5KRXR3dzVVODF6S2FIUlBIeHF0eExkNTFpcFll?=
 =?utf-8?B?L05qVGp2NnB1d1RpNEpkcjNTUmUwb2YrazRaSmJsVlUwWUszaVhmVlRxV0xm?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s9+DeyxDbseTwL/07mMyszncKoGhMDa/uxlViRrW62dp13Ikft8j44R4ABQydrE9FiXRkAhmut4l/mfGZOfxwHGY9PsGyeHsJzlScggt/+2IRJevABRJdWonaENHFF49wGyjG/CgZetsAfje8cyH56FA0Jc6gATicHm4w/z1401rTzibuL9HWJkDMkflTxFWShG1z87/8fewBOWvkR4eQtvRUxRMpSVvMzhlEGjQnMIsZZ3FtqoaFvKkpBtXwkkAkVBahTqJSr/4pG418oAVKTxCci6rOnBUJMmIe1cSWFpoMicV9wQZ3w0O1E6xF+DZr2EuSBDfQuMpDPvGODsfQE74+AA21AKlEq+D7Kx5Ch4fhZrodrhDUU274QvwVT9U8XwVOip4DYU3fBZ2Z2ykmTrtI0LWPLDlFWqQ33fyUZM+KY7pQMT9EWZjan9fQl7ZlCn8xLwSNslVxXegnArhz3FINNt9mUms+YcjTQWdCz7zb1v4uFViRvsd3645v6twEz7J5DR92o7LtgSm1+SqcPiHkQ9u1BA+qhOX+teXTvYuIujQBk6JMUiRlesu49FZyvB+S/Q3r94bUL/FeOOPxxz1cQfIzeImme5NpGq8RUw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a41220-0be6-455a-e2ca-08de3dadf463
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 20:50:47.4098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4l4E0TawxiETW7ldw3xzCE+/rJwwWkZEcIMAgypzEnVLgQUtJNJOyLtQayOvuXQ/vHAiiko99cGOp+UwKB9rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1189AF8C5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=937 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512170165
X-Authority-Analysis: v=2.4 cv=bq5BxUai c=1 sm=1 tr=0 ts=694317ac b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kML5vXh8SpfcSk0zMX8A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13654
X-Proofpoint-GUID: Mfi7Y5IfwibVPx3Ii-RFSTw544FT-Hre
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDE2NiBTYWx0ZWRfX233VTQ5481k8
 cIWCGv4V52ebLSYKgP+8e/AVw4VvfbbN9i5NGOR4HE0ta+F6nAoF+5WsuAz+BRhkGgQYjeY9n+C
 1mZh+LD00mRvcm5mBtEV7jqtUkCAmH78NOaJj9StYTr7mrLYrrT+q14KEQyhyVCLQg5PrPAsL7F
 cTnQGcNYhGS8oISMywj+ARc5nYAAD2gJ4sBLaAEkQe2elatVxcd8CFyr6a7ZrtT3EHGL5Z6pMKr
 SmvWxZq24Kb5i9g395WwZdKRh4zpA9whu3xNXneozq7UVQScpu6GCS5663ySN0yl98MfTvZ4qFV
 vKzxRB/NpsHHILKTYnlnZwCZExiqGz/sLW/6WTHUy7yGWNbJDJFQGxXGMXhNgsVUDqgDd58NUtA
 29ea1gwAtCdXIyiY1vtn6tnLRYfncXwxwBRmzODREPYPC7JOkCo=
X-Proofpoint-ORIG-GUID: Mfi7Y5IfwibVPx3Ii-RFSTw544FT-Hre

On 17/12/2025 19:35, Eduard Zingerman wrote:
> On Wed, 2025-12-17 at 11:34 -0800, Eduard Zingerman wrote:
>> On Wed, 2025-12-17 at 18:41 +0000, Alan Maguire wrote:
>>
>> [...]
>>
>>> So maybe the best we can do here is something like the following at the top
>>> of vmlinux.h:
>>>
>>> #ifndef BPF_USE_MS_EXTENSIONS
>>> #if __has_builtin(__builtin_FUNCSIG) || defined(_MSC_EXTENSIONS)
>>> #define BPF_USE_MS_EXTENSIONS
>>> #endif
>>> #endif
>>>
>>> ...and then guard using #ifdef BPF_USE_MS_EXTENSIONS
>>>
>>> That will work on clang and perhaps at some point work on gcc, but also
>>> gives the user the option to supply a macro to force use in cases where
>>> there is no detection available.
>>
>> Are we sure we need such flexibility?
>> Maybe just stick with current implementation and unroll the structures
>> unconditionally?
> 
> I mean, the point of the extension is to make the code smaller.
> But here we are expanding it instead, so why bother?

Yeah, I'm happy either way; if we have agreement that we just use the nested anon
struct without macro complications I'll send an updated patch. 

Alan

