Return-Path: <bpf+bounces-76707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E57A0CC2171
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 12:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2504D30166FD
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 11:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034BF34105B;
	Tue, 16 Dec 2025 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MqKDo41e";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MqKDo41e"
X-Original-To: bpf@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013026.outbound.protection.outlook.com [40.107.162.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA6C340DB7;
	Tue, 16 Dec 2025 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.26
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765883072; cv=fail; b=co3klVxiAeLMetosurCRjsnYpAj/NR0ks6myozTYkjrb3gnZbK3TKPSsqV4fGhwacK0GFkN4RRxbF3gQj8Gp8azkZBgUVhUtztKtaceoDc1ONdChiQi+i6uu8ziJqh6m+xdWjsMeTCJZqaj9IbgneWGrX5F0Opnpi7kE96Ji2gU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765883072; c=relaxed/simple;
	bh=G+CmbooVziXnyu89z3mT7zrdIwuBu3SaHUbIcN0oGBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u7TNhDLMK7kEbF6dx5OlX9hK7OWTm4FDLwAefMyb0jp6AxUvlG3fTjIyaYq7CiUYfTeD0BI4xAqmWfuo8MBkgM3TWHx4DfeI6uCJXB0F8JgYSH6JJVdtCm3axtqHSgRzR/EYL8Ix/C+O23N4oo3vK7qZZFrfUmxTc3vMSLrqCPM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MqKDo41e; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MqKDo41e; arc=fail smtp.client-ip=40.107.162.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UWTAWAllGIQvzTVrmv1UmLecbLapRTmbThOaMlJ05xkkE4vQvIxBz8hcV1afR2kAlRLZkAXqV489561w4T8LgIlSyx+MosoEiQ3NswJ5Hn1s/0gB+Wh0KD/fgFE/tq+TjToKwl++pQlEmDqyvKy8dLj06Q6UW9lz1vmJxrq2Z8IE8Cq9MNGlQV/S4caDbqHfZ7odIIKCjRoid7fSjIVN4mQRv/veg2NYbKzwd/ZABhiQ1+rB1FLVq2ut6UazVXQ+sUViilPYDMGUqWfgg+n7Qto9CtKivBQhhFHL2hflNtFaZtBoLL5LsDheaEGTdIBgnZbMtEsw3rAIJDtvGofrPw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPwQzKLhLFSvAOtSMsOtC8/iXGecaoK7dhKgScvvuRA=;
 b=WE0PpvCTVXwu7CBTu8Z9qBOFZlqcoJbQ4gBI4isWGuXMMyiZEsspPKf9dsCSE+oQbjvPDHYXEt03K8mOiFrG+T5tUgucULMDgqSbcnIyX3/BS19fzBazNC/ujkCGk0fN3PTRHwVIVKhu9pyPzmy8UdoCn2L+wr3L44XPt83aVRWAFzQyn2x6c5kOahPyzzffYdlzZbEUadwLplWjQv3FplmIOhOOOTHVW0aS1+cS1L5iNIUY8WoBLOQ/ek9r5MsO5irZEKffHcy+1uE+GT5AJ4VTl6fYIbv7lMVaDSQ7Hgbz05tRkZsFmHwt+sOT4iB/lhAaDv2Gl40jUvy0Aja7Lw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=google.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPwQzKLhLFSvAOtSMsOtC8/iXGecaoK7dhKgScvvuRA=;
 b=MqKDo41eRkNqRsyBRY5nZNGygH8hn6qOpOo07tk8UqyY0gUGvgKy7unaB2lpF3z0ZYfuFIIqI3GWnuIzW33m1fRyKJdftN3rzATOlMROxI/B/m10RGOT0+lVmOhZpSor/i7diSHp8Y95/eAAkdd7FhQSSARfiYTgyvh34F3Bz4Y=
Received: from DB8P191CA0017.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::27)
 by AS4PR08MB8191.eurprd08.prod.outlook.com (2603:10a6:20b:58e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 11:04:22 +0000
Received: from DU2PEPF00028D09.eurprd03.prod.outlook.com
 (2603:10a6:10:130:cafe::87) by DB8P191CA0017.outlook.office365.com
 (2603:10a6:10:130::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 11:04:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D09.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6
 via Frontend Transport; Tue, 16 Dec 2025 11:04:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GL36KmA0/8JyR7dsSIlfsTtvnB/xkIG1MaGDRvomsLkv9oJD6pWBjrIzgbYBd6ViDFqLONHsmAkq8dyHQJpgsunuMzPv7jNo+unz6VssRcLQTYpSF+ByAn5mizUHOjAwiIv/XPo1XOY8IJsfbpQJSfeD+B9j3BmJ7MALR36dh08LrF4CBhZsll97Go6x6PElitFzvhqN/HLDglyWGsG+BdSaH1Vd1w6VnCgoNXu9B6iFh3DIf1GNOtD/xadXrNf6LetMZgXazg73fme3lxKeUqX2yao4csxEY1bVe7gABf15FDaHlwl74zUq52oaEFOcWJG2ZL4LhP2Nu1m45X75KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPwQzKLhLFSvAOtSMsOtC8/iXGecaoK7dhKgScvvuRA=;
 b=ENnqK8Vh4M6VrVJwzRauD5n35hHDRIDPvNLBX0+kq/xioXdhRNjuzNHSJsPdS1X1q7wir6uc85agyW3pRWEg5JiREncjuGgFYPNoYdnXcc3ewI8S4FP35762tvrzBd2P8zE8svDMMYwozDYcm2ddm/rrsf+VjfCK79v7mD8oZITv7AJ213HnI5UtuGEIlDBa/3210YEgNcpr+CuZVejMEk/pJAEBFW+GYgIjel0IQ8w1TJSi49OFbQYqrY4wJBLF4DEtzBBYf/WlLLvybhqgJV4xN7XtUqYkler+iEoguL5wSR4+GZxY56EKM3OkRMhzduSGQ0skYRzZVZUeKU9pNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPwQzKLhLFSvAOtSMsOtC8/iXGecaoK7dhKgScvvuRA=;
 b=MqKDo41eRkNqRsyBRY5nZNGygH8hn6qOpOo07tk8UqyY0gUGvgKy7unaB2lpF3z0ZYfuFIIqI3GWnuIzW33m1fRyKJdftN3rzATOlMROxI/B/m10RGOT0+lVmOhZpSor/i7diSHp8Y95/eAAkdd7FhQSSARfiYTgyvh34F3Bz4Y=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by GV1PR08MB8131.eurprd08.prod.outlook.com
 (2603:10a6:150:91::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 11:03:16 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 11:03:15 +0000
Date: Tue, 16 Dec 2025 11:03:11 +0000
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
Message-ID: <aUE8bwUVa6jSUft1@e129823.arm.com>
References: <20251212161832.2067134-1-yeoreum.yun@arm.com>
 <20251212161832.2067134-3-yeoreum.yun@arm.com>
 <CA+i-1C2e7QNTy5u=HF7tLsLXLq4xYbMTCbNjWGAxHz4uwgR05g@mail.gmail.com>
 <aT5/y3cSGIzi2K+m@e129823.arm.com>
 <DEYOI8H2OESD.1H56D3H8HKILB@google.com>
 <aT/WOAr4osoJWaMS@e129823.arm.com>
 <DEYP7JSVTB9D.3EFN2KEHH3O79@google.com>
 <aT/drjN1BkvyAGoi@e129823.arm.com>
 <DEZK5U2YP6I0.27VJHSVK14646@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DEZK5U2YP6I0.27VJHSVK14646@google.com>
X-ClientProxiedBy: LO6P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::8) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|GV1PR08MB8131:EE_|DU2PEPF00028D09:EE_|AS4PR08MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 1944617f-fa00-4a4d-8d55-08de3c92ddcb
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?U1FSV2pQMjl2V0JkK2FnK2ZEamcxRkxFYzFmM0p4RHVzYnkycWw4QzE1UE9l?=
 =?utf-8?B?VzYwRGpqeUpZY1VVbXd3UkQ0amFHamJYbE44YWwrTE1zRlVyY3pxRGZwYlly?=
 =?utf-8?B?VVM4UmExSVZyVGo3dURqbHFOMm1OVFhobEpPZVRJYUh0Y3ZkT3Z3UXBCTjha?=
 =?utf-8?B?U2MrdnVkei95dEpQd2VJSlE3NUZ5cFRSRWFWcFhONit1c0tDZ240SlNCN0Rq?=
 =?utf-8?B?M0VqM296a2tVN05ONVYycmxxcjkvMUpFcXFFVnpyMTZQOFRGS1U4em1VamQ3?=
 =?utf-8?B?eFlTTlZrWVp2V1RvcjZBbVZoUmZwY0xwZzcyK1VaMXVEMi9EMGNuUWI4L2x6?=
 =?utf-8?B?bm9TcC9tbjFwZUhyT2VmYWw2VW9KYU51R0lSK1hXaU9rd0NkNXQycUswWWdN?=
 =?utf-8?B?ZjE0aVk0OXUranl3UXN5QnBCRkVDbGVrU0Qzb21TVm5LK2tyckI0blZPNkIz?=
 =?utf-8?B?NmxpVDBVLzlscmR0QTdnN1U4NzMwYXJVUVdCamJsam55ZjRGVXFBWTA4WmND?=
 =?utf-8?B?NXFDc0phVXNvRFR2R1ZYam15U0NXcUxUL2wzSVN6T0FEQVZhMjJUaWphcDhW?=
 =?utf-8?B?c2dkTEdJL1BNeGU3UzV3aWxJVGZyMThXcDlqNEVIbDJyaEhOb3dMMDBWRzVl?=
 =?utf-8?B?WFZWTzZXYW13aDE1bXlNYkx5UDliR1EvS1cyeWJ1eEdZUnRYei9sZGFzeG8x?=
 =?utf-8?B?cWQ1bFVUSnA2MTNhRGlDYXpTK2ZpdlUrcmlRclJqcmxHRmpXaHB0QkpIWEp2?=
 =?utf-8?B?V2szZWVuMS9NdWRNQnJ3Qk5ZNHBCclk1MmJGNkt2RHlrdHZ5bFRYN0xFQ21q?=
 =?utf-8?B?cmFBSXdza2J4NEs3YmVFTmtYREhQeVFCVjIyUmtJbjhyeUU1VFVpa2JRL2E1?=
 =?utf-8?B?R2duSFppa3ZQT3FCNU9nN0hsMjgyY2k4c0VWYWZXNzZhZll2aFZUd2N1Tndh?=
 =?utf-8?B?aWc4ekpYMVlNVFFrTTFacUx2RVRmeWE3MmV5eG5pdE5lVkZ4c1JKcGt0eEtB?=
 =?utf-8?B?enozK3NlYmVWbEM1eUh2bVp3RnZJRmNwSVhQZXJidER6a2R4eXVCd0hoYjA2?=
 =?utf-8?B?VWVsdTlzaERvNWZ5STBqY0NmVnVrRlNQZFlvNENmTmkyTlFvUHkzMnZKaUps?=
 =?utf-8?B?bjhXNzN2ZzI2WFh6N1Zzem9GUU1OK3J0MUs3aVpSbTVWT2EvMnVzTWJpNFB2?=
 =?utf-8?B?bDhDbmlMZlF3VmF1RHUxQkxlWHlMTi9Bc1pHVEZTRW1jTnRlS0czcFAwYVBT?=
 =?utf-8?B?U2g0Y29ZSCtObnRBQ1p4Y1ZaVjBRNmJEQml6YVNvMnR1M3p4bzNFQ0l4eUVH?=
 =?utf-8?B?aHpteU5MUzVnekZJemJFK24zaGtIdlFrRVF2YktmWitocDlnOG5IZG9IOFR5?=
 =?utf-8?B?Wnh0aDk1NnNqRGRlWkZRZlpHOE1EN2JCV1RRTk9QWFpoNkN0eUc2QlB0QWp3?=
 =?utf-8?B?bnVQa2l0U0dvNmpwNStHR1J0YUJUYVRCSVVNL28vcU1GWmZld1RJTXkzMFNU?=
 =?utf-8?B?UGVDT2RHd3AxaVRxYnBFTnJnbU5mRFZxK1pIU1ZtRjdJZ3BReWVDNXRtbHZ3?=
 =?utf-8?B?VkdzOS9DWmhpck9DM01UdUZkUzdyQ2MwWWMvbW1NNS9Ka0Y3TnNTWnJuZDVZ?=
 =?utf-8?B?T0tYdXBGOHVOa0lFT3k1ZUpDR2hVZ3dSM2xadFhaQXlLc1ZnSm1uUXU4VjVh?=
 =?utf-8?B?Y3NlRW5wMDhYcFA4U05pZ1o4Ujg1QzZzUHdLRXc5Vm9rT09RbldKVEJYdGlX?=
 =?utf-8?B?YVNHcnlnZkI1VU5QdE5kQ0hiY3hNRldrOWs1Slh2TVlHeE11VDArM1NyTEpE?=
 =?utf-8?B?YTNlWC9IdXNObEphVmx4Zk42UXVaSlpLTEdoZXBYWlNOZlpWbzZmT1hxazFI?=
 =?utf-8?B?eVFhanZqdDZoRW5CWGxPSkUyT0thMlZDaTBFdEptb2QwOEcrc3owc0tGSFEy?=
 =?utf-8?Q?Em/sf43TzXR5vKm+lg9SbQv8ILhbV6Wq?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8131
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	79556496-175c-40e7-6658-08de3c92b630
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|14060799003|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0tNSWFXZ3pWcjAzVnZnN2ViclZGbFp4bW96bzI1R1hyQ1gvOTNjOE4rZFdU?=
 =?utf-8?B?aVU1OEZSaGgwMGZCMSttUWdVbFhYQUZ0bTlsWk1kUFV6NE5EQ1hiSFFKeGsv?=
 =?utf-8?B?K2pTOWoxRUt0RDFabUdPNFFzd0wrRGtZcEFhaUZ2QUUydEduVXUzYlpUUHdV?=
 =?utf-8?B?L2V3Yk9Sbm5xKzhJSmYrcmJ1SjZnUk9CYm52OXF6a1NwVGpRRmhIR1kwdzVt?=
 =?utf-8?B?Qm42V1IvYVNyVFd6K2dDaS9Cd0czWU9zb21iN2FrTjkwSDRjTlVBdHArbnM2?=
 =?utf-8?B?QnZZNk8wTnNGanArMk0rTzFiaGZYZE5HS2ZUajVFVnd4QXkrbTh5TE9KY3VL?=
 =?utf-8?B?ZlFHYzQwZVIrUHZpc0wvNkVMZFJxUU5GWElITGM4SkZjZjhSbGdzY2FqNG1Y?=
 =?utf-8?B?T0YxQ0wwRVEraTJjQ3lYcWZML0gvVDZiUzJrSmp4dWtOelk2eWpyR0RzUUdI?=
 =?utf-8?B?N1pzdlJDNTUvWUV3bS9Oekd5cmEvRGZ3ZlgwU3dIUVdyTktKajNSZHRqQ1Av?=
 =?utf-8?B?dzZ6ZDg3MjhHRmQxRnVlVTdrQlZ4TnQ0ZjhVbjRtSmI5dTcxempaR05JYk9u?=
 =?utf-8?B?djFja1ZEU3doRHBKZ1Jnb3R6eGdHZDREY25sb0U1U2xVcGsvTkpXMktrL0FB?=
 =?utf-8?B?UWo2dEx4MmdyK2J4RGI4NEppdnZFSGFEQXZpVDZGaFVSclBOdXpYSC9laXhC?=
 =?utf-8?B?UVZGSmFBeS83Rm9tTVBGbU83YS9tNFBxV0FFT3NVMHRLU3NBKzNjNFY0ZjEy?=
 =?utf-8?B?ZjZCWGxhK0VENXVSdUtwcFFBemJSK1VTaGFTdkF4RnNtNWZ0Q2NObEhRRm9Y?=
 =?utf-8?B?aktsbXkzWi9jL2kwWk1JYzBFd3BabE9oM0R2RUo5aWxzRzNSbTNwcHlrMFRn?=
 =?utf-8?B?V0wwY0tweE1zWTBxLzJtZlFXZTY3T1U0YTdqUlUyZ1lSY2t5QnRqY092Mlht?=
 =?utf-8?B?MWI1UDkzcnFyTWw2V09HaWlLS25zMU1US05xOHQ4ZFFVblVRUmNzcFhKQmlW?=
 =?utf-8?B?dU1JcjhVV20vU1ROL2dkZytNSDNFbTBlc0VRdUhNN0JxU0owSlFwWFEzZWJ1?=
 =?utf-8?B?OHc5Sm1YRFpkWDJSS3dITXZJLzZvQ1lOL3NDeG9UWmhFM25DUWdqS2hhZlhN?=
 =?utf-8?B?U1BWU2ZnbTRNa0h3V2JURktrN28wTUlDVlc1Si9QMkVVTWUxam9oZDVKSjZL?=
 =?utf-8?B?eEl1WW1jTXpDaStSVlE5ZFp2MXVaT0dTQUc4QjNWaHExNFMxdHZrNldqbFlZ?=
 =?utf-8?B?aDROTDJVci90L3hzemFSMUNrVlltSXA0V2tnM2Y2cHpuMURjMEFRUkhXY3JK?=
 =?utf-8?B?cXJBMGtjL1ZCVGdoSFE4bWNVc3VPdlVEejliKzVyb3ZJWDJ3TEVab0VUSURt?=
 =?utf-8?B?T25QRVRzajREcVRpTjVjd3hmdXpqbDVkNEduTFRFakp3Tmg4V25SY0Qzem43?=
 =?utf-8?B?WVZaS01MWFN0cjR5MG9TNHlhRTY5TjdVWmMxcmVWaGlnV1E5dTV4QW5BNWVP?=
 =?utf-8?B?SmpjZGltNFBEUGhvNitLd0xKUEJEUFZyTmhRdWg2Z3U3UGFLS1Y0Q2Z5VHVL?=
 =?utf-8?B?R05MVXBjMmhWZkN6TXZHSGgrc01qZnl0aFNLbU5YeHlxL1pEWVJsZUVKdksx?=
 =?utf-8?B?NXN4ejZoK3JBTVlSQ1FtOHRPZklrL3MrWkljdG9Sbjk2NUZ4aDE1aFZ5MHNY?=
 =?utf-8?B?Z1dQTGd0OVp6VzVZVGRxdjdCZENPUzh3ZDJRZ3QxMlpzQmIrM0tlWHpnQngy?=
 =?utf-8?B?L2NneEl6RCtCMTNMOUNHcTlrYzM0TTdRWmtUdXhkSXQvS3Yza1dNM05PRW9B?=
 =?utf-8?B?QXFlNTFEd3BBUWloZU8ySDZPTVJ3VkZXV0dmZDdacWl1dk5KUUFkcWJKeTM3?=
 =?utf-8?B?dVcwVUdDMFVtcDRiYmwzalFGd0F0aUE5T29vOC9vTmxNZHFHT3JNMGpJUVFl?=
 =?utf-8?B?QXQ3NkdHWC9NV0JubWh3TEVlZnVVKzJhNVcvSll5dnVURVBiVWgxUFhSUEx0?=
 =?utf-8?B?eU04NC9tWElNckRyb1dQTmpjWTQycmo5Y0ROK1ZUQVdDMitROVNKSitiOUp1?=
 =?utf-8?B?YS9TeklGRUhEVmpIZXBjZzRQb0NsWEszbzJ4c3pzSkU3cnV6cVZDVTE3WXVZ?=
 =?utf-8?Q?eR3Q=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(14060799003)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 11:04:21.6465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1944617f-fa00-4a4d-8d55-08de3c92ddcb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8191

Hi Brendan,

> On Mon Dec 15, 2025 at 10:06 AM UTC, Yeoreum Yun wrote:
> [snip]
> >> Overall I am feeling a bit uncomfortable about this use of _nolock, but
> >> I am also feeling pretty ignorant about PREEMPT_RT and also about this
> >> arm64 code, so I am hesitant to suggest alternatives, I hope someone
> >> else can offer some input here...
> >
> > I understand. However, as I mentioned earlier,
> > my main intention was to hear opinions specifically about memory contention.
> >
> > That said, if there is no memory contention,
> > I don’t think using the _nolock API is necessarily a bad approach.
>
>
> > In fact, I believe a bigger issue is that, under PREEMPT_RT,
> > code that uses the regular memory allocation APIs may give users the false impression
> > that those APIs are “safe to use,” even though they are not.
>
> Yeah, I share this concern. I would bet I have written code that's
> broken under PREEMPT_RT (luckily only in Google's kernel fork). The
> comment for GFP_ATOMIC says:
>
>  * %GFP_ATOMIC users can not sleep and need the allocation to succeed. A lower
>  * watermark is applied to allow access to "atomic reserves".
>  * The current implementation doesn't support NMI and few other strict
>  * non-preemptive contexts (e.g. raw_spin_lock). The same applies to %GFP_NOWAIT.
>
> It kinda sounds like it's supposed to be OK to use GFP_ATOMIC in a
> normal preempt_disable() context. So do you know exactly why it's
> invalid to use it in this stop_machine() context here? Maybe we need to
> update this comment.

In non-PREEMPT_RT configurations, this is fine to use.
However, in PREEMPT_RT, it should not be used because
spin_lock becomes a sleepable lock backed by an rt-mutex.

From Documentation/locking/locktypes.rst:

  The fact that PREEMPT_RT changes the lock category of spinlock_t and
  rwlock_t from spinning to sleeping.

As you know, all locks related to memory allocation
(e.g., zone_lock, PCP locks, etc.) use spin_lock,
which becomes sleepable under PREEMPT_RT.

The callback of stop_machine() is executed in a preemption-disabled context
(see cpu_stopper_thread()). In this context, if it fails to acquire a spinlock
during memory allocation,
the task would be able to go to sleep while preemption is disabled,
which is an obviously problematic situation.

> Or maybe actually we need to fix the allocator
> so that GFP_ATOMIC allocs are safe in this context?

I don’t think so, because GFP_ATOMIC can still be used by
IRQ threads in PREEMPT_RT. (If an IRQ handler is non-threaded
due to IRQF_NO_THREAD, then it cannot use it.)

Although the root cause appears to be that the memory allocator uses spin_lock(),
I believe the real issue is where such allocations are allowed to be used.
If we changed the lock to raw_spin_lock(),
this would introduce significant latency during memory allocation.
So I believe this is why the memory allocator continues to use spin_lock().

IOW, what I really want to ask is whether
general memory allocation/free operations are
permissible in a stop_machine() context
(I think nolock() can be allowable only).

Thanks

--
Sincerely,
Yeoreum Yun

