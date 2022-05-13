Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048485267DE
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 19:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382739AbiEMRF2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 13:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382736AbiEMRF1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 13:05:27 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D4A5A59E
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 10:05:24 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24DFAc7V030602
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 10:05:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Bdc5n2MWl1y4bbHwyvo7gV0BBE68O15MjyUekQneFnw=;
 b=Y6O8Zym2Qs/aYoxIGhzroCc2YeswFkFjXw6vRkMaJcPgwYeDdGfSGjKLPaZtG81a4kmB
 bWwCWM8WgbLnti1uSnk8Doe5sd3d0iB7Rv+96r5R0pnBrHBdXCpA6TGxgzWntmSNKqVA
 fbNr1KzvEy7skuQChbhCqtlz7KHXB1iEwnc= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g12mtstyu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 10:05:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2Io1yc/vHgzbQrwiS8Fd2CFRtQOU4/KrGh6eYQRXO3RpuMo7YYjLyRK7TYdqWHcISs9Cr+UWJgttL0I6eUkyRk7gL2Z9g3uIN9T4jciMQLS4F7stA090pdaxm1z32jdEvDUgqPW14xZgf8tzr5B7bhPMAEGyBfZ7mdlzl4nMMV/y/METJBNDwcGsWuZAEEs88qhQ5QMH6JNHEVE8yYWGgce2uupEkV7QuntLiAiJZJ9h1eVS8p8s48fcAsS6mTZkHe9gm8XlXCWiPmx1cgjc1HMJRaNz24hIvovEAMTEmJYOy/lIHu31S6DGT77QM6x7bETpquuYMkYK8lr0N1ngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5DvUotwmnpknyeTTcZDybuTIF2ylw0GmEHKgRHKLW4=;
 b=ahoDxIq68LdImHgNFsQcUflqcVTLph70MaUUvX4OXAaVg46Mi1XxX12VpcIwqRMky68AUQX6DW6en2KGGUG/mFupKE0JVPzF6psOsiO8vrYGtplBMH75vfazwByRGn4NoA8VK31V08KG4DiiGsdGVWEca6RTjV5JJWeE/j2ZPrHeFVFlCLrgKmGwaLNtVf8dA3SFdHEa0vmOyFWNbzggb4kaTwTj1QnvrPeHDfhC1AGzysRjhH7tCFNroq2TQNIjWc6axQkMCTq0RAUm8SLbzTss0P7SHt13dIVx1plR2PEPLcCfUdnvAMQW5fIbnw8vuY8LF6aptjwec8rrDFzMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BYAPR15MB2549.namprd15.prod.outlook.com (2603:10b6:a03:15c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.16; Fri, 13 May
 2022 17:05:21 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%4]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 17:05:21 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 2/5] bpf: implement sleepable uprobes by
 chaining gps
Thread-Topic: [PATCH bpf-next v3 2/5] bpf: implement sleepable uprobes by
 chaining gps
Thread-Index: AQHYZmfvguvoJCxIhUOr//cQtqUQ+K0c+GYAgAAQpQA=
Date:   Fri, 13 May 2022 17:05:21 +0000
Message-ID: <d902c2267ffbf744a455ead43c2766ff39ca38fa.camel@fb.com>
References: <cover.1652404870.git.delyank@fb.com>
         <1b9c462226d2d7b97293e19ed2d578eb573a4544.1652404870.git.delyank@fb.com>
         <861a77c8-80dc-7360-d7a6-d8eabc84461b@iogearbox.net>
In-Reply-To: <861a77c8-80dc-7360-d7a6-d8eabc84461b@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f982670-dff0-4d1e-9b8f-08da3502c3bb
x-ms-traffictypediagnostic: BYAPR15MB2549:EE_
x-microsoft-antispam-prvs: <BYAPR15MB2549C1FEDB2E9C6D4D1F5648C1CA9@BYAPR15MB2549.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b4MWYA4Kj3Vk12qS5R0H1TnCzROlmIyzqht8N367QBE75SKDstX7imVxg4/9mruUsJfy1IMSUpAFw6KT/M+WBC+gO6+fIme3MmXXM7FUZ02bc9i7bcR+nRAdsTr66LsqTCgU+MviDuRBu7lAn6zTAB6KH8mILfHaO/Xq8ly0AFA4dm4P+EAKI0zWp+iHEv+LI/xfzLiJX/5i/zGKaxIbCRpoe3anleRYoawqdeOKngCdq9c05dduDdcXGfAvDABKni7KmCejkzlxp2JYN3wfd6+k3GZIakI6Lu/7ccqYnpxtRUeDthydv1kQtpGJyF5wo7yrkdonIF3mhd2Amdj9GJJLenhVYTOITbD4uOeRctOaUjsfvEIRM+j/A4AhMfgVfP4Kt4uMxf/fMY2ZmbCMKvzcfakeD7eAnW7Hg1p2HGM+YYj3sSLEMkfRMqU1Nd7FvikxkYyQhnk3pujzypTfEnJBF4FrGk3/KdaGWEgUva/DEM4Nn6tVjtj66zJZFTrPjsU8kjheMtVgqWRv1rFtIQTQjlsmZ5TX4ncVBpa/nMSvTdSnAWLzbvkvTBRTC7G2EWq8FIduaqKeF2rRc5FbuevKjxZeWOY29T5XzhMmrIfDAcfDNbgvwclo7NwujwbRt5lSvPLGrCGevvhR2aMao8494EylJrBsNXCniaoMds1cfuA2pkW4H5f/SuzUEZbGfTXOq2Y2Th5sAe2Lxik3sA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(36756003)(6506007)(122000001)(66476007)(71200400001)(5660300002)(53546011)(2906002)(110136005)(316002)(83380400001)(6486002)(966005)(186003)(8936002)(86362001)(38100700002)(38070700005)(8676002)(508600001)(91956017)(66556008)(64756008)(6512007)(76116006)(66946007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjJvQmtRRUlxMEdub0FGSTYySUlJWVF6dXlwVUZHdUdFL2N4Tkh2QkNHeXc4?=
 =?utf-8?B?citEV21nMnE5eXF3Q00zRVFpS0ZFT1N0L0k3MDIrektIT1JNV0trcE1Vekw1?=
 =?utf-8?B?VEdkNWxBN2dKNFhLMlVtK3B4RVdNWklwbENDYzNnc2I2VjNNUm5FRkN4VjhD?=
 =?utf-8?B?alU0c2N3Z3ErcEN1WjRiUEYrWEpRSUJpQk9KRTRCSTJOWngrem5tOUR5K1ZS?=
 =?utf-8?B?bzhaZ1ZkTzdhN3NpeUIwTlhLUHM1My9udmFZS2tFRGNMb0twVnBGdkdhQ0ZB?=
 =?utf-8?B?UjBsVnZ1NXdxVVJOMjA5UU1oNnQrZ0ZxME0zT21RTmE5RHNGZS96dndhQ0NS?=
 =?utf-8?B?VVRqUXdvMXhJdi82ck9wemsxZnFFQ0Y3TTNXcmZzNGFmZnpia2pDazJ4NFlN?=
 =?utf-8?B?RnRhNUJzcFRJRlZRMkViTGJDZjYzazBDc0JtS2kzc0pGZUl1clh4Mm8vK1lO?=
 =?utf-8?B?cm5wN0JCa1o2RXhpSnlVVUNvc2lhOW9pWWJLZzRuQlpOZEVKU3ArSGs3NElG?=
 =?utf-8?B?ejJ0ejBaYTRMS3Q4eGg3K3hEWEJDWTlkSWdjWWl1VndCdzBoSEIrT0ZjNktV?=
 =?utf-8?B?Lzh5V01tazZiSUgza0NUN2FyM0VFTlpLTWJvczFoZDVaNHdTb2FRVUFLSG1o?=
 =?utf-8?B?KzRXQTZERGRwVDA2R0p6VTYyL2tjWWlxQnBkUXpuRGRUaE5DcGFRSnpWZUl0?=
 =?utf-8?B?a1VZOGs3VHVQRWNSdVAxcEZaT0hwZk12czlvL2pwRnl5T3VZVlhrVnJ0QlBE?=
 =?utf-8?B?OUJQZ090WEd0dnRob01PaXVQOGpVaTlaZDMySjFPczdXV1N5YS9veTZtYjUy?=
 =?utf-8?B?RnorcDZ1QmY0TnluQmNBVEQva1J4WlZuTlRuYjZFVHNUTG9GY2tZaTg5OTdH?=
 =?utf-8?B?SVJDTFI2d3VSRll2ZGFQQjAzWkJXUm5XWDhsR1dUaVJlNmJlZnIvMk5CMTEr?=
 =?utf-8?B?Z2Z0eGhDSWhEYXBVZ1Ewd2FuZENFK0dFa1lVUldhZ1JQTyt3QW1EWEJzZnRC?=
 =?utf-8?B?YWltejhTQXpkYTJzQlU5V1VFTURaM3JzQ1dCSG4xYnNWeEt5cWQwK1dYVjJj?=
 =?utf-8?B?OGFkR2lmMTlvTUE5Z040Z3lWU3dQVmwrYko2bi9JVitMSHpvMTB6VGswYUZr?=
 =?utf-8?B?UzN2SlJGN2hNamRLMEFpdVE5TEdIdkZJYWFZV0tLL253cThsN3lqQUFtYXpM?=
 =?utf-8?B?b2pmZVlTWWFjV205MzZDd0tBM1JERlZORlpQRThjYVBwOFMxRjhyWGRuQ3Jz?=
 =?utf-8?B?b3AwbGNsR3ZOS09XZnFKSzZFMWJsbXhyL2VZOFlmZnhWbXhWTC9OZTNtWDNS?=
 =?utf-8?B?MzY1MzMxTnhneU9kaHcyQnU1aDFCa2hKdG1CbStIZlNaY05zM0pOelRTMXhp?=
 =?utf-8?B?L1lTOE93TVRmdXpiTjBobExGbDhaT1BGNGNPckM2ai9JTVU5OEFtT0lhSlpW?=
 =?utf-8?B?dStOUHo2Y1lsVFZDM0lMTkFsYnRZNXNrMG1HMkJUSWFycml3UGdnMjNObmFn?=
 =?utf-8?B?M1k2bTJyRXVNc2xPcUN3SVdnbGoya1hMUTZxQTFKVWx1L3h2VUQyM3pUZXBH?=
 =?utf-8?B?dWlTVlNER2l0VlRFS1QrNFRYVkxwT1IwM3R4Y0FMRG1yQ3pXYm1ObzI3ZEhS?=
 =?utf-8?B?blA5ZGFZQ3RBVUprVkFPUUhSajdFektuby9mUSthUGNrTlRkZUp6ZHpIZUxr?=
 =?utf-8?B?T3JCL2UrMDBFVTlWZUs4dUNyUG9RVG5qUHBHZWErNklhdVV6K0VqcTZXb3cz?=
 =?utf-8?B?bGpnYmxBZUh3VldWQkdLSWJSS2NSY1N1YWcwSFVLNUhEWFcyd05QTXI1Vklh?=
 =?utf-8?B?c1cydVJoZVRhWG92ZTEwdm5mTnRmK1pwYjFrdnd6TjZYeXZpWTR5VE1DM1Ba?=
 =?utf-8?B?dGxoR0FVRlI0UjIwaGNhdjVXU0dtYlFRZlFnN3hySjd6cmRzOWNWNDlLVmJ2?=
 =?utf-8?B?bGJqT2JTUWVJN1lkMHpLd2xZSGJTamtKVUQrWXI1QWxYTnhjNjB3amdVQkVY?=
 =?utf-8?B?a1UzN3N1ZGJMc2NiMXl2QjFHNEFGNmg3cTBnMmRSRU9VYkZsNjR2TmVRT1Bh?=
 =?utf-8?B?QmEzWWEvYjAwZy9GaGFkM0xMTjMrVEhxd2VMald3SW1Sby9OY1FIYkNzTjMv?=
 =?utf-8?B?QVJPZW9zK1pEdmdZWG1ua0tweWJMcXUyNksrQXJPUDNhUVBTM3d2UXVGcitQ?=
 =?utf-8?B?VUtqS2E3VCtxenUzcVNqS0dUYzFoZnZUbFNRT2U1ZjBpRVVrbEZRaUhueWx0?=
 =?utf-8?B?UWYrbTFMZXVkWDg0QTJrUE1FMGx1L1BpTmVOZUZlcHFaby9hS05uQlZxNWpV?=
 =?utf-8?B?S21HMnVGTUhYZlNwQUw4RWJBaDk3Wmt0Zm9SbzQxcmtkRkV4UE1EcnNORStv?=
 =?utf-8?Q?oWNzHbFGzV8CvNrJJAHNHbCQ7fqvmBYIt4TSd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF62B1D861AB4640834631CA1896F2EB@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f982670-dff0-4d1e-9b8f-08da3502c3bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 17:05:21.6092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U3xdUV/byJzzJ7dly9R5LYitF44LWMO4c6i3sD899n1Y6jToGCygP/IaU1YJgtPj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2549
X-Proofpoint-GUID: Eyy4CTMlC9JJDH_IREPzR89DuZFZ2dGX
X-Proofpoint-ORIG-GUID: Eyy4CTMlC9JJDH_IREPzR89DuZFZ2dGX
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_09,2022-05-13_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gRnJpLCAyMDIyLTA1LTEzIGF0IDE4OjAwICswMjAwLCBEYW5pZWwgQm9ya21hbm4gd3JvdGU6
DQo+IE9uIDUvMTMvMjIgMzoyMiBBTSwgRGVseWFuIEtyYXR1bm92IHdyb3RlOg0KPiBbLi4uXQ0K
PiA+ICAgc3RydWN0IGJwZl9wcm9nX2FycmF5ICpicGZfcHJvZ19hcnJheV9hbGxvYyh1MzIgcHJv
Z19jbnQsIGdmcF90IGZsYWdzKTsNCj4gPiAgIHZvaWQgYnBmX3Byb2dfYXJyYXlfZnJlZShzdHJ1
Y3QgYnBmX3Byb2dfYXJyYXkgKnByb2dzKTsNCj4gPiArLyogVXNlIHdoZW4gdHJhdmVyc2FsIG92
ZXIgdGhlIGJwZl9wcm9nX2FycmF5IHVzZXMgdGFza3NfdHJhY2UgcmN1ICovDQo+ID4gK3ZvaWQg
YnBmX3Byb2dfYXJyYXlfZnJlZV9zbGVlcGFibGUoc3RydWN0IGJwZl9wcm9nX2FycmF5ICpwcm9n
cyk7DQo+ID4gICBpbnQgYnBmX3Byb2dfYXJyYXlfbGVuZ3RoKHN0cnVjdCBicGZfcHJvZ19hcnJh
eSAqcHJvZ3MpOw0KPiA+ICAgYm9vbCBicGZfcHJvZ19hcnJheV9pc19lbXB0eShzdHJ1Y3QgYnBm
X3Byb2dfYXJyYXkgKmFycmF5KTsNCj4gPiAgIGludCBicGZfcHJvZ19hcnJheV9jb3B5X3RvX3Vz
ZXIoc3RydWN0IGJwZl9wcm9nX2FycmF5ICpwcm9ncywNCj4gPiBAQCAtMTQ1MSw2ICsxNDU0LDU2
IEBAIGJwZl9wcm9nX3J1bl9hcnJheShjb25zdCBzdHJ1Y3QgYnBmX3Byb2dfYXJyYXkgKmFycmF5
LA0KPiA+ICAgCXJldHVybiByZXQ7DQo+ID4gICB9DQo+ID4gICANCj4gPiArLyoqDQo+ID4gKyAq
IE5vdGVzIG9uIFJDVSBkZXNpZ24gZm9yIGJwZl9wcm9nX2FycmF5cyBjb250YWluaW5nIHNsZWVw
YWJsZSBwcm9ncmFtczoNCj4gPiArICoNCj4gPiArICogV2UgdXNlIHRoZSB0YXNrc190cmFjZSBy
Y3UgZmxhdm9yIHJlYWQgc2VjdGlvbiB0byBwcm90ZWN0IHRoZSBicGZfcHJvZ19hcnJheQ0KPiA+
ICsgKiBvdmVyYWxsLiBBcyBhIHJlc3VsdCwgd2UgbXVzdCB1c2UgdGhlIGJwZl9wcm9nX2FycmF5
X2ZyZWVfc2xlZXBhYmxlDQo+ID4gKyAqIGluIG9yZGVyIHRvIHVzZSB0aGUgdGFza3NfdHJhY2Ug
cmN1IGdyYWNlIHBlcmlvZC4NCj4gPiArICoNCj4gPiArICogV2hlbiBhIG5vbi1zbGVlcGFibGUg
cHJvZ3JhbSBpcyBpbnNpZGUgdGhlIGFycmF5LCB3ZSB0YWtlIHRoZSByY3UgcmVhZA0KPiA+ICsg
KiBzZWN0aW9uIGFuZCBkaXNhYmxlIHByZWVtcHRpb24gZm9yIHRoYXQgcHJvZ3JhbSBhbG9uZSwg
c28gaXQgY2FuIGFjY2Vzcw0KPiA+ICsgKiByY3UtcHJvdGVjdGVkIGR5bmFtaWNhbGx5IHNpemVk
IG1hcHMuDQo+ID4gKyAqLw0KPiANCj4gQnR3LCB0aGVyZSBhcmUgYSBudW1iZXIgb2Yga2RvYyB3
YXJuaW5ncyBhcm91bmQgeW91ciBzZXJpZXMsIHBscyBtYWtlIHN1cmUgdG8NCj4gZml4IG9yIHVz
ZSAncmVndWxhcicgY29tbWVudDoNCj4gDQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmhvcHRvLm9yZy9z
dGF0aWMvbmlwYS82NDEyMDQvMTI4NDgyODEva2RvYy9zdGRlcnIgDQo+IGh0dHBzOi8vcGF0Y2h3
b3JrLmhvcHRvLm9yZy9zdGF0aWMvbmlwYS82NDEyMDQvMTI4NDgyODIva2RvYy9zdGRlcnIgDQoN
ClllYWgsIEkganVzdCBzYXcgdGhlc2UgdG9vLCBJJ2xsIHRha2UgY2FyZSBvZiB0aGVtIGJlZm9y
ZSB0aGUgbmV4dCByZXJvbGwuIExldCdzIHNlZQ0KaWYgdGhlcmUncyBhbnkgb3RoZXIgaGlnaCBs
ZXZlbCBjb21tZW50cyBmaXJzdC4NCg0KLS0gRGVseWFuDQo=
