Return-Path: <bpf+bounces-65150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C65B1CCA1
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 21:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04114188E120
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 19:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194C029E118;
	Wed,  6 Aug 2025 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utah.edu header.i=@utah.edu header.b="L2xAg2kf";
	dkim=pass (1024-bit key) header.d=UofUtah.onmicrosoft.com header.i=@UofUtah.onmicrosoft.com header.b="BrIP2P6r"
X-Original-To: bpf@vger.kernel.org
Received: from ipo2.cc.utah.edu (ipo2.cc.utah.edu [155.97.144.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A35621ABDD;
	Wed,  6 Aug 2025 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=155.97.144.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754509942; cv=fail; b=udPdfWPb9eXLCzYiw3vIjbAwcs77h8S4pYD7QlJMdaPQh3dh7ehQ/tbMM4p8d7mjsYnuv0DH0TeYGhW4M1w+dJSAPHc0KLDS5rs4FCjhg0I9VMSLZ7yE24x31+nxrEHolAw3NjWcX+WeyIApFI+s6f+iI4T2JR6OVTiRRP4llTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754509942; c=relaxed/simple;
	bh=0pSVZazb1ZFrDhG9xIt0MpHzJX4gQNkHFBzvBB1//TY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T+jjlkrDnXdERA1HWiDiMRCKBOaB+n4Dsozh+mV6gk3zBcrKfy8ogvENIIpVJtkCcGIxT7eCksFSs+lf2jpwb2J1nHmQb5aVeymSCpl9BKtJQBOwNsiKDWJht/e9UJ5xBYmrZDwrSB3n/FzX6JKVPoBIj6OZNVlvA2GMXFp71FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utah.edu; spf=pass smtp.mailfrom=utah.edu; dkim=pass (2048-bit key) header.d=utah.edu header.i=@utah.edu header.b=L2xAg2kf; dkim=pass (1024-bit key) header.d=UofUtah.onmicrosoft.com header.i=@UofUtah.onmicrosoft.com header.b=BrIP2P6r; arc=fail smtp.client-ip=155.97.144.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utah.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utah.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=utah.edu; i=@utah.edu; q=dns/txt; s=UniversityOfUtah;
  t=1754509940; x=1786045940;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0pSVZazb1ZFrDhG9xIt0MpHzJX4gQNkHFBzvBB1//TY=;
  b=L2xAg2kfhqd1zkio9df0AZzbdGLCHfuDuBDwLH4vT6C3q1Bv+YibR5kr
   fbQiYb37Rr++w/TdmT9P6j1eOfs8H9gwDPbQ//xWc0I7OOc1rgGiVG+u4
   Hz3h9DAoX0J9PH/heBYssI62pK34PHxzyDgmBC6M1u9UYeppGrIQrze+H
   mslgCgVRIDldoQUqobYIh6p/53wRby4HcqaxCiGxKwLZJRZ4QF7qpIZcY
   6rDdwdA3HyikKkFPQOF8NtZ0+ek8s/TvFl/h6gKfku4rAQuy6mKEdjHUh
   NFS2mJh3brhxEfER9E4lXTOIGkHriRsiNgAXGuPvLYPyKq1AfRXWlQY4W
   Q==;
X-CSE-ConnectionGUID: Y3WbVVAyTV6CjbllX8TLAA==
X-CSE-MsgGUID: h9C892hmTlWEDEOys+t/Pg==
X-IronPort-AV: E=Sophos;i="6.16,209,1744092000"; 
   d="scan'208";a="92966484"
Received: from iso-dlpep-p04.iso.utah.edu ([10.71.25.167])
  by ipo2smtp.cc.utah.edu with ESMTP; 06 Aug 2025 13:51:03 -0600
Received: from iso-dlpep-p04.iso.utah.edu (iso-dlpep-p04.iso.utah.edu [127.0.0.1])
	by iso-dlpep-p04.iso.utah.edu (Service) with ESMTP id 164BF4065D6C;
	Wed,  6 Aug 2025 13:43:23 -0600 (MDT)
Received: from UMAILX-M201.xds.umail.utah.edu (unknown [172.31.233.10])
	by iso-dlpep-p04.iso.utah.edu (Service) with ESMTP id E5C814063D00;
	Wed,  6 Aug 2025 13:43:22 -0600 (MDT)
Received: from UMAILX-M200.xds.umail.utah.edu (155.97.144.200) by
 UMAILX-M201.xds.umail.utah.edu (155.97.144.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Wed, 6 Aug 2025 13:43:24 -0600
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 UMAILX-M200.xds.umail.utah.edu (155.97.144.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57 via Frontend Transport; Wed, 6 Aug 2025 13:43:24 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxcxb4x5e6hjK0CZaGhKp8tdMINiOr7JQx4XuNbzLeycIG5Ct/k6/VNWRt9Gq529Z0tZAYqIX/dUdtzgsL/jUthOOvoEpo8Z9jd1mPrss9E0k87kDalhPCFASmfsgY3geB/vSxll7qRw2eglheHFH18ioKStkhUsDquaptnvqR9fSI0e4ngjgwTUjox/ZMMM33VLCJgvyhPGWghdaKFbHjNAtKMMjbOzpG/WFJb289LivsVHAT7NWi7SobjLwnG8WyeFbDMzT3TVRB/vU2ysUCBAF3aN/ibXChUVhYq6HjVh6wlRCZQx6Z5yj/I+r1ycNVBgsUBzUaLEp6wFtAYr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pSVZazb1ZFrDhG9xIt0MpHzJX4gQNkHFBzvBB1//TY=;
 b=wK6sM0ICPdfkeLHW0gDOsze4IZcrfXkbmNsUJYdcHOiferJTwcwPlHKP8XnQM05LeQATk2CJNrLpbMhV9IeOTBR3h8GPgDTg0lLlkTm1LK0cWJG/k2o5IugJ+Hk6GecYPpBziJYbpF41L6KVADygEx6cIFALmY5xUhb/uQUq9L5MtTk4ytqa2rSzlRcx4lpxu125dDcxQxALbDLWu6Qo8wxIKbPTYB7uDslUpnVcjXKOVtlWM3MAWUMGqIRdahhMbLDj7BPFrlw2UoJNvB1EiO2gmaw/a8wqbVDfIwW6hn+JjS9y9Qs+as/Q3qtD1BYu4b5AQx3xjOOw+MrIUad4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=utah.edu; dmarc=pass action=none header.from=utah.edu;
 dkim=pass header.d=utah.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=UofUtah.onmicrosoft.com; s=selector2-UofUtah-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pSVZazb1ZFrDhG9xIt0MpHzJX4gQNkHFBzvBB1//TY=;
 b=BrIP2P6rkZAFRczAQlev8qZLPSL1bMQ5GUie8a4S7PkeLj9M5f4pcZR6gvUL+xZwrtFTYCHzU3ZrBrsb08AC6x60TF2EURDUUloStk8/aji3WONn2OAY2r/KxIUG0//Nbp/db+bVqCrqGTZiO5Oq+aCvVKbEI2hOEue+qHDa3es=
Received: from SJ0PR11MB8296.namprd11.prod.outlook.com (2603:10b6:a03:47a::12)
 by DM4PR11MB8226.namprd11.prod.outlook.com (2603:10b6:8:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 19:43:21 +0000
Received: from SJ0PR11MB8296.namprd11.prod.outlook.com
 ([fe80::4b77:8603:59d9:7b58]) by SJ0PR11MB8296.namprd11.prod.outlook.com
 ([fe80::4b77:8603:59d9:7b58%5]) with mapi id 15.20.8964.024; Wed, 6 Aug 2025
 19:43:21 +0000
From: Soham Bagchi <soham.bagchi@utah.edu>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Soham Bagchi
	<sohambagchi@outlook.com>
Subject: Re: [PATCH] bpf: relax acquire for consumer_pos in
 ringbuf_process_ring()
Thread-Topic: [PATCH] bpf: relax acquire for consumer_pos in
 ringbuf_process_ring()
Thread-Index: AQHcAYMoNQzamUe4NUWtaJRKzuFVkbRMcmwAgAl8djU=
Date: Wed, 6 Aug 2025 19:43:20 +0000
Message-ID: <SJ0PR11MB82960FC0F6259C67733F8415F82DA@SJ0PR11MB8296.namprd11.prod.outlook.com>
References: <20250730185218.2343700-1-soham.bagchi@utah.edu>
 <CAADnVQJqbYN1VGoSqsHMqvMoZgTw1+PPS87zqsKhUtPgSarY1g@mail.gmail.com>
In-Reply-To: <CAADnVQJqbYN1VGoSqsHMqvMoZgTw1+PPS87zqsKhUtPgSarY1g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=utah.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB8296:EE_|DM4PR11MB8226:EE_
x-ms-office365-filtering-correlation-id: 99106110-8dbb-4db8-96c1-08ddd5217fb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RlIzYmo4VHlZeXE1R1BhNWdmc2lXeElSRDFOejRxSHpaUWU5Q0lSQ1V5QUJT?=
 =?utf-8?B?RXAvSWpZVklqTG5zNFZocG1FK1hGMFNhZXBselcxUUxoUTZqUjFqTmgvTjMx?=
 =?utf-8?B?c2dLZyt3TTBaS0JzZUVFeWV5Z2crcmZRV1VqdVNkQU5ma1lIdnJ4Z2JNdE9P?=
 =?utf-8?B?a3ZxRm9aMGExeDY5ZVdabmgvT2VBV0N5QUp0TFRwdmZJNlh0cEQwbC8zOHRz?=
 =?utf-8?B?ZjlsNVE5TUJpRGRWTFdqNDJoVGNhZFZKVzNFVGdoOE5icSs2bWtBZWVnMHhm?=
 =?utf-8?B?S2R2VVVFS2R5Sk5pZzFtSVFHdXdIN3FnMzhYOGRZczI1dGF1b3ZBR1hWY25G?=
 =?utf-8?B?R3FMSi9hblc0TUE0T3B3bE13QzZlYXE4cnROR2tCRDgxbkZPZ1Q2cnpJU2pJ?=
 =?utf-8?B?dHBCSVFFYWpPYzVOVWpvSGxTNlhHNHBWeXNZYUxNSlJ6dnZaaThMamNHQWhy?=
 =?utf-8?B?MDBoeU5ubmQyWUpvWTNOSE1lUHZNWTN2ejFUblpGSWY3QzhoSGJEWjA4Y3p6?=
 =?utf-8?B?TDJweE4yYXhKY1RLOFF4SDRhcjRxZ1RicG1kM0M3MGJIaFF2U0xaZmo2QlBn?=
 =?utf-8?B?OVkrTUF0WDhpRVJrNlRGZDFBRFRUdXRpN0lhMXJ5NDR3YnpBRnZyZE4vYnlZ?=
 =?utf-8?B?MWNjdjhUeVNVUDZ1VXpobnFHUkcxS0Q3UHJMYU1RNTgrTDUzOFJndDVaZURu?=
 =?utf-8?B?ZmdGREtUTjkyRFNQUTFJOEFWelRjMUV4R3Bsd0VMZW4yWVJxNnRMeFNycnkr?=
 =?utf-8?B?WmpwNGdLK3RLVFIzZVhxT2ZXSCtvYmxpTThrbkxpSjJubVVoZGc2VnZYS1VG?=
 =?utf-8?B?MGI0bVZMWEFadjdLOUZ6a2lxRkkveGFacVIvdXpNR3JjWHVoT2xqc05IUUE0?=
 =?utf-8?B?T2gxdkwwc0M0VUlGZWRENGV6dkRxVTdIYkxBQ2YzakE3OHkvVXhKVXlVTC9M?=
 =?utf-8?B?Ukp4WVZzdW9EMXBkYVY5aFdYN2RHc0pPdFkwaUFHaE5yNElYL0VJZ01oMysr?=
 =?utf-8?B?bWFIR1lsN0pFQnpkNm9IblFHa2IzTkt4ZnVHM3VmTTlqWTdnUnl3WVpaZEpV?=
 =?utf-8?B?QnRidzBDSi9Fc1RSaXJmWkRRUjViZ2hHblgzRkp0U1NDUkQ1dTFsRTNWRis3?=
 =?utf-8?B?T3I1OVRnVTNHbWxGNnYwa0xlODFvOS9oODh3anVVS2RiNkVUa3R5R1ZwcWds?=
 =?utf-8?B?bGtrcGprd1c0c296bVJVVHpSTzVkK0pXSStLeDlNa3dyVGVwWGlEQUhXTytO?=
 =?utf-8?B?NVhPMUJLMlQ5T0ZwRFYwdTN6cEN6cXc0MG1hZkhBV3VKbUdZaDkyOVhZeGpG?=
 =?utf-8?B?dDBMV25yT3AxdW4yM2VYSHgxVG1pVmY1dVBVR0psYXJ6azBGcXk3bHA2UzFW?=
 =?utf-8?B?RUVtblI4YUx3ZlNTbzFIU1o5M3NJK2F1dngvQWMxNVk2cmV0cTlHbVk5TW42?=
 =?utf-8?B?dFQxTWR1RktXUDJCN0JYVHhvUDl2NkJNbzlrOVQ2V2pwY1VtQXMyZUVuOTdm?=
 =?utf-8?B?VWpnRDVNZDgxZERFQ01LOG85R2psSGNMQ1lGazhvSGNBRGhkcHVSOTd5SDB2?=
 =?utf-8?B?Rlh0VWZCYmRheXF2dS9KSmN1MHVtOG9pRVpNdlBlR3dlWmxrUEVtRmVTWDhI?=
 =?utf-8?B?T2pGQ2M1SElwT3V3UHNadTFUelFRZmhTQkh6UGswdktCemxQdFRuQ3g3MWtJ?=
 =?utf-8?B?RXp2b3cxZFVRZzloaHpEMFlHQlYydXlIWW5FU2drZ3ZLVlVRdVBEYVp0N3Y0?=
 =?utf-8?B?WFZQQnBzeHVZYnhvRnZqckl1Q0ExMFdZWU5MbThmWnJPNDVjQlAxa0s0REMz?=
 =?utf-8?B?T1Jrbzl4MmdTS0htb3o5UkdIY0tpVjJkLzVWbjljQ3dKaUtvTW9PZGgyUDFx?=
 =?utf-8?B?YWdYNVdZN1JQMWV6VVhndU9GMks4bnpQQkNhVjI4T0Y1MzBFempyb3ZBclF3?=
 =?utf-8?Q?zR94QN3/hwo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB8296.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1lUc21YZ0RWOEV3T3hzMElxejlZVU0yRzhtMStKM1UxQ1FpakxsRWprNzVZ?=
 =?utf-8?B?MzRMV0dvMjVBdmNIRnJ2dFJka0dyNVFsRDVqNElhck03MEtYaW9BblhkZ2VY?=
 =?utf-8?B?TWZ4YmFhYVcrczJEQUd2UWVXRm5VNEViOEhwSFZUV2M1cUFVOGFXb3BPRTBX?=
 =?utf-8?B?SjluVUt2TlJMSTRuNHlIcFIxTFlIalVOUExERnhwUlRtWUFkeFpieGkvK2ZZ?=
 =?utf-8?B?cnZ5dnJvZmw0L0hpVHltZjR2UGxPb0tBV25xY1U5MXpSRHczWEZHdHBpNE95?=
 =?utf-8?B?NUluNjh2ZjFwY1Y5WUtvN0J4SGp4UVkyd3JBMU9JQTl0WG0yMEV4Q0tzNjR6?=
 =?utf-8?B?cm9ESWJHQTFJKzd3Q3FzL0s0a2NSUCsrYSs1YXRZNXFERzRDMEM3bFdIVDBV?=
 =?utf-8?B?MldjV25jVDZkNUFnNzJybVdyR0lhenYxa0tmUWtPRUtZVERDU2hYQkZxWHFR?=
 =?utf-8?B?NHZKcnRNejFoNEpIRDBnbEdHUjladHFLMnRhTEpSNFRpdWtVa0NVbk1HUUNL?=
 =?utf-8?B?UzFhMU9ySm5LNnJiVlhFak9XeXZENFFER1A4d3pLdFZ0OE1NKzRqQUNtd29U?=
 =?utf-8?B?eW44ZGVRdzU2Ui8xQ21EZ0FQM29SREhHeGlya2N6bG5pUGlxQmNpRTVONEpi?=
 =?utf-8?B?VFZjTzJaa0lPcDZ6L3M1MjMxdEd4LzRTN2RaaXlnb3JHeExqUk9HcE1COW5I?=
 =?utf-8?B?Vk8rSUVSK0JPRm44U2prTTVBRElSOTlFeGo5dmlFUSt3bE52RUkvbE96UWpo?=
 =?utf-8?B?a3FTS3Y4VXVUTHlZWitRUE90U09Td0E1SXE5aU1DL3VNWGQ2YUlvUW5lR1p2?=
 =?utf-8?B?eUFweGhtU0RIWmhPWGJMWkNramUxcGszc21CU1VZVU1sRU1aL2daaSs2amtV?=
 =?utf-8?B?MjNGbi8ySVhEN0VJb0hkZENqS0IvQWQ0bTV4T0dhMXNzeWkycFpiOVNTaUpz?=
 =?utf-8?B?dHMvOFBQVTFIdnMzOFdHclAwN3Z1M3BEUzU1L3F3YW54czBYTUhQYStjdDFX?=
 =?utf-8?B?UzBiZTJ6eENXUVorazNRZy9EOVQ4SHhSWEVHUlVNQlhzSHh5WElGR01NSW5s?=
 =?utf-8?B?bm94MlI4Q29hblRLNGFRMzloUFhkRlR5Z2tCRnpmaERKQ2JCUzBlTjR0MjA2?=
 =?utf-8?B?eERROHp1dFZFWWc2QmZENGszWUdHQ2lSNURCT2NrTDkyaUIxemV0d1dlVkNW?=
 =?utf-8?B?QXcxMVpTWFpmOENYenpBckVZOTU4TkREbnU5dXRRRkZVc2Vqc082WVQzTWlF?=
 =?utf-8?B?eGFzSkg2RFZmNytVZmlCd1hjaUtBOFliZTVjSmtCWmJnYmRYWVIvbGZSMTRT?=
 =?utf-8?B?ZzVQRjJpbGlIM1BDaEU0WWtXcks4ZnFsUVJYWlBOaGFJNUVQY1lwaVhOYnZj?=
 =?utf-8?B?QklnU29sL3lMelBrL2JSaG1YQUFaSlg2WDE3RkVKd1RRUms5RmducEFRT2ZW?=
 =?utf-8?B?Nk81UWxiVENTTDR3QldBaDBHQU9CVU9tM0ltT1VNaEhVVmsxN1JYRFZoeFJY?=
 =?utf-8?B?clU4QTkvV3dzc0lIZ3EydUNqdExDcU1xTDVLZ1lZeEVWZTBkTExpS3Q4WktV?=
 =?utf-8?B?aUdnTE9DdXhQeE1pZUhoNk9OZUZRNCt5VWc0TGNEbGlJcUJ1MmxQVWhzdDll?=
 =?utf-8?B?RldERGpwM3RFandSSDQyOEhBS3Izc1NhcVJqb1hiU2YwTTQxWEFiVmRoSkxN?=
 =?utf-8?B?V2tJNWticVBDOHh5SzNNR3NJOWJhV1dBZzZQNU50cUt3TnVtUGFLVTFzQzRu?=
 =?utf-8?B?ekNOaDM2N1FzZDBDbWVWMEJFQVBjNTk3dFZ5STdQV3NwUnVqbXh2MldHZlg0?=
 =?utf-8?B?NWozcjdURkRLUG9NMXZCSHg1ditVMVNXbHpBb3BBZnJlc052OE1ZRXYxWG9G?=
 =?utf-8?B?VWdMQ3lVaU9nbEhHaG92dWk2dUh6MGh5dTlLQTNnZDUyN3dxdVRmL3BuMzVQ?=
 =?utf-8?B?bDlGYytma1JLbzkxSisyOGszbkJMN0d5ZmJueUtYRVhtcFFvNTM1bzdObFVu?=
 =?utf-8?B?ak92TUVlUVNZUnBRc25aYXF3UDRFcytlQkVNZ1JRekVXN3hXTGUwalUySU5T?=
 =?utf-8?B?RjExSjhlYlFVV2FMY21sVjJtWFBPeE9DYmVzT1JOWEN4TmlCVlFrK3p0aW8x?=
 =?utf-8?Q?BQWy9A46WV50WxwreWi0acgF7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB8296.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99106110-8dbb-4db8-96c1-08ddd5217fb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 19:43:20.9557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5217e0e7-539d-4563-b1bf-7c6dcf074f91
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SrWVeZsqTfYEOEesjQiAJvh8OPj/ot/HNc0ebpSNv4qNBpu9PK1m99Nz50CznAbGSSsFEfkdxg5Qm77puCUDnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8226
X-OriginatorOrg: utah.edu

SSBoYXZlIHRoZSBmb2xsb3dpbmcgcmVhc29uczoNCg0KMS4gcmluZ2J1ZiBpcyBhbiBNUFNDLCB0
aGVyZSB3aWxsIG9ubHkgYmUgYSBzaW5nbGUNCmNvbnN1bWVyIHRocmVhZC4gVGhlcmVmb3JlLCBv
bmx5IGEgc2luZ2xlIHRocmVhZA0KaXMgbW9kaWZ5aW5nIHRoZSBjb25zdW1lcl9wb3MgdmFyaWFi
bGUuIFRoZSBvbmx5DQpmdW5jdGlvbnMgdGhhdCBtb2RpZnkgY29uc3VtZXJfcG9zIGFyZSBfcGVl
aygpLA0KX3NhbXBsZV9yZWxlYXNlKCkgYW5kIF9wcm9jZXNzKCkgaW4gbGliYnBmLg0KDQoyLiBU
aGUgcHJvZHVjZXIgZnVuY3Rpb25zIHNob3VsZCBjb250aW51ZSB0bw0KbG9hZC1hY3F1aXJlIHRo
ZSBjb25zdW1lcl9wb3MgdmFyaWFibGUgc2luY2UgaXQNCmNvdWxkIGJlIGV4ZWN1dGluZyBvbiBh
IGRpZmZlcmVudCB0aHJlYWQuIFRoZXNlDQp3b3VsZCBwYWlyIHdpdGggdGhlIHN0b3JlX3JlbGVh
c2VzIG1lbnRpb25lZCBpbiAoMSkuDQpFdmVuIHdoaWxlIHRoZSBCVVNZX0JJVCBpcyBzZXQsIGNv
bmZsaWN0aW5nIGZ1bmN0aW9ucw0KYXJlIHByb2R1Y2VyIGZ1bmN0aW9ucywgd2hpY2ggZG9uJ3Qg
bW9kaWZ5IHRoZQ0KY29uc3VtZXJfcG9zIHZhcmlhYmxlIGFueXdheSwgdGhleSBtb2RpZnkNCnBy
b2R1Y2VyX3BvcyBbMV0uDQoNCjMuIFNpbmNlIHRoZSBzaW5nbGUgdXNlciBjb25zdW1lciB0aHJl
YWQgaXMgbW9kaWZ5aW5nDQpjb25zdW1lcl9wb3MsIGFuZCB0aGUgY29kZSBsaW5lcyBpbiBxdWVz
dGlvbiBhcmUNCmxpbmVzIHdoZXJlIHRoZSBzYW1lIHVzZXIgY29uc3VtZXIgdGhyZWFkIHdvdWxk
DQpyZWFkIGNvbnN1bWVyX3BvcywgdGhlIHRocmVhZC1sb2NhbGl0eSBvZiB0aGUgbG9hZHMNCmFu
ZCBzdG9yZXMgbWl0aWdhdGUgdGhlIG5lZWQgZm9yIHVzZXItc2lkZQ0KbG9hZC1hY3F1aXJlcy4N
Cg0KUmVmczoNClsxXSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9rZXJuZWwvYnBmL3JpbmdidWYuYz9oPXY2LjE2
I240NTYNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KRnJvbTog
QWxleGVpIFN0YXJvdm9pdG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPg0KU2VudDog
VGh1cnNkYXksIEp1bHkgMzEsIDIwMjUgMTA6NDYgQU0NClRvOiBTb2hhbSBCYWdjaGkNCkNjOiBB
bGV4ZWkgU3Rhcm92b2l0b3Y7IERhbmllbCBCb3JrbWFubjsgQW5kcmlpIE5ha3J5aWtvOyBNYXJ0
aW4gS2FGYWkgTGF1OyBFZHVhcmQ7IFNvbmcgTGl1OyBZb25naG9uZyBTb25nOyBKb2huIEZhc3Rh
YmVuZDsgS1AgU2luZ2g7IFN0YW5pc2xhdiBGb21pY2hldjsgSGFvIEx1bzsgSmlyaSBPbHNhOyBi
cGY7IExLTUw7IFNvaGFtIEJhZ2NoaQ0KU3ViamVjdDogUmU6IFtQQVRDSF0gYnBmOiByZWxheCBh
Y3F1aXJlIGZvciBjb25zdW1lcl9wb3MgaW4gcmluZ2J1Zl9wcm9jZXNzX3JpbmcoKQ0KDQpPbiBX
ZWQsIEp1bCAzMCwgMjAyNSBhdCAxMTo1M+KAr0FNIFNvaGFtIEJhZ2NoaSA8c29oYW0uYmFnY2hp
QHV0YWguZWR1PiB3cm90ZToNCj4NCj4gU2luY2Ugci0+Y29uc3VtZXJfcG9zIGlzIG1vZGlmaWVk
IG9ubHkgYnkgdGhlIHVzZXIgdGhyZWFkDQo+IGluIHRoZSBnaXZlbiByaW5nYnVmIGNvbnRleHQg
KGFuZCBhcyBzdWNoLCBpdCBpcyB0aHJlYWQtbG9jYWwpDQo+IGl0IGRvZXMgbm90IHJlcXVpcmUg
YSBsb2FkLWFjcXVpcmUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFNvaGFtIEJhZ2NoaSA8c29oYW0u
YmFnY2hpQHV0YWguZWR1Pg0KPiAtLS0NCj4gIHRvb2xzL2xpYi9icGYvcmluZ2J1Zi5jIHwgMiAr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+
IGRpZmYgLS1naXQgYS90b29scy9saWIvYnBmL3JpbmdidWYuYyBiL3Rvb2xzL2xpYi9icGYvcmlu
Z2J1Zi5jDQo+IGluZGV4IDk3MDJiNzBkYTQ0Li43NzUzYTY1NzBjZiAxMDA2NDQNCj4gLS0tIGEv
dG9vbHMvbGliL2JwZi9yaW5nYnVmLmMNCj4gKysrIGIvdG9vbHMvbGliL2JwZi9yaW5nYnVmLmMN
Cj4gQEAgLTI0MSw3ICsyNDEsNyBAQCBzdGF0aWMgaW50NjRfdCByaW5nYnVmX3Byb2Nlc3Nfcmlu
ZyhzdHJ1Y3QgcmluZyAqciwgc2l6ZV90IG4pDQo+ICAgICAgICAgYm9vbCBnb3RfbmV3X2RhdGE7
DQo+ICAgICAgICAgdm9pZCAqc2FtcGxlOw0KPg0KPiAtICAgICAgIGNvbnNfcG9zID0gc21wX2xv
YWRfYWNxdWlyZShyLT5jb25zdW1lcl9wb3MpOw0KPiArICAgICAgIGNvbnNfcG9zID0gKnItPmNv
bnN1bWVyX3BvczsNCg0KSSBkb24ndCB0aGluayBpdCdzIGNvcnJlY3QuDQpTZWUgY29tbWVudCBp
biBfX2JwZl91c2VyX3JpbmdidWZfc2FtcGxlX3JlbGVhc2UoKQ0KDQotLQ0KcHctYm90OiBjcg0K

