Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB234B281E
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 15:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343791AbiBKOk6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 09:40:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240287AbiBKOk5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 09:40:57 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120052.outbound.protection.outlook.com [40.107.12.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C948B188
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 06:40:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fpnyx9zkaWMSUsNp4kBiOvoOtQNA0fe9U2bZRsh+lCWspPEmPME/qOCCqVw4FhWmB6dy1BW04rcoG3ECFWwFvaK8ED+0Tr7FytqK6A89yaqTLRiExpj4YITJkqFh305Cy2K4aEVAY8yDTQ5QXxiIsrRakkIjpsqlxS83KpvpQdlDL77uUcgB7l7am+BRUdizrx9QHDPVr2IZKBSwKZ9cDlM95GLcIFoPxg79dNdeskDxktdQoo7+iEbudUAAV2j6nGf1C2ibXEoSLWWW3YrYv4iY4/2iSSpW4Ez/kGnLQDRad/RnXzhAeE6/Lh6uAqkwOelZkACquVYwo0hz04Fecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teqS40ATljObvx9yV3MzqGApTUSz1Q8V8A0TLlgp6rA=;
 b=dydq27cUqEvqFxU/+r0lmuSMPTvo5ePwccqzEH8kLH3+Rv+hpIYLlvqRVHuHfm+Pqs9JA+sb7KSty8rhEzaJUKu3J5uX8g6f41QGTPUamGWl4qLGI8WEJMgdxmR/zCEK2OEpKVphK/aAE+StALGPQzkT5245qk65Xlya12VciKXZi9LD71tWZiSJqJE8Lx55fC2XGbkcE0h4KtglHCrezNR9cTZ3f2ybEuLYMIhqTZfIT6myHeOcud9x+0glOCJAr0mwzYGaE1cRMUciEM+t168zcmZsdCRi+CsmiDFerllcPdKEpZlMmjHbfVklAn6zEy/HaoH7mUJpqGsTH18nFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2882.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:37::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Fri, 11 Feb
 2022 14:40:49 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%9]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 14:40:49 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [RFC PATCH 0/3] powerpc64/bpf: Add support for BPF Trampolines
Thread-Topic: [RFC PATCH 0/3] powerpc64/bpf: Add support for BPF Trampolines
Thread-Index: AQHYG/GPWbNig1tz50Kf4rwZD273ZayOctWA
Date:   Fri, 11 Feb 2022 14:40:49 +0000
Message-ID: <918b842d-f674-bbdb-c772-b43a00f1b155@csgroup.eu>
References: <cover.1644216043.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1644216043.git.naveen.n.rao@linux.vnet.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a0e6860-e776-4ad8-bae3-08d9ed6c7f36
x-ms-traffictypediagnostic: MR1P264MB2882:EE_
x-microsoft-antispam-prvs: <MR1P264MB28825C9E620EF9CFDF23C4C0ED309@MR1P264MB2882.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: apocuxWa5y0DdJ7llkveyz7QPqwG245lr2t34Eq5IVuHYTAv9YGDPsCJ3nNvKgBCZscMpyImSP8t+xZR5+nANQRYHU1tv1OPT+uH6zH0Wkb+ohaRgJAwZf9IJIwYtwATq4J2Okw45RsjFN2dw+TMr+sff9WOhJVZ0/GFY940vK3T4fmLeZ116RuElpqSFLLkwY1J4H4wgN8FkdFQcSRYq3/6Rg4jLN+Ttqm4A/lk5KfnZqgwolHj+wF4LDhzFoMcsQbeP8kHVbJSng5IL5/GApvSZ8994LOkTSwGYncoNawOx7lO4Nepo2uxuciK/xJMYHRnl85Lo3x8dPiuGYK6782JYvSrr7AGJZopjRTP4m8xOM2C9Xmi1rKXTBlWGD/HjiBDFLkzjHUJnyCQmJzZLll1eH1zdlCdexu+AJgk04Gh4txCFFIez8gO8Fp1VIPa2LleSkUDcbziSSeBr4NLOw0qb9pnPlN/09DCuvMmmudiDWJsLbD9E2zniAjN7kMFp0kNsmD7rR/zh8FOOSnsbU8rwXTOlL53ZvvLN+FvUwB45kGHYzaMNNCZExzcuK5SW1RwAVsqYSWBVVqifslJINbQbT7fnJ2i2Vw0M4O+tBjG/FCbpt/0E9vRRda4N/N4w07z/cN11e0Rn1B9xLJ9msojS5V0ai4bzkbFTJnqxkO86D5uinqo09J3sID/weQjbCj79/2H2FjTsRuSpkwsIIhhRr8hYRHqw0sCZIQiJ/IrWtMeZuF586CiOuxeAGJXDh0nC/DeHzKpk/VlGDiaGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(6506007)(38070700005)(66946007)(76116006)(6486002)(6512007)(64756008)(8676002)(66476007)(31686004)(8936002)(66556008)(36756003)(66446008)(54906003)(316002)(110136005)(186003)(508600001)(44832011)(86362001)(71200400001)(26005)(2616005)(38100700002)(66574015)(91956017)(4326008)(2906002)(83380400001)(4744005)(122000001)(5660300002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTJFclEwWDJZSXdjYkI5bGpkMXZOQkNlMjVmS2Q5b0d0TS9BWFJFcU9KcVBY?=
 =?utf-8?B?S1FLbFFKZTNtVHcxTlR0d1RGTlRUZG9XNURjdDRoRzRnMkhqWGIrYmZZS1lt?=
 =?utf-8?B?dUM1YnRKRmoyazBtUVoyNVJvbm83d3ROaDFicTh3UWtoVnVoVHljS3RtTUtt?=
 =?utf-8?B?Y0pNbWs2bTRBays3Qkh0dmpHbTVnWm1BZlF3R3MxVFpwV1o1ZXVTcGduNThh?=
 =?utf-8?B?a1IzSUtaMFRvNDliQXlUV2xhRFZ6cDM1THZGYi91MWVYOVFLV3JVaDhscWhH?=
 =?utf-8?B?Tjk2NHlSb3JGYVJSOTExeml0UGxXcXBIYkJ4WTc5d1ZTcTBVRWFhR3lUN04w?=
 =?utf-8?B?OUdBVUloQTZ1eEtOb3VocTRBczVkVDQzcFkvSmZtV3d6TE5kMHg0OFE0V0l2?=
 =?utf-8?B?SUh0MnFtVjg3bGNNQm5QUW02ZGdlQ1lmLzlXelR6K2xtQUtQbFdDZlRGVnFF?=
 =?utf-8?B?UUJWL0c0Y3Q0S2NnNU5uQnRUK3F3WTFtZDVybDBCZTdObzF2ZHJOelpyNkIx?=
 =?utf-8?B?K2RrWFExYXJhbnp1eWpnb1QxVzZkM0hxdTQwbGtjNHlTRlFoYW1XbkpDUjE1?=
 =?utf-8?B?M0k4d2hiWjhld1RFQm5ZL2RtUmJDNTJUMTdqRzF1ZE1jdVhqYU1mcXRGTElp?=
 =?utf-8?B?SjhXVE1DUWkvWW8vSnpGblJ4Yk1NbFRBc2FuTDlWUFNUNitHVnA0R0FwbXlL?=
 =?utf-8?B?TUw2bExxOFdwWVNyaGZaV1hjZkVhajF6cHpCekRuWXc3MS9nL1VpekhpRHV3?=
 =?utf-8?B?bXRxL29Wc2dlbklIWW1YRjhnMllFMFNkejN2MUFYUS9waTJxa0M3VUZlNkI2?=
 =?utf-8?B?WllsZWt5S0NpOXpYamE0K3UwY2pPYnV3Qjl6VmhoWi8vRHJpQmI5YzY4bDBo?=
 =?utf-8?B?OFo3ajAxbGhjUnNvTjR6UklmOUZzTVVkRFV5Zkt4cHZzVmhvaHRPRFBsUlJN?=
 =?utf-8?B?UCtMNTRkR0Q4dHloRlFOUy9WdThDM0JSQm1MbXVtZGhPOThFMnpUaWx5cXhH?=
 =?utf-8?B?U1BmbWgxNFVxSGR1cDl5a1JFQ0o5SzlHMzFXSG5YQXlRM2F5Vkg0K3lvcTdP?=
 =?utf-8?B?L3lxLzJ0QzhIVmNteG9wRUlsMlFKWDlVTDdYRXF2YkppRGVBZm01U1NIN3A4?=
 =?utf-8?B?SHhOWk9WWWpNZ0FUempHMUtIZkRhT0Jiem5tNzJvaUlrODBKbWtIL01aL29H?=
 =?utf-8?B?TG9lQ2lBb2ZqZ0ZrbmV6Q3lYWWZJVS9SbStwTFIvM0RaM2NTWDB1czdjVW9K?=
 =?utf-8?B?TkFBTnUxS0tXaDZpMXlITVRWaFoxWW84cXo1Q242YjdHWkdUbC96ZnQwYXh6?=
 =?utf-8?B?RzlLR2F4UjBJVGVQWDFicHlGNXpIVVRlbUFJVDZ2VVNPU3BIcGxVVDBIMFZq?=
 =?utf-8?B?RklJTFZkUHZYOVVYMWFWVExVNUkzTGw1cWhFdkJsWW1vVzUrQ2Q2Q2x0dSts?=
 =?utf-8?B?LzJyWFB3UFdGY1FSMDc4MVVLV0JrRFhjZ2hJdnluVDVsY3pqSWxPejFHay81?=
 =?utf-8?B?cG4veEJYdUhaTlVXQUJNMWZSYVRrUGZxMEp6MzI4aS9nZ2l6emVtNmlnTVhl?=
 =?utf-8?B?ejhuc0lLSks2NXdPZnI1NjVRMGlwZnpleUdlWFE3cHpqVkl3alRWQWFHNzR1?=
 =?utf-8?B?WXp4SWs2bVBDSm52RndZcnl5c1liMlFuM2FTdGJvbThxZkw3bWwxanBrK3BE?=
 =?utf-8?B?K2V3SityaG96MnNOUWxtb3FkQkgyRHFOdVZpeW1XUEg1SFczU1dNc1BKTExP?=
 =?utf-8?B?YVNwZTVyY3NmSitPZWtReExybnA4MWFubnlmdXlPSzR5cXRwaUI5azJmdW43?=
 =?utf-8?B?MzVTVGY3Ykh6bXNnWE9lVUhGVjVad3ZPaXpyTjRQbnRIV1FyR09CTU0rRTk2?=
 =?utf-8?B?YXFtU1JFY3BWeHZIekxMUk1pc1pSZXhZTHRnM1ovejJJV2FVU3huR3g1cnRQ?=
 =?utf-8?B?VU9iSnJFYUlyakVXU3lxcG5xVHJLN0RoUkh3OUI1emlLcFNrcHFyQmE3RUpK?=
 =?utf-8?B?bEFLRHJZNm0vbGFjaGQxcVBib2hQUmtXU3kzMklJMFF0NEVhSWRjTHdkcXRi?=
 =?utf-8?B?VjdsY1MyRkZFZm5Lc2MxRGoyV3RTclVtb2hJd1VuVzBQUnBOWC9OVXZTSlBN?=
 =?utf-8?B?dHI5SzRGbElvaFVMRGFvUnBlYVQxQXJ0cUZ3SmZzZC9yOFcwV3VzVThFZW5o?=
 =?utf-8?B?MWtGb2NXc1RqUWZxdFU2Rjl4MDEzNWF0K3BBQnFpNm13bGl5NWxLaThFa3Rs?=
 =?utf-8?Q?RDnyqh4UZFq1p16eE5GsdFXIh4K6Xs45UunqFI+v50=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <184AB79BD660DE4BA06144E1A52B842B@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0e6860-e776-4ad8-bae3-08d9ed6c7f36
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 14:40:49.5484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0hSa1Wi6qzoieZzhKFQ1ipfOV/rI3mpQo17WFMx/JkREU35X1L/CJVQpPSqZgBb9HihPZt30Tt3b51AlM7O7wOAlDzYtIAFzDl2+4bu5b/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2882
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCkxlIDA3LzAyLzIwMjIgw6AgMDg6MDcsIE5hdmVlbiBOLiBSYW8gYSDDqWNyaXTCoDoNCj4g
VGhpcyBpcyBhbiBlYXJseSBSRkMgc2VyaWVzIHRoYXQgYWRkcyBzdXBwb3J0IGZvciBCUEYgVHJh
bXBvbGluZXMgb24NCj4gcG93ZXJwYzY0LiBTb21lIG9mIHRoZSBzZWxmdGVzdHMgYXJlIHBhc3Np
bmcgZm9yIG1lLCBidXQgdGhpcyBuZWVkcyBtb3JlDQo+IHRlc3RpbmcgYW5kIEkndmUgbGlrZWx5
IG1pc3NlZCBhIGZldyB0aGluZ3MgYXMgd2VsbC4gQSByZXZpZXcgb2YgdGhlDQo+IHBhdGNoZXMg
YW5kIGZlZWRiYWNrIGFib3V0IHRoZSBvdmVyYWxsIGFwcHJvYWNoIHdpbGwgYmUgZ3JlYXQuDQo+
IA0KPiBUaGlzIHNlcmllcyBkZXBlbmRzIG9uIHNvbWUgb2YgdGhlIG90aGVyIEJQRiBKSVQgZml4
ZXMgYW5kIGVuaGFuY2VtZW50cw0KPiBwb3N0ZWQgcHJldmlvdXNseSwgYXMgd2VsbCBhcyBvbiBm
dHJhY2UgZGlyZWN0IGVuYWJsZW1lbnQgb24gcG93ZXJwYw0KPiB3aGljaCBoYXMgYWxzbyBiZWVu
IHBvc3RlZCBpbiB0aGUgcGFzdC4NCg0KSXMgdGhlcmUgYW55IHJlYXNvbiB0byBsaW1pdCB0aGlz
IHRvIHBvd2VycGM2NCA/DQoNCkNocmlzdG9waGU=
