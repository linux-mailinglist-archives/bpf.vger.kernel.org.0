Return-Path: <bpf+bounces-60195-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 395AFAD3DD2
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 17:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10243163DD6
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 15:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875BE236A88;
	Tue, 10 Jun 2025 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TcnhfOwJ"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A8B1EDA2A;
	Tue, 10 Jun 2025 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749570446; cv=fail; b=LL+VVIaH7plGAfmqa/0gFYgl0HkLyn7PkK3s7YvGC6SZSYDDHadqaZ2MzXIOJE96DIpzqZ4DvbmzI6oJCrocZbW4rnEPuYgMx7zLyUQb7wdRb6wnkE7SmPhmdjH/iW9Es/YHS5BEEl7s6aodf2uSYUL04mH2sCtupr1Hqf1xoIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749570446; c=relaxed/simple;
	bh=kNqOPRYfBp1r3scT/iLybWzgt/hwCgpNufnXle0QtRk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N4cdt4v1y3Hez+x5SNgCckEANe6aPtTxHJdw7E0gpAiHjb9uos25ARsjqDkPt4C9MBBd3KmmDEDwaozunm+QKBKb+y7kHCADI/QBm1+DmXJPHl7+3CpFjilbwHoceMdTXtFerA5uaVQlAnNAND45wjekmpyMq5oH28rTqplsZ/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TcnhfOwJ; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWm4OLPUOWzYLRQYujdyqx92U+zwhS7TEhiELwrJ282LeiTD3v6LAgKZmRqyfG+irQpABrB3mwaqfQ4jqnEujKVDiuF1V8TuSS4MkRHYSZbNivkRpcmHB8eWJoS+0S2LQTKyDYdzp9VRMeZpFENjINCZG4PSAY6FlT9mzaLaaqxgQ0sHg26MCTh7V156aqlbiQrTiqBrv98ejoS7bgLkB786uoxWel2jwHang3CL8UvQ+lc7PaILc6TaPJOTRgcnEBGhIXvFXWM6iYjR/sSwJyOa6ZKUSlSbJZCNOQwS6hPA5S0pdg5p5wXw4FJaWtjtowyTlcHYmeZmW19BkXl/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlYEdZPFpCZoZon3Dwb7tTn8DRVD60pKerjsmS3f748=;
 b=xgK85P82XH0FV+7rAaUkPeV9fEmAyLY5CRNLrPP662hLtQsZrT5SUOlKth/loxQI19D7nsUMPVZJZBFJXvSwEhfOhqEnzDiWXkMPq4c0BvdQs+ODi2pnLfiRLOQfLgE3rFqtuZ8r/DeeNORhTq/lyJryXyMZE/KWIWbL9xmfSRqw+qsE6fmhFMJx4NxhNM//WIaHchhbyd8LE/Y34T3s8PGK2hROdELLIbopkQ4j5i41NL71TlBOj6Uv1pxfQae6FrejfRbVMtRnTIVNpt0y7IAZLk9FKmZybl8kEPXcNs5LKGTu1S1cTbMGKMYTyOnfWmNgk0GJ9wc4P35zWFMx5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlYEdZPFpCZoZon3Dwb7tTn8DRVD60pKerjsmS3f748=;
 b=TcnhfOwJ0p04ce9MVmRqWZxjeQmtTz91XcXPXbp4an+lSB1k0Ff9SlIkjg+NKrXVRo2C8Gm6/cx9OE8Hpe9SBxJaUCc1IQTBCQOauQONEmbP7HflrKmgJ2Ef7wGPTcSawshvwFbb8soUoIVx/MWimVWwpQI9jp5KZjpcXhihtNVXpjR0of312aGtT9TGXtMDVZdtic5PqkU/Df5kHsgx9eFPhR8SJFBqm3E467TDAdLEYrc7yUe4fDwPTgELcHRlQiaXTULpAfRgLdGj9CLahbViOmcHf82WWRSDNRIKDdwOocEvUbhh1GWoJQ3hIC1uYp5OpAjYpAuYMgw9E9vetw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 15:47:20 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 15:47:14 +0000
Message-ID: <f1b83c6f-850e-42f7-9750-0a0d45e44623@nvidia.com>
Date: Tue, 10 Jun 2025 11:47:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rcu: Fix lockup when RCU reader used while IRQ
 exiting
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Xiongfeng Wang <wangxiongfeng2@huawei.com>, rcu@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250609180125.2988129-1-joelagnelf@nvidia.com>
 <20250609180125.2988129-2-joelagnelf@nvidia.com>
 <aEgjvGkYB0RoQFvg@localhost.localdomain>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <aEgjvGkYB0RoQFvg@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0249.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::14) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 543b959a-6ffb-419a-7ab5-08dda83611f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGNpeE9ScWVmNkxEdmJlNUdxN3hhTDY3Y0hjVWFncTEzemd0NFBLL1NYUVhi?=
 =?utf-8?B?Tm1XaFlpU3RxNmdrNHZpLzJPcE9SdUNIWkdLeWY4WHE2Y3UrS05WRklCbFFI?=
 =?utf-8?B?bTc2MEgrcHUrdkkxYld6LzYwTk0xZjFqemJ3MnVGRUVIQTZZNnkwQVVNVERV?=
 =?utf-8?B?U1NDem1IazBQUzg0Q0d1K0lReXBjUE92eS8rc3FqcFhHaHNzaFdiZWd1K3Z5?=
 =?utf-8?B?S3FKaCtLUU4yYVpoa05vY2VONjBMSGxuODl2ZTBha29KVGdKNStON09KZkZr?=
 =?utf-8?B?WHhndG92VE1kZCtiTFRwcTRieWg2cVdTazZaK3dzSTQ3MnNZNTBGSC9XWW91?=
 =?utf-8?B?dXEwaHhWVnFkZ0lwYTl2WVVaSC9VNW5yQ0NEd2xUd2VROUllaDdFUlNMWW9j?=
 =?utf-8?B?aHhCRldIS2dpZGJEc1NiQ2t2cnVORVRZTngxb01sQkdSQUVhMGlOYTBaVDNW?=
 =?utf-8?B?aCtLNkVvR1hzdzNSbVU1Qy9GYUp3MGlDZVY5VFIvYWQxeCtxRERRN2h3UGl2?=
 =?utf-8?B?NmtjdDE2YnQ5bzJmZ1hSaFJvbHI0RFE5TEFWRGluSjlvb2VueDVldU5ORzZv?=
 =?utf-8?B?WnlsU21SMEdPcWE1VURwN3NWSjVKVUtZNFpYMkwyV3AvbGpaWUtGVGhweTR2?=
 =?utf-8?B?QjFMcWdtckhPMXFzUFBiS2N1OVUvUjNqdlpTdXp4cmczVVh6RHR2Z2lnNFhC?=
 =?utf-8?B?R2s1b3M1RjVoTUpTczFVa2o3MlUyYnZDRkJFNTRrbml2YnB3eTlOYldSZllB?=
 =?utf-8?B?cTNYeDJNV2IxcklJejQ3bjBGdVBaQ2lmTjMxdFhxQlc1cUpralNKeUdqazVa?=
 =?utf-8?B?UisrWjJnaENNdXBmNW5aK21MTkdaNnVtLys2MVdnaEowRW01aGJ4K1ZZem55?=
 =?utf-8?B?aE9JQmtjMjI3QWd1dnVIME9XZ1pRYU90WE1vTWNJS0k0OWRGejhEcmhXZ1Zo?=
 =?utf-8?B?ZGNLSlVzNW5Sb2FucmFNWDVtUm12Vng1TFcyOEdibDhHZWxteUt4WDhtdGRO?=
 =?utf-8?B?ZW9qdHlKelgxaHBIb0I3Y3BUMXhlVStkWlc5REVYMFVTVWhtUitxQm5kMmZu?=
 =?utf-8?B?S1k1bE1wUExUekFNenh5RTdTUTlqTFJEeHNKbkVDU2ZxQnlwbU03ckUwM0ZS?=
 =?utf-8?B?c0d0TXFCZ2hZZlVnNjRzaEtPQkpYRGt6RmEzaGJmaVhKOTk2SnNQRy9USFJh?=
 =?utf-8?B?dlN6Y01lZnpHQUR3bXlDWVc1V2tpOGpPK1FFL2tIbmk0QWtkdmo4ZmczaHM4?=
 =?utf-8?B?eUdlQy9nN1FRbmFVNDE0WUVzQVVlVk1KdU1FUUg4QjdPeTBjU29aNXJnMnhX?=
 =?utf-8?B?RGdrcTFBVlRvMDFOQUNoQ0ZzUjBoWGcyRnBVdEYyUWs4ZTVETC9XdG1XUEpw?=
 =?utf-8?B?MXRyZVltbFhvQmNhNDVuUkU1NmIweEZ1U09zTmhjUzVGa3ptdGpoMWlnSnpv?=
 =?utf-8?B?S3BwaTNJQWlYTzlnbjZuKzJORlBIMnVKaXNEaHdBSHFaQjdZaXVTbTVDWFJ4?=
 =?utf-8?B?cCtVQmZFWG5talBURTZIcTk0QnZFRk9hUkNhdlIxQ3o5anBManR0eU1RTDc4?=
 =?utf-8?B?dnQrRG1zanpMNmFQR0NiMlQzL1FKTmxZTGZwNkFzSzRSWlFzMkhtd1VqQnly?=
 =?utf-8?B?a0FpQ0tSWkNLZ0YrYWpvK3pxeHowa2pHeERoSTRZS29nSzlXNFJoWnUva0pX?=
 =?utf-8?B?TCszTFdzMkhSRHhBeUE5TmdRREp4RFhld0h6Tk5DVW42REw0VWhFN3YyMzVp?=
 =?utf-8?B?SXY3TDN5Vi9hN2hjTHNmL3ZRdmRuUktFb05vYURTekRKc3VHME1XNE9EcnhE?=
 =?utf-8?B?Nk1zQnNHV05oSGx0VUVnUEFSR0ppOE02NGVIUUhGa3BQZjJRbysrSDQ4UEJz?=
 =?utf-8?B?RVRXUUJUY0pKWmpsRUo1QThuZkN6cWNmT3BFTXRJK0hONXI2RldyRmlQM1ZZ?=
 =?utf-8?Q?0RN6BshJieE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWV3WlRBY0EzOENmVVovaGxLdnVGU24yTnNLN1pKeTdMZHh1SzZPNVl1aVZ5?=
 =?utf-8?B?UDdGNWRnazJQajZyTlQxRFpHTDAzQnZOVlVDajhaemNLeWZBcGlIL0x0SGVy?=
 =?utf-8?B?NlBVN0RsL2NkRENCRWVqVmVjQkVCQitsbVIzNjlUNzJPN0tHdXBQZjEzOXky?=
 =?utf-8?B?enIxQnA4STVmODhTakdUWEdhd2hKQ1hSVnhJYkNac1BpNlFhRlVZL24wbEdM?=
 =?utf-8?B?QnNGUnVjZUZtbno1TXZoRHBZS01iaFRnMXZWT2ZkTjJzdlJlejU1VGxPODlL?=
 =?utf-8?B?U3liaGVUandnY3lDaHJaZXdHWGxnOWJiUWg2Q05JellHM2xJa2sxSW4xeDhG?=
 =?utf-8?B?K3cxV1N0eHBUejBhN2M3VUVvRnBwK3B0SnI1cGUydmpRR0lJU1lxU3Bwa29Z?=
 =?utf-8?B?RVBnN1NWaTlzU0c5US95OFZRenEvR1dVcmV6U0UzWWEzdDZkRWhwQW82ZUc2?=
 =?utf-8?B?c3hBbk5iTisrYUtyVk80RTNaa0JrbGl3SXB1MkdWT1NWQTRhSFdMQXBYdHE5?=
 =?utf-8?B?aVZrS2lPdTNDem0yUVNDQ0xVc2xwUlRUSmFYWFNMNHUzYjVxZmlsL3haME9S?=
 =?utf-8?B?dzJCSlBxV0JKVE1EbXZWc0lTSEdXbHY4ZU9UeEdGVmRsK3ltd09RWVgzNy9U?=
 =?utf-8?B?VGEzNmx5RzdOVitWU256Tm9XV2ZOUFJHMjFONXBmWmsxc3ErNDdsb3ZnMXly?=
 =?utf-8?B?bElsS2RnTGk2aWxDL0kyZUJkYStoYm43RGU0eUlzeWJiOU45djFmWHVYQU1u?=
 =?utf-8?B?Rno2Tkdxc0QzTGRiMktRbEZZbFVscG1Eem0vZ1l1TWxMdGNJYjNpOUt0UlM2?=
 =?utf-8?B?NllEa3RFcU5nYyszZHVhMzdxS3dZbGR2SERkWldrNXE1U0YvbjdWZTdCbmxC?=
 =?utf-8?B?bmROVnVkeUVFMEp2TUdMelN4ZllnLzZkZXdTUjR6ZlNYTG1zUWZHaFVPdE9v?=
 =?utf-8?B?NysvY1RNREFyYnB1Z2xSMHRhZVA4REtyWXd5RWZVQzhRR1ZRZ08yVUVNVWVQ?=
 =?utf-8?B?K1dNQU9kUG9ZVENlUmp4cFNsTnlQSUJyY3k4eUZLUmZFdzhmM3dWRE5yZ0VC?=
 =?utf-8?B?OHk3Nmt4NThmODhDRXovN3MyTU5RN0E0aEFRVlFtaGpucTBqNW5OZGR4WFVa?=
 =?utf-8?B?bEFDaWJMa255QW9nUm1wWjFqSmcyOFA5VC94SDNEMVV3UDBZOVVOZUJuekFs?=
 =?utf-8?B?cVpwTEgwbWlkeGI0Z2pFN0pDTUgxK016RVhJZWxNZXdBZmN0cFI1Z0RDeWps?=
 =?utf-8?B?UFRWOFhnV2tIYmhSdlBJcUNoL3d0ejFKSHBQckJxWUt2U1R5Yjl4L2MrbEh3?=
 =?utf-8?B?WDFTNEVNdkN3OCtrajZLMStPMjdnNmhpSngzRDJvV29RR1BQMlFjUzgwTnlS?=
 =?utf-8?B?Z3dOQXc4ZmFkK2Q4b3VXYUtvd28yblgxT3Ixd3pMbTZZeERHczRvSk91eW90?=
 =?utf-8?B?TzNaNFdNUklTWnYyVHg5QTRUMHJ1WTBubDlMd0o3OHZLajYwVFE4NmMzdXI2?=
 =?utf-8?B?S3g4QTdIbHduM1FoQ0RiZmg0VHJIak14Ni8vems3MEhUQzFLVmpOKytwdE1J?=
 =?utf-8?B?ZWY2N0VrQjZsYk5uQ0pUcVoxaW44dWltSUlyTFBhU3NCNHRSOHBDdzlsTnFE?=
 =?utf-8?B?UlV6REpBbHhxYStpM2xBYzkxMTJ5T3RBR3U1YlJkckZDTXZ3TUEzOC9JS2tm?=
 =?utf-8?B?Tll5cnRVWTFpN3VxdFdvQ2xVU0xPdm15clNJL2ZtcUdGbHprZys3a2trRzRQ?=
 =?utf-8?B?M09jSGhldHV1OTVrUHVYZEpUbjVkUUljZkV3azdpSHVrYVJGYmJweWZxWGVJ?=
 =?utf-8?B?Vi9BckV3dWhIWThqa25qTzdlSVdQcllhQ0tKc3BIUzdOZGE4bGltMStaWitO?=
 =?utf-8?B?WldocGRDQ0VWbXdlbzJaWUJrVjEzSGhyODdZcWlaOE9kaVJrU3JPaHhpYlZZ?=
 =?utf-8?B?bVF5bHlrZjVDeHZuWEZia0xHN1RoSk8yZ0pwUDhWQng1dGJZWmpWdldYbE9R?=
 =?utf-8?B?MEFUZjJZMkZhOU1MSFVYZ0pGaDArWDU2TUZqa3RFU09KdjEwMSsyckRJNlpy?=
 =?utf-8?B?TEdXeFpPZUJCZFl4d1B4N2pVU094ZzJIZTB3Z2dyVWpGV0J4N3l6cGJnczdI?=
 =?utf-8?Q?tuYFLBotDbHI3/g8eelmA/9dJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543b959a-6ffb-419a-7ab5-08dda83611f4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:47:14.1605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmpDZrPNy0tLdUevmyQ9IY0LWQHUWP461l6C6F/2KvITBn77SNInVtbGXbkegCgm69AL8+cdspizrIkIWGOP5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860



On 6/10/2025 8:23 AM, Frederic Weisbecker wrote:
> Le Mon, Jun 09, 2025 at 02:01:24PM -0400, Joel Fernandes a écrit :
>> During rcu_read_unlock_special(), if this happens during irq_exit(), we
>> can lockup if an IPI is issued. This is because the IPI itself triggers
>> the irq_exit() path causing a recursive lock up.
>>
>> This is precisely what Xiongfeng found when invoking a BPF program on
>> the trace_tick_stop() tracepoint As shown in the trace below. Fix by
>> using context-tracking to tell us if we're still in an IRQ.
>> context-tracking keeps track of the IRQ until after the tracepoint, so
>> it cures the issues.
>>
>> irq_exit()
>>   __irq_exit_rcu()
>>     /* in_hardirq() returns false after this */
>>     preempt_count_sub(HARDIRQ_OFFSET)
>>     tick_irq_exit()
>>       tick_nohz_irq_exit()
>> 	    tick_nohz_stop_sched_tick()
>> 	      trace_tick_stop()  /* a bpf prog is hooked on this trace point */
>> 		   __bpf_trace_tick_stop()
>> 		      bpf_trace_run2()
>> 			    rcu_read_unlock_special()
>>                               /* will send a IPI to itself */
>> 			      irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>>
>> A simple reproducer can also be obtained by doing the following in
>> tick_irq_exit(). It will hang on boot without the patch:
>>
>>   static inline void tick_irq_exit(void)
>>   {
>>  +	rcu_read_lock();
>>  +	WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, true);
>>  +	rcu_read_unlock();
>>  +
>>
>> While at it, add some comments to this code.
>>
>> Reported-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> Closes: https://lore.kernel.org/all/9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com/
>> Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks.

> * What is the point of ->defer_qs_iw_pending ? If the irq work is already
>   queued, it won't be requeued because the irq work code already prevent from
>   that.

Sure, but I think maybe we should not even attempt to queue the irq_work if
defer_qs_iw_pending? I understand there's no harm, but we'd depend on irq_work
internals for the intended behavior.

> 
> * CONFIG_PREEMPT_RT && !CONFIG_RCU_STRICT_GRACE_PERIOD would queue a lazy irq
>   work but still raise a hardirq to wake up softirq to handle it. It's pointless
>   because there is nothing to execute in softirq, all we care about is the
>   hardirq.
>   Also since the work is empty it might as well be executed in hard irq, that
>   shouldn't induce more latency in RT.

Oh, hm. So your irq_work_kick() on PREEMPT_RT would only trigger the hard irq?

That does make sense to me. Lets add the RT folks (Sebastian) as well to confirm
this behavior is sound?

> 
> * Empty hard irq work raised to trigger something on irq exit also exist
>   elsewhere (see nohz_full_kick_func()). Would it make sense to have that
>   implemented in irq_work.c instead and trigger that through a simple
>   irq_work_kick()?

Yeah, sure. We'd probably need some serious testing to make sure we didn't break
anything else and perhaps some new test cases. From past experience, this code
path seems easy to break. But, nice change!

thanks,

 - Joel


> And then this would look like (only built-tested):
> 
> diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
> index 136f2980cba3..4149ed516524 100644
> --- a/include/linux/irq_work.h
> +++ b/include/linux/irq_work.h
> @@ -57,6 +57,9 @@ static inline bool irq_work_is_hard(struct irq_work *work)
>  bool irq_work_queue(struct irq_work *work);
>  bool irq_work_queue_on(struct irq_work *work, int cpu);
>  
> +bool irq_work_kick(void);
> +bool irq_work_kick_on(int cpu);
> +
>  void irq_work_tick(void);
>  void irq_work_sync(struct irq_work *work);
>  
> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 73f7e1fd4ab4..383a3e9050d9 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -181,6 +181,22 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
>  #endif /* CONFIG_SMP */
>  }
>  
> +static void kick_func(struct irq_work *work)
> +{
> +}
> +
> +static DEFINE_PER_CPU(struct irq_work, kick_work) = IRQ_WORK_INIT_HARD(kick_func);
> +
> +bool irq_work_kick(void)
> +{
> +	return irq_work_queue(this_cpu_ptr(&kick_work));
> +}
> +
> +bool irq_work_kick_on(int cpu)
> +{
> +	return irq_work_queue_on(per_cpu_ptr(&kick_work, cpu), cpu);
> +}
> +
>  bool irq_work_needs_cpu(void)
>  {
>  	struct llist_head *raised, *lazy;
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index a9a811d9d7a3..b33888071e41 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -191,7 +191,6 @@ struct rcu_data {
>  					/*  during and after the last grace */
>  					/* period it is aware of. */
>  	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
> -	bool defer_qs_iw_pending;	/* Scheduler attention pending? */
>  	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
>  
>  	/* 2) batch handling */
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 3c0bbbbb686f..0c7b7c220b46 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -619,17 +619,6 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
>  	rcu_preempt_deferred_qs_irqrestore(t, flags);
>  }
>  
> -/*
> - * Minimal handler to give the scheduler a chance to re-evaluate.
> - */
> -static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
> -{
> -	struct rcu_data *rdp;
> -
> -	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
> -	rdp->defer_qs_iw_pending = false;
> -}
> -
>  /*
>   * Handle special cases during rcu_read_unlock(), such as needing to
>   * notify RCU core processing or task having blocked during the RCU
> @@ -673,18 +662,10 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  			set_tsk_need_resched(current);
>  			set_preempt_need_resched();
>  			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
> -			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
> +			    expboost && cpu_online(rdp->cpu)) {
>  				// Get scheduler to re-evaluate and call hooks.
>  				// If !IRQ_WORK, FQS scan will eventually IPI.
> -				if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
> -				    IS_ENABLED(CONFIG_PREEMPT_RT))
> -					rdp->defer_qs_iw = IRQ_WORK_INIT_HARD(
> -								rcu_preempt_deferred_qs_handler);
> -				else
> -					init_irq_work(&rdp->defer_qs_iw,
> -						      rcu_preempt_deferred_qs_handler);
> -				rdp->defer_qs_iw_pending = true;
> -				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> +				irq_work_kick();
>  			}
>  		}
>  		local_irq_restore(flags);
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index c527b421c865..84170656334d 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -377,14 +377,6 @@ static bool can_stop_full_tick(int cpu, struct tick_sched *ts)
>  	return true;
>  }
>  
> -static void nohz_full_kick_func(struct irq_work *work)
> -{
> -	/* Empty, the tick restart happens on tick_nohz_irq_exit() */
> -}
> -
> -static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) =
> -	IRQ_WORK_INIT_HARD(nohz_full_kick_func);
> -
>  /*
>   * Kick this CPU if it's full dynticks in order to force it to
>   * re-evaluate its dependency on the tick and restart it if necessary.
> @@ -396,7 +388,7 @@ static void tick_nohz_full_kick(void)
>  	if (!tick_nohz_full_cpu(smp_processor_id()))
>  		return;
>  
> -	irq_work_queue(this_cpu_ptr(&nohz_full_kick_work));
> +	irq_work_kick();
>  }
>  
>  /*
> @@ -408,7 +400,7 @@ void tick_nohz_full_kick_cpu(int cpu)
>  	if (!tick_nohz_full_cpu(cpu))
>  		return;
>  
> -	irq_work_queue_on(&per_cpu(nohz_full_kick_work, cpu), cpu);
> +	irq_work_kick_on(cpu);
>  }
>  
>  static void tick_nohz_kick_task(struct task_struct *tsk)
> 
>   
>   


