Return-Path: <bpf+bounces-57771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EFEAAFF33
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 17:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394AA3B9C67
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 15:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A535B278E71;
	Thu,  8 May 2025 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ZKMvvZYJ";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="DJclFquM"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2EE7E792;
	Thu,  8 May 2025 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746718003; cv=fail; b=mroId+I7AO3fpyEBZGxXQGy4f3GxFSbsydE8U+UohIcEqp06DbM59MgaJ4K0hwmuY5o0dcPeoy1KPeyfJCcEoiMtJpUokBJu8k0b7gMmOf3RnCd/8yj9BuZkDcIAXExjWenqDUuhkVG2y1WEkiqfPBZRPS4jMLj4e/1bQc1jQLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746718003; c=relaxed/simple;
	bh=Fpde0dSRf4x2oET8hlJuZP/AWxOx9S9Sl0cfr8kS2sE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FjBYJfCqburJ9KljwyBtfxWmqDYG25Ia5JZNxAiuXCMbWa2OpWDWvkB6DqP725JSFIDveMlWozzVfWv1xBoo//MnbtpzP6aSTfScJp32bOR/yrZ63lAKBL16+5IEHx/dRgVUqGaL7DA3D5TvK3Tq8Ri20ZDVFKIxpy8/hNe9Hw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=ZKMvvZYJ; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=DJclFquM; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548AlwKk012549;
	Thu, 8 May 2025 08:26:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=Fpde0dSRf4x2oET8hlJuZP/AWxOx9S9Sl0cfr8kS2
	sE=; b=ZKMvvZYJBVpx9wbCbmD6lfQgOiacT0MLXlXyNy7nXX+o9m5ILld0ZkiTe
	/AyPsJZkhH+MxHq7qMN85bHYtCsvk/7pmEVSx90G9Qkyw8p5L2KgGx1LkvfCk0Wz
	67YxoJesE8V2VGMrIW+f6FJi1wu7DnDhMTuJRaxkPJ9HBuiOmYRRJHt0XpbnF78Z
	DNZ8yFstX0FhoTLxByME3wF+zNoLZi2p+o4QXJkD012WhmhjSE7NEB1hrq/He/0o
	W+URkDMppwQD4yC+brTwcptDU/SnLmhkWvYbCzuVX+xLebWK5PM5sD+fa/+UDTCc
	6q1io//IaWxst4JAfGSibXOWJmVdQ==
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013079.outbound.protection.outlook.com [40.93.1.79])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46djpyknhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 08:26:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyH+j5Z7t8lfZBIHwgmxt582yGOm1d1QFYLxL8FoattcosrKdJRY9Wnu0gXy6EhfK5mgaJKU91LQSKpjSB6V+A19dG/hsF+7DdtUdiG28fCE0DDQojE+4RO6nTzAhtRQVRwUTl0nFR2+ch6xDgpexnn/hl3rZhPRlFK6uDlJ6gKUqVfJgdB7e6qb+d+yvu1UbGA3B21FPgABuSitjmm93Q0Jp7npeVUWgIadCkRPhS2lUpvmdsujUht8D4q9gzyxTqMvX+315UuMEpc1O4/HHlsVy1ICyxaewFYJwOXs/YKmfUXnCDZCvTJ2/Zn3D4yyWGT28ZdW5gE/jxy+O476mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fpde0dSRf4x2oET8hlJuZP/AWxOx9S9Sl0cfr8kS2sE=;
 b=Le/+W15HKHIVIsZjmY3wLV0koR7ywTaLYuYRucREd0acY7zwvj9C94KJzNFo6Jn08lyVmWmlz4Nby+X4AshbNdgmhGw5ztaTQnGAbA0rvTG20a0YyvldXlCv/Dcvp62uVTdJAy2RHAMO3jnA+uOd16gzuHg5lL/ka79gqVlzrz0li4OM/lHCIeJ19XVjy4SGDDaxrcEZilvvI0uIHFC5KLUlnOnu9nMIjXWaGXHqfROqqMSO18s+w54Si3FxP0BdsxXj+WHt1PnbH7KuH8DK6Iqy8A6U9Xj+5dTivWstURpteHa1FhzZ2gzxepGVeLU4Pq/dGwDmqutwOi+Z9f2MEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fpde0dSRf4x2oET8hlJuZP/AWxOx9S9Sl0cfr8kS2sE=;
 b=DJclFquMlXkEIBOEIEoJSSVo3i6I23XZBcIRDmu22tMkaEnSCi34ooHujFl4apz6b1VCwVNiU3wUMSNP7RYE7YsUe9wHFQ9dwiBEi3t67x5l8s/atW404h9GqdrMPUCMhw8+sBjAECm/OmerVK7Rar8DJxnj2mrOEayCBj9OroqormGVsZ4O1PXLtBXI6aqB/4c/Gxh3SKZzKm+apqvJ/sUjf4lOdvOojiDAo5Iw51RX0aXPdj8ZdXtFRqu4NzYZSIs0xtK8Qq0ZKfofz57QmTPeg2tCy/KrBL+dE1/p5Vn0vqt1L+H1PjWJGqA6rMGgAxSqyZALzmP5Uxw96UGELg==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by SJ0PR02MB8657.namprd02.prod.outlook.com
 (2603:10b6:a03:3e5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Thu, 8 May
 2025 15:26:08 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 15:26:07 +0000
From: Jon Kohler <jon@nutanix.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang
	<jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend
	<john.fastabend@gmail.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next] tun: use xdp_get_frame_len()
Thread-Topic: [PATCH net-next] tun: use xdp_get_frame_len()
Thread-Index:
 AQHbv2eEW0uswKQU00yY881fwUmSW7PHpieAgABkjwCAALEOAIAADRCAgAACCwCAAAtLgIAABgSA
Date: Thu, 8 May 2025 15:26:07 +0000
Message-ID: <70BE9E9A-7BD2-4B79-B3A0-E32BA25D4992@nutanix.com>
References: <20250507161912.3271227-1-jon@nutanix.com>
 <681bc8f326126_20e9e6294b1@willemb.c.googlers.com.notmuch>
 <1DDEC6DE-C54A-4267-8F99-462552B41786@nutanix.com>
 <681cb1d4cb20_2574d529466@willemb.c.googlers.com.notmuch>
 <962b227f-9673-4050-90b2-334850087487@kernel.org>
 <7C311781-F3BA-4AEB-BD17-892A88192016@nutanix.com>
 <2508ea8d-b7e3-49dc-b110-7eba1e4ece4d@kernel.org>
In-Reply-To: <2508ea8d-b7e3-49dc-b110-7eba1e4ece4d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.400.131.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR02MB10287:EE_|SJ0PR02MB8657:EE_
x-ms-office365-filtering-correlation-id: 1780f2b1-b62f-49f1-f558-08dd8e44a7b5
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QlN4bUNvbk85cnloVm1xbldlNmd6ZXJRVUxKbHRTb2t1cFJpZk1Cb28yRU4r?=
 =?utf-8?B?R1poSktWc21UUGltcUsvejB4dWdFZ3dLOGZvMHozMnY2MmhjVS9Od2lGY0lD?=
 =?utf-8?B?UnF4ZWRXOG5ETUpDbStSckxlM1V3VTJqTG94UnEyUDlUMGw5SlRQbGIwalk3?=
 =?utf-8?B?ak1lSTVVNzlwOWJaK1dyK0wwWWdZbVV1cUlrcnRMbkVtYzh4SkJxOHpwVFY2?=
 =?utf-8?B?SXZ1WFhScmhodXhWRmQrbE8yUmxINktwUFpkalVzWXFqR3QwblJWTWFHRENs?=
 =?utf-8?B?Z2FXKzI5a3BPWEhhWmtaUzYvWEdLZ0JFUnI2SzJ2VGkwem5CVE1QejVNZVpK?=
 =?utf-8?B?bXVJdndqZk8wU0xMSEI3SFBLWmUrZ2pYZllEd2Q1ZU5Telk1TWpxMm10YnlW?=
 =?utf-8?B?WTljdzRZMUI5NXlqRTNkQ0l6VlJSR1ZqdU1hWTR4RTd2dUxxZ1Z5MGJFNTBS?=
 =?utf-8?B?SnNZLzM5SVdtaEpoaFdDMzRwUkdLbUt2NFdLTmY2Z09vVWVJeWppVVl2M0Vn?=
 =?utf-8?B?S1pzSnF4ZUlqUmwxVkg1MkppWGQ4WGtzZGF1WjBZdThJUUFLaVg2eE5uTXlD?=
 =?utf-8?B?OFF0M0I3WWFLYUVsK2wrL2hVR3NCZ1N6S2R2N0hxby9pS2JhVmcwU0k3dVJW?=
 =?utf-8?B?RW12YVhvaTRnWkxJZHJRSGNvMUF0QkNobVNmUEFnRUNRcWZ5MWphRzMzeWdo?=
 =?utf-8?B?N2xiVDBScVpaZ25qelRZeFhxMlNlSC9zaGFzOXhaVlVNdFRhK0dRZnhIMExw?=
 =?utf-8?B?T0wyOWZCUW41alpyZ1VueUYwaXJKdi9jUTREUVlGeklwSWxTcTVLSjFoVnVk?=
 =?utf-8?B?OFBSRkFyUElhOHFrYVM5cDNnemNVeGFQRENrM0pmMVl1Q3JVNHJxb3N5M0Jt?=
 =?utf-8?B?R3poZURTcFkrQ2RIa3BGdUZXanFlU2VSVndnYW8yb3pLUHd5QU15L2dUWFF5?=
 =?utf-8?B?VXhXSUh5WHd5UkhqVjVXbk5tb2VUOHpiRUMySnkxb0pPelBwUGdlc0lyYkdR?=
 =?utf-8?B?V1pHSnVUemZSUFZRdnNqQ3dHQ2Q2RnRlK1FMWG85RjBHUHBLWGJHUlNzc29B?=
 =?utf-8?B?TE9Ra0Rpd3dWZG9TQmdtTnF2dU96UlI2QjhKdjVrZEVNdnNzeGM0c2pUT1VV?=
 =?utf-8?B?aERBaElmM0taOFdWQWphY3RyK0VVMFljRW5jenl5T1ZadDVhYzYyWHN1ajFI?=
 =?utf-8?B?cjBvSHJkNkJYaUl5MHFxVFFVZUtWUmdJRUNpczl0NVFPNmVQL0pjNDd4emRl?=
 =?utf-8?B?RHNIcm5aUkxjQ1ZjOHFZWXA3NkNQK1F6ak5jYjB3SjBxalB4UmR2MnVENnRO?=
 =?utf-8?B?TFVlZjhReEkvQVpoanBhN3l2MG5PSHo5T1FONWZ0Q1JGUDRZL1gxKzZOVXhi?=
 =?utf-8?B?Vm56WkJlQkRTMnUrdkk5ZXQxTjRWWUxSL3psMk9KOFRjVXQ5d1UvODdPNUx4?=
 =?utf-8?B?ZHNLZ0U1T2pqcjZZV2JkenJTdXk5Tlo5U094UlhTZGFMdlNXSngzUGxKNnA0?=
 =?utf-8?B?akVCSDNPT1dNVFBTczZmTU9va2dOWU1OWFJ0Y3RaWFpFTU1jT1VWUklhRytu?=
 =?utf-8?B?b0xpbndwRHo0OTFKUkVtOVlDT1VtZ0s1OE1OandWT2twVk50UzYrakt4NVBB?=
 =?utf-8?B?cDVST3hCcGxGMkFlN21NYXN3N2lRc1ZPMUZOSmxIYTRXM0t1K2x6VnV5dlFv?=
 =?utf-8?B?TXlBZ1ZSZzRyemNydUV5aEdSVG9uMEIvVnd3VU5uZnhpUmNMbG9VVWNnSmNt?=
 =?utf-8?B?RWY3bGMzWml6VUhMQjQ0ajFTZE84WHJXVW9VeVZIaWlrU25nSGgwcUE3US9J?=
 =?utf-8?B?SUJwYnMrblZBMmw0cHRpb21CVEdXdjQwTGVCNWFzMUo5cGNzLzJlSGZTTFdx?=
 =?utf-8?B?QTkxNDJMaU5FWllGazBraTcwbU80VE9YQS9TWDl3aHE1WkdPRXFtZVhJRmRX?=
 =?utf-8?Q?AYjzAHyrIW8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TmZFVHlUY2ZUWE1SajQzYmFtM3hieGNWYjZRS2F3VXZyZUk5bVZTYnhSSU5Z?=
 =?utf-8?B?WkprL1IwYS85cEVxYUtOd2RCS2lSZ29BNjRnNFk3UldwNFo5TG1TcUNwMmFJ?=
 =?utf-8?B?Q3RRS3dFWU5lbHEvc3FMbm16eHZpb2xVeXF1emxvMEN1TWVBSlRmTk45cDl3?=
 =?utf-8?B?QmhwNlBVM0I1em96OGEvMFBORzhzRTViN0h5ZFZmRTdxdnFRbXJ6N2s0ekNV?=
 =?utf-8?B?UEFXR2puc2xVMmZWbDNCTFF2ait6U2xEVkxlQVpDRXh1ZWFQV2lKZm5EeEJH?=
 =?utf-8?B?d2tpamE5ZFZ3NVJFclYwMEp3d0IzbE10MXpQMWE4eHJjZExmVVdvdUwyTGhy?=
 =?utf-8?B?alFKTGoyQ3BpdU94WnFlL1l4aEJOOFBYZlJxK3JPUDJIYTgyc01XeE04enQ5?=
 =?utf-8?B?WE5uSHJPVDA0R2NSajdWZlhaK3pSamYzRFJ5SHc2bjQ1cHIxMzlkMFdQY3da?=
 =?utf-8?B?Mmd2Wm51UXdNK29vZkhYZStTYW9aNkZuVUhxREp2WUZJZzFnUllTa0RUNkZH?=
 =?utf-8?B?REI2c2FrVFVJRXVoWE9jL09vNmdTdkFrSXlFUkdQcnFFMEE5UHBzZG5oaDVG?=
 =?utf-8?B?ZHhMek00endvcG5ueHhxTC9wWEtDTXZ2RUgvblhLYnVlZmE5N3AvTC9SQlNF?=
 =?utf-8?B?Q2dXSEt0NHcwR2drUEwrMFFueUIxRkp4dlZtT3phM1NFSVBURTRTSFJOam1Q?=
 =?utf-8?B?ckZaSlZZNUl2SUVMbllqeGxBODhwUlBhbU1mVk5mRTJaalROL1FTYmlOdlFF?=
 =?utf-8?B?ZzZOVHU2SkkxNUxvTnhsQVdyajFaZlFoQWxCTkhRVmErUmVPcW1SR00wYlVr?=
 =?utf-8?B?RUQrT2VCeDd3dzYxRitWVy9YbkE5aThSTVRST0VaYXNMVTZDditya2c2MDBV?=
 =?utf-8?B?NzhBN1JVVDVHV08vVXpubEthWlFxM3lnd2ZCTG9qdktiZmtmVlRMQmNGelVL?=
 =?utf-8?B?TklGZXdqNUxCbXZtMTlRd213YS9UMjRmeWk3NkFHWEY0bXRVd3ZrRTVZNzd0?=
 =?utf-8?B?bGhLTis2VGJPekprOTJwaEpCZUp0d2U5Ty8xYVp2aVJ5cWQweWZqZzZwenJM?=
 =?utf-8?B?UHlqcFMvZU81R2xYUndiaW5FTmpzYmMrdWE5Sy9OdnZuUytTZnRhSDhlMC9C?=
 =?utf-8?B?SitFRnN2S3dFWWRSN3Z2OTIvZHl3RndteGUwbVBvWklUbmcrcXRkbklVa2Nq?=
 =?utf-8?B?akpGUy9hZ0VLNFJrRnYxSlVTYkNUWUtWdHUvZG9MQ3BxVGhTTUF0aXBrYWkz?=
 =?utf-8?B?RXZ5clV4T1U3RklMaHRFcnhmTTdGd1RpT3dLVFY5bDNDazllVy9TcVp5Zkw4?=
 =?utf-8?B?bkpkdHk4MEw1bldHdW4yemoxS3hzdmRDa0dWRXhhemczbUFUS1Q0Qy95M3k1?=
 =?utf-8?B?Qy82LzBXTzBSNmJwSlJuKzV0M0hLNHhqOTZqZUlGVnZtcW1xNS9PaWx3T3ZH?=
 =?utf-8?B?TTJNVDBkdXdBUTVMU0hxbDdGR2FMd2M5RVV1K1ZNOHd4M1RtMDFteklTR2ZT?=
 =?utf-8?B?NUhHcTFoZzJ3RWVZSEplbWVseUJmQ0pOSXFJWmpvUnB0YldNYWF6QzJmZHZV?=
 =?utf-8?B?K2V3akNYR1BVRmFDR3VkUTVTRzR0cTg5QTVFZWJ1V25DTVlJeGdrMHN5Tzhl?=
 =?utf-8?B?c0M1NmttbzBWekx5WE9waTdmdnpjU2JISGxmemV5UURYdThZQzd0MnZkV1c3?=
 =?utf-8?B?dFM3WmU5Z1dQUVMreU1DbzZ4UHQ1NFE0WWpRdGUzNDdvUXh5VDAvdUtlUDI2?=
 =?utf-8?B?Ry9zQmwrckR2Y1FUZFl5SlpvbHZoenpKWWFnWUhvSXFFMnZLak10RWlRK2J4?=
 =?utf-8?B?N0hnZy9BTjhmQU9BNHpGdzZvZVNWR1dyOWVzbWxFZ2RURlJmZzFjL2h3S2Ja?=
 =?utf-8?B?eHBnQnJxUVJSRXlHUDRoaHl0SE1xOHZGbkNQbU93Sll4TFZCdGRqOWpHblNU?=
 =?utf-8?B?RHR1VVFqQUlMU015cE1NV0tqUndETEpCNUdNUXlTWHcwdmJOSnZsNWk3WTl0?=
 =?utf-8?B?N09oVnR4M3FDeW9mT3d0clpxY2tIdUJBQkl1SGgrUUtDYmE1d2NvTjBtcklR?=
 =?utf-8?B?Z1pMWVNQckNRWjRXdURXb1dMSndMWVNkL21wMld4c21ybTFEakZHY0h3QVZ6?=
 =?utf-8?B?SFYwM2RsVlpHUnVPZmNuZGFCZ29SQ2ZUS1NrMlB3VTNESjNybGpmTWdEZkda?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8935DD398AA814381E8377270C7BE9C@namprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1780f2b1-b62f-49f1-f558-08dd8e44a7b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 15:26:07.8938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LzXas7V2zzuuBaU49LLw7p1yAO/0MugSbp8U4bN8RwElFI4NhgAcmzzG8O9Yi0JcjkYDOnBUfVZQ4rSOk+dCktRECGGDeYlKQ7kHfZu9awc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8657
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDEzMiBTYWx0ZWRfX57LIja9YEtH6 /OA6DpFsAUIMzg0BERn+aJ5ML/Q9vlkUJX+dVMPiCygulpkhMKa8DK+8pfJpx5J6VZdjOfKFVqP JSdp0EBLyXE3mTfv8HEAZPeh/cUXVloRcp0Gkolg9aZNIE0G9vyJfoPEUAMrOwQOLYiS8myQHeN
 wOQnn6t+Mm5aP/90nXxfC3EAfJTir016/JL0Znu8hE6qLpoSrt02ry2tjFuxH2eLkSvHfL4oDZ8 m8YBiGElH4gibvPaRGUQN9c8WZuDhfZwuxt3LD25wSszFvdqoTsif2J5hSODww2pJ9BcWzke8D/ N3VtJGmBPuYf26vJWEviwrl6JygPrK/e98mRC2G8mFQSjEQNy3VCz9vJSNG54BuLjDn+nQGtJcM
 rbVajZlfMMYdhAK2kOw2GW6Wgr2sNt7VXdJCtOl74rJTaRUhQ+W0Al5/eWqzA9kvWhN8KLvr
X-Proofpoint-GUID: ejgsM98qVMJbA93P7sYCghPoGyHuIKNI
X-Authority-Analysis: v=2.4 cv=NMHV+16g c=1 sm=1 tr=0 ts=681ccd17 cx=c_pps a=OYTBATO8h6EMnG+Ds1NGug==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=uXwBh6sXZI2_TlpSTxMA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: ejgsM98qVMJbA93P7sYCghPoGyHuIKNI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

DQoNCj4gT24gTWF5IDgsIDIwMjUsIGF0IDExOjA04oCvQU0sIEplc3BlciBEYW5nYWFyZCBCcm91
ZXIgPGhhd2tAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiANCj4gT24gMDgvMDUvMjAyNSAxNi4y
NCwgSm9uIEtvaGxlciB3cm90ZToNCj4+PiBPbiBNYXkgOCwgMjAyNSwgYXQgMTA6MTbigK9BTSwg
SmVzcGVyIERhbmdhYXJkIEJyb3VlciA8aGF3a0BrZXJuZWwub3JnPiB3cm90ZToNCj4+PiANCj4g
Wy4uLl0NCj4+PiANCj4+PiBBRkFJQ1IgdGhlcmUgaXMgYWxzbyBzb21lIGR1YWwgcGFja2V0IGhh
bmRsaW5nIGNvZGUgcGF0aCBmb3IgWERQIGluDQo+Pj4gdmhvc3RfbmV0L3R1bi4gIEknbSBhbHNv
IHdpbGxpbmcgdG8gdGFrZSB0aGUgcGFwZXItY3V0LCBmb3IgY2xlYW5pbmcNCj4+PiB0aGF0IHVw
Lg0KPj4+IA0KPj4+IC0tSmVzcGVyDQo+PiBXaGVuIHlvdSBzYXkgZHVhbCBwYWNrZXQgaGFuZGxp
bmcsIHdoYXQgYXJlIHlvdSByZWZlcnJpbmcgdG8gc3BlY2lmaWNhbGx5Pw0KPiANCj4gVGhlIGlt
cG9ydGFudCBwYXJ0IG9mIHRoZSBzZW50ZW5jZSB3YXMgKmNvZGUgcGF0aCosIGFzIGluIG11bHRp
cGxlIGNvZGUgcGF0aCBmb3IgcGFja2V0cy4NCg0KQWggcmlnaHQsIHNvcnJ5IGNvZmZlZSBoYWRu
4oCZdCBraWNrZWQgaW4sIGFwb2xvZ2llcyBmb3IgdGhlIHRyaWNrZXJ5IQ0KDQo+IA0KPiBZb3Ug
dHJpY2tlZCBtZSBpbnRvIGxvb2tpbmcgdXAgdGhlIGNvZGUgZm9yIHlvdS4uLg0KPiANCj4gSXQg
d2FzIGluIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB3aGVyZSBmdW5jdGlvbiByZWNlaXZlX2J1
ZigpIGNhbGxzWzFdDQo+IHRocmVlIGRpZmZlcmVudCBmdW5jdGlvbnMgYmFzZWQgb24gZGlmZmVy
ZW50IGNoZWNrcy4gIFNvbWUgY2FzZXMgc3VwcG9ydA0KPiBYRFAgYW5kIG90aGVycyBkb24ndC4g
IEkgdGhvdWdoIHlvdSB0YWxrZWQgYWJvdXQgdGhpcyBpbiBhbm90aGVyIHRocmVhZD8NCg0KSSB3
YXMgdGFsa2luZyBhYm91dCB0aGUgdmhvc3QvbmV0IHNpZGUsIG5vdCB0aGUgdmlydGlvX25ldCBz
aWRlLiBJbiB2aG9zdCBuZXQuYw0KdGhlcmUgaXMgcm91Z2hseSB0aGUgc2FtZSB0aGluZyB0aG91
Z2gsIHdoZXJlIDwgUEFHRV9TSVpFIHVzZXMgeGRwX2J1ZmYNCmFzIGEgbWVhbnMtdG8tYW4tZW5k
IGZvciBiYXRjaGluZywgZWl0aGVyIHRvIGJlIGRpc3BhdGNoZWQgYXMgcHJvcGVyIFhEUA0Kb3Ig
anVzdCBmbGlwcGluZyB0byBTS0IgYW5kIHRoZSB0cmFkaXRpb25hbCBuZXQgc3RhY2suDQoNCkFu
eXRoaW5nIGFib3ZlIFBBR0VfU0laRSB0YWtlcyBhIHdpbGRseSBkaWZmZXJlbnQsIG5vbi1iYXRj
aGVkIHBhdGguIFRoYXTigJlzDQp3aGF0IEnigJltIGFjdGl2ZWx5IHdvcmtpbmcgdGhyb3VnaCBu
b3cuDQoNClRoZSBzZXJpZXMgSeKAmW0gd29ya2luZyBvbiBhaW1zIHRvIHVuaWZ5IHRoYXQgaGFu
ZGxpbmcgYWdhaW4sIGJ1dCB3aWxsIHNlZSBpZiBpdA0KYmxvd3MgdXAgaW4gbXkgZmFjZSBvciBu
b3QuDQoNCj4gDQo+IC0tSmVzcGVyDQo+IA0KPiBbMV0gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5j
b20vbGludXgvdjYuMTUtcmM1L3NvdXJjZS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMjTDI1NzAt
TDI1NzMNCj4gDQo+IA0KDQo=

