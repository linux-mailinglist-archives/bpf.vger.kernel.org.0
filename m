Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EE458F1B8
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 19:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiHJRnj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 13:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbiHJRng (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 13:43:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B664986C24
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 10:43:34 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AGuRfp007416
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 10:43:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=VswsWNG2Ee4wcj/M23jWZAkxCh0QH1v+ikGGFgAkZag=;
 b=peM1ufvZ1OsYUE1D4GucTxbwht6RvdPukpU7orjG1/IJQvSur+uEtBi+/iGekfzOXdkR
 PFAxyS82+6j6lqWyl5B4V6E542NLFV+SeDUwRhPVm5IxHU+51g2TrUr+VDi1MRdCUJk8
 cPuItjYG0h8bwQz4y7aJF/UW9j2fysdM/Ro= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hvdb12cvf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 10:43:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBmH45iRCaQOcrGzQwIDB6s3lr82uWGphdpOt74qlmd4rga+TkDMV6Y+DR/Jgh9fS03zFqbYGvk+QlJJ1W7+2egR9MuBmGhjQgA+N1v605kFECgIPg+vk0kIwurNh9KkrK1ainxGZU0rCJNLp5ROzYGO1kwiIFtsQXC9Xr/4ELc9TAxoL1thmsUINMzh/6JUYW8toZ2qbZf4smxKhqs/wpFUxRCAzpl9OuYfy2EEGC3eMxyPWNgotGhD92cfkN1vY35NJOPRNIpvNhX4iM3K09G+5YXYo5tLvPkYfU5C/p0Aw6Ylcr/9fY8FyCoALaAD7S2n1Lshdfg/nN/ZrkzmJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VswsWNG2Ee4wcj/M23jWZAkxCh0QH1v+ikGGFgAkZag=;
 b=FitC9itPP8hydFhrOPU+zUbdef7rjKcEnjZZ3s1djBkHSXtrXU8tDx/2qqr+Lf/VI18Bf5nSlxBKa5dpmbE6YCv2+lJTPMXVP2h04L1Il2Bzbzk30/z49pmSky3OAcCjQ6+Xg6TffRuBpM0uBEZDGRJsQEUSQRs2xdvocdcCGEhmSSLsFiARvsmWzXhg00pIdReDhFGSHTFyxQnC+LZ3ocnSxjqmqbDh4LCO6wYrT3zPMO1PcdSwGZI9s4rtfzMIIFLmNfn/MRZNyhsM88nW7zoEQ09tLWpqegjrrTC20jGamSnB4BZ+90krtkcLWL61l2l3QSdUYmpEPQluMq8gkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by PH0PR15MB4765.namprd15.prod.outlook.com (2603:10b6:510:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 10 Aug
 2022 17:43:31 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f%6]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 17:43:31 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Parameterize task iterators.
Thread-Topic: [PATCH bpf-next v4 1/3] bpf: Parameterize task iterators.
Thread-Index: AQHYrCnrPMK/hfinLkaNht0cHU8UHq2nIeGAgAAGagCAACrSAIABFfcA
Date:   Wed, 10 Aug 2022 17:43:31 +0000
Message-ID: <ab83dc64c24287ab0506498ed1d4efd2b5fbdfa3.camel@fb.com>
References: <20220809195429.1043220-1-kuifeng@fb.com>
         <20220809195429.1043220-2-kuifeng@fb.com>
         <CAADnVQLjHpfFQDn_1mXj7+o6E8Dsmatr0jeozPAk5rV8hcLWfg@mail.gmail.com>
         <a667947bbd9da453017e2eb4b53b6523bdb110be.camel@fb.com>
         <CAADnVQLKExnPXWaCEuvTME6=VLUaQA52t_9NFTsXyrPj+213_A@mail.gmail.com>
In-Reply-To: <CAADnVQLKExnPXWaCEuvTME6=VLUaQA52t_9NFTsXyrPj+213_A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a2d3cf8-e184-4038-59ea-08da7af7d736
x-ms-traffictypediagnostic: PH0PR15MB4765:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZAZRo98xnofJOC7Nbv58DgY29jeobbGtXAF5daX/6HjOtsqgNay9SWGxpVB15QjT5H6oukVnHpPIq6rzots5+8kHRwTpUnG41+14bsRUE6p54IxLSrVtZ0Ephbw9I74axI5IdQhcjYQ/Ld9galeVsr8EcadIGbvLRBbTvIaTJ9Etf1ZZblUu+GU+nbfgl1drMBlURPam9+LG3jrXmRGWpJMmUuUUzh9Yvf+FIUX6pwTjEVbiTupoHSwCmlE+jOpAjfMTvqYa4e9yYnOL/dUo+B89A3nb4ocLWbgm30XtICDfzE8DHs3A0b+UMUgOpGArRL099wF+2Y9crWQ5F05S8iDkTuB1Ed1RPrpbnCGoo6QUXd4+ganCRtH4Q3YtCAk4geMKBJT10WHnulwroRv8Zmprs/BS+NPX/4KXw9oU4HHkYgexjAWmey5YNsDpxakFR1gRBCp6lLmW0f3qWDU6geXU19Uprzrk1JF+yvSa/P6Qqgy6pFfJGg8KuuitL2Jj5TgEbjArm6pZUCUattZ7SG1hZGDWOe3b08vniHR8dvITuZb8UjTqjz4p9WPBn9bOjYJJS+GFm7/UOpcdQsyq0R0oaED1YyDDlTdJ4prow75gLeJ1TVnThXLKH9WmINTkbXDnd8nJGHUWHy6DRUi1GVUfXY18IEzyOoKGqBe717Gg/WRC2SGasWSqK/KHYE9TBJAbxlxyddPfo7V3KhBWcY96H3NStmXJqBnERe1qNQ6vLPoPlm/1/gvTUFxL98tCJ+hP1scKTNbQqk81GlnLir/Me9FVctlSqPhExJTav0t4y1iT+IXpk0iIMYuMWxSP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(122000001)(36756003)(316002)(86362001)(2616005)(66556008)(38070700005)(71200400001)(4326008)(8676002)(66446008)(66476007)(64756008)(76116006)(54906003)(66946007)(6916009)(8936002)(6486002)(83380400001)(478600001)(5660300002)(41300700001)(38100700002)(186003)(2906002)(6512007)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGhMV3RpWHlNUU5icGhtRHR1R05JNGczUU9ZUzJDampaelRvRmg1N1BWVk1p?=
 =?utf-8?B?Q2p0SlFPZHlNSWEwcS94Nm9UZXVlNG9GSEJiZlRqK0FsQ1RiVCtWUTlDb0ty?=
 =?utf-8?B?U2wwU0dFb1dtM3RZa0NoQUFsbFFOK1hLeExLKzBZdFdZZlA5aVNvV1dIN2tD?=
 =?utf-8?B?dTFSYUZLaFNRWFNwRHMrWTZMOWdML0cvQXhIMnF5R2lXelNHU2hIMEFMYStj?=
 =?utf-8?B?d0d0UWY3Y2pjM1V1QXdjWndSeTBkOWRsRGFlMGNISFBwMWhEK1M0YUExMEJD?=
 =?utf-8?B?c0ZmOWIyVSt6emN6RXl5WUh5ditMV0IzWUQvaWhacEtmTWVlQ24rbnlUU2tT?=
 =?utf-8?B?RDlNSzFSTEpZNUVHQUYyVUJEVWVBTXNtakp0bWJSWFl5ZDFTSGJvS2VGL0dZ?=
 =?utf-8?B?SnRLWlVZcnlFUE1PQm5McUFIa0NERVd6QnAvTnZKcFdPc09XNGhiRGZ4VzNW?=
 =?utf-8?B?RHovdVNyQUp3bnVXRE1xS0NXUEJUTE0rMWhKcTZSUzRURW9CQWJlTjd3dkRT?=
 =?utf-8?B?VWJ5d0o1bmR6dHBobWUrYzZTTGhTYkh6dU9yNFdFRE5PTWxVT0orOTZ5MGN0?=
 =?utf-8?B?YW5Rbld4RElLY3Q3MVN0N3FwWmJRNTZkQzFyN0oyZjR2cGlOdWMzQm9oU1o4?=
 =?utf-8?B?TmJqc3YwRmFYSkgxOWxsdjd4U3Q5OUppYlNpWGZCWXBubzF1SEpvc1NCNzJ2?=
 =?utf-8?B?Y0doS2ZlTjhCOVV2SkRiaVhhSkJ0cUlMbU0yc3cwR044enhnMlJhdjVLV3Q4?=
 =?utf-8?B?YWphU2hPbXVPWFdRWWx4S3drNTVUUmJlN0hOU1hXOHZQeGRSZ3F2ZnNGbnRq?=
 =?utf-8?B?dVNWakNxZlptTkxBRW9tbVlybXZpMWFEZVZnQllHYVVkSFlld1M1V24vVVh4?=
 =?utf-8?B?Rll5ZTBQRUg2SEp4UUlOOGQvZmkwcjM1YkdCOXFtenFmbDNwOW1sN29vY3Jj?=
 =?utf-8?B?MGY5bWhuTUlreTlNZW9YMlF1VDJLTVd6Tmc5MWo0ZFcxc0ZxN3V3VHFtbU8z?=
 =?utf-8?B?WEZMbXc3Y04xSm15QWZhaDJXOVpRR2E5MGFXd0pEUXRXRWNmZ21pRmlQMnVJ?=
 =?utf-8?B?a3JYenUzdzVrSlpWd200dmlxYysvd0dmc3F3Wi96d3RTSFJybUJjSHdyNkJH?=
 =?utf-8?B?QTJDZHFwQ3R4WWZSNmtlSTFaTTF1QmhlS0VQNFVGZnNIVE1VbEN2SUg5enBz?=
 =?utf-8?B?VFpmS0xFK1B1dmZZSlVvYTZOMWo2ZTFodmVNa2hEOVFISEpoa3NEUTg4RXlM?=
 =?utf-8?B?bXV2cGpVVXVNNloyRUZ4c1ZGZ3gyTEk5SU9jUkp3cFR0M2xUc0hEM2lQSUpS?=
 =?utf-8?B?MmhKNE9lQ0lhUWhobnlNVnpwMHJuMndlSVdDK3ZZN3JRaE1OQ1NNNkpEdTBm?=
 =?utf-8?B?ZUJyTDA4RndVT1VOMnFPeVhWZ0RXeTUrVDJwZUsrNEh5dU9jWnpFQ3BGNENY?=
 =?utf-8?B?MG8zeTQ5UkxKS3l3Qlg0Tlh5VDBpY2taSXVXLzRSK0w1R3JWMzFEdmROd0FK?=
 =?utf-8?B?Q0xQTmZGc3Fub2xJL3k1azlqRjBUMVhidFZNcEsxV2ZrT2kybHYyTWVwOG03?=
 =?utf-8?B?TEwyaWt6Q3pJV08xRU9mT2ZFQjlRR1pLeS9iNUN1b1dPVnIxMStYRGxOOWVT?=
 =?utf-8?B?OS9SMStHUVZtckxoZTg1emorckJuVHpRMzh2cjd6Sm15UDBZZ1lNWHRjUHZP?=
 =?utf-8?B?RHpyOFJIK2NTay9TVEtQM0JuVTY5TVBaS1V0dG1mdkJ2dTN1Z2NaSlpET2w5?=
 =?utf-8?B?eEZsdWxxaXZjb3NVc1ZpbUJYSW55d2VyZmlESDFNRCtrV0NlbmcxS2RKTTg2?=
 =?utf-8?B?eXZDcGF2cE9QbU81ZG1KM2RWQ041N2NOcjIycTIvbjRYbXNNOCttZjNtL1Y2?=
 =?utf-8?B?SHJsWjFBL1lNTjN4VytjZ0x5aHQ4aGJIbU1lOEx5eUdOUDBOU0xCUnpmbWRS?=
 =?utf-8?B?Rmk4ZWZBQnZsVUVCWFgrTzZJaEtSTStsM1VqNjkwa2pybkgxUjFLMXB4RWkr?=
 =?utf-8?B?L3FoRVNRcyt5MWZIWVVrQXdMV0I4WTJFdkhNdWdQd3ZPS2xxVXBzbnF6a0NQ?=
 =?utf-8?B?NmRuOFFncERqMHdTRWhmT1ZRTXBaOFVSc2pzZU1aWloybTlsa0RTM0VJcmUx?=
 =?utf-8?B?OVhmNHlFRXFlUUpqb0FidDZWWEJxdmI4TGR5RExsZkJKYzZObXZKdW1waUVV?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD58023C3E30BC4886DDE77C8D7E280C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2d3cf8-e184-4038-59ea-08da7af7d736
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 17:43:31.2364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mLGyShNIh+vJDEBaBbYnYVD9PbWZbdNZqPE8tHxcX24oOET0JQi3Zrz1s6nfrZd/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4765
X-Proofpoint-GUID: BHFxBaHsY7vEiDazHIAMYYnIif_NWiRM
X-Proofpoint-ORIG-GUID: BHFxBaHsY7vEiDazHIAMYYnIif_NWiRM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_12,2022-08-10_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTA4LTA5IGF0IDE4OjA4IC0wNzAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6DQo+IE9uIFR1ZSwgQXVnIDksIDIwMjIgYXQgMzozNSBQTSBLdWktRmVuZyBMZWUgPGt1aWZl
bmdAZmIuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBUdWUsIDIwMjItMDgtMDkgYXQgMTU6MTIg
LTA3MDAsIEFsZXhlaSBTdGFyb3ZvaXRvdiB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgQXVnIDksIDIw
MjIgYXQgMTI6NTQgUE0gS3VpLUZlbmcgTGVlIDxrdWlmZW5nQGZiLmNvbT4NCj4gPiA+IHdyb3Rl
Og0KPiA+ID4gPiANCj4gPiA+ID4gQWxsb3cgY3JlYXRpbmcgYW4gaXRlcmF0b3IgdGhhdCBsb29w
cyB0aHJvdWdoIHJlc291cmNlcyBvZiBvbmUNCj4gPiA+ID4gdGFzay90aHJlYWQuDQo+ID4gPiA+
IA0KPiA+ID4gPiBQZW9wbGUgY291bGQgb25seSBjcmVhdGUgaXRlcmF0b3JzIHRvIGxvb3AgdGhy
b3VnaCBhbGwNCj4gPiA+ID4gcmVzb3VyY2VzIG9mDQo+ID4gPiA+IGZpbGVzLCB2bWEsIGFuZCB0
YXNrcyBpbiB0aGUgc3lzdGVtLCBldmVuIHRob3VnaCB0aGV5IHdlcmUNCj4gPiA+ID4gaW50ZXJl
c3RlZA0KPiA+ID4gPiBpbiBvbmx5IHRoZSByZXNvdXJjZXMgb2YgYSBzcGVjaWZpYyB0YXNrIG9y
IHByb2Nlc3MuwqAgUGFzc2luZw0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gYWRkaXRpb25hbCBwYXJh
bWV0ZXJzLCBwZW9wbGUgY2FuIG5vdyBjcmVhdGUgYW4gaXRlcmF0b3IgdG8gZ28NCj4gPiA+ID4g
dGhyb3VnaCBhbGwgcmVzb3VyY2VzIG9yIG9ubHkgdGhlIHJlc291cmNlcyBvZiBhIHRhc2suDQo+
ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBLdWktRmVuZyBMZWUgPGt1aWZlbmdAZmIu
Y29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gwqBpbmNsdWRlL2xpbnV4L2JwZi5owqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqDCoCA4ICsrDQo+ID4gPiA+IMKgaW5jbHVkZS91YXBpL2xpbnV4L2Jw
Zi5owqDCoMKgwqDCoMKgIHzCoCAzNiArKysrKysrKysNCj4gPiA+ID4gwqBrZXJuZWwvYnBmL3Rh
c2tfaXRlci5jwqDCoMKgwqDCoMKgwqDCoCB8IDEzNA0KPiA+ID4gPiArKysrKysrKysrKysrKysr
KysrKysrKysrKystLQ0KPiA+ID4gPiAtLS0tDQo+ID4gPiA+IMKgdG9vbHMvaW5jbHVkZS91YXBp
L2xpbnV4L2JwZi5oIHzCoCAzNiArKysrKysrKysNCj4gPiA+ID4gwqA0IGZpbGVzIGNoYW5nZWQs
IDE5MCBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2JwZi5oIGIvaW5jbHVkZS9saW51eC9icGYuaA0KPiA+
ID4gPiBpbmRleCAxMTk1MDAyOTI4NGYuLmJlZjgxMzI0ZTVmMSAxMDA2NDQNCj4gPiA+ID4gLS0t
IGEvaW5jbHVkZS9saW51eC9icGYuaA0KPiA+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2JwZi5o
DQo+ID4gPiA+IEBAIC0xNzE4LDYgKzE3MTgsMTQgQEAgaW50IGJwZl9vYmpfZ2V0X3VzZXIoY29u
c3QgY2hhciBfX3VzZXINCj4gPiA+ID4gKnBhdGhuYW1lLCBpbnQgZmxhZ3MpOw0KPiA+ID4gPiAN
Cj4gPiA+ID4gwqBzdHJ1Y3QgYnBmX2l0ZXJfYXV4X2luZm8gew0KPiA+ID4gPiDCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3QgYnBmX21hcCAqbWFwOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgIHN0cnVjdCB7
DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudW0gYnBmX2l0ZXJfdGFz
a190eXBlIHR5cGU7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuaW9u
IHsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHUzMiB0aWQ7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB1MzIgdGdpZDsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHUzMiBwaWRfZmQ7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIH07DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqAgfSB0YXNrOw0KPiA+ID4gPiDCoH07
DQo+ID4gPiA+IA0KPiA+ID4gPiDCoHR5cGVkZWYgaW50ICgqYnBmX2l0ZXJfYXR0YWNoX3Rhcmdl
dF90KShzdHJ1Y3QgYnBmX3Byb2cgKnByb2csDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L3VhcGkvbGludXgvYnBmLmgNCj4gPiA+ID4gYi9pbmNsdWRlL3VhcGkvbGludXgvYnBmLmgNCj4g
PiA+ID4gaW5kZXggZmZjYmY3OWE1NTZiLi4zZDBiOWUzNDA4OWYgMTAwNjQ0DQo+ID4gPiA+IC0t
LSBhL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaA0KPiA+ID4gPiArKysgYi9pbmNsdWRlL3VhcGkv
bGludXgvYnBmLmgNCj4gPiA+ID4gQEAgLTg3LDEwICs4Nyw0NiBAQCBzdHJ1Y3QgYnBmX2Nncm91
cF9zdG9yYWdlX2tleSB7DQo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIF9fdTMywqDCoCBhdHRhY2hf
dHlwZTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIHByb2dyYW0gYXR0YWNoIHR5cGUNCj4gPiA+
ID4gKGVudW0gYnBmX2F0dGFjaF90eXBlKSAqLw0KPiA+ID4gPiDCoH07DQo+ID4gPiA+IA0KPiA+
ID4gPiArLyoNCj4gPiA+ID4gKyAqIFRoZSB0YXNrIHR5cGUgb2YgaXRlcmF0b3JzLg0KPiA+ID4g
PiArICoNCj4gPiA+ID4gKyAqIEZvciBCUEYgdGFzayBpdGVyYXRvcnMsIHRoZXkgY2FuIGJlIHBh
cmFtZXRlcml6ZWQgd2l0aA0KPiA+ID4gPiB2YXJpb3VzDQo+ID4gPiA+ICsgKiBwYXJhbWV0ZXJz
IHRvIHZpc2l0IG9ubHkgc29tZSBvZiB0YXNrcy4NCj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKiBC
UEZfVEFTS19JVEVSX0FMTCAoZGVmYXVsdCkNCj4gPiA+ID4gKyAqwqDCoMKgwqAgSXRlcmF0ZSBv
dmVyIHJlc291cmNlcyBvZiBldmVyeSB0YXNrLg0KPiA+ID4gPiArICoNCj4gPiA+ID4gKyAqIEJQ
Rl9UQVNLX0lURVJfVElEDQo+ID4gPiA+ICsgKsKgwqDCoMKgIEl0ZXJhdGUgb3ZlciByZXNvdXJj
ZXMgb2YgYSB0YXNrL3RpZC4NCj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKiBCUEZfVEFTS19JVEVS
X1RHSUQNCj4gPiA+ID4gKyAqwqDCoMKgwqAgSXRlcmF0ZSBvdmVyIHJlb3N1cmNlcyBvZiBldmV2
cnkgdGFzayBvZiBhIHByb2Nlc3MgLw0KPiA+ID4gPiB0YXNrDQo+ID4gPiA+IGdyb3VwLg0KPiA+
ID4gPiArICoNCj4gPiA+ID4gKyAqIEJQRl9UQVNLX0lURVJfUElERkQNCj4gPiA+ID4gKyAqwqDC
oMKgwqAgSXRlcmF0ZSBvdmVyIHJlc291cmNlcyBvZiBldmVyeSB0YXNrIG9mIGEgcHJvY2VzcyAv
dGFzaw0KPiA+ID4gPiBncm91cCBzcGVjaWZpZWQgYnkgYSBwaWRmZC4NCj4gPiA+ID4gKyAqLw0K
PiA+ID4gPiArZW51bSBicGZfaXRlcl90YXNrX3R5cGUgew0KPiA+ID4gPiArwqDCoMKgwqDCoMKg
IEJQRl9UQVNLX0lURVJfQUxMID0gMCwNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoCBCUEZfVEFTS19J
VEVSX1RJRCwNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoCBCUEZfVEFTS19JVEVSX1RHSUQsDQo+ID4g
PiA+ICvCoMKgwqDCoMKgwqAgQlBGX1RBU0tfSVRFUl9QSURGRCwNCj4gPiA+ID4gK307DQo+ID4g
PiA+ICsNCj4gPiA+ID4gwqB1bmlvbiBicGZfaXRlcl9saW5rX2luZm8gew0KPiA+ID4gPiDCoMKg
wqDCoMKgwqDCoCBzdHJ1Y3Qgew0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgX191MzLCoMKgIG1hcF9mZDsNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgfSBtYXA7DQo+ID4g
PiA+ICvCoMKgwqDCoMKgwqAgLyoNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgICogUGFyYW1ldGVy
cyBvZiB0YXNrIGl0ZXJhdG9ycy4NCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgICovDQo+ID4gPiA+
ICvCoMKgwqDCoMKgwqAgc3RydWN0IHsNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZW51bSBicGZfaXRlcl90YXNrX3R5cGUgdHlwZTsNCj4gPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdW5pb24gew0KPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX191MzIgdGlkOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX191MzIgdGdpZDsNCj4gPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fdTMyIHBpZF9mZDsN
Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsNCj4gPiA+IA0KPiA+ID4g
U29ycnkgSSdtIGxhdGUgdG8gdGhpcyBkaXNjdXNzaW9uLCBidXQNCj4gPiA+IHdpdGggZW51bSBh
bmQgd2l0aCB1bmlvbiB3ZSBraW5kYSB0ZWxsDQo+ID4gPiB0aGUga2VybmVsIHRoZSBzYW1lIGlu
Zm9ybWF0aW9uIHR3aWNlLg0KPiA+ID4gSGVyZSBpcyBob3cgdGhlIHNlbGZ0ZXN0IGxvb2tzOg0K
PiA+ID4gK8KgwqDCoMKgwqDCoCBsaW5mby50YXNrLnRpZCA9IGdldHBpZCgpOw0KPiA+ID4gK8Kg
wqDCoMKgwqDCoCBsaW5mby50YXNrLnR5cGUgPSBCUEZfVEFTS19JVEVSX1RJRDsNCj4gPiA+IA0K
PiA+ID4gZmlyc3QgbGluZSAtPiB1c2UgdGlkLg0KPiA+ID4gc2Vjb25kIGxpbmUgLT4geWVhaC4g
SSByZWFsbHkgbWVhbnQgdGhlIHRpZC4NCj4gPiA+IA0KPiA+ID4gSW5zdGVhZCBvZiB1bmlvbiBh
bmQgdHlwZSBjYW4gd2UgZG86DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBfX3UzMiB0aWQ7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX3UzMiB0Z2lkOw0KPiA+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX191MzIgcGlkX2ZkOw0KPiA+ID4g
DQo+ID4gPiBhcyAzIHNlcGFyYXRlIGZpZWxkcz8NCj4gPiA+IFRoZSBrZXJuZWwgd291bGQgaGF2
ZSB0byBjaGVjayB0aGF0IG9ubHkgb25lDQo+ID4gPiBvZiB0aGVtIGlzIHNldC4NCj4gPiA+IA0K
PiA+ID4gSSBjb3VsZCBoYXZlIG1pc3NlZCBhbiBlYXJsaWVyIGRpc2N1c3Npb24gb24gdGhpcyBz
dWJqLg0KPiA+IA0KPiA+IFdlIG1heSBoYXZlIG90aGVyIHBhcmFtZXRlciB0eXBlcyBsYXRlciwg
Zm9yIGV4YW1wbGUsIGNncm91cHMuDQo+ID4gVW5mb3J0dW5hdGVseSwgd2UgZG9uJ3QgaGF2ZSB0
YWdnZWQgZW51bSBvciB0YWdnZWQgdW5pb24sIGxpa2Ugd2hhdA0KPiA+IFJ1c3Qgb3IgSGFza2Vs
bCBoYXMsIGluIEMuwqAgQSBzZXBhcmF0ZWQgJ3R5cGUnIGZpZWxkIHdvdWxkIGJlDQo+ID4gZWFz
aWVyDQo+ID4gYW5kIGNsZWFyIHRvIGRpc3Rpbmd1aXNoIHRoZW0uwqAgV2l0aCAzIHNlcGFyYXRl
ZCBmaWVsZHMsIHBlb3BsZSBtYXkNCj4gPiB3b25kZXIgaWYgdGhleSBjYW4gYmUgc2V0IHRoZW0g
YWxsLCBvciBqdXN0IG9uZSBvZiB0aGVtLCBpbiBteQ0KPiA+IG9waW5pb24uDQo+ID4gV2l0aCBh
biB1bmlvbiwgcGVvcGxlIHNob3VsZCBrbm93IG9ubHkgb25lIG9mIHRoZW0gc2hvdWxkIGJlIHNl
dC4NCj4gDQo+IFdoYXQgc3RvcHMgdXMgYWRkaW5nIG5ldyBmaWVsZHMgdG8gdGhlIGVuZCBpbiBz
dWNoIGEgY2FzZT8NCj4gU29tZSBjb21iaW5hdGlvbnMgd2lsbCBub3QgYmUgbWVhbmluZ2Z1bCBh
bmQgdGhlIGtlcm5lbA0KPiB3b3VsZCBoYXZlIHRvIGNoZWNrIGFuZCBlcnJvciByZWdhcmRsZXNz
Lg0KPiBJbWFnaW5lIGV4dGVuZGluZyB1bmlvbjoNCj4gc3RydWN0IHsNCj4gwqAgZW51bSBicGZf
aXRlcl90YXNrX3R5cGUgdHlwZTsNCj4gwqAgdW5pb24gew0KPiDCoMKgwqDCoCBzdHJ1Y3Qgew0K
PiDCoMKgwqDCoMKgwqDCoCBfX3UzMiB0aWQ7DQo+IMKgwqDCoMKgwqDCoMKgIF9fdTY0IHNvbWV0
aGluZ19lbHNlOw0KPiDCoMKgwqDCoCB9Ow0KPiDCoMKgwqDCoCBfX3UzMiB0Z2lkOw0KPiDCoMKg
wqDCoCBfX3UzMiBwaWRfZmQ7DQo+IMKgIH07DQo+IH07DQo+IA0KPiBhbmQgbm93IHdlJ3JlIHN1
ZGRlbmx5IGhpdHRpbmcgdGhlIHNhbWUgaXNzdWUgd2UgZGlzY3Vzc2VkDQo+IHdpdGggc3RydWN0
IGJwZl9saW5rX2luZm8gaW4gdGhlIG90aGVyIHRocmVhZCBkdWUgdG8gYWxpZ25tZW50DQo+IGlu
Y3JlYXNpbmcgZnJvbSA0IHRvIDggYnl0ZXMuDQo+IFdlIG1pZ2h0IGV2ZW4gbmVlZCBicGZfaXRl
cl9saW5rX2luZm8gX3YyLg0KDQpJdCBpcyBhIGdvb2QgcG9pbnQuICBJbiB0aGF0IGNhc2UsIHdl
IHByb2JhYmx5IG5lZWQgdGFza192MiBpbnN0ZWFkIG9mDQpicGZfaXRlcl9saW5rX2luZm9fdjIu
ICBUaGUgb3RoZXIgc29sdXRpb24gaXMgdG8gbWFrZSB3aG9sZSAndGFzaycgYXMNCmFuIHVuaW9u
IGluc3RlYWQgb2YgYSBzdHJ1Y3QuDQoNCnVuaW9uIGJwZl9pdGVyX2xpbmtfaW5mbyB7DQogICAg
Li4uLi4uDQogICAgdW5pb24gew0KICAgICAgICBlbnVtIGJwZl9pdGVyX3Rhc2tfdHlwZSB0eXBl
Ow0KICAgICAgICBzdHJ1Y3Qgew0KICAgICAgICAgICAgZW51bSBicGZfaXRlcl90YXNrX3R5cGUg
dGlkX190eXBlOw0KICAgICAgICAgICAgX191MzIgdGlkOw0KICAgICAgICB9Ow0KICAgICAgICBz
dHJ1Y3Qgew0KICAgICAgICAgICAgZW51bSBicGZfaXRlcl90YXNrX3R5cGUgdGdpZF9fdHlwZTsN
CiAgICAgICAgICAgIF9fdTMyIHRnaWQ7DQogICAgICAgIH07DQogICAgICAgIC4uLi4uLg0KICAg
IH0gdGFzazsNCn0NCg0KRXZlbiBhZGRpbmcgc29tZXRoaW5nIG5ldywgaXQgZG9lc24ndCBhZmZl
Y3QgdGhlIG9mZnNldHMgb2Ygb2xkIGZpZWxkcy4NCg0KPiANCj4gSWYgJ3NvbWV0aGluZ19lbHNl
JyBpcyB1MzIgdGhlIGtlcm5lbCBzdGlsbCBuZWVkcyB0byBjaGVjaw0KPiB0aGF0IGl0J3MgemVy
byBpbiB0aGUgdGdpZCBhbmQgcGlkX2ZkIGNhc2VzLg0KPiBJZiB3ZSdyZSBleHRlbmRpbmcgZmll
bGRzIHdlIGNhbiBhZGQgYSBjb21tZW50Og0KPiBzdHJ1Y3Qgew0KPiDCoCBfX3UzMiB0aWQ7DQo+
IMKgIF9fdTMyIHRnaWQ7DQo+IMKgIF9fdTMyIHBpZF9mZDsNCj4gwqAgX191MzIgc29tZXRoaW5n
X2Vsc2U7IC8qIHVzZWZ1bCBpbiBjb21iaW5hdGlvbiB3aXRoIHRpZCAqLw0KPiB9Ow0KPiBhbmQg
aXQncyBvYnZpb3VzIHdoYXQgaXMgdXNlZCB3aXRoIHdoYXQuDQo+IA0KPiBJdCBzdGlsbCBmZWVs
cyB0aGF0IDMgZGlmZmVyZW50IGZpZWxkcyBhcmUgZWFzaWVyIHRvIHVzZS4NCg0KQWdyZWUhICBI
YXZpbmcgMyBzZXBhcmF0ZWQgZmllbGRzIGlzIGVhc2llciB0byB1c2UgZm9yIGFzc2lnbmluZyBv
bmx5DQpvbmUgdmFsdWUuDQoNCg0K
