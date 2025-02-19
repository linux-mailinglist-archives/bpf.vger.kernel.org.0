Return-Path: <bpf+bounces-51970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08384A3C520
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 17:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B033189C01C
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 16:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD371F8F09;
	Wed, 19 Feb 2025 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="N6kWGOqv"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD3A157A67
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982800; cv=fail; b=VX+OkxiSd0Zi7O7n0GNLOCHfRmZ53Gyrx6oQDp3wqjz/gbsLpLypfO01neuOzbNojPxH+1vpN4caLQNdJX8ztJBDiZz74I0eQKfrmCvvisNc3YDRvjPx3RJmm+c+jSZZxe/e2SHVACTztxs/DCac09inoBPF/+wkq+wNK0rknxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982800; c=relaxed/simple;
	bh=4DPikHNFRlxRRCaghSmYBm5I84n3SIDQpwRD9zFlf5Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T3SvmWwO46AgkxPiI/ytNFEZ3dy11qSkAf1Y/lYu7Llr2TANS6Dg1VM1uf9Ktb5UngluwlDAHS9Ah3AZI24J3Sp6CxBqGY72WJdpmAhjj3QBNeB9tclVHVDMQr5i3AmQXoL9Kr85ncdiDcD15pvcGF1hfOCFcVqjoRX2glvG3Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=N6kWGOqv; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JDX9SF008698
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 08:33:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=4DPikHNFRlxRRCaghSmYBm5I84n3SIDQpwRD9zFlf5Q=; b=
	N6kWGOqvTh5ZXZdFXR40Fg8rNs1fe96bSh90m7uv5Ps+WtlNl5foLepQaOxicNgr
	RSc4EzLhRoG4lQ7QscEtnk+FdqoocjurftdY9PHhHxioGJhBeTNQiVVlfs5ZTUEB
	03SHqV86BglQw3UZLnPnst+ZOF7q011A7Yb5MI17V7plIXmv1sZSKWkgCJoRoTIa
	a3p2z6XDtvMoJpNDwmCpTyxi/jdA/D88JahadxgwDkwAY8nvXTia1RwjFOsISqtR
	SICwy5TTUY2vBVakADDam+yzdwLHeW69NVunxwi4NT0ak833YJqJ7qT3n5QXmeKU
	3EsUkq4CHusHYCgbAduzyg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44wg8m9avf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 08:33:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1kPNht/9oCy+FL/+C9crnLkR9cmR/sPZEqvG+TXkGYiUnCX2t1HLzgiE/ReVMwbammuKAJgT0CW6/tKPv4SHYGvj572njKGQYr+yUiPTE4chW5YdnZzCm36ZSTY/XxIP1AGjWFSfft6z7/0RoJAMs+xyc8AS2FNhSPOR52esVUnOsVSpSkNMEn7H1gO/K312UbMpr5eVOOQzXGL4e7JOEZO8aEzaVJKxEUaMN/qy0CRDnYAJbBI4SY9j3vupBwgLgCZbp2SVPSDIWJb4DSJRUi4Ihe6WHDG7BSf6hmS2A+6iB8WanMXz098oREmdopeBNiAp41W2rMbNOtRLBp30A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DPikHNFRlxRRCaghSmYBm5I84n3SIDQpwRD9zFlf5Q=;
 b=pFEUd+qEPM+apdQzm4H13s/d1OdRymLMo7uNKd3/Osp/SOQu9jIoDe0rS6lzw/t+Qtn4hgDvSwsY1x0zOUYfifAVIEvhCpnfRZBgNI66rVSeFkSYifoaX57D51lL7HLQyABSCYTPwM+67QIWR3c+erms/MDSTlunr6Le9Oyyd97g0hHLUhpt/kg+oPvwniAENPAPBF5wqDgNxUFUrf/78s/wgUUQK5RkjqYMSGjpzuuu/TNNXxAdh+PTk5u8QZKsq/m17LVj6Oc1m1GTcYv8m5EHvWN4B8BPAy6TOmD+f2Z/SYWdUCVdLxGRF6P4dCz6S599ER0TLKorJo/Vhuxm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BLAPR15MB4052.namprd15.prod.outlook.com (2603:10b6:208:276::22)
 by MW4PR15MB5251.namprd15.prod.outlook.com (2603:10b6:303:189::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 16:33:14 +0000
Received: from BLAPR15MB4052.namprd15.prod.outlook.com
 ([fe80::d42a:8422:b4de:55db]) by BLAPR15MB4052.namprd15.prod.outlook.com
 ([fe80::d42a:8422:b4de:55db%4]) with mapi id 15.20.8466.015; Wed, 19 Feb 2025
 16:33:13 +0000
From: Daniel Xu <dlxu@meta.com>
To: Jason Xing <kerneljasonxing@gmail.com>,
        "bot+bpf-ci@kernel.org"
	<bot+bpf-ci@kernel.org>
CC: kernel-ci <kernel-ci@meta.com>, "andrii@kernel.org" <andrii@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 0/2] bpf: support setting max RTO for
 bpf_setsockopt
Thread-Topic: [PATCH bpf-next v3 0/2] bpf: support setting max RTO for
 bpf_setsockopt
Thread-Index: AQHbgqgrQxWPOlIc6EiT2pyD1EGf7rNOT8kAgACC1oA=
Date: Wed, 19 Feb 2025 16:33:13 +0000
Message-ID: <bfc930d1-4a96-47c1-a250-e53dfe7a153f@meta.com>
References: <20250219081333.56378-1-kerneljasonxing@gmail.com>
 <38bb5556f4c90c7d4fbe9933ba3984136f5f3d5cf8d95e4f4bc6cbfb02e1e019@mail.kernel.org>
 <CAL+tcoDZAwZojcMQZ_bc71bxDpdfSE=q5_6eXirZLEWXFnY33w@mail.gmail.com>
In-Reply-To:
 <CAL+tcoDZAwZojcMQZ_bc71bxDpdfSE=q5_6eXirZLEWXFnY33w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR15MB4052:EE_|MW4PR15MB5251:EE_
x-ms-office365-filtering-correlation-id: ec68ed53-c7e6-4f9c-37e0-08dd51031b1e
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b0d1OWNUenhNYzVKbzBwQlVKMUp1cUlNRkhCRi9rUFUyQU0yc25oOFJnL2li?=
 =?utf-8?B?cGd3Uk1xYkJ1Z0tJTENqVGRSQ0oyT2E4T29aZ3Mwc3M5YXpES2EycjU3VWlU?=
 =?utf-8?B?ZFVsSFk5eFBoT3VLWW5iMkNJN2hnem13MTNObjM5U0MycmFGTHR1Z0E3dmlF?=
 =?utf-8?B?QTBWWXptQnhaVEhJSEs0dUN2U0EySUpicThaeDRqbGtKR00rRW50RUxxQ3VD?=
 =?utf-8?B?c3BlWmh3YmNwTDl5c3FndU5OOVBOOE9JVDJVWlNwWG1KbnZsQW9NR2tsY1gr?=
 =?utf-8?B?T09XbTIvYkxEaHIzN0xOSS9NaTNiWXN0bDR3MVhBdnVCV0Irbm9CRm9oeDNt?=
 =?utf-8?B?WGNXTzF1NURLbTNmamxjZ2I1NlB3V2d6c1VYU1pML2VodEpkVzBObGNsNzJV?=
 =?utf-8?B?NzhIUDlENEdEc3NjTHRTblZjWXhiV2FaV1pPNTNQMHhEQkgrMTR1WnNUMktQ?=
 =?utf-8?B?OUJWMU9TS2pSemx6bG5Vem4xUDRRMmlCUWp0d2FNQllzUVdMZVJVZnQ4Vitw?=
 =?utf-8?B?LzZkaTBEc1h1dGVGTkhQNUt2Si9DNlhDTnE0dEFQTkw5cnNsTDVxN0RMQU15?=
 =?utf-8?B?WTBGSU54R3FJR2RIODVuUzhSUkZCVWNLQitGdytyTnhzRzJzRE8yQVYranZF?=
 =?utf-8?B?VEhrVVJLTFAxSkNvQkM3ejAwRmV2UFk0NXY5YXFNZWxibkcrYlU4NytKS20w?=
 =?utf-8?B?TkZyaWlHZ0dPM2pMS25XNFUrdGZSYlFBdVNjT1VWQ2JyZHhjbXRnWlV5NkFN?=
 =?utf-8?B?M2U5NzUzbVBoeHp6ZzIrVXFncnJLdlpMNEp4TDQ5Qms2emtER28zSldFdXJR?=
 =?utf-8?B?aWVlMnJqOGxJUTdJZ2QwdWVxZmlMWHExQ1Y3cGZNQ0VxZldZR1owT1RqbHBY?=
 =?utf-8?B?VnJ4OE1pcmU5Z0VMM1F6aUZqWUxINWVtSldXdXI5TGtxZStuTUxVeCtwSUNH?=
 =?utf-8?B?SThiN2VBL0ZScGFMVEpOV0dSRXJFVVpsaGZnc1BGUllrY1YrdXFXZ05JNW8z?=
 =?utf-8?B?TDQ5VUtMUUhFUkFNMHlKYWk0bGJrV1dhV1JVclBhOXl3UjJxZDFCZnFpcEZT?=
 =?utf-8?B?TE8zS2lZUmZxMVMySFhzK0IyT2tqNmdsQyt4SnN0YXloZWVCQWFleGh3aklp?=
 =?utf-8?B?QXpPUW5sdGdnRTI0SlJCQ3ZURkoxYUxiRGs3cDQza2hQeDBYWnlyOFRtYjg4?=
 =?utf-8?B?eWI3Y0UwSllBbGJ0UTl6QnB1Z0xoc1pydHRHOXpVVSsrSVBxSm90VE9NeGdN?=
 =?utf-8?B?YXFtVzdSRkJDa25sOUJzV2ZROVZSbWdqZEVIZjFWb3U2TnJFUGx4dHlFbWhp?=
 =?utf-8?B?Rm43VlNWZ0VrUTNqNURxcnlPd3ljMEg0NlExeUxHd0VNVjJiVWErSGIvcnkv?=
 =?utf-8?B?RXJVclExa080dEIxKzhva3VpR3BTUE9KOTJwU1VCdURnSkxmOTJielpVcCtl?=
 =?utf-8?B?bllQa2lkY29zejQ3NjFaYXhjOU9LWWtEOUZhaXNpZ1NKSHZEV1kyUUp5d3Vn?=
 =?utf-8?B?WTJrSVJZTnR4Znh1aFhtOHNUWVNyN0ZPZVIySzlQOWx3alI0Njh4ZWhKbldu?=
 =?utf-8?B?aExkOXYyNHVEWFJnblkzTmRKNzhWSkR2THFvRFoxOUF3WTYrbU44dzE3STFr?=
 =?utf-8?B?WnBjM3hXYjZaUGlsbGxOUjM0ZUt2aTRmVjMzU3hXbVdkQXpSZEJCNTJLNS9B?=
 =?utf-8?B?dEVreDM3Z2M3Q0hNRUNNUHBxanZablRSaklDd2o3S05kbXRpV3VvZXREWGc0?=
 =?utf-8?B?MWpZVk5NM1F4eUZlL0JFMzN6N2s0T1R6TGxzYWFlUW8xQ3VGYVNHbFdiLzdq?=
 =?utf-8?B?TCtzQ0JGT3oyNEZ5YmJZekdrSWZSNlRpMjhYMlArOHA0VmF3MjltQ3l3d0dr?=
 =?utf-8?B?akYvbFR0cmtoZyt0VGRNSXE5VEZIamQ5bHBkQis1bEkrQXZ1aWtna2FKYmxQ?=
 =?utf-8?Q?1DGE3ZMRhkSBbfKD7aTa2hIkv6Zo4zdj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR15MB4052.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZzdqQ0I4Z0huUnMwOFhnaENiUEhTajJtenBjbEZGNkZ4cmFqS2RkQXBuSktB?=
 =?utf-8?B?Um9iSFVPaDRGRy9GbmlJZnBDcVBMb0ltM1hFWGtUa2NkL1VmOEhCSTRmcjhj?=
 =?utf-8?B?c2ljclFxQW01N1FhRE9mMU55a0x5Nkhtc1hoTWVZN0R4TjQ5OXJBc3FHQWtM?=
 =?utf-8?B?ZGZDZ0I2ZytpdDhRbGhFSjd4MVBDYStPWlFzMzhqWXlhL3ZnWXgzZ0JXSVM3?=
 =?utf-8?B?ODdlTkxTS1V6STZRWmtKa1o0Nm9WUmlyZkdDckRpcU52SmtXaHhPU2tBRWFL?=
 =?utf-8?B?RWxrVzBITktsV0RvTFlxbUVhWlpHcUpFQis4MEdETTdMVkdmYnNXc2Y0THQ1?=
 =?utf-8?B?T3p3eS85Mm9kNHYyU242QTZoYnFRL3RJdWlBeHFYRUJxT1h6eXJ6OGRBTlF6?=
 =?utf-8?B?cXZRN0Z4YjRiZzRKY0FNUkducEQvUzlSeE40Um1UdjFjSmFPOGVZNC9LSzEw?=
 =?utf-8?B?WXg5MWtYQy9JTjN0NVpJVTAxa3RudlBia1Urajd2ZFRiTTV6UFVWd0d0ZStO?=
 =?utf-8?B?Y0FISlJxKzBBWnlOTnZwSkw4emtvVU16ZFVxRWVXN3U2NHNYcUhjU3d4OEJ6?=
 =?utf-8?B?cnR2TmVMa3E0c3RwZm5NcTAxZC80R0xKS2pMelBzdjlLdDR5MFFiTmlXVnZz?=
 =?utf-8?B?dzFFUE5MWXM0RU5XbDNva01EVG82RlJGKzBPWjRYTGlZV2JvT1oxT1hJSDRZ?=
 =?utf-8?B?OXlJK0FwRUNHUG5TbkZaY09KUlJ2bXVQZXBVY0hUM0pUdlM4M2d1Ynp4ZGs0?=
 =?utf-8?B?V3hSRkNMZWdZcmgwaE9BRUsrZ0Z5ekhXcTdFMkhjbnh6V2VFcnkrUGt4Sm84?=
 =?utf-8?B?SmNsbGVmbm1OYnZQQ2NPaStHZkMwZHpNTjZMK2pZdnM5M2VCK0tmSS9Hd1JT?=
 =?utf-8?B?ZitmaEZlUEFVbllTaWtURGZmZlA1cUF5K2srTDJBUnUwU2pRUkxTZTQ5OFpU?=
 =?utf-8?B?YzVRSUtKbTE4VGxobkt2R0tScHpCakRBa0NLWjV3L1Q0SlJCN3FPOU1kR1J2?=
 =?utf-8?B?dFdTTzduTWZFMjBGaGp2VHFTVkp0NTNkd1pFU2tqc1VOZ0tyNWNzQkZEWHhQ?=
 =?utf-8?B?WjdSZ01aNVUxRVNTenFCNTNueGx3eGFKaGx4K3RQbC9rbmVGSXJwVWovVFNL?=
 =?utf-8?B?N0FLM3hsdkxZK2sySjVhYm0wQ0NpMzJSbG45WXhEeUJCdjJRODFpeDBqSExG?=
 =?utf-8?B?Vm5SVUZJZ01RYmswMHhFbFpqeTFyZXkydGFBMk1VOWRwWkdRYjY1TUtxNWRH?=
 =?utf-8?B?aWt0YWhXYnR3dEtZbEZzTExPL2FISEM4SElsaWhIdFFzNzhTNHB5cFFBV2ZP?=
 =?utf-8?B?NmNOZW9zNkMvVjE3Z3pLQTJPSHRLTzdVTGJrYmUzNVF6c0Vpdms4KzhQTlZv?=
 =?utf-8?B?RnRwUzVkMVJyNWU5NG5uWFRJeHhhR1YzVk43UldSRlN0bE9ZcmtaVkJodEFT?=
 =?utf-8?B?eWVhVytSSVlIWWtIUklBU3FQdGgvRWtWYmlJRFN1Qlp3TVZqemwwdWpDbWNl?=
 =?utf-8?B?MHBPL0trdC84YjUzcEVGY3pVemlXTHRkMDdncXlERk1kcDRzWHU3UEE1OC9S?=
 =?utf-8?B?Y2JiYW9rZVQ0UUNQdS9PeFFVMzg5NkdGUGI0UDN6eHV6TmlFeUJneDY0QVVj?=
 =?utf-8?B?bm5uS2RRNXJIMFRZc3MzTVNiWHR2UmFnNVlMQkdORWJ5UE92dVBoeXV6MnBo?=
 =?utf-8?B?c0JBdHVGekxvTUxpOGZNcVhSOVJhc1lDN3JsQ1c2SVFwUHEwalYyWHpaUElU?=
 =?utf-8?B?U1poVE9IR0E4MXpJZThRL3pvUERHc20vWDFWK0xkNzNyRXNVMHoxU3lpakwz?=
 =?utf-8?B?NkhzaEE1bHVtU2NpSGQrdzdGRXR6SkVMUnB3cUZEZkxIdU85OWJNMk9mUkxT?=
 =?utf-8?B?QXp2eUVMUGpUK3lCdUwvRTdlQm9ZbnFUTlI4a3FHQjVnRWpnM3VETk5VaE1E?=
 =?utf-8?B?UWg1a3YrNWZtRi9EVjlzc0d5c1lIbDBGemZtbnFwMWwrSS9MRUlnT1RiVWVX?=
 =?utf-8?B?eVpFMTRDc3drK0pSS0k1YzkzaHo1a3FXRXU1OVkyWHZCdlJQZTY0NEtlWFFz?=
 =?utf-8?B?ZG5UMHVHdjBKQVdrN2lvNFJxMklrUi9WZXUwd0hWclhJbjA5QXZBL2t5S0E1?=
 =?utf-8?Q?1pJw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A60129649B89564B9049FE9FC139125F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR15MB4052.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec68ed53-c7e6-4f9c-37e0-08dd51031b1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 16:33:13.8043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VrFddufbucpyoXWOCvtauLemQ9vCwIMryuqrj3wsq/RMioTCDvEF4WFLl4bLJEC3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB5251
X-Proofpoint-ORIG-GUID: fL3fuVDJzlRUSuo5g77I03nYHSCjaCoi
X-Proofpoint-GUID: fL3fuVDJzlRUSuo5g77I03nYHSCjaCoi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_07,2025-02-19_01,2024-11-22_01

SGkgSmFzb24sDQoNCk9uIDIvMTkvMjUgMTI6NDQgQU0sIEphc29uIFhpbmcgd3JvdGU6DQo+IE9u
IFdlZCwgRmViIDE5LCAyMDI1IGF0IDQ6MjfigK9QTSA8Ym90K2JwZi1jaUBrZXJuZWwub3JnPiB3
cm90ZToNCj4+IERlYXIgcGF0Y2ggc3VibWl0dGVyLA0KPj4NCj4+IENJIGhhcyB0ZXN0ZWQgdGhl
IGZvbGxvd2luZyBzdWJtaXNzaW9uOg0KPj4gU3RhdHVzOiAgICAgRkFJTFVSRQ0KPj4gTmFtZTog
ICAgICAgW2JwZi1uZXh0LHYzLDAvMl0gYnBmOiBzdXBwb3J0IHNldHRpbmcgbWF4IFJUTyBmb3Ig
YnBmX3NldHNvY2tvcHQNCj4+IFBhdGNod29yazogIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcHJvamVjdC9uZXRkZXZicGYvbGlzdC8/c2VyaWVzPTkzNTQ2MyZzdGF0ZT0qDQo+PiBNYXRy
aXg6ICAgICBodHRwczovL2dpdGh1Yi5jb20va2VybmVsLXBhdGNoZXMvYnBmL2FjdGlvbnMvcnVu
cy8xMzQwODIzNTk1NA0KPj4NCj4+IEZhaWxlZCBqb2JzOg0KPj4gYnVpbGQtYWFyY2g2NC1nY2M6
IGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy9icGYvYWN0aW9ucy9ydW5zLzEzNDA4
MjM1OTU0L2pvYi8zNzQ1MjI0ODk2MA0KPj4gYnVpbGQtczM5MHgtZ2NjOiBodHRwczovL2dpdGh1
Yi5jb20va2VybmVsLXBhdGNoZXMvYnBmL2FjdGlvbnMvcnVucy8xMzQwODIzNTk1NC9qb2IvMzc0
NTIyNDg2MzMNCj4+IGJ1aWxkLXg4Nl82NC1nY2M6IGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWwt
cGF0Y2hlcy9icGYvYWN0aW9ucy9ydW5zLzEzNDA4MjM1OTU0L2pvYi8zNzQ1MjI0OTI4Nw0KPj4g
YnVpbGQteDg2XzY0LWxsdm0tMTc6IGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy9i
cGYvYWN0aW9ucy9ydW5zLzEzNDA4MjM1OTU0L2pvYi8zNzQ1MjI1MDMzOQ0KPj4gYnVpbGQteDg2
XzY0LWxsdm0tMTctTzI6IGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy9icGYvYWN0
aW9ucy9ydW5zLzEzNDA4MjM1OTU0L2pvYi8zNzQ1MjI1MDY4OA0KPj4gYnVpbGQteDg2XzY0LWxs
dm0tMTg6IGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy9icGYvYWN0aW9ucy9ydW5z
LzEzNDA4MjM1OTU0L2pvYi8zNzQ1MjI1MTAxOA0KPj4gYnVpbGQteDg2XzY0LWxsdm0tMTgtTzI6
IGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy9icGYvYWN0aW9ucy9ydW5zLzEzNDA4
MjM1OTU0L2pvYi8zNzQ1MjI1MTMxMQ0KPj4NCj4+DQo+PiBQbGVhc2Ugbm90ZTogdGhpcyBlbWFp
bCBpcyBjb21pbmcgZnJvbSBhbiB1bm1vbml0b3JlZCBtYWlsYm94LiBJZiB5b3UgaGF2ZQ0KPj4g
cXVlc3Rpb25zIG9yIGZlZWRiYWNrLCBwbGVhc2UgcmVhY2ggb3V0IHRvIHRoZSBNZXRhIEtlcm5l
bCBDSSB0ZWFtIGF0DQo+PiBrZXJuZWwtY2lAbWV0YS5jb20uDQo+IEkgdGhpbmsgdGhlIG9ubHkg
ZGlmZiBJIG1hZGUgaXMgdGhhdCBJIHJlbW92ZWQgdGhlIGNoYW5nZSBpbg0KPiB0b29scy9pbmNs
dWRlL3VhcGkvbGludXgvYnBmLmggZnJvbSBWMi4NCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL2luY2x1
ZGUvdWFwaS9saW51eC90Y3AuaCBiL3Rvb2xzL2luY2x1ZGUvdWFwaS9saW51eC90Y3AuaA0KPiBp
bmRleCAxM2NlZWIzOTVlYjguLjc5ODllM2YzNGE1OCAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvaW5j
bHVkZS91YXBpL2xpbnV4L3RjcC5oDQo+ICsrKyBiL3Rvb2xzL2luY2x1ZGUvdWFwaS9saW51eC90
Y3AuaA0KPiBAQCAtMTI4LDYgKzEyOCw3IEBAIGVudW0gew0KPiAgICNkZWZpbmUgVENQX0NNX0lO
USAgICAgICAgICAgICBUQ1BfSU5RDQo+DQo+ICAgI2RlZmluZSBUQ1BfVFhfREVMQVkgICAgICAg
ICAgIDM3ICAgICAgLyogZGVsYXkgb3V0Z29pbmcgcGFja2V0cyBieSBYWCB1c2VjICovDQo+ICsj
ZGVmaW5lIFRDUF9SVE9fTUFYX01TICAgICAgICAgNDQgICAgICAvKiBtYXggcnRvIHRpbWUgaW4g
bXMgKi8NCj4NCj4gTGFzdCB0aW1lIGV2ZXJ5dGhpbmcgd2FzIGZpbmUuIEkgZG91YnQgaXQgaGFz
IHNvbWV0aGluZyB0byBkbyB3aXRoIHRoZQ0KPiBmYWlsdXJlIDpTDQo+DQo+IEJ1dCBJIHRlc3Rl
ZCBpdCBsb2NhbGx5IGFuZCBjb3VsZCBub3QgcmVwcm9kdWNlIGl0LiBDb3VsZCBpdCBiZSBjYXVz
ZWQNCj4gYmVjYXVzZSBvZiBhcHBseWluZyB0byBhIHdyb25nIGJyYW5jaD8gSSdtIGFmcmFpZCBu
b3QsIHJpZ2h0Pw0KDQpJdCBsb29rcyBsaWtlIFRDUF9SVE9fTUFYX01TIGlzIGRlZmluZWQgaW4g
aW5jbHVkZS91YXBpL2xpbnV4L3RjcC5oLiBCdXQNCg0KSSBkb24ndCBzZWUgYSB1YXBpIGluY2x1
ZGUgaW4gbmV0L2NvcmUvZmlsdGVyLmMgd2hlcmUgeW91J3JlIHVzaW5nIHRoZSANCmRlZmluaXRp
b24uDQoNCg0KR2l2ZW4gdGhlIHRyYW5zaXRpdmUgZGVwZW5kZW5jeSwgcGVyaGFwcyBzb21lIG90
aGVyIGZpbGUgc2hpZnRlZD8gU2VlbXMgDQpiZXR0ZXINCg0KdG8gZGlyZWN0bHkgaW5jbHVkZSB0
aGUgdWFwaSBoZWFkZXIgaWYgeW91J3JlIGdvaW5nIHRvIHVzZSBpdC4NCg0KDQpUaGFua3MsDQoN
CkRhbmllbA0KDQo=

