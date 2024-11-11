Return-Path: <bpf+bounces-44515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719FE9C3EFC
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 14:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 614FAB23EA2
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 13:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E71B19E970;
	Mon, 11 Nov 2024 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l2+36lKY"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7995C19DF48;
	Mon, 11 Nov 2024 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329716; cv=fail; b=lAKX/WhuHNyeHFCexlWNZM7LKN1Hz1MsN/iliq88WwtUd/K/tmOE1OoMNZWOO/tILSo+IXZ2IE0YrrYjHdANagS30+wqRyHaBioy7cXahmLnshtoai4EZ0dTnRMXhlfu8E+Mhg+eq01+LlYMvBbXnC+85DW11DdrtNxkEudXMCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329716; c=relaxed/simple;
	bh=ZmcZ6LJET0SZgwJMYLL4LwW1LElP3u9LbYgjDSUbQgg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aIJ+eFeH5oXnjV5zibVZhPDSl2UD9ccQ2hca3as7NjgUgoHZ8AtdH6WriDjZz5jsxWAsEMYZTiHDj7ZHS0Ai3e71ki0fSvbGWvpXRhOygs6jcQLNxhlxXPvz/H42I6kNpBzYwcxdFQ5djkyFY7W8JMxaf9oaYe1GuB+sgHVTkyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l2+36lKY; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4p+sg4w1o/6LeGMDtSBeAYTCQJHjKpGx4Va7Qtc0taLlkcVHj6AvDEOQ5+iEviKDZPH02bwpMrO5Ifz+gwZRQEGXNJ5VDLkPZ6MI0+SAWaiUttoZ93PD/N43FvvPZjuz0V0LX3pzpbkvlXh2xmGwNJ8inK04B8gYCXHpp7c7lwWXClRxqlXOe9mM8DOvZgLymHu4pb2ZG/CHC09uEUbNWmfyzv6NF2+M81Yd8XtQJsesflpSHLlLI2QNLiT6wjL0iP7nkLwQdRAZcaIqq6IkqY4puygxxfIZpOLB9ysniriB/9pLZr91zC4iJGM//mnc8HksF/7F2iDMbEZNCNKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7axg7edEfnLGCKpucB22kwenrpxWp7mMAMEPf5DcMV8=;
 b=YHTehEvVLuMBUZATuQaZ0YjVZOqr0OT54lDQdSA4hl/LTz6NMxY4qQsOidoyGTh7BSIGioNxS5xqNoMdiaoogJBIrIpIQPYbiTlE0KGbcCR45Vnz7EkJUPf8trm13uBCZ3AScsIP9tSDS+t0m5CjYVOVQ7jjAzvZ0djR9zqWu049FL0JrN9nEpE/Yj28yNZ1hQ8axJTaEleWSBO3s4VP28MRpKj0lioPByxC8HxeG5skInN2oloQyU+RJXaacqwQfrTXFjlVsDQxkf7OuYqEi/K6zNCEJiOwRjTnkHhNFkh3wtLcZvU8N4aADOAZeGjYURehG4kH7bYDJL5ONIDoxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7axg7edEfnLGCKpucB22kwenrpxWp7mMAMEPf5DcMV8=;
 b=l2+36lKYMNB8IhCgWLg7P0M7BnRBMjnvGOs/rWCceb08OciCuiXQBb3HTTeGOYdVLFnZHw+QDZJYH+X5LVLrPVRzvKVoQLU5n7TBZTJjZqXuCUWcoxJ4OEMMbqcmqr3Xwtn8InCqzKVO70CNNWkP+UgPlkSlZG339NHNj7Oa648=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 CY5PR12MB6454.namprd12.prod.outlook.com (2603:10b6:930:36::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.27; Mon, 11 Nov 2024 12:55:12 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 12:55:11 +0000
Message-ID: <e46a4c37-47d3-4a02-a7a5-278d047dd7a2@amd.com>
Date: Mon, 11 Nov 2024 18:24:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rcu 06/12] srcu: Add srcu_read_lock_lite() and
 srcu_read_unlock_lite()
To: "Paul E. McKenney" <paulmck@kernel.org>, frederic@kernel.org,
 rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
 kernel test robot <oliver.sang@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
 <20241009180719.778285-6-paulmck@kernel.org>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20241009180719.778285-6-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0029.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::32) To CY5PR12MB6599.namprd12.prod.outlook.com
 (2603:10b6:930:41::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|CY5PR12MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: e278e178-a190-47dc-8a01-08dd025013bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzlZOHY1VHpZZ2xXNEtnZW4yMG1wWHk0TTVMdGoweWdET2NqRCs1VE9lWi8v?=
 =?utf-8?B?L1hBN2lpK2wzTS84ZkphYzZDay9kdGdURVAyeExkL2ZMRFh3b2ZIdXlxMjVn?=
 =?utf-8?B?UkxHVHRLcmRZTUNFQXIwT2hxYXZDbDFaWGpNYlZNZUYxQjFDaHpRR2VsLzdR?=
 =?utf-8?B?VUJlWFcrMG1mNWUrYk5TSjU1eUNZdTNJY0d2ZnpNM2hBYXlvT1QycjYwdDRC?=
 =?utf-8?B?OVZvaXN3QWk0Nng2NzNFRlhFYUdBSmpMaWFtcXVhbVVHREU4TFNLWWtDNWNt?=
 =?utf-8?B?clRHK3k1RnRpa1p5ZU9PSmtuQ2lVN01VV0JJVFBFalBPVlljZmwvOVMzY0lJ?=
 =?utf-8?B?SFpKc25nQVg0clhsU1BldG5rc1RnUXpIV2JsS2psWmdRN2dFOGlJaUxycEtN?=
 =?utf-8?B?N1dVeDVjK20vWjExMWRXbnBzb2VHSGJCbUZxTmc1WkpDakJNb2JwdHZ5RUZl?=
 =?utf-8?B?ZTFlYmhDYlVWb3ZUNVpKamNJa215T2FuNWk3bTBlSXlUMVczMFZLVjRiRE9X?=
 =?utf-8?B?aDRFYkVPUHRiRHEwZncyVkFwZGZqMXNMMm9zWWJhRFhxYjRKSE5GallhZlI1?=
 =?utf-8?B?SWVZaEVJOFFiRm1PeFlCQ1ErcHQ5dWNicVdKN25JSkhNM011STJvdWhoSDBW?=
 =?utf-8?B?RGdpVWx6RWg1RDBST0dQSTdCRzJJSWFDd1FhWUNCV2VsVVpyNzJTcDVaaVlV?=
 =?utf-8?B?QnlrNFRLT3pPVitKSTh3RHJxUUNnZ2RFbnE1NlBtNS9VNSt5NHFnRW84bWRI?=
 =?utf-8?B?U0J0US83T2p0bndhL3ZxZ3hkZk1IS0szclBiSE5MZlJjakppQTRSL3pNTWtX?=
 =?utf-8?B?SVoxQ3hjWGZ6RmNWcXB5T24wbHp6a0htUmJsai9oWkppWDNMelJuaHUzK1BP?=
 =?utf-8?B?REZRZ3RjbVdHenEyVGs3NzJvUkMvTTlSTEJYemZxRWJaT2tSYzFQYThnaFlm?=
 =?utf-8?B?VmR2eXpFVVhlc2kvM011em94Yk9zZ3piN3hTSWtFOVFGZ3pJZXpoR2Rqb2VL?=
 =?utf-8?B?bUtGMzZ2MFUya0QwUmNKNGFXa2FiMkt4dlp3eWtBNDJBQndwZHFHeHFnc0lk?=
 =?utf-8?B?WGh2UG5UU0d1K0ZYdkd2ZXlXTFVlWHBLeXlPdjJ2Z1F2K2JIVXZ4b2poWFZE?=
 =?utf-8?B?TjlVQzhxZVZXamx2UDFZSTd0RmNremRIdEJucnpodHF6RVhob1Jtbkdna3Jq?=
 =?utf-8?B?aTFrZTFRQlA4cmU4N2NXTjNwZEl2SjlOZmxQbTF6dnRjMjZtdkFQanM1UmJV?=
 =?utf-8?B?MnVua29IVGlRZVJ1ZlB3TStXSGZjcytYNEFyTjVSOXJOQll3TEp1VTZkSHBW?=
 =?utf-8?B?cnpnL21yWUNyUklwbjNTSFQyZngxam5mMDlzMTI1Nk1RMkg1ZzFJVTVBV3Q5?=
 =?utf-8?B?TGRHN3NSUU9vSXNnYmxVL3A5WDcvcmhvWjhjamJiR0hLcWlrSFptYUZwYTVq?=
 =?utf-8?B?L1dSRmc1ZllGYlRKMXZUUnlnYTBPQkI0aVlMRzBsS1dnSzBaZCszWFJrdlNN?=
 =?utf-8?B?VjlMYjhzVjg4azh3VWl0NWNoZXpybEFNU01GT1FtSklDMGNZV1crdXdsQWZU?=
 =?utf-8?B?T2x2TVdzYzBubWk1VzFuRkdaRFMyak1VYVFlbm1PQ3UzNHgwcFliU3BHTzJo?=
 =?utf-8?B?Ukc3cUNKUkxkVU1Sc3JPdndXZkI2N0EvOG1rT292dzNJQUpKT0Vvb2RCZEZX?=
 =?utf-8?B?aUU3bXFJTjl3WEhqNE5PR0JFcFpTMTgwd3BHSWZyK3JpQThacEJMbjk0eWIx?=
 =?utf-8?Q?115Q8bFcDVVTv4TYjO5mTKrs8AqmCHMpii1YegV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXJLTFc2ak5VblExMUNXSUtvQUNwSTVWaGsrNnFwNC9GNnI0OElPSEIvWTFv?=
 =?utf-8?B?Z2ZUSEVWdHgxRzVqZ1NacFRlYnNXeUNLNWNtZUlxK1pzQkN2ZTA1Z1FscCtI?=
 =?utf-8?B?WlRkUFRESmNDdFE4U3dTT0RaQW1qQ2kwZlNEM3ErRFJsdjRkSzJhb3hPbDQ4?=
 =?utf-8?B?aVNFNytuNzFtRHhuY0o0Qkp6RUEvVDF2NDY0SnZnNVlPWnU5NHpXRVJ1K1Mx?=
 =?utf-8?B?eHpaYzdScTZTM3F3OVcydGhuelpFWktyL2dwOVdubFZ1SmJyRG5DamQ3RmNo?=
 =?utf-8?B?Z3FueUxXc0VhVU1haDQ0OUlEdVNJcGtjck4wMmMxaDFGalBhY2dGcVlwT0JO?=
 =?utf-8?B?Q2d5dnJ5MGVXcVlzdWoyTXQyR1FhVWJsbHJmNW41NGpBVEhPQmVtS1gvR3hH?=
 =?utf-8?B?RjNHQjhVNkNNbjFoM1pFMnR0NkhzRlY1QVYvbkZTRTZKSXlLZjBiZ3NwK21R?=
 =?utf-8?B?RHh2ekozeW9aUWU4WEFybXR0L3Z4blF5bno4UUE4YnMyRytRcDhmU0w4ZmRP?=
 =?utf-8?B?Ukx0dFY4L29TeEQ2MXdCc0FPL0l5RWVXWHF3bmtMM3hvTTN5MXZRbm1VUlBy?=
 =?utf-8?B?SmJ5WXFUSkZsQU9oSE9GMmUrSDNmMk5HTk5OMk5DVnd4dFQ5MC96SXpmQ2ds?=
 =?utf-8?B?OWNQTnFVVVBBNEtIZXV3TFVYYmY1ZDVmRUdkMGxmc3NJVWtuTWQ5aEhJSHRv?=
 =?utf-8?B?ODBKeHRmdWVVTGRIQktJMzV6YkJ2WWY5ZHlGSXpDelMyMzI0TTE1WGpRWGVL?=
 =?utf-8?B?M2lMOWYwMU1CM240clN0ZGtnaWh4eWZOZUEvVTE1WFdOcCt3WFVLS25Wa0tD?=
 =?utf-8?B?bW84UjBLcFJsY295ZlVCZ2RyMDBlbG9VMHZjTUk0dnZDejdPSTl5M1ordmdT?=
 =?utf-8?B?cy9RUndjc3l0RmJ0cHY0RzBtVm1wUjJjLzduSFVHUFBxL3JBZ3Y2MkUreXBp?=
 =?utf-8?B?aUZPNlFSdytFY1E0Q1J5bnduTzhjMXAwQy9lbUd6alBTQTd5VmdxaTFuV2JW?=
 =?utf-8?B?eFQ5dHF4em9VZVhKaDFCa3RVMmZnQ0Q0TjhkSkZ4bExBY1NwWElnNTZ1TlNT?=
 =?utf-8?B?NjUxWUdRaE5QYzdBVUQ2Z2VUclh6OWYxbUVZaUhzT2U4YkFyTnVMR2tCRUlu?=
 =?utf-8?B?aEgyR2U1Y1E0b3hTS0toTk00UXJteWkwYkt6UmpTNXIxL1NhTzF2bDJtUGtt?=
 =?utf-8?B?SXJJWDNaK1p1THZCSEJad211TUlKY3JVTThUYTk0cjZ5cHpIdlI0aXFXb3RQ?=
 =?utf-8?B?cmdzUlpES2xYN09tVjczWmNjOU94VmZsNiszUUtyVjRQS3RXOGtGalRNTVRD?=
 =?utf-8?B?QTJXZjVyYmlnY3VWMXFBNUxQdFJQeUJhRGtrMStFajFwdU9zeDRmUkZZQWQ1?=
 =?utf-8?B?OW0vdlczL0dGcXYwallUTE9MeFJLdmRxT2tCU0VOTkJxUWdRc3Vid0EzdkI4?=
 =?utf-8?B?VnRCcVpDQjZuVjBKRjkrTHFjY2xwcnducWt4RXc4T3cvYzdDbzhWME03MFpN?=
 =?utf-8?B?cE5RSjNHejMzdDM3dm4vY1BFQlF2M1NOb2FQMWhMQ0o4amtYSm1rb1lFSXE3?=
 =?utf-8?B?UmQrV0RKMlZlRkV1SXRnaFlhbExudkNCWkFNLzQ2TFdRVkZVN1QrcDE1cjE2?=
 =?utf-8?B?c3JpWHREVlE4NEhGQnJLQWxMQmtCZE9Fd3hDRUZnbkxHbVNYbEpNMThLTGhk?=
 =?utf-8?B?d1ltcmJMa0Y4RGJnWkF2TFRaR0FmNUhiRWJqV0t0Mk1DYTR6MjFHSEUrai9W?=
 =?utf-8?B?RWdveCtmTjdyU0FnM2txM2NCYWpWUEloaVlKNnVhbEloNzFyZk5qSFdhQzI1?=
 =?utf-8?B?T1NmWlJwMzk5czNUU0FIZ3hBSlpyZ2l6ZVZiVk44UUhUb290M2o0bTlhOHQ3?=
 =?utf-8?B?UUJ6WXFsUjhzSEgrS0JIdWY2R2ROZUVaUHNJVHlWaE01QUNiRThBVTVxSGpU?=
 =?utf-8?B?U0ZXWTFFSzBZMUZ1QllndXhBOUttQ2pmbVE2TEpHWExTREVZNnQ2Q1JEK3Qv?=
 =?utf-8?B?VUh5dFdNa2VieEF3NmtxVjVNVWl2MFo1djZuRWJJNDAyRkZGL3YwdURrMGdv?=
 =?utf-8?B?ZGpmQjJoY3pDZytNR3Y1Nm1yVnBJSUVYZDNoM3ZZQUdyN1IvdjZsM3RxZkwr?=
 =?utf-8?Q?stwnZCQJCmbrZjAIXr51mtgeR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e278e178-a190-47dc-8a01-08dd025013bb
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 12:55:11.7530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUcdVomFOQzoAMPWs9yss319oNDqhmhMtdorGN8o2bosYImz3sEuc2pF7HTA8LiCzg8PDfQpkFhVr7UWxPaf9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6454


>  
>  /*
> - * Returns approximate total of the readers' ->srcu_lock_count[] values
> - * for the rank of per-CPU counters specified by idx.
> + * Computes approximate total of the readers' ->srcu_lock_count[] values
> + * for the rank of per-CPU counters specified by idx, and returns true if
> + * the caller did the proper barrier (gp), and if the count of the locks
> + * matches that of the unlocks passed in.
>   */
> -static unsigned long srcu_readers_lock_idx(struct srcu_struct *ssp, int idx)
> +static bool srcu_readers_lock_idx(struct srcu_struct *ssp, int idx, bool gp, unsigned long unlocks)
>  {
>  	int cpu;
> +	unsigned long mask = 0;
>  	unsigned long sum = 0;
>  
>  	for_each_possible_cpu(cpu) {
>  		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
>  
>  		sum += atomic_long_read(&sdp->srcu_lock_count[idx]);
> +		if (IS_ENABLED(CONFIG_PROVE_RCU))
> +			mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
>  	}
> -	return sum;
> +	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
> +		  "Mixed reader flavors for srcu_struct at %ps.\n", ssp);

I am trying to understand the (unlikely) case where synchronize_srcu() is done before any
srcu reader lock/unlock lite call is done. Can new SRCU readers fail to observe the
updates?


> +	if (mask & SRCU_READ_FLAVOR_LITE && !gp)
> +		return false;

So, srcu_readers_active_idx_check() can potentially return false for very long
time, until the CPU executing srcu_readers_active_idx_check() does
at least one read lock/unlock lite call?

> +	return sum == unlocks;
>  }
>  
>  /*
> @@ -473,6 +482,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
>   */
>  static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
>  {
> +	bool did_gp = !!(raw_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE);

sda->srcu_reader_flavor is only set when CONFIG_PROVE_RCU is enabled. But we
need the reader flavor information for srcu lite variant to work. So, lite
variant does not work when CONFIG_PROVE_RCU is disabled. Am I missing something
obvious here?



- Neeraj

>  	unsigned long unlocks;
>  
>  	unlocks = srcu_readers_unlock_idx(ssp, idx);
> @@ -482,13 +492,16 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
>  	 * unlock is counted. Needs to be a smp_mb() as the read side may
>  	 * contain a read from a variable that is written to before the
>  	 * synchronize_srcu() in the write side. In this case smp_mb()s
> -	 * A and B act like the store buffering pattern.
> +	 * A and B (or X and Y) act like the store buffering pattern.
>  	 *
> -	 * This smp_mb() also pairs with smp_mb() C to prevent accesses
> -	 * after the synchronize_srcu() from being executed before the
> -	 * grace period ends.
> +	 * This smp_mb() also pairs with smp_mb() C (or, in the case of X,
> +	 * Z) to prevent accesses after the synchronize_srcu() from being
> +	 * executed before the grace period ends.
>  	 */
> -	smp_mb(); /* A */
> +	if (!did_gp)
> +		smp_mb(); /* A */
> +	else
> +		synchronize_rcu(); /* X */
>  
>  	/*
>  	 * If the locks are the same as the unlocks, then there must have
> @@ -546,7 +559,7 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
>  	 * which are unlikely to be configured with an address space fully
>  	 * populated with memory, at least not anytime soon.
>  	 */
> -	return srcu_readers_lock_idx(ssp, idx) == unlocks;
> +	return srcu_readers_lock_idx(ssp, idx, did_gp, unlocks);
>  }
>  


