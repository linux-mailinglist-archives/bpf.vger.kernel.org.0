Return-Path: <bpf+bounces-50181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FA8A238C0
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 03:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9AF1889FAB
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 02:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508AD182BD;
	Fri, 31 Jan 2025 02:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="eKVl0bSK"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00007101.pphosted.com (mx0a-00007101.pphosted.com [148.163.135.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3ED24B34;
	Fri, 31 Jan 2025 02:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738288856; cv=fail; b=HSOvlRLLUGxxutkF2ldkWT5/hbIzGpLPRW6hQruezNTrRvJOFqwTLNvMhcGOQz0fZPTbQyFeWUnEX0WepSN4Y17yB6bE+mmb4rVmE+H+k+Ow4YRmkGrIhr86i8gxM1y0cDIjmMXzI7ZzbEOW6x0sFacsTE48+CPcDJeuvoLO8I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738288856; c=relaxed/simple;
	bh=zNPrWYJewmgY4vsKZb/JmnWublh+jbnrsHwqbbB0zKA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jd8bdeGLGX84RcS6FmXXrG6AMEa5204jw2GdTvTHpLv+k4S8Eb17omvkhOc5b8uKNJPoQ+7aBJrPCPb/T4EPF/DwTWLHz1UxFMOU7x0lH7DZvM+m9CwxlhUM1nz+S3K5mK0JH4l+3dFLh5Z17w7fniud1oDGq+qVZHAc9UOVgn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=eKVl0bSK; arc=fail smtp.client-ip=148.163.135.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166256.ppops.net [127.0.0.1])
	by mx0a-00007101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UNhMxj031482;
	Fri, 31 Jan 2025 02:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=campusrelays;
	 bh=46sPJlq8bXnnE2CeNjpFizm2xaSfztfjXCmaYSAk538=; b=eKVl0bSKAG2P
	H4PuxCXE0vlTvj5fx3aByln4LSOfLvum7zORlHy0kGp1aH4tETbxK15ax1H8z27n
	gqe74Ie2+X6Q2uQSGX5rlX2tiCE+9OG6pQjMH510VG5FwMb/GgZDYB8jqMBQwxpF
	1NYZwKlehk+BMobRXEX0PYw1vcxAThldSVaO315a/NfOoo/p9cFsqGMOZISs0QTU
	ZWs+yeonnmdQvcHVaiHIshKJjz2F4dQoltUwJzkrkprOBJT59DKILN6DbIUIG4za
	bRU5xiinqN/1vm8q1T4GXfnesRec0N0NfE3ivUh4wIIxL24yIKjNlJ6BrOSh7u0i
	c33yfQGRiA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by mx0a-00007101.pphosted.com (PPS) with ESMTPS id 44gj21saes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 02:00:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhf7oZX9E0kHQgVfp89F+mbHKIPoyW0co+8nrea87xDP/fDJKgu/WPyQSFL1FCZYNIdTGfCARuQNt5Iy2OMdfTwqWZDgPE0bXKPoomRrO6GUMU5K1ERsw7tdFA2Ejy7bUP6OptjW1lfX8QMm/TRIlhA2A6Q+H42Ylw6W//P5+hYV6LcZZM1wwHwfq8kcfU4D7+Xh2I2RUXkpAWYdZQpYbfB6VEQ+nipGIbFyQtCcc7fJT7vqmjQ+rJtBeNMIw8uOVX7TDcQ63mrxJ0Otgs7N1TNa0xaGwOWgpYYeWpSE2qiBKEpEiptMYNWB2Mb92FSQ+0FWki1B75YaHsS7IjiZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46sPJlq8bXnnE2CeNjpFizm2xaSfztfjXCmaYSAk538=;
 b=vOKl8zFFEaLtXuf6xk+IOD/QMoEc4oJTz2D18SfNSgKTxxONUSN1xxVVrh31fLa8cUUlT4YAdyOxZyu+BaUVH9I/M85p6WSjzwrJjX1GxUk+FjEof1ukmxlUHwp5mShSykEs9EK8aIyJtQxa0u5zkSR8RrUpB5zmczir6mdatD9d6sU8mLB3qd3/dzlww27hE/ejmW4pCt5Tx0CkjS7AqstJh2E9BQ7rHzcQTWyaI/ARB4vOSjKFGeb0vjMqgtlw15W0jDtvKZRr4woQFOx+Zjkf9tZ82Qjq3fuG34ujgVtmdQVuJajj/BJzAfBAAqee8R77seMf12pt7PKfCae/Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15)
 by DM4PR11MB6018.namprd11.prod.outlook.com (2603:10b6:8:5e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 02:00:06 +0000
Received: from DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::d52:d2da:59c7:808]) by DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::d52:d2da:59c7:808%4]) with mapi id 15.20.8377.009; Fri, 31 Jan 2025
 02:00:05 +0000
Message-ID: <9648c5e4-8f98-40f8-ae48-caa0387e0bda@illinois.edu>
Date: Thu, 30 Jan 2025 20:00:04 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 2/2] samples/{bpf,hid}: fix broken vmlinux path for
 VMLINUX_BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <n.schier@avm.de>, Ruowen Qin <ruqin@redhat.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20250123081950.173588-1-jinghao7@illinois.edu>
 <20250123081950.173588-3-jinghao7@illinois.edu>
 <CAEf4BzbCm4=NLV4DOyRxvxEtZUONzqmXBOFMp5cg=4hPEEYUtA@mail.gmail.com>
 <2sxhtfdzspkn5umtfpxiueb67v4jhl3nad6i66qtfry52o7sip@nm5oeplybppa>
 <501166cc-02fe-431c-9258-c2f44227ebc4@illinois.edu>
 <CAEf4BzbYUsPzyVkDOKYhKc+Gs4O=mZExJ1_gc=t1siMz8kvn2Q@mail.gmail.com>
Content-Language: en-US
From: Jinghao Jia <jinghao7@illinois.edu>
In-Reply-To: <CAEf4BzbYUsPzyVkDOKYhKc+Gs4O=mZExJ1_gc=t1siMz8kvn2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0011.namprd14.prod.outlook.com
 (2603:10b6:610:60::21) To DS0PR11MB7286.namprd11.prod.outlook.com
 (2603:10b6:8:13c::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7286:EE_|DM4PR11MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: 62dc4719-c700-40d0-2bc3-08dd419afb49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVRyOHJxTk1Oa1YzblZpYkRsMElmVTVsUmpBTVhSQnAveG1pRkROZGJVZ1Ny?=
 =?utf-8?B?LzdJdmVuNk1pby9lZm1wY0syLzI1T2trWWswaG4vNndYdlA5ejBpYW51dlNS?=
 =?utf-8?B?TDNySDllNEhBMzZ4SjVSZVJhMW9Dd1RKeC9ITUFLU1Yvbk5OcUZzQ2NZRUtY?=
 =?utf-8?B?SjhGeFFTY2R6eU9lRnRjVFVmK25ick5YNU81eFpBVklQc2Q2SGlOVU16RnRX?=
 =?utf-8?B?bTVWdEJYRTZFanF2d0RBSnMvWmV3blVLRWxwUExRRlBhYjNEU1pGL1NUblB1?=
 =?utf-8?B?RTNMRVd3Z29zYVhPQlRGUUhlZHV3UmJ1S3czZ0Fnc3dQNGl4ZVBJc3BTQU9m?=
 =?utf-8?B?NHJIcndtOXd2TFU1SjgyTEdtZHVRQXJja1N0dHBIMUNMTWdFQ05CRng3SmtF?=
 =?utf-8?B?Zkh5VzVPa1RZaGl3dTRIbWo0dHlNa0hwK2Z1dCtac1dRQjhRZEtBSlhNMk9m?=
 =?utf-8?B?Z2dxclFFcVhzNm84WVJQSUkrTlI2RTJ5UkllZTdQc0RKbVcwdDFrT3luSlQr?=
 =?utf-8?B?ZHFIdFRRWCtiNlJYSFByakYxWjZlTlR0ZzZkZFNaUHdyUnBuWGd3YkdqeFZx?=
 =?utf-8?B?L2prSmp5MEJXOFNQems0RnB5YnhRSkd1dEp5dnhjcTZ3aXg2c0tiSXlTcC9l?=
 =?utf-8?B?cVh0b09JVGx5T2UxeG1pTmlLVnV3VjFucWpRMDdrUDZzUUpHczFPa21JUSsr?=
 =?utf-8?B?ekUwdS9HNEtzeWd3S1JxSmV3bDJJeHJjc0psdjZubkxxcGtnN3VKTVNva3Jr?=
 =?utf-8?B?TWRtTjJHSkt6Q1dUeVJCVjUrSzBHYzV5NW1CS3VQc3g1LytUYkhjUXBhTzEy?=
 =?utf-8?B?Y2dqeXFuZ0lqUVkzN0dHOWVOVlBVU1BySmF1ZTFDZjNnSWs1NG01bnR5ZmVz?=
 =?utf-8?B?aDROTlMyS3N3d1J6Zzd2RU9GNXR6dy9ZUTdlMEFNbkdldk5vaXRwbk1iKzZt?=
 =?utf-8?B?Z1diSzFtRldJVnRFY3V3OGovMzQrckJITHdtdkZpaUFsdFNmMXNtZUhnTngx?=
 =?utf-8?B?MG9xbkxVV3hJVmNCeUJ0WkVUZTZCMUoxWG0zSzZTY1RQQkhKODU5ck41ZEVK?=
 =?utf-8?B?QmZVMXI5cDhrVFNlcy9qamhITytRM2tqMktxTlhrRnlpZmNrOEc1RStmdHR2?=
 =?utf-8?B?dHJUMEhsUVBuNUJNY2FEdVEwZTg1NHVvaVBDQ2NDaDBCK1FNVzdiYlJnRWY0?=
 =?utf-8?B?N1NYWlE4MUdPU2IxR1gxcFlNTDRNdDAyWXl3UlJuUTF1eE1Fd3d3a2dYT3Uv?=
 =?utf-8?B?WXNSTTZXVmVNUEpiSTduUklTdlRtUXdtMTJLVVBla0VkTk1xajU2MUlpeTBG?=
 =?utf-8?B?Z1htaVlvVWlkUXVWSmdYdUVTQWg2bHRiZEMzM0pvdVlHc3pLbVkyNXIzOExH?=
 =?utf-8?B?K0FSbFAyYklET2Z2WFJadXZyUVVXTjlYUENjb3l3c3NYUEpJK0JQME9BOStP?=
 =?utf-8?B?T3phRjlPeXVWQUErVzkxdUYvdzBmYlpibEJNY1kxSjFscWxHY1RpOVFTNnlM?=
 =?utf-8?B?ZngxUEF4QjlRUHY4T3ZaWWVkbFpWTkhIS0tpcTYrZDFPQ3ViNnltSERGOEk4?=
 =?utf-8?B?ZE1pMTlZMHVsTnUzYXpkMWVGNWtmSWNtRzdJTE1CNTRyMDd5QldEdEp2d1gx?=
 =?utf-8?B?WS8yZTBVZDJNUkYwbmZBTzE2TTMvbndQZjhkd1d4aXVBVDVTOGR4OWI1NVJq?=
 =?utf-8?B?U1VBZUgxT00zaWxJZXZyN3AyVCtLNmIyTnpYTU1EK0VlU3FoMmFtNldsT01q?=
 =?utf-8?B?RVA0T3lBV3lSZnZmWTBRZDVFTmg4WVVhKzZ3S0tIOG4zaDdOQjI0b28wL3hN?=
 =?utf-8?B?OWc4Uk82Wk5lUnNMazViRmVOKzl4QzY3eDJVM2RFS2NrTWZRQ1hvcXVYOUIy?=
 =?utf-8?Q?LAhqybe+c/C8v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7286.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEFwZDNQNVA2U3BzSEJaL05KZ1JMS0p4OHo5NC9HdGIyWTZGd05zTGNuQkJI?=
 =?utf-8?B?WWtEZGNGbmp6UDVKWGRpZmVBU2xUZFpFR0R4VWNNT2VCbURuNitLT1ZaajM5?=
 =?utf-8?B?cTJvWW1aMzA0ZEl1Rzh6a09pNG9YUDZDd2pUdEZrVUNWeEdhUnJLM25RbUxP?=
 =?utf-8?B?c3VTQnlmbk9xTmZsNGpJbXh5ejVTZVYyRXNCcUk2NE8zZ3BmT2JTcXNNelVF?=
 =?utf-8?B?VDVYdGlKSTNHNCtQSWxUeFBQMm5mYVd6QnpBSENyUzJ5MDhlL0dsU1A3QkZk?=
 =?utf-8?B?YUNPalFraUlCMHYveHVEanNGVmorQUQweTVFWnZDYkhTN2ZlSm01VWk0T2gx?=
 =?utf-8?B?NDV4cUhteE9IeDBaQk5MYkljSklHaldoMGxwQUFybzdPNjJuU3ZnNis0QlNC?=
 =?utf-8?B?NDFudkJGaGFIbjJ6WkVrWnZPaVUyYkVDR1VTOWtPUXFNbTRLdmphUXYvYlYx?=
 =?utf-8?B?TWhFN3FjTjc3QWc2amF4RVNHTi9MNEpNMnpUMXllaUIyeGdmbDlWWW5SZDFl?=
 =?utf-8?B?TnlUdDJoOE9Bd3I3bVFYWHZnU0NLbDViNE1qb0grMnJBbjdkSnNuKzgyMzFN?=
 =?utf-8?B?U3J3VCtMdkVZdXkvOVpnSDVzMytOZlg5K2hjNUxNdHRva3JnZHhoN2Yzc0pi?=
 =?utf-8?B?Q080M3hUSFFNcE1tblYybTA1S1k0U09zYW9rUEp1SDlXNVBCelhjSUJlQUFq?=
 =?utf-8?B?dE9lUmREdWJ1bG9xakhrVVZYSTZXQ3NKS2FCMUFLMUdPRnJKU3FENTBJSDNs?=
 =?utf-8?B?MGlrYjdydU5XVThZbEVpTzdvZHM2RWxiR0J1TGFDRTEvYWNNb1A1Q0puYmZH?=
 =?utf-8?B?US9iMkRuWWk2eEtTV0w3TXM3RzljSlBESTl0c2pTU3kyc1NFaEZQc01HQ1lM?=
 =?utf-8?B?bTRCRVJOVURxL2VnU2hBQUd3L0lGWkV5UjU3ZFN1UkhEUHlYQmpDemtvWVhK?=
 =?utf-8?B?eFhzcWVOYmFiMlhvbVpDekNzdW10TDhvRmRxcGFHbUZRL1hRbFVzaW1jK0pR?=
 =?utf-8?B?aDdzTDFZR25QM3VQYVFvVzc5QUZ1eDJTclYwKzFtWkdZY1JZRmtWYnVrdkdm?=
 =?utf-8?B?bEJjN0tkU2ZQK1A5all3bzJibEhJYkFVV2tzV2VWeWhlRTVUeUI1M05kV0tM?=
 =?utf-8?B?bW4vVHB0UmFkK0hqb0RSbjBlVm9rOWdOVWdDUytkaERvNTNHSHQ1eGNvd3hU?=
 =?utf-8?B?VHBIT25GWXp2RDdTcDVtME5lM1BXSjdEZTBmMytXMmtzbjU2OCszUUwvMVh1?=
 =?utf-8?B?UWJUZDkrbE1LRWlIMDJxendQV0dFVU9xMUxsOERLa1dOOXRocnVhMk5CN3F6?=
 =?utf-8?B?ZHhRMmtyUHRSaWI1YWRNbU9HSjFDNm5BVjIrRWdMOCtNbDltaTFFZUhBcWc4?=
 =?utf-8?B?dzlCS3pzaHVsYmtUREZaVzFMeDRGcmNyS05EMW5DWmVSbFRqUHYrQWRMU0kv?=
 =?utf-8?B?Z2R5Yjhmd01EZWhkRHphbVdXcmZZVENrU25zZ1hPcDdYanhaVU50VkdabS8x?=
 =?utf-8?B?SHlabWNmbUZNM3NHaEhVWitMK3Q4Tk9YckVnVVZjUnYxNzhaQnIzWHhPUXp5?=
 =?utf-8?B?ZFNkQ2ZTdjVKVkhCeWFsZkFrMHZEOE8vckxhN3BJNVZMN2VsMnlGaDJiOEdi?=
 =?utf-8?B?SUtXRzdzc3BzU2NWZzJGbEhhY0QxRjZtNDhaWlBvemcvUzYxZHBvZm4zNGMy?=
 =?utf-8?B?ck91N28wSE5Kc2JxTFhuelcrMnZPRVIzVERjUXRObUNJQnZPdGd2ekFYNGN6?=
 =?utf-8?B?UHhyVmV1L2dDY0phSDFNaGJMNjJvSlpVVHlYL2l4cjRPREh3Qm14OGVkYXlD?=
 =?utf-8?B?UUJOQStDaG8wSlZTTzZ6SHhTL0ZFY05CWWFmNnB6QkRTS3hLM3lFdmNxSjRN?=
 =?utf-8?B?K28vT1dubWVDUy9QVEZjb1czYUlmWElIZWlSd1hBUTgrbzk2Snk5S3Nhdjgz?=
 =?utf-8?B?d0N4NE9FbStQT1NtNmhsckpiYStPa3ZwUVNydVhYM3g0VnFIL09vUHRMb2VO?=
 =?utf-8?B?WE9TZEcwU3JlMlY0RlNEQTA3alV1L2kxc1ZFc1NVV1g5cnp0Ym1ERGVsVkZx?=
 =?utf-8?B?bE1nMEcrM1NsYk1Od05oQ1Y3WjNxbzRsbkNlb2wrT0NSN2hKeWloaEs3bmQv?=
 =?utf-8?Q?xj/w6fxf6u/H+OgUUK9+GKUP+?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 62dc4719-c700-40d0-2bc3-08dd419afb49
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7286.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 02:00:05.6298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6mP3AWi0qk2c18nHzZ+R88FJ/5x3B+lvNp8uuhY+rpt/A4yJn4sfsZpwnJg+MLvGf8jBs/ravvSLg4wcHdTSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6018
X-Proofpoint-ORIG-GUID: UKfMCVQCkK2w9vJR6xrJZJMDkiYs2-i-
X-Proofpoint-GUID: UKfMCVQCkK2w9vJR6xrJZJMDkiYs2-i-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_10,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2501310007
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 



On 1/29/25 6:51 PM, Andrii Nakryiko wrote:
> On Wed, Jan 29, 2025 at 2:06 AM Jinghao Jia <jinghao7@illinois.edu> wrote:
>>
>>
>>
>> On 1/24/25 2:04 PM, Benjamin Tissoires wrote:
>>> On Jan 24 2025, Andrii Nakryiko wrote:
>>>> On Thu, Jan 23, 2025 at 12:20 AM Jinghao Jia <jinghao7@illinois.edu> wrote:
>>>>>
>>>>> Commit 13b25489b6f8 ("kbuild: change working directory to external
>>>>> module directory with M=") changed kbuild working directory of bpf and
>>>>> hid samples to samples/{bpf,hid}, which broke the vmlinux path for
>>>>> VMLINUX_BTF, as the Makefiles assume the current work directory to be
>>>>> the kernel output directory and use a relative path (i.e., ./vmlinux):
>>>>>
>>>>>   Makefile:316: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  /path/to/linux/samples/bpf/vmlinux", build the kernel or set VMLINUX_BTF like "VMLINUX_BTF=/sys/kernel/btf/vmlinux" or VMLINUX_H variable.  Stop.
>>>>>
>>>>> Correctly refer to the kernel output directory using $(objtree).
>>>>>
>>>>> Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
>>>>> Tested-by: Ruowen Qin <ruqin@redhat.com>
>>>>> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
>>>>> ---
>>>>>  samples/bpf/Makefile | 2 +-
>>>>>  samples/hid/Makefile | 2 +-
>>>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>
>>>> can you please split samples/bpf from samples/hid changes, so we can
>>>> land samples/bpf fix through bpf-next tree independently from other
>>>> changes?
>>>
>>> FWIW, I don't mind if this goes through the bpf-next tree all at once.
>>>
>>> Acked-by: Benjamin Tissoires <bentiss@kernel.org>
>>>
>>> Cheers,
>>> Benjamin
>>>
>>
>> I wonder how we are going to move forward with this fix? Do we want to let
>> it go through bpf tree at once or split the changes?
> 
> I'd prefer the split and routing through respective trees. Is there
> any reason not to do that?

Sure, I will roll out a v3 then.

Best,
Jinghao

> 
>>
>> Best,
>> Jinghao
>>
>>>>
>>>> pw-bot: cr
>>>>
>>>>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>>>>> index 96a05e70ace3..f5865fbbae62 100644
>>>>> --- a/samples/bpf/Makefile
>>>>> +++ b/samples/bpf/Makefile
>>>>> @@ -307,7 +307,7 @@ $(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS := $(TPROGS_CFLAGS) -D__must_check=
>>>>>
>>>>>  VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))                                \
>>>>>                      $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)) \
>>>>> -                    $(abspath ./vmlinux)
>>>>> +                    $(abspath $(objtree)/vmlinux)
>>>>>  VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
>>>>>
>>>>>  $(obj)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
>>>>> diff --git a/samples/hid/Makefile b/samples/hid/Makefile
>>>>> index 69159c81d045..db5a077c77fc 100644
>>>>> --- a/samples/hid/Makefile
>>>>> +++ b/samples/hid/Makefile
>>>>> @@ -164,7 +164,7 @@ $(obj)/hid_surface_dial.o: $(obj)/hid_surface_dial.skel.h
>>>>>
>>>>>  VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))                                \
>>>>>                      $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)) \
>>>>> -                    $(abspath ./vmlinux)
>>>>> +                    $(abspath $(objtree)/vmlinux)
>>>>>  VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
>>>>>
>>>>>  $(obj)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
>>>>> --
>>>>> 2.48.1
>>>>>
>>


