Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6B15A3249
	for <lists+bpf@lfdr.de>; Sat, 27 Aug 2022 00:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345290AbiHZW7B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 18:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiHZW67 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 18:58:59 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2214FE990B
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 15:58:59 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QIP6ox028184
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 15:58:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=zNUKbXY3RVLmpWmsqIn3Cqli+knLhCsbSXjY+pQzxuQ=;
 b=GHM41LOmdPkLgP8UV4OimUkMUcWWXh6EETgWAyDEdGVD1Btv+Nj94/gCN8hDiz8kgQVJ
 7JT8upKJQq1j8+txbHv5hMMQowNAyBRrtkH3IybZhpPFbxwcKutTNLj+oIHU+3+Y2dZP
 6eazwXS6JbCnyAnd3CwEBJJPYM7/YUBrdv4= 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j6myh6kga-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 15:58:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0A5IJuYhb+9fxDn021zFQsesW0Ea1rvRnKJD8hwPI1FT7YDnjpY78G3GeE6WAbyUgd8by1a9+LOz6hJOunGuLeedzpCFaTcaf411dPmp4/6ZAe+zSSonUrP2LV23+XjpSz/ktn/BXNPGuZGoaLvoPXjiPxhKihxUdq1fqnYq8AjJ0GiY1hg1sj2xbIF2InkmCoV6Bwj3JvhN6VbwjMwVmmrx/s2uEAGFOi1DO0n7AC4xnp2ss5uAIsx9szD3ZL5Dh2sXGfntXpYMjTCKzc/kWvSFISsjpCMr5KcEhHnB/AWCc51yBlLVmTB8UcxF493jGQFDRGf5b+wgWbKL0FWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNUKbXY3RVLmpWmsqIn3Cqli+knLhCsbSXjY+pQzxuQ=;
 b=V7+z0lRW6b7X/dTvJYVtElPOqe0gCIt2/suEcMC4D+ho9ag3Y0Ta8FmnEzzY3vluXQmoLw0P5y/wvXK1Hw30HuoUxsF0S1v9Z+2OfLCjKgpUG8deNpjOQ3WSsGhYqTyEMujGr8a3BUesJBQ+HF8hkJmOSijhQ6jIGWsOUFOehq5JWxBBTqYg6Qe0IaB8xo9PVPvOtkTDA6IGcUSytNmaUlYIjf41wrgwhMKzh/LvLuXLlsQIKR+tFQN5b9nlAi44IC0dw0WvIuG8QNwV1SeVl3XOQnlt7krFbRHF5gm8sysG4im7uFriveMHSNtVuqNmCMXEvHM22Ys91zCu4ZIu4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by DM6PR15MB2603.namprd15.prod.outlook.com (2603:10b6:5:1b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 22:58:55 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f%6]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 22:58:55 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "quentin@isovalent.com" <quentin@isovalent.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next v7 5/5] bpftool: Show parameters of BPF task
 iterators.
Thread-Topic: [PATCH bpf-next v7 5/5] bpftool: Show parameters of BPF task
 iterators.
Thread-Index: AQHYuOQbxdDwFgXZP0eqhBcRDvczUK3BCrAAgADCXAA=
Date:   Fri, 26 Aug 2022 22:58:55 +0000
Message-ID: <f7c9ba3e30218668baade2bcb142339943025172.camel@fb.com>
References: <20220826003712.2810158-1-kuifeng@fb.com>
         <20220826003712.2810158-6-kuifeng@fb.com>
         <c2de50b3-4928-4a7d-6028-fd04a1aeff00@isovalent.com>
In-Reply-To: <c2de50b3-4928-4a7d-6028-fd04a1aeff00@isovalent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cd4d2d7-9e70-4d57-427c-08da87b68d6b
x-ms-traffictypediagnostic: DM6PR15MB2603:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k65p76TEfJtsy+1RT4KncEBMB4PkI1jcEFWOE2bHaGb0nma4RX0PwciMUqyYXE843Mt9WMWukuroNMMVRgBkluwdR9iA6Sh42tNlQ7+l6BuIaSTAEMbJVNnY4oO93jqlLsQBmSivPQmu+x0Cs7wo2Ciogvu3GlDHXh+KkdXA9mgH4XOBm2kru7HBQYmoL2uCLwGcIsWecEF/mQr5UKlMdU3sWG25mRmjrTpMfJz35g5S2CZ6FMQdNrNB9PJ+5q/SCnmx42VpUuKXCpm1m+d3OKlkz8/CSxPsHOGzm5eQuLuRARapCWLHNHyv9aSh9nred+YOTXxfci2aBuLsnoN794wTnW0lZ75J0bo5ih+TYy4BJu8S01UjMF2B3HAcW/qMqd7nqJ231wbbZxF9ocIs9k4QoO2iBdvAMXuQ6XtCRsUWKNAHDsABg5IoMrqDf3DZsqzLld+YkhcDc10cE//lb1kUf9jQ6xQKkB94oMqv21n7fC4RyMLEggqOKbdzFn+8UcvxgQhDc2qB2R+ntOP4ZDL3eMPcyN0Jv3NqJJ6GziXHGypqm0vmA/42rf8HjekjZzg/itpNTDXeiDfQ3a2VvafMvuc5yAEzj/2XUfKoiOPE3us3lk9fSkN6/pcwBG9tWTTko+1YIDI13aOWyrJdwA0+sY7DoikzyJUG7kLf6+HftSmDqGR/8MsWtIykt/EYx+yrd0i5H09aAoroq/nhCRFlBFC5EMu9JJogsfEjN/XTkYDbzG9E9N/XsiS/L+d5HBIuWkuTBNkxi868/ZfPBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(6506007)(6512007)(38070700005)(316002)(6636002)(53546011)(86362001)(110136005)(71200400001)(6486002)(478600001)(41300700001)(122000001)(38100700002)(83380400001)(76116006)(2616005)(186003)(36756003)(2906002)(66946007)(8936002)(66446008)(64756008)(66476007)(66556008)(5660300002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2U4REd0TG05czg5QUNHV1FpWFh3Znl1bE14WEhNczkyMU9vTnpaMG14a3lT?=
 =?utf-8?B?N3M5L0NNUUNDN255MU5kb0NKL3A4MS92V0xMUXh0UVVKTG00TlROVTVRQXpU?=
 =?utf-8?B?RG9rb2JiWWxLSjl0WlJCVTlhcjhHMGJ4YWlFTUtPTnZXZzFjN2hZVHdPSWl6?=
 =?utf-8?B?REozVGdScFl1T24rRmVuNDNNQjIzcVFBZEFOQTJhRHJSWU55T1VkRXR1OGRS?=
 =?utf-8?B?Ly9PTkdjMUpOOUVESWJxazAxNDRiN1VOck9ZSmswMWhYV0ZtMVMzSVhCZlFk?=
 =?utf-8?B?UlZvdXI1cmM3dUVWZStUbEQrVkxPeEpZWENiYXhUemE4dmZvdk0xaVBNNit6?=
 =?utf-8?B?ZlR1R0sxNS8zRVJiTDNDRFAzdjF1eU9tSVhiR2JBbE1KWW9MQnVJcGZzUzRy?=
 =?utf-8?B?RkJLa2YrRk5EcGRzOWhwYTRyNjZtU2pFZnZIUFJIQUJIcnQ5a2FXZTQwUWUv?=
 =?utf-8?B?VHpzSnNRZjNyRVg0dGdkVEYyc0xrZ3l1aHhXUXpHbWo5VlBwNGdIWEw0Yzd1?=
 =?utf-8?B?dHIyL0FEZ3o1N0lqMHQ3M1FqdmFpS2lrREZHT28wOVZNcVVZci85Zk5rN1N3?=
 =?utf-8?B?UTc3Qjk3Nk1MNlc5VUU2RUxaYk5tSUNKVDZtaGp5UG5CcnB2UHZKcUYvZS9l?=
 =?utf-8?B?d2VGSU1uUXhFUUZZbzkzVUhYQ1l6UG5kMWUzZWtMTUpaMHVTeC9sRHlOd2dV?=
 =?utf-8?B?U0g1b1YwQ2IrNGpGN1RiTWVmZXBadmhiQWVhUFY0T3JsUmQ4TlIxVTNKM0VH?=
 =?utf-8?B?bTFlNENTNm1qc1N1UnFFS2J6OHh0NFV2UXdJakg5U0xwdnVqUWpNRFBHMWZj?=
 =?utf-8?B?T0orRm0xalJQTGpBaEU2U2lPYmpCWnhCWUtLT2RXTkFMajcvbWttbm9FU1RH?=
 =?utf-8?B?cm5VM0RMaVlkaGIyazljT1JVR09WNzJVNHFVdGMzSzliSkhKR3k3UGloU2pn?=
 =?utf-8?B?Q2VIbk5WanU5VVdaVzUrdjdMcXFVWWVpa2VXYmNHVkxpZy9ZUWFOeTQ3akts?=
 =?utf-8?B?TGdEK3czYXVRVFFGaDBHNkQ4RWp2N0UyUTI3UjFVb0F0OGowZHEwQjZCR0VY?=
 =?utf-8?B?eHF0Y2FZNDJmWm9LNW5GZjM3eHU5V0dhQXRpSys2RkhVZVpRelplSys1dU5r?=
 =?utf-8?B?dk9JY0dqTWthZk45akVQeSthQW9jbEdIRks1SDVHV0kzendmWVFjcDRZVEtK?=
 =?utf-8?B?QWJTbE0wSUVtWHZNcm9ZbnZCamdIcGg1VityK0xtb01QUlJrUnJWMzZqakc4?=
 =?utf-8?B?SFhHQnhOWlM4RUxzZmhFZ3hjZG1lcjRRWU9aRWZXZFhYSDk4b3ZJRmRNUGN0?=
 =?utf-8?B?cEhTYThoSjZXYTdWeFViVk9BMFlvVG04OUV5VFo0YXVGTHBPMG1TSGNqNEhq?=
 =?utf-8?B?OURVQjI1ZHMzTGVMQ2hPQnhBRWVsc3VNa2FQZ0l2aVN6SkdoWDZPejYvWnpw?=
 =?utf-8?B?blF6TWZxMzZCdklzZnZZQ0h2NlptTVFzeFgrYi9zaHAxb3ZJc0pjUGhaWVVG?=
 =?utf-8?B?MklzZ01xL29aYnBrejRhMCtkUUpVYVVDU1F0ZlRjRzhhL3lPTzgrTFZoNWg1?=
 =?utf-8?B?SlpaeDBhTzEzYStXN2N4Rk5aMzhUT0ZZQmdSQ0xjbzBLWjN5c2cvNFN4ZlZp?=
 =?utf-8?B?TWxkMFBtMWRDZzBIKzdjMWVNQjB5VmlqblNsbm8zM1dXQS8zQmlnUVlYb0VO?=
 =?utf-8?B?S0tBUElnL3NGUUNVRk85d05QSER1UUphV1N1RFY0WEwxNnQzRDFvK054OElp?=
 =?utf-8?B?cy95TzNZNzlpSENxSUpKcVBGMldNcDNiaWFIZVpJY3lhL0VwSFJOVEExNVRX?=
 =?utf-8?B?T0xDRG1VSTM1Ync2dzFQaU1kbXNiY1BobTFPck1lODBHOHhqM2dwMUd0UHNF?=
 =?utf-8?B?dlZPREVHTndIc3hnNU5wUjZvcVJORVdJNjVkQUtVVk1HeVgzNkhTQVpIaHUy?=
 =?utf-8?B?TVVFL1RYMFZrWnROWXJaWWU5aGJwUFNwdy9mUzFTOFN4dGVEbStubm1maEJi?=
 =?utf-8?B?eW9OUFdkaUVpQ1pycWYyU3BUUkdkdHZ5bmZUL1U4REM3L2FObW5tT2xQS3Fw?=
 =?utf-8?B?Vmt2M3dsODVyeVROM3RBMFNjN0RYcThjclpwaTQydkYzK2xUaCsxR2ZubEpk?=
 =?utf-8?B?WStmMjhOdFFLZitEejVIaisvVERoSmt0VjlFdzBKNW14azVacGF4RmxyZzF6?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C565AAB9F53004D965AE5E2B13EDE54@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd4d2d7-9e70-4d57-427c-08da87b68d6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 22:58:55.2292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +52Gb8sP/poCeVM8YOhkYojEu+uzkLLqA4sZvQl5e3eq/2urkorAytmA/kzIbZDF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2603
X-Proofpoint-GUID: dgiXa-_uLO9j-V4iwwGY6qc5RH4Nwqlu
X-Proofpoint-ORIG-GUID: dgiXa-_uLO9j-V4iwwGY6qc5RH4Nwqlu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_12,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gRnJpLCAyMDIyLTA4LTI2IGF0IDEyOjIzICswMTAwLCBRdWVudGluIE1vbm5ldCB3cm90ZToK
PiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLXwKPiDCoCBUaGlzIE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5k
ZXIKPiAKPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ICEKPiAKPiBPbiAyNi8wOC8yMDIyIDAxOjM3LCBLdWkt
RmVuZyBMZWUgd3JvdGU6Cj4gPiBTaG93IHRpZCBvciBwaWQgb2YgaXRlcmF0b3JzIGlmIGdpdmlu
ZyBhbiBhcmd1bWVudCBvZiB0aWQgb3IgcGlkCj4gPiAKPiA+IEZvciBleGFtcG9sZSwgdGhlIGNv
bW1hbmVkIGBicGZ0b29sIGxpbmsgbGlzdGAgbWF5IGxpc3QgZm9sbG93aW5nCj4gCj4gcy9leGFt
cG9sZS9leGFtcGxlLywgcy9jb21tYW5lZC9jb21tYW5kLwo+IAo+ID4gbGluZXMuCj4gPiAKPiA+
IDE6IGl0ZXLCoCBwcm9nIDLCoCB0YXJnZXRfbmFtZSBicGZfbWFwCj4gPiAyOiBpdGVywqAgcHJv
ZyAzwqAgdGFyZ2V0X25hbWUgYnBmX3Byb2cKPiA+IDMzOiBpdGVywqAgcHJvZyAyMjXCoCB0YXJn
ZXRfbmFtZSB0YXNrX2ZpbGXCoCB0aWQgMTY0NAo+ID4gwqDCoMKgwqDCoMKgwqAgcGlkcyB0ZXN0
X3Byb2dzKDE2NDQpCj4gPiAKPiA+IExpbmsgMzMgaXMgYSB0YXNrX2ZpbGUgaXRlcmF0b3Igd2l0
aCB0aWQgMTY0NC7CoCBGb3Igbm93LCBvbmx5Cj4gPiB0YXJnZXRzCj4gPiBvZiB0YXNrLCB0YXNr
X2ZpbGUgYW5kIHRhc2tfdm1hIG1heSBiZSB3aXRoIHRpZCBvciBwaWQgdG8gZmlsdGVyCj4gPiBv
dXQKPiA+IHRhc2tzIG90aGVyIHRoYW4gdGhhdCBiZWxvbmcgdG8gYSBwcm9jZXNzIChwaWQpIG9y
IGEgdGhyZWFkICh0aWQpLgo+IAo+IHMvdGhhdCBiZWxvbmcvdGhvc2UgYmVsb25naW5nLz8KPiAK
PiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogS3VpLUZlbmcgTGVlIDxrdWlmZW5nQGZiLmNvbT4KPiA+
IC0tLQo+ID4gwqB0b29scy9icGYvYnBmdG9vbC9saW5rLmMgfCAxOSArKysrKysrKysrKysrKysr
KysrCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspCj4gPiAKPiA+IGRpZmYg
LS1naXQgYS90b29scy9icGYvYnBmdG9vbC9saW5rLmMgYi90b29scy9icGYvYnBmdG9vbC9saW5r
LmMKPiA+IGluZGV4IDdhMjA5MzFjMzI1MC4uZjk2YzE4YmI3YTQyIDEwMDY0NAo+ID4gLS0tIGEv
dG9vbHMvYnBmL2JwZnRvb2wvbGluay5jCj4gPiArKysgYi90b29scy9icGYvYnBmdG9vbC9saW5r
LmMKPiA+IEBAIC04Myw2ICs4MywxMyBAQCBzdGF0aWMgYm9vbCBpc19pdGVyX21hcF90YXJnZXQo
Y29uc3QgY2hhcgo+ID4gKnRhcmdldF9uYW1lKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzdHJjbXAodGFyZ2V0X25hbWUsICJicGZfc2tfc3RvcmFnZV9tYXAiKSA9PSAwOwo+ID4g
wqB9Cj4gPiDCoAo+ID4gK3N0YXRpYyBib29sIGlzX2l0ZXJfdGFza190YXJnZXQoY29uc3QgY2hh
ciAqdGFyZ2V0X25hbWUpCj4gPiArewo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIHN0cmNtcCh0
YXJnZXRfbmFtZSwgInRhc2siKSA9PSAwIHx8Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgc3RyY21wKHRhcmdldF9uYW1lLCAidGFza19maWxlIikgPT0gMCB8fAo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cmNtcCh0YXJnZXRfbmFtZSwgInRhc2tfdm1hIikg
PT0gMDsKPiA+ICt9Cj4gPiArCj4gPiDCoHN0YXRpYyB2b2lkIHNob3dfaXRlcl9qc29uKHN0cnVj
dCBicGZfbGlua19pbmZvICppbmZvLAo+ID4ganNvbl93cml0ZXJfdCAqd3RyKQo+ID4gwqB7Cj4g
PiDCoMKgwqDCoMKgwqDCoMKgY29uc3QgY2hhciAqdGFyZ2V0X25hbWUgPSB1NjRfdG9fcHRyKGlu
Zm8tCj4gPiA+aXRlci50YXJnZXRfbmFtZSk7Cj4gPiBAQCAtOTEsNiArOTgsMTIgQEAgc3RhdGlj
IHZvaWQgc2hvd19pdGVyX2pzb24oc3RydWN0IGJwZl9saW5rX2luZm8KPiA+ICppbmZvLCBqc29u
X3dyaXRlcl90ICp3dHIpCj4gPiDCoAo+ID4gwqDCoMKgwqDCoMKgwqDCoGlmIChpc19pdGVyX21h
cF90YXJnZXQodGFyZ2V0X25hbWUpKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBqc29ud191aW50X2ZpZWxkKHd0ciwgIm1hcF9pZCIsIGluZm8tCj4gPiA+aXRlci5tYXAubWFw
X2lkKTsKPiA+ICvCoMKgwqDCoMKgwqDCoGVsc2UgaWYgKGlzX2l0ZXJfdGFza190YXJnZXQodGFy
Z2V0X25hbWUpKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGluZm8t
Pml0ZXIudGFzay50aWQpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGpzb253X3VpbnRfZmllbGQod3RyLCAidGlkIiwgaW5mby0KPiA+ID5pdGVyLnRh
c2sudGlkKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoaW5mby0+aXRl
ci50YXNrLnBpZCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKganNvbndfdWludF9maWVsZCh3dHIsICJwaWQiLCBpbmZvLQo+ID4gPml0ZXIudGFzay5w
aWQpOwo+ID4gK8KgwqDCoMKgwqDCoMKgfQo+ID4gwqB9Cj4gPiDCoAo+ID4gwqBzdGF0aWMgaW50
IGdldF9wcm9nX2luZm8oaW50IHByb2dfaWQsIHN0cnVjdCBicGZfcHJvZ19pbmZvICppbmZvKQo+
ID4gQEAgLTIwOCw2ICsyMjEsMTIgQEAgc3RhdGljIHZvaWQgc2hvd19pdGVyX3BsYWluKHN0cnVj
dAo+ID4gYnBmX2xpbmtfaW5mbyAqaW5mbykKPiA+IMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYg
KGlzX2l0ZXJfbWFwX3RhcmdldCh0YXJnZXRfbmFtZSkpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHByaW50ZigibWFwX2lkICV1wqAgIiwgaW5mby0+aXRlci5tYXAubWFwX2lk
KTsKPiA+ICvCoMKgwqDCoMKgwqDCoGVsc2UgaWYgKGlzX2l0ZXJfdGFza190YXJnZXQodGFyZ2V0
X25hbWUpKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGluZm8tPml0
ZXIudGFzay50aWQpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHByaW50ZigidGlkICV1ICIsIGluZm8tPml0ZXIudGFzay50aWQpOwo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVsc2UgaWYgKGluZm8tPml0ZXIudGFzay5waWQpCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHByaW50Zigi
cGlkICV1ICIsIGluZm8tPml0ZXIudGFzay5waWQpOwo+IAo+IExvb2tzIGdvb2QsIHRoYW5rcyEg
SSBub3RlIHRoYXQgeW91IGhhdmUgYW4gImlmIC4uLiBlbHNlIC4uLiIgaGVyZSwKPiB2cy4KPiB0
d28gImlmInMgYWJvdmUgZm9yIHRoZSBKU09OIG91dHB1dC4gQ291bGQgeW91IHBsZWFzZSBtYWtl
IHRoaXMKPiBjb25zaXN0ZW50PwoKU3VyZSEKCg==
