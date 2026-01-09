Return-Path: <bpf+bounces-78419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C96EED0C74F
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 23:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC5713020396
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 22:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A5D332EB3;
	Fri,  9 Jan 2026 22:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="CO114bpc"
X-Original-To: bpf@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020099.outbound.protection.outlook.com [52.101.189.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6AF50095C;
	Fri,  9 Jan 2026 22:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767997906; cv=fail; b=aFxOZLFkLyyvbWrV6UdSsJh24VIyx/DxNycMcKnj/diOs2Vc4IxZBQJfvacSLA3li4weg/cwT81sA79ZjXLfg99RpBCxoMItaGZpNJqpoEXYNrDRpdBk5V3HX/tLAB2Hx09fDpfS9jk2yWtz5bmDhdvCBKjbKS0bMH/NAP1y7iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767997906; c=relaxed/simple;
	bh=J183VU2iFRIhA8H0X4KdVy73ohzCkZTg3uMCvj7y3gc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z2Scxj8Mfrjd22nHSa/p47OXeJbY2q+NKATkxm/bkE7taLwNrnkkbPwoF57x832ivJjuNP0/xUp2DBwjrPXSvR1ltZCXt9SXbHTuSNca3i0dFslCB+/JOpP/Zil59dEgsUWhXlY/A2fnqDzFJyEAp3edtFl0ldI6s3uKjfRzMbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=CO114bpc; arc=fail smtp.client-ip=52.101.189.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzFJXSeN7WZzweyiBkebvyzbHK6beXD9S1x5qqcbMrloZvEEK1+bSRO7kZIF8pvx6jEqghm4DzXGJwQIU/BnMY8guBIQnIWEuCoAizHaTslfW4k722lwNswCW7Qf8Vmo4MHK1OSgZD/nh6cw5K7qqeElb736W9/jfeoyZfajrKWF3xkVk2f9+e9XDNB5oGbeZvmcDMWGLTQoiMz4ZHLRrDI3e6syGXrFgy0v19J+ePPgtXSaSlPeRTLl46RHfQBd+77SGXuF2PSnOU/olPQJkMq7abNe5+oLmaqV03O6M8Ou1p5YC5FYhMeZzv2ar3AtPmviJ0kARhkRq/vyLVFqRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7yBf6QtlWvikqR6zs7QzmA0D/hYDxv63mSdsI5yRZw=;
 b=oCXfJgt8+lActleWkrmQK+GUClPW59IrMUHvSIwIYjcDugPYCvj/pDj8oz9dVw7OfWEGMlRpy5y3qzMkX8Xdh4qWN1H8OqR4ADX+TCd1hshE/XxdnOPDz9z8Nz5MFvda8pMsGgCUM/HCNjUBalKAjNRnHur/lg6Y66As7pogJPWzYtH5pGot3GWqNCOKsixB8VURINxkbrJWMZ+LBEzUmIxlwon684Wg7c09SbxBe9KmNmbeSBr4jGA4PVp9G/N3wVpVdBPX7HdLy2iweua0tiDqo2QOyrNMrVJhiVV8JqnROmtkgdaEXmNQyUr68nVX4OytfR5p3r/wBzeVfhWAcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7yBf6QtlWvikqR6zs7QzmA0D/hYDxv63mSdsI5yRZw=;
 b=CO114bpcxhK1tH2QYK+mUq/kYTEwfRE5M+0QXnBodrU3ZZnEos0xzJVlmvBkcZD2myshHFm4L1eQbuJB9hG1/zLaCD9kdpNYQSRXjfVH4wzxaNhRWQ1ewk0Gda1IF+ls9qWMHpnunCcKks3Go9CsUcgMGupFgLrz6HxC7WVc4Ebqs6ORZ+YTeyeuaeCh4V7VVdrBmTqkU4wIpSWUea2hZcHAjw9rYZLG5UsUWZ39ArpdqJUYW3fVUp6kCS2NhsiVs8TAXsQrNWmH9OxUSsT37FWQf3W9ZgtSSppWwiRbDzWmRI2h0kOfzIh1GPb/bN+sliupgoiD0I/lebJR/zMr2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB8772.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 22:31:40 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 22:31:40 +0000
Message-ID: <86c106f9-f968-4423-a81e-7377989321c5@efficios.com>
Date: Fri, 9 Jan 2026 17:31:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20260108220550.2f6638f3@fedora>
 <da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
 <CAADnVQJMa+p_BcYxKUgve2=sqRBwSs3wLGAGhbA0r6hwFpJ+6Q@mail.gmail.com>
 <20260109141930.6deb2a0a@gandalf.local.home>
 <3c0df437-f6e5-47c6-aed5-f4cc26fe627a@efficios.com>
 <CAADnVQLeCLRhx1Oe5DdJCT0e+WWq4L3Rdee1Ky0JNNh3LdozeQ@mail.gmail.com>
 <20260109170028.0068a14d@fedora>
 <CAADnVQKGm-t2SdN_vFVMn0tNiQ5Fs6FutD2Au-jO69aGdhKS7Q@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAADnVQKGm-t2SdN_vFVMn0tNiQ5Fs6FutD2Au-jO69aGdhKS7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0145.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::11) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 301191dd-bf98-4d68-e965-08de4fcedb97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YktVRmluUXlBZDdsaTF0NFI5eWNSV3pJVmN0THZKSFJYS09rOG9sYnpZS05l?=
 =?utf-8?B?VFJuakJOWFdXTmFYL2dkTEMzMjhjaXZUUlc5Y2RvQmwvWDVNeDByRTBxZzBq?=
 =?utf-8?B?WWVBNFV3Y3pzZmI0Q3ZIR2tQVE14cDBlbFdWWlhObjlWSFk0MHpDSkhZU0Vx?=
 =?utf-8?B?YzJ2T1pKS1RiS3hEaWZwdW1ucnVFa3VMNXFSWVpPNXdwT0gyNnZ2SmJEckFO?=
 =?utf-8?B?Qm5oWk1oL0NmTXFSbVFLYkM2aHovQWFWYXFEcmxTUUptZ2lpNTc3UkE5UVoy?=
 =?utf-8?B?Q0krbDV3RFpTdzFIb1pRUk1YUC9LczJRMktqMWlNWW0yQ2hpZmk5enJYeGQy?=
 =?utf-8?B?MDFhZDZaWS9hMXZabVBFeDkzSHdqZ0pHeFBudktiRTY4QlJLZk94MGlZdlRD?=
 =?utf-8?B?c1UrZmRpRG0wajFwWTBEM3pSQm54OU1pYWRMQkpFd1ZGeFBzbmFTdHlPOGtJ?=
 =?utf-8?B?UnBzVm0zdWtnMDBsOXhKMGFLenFKTWRqZGsxZ2JOTW5XQ1hwMXpCUXNWZWFx?=
 =?utf-8?B?S3RSVHg3aWtLRWVCdUhYVjRCT0xDeEVxMkNUQnR1amJtcU5JL2MvaXdPZGdi?=
 =?utf-8?B?NkRjNTd3VjZqTWVrOG5IVWt3U0E0N0xrdlZ4LzN6T2F5MlVsaGFuR1Y2WkRV?=
 =?utf-8?B?TmRMaHpPaXJRcWZhM0xXcTJBNHNkOFhrUTV2QjdkZ2d4UlZwMVk1NVBhNVVY?=
 =?utf-8?B?dHhNVEJwRzlKWE1GSW5zNlpENEFiVTRmRWFwMFcrMlpoWHN0c3lTQ3o1RWFR?=
 =?utf-8?B?SjBTMzVLc3ZlM0RxTjhJaVpvWFJyMUFUdkphNU9LeW5rdkRoYmZEZjFNK0pY?=
 =?utf-8?B?dlRqZm5IbnpjTWpXd3pwWnVBR1BVOHgxaldvQS84Z0ZCb2lYdTVDNWdROFhF?=
 =?utf-8?B?N0RaRVBwSVZpVzJuZURPS2hXbitOdDVtV2JlWnd2YUVrNGplWFptQ1FYZ01k?=
 =?utf-8?B?YWo1K1EwSEVyNEJyaDVCS2t2UVY5SGJzUkZMc1NKMXFlcmJBYk5XbFZGUXEr?=
 =?utf-8?B?NXI5S3ErUGZtM3Fab1QxclVkVVpDUlVxTUJ6QUZsMk1MNUlaVHhFVzNsWGU2?=
 =?utf-8?B?NXlhbURUY0tOSFQ2WWdQeUNHNENNWTIxRCtVMXVPK3BLR3JtVCs4SXRvU3Jn?=
 =?utf-8?B?a2IrOHpxSUJZRGFmcUtFeHM1cHJ2VThld04xcXg0MFpxRDJhbnBlVEtLVk9q?=
 =?utf-8?B?ODZ1Z3pYRWxxS0NTQk5uZXNyck9vTGZlZmhuZ25IdTF5L2RscDJDc1VsemRZ?=
 =?utf-8?B?U1ZwM3ZoOG14bFYwemNnQ2xvT3RzOWZhN3UxU05GQmFmNzQyVFlEVW9GdDNO?=
 =?utf-8?B?ek0zSnBaV0hhdTB5cFJidkJaRHhrS3puVjFCU3d4UUN6SWV2Sk9KUTZDeGh0?=
 =?utf-8?B?WjNNTzU4MFFzYlhNc2ZjK3RucFRNZE5lOThLM1lQRktJNmhkS0tuSmtOdTRO?=
 =?utf-8?B?YW5wR2swdGMwVlVZRFdwNHRPeHR1ZGRzM3Z4ZDZVWlFybDZTMlArc0lXb2JX?=
 =?utf-8?B?Wk9kWXhhaWdEYVJvOWtvbUkwWEJLcnBoNWRmVnZsSGxqWkMwVWlSdGVDcklv?=
 =?utf-8?B?aTFDYXNuR0R4MC9tWEc4dkd1SDhNb3cwWFZBQXI2clF3aEI0SnlTRnR0V3Ja?=
 =?utf-8?B?S00xRUp4ajUyQlpJb2pucUdobk1EZXY4WStKVUluMGlzMWxoWXlmRzdDZGlz?=
 =?utf-8?B?M2swNWpzZDg3Q1AwSE1LYTZuVDR0VE13VUF0cmYxbG9QNUNQL2k1dHRDMHpt?=
 =?utf-8?B?SkN0ZmhXSVZvZ1lkR1RWMjloeGllTFFWMWxWM0FlTUtaOEc2ckFoM09NWVMw?=
 =?utf-8?B?dkZDSlFqSSs2VkxoUHh1NTRtUE1KT1dEYnBxUEg0emljS0JsYXlyYzBHajJV?=
 =?utf-8?B?TGpodTdDelU1U3QwOTFhRUZyVGN0V3JlZktQZ0VKLzhxb2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck40Qld5c2RaeFNKRzRwYWhYb1pRSjRzNm9ldHpacmt4a0lSdXJvMWVRNnB3?=
 =?utf-8?B?SEl0eVM0UDQvWkJwbk5JV2FtdWl3Z285SDdEczA2aUFtZWdWNlNyQmVIR1hx?=
 =?utf-8?B?OVZ0d1dhaGx3N2kzTEd4OGQxdDhFUXQ2cm1SbTBNMFNITURkYTRoUVZGT2I0?=
 =?utf-8?B?NDNtYndQNnZMUzJ2OThtbTJ2N2pNcVVSK1NpOFZuMmVjbVB3TWQ5UTFhc0FB?=
 =?utf-8?B?VzZtcXIxVE12QVZJVjlqaEdFdVRUaVY4cU5SRnoxQ2dsMTdrd2xrektmeE9y?=
 =?utf-8?B?ZGJyUkdnc1N5U0ZUR3NmelBWZFNSOUhEWnJXemhFZXFzczRYRkhNR3RXVUp4?=
 =?utf-8?B?ay9DeHU0VDhYVDEyNklLMkJRVk5MU0d2NDlTb2Y0K3lzMU9VVDRhc3k5UEs4?=
 =?utf-8?B?Tmh0RUpQTUZwOUJwLzZsMW1DOFRIczdJclQ4N3JZMXViZjVCcnN0cDVlakpr?=
 =?utf-8?B?NllMaXZ4TUR0YzROZWZ3aSsvRUozWTJTN1RPODhVVTQxVHl1TytRZmNNeHhD?=
 =?utf-8?B?MHZYS2lVRkFKQTBqUmtGQS9lb05ub3hzSGQ5Z2pacW5VdWdBbkc1R2p1bnc2?=
 =?utf-8?B?WGw3alRIekpySnBQYXcyK2s2M09iNm5WQVJORWJnalRCMHpxaGlCbTBlSWVh?=
 =?utf-8?B?K2djZU42dGpYMzV5Szl0UkxJTnhOOEI5NnB2TjdndzNJTWdiRTQ1S09OdW00?=
 =?utf-8?B?UjlCVHB3R1grU1FoUnE5MFNEamt3a21zV0tNTHd5WXREZDBIb3hTRGVNQnhw?=
 =?utf-8?B?dzJTa2lNUXBkRmZWYytFWjFKSXR1dkdoMjhYaUF2b3RseWtrVlR6d08xMzVt?=
 =?utf-8?B?OWI4WlFMKzI5WUFDbU1UZmFaQUVibVlGS1k2SWtOQ3VYZXh6c2JtN1BKbElH?=
 =?utf-8?B?cHBXaDJGVnZ0WXZhdFFYcmR5Q2ZBWHh1eXNmUUFsZEZqRzE4SDRjZDR3NzMy?=
 =?utf-8?B?VlYvaDZocSt3SnZneVVMbzdTMlFxUjNoZkZnM0diK0NLSTZhb0xZMllQaWt4?=
 =?utf-8?B?VVZTSStNRlFHSGl5ZHh1WVp1TUtXczlHNWt4NGtRQ29acFRKL0l6dkhqdVBF?=
 =?utf-8?B?ZkNIL1AwVFlaa3dNNWRVY2FVc1ZrZjI4N01xSTlSM2kxNmk1VkZjZUd3ZmdS?=
 =?utf-8?B?RllEamc2eUZxdjNVNzA5T1hJdUpNL3N6eHBGcHorVURWbnNQME5pUGNxQXBq?=
 =?utf-8?B?S3I5ZU55VXBMeGRHV3JQS3dCTVhMTEN6Rm8zR1d4Q1NxekYyU0FGSEN0RVlS?=
 =?utf-8?B?anZsSWxMeit5Y2Rmd3VIUFlNQ3dNZXRQcUhLL2tCVitlZlJBYWVuZmdTZmlV?=
 =?utf-8?B?c2NsZlhTMUgzckRXWFVHWWxQenlJdE1pSktwbDFTZHE5N0xVaEE4TFlWbWth?=
 =?utf-8?B?L25vNnB4Z1RGMUNBMSs1aHlKaVNCV2liVG80b084S2UzdGVCeTAvRVMyOC9s?=
 =?utf-8?B?VGhCSmFTN0FybzQ0RjNCakw5MkYxazdJOEJwMkdXT2NZZTlSdjVxdmdSdXg2?=
 =?utf-8?B?eDNlQWRUMnA1UHRieUl4OGx1MTNjQkEwTXVJSXNhZDFMUGxHblpvMisyWVJn?=
 =?utf-8?B?bEwzMGIyWDAyZldKYW5obWVXWjc3Zlh2RVUyMENvODdyUndQbE5Cd2E2NEE2?=
 =?utf-8?B?UURIcC81bkdQWmptaTZOSG5pVGhSODBaY1FPdUlQdk5XdE5NL3JjU0w0Ujhh?=
 =?utf-8?B?YmlxaGN3SUk5NzZVOUc1QWtzQy9UemZScDFIdHlVenB6QUZGeUpJTnFPenZE?=
 =?utf-8?B?cHpDQ1NOeUtOdVQwaUNkdDF2NFVDN0E4aDM4Q0lZS3FneitKRzhqdmx4OFRO?=
 =?utf-8?B?QlpmaXJVZko3SGk4cmJsdjdoK2RXQTJqY1ljMzNDNm45TVFPMzdqdU1Ib1hR?=
 =?utf-8?B?SGh3WXNNMEhkZXBsRFF6VStZeDc4YzBUR29CelVJbm9sdTRCZWg3Njk0b3N4?=
 =?utf-8?B?Rjc5c2lvZVEwaC9JYmNRYVJzai9rV3pRaEFlS1FMNUpUVXhCWWFWK1dkOWhD?=
 =?utf-8?B?WHd4cVAyR2ZmdUE3YXVMakJxNGEwbGRvdlpndlhEM0ZSU0d5cDFZanZSK011?=
 =?utf-8?B?UkhBdkdvVU4wdUYrRHhmWmpTREhpY05GeXExdjg0ajRPdXNyRWpyMEpZS2w2?=
 =?utf-8?B?blFtYlZKdHh0WVU3YXVqK1FZL3A5Qk83bDg1SnhsTGRWMldnNVNhQTh5ZWF5?=
 =?utf-8?B?K3dVcmtnZW9GeVlyUGYvaHZ4dFZoaUJXTmhrYXRLMlNzMmFQUVlDMWttRlA3?=
 =?utf-8?B?STM2dHlud0wvc3dWS3JnTXZLV09WK2QzcURFOFIrSUFTcjNUYUN2RnZFZU1B?=
 =?utf-8?B?alZYWlFwNGRuNzBuc21tZldoamZHdERLejFiYktaVVhMRm5OTFhDQlJzaDFJ?=
 =?utf-8?Q?0UGfP/UnUtJ5fl6eupC5w+0hRxl5BZ/830S1O7schMlMm?=
X-MS-Exchange-AntiSpam-MessageData-1: 9LRvIEHcK4RWDJaKtEheGboy9CmS6cQXWh8=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301191dd-bf98-4d68-e965-08de4fcedb97
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 22:31:40.0224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCabRMOONbC6W6JjUgR6dAyqGxKFvKDP/+SA8FeeL/KEw9Jd09ixGHTFP1rhUwdUO6Z7VN5cuTPdEumNVdUrB8ZEPRLs9KQbQd0LRPjf1dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8772

On 2026-01-09 17:18, Alexei Starovoitov wrote:
> On Fri, Jan 9, 2026 at 2:00 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> On Fri, 9 Jan 2026 13:54:34 -0800
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>>
>>> On Fri, Jan 9, 2026 at 12:21 PM Mathieu Desnoyers
>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>
>>>>
>>>> * preempt disable/enable pair:                                     1.1 ns
>>>> * srcu-fast lock/unlock:                                           1.5 ns
>>>>
>>>> CONFIG_RCU_REF_SCALE_TEST=y
>>>> * migrate disable/enable pair:                                     3.0 ns
>>>
>>> .. and you're arguing that 3ns vs 1ns difference is so important
>>> for your out-of-tree tracer that in-tree tracers need to do
>>> some workarounds?! wtf
>>
>> This has nothing to do with out of tree tracers. The overhead of the
>> 22ns is for any tracepoint in an in-tree module. That's because the
>> rq->nr_pinned isn't exported for modules to use.
> 
> None of the driver's tracepoints are in the critical path.
> You perfectly know that Mathieu argued about not slowing down lttng.

My argument is about not slowing down high-throughput tracers
on preempt-rt kernels. This affects ftrace as well as lttng,
so both in-tree and OOT tracers just alike.

Are you so sure that no tracepoint instrumentation whatsoever can
be compiled into a module which is a critical path for some workload ?
That's a bold statement.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

