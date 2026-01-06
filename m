Return-Path: <bpf+bounces-78004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00972CFA3FE
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 19:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9090E3042771
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 18:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223D135BDB2;
	Tue,  6 Jan 2026 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="c2KKYaq5"
X-Original-To: bpf@vger.kernel.org
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022109.outbound.protection.outlook.com [40.107.193.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C595F35B15F;
	Tue,  6 Jan 2026 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767725033; cv=fail; b=bdGL9fxZBriUtIc8WdLMiNJX1uTOTyRAZRsCjVtknzA9cz5cf51wQS0m5/aqtjuGwovq51VLuwC/2blyJ6MqVkv+Rg4pwvcW9EZAtDQGsYRyJ0KV7p8RYhLt5dzNL/KeMozkKXVWbxlqpYLadLch86wnB8nUmG1IMqKZrHXlasI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767725033; c=relaxed/simple;
	bh=0vLM8TsmrR+l/edcOQ7IC4CZ7ExeQfAnOvaSAuaElY8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=umTQCp5u/l541pTFIkanpWYznR1An+d4qdfj6OVVoa5NB8PH5UGBQJyXUSumVPAuLI+FWpZP+gHeV/Lh24WLK+2SMPiGcvHDEOJk2SAARyeSUak1B66yKmlwC6tuZuleLtIm3keMq0JCfgcAKo08PzK9wmuePGY3FZmEvnl9VaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=c2KKYaq5; arc=fail smtp.client-ip=40.107.193.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZtXcQgy30exCEMGrBecSibzHZISiAo/km2V3n82XLyVKJ3TalZE2j1eIF4JYejkEPA9OmPjtnUt+mIZ55LrVBUqScltQuEnJIxcXF9m88qQGKJ2mRDwJSZgShEVLSwnbwgjRImeuIG1N4rVxaKJRp11LRTAcn3Pv6MHeQ+0Xqa1cqZB7cQ3tPFR62hspEzNNKYcxR5BYVS0CEB2DtPwe5OgkdMJDbCS5t9iDxxDedsr5x9wkbzDSceCHAaR0RTHaIfkkVzWfIjk2QdsUtgEcG7jW99A4cT3HiyGIjbuVCp8ZgXHZKew7osF35zPAE/+IEKBgNWkB6Ke9/JwIde+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKgefZk61Vz3cK8RvoapvAu5NS7n0X2RLEZgasQIMyk=;
 b=HUHnpwd1xnNsoc/5FE5AT3x5W53aoBcZg1RbyNKt4ujFtazxgpZcTqJ5VZENwb1hgtjfeHvqjpt2SWdnnWp+GuX2UEYh3QG3dwHvGGHBOXm5uKsH6qa30ibPqNtiL36zBmUNMrWT4WGoAdcvDFoA4KzPm3W685PI6/5jgypLal2srSd8Ks1b0PMpXRtAai6DdL7Z64whVgfkNTDFdJn9/1N+fkvyUwM+yP41/2ktSeE8WxV/z5fUnS6Tbpf2SgE3R30i90WyIsVefs4jYZ+2h6aftdlvWTk14pWp7zJGcTiTTUSsf6+AHDmhsdTlVikVIPhBWtIzwHh78gsQFqliEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKgefZk61Vz3cK8RvoapvAu5NS7n0X2RLEZgasQIMyk=;
 b=c2KKYaq5tMJjoYCjm9jb3FoalKqpd0tNaIotoQy6OMfbAakYvBra6ybeyXaa8BNHgv2EXrOiclr4gdDtGqVJgI/m3r40OsED/9pU9zM3niWh2srv0yiijwaMfFI63JSD1ZLDzTih3PayBcrht/fBXt8ntR4L3atlkCzXXhKNBEYpg7OWJc2xKcCQlysAhWhwvh5SOh0ZEoRDEgvlbv75xx64bxAtD7qHROtVQbMlzn/FmVbmP9I33Nx6pRZwsUxu5551YDxHUtstbcyxB0yGvevVRYkxGOoxF/dafdcE2dGwFyTKN1UGCsw261qE7Zc7XnrBQZF9HMOcnL5A6/rDkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YT3PR01MB6551.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:72::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 18:43:49 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5ebf:cd84:eeab:fe31]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5ebf:cd84:eeab:fe31%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 18:43:48 +0000
Message-ID: <bf0ab439-bcf3-4727-b0a3-9f39689bad26@efficios.com>
Date: Tue, 6 Jan 2026 13:43:45 -0500
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
References: <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop>
 <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop>
 <20250716110922.0dadc4ec@batman.local.home>
 <895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop>
 <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
 <e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com>
 <2d9eb910-f880-4966-ba40-9b1e0835279c@efficios.com>
 <2f8bb8bb-320e-480f-9a56-8eb5cbd4438a@paulmck-laptop>
 <42ec09a2-ba39-4277-94ee-faca1540a4c8@efficios.com>
 <24a769a9-274c-452f-904f-fa1cc8271183@paulmck-laptop>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <24a769a9-274c-452f-904f-fa1cc8271183@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::17) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YT3PR01MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: efa33474-ab43-4e4b-5877-08de4d538779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGthWGVjL1JIaWZJN1ZOaDluUHEzSGhBaWtvUlorbkdDTnJBQ2R4ekQ2aHd0?=
 =?utf-8?B?b080V1BnQ3pxd0lMc3EyTjNnOHplR1VLcmxOSmRrcmE3bkIwaEJZdEVNSmEr?=
 =?utf-8?B?ZFN1RUhRTlFJSk9KU2V2anA0dm9LemVnRm9tRGJHbTMwM1JmcXdNbkliUGlU?=
 =?utf-8?B?THV0T290MDRwNE1FRTVoUGViTUJtcVRiQU1IRFlPZGJ4OWxQWTJmMkRES3JU?=
 =?utf-8?B?WHpKRHcyeVU0WkFaL2pnR3FMTWNvQTRHbHpuVWxLc0ZGNXRzTTFNZldnZDdU?=
 =?utf-8?B?T2s1OUdUY09oL2pHODlhckVRNFZQbGU0MExjWFJTN1p2eGhOWVNLU0tyOXFn?=
 =?utf-8?B?OStaN1N2WWZaNHdtaHUxNlliUjZjb1J2YTU3T0Q4SFIyU2xyMmRPOFczZGs1?=
 =?utf-8?B?V3VkVWNZTW9Dejk2TlF0Tm14TFJuMzBVbHZaYWVGUDFXZnZTNXVGYUFIdFpG?=
 =?utf-8?B?TlFJN3RuakIyQWFHUEp3ZDRhQ2VneGJwUjE5MzdERmRyWllIOTQwSk1ZbHJ5?=
 =?utf-8?B?cCtLMkxncE5iVjJjMHlNQ0dtU1l1TSt1amF0WmFtcGdKeDQwRUlvcEdmK0d0?=
 =?utf-8?B?b3hNNDBtMExVZDYwY1NWUTIra09hRHpEa1ROQ1B5OGlxaW5PQTdRQkVzeDN5?=
 =?utf-8?B?YmdZWGJKZ1MxZnVBTVQ1c29UbTJLSkVDSXViNkpBdkVQemRYV0JsVmlDVVRk?=
 =?utf-8?B?NVEzcVk4QzdJWjE2MXpHNjlJZVAwSjNZa2QxcGp2NnNwdEh4K3FDc3I0VEhw?=
 =?utf-8?B?TWRqTWd3ZHRKdzZOczNaNWl2MDh3ZW83MUZ6TzZRMVIvREQ0QU0yL3Vra2R2?=
 =?utf-8?B?VFljNnVMQjVRL2xhQ0V0UURsWG5PamtjVGdpbWpPVzBDbTNWcCtmdnowdUlm?=
 =?utf-8?B?cTBkTGlqWDlBU1ZHQ2NhNllsRnhmK2lUNEZveFRyZkUyb1gxU3Y1SG0vRDlD?=
 =?utf-8?B?YTZjKzNHTlo3VXhWcWVDcFpoby9iTndkTmZ2OEQ0NTFzVFM0emJ6THV0U3NX?=
 =?utf-8?B?eVpLRDJ6ZXI4VDNaaUxPc00vR3NHR3hqL2lUd0FIdEFhNHc3aGZONjJPOWxL?=
 =?utf-8?B?a3BYWDkwV3dsb3dOc0RQVWc1VEJXbS91YTNaL1BEajNiZEwrSVdZL1Qvekhj?=
 =?utf-8?B?RlJiUDhueVJzQXRDWEFKbk1NbE56M1N6QnJCZlFwdmZiVXU4MlI2MWR2U2Fj?=
 =?utf-8?B?S0pxWW9IS2hsdGZ2UFhrajBNYVhxTGZnd0RzMktlTU9ubkh1ZUQxNUNJdEo3?=
 =?utf-8?B?Y1BtakJmalhOQ2FIM1hPYytYajV2WVhSVnlMM3BPVWlYY0RxVnBNSWxNN2FR?=
 =?utf-8?B?RUY0UVI1M1Y2dWVoNEdvdHo0TDNrejF1WmdrYUtITHowWVVqVmZEb1hvS0VD?=
 =?utf-8?B?WjQyQTc3N3Z0a2pBZW1rQjY2ZTA4dFJoRXRuTmQxbVlZRnhUUitsclRoeXBJ?=
 =?utf-8?B?NERxSXNoL3RYWlRoZm9HSnpoUFF4bjVtME9uNERJM05CVXZUbWk0NmdoTWp5?=
 =?utf-8?B?a3kzUlVMYVNYT1l6a29FK2hERFNQd3lPVEh0bGVXTjZJa3B1TW1PYmdWeTRy?=
 =?utf-8?B?ckxxNnZIcEY1Z1VvdFl5RDhyckxHbWdiYnJFUXllMitrTlJ3Wi9jREJhU2U5?=
 =?utf-8?B?NllJVGcvdHkzSEFVSll2eTRVK0VGSjJTQ0ZJTm8vWUY3SVpEdVJHLzBFN3lQ?=
 =?utf-8?B?QzdZOVVJbWhva1ZJSmhRZDZpK3pQcFBpd3VTVWRqT3hQMkdaUGFmdHd0enp1?=
 =?utf-8?B?ZGFhT1VGZEw0dzhUbUlyK1Q1eXdRNTNMZWVXYklVUU92TDFmYnFQcXVFOVVL?=
 =?utf-8?B?MTQ0UThoTjk5cWU2c20vRU8xSVNqRUtjSmx5QlVneUszVFZYMWV5cGtMTG5E?=
 =?utf-8?B?L3c2ZXh1OGxYcDFTVy9BSXl5dm9qeHZSR24zYVF1N0ppbFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkNTUFhZSVBRV1prWG1aSFU4WVV3OEtEZmlkbmhSdkFFOGRBREdvc1A0MWhJ?=
 =?utf-8?B?M0tUNXNkQ1I3NkVlc1lqK2NrVzcydzhMd2oyd1A5dS9MWXgzNngyQmpzZnlQ?=
 =?utf-8?B?T2lRR01CZnR2eWx4bHkvT21WWnF2TkJ0NXpGNkU3U1ZwMzQwc3pwbXdNQmdx?=
 =?utf-8?B?UkJSNnZFUFpGRHBGTWx3WUVBa1J6ZkhKRHl1NDlVRVo5UFFNM1A0VllEK016?=
 =?utf-8?B?V2NiWUFEUUc4bTdDTnRFTmdEUmxoYjRnaFBTYVR4UWlwYW83cFRmT3kwWmt1?=
 =?utf-8?B?dEQ0UnUyaWFzajVKZzU3eFdqenVETVpvRmpRZkZvcXZiai8xTWJaUGdKdkQ4?=
 =?utf-8?B?bTZrWVVYdEdxaU1ZcnltK2sxY0VMNHdyVjNCN0ExRTFnZFBDNjhJUWpyTVdT?=
 =?utf-8?B?eDAzVy9VUmRpTkJjanFHZkZCTzJYb3lPSzhCNDJOSGw0cHlCUnJsREcvNmhK?=
 =?utf-8?B?QzcvdXd2R09NdEczTW5OU0hMZ1pZdFEwRW9KUWpkSkRPYkVYeEJ1ZXdML001?=
 =?utf-8?B?clcyUEc2NENBbGtDbytYTk1zSEk3RzNiUkxlWnpucVUzR0JFTVE4TFh4UWZx?=
 =?utf-8?B?UG14MHNhUVY5TDRvWWwvQm5OVXhEeU5KSUZSVFV3MVkrU3dEaE05L3YrMlRZ?=
 =?utf-8?B?dy9hOG5RRFhycjh1Vk5Hd0dYZVp0RldRU084OWNkMUVBVkxUUDVZQjVpUlA3?=
 =?utf-8?B?ZjB3TllIK0ZYaFpqSUgwYzh5V01tRDQ2LzBia1ZxMHpuamIzcDcrQW5JYlRm?=
 =?utf-8?B?L2lqdW9RczR4bU9NMnBvOEdBaGh4bVh5cVpXK25iRGVOL0pWQTE1U1ZtSWhi?=
 =?utf-8?B?ekFLeFJIUFovUjVTNkwwVld3dzhGeTBJckxLeDB4b2hxZ3RzYzd1dkNId2py?=
 =?utf-8?B?bzlJNEZNTzVnM0FFYThWM2taM2N3KzJHUzU2dy9YWDB5RGEyZVRKSU45V2pF?=
 =?utf-8?B?ZkNROG9NcHR4T1VBRnhBaTl5eTlvd3MxbnJmYjZDMVRqUmtGcXp6dVNiWEQx?=
 =?utf-8?B?L2lrVEJTNFkxMy9CTnQwNFZvMmZ3OEdmN29ITFFtRm5weE8xdURJWjhwWXU4?=
 =?utf-8?B?dUQrYk5DamxKV1pYOWJWQWhaZDhHWmVrck5Hb1pFbWhmckk0Uk5ha3BHYVV4?=
 =?utf-8?B?S3hLNkpvaU1SOHVjQnZPRU9uK3pBYjljUXRsMjF1ajF0TjQxbmVraUxiemJw?=
 =?utf-8?B?RllHSWx3R2pTNzBxdU9VMHo0UlRpdzNnckI0ODQvRk5RWmVhY0dKS2kvMXVz?=
 =?utf-8?B?UkE0VjBxNTIxeW1qUmliMHdBK1prK0NXMDdiZTBlRnVhYmdUSWYxbVduaFpx?=
 =?utf-8?B?U1c4ckh3S0RHWEFJY2xtWXd5UlpjMXArVlVtM3FZQnc2Q3QvQVhUMTc2bTdn?=
 =?utf-8?B?YjBDaE50d0RTb040VXBkcEYxbDRqd3BUSElaUFJ5cFNrQ3pORS9TSUZRZFN4?=
 =?utf-8?B?L2QzR1BCUlNIYml2a3gxRDd2L0RjdXpjM1d5eDhRTzR1OTJ0T1dNRGUveDA1?=
 =?utf-8?B?bFdBL21GbmtiOEs5UUtGT2dHQjc2ejVyRlJkdXZtUjBDUkFidkpjRGkrejhi?=
 =?utf-8?B?RnBwSWxvSGlEbm5BRXFWTUZqeUhZMTF6M255QkhMaDQ0N2YwZ3QyMU5sVGl4?=
 =?utf-8?B?M21WeTNBa1RxMmNEUFcrdk9hUTFpYU5iZkk1R2FGYzQ1VnpRakdoRFBFOVd3?=
 =?utf-8?B?YSs0UmM0eTdqSnMxYmpsakM3TnQrVVlDT2h0WjcvNDRIdXBVUi9FTDR0Qno2?=
 =?utf-8?B?Q1ltVURKcFh1VzZnWklQV0lNYlYzZzYvM1doSTAwMno0ekdzdUc4L0MydUtp?=
 =?utf-8?B?ZUljY0NxQjlLK3ZaMWMveFhERWx1bHdVRFVPME5WVm5MOWNERlJJRzNtVkht?=
 =?utf-8?B?a1NXUURTVEN5QnhSem1FSDdEODdaMy96RDA2Smd6K1dDTWRHYTNQcUJEVHdr?=
 =?utf-8?B?Vk5WOXl3TWdOU3VkakRSUVNQQ2ZTa3NnV1BTUU53TW9DalREdTFrSFVYZHFM?=
 =?utf-8?B?OUQ2aDFDUTZCS0IvWDB5MzNwOEhWTVpYdFEyaGJGamhFSVBsSEhYMXN0K24r?=
 =?utf-8?B?c3JaTUs2ZWRHb3pIR3BndWsrUVFoL3BKN0k5ZXFVd2ZCRk93bWNGaGhVb3pP?=
 =?utf-8?B?YU1ROVRscG9TWXVQTDloNzd2Z0lrdW44cXV0WTNRL256azVFQjh6RHRHbVVC?=
 =?utf-8?B?anRKb3AzVGRiSG8wUzlkOEFTTXA5cW5sdWJRR29JZ2k3MmxJdTFDek9vYXZx?=
 =?utf-8?B?d3hzMGNVVVkrRnVwQ2FtVXhYMk1iWHZ1RFRRVWV4Y0IzalNMb2JTRUlpSjQ1?=
 =?utf-8?B?T1NwTWxjRzJEZ0YzZlZFOExiSGxuNXZtRy9RN0pzck51V2xvbHRNY0RDY3B1?=
 =?utf-8?Q?zD7QhfQXm9YjBdi4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa33474-ab43-4e4b-5877-08de4d538779
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 18:43:48.6063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyH1VXjuoqy608ZDtPgq1zyW7VKyxrKLfuniNh7weFlB+q9HDBDRMkl014J48mR/ZeJ7iuS7a5/j5k53AThqkpv8D+nQqC7KgY1+/bP3Wxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6551

On 2026-01-06 13:30, Paul E. McKenney wrote:
> On Tue, Jan 06, 2026 at 10:08:44AM -0500, Mathieu Desnoyers wrote:
[...]
>> Re-reading the comment and your explanation, I think the comments are
>> clear enough. One nit I found while reading though:
>>
>> include/linux/srcutree.h:
>>
>>   * Note that both this_cpu_inc() and atomic_long_inc() are RCU read-side
>>   * critical sections either because they disables interrupts, because
>>
>> disables -> disable
> 
> Like this?

Looks good !

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit b3fc7ac622a19fcf921871be097e3536847406cd
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Jan 6 10:28:10 2026 -0800
> 
>      srcu: Fix s/they disables/they disable/ typo in srcu_read_unlock_fast()
>      
>      Typo fix in srcu_read_unlock_fast() header comment.
>      
>      Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> index d6f978b50472d..727719a3cbeb9 100644
> --- a/include/linux/srcutree.h
> +++ b/include/linux/srcutree.h
> @@ -259,7 +259,7 @@ static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ss
>    * srcu_read_unlock_fast().
>    *
>    * Note that both this_cpu_inc() and atomic_long_inc() are RCU read-side
> - * critical sections either because they disables interrupts, because
> + * critical sections either because they disable interrupts, because
>    * they are a single instruction, or because they are read-modify-write
>    * atomic operations, depending on the whims of the architecture.
>    * This matters because the SRCU-fast grace-period mechanism uses either


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

