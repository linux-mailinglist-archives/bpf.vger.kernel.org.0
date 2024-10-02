Return-Path: <bpf+bounces-40803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4EF98E76E
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 01:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6D6283F40
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 23:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A98D1A01BC;
	Wed,  2 Oct 2024 23:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YXJ5R6fz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TiGQZsT+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484541991BD;
	Wed,  2 Oct 2024 23:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727913198; cv=fail; b=EVr6KYySIIUd0VNJxZNN4YF8Wpw7Q+kIUUw0GKeD/9oCQ3fgqxgFMMsdNLiJIxYtRhd+WYxDFWIrGu63TNkpZJOpW1Wa4BBjrvplIBd6gKcqLOLDclTAPc9abhRYO3HSS/qoc9XqbTCuisEGHmy2H2Tmd0ryqsb4CGjM2PCvku0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727913198; c=relaxed/simple;
	bh=CfvD+aMTqZnDxnmr8RS8e8SOnDZcmfDFeHmjYliiNTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HlDAf0xTAR7/FoFp5AbH0r9RZsQ2u1v+rwZnXkc1mGe/T9Qc/9pCEoOp68Y00AcbYSWojHfmMyuJsKiyc4/C7sUZDGUKX2cSy8LOyBO8KZbYa+3K3++egfOuQpP30C5pq7dkI/3pYbYulLHwCawDkuiog5eMd8MN3xR+yX50Hi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YXJ5R6fz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TiGQZsT+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492MfaSD027749;
	Wed, 2 Oct 2024 23:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=3K5LOgwm4TNCgRqXXYTFNxJXmqOneN/pDF5TZoOIawk=; b=
	YXJ5R6fz2RFc6or/IuECJs7qdb9q0nhgmThC74Eh/P9eqa+l9BaW/dYkXzXnLEyy
	mn3PMizWhg+q9YHuSvp7/8czvNI/e1kllKalFsOe8+NjWXBfCkLe07ZW8W/d3sci
	8AT8eNoiMzwkVB6RIULAEZLJZtKvqKxA4iT5rJYKPbJrLQkgbvwzzDoGSl4Q3qiV
	BbGf2tJiO9xUVNxOhnhWZE/xAKg3T5KGBrY5YCvEKTyssRNpQVYXSrV+X/Sis2Ky
	ceWhKl+O1WcmkVxB/pSuzHn8U0rofZcag1EkFrY64P/+I92vcOXdgi/BpguuH1jl
	J/WqdaCqyfKDnf4ykV6yRA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9dt2xg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 23:53:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492MMtEb017377;
	Wed, 2 Oct 2024 23:53:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x889g638-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 23:53:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VK1vQZN1IwZGf/Dgi6wXRErPRF8ZN5OKB8KT/VkcDmojTNjpIgaTSbiGsWFkOisJYDnJC03x+EAkV1ZDlK+Rm+6ioYGOYlBzQMcBppu6b+zP0hxm5KTFzUGgBwacnyHI97zP7yQ+QGIWhOeClZzWKn07q1wwjdv5QJMw7zLWgHPuAmoJfA2RJpDfXZBB3NkKs3dt2cam3yAIkNq5M4RPKOZvvzifbDrD+dtGXe2Qk9WyynjpUazSj/hSaSfZy9IvrpE+Eg7yrkWXb/c8ltxJ3d38qJEgfZbCWRSFdYiCqTWHVGIxa4aUl7I6VDTOmstAZ6fW151KUvZy9AoF8SQUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3K5LOgwm4TNCgRqXXYTFNxJXmqOneN/pDF5TZoOIawk=;
 b=mJ/6Wzya3gN9Ga3qtNWjEW8UNNfF00/s/fEh1ahUqF4QTPad51Lq5MH8tMhYQ+VGCLig7cj++ptwBJdoi5Y1J11cHr3Bgv6mXI/lXOJ9qv8XT2lNMh1TKfRrgivE+R7m7BG4TvB4UR31Hxjgab2KyxLFbJarUiYeERKaZmTGpw0GEFYf3efxUExsxuUHe3U9U/etiX3fgLHb/APcc8PysIOQ8j/zTnKYL/KH286i2blRTXJcYsarkWYEVM36IoQayIAbYJqqVkilQoUeJh+fFNdnszTbKzHPCHmxtqNMPCUwggSmurZf87PMO2TnBBHaZCBcIwuGYnZSAKatONcF+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3K5LOgwm4TNCgRqXXYTFNxJXmqOneN/pDF5TZoOIawk=;
 b=TiGQZsT+tDzY8DHPQKROVFPZzIUjktFCpgFqkzlA6wEZpfBz50t5nyyn86XIVnzna2RxjFemQpe88qC5hDLawSJ8Ad97c6h7+fjpkyX29oGLg0gTqq6bDaAzoclhWXg1vCu9H1JPscnWto5HUIkOHt3lEifWRGmoT7mrTBj6wi8=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SA2PR10MB4458.namprd10.prod.outlook.com (2603:10b6:806:f8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 23:53:04 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 23:53:04 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves v3 3/5] btf_encoder: explicitly check addr/size for u32 overflow
Date: Wed,  2 Oct 2024 16:52:45 -0700
Message-ID: <20241002235253.487251-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
References: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR16CA0016.namprd16.prod.outlook.com
 (2603:10b6:408:4c::29) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SA2PR10MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: 76bbe1aa-cc96-4be3-f124-08dce33d5b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bc0RfEM/XIDWEPzH0kxR3nYsysgFfju3sNBESRA1RgZR69Cu/+oChEMxacBe?=
 =?us-ascii?Q?Q5Eq55eS52KQTH0s68njpAxS+6geARMDRRoFTFzmwGkWYyzxPt2rli/ehJbH?=
 =?us-ascii?Q?WVDUuLOyE6jvD4hRJpkbuMtgk+oud/OFOiJb1lAXPLmFVRpizUKjQ5SfTtuu?=
 =?us-ascii?Q?8qqCbLgQZIMylHesxPzhHttspv53yHQb+ZGJ055OIvpagSAyQIvwjBodUMdw?=
 =?us-ascii?Q?f7hWlR+tUM++D0FGq08suFzQ1hCKUpsoJ+HQf7fQOniv3FbaynxhcwpKK+Mw?=
 =?us-ascii?Q?X9DC6jakNKEem208e5ftWMO84PP8kmVEqIjxqqjCenFqRah4vENOrtVfHAOg?=
 =?us-ascii?Q?3c7nKiWVpSa2D2H7PvVMyweDmXGgQc5HWu5tuC35XKXbe8H9M/D1hwygnwJ+?=
 =?us-ascii?Q?TwYJV/v/u4MLIYAuFZJScq8rwevpltqhEMv8FB1jWf57qVi8hkcxUpAQvrKi?=
 =?us-ascii?Q?/0+R7ZSr/Th9BZQJkwIjSHZihBalh5QxRbppIJvYCsLUzeVOhiC/H1pOzcEF?=
 =?us-ascii?Q?bTfummyFoIy/E6Dq/7nDdjb0r8uYe5ZiE2Xbhirb4wfwRbQwpC3WlTnAGt9w?=
 =?us-ascii?Q?yAg5G/cfbHwisZOJWJ+CC/HbrS+i2oGNY02MDPULZDE0X+nwXrgMLP0Lwifm?=
 =?us-ascii?Q?goj02Zqck8c50xGjq3h79sCLtrj6sEI5Czg7DGPm1CJ6KfgnJNT8T0smATUN?=
 =?us-ascii?Q?8hFFCqGckyeLCkgq+AUL4VxQF9aAtC/CsoQzNtp7MKytumGIbv7cU8JD4Ufh?=
 =?us-ascii?Q?A7gAoap1OpDuvf/o/jg3qYJ9jZETR38N2TdZB/MmzBa9AeJWHmYndBPBhdi+?=
 =?us-ascii?Q?jJUMK/6rKcaGYQKaTEn9xAO/9pLLEJzBeX3aatu7+QfHWQyoVWLGhQ80G1SZ?=
 =?us-ascii?Q?8dawiQgPs6TezRPMFf9E9NpyyC7Qi13obrHQIvh7URBrL3DEUpPJGWzQxRd8?=
 =?us-ascii?Q?Qji186O26jfKvDAyYilA9P3S84JXWq+bs5Ol0Cn/QsxzH/8baOJe0o1nNYJM?=
 =?us-ascii?Q?gmbfam2mAaTZjjqVQ87tzFd2P2LxgLkBYWXq5gVt4insAufnhLRG6tb8azF7?=
 =?us-ascii?Q?OE4zV0TIFazqvGwq3DtJSxJ5LTlidchYHq7HiNbLe2mEr34C3nXXES4Oj3Zk?=
 =?us-ascii?Q?kMLsV9ncsrODbgN1B1+/LjAJA7L+fTPY/E+bUIvl0jS/dIvl2SS7A0i8BJuQ?=
 =?us-ascii?Q?tocymf+4lsI+cx8gb/PCuNas1kIei7ScPSo9T8Hp1bZ6qIbe/R6a7GbB4iec?=
 =?us-ascii?Q?8/AdpK2TQrjl9LjQRi1HjIetMELNpOdn59GTs1icRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BEiVGpsau8f3wBe2mZ+IjivMIJvJZdvvr2Lr1WVHtOOB5m6UpLK8fGVUAylw?=
 =?us-ascii?Q?JYJUpLJGSZ+ApVrtK1kSDL5Krh+wjpx+Vpn07mcrEgYwlig0XxsXAMWrZT9L?=
 =?us-ascii?Q?S9ZkHopCg9oUHReLsev7yRhfDYj4xXJkOm/qzuEmSU/a2HII6vNqM1SeXuKW?=
 =?us-ascii?Q?52uImSFcJ73izNW/+pxwpuBsaw/6qvYbqVkTmMpMox+GExk3QQ2lxFlgoZ+4?=
 =?us-ascii?Q?QMzCBzH+Rl5jvR2AAdQbiIiugPHpruXXcgRPvYQsCM7MagCtu5qX+chJUKJz?=
 =?us-ascii?Q?pg0yQgJSJrXrVn8Gk+17mU1bOr4qhiG/Nn6S8j9nGQju4VcqgNNHq8Fp8RVO?=
 =?us-ascii?Q?XIv2tAq/1qJwGLy2IcTDQlzDUSRZ1zqC2cl3ungMTU1v6ANW6RfJg1Pt/Fa4?=
 =?us-ascii?Q?FhYqjZJcnbLWmtCrlxOEPG+44xigy5SQv6cHd14Qg1yynZwxgi5fuupJGi4y?=
 =?us-ascii?Q?iuvwWN246NkqJXwYgftLdYuBnT1rPgKI+pqQ73KFs1wGhp+G3HaNgSB1cL/j?=
 =?us-ascii?Q?Yh2m1IVSP3DJfXVkT7NcOI1gTrxVj3ZRgsyRWTaAe+AP8rGd/dRaGB61eEA+?=
 =?us-ascii?Q?I26tGFezMiXGQRDNwLDEGLBwzyMKmqakQhM2OoMmGY3w/vNliJtZ+f3+s1Gm?=
 =?us-ascii?Q?N6PPickEjhPrENNiuu9F+pGNmS71wcH93vLH4uzWOAzLZkzwLdDoOqrOKxGA?=
 =?us-ascii?Q?cIRo0w8qNnGTr7QptTHrMps/v0A3NDkLLOyB6GSa5APwt6UkVOl573Z02Wf2?=
 =?us-ascii?Q?+GL6SWCedP92fY98dOWX+vi5vAtR/Ar0BkRK5iaPfNWh5VrHSAXyj16am5nM?=
 =?us-ascii?Q?LM7WIBgY/WFWsqa+Duev0Qaow2G9E7W93d/ebDv2Gt8UYhY9dZzhjaA9NZOA?=
 =?us-ascii?Q?xJI3t7bd2YTFiOqm05UIlk0/qcQHwKQ+MDmZLQoAgNgviEnrgLmtfxHJRvxj?=
 =?us-ascii?Q?iKya111wIv8ZQLINOMAM/uJm0DsC1ZaMKnIxzBoV+yfXtzB46KhuwhoZrNmA?=
 =?us-ascii?Q?5Bw8sERmMnNO9p0r9ne5KoLPJ+3ephASzkur2wBGnzLJQ2knwVZ+NCUE4vQN?=
 =?us-ascii?Q?JwMYoi5RE1VmI+dMgD0SnVWqoIAOCDNrx66dAmWfsh7fCPcnEXyJjtJXzBIw?=
 =?us-ascii?Q?jc8bT1bYasHgaA3xr0/R9d+XFn8nkyPzUK7+tObqt6yABSltkojzy1Qjxja6?=
 =?us-ascii?Q?dqM0cQ/5fz/qjHto6sQ1jp8Z+eTkfdt400w6EiIBou8i+L3bc0Lo4FZppPgC?=
 =?us-ascii?Q?AwK53O7xTN6OX0B5OSAuQ9ah13sak1uROpLCUMNG46dyNnu1pJYXy8QfKyKp?=
 =?us-ascii?Q?TY3sGA49Q1FizY2c+kmlNz6t04DrXcGkrwDxVY5krPvHEFzyxmbPvmqovLNr?=
 =?us-ascii?Q?tab7U13Joh+Ie57OvQ66j/KtVaZ+ozR2QuCe6TH9gCgkz65MlZT1ivAYetO2?=
 =?us-ascii?Q?0HtpWiZHHwWrVQFu/AXYJEJFUhcrtB+3D7a3UDTTocdosYQIont7nXTIfyjL?=
 =?us-ascii?Q?9+9V575QqEAW0kxY3ZW2EDuO2/3+GS69WYRYVvRd5bCgCCkKXfKcrJLqjLCP?=
 =?us-ascii?Q?lsA1ghRPrybQCIX+RVHx7jbsgXf3Lr46sJxB8LdZqXq5NIzTDeoTLb4eqMoh?=
 =?us-ascii?Q?2avNH1xm33HvqyCT0DkRvY4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jihgiE0bV8fl/i/8bK5fdF49py95jgSkNqmwxZOrx+LAYABcPzRzBkz9JupF7QHaZTjQO8UDkF4pDggS5vdojj5IhYOw8dv+BTufTgf68MoD9PjmJNs/8M+THjdqs5E71az5DvLDpp4o45jO3s+DupNJdCbFgbm0NXnI1cR2PuTPrKW9PIQTBQiMZrTyyaomTqRNa8sygo+Yl67WAdy4iI4MxLLM8W2my/wgVbSRJcaplnlYuRtiv1k5R/WA2dgmdB5AvxhoDNQxNqwWrRSGk9gLPZeOlCtYZ6dKIPMoQgBqCiaOFdKlk6B5hGnmIGhwGXQ3FJGA6PPdqCGI+PH8MjuG0ELDw82zmiHQOBn3I/lBDQ+K+rKyLHEve3XWkfyZv4xgWnEO0WrJ/cZ6dWWMyFQcVIKm785ArSqdduPowskXI+ifAgN3ykU3KyrX3BCGcrbmMZl5BALgDddKzO41FXJ1x8tlVGgKHBcdnX8kYbdS/Boavv8BqarYEtIwuoKVAvQqUDASu/lPvp7jB0Uwr0d5NyW07HQWe2kL8ee6aBj0f0sTHDY6dNnN9Ii+gfAVYk4WCYVz1A1Phr+tp14jpAh/71bc5k1FUX8m67amFBU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bbe1aa-cc96-4be3-f124-08dce33d5b70
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 23:53:04.7882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLqWpYriTE3byQi965XdqvSFktkQmTYo/7MAQL5uPePfGz6SDp5njSFOZDy5OByWb+3950NFXI8K0SySLEWAan3qBIAoL7Ot85lKHFz/o00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4458
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_21,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020169
X-Proofpoint-GUID: -nzxc_7L1cF7bOvmJQWTs0cqMuxSIzV5
X-Proofpoint-ORIG-GUID: -nzxc_7L1cF7bOvmJQWTs0cqMuxSIzV5

The addr is a uint64_t, and depending on the size of a data section,
there's no guarantee that it fits into a uint32_t, even after
subtracting out the section start address. Similarly, the variable size
is a size_t which could exceed a uint32_t. Check both for overflow, and
if found, skip the variable with an error message. Use explicit casts
when we cast to uint32_t so it's plain to see that this is happening.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 btf_encoder.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 31a418a..1872e00 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2250,9 +2250,16 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 
 		tag = cu__type(cu, var->ip.tag.type);
 		size = tag__size(tag, cu);
-		if (size == 0) {
+		if (size == 0 || size > UINT32_MAX) {
 			if (encoder->verbose)
-				fprintf(stderr, "Ignoring zero-sized per-CPU variable '%s'...\n", name);
+				fprintf(stderr, "Ignoring %s-sized per-CPU variable '%s'...\n",
+					size == 0 ? "zero" : "over", name);
+			continue;
+		}
+		if (addr > UINT32_MAX) {
+			if (encoder->verbose)
+				fprintf(stderr, "Ignoring variable '%s' - its offset %zu doesn't fit in a u32\n",
+					name, addr);
 			continue;
 		}
 
@@ -2285,7 +2292,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 		 * add a BTF_VAR_SECINFO in encoder->percpu_secinfo, which will be added into
 		 * encoder->types later when we add BTF_VAR_DATASEC.
 		 */
-		id = btf_encoder__add_var_secinfo(encoder, id, addr, size);
+		id = btf_encoder__add_var_secinfo(encoder, id, (uint32_t)addr, (uint32_t)size);
 		if (id < 0) {
 			fprintf(stderr, "error: failed to encode section info for variable '%s' at addr 0x%" PRIx64 "\n",
 			        name, addr);
-- 
2.43.5


