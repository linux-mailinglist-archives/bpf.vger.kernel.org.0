Return-Path: <bpf+bounces-57723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9072EAAF14E
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 04:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F651C22A25
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 02:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E461EDA16;
	Thu,  8 May 2025 02:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="x5EZckcz";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="r2Y9neKV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3700E1DFE12;
	Thu,  8 May 2025 02:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746673022; cv=fail; b=Khiw0PfPjtboQp8RHmE3k9dMNKtc+8CcLHpOdN2NePhB7FyirInctUshUW/d+MGWZhv7PGxHJgs0WfjOqeubkUyGczQ5pKiS6CbuTnbK7LS5sLbCQZdz7kIhrkHPq9/B+P3oDfuU/gVS4a0XT3+p9lpObt/Y5D2HWX1dBe3ffNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746673022; c=relaxed/simple;
	bh=/WdKyFpJxNyHD9l2bosgcs6gAoAQRqChQlxfIkRza3I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TqgboMsHWUl1/+NbmOdiAICf1SjX/ceFv77uQInS4RcWA8dbAeXxbIR+Ork55lmMBH9EBJ2H2WOz+Wtd+PeNKsHv6fT5/0DeQWqPVVeNzXPA2vwqblXruAYTs33gkSsZYXeuBcYNk7CfQV4uyHr5QSKxkr+Ou9dJSfEOISz08aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=x5EZckcz; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=r2Y9neKV; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547LLfRf010664;
	Wed, 7 May 2025 19:56:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=/WdKyFpJxNyHD9l2bosgcs6gAoAQRqChQlxfIkRza
	3I=; b=x5EZckczUrh3MW8EHlZyEZsnWzcLYuj1gKlJmATcGJGxrFvrYVIQE4baW
	zpvJ1mZeJBk0hplfv0vc9dmFbHFiauTK0PpcSstsBpcciB9zPZwuHng8tgWoJ9PO
	4lU5t3T+OCxf3AhVrg6/TJEljZ41jIQbER+N4LU1hxTfVPFAePTAD/7ptgAPh8ly
	gPW5axLLEbwh0rdcvCNt1c7MhT3RM/DowcJ3Ojn83Fp6zd0ytbd9aYqVzz+IAl35
	74iQpUzVBAQEiMZ0RTsyJ/EowNACGBWt2X/5NAa6sTJVkQiRqaWZFxLD+w50Rmlw
	8vFZCBzIl0oof2INsf2ugEWMv3EHg==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46dj7m27kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 19:56:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+IDO7+Qfkt7eoZKLultCxHFoSn37/pqrO4e6c9DBHIGHz0WvkRACMgMtz/f9LfVr4deFErrsmKivCQTi0TgEbzC+FXJchjw0d6QzOl1PuXnydMXmOr4tGxGrfXbkQr0UzCiePRhgWKUZDkQD9xDz4MUqN/2HHUYB32RHEeckn0YLDIApn1SNxBr6qy5x7+GGQbjIMRfXGjS/SpAvC6qm0VRn/iq26bq/tvP3MkdifEnLfW/G+CTuSLUq7Mc7UvpplbBXoTKFEKu+EUr2E/qP2DuXZp1dAFPBEFYHOZ9cs1rJEXvhImVEE06SRP5FMrIT+lxHgegq5EWBaeKoWhE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WdKyFpJxNyHD9l2bosgcs6gAoAQRqChQlxfIkRza3I=;
 b=bTdUNMKXt9A5usnYbSIC7H4EePCD0wc8cdXLUZrbDzedb8FizSNjgm254RmEw4Q+92gURVPSt2Q8rsV9s31fZ98L5ToirAeUq6b8B5R4nkzUytU9YSExEX4vcrakSapIpT4wG/Gz7CwTTL0m+wd++y70YudOmb3bShtmyrMAjQvpx5usPg9tyko2LOgaiaazegkViz0ici5JD/624+WfDxxt7qNzPDX4xhzIiuXmSzNF3LTDV2pbSF3f06rfNPiPTkJcuurr5GGYvaydVcVlG2hO10aZRnKJw8QaYpiLpFWkwtmG3jOTvLWdzQRkIiEEHDLIA7ooHSTiCOLw7T7WmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WdKyFpJxNyHD9l2bosgcs6gAoAQRqChQlxfIkRza3I=;
 b=r2Y9neKVMcNUiKbLK51YTJbGbOgij0VY4/N92mlfOpxZoyoAZ/vtIJNGR0K79Bt3fBzbLVFXKB19IdEgI9rRgQ4JeCxMdv1kk6n/lB8BfCUWdteOrTxvgg2fFmpHP259yxkqEd8/uFGDg97Mny7VgoDOYCDIKC/M0wH4MxtgIg/LH3Hz0wpW+/2c6oLc3joFxKA+Vxp1z2TVUevAtbxccsan/Fg9LzayD8HlTugR37k98DZXgDZuHnaxeY0hwo/tMIIvqYOLkJHUOwWtGmmQNvT3bslP60UaPnYLx9fRuf4A0bgVCSKVhesGsMhzJddQHS5GPL3qoqrO4fdX89PAUg==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by CH3PR02MB9610.namprd02.prod.outlook.com
 (2603:10b6:610:128::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Thu, 8 May
 2025 02:56:25 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 02:56:25 +0000
From: Jon Kohler <jon@nutanix.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper
 Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next] tun: use xdp_get_frame_len()
Thread-Topic: [PATCH net-next] tun: use xdp_get_frame_len()
Thread-Index: AQHbv2eEW0uswKQU00yY881fwUmSW7PHpieAgABkjwA=
Date: Thu, 8 May 2025 02:56:24 +0000
Message-ID: <1DDEC6DE-C54A-4267-8F99-462552B41786@nutanix.com>
References: <20250507161912.3271227-1-jon@nutanix.com>
 <681bc8f326126_20e9e6294b1@willemb.c.googlers.com.notmuch>
In-Reply-To: <681bc8f326126_20e9e6294b1@willemb.c.googlers.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.400.131.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|CH3PR02MB9610:EE_
x-ms-office365-filtering-correlation-id: 63b0b70d-3e4d-4aeb-cec9-08dd8ddbebcf
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S2pvbCtHMjhWSDVnaXUrNE1ETlVzOUlJNW5zUUJITW9FRUR4Qk5XN0l1V1hi?=
 =?utf-8?B?VVBhUEppc2pOaFBqYXk2V3VwNW5hUjZ0ODQwTkdmeDN6eS9wbEp0QkNicWlV?=
 =?utf-8?B?MzZCV1RUdWhtUExFaDZxbnp6VGpuNUtLb0RsamJaaVFwZzRwN0MxNnRYditL?=
 =?utf-8?B?eXlHR1drN0VlWTFyMTI0cFVxNUZ0cUg3S0g3TldGSHBRZXY0cXdYVFJiRW1Q?=
 =?utf-8?B?eTdQSlJPTXBIZitOU0JPajZLWW5YOElkVzArWVdhTlhVVHVTeTBnSDBITEtW?=
 =?utf-8?B?am41MnFpSTdjOThHV0lMQXVDL1ZZZFJIZE9jVTIzNmZwdjRvQk9INU5BL05x?=
 =?utf-8?B?UVlSWnhHZFYxWlpKNDVTOUlrNmxEL2tBdDltdmNRREptdFYzQ0VNT0NKa1pX?=
 =?utf-8?B?QWdlY1V3cHliRHkrdXBlb3QzRUQwT2tDNVNTMEZFcDM5ZzRGcHJzclVrMXFQ?=
 =?utf-8?B?SVE0by9qTldPL0dmamdjWXc3MWxUQlgyQkxLaXhpWkp2NWl4dXJSM2owKzJB?=
 =?utf-8?B?MFRET3NMK0VVb1BFSWlKMzVKaXk4Nzh6Z0wydnJGd2JSSStYVkRnaWFoOXJX?=
 =?utf-8?B?N0VlWlEwdTBNbjVBQ0J3TTRUS1BuNjlqam1Bcmp2Q1NJNmxTUE0wUlNCeGcr?=
 =?utf-8?B?Ty92czBrVDYvNkcwZk5PbENCdFRBUGRGbmduUHJpN1k4R0ErRkpVZ0wvTE1p?=
 =?utf-8?B?NkRPaHdLS1JwT2hhc00ycndYNDYvQjFkZG81N0Y0VERXc2J0S2JQUFJVQ2pi?=
 =?utf-8?B?L3c0b2VXZDhDZ20wTU1jR3hYcjh1WU40OFB6aUJtdCtrK0pRWEkvOHBwa1hh?=
 =?utf-8?B?Nk9mMnhEZjdOSnlzdEhJam1QUlFqMEFJOTVLMmRqZVBwUjgycndTaGh5dkhp?=
 =?utf-8?B?VjdpeWVGajg3SC8rRGdIaSszRThhL0tPaVNLRDV3eDN6dTZUK01mTHlFWVVt?=
 =?utf-8?B?NStabmhJL2xFRlpXQk9jbHJITVJRMzBFVmNZVnNaVWpCU05WUW1lNzcvMjFk?=
 =?utf-8?B?bVAwZXlnRFF0eTZaNUdQU1RnTWgxMnpHMUIzMlNZL0k2TnRxdE9TSlJISkhp?=
 =?utf-8?B?SE0wZWtMVFM4cnUwa2pZdEFxUGVuVERTTlhQWDNHNER6alkwWUNwRjJwdzda?=
 =?utf-8?B?ZGFGcTY5RzVSNVl5UzZ6Y2lSZTZMNEpobmhNaEk4WlZ2R0lOdW10TGFvR2tT?=
 =?utf-8?B?c3M2SXJNNWtianJYYVVmcmdxSTVncWQra1hTVm15U0hrQTNmN2lTNFhsL2RW?=
 =?utf-8?B?UjNLbHVMa0gzWm9UbHFxN1dNcFZLTVVhc3Jzd0NkVmN2SEFyVTBFNEJ1OUFX?=
 =?utf-8?B?RVBmMEFJUW1yUHBNenlNbVA4SnpTdE91ZHYzT092bTFHWStQUkJYWmVBZGIw?=
 =?utf-8?B?dDVrUWx6cjFlUXlOYXFCZWUrYnBmZ0x3SHpmZHdLakIwcXBHRmV3Skl0K002?=
 =?utf-8?B?MXl4d0lTTlNvZkpOMWs2c2ZyVUc2THZmRUNmendHSlhxMWRRcG9JT21rakFU?=
 =?utf-8?B?SVdrS0IwL0wxUVhqai8yOUl1YWV4dzJac2UxcVQzS3o4OTNaYmkwc1l2Zng4?=
 =?utf-8?B?VmNianZNZG8vSUJwWUtRcFVIazllQWNxOEVxTGpMQkFWR0x3a3NUWnl2RkhZ?=
 =?utf-8?B?U05FT0xvVjFTUjFUS3M0RnA2bUU3NnNsSXVlUXZjcHNCZ3FiS2JSNmo1dkxD?=
 =?utf-8?B?MGV1R3FYMTdzWVR6c2tCR3RTRk9ENXNNNWpYM3JWdTUvSEc0ZWF6VmE1SURE?=
 =?utf-8?B?QTFyK0FPUm5sSWcycE0zWVVVNm82LzFBQUUxbWZOOHVhdHVwazlHOERNSjFj?=
 =?utf-8?B?RnhkTUFUVnRQNjJ2Ulp2ZFRKUEgxYVZmTE14QlFhQkxwNDFQc3NoUEZWbjBv?=
 =?utf-8?B?VGI1S0hJUkkzRytxb09KaE1DUHhZTVZ0TEFzVW4wYVp3UitHaHpFWkJDa0E2?=
 =?utf-8?B?R2x5NnV0aDd3VVpLTkF3cW9SeGdZd1R1V1NHa2x4N1FxMzZ0UjVGTWZvUTFK?=
 =?utf-8?B?U0QyZ0hiZDVRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UnpsY05PcWNyREJVbWo2SHIyWWQxQUQ2QjZCUkc2THBISXc4WHVobldHWDIv?=
 =?utf-8?B?ZGtSWUgzb0VWQktQd0VPR2xjY003Sk1sSGt3WFl0bDhWRVdCK0J3enhsZk1I?=
 =?utf-8?B?VUZWMFFMRk5xeXBtZUljUjRCdCtPMmdncEFEWnJnQjJ0MlZ1TkcrODhKdEcw?=
 =?utf-8?B?NUhkUGNrNDU4V1JBeXozN0xkcCswTzI0dDM5WU5wKzltTGZWYzQyNERhNENJ?=
 =?utf-8?B?N3NoUXcxMjZUSzg5M2RKaHVVY3ZIUkJmSzhnNTlDOHFVZ09vaEptNW91T0Zx?=
 =?utf-8?B?aStYTENrUFE0M1ZsbnhjVUNacCtGNUYrU25QU1dtV1p2ay91RFdwU0ZkS3FH?=
 =?utf-8?B?RjZYYmlaOUtrU2M0UHJRdUxDWXV3ZnA3NE1RMVY2UjhaWWswcVBFZE9xNGZp?=
 =?utf-8?B?TnRFWFEvbWxQZlAzTG13VVMrWDRmNzhhS3lWbWx2Z2xQYTF6R2FNNUM3ZG10?=
 =?utf-8?B?cXdVYkIyWkJpT3dFeEdibWNSYlVDZHIvQnJSZjJvbDE1QzNzbFNJdFVzeFBR?=
 =?utf-8?B?bUl0TFN1djZZUjhwTFBtaUk4T0orbjM3YytFRU5xb1pveUFDRzZqcmZZMERC?=
 =?utf-8?B?Zk5zY05HdFJjeUtWdDVOd0tLbVMxYzNtUk9hMWplZW80enp0RXBORXlrVFNC?=
 =?utf-8?B?bHg0OU5wWnczZlZ4T3FrMG9RWFI0bEdNSXR1dmRaSCtGNC9UOVZYS1AyUE9Z?=
 =?utf-8?B?UURrYzJvUWR3dmhadFRoZ3Y3T1l2VXZuSlR1MTlzUXpWTDlmNTU0SUpNbXRP?=
 =?utf-8?B?cDdBNzFkVUVHMnUydDVGUFFCbndoVTRPOEd6Tk12VlBnRzQ1WUp1YVhmNVIr?=
 =?utf-8?B?MWFQRGtrYkpTNnhveXJERnAvSVljL24vSmhJVm1lenQ3NW5sREVVSmVlaXhS?=
 =?utf-8?B?WnlZTFppOW12VmU0QXpMOGZOeEh2azB3NFVrdFlVRTZrZ1NMNG9YbHllK2k1?=
 =?utf-8?B?eFdJQUN0R2wvT0dqeGNWQlBTZHdQSGdxZFNDdGdNUW1GVFo1Zm40TGRsbG4z?=
 =?utf-8?B?MXRhd3FHblZnRk1JZUFaV0xjVHVaeXE0QXBxYnIxdXNlejlWMzI0OTZYeTJl?=
 =?utf-8?B?bkt0UmpQVzZpdmVxWnhtblR4WklZbXR3RG5HL2VMellnY2wwV3pOR09McGh1?=
 =?utf-8?B?bnhVZFNCakVZSUpHcFNubVFrUklHcG91VytTM2lxVEJnLzRNVTRUQ2UxMml0?=
 =?utf-8?B?cHBBM052UDl0U3Q2TzQwNFNJcHFTNzlJY0hhOEgwbzZoS0lrOGtjemVDSzda?=
 =?utf-8?B?ODR0TjFZRHFVRWtKeXl5OFBDdTFHWlV6YjZwQWxrT0krQ2lBbFB3dWw1b2FQ?=
 =?utf-8?B?OTZSdjA2MFZUckt3ZzZ2djJ3eUhNNkU1enJZczRoZ3dmRTBDMTBiZmtmcEtW?=
 =?utf-8?B?V1lMSEp5VDJnaGdPaFdzb3ZydGt5aWw5bUhnWGp0czFtd0xyZTZNUTk3a2dB?=
 =?utf-8?B?K0ZFdFk5MklCMWpiRC9LU0ZvcTBXUzNMSkp4ajljVjhBeTZORXk3SGFUZ0FI?=
 =?utf-8?B?WDFjaGp3MGsxVDY0RXhaUUQ3M1JtMFlidWQ2RThmc1crMnc0OWRNMzhFcXRp?=
 =?utf-8?B?OG80cEV6dVVTWjJTbDJZKzhnZVY0bVc2c0hVOWs2Vkh5MTZHSDRXV2ZHNGxn?=
 =?utf-8?B?azNDWGMvOTFZaWo2enl4NjBGUERBbjExczlsZ3plU0xqdEVzYmtDZzJBQkhB?=
 =?utf-8?B?STlpRExNZEJ1SXpUanNkQXR3ZG44OGpmY0I5SldTcHRhTCtMSFBHR2l4TWJ6?=
 =?utf-8?B?aCtSMitvSXZsTEJoODQwS2xES00rL2tzZ3J5UENEMFdrN2NibkRiZ213dmU4?=
 =?utf-8?B?UVpuZHdua3VCTEZpWEo0cFJRdXJzNlE5elBGd2h5WTZIZFVMVlZqTzVPbFpO?=
 =?utf-8?B?MzMrTXRGUUNZcmRtU3Z4NVkxOFZVYXJldzFSMkZJcjFlYlVVYk1jb2lxWEtW?=
 =?utf-8?B?WnBVd1JJUGVxNnlubEZDWTVPejExNUFiMStqSHMwMGlodEl0NWlVMWhXanRO?=
 =?utf-8?B?SnNiUXJBVGhYWmJjMjFIdjl2a1FoUm56QzRkdnkwa2hOWEVnZGdPYmZmNGlU?=
 =?utf-8?B?YnVrRHIrbUFYcnZHQnJ0ZEpURXIzQUYyTWxxaUZTd0FhMDlDeWdpNDFXQnVD?=
 =?utf-8?B?RWxTbm9uZUVNRmR3UmFmZGVzOFRRT2FCaVRvODJncGE4TVMyTE9ROHVwYjJR?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DF3E897BEE17D45A92FE9B46D5D368B@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b0b70d-3e4d-4aeb-cec9-08dd8ddbebcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 02:56:24.9674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9F95cvAqMbXT5IUqe6Sr6Tb1NtSYXwHXLYjkVLRO1S37nKTxv9ThuTaTNEuW7dGnuOGIZ4IoC6WWuM80yFYxSOz6NVcJON+w8dwmWDxkioA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9610
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDAyNiBTYWx0ZWRfXx+c8lqpjWuHb aMeuOeu24kQ9HaXimRQuiZJOjHs7L+V8QTUHWdD6w8YDoHyKGnkzUzZ0LU/HBynX5bQnjMOYME9 b0AS199S6KtRtwZIEdHKTqh9ZtUjlLuAK3LOX/pe7fPp1r7YxanGGQ83aEE3KG3x3v0H6hlMMJJ
 rN8qV/1vFGVc14XDYaLv91Tt+lqvt0vVmi7KTeprSfCHZbBPhvPu9alk/uMQVu7j+jnD57uFB1D 9JWTfS0jdxO9+mPOGP+JHMLzGVCXtnGkW+8oLtrE9ov5krlvul4dCdXYRv2bGaI0XRDFS9+gNh+ JKzNQ6rbOn1YZkhfhjGPQ+doX5dJYePVhr6aAyo2312sJ40+pYuQMVg92Z5MptHM3YITsesWwuZ
 18h8+TxwErMai5LzLfwmrIybosoSBTGJY+43elwqQw7ROClfdG6tahPUmzOU1jrsuNXHtquD
X-Authority-Analysis: v=2.4 cv=LNpmQIW9 c=1 sm=1 tr=0 ts=681c1d62 cx=c_pps a=oYCWE2dcp7hbP1SgTdEJ+A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=pGLkceISAAAA:8 a=64Cc0HZtAAAA:8 a=krVESuu7WunwzPRMhosA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Fx77T2X8i7bfLURd5olmphAdWaSh1g3Y
X-Proofpoint-GUID: Fx77T2X8i7bfLURd5olmphAdWaSh1g3Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_01,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTWF5IDcsIDIwMjUsIGF0IDQ6NTbigK9QTSwgV2lsbGVtIGRlIEJydWlqbiA8d2ls
bGVtZGVicnVpam4ua2VybmVsQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwN
Cj4gIENBVVRJT046IEV4dGVybmFsIEVtYWlsDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IEpv
biBLb2hsZXIgd3JvdGU6DQo+PiBVc2UgeGRwX2dldF9mcmFtZV9sZW4gaGVscGVyIHRvIGVuc3Vy
ZSB4ZHAgZnJhbWUgc2l6ZSBpcyBjYWxjdWxhdGVkDQo+PiBjb3JyZWN0bHkgaW4gYm90aCBzaW5n
bGUgYnVmZmVyIGFuZCBtdWx0aSBidWZmZXIgY29uZmlndXJhdGlvbnMuDQo+IA0KPiBOb3QgbmVj
ZXNzYXJpbHkgb3Bwb3NlZCwgYnV0IG11bHRpIGJ1ZmZlciBpcyBub3QgYWN0dWFsbHkgcG9zc2li
bGUNCj4gaW4gdGhpcyBjb2RlIHBhdGgsIHJpZ2h0Pw0KPiANCj4gdHVuX3B1dF91c2VyX3hkcCBv
bmx5IGNvcGllcyB4ZHBfZnJhbWUtPmRhdGEsIGZvciBvbmUuDQo+IA0KPiBFbHNlIHRoaXMgd291
bGQgYWxzbyBiZSBmaXgsIG5vdCBuZXQtbmV4dCBtYXRlcmlhbC4NCg0KQ29ycmVjdCwgdGhpcyBp
cyBhIHByZXAgcGF0Y2ggZm9yIGZ1dHVyZSBtdWx0aSBidWZmZXIgc3VwcG9ydCwNCknigJltIG5v
dCBhd2FyZSBvZiBhbnkgcGF0aCB0aGF0IGNhbiBjdXJyZW50bHkgZG8gdGhhdCB0aHJ1DQp0aGlz
IGNvZGUuDQoNClRoZSByZWFzb24gZm9yIHB1cnN1aW5nIG11bHRpLWJ1ZmZlciBpcyB0byBhbGxv
dyB2aG9zdC9uZXQNCmJhdGNoaW5nIHRvIHdvcmsgYWdhaW4gZm9yIGxhcmdlIHBheWxvYWRzLg0K
DQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IEpvbiBLb2hsZXIgPGpvbkBudXRhbml4LmNvbT4NCj4+
IC0tLQ0KPj4gZHJpdmVycy9uZXQvdHVuLmMgfCA0ICsrLS0NCj4+IDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC90dW4uYyBiL2RyaXZlcnMvbmV0L3R1bi5jDQo+PiBpbmRleCA3YmFiZDFlOWEzNzgu
LjFjODc5NDY3ZTY5NiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0L3R1bi5jDQo+PiArKysg
Yi9kcml2ZXJzL25ldC90dW4uYw0KPj4gQEAgLTE5OTMsNyArMTk5Myw3IEBAIHN0YXRpYyBzc2l6
ZV90IHR1bl9wdXRfdXNlcl94ZHAoc3RydWN0IHR1bl9zdHJ1Y3QgKnR1biwNCj4+IHN0cnVjdCBp
b3ZfaXRlciAqaXRlcikNCj4+IHsNCj4+IGludCB2bmV0X2hkcl9zeiA9IDA7DQo+PiAtIHNpemVf
dCBzaXplID0geGRwX2ZyYW1lLT5sZW47DQo+PiArIHNpemVfdCBzaXplID0geGRwX2dldF9mcmFt
ZV9sZW4oeGRwX2ZyYW1lKTsNCj4+IHNzaXplX3QgcmV0Ow0KPj4gDQo+PiBpZiAodHVuLT5mbGFn
cyAmIElGRl9WTkVUX0hEUikgew0KPj4gQEAgLTI1NzksNyArMjU3OSw3IEBAIHN0YXRpYyBpbnQg
dHVuX3B0cl9wZWVrX2xlbih2b2lkICpwdHIpDQo+PiBpZiAodHVuX2lzX3hkcF9mcmFtZShwdHIp
KSB7DQo+PiBzdHJ1Y3QgeGRwX2ZyYW1lICp4ZHBmID0gdHVuX3B0cl90b194ZHAocHRyKTsNCj4+
IA0KPj4gLSByZXR1cm4geGRwZi0+bGVuOw0KPj4gKyByZXR1cm4geGRwX2dldF9mcmFtZV9sZW4o
eGRwZik7DQo+PiB9DQo+PiByZXR1cm4gX19za2JfYXJyYXlfbGVuX3dpdGhfdGFnKHB0cik7DQo+
PiB9IGVsc2Ugew0KPj4gLS0gDQo+PiAyLjQzLjANCj4+IA0KPiANCj4gDQoNCg==

