Return-Path: <bpf+bounces-35216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B45D938C08
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 11:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575AB1C21299
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 09:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A295C16A395;
	Mon, 22 Jul 2024 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y2ymlM6m"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C15149DF4;
	Mon, 22 Jul 2024 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721640401; cv=fail; b=G/OqcklkA1ERSf1kc0yZ6TZSiynh4Hy9GDrJFmg4NdF1fbU78Fc4N2iOgAWHMawXEP6lTBUT66pPpOKV5ab0q4VJ7upUwaGG0HaNHrSRERP8My0M9Rio5WuHB+QLRcX7oUd6pFj95jxEtUTxCne5qnf19bjcA9p/XiMh7Gy0L2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721640401; c=relaxed/simple;
	bh=F4FWDc+Sfh3xwNQDUnlvTuhpEEbK1KvmUorH3Slq/rU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C2qvIRhDEfZdChUogAlvFJVDEe9wjzhZE055PW2s26EZZ/4Ki/t1h6xWHjqnn3YBfheMR/RC4N49DPL96TlBptSlWYh190EvAJfJSePGTIdfJ66OtPNFlZPN4e4bEKQNHRXGcfS3LNP/j+Z9XaIGFP9uBTTTjiwOjG9rvKF6YEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y2ymlM6m; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLaf4iiHLaLd0IHncap6KeQ8DdnXRDuQSlXhMuqY48MOyghPJMGuIQqZHW0H/xHHdMy+rKUnrrSmAT96qmK4faYxFDY+E+rkIWn+CcFGb0GNGhkCJw3NxMdFeB9Xl395FmtRO3BHxcYtYyHz+2NlzT4Dy+05qSFCJ6gS1r/Tl3HkSE8g/i7+xxuQ6dWUMCm9lTy2O6VSP9gRWGMrI8fPhnkuB1Vs0YV6VDFbZmq3cEES6sL4VI4KL8Fes5np00YDtp1PJdjIV8RlrHmOm176yyUIzmxex68O3irQeiOVfqYzmEea9alaeiOIWVyHFXbzp7Oig5Asbt8GRQdzEiv72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4FWDc+Sfh3xwNQDUnlvTuhpEEbK1KvmUorH3Slq/rU=;
 b=pwxVO64l59HzAM/rj/eKH+hkMb7oItl+BoQw44Uiez3FqvCTnFQ7s5/n2CUjwPeAFDf1MXWiOjQPJmMZ1oYAwU4U749R/mMXE4ZyZIsktC9bn39beAzuER2x1/pSaBitCujoaGVIVfacnaFVlu/YPrM2Mq1Fc6vZYLIJqHa0r8+CuMeSWQoVOg9sqaCZpPKGIHpn/GTvBuENScTmM7R4d0WvowxD13KBgcCFyPbJpRqY5IpascwpRj9Hv/bKgcw+752diu3fgWv6qJWE7qyWR5CeG8qxDPGrgzbhJNiNZ5M59BsNeUhEj1q+caqHSlcl/hOYmJyG9DSu2VcFNu5bVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4FWDc+Sfh3xwNQDUnlvTuhpEEbK1KvmUorH3Slq/rU=;
 b=Y2ymlM6mI+TOabjjOMKwLc7oUWyMQ8biYQbrnqAgQGS8w6Z1DTNtZGce9KjRuUlCRM0MRJ2G8Dy5a41DXFIU1u+qNVIkgRzPjCWkfH9ni4zFJgyeiIPiRZzs6Yop2nlkObwJrXrR/tb7ts/2h4ZVUVBuOX4KVclMfcPbHOyrV/r4eQ9n9wALzy9Thd0xSrAwItyTJJ7bJJNkzH6s5iCgA/X0yEZ1pFB7TydUzJU8vu04tXZi3NLK2raOKb3yHFWITtbD8WK2Xz2R6IHjMLXuBM7yLyWPSElYGFKC/hsuzbReNsfU9YfDI4+prjetVsKm0ZoWPhiBc9NOnfzLZiIVrg==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 22 Jul
 2024 09:26:36 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1%3]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 09:26:36 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, Carolina Jubran <cjubran@nvidia.com>,
	"sdobron@redhat.com" <sdobron@redhat.com>, "hawk@kernel.org"
	<hawk@kernel.org>
CC: "toke@redhat.com" <toke@redhat.com>, "mianosebastiano@gmail.com"
	<mianosebastiano@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>
Subject: Re: XDP Performance Regression in recent kernel versions
Thread-Topic: XDP Performance Regression in recent kernel versions
Thread-Index:
 AQHawZQu7pYCTnvmyUq17tC6Eto8LrHPR9wAgAAvuoCAAPRZAIABv8wAgA4WlgCAIm0DAA==
Date: Mon, 22 Jul 2024 09:26:35 +0000
Message-ID: <2f8dfd0a25279f18f8f86867233f6d3ba0921f47.camel@nvidia.com>
References:
 <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
	 <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org> <87wmmkn3mq.fsf@toke.dk>
	 <ff571dcf-0375-6684-b188-5c1278cd50ce@iogearbox.net>
	 <CA+h3auMq5vnoyRLvJainG-AFA6f=ivRmu6RjKU4cBv_go975tw@mail.gmail.com>
	 <c97e0085-be67-415c-ae06-7ef38992fab1@nvidia.com>
In-Reply-To: <c97e0085-be67-415c-ae06-7ef38992fab1@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (3.52.3-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|MW4PR12MB5626:EE_
x-ms-office365-filtering-correlation-id: 12c9d1cb-9e1f-437d-c4ef-08dcaa306206
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YjJPQU1yY01MMllpTVVuSEh4elh3ME1MK0ZJZXBiU2F1eFBZSmlNdUprZHgy?=
 =?utf-8?B?QjJjRy9uTHE5aXlTNURBVXpabTFNUkpTYUQ3T1ZxcUNiYjFRVHFkN2NGZnNM?=
 =?utf-8?B?dm1SMDlMOEhyNGhRVGV2OFM3VngwQ2hDY25EbG5LenZQRzJlYTVna3BHdUY1?=
 =?utf-8?B?NDhGVzRFbTRiSm84SzNHZWhPVE9LSzlGbnpFZ21qWmZWNXFpTWQ1SzhPeWVI?=
 =?utf-8?B?MWlSVmJabVU4TTVpd0luYUZlQUNwTmhMbzU1NThscjZpRk1heU92SkZKT0pi?=
 =?utf-8?B?dTgrMmtzQisyZDRITmpLUmRqUFhhejhaMDN3THYvQTBGb20yRFRWQ3R3QXZH?=
 =?utf-8?B?SEM1TjR1S2tFamVaOG9PWDdGQmZyVG9yNzRaRDA0Sk5aajZ3Vm1WeGJrTHg3?=
 =?utf-8?B?aFRtZk04YitvR0tVeFVpSitvVklGU3VoOXluWkNVV2IvaGNCT3FMRlB0VHFD?=
 =?utf-8?B?QklBYm9jNUJOd05UbUlCbTFlK2RVVWR0U3loSjBOanhhVDY1bWVERi9GMVJt?=
 =?utf-8?B?ZmNKWHI0MFQ2K1dkTzFGWUdsZkNCSVdwbUo1bFErRElDNE1jVXhzLzYrYmt2?=
 =?utf-8?B?V0hOWkJsa3dqNitlVXAraExjNlZzUWlCTFg3TnFIbUJqOHVoWDhwK3JLSkZw?=
 =?utf-8?B?TytvRnRkNVNJMDBtdllwbXVPT3lCU0FWNG5XK0RpQ2ZKVFhEUmY1eEdCYTA4?=
 =?utf-8?B?dk1BK0JUbUo1UUh3NUE4RWptVHJQWFd1TE1hdmh2NTZsdnVlY0EyOEpDVDdP?=
 =?utf-8?B?bCt2OXpiYU1LQVpJcEtXTWlSb1c5a2JRanhscmdLOWJ2ZFhLVVpSM0NVbGw3?=
 =?utf-8?B?TzFhdWdpNmkxeFFKN1dlZXlpYVdrWHlpRzI3Z0ZLam5JVVNFWVMxK1B1WXA2?=
 =?utf-8?B?Um9wWCtYUW9ROWJ3R2w5THNVRDFuR2EzMnJWSWdiSm5DcmRKcGJRYmlMRmxi?=
 =?utf-8?B?b3FQRHNtcnNxS1hLK2pGcjZvZnZSenQ4UnBPY2dvRmFpV0NWM3NpRHJxSmh1?=
 =?utf-8?B?emUrZTZ4V3lyak1mdlpGMVN1aHV6VCtFK0lsYk9HUzRBQWNFNCtZK3RIV3di?=
 =?utf-8?B?cmRmdFJIWDV1TXlRY1MwREVWdW0zUmRoQm52REs1RTRkdGtIekZoV05XR29Z?=
 =?utf-8?B?VnRHZU40UlUwaE9iTkg0ZCtXSTZxMTdXUy9ySlRSOXY0QlA0dXlHUHlZbkFT?=
 =?utf-8?B?NTRISWZ3ZGY1czlxdWx1bVV2YmRpV09sZnZDRlh4QUxpa2hXTGEwdXpGMjB5?=
 =?utf-8?B?cVl6Q3ZuZzF0clBwN003QXdOWGVqbTFkVFdFNmljZ2NabVJGTUFWd1hyUkh6?=
 =?utf-8?B?R3ozUTJQSG9MT0NQdkdwNnlEL0M3RWViVzlvUkN2aS9lRG0xU1VYRmRiR2kv?=
 =?utf-8?B?WlNFcitqZi9wajJtcldwMHN5RThmckNFaU5YMWZhMGMvWlNLOVFUNkpmeWtE?=
 =?utf-8?B?Y1ZZRElWYUY3ZnMvWmtyaWdyRjVGNDJ3Ump5TW44UTZZRG5FblYxYlNXYzZq?=
 =?utf-8?B?dEppTHdKL3BRMUZiMEw0Zkw5UHNKcVRkeWRORE03d3pOWUhvTmhDRjU5Y3Qr?=
 =?utf-8?B?RmdoWC9iMUdhcWFxT3NNRjM4YUwyVVJReTQ1MDI1YXAvU0N5U0dOTUJVdHBT?=
 =?utf-8?B?OCtNM3Y4ZGhQVUhabytMM2pqVDBQaUVVaHZnZnRydk8xWlplZm5ybWM1cW81?=
 =?utf-8?B?d1AyQTJmQWV2NlU3SnQ5dnpSMzVpa080S0kzNkxuNzh4OE83amFXajcxQmo0?=
 =?utf-8?B?STNJVHNRbUYrMSszN3ppMGlKbFh6cmViQzhlMWtxSkhPeWJGWlpWbUdUMGJa?=
 =?utf-8?B?VXA0Y2FKMkZNN0VldU44bC9pL0RCNExlNHBXQ29EbkluUmw5SGxoWXJtNVNl?=
 =?utf-8?B?SWRLcDJ2N3VXaUtxRVFsS1VRN3NPY3Z1MW9JMVZTdjQzWGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmoxcXVXaDhMQW1vSFpoOXJrRmp0dTcxSE5RaG5IT1Y4MlpOSHd3YkFQS2pI?=
 =?utf-8?B?Vld5U21md01OYy9nMnB2UWpoZVVQbDVhZVhsZFJTRCtkZGJTeUM2cUV4em5I?=
 =?utf-8?B?WEtzOER4NUliQzV3T29XL2JsYTl3NlpZT2JNNjdXV1UwVTBnK0gzZWF2OXJl?=
 =?utf-8?B?aWxYNDJ6MFFlZzQ1Q0pWRmRldDhkTHpOOE5yeFdHNFB5L1dHNkl1eUw2U092?=
 =?utf-8?B?enVhSzluRW55bU5kTFJ2ZVAzdXg4NWttVVg4cWJzbEdOVjcreEVoYUowb0N2?=
 =?utf-8?B?bkt1NnRkNkhQN3hURml2Zm9DZTEzeWZKV25FQzgzakVQRys0RzZVM1dwQjVh?=
 =?utf-8?B?c1pudkFMZG9GaTF0Ykdjcm9pU1FibmxjQi9makRYUkZuaTh0eWdvK1VTN2Rh?=
 =?utf-8?B?WC9aTEtSWVZKbmhsS3dmTXZjeFNYR1FZMW1BNllpTHBvSDdDRVRuZE5pSDhF?=
 =?utf-8?B?dXcwNHVvMTVJSk9XNVJiS0lGQ2VhMTgwNlRCRDBuWVMwb2dOVFppYUZqczZi?=
 =?utf-8?B?Y1BZR2k1UVM0TzFkNWRJQlBnZUtrRWFqaFpFbzMzbkFTc1hNcDBpQ1RJQVFY?=
 =?utf-8?B?Z3p6VTRZTzRmSVB0VEFZcHVtT1AwQWlTN29qZk1sS3BacW1VZEV0Qzg5QmtW?=
 =?utf-8?B?SmlvS1RCU3BxeStpTlZQa2hsQmQyd3NjTGpGcVBOU0pHTG9YQTAwZ3RzUFp2?=
 =?utf-8?B?bkpOTTNJMTFzQ0kyejhLOTk1WGE1cUN0Rlg5MkpOZ3ZrUFlmSVRiN2hab3BE?=
 =?utf-8?B?ZUEzVnN6ak9aUDZWODNoQ2lXRXJKdzFYbVgxZ0FCbTAvS29FMGN4bXl3ZzBw?=
 =?utf-8?B?dDMyeGg5M2lRMmFzRFlqWEFINC9CRzlBSTFXcTVYWkxkUnJMaDBnL2crZGxG?=
 =?utf-8?B?dG1PVHNyMldFLy85a2dZc09jUzZZS2ZQMjVvVHQ4SWsyMFlhYlFZNi80Myt1?=
 =?utf-8?B?Uk10VE5iY1FDN0JBSHd0Z1lnTVBLTHNrdWU2bmYrbE9EMHpjbUs1amNpVWdO?=
 =?utf-8?B?MmxyVDh3K1Zza3NjZklDbUJTbC8rekEvS3ZlekFvWSt6aHpkd2JjY0RXL0Fv?=
 =?utf-8?B?QklSRkhFOExxVEc5dGlSVzl4SVcxRnNtVTNoYi9xT1BhV3FPWm8zdEdUMEk5?=
 =?utf-8?B?eUx6VU1rNzd5R216T2JsamdkK2hHZFpMaEZnSGVTdmp2dzg3NlZPR01qV09T?=
 =?utf-8?B?dlU0KzBpL0pDSWtZNzBEWnNhOEZVb0o0Q3FHV3h4b2tnUjQ5VG9CN09yWmto?=
 =?utf-8?B?RDArNEVMY054TWY2L2RCOXFib2tRNGl0azVkYXZTaTdSbHp5OWZ0b1hiUXFQ?=
 =?utf-8?B?R0tEOThRTkR1U3FkNWR1bzQ5Y0ZVNzR6U004OVlGMDFaSHl0dmRxOWthc0FL?=
 =?utf-8?B?MWplaDZVdkRLUkN6V0VCNlNjMkxIVGh1S3hadFk4VVlMbUhmY2doL0ZSeng4?=
 =?utf-8?B?U29ydjc0Y2ZSWEQ4RkZkTmxTL1Y4eXZTSEhPZTgvMXlWd29PSkhhcmljeU5t?=
 =?utf-8?B?Rk5BNmZHZ0p1dEd4dDFHb0hUNkVWUFRqT3lDeUlOTHBXZHhRS3BpdkJocWZN?=
 =?utf-8?B?WkJxWEw0cldjL3ZnL3FocWQ4amxJdHlzQTdvS1BpY09jdjgvczV6c3gwMW1x?=
 =?utf-8?B?RXJMbS9GQ2t1QlBRVTJVZm5kdlNZNTlGYmM0QzNCK0xHTU9DalpLRmtTZTBW?=
 =?utf-8?B?M05GdVNOTXJkWldYWnpKVGZab1plaU5kZmJub0t2WGlubG9HejY5SjRBcEcz?=
 =?utf-8?B?OCtFNjNMQ0tiOXdVUWlmK1JNZFZ3NjhhTGhwQUhVRVFib0hjL05Yd2ZobzND?=
 =?utf-8?B?MmJyV01rbTZ4UjFlZXhLOVpvSWM4NTNZb3dtT01Fa0k0TnBrRWxVcW54K2Yw?=
 =?utf-8?B?TStEeDBRWmVJTkdiSGlnME1VVWhoeUVYQjNuUC9vemJJb1BUN3krOElEWm1G?=
 =?utf-8?B?cW9sbGFxaDdxL0RYUWozdmU0MXBxdzdpU2JYbW5pT1c1NDJJSDdmRnlWUVla?=
 =?utf-8?B?TDJ0WEZNenIvQXlTNGNyVmJTQndaWnFyT0M5ektTVFpMTkRKc0JjK0lYcFJ3?=
 =?utf-8?B?YkxqS1R2cnUxT0M4anBmQnBscHE4dGtBRGVPbTNkbVQyS2xKN1QvcHlqOElY?=
 =?utf-8?B?QmRPWmJQM2dnVlF6MWYzeVFWb3hwa2NBbXFEQk5rRUhMdjdHdWRXQnZyeGQ0?=
 =?utf-8?Q?nwKFe/vNou8+5QzMvAFFQ1xdGIWa6ueKeAZZCW+bx5p3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8D23D1BE1AB4047970A730A0EA502F5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c9d1cb-9e1f-437d-c4ef-08dcaa306206
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 09:26:35.9359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t7gv8uQVgdkOnmAojkkHf1GGhYzW9ztpI1c8muug6qjeX/Htgiaq/u7Lwb69rC0od8FAIG+HeOz5/IFVSJhJag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626

T24gU3VuLCAyMDI0LTA2LTMwIGF0IDE0OjQzICswMzAwLCBUYXJpcSBUb3VrYW4gd3JvdGU6DQo+
IA0KPiBPbiAyMS8wNi8yMDI0IDE1OjM1LCBTYW11ZWwgRG9icm9uIHdyb3RlOg0KPiA+IEhleSBh
bGwsDQo+ID4gDQo+ID4gWWVhaCwgd2UgZG8gdGVzdHMgZm9yIEVMTiBrZXJuZWxzIFsxXSBvbiBh
IHJlZ3VsYXIgYmFzaXMuIFNpbmNlDQo+ID4gfkphbnVhcnkgb2YgdGhpcyB5ZWFyLg0KPiA+IA0K
PiA+IEFzIGFscmVhZHkgbWVudGlvbmVkLCBtbHg1IGlzIHRoZSBvbmx5IGRyaXZlciBhZmZlY3Rl
ZCBieSB0aGlzIHJlZ3Jlc3Npb24uDQo+ID4gVW5mb3J0dW5hdGVseSwgSSB0aGluayBKZXNwZXIg
aXMgYWN0dWFsbHkgaGl0dGluZyAyIHJlZ3Jlc3Npb25zIHdlIG5vdGljZWQsDQo+ID4gdGhlIG9u
ZSBhbHJlYWR5IG1lbnRpb25lZCBieSBUb2tlLCBhbm90aGVyIG9uZSBbMF0gaGFzIGJlZW4gcmVw
b3J0ZWQNCj4gPiBpbiBlYXJseSBGZWJydWFyeS4NCj4gPiBCdHcuIGlzc3VlIG1lbnRpb25lZCBi
eSBUb2tlIGhhcyBiZWVuIG1vdmVkIHRvIEppcmEsIHNlZSBbNV0uDQo+ID4gDQo+ID4gTm90IHN1
cmUgYWxsIG9mIHlvdSBhcmUgYWJsZSB0byBzZWUgdGhlIGNvbnRlbnQgb2YgWzBdLCBKaXJhIHNh
eXMgaXQncw0KPiA+IFJILWNvbmZpZGVudGFsLg0KPiA+IFNvLCBJIGFtIG5vdCBzdXJlIGhvdyBt
dWNoIEkgY2FuIHNoYXJlIHdpdGhvdXQgYmVpbmcgZmlyZWQgOkQuIEFueXdheSwNCj4gPiBhZmZl
Y3RlZCBrZXJuZWxzIGhhdmUgYmVlbiByZWxlYXNlZCBhIHdoaWxlIGFnbywgc28gYW55b25lIGNh
biBmaW5kIGl0DQo+ID4gb24gaXRzIG93bi4NCj4gPiBCYXNpY2FsbHksIHdlIGRldGVjdGVkIDUl
IHJlZ3Jlc3Npb24gb24gWERQX0RST1ArbWx4NSAoY3VycmVudGx5LCB3ZQ0KPiA+IGRvbid0IGhh
dmUgZGF0YSBmb3IgYW55IG90aGVyIFhEUCBtb2RlKSBpbiBrZXJuZWwtNS4xNCBjb21wYXJlZCB0
bw0KPiA+IHByZXZpb3VzIGJ1aWxkcy4NCj4gPiANCj4gPiAgRnJvbSB0ZXN0cyBoaXN0b3J5LCBJ
IGNhbiBzZWUgKG1vc3QgbGlrZWx5KSB0aGUgc2FtZSBpbXByb3ZlbWVudA0KPiA+IG9uIDYuMTBy
YzIgKGZyb20gMTVNcHBzIHRvIDE3LTE4TXBwcyksIHNvIEknZCBzYXkgMjAlIGRyb3AgaGFzIGJl
ZW4NCj4gPiAocGFydGlhbGx5KSBmaXhlZD8NCj4gPiANCj4gPiBGb3IgZWFybGllciA2LjEwLiBr
ZXJuZWxzIHdlIGRvbid0IGhhdmUgZGF0YSBkdWUgdG8gWzNdICh0aGVyZSBpcyByZWdyZXNzaW9u
IG9uDQo+ID4gWERQX0RST1AgYXMgd2VsbCwgYnV0IEkgYmVsaWV2ZSBpdCdzIHR1cmJvLWJvb3N0
IGlzc3VlLCBhcyBJIG1lbnRpb25lZA0KPiA+IGluIGlzc3VlKS4NCj4gPiBTbyBpZiB5b3Ugd2Fu
dCB0byBydW4gdGVzdHMgb24gNi4xMC4gcGxlYXNlIHNlZSBbM10uDQo+ID4gDQo+ID4gU3VtbWFy
eSBYRFBfRFJPUCttbHg1QDI1RzoNCj4gPiBrZXJuZWwgICAgICAgcHBzDQo+ID4gPDUuMTQgICAg
ICAgIDIwLjVNICAgICAgICBiYXNlbGluZQ0KPiA+ID4gPTUuMTQgICAgICAxOU0gICAgICAgICAg
IFswXQ0KPiA+IDw2LjQgICAgICAgICAgMTktMjBNICAgICAgYmFzZWxpbmUgZm9yIEVMTiBrZXJu
ZWxzDQo+ID4gPiA9Ni40ICAgICAgICAxNU0gICAgICAgICAgIFs0IGFuZCA1XSAobWVudGlvbmVk
IGJ5IFRva2UpDQo+IA0KPiArIEBEcmFnb3MNCj4gDQo+IFRoYXQncyBhYm91dCB3aGVuIHdlIGFk
ZGVkIHNldmVyYWwgY2hhbmdlcyB0byB0aGUgUlggZGF0YXBhdGguDQo+IE1vc3QgcmVsZXZhbnQg
YXJlOg0KPiAtIEZ1bGx5IHJlbW92aW5nIHRoZSBpbi1kcml2ZXIgUlggcGFnZS1jYWNoZS4NCj4g
LSBSZWZhY3RvcmluZyB0byBzdXBwb3J0IFhEUCBtdWx0aS1idWZmZXIuDQo+IA0KPiBXZSB0ZXN0
ZWQgWERQIHBlcmZvcm1hbmNlIGJlZm9yZSBzdWJtaXNzaW9uLCBJIGRvbid0IHJlY2FsbCB3ZSBu
b3RpY2VkIA0KPiBzdWNoIGEgZGVncmFkYXRpb24uDQoNCkFkZGluZyBDYXJvbGluYSB0byBwb3N0
IGhlciBhbmFseXNpcyBvbiB0aGlzLg0KDQo+IA0KPiBJJ2xsIGNoZWNrIHdpdGggRHJhZ29zIGFz
IGhlIHByb2JhYmx5IGhhcyB0aGVzZSByZXBvcnRzLg0KPiANCldlIG9ubHkgbm90aWNlZCBhIDYl
IGRlZ3JhZGF0aW9uIGZvciBYRFBfWERST1AuDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25l
dGRldi9iNmZjZmE4Yi1jMmIzLThhOTItZmI2ZS0wNzYwZDVmNmY1ZmZAcmVkaGF0LmNvbS9ULw0K
DQo+ID4gPiA9Ni4xMCAgICAgID8/PyAgICAgICAgICAgIFszXQ0KPiA+ID4gPTYuMTByYzIgMTdN
LTE4TQ0KPiA+IA0KPiA+IA0KPiA+ID4gSXQgbG9va3MgbGlrZSB0aGlzIGlzIGtub3duIHNpbmNl
IE1hcmNoLCB3YXMgdGhpcyBldmVyIHJlcG9ydGVkIHRvIE52aWRpYSBiYWNrDQo+ID4gPiB0aGVu
PyA6Lw0KPiA+IA0KPiA+IE5vdCBzdXJlIGlmIHRoYXQncyBhIHF1ZXN0aW9uIGZvciBtZSwgSSB3
YXMgdG9sZCwgZmlsbGluZyBhbiBpc3N1ZSBpbg0KPiA+IEJ1Z3ppbGxhL0ppcmEgaXMgd2hlcmUN
Cj4gPiBvdXIgY29tcGV0ZW5jZXMgZW5kLiBXaG8gaXMgc3VwcG9zZWQgdG8gcmVwb3J0IGl0IHRv
IHRoZW0/DQo+ID4gDQo+ID4gPiBHaXZlbiBYRFAgaXMgaW4gdGhlIGNyaXRpY2FsIHBhdGggZm9y
IG1hbnkgaW4gcHJvZHVjdGlvbiwgd2Ugc2hvdWxkIHRoaW5rIGFib3V0DQo+ID4gPiByZWd1bGFy
IHBlcmZvcm1hbmNlIHJlcG9ydGluZyBmb3IgdGhlIGRpZmZlcmVudCB2ZW5kb3JzIGZvciBlYWNo
IHJlbGVhc2VkIGtlcm5lbCwNCj4gPiA+IHNpbWlsYXIgdG8gaGVyZSBbMF0uDQo+ID4gDQo+ID4g
SSB0aGluayB0aGlzIG1pZ2h0IGJlIHRoZSBwYXJ0IG9mIHVwc3RyZWFtIGtlcm5lbCB0ZXN0aW5n
IHdpdGggTE5TVD8NCj4gPiBNYXliZSBKZXNwZXINCj4gPiBrbm93cyBtb3JlIGFib3V0IHRoYXQ/
IFVudGlsIHRoZW4sIEkgdGhpbmssIEkgY2FuIGxldCB5b3Uga25vdyBhYm91dA0KPiA+IG5ldyBy
ZWdyZXNzaW9ucyB3ZSBjYXRjaC4NCj4gPiANCj4gPiBUaGFua3MsDQo+ID4gU2FtLg0KPiA+IA0K
PiA+IFswXSBodHRwczovL2lzc3Vlcy5yZWRoYXQuY29tL2Jyb3dzZS9SSEVMLTI0MDU0DQo+ID4g
WzFdIGh0dHBzOi8va29qaS5mZWRvcmFwcm9qZWN0Lm9yZy9rb2ppL3NlYXJjaD90ZXJtcz1rZXJu
ZWwtJTVDZC4qZWxuKiZ0eXBlPWJ1aWxkJm1hdGNoPXJlZ2V4cA0KPiA+IFsyXSBodHRwczovL2tv
amkuZmVkb3JhcHJvamVjdC5vcmcva29qaS9idWlsZGluZm8/YnVpbGRJRD0yNDY5MTA3DQo+ID4g
WzNdIGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MjI4Mjk2OQ0K
PiA+IFs0XSBodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTIyNzA0
MDgNCj4gPiBbNV0gaHR0cHM6Ly9pc3N1ZXMucmVkaGF0LmNvbS9icm93c2UvUkhFTC0yNDA1NA0K
PiA+IA0KDQo=

