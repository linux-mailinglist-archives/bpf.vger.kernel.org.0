Return-Path: <bpf+bounces-58909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0C1AC34C2
	for <lists+bpf@lfdr.de>; Sun, 25 May 2025 15:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFABB17574A
	for <lists+bpf@lfdr.de>; Sun, 25 May 2025 13:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B011F1931;
	Sun, 25 May 2025 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A1Ic7Pzd"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD8C111BF;
	Sun, 25 May 2025 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748178253; cv=fail; b=g0X+RiiD6dkuTpLM9fsRTUf85t14WhakpDNcNg/sNALPyAco18Pmi2hm9MCOL3COaiIg03Qvyd0g/hh+Ee0a73HGTSxTGfhfg+ftvhyACaoTjZyhOHEMfywT41rDvxAXaxgqgAbtrIyB5MYN34gqTzaVb1gDNs40jvze+5nys4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748178253; c=relaxed/simple;
	bh=k/BsBqFuymdM2ZuAu7S7QheETsj1A04fj4/Gd5/qHzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bUA0OlY0a3t5ERpfZK+5V521x8Xe+qdR8gqVdauTYUWac2aEEEmvTsLqs9YSKpiRaLOtTZHlx7SJTibhovql7dc/cakgFp/vEnG+Ro2o9YfZ/DG6EneZU6259JLvuX/T4/Zd2c4c/kA181C7H21O63cccXf2I017soYjPE8qyVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A1Ic7Pzd; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCHspfuSlN9i7Yz/c2Oq3Ntp1CJEzZNTyo1bkLx9XFzm8VFU4VVcKPAinYr3TfTNaB2FnARlxygGDhaHlzA5cUwKxGmDOx9QgUpruIu07gaF6sTOUVGHr3kpVbrg04gblQqs2BMc2us9HiKco3vLu5/AIIGFApYb8fNJNZp8hLgh0BmY7UMT8F76vzWwHU4uy5CIwmi/NLEpAXwzQOWoaKFx8MtfKMCwMIrvu50V3bvqrb8WnWOqff/TtpKlSTMAtu8PR3fbwbdGH0Zgy1AWr+WInYQKWBH4ZBmfZ0GdQRAuh6cYmgq/6WIOcaR/ZhBpXmK9SU0pFaQS+6T/vO0ADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvpYepWeZ6vEVdX2gLgAr7NBYMk5/vTxnX83WlMosuk=;
 b=XjEiEB7Nxqj2J4VzPguTEDX623dGM1hC3SgIsJ1nyOwfNuNibA7JWLJTdGYut0C1+HgIk9V+xBD3lLrLOolMA7wsRU/tZpK6RE2tTuwiF/ynwTH6t7eABw+ywJo2hTe9DJN2u78WUYKlxBvw7X1zHJCH1jZiYmZcg2X0JhIugE/jUKCt0bSunpZeabvZIA4UIvWDZdsljfgWVvDESYqObj9xC1cPudQL5VqOiipbo6vombbvWfvx9MF8R+ZlwVHeNSb/0Ik5fuAuuh+Mq3X8v1V6qUbEqcwh8KayH6DeyK6vu8zqeMAeuXWTtxZIUK1lgrkn3Gh7ZRSdk0MoDfieEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvpYepWeZ6vEVdX2gLgAr7NBYMk5/vTxnX83WlMosuk=;
 b=A1Ic7PzdhJFv4T6I9Vqp/Yh2LVTL+Ymo8M7RCnHRIMy3kSb3L2cb3SAA0kv3duPK8EBw9WKPj5lBmtDUyfkoiPsQ2TtwzBFNWtKCCecF00x+p2Qc3CKBFK1iZviqti7Nn7sv/TENLzW9poGNhRb4rg5QHVa0B6NT11juKnU7PPFrA7y4sQzVgB+5uBiUWJWnerfZYrv2be+LwNg64JT/iMUASIWI0b8+wpcRUr66f9Y85N9Y68C74D51WZQ8PY4/o8i/N4DaOGI+y++fL4jukG0bvQY/az/ONv7FnVjdJ0hXPe7tuQjW8oDXjKYEBXqrzAJxTmFUeo5AgAO8gU33sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by SJ1PR12MB6316.namprd12.prod.outlook.com (2603:10b6:a03:455::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 25 May
 2025 13:04:08 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%5]) with mapi id 15.20.8769.022; Sun, 25 May 2025
 13:04:07 +0000
Date: Sun, 25 May 2025 13:03:53 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Mina Almasry <almasrymina@google.com>, 
	Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next V2 02/11] net: Add skb_can_coalesce for netmem
Message-ID: <c677zoajklqi3dg7wtnyw65licssvxxt3lmz5hvzfw3sm6w32g@pfd2ynqjkyov>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <1747950086-1246773-3-git-send-email-tariqt@nvidia.com>
 <CAHS8izOUs-CEAzuBrE9rz_X5XHqJmWfrar8VtzrFJrS9=8zQLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOUs-CEAzuBrE9rz_X5XHqJmWfrar8VtzrFJrS9=8zQLw@mail.gmail.com>
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|SJ1PR12MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: b645ee3b-a29f-43dd-75e5-08dd9b8ca208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2grcFVBVitjS2ZHLzZUK2dnOUlyaGpCV3QwcjdxSjZ0Z1R4QVZ0YjZ6U0hR?=
 =?utf-8?B?UFBxTTZmN2Q0c2I3aEo1L2pkajlqMDMxZGJMWlRKNTJLdmZmVDlOTHNNcGVv?=
 =?utf-8?B?M2E2YUlWeXFzaUJGZ0k3K2x3YVE1cXBSQkh6cERkc1VwY2MvRUFwQjRtRzd3?=
 =?utf-8?B?RUNKNU95Um1Udzl1OEZERUFQMTVsRktOU25OY1M0MnEvVWtyZjdSMDFQTXRj?=
 =?utf-8?B?dDBld0EzaXJsUWs0SXh2N3Y2bkcvVWttZE1TbVdqYU9IaGFZUGczbDVURWta?=
 =?utf-8?B?eTFVdmM4ZHQyQ1g3OXptMzdkTU4zNlFaMjVFQ1B1TVZ0aGJjTGtGYlBra2o3?=
 =?utf-8?B?RVBQTnhEbWxzRWg3YXNHa1ltYVpkak5kbis5SDIrTmtSVnhpeUhYUTBvM2FF?=
 =?utf-8?B?SlV6SXVWSTd1U2J4Yyt3bldvMFVhZjRyNGFtbmVCc0p2QTZLSjJnL2cvSDZr?=
 =?utf-8?B?RTUrTG8yZ1BVaTMvRUh2WEJSQmdZdkdBaFN1cnVSVk8wekg1N1VpKzJrNXdM?=
 =?utf-8?B?UEg3dCtKK3lHK3VFazc0bE0wNXRNSFlabG9KbGFTakE5aFJSeDdwclZxMk1K?=
 =?utf-8?B?VmdOSDdkK3lmWW5Wc2FMK2wraXAvKzFuZFZiVDUzU0kxclVSY0U0eXhaTEt6?=
 =?utf-8?B?TE5uYjV5SGJTTklZMlhleHdxZk1HcnNxTlJJRmFydDkvMUVRcjdRV0lTTU85?=
 =?utf-8?B?dmNaYXhqdWpBZjdCQU9nU09XTFRUUEFQRGdMTWlBa2Myc0hzdTgxdTFKbitR?=
 =?utf-8?B?dWwzK3I0Q05TWFk3MUxjL2xYeFRCbmdwVTFMN2Y2SU5hZFdtVStBNXJiSDRz?=
 =?utf-8?B?SW1jZEJzekh6aG56ME1YMmQyQ0dTcmltSlJLL2RuTnRoNStrdnFjTUducjVw?=
 =?utf-8?B?ZFFmQWdmTFBzQllpY0dVeXU0cnRTZFN2TnNZb1hvdGM3NFlSU1BFNVBXdExz?=
 =?utf-8?B?eTRYSXkrSVUzbUZ5blhYTnhZTEZ1QnJYOVdLanpUMTh4TjdFWDVyYzVOZDYz?=
 =?utf-8?B?UStOTEQ1T3NGUm5PbVlRQWJ6dU9RZmQxOEVadE9PS1MrK1k3dVBMU2NWckFr?=
 =?utf-8?B?V3JDckFqMXI3Wjhma0o5N2M2S1FteHZNSHM5SCtsNWxzSXpBbUlCbE1mYzF2?=
 =?utf-8?B?Y0d2MFFkLzFLeXFHNUNLZmYzVVI2OFJSVDgzc253VDc2N3RIUytpbUhIVy8w?=
 =?utf-8?B?Y2lrMjY5anBmaWkzSXlzNCtOYU5JRjZnSXR5OTVLQXQ3djJUUEtSWXVrUGtl?=
 =?utf-8?B?ZVFSRHg3SWtRd1Y5N2c1bVk4UVlHbnYwR3VNc1FhS2U4ZEg3S05IamJlelMz?=
 =?utf-8?B?SFFOS3E4bGVEZzhaV1F1ZWhLZU5wRnIrQzJEVXE5NHd0cktOYm9qWXpPb1c0?=
 =?utf-8?B?T1ZXSWMybEdkcHFmcTBmTGgrYS9ja1F5VXpXUS9UTFB4MFJ6QnpiRmRmNVZM?=
 =?utf-8?B?ak83K3Y5TWtoMHV0QTVyQ1VUNXozU1NuOGp2NjZEVEFkRXpsbnFiUEZiS2J2?=
 =?utf-8?B?RUZmNVA4RHN1Q2xYZ1UvNTBMaTdYMlY0Ym9peGJ1MmliQTF2V2tmaU1xR0tv?=
 =?utf-8?B?aG5RQnpxNjFMbkdOR0EyV00weEh2Zm5ZZGFmQlRBaW40eFZOb0VZRlRNY0Zh?=
 =?utf-8?B?dUUwdWg0SEJNTzdUWTRvM0NDMFZ5RWdWM0pTdGxSOTgySzc4STU2WDN3dUpI?=
 =?utf-8?B?TFpuakFieE1wOHVERFdrREx3RW1Gc0J2bDFsYW84ZzZNUllnNjRWT0FJZE1R?=
 =?utf-8?B?YmJweGpSeGVzSzIra3c5TTRESWVROS9oUVhUa0R6bTc2UHkwREpjQlIyV1cv?=
 =?utf-8?B?a2JVT3d6SnVuU1E2Z1UzVE9Wc3BtejNwMlUrOVJTYkw2QWNWWm9FOEhkNTBZ?=
 =?utf-8?B?TGlwMGRRb3RZSlNMWnhlSnNpWDR1Z1hadStJY0hBSWg0USt0NEJiekRUb3pO?=
 =?utf-8?Q?5FnoXTKcJgo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGRONUtmSVNRMlVOZlZwenkyeXRjVjB3a1IvaC9xT2FzN3AvdytNenRWVHgv?=
 =?utf-8?B?TW1ORHdEaWo1cHlTd0VkNTQ3ZTVkeEFIUURFRVlwSFgvZkJXV2dBQUZOeTVy?=
 =?utf-8?B?S0tPVDk2aU80YXB0TWVzZWs5ajdQMDNLU1FLcjI5cmJwTHJPaGtNUkdnR2Qw?=
 =?utf-8?B?U0ZHa0wyeGZvcXBpNXRMN0UzZ0o4UFQ2RU9yUE5YWWRHK3hRTzJUcTRXWmhM?=
 =?utf-8?B?MFZMb1h3RUdvMm1zZnFMMmVYZGpIT0F3K1NmRXVQSWRsSTh3c0gzMWZicEJu?=
 =?utf-8?B?b1VNem1RbnF6aVRlSFVGNHJKT2ZyYnB0VUhieHdWVWNLUk0zcVlOYzRjMVFK?=
 =?utf-8?B?bTBOTFg5K1VzY1V0eVNoMzJSaHVZVzl3d011UlVxTTNsUEZlbk1NWEZ5L1cr?=
 =?utf-8?B?YjJjYWNYZzJRWFNRa3Jhd0RPbFdmZjNzbnN0eTdmc1dGQmUzbERZOWpPUUow?=
 =?utf-8?B?WW5KbU1VZlNMVnhiYmo1QUJpZ3k0QTUvRzQrdktza2JHaGhlZzBSYmNGbWFn?=
 =?utf-8?B?KzVCVDlxd2p5b1ZvcjdmOW83UHdvYVhjNzl2aUlRRjhNbTFyd0xaWVIzM1Mz?=
 =?utf-8?B?dFJFbysxTk9PU25UaGZXckxzeEp6M211MFFRM01XU2RCN3laMU9YOStudllt?=
 =?utf-8?B?N0JhS2tpNFQyTWRlQTRBeXBWMGlKaXRBaVArdGJObTg3eU9nTmwrcGVuMXlD?=
 =?utf-8?B?czB5K09TUCttV3pJT2JjS0RLMXlCdUJmU1Axci9McUErRXVhM1RONXE5ZjBR?=
 =?utf-8?B?RVV3SHFiL0ZPYlJlb0tNQ2I5UVdBRm1tRk5jTzFlVWt1ZzFSMjNJaGlEYklw?=
 =?utf-8?B?YTZCc2NMaTNMdVd2TURWQkhDdFRQS090Qlh3b1pMaSsycXdmcVc1YUpUNnI1?=
 =?utf-8?B?NE53UjAyMlhXSzZkYlJhNWFBcHBnaVFaVExnZmk3YUF6c0ttRFJxMGs3VzYz?=
 =?utf-8?B?Zi9xSDBsdENmY1Y4ckRhZ1pYWlVuM3BSWm5HUkpta1JDN21IR2M4cERzY0xx?=
 =?utf-8?B?d0ZRa2FNclFEcmlmQnlZdGI5RTJkYlAyQVEyNHU3NUwrMnFJME51V1JFZkJp?=
 =?utf-8?B?aUplLzJXdTBkczNFOGRCbTVBN3h3ZkprSldJc3VlRHJ5ZTIrc1R5M1JqUGgw?=
 =?utf-8?B?T2VOL1k0Q3prSzNrWXNvRjVrVnBNZnZ1VDRFRUVPNUxWMlRucm5qVFl4b0RS?=
 =?utf-8?B?QXFTVEx3V05zZnk3VFJlNlZ4dEJFOGdlNjk1R2JpTzBsMnVtTDcvaHNUL3VS?=
 =?utf-8?B?aC9xdE4wWVVwbnBTVmtoZUFxYjUxYXltSjEyU0NpcHMxZEZXaGN0WStZaFJL?=
 =?utf-8?B?Q0JaY3k1UENZOUowM21TTmlrV1ZJa3h4NUxjNGZlOEQ5QkVMVU4xYkZucnhP?=
 =?utf-8?B?cVRZZ3VSdWVyOVRIRTh0NHFDa0k4RHg5NHZhUkpTbDFlaEZ3dWtyK1RxdFlp?=
 =?utf-8?B?eHJOSktEMHRNQTl0QWhtTHRCc1gvZ0xIaSs4clJRMUxLTVVFZXhHRWlZNEZT?=
 =?utf-8?B?NXN6QkhVd0d0NXJzbVhjSWg4YW9WMG9nMWRUdVd4WTlaWkVPTEt6d2dhTzBv?=
 =?utf-8?B?OEx3dFJ6L045Z3FEakFTT2JUMzVYcUwrcExoaFVMMW9iKzNsalpIRi84NFd4?=
 =?utf-8?B?TVVWNDduRXJibG5BRVQ5RGNYc1ROZXZLS0RGVkhtZTIzc1loQ1JYNmVlYzRC?=
 =?utf-8?B?ZldnN2dFOEF0RVhhY3VWNDh2Z01waFYzd3ZrSDhabmVRVzVWRmI3SXdTOXYx?=
 =?utf-8?B?a3JhNjVTdklGa1ZrYzRlUkZnajdzejlDUERmZlkzTkR4YkkwdzltRTlDcC9l?=
 =?utf-8?B?bFNzVHNFL0I4WDB5MG1sRGZ6VTB2NlBtRWxCaFhjcTc3R2RGTFpTeTgveEpo?=
 =?utf-8?B?MjRHYmE1ZWRkV3hYMVVHS1U1WFcwallhTlA0UVQzNDc3RzN3b2RJYjlPMVZ2?=
 =?utf-8?B?ZzhCRllKOUJXd0pTT1NuK2FjcGxyNjJOS09seXFEVTI4MWhLd0ZBd01YVXNO?=
 =?utf-8?B?NmZsaks5aTF6NW5aSHpMd2ZvYzZ2V0N3c3c5Z3diOVg5YzA4aXJPWE9aQkQ4?=
 =?utf-8?B?SDhiK1FvWkoyY2c0M2s5a01pM0IzRms2NkFGRG8zbFVXSmRISlQ4bVgxc3A3?=
 =?utf-8?Q?rkmm2GpIuq+rG0aoDNpqioQDT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b645ee3b-a29f-43dd-75e5-08dd9b8ca208
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 13:04:07.4981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KCsWX/QslLaOQfpmfm/IFCQvhP3yFfnVXkcjY58NSjp7w4pfAQZ3soDdWTjRATsLDVji2aTsCAPnSRuItqJPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6316

On Thu, May 22, 2025 at 04:09:35PM -0700, Mina Almasry wrote:
> On Thu, May 22, 2025 at 2:43 PM Tariq Toukan <tariqt@nvidia.com> wrote:
> >
> > From: Dragos Tatulea <dtatulea@nvidia.com>
> >
> > Allow drivers that have moved over to netmem to do fragment coalescing.
> >
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> > ---
> >  include/linux/skbuff.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 5520524c93bf..e8e2860183b4 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -3887,6 +3887,18 @@ static inline bool skb_can_coalesce(struct sk_buff *skb, int i,
> >         return false;
> >  }
> >
> > +static inline bool skb_can_coalesce_netmem(struct sk_buff *skb, int i,
> > +                                          const netmem_ref netmem, int off)
> > +{
> > +       if (i) {
> > +               const skb_frag_t *frag = &skb_shinfo(skb)->frags[i - 1];
> > +
> > +               return netmem == skb_frag_netmem(frag) &&
> > +                      off == skb_frag_off(frag) + skb_frag_size(frag);
> > +       }
> > +       return false;
> > +}
> > +
> 
> Can we limit the code duplication by changing skb_can_coalesce to call
> skb_can_coalesce_netmem? Or is that too bad for perf?
>
> static inline bool skb_can_coalesce(struct sk_buff *skb, int i, const
> struct page *page, int off) {
>     skb_can_coalesce_netmem(skb, i, page_to_netmem(page), off);
> }
> 
> It's always safe to cast a page to netmem.
>
I think it makes sense and I don't see an issue with perf as everything
stays inline and the cast should be free.

As netmems are used only for rx and skb_zcopy() seems to be used
only for tx (IIUC), maybe it makes sense to keep the skb_zcopy() check
within skb_can_coalesce(). Like below. Any thoughts?

--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3873,15 +3873,22 @@ static inline bool skb_can_coalesce(struct sk_buff *skb, int i,
 {
 	if (skb_zcopy(skb))
 		return false;
-	if (i) {
-		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i - 1];
 
-		return page == skb_frag_page(frag) &&
-		       off == skb_frag_off(frag) + skb_frag_size(frag);
-	}
-	return false;
+	return skb_can_coalesce_netmem(skb, i, page_to_netmem(page), off);
 }
 
+   static inline bool skb_can_coalesce_netmem(struct sk_buff *skb, int i,
+                                              const netmem_ref netmem, int off)
+   {
+          if (i) {
+                  const skb_frag_t *frag = &skb_shinfo(skb)->frags[i - 1];
+
+                  return netmem == skb_frag_netmem(frag) &&
+                         off == skb_frag_off(frag) + skb_frag_size(frag);
+          }
+          return false;
+   }
+

Thanks,
Dragos

