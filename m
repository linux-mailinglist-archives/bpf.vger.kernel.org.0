Return-Path: <bpf+bounces-44531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9387C9C42FB
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 17:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249E51F25545
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 16:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8131A264A;
	Mon, 11 Nov 2024 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B3PvaVl7"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779EC14AD3F;
	Mon, 11 Nov 2024 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343941; cv=fail; b=oNpuv1mHPFqhPPutoRqIkfkL2wCwDfzO8hACnkGfGS8Vy/VpnNwe9iHT07YZzu25GLHurmF1hxY/k4W30zWK5Ccj9rMWhiacPaAoUo61oaGC8ps9mkmVIcc1QhlAhe9qk39vLDQ0wx0DYoVGt5gwpxu4StPJ5lAOeTfXruc1nYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343941; c=relaxed/simple;
	bh=/39i8cUXabSJKfqI5fdspm/iY5uqVQGmqg1Bcg9yfus=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hrq+3Rk9z0GB+J9mVc76B14tMxee8ByP3C227pj4xYD/y63H2PcxyLGrl1gRLVeZPdzsoTtBzsQ+d5D2LYDXOV5SvKx7p0jXBi1eoShN90gQphNIsGPzIDJM/ZhSpJgNDNT0pTN2gYLN45LgCNYf+rGN4rmY6xGsY7j94nVPi4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B3PvaVl7; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Neq3wZIKYZ2AoPaEV3u6nEo0w17ZHobkSeSXY0nfmvFZnMoDczEJnC6y0AVyTrl5CBN67RnS9QN3yS2jRDrO7urM4anDpb4zuWzzI/SLjqkramGEZzuUFF0HxO3l9418q7003NlrlDW1mtIlzXkFpdEvcw6/DB9ZZYy40H+rZvYs0n5OZDrNw/LsYrvMgFjzniU2TB64NPV+A7UOEfxQ2hk3E1FUfUCkc7lfVYIfwpHl6poCqmdmVWwYsa+qgWMyuYOeDDOS756NCJr2z1YdAI67Oe4UL0rD7b2uNnqyk9Z7PDQsDkcT1l5vkXGwds5d0aVVh5rIpUs4Ok5NcWdnZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FatAbhnO3IxNulbd2JWeg57nzEJd0r1W73YmjuBCyfI=;
 b=nWLjz1d7Iw3vd7cs8Un9jyskreFhF2uUTVbLDvLV68CmYa+Wb/yorKm4z1azMiPc77wiIoJQdxRyxQm6wurRbmNWHZvEmKBmQ+eWnOxSworwBsc7OsZlM1wPK6AvE2SuZh7taeQPXmgRcIucqgS9J/vf9civ2rxdYK9458kOBSd9mzJwZCzQHKXvxBoW07/4VCnd4M3sef89C9bBMfRoilylLCm/AFp6OZi3Cjadaob2uD3s0OAbbhoM/c0xw1ku2lbi8addjN4ANyyorgFv8oZc9r79jHu3d/WlnnmXTN/c6yRqqK8kTfQqMFK9bHItW21Ad7jpCgoj5JbY9LH2KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FatAbhnO3IxNulbd2JWeg57nzEJd0r1W73YmjuBCyfI=;
 b=B3PvaVl7ixg7m3Hr3oNioytgjF61LbJIDw9ruO1qII9dncGmqKlqa6A0Ny66bVwGzApSuj/xLoAa3yDfY7/3GSFcdAdUxaKQKgNUZLhOOrXMva1TVMiwFtsz8pFlibT12ARaZw1OTJbPKwC7FGKWdnqZG2NeP8XKDjp0MFvPMsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 PH7PR12MB6762.namprd12.prod.outlook.com (2603:10b6:510:1ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 16:52:09 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 16:52:08 +0000
Message-ID: <c15d4a80-2f27-4588-af87-9cf7cf3ad79e@amd.com>
Date: Mon, 11 Nov 2024 22:21:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rcu 06/12] srcu: Add srcu_read_lock_lite() and
 srcu_read_unlock_lite()
To: paulmck@kernel.org
Cc: frederic@kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, rostedt@goodmis.org,
 kernel test robot <oliver.sang@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
 <20241009180719.778285-6-paulmck@kernel.org>
 <e46a4c37-47d3-4a02-a7a5-278d047dd7a2@amd.com>
 <71a72bcc-ba85-4f86-9d41-cccfd433fa09@paulmck-laptop>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <71a72bcc-ba85-4f86-9d41-cccfd433fa09@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|PH7PR12MB6762:EE_
X-MS-Office365-Filtering-Correlation-Id: 6daca2fa-af05-4d77-2d4a-08dd02712e2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1VtUXVOMDVJNFFLLys5ZXc2VXdPbzFhUjlyNGZubFhFZGdoVlJRdUhoN2NU?=
 =?utf-8?B?cHAvSWxVbDRLZk0xOE10cTNaVmpxL2dnYzR6ME1JeUMzVlpPMlRYSjNZdHZR?=
 =?utf-8?B?dzRUZm8yd0xGVy9BUER1RnUvSDBIb3l4N2Y2OXY1UVpDZEtITFBJRmFmblps?=
 =?utf-8?B?eW9WaFFCRjdnQUdBR3pCd2h3MzNWYVFLeWkwQlpWMEUya0FlYUhuLzRrcnhU?=
 =?utf-8?B?TXQ1YkZSMlBGTlN5eS9SK1NVaXc4Zno0RVJYZmRKUHpIYm8zWmFRRnJIakJz?=
 =?utf-8?B?YWRqY2RwUHZOZW04NnplWFRvVmxlVTlLeEdCYWVXUStpbkFnNU1rUTU0UWZW?=
 =?utf-8?B?N2k0eHQzTE9MMitnNTVwbWYzZVB2dWJGdi91bkNZc2IzdGtEdG1DQTM5MFA3?=
 =?utf-8?B?SUk1em9vVkl2UWFwRVViQmoxeXZ5THd6Mitkc3p3WHlqRm1yTWxKbGd4b2M0?=
 =?utf-8?B?L2lXalk1STBmOGVVVGUreTVjOUFBeG5ucTQ4STJ5WnlDZVpvVUJFSVNES3h3?=
 =?utf-8?B?MEJRM3crbXM5V1FpSEcvMmlTbUVCRjZYano3REppQnM2bHNvZGJZdG02Vk9o?=
 =?utf-8?B?NitkOUtpTGxtWnprVCtVbDZPdWxwamZsbWdDN0IrVzRzZTE3RXo5czNMNCtW?=
 =?utf-8?B?NGpkTk02UkxIYnVLMEV5U0tlQUwrbStmNXYrMkIzRkpXemlXdVVuYWZ0WHBG?=
 =?utf-8?B?TGhkbXpOVlFPWFNxUVNXZXl4MENWc2xnbzl4bzVBSCtubEJ3MGxWNHo4cGh4?=
 =?utf-8?B?TWxkeTNseUpHckROa09QS3NjcjRYTlNOc3d3Ym55NkVLSkZJcGdLaURGUnB3?=
 =?utf-8?B?ck8xclBMWlBGeFRCenhSWlJjNG8xWVJxaGlLMDNYQWV2M20rNmErNzV1TUE1?=
 =?utf-8?B?WkQrZTAxQ000NDk1U01FMUd5aVZMNUphNHgrVlRVVmt6Q3NkR3dlVmpvalZo?=
 =?utf-8?B?Y3FhK1lhOE50b2hpMzVSNTBmNXBVRCtCcXRnY1o4MHFRZm9UMXZRUWJNSjNX?=
 =?utf-8?B?WGlkc21acENveitkM0taR2Q3eGVsOUErYmlnaU55bnlqbXVWeDQ5SEVOQ0Fu?=
 =?utf-8?B?QTFUM21iYXBROVVvbzRJS2JJQjdKQk9HbVhEWW1tMlUrU2ltVzB5UHFRemFF?=
 =?utf-8?B?ZTVUbm1Lc1dBcHFqNkJaQkc0cjlsVGk4b25pZllCd1Q4d2twY1RrRi9TZFNX?=
 =?utf-8?B?MCsvZlovWG0vdUFDRURXbWUwM2JqNWsyRDkwdkhVK2JOR0hVbW1icVl5WDhw?=
 =?utf-8?B?WHRWMStsdGd0b1hVVmNwUTlkWWtURlhkZUIvbzJmRzJlU2pvcmZlWEFKNmVN?=
 =?utf-8?B?bEMxTjlRS2VRdEhwdm5IMittT2RUVFVWRUJnQjlMUDNLL0I2bTI3ZzcveVQx?=
 =?utf-8?B?c1JhQ2NUN1hVS2p2STJlSlloWUtWaFUzMjRuM3k4MTdWVDJoM0xRVTN5MTBZ?=
 =?utf-8?B?MXh5QUtsdk9rS013NUhVTEJxZmhHSVpvRGs1bXh1RUphaDN1OXI2cEI3WVRH?=
 =?utf-8?B?QTFvZ2pjUEVwWmFSZDJKTEFyWk9LMm5XYzRONmxtRUFWOGcxZmIveUdGN1dj?=
 =?utf-8?B?VXJUMGpPWWJHOVh3UTNDV2htb0xtTDloQjZYNGtkNEw2bmhCcWhVN20wc1NR?=
 =?utf-8?B?RG1tQ1owdjhOeXlnMkx6dlpOUVN6MTg2TWhKdm5NdW5xbkFuRW1kYmFyaFhQ?=
 =?utf-8?B?RW5ObExDRG9jeEovMk5icjlXSGFTM21RQzA5d3ptanc2TWlLaVRxZDNPWklV?=
 =?utf-8?Q?KrRMdFe//hgrhqgdpx9UFhdh6J7rRKytgyIwc2i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bE1EV0tzRytRbVRFR2VVcGRrdUdFdXByUG85cDZhb3ZFUW9YUStmT3U1THdW?=
 =?utf-8?B?MlEyRDBNM2gwVlkzMEE4aHNTQ2ZDeUVGTkRWaDlxdWtNNW1VQmdyM2ZLa0k4?=
 =?utf-8?B?RE5OUjNXU0ZtNzRvS2ZxTy9jL21teUtvZjlpUThzYVJEVVdkaGNySGNwOU1G?=
 =?utf-8?B?NXVEcHpjTXFSQVNYb21PQ0Y0b0lpcUw3QWE3VUpCSDlmcWgxVWlCUGtudUk4?=
 =?utf-8?B?UTlzREwxQTI0UHFJMVBVeE1EVjg2cmZnRWhrQjJFQkYzUmVrOWV3WUtwYmIy?=
 =?utf-8?B?OW1TK3I5bytxc1dFbzVtN1ZyMzJWTWdEMEowc0w5TmExMDIxY3EvRDdTcER1?=
 =?utf-8?B?alFTTnN1Y05CTktNWmlCR28xeXVRcWFyZEZ4NnNSenZYZFViMFIxOEljeUtu?=
 =?utf-8?B?RnZ2WS9vbGdPSGdDaFFwd2VJN3B6S1VpZURFbFdIZXBEZUFHOHdaYm55YjVw?=
 =?utf-8?B?YzBJbmdqSWxJVzgzeEQ3TW9la1RDMml0bGJBOW5tVWVIeDlxR2I4SFVRZjdz?=
 =?utf-8?B?QUdsQWVIN01UQnNjWkdJakJnY0FkZ0cvVjByaEFhdlBTeXkrQ0lUWU5jN2h3?=
 =?utf-8?B?QkhoZ1ljdW9GY1FsU2dtM2Q3RCt0YmJkbUZaSG9HclJIUWI0WS9xUUNDbTQ1?=
 =?utf-8?B?Zk1JalljRlJxcGpUMFFnTnVGTWczSlNFQ3VqRFlOQ3c1QnozQTlGZDVFMkVN?=
 =?utf-8?B?UmhpSWpqdVdVRk9YeUVwNkNxODJRQlFkbzMrKy95YkcrOStWQUpaYTEzVTZt?=
 =?utf-8?B?MFZDZVdaZ3RMK1V4a1pHaFg5bm9VejVHTGRIMHRrUGszTlBFdHpneUhvV2hJ?=
 =?utf-8?B?TlB2KzB6WG1uaUxCeFZiZHk1V3lDY0tkbmRabEIrNEdSemx6WU9jZWhlZU1w?=
 =?utf-8?B?eEJ6dFJsNnpFRm9LcHg5Q2dKYkU4S3dCcStUKytkSFNFVnZHeHI3dWlhS3Uy?=
 =?utf-8?B?a09oc21PZlRkV3VxV3NQOTQ4YWhrckxHbVpYUk1XVTlSTlA0UldRQ1B4WmhK?=
 =?utf-8?B?cjUyV0NPYk9hKzQvV1BxWTR5Zm90NldyZk1PWEVLQkp1NFVaalZLSzBpTmQ3?=
 =?utf-8?B?c3FxS2lLWitzSzBhblZIVlZ3RmRiTS9JLzMrTktvUlVaZDcwUXlVcUNueVJS?=
 =?utf-8?B?YnZ4eEhqcDljU3puVEtGcFNFRDl5N3hOcVpCU1VRUk5GZVdUWFFoRzZJRzNZ?=
 =?utf-8?B?c3JUSmllZ1VRSm1SNUlvdUE0YzEzOVFxZ09vWW9aN3V0QTIzUjJKVzVEbUk3?=
 =?utf-8?B?SENzQU9GTXRzMkxORFNzR1FKWEZWOXpKa1JmT3U4cXZKVjdNYVpTSEd0SU4z?=
 =?utf-8?B?c2F1M0Ftcno5RitDUHNXTjNTaFlXMWtOUGhUOTFEYmU1ZzN6SmZZMStjcFFW?=
 =?utf-8?B?bUVHdnh3bHdtY2hxSzB4bGRKbTgvLy8xYWlqYWdyTlVLRFhvNXhvSGpaUzZF?=
 =?utf-8?B?YXRjc08vUi91RUVmenZhZjhJTTY0OFRFL21SMWo3SDhPMTM5WkhSL1lSMjd1?=
 =?utf-8?B?WnMzRUhma1JiWEt4MW5WS0RiYjNCTWJwQmlJc1pYUWF0WUk0RmUrTWY5elhi?=
 =?utf-8?B?ZnZtdnpGRzgvamw0M2FuWlNGcXNqcVNFRjFCMHdJNS9jVys0WUNTSFBGOTdK?=
 =?utf-8?B?TEMySVhrQUVYdkw1TUlwYktEbStHZFBTMjl5akIwcnErVmVLTDJnNWZQTGNX?=
 =?utf-8?B?cVc2b1JSV3FKQlR2NjlRdHZHcU5wZ1VydWdHZUZaWi9QTG5Gbmc3eVNpeEFi?=
 =?utf-8?B?S3l5aTFoR3Nsd0ZQOTFRV2NhWFRkcUwxM2pVOFJhY21KbU9QMU96a3Q3a3VY?=
 =?utf-8?B?NUt5Q0pTQXlVUmIvYmJ2SVptOXpLckZmblZZeGFILzlENCtLYUpBOFVhNEc3?=
 =?utf-8?B?cm52YWF1N0Z5TzRENUluVUUzTU9tZGpTSHo5cE9hNWNlU2hud2lIMWdQSDZ1?=
 =?utf-8?B?S0l0eXpVYmVvQ1BxOTBRWEs0cU5aYldzWHFrd0NEWGFEUTNncUt4ZW1WbUJ3?=
 =?utf-8?B?T1phMU1nOXVXaTV1K2dGOTM5bGFOaSs0WTJIWVR5NHpXd1NiS0c3R21RUmVU?=
 =?utf-8?B?Sm9abjNmMFRONHloa2JoY1RSTDNHbDFWUnMzaWZXMmtOekxnL1U4Vitld0lT?=
 =?utf-8?Q?JE+0ZobeA10dJGk652u4nfz7S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6daca2fa-af05-4d77-2d4a-08dd02712e2d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 16:52:08.8429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2k7OE1/g9bAaetzI3p4nwPMcHzyUbDVIAUysechfMCD9EIZJatZo4pxS2VoVZFcTUCjufd2w4XhmVeC9IuO+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6762



On 11/11/2024 8:56 PM, Paul E. McKenney wrote:
> On Mon, Nov 11, 2024 at 06:24:58PM +0530, Neeraj Upadhyay wrote:
>>
>>>  
>>>  /*
>>> - * Returns approximate total of the readers' ->srcu_lock_count[] values
>>> - * for the rank of per-CPU counters specified by idx.
>>> + * Computes approximate total of the readers' ->srcu_lock_count[] values
>>> + * for the rank of per-CPU counters specified by idx, and returns true if
>>> + * the caller did the proper barrier (gp), and if the count of the locks
>>> + * matches that of the unlocks passed in.
>>>   */
>>> -static unsigned long srcu_readers_lock_idx(struct srcu_struct *ssp, int idx)
>>> +static bool srcu_readers_lock_idx(struct srcu_struct *ssp, int idx, bool gp, unsigned long unlocks)
>>>  {
>>>  	int cpu;
>>> +	unsigned long mask = 0;
>>>  	unsigned long sum = 0;
>>>  
>>>  	for_each_possible_cpu(cpu) {
>>>  		struct srcu_data *sdp = per_cpu_ptr(ssp->sda, cpu);
>>>  
>>>  		sum += atomic_long_read(&sdp->srcu_lock_count[idx]);
>>> +		if (IS_ENABLED(CONFIG_PROVE_RCU))
>>> +			mask = mask | READ_ONCE(sdp->srcu_reader_flavor);
>>>  	}
>>> -	return sum;
>>> +	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
>>> +		  "Mixed reader flavors for srcu_struct at %ps.\n", ssp);
>>
>> I am trying to understand the (unlikely) case where synchronize_srcu() is done before any
>> srcu reader lock/unlock lite call is done. Can new SRCU readers fail to observe the
>> updates?
> 
> If a SRCU reader fail to observe the index flip, then isn't it the case
> that the synchronize_rcu() invoked from srcu_readers_active_idx_check()
> must wait on it?
> 

Below is the sequence of operations I was thinking of, where at step 4 CPU2
reads old pointer

ptr = old


CPU1                                         CPU2

1. Update ptr = new

2. synchronize_srcu()

<Does not use synchronize_rcu()
 as SRCU_READ_FLAVOR_LITE is not
 set for any sdp as srcu_read_lock_lite()
 hasn't been called by any CPU>

                                      3. srcu_read_lock_lite()
                                        <No smp_mb() ordering>

                                      4.  Can read ptr == old ?


>>> +	if (mask & SRCU_READ_FLAVOR_LITE && !gp)
>>> +		return false;
>>
>> So, srcu_readers_active_idx_check() can potentially return false for very long
>> time, until the CPU executing srcu_readers_active_idx_check() does
>> at least one read lock/unlock lite call?
> 
> That is correct.  The theory is that until after an srcu_read_lock_lite()
> has executed, there is no need to wait on it.  Does the practice match the
> theory in this case, or is there some sequence of events that I missed?
> 

Below sequence

CPU1                     CPU2     
                       1. srcu_read_lock_lite()
                       
                       
                       2. srcu_read_unlock_lite()

3. synchronize_srcu()

3.1 srcu_readers_lock_idx() is
called with gp = false as
srcu_read_lock_lite() was never
called on this CPU for this
srcu_struct. So
ssp->sda->srcu_reader_flavor is not
set for CPU1's sda.

3.2 Inside srcu_readers_lock_idx()
"mask" contains SRCU_READ_FLAVOR_LITE
as CPU2's sdp->srcu_reader_flavor has it.

3.3 CPU1 keeps returning false from
below check until CPU1 does at least
one srcu_read_lock_lite() call or
the thread migrates.

if (mask & SRCU_READ_FLAVOR_LITE && !gp)
  return false;


>>> +	return sum == unlocks;
>>>  }
>>>  
>>>  /*
>>> @@ -473,6 +482,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
>>>   */
>>>  static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
>>>  {
>>> +	bool did_gp = !!(raw_cpu_read(ssp->sda->srcu_reader_flavor) & SRCU_READ_FLAVOR_LITE);
>>
>> sda->srcu_reader_flavor is only set when CONFIG_PROVE_RCU is enabled. But we
>> need the reader flavor information for srcu lite variant to work. So, lite
>> variant does not work when CONFIG_PROVE_RCU is disabled. Am I missing something
>> obvious here?
> 
> At first glance, it appears that I am the one who missed something obvious.
> Including in testing, which failed to uncover this issue.
> 
> Thank you for the careful reviews!
> 

Sure thing, no problem!


- Neeraj

> 							Thanx, Paul
> 
>> - Neeraj
>>
>>>  	unsigned long unlocks;
>>>  
>>>  	unlocks = srcu_readers_unlock_idx(ssp, idx);
>>> @@ -482,13 +492,16 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
>>>  	 * unlock is counted. Needs to be a smp_mb() as the read side may
>>>  	 * contain a read from a variable that is written to before the
>>>  	 * synchronize_srcu() in the write side. In this case smp_mb()s
>>> -	 * A and B act like the store buffering pattern.
>>> +	 * A and B (or X and Y) act like the store buffering pattern.
>>>  	 *
>>> -	 * This smp_mb() also pairs with smp_mb() C to prevent accesses
>>> -	 * after the synchronize_srcu() from being executed before the
>>> -	 * grace period ends.
>>> +	 * This smp_mb() also pairs with smp_mb() C (or, in the case of X,
>>> +	 * Z) to prevent accesses after the synchronize_srcu() from being
>>> +	 * executed before the grace period ends.
>>>  	 */
>>> -	smp_mb(); /* A */
>>> +	if (!did_gp)
>>> +		smp_mb(); /* A */
>>> +	else
>>> +		synchronize_rcu(); /* X */
>>>  
>>>  	/*
>>>  	 * If the locks are the same as the unlocks, then there must have
>>> @@ -546,7 +559,7 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
>>>  	 * which are unlikely to be configured with an address space fully
>>>  	 * populated with memory, at least not anytime soon.
>>>  	 */
>>> -	return srcu_readers_lock_idx(ssp, idx) == unlocks;
>>> +	return srcu_readers_lock_idx(ssp, idx, did_gp, unlocks);
>>>  }
>>>  
>>

