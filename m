Return-Path: <bpf+bounces-76722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8A4CC47DD
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 17:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0743307DF15
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 16:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8CF2727E3;
	Tue, 16 Dec 2025 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KsTZiLdg";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KsTZiLdg"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654871A254E;
	Tue, 16 Dec 2025 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.62
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765904009; cv=fail; b=ZDnpT0GHJYmJJRPWPq15Z/DdpCEgcPeA2C/auONvp0/dQrANEy0Ox1qzsaZsXCzl1sp0cTBGMWA7HMtFdigtqpQN2wevHqEpvLtRTVs7D7jBYaarp2C9a6J/d2IZ+PBHPJmR4EEhnpvpAFGyu1C//clGKjkwQ6oD2vVX4JNAi2g=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765904009; c=relaxed/simple;
	bh=UPZT++tFxjKoTMPpu4wfoZy8Q725TzXf18Fj5EgO7Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sjZNAe51CdKdLDT1fe53eq4GoS0gc9+0G+Cvtb8fD3xTTsHkN6d9oF4oGwlWiTMD2YIupCr2/t8+87VPIgJzCpXtLs1AfQc6ZNTq6dSzEc9Km+ljagqNzD/pE4Zn+89EFRjfNjtDYoO18F0ABp32TKsO5crKRy7koVaf9M6XlBE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KsTZiLdg; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KsTZiLdg; arc=fail smtp.client-ip=52.101.70.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=CXhMu2LKCif54qEdz51OK5bZDu24REY0CJK5VEGdAgyWMcPNUJ2muBRIf3yGeIRvmneFWfx6uyT3GFAVmdNjNB741QZQ6gX0078Y8kNHV9CCw9uG6SKGrZMtsTqwIEHeSQI4d6xt/zE96GjUz8IPdqGcrwSC/7vjcnyjJnWdlWlA2Eh4luUP+j336+N3suUA3xWkBfOT5XktQSiLFgD0JPQmW9WL+P5nyfQY5gHSPlmmt7DniKLZBSNUm2Ub5r6LqovvhNHJSJR/I6CDNeTrsF5Odvh5sH8RrnPXBoyAf71NGciaDguHMP92es4xjrUQ5bZtCnT6oUYrmUe46pEvFQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+4kd+iCcgRloDAQ146EP39t5yWYMIvrTdSJ/X+gTTI=;
 b=OkR76lIkR+N+Qy4+3qdZx8fpU3xNJGK1bS6yum+yA+sokdjJUyelvWa2RAhqRLMZc5oCR5QtTHMDDak306qX7fCH9yVg8WDFlS1xRNH4eV8hauNd+FlDELyW8VPSLincx5cb3J2zKYpBIfPXUozoWoLcab49PdtTdHFphbNWUR2n1dpR0by81kuESmjip7SCjOj7vyqBxzCqzjUMYXA3nkbRrpUTFpPMa/RaVHPdhfjxyTM6ngXUpzVSldYaDeLv72UXBRFsszAm2AlF/MXW5TsKLk2AAl+uzSGfUDj4Jgb0Ts+eK4matkSjfQ3Vlu10nmogqP26VQ59rCueQTGN/g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+4kd+iCcgRloDAQ146EP39t5yWYMIvrTdSJ/X+gTTI=;
 b=KsTZiLdgZW8COsLWPicFU4FyiIazCZM6lFpLzbQ0Raxlddnx/8RSWMQzB3hEr7Y7KVoEDZ6BFCTKmFALW7dYyJrYB3d1mWAVnUK+iwAoXuNdTZIMlRae4/e5lmRKUtU6cH+mnyQriJnM+QWT1Wpjon09V4Ys3GPnQj5hWXCDRPE=
Received: from AM8P191CA0001.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::6)
 by AM8PR08MB6545.eurprd08.prod.outlook.com (2603:10a6:20b:368::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 16:53:21 +0000
Received: from AMS0EPF000001B3.eurprd05.prod.outlook.com
 (2603:10a6:20b:21a:cafe::12) by AM8P191CA0001.outlook.office365.com
 (2603:10a6:20b:21a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 16:53:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B3.mail.protection.outlook.com (10.167.16.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6
 via Frontend Transport; Tue, 16 Dec 2025 16:53:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRDE24X5oDu8EKU/lgaGi2bslP0twI4eBRy4FVUF0Kb3GJIgeMt3sbDrq03D1uBpLyVn+t0CDwtWrBSxyAQb9VWHXtkD3xOooDPBeXANiZMMKyfuuYSW4NF0CoSQCz6hedV7DrLrKB98KieOXILxSHQWt3lN5932miadJVZQgTuRPLBVw6l6xKYDRlK6xZF84LKz0ZvuoWBHrsEtDAsUxYz8GEgJ/GxbVgAYyq81NhTCc48QnnnT3En69s1LCyHLl79XQZE7UyKj4cpxgxU7n7e0Mn7ukYA/PaHQTPKTfUgFxBa8tLW7q52vnVbF8SsnvKdSPJp2OwmnAbiNpFe48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+4kd+iCcgRloDAQ146EP39t5yWYMIvrTdSJ/X+gTTI=;
 b=Di4JtOquK5RV7B/0+N1ULIcsPY4Z4l1DDSOQpFMfFQtNFzi5Oc53U3dY7cXkR1Z2d1OCp2a0wHYaP+zY8dOZSwNdh5DZ9Qj1lgo2W7Npuz5WZ8nWoE3mL5c/QbDve+ix+Y0CE3ZKG5dZuGnxbSKFxQbmFBB7Xct9lPiIqEsAQvfD9YjW2lXuQNV3nzbptqs7wLNr62JihX0fHbWOJBLxc1oiJvCHB+HKbkZhL+1VIUrqHF/UF0u8O2/iFpPrkbAUhp77uyURficlK0Cl0CWYVPZs6QRdm5hV1u2pB2+wzrqH3Q0UCka9jgt8Ixs9IDlYWkOr2/C67vXrDiNS0ZjpAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+4kd+iCcgRloDAQ146EP39t5yWYMIvrTdSJ/X+gTTI=;
 b=KsTZiLdgZW8COsLWPicFU4FyiIazCZM6lFpLzbQ0Raxlddnx/8RSWMQzB3hEr7Y7KVoEDZ6BFCTKmFALW7dYyJrYB3d1mWAVnUK+iwAoXuNdTZIMlRae4/e5lmRKUtU6cH+mnyQriJnM+QWT1Wpjon09V4Ys3GPnQj5hWXCDRPE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PA6PR08MB10526.eurprd08.prod.outlook.com
 (2603:10a6:102:3d5::16) by AS8PR08MB10003.eurprd08.prod.outlook.com
 (2603:10a6:20b:63a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 16:52:16 +0000
Received: from PA6PR08MB10526.eurprd08.prod.outlook.com
 ([fe80::b3fc:bdd1:c52c:6d95]) by PA6PR08MB10526.eurprd08.prod.outlook.com
 ([fe80::b3fc:bdd1:c52c:6d95%5]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 16:52:16 +0000
Date: Tue, 16 Dec 2025 16:52:13 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, jackmanb@google.com,
	hannes@cmpxchg.org, ziy@nvidia.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org, catalin.marinas@arm.com,
	will@kernel.org, kevin.brodsky@arm.com, dev.jain@arm.com,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] introduce pagetable_alloc_nolock()
Message-ID: <aUGOPd7gNRf1xHEc@e129823.arm.com>
References: <20251212161832.2067134-1-yeoreum.yun@arm.com>
 <916c17ba-22b1-456e-a184-cb3f60249af7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <916c17ba-22b1-456e-a184-cb3f60249af7@arm.com>
X-ClientProxiedBy: LO2P265CA0300.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::24) To PA6PR08MB10526.eurprd08.prod.outlook.com
 (2603:10a6:102:3d5::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PA6PR08MB10526:EE_|AS8PR08MB10003:EE_|AMS0EPF000001B3:EE_|AM8PR08MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: e68d0115-8d81-4cc2-c154-08de3cc39ef4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?S1FtZjZYVExsQ1FlTkQ1bTV4QkZ3RkFYMk1Yb3poMy9xU0ZzaU1YdEZPTjFv?=
 =?utf-8?B?RnFub0VGbUFoSEpGUGpScHF0L1pRdVJNdkR4OEFyYWhUY29aTjgrUW5uTDZE?=
 =?utf-8?B?N2tIMHhzNzluSWNqQ29PclZPTnVreURvVTh4MFRXQU1UOUlJeE5ORmxTNWtS?=
 =?utf-8?B?RGoyc0lmbGVJeXVrUUZMQUpVVTRxdUxTYXRVMm5ORjYxL1hDOVRlaG90K0Mv?=
 =?utf-8?B?VUlFZ2hJblp0eXpteWtucHJIVjh5MHJXOGFGbHhjdk9tYys2NXREU01BdjdK?=
 =?utf-8?B?WENUVTZNTklzTGVLUisrRkU1Zys0SkxUZU91RlovNjhsQ3FWV2JuZi9Db2Fm?=
 =?utf-8?B?cGs2bURiRzlpLzNHR1RvSWpOYnNwcDhnTHFRc3NUZ3Yzcy9sZ0FDY1E1eEov?=
 =?utf-8?B?V1BzUEZSRFFrWlZmNW9pV3ZDVTNCZjBsaDFLZ0tsbjZQM1lZZi9GZnd4VmZx?=
 =?utf-8?B?cGgwNmhQZG5VNXJpTW9PU1V1Z01xOXgxUVZNZ3c5clkvTEt0MHNaUDlBWXl6?=
 =?utf-8?B?bDZoeXlUL2ZKVmF3eFBXc2VIZUcxTFcwZXZCcnpKenBnZTg4Wk94MTVzcEFP?=
 =?utf-8?B?VUhWV2RBbEd4Vy9qc2hvSjlPOWYyS2FzY2hLTGg3RmpEMUFtV1lCTDFKdE5Y?=
 =?utf-8?B?azJMT0MzSGhBMlNJZWtCK1h2VkJJRWRMbzIyODRlMXVRVURRQS9MTTZYRnZS?=
 =?utf-8?B?MG1vNTJFV3hiZ2dMYkpETFhmL3IrcE0rZ1ZmRHVCcnp3d2R4eUxlQS82N3l1?=
 =?utf-8?B?RHhqcHNzS3hyTmF2NUY2UVFia0g4OC9YUGUxT0h5cGVQcjRNckhqbXhxd3lm?=
 =?utf-8?B?Wng4Q1RkbnZHSHBBUWFLRjJkdTcrR0NXQk9lOU9rNGE0RVo2Nmp6dnNHdVNZ?=
 =?utf-8?B?M1daME1hTWVLVnNDSkVvNktFN0ZZYWZuMWJ6em41ak1ycXBDTlc1c2NUUWVX?=
 =?utf-8?B?RFFGcWtGUFBtTGNoUFFFQXhiOTk5dlpzZHNDeXJ1QWlLZGJDSWRHK0hPK0lO?=
 =?utf-8?B?aS8zODFURHA4Vm5qbnlmbkw3UUdVRUFTN3pyZ056T2xFRTVKZDlUVFR5NGpN?=
 =?utf-8?B?d3NSbkpsTDB4Y29KU1Z0MzkyaVU5NnZzNm4reVNFaGphVkNrQW1sNitjUCtZ?=
 =?utf-8?B?eDE4RjRVZlA5MG9uc3dPb1BIUnRraHZyQ3JrNUwyZjBwVEwxN0ZxZHlzSzhk?=
 =?utf-8?B?U3kxb2g5MjdyVm5PM3FiZEdleXlYdTg2V0E5VkxIZEs3cmM0MlI5enp0N25I?=
 =?utf-8?B?TVlUTWNtQnhHRDBFdFdJWFV3WGpTUnRRNTYvZmQ1a2ZrTlhHQ1N1eUgybzVP?=
 =?utf-8?B?c04zNEZQTWJsS1dsVWJzSmt5WFlGSW5Ldm9GZnkvdkVEWkZtSTMzM05OS2k2?=
 =?utf-8?B?cUtxLy94dWFXeUpReGlxeXJWZ0lmVHpGZ0ltZjJ1OHZtS09SdUFGazl5VkpN?=
 =?utf-8?B?RkFzb29MMEJ2YU1YbmhFWTUzcGZ4eHBpdWIyWFhiZDZleklWMDVlT09uVXVw?=
 =?utf-8?B?MGwxNVA2N0ZjZ2ZHcEZZdTVMOVJRVnhNU0ErWkVINThYaWRCeFF2WjllZTR0?=
 =?utf-8?B?c1RheUhsbWVlMmxYbGRjTWZMK1hJVlZiTk9tZzkvcWdEbG9hSGNBcDNGckF0?=
 =?utf-8?B?cndyMjJsSGFVNkRSN2JzOFVTSlBQYWxhamhmYUpGbDFNNDMwZzRTdEJBclhE?=
 =?utf-8?B?bDhWSFhWSFh3bEI3anpZN2w5QWJKaWtRbEpvbjRadnU3anRNSEs3ZVNZT0dM?=
 =?utf-8?B?NmRMTGRCaS8yb21kODkyWGhSRy8vcGJTZGxmNjdVODA1UlJoWitIanRDOTZV?=
 =?utf-8?B?NC9uLzNHTUN3aVd1Y2VKbGs5Wi82SkVNUHExNG96RktjSm9xdDh4MnpLclVC?=
 =?utf-8?B?b0hxU1YrbmpOczU0ZWY0NUw5Z0xzOG9SWU1RQ1BXb3FwdzhQMy95RlJRcVdx?=
 =?utf-8?B?cmUyclh1ODdaNHpaT3FuakZXY0ZqeHR3QU9yY04wc083NGc0blM4L3NyVmRI?=
 =?utf-8?B?cDlWZm9ZL3JBPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10526.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10003
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	50b7ca0c-1373-4e6b-d38e-08de3cc37823
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|7416014|82310400026|35042699022|14060799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnM2dzNrbkV4OUNOaW5UN0lWMkU3ZVBvUUh1T05YNjlzREtUZ0tyV2Y4djFS?=
 =?utf-8?B?R2N0T0hyZmM1ZU9MaVhsUGdobnBRMkg3eEtwL2F5OExXQm5sZjlXUFBkWDMr?=
 =?utf-8?B?V084K3dtMjZFMHU3OXIwRHhyQU9CbHBkbHd1YUlvNCs3TDNMSzdCU21raTh4?=
 =?utf-8?B?VktzU0dsTHBJek9GRDVNbnhCaFdDTUdrTFhESm85VklhVFN3ditCZm42NUZt?=
 =?utf-8?B?bUNFb3hHNFREOVFVMTN2TVRKK0IxMmpsMHFmMUZ0M3FJSWcxMFlvYk8vTXgz?=
 =?utf-8?B?aVlIVmQ1T3RqVVE2REFHaFFSdmFSV1pvQ2ZlekRZdmZLK0ZvWGorUVdDUERQ?=
 =?utf-8?B?bGJvNUQ4a1dPVVA3bkNTeDRiVnF2UWtCczhncXpZd1dRWjc1UWt3Ui9VY3FL?=
 =?utf-8?B?T01mSTRoNHVaeE1sbm1qbExpV0c4Q0xMSE1vMWR0R3pBdGgzZHVUSG9LQ1dp?=
 =?utf-8?B?RkU1amtENlBqQko0RmFOVUNyaDk4SzhQWVh6eFpDQTBxNHo2ZkVMK0VqeWNs?=
 =?utf-8?B?NmhVRmZNRHNRRS8xMSszU0RGeDRYVVQyNFExV200UFJ6SHF4Q0lQaW1PL2c3?=
 =?utf-8?B?eUllVDhVL2FXZFZuaWdleXFSZXFrcmVNTzNUMVkvckF6VjdGT1BZTDF6SWlT?=
 =?utf-8?B?SmRCQ0w1SmROajA1R2UrNUw1RXBnYWNSQ1dsRkdmR2ZSbGx4b3pqNFg2eHFP?=
 =?utf-8?B?dEROeE0xTE1kRGt6WU9NU1U0SmxrL3JENEtDcDZDOFpObEQ3RkhpTVBNWnZl?=
 =?utf-8?B?ekhZS2dKZFhHVzV2VE05SlNBbjlpV0NzaFRpdUtHVFR0RnY1akdwM2FBRkNr?=
 =?utf-8?B?eEN3empCMlZQbjVaVkpLaWJSRHBHOWZ6VGJPYzcvVkNGNmpmS1ZIeUNYblR6?=
 =?utf-8?B?TGtiSko5Q2gvQmN5YWpUampqbVg3WDc1Q0tKcG1SSy9tdkRQRTAxUkZ5MWpl?=
 =?utf-8?B?QkxRczExOUpCRVU0WFdHM2k2NnVHbzVtTVExUjVjK3JPc3FYWkFORGQ0WDE5?=
 =?utf-8?B?aVRGRmNOamZ1cUhsYm1JWEkzbUo3UHFDRjJFY1NkSVB1cVdnVkNPM3JhbHJj?=
 =?utf-8?B?Mk1FZGt1U1hPOFp2eEpraThwVjkwdFkzWmdPaTBxcXV5ZVJ0OU9FbGpGYUVC?=
 =?utf-8?B?WTdVcm5GUThONm1UOHR6TjJFZTRQdUd1QmxtOXA5a0dodFcveUdYTlNoTmxJ?=
 =?utf-8?B?dlVieU95NTB3WE00N0hHZGZjMHR1YjBVZUM4am1zZmhjUWZBSFY0OUVrQUls?=
 =?utf-8?B?U2dqc1NDZ0ZIckVnd3RsdTh4UjNsMHBabm5UNEI3bG5wL3Y2ZmtmamJsdm9T?=
 =?utf-8?B?WkhBdWFTYmNzYVBXQzJ6azZIak5Ja1haMEkvcWtQdmRPVFlaSlRsMW91VjJn?=
 =?utf-8?B?bHk0Uk43QWRNaWtFL3lFR1JoK2tmUG8xQ2d0ZjduRlFYWlhzS2V3MkFSTWhS?=
 =?utf-8?B?ODIxWDRhTlg5STdaWlFjdXBnTEt6NGFaQ084cHkweUEwY0hEbXFHa09OcjRJ?=
 =?utf-8?B?QUxCS1ZqMzlIZWhVYXg4VGdkbExYdUt1TmxPZW5KOHludjFZcExrcHlZVHVj?=
 =?utf-8?B?M2F6ci9IeVM0YTNmMVpGS1RyODE0RzVna1Z4L0ZLaFRaR1VZeGE0MUxGV3g2?=
 =?utf-8?B?VnhwWW8zYWEzUzErTzJ2NVpYc3ViKzRCSWk0NHJJc2xqUkQ4eDBPUGlrbzc2?=
 =?utf-8?B?UjBNK1NmWVZJRUhoMGZMTjU4RjAzRU9TVXhvVkV3Qkg2QmV1d293OVBNbkFS?=
 =?utf-8?B?T0tGZmxNL0FMYkJ6WkNNT3EvTUNZaFBRM1RKT2hpcnUzVXpDRVFIbzFSWGJy?=
 =?utf-8?B?bVZRWXUvZVYyR0xOR2kwMnByZ0JMelpUZ0hYTXpOV2ppa3JVTGpyQnd1UUQ3?=
 =?utf-8?B?NHB3S0hrVGZwRCt0cm9Ia3lFV0swNXh4YVlUcG54VXdtWDh2UytqSGh3M0Qz?=
 =?utf-8?B?WEg3OENmQ1NaeGE4WkRidHRYbzlGeWlWdER0OEFFK2Qvd3Z4cFFZcjdVZXRJ?=
 =?utf-8?B?NXAvMmZVRlBFbHBvQzZKeVlLTUluQkpzVXkycUlhSVBnNkZhd3laZUsvSjJr?=
 =?utf-8?B?aFNkcE9FVjFBV0Z1RDN6YThKaHEvbmxOdlZCSU9JZEdlNnNMeG9SdkVURkJL?=
 =?utf-8?Q?ffBg=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(7416014)(82310400026)(35042699022)(14060799003)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 16:53:21.5792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e68d0115-8d81-4cc2-c154-08de3cc39ef4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6545

Hi Ryan,

> On 12/12/2025 16:18, Yeoreum Yun wrote:
> > Some architectures invoke pagetable_alloc() or __get_free_pages()
> > with preemption disabled.
> > For example, in arm64, linear_map_split_to_ptes() calls pagetable_alloc()
> > while spliting block entry to ptes and __kpti_install_ng_mappings()
> > calls __get_free_pages() to create kpti pagetable.
> >
> > Under PREEMPT_RT, calling pagetable_alloc() with
> > preemption disabled is not allowed, because it may acquire
> > a spin lock that becomes sleepable on RT, potentially
> > causing a sleep during page allocation.
> >
> > Since above two functions is called as callback of stop_machine()
> > where its callback is called in preemption disabled,
> > They could make a potential problem. (sleeping in preemption disabled).
> >
> > To address this, introduce pagetable_alloc_nolock() API.
>
> I don't really understand what the problem is that you're trying to fix. As I
> see it, there are 2 call sites in arm64 arch code that are calling into the page
> allocator from stop_machine() - one via via pagetable_alloc() and another via
> __get_free_pages(). But both of those calls are passing in GFP_ATOMIC. It was my
> understanding that the page allocator would ensure it never sleeps when
> GFP_ATOMIC is passed in, (even for PREEMPT_RT)?

Although GFP_ATOMIC is specify, it only affects of "water mark" of the
page with __GFP_HIGH. and to get a page, it must grab the lock --
zone->lock or pcp_lock in the rmqueue().

This zone->lock and pcp_lock is spin_lock and it's a sleepable in
PREEMPT_RT that's why the memory allocation/free using general API
except nolock() version couldn't be called since
if "contention" happens they'll sleep while waiting to get the lock.

The reason why "nolock()" can use, it always uses "trylock" with
ALLOC_TRYLOCK flags. otherwise GFP_ATOMIC also can be sleepable in
PREEMPT_RT.

>
> What is the actual symptom you are seeing?

Since the place where called while smp_cpus_done() and there seems no
contention, there seems no problem. However as I mention in another
thread
(https://lore.kernel.org/all/aT%2FdrjN1BkvyAGoi@e129823.arm.com/),
This gives a the false impression --
GFP_ATOMIC are “safe to use in preemption disabled”
even though they are not in PREEMPT_RT case, I've changed it.

>
> If the page allocator is somehow ignoring the GFP_ATOMIC request for PREEMPT_RT,
> then isn't that a bug in the page allocator? I'm not sure why you would change
> the callsites? Can't you just change the page allocator based on GFP_ATOMIC?

It doesn't ignore the GFP_ATOMIC feature:
  - __GFP_HIGH: use water mark till min reserved
  - __GFP_KSWAPD_RECLAIM: wake up kswapd if reclaim required.

But, it's a restriction -- "page allocation / free" API cannot be called
in preempt-disabled context at PREEMPT_RT.

That's why I think it's wrong usage not a page allocator bug.

[...]

--
Sincerely,
Yeoreum Yun

