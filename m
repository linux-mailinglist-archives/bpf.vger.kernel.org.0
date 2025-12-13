Return-Path: <bpf+bounces-76553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4714CBA490
	for <lists+bpf@lfdr.de>; Sat, 13 Dec 2025 05:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DA4B30B1DB1
	for <lists+bpf@lfdr.de>; Sat, 13 Dec 2025 04:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B8517C211;
	Sat, 13 Dec 2025 04:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ACdt4JpO"
X-Original-To: bpf@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020118.outbound.protection.outlook.com [52.101.189.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58783B8D48;
	Sat, 13 Dec 2025 04:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765599588; cv=fail; b=Lgf+aoA7unZon4/lhyB7SGjiXo0rFJTqBjaRMH4Nz7e5R5T2XfDXJIjB58POZmNiJFXqIgNB2MkZnAQwMfAYc5GGuz6GzKQvuqghaQQ+FOLzLOtuMKNpdS+IQiGwWoYIJr6hISCZLXfdz+IYhSM0kXZLjdGBxjjxAKV3yQEzFbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765599588; c=relaxed/simple;
	bh=5iLmY87XsZ+iJhDZOI8+TImhzbLWcckBspeSET93saU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hEB5N2uDKaYm5LH68F4QgZ9LSzCqqhLPOyfLeDNX2gxi+CjEcDObMlymYVEa2demSjiw3pUDTEH8M92tz/IQTR+aRi+QPCq2cVkM37ir+4irDA8RsSBLcbl55cPtz/BKqqXta58mKpa5ZlDmVqArF5iURLTxXzBm12u5ur6EDeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ACdt4JpO; arc=fail smtp.client-ip=52.101.189.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoW66iW5OZfPntOEnKKbWkvpUDGPyUH8A/VHT8TPi7rDMzpSEpH1SfeAe1QrwprZ3L/8SExoVxoMfKP6PtBRPFsohM+/NmCdPDZq/Nx5tquH/IvUW0MSO12+EMWiQnNjblUU+sHoi1WpbUUnhOfVrYEYI2qmcVFwz0y5RNizV6zpau2gU1r/Rl9RoQFs+Sn+VVbRIz81QKrcsrq6kDtnVIfI5jkkcMFGO/ax72D7EXD9MqBVkE24vrPb73kOim+UhAs42ZBCr41lV0VNWxjRQkutHxLiOpPyEKV1XvF1cZgQ6qG8GHnZ9XARFEMR/zVk3JU84srPuE+IEPuy6GgYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGC++4HXnuTLgYTymas2LRZ8/m5BWpruWmfQGV5gcVs=;
 b=n2y9rH3rHcwk2+HZQ1NeO1l4MpB1vhFWzruNoCZLQdPozsGC60x121df/ui8s2LwU/BNlu8UaqzkdAOt88LqhMY5g92+wNl0ARYg9ydCN5HoMM2Huq62ps8HBMcz+sTEGfyGyJ/fFgs4aIxNiHRk4PjzjDQ4oDPuB7Ttw5atk2HbjDkB0AUNpcmpW05W2N7X1P6h+3cwug6CvKvve5RVvMt6TK+vlwp9GBkPZCr9KWUQi1KPxstx7kISo9bAjYkyEg+NWUqLngLPdMQpKTckssoGZGZThNzvoYBCz5NnZafVEP9OwfgzQqTFsDGy+dLJijwRGKwJWhkWHWZ4ttMy1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGC++4HXnuTLgYTymas2LRZ8/m5BWpruWmfQGV5gcVs=;
 b=ACdt4JpO0m19D9otOFF6ue123xD+33Y3Sk88nYiX1/v6ldR6uK3+gDrMU9/cgfabJDrrPp7dUv8TUbP8v7DftMOO+LMiQ2hOVO+odln2OYI5bu0zI+yniAq2ktnJnj9xUCD8spPrukIZ1pq2UM18weJ7/6cfXq6hluEZl6jU0vrumz3ptLc7DYu4+mo4eaFScMvWeVoWMbxE8sdL4jSzRiYYonxH7WDW3DTTv0PGW958SQ2i7WwKbYc2Jtl3aq1fBwZFrISYY72A5O3+sD9FqOSxnx1in5Cs/LMSWk/Y8ADDVqqG8gtMNtkDwtMkgVpRoLEYDjPzaPFjOVwhIVCgag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB6144.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Sat, 13 Dec
 2025 04:19:43 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9412.011; Sat, 13 Dec 2025
 04:19:43 +0000
Message-ID: <09c76498-6a0b-4880-8a86-2a295c47c703@efficios.com>
Date: Fri, 12 Dec 2025 23:19:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
To: Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <e2fe3162-4b7b-44d6-91ff-f439b3dce706@paulmck-laptop>
 <B5D08899-9C23-4FA3-B988-3BB3E8E6D908@nvidia.com>
 <febd477b-c111-4d5e-be89-cae3685853f5@paulmck-laptop>
 <bce9a781-3cc3-45d7-8c95-9f747e08a3cd@nvidia.com>
 <0ec97a2d-5aee-4214-b387-229e9822b468@paulmck-laptop>
 <C0D26D77-316D-467F-81C9-030D4E0EBCD8@nvidia.com>
 <83cd4b4d-1eec-47d0-be91-57c915775612@paulmck-laptop>
 <7683319A-AB3D-4DF4-8720-9C39E3C683BA@nvidia.com>
 <d863f1ad-477d-4e3f-a0b5-fa9f282a164a@paulmck-laptop>
 <C9254103-18E1-480F-8009-003EB44F6F2F@nvidia.com>
 <39252902-567b-4e74-b6c4-91eae1df7c0d@paulmck-laptop>
 <20251212211839.6c3e2399@fedora>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251212211839.6c3e2399@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::20) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: f211cf50-456b-4d69-c950-08de39fed750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3BJWCt3MVBiTUw4YVVBOXhiK2lQQU1GYjZ1QWRzVGlOMExYWVpidkphSVdp?=
 =?utf-8?B?Q2NoM05QRjNTQzFZaDQ4SFJROHIrUnU2cjFRTjNOcjkwMmJYRVVKUzZ0WGhU?=
 =?utf-8?B?dUF6c1ErZnh0MmFGUVNDVm93VHNlR09BaUtCQ1IybDI4Qkxoa2xHZGxwbXFt?=
 =?utf-8?B?TDBub0k2UjdhRWtUL2dwZUpqN2R0R0JEWDBpR3cwUzNadEZ5TXZkck1oQnhy?=
 =?utf-8?B?eERGYUZYMkV3VVJWNGlERUdVSFdPb1cwVDB3aG5tMlRXbzN1bHU3bUxzSUZW?=
 =?utf-8?B?bmtzQTFvZVRoY1ZWU1ZNeHBlZXMzK29NcjlSTjBLR1Z4dFBHNEpwUGM1cUk4?=
 =?utf-8?B?aSt0eE4xeDFCRXVqSWlWOXdtbVE5R1NNZEJEeGE3OHhlYTJCdXR1VVQwSFJ5?=
 =?utf-8?B?UmgxdjJxSHc5SWxZREhvWlhjdjdDMTFuNFN1SXZoc3ZzYTdxRjQrSE51cnhu?=
 =?utf-8?B?Zlp4TmVFb0tWYTRUZ2Z5Z1RYcHJSNzl1bFI2L3F0V0RRQUpQSlp2cUhHVFQw?=
 =?utf-8?B?SWJoMGp0NU1ORHBmOVZuQi9GN2hZWlRMdDJMWStBOEVYdWpiSngzSXlnNXFP?=
 =?utf-8?B?NHQvVGc5Q2d1TUdLWUlMcnV0WXpPTFVLYUp0L0YzR1pKcU5uNTUwd0EvaXdZ?=
 =?utf-8?B?NGRBbENmeTFLSlJHdXNjcDMvUlNjOVphVTRWWXZhYjlvTk5taUJhVGJ3YjAw?=
 =?utf-8?B?SExpVkNXVk5SWmtyMzBVWGs2K2duM0dRQ2dQOHBGNXN0SVNNVVJxblZPOWJl?=
 =?utf-8?B?V1lDOGVCS1lWc2EwSDhtaU4yWTlsOEY3TTE1bFMrWnYxWERpUHNrVEg5dzFG?=
 =?utf-8?B?YWI1K2pzRTRTaTVrdEdhc0NaSnF2cSs4Y1l4V1hyTmc1MXgvNUQ2YUM3eXZl?=
 =?utf-8?B?K1BkOGhZdXlRSDJsODliRmJWNGJQWVcwbDE5Y2dXZ3BRWnBDUzBYZ24yMGJ3?=
 =?utf-8?B?RGpTS2pFYklBTkdXNnc3eW5ZYks3RjFTY1hkNmMwS1FsWGUrVmpESXoxMjds?=
 =?utf-8?B?dDZyZTNSZjBRdlZDbUFtOXkreWpMQ3E3U1BJeE56N0RldWF3bnp2OEJsc1lw?=
 =?utf-8?B?aC9PejdMaXVEamltbi9KTHQrRGxiT2dYQ3dmOHR2bkNweGZCUG5OaXdIWEs4?=
 =?utf-8?B?eUtWR2ZOYjhvcEtNNmpEeXNjYTVvMUhLS0cyUVpjUStjZVpxT1hHQ1QxazNp?=
 =?utf-8?B?Z05rRlY5eDBmMkJ2Z3hzZ0EwcXRsUjZjSTF0RE9relo4a3Ywa1gra2tMQnFW?=
 =?utf-8?B?OVpwNXhQY21XUHl2U2Rob2JZOWF3Q3dBUHlDQmdPRFd1V2tHRFErYTRwN2dF?=
 =?utf-8?B?YTJFUkF0ZEhmMjl3bnhwa1hNVmEvaitBMzRsRGtDQlFEenlWQXJvUTRxc1hU?=
 =?utf-8?B?eHJoSDVaODc5QkVpTGtmODRnUXg1UVhiaW03MWpQQkFEVm5MckFBclR0UzhO?=
 =?utf-8?B?UHVKaHJNeHQveFg3d2dZY09PRGc0QVNXRDVlcWxqQVFiS3pFVmwyVkxiV280?=
 =?utf-8?B?OW9xU0ppQWxydHVtcEJiZXVzS3BNZW9ieENpMys2WWVQWC9lNGljZml0Z0NS?=
 =?utf-8?B?SzlmSldqVFdGMzNvZDNHNWs2WXp1Nll2bHdWamdTS3hxYkdScEhVR3h2Kzhp?=
 =?utf-8?B?RjFOODlsWExieFdVR0hLT29RdmJMS3BqYlp6MmZ4MWtFVnh6N013MFZJeVps?=
 =?utf-8?B?cVpzbXhYeFM5VlBNelVMZ2lhc3RWU1dkSVhqTHlaSWpLdWZIZFhLQUVHMmxR?=
 =?utf-8?B?MWRkV05zV3o4d0twaElVanBtMURqMEZPQTVhb0RVcGdIMmJDV2IzdGdWU040?=
 =?utf-8?B?V2NHVDFVVk8vTXpsVDl5cnZ1T3gwREtFMm9UQ2RZbStXT1p5SExPUjMxU3kx?=
 =?utf-8?B?WVRVOHlscHNzWXREQlVGMWhHV1FobkxkRWlaV0VHREY3eVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUJYQ3BFUk5SV2J6UGFIYytYYkwvVDU2S1lDeHg1THQ0QmpmbVlPN2h2c2ZV?=
 =?utf-8?B?ZXpibkNxdGJlcHQ4YUV1RnlKUDAyMFdWaGkvV3BncWRwam1iWDRPcGFKOC8x?=
 =?utf-8?B?WWR0Q2krdmwwbDBSY0g2b3BuTnZORmQwNlR5WHdQa2R1b3hyaXR1STdqWkM4?=
 =?utf-8?B?SUY0dUFOKzZYUHRPSkhtdEpiOTkxWXdCTVdFektqMDRxVk50ek5nbnFwNXZX?=
 =?utf-8?B?OW9SUU0zNVk2eTBQaWpzWmZoT3NJWUZrN1hqRGg5VktkeW1XcVFIR3NmWStV?=
 =?utf-8?B?c3RicWpPWmd5RTlucWp2dHhMUzlCRzJkbFhlT2MySDVKalJJQ3p3VGNUcmFw?=
 =?utf-8?B?VlRhTURZRUhmY0NKU0ovWjVXRTZrQVQrbVM4Rmd1ckpqaDBjNzg5L2tmWTB5?=
 =?utf-8?B?c2NiTnhVZDFtTTdRY09pQ05Ed0JFL3prdkdmSnhONW9GMzc3RWpOdGhiazEr?=
 =?utf-8?B?L1RXWmRYWmR4RE9IS29DbTE2Zkdid1BjZmtQMjYxTHBKclZlbU03anlGM2ow?=
 =?utf-8?B?bnorMVdCQW5YeHovR2lkbG4xRnpWQmFXUDdUd3B6RW5WWU9MMFlYRDNjTEor?=
 =?utf-8?B?Z01TMEsvNkxUaUFMQldKT29NWVJVanY5dGt1MEtiM1E0MHRkQnBaSEZOY2hk?=
 =?utf-8?B?clJkRDlUQkREVER0Y21MZXY3UlpBc2QvV1drSjF5Q0d2ZEZmWjVGT0tRNHRW?=
 =?utf-8?B?enJDUUsyMnZ4d0kzQm9mSGZPVVZKMWhxdGhvTEJsTzlHdnRzcDB4L1kyakVU?=
 =?utf-8?B?dTA5ZGRXOEkwSHA1MElHRFZod01RRzh0K0tPVjRibHh1N2RLdzlEV2RFRldo?=
 =?utf-8?B?NUFOZVl3T1hFc1ZqK3ZXTVpHbjNLNzkzUURRWk5wVkR3RmI4U3ZYUUZkbGhp?=
 =?utf-8?B?Tmp4RUNuZVJueUNONEhLSUlSWHI1cDVrc1lPNzE1RklsQ2ZiQkdCYUlKOXo0?=
 =?utf-8?B?LzV3REZpbUE2SU9NSGdoemhaK2JqVXlpYXYySGZMQmhPbXFhRUk0c2dJei9O?=
 =?utf-8?B?dWNFYWVnd3lhWGdJdEtTL1RXc2VTN0xhVEVVSGNaejhrdlY1dUJEVkZEcjIr?=
 =?utf-8?B?cW5jWk1zWnBTZnExMXhVYkIxbzliUXN6SE0wdU5IUWd5bmZvMDY4RDlhNnMr?=
 =?utf-8?B?bE1seFhQc3N1TUUxUFhzV1djOEl3S3d5T3kzMHdHWjZ6MndEeFljOTErWE5N?=
 =?utf-8?B?OCtLM0N5UFJUN3NEdWJxcStBQldZR29vV0xLejk4bjVmVkdoMFA1Q3oxTmRU?=
 =?utf-8?B?UjJaWTVJMDRhbWRuT3lsV3k1Z2NDSlY5YUV0Z1UvWGQwdzdadnZFUUdSdVBP?=
 =?utf-8?B?TE5mMzYzSGR1aGhYdUFnVTByNEdJTVY3Wk01ejZLYTY5SzFmUXUweWh0M2dj?=
 =?utf-8?B?WDNXeXRseTJrUUFTZlV1WHhwcGpsMDNFSENJQ0ZlWk1DTWZ4aFNiazBnSnZs?=
 =?utf-8?B?TkRFZzM5MDBTYkhpSmx6QlFsMzdOVEdWcUEydWpQQ0xlNm5EZThodHV1ZXV4?=
 =?utf-8?B?Ti9aUmtVUUtuVkhjSkYrcVFmWHZ3MUlhQ3lablVQSEJYdTNtUjBRSjN2ak5y?=
 =?utf-8?B?cnVkbEtNWUVpNE90Z2VSSmNpOE51MHBSVFd5RkIvenJtcjMzdW9WRHR1VnFE?=
 =?utf-8?B?RU1EbWxEVSsyQmR2aHp3eG5LYTZnamczN0kxNC9ZNXNDZUpKWjZwZ3R5d2d6?=
 =?utf-8?B?SktrOWIwZk5ZdWUwZStjaUlEVmtEay9rbzRZNnlzWlZNYVlWZ2ZSdGJ5MzJv?=
 =?utf-8?B?bGlNUVE5REdxeVNOdng0ZDJDYTZ0amZKeGpKTnVja0pCdEhiM2hndnlkVjcw?=
 =?utf-8?B?WlRSWk5RcWd4MDZ0U2JuUE9MRElpL2F0UDhaV3hwZ3JOUFRSTFc3dk5SbG81?=
 =?utf-8?B?WHlHeElZdGV4NEY2V1ovVjVsL0JzZHJHcVNPd0t2QnpQRE1hNnVHd2dBYlZM?=
 =?utf-8?B?WVlJd1plMlduUzZlNWxTOFNxdXN4WjJna3lWV01BYkdIWno4bWNTNEhHeVNU?=
 =?utf-8?B?OUh1eU9mUWFmQStKTFdncXEwY1cyMTBqQ2FFRktqUUk3R0hSQnpEanI0SnVv?=
 =?utf-8?B?azBMQXVNOUFEeUR0UnpTZE5ZNGxmREtMNXRKVUE2ZlRJZCtBYmU3V2lGRjZF?=
 =?utf-8?B?bDBEV3RUR3FqeXhlWitwS0svdVN0a1dLNm5yNjdvMmw5S1BtZnFCaXUrbmt0?=
 =?utf-8?B?L0E9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f211cf50-456b-4d69-c950-08de39fed750
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2025 04:19:43.2071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/komc88IEe57ruUZkfGlv1gHoe5qVkU9WUTAoqUQVXctJTPbzlPqm7KvVyD2EeKUqvZprYZeB+C3SM0Kh2OpNQqFvvqYxhIMoSLEcCz2+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6144

On 2025-12-12 21:18, Steven Rostedt wrote:
[...]
> 
> Thus, I'm going to keep this a PREEMPT_RT only change. If someone can
> come in and convince us that the PREEMPT_RT way is also beneficial for
> the non-RT case then we can make it consistent again. Until then, this
> change is focusing on fixing PREEMPT_RT, and that's what the patch is
> going to be limited to.

Here is one additional thing to keep in mind: although
SRCU-fast is probably quite fast (as the name implies),
last time I tried using migrate disable in a fast path
I was surprised to see verbosity of the generated assembly,
and how slow it was compared to preempt disable.

So before using migrate disable on a fast path, at least on
non-preempt-RT configs, we should carefully consider the
performance impact of migrate disable.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

