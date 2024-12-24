Return-Path: <bpf+bounces-47583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 452E99FBA8E
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 09:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B301884714
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2024 08:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9884B191F98;
	Tue, 24 Dec 2024 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NQVfotmv"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A348DDD2;
	Tue, 24 Dec 2024 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735029468; cv=fail; b=a+0yQy1Sd5Tb8h4Nwg5Z9oKpzkjWFB3Sw+jpDbWCYX6ZvcIq9CJsveRjOzrtSZALSeiCVGHyQ5vhE8aWZzCPV2slzspJxm4dgN7Cj5ROgfOBmoZ8SPW2DCRsb+DRbI1IDi54+7z0rRcC41E0OZJQnbZsTpZqZ6EeEFWkRH8f/LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735029468; c=relaxed/simple;
	bh=ZwhwxmuClpFuLg3MUkVBqhDO5kARr3ps705A12aVjeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=goi1tPn11MfJaY4Ptio0T1urqcBQrsKLUP9MovnWWo6A/zgUF/C8XvhfKHVIQIrJDaRfBNuvBDBxF9R0VWbsZ4SXQ0NQ7ZbSVIaOU3WsQhp9ikUxRSvE9FZYSqW3UjF6PpchhVA2J4hgQWL+u3oavo1P2OVMxcIhA2M9CxJyh6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NQVfotmv; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INwkBvbIqkhTPdcbXvMHgSxTm3ve4FVbMi6ZdK0RMxdEbrhgGpP6LMNIXNt/W7uh0JGeuRgO0QwcIMv6BzKqgcDvWfv3VdaVL2I1GOddgh0yfWyQldI7K+gONYcVu4c7T+2jRHOnh2dB53gs0DD1KYidP7tAVazFjekV3wa94ebsynw9PpqVsQTurdbvdPBZPo43sP09jm5Z7nfLsKWoMq83WxIwAbZr8BixxRRfnHzAdiru7YR42hFOJj4sfthNZ27qgOIMqVcbtL8l0y59IpNLlUTHFiLJRr20svVGAB6UHigN9Q+wng2sCoI9tIlLlWIPZRgESpsZh7C4hsgRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjiE/LY9dxVMX2CSTXt2NA2qJv+0AbNYIRtw8I/YyVc=;
 b=nPLVBoffRViYAZvuAw16HXp72SFHW31l6wNrKdbWEGrU3WoVfUAGQN4CCEfsftTawYzbJGHrIDDFnStPfK0CPzuWMTRffoEgNCyiq1bd9qOJton/PfQKCE5TaSTVzpXKBxBt4HxUhgF7LSapLqpPEzVpQfX5cSqakKzR60C/sFmdDOSuGaKAtgbpQTHWi/N5oxGr9d8CQQKPUD657gNZaqfKGINIRo7VMkqYXGqClaaGUsNRwjZKX6/ZH8zUXP5wBZFeZKrrdTz/RiyBubg/JpVPu1I/p5bJNKZbjGaw2m9Q8J4/+mVN52KP85J4Zcucadd4Y0c78feCcbncrLFVsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjiE/LY9dxVMX2CSTXt2NA2qJv+0AbNYIRtw8I/YyVc=;
 b=NQVfotmv6CTtm7fblY/6LzHkAzDMFzxqmqpULe1Ri1VER166bO2/81hyoP4oOe+QHbHdPEfPgRCyuLaROH6ldUCgmi/GdHlKfNhGbek0S9X1U9LI+y5SI+s9N/Rif2S3V1Qrnmaxt55tGTJQrDdjgUfnsxP3MCzdTyiRFvpEXtIKegN2HxtCj25vWO/TnPn0057DXG8Me/LHZoXSU0vBcS9Od6nj/l270/4DFjisyqBtbH0dItYBpD4EYUSSINvy8V82c+QZ+dTSwWRvEAraEsU/mfQZBl3g74EWuOt3J8dwRKch5jHhWrVso7SxaHj7Erf4ECanmGq1ueeJPGnm/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SJ2PR12MB8979.namprd12.prod.outlook.com (2603:10b6:a03:548::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Tue, 24 Dec
 2024 08:37:40 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 08:37:39 +0000
Date: Tue, 24 Dec 2024 09:37:35 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] sched_ext: idle: introduce SCX_PICK_IDLE_NODE
Message-ID: <Z2pyzzmrbcVJ14TI@gpd3>
References: <20241220154107.287478-1-arighi@nvidia.com>
 <20241220154107.287478-9-arighi@nvidia.com>
 <Z2ohDX-F6bvBO3bx@yury-ThinkPad>
 <Z2owJmy22Tk-bl4A@yury-ThinkPad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2owJmy22Tk-bl4A@yury-ThinkPad>
X-ClientProxiedBy: FR4P281CA0450.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::11) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SJ2PR12MB8979:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d4dfb42-b7dc-4f47-eea4-08dd23f639d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0F0RjQ4R2VKR0cxd1ZxbmNrWnR2UTc1VlNOZ3dXS2JRKy93U3NsYkNzYUIx?=
 =?utf-8?B?ZHRJMy9hbWt3TEVKRStzSzd4NzZrdnV5OUdjKzFnbUNPeE9NM0J2emwxc0xN?=
 =?utf-8?B?NUVnMWZWd255dUw4NUpybUZIaUdoNkNhL1VHMXRRM0t5Z1VVNWJXd0VSdVJD?=
 =?utf-8?B?NVNyeFNuR25XSW1OYUpUQUR2RzZ3aWtEMXpjOXRxZlR1YzFmTXJQdVZuc2ZU?=
 =?utf-8?B?bnRQT295SEtsVWFROEhUaUt5ZnRRRE4vNXpueUVHRm9sV2dqaTZWMmNPam0v?=
 =?utf-8?B?c1N6V3FudlBUNS9xWlQ2NkNqbjArWkRIcG90WWpJOW8yUzh0Tjlta3FYbTZH?=
 =?utf-8?B?cjUrZ0ozR1FGTGR2THBrNzE3QXlvTjY3bEZlVGRXbXczQjZZQU1mS2oyV0Ix?=
 =?utf-8?B?SUpSNytLZUxXakU4UVNzeHlyR3U5YkJ4WE5ZYWVNRXJEVnpxRGhVdlJUemtH?=
 =?utf-8?B?clhxdnlBTjFkVElTVEFqdDQzZ29YSmFnd0VnaXk0MSttTmJQR2FPSTBuaGVN?=
 =?utf-8?B?ZmJhakEyU0NPSXZMMFh4b0pCN1pldlR4NjRDUkpmVXdDQXl5a0tIUmNqbzJY?=
 =?utf-8?B?WDFCOXRESWx6bUNqNm4vN2NRY0ZkZjQ3NzY0S1YvM3J6TGV4ZklTY3ZFdVV6?=
 =?utf-8?B?a0RQS3FXUGJDeEl2SWtOb3ptWnQ5UmRrb3pMMzRwVytiQ3VWNGYrU0d0V1Vq?=
 =?utf-8?B?dnJHdy83Y3JlV2QreDhCZ2tnbklWRkZmdDJPRVU2UmJpZ2NQQWZXeTRRYTJR?=
 =?utf-8?B?QlZ4MmpwUFNrOEUvZ2x6WCtUMnh1aENIODhhdWpXUWl6T1ZDWW9MclVUaFlr?=
 =?utf-8?B?TVNMZkF4QmNyMWRRNHNxcko2a1VucXBkK1ZIRndhbzJKcHVRNFVEWEF5dVNQ?=
 =?utf-8?B?dS8yTXVGNzFTQkpPVEpsYnRiSTFQTGFiSnZhemJHM2c2RG04WG11dkFTQUJ3?=
 =?utf-8?B?OFpkOXhlV1lUN0ZtNjhsenlzYnFQT0I0bjg1cmN0bGhkNkhWQmZab1NZQmE0?=
 =?utf-8?B?cDAranRaT3QreE03WEdhdk9IT0I4bUp2ZHRMMmE5dDBQakwvM3hSMDhjNUJl?=
 =?utf-8?B?aVhsSDZWaDNXS3dLSFpnZTFrTWRWVlVNeUNpcHRTakJBYVZQOUlpTFdjaDJN?=
 =?utf-8?B?K0dTczFwZlJ2Y0NFOTNxZEZDVVBwK2VZaS9zb1pqRlNKTXNqaW9CNzE4VEJ0?=
 =?utf-8?B?dTlndGFmOGd5dFNPR243OXZqV20vK05jdWtIMHQxOU1mN0NHeFhUWmNnTkNX?=
 =?utf-8?B?aUpIeTdZcGZPQkVkblZuakIvd1NNVWMwQ0VST0hXYjNQUm5yMmFSMUZKV3Bu?=
 =?utf-8?B?clR1VnZzOW9MalVCYWdDdzM3QWpXNTZmYUR2VzVSSWwzTGN1SEZMM21LOHBL?=
 =?utf-8?B?RUMyTm5waU1yWU5EOHR6N0tTOHljS2RKSE5aaFhuaUVoZ3hrUVd3YlVwTUlF?=
 =?utf-8?B?b1dtUWdIL0hKUFVvR2t1L3Y4VkV6cm5zYzJaV2N1L0lyTGlYcnQ2bTJzUTZQ?=
 =?utf-8?B?cStwUzlJQm1tNlBYRkZlcVUwd1A1TGhqT1JwZHpmV3ovV0FsQTJpd0VSVThJ?=
 =?utf-8?B?THhxVGlHc29VaW01eUVLV3hyaHZwb1ZubTNLYkNOd05HWUxXZGxMN25XRTdM?=
 =?utf-8?B?TWZVMGxRQnJ5U3F3d0kvL0JzNEtpWWNTN3Fyd0k4UDBKYkZVU3hXWWZGNlJ6?=
 =?utf-8?B?ZlFQTDVIWHZSaVFlSHIyMmg2YVRVUzlubURqSGVINVdjWjZCNERJMHppdEJU?=
 =?utf-8?B?UUN2VlFIL1dmdm8yeE9IMzJVL0FmeXBuY1FhMzdvNGFQTmQ3eEo5WEltMndp?=
 =?utf-8?B?eE9zc2JzTHVjM1ltU2sxQzZHZTgxd2s2UDJPNXJtQWdyekpXOXhPNjJ3YkI3?=
 =?utf-8?Q?YjcVU2oRCkzx7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUFHblhTd1piQ05BMWFCOEVWZnU3a2p1TWdSQVdsM0s2aU9aM1FIemM3eGZN?=
 =?utf-8?B?ZC9ZTUJua0p5TFR2eWxnekx2TC9zUVg2YlJIemdDWm51UElQa2lkUDVBMkxN?=
 =?utf-8?B?NlQzandlQ0lsQk9jYWt5YWQ2NlMwSzVVMDdKTVU1VHBSL2Vrckd4Y285K2NC?=
 =?utf-8?B?ODdiK01IOXdDZ25jRkp0MTkvRVlvMDFSMCt1aGx2bVhKajJscGFyM29SWFV3?=
 =?utf-8?B?aWJ0azRkcVBoNmRPaUxmM0pTT0d3UytkTmJDYzFkc3l2bGNLcXV2NzNYTnRz?=
 =?utf-8?B?Y3Q0cHFJeWYxbFdxQ3hyOHdWaVBobHovYkk5TEgyQXBPenRwMkQ0cysrdmpV?=
 =?utf-8?B?NFFPb3VsMy90Wno3T093ZnNrVHdIdmY0QjFOYkZvYjRTTHphK2Z0K3cyaW5Q?=
 =?utf-8?B?Y2tYMHhrUW9WdVdHRk1YRk5RS0pWdUgvem9LZjhUYkFreEljUWUwUjlUQ0RL?=
 =?utf-8?B?MjBURmkrNVlUazUwRXQ3bUlMOUtVUWttSXJteHNibTdCbm9wa256Z1pWcXBF?=
 =?utf-8?B?UVBQd0ZEMUhmektiRHliRklYZnJSYmhrMy8zUzlBSG9OaWZ5a3pURzcxak84?=
 =?utf-8?B?R0Y5UTIwUTVoYVYxbEJJS0YwU3p1OEJFZHVBN1J6RHhVK08xMnpyMHc5U0lw?=
 =?utf-8?B?dTlvd2JkL3dBbjcrYzlvU3Zwcmt3bTJjczYvMUh3MURNUS9udkI5S1dxL0Qx?=
 =?utf-8?B?MEZlbXpqaDllSUdhSTZKZUJUM2c2ZjM2ekNlYXBLMXorZzJqR3EwNHV6eVhi?=
 =?utf-8?B?cElsMFFod0Z1M2RzM0xXZkR3QXUvMEhtL1dPKzJMaDdOWGh2VDhDb3dUZHVW?=
 =?utf-8?B?Z2tpYkh2OExIWGd4ZWZ3TEEwY09aYy9lTTlkSE9nWThnK0F4WEZicEk0NUlk?=
 =?utf-8?B?ZmRIVWo5UmhLR29TM29jYVl2RUdlODFENmZpaVFNMCtETFhLV1BrWDkzQ2Nj?=
 =?utf-8?B?ZkM2SXJlRXQ5YUwzbzFXR0NZcUlwdVQ3OHMycmJqbE52SkFkTnpEMnJrQUVi?=
 =?utf-8?B?S29KbDBkYkNkbVN2WEY4SXNMYnBkVTVkdUhtV0k4bzVaRzRZRTd4MUNwUFpu?=
 =?utf-8?B?TXpMajV1QUI5RCtKK2xuZEJQTVF3MmMzVXBBd2Nyd1F0WnN3VDJ1UlRXRUNZ?=
 =?utf-8?B?WVk4NVBQVEJOSC85bEsva2htVFdscEdRTGVWOEtJVEtzdXoxajhiRnVvOW9r?=
 =?utf-8?B?MDV2NGVtUFBUSk5Dd2VEMHFEZVRoalNtUjM1UFpBMkdGdjJvMFNpWXhoVkFt?=
 =?utf-8?B?MVVySHRzdUg3SFArZkRiWk9oa3MzTmpmTmtHdlNXaUUrV3MwQWVGS1Joa2Zp?=
 =?utf-8?B?YUpzOG9sa3psSDIvUWFuWHg0QnlsZ0dqWkJLZU9mZGVqMnFKOUF4enNqaTJG?=
 =?utf-8?B?blJKWDVKdW9Bd2VITEZGRFBNbTltank4bWZ1UHFvYXo2YnNwRmhGSk9sSytS?=
 =?utf-8?B?aUlmdDBadFFNUFplL1JJOGRPTlRWdFBBMmFLRGFCSFAyT1lnUHpRaUkreXlL?=
 =?utf-8?B?UWlUMjB2K3V0YlZsUmFWc0xLMktTMDN0U293Y1UreS9Za2ZTSis4ZjF3RVVV?=
 =?utf-8?B?eXVMTGRvL0cxOEl2MEJmamlKMDNnZ0cvcnJKV3ZzSUFrTzlucE5tOUJSYUl6?=
 =?utf-8?B?ZUVya0VSalVNOWd5NEdlSUdXYTJRYzVuenVwdGNzdjUzRlhmUksybTdwWjBM?=
 =?utf-8?B?eGNsRk5DZmgyNXZrRUdjNzRoWWYwbHNMaDJmeW9QeGdoeUUvbmo2a0ExUkhM?=
 =?utf-8?B?T2tQNm52ck9QTXV6alFaUHF5Y1ozNVhKUUJjYkx1QUFqbHNtNHhUcXdZYWdM?=
 =?utf-8?B?V1lQVU1CUGVITENFQjlIRUR4YmRsaWVKMEc5ZE9VdWY4dmRZV0pOQzZVVkRR?=
 =?utf-8?B?WXNnaTFHd3BSRXlFUkdNSm9vWCtrVUwzV1MvcnNsMThIREZzd2VQOWs5d1Q4?=
 =?utf-8?B?UXZ1c1JIcld3L2gxc1FxaWx4R1o5RmJaNUJpbHIwbkgycXpnU0hnZVlMRDdr?=
 =?utf-8?B?WStIcTJKNjdZMUlNNGdJcVA3dElvMldjRlV4b1NmRFVrekNmaitUbitUMmVZ?=
 =?utf-8?B?c1pTeTRLc08vQXMva1hYSVFGam5tV05mZkhKU1NFSUE2bHUvdDNzbDFTTGlG?=
 =?utf-8?Q?OTVJkBvDKfanA+i2X8g9TC5cv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4dfb42-b7dc-4f47-eea4-08dd23f639d7
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 08:37:39.6864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIG/zBvxHBfJaGkT91lZuMjOCDG1Gib/zPjK/rS1cmZ6JMqwh+REUzhUWQ4+DaLcomxKMMdzUJLewp0JDtSIbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8979

On Mon, Dec 23, 2024 at 07:53:21PM -0800, Yury Norov wrote:
> On Mon, Dec 23, 2024 at 06:48:48PM -0800, Yury Norov wrote:
> > On Fri, Dec 20, 2024 at 04:11:40PM +0100, Andrea Righi wrote:
> > > Introduce a flag to restrict the selection of an idle CPU to a specific
> > > NUMA node.
> > > 
> > > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > > ---
> > >  kernel/sched/ext.c      |  1 +
> > >  kernel/sched/ext_idle.c | 11 +++++++++--
> > >  2 files changed, 10 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> > > index 143938e935f1..da5c15bd3c56 100644
> > > --- a/kernel/sched/ext.c
> > > +++ b/kernel/sched/ext.c
> > > @@ -773,6 +773,7 @@ enum scx_deq_flags {
> > >  
> > >  enum scx_pick_idle_cpu_flags {
> > >  	SCX_PICK_IDLE_CORE	= 1LLU << 0,	/* pick a CPU whose SMT siblings are also idle */
> > > +	SCX_PICK_IDLE_NODE	= 1LLU << 1,	/* pick a CPU in the same target NUMA node */
> > 
> > SCX_FORCE_NODE or SCX_FIX_NODE?
> > 
> > >  };
> > >  
> > >  enum scx_kick_flags {
> > > diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
> > > index 444f2a15f1d4..013deaa08f12 100644
> > > --- a/kernel/sched/ext_idle.c
> > > +++ b/kernel/sched/ext_idle.c
> > > @@ -199,6 +199,12 @@ static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 f
> 
> This function begins with:
> 
>  static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
>  {
>       nodemask_t hop_nodes = NODE_MASK_NONE;
>       s32 cpu = -EBUSY;
>  
>       if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
>               return pick_idle_cpu_from_node(cpus_allowed, NUMA_FLAT_NODE, flags);
> 
>       ...
>  
> So if I disable scx_builtin_idle_per_node and then call:
> 
>         scx_pick_idle_cpu(some_cpus, numa_node_id(), SCX_PICK_IDLE_NODE)
> 
> I may get a CPU from any non-local node, right? I think we need to honor user's
> request:  
> 
>       if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node))
>               return pick_idle_cpu_from_node(cpus_allowed,
>                      flags & SCX_PICK_IDLE_NODE ? node :  NUMA_FLAT_NODE, flags);
> 
> That way the code will be coherent: if you enable idle cpumasks, you
> will be able to follow all the NUMA hierarchy. If you disable them, at
> least you honor user's request to return a CPU from a given node, if
> he's very explicit about his intention.
> 
> You can be even nicer:
> 
>       if (!static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
>                 node = pick_idle_cpu_from_node(cpus, node, flags);
>                 if (node == MAX_NUM_NODES && flags & SCX_PICK_IDLE_NODE == 0)
>                         node = pick_idle_cpu_from_node(cpus, NUMA_FLAT_NODE, flags);
> 
>                 return node;
>       }
> 

Sorry, I'm not following, if scx_builtin_idle_per_node is disabled, we’re
only tracking idle CPUs in a single NUMA_FLAT_NODE (which is node 0). All
the other cpumasks are just empty, and we would always return -EBUSY if we
honor the user request.

Maybe we should just return an error if scx_builtin_idle_per_node is
disabled and the user is requesting an idle CPU in a specific node?

-Andrea

