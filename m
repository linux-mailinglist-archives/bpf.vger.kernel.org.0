Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D4D4F577A
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 10:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiDFHgv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 03:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343868AbiDFHNg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 03:13:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FA2215BE1
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 22:35:10 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 235I0WWg006165
        for <bpf@vger.kernel.org>; Tue, 5 Apr 2022 22:35:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ShITf15ny2zRWck07X/nHVn9f/aMpMYn0Y1Jc8BIYHc=;
 b=NSPjyIpzmR2KY6Gb0mssQDiH69oStQD2SfcJ96HwA9zFWb692ZT5Ajg32ck3v+/qZRYz
 Tww2LsDN/YcGIoIU3nwMZT4T3YmHBSqLYePSJbFC0LLsaoqUGI5sd2H982/qKU8ECIia
 A6xSWqORz0rDnmtfC4s99i6cF/kppp9BxhA= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f857xcsg6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 05 Apr 2022 22:35:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpOLIGmn3C5J3akqiWMN7W8wRHnr41yyHLhetdOIe+4acxgj9P8xzrEvTp4h3zOGgwyvEiesWKABFnLUYL9n1sn39/MYN5RA04ROcCZF0vA2cNqJcBwnePpoFGOmCsD40Cbz7eCoBF9rL0WjDprr1xF7Lu9Ix39yVe50vsBvA//GNs/VF6WIvpw7Pg2mxVO7KmWxnV49gJOWkt8Ftg/mXi68rFL5NF0ciU5Bojdbp7hUNtt9gEknw3ep5TdRkFUyCkYXJTYxpuZYfMBn+xiYBbEvYC45tyn1gpqezwkXZvaCNDIzXZOM0J+jQU/8bX7dzw6XcZEoDQ2GNbKJhpmnZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShITf15ny2zRWck07X/nHVn9f/aMpMYn0Y1Jc8BIYHc=;
 b=YkEQCcOx3N7/LV/LMuSG4Fy03sZutaMr2P8nfc4Vemy9f1h2So0p8lQJ/wpcE3QVB3YQi2N57OQwNDBpAC0XsX41Yg3f9KJyi3hfWooWzYliKwu2Ga8V6doH8RrroRdOPH/I1QCnwiMN4Knj3wUh0EDMlsOUdYVuIcFQiqJ6+cRtcEJjR/+Ez47T1G8lnSxtxm/ECwnbqHpjikchKZ94leAFPuSd8DSysfNzuW+XqDZXkJLRMYIJCKX0pDto+8YEowVT59UBtgh13753je0exC+zzidTftiaqr9YuodX291+rXxrW8pQHTkmXwscF7gwE45I+f2xsVOlTD/o4kP2Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by BYAPR15MB4117.namprd15.prod.outlook.com (2603:10b6:a02:c1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 05:35:07 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a%6]) with mapi id 15.20.5123.025; Wed, 6 Apr 2022
 05:35:07 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 3/4] bpf, x86: Support BPF cookie for
 fentry/fexit/fmod_ret.
Thread-Topic: [PATCH bpf-next v2 3/4] bpf, x86: Support BPF cookie for
 fentry/fexit/fmod_ret.
Thread-Index: AQHYOM8IO1xa8/UtYkS3jv5jd0HQ6KzFhuUAgAT9CYCAAB8sgIAANuSAgBekhYA=
Date:   Wed, 6 Apr 2022 05:35:07 +0000
Message-ID: <9052649c76d7198f805424c34d145ce964cadb5c.camel@fb.com>
References: <20220316004231.1103318-1-kuifeng@fb.com>
         <20220316004231.1103318-4-kuifeng@fb.com>
         <20220318191332.7qsztafrjyu7bjtc@ast-mbp>
         <CAEf4BzZF02Jn3PP8LJ7oF55ogPOePt0Wt8+Dtmj5fN0r7PfU0w@mail.gmail.com>
         <CAADnVQKo2xiOYrUG_Mb9OTAO_Sa7uahkYL-UEbu02GD=Sr8BJA@mail.gmail.com>
         <CAEf4BzbL0SBN_1MG4r3boErrz73DRMK5v_6mEjHgMMXgix_b9Q@mail.gmail.com>
In-Reply-To: <CAEf4BzbL0SBN_1MG4r3boErrz73DRMK5v_6mEjHgMMXgix_b9Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d979b151-044a-437f-9d60-08da178f3583
x-ms-traffictypediagnostic: BYAPR15MB4117:EE_
x-microsoft-antispam-prvs: <BYAPR15MB411792B320D9586E876DD7D1CCE79@BYAPR15MB4117.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ocBtCCXM9s6G2oQ1hr5jWMrJmD4zXRvmz/geW33qFr7J35LFPFTVGrCLvNzRa3a3D36YrnNrdt1jnAMAa7nJhrqQ08J1pUIXv10TPfnWh3YivTCbT31xiwWAWBCTRdiPwP3deX+yfn1oYCV2DFysljXVuTbVSvzFE2bG2V1yk/qJHFiYarwK/yx008fMXI026HKlYABCqcdv0LjU9vv6RuhPtgYtQjWzv0zbQqCgkH1pgf26tib1W4qxd4EGRQ8APviG5ibA1GFxFOFl79txq7JF4uZlz6SID+pE12Ay/zgQU6qvyEtQt5+YXrYjJKDTKKz3i7ImOpPtgMkXbn1shTN34mNdC7TknLZ7+CEDrYye+x9086Y3ABGYupuph3FG3L+XloN0zEZCmUGaIaukbcWwM1Oi3xoKZj45eOuOq3m7obvDmGMHP3ygNVp0CB0k3twtPgH1udjqW5IZgE1yKvgL75V34KADJkNBVPobzPZcdjCqku2CllXeb/VGjAV/Zk4BSGoE7sd4KfQKozDK2vtgRVkac2bXb/q58Jqv59HA4tPV/crb6pUFAwYPLwcrG0GD4IOTMIDqyi50sdkzjDqE2IIIciL13QaEgEQirCxNOBvWEnTpqrjS/FlgbcdWfsbIci8kFbl5c/00ruuLuOcuL1V5cPIoY65C0fgWFbi6FToG1KsRVfoh8Afz4Md/256CWmaqGv7wHFYsW8MFfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(86362001)(8676002)(66446008)(76116006)(4326008)(122000001)(6506007)(53546011)(66476007)(64756008)(8936002)(66946007)(5660300002)(38100700002)(66556008)(6486002)(71200400001)(38070700005)(316002)(54906003)(186003)(2906002)(36756003)(110136005)(2616005)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlN5ZzhuZllqek84aUs3OXNZRkt1SWFjbitlSk43OUVFSEtFODQrd3VNTElF?=
 =?utf-8?B?MlFBajcxQmJ6dEtnVXB5eTBMRGFKbHd2ZVlORWhQNnlVVVZsK1JldGRaMW9n?=
 =?utf-8?B?ekhMRUFHMkdYNzNYZmRzb0VRaUhzNzV1b1VPM3IwS0lwUVphSUw4S1RFbkhn?=
 =?utf-8?B?MHJvSnVneUtWYnlCNjQwb2p0VlRuYThBZ2dlM3QyV0hwOHMzNDZ1UGVIM2s4?=
 =?utf-8?B?a2FoUmlvSm84YzM2QzVndTJKaUJVOHdacldnelY2ZlY0b3JSUmNUaGRGVDlI?=
 =?utf-8?B?YVc4VTlWSEZDVENLdngwamlNbU8wOEUraVd3NkhyczM2cmd6OWZxWWd6b1Zz?=
 =?utf-8?B?c0JmQVI2allHQ29XRkxXdCtMSFd2cGhCR01kd0dRUVc2MzVxUFgvMU85azRG?=
 =?utf-8?B?SGluRCtST3U3enlZZUN1NUtDOEVrVmFwTzRYVVV3OTlyaXVBZTcxSDlVbFlL?=
 =?utf-8?B?L2taOE5hQy84Y0IrRFRhcmo4cjNNWDU0SFY1Tm5YNjRiMzhWUzNSa0EzNkcz?=
 =?utf-8?B?dDlDajZtQzNZYVhaT0xEZHBTSy91bE5Uc0RPMER0WHR5WGFUZlp2RVJmMWxV?=
 =?utf-8?B?a09ydm1rVStrOWhRcjQ0Mlg2Y2doQXBUcXEvZ1dOTHZzZFBGRkIzMlU5YUlY?=
 =?utf-8?B?NHRnOEhjN2QwYVIwZDk3czlQMm1aNlpIbFRLMkQ4SzNOUDd6TGU5UUI1QmVD?=
 =?utf-8?B?WmtoSnVlUVAwRStHemJDeFlPa1BQRXc0a2h2ZmRpUVdTNmdVU2pZUGNSV3Er?=
 =?utf-8?B?V1JkU3FzcTloTk03bW5aL25neVBpRDNmZGRiakZaendrN3hDK0dtbFpsVkFM?=
 =?utf-8?B?aVNJRU1nWjlRQmRMeVJ5azFHckd6TG5OVTRxQ2FzYmtVR010OTl2R2pPVG9S?=
 =?utf-8?B?Y05IZjk1WWU4OGVQYjB6aGlUWGo1bENXREhlUTh3ZmJhaTBLdHQrN0RDWUkv?=
 =?utf-8?B?SkwxMlVTZ3hzbldNU0VkZ0VxQ0JXMU1zL3E3WXBOdG9mTjRoNkdGaytXZnlk?=
 =?utf-8?B?cWMyU2dOODU0SE1idGtnRXFkV1ZwWi9uZ085c3ZlTEZWV2FMakxrZWg5SUQw?=
 =?utf-8?B?cHVUVzNsbnRoSHFQR3o5LzFEUURYZnZjY1RRcEJ0dVlvTUhMb1M5amVSeVV5?=
 =?utf-8?B?bGR1WUcxajNWajJHSXBYM0h0bVBWWjlUNlhtbHRkdk1PRUhtZmt3QmlGbG1W?=
 =?utf-8?B?UTFPL3Q1VU1NdnNnNEhBSlRaZDcwRk8vajh1aS9kRC8rZzNIc1drRnVTcm92?=
 =?utf-8?B?TzRWdkdaKzV0bTRVQlo2VWtvR0NUTWFjSlBzZnlpQmEwODJYMU9JV0lSWEsw?=
 =?utf-8?B?RVR4UEwyODBGdmVyQllhYkUvVHpBeWRQSGVNT3RyQmVpYzcrN0xMeHRBOTQw?=
 =?utf-8?B?RG5TNWFVRlF2alBMMDJON1RGbi9HQUJQcElUT25raDV3UHRSTHJORmk4VW5U?=
 =?utf-8?B?SzJoWU9LVDFpdUNHaWN0NS8raGtQT0owcWFnKzY0NzZjZHZ1R0M1SnZoLzBZ?=
 =?utf-8?B?dVhWUGllU3ppOVhRYnphS01MbzZyTU5JQWlzMkRkWHhaZzlMbDY5c2VHd3pN?=
 =?utf-8?B?blRxVFRJYy93RDdpYVE1YWVMZ285Z0E0T0hndWNTUlVUanNicml4Qk5UbzJt?=
 =?utf-8?B?RHlRN0h1ZzVjRTJUSVN0WjkraEQwTllTa2pXNEY0TVMyNlpOQkE1aUVVR2tv?=
 =?utf-8?B?aFRycFQxVnpGU09ZR0sxdXI3cDZjL0l1Zy93UXFkb0hpdllOSjlXbmx2Unpx?=
 =?utf-8?B?d0t1K1BJQXdZa3dSZjJYNHhSUzBPaWlybVl5MllQeGorMVEyTDhxZTZZZ2U4?=
 =?utf-8?B?OTJ3WlRweWZnb3M4S2VUWC85Q2kyQ2VBbG9SQ1FNTFFObSsvNW1jM0plUFpp?=
 =?utf-8?B?dkRTSWUyQm1RTWhqUVdXbW1WeDNwOW04bXJaWXY3MkdWNTZOdzUvcVE3bDZM?=
 =?utf-8?B?MmoxWlNsZU1rN3JZQ0laeTg3K0ErempFUUk0OGVmUnRiaHAvQ1lndXA2dGtJ?=
 =?utf-8?B?QmdDVWptcUI4T0Z5QVZzSVgrZXlyc2doYzFOTDlJbmlmbXovNTdmb2NrYUwr?=
 =?utf-8?B?TEVMUS9ZV3gwdFM5dkFGS0ZXNzRSd2JHTG43ZXFmaXZkL2lyVFMrdmxsOUhr?=
 =?utf-8?B?dk5CVHNETTFMNGpoM1R3L01xa050UHg3Nmp3NlJnZEUvZ0xOanRoNWtwQTcw?=
 =?utf-8?B?YktyblRGbkZseEQvaUh4QUVrWFI3RWRaYjNFUVR0azN0TFZqVllnNG8reWpC?=
 =?utf-8?B?UXdCbGVKb21xai9LKzB5R2x0SG5Yd0xuUWwrWFhMbWloK0RGa0dmUmVTNDhY?=
 =?utf-8?B?TVlDVmRiTEQzaCtWVm9qTFIwandhSW5jbUxTTU9kT1NyaktyNFZjNks5TEZN?=
 =?utf-8?Q?Yd58I8ru/uPbEn+U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18DAAEBFD26B4247803474A1C8347E2D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d979b151-044a-437f-9d60-08da178f3583
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 05:35:07.0676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RcJtFyyZzZsT8XcH+XL5Vou3VfZVm1WLs/so1c0T7gGqQdr0J5mn2uTp8/b5rTVV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4117
X-Proofpoint-GUID: KUOctWKeKoRNb2fgSp-rqE_wCKPFEf5N
X-Proofpoint-ORIG-GUID: KUOctWKeKoRNb2fgSp-rqE_wCKPFEf5N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-06_01,2022-04-05_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTAzLTIxIGF0IDIxOjMyIC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IE9uIE1vbiwgTWFyIDIxLCAyMDIyIGF0IDY6MTUgUE0gQWxleGVpIFN0YXJvdm9pdG92DQo+
IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBNb24s
IE1hciAyMSwgMjAyMiBhdCA0OjI0IFBNIEFuZHJpaSBOYWtyeWlrbw0KPiA+IDxhbmRyaWkubmFr
cnlpa29AZ21haWwuY29tPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gSSByZW1lbWJlciBJIGJyb3Vn
aHQgdGhpcyB1cCBlYXJsaWVyLCBidXQgSSBmb3Jnb3QgdGhlIG91dGNvbWUuDQo+ID4gPiBXaGF0
DQo+ID4gPiBpZiBkb24ndCB0b3VjaCBCUEZfUkFXX1RSQUNFUE9JTlRfT1BFTiBhbmQgaW5zdGVh
ZCBhbGxvdyB0bw0KPiA+ID4gY3JlYXRlIGFsbA0KPiA+ID4gdGhlIHNhbWUgbGlua3MgdGhyb3Vn
aCBtb3JlIHVuaXZlcnNhbCBCUEZfTElOS19DUkVBVEUgY29tbWFuZC4NCj4gPiA+IEFuZA0KPiA+
ID4gb25seSB0aGVyZSB3ZSBhZGQgYnBmX2Nvb2tpZT8gVGhlcmUgYXJlIGZldyBhZHZhbnRhZ2Vz
Og0KPiA+ID4gDQo+ID4gPiAxLiBXZSBjYW4gc2VwYXJhdGUgcmF3X3RyYWNlcG9pbnQgYW5kIHRy
YW1wb2xpbmUtYmFzZWQgcHJvZ3JhbXMNCj4gPiA+IG1vcmUNCj4gPiA+IGNsZWFubHkgaW4gVUFQ
SSAoaXQgd2lsbCBiZSB0d28gc2VwYXJhdGUgc3RydWN0czoNCj4gPiA+IGxpbmtfY3JlYXRlLnJh
d190cA0KPiA+ID4gd2l0aCByYXcgdHJhY2Vwb2ludCBuYW1lIHZzIGxpbmtfY3JlYXRlLnRyYW1w
b2xpbmUsIG9yIHdoYXRldmVyDQo+ID4gPiB0aGUNCj4gPiA+IG5hbWUsIHdpdGggY29va2llIGFu
ZCBzdHVmZikuIFJlbWVtYmVyIHRoYXQgcmF3X3RwIHdvbid0IHN1cHBvcnQNCj4gPiA+IGJwZl9j
b29raWUgZm9yIG5vdywgc28gaXQgd291bGQgYmUgYW5vdGhlciBhZHZhbnRhZ2Ugbm90IHRvDQo+
ID4gPiBwcm9taXNlDQo+ID4gPiBjb29raWUgaW4gVUFQSS4NCj4gPiANCj4gPiBXaGF0IHdvdWxk
IGl0IGxvb2sgbGlrZT8NCj4gPiBUZWNobmljYWxseSBsaW5rX2NyZWF0ZSBoYXMgcHJvZ19mZCBh
bmQgcGVyZl9ldmVudC5icGZfY29va2llDQo+ID4gYWxyZWFkeS4NCj4gPiANCj4gPiDCoMKgwqDC
oMKgwqDCoCBjYXNlIEJQRl9QUk9HX1RZUEVfVFJBQ0lORzoNCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0ID0gdHJhY2luZ19icGZfbGlua19hdHRhY2goYXR0ciwgdWF0dHIs
IHByb2cpOw0KPiA+IHdvdWxkIGp1c3QgZ2FpbiBhIGZldyBtb3JlIGNoZWNrcyBmb3IgcHJvZy0+
ZXhwZWN0ZWRfYXR0YWNoX3R5cGUgPw0KPiA+IA0KPiA+IFRoZW4gbGlua19jcmVhdGUgY21kIHdp
bGwgYmUgZXF1aXZhbGVudCB0byByYXdfdHBfb3Blbi4NCj4gPiBXaXRoIGFuZCB3aXRob3V0IGJw
Zl9jb29raWUuDQo+ID4gPw0KPiANCj4gWWVzLCBleGNlcHQgSSdkIGxlYXZlIHBlcmZfZXZlbnQg
Zm9yIHBlcmZfZXZlbnQtYmFzZWQgYXR0YWNobWVudHMNCj4gKGtwcm9iZSwgdXByb2JlLCB0cmFj
ZXBvaW50KSBhbmQgd291bGQgZGVmaW5lIGEgc2VwYXJhdGUgc3Vic3RydWN0DQo+IGZvcg0KPiB0
cmFtcG9saW5lLWJhc2VkIHByb2dyYW1zLiBTb21ldGhpbmcgbGlrZSB0aGlzIChJIG9ubHkgY29t
cGlsZS10ZXN0ZWQNCj4gaXQsIG9mIGNvdXJzZSkuIEkndmUgYWxzbyBzaW1wbGlmaWVkIHByb2df
dHlwZS9leHBlY3RlZF9hdHRhY2hfdHlwZQ0KPiBsb2dpYyBhIGJpdCBiZWNhdXNlIGl0IGZlbHQg
bGlrZSBhIHRvdGFsIG1hemUgdG8gbWUgYW5kIEkgd2FzIGdldHRpbmcNCj4gbG9zdCBhbGwgdGhl
IHRpbWUuIEdtYWlsIHdpbGwgcHJvYmFibHkgY29ycnVwdCBhbGwgdGhlIHdoaXRlc3BhY2VzLA0K
PiBzb3JyeSBhYm91dCB0aGF0IGluIGFkdmFuY2UuDQo+IA0KPiBTZWVtcyBsaWtlIHdlIGNvdWxk
IGFscmVhZHkgYXR0YWNoIEJQRl9QUk9HX1RZUEVfRVhUIGJvdGggdGhyb3VnaA0KPiBSQVdfVFJB
Q0VQT0lOVF9PUEVOIGFuZCBMSU5LX0NSRUFURSwgSSBkaWRuJ3QgcmVhbGl6ZSB0aGF0LiBUaGUN
Cj4gInBhdGNoIiBiZWxvdyBsZWF2ZXMgcmF3X3RwIGhhbmRsaW5nDQo+IChCUEZfUFJPR19UWVBF
X1RSQUNJTkcrQlBGX1RSQUNFX1JBV19UUCwNCj4gQlBGX1BST0dfVFlQRV9SQVdfVFJBQ0VQT0lO
VCwNCj4gYW5kIEJQRl9QUk9HX1RZUEVfUkFXX1RSQUNFUE9JTlRfV1JJVEFCTEUpIGluIFJBV19U
UkFDRVBPSU5UX09QRU4uIElmDQo+IHdlIHdhbnQgdG8gY29tcGxldGVseSB1bmlmeSBhbGwgdGhl
IGJwZl9saW5rIGNyZWF0aW9ucyB1bmRlcg0KPiBMSU5LX0NSRUFURSwgc2VlIGV4dHJhIHNtYWxs
ICJwYXRjaCIgYXQgdGhlIHZlcnkgYm90dG9tLg0KDQpJIGp1c3QgaW1wbGVtZW50ZWQgYW5kIHRl
c3RlZCBhIHBhdGNoIG9mIHRyYWNpbmcgbGlua3Mgd2l0aA0KYnBmX2xpbmtfY3JlYXRlLCBzbyBp
dCBjYW4gYmUgZG9uZSB3aXRoIGJvdGggcmF3X3RwX29wZW4gYW5kDQpicGZfbGlua19jcmVhdGUu
DQoNCkRvIHdlIHdhbnQgdG8gcmVtb3ZlIHJhd190cF9vcGVuKCkgZXZlbnR1YWxseT8gIFNob3Vs
ZCBJIHJlbW92ZQ0KcmF3X3RwX29wZW4oKSBzdXBwb3J0cyBvZiBjb29raWVzPw0KDQoNCg==
