Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4111A4CC75D
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 21:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiCCUyz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 15:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiCCUyy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 15:54:54 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8665911942F
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 12:54:08 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 223KGHHj015839
        for <bpf@vger.kernel.org>; Thu, 3 Mar 2022 12:54:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=xLYmR5uSzwgHdk0Heu/UQ26jxpwQ5VZKVtEPtXoBe2I=;
 b=qIqqg12pq0QOMCKSafi0+m5TH08P8m1ArX4oAGmMHDLX5TH2gkA19u0UO+QvruGqDkK0
 t5/T4TLzjaLoqnMpoZC89wghb2tBpNO2KCtmDLnA7KW7GV77+xInbVA+VEinPWoFNFbB
 v86joYhX9IKh8im/f3Wxl+T5HKQZesQXBi4= 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ek4jkg893-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 12:54:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Io16HzWgLyvwizvwlYXSnnEkOzy/a3GnYjqaWew84OkfoCk6P2iLX8XDe0b0yDw7AnoCpuccSXPyKYNDeGtXEfBSgj0Q0si6IEs5JaM6NgK1RUcjJc9n7PW6Gs0bGh3pTO1t+/C20+zeGeqqcoGkH3qpnn3AtQyMOru+i0j4hr2y6dWXZkk2q+vCKKkPA9nVeaE8OgvblUXpGIyd2gGSEi2DxFYHraJKTk+KnDOTlXtn9XVmDriaC9Kh8OQuMxpFucBozF5AzcHbto8aVJQoiv6H+mmoo/kmQh+achetx5pSTaOaoVo/5uaYIdNjpeO+KbS7/j+n+93bh8+YTjpfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLYmR5uSzwgHdk0Heu/UQ26jxpwQ5VZKVtEPtXoBe2I=;
 b=gCnVGvGKj5yDHn/HjKZ7qOD5dHlaMyOXyHR6M7eqDoHznssU0bbBUD73keZL1sVtCf4nJYvw/4k4Y4om6oVOie0uWyraxTOkwTTNf2yheL1BqkYG833yGfgZKshn7Pvbca5+0I6ZrHFY4B8IRScvDJ2U4WXJbz4UJpBjGK8n9E/40yZrG5vIqViw4rfcTOVbL1AaaNFfZBdnldQG05kt4K0ZV091quco29aFjUrY4mkZkyAVgJmCApr8nJp6v4VFANDLaFVrgiLVVuLzu19XWcJWroFoI+3neNEqF0hfkMws6O826/+mMg1pRaFNezppnJ5QmuoUrKr+GQYMPKiKig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM6PR15MB3800.namprd15.prod.outlook.com (2603:10b6:5:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 3 Mar
 2022 20:54:05 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%5]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 20:54:05 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/4] bpftool: add support for subskeletons
Thread-Topic: [PATCH bpf-next 2/4] bpftool: add support for subskeletons
Thread-Index: AQHYLeAOF8q5RjwbxUKWJ0TpgoNb3ays5SuAgAEewYCAACCQAA==
Date:   Thu, 3 Mar 2022 20:54:05 +0000
Message-ID: <108158a8914fbae73f750d635773172db007a704.camel@fb.com>
References: <cover.1646188795.git.delyank@fb.com>
         <a679538775e08c6f7686c2aec201589b47eda483.1646188795.git.delyank@fb.com>
         <CAEf4BzZzAToLHESKrddn2y1FoLHHUVGzJe7=1ih0E3EA7BBdHg@mail.gmail.com>
         <9028e60f908d30d5f156064cebfd5af8d66c5c9c.camel@fb.com>
In-Reply-To: <9028e60f908d30d5f156064cebfd5af8d66c5c9c.camel@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53454510-e010-4731-b6a5-08d9fd57f48e
x-ms-traffictypediagnostic: DM6PR15MB3800:EE_
x-microsoft-antispam-prvs: <DM6PR15MB38007327670364BC2090E1CFC1049@DM6PR15MB3800.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lYD/xAX0G2Mflf8nqOqwKGLsZyzx8JEX7B5N2otzwlhFE4MHcIXNC9eS1FCD5pMZ4bz4yP4nK0NbuULR/rvodMpqGsQOYu8zqSspksP1GqrHoTv/X5f2rtC8t9XFXPJXTBvmnzk+cJTn5hZKy9ctJ22vZnahN3fgjRHt/x7QSHvgFlEGQy4lClT9q2YZS6ffKWP9k9UpOGIAPu46ftCIF5o6sKhBaPpNoTfbRxGX2r80buO47fo2hFYNKZS4x8ekjEFfwgqzTS6pCxz6j5JI3XHAmL7twct9IkgkUjHFjR137WgGMqxfxFK/gK41kgOFgA2f/KkcJLHI2AW49u0c+JZuCjK8DIFH5t30Whpr86Q5ktuR77F5jYMEFoECtm+7Fnkyg88SHUnIOdsAiACZY3QbWyHCnjIr11HgRyGC1r5xgERY/LVwZ3Iu70TOIaKkWy+8z3pV3FCBIv4G3pMHzFwYaHr9ZCVsyPEiX7Jxe1QuS5K0pylBrtx+rbfTLtGfgC9j6fBbCWFrGHJUzL3AePi58jbza1wJuUvz4uvpN4v74M1hVQAUjak+pb+kwFXbrsibsFBB8WaXwTeHg9Ebke35z8M6RxKsDDkvsiX93VqA/Y/KKAK5bArgyj9fJCCSL84XO7gULA2uOAf/HkPxvQF7mfsDwwfUflZSw+m+RpCUhzMbfZ/PheUsyUkTngu2WjfI6KwI4gWBYdzzOHNfXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(38100700002)(6512007)(6506007)(36756003)(5660300002)(508600001)(2616005)(6486002)(4744005)(86362001)(71200400001)(8936002)(38070700005)(6916009)(2906002)(54906003)(66446008)(66476007)(4326008)(8676002)(91956017)(66946007)(66556008)(76116006)(64756008)(316002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTVCYVBUYjVNYkpMQ2hSVTRoUFNDb3ZIN1Q4dmJLVnd4NGxUbXJxNHJYcVNB?=
 =?utf-8?B?ck1Ea08ycmJlZEtGMjdZeWxlY3ltbTZnUFk1dTFLWm5LQVdRek1KeWk1cTJk?=
 =?utf-8?B?cDE0R2svWmgraGx6SWpOQzhnQU03bzV3d1dvL0pyNzF5Y09GdmpkZyt6STdQ?=
 =?utf-8?B?ZjlYSEFleVMwbWpDcUNsQ1lrNVNxWEVWdlo2c2F3RTZMRXpsQkFrUFVRbTBy?=
 =?utf-8?B?TjhXRTl3TDhaNkQvZm5WbWJnZHYyaHN1d0R6aVowb1JpdHJtWElJOXllc0wv?=
 =?utf-8?B?MU1JMHpDekpIRThSaHJmTm13bGJrRGsxb3ZEVlVsdy9Lcy8yVGovbVJnQnh3?=
 =?utf-8?B?emNJYkdNOXZDczFQZkdMTVFxd08rVWNJRGxoNEM5V0RkbmhnaFZzMytCdVdz?=
 =?utf-8?B?SWlqR2I2SGhBRTZxWFppeU1BSThmamxsTisxSjMrekpHb0JNWHpyWnhQWFB0?=
 =?utf-8?B?THQxR3ZTUlNaVXNlTzRXRnJKMG1mc1JBT0M4Si9DNG1vZTZnWklWUkZ4ZDZl?=
 =?utf-8?B?aWJoaXpTKzV5a29RM2VuZjhEUCtXbjBaMVhwQmtuMzE2S3BQTHlzM3BheXJo?=
 =?utf-8?B?UmVFcnV2YmxTY3pUc014bVFxL1FjNVFPTWEzZk03T3lWMHRlS0p1WFBmWWZ4?=
 =?utf-8?B?ZEJQcDg1Wm5RU284VEphQlpmcXpsejgrQ253Y1hueU5iQ1lJQUlvWlZnbFJw?=
 =?utf-8?B?MmJPZmg5TDE1Snl1ZENJdkJEdGU4b1NkOHZ5MjJEdkRtRmI4U1lJVWg4dHov?=
 =?utf-8?B?c1FDUXRoM215OFNlSmxFM2dsK0NGbkN1Q2RGOFRtbmtmWVBJUlg1NGdBeFRJ?=
 =?utf-8?B?RUJHcHNtLzFJbytFZExUT3oyR1JVdmIzVTVlVW1XVllwdytPZXpsU0d2bDZq?=
 =?utf-8?B?em5INHNOMFpCdER3L0M2WU5yVElJWXlranh6UHpabFVQNE9vQkExVWRkajls?=
 =?utf-8?B?V3UySDJ4QlVHRzU5KzFraDJVYnpBd1orc01oWXpGOEFhSFhlcWNWbFd2U3Vn?=
 =?utf-8?B?REpoMEd4L0tjMDlzb3kxWlF3U3UzQnBac2ZCOCs0Umd6amdXcUkwQjdHY29p?=
 =?utf-8?B?RmMvVWdFVXZwQ0w3UDlRcnhoUnJhYXMxaHpNZGU4SG5LdlpSZXA2Smx2dlBM?=
 =?utf-8?B?SVFXdnYwU1B5SkNNd1ZZb0E3ajBLQS92Nk1lV0xxMkFsVnppZjFPTG16UmJQ?=
 =?utf-8?B?Y1BGeVVvbVlPWVB1OE1yUUFvd3l2c01jcFdnc0dHNW5yQm9CN3pKNG9xaDIw?=
 =?utf-8?B?cXpsOWVhSCtETzNUUitWekJPUXRtRG91b1g3K0cxaXkwUFNpWnhoT0RvS3hq?=
 =?utf-8?B?N25IeVlzS29XMkc4UGVPZ0U2Z0dWOFBuZHBTakFEb0wxV25LS2xUYTY0Tkp1?=
 =?utf-8?B?dDRvWk1XZkxXU1pzOW5ycDBLT3YzbHRnRFJ2V00yKy9MSDRIZi9KNG1Jd3ZE?=
 =?utf-8?B?ZGptdk93ZE8rTFFHZlpVeU1BWEw3MXljazhTUGFPenYwYysvWU4rdGtMMk1S?=
 =?utf-8?B?c2p2Wm1XaGh3elR4emJOSGxBVlRSOWQzNHowVStodS9ra1hiY09VOGVaZlVR?=
 =?utf-8?B?QU5ZcTZqV2dqU2k2L045T1RUQUdOb2NRRDJpSlloVzM0c1VmbjZyQ2xod1hK?=
 =?utf-8?B?V1FLdjlPbjkxaSt0L2MwbW9OaG45LzFlSlBDQmp1S0hGbFlvT2dzUXdzQTZW?=
 =?utf-8?B?WTJmdy8vU09YRHVTcGhRMk9tTHJneDFrUzRsRExaOVA2N0RHbFRGZ2RBMExy?=
 =?utf-8?B?OGtnS0llWnE3Z1RyMFlDalhhdFpVR0NPeGpkYVdZSXJWdWxDZEJTM3NoNEI3?=
 =?utf-8?B?ZU1KbUFPREpSdDIyWFlmWFJJaGw4YVJLVGxIRGVuTUJjQ1BvYnI0dkVTbWVt?=
 =?utf-8?B?TVhVK2tpTFhGTmUyUmVPbEdvREVzcDhMUUdRM1paTmxLbWxEUzlSN1ZFRTkz?=
 =?utf-8?B?Q2x3eTB5OXBhWHE5OEt4N3JFQjNlMzFNcXdpbjJZcy9sVldzRVpxTUJTY3FM?=
 =?utf-8?B?TjUyZTNNUkRCRndXNjdKaG96akh5c2lCaVk2dGMraE5iSzN4cHI1cUcyeTZs?=
 =?utf-8?B?UHhkQ0pVYmhscjk1V1ZvVERRM2c2YnRMUGszY2FzZFNTMSs2cnB2SlpBY2Vv?=
 =?utf-8?B?ZWFTN0VmNWlhV1ZPTmkwblV0a1luS1hETm51NVNUdlZtc1M5amxtK2I5YkRP?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <535D2126D2A3734A9BC958AE01AF9BF6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53454510-e010-4731-b6a5-08d9fd57f48e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 20:54:05.5986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kxNChB3aXI+39pk+xlFySoF11v3pEKxNwDs4esShbDNUACTg5Ehm6D4D7VqCqGUN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3800
X-Proofpoint-GUID: YX6EDln6nby0m0PEfbqDZ0re3K0uDYxg
X-Proofpoint-ORIG-GUID: YX6EDln6nby0m0PEfbqDZ0re3K0uDYxg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_09,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203030093
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1LCAyMDIyLTAzLTAzIGF0IDEwOjUyIC0wODAwLCBEZWx5YW4gS3JhdHVub3Ygd3JvdGU6
DQo+ID4gDQo+ID4gPiANCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1hcF90
eXBlX2lkID0gYnRmX19maW5kX2J5X25hbWVfa2luZChidGYsDQo+ID4gPiBicGZfbWFwX19zZWN0
aW9uX25hbWUobWFwKSwgQlRGX0tJTkRfREFUQVNFQyk7DQo+ID4gDQo+ID4gaWYgd2Ugc2V0IG9i
al9uYW1lIHRvICIiLCBicGZfbWFwX19uYW1lKCkgc2hvdWxkIHJldHVybiBFTEYgc2VjdGlvbg0K
PiA+IG5hbWUgaGVyZSwgc28gbm8gbmVlZCB0byBleHBvc2UgdGhpcyBhcyBhbiBBUEkNCj4gPiAN
Cj4gPiANCj4gPiBvaCwgYnV0IGFsc28gYnBmX21hcF9fYnRmX3ZhbHVlX3R5cGVfaWQoKSBzaG91
bGQgZ2l2ZSB5b3UgdGhpcyBJRCBkaXJlY3RseQ0KPiANCj4gVElMLCB0aGF0J3Mgbm90IG9idmlv
dXMgYXQgYWxsLiBUaGVyZSdzIGEgZmV3IHBsYWNlcyBpbiBnZW4uYyB0aGF0IGNvdWxkIGJlDQo+
IHNpbXBsaWZpZWQgdGhlbiAtIGZpbmRfdHlwZV9mb3JfbWFwIGdvZXMgdGhyb3VnaCBzbGljaW5n
IHRoZSBjb21wbGV0ZSBuYW1lIGFuZA0KPiB3YWxraW5nIG92ZXIgZXZlcnkgQlRGIHR5cGUgdG8g
bWF0Y2ggb24gdGhlIHNsaWNlLiBJcyB0aGVyZSBzb21lIGNvbXBhdGliaWxpdHkNCj4gcmVhc29u
IHRvIGRvIHRoYXQgb3IgaXMgYnRmX3ZhbHVlX3R5cGVfaWQgYWx3YXlzIHRoZXJlPw0KDQpVbmZv
cnR1bmF0ZWx5LCB0aGUgaW50ZXJuYWwgZGF0YXNlYyBtYXBzIGhhdmUgdmFsdWVfdHlwZV9pZCA9
IGtleV92YWx1ZV90eXBlX2lkDQo9IDAgaS5lLiB2b2lkLCBzbyBicGZfbWFwX19idGZfdmFsdWVf
dHlwZV9pZCB3b24ndCB3b3JrIG91dCBvZiB0aGUgYm94Lg0KDQpJIGhhdmVuJ3QgbG9va2VkIGlm
IHRoYXQncyBhIGJ1ZyBhbGwgdGhlIHdheSBpbiBjbGFuZy1lbWl0dGVkIG9iamVjdCBvcg0Kc29t
ZXdoZXJlIGZ1cnRoZXIgb24uDQoNCi0tIERlbHlhbg0K
