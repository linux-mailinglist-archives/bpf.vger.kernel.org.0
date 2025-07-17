Return-Path: <bpf+bounces-63660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32328B0950F
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 21:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E305A23AD
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 19:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75622FA655;
	Thu, 17 Jul 2025 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="qYz8GrfQ"
X-Original-To: bpf@vger.kernel.org
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2113.outbound.protection.outlook.com [40.107.116.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203A821B9DA;
	Thu, 17 Jul 2025 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752781016; cv=fail; b=OziePGFHzH9BAEEnDVB3lEfivbvd5S6NNVT+egQmdVvtgR93OMiF7FsaiJV5ZyWiExmL6xLm/LIdaIGyehcss3RrxuoXKTERyjLtJxVXC/mVITp8LfiFMcsTURLWQuFz99FOE549FUWnYlKSBa3vm9F43/CxUIIuHFKOg/Nw2fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752781016; c=relaxed/simple;
	bh=F3JjrQUn9BO2oWAbHI2KU1QC0HyZYo7ekHEp7rQ9DPY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pS8SbMys9Ulx0dLbfEbXKdqxZz9LIZh7sedKVcnkx1V6kNPZQDAcmC41srbSkTMnMxqtY+XcqR8yNXB4/v4AujBj7dTn/bPx3tlzlqRxLayq+hgMq/huPNwV8a/0iclEl7yfnb3sOfoTRqhvyQSzicBsmo+PqaoUviU9eeuBvzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=qYz8GrfQ; arc=fail smtp.client-ip=40.107.116.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7OgcpINxi6hjQ+nkQDAOs6u19D6EJyBrwjx5AKqbumXil/glL3s3IgQPTNbVpJ7NAM3PHS6DUQgYRB4kGc2FkwyN2NtvlUKo7tom4d0leLTiCchc562AkVaPpzPBKLj7EXxT9P5pl674ae9FLUwzF1tnnZTo5jZBCTxgZpQHgcBYPsqhTidF/4cgTDP1ifyC8KK869sHLjIJKmAr8rWVN+RYtE1N1gE1hGTXABuHGdutTRbKK6M8evrzz4mPLXvqa4nXPWsIr4AYf/Vva0iQ1WPT8mfWmBiEVxH3WOI9z85MDFWZAPPGTxh1BjiQZuy5ccHSrgOkhyG5XN1CRcx/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNEqDSWC5/PLF41NiHC+3F0482L+G87cW4HlggdzOIs=;
 b=rDuyPxaH66zbCDW4ETd1imRR7jweZTpW4d6QkDt7lsDXSMD4uZJUC/TuPGiMXo7n6YLR2XuZtu+ioIkopt9sxYrYBelBqfii4pWEIPY16rt1DW26t4Abvii3jpBalLzqUUQq+jdeOrLQNLemFK7q9Y0+vUX9pRSoB1iLIIK7BG5IqcikwnIKnx7JxuEDdYVyBMgPCuzizJYBtWnd3oBYLfJP8G9Ucwwi96+fjEul3FsEbWINUXHn6e3I0kUBi/TrmQvsTQqTxl6zlb08zfpwEnZuOFh0ty1jpVoKDMekwzR/VYqYE3/wqqRC+YYnF1xutcVdBRJEBr6AfDo87GtFww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNEqDSWC5/PLF41NiHC+3F0482L+G87cW4HlggdzOIs=;
 b=qYz8GrfQmDhO4oNOXJUjTa1IrOt5gUPttStomj0l77XohA3XaAjxwEDk8ZV/YHkFCGd8npC/2mzk+nDKvmPs7aGYpWsF1vIeLnO9guiTvxr2gfujsUCGBxPkW0n35cgNWwn1UqOyP6aqRE4OJ35NZpZTZESN9J4AGRqyYBkXMXl7dvkU55PaEZLGQLifltsFHfl9tCRoX24S+AarG1LoQCPNoiLIPQageeXjr2QSw0Y/w09MQLbju/mNNh7xDf3T8563uYfIclwFrRzpwsBhYhdT+X+UTcGyvSJHCrS1AM2bvA0cEgr0t2AH2ktFkJ6QVeydUCqf1ZJ+2KP+cCHYIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB5509.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:61::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 19:36:48 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 19:36:48 +0000
Message-ID: <5dc49f5a-ddda-422b-a8af-c662ee53d503@efficios.com>
Date: Thu, 17 Jul 2025 15:36:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
To: paulmck@kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Boqun Feng <boqun.feng@gmail.com>, linux-rt-devel@lists.linux.dev,
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, bpf@vger.kernel.org
References: <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop>
 <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
 <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
 <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
 <20250716110922.0dadc4ec@batman.local.home>
 <895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop>
 <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
 <e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com>
 <2d9eb910-f880-4966-ba40-9b1e0835279c@efficios.com>
 <2f8bb8bb-320e-480f-9a56-8eb5cbd4438a@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <2f8bb8bb-320e-480f-9a56-8eb5cbd4438a@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0010.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::29) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB5509:EE_
X-MS-Office365-Filtering-Correlation-Id: fafde627-d5cd-4d53-f9d9-08ddc5694545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEJzejlsaFN1MVFNSUYyQ2tYNlQ3U2NTdTlSaDdUZi9xcit4MG1SYXdUQXlN?=
 =?utf-8?B?WDg0enZmRE9TamdNbTBJU293ZjMzQ3hmNVl0K1NXTlNVdzJWS3dLSDBiZTlR?=
 =?utf-8?B?d3I4SE9sVEwwUWZycEViS3U4VXVxR2VobDVnRTQ0WURoNWk4cld1NkVZbVJW?=
 =?utf-8?B?QjVHNUszYzltVjFzVXRKOG1GZEtkMHQ0NjFTc1pWUHIwZUNwWDdIU0VuWkdx?=
 =?utf-8?B?QmNtWGp4SFpJOFRYeExFUzNuMHhGUi9MRldxYmJwWk5nL1h5ejBUaFBGWWJr?=
 =?utf-8?B?enZzWVlUeVdZTUZ6NHA0YVh3T2FObUhENHkwSm5GRFFtdUlnZktPWEIwYWhU?=
 =?utf-8?B?Y2lMYlNJSHJTWGdacGNIanNaZHBRc2hBV1dic2VyWFlBMHJ4aWRzeUt6dG9j?=
 =?utf-8?B?UEI5YzVqWEI2M3pTVm5JK2JCbk1ZUUx3T01yNldhQmNCeG1wOHdMV0pDQjRS?=
 =?utf-8?B?S3ZLVUJiZFZrcGMxNThYT1dNYlc3U2xlbkgwak1id3B0WXRaNVN0MlZHNEZk?=
 =?utf-8?B?MVB5REg3amZlSFY4V3RJWlNES1A5Qm9DMDRyUndIazBBSW9SaUdFRjR6bEVz?=
 =?utf-8?B?UzNHWVRGdTIyeldrd0FuQmNFWlVTNkhvZnhReGNZRXFOcUVZRldLT1JtQXVh?=
 =?utf-8?B?OE9LcWJTNXIvZGxwZEpNTFRYQUREOURHdUtvQXFTWFhGYmpYRTJ4YUNlOElB?=
 =?utf-8?B?elArYlBVa0JDSVVWMW9TVTdlekpvZ0dJZ1VEQ0xrRnRCUFBWWGJHcWtxQnhq?=
 =?utf-8?B?YlhGcVkzVGVPZWdPTjdlTDdqL2pGQTllL0tRM3JBVThzT3dHMmxsRUx3MDFy?=
 =?utf-8?B?dUkxQlRCWU5NZXZlZFJIcFNuakNFVGNvRzRFZjRVZWVsTngxYWVIU1d3Q3VK?=
 =?utf-8?B?Vlk3VHBRSTZTZTIwbnZXSmx3RG94c3h2R0FiYVpnd3YzTExMNUNzakp0d2RW?=
 =?utf-8?B?SStpOE1IcXozNS9oSnBBaEVsejhKbzQ0aWRTM09iVmNTcTcva0R0L1ZXUU9Q?=
 =?utf-8?B?c2d1SThSdVd2djBwdXV2TDl1NGdPUjYyUnR3UmhuRkFGc1MxaUxUQjd3YkF5?=
 =?utf-8?B?ZnpRZmgzMlNiSmM3a3hqTC9yYjB3ZjAyYXRGOTBZaUlGaTZaMWtiaDNHM09i?=
 =?utf-8?B?cnkwM2cxU2VPTkUwbnJsRC9yYk9vS3IvbTRSeGtIK2RqNURqQkxYNFhGMitI?=
 =?utf-8?B?eGN4VnFqdWZSSWU4RzR4ZjJXQ1Q1Y1p5UHpncTRWMnpLRlhkZnB0NHlCZ1R4?=
 =?utf-8?B?UE85WDZ1V2Z2Y0picFFyaGZTTVVrZFVaVDhDNFNWZkJvUjlXTGcwV2xTRmht?=
 =?utf-8?B?UDNYcDVna2U1SWxCcDRuNzI0dVNXcXV4dHorQzNnV2d0SGZDVHMvWGZlYm10?=
 =?utf-8?B?ZmlqYkxoNXduZGFRRzdvSEpVWlhvTVpCMDViR3BIQWx4SldnSkIvcWZ4bWpY?=
 =?utf-8?B?SVdwcGlWUFppQzBSRk1iWFZNSXpXVjNSRlpIdnd0RHFBK214Sm01UXljSDBV?=
 =?utf-8?B?QjhobTRGTUE0UjRSR1g1T1ZIaWVnbTQvOEtZTTNqRVVVRHB2VjRqdnJ1QXU0?=
 =?utf-8?B?ZzVtaGpTMGZyZjdBS1dZKzNWN1FDTUNURGtLNlB3L0JrZ05teEJKS2hOak9J?=
 =?utf-8?B?KzRXV01YaTlYT3VBZGh6ZGpxN1hBUFNpS2d5S2tpR052ZU5YZUhmd0RQdXM5?=
 =?utf-8?B?SHZuWDBPcE5oTkJvZnJRT1RYeFM1bjZUc1lxcnhEZmRnMXdzc3o3UCtCVjdX?=
 =?utf-8?B?b2J2QlF1ZE13R3N5NzBnZjIrM0laMmdZU1NNeEZHMUtVbzIvZkRkVGdZYU9E?=
 =?utf-8?Q?hRY57RLXp70Gcqptj/2ubdptnkYQW6iUSHD7s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGpWK0cyWUxGK2hZYnl4cndIQ2tkWGFvTGFVYy9YYVBWZjZhTXdEMkcrRk1R?=
 =?utf-8?B?UXRCVzQ4bTQ3Mi9LRG90U2IrWkZkcVBjdHpEeWgxcFM5YmdEZXJKWkZYZU5q?=
 =?utf-8?B?cFBkQVNVSjFOMUdvUVBlWmRNVTVGTmhLOVh5eWg0eGNzNFU5VFdWSEUwbEQv?=
 =?utf-8?B?QjNTd053emZaQ2dLb0lkR0ZsZlZOOGN2S2hsaWpQbzFLZkhpWE9CWWV5cVZo?=
 =?utf-8?B?RDFwRUk1UGo3bTVQVDRYNE81dnVpUVhxN2hSWjlpblFyQWc2cnp4a0phVUMy?=
 =?utf-8?B?NE5aaUFpSjBWeTJIMk8wTUpxVlRISkhSc003b1p2WlpUamY3c2ZkWmJXNGNI?=
 =?utf-8?B?QUNPUGZNYmY3ODdBMTgzaHBaYkx0UCtub0ducDVqdmdmNjBXMlN6SnlvYzRx?=
 =?utf-8?B?UTQwZVRSc09qMFpsY2RRN2laVWpLWlZid0hNbzl3UitoNkVmT3JGNkN4clFY?=
 =?utf-8?B?cHVFNTJRakd3YnNYM1BUUUxhaXczVk9ZaEFvRU5IWUdqZGZQRWx4UlptQjhJ?=
 =?utf-8?B?YjV4Tno2VXIxbHpzeEhMT1VxVWQ3aXV1dTJEaDRnMVdpbCtXQUFaNHl5M0RS?=
 =?utf-8?B?Y2ZPMHlQMDVjZGRpZy9yVjBUajNESm9sMnZ2RC8vWGJJc0hmUkpCa1o2MWdh?=
 =?utf-8?B?TEVJYTVabkMvWlNIQ1EzN2tONlc0T1pxNWdPQWtURFExYmpZWmtmcjFvZ09V?=
 =?utf-8?B?T25hNGV1bmFxS2QrWGVVZXF2NnlybHNYQjNyYlZmZnMyY3hGaXc2SWwydERy?=
 =?utf-8?B?VmFPMDhIYktkZGtJK0Q4eE5Ra1FWOHN6OHUxY2h6S3VseDlwYVdraGI4UlJ2?=
 =?utf-8?B?T3ZlOGc3cEtzaVVQTWZVV3g4OXVQZ0gzaEk0THU3Snc2V2piWWdodHF4TTc3?=
 =?utf-8?B?SkpSSGxwM0RrY2s4RC9vVUZ5dXE4WXpuWHQvZHBVQi9WeTE5eDIyVFlrMGdM?=
 =?utf-8?B?R0NtNnJGTWVoQXd6cFhNR3owOHRXak5UcXRRbllmWndwOTE0ZjNRVDFTSDBP?=
 =?utf-8?B?a29keFFTNXIyRGNVMEIzZjB4d1Zuc3kzMmNPOG9HTGRYRURDbU02WnpSbSts?=
 =?utf-8?B?QzBWcFV6ajNiR1daR3pPTkdjQWxPUlkySXZEQUxnYWdCb0RReWw5dUt4SFNC?=
 =?utf-8?B?MFFHVU5RQ2M4S1BNeTFQa1V3bFh1V2lHUm04UUVaaDFiTTVHakFKUnduVXpF?=
 =?utf-8?B?U3ViZlpQSnd3aXEyVkszOUNadlJxbWxJZ2NKM0IxRmI5NWVRdDN3c1hzVUlO?=
 =?utf-8?B?ei9tcUFtZWt4b2R2QUsvZU9tR04vaEY2aVNsTStiQ3pJV0hYTlZnRkxqczFB?=
 =?utf-8?B?NEt6bkpERzdJbjFDblE1c0NscnhOaXF4RHJ3TkpDWVYzTjhlMGxrZHlWRjRk?=
 =?utf-8?B?bzFDUG5yMmxRaEs4R1lSd0VhZi9OeVRPVVdNbWdSZGticXFycUxCOWRDVXJo?=
 =?utf-8?B?d0MvY3hmYkRsTHJWUGVzS0JXUDR5Qm5tMXNFYitaNnh0VHdBaFJoOW1lanox?=
 =?utf-8?B?VWxhRTBET3RyLzh0a0xkZkNFR01pZDE1NERjQmFyVW5VUmE3UkhUTG1KdUNn?=
 =?utf-8?B?MXQrcnp0N05ybWwva1BSVE1lREVnZklqd05EcGRiZ1FzZHRiZ0hGVUVYOWVs?=
 =?utf-8?B?c1dic1lKYkpBbXBxY3JPTWN6d0FOb0MxMHhsRE5GNzM0OUFkcld3dnFxZVJF?=
 =?utf-8?B?dlRxQmlmNERHSVJXT0s0MEt0RWRaOWZwaHh4MHF6TitWelB0Y251TjFyaDE0?=
 =?utf-8?B?U1M3T0JuellzQWVKRktQWjFscWJMQkJCS1R3RHl1a1BOWjQvSUlkQ3lnMlJr?=
 =?utf-8?B?QzA4b1d1MU9GcERDWUdYa3lvaDZvSHhOOU9iZW5DckZoZ2hSZ1BCYWlpUzRD?=
 =?utf-8?B?VTdERkJ5WHQ0ekZKVDNBdUZ3clgyeklnUlM2bWV4eEVxclljbUt6aEVmWlRB?=
 =?utf-8?B?cXNhNkdLdHBHOEl2TG5kd3RjL1JPdE13YUNYOFpnZjNlMDczWjEvS3JWaC9Q?=
 =?utf-8?B?Ym82VDZqTmxib3JqTWlja0pYeitvOWRBWnlZblBFZkh0OEM1c1FiVFd4L2RP?=
 =?utf-8?B?bzR2clo5T1JwT1RwcFhBYWJQTlNiNGpRMTVBc291TTdTbHFiNjZTZHRmR3U0?=
 =?utf-8?B?YlRMalB4elRhbklXVUpLYXpBRnN6WkxQYll4RFZNMXl6UmJ5RkFkd0JUNkVN?=
 =?utf-8?Q?qckH9ia33IMzVTalta0Vh6Q=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fafde627-d5cd-4d53-f9d9-08ddc5694545
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 19:36:48.2711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKxusP6Pfx0vBkc33K++UWIW7sOjpf6gZ0og2gvItL/Jzx5gr5e6/VkHWKhM629GNUIGijtzcOElAUSACsnbWEYF2nCz68Esms522pntw0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5509

On 2025-07-17 11:18, Paul E. McKenney wrote:
> On Thu, Jul 17, 2025 at 10:46:46AM -0400, Mathieu Desnoyers wrote:
>> On 2025-07-17 09:14, Mathieu Desnoyers wrote:
>>> On 2025-07-16 18:54, Paul E. McKenney wrote:
>> [...]
>>>
>>> 2) I think I'm late to the party in reviewing srcu-fast, I'll
>>>      go have a look :)
>>
>> OK, I'll bite. :) Please let me know where I'm missing something:
>>
>> Looking at srcu-lite and srcu-fast, I understand that they fundamentally
>> depend on a trick we published here https://lwn.net/Articles/573497/
>> "The RCU-barrier menagerie" that allows turning, e.g. this Dekker:
>>
>> volatile int x = 0, y = 0
>>
>> CPU 0              CPU 1
>>
>> x = 1              y = 1
>> smp_mb             smp_mb
>> r2 = y             r4 = x
>>
>> BUG_ON(r2 == 0 && r4 == 0)
>>
>> into
>>
>> volatile int x = 0, y = 0
>>
>> CPU 0            CPU 1
>>
>> rcu_read_lock()
>> x = 1              y = 1
>>                     synchronize_rcu()
>> r2 = y             r4 = x
>> rcu_read_unlock()
>>
>> BUG_ON(r2 == 0 && r4 == 0)
>>
>> So looking at srcu-fast, we have:
>>
>>   * Note that both this_cpu_inc() and atomic_long_inc() are RCU read-side
>>   * critical sections either because they disables interrupts, because they
>>   * are a single instruction, or because they are a read-modify-write atomic
>>   * operation, depending on the whims of the architecture.
>>
>> It appears to be pairing, as RCU read-side:
>>
>> - irq off/on implied by this_cpu_inc
>> - atomic
>> - single instruction
>>
>> with synchronize_rcu within the grace period, and hope that this behaves as a
>> smp_mb pairing preventing the srcu read-side critical section from leaking
>> out of the srcu read lock/unlock.
>>
>> I note that there is a validation that rcu_is_watching() within
>> __srcu_read_lock_fast, but it's one thing to have rcu watching, but
>> another to have an actual read-side critical section. Note that
>> preemption, irqs, softirqs can very well be enabled when calling
>> __srcu_read_lock_fast.
>>
>> My understanding of the how memory barriers implemented with RCU
>> work is that we need to surround the memory accesses on the fast-path
>> (where we turn smp_mb into barrier) with an RCU read-side critical
>> section to make sure it does not spawn across a synchronize_rcu.
>>
>> What I am missing here is how can a RCU side-side that only consist
>> of the irq off/on or atomic or single instruction cover all memory
>> accesses we are trying to order, namely those within the srcu
>> critical section after the compiler barrier() ? Is having RCU
>> watching sufficient to guarantee this ?
> 
> Good eyes!!!
> 
> The trick is that this "RCU read-side critical section" consists only of
> either this_cpu_inc() or atomic_long_inc(), with the latter only happening
> in systems that have NMIs, but don't have NMI-safe per-CPU operations.
> Neither this_cpu_inc() nor atomic_long_inc() can be interrupted, and
> thus both act as an interrupts-disabled RCU read-side critical section.
> 
> Therefore, if the SRCU grace-period computation fails to see an
> srcu_read_lock_fast() increment, its earlier code is guaranteed to
> happen before the corresponding critical section.  Similarly, if the SRCU
> grace-period computation sees an srcu_read_unlock_fast(), its subsequent
> code is guaranteed to happen after the corresponding critical section.
> 
> Does that help?  If so, would you be interested and nominating a comment?
> 
> Or am I missing something subtle here?

Here is the root of my concern: considering a single instruction
as an RCU-barrier "read-side" for a classic Dekker would not work,
because the read-side would not cover both memory accesses that need
to be ordered.

I cannot help but notice the similarity between this pattern of
barrier vs synchronize_rcu and what we allow userspace to do with
barrier vs sys_membarrier, which has one implementation
based on synchronize_rcu (except for TICK_NOHZ_FULL). Originally
when membarrier was introduced, this was based on synchronize_sched(),
and I recall that this was OK because userspace execution acted as
a read-side critical section from the perspective of synchronize_sched().
As commented in kernel v4.10 near synchronize_sched():

  * Note that this guarantee implies further memory-ordering guarantees.
  * On systems with more than one CPU, when synchronize_sched() returns,
  * each CPU is guaranteed to have executed a full memory barrier since the
  * end of its last RCU-sched read-side critical section whose beginning
  * preceded the call to synchronize_sched().  In addition, each CPU having
  * an RCU read-side critical section that extends beyond the return from
  * synchronize_sched() is guaranteed to have executed a full memory barrier
  * after the beginning of synchronize_sched() and before the beginning of
  * that RCU read-side critical section.  Note that these guarantees include
  * CPUs that are offline, idle, or executing in user mode, as well as CPUs
  * that are executing in the kernel.

So even though I see how synchronize_rcu() nowadays is still a good
choice to implement sys_membarrier, it only apply to RCU read side
critical sections, which covers userspace code and the specific
read-side critical sections in the kernel.

But what I don't get is how synchronize_rcu() can help us promote
the barrier() in SRCU-fast to smp_mb when outside of any RCU read-side
critical section tracked by the synchronize_rcu grace period,
mainly because unlike the sys_membarrier scenario, this is *not*
userspace code.

And what we want to order here on the read-side is the lock/unlock
increments vs the memory accesses within the critical section, but
there is no RCU read-side that contain all those memory accesses
that match those synchronize_rcu calls, so the promotion from barrier
to smp_mb don't appear to be valid.

But perhaps there is something more that is specific to the SRCU
algorithm that I missing here ?

Thanks,

Mathieu

> 
> Either way, many thanks for digging into this!!!
> 
> 							Thanx, Paul
> 
>> Thanks,
>>
>> Mathieu
>>
>> -- 
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> https://www.efficios.com


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

