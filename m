Return-Path: <bpf+bounces-77854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A383CF4DBD
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 17:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A27DE32EB286
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 16:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B70328243;
	Mon,  5 Jan 2026 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mi44rDvQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vqeVhnL3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C722DF13F;
	Mon,  5 Jan 2026 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631665; cv=fail; b=R6goa5cSYZMiUURfiUlJb2rYbPdksFBvEb8q3gQnzF11UcACaJQe0fOObPeAd+PVUprDdYskjzPSI3VIGlImz7SRQ8osPtE6xrl9EiWSgbeMaAvWjQ9nWzMzTN7STc+sbb3FHe5OpILlHyts9Xb5j9wZ7pLEkvqm8T1xvMQ+VzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631665; c=relaxed/simple;
	bh=HaVoDBbH3zpq1LFBMVUOjgV0/ro9nk3I8rYUmx1Bm7c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KI8kvj+TAvnglfSM1i+R7NGLBnJkeY3gVWE5qlrCfgjKOJFicGisoMxnwi8HsA6jBrxl9sDVS3sp3rjhhF0es6WfwE+wNAeSZDp+6DaxUAyOZ4RrWP46qzeg+fULYa2gjdSJdEKGlesfP0Aj36jHyEjf9k+fXGAK3ETv8v5yCq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mi44rDvQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vqeVhnL3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 605GLH0E2309782;
	Mon, 5 Jan 2026 16:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=X6uUBShu+Z2sNIXE6CTmzy+W0EA+BoJAp6+9A+9OCiw=; b=
	mi44rDvQHHHGwZYH6b8ryx4XwszD41TdOalvzs2/Ca0AKSkQ8Lh095lJgri1gCIO
	qbtOshNNaAHKPssaS1Zpf1WopZvDFZ2164XXoylg1Cg5U9JMyKOWKpQuT1P2Xbyj
	0IpM9WfCyz9bItKpIWV93FuhMdQgfKBE2CynIr1pGf6p9qP72gR/3SXFlc8OUxfD
	8sDrsmfGeSEG/BUTiyyMOlZL65Weo2ardmgR6Dy2W3pNKgdo1HzFzab8wOym6Rx6
	bYr9g2k/ldxbi5DNnF0X7Spot71gTW0cl/URbQN+P8D5US1jFgJ/8KiCr1JOsMdc
	kBAwVSxhG2/LNy2T8ij61g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bggrdr1p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 16:47:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 605GUJYG040098;
	Mon, 5 Jan 2026 16:47:25 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012050.outbound.protection.outlook.com [40.107.200.50])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjhk51f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 16:47:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxKDTDkAvlVpDx8flLdATqpbw2lrnDXkbi8u5ZdI6JSnaN/S6kUyMC9mPUL1ND8OZwOM5fOXuIvOqcd8jIRODm9dkKNJXNOWoxb+IpwJTyiU1q32mEZaIP0g/Acj/GnuNuB0AY8p6Nwfewz1U1t8lH6UT1kxgM6QOLNwacsbWwcHYXlFbO4vk0ucZDlZ3imfO7I5dwCRqdQln03VnqhPYwnQUQcDHh47n7peFp8VSQG2ZWuCARvmZtk4f2AtqnMNFvy0y/hqtsxhAS9KIKnlDTuYAUq9ZHowv4K5SsH3baDtb90aU7MrUiNGz0bvqfTNcf6mF5oc3+B9IJbMaTHTzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6uUBShu+Z2sNIXE6CTmzy+W0EA+BoJAp6+9A+9OCiw=;
 b=Y+8Af/VQ7aByKyVUSi3dNvkOkj9x/DPKLTMIU8U60gnH8eDmrXnImnZSN1jF0mgADehyQUlIeujvkM3yooRcd/ppflSE5ach1wYeQxdKsLmuwYdzSevDqQeUelGYsBwEgY7V2gEjpqZBsNdn8n4F4mQAcCqh9OZkh0yJm5EvlyIrW/pKVwomphzXKe2S7BvYCtEmbooID0egzYK+jJICNyWFN9UpVlbaM5J0B1zuz+uDNZdN4pI0PV4tfgBPXEyVcQKZ095Xu6O6HLs9o1VhRuqHtCQxekU6cueiLGPY07Qp1TQ7AIszYY8f4qObgaWX7bBNJm1Wnbte8MpCO7/ZRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6uUBShu+Z2sNIXE6CTmzy+W0EA+BoJAp6+9A+9OCiw=;
 b=vqeVhnL3fisuVUuEdYlkFAGz+lALa02bJ2U1HKBYjypd2hOkKY4Bfu1tdu1kJbk21DOM74t5ktFXXbVpnk3dtu74rtKD1TwAoH8PORR70XZm61y9dpzLEjiZrJMfh7u+aI6OvymZdt18P+t4lKFTEeOJxOjJ8ZZ9XbLpIbLiBPQ=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 BL3PR10MB6211.namprd10.prod.outlook.com (2603:10b6:208:3bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 16:47:11 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 16:47:10 +0000
Message-ID: <eb33f1da-bba4-44e3-9585-a94d4dbbdf75@oracle.com>
Date: Mon, 5 Jan 2026 16:47:05 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf-next:master 8/9] FAILED: load BTF from .tmp_vmlinux1.BTF.1:
 No such file or directory
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
        kernel test robot
 <lkp@intel.com>, Dinh Nguyen <dinguyen@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Andrii Nakryiko <andrii@kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, dwarves <dwarves@vger.kernel.org>
References: <202512250932.X7mdviuH-lkp@intel.com>
 <5c9130f8-dd8a-41c4-8033-d5661f64c01a@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <5c9130f8-dd8a-41c4-8033-d5661f64c01a@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0381.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::33) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|BL3PR10MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1de1cb-5b25-403b-2e75-08de4c7a11f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sm9sQ0VId1VhREVjejhNWkRTWmFZNFdWNkhZTWJQRWxyVGFaaWpKZVNSak5a?=
 =?utf-8?B?RUFBTHQ3OGhyN2pnYzhUaEhKVm1BQ3hsTEFYc1d0N1ROWUkvemFIWFlnbklx?=
 =?utf-8?B?ZkE1V3lJZG4wVmdSYzhKWlB5bEcyd1d5ZVJrSStLK3F5cTN2M2plRTlnUTRL?=
 =?utf-8?B?RUo4Nk5mT1ZZZ1lKdUhmQzFrMlNsemJCT2dsUnBkeGJHNGtldzF4c21nZUxX?=
 =?utf-8?B?R1o4Q09ZRlpBS1Nta3RhRHdKdlRnSldKamdOcEN1aElrSklvU0o4VHQ1M1Rh?=
 =?utf-8?B?TFlQTDFnT2RXekJ6czREOStPQ1p2TVRMQmh0Z1JTOGJPUFo1RVZwM2pFdTd2?=
 =?utf-8?B?aHNab1EraUVoWmozRWd0ZUI5UkFXSi8yZE4vRS8ycUNIRVRQb2xBcmtmWlhv?=
 =?utf-8?B?QjNlYkNUUkVMRFcySjkvdTlpRzFLOHY0MUFkemFhQUFZZlV2aXdpM0FOV2dR?=
 =?utf-8?B?YXRIMWhLaGVOMjRlTDVRZDM0cFB1MHdFR3lZcnlWSkZUcVhZRjBQalVpSTdB?=
 =?utf-8?B?cTF1YzN6RDJ4V08wSVlJQmt4VlFPdS85VjZSTEYyZkVyUy9oVDM4UmZGUWxU?=
 =?utf-8?B?ajVMQUlTdm84YmdnMXM1bXdVbHVTdlJHNm1jVHM2cjFheU85QlJTQ3VtT09V?=
 =?utf-8?B?UEZrN0NnZSs5RTdidVpFRVhEMU9OcmJTRjJ1WXVGckt0OTVHMURrZXlCRjYz?=
 =?utf-8?B?MkZGTndsbTJqOHBGa0JjSE13ODBvZHlRL2tCekNCZ0I3R3piM1FPVlZIVUs1?=
 =?utf-8?B?bWcra2ltVUdUY3JnTEVidzJteTFVRHBWQ3N2WjFDTTRrV1BET2UwaTI4NEQr?=
 =?utf-8?B?aExxSFZHakJ5bktyTmhJVGNXTC9aOGtwRGt1OUljeHQ4ckErLzFVVmlVRktv?=
 =?utf-8?B?N0NtMDMwWFErOXhUdTNPQlpvZHgwRlZuakhIZ3E3NjJUTld1djlCOTdaN3hs?=
 =?utf-8?B?WVlZK0ZQaHdKZ1JKdFRIaHViU08yNHMvQS9mTzgxL3lQRm9vMUFrYm5QOGtz?=
 =?utf-8?B?TUwyajFEYS9kY1FjNmdqdEo1Q0NiQVhVaDVnOE9WblFUaFBsdWhYeVIzZHlU?=
 =?utf-8?B?Yk0rZ2dmQWsvb1RoT2lXVnd1QkRDaGp0bmNOVnl6T1ZpN0VWRXU5SDkvNEh2?=
 =?utf-8?B?RndsTmtKcUxzbWszQUU4S3JUemNFYXpZYmgzRGJsQXh4Y2o2MmpDMkgwYTRh?=
 =?utf-8?B?NWZQTVpLdWhpTzVzT1ZSb2ZBOGQ0dGJnZklyK2JFcWFIY1JuRS93RWlvZkgy?=
 =?utf-8?B?bEtkblA4dmVTenp5MFdTeTNORUJCVWVBWHdibzhrUVNRS0xBWlF0MFZjS0RN?=
 =?utf-8?B?REVJcktObkNUL3d3NnZYYVF1MTlEdFR3Z2FSWG8yY1RYL0g5T1pNam1Gb2R0?=
 =?utf-8?B?OEltS2VDUXFJZ24yemxNcjJJd1hQVWxNUXlTMUpodERtYU5Bc2JvUWlJVHBS?=
 =?utf-8?B?SUw3MmFlNDkzYjlERTNQTWJ5UEFIL0VtZDFKbEF3WXIzTXY1d0dEYU5QMW95?=
 =?utf-8?B?NjRra25GeHBmblM3bVB3SXpFdkdHS0xSRXpORlU3TVVpOFErL2crOW5pSDB0?=
 =?utf-8?B?bkNiZVJmTU9oZVRVZmRLV2t0Y2JxOTNROTZkRGxyTVFiMGVIU2ZKQmxDUmRm?=
 =?utf-8?B?dVFBSUtPcVkzS21INVhzZFp4amd3MUxEUVB4R3AvN2k5WXZoLzdyY21vN0tB?=
 =?utf-8?B?TWZiUkF5S3ZvZmFiUW1nbkRvcGc2WThQb0pCWGxINkRNT25qN0h5eEtFeTFQ?=
 =?utf-8?B?ZEs0RFVmRGZDSHd6VjQyWTEyZTlkNFl2bWEyQlpHOGVyUlVGbWN0T0l0Unh3?=
 =?utf-8?B?eW5rUUVndWFxZ2QrMm1uUUdDQXlWSEZ4MXljZ2Z3b1YzRlhKUWJwTHJ0Vm9p?=
 =?utf-8?B?K0tvUDlNL2hZS2ZNNS9vL3B6WGQ0VlZmV1ZJaytWdmtCOEcrd3hDYW8wcmpU?=
 =?utf-8?B?RXpMTFR0WWpoOVRHNHh4S0NPSTFpV2FwT1RPVTdvcFRva0ZZK3M4elZqM05E?=
 =?utf-8?B?dFhUbEFDT0d3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REtYWDFHclowTmxHaU1NV2dKTG9QYzVXN2FVUThNNVdtZE1hNTVSQTB5ZXhR?=
 =?utf-8?B?b0JmdHRTbzVMR0tBdzRjMEhxcE9KRVowREVmRmRmdm9WWjRZK2Fud0lPdkFG?=
 =?utf-8?B?SEM0UmIxTDNEWnJEWThpK3VaVlFqVVJnajMvcWJNZVN6Q2NML2N2SEJPVmRi?=
 =?utf-8?B?eDdLdHZGUjBFUXpveFhwTkk5VXBVNlBRcTZFRWdlQXNtaWp6cGxXYTJHWkpH?=
 =?utf-8?B?Z2NaS1N2MFJIUytrSW03MlJEaGc4a2hHa01Iemx0N1ozV2RJZFhXbzMrZ0Zv?=
 =?utf-8?B?bFdkT1M4UUhnMFpFT3lTclIrWWVYWXlmaFlxamtUci81UjVtUEYrKy9iR2tR?=
 =?utf-8?B?bkY4U3BHM3ZwKytzM3NNZlhNTUhzbm4xR3F3aWs4bVhuVDFpUktCMDJSU1c1?=
 =?utf-8?B?bnYyRjBVT0NKMEh0a1pSQXQ3ckZ0UElzTDhJcXljVjYxelBGTXlKdlp0a3RM?=
 =?utf-8?B?QnU3WnpZN3daWHRDQWZ0RGFsQWdQWEVPVmtIeXkvOFlWRzJxTUY3N0ZmRTdZ?=
 =?utf-8?B?TnNlSWNjWXlmY1Q0ZkZRRVRzVlhuU0lQVUJrMFRvNFhMODBpdEk0ejRtbVZr?=
 =?utf-8?B?cnZuMVhBS2p0UC9uRVZSSW1rYW1XaVhiS2hPd1FsL3NKWTRVbVRTaFJJbFd4?=
 =?utf-8?B?OFZ1amxJNXdPWHowYndEaEg0ei9ZYTdHNEIwWlFZNWt4VmZjVGRORzRlUlFO?=
 =?utf-8?B?L3pQQ1N4dU5NejFEY0Z5OHVzYkFqR2ZEa1FyV1NUZ0Fyc0Jlcjh3YTNqUDBQ?=
 =?utf-8?B?aGNralFneXRKWTcvdmRKZm85ZFgzcHEwQUhZM0oxL0l0Mm1ESDJxYjhOY2lp?=
 =?utf-8?B?eWN2UUdxRzl5N0hITGlWS2ZFbXpzaW1zR0c4MmFKbDJncGxhWENUR21kZUJQ?=
 =?utf-8?B?YTRQQ1R1SnV4cnFMUGhtZ1dPUlVCSlJYWTY0WkxETUs2ckNrcjY3RVpET2tX?=
 =?utf-8?B?MzNZeUVaQlR0TUpnUUNZblU4cm1YQ1A2UU85VkU3R0dBWDhvVEp3cWhkVmdr?=
 =?utf-8?B?a0JTb3R1Y3FLeUZsSlR6Z0hTU1NiSDBwNktOdG9UbWZOaC9nVDhqaE9sWGVm?=
 =?utf-8?B?MWgyZUl4dGxEbGZxeUZkNjFyWmU1b0pJR3ZOZ1hFR0JSTXFQZlB4NFRlK3BZ?=
 =?utf-8?B?V0FoMXBzbjBQaS9RWjJXNnJMVWJ1cVpRSndjbjMrVitXanlocm1aZTZRazI5?=
 =?utf-8?B?c1UwM0dueFJnZnk0MmUwUnAwQ25CeFo5cFZoSXFTMy9aamZPMG5qRUo0dUlt?=
 =?utf-8?B?OWhlVkZZdkdOMzY1T1VYY3Z6QW1OVisrYjNmSmt6RUdXbUgwQ3ZZVlYvT0lY?=
 =?utf-8?B?OXZjTU1QY2hpZXlkOHU1TVNnSWlmaVVib0tGTGd1NWNlZUp2RlhMU1MvY05Q?=
 =?utf-8?B?eFpVU01rdXB3VUZWN00yUVlraTRoakRxTGgxQ3BiT05KditOK2tYaWU3MCtN?=
 =?utf-8?B?VENYSGdQWEh4S3JYemFjUzBESWdHYzdxOUNKZFJVMWFYMGx6N24zVVdNWXRF?=
 =?utf-8?B?cEtzMHo5b2dad1orMktNZG5ONVRPaklqbzM3T1VmOWc5SE0rcTdPR2I0anBm?=
 =?utf-8?B?Wm1vMkFuT1hzTTh5aFlVeXU4eVZuQ2s0REM0N2dkVCs1eHRmYTRldkd2TzNt?=
 =?utf-8?B?azZDY1JkYXNFb1YrbCs1ZUkwaGZQWHdDUFdWdjFpUDJEU2ZmYVphbEsvMGRO?=
 =?utf-8?B?eTRWc1M1SDdqQ3Z6ME9DbGx1T1BFY2w3a2lkV0tmT3NVcTFsRWMwR2N1dEpu?=
 =?utf-8?B?UnBESVNMaUJHMndyeEM3U25ialZTV05wOEkxUjBNYTlHT1hBZzV3QkxTa01S?=
 =?utf-8?B?bW16UHlDck83cWV4aUR6Qnd4eWRrN3QxeTNTd0QrejNGNzBpNHZmeW5TMG8z?=
 =?utf-8?B?ajhLMzN2Rjh5RkQ4ZjVzbHhOdXZJSEJmSDZBQ0grK3lYTy82SHpIMkNMVG4v?=
 =?utf-8?B?ZHQvS2VLdjRGTW96djVQZWtFNVNweW0vT2poazcrWU9rT2lQSmY5ZDljclJ1?=
 =?utf-8?B?TFVlbkJiNmRxajZKelpwOCt3L1UwTncxVWdhaXpaOTk1dDBQcWQ4akdJY2I3?=
 =?utf-8?B?aUdLL2VRL1A3aUIwVjdRcyszdy9NcE5Hai9iNHZWYnNUYlk4V2RTTkM5K2ZP?=
 =?utf-8?B?OTBXOUNMaUw3UmRZTHdGejhPMUtpbXQ4MkptMmZ1ZCtnb0ZUWHFINnltQ0Ja?=
 =?utf-8?B?ZC9xNDFMMVNyaE1jZnZHYjhQdDNYcGQxR1NaMFJvTzM2VkFaWFl1YW9seXh0?=
 =?utf-8?B?WmdLOCtVaFZiUGFWL3lodGJqZmZQd2h1MzBGTWZtT2IrSzcyaVd3UWt5UEhE?=
 =?utf-8?B?MEYvL1M5Zzd3RmpJK05ld0NZVjVSREx1VDZlZWUrQmpxaWRQSnVPdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+GyotqubCXqxyaOPrOLQyBnvtNcLLP6y8Psu+QtmL0xCoESM6jG7QZn1H5fpUyIlTDN42l8T3ij5zy7szqXe8w77dI+erPcIejOafG14RQzCshPn7TAEP3MfDH/CD+3vwQAfkFH+WZ7nTIvD/XV/c+oh0ixrtTCKi+IEO/n0mThuSrW0W8o1cfEfEnFtvyFdOnOR14VGlVexkeTxDdWe8b65zcTfEyYXNEztx1w8MV7J4rCyI0rQkf/+jBI5/A519RbBH5Yp3nIqu4+L3cdIFQggsG2scUReCnqBbYb/xuceUWVPwWUYoO02RGSV7M9jgUhrnxv3G3qXUozliG3t29/jyZSq9AcRxVFmBERiss9t/SBDBDsTuicYgndFoTYTCGT3jnJXXl+XL+fPwW7B5u56+o5RzSWPD8lvsBxUVNimWqxMuL6eo9fq/ATj+2EmvW+7v5dfFhPt4RVNgabpwJzVMmcF3FQgqKinmzl/+gYtkilcaNzgJwsfG2GJIclpy5m7V+9M0dIfWSgcf0RyeEb29D7iFCzo9Y+g7JsHAreb8r5FkTsb2eHBaRBKB29ERvKUHZ2v3sPXEL4D7Yf0a65UFMSEt8g2kxRNhWt9RZI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1de1cb-5b25-403b-2e75-08de4c7a11f2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 16:47:10.7146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISdnsk8WyMzsCkoHW+Ru9vo3XozXYrq+qqraJF0dCHfV2uCEaTUh1n/F3oaAsWoziWKHxPlAkoAglig/AT+9XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601050146
X-Authority-Analysis: v=2.4 cv=Kt9AGGWN c=1 sm=1 tr=0 ts=695beb1e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=8VpDeP3kAAAA:8
 a=oaZ6UMzIbVQnWoPzKqEA:9 a=QEXdDO2ut3YA:10 a=mmqRlSCDY2ywfjPLJ4af:22
 a=x58pXJj3Pl9T3GLWE5Uy:22 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: 5vI2vNNS8NdsEMnM6ZP34Hm4rhXJkQk1
X-Proofpoint-GUID: 5vI2vNNS8NdsEMnM6ZP34Hm4rhXJkQk1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDE0NyBTYWx0ZWRfX6MuSxZFn7/pZ
 SO6PEurJul87WGYrAW42O9J2sDD7kr+AF6eocSQGhGcbilAPwcFKHqjsEX+C0kxvs4UVxinQyMQ
 7GSlyFjVTq4QAd3MBZLuYGqBrULszy6XUDJFtYmoY2ypF3iT9A5U8sSlINQTRc0UklgCuisLhMC
 Eiqjs3u2T99NwATK8KBt6polpZl8pSH3yavBZh2391qCD81PhFOPKZy2ncn2Bk25tVbAcyxnd+n
 91Balpq+6tWXn794Im73msKwhBNWWqnExVz1WoVffqQV0XLrb0jO+18ekR5GjdpW5Vayafz0+32
 6ji4aLnTtAqpiTPXm0opG9P/nKlXDA9bb6wdmf5YE7bmJx8ePHvL4SGxqrMGFEutz76glG0pqbi
 ibb/qAlyOwG5iGkMBpew//mIz39bOaH6OwKl5Nb/EcDSEF35+ABd396KvzoQf4YB563967z2b2n
 FxOnrqB+4r0x4krUkgEbu555C62SbsayYiweOiws=

On 29/12/2025 19:28, Ihor Solodrai wrote:
> On 12/24/25 5:01 PM, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
>> head:   f14cdb1367b947d373215e36cfe9c69768dbafc9
>> commit: 522397d05e7d4a7c30b91841492360336b24f833 [8/9] resolve_btfids: Change in-place update with raw binary output
>> config: nios2-randconfig-001-20251224 (https://download.01.org/0day-ci/archive/20251225/202512250932.X7mdviuH-lkp@intel.com/config)
>> compiler: nios2-linux-gcc (GCC) 11.5.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251225/202512250932.X7mdviuH-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202512250932.X7mdviuH-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>    Complex, interval and imaginary float types are not supported
>>    Error while encoding BTF.
> 
> Hi Dinh, Alan,
> 
> Not sure why this has surfaced only now, but it appears that kernel
> build with ARCH=nios2 and CONFIG_DEBUG_INFO_BTF=y has been broken for
> a long time.
> 
> I tried the following revisions:
>   - bpf-next @ 522397d05e7d as in bug report
>   - bpf-next @ 014e1cdb5fad without the gen-btf.sh patch
>   - v6.18
>   - v6.17
>   - v6.12 (~1y ago)
> 
> All fail with the same error in pahole [1]:
> 
> 	Complex, interval and imaginary float types are not supported
> 	Encountered error while encoding BTF.
> 
> I used v1.24 in most experiments, the default debian:bookworm
> installation.  Upgrading pahole to v1.31 doesn't change this behavior.
> 
> I also stumbled on a phoronix article [2], saying Nios II support has
> ended with GCC 15. Is it actively supported in Linux?
> 
> Not clear to me if anything needs to be fixed here. I'd appreciate any input.
> 
> Thanks.

hi Ihor, it's probably worth separating the issue of complex/interval/imaginary
support from nios2 support. In terms of the latter, if the breakage is old I agree
that it is at least a lower priority. Did you figure out where the problematic
type comes from? Might be a workaround we could apply there.

It also does raise a valid issue about supporting a larger menu of floating-point
types supported by GNU C/C++. To do so it looks like we'd need 2 bits 
to support the range of possibilities 

- standard floating point
- complex floating point
- interval floating point
- imaginary floating point

Is there interest in supporting these? Thanks!

Alan
 
> 
> [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/btf_encoder.c?h=v1.31#n469
> [2] https://www.phoronix.com/news/GCC-15-Drops-Altera-Nios-II
> 
> 
>>>> FAILED: load BTF from .tmp_vmlinux1.BTF.1: No such file or directory
>>
> 
> 


