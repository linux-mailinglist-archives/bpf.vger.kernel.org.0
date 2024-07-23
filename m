Return-Path: <bpf+bounces-35384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3605C939E47
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 11:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA7F282E90
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 09:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC2614D435;
	Tue, 23 Jul 2024 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Enw/zQb1"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F5938F9C;
	Tue, 23 Jul 2024 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721728385; cv=fail; b=rH3p34PXuUUtbXMzM9UJguDhJw6x/h+Q6z4HvEa0fDd2jzFWIsPKdbofmmWWaWoVtM8xjRwgRTCGWjDSoJZRK8hFnsUyZm2fCb2YKT71hhr9KmCjLIq7itL3ioHsxo9ZZbeFYjzPokP61J/s8bFwh2wtW4azVBQLokGZqpXB61A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721728385; c=relaxed/simple;
	bh=J6BX2/WZA4Gw1taXIO5jyppo1/KPY5rLdpY3sq4Q4k0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cQ2jDk/+w8HTH1WPT8lH5+7M4JTxKS91d0Rzi69wrqQeoVGFT0iFFoJ1CC9hZsX12MNOhMZBnmAh1cKH1mHQNpUmViqiKNBg8y/wYM/OL7Y5lzFenjeE9GftOkDmOiYCRQQkYhhZzmY6YVSi8IIEouJYkyAnS2uz2eK76wzc0QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Enw/zQb1; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFhjts9Os3STU04QgK7XXxYSJJdopJ8BjgxzZjzuK7+XBnn1aaGeO/jdOei0fCYafD1ZN4Sw6G2cNp1djLbZ6hXze4blmbUvoz3ZlJwWueCsS1/VKRrNRAuqsvS3d59UlHFXqo/pFg3blSU7d/q6kxbdp/E2G2kO7SFn8buiwv9kxXrXA0+LeVlzfef9+wGSYTFAaSRAbgIDYNXRB/UrDgmEfYzEZXaSeStHyQ+KZ+yuUwYdqpVivv8Dyt+4jrZn+xkxGr0rY0fAncxg6yqfSVeJOOlPRS5ewEz5P1xJLjGwaz4gIV1tRzjTkoCVknm7Tiz/z3v6hnRlCNU1TX/ooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtPHOXMF31ea/NfLu4uipNLowYROgCmFjK5xHi4msWo=;
 b=RC0918c0xWD6Ks1vGSbC2ejJ75/3Ss40yUgm8Jwi8zIArgzMPHh/JqUiJYZtEmnQG4N6tIfaPilf8Eg0HaPu7obdHp5eqTcBImUgl4kBvc4jTFoCAI6O/56gKBeedyIU1T0vXbElO/KTfM3bru4I+4AUhXD+Gvzylfia16Q7MpYmAxSGnjuwlGEQPHfpEWj7iWsCU4BxKlqqoybGUlvlAN6eJJuArb2r1sPeHd32cEEyP+cNWDhwax889Xfjjqfn3UmZIpRCSExG71/2ZcgR+fklrPAmXjblzTXRhPHXOPXBryXizpL/C85T4wAu0nohRaBjySAzWDsxjzCCRzVEXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtPHOXMF31ea/NfLu4uipNLowYROgCmFjK5xHi4msWo=;
 b=Enw/zQb1gxpFpwPm+ymb+Us3f6QbdwNUClOwlOnyCRpVb6oUzGZ9ujR7Ba70XBJLzu6iHmA4Hmo7dzxrD4gTNCwEt61TV1PN3DgLq2vC6AmRZsIZRo2SmqtasqKv3f4PZfqUX98VKx9AkJW21mrRGmpKKT1JwX76kUh8GyrZcySGWB6Qr6TXaYn6q7pm+HeBZG7hmxmFD0TOMa+po6EDwj65u/UU2FGwWfIT+C4cKXQ5GDP2H0gxGyiBCLLg3HKHFjy+xyWBRV6YbPWkq08b2hiqqjfTjyNWxowp8d3p6jLV0TsQ7dQjYggOFOV4o6UVQchvTFdljXuUqDUNqnPyiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6184.namprd12.prod.outlook.com (2603:10b6:8:a6::8) by
 DS0PR12MB7876.namprd12.prod.outlook.com (2603:10b6:8:148::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.29; Tue, 23 Jul 2024 09:53:00 +0000
Received: from DM4PR12MB6184.namprd12.prod.outlook.com
 ([fe80::5883:408d:962a:feab]) by DM4PR12MB6184.namprd12.prod.outlook.com
 ([fe80::5883:408d:962a:feab%4]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 09:53:00 +0000
Message-ID: <b1148fab-ecf3-46c1-9039-597cc80f3d28@nvidia.com>
Date: Tue, 23 Jul 2024 12:52:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: XDP Performance Regression in recent kernel versions
To: Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "sdobron@redhat.com" <sdobron@redhat.com>, "hawk@kernel.org"
 <hawk@kernel.org>, "mianosebastiano@gmail.com" <mianosebastiano@gmail.com>
Cc: "toke@redhat.com" <toke@redhat.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
References: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
 <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org> <87wmmkn3mq.fsf@toke.dk>
 <ff571dcf-0375-6684-b188-5c1278cd50ce@iogearbox.net>
 <CA+h3auMq5vnoyRLvJainG-AFA6f=ivRmu6RjKU4cBv_go975tw@mail.gmail.com>
 <c97e0085-be67-415c-ae06-7ef38992fab1@nvidia.com>
 <2f8dfd0a25279f18f8f86867233f6d3ba0921f47.camel@nvidia.com>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <2f8dfd0a25279f18f8f86867233f6d3ba0921f47.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::13) To DM4PR12MB6184.namprd12.prod.outlook.com
 (2603:10b6:8:a6::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6184:EE_|DS0PR12MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 7228773a-6f39-4f8c-365e-08dcaafd3c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmJXSmJaYTk0c1pZRnI4R3hlaSsrd0oyMFQ0SGNGVmdMcnc2TUVMTm5RekhJ?=
 =?utf-8?B?aGVRVU50NmltVXFEYmhma0orWEljS3Y3NENnK0haTGRHdy9jb3JZYnlmcGd0?=
 =?utf-8?B?Zk1mNHBmZUh3aU1BQXdpZVhKNEFYOGtRVHo4UTJvbzAzWW5VZGdnL0lzNzkw?=
 =?utf-8?B?SnNxM0ZsSW4waGFLZjFLTXNtdFRtRXQwM3RMR2FVS3MvWUs0RkNTcmd2cnJR?=
 =?utf-8?B?T0duZm1GSkdwYmFVYlRBT2dXN0hrZWJHNXdLVFBEbDh2UjAxV3BYOHZxK01o?=
 =?utf-8?B?VmNPdzByRGhBV2djb2VwYjJQbmZaUk94SXR5NVBnU3BpdXNjbkd2bFllNHRh?=
 =?utf-8?B?dHhHVE5tN0FKT3dpWElwSStidzR2b2hzM0xGYitHcGxMNjB1Tjl1YmdCM3RB?=
 =?utf-8?B?RGZlN1M3UHJ3cHZmbnFZR0QxdndrRnJqM29hdW1sejJpbndibEVtQUhrcUcy?=
 =?utf-8?B?L3UyRjgyVXlFZVJYU1FucE9KZ29pYmlSSTZOeGczN2NndlRSOU1tZTBIZ3hH?=
 =?utf-8?B?dE9nczNiNUYzd1hYdWkreVdUd3dVT1FkYnBZRnJ3NUxjaC8vcmdzYXNaVTdv?=
 =?utf-8?B?bWFhWURpVDczYlpNaWNmRTNJUEF2N1pVN1JDa3dBVXJUblNoaTVaUTlicVZm?=
 =?utf-8?B?ajNTTjRIMlhTczIvT05oejlBcDhPMWZBQ0FhSWZFY2pHVjRETXMyeWQ5TVpo?=
 =?utf-8?B?djdlZjlIaTZUcVpoQTdaV3hpNkpHMUJGclZSZGUzYng5SEs1R2FBVUloaXdT?=
 =?utf-8?B?cWwveXJjckJ6RzJrQzFiaXA3Y200T0Zrc004ZjZPbCtJQmlBbHFlVHdiNjZr?=
 =?utf-8?B?UUgreEdPOEhnOUQxR1l0VmZsQW93dXdiNytTaCtqSWw3NW1Mc0krbEo5elc5?=
 =?utf-8?B?ampoU3FnWHE3WllQY0oxTER0bUNtVlQ2MVVhek9CQllFTlM3UGRIYmpQc2Ja?=
 =?utf-8?B?ei9XaDcrajBWRjYyQUgwT3FRc2Q3KzhCMWFjQzNkbFBQOWFFT1dBb000dXY2?=
 =?utf-8?B?VWVXSHlWQVdhTGJrU2FkbHJSdjZST0k2MmhuaFNvTGJqd2g3dWtTMC9FMlVG?=
 =?utf-8?B?SXRiN2pJTGZtejRPVUprR1hOUEtEUzRsSXMzL2FiazZBbUttb3RCY3d4V2xM?=
 =?utf-8?B?eGJVcGhJQzlnUmozalhLdGdRMjdKaU5Ma3hOaHpodG1sKzVtTE1INk1UU25o?=
 =?utf-8?B?elEvTUplUUlIQWZIRWROTXBtZ2pqdHBJUUtYNVJUeHdUUm1iMjJITFdDQkIz?=
 =?utf-8?B?ZXVDbnl1YmlMN3hFOVFxSXdkQWRqMDZUQlpVSnYzNjhsL1VsRE9ESDNNTVhP?=
 =?utf-8?B?ZXB5bUE1ellpY2ozNCtCaW5ZaEYzdXVnSlJyZHZWaysvd0JDcTFLVmgxNm1B?=
 =?utf-8?B?Zi8wQW56RGRabjR3STZSNks2Qnk3SFVXZVNhQWsyVmRZWndoTkNpWjRsTHYy?=
 =?utf-8?B?WStUWjIwbUtnOVcvQlQ0MTlVeUt0T1BNeW5WWkZabUljWEg4cUozVFc2eFFt?=
 =?utf-8?B?T2Z1dXY5VmV5UHFLenRUZzFTdDhEZ0dvWGN4blI5TlVHckRTYU1KVkJVZnpX?=
 =?utf-8?B?YU9sVUdWbzNTeVpUajQrb2grNnl5T3V0TlFnQ295WUV3L0MycmlLbUNwNXg0?=
 =?utf-8?B?Wmw4QzdQM21SZHhPWEFuZDVCUi8zZjRZT2FMeDZmUXN5ZlgwbEVtNU5GVDJC?=
 =?utf-8?B?WHhGWnh1b05JSWNKdFk0c2h3R2VvcVV3N0xFckZEOTJ0OE5iV0MxZFBhbDg0?=
 =?utf-8?B?TkRrTExkTjNBcWgxdG00SDlzNnYxOU0zL0ZjNE9qQjlZTUFpbWhNb09mL1R4?=
 =?utf-8?B?UE80T0FCMkg1T2pmWXhVZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6184.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGl5RWkwY3Y1eHBEZVZQNWZMUThmOGkyUllzcHRibjQ5TUY4elU1RTF1UXVX?=
 =?utf-8?B?WWtsKzBDSmlJMFlGNmR2Wmk4dEhwWVBoeE1TdG1TcUdzL3YyM3NUdDJUYmM0?=
 =?utf-8?B?bTNNTzFscitXaUxRL2Q2RlRkM0hFbVQ3UTczZWZHbC9ZZ2tkVDhVWUF6dGxT?=
 =?utf-8?B?bDFpcFVSeUx1R3lRcnlXeDJ0a1JOY1B1T1YyTmhaVlA0M0Y0L1ZDd0sxNFAy?=
 =?utf-8?B?TUtRcHlicmc5OTRqUFU1QXMxNHRyQTloRHJNYWpTWUxnR0dYaWpZY1NKNGFY?=
 =?utf-8?B?UDVHRW5UOG8rTldvWktPdmtKY3o5cHV2ampTUTlTeGRmNDNwc2JFUVMzY1Mr?=
 =?utf-8?B?RFBNdFpoVmV5QnZ1NzJLNk5Da3pCY3owc1pQOHp4K280Z0tWaEErNkNTdjFQ?=
 =?utf-8?B?YlV4d2NBMThFYjhQQS9SVk03ek1IUHJjQ1R0T3JvSUlLZHhrdzAzUzhRWG1L?=
 =?utf-8?B?ajlHQzZWc3cxK3pObE5xSk9nc2xkS2tZWjRGNkZtWEJDSGJuSGhLNXhtMTIz?=
 =?utf-8?B?Z2tlKzhjRm9uVG52aGhPOXZudW13YUFCZ1NKZTRHVDEvd1JDNkdOc0ZDTjNl?=
 =?utf-8?B?Szg4VU5sbHZGZWpuR1JycGp3Tk5Dc09DbzNTRVlobGs4TFk4eExqYXJFNWVN?=
 =?utf-8?B?bDU2N0FXUG9qN2YxOTd1Z3BnK2tCaDZZTnpOWnZLRmU3TUdVL05PNDVkNDM4?=
 =?utf-8?B?dWp6UzN3MjgvUFFBTlQ5azB4OTVydjNGMHFUd2tjbC95V01VOTE2Sy80alo4?=
 =?utf-8?B?MFB5ZFVjY3V3SjF3WkMrQ2pqM3ZZNDZmQmxDbDBZUjE2MXRiY3BXenlNODY2?=
 =?utf-8?B?SFNkK1p4dUNLR1VaQVJKTEdOcHB2SDVOL3JacE40RllSaDE3U0NVRkk4b080?=
 =?utf-8?B?YzJJdytTcmluclprWHlialVYOVBtZ0liUnM0aGg3ck1LUjdpczZmUXIwWHhV?=
 =?utf-8?B?dnN6N0htUmdSTEJ5cnhHWVpkL0REVFFZK0lMeDM2U2ZicmJvRzBiRGZkNUNP?=
 =?utf-8?B?RHlEMXV4SmZKcFBBWVNKRGZZaFg0ZnRFdUJJYzdTZ0pEam5aclFQZzMrU0V2?=
 =?utf-8?B?YXkrSCt3UldQaGtMQmNGTzhpN01JeEtRWm1ZdWpkOXZsNnFkWGtQZDB6M0ZE?=
 =?utf-8?B?UkF1b3BQTHF0TVdiVWxEOGZ4UkJmMU9saFR4ZWtLK2N0Uko4TkNvL2V2a0Uw?=
 =?utf-8?B?dStQNHYzeGdTblVIbTlTR1djUGt2WENiQUkvMGcyVWVrUndpMnZvdmFUWldQ?=
 =?utf-8?B?cXd3ZlFUejNKYUplSXV0QmxJeG1tVmUzczlPZTliYU1QQW8xb0p5SnU5SUdv?=
 =?utf-8?B?ejBtbXlFeENYWjFmeWxJZ3hobmtPV1pwUGNxdmpRSGt6eWZibGdXZjJURnJv?=
 =?utf-8?B?a2gwNHFvenY3WHI3bXpIZGZlb2RFRmVCbTd1bHNQMkJmY3lYbmFyc0ZTSFds?=
 =?utf-8?B?d0l2WnlSU0lHUWVUWUZObnlIYzdyZ2Qzb0tGQTYvMXI3bHJxNkQwV1ZaSTdo?=
 =?utf-8?B?VG11VnRiZnFEaGxoZ0FSZ0RSakE3RTF3QjNmbVJxUlo1dVVRWVBvL0lIWTFR?=
 =?utf-8?B?SDhBa2Jld1pVZElMcExwVHl6M2lhQVdwNVpNRGlSeVA3MFVUV2Q2N1R1WmFG?=
 =?utf-8?B?Qmt0UnJGUE9uYzF2UHgreFNka0ZMQnJ5aFVUN1FXNUdJNGF1ZlkzNmVwZXZy?=
 =?utf-8?B?aStibWQ4MDVIU0w2LzQzSzZqZGtyNXgydTYyWWkrNHpaVlZSUE9SdGViTDla?=
 =?utf-8?B?U1VzTXA2dGovQlZBNWRZbHozRUFmV1NZT2Q5S2FUeEJCQVJjUVpvSDdhbmdO?=
 =?utf-8?B?VndSZ3lwNmxMVm5DQ2ljTFNUTUxKMytOelhZaGJUZnJndVppYlBlREVuSDJC?=
 =?utf-8?B?ZW1JSmRXaTlMMXdKcDVLbllXblpEbVNicXkzSG0waHNtK3ZEVXpZN1ZZSHZn?=
 =?utf-8?B?MlFXVWpjdFAxNmFBb2Y2YUZBT2VtUzFNZXk4R3BraE1zaG5TV3pQczhDejZI?=
 =?utf-8?B?cDZrY2MxbXdYNGtjU3RQYU1DV1hHRFBkOTN5Qkh4Tmh6TFdSVlluR0N5TWNp?=
 =?utf-8?B?bVRFWk9hTWI2dzZaZ2k5V2w5YURDb3plRU1XSnI0aWVnaCtOTXRDVWczdmFL?=
 =?utf-8?Q?Edg/awrHL3UvlFyPlKo4roMed?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7228773a-6f39-4f8c-365e-08dcaafd3c8e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6184.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 09:53:00.1200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqAjynJYiF7znHk4FCI4A4WmEsStTzXnVFMXSiiU4rSnw50C5mD2oZjg75qhXsJtcBa07pM9dTqGL8KHrH9eVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7876



On 22/07/2024 12:26, Dragos Tatulea wrote:
> On Sun, 2024-06-30 at 14:43 +0300, Tariq Toukan wrote:
>>
>> On 21/06/2024 15:35, Samuel Dobron wrote:
>>> Hey all,
>>>
>>> Yeah, we do tests for ELN kernels [1] on a regular basis. Since
>>> ~January of this year.
>>>
>>> As already mentioned, mlx5 is the only driver affected by this regression.
>>> Unfortunately, I think Jesper is actually hitting 2 regressions we noticed,
>>> the one already mentioned by Toke, another one [0] has been reported
>>> in early February.
>>> Btw. issue mentioned by Toke has been moved to Jira, see [5].
>>>
>>> Not sure all of you are able to see the content of [0], Jira says it's
>>> RH-confidental.
>>> So, I am not sure how much I can share without being fired :D. Anyway,
>>> affected kernels have been released a while ago, so anyone can find it
>>> on its own.
>>> Basically, we detected 5% regression on XDP_DROP+mlx5 (currently, we
>>> don't have data for any other XDP mode) in kernel-5.14 compared to
>>> previous builds.
>>>
>>>   From tests history, I can see (most likely) the same improvement
>>> on 6.10rc2 (from 15Mpps to 17-18Mpps), so I'd say 20% drop has been
>>> (partially) fixed?
>>>
>>> For earlier 6.10. kernels we don't have data due to [3] (there is regression on
>>> XDP_DROP as well, but I believe it's turbo-boost issue, as I mentioned
>>> in issue).
>>> So if you want to run tests on 6.10. please see [3].
>>>
>>> Summary XDP_DROP+mlx5@25G:
>>> kernel       pps
>>> <5.14        20.5M        baseline
>>>> =5.14      19M           [0]
>>> <6.4          19-20M      baseline for ELN kernels
>>>> =6.4        15M           [4 and 5] (mentioned by Toke)
>>
>> + @Dragos
>>
>> That's about when we added several changes to the RX datapath.
>> Most relevant are:
>> - Fully removing the in-driver RX page-cache.
>> - Refactoring to support XDP multi-buffer.
>>
>> We tested XDP performance before submission, I don't recall we noticed
>> such a degradation.
> 
> Adding Carolina to post her analysis on this.

Hey everyone,

After investigating the issue, it seems the performance degradation is 
linked to the commit "x86/bugs: Report Intel retbleed vulnerability"
(6ad0ad2bf8a67).

This commit addresses the Intel retbleed vulnerability and introduces
mitigation measures that impact performance, especially the Spectre v2
mitigations.


Disabling these mitigations in the kernel arguments
(spectre_v2=off ibrs=off) resolved the degradation in my tests.

Could you try adding the mentioned parameters to your kernel arguments
and check if you still see the degradation?

Thank you,

Carolina.

> 
>>
>> I'll check with Dragos as he probably has these reports.
>>
> We only noticed a 6% degradation for XDP_XDROP.
> 
> https://lore.kernel.org/netdev/b6fcfa8b-c2b3-8a92-fb6e-0760d5f6f5ff@redhat.com/T/
> 
>>>> =6.10      ???            [3]
>>>> =6.10rc2 17M-18M
>>>
>>>
>>>> It looks like this is known since March, was this ever reported to Nvidia back
>>>> then? :/
>>>
>>> Not sure if that's a question for me, I was told, filling an issue in
>>> Bugzilla/Jira is where
>>> our competences end. Who is supposed to report it to them?
>>>
>>>> Given XDP is in the critical path for many in production, we should think about
>>>> regular performance reporting for the different vendors for each released kernel,
>>>> similar to here [0].
>>>
>>> I think this might be the part of upstream kernel testing with LNST?
>>> Maybe Jesper
>>> knows more about that? Until then, I think, I can let you know about
>>> new regressions we catch.
>>>
>>> Thanks,
>>> Sam.
>>>
>>> [0] https://issues.redhat.com/browse/RHEL-24054
>>> [1] https://koji.fedoraproject.org/koji/search?terms=kernel-%5Cd.*eln*&type=build&match=regexp
>>> [2] https://koji.fedoraproject.org/koji/buildinfo?buildID=2469107
>>> [3] https://bugzilla.redhat.com/show_bug.cgi?id=2282969
>>> [4] https://bugzilla.redhat.com/show_bug.cgi?id=2270408
>>> [5] https://issues.redhat.com/browse/RHEL-24054
>>>
> 


