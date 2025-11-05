Return-Path: <bpf+bounces-73734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB66DC38235
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 23:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6347E18C7FE8
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 22:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE222ED848;
	Wed,  5 Nov 2025 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="wEa+61AD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDAF2BEC42;
	Wed,  5 Nov 2025 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762380293; cv=fail; b=LyUCUHTC8UCiW0uL7UOn33l0xCui4zbH4dFouvNnaXOfi50fXiq2GnXdbT1L4XiZc2kpj0i3Ht3V2Yw8X57M8xF1wxRvrA1eMMmZpF9Pp8xRXMuLCbr2bdgcdhOHUu9G/rB2iX5e3ZMyNjTZGp1ZIBxNfEo3fmXxxeE1lb4CNyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762380293; c=relaxed/simple;
	bh=H70lXsaYVpVPIm8NRBK6EgRoEzTcHBPEIaIfQq7qgc8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fe4ELv5++p3tDai9meE2CaxX2fOEI4m0G37b1G7wGisP9yKgHIB77b9Q719oJPEe4jGMLnRx8bZHcM7v9naGTqjP/FePf03SNvTNNTkej1hWbXvFITx4KXrfjK14c3KLCNe2YLF7JsTSog2/SAcLDzYlKr92dUg9PurRhCp6IUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=wEa+61AD; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5IJDtJ4131724;
	Wed, 5 Nov 2025 14:04:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=H70lXsaYVpVPIm8NRBK6EgRoEzTcHBPEIaIfQq7qgc8=; b=
	wEa+61ADHVh5VhV2ujlGRM+loRee8kHXjj8Mr3BLiiQLTF3ZPxo+grRn9SBCbmY1
	elPlwZqSc21CYB8M4kgXobuJiVDB63IBQD10kw0PAxDuWx/XAc9rcVuyHuzGUjjb
	UAcg5iPLSYhTqiWVMnIANdoAd6SqrFbpO9DsOx1VHU1d7Hz/Z1lBWk09aovIy1W8
	z19bv0UQvy8pYNgxZK2cPGnzGSDI+rnwsdl4suotjHq7fd4Z0Z6Cb1m/Xv5ufqpn
	Jl3c4maFapHNlCsCO/93FY3Pn5Vps+31ql0pkDtptiGvKCYK6PGASMqpleojBhKj
	9OTWEvu9/l8pt1uxOLbuRg==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a8bjq1yxm-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 14:04:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYqnS1BGRW3BSGQdQJvXY8OasaQdk7JNFUsvdVi+gNzgIFWKzTuWLWHozKwVI/R5L8zrd2bgheVq8sc8Qqvspi6lMuZtNSDozV8APyXT7guqH33sLcQNNu0zX+6XOsFP4gXHNldJLJzodq7kuYQImri3Ibn4UjiTup0QvqvTk6qf8MC2u07/M4H9ZQoPZHgoXMRh5AI0XciN7D+kuwZRzQR7Ku3Zc7FLRy5AMGA+zpgg0cRakTsqDXQWZqmdSFjwwlleer50Q8j/On6/VXJw/KlWW+cs3Rhr0a7qn6ZyrPCAZXnyu3wW/k6Pk3+cvXqlYsXSyZDxSHMtGMJj/YsSWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H70lXsaYVpVPIm8NRBK6EgRoEzTcHBPEIaIfQq7qgc8=;
 b=yF+haZTa7quTyk5mULQcCMlkmWor3kKyDlKJt7iMdVJmFHh589QYRlE/wPfDk/Ete7Hp4FvHy5wGCCBYlVjdAG7ebN3uNDWnJXPEBaDl+1klYINc5ORI8UkWq5U1zp/4OTzlHjKdF5aNDO02fC4wDrOwFZRa1sLPytdJxgLSJ4rrpAc4eidd79fhp10WRGAByWVLoqJcvUp8eH3MVpVcYZVEHzPMc/fDHUHDnEcHSGIyfXCiK/HewVZteWqgyDpkeTlULpwD0HsjS3q9+r8nm5qDgrJfWRFao46OGbvNnPzF+fFWD8KWXD7iU7XEu+3KIHKxCbrvacu02yXICUXh5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DS0PR15MB5651.namprd15.prod.outlook.com (2603:10b6:8:152::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 22:04:46 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 22:04:46 +0000
From: Song Liu <songliubraving@meta.com>
To: Jiri Olsa <jolsa@kernel.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt
	<rostedt@goodmis.org>, Will Deacon <will@kernel.org>,
        Peter Zijlstra
	<peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>, Yonghong Song <yhs@meta.com>,
        Song Liu <songliubraving@meta.com>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mahe Tardy
	<mahe.tardy@gmail.com>
Subject: Re: [PATCH 2/2] selftests/bpf: Add test for bpf_override_return
 helper
Thread-Topic: [PATCH 2/2] selftests/bpf: Add test for bpf_override_return
 helper
Thread-Index: AQHcTlQUlQw13BAGeEaFxq3FVXBweLTko7AA
Date: Wed, 5 Nov 2025 22:04:46 +0000
Message-ID: <5F73DC2D-2B0F-4832-8641-BC84EFD9D8AE@meta.com>
References: <20251105125924.365205-1-jolsa@kernel.org>
 <20251105125924.365205-2-jolsa@kernel.org>
In-Reply-To: <20251105125924.365205-2-jolsa@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DS0PR15MB5651:EE_
x-ms-office365-filtering-correlation-id: b3c0aa01-3ee2-4b76-5504-08de1cb75527
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TnZqbk8wYjN2eFVBRzVGSFdzNVdlcVRDS29mQUFHdjNPQUVUMlh3QWFOYVdy?=
 =?utf-8?B?NXdGK2c0cGxOd252V3ZMeWxtcWo4TXUwUTNySnJZVi9jdWVLVlM3TEFoU0ZH?=
 =?utf-8?B?ZGVaVUlkemtEM3BBZWZ2TzhDZFp1L3lBdkRvRCttR3ZRaXRQWjNnbTJHa0lk?=
 =?utf-8?B?cEpMWlhKRysyMUcxdzRFQzN2TGo2N0hxWFF2eHlZSWh5eHh3VGpBeGF2bnRB?=
 =?utf-8?B?S3h2YlZSWkFMeVlXbGxEcmZta0NJOXNiQ0JuTDRDMWNJVDNqQkpDKzBpM3hz?=
 =?utf-8?B?c0hZczB5dmsxQmVqTTYxNk92NGFrdy8vU2hZdEg0bDdsd1MyVXl2WDVKTnBk?=
 =?utf-8?B?TURJajN4K3hUZ2NrL0lVNHZQRHNjMi8vM3R2VFFvVDVVUTk3NWhWdXZ4MUpD?=
 =?utf-8?B?eGsrYUJxV3FFYmN1d2xFTkhyWmIzZVRXRW9NS3VpNURLV1JaaTg0d0ZyZGY2?=
 =?utf-8?B?TXhlQ0NIOXE5YTBFV2RWUTJkaWVoUXEyL3JXdjN5aWY3ZXgyTXZ4eDZNWTNp?=
 =?utf-8?B?MnBCeFdKRzBrWi9UTWh3K1REMDBoeGhFT2xIVXQ0bVR0bWpKRE54RGRYRFZR?=
 =?utf-8?B?SXcvQjkzQjcrUVZZa0NzQXhzcDMyUVdiSEtBNHBBNHp0WkNSSmV3bDh2WmFD?=
 =?utf-8?B?TDZrZVYvWnZLR0ZDeGs3T3RVRUdKQno5TGduT3dkWWtzSm5DbjArKzlGZFV3?=
 =?utf-8?B?OGdhRk4vS0gza2JVWEtid1htQXNmbFlBVnYvYmo3VjloZWxYTTE0Yjd6NFVJ?=
 =?utf-8?B?Y3NQL3RpWDRJT1dKWCtTdmxqVlJVdjhHYnhCME1kUzk2QzkvODNSRjhVaVk4?=
 =?utf-8?B?NzVZZ0FMODl5TE9nMDJ3aHNKY1BSc1F5RjNEVzZleExqRFBsZUxDNzQwVkFi?=
 =?utf-8?B?dXA1UWc1bmdBYzR4dklVeEw1cXVWT0JWRFpmSUF4OXRqQ0RmRzZURDZHbVdp?=
 =?utf-8?B?amd5Zm9hbjN4djhybkxnbi9Gd0lZeEtVWXRXUGdtT05qRWtITUw3b0dRcnRB?=
 =?utf-8?B?Y1hlUFhrQUlJSFNrTWM0VElscGJHWlVieDQ5bE9qNldNTUtZZ3hOeERlVEE3?=
 =?utf-8?B?MkVCM1l1aFRUVUhkVDJpMENCM2ZSVzFERWxEVzBDcGZJL05ZRU02U2tRQ0xx?=
 =?utf-8?B?eS9zdlZFOHU1OVRlbWxxaDBvaHJvTStObS91QlBGNDBDMnpFTElwbHhLbWFK?=
 =?utf-8?B?c1daZHdPM0NqTzQ0M0JqSzYrcDBRMUo5OEFXNW1LOEtpNFBzREs5ODF5SlFD?=
 =?utf-8?B?QURxM3FBTmRrVkJRRFZpN29SR3lBYmM1bVdNM3VSSldwSE1LaTVJdGRtSGpk?=
 =?utf-8?B?cDFXTW9EQXRJajE4bXZqd1pPN1MwU3pvODNjSjZ3SzFCT0FlTGx1ZnQxak1m?=
 =?utf-8?B?dnZvWWNRUGNIYWJHN3YxWFlpTk5IVEJjVTd1UUJHMnFySDBlWXl2SGdUdVMx?=
 =?utf-8?B?alUyWTNqenpRd0tNckNnUE1JUWFhRTNLNm5xOVBZS2hzaEprdzFxaWhtQkZm?=
 =?utf-8?B?Sjh6TEFXMTZQMENvWHBXQXZ0dXUyaTV6aWovUUlBMzhjb2JMWmh2bnlSNE9L?=
 =?utf-8?B?akltRmxUaHJrQzV2djcvaXQyTmE4SnhJRnZYaHQ2cTJYUHlxWHhJRG5DbkZr?=
 =?utf-8?B?VHVPQndQYkFEcU1PQUx0UzhCSFRBVDhSR2EwQWJsZkplajhKTVVsWlF3dFN6?=
 =?utf-8?B?NVBXQ3dlejJVQ0oyZEExUzFJOWg2b09UTU9CZjdPUDNVUDFCOVgrNU1zbmNp?=
 =?utf-8?B?TytKczB3Mi9XaDg5bEtNbnFRdklDN08wN1pheWJwVzFsUXhCWHBLck1MU3lV?=
 =?utf-8?B?M0M5K05pMnRNejBhQmdxblJMUGZiZGZuNlpLaGVVMmY3bTd2Vnl3ZmZKaW9q?=
 =?utf-8?B?QnV0YkYwM0hUUTJUd0FjU0tvSTFrZjU2bitlOFE2eEtzMnAza0lXYm1LNHpM?=
 =?utf-8?B?cHdJenowYysyaXJ6VU92VTRlL2FNWjNtWDF6TFNkUURJbS80M3JsZVpIQVNV?=
 =?utf-8?B?TEI2Z2pBUngvM0lldnRYVDVmVE1pbVRGSUM2UFVSU2h2ZmZpWnFkcktHTERv?=
 =?utf-8?Q?Efaj+v?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlQ5NjVWYUZrUEt5VG9lN3I4K3BZL2hLMG5YZXhzWWNHbDBSQ3BwN3loL25P?=
 =?utf-8?B?NlZJZjQvUy9JR3ZvdC9wRW50MmVadVpmZGlHWkVFK0FRUW5DM0t2MnIzVDF4?=
 =?utf-8?B?T2NmTlN0WHBKeHI4R1RhS2owYWx2VHNCYXRIRHhPOUt1ejVpR0IwOTd6QVAz?=
 =?utf-8?B?SG1BYnF0ZFIvUzN4cE1ldXAyR0ZmY2c0Zm1oeVFQVXJlRHlaUWtoMGdNUXhU?=
 =?utf-8?B?dkljVUZIOWZyNkFhWDdLckNtamtncUlaZ1JPbzhmNU1ZLzA0R0FXZWxEeTVD?=
 =?utf-8?B?K0RiY0Q1bDdWbXJHbXl6SHcyTm5JNGtlNjFDb0ZJMzQwM0VBVEFmQzdXOEtC?=
 =?utf-8?B?Z2hJODFNOFkxL1ZIVnU3R1VtaWErWnZ6V21DVllsS3VtVithc1VnQ3prMEJ5?=
 =?utf-8?B?WGJ4clNscjFHYUpjK1g0VjhWc0VLZlNtNHlKb3ppNW1yYkZoQWF3OEdiRUFr?=
 =?utf-8?B?bkRNNU5hSUxVakFIZW9FanpZdG84M3JRTkxUOE00RStIaGJ0NGdBWGlidDlE?=
 =?utf-8?B?SjhlRHVxZkZNamd4aHNJZnFMV2x0WCtZNElyTll0bjZsRHgrbU5taytwTGRM?=
 =?utf-8?B?NW9HeHd3ZXNCK2tZK2h0UXBCR1dmWUJFM3Vrd0RDNy9uSjhsOFp2ZnFvYnd2?=
 =?utf-8?B?bitRK0VGMExVR1Bhek4yVUZFSG5RejdNVVgvUWo3SWFrOXh0Rks0c29UcCtO?=
 =?utf-8?B?VDZQUGVBeWZlNERTK3VaclUyNzlEb1VoMVNqNHNkYmJMcWdjaU0yNjRPZCtP?=
 =?utf-8?B?YkMzR0Y1K3Jzb2pNY2VFeERVMnVsOS85SldyUkpyaERvVTlEaHVRZCt3RzRq?=
 =?utf-8?B?SkNJZURvNzVYaXZCdjllMStLVFphd1duR0RGbzg0UVpTbHRPMDhwZ08zaHk1?=
 =?utf-8?B?dEYyeHBvSFpOTnI0NS9lUCtJZVVtTDd5RUJHYlB0MXdqYXdMQnFUczYycVc3?=
 =?utf-8?B?QXhOVVVLdk9Yamd6eXloTWJqUW9BQzJPWmZ0RW53WlpkS1lEeUxkc1dLRGNz?=
 =?utf-8?B?RHR4N3NrblZVbWFveFE3eWlLZlRYTTVOQjJGbjJFRUhweDFrRDFrNDZEYjA4?=
 =?utf-8?B?L1JnSG9RdUlQb204WHRpOVhTcFBOcThSSTNuK2JZU0hOU092SlJxQXBucjZo?=
 =?utf-8?B?QTdMeFNyejM4S3ZLUHdOblZQcjV4VUlhYnRpNU5CSWlhN1l1V0VlWWpYN3U1?=
 =?utf-8?B?RERDNHFwZVVsRHVIQlpCcks3ZU5MYlNQSkJTZW5jWGlvL1pkSko1Y0Y1bVZh?=
 =?utf-8?B?OGQwRjhjRFk3cVNsV1JZZk95WkdyaWErZUxTOEQza2tIRFVkMUYxckdldzZO?=
 =?utf-8?B?QS9Mam1BR0htWThJdkd6SWVCbXBZbE9vOTJLRllqdXpxeC96V2dUUDFBT2Js?=
 =?utf-8?B?OGxsblFOVzl1ZlQ2SmlQYUZEUnIya1c1OTBMUVhZSDRXazk2cnArbnZZOTVT?=
 =?utf-8?B?eUI4bFI4MHNVeUxCVkwvU1NJYVdRS2I1cnhuYVNEZ1BkbGo1OHJ0ZXdWUnIy?=
 =?utf-8?B?WGZzS2lWdEUzQmRpbTVTQkk5RGVmL2s0UGY0UEZ3UGxBS2JhNEQvOThuSEhv?=
 =?utf-8?B?eVlNb3dNelpUQ3I4eVBpSXd3MXo5U3o4Z21YQmR1YnJjdEtPWUloVDgyL2dM?=
 =?utf-8?B?bUFiaFA2RFdQSVF1czZlUWtQMFd4SXAxblpiOU8wbFArdWVzUVNQWlZ2N1dR?=
 =?utf-8?B?M0hpMGh4ZjAvT2srTmFLVFBNdXNJMFlqb0ZVd0phNitZM1RuOXY3UEhEUG8z?=
 =?utf-8?B?VVdSZ1NuZi80Sng2MFhkSC9EUFg1VFRxazNXZVBla2FqS3IzZHdQaXAyOFhR?=
 =?utf-8?B?SUo1bUFHTS9MREFnTktwaGNsbFNIUk1XcExLNXhaUmRWL3JXa2sxRVRXbU53?=
 =?utf-8?B?MHJtR0V0OHl0dkliT0MxV1FmMkgyMURRNTF4QWVPL1MzM0NWbitKNzdNaWFP?=
 =?utf-8?B?cGFzYW0xby9ONXdmY0pjdGU0R1Fick5qT0RxVVYrY1Jqc0ZxK0lSbXZ2d3FH?=
 =?utf-8?B?ajJqcUF1VG10Rllwd2pjWEVhdFVycEppMG9jSC9JZmlhQUdqY3VxZmJxQnky?=
 =?utf-8?B?UlQ4b3BGelpBTTU0T1VTSlV4M1pPOFlJTEFJNGlGdmFPMGZCM24wOW45SUd3?=
 =?utf-8?B?MEViek5mWkt1d2VFV2gvQlgwR1JvYnFWaTVpb1RkNG8xOFErVndOM3VuaFJH?=
 =?utf-8?Q?shMp4YjZeI12u9BQ3M6K7nblYuxIs7LkFRih/gWDetRC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEEF84D8C0026F4691831995185613AD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c0aa01-3ee2-4b76-5504-08de1cb75527
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 22:04:46.5811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /1YSZHGwuCXUfZTABtoZnItZST/mLlhp1EslJaC2rjI7KFPBe5cITGxFfKP+KJmMhien9fecUAIbx3z4cm1JGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5651
X-Authority-Analysis: v=2.4 cv=E7bAZKdl c=1 sm=1 tr=0 ts=690bca02 cx=c_pps
 a=Rzgcbe2yxP2fEJMfMKkCcw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=22rltLk-olOGDPis1WwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDE3NCBTYWx0ZWRfX1Qg42YPgi/yO
 36j9MxppPy0kuCCMKf7o6FV1DX37MjB5f8H/L+uFa4ZqphXW+lhwdfuS5EGeYiZtolwO/+5aqnx
 eQdMr7ZXPglSk7fyv+hq176INWXaIHD/HpGn9MjVGI/c8GVWfYLOuxgt3PM/OhHeYgw6vPO5wWA
 WikElTr7cbwgL1d3BBAtE1mublI9MGMIiA8yFgG7b6lbEK2hpV9IVxvr0bryN7xmLCiJbglj0ib
 DPzXIw1i7UjT2Cdfrn+WNdlVsrmWivBtOQswHc00QBUZBVdkA2wuv9q8XE+LF8/U9oMRQzEGTEL
 S8FZbYuG314Ga5Y032uEoOHR3gxnOlUjfy4kk9ZvpHbhn9eWrPl+EyN8iB0vDpEtMeVXo0sA6cJ
 4+dtMQbPaHw1dP18DwCGwNewaysHdA==
X-Proofpoint-GUID: kMbAXZliA-MaqccaOQcqrLxR7YgpQeRZ
X-Proofpoint-ORIG-GUID: kMbAXZliA-MaqccaOQcqrLxR7YgpQeRZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_08,2025-11-03_03,2025-10-01_01

DQoNCj4gT24gTm92IDUsIDIwMjUsIGF0IDQ6NTnigK9BTSwgSmlyaSBPbHNhIDxqb2xzYUBrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IFdlIGRvIG5vdCBhY3R1YWx5IHRlc3QgdGhlIGJwZl9vdmVy
cmlkZV9yZXR1cm4gaGVscGVyIGZ1bmN0aW9uYWxpdHkNCj4gaXRzZWxmIGF0IHRoZSBtb21lbnQs
IG9ubHkgdGhlIGJwZiBwcm9ncmFtIGJlaW5nIGFibGUgdG8gYXR0YWNoIGl0Lg0KPiANCj4gQWRk
aW5nIHRlc3QgdGhhdCBvdmVycmlkZSBwcmN0bCBzeXNjYWxsIHJldHVybiB2YWx1ZSBvbiB0b3Ag
b2YNCj4ga3Byb2JlIGFuZCBrcHJvYmUubXVsdGkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKaXJp
IE9sc2EgPGpvbHNhQGtlcm5lbC5vcmc+DQoNClRoZSB0ZXN0IGxvb2tzIGdvb2QgdG8gbWUuIA0K
DQpBY2tlZC1ieTogU29uZyBMaXUgPHNvbmdAa2VybmVsLm9yZz4NCg0KDQo=

