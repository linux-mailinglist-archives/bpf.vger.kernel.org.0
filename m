Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE7E5A7339
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 03:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiHaBLV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 21:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHaBLU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 21:11:20 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1325585A82
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 18:11:20 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27V0pv6p029599
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 18:11:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=U7mc3ONri6CrSQ9OzCAdceULRD3utA3QUiMqjBuqqX0=;
 b=oPQVXatPeNt2CKWpNh9ss6RdV61p/aqnAL5Rgv8kJ7HrY7YWTYw91YBrNwRdA5LDlILc
 gaPZ9dN5ZVyWaT/2eMnNnpdbMUkr9tFrrJDIYaW3bHX+Y4Luj49EId52BpaDYFu6frbN
 MTio0DwBsysOhuD48Nd1KOmVpp3fwu66SwA= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9a6j6ngh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 18:11:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/OPGlDKPRR4BuLmG5JIR/snXLEbU9zxQ3twzQKz9UsXmcxL40VPmeWJefmsGk7o0x7qqsFtFlSW8FqIf1PUpdVVoD2+wgCy9o7AdojN8ExUACc6vZAOuLsHcCpjEsj59epjGAAtCjhISeGL1F77Z5qnn4lF2IFyBNdLI4HG8V4IK7kLhaxHUXld+/aw8DhCRPAMeF6hvW94ff1gFITitzCAQbjdyu9rqQMYRbOEx+Tcq8Wd6TCjZX3lspE9TqH8zHumJeb/grv1DR4GLdYbpDjQwtCwqteQKPM3jBM2NUBcOOh78U9MwDZzHyD00TWZderHuDyYmks28NwmakAFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7mc3ONri6CrSQ9OzCAdceULRD3utA3QUiMqjBuqqX0=;
 b=Gqg0rxuoU7fU7d05GQSMmJ6El/8EHCjhrOXFEQtjwfpdG4TETmz45ZlegMnD//nyOf7N2W597bjJgD62jMTwMTZa0he7AbUBX7vu7p8lRsM81BshJTVAurCWDF4v1Wq4T29ICY1lkBdgzmJzCfLeS4TLAXstM53Kp5RskaOQHwZp5MI2c46TgGhA5s6UkePtByNoCRY6rH+kWn9LGvrmG8REYem4J5uzfOulrD36NeyPoivljV3w72mZlOCguf7X2813ZYbReIEOAvKSp+WVKH5EKcMro3NwJ/ScuhakE7/94z+xJ/87cUCQ5QnYZCEOHuBC7IgJnQ47s4PhXH/buw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by MN2PR15MB3360.namprd15.prod.outlook.com (2603:10b6:208:39::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 01:11:16 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::8fb:578:a3da:40ce]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::8fb:578:a3da:40ce%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 01:11:16 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v8 5/5] bpftool: Show parameters of BPF task
 iterators.
Thread-Topic: [PATCH bpf-next v8 5/5] bpftool: Show parameters of BPF task
 iterators.
Thread-Index: AQHYu9zdKf5FVjH530y9Tzu2bSbSsq3IIImAgAAU3IA=
Date:   Wed, 31 Aug 2022 01:11:16 +0000
Message-ID: <abba7eb0540bda61c653fa42abd3bdd552438208.camel@fb.com>
References: <20220829192317.486946-1-kuifeng@fb.com>
         <20220829192317.486946-6-kuifeng@fb.com>
         <56e56327-cfed-3e78-84ca-db45ac5662c9@fb.com>
In-Reply-To: <56e56327-cfed-3e78-84ca-db45ac5662c9@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f513c34-ea3c-4a01-8bc3-08da8aedb48c
x-ms-traffictypediagnostic: MN2PR15MB3360:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xEX9meOPiD1tf0rw6ZXkLjt5p/tvxRnM1hl65bWJkrKIv0XjX78Q3CpNL2qad9+gcoTihs/3d6RcwwgNymi6RK8yPOIUqaU/TOR0tWpRmAOYNEDtl3JRHP1oxU2yhtsCgjPBK2XtJLutkMIid/gJYaGN3tlsELuW4x8C8LXGJzgxLptjxVZZUMfruKZmkxUon8WLap+OwLBilj4WqZ7uULUXGbvKVwt6F9UqTurz51ckqoZOkl6XQUveySkigyC8d/8Aru9UUJ3Vw/NiB7nRxUdj1h8jEhieD8BDLlT1N/DqOGcL/UNluXOjbgt7rWd/aYSfVOsecTtgPTQCyzX1FihWgIkUFPizowPUkg1b5c6GnXhc3R4zyOKGD9R0k65PbDEAcR9JloGSxa7WVQDpXOJMwbEpmbjADU84FPbkF5NziqEm7oixSBJY0G7PDGb0yixaQokRA/iIrhN7M1UqkkkNMtptYfHxuTh9Kutq9Odc6Q7pAUhctG72myiELF8pUR06D/4sFV8wQrnNLBTIvzsiWjMyTA4PXOjy8rGNc9nJnlwGwAD4+qto57dAzLN0OfI1yRv2D4dhx4QYDNINCcK0x0Qe8c8m30ctMLx4gZBD72W7CGrpmEDY4jugDwBkrJ6QTEugK/549MkHszEHJHBE51qius0gJc30mBlRoc3raZXsKyLg6ykSCxLnGIAXtMawz3Y+DKC3OBQ9KtTYHtjmeSIIq6nW6PIMoFg14SOeXoYqDChaV/HI7cGTtF3mnfeSYqfGOZLVFQlbyJ6dwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(71200400001)(36756003)(8676002)(8936002)(76116006)(316002)(110136005)(186003)(6506007)(66556008)(64756008)(66446008)(66476007)(66946007)(6512007)(478600001)(122000001)(38100700002)(6486002)(41300700001)(5660300002)(4744005)(86362001)(2616005)(38070700005)(2906002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEV1YWxMOHFQNE1nRjM0TU9VYzZycHJnUkloc1VBRnNvR3pXRndNVzJwUVAr?=
 =?utf-8?B?N0pLNTRuNXlDZGFHOTFQL1Urc2MxL3VudjRja2Q1RDJhK1NNVGludzJPUnVz?=
 =?utf-8?B?cXJFVFdPZ2U0bk0xNkl1dW9uK0hwOUFhUC9kSTdNSXdDZFlvd1BRREhSVWxC?=
 =?utf-8?B?UnZCS2tYbGtmTmE3ZUZObkJLVmNqWFIraEN2Tlh5TUtiZ3JJTTNWUStaL3FF?=
 =?utf-8?B?RU1WMFd5SDVlQ2xCYTBRa1U1Ym5mbnN3dWxSVUVNL0NjV05iQmxEeUk2aERZ?=
 =?utf-8?B?blBsVnN6aTNvRTlXclA5emNmYWhCbHp2LzIrcGEybC9Ua3ZIYXYvMjJtTHJw?=
 =?utf-8?B?OHJzQ3JUamhHQUpGUTIxdVY2ZXNqbmpNTDdzcGZqbWlVSTVvb0tCOG1jY2Zw?=
 =?utf-8?B?OU5NNTBUbG0rNGVySm4vb0ZpbjZsVkVZTVFrSlVBTmNjOUlqRFdHRHZ0VjBO?=
 =?utf-8?B?Z1pzdnNFRFh6TmNMcmhWYTJtRTFDU05GNnVVSldpMHRBbzdxdFMxcWRWYng0?=
 =?utf-8?B?RDBuOWVUNXFpVGJTSFBUbnhGK2pDRm5UTzJ6dVhEbWlYQnJSNEx3S3crbm9q?=
 =?utf-8?B?K1g2YW9acHBrczZnTUJYMmlJbnhDY2gyMDJPaDRpUE1zQkJMZTIzZVBqMmN6?=
 =?utf-8?B?QVJwNk1PNFlFWWRNZzBwSUluQmFCUld1ajgyc1RxbzNqMU9aQ1FqWUVkZ1lJ?=
 =?utf-8?B?Q3Y4UFNCUTRFVVp3R3RabnZ0cktQOUJRcHpwMS80K01qbmxiRktiQ2ZkQmpw?=
 =?utf-8?B?d2dKekxMOW1UUTg2Zng0d0lrOVVjZnJybUUvc0ZzS0dpN1VpTlkrYmdYTWFU?=
 =?utf-8?B?MjZNanlHQVR6ZWpNd3hlekhiSURKa0E0WEpPdXhwamxFOTIvajFBTEY4aXdV?=
 =?utf-8?B?c0Rmc2poRHJSeFlQNGY0Zk4zYXp1dzBRejN2M1c1Z3ROWDdkYTU4aGpqN1Jv?=
 =?utf-8?B?VVFuUzlXcXlUTE04aWxSa0FxL0dQMFF6emNIa3lockZiWGp4UVppbHlHTWdU?=
 =?utf-8?B?NC96dzJVbHVrNzVJV1lwT005RVMzSEJvWlBVamRJUDBQeDBqNVMyVXhnbmF0?=
 =?utf-8?B?cHYrTkxvVVZUbmNnMk1pRHg0Szg0c05WbTFqRVk5ZDRRYXg1dWdjMy9mdzV0?=
 =?utf-8?B?c2JlbGhSZFo5RGM4aVB0c2NYMjYwN2M0QlFQMzNuc0NRcU11TXlrNlF0KzVU?=
 =?utf-8?B?cVk3QnZEd0lZbjhmNjkvbnRJRTBwcWxiazlkL3RrUThLRW9iYjMwVUZjTVBx?=
 =?utf-8?B?bXpOYmFJYU1adVAvNDFtQ2JMa3Uvdnd2UytCaHkzdXJwNU1zU3lUUnRIcFM0?=
 =?utf-8?B?dDl3Wlc1VExPTXBaZVFQUjMzK2h5UzdjNmFMb0p4UW1xdnNnb0NmZVRoejN4?=
 =?utf-8?B?L0tPcXY2RWJNaGhIWVd0THh4aGJ2bDZKZ0lXSGprbmRkeUU0VDZuUjJVZURK?=
 =?utf-8?B?TnRwV3ZDMWxnMFRDbk5JM0xZWkt2TFhDdmYyU2JkWXY2WHFIM2FnOG5OcTNH?=
 =?utf-8?B?dElxYUtXVWtRNW9YNTFiS3BRSkJzS2kvNHI2cmdRS1ZQT0pydlVHZlFNUW5x?=
 =?utf-8?B?WTFiM2tKQ3lmcSs4akladU0ya1Jjam1PTlFLKzBCclNDeW5zY0Z0Y0dTRHc3?=
 =?utf-8?B?Z1RPNWprR0RQS1NTOTE5YXdERXV0UTJvWHA4QlhLZEh4KzQxejdzZUNFTFhk?=
 =?utf-8?B?cVQ1bis4dlJhczBkTUlsczVGR24wRmQwMDUxQ2ZzMFdhN1pWQWtkenM2RHBr?=
 =?utf-8?B?anpzeUlZT05pVnkxR0VNNmo5RWxONldQc2F3UWxPVHJoWFpaUTRRczMzM0x6?=
 =?utf-8?B?U2lrbDhRNExyYUVOZXh5aE5xeURXeVd0TnowZGZ5NHh4blNTQVZja205UE5I?=
 =?utf-8?B?WjBUajFJYnY4bnJPUllodlFKRVFLcTE2N3NMYVFYbzI3c3ljMi96azhrN0Nk?=
 =?utf-8?B?RWpVUUF3aGw3MVlYK29xbGpzSEdXMVdrSUNxRmZOckxCa0pwUW55NEZOa3Qy?=
 =?utf-8?B?R0JBWmtvV0VscHAyOE9GOW5wMWV3d0g4R2J4L21zNURjQ0lnNEV1ckppVGVx?=
 =?utf-8?B?SXBkUmZZeVZtbFphUWxlaGk4R0lSMmgzU1pwL0VVM0dRczJTN3d6RVN4SFcy?=
 =?utf-8?B?Vno4QkdTNzRsVmVHazU5dWRnWEJRamFXSEd4eGRrV0VnZTAzd2lIVlNzWUNk?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05AD5EC636D4694AA5F44F6D69F7ECF4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f513c34-ea3c-4a01-8bc3-08da8aedb48c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 01:11:16.7182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e7uqLSZhRx9Qwa2w/zIJon21xJWxtApiLE6DplooLs/nM6DOFcsJLU+Fj1GnR2RX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3360
X-Proofpoint-ORIG-GUID: 3uLyZWSua9JbY0yGeEqQOTONxPJ-UFZK
X-Proofpoint-GUID: 3uLyZWSua9JbY0yGeEqQOTONxPJ-UFZK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_01,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTA4LTMwIGF0IDE2OjU2IC0wNzAwLCBZb25naG9uZyBTb25nIHdyb3RlOg0K
PiANCj4gDQo+IE9uIDgvMjkvMjIgMTI6MjMgUE0sIEt1aS1GZW5nIExlZSB3cm90ZToNCj4gPiBT
aG93IHRpZCBvciBwaWQgb2YgaXRlcmF0b3JzIGlmIGdpdmluZyBhbiBhcmd1bWVudCBvZiB0aWQg
b3IgcGlkDQo+ID4gDQo+ID4gRm9yIGV4YW1wbGUsIHRoZSBjb21tYW5kIGBicGZ0b29sIGxpbmsg
bGlzdGAgbWF5IGxpc3QgZm9sbG93aW5nDQo+ID4gbGluZXMuDQo+ID4gDQo+ID4gMTogaXRlcsKg
IHByb2cgMsKgIHRhcmdldF9uYW1lIGJwZl9tYXANCj4gPiAyOiBpdGVywqAgcHJvZyAzwqAgdGFy
Z2V0X25hbWUgYnBmX3Byb2cNCj4gPiAzMzogaXRlcsKgIHByb2cgMjI1wqAgdGFyZ2V0X25hbWUg
dGFza19maWxlwqAgdGlkIDE2NDQNCj4gPiDCoMKgwqDCoMKgwqDCoMKgIHBpZHMgdGVzdF9wcm9n
cygxNjQ0KQ0KPiA+IA0KPiA+IExpbmsgMzMgaXMgYSB0YXNrX2ZpbGUgaXRlcmF0b3Igd2l0aCB0
aWQgMTY0NC7CoCBGb3Igbm93LCBvbmx5DQo+ID4gdGFyZ2V0cw0KPiA+IG9mIHRhc2ssIHRhc2tf
ZmlsZSBhbmQgdGFza192bWEgbWF5IGJlIHdpdGggdGlkIG9yIHBpZCB0byBmaWx0ZXINCj4gPiBv
dXQNCj4gPiB0YXNrcyBvdGhlciB0aGFuIHRob3NlIGJlbG9uZ2luZyB0byBhIHByb2Nlc3MgKHBp
ZCkgb3IgYSB0aHJlYWQNCj4gPiAodGlkKS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBLdWkt
RmVuZyBMZWUgPGt1aWZlbmdAZmIuY29tPg0KPiANCj4gUGxlYXNlIHJlYmFzZSBvbiB0b3Agb2Yg
YnBmLW5leHQgYXMgdGhlIGJwZl9pdGVyIGNncm91cCBzdXBwb3J0DQo+IGlzIGp1c3QgbWVyZ2Vk
IHdoaWNoIHdpbGwgY2F1c2UgYSBjb25mbGljdCB3aXRoIHRoaXMgcGF0Y2guDQo+IA0KPiBBY2tl
ZC1ieTogWW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNvbT4NClRuYW5rIHlvdSEgSnVzdCByZWJhc2Vk
IHRoZSBjb2RlLg0KDQo=
