Return-Path: <bpf+bounces-76491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BD6CB76F4
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 01:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F17D3017397
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 00:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F27242AB7;
	Fri, 12 Dec 2025 00:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NSCVnnZu"
X-Original-To: bpf@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DF029A2;
	Fri, 12 Dec 2025 00:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765498344; cv=fail; b=WU/bGzTGK3QWRmJlIAVBObZ7Wd5QkRann+kLE99V80Bh4Eg+OHOjeLOUqK3rPRfXUrTTNZ3o9UF6XIygiXLD4I3P/ZtAntiJWrxndruauW1we01lw5NR98KLLA05CYtmYD2D0W1kzMOvXWKL405xyzjWoCjxEBATTVsi66IQ6vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765498344; c=relaxed/simple;
	bh=1+DueGB6EkWsqMr0Ymnlqz8DX7Q4IxRR30SbFhKz+tw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vg49YQD7f4zqzuf1HaP1pzHRFXvx96eyIlJGNJq10xaaSaOY6Y191BgSwDuOLFL7/bRe0Obyf6gxdROM66qSNSzZRvmdi4etrLGv0UHAA7JaFs4AdztK4+9w4+Z//ZQYIDsfAm9PS/isuPKcB9mIbWp4DTxQEdEINAw3OykJvFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NSCVnnZu; arc=fail smtp.client-ip=52.101.52.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGkAUfO2yEkejqwgfXdJzSSx4nnV+QbbQxedlvu/BhoUKaeYEqR5052kqbRHxp6BTdaQ6DT99HeA2Oc7xNYyZauTuU9+HvBiIZyW6a9zP8Zi+sDm+V3W3+lggOPonu1/rP5iWcGT5P2d5/Ssc6nrWYhnucBPO6NevDPFZWrqxMhbqy61qW4CzKzfGkZbtVJ1pNBe6+el6CikFQ+o9BymUTZQwN3UA4ZBrC9JS09m1GaDhgXEZ0ZRwZDke6sWlvh+Cpd0yS2qH16pn3VF+/MvllzPsSqSrKVGXkIq/WDtQY3932dqLbkjtybijJsVVeM7clYmw513DKEP9PVNNYZMjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MP5Zmv+RIepUn9ZNKJ63/50gQI6MGQrx1cx6qf6f0Tw=;
 b=SG7xvzOPmppl9CtOkUcgC43oyktMmmGFxH3nyx6th0aYxFG//3m/sCsphSIqOszNoBVuDRiXMWHzPiMBAOATgSIULADVT5/ZLeRIo+A2Aowm0LMbbV3bpaqr1zOlLvYsRx0x/ZTIXzabe74FTtkjZgJbUNebdHCi45PE5R799XQPLaDugn5NW2yZn9OvC9ty/DMvUZPrsmyvsjZZzlevTKq8IfiS1e2JlrZL44sSjQIxpdMbnghb/ylvRNHWg2gsghT9CSU5dGKU+j2Ac8fGzbfAXAzIaoqLyzWURjjc1K+c4jzdENKpwRUA1aPG3aPzwtLC3xV0oo+ruFhn7XteuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MP5Zmv+RIepUn9ZNKJ63/50gQI6MGQrx1cx6qf6f0Tw=;
 b=NSCVnnZu6kkwQQfQKb+QqcdxvQEYLvLVoz1fd3cx4ko9P/ZPJg57yotz0vHokuy3/x+yGRnPwKxHl+7yhTjoQl2fq8wKhPSLGS3HEjHORVQAhm6Po7exjqs63RysrG2a1tVau+PFimIHavPsAeQ/X3kBV07tMaEKv4DU9VOYcsaPaIB04v2JkVTbgLEX2dXgoWnJju9IHlWux/zOyKNHH2AeCq/RyogzUDvK+Xmkwe92MjKNQhWY9BR5eqTKYOVMMnnGcuVP9uMuCyo/tUv0spnh/Xbx0karrODAYN4KHNH4Zrwc9Q3eSMiecoS8HSu04X3bdhZAPOLV++NnRABeYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.7; Fri, 12 Dec 2025 00:12:15 +0000
Received: from PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6]) by PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 00:12:15 +0000
Message-ID: <bce9a781-3cc3-45d7-8c95-9f747e08a3cd@nvidia.com>
Date: Fri, 12 Dec 2025 09:12:07 +0900
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
To: paulmck@kernel.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Steve Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <e2fe3162-4b7b-44d6-91ff-f439b3dce706@paulmck-laptop>
 <B5D08899-9C23-4FA3-B988-3BB3E8E6D908@nvidia.com>
 <febd477b-c111-4d5e-be89-cae3685853f5@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <febd477b-c111-4d5e-be89-cae3685853f5@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWP286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::19) To PH7PR12MB8056.namprd12.prod.outlook.com
 (2603:10b6:510:269::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8056:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 599b9fa9-7745-4ec5-7a41-08de39131aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFZjN1BnRFpXNmdZaEgybkdVRWNmL3BNd295bXk4YjBUV3ZTaGxZNGJRUnM5?=
 =?utf-8?B?SDUvMjZYMkRjcytFZkF6N245SmM3VWtsalUvY09zbHFXbnlqT3M0dFQ0TVVa?=
 =?utf-8?B?MkhCbGEzRXl6WXpreHp5dWU1QXNvOE9CN1Y0NEEyYUg2ZlIrSXZxT2xsOHly?=
 =?utf-8?B?c0UzNi9XM3dZQmtIRW1iaExrbElZUG9sTHRibURZWno1NXhkN0g0T09pdXAz?=
 =?utf-8?B?TFo3cUtKM0V5bW8xRWhmQm9pVE9JSTFGOXZqeXFpaDJkZ3YrMEU4QXI5U3gy?=
 =?utf-8?B?ODZDamFTWXVoMFBlUjhma2lFR3pxc3Q0Tlp2RXhGMkdTS0xQQ0o4VXk2Sml4?=
 =?utf-8?B?cjBmL2VuSVljaFVzSFppNE95bXJrRDJWeHlHSDY5c2ZJUzNYL1ZuTnFha1ZN?=
 =?utf-8?B?Sy9TU3B6MUFYeE14bFVsWmdwZWtWdklSMVphSkt2amhGWlBEVFdwTC9nUFMz?=
 =?utf-8?B?ckJhT3llV0dXOW9LNDJHZDMyVDVMOEkxQ1pOdlN1Nm9SVHZadmp5SGgyKzYy?=
 =?utf-8?B?Ym1VSVN5U3BYamRYRXc2dXY4YVFVN1ljb3BuMjdqL01iczlUM2xFME5wWGRG?=
 =?utf-8?B?OGJGeHkvdTV0dWhNOHhiT0JNdUE1UWlMVklNdVJ0YkNlbFBEUXhudEg4QUlX?=
 =?utf-8?B?TlNGRUc4bnEyeDBlWmdydjVIc0kwYUZ2T3lZRjdod2x3b2Q5TWt0SEdNUVBp?=
 =?utf-8?B?b0xvazdZSlN6K2E3WUFCMUxDUThodDlybkpoemcvV1UvODEzWUd0RVZ3VG1x?=
 =?utf-8?B?bnZ3bmh4NnJTSDljd2FyYXRValpSMnRLOUxFK1hOTzRyTTRKSng1V3JtV0NM?=
 =?utf-8?B?WWNsY25HMDVNYjY4ZC9LcEtSRnhXbk5TWGZEdEUyRk1oVlBYbEQwaU1QUFBK?=
 =?utf-8?B?ZWhWNy9iaTlYK1NoZ1dYaVB0WWxqcXYxTUtPa3RtbG9TYU1sYnRsUUFvRE5D?=
 =?utf-8?B?THY1R3lyVlZXZVllR2tWMUgxRCthTy9pRG9tWnZaRkVWSjU2eG5TQ3VuUzdU?=
 =?utf-8?B?Sk4xOE5yMkN3VWhsakZ0TGlFUm9PZFJXUnpTU0F0eWM1QVJjZHJnYWtGcktE?=
 =?utf-8?B?Q2xzVEZ1NmpjZG02VG51bTFSK0g2bCtqblhlUGJzOUExdGk0eTg4UTd5ZGUx?=
 =?utf-8?B?T2pXZkxnU3owbExaWm1HMFRJdjAzTXcyeGVuOFlpVTZzaFBaR3d6N253bFBD?=
 =?utf-8?B?eUw5MklLSFZNRWFCZ25xM01wOUpYYjdBVzVpM3FvVlYyUzhZQnF2RDNvSElO?=
 =?utf-8?B?TVNyQ2VvakdFaWVBTEJXaHJkc2dIKzRkMUhURGZGNUkyRlBhNzdTaXN0RUZC?=
 =?utf-8?B?TWxORFpEejR1V051VitBWHdMd1Mrc0RmdmxrZk4xaXlxWHJheFlsQ3prczVM?=
 =?utf-8?B?MkhTdmJIY2xZUmpQaXVaM2NNZkRMamdyRHREUnF0NG15aUc1bHdPWFRtUk9K?=
 =?utf-8?B?d2Q0aUlNU21scUVES2RTenRyei95Sm0zSklPVjltaDVqc2UwMG0vNkViNkpQ?=
 =?utf-8?B?T1h5cEtmSmt6a3NUbzJZcjc0MUtnTys3R2RGYlgyKzRFVjZXUEZqdVgxRklx?=
 =?utf-8?B?bmxmcWZ2NmJETStOd015SzhBQ2IrdjRja29URDVYd0VRK0diVUJZZmFRK2o4?=
 =?utf-8?B?SlhIRkw2dWJZUGVndElqWXRUbDE5UXJHaEN1QTVldmVtTTVXL0dVMFlBTnd1?=
 =?utf-8?B?QnVkNUxDdVZQbk45REMwSjVxTUdyZW5KZFVnVWN2VGdUMUNNMnpDd2xzVVc1?=
 =?utf-8?B?amxiTzA1TWVKcVFkZEJIZlFWT0JaSXR1VW1YbFVDWDJ2WUpMMjFTVXRNblhp?=
 =?utf-8?B?L1RrZ3VKWE5TaTF2c2doUG5pTlgrY20xRFQzbGh6S1JlZFlISmFPSGhaOVRO?=
 =?utf-8?B?UUpjc2JnaDVVMEVvQVJlc1hBUHFDWHU4RHVDTHBpV3NkV3N3SnB4aHNrT2Fu?=
 =?utf-8?Q?qOG2z73VTw56MKdW1G7sLcqNkVmSz16N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b05NUlZUc1RYMnlPWGdDVVFJOURVRlE5ZStweURiVFZMRGZwR1VXYitBU2dl?=
 =?utf-8?B?NlBKdEtBRzB6RW9WbCtUeFJuNjdOeHBrYlpqQlBIZUpVTkhCWE1wMmZUSENj?=
 =?utf-8?B?d29Xb2Vuc0tqaGdlVVplRkR6d1B0UFYvZ2J3NU4yOXU4RHljODJhWFg3V2pi?=
 =?utf-8?B?OERKY1M1R01Wd044U1NYS0xJeE5SN3BwZlh2WXNuSDREclByVmJ2QU95MHRv?=
 =?utf-8?B?TEREbXBDZEpheEI3dkJqcTFpTmlYRUtSb3RmQUJkMGxzTzVVNi9IalRHcnE3?=
 =?utf-8?B?UHJyYk1iNkFKbGN5Vlp3TDBHazNucGxOS2tHM3RnNkcrcHY3MGVIS20wd0pE?=
 =?utf-8?B?VDNoUENrQjBqcmFIVzBZVkhpVDRJZmc5T3U5MTNaK0ZuS3RUdG5BZWptYUh4?=
 =?utf-8?B?eENJdFpJblg0Zm1MSVNBT0xpbTVmUDJoNVhraVJlWTlDQjR0RGMvVnorRVVK?=
 =?utf-8?B?U0EyNnhXRm4ra2RLQkxKYktXSUl3VWVsRXEvdmw0NWM3VE9zK2NGSFpHOGx1?=
 =?utf-8?B?ZlN5VzBoRFArdzJOVkFiQk1POHV3bVdIckpJTzRyY0NyL3BxRlNuaXRWMlNE?=
 =?utf-8?B?MDM2eGYrNW9SZlBKR1R0OHRIM2xoWGx6aU5rM0wrM3VLU1NCWE5SWW9lSmZn?=
 =?utf-8?B?Yi8rYkdPMENuRWo1cUJLUC9PcHduTk5JaDZ0OWpldTdKS0J5SVgyUkNuR3ZB?=
 =?utf-8?B?YzNZZUFJa2hzVUl5d2ZEMDB4TTROYzlhZFBHVnUreTltaVhGWXBnUXFLRitJ?=
 =?utf-8?B?Z3Y1R0k1MzRVSURHTzU4cndjeDYrN2FkN0ZYcFE0MmR1ZExiam9SaXNrZWQr?=
 =?utf-8?B?Q2RleEZKTGw1bWk1VGk3ZGh3V3BVYWo1MGdYTDZ0dzhOYlVmakRqeXRFMk8v?=
 =?utf-8?B?bUorRVl6M3pERmhZQklEWXFrYlFoOXkwbGFGc0VSdDdYcWxXdFpBZFF2MWp6?=
 =?utf-8?B?NEZpc0xPUWw4TnAyMHZXSHVMWTRBbGdnVEdCWnNTSHpDd0llZ3lkRjFjczQy?=
 =?utf-8?B?UUxldGdyWDdiaDVEYXRucEZjb1RTbGJMcjUzbkFCZDFXVzdqMEg0WDdJVEg1?=
 =?utf-8?B?Uk5LZlBzeTh5Z0tkRks3eW9hZ2VZQ2l4V0pxa21vRWhEdm9EeEdsaHBHdWRP?=
 =?utf-8?B?TWJNWTE0N09tNWpoYkY4ZERJYUFjUHczMlFlR3hjbmh6QUFqcm5ORnEyUU13?=
 =?utf-8?B?SkIvSHhVNElSNkNWSDNrQW40VmowT05udi8zckJVVjRQNWtLeHRFdUJiZ2JR?=
 =?utf-8?B?VDJzZFBFRWlOa2pQWE9YSkF4RjAzcEkrOUVXMnB3TWRVMmpRWEVNT0ROSHR4?=
 =?utf-8?B?WHIvNlRjRTBtU0pKZ0w1bzhHWUd6a3J3bWxvaytUY2c3MWNHMVBsYVM0bVRJ?=
 =?utf-8?B?YkFDRERMMktXaVNjRUFHWWNwT1RZdWdBUVk1U1NNc1hCems2cjJxeHpKQWxM?=
 =?utf-8?B?YW5EczJvRjM2cUNtazE2NldKMU03cnRVSmNzN0JlOEFWbEFYVEdKbjNDOGRq?=
 =?utf-8?B?Q0hmdlI5a24zb1YyRVdYbGtKTHpPYWhmS2tWVDlXV1hJR2RoaEJ3Ukx1TGdC?=
 =?utf-8?B?WWxBRWxpUWJuMHFkcFU1Y2pIa0lXbVdvSUdxdjBGNGx2am5WbUNGQmh5cFda?=
 =?utf-8?B?UlNvY24xc0E2dDdnUVFOR3FUem5Cek83cXNManNIeU01RmFxQStrVXFDdjFI?=
 =?utf-8?B?Q2NHZDhsbkNKV0xoTzhxaXF4bXg1UTRlbkEvbkkrM2srZ2xsTkZxSkpMblhn?=
 =?utf-8?B?QzdoQUN5Mk4yOC9IQkdTdzRFcElLWnVVV1YyZXBSb1lGb1FpR2FlU1ZadGlq?=
 =?utf-8?B?ZEkyZ0piTDFxTDhDbHUxNGh1ZCs1R2NlK1BPS01aSDJmc21kR25yd05VNmdj?=
 =?utf-8?B?UW9DakRxKzZUejBOUjQ3QlM3V1BOWDJCWHliZE5wcGw4RXdIZFRUWWV1b0Zm?=
 =?utf-8?B?V0h4M1ZCcGJERGZzekhyOVYrV01iSkdabmRVZTljY2t4cGprc2V1VG1tb2Nq?=
 =?utf-8?B?QkJxcjUwZWNlTzlNQVRFcG1tY1hxenpKejlaMFUvbFRINjBwWWlGYnhDaXBp?=
 =?utf-8?B?dWtsYThjL0k0WmNvN3oybS95dUtFQkxUNGJYY2pBbDRLQ0NwbDJPbE1QZXZ5?=
 =?utf-8?Q?6BnU5ipKVGV0pNNULR1SUbwQW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599b9fa9-7745-4ec5-7a41-08de39131aaa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 00:12:15.0219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XfUPzICboIKqElB+OveqAZ4zwsV00+sjcuEcG2JsxiwR9AvuT/a/OsUnv0gGo3J0VJ+HEBYjT6t9MNp+chyig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559



On 12/11/2025 3:23 PM, Paul E. McKenney wrote:
> On Thu, Dec 11, 2025 at 08:02:15PM +0000, Joel Fernandes wrote:
>>
>>
>>> On Dec 8, 2025, at 1:20 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>>>
>>> ﻿The current use of guard(preempt_notrace)() within __DECLARE_TRACE()
>>> to protect invocation of __DO_TRACE_CALL() means that BPF programs
>>> attached to tracepoints are non-preemptible.  This is unhelpful in
>>> real-time systems, whose users apparently wish to use BPF while also
>>> achieving low latencies.  (Who knew?)
>>>
>>> One option would be to use preemptible RCU, but this introduces
>>> many opportunities for infinite recursion, which many consider to
>>> be counterproductive, especially given the relatively small stacks
>>> provided by the Linux kernel.  These opportunities could be shut down
>>> by sufficiently energetic duplication of code, but this sort of thing
>>> is considered impolite in some circles.
>>>
>>> Therefore, use the shiny new SRCU-fast API, which provides somewhat faster
>>> readers than those of preemptible RCU, at least on Paul E. McKenney's
>>> laptop, where task_struct access is more expensive than access to per-CPU
>>> variables.  And SRCU-fast provides way faster readers than does SRCU,
>>> courtesy of being able to avoid the read-side use of smp_mb().  Also,
>>> it is quite straightforward to create srcu_read_{,un}lock_fast_notrace()
>>> functions.
>>>
>>> While in the area, SRCU now supports early boot call_srcu().  Therefore,
>>> remove the checks that used to avoid such use from rcu_free_old_probes()
>>> before this commit was applied:
>>>
>>> e53244e2c893 ("tracepoint: Remove SRCU protection")
>>>
>>> The current commit can be thought of as an approximate revert of that
>>> commit, with some compensating additions of preemption disabling.
>>> This preemption disabling uses guard(preempt_notrace)().
>>>
>>> However, Yonghong Song points out that BPF assumes that non-sleepable
>>> BPF programs will remain on the same CPU, which means that migration
>>> must be disabled whenever preemption remains enabled.  In addition,
>>> non-RT kernels have performance expectations that would be violated by
>>> allowing the BPF programs to be preempted.
>>>
>>> Therefore, continue to disable preemption in non-RT kernels, and protect
>>> the BPF program with both SRCU and migration disabling for RT kernels,
>>> and even then only if preemption is not already disabled.
>>
>> Hi Paul,
>>
>> Is there a reason to not make non-RT also benefit from SRCU fast and trace points for BPF? Can be a follow up patch though if needed.
> 
> Because in some cases the non-RT benefit is suspected to be negative
> due to increasing the probability of preemption in awkward places.
> 

Since you mentioned suspected, I am guessing there is no concrete data collected
to substantiate that specifically for BPF programs, but correct me if I missed
something. Assuming you're referring to latency versus tradeoffs issues, due to
preemption, Android is not PREEMPT_RT but is expected to be low latency in
general as well. So is this decision the right one for Android as well,
considering that (I heard) it uses BPF? Just an open-ended question.

There is also issue of 2 different paths for PREEMPT_RT versus otherwise,
complicating the tracing side so there better be a reason for that I guess.

thanks,

 - Joel






