Return-Path: <bpf+bounces-68380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87908B575B8
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 12:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1122117FDA7
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 10:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FA32FABF6;
	Mon, 15 Sep 2025 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zq28uvgK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XRYrY6Wq"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1142D7805;
	Mon, 15 Sep 2025 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931108; cv=fail; b=UcS1WNkAHJK3MwJocEk3cEtFiJWRPbZOdWjO4hqQNLbSN3hEtToJYNGgch6DGQDNFf2SY0+I91kpRGPPK1JU02RoPnHH41P6AsNrpcqrTuSACUR/59A6lIshB4uEtur0MFplLQlNcyhmPuELldMbIyNO+9vA0goCdpf9BW9Ybbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931108; c=relaxed/simple;
	bh=4Xot06Bxzua20Vk8IJnr13msCo+c69xEz9kkPKWQFsA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 Content-Type:MIME-Version; b=EtWzGMTrPxHvZgQhQOSZZrWamzJvsXYC1vmnblnJwfpHsZg1zl8beiiVqtRRGaVomqj/sCJT3AvoolrxKfVN3XJ3wJrjwUOhssHy0jKLTUt2qnuZqzGIH3oFTmUGL4VfZIGFJ0l1gdyH0SeeC/eOI8453pQb0POSJf+lihumAbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zq28uvgK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XRYrY6Wq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F6gGha000403;
	Mon, 15 Sep 2025 10:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4Xot06Bxzua20Vk8IJnr13msCo+c69xEz9kkPKWQFsA=; b=
	Zq28uvgKzmnOl3mqmg4cZXFjSCoXOC+X1bm4SJNNAz4A0LzrwCp0MKysSnXWBxAM
	FZMJJ4PXIByqi/UOVHa1Edpi9RSdghcCpGyBxLcTvmlEJm+UBFn6KqnK1UI3b/0y
	NRpP6VM84r8WVcSIiCU7iLDMN+RH6fqfBn3qzFawI64CmcYtrYDYey2NuigRNCjc
	mRnunKANlK51GLYwzrK5d0oSZHEIy7Dup7nbdF0wMpYl7XqasscZsyRYtzKuWv8g
	ndSkR8XawyBoZxAwbNghLL2Z7zpw9ozrddZVOFnQj04soGfdwNBD5a8SMHLeTuQ4
	ouYDeCBLERit0mlG+QgxkQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494y1fj1ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 10:11:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8lVxa021568;
	Mon, 15 Sep 2025 10:11:37 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013016.outbound.protection.outlook.com [40.107.201.16])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2atd4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 10:11:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfxOuY0x1hCHVsIKFiq58he4v2Mw0KkUlhFUJClVNiVtXAtmgswW7XkeDAw9e89/v6Zx5dAA6eDSxEevSvYCWvYCboZRK8ai/BCzqFkZ2BgrIHw8YKuQC5OWDO3TmnfRK/c2P+ZKVtMMBQHLQsmg1wYpQuamVvd9E4Wr9HKLsG+A/PxP9ScRFcccp0d8KCa2JgL7QSdR7HY2MoAu6paDlYYvIUtcfs4azbFmLIIrlRA9mHOA9VHCCZ6SlYbNRDm4mcAVPFkGt850hf9AC4VbWJN73zaldMmQkVoXRM5+dWh80GsY38fq0hEFK7JOYj8ZrQyoNGuk0sdt98PcceKUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Xot06Bxzua20Vk8IJnr13msCo+c69xEz9kkPKWQFsA=;
 b=wt2u2rj2aOhY4pSc4eF6T7PX+xjEgpa/1fd5/j1Us7L7magLJj+kYo/OO+kwmzio1mMftE0/4N6YURIjrDMoi6CasWkeVv6q/zjN+A+hWPGOQQXztiGTQ8hSIJdYuYqaCqHR6K8O/Ftj8QpGZgdyU84UPQ+cWnFgvXUzG+fP6dJG2fp+tkECyxWvDPjATPd7CmdAr16rxafc7hlwYGlshGzey049Atgs+3JfGv0bbBf4e2IRbcU5K8WPydZVByt2MNq5mh7qe80Lrfld9+uIRmd4+twK2QAPbaSmNMrgoFbOrLX95hW/4yNd4W5DogOFJrmSv5v9ntstmLBdfObjcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Xot06Bxzua20Vk8IJnr13msCo+c69xEz9kkPKWQFsA=;
 b=XRYrY6WqQTf1Waz4WQBUVDCSkz9V8v5sLslMRhNguPJlAm1PdrdOgp+va90rT0byFWBozMggUzHuF+LmK58g+juneuT36ZRaCWIjqfdlaj1K4/Av+AZ87myB4TYrt8X4PFNFzEF/9PAd/nqWRGbRayQCot/Nac7zMZLOwiQaeBo=
Received: from PH3PPFA3184E4F2.namprd10.prod.outlook.com
 (2603:10b6:518:1::7bb) by CH3PR10MB7714.namprd10.prod.outlook.com
 (2603:10b6:610:1ae::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 10:11:35 +0000
Received: from PH3PPFA3184E4F2.namprd10.prod.outlook.com
 ([fe80::815c:d94d:29c8:ecb3]) by PH3PPFA3184E4F2.namprd10.prod.outlook.com
 ([fe80::815c:d94d:29c8:ecb3%8]) with mapi id 15.20.9094.021; Mon, 15 Sep 2025
 10:11:35 +0000
From: Nick Alcock <nick.alcock@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Nick Alcock <nick.alcock@oracle.com>,
        Arnaldo Carvalho de Melo
 <arnaldo.melo@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Arnaldo
 Carvalho de Melo <acme@kernel.org>,
        Alan Maguire
 <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
        Clark Williams
 <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, dwarves
 <dwarves@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song
 <yonghong.song@linux.dev>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [RFC 0/4] BTF archive with unmodified pahole+toolchain
References: <20250807182538.136498-1-acme@kernel.org>
	<CAADnVQ+cvvHN9CunLP03yRFKz2YJirmF0j80-fZ0A-8aVVopPg@mail.gmail.com>
	<b297444e23c42caeab254c90fa91f46f75212e29.camel@gmail.com>
	<8EEC78FB-CBFA-4DFD-827D-3D5E809ACA0F@gmail.com>
	<87zfbsici0.fsf@esperi.org.uk>
	<CAADnVQKRuMzZWq5k3Z-QVCyLiR4Vin0zjPR36Om0fQbZ3RGYNg@mail.gmail.com>
Emacs: ballast for RAM.
Date: Mon, 15 Sep 2025 11:11:29 +0100
In-Reply-To: <CAADnVQKRuMzZWq5k3Z-QVCyLiR4Vin0zjPR36Om0fQbZ3RGYNg@mail.gmail.com>
	(Alexei Starovoitov's message of "Tue, 26 Aug 2025 17:14:15 -0700")
Message-ID: <877by0vxda.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::14) To PH3PPFA3184E4F2.namprd10.prod.outlook.com
 (2603:10b6:518:1::7bb)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFA3184E4F2:EE_|CH3PR10MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d983e78-8822-4119-d687-08ddf440401f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzZPZ3NkRkc4ZWtBQm4rbjNiaUIxRSt3NmR4MmMyUVByMmlpR29Vbi9mc3R2?=
 =?utf-8?B?V28wMlhzaFAxMHlCK21IYUFEOSt5NXkwSXU1RElLMDVEbGY0NU82aEh2QmRt?=
 =?utf-8?B?anV2ZjFuakNwN1hOQThyZmQ0MzB1YWFkejF2MzV0RS95bG4ycjM0QkhuR0d1?=
 =?utf-8?B?SU9KZENjNGJDK2wxMnQ1Wk13Sk8rWGgzMXc5amxKclgzOGxHRE5CVTRHMUhQ?=
 =?utf-8?B?b1JCRGluZTBHNHUvdnhaRFFpaVIvVzV0WXNoNWlMNHcxeFJpbWVPMjg2Vits?=
 =?utf-8?B?RHNZb3UrRFpaeTdYY0JKK0NTMTF1NFJSc2laeUdmVVV5Vkhnc3NSQWhFMThw?=
 =?utf-8?B?c2tibGYyRUdSSWxoRm5xM1dtd0dHME9yd2c3K01ZaWVMTUJIam5GV3l5cnZk?=
 =?utf-8?B?dnlTUGJZWWFXV2swdjNhNkhmcVlrdUdWYkExTDFNeGpvaEExTXMvQk85WTJy?=
 =?utf-8?B?aVU2WTRRVU41aDh6ckhYdll4RUlhSmZ1cGV3QjRHSW12dkRmSVJtM1NRVzlt?=
 =?utf-8?B?eWo2a0dsdThEV3lZVjlTblc3V3ByUU9tQmRmMFNMNGlVR2VidFhXQUZXTzNl?=
 =?utf-8?B?NzJKVEd0eWdYcno2Z2pnMnJrRFFwc2Rna0c1QSs5a3lOWmtuSEh2Nml5citz?=
 =?utf-8?B?WnJ3OEtleGRIUmQyWEFFckJBY2svSUZwcFAvd3VRUmhDQ01BWWxSVjVNa1ov?=
 =?utf-8?B?bEc2OU0waGF6M0kwWGpiemtoQ2V0R3pEemZYalZMUjZubzVaNDVma0VKNXRY?=
 =?utf-8?B?WHp3elBHd1d1bENaSjA3WnFSWDNXZHJLSHRBcHNCNldXNUlDdHJqMXJCMFp1?=
 =?utf-8?B?SkdzS1k5Z1lLM01HMHRCZ1FqbU5qdk5EZkFjTVhnVXFQWE8zaFROem5VMm9i?=
 =?utf-8?B?MEVZNzdHaU41ek11dlFsZVBiM2Rzbm1MT2RKbXJVSDVQRzVMekZ6YWsvR2pm?=
 =?utf-8?B?ckpNWndYSkpMVFpoUHI5MlFZdlk2RFpGYjdzNmVJOW1XOTZQU0RiZ09NUU5W?=
 =?utf-8?B?THQ4N3ExMjh4cmt6R3g1QjF5Y1FyRVhHSWJBdlhmdklIejhmaEN2Z2VlSXpJ?=
 =?utf-8?B?bGV0UkdyQ3RGaW96ZTdxWlV0MVhWMTVsWmMwam4zWUo0b3RBSVpxR1BxN0FD?=
 =?utf-8?B?eEJ3ZFYxZkVDMW5LUEJVN01raXJpVlFhL1NEdTRqejZYSU03dzR2WVJ4eFVQ?=
 =?utf-8?B?d0pPcHFQYlNzcTJ5Z1BqY01ZWVhCQWViN3BxeTMwaVlPV1A3cE9JYVErS0lF?=
 =?utf-8?B?Zzh6RVBCNjhKM2YxMnFSUGIyeWllWHUzUE5YMEw2UFJ1QkRpdEFoZHkwTUVq?=
 =?utf-8?B?QWZDcmxDMVJzMVN2Mk1Ld2VSNTNwV2ZiZm44czA3cDVuOGtJUXRDZXZ5RDZo?=
 =?utf-8?B?KzdLQ1dDaDJSTzFsVENsL21GY1dWK0FwcVpwRkxjTHVtQmxYSGM5SXIyUnk1?=
 =?utf-8?B?TWFNclMxTmh5THUybXJMSXIxZUhlMUYvdTI0bWJ5a3RndkNhRWovNmxIbHFv?=
 =?utf-8?B?TU02YVFBcFpMYjZSU0dsb2FGYnFWaVQzMzhWbUh2bUZMM0xvcEpCYmRLd0oz?=
 =?utf-8?B?OTgrNnk4QyswY2J5Z084dnJlZnM3ZVBsM2h0TDY3a21wYy9zUGZFd04rVzhq?=
 =?utf-8?B?SEVOVlFaTTU3YnpQRGdCcG9MbVN3bkI3MFJ6VGpzQ0dHVHlpL1d0aDJBUkRR?=
 =?utf-8?B?V2s1bzRmU3pSY2FJRnR4MVBMZExqQUErdlJqZG5CLzQ2N3owY3I2dnorZWU2?=
 =?utf-8?B?ZkRmSU9zZlQ3NWVoVnpkd0w2TUxsWTFqY2VsVm9Ya3d5cElPUFJqTitSZ0Ra?=
 =?utf-8?B?UFhSRERWYm9WOWtkdTB3TFZoeGdUT0RmWlVEMy9jQndmZG5NbGs0VEVnOXR4?=
 =?utf-8?B?bnY0OUpMY3V0ZU56S0RDdVVXZ1c0azNaRUVPOU1STGJBRVFQN0Rhd09VNWZ0?=
 =?utf-8?Q?NkxYJxG2pw4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPFA3184E4F2.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0Q5dDdodmZzQ2N0eDBCZTNEYkhhVTBKaXFuWWt4R0c1S2tqYXkxaXFrQzk5?=
 =?utf-8?B?dTZRVm5YMmFQQWJ2R01vdHZzUGlxSHM5Yi8wN3JRc0prSXJ2aldOcHlvb1k1?=
 =?utf-8?B?a29TbmdnVEY0b01BN3VGem5wNmM0N29ObnJtSXpoUHFlNnlIMGhBRU94SERm?=
 =?utf-8?B?Wmt0Q0lwemtKRGZ1WHlyNkpxUGh4M1Z2YXBPWDd1TTBiZzEwMk1QZlI3MVJm?=
 =?utf-8?B?UmtJblU3ampnOGhaSFd1ZUFtV0FtSUVjZGZQSkJLbjFXQysxSEx3eDliYWhy?=
 =?utf-8?B?dVl1bFRIQy8rR2JrTjN3MzIvY1RRNUhtZG1GaHk2Q2NUeU81TkFudm1CemIz?=
 =?utf-8?B?TzI2NVd1Vk5ndHFGSmxuRk0ydWt3UkVPS25seEplc004aVFyUWpVRXpHMHVz?=
 =?utf-8?B?MU9TMW1iL0wreE1QaGVZR1pEUjkrK2FXaExSelVFMkt0VWdvdEZuZEVRYWJh?=
 =?utf-8?B?NDVzWnlyMWp2OEpSc3NtSzl6M0hlNnllTG8zVjJsME9kWnBvY3FWd0hFR2o4?=
 =?utf-8?B?SW1vM0t1UnBGeXgxOWMxem8ydjNqU3Z3eWpMblpOdVJMSkZXQlFxMHE1Rndn?=
 =?utf-8?B?bEJ4cHlFQ2hHWnNXRVVrY2JBZXI4SC9XaCtvcFF5NnpLTmJJZGkzK3Fob05H?=
 =?utf-8?B?bEVtbjVlMzJJR2FVcm1tVHdhNnhVTjFTZDQrN0JVZmZKL2QvMXVqbU9tV1dp?=
 =?utf-8?B?K1MxVzl4ZzN0MEVweTlFZWkwOGFBWGZ4WERvcXZiVGNiWXpWL3dNRTNmTDUy?=
 =?utf-8?B?V3k5cDN5SHI4YXdCNVVyUW1BYzd1ZDRUaExCeVlHNmFNM1QzbDdRM3R6RTcy?=
 =?utf-8?B?THlicFNPakRDb3l3eVMzZ0dLNU1nK1JMMmRibXNCWCttOVlqdnExTDk5RDdM?=
 =?utf-8?B?SkltVGpsWXcyVWowcm5URG5qZ2JKV2lndHVCQ2lwT3NWV2xZSUdkSFNOZTlq?=
 =?utf-8?B?TXJsUnZVUlp0VzlHbWJTRmtMM2tiUFdUR1ovbUtlaDlJaGNkVEFwWU9lMXg1?=
 =?utf-8?B?WE9IZm03cUV2VytQc1ZXNCtteEJEbXJoWXZ5VGhPTFNmOExheU5XWmlmTGtE?=
 =?utf-8?B?d01TMnhoam5ueVdrdWhWeG1wcXpVYzYrWDFMbGlMWHFPckpTaGVjaThDSFhr?=
 =?utf-8?B?MXd4Y2Z0bmVWVG5FckNoZk96NzROZUxHWk4rQkJiWWs5SUdVUlJRblF4OEJz?=
 =?utf-8?B?Y2p4dGVBaWhNTVlZRE5iZFZPL1VzTk13bTR3WmlJVFlpeFowME42Q2x0Y2hm?=
 =?utf-8?B?Z3c2aHRpRE5NNGtSdk1KS3RlbDQxMVByOExYVytEYTNzWXo0d1JGZUl6TE5P?=
 =?utf-8?B?ajhkRURBdkR6YlBPYzRxcjRWQlQraDlDZjd6blhIZEFUUGZwV0E5cGdnZkdM?=
 =?utf-8?B?UUVMTHFYdEZRT0NqQ0gvWUlsSlVzUGxXdUVVUEUvQTR1citkdFdGd2RKWS9h?=
 =?utf-8?B?NXFQMjJDTFRkdVlLNEZ4MjRqZWczc21wemFoYkZ1bFNYcUJEM2NOQTZ3bUI4?=
 =?utf-8?B?SVllOU44UlNtWjVwVzNvYUZDYUNSY3FKelJOMnJRcTZUM0VDNmZHbzlaVk5Q?=
 =?utf-8?B?WUpGNU5uMTZNZitodnRPR3JyemZoa2lkSW1sQ1VzcVVnSGNMM2N4b0E0c0hr?=
 =?utf-8?B?RFhyZkJJZ1NsNHVGNWxLMGU2LzRtRmlwZHFMNHlncFdta3FhNUZuVUMxVVZD?=
 =?utf-8?B?REVudjNKWmUwTFBZMFpxeW16SjJHQzYvS1JNOFVmUGwzakFRTHR1ZnZsL3Rr?=
 =?utf-8?B?ZmgrZTI0bWNpNVRVS0pZMXBKbERqaGM2NmJ4SVZKeWp4WFJvbHNKckp4N1NK?=
 =?utf-8?B?MWI1Q0I5bVJOcUpxbmNyS29BWjZXbW9qVUs2dWJvTU9jdXh4V2ZOZVZSYzFF?=
 =?utf-8?B?VjFSc09uYzQxeXNOY2Zzc0dPV2ZYUGJzWEFKUkpFVy9nL2F0dVpqU3kxQVdm?=
 =?utf-8?B?V1R0MHBTQ1dXRFdhZkJGN0FzcHRyaXN1alNXQUUwZ3N5VU82ME85bEVId0Y3?=
 =?utf-8?B?a2U3V2dNYjdZSkdwZWlGY0w1emJaYkwwRnFtR2lJaHlBSW9hYzZoTmQvOFZs?=
 =?utf-8?B?Uk5melZVUE5Kekc1aENKUE5LMDBXRm1lSFZFMkcyZ3JUS1o0UXM5bnE3K0Vn?=
 =?utf-8?B?NUtIL1hCMTZ1YlJUdDQ1eWl4ZHJRWittY2xaWGFzWTFkeDBlK1hsK3Zud2ZJ?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M51ekmIyNk4M1H5cVUFqp39QsVSyFnd90KoGti2J3Ao9TmXbgzrvosGbROnMUdO2zFy0wKK/vJUeJ59lj5pUSAyEjDUnWjoTSMYCXrOCNi9pSGvYP8SzPqh86gje6pTessMhDQrYvrODn6QwKXlS8hInLWYUfTCTre5T9PVbEmT5PK5nWFA8zenxZfb+PKt3Qqo/36flGTbj1ZZooIeq43O/jEOF/z9Zh3aQv0refIsh9iNNaX/D1O8HtBAYRdZwQLdWYlzkcr1v0fabyecd/8Lq0Y7G9upcOKJCcGtoM8Cu4nLbWxDINoQk+IluiI5iLmn/XXSQefHibYvkFsKe+6QXSlIjdxV+e7AXWnxthE75i0XR5EQkoypbZnVb3wO37imNAuPt7c2f17w3R1U4a1vEPPaMCNwiiKZjulilABXi1gp7lvG/JNl3GfYOQ+Gs1DgSX9haX5CRnsyjpZCeZI8CF7qZ5iUJZtVve+LCrCr/cRI43XhJVtuuNLGA9/Z36ESz3ahZ+lGq9QP//xA9QEshSFPI6R5Chw+d77tBpUQdpslBHvYzyms/IjJX6lxm7szCiXSBuNJxF0noipxxZm6sHYuBl33x9r0YZfiG7DY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d983e78-8822-4119-d687-08ddf440401f
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFA3184E4F2.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 10:11:35.1561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BwOCaitpFR1CATkKpHAZeWuUGgssHkCZYR11HuoKXsHAfNPiydVF1zq6IrpR9ev/kU+7B0r7pEBFus+9qiIuhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509150095
X-Proofpoint-ORIG-GUID: 1-zRsOVBTQfSDi4LR4gb0ns74lNhlhte
X-Authority-Analysis: v=2.4 cv=KNpaDEFo c=1 sm=1 tr=0 ts=68c7e65a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=fG7_nLX_iXDlMi6saAsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1-zRsOVBTQfSDi4LR4gb0ns74lNhlhte
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxMiBTYWx0ZWRfX1ZrK5EfoHZqQ
 HpBo/EDxMKWCYU92Tku0IBwqeffYmtomATiI92+bFEnnilI3DIo1GtA4ruPY9e0axS6MLDsLYEY
 HF3rSM373jX7O8vYOCcmJoWyQLxlOANB/MnvBiwM4KVaVY82HMJEvYNh1Zi4qDTl4yV6O4rtT/e
 ixNkEAOguvy7Pf5aM2iDY6QDvFmPaSPYl2AWZb4k0DzfFhPc522u+A3bbnlcgK14xDLWhcUryvA
 8n2aMEHmFNtWCWSlGnUiyMhBeAStSZdlyjwsC3UYQfa624Svra3Sfqo18SfIsN9GzD70dyUjksR
 MB9Hs6l76V0s1kDMgOeymZtnDaD4xYZJNevRtC8IF6R4QY+8O0bGyWIhNOFdS/ARjE/XyBBy2Ma
 afJDMH5u

On 27 Aug 2025, Alexei Starovoitov stated:

> On Thu, Aug 21, 2025 at 2:35=E2=80=AFPM Nick Alcock <nick.alcock@oracle.c=
om> wrote:
>>
>> >>I'd like to second Alexei's question.
>> >>In the cover letter Arnaldo points out that un-deduplicated BTF
>> >>amounts for 325Mb, while total DWARF size is 365Mb.
>>
>> That very much depends on the kernels you build. In my tests of
>> enterprise kernels (including modules) with the GCC+btfarchive toolchain
>> (not feeding it to pahole yet), I found total DWARF of 11.2GiB,
>> undeduplicated BTF of 550MiB (counting raw .o compiler output alone),
>> and a final dedupicated BTF size (including all modules) of about 38MiB
>> (which I'm sure I can reduce).
>
> 11.2G doesn't match Arnaldo's 365Mb.
> Frankly I've never seen such huge dwarf objects.

I have, but... it was a while back. I shouldn't have worked from memory.

Regenerating with a more recent toolchain, summing up all written
section sizes (so, undeduplicated .BTF compiler output *and* all the
deduplicated module intermediate links) I usually see DWARF sizes about
two to three times that of the .BTF (e.g. the BTF selftest is about
800MiB versus about 400MiB of BTF: the final BTF size from both
btfarchive and pahole is on the order of 2MiB).

Using a random enterprise kernel config (so 2900+ modules, etc), I see
4072236343 bytes of DWARF, 2199803264 bytes of undeduplicated .BTF
sections: so, again, about 50% reduction.

(toolchain-level dedup on this one takes two minutes and peaks at 5GiB
memory usage, producing a 40MiB BTF archive: I know this output can be
greatly reduced by a fix I'm planning shortly. :) )

> I'm guessing you're using some ultra verbose dwarf compilation
> mode. If so, it's not a realistic comparison, since typical
> kernel build is what Arnaldo reported.
> That's what I observe as well.
>
>> >>The size of DWARF sections in the final vmlinux is comparable to yours=
: 307Mb.
>> >>The total size of the generated binaries is 905Mb.

Ditto, now. I dont know what weirdo config I was using before (I suspect
it was just an older GCC with a different default DWARF version, and
this is simply DWARF 2/3 versus 5). It's still a nontrivial saving.

>> GNU ld), despite being single-threaded and doing things like ambiguous
>> type detection as well, used 12GiB and took 19 minutes. (Multithreading
>> it is in progress, too). allyesconfig is faster. Anything sane is faster
>> yet. Enterprise kernels take about four minutes, which is not too
>> different from pahole.
>>
>> I was shocked by this: I thought libctf would be slower than pahole, and
>> instead it turned out to be faster, sometimes much faster. I suspect
>> much of this frankly ridiculous difference was DWARF conversion, and so
>> would be improved by doing it in parallel (as here), but... still. Not
>> having to generate and consume all that DWARF is bound to help! It's
>> like 95% less work...
>
> Something doesn't add up here.
> Everyone is using pahole and lots of people doing allmodconfig builds
> with pahole. Noone reported that pahole consumes 70G and runs for hours.
> Something is really not right in your setup.

Well... yeah, that would be the make allmodconfig / allyesconfig
configuration options. pahole takes more reasonable times with more
reasonable configurations, but still ten minutes or more is fairly
routine for me.

> Pls use typical kernel build configs then we can have apple to apple
> comparison and reason about libctf pros/cons.

I'm not sure there is such a thing as typical, really. I hope random
enterprise configs will do, but they probably have more modules than
"normal" and God knows the BTF test configs have fewer :)

--=20
NULL && (void)

