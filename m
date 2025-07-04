Return-Path: <bpf+bounces-62441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02348AF9B88
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 22:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164A95A840B
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 20:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880C9231845;
	Fri,  4 Jul 2025 20:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H8sovjks"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB1522836C;
	Fri,  4 Jul 2025 20:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751660092; cv=fail; b=qg077KyndvhAuVca6SCiLFtFLvFx57Vn3IuZ5bga0E0rtM9gvTygpVHCZolqxSlo9NeInEVG9chLwuFLmLgOFOT4WfQulZFLQy/AnBLS1I/G8TSyQGtdJQ+eqjYbxvB+B8Q5bb7Vwb+h13BtlvTez9g5gPko+mucYbIowggwxy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751660092; c=relaxed/simple;
	bh=eOakgkcnn+xG3VYCEY/1pbBUT9FbMEcTZi+nq8zipNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W6OSDPE87Nx5aGiG0tiTLiVjLPGV1yuV67AmdVZnUxaY7scSUzcahFv+IJkIoozSzD7WhYn9T5Eh5mh681S8kNC0eYVJ3eoV7jwlx4oRKWzx5+uWNr53V0T2YA0fbA8GCCLsFXVUOEON+jo/NjhwG9DwOR+Axc9YZA9+himFrP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H8sovjks; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHVk9fjBHte2A+9xk2T62HyRpniEfdf+MGV+jUCoO43saFmw1h+4/4m0eQu/fN+ET72I/CmDglnOgay028naoeNd52oCkamCkM9usPZQW3oN5ZieM3GkIU6suF/spml/i1Ju/hrnfAadze0IT/7Ajq1X8GAkyGt0KP1bfkVdDx5RP7ev3hrkpaHipQ68CIhMy4o4rBDOoK/LpJcKC+WMOSZk7asunr6yYKfx0nKXVvXRGFqRlduLg3VocSsa9vaswD8woUpHliUMTBeIRGwKkbdn4tM2MDtKX4eHgWVXwBXDa9n3BRd78n1BQr3bTt9gKNV2WRk20BocdsHUr4K2rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzFddSS4S7sZw5U/6jQ+GfHdOVLP+tG4Wkuv5aF5fWg=;
 b=a4HWM1ZBhylPRfJhX6gUYkkzQVlkoMUDFhHoAwhpafhAaCHsCsuBMmcsf4RHLEgndhCnnfVvVA5rQdgxZhFleV8zeFj7Fdb5XcP0Z56HIe705F7LxRpqSQ3U5+V+rtWd+1AbSfG2lAIaJwCpHBDRB4uvvuncGiL8dnkXbDzpXSlVhiNuAie+Q5j/1YztKlL4PAu0YINyLRh494p/2eTIMBIEfMZ/ogvVuZyYhcCQN0D/pLZ9nrynWd89FphRXqz+oSwLAhMuAJjNeuEIUL1TmeytXCQeZW4FBRf/Yo+HFb32WchQh6xaFss4v0myZFSVekdpUDc9CiX5LIkJDvpa8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzFddSS4S7sZw5U/6jQ+GfHdOVLP+tG4Wkuv5aF5fWg=;
 b=H8sovjksh7opF4QjWcRN8FlkBe0l227/JNc0g/dKcvmbAhPMuMq8+QkXOoCopnbWnN9RE72gzMPlSJnmQyjOFdK/dhsimPVp7RIOmY1KNWIJsKqE6MJLHcCU7QVx52uKrnKDAljHyIcUGiabDTmSWnNjr8b8Aq/GHUCwY3kWXQ8UpE9ed3A3KGCJHgWUWRTIRAQBDfFejdgj5E103BZ4bvxQj5fIJn7Djl4KdUwQxq+QiUAi7y3V5RLEcgesvUjwf6T1f09SL9kiWSup0UcaheQ5BDfNrKvDkuxMGkyucyGnFKFI2CE+PXKvlhCOfr7x3VA8dCb5inf34LNSgCMZPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by CH2PR12MB4278.namprd12.prod.outlook.com (2603:10b6:610:ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Fri, 4 Jul
 2025 20:14:44 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%5]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 20:14:44 +0000
Date: Fri, 4 Jul 2025 20:14:20 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Chris Arges <carges@cloudflare.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Cc: kernel-team <kernel-team@cloudflare.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, tariqt@nvidia.com, saeedm@nvidia.com, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Rzeznik <arzeznik@cloudflare.com>, Yan Zhai <yan@cloudflare.com>
Subject: Re: [BUG] mlx5_core memory management issue
Message-ID: <md46ky57c74xrw2l2y5biwnw4vzgn6juiovqkx7tzdwks6smab@vpfd5hmclioa>
References: <CAFzkdvi4BTXb5zrjpwae2dF5--d2qwVDCKDCFnGyeV40S_6o3Q@mail.gmail.com>
 <dhqeshvesjhyxeimyh6nttlkrrhoxwpmjpn65tesani3tmne5v@msusvzdhuuin>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dhqeshvesjhyxeimyh6nttlkrrhoxwpmjpn65tesani3tmne5v@msusvzdhuuin>
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|CH2PR12MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: c45cd071-5cac-47ad-eae8-08ddbb376a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVd6OCtYR2ZqQUFyaUN3ZENhZldSSlJ1cWE4andGZ0VZV0FOcEVGbWFsWGEw?=
 =?utf-8?B?b2QzN2M2VWZBdmlUUERFTEhZTHo5ZW14R3htRTF4QmRYb2lkUjdYQnJmRnhD?=
 =?utf-8?B?clJzT20xV1pDMzhUS0pKemlubWNZWVdFWGhuMkNoVEtFbGVvTktILzhvKzJ6?=
 =?utf-8?B?bjdwZW9kVWNJY3J1Q3RObE5BeGh2U3dnVXR0Yi9VWDdnWTY0b1BibzBaR0gr?=
 =?utf-8?B?Y1YxQitHM1ppcWtyeTFQNkc3eTZxbGZhMFFiOXFSQXpXVHdoYkxyOTZhSUNY?=
 =?utf-8?B?enE1RTBXWG8zeGFMNEpsY3VTaHhwQ1F5ZmVMUUNjZUM2cHg5ekE4MWU1eHdF?=
 =?utf-8?B?dFpOMkp3Vm4vOHdPbnN3VlhCUUgvVkI4cUxZSFFQaHN2ZXdXdEs0THVyWEdr?=
 =?utf-8?B?dUpPS05IWW1sV2FtWktpRWp4MHoxR1dxS0tidEdDR293azhkTXQrN2NSTVRw?=
 =?utf-8?B?TXI3ejUxZ1JYTjBoOUVldDZmcXBYSTRyUTFRTHFlWklXamNXeEVXVjhlUWRF?=
 =?utf-8?B?N1hzM0R3akRPck9sb2ZDaDJiRExiZHV3V1FteUFhN1BZdHVicVBHcDdVRW9y?=
 =?utf-8?B?N1FhcGtOOEErU1ZxZjY4VlJKdlZ3WnRicjdWRFZiNWVucTZ5TEl4OTBud0wz?=
 =?utf-8?B?cHk5YmFuNmhsVTIvYm42R1RTMEM4RlR4TVN0MU91Um9LT09MOXVQNWw2R2VX?=
 =?utf-8?B?aWhPWkpCb0FxVlZwdlM1bjNJOEwwTlJYdnBhTTlrR2ZNSkxlR3lpUU8xTklF?=
 =?utf-8?B?L0tobmFod29MZFN6aWk3N2EzQXVMWCtSY0hsQ3pvdFJ0amZpdG9RMjhoTVpr?=
 =?utf-8?B?eW9aUzUxRkttZTNiMnNKWStDdElSdXBPSm85eEhDWjROTzBVRGZGR2VuaVA3?=
 =?utf-8?B?Y3lNLzgzSThTR2hKRFVBZ0U2dUF2dGk5a1VFZkw2SXczZlhuc3FhTzdiSkVv?=
 =?utf-8?B?V09SR3d1TkNMTkdQVG15eWdNNWU2bFQ5bG9TZTdTek5EODRhcDRqUmJqNXBY?=
 =?utf-8?B?SUR4MjNadjArZnA0Z1lnUlAzd1lZcmpFRFQ3UGpCU1FvVzJweFRCMnZreU9u?=
 =?utf-8?B?MC9DclYvMmVscmFvWWRoY01laEZIbVh1U3VPMy8wK0pHdVVkekRqNFhaME1v?=
 =?utf-8?B?SnR5S0dFSjVkMTU1ZWpmRk85SFJQeWE3M2VoV2dtaEZ6eEpYZFY3VU56UUZq?=
 =?utf-8?B?UUc5UzNocndMWUVNcUdMd0lRbUcyblY4eUNUazdSWDEwWFg3Q3VHZTdhVHNh?=
 =?utf-8?B?bkRoVTdxbk8rd3pDbFJ1L1V1OElXcWdVOVRic2dtZXJRUUlvVVV4R2RJTDhB?=
 =?utf-8?B?OCtUd3JUWWRKQ3laWWlUMkM3Wll2dEFzUnVBZjNhMUY3dDdyVUh6WlFNZVR0?=
 =?utf-8?B?bENZUTc3VUJLaHE4SzQra2U3aGZVdVFRMXo1SVo3VGYzNGN5NFNTRTBDRkJh?=
 =?utf-8?B?LzI3VE4vbm9oQ1hoeGY2Tkd6SElldzI2TzlpMzg5ZHN1NE1JaFpkM01YYncz?=
 =?utf-8?B?UXA0VzJPWVNIcXVDc1B2Uk14Unp1eXhFaWl5NEFIMlI4WXQ0V2tjWkI0U2p5?=
 =?utf-8?B?UmJ6azBCZjREUW5hbjhSMlN5cUk4aHNCTlNHM21yaHl3eTlFVVRTL216Z0VC?=
 =?utf-8?B?d1lBYUJWUWhHdU0yV2xrSjdaZ2plRTlaN1FnSEdzWHIvNjFaMnJyVWxCd015?=
 =?utf-8?B?MEFRT3NuZDZkUURzT0QyelRMNGFzTnd3dnZuYTE0V0tnSDBvaVdic2Jxa1Rt?=
 =?utf-8?B?elpYV0E2aHhiQWhSSHFGUDI1c0sreG4vOGVlRHBuNmMweHhuZ2xoR0pEdkZ1?=
 =?utf-8?B?UEdIUlhTbjdGRmFXQ1dZQ0pUQnh2RjdwQ2luZko2by9LTGk3andBUEd4aUdC?=
 =?utf-8?B?alJTMnNONm12TEpHbjFaY1FnbmtnTWk2SHVPOTk2SXcxbkxJWVlwRVQzSWNW?=
 =?utf-8?Q?J2XLVirjes8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWdoNWJZR2QzYXZCRmNXMnJYZE96aDcrbTlUd0JiTWpoNDNaKzZmNmJkanFh?=
 =?utf-8?B?MWIzUVBvc011KzR2cmYvQTdBZjhxaEJidGwwQXViM1QyekIvanZIU0VxbmNp?=
 =?utf-8?B?ZXdBanJSbjM0YXBRWEVhc0gralZ4cVNMTmNmRlRNYkd0Si9LUm12bzNQaUh5?=
 =?utf-8?B?WDREUjVYTUxtWWN1eUVCbzBnQ3hXWDhBcUZYOVM4RWNlRk9BQVozRGpZaldZ?=
 =?utf-8?B?akEzRmhVRU1lQ1FRcUFUSE5hWUllR096eFR2WTNTR0hUa1FuNTJKSmdjODlT?=
 =?utf-8?B?ZUxvN1BFLzY4TTZXckUyVzdlcjc2Z3prakJIdGdkdDJKa0k2YXlEV1drNnBY?=
 =?utf-8?B?S0F3UjIxalZiT2JrMjdxTlRUOXRpSEZqV1Z0WS9jWmpIK1NiRElwZ3RiakpJ?=
 =?utf-8?B?K1I3MUFNOTY5TjljZGNkRnJzQ0hsWFdWQ1QzR2VlQlNETTAzNHpXa3I0WHdM?=
 =?utf-8?B?YlpJTFpMT2tGeVREWlMxWllSWTk4WWR2VWY3dG42T0djQmh4dVhEc05xUWlQ?=
 =?utf-8?B?S1FoZk80RXpVTDhMVVNWS0lDVDJHMkJwK2JXaFhzMTNTM09oWXloNHVqM1p4?=
 =?utf-8?B?ZXdiK25Ea0d2WDJtNXdxeWN6dXhqTHRBNFU3TEZEb28rQ0lNSnlyVTNaM0lO?=
 =?utf-8?B?dTl6T0ErWkIrckVOWnFCUUkxMzJ1U3NqS0liUjV2Q2J6MElINlJrUlliSE42?=
 =?utf-8?B?RHcvQ3BWSXlJVm8rMjVCejI4R3h2eVV6NnEveDk4ZnYvdFpnSWdoR1NtNVgy?=
 =?utf-8?B?RlBvd3lIQnozZ2Fya1JreXQ3Yk5QVlE5MVE3T1lzQWxiamtvQ0tXNEhsazVs?=
 =?utf-8?B?aFZ3UnZEeUU3eDI2TnZJUG5DNWVkVVBYUVc2VElGMkFJVndHL1oxZW5UczlM?=
 =?utf-8?B?eTA2cyt1MURVY3QyL282NkNQM1NtWG1NVkhjVDNwZzdnNllJbkltbGo5QkUv?=
 =?utf-8?B?ZlVZTGl0dVI5UXhFRDFkSklPajF1RE9JOHVWZ1JyQm84ZFhTU3hta282djM0?=
 =?utf-8?B?Zy9CMU5kbGRWYVZaVDJBZ002VVhSVnE5anhiazg0eVp5RXZGUC9YMXJ2MUVQ?=
 =?utf-8?B?bkh6WWpPcWxPbkxVbklLUDF1STN0TGFGRGROcUZqbFQycnRrd3ZYbVJYRlUy?=
 =?utf-8?B?KysxR3l4SFBqd29qRkRhOW95d293SlNzYU9Dek5ZL0dialpSQ05vMi81SFBP?=
 =?utf-8?B?ZVdPNVZFbXFxZ1JjZnVjU1FuTGI4UnZRb0UvdFJsOGltakVoOXBLWDB1c2JK?=
 =?utf-8?B?RU9nSHE1ZlNIaGlQQlJTZWdTeXRjSU9Zd2pwcWlFSE5lLzJjZ0ZTSitCMlJ4?=
 =?utf-8?B?NHlpS3pLTm5PNWhsT0xrOFBnbEZtWVdualZSbUgxeDZockhNbFhhNWwzdUxW?=
 =?utf-8?B?Y2dEZlBSUmMrbFJUVVFmYTZQeDRyN05nNEp0clYxVE1lSlVGbnRnYnpzVkhB?=
 =?utf-8?B?V09pTkltUVNJdWRJQmdRQW9TSEdYVFhTMGVVVXQ3dG5yczY2ZXpwbGtTM0VK?=
 =?utf-8?B?R25tVjJzb20wVWFqZGpMTitneE1JT0E1ODQ0VGxWYmh2c2FMMHNvV1JRZnlG?=
 =?utf-8?B?aDJmaWVMMU1NbDU4anVWT2w1dnMxd3BXSzl2VC9uSHYvbHZuR2tYU1pnQVBS?=
 =?utf-8?B?TUhBMEdMMjdDR1ovdFF2U1VHb0xCMnl4L25jQjNCTmFFT0FPZS9tdUNVbWhD?=
 =?utf-8?B?cWJOanh2UTdDT0ZaTE5JaWErdGtRN1EvZWdWUVJvazMyRVZIZXNCSUVGZlk2?=
 =?utf-8?B?TW1tdVNyQTJZS09tNitNak1CNVVxQk9vaXlDLzVqTGdVeXJnOWxFOG1vVHpK?=
 =?utf-8?B?ZGxQRC9LZHBFTENvaFc5TkhJWktnekZGTWV3YVJpYWpFaVg3WVpva2RJcVIz?=
 =?utf-8?B?SWNIVkR6K2NqYmVqNTV6SUlZTXVVMFdVblB5bmg1ZUhKSTEyNVQ5Uyt1K1Ey?=
 =?utf-8?B?SDRJQytPS3VwNHBMR0hwSENjbGhUNVNzd3JuUGt4blhUbWhkYkJKNXlxM1dP?=
 =?utf-8?B?VVNwTEhFTlR6UG5namJtWFZIUmZEcEVwb1NjWjNOTDNXL1ZGQlVuSVRybjg0?=
 =?utf-8?B?MWRHQ21RYXNQS3Vxdjg3TlNrWFdFRnplcUtVTjhoVnAyMWkvTWdMaXFxZHho?=
 =?utf-8?Q?6cLgx37i4NMtEcgGh529hpEj8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c45cd071-5cac-47ad-eae8-08ddbb376a4f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 20:14:43.9134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9mHI4X/4oZPNaN4CHTnEEFJK29fumVEwLgnYyGccALBMbTtouP1O+kxUKlB00NHp87I5ta73/630oT8vYyjMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4278

On Fri, Jul 04, 2025 at 12:37:36PM +0000, Dragos Tatulea wrote:
> On Thu, Jul 03, 2025 at 10:49:20AM -0500, Chris Arges wrote:
> > When running iperf through a set of XDP programs we were able to crash
> > machines with NICs using the mlx5_core driver. We were able to confirm
> > that other NICs/drivers did not exhibit the same problem, and suspect
> > this could be a memory management issue in the driver code.
> > Specifically we found a WARNING at include/net/page_pool/helpers.h:277
> > mlx5e_page_release_fragmented.isra. We are able to demonstrate this
> > issue in production using hardware, but cannot easily bisect because
> > we don’t have a simple reproducer.
> >
> Thanks for the report! We will investigate.
> 
> > I wanted to share stack traces in
> > order to help us further debug and understand if anyone else has run
> > into this issue. We are currently working on getting more crashdumps
> > and doing further analysis.
> > 
> > 
> > The test setup looks like the following:
> >   ┌─────┐
> >   │mlx5 │
> >   │NIC  │
> >   └──┬──┘
> >      │xdp ebpf program (does encap and XDP_TX)
> >      │
> >      ▼
> >   ┌──────────────────────┐
> >   │xdp.frags             │
> >   │                      │
> >   └──┬───────────────────┘
> >      │tailcall
> >      │BPF_REDIRECT_MAP (using CPUMAP bpf type)
> >      ▼
> >   ┌──────────────────────┐
> >   │xdp.frags/cpumap      │
> >   │                      │
> >   └──┬───────────────────┘
> >      │BPF_REDIRECT to veth (*potential trigger for issue)
> >      │
> >      ▼
> >   ┌──────┐
> >   │veth  │
> >   │      │
> >   └──┬───┘
> >      │
> >      │
> >      ▼
> > 
> > Here an mlx5 NIC has an xdp.frags program attached which tailcalls via
> > BPF_REDIRECT_MAP into an xdp.frags/cpumap. For our reproducer we can
> > choose a random valid CPU to reproduce the issue. Once that packet
> > reaches the xdp.frags/cpumap program we then do another BPF_REDIRECT
> > to a veth device which has an XDP program which redirects to an
> > XSKMAP. It wasn’t until we added the additional BPF_REDIRECT to the
> > veth device that we noticed this issue.
> > 
> Would it be possible to try to use a single program that redirects to
> the XSKMAP and check that the issue reproduces?
>
I forgot to ask: what is the MTU size?
Also, are you setting any other special config on the device?
 
Thanks,
Dragos

