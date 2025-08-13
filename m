Return-Path: <bpf+bounces-65493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9674BB241DD
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 08:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040B316536E
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 06:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E212D3237;
	Wed, 13 Aug 2025 06:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="J3A5Pumv"
X-Original-To: bpf@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013027.outbound.protection.outlook.com [40.107.44.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254D88462;
	Wed, 13 Aug 2025 06:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755067776; cv=fail; b=CP2yK3qtzcFHGDw9KDb5Xyg9T1YKyIXEh1nFvauOd5u0xemUIBMAdbI/4OZftnTO8buWZqw7178noBr37USHVZuNlK7rSO/uuBXD1ivUYwOOXAVgEOBD7U67nGnQHokBUPRgdEqTkbmexde5mi8fc7uDqkTMJlNjUC4l4rHNGVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755067776; c=relaxed/simple;
	bh=H3MJ7apaBhoYi4kWuVh2G8qckyOa/bX01FUUiR2Fluw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ih+xs9uaH/cZ8zvc4ybjIISlgyuTtl/iL5sTf5TnwVqmnfY8udTBtCvxis1lOcshY2pJMHnIWs9Rad+FxyG4vo8LMf9q+IaacJpsORr9yL9FBE6QMhRSvlZCn8q4+wf1A7lE4O1BOctuQFeowyAd+qWsdNvMDhI9PNMHnIKYVdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=J3A5Pumv; arc=fail smtp.client-ip=40.107.44.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ot/re4OS5mn6N3blz/T/mQWQpfVGshWfBxTFlhOy4d1LSPBEcEzxreUuVegsCYURQ17Kz5mG+eZs56+0Y4fMJOtlBGuD8bhMlBjaSpL3m1ouOqTz4UJCEF3IsIjHMUj6bEF/UkynpgbjQIX/SpdeScH/sbPO9A+M5YP8ecFAaKaxMfj43+vCDph2X/tL26ApJUVVBIeyJ3mXeHiGUFrUO6eccnqREor9uiaRgZq59FhFkn2RnSAjmeQdZK4LTzfblc3MSMSe6foz2qk2gc6p+XecWszU/tOIVaDID1SHaVW0WRj8cmqTmRrFeuyUvGoJMRdcpS8l9ZOcwSwj36aeQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3MJ7apaBhoYi4kWuVh2G8qckyOa/bX01FUUiR2Fluw=;
 b=gT2/Optm1ufC6tBt2uR6qx0kWzrz+KZDi+ubqUEz3NBKIrUga+wW0QMpCoAcITPysRugvbNJ5EYTqJ3GqJ6rAm4+eyl+IJK2Y/S+6d4L/TmDFXgksgV5AmhAbpxQ+7gwHeJsGuZw+iN0B6u2L2J52V7S+oFUsggQHF2TRU60Nnhuny8Dtfxzq83pW2C9LFbueOwzpiQMi2FnwU2bCeJVLtZObOXzq6rubU51ukPqbjVRBAnGc0PVlj2V7rXorPamKlY6SSZdy2hxvlMhdTJbPS8xMCkLC+9pXRu9jP//i24amC7lv6Vu78HNaN6z3Scl3ORsG162Z/V20rjk2oTHWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3MJ7apaBhoYi4kWuVh2G8qckyOa/bX01FUUiR2Fluw=;
 b=J3A5PumvzThSlDkfYEnDnnijxem87pUKn5hqCWRxBWrcdcT/8it9uqSeH7RnP4ottam9MpT6X9BsEioUrw5v6jLQ5VGh5NmDlWhE9dCBuoYACP1QEaFbmhBYpKcGJvJRdnfRo+EELM37amPYGgUoZS4YU9CPXR5Tuw5bYhOOK3JBlZW2byI0MEKugayVYtqYiTL2T3LYv/AdyCag/8i1e487eTBOpDv22+daXZnLMWy2EC28aNdOn8TjGHvj/ZYU31VNQZQZGYmnlAdLFRzs2LsvFoUByFxoqlyIsQqohfbMo7V9R7feSI27Cpad8VmwoLQIJBahOJlnJS6wSyLhLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYUPR06MB6080.apcprd06.prod.outlook.com (2603:1096:400:344::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Wed, 13 Aug 2025 06:49:29 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.018; Wed, 13 Aug 2025
 06:49:29 +0000
Message-ID: <98c6c93e-e370-4fd9-b47e-19ba4182e5cf@vivo.com>
Date: Wed, 13 Aug 2025 14:49:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] net: use vmalloc_array() to simplify code
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jiri Slaby <jirislaby@kernel.org>, Nick Kossifidis <mickflemm@gmail.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Brian Norris
 <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Johannes Berg
 <johannes.berg@intel.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Kalle Valo <kvalo@kernel.org>, Aditya Kumar Singh <quic_adisi@quicinc.com>,
 Roopni Devanathan <quic_rdevanat@quicinc.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>,
 "open list:ATHEROS ATH5K WIRELESS DRIVER" <linux-wireless@vger.kernel.org>,
 "open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)"
 <bpf@vger.kernel.org>
References: <20250812133226.258318-1-rongqianfeng@vivo.com>
 <20250812134812.298c7d97@kernel.org>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250812134812.298c7d97@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0187.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::12) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYUPR06MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: e505c040-1f3b-4ca8-60ff-08ddda358d2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qm5MeUJ6ZEhaTjJVZnRrWC8rZSsvTFpIMitXZG4xWTdWdkpBeWZneXhDZWpm?=
 =?utf-8?B?cHoxMmg1ancyNXRlNmlZM0tLcEd1RVlKVTQ0c0JUUjhjSTJHNkxmcU12czkr?=
 =?utf-8?B?WXhPaE9mVHhBNGZzYUgzcmZZczAvSkdnTytqSnpyUWRXeVpZVENtRXJhTUpX?=
 =?utf-8?B?b0lqaW5oWU1YY05zWGovakd2cVY1NWVZd0NyaS9GRUcvdUhqVzFxYWlsVVlN?=
 =?utf-8?B?ZFl1NzJMN0UwaDN0czlUYXBnZ296TTJmM2J4MXVSZ1ZicnJ3RXlNY3ZEU3Rt?=
 =?utf-8?B?Nk9tSnQwMU5TcGdkai9sdjMwUHhzN1ViUVZkaVlEbnkyTTBHbm1FQVFVdFRv?=
 =?utf-8?B?dzJHcW5nWHhyZXdWVEhPS2gxZ3hET3ZORkV5Q0FNOFdtVk9yeWFuOFJ5QmpP?=
 =?utf-8?B?RTJ6Z2JWbGtwRklIbitvY0ZSMzNIT3pvQ0U3UEZDOElqNlVkQXkra1RyYkwz?=
 =?utf-8?B?NHBIOU9tRmhjRlFPZ3pnb2paMm5UMHZ0L1VDb0tuQXZ5d1NSZi9NR3BEOXNM?=
 =?utf-8?B?R0tDU1RMamljV3hrb1RXRGM1TEFjQk5VekpDTGhlNG1qc2pQQXhaa0RwNDI2?=
 =?utf-8?B?c3o1SHVzekhYYThXckw5czhvdm5HU05iTWg0Q29kOStBcDV2dkpQOEVNNlph?=
 =?utf-8?B?SVFlUjMxeksydURyT1pOUXFEcE1HMXFITVhNZ3RTNmhYaGt6YXJ2R3M5ZzZu?=
 =?utf-8?B?c2lkM3FwUlRMOVpJd0w4TlZYSHRmNWZnajVSZHQ1TmduZXdUaWl6SW5qNmNt?=
 =?utf-8?B?ak1qUWgrUkJZNG1PVFFHT2ZjeW5XRnFiSGFnLzJza1NSVTNOekpRSnVlTkJ2?=
 =?utf-8?B?dnVZbHBjUjduamdUOGY2TWo5Vjg3a0xHT1k0MXRHM2Myc25MNGVBVWZ0SU9S?=
 =?utf-8?B?MlEybXpUYkpIaStWa0NBcVdJc1ZzWXFVa0F5L29kVER3c2l5WitjWkNqcE9Z?=
 =?utf-8?B?bWlKNHNaZ1JUVGJiZitad2ErVng0bGZpZlBNeld2aFR5dEVvVWY1OWkwbGRz?=
 =?utf-8?B?K3ZHcGFsajJKemtkY1k3RFhDZjNXa3Fmand2OHFJYmVwZnlDS0F0UURqSTBZ?=
 =?utf-8?B?OVpSSXRHRVphNTljZzZQdVJmMDRZZnh6b1pWK1U1ajdPVDYyclN2VVZxZXZX?=
 =?utf-8?B?UC9rU0pmaXRwRHB0aEt3Wlo3UDBROU90RWg0U1hPWCthOGtwZE9ZS3hPakk5?=
 =?utf-8?B?a0NzV3hTcVgwU1NIRjlTR096UjVIYytmcUQwTllCMmxDTk9KRC9xYU13MHAx?=
 =?utf-8?B?dStPNXFFd1ErZDFYWk1BN0FkZzUwYWZpa3Bwb3MvME9uVkcvMHc1eGdWZEI3?=
 =?utf-8?B?cVBvR0p0ZlNEMDFVSld1Wm1EMUt1b2llcFJtNFpiOVV4bDZ2VDY5U3JBalF3?=
 =?utf-8?B?dVp2WDhKalNMUjBQOEpDT1NnM0RJWW5hVFBONUZVRXQ5RWx4MXB6N1FsbEpa?=
 =?utf-8?B?MlhNOWFsQkh3OHR6NmQ0TW95OGJEVFA1ZFczRWx1NFdPb0hBV3o5UVRuQ2oz?=
 =?utf-8?B?Q1E0QWE1ZXJPaC9XSG5RL2tHRHpVM0JuT3UxR29TdFo4S1ZleEZRUUY5VENF?=
 =?utf-8?B?YVUrRVJQZU9idU5wNGFEb2NTSXNkVmcvRGtTNjBNU2JLcTBqOXRRa2hNNEEx?=
 =?utf-8?B?R1lBc1cyOXFZMkdFcDJmSzdMdVVnYXZYanhocnRxMy81SmZFUFZIYmU1SWJM?=
 =?utf-8?B?VkVldncraGptT3U2Z3ZWS1ZZc3V4dkNNYWFZMFN5b0dvMVRxQnNxc1htSjlm?=
 =?utf-8?B?Q1V4REorU1JZZm0zUDV3ckVRSTBHMHB4d1NqdW4xQmpYck9FY01sZ2lST085?=
 =?utf-8?B?VXByZXQzdGtTZHh6M1ZFTm5kRHlBZGZ1cU5UaCtjZ01NUmRzajkzOGNyQnQ3?=
 =?utf-8?B?b1NLQmh6eEtaWnF0eDR0WDQwY2c0WDZyNFBVUy9zUXZXVHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjkxNWhJTVdjNldITUZKdmJZMXpMSit2QWdSTEpLREVtVllDMHRKSjZnTExC?=
 =?utf-8?B?OVBmNE81NW51R3hyWTRNQm1TNmlDQVA2UnorOS8xSEsrRzFjdWJPN2FQL1A0?=
 =?utf-8?B?SVZmc2lwOFBZTlhEdm1CTkhNSk10akdneXo1Q0FWWDdRdE5VWHliTEVXNW1K?=
 =?utf-8?B?MWNVTXloSkVGekRGblV5OVhTOWlubnVaL1NRK1pUbGxiK2R5REhpV3NsUFZ1?=
 =?utf-8?B?WW5Na3Z1OGxONnlUaDBkMG5tVUllSTNaVFkzTjZjNGZUb29uNlZDSitPaEhx?=
 =?utf-8?B?L01oeUNGZURZWjhMMW1VUUpaYjhFMlM5RXZuTUoyaEQ3eXhpNmRoMkorVWpI?=
 =?utf-8?B?R29rR0JjK2F1UGRtOE82SVl6eTlrU2lnRzYwK2dRTUF4ekNoWnJpS3lQWkNu?=
 =?utf-8?B?WWRWYzhDb1o1ZHNtZ0cwUldBc0d0R1VVdGl3dmp2V1FFWUVpRmlveTlrbXM5?=
 =?utf-8?B?dlh2akNWUUdIeDhRRythK2t1Rk16aVo4Z21TaE9QM0JqYkJLSC9JazhLenlu?=
 =?utf-8?B?OEI0aUFrUGsyemdYQlp3Ti9LWWp2bkw2Q1VWOWRGMTllQk93VXdmWWhmQ0lX?=
 =?utf-8?B?UVhPZUpIWGhaSGlsVVVid1FKVGxoampQeVZOc2RuZXJsN0NGVXkvVlVta0kw?=
 =?utf-8?B?N2JtV0paSFlyZ1k5WXNjcGZXZmhVM0JDeEZJcFkrWnNYM0g4eC9rVVRPMDBk?=
 =?utf-8?B?ZGp2NkFnSkQyNFhGWDk2NU9UalhRL21TUzlMaXNKM25SY21RTlhKTDNDdGxN?=
 =?utf-8?B?RngvWDhCNUIzdjhCRlViRW44dnFIRllLenlHdkJJY2V0WVJzQ3pabGJsbU9U?=
 =?utf-8?B?WDE0MzlzK0JibzlSUmJZV1lpaEt6R2JqZ3RBaHJVZ2Z4R1NTYTNVVkJPUmxS?=
 =?utf-8?B?YnNkZGtCS1VzUWxXM2pETHNyNlU4eTN5QWdIaFBuNlZoeDY1WElyRVdoVHRo?=
 =?utf-8?B?Z3J1L3E2RmFDUVBUT1RRRk1rZDZpT1p2ZU85dXN5dFlqVWRmWFBCY0Q3eWM3?=
 =?utf-8?B?T3VOQm1ROTNEd0N3QVd3Mlg5NFJkZ0xzRlJLaEZYWnVVS2duRFFYRDBsRW9w?=
 =?utf-8?B?Uk9mNVRodS9mZDB1aHN6RGdERWFBWTcxbHZHeGxQbk1rQjdEMVdKS2c3VC9W?=
 =?utf-8?B?V3cwZHpHZGltU0JLZ243bUo2d2dKZFJUN2dVdWszeGZQYVZEeDFHRE95UnJB?=
 =?utf-8?B?VkFnZWlFOFlPQ1ZZNmRjNVZMZ09vZUJMMVhJZlZKM1UrWFhBbXowS3Arbm95?=
 =?utf-8?B?dWRwWUpPZnI2UzJGdEcrL1JZMEdUQTZNempLNExZdFBPUGZLOERLVkNJajhq?=
 =?utf-8?B?encrUFNMWGFvdGltSjQzQzZtMVluYVRGZS8zT2JZM0l3Zk92Mk5lS1VYeEl3?=
 =?utf-8?B?Q2pZL2l5MjNRMFJuVko5eFRGMytYVjViaUgzanFyMURIMFhBRG00Um02Tlhi?=
 =?utf-8?B?SzBSYjVuSUFvc0sxdnlOUkh4MjdhMG85NDFqUDlicUc5U2hTVis1Ym80ZkVL?=
 =?utf-8?B?T3dTdWl2NFNWWVVzYjFka3NsTlozVTFENmMvRDkrbUJhMHE1b0h0R29FSkp2?=
 =?utf-8?B?MkI5VGZ4SnFhNGtHLzN3eGZsZ3JZdjN2Zmo4QU1pMDk3NFdXcTFkSmI5am1m?=
 =?utf-8?B?bGp0MGhNT1Q3UnBTWlAvZ20wY0dxYzB6UGhzZVFia1U1WkdjbjJsVGtQaFBO?=
 =?utf-8?B?WkFKS3RmWWJMRzc4YXM3Q1V0K3Y0b1JmdXdkVTQyTmZFM3NoMVlhUGVNWDdu?=
 =?utf-8?B?NjFwYThrWi95b2l6dVFTeHZmcXozT2FnS2J1NDU5ZlZoNnU1V2owekNaZDJh?=
 =?utf-8?B?cVV0RnA4QTR6UDVlL1ZKdU1NNzNQNzBiWi92UTZDbkhROFB4a290TFRZTmdn?=
 =?utf-8?B?bEFpZXJ0UWFPS0NIclBNb3pJL0pZeUl1STZkeVF4b0NOREN6RUhCRGdNOWhT?=
 =?utf-8?B?YXc2aTFjbWhuamprTTFWRWhFWUZnUmlrZ2VzR2ZPNVQ5OWVWOFdVNmJWVkI1?=
 =?utf-8?B?TmhhblQ1R3dHcmdETUlOZHJxbHBnbFhjNk1uSTd2Vmp0YlBlT1d0blFHM1RD?=
 =?utf-8?B?L3JBQ1FIaTMrQ0JKZlRIK0tmL2IvZGs2Y3Nrd1VlaGdacitOMksxbUFWejBR?=
 =?utf-8?Q?AYpjhY6g8AOGStSeLjbin59xw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e505c040-1f3b-4ca8-60ff-08ddda358d2f
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 06:49:29.5600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwlxHwYLrN1TyY+GhlQizc9qnxrn0tqRBdxvWFfhdA1lfhYzZMgZ5IKGB6gX8yiYjcbI7SlKUK23mRVCdfB7UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6080


在 2025/8/13 4:48, Jakub Kicinski 写道:
> On Tue, 12 Aug 2025 21:32:13 +0800 Qianfeng Rong wrote:
>> Remove array_size() calls and replace vmalloc() with vmalloc_array() to
>> simplify the code and maintain consistency with existing kmalloc_array()
>> usage.
> You need to submit the first 3 as a separate series.
> They get applied to a different tree than wireless patches.

Ok，Will do in the next version.

Best regards,
Qianfeng


