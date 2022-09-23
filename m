Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B52F5E8642
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 01:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiIWXSt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 19:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiIWXSs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 19:18:48 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EFFF2740
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 16:18:47 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28NM93Sb031736
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 16:18:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Ijxqf3HpcJB8xctlaxv6HG0MYNOrlbWhJnymW5PEYFc=;
 b=BydTww5mwNtGqlY1oUkvuiOh7mzSqQIhs0C4/JNkohyoZkvZmCO+LPDnyPq6yWC4AtSH
 fQyaJcUiFAfEXjQhzlCp+VGbf/6n73bVg0Yf5lshBWgzly1La1XCMdiunY4wm3BB7QlT
 bAfM7ah4hxnIF913isZUlguoYh3miGs5vnA= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3js7mxe3v0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 16:18:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcBQVyTAB7km2P6gaLZ6KiMyiAFTTrScfHKpSLVeeZlkMW7JL4Sr2JX6pMLBkxXXew8190oT6qBfU+AlKXkl3/pZwbM4jnbev4TbPeeryIXJgCCqAfPWPYc/k6yR7rkmatre/7l5cn6+nR10MJRNhNWXMNld+5PwJulaqlIT5Mh/v0SvzB2K5HvMu0Y2wlTR+1Q7vlPT3AaTYQd8cutLKqWBX/sB8oAIto7Yc9GcQdwS1xDT1hImZYfVm/5cxk1l+V99PHCJ8QxKmbq1hHgTypp3Xg3pxoIu94OU04A94QkQbcODnm7lHIXzSX7uB/9NVXdUTrv/P1euxrj16NSgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ijxqf3HpcJB8xctlaxv6HG0MYNOrlbWhJnymW5PEYFc=;
 b=SHPZ8SwNqtACFTO3r1W+UNz2IxtgH2cDHr/p55MY4tCUmj/1JAoaCxiTjbn9UUwhm0+aRey20m5VmdO2RODkidxJH9B14evRP3/GtjtqMKbio0QzTJ5jXTqmdYyxg7MjOy9enQ3ylkxBJUSGXn+OTegNzR+DUxRe0Hx13Wc8dQY1RWoj3dvAdcDGwUecl8zblOK/M1ZjGAo6wBYfI0aFRrDIOiba4iS8SsZdOusRkWSmaGhoQIcQUU0yaMpr61SLv90swgbpew0VPm90ijzAfZmlUBq537mOK/7oY1lXf6Y9lfHeJpdW7DL3uPaabYiZrqLbNoikjF+QCEndWUrkxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM5PR15MB1676.namprd15.prod.outlook.com (2603:10b6:3:125::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 23:18:43 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537%7]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 23:18:43 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
CC:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kernel Team <Kernel-team@fb.com>, Hao Luo <haoluo@google.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: use bpf_prog_pack for bpf_dispatcher
Thread-Topic: [PATCH bpf-next 1/2] bpf: use bpf_prog_pack for bpf_dispatcher
Thread-Index: AQHYz5IaSevvmeP4LEWNGRKKbbYINq3tkLWAgAAVygA=
Date:   Fri, 23 Sep 2022 23:18:43 +0000
Message-ID: <37C7A6C4-33C6-42EC-8BEC-E6D70AB0774A@fb.com>
References: <20220923211837.3044723-1-song@kernel.org>
 <20220923211837.3044723-2-song@kernel.org>
 <CAADnVQKgvtt+aLpNQ2OFf5HXqyTePS5=9efRY14fMViayBLNwQ@mail.gmail.com>
In-Reply-To: <CAADnVQKgvtt+aLpNQ2OFf5HXqyTePS5=9efRY14fMViayBLNwQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DM5PR15MB1676:EE_
x-ms-office365-filtering-correlation-id: b5b9242b-0b59-4b1e-76d2-08da9db9f523
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ddfFO3qBat4iVe6u7z5X74XrRaq0e7c0vfHgaH4vQaH7q845btPBibYtw2qwrv0ugzujNTjyFZlj2UckCtCSShS4Cr55tS883tlhyy7mJ6suPOFWXeL5v6arQSAW1BqTVGurHGy/YB9NMYtOI68dGATO603HBRvGtI4HQ6K6tUa/usPBUQkX5ZtM4J6ZjB5ghVvvGg9jeb++aFpBBhdXLlHXnjuMH5IygOGNzgkMtKFSKNeyowdOlKvCuw9InBxyovM297QskVMeDpKgIGgJ05p7a7JbTTyFLpVc8C7ArlnMWzmITXdPCq+/4flnrt//r0EjZqDS3RKlzX+1wMLUVuI1rUp8cRD+L8RRveEvcOJEvEMhQCVUwAsih9heIKkqF2+ABQnOw/kqPPEQEpYGKF1PODKrEocUY4RbfPgMTtE/3umOukxriEm0fU+NxF89yEFOe1HYOppNqPHEKtFsxMPtE3YqD5Qh8EqkRVmUT6RA3EDtNGDb+mvkmivv6dj9TICD253kw9M0qwQMxI+SEasMdG5WnU3zqkx/fVfYlGPow/IPkv+vSqJqQgLRTt3PUrySTxd5QbDfFXsNI0b8PVhqV/MOngaNoORhaXR6++ZL9X2kM6IHYbmIysf0mRQBlVQENglCdoJ01U/c41uonrbiquG3bVsfAQVmEee4w2xWZ+w/LLw+KkK6PqABc7OARdD7RiF6SWSWPxs4TQHRnQsFw3S5cVSTpF4Kj7A1D8lQIgAoMSKX9CcnVCY9+fw0KcGw9DB94A+B3aB9Ev3HPwiGwItx1o2Sj7z163EQ0hk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199015)(33656002)(83380400001)(71200400001)(110136005)(54906003)(5660300002)(7416002)(41300700001)(2906002)(6506007)(8936002)(66556008)(6512007)(36756003)(66946007)(38070700005)(66476007)(4326008)(91956017)(64756008)(8676002)(478600001)(66446008)(76116006)(66574015)(6486002)(2616005)(86362001)(122000001)(186003)(53546011)(316002)(38100700002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajc4YmpCUFVsamxlR2FBU290RmlPOWp4bCtXSDd5YmVBVWJ1MEVpSDU2QXJu?=
 =?utf-8?B?Y3dpRnRCKy9DL2tVWEhSUGptdnpPVll0cGRoYXMyditnOTFaWllrUXhsWmM2?=
 =?utf-8?B?Q1dMZGhRaWZXWkJQZ3FkRnh5NkRuRHFWdytoTDJDNEV3RGF5dmxvb2UwODRZ?=
 =?utf-8?B?Z2szRm9vcFBROTFsZ0lwdEhtNnludENDeFpvMTdrUk1HcHVtNUV3dlZaQmd5?=
 =?utf-8?B?Rm0zRkhZVjVzcFhDYlpVajNtUTlMRVNiQTFYS0JUVGJETEN6bEJPd2lDWXox?=
 =?utf-8?B?RWNpZGlUN0lYdGFRejZnbUlNUDFHZWRCalJVb3diVC8zRklHVCs1ek9tTDRM?=
 =?utf-8?B?SHRsQk1GeVZUeG5lSlY1N0hyQWt4YWdKL09JY0NXdFhocVpVMDBaRlZNV0xC?=
 =?utf-8?B?UCtnT0NZRG9wK2hsbWNqYUpwMWRoR2h1L0dKdXdUQ0F5R3VuMFVkeGdFWklo?=
 =?utf-8?B?djFkN0tobWt2c0JYS0syWlZHVFZTOHNLNE90dDVpMTY3b1JRY3pFMFluTXFu?=
 =?utf-8?B?dW1lMVN5YnJCSWc5N1gwdmEwL2hvOFQ2VkMrWldQb2xKT0RlcVk4N3RZUDZH?=
 =?utf-8?B?L1I2SjZNdURyODh5Qk0vR2RiZU1rc3lBUTFUTjFYaUJISXg3WllLSVdtTmc3?=
 =?utf-8?B?TVB2bVh5amdCdmFQTmNHTFBwbzRzb1ZqL0V2YnhvQ3BIVngwYXdRalkvV2kz?=
 =?utf-8?B?dEJVOUFlU1RJU0VKSnFJYWcwVzIyR0orbzh3N1o4OERHbDVaYVR6YU16Qjd6?=
 =?utf-8?B?YmtwRE9zV1JML2RRMDQ5SkdnVHNMYmJwcjcvT0RyckdhQzBKUi9sY2R3UWVv?=
 =?utf-8?B?TlBNTFBVZTVzT256d1JHa0hOeUd2S2ZTMk5pTFArTHJzYlFMZTE4NVVhdytK?=
 =?utf-8?B?S2hxOGVrd2RwZnFjQjlyaXVXZDFmWjV4VCswWUY2SmMzOEpXZzZGU05xVXBu?=
 =?utf-8?B?elB1MDIyNEoyaEl5K2RxRisvY1dxWFZMZHpRSExUbkhvNUQ1MitrVkdLcEhD?=
 =?utf-8?B?eWhsQ2dpWDQxTHNMR216djJxdk9VRWlPaVMvU2FEVjlmTmNJVmE1U2NiQUlQ?=
 =?utf-8?B?bUZqTCtLZE1vQlYwSGk1c2xKVk1qOHVleXJWZWtYeUJtbTlyOXZIeEtkQloy?=
 =?utf-8?B?WXowbG05WEc2YTZvWFZEcHVHQjNWQ0xiQmhncGdBSlBPTU1kUlRvN0hpNllJ?=
 =?utf-8?B?eVlSOXVFeWUxM0d1akZQMzBqTFEwTG9oSURGdFU4NDhreEhNb1Foem9qQmtv?=
 =?utf-8?B?cGlwMlVMVm9iUDZxMDBpTE5iK3lLRlU0ODFqRmVNTHNRdEY1bUxnV3E0Mjlo?=
 =?utf-8?B?Z2tidXowWDVBNDRDTTNLZHY5Q3U1YVI1QnJZTXNIWEdGTDdSZE9vbzlOVzZh?=
 =?utf-8?B?WjhyeWxkOTZLMXNNWmVEWS9CMmNGYjFnYW02WndVWDNSalZRbEFuR3lSTmJ5?=
 =?utf-8?B?Q2w1Vit5aXpVNlBOMGVVYTNFRk5FUHl1a3VOTllXZnFlQUFGcVR3cWp6NHhy?=
 =?utf-8?B?aFVPWHNCbzNxN3NRdUVuT1BaTFJ6bXRGOTlPc3lyZXFDblRFazI5T0EvYVRU?=
 =?utf-8?B?L0ltTVcxWFBHYTAzcjc1WFpDcDg3RnBqdWpFQkhxc2xFOXdCYXBQSlRYNDg2?=
 =?utf-8?B?VkJUZ2NSTStub2V3QVBNYW1hb2NmRVZ2YXRKNDVPMFdlenRMdTVUbjhjZVJh?=
 =?utf-8?B?NXdNcnZqQWJYT3AzbkJndWxDenV0b3RnekNtenN5bHFKZGdZMFd3aUpCU3Vn?=
 =?utf-8?B?S284bU1ZWkhWUU5CbklzbUY2L0k3WEpKbC9md2d5YndOc1BnaWxpUEwvZUdp?=
 =?utf-8?B?UUhlNVV4bnd0KytqZXpoMXIxbS9FSlViU3lsRDNnRENRTTFWeVF2c3p6eE5m?=
 =?utf-8?B?UUJqT2FtM2g2aDBpRWQ1TFYyT29aV05GNzJ3dWlJaHd1YVJRUk1yRkUvZkRj?=
 =?utf-8?B?bjk5NWVTUDhNMmE5N09wM3UycmwraldNRTNubTB1eFZyN3BEemtQTjY5V2lU?=
 =?utf-8?B?TXhxbk1RSUJyQlI0ZXZGcXg4dndhK05xRTJOVXcxTmZvYXBJOTVkYjRIYU5t?=
 =?utf-8?B?VFovWTdRRHp6S0VTcUJBOTRxSEFVV2RrU0hBTzVzbnFnRmF2dEVSb3lPbUtx?=
 =?utf-8?B?MVp3Q3NmckY0bU1nREJwZU5Nc1g4STltVFFWekM5d1lJdnl5NnBMR3I4WVA5?=
 =?utf-8?Q?fgoJpypDVo9fu/erxbPvBWg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A627B39079295248A51DB3F44DBD32BB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b9242b-0b59-4b1e-76d2-08da9db9f523
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 23:18:43.3286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ZZCDSfPQTi/hvmB/xk9Io2Ly6u1aZ5Hyep4I8bfivHGmlYIvAphZzHzg8XIEzL0WMwfzd04W9YzLtRbnwZTXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1676
X-Proofpoint-ORIG-GUID: d5NbSUEf4pzlUxc0Ni8WUXTjYOpre5ly
X-Proofpoint-GUID: d5NbSUEf4pzlUxc0Ni8WUXTjYOpre5ly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_10,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

KyBCasO2cm4gVMO2cGVsIA0KDQo+IE9uIFNlcCAyMywgMjAyMiwgYXQgMzowMCBQTSwgQWxleGVp
IFN0YXJvdm9pdG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+
IE9uIEZyaSwgU2VwIDIzLCAyMDIyIGF0IDI6MTggUE0gU29uZyBMaXUgPHNvbmdAa2VybmVsLm9y
Zz4gd3JvdGU6DQo+PiANCj4+IEFsbG9jYXRlIGJwZl9kaXNwYXRjaGVyIHdpdGggYnBmX3Byb2df
cGFja19hbGxvYyBzbyB0aGF0IGJwZl9kaXNwYXRjaGVyDQo+PiBjYW4gc2hhcmUgcGFnZXMgd2l0
aCBicGYgcHJvZ3JhbXMuDQo+PiANCj4+IFRoaXMgYWxzbyBmaXhlcyBDUEEgV15YIHdhcm5uaW5n
IGxpa2U6DQo+PiANCj4+IENQQSByZWZ1c2UgV15YIHZpb2xhdGlvbjogODAwMDAwMDAwMDAwMDE2
MyAtPiAwMDAwMDAwMDAwMDAwMTYzIHJhbmdlOiAuLi4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTog
U29uZyBMaXUgPHNvbmdAa2VybmVsLm9yZz4NCj4+IC0tLQ0KPj4gaW5jbHVkZS9saW51eC9icGYu
aCAgICAgfCAgMSArDQo+PiBpbmNsdWRlL2xpbnV4L2ZpbHRlci5oICB8ICA1ICsrKysrDQo+PiBr
ZXJuZWwvYnBmL2NvcmUuYyAgICAgICB8ICA5ICsrKysrKystLQ0KPj4ga2VybmVsL2JwZi9kaXNw
YXRjaGVyLmMgfCAyMSArKysrKysrKysrKysrKysrKystLS0NCj4+IDQgZmlsZXMgY2hhbmdlZCwg
MzEgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvYnBmLmggYi9pbmNsdWRlL2xpbnV4L2JwZi5oDQo+PiBpbmRleCBlZGQ0M2Vk
YjI3ZDYuLmE4ZDBjZmUxNDM3MiAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvbGludXgvYnBmLmgN
Cj4+ICsrKyBiL2luY2x1ZGUvbGludXgvYnBmLmgNCj4+IEBAIC05NDYsNiArOTQ2LDcgQEAgc3Ry
dWN0IGJwZl9kaXNwYXRjaGVyIHsNCj4+ICAgICAgICBzdHJ1Y3QgYnBmX2Rpc3BhdGNoZXJfcHJv
ZyBwcm9nc1tCUEZfRElTUEFUQ0hFUl9NQVhdOw0KPj4gICAgICAgIGludCBudW1fcHJvZ3M7DQo+
PiAgICAgICAgdm9pZCAqaW1hZ2U7DQo+PiArICAgICAgIHZvaWQgKnJ3X2ltYWdlOw0KPj4gICAg
ICAgIHUzMiBpbWFnZV9vZmY7DQo+PiAgICAgICAgc3RydWN0IGJwZl9rc3ltIGtzeW07DQo+PiB9
Ow0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZmlsdGVyLmggYi9pbmNsdWRlL2xpbnV4
L2ZpbHRlci5oDQo+PiBpbmRleCA5OGUyODEyNmMyNGIuLmVmYzQyYTZlM2FlZCAxMDA2NDQNCj4+
IC0tLSBhL2luY2x1ZGUvbGludXgvZmlsdGVyLmgNCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvZmls
dGVyLmgNCj4+IEBAIC0xMDIzLDYgKzEwMjMsOCBAQCBleHRlcm4gbG9uZyBicGZfaml0X2xpbWl0
X21heDsNCj4+IA0KPj4gdHlwZWRlZiB2b2lkICgqYnBmX2ppdF9maWxsX2hvbGVfdCkodm9pZCAq
YXJlYSwgdW5zaWduZWQgaW50IHNpemUpOw0KPj4gDQo+PiArdm9pZCBicGZfaml0X2ZpbGxfaG9s
ZV93aXRoX3plcm8odm9pZCAqYXJlYSwgdW5zaWduZWQgaW50IHNpemUpOw0KPj4gKw0KPj4gc3Ry
dWN0IGJwZl9iaW5hcnlfaGVhZGVyICoNCj4+IGJwZl9qaXRfYmluYXJ5X2FsbG9jKHVuc2lnbmVk
IGludCBwcm9nbGVuLCB1OCAqKmltYWdlX3B0ciwNCj4+ICAgICAgICAgICAgICAgICAgICAgdW5z
aWduZWQgaW50IGFsaWdubWVudCwNCj4+IEBAIC0xMDM1LDYgKzEwMzcsOSBAQCB2b2lkIGJwZl9q
aXRfZnJlZShzdHJ1Y3QgYnBmX3Byb2cgKmZwKTsNCj4+IHN0cnVjdCBicGZfYmluYXJ5X2hlYWRl
ciAqDQo+PiBicGZfaml0X2JpbmFyeV9wYWNrX2hkcihjb25zdCBzdHJ1Y3QgYnBmX3Byb2cgKmZw
KTsNCj4+IA0KPj4gK3ZvaWQgKmJwZl9wcm9nX3BhY2tfYWxsb2ModTMyIHNpemUsIGJwZl9qaXRf
ZmlsbF9ob2xlX3QgYnBmX2ZpbGxfaWxsX2luc25zKTsNCj4+ICt2b2lkIGJwZl9wcm9nX3BhY2tf
ZnJlZShzdHJ1Y3QgYnBmX2JpbmFyeV9oZWFkZXIgKmhkcik7DQo+PiArDQo+PiBzdGF0aWMgaW5s
aW5lIGJvb2wgYnBmX3Byb2dfa2FsbHN5bXNfdmVyaWZ5X29mZihjb25zdCBzdHJ1Y3QgYnBmX3By
b2cgKmZwKQ0KPj4gew0KPj4gICAgICAgIHJldHVybiBsaXN0X2VtcHR5KCZmcC0+YXV4LT5rc3lt
Lmxub2RlKSB8fA0KPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvY29yZS5jIGIva2VybmVsL2Jw
Zi9jb3JlLmMNCj4+IGluZGV4IGQxYmU3OGMyODYxOS4uNzExZmQyOTNiNmRlIDEwMDY0NA0KPj4g
LS0tIGEva2VybmVsL2JwZi9jb3JlLmMNCj4+ICsrKyBiL2tlcm5lbC9icGYvY29yZS5jDQo+PiBA
QCAtODI1LDYgKzgyNSwxMSBAQCBzdHJ1Y3QgYnBmX3Byb2dfcGFjayB7DQo+PiAgICAgICAgdW5z
aWduZWQgbG9uZyBiaXRtYXBbXTsNCj4+IH07DQo+PiANCj4+ICt2b2lkIGJwZl9qaXRfZmlsbF9o
b2xlX3dpdGhfemVybyh2b2lkICphcmVhLCB1bnNpZ25lZCBpbnQgc2l6ZSkNCj4+ICt7DQo+PiAr
ICAgICAgIG1lbXNldChhcmVhLCAwLCBzaXplKTsNCj4+ICt9DQo+PiArDQo+PiAjZGVmaW5lIEJQ
Rl9QUk9HX1NJWkVfVE9fTkJJVFMoc2l6ZSkgICAocm91bmRfdXAoc2l6ZSwgQlBGX1BST0dfQ0hV
TktfU0laRSkgLyBCUEZfUFJPR19DSFVOS19TSVpFKQ0KPj4gDQo+PiBzdGF0aWMgREVGSU5FX01V
VEVYKHBhY2tfbXV0ZXgpOw0KPj4gQEAgLTg2NCw3ICs4NjksNyBAQCBzdGF0aWMgc3RydWN0IGJw
Zl9wcm9nX3BhY2sgKmFsbG9jX25ld19wYWNrKGJwZl9qaXRfZmlsbF9ob2xlX3QgYnBmX2ZpbGxf
aWxsX2lucw0KPj4gICAgICAgIHJldHVybiBwYWNrOw0KPj4gfQ0KPj4gDQo+PiAtc3RhdGljIHZv
aWQgKmJwZl9wcm9nX3BhY2tfYWxsb2ModTMyIHNpemUsIGJwZl9qaXRfZmlsbF9ob2xlX3QgYnBm
X2ZpbGxfaWxsX2luc25zKQ0KPj4gK3ZvaWQgKmJwZl9wcm9nX3BhY2tfYWxsb2ModTMyIHNpemUs
IGJwZl9qaXRfZmlsbF9ob2xlX3QgYnBmX2ZpbGxfaWxsX2luc25zKQ0KPj4gew0KPj4gICAgICAg
IHVuc2lnbmVkIGludCBuYml0cyA9IEJQRl9QUk9HX1NJWkVfVE9fTkJJVFMoc2l6ZSk7DQo+PiAg
ICAgICAgc3RydWN0IGJwZl9wcm9nX3BhY2sgKnBhY2s7DQo+PiBAQCAtOTA1LDcgKzkxMCw3IEBA
IHN0YXRpYyB2b2lkICpicGZfcHJvZ19wYWNrX2FsbG9jKHUzMiBzaXplLCBicGZfaml0X2ZpbGxf
aG9sZV90IGJwZl9maWxsX2lsbF9pbnNuDQo+PiAgICAgICAgcmV0dXJuIHB0cjsNCj4+IH0NCj4+
IA0KPj4gLXN0YXRpYyB2b2lkIGJwZl9wcm9nX3BhY2tfZnJlZShzdHJ1Y3QgYnBmX2JpbmFyeV9o
ZWFkZXIgKmhkcikNCj4+ICt2b2lkIGJwZl9wcm9nX3BhY2tfZnJlZShzdHJ1Y3QgYnBmX2JpbmFy
eV9oZWFkZXIgKmhkcikNCj4+IHsNCj4+ICAgICAgICBzdHJ1Y3QgYnBmX3Byb2dfcGFjayAqcGFj
ayA9IE5VTEwsICp0bXA7DQo+PiAgICAgICAgdW5zaWduZWQgaW50IG5iaXRzOw0KPj4gZGlmZiAt
LWdpdCBhL2tlcm5lbC9icGYvZGlzcGF0Y2hlci5jIGIva2VybmVsL2JwZi9kaXNwYXRjaGVyLmMN
Cj4+IGluZGV4IDI0NDRiZDE1Y2MyZC4uOGExMDMwMDg1NGI2IDEwMDY0NA0KPj4gLS0tIGEva2Vy
bmVsL2JwZi9kaXNwYXRjaGVyLmMNCj4+ICsrKyBiL2tlcm5lbC9icGYvZGlzcGF0Y2hlci5jDQo+
PiBAQCAtMTA0LDcgKzEwNCw3IEBAIHN0YXRpYyBpbnQgYnBmX2Rpc3BhdGNoZXJfcHJlcGFyZShz
dHJ1Y3QgYnBmX2Rpc3BhdGNoZXIgKmQsIHZvaWQgKmltYWdlKQ0KPj4gDQo+PiBzdGF0aWMgdm9p
ZCBicGZfZGlzcGF0Y2hlcl91cGRhdGUoc3RydWN0IGJwZl9kaXNwYXRjaGVyICpkLCBpbnQgcHJl
dl9udW1fcHJvZ3MpDQo+PiB7DQo+PiAtICAgICAgIHZvaWQgKm9sZCwgKm5ldzsNCj4+ICsgICAg
ICAgdm9pZCAqb2xkLCAqbmV3LCAqdG1wOw0KPj4gICAgICAgIHUzMiBub2ZmOw0KPj4gICAgICAg
IGludCBlcnI7DQo+PiANCj4+IEBAIC0xMTcsOCArMTE3LDE0IEBAIHN0YXRpYyB2b2lkIGJwZl9k
aXNwYXRjaGVyX3VwZGF0ZShzdHJ1Y3QgYnBmX2Rpc3BhdGNoZXIgKmQsIGludCBwcmV2X251bV9w
cm9ncykNCj4+ICAgICAgICB9DQo+PiANCj4+ICAgICAgICBuZXcgPSBkLT5udW1fcHJvZ3MgPyBk
LT5pbWFnZSArIG5vZmYgOiBOVUxMOw0KPj4gKyAgICAgICB0bXAgPSBkLT5udW1fcHJvZ3MgPyBk
LT5yd19pbWFnZSArIG5vZmYgOiBOVUxMOw0KPj4gICAgICAgIGlmIChuZXcpIHsNCj4+IC0gICAg
ICAgICAgICAgICBpZiAoYnBmX2Rpc3BhdGNoZXJfcHJlcGFyZShkLCBuZXcpKQ0KPj4gKyAgICAg
ICAgICAgICAgIC8qIFByZXBhcmUgdGhlIGRpc3BhdGNoZXIgaW4gZC0+cndfaW1hZ2UuIFRoZW4g
dXNlDQo+PiArICAgICAgICAgICAgICAgICogYnBmX2FyY2hfdGV4dF9jb3B5IHRvIHVwZGF0ZSBk
LT5pbWFnZSwgd2hpY2ggaXMgUk8rWC4NCj4+ICsgICAgICAgICAgICAgICAgKi8NCj4+ICsgICAg
ICAgICAgICAgICBpZiAoYnBmX2Rpc3BhdGNoZXJfcHJlcGFyZShkLCB0bXApKQ0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPj4gKyAgICAgICAgICAgICAgIGlmIChJU19FUlIo
YnBmX2FyY2hfdGV4dF9jb3B5KG5ldywgdG1wLCBQQUdFX1NJWkUgLyAyKSkpDQo+IA0KPiBJIGRv
bid0IHRoaW5rIHdlIGNhbiBjcmVhdGUgYSBkaXNwYXRjaGVyIHdpdGggb25lIGlwDQo+IGFuZCB0
aGVuIGNvcHkgb3ZlciBpbnRvIGEgZGlmZmVyZW50IGxvY2F0aW9uLg0KPiBTZWUgZW1pdF9icGZf
ZGlzcGF0Y2hlcigpIC0+IGVtaXRfY29uZF9uZWFyX2p1bXAoKQ0KPiBJdCdzIGEgcmVsYXRpdmUg
b2Zmc2V0IGp1bXAuDQoNCkhtbS4uLiBZZWFoLCB0aGlzIG1ha2VzIHNlbnNlLiBCdXQgc29tZWhv
dyB2bXRlc3QgZG9lc24ndCANCnNob3cgYW55IGlzc3VlIHdpdGggdGhpcy4gSXMgdGhlcmUgYSBi
ZXR0ZXIgd2F5IHRvIHRlc3QgdGhpcz8NCg0KVGhhbmtzLA0KU29uZw0KDQoNCg==
