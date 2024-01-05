Return-Path: <bpf+bounces-19130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D3B8258C1
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 17:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B40283CE6
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 16:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4179331A71;
	Fri,  5 Jan 2024 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="eHeK2RNx"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042E33174D
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355089.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 405BQYA5032530;
	Fri, 5 Jan 2024 16:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	DKIM202306; bh=Mxu2B+niO2cny0RfWBQ1zTIeWQfjUE/YOGLoKNDrnj4=; b=e
	HeK2RNxdxJuzGASGwb3BxsUnS3XYmTR/y8D/6mxu2DnZ2JN0IK/eb1bBTFTxzMvu
	vArd2FBxgMpXtJm5C+F/wLn91ba3a3yJt4YnBagAfDEWEAirj3eVJd1Ulcv9OJcH
	rjhVwO2bfOswAkl+rl75iKjJEiA13VxkHlnc+6uGBCR4dfePworDLZIx/ty5jhDl
	wHo+DyYPLzfZOfM3igD3tIi7T5Zl1+ggdGyVPAxYIQeZkK8gI1jgeghF5MBIHUrt
	g2EiQNAetuiVAf7octo3oNJ4mO03X3HDNrA2FuntQ9uZDrsiOMWzDgvpuWTS89KD
	eDlxDdOQv0nUeidUWUHdg==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2040.outbound.protection.outlook.com [104.47.110.40])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3ve97x9bcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 16:58:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1VlyYc6TSQ7JQ63CGrwVtpr/mbCojgP9OeW3QnNBiZ1J2aX1wm2iLbXAKm+Ofh8EahThNpyr/FkC/XAWxaMM7nNm7Wl4UPa0WqCYK08GD85P9W4gEEbvMLyRnqU8F9HhHn5JlYUcCXZrKyeKYi64VXsw7QesrUz6BJTdIzpnIG1/cIfIxQGvUgnmmYIFLyLjeSwav9CoPgwWZvrlluBG1E4vcRU3Z/U5FneS6/d2Ndvamih6LwsN08ClsUD+FXOVoO5Gx7aANBi8vLzVciiqsAoAiPLerPm7pJ4t0aQCNKMqWjEm+hkFqdXpL8lz9wOu5c7LZHxWu3JZKxq08c39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mxu2B+niO2cny0RfWBQ1zTIeWQfjUE/YOGLoKNDrnj4=;
 b=N0mlO+FEwxsXaGUB5y9/m3SleidL5eTTzz01sR+PcxOTkv3wUZT8WsBIMzIOXnAXpTEMBrKYECf4ZTj54W1uNuWPPOBRHFaFoe3/F0IHpLJ71JSxHAAg3ToWOYuQCTH+4jxXH0R8f3/tvaGZto41AL0Hn26uvGe6whg1LMkmTS58TOozgXEhJKHUmsgr2XZr9vPzU1X2gKvwI9I3D3H0ViMBvBKli7puWtiZsAW05dsY3wHxKLwv3JIFED6rCtbXfdw0WonhVDDhy8POTG2doBJ09mMRPpLzeejq1xzFsQqZdJ1lfzGDwO1GmcnX+b4blehvXLTWIHkhqfKs7+7HBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com (2603:1096:101:66::5)
 by TYSPR03MB7370.apcprd03.prod.outlook.com (2603:1096:400:414::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 16:58:38 +0000
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::c0d5:21be:6c82:e5f6]) by SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::c0d5:21be:6c82:e5f6%6]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 16:58:38 +0000
From: Maxwell Bland <mbland@motorola.com>
To: "Jin, Di" <di_jin@brown.edu>,
        Alexei Starovoitov
	<alexei.starovoitov@gmail.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "v.atlidakis@gmail.com"
	<v.atlidakis@gmail.com>,
        "vpk@cs.brown.edu" <vpk@cs.brown.edu>,
        Andrew
 Wheeler <awheeler@motorola.com>,
        =?utf-8?B?U2FtbXkgQlMyIFF1ZSB8IOmYmeaWjOeUnw==?= <quebs2@motorola.com>
Subject: RE: [External] Fwd: BPF-NX+CFI is a good upstreaming candidate
Thread-Topic: [External] Fwd: BPF-NX+CFI is a good upstreaming candidate
Thread-Index: AQHaPpWonDW/eHWeP0q2GVAamFCjbrDIvSYAgAAkCQCAAZfpAIAA9E+Q
Date: Fri, 5 Jan 2024 16:58:38 +0000
Message-ID: 
 <SEZPR03MB6786BF42E7105E8B55C5788DB4662@SEZPR03MB6786.apcprd03.prod.outlook.com>
References: 
 <TYZPR03MB679243A8E626CC796CB7BDBDB461A@TYZPR03MB6792.apcprd03.prod.outlook.com>
 <CAKOkDnNAQSrWxsJBrcLV7ReaQkX_BHX+EAn69e0cpe9b=FAsUg@mail.gmail.com>
 <CAKOkDnPnNE=MNP-1_8=T9vw6Ox80OAJmKonzpDO4abW8Dz9JwA@mail.gmail.com>
 <SEZPR03MB67865F9167DABCA16AA6811BB4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
 <CAADnVQJCxFt2R=fbqx1T_03UioAsBO4UXYGh58kJaYHDpMHyxw@mail.gmail.com>
 <CAKOkDnPZ5SKYOQhE646Se5oYCi7Rc3ubUTnrE+-aXiViTsA1jQ@mail.gmail.com>
In-Reply-To: 
 <CAKOkDnPZ5SKYOQhE646Se5oYCi7Rc3ubUTnrE+-aXiViTsA1jQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6786:EE_|TYSPR03MB7370:EE_
x-ms-office365-filtering-correlation-id: 2b5971a5-0e0a-4150-9a86-08dc0e0f9046
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 IFplwqrecAVT9CP43PFCY9cZidsJ1fX1K3Looo3t1Uozb0vI2AXuypmELb+pfHWmR8j+YGyXZ65XxT43KwvWTXj//57dcR56rMgIkmG1MK41XtS59a0a3vOKYJaPAryMq03L3jVM3MXZGqK0x/SzUeTAxcA81+nNyzylsE6s52UhloyE0pCIUsfM0ioIt8DgL9ae1NsuuViQ+SekNLxF/Te25TvVCM9H72aIMsnVXbRna7zlEjXsrHrLYZ4DxgfOcW+kI+VOSu1G5p0CUYRlwEmRSE/aSQ40ND1b3Hxu9fm4XVcSvN+2KL4+GsGySG9xb5qmCUywWOoj/8Z28CuEn+uIAKiR5yJ+II0eefar8l1y0tNcLCBWtm/+4uZ2hOgz4QG5siKgjB3sV/W0KSotFsCw9DmqgiMfzM4LFTkTzFsk9Yrzp800tuYZY8+XMM0TPigzxq+ymnU7dD7w6CNxOCBk1eTgi5wT3qZ9dFnmASZig6lU8ISQZTaWDZI1rQiWKfOFnj8cpCOjdVHMNfkDxzxkb9jBOf/YEaG++QXrlZhA554KHVEbWrdQwfch4h8fByZrGZwcUmekSgiUQb1iBz1URE93j9vq/OB2SOkV3mmr26XZxeOjULeCrHpWPFt3eYfJGco1dSGAVQ2x77z1hZv/V+5YzWpWU7EtyiXQ4Kbg1zWp/Q0YJNlJJPXxYWgNJlWHrAzSxF7AxECzT7by5g==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(451199024)(64100799003)(186009)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(122000001)(38100700002)(82960400001)(9686003)(86362001)(6506007)(71200400001)(55016003)(53546011)(7696005)(107886003)(26005)(5660300002)(2906002)(33656002)(478600001)(52536014)(110136005)(54906003)(8676002)(316002)(83380400001)(8936002)(4326008)(38070700009)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SkdXbi9Sa3M5b010NTUzbERvUFUvdGk3cGtkc0NVT0hmMUhXTU9ZWm9GbmFw?=
 =?utf-8?B?Um9vUmsxSkgreHdLSGZkblQ0ekpVWkpUWHNaTFFGTWZCaUFkajB4UEVzRXJ1?=
 =?utf-8?B?djFQVnFNdkNEQkVNeVZ1cDhvTHVJN3F0S3BTZ1B0L1pTTDEzblo1OThlMFhP?=
 =?utf-8?B?eGduOFRMM0ZTUmE5UnNUZGU2T3p2WHN6Vmw3L1R2VHpGRGx4RWpobEpNVjlU?=
 =?utf-8?B?M1A2RjMrWm1Hd3NjaVhHNHlmTUdpN2J6cXhYR3Y2QjFHYzdFRFFNTzRwWVFt?=
 =?utf-8?B?d012Z2p1UW4xSnhYQlY1Y1JCNysrSFRzUlErZWxZemdKSmpCRmh2WjA1bjV1?=
 =?utf-8?B?QnAwYzMralZoZVdLYmhnZUxaUW1rNFZSVjBsVVJDV0ZiQUpGUmpkNUNUWGp2?=
 =?utf-8?B?K2hvVC9aNDRLN05zQWNtSk5YK2M5RE9leGhGbDRVWUpoWG5kWExHalYwTFI4?=
 =?utf-8?B?RVNxVjdZbmZ3WTJIY09pYloxVWduR3R6ZTF2VldDanJ0OVhNQTdhWDFkVERz?=
 =?utf-8?B?Z0lDaXlMbGdtVFdFdHJVOW1ZemxacFJwTGFFOWVCTVlEV2w3R3V3d2wwU2xX?=
 =?utf-8?B?NG1SeWQ5enkyVnZkdmZPb1FidG1ueXdsdTM5OG5zUEdZcHNralc4VlhaTTNG?=
 =?utf-8?B?eDloa2JRenEzZVI0SHd3bXhjOEJIRklIcTBvMGRoUmt1aGx2cnZDWXlKSVYy?=
 =?utf-8?B?TXdZVEE3cWJaczQxdnBGcmdJWUpTcXZCNUNKTldkSCtXdUl6cnAzVnB5eWNu?=
 =?utf-8?B?QlBBRCszSDFOei9FTUhHeE5EQkh3RXRKb2dEaXFSMnNseW9vNWxybXhjeGhN?=
 =?utf-8?B?cmVmM29uOVJhWnZBS0pWYU95Y1NtcHBOMVpsR2FKVi9sUGs5OFgvQzU0NUZ6?=
 =?utf-8?B?RmpHYWI4emMvRW5hcUVFTVVWOThVMU1weWE4V2daTEhaenN5cDRpMWdETHMz?=
 =?utf-8?B?clVLOG1Qb3k4TG05UFZSSm9OMjdLdW8ySXU4K1U1c2NrSDU0aFRZUEtsNlhp?=
 =?utf-8?B?cHdwUWpTZmR4ZmpiTnE0dWtZeW1mOGlITDE5WU9NTFRVWEZnb0VVQUtkUWhy?=
 =?utf-8?B?Ylc0aU5uVytpRWhJM2xrNTNNLzdXdHJ5STE0c0ZPSXFwNlFVR2p4dXV1MGtJ?=
 =?utf-8?B?VXhLdjBVd0dWcnhycDJSa1U0emFkQkduQllBUUNZV3owaThqWjVDOU93V0NU?=
 =?utf-8?B?cUNXR2hGQnFQWHRNOEo4N1ZsZXd6SHZaYTVSUW5qRklsOXhqNkNmbGw1Q0Ra?=
 =?utf-8?B?RXEvSUZlcVdIZGw3cUNPVGtOUnNsNGpmNDMyWFJiYVB4ZXFFSnJtdTFiQ1Nj?=
 =?utf-8?B?N3dUZUhqMThoS0pNSm1HM3JERWlvblRLVHJQdVhYaW5rN0hnT3NJSHFnODBv?=
 =?utf-8?B?azBLVU1FM3hYV0VkTkJyNCthdERoVkhjaktPTW93ekxRV0FjTjJVSWNVU3lT?=
 =?utf-8?B?WlgwaEYrRzl1Z3dOSGFUT29zYldHWlpERFVKS0dnaWN6L3lHeWlBeGR6QmxT?=
 =?utf-8?B?MTFrR1ZmWlpsMXI1ZjdxOWoxcFF2SjZRVlpydy9MN3JWOTFBREYrbVYwQjV6?=
 =?utf-8?B?QXlFcWJnekpkZGR1dE9mTlVHRmJvc1BLR2Q2SWJBbkY1R2o3QkJ0VWx0WVJF?=
 =?utf-8?B?T0pvRFMvRUp2ZGhMRVo5Y0E2L2tFRWxxRytRZFJOMEVycXEwOHZ6Ujc2eDUx?=
 =?utf-8?B?QkR6enRxVTcvNUZmdzJTRWpoZzRjWXZWSVdXbWhseXNwMWZ6WFVCTzNzL1Ax?=
 =?utf-8?B?WTZJTDM5ZUFLbXordUJZekgvUVFYU3JDTFpWdUN1akFUS3ZVenFha1p6NFpO?=
 =?utf-8?B?TXBWRWllWmFPbmpKem5WSHE3OFNnUXEycE5oUEZIa05VeUMrNTRxdVJNL0V3?=
 =?utf-8?B?Z2tqWGE1a0ZkUUxXL1d0b0U3WEFYaVhTMmwveVI2ejdaQVQrYXNsanJ5OSsw?=
 =?utf-8?B?RkUwanpPU05VRmVOR3I5ZUpJWWhCWWJUR0w0TkNqMjNzYWlqdFBOSkVZdmxK?=
 =?utf-8?B?Q01rUXJhcjdGZWROaHQwQjFxeGY4VTZ2d0IwNUxRSWs4SjM5dmdvd0JpS21E?=
 =?utf-8?B?YTVIOW1lU0JrUURDWnRpdzc4Wks1ZW53bVpkQ0hQZWppOHBzdVVNcWZEZnlR?=
 =?utf-8?Q?KEZY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: motorola.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6786.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5971a5-0e0a-4150-9a86-08dc0e0f9046
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 16:58:38.7092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DnC6xzQAe1Ik2sT/Pvn9cWAMrRbxKKCv7klNldmBGysMkf58v5gb5zAt/dMCecFm6gp2ZkHIq3BpwlkrqGEWCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7370
X-Proofpoint-GUID: Nk6VO9BW2XauteDi1T9n_1a_rozBxEJP
X-Proofpoint-ORIG-GUID: Nk6VO9BW2XauteDi1T9n_1a_rozBxEJP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401050140

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKaW4sIERpIDxkaV9qaW5AYnJv
d24uZWR1Pg0KPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSA0LCAyMDI0IDg6MDIgUE0NCj4gVG86
IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4NCj4gQ2M6
IE1heHdlbGwgQmxhbmQgPG1ibGFuZEBtb3Rvcm9sYS5jb20+OyBicGZAdmdlci5rZXJuZWwub3Jn
Ow0KPiB2LmF0bGlkYWtpc0BnbWFpbC5jb207IHZwa0Bjcy5icm93bi5lZHU7IEFuZHJldyBXaGVl
bGVyDQo+IDxhd2hlZWxlckBtb3Rvcm9sYS5jb20+OyBTYW1teSBCUzIgUXVlIHwg6ZiZ5paM55Sf
DQo+IDxxdWViczJAbW90b3JvbGEuY29tPg0KPiBTdWJqZWN0OiBSZTogW0V4dGVybmFsXSBGd2Q6
IEJQRi1OWCtDRkkgaXMgYSBnb29kIHVwc3RyZWFtaW5nIGNhbmRpZGF0ZQ0KPiANCj4gRGVhciBB
bGV4ZWkgYW5kIHRoZSByZXN0IG9mIHRoZSBjb21tdW5pdHksDQo+IA0KPiBJIGRvIHdhbnQgdG8g
bWFrZSBhIG5vdGUgYWJvdXQgdGhlIGNvbmNlcHQgb2YgdGhlIGludGVycHJldGVyIGJlaW5nICJs
ZXNzDQo+IHNlY3VyZSIuDQo+IA0KPiBGaXJzdGx5IHRoZSBpbnRlcnByZXRlciBpcyBub3QgY29u
dHJpYnV0aW5nIHRoYXQgbXVjaCB0byB0aGUgZXhwbG9pdGF0aW9uIG9mDQo+IFNwZWN0cmUuIFdo
aWxlIEdvb2dsZSBQcm9qZWN0IFplcm8gZGlkIHNheSB3aXRob3V0IHRoZSBpbnRlcnByZXRlciBi
dWlsZGluZw0KPiB0aGUgc3BlY2lmaWMgZXhwbG9pdCB0aGV5IGhhZCBmb3IgU3BlY3RyZSBWMiBz
ZWVtcyAiYW5ub3lpbmciLCB0aGF0IGlzIGFsbCB0aGVyZQ0KPiBpcyB0byBpdCwgdGhlIHNlY3Vy
aXR5IGJlbmVmaXQgb2YgcmVtb3ZpbmcgdGhlIGludGVycHJldGVyIGlzIG1vcmUgbGlrZSBhbg0K
PiBhbm5veWFuY2UgaW5zdGVhZCBvZiBhIHJvYWRibG9jay4gSXQgaXMgcXVpdGUgbGlrZWx5IHRo
YXQgYXV0b21hdGVkIHRvb2xzIGNhbg0KPiBmaW5kIGdhZGdldHMgdGhhdCBjYW4gZG8gdGhlIGpv
YnMgd2l0aG91dCB0b28gbXVjaCB0cm91YmxlLCB0aGUgb25seQ0KPiBhbm5veWluZyBiaXQgd291
bGQgYmUgdGhlIGF0dGFja2VycyB3b3VsZCBoYXZlIHRvIGZpbmQgZGlmZmVyZW50IGdhZGdldHMg
Zm9yDQo+IGRpZmZlcmVudGx5IGJ1aWx0IGtlcm5lbHMuDQo+IA0KPiBHcmFudGVkLCByZW1vdmlu
ZyBhbnkgdW51c2VkIGZ1bmN0aW9uYWxpdHkgY2FuIGJlIGFuIGltcHJvdmVtZW50IGZvciBhDQo+
IHN5c3RlbSdzIHNlY3VyaXR5LCBhbmQgdGhlIG9ic2VydmF0aW9uIHRoYXQgdGhlIGludGVycHJl
dGVyIGNhbiBiZSByZW1vdmVkDQo+IHdpdGhvdXQgdG9vIG11Y2ggcGFpbiB3YXMgcXVpdGUgaW50
ZXJlc3Rpbmcgd2hlbiB0aGUgb3B0aW9uIHdhcw0KPiBpbnRyb2R1Y2VkLiBCdXQgaW4gdGhpcyBz
cGVjaWZpYyBjYXNlLCB0aGUgc2VjdXJpdHkgdHJhZGUtb2ZmIGhlcmUgaXMgYSBiYWxhbmNpbmcN
Cj4gYWN0IGJldHdlZW4gdHdvIGZ1bmN0aW9uYWxpdGllczogSklUZWQgQlBGIGFuZCB0aGUgaW50
ZXJwcmV0ZXIsIHNpbmNlDQo+IHJlbW92aW5nIEJQRiBhbHRvZ2V0aGVyIGlzIHByb2JhYmx5IG5v
dCBhbiBvcHRpb24gaW4gcmVhbGlzdGljIHRlcm1zLiBUaGUNCj4gSklUZWQgQlBGIGhhcyBtb3Jl
IHRoYW4gY29udHJpYnV0ZWQgaXRzIGZhaXIgc2hhcmUgb2YgYXNzaXN0YW5jZSB0byB2YXJpb3Vz
DQo+IGF0dGFja3NbMS0zXSwgaW5jbHVkaW5nIHRoZSBvcmlnaW5hbCBTcGVjdHJlIGF0dGFja3Nb
NF0uIFNvIGRpc2FibGluZyBKSVQgYW5kDQo+IGtlZXBpbmcgdGhlIGludGVycHJldGVyIGluIHBs
YWNlIGlzLCBzZWN1cml0eS13aXNlLCBhbiBldmVuIGJldHRlciBtaXRpZ2F0aW9uLCBpZg0KPiB3
ZSBoYWQgdG8gcmVtb3ZlIG9uZSBvZiB0aGUgdHdvIHBhdGhzLg0KPiANCj4gSSB3b3VsZCBhcmd1
ZSB0aGF0IGtlZXBpbmcgdGhlIGludGVycHJldGVyLCBlc3BlY2lhbGx5IGhhcmRlbmVkIHdpdGgg
ZGVmZW5zZXMNCj4gcHJvcG9zZWQgaW4gRVBGLCBpcyBhdCB0aGUgdmVyeSBsZWFzdCBhIGNvbXBl
dGl0aXZlIG9wdGlvbiBmb3Igc2VjdXJpdHkuIEl0DQo+IGVuYWJsZXMgc3lzdGVtIGFkbWlucyB0
byBkaXNhYmxlIEpJVCBhcyBtaXRpZ2F0aW9uL3ByZXZlbnRpb24gYWdhaW5zdA0KPiBwb3RlbnRp
YWwgcmlzayBmcm9tIHRoZSBKSVRlZCBjb21wb25lbnQgb2YgQlBGICh3aGljaCBpcyBub3cgaW1w
b3NzaWJsZSksDQo+IHdoaWxlIHN0aWxsIGVuam95aW5nIHRoZSBzZWN1cml0eSBlbmhhbmNlbWVu
dCBwcm92aWRlZCBieSBFUEYgZGVmZW5zZXMuDQo+IA0KPiBJZiBJIGNhbiBoYXZlIHlvdXIgYmxl
c3Npbmcgb24gdGhlIHNlY3VyaXR5IHRyYWRlLW9mZiwgSSBjYW4gbW92ZSBmb3J3YXJkIHRvIHRy
eQ0KPiB0byBhZGFwdCB0aGUgcGF0Y2hlcyBmb3Igc3VibWlzc2lvbi4NCj4gDQo+IFJlZ2FyZHMs
DQo+IERpDQo+IA0KPiBbMV0gUmVzaGV0b3ZhLCBFbGVuYSwgRmlsaXBwbyBCb25henppLCBhbmQg
Ti4gQXNva2FuLiAiUmFuZG9taXphdGlvbiBjYW7igJl0DQo+IHN0b3AgQlBGIEpJVCBzcHJheS4i
IEluIE5ldHdvcmsgYW5kIFN5c3RlbSBTZWN1cml0eTogMTF0aCBJbnRlcm5hdGlvbmFsDQo+IENv
bmZlcmVuY2UsIE5TUyAyMDE3LCBIZWxzaW5raSwgRmlubGFuZCwgQXVndXN0IDIx4oCTMjMsIDIw
MTcsIFByb2NlZWRpbmdzIDExLA0KPiBwcC4gMjMzLTI0Ny4gU3ByaW5nZXIgSW50ZXJuYXRpb25h
bCBQdWJsaXNoaW5nLCAyMDE3Lg0KPiBbMl0gTmVsc29uLCBMdWtlLCBKYWNvYiBWYW4gR2VmZmVu
LCBFbWluYSBUb3JsYWssIGFuZCBYaSBXYW5nLg0KPiAiU3BlY2lmaWNhdGlvbiBhbmQgdmVyaWZp
Y2F0aW9uIGluIHRoZSBmaWVsZDogQXBwbHlpbmcgZm9ybWFsIG1ldGhvZHMgdG8ge0JQRn0NCj4g
anVzdC1pbi10aW1lIGNvbXBpbGVycyBpbiB0aGUgTGludXgga2VybmVsLiIgSW4gMTR0aCBVU0VO
SVggU3ltcG9zaXVtIG9uDQo+IE9wZXJhdGluZyBTeXN0ZW1zIERlc2lnbiBhbmQgSW1wbGVtZW50
YXRpb24gKE9TREkgMjApLCBwcC4gNDEtNjEuIDIwMjAuDQo+IFszXSBLaXJ6bmVyLCBPZmVrLCBh
bmQgQWRhbSBNb3JyaXNvbi4gIkFuIGFuYWx5c2lzIG9mIHNwZWN1bGF0aXZlIHR5cGUNCj4gY29u
ZnVzaW9uIHZ1bG5lcmFiaWxpdGllcyBpbiB0aGUgd2lsZC4iIEluIDMwdGggVVNFTklYIFNlY3Vy
aXR5IFN5bXBvc2l1bQ0KPiAoVVNFTklYIFNlY3VyaXR5IDIxKSwgcHAuIDIzOTktMjQxNi4gMjAy
MS4NCj4gWzRdIEtvY2hlciwgUGF1bCwgSmFubiBIb3JuLCBBbmRlcnMgRm9naCwgRGFuaWVsIEdl
bmtpbiwgRGFuaWVsIEdydXNzLA0KPiBXZXJuZXIgSGFhcywgTWlrZSBIYW1idXJnIGV0IGFsLiAi
U3BlY3RyZSBhdHRhY2tzOiBFeHBsb2l0aW5nIHNwZWN1bGF0aXZlDQo+IGV4ZWN1dGlvbi4iIENv
bW11bmljYXRpb25zIG9mIHRoZSBBQ00gNjMsIG5vLiA3ICgyMDIwKToNCj4gOTMtMTAxLg0KDQpB
IGNyaXRpY2FsIHN1YnRleHQgaXMgdGhhdCBtYW55L21vc3Qgc2VjdXJpdHktY29uc2Npb3VzIGJ1
aWxkcyAoR29vZ2xlJ3MgQW5kcm9pZCBHS0ksIGlpcmMpIGhhdmUgSklUIGFsd2F5cyBlbmFibGVk
Lg0KDQpBZnRlciBJIG1hZGUgdGhhdCB0eXBvIHRoYXQgc3dpdGNoZWQgdXAgZW5hYmxlZC9kaXNh
YmxlZCBpbiB0aGUgY2hhaW4geWVzdGVyZGF5LCBBbGV4ZWkgdGhhbmtmdWxseSBub3RlZCAidGhl
IHByZXNlbmNlIG9mIF9hbnlfIGludGVycHJldGVyIGluIHRoZSBrZXJuZWwgdGV4dCBpcyBhIHBy
b2JsZW0gcmVnYXJkbGVzcyBvZiB3aGV0aGVyIEpJVC1pbmcgaXMgZW5hYmxlZCBvciBub3QiLiBK
SVQgaGF2aW5nIHByb2JsZW1zIGRvZXNuJ3QgaW1wbHkgdGhhdCBhbiBpbnRlcnByZXRlciB3aWxs
IG5vdCBoYXZlIGlzc3VlcyBvZiBpdHMgb3duLiBJbnRlcnByZXRlcnMgYnVncyBjYW4gbGVhZCB0
byBtb3JlIHNlY3VyaXR5IHByb2JsZW1zIHJhdGhlciB0aGFuIGZld2VyLCBTcGVjdHJlIG9yIG90
aGVyd2lzZSwgcmVzdWx0aW5nIGluIHRoZSBuZWNlc3NpdHkgb2YgYSBjcml0aWNhbCBnZW5lcmFs
IGNvbW1pdG1lbnQgdG8gbWFpbnRhaW5pbmcgYW5kIHZldHRpbmcgdGhlIGludGVycHJldGVyIHdp
dGhpbiB0aGUga2VybmVsLiBNYWpvciBwbGF5ZXJzIGxpa2UgSW50ZWwgYW5kIEdvb2dsZSBzZWVt
IHRvIGhhdmUgdW5vZmZpY2lhbGx5IGNvbW1pdHRlZCB0byBKSVQgbWFpbnRlbmFuY2UgYW5kIHNl
Y3VyaXR5IGluc3RlYWQuIFRoZXJlIGFyZSBzb21lIGdvb2QgYXJndW1lbnRzIGZvciB0aGlzIG9u
IHRoZSBub24tc2VjdXJpdHkgc2lkZS4NCg0KV2l0aCB0aGUgaW5jbHVzaW9uIG9mIFBldGVyJ3Mg
Q0ZJIHBhdGNoZXMgYW5kIHRoZSBhZGFwdGlvbiBvZiB0aGVzZSB0byBBUk0sIHRoZXJlJ3MgYWxy
ZWFkeSBzdHJvbmcgcHJvZ3Jlc3MgdG93YXJkcyBzZWN1cml0eSBmb3IgQlBGJ3MgSklULiBJZiB0
aGUgbWl4aW5nIGV4ZWN1dGFibGUgY29kZSB3aXRoIGRhdGEgaXNzdWUgZ2V0cyBmaXhlZCB0b28s
IHRoZW4gaXQgd2lsbCBzb29uIGJlY29tZSBwb3NzaWJsZSB0byB0cmVhdCBCUEYgSklUIHByb2dy
YW1zIGxpa2UgYW55IG90aGVyIHBhcnQgb2YgdGhlIC50ZXh0IHNlY3Rpb24sIHdoaWNoIHNlZW1z
IGxpa2UgYSBodWdlIHdpbiwgc2luY2UgQlBGIHRoZW4gZ2V0cyBhbGwgb3IgbWFueSBvZiB0aGUg
ZnJ1aXRzIG9mIHN0YW5kYXJkIC50ZXh0IHNlY3Rpb24gc2VjdXJpdHkuDQoNClJlZ2FyZHMsDQpN
YXh3ZWxsIEJsYW5kDQo=

