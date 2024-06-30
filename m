Return-Path: <bpf+bounces-33446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 317E691D11C
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 12:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1AF31F2105C
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 10:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1531369AA;
	Sun, 30 Jun 2024 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="McSR38cb"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A0012F5B3;
	Sun, 30 Jun 2024 10:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719743171; cv=fail; b=BhminQAQMrNjFDAXFOPu0GqMhRyzp2IxmSjzVpF6DdBCjNlbWazuh8MvjmyEQwhUQIVZzYkk1aM4DyFNImZtdR3SOP23uls/5gqpV5ZUAsfui8HbbK7Fm61eetJLjGVf/6AOmRYL54OGdxq7wxnKL2D+R+Lyz22BxQRsNek4Mcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719743171; c=relaxed/simple;
	bh=g20AvpI0nPKSvq8gOirOj2kkucTNSZCgL6V8i7loGO4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FAQJCs+n/kaQ3ec8khVcYoPQLr2Kc3Yrg8V1FU6/WSLk2ozs28JDe8geL+WIusxr95KfvpQTC6VEvOYWjswFOLQuiadoxP13nOBdAKFp/7WasTI4AU0MgecN3bgJMmwPEInVbfvo+m8tPxQ0riwGd4vCgoMAkvufs5CXEOObScE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=McSR38cb; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeQVSLtWoptHy/ZdOAHAutNMwaORpl3Q8Fn6NnHdsTVwq+5ugE4k+wo8N9z3lwGpVBigjMdPCyqpIaC/4/hZy7q/gmJaVOYpyrhU6vs6t4079fb1QMTxGOXOH0IbOaK6dJr+YXWS+e9UGXKJlZHTVO2ph2BKGEDTnUa+VN53CQ/9AKRP18+GF2z8HA9+MeKHz+82JVnJx0Gg3XVJYMuzNClpujlKSar6gcMHTEoUoqhyeHLKX7InXkWpbPR0JjdA0eg5/GoYjaikVWkxSr/zvOQ1TT50y/8M3EO5LOrh8q50RpleAN2eTAoV3dISwUsHSr/wEtz20/sF3NNna207vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mq0huRkUlcWuako5CX77CmzFqqenu6wPQ5JW37EEUs8=;
 b=JNv7zrlTtNWoR/VzVraihsUA6tlmf7QHMLz0BYCNAvZcmw/+GVLAq9447wSNwwKTzzjb+QCPe1J3xtlWS39PhNY02a804nNdp7S0WhgYqk+shl/CI4LG+/1wpoBR2Wo82MQ1EpD6KUMJKxEY+znIMglbKWZdg2JVNGuhL2fdbEeDHSE28AeA4X5WoAliCFD0OQ/WvIGA8oLuuHiEPa7afKnOLGae04nfhWmNSxNMcKvybJNgQJyTliQOosQXbB7R/M4EpQr0MR+3N1nlNl6Q1Xyaa46mSdRQU2nHX833Cq7DuVRBzjydblU4+rY1G7oL9uo69prJDBYN1KBHFnQBTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mq0huRkUlcWuako5CX77CmzFqqenu6wPQ5JW37EEUs8=;
 b=McSR38cbGaB+fM3Oil6bcsc3fmYd5/JpZirzzKBO3WchNodFSUEj0V+PZ+p/NziyYeQKmFO9z6USHHC9RZj0YTZMgZfa5FWtZgdQLpRb4008T+qgxWblS3SsDXQzt+MiRH4Ma6fCQnlFhbQ23nZgvdpCcxgBUQ3oRBx2gcVLBkv3k72qJm2/QwryFIcBJLQ0T5r0gzTCOr5xYtmBwQ1aXpqFbUMuF2L1Yml36HAXTMBF7Owm0/v5zxDOoYMbZSq8PkM/IjQ+qT8MZibScHaxQynX2tcDsMuc8M/Mw9PsNY6AcJzBY7MrKa2ooIjw347VUhOJzFe8bmK96zQ0a9wwjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6037.namprd12.prod.outlook.com (2603:10b6:8:b0::11) by
 DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.26; Sun, 30 Jun 2024 10:26:06 +0000
Received: from DM4PR12MB6037.namprd12.prod.outlook.com
 ([fe80::ed3f:e702:63ce:37a0]) by DM4PR12MB6037.namprd12.prod.outlook.com
 ([fe80::ed3f:e702:63ce:37a0%4]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 10:26:06 +0000
Message-ID: <6fb46358-e92c-4264-9863-c011fa970478@nvidia.com>
Date: Sun, 30 Jun 2024 13:25:46 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: XDP Performance Regression in recent kernel versions
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Samuel Dobron <sdobron@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>,
 hawk@kernel.org
Cc: Sebastiano Miano <mianosebastiano@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, saeedm@nvidia.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Dragos Tatulea <dtatulea@nvidia.com>
References: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
 <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org> <87wmmkn3mq.fsf@toke.dk>
 <ff571dcf-0375-6684-b188-5c1278cd50ce@iogearbox.net>
 <CA+h3auMq5vnoyRLvJainG-AFA6f=ivRmu6RjKU4cBv_go975tw@mail.gmail.com>
 <87ed8mftra.fsf@toke.dk>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <87ed8mftra.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0053.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::18) To IA1PR12MB6018.namprd12.prod.outlook.com
 (2603:10b6:208:3d6::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6037:EE_|DM4PR12MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca2dec1-43b9-4c40-6332-08dc98ef0631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVlidVZoSjByVnZuNXRRMTdHaXZMam9WeFBqY082dkNSeFFtZmJCMVRoM0xF?=
 =?utf-8?B?SG9LYWlqdTVuVDVqZTRpZkorWmhFaXBCUzRNMGtMQUxBaHczSERGRGh2Y1JN?=
 =?utf-8?B?L2dXVDZyRU4wdWJtT3NPMkt4WlNEeFQ2UXp1eXFYa0JaM0ZYbEFoS0ZHZHE2?=
 =?utf-8?B?WjhtUTdTbTZPUWpIL2x1RkVZZmxRWWZIWWN1VEhBUERlaUpURzNqeHptNCts?=
 =?utf-8?B?UDVubkpjcEY2ejRoczVVTnB6YmpSalIxdEQ0Q1FaTEtmOE1PUlBGRjFYTExR?=
 =?utf-8?B?Z1Q0Z0g3S2Y5QWE0SkIydWZ4TUtUNE15TjJnMHhKcHRJYXc4N0hubVF3cEV6?=
 =?utf-8?B?bFB6M3B3c0VwQVJlZTRFZ1VncVp2Y2FwcjN2VVcxNndtOHRXMGpqM2Vma0Fu?=
 =?utf-8?B?TjVvQmRLT3NoMTV4VG54M1IvdENqVXQ4Snk1REdWbEFRcEdIK1ZHZGtIMGJa?=
 =?utf-8?B?bmZQR1BtZHFXN2UvTFNGM3FSQnJ5Z0h3OW9Wd2VvUnFvcHFCU3VOK095eEVK?=
 =?utf-8?B?cWFQeTFUVTlvTlRSN2hCYnlKQkRheFE5cmJ5YTJZS29MeFZqU1BZZGVYYjFL?=
 =?utf-8?B?L1dHblZnbjJFVmk4K0dwUTMvK25HSHk3dGFuR2xzSVlOejE1Qlpoenh4KzlJ?=
 =?utf-8?B?ZS93Qk9ZMTI5ejRsbXJ4cjFTUkdXYnBQVDdDbnkzNGQxa2dZZXd6M2tjNm5x?=
 =?utf-8?B?bDNZM2VGQnAwODNnYUNKaEgxa01yczc2VEpSOEk4Vyt6MEtoMy9KL3FONTJz?=
 =?utf-8?B?SkNxeEg5dXBvRklYdndhT3hUT0VBUDdVZjQrR3l6MXlkOFJWcUNzZTBWYmZ6?=
 =?utf-8?B?R205c0JRSmZiN3FEdkIvc3JyK0ZjLzc5cU5neDFCSi9idXNPZVVZRmNWTm5L?=
 =?utf-8?B?MGNqUEpRMEFEVHBHZVZ3T0cvUWdpU1NGUkhlcnlrZHJhVVdPYlh0a0piZHQr?=
 =?utf-8?B?dlZwQ1NISHV0MWlSa2NsOWJBN3dwOUt0czBPREkxbXdYbEs5WGcxQzVrcHVK?=
 =?utf-8?B?MkVzamZ1WU9KakxVVVMzbUhKY2xOeWRKZW8yQ3JDbEgrSk5BNkNudWQ1UE5s?=
 =?utf-8?B?dmRJQWtGU0ZYejZmU3lLbmNoOE15NnFpT0lHODVKY0pxb1VGOFEzSUZxZ0dW?=
 =?utf-8?B?Z0IwRittZ250ZXozMzArYnJ4NHJSUXBCSGhLWHlCaWZXdlcybDZLdTJlMnhh?=
 =?utf-8?B?WVlYK0FLSXlUK0wzTVV4VmxBZkNYZmZnZHAxRXZPNTJLWjM5SmlQVzlML1pT?=
 =?utf-8?B?ZFRvd0NleFhNSWR2YkdhQTRmMFV1WkJEM0N2OVUxMDd6TkdERlo0QWRWaVJ3?=
 =?utf-8?B?amFTYkVGZjJ4Yk50d1FUd3NPWGIwUEtzaVNvR09WcCtDRUlzZDMva3d6bEUx?=
 =?utf-8?B?Ui9odjBsNWl2eFNLelVjTDJNT200NVVDc2xyRHVzVkduSkRvL0YzbEc1c003?=
 =?utf-8?B?bVNXYWZTZXBqczBYWU1veDBxdnJOMUFjVFJudGc2VXZKazJoejc4QjI1aWhO?=
 =?utf-8?B?QzJKUlBCT21Lb3FPMFNiNmhLSEdIKzZjTUtVVE11WWtkakhQMzUxRHFYM285?=
 =?utf-8?B?dXZHMU9QSE91SmNtUHF4dS83N3VFcklmazRmTjdXRUNnNnhtMitqbEN1VVpl?=
 =?utf-8?B?OTVLNTMvWXBPMjBWc3d1WE5ZVnlhVFVGblRLQWgzTyt6c25TbWVYR2x2SlVF?=
 =?utf-8?B?WFNxTWFPYXN5R3NNMVV4bU0vMGYyd1VOVzJSZnBiMkhwMERqemgweDVZTXIz?=
 =?utf-8?B?eUxVYWs2K0hjbmlXb0tWM2Q5RzJ2ZTRUc1NxZDR1K0xhcTZrVTRuT0FhQzNo?=
 =?utf-8?B?SlNSTlkzY3RPYkZiK1UzQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6037.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTF6ZkhHdXZ6SFZZM0dGWnJGR1VsZHI0RDZKcnlOSWd1RlFEWm5lR2FXTUI4?=
 =?utf-8?B?UUpFSUh2TXZYb0YrWjZtTmtUblpoOXlrQ3pIMm9EbzF1YVpNU3pnZmFjem5h?=
 =?utf-8?B?N3YvK2QvRmczM3lNMTlYQjBzbU5sN080L21VZUk5SnMrakpaSThKY1R3TmpG?=
 =?utf-8?B?cXByVDZsOFNZQkxoUGNoZ2JVNklDamZLU0x6a25EeEJZYXZaSHlGWVEzTW55?=
 =?utf-8?B?RVFIcUZ5bDdEZVB4U3h6T0hqaG5aU3hUR2ZsZDB2cmd0TW1iS3RMMG1HZk02?=
 =?utf-8?B?MXlzZGFodDZ6eXhwSUtNbUsxa1JNODNTQVZ6em55Y2ZOK2lqM2hZWlMxR2I0?=
 =?utf-8?B?aXM1ZzlrdGo3dllMLzVrQUNvSmVSTVU3bFJFRmpqMmxZdzdpRXZ1VTVzYkpK?=
 =?utf-8?B?UjIwazNyaWViRnR2alUrTlI0WnlJVXB0RjdvY0M2L292YXk0bU9nNmU2RFVy?=
 =?utf-8?B?bkV5eGd3cE83amUvZnM1eWNoWDREVm8zTFY3RGZ5alBLUU5aYllBVGo0RFo5?=
 =?utf-8?B?NVBpaGU3cFJabENsYlhhbTB2WlErZ3d5SmpZQ3YrcVltQy90REZuakQ0MFNU?=
 =?utf-8?B?NFBMZnUrdnphS0tqdk5TM3BQREhSZUdlRUd1bnc2RnliS2RkcGZSNGpJeFRU?=
 =?utf-8?B?UDFQTUN0cVJPVnNvL095YVdGMk1DYStldVlGcWZMUTFKNFJJRkF1b3Q3ZklT?=
 =?utf-8?B?aytmcjRGWGVMU3NGVWJ0M2ZueXFmZnZHem1RY2VvcHRaRnRIcktYeVlMK3Z2?=
 =?utf-8?B?QjdJNWR1UzhveHh0MnQzVlN4dXExbGFXTWJiRGtqSS9nbHRhMUtocWlrdGVZ?=
 =?utf-8?B?ZTNyTnBObE9PNURnNWYyQ0VpbWlGUnhFSEZ1cEo2YzJuN09xYjdNUlZwL3R1?=
 =?utf-8?B?T053R2ZVa0NROGhQbm03MzRybEVKdldHaFVEVUdWUkVTUXZ0WjI2SDRGOTEy?=
 =?utf-8?B?Q1JWM2lVZUl1cGdRaUhadm9wdFpPZTZ2VUFLMU13Zkc5RDF2bHFjeWVUeW5x?=
 =?utf-8?B?RExyWFpJS3FqMkdsdmM2S3lUUVcrV243TUkvbW1aQXdmaHBaQ2pJZ0FVb2hw?=
 =?utf-8?B?U1FGd0Y3cEh2dDFKdzZ2L2l6ejhFYkJGQmkrZklldGk5SjYwQTZnckx6ZXlr?=
 =?utf-8?B?T1hoWlMyR2EwQjdqeVF4dGZ5SENFUDBoZjBndGdYd1V6cUsrRlpaTDJTVnBH?=
 =?utf-8?B?c0l6OFU1WlNsTlZyMDFxNXRIK25JQXpON3QwdDNyZGtvMTV2RlpIWEVrOXo1?=
 =?utf-8?B?YmlzN3pqcVQxNWtac3I4alIvWEdpRnhCSzNBVzN2VUNBMUE3d0dneVp5UGFF?=
 =?utf-8?B?aHZFUkE3Q3lyV2lvd2xJRUpkZkNHbXI3clUxQ2xyOVhmYjYrbTV0ZkFsZnM0?=
 =?utf-8?B?Y2RDMWlyRThQbTVtaVg0WTdLd3lndHdSWjZKOTcvU0pHUFdodU9EbXJtV3Jt?=
 =?utf-8?B?SVc4VURkTWF5aW5iNW1UWTFna3FnWEdlS3Vzckl4MlpySTg0S1Rha01PZnJO?=
 =?utf-8?B?UWRwVTB4TERHNlFTNFFoR0pSNHdXNjZ4MXBWMUxhdDJlcWFMT3dvSzlEdzhr?=
 =?utf-8?B?K0oydGVjbG1RTzBHWGlMNXluQ2xyR1FkUVIzby9BakxaQUZYZDR4Q0E0UXFa?=
 =?utf-8?B?dWloTWtpajZ6bjlva3BwY2Ivd1dwcnlNdFd5K1hMVXpobjhDVXFQNUhpRGtk?=
 =?utf-8?B?TUFnaUFzK1BiWTQwZmdHMWthaVRLdXMrZ28xOE5xWTBwVHljL0diYS94clow?=
 =?utf-8?B?VDRXM3ZkN0RIRHczNHFNY1FONHRqaG5EWGw5ckdwRFNDa25vZ2NsYjB2QlU1?=
 =?utf-8?B?T09la0NWdHR3ZmZoajZ6c2h1RHhqTU5Xa2JRVmZKVUNka3g3anJxWjZqZlho?=
 =?utf-8?B?czRDUzVIYnFXZko5SlVUWjlZaTBpaWpQZCtwZmtiTTBjQWRlUCsxM3ZDaHRU?=
 =?utf-8?B?N2x2RHVwNGJZWlJ5L0lUQ2g4TDF1NktWUUcxQXd5b3dReGpjN3pnQnZnM0Nr?=
 =?utf-8?B?Q2hHSzJIZnM2UEpMVVVQQ0xYbXNCcy9CVk84bkVYWXRLcXBRSllHcUowVnFy?=
 =?utf-8?B?ekxpUWYraXhrTW44bmI3TDhnTUgyYW1uRUtxYmNSQmN5STQ4MVAzdHhlcmo0?=
 =?utf-8?Q?KNEc2nu7bFDxdvLsYsXMZQfvU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca2dec1-43b9-4c40-6332-08dc98ef0631
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 10:26:06.0637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oiGN/Ae5Qdj6elkGQdR5mJdBCMbsrv0iBEHKKeBaO6CQ7rr6xxhqpOnVVEOoRt/vLcHLvx7Ry5+GjbtVV2JxfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867



On 24/06/2024 14:46, Toke Høiland-Jørgensen wrote:
> Samuel Dobron <sdobron@redhat.com> writes:
> 
>>> It looks like this is known since March, was this ever reported to Nvidia back
>>> then? :/
>>
>> Not sure if that's a question for me, I was told, filling an issue in
>> Bugzilla/Jira is where
>> our competences end. Who is supposed to report it to them?
> 
> I don't think we have a formal reporting procedure, but I was planning
> to send this to the list, referencing the Bugzilla entry. Seems I
> dropped the ball on that; sorry! :(
> 
> Can we set up a better reporting procedure for this going forward? A
> mailing list, or just a name we can put in reports? Or something else?
> Tariq, any preferences?
> 
> -Toke
> 

Hi,
Please add Dragos and me on XDP mailing list reports.

Regards,
Tariq

