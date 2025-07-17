Return-Path: <bpf+bounces-63648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BCFB09377
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 19:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07B9F7B585B
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 17:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3634307493;
	Thu, 17 Jul 2025 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="eu2Nrlkj"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2120.outbound.protection.outlook.com [40.107.115.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA59306DD4;
	Thu, 17 Jul 2025 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773928; cv=fail; b=sPNv+blNsShg0vzEnwJ79jKCLA74gs8hVwu184Cwk6qBZSW6lHtVnYLwIVYGq6KQUMpK3n50wrPbT9q5kzq/J5IITEkWu+19eyRpZSGY8PR/75M/PCEm6pghLsZT5tTxbP7NTh2hlpAKUy7bkiHvGMKlYfWNJgpPFh5PENylmD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773928; c=relaxed/simple;
	bh=f8EsTuR4lu6wJ7KvvAl7MGYREskDZ3ver6IIeTmErcw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DrnPe04bfZtij02iQd/KYkwJXXmWrtHiZ+sbxDsHaKlAaxH+1iVPhEbenSXKhuC2Eqc//+JnqXdCHYBoV5st83OShyHdcfPx5WFAKyusElRXmpB53EFbLS6I3+9iBTTeWgGB/Rjmpu20HWDSO71kttqa2afKN7LMbzrh5P1r4B4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=eu2Nrlkj; arc=fail smtp.client-ip=40.107.115.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBZ6sE/KbndsxAGA6prj1bbmENu+bTaungSF6CaHLK4p9gT+uTyL2WkTYKYg5boXlT9q3dbENGCPUieFdToJMF9HNTjai5Gy0KaQonbmMGtOucT/g918fORD2AfVG09UiU2vCAbJVqLI/c6Kcnqv63I4rzRJ2TCDSojVgUH+i6fhzT6EwvIE77jXvbp46wxkfXXuY30xXkKIjt8wz07Y2NG4+wyq+OKSUhxOWX9SZKnf53mIaaAtKWGiobYZZhVe9Q5zRjG/5MJDsFpuX1SJcXKidJ7CitgD+09IEeXU6i+kFqqNrKYbbQ4bgPjB/NQDcFztZ72DR1mPBjKgwvn4NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QAYqhe5RpImb+1+jCkdKpGzjv1h8RqTPHmwZpD/hvI=;
 b=wQUyIfHQ0zZQ00hXZRMzjz9Jag7rrOPLEOHTBVVq9VLyp4wQH13y9gZ/kjuu9eefXBENRuGfzZnU6Iiiz079vByHOzMHybQc0oC4bPc0CGykbEETM61SkTOfxeORAKJl3Ek987eDYiA8rJnnpGlnbcYl+Mu09rS4+2fu3K86UpXSqGq/UiDLEsWu3I1opPsBPLynrJ5M9uDUrA5Yh/iPNHG0wCIHdVUVg7uU8nukqz4Nkwh6UGr7FVXF6k0jHfoREHkoEE152HL3L5R3+91CptaVsx/IREuuwYn0pL6C58XzNG0DcApkNNpQ2xM4i3tODtjgAF6m8hs9JTlSdRrrZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QAYqhe5RpImb+1+jCkdKpGzjv1h8RqTPHmwZpD/hvI=;
 b=eu2NrlkjxWYsC4iAjkCphWXLSBnjBUlSDyhiJijffs0iNG2ZkxkxrxPVbCGqbHb7k7pihZMrPEP9CrbrTx7hsniMdGfxJwPA+aiNmF2lPmFpZutP7zfdaDPRBWF92ouHK12o2sWdBDq16p7mVzcJx+VL0D3+wk1Fcmq1NSyKtm+9t8cM/A3GTlIc25SlK3zEK/ckI90/wguL8Mc9j55tV/5heoxcqubM3+FWaMGBd4G5eqjVp6mERVNKlcJmpMMKm3okcVloeCrkBagvCJTGmCrqGgUjo7QxHLceIjqtg+J+yRTdxn1uf+tRnYYqP1cIV8epzoqOQclW/voITPjALw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9141.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Thu, 17 Jul
 2025 17:38:42 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 17:38:41 +0000
Message-ID: <a66063c1-c4e0-4cc4-9265-2ab58cd262be@efficios.com>
Date: Thu, 17 Jul 2025 13:38:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
 rcu@vger.kernel.org, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, bpf <bpf@vger.kernel.org>
References: <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
 <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop>
 <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
 <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
 <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
 <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
 <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
 <20250716110922.0dadc4ec@batman.local.home>
 <895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop>
 <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
 <e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com>
 <CAADnVQL7gz3OwUVCzt7dbJHvZzOK1zC4AOgMDu5mg6ssKuYU6Q@mail.gmail.com>
 <20250717111216.4949063d@batman.local.home>
 <CAADnVQ+r8=Nw0fz8huFHDNe2Z6UnQNyqXW1=sMOrOGd8WniTyw@mail.gmail.com>
 <20250717114028.77ea7745@batman.local.home>
 <20250717115510.7717f839@batman.local.home>
 <CAADnVQJwpM=DfWjYe12pbx=Yb9NR5MRktzwgV_ALjLqMR3w9nw@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CAADnVQJwpM=DfWjYe12pbx=Yb9NR5MRktzwgV_ALjLqMR3w9nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::35) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c6db75-c141-40da-a167-08ddc558c51f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aCtVdGlEUDkybTgrV1lGV1dSQkpHV1V5SkIvZWcxUVpCOUFxcitMVng3dkNy?=
 =?utf-8?B?WTVpV2QwY3lPTFgya0wvTEdLMGl6cktUOTAwaU1WREdEcURQeE5QRzZLQlBM?=
 =?utf-8?B?dVJETC9PS2d5UlhwMVhteFoxZTVYSFRncUtRdXFQcE9QN2RTTDZ5RXp6bFpy?=
 =?utf-8?B?WlFkTnBJQjhUVU5QYld0aGg5ZU5WZ3N2USs2NE1KNWRtd2s1dHY1WVF2dXM2?=
 =?utf-8?B?VDE0M3c4TGwrL3JibVBwNUNlSFZ3ZEtVdnYwSEtqM3JBekRIWEcwQU14OWpw?=
 =?utf-8?B?TjlYR3BRT080cGJFaDkxOWZYYVNMbEROYTcrUTJ3d0JOQUlyVk1seEpXM01n?=
 =?utf-8?B?VVp0K3RjaEoyNzR6UDUzdGY0Y1FkR1BsT2JyMlMzT2hIdzRVNXFYek1PUi83?=
 =?utf-8?B?MU5Mcnd0dWxlVmxNSGNuaFp2RnVja0lwU3k0eUZSRWIyNWd2elk0Z2Q3My9s?=
 =?utf-8?B?dkV0Sk1LTHJwcU5sVHZBb2ZpRnUyTTNWSDRSbEFwVGRvc2FDV29ucUVWaVZs?=
 =?utf-8?B?enNkNmlWcktTSXBrODNKK2llcWMyQ2hkY1ZTdVQzRDZ4VE9Qa0VFUzBITG9R?=
 =?utf-8?B?TjdxbFN1SjJtUVU5VVZaQ04yK3BKYk84ZEpFK1ozdHRwUWpOY09rbHUzVG5W?=
 =?utf-8?B?UHc4ZVpDQjE5OVpZMkxzRjFvRC9yLzN4TldyZURkbUh0OGljb2QvNGpxTGJm?=
 =?utf-8?B?eVNZUGEzdkdwdUFBaDBRdkQ4YXhHWWNIK2VjQ3Jrc1laZDFlMVR6ZW1EOVVl?=
 =?utf-8?B?Ty9WUi9kaDRJTEw0Y2E1S0M1MmlIRzhOaFJpeThIT1h2elh4ek1UdkE0MnFl?=
 =?utf-8?B?SnZyY0ZUUEZtTHhLTUI1TVlhOWJjdlpZT29Hbk5Db0RYclFLa2huNVFmRkFl?=
 =?utf-8?B?NXloOE5TYW1vOGE3MG5oYi8wS25JaS9kckN6TnRYSjV6SVBxNFRqSWRXTnFL?=
 =?utf-8?B?M0psRmJNZjBsYzlLQVVkUGR6Wit5SXVnazIxY2NzWTZKYXFXaXV1ZnhYWlMz?=
 =?utf-8?B?WEI4Y3pQRlB6S1NuWHR6cWRvSEdXYmpXTW1mTkFhZG04dlI1YzBtRDVzcWY3?=
 =?utf-8?B?MGlGSGE1cXpIWEtYYnIzZUl5ZzZTbzkwcG9VamJkenhLemxwSnRRMXNZcTZP?=
 =?utf-8?B?Y20waXNDWFY3QUptMllUWWw1L1ZjTXUwM3VFYUl1NHN5dUJJd0VmaFlwWVMw?=
 =?utf-8?B?M25XRVN5dnErRkZjRUtibHZzdUkvd3hJNlFQOGlRb2N2a0lBaVhXdEpUeTZW?=
 =?utf-8?B?aGEzcHg4ZXRQZ3VkUHQwY0taOCtVUG8vSHlPcHNiTmdodzlnck5OR21jVFRa?=
 =?utf-8?B?VkFWaC9vWUEzc3U4N3NlOFRQOUtNcUN5QjZETDNvR3c0WkdmY0NYcERVaWJj?=
 =?utf-8?B?TXJ4WDJZR0Y5eGMrU1BEQll1NU5kU0dJb0Y4YkxmREl4RjlmbUd1M0xMYUlY?=
 =?utf-8?B?cmx4S0habDZ4d1Z5RG85ODJENmlhUHBaTVpYQVJyUWl5ZXUyYWR1WE42MkFa?=
 =?utf-8?B?MUU1MVhWcEgzRmJiS0UyOVgvdXhoNFB3YXJ4V2FQMEVwNjNCUzNhQ3RxZzdL?=
 =?utf-8?B?bjEzNzFqRFdVNGpjeFh6WThBanJDWmhnYk9QNGRTdFJTK3BGU015NkJmUkxi?=
 =?utf-8?B?MWsyQXV1MEZhU25jbDFTNEVFNm1KNG96eVdjUDV3aXdLOGVmNWtMVlhORTM5?=
 =?utf-8?B?Z0hxMnlxaTV1ZFZNWTJYUmoyd3FvNWwzbDQ1djNYVGdZN1ZSUGdhczU1dDhq?=
 =?utf-8?B?Sk5PaFBtVlFaSmI5eWM3Z0xBLzFrcldOVFBlVkFOdmdRUHlMNFBMQ0tCS1RJ?=
 =?utf-8?Q?S3hxQBZxO4Gwfu/N4zQT5TeFwBX2HjugfPcCI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEtsaEpJaUF5UERhc2JNdFVhcGZIT1NUb1ppMWVJeVlOVkxPamYvUVovODBJ?=
 =?utf-8?B?RmQxQ0cxOWdnZ2NsMUI3b2JsN1BlYUFHZjFWbnV0SjU3ZjlSc3h5bDIxZ1N4?=
 =?utf-8?B?Q0hWWUwxbkk5OG9oRTg2WnU0cUh3RXVPTEozSGpaaGlvNGcxamhkOWhFUURk?=
 =?utf-8?B?ekZhNnNoMXVENGM0Wkl3SW5yVlF0c3pJZE9KSmdmbU1hL1hxVFNGT29HanNB?=
 =?utf-8?B?MFZkNjYwdHRsZ3RLZCt5QllGRUM1V2djWTdWbDdxN0ExZHFQMjhSeTVzQnBV?=
 =?utf-8?B?VmlCSEk3cE04Vk9CWkJWa2tMdXIrVDg0Z2VCb2hGV0d0T3NEbDJ1eXNDUWYr?=
 =?utf-8?B?d1U2MVJ2L05IK0lRMDlLT1NJUDVic2VkWWdMZ3RzWHE5djZtZG1BeXN0ejVG?=
 =?utf-8?B?VHAza1NBRHJ6UlQzOGRmTWMwNGJwcEVjV1lpOW9IUDYxbnExckx0UVBqZzJl?=
 =?utf-8?B?TGlUdTBHVFlIZFlIWGE3b1B3blkzZUNjeWRpS1hUWkkrOGdrSDl1Yk5FeXdV?=
 =?utf-8?B?dTNVUjJXOUdSKy9naXlCdHYzajZ1M2ljYkwvQ1h5NGVoeXBmWnFKOHF1ZlUy?=
 =?utf-8?B?RWhBUlUyYzFGcS9idzZHWU1RSnJGOVE1bXlCbGs5ajh4cXlrK0dIalhIaXR5?=
 =?utf-8?B?MFExa1A4c2g1bkE5eSt2OEdUTlJjaXVkdVRwejdOa2ZFUUNncG1HWW14NDJa?=
 =?utf-8?B?cW1ETVNxT1hzU1VQdXB4MXRFbFFPQ3R3MExyakFHUWJ0dWFnZlpXdHdnZ0xI?=
 =?utf-8?B?U0ZKN1l5U2pJeUgzNGU4SlNpUmd2bmlSYnMzUkdMSlN2UDVRTE1QVGdUVTQ5?=
 =?utf-8?B?VEtFelJCVlgzNXorRklpbFBza3E2NThzaHo5bUQyd283ZzB0QWQxS2M5TXc0?=
 =?utf-8?B?enJwWWkzSkxHUHdFTmJIbWd2djV4VC9NZFdlbTA3SUlWMGlEZU5KZExIby9K?=
 =?utf-8?B?dXBlSjQzdUxhb0hLdXltaVdTR0VXYlc5RlBFdTVRWHdDU0xJdllHM2hiREh5?=
 =?utf-8?B?R1BLN09iSHdtaytnMkZ5anM0WDdKNFJZcDd6OEl5R1RvRFc1c0NQbWxJalVH?=
 =?utf-8?B?QmJxUjFMaTBVSXJzQlhJZ1lPcWRvY0laZkpzb2t5OUZkTGdaaHo1cUM2YVpX?=
 =?utf-8?B?VERYUXdZL2tYdjVIc1NFVmxjTTd2cFNjWDBZKzhIUFJwZXdSUG80QllRWU1U?=
 =?utf-8?B?L0JhalhxQmhHL0RJdlJtK2FXV3ZyWGNaYVh6T011ekV6UlAybmVYZE5yYkxV?=
 =?utf-8?B?SDJWK2EwVmQ5MTFuZmcrSk5SYVJ3cTBpVjlpVk1TUllBVXdrdDBBYVFDUGRq?=
 =?utf-8?B?emRrVVI4OWhwNXBFa3QrV041d2VMNHpGRlBWay85S2dPeGVzWFRnOXo4UnRM?=
 =?utf-8?B?RUxGbWFUWWhNUTN0OFpqTU1tYWQ4cnZmTWphV2tKOTVIQzVjZi8weUM3cHpv?=
 =?utf-8?B?UDNqR29aN0pXU0pSTnpQMlZrU2xDS0hKRFVqeWMyaGtjTDU4SUo3U1l2ZTBJ?=
 =?utf-8?B?TnBlZ1VEQVZydnZ1SG8vaUFuRUZ0bDRtenFtZ0hkY21WV3cwSFVFWE1iT2FN?=
 =?utf-8?B?ekdTekxCQlU5SlNzbG1nUyt6eEF0aFNudHFpZmNYYmk0Z0NGRDVkZkxFSmM5?=
 =?utf-8?B?bUZlKzhNTmJLZEZITjZ0aVpNbysrcXc3eW1vVXVKaVFXSm5lVDhYOU5YOHR1?=
 =?utf-8?B?L25Hc2dmdys2ckJrK2tMK3BaQlhKRDZlK1pmVmF5MmxxOWlJTE1MbUQ4VWt2?=
 =?utf-8?B?Rlp3ZlNHeDQ0S1VJMWN3OGFhdExHeW90L3dFUlRKOGwwcWZmQ05DUVBDODhM?=
 =?utf-8?B?TllkL3hGaUtXZ1JnUkIyV3lNejd6ZFRXSVgveHl1cjJieWJUMjYxQ3VmY2I2?=
 =?utf-8?B?OGFIbWN6bDBCUk10UDFvRGxDYktMb3JGcjNkWUt2bWVaWU1zcktMU2pieWt5?=
 =?utf-8?B?cFJGa29tM0oxVGZ5Ym1qeE9ldkR6bnZnS0Z4U25HYWNLREFQcDFhOFBQSXFa?=
 =?utf-8?B?Y1pqNWk1KytuVzhXdkZBOWNmWG1VaCtYZEduLzgzQlYwMUEwK29ib3dQdm83?=
 =?utf-8?B?cDdRTWpFMWY2WXBqNytPMXJUQVdZVnEyMVVGV05yYW0zSERqV1dvZUtKZVJ6?=
 =?utf-8?B?WUZDY3QwajgxVEJEYWxDRGRlSVlMVCtLTFRiR0ZoaTd2ZGRBeVVac1IycEUx?=
 =?utf-8?Q?3kWUk+ZsAIBw1gg+OI3o+TI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c6db75-c141-40da-a167-08ddc558c51f
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 17:38:41.5262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxbINWgtSxE5s5yTLTkbcdzz/GJT3P+4Of0FsC0Vng/hAjbPbhfS9zlZnK2cNHqM5CePKLSW0zsBokxLoGr91/RpcZViZQKLt9lnUvjvd9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9141

On 2025-07-17 12:02, Alexei Starovoitov wrote:
> On Thu, Jul 17, 2025 at 8:55 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> On Thu, 17 Jul 2025 11:40:28 -0400
>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>>> Yes, it is a tracepoint infra problem that we are trying to solve. The
>>> reason we are trying to solve it is because BPF programs can extend the
>>> time a tracepoint takes. If anything else extended the time, this would
>>> need to be solved as well. But currently it's only BPF programs that
>>> cause the issue.
>>
>> BTW, if we can't solve this issue and something else came along and
>> attached to tracepoints that caused unbounded latency, I would also
>> argue that whatever came along would need to be prevented from being
>> configured with PREEMPT_RT. My comment wasn't a strike against BPF
>> programs; It was a strike against something adding unbounded latency
>> into a critical section that has preemption disabled.
> 
> Stop blaming the users. Tracepoints disable preemption for now
> good reason and you keep shifting the blame.
> Fix tracepoint infra.

I think we're all agreeing here that it's the tracepoint instrumentation
infrastructure that needs to be changed to become more RT friendly, and
that BPF is merely the tracepoint user that happens to have the longest
running callbacks at the moment.

So AFAIU there is no blame on BPF here, and no expectation for any
changes in BPF neither.

Thanks,

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

