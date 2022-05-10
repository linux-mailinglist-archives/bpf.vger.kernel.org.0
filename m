Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE3E52225F
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 19:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347970AbiEJR1w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 13:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348010AbiEJR1v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 13:27:51 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E36268EB1
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 10:23:51 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AFLPHD024990
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 10:23:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=rIzeg4bt8qpfVFWxr/lSMSw5kqI7WbKbsMd18eKqgtY=;
 b=QYGBUrzkQUMkWiBwPjANRjg7LKupBgOvCnE6H9w+rjNtwnutogY8ItPO2KUCxnQeW9oY
 Y7mA0i9tkUNiEnn0v03/plLNsEioG18O81YfEo8VhylxMdwMd25yw45ZupG7e2oC39vq
 XvkxEYBgjRSwDDRzf5J3Y0dekL76QAFmTPk= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fyn47u2yb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 10:23:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2AmsBBJyBquTzOBf7cOk5r/Ph/mxIkeD87Y0MOYCthJOxyJYPVWsSTk7EcUj/8M5GdKkiFGoNJAoaKihN1n2NbSrMx4PZL6LfnvBzXqFXQG15YVN5dR42lC2ReIl8Qr4Bg0xoOO02r1nxficrQ8DzT3SNu7MSsY6cExTvgNUeaQwPClU2D3FYniwqk78kQRggL2ZEp57ViCX2XeP6/VkpgKkSSZygGe6RiX5smc/Nh0TA/LrDwR3Fj7EkofgaHNifIeoil0pNNN/cA7ilMG5SZrhMvRX8y5kKsD2fZGgUprBeNRdlXgFwZhhtWgfpx/CX5hFcYEVHJHhVCru9HBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIzeg4bt8qpfVFWxr/lSMSw5kqI7WbKbsMd18eKqgtY=;
 b=S74vhBGJdb0TsRpViZuLWGTzU5NoX81RXFZ3dTGNyYBReKCCxeYHyQn86QyK3yz/GyhWlg4e0MoFrMZE53GWBSPaJu6X/6wSH+QNPAXkpAz2p7a3p7UTSwc7bY/idk2270XWE0H6ZWHBxyl9o1LRMefV25y7wE/GFW5BjhR4Ei8/S/4tCoPQOUPtYlQte9Y/lt2mZrGyaLIfejv/fgbdr+7r5hMpwbalGXUdNPxn1mqT/qL4fYdtWjZWmbYynNFiZHOkjKvG1jk+1RWtiqB2GK4VtGqYJp5/2DHS5O2SWN3UTsIV61j1cotH60tQ5viL69KX4aIwbMI4hwKVOeFJxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by BYAPR15MB3143.namprd15.prod.outlook.com (2603:10b6:a03:b5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 17:23:48 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::8062:184b:31e7:8777]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::8062:184b:31e7:8777%6]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 17:23:48 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v7 4/5] libbpf: Assign cookies to links in
 libbpf.
Thread-Topic: [PATCH bpf-next v7 4/5] libbpf: Assign cookies to links in
 libbpf.
Thread-Index: AQHYYorDmR6cprbWJEeP4HUoLk+wsq0W6oIAgAF10wA=
Date:   Tue, 10 May 2022 17:23:48 +0000
Message-ID: <021ea9d3a2008c39a8ee41fe3955d473baa61c66.camel@fb.com>
References: <20220508032117.2783209-1-kuifeng@fb.com>
         <20220508032117.2783209-5-kuifeng@fb.com>
         <CAEf4BzZ06F3vwhHHixpCyXHpnhCx2mwhT6GS5S5FfvBp_bsV9g@mail.gmail.com>
In-Reply-To: <CAEf4BzZ06F3vwhHHixpCyXHpnhCx2mwhT6GS5S5FfvBp_bsV9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6278ddf9-a764-485b-b3c6-08da32a9d85b
x-ms-traffictypediagnostic: BYAPR15MB3143:EE_
x-microsoft-antispam-prvs: <BYAPR15MB31439F2EF3F4ED807D9CBB31CCC99@BYAPR15MB3143.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CFyOLbays6MCjX+Q2YcoOExvAYsrzmkMMff90WHvjgB46GKy/rC5Ulz/uDt5EzFehFUnBkAdLmLgbW/g4kdVfi8ewGcvDFPLmC2V0MUdFoRoGoOv93g22uGL0c2GlK/byO2Rd5tlTVfJcgl6N9Bdgzyfs4sXVjcwAOaP30HsqsmeRpmT5oUAktFLMV92eI2RobPGNQvLM0bfo+TDQjw+ijBQHPY77rbmWtG6F5mfNc6oHUhSYmsRQeUaxrnG6PVvNhufBpZZMycz62P1n2WjfZ0VSsvXEEDTlmL40Zfa6vxtVxC1RJk2aSs7XimFUxXChUK8/GJc5HNyaKh4c4B5LYfSCNuDdGzJKQg1TDmVtEdLI3YVkGorK6VNmuJ/XrbaW+X4CooABoZGckbS5/Yi7JIEyFUJrIo+BOzokt/k1oIq2GQh5TzTQEvvK7VZ4lAid++3wwrm3NBWDCP+L/m1+bdBlTYz7prHDxiFT5n/r8YgjZJE2dxjJKhwZo1fLz9Xl8wb0o1mQLyz4XK2jZUdIJzYk4xsmq0p28x1BUUe6VPfDhZ5/vLmt6MWA9VAJPOIHKHPplA+FJbLLBtEmT9oCtKC3G3t+Jk+dpaOfZHLn0LsmLXqUBeJ1BsWnWjiY73yixB87DWKz2o09eVTvAc1fyk1dfs91Do79YQUhOnpD9IYZaU8XoMpfskHml6M4JphgIEx7qdAIqk3AyntDIBztg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(83380400001)(36756003)(122000001)(316002)(2616005)(8936002)(64756008)(6916009)(8676002)(54906003)(4326008)(66446008)(76116006)(66476007)(66946007)(66556008)(38070700005)(38100700002)(6486002)(71200400001)(6512007)(508600001)(2906002)(5660300002)(186003)(6506007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjJxcERKOG9qVmlwQS9HWStQZkJEQVFCNnJmMUMyOVhha05vVE9HblFJZWdY?=
 =?utf-8?B?TUFsVkFZbWJTdGRCVFJNcWZ4ZTRBc2NyU0FrYzh3aVdpSm80MG9WUjMxbTNa?=
 =?utf-8?B?bCs5enNNUGRMSTI0cExLYzdxS1ptamZyMTdnVlJ3eGJsV0w0TzhqeDdlT3Zq?=
 =?utf-8?B?T1VlZWhoNmVFdzRWTWJIMXYwT1dIVzErK29SeUtpYUVTcVVBcGlCa3VkS24x?=
 =?utf-8?B?YWJrNWtRS0xZRk83alVaMmpEWmxIQnZRcG4xYW04anJVaHFJUVp0Sm1sOVhJ?=
 =?utf-8?B?VXhxZUY5SDNkRFRzWUJ4cHRzOVhwWXV3bGNwSWd0RUlPQ09ZNEpTYTdLYk03?=
 =?utf-8?B?ZTh4Y29TbFFQYVRjTCs2b0pVM2dTZmZSZXBIM0xKOWpkUEdvN1B2T1RUZFox?=
 =?utf-8?B?cDNGaVZvWEk4aHJIb3RZMkdDcUxWSERWMXc0b1R5azlOT3JWSzhHTG1nSEE3?=
 =?utf-8?B?WjVzVDFLU2YxcWRQQ3I2R25jZWRoY3gyWVVpa1hmajVUcE5jUWY1V04ySUdU?=
 =?utf-8?B?UnB0YTg2WkRSUXVyTXBtU2Vnbno0Vnd5d1ZzV3IwakNldVM0cFVpK2lNZ2Ix?=
 =?utf-8?B?cEUzYkNGemx6d0FOOWlVTHNFdFhrdHl0Wjh1LzRHQnE2RHhraTUveG14M2tV?=
 =?utf-8?B?dnBGWEE2ZGlvellSVXJHY202bFJIVmo3RW1MN2tCcDRyVlI2SXI3MTR4UWp4?=
 =?utf-8?B?N2cvdjNPb2RJSDd5ZDZXSERkNU5PcUQxbVNxVk52eHhGZVNNZzNiSTZvNk9o?=
 =?utf-8?B?WnFTaFpubHF2Yit6Y3dMdHZBYzlvdnVlZVluMWxSY1A5ejkxRmVPQnpVOGsx?=
 =?utf-8?B?TGRvQnR0V3dCaUxQTGxHb2tiZExvSDgxZW9xb2xRWi9CTlhqSHFTcnFHaSsv?=
 =?utf-8?B?VEVIQjBwZkVWSHBVa2MwbTZQcys5ajhEcThlc0ozMWg0R3BtN2w2NkxRQWtF?=
 =?utf-8?B?QXVKRFNOUElXUDl3emg3dTIrU1V3QWdFQldSdTcyVlIzYUFqeEVGTHZncVMw?=
 =?utf-8?B?ZGg2OW45RUFYeHBVdWFyQ092NkhoM29sMlQxQkNhUHVuSXVZUTV5S1B1U3lZ?=
 =?utf-8?B?aDB4Y3hlc2JMRDZZNWt6bGZ5ZytNOWZVQVBBODBLSW1kbUg5UzRNTVZzM0tN?=
 =?utf-8?B?c0Fwb294SHQzVU1yYkpVWVpqUnlHUGRCTEVwYy90NjlQV3J1NEFxQVRGbUpS?=
 =?utf-8?B?cjB3ZlhJd0Qzd0h6S3kvOW50MFQ3ZDdFeHFqRjFGZkFabEVjQVhkdjFrOE9O?=
 =?utf-8?B?THY4QnVtTEhPbHNFTFBXNVpBSkVvdVdBdnFRQ0V3S2NzMmdIa0VBSEcxbDly?=
 =?utf-8?B?QUpyWkFGZ1JWWkZDcG9hZlRXeWo0aFl4aGVmZW8rVXlSaHNObnVISXVvdWhs?=
 =?utf-8?B?Z0hHbEhBUWlxZGxxN28zN0JlMWxDb0svbGM5eG1OZkR4ZEJRaXFMUS9VNDJY?=
 =?utf-8?B?SzREVENERnk5eGl2Vjk1UEE4UGYzWC9xRVVKU1F1RktFZEk2SXJ0a0I2ZmNW?=
 =?utf-8?B?S1g5V1FzbnViYkxJK2JuWG9oRDdidUJ1MWIyb2x0SkZOUkxXZWIxdHBUd0Jl?=
 =?utf-8?B?am92bHprWFk4WVc3VVhhT0FybkVsNHRQN21JUEtpbktkeUpaMS91QVhUV0pn?=
 =?utf-8?B?RnZyUUt2UGFQbTFaeDR3a05GQlQ2aTlYUFVUZjlDVXpOd1MxT2QzSlFieXlh?=
 =?utf-8?B?VXd1cFMzUDVYcTExb0NESVlwYXVZVWl5ZnZOZGlxM0c2NzYvRFBqY0JqdU1N?=
 =?utf-8?B?eUN1bVNGZ0RJV0oveXlXbFhsUktZdjRWQS96SDlGVmNZdXZoVHRUUE9RZGN6?=
 =?utf-8?B?U3lmYU1EdGRNL0tGYUFtOU5QT3JQMmZWTEk5bWEydENiRXN4SWRQblJKeUpI?=
 =?utf-8?B?VlVRMStVODVQY0dVM0FiTHRXNHY4QmgwQ2FyQlVNYUZpcUxPR1NRaE9nNVE3?=
 =?utf-8?B?Ymo4MHBGdC9uTlY5L3JkSnoxUklWb0FXU3JBU21nZW8vUnZWczcrczN3VjY5?=
 =?utf-8?B?cFpITitudGxUbDQxZ0R3VlluOEVGTWtmMUtTRzgvcTBDdkN1UFBhOWd5NS9J?=
 =?utf-8?B?L01YMUhaaGRwUWZXM3l1QjI5b1dPclFEZS9IUnFKRFVzU0NBWE1zYmRNQVpB?=
 =?utf-8?B?MjMrdDFqVnU3UU9KVVNTL29yWUVOV1JERGw5em9LU2R3b2R1VGJibitqc2JQ?=
 =?utf-8?B?a1JrQVp1aklmQXhvSTNhQTlWWW5ONW51R3Vaa1BpOTBYcU52THJDaUNEaHND?=
 =?utf-8?B?M0JSVHlNMXRaQkovUExxZ0x4UXFLWlUrRER1NmFMbFFSTFArUmdTTFFRSjY1?=
 =?utf-8?B?OVF1OXAyaDl3aW5Mb1hqbzlsRUhuVUlYNmdIeGhEbjlTNWh6SXhXSi9EUHlj?=
 =?utf-8?Q?wEJXyz8s/RvrRGxBjNqQ7LP9FHFlJvPhmIkCI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <583CF841841CB0498EC7B110E8649B51@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6278ddf9-a764-485b-b3c6-08da32a9d85b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 17:23:48.6628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F20ymFK0w7d0y05M/QxU1wgoaGIQFAak7150Zzml28qIYiy3/BvKTyQ+HqLEzNWn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3143
X-Proofpoint-ORIG-GUID: l02YRkXk6wrGc2lV9EC77eZTv27RSy83
X-Proofpoint-GUID: l02YRkXk6wrGc2lV9EC77eZTv27RSy83
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_05,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTA1LTA5IGF0IDEyOjA1IC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IE9uIFNhdCwgTWF5IDcsIDIwMjIgYXQgODoyMSBQTSBLdWktRmVuZyBMZWUgPGt1aWZlbmdA
ZmIuY29tPiB3cm90ZToNCj4gPiANCj4gPiBBZGQgYSBjb29raWUgZmllbGQgdG8gdGhlIGF0dHJp
YnV0ZXMgb2YgYnBmX2xpbmtfY3JlYXRlKCkuDQo+ID4gQWRkIGJwZl9wcm9ncmFtX19hdHRhY2hf
dHJhY2Vfb3B0cygpIHRvIGF0dGFjaCBhIGNvb2tpZSB0byBhIGxpbmsuDQo+ID4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogS3VpLUZlbmcgTGVlIDxrdWlmZW5nQGZiLmNvbT4NCj4gPiAtLS0NCj4gPiDC
oHRvb2xzL2xpYi9icGYvYnBmLmPCoMKgwqDCoMKgIHzCoCA4ICsrKysrKysrDQo+ID4gwqB0b29s
cy9saWIvYnBmL2JwZi5owqDCoMKgwqDCoCB8wqAgMyArKysNCj4gPiDCoHRvb2xzL2xpYi9icGYv
bGliYnBmLmPCoMKgIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiDC
oHRvb2xzL2xpYi9icGYvbGliYnBmLmjCoMKgIHwgMTIgKysrKysrKysrKysrDQo+ID4gwqB0b29s
cy9saWIvYnBmL2xpYmJwZi5tYXAgfMKgIDEgKw0KPiA+IMKgNSBmaWxlcyBjaGFuZ2VkLCA1NiBp
bnNlcnRpb25zKCspDQo+ID4gDQo+IA0KPiBJIGhhdmUgYSBncmlwZSB3aXRoIGJldHRlciBjb2Rl
IHJldXNlLCBidXQgdGhhdCdzIGludGVybmFsIGNoYW5nZSBzbw0KPiB3ZSBjYW4gZG8gaXQgaW4g
YSBmb2xsb3cgdXAuDQo+IA0KPiBBY2tlZC1ieTogQW5kcmlpIE5ha3J5aWtvIDxhbmRyaWlAa2Vy
bmVsLm9yZz4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL2xpYi9icGYvbGliYnBmLmMgYi90
b29scy9saWIvYnBmL2xpYmJwZi5jDQo+ID4gaW5kZXggNzNhNTE5MmRlZmIzLi5kZjliZTQ3ZDY3
YmMgMTAwNjQ0DQo+ID4gLS0tIGEvdG9vbHMvbGliL2JwZi9saWJicGYuYw0KPiA+ICsrKyBiL3Rv
b2xzL2xpYi9icGYvbGliYnBmLmMNCj4gPiBAQCAtMTE0NDAsNiArMTE0NDAsMzggQEAgc3RydWN0
IGJwZl9saW5rDQo+ID4gKmJwZl9wcm9ncmFtX19hdHRhY2hfdHJhY2UoY29uc3Qgc3RydWN0IGJw
Zl9wcm9ncmFtICpwcm9nKQ0KPiA+IMKgwqDCoMKgwqDCoMKgIHJldHVybiBicGZfcHJvZ3JhbV9f
YXR0YWNoX2J0Zl9pZChwcm9nKTsNCj4gPiDCoH0NCj4gPiANCj4gPiArc3RydWN0IGJwZl9saW5r
ICpicGZfcHJvZ3JhbV9fYXR0YWNoX3RyYWNlX29wdHMoY29uc3Qgc3RydWN0DQo+ID4gYnBmX3By
b2dyYW0gKnByb2csDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNv
bnN0IHN0cnVjdA0KPiA+IGJwZl90cmFjZV9vcHRzICpvcHRzKQ0KPiANCj4gdGhlcmUgaXMgYnBm
X3Byb2dyYW1fX2F0dGFjaF9idGZfaWQoKSB0aGF0IGRvZXMgYWxsIG9mIHRoaXMgZXhjZXB0DQo+
IGZvcg0KPiB0aGUgY29va2llLiBJdCB3b3VsZCBiZSBuaWNlciB0byBleHRlbmQgYnBmX3Byb2dy
YW1fX2F0dGFjaF9idGZfaWQoKSwNCj4gd2hpY2ggd29uJ3QgYnJlYWsgYW55IEFQSSBiZWNhdXNl
IGl0J3MgYW4gaW50ZXJuYWwgaGVscGVyLCBhZGQNCj4gb3B0aW9uYWwgYnBmX3RyYWNlX29wdHMg
dG8gaXQgYW5kIHRoZW4ganVzdCByZWRpcmVjdA0KPiBicGZfcHJvZ3JhbV9fYXR0YWNoX3RyYWNl
X29wdHMoKSB0byBicGZfcHJvZ3JhbV9fYXR0YWNoX2J0Zl9pZCBhbmQNCj4gdXBkYXRlIGFsbCB0
aGUgZXhpc3RpbmcgY2FsbGVycyB3aXRoIGp1c3QgcGFzc2luZyBOVUxMIGZvciBvcHRzLg0KDQpG
aXhlZCEgIEkgY29waWVkIHRoZSBjb2RlIGZyb20gYnBmX3Byb2dyYW1fX2F0dGFjaF9idGZfaWQo
KSBmb3INCnRlc3RpbmcsIGFuZCBmb3Jnb3QgdG8gcmVmYWN0b3IgaXQuDQoNCj4gDQo+IFdlIGNh
biBkbyB0aGF0IGFzIGEgZm9sbG93IHVwLCBnaXZlbiB5b3VyIHBhdGNoIHNldCBzZWVtcyB0byBi
ZQ0KPiBwcmV0dHkNCj4gbXVjaCByZWFkeSB0byBiZSBsYW5kZWQuDQo+IA0KPiA+ICt7DQo+ID4g
K8KgwqDCoMKgwqDCoCBjaGFyIGVycm1zZ1tTVFJFUlJfQlVGU0laRV07DQo+ID4gK8KgwqDCoMKg
wqDCoCBzdHJ1Y3QgYnBmX2xpbmsgKmxpbms7DQo+ID4gK8KgwqDCoMKgwqDCoCBpbnQgcHJvZ19m
ZCwgcGZkOw0KPiA+ICvCoMKgwqDCoMKgwqAgTElCQlBGX09QVFMoYnBmX2xpbmtfY3JlYXRlX29w
dHMsIGxpbmtfb3B0cyk7DQo+ID4gKw0KPiANCj4gWy4uLl0NCg0K
