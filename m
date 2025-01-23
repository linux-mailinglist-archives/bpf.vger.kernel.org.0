Return-Path: <bpf+bounces-49596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141FAA1A9C3
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 19:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465A2163A76
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 18:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFE115625A;
	Thu, 23 Jan 2025 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="thnmdn40"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D0B19066D;
	Thu, 23 Jan 2025 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737657912; cv=fail; b=KLN3Vce0ZLzkkw8SOr6+4BYBXWFJxcekO8AG7SDa0ILMN2AEVmmzAyYc/4dhLpBFTUtTjZ85j18JcVHahlWS2zCz7OpM6OvMXiZjB3C6t8y+auhFUbx5x+hBOrJUipdGVdRDUy/HPV8L2znFskZ36PEPsKBPODAByoUkPEnBc8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737657912; c=relaxed/simple;
	bh=sdQ5HQVdrmRUTwfIYGRqR80HY7PV+0KdPpjYPQzZGDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uUFUTfykY/QdAgROD9OT8eCR7lKEfjZlj/+o3BqNuGGryYcKyDR7DhSRFsqj1GMY6QABI0YiWtl701p1m/Oa5vp4qNqH/dpmZpsmvZKAREFTv4nkl1jlU+pOwxGed9k2JXqKOE4WKHwxBhlib0OrbuujGZ16fDFMNaQcI/LtYhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=thnmdn40; arc=fail smtp.client-ip=40.107.101.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDKSZGVJaVjxXlXt7Y+b9XtVKOy1K/ORX8tdE8Hnq5FP3mnxlcVKyFabeg/4UERWFJqhLgytyXRGmKLDkkgjlXIQitFtJ/CIgWNjCLAaxaC5IXMq1D7QHtfLuwI2PmACDoMr7t2uQipUIJ6zWP4mzBmptvokueK/nj0EiQtwnbCwxLqTdQ+EOsKO3BmeQOMuE0FcgU1bVwDp1lcaACB+wz/eHlnADb5mp6m+CuHYow6zFhtMBZVBAPThQj4RO6lst+MTqDTa46iUSC3RBGcZsEZdHaO6FFR/Fjw6FuWSsSfQ+Tp9Wz3TS4dEqHw0JUYMxA4lcBYVDsq0hAjf4ffo/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5zz3TbWlC/I9eH5EUBfyP1KRZB/A1sBEfoq5xB3JYc=;
 b=WcA3kHPRSjOb1AxjIv7ZOSF1Ub68EZm8eXaFqjC4g9xWrTjOnXeo1hY1cZCA7uaVOpOHf5BXujjhNZ4dBwIdetiu5yDlTfTAhPTCuX0Z2tS4gyih+gy7aAe3yVXDRfFJ4NoIFtcic9Q2FSrN6G1X2JXdGUzx5Zg5kCIvR7IbF2GZSDUq6jSsG+J8G4tOHZrobHmetbWyfajcMylgvmK+uRWbX7he/pBnE8JX2pCVTkPlsQ/+DUsBoe5VBZxdNDwr2F5gS8YPcCLUDq0iPkfXTHe4Vu0Y/EppQZHLOl8S95d6jk7u6nJ2SJXKS2hFRD/cB/N6CN6fOeJldqFoTXia2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5zz3TbWlC/I9eH5EUBfyP1KRZB/A1sBEfoq5xB3JYc=;
 b=thnmdn40XYhuRuu8Pukct4tlESOAk3i127B21mhTARtNRQj/nhY6N/LgTXZOCZFfsrI+CWME7o4BS4EQXQT7GmtIgholijcWWTJCNT2CoQ7qdsPCzFW4SydabNN7WAcfxqonuzSoeWoO3Zdda9EuVdzERfBOP/tOeMvbd29E3rfZgODrCUQmNRMrgc06iOU+WDHJqTeaovVZggGs2ARw5H3PYD9oZu7btBVS49aUtmwYg/5/t2kL68FR4udMkeRD64WMF4urciuz43dGbEb2KyU1DfJNK8TcyuRaCpR5w9YU9JH+r/ppBe66IaVuol+ukQxXW+2edaO7f+bqqMh9xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 18:45:08 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 18:45:08 +0000
Date: Thu, 23 Jan 2025 19:45:02 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, sched-ext@meta.com,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH sched_ext/for-6.13-fixes] sched_ext: Fix dsq_local_on
 selftest
Message-ID: <Z5KOLqwLq96HjkwH@gpd3>
References: <SJEarr1ol1z7N83mqHJjBmpXcXgHNnnuORHfziWINcHBQCJzY0RczexPKxdq_vE5cDYPeO3bx1RdsNhLqw5UYI40HSX9cPZ9rdmebYwwAP8=@pm.me>
 <HdoCQccNk3GZdnPx5w1vuAfOMMgtWeUgrUhn_e8B-hyRrWoOPakTGcoI3Q4-QmK_44msuvivoRUykxxeB82uR-S3enkmFaQl2t6Zgu-Nq6Y=@pm.me>
 <Z2MV001RfiG7DNqj@slm.duckdns.org>
 <ouIylyHgXTVZ9RiyVeHZ26YXQLKMEKHoOVPWIgpWRDD2FL2RDwwUEocaj4LMpMR3PjbwpPuxEnJAjMeD4e7LnWIAYvIbGC5BPvPGtzyumYk=@pm.me>
 <Z2tNK2oFDX1OPp8C@slm.duckdns.org>
 <QHB1r-3fBPQIaDS8iz26J-zoMbn3O6VLlwlZP1NQdkMzlQTsCX_xrfTPBoGt6SQOGgtg6vN7aXles4CndepTvjIVQ7bVXDBrvPaiRH5R8tc=@pm.me>
 <Z5BMkyJ8I7cth1GH@slm.duckdns.org>
 <m94EAn-xiPWJ1dRFTqcm6urBNNOPza94BmyYvp_5ti06uAZF0Izg2mBC9rpbc3PEfWWvDf7UyDt1x_2gB-7y3esTH3f54s05QBxcTXh4YhQ=@pm.me>
 <Z5IOpOD9cs2fLaIg@gpd3>
 <Z5J1Ft2YwSRpedzx@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5J1Ft2YwSRpedzx@slm.duckdns.org>
X-ClientProxiedBy: MI1P293CA0002.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::9)
 To CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f6630ae-478a-44e3-cac0-08dd3bde0f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDZ3YWJsV1JQWVhPeHpsRmM2a0dGUFpuUnZtM1l1aDNlMXFBUEk0SUl2aUcw?=
 =?utf-8?B?N01VWTBUbTlVWUFWbURnMW9NdVhwM2Nna0RQMm5jYm9zSWVmcDVJRUJEVFkv?=
 =?utf-8?B?S2dDQVNQZXRacVhsdFlzOGVmanJVSVIvNEtncTBXRzVMSUVRakpiME55dEZp?=
 =?utf-8?B?MW9BdnJ0M01jbDRGeHBYSFg4RndYOEowVjU1alI3Yll3V1FqRnJBUWpoN2U5?=
 =?utf-8?B?elhNR3JtY1pmNlJTYkZGL0t3clRuTS9jeGF3UlZqVjRKS1RvbjVxWk01R1Ex?=
 =?utf-8?B?TW5OVHYvYWxUMkRZaDcrL01va3NEZnluMjdaeC90K3RnQ090dXBHVlNRUlRY?=
 =?utf-8?B?UERGNUFPV1VHOUhUcktWV0JxeTV3NEloOU5aZFRQUEVHa3RCWGNnelBwVjdN?=
 =?utf-8?B?NXhIWW94KzFER3E4VEh6V3dTeFhWMXRKRW91b3d3SDgrSlQ0cUxseEVXZURH?=
 =?utf-8?B?UGdCTWJlRFFKSVhGNGxnWDdTS2dScXBRQnNaMTZKR3F3algwemRyU1Z5dEZz?=
 =?utf-8?B?ajlnVC9ScWR0WDdUVE5TcU5Qc0FWQUpUcEZJQ3JYWDdDcW5PZThwNGFwV1lq?=
 =?utf-8?B?R3BGZGtjWEZzRlpkS2FTL2xtVDgweERtaDI1dzFmb0pURWFRL2hXcExab2R0?=
 =?utf-8?B?ZXNyaCtqdkVBNGNKVjZ5UWx1enpjbm53cTZWUW9DQUI2WHhkUWRnbjhTSTBP?=
 =?utf-8?B?OEtianVLUDFpaHFDOWFPY1d5VVE1RkJIaDE2emdSbEhOM1lzZ3RGZ0Q0OFhB?=
 =?utf-8?B?YmQrK3BQV0MzcHZOeSsyWXhFVUZCUGo2TjdZbDNFaTJSUnA4WHBWWkxLNk9G?=
 =?utf-8?B?ZGowU1FzaXZUazNlUWFpaGVFY0lnRGFpY3NTU3NrQmgrcUljTHZZV2o0RDhH?=
 =?utf-8?B?b2ZNYUhVTFhPVGUzb0VmWlJBblB3VHNOaWo0dFI3NjVWa29mUzZPdnVrUlRN?=
 =?utf-8?B?RlJwMGo1YTJ2dTdLNEVPVG5rcWx5enl1S0ZjYy9PbDRPZUZXOUUwMnNIUnpD?=
 =?utf-8?B?aWxWd2dJSW0zNElUSStWVFBhVlgrckhZRHdUbDUzOHlQR3lVZy9OU0pJOWh5?=
 =?utf-8?B?NkkyZjZKVFYyRG0rd1Q0eHFuZGN3S2lJR2x1ZUJRNFJVMGp1b1VzcTRoR0lk?=
 =?utf-8?B?TmlZbktTTG1jTmVMaURFMWMxaE9OLzI5aFFXaU12WGNVN3FiYnJGQ1d2ZTlK?=
 =?utf-8?B?RG9xWW0rdnhFWjB0bzVTby92ZEw4ZGg4R2NQWnRnM2R3L3ZLcnVmUVVZNXU3?=
 =?utf-8?B?TEdCMWpiaDBlWVEvR282anNiRXRoWUxSTHVFL2ZPRXRlOUJMYW15RXo1Q2tZ?=
 =?utf-8?B?b0dXY1A2WWhKRUJ6c25WdVZUVVhCZlRIdEJJV0dES3hTWVBESlp1emRhb1Rs?=
 =?utf-8?B?R04xcnViS0hKR1FlVjUzRXBMTEVhNXhOZmJFcEc0YXdRZ25ZSlc2dGlXeTdO?=
 =?utf-8?B?cU9YdXB2RDI3d0J0RUc5WWY1cU1CZlhHaE9NQUhDbVQ0K0tQbDB0a25Xc0RU?=
 =?utf-8?B?T0JkUWpqRDRpSkV1NmU2Rm5UQWRYNXVOdm5pOFc4b25pTkVRSFMvUU9DeEN5?=
 =?utf-8?B?ZTlHV1E3cHdWMnozUk1ycnNTY242T1l4YVByNm1oWSsrc2IwUjBRNDMwSEMx?=
 =?utf-8?B?WmY0V2p5UGtZSTVFd04wdXppbCs5d2IvWjFHam9Bb3RqWVB5QkpVRGk2RzlI?=
 =?utf-8?B?cy9Tb2tmU1VWWjBzUERYSjlTOHR5MmlTRXlXREdXV3NDeVBReEs3RUVwU2Vk?=
 =?utf-8?B?N0ozcFI5cmJRcVNiaUJwMjF6aE9ncGVrWjR2WFJQbTQ5TC81TVI2aGpaN29X?=
 =?utf-8?B?R1RJSERUUFJuVmZOVjdOcTYxY0pVaEs3TG9teEdUMU5HNnR0YS9HM3NaRm8x?=
 =?utf-8?Q?vlcvUG004U58F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUp6Mi83QmVpbXRiMlZVa2k2QU1aUXdxc3hrTjlHL3pmallycDhHaVEwNmxH?=
 =?utf-8?B?SDdteVZGY0c3QWxLNllHWU90SXBtL1JPM0g4ZnE3Z2ZDK01EZzlUZ2pHOUIw?=
 =?utf-8?B?K3ZKMFJGQUE1UHZaOWdEYkxYYnJjM0lXQ3ZyQnRWOExLS1psV0NLSE4zQ0Vv?=
 =?utf-8?B?MGVqZzBzcE1DRDFqaGh3cXFkdzRBN2tmOWR6SkVDK2pNOU1yeTFFZTdWTWs3?=
 =?utf-8?B?bEI0My9VR20vQ0RwU2ZDV0RpQUNTa2l3QkhBdTdWUEZnd2taWDJBVFV0Nlo2?=
 =?utf-8?B?M0I5Z3haRG1OZEt1NzdLNFVOQmFQSG1QSDhGdjdoQ0xaeFlya3BBaVFkVHFy?=
 =?utf-8?B?N0lWNHRZc3pBRXBMZm9udmpMbFNZNnZVLzVkWWRoNWR3aWpyVldRamkxYzdK?=
 =?utf-8?B?S2lvSUxpaVNReVBnY2xmMFB6UXZCS1F4RzE5WWxZQ3hPays3SnZZOExOR3lB?=
 =?utf-8?B?eEpSYVg1WGNJQ0hJRlFyNTY5ZTFUOW5ieHJ6Z2VsYVpJZ1hRUG0valN0MFJC?=
 =?utf-8?B?QloyejRYS3BwMjd5NDJJTk9ySS9OTmMyOTdoM2gweEtoTXd6RU5IVzZDeU5B?=
 =?utf-8?B?YVdsWHBtSncyMzVLcVJsQUdjSzJGZGd1cmZVWDBLNmxCQ3ZRaTJqZmwzWmMx?=
 =?utf-8?B?M0lGS2VNSnpQSExBbFNSZFNUaGE1K0dwRXFDR21JWGtVd2h4TkFabktHOGVJ?=
 =?utf-8?B?cSs4Q0szeGN3MGs0TEZYNjVtYWZoVWw5R0s0bWVzL2RmR0hQTHZGUE5EWkp0?=
 =?utf-8?B?cVlyTjdQdVV1Y3lWZzViTFV3ZS9tNU9HSWNkYlVEMTZ4SHRLMlRmZW50OCtq?=
 =?utf-8?B?N2oxeEdSZ2s5VGt3empjL25VV040YWRPRCtHUHZSZE9yci90aUZMdDRTQ1g0?=
 =?utf-8?B?RTN5ZzY5aUlTaytSOVM1d085bFVoZVFBaTJsZCtUZG1VbzN0Y0hpdmp2QjNr?=
 =?utf-8?B?L0FzeTNYdjJ5aWhWdW8rWS8zbW5kbEhDRGpOUkc2UFJPWWVzR3dWYUJMeis1?=
 =?utf-8?B?WFhtbDhodDhoVjRnMEdmQ0xxWkFkVzRaaVZRNWlJYStVSnVxR0ZYLzBMM1pL?=
 =?utf-8?B?RUNPRWllQUI0ckg4ckpxV0dDSlZTSytyUUk2QUkvOXZldWZzZ1RlYTFTbHhO?=
 =?utf-8?B?NFAvRStPRzBCUndnOTlnWEF1a3E4SkpoQVNHNXBibVUxRUtpckxLaEI5OXdB?=
 =?utf-8?B?N0lsdVpxbDZYN09IcWdVUDhvSmV0Y002elY2dVFRb2dOOVpTSHE1bDFieWVr?=
 =?utf-8?B?VHJuS1A4Tm4rdWx2VzdkWGl0WHc5Z0ZwYmJDRGdOTHlmZXJValBSeWNHRE4v?=
 =?utf-8?B?WUxDb0JWV3p0OTQzamcyQjZ1Y1FaMUcxdTN5U2k2RUwzcktlNUtsR2NsZWdx?=
 =?utf-8?B?OW5veTR4OXJMeEMvUWJveWZTS0FhbmVDWjhzSjBiTXhvSU5NMTJhZUYwaFFI?=
 =?utf-8?B?b0ZLN0Y2MjY3TjJ4RmVmVE5ISldIeTVsSGMrbTZ2bW4wQXFsTnVuU25pNGtC?=
 =?utf-8?B?S0ltSHZvS3FxQ3RWU1c3SDBFWEdoUXlyK2pNcDZSOEVvNUlHYlk0Rjhuenlo?=
 =?utf-8?B?UEdUQ3hnUXBNMmNkOUtiNG9HcGU4YUhXODJ3d1BWZnEwUjhqODlCaURLeXJz?=
 =?utf-8?B?V01MVXp1czFnSUhleTltakw5bjhGSVRQeTRIZ1FWVUlhMDIzM2JJMzVnM05X?=
 =?utf-8?B?akFaNWxQbWtKQk9hUkxrTWQ5Wm1DUlFMRGxkV3Z3WFI4TmgzSnBpVnFBeHJt?=
 =?utf-8?B?WXByc1JQa2NKTzgwQWFJR0x3bzNTUi9LSlJVUEdaNGhsR25DWldmazRjMDFm?=
 =?utf-8?B?UGRiTXBxSzNWVzA3b1lrQVdheG9tYUxOSFdMT0s5ZlFFdStXbWg5MGhNaTh5?=
 =?utf-8?B?anlJV3pqTllWT1E4d1pWUDBxbVRIUjZoUVc4R0ZURzBjTEdhekw1MnhOM1R3?=
 =?utf-8?B?R1FmcVBVRnFGM2tlaWNRS3VodVAwV0MvQmxoaFVlMkFLZDAzNDdOWkFOYy80?=
 =?utf-8?B?OGFaejB4RHZPdVZ6ZUxET1VnbFlZU1UvcUd5b0xuU0kzTEh2UERibU9pd2dW?=
 =?utf-8?B?UlMzVitBblZHc0puVXFsNlVUK3k3ME9oakk4SFdPUjZydWtOOS82N2ZDUHdh?=
 =?utf-8?Q?NFy2kBAzotio+EiaEqux3cTU/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6630ae-478a-44e3-cac0-08dd3bde0f42
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 18:45:08.2387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZUOraik/Nz0tsUEt0ckE7z1AZvT0kDyfFLWgBxk6gDBxWOykVCwP+QemLWfCSA+wchEXRCakbEgV0/vRFFMAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086

On Thu, Jan 23, 2025 at 06:57:58AM -1000, Tejun Heo wrote:
> On Thu, Jan 23, 2025 at 10:40:52AM +0100, Andrea Righi wrote:
> > On Wed, Jan 22, 2025 at 07:10:00PM +0000, Ihor Solodrai wrote:
> > > 
> > > On Tuesday, January 21st, 2025 at 5:40 PM, Tejun Heo <tj@kernel.org> wrote:
> > > 
> > > > 
> > > > 
> > > > Hello, sorry about the delay.
> > > > 
> > > > On Wed, Jan 15, 2025 at 11:50:37PM +0000, Ihor Solodrai wrote:
> > > > ...
> > > > 
> > > > > 2025-01-15T23:28:55.8238375Z [ 5.334631] sched_ext: BPF scheduler "dsp_local_on" disabled (runtime error)
> > > > > 2025-01-15T23:28:55.8243034Z [ 5.335420] sched_ext: dsp_local_on: SCX_DSQ_LOCAL[_ON] verdict target cpu 1 not allowed for kworker/u8:1[33]
> > > > 
> > > > 
> > > > That's a head scratcher. It's a single node 2 cpu instance and all unbound
> > > > kworkers should be allowed on all CPUs. I'll update the test to test the
> > > > actual cpumask but can you see whether this failure is consistent or flaky?
> > > 
> > > I re-ran all the jobs, and all sched_ext jobs have failed (3/3).
> > > Previous time only 1 of 3 runs failed.
> > > 
> > > https://github.com/kernel-patches/vmtest/actions/runs/12798804552/job/36016405680
> > 
> > Oh I see what happens, SCX_DSQ_LOCAL_ON is (incorrectly) resolved to 0.
> > 
> > More exactly, none of the enum values are being resolved correctly, likely
> > due to the CO:RE enum refactoring. There’s probably something broken in
> > tools/testing/selftests/sched_ext/Makefile, I’ll take a look.
> 
> Yeah, we need to add SCX_ENUM_INIT() to each test. Will do that once the
> pending pull request is merged. The original report is a separate issue tho.
> I'm still a bit baffled by it.

For the enum part: https://lore.kernel.org/all/20250123124606.242115-1-arighi@nvidia.com/

And yeah, I missed that the original bug report was about the unbound
kworker not allowed to be dispatched on cpu 1. Weird... I'm wondering if we
need to do the cpumask_cnt / scx_bpf_dsq_cancel() game, like we did with
scx_rustland to handle concurrent affinity changes, but in this case the
kworker shouldn't have its affinity changed...

-Andrea

