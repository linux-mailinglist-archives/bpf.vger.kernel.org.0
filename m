Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D9B5A397F
	for <lists+bpf@lfdr.de>; Sat, 27 Aug 2022 20:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiH0Sdt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 14:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiH0Sds (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 14:33:48 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DCC5D0CD
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 11:33:47 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27R7WCXQ016960
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 11:33:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Wdj7LDJOkimE7X2HsoKoQH+X/Fktq49Tl3bGixcWzfk=;
 b=g2VwwbMk4euwtXUkqv98J4Emxo4qVAc6kGCxOSOxgVp7MqE3vFrUdUflpxoxqg7RyXgT
 +Rky2R2DP59t1RIoHBVSp/4WthorTKCfq0TPSind3UyiUr/7johz60CFff3v3a6kbAw9
 +r4PExRRUc6GdxVJXRK1tnMVRr+J0bMeMco= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by m0001303.ppops.net (PPS) with ESMTPS id 3j7exy1wwv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 11:33:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnKin4d6+KXJLeNMIsYLZL5kvpx5DtOK5Y9HP8p43NAU6m19RiI3SvTUUFKjqfF9dQfvu4xwkD2OK/2MyV0zJF2sLTvu/O6TkR3VCjyDjSzd7qVd9FjElrz421dr4j+vsYtTFjDh2KKwVBrei9clirAt7G0xMOmyzPf+OaFxaEkU85LT6WZRtNpc3Hiw0GI8RTe4U71k4QTNGjy7x+9pG4Z/BP9he0sAw5wUsVta3nGW8/JB3lfwCPC326J5PVJ4Xf68u3E2WstJ2G2MdSg08xBvv/zHEGP3aUToLJfOHbuqKz0ny2Bcf9Nd35A5YB1dQlWiCPTQT/aIq8HBje9m0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wdj7LDJOkimE7X2HsoKoQH+X/Fktq49Tl3bGixcWzfk=;
 b=L96uVxC7YNm7EKiYyHLL6I21ag71loqJ98MeV80wV5wB8r8kGN3zODWCEQzjvPtAVd1ntjIvKWtoKN28cC36R26vMQVzwLivWLYFXScn2fC6m6SNu83PMswqxcSSOhBPgjjepZk2YMaOvuOhlbUWPavxqJQ4lV48WBOOxH3zt9Cus4Ioi7+l0cRF3H0jcCqU0021jDq5lMz4Qxbg8/u78R5BtAfksMlDnxO//M5Ibjg7fYG1oGbjiHFBWfMfWSXoS52WKlWYHKMquHF9lk+ZYscIA+SZf+al+0/2tfaCLXkk4JI2NDQlVvwNebkzCwbZ7s404mw0u6AHGfgeU+OwIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by BL0PR1501MB2019.namprd15.prod.outlook.com (2603:10b6:207:33::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Sat, 27 Aug
 2022 18:33:43 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f%6]) with mapi id 15.20.5566.019; Sat, 27 Aug 2022
 18:33:43 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v7 4/5] selftests/bpf: Test parameterized task
 BPF iterators.
Thread-Topic: [PATCH bpf-next v7 4/5] selftests/bpf: Test parameterized task
 BPF iterators.
Thread-Index: AQHYuOQkfizuDox+9kSFAPPFDnGM8a3BsomAgAFiwIA=
Date:   Sat, 27 Aug 2022 18:33:43 +0000
Message-ID: <b453f23f1d78b40616e8d55649eed117a4925133.camel@fb.com>
References: <20220826003712.2810158-1-kuifeng@fb.com>
         <20220826003712.2810158-5-kuifeng@fb.com>
         <6a783eea-dd72-eb8c-7ce4-8dfb06bb1fa7@fb.com>
In-Reply-To: <6a783eea-dd72-eb8c-7ce4-8dfb06bb1fa7@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ef22fc7-d0b3-4ef4-3961-08da885aabd1
x-ms-traffictypediagnostic: BL0PR1501MB2019:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cGUBzV0zTYbYxUXfRoCJqMUVhNZDLFrk/ThN7XjY7PFIQD5JrE+K6kXp9+IYkE3oAy5cZpNUwQA+nar5I/wya2ot+yNZee45+E0v9npaannxCZ9aiwrRbZvw4JedhaGwzH6sqCzrTZWKRXp1vpKXQcMeSxuuUGTosHBb51mkS52eUdPILdPEQSlSuUgfTK4wzvTrwzytr5MxDtgXeGoerz04/jzAAu5PL4imZDuQKFID0nrWBCGqr37dfg3rPUgJQZ4hEFrPy2gmb2YSngLTJC7eMh6MCF7FW+GlkJ+57Z+vsvy2ILsZoHaJXZ/pEvTmlj4wQ5KhBDEev9vqBtBUZ6ZQPQPbCdvL21nnd5dSr/oUhMsOZo7nwQtTK+yiEQq57McOd7Nk0rbTw6WW9c54JOml/hgMNQuFXMj20Lw++0mzmgBeWlfeT9jV7tBEa8Hjf54LY+41eBQKzyajLViHnVtaEdw8I2hgKc6EdUQ0WLAZAzw6+/nHuC3knUcPv8Rmwu5TQd2ckwvC9b1lp9mPw6NKam2C3h4n9OmILxk/9aRW6LOy0BG8iLDS6IQU7e1RC/l6Ky/Xo1ZY1V7qDKulVQ38DYklZOrwA/cRxZwGXCkeIHIyaxn4Zkto0Ts8dIaF2VLjRL/u5gleKi0Zd+POW6kCQuQp7HL2wzOZDUJwYGLoulWSznUEnHl8tlHeXHT11DyuL6N/uU1H3uvNq0+fiChKZa7vNCgz7L5z6R6/LcHGizUKKVHmYBMKtOBEi25wFcciuK0kReOV9GKokkEqkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(6506007)(36756003)(53546011)(6512007)(186003)(2616005)(110136005)(66946007)(2906002)(76116006)(316002)(8676002)(71200400001)(41300700001)(66556008)(6486002)(478600001)(66476007)(64756008)(66446008)(122000001)(38070700005)(5660300002)(86362001)(38100700002)(8936002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWRVSUVpcExvaXB0RzdNaDJYSjJFQ3BFNC9XdDVNRnVTd09tZ2E3bkVhNVh3?=
 =?utf-8?B?WnpVeXUwaDZrejBYTmE5SVpOaWRLMXVIemJVOTlVdDJRUVNjempNQmg5NVYw?=
 =?utf-8?B?Q1Z6ZVZCUUFVM08zUjIwRmRHOXMzQUYwWVlzSDU1WGowcXBHRmVYZHlhWWpD?=
 =?utf-8?B?MzJUY0R0akNoOXlXUk9lYzZic3ZkeW5qbzRsQUpHanA1TlNEYXBxVENoVmU0?=
 =?utf-8?B?OEovOVFGajNNekNRb0J5NnlOY1BsbkxSTGJDTUxkYTRUcGkzWUl3YmhYTGhk?=
 =?utf-8?B?UUd5YTVXUXVxRWYrRXlRWlV3bEw5aUx5TUlSZVhRb1JzbTV1b3hzMmNSajVL?=
 =?utf-8?B?UUd1M2lSUFFiRzJZS0RuMWZETnhMeGFRcGt3R0d3NnZld3ZFRk4yczI0MXh4?=
 =?utf-8?B?ZHMwYkFBSDF1WFVKdTl2ZDZsVHR2eUR4djFaajk2aC9GQ29oSnp5R05hZmVW?=
 =?utf-8?B?b1E4dm9aTGVyV20xbzVtODl5dTFzRkwxUTBlZndFcndXOUdkUGNCcnRCNWtU?=
 =?utf-8?B?a2hhMkwrZEJnVGNYUDBrb1cySExkdWN0bzJ0b1B0RGhyZ3drMElEUElCeFE2?=
 =?utf-8?B?c2VNZHhvdU0rb2hnVWxnRlRzSGoxbTNXZWN1UTVkVVdYZFJ3MzlIZDZ2UU5k?=
 =?utf-8?B?NVNwUHZDOWh0UHIwT2I2dFhHWEVtYm55c2JxeVRkVjA4bjVTK1lJL3c3bG54?=
 =?utf-8?B?Nzk2N0RlMGVtNzRPYTlHUnlLdFpjajBZWkxmRWxVUWF5MHNaZWJzT2NPanJO?=
 =?utf-8?B?UVlzZ1dRREczSlQ4ZjUzSVJET24wN2tNT3R1dG5Dd0ZKNjM0N2w1dTJKUFBx?=
 =?utf-8?B?SEhqQ29pNXpTRERwUUpmQWh6ZEZuVGpvZFFlZzdJZWFSbmdxc04rblV4NjEx?=
 =?utf-8?B?a0VHNXE0amRsQ3JraGltMUloMS9HcTE2VDloV0pGNHlpZWFIZkhjV3RMeExN?=
 =?utf-8?B?L2IyUGE4VUNRQ1FmbnM1VVBQZ3RuSmpaYWpXOTBVWVRqUlRmOWIwUVBudi95?=
 =?utf-8?B?YmVPWnVFUEVMY2hBRDl3Q0lIV2cwTFdkWHc2d2NVQmJoemQyV0Z1SGRCRnFU?=
 =?utf-8?B?MDB4VE5TQkh5QU0zYjZUNkpQV2xxK3V0MFBJMmk2aWZTVEhRVUNLMEorcTZJ?=
 =?utf-8?B?Ry9ZSzhLUnFITEgvVWVzZDR4QTluZmxaSklPSmFtUmcrcWNOYU1iS05Ka05U?=
 =?utf-8?B?REttZkplaWJRQlJWaUtZRE54M1E1MGlrZllIeHRCTE9MaTlCNmZrWlNCcitv?=
 =?utf-8?B?NUREdE1nOHR4cGdrME5RZkJqUk1rQWNXZ2xpV3VjM0xubkhKVm1aTnFkd2s3?=
 =?utf-8?B?Uks4MVNNRERmbkN3K2k1LzZjY1lhT21aUGlLMnJlUFhZenU3VUlnOThmUTZx?=
 =?utf-8?B?WlR6MTFxbjQ5UzZwODN2dTF6MFNrb0EwTWlkaHRJbDI5WnFHQktEOFZLdjFF?=
 =?utf-8?B?RThBL2ZxVG90Y0p6VUVYMXdLRVlYUlMvMkdESTVFRFFnYXJyUENDSEtIdldI?=
 =?utf-8?B?QStkczlrZGlhQy9TeTRxVXQvOFduRC9qTHJXT2pCbERYY2xoRFFmb0VKTGZa?=
 =?utf-8?B?L1UzVnd6Z2dhRjRwWEpERG5qczN0OXBSRGNNRndoNlhwaUtaa3lCU0VsRlgz?=
 =?utf-8?B?Z0RUYlBNN2xXU1NEOVljODNEL1NDekRiZVhyelpKQnFuOWlqYjFYSXpkT2pL?=
 =?utf-8?B?d1JHbmJ3ejAwTjVOQVViSGQ1YnFzODNtSzFxckZwc21KUEJpZnU1Ry91d29B?=
 =?utf-8?B?OW43V0plOTEzNENuN1JIcGF1YldEdnNwTUFHZHgvS0tCamQ5ellvTzZLS25D?=
 =?utf-8?B?RFVPRFlyK0RTOEZvcnZNWFZkMEE3alJzOGhCMGFCOFpWTGxhRXpZZ2I0L1FG?=
 =?utf-8?B?MndKWTA5NXUxYWlneHJyUlNGaHE1WXZ4TzlRYjRGdllQQm4yd2xKdzQvZjB4?=
 =?utf-8?B?OHM0ODhPTUI3Vm45YUx1cmhFYjlhaUk5dzhHR2U0NEZoMnA4S21YaHpUZDBo?=
 =?utf-8?B?dXlwQ0t1ZnlielNMQU43Q3VUbklsT0xMUnN6K0IzT1lBcytvS2NsYmFpNHNO?=
 =?utf-8?B?YWI3TDhGcUk1SER6eVk1eGdYZkROdG9QM0VkUGJEK2hDWGF6Zy9PR3MvcnZT?=
 =?utf-8?B?U0Y3bWZKTkYrMVhpZ1VQanNFaTVMaU9iVkxZZ0JZRkRGaGo0WDdydjc3djI3?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FCCF541855D204AAD5C59C02C9B8223@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef22fc7-d0b3-4ef4-3961-08da885aabd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2022 18:33:43.7083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KNVkTJ1XErGUUXO+317sdc+KlJPI2vjNxKGBI4N7778/DoHF9AkaLSkkzhcodzhL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB2019
X-Proofpoint-GUID: H0TS6Y-5OIZreN2C4e8aGldhEuKiE286
X-Proofpoint-ORIG-GUID: H0TS6Y-5OIZreN2C4e8aGldhEuKiE286
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-27_10,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gRnJpLCAyMDIyLTA4LTI2IGF0IDE0OjI0IC0wNzAwLCBZb25naG9uZyBTb25nIHdyb3RlOg0K
PiANCj4gDQo+IE9uIDgvMjUvMjIgNTozNyBQTSwgS3VpLUZlbmcgTGVlIHdyb3RlOg0KPiA+IFRl
c3QgaXRlcmF0b3JzIG9mIHZtYSwgZmlsZXMsIGFuZCB0YXNrcyBvZiB0YXNrcy4NCj4gDQo+ICd0
YXNrcyBvZiB0YXNrcycgaXMgY29uZnVzaW5nLg0KPiBJIGd1ZXNzIHlvdSBtZWFuOg0KPiDCoMKg
IFRlc3QgaXRlcmF0b3JzIG9mICgxKS4gdm1hLCBmaWxlcyBhbmQgdGFza3Mgb2YgYSBwcm9jZXNz
LA0KPiDCoMKgICgyKS4gdm1hLCBmaWxlcyBvZiBhIHRhc2ssIGFuZCAoMykuIGEgc2luZ2xlIHRh
c2suDQo+ID8NCg0KIlRlc3QgaXRlcmF0b3JzIG9mIHZtYSwgZmlsZXMgYW5kIHRhc2tzLiINCkl0
IHdvdWxkIGJlIGVub3VnaCBzaW5jZSB0aGUgZm9sbG93aW5nIGxpbmVzIGV4cGxhaW5zIHRoZSBl
ZmZlY3RzIG9mDQp0aGUgcGFyYW1ldGVycy4NCg0KPiANCj4gPiANCj4gPiBFbnN1cmUgdGhlIEFQ
SSB3b3JrcyBhcHByb3ByaWF0ZWx5IHRvIHZpc2l0IGFsbCB0YXNrcywNCj4gPiB0YXNrcyBpbiBh
IHByb2Nlc3MsIG9yIGEgcGFydGljdWxhciB0YXNrLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IEt1aS1GZW5nIExlZSA8a3VpZmVuZ0BmYi5jb20+DQo+ID4gLS0tDQo+ID4gwqAgLi4uL3NlbGZ0
ZXN0cy9icGYvcHJvZ190ZXN0cy9icGZfaXRlci5jwqDCoMKgwqDCoMKgIHwgMjgyDQo+ID4gKysr
KysrKysrKysrKysrKy0tDQo+ID4gwqAgLi4uL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy9idGZf
ZHVtcC5jwqDCoMKgwqDCoMKgIHzCoMKgIDIgKy0NCj4gPiDCoCAuLi4vc2VsZnRlc3RzL2JwZi9w
cm9ncy9icGZfaXRlcl90YXNrLmPCoMKgwqDCoMKgwqAgfMKgwqAgOSArDQo+ID4gwqAgLi4uL3Nl
bGZ0ZXN0cy9icGYvcHJvZ3MvYnBmX2l0ZXJfdGFza19maWxlLmPCoCB8wqDCoCA5ICstDQo+ID4g
wqAgLi4uL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvYnBmX2l0ZXJfdGFza192bWEuY8KgwqAgfMKgwqAg
NyArLQ0KPiA+IMKgIC4uLi9zZWxmdGVzdHMvYnBmL3Byb2dzL2JwZl9pdGVyX3ZtYV9vZmZzZXQu
YyB8wqAgMzcgKysrDQo+ID4gwqAgNiBmaWxlcyBjaGFuZ2VkLCAzMjIgaW5zZXJ0aW9ucygrKSwg
MjQgZGVsZXRpb25zKC0pDQo+ID4gwqAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL2JwZl9pdGVyX3ZtYV9vZmZzZXQuYw0KPiA+IA0KPiBb
Li4uXQ0KDQo=
