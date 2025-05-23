Return-Path: <bpf+bounces-58858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D617BAC2A03
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 20:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CFD67ADF79
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 18:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF9B29AB04;
	Fri, 23 May 2025 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nnIw5m1+"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E9227E82;
	Fri, 23 May 2025 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748026651; cv=fail; b=e3wbXsfl1y0Chcr/GtjtIfGXXOsSwYtBk3VqfWOHmHSWnxMGRZv0AwYcf7QJfxYu1p9HzJVjwPl/mP4XCUTT5Tsch61S6bBZMEd7cbWkvMZFeGW2El/tUUGs378fg9VIIYAeoVTuxeA5OOzZH3OGNI371BHqWsIVbYcCeDuS0kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748026651; c=relaxed/simple;
	bh=Fqrijivc0QTqi9ipnRrMOR3EjEgYsuHR3K3Z65xPBLU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dcnfqczzlxb/szZMUc/XV4YIeQ0jRZXPELIkb0H5G1lPpU0NDr1YH5Jl7erDdSnYxGPXrPz0ZxCq/pPNd8JqLL1PGVuGCk4osyLaOkAgq+36d7Qu+Jn/qlWCyfYtVnyiJbvSqcIu+au2MwkHHCg9Ky7XwkacWMQywHKIZ04zWuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nnIw5m1+; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NIdZbw029348;
	Fri, 23 May 2025 11:57:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=Fqrijivc0QTqi9ipnRrMOR3EjEgYsuHR3K3Z65xPBLU=; b=
	nnIw5m1+8XXsRmSkCA5MXFqS0Emn4RFTqJziN/1bQQa+U6HHBCgS+CRvfG81Fb/e
	kTmjjAG2405f6dF4n6TOx74MXkB6tgWC9RJZNNyQM0fJ1icnoMgbyONbQ05qJaKv
	EMYmmkNt7oDIn8sCtSUpGsKVTtMM13Hol/iG9u/YSxERqhGwQWlE+/klZ1QN+kWV
	jfr6EXMhLhVdg+43N7wrd2vPgjFYvZqXN0qzV//PFBOEn8UYrOdrNvflSE2U+Mef
	jcYIuDTYCwtb1iOr0zQCdHCfofSS2CItUiIv9UZoDCsnpiQVTI+usAnD5UDm3LT+
	LbGEkrAWkh7s4WJRpiFH9Q==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46sxy1dfku-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 11:57:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJAvEZH2RT16Hp1U4ZOOEdJudVukb/38HuiAfe/BiKhQEEkcI2bJ2dFEcAV3BFCDa4VvlGbSZilqw1Bzg5o2P11/RGVx+l0zZJp5CXAqLz9H7z8WGooa0olF8VfBAwcfNiTbuotTHtSYpmEePjCuvZgr77ukc15ol5C3KXwUUvBJjE7UsHEzCaumfDIk1y3Hjj/zcNSPNjC3iQKON81I5NY+i/+7UEKbHRPMkAFm8Z3ai1sdpQJ1TzG3Joderjh1tgheNxFliJPcK2LSCYzFdz0TfdxmPfYY+bWVr1fTxNh5YXlf66sp3t/yZCso5yfQmPNvBKA3WToT/ht2deFUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fqrijivc0QTqi9ipnRrMOR3EjEgYsuHR3K3Z65xPBLU=;
 b=WK/OY+QObHfS2TQMnWCBClmU9RUSE/SvpeiMZKq5lrvGVOAJlmSLEUqLz1v1/TTrhT0W6+s69IA5AskhCR0vubTC2bmwYzYCvEhfjMmzXOYSM4MjWiCz+U5bJuBoEhClx7FJ4pmfnEiU4XxLIErathD6jk6khjE8oifEnt3UtIBVYRuUQehWyvi7rCHdqhdHy0LtJ/eg8NOYbX4OQP70yG7iA1oPBpRpTktLNloN3WQUfuXLpyU9qiXeL23SJL1y+cxM+HyFnp+1KZWCu7sE/wnneYDGzLUdTXAkpMA+hd3y/HRIPXVzX4Ckwv/wQF7Pr2Hmk8hFU8/4+okQEQOlBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5671.namprd15.prod.outlook.com (2603:10b6:a03:4c1::19)
 by DS0PR15MB6166.namprd15.prod.outlook.com (2603:10b6:8:129::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Fri, 23 May
 2025 18:57:25 +0000
Received: from SJ2PR15MB5671.namprd15.prod.outlook.com
 ([fe80::a025:a1d3:960b:9029]) by SJ2PR15MB5671.namprd15.prod.outlook.com
 ([fe80::a025:a1d3:960b:9029%7]) with mapi id 15.20.8746.030; Fri, 23 May 2025
 18:57:25 +0000
From: Thierry Treyer <ttreyer@meta.com>
To: Eduard Zingerman <eddyz87@gmail.com>
CC: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alan Maguire
	<alan.maguire@oracle.com>,
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
Thread-Index: AQHbrwS3AlS1roAfS0S+1p7h6I+KLrPaDacAgAUZ8gCAACNmAIAAA88AgAF8JgA=
Date: Fri, 23 May 2025 18:57:25 +0000
Message-ID: <530F1115-7836-4F1F-A14D-F1A7B49EF299@meta.com>
References: <20250416-btf_inline-v1-0-e4bd2f8adae5@meta.com>
 <d39e456b-20ed-48cf-90c0-c0b0b03dabe6@oracle.com>
 <09366E0A-0819-4C0A-9179-F40F8F46ECE0@meta.com>
 <CAEf4BzZxccvWcGJ06hSnrVh6jJO-gdCLUitc7qNE-2oO8iK+og@mail.gmail.com>
 <bfb120452de9d9ce0868485bc41fa8cf56edf4cf.camel@gmail.com>
In-Reply-To: <bfb120452de9d9ce0868485bc41fa8cf56edf4cf.camel@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5671:EE_|DS0PR15MB6166:EE_
x-ms-office365-filtering-correlation-id: be07e636-ee66-4276-07ae-08dd9a2ba848
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eWFxa1ltTVFVWXVrSTY3U2toZVA1dmlkMzJSejkrQ2krWEVIczU1NndXcE01?=
 =?utf-8?B?TUxGMC90dTNZTk9HREF2WXZ5Nm9uczRjY0YrMzdwWjVEL2EwUENpcjl3Y1l0?=
 =?utf-8?B?VG5tZzhHb3NBWVk5UUxJQlhGYkVFTVlJNTNSN3ZoSVc1ZER4cEVoMUhRU1Iv?=
 =?utf-8?B?citQaUdMVUNwaWF6ZjVnYnI2eHMzSXEvNzI2VVRmVUt0WlRhWU5WbXpDNHF6?=
 =?utf-8?B?YjlWc0lzQmlheW5MWDBUdFhZVEREMEZBNlVIMEFISy9hRGlrRFVKWFFHOEVZ?=
 =?utf-8?B?aXJ2cE5wN1I2a3ZOUHRRSE11Y0RlbGJlTW1GRjBUbTA1ZGFDQ245enh2U2F6?=
 =?utf-8?B?bFNZK1AwSWNVNURmRVBSbXBtakN5R1E1RTBTSGJ2NkJJcmRhQnlScTdDbFdF?=
 =?utf-8?B?eU9vQnhTVExQSkUwR3JIUXhwKy9Zb1pVOGhoUU55L2kxVG93M2taMExxNmJp?=
 =?utf-8?B?UjVsUGQxdUlqckhvRDN6VFhiTlFob3VOUDVxN0dkRjQ2TGIxOUJLUEFZUU5k?=
 =?utf-8?B?OTNFRmhZWGN1dG02eVU0WjczcDlQT0Q2ZktKU3gvU3NLSzNXMlV4dmdJVGNZ?=
 =?utf-8?B?RjN4a2k2YjdWTmJiVCtSeUI3OXM4cC9wRFFmREhDSFVWKzdtWHBrdGlKeUts?=
 =?utf-8?B?eGZRRDY0cnRCTEZhTGhLZDZ3Zy81RklWWHVZelR1dmxkbjVmamI2ZE9ZY3Iv?=
 =?utf-8?B?NGRHVlI0akp5NW5YSCtJTWNHSk1tSTZFTThJZnhIZU45NVRRWnlGVFcrY1Ax?=
 =?utf-8?B?VGx0N25FS1Z2UVpLUUNnYUVqSGZIVVhVcmJIQXlYM2dnVTBKVkkwYUdKQmZp?=
 =?utf-8?B?aERaNDhneDJBV2pLWkhTa0ZSUEJSY1BJcW55Ylg1T241enMvSjJqcWIxMXBl?=
 =?utf-8?B?aWxhMmNHbjBYZkNVQVI4ZjJIdTNWMThZVklLeXo3VndxaDNBcFZDZEdVaDhN?=
 =?utf-8?B?c0F1UDUyb1lqM05YMFIwVXEvV01Ub2NGYmhVS05PUktmUFJOS2lzUFBZb2k5?=
 =?utf-8?B?SVZYU284UnRMS2YzWUxMZVpGQ0hGUU8rMnk5bTA4YlVtYnBkdVNETStLK1FP?=
 =?utf-8?B?VVZjRnFJbEJYVldJNXFCMXJMRitkcGRUYU82T1NvekNkbWtmUm5Bb0hUMkwx?=
 =?utf-8?B?T1Vqa2J1L2lsc094RVdJdE1wKytGMlZMSHZCRG8rMldOWmx0WE04aENIWXZH?=
 =?utf-8?B?dkx3ckluaTNrdGpBaElIRkdlbkg3TXM1TnFOaXp3MDJSWXdXL0xqc1BKTVd5?=
 =?utf-8?B?aFFldHNFYUgrSGVsSWd6T3ExSlAwQXpMM3N6TjRFNy9GZTFaUFlTM0MxSjc5?=
 =?utf-8?B?VEpoUEZzOFgrQVF3NjZkSVNSU1JmTmVkKzA4akVqZk0xNTNyNExOakhXQTFI?=
 =?utf-8?B?ZlVvcUJuT29YYkVEME1LZ3ByZVFXakxMcit2TzN1OWhoTDNBaEdDVG92bWgv?=
 =?utf-8?B?VklLak5aTHJyVktRa0F4ak9JVUkxWWJSdVAxOHJ2a3BabDRDRnRTQXRMaDA1?=
 =?utf-8?B?eDcvTnhJVVpkOXRPRU85dHhlemVDTEhBcXZaeFNOYXQzYTIxNTl6RS81VXJB?=
 =?utf-8?B?K05kdDMxSk1wbVlUK2tWdC96QUY1ZnU1RXY4YUZpb2xhRENaR1F1ZW5lY2p2?=
 =?utf-8?B?YWF1WCtXNlE3d0ozcXVoQ3RRQ1gweFY4N3RTRWJRZUVJT0M5b2hQZWtGbDZh?=
 =?utf-8?B?SDdYM3FRR0kwLzVpalV6ZUFPZGsyNVFXSlRGckpTWDZ5WWRwaDRFdXptYVpR?=
 =?utf-8?B?MmVyNGt5YlE2Q3NldmsvUDljTzVGaVBoTnBvWnByUXo1YmgzL1RHbnJONFg5?=
 =?utf-8?B?SG11Z1pTZzRyTmFtcTErSFZKeEZJaWxhYTNxNTJmYVdUWmpQdjUrYi9ORVRJ?=
 =?utf-8?B?T0ExWVZpMmIyTWpZVElES2ZEMWJsQkVCNFlOYzByZVd6dFpYVUFpVjBjVWw5?=
 =?utf-8?B?clBaV0Z0UU9pVTUvdWpBbDF4c0ZDMGNhQ3k3VUx4eStlNjV5WjZmb3RuTkg3?=
 =?utf-8?B?QnhLL0UyZmRRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5671.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?amZjMkE4bzlueWFBNElwWVdkY3JaY2Q2VTRnN2prT2dkTzZ4dys1WnE3ZWpn?=
 =?utf-8?B?Vmc2MG9tYzYyUE9LRWE4TzZOT3hzM1liV0pmUENLU3lleklkQlVJamZQU2FM?=
 =?utf-8?B?LzZqMUR2NDNUbXQzeSt5QTFzQXpGMWZ5MzVJN1dRZitCSHprTG1OdnFUZ29q?=
 =?utf-8?B?QVN0N0Q0Z3VVa2w1OWJIUTdZeEF4bHdvMm5KZjQzeHd0Nk12WHVDRUx2NjRN?=
 =?utf-8?B?cHJXaG42aVVnaFhsVXc0OUlKbUdnaUltaVd3NDUxNHlmVUNtTytiR0tQNWxt?=
 =?utf-8?B?bEN6cFJwQlEvK0d5ZUJ4cGVOSGlYTFcwaGVnZmZwd2ZyRFhJRHhLM3lxNitQ?=
 =?utf-8?B?UTgyTUZwYlpFNkpUekI3UnpsT3BuUDhFbzlYMkpHZUR6R2R0dCtYcUMwemlq?=
 =?utf-8?B?YzdWcytuTWt0RlVhUU9na00yN01uS2RjWnplTHNNY0JHNkFyRGFoMkdITllX?=
 =?utf-8?B?ZW1pUXFhMUIrdDZhZEI5bnN6Tk0vaXVvMllUTGtpeWhwS2ZoU2hRSDdMUXEv?=
 =?utf-8?B?Mnp1c3Q3ODlYc0RJWm1seHJ1cEdPSGtBZkI5alRwUjM5amlPT1V0dW9QdXFU?=
 =?utf-8?B?VGdQRTBsQW53Y1VNaHpGVG8wOU1NTGhaZGNESVd1TVY2Nm41enJkNlM4MXFR?=
 =?utf-8?B?eHVLMEhJQjcyeDVjZlRQOWNjaCtmVzVGejF0RDFvRDJVTzY4bk9NS2gzSEpR?=
 =?utf-8?B?djZGUGw3SThzdnBBRjFFaUNZQVBxczZpVEdWS0lzc1JDYVV6QVpyZGZkdTFx?=
 =?utf-8?B?RW55RGpNSWhPOHBNM1NwUjBXa0VaS0NUdzU5bjlGNm9Pb01kUmdZdFpkSU42?=
 =?utf-8?B?aW5jd2JFOHRmUzdyWlFGZlBzak4wckV3ZXVxK3VZQ1ZwSStUMnUzY01SaHQy?=
 =?utf-8?B?NVZFMEowbkl5V1RETDFHMnl1cXB1bzlpczRueTNpQXlkaEI5SHV5WFpEZkd5?=
 =?utf-8?B?djFqZEhpaW9QcDcyWHJiS1hMY0JTbkxPNWFzeGxaczlVcEdmclZCZU9kRmor?=
 =?utf-8?B?WHdYaG9pbE10ZHZqZURMbUhqemxjUDJOaXRzVlhGdDhjZ3JNa0xWMzJHckVD?=
 =?utf-8?B?QnlJbjJ5TjJCZjZjK1ZKWUM1YnZvS1c2UlNNVWo0Q0lYVlJ2ZE5BanJVR0JO?=
 =?utf-8?B?eXdiNEtqV2JHZDN0dTNuTnA4T0JzdVBkUVArNnZFQnR1cE94WWZaTkJNdUd6?=
 =?utf-8?B?dTdwUzVsVXNZenIwNU5CTDk1S1NZRGhsc3RtZ1l3ZGc2azg0alhQOG1aWHhp?=
 =?utf-8?B?VDRKYW1MQ2ljN0hiOUoyaVFMR1dwWnJjd2xRbFpXWk1sMG9OZGlHcnhTQ0l5?=
 =?utf-8?B?OHk4cE5oWGhobVVqbzNDOEZWTmE3RnVDMUZTUmxaNUxScDdyYjI5V0FsWHJI?=
 =?utf-8?B?dG9naGVxLzB6NGEzK3ZBZVRzL2tNRURUNkZHcUFSYW01YkI5SHM0eXlCT05y?=
 =?utf-8?B?VU84Zk9mWDRoakNheGlLS2tlMDBZSTlDRDJyQ1p3V2pWMVlkTHZrTnRmQzJ6?=
 =?utf-8?B?K1BaeXI1WGs1N0xOR2g5dk9NZ29HQWRRSExVRlVrbmV3SVRxZ0w1K0kzVFNa?=
 =?utf-8?B?bmk2QmlLWWN0YlNGNnNubXFraDdXdWRpNlZUaE9DaEhVZ2xFVlI2a01Eb1l3?=
 =?utf-8?B?LzJZY2hGUmVsZlB6WnovMFF1VlBkbVk1c0ROVHlHR3I3M2pZUlJxek85WTlt?=
 =?utf-8?B?eUtCVmU1YkZqUWU0MUs1amJRNkxJY2wzelJ0SkNMU1pUZm1wNlBkOGREakFY?=
 =?utf-8?B?NktkdmRPNnhzR29pMzlEWmxKZmRrQjRjWW9GdmRhbXFTNS83ajkraVJXaGk3?=
 =?utf-8?B?cnJiRVltZi9FbVBmM1haSytpeVJ5VnJqaEZMMlp3ZUFrdm5heTFxUzJVY3oz?=
 =?utf-8?B?d1B0ODl4QkxzamtRVU83NDY1K2dpOVhpNG9mMkZvdUVjV0ZVQnphYXp3akMv?=
 =?utf-8?B?dStxSXgvbGdnL2ZWbTJUS3cxK2ZTdkxxajJ6d2JlUnB2SEFyUWN4aGVYd3BZ?=
 =?utf-8?B?U2doNlFhZ0t0VlhLNkkrOHYzYmZTWnJtaU5EY1RDUHhvMUtwRUtXMnYwOUta?=
 =?utf-8?B?UTRmY3UwOWU4OXJnQzIyeis2Sml3VmxCQWFiVHJ0NGdYcVpiS25UY2Eza1lh?=
 =?utf-8?B?LzFvVVNFNTFtd1VNQ0YwSlZ3UmR3MUFBNWRvOWZVUzlMRE5EcVFGc052WUN0?=
 =?utf-8?Q?hWKtcxoXQCTGVnM5YwAT0s4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12D818FD6BB4C745979074C5FEB586EE@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: be07e636-ee66-4276-07ae-08dd9a2ba848
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 18:57:25.3565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WRJ7Dch38gzBpDF0SKS3TljGv547h/JOXpKgPuuBzbJEBO9h8IfvFIkfQLEV05urBAisdMW2MsLuZhKxVdI1Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6166
X-Authority-Analysis: v=2.4 cv=dtzbC0g4 c=1 sm=1 tr=0 ts=6830c518 cx=c_pps a=joOa9jS1HckycheXktnQag==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=o6MlS1fm8hq1_3pDCgsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1Gm7o8BGFMVFhUuZy5Au3XkVhZNoyoUy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE3MiBTYWx0ZWRfX3viW9Z7+5QZI g2KB9mdCAIAv/Q81utzNWy0oJZ0pmv7DQNbpQ/9GCQWVNZ+Wb1GjaQlN/JiJiTC0aA8yhc3bYvB uG7D/Fr5itkJMHWXnXHoXrnI71F8UvMD8mEA5srrjh/J82DSBu4wSG0Ad9ST3LpwdD7/Sl3HKZF
 K+yODetI/shMWkISzEkqFiqHNrZ1Pu1/Tw8g7KxvPn4CgT1GLWFOQDklPaJJOvU5sXtqkluU168 2eBR0bQfKMRFqV7fdk5BHdgx83EW9QNSB0fLvPBcYWETWyZ427qZej4ATpVBARdViZA9Zgff8yZ 3RD390fzEqra8AuYrMMmvbqgynbP8FIne3bhOi40hlureldJWYL0TQj5K4MGtozDY5yvHK3mzvm
 6rJnmLG9PeHwrUY4XfaWt3zYuONE/VoC7bzP3yq0QOPgpbfP4vWj3psnY6hiTsg1SlK6wp5h
X-Proofpoint-ORIG-GUID: 1Gm7o8BGFMVFhUuZy5Au3XkVhZNoyoUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_06,2025-05-22_01,2025-03-28_01

Pj4+ICAyKSAvLyBwYXJhbV9vZmZzZXRzIHBvaW50IHRvIGVhY2ggcGFyYW1ldGVycycgbG9jYXRp
b24NCj4+PiAgICAgc3RydWN0IGZuX2luZm8geyB1MzIgdHlwZV9pZCwgb2Zmc2V0OyB1MTYgcGFy
YW1fb2Zmc2V0c1twcm90by5hcmdsZW5dOyB9Ow0KPj4+ICBbLi4uXQ0KPj4+ICAoMikgcGFyYW0g
b2Zmc2V0cywgdy8gZGVkdXAgICAgICAgICAxNCw1MjYgICAgICA0LDgwOCw4MzggICAgNCw4MjMs
MzY0DQo+PiANCj4+IFRoaXMgb25lIGlzIGFsbW9zdCBhcyBnb29kIGFzICgzKSBiZWxvdywgYnV0
IGZpdHMgYmV0dGVyIGludG8gdGhlDQo+PiBleGlzdGluZyBraW5kK3ZsZW4gbW9kZWwgd2hlcmUg
dGhlcmUgaXMgYSB2YXJpYWJsZSBudW1iZXIgb2YgZml4ZWQNCj4+IHNpemVkIGVsZW1lbnRzIChi
dXQgbG9jYXRpb25zIGNhbiBzdGlsbCBiZSB2YXJpYWJsZS1zaXplZCBhbmQga2VlcA0KPj4gZXZv
bHZpbmcgbXVjaCBtb3JlIGVhc2lseSkuIEknZCBnbyB3aXRoIHRoaXMgb25lLCB1bmxlc3MgSSdt
IG1pc3NpbmcNCj4+IHNvbWUgaW1wb3J0YW50IGJlbmVmaXQgb2Ygb3RoZXIgcmVwcmVzZW50YXRp
b25zLg0KPiANCj4gVGhpZXJyeSwgY291bGQgeW91IHBsZWFzZSBwcm92aWRlIHNvbWUgZGV0YWls
cyBmb3IgdGhlIHJlcHJlc2VudGF0aW9uDQo+IG9mIGJvdGggZm5faW5mbyBhbmQgcGFyYW1ldGVy
cyBmb3IgdGhpcyBjYXNlPw0KDQpUaGUgbG9jYXRpb25zIGFyZSBzdG9yZWQgaW4gdGhlaXIgb3du
IHN1Yi1zZWN0aW9uLCBsaWtlIHN0cmluZ3MsIHVzaW5nIHRoZQ0KZW5jb2RpbmcgZGVzY3JpYmVk
IHByZXZpb3VzbHkuIEEgbG9jYXRpb24gaXMgYSB0YWdnZWQgdW5pb24gb2YgYW4gb3BlcmF0aW9u
DQphbmQgaXRzIG9wZXJhbmRzIGRlc2NyaWJpbmcgaG93IHRvIGZpbmQgdG8gcGFyYW1ldGVy4oCZ
cyB2YWx1ZS4NCg0KVGhlIGxvY2F0aW9ucyBmb3IgbmlsLCDigJklcmRp4oCZIGFuZCDigJkqKCVy
ZGkgKyAzMinigJkgYXJlIGVuY29kZWQgYXMgZm9sbG93Og0KDQogIFsweDAwXSBbMHgwOSAweDA1
XSBbMHgwYSAweDA1IDB4MDAwMDAwMjBdDQojICBgTklMICAgYFJFRyAgICM1ICAgfCAgICBgUmVn
IzUgICAgICAgIGBPZmZzZXQgYWRkZWQgdG8gUmVn4oCZcyB2YWx1ZQ0KIyAgICAgICAgICAgICAg
ICAgICAgIGBBRERSX1JFR19PRkYNCg0KVGhlIGZ1bmNzZWMgdGFibGUgc3RhcnRzIHdpdGggYSBg
c3RydWN0IGJ0Zl90eXBlYCBvZiB0eXBlIEZVTkNTRUMsIGZvbGxvd2VkIGJ5DQp2bGVuIGBzdHJ1
Y3QgYnRmX2Z1bmNfc2VjaW5mb2AgKHJlZmVycmVkIHByZXZpb3VzbHkgYXMgZm5faW5mbyk6DQoN
CiAgLmFsaWduKDQpDQogIHN0cnVjdCBidGZfZnVuY19zZWNpbmZvIHsNCiAgICBfX3UzMiB0eXBl
X2lkOyAgICAgICAgICAgICAgICAgICAgICAgLy8gVHlwZSBJRCBvZiBGVU5DDQogICAgX191MzIg
b2Zmc2V0OyAgICAgICAgICAgICAgICAgICAgICAgIC8vIE9mZnNldCBpbiBzZWN0aW9uDQogICAg
X191MTYgcGFyYW1ldGVyX29mZnNldHNbcHJvdG8udmxlbl07IC8vIE9mZnNldHMgdG8gcGFyYW1z
4oCZIGxvY2F0aW9uDQogIH07DQoNClRvIGtub3cgaG93IG1hbnkgcGFyYW1ldGVycyBhIGZ1bmN0
aW9uIGhhcywgeW914oCZZCB1c2UgaXRzIHR5cGVfaWQgdG8gcmV0cmlldmUNCml0cyBGVU5DLCB0
aGVuIGl0cyBGVU5DX1BST1RPIHRvIGZpbmFsbHkgZ2V0IHRoZSBGVU5DX1BST1RPIHZsZW4uDQpP
cHRpbWl6ZWQgb3V0IHBhcmFtZXRlcnMgd29u4oCZdCBoYXZlIGEgbG9jYXRpb24sIHNvIHdlIG5l
ZWQgYSBOSUwgdG8gc2tpcCB0aGVtLg0KDQoNCkdpdmVuIGEgZnVuY3Rpb24gd2l0aCBhcmcwIG9w
dGltaXplZCBvdXQsIGFyZzEgYXQgKiglcmRpICsgMzIpIGFuZCBhcmcyIGluICVyZGkuDQpZb3Xi
gJlkIGdldCB0aGUgZm9sbG93aW5nIGVuY29kaW5nOg0KDQogIFsxXSBGVU5DX1BST1RPLCB2bGVu
PTMNCiAgICAgIC4uLmFyZ3MNCiAgWzJdIEZVTkMgJ2ZvbycgdHlwZV9pZD0xDQogIFszXSBGVU5D
U0VDICcudGV4dCcsIHZsZW49MSAgICAgICAgICAgIyAsTklMICAgLCooJXJkaSArIDMyKQ0KICAg
ICAgLSB0eXBlX2lkPW4sIG9mZnNldD0weDEyMzQsIHBhcmFtcz1bMHgwLCAweDMsIDB4MV0NCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjICAgICAgICAgICAgIGAlcmRp
DQoNCiMgUmVndWxhciBCVEYgZW5jb2RpbmcgZm9yIDEgYW5kIDINCiAgLi4uDQojICxGVU5DU0VD
IOKAmS50ZXh04oCZLCB2bGVuPTENCiAgWzB4MDAwMDAxIDB4MTQwMDAwMDEgMHgwMDAwMDAwMF0N
CiMgLGJ0Zl9mdW5jX3NlY2luZm8gICAgICAscGFyYW1zPVsweDAsIDB4MywgMHgxXSArIGV4dHJh
IG5pbCBmb3IgYWxpZ25tZW50DQogIFsweDAwMDAwMDAyIDB4MDAwMDEyMzQgMHgwMDAwIDB4MDAw
MyAweDAwMDEgMHgwMDAwXQ0KDQpOb3RlOiBJIGRpZG7igJl0IHRha2UgaW50byBhY2NvdW50IHRo
ZSA0LWJ5dGVzIHBhZGRpbmcgcmVxdWlyZW1lbnQgb2YgQlRGLg0KICAgICAgSeKAmXZlIHNlbnQg
dGhlIGNvcnJlY3QgbnVtYmVycyB3aGVuIHJlc3BvbmRpbmcgdG8gQWxleGVpLg0KDQo+IEknbSBj
dXJpb3VzIGhvdyBmYXIgdGhpcyB2ZXJzaW9uIGlzIGZyb20gZXhoYXVzdGluZyB1MTYgbGltaXQu
DQoNCg0KV2XigJlyZSBhbHJlYWR5IHVzaW5nIDIyJSBvZiB0aGUgNjTigK9raUIgYWRkcmVzc2Fi
bGUgYnkgdTE2Lg0KDQo+IFdoeSBhYnVzZSBEQVRBU0VDIGlmIHdlIGFyZSBleHRlbmRpbmcgQlRG
IHdpdGggbmV3IHR5cGVzIGFueXdheXM/IEknZA0KPiBnbyB3aXRoIGEgZGVkaWNhdGVkIEZVTkNT
RUMgKG9yIEZVTkNTRVQsIG1heWJlPy4uKQ0KDQpJJ20gbm90IHN1cmUgdGhhdCBhICdzZXQnIGRl
c2NyaWJlcyB0aGUgdGFibGUgYmVzdCwgc2luY2UgYSBmdW5jdGlvbg0KY2FuIGhhdmUgbXVsdGlw
bGUgZW50cmllcyBpbiB0aGUgdGFibGUuDQpGVU5DU0VDIGlzIHVnbHksIGJ1dCBpdCBjb252ZXlz
IHRoYXQgdGhlIG9mZnNldHMgYXJlIGZyb20gYSBzZWN0aW9u4oCZcyBiYXNlLg0KDQpIYXZlIGEg
bmljZSB3ZWVrZW5kLA0KVGhpZXJyeQ==

