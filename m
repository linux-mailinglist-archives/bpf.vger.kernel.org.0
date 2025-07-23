Return-Path: <bpf+bounces-64219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8369EB0FC33
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 23:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5EF61627EB
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 21:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36D5270574;
	Wed, 23 Jul 2025 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mX5w0zQF"
X-Original-To: bpf@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021130.outbound.protection.outlook.com [40.107.192.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13141207DE2;
	Wed, 23 Jul 2025 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753306827; cv=fail; b=H7lKHYgPf2hyI7W0ieJHGt7jQg5hLL9oxL1YDmTZt70dXxHIsO7NkCouU/A193KrBkeGd1rpKROodTL+I/yuyhE3n2+cHce+d9dTq/hqrv+F/1YCjSXkaeRo4nqkS73fNXxEZT0i0v3Sl5nmuF7oqKTIlbpzRgnLdaQJa46nKEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753306827; c=relaxed/simple;
	bh=MuwaMlLe1pqdoXKgo95oN66xVGCc3ToIvWxr4ZEKigI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IFBpcTFQR9qwixSgQy50OfWaBp/RG8ZuPkqh8UOyszL5EGm8cVhc7p7sXqs0nSdyLpsk8f5ydCkXispKa/OumGQKqhGrxKRuIohjgBQH9v8k2TINCrnX3ZdoM118+MjqPryX4qQzwdqRVXQgerZOosNrD0rJVoW7KOqJCmdPBZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=mX5w0zQF; arc=fail smtp.client-ip=40.107.192.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G36NTxQIQhtfJqxnGwky0x8O+yHaQq6tLpxRaeqFckx7EX8hvgSMhygHjyGQe3Rng1Xw3uog86iGc9TjrdQ+pxv7tOaIkbiMS6LHqlUvYJsWDJMw3y1sjD/dtBqmy/x81mZ04xnJ+0HTtBD1msRhXYhlBljJaxcUyeGIDqkSTPDax3vCiUE4zwQmxocdx/heEplCoYlvtBOjCzx7cpu9ZVsdSBzu4Ifv3CC0xPhC/tLegtmFPkdYWXlrjxUT985ZpsDnv2ypmqi4d+yIfj+M87/tMrjT7XAvt+ZxlNbPQqfSMGIoN8J+XbcwPYFmoJ8Ra1vABLxz1GfbCcpEgqM3dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNEVZlfKK9lMHLyJ4sVfEiXoJlCFXqyjA7dbIZaXPS4=;
 b=aJb999uphEN5YY9f0gnACBvmLmrFVj0pgfpnB6fcqDUOkcYU8u7k9GwphLST25iQGMiROfItmtFctW7mhNq06ZsBtBb2mmgn3KEjbF7OPVm+EbGDt9f/75qeM01ItYhZFPuuGALGlGb/tKjIIPof1k+IKkphstNEgG9Ezaq7iS+D7XnpagLih9IeCdZvhrIeOyIcx2sHT3LCmHVrz4Pkl5U+wgwlgCNl7xhx1qUqhafAZz1kBEFS8PuYpRlZuSD32kClCXDPcIMoUCoNnpHBjcWiY7t0sraSpxRIAqr80fvt7rA55ZlAVHQXvjN0NNdL4iA5HC95Pp1tLZv9E2R8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNEVZlfKK9lMHLyJ4sVfEiXoJlCFXqyjA7dbIZaXPS4=;
 b=mX5w0zQF6dBJeM5y+8xIr33l3AD4ZFhZjiURaAdJH9IRj/aDpKWdd9CRneCbHdfMIosXq71ZrRxRmDS2+AkRGCe5iWThH5XzVCc3AQcEw/79Crze9QlAG6hwr1f5KZO/bnbMwecS36LGolkuUGiXRkzk8ERotaxYLhfCUiNft73SZTWAy1D+RM4GHgrazKdDyAyUacRo8tJOSesFmxeVM1ejln0ylHFC8d1YJPUhrW9kOmGVS0iIwFJ3vdu3H+9wER/im1woAoffryzeiZIzK/mwG7nuzGJ9ZNihFGNm2vt13XgywrSbFAZcT8BN1CBTZ+ZwY8JNsGXB7ByA1tbV+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB8412.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Wed, 23 Jul
 2025 21:40:21 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 21:40:21 +0000
Message-ID: <020d22f0-a95b-4204-a611-eb3953c33f32@efficios.com>
Date: Wed, 23 Jul 2025 17:40:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
To: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf@vger.kernel.org
References: <45397494-544e-41c0-bf48-c66d213fce05@paulmck-laptop>
 <20250723202800.2094614-4-paulmck@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250723202800.2094614-4-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::38) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: 5896d060-a03c-485f-5f79-08ddca318685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkNseU1Ld3czM0hpRVhQVS9RcS9PU3NxWEpTck5oNEw5VGRPWmFhQURHZndZ?=
 =?utf-8?B?ODF3UXQyd1lTUkxrZnBuYW9lWlN2VllzZzcwSG5TenRQdGVTNmgzNDdpN0pa?=
 =?utf-8?B?UGNEc0JESzJ1eHBjdDJhbElRc1FWVnl2Mml6TjE5a2hITHpRMUJlaXZRNUl2?=
 =?utf-8?B?RUhiT25mYUtKNWRUNTFmQ1FzWlp3eHJzK0lrV09VdHJLM0NKYUhzN21PNEV4?=
 =?utf-8?B?VXEyWFAwZW5xK0JIdTlJeTBFVjBJRzBZL0dxVU43TzVQRGxvYk1HTE9yK0dZ?=
 =?utf-8?B?MW5yMVMySGVyZEwvaVZpb1NyRmtRNm5VczVyeDhOcERoTWRqZExsZThZdFht?=
 =?utf-8?B?VkxBSnFKeXFsZjZJMlMzVzJkaHduTHFYYWFWRzlyWm5nUUhWczNpZFM2ZDlG?=
 =?utf-8?B?ZlpUNE02L1h5Q1oxUnM1L1p3MHNIUTNTNTMrYjZDcEE1SFVodTRkUFI5S0Nn?=
 =?utf-8?B?ZE9ESU8vRDlZK3l6dkY2OHVRd05TUTh2eFhyODVLVHpkWGJWOW5mcS9PT2tY?=
 =?utf-8?B?VWxCWmJCUWJQc0owNXV1SDI3ZzVoWUdGL1NHaTF2MElHTFRNNFlvMHJDMFJQ?=
 =?utf-8?B?VUJyS2R3WGVxZGlPNzFhajNCZnk2bDNwYkR5RVZvT0xtMm1LaFNPUnNsVnNv?=
 =?utf-8?B?d3lhdGFpOVVkSHRJVitEZmdHRW1aUFNhdjFPempkcmp0K0Vpb0ZVUzVoaWhu?=
 =?utf-8?B?L1ZuOVVneG14VXlYZmtsZjJ5M2hqaVFIamYvYW0yTlV5RnVYUXYvYlE1UGc0?=
 =?utf-8?B?bC9XVXpRWWtqcE9WZ3M4YThLTXg2U0drbDBjY0F4aWJnTGh5Q3JlTXA5ck1K?=
 =?utf-8?B?cEF6eGNQYnUzS1djSGZXRnpsNHhQRUhFQ0dLd1daM2p4akhjZXJiUTZ2aWZp?=
 =?utf-8?B?Unk1aDVyMzdsdTVMR2dqOTdtRU9rZnluOXhoVG1KcmVCTWJRVVNkTnNtS2tp?=
 =?utf-8?B?a1BqVndha2ZJaUljdmo3bklIYmRlaWVJOGdNRjQvVFdBK2QrdEJ2cHVQZ29N?=
 =?utf-8?B?M2U1SE1FeUNJMDBDSVp5UXpCTFBGNUlrWFRmY3ZuSE42MTNrVGtKdkk0c3hP?=
 =?utf-8?B?MkxHM3hMaE5rYTNFZFpZWkcvTDRKblZqR3RJTThZU09MWDM0djliRW9udWM4?=
 =?utf-8?B?MWlNWEUvcjVJTjlSb0lBT3UwTkxtOWlCOG02a09yQ2xtYjNJWHVEQ2pXYloz?=
 =?utf-8?B?SDhteWgybU41TG92T0UvUVhWbVhvTHBUb0cwUXZzemdUTW01Z0E4ZjBtL1Zv?=
 =?utf-8?B?WU1CSkJqcWExOGJ3ZmRpR1JMWmJNQVc3cnlQNFhzcHZLTWUxR2JuMS9Ca09m?=
 =?utf-8?B?RkhmblE2SFE4ZlFHNHcwTk9zR3Uzb3BXRzMxWXpEOTB1ZTZxZnEvUkIxZEF0?=
 =?utf-8?B?UjIxYmpYSkNyUUpLTE9kY3VVY2JwdWJUblNsSm0rZmN2TXJ5T2hPMk9oT2Fr?=
 =?utf-8?B?dy93U1BJYlIyV2NhUHJscnpkOWpRcStDWlFsMjE0aVowU280ejV0RkpNM0dh?=
 =?utf-8?B?Vm1JUWx3USsyOGd5aTI2Vm81Ky9LUzB1elBrNk9LUlBneGIxUVdjSU4xUlFB?=
 =?utf-8?B?V255ZlpaVWhCR21LLzZGYmJ0MWFKczY4djA0TWJYNWFTd1dUd1RUN3l0S21U?=
 =?utf-8?B?eEdqY1UvdUZhaXdVZXlPcTBBRHFDVk82N3YxWW53VG5hZzBmWDMwUHdxelpj?=
 =?utf-8?B?alE3VGgvblFyb0JwY1k3bFg1UG02bGVia0pQaElSVnFPRWNRQlp6YTIxVm95?=
 =?utf-8?B?TE9HTW1VTE1LdFFsTnE0UjNPR1dXWjIxK0doZFNjRWkzZ1RMNnR6WjZMWHVE?=
 =?utf-8?Q?tTrH8tupFm0g1qkggAS10YkJxL5qe4hhzodF8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTNMeEI4NUpSYUJ6ZWpRN3JneldzL1dPMTVSV3dDYUM4S01rdFFrb3JZdENi?=
 =?utf-8?B?bm14eXU5ak5jbFcyb2gvbEY4WmhRL1E4Zm9sMEc5S0NjajBFeGdzdVFVWElw?=
 =?utf-8?B?WGMrZ0ZSTlozWVVkSThiZkFIcnlNUHNPVmZMRjZsWVFMaUVOSzRSUDFMY2tk?=
 =?utf-8?B?SGVzTmE5TGUxSFQxRUJzdnllei82SXA0cnk5TmdGb1N3NjN5eUtOSG04dkta?=
 =?utf-8?B?eFpuQkkwaDVyVzE0K0gvMk1pSUJ1TkhNYlJiL3k1N244QUZqcHNJL1BaNkda?=
 =?utf-8?B?UE1DeDRPK0w2R3FtaTJFVUVYMHpPSmlwZXJpRmFMWWZZTDZFanFMLy9aQi9y?=
 =?utf-8?B?bkw5OWIxaWd0dk5Ba1JicWVTR3B5dkk2ZXJlaHJHUDNWbHVrdjcwYjZjaTlS?=
 =?utf-8?B?QWtqUG1FVmV5M3dSNjIrZFlkT25QekFPOHN3SW5ma2tBb0sxMnArdW14Q2ph?=
 =?utf-8?B?VFo4SkIxa2NJUE5LdjF2QjFtNjhWUHZLK2ZwQ01iQ3dRRE1HcXJPR3JVclpJ?=
 =?utf-8?B?NFNOQVFPOVE2cGJsaVFaMlZpblRURmU4S0dmQzdObmpZeVlpR3VtczUwVlNG?=
 =?utf-8?B?OEFVOVVaajI3WGlmY3RoMmxjYk8waGphM3lyOERtTWEyZjMxaTdhWkp0c0Fh?=
 =?utf-8?B?M2N1YkhwTFZOaWlia2tmb1dxeW1sU0hWb2g5V1RMUS9nSUpKeDBEV05JU0Mw?=
 =?utf-8?B?enh5dE1XVkxYMDJvRTFXNnM3MUc3Nm1ka3Q1VGdNbjZzbnhRbkdoR04zbWFy?=
 =?utf-8?B?SFhGOENkUlNHdnRtdTdsVzJlbHB4dEsrUEZqZFlQb0YrTHllUTh4eGlXZHlL?=
 =?utf-8?B?L3JGdXVRS0o2TEJqVmpIUE9HOVU1bG5laHRyVjg3TXIydE90amNjdzhrK1J5?=
 =?utf-8?B?cWUwZGh0ODBoclM4WkwrSzlndktSYzBzRGJTcFRkaGx6cVZxYXNOK242aUpp?=
 =?utf-8?B?ZVljcFJNeXR4RENNOFg0N2ZKZStUVXV6UU93OXpkeS9DZFB4ekxCQ2lyL1lt?=
 =?utf-8?B?MGJzaXlWejVSMnR2NnppKzBMTWlCdkxWR2orV1hXWUZzazJCMFFkQjhqbStr?=
 =?utf-8?B?SElCSmVaaFZtTnI2S0dERE1VNXRDZnZKWTBjbTZDTHlQTHU3a0dMQ1EwQkt1?=
 =?utf-8?B?TE56YXB2clJ1UFlCb1FPS0UvTDRhaWltc0RlVlNzbHQ1Qjl4aEQ2NnErUkFr?=
 =?utf-8?B?REhyY205Y2hrS3VTQlREeHhvSGpLU0I0a3lsdEhoTDVhUGJIOEdSamFBc2V2?=
 =?utf-8?B?dWFSU2JIQ2puZkZBeCtlWk1wQzVieVRDSHR1d2Z1TUdlNkNENENMczVWYWli?=
 =?utf-8?B?emkzWFRybVdac3VUZ0VYOU5iR2Q1Y2Z1WkxoR3NhZk1zQmNEcDJtZjQwOTU1?=
 =?utf-8?B?WnY3UG5IU2svMklTNGI5b1N1K1dlWXRzTm44cllwR0c3YnpyZmNoQ1JmT0Vm?=
 =?utf-8?B?cWdORGxuQ3pNd0lCMkNwMHkzaDVya09VODc4Y2FwYk5BQ2hSNDQyWkovaUMv?=
 =?utf-8?B?aUt1Vk03VmE1dGlpOElkenU1RTJYNStxRjk4eFl5TDQ2VkVEa0RXQVlzMmFq?=
 =?utf-8?B?bkpuZzhrTkU3bkttQTBIV1M1SkJtaDFRak1MNzVHbHJFcFFvYUptcUZ5aFpZ?=
 =?utf-8?B?NHMreVZhckdmaTdPQ0FzZ2x2bVd5SnEreSszSUdUYllJWjY2S1hqT3I1N0Fk?=
 =?utf-8?B?Z3JIS3pzdkhYMmo2MFV1RzFrMjhRMmIyVmErSkVpaFd6MVhzQXhyMUQ3Qzgx?=
 =?utf-8?B?QkM1bGErWC9BekFrSkxma2p0K0RndHJQbXdVNjFCWU5qMzRYNkk3bk1QWWx5?=
 =?utf-8?B?bG9ORDczOWEvZW5JY25GYjFadTVtV2dNbjcrK25WbVFrN0ZKYy93OW9PbUJa?=
 =?utf-8?B?eEsvWnBjeG56YW0rQTRTM2hucEl5SUU0MGs4V2xqTUFZSmp5SHhTZXk1RVRG?=
 =?utf-8?B?SW5oVnZnaURmSUhJdWtheUp5YldmUUVzUzhiMTFTWktKM05IU21nMHdVbWRX?=
 =?utf-8?B?RHB2TlU5aTUyUG1mUGNDYlN1OU5kTjExY2s2L3QyY213R0lrQzFQNXpxeklQ?=
 =?utf-8?B?aDFld25UMndIWGtnNWs5YjViUG1JcElpNkpyVEpiRFJIMG13WjZibmxzYkFD?=
 =?utf-8?B?aGtFNUlGVlBGQ21BeURtVnU5Q0RRWHZka3pzN1lYemMzU0RXdGNLQ2loZ2w3?=
 =?utf-8?B?RjR3Y2xKWEExMGo3OUZwN3ZoNXZPNGE3akxuTm9ONEtoRTk1VDl6ZXJWcmUv?=
 =?utf-8?Q?0fb7RjQseNZ+8+8CP7SGJ8eBdqkDA5OGKek7bhu0Qw=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5896d060-a03c-485f-5f79-08ddca318685
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 21:40:21.6606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x48h3SS4B6udQYSb4ne+BSTeRAQ21tzq6soKbuhLPBTIrcgGWjxYV3yTOk7+I9d5OUIy2fbZr+vMN8ryq79ZnbAFEm9/SLMyMpSe5jy6G9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8412

On 2025-07-23 16:27, Paul E. McKenney wrote:
> The current use of guard(preempt_notrace)() within __DECLARE_TRACE()
> to protect invocation of __DO_TRACE_CALL() means that BPF programs
> attached to tracepoints are non-preemptible.  This is unhelpful in
> real-time systems, whose users apparently wish to use BPF while also
> achieving low latencies.  (Who knew?)
> 
> One option would be to use preemptible RCU, but this introduces
> many opportunities for infinite recursion, which many consider to
> be counterproductive, especially given the relatively small stacks
> provided by the Linux kernel.  These opportunities could be shut down
> by sufficiently energetic duplication of code, but this sort of thing
> is considered impolite in some circles.
> 
> Therefore, use the shiny new SRCU-fast API, which provides somewhat faster
> readers than those of preemptible RCU, at least on my laptop, where
> task_struct access is more expensive than access to per-CPU variables.
> And SRCU fast provides way faster readers than does SRCU, courtesy of
> being able to avoid the read-side use of smp_mb().  Also, it is quite
> straightforward to create srcu_read_{,un}lock_fast_notrace() functions.

As-is this will break the tracer callbacks, because some tracers expect
the tracepoint callback to be called with preemption-off for various
reasons, including preventing migration.

We'd need to add preempt off guards in the tracer callbacks that require
it initially before doing this change.

I've done something similar for the syscall tracepoints when introducing
faultable syscall tracepoints:

4aadde89d81f tracing/bpf: disable preemption in syscall probe
65e7462a16ce tracing/perf: disable preemption in syscall probe
13d750c2c03e tracing/ftrace: disable preemption in syscall probe

Thanks,

Mathieu

> 
> While in the area, SRCU now supports early boot call_srcu().  Therefore,
> remove the checks that used to avoid such use from rcu_free_old_probes()
> before this commit was applied:
> 
> e53244e2c893 ("tracepoint: Remove SRCU protection")
> 
> The current commit can be thought of as an approximate revert of that
> commit.
> 
> Link: https://lore.kernel.org/all/20250613152218.1924093-1-bigeasy@linutronix.de/
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: <bpf@vger.kernel.org>
> ---
>   include/linux/tracepoint.h |  6 ++++--
>   kernel/tracepoint.c        | 21 ++++++++++++++++++++-
>   2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 826ce3f8e1f85..a22c1ab88560b 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -33,6 +33,8 @@ struct trace_eval_map {
>   
>   #define TRACEPOINT_DEFAULT_PRIO	10
>   
> +extern struct srcu_struct tracepoint_srcu;
> +
>   extern int
>   tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
>   extern int
> @@ -115,7 +117,7 @@ void for_each_tracepoint_in_module(struct module *mod,
>   static inline void tracepoint_synchronize_unregister(void)
>   {
>   	synchronize_rcu_tasks_trace();
> -	synchronize_rcu();
> +	synchronize_srcu(&tracepoint_srcu);
>   }
>   static inline bool tracepoint_is_faultable(struct tracepoint *tp)
>   {
> @@ -271,7 +273,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>   	static inline void __do_trace_##name(proto)			\
>   	{								\
>   		if (cond) {						\
> -			guard(preempt_notrace)();			\
> +			guard(srcu_fast_notrace)(&tracepoint_srcu);	\
>   			__DO_TRACE_CALL(name, TP_ARGS(args));		\
>   		}							\
>   	}								\
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 62719d2941c90..e19973015cbd7 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -25,6 +25,9 @@ enum tp_func_state {
>   extern tracepoint_ptr_t __start___tracepoints_ptrs[];
>   extern tracepoint_ptr_t __stop___tracepoints_ptrs[];
>   
> +DEFINE_SRCU(tracepoint_srcu);
> +EXPORT_SYMBOL_GPL(tracepoint_srcu);
> +
>   enum tp_transition_sync {
>   	TP_TRANSITION_SYNC_1_0_1,
>   	TP_TRANSITION_SYNC_N_2_1,
> @@ -34,6 +37,7 @@ enum tp_transition_sync {
>   
>   struct tp_transition_snapshot {
>   	unsigned long rcu;
> +	unsigned long srcu_gp;
>   	bool ongoing;
>   };
>   
> @@ -46,6 +50,7 @@ static void tp_rcu_get_state(enum tp_transition_sync sync)
>   
>   	/* Keep the latest get_state snapshot. */
>   	snapshot->rcu = get_state_synchronize_rcu();
> +	snapshot->srcu_gp = start_poll_synchronize_srcu(&tracepoint_srcu);
>   	snapshot->ongoing = true;
>   }
>   
> @@ -56,6 +61,8 @@ static void tp_rcu_cond_sync(enum tp_transition_sync sync)
>   	if (!snapshot->ongoing)
>   		return;
>   	cond_synchronize_rcu(snapshot->rcu);
> +	if (!poll_state_synchronize_srcu(&tracepoint_srcu, snapshot->srcu_gp))
> +		synchronize_srcu(&tracepoint_srcu);
>   	snapshot->ongoing = false;
>   }
>   
> @@ -101,17 +108,29 @@ static inline void *allocate_probes(int count)
>   	return p == NULL ? NULL : p->probes;
>   }
>   
> -static void rcu_free_old_probes(struct rcu_head *head)
> +static void srcu_free_old_probes(struct rcu_head *head)
>   {
>   	kfree(container_of(head, struct tp_probes, rcu));
>   }
>   
> +static void rcu_free_old_probes(struct rcu_head *head)
> +{
> +	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
> +}
> +
>   static inline void release_probes(struct tracepoint *tp, struct tracepoint_func *old)
>   {
>   	if (old) {
>   		struct tp_probes *tp_probes = container_of(old,
>   			struct tp_probes, probes[0]);
>   
> +		/*
> +		 * Tracepoint probes are protected by either RCU or
> +		 * Tasks Trace RCU and also by SRCU.  By calling the SRCU
> +		 * callback in the [Tasks Trace] RCU callback we cover
> +		 * both cases. So let us chain the SRCU and [Tasks Trace]
> +		 * RCU callbacks to wait for both grace periods.
> +		 */
>   		if (tracepoint_is_faultable(tp))
>   			call_rcu_tasks_trace(&tp_probes->rcu, rcu_free_old_probes);
>   		else


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

