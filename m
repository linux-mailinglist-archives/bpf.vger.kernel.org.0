Return-Path: <bpf+bounces-73506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8B7C331F5
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 23:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44F4A4E7F12
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 22:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876B82D0602;
	Tue,  4 Nov 2025 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Fypxj7WF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489FB2C027C;
	Tue,  4 Nov 2025 22:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293610; cv=fail; b=UYzYk6FdC8CnEqbVDWz7uXeqpHQHe4Jf+O2YXq2nmpLDxUUUHjn0xQdmS8y0rIq5dHxt7LjdJZfpWmhtl12GxIPdx/EmNkqmq+HuDjb/yWPY6OOmECOliDZuOXhRpL969n7rT3tDq66lCnxwrTv2wAXx23HbZskqyFffW3MVYIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293610; c=relaxed/simple;
	bh=2pNPQ73N3sM8u6CJkxE844EnIcwHg8QSllSByq35otA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dr+jeV/h7xMijGvMMWZEprQde9HQX5XMxKP16z50VnQLPyftZ7ck5g42K7MZOA0YAgt9gIaJ+GLDAEvzKX6f/y62GEcDpduppozsaH1g857UJ6hKj6KJELxHvO5JHUuN3OKK23TMCLK7fXwxc6EObj6fkeeG5upU08HwzXzBy1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Fypxj7WF; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4LaeEV1213779;
	Tue, 4 Nov 2025 14:00:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=2pNPQ73N3sM8u6CJkxE844EnIcwHg8QSllSByq35otA=; b=
	Fypxj7WFVfJJCDwXEjjzDmMVPzUajSy/kTKMPZmdBndCCn8H1a6hFvgOctBItI7j
	oZ47asPmXktB/H5HHcZEDm++25b1xB5atR7oG7SxflVkBtruB1jmuUfWRhXZfVYZ
	mIDy5LnMtncG+L5UyXBS19yLHjDaZGDNQwJwlpaTbzUxzZXXeK/NKLVoTYYlPHf9
	s1qhpzoOquoKfhjyIyqa5RQLxm+PdFreYX4vIW12CaAqRgqot8euZZ6pJs8FdEXA
	MkJYqgCDknTAyer3lQWlyK9FeZmqZ1dTnRcRxbIWXb95q502FMEMSmhOgnPSjgU9
	E5heAmoQkZaRcIyWme1H5g==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a7mgab9jv-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 14:00:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQhb6NXrug/r9nJikejaruKNwU80orJE5x1qQplS+Gbbd+U0cX2ZAo38eOQqzCa0JTEaM/CSxqM8JT+cfRvVYPmLy8pWy9G83W7ullyfHB5bnjhgddDI6n+hKy4k4AI11owYkJTJzJlDJzdPtxX9JzoqOtcano21Y/q66Qn3jXkYmlg7JA/1tXEjAt6R/QB1/c2XEZXbYBBPU+5Xr9YuCr0xcedHqH8MxwHwEG8QUGr7mtGx3hAIccYEwhuioKWBprL/9QsP0DBJ5DCcsUIBJts5mVEPwkAaQx9V+ckpgZaEoVvm/UYF/ieS79TC1Z0E4h0PkeP6fhsz6RC7VA3bvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pNPQ73N3sM8u6CJkxE844EnIcwHg8QSllSByq35otA=;
 b=jeX6tUfLVqevR8FBXlti52lqWy3LwLhex/5ZL0atZaJ0MCPFP/gk3JUduJhBZz3urWi2ZV4potsrU+VMDcANiKMs8r1hN92Ns/LOL8G0Vm7x1pgak1cf3wyvcz2pAmNNwXUQtIof3+4zRDfVLVqQycHRsBvPNSN5bGa2zVv95C8sC0l2VbeEFeyGJoDVZDnicEtNrhougVZ05R3gjqOkPhWwYdpmXyjbaT4LvdIapWcyoXupzLBJ638OLnHCU//CPocRxmixRGzH9JbZFtg9G1+PFOpoHe4cP07n9QgktMYScQBQYMlqrx4bsM5c4h0ieuJExAAJ/qLT7VQcI4wB5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CH3PR15MB5976.namprd15.prod.outlook.com (2603:10b6:610:158::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 21:59:59 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 21:59:59 +0000
From: Song Liu <songliubraving@meta.com>
To: Amery Hung <ameryhung@gmail.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "alexei.starovoitov@gmail.com"
	<alexei.starovoitov@gmail.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "tj@kernel.org"
	<tj@kernel.org>,
        "martin.lau@kernel.org" <martin.lau@kernel.org>,
        Kernel Team
	<kernel-team@meta.com>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>
Subject: Re: [PATCH bpf-next v5 2/7] bpf: Support associating BPF program with
 struct_ops
Thread-Topic: [PATCH bpf-next v5 2/7] bpf: Support associating BPF program
 with struct_ops
Thread-Index: AQHcTbA7OQhBOnN7QkO4hM70o0ckabTjEUwA
Date: Tue, 4 Nov 2025 21:59:59 +0000
Message-ID: <5525A04E-70F7-4E13-AB12-A6905FB3697A@meta.com>
References: <20251104172652.1746988-1-ameryhung@gmail.com>
 <20251104172652.1746988-3-ameryhung@gmail.com>
In-Reply-To: <20251104172652.1746988-3-ameryhung@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|CH3PR15MB5976:EE_
x-ms-office365-filtering-correlation-id: f51af71a-dd00-4498-b343-08de1bed7f51
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?OVZaL3ROeWgvaVg2NXo1N1NRL1o2bXRESXFqYlFJQjBleFMrcGI1dzN4UTA5?=
 =?utf-8?B?YmJ2aVN4cVBrUjNpdjl2OWNxWHBwUFV4QndaVHVzR0pLR29YbUxSUlFwOEpT?=
 =?utf-8?B?UXdyUmtBWE5nRUtocVBoMHU5bEw1UlJmNXdjS0RrVjkwYWZ5bUt6d2dGTTVC?=
 =?utf-8?B?a2N0cjNVcm9KaTR3YmlrdGFqU3YrMkQ0RGZuUUJ1SDhXRG5yUVBhWk1BNEt2?=
 =?utf-8?B?aWtnaGJoUG1RN21SN2xJbW40VExMbzBIS0Fmd3c3N2hWb3VkeGpYK3I0RFJm?=
 =?utf-8?B?ZHpITHdkRVczMFVyM1dTbUo3b2c5TzZUWTdzT3RZZ1R0UFpIR0lycDZoekxW?=
 =?utf-8?B?QnQ2UkJDVjJ3bS9Sams4cExtemgzT0Myd24xK0tibmFPTFp1SlljYkNJNFlP?=
 =?utf-8?B?UVZpaWRhWUhFdzVwVVllTzRucDFrbUgzQUlDVm9LdndkQnpPN0RxOHIrYmxX?=
 =?utf-8?B?WFFPNFRUOEtYTWVBcXZZaEYzTUNYTGFsejVjMG5oSmRmYVhFU1A1TXBha1NK?=
 =?utf-8?B?ZU9meDhoRkNkTGJ0cnkxa2pOVEN4R2wvSlBHUWV0VnppWkxYVVoxc3FXUHZV?=
 =?utf-8?B?UHBaYjc5OFA0a2E3N3VpOWdDR3hYdXJtWFhnS0hLS05kNXJDVE5QVENDQnpS?=
 =?utf-8?B?dmZZUFhOZmVYaDJnTkNqVE1YSXRkT2xyYUowRUVTaC9xdTA2TVlsc2g4czA1?=
 =?utf-8?B?TmtnK1l1aVZoNUNhcVFJb2JHQ250bnJjT3pOQzdoVTdkbVNjSDhFamNkbGx2?=
 =?utf-8?B?aWxlRUVrM2FQcmdUNkw0QlJLeFQxam1nQ2JCSG9ybDJnWlFLYzAzUEFCYkt6?=
 =?utf-8?B?RTR0MjBnbk1nQllBYU1kSUNjUkRRMGZuR21EcHowamRmejBwRE1UVXo3Z29z?=
 =?utf-8?B?NlJKRG1LVExoekJ0cXZQNjRjSjg4ZktLSVBDaVVaVFpuVHFlUDIzTFlTRkVq?=
 =?utf-8?B?NU10MDZCTzVjRTJGcjRLWk9JVlRReUZib2Nabzl2Nk1aMm1tTXU1ZnZYS3Fi?=
 =?utf-8?B?SG1OVFNadkR6dVVJVU5jZWp1YWErZ1dyVzZCeHI2M3I3VXRVRnY0MEV2dnVP?=
 =?utf-8?B?L0pqcDJISlZneG8rNFJ6R0FJZmZrWEZtbGwvai81bGFJS0o3em5mNzZRU2Qw?=
 =?utf-8?B?NndMSTdab2FSR3ZHTnBMQkVSc25sd3Z5b0loSFZPenl5dGpFd09FeVQxUmFM?=
 =?utf-8?B?a1ZBcHp1Y1hZbzBMTWt5czZJWGVRUnIzNXczelRBU1M5ZDdCWDBIZDl5UTBZ?=
 =?utf-8?B?akIwUWhoVXE1a1VUVjd4VzNzY0VxK1I5aThDbzBNK3hROWpEbGhILzN2cEg2?=
 =?utf-8?B?SmZNb1J1V0xqZTdVNXNKVXhickNNKzRwdVNmR0xoTFR1TjZmVlZaemNNc3Bh?=
 =?utf-8?B?TjFzTWhIeEgwWEx5SXZvbkVZTE1TempJbGwyVFlYdXVPL3o4dHg3bVloVVBY?=
 =?utf-8?B?eHJjOWVSNVc0cW95cEg5VkVGbU5mSmxtTVJneXhiMFRGUGFmRDNvMnZJZWdq?=
 =?utf-8?B?akJDU3hSS3B5MnViSjZtZmVld245R29MTHA5bk0wTk1aQ2dybWZtNDFoa3or?=
 =?utf-8?B?K0tOWkJKdEVtbTNEdVh3UDIyN1dFYU0xQll1UFlGZ3pwN3VvbGFBTHU4RHB0?=
 =?utf-8?B?MGFwVnNOUW1mOTdnWkphQlpYR0JYTjVRTU8wVzNEcnBxSlZ0U0tWVzMzUVQr?=
 =?utf-8?B?cUttY2oyMExOU3V0NW8zbjYvYnByVlg4WXUwRDQvME16L0VlWTFJQWtDaWZM?=
 =?utf-8?B?MWFBTDNSNGtybVJiU2FabXV5aCtQdzMrMC9jZkE3WXk4LzJDWlNqVWkxY3R0?=
 =?utf-8?B?MVprT3ZWbUk2bFhOM0lxdkIwVllKUWNTVXpSSGRRNDBwYlhZNTVUNTVuNTNu?=
 =?utf-8?B?L1BjQkNnM09VSFYvMjRHdGFKN3MxZDhuWFFGN3ZsdHhONXJPalFPa2F4OUhI?=
 =?utf-8?B?VkIyUFJvT2JkNnNwUjhrMFhIalNaNk81ZVZ6OGdCQ09laGQxbDRsMjJobzlQ?=
 =?utf-8?B?N2JWZE4wVk8wcGpSWWgwMUkyb2E2L1NtK3RUV3hWdXFtcFY4dFVOVkY3aDI3?=
 =?utf-8?Q?IBPELD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmlmOWFUSXZlTTNvOEg2MUVJQkVJVHl1allRRi8xWm5PVG9YdHRoZ2RscGVU?=
 =?utf-8?B?dXB6anl0Lyt1NTN2N1dlUHpWZVZXQXNaQ0pzVW1ZcFdFOFZYZ0pEbXdwVHlY?=
 =?utf-8?B?OFpDMjlqNDRtaW9QZTlJSStqcVJ0clVaZ2tSaUlLMnBFeGphR2pzN1g1Qm5F?=
 =?utf-8?B?ZFRCWVVPRTF5TnJSN0VNQ1M5RW4wUmd3bi9pMDNxUUQ4RXZ4VyswYTdmL1dL?=
 =?utf-8?B?aGR6R3lYM2xWb0d0NzkwYjVKb2VCenVIWkFtcytXZk5lWjZMZnhpRUV4c0dP?=
 =?utf-8?B?emZZVzZ0TlJRdVdlZXIvbVlqd0tCTWtsU2QwM3hsZkJNcW93enRub3hmT244?=
 =?utf-8?B?b1hWb1U4NUo3WkdaQSt2TkF0Y2RURXBOUEo1aFlwelJVa09udC9EL3VYYTFp?=
 =?utf-8?B?RS94b3NjMlNGNVFpK1RPQUdaNjA3YXh1ZzZKNmQ5bVIzdGgxOVIzOXNiWmdO?=
 =?utf-8?B?cHJja0tLc01GQ3BOV0JLc1RjSDZTZmM0T3JVclQySDRqVGc1a2Z0RHNUVTlG?=
 =?utf-8?B?WGErZzM5VW9BbXZnYThzNDE5NEtVK3lVY2p3UkVaVkFQSjNqODQ3NkcyMGl4?=
 =?utf-8?B?b3pQSFMzNjVENFBhNFZ1TWR6Q0YySUJKdVhTaEVQSlI1eHREU0dSK3RLSmQx?=
 =?utf-8?B?OVpHeWcvSmFvdHFJemVwZlF1K2czQXc4c0J4L0hhZmxWMi82d1ZySXdMa1N3?=
 =?utf-8?B?bjBmSWZpUEl3UXRaMTdiWGExSTVuNVlBbGxFNm5DWkNuS1RaeHUvN3Q4eSsv?=
 =?utf-8?B?WWZoUnIra3NYcG9jN091WDhqMm9MbC95ZlRXZWJsNFpodExDY2E3S0d0bTlU?=
 =?utf-8?B?K1dnSERES0RkN1E0cWhSRkxkK2xVcWw0UE9Neno2NHp6NFR0TWVWK3Y2MThW?=
 =?utf-8?B?YTY5RlREWHR2M0IxUmVXRFZwUWowTVFNZ3JIdmluaTc4MTh2RVZyUGhhbjI5?=
 =?utf-8?B?Z0pEdE5VOWUycGVWaFR3emJsdHhVN3JMSjJUOG9hTkY0N2NETFNnNnBMemR6?=
 =?utf-8?B?dVAxbjB0bUQxN0txUEgwSDEveGp1NW1UQTl5ZHFkY2t4YXZ3cmltTWxLQVBW?=
 =?utf-8?B?Nm5vZmxpQ2pWWjlkUTFVQ1R6d1JYb0ZTZ2tvaitYdUMyOFNXWUdvdkhDaGhk?=
 =?utf-8?B?WTdxZnhjK3hNd1QxaWJrZ3ZsMkd2T3lseW16OHZrSnBkL3FZQWV4VS9HeGR5?=
 =?utf-8?B?RHhLbU1ja1BZR09RaU42KytXMTZoQzBnd0hYemlidWtLQ09NeTNjakUwY0Jo?=
 =?utf-8?B?MjA5enlSZTJ0WDNjT3EwM2tSNXdjZk1rVys0MEhSeUIxcFliVStKOERUN3R1?=
 =?utf-8?B?M1YydittMzltN0pkdXlKSjdkYWNEMk5CTlh0M3A0U0RVK1JEWWlpSVgzMDNF?=
 =?utf-8?B?bXpUSUExU0l2akI1ZVlzOHFjU1N0WktmdDE5RHlBclRhcUMzZjI0bmdIUHh3?=
 =?utf-8?B?WXB5Mk16Q1BvM1QrZjZFMnloeTBBeGkrYTNxTDJlOUJPemxaTnZUakFUWXNy?=
 =?utf-8?B?UGtGeEYwTTdSb3FoODlRZ0xxcy9hbmwwMmZjQmdwUU9zT3pqRnR4RlU0Y0tL?=
 =?utf-8?B?R2gyQ0hUbHVNdnZKWWxRUDBvT0F0OThUVDlKWitwazBMNytaQnk1NVlWekFM?=
 =?utf-8?B?YzAzbVd1clVNN3Y2UG1PRGlRc0kybDZaclZZQ3lVN24wTlZOUGNoNTFrNGht?=
 =?utf-8?B?WW5WUjN1OWFyNmxxOE1nV3NpTTBoL201SVFyL2d1a015Y3Z3cUI5Z2pIb2h0?=
 =?utf-8?B?WVU2VEVja0FvNWZSZGdldTRBd1g3SWVtQ2JqekNnMzRIOWpVRG9NdDdRNm5v?=
 =?utf-8?B?cWtBcEZqd2l5ajRrcEsyeGNLVHNhQWIvcWdDZHF6MFRIRWlXUW51TGM3aVhB?=
 =?utf-8?B?c0dBRVJPUmNiRTdCUHNmWGl1SDNLVm9TckM3RTlyNEJTdjBMVlhkd05XR3dy?=
 =?utf-8?B?Q2JIQWR1dGMxeEZSNUUzY0lsWG56SmVYWnpPMEVzNVRCUXFvbkVHK3pGamlD?=
 =?utf-8?B?ZDN0SHQzQjAzb2RXSXlrbEQweGJuemljdyt1SzhOM1g4WVlkZkp6S0FiOHRE?=
 =?utf-8?B?TXNSNGRVenFFSENtbHlJTVVNdlZLY2ltWUh4emw0L010NldSNUxGUGZtZzJs?=
 =?utf-8?B?YWhkVDFFdUdCL2lEbkNmNmdSVGM2YlUvLzFEK3pDUVh6Y014eVZZMWt2VzBM?=
 =?utf-8?Q?mu7AqyDZuSlkAZ3lQi2wYUM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AB8ED9A9527E84489CEA1AFF98CA9A8@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f51af71a-dd00-4498-b343-08de1bed7f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 21:59:59.0416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uDGrFo6CL1+tqHBsljpbVZadtcsV6KQ8ZOjNck19TB3CMb99Wmy0Zei80wCvGLGH3+F2+qqSALcu8ql7aMPdIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5976
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE4NSBTYWx0ZWRfX63ZxPUh6MrBe
 LYUs0jXjU6A6KGgOaFINcfD8Y7MDcwv7ZbgC1atKsjuDxw8uJCfxWHTGcmXqYLTe1oyZQPfC4U0
 dPK3IvIjNs4tNMDjqob622Q0M90Is6cUlVar3WB1Dba5JVdI+w4yiDZRWqStx9iOPGZRHEObPyU
 YpDbHD9NcuW2xNiAiTy+hx+x6zRGjYN6BattHOsqwieeGmkTDgcTpdqDGmCY7aSpQJEtbilyFHx
 fpqvLtvpVji5aUnivcsRrfFvrqWFR9G61Ysrr20QX8ivgem4UKEBRR+aRLarHSWCKmvBbG6E4w6
 GfDyjTjYjIQlP1bz+BB3xAYErpj4fNOAzfgxbkimlIA1wjvV8Objb6GYX1A6maqnoqe7GQceCJJ
 GYdDkHGjJPYSNmptkgh19Q4+YnGq1g==
X-Proofpoint-GUID: xD8WDx4UuXT4Dqonaupp1xEvMn99qKW_
X-Proofpoint-ORIG-GUID: xD8WDx4UuXT4Dqonaupp1xEvMn99qKW_
X-Authority-Analysis: v=2.4 cv=Hqt72kTS c=1 sm=1 tr=0 ts=690a7767 cx=c_pps
 a=WNBGq+kRZA72juK154DUDw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8
 a=ovGfOgR4eZvFg_CmpA8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_03,2025-11-03_03,2025-10-01_01

DQoNCj4gT24gTm92IDQsIDIwMjUsIGF0IDk6MjbigK9BTSwgQW1lcnkgSHVuZyA8YW1lcnlodW5n
QGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBBZGQgYSBuZXcgQlBGIGNvbW1hbmQgQlBGX1BST0df
QVNTT0NfU1RSVUNUX09QUyB0byBhbGxvdyBhc3NvY2lhdGluZw0KPiBhIEJQRiBwcm9ncmFtIHdp
dGggYSBzdHJ1Y3Rfb3BzIG1hcC4gVGhpcyBjb21tYW5kIHRha2VzIGEgZmlsZQ0KPiBkZXNjcmlw
dG9yIG9mIGEgc3RydWN0X29wcyBtYXAgYW5kIGEgQlBGIHByb2dyYW0gYW5kIHNldA0KPiBwcm9n
LT5hdXgtPnN0X29wc19hc3NvYyB0byB0aGUga2RhdGEgb2YgdGhlIHN0cnVjdF9vcHMgbWFwLg0K
PiANCj4gVGhlIGNvbW1hbmQgZG9lcyBub3QgYWNjZXB0IGEgc3RydWN0X29wcyBwcm9ncmFtIG5v
ciBhIG5vbi1zdHJ1Y3Rfb3BzDQo+IG1hcC4gUHJvZ3JhbXMgb2YgYSBzdHJ1Y3Rfb3BzIG1hcCBp
cyBhdXRvbWF0aWNhbGx5IGFzc29jaWF0ZWQgd2l0aCB0aGUNCj4gbWFwIGR1cmluZyBtYXAgdXBk
YXRlLiBJZiBhIHByb2dyYW0gaXMgc2hhcmVkIGJldHdlZW4gdHdvIHN0cnVjdF9vcHMNCj4gbWFw
cywgcHJvZy0+YXV4LT5zdF9vcHNfYXNzb2Mgd2lsbCBiZSBwb2lzb25lZCB0byBpbmRpY2F0ZSB0
aGF0IHRoZQ0KPiBhc3NvY2lhdGVkIHN0cnVjdF9vcHMgaXMgYW1iaWd1b3VzLiBUaGUgcG9pbnRl
ciwgb25jZSBwb2lzb25lZCwgY2Fubm90DQo+IGJlIHJlc2V0IHNpbmNlIHdlIGhhdmUgbG9zdCB0
cmFjayBvZiBhc3NvY2lhdGVkIHN0cnVjdF9vcHMuIEZvciBvdGhlcg0KPiBwcm9ncmFtIHR5cGVz
LCB0aGUgYXNzb2NpYXRlZCBzdHJ1Y3Rfb3BzIG1hcCwgb25jZSBzZXQsIGNhbm5vdCBiZQ0KPiBj
aGFuZ2VkIGxhdGVyLiBUaGlzIHJlc3RyaWN0aW9uIG1heSBiZSBsaWZ0ZWQgaW4gdGhlIGZ1dHVy
ZSBpZiB0aGVyZSBpcw0KPiBhIHVzZSBjYXNlLg0KPiANCj4gQSBrZXJuZWwgaGVscGVyIGJwZl9w
cm9nX2dldF9hc3NvY19zdHJ1Y3Rfb3BzKCkgY2FuIGJlIHVzZWQgdG8gcmV0cmlldmUNCj4gdGhl
IGFzc29jaWF0ZWQgc3RydWN0X29wcyBwb2ludGVyLiBUaGUgcmV0dXJuZWQgcG9pbnRlciwgaWYg
bm90IE5VTEwsIGlzDQo+IGd1YXJhbnRlZWQgdG8gYmUgdmFsaWQgYW5kIHBvaW50IHRvIGEgZnVs
bHkgdXBkYXRlZCBzdHJ1Y3Rfb3BzIHN0cnVjdC4NCj4gRm9yIHN0cnVjdF9vcHMgcHJvZ3JhbSBy
ZXVzZWQgaW4gbXVsdGlwbGUgc3RydWN0X29wcyBtYXAsIHRoZSByZXR1cm4NCj4gd2lsbCBiZSBO
VUxMLg0KPiANCj4gVG8gbWFrZSBzdXJlIHRoZSByZXR1cm5lZCBwb2ludGVyIHRvIGJlIHZhbGlk
LCB0aGUgY29tbWFuZCBpbmNyZWFzZXMgdGhlDQo+IHJlZmNvdW50IG9mIHRoZSBtYXAgZm9yIGV2
ZXJ5IGFzc29jaWF0ZWQgbm9uLXN0cnVjdF9vcHMgcHJvZ3JhbXMuIEZvcg0KPiBzdHJ1Y3Rfb3Bz
IHByb2dyYW1zLCB0aGUgZGVzdHJ1Y3Rpb24gb2YgYSBzdHJ1Y3Rfb3BzIG1hcCBhbHJlYWR5IHdh
aXRzIGZvcg0KPiBpdHMgQlBGIHByb2dyYW1zIHRvIGZpbmlzaCBydW5uaW5nLiBBIGxhdGVyIHBh
dGNoIHdpbGwgZnVydGhlciBtYWtlIHN1cmUNCj4gdGhlIG1hcCB3aWxsIG5vdCBiZSBmcmVlZCB3
aGVuIGFuIGFzeW5jIGNhbGxiYWNrIHNjaGVkdWxlIGZyb20gc3RydWN0X29wcw0KPiBpcyBydW5u
aW5nLg0KPiANCj4gc3RydWN0X29wcyBpbXBsZW1lbnRlcnMgc2hvdWxkIG5vdGUgdGhhdCB0aGUg
c3RydWN0X29wcyByZXR1cm5lZCBtYXkgb3INCj4gbWF5IG5vdCBiZSBhdHRhY2hlZC4gVGhlIHN0
cnVjdF9vcHMgaW1wbGVtZW50ZXIgd2lsbCBiZSByZXNwb25zaWJsZSBmb3INCj4gdHJhY2tpbmcg
YW5kIGNoZWNraW5nIHRoZSBzdGF0ZSBvZiB0aGUgYXNzb2NpYXRlZCBzdHJ1Y3Rfb3BzIG1hcCBp
ZiB0aGUNCj4gdXNlIGNhc2UgcmVxdWlyZXMgYW4gYXR0YWNoZWQgc3RydWN0X29wcy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEFtZXJ5IEh1bmcgPGFtZXJ5aHVuZ0BnbWFpbC5jb20+DQo+IC0tLQ0K
PiBpbmNsdWRlL2xpbnV4L2JwZi5oICAgICAgICAgICAgfCAxNiArKysrKysNCj4gaW5jbHVkZS91
YXBpL2xpbnV4L2JwZi5oICAgICAgIHwgMTcgKysrKysrKw0KPiBrZXJuZWwvYnBmL2JwZl9zdHJ1
Y3Rfb3BzLmMgICAgfCA5MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IGtl
cm5lbC9icGYvY29yZS5jICAgICAgICAgICAgICB8ICAzICsrDQo+IGtlcm5lbC9icGYvc3lzY2Fs
bC5jICAgICAgICAgICB8IDQ2ICsrKysrKysrKysrKysrKysrDQo+IHRvb2xzL2luY2x1ZGUvdWFw
aS9saW51eC9icGYuaCB8IDE3ICsrKysrKysNCj4gNiBmaWxlcyBjaGFuZ2VkLCAxODkgaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYnBmLmggYi9pbmNsdWRl
L2xpbnV4L2JwZi5oDQo+IGluZGV4IGE0N2Q2N2RiM2JlNS4uMGY3MTAzMGMwM2UxIDEwMDY0NA0K
PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2JwZi5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvYnBmLmgN
Cj4gQEAgLTE3MjYsNiArMTcyNiw4IEBAIHN0cnVjdCBicGZfcHJvZ19hdXggew0KPiBzdHJ1Y3Qg
cmN1X2hlYWQgcmN1Ow0KPiB9Ow0KPiBzdHJ1Y3QgYnBmX3N0cmVhbSBzdHJlYW1bMl07DQo+ICsg
c3RydWN0IG11dGV4IHN0X29wc19hc3NvY19tdXRleDsNCj4gKyBzdHJ1Y3QgYnBmX21hcCAqc3Rf
b3BzX2Fzc29jOw0KPiB9Ow0KDQpJbiB0aGUgYnBmLW9vbSB0aHJlYWQsIHdlIGFncmVlZCAobW9z
dGx5IGFncmVlZD8pIHRoYXQgd2Ugd2lsbCBhbGxvdyANCmF0dGFjaGluZyBhIHN0cnVjdF9vcHMg
bWFwIG11bHRpcGxlIHRpbWVzLiANCg0KVG8gbWF0Y2ggdGhpcyBkZXNpZ24sIHNoYWxsIHdlIGFz
c29jaWF0ZSBhIEJQRiBwcm9ncmFtIHdpdGggYSANCmJwZl9zdHJ1Y3Rfb3BzX2xpbmsgaW5zdGVh
ZCBvZiBicGZfbWFwPyBUaGlzIHJlcXVpcmVzIG9uZSBtb3JlIA0KcG9pbnRlciBkZXJlZiB0byBn
ZXQgdGhlIHBvaW50ZXIgdG8gdGhlIHN0cnVjdF9vcHMgbWFwLiBCdXQgdGhlIA0Kc29sdXRpb24g
d2lsbCBiZSBtb3JlIGZ1dHVyZSBwcm9vZi4gDQoNCkRvZXMgdGhpcyBtYWtlIHNlbnNlPw0KDQpU
aGFua3MsDQpTb25nDQoNCg0KDQo=

