Return-Path: <bpf+bounces-65494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CAFB2421C
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 09:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D5E563C79
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 07:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8942D6408;
	Wed, 13 Aug 2025 07:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="a/QI2M1C"
X-Original-To: bpf@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012014.outbound.protection.outlook.com [52.101.126.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F397269D06;
	Wed, 13 Aug 2025 07:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068417; cv=fail; b=DAo+SuYGZM9Ay2zESOUS3rYde6K0YYPnCkJWPlknZrx8rz3tfW9EzgiLmSpftKBgO9Kg3GM3hW8FoSCWecPgfQI/x2PV8kct7YebqHkx8ZODbXbS8PQq1ZHr6G0KGGVNnNyuIfiaO8mtrpjbaIh9yfl+LgFwRvkl0uOUFuWTtDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068417; c=relaxed/simple;
	bh=G1nPXjcuk+lWT6j/TXHpkX5o46M/VLWT90YHyClSg9w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K5zvyI8CUp+XW+KxbQEqeQ9bPrxu61aR02dE+zvtl8ppEMkpa3S3cp6KAA5RJVSZZ5cUoFclfYx17wlAmGoiyJ45LNXq4GyCihgT0nyEV7efT+xMOPiGpaU99QFkQ8lRdZYOdVdVRgNL2zM0NEXjBD8PaTwRbrK7o9Q9195lNlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=a/QI2M1C; arc=fail smtp.client-ip=52.101.126.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDp3ik4eLQnmnjT5dbXJYXJPEIXBFQmoktruEE8SA6YdXA+MqDKElFKn58iZFzasw6tv7pxejfP8Ku67UqAsf0AsjHKH+SPWeuvW/o2xsCmloLN2qeJOBIlO1ke0eGh3knPEw4+Pi6ihB3hbQ4HdJecwWK9HbhFJTV9zSUQIjYQG663DhokGO34YsQ0M9HzpoOAvtZ9SADtvGkstdYvC/BmQCoO3WncA3p+f/tICNOCpqMzkvVW/uOIpabMH+hvYfMwpBWGE6Q8inJCPYY9/NxJKOFVqfmHaBM2gQt5+ZIDCpQyf7oi0zfLkH3sJRVSvgHS291G2aWuffmrtWEokEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+fm5x27WAV9urzCoXBYD+H69WceYmwFQnylzVAgTk0=;
 b=BXNFFRuOuWArwVx/6JP2GLzHGRsxSddm91JXOaSeLCXxGjB9DRmu6VcPewsZc1hvq271j7cPYpx14LJRDDWLLp/7c0u0bo5dsW3vxQ7Z/AnVtg1kTyKy2glRIk0SWr20jOSYnFb+QgT80xczDA7sJVyX1v3diLPN10LaQnRJAfCI/5UQZzdxSM+gaE50ZVugbdyZdVUsutyJbb5SE46+cLscotM9jsmDnse7Z9P/PkKq0iqPUNE+DX9kSCPdWzmsBr7YRfwksg213DaCxrvPBYVposAFPNwhaxqXA4EZmaCbkLcFzJzHgXrHY0QhxJag503OLjWZ9pUcBkzOrg6HwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+fm5x27WAV9urzCoXBYD+H69WceYmwFQnylzVAgTk0=;
 b=a/QI2M1CAhyo9hKK4mvyWfCYrszFtkiJQgJgm5MQ6hUjBIPKifNX0WMILn+COeDw1hKG2BhvI7YOx6mky05vVVI0LFE7DitB1VpW82xDL08gs084E+bnIET2LW8EegZwhv24k5arIlWeRQ7w2S8x1mG/VrUfVdQN8KkWuz+54tN6Dei1Jx8avtbg+o7hVxV4iI6JcA7YlYHTbEObK8Zjjx/6pjNuGHE4rpC5TJvnSYOyOtFEYg6m2noLXl3VDfgl+Ckk6n4NJlKRulyF63xOzh0aF9Ipu0Hx/YI4xXRGv6Iju7ptCezZ2bU1y8sfgInLsW7uvx2oKFR7BWAFqfDZ9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 JH0PR06MB6559.apcprd06.prod.outlook.com (2603:1096:990:2f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.22; Wed, 13 Aug 2025 07:00:10 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.018; Wed, 13 Aug 2025
 07:00:10 +0000
Message-ID: <d015dc98-cacb-456e-ba31-3cd387fe1244@vivo.com>
Date: Wed, 13 Aug 2025 15:00:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] ethtool: use vmalloc_array() to simplify code
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)"
 <bpf@vger.kernel.org>
References: <20250812133226.258318-1-rongqianfeng@vivo.com>
 <20250812133226.258318-2-rongqianfeng@vivo.com>
 <20250812134912.6c79845e@kernel.org>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250812134912.6c79845e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0055.jpnprd01.prod.outlook.com
 (2603:1096:405:2::19) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|JH0PR06MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e22adfa-977b-4668-603c-08ddda370b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SCtNMG42aW5Hc081Y3FacGpudTZFcklmbkhnRVVsbjZHRFZQTEF5RFBQaWcx?=
 =?utf-8?B?RXhoYzh1QnJMK25iTlVOSElrd2hObktNNFFabi8xOXBaZWdQYVBCRjl4VE10?=
 =?utf-8?B?clV4WENTSVBUUnhmUmowZnFMNDJUb3FXeXlLckEvRDlhdGVaejg4TStMdHNq?=
 =?utf-8?B?SVo3YkxYdjVVL0lpN3ZuTmx1TUNsdlJjK051bmhvSjdVUURaWjg0V3RaNmJo?=
 =?utf-8?B?d3NBaDdIdCs5Y0k3T1RKWWd1RHo5QmF5RXd1Wm5obVE4MitwNmp3d1l3Y0JC?=
 =?utf-8?B?OGtUcFBRMlNDNWpWRkJlYXNYVWltVG1OVThkSEYzM1NhWmhvSVp0N0tNSWdN?=
 =?utf-8?B?MEdaWFdiMkE3cGlrZkh5NEE5QUF4M3ZjSFEzWGE3RmJ5aFFDckJSMG12NVNa?=
 =?utf-8?B?YWlxRTNIMEhKQk5zVjdQa1l6UzVTS0ZpcnBtaXRXcGsrUlhITzg1bkNnckZI?=
 =?utf-8?B?eTVKR2tDWU94NVNoc2dxWjBHYklYSEhHdHh4YjNGQlVGQ2hseGpUcGsvYk1K?=
 =?utf-8?B?Q05BMlRVRGhaaVAwS1NTc1NhSGs5RXdvZUMrMnJuellqY0tRWG1MNENxckxP?=
 =?utf-8?B?MGNFdThJV2NJMnE3Y1VRTUdlbXgvZnY5L3p0K1oxYVpkN0s0cGV0Wkx2Qkk2?=
 =?utf-8?B?YmVnZmJTTnd4a0xucU9kQnE5NU15bTRLNnpwSHBJWmx4VUN3WTZSaXR2SThC?=
 =?utf-8?B?WUFUdHBNVG1zY0s0U210TTJDVGYzZTRtMTRCeW82SHo0d21PejN1c254SVV4?=
 =?utf-8?B?UUZ2Zk5MQ0svcWFqMnJmdk9jdEVWaVBCNTNBVHRZcmhiRmROMEFDTnRrT2E0?=
 =?utf-8?B?YXV4dTQwTXBZTUIrV2Jkekh0WmhDVXpOejJ5MWh6aG5Tc1NrQXFzV3ZiN3Jr?=
 =?utf-8?B?ZWNrbUtOSGJ0dzE5WkJJcWN3dHU1NjFOQjdxd0xhRUlKdlBNM3VGMnJ4WndP?=
 =?utf-8?B?OFFIaGppTnR5QmYyaWN2YkxrQWpPR2wrU2hEeE9JMGg3T0V5RERxLzBra1lC?=
 =?utf-8?B?UE5kMDlYRDBpWjB3WERpY3BLeWh2TmRkNlN3NkU3NkhWMmZ6eEVWOU5RNmUr?=
 =?utf-8?B?VXNxYkRPQmlQM3hLeWFmZVhaQlh0WE8vZzR2ZmdZSGg4RGZ5bUNKOE5MQW85?=
 =?utf-8?B?YlNpTHJCeHJkVFNnN2VFM0pTOUZMM2drSzhTSEFsVnptbDU5ckFlOWhwMXVM?=
 =?utf-8?B?K3p3UnBNQ2oreFVpaW5PVXZJcUdBRmRLUTlzUXF6bU9sQWt5NTB3dFB3cmpT?=
 =?utf-8?B?MFl6dGtJaGoraHZhQlhSMDdLY1hVcFBIVDlRREpJNTRoRzB2emtJRDRiZDBW?=
 =?utf-8?B?Z25yMjh3eGwzL2VSclN5U0RBN1JGTGpjSnAxV3AzVGpqWTQ2WTVkcG1ReXcr?=
 =?utf-8?B?QktNUWVSNno5M0RXT0pzTE5hZXFRRkVWd3dQbXVIYXd0TW9TWlBjVEw2OUg3?=
 =?utf-8?B?c2cxMXBhc0h1NmFWcjBkWHIwTThDL3lpcWkrZm9PbHo4OEEyc1REYWxuNHA5?=
 =?utf-8?B?S3VkengzNEV4NjlMVkNYbEt6L016RnBIaDZuVFhBMkRFam1SNDZXSVgxbDZw?=
 =?utf-8?B?Nnp2SlByQ0kzZUhUQ2FZdVdXNU5RckE5T0VmU2o2U015NTVPZ2Qxb0ZFbE5m?=
 =?utf-8?B?YzhNTnpuMVJoOFFsVUQ3Z3B2YW43UlpwcitWOENHakNpeUFQbjE1TGE3Z3g0?=
 =?utf-8?B?MithbnpQUUw0S3VadXQwcnJHQ2Q3Z1hhOGdVaHJVbEc4K1VOZjhGcGFjREF0?=
 =?utf-8?B?Nk1RNjN4Y1czZ3BRQlhRcTl0YW5Ta0lEalVKL1M0RVVMSzZQQzNzMHN0NUdo?=
 =?utf-8?B?YkNOREJQNnJLQTZLVkZMaXBvTVZtSzY4eklxVWtBbDU1WXhUQmhtc24yY08v?=
 =?utf-8?B?bkNnTlpRYVcxY1ZkR0wrcVpITjREL3RGOEN2Nk9ic3IxS3NHWWtWdHlxc0Jh?=
 =?utf-8?Q?Z7fLR5puZ0c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTNqY3FIdHNjbDhtWGQ0dFdTU0VCQ3FTYmhabEhjM1pOak9hb2RucVgwbklJ?=
 =?utf-8?B?L25QNVlYNG95ejVXeDJwVjNWUUhQemRsUm1XQlFPR0ozUWtEN3R6MTh2d0d1?=
 =?utf-8?B?ZGM4SXZNRDArVnMraW53QzFzcWFVbThDOFJTcXFLNW1kbFNjSEFGd3VMVDlw?=
 =?utf-8?B?MzNwSEo4VVI2NTFqWG4wcnRwdDE0TktCSU84TFovQWc5UThHdVB5eWg5ODQr?=
 =?utf-8?B?SnRqVWlOTlEyYlhlQzFqcUF6dFlFdzFiUU9TdU1EUlg0c2RwQWxwZnU1aDdV?=
 =?utf-8?B?UXR1WFdOMUxsSHg0VDBBdEU5dTJOclJpbUIwTE4yaUk2MExYQkszMDB4Z3BI?=
 =?utf-8?B?ZDNCSzV6dkRxUDhQL3UzeFJwNWliMmkzZCs1TlZ6NDRWVStYQS9YaFhEZUlo?=
 =?utf-8?B?aE5UVXRJNXdCV0lqaFY2elNTMmd4M1ZTdnk2WEVMVTNISG5BeUFYdXNYS3FL?=
 =?utf-8?B?ZGFpaTVxK1hHdmZqaFRtVjFjZDRSTWRnS09CcTUzRTNZREdXb0wvVXhxWjZS?=
 =?utf-8?B?SnZUcWt2WEQ2WVlzcy9YYlNXU0RNbnZzcVg1ZkVZZFloM0tWUVlxUTQ5dXZi?=
 =?utf-8?B?NTZWQlBndXBrR3hYWjBCbEp0SlkwbGI4SFJjN25nRytOZzZLRzBZQms2YnNv?=
 =?utf-8?B?S1FNbU5tL0c1VFdBSW1YeStmcDh6TldoN1VlM3Z6NkJVUGF1RnhqYzVxdXlJ?=
 =?utf-8?B?anNZN2hneFcvRkdUdWZHZnlkR1krS0tRRCtiSkJMSGxIVU5FZnpWVzl2RWxR?=
 =?utf-8?B?SUdzNEQ3NFFuVnZPcDlrRy8zQ3V3RmFIODMrTWNCTHdaQ0lFbGcxVVVZK3F6?=
 =?utf-8?B?dTNGbHdEbGZwN213cnh4V25pcEtIWk51SXNWTkJBQVl2NEdmTjJENTBFSEZO?=
 =?utf-8?B?QjRVSzFMZElJbXg0SGxkTk5GbWpqSFhKWWUwSUtsaGtKS0E4MkdsUnRKc2du?=
 =?utf-8?B?Z3dsczlOc0NabStGcTJteFUzRWhGVExGOFVBV3FRRG9xeWdzZ2FPeHVqQy9T?=
 =?utf-8?B?OWVPY1M2akxsbUx4czRWM0Y0Sk9vYWY3TE50Q1pxUFNTTnp0QTFIajl1ZXYy?=
 =?utf-8?B?YnFQdEd3OVNjdnB3aHluQ2NJOFNSVUlITEdkQ1BVMHBTMDF0MWNaSE5JczE5?=
 =?utf-8?B?MjA3K0VhRlAwRDQybm9LOG45dmdURHVZY29jc0h5REphT2Jybkk1WkRvUEFp?=
 =?utf-8?B?Rlo4VE5VS29iaVZmODQ5RTFNQXJaVjJTcVBTSWwreTFDTVJUWFNkSW9OQlhW?=
 =?utf-8?B?aTVpd2wvNW1LV21NWmRScHBpSzllVDlDODJQYTJUN1MyVkxXdWF0U3VHNmtL?=
 =?utf-8?B?Nm56MkJyQ0MrTW1INDg4UnczeDBKM2s4dWZGU2tMdFdMZ2dQV0ZjWC9sMFZK?=
 =?utf-8?B?V3JtaFZWb1c3Y2ErckdJVWoxTXRIeUlkVm4rbHhFY0MzaEpPZGlISFVDZS9y?=
 =?utf-8?B?M29VUDNOQXpzTlZnelpCMGJUd2ZuaXo0cDFXNGtOYnhpVTZleXk1THRXbVQ5?=
 =?utf-8?B?dTFEVFNjbUhBWWVRZTdPRlAvalkwZHpzV1FTNWVPaFpEYTBCbWRQdlo2aktL?=
 =?utf-8?B?dVE1NzkzMzBTZE5mUEk1Q2JqZ2ExYUo5cHRmV010bFFrenhHaHhab0ZwNmlr?=
 =?utf-8?B?enZHVW9EVTNxZUgxb1V0MXVsN3YyN29BZUlBbEpXV2Z0REdzMkFBdEhpN1dy?=
 =?utf-8?B?Q1B6aE10ZW9ueVFIMjQycitXVHNLM0oxQi9wakliSzllMzlCVVJRU0tvTytn?=
 =?utf-8?B?alh2SGFycktTMTJ5S1pweGZrbDFEeHdnYkZHaW5mNDQ1UVVGSGgvTlFtN1Q4?=
 =?utf-8?B?SHJEaGVjTHIyN3BzYXY3L2ZvNHVSam5qenl0dDlSRXJZeUsvbkRxWDFRTWlR?=
 =?utf-8?B?N0hnUmh1Wk4yRVZOUWNxRUk1YjFyT1dxTy80Y1VoSU84S2dNdUNzMVh5WVFR?=
 =?utf-8?B?UitHTi80RDdEeVdtQjkranU1K2VZd3haTWI0OTlDUVJWR1RuaGpJS1V3dTh6?=
 =?utf-8?B?N2VoNzNUelpOVnpzZDMxSnJFNVl1b3RMWUM3a0dWM1g3TVZ0UytVc2ZzN29r?=
 =?utf-8?B?NWpuTXZLZ0NmNHdac0k2Y0pjbHQybHdNYm02RDJVY2pBdnJXTDVjWHpsWEFJ?=
 =?utf-8?Q?BQyeFwqxIlZCg1Uh56iKk18RG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e22adfa-977b-4668-603c-08ddda370b68
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 07:00:10.7796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kL0wa+4kxtx6GLDX2EQvjfOnPxMa/g5PLvFNwcd6fYWONt2Okv25l24w8tWoJ596ZqlBhmOufJcrxQOTC18bXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6559


在 2025/8/13 4:49, Jakub Kicinski 写道:
> On Tue, 12 Aug 2025 21:32:14 +0800 Qianfeng Rong wrote:
>> Subject: [PATCH 1/5] ethtool: use vmalloc_array() to simplify code
> ethtool:
>
> would make sense for patches which touch net/ethtool.
> Please use
>
> 	eth: intel:
>
> as the subject prefix.

Got it. Will do in the next version.

Best regards,
Qianfeng


