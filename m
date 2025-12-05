Return-Path: <bpf+bounces-76192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9B4CA99C6
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 00:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B5ED305116D
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 23:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E5D2BE639;
	Fri,  5 Dec 2025 23:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Kkq9epJM"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3A199931;
	Fri,  5 Dec 2025 23:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764976738; cv=fail; b=EPwNBzrZzTIPa7tqmmXkkJ/m2IwZ/L//tWCzJW1SPJDk7KmnV0Givp37NEWDrQkr6dgc6Es2361Mukl1FSVJW62WN9DZKtfHzgi4paH7woDiIJz14KoOEXauzSruchzAGvW3jQgbTOSSGBizibJx2W2e21SaxHQU58cCQgbE3Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764976738; c=relaxed/simple;
	bh=6mSj5IiM4goJYjfYGF764y6Wx/ag+kAK1vSRnVDsBJk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qT8gS+3eFJslFaUoa+1zt7S5g3erDiTuTmaKflKDQmKhrZAbTY6p9YTQMhP3vb1J4E/bg7BvDEyOy9X4bIvGGLBuKlo+99ZoZYFke7eklG4SvCmHM5j7jsm4IqcymcowTOKYHl5b6cOyxZhGdLEYyKYAZmb0HPz5tQWLzdtZlgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Kkq9epJM; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5M9Z2t3495734;
	Fri, 5 Dec 2025 15:18:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=gnHy6TEwJzwazQCGSQHIx7D2B09g+uAg5t2ikQnLotY=; b=Kkq9epJMPKO7
	sh7XEpb0vOXScKv+sKt7WOsXMwqVlcLJPz8oUu8M4TGRfY1LsSbEAYKMbOg20eFo
	/YVoZcNQqJ4z1OIpT9ASWayeT/bNWk3oAwNvhiMKY94uzMgjDAHTfuyRUvUSIl8X
	/h7FVcQ1CSI5iruniKf8FfcBRMW4l/lWslmRMYf2++T6UU0BfVFsknKSHgyAaio0
	lKQVrIHOO1ebM/g77ZMRQ7R513qlUFNrvVzvR2U+tVQNlQbtE4ZjBVeI1G08RQCK
	sfCbxH2z3ywAhJS91Nrv13k8xYlUpz5Ih4/7zHteFmZULaT0s47ClVQ00DaUG1jA
	tZA1+FVVAA==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4av7xpgcub-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 05 Dec 2025 15:18:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LESv2C2EnTv043e1LCMrNDxHUS4pZqJtGNK6WsPMa08cM1Mfefqq73+x83x+4j1GtCW6o3I2tEfvCu+FyuU92xqO4YwVRhnKCwC1g1V2/0llVCz9xepf/GnENmmM5NpwL/ANkDdxcqhcJr0y8vqGC6jjWLTss5rqrVUm1ebf3/Ki6bKxpGZ9c7UsjyoO0khEBWthSToh3f4ks5iEUDbcuKOTSvhGNLaHiqL5Z9cRM6VEw5kZlsSnwKhUuc0YAb3SYPvluKbdWBBEm0GSmIKhnJ7QxhF2J1N5b+hITLAkYqoeJDg0Ly63o+D2+t5D5/ZhW1/cR0RRPKjBlq6e2/Ia1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnHy6TEwJzwazQCGSQHIx7D2B09g+uAg5t2ikQnLotY=;
 b=JAgCxw0+Q4/5n9w3ZFKm6aYx1u0BN2VHz1mLJXAdfZfzmmWnZ8c+3zh8AQtRKBiIBwinrLOs4yHtdmk2g7tyiTcGKjAcVeFcgIFl0c3bi5uZG8gt/HsdHuHSbbM4jJcA04zcZVYOfbmaivpC5/AWYUCN+Y5gXD5g0rIHHJ+hr7kuAv0RTFZZkGHUHYNnIFsRKTyImwUQrTWcYnPh6x06eBE8eLX6qAhTb2GWr8hyuz2WUb6ySfbWwKCQnBMxoyJV3Cfo0ISOhd2DOYHeyutgOyfjhlLdaTH1siuv6U6GS0e/Jftitf4ksS2WOb/U7SBrdvZU8VvIrHDv5Ct51rVHRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by SJ2PR15MB6404.namprd15.prod.outlook.com (2603:10b6:a03:579::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 23:18:26 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 23:18:26 +0000
Message-ID: <bcbfcab2-1a2a-4301-8811-2ebe998d49d3@meta.com>
Date: Fri, 5 Dec 2025 18:18:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/6] resolve_btfids: Factor out load_btf()
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bot+bpf-ci@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        akpm@linux-foundation.org, nathan@kernel.org, nsc@kernel.org,
        tj@kernel.org, void@manifault.com, arighi@nvidia.com,
        changwoo@igalia.com, shuah@kernel.org, nick.desaulniers+lkml@gmail.com,
        morbo@google.com, justinstitt@google.com, alan.maguire@oracle.com,
        dolinux.peng@gmail.com
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, martin.lau@kernel.org
References: <20251205223046.4155870-3-ihor.solodrai@linux.dev>
 <e7478657b0308d8c4c16f5f412e92a3dbf565b0777424bd6d163d1d8288cf10a@mail.kernel.org>
 <fb8c16dc-07ee-48bb-a370-0a4931dbba08@linux.dev>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <fb8c16dc-07ee-48bb-a370-0a4931dbba08@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:610:cd::27) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|SJ2PR15MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6b4b9b-3ae9-4641-cb8d-08de345497ea
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WERtQlFFTHdrMU9aOGJSWjNqVGc4ekxES0tyR01pa3NZQjhHSlZIY3BEZEMy?=
 =?utf-8?B?RURmdjRMWUNiYnZYZk81R2IyV2w1TXdmUDdXR0dQdE0rNkhHbEJJZGxhK3dQ?=
 =?utf-8?B?SlJPeWY3Umdnam8vNnBKMXRQSlMwUVJiVm9NUWNtRkNoR1FTNGYxNTMrSWNE?=
 =?utf-8?B?MndRcTNlYkc5Nk0rUW5sMFJQWkc1dm9id0JuWUR5OURsKzNadW5sTFBsL0VX?=
 =?utf-8?B?YzBGMmZDTkV3WlVtWEpHcVptUDRvY21UamxsV0tlVUlSazZ1disrSHV4d3ZM?=
 =?utf-8?B?bzZGYzBJVFZyN2dKeHpZMUJNSjh1dVlsQTQ4OE1RRERqczF4UUtrY1ljbzFS?=
 =?utf-8?B?NDdQRWpvTUZsTzB3U3lVdU0wUXU4OFFpTVpuVWh5cnBwVWdFS0xHVThSZzNk?=
 =?utf-8?B?OE90NU5jaU9NK0JQbjhIN3Q3bnFYVU9PS1FVMkdzVGt3THJUTTR0cFBQc25l?=
 =?utf-8?B?RTc5ZExUVWk0YUNteFN0aGxVMnNDWjA0MDJnN1hqcmJ2ajAzSCt2ampnWVcy?=
 =?utf-8?B?UjFYUlpPc1RWY3RqY2l6RVk3ZTBFcmJORFpvNlUxN3UrVjk2QmlqVnB0Skh2?=
 =?utf-8?B?KzJsUkk4Q2xJR0lDM29kWFJkdmxsZlNRaWx0UFFZNUEzN0NPQkQ4N21MNHgw?=
 =?utf-8?B?cExvNmIrZzZCYm0yT0VacjVaRUJncjJjSnZxNmJKckxKVzl1Zy82L0JDTXBI?=
 =?utf-8?B?bG9FaUVNQzR6WnJOMjhOQmt0LzRNM1ZjdmpFL1VhWHlRV2xtZkhvdmtwbUhr?=
 =?utf-8?B?alExdWtDbExFZjhZRUltRHRTaEdzQklZaU15NXg0cVI0RlBvaXhZWll0N2dw?=
 =?utf-8?B?eTJHT1Rrclkra1dpcFNPa0wxc0YrcEdKQW1qeWtYZXZDdkZQbUVNbXdIYUJC?=
 =?utf-8?B?TW50UTh5WXVDclVIcXNPUVh0bjZacFNhL3JNd3YxMFp1MndPYTN6RWtKOU95?=
 =?utf-8?B?Um0zMDhHRTZ1ZTVBOWNOYUVGRXB4M2R6RENNc216UENWM1dXN0d3LzViOThh?=
 =?utf-8?B?NVV0SVd2V3VtYVhDMFpDUmJqQXVBbTlEeEs1dlF5RmZtdy9HRjczWEwweU9X?=
 =?utf-8?B?QW11U2gwWEpXM2ZmVklhQkpOdUFPS25MUTB2MHh0SUw4YUt4SnNaaEJUVjl2?=
 =?utf-8?B?ZS91OXpDZFg3aDhscnUzb0JtTjc2YUpDbkQ5U1JBOHI4ZlBVcTJ1NWpRSVlT?=
 =?utf-8?B?OVA1bFEzU3FWMldvTlF2SUh4aTRpRjRMOHN4UUhFOFRSUnhQRHdLMXhtUXJj?=
 =?utf-8?B?aTRNam5XQm5XMytUSHZ2MWNqNW9yQVFLMkxEbmJzT0lCdDFvRnNDSVdNWHZP?=
 =?utf-8?B?UkRXSm9tc3FNbkx2UmZienNvRGtLaGNXNmpUN3BwNVBmTnZ0VDVqaDVmQlh5?=
 =?utf-8?B?aFRYcHpJUGNoZWxGNWlWamVWWHFsaHBaOXJOUi9hYWRKeXV5OUpaK0pTN3FU?=
 =?utf-8?B?L1lFVWhmMXMyVDZHV0ZoNkoyZmg0Q0JkN3JtWkoveGM1VHlNWWxscUlHaFJz?=
 =?utf-8?B?dVl3NDFqWnRjZmRqMEpUODJzWnJxc2NZU0JTSDJTZ2dvY2xXN0FnMmVSNHdU?=
 =?utf-8?B?QWNVazJOTGc2Uk1hK1hrODVFdDY0QzNKMEMyaTVhKzh5TktYSHVPODFTU2JG?=
 =?utf-8?B?VkNZZXFlZ0o5U0kwa0owK2lZZkhRbjliRTBjYzdFQm16L1lMeEgxL1BQTnk4?=
 =?utf-8?B?MDRrS2RqMGJ2LzVxVWxtbkcvejY5MGJhKzRLRmtrRVh2WVM4M05SVVhhYmdC?=
 =?utf-8?B?QXhtNW5ydjl1WjRFeDhTM1lpWml3MlQ4Rm5TRzAvSlh1U2FHdFJNQUYrVWNz?=
 =?utf-8?B?K0g2bUpKRTJIaFV1RkJodkxVTmkxaUU1TEg5aThCdGNJT0RZRklNWXI0SURm?=
 =?utf-8?B?b2k2d3NnMkVpQlErZTc5Tk9ORGUrTW45M0VHeS9tbTFNUTdQSWxWelNsZWhP?=
 =?utf-8?Q?pdJmQWZA3q6Op4bkQjTmMgmY7A2jCo9w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnc1dmdRcVFtUGt6bWtMeG9tMjNTSGswQVVKcmR5VkFwUExFdko5clo3SDJk?=
 =?utf-8?B?Zk1VVUxBaFJMYy92eHI0VHZNYkFURFVod1Zlemx4M2lTYTMyVmhrTG5rUTZV?=
 =?utf-8?B?M2tHMUF5bGhzdGl0QlFTRW9RQWtaQ2JJMHNSYVQrQXB1RG5iRlJnbUNPUzdI?=
 =?utf-8?B?Yk81Z3AxN1NzMlAxeGNtVXZXRVR2S1FSaXVUSXVWZDdOSU82bDFzbHpvWUc0?=
 =?utf-8?B?dzVSNDVCZHhKZjJ3TEZ0RGRicjBJMWJBLzczTXhwZzBjRFAwWjJ5SUpBOUFI?=
 =?utf-8?B?b0g2MG05UWlEZ3o1SklvSHZXNm5GWUZtOVFrd2xEMHd2N0RlN2IzakR0QW8y?=
 =?utf-8?B?U2FKMHNBUnNUY1IwSmUxT1dCMTl2NXd4eGFuQUgvL240TU13bFNqa3lmMk5D?=
 =?utf-8?B?QldwTFVOT0I5MkRMUUE2aU1oWkIyZFJWUUZINzE0eGN0Y1M3Q0ZCTzJmeU9y?=
 =?utf-8?B?bVZrMnNNOWVHTEV5b3pkbEVXL3NhSTdaaUtMR3hCdHJyOTFvTTNuYytnQlRF?=
 =?utf-8?B?T1dwejBwVDZyM3dqcFZrNXFydzA4QVBqL0U4L1Vsd0FEenorSUliSlVDaHVZ?=
 =?utf-8?B?dENKREV2bmpmcWwwRkhpYmVNK3FJZHRzT0dLZDQ1cWtRM1hxMW5iMmZ2ZnRX?=
 =?utf-8?B?TFVZbElORXh0MzNLcHBzVHIzZTlLMGxvTkJtWEZhc280YlpvQlBkSkFOR095?=
 =?utf-8?B?bkdmaml5ZlNweHErcHlZVklNR3Z6Q0o4UGhuVUJ5TEZCOE5Vd1pmbWcxR0hT?=
 =?utf-8?B?YnlUTmlCK01nQk5ZZW9jZ0dUQ25PN0ZxaE1uRSt6bzU5bkRyeENSQ1Nhd1ZR?=
 =?utf-8?B?TDlxQ21zclh1bWRnNjRJdVc4ZGxnazlnTmNlRHIyUXNPMFh4NWF4RHg5UytX?=
 =?utf-8?B?aU9NOWYvN3lMdFNGVDhZNTFINE4rRnBDOHcxYXozVDFRN2ppVTJacWQ2VzhJ?=
 =?utf-8?B?ZWk0YWZYRnpmQjJKenY2T0ExeGs2ZzBydXNZZW0vY28zTlBaSDhVN3VsNFFx?=
 =?utf-8?B?OWVzYThuZ3gvWDlyZFlCbnRCSWtZTkdvcFZRQWpJandvcmNPMUwwZ3hYVkxO?=
 =?utf-8?B?eElBdWpGSGUvYktwamlMMWwwbUhPamJDQVhrTWxpYzhoT2xzcExhd0dibi9D?=
 =?utf-8?B?WklxSjNIS0FXTGVxblM1a2R5MEpNa242c04xTjY0Ym1xRXJ3S2R0MytCc0Vy?=
 =?utf-8?B?UzVCTysyTzlQa3VKKytrSDhIK1VUcjB3Uk11VVhwNXR4NHQ4TmtHSFdRVDJ5?=
 =?utf-8?B?MnlUVkpic0pGdHM5RGV2cGtoZFJtRkp6akNkbURNZ3R0TWNmRzd2cElzSmRk?=
 =?utf-8?B?NlZ0NDhGRnZlL0dockQ4UlN6YUlESGZsY2owWnJWMEJMMWVremVnSnplY0xS?=
 =?utf-8?B?YnYvbEJtbFJRSDZUdnE2NTZLTW9RdnNWL3F1bGUxYUwvOWFNVDVGdDY0ZS9C?=
 =?utf-8?B?OUhhOVZTektzR2FTeUFSSmVNUlRLK2FqYmFwdzhTVnliVHFraVV3SzFCcFh2?=
 =?utf-8?B?VnhZL0dwUGNTN1hPQk15Skc5dC9tZVJQNk1JYzVWNk5RRHZRaEprdEJleUs4?=
 =?utf-8?B?Sm9FT0dUV2JRc3U5b2xRV2R5OG9qMW5hbUx6UDdHU2M5ditQRDJWNHZCam05?=
 =?utf-8?B?ZkF6VG5pVUdtNStkWSszSkt3L2p6S2RtekdXTkIrWnVZNHhPcVBaaE10cVdE?=
 =?utf-8?B?YWZpMDBtdmNjVDFiNVlMVHdOdzlxQ2RUN2hGajdscXpzWGpER1RjRExMWXBq?=
 =?utf-8?B?UlhpRHJ3aHVyNWxxRDJVL3QwUVhBbCt5V3o1NTJPMys1OUFpNWIrV29XZjBx?=
 =?utf-8?B?NGlFZVZrVTVJNW5tNXFwUkVsMnJMUGsxbWRCV1Y3eGJnVW1hcS91WU93WXJo?=
 =?utf-8?B?T1JyVFRGYitsc3htbnF1WnlYN1ZYV081Rjd2UHM1WGZ5RG9IVHJZN3ZhTEtJ?=
 =?utf-8?B?NGluQWRlejJFdHBZa0ZCNzlVZy9sRVIvcDZ6bkU3bTZMZW5WYXM3eGt3cHFQ?=
 =?utf-8?B?ZWxOQ1BwTklNWHZLejZXVm94ZDJ4UnV5em4yOHNQYU4yVTRNY3VwdE9XM1FD?=
 =?utf-8?B?dk1ub05yZDByRmoxYWtYWStneVNFQXQzM3Y5b1huSHpxT0hxUzJRazlMWXA0?=
 =?utf-8?Q?ryXA=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6b4b9b-3ae9-4641-cb8d-08de345497ea
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 23:18:26.5100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pwITOCmiRbJVQ8OI+w+Aq3AH09dZZNY7iQmUj0RusfZtI8w0A6UmaOsWujgZOwr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB6404
X-Authority-Analysis: v=2.4 cv=N+sk1m9B c=1 sm=1 tr=0 ts=69336847 cx=c_pps
 a=1g1g+NiJF5nyOkqFb40SOQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=UxR0MKg7D711HP9QJ9cA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fklZ38SYkHNjDl-ZhGY4u9DB3EXfNLn8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDE3NiBTYWx0ZWRfXzdOJUWUwDh6P
 3sXoUmzPQ2QB6hCVNqFfGRXKdA0hCzdD66hErdI61MNi7EQbn0XeNBNIAGPidJc8NlYH+GSQ7np
 c44Xyt49VY5S1eNg+gavtjsYc92G8KsXmCA9EVB9MZ0mzAKVPYERMNnPM7egM5QoMcnIkjSPubH
 rG4heWotNXm1TWrNa4M+W57ImFj6MCzIyljrf/NXZuyloI5rvYeLDX+3gjCOZrJeuf9HO2Rp9nQ
 vLtF+NcTMv0aHR363iP+JDA7SsySsAcquhy08uNxV1mK24YCmJmKw8YuVSdDOXt80uAyKlIl/5I
 zihaSe5WheQ+xkYp3N7TCFjtUAu6QhwAe7PLATtX4mUSOERTtfYYY6v/F0V1j2eMhxr/1L5HSUu
 y0x+MJL+Gjwq5W+4DXU4/6j/4LmT0Q==
X-Proofpoint-ORIG-GUID: fklZ38SYkHNjDl-ZhGY4u9DB3EXfNLn8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_08,2025-12-04_04,2025-10-01_01

On 12/5/25 6:12 PM, Ihor Solodrai wrote:
> On 12/5/25 2:57 PM, bot+bpf-ci@kernel.org wrote:
>>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>>> index 164f0c941f04..b4caae1170dd 100644
>>> --- a/tools/bpf/resolve_btfids/main.c
>>> +++ b/tools/bpf/resolve_btfids/main.c
>>
>> [ ... ]
>>
>>> @@ -529,16 +532,10 @@ static int symbols_collect(struct object *obj)
>>>  	return 0;
>>>  }
>>>
>>> -static int symbols_resolve(struct object *obj)
>>> +static int load_btf(struct object *obj)
>>>  {
>>> -	int nr_typedefs = obj->nr_typedefs;
>>> -	int nr_structs  = obj->nr_structs;
>>> -	int nr_unions   = obj->nr_unions;
>>> -	int nr_funcs    = obj->nr_funcs;
>>> -	struct btf *base_btf = NULL;
>>> -	int err, type_id;
>>> -	struct btf *btf;
>>> -	__u32 nr_types;
>>> +	struct btf *base_btf = NULL, *btf = NULL;
>>> +	int err;
>>>
>>>  	if (obj->base_btf_path) {
>>>  		base_btf = btf__parse(obj->base_btf_path, NULL);
>>>  		err = libbpf_get_error(base_btf);
>>>  		if (err) {
>>>  			pr_err("FAILED: load base BTF from %s: %s\n",
>>>  			       obj->base_btf_path, strerror(-err));
>>> -			return -1;
>>> +			goto out_err;
>>>  		}
>>>  	}
>>>
>>>  	btf = btf__parse_split(obj->btf_path ?: obj->path, base_btf);
>>>  	err = libbpf_get_error(btf);
>>>  	if (err) {
>>>  		pr_err("FAILED: load BTF from %s: %s\n",
>>>  			obj->btf_path ?: obj->path, strerror(-err));
>>> -		goto out;
>>> +		goto out_err;
>>>  	}
>>>
>>> +	obj->base_btf = base_btf;
>>> +	obj->btf = btf;
>>> +
>>> +	return 0;
>>> +
>>> +out_err:
>>> +	btf__free(base_btf);
>>> +	btf__free(btf);
>>> +	return err;
>>
>> Can btf__free() safely handle ERR_PTR values here?
>>
>> When btf__parse() fails on line 541, it returns ERR_PTR(-err), and
>> libbpf_get_error() extracts the error code, but base_btf still holds
>> the ERR_PTR value. The error path then calls btf__free(base_btf)
>> where base_btf is ERR_PTR rather than NULL or a valid pointer.
>>
>> The same issue occurs if btf__parse_split() fails on line 550, where
>> btf contains ERR_PTR when btf__free(btf) is called.
>>
>> In the old code at symbols_resolve(), if base_btf was ERR_PTR, the
>> function would return -1 immediately without calling btf__free(),
>> avoiding this issue. The new error handling with goto out_err changes
>> this behavior.
> 
> That's a good observation. Interesting that AI noticed this only on
> third try, probably due to changes in prompts.
> 
> btf__free() checks for error values [1], so this is not an issue.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/bpf/btf.c?h=v6.18#n968 
> 

Hmm, it should have read btf__free() to answer this question on its own.
 I'll check a look.

-chris


