Return-Path: <bpf+bounces-76889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E93CC9253
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 18:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0398305578E
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 17:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28D63446C8;
	Wed, 17 Dec 2025 17:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TFqDMqsu";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TFqDMqsu"
X-Original-To: bpf@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB7C33AD85;
	Wed, 17 Dec 2025 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765992798; cv=fail; b=KJ/OQ6pGzP2LrZIWKuMGe081xbDwPU75AowSN0RpQTDZZVmrpzTjN6+jSJA60ED1Ea4gZiE58taGPgrsyCNn+aslILxobQE0ZrUHbdye6F6uv+EqA4a4SowInAgGP02VJ3insc7yGuugOSUTzhDYJtBkXzHks/riH2j9upMgmwI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765992798; c=relaxed/simple;
	bh=k+/6nLR8dZdXI3WdWl2IlX41Kckd6pCDi859nmOy0NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iS2NIUAcsF+eVkTUrFdz6qpLl3I4JvcDxPc4NSZKf7QthI+7eAnc8V7KGvGQJykTP5csSXayjfgN0je2O18knWXd4untSp8eXmIjNjvWOiKTT6nAyH7bnI0BGEPzzzTwrqk3Xl8p6k8bpdv+8rjZsi47EmM892HWmVRAp9/Dyfw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TFqDMqsu; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TFqDMqsu; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qRBJ8IwEZC7yVGkY4QKg97CzffzMIUZhyJOMPw8m7QB7lyubp5WV1RnoS+5TB+jHxtuES6x5Pxe/kKZPbtPi608hurRpIViU3IZao7xRdpEpuWwVKclS3Rv2I4sHqq+LjB5Fl6HkirTjpt9QoRrbu31LHJbXv6/VhSzGofZeIHCkcWh3P36GxGcH+J0uF5fTgDA9pkvP45p6TG5PM24Qk3HEz18PMNPyhlfoEmrbBc/s3PuNgCNWhqy30AH5I6+knZe3nc0S3Fb2N7a2Kfw79H64eNuOaeFCVkEbrVhpDdKtGwhaeSis2ag8La7x41ohkA//091Tqlk3uNstUt2NKQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vWx5BCTLoPer76khIZ0KZnW7j9Sd+4ljSfH1OkvVdY=;
 b=RDM6VYqMPZxrMBO8A46Qp9mAmOE8eWyig9JHpbxYgLw+PeFYR5XY3/Jj89WopHRQN1zbLj4doDIt8ElKDUJRS6jjJZVlQgwECnrigW3bqVhXjhTKAjkDG6wHLLYre/r3rB0SpPR8XLiKSft7IzdA91KK60ilO4giQ9d79dV3OcYNmDTCyxiv2eJNlhoDU5NH4myjFLuYkR2MuxixrHWBctdU2ZtnburxWCwwZ65ioAKA2OldKacUv2Q+jSL7N+4s5fDEsvFFixb4J9tkVN781553oP7VAMx6/Z2R4h+qHxBz+0URFC4AMh2Uokz9CxcQFhL866E7PQrL/snj4J7sWQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=google.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vWx5BCTLoPer76khIZ0KZnW7j9Sd+4ljSfH1OkvVdY=;
 b=TFqDMqsuircycO+l7/GsnYlTAr24Uuohb/esnlM7imJcs6ZyiEX9uGeHM/Ty/x+7xZvYENChj8mCF7Lh7gqfNIV42uoYiENAB4xW88oc6PC/PAlBxogOTtHxdW/u+Lv1Vyk0a1uh4PSExU5rFOm2Gzaz3tlRJ58Eif3YiUcfvRI=
Received: from DUZPR01CA0331.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::24) by AM8PR08MB6484.eurprd08.prod.outlook.com
 (2603:10a6:20b:357::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:57:15 +0000
Received: from DB3PEPF00008860.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::3f) by DUZPR01CA0331.outlook.office365.com
 (2603:10a6:10:4b8::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 13:57:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF00008860.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6
 via Frontend Transport; Wed, 17 Dec 2025 13:57:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIIc9kun7LY2hp/i5A7YkJByqYXcB25H5Ui03CHoFw2piBMSxz/wiG48ozp+DqWSEj/tWyBuZNd7grPGu8M0y91054NJrRNyCurZki6Q9Yk9uYCznNmc/le2QQOPJRwW0DZ4iQZWG2qqtu1iXQFxC4nSd0BlIAT+UXzoepgKLR8JMmGYuGqIvIKG3y7TxoU7ty4ZTNeuSUP8X87nQgY3kN/t7YmGYBXvFtZ1nUFIFXn1nrV2KjDnLPxSjdsVOmAlYZCXsC+mgB7qPNew4BDR7nPsUrzdpU9CILN6j62pKdSRHRRAzQ1k6bGPhdrfms4CtKc2yu1yV9uzlmcIjZMGeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vWx5BCTLoPer76khIZ0KZnW7j9Sd+4ljSfH1OkvVdY=;
 b=aSIQ8IPmrJy1lVIC6vCvUuuz0w9B/J5GF6bY4iB0R/MaQJw9PxGShMw5Vic0aQzh1C8BQq2xCGSUUfn45341dn3uIjjJLY4vLLMo1eXGNcFRvnhncgFWqyOVvmFkdbsj56vsnrGRVAx5mAwQLryQzIjj/FjOI7VUEp3TVIGhNdiDrADWI6MABL29bLMYZzxNM4Gp+0sDrLzazLZr9uMsk9aHyZfpRa2WJXBxR2VsWHC+gJCcxFC+wDnryMn352JOW51PUkaPDrwQfjcRxxbHk+DeWSLaDkzJG+wJLSrKyZ0T5Z2FTt9utXdJ7Y03qQNQuT88qJk3HQBw/blBYhkqwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vWx5BCTLoPer76khIZ0KZnW7j9Sd+4ljSfH1OkvVdY=;
 b=TFqDMqsuircycO+l7/GsnYlTAr24Uuohb/esnlM7imJcs6ZyiEX9uGeHM/Ty/x+7xZvYENChj8mCF7Lh7gqfNIV42uoYiENAB4xW88oc6PC/PAlBxogOTtHxdW/u+Lv1Vyk0a1uh4PSExU5rFOm2Gzaz3tlRJ58Eif3YiUcfvRI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GVXPR08MB10728.eurprd08.prod.outlook.com
 (2603:10a6:150:15b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:56:04 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 13:56:04 +0000
Date: Wed, 17 Dec 2025 13:56:00 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Ryan Roberts <ryan.roberts@arm.com>,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, hannes@cmpxchg.org,
	ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
	rostedt@goodmis.org, catalin.marinas@arm.com, will@kernel.org,
	kevin.brodsky@arm.com, dev.jain@arm.com,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] introduce pagetable_alloc_nolock()
Message-ID: <aUK2cALmtIUPeeWy@e129823.arm.com>
References: <20251212161832.2067134-1-yeoreum.yun@arm.com>
 <916c17ba-22b1-456e-a184-cb3f60249af7@arm.com>
 <aUGOPd7gNRf1xHEc@e129823.arm.com>
 <100cc8da-b826-4fc2-a624-746bf6fb049d@arm.com>
 <aUKKZR0u22KOPfd7@e129823.arm.com>
 <d96ac977-222e-4e8d-9487-da1306198419@arm.com>
 <aUKnfU/3FREY13g1@e129823.arm.com>
 <d912480a-5229-4efe-9336-b31acded30f5@suse.cz>
 <DF0J58HOVLL4.2E16Q87D2UXRW@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DF0J58HOVLL4.2E16Q87D2UXRW@google.com>
X-ClientProxiedBy: LO4P123CA0567.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::20) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
 GV1PR08MB10521:EE_|GVXPR08MB10728:EE_|DB3PEPF00008860:EE_|AM8PR08MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 328a592c-33d9-4312-0fb9-08de3d742e96
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?WUJXK2NLVkNPOTBMenZUOTdYQkIyMlNhazZUZnpCWWtOTnp0L1l6aWV0cmMw?=
 =?utf-8?B?Qi9sZWgwSi9EOWZHd2xKemtXclMrdUlnUWE4Q2FtU2JCek53b29QV2t1dklj?=
 =?utf-8?B?RFYzWE1YRmNWQ1F3WUVTSEhwOWJLRU10bEV3ZkR5WDdzam9xa2IrSE9yeThz?=
 =?utf-8?B?bDBHMG44UXJwTjdhM2hXemhmQ3VjNUZRVzVmaDI1K3hMSWc0ZW43ZWc2MUlF?=
 =?utf-8?B?WW15c1M3bnFFR245YzQwNmFPMDNaZ1I5NTJDNkNZYzRuNkMya3Jxem93dFlL?=
 =?utf-8?B?VlM3OUZ2MU96SmlFYjRpOWpMajQxR2hRVFZDRC85UEsydVc3NnlVcmNsSWdk?=
 =?utf-8?B?UXRHU1FWVThvZ0N1ZGZKbnAyV3M2S3h3aTdaMlB6ZTlLbTV2RmlMRVJBY2ph?=
 =?utf-8?B?YWNSU2xwYmRJNlo2UDVYdlNvc3RhY2NhcjVZZzFUSXFRLzNxUS9oSWZtR1d4?=
 =?utf-8?B?Y09kYWtqTE9icUlNNXM3azdyaEh5VzZNTDBhZ2R1VG05a1NEKzVycWdodEl0?=
 =?utf-8?B?RHA0Q0l1alpQa0JGekwyTzRlZHlzeUNaRUtGNWtHSk9ucWRBaTJSMmI4a1Fs?=
 =?utf-8?B?UHRiYjhRbURyT0tRR2kyc0gxa2syN2lZbXNlWTlFQ3E1bVR1SXdac3d3NENq?=
 =?utf-8?B?QWNnL0pZSGxOdGVlRUxLUmFjZDFLVTZTSklJcFduSVlqcXgxOC8yd0JPeC9B?=
 =?utf-8?B?SXpsOHdadU9Lanp0UzVZSUwvYUpObDRiVVpzeVQrY3lPRDVucmcwWjM2YU8x?=
 =?utf-8?B?V3UwZTF5eEcwNTJRTUYwUWpVdW9mVmFueHZTR1RlVlFvSktCc1BZV2VRTjlM?=
 =?utf-8?B?YmJFanlFRHBrVVRuWG9CeDBEVVo4bzdib2srYjhHRkVMdHQ2enBZenNxQnIw?=
 =?utf-8?B?ZkJ1SEx4V2xvcmNSZ1c3bnFJbVNwWlBoSlNJVTFlYXU1WHhVQmxvVElyQzVB?=
 =?utf-8?B?cHZaQWlYZzAwc3NtbXJuK3BjK1hocS9yYTZ3Q3huR0xKdS9tNmRnWURRSkNk?=
 =?utf-8?B?VjZ5OThLZlVIMDNSVDhOR0EzSElPUUk2NkJqQTFENzZrSTdkQXRRVTRGWXBv?=
 =?utf-8?B?YTFvYSt6cVRrOHNGZjBNZkpadU8zenlIc1FYQXV4Q0xjdU02WTh3ZnZ2eCtK?=
 =?utf-8?B?c0dSRFNTZzFFUHRoSWFuZVh6S24vdFRzV3FyendPb01QdksrbHMxb1JKTEsy?=
 =?utf-8?B?VTBETzhFc0JLRDFLZGs2eW5qcFF5dEg5WnRWakd2UEo1blh2djg5V2UydzBN?=
 =?utf-8?B?UmVua2hBbWtvU25LK25NVlhtV3JGWkl3dkQwTXByRkNBVDdOTHFPbHd2Qyt3?=
 =?utf-8?B?bUZoZFJIVWtTMjgyTFNYMWZzak5PK2I2eW9yY1QxbVVMUml6MStabXdzODQ2?=
 =?utf-8?B?VlFLWUt4ZXQ4aGVabjAzUlQwZ3N6ZkVUaDZOcmYrUGpidWVPZkJoUXMrd0ts?=
 =?utf-8?B?ZlBOQnRaZXM5OTMyU1dGSEFJREs1U1lvQU9PRlViSC8xR1JzYW1SKzFySVVM?=
 =?utf-8?B?Y1Y3ZDRuSHE1U205dGhKYTBROHE1RC9rWlo1czhlejlFWVRqRTgzbTh0Nzh6?=
 =?utf-8?B?VE9uVkJmVjhTb2wrUzNpNFE3dUozK0w3TTU0ak13dENWSW5LR0lyaXMwVkhK?=
 =?utf-8?B?SHlDRVMzdDlYbW1MZTJtenhOdjRvd0VIakNSUHdiUk84MnF1cE9aUVkzQXZI?=
 =?utf-8?B?ditRcitBdklPL0xBbFZNRFIvckphTU5OREpEWXVWbnZWK3J1T2xXVWQ3TU05?=
 =?utf-8?B?OFRaOXF6bnVoU1hJejdLL1N1a1dHOGE3S3hGSUlwU0lHQzhRc0RIOHE1TFM2?=
 =?utf-8?B?bVJvdG5wd0w4elRTa0ZpS0VkbzIrZXRCRE5QN2d6SWw2dElpMlFESVBFbkxi?=
 =?utf-8?B?L2FlVERINzVQZGdQODFyRFlUeVl5UXg4ME5RRTFpS0tBTWhHYnJTaXFXRkxL?=
 =?utf-8?B?ZkpmUVc0bWZaNmFXRFUvZHZUTTdyZlArNWhDSHNTTXArbFhTdEtTNDlzcVJz?=
 =?utf-8?B?aEp3ZlRzWmpBPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10728
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 869c9582-cb8c-4433-2fdc-08de3d7404d8
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|14060799003|36860700013|82310400026|376014|7416014|1800799024|35042699022|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?L09HMkxmcXgxamJ6eDVaVWpQZ2FnbXNYUzc4eU4ycjFnaWdlcG13Z1FiLzhi?=
 =?utf-8?B?T3MwakdQd01TbjRacFRtK3RnWkpkVE9HMW9yOE9COUp6STN3K2svei9nVFhL?=
 =?utf-8?B?U0RXdEtxaG5UY2trQ2Vwb01ZLzNUUmdxcTZ2NE1qM09MYndVOHZ4c01FNW9t?=
 =?utf-8?B?c0E1WkRXTmthUG0zUm0vbFBMY1hWR1VOeHBZMktTbGJTR25udXM5R0V0TTQ3?=
 =?utf-8?B?ZlFvTmF6SENRbFJKTHBoWVZnMzJpUmt2SE5URDdwZzNZZElqckU3akFuR0JG?=
 =?utf-8?B?M28vaE5memN2SXM4QWF5WWVKVHRQRGtGa3ZJZ2FOWWk4WmVXQjBkb1BabVdZ?=
 =?utf-8?B?ZWUxVjJ5aXZsQlNjNHZHQ2JrRFhxTll6bVJoWERiYlJvZThRM24zQWNwMm9T?=
 =?utf-8?B?TEdmbXNBdEtONzJpQ1FXS0VwMUE4QkVmamdUWVYzUTQwdlJ2d3hGRWJXeGxW?=
 =?utf-8?B?TTRmSFdVS042YXMrL3NiMnFUcmdqVEU3Zjd5Y2tpeE5naTVyMHVaYWxnL3NU?=
 =?utf-8?B?Q0xpeWV5aHY4Q2VXUzlhWitHZG5VYjR2SFB4THo5Ri8yUEhxaElpR3pFSmFv?=
 =?utf-8?B?V1VGc09ZRkpSTldYTktxM2FDby9NV2V6dTJNbTBBMVlVWW03V2hRR1ZscE94?=
 =?utf-8?B?YVZiUXFCR0JOVTk0c0NWcTFLenJreEFmdEVaczkzaG1PRncrd3lLeEs5V0ZK?=
 =?utf-8?B?cVI2cFRQSjBGODZnaUIrK0orQUdsU2pIVnMzU1Y2ZFV3NnpiVTNPUGV2Q3NH?=
 =?utf-8?B?L2xmVzVjUHRTMWtiTGV3bllSTFpVOW12TnJOSGpVS3dvQzdQdnpSWEE0NlFE?=
 =?utf-8?B?ZGZHRkx5WkhSNDJXOE1PWjJRdmRQK0hQMTF1bzQwcUkyRXFpT0xFaUUwK0RK?=
 =?utf-8?B?MmRSNndxK1VkNEV0dWJDMVovUHliL1owK1hIeWhLd3Fnd2djZXdMYkJ6Znpi?=
 =?utf-8?B?dFJmYWtFamswQ2lFUDlkY2xKVEo0Z280bDdJTnV6cm00OE8zeXRrSGFhTENP?=
 =?utf-8?B?OFhuQjEvVWhOMWZ5cndRQk1aamdzOFc2YUlZbHU5ck9LZkZhUkpUbG51d3k3?=
 =?utf-8?B?cjBxYUZ2d0pTM2txSndGR0NFTW5GM3hJVGFWeGp4Rk1SUVdFbzRjOURubE5y?=
 =?utf-8?B?VGVYWG5tcE93VGhCU3BpeldQbzJtaDJJLy9rQ2pYdERyQnlseEI1b0NLS1Bl?=
 =?utf-8?B?RVp1QXhycVJRWHRXK1JuMG92YmtTVHI5MDdpak01ZWJENVVrQkJnMkZ1Rldk?=
 =?utf-8?B?TS9GU2EwUU9NNXZwOHl0OTM2QnJhdmNySzlHUmVYWStFZHdxVHg0TVRTWUtY?=
 =?utf-8?B?cnRVZDNzayt5clErVEh5aGNiRk9Wd3RsU05hRnJ6U3NhenNpVVo4K3orM1ZN?=
 =?utf-8?B?U0VmUzZqeGZyeStNemZXL1JObTlQMUhLZ1Q2Q295YWMwN3BXbUtLKytBZVNp?=
 =?utf-8?B?dmxSNDJLSGxQaEtxNVFYbmptWWthcXhCRW1UUXRyOGhERmc1aHZUU3pLU0xr?=
 =?utf-8?B?OHFOeUh2YzNrZzdNaFlJSTdCTDZwTmo5dWNnd1FzUUhSMXg0Q01tSENRbk9u?=
 =?utf-8?B?dkdoVTlGa1BacmhuaWR0SC9mWUZrL25jSTdrWGlrRXB2RS9xMU9vTWZUWGxx?=
 =?utf-8?B?SlNROWNxN0ZqSHlQWmxWM3BBNDBzcEVxWDJ1dVZNLy9Fck5OdElWVEpIeVk3?=
 =?utf-8?B?ckoxWlFQSHJTRXhjV0lLdDhjMGRSRk1xUmsxZ3lkdTRURzc3NVEvaTZzbTJN?=
 =?utf-8?B?WWQ2RzMvcWRLc0pOUUxZb1Z5aHZOdTFLb0tybkN4cXFvOVdKUG9YRDFJenRw?=
 =?utf-8?B?TTFiMlc3M1pPeXloT21yMlBoYU9ZcGVYaDlkeHBuMGNBV1FxbzZsSTdUa2tK?=
 =?utf-8?B?UlloWFFqYU1IUS9JbXBPV3NYeVFORDFSaVp2ZGwzaTc3S2UyOEFYWWhER3FZ?=
 =?utf-8?B?VnNnSmdrbkhUcnYybVNQZHFmNTIxMDdwRnpSazRRVXJaOGpjdkpwK0NWcDRy?=
 =?utf-8?B?eGxzaVI3NUVYc3ZCckRDL0FENGRCMmc2MTdxVE5XVUVxMnMwdENoV3NxTHhl?=
 =?utf-8?B?a0RUQXRKeFNsNnV3KzNyeG53dEFxL09GNkZXUTQzSzRsZmhZRTlUT3h3QnR4?=
 =?utf-8?Q?2wwI=3D?=
X-Forefront-Antispam-Report:
 CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(36860700013)(82310400026)(376014)(7416014)(1800799024)(35042699022)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:57:13.9466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 328a592c-33d9-4312-0fb9-08de3d742e96
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
 DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6484

[...]

> > Note this is explained in Documentation/core-api/real-time/differences.rst:
> >
> > Memory allocation
> > -----------------
> >
> > The memory allocation APIs, such as kmalloc() and alloc_pages(), require a
> > gfp_t flag to indicate the allocation context. On non-PREEMPT_RT kernels, it is
> > necessary to use GFP_ATOMIC when allocating memory from interrupt context or
> > from sections where preemption is disabled. This is because the allocator must
> > not sleep in these contexts waiting for memory to become available.
> >
> > However, this approach does not work on PREEMPT_RT kernels. The memory
> > allocator in PREEMPT_RT uses sleeping locks internally, which cannot be
> > acquired when preemption is disabled. Fortunately, this is generally not a
> > problem, because PREEMPT_RT moves most contexts that would traditionally run
> > with preemption or interrupts disabled into threaded context, where sleeping is
> > allowed.
> >
> > What remains problematic is code that explicitly disables preemption or
> > interrupts. In such cases, memory allocation must be performed outside the
> > critical section.
> >
> > This restriction also applies to memory deallocation routines such as kfree()
> > and free_pages(), which may also involve internal locking and must not be
> > called from non-preemptible contexts.
>
> Oh, thanks for pointing to that, I had never read that before (oops).
>
> Shall we point to this from the doc-comment? Something like the below.
>
> BTW, Yeorum, assuming you care about PREEMPT_RT, maybe you can get
> Sparse to find some other bugs of this nature? Or if not, plain old
> Coccinelle would probably find a few.

That's good idea. I'll try to sparse later.

Although this is a slightly different topic, based on Ryan’s suggestion,
I plan to address this misuse on arm64 by switching to pre-allocated pages.
As a result, I will remove the pgtable_alloc_nolock() interface.

> From 4c6b4d4cb08aee9559d02a348b9ecf799142c96f Mon Sep 17 00:00:00 2001
> From: Brendan Jackman <jackmanb@google.com>
> Date: Wed, 17 Dec 2025 13:26:28 +0000
> Subject: [PATCH] mm: clarify GFP_ATOMIC/GFP_NOWAIT doc-comment
>
> The current description of contexts where it's invalid to make
> GFP_ATOMIC and GFP_NOWAIT calls is rather vague.
>
> Replace this with a direct description of the actual contexts of concern
> and refer to the RT docs where this is explained more discursively.
>
> While rejigging this prose, also move the documentation of GFP_NOWAIT to
> the GFP_NOWAIT section.
>
> Link: https://lore.kernel.org/all/d912480a-5229-4efe-9336-b31acded30f5@suse.cz/
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  include/linux/gfp_types.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> index 3de43b12209ee..07a378542caf2 100644
> --- a/include/linux/gfp_types.h
> +++ b/include/linux/gfp_types.h
> @@ -309,8 +309,10 @@ enum {
>   *
>   * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
>   * watermark is applied to allow access to "atomic reserves".
> - * The current implementation doesn't support NMI and few other strict
> - * non-preemptive contexts (e.g. raw_spin_lock). The same applies to %GFP_NOWAIT.
> + * The current implementation doesn't support NMI, nor contexts that disable
> + * preemption under PREEMPT_RT. This includes raw_spin_lock() and plain
> + * preempt_disable() - see Documentation/core-api/real-time/differences.rst for
> + * more info.
>   *
>   * %GFP_KERNEL is typical for kernel-internal allocations. The caller requires
>   * %ZONE_NORMAL or a lower zone for direct access but can direct reclaim.
> @@ -321,6 +323,7 @@ enum {
>   * %GFP_NOWAIT is for kernel allocations that should not stall for direct
>   * reclaim, start physical IO or use any filesystem callback.  It is very
>   * likely to fail to allocate memory, even for very small allocations.
> + * The same restrictions on calling contexts apply as for %GFP_ATOMIC.
>   *
>   * %GFP_NOIO will use direct reclaim to discard clean pages or slab pages
>   * that do not require the starting of any physical IO.
> --
> 2.50.1

This patch looks good to me. Feel free to add:

Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>

--
Sincerely,
Yeoreum Yun

