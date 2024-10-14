Return-Path: <bpf+bounces-41843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD8699C43B
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 10:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F986283845
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 08:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E07B155300;
	Mon, 14 Oct 2024 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tqyPpo8B"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28C61514F8;
	Mon, 14 Oct 2024 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896190; cv=fail; b=jr7vu9vEpJz6uPjZOy1IcavNSgAxOMh9i7e2P56D0Oh3mfd+/9WiaEjZCYzdqEfsM1V99KcW8Z/AL/OnxJIvidWySbkTuKkjKw2oDSbsjJbWeDrw0GjLL3J9kGssf4Kkr/W+Bq6Qmlss3jsp7vxRymFGmr0RlfjTQYE3gGOxG2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896190; c=relaxed/simple;
	bh=hxiDk6FIKIgL4nAxYTyUSZo8f+JBGLUPdznZZLxh61s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NXfvXa9COiLX9IO3CxHvwbMnltLh41mmShH027/DwOWpA4DFUp5taCLNovohmeFkWFtQ4eLCalGcLIg2vi7rcnIquBDbCVf3KsSejXjGguINdNqPBidvhpiYawMfWxTJGqAi58DqOZGkcC0Z4Q9ZxJ9YzNxu3a8I3yhRT9pejhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tqyPpo8B; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aiLxST7wiEffJqvwbXyyqEJQpWV2JXy1YnkGHxxWrYZODGCod/Nhn2HeBBbGF1I04kRCAHjYQfnhngvMSe++5e/ODrBf04I21MNnRRROYvR1ej8BPIKSzn2nJmTqM/47B5NvpdfMCX7HXMFCL2ZAAgmI1hEOM8TBLpk1Fx0v+bgPxol8drWYpM/z/9ChwIWRuDi31FHczhepGMPqCU7YyvH/gDv7l5zG59wd52Z2mvdwONgIPCvVRXYv35Ehw0Ct3FspbbXhZ2NWXp5wHwn9ubi2NTPOSKgMtFXwuXlBv8auD4JYZaiVHcLFsyQ+lIl8lqMPJWj0a+AuGr115k5o6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9j/wBzpvx8TX1ZuIoFZPti1px5+88IIK4cj+8suKRpU=;
 b=dI7nngYv3Geo2kYqCpkzojlo44spZoVLmacGorbF2lOuIVNSSxo44a5B9lV6do4mwLxDIcL+Z+ojwslo+9CZjJtWbJ7nCgxB7E+si7JfSPimpllQbJOJo0Bi/iuy5sojYfunHOiqHW4llp4VpDl3sRTfAnPmMM6+S6D99jU/lfSZyUzFayoYiY9x0Y2j2yvge9dElMCPNvVHwi1z+P4QP0OrAkwtmhPq/TKrhJGnVmr96rwTRbX9+9DuGmKQWTpFM/KV1kXaJtvEsUufpmvd5II2idJRdPzh7aOQ2sH9XPsCO1x4JZzi4V9CnXAnGnu6uhzOewilqEsSRpZNpjoGFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9j/wBzpvx8TX1ZuIoFZPti1px5+88IIK4cj+8suKRpU=;
 b=tqyPpo8BBNPucdYxLvgEf5hEqf5gttYVeU8itrRm7M7qZUI88XQKZpTDGYY2tfXFTDTbWCezuY6TBXSfXKscVRIZ2AMGxzn1tFUi9l4S+mYfGTapKFtDrBDKeJmZKHJAdTtJZ6E150X1PCXTgy8Oj3xkeKe41zXeRHouOVELMTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 PH7PR12MB7985.namprd12.prod.outlook.com (2603:10b6:510:27b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.26; Mon, 14 Oct 2024 08:56:25 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 08:56:20 +0000
Message-ID: <b9eb4931-ace9-4a34-bc8d-bb839d14efb9@amd.com>
Date: Mon, 14 Oct 2024 14:26:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rcu 01/12] srcu: Rename srcu_might_be_idle() to
 srcu_should_expedite()
Content-Language: en-US
To: "Paul E. McKenney" <paulmck@kernel.org>, frederic@kernel.org,
 rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
 <20241009180719.778285-1-paulmck@kernel.org>
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20241009180719.778285-1-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::18) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|PH7PR12MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: b9118112-c9ef-42da-bea5-08dcec2e1215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEl2NVVrczZBL3pGQmhFK1hFNHhIeVdZcVQyWXRVNEo0UXVNaEQ5SEVSb1lQ?=
 =?utf-8?B?WG12dDJvcExlRnk0aEdRcVBXVkw0RVQrTU92S0szOWhmNWNyM1R6aFl4Q3ZR?=
 =?utf-8?B?YVZzM1RrT0NrdUIwa1h4ZlhyZFR4WHpDSk56MmhySTZtRVdLNmNRbHMxTUI2?=
 =?utf-8?B?UmNIUnNXMnlseHZhVW1NRlZzWThhMkpBbkRtUU8rUndhbGtFQ25iOWlxV2NT?=
 =?utf-8?B?aE40WDdmM1BpWlFiaVZEeGpiTkNncXRsZ1JRVzRpcVJ1M3pITzV0eWJPMmpM?=
 =?utf-8?B?aHo0MUVhUHJtTE1YVkNxbXR1UTBRUW12V0FPcThKMkNZbVpUbmhveXU0Y1lH?=
 =?utf-8?B?UHc1RUlyeW1rb0c3MXRUeWplMlJqTkdUQXlndWdMWEsxelRIOHdrcWdOMHIy?=
 =?utf-8?B?V0w3VkNNck9LdFJxdE9QS3N5Qk8xc1I2S0IxeE1LVThHb1g2ZUZvU0RLaUNB?=
 =?utf-8?B?Um5VNmo5dGMwZkxuaUNadzkrTHRlbnl5T2hYV3hSZGtHaVA2Z1hhcm9lR0p0?=
 =?utf-8?B?NWFEN2lja1J3SGxGQzdEZjYwREVEZWJVaHUxblZKblhybWZ2MldJQkFiYjc5?=
 =?utf-8?B?aFkvMWgzTmlZbSs0ZWhJTkRqLzN0WkR3VkhMRndEMmdLeXVHVnFWUVRCcHFJ?=
 =?utf-8?B?QStjbGU4TUE2VHdKeWd4Tmo5UWlKMUNxdnhyRldQbXoyLzJUL2RVSU5JdGQv?=
 =?utf-8?B?eCt4a2NtWk1tdU9WT2F5RjJ2bkQ0VEsxSkx5c0VYME9VVFBpdkxWQlUyUnBV?=
 =?utf-8?B?eTAxWGY5WVhMcS9QSWVqY1hSSko4YlczY2dSckpmRlFVUVhtQ05jWnkxS2wy?=
 =?utf-8?B?RjN1bXc3cFV5dGk0RlJrZ2dBdjlIRXlmcm4xQ0lkWXRlU004bnNyNHk0dHlT?=
 =?utf-8?B?OFVKSndLeDgwNzdWbEt5SEx3Q0tNRWkzQnk4V1VBNkg4bVVHOWJ0WURoM0E1?=
 =?utf-8?B?YURaZmJ1dXVNOUxwVWQ3Qmt4TFVLTk1KaTFmelU3V1lrUWMyQWptL1RwbUVC?=
 =?utf-8?B?VVUvMW5YbWV4bHVoMldzcFNQc0M2QWZlSHNJRTFyUTJSektCOUxadS81VWdo?=
 =?utf-8?B?VnYyUjdvSzdHZFdOa1VlRFcrNy8yMUlEdjB0aEdhSHoyT1A1ekJuUmxhTzZK?=
 =?utf-8?B?UERhR3FRTE5CUGRxd2R4R2xqbG9FS2pBaVhOTG9xQnJoRFU2MEh3UXRVTmtW?=
 =?utf-8?B?dUpVbjZHNnJ3K0p3K3k3RGtvZmJIczV4MGY4RlVQZTFBdWRwK2UvUkJUamlG?=
 =?utf-8?B?Q0ZnWDlUTC91bHp5MGlPd1EvS2NZRVV2RWZEU3FIK21JVEZySUcvUm4zRmp1?=
 =?utf-8?B?dTY5Y2NzY1JzNzBUVndVc2dhREY2clJma1I0clBBazBvVzdjK0YxVUlwOTly?=
 =?utf-8?B?OFZMQmdjNElpRU94VWNGL2NaS3dzSkk4Z0hLKzlibTJDa0FaMzhvS1liL1g3?=
 =?utf-8?B?S2FHQjZxU3hHckVLdFdQVllUaEpWeXZVMVNETHd1RHZ2aDRaRkhNdTZ2dWt1?=
 =?utf-8?B?UUNLRll1UGV6bEErWUpybEZvMmR6dS9QM1BTN2o4NGdXNHBJeHFjU08zZ2tt?=
 =?utf-8?B?TU0vcGtQM3JkZktIWXgxb0wxSGV3b1MvM0tEaU1TWHVTSVo2TEEwTXpYR1VI?=
 =?utf-8?B?aXZLWlozYlZldVJpanhCbTkxS2gxbmM2ck1ZSENnaTYwak9kK0J2WVlER0lu?=
 =?utf-8?B?S1lvQVJic1FQM0hDMUhhREFIaDZZcHJjTWNiUlV4RVJpVXJiYTArOGpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0kvOFRpVi8wMWNRZ1dtbGRWczlmTnlPNktjb1VXTGRyQmY1ZWVTc2VOcXI4?=
 =?utf-8?B?ZlBzYVBSVEwyOWZMRGFzMHNZMitKR1ExcUxBSC8xT3ozSVF3TUk4WGE1Qi90?=
 =?utf-8?B?UnpjaXJndElGczFRWHoyNnEyR1JzbWU0N24rUzM5b01tT3BmWVl0NTZ1N2ZN?=
 =?utf-8?B?QTJnUXoxT0thOHdZUjdRQzFsaGp4T2p1QS8rV0djdEQ1MGNtWmNKUzNOOUxB?=
 =?utf-8?B?Tk1jc3AwWFlQU2UvUjVrT0ZKUzRzZy9zanRNc1VQeitmQW5OeHYrdWFMaWs5?=
 =?utf-8?B?ZEtScDFZdU4xZk9SNjZFRHpmUUNTLzRWUWpZczVjN0FtelRJV0h3b3crbFBp?=
 =?utf-8?B?SDlHWFFZdG9mbXNmblhvYUNBVWNkb3NXTXM4OEx1bTRPZjhYTFlhaVAzZzNE?=
 =?utf-8?B?Zy9yY3pKNVJhRHZiOWFWeGtmT01aVWgyaDZRRUUyUEZWRzlUdEtseVEyU0h3?=
 =?utf-8?B?S0JZNmhpT3ZnVUpGK0ZjYjNhNmhvRTd3RnNia1luSCtYTFo3VW9PUUpVWDRr?=
 =?utf-8?B?bUdqTnBYSnJ5RTh4Y1RudTNQQUZiQTFnNnBjWmdwdm5KdUhrUnhvRUdDbjdW?=
 =?utf-8?B?bFc1U0NEYVFsSFRRMmg0SGc5R2ZZSlQ2ZXk0RGxuN2JGTVNnZ2VPaGRlaGNO?=
 =?utf-8?B?L1dlcDZKWVRDWElVZUkxbUFBZVc2WjliWmM4RHBuYWYvVm44SWJWNEhiYlZq?=
 =?utf-8?B?TWFIekJRWEV1MWgvSFBSdG5tbTd0QUY3MHZBazcxT1R5eVB5cWtWYnpMeVdS?=
 =?utf-8?B?czROaXJFSXVQbVhta1pXMzVkWjhiQm9ueFdWb3VuZm44SHFhRVEvUGZhV083?=
 =?utf-8?B?MTRxdlAxRkxmMUlmQnNodUpsQzFZelZ0KzdPLzdsZWRSN0NIWFpqRGFlZkhm?=
 =?utf-8?B?d2dIZERlTWM5UDM3ekpqaUNBNEQvYjI0eG1zK1lLMHpVNWk5aHQ2azFGUVcv?=
 =?utf-8?B?ek9HOFE3QzRBTnNtZ2lmZWw5aFVaekhBZ0hmdmR4N1ZieVpob3VtQjRrMTd5?=
 =?utf-8?B?ODNlT2JZV21aNG1Ta0h4OGlGa2tnZVpBc1ZuTVppOTJ1Rm5lR1lyeDdaSEpv?=
 =?utf-8?B?UEY5Wk1peTl6dUg3S1UxNXppeTdXUVIwdWlkU20wR2dHeXJ4T1EyQXJiV2h4?=
 =?utf-8?B?U1g5WEVtbXpxYi9Qc1JCTU8zMXV0bG0vQk00SzdhOHM0djBUK2daRmRxR0FV?=
 =?utf-8?B?cFliYzlpRWpRQW5IU3NjNCtvWjJsQVUwWWxEeVhZaTBzS0VrQXYrMUxyVFFH?=
 =?utf-8?B?cU80Sk9aTFhDMTAzWlB0ZkMzWFJSeURkYXNtU0Q0Q1NBTVhGcUxtQ3hNLzRn?=
 =?utf-8?B?S3kyY3d0WVJwNDNEUngzNWI1RGpPMHJHZUVMRUhZaWx5bTN1a0trRmV2VTdC?=
 =?utf-8?B?U05DcmY4UlVGZUpGRFkxMmNoZEYrd0RCTFNKRURvRloyT0VVYmt1OGJ1MUpp?=
 =?utf-8?B?VlBxYWhuajh2eUtPL3M0RWs0Y1NXbWhYLytkNDdGd3hsbVJKWmpIeHR3WkpE?=
 =?utf-8?B?R1FaQmtLTENVNU9SY1JkekEvWTczdWQwMjdENXRDbXJKSkVNa1hReU1sNW96?=
 =?utf-8?B?bm5FMzV5ZUNrZ21oOVBzVjNjQy9JYndsdGVTc0lkK0dFODJpcnJ3bVo4RTUz?=
 =?utf-8?B?czd6U01FdllqWFRjRlJQWlg3aE93RmVXbk8waXhkYlNabVhnSlQ1aGVKVFJQ?=
 =?utf-8?B?Rk9NWUdCc2k1RXdHeTNYU3R3OHdtRG5PYldQemVYSnNLSkE2eW1CWW5zdCt4?=
 =?utf-8?B?bVVqRHRrWjJaenNZNHlXMW93NHFJUlJITXo1ZGdRajAzSFVxQndNWTVPSUpX?=
 =?utf-8?B?VDQ1TG9UMEpKTSs5eG1ZK0ttdmo0b1FBeTNFcDJpNVd6V1JmUVZzSHRYdy9P?=
 =?utf-8?B?NWRpOVlTMkdCMkE4UDd5REwxek81dWwyV25UZk53a2hYUzMzcmFjRzN3MkFB?=
 =?utf-8?B?L1hjUkVrYm5pWHoxRXg5enF5RURSZ0RNSDBJNGd2cWZjbWtMaW50dnQvM1dF?=
 =?utf-8?B?NnlVSVZabW0wRWp5WkdQTEM4MDlJdWJTNEJyTmFKL2NBdDExMW8yTmU2WGdQ?=
 =?utf-8?B?OTh0b2czWVZReWk2aXozYW8ybEM1NHRFbmFSQXBmd2VLQjZTYms1ZTlzT0ZP?=
 =?utf-8?Q?S37nlYjoOQRrAR2DWLTSHC9HP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9118112-c9ef-42da-bea5-08dcec2e1215
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 08:56:19.9430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pjdx90u4vYXMcx+k9hU9Ec75dKSw+GfcRIiYQqPMp/C5E8J/8IoineuXQyBgE/J6cxv0E/3Xdrqg6WRVSvsldw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7985

On 10/9/2024 11:37 PM, Paul E. McKenney wrote:
> SRCU auto-expedites grace periods that follow a sufficiently long idle
> period, and the srcu_might_be_idle() function is used to make this
> decision.  However, the upcoming light-weight SRCU readers will not do
> auto-expediting because doing so would cause the grace-period machinery
> to invoke synchronize_rcu_expedited() twice, with IPIs all around.
> However, software-engineering considerations force this determination
> to remain in srcu_might_be_idle().
> 
> This commit therefore changes the name of srcu_might_be_idle() to
> srcu_should_expedite(), thus moving from what it currently does to why
> it does it, this latter being more future-proof.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: <bpf@vger.kernel.org>
> ---

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>


- Neeraj


