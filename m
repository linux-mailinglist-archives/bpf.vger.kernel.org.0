Return-Path: <bpf+bounces-40809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E6A98E7F7
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 03:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B331C22075
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 01:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D3FDDD2;
	Thu,  3 Oct 2024 01:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="EiPmayf6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63741BC20
	for <bpf@vger.kernel.org>; Thu,  3 Oct 2024 01:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727917322; cv=fail; b=NuFlOv6/h74i+5K+BwNf8JjKer2I+tJVOK5xciWv9b/0nH/qMQ10a/lCZZdup7Fitc5Mk6r7WyK39ZSBz4Wga7PIJk8V8DTCbbJj08pSvGsM/2sydpVwwtuowIq4dM2zjXAagJ7I0+17FnePo0QN0k2PV5yDmYDl03d2UAihAz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727917322; c=relaxed/simple;
	bh=qxzRqIHHoqCeQYb56I0n6BK4ai+GA5hN2r43+2l0QeE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=usiKh+hTEvsHcFY9H6zTFH6BQc2Jwv4yjSAsXIjXZAa/REjlaRgk4Q+EHG6/YM2SqcQMTf8iStl5umMJiQ7ri8SYpNNBZ7v4G/sN5GFVSY/QvJ9I+k25bjtCDuHwjiv2HeWT9Q23DhTuqB4Uts9TlJeF9F1OTpB/fcUzlxPNWHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=EiPmayf6; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4930iWAS018848
	for <bpf@vger.kernel.org>; Wed, 2 Oct 2024 18:01:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=s2048-2021-q4; bh=qxzRqIHHoqCeQYb56I0n6BK4ai+GA5hN2r43+2l0QeE
	=; b=EiPmayf64ZvNxSBDvcWn8pEpbgeBDH6TwBNCLNOw9gRwbyIvXMD4FPNwpyU
	DivwpaauamNlCDy5WNm9SRQLLsbJI5CdllEyKBgCZx9YAY2phFR3bg/HAevKar3a
	ycspYzfl+ZSUP//xZzvp7iLYHIlIOm1cuyQyFmsddnEGFyQHrJud5WPtLJ46O558
	k4NUtEd1pVsDhE1POI0Uiy+IevU0J6d/FAn5qXKPidOJ033dQ3XTnSaZYA7YJbol
	WkQIaEcSOaNiDFFESLwb0A6f+HEgRgvUH0xJEswu4IacEoXnPzIOYHjF1xmtOHSJ
	lonzWEX9czutmeLTZ2cE4sh0t1Q==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42163x4ned-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 02 Oct 2024 18:01:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQTbTSE4hcoMr97dmb+la+yLrBQp/z0PA0qNALZv0RSuIHJM2qSBEbfqSXCSHlx1kmoZtHUFUXMtalg1AsowrgVHfEP6THW/3WUBIU/YKr2HGWqHtknbF5bERZvwxFVi8piJi7znR21RZjls0dTa0UOSTVma4rGzLh0J6hIwW20oj41kak2wkM+xcrDS50a7oaqLT81d5wS2q9XtIfm+oQj+mca5I8Y80iRgRUNa7dJbbwbyodZgmiPhgvLhsGaiDFxNvlHrt7jZjsKadzBohHKApDXYJSy9XikNWjnLWEmXTMNSz7bZex6qC/iWbxPMcg/EfI9wHI3NK1iwfZ4gjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxzRqIHHoqCeQYb56I0n6BK4ai+GA5hN2r43+2l0QeE=;
 b=BNTALur9ZphXWrOM1l6BvWs2ioCJs9rEiYmbGEGE3krZCE4ShxxDaDxbw8B2/qcvsGy/NGRzXGzOLEuEjT5eoDD6Z7ASmt3UGMqkZ7SNUabe0C8GGhFysqwrzsvKZx6wnfSKfrccjtsg8SE77uSqPIJ0m9jWVqZw5U7mwaNSVMvZZUU8fHG6k70BqJ504frPquWk7iXuVnq95XCd70wul8+rEFvzAJEHHl179/TCFRiGpUHEizgORCBbVszRFDA0HMH8cxU0uWmKVEsYm1OaEX1EFkUsD9DlXAVQGmbZfmOY4y+B3JGLOybSd4x2mRFb2M4qlkbiFsl7pcci0tb14w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from BLAPR15MB4052.namprd15.prod.outlook.com (2603:10b6:208:276::22)
 by CO1PR15MB5100.namprd15.prod.outlook.com (2603:10b6:303:ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 01:01:55 +0000
Received: from BLAPR15MB4052.namprd15.prod.outlook.com
 ([fe80::d42a:8422:b4de:55db]) by BLAPR15MB4052.namprd15.prod.outlook.com
 ([fe80::d42a:8422:b4de:55db%4]) with mapi id 15.20.8005.026; Thu, 3 Oct 2024
 01:01:55 +0000
From: Daniel Xu <dlxu@meta.com>
To: Namhyung Kim <namhyung@gmail.com>,
        "bot+bpf-ci@kernel.org"
	<bot+bpf-ci@kernel.org>
CC: kernel-ci <kernel-ci@meta.com>, "andrii@kernel.org" <andrii@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v4 bpf-next 0/3] bpf: Add kmem_cache iterator and kfunc
Thread-Topic: [PATCH v4 bpf-next 0/3] bpf: Add kmem_cache iterator and kfunc
Thread-Index: AQHbFP4xKrvLuTe+REuNf5Nadm/3wrJ0KZiAgAAMGYA=
Date: Thu, 3 Oct 2024 01:01:55 +0000
Message-ID: <96728576-f323-4eba-a1b0-5c73d357efac@meta.com>
References: <20241002180956.1781008-1-namhyung@kernel.org>
 <94bdb7a4cb0f83adf655d98a5c5f5df5299b960d2af54c87eba08de9646d0e42@mail.kernel.org>
 <CAM9d7cjGh5+5Cgw-5Nc5oO88HgJz33BUuMGYREExEgWXND3B_A@mail.gmail.com>
In-Reply-To:
 <CAM9d7cjGh5+5Cgw-5Nc5oO88HgJz33BUuMGYREExEgWXND3B_A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR15MB4052:EE_|CO1PR15MB5100:EE_
x-ms-office365-filtering-correlation-id: f5b7fcdf-6c33-4194-a2ed-08dce346f992
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VVloK2FySlR1SEw0TVRXNWtXV2d4eEFjbE45U0lRWWs3b2lnZEhBWE1seTVx?=
 =?utf-8?B?VE04VklYWW16cjV2RTJhOHJtVHo0alllRUZadEhHckJqbmNiNkxLYlRMejRT?=
 =?utf-8?B?eEM4aHZPbkNaSTlyU0tBc2YxYmlSbCtiL3JhdWhHK3RkN2FqVTN4cE5ML0d5?=
 =?utf-8?B?RDlyakdyZ21reDNhMURESWw3VXNXd01kN1ZrUFBBWUpzdGI3MHEvb2FVRDZn?=
 =?utf-8?B?RUQybU9hNnpITjlFWWRqalV2N3dScFpleEFiNThkSnVoL3p5a2IxaTcvRjls?=
 =?utf-8?B?TWs1L2ZySHEralJaZmFENXN5c2RRc05aWGYyazdnaTliWGJ1SnNRcmdubHh2?=
 =?utf-8?B?VFpKQnNuSlZJYUtVUE14NHdORnJrTVI0L2xSblhwZlF5cUZEMTd4YnUzenlz?=
 =?utf-8?B?WmFwMmU4eHlKeWpuTlpscVVXMTRZR0FXMEZySDhsNWlSc05PV0FZNlFsWkd1?=
 =?utf-8?B?cWlSN1hxeVQyaDJXSlRTekViR2dsTm9qR09NNzZSdm1JaStGZDBaeDliVXo0?=
 =?utf-8?B?Y1pOcE1Xck9FU0VOMGRRbzFSN2xWbFFSV0s4WWJRZ1Y5Smx4K2paNThSQkNX?=
 =?utf-8?B?bFRCZktEL09UUmdpRmZmN0l3SENuUnBzWUQyZEthWkV1ZE4xamxBTWw2TXdP?=
 =?utf-8?B?dUEyQmJNc0ExWVBlRzU4RU1tejV6eURCNUJHMUlaQ1hmRXl2Q1I2eHJMTmsx?=
 =?utf-8?B?NlE3Y0NuVVlFRVVIRjM5V0N6ZDJJb1FMUzl3SXE5d3FXQnhpQ0llMDhnTkIw?=
 =?utf-8?B?SWEzYlNVcEp1VHF3emZtSW5EUGZoRGtwRURQL3p5SG5ZaU4yemNPQlJEYkF5?=
 =?utf-8?B?VUI5VUJrbEsxbUtqdGg3TmJpU2k5dkVhME4zekhJbjBHZ0VuRTExRmd3azNs?=
 =?utf-8?B?b3BEZmU4L3dIa3hDanRuUjVxVUlMV2g1SS92MjVURk9pRjZzSm5BM0FTaEU1?=
 =?utf-8?B?QStqZ0dZQzJSak1zaTU3cm5JZ2tSMFdnd1VvaGZGem85Z0NyWFExWFdjVXds?=
 =?utf-8?B?RGpFTWhTb0RMdUdIazN0Yi85Uys5akZqK1NRNzBJSCs1OVhrSXlvMDNOL0tM?=
 =?utf-8?B?R3Q1S2lhZzIrOStIWnUzYmxrQU1jRTI2U05tdlVxZlNvNzJ4enZteXg3dzg0?=
 =?utf-8?B?b1RqdmNGU1VzNERCYkRLSnlVVC9pOTBHdXVNdzI0K1pPQnBvYXhPbnhwdi9I?=
 =?utf-8?B?MFIrTmp2N2VZejJESUszU3ZNamdrNVlDSFdlWW12cWorZHlyY0ZqbHUxOXE1?=
 =?utf-8?B?QWRvYXhVd0hNUk80QVA3RFY5SjNNNzNlZlp5QkUwdnREMUlNbHZJdUVBU3Vx?=
 =?utf-8?B?cXpDcjljcHZYbUFENGpQMEgxYUh3cksweW1rcnJmeWpSUTJBNXFaU0d3TUNU?=
 =?utf-8?B?RjBDYktTMGlSN29lQys5emhZd044c2hrR1B4cmRFSkNnOU14UnpKazluRitR?=
 =?utf-8?B?V09Cdjl4STFkaTdEM05mbEthVDg1a2ZxU0Eybk1Pdlppdk5UTitZK2U1VmNk?=
 =?utf-8?B?YmtCc3U2c3VSb2VxTmlKNVRZbmpyalp4cUlCTVNRWlo4YS9SN3NoS2I0Q0Ew?=
 =?utf-8?B?U0h5TnZmYXBXaEdOK0d5eWJmWnB6WHdwcjBVZWtpamozcnY3d280dGltbGNt?=
 =?utf-8?B?QWdHbnVRTFF4WitjekNSblBncERSbnRoL1JMa0lRQmRtTEc2VFpYSnlYdlBI?=
 =?utf-8?B?T0xFcGlNblhFNEQvWHZXZUg1Snh2d0l2U0t0OUdMWWxQMGVoc0o4djUvTGRF?=
 =?utf-8?B?MFZBZnpFOXRxZ1ZNUHZaRFNVYVc1ZVZkaXViRC8wWlVoZmM0N09ZbnExcTV5?=
 =?utf-8?Q?FOkPg+4jh1Wok7NC7wZzkRyjFcQb376cREJcA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR15MB4052.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?azc5c1lQNlBtZGg2bkNvbE1Ram8zb1dueEE5dkJGYi9maFJpS2VRUGNHbGNG?=
 =?utf-8?B?Q3ZqbzhoZWVpVlNMbENrT3hVTGpPNHJUL3kyL0pXSzI4dXc1UXdFNGJDYTJy?=
 =?utf-8?B?cEpTTVhyTU01NmltUThoeWVFd0VrRFlTanFmU0JPS0JDS3h6UWhLU3RIV2NO?=
 =?utf-8?B?YU5qTkdXK01aRk4veVZzMkJ0MXZtVEhhK1JXNTNnMFFBbDhUZ2JsYzN2Vm5u?=
 =?utf-8?B?bTI2N2p6WVEwcUU1aTAvMis4K0tCd0c1YndTOVVoMCtsSnVLT2w0TzluMnM3?=
 =?utf-8?B?ZUUwZ0toV1BNaWNvVzJNSHNnN1ZWVDJzNkVTWENKOXJsa1JUR2t0cUFmSlJD?=
 =?utf-8?B?NzFxZ2lQOGM1OTZIc0RaVCtrUDVUd29wMk5oWEFqRTRITzZQZjk0Wlk5WkFE?=
 =?utf-8?B?bUxyMW9HTFFnWHZ1dWJrTk10em5Qa1kvQnRtRHRIdXdsZGZrMVFVMDFpQXNh?=
 =?utf-8?B?SjVLdGEwZG9ic3hScjN3dHB2Q0FtNklIMFptWmVDOU1LSTc4b2d2WWhVNVp4?=
 =?utf-8?B?My84NGpZM1FDakhRc0RTZmFoaFdpZnY1Wkd6RDFUUmN2NVNtVWEwSmVUTkV6?=
 =?utf-8?B?YTQ2MVJRbnRrT0tGSFp2aVF2amg0bnQ3d2ErYjZBd0xPZ25MY0FGOE9nTmhw?=
 =?utf-8?B?V2tqLzJ4dzBXdlBCcEVzeWhuSzFtQWFhQjBtQ0xqNGJkMzF5TzkrNEszWDVD?=
 =?utf-8?B?KzY3SHVmWTFIQjlnSWZmd2ZHdFo1enBiaUMvR290T080ZjNXSDF6Zk9sNFRy?=
 =?utf-8?B?ZnowcysxS2ExRThkN1Y5eElBd1Rud1kxR3RQMm5KaFFhT0RaWS8wVnM0YVRr?=
 =?utf-8?B?ZERDMGlpcWVsTDgrZHVGT3hhQTlLcFBLVzNDWXF5eEFzMlV0bmtDejA0SkhJ?=
 =?utf-8?B?ZGJjNFZ1YWx5dEdWWUlSUHJONWdCbVJDcWhpTEJzY3ExSlVSR1FKV2RnSnB3?=
 =?utf-8?B?NEtTVGxjaU5SYmZQT1BMSG85TXNpU2srNitNVVlFZWw1ZngrTmdtV3Flb2dV?=
 =?utf-8?B?c2RycFBac0ZKbXJqdnN4a2NpcWVjempRM3NsclZoYzR4UTFyUFFnY2JxdEVy?=
 =?utf-8?B?c0tOKytDUkdUSVJaYVJsMGhOc0FqcG5iYTYvdk5DZlB2TmN3VzM4aW5MUCsw?=
 =?utf-8?B?UlM3eGxBRVJHMGRrOThWcTJhaC80WlcvODcxdkVSS3k0ZTErdWlkVy9Ib3dE?=
 =?utf-8?B?bktFT2IxLys1aytDeDVlZEgvdFpDcVBoL2src2J2Wm1uSitDUUpHY3kxem80?=
 =?utf-8?B?UnNFWmc1SS93RVg4VWFHRVUrRXFXNjR3SXZKeUNYUENpdDU2L00rSXovU0dF?=
 =?utf-8?B?dVBWOERtd0pTOUFkYVNOYitpMGsxYlBxL1JIemtHSHk4OStQbUN4VU5nbWhk?=
 =?utf-8?B?VHhuMmZJczRDa0tUU3FzakFzSTVIOUs4MWxhYUhjNndUQzdCNXVNZDZ0aVU0?=
 =?utf-8?B?QXowZVFhN2QzODdOZS9ObWNCa1crdWpuMUNjczRmeVNUOXNOYkQwbkhlbGcz?=
 =?utf-8?B?YWpUMlgzTkVCQU9Ga085QW1IK080VVRyZEJwSDRzOG5VSzhDTVRhUldJYmg4?=
 =?utf-8?B?R0xQMlF6Yk5WWFAzbnUyc3c0ZW1FU3V2MHNiMllpdVYyWHNpem52V1hHUDUz?=
 =?utf-8?B?WmdrS1hZcEFhSTJOSDJSNm5UWHF3VHc3a0N1b2pIRk1GdEt1SU9qdWljdWs0?=
 =?utf-8?B?M3R5WGdhbVBmbURHM28wdzUxTjdhS1JIVTBOOU02YVZxL1pZKzZURkZudWtu?=
 =?utf-8?B?STd1bFNXd0MzRnZwcWY4bURtOEs4cjJJeHdQZG1jY2FqOXgzVHhYKzNvU0Ja?=
 =?utf-8?B?SHpPMHRqQmhmNzJ5RnlScVZXT0k4OFRmbzdFQjJwQ0FwMGZ3TVRMOTlLbXlq?=
 =?utf-8?B?dURzYVFIUXE5aFpYbnlrZjBzeW5ud1lVdXQydGtjQ1RSZVZqUDdld2FoaTNm?=
 =?utf-8?B?RUxPanJ1eldMbzlONXhIcEhEVk9KS2VuaWs2Q0h5aUM5bXlEZFlaanpkQ21D?=
 =?utf-8?B?c3J4UFhuMXVxL0U3ZjhVdGx1L1hQT3JxQUZ5aE9JdUptVGR4M0cvMitIOHd3?=
 =?utf-8?B?MllLbnFJRGhTNDVhb3UyQlZBQzdpNzZ2NjZQdDFUT1JKWENheTByend0V3BJ?=
 =?utf-8?Q?7+OkQuo//gknvrS+IQsG8bZna?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ED1FCAC2BE34D459CC7670407EAD437@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b7fcdf-6c33-4194-a2ed-08dce346f992
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 01:01:55.3934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zjC5q6mW+2KhrQZoClqBk40csS26lUOMEFdtgrmkZCaxUJ9I6IuELSdYwk0WyxCE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB5100
X-Proofpoint-GUID: mkPnqcpEdWAyq1-UyB98iPrK48Jg5HWi
X-Proofpoint-ORIG-GUID: mkPnqcpEdWAyq1-UyB98iPrK48Jg5HWi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_21,2024-09-30_01,2024-09-30_01

SGkgTmFtaHl1bmcsDQoNCk9uIDEwLzIvMjQgMTc6MTgsIE5hbWh5dW5nIEtpbSB3cm90ZToNCj4g
SGVsbG8sDQo+IA0KPiBPbiBXZWQsIE9jdCAyLCAyMDI0IGF0IDEyOjA24oCvUE0gPGJvdCticGYt
Y2lAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pg0KPj4gRGVhciBwYXRjaCBzdWJtaXR0ZXIsDQo+Pg0K
Pj4gQ0kgaGFzIHRlc3RlZCB0aGUgZm9sbG93aW5nIHN1Ym1pc3Npb246DQo+PiBTdGF0dXM6ICAg
ICBGQUlMVVJFDQo+PiBOYW1lOiAgICAgICBbdjQsYnBmLW5leHQsMC8zXSBicGY6IEFkZCBrbWVt
X2NhY2hlIGl0ZXJhdG9yIGFuZCBrZnVuYw0KPj4gUGF0Y2h3b3JrOiAgaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L25ldGRldmJwZi9saXN0Lz9zZXJpZXM9ODk0OTQ3JnN0YXRl
PSoNCj4+IE1hdHJpeDogICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy9icGYv
YWN0aW9ucy9ydW5zLzExMTQ5MzUwODY2DQo+Pg0KPj4gRmFpbGVkIGpvYnM6DQo+PiB0ZXN0X3By
b2dzLWFhcmNoNjQtZ2NjOiBodHRwczovL2dpdGh1Yi5jb20va2VybmVsLXBhdGNoZXMvYnBmL2Fj
dGlvbnMvcnVucy8xMTE0OTM1MDg2Ni9qb2IvMzA5ODgzNDE1NjQNCj4gDQo+IEknbSBub3Qgc3Vy
ZSBpZiBpdCdzIGJlY2F1c2Ugb2YgbXkgY2hhbmdlLiAgSXQgc2VlbXMgdG8gaGF2ZSBmYWlsZWQN
Cj4gb24gdW5yZWxhdGVkIHRlc3RzLiAgQ2FuIHlvdSBwbGVhc2UgZG91YmxlIGNoZWNrPw0KDQpJ
IHJhbiBzb21lIHF1ZXJpZXMgb24gdGhlIEJQRiBDSSBkYXRhc2V0ICh1bmZvcnR1bmF0ZWx5IG5v
dCBwdWJsaWMpIGFuZCANCkkgZm91bmQgYXQgbGVhc3Qgb25lIG90aGVyIGluc3RhbmNlIG9mIHRo
aXMgZmFpbHVyZSBbMF0uDQoNCkkndmUgYWxzbyBtYW51YWxseSB0cmlnZ2VyZWQgYSByZS1ydW4g
YW5kIG5vdyBpdCBwYXNzZXMuDQpTbyBpdCdzIHByb2JhYmx5IG5vdCByZWxhdGVkIHRvIHlvdXIg
Y2hhbmdlLg0KDQpJJ2xsIHRyeSB0byBmaW5kIHRoZSByaWdodCBwZXJzb24gdG8gZGVidWcgaXQg
ZnVydGhlci4NCg0KVGhhbmtzLA0KRGFuaWVsDQoNClswXTogDQpodHRwczovL2dpdGh1Yi5jb20v
a2VybmVsLXBhdGNoZXMvYnBmL2FjdGlvbnMvcnVucy8xMTAxMDU1NzIxOC9qb2IvMzA1NzM2MDc3
NzcNCg0K

