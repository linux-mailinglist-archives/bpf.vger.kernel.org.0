Return-Path: <bpf+bounces-61483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC60AE753E
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 05:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933ED1922E92
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 03:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9292318871F;
	Wed, 25 Jun 2025 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cQA2CtB2"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773A5307489
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 03:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750822281; cv=fail; b=aIOSqiCulV94kDkQhV0e2oh54c+kUvgOuKWSuhh8Az3EVrOAplAWlPYYneqBs93HkGfaf7xEtq6Pm5yXcXHZJL+n5ZzK0DZy949CYWR4grUJ+2Jk8+gp3gRZ3VD7dv7Ni0pAgK3cgTKdiEZNc/Db8rQ5iB06lFF1tqQbL3pBFdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750822281; c=relaxed/simple;
	bh=6uOXA2/yUMbjvoKCOzo+I2yH02V4mcGS00bw5R3c80M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cj+vUer2ejHUPkOYtLL9GCydb+IWyXvcwE5RYEtl/asYDh6t5c360mFvOsAkbes3BOJPHO0+viYPCOiPi6o7lKCFPNenHWLZKobBjJGjqX1Hta3NtiwUGck5mqZOhjDCblz2h3yojlvOUf5Q8LvqHjBgPtlimcXdWMQu8Hd0P6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cQA2CtB2; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P22Ilq015988
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 20:31:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=6uOXA2/yUMbjvoKCOzo+I2yH02V4mcGS00bw5R3c80M=; b=
	cQA2CtB2pWYMaPwG4K59q01isJMYhFO6JBzsmHsjiYYUs1PXFUM6ZDSJzuzkQbzL
	DxqbFQ1mK2IzSGlS6LsWwuZRD5Qjuf+VcoU8bPueZ3hN+x/rCI8VejEqSTmjnZ/Z
	sWyAKGgAttQvWygH3A2oV7w44Kef7I9NhjppR/oS0UnD2gN/fEBjCPUo5DRvFlhF
	POxRBDdIOTGDnXMtW7rTlw9nToip9aRxxq7AWqnMoLjN1XKu0BRasuhVhRqNDivZ
	yOQ+NT+cbnoP8PBrqQ9oTGhaYKsVP8lFJ3TG6Wc6NFits/9OLIv4uSyTuk9BHOt2
	aknK/Yi4WBErG+KMCNKqtg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47g00ebubp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 20:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxhcWWpphOT+++gp6qD7xMF7fmo7qspz2IPt6zWslnVJksyyM6RukMPYkkypQhnFrcvMzrS5vC4FGmUqn4n+P+h8VgRLPaYkjuf8Zr+87Yx7Dei3elRreo3EojJc4xcaBxO8nR+R6cdzeOA7dYT9AcVucifdENIcDBBD/NiJshFBEg0H8mjllEO3K9aPFol6OYqH16aPicFDMlM7D7P9jwacqwR5MhiRBAW603M69dfiz7NmohRX9RBQ1N8yuiDC4DzblF8OkU5BSnB4i24jiOq0ZTCupY9mEJiW6RZ/+8/ZNwRYzmnBrTZ3/pQbqdIhVUJUBPF4Q/UPHix/hCAZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uOXA2/yUMbjvoKCOzo+I2yH02V4mcGS00bw5R3c80M=;
 b=acbAq2gPfdKKtGx/3czhwyJc+NhVwLmmwZSXqIADZFSAJNqVuFDfzCRSWQspwMC+QoDGsIRVS3LrGJFK9flgSacXqGGiluieqj7+HPCAloehLc9z/9o0VXwOKnjIMO4Pdm7mpSRo+Kv/K/IKVbPy+nttWtPipjZpn2R0KOSx2hVkS137kPbPd5gDYL3BmXjZkv5ZF2/J68ilkU4cEOU4yACsy+GigIlV3RtGlFn2wJeWCugrcZZ/cBSS638ukcawdV48OmeYfpwublT7SWVlXD4EdlGIE6EbMyjZ6ebuYypTRrtnLpe90BRI/q2IYN5szYuw08HdxNCMo0teThVyKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB4403.namprd15.prod.outlook.com (2603:10b6:806:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 03:31:14 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%6]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 03:31:14 +0000
From: Song Liu <songliubraving@meta.com>
To: Eduard Zingerman <eddyz87@gmail.com>
CC: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net"
	<daniel@iogearbox.net>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Add range tracking for BPF_NEG
Thread-Topic: [PATCH v3 bpf-next 1/2] bpf: Add range tracking for BPF_NEG
Thread-Index: AQHb5WBrUL6rlaGHZEmv4DRfiTbcVbQTBbqAgAAyrIA=
Date: Wed, 25 Jun 2025 03:31:14 +0000
Message-ID: <5BA1ABB5-B13D-4AAA-B357-4F6B0940F3DF@meta.com>
References: <20250624233328.313573-1-song@kernel.org>
 <20250624233328.313573-2-song@kernel.org>
 <7aa3235b66f293228ab43b8fe876723a7aff67d5.camel@gmail.com>
In-Reply-To: <7aa3235b66f293228ab43b8fe876723a7aff67d5.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA1PR15MB4403:EE_
x-ms-office365-filtering-correlation-id: 38c404cd-b81e-4254-ff14-08ddb398bcf6
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R1ZPTEFjNlNSdkRQckFYbHBjcTNza3BuVE4vbkwwMTlTclRoaXBKZjNyaGJY?=
 =?utf-8?B?ZjlJSDNwT3ZDS2VWOE50aWhjbWdlSyt0SjB4SkNuekpyU2xOOE9yYjVqOGxO?=
 =?utf-8?B?LzV4aHpXSFNNZFgvU2tPQ0ZVbFJ4bjBDQ2VwYlZ3YTluczJXY2pDV1hoYkMw?=
 =?utf-8?B?WnVnOHRlbkFCSjF5bGF2UzhhZEhkUGhHVFNSNjJ2MzlYaVArdGFBWUw1NWVI?=
 =?utf-8?B?Z1ZNOUh6UnF5VDlCbFdGWnMyS2dKSHJxUTJlb1p0L1ZxNFoxSENtUlhaSmc2?=
 =?utf-8?B?b3pjVkxaRXFPWncwNWROZm5lcTFnTlpKTVNwZSt2c1NRblFUc1d2b2ZhbHVq?=
 =?utf-8?B?bk16Rm15MTVhbXd6aGxvTWNVTjN1cFRXc1BkMTdLSnZvdTFOcTFzWVFQaUlK?=
 =?utf-8?B?S3lzcnJOdUxvcjAzN09jczVFRGJ4U3FTZk9ESjVTM21LbEhZVTNRSVp6ZnBo?=
 =?utf-8?B?WTFIcHNxM3JZaUlGR2RIcWN1eWdyMlpCWmJvWE83TU9DTXJpdHYwOWZhaTND?=
 =?utf-8?B?YzhOUU1Od2ZQWmVvVkp3U050b3luZVhqRkwvQndlOXRXMFJKcXZHMDk1bjNo?=
 =?utf-8?B?ME4zTUtmb2FIZ2tGK1orYW5CUWg3WVJyTCthMHhvLy8zWjJtQS9CYjFTYkZQ?=
 =?utf-8?B?TTF2UzBRalVFVTkzY0hjaXkweCtUWTNDblBKZE56S2tUMTlrMTB6bmJrd01Z?=
 =?utf-8?B?Z01tZlVaYjVPV3liT3V1YTdrQWI0UnFxSTVtRm1LUkJiNzBnVEVPSDBROW5P?=
 =?utf-8?B?cWI1dGN4aTVhWlJVYTF6TVAxQ1JicUo4TDI0Qjc4YlVvaHg0ME5OTlNWczFk?=
 =?utf-8?B?eDU5RldzSVBVQjJ4bERMcGxTaHlYbjEzR3p5dzV1UmRhYUd4SWxCQVpBNDlr?=
 =?utf-8?B?eWYrdHdsakhIV0w0cW00RDVTcEF4cVJQekNSVENkUE02aElNM2FwTm1YS2dM?=
 =?utf-8?B?T0phVFVBeDk5ZzVvbnRLVVdNRVdnOHBBamxqUlUxSjBUYUwvUTNuVmV2VVR5?=
 =?utf-8?B?bDJiay8zUWJIbUtPQ2ZyRXdTSDVpdnlLcG5iLzQ1bVFDODZaV2V4d0IrTzhS?=
 =?utf-8?B?YWJUQXdvamVqMWQ4TXVmSFJNZkVwa29wNU1RQ0dwb3RhM1BRNUpZTFlUWXVl?=
 =?utf-8?B?U0xBUmwrSTNnVENQRXpMeUw4TWlSUmJkQzhMMzltYzcyVG9zaUcwbEJ1bDE2?=
 =?utf-8?B?cU5rdExVWGwzSmlmdnBQSWFCUjFGajJuSUcyRXFxWHRZc2NFTW80aVgwaE9r?=
 =?utf-8?B?eU1QTXdOYmVrQmkwU3AyYTMxaTRtczFHUWRhZnNWMTYwT1MxWG5TSjdjNGo2?=
 =?utf-8?B?VHRBSnNhL08vOEhhdlFmYTAyL3ZRUVl2bEV0WHg3YzA4KzRmNXJTcVRwY1E2?=
 =?utf-8?B?NUttQXh1Mk5DTm1KWHRjUXlNUHVCM0FjK0VqZm85cnVvMEJsQWxCYk1lT0lo?=
 =?utf-8?B?NEFJclFQeVAvYk5XUXQrcVZnTkl1Zks3YjUzbXZjNmlLbkpYSUhsN3VzN0p4?=
 =?utf-8?B?K2t6M0dCbWhacmZ1ZVltSFUrUWFoUk91WEgxYmZOWlZZaEhONVpQMStFTUFs?=
 =?utf-8?B?MnVpdXdDYUFNY1RjWWxGNFZ2RjFRNHkwVDA2cEN3S216ZTh0Y3FtNGFzNG5C?=
 =?utf-8?B?eTlheTMyS3ZYY0FiK2pxVkZPSDRXNHI2ZThFVG5NRmo0SkdLeTlZdkozS1k1?=
 =?utf-8?B?ejZXSmVHWWNOOGtqd0ltdzdGM0M2czM2TmRBYUFUekZiTVNyNXY3a3BIanhB?=
 =?utf-8?B?Y0F1QVd5WjZLVnZNYzEvMUdDSGwrQVF4b2lkSTNacnNHeFdOTmtUT05FM1lm?=
 =?utf-8?B?OWNnSGRSSWRmYnYxdjEwTzhzcWFtT3dIeEI4UXpqcFplNlJ6V05rUklRTDVs?=
 =?utf-8?B?WkpxRHdlQWNzTUFKQ0NHaHhRdTdJK1RhcTVjK3NRVm1GY2FRa09PM2J4V0d6?=
 =?utf-8?B?MzFJWllEbzBUelJSRDQ4SnNkWlY3NWVmVTlkampZWmppeXFRQW1pbmhZVVNE?=
 =?utf-8?B?eW0rM1VnY3hnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHpESzNsTmIxQWJ4b1BMcng3UU9raVdManRBZVE5ZmNWeTR4ZjhrUGQyalhP?=
 =?utf-8?B?M0NEWmVFVWxIeUljOGlIRmE1eXduVnFPWHp4T1lzd2xSRHozU21jN3FBSXIz?=
 =?utf-8?B?Rm0ySUduL0F2TEVvbUE3WXVtOStOQU9waGFHL1Yxbk1BSXd4U1lUbENzYjJM?=
 =?utf-8?B?VlZuR2pkN1VsdXlpWnpYZ2NyNTU1dzRwekdVVGlLU3RYLzVlbytOWG43Z2Rn?=
 =?utf-8?B?OTZwTG1Md1JSVW1VNHFxc3R0eFFqSEdPMWNMY1A3azJNY2VuUEZ0ODJ3ZkVT?=
 =?utf-8?B?UWVvWTYyVVFIOGc3Nnh5L2ZGc1c4K1pWbWZ4blpCcWxmS29pR3c1K2lScXds?=
 =?utf-8?B?MTRwTXpOVnNKVlNiT25sbGh4bFNZdG5YY09SVlJrVHlsQzRnZmNtRFBrbXI4?=
 =?utf-8?B?VmFocXdZYVA5YzJ0WmdvaUo4aWY1MHkyNEhUcGtQTW40TlhGVnM0S1hzUEZQ?=
 =?utf-8?B?QWUzWm5KN3FpT3BBcDZyU3dNSnJNNnNpMjZETXJPZUN6R2lEWlFLcW5wYzRZ?=
 =?utf-8?B?NG9aMFRHSU9EM2NFWVovaWdsL041TzczVUtENEF3eURCMTdHWE10dk54V2NS?=
 =?utf-8?B?NU9UOTRFMFp0MTVWTkg2UmhNSGZaMWpHMmFNVnlEOC9VY0ZqamlDVDFwak5V?=
 =?utf-8?B?TTg5bnhlR3g3Ui9seXpDUHV5MWMzc2RXNnEzZGlacTlTNFdaYm4zRS8wTnNX?=
 =?utf-8?B?dlFqRW9QZXR2U1BJQ1lLNUZhYWt6WFNKTEFacnRkQUxYYU8wVDV6YW9UYTNt?=
 =?utf-8?B?cXREdkhZMEJkVFlNTlhjOXFIMi83MkJBSGV6d3JmRFdsMC9OaWRzcVNwUVNy?=
 =?utf-8?B?LzR5eWkyZTdzbnUwSUF5Uy9YQks0NlFIc2RBWDhEMWtkTU45VG1Idzl4aXhJ?=
 =?utf-8?B?QUg4aEd5a09GekZoTmY2VFkxcEQxNDYzd2pNV213Wm11VWRNOFFDZ3IvUHF5?=
 =?utf-8?B?N2E1YWN4cytyMUVKOSt0SXJMaThKczdIWWlzNnRwOUJac3phY3d4RE5NVkd4?=
 =?utf-8?B?QnNTZmZNN0RqaDZYWHptdGZBRWQ1c3NqTFB1UUY4UThaR1d4QzFJVDFsbDBJ?=
 =?utf-8?B?Q2JlNk01YUdVRnA4aFV1bUNCcnFnajNHR1ZBWGJmcWtHNVZMdll0WmhJVVVR?=
 =?utf-8?B?ZUhkdHJMdmVYU1ZpZzh2VE9mRlBTaWVLNzgvY1FpUVBwUmdlanFSdUJ6NVEz?=
 =?utf-8?B?a0dnamthWjdwalhPY1BubERmL2tzOFo5Y1VyZ3ZZL0ZwN3hTTkFLWHZDWExr?=
 =?utf-8?B?YjMzdG9Ed0NHc1U4R1FVRERFYnNzUVF4Yi8vVDRWVzBWRHVCWFM2WUc5amVw?=
 =?utf-8?B?V1g1M3pMbDJVK1VZSXpIVnh2eWlyL2FsWm5UT0dSamNtZU9qRVZkeDZoK1VN?=
 =?utf-8?B?UmxIQlF4ZHl4eG9sRHJ2dG90Q2t0TXAzbHdVcG9JVGpnME9GL0JTNGI5MW4w?=
 =?utf-8?B?RDdncmROc1JpUi8rOWp4THZmdXRROXZvdE1xdVJ3a3VhR0VraU5sMjlXdmNo?=
 =?utf-8?B?TCtiSk9kZTRUR2dXUStPNjFBNVFlN2J5Q2dpU045ZUcxY0ltR1lmYXdzeHZW?=
 =?utf-8?B?dHFTcTM2NHV5amtLbWJRVE4vVTNZdzlkb0MzbERlU0ZuQ3NOTmFaVmo2MXAw?=
 =?utf-8?B?aFFvSXJvVWY5ZnZyU0E5bDNnVGtFeWZMT3YyenBiSmNUTGJ2WDNzMm5RZFFI?=
 =?utf-8?B?MWhycTVlejRMSVdjZXBRU2o0S05oRXQrT3I4NGllV1Nwc0FXZ21pWTUvclU5?=
 =?utf-8?B?MTIzUmphTVBma0hqc29wUUxkZXNibkZVUGZ5ZVhiZXNtQUJyNXppVWcwaHIw?=
 =?utf-8?B?VnhpYkl2MFMyUnZWVFZSdkR3OFhnUFd2SVlBMHNOdXc3SVU1V0RpUHBZbW1r?=
 =?utf-8?B?YnJoMWE5MElJZUhTR2lWUm1oWWRFS0tEZ2wvVUxoNUJmdFVFYkFhd1U2MlQ4?=
 =?utf-8?B?djN6UkNsVnZ3L3FRdFlBSGRiRG5LNlJGRkM2cWRyRFkyc3dEK1FQYjY5RFVn?=
 =?utf-8?B?WXY4aE04SVJ2My9pM1BrQ3NTUHFobWp4bE9KZUdNNDJhQjV1MXZLbTN2cW5V?=
 =?utf-8?B?N0EyWEt6d3dDMzR6Zkd5RDFOK2RONFdTSFpCaHNiV1BiWUJ0ckZaMW9uc1Rp?=
 =?utf-8?B?NTFPR0pEZys0U0NtZHF1ZXBiNVk0c3NFSmxjdFEyVE9DNUtxYmVaM1hwVVpR?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB20BC3A3EB16A44BDBC2677D70DA53E@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c404cd-b81e-4254-ff14-08ddb398bcf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 03:31:14.2852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IxNDz+uRCoPCsO2299pWTP/jPoFR+31+7qQPNsrx82VM99QZmbO3NSTcS2el40FmZhKHKmyvCiCRxEaxsAMLzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4403
X-Authority-Analysis: v=2.4 cv=aaxhnQot c=1 sm=1 tr=0 ts=685b6d85 cx=c_pps a=gu6RomWtnwV9OjqK3d0IpQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=a3ATbRu_8qMCY1pyxxsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3pzM2AnsMJ56ovwZWwhh7rl8iGdr_nlY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAyNSBTYWx0ZWRfXwOa/fASILr91 CbTGYhCpqM38R6tditKzr4/AZYvm3uGz6O6Pbnf+oAboOUzcNtJxwAMOLDpz0qaDl9oECMVy8VZ OWPIA9v89H+b/sfI4I7Dod7AlxNK3FuFdeOZAhYIUMoliu6Z7XiqWPzye6+V6BrI3wDMPy4/Fpa
 kN0BMR0+z3oQrqDVxZBXritFgjMNSQltntbfwOGmgy1TDX+b23/y0TZ1rC9RShL4bHBsx/TS1Cw 5h9OC0FZzKRi6l9xxuF5o3+QCMmZp6nMZ2pxZbDO7hc9vOUOJaG+Rk7JkjXgwFVelv/1tEvVcrP HzXTHix6gLwQWDVJBRctmL6LXJ047kmg/fjXJZiShwpsgh0t4jZdN5OxnJCZ3yY/Cl5kEhevDX+
 Avd2nzcmx/mxE0SN93rYrVkSTy8yyQjC94Z3uNr2pSORazdpM5FvHFYqrWId/fbssdN/NzT7
X-Proofpoint-GUID: 3pzM2AnsMJ56ovwZWwhh7rl8iGdr_nlY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01

DQoNCj4gT24gSnVuIDI0LCAyMDI1LCBhdCA1OjI54oCvUE0sIEVkdWFyZCBaaW5nZXJtYW4gPGVk
ZHl6ODdAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgMjAyNS0wNi0yNCBhdCAxNjoz
MyAtMDcwMCwgU29uZyBMaXUgd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4+IGRpZmYgLS1naXQg
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdmVyaWZpZXJfdmFsdWVfcHRyX2Fy
aXRoLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdmVyaWZpZXJfdmFsdWVf
cHRyX2FyaXRoLmMNCj4+IGluZGV4IGZjZWE5ODE5ZTM1OS4uNzk5ZWNjZDE4MWI1IDEwMDY0NA0K
Pj4gLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3ZlcmlmaWVyX3ZhbHVl
X3B0cl9hcml0aC5jDQo+PiArKysgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3Mv
dmVyaWZpZXJfdmFsdWVfcHRyX2FyaXRoLmMNCj4+IEBAIC0yMjUsOSArMjI1LDcgQEAgbDJfJT06
IHIwID0gMTsgXA0KPj4gDQo+PiBTRUMoInNvY2tldCIpDQo+PiBfX2Rlc2NyaXB0aW9uKCJtYXAg
YWNjZXNzOiBrbm93biBzY2FsYXIgKz0gdmFsdWVfcHRyIHVua25vd24gdnMgdW5rbm93biAobHQp
IikNCj4+IC1fX3N1Y2Nlc3MgX19mYWlsdXJlX3VucHJpdg0KPj4gLV9fbXNnX3VucHJpdigiUjEg
dHJpZWQgdG8gYWRkIGZyb20gZGlmZmVyZW50IG1hcHMsIHBhdGhzIG9yIHNjYWxhcnMiKQ0KPj4g
LV9fcmV0dmFsKDEpDQo+PiArX19zdWNjZXNzIF9fc3VjY2Vzc191bnByaXYgX19yZXR2YWwoMSkN
Cj4+IF9fbmFrZWQgdm9pZCBwdHJfdW5rbm93bl92c191bmtub3duX2x0KHZvaWQpDQo+PiB7DQo+
PiBhc20gdm9sYXRpbGUgKCIgXA0KPj4gQEAgLTI2NSw5ICsyNjMsNyBAQCBsMl8lPTogcjAgPSAx
OyBcDQo+PiANCj4+IFNFQygic29ja2V0IikNCj4+IF9fZGVzY3JpcHRpb24oIm1hcCBhY2Nlc3M6
IGtub3duIHNjYWxhciArPSB2YWx1ZV9wdHIgdW5rbm93biB2cyB1bmtub3duIChndCkiKQ0KPj4g
LV9fc3VjY2VzcyBfX2ZhaWx1cmVfdW5wcml2DQo+PiAtX19tc2dfdW5wcml2KCJSMSB0cmllZCB0
byBhZGQgZnJvbSBkaWZmZXJlbnQgbWFwcywgcGF0aHMgb3Igc2NhbGFycyIpDQo+PiAtX19yZXR2
YWwoMSkNCj4+ICtfX3N1Y2Nlc3MgX19zdWNjZXNzX3VucHJpdiBfX3JldHZhbCgxKQ0KPj4gX19u
YWtlZCB2b2lkIHB0cl91bmtub3duX3ZzX3Vua25vd25fZ3Qodm9pZCkNCj4+IHsNCj4+IGFzbSB2
b2xhdGlsZSAoIiBcDQo+IA0KPiBBcG9sb2dpZXMgZm9yIG5vdCBiZWluZyBjbGVhciBpbiBwcmV2
aW91cyBtZXNzYWdlcy4NCj4gQ291bGQgeW91IHBsZWFzZSBhdm9pZCBmbGlwcGluZyB0aGVzZSB0
ZXN0cyBmcm9tIF9fZmFpbHVyZV91bnByaXYgdG8gX19zdWNjZXNzX3VucHJpdj8NCj4gSW5zdGVh
ZCwgdGhlIHRlc3RzIHNob3VsZCBiZSByZXdyaXR0ZW4gdG8gY29uanVyZSBhbiB1bmJvdW5kIHNj
YWxhcg0KPiB2YWx1ZSBpbiBzb21lIGRpZmZlcmVudCB3YXkuDQoNCkkgc2VlLiBUaGlzIGlzIGlu
ZGVlZCB0aGUgcmlnaHQgYXBwcm9hY2guIA0KDQpUaGFua3MsDQpTb25nDQoNCg==

