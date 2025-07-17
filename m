Return-Path: <bpf+bounces-63607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 790C1B08FC5
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 16:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF7F1AA85AC
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 14:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7215F2ED144;
	Thu, 17 Jul 2025 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ZmCdPzWg"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2112.outbound.protection.outlook.com [40.107.116.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246183FE7;
	Thu, 17 Jul 2025 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763613; cv=fail; b=WmJBkv5QEZcw14PtHwOXe22rsMVD1OldSQ3Tw+HF7RSwc141sGjTlXMTUpRAjebgTW61C9b6pvE6gF9A2CONICRM8CzZTYzIST6ACQCl7SoYYhX/TjRmM10am6g/v1jqYfp8enRsSrJoNJ/uln/chMQas9AQo0/+wg+OGCrzUB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763613; c=relaxed/simple;
	bh=0m6ES/0jnEo9d8i2roZlPKIKbHbbUTR15QBcnn6cGu0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bc81zoBpluwZee3Q0VOHWr3YTYWU9FfpR7D90valxKQtpmJro55mmTDLDAfUQrWvPVxk1um+aX+5cXP+BOa8NSWAhDJzQEsLLJhhnn1tv9zpcwXWTdGWSj5g3zig1JDAENrEFeQe36h2Km9H3GQ9p4MT9w7TV0xCUJyEx7uZJ7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ZmCdPzWg; arc=fail smtp.client-ip=40.107.116.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjgAcQCLfskrT+2ownxygeM+YhFv++xs2Dw/vq+wGJBbz+/xOKIIbv/o4uJzfKwShHWKYC510QggKifcAt1cQY0VCw92wRLEVVtdAKGErKp67nsg+HGCjxcLMShOrWVUYB+GvlC7m9fVxR5eBUpvO051VbuuzzOkh3NpEv/UR9JDXd4bkud0pa0TiQVWx8zRYY5wdwu8ScgWMN/fh0bx+2E3OfJt28Z56D3tJj+fpk+/zUttbpxUmn8Dd4ARW2Cv0vyyru/Mg6s/m75iyqIAeH8Es75+x7hFmUHyyd0QTHx02PSiymmYvLyKICUiynTJZwFjKwu3StuBohBf4ZZ4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEWmP9t6CWOdqUL7s965YL0bgswbgT9Sf8l7ISttahQ=;
 b=XZXmK0oF4C37W/M7jjcogdsj3drkAoDbAl1oJMtc/Z4xYKws+MaXXhXQMOixacPBtnPQGxJIi1OSd5v/PZJsO8aFneEnyEDTOZN8CAB9LXlNu+OBBkIxICGWjARm4xsd9faHkCKN/sOtm2Vt5M6poYkCs9E89uwngmfUy3G/acuLAr+LL03PT/Vit7kY2JuHeT+5flvyBN8slJlCXuGy1R5fNaAEyey9+3fPYxXPhxjRyFqDJST7Di2C/5zkm5Rm2n7YgvuNvwLfcnxcrdjjXV4ai4Zy0cZ4xfZEbWAg7WWB1zkDUdxTEwbvzGyTrPE34nvSMzRuS6IyzRDr33pLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEWmP9t6CWOdqUL7s965YL0bgswbgT9Sf8l7ISttahQ=;
 b=ZmCdPzWgCLmNrAqT2pzOpHtdWD47qVE8+lmfzZ5INxb5zk39lf8Opd974ann4k+dPoTuFrXfcJ00L39xWGn0sN7FxL844aiHQiT1XJJThO+b4wfnZbYBangtGuF6naV5JS3m4oiJ97oQWhRtOYfoeKG4Dew4Q+m/t71xfeYWVc7oODxFDVZhjW+QeE3rb0nzr0vJGyqB0KtPztsjlybcHPenqG3ZEL3Mb7GQxF2yQ1XiUdDq35UpyPgLta6DE4cbVQK+5PmOAyp4CiWRin2uUr/wJ/lKPILXn07YzVbMpzALfeFA4KySZ5+ShkBpgn69dzIg6FceuOPv45Zo8Dbcaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB5903.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:57::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 14:46:48 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 14:46:47 +0000
Message-ID: <2d9eb910-f880-4966-ba40-9b1e0835279c@efficios.com>
Date: Thu, 17 Jul 2025 10:46:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: paulmck@kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, bpf@vger.kernel.org
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
Content-Language: en-US
In-Reply-To: <e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0280.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::29) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: 85748041-b3dc-4db4-a577-08ddc540c1be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1Job2IrbWNqS3dhaFh4SHlPZ1RGSjRreC9JRTIvVDdYakc1b0lRMy9Qak1M?=
 =?utf-8?B?U0Rad0tlM2ozb1gwS1ZvcUs3YzEvZURCR0E0RDJiK0k0NWx5ZUlUaGlqS3Bn?=
 =?utf-8?B?elpzOCs0UFU3OVhQNXRuREQyZUZwZ0RCZmM2V3czV1hjVGZCTEJ4WGtmVy9P?=
 =?utf-8?B?NkVzbVNvMlZvOWQwZHdSa29aK05zaTNiZ1VFbUdubFZPVHh6ZFFqTjhmODJP?=
 =?utf-8?B?aWZEaExscnZrbm9LbUtSNCswZ0Y5bzlkSXJnRGs5SE5RWkxobGFIVVpFV3c0?=
 =?utf-8?B?Tkh2cVZvK3ZmUHpGYVNoTDdxNDBGc2NBWUpnNXdlME5VdzMzUXlRaFRRaG1w?=
 =?utf-8?B?WGR6aDZFUVIweVJHaTNCNnQzUWd0MFVzK1AyMllQOWZCeFBXdlo5aWNmbWds?=
 =?utf-8?B?cDg2MFJBWlZyeTFqMXJBRVhYWCtzVU9SUmw2TXlBem5yQnhHb0FLNU9WV0kr?=
 =?utf-8?B?RnpXR2IyMWJPVXlham4walpvUUIrYnRacUV3RzZXYVU2dGMwMkVIZGVsdEZk?=
 =?utf-8?B?L2lSQ3l1bmNvQ3JRbFdWbHo3UjAxTmdMT2d6M1R1LzVTYnBKWEg5KytQZlFG?=
 =?utf-8?B?L2YzY0lYMk0ycjU4MVRCRlVtdElkTlZ4RUx1Z1hGKzVkSEM2aHBhK3B6amtR?=
 =?utf-8?B?Vk5hN3ZtYTI4eDJlMC9ENEgzajBpYk9UQ250UXlIM1JLODVPZXdORGlwdHVI?=
 =?utf-8?B?dnhRVHJGK3NnMW1wNUFKT0JncHNpcndpeVNoZDZHRkE2UVIra1ZHQmRGWFlN?=
 =?utf-8?B?QlZIZnYzalhMRkZmNExyamdFa2xsbStFUjVUREJyRFlZSlEwWEZnbDdXd1hP?=
 =?utf-8?B?TEx1MkcybWZZZWVPQVhmSnpITGJ3NjZiWUkreC9JSWVzeUdhOW9uSVFnbzdY?=
 =?utf-8?B?dDFwOWkzMlFSOGJ0UFRkc04rbzByQm11WGl3N1BkaWFTdWJzRTV2WHplYmxK?=
 =?utf-8?B?NTN6WXdPek9kZ2lIV1JYdnQ3ZFVmNGNhSUZTaEVDeFJVWDJLNGcwUU9UdlRR?=
 =?utf-8?B?YXRJZ3MzejhnVFRaQ1lYOVkvc2VkeCtOZDJEb2oxaFlHU2gwNVZLT1pxbE5w?=
 =?utf-8?B?M0pwM0FDZ21EeXJKRTM5MXM1dnBRbFRCSnF3dGNvWEx1V0hKRCsrN1l1QXUx?=
 =?utf-8?B?STFNdUNEVHc5RmVDSzZBd2tKbTNxSURIQnNHNThpVHBEV1NkR0c5MU9hZy9W?=
 =?utf-8?B?VkJVejgwbFNsZVc1aUptYjFuLzZNY2drMnBZYlR5TlBiWHFLdW1SK1EvYkVo?=
 =?utf-8?B?M3UyblpPV1M0L2xXcjgraVVTMStveGpuU3p5c0kyem1oZHZiVVVXZWpid2kv?=
 =?utf-8?B?YlRYajdFQklVRXdCUjc3RFpjUnB3MlI1Y3JGZnFhVm9kSy9idStOdFg1dWxU?=
 =?utf-8?B?NjFVUk90aFk2T3ljWG13MCs2MGpobFpmeFE1eDdSQ1ZXbWRDNEJLSjYwUEo2?=
 =?utf-8?B?SlJ1ZXAzV0w0Nm0wejBLd1llYWFCTlpLamxXTFY4eEQ3RUY3dVJjTFhJdDls?=
 =?utf-8?B?ZUF6UThaa1pZdnNtTUg0TmZ4aXNIUlRiRzdnTFVWM3lhbk03Zmg5UE1FTWl3?=
 =?utf-8?B?bm93VFpBazhZZUxQR25rb1RHd25aV2c3Z1YxQlREMnRkTmVhZFA4eFBKazBt?=
 =?utf-8?B?ZlpnN1BRb3VXWnFnMXlackpneEJnUWlNMno3MUR3UTMyQkZWVTV5YTMwa3k4?=
 =?utf-8?B?QkNDanpRTU11aFhwT1BNOXBOem5iMCttWkJWVDViWUozTjVLbnFaaFBxcW9J?=
 =?utf-8?B?bnA1VXZZTjFQSy9yZ3Y5amlua1prKzlFY0JQKzE0L2lBclIwZWxYUnZOdUEr?=
 =?utf-8?Q?MD53SjWeGcVpn+6hy6pLhXnusDUB6bH50W9w0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWZpTGoyVEx6WWEza3RVUFJrSlRVKzU2TUlaTFZMQjJXSDBoc05nb0ErTm9G?=
 =?utf-8?B?QkQvVzRZU0dITHlrZTd0Y2VGRUNrSFZYYmErVkxDMmltcWtmRnd0dWVBeU0z?=
 =?utf-8?B?SWlmMjdBR0FkS3RsNFd5dnVFNUJqWElYYk5OUFpldlFycXdQbVBtRzBHMm1x?=
 =?utf-8?B?R3YybmEyR0N5aXpza0RHWks1bFlGM0QrdmZBV3phKzN5MXVmNkViVDd1aVRY?=
 =?utf-8?B?M3djZmdodjlOSStlMVBoaG1uRVZrMCtMT0tQeUxMNXUxamtWS2tmNU01R0sx?=
 =?utf-8?B?NmhIWXdHemlNcFZZZkU4RHpUcUh1blpKTk9KSVlFR01JZEpwWnQ0SUJJMWxx?=
 =?utf-8?B?dytEdWw4RDBPcEtKeGVkMzlncERaUjcwY0xFcmg2Szd6MmNFMWhLc3F4OVF2?=
 =?utf-8?B?WmwrbGlBUVVTTEJUM21WdWZpTlBJSTRiS0hxTXNZQ0pRSzJXYlhwMG9KTnE2?=
 =?utf-8?B?TFM2NmsyRngvSFBaUnJ5c3d1dWJETXh3NXdYK2t5Mno4THJ5bTNMT0xFdHJW?=
 =?utf-8?B?UjZJN3BCOGRENXlIazlBcmF2c0dPSHBpU2tqKzM2QytLdEZpOWNvSG10akkv?=
 =?utf-8?B?ZU5JNTM5bmUzcGtYMU0xeGx3WWNHdjZ3eWk1L3pqRXdPbVg3WWx6U1VYNEZK?=
 =?utf-8?B?SmVZOUFyNHd0Qk5OZ3U5RTRDazdnTUl6WmNKakxGQWU1TzRzNU9UMWRJRXpX?=
 =?utf-8?B?SURxcThDZVZueGtLNG1PNjF4SnJJQlEyaXRaYWRmMXFaZG40a3hjMy9kSlBz?=
 =?utf-8?B?b0NrNkpXUEJ4VUZXNFRHN2NRQklWR1ZUZWFYaUtzTWFIYWxraGpvblk0enJv?=
 =?utf-8?B?eWtNdUtMRkdOUGl0U3hPalUxM0VaZC80SDZzK1VJT1dBN1h2VCtmcFVpTXdV?=
 =?utf-8?B?VzVidVYxNnUwWHFVM3NmR3JONjJiREF0bm01eU5oT0s4clgzbGNNdHlGaE5X?=
 =?utf-8?B?VllUWHRacGRYcnhNZ1dsOEJIdDU5YWR4Wk1KU3dJZTRWejVtb3FGQ0grMmxO?=
 =?utf-8?B?ejIwb1BTa1dUR09HTHFuUC9yd0RydGVUVG9EajJNOUZlWlBXUlF1OHU1a0tU?=
 =?utf-8?B?c1E2WTR3T2d1SzR4QWdBd2d5enBHSHFQV0JJNVA0ak8zWGhHUVdzbk14NkQ4?=
 =?utf-8?B?eit4bE53TmJ0MW5MemM0ODlKOHNRNE9hRm1wMHhXdnhnS3ZqaW0yYVRDcWdU?=
 =?utf-8?B?NllYTEtUeWJuNzNEVCttOXJKN2RibWVHa2J3bXdXU0xVdjFIVnVKYTA3cFFp?=
 =?utf-8?B?UDJoU1BHWGdyWjhLSlRIKzhNOXhMbHNmenB1a0lQTlAydG14dHhvTlJCeVJJ?=
 =?utf-8?B?OHc0ZVJiNk90Mjc3REo3VWMrc1lOdmQ1am45djg5aVNETjFTWmxZd2hxUlA0?=
 =?utf-8?B?SWNBbmlWZjVhZmVzLzRKellZRVp4L2lKMXN5cHp0R1F4RERHa2dBRyswRlpr?=
 =?utf-8?B?VUJrNUdRaFlBUElML0Zybnlhd0wvcHduMUdlamRMVzhqcDNFRlp5UkJSRldL?=
 =?utf-8?B?dGt2WGcya1dYUFh0a1dpSE1mcVRqdHRxWkFxazFIcjJ1alp4RDVHRWZJK1pL?=
 =?utf-8?B?QjMrWkErbWgvc1BVSG1GUnVqUTlDUVptMDhnOE1IV0tXWGFmQ1Z0MytsVFZN?=
 =?utf-8?B?YkIzbURSWGFCWDRXaXo4cXRvRlRROU5HWFkxWHV2MjhFa0djVDdEMkY5V09X?=
 =?utf-8?B?Mms0eVkycE1wVXl6Vmh4SE1Xb2NoazBUamlqZHczUTJkMkdXY0VuR3pQT1JG?=
 =?utf-8?B?cUw3c3FvcGN6aHNQZzBsbVd5dm9hRi96d2VYNnE5TFcvdHZWR2MyV0VvaTln?=
 =?utf-8?B?N0JmREdwbUE5VS9vaCtzTFRDaGJCZVJmUjZEVmlDWXpNY092Lzd4Y3RvREpl?=
 =?utf-8?B?U3ptT1FKbEZQWWVxNzNra0ZOVE5WVjU2N2FWY3V0Y1JKQVAxOUVNY3lEYVRB?=
 =?utf-8?B?SDhXVDJ2bzJMcTY0TDFQUkNnUEppWW1mT0gzWkh1a2FFbkRPVlJwd1Q2anUx?=
 =?utf-8?B?VHg2NzA2SXpkaU1hKzZqRG05QXBpYUE3RFViY21wYW9NV1g2c3NKWmZjWWNz?=
 =?utf-8?B?UEZyOHNZdkpsNlgvRkR2QSthaEVwY2g0MVYzVWtGem9XNEhBeFFzUFMrb1lq?=
 =?utf-8?B?ZFhLbzhmT3lsNmphQzVVWXpBWGZyZWdycTQrallESFhqZFZ3VEhyOWREekwv?=
 =?utf-8?Q?Wek7DayHfndEsrsG/Pyz+lg=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85748041-b3dc-4db4-a577-08ddc540c1be
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 14:46:47.7027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uF0pjSFGWj149sjHp2Rwbp+J0D+X5t2jhF6c9jEeVR5BrVBAL+KAtNnyLGozng7SBlZrJiVZl1OAsSb3DHRmrszfWKxZYv7YIg2GjPaVfMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5903

On 2025-07-17 09:14, Mathieu Desnoyers wrote:
> On 2025-07-16 18:54, Paul E. McKenney wrote:
[...]
> 
> 2) I think I'm late to the party in reviewing srcu-fast, I'll
>     go have a look :)

OK, I'll bite. :) Please let me know where I'm missing something:

Looking at srcu-lite and srcu-fast, I understand that they fundamentally
depend on a trick we published here https://lwn.net/Articles/573497/
"The RCU-barrier menagerie" that allows turning, e.g. this Dekker:

volatile int x = 0, y = 0

CPU 0              CPU 1

x = 1              y = 1
smp_mb             smp_mb
r2 = y             r4 = x

BUG_ON(r2 == 0 && r4 == 0)

into

volatile int x = 0, y = 0

CPU 0            CPU 1

rcu_read_lock()
x = 1              y = 1
                    synchronize_rcu()
r2 = y             r4 = x
rcu_read_unlock()

BUG_ON(r2 == 0 && r4 == 0)

So looking at srcu-fast, we have:

  * Note that both this_cpu_inc() and atomic_long_inc() are RCU read-side
  * critical sections either because they disables interrupts, because they
  * are a single instruction, or because they are a read-modify-write atomic
  * operation, depending on the whims of the architecture.

It appears to be pairing, as RCU read-side:

- irq off/on implied by this_cpu_inc
- atomic
- single instruction

with synchronize_rcu within the grace period, and hope that this behaves as a
smp_mb pairing preventing the srcu read-side critical section from leaking
out of the srcu read lock/unlock.

I note that there is a validation that rcu_is_watching() within
__srcu_read_lock_fast, but it's one thing to have rcu watching, but
another to have an actual read-side critical section. Note that
preemption, irqs, softirqs can very well be enabled when calling
__srcu_read_lock_fast.

My understanding of the how memory barriers implemented with RCU
work is that we need to surround the memory accesses on the fast-path
(where we turn smp_mb into barrier) with an RCU read-side critical
section to make sure it does not spawn across a synchronize_rcu.

What I am missing here is how can a RCU side-side that only consist
of the irq off/on or atomic or single instruction cover all memory
accesses we are trying to order, namely those within the srcu
critical section after the compiler barrier() ? Is having RCU
watching sufficient to guarantee this ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

