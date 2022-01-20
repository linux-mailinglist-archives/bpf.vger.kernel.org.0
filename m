Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63ADE49570B
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 00:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347844AbiATXh0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 18:37:26 -0500
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:37656 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244889AbiATXhY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 18:37:24 -0500
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20KNWH8d005684;
        Thu, 20 Jan 2022 23:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=KJB7eM0VCI+p/FZkPrST+jOdA3BlfgayujJwsEPBH9Q=;
 b=JrAW99k9O7jbGtS4mKoEmn+/YgYeqnocdELhsXlLnc9u45rN/5ANL2uNpm7ZpA8LqMza
 UldyFrhYBOSy3ZyCoacAiTYu6gonDB5QRJYitvxraWuV0C7JdwjEpGW/hJ2IIqdvzzV2
 oHpuMXAz01L31kdGvBaecjuwouLod3f+2PNlbKU/DOgMdiN3I+rC41nMHSjxH0//o1IQ
 Nplu8ppqPbo6lmL0RsUgOzNOwa326OYSHIMSuclLmrJuNxKb6+AeQJacSibTY0lm9bA7
 l1b0KIvwe2RKIRpN0RVahi4y2hMYCxO7bL80gZGjO9L4AbaPCyqumEKgkfUnee5PKE6c hQ== 
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2172.outbound.protection.outlook.com [104.47.23.172])
        by mx08-001d1705.pphosted.com with ESMTP id 3dqhcd009x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 23:37:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fF2d4XkomCfJcGlHh5NH7yLpkO2kcG3jYXjAY/gcVWdwN2l85pqpOgBE8XCi1OH8ify394nNtWrRFG4NWrGz8/b8ubUjevWmhORaUISgJPvjd1k9IkMRl6FIllv2Jbz/wayJrdJXYtfm4NooNnj9EzyiFiSTpcjpmu3Flgy25sWD+fk7/WyAOzViC95oXck8NeGtv/lk8SN86nPfcYaG/Mqld+G1LiiyVQKfX71/4m51nArCOIY5le1w6S9oXjImda6I5nzZWK5zG+XNvakjj8yts6g21itF5EhNJeVzLf4/jsNXxABDBKodgCqphCP5M4gkv1cmx/HUiVXXlX0vFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJB7eM0VCI+p/FZkPrST+jOdA3BlfgayujJwsEPBH9Q=;
 b=GLv4UHZ9N2Rrdtk3n38TzmRUXEMK8svoyUd6MDTotVDBFMJIAtetS10ETrJgFczwJhMx3et1mf5wECbsoT2XI+kv4Tgh9jQst8GxCxqF9H0pJhIpQL6hI5Zik5PzXDeTnZYExeGq5rNEKE13IokALE0Sqw1+951b8Y3N51mi7P5nhh/2o5HJYZZLWcKyhE2A/zOWJqM+L0DCoW8RP4GhCUedS1Jsnv9+mNQCzH0nR3VXN0oLid756RMNFBsSC7HBygOUXzyE30hShespLGP9Bgq5lyByuAH8tQexFzef0zHnPA9ResFqRj1Gcb/jXtH+tTEEG6+Sh4l5cT9GuKn7hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from TYCPR01MB5936.jpnprd01.prod.outlook.com (2603:1096:400:42::10)
 by TYYPR01MB8119.jpnprd01.prod.outlook.com (2603:1096:400:111::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 23:34:12 +0000
Received: from TYCPR01MB5936.jpnprd01.prod.outlook.com
 ([fe80::4d73:10a:5d6:4b8d]) by TYCPR01MB5936.jpnprd01.prod.outlook.com
 ([fe80::4d73:10a:5d6:4b8d%7]) with mapi id 15.20.4909.011; Thu, 20 Jan 2022
 23:34:11 +0000
From:   <Kenta.Tada@sony.com>
To:     <andrii.nakryiko@gmail.com>
CC:     <andrii@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <songliubraving@fb.com>,
        <yhs@fb.com>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>
Subject: RE: [PATCH v4 2/3] libbpf: Fix the incorrect register read for
 syscalls on x86_64
Thread-Topic: [PATCH v4 2/3] libbpf: Fix the incorrect register read for
 syscalls on x86_64
Thread-Index: AQHYDTZZ2C28qVTfhEWPJ0gTzKPfeqxqq8iAgAHYINCAAATdgIAACHzQ
Date:   Thu, 20 Jan 2022 23:34:11 +0000
Message-ID: <TYCPR01MB59365EBB32022F54882AD196F55A9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
References: <20220119131209.36092-1-Kenta.Tada@sony.com>
 <20220119131209.36092-3-Kenta.Tada@sony.com>
 <CAEf4Bza9A+iC49bZRiSPWNuy+=qG3sc=_XvKem4Fj2zZF8merg@mail.gmail.com>
 <TYCPR01MB5936508A473D90FCA8C779E9F55A9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
 <CAEf4Bzb5ShGTVwf-62rYzA0EKqSd=HkMuWeaO=Og4xyN8k6=AA@mail.gmail.com>
In-Reply-To: <CAEf4Bzb5ShGTVwf-62rYzA0EKqSd=HkMuWeaO=Og4xyN8k6=AA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9a48a8b-308e-49fc-98d7-08d9dc6d5d00
x-ms-traffictypediagnostic: TYYPR01MB8119:EE_
x-microsoft-antispam-prvs: <TYYPR01MB811990E5A8E2178DAA43684CF55A9@TYYPR01MB8119.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jfzOkuV+tavN40BWThT3BcWuL0cgVmwZrIh/PtM2DZQEaZsQoWEA1d+VWF43N92DeAIjNlBWLsk7MWWnuNctMI9LioqpoEpF1Pl5M7y0Domi0dE3XIu3I6Sm+1nYY1gfakEzLO1XAldJplbA1jyQRENyIapMQNtFQcSGMN5BS7DmOEWEfn+GniLz54RPFPKqGKM+Z0AbM7L1etFNtLxAR8t1YaktuBviAOnvr/8reW2pj1PJOl6l+8bkYoi9rjW1+JnzAFkQyO+dxWgdUkWGKl8JD9z5dJ2KkkPoZG7hTkaXvpIL31YpC7aFu/aqCO/MRbj4GoAjNbQWiEj1IqeQiMX4lLBF5QOU96dWQhgXOk7Ytjnz6JqKFYdYcmi0no22xfkeR0SXxqYmLc2ic5VcfPwtjJFlMqhmQilEK1M7JIeGiucNe5lzvUKxN9wNs9E0Zj4/1nYDOaHpPUgeENF7C/msw3It3yfpks8zOMIzAA5xJArsQe8sbSf9goChbxXQO09VeE0UZPC39XjoosBsLQoeJhgMU9LGdRDoIYtLsXnMmGvKzEN1ebzDTQtM7y/vfYp7c5K1V+Px+fi4lz7IxaNQr0bgRuJSZZGgL9PKH/Neiy09lSklb+FiW+51mNX4iQ7wzNkxqq4Ib38SCuCZiCh9uIzE2kkLZvRdK4qM7mp9Lfu6m8t+9uaMUnVlL6J731O4znZxkTtzxMD64j7P4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5936.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(71200400001)(4326008)(9686003)(33656002)(38070700005)(4744005)(316002)(55016003)(122000001)(82960400001)(7696005)(2906002)(52536014)(6506007)(6916009)(5660300002)(38100700002)(76116006)(66946007)(8936002)(8676002)(186003)(7416002)(66476007)(66556008)(64756008)(66446008)(508600001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTJ1aFlsR2Npc2hZaXp4b3daSXpZR05SSGpDMlJWZ0RYVWI0cHowQ01vV2JY?=
 =?utf-8?B?d0thL2l1QnIvZzlTK1JzMmY3YVZoaUJhQmtTUFFiY3hpdk0zTzYrOVQwUjNN?=
 =?utf-8?B?N00wRkFrb3Q2b3JvcDlRMncwZ3NkNjhGRzV1THZTdURKV016NENRUlduM1h4?=
 =?utf-8?B?N0tLU1RlN0RkVlc3UE9QN0pqUkREZVZqSVk4N0tFYUVFK2x3SzJscVNpNkpI?=
 =?utf-8?B?K3ppL2Zha0V3YXUvSko1cjB4dlMwdVZwOXRaWmswemFPS3M1SEdIeFFVNGN0?=
 =?utf-8?B?MUNyQ21FQmROTmxUV1Q5N2lYNkl4OTM3OGJOT2hkOThmTVVOU0k1bkMrSEFC?=
 =?utf-8?B?MWhUeE01cUd6RU9qNnhPVVhDWEpCM0o4V2ljQUVUSXJXTTdjNlZtOWRiZ016?=
 =?utf-8?B?Q3BNNzFBMnNoY2JNME50UWhIN3k5RFIxTktEZnJtQVFMMisySGlHOVRBNmdS?=
 =?utf-8?B?WkJyUnFTRGVidms2aGpHeTNVVjNBNERFRmJnbnhNdEpCTjN2ZUlveHhCVUFv?=
 =?utf-8?B?Z2xmMnJ0amFHVXZERXI1aUJMRTZmU0NmbEszTnl4U1c4MHlNWWNyVlRRWjlS?=
 =?utf-8?B?UWpzMjhld2J1LzhuaFZqQ3EyNzlUK1I1N2wwK05xRFp5UDdwSjBhOTVvVENt?=
 =?utf-8?B?Y2RHUDN5YVlBcGpLOTdUS09zVWpjMGtIY1o0VGp0NEdHQnh5Q1NRSDQzcW1P?=
 =?utf-8?B?WUR2OHhjbzNaZjhhV3FNMm9IVE1JWHNEcU5vcVozQ294M2dCR09CZmh1dU5P?=
 =?utf-8?B?MGdQVnF0RWwvZEN4c0hpWCtLbm5NenpqL0Z5UElPNkZ4V1ZhK2FZUlhxMzA0?=
 =?utf-8?B?YUdBc2FVWVB2ZEV2R2JiWkxuR1VCU0JWblMrV2dvakhtT0IzaXZIMnlvMHVB?=
 =?utf-8?B?OGc2Umdlc21zTkVDMHMxWlQ0eGNrVDYvczIyUDBwaUttRm10THlOalBZWGhN?=
 =?utf-8?B?R2ZTL0pRREk2Uk1OVTdaVzZlMmxBb3FCREUvdmh2VjFFNDJmSkZLZTQvSDQv?=
 =?utf-8?B?YU4wc1prOWFUV09EL2RCdHBTaGRuSVU4dGNoVkRESXoycGVTZURGQmM0ZmRU?=
 =?utf-8?B?bkNjWVgveDRCelhxSGtxUm1RVTVQb2cwMEIzNG50ZzVFVmxwUnNyVjRERzVx?=
 =?utf-8?B?dWxTWFJIcFZTUFJ1UDRQVFA3ZGIrY3pTUVBkUXNycm1PKzBVbGJzd2lnRk1m?=
 =?utf-8?B?emZRdnU4M1l0bW9Zc2ZyeW5TQ0srSTYxQURWeUJhTFV3ZjZpU1kySW9yNEZz?=
 =?utf-8?B?dFIxMXZjdzY0b2JpVHNYS3J6TGZwNlYxTHBtOENwU25uMklzcUI2aGhEUEYv?=
 =?utf-8?B?ZWRsTGVGRVhxWjVSaVJHRnFXUW5LTFVYanpsVkQrWWJaVVJOOVM1VE56NWtE?=
 =?utf-8?B?VnRlZWZQZnpaWVpOWkxuUjdiakZjSndiWDcxMDg3bTBDVzg5V2ExNVhNRU1y?=
 =?utf-8?B?N0RLbTVpNm5uZHFob1l1WmxjNkk3VW1SM0JsTmJPRU1wVzh6SXJrRHpMYVBv?=
 =?utf-8?B?bzFzTEc5RUlSc1A2bEM5QUYxdFFCK3JqRU91d2MwcTgrRVM0cnArQW1JYzI0?=
 =?utf-8?B?UjI5amRCYVU1UEU5VjJjVnRWMEdMS1l2ZFZmY3BxYWFBREphOE9McFN1N3o0?=
 =?utf-8?B?RFo4VGpVRjg1L0k4TVVmVGhLYnNqTnFjSUxzcUFsOXVSemwzaE5jbHZaZGQ5?=
 =?utf-8?B?QTBwUnE5NG9CdWk5QlREMEREMnQrZWltY2ZzeENzdGRkSkNEU0xERExCT2VM?=
 =?utf-8?B?dFJsSHA3Zkkvd2RvS2hKRyt3cXo0b09hSXpkTzh5ODVWZCtkR2Zjc0hDK1Nx?=
 =?utf-8?B?SFNURTd4MUNuWEQ3NmdFWEsrOWxiaFYxNVZrYnE5aHo0QUNPak9UUjU2ZGhk?=
 =?utf-8?B?c3VlK1FWWGI0QlVhSWFRbXpvY2JkN2tWYjRjWGcwalUrdy9VcVB2MmVkN3VW?=
 =?utf-8?B?NVRiYmZYeVpHWDJmbWNXZ1pGWGtkRko1OEtNM1M0V2h2VHdNaU5GWGJiaVZJ?=
 =?utf-8?B?RUdXMTBDNW9QMVZMakJGRnJWai8zbVpJRnNGME9LaE5wUVUya0sweXVHTXNN?=
 =?utf-8?B?SURPU2J4a2t0NVBhWkM0eks2eHVBZjFRSFRDdEdqNU5IbktzVVhycllpYmhz?=
 =?utf-8?B?RE5EWEJ6UUFXMG54SXI1OFA2UUUyY1Fyak5RVlp5c2dWaytiNnFhZExqZURU?=
 =?utf-8?B?b0I0Yi9XMTdtWFkxUWhVdm16MlF6U045ZUd6d2lnTVdUdnRWZHN2dStTbm8z?=
 =?utf-8?B?WDUwek9VSmZBYTNWOC9aQ2V4dmxRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5936.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a48a8b-308e-49fc-98d7-08d9dc6d5d00
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 23:34:11.8877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1lTFugeW84z6ITblMMMFiUkrEOSHOsSDeyzCsNOsaGTlxyJTDCxKiene8opdGboTVpDqc1SK7BuN38emxJYlLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8119
X-Proofpoint-GUID: lQALxm4w23cM9VBq0uVE9BDAHta9O3bC
X-Proofpoint-ORIG-GUID: lQALxm4w23cM9VBq0uVE9BDAHta9O3bC
X-Sony-Outbound-GUID: lQALxm4w23cM9VBq0uVE9BDAHta9O3bC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_10,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=801 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200119
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pj4NCj4+ID5kaWQgeW91IGNoZWNrIFBUX1JFR1NfUEFSTTRfQ09SRSgpIGRlZmluaXRpb24/IFRo
aXMgc2hvdWxkIGJlDQo+Pg0KPj4gSW4gbXkgbG9jYWwgdGVzdCwgdGhpcyB3cm9uZyBjb2RlIGNh
biBwYXNzIHRoZSBjb3JyZWN0IGFyZzQgYmVjYXVzZSB0aGUgdGVzdCBqdXN0IGNoZWNrcyB0aGUg
dmFsdWUuDQo+DQo+VGhlIGJpZ2dlc3QgcHJvYmxlbSBpcyB0aGUgbGFjayBvZiBicGZfcHJvYmVf
cmVhZF9rZXJuZWwoKS4gWW91ciBkZWZpbml0aW9uIGRvZXMgZGlyZWN0IG1lbW9yeSByZWFkIHdo
aWNoIHdvbid0IHdvcmsgaWYgcHRfcmVncyBpcyBub3QgYW4gaW5wdXQgY29udGV4dCB0byB0aGUg
QlBGIHByb2dyYW0uIFdoaWNoIGlzIGV4YWN0bHkgdGhlIGNhc2UgZm9yIHN5c2NhbGxzLg0KDQpZ
ZXMuDQpJJ2xsIHVzZSBCUEZfQ09SRV9SRUFEKCkgZm9yIFBUX1JFR1NfUEFSTTRfQ09SRSgpIG5v
dCB0byByZWFkIGRpcmVjdCBtZW1vcnkuDQo=
