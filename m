Return-Path: <bpf+bounces-76709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2CDCC3050
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 14:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7735D3053CB3
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 12:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14633570A6;
	Tue, 16 Dec 2025 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Wo6wqwVz";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Wo6wqwVz"
X-Original-To: bpf@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013037.outbound.protection.outlook.com [40.107.159.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4645B3563F1;
	Tue, 16 Dec 2025 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.37
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886546; cv=fail; b=YildmZATW9uf1RFINP48VbhzfHla1OkMUwQZuUkXiKaNHWB7OTDtX6ulzOH0gJ1czln+mZ2gQ4ReoGaq3/+MPS5jIsNBEXwAf6pJt/Q0GVYBSBS3RxENt0W+rTOf+1u3xL3XEsAN61S7fZC0hW82gJy2O1atBJ0oIUellR204ko=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886546; c=relaxed/simple;
	bh=blpvqmfOMLLjQpN2QipMowBzCL+kPIe0Q713JtGGsps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LXMQYTyJW1u0Bw6/paJ8GOBi9otCkNtoRsppBMjP9H7fKLuvG25ZI8YshyTiO8fxBscF6wh7gHEAnYgMmW/Wm6qliCZNTRZuSDU/Gz2rH5Bh3es3g+7vxVtIPjaeO3WSdgTUVUdBL0C3jx+lM+Efef0+SA+JzqBHRu9bTeuG2JU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=fail smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Wo6wqwVz; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Wo6wqwVz; arc=fail smtp.client-ip=40.107.159.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=OcwJI8576lFS3XXqBMyDlkXIGSavdA5vb7Cu8uvwjZ9m0ecVgxCXlkJfyrvEKKZ+wVXlPSxiGavtLw7SbIFK6iEXFhT2qPlHaWc2ez6zxu1e+OZRDcOcphhsMG3OnM/+dokwzarQWZAxDXNCGhZyoPSEFar/FCVp1JMsfeb3pN8yJ126XPsKREt4fcVI+tN0D5K7Yqby+/11vF0QE8ijJ/QXvmgefpzNizy01KW3BmWfikGUkqAv/Q38glNg84k9SNUHSiucmN+Rwlj/TR8Z8gh2RTqL2OtyGFCMCry//k4uJyKvHWDmOHr3fewwuYnhhYCSYOdwUYW3g7yBTa+v4Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4Zjr57/Giv4IpOAvRI07Axe4r6own+hr0getgeEwPQ=;
 b=k/a5QJK2g41VHsL5JvURsATjHSWWdgqy3wJtLSV/AF0bSHdyhsjbIEMMgNuRs1WMiCIajAjJwbMUqXpOVc+p9o+kBPdPFM97O1CRAjXLhhSjMM6TlAPxT3+OwRLL7LQyRdN8NmeItIxNUNCb4FmATJi8HSLJL3pSYQNcuzAA5Z0IYxqUEWu2IiltZ3XePvl9vJNENZNBUKud0yCrvZXYPEkXcWBkzSmZ8YZasn1gmegI89nX8SWUCbut8gT4u0PG90bkoNjsA+XS0LRMqVc+Shs8Zjx44AD5R26f7n0Rvl3WofQ/q1N6ExmNjubwxNOjnTTy2oZ/LiNIAmF0EvRbqg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=google.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4Zjr57/Giv4IpOAvRI07Axe4r6own+hr0getgeEwPQ=;
 b=Wo6wqwVz0MUPr2XDYrofJ5aecnMNDVrUeSSAaGlnaQ5TuquqIdSZ6sI6mv3oOP+0UBCAQCXpwkz8v2TtRPtNnP854Ytbfm5RAT85gvw3ph+JC2mFH8M9u13okwGYNPHMlQy+n7QHLIW4Atqa4tDKTIOHLJwCry9JLu99kG6YdaU=
Received: from DB8P191CA0015.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::25)
 by AS8PR08MB8898.eurprd08.prod.outlook.com (2603:10a6:20b:5b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 12:02:15 +0000
Received: from DB3PEPF0000885E.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::bb) by DB8P191CA0015.outlook.office365.com
 (2603:10a6:10:130::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 12:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885E.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6
 via Frontend Transport; Tue, 16 Dec 2025 12:02:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBrkr/ztPiYGa/e6U65o+oEeRND124OhPXXP9hoJfEYqf0zcRayjYezMB33hsvUYPBU9fkopgFA/y2braPE/fML9Jphg1X+7ovddqamr6/d7yMhQHFywTehEGH9Eb6lX50yVWlHJGrz//bYR53LTx5PLcmtph14w1Jnl1RMeu5Zn/x/MpvANcny/VeGb17x9/pC6AZlQqoliPcpxea+vINWcSLx7n6HZJgC65rJgmrb6Z5Umnqxu8bZ/nHHqJozRZXRfKtBh2D5gRTLcff4mMeWLydr14DfYNjlxlWrpx0HgVuFWlgkRGsbi3Qsw/jBbhMWDRrEoi6Olq1iOPie2iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4Zjr57/Giv4IpOAvRI07Axe4r6own+hr0getgeEwPQ=;
 b=fAbITRJi3gUzpI5YZvHol1lYjYe85/SuLlczlSHJiRrrpKU3ujfu+l0S+DStF4gONoWSV2upNoandudUWP5Ac5+bYaJ3nezJhiOX8/rphQVxx9DEbM70YJSHM0VfwnLE7mV6ryzJ9oIRDFGdEpRD+R2setTBS2nJAdW9SLL+dxmHne5AUhCURBKl2rYn45pEZCz/CBLU0nyPla+2nT10UvZrRLxk25PAWVyAf07HL1efQbGYbCgESDXhBGoUtq17/NnH0LF7PN43BkbbU9RafPk0a3T3ylCVx2GhwwRNRd0S0Z1y7/BoJyaYAxJkQ/R5/isdlVbV5W50qQUWWPMPQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4Zjr57/Giv4IpOAvRI07Axe4r6own+hr0getgeEwPQ=;
 b=Wo6wqwVz0MUPr2XDYrofJ5aecnMNDVrUeSSAaGlnaQ5TuquqIdSZ6sI6mv3oOP+0UBCAQCXpwkz8v2TtRPtNnP854Ytbfm5RAT85gvw3ph+JC2mFH8M9u13okwGYNPHMlQy+n7QHLIW4Atqa4tDKTIOHLJwCry9JLu99kG6YdaU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS2PR08MB8951.eurprd08.prod.outlook.com
 (2603:10a6:20b:5fa::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 12:01:09 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 12:01:09 +0000
Date: Tue, 16 Dec 2025 12:01:05 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, hannes@cmpxchg.org,
	ziy@nvidia.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
	rostedt@goodmis.org, catalin.marinas@arm.com, will@kernel.org,
	ryan.roberts@arm.com, kevin.brodsky@arm.com, dev.jain@arm.com,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: mmu: use pagetable_alloc_nolock() while
 stop_machine()
Message-ID: <aUFKAdPY3zTlPmnr@e129823.arm.com>
References: <20251212161832.2067134-3-yeoreum.yun@arm.com>
 <CA+i-1C2e7QNTy5u=HF7tLsLXLq4xYbMTCbNjWGAxHz4uwgR05g@mail.gmail.com>
 <aT5/y3cSGIzi2K+m@e129823.arm.com>
 <DEYOI8H2OESD.1H56D3H8HKILB@google.com>
 <aT/WOAr4osoJWaMS@e129823.arm.com>
 <DEYP7JSVTB9D.3EFN2KEHH3O79@google.com>
 <aT/drjN1BkvyAGoi@e129823.arm.com>
 <DEZK5U2YP6I0.27VJHSVK14646@google.com>
 <aUE8bwUVa6jSUft1@e129823.arm.com>
 <DEZLRT59S25H.2YWTZ2G0TN3HV@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DEZLRT59S25H.2YWTZ2G0TN3HV@google.com>
X-ClientProxiedBy: LO4P123CA0336.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::17) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS2PR08MB8951:EE_|DB3PEPF0000885E:EE_|AS8PR08MB8898:EE_
X-MS-Office365-Filtering-Correlation-Id: 925cc9e4-f389-405d-511e-08de3c9af410
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?c2JrRCtKaUNMVHUzRXk2TjFMNnFVR1hVVzZVNDRnSjhxNDlweDd5ZDN2R0w5?=
 =?utf-8?B?RUJwWTVCMWdkSzBQSXFiZ0ZIN1Rxd2NpdXZxWHB2L0s0dFBuVktaNWZwcDFE?=
 =?utf-8?B?d242VE4rT2Q1dkwwWXl2czFCSGtRU3ZWMjZZeHJkdm9STXNCckVFVXpqTVhj?=
 =?utf-8?B?eGw0aXZYMWJxdzRRdUh6aU9UYSsxd3p6UnIyOGwzbjZYN05HSjY3bm1wYkFj?=
 =?utf-8?B?T2hpMStVWDB1Tkt2cmU1VDR1V1FVZStwcncxU3pBbnJRTTRnckhETWRneUNL?=
 =?utf-8?B?MXU1Ky9XZG1IaldEV2R4SmVlKytFeHYrU1A4ZmdJdmxwRURYd0dZa1VVY1pN?=
 =?utf-8?B?eWZzMVMzaXY3cG9xdWRaV2ZtOEc1eURoMVVYdG04cUJ4SlcyV1ZVKzEzWDdG?=
 =?utf-8?B?b1ZRUGdIWVBualRFdENGa3hjSWhnODFxVlR0WktLRE5hcCtRajM5dndHN0px?=
 =?utf-8?B?NVRrM1l2TVR4dG5WY0Z6VWc4WDBoRVhmQ2ZMb1FwS1JXam0vUWdzbjRJVEJE?=
 =?utf-8?B?YmpqUWw1ckZ5RE50czRSRUpjd1JwZlpKTlJIMWZwSlE3MHM0WGNjaE9rdUJ2?=
 =?utf-8?B?SkdMd2lGTmNPMUdKc2o1OXZKYkF1dVdBRHRuSDRkVXMyV0lsT2dJUFlGQmd1?=
 =?utf-8?B?MHdnWWxsVjl4dkN4bzE4RVZmWDFjRmtpK1BqQ21qMm00YkFaSHQxSE8vR0lC?=
 =?utf-8?B?eDJzdlVDdWhQOVFwbnY3a2J0NUJnVHVSV1ZWZ2Y5ZTRycVozUXZ2MFdtdGRq?=
 =?utf-8?B?VGMxcEpsb3Z0aFBxVm9ldTdVUitkeGdjNmRIeVV4WlJzOHFnTlhyODB2NWVT?=
 =?utf-8?B?RTduK09vYXg4S3Z0MTVlOTBBLzVkZGhCcEcyOStsL2FlNkEvM0kxTFZ4WlBr?=
 =?utf-8?B?RXA3czRZM2cwL2VtNC82eGFISENZdlVpNXlpR2thU1Z6RUZzR0JHd1VDY2xj?=
 =?utf-8?B?Z2xqR0hVbWxlMHZsNkI1R2RNRUFLaXg0dzV2NjdzK09GY1djZzNIeWh5bVFR?=
 =?utf-8?B?U1pxQ1RUejVLTWJtMENmM1hQU1pCaFVvZU1kVnQrTmd1OG5wQlF4Rkcyczkr?=
 =?utf-8?B?dytPNEZCWGFrRmpkN012SVRZMG5FNWtoRFlRSG5hcHdXUFEvSUZHa3VvdHpZ?=
 =?utf-8?B?dHR5aWkwYzZGMUpYN3RIVDNxSjJqdlM1OEtqUnluTCtrWFkzOURSamU2K2JK?=
 =?utf-8?B?ZTJwWlQ5VThoR2tlVEhmbVBjaFNGOUszYzd4UVJzZHVhdXlIa2RqZGl0bWtr?=
 =?utf-8?B?amRBbTFTSktzNHJoeTdQWkxzS01KVGRXS0NPcGtEUWZ6VUh5c2NhZW1BUGhl?=
 =?utf-8?B?SjZnOE9reFNFWk5qTVFCM2QwY01MemZwRHpFZERsL1lidUxZd3FjUlFpL0hY?=
 =?utf-8?B?b0p2R2VvcmVzNW0vRnNBbmpwUU5hYyt3T2FFUjMrbDhFZTdGVzVaQnFmdXBv?=
 =?utf-8?B?ekFPd3BnMkd5aCtzVlRmUkhmVVZKZFVuSW5Xb3ZPN2RRM1M1VVpqYVhSVjha?=
 =?utf-8?B?NERrRDllcXk2aEdJLzJ2cTNGR0FiUEpYWVNtOUxtQzJOR1JQWHJtLzYzYk0x?=
 =?utf-8?B?cHRrZXpjUmpOL2U4dGQ0NXF4Vm9nM3g2NElaY3UwdDB1OXpsY2V2SU9ETkty?=
 =?utf-8?B?TDd4WDRDR1ZDQ05wYUp3RUV5WFNtWXg0NlUzVlJRcVpaOVVkQnVDK1psZnhD?=
 =?utf-8?B?WTdhaCs3bklYN0htNjlRQ3QxRkM2Sm5ucE9NQ1laVTF2Zm13cU9RUFBmUTVr?=
 =?utf-8?B?SHNhbjF6dnFHdGtSVW9PM2lYanRuUUpwTk55QmFMZ1RSZmJ5c2s3S2hMYlR6?=
 =?utf-8?B?VVBDcU9qc2h1QmEyMGVHODM2L2I0azhYbjhWaTdscW1iTU1jRTQ3S1BESEVW?=
 =?utf-8?B?bmVmSDRSdnBDK2FFQUZtait4K0o1MHRxZDlXRTlOUFFJZW1KQUlhU1JHSmts?=
 =?utf-8?Q?MbN1q2tw4lCFnJDMSb1fCUt0xlJ4W7ff?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8951
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e05d8b4d-5418-4837-0d64-08de3c9accc5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|82310400026|376014|7416014|36860700013|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUJibTY1Q3g2eDc2azUzSGZDb2ZXK0dsa2FyWUZnNDMrUk53OUppV3kyT0ly?=
 =?utf-8?B?Nm9UeWJDcVdxajdiTEUrVWkrZUJ2czQ0bzFTOVB2M2V1S3dvTjVRb0dnTExr?=
 =?utf-8?B?eHEvMzBQaW1ER2hSdWI2cGhyMkpPTG9qaTB1WU9MWVliaDlwSk9zemFST1pY?=
 =?utf-8?B?cGhOTHY5c2dRNGg1UjdOcHN0b2RIS3dqbmtEMXdUR0ZCMDBnZzVyek1oSWZZ?=
 =?utf-8?B?Q2pLeVdqZmxHUk4xdHBCTFdEaHlOamxlRnpCU0dTK0lyRFlNMXA2WnRsbHVx?=
 =?utf-8?B?K0VpbDM3UC9OUUhzN1crMWJwYlkyRkdJWndYS3crWDBxL0Fqa2xJOFJweStw?=
 =?utf-8?B?TkNlOVYzWlR2emczbmZyZEFlcmp6SHRPRENpcmgxbGRXNGxLaTJkcXozcEJW?=
 =?utf-8?B?eVVNYXRxMUw0eVFOTmNYanB3OGE4M0tROC81Q01PRzN4NkNRN0drd1ZDWm5F?=
 =?utf-8?B?Q1hvVjRNeFdXNkFzNVRLSnBTTlJVaUZqaDFNQkwvUVd4bndTTkhGUkI1c0Vi?=
 =?utf-8?B?d2xnQ3FGeWdpT3EvS256dGdPWG5HZGdEcW9VMkJRRUs3NmtUWVhGZm5sZzhp?=
 =?utf-8?B?UTI5YzlnR1NTaUJqY05DSDdqSVY4amo5Yng2OE82eExRVnR1bllxb1lFWVYx?=
 =?utf-8?B?enZFblhmcE42WkpmYnlSdzhIVSsrYUFhUCtsVGdRRTdMU1hzcXNXMk9SczQz?=
 =?utf-8?B?azA2Ly9CbjUwSkpUWFhNTmN4Vkt4Y1Nyd1ZlSWFodEpPck4rVVhudDZaTEJ3?=
 =?utf-8?B?VGpzd0s4YlNKamZ5b1NnVWFmeVhROGJEd3ZlS0ZkWWlKUUt1QUZJcGlrK3N1?=
 =?utf-8?B?U2xNY0dkRDJLZUluMDd2QU5aOStpZUkyM0JhaU9hSlZROUh4VlB1Zk9qZkpY?=
 =?utf-8?B?NDQxckxac2pLVUhRTXduRGc2cndWRytiakx0bEhRZFdOY0w5UTI3M1E3MUt6?=
 =?utf-8?B?NExUb3pTQ1c5T25STksrYmVranN1bEFtcG1FSFBhL1Arckg4aWNZSGdDZEw2?=
 =?utf-8?B?bldkK2F6RXd5TFBMeElWRmpPbktPU2dIbG8xU0RoTGE0VFE4RUZaTE80UHlX?=
 =?utf-8?B?MW5Fc1pCaENEMHJHTDhhOXdVbVNPZkNxQ0t2YkMrMkdMTERvaXFCdjBmNDVS?=
 =?utf-8?B?cVJDZnhPa2lTWDY4a1VrMjRENHBRVkVCYnVrWm1pS0l3RlAwM3BYRVZRTEhJ?=
 =?utf-8?B?eVpvd1ZRMTJyaGFxeUJtbU01YjUrelAwT2U2N0NLWGJSeGEyY1gxbk01cDEz?=
 =?utf-8?B?KzdUUU5GOVZ1LzZ2Q2xrWHFXSzhnRklFOUJQZUJoaDd5b0x6ZXZjQnBUL2dL?=
 =?utf-8?B?OE9uSVRLWFVaRTNMZ2tDRVk2cnhMRExYT1NGbjNEMHNxeUdNa090M3NQNmNx?=
 =?utf-8?B?RDI1YzRnTFdPTmZpSUh1R2xRQnkwaGZ6T3pQS2pPTmZBcHM2Y2xGUlhXUWdK?=
 =?utf-8?B?YUMvckdjSFYxS244d1NMUUZYdnpHek1Tem9Uakd1QVg2R1FPV3F3Z0hVanI2?=
 =?utf-8?B?M1JGdzlKSmxMRTJmNEtYT1QvNVVxQUNKbk1ENG11MENmTm5nV0U5ZC92WCtz?=
 =?utf-8?B?bFd1MnR0ZGJjV2tVSFR5bWRnL05lbXBnUTU4SUhxaHR1dzNZbnZxUGxPc2hp?=
 =?utf-8?B?YWVVYjdCQnhjN1lKM3lTdnVGZWIwVFhJVmUyOTQ2akQxRVVwdHJCc2lSUjJK?=
 =?utf-8?B?TGF6dnZhSmRhUlpaL2RaRnRlbWJ1Wm5qdUJyMXdUYWlkUkRvR1BzUUx5bXNT?=
 =?utf-8?B?ak1DRXpjQ1Y1WHNBYmFsL25wN0ludGFYWGFESk5xSWdIOUtFbHc5MHNQYWVW?=
 =?utf-8?B?dUlPaHdPVlV5THdkU1pxOWkvY1Q4QUZXdXZ3blJacDhlV1VlejZHWFVwekJ4?=
 =?utf-8?B?UktTbDB4U1ZIQnlzWFBuY3gzMWtxMGNIY3ZzRHFXdDcxQ3k1ems0UWxaK2lL?=
 =?utf-8?B?TkUwQ2tydmdleTlvamkvMDYxWmFteEZDMXdiMjV4RGtXbEdrdHN3Z0p2TkxR?=
 =?utf-8?B?eXZZRm1ta0gxM3RCTGxUeURhRjBaM0NTSURha3kvRHVPSmNGckxTalU3d3FB?=
 =?utf-8?B?TXRCUjVpSVhrOURsMkwwd05WL1N3SHBNcTJXUmJxa2taN0w2UnBTSDk0V1o3?=
 =?utf-8?Q?AfM4=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(82310400026)(376014)(7416014)(36860700013)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 12:02:14.9735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 925cc9e4-f389-405d-511e-08de3c9af410
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8898

> On Tue Dec 16, 2025 at 11:03 AM UTC, Yeoreum Yun wrote:
> > Hi Brendan,
> >
> >> On Mon Dec 15, 2025 at 10:06 AM UTC, Yeoreum Yun wrote:
> >> [snip]
> >> >> Overall I am feeling a bit uncomfortable about this use of _nolock, but
> >> >> I am also feeling pretty ignorant about PREEMPT_RT and also about this
> >> >> arm64 code, so I am hesitant to suggest alternatives, I hope someone
> >> >> else can offer some input here...
> >> >
> >> > I understand. However, as I mentioned earlier,
> >> > my main intention was to hear opinions specifically about memory contention.
> >> >
> >> > That said, if there is no memory contention,
> >> > I don’t think using the _nolock API is necessarily a bad approach.
> >>
> >>
> >> > In fact, I believe a bigger issue is that, under PREEMPT_RT,
> >> > code that uses the regular memory allocation APIs may give users the false impression
> >> > that those APIs are “safe to use,” even though they are not.
> >>
> >> Yeah, I share this concern. I would bet I have written code that's
> >> broken under PREEMPT_RT (luckily only in Google's kernel fork). The
> >> comment for GFP_ATOMIC says:
> >>
> >>  * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
> >>  * watermark is applied to allow access to "atomic reserves".
> >>  * The current implementation doesn't support NMI and few other strict
> >>  * non-preemptive contexts (e.g. raw_spin_lock). The same applies to %GFP_NOWAIT.
> >>
> >> It kinda sounds like it's supposed to be OK to use GFP_ATOMIC in a
> >> normal preempt_disable() context. So do you know exactly why it's
> >> invalid to use it in this stop_machine() context here? Maybe we need to
> >> update this comment.
> >
> > In non-PREEMPT_RT configurations, this is fine to use.
> > However, in PREEMPT_RT, it should not be used because
> > spin_lock becomes a sleepable lock backed by an rt-mutex.
> >
> > From Documentation/locking/locktypes.rst:
> >
> >   The fact that PREEMPT_RT changes the lock category of spinlock_t and
> >   rwlock_t from spinning to sleeping.
> >
> > As you know, all locks related to memory allocation
> > (e.g., zone_lock, PCP locks, etc.) use spin_lock,
> > which becomes sleepable under PREEMPT_RT.
> >
> > The callback of stop_machine() is executed in a preemption-disabled context
> > (see cpu_stopper_thread()). In this context, if it fails to acquire a spinlock
> > during memory allocation,
> > the task would be able to go to sleep while preemption is disabled,
> > which is an obviously problematic situation.
>
> But this is what I mean, doesn't this sound like the GFP_ATOMIC comment
> I quoted is wrong (or at least, it implies things which are wrong)? The
> comment refers specifically to raw_spin_lock() and "strict
> non-preemptive contexts". Which sounds like it is being written with
> PREEMPT_RT in mind. But that doesn't really match what you've said.

No. I think the comment of GFP_ATOMIC is right.
It definitely said:
  The current implementation *doesn't support* NMI and few other strict
  *non-preemptive contexts (e.g. raw_spin_lock)*.

The reason It couldn't be support GFP_ATOMIC in raw_spin_lock() context
in PREEMPT_RT since critical section protected by raw_spin_lock()
is non-preemptive (preemption disabled).

This is the same reason "GFP_ATOMIC" cannot be used in the
stop_machine().

--
Sincerely,
Yeoreum Yun

