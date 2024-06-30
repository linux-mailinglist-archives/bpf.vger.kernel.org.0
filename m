Return-Path: <bpf+bounces-33447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FFB91D17C
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 13:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 986EA1F2183F
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 11:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F9313C699;
	Sun, 30 Jun 2024 11:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KxINlwr+"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FCF12D76E;
	Sun, 30 Jun 2024 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719747846; cv=fail; b=jSC/IPjMjpgDfXV+F9GdzGxwgzbCou8495uDExRl5snHBWAdR5MVzz86/4hEU9u3Tu6ZPfL/m6dn/cIzrKRum8V39FYMOGVZBWWl5a+vPFI9qRompE3muOVHYNeoSoNUZq6EO0UkLlvZEtE2dnb/vDiSVLTZJ/9VyAYPQIHuGvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719747846; c=relaxed/simple;
	bh=bg50bbbpSRf+VbTuXvo6Hq8JG/CShMvSrh/JR6RneYo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Iq1Vt7cgiaYZjej1afYf7Ge+LEWMAWu7Eja8n44c2bAEulZGIqSva8yDxXOZR6q8RL3cxq97EM5hrbMPm9IsevuVKYHp35uCOjMBY4bvvH6dOhG++aYNNAbZxCoJRqyBYtx2t7mEdVGpT/Ptt/N/4o6lvjxSN6KttdixZnRbufs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KxINlwr+; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzWeDg0s1oUSsQiLO4hErDwGXd0I2IM3WPXIwJDD4tPxwaw5u5QrKcbqwFZEzAPiFkvJcdux6qDkdXXdKlPDZty7xVVHkKG7lRudkwzJ6ATZFgzTkKQJRegOWe/OG9oWxFA1MU/g0z9hQoPpCjSr0yMzCgn0m2cBuWFnN8n7fxrIkhgpiLq29oU1NUEAmpSUDsF4tXkkMXHy7eO2Y3bfXGMOoJa/lZushv7sPfIxYCITNkgLjrgrdSFTmdnhFtbqx9VcKZmbMYZnE6wHjTm5m/tmcdqqeo5pgWWh+h4s+UXk8Wjo8FupIXPjR8XkcSjB9TBmhBYFLkvAZMYsh5PGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywNRh3wT+PjY0cmgm+Ucil4I6Aka/zUjJ+VrsxXrse8=;
 b=nTpZef5EetO+bVe2quJvCVHDQgvZFpL8eyuURE68Fg1r2YgiouEZHJ9jf4lXNkCckT6DdEpRbI1WYx1iOpqpEUa1OHdTAF3C/OxPL5KJmihWjPImk9tWlvkD/Fxr2AuKYWMYtGqt64XWKiM/Ei2bw8Ktqttuka5C+PXUoWe5+7iY6hlDiopsGiSTeUg1B2CyHyDIW+/H8Jan3l37VSOhnWvb/HYopEdqaenBf3yVl6Xg9YGfjzDWGrk3tUK30twhGfR9hT9mIlrJYGeD643uOFi0IrYK0WLtvKcPTHfjqlTHr8LPYUQzz+YHpu/wx+16OtDFCflgZ8LWSIsjlgFGmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywNRh3wT+PjY0cmgm+Ucil4I6Aka/zUjJ+VrsxXrse8=;
 b=KxINlwr+18a4IcV1ix4yDtJQxFAoTG1nAox5EOjmaK4nxzWFHp1J7vNDpyJc93/sqsEPb8m4QE2BBNGYMfcRaCDZOknVbZnP6o2nCZiGUU79OEgBYa8by2YzevT7ZM2eR/2SZBtpoPREEUaRbsTif5JD8Ro05K1Jeaa2JSm8kXV9egT5ze60E94nU69vcS49nMfBXQfzSIWqFdMIUEQWdI4HCHi0fipvQ//lO9x0VebkI1+zuWg9VKy7UlpMHUX+v0eMc8urUbp2DAMYzJAmMJ58O7LqH5aiUiSQyCMX8bclZp6cSobyeYscbCQ1gxXOAe4NjrrlmxPkBJ2y4iLBPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6)
 by SJ2PR12MB8847.namprd12.prod.outlook.com (2603:10b6:a03:546::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Sun, 30 Jun
 2024 11:43:41 +0000
Received: from IA1PR12MB6018.namprd12.prod.outlook.com
 ([fe80::c3b8:acf3:53a1:e0ed]) by IA1PR12MB6018.namprd12.prod.outlook.com
 ([fe80::c3b8:acf3:53a1:e0ed%5]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 11:43:41 +0000
Message-ID: <c97e0085-be67-415c-ae06-7ef38992fab1@nvidia.com>
Date: Sun, 30 Jun 2024 14:43:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: XDP Performance Regression in recent kernel versions
To: Samuel Dobron <sdobron@redhat.com>, Daniel Borkmann
 <daniel@iogearbox.net>, hawk@kernel.org, Dragos Tatulea <dtatulea@nvidia.com>
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Sebastiano Miano <mianosebastiano@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, saeedm@nvidia.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
References: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
 <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org> <87wmmkn3mq.fsf@toke.dk>
 <ff571dcf-0375-6684-b188-5c1278cd50ce@iogearbox.net>
 <CA+h3auMq5vnoyRLvJainG-AFA6f=ivRmu6RjKU4cBv_go975tw@mail.gmail.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <CA+h3auMq5vnoyRLvJainG-AFA6f=ivRmu6RjKU4cBv_go975tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0415.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::6) To IA1PR12MB6018.namprd12.prod.outlook.com
 (2603:10b6:208:3d6::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6018:EE_|SJ2PR12MB8847:EE_
X-MS-Office365-Filtering-Correlation-Id: c3acf8df-69d4-4fbc-1036-08dc98f9e385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UU5CMXEvWGVaL3drV052TzJQN1YxUDV1Qklvanp0VlNrVjNVblZnZG0yUmhS?=
 =?utf-8?B?VmFFU2VYbXc4TmJ5ZmQ4NDQ4V0dvQlRCUnNweXBnUHRHWUc5QisvNjIxYXFh?=
 =?utf-8?B?U0JKUHlTOE4yWnJtZmdTRm9mRklGaS9iTGpENnBMTVM3a09CVWNVTDkvMnBn?=
 =?utf-8?B?Y1FqOTJCRFdGNTRRMkpqa1dkRUxnRjRuc1oweEUvWHRDR0hsTXhVK0RNUjlB?=
 =?utf-8?B?aE1YNCtuTEpVY1EwZEdXcXFxb01aMHVlT3k0eUZ1cThuTmhSUjB0U3hvWVh4?=
 =?utf-8?B?M2VwbkttdG5jK1ludFMzL09PeUFudmhWclp5djNYaDlSd3AwQnhBUGZvNDl2?=
 =?utf-8?B?bzExK08zbW52RzVHUGlDZXlFNUxoUE9jY29vRG1yNFpkRThpam9Wek9ublAw?=
 =?utf-8?B?WjdZVjJHWlJDZTA3YnRodWVEVkY1U3VBVHhBSDZkSlo0OHhKY0ZqZC9nVGdl?=
 =?utf-8?B?QVFHdktIMFZxcEJXWGM0VDhmNGdRM3FNOXdVeXlyWE5wV1hCODdtb1M3VlRi?=
 =?utf-8?B?dDYrQzlxK21GbW5FTnp2Q011cHM3a0NVKzlvT2tHNzZlcUR4aE0xVWVrdldj?=
 =?utf-8?B?eWpHVFNFczV6cU9zZWU0cE1DUTZSQ1NaNDl1RjFvTW1yQ2NFQ1hLUkR0RU1K?=
 =?utf-8?B?TjUzVUdpSEtJYW12K1hZckQ4S2Z3N1ByT2gvQXZWMVBBTUpkbFY5UlJJc2pX?=
 =?utf-8?B?ZlFpSllMSFlBSHZobzloNFJLZmppMzdrSmVsSlQxRmJaci9sZSsxWStKZHVH?=
 =?utf-8?B?SUJOZnh2azltVGJXV2wyK2RaK01ZclVxOEhlcS9BVGQ2ZVhJRHpGYlpqYW5n?=
 =?utf-8?B?TERVSEExd2NLTHY2ZFgvTkJuekNIam1QbjB6V09UTHk2Q0FBN3VnK0kyNEhZ?=
 =?utf-8?B?QksxbjVvNGZHYXhvRENTUTF1aFpXOWpMMk5XN1FtTzNwSnNiTFlENU9MV0Ir?=
 =?utf-8?B?VFV5UXN3ZWZxa2c5b2dqZ1JjZ0pWQVBRWlFvSm9nbFB3MmpNQ3JzaVdLSVp2?=
 =?utf-8?B?cEp0ck5KdUZRNHNIdXhMa3VLREY4cjZ6SkdlM2pUVzBWeUJDcFlWSFRmdkNP?=
 =?utf-8?B?ckpXektBVUNKajk5U0tjRk1YRUYxb3JDYUlHaVM0UmU3R2h6bHhOZFBNaktm?=
 =?utf-8?B?ZnQ4M3Y0L1NBUzI0cHV0bERPb1Fjayt3SjlzYU1tYmNhcHZ4Tm1nenl0MXB4?=
 =?utf-8?B?L0ZmaUd6Smt6NmJ2SWdLb1E5VHBpRGhqSmZsWEFRQnF6WUI0SWUxdTJ5Qi9O?=
 =?utf-8?B?WmxBdS9VT1QyMzZmcWplanNicWpydDZyd29GdFM3Y3d2TlNHb0E4alM4UElE?=
 =?utf-8?B?NWZ4MTEzZkkxS0d6Z05JM1ZlcG1RTFBsUTNmMzNUNCt2S1NBanJxNGx2LzNp?=
 =?utf-8?B?VUNEUENQdFowVHhaQjZHc1dFcHNxdVFmSUxzNFZrZFpSRzRKSEZycDErb0pH?=
 =?utf-8?B?WUZHVmRwK1RqZEZSdlZ5Q1U2Q1RjTUxoMktpY1B5dS9QajlJZ0ZMZnZrL0wy?=
 =?utf-8?B?ZVFxUGs0eTRvemowaklWYmhXa2dObmVyYVd5SCs2d2o2ZFZnOHFCNTBzTkZI?=
 =?utf-8?B?Qm5haVdLN3g5ZnFsU0U2OVVyMEU0bUhLK1pKM1VITW9VaXViVEJFT0RLSk1F?=
 =?utf-8?B?bFRNVFJxSnpQT1NWREtqSFVGclNQUlFaVmNGR3djUzZWa1E1dTNmcTFsRmpV?=
 =?utf-8?B?QklHOTRSMHprWi9VOEZMUSsyUkVEMzZpMnJPaldqa1JCS3lwY05XZzlrMlBv?=
 =?utf-8?B?T1F1QXNBWG9VTTVHZm5tU3dueVZhZ1MvSEZyb24zZTdCdWxLR0NyS0o3TkdQ?=
 =?utf-8?B?ZmtKblVyWW56dEQrRitBZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6018.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aitEYysvTWNZQnpPV3FlVHBaUFdRVHdqR1kwZmpMMnFRZEdzcVpNQmRRMkw3?=
 =?utf-8?B?UHpEYXV6cmVKNDNhcGRYVUZmZ0kyNWM1UEFsRzB5ejJNNDA3WkIra0NaTVJo?=
 =?utf-8?B?YkgySFlsT2UxRWQzODNtSXA3ZG4xVHlXZFh0MUUwOVhpMjY1T3dpaWtnQ2JF?=
 =?utf-8?B?QjQ4WXBKajZuVDdkSFNXaFVtWTNtTHJiUlRXRTVKTHpQNnJwa29Vc3MxcjdH?=
 =?utf-8?B?a3B2ak8wUWRrcVFGdmdZa3JLN2JzdDQ2UkNDakZjM2x0ZjhqRHpCV0ZxRjU2?=
 =?utf-8?B?ZGxhVUp2N2lZUFNzN21QcGVWWmtudXVTc3hxQmFCU29KaEFNMmFHUmY2UnFs?=
 =?utf-8?B?REdRN21mVFdpTzZETEhBUGFHRHRPZHFLZHBsNjViWTFmYWE0TU9HblNUSG4y?=
 =?utf-8?B?ck1YQTJlZFZFa09PS0tXSTlOaTNDRE5jNVdwRnZMRFY2TnNnVHNkR044Qk1h?=
 =?utf-8?B?MFozYmg1ejIwbVlLS2N2TzdDc3I0NGlPL1VMVTFYZXpMQWNCcWRRYmNySllr?=
 =?utf-8?B?WmRFOVZmNlF5ZklMN0ZodEJtcWJIOEEvdlY5K2ErVXpmbG1iQXFPamNpQVVo?=
 =?utf-8?B?ZEFabVpBRnpNUWVYcExRWjFEMkxEVnNITWxEWGlRdkg2V1luazd6V0tEaStw?=
 =?utf-8?B?aUdzTCttdWdJOWRvU0QzVFZRTVRBaGlhRG42OTFRWVJyTDRSVzBCQWZKK3JW?=
 =?utf-8?B?UTNkMkRTNE5HNGV0UUJoWjBVYkRHc0xaRDdtT2NPNXRSTTlxTTZZSVlDSm1n?=
 =?utf-8?B?b3JjMVlBOFdHTFdQMzZRY3VlR3BOWkoyaTRqcWdZby9qZDJ6VFVTbUV1RGZ5?=
 =?utf-8?B?dU9na2ZnN1U4d04xejN5cnhFT1ZJejZvVzZubHNDWmU4ZFlwNEN5RHRjQ2VS?=
 =?utf-8?B?ckVjV2pzVy9Jdm1LVXBiaUp2OUR2ZnJOOXM1c0R5RGxwOGpuemx4OThLY3Vm?=
 =?utf-8?B?U2FKT2lsdFZpdVhrWVhPWDJWUzRRclpuZEQ1aU1LSkJCeHZSRGRLdkNXRnlk?=
 =?utf-8?B?bk5ESDB0SkdrNVlEeXhZbThud0g5YTJjMVN0WlRaR005VG9GZnlibnhsNVJ5?=
 =?utf-8?B?Z3VhU0QvL3dwK2tZZHY2cWg5OC9rTTM3aERJT0piWmV5U1pjZ3hrN2pmL0h0?=
 =?utf-8?B?SUF6OUdxci9yb2g4MDhJQk9aaEhQNEZ3V2F2V3loSDIzRkYwbE1SeERERTNP?=
 =?utf-8?B?cFJMcG1vT0V2K2dYNC9WT2ZpZW9aTkpsaGRabkkraWIzK09ybEY0STI5eDE0?=
 =?utf-8?B?bFlUTS9TTFd2dSsyWUFtQnI4YWZvcW9pTDV3cVdHdHFYZjdsRXZCa2F3V1pD?=
 =?utf-8?B?djJwYWQrVnFHTjFqTmxvSzEvYkY3NzhnUUdwUkdBaEZIVU1GVldhWThtQ3BR?=
 =?utf-8?B?VWVwRDhpWEhIaFpvaVlxTGNFSXhLV05WOWdqdVd6TFg5WU9adEdhUkZRazNB?=
 =?utf-8?B?YThsTG05bG0wbUowL3IrVjh6ajNzaHJHQmJCRTV0eUlZUjZ0bWQzc252VzJM?=
 =?utf-8?B?dTZ5S0dsR0d5STV3VGQyVnVLT2NmL1hjOWZCZkx1TGZjNkJnOERaOWxnWUJx?=
 =?utf-8?B?Z2xLdVU3Rkk5SWhEUEFWUk1ONTc5MFJRRHI4L0dMMGZ5TkUxbWxHUmVkZ3ps?=
 =?utf-8?B?Umo1WVhiaWVRWnR3Ti9hWEt4YlcyNlJiZTJmbnM0dnd2M3JGTnB0OE1nQ3ov?=
 =?utf-8?B?NFc1QzBkbUVXVlFRVnJyeFV3ZnZTeTZLUE0zcDhRbHNhbkU4ZWJRdUZtUXd2?=
 =?utf-8?B?N1FobGhVVHdLZmRWdTNrTnFmY1pzOVVOSFJiM0NSK0FwMS8wZXpLNysraGdo?=
 =?utf-8?B?NklPN0xQcnBscTJvUWtZakFJTENyeVQ0OTRSL2loVXhhMysrN2oxYmxKL0Jr?=
 =?utf-8?B?Uk5oYjNnTVRyK0o5bTNYRjc0NG0rbC9wWlBKQ29GMGl0dE9nZkZVZXpUKzJ0?=
 =?utf-8?B?Q0tvVGhMWDhUVlBRTytxK090bzZ5VzdwWitzaFFQemRFODVBc2Q5TG9KRFUr?=
 =?utf-8?B?UU44VGlnd3E2OU1KYlRVcmo4SkcxRXNOVFFTM05MNFpMZ3RXUjBGVldzTHJI?=
 =?utf-8?B?ZlJVR2I1VDlOckU4c2wvQVNLWkxnM1NtL2Q2UWd0QWdPMkEwMWUwWW96a0gr?=
 =?utf-8?Q?hTNY0a06btAye8XnydgigQICU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3acf8df-69d4-4fbc-1036-08dc98f9e385
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 11:43:41.3397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vr8azhbj1m1KR5AR7S8+MB9K1Ddr0SHzBztZytY9MGVKh0zNL2JfXo3uqZqvXVRxpi3CEAZff9yoQg0SDUkmCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8847



On 21/06/2024 15:35, Samuel Dobron wrote:
> Hey all,
> 
> Yeah, we do tests for ELN kernels [1] on a regular basis. Since
> ~January of this year.
> 
> As already mentioned, mlx5 is the only driver affected by this regression.
> Unfortunately, I think Jesper is actually hitting 2 regressions we noticed,
> the one already mentioned by Toke, another one [0] has been reported
> in early February.
> Btw. issue mentioned by Toke has been moved to Jira, see [5].
> 
> Not sure all of you are able to see the content of [0], Jira says it's
> RH-confidental.
> So, I am not sure how much I can share without being fired :D. Anyway,
> affected kernels have been released a while ago, so anyone can find it
> on its own.
> Basically, we detected 5% regression on XDP_DROP+mlx5 (currently, we
> don't have data for any other XDP mode) in kernel-5.14 compared to
> previous builds.
> 
>  From tests history, I can see (most likely) the same improvement
> on 6.10rc2 (from 15Mpps to 17-18Mpps), so I'd say 20% drop has been
> (partially) fixed?
> 
> For earlier 6.10. kernels we don't have data due to [3] (there is regression on
> XDP_DROP as well, but I believe it's turbo-boost issue, as I mentioned
> in issue).
> So if you want to run tests on 6.10. please see [3].
> 
> Summary XDP_DROP+mlx5@25G:
> kernel       pps
> <5.14        20.5M        baseline
>> =5.14      19M           [0]
> <6.4          19-20M      baseline for ELN kernels
>> =6.4        15M           [4 and 5] (mentioned by Toke)

+ @Dragos

That's about when we added several changes to the RX datapath.
Most relevant are:
- Fully removing the in-driver RX page-cache.
- Refactoring to support XDP multi-buffer.

We tested XDP performance before submission, I don't recall we noticed 
such a degradation.

I'll check with Dragos as he probably has these reports.

>> =6.10      ???            [3]
>> =6.10rc2 17M-18M
> 
> 
>> It looks like this is known since March, was this ever reported to Nvidia back
>> then? :/
> 
> Not sure if that's a question for me, I was told, filling an issue in
> Bugzilla/Jira is where
> our competences end. Who is supposed to report it to them?
> 
>> Given XDP is in the critical path for many in production, we should think about
>> regular performance reporting for the different vendors for each released kernel,
>> similar to here [0].
> 
> I think this might be the part of upstream kernel testing with LNST?
> Maybe Jesper
> knows more about that? Until then, I think, I can let you know about
> new regressions we catch.
> 
> Thanks,
> Sam.
> 
> [0] https://issues.redhat.com/browse/RHEL-24054
> [1] https://koji.fedoraproject.org/koji/search?terms=kernel-%5Cd.*eln*&type=build&match=regexp
> [2] https://koji.fedoraproject.org/koji/buildinfo?buildID=2469107
> [3] https://bugzilla.redhat.com/show_bug.cgi?id=2282969
> [4] https://bugzilla.redhat.com/show_bug.cgi?id=2270408
> [5] https://issues.redhat.com/browse/RHEL-24054
> 

