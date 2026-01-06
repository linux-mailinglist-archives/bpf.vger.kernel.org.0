Return-Path: <bpf+bounces-77965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1109CF9024
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 16:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD06030D5371
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 15:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1847433D6CC;
	Tue,  6 Jan 2026 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="CXV85LkI"
X-Original-To: bpf@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020140.outbound.protection.outlook.com [52.101.191.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860CF340A70;
	Tue,  6 Jan 2026 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712134; cv=fail; b=B8ThgYmg23z3i+5DpMGtzsqBx0APKrt+71GYIB78l5YrNxa0Cn6mlyOYC07iVkBbulU+SRjID1UbGklBBPqE/g2OvCTVttmpoo14VhvDOwAROWzIuun77YETAY+xuSpR8XYWOMZZLOk1CrWceM3ksYNJEGUhdB52PQN6obBnj+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712134; c=relaxed/simple;
	bh=cTum3uAU0S+3Gg8uw1Oe/ADqnZiJRDHGS+bHVtAStQs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YVc7albvSlfI+n8gL/NKib35HfLYkJ4zVsVowdJ+8YYDTH/H5IJ5GH6+ar1ZsG87kkm0rN7lxGbH+gpIO9fpPxCfhgN5A7kAVj7ivStRXR0syN7mvBowDt33v1ybGc4ZDxsnd8a6m0/KxWfdfKwShXD+wiI5j5J8j+9OmMNoKS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=CXV85LkI; arc=fail smtp.client-ip=52.101.191.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3HFN8Gf89rQyR3gV6nz1uvv1no/pM6CnkuoMUnKOhvgENvAQ/jABZdAghgrk4mzOsXapL+voTGQiWWD3EYxaqIXe1rJ0p2/o8dl3LhDyvUqncQZVG6HiIzrYNq53tYsJkw58Q/XabczZ9+NSz4lWGq8PYWO/ULSzyCuuL1i+XrQ+YPk6H6neYL14ARlAEhvMzNOH8zNbjH7SpaZ8LL1ARUeCXBYyZSECMMWXxZ528A0t0Az1pdAM6TURJgY5R4Be3iCxzK3ZS8rqohlq0mT6/FeMDfkXWZvG6KVNjOWI8K2p2YFJUQOzFK5nVQi2uzM7M7cA0lKH1h13PH0LYCxRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIxfHiMnFQCZie/AD3H+a97g0TLDPQMkRaBGGT5TzfI=;
 b=yv/KcvDjpMgAWAkgysORzgn20JYjBzcPiPEyvm1TruZEsiHIh7Rou1F59Q7Ythgci5jBUHFWDWzdbJi33+j2o0JNTCdUuGtlMZuaz11K2bt3y73UvWT26YKss0XmiPHWvxOrbp82En9vdxcemYuMPSK2uEgb5l3YipfC3tr5gOaQTzyIr7dBwfoBxsyO0qU1xDhLb9ZYM9xgSyc70Pc0NHREWfn+FB9AMfABe0RDgnsOKScyZu2K3D3VklR1fZnTJMm4rNZfPf7E3xliRp9a+5E9QHzjogkYSgudGnkIlqO8ZJX9o+DiKHJi3+PAcGPg5EcuSB3HcnWfZp49rbYZpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIxfHiMnFQCZie/AD3H+a97g0TLDPQMkRaBGGT5TzfI=;
 b=CXV85LkIRZWu+kLGeD+45H6VFeMHVE0fmPTUfX1iEt7EBCjRcqOVw3NOfpOh7D5KaSgARm4SEmA2Wdr3cXnXKJV/zJ2tBVMtZ4DXiP2zLaDLAQ1BqlSkZk5/ZQ/JtQFDPbf3I4c1SDAVi2ILSdbVlXJcZjRe6kRr5vMKRI3YBIVxyR5yVr15Ne97qFfeURJ1Z0d8U7I1bUPTIhSvLA1ozXjdAtTdQ8V4UdkpPrgcSNJgg7cNiORlRhyacb3RhDlJBe6eAhA64qoBl0XMoAnM7yckYE7URtL5g+BDeQ+RPXQFQjTCqTqGUQ+iO1J4cO5HJL9pTcrqPu/gK+zlTn+Kfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YQBPR0101MB5383.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:46::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 15:08:47 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5ebf:cd84:eeab:fe31]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5ebf:cd84:eeab:fe31%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 15:08:47 +0000
Message-ID: <42ec09a2-ba39-4277-94ee-faca1540a4c8@efficios.com>
Date: Tue, 6 Jan 2026 10:08:44 -0500
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
X-ClientProxiedBy: YT4PR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::11) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YQBPR0101MB5383:EE_
X-MS-Office365-Filtering-Correlation-Id: 98735019-ff8f-43eb-f8e5-08de4d357dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGRheE00RE9kR2Z2QkxTZ095Z3VMejJNMlNHV0Y0dWwyRzlOTnZMSTRsQUNo?=
 =?utf-8?B?TVRLUzg5clRoUFFiSDFJK3J6ZmxPZ3NNWEk0eGd2RlB4RzEzTEF4MEtUWjR2?=
 =?utf-8?B?ZndyZXBxakx2SzdjNVpkVjBIa01wbmJGVk1lR3I2WlA1Mk9OVVhQTld1cFNY?=
 =?utf-8?B?a1JvMlAvditDZTZVNGtWY2RsMDNFVUNuR2owalNDbWN4blhTN0IwM2h6MWFJ?=
 =?utf-8?B?akVVNmQxenZudHUzcElFVWl5YXJnbVNjY1ViRVJ2cVEzWFpkM25RTXZuYkVt?=
 =?utf-8?B?Zk8yVlhweFE0TnBubk5LdUR6SGh5MkFUdUlwUEswYVlQVzBrYlhnQTBGY01z?=
 =?utf-8?B?Tk01NXI4Q1c4MlY1Y3g1NngxMFJNZXNyQ0JRUkNYN2Mxb1VVQzNUZlV2ZzJ3?=
 =?utf-8?B?T0lvUFlVWER3MXdxYU1vT0txRUg5RTN4M0p3cXB3dSt3cnJ4UW16THBTYVpy?=
 =?utf-8?B?UlVwK0luK29TUkFOQ29mbis2NGlOMVdVaE85NCtpMG81TjgxdXRJN0g0NThx?=
 =?utf-8?B?bStVTjh3enlsaDZ5aUc4ZlJrU3d0dnhIUVVkV1pJQktIVUtaMjFONWpMRGdw?=
 =?utf-8?B?MVNwdVAzRkM0RTlUYUZzR3FCM2VrWnVCT1FoRDBGMjBiMkttQXJmUmRBa3ly?=
 =?utf-8?B?ZEladWFBOHVFVHg1Q00rU05NZExQUURJaTJJTFhZTVMwVThaT0pGbmgyZVVG?=
 =?utf-8?B?T1FNczJ5UGpXWUdBYWJSdEFFOS8wbkNwWTNGVjV2MmI2L2hVWHIzVmtvYmxP?=
 =?utf-8?B?dHFUUVZ6MFh5OGNXT2pHalMrSjNrWVU4b0JKcGZUa2FqeGl0cG9rT1MvaEJz?=
 =?utf-8?B?ZnhFVDNYVXNTTmt4VDFCZ0VncGx0cTNrR3dSWEduR3lKdU16ZncrdTFyOWpT?=
 =?utf-8?B?OEFkeVNicDJSMWhJSmFTRHdnaTdKNm1qVVlER2FZZ3llVmp4amdLNkFCbGl0?=
 =?utf-8?B?ZmZLeUJzVWJRU0FVRjJ0YS9scUdPMzdjZWZpV3JVZVE1YVZzWFRZN1lSM0NN?=
 =?utf-8?B?UWNJYmxSOE9RbXJYdkdzbDJ0NytCRUJPL2NKS0wySmlMT1lJTFh1TlFDLyty?=
 =?utf-8?B?aEhNb1ZRQXNuREpDVEJXcyt1ZDJKVzNNR0RpNHFSWkovTkNvWnBmMWFJdUIx?=
 =?utf-8?B?TW9TdDVHMGhOLzIvdGVVUWp3Z2hvMmU5V2p6YWl3TDVIVlovWXlSOE55elcr?=
 =?utf-8?B?V0lWR2VibllCN3BRN0ZrV3VRN3hNYVZVZVQ0WUhqL2Z1RDVnRFdGcEduaUJz?=
 =?utf-8?B?WGlVNDJhb3pHMlVmTnV5UElqL2luWkFXMzRIeEVmN0IyK2hhWVE0RFRRT0o5?=
 =?utf-8?B?TjJiUUhEYkdCWkI5eWJFYUptNXZjaEROVjk4aElzYytSS0puQUhvM1VkM3NL?=
 =?utf-8?B?YXVNZTVCTTZPNU1IOXRzSDR3Z0R5Tm1nV2hyUWZmSGdHQk5VY1ZmZmVLY2kx?=
 =?utf-8?B?ZnNuS295SnpKTmxZM2hWODMzSVo3TmE1OUhzbU1PYUlweUp1b2FZS2xKMzJi?=
 =?utf-8?B?UnN0Wnh5WC9ObmxKc0RVTW41UklNOWxKMzl6ZU02TnpwYWtocGpZWElVT2ZB?=
 =?utf-8?B?UHZDQjBRWXZCamlvL2FwaW5ITFZHbU9QQnRLeXRkWDdNU0tDM2ZvSkF2Vmgy?=
 =?utf-8?B?RnJkc0ZoeTVkdVZTcFU3V3JSNXRPZktEbWJXQW01Nmp3UThReEtJY0ZPRFBo?=
 =?utf-8?B?aG51SGZLQ2xMQy9UVk1vbEVNZlgvSnNGVjY4SnZHYW9FQnU0TjNnM1ppbnZi?=
 =?utf-8?B?djdZY2xsSGtRME1yQWI2N2ZlZGFidkl1N0FJRzlsWXdrR29OakF2bVZSQzMw?=
 =?utf-8?B?RHc1Z0VuSllibVd3eSszNzNkRy9OU25penFqYUNoNldYcVZDWWJiQ2tCcVJx?=
 =?utf-8?B?djRlTG5IditLcjRZcTJ3dTVmU1BTYzRlbTFvVGhZK0x0N1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tndnd2d6YXZZVFRJSEZsdFJBU3E0VWJid2J3RVFER0FrV0hxM3JoMDU1aU90?=
 =?utf-8?B?YWFtTEZHdVYxSFVmdmFSRDRiSy9LdU1taW1pZjFHTVhWdkNSQitTVHJzcU9x?=
 =?utf-8?B?dFZwbjMrTG4wNTRJcmNOTC8zMHdRa25tVlRJbi9SM0Z6YXhmUnBBTkRnSEdM?=
 =?utf-8?B?cnEzbHcrcmhkNkhGVnBUZVZuZExWRzRXNU5UYU9lZHRod2gzbTJ6NElMWW9O?=
 =?utf-8?B?ZCs0SFFoK25QY0o1bFZZU0piUlAvQzF4STFETWZvSG1Gbm9uYWwzekl5WEV5?=
 =?utf-8?B?bEY0UWVpT1pNY2RUZ1BwNjliVC9YZm4yc0I3bE5XQXFBZUd6dUowaksrVWd1?=
 =?utf-8?B?bFZtZGp5YTZVQ0hZcVZLd0dEQTNmV3FkV043SXBmM3RtbGtDZ1pZMDl4YWlC?=
 =?utf-8?B?R1g0c0RmdUY5cmVVQUF5NjZVOGpYQ2tweVFpSHdrbWI2OElaTUYvOVNnNm5m?=
 =?utf-8?B?ZHVvR1J6QWpnY20veHdMV3VzTnQwQ1ltY2s2ejh6Y1VHbmw0TW9aZERza0xB?=
 =?utf-8?B?ODZLWjJGRmlGcDRuUVVhMWhJNDJNSTBrb2wxcnZ2dGthbDZ4RjVqY2xiZGZr?=
 =?utf-8?B?YlhGZkJ3dG1lQ29KQ2dTMUJ3THoxZ2crTmFIZGxZY2tLSHI4Q0tIVHBVbUZ1?=
 =?utf-8?B?Z095b3RnSTBxakRPb1l2Y2piUU9CSCtZb0dmcm5rUVYzd2NmMDRhMys4YlRK?=
 =?utf-8?B?ck1ja3gxR2dJNVFKYklUVWo0SnJqSktJbHhyOHNYWlUybUtqb1E5T0NLU1R0?=
 =?utf-8?B?YUluaU5ybEZNRVZseEdoeG5MVFZlR0VwV0pLbU1UUWMvU2tPYXZ1QTIrS0Ju?=
 =?utf-8?B?S1VYQmd3STJNOE1VSXVCWHd3dVQ1S2ljNmk1K29iZEZDMFNxMVlBSXBlSkE2?=
 =?utf-8?B?dWl4RitjQkFONGc3RGtLQ2s3dnZTcEVMNXBBeHFPanRxdWNzdVFnbXB5NXpU?=
 =?utf-8?B?emwreVJLQmtkSmw2WFhKdmwzWGNsZTRDcTlCdGhSR0lkenNtMmVlMy9KZWND?=
 =?utf-8?B?dlNUQ1ZEemZXVnVESDV2S1Fqb0RQbUFtcDBUY2dBMEpOcDBvM1dmYmpqV0xL?=
 =?utf-8?B?TXEvUk8vTTZsWjhHQlhpWlJzOU01MUc1bGdyODA0cmg5MTQ5TUtIS2xsYU9o?=
 =?utf-8?B?SFRTWHRCTllFQ1BNcGR6TTQ4UFpORzNYZWd2NnVDeWo5YTliSW1LZDRWOWox?=
 =?utf-8?B?NURGOUZ2Z1B1SS8vTHZtV1pRQzdSb1FYOWttdmtBYWRBZnJiZGl4c2NyckpH?=
 =?utf-8?B?U1Q0aGRuaGE5T1d2Nmw2b3ZNRzlZUnJOWVh4STNpWUJiQ0VIVUhlUjhtYS9W?=
 =?utf-8?B?U2NGOSt6MkF3aVVUUHVRbS9rNTc5RTFCSThIem1LMndab3pSRXBtdHg4ejR6?=
 =?utf-8?B?ZUR4T1pjZ2xsbDNWaDdISW9uMnNGUk9wbklYWlIrSTJjY0MvdmVRRXFxUi9S?=
 =?utf-8?B?ZldPMnlrWTdsTUlVaXZhZzFFUHJiL21kOUxJZDVQbSs4VlJnNVRRekhPa3ky?=
 =?utf-8?B?My8xU0g4MDd0clJza2FNeFJtNEtuTEVubFJaakVFVk5yNVEzMzBuTWFoQmNG?=
 =?utf-8?B?WU9nS3ZUTnhHb3IwOFRPQXJGOFlXd3k0dGlhT2FNbm9ybW1Ddm9jMUI3NDkr?=
 =?utf-8?B?dFJ1MWZnUjMvRE5TTnN5M2VQVHk3TWxteWRzK3pCYituc3ByU1Y5L0duYXl4?=
 =?utf-8?B?bXI4djFEbDRxYWpkdmtYYjFibWtpdkRsazZYell5WVNDTUkzbit1dDVKNUho?=
 =?utf-8?B?bnV0Y25kT0VJeHcyRWRiVHhrRnJ5V3FVSlBzUVRSeHpUdWpYMHVid3NrL0tq?=
 =?utf-8?B?OFYrSXdTLy8zT2dpNEVLZjZ0KzMvWnhoQlFIY3RDNEZieWdNTVlZb1pvQXJJ?=
 =?utf-8?B?WmVSbVlOVEJxRXBKRWxBV0p6REpuQmpzeHRodmdUeUx6ajZTaTNvMENLMy9I?=
 =?utf-8?B?V2dIVHgwZEJ3bU1XVkNKOW9hQTB6MjBpbjMydkVJUStPdDNVWXJjRnZWVjVz?=
 =?utf-8?B?Ym5JVFRoeDZvbUpybzFmci9FUXNBQmEvTEtsUnA5MDVZUklialg2V1lTbXk0?=
 =?utf-8?B?NmtzNHN4NThkNnJVVElYLzc2bWVWTVV3Q01DM1FScHBIVmpJT2gvYXBhUmx3?=
 =?utf-8?B?UG83VlFNUWNKSE5JOWpuV04rRzNKWm5UYnNBcXR2cnF5dlk5dUhCbnhmZ05q?=
 =?utf-8?B?TVpHKzlqSkZDNG9pdDFGcUZ0SHQwRUFRR2hvb2ZLcStuU1dzUmdlR1NWeFNq?=
 =?utf-8?B?bzM5QVpJbUp2TXg4UzVEajJ2d0dWMjUrYldLbG5iUDBGNWdidEdRbFoxZ2Nz?=
 =?utf-8?B?amtFUThPcGh2cFNZWm9GUldrTXRqcHUwU2duS0NsZTdKNGppdVV6enNjWnh3?=
 =?utf-8?Q?+rmGIMG+HKpOQaGv1KfOsm/F1pzCpsbF1eIVk?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98735019-ff8f-43eb-f8e5-08de4d357dce
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 15:08:47.4747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0X0G2F4okQmxtY2O4KOmHR+XGCHylebQ6vIFkRVJyONSl9laryefvltga/gSswNoNF8wWv+aGXPkGmX1epkpJEXZzEy7p0krxyvKYa4jGAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5383

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
> 
> Either way, many thanks for digging into this!!!
Re-reading the comment and your explanation, I think the comments are
clear enough. One nit I found while reading though:

include/linux/srcutree.h:

  * Note that both this_cpu_inc() and atomic_long_inc() are RCU read-side
  * critical sections either because they disables interrupts, because

disables -> disable

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

