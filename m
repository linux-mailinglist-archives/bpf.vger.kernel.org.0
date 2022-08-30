Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6145A58A9
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 02:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiH3A6a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 20:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiH3A6P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 20:58:15 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50C2A2A89
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 17:58:10 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TMpRiY030510
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 17:58:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=meRvHNW2+eajMcVR9b53xtnaRlUKRT4Hok+F1HLPGSI=;
 b=E0/kk0MQGswjshp0BuuhFRZCLBbsVGRA5GppybUsBJOZT0+uTSUUIYtF7PbSoSXByXTR
 5XVZveX0wfOqpMhOz9HPVwIpQnh796xk7irhhLrHkyKYxgllB/n/KEqyqy4tcYKPwh8h
 jL8oeBMcil9IEgdd5eGHlE0suGlGUSJLkZE= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j7h3uwf9k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 17:58:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMR7pT36+qAM41DibXQ7ffv6qFSkD8urNXxbdzcL163DO3D3MWk3fsXk1hOBaluIJui6oI1u8OSJrSQEXN2tZdjJHB4aGbtsF4xHZIq5PE/Wy0G4kuvscNgZ3MHtvZb6bOWKQgICCu0JumgBed56FIZheb0FlufN+rd+HxbQign+pLE4gP7i6C462gt0m2unGKaNU4TQ5gOhirgoIriMRsy6fwtUW5h0Un4rOsjJfFkhI2ht4/EQh0FW30ieBQAVOrZdah0yiIoiaQipZVOXZrrapnP/Ac19IwDE4ponOZQhXkW0xpHGRB3RMtvoERSIrEE2Sxz3SRvhAfNDLSyheA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meRvHNW2+eajMcVR9b53xtnaRlUKRT4Hok+F1HLPGSI=;
 b=TU2c9gCG/z3Hhg4Gw+Lc34o0FoZ7h7oqCozDANI74ncKaN+OeRZ96tcmtDLfffDbLnVBZ0U3DXG1+OaYApstSivkjqki5r1ZAwfnUeWQgQ82KnwZ6Od0RT0n8lkss4Um+bjpbHkKkuFIe1xd9Ie+dY+rGiT7g0kHbnZ7rApCQiftaTrYS9YQwGWZe3tHcX0zay8F/H8k4n7Ym27hvneljkU3+UMRgOfiXHbW+CcSIT95/2irNJB/U3ZvyvEc/p/pIuhGggbZ9C+79tUf6L5U8at6w2Dw+EfdGZmyJeGVUW6HPRD0SsV2Lez1tqDZhyotZeKiV3kShveSQRUt00Z80A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by DM6PR15MB2281.namprd15.prod.outlook.com (2603:10b6:5:8d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 00:58:02 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f%6]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 00:58:02 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v8 3/5] bpf: Handle show_fdinfo for the
 parameterized task BPF iterators
Thread-Topic: [PATCH bpf-next v8 3/5] bpf: Handle show_fdinfo for the
 parameterized task BPF iterators
Thread-Index: AQHYu9zclRlYWowWNEGMnR+ZA6AMha3Gnw4AgAAAU4A=
Date:   Tue, 30 Aug 2022 00:58:02 +0000
Message-ID: <2e22e86ae279bf786b742ac1b31fe12d986985cd.camel@fb.com>
References: <20220829192317.486946-1-kuifeng@fb.com>
         <20220829192317.486946-4-kuifeng@fb.com>
         <b6f3a06da330640382ca7885ec2500621eae9d80.camel@fb.com>
In-Reply-To: <b6f3a06da330640382ca7885ec2500621eae9d80.camel@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17966652-626e-4713-ef9c-08da8a22b07f
x-ms-traffictypediagnostic: DM6PR15MB2281:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hEZVxGEL183xjBiMd2b5EYjYuai15NQBntdtfJpRa/jyo/AsAd2Lceuv3fnNAa3YYz/1a26efyR2+3d0wJLnHvtKtiFOXdh9mMsBU5C1S2v64/D/7cfzrvzvbtezJYdLzRTx8rkX3q4bwPg8KKu2wqaz607kosaoRtgcQrDO9aMDjDMkDnHbpMucGdxsS0aqG/yqiypFQJCf2gPOfYiZii0g0+83ofTbneThILGBHBzGFQZtc5Amx8hmjsGLMvF7Ov/hA937sYoNmvYb1JaHqFqDZqADiXNrzPPcy+PrfSMD7YvuWRsMashU4cUZPUQXYFVE3dadIBjk1FKzN122r8RxjJhRZCTqaQLxiGI1RGmK2rEhU+31DeXncFZfDyny7jiggGPi5rvm959oVfbWsq6+vhBFqhUCctwcCwJn2aMfJDAjVvkSMXU3khSo1OWyy7S75AzcqBLSMmz70IEZhtiRguwvPohegwyDV3X+8MM0/oxo8evOetDMAgbR2JMiEKqkN/DbYUdKp+g1P/e6NRZuaNemHE917Hm2FtCvbVElOimDP7a7qAyrLpbUd7cQZUrCrSuvb6e3+0lDV/UNZF116KwN2J+pi6NP4B3ECkteDkr+MlL4GEsKciDJORKvoFfqZ92127ycC/Z8trU57QtKq0GMeSN08Lcaf7dmuh34ABtwCcRWXPaXAFfN7K7T77WMMXJJeU0jmBmcQoytGMs/UYnNqdmhVj+UZzEX4G/NHXWF8Qol49glMOlD/xYY6ksEyuq3GegtQpF5zl5I+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(6512007)(86362001)(71200400001)(478600001)(6486002)(6506007)(41300700001)(186003)(38100700002)(122000001)(38070700005)(83380400001)(2616005)(66446008)(110136005)(66946007)(66556008)(5660300002)(66476007)(8676002)(8936002)(64756008)(36756003)(316002)(2906002)(4744005)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2RIcGYxMUVvN0M1dFI4QmRpbG5DN1lNNjkzQ2ljZmxsZDVod0Q5YmRibkkw?=
 =?utf-8?B?YnZpcXN4b3BYUG1jZkl4OGt5eVhQTDYrQ1NIKzV0RGx2YzdWZklKZEdmR3g2?=
 =?utf-8?B?aEdBSTBrNk1wSFJiVHpvQ3ZwNmxnaHdqZmlVVk1RdERrYXJrL0YrZFVjRWZQ?=
 =?utf-8?B?VURNRGxCd1VqcXRGWG9JVmxYYUNUMm1rYWI2NHZnU0Z6WThrRWJ3OWU4Zi9s?=
 =?utf-8?B?ajNCdmVkL0VPVGY1MTFURjM2THpWeHlhMHZ5ZXRsc3hSWHo1eXdleWtNRjJn?=
 =?utf-8?B?YUU1UlRvUm03THd0T2w3Y2F0eU56eE9hODVjb0VpOWNNeCtyQWp3WSt4NjFG?=
 =?utf-8?B?T3BMK1BwNkYrZnQyZE1aQXRKWXkwMkZOU1BNQWQ1ODI5Q3NDcVh5d2NDOE5Q?=
 =?utf-8?B?blo3NWNOK25oTzFtL1BHaS8weWViNkNJN0JlVXcyYVFqMzRrWEFUa2Z3ZWVO?=
 =?utf-8?B?a1ZFY21UczZxYm5ZeHl5YzNkdHRFOEdua0xzdi9TZld1S1lvc1FDM2dhQm16?=
 =?utf-8?B?YmdJdmtzdHVVbnFYcnpnQktBaWRyMDExUHNvQXZBaFMzdGRQZTdpYnBkK2hn?=
 =?utf-8?B?ZDd5bmx4dXNCVkdPUHlJUVF5R0ViL0c4S0tudFRvUFZ4VkM3VW9kbDRxSFNP?=
 =?utf-8?B?SGIraTlhb0Q2RDgzUHhqOEdoZWRUVGlZeDBxT0pvMzVObkUvQ2tFTjdmRTU1?=
 =?utf-8?B?QWVzemlRbzFJWW5YYW9LRnR5ZU9lT2J2UVZLSUhGWEF2SSt5d3lmaHArSEZi?=
 =?utf-8?B?YWpNMG5JamJ6VGh3V01majhZTEk0ZWwyOWtzSjZGYTBubGROdUx1OFpQWHNr?=
 =?utf-8?B?OE1rV2o2c3g3NFF1a29aTktpOGJURVdNZFVIRDJjOFFMb3VnTVZJWUM1YVMr?=
 =?utf-8?B?WkJ1UjlLb1FCbFdrTU0vQi83cWxaQm1TRHhrR0htTWlvMHRSeEdLWXBWdGdW?=
 =?utf-8?B?Q05EVE55Nmd3SWhvTnQ1cWtobTBvWXRnNDQ4aWJPcEYwYlpKNFpIS2VTekJw?=
 =?utf-8?B?bkh4MzRSeCthYkZzaTcxczgxMlZlRlFybGV5bktnaTg5U3IwY28rS29vTUxu?=
 =?utf-8?B?dVNzeDhXeC9kQUNLVGZsSzdUV1JFdVYxU3dVK1JOa2VybzljNkNwMmdRUHFJ?=
 =?utf-8?B?aTcvYVJoT0dWVFdNbVdZeWdKYkNUZ2p3ZXRxOFcxMC9udFpJSWQ2OFp0cXdn?=
 =?utf-8?B?MlR2KzNTVlpHL2hrc2krRm1PdGg0RlltWGVndXloZGUzOXlKSW40cnkzYkZ4?=
 =?utf-8?B?RHljL01ZbmJ4dkhQbDhuaVJFdC9OQndvQkkxZnhGYitjTWJ1UkhCUzFTSGV3?=
 =?utf-8?B?dDRnVlpyODJPdU05NnN5aGF6SEdNbkovQ1FYQXZFcmdhbVF2RnVyeXRkZ1Nj?=
 =?utf-8?B?czZkTWFFOUtvV2tUZkI5Q1FCOUIrOFhmditEVTEwdFJPK0hlVFpuekRMUzFi?=
 =?utf-8?B?YnBjeGN2all5eWFwVURKcC92OVdqNlJ6RmsvYXJicm95dVJBdGxtSWo0UUVW?=
 =?utf-8?B?TTQwU1J1V0tTZWkrWXEwSWZVM2dqZll5RDV1RFcwRHFMV0tYUlNjaVZJT0RJ?=
 =?utf-8?B?OUhqVndWaXRPVW8ydUJ1VUFGbjBpVmpQSFA0bnNoZlBHMlFGMkVHK2FrcVF4?=
 =?utf-8?B?RmJwOXZqbyt5WFpWWjBUYk1TVlRsbGJlUnk2RGFOWm55czY2cXFDb0xTcWlZ?=
 =?utf-8?B?cVhsb1EzVkdJYm9oTDF1ZWgxT3h4cGFERk9SdFh3anVCSE1IdmhQZ1Zjd0hz?=
 =?utf-8?B?d3ZJaFBML0JqV3ZuM2ZNeEMwMDJQNUNtRFhMWERFZERkd1VUbndKWFJSdU90?=
 =?utf-8?B?L21oZVhKUVUwMDRSc3lwYXpEV2JRcmtYL3pWbGs1SDN6QSs2VGRNWlFqMlBF?=
 =?utf-8?B?ekRZUVpZZ3hxUjRrTTk3cC9yZy9WcWNZc3JOYXNHaURDS3pTMGxuRjBBL01O?=
 =?utf-8?B?VGh1MVRLdldYUk9jVDlzUDFxL3pCMGpxVTV1MkRMVmE2NFNSNjJPMlFscWRo?=
 =?utf-8?B?Q01GL2ZrV2wrQWRFYi9NOTEwenVyYzhsZlkvVElDelhzQjNaTEJ6MnhuTmd0?=
 =?utf-8?B?NXg0Z3VpWWNtY0dLU0xaR1ZjQXlVeFh1SGtlQnd1WVd5eW5maGdJdHNVOXRC?=
 =?utf-8?B?UFp0eWE5dG9GK1c5b0ZVM2x3L0JCUEdWblJRS1Z0YWNhK081V2lRaTRGYUFU?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46D97C720582A247B528ABD7743CEF3F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17966652-626e-4713-ef9c-08da8a22b07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 00:58:02.0729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e7wDpc1at3jkrwzvCxCd+ncWBF4Q6chu79dsf1MqwmXvOECn8v9vv4wIqhW8Gm3B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2281
X-Proofpoint-ORIG-GUID: A6tOoi3g_svJ9JVoCw9KJKbjCvjYEdEv
X-Proofpoint-GUID: A6tOoi3g_svJ9JVoCw9KJKbjCvjYEdEv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_13,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTA4LTMwIGF0IDAwOjU2ICswMDAwLCBLdWktRmVuZyBMZWUgd3JvdGU6DQo+
IFNob3cgaW5mb3JtYXRpb24gb2YgaXRlcmF0b3JzIGluIHRoZSByZXNwZWN0aXZlIGZpbGVzIHVu
ZGVyDQo+IC9wcm9jLzxwaWQ+L2ZkaW5mby8uDQo+IA0KPiBGb3IgZXhhbXBsZSwgZm9yIGEgdGFz
ayBmaWxlIGl0ZXJhdG9yIHdpdGggMTcyMyBhcyB0aGUgdmFsdWUgb2YgdGlkDQo+IHBhcmFtZXRl
ciwgaXRzIGZkaW5mbyB3b3VsZCBsb29rIGxpa2UgdGhlIGZvbGxvd2luZyBsaW5lcy4NCj4gDQo+
IMKgwqDCoCBwb3M6wqDCoMKgIDANCj4gwqDCoMKgIGZsYWdzOsKgIDAyMDAwMDAwDQo+IMKgwqDC
oCBtbnRfaWQ6IDE0DQo+IMKgwqDCoCBpbm86wqDCoMKgIDM4DQo+IMKgwqDCoCBsaW5rX3R5cGU6
wqDCoMKgwqDCoCBpdGVyDQo+IMKgwqDCoCBsaW5rX2lkOsKgwqDCoMKgwqDCoMKgIDUxDQo+IMKg
wqDCoCBwcm9nX3RhZzrCoMKgwqDCoMKgwqAgYTU5MGFjOTZkYjIyYjgyNQ0KPiDCoMKgwqAgcHJv
Z19pZDrCoMKgwqDCoMKgwqDCoCAyOTkNCj4gwqDCoMKgIHRhcmdldF9uYW1lOsKgwqDCoCB0YXNr
X2ZpbGUNCj4gwqDCoMKgIHRhc2tfdHlwZTrCoMKgwqDCoMKgIFRJRA0KPiDCoMKgwqAgdGlkOiAx
NzIzDQo+IA0KPiBUaGlzIHBhdGNoIGFkZCB0aGUgbGFzdCB0aHJlZSBmaWVsZHMuwqAgdGFza190
eXBlIGlzIHRoZSB0eXBlIG9mIHRoZQ0KPiB0YXNrIHBhcmFtZXRlci7CoCBUSUQgbWVhbnMgdGhl
IGl0ZXJhdG9yIHZpc2l0IG9ubHkgdGhlIHRocmVhZA0KPiBzcGVjaWZpZWQgYnkgdGlkLsKgIFRo
ZSB2YWx1ZSBvZiB0aWQgaW4gdGhlIGFib3ZlIGV4YW1wbGUgaXMgMTcyMy7CoA0KPiBGb3INCj4g
dGhlIGNhc2Ugb2YgUElEIHRhc2tfdHlwZSwgaXQgbWVhbnMgdGhlIGl0ZXJhdG9yIHZpc2l0cyBv
bmx5IHRocmVhZHMNCj4gb2YgYSBwcm9jZXNzIGFuZCB3aWxsIHNob3cgdGhlIHBpZCB2YWx1ZSBv
ZiB0aGUgcHJvY2VzcyBpbnN0ZWFkIG9mIGENCj4gdGlkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
S3VpLUZlbmcgTGVlIDxrdWlmZW5nQGZiLmNvbT4NCj4gQWNrZWQtYnk6IFlvbmdob25nIFNvbmcg
PHloc0BmYi5jb20+DQoNCkkgbWlzc2VkIHRoZSBhY2tlZC1ieSBoZXJlIGluIHRoZSBwcmV2aW91
cyBtZXNzYWdlLg0KDQo=
