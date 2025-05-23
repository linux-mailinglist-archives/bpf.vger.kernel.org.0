Return-Path: <bpf+bounces-58857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D965FAC29D2
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 20:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DBE3A6026
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 18:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309E1299AAD;
	Fri, 23 May 2025 18:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="WRfl29l8"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DD347F4A;
	Fri, 23 May 2025 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748025315; cv=fail; b=GhDgUbKh/ejHBiVBnWUPil4q3Nvju0jUO9GBMoJRzHIhaIWlkdbAja+9FWjTVH9s6GoCRDBGFX8/k0uOrIoV3woaJhCdKIwpyq9duBMi4rxBYgd9LzJOs18yK1B3ihecWc4IIAX1eJj3bfKTSdOrZHsSMLXcbOsHgu6l4jYclMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748025315; c=relaxed/simple;
	bh=CkLWVAUW/TBJhe1to6gGXbHx2IgeQ6UQ4m5cG0IPTs8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TGe1WdZaQDIqg+39T562tIQ5gd6DZQjwLYaDOgMKgRbc1A5yItZ7c/caPeYCIkGQXJMY7kAX2mpWwVjq8mCvPDMVf0U4m1YPSfa/1HpgqBZBiEhmdmb0iQHYBp7z6z9QaVLrzShN3qtypp1K/uA5cTQQA/I0PzDLQzqVWzHkRLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=WRfl29l8; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NINnZF028891;
	Fri, 23 May 2025 11:35:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=CkLWVAUW/TBJhe1to6gGXbHx2IgeQ6UQ4m5cG0IPTs8=; b=
	WRfl29l8uSgRQvL4iB3q3jrQHOdwzD/fPL5y9yGJ2HbNBRgSnblTsyzLX3Ze3VYv
	WvwjWDHxG/sXtE2wHtjZ2mVOOqw/3WeQU1wpVomIwiSLq6xJHtOjI+CU3C7g0pYY
	+OSaSIlQh79uG7Yy1rjV3JSGR1jg8NNzx5ZgEm28BV9jPjGKVF9Uywj5KP25YS1Q
	905+aW0xwdCPh/fP+mvudI6LcD6bnn/rZHmQI5KI3wwg9yG3pDJGf1lkcFTZyDcq
	12D4c+v5qnPbBh70dTD43N/AAAPErsjyTo0CNjdPEiQzInrSmxDSVZgl6k49Uqji
	HK1V+ezKGY0jqiyysKWrnw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46sxy1dap6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 11:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yABp45ThxXjpnk/dUtKzYwY/Avb9XyA9eABNH+CQXAQEQHL+IzEGobyBGliMha8SXVhoiuO6ia3PnhX75hU9VeVagJWuxSayM9nTO5LAhAuON0RdiVhaWctQNHTI+ZLrSij5o5B6H53mhl2juFjLtQwSCiIPch0dMw5OcU3X3rKsn/9aQawgs01E7C6jfpjfbIrMZwI/JuCAbMQ/egzBJe9JQX+WxU7T165kgXyxgeAbgrI8pElmQzRoKSNuo04mYfvEGIjBpIZE1R3aVOi+mQ738jUHB7RHh2XMc28o4FlTvW/02XrNGctCftdmzQwySxaCFSgHXgXi+9Am3aiQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkLWVAUW/TBJhe1to6gGXbHx2IgeQ6UQ4m5cG0IPTs8=;
 b=OXnCYBh5Wlwr/+/1cFB2f2CCprfhJ1kTIPvwaGAyHhBOnF3Dyc9UUw2qp0OisoY/o6Q45vb2/3QT50bwIFzUzPKttgzFkG5/7YGqZQFsa0ajwemP4tR9N4XVS46u+Sb3AksSUztEI/qUlEKV9nfuQtQCYztFA+5CalkC6d2vhsmn0D1+4IWwSgO1gRr66+6jQqRe1AfZlg1JTa9nP1td4RpMcmZaSyYKgvd2BF2qB7J+RBUb06wi9I0qDsPHZZy9fKlT2iwNSMjqBpf/eeWf7YnN/FEEWsQ+LJ5LKVr4sNOT46kqONMyIKLDERXS5TqIl+1/bZQp9f8xB+Qkox/yFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5671.namprd15.prod.outlook.com (2603:10b6:a03:4c1::19)
 by MN6PR15MB6121.namprd15.prod.outlook.com (2603:10b6:208:474::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Fri, 23 May
 2025 18:35:09 +0000
Received: from SJ2PR15MB5671.namprd15.prod.outlook.com
 ([fe80::a025:a1d3:960b:9029]) by SJ2PR15MB5671.namprd15.prod.outlook.com
 ([fe80::a025:a1d3:960b:9029%7]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 18:35:09 +0000
From: Thierry Treyer <ttreyer@meta.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Alan Maguire <alan.maguire@oracle.com>,
        "dwarves@vger.kernel.org"
	<dwarves@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>, "ast@kernel.org" <ast@kernel.org>,
        Yonghong Song <yhs@meta.com>, "andrii@kernel.org" <andrii@kernel.org>,
        "ihor.solodrai@linux.dev" <ihor.solodrai@linux.dev>,
        Song Liu
	<songliubraving@meta.com>, Mykola Lysenko <mykolal@meta.com>,
        Daniel Xu
	<dlxu@meta.com>
Subject: Re: [PATCH RFC 0/3] list inline expansions in .BTF.inline
Thread-Topic: [PATCH RFC 0/3] list inline expansions in .BTF.inline
Thread-Index: AQHbrwS3AlS1roAfS0S+1p7h6I+KLrPaDacAgAUZ8gCAAYvbgIAAEUcA
Date: Fri, 23 May 2025 18:35:09 +0000
Message-ID: <9980C8A1-CEBE-4B35-90B2-9DB5DCEF7616@meta.com>
References: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
 <d39e456b-20ed-48cf-90c0-c0b0b03dabe6@oracle.com>
 <09366E0A-0819-4C0A-9179-F40F8F46ECE0@meta.com>
 <CAADnVQ+SeJfjTRSdz=UYjYNhS9HMDriWfYyd==fLB1XBMSMdxg@mail.gmail.com>
In-Reply-To:
 <CAADnVQ+SeJfjTRSdz=UYjYNhS9HMDriWfYyd==fLB1XBMSMdxg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5671:EE_|MN6PR15MB6121:EE_
x-ms-office365-filtering-correlation-id: da677e33-53ca-4e9a-8da8-08dd9a288bfb
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WENISmNzbWNTWENMS1ZrNFZMNDlwN1h5a01Wb3I3RVZoek9McThzV2dmZ0lr?=
 =?utf-8?B?TUUxSldqUzdncm1ERXM2dUE0R3pqZGFNQ0ZINzFrVHFsU091ZkN2QlZ2aUEx?=
 =?utf-8?B?enZhVE1LUTU2VGQxVFlIK0k0TWk4QlBCZTlWQjg1Z2tOemFoUWFlOU9VM1h1?=
 =?utf-8?B?M2x5UmFTZkN0ZzN2OW5LWUkzUEpJcWFpZ29Uc1UyemNoMDZwMkZSWW1JSmYy?=
 =?utf-8?B?WU5XVHhtNUNST1c1V1BBak05QmQ1Vzl0TGR2cWhVaHhzdVNmMjVVWVR3SHp4?=
 =?utf-8?B?M05nWXl5L2h6dXhMTzd0Q3BMK1NieHFrVzRlbCtwSWNGYUtnMUd0MzVtSUxZ?=
 =?utf-8?B?WjY0U2c1L3hKeVdjemdMTFdsYmF1N2l4NnVYYURNSGkveGs4RlhTdElzY2wx?=
 =?utf-8?B?VFdWYkl2aERrVlJ4UjN6WjFERGw0OVAxUEdIdzZ4ZnBWa2VjNDlpUXM2QWFK?=
 =?utf-8?B?NkdORlZxVnd5RnlxNGM4VUpjbnpJeUlMdS91UlFmcm1hZG1hWFJMMWVCM1VV?=
 =?utf-8?B?V1IrZ3lDYldRajVyck9RSGFENXFkL1o3ZjVVRFQ5WXF6NE1xa1paa0JXYkwr?=
 =?utf-8?B?a3RSWGJtbFA0UkYzR0ZkbmwvZG5CN2xUejZqL2RMM2NxaTNNZEd3WGhtSVp1?=
 =?utf-8?B?b01ja253V1JYeVh5cTdKcDJJbEtCaGF4OW9EMEE0OUhTdTFEc1V6RWJoUlUv?=
 =?utf-8?B?STh5cFdQRmFlNFIrTmIyMU9vT2NzWUlydlpleUZGN3ZWdHdQQWtITDVNNSty?=
 =?utf-8?B?Q0pSa0xoeDNLdG55cXo3aEk4M2hSMjVxS0RGOERVaWxtUUdBd0xGUkwvd0pq?=
 =?utf-8?B?NmNWWW5ZZzdEQzhyekVoZ0VsWS8yTnV1ZXJtclpyQ3lpMVU2SW54RzdTYldF?=
 =?utf-8?B?QnU4c0wraUdNdzVBUFZpV3dUK2VCcVY2ekI2aGhmakNJQUkvZ1VXZHNyenQ3?=
 =?utf-8?B?SThlREQ0dHhaemFEYzNZdkZDamhaTkorTUlMWjhLS1ZCd01RdDFBQ1FPRk9l?=
 =?utf-8?B?OXRTZFhlRW0ydzVOcHR6R3MwWTI4VExSclU0UHVJdkpBUTQ0MDFyd1VqbDdE?=
 =?utf-8?B?cVRxbzVSeDdkdDhxM1Yzam5LVnVNaWlCR08zUWR1eEpxbmZiaHhRbHduVXI2?=
 =?utf-8?B?cmxtMWEvMGg1ZndJbE1aRXlCZ1BzblYrUXFOcTBPWjhSRG14SDVrK2NjTzZK?=
 =?utf-8?B?cW5MTEFOYVg3WFNCQnFQVGRUZG5rSk9GbENZK3NkMFEyS3hHKzFtalhQcTdv?=
 =?utf-8?B?bDcvaWFPaG1GMitqODgrcEJkVHcrY1dXbEI4QWpLb1NmTnhiaCszdlNmR2Zz?=
 =?utf-8?B?UlYyZ2VZcCtsby9JTEdDdmdGQm82N0RKQTV0WlNidGxHR1VBT2srOVhqVFZ6?=
 =?utf-8?B?V3Q3dzNEcTM1M1A4L2FpbjViajl2cFBXbnQ1YU9NcGJJN1hCWlRVMmFCbDFC?=
 =?utf-8?B?ZEtlRjNadUpEaXM5bHpYMkk2QmdaeGtHUW9TR3BtWkFyQW5iWU41eTRBZlNG?=
 =?utf-8?B?WEw2blphRkxabnc1VnM1OTVkWDQwVE9qdDR5b1VnVXpMVVNoUXJPclpRN1dn?=
 =?utf-8?B?d3BTNFFFcEh2LzV5Mk54cHE3c1lRVEg2VWIxbXJLajM5eFdIeWRjbFJHWjJt?=
 =?utf-8?B?bUNyek1FOWI2TlRUbFpmR1pQRXBoUHphbnlDOVRXSU5oTThQb0QrRGdqbjh4?=
 =?utf-8?B?YWIzcE9Mc0MxL09vUlgxSmRVT2ZkR2ozTVFuM3RGZ2pJTjBCSUZiRCtVVDNx?=
 =?utf-8?B?WWYwdHRwOC9CeWJ0NWQ3RGhlZjVWNVRLa3F1TituUVFkTjR0T3MxY016YURC?=
 =?utf-8?B?RDFlMWhXWCtIdTJMR3Y0M2g2Z091aTczUXJ6WGtoV0xRaFNPOUJFZ0hGVnJo?=
 =?utf-8?B?KzVPN01GQS92K0pycWJ5M2k5K3UyYWpZejkwQ2l5MUpHRWFqOGY1UE1GRjI2?=
 =?utf-8?B?TEtxaVVYNFBSNGtYbVZwemhHZ3RFUWZQWHYzenVteFZ1OStIYnJycUtnbExI?=
 =?utf-8?B?ZUhmb054aEVnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5671.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a2w0M1RsRzZ1enNhZm9Qa3htYStnbFlzSzJBeU9jclN0Uk1vdktGUkQ1c1J4?=
 =?utf-8?B?MUhnMWxpN0JkU1dUMCtVRHA5Y3lvcmJtNUxacURaRExKOFlmMHJrMkpKL0Zq?=
 =?utf-8?B?RnpBcTdUY2E3NFlXTWZ5T1l2YmRPUm8xUnVOdGlHU3RsWGxzblZIZDVrT0Rt?=
 =?utf-8?B?UkxwUDJhQXh3YkNSSzJXSmlBZjg1cFZXdkVHWlhwa1ZRSzVRZTIzZUVQMkpm?=
 =?utf-8?B?Ky9zbUw2Q0NCeFRKZEUvTk9ZSmJCcE1XTlRjNXF4WFNLcWtBK0toMWJlbEpH?=
 =?utf-8?B?eERxdEVYdlBieVVabUdacllrdWw5WWRTRXFzL0pFTFhnTzBqSmEraUpGWXpt?=
 =?utf-8?B?U0xYU2FsM3FFZUJTNjYrKzNlak81TldLUktJdUo4Vkd2bjRJT3pwWlk3YXho?=
 =?utf-8?B?aGZoMlh0bDRYZTdpNEFWbjd3ZVZCNXRteEFmM0RvTjZnVGt5ekZES092L3Fh?=
 =?utf-8?B?Y1ZDUld4WFNqSTFmaFV4Y1J0azI0MnFpS3dVbHVyWHdpZUtYMFozbzlJR254?=
 =?utf-8?B?U2s2S01Wa3piMnpjY2dvVXhFMU10bHlsN1RJY3VreUVJQWNVcC84ZlJ6N0Fu?=
 =?utf-8?B?QkJLdE8zb0czWGJ6RWZqckZmQzdYSEplUndIdnBMNW5waG5mVVlOMjVUY2dZ?=
 =?utf-8?B?NjdpenlyMVd4Qk04K3ZDbEV5S3ZkbDArUUQrdDFGN1hmMk0zbFBRdDNRT1p0?=
 =?utf-8?B?UUhZL1F1NHBnZ1BlWTVQSlZvSGRmK3pYZlc4cTY2Q3JnVnhYNGgzY21UWDc5?=
 =?utf-8?B?bkwySENzbllWRURYMU00WnI1VXJuYkJ1a2ltQjdnZ0RHT2tvSmdoTlJsQ0tz?=
 =?utf-8?B?aEVLeFlhSkZHVUIrODlRQm83M05mdlFnZmkvbzF3ME1iS3pxVTkxbkxxVVU5?=
 =?utf-8?B?dFNmS0N6KzJudXg1N1BtTUo3RERpV3c4RjRtRytzSUZZbDRTSnRNNEozY3k4?=
 =?utf-8?B?OGdRaHluRC9VTllwbVZZbmoxNDlVNFZVMCsvWkhBT1EvVDY1emRHYWlvcmdh?=
 =?utf-8?B?dGFoSHhJdHFKQ0czMXg0dGVVT3JGR2UwblprMTdyNTZRV3BjZ2p5VlJKNG1Y?=
 =?utf-8?B?K1hmZWtNUms1N1BCNWpVSW9yUDdPcUlXRzV0K1B3Y29qcy9VNEU2QkU0Y1pP?=
 =?utf-8?B?aHVsQ3RTbXU3YlB4VzhKREhEbEpMaStGUnFXV3NZNzFybnRIMnlXQ3lRQlUr?=
 =?utf-8?B?WHYvcVdqS003cm5WQUZESC9GZ3o2cVpmcUtNYXFXOXE1d3ZZdG5wMXVVSkFO?=
 =?utf-8?B?Z0FPU21CL0xFeGovQWszVTdmNEhPaHVtYll4elcxZDhKRUFWeWU4dWdpMExM?=
 =?utf-8?B?dmFTM2lOQjBBM3lOODRVT0FIUTBkc1hZUXN6NnEreFp5K0Rqd21zL3hESXFt?=
 =?utf-8?B?aGcwQ0pkTENhYWxBenZUZ2JFQ1hqVmkwZ3pyc1AvTVcyU3Fpcjc5SDJ5cGNi?=
 =?utf-8?B?b212dllIaUVSWFREaXc5bjliL3I5ajhrNFE4MzYxZkZDUEhHWnp6c3B1ak8v?=
 =?utf-8?B?SThZOUdxQURaVmFwQktDdStCS214b1Avb2VCbm5zbmFhdnk3WXJNY0cvTXJF?=
 =?utf-8?B?UVZnUjZoeVdlMU9XOVJ1ZlBuS0U4eUo4OTVKYmNhSFkxZ2xEbWlQdHdTemdC?=
 =?utf-8?B?UGpvTEdVRllJeVZmUkZrZjl5MUtEU21NMGxrMStoOWhkYmJjd296S2UvOXZG?=
 =?utf-8?B?TE9Dd0l3b3ZmYUZrVnlONnVYMGRLZ0FJeHNnNHQyODc5VE1Vc0VqNVNETXFB?=
 =?utf-8?B?c3p6dStkYS9KajlRSDdoZlJtNFg2M3NkVWdtK05vWWJkUlZjWEo1WS9jZ3hM?=
 =?utf-8?B?anBkZUNVMlJTS3ZGckNXR0NLQi9YNDdoTnRmNUcrTEdzTjVKN1lBVXRBUHR3?=
 =?utf-8?B?WXVMMlUybHRsMEVWNk1xOWNpdXh0b3ZCSlRqdHZidHBrK2JhZVRuRkpwL1Rq?=
 =?utf-8?B?WXpQRkNXem1XRnBLYmc2QklQVkNVZnE3aHVSYm9pSnNxMmQ2Vy9RODBJenJL?=
 =?utf-8?B?bFRFQjRHcUdMa1BlQkdBcEREUk5PV0JZU0c1UmRkRG5rRlF3OXA5U3NkemVo?=
 =?utf-8?B?NHVUcysrRHFHTy9sRnMxWmJtNVluRGZjMTVJY2FkYUYrM0VlTDc0aEpacjZa?=
 =?utf-8?B?a09wWThRd1BOU3kxT2ZqaVBkeFhHbGxFMUZqeHVPY1p2b3hyUVZLb1VsRXhs?=
 =?utf-8?Q?4q5IhrvPzKVH8oRH2bVnWT8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <050FFB3BBF012143B6A60CCA4CE70C24@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5671.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da677e33-53ca-4e9a-8da8-08dd9a288bfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 18:35:09.3798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MaP16e37oR7Ys8itnRmbHmENQLJVZBHrhEfrMhftB+CMcYF9sihjiVswbE4fluVETngcARjw9mbvOGLaAHCokA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR15MB6121
X-Authority-Analysis: v=2.4 cv=dtzbC0g4 c=1 sm=1 tr=0 ts=6830bfe1 cx=c_pps a=jp/Y3J+1q1HyW0yI7KzyLA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=MXWK12fs9hgI1_gbLCAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4-cekoxdQgQFV2ZnTiyB-spEo4lmk8PC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE2OSBTYWx0ZWRfXxJZCq3Yh+S7N WuafigXkQmde9oLm08nyWpKUs3vStEb/1miQ5FQBnh96Joj6PwyAnU1OPTDKZxlGIRxIWhxK3Sy K6uG3KPhmhPX2NnTkUTEX9oKrWYqYKZMOvYXS4dLGu5nZPAaq5uv2tNkdCUfVJF7f8ox5pt2WHc
 4YkZSC1fGsOMVFT8fvsysEFntoHEHD8Sw5onZ8Favq6ttrhwTWuvAPz6+zGS3Z7NBAHgpnTWTQn oGYFNU3GQ+XAfdUqPKTs8dhrhWCivZRy9jQiye5bNzRtgQcKOqK7vANwFnJV6UDf0Y6jvzf+WPu LxCbOBDRrJl7flUPAUsvy+jAJ6vx61/B8TmP5Bb74FuzcpiLn+RRtx44fRtBTDMtaeJqTGPnffp
 Lvo6kjM1J3VzpBr4NhBNXK+k7DrUJ+FX3ibp1RGv8vqIejNmyLz6lxfF28f8WFcSSsX/F4+B
X-Proofpoint-ORIG-GUID: 4-cekoxdQgQFV2ZnTiyB-spEo4lmk8PC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_06,2025-05-22_01,2025-03-28_01

PiBJIGZlZWwgdTE2IG9mZnNldCBpc24ndCByZWFsbHkgdmlhYmxlLiBTb29uZXIgb3IgbGF0ZXIg
d2UnZCBuZWVkIHRvIGJ1bXAgaXQsDQo+IGFuZCB0aGVuIHdlIHdpbGwgaGF2ZSBhIG1peCBvZiB1
MzIgYW5kIHUxNiBvZmZzZXRzLg0KDQpXZeKAmXJlIGFscmVhZHkgdXNpbmcgMjIlIG9mIHRoZSBh
ZGRyZXNzYWJsZSBjYXBhY2l0eSBvZiBhIHUxNi4NCkl0IHdvbuKAmXQgZ2V0IGFueSBiZXR0ZXIg
d2hlbiBpbnRyb2R1Y2luZyBtb3JlIGxvY2F0aW9ucy4NCg0KPiBUaGUgbWFpbiBxdWVzdGlvbiBJ
IGhhdmUgaXMgd2h5IGZ1bmNzZWMgc2l6ZSBpcyBiaWdnZXIgZm9yICgxKSA/DQo+IHN0cnVjdCBm
bl9pbmZvIHsgdTMyIHR5cGVfaWQsIG9mZnNldCwgcGFyYW1zX29mZnNldDsgfTsNCj4gDQo+IHRo
aXMgaXMgZml4ZWQgc2l6ZSByZWNvcmQgYW5kIHRoZSBudW1iZXIgb2YgdGhlbSBzaG91bGQgYmUg
dGhlIHNhbWUNCj4gYXMgaW4gKDIpIGFuZCAoMyksIHNvIHNpbmdsZSB1MzIgcGFyYW1zX29mZnNl
dCBzaG91bGQgYmUgc21hbGxlcg0KPiB0aGFuIHUxNlthcmdfY250XSwgYXNzdW1pbmcgdGhhdCBv
biBhdmVyYWdlIGFyZ19jbnQgPj0gMi4NCj4gDQo+IE9yIHlvdSBtZWFudCB0aGF0IGF2ZXJhZ2Ug
YXJnX2NudCA8PSAxLA0KPiBidXQgdGhlbiB0aGUgbWF0aCBpcyBzdXNwaWNpb3VzLCBzaW5jZSBz
dHJ1Y3QgZm5faW5mbyBzaG91bGQNCj4gYmUgNC1ieXRlIGFsaWduZWQgYXMgZXZlcnl0aGluZyBp
biBCVEYuDQoNCkF2ZXJhZ2UgYXJnX2NudCBpcyAxLjI3Nywgd2hpY2ggaXMgd2h5ICgyKSB3aXRo
IHUxNiBpcyBzbWFsbGVyLg0KSSBkaWQgbm90IGtub3cgYWJvdXQgdGhlIHJlcXVpcmVkIDQtYnl0
ZSBhbGlnbm1lbnQgb2YgdGhlIEJURiENCg0KPiBBbHNvIGZvciAoMyksIGlmIGxvY3MgYXJlIGlu
bGluZWQsIHdoeSAiTG9jYXRpb25zIFNpemUiIGlzIG5vdCB6ZXJvID8NCj4gT3IgdGhlIG1hdGgg
Zm9yICgzKSBpcyBhY3R1YWxseToNCj4gc3RydWN0IGZuX2luZm8geyB1MzIgdHlwZV9pZCwgb2Zm
c2V0IH0gKiBudW1fb2ZfZnVuY3MgPw0KDQpTb3JyeSBmb3IgdGhlIGNvbmZ1c2lvbiwgSSBrZXB0
IHRoZSBudW1iZXJzIHNlcGFyYXRlZCwgYnV0IHRoZSBsb2NhdGlvbnMgYXJlDQppbmRlZWQgaW5z
aWRlIHRoZSBmdW5jc2VjIHRhYmxlLg0KDQoNCg0KVXBkYXRlZCB0YWJsZSB3aXRoICgyLXUxNikg
YW5kICgzKSBhbGlnbmVkIHRvIDQtYnl0ZXMsIGFuZCBhZGRlZCAoMi11MzIpOg0KDQogIFBhcmFt
cyBlbmNvZGluZyAgICAgICAgICAgICAgICAgTG9jYXRpb25zIFNpemUgICBGdW5jc2VjIFNpemUg
ICAgICAgIFRvdGFsDQogID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQogICgxKSBwYXJhbSBsaXN0LCBubyBk
ZWR1cCAgICAgICAgICAgICAxLDAxNyw2NTQgICAgICA1LDQ2Nyw4MjQgICAgNiw0ODUsNDc4DQog
ICgxKSBwYXJhbSBsaXN0LCB3LyBkZWR1cCAgICAgICAgICAgICAgIDE4NywzNzkgICAgICA1LDQ2
Nyw4MjQgICAgNSw2NTUsMjAzDQogICgyKSBwYXJhbSBvZmZzZXRzIHUxNiwgdy8gZGVkdXAgICAg
ICAgICAxNCw1MjYgICAgICA1LDMyNCw4ODggICAgNSwzMzksNDE0DQogICgyKSBwYXJhbSBvZmZz
ZXRzIHUzMiwgdy8gZGVkdXAgICAgICAgICAxNCw1MjYgICAgICA1LDk3Miw0NjAgICAgNSw5ODYs
OTg2DQogICgzKSBwYXJhbSBsaXN0IGlubGluZSwgdy8gYWxpZ24gICAgICAgICAgICAgIDAgICAg
ICA1LDE3MiwyNjggICAgNSwxNzIsMjY4DQoNCigzKeKAmXMgYWR2YW50YWdlIGlzIG5vdyBtdWNo
IHNtYWxsZXIuDQooMinigJlzIHNpemUgYWxzbyBpbmNyZWFzZWQsIGVpdGhlciB3aGVuIHVzaW5n
IHUzMiBmb3IgdGhlIG9mZnNldHMsDQogICAgICBvciB1c2luZyB1MTYsIGJ1dCBrZWVwaW5nIGlu
IG1pbmQgdGhlIEJURiA0LWJ5dGVzIGFsaWdubWVudC4NCg0K

