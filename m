Return-Path: <bpf+bounces-73373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8BFC2D9E9
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 19:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD1F24E80B1
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 18:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FBD1A8F6D;
	Mon,  3 Nov 2025 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="a35T0c46"
X-Original-To: bpf@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020085.outbound.protection.outlook.com [52.101.191.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E84217C21C;
	Mon,  3 Nov 2025 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193792; cv=fail; b=hcXlgDveZ6S3PcxpJH6auYKXuWoRGnwLuptYzsvUUevi03MiV46IQMPLQy9BJjLmZHuq+MgNV7S8OCXTC90iXcFUc1lXK/6K46L8TAQuggftqheJAgQQ1RA+mPcBe6wL1ivO8/EqcDoLof9AMcCJ3ZxUe9PHZRu66nkT2NfM/cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193792; c=relaxed/simple;
	bh=ZLjzPdiIlS19B6rLQqfrDc1+jE+HRWhMOd3LSfCrp0I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iBFXIBCVfVfAtQI6p91NTZfg3TcZOxKJglRakJ1NZC/bvgFaDQSUlSzc4geGajSo5O6m42St59mItMSCUTBTKahTnydFdFZphmllfYJ7/CPKLtZdqkeqHKiTTKy6dr7vy3skKbvf7ef5DievW5u0cmDKJJ/NJprmVnysptSoPbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=a35T0c46; arc=fail smtp.client-ip=52.101.191.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkrqKlOFl1KTNxLCZkpIEe2T2GR3a5P0No/UIk6lEXcmWAfsLUNIKr0PTXS7Fr+lmXWxZiay9TgEya52r+hyIOmYE26zwshghZWXMr23EdmcMZwze6T/7p3ZXPwDvML1HgiYSsczykfDxyI7bRYeQDXRulo3pQyv7J8ogsK+eMgIotbi3DjH6FtQfWQ0Cg6vLB4uGcMNQrB/5zspC1DkwiHi/I0XMaz8tbAyeHNeZHX3ls38ggCaO+cpmRSohftkFpJENZYgTrd513F/Z1/tOjQTJolswnnj/QpMwGckFddEklJVHyTTOjPuBeMzAKjaHS4+X7c/30MUP2gJxWM03w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjA+tCkVv7HMBopE4CROfapBNMNTcsB8iFYjRUDIDVI=;
 b=xJF6aPXS1EAtcur17GvS28TVCQU8aJmGPCkLvnBIY+TxmiLLRKSlLMMXz2rs+UovwMxX3dQqo0mOL48oRMbQpXSHiitJyiliG2HE8OgdJmMOfzqBRAYgd8ww++JvKXBUGsHaYDbMYSN6cIz40o1aKofHQuMrHAqGQ40haIRGaV6hH0/eHe6rjx9iR3rp365qRzFO4+8RFthQplsVSDn9E8ouORYWv448Ivpeu0phbdPgPyiOykhViMZfV3vNha3FV6/eE7JJaz4K7m1YgLRmpaYl/MjshTLFJ7RoXgil8QGONXbOOAvOgQpxEnhP0xs5VQpfOD2WSfChGmZ8JKw3ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjA+tCkVv7HMBopE4CROfapBNMNTcsB8iFYjRUDIDVI=;
 b=a35T0c46utUuk06XBVZNlbbjtYU/Et/qRmzQxkEo8NBWfnWURuA9ES6p+gCLFhOgfm5BhFZ4X3Tr8VmZTr3x+Lh4fuyUZUuaoAs4gALk+gpr2xOPHW0ZwfzFE5MtV78BRtf/9dMVJc8Otp30wkHyfKIuJ89+xmwO14hVeFdim0FayWV639oaxgW4LTnL6b8aSItlRk9xWsoCz264VsS0PhMl+y6sKvSQYHGonihlrPyWcWyAZbIwjNkDnp49sCS4nu/4RcwQKVr8cYe6r6POym7jHW5d3Y3q+FLLF6Q5Qr1Qur68De/MyLJKyMNwdZrKTlT0akVAQKKGJXIPUlalgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB5959.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:36::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 18:16:24 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 18:16:24 +0000
Message-ID: <7cdecba1-2b30-4296-9862-3dd7bcc013d8@efficios.com>
Date: Mon, 3 Nov 2025 13:16:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/19] srcu: Optimize SRCU-fast-updown for arm64
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 rostedt@goodmis.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
References: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
 <20251102214436.3905633-17-paulmck@kernel.org>
 <b2fb5a99-8dc2-440b-bf52-1dbcf3d7d9a7@efficios.com>
 <f89a3a56-e48a-4975-b67b-9387fe2e48c6@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <f89a3a56-e48a-4975-b67b-9387fe2e48c6@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::28) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9db93c-b335-4394-1002-08de1b051917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rk1sb0ZFbUhHVkNxUCtoNVllT1Iwdm8yL3hQclFpZkVLMjcxR1g2Rm0xbmNF?=
 =?utf-8?B?WUd3OHhyZEVac3VublN4dSthMWFJQXhiYUVVSHVtcmQwNmRrL2JybkQwdDZD?=
 =?utf-8?B?bW5vTysrWENqVVEwbzB6NVNHVFNXOFdNcjhIK0tKUjNTK2M0SU1OdmNGcXl3?=
 =?utf-8?B?b2hoMUtteDZhb1dkZ1dNN2E3QnZ5UU5TZmM0ZG5rQzFPbXB3Q0hmNUxadE5y?=
 =?utf-8?B?MWNDWkdSbWtvN09qbGpZSFBnZEVabkhoRGhhNU9zUC91cDd4NFRPRXF1RjFB?=
 =?utf-8?B?UTlOeW5UT2dKajJadjgwQk9GdzZDRFVWdk1CamVwVks4VEpZS29tNGJ1Z0xx?=
 =?utf-8?B?SmMzK0Ewd0JWTS93TDNabDI5aVFwV1hKNHk5WTRhODNYRyt0eW15dVNkN3dI?=
 =?utf-8?B?SDZoZFJTSmJYTlp0emc1aGFjMjF4SjNyMVZvVVNwTURVK3lVQkxoa0FXSjhI?=
 =?utf-8?B?ZHBjN3B4djhJMlJYM1B3MnJmSjFZNGhnTndmNFhkSDMxU3ZSeVhrYjRWRGpE?=
 =?utf-8?B?ZVRGSE9CeFFpaGtTZ3RDcmZLd01MZkd1dnZjZDJPbzF3QUlyTWdpMkcrME1h?=
 =?utf-8?B?Ykd6TXdkeG92aXBvcm9PSjk4VnNzdlhEb3B0Q1JMK2VyS3ROVjVuWmM2N1dn?=
 =?utf-8?B?d3JXWU4xNnphZDFHSzcwTE9kOXdxSElaUnZDRm1Rcm51b1h5b0ljYUtPMVhw?=
 =?utf-8?B?U01kbFVQNEEybWNsdjc0R1lteW1vZm5RdndhQi9Dc3BDakg1eEg2U0xEKzI1?=
 =?utf-8?B?MTZ2S2NXc3lIWmxoZ3NOcVkrdmYxOFk0S014bVBhZWJBeFFpbUx1R2Q1cVF4?=
 =?utf-8?B?ZUtlaHp4NzlQWGV0SlFhWFlMbEZRaTVUODBjeEhRWFg3QVROVnIwdWtBalZ5?=
 =?utf-8?B?RUpVajJ0bEZNUFhndzNYK3IxejdBc3NhQlRodEZJaWRjNXZVN1gzYWx2eDFJ?=
 =?utf-8?B?cVZOQVJTeVNBNkF3ZnYxajlLMW9wTVIwSFlkUGszYVJxd1JNcmVFV200UzlM?=
 =?utf-8?B?TFJ3ektJa09GclVLd1JMQnpQVnBwTW1vOFpsNUJhSWpabkxEYU9SRUhLa2tS?=
 =?utf-8?B?WThJL3pFTzFyLzBkczJWVUd1YVNvQlU1Q1AxQ0lMLzRqK25WdE5hZjB6WXU4?=
 =?utf-8?B?NnNqUm1FY204VFV0UityQkpvdWVWTURjVU5DMm1jK3VGN0dsYzBFTG9URVdj?=
 =?utf-8?B?WEtxYTRCYVhWdnZPUXhXcE9sSkkwZ2g4RnVyNGJCb01QL1c4QklqOG05SjRt?=
 =?utf-8?B?OSsxeEtKZGFyVzZnb2FLVlcrNTY5TXEzUndFNVdrTmtMbVM2VGZQbzFyWFNr?=
 =?utf-8?B?dXgyQWIzM05FcWJvdXk3dXRORXJPK1FKMzZPLzNNSE5mN3ZsdU11NFFLYUdH?=
 =?utf-8?B?NlBtMzNCZUVWZTlOT0hlYmNFNFBIVUwvaTdNUm0xSmJiRUlaSmhwYlpwNG9n?=
 =?utf-8?B?eFR1T01tamZVZThlaDdkTGlhUEswU0F0MkZGMm9Oam44NUxKb1k1bnRwMFh5?=
 =?utf-8?B?OG1YWVFyK0V0d3MvTXo5SGU3eHlJMjRWbGtuM2RYejVPUVR2eW01NFFUSTBm?=
 =?utf-8?B?VzRMMVVxdlprV0xtVnptVnY2M3B0M0xTd3lTV3h4WVpZdlRPK2NOT25FZ3Ix?=
 =?utf-8?B?eTlLN0svbHdKKzdpUzl4eUNMTmd4QUdGK2lCTWpBa3ZQL3VVd1pUSHcwaUVB?=
 =?utf-8?B?QWRncUYzYmN0bENzMytRMlkrSXhhWlY0TWEycVFwODF4NzdCMjUvZkZDZ21r?=
 =?utf-8?B?Ulo4UVkzb25lMG9XNmNkejFxUzg0RldSQkpocExZdDgwTHM1ZGgwaXM0ZS9Q?=
 =?utf-8?B?cjdaSUoyaG9ZeEpReldzYVlrVmY3b1p1MlQvUHhIQ3NCL1RMTXpET3NzMStS?=
 =?utf-8?B?MGpreC82QlprL3pGYWFvN3h0Ylo5VVBnMlBaQmlQTUdTQlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE1JQldUNHYzaXh2ZXcrNlJ3RUhHMTVieEFTeEcwMytJY0d0aXh2SE45Smox?=
 =?utf-8?B?WHQ3RmFwYm1FYkVOQjB4UlF0WkVSb2RINlkyRUJta09DQi8zR3hwSGtBUysx?=
 =?utf-8?B?MjlhVkQvZkhTTy9pd215NWZKcTFldlhId0JGcS9iUXdaak91Q0hZSmxkdVQ4?=
 =?utf-8?B?STlhTmhvZzhrek5TZ3hsSi9xNUlXUHRWd2hUS1hicHoyRFpMOVNuQmFoR2pw?=
 =?utf-8?B?V0V4dEorQlJ4bnhnaXJNUENVaitZVjBxVUdOSU8yZi9qcmphODI5d2l5OG1k?=
 =?utf-8?B?d3FCd2hJVWYzNjJuODRmdGp3VTZTZWx3SThQdUVGcXdsSEppcU5vS2pLWEhT?=
 =?utf-8?B?K0loa1NzdDJBQ3Y1UGhVTldFZjFObHNQYWZLd3krRWlKZDdMZit1Nm8wUDJt?=
 =?utf-8?B?R1dTVWRUbis0VjJVeE9VRHZETXI5VzdOTUYwVlBMcTdyeHVtUVo0UUZrbndE?=
 =?utf-8?B?RXNKTWJCUzdKUEJhZUJjRnRSZjd0RXllQjN2Q3lGZ2cwdVdDY3ozRU8zNE1W?=
 =?utf-8?B?RElXcEdrMk1xVm9GdmNRQmxSdkdTS0x3YVFBOWt2dVptRkxLK0VkaWxsUzJR?=
 =?utf-8?B?K1o4QkNnbkhLeXJwazJGMzhsd2xXc1RPV21WbGJsVUpiaGF1WS8yMDF0TG1u?=
 =?utf-8?B?TjV1OEVxUVVEck1SemZwdmJmeHkwWjdERFVoZFljWDZOdVhWQ2E0MlIyVzdW?=
 =?utf-8?B?K2lkcWRoR1hMRG1ZN29qV0Q0VS8zUWZheWZReitFQTJjNmk3eDZIK3VlMWNz?=
 =?utf-8?B?M0JJSkZMdmpoSGQ5dFN0UWlBTU8wQlhod0g4Y3lOdzBkcUFWczI0T3M4T3JJ?=
 =?utf-8?B?RmpXWU9vTitHRjRlQlJZR01qZmZuVWJ3OEJ5cHBhbVBhRWRXWWdNRWp5QmJF?=
 =?utf-8?B?Sjc0YiswcUFwRVJmNjdoaTZYV2JZbDdOM2JVVDB0Sm9va0hPMHJhTFRqMlF2?=
 =?utf-8?B?Y1hlSmpsTXprczBzblZRNFRCSkw4VmRhUEN3Ri95L3ZZa0FMZkZaTzNvSUFF?=
 =?utf-8?B?UkJqaVc5Nm5kWm1kTFpCcU9sekJPYzJDb1dKZG9UN2FVZGtBSjVrc3Z0eUtt?=
 =?utf-8?B?UldsaFF2RENMS2cya1dqN0ViYWF1NG1QaURaR3R1NDFKdGJWMm1tbzhBUjZm?=
 =?utf-8?B?Wmp1ckRrK0lsSk1KVjAxV2dvcTlEaGRQQlF6cTlTSG9GeURqS3FLenowVUNh?=
 =?utf-8?B?SytHNHZabUhGcE1iZ2JyNFBhY2JGZ1RCVmhIWEVQZUpKcGR6N21ZNy80RmhZ?=
 =?utf-8?B?bXVTTWZNT2t1VytFZlVjRlJqclZlVDFza3Z1NHFoSVBRRit0UVJPS0V4Vnpl?=
 =?utf-8?B?NlZYWlJpOTVaWWxRVUZnc2JrQnZaZlE3Z0EvdTZOUXdQMTFiSEowNkxkWUN3?=
 =?utf-8?B?QjUxTFBoUVBoNGw4Tm8wSldSV1pPdXlLVk83WlZoS2NRWFlwU2JCQ3dSaWZx?=
 =?utf-8?B?OWwreWZqZXhmcUZCVXBXU3BJUlNyZTM1RDhCTTFJREFNTUgvN1hQSWhHR3ND?=
 =?utf-8?B?YnkyZFJ1Tm53eFdvbDR0WlNvZVVIWEo5Um9pT0VubW9XN1NxLytuVnMwc0E1?=
 =?utf-8?B?aytMWDBMR0d2UWZ2ZDZUbE9XMzZLWVRBUTJRNk0wOTVuUURiTzVGYVM3UXJ2?=
 =?utf-8?B?UWJzNzZmQVJpb2xiZWdvTmZqRWJnM3h2THIwZmNKZWx0NTVkN1E2WWpGeisr?=
 =?utf-8?B?ZDJQd0NqSTJSb3kxUXBpcnhKWDdzM05ZektZalU3NGsvSFRLWEtGYTZ2Q29E?=
 =?utf-8?B?US9xTDkrSWtXRXVONHFvZWl0RnBJKzRkY2cweTV1V3pXMXFrMy8yblZCbUtQ?=
 =?utf-8?B?TTBMUmpoQk1aQ1QwWTRPdzNoWDhsTFFuM1ltYUl1b3lSWWVvbENkaWlEanlI?=
 =?utf-8?B?SXJVUXZET25XZHNZSThPWkt4QXNqbC80OGFob21jNW85NUJOaEpVbVpaRnZa?=
 =?utf-8?B?RThaRHBsdDRaVkJuWnM4M1RZNUJRQnZ4bWQ4OHRKK1cwVnYxZ3oxUnc0TThC?=
 =?utf-8?B?dDFzckhnVXdidnVyMitvamkrenY1dXM2Y0dHWDJTWnpBc0p4WmlmYy9tQnMz?=
 =?utf-8?B?cjc5b0dWcEg1dHdBNHl4a3NPUlpUYzVHckFnQmFHUGE5Vk9qUHd0eVMweUpQ?=
 =?utf-8?B?N1lzcE1TSzNKaGFVOEs2MG00OFRjcldzT09OQ1diNG0rVnY4TkxWUmdiNWRU?=
 =?utf-8?Q?9KlYXnmlHINB70ksJdz469g=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9db93c-b335-4394-1002-08de1b051917
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 18:16:24.4534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzuvIG3nz/X8kdkvgFgGiX5pvQXS5seXX3NuN82cJuETFtevMhG55gdWQssiotfb7JyrL+YSr74bMzahOEu6FG+NFWGFXP9f0rZrxMwAMKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5959

On 2025-11-03 12:08, Paul E. McKenney wrote:
> On Mon, Nov 03, 2025 at 08:34:10AM -0500, Mathieu Desnoyers wrote:
[...]

>> One example is the libside (user level) rcu implementation which uses
>> two counters per cpu [1]. One counter is the rseq fast path, and the
>> second counter is for atomics (as fallback).
>>
>> If the typical scenario we want to optimize for is thread context, we
>> can probably remove the atomic from the fast path with just preempt off
>> by partitioning the per-cpu counters further, one possibility being:
>>
>> struct percpu_srcu_fast_pair {
>> 	unsigned long lock, unlock;
>> };
>>
>> struct percpu_srcu_fast {
>> 	struct percpu_srcu_fast_pair thread;
>> 	struct percpu_srcu_fast_pair irq;
>> };
>>
>> And the grace period sums both thread and irq counters.
>>
>> Thoughts ?
> 
> One complication here is that we need srcu_down_read() at task level
> and the matching srcu_up_read() at softirq and/or hardirq level.
> 
> Or am I missing a trick in your proposed implementation?

I think you are indeed missing the crux of the solution here.

Each of task level and soft/hard irq level increments will be
dispatched into different counters (thread vs irq). But the
grace period will sum, for each the the two periods one after the
next, the unlock counts and then the lock counts. It will consider
the period as quiescent if the delta between the two sums is zero,
e.g.

   (count[period].irq.unlock + count[period].thread.unlock -
    count[period].irq.lock - count[period].thread.lock) == 0

so the sum does not care how the counters were incremented
(it just does a load-relaxed), but each counter category
have its own way of dealing with concurrency (thread: percpu
ops, irq: atomics).

This is effectively a use of split-counters, but the split
is across concurrency handling mechanisms rather than across
CPUs.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

