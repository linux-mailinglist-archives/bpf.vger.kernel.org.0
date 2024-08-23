Return-Path: <bpf+bounces-38003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD6195DA01
	for <lists+bpf@lfdr.de>; Sat, 24 Aug 2024 01:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8472AB22B44
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 23:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC791CC142;
	Fri, 23 Aug 2024 23:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="UcIqKsgW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3081CB326
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 23:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724457432; cv=fail; b=SbuZ1RAn7hbw0o49v5wgRXJT824/75EHnhb2uEZGVaG2HMAcAxFD1ASev/Bfuv/REfr8kKmCwdnFlbGtZ6IOb4Q8pqnDmfe/IIxIuZhepuyJkjKFJf8El2UPyslzPRJ0od737QTDCQArzWc3w2Ykbd6aMlc7oIvSzZfKhpZ4Utc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724457432; c=relaxed/simple;
	bh=kJA21NcDzcugT1CVk0r+1tsaGTkGaSiBScq8Hkbpvz0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ciya2Ep15yefLvc2BJy8wD1LDF07iAk8GWr8WvuFw4Y5ndt9vEbfDABbwxfvg/3HMcKqqNi4fqRP9S/vNzElbPzTFg06WFXegmVsSz7g/NNZmik/5rb41mBDfJ7GfveRovvGhz3f0zQ3xwCJQezj9L+CuylK3WQpakT5yFllXSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=UcIqKsgW; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 47NJuYEk019876
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 16:57:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=s2048-2021-q4; bh=kJA21NcDzcugT1CVk0r+1tsaGTkGaSiBScq8Hkbpvz0
	=; b=UcIqKsgWVle2bhibgAhUNIL7uvOk9VMJDCRSE0C+0hF+VE1KYKJ2B8cFcxL
	gMGn05V8WbnTSkB3FTxuIHFqTPxjes5DtJh2oo2BXVk2sy8JyRBpLf53DH1tMvBE
	Jl9aGSAwLaKfxCChreN5f19Lo6Rp5lJCewxhE5Yn1vfvpuhhrVlU/2fsxMFbLMGz
	j3++547O2herkZsnTnpjNSa4nOvTDmTRIcNUtoJJEq6mHZ2L3/j5geH80r94HpIC
	LuQomiytZRHs+5nzc9XJtc1gjDMbOSvS6hMpjswQRurzdF/2hEh9+/d0t94EytOr
	bj8NcR/FNkdgxng8ImiuYkUbkLg==
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
	by m0001303.ppops.net (PPS) with ESMTPS id 416c9885vu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 16:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxljLGcjTFggKxolCap+7QDbCIUzXekUBqppnIWKkQujTNR1p4jGIFI2wVfeIkHfOJHMtZMfJzrQqC9PoZHoAVOol17lDshvKVp+UuXUy6ceNCVtZXvSG/Yg+fzLEPF7QnHk7UH+ZWS47HyZ+Fj0clvCbP/OzEA590Hs3ck7JoKfyrl+NiHSeZzRxUH9TaWkAWYgOrSvO+900qW0xp5QvwaqtX2BuMq8q/q87OeZ2BcPdl4zbuFTzyieJl37xBppeRVhSYpaYmpgslkDZ6bQXL51BRQQ3Z+jp2aqAe6R6rMRmQYB2fg38NCXQddpt4A3+Y/Oukir54F497xjEPrvtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJA21NcDzcugT1CVk0r+1tsaGTkGaSiBScq8Hkbpvz0=;
 b=BH0n2uyA5a/ZXiSv9tpWbZDSNHzJacRn6/TOLam6GDyrXgXfyyu2AvNPcggXD5aXLs8EqVdpxegngBGUfVdbYixxVQIFgDj6/UGKzWFFkRRua4R6W7ZSqfedNdCOAJuDqRatwn2PczhNhZ6kv5rmyxrXXf+v0gO9YDFMG36/7hcB39q2VgOApD4Z82W7/CWshk5qcvFDfZV+NBw4F5hF0l1OedGsDYOhg4u3zBlut4RrZG/JgxNzI3IODNzRk0q5kGBNSj7IQkUAev55PuiXvKCE6uL1zLv3AXsAJQhKGjlFQpgRrNnTqPU8aa2HRwSTdJCbif7MCIpJ+ZZ7Pjs+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB3488.namprd15.prod.outlook.com (2603:10b6:208:a6::17)
 by CH3PR15MB6452.namprd15.prod.outlook.com (2603:10b6:610:1af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 23 Aug
 2024 23:57:06 +0000
Received: from MN2PR15MB3488.namprd15.prod.outlook.com
 ([fe80::bbc4:c02:e364:28e0]) by MN2PR15MB3488.namprd15.prod.outlook.com
 ([fe80::bbc4:c02:e364:28e0%4]) with mapi id 15.20.7875.023; Fri, 23 Aug 2024
 23:57:06 +0000
From: Daniel Xu <dlxu@meta.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, kernel-ci <kernel-ci@meta.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "andrii@kernel.org"
	<andrii@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        Alexei Starovoitov
	<ast@kernel.org>, Manu Bretelle <chantra@meta.com>
Subject: Re: BPF CI and stable backports (was Re: [PATCH stable 6.6 2/2]
 selftests/bpf: Add a test to verify previous stacksafe() fix)
Thread-Topic: BPF CI and stable backports (was Re: [PATCH stable 6.6 2/2]
 selftests/bpf: Add a test to verify previous stacksafe() fix)
Thread-Index: AQHa9QL3zpwYk9dCW0Ww8EKesIZ067I1hkoA
Date: Fri, 23 Aug 2024 23:57:06 +0000
Message-ID: <f4c2306d-6bb9-4a17-ad51-0ffba13a140c@meta.com>
References: <pybgmvfeil5euvdz7vs7ioacncrgiz4lnvy5sj3o4prypgsdd4@tzc2ecsmyt6g>
In-Reply-To: <pybgmvfeil5euvdz7vs7ioacncrgiz4lnvy5sj3o4prypgsdd4@tzc2ecsmyt6g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR15MB3488:EE_|CH3PR15MB6452:EE_
x-ms-office365-filtering-correlation-id: 54827be8-2d32-4c37-39cd-08dcc3cf4b21
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dW10SGY2d3RNUzlJSnhmUndKbG1RMnNnOFJ2cmJ3bXByQlBsV05INDRsWFdO?=
 =?utf-8?B?VFE3V0FqWnBKbk5jMXN3UUNsWDNRR2lyRFB3eFViSmY2TWJzYnJKa2k4VG4w?=
 =?utf-8?B?V3FpbVNiYUhvVjhSLzNGSkZSa0M0bVFic0hIN0laNW1zUFpjZkF5KzFnZmxp?=
 =?utf-8?B?enE1WjJVVUFxWEJRNUhHeEFrNXI0K3MzNGJIcDlNQ1ozdVB3NkdKbzZZNUIz?=
 =?utf-8?B?RkVmcmduWTBkcWx6elJFSzBYdUlMS0M5eSt2Q1A2dXZzT0lNeGdybGh4UGZn?=
 =?utf-8?B?S3pnV1I0R0hTSkxka3FDSDN2bXUyS3BRNVlBTDMwL2M5U3huaGl6emtzM3c1?=
 =?utf-8?B?blh6cVEwaVVLVlk3bWF2ZXVRdUJ3QmpRTEFzb0kxcjFsd21qbU1oaUlxZ0pP?=
 =?utf-8?B?ZzNEOW1EWHZ6cms1c2hwbGdZck41bWkyajVpN3htL3pWazRyL2lEeENJbnRI?=
 =?utf-8?B?MEdXQ3hzbDlWN2lGc09FMG04ZjdTZEFkQit0TFVSNStvVkxuNDN3K25Cc3p3?=
 =?utf-8?B?cjZXTktjTW83ZG5icEJEbEMrSEdDRDdJc0JyVXJlUFNEeEFUUmxZeXhFc3R4?=
 =?utf-8?B?R095SlVyZkRWQU4yeEJLczJvejArZzFETmFEZTdrVHQ2aXFkV0NUUjd3ZDRU?=
 =?utf-8?B?aFFPRFZ2a0lRcTBUcXc2Z3dRM2ZxSi9LaFlGbm5iUTUvT2NNaGlSVHpTMUw5?=
 =?utf-8?B?ZTV6amRhem9NanhDaDAxa0s3RTE3c2hFTElEeHVjSE9WK2c2U28rbVJObUNl?=
 =?utf-8?B?THJ5WmFudFV4RmIvb0szMk9NU2xZK2doVVp2SFVPUW5KQm93aUhwQUkzQlI3?=
 =?utf-8?B?b3pSY0pyM1JSa2plbncyVDQ3b1pyN2hidXJpUndxb0JUL2VCeTRMUEEvd1V5?=
 =?utf-8?B?dkVQZTRrYUFuQk8xRm1oZ01kVHgzNnVldTRSUWVRczZRWncvTDVvc2FZWkVQ?=
 =?utf-8?B?WnBlclVMRi9yNm9lV0tiMnZSQk4rVGxNTnFzdy9SalVxRk1xc3kwQ25CU0kv?=
 =?utf-8?B?aUJqZW1jbkdhQmtLRlM3czZ2ZzFjQXdYSEZHWTUyeTN1NVI4a3FOY01qdW43?=
 =?utf-8?B?MlFWVUsrOUo2NE12M2ZLb0ZGNU9YTFQrODZOY1hoOVcwTHQvZlRtc0x4UTg2?=
 =?utf-8?B?amdWdml5RXFDeWtScnZlaDBkcWpiZnhScUVZUUNkWFErRUxMU3lQZTBoWnZG?=
 =?utf-8?B?ZnFmUHNUdmtZVExkcnZ2Uk1BM2VENlpkc1Qrb1RSY0g3cEg0b3ppQ2hkTWVt?=
 =?utf-8?B?eTB4MlQ1OFdQYjZqU2syMGc2dGdWbEpVZllCTnBwZ2hKMW9RYjdXTTY4RzFP?=
 =?utf-8?B?RVgvdWhwQ21DN0hROEF4WjhTWnU3cllKM0lMMUJsNkQvRnpPRmp0Tyt0M1J5?=
 =?utf-8?B?bzluSFRLelliSEZ1aENDb1pmVFdFY1liT2pZa2lXZFdNeWNtbktJdTllaVRP?=
 =?utf-8?B?Wkp1OGU4U3pZVTlWSldWR3NEYjUxem1TejFOUXRkcjJ6Q0FmRDlIUEl2elJ4?=
 =?utf-8?B?N0VTaENoTm1lSmxEaTZ0NVR6Z1lDaVpjL2IzdHpySmtPZ2tQVXRNbm1aTlV5?=
 =?utf-8?B?VVVIMFZuT1F6SnJFSHRocHhEb1FUMXV1NjViSDlLV09tQlVlb2tCV1lSWGUy?=
 =?utf-8?B?TEMrQ095TGVMVWw3NDRQSEhWeC9JUWJoa1M0c1pPRzRoNm1wREdJNzhPWkxz?=
 =?utf-8?B?VU1xa2FSWk9CdFk0S1FBZjJ6Z0I1R2FIZUprWktyRm9zSTNEQ2dxSld4SlAy?=
 =?utf-8?B?Q1VjSVBrdjVpN1prRlhpRGNQaU5jTUJtUGZtdGtxTDhWa1hnTjFIWmxEV3hK?=
 =?utf-8?Q?StIRfCnP413Eya/Nw7AW4K4aSViQwkAtdhAls=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3488.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEQzbFJNYTErM0NwdkU5U2dZWDgvZHF1dGJGejBXcGRpTlcrcHg3YmlpRlU2?=
 =?utf-8?B?Vmh5QUF4UG56NWVTSDVHL2Z1Y0Q5TFVPWkNUbEVkTnVUTFdUeFh6MzdCcUcr?=
 =?utf-8?B?ZUcweDBDS3kxQW5sT09jeVRFdnZqcjdkU1RzZ3NqdEJFQ3hoOCtoeHE3ckJY?=
 =?utf-8?B?WjJrZk5FN21FVW9oZ1BlTEUwcDZOemdpR3ZZTmpoQ2tld2F4U2hYR2ozeVRW?=
 =?utf-8?B?SkZzS3pKTUJCRmt4L2Z1WE9zWHlwaDgyenFGOTUrWW9sTmUwRjQxbk5sdVpu?=
 =?utf-8?B?QTl1UmlLNXArRmNKa0p2cm81azlSK0tNeHNFNGJrUHpma2N3K25KaEpMdFZk?=
 =?utf-8?B?NkJhcjJHZ2dYdDdwVkZPZUZaenZkYmxaV0xTN1BpNnpHaUdiRzdRcEp3OFc4?=
 =?utf-8?B?U2xWdXphc3dyM1lFTlVJRzRZU2QvK3Mxb0JsRWhvOG5qMnBBdmlyVmZtcGcz?=
 =?utf-8?B?VDB0Y0V2ZnlHbEFMbFBBT201TGQ4eEN6REh5U01hQUtVcU5LOFpubWRFWVgr?=
 =?utf-8?B?QnZBU0tkZ09nNE0yM0diVzhURWRSUGFCN3g1S2RvMXFtYW5LMnh2Q2tMelhV?=
 =?utf-8?B?cCtXeTgxYjd5djEvYm5nUGw0R3IzWXhudHJOMlg5U1lZRXZZRlduaHJISVJ4?=
 =?utf-8?B?Vm1oc05xdUlGQ2J1M09ueWo2Z2pBMjNFZUVHajhUS29ZV0h6NGFsTWdhZU9i?=
 =?utf-8?B?RXcxTjZPUVBjMFY1MFlLQWl1NXNaemwyWmpDbVpXZ0lNUUV2cEF6anV5Mi9N?=
 =?utf-8?B?eDk4YWE1RnVDcmV3dllXSDNCRldnM2QzZHZxSVRPOC9WaXNDNTVHZ1Y2SHVM?=
 =?utf-8?B?VnRZQnV2WUppUC94MGxVdkoyOElYMmV2REdVSCsyckR6Vk95S3hwZk1Pa3RZ?=
 =?utf-8?B?azlBc1d5TkRKLzNoTm5RaGlrczlQUzV1TzM3TUhpWWcwT2JzS3NWZmxhTFNP?=
 =?utf-8?B?cjQ5MXgyRDhGRDJ2QktVSnJuYlV0WVRTcDVmeTVFcG1vZEQ5VTRCMzNyV2sv?=
 =?utf-8?B?RndqNFJmeUtzRlBEek9GNVBwVmZwMGdqMlpYL1VIZnAwMEdIWVpDYmhrREZy?=
 =?utf-8?B?ei83aWN3cDAxTmxwYTJoTDRjaFdoaHVqam9ueTc2VlNjcVk2RmhaQmlCNFcz?=
 =?utf-8?B?alpHSWJGR1FReWk4RmY2dUVZN2RybFZQVTZHSmkzdWozYlVLdVBNSTQza1Vm?=
 =?utf-8?B?R1dYeVpzUWhrTlpUYUVnSGtGcEVIUGkwa05MVXVaRmZkcFpqUkFkNHR2ZVhQ?=
 =?utf-8?B?OTEzcHhLTlllVTc3aUFHbGdickErSDd4RW9aSXgzUTV0d2liOWRiN0s2dnF5?=
 =?utf-8?B?cytIOEQ0K0s1WGNGQTZoQTNvL3B2Uyt5NUttU2JTZEtDd2hvZ3dxSkZsUHM5?=
 =?utf-8?B?WHM2c0wrdllJUlZhNFhEcHhVc3VKdkRaN1k0bVZid1hOOThKSk0rVHFEcDhQ?=
 =?utf-8?B?dG9TVU9VVFVEOFlhN0VMUGl5WjdQanE0VWdkRGk0amRVNVVXSXFtd3JUZUpj?=
 =?utf-8?B?Y2JuZTVMc3ZZY0FLSjd6Q0V5aCt4RWxIRWpDd3ZKemszdWJPTlp5ODM3NDRU?=
 =?utf-8?B?UDlwNVpiS3d3U09OV0F1MDhib3V6Yy93M1I1L1Y5MlQ4YlJKcDRUZDkrVEtz?=
 =?utf-8?B?dWcvdFJwOWxjNkVWTU9jU2dITUFwQUJZK0xPbVFUeXVDNjI2eFhlTkFQdTI2?=
 =?utf-8?B?dzRJQWRtSFRWN2l2ejRXNENCYXh4ZUFISVZ0ZjBhR3pWckw5TytuUU9HcS94?=
 =?utf-8?B?d0psWDc4dzA0dlpIc015MXNweURrT1F6LzhQK1IwV2U5VlN0T3dVeUhiSDcv?=
 =?utf-8?B?bkdKSnArZUcvaFhFWFkzcXQ1TnRWWm0wbVJVcHB5SDRJYTBReWhHQzJOQXAw?=
 =?utf-8?B?RVdkZ3RMSW5BZE9pTkFqRzhCN29zVlBRa0JQZkhzWnFST21VT0hITHk1ZmtC?=
 =?utf-8?B?UnBGVkU4aHhRdUZ0RkQwcHZScHc5UDlyQ2ZDdXBHQk1WREhvZlNLTGQ2eDQy?=
 =?utf-8?B?VTdyVmF5Z1h5Rnc2MnZjbVkveFFFL1phUGhoL1o5YzJFaDh2MG9rMHo5MDNy?=
 =?utf-8?B?TjRNaWVVdTJTaEZ4d3R2NHdNdUdXOVZXSXV0bXRVVDZKbXhpZmhZQW1NMS9m?=
 =?utf-8?Q?N89I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E2A93E485712C478B5D10B28DCF06CA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3488.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54827be8-2d32-4c37-39cd-08dcc3cf4b21
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 23:57:06.5298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nN9qGcegFwOx+CD4/bOaVGFZqMPGstFuuzgbVtrvEsjLhjPx1c6Z4tzjb6Z8bB5V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6452
X-Proofpoint-ORIG-GUID: Q4nEcrk6Si5FK7ECe__zMhX2-81FmV2S
X-Proofpoint-GUID: Q4nEcrk6Si5FK7ECe__zMhX2-81FmV2S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_17,2024-08-23_01,2024-05-17_01

SGkgU2h1bmctSHNpDQoNCk9uIDgvMjIvMjQgMTk6MTksIFNodW5nLUhzaSBZdSB3cm90ZToNCj4g
SGksDQo+IA0KPiBPbiBGcmksIEF1ZyAyMywgMjAyNCBhdCAwMTo1Mzo0OEFNIEdNVCwgYm90K2Jw
Zi1jaUBrZXJuZWwub3JnIHdyb3RlOg0KPiBbLi4uXQ0KPj4gQ0kgaGFzIHRlc3RlZCB0aGUgZm9s
bG93aW5nIHN1Ym1pc3Npb246DQo+PiBTdGF0dXM6ICAgICBDT05GTElDVA0KPj4gTmFtZTogICAg
ICAgW3N0YWJsZSw2LjYsMi8yXSBzZWxmdGVzdHMvYnBmOiBBZGQgYSB0ZXN0IHRvIHZlcmlmeSBw
cmV2aW91cyBzdGFja3NhZmUoKSBmaXgNCj4+IFBhdGNod29yazogIGh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcHJvamVjdC9uZXRkZXZicGYvbGlzdC8/c2VyaWVzPTg4MjQxMSZzdGF0ZT0q
DQo+PiBQUjogICAgICAgICBodHRwczovL2dpdGh1Yi5jb20va2VybmVsLXBhdGNoZXMvYnBmL3B1
bGwvNzU4NA0KPj4NCj4+IFBsZWFzZSByZWJhc2UgeW91ciBzdWJtaXNzaW9uIG9udG8gdGhlIG1v
c3QgcmVjZW50IHVwc3RyZWFtIGNoYW5nZSBhbmQgcmVzdWJtaXQNCj4+IHRoZSBwYXRjaCB0byBn
ZXQgaXQgdGVzdGVkIGFnYWluLg0KPiANCj4gSXQgc2VlbXMgdGhlIEJQRiBDSSBwaWNrcyB1cCBz
dGFibGUgcGF0Y2hlcyBhbmQgdHJpZXMgdG8gYXBwbHkgaXQgb24gdG9wDQo+IG9mIGJwZi1uZXh0
LCB3aGljaCBmYWlscyB0byBkdWUgY29uZmxpY3QuIENvdWxkIGEgZmlsdGVyIGJlIGFkZGVkIHRv
IENJDQo+IHNvIHRoZXNlIGFyZSBpZ25vcmVkIGluc3RlYWQ/IChPciBoYXZlIEJQRiBDSSBhcHBs
eSBhbmQgdGVzdCBhZ2FpbnN0DQo+IHN0YWJsZS9saW51eC0qLCBidXQgdGhhdCBzZWVtcyB0b28g
bXVjaCB0byBhc2spDQo+IA0KPiBPVE9IIGlmIG1haW50YWluZXJzIGFuZCByZXZpZXdlcnMgcHJl
ZmVycyBzdGFibGUgYmFja3BvcnQgbm90IHRvIGJlIHNlbnQNCj4gdG8gdGhlIEJQRiBtYWlsaW5n
IGxpc3QsIEkgd2lsbCBkcm9wIHRoZSBDQyB0byBCUEYgbWFpbGluZyBsaXN0IGluIHRoZQ0KPiBm
dXR1cmUuDQo+IA0KPiBUaGFua3MsDQo+IFNodW5nLUhzaQ0KPiANCj4gWy4uLl0NCg0KVGhhbmtz
IGZvciByZXBvcnRpbmcuDQoNClRoZSB3YXkga2VybmVsLXBhdGNoZXMtZGFlbW9uIChLUEQpIHdv
cmtzIGlzIGl0IHBlcmlvZGljYWxseSBsb29rcyBvbiANCnBhdGNod29yayBmb3IgcGF0Y2hzZXRz
IGRlbGVnYXRlZCB0byBCUEYgdHJlZS4gSWYgdGhlcmUncyBhIHNwZWNpZmljIHRhZyANCihicGYs
IGJwZi1uZXh0LCBicGYtbmV0LCBmb3ItbmV4dCkgaXQnbGwgYXBwbHkgdGhlIHNlcmllcyB0byB0
aGF0IA0KYnJhbmNoLiBJZiBub3QsIHRoZXJlJ3MgYW4gb3JkZXJlZCBsaXN0IG9mIGJyYW5jaGVz
IHRvIHRyeS4gYnBmLW5leHQgaXMgDQpmaXJzdCBvbiB0aGF0IGxpc3Qgd2hpY2ggaXMgd2h5IHlv
dSdyZSBzZWVpbmcgdGhlIGNvbmZsaWN0cy4NCg0KIEZyb20gS1BEIHNpZGUsIHRoZSBzaW1wbGVz
dCB3YXkgd291bGQgYmUgdG8gbm90IGhhdmUgYmFja3BvcnRzIHNob3cNCnVwIG9uIHBhdGNod29y
ay4gSSB0aGluayBpdCBtYWtlcyBzZW5zZSAtIGl0IGlzIG5vdCByZWFsbHkgYmVpbmcgc2VudCAN
CmZvciByZXZpZXcuDQoNCldlIGNvdWxkIHByb2JhYmx5IGFkZCBhZGRpdGlvbmFsIGxvZ2ljIHRv
IGlnbm9yZSBzdGFibGUgYmFja3BvcnRzIGFzIA0Kd2VsbC4gVXAgdG8gdGhlIG1haW50YWluZXJz
LiBJIGRvbid0IHJlYWxseSBoYXZlIGFuIG9waW5pb24uDQoNClRoYW5rcywNCkRhbmllbA0KDQoN
Cg==

