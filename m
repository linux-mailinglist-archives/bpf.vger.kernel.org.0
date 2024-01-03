Return-Path: <bpf+bounces-18954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA24823840
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 23:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E711C24434
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 22:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8532B1D684;
	Wed,  3 Jan 2024 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="Kp2FE+0S"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD821DDE6
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355087.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 403GICiU030146;
	Wed, 3 Jan 2024 22:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	DKIM202306; bh=TWJt0NHLE7m4sJeLS2+BV1RFKwx40fbowVV0ZczW+6U=; b=K
	p2FE+0SClfbIiJrYxdk+qeW+an36qz6Szs6S6hRyNBZ6Dq5uiF4VGvtQDYv7pQ4U
	OhDSUv7QzuXV1ak3Y9vYlkmtAJfnurVo2e4+V0lUXRK8vDA8hiti6RDPriZ9aIWF
	cSpbzbH7m/iVMRNIdtHm7m/IXSzwtqkO4t+Z1icjbpURn2ydSblMvEu9QwD5euzY
	af0TnplXj6FC0Erhny9EEtTGW1JwFvj51OovazoSK0TaJ9sOJof1PuLJ/07XPtfx
	Ehsw0WHCQ0/ZkK4m0eLJsXzUe8X+sV2GesQGAqjPvaL9v5e0L+y3cjl1MgzHM6Hl
	GqPxwk8GrXywE+TcNd9qw==
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2041.outbound.protection.outlook.com [104.47.110.41])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3vcv45jb1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 22:36:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIm7jFsJ79NbBY5gC7yHy3GtceyXXCZkavL25FEJHEwkS5jKEi1OvuNbv96QN5o0aY5nRYOhwhxFgzfYXOEcC26Atgt0iv4rFSvMM3D+iujqRx2oKTCPYkgFHUMlQ3QJiOy/sxS3pcEIVQ7xD27O5dGQA5kTOnsF3QU4/qGYOqsmX1hqtwAF/SnDeNaE9gUvvH9mAksavUVYHz1CPPH+iNCseN5pGAQfffCXHqniFZXDWIUh2TXVNBwD56GeFYLqa7L+JC9XfCvZCx25z98RlM4gDg4A9d+bWiBSNwNTS36rVxHd7u3AE+rZMZez94PZHP6WnnDmXc5Ot155OMg5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWJt0NHLE7m4sJeLS2+BV1RFKwx40fbowVV0ZczW+6U=;
 b=T+bT9TTcB96KclSv4T6JFIs9STpBSb6+Q081yjiXLXs5i9vX7BaW+qwnPdgcbyHP5WEEEuupy0zmy0lZ0N8Zln2tastZsOFTHfpthPL935ERsMaA7F1Xr6JxL6On3aUzB/gKwGXeJRg8BPZCAT1f1c7NCjJCyzBmEuqKBXvbtUXsDdwAuyGinL2mA8BXrLWuQ2k8H3WN+s1NGtoFbPodLH4ukmeFhx9e/M3ZPymO5Q8kyAXUs6e+5NtqG4XAMDH4+knrWI/LCEr4kmj2dL1Br9q0aDZfdY8Rn3g3Jy4r54PqkkhBqbvKaHAAjjNwz2e3kWZYAYg+AR+Glkr2NGYO0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=motorola.com; dmarc=pass action=none header.from=motorola.com;
 dkim=pass header.d=motorola.com; arc=none
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com (2603:1096:101:66::5)
 by KL1PR03MB6970.apcprd03.prod.outlook.com (2603:1096:820:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 22:36:37 +0000
Received: from SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::c0d5:21be:6c82:e5f6]) by SEZPR03MB6786.apcprd03.prod.outlook.com
 ([fe80::c0d5:21be:6c82:e5f6%6]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 22:36:37 +0000
From: Maxwell Bland <mbland@motorola.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Greg KH <gregkh@linuxfoundation.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        Andrew Wheeler <awheeler@motorola.com>,
        =?utf-8?B?U2FtbXkgQlMyIFF1ZSB8IOmYmeaWjOeUnw==?= <quebs2@motorola.com>,
        "di_jin@brown.edu" <di_jin@brown.edu>
Subject: RE: [External] Re: [PATCH 1/2] Adding BPF NX
Thread-Topic: [External] Re: [PATCH 1/2] Adding BPF NX
Thread-Index: AQHaPnlcQ/EeS56CsE2L+Zet/Q/kJ7DIj0aAgAALnYA=
Date: Wed, 3 Jan 2024 22:36:37 +0000
Message-ID: 
 <SEZPR03MB678610EEBA5140BAA4D1F13EB4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
References: 
 <SEZPR03MB6786598744F4D5DE29C46651B4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
 <2024010317-undercoat-widow-e087@gregkh>
 <SEZPR03MB678613E8257AD66C6CE47410B4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
 <SEZPR03MB6786B27446DE261893D911B5B4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
 <CAADnVQL-Lvg8ySrN+DNw45AHvKtWBdKLfPhdQn2ZZOdcrgrCyw@mail.gmail.com>
In-Reply-To: 
 <CAADnVQL-Lvg8ySrN+DNw45AHvKtWBdKLfPhdQn2ZZOdcrgrCyw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6786:EE_|KL1PR03MB6970:EE_
x-ms-office365-filtering-correlation-id: 926e3aad-b755-484c-749e-08dc0cac72b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 JBclpyF4/VI7js7Mcgo69ShJvxiamwsxNcH6ARLb/rJNDqlcC3hNmL0HgTgq+b8b5g39OQAz9oiQrj4ipVU61McAQ5oiePvIfmgADY9PULk/VUnSo2gCJ+XvU5lmjcL8Rhpi92ZptT88+DSwuodAClWZ+JTJMQ4rLNGnbT0NCN/67gYzL1rwwjXw4KTuqCxPSST/J9IXYMPMk+wob+mSSnnEteCFpY6LCyiYQ7aeTfQyUBRu9eleimdeupL/ABtG6P/JhxLU+2+fFr9MODO/ru7ajlfmwJd19gIhehKmsbcbhpqB77CVRvQYttCK3f9stHYGMOjb3uDpZhfozLxACulVzNAUmtJtk19jfdqYGDcaFUAIXkzRMgwWFd03CIEj+gIF5Yb50kcaTqiqSqPUr0th66vWzRkI0rkXbgu0ZtoMTV7wYuJ5n7uZKKUHNtfPhTaeXOq98LatAYcAm9ODeYM5ZJFdebLu5NR8Nzt3iMk3CufUXO/EYpQSnm2F71y+EkdSET9HzzXKtfyGwcIJdlE15gjYrCtU2Ok/f6Kgp5+mRuqFieE8EKgK33T8PhL2y/Q0BAjrYdMqLOAGVhqN8Eojonbn8ti6tZPV4PmPFgMPwyNf6rQGB5HfLJtMaHEDOZqObWxzqO5KkGKQtjwl1K8PBMicc7lOBXoFN7qXsmSFimyj73t+KZY/WuGF+Xcq+sMjJ6iMUlaFbYk/OBTx8Q==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6786.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(86362001)(38100700002)(122000001)(41300700001)(26005)(83380400001)(33656002)(55016003)(38070700009)(82960400001)(71200400001)(478600001)(8936002)(64756008)(6506007)(8676002)(7696005)(66446008)(76116006)(66556008)(53546011)(66476007)(66946007)(54906003)(6916009)(316002)(2906002)(52536014)(4326008)(5660300002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eFpGQlltdmNJNUJJNW5Ba05QemR5Um1YQm5Kd01DYllpRFl3aDhoZDBMcCt1?=
 =?utf-8?B?L2hHbzZHVUdIVmJkaG03cGhQeFhOUmMwUTdCbG55QnR0RS94akYwazJybGhp?=
 =?utf-8?B?aENsNEI2YnhFYWtzQmgzK0FNYUtQOVhpN1RvMXpaa0IwdlJ1RW9LN1VEcERX?=
 =?utf-8?B?cmxVNDRWcE5KOWM4OWJXNSt0bU9VSHR0UHo4d3hRM1phREJDNUwzcGUwbE5W?=
 =?utf-8?B?cXR5d0RIQnJmM1ZhcXRoSENNRWdSUEpBL1JYQWI0dWxRS2hIdU5WT2RickI4?=
 =?utf-8?B?cnBRZEppbnIwelVncE4vZXpnWWVRVVlTRmdFeTlwWFk3RkkxRU43Wmp6OUc0?=
 =?utf-8?B?WFhqemVZd25vejhKdnN1Tno4R0JveTBWS3VqeEI2RUdrbTh1QkdtUnZKamxk?=
 =?utf-8?B?cEFaWS9uYVJsNHlGSlNKcWZuSGFNSjFHUEpzMVV3U1ZuOUJhSDFpMlZhMG9C?=
 =?utf-8?B?RDdpVnk2S0U4Q0pxL1MrenVQTjhKVHdpOUlKaU1iRStJa2IwMmhaOUQxeXhK?=
 =?utf-8?B?T2pneFRiWGszdC9vWllCdEZqV3NHTHVnZDZ0bnRVY1ZGRzlQbENvdFh2c21j?=
 =?utf-8?B?dXB1TktMdkxaaWs4WGxYWm12dDlDTnF3ZExGMHJNTEJCZmg0dTQxNXlFWHk1?=
 =?utf-8?B?UHVyWmhPWjZEZzVZRlp3c3RvdytrR2NSYkYvMWpQL2pJS2k1Q2dqZ28xeG14?=
 =?utf-8?B?VVZYcXF4Yzd1aExkQVl3T0wwT1VFWCt6SVRoRExCeTVIWXVabncvZDlyZ3h0?=
 =?utf-8?B?TjdmbktWQW1ua2gzL0FrR0JkaW9rZW1lVjVaaURVZTQrdEdtZGlGT3EzSGsv?=
 =?utf-8?B?MkRscUt3bjV1Q2xnekJ3QnBCb2x3T0JUdDNKdzVVM2l3UHdoTDFNYzE1cXNi?=
 =?utf-8?B?Q09DSkVvY0Q0aThHTE9xZjc0cHh2eHh3bEk0cVFNY1p6aVNiSEk5NWRrYjNR?=
 =?utf-8?B?TzQ5dCs4ZlZzaDV5NlFmQnFHMUszdm5pTU1HVGlyWjBpTklkNTZyTmxoa0E3?=
 =?utf-8?B?Q2Mxc09iZXJIbGZnWnVoQ3ZoQyt0Z0JjL2dTYkhwTytVaGxCNUJjUWJEWHlj?=
 =?utf-8?B?NjIzc2VQNGZheHQxK1JxekdVaWZDeHpGQitrMkpWSEZ6a2NhbDhHNUF1L2p1?=
 =?utf-8?B?TGZSY3RSbnpSaWIwY2R6WDhXZG4vQTA0STUvanR6YzV2UzNmS243Q2lycXlV?=
 =?utf-8?B?eVlhNldDOGw2TUc3cXVFTS9oUVRFbUNjTEFqd0NXbEF5YzZvaXFpMUcwNXh4?=
 =?utf-8?B?T0tIUTdlakIvVXVlL0VGMzVzemg4LzZoUi9ZWHNSOUVaS0FsR2dhZlgyZjYv?=
 =?utf-8?B?ejJISnAyQ2xTR0N5VXFFV3F4Y2lUR1FIYThqeWtHRW5QVkIzV3ZqaUc3aXpI?=
 =?utf-8?B?b3dwNjFUMnM5ckw0VW1SMXZvTWtOdXYzWjZxN2dXdjE0SGVscFRGSzN1aFFJ?=
 =?utf-8?B?WkJrR0d0S3h6a3V6NURndFl3NWxMTGpzN0U4bGlGOVdsZmk3WHlRdnJIRTF3?=
 =?utf-8?B?dVFjSWZjSWtwc0R6QkNXUVFHT0VsTm9pcHRpa0IzZFZqbDlUekxtaUhkNk1r?=
 =?utf-8?B?RmR0TDluQ1ZjUGJDdWpIUnROZEwvaVFyUUZwRVRzSmtCL1RpZ1grcjZNSTZX?=
 =?utf-8?B?cDk5TVFEYi9jTEtNM21VbHBmVWJBcW5aUGozSTZQZFpFeEhEcWVQaVBkK2F2?=
 =?utf-8?B?QUg5WEttaFp6cXQxT2txdExZR1kvMHBMTmtGdSs0Qmc2N0E0elFqbU1nSXRn?=
 =?utf-8?B?cGJML2p2RjZCMWJUck5zUmxlRUlkaHRxOVhkM3hNQjkyZWVweGZSYkV6QjJq?=
 =?utf-8?B?bnRWMDU0MFhpNENHK3pjOFNjSEI5d3E0ZVR1SUJMK2dPYXFJS3VJaUJNeXFk?=
 =?utf-8?B?WGtTWjdJYTZ4WlZ5NG5NSHVjOTNabEZNTVdKaDVBczB5a1pnSVdYcUVqeGNK?=
 =?utf-8?B?YUh6Qis5WTExNGYrRHRucE1HSVhVSGRiUnozY1RybUw2WUZTMlduQlNwWVZZ?=
 =?utf-8?B?WWErWTlKckVVYmNlT0RGdDVHbmJYMlhYQWltWVFXZXBya3BkS1RPMW96S3Jq?=
 =?utf-8?B?d0x0cG8ra2xSYTI5TmtRTDZXWUpRZFRIelc5eFAxNzZDeDNsSjZzY0xYKzNo?=
 =?utf-8?Q?53yk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 926e3aad-b755-484c-749e-08dc0cac72b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 22:36:37.7583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttYwu6Bgccpib2/yjhfNWKe/nF4ROW3kIotGjCxYCFKFCmRHb1/ODBy6uAOdjcW7gIaGKzNhk3tmxKcK4bx/lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6970
X-Proofpoint-ORIG-GUID: aonrkgn02ZNQgoIb4LLThz7whMuHSta0
X-Proofpoint-GUID: aonrkgn02ZNQgoIb4LLThz7whMuHSta0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-02_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401030182

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4ZWkgU3Rhcm92b2l0b3Yg
PGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFy
eSAzLCAyMDI0IDI6NDggUE0NCj4gVG86IE1heHdlbGwgQmxhbmQgPG1ibGFuZEBtb3Rvcm9sYS5j
b20+DQo+IENjOiBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IGJwZkB2Z2Vy
Lmtlcm5lbC5vcmc7IEFuZHJldw0KPiBXaGVlbGVyIDxhd2hlZWxlckBtb3Rvcm9sYS5jb20+OyBT
YW1teSBCUzIgUXVlIHwg6ZiZ5paM55SfDQo+IDxxdWViczJAbW90b3JvbGEuY29tPjsgZGlfamlu
QGJyb3duLmVkdQ0KPiBTdWJqZWN0OiBbRXh0ZXJuYWxdIFJlOiBbUEFUQ0ggMS8yXSBBZGRpbmcg
QlBGIE5YDQo+IA0KPiBPbiBXZWQsIEphbiAzLCAyMDI0IGF0IDExOjE24oCvQU0gTWF4d2VsbCBC
bGFuZCA8bWJsYW5kQG1vdG9yb2xhLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBUZW51
dCA8dGVudXRATmlvYml1bT4NCj4gPiBTdWJqZWN0OiBbUEFUQ0ggMS8yXSBBZGRpbmcgQlBGIE5Y
DQo+ID4NCj4gPiBSZXNlcnZlIGEgbWVtb3J5IHJlZ2lvbiBmb3IgQlBGIHByb2dyYW0sIGFuZCBj
aGVjayBmb3IgaXQgaW4gdGhlDQo+IGludGVycHJldGVyLiBUaGlzIHNpbXVsYXRlIHRoZSBlZmZl
Y3Qgb2Ygbm9uLWV4ZWN1dGFibGUgbWVtb3J5IGZvciBCUEYNCj4gZXhlY3V0aW9uLg0KPiANCj4g
SGkgTWF4d2VsbCwNCj4gDQo+IGludGVyZXN0aW5nIGlkZWFzIGluIHRoZXNlIHR3byBwYXRjaGVz
Lg0KPiBDb2Rpbmcgc3R5bGUgaXMgbm90IGtlcm5lbCwgc28gaWYgeW91IHdhbnQgdG8gdXBzdHJl
YW0gdGhlbSB5b3UgbmVlZCB0bw0KPiBmb2xsb3cgdGhlIHBhdGNoIHN1Ym1pc3Npb24gcHJvY2Vz
cyBtb3JlIGNsb3NlbHkuDQo+IA0KPiBBbHNvIGNoZWNraW5nIHRoYXQgeW91J3JlIGF3YXJlIHRo
YXQgdGhlIGludGVycHJldGVyIGlzIG5vdCBzZWN1cmUgaW4gZ2VuZXJhbC4NCj4gU2VjdXJlIHN5
c3RlbXMgbXVzdCB1c2UgQ09ORklHX0JQRl9KSVRfQUxXQVlTX09OLg0KPiBBZGRpbmcgZXh0cmEg
Y2hlY2tzIHRvIGludGVycHJldGVyIGhlbHBzIGEgYml0LCBidXQgeW91IHNob3VsZCByZWFsbHkg
cmVtb3ZlDQo+IHRoZSBpbnRlcnByZXRlci4NCg0KVGhhbmtzIEFsZXhlaSwgaXQgbG9va3MgbGlr
ZSBteSBlbWFpbCBjbGllbnQgcnVpbmVkIHRoZSBmb3JtYXR0aW5nLiBJIHdpbGwgdXNlIGdpdCBz
ZW5kLWVtYWlsIGluIHRoZSBmdXR1cmUuDQoNCkkgd2FzIG5vdCBhd2FyZSEgSSBzZWUgdGhlIGlu
dGVycHJldGVyIGlzIGFmZmVjdGVkIGJ5IFNwZWN0cmUsIGNyZWF0aW5nIGEgZG91YmxlLWVkZ2Vk
IHN3b3JkLg0KDQpXZSBoYXZlIHRoZSBpbnRlcnByZXRlciBkaXNhYmxlZC4gSmluIGV0IGFsLidz
IHBhdGNoZXMgYW5kIHRoZSBhcHByb2FjaCBuZWVkIHJld29ya2luZy4NCg0KV2l0aG91dCBnb2lu
ZyBpbnRvIHRvbyBtdWNoIGRldGFpbCwgSSB3aWxsIHNlZSB3aGF0IEkgY2FuIGRvLg0KDQpSZWdh
cmRzIGFuZCB0aGFua3MgYWdhaW4sDQpNYXh3ZWxsIEJsYW5kIA0K

