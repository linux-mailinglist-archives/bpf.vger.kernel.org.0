Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AF25A8469
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 19:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiHaRbQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 13:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiHaRbP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 13:31:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC6824087
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 10:31:14 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VGmld0011830
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 10:31:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=D3kpDt3pilsZ2LGUtBak3GjPjBv3cTLAp/WK0yRrriE=;
 b=NIw4HUIxwpVxfldW1DRR5Ldy8qyQhsA33FZ9CY1jHsBw4AAlN2oq2kbKITVTXGokNfiF
 +fU2ArjWdgD3ELANAUKhVMvlCYAb2bjEZao5apTz6fMeEcIBKCUEd+mQzaLjt8tRIYMo
 Uya/TRoL0iIqsLV3Q2JkdBZMnc+XC3VXQoA= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9ae4kjmb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 10:31:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X50DsFb7TPc2uTwrSwviYAa1Pfi2chmdA8Z4vQKyL+cjZW3676ghEUnu8FD0vWml9lIHLAT20B7LLnJy8W2JSNArNC09nrkGp8nUt+aEGNDcQJvqoznzQkgCriMyUxHXXlH0LejlIeeNo0gbQUiZ5OiHjx3q/32GgngVP/rrVGwmaJX/i4L9XrmuZ59Q8nTUBb+pp64USl3JE/GE5kyI4UzC1o8ChfWOm+DJQT5MWOE9GpXKiFpj5XnTOZ5goiWj0sBAFqaWkEdx8OdWt1fy0yVGNYZqUd2vXKZE7GpLXbofIlzibc6HS1TgrzweIwGiLQZYWFGWMHUWOX6v+OWSqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3kpDt3pilsZ2LGUtBak3GjPjBv3cTLAp/WK0yRrriE=;
 b=ASgRXcrhgwAzaz4b1Au/3sv4DOauRHO6QXiKZiJpj4Ye0oCoMaMOj87fevRUwpIze0zj7okNjhXNY/WyQ0Dz9EcM/C7M3Qw7vyk5L0yL8dq/X6CwnjlwCXXz92TZd42V1VK7mqxtapUmy+psVBvO4ujM5ibLSq4JDG/iBSi8hZZnxbxa5d8toVp3xfxNEx3XW0Nn3RU8PH11Kq+ZCdHCF2Hx4DBwEonH2mQO4umWPkdSyVwO6pQc4caVhLF9iJU07COHo7njJhfL0No7TlYvGXQu50g51JrsrkcOB6t9Hod+3nuvB5FRvzqHONuCPsJHMs1XZF9kzO5cduNGSHjvzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by PH0PR15MB4750.namprd15.prod.outlook.com (2603:10b6:510:9c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 17:31:10 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::8fb:578:a3da:40ce]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::8fb:578:a3da:40ce%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 17:31:10 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "olsajiri@gmail.com" <olsajiri@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v9 0/5] Parameterize task iterators.
Thread-Topic: [PATCH bpf-next v9 0/5] Parameterize task iterators.
Thread-Index: AQHYvOK8cJNKWutpCU6L95Ek/F5ofq3I4O8AgABkNYA=
Date:   Wed, 31 Aug 2022 17:31:10 +0000
Message-ID: <877be66f99a4981dd9645657fa92466807701d71.camel@fb.com>
References: <20220831023744.1790468-1-kuifeng@fb.com>
         <Yw9GzoOhUBxSs8fz@krava>
In-Reply-To: <Yw9GzoOhUBxSs8fz@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fccafad-69a4-480e-9680-08da8b76984c
x-ms-traffictypediagnostic: PH0PR15MB4750:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: einkI5iN9ft9HdsPEoqNSA33lBft78X3WjsFSesOL46veWb+LlBOiMsdomHs/7keIL7A6wihr+hJkZrljS7y5gI/d2S5xEbmTSKUXp98xlQmtWM0iMDbVexs9ufwNkNdxbmKvafUG1w4uN/Ba5zUPh5bBx5wP7gLyBOMpZjZu+M+MnX3NP6I18cMbH8+7/ouHkuCe620osVlgfbrei1H7T7gpn8rDNM457JcHjGsoJKlUJ2RIdJjgRuTvHxG6yRQt8lIK+9P/2GUoSu0Ra9W5SDP8kMkz5kycBN37bZXg/oVA+PRPV5UyUyjkGXscU7iM1qRp64Vl5KoHngEQZZQB2TfAw+cxigLP85+EAzz8ygo7bj+aCCVcYnZVfX8jcFq6LtY1pe8Ct7HqIa0dQ/t5BcchtMsDfqXjgfPNLrCdoDanidMwnyPffPc7zS6aYbSNqlBDo07kctKbVgZ5X6FZBfWdbp2ao0LE7uY1Iq+mYzEXmter4U1BapTWOhPk63NYVJoASMah8vpU2Xl3qWrUjw77hFzyMctu2BtFJZFmrZ8xa41GEMApjKQkmYGPdIOJ4kEfWzZ/tfxoTbQETQ6y/vmbMC+QvWuG42/DUmSS9jIl0tDKH0qwwnOziYoz5MebWDJVbOOAfGuPF9XlHQL2ICG8NGv4ZxCUImikBCtxx+fngF9Ic/W57Xn1Cq3FRfrLN95VnzHfW4LJ8Nq5JxrhPGq9tARknmskgAh0WJ0YPQ5ObP++SBTn2p9bLgKwKtpRsU+lUpwDo5W0oLeEC5G9vevupqorjrhyWNZAU0J273Ix0XZ0pkOtuQWgqzpDTdtmVpYWffgPbptiQTF+s31Gg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(38070700005)(186003)(86362001)(4326008)(6916009)(2906002)(8676002)(54906003)(2616005)(38100700002)(64756008)(66446008)(122000001)(316002)(66556008)(66946007)(66476007)(76116006)(5660300002)(83380400001)(8936002)(6486002)(966005)(41300700001)(6506007)(36756003)(71200400001)(478600001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWZOenlRbjdnUkwxVjloZG1uMFFKUCtpdXp2R253RXdOVHFBVVFrMEVjaFdR?=
 =?utf-8?B?SDVncURYNnUwODl4MU5ib3JrSTB4TzZNTnhSTGJ3RUpEVE5vckFZRFI0eW96?=
 =?utf-8?B?K0VrTWdoTFROU2N4elRjNWQ2M2hya3l0WDVNVGxaK2JIREw2QXB0RVdBbzRa?=
 =?utf-8?B?aHlQZ3FBZDZKK2xiMzZmL2puT093YVU2WDhNT011aVpvb0NMSG1Nc0xJQWpl?=
 =?utf-8?B?OXR0S3JvNFQ5bzBvYnNpbGUzaDZhYVlOekVSTW5vRlA2aXVjclRCWGtMaVIw?=
 =?utf-8?B?c2JDL1ptdW5ENHYrNVk2d1N5bllSckIwcitlbjlEUXJWcVgvMkxLdGU4aHA4?=
 =?utf-8?B?bkRNNEtTc291aHU1bVFSRjVxeWVzMFR1U1JIQXN5SFl4Qy9ydDRBejRWTTd4?=
 =?utf-8?B?RCtydE9EWlZLaW9CYW1xWGFDbk5tZWdXK0NpbWtRL2ZhYTg4aDcxNGkvRnFR?=
 =?utf-8?B?NGU3SE1Ma0tBSk9mekRja2pzeTJqcEFYVTQwQ0lvOTFQSWhFc0VaNDdiaWpv?=
 =?utf-8?B?cWdzMjk1ckM3NHJMOXRZbVJicTlObzlocGUxK2o1VUFLUFd4TStlRGk2Mnln?=
 =?utf-8?B?bDBINksrd1ZDWWNLdkx3TGVCeXhRWkRtNERhYnlUR2lxM2VPdWE5cE9ZNzE4?=
 =?utf-8?B?MTgzWlRRL3g1ZEJjUHkrZlVzRXFFZU02aWNqVmtHdnVmNXpuRjVpQ0pHYzFT?=
 =?utf-8?B?MVdTeDN5ZzdzLzV3Y1hFWTgyVHphV0prQmRnSWhrbTNUUmFYU0ZvVlN1QmRX?=
 =?utf-8?B?NzMwRklXSzdxUzROYytXeWp4WCsvV3cvNkZqS21QQ0V0bm9kZURnSDNSUy9U?=
 =?utf-8?B?eFYvNjNXQU9GZzB0bnZ1ZXhuOUxhUnU3NTdoQk12V1pwZVkwQ1NnOVZ5SkQz?=
 =?utf-8?B?OXBuY09TTFJUUnJNUm9aTmRtdnNRa0lSNHg5RGl0eC9yKzJVb2hsdnNRdkZm?=
 =?utf-8?B?Y25kMHg1NG1iRVlJSUNVRUVVUzdxd0lCRGtEVjV5cUp5T09VTlVrQVFPbUt6?=
 =?utf-8?B?M3pvN3F4ZWVFbi80d050R0hWVzU4VTBiQzhhaTVuNnZSRmowRnlxUXMvTHY5?=
 =?utf-8?B?citNVXhUOWVFN2p2ZCtSc0UvRDZCcE1MOTJicWt1WFVKajFMb3dCVUVRTmh1?=
 =?utf-8?B?MTM5MnB5Ulc2WFpKdUNqbjdpSy8xcTJhR3ZXaDY1dklkNGcwR2V1UDFJMWN6?=
 =?utf-8?B?MEExY0lqc1NMRUVjTlB0QU1YRGdULzFuYkw3SnRheW1zYVo1OGVhMkpEWTZp?=
 =?utf-8?B?WTVYd2U1enJCR1ZlNHFLY3RrYkhhcmtBRk50Q1pXeDVtVHVGTTcvcm1ndTRi?=
 =?utf-8?B?NlJQN2xtV0FTdkZJOU5sOEw1WS9ud0gyZitWN0RxdVV0c3VuZS9WWkNXc2pW?=
 =?utf-8?B?OUFEaXd2RWFCaW9kc0xpTmFCSkpnbG8wNytNQ0lCanVwcjlrL0U3aWd0NXkz?=
 =?utf-8?B?Zjhjc1N1YzJhcmhRc1pNSGZjTlBEZFFDWDJmamNObnFBQndXMzFxbUF1Q2RO?=
 =?utf-8?B?VEhaQyswUW5CdnowNGwwc2REZExhbXl6cTUvTmlxUkpRSnB6V3hOTVVqZDNT?=
 =?utf-8?B?NUczMG1sNWVWVFNpN2ZDcDVqUk94K2ZBTFJOdVpWTmo0ajUwRlBtVWhnRE5N?=
 =?utf-8?B?UzVRM3owWklkZDVZRHNPVmpxTXJxWGNQcGhjOHp3TkJFR3E4bzBhekx0elM1?=
 =?utf-8?B?VTZBTkpMTVB3c1FiWFA0aXBFWHZJMmxIWk9aMkZFa1E4VDQ3UGpQcTZ4ZDE0?=
 =?utf-8?B?N0VKdmhFYTcrVVBONThYQmNidkJaaU9FMGx5ekZGSVZRZHBvUXE3MlF3UE9H?=
 =?utf-8?B?ZFFKVFUvZzd1WXpmM2dxblRHaDRCYWIzMGdtTXpFTjJWem93V3F2aUk1NGpn?=
 =?utf-8?B?VnRVUmpiN0JiekQ5VzYwU3JTcytXNzdpZTFTeEpNZWlZTEpvMVVVakFaN3Zm?=
 =?utf-8?B?KzBjVzJSSkdNMlFDck56anlqSjdoMSs2OERqUUl3aEdBSzRybzVEdFE3V3RT?=
 =?utf-8?B?M1A2THdxRndRMnZMbTA3cjkwRmFwNWhJaDFsbXBxS21XNHZsNDNuOWlkVFRi?=
 =?utf-8?B?T2VwOXZGaDFZN1RsSEFIbmh0WkpXME14Wng1WDZyeFQ3d0EyVlgvMFVIRXBk?=
 =?utf-8?B?UUtMZlpKSkprTUpQZjAzRmNDYWQzczNSUlNTNVRCVkgxS0ZmRmZ5eFRnbllK?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59FCCF6004BF624AB0C6C96EE7F810CB@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fccafad-69a4-480e-9680-08da8b76984c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 17:31:10.3279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Upktrx0hQwAUpBTqYv2Aihlha1LXNGsfvoKozV1/P64Sr2bhZkFCT9NA+wiWGcI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4750
X-Proofpoint-ORIG-GUID: YLfWOlJ1WXrPJWUDr2i4hqsEkXwy2eFJ
X-Proofpoint-GUID: YLfWOlJ1WXrPJWUDr2i4hqsEkXwy2eFJ
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_10,2022-08-31_03,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gV2VkLCAyMDIyLTA4LTMxIGF0IDEzOjMyICswMjAwLCBKaXJpIE9sc2Egd3JvdGU6DQo+IE9u
IFR1ZSwgQXVnIDMwLCAyMDIyIGF0IDA3OjM3OjM5UE0gLTA3MDAsIEt1aS1GZW5nIExlZSB3cm90
ZToNCj4gPiBBbGxvdyBjcmVhdGluZyBhbiBpdGVyYXRvciB0aGF0IGxvb3BzIHRocm91Z2ggcmVz
b3VyY2VzIG9mIG9uZQ0KPiA+IHRhc2svdGhyZWFkLg0KPiA+IA0KPiA+IFBlb3BsZSBjb3VsZCBv
bmx5IGNyZWF0ZSBpdGVyYXRvcnMgdG8gbG9vcCB0aHJvdWdoIGFsbCByZXNvdXJjZXMgb2YNCj4g
PiBmaWxlcywgdm1hLCBhbmQgdGFza3MgaW4gdGhlIHN5c3RlbSwgZXZlbiB0aG91Z2ggdGhleSB3
ZXJlDQo+ID4gaW50ZXJlc3RlZCBpbiBvbmx5IHRoZQ0KPiA+IHJlc291cmNlcyBvZiBhIHNwZWNp
ZmljIHRhc2sgb3IgcHJvY2Vzcy7CoCBQYXNzaW5nIHRoZSBhZGRpdGlvbmFsDQo+ID4gcGFyYW1l
dGVycywgcGVvcGxlIGNhbiBub3cgY3JlYXRlIGFuIGl0ZXJhdG9yIHRvIGdvIHRocm91Z2ggYWxs
DQo+ID4gcmVzb3VyY2VzIG9yIG9ubHkgdGhlIHJlc291cmNlcyBvZiBhIHRhc2suDQo+ID4gDQo+
ID4gTWFqb3IgQ2hhbmdlczoNCj4gPiANCj4gPiDCoC0gQWRkIG5ldyBwYXJhbWV0ZXJzIGluIGJw
Zl9pdGVyX2xpbmtfaW5mbyB0byBpbmRpY2F0ZSB0byBnbw0KPiA+IHRocm91Z2gNCj4gPiDCoMKg
IGFsbCB0YXNrcyBvciB0byBnbyB0aHJvdWdoIGEgc3BlY2lmaWMgdGFzay4NCj4gPiANCj4gPiDC
oC0gQ2hhbmdlIHRoZSBpbXBsZW1lbnRhdGlvbnMgb2YgQlBGIGl0ZXJhdG9ycyBvZiB2bWEsIGZp
bGVzLCBhbmQNCj4gPiDCoMKgIHRhc2tzIHRvIGFsbG93IGdvaW5nIHRocm91Z2ggb25seSB0aGUg
cmVzb3VyY2VzIG9mIGEgc3BlY2lmaWMNCj4gPiB0YXNrLg0KPiA+IA0KPiA+IMKgLSBQcm92aWRl
IHRoZSBhcmd1bWVudHMgb2YgcGFyYW1ldGVyaXplZCB0YXNrIGl0ZXJhdG9ycyBpbg0KPiA+IMKg
wqAgYnBmX2xpbmtfaW5mby4NCj4gDQo+IGhpLA0KPiBJJ20gZ2V0dGluZyBicGZfaXRlci92bWFf
b2Zmc2V0IGZhaWw6DQo+IA0KPiB0ZXN0X3Rhc2tfdm1hX29mZnNldF9jb21tb246UEFTUzpicGZf
aXRlcl92bWFfb2Zmc2V0X19vcGVuX2FuZF9sb2FkIDANCj4gbnNlYw0KPiB0ZXN0X3Rhc2tfdm1h
X29mZnNldF9jb21tb246UEFTUzphdHRhY2hfaXRlciAwIG5zZWMNCj4gdGVzdF90YXNrX3ZtYV9v
ZmZzZXRfY29tbW9uOlBBU1M6Y3JlYXRlX2l0ZXIgMCBuc2VjDQo+IHRlc3RfdGFza192bWFfb2Zm
c2V0X2NvbW1vbjpQQVNTOnN0cmNtcCAwIG5zZWMNCj4gdGVzdF90YXNrX3ZtYV9vZmZzZXRfY29t
bW9uOkZBSUw6b2Zmc2V0IHVuZXhwZWN0ZWQgb2Zmc2V0OiBhY3R1YWwNCj4gMjU3MjIyICE9IGV4
cGVjdGVkIDIwMzk3NA0KPiB0ZXN0X3Rhc2tfdm1hX29mZnNldF9jb21tb246UEFTUzp1bmlxdWVf
dGdpZF9jb3VudCAwIG5zZWMNCj4gdGVzdF90YXNrX3ZtYV9vZmZzZXRfY29tbW9uOlBBU1M6YnBm
X2l0ZXJfdm1hX29mZnNldF9fb3Blbl9hbmRfbG9hZCAwDQo+IG5zZWMNCj4gdGVzdF90YXNrX3Zt
YV9vZmZzZXRfY29tbW9uOlBBU1M6YXR0YWNoX2l0ZXIgMCBuc2VjDQo+IHRlc3RfdGFza192bWFf
b2Zmc2V0X2NvbW1vbjpQQVNTOmNyZWF0ZV9pdGVyIDAgbnNlYw0KPiB0ZXN0X3Rhc2tfdm1hX29m
ZnNldF9jb21tb246UEFTUzpzdHJjbXAgMCBuc2VjDQo+IHRlc3RfdGFza192bWFfb2Zmc2V0X2Nv
bW1vbjpGQUlMOm9mZnNldCB1bmV4cGVjdGVkIG9mZnNldDogYWN0dWFsDQo+IDI1NzIyMiAhPSBl
eHBlY3RlZCAyMDM5NzQNCj4gdGVzdF90YXNrX3ZtYV9vZmZzZXRfY29tbW9uOlBBU1M6dW5pcXVl
X3RnaWRfY291bnQgMCBuc2VjDQo+IHRlc3RfdGFza192bWFfb2Zmc2V0X2NvbW1vbjpQQVNTOmJw
Zl9pdGVyX3ZtYV9vZmZzZXRfX29wZW5fYW5kX2xvYWQgMA0KPiBuc2VjDQo+IHRlc3RfdGFza192
bWFfb2Zmc2V0X2NvbW1vbjpQQVNTOmF0dGFjaF9pdGVyIDAgbnNlYw0KPiB0ZXN0X3Rhc2tfdm1h
X29mZnNldF9jb21tb246UEFTUzpjcmVhdGVfaXRlciAwIG5zZWMNCj4gdGVzdF90YXNrX3ZtYV9v
ZmZzZXRfY29tbW9uOlBBU1M6c3RyY21wIDAgbnNlYw0KPiB0ZXN0X3Rhc2tfdm1hX29mZnNldF9j
b21tb246RkFJTDpvZmZzZXQgdW5leHBlY3RlZCBvZmZzZXQ6IGFjdHVhbA0KPiAyNTcyMjIgIT0g
ZXhwZWN0ZWQgMjAzOTc0DQo+IHRlc3RfdGFza192bWFfb2Zmc2V0X2NvbW1vbjpQQVNTOnVuaXF1
ZV90Z2lkX2NvdW50IDAgbnNlYw0KPiAjMTEvMzjCoMKgIGJwZl9pdGVyL3ZtYV9vZmZzZXQ6RkFJ
TA0KPiANCj4gamlya2ENCg0KSSBjb3VsZCBub3QgcmVwcm9kdWNlIGl0LiAgSG93ZXZlciwgSSBm
b3VuZCBpdCBzaG91bGQgYmUgYW4gaW5jb3JyZWN0DQpib3VuZGFyeSBjaGVjayBvZiBjb21wdXRp
bmcgcGFnZV9zaGlmdC4gIE9uIG15IGRldmljZSwgaXQgaGFwcGVuZWQgdG8NCmJlIGxvYWRlZCB3
aXRoIGFuIG9mZnNldCAwIGZyb20gdGhlIGhlYWQgb2YgdGhlIGZpbGUsIHNvIGl0IHBhc3NlZCB0
aGUNCnRlc3QgY2FzZSBhY2NpZGVudGFsbHkuDQoNCkFueXdheSwgSSB3aWxsIGZpeCBpdC4NCg0K
PiANCj4gPiANCj4gPiBEaWZmZXJlbmNlcyBmcm9tIHY4Og0KPiA+IA0KPiA+IMKgLSBGaXggdW5p
bml0aWFsaXplZCB2YXJpYWJsZS4NCj4gPiANCj4gPiDCoC0gQXZvaWQgcmVkdW5kYW50IHdvcmsg
b2YgZ2V0dGluZyB0YXNrIGZyb20gcGlkLg0KPiA+IA0KPiA+IMKgLSBDaGFuZ2UgZm9ybWF0IHN0
cmluZyB0byB1c2UgJXUgaW5zdGVhZCBvZiAlZC4NCj4gPiANCj4gPiDCoC0gVXNlIHRoZSB2YWx1
ZSBvZiBwYWdlX3NoaWZ0IHRvIGNvbXB1dGUgY29ycmVjdCBvZmZzZXQgaW4NCj4gPiDCoMKgIGJw
Zl9pdGVyX3ZtX29mZnNldC5jLg0KPiA+IA0KPiA+IERpZmZlcmVuY2VzIGZyb20gdjc6DQo+ID4g
DQo+ID4gwqAtIFRyYXZlbCB0aGUgdGFza3Mgb2YgYSBwcm9jZXNzIHRocm91Z2ggdGFza19ncm91
cCBsaW5rZWQgbGlzdA0KPiA+IMKgwqAgaW5zdGVhZCBvZiB0cmF2ZWxpbmcgdGhyb3VnaCB0aGUg
d2hvbGUgbmFtZXNwYWNlLg0KPiA+IA0KPiA+IERpZmZlcmVuY2VzIGZyb20gdjY6DQo+ID4gDQo+
ID4gwqAtIEFkZCBwYXJ0IDUgdG8gbWFrZSBicGZ0b29sIHNob3cgdGhlIHZhbHVlIG9mIHBhcmFt
ZXRlcnMuDQo+ID4gDQo+ID4gwqAtIENoYW5nZSBvZiB3b3JkaW5nIG9mIHNob3dfZmRpbmZvKCkg
dG8gc2hvdyBwaWQgb3IgdGlkIGluc3RlYWQgb2YNCj4gPiDCoMKgIGFsd2F5cyBwaWQuDQo+ID4g
DQo+ID4gwqAtIFNpbXBsaWZ5IGVycm9yIGhhbmRsaW5nIGFuZCBuYW1pbmcgb2YgdGVzdCBjYXNl
cy4NCj4gPiANCj4gPiBEaWZmZXJlbmNlcyBmcm9tIHY1Og0KPiA+IA0KPiA+IMKgLSBVc2UgdXNl
ci1zcGFjZSB0aWQvcGlkIHRlcm1pbm9sb2dpZXMgaW4gYnBmX2l0ZXJfbGlua19pbmZvIGFuZA0K
PiA+IMKgwqAgYnBmX2xpbmtfaW5mby4NCj4gPiANCj4gPiDCoC0gRml4IHJlZmVyZW5jZSBjb3Vu
dA0KPiA+IA0KPiA+IMKgLSBNZXJnZSBhbGwgdmFyaWFudHMgdG8gb25lICd1MzIgcGlkJyBpbiBp
bnRlcm5hbCBzdHJ1Y3RzLg0KPiA+IMKgwqAgKGJwZl9pdGVyX2F1eF9pbmZvIGFuZCBicGZfaXRl
cl9zZXFfdGFza19jb21tb24pDQo+ID4gDQo+ID4gwqAtIENvbXBhcmUgdGhlIHJlc3VsdCBvZiBn
ZXRfdXByb2JlX29mZnNldCgpIHdpdGggdGhlDQo+ID4gaW1wbGVtZW50YXRpb24NCj4gPiDCoMKg
IHdpdGggdGhlIHZtYSBpdGVyYXRvcnMuDQo+ID4gDQo+ID4gwqAtIEltcGxlbWVudCBzaG93X2Zk
aW5mby4NCj4gPiANCj4gPiBEaWZmZXJlbmNlcyBmcm9tIHY0Og0KPiA+IA0KPiA+IMKgLSBSZW1v
dmUgJ3R5cGUnIGZyb20gYnBmX2l0ZXJfbGlua19pbmZvIGFuZCBicGZfbGlua19pbmZvLg0KPiA+
IA0KPiA+IHY4Og0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2JwZi8yMDIyMDgyOTE5MjMx
Ny40ODY5NDYtMS1rdWlmZW5nQGZiLmNvbS8NCj4gPiB2NzoNCj4gPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9icGYvMjAyMjA4MjYwMDM3MTIuMjgxMDE1OC0xLWt1aWZlbmdAZmIuY29tLw0KPiA+
IHY2Og0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2JwZi8yMDIyMDgxOTIyMDkyNy4zNDA5
NTc1LTEta3VpZmVuZ0BmYi5jb20vDQo+ID4gdjU6DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvYnBmLzIwMjIwODExMDAxNjU0LjEzMTY2ODktMS1rdWlmZW5nQGZiLmNvbS8NCj4gPiB2NDoN
Cj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9icGYvMjAyMjA4MDkxOTU0MjkuMTA0MzIyMC0x
LWt1aWZlbmdAZmIuY29tLw0KPiA+IHYzOg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Jw
Zi8yMDIyMDgwOTA2MzUwMS42Njc2MTAtMS1rdWlmZW5nQGZiLmNvbS8NCj4gPiB2MjoNCj4gPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9icGYvMjAyMjA4MDEyMzI2NDkuMjMwNjYxNC0xLWt1aWZl
bmdAZmIuY29tLw0KPiA+IHYxOg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2JwZi8yMDIy
MDcyNjA1MTcxMy44NDA0MzEtMS1rdWlmZW5nQGZiLmNvbS8NCj4gPiANCj4gPiBLdWktRmVuZyBM
ZWUgKDUpOg0KPiA+IMKgIGJwZjogUGFyYW1ldGVyaXplIHRhc2sgaXRlcmF0b3JzLg0KPiA+IMKg
IGJwZjogSGFuZGxlIGJwZl9saW5rX2luZm8gZm9yIHRoZSBwYXJhbWV0ZXJpemVkIHRhc2sgQlBG
DQo+ID4gaXRlcmF0b3JzLg0KPiA+IMKgIGJwZjogSGFuZGxlIHNob3dfZmRpbmZvIGZvciB0aGUg
cGFyYW1ldGVyaXplZCB0YXNrIEJQRiBpdGVyYXRvcnMNCj4gPiDCoCBzZWxmdGVzdHMvYnBmOiBU
ZXN0IHBhcmFtZXRlcml6ZWQgdGFzayBCUEYgaXRlcmF0b3JzLg0KPiA+IMKgIGJwZnRvb2w6IFNo
b3cgcGFyYW1ldGVycyBvZiBCUEYgdGFzayBpdGVyYXRvcnMuDQo+ID4gDQo+ID4gwqBpbmNsdWRl
L2xpbnV4L2JwZi5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqAgMjUgKysNCj4gPiDCoGluY2x1ZGUvdWFwaS9saW51eC9icGYuaMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTAgKw0KPiA+IMKga2VybmVs
L2JwZi90YXNrX2l0ZXIuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfCAyMjcgKysrKysrKysrKysrLS0NCj4gPiDCoHRvb2xzL2JwZi9icGZ0b29sL2xpbmsu
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTkgKysNCj4g
PiDCoHRvb2xzL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqAgMTAgKw0KPiA+IMKgLi4uL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9icGZf
aXRlci5jwqDCoMKgwqDCoMKgIHwgMjgyDQo+ID4gKysrKysrKysrKysrKysrKy0tDQo+ID4gwqAu
Li4vc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2J0Zl9kdW1wLmPCoMKgwqDCoMKgwqAgfMKgwqAg
MiArLQ0KPiA+IMKgLi4uL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvYnBmX2l0ZXJfdGFzay5jwqDCoMKg
wqDCoMKgIHzCoMKgIDkgKw0KPiA+IMKgLi4uL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvYnBmX2l0ZXJf
dGFza19maWxlLmPCoCB8wqDCoCA5ICstDQo+ID4gwqAuLi4vc2VsZnRlc3RzL2JwZi9wcm9ncy9i
cGZfaXRlcl90YXNrX3ZtYS5jwqDCoCB8wqDCoCA3ICstDQo+ID4gwqAuLi4vc2VsZnRlc3RzL2Jw
Zi9wcm9ncy9icGZfaXRlcl92bWFfb2Zmc2V0LmMgfMKgIDM3ICsrKw0KPiA+IMKgMTEgZmlsZXMg
Y2hhbmdlZCwgNTkxIGluc2VydGlvbnMoKyksIDQ2IGRlbGV0aW9ucygtKQ0KPiA+IMKgY3JlYXRl
IG1vZGUgMTAwNjQ0DQo+ID4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL2JwZl9p
dGVyX3ZtYV9vZmZzZXQuYw0KPiA+IA0KPiA+IC0tIA0KPiA+IDIuMzAuMg0KPiA+IA0KDQo=
