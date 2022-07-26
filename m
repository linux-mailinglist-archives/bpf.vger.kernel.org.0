Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1ED581C5C
	for <lists+bpf@lfdr.de>; Wed, 27 Jul 2022 01:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiGZXOr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 19:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiGZXOq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 19:14:46 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8EA15FCC
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 16:14:45 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QNDI4n031351
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 16:14:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5RV3BRcBxZJELN39JSN41i2fnpCc+j8IeGiRNEj4ufc=;
 b=QdB28sP5Io3QZMGG59gUMgGa6/tLipvSapsmoVpDo1lTp8jHrTbQ53z6Jl37AWeMvXVw
 yXQdyjTURMgMESqD43LRE32VVQCKfZ0OT4F0M6TBwo5jQH39ltHApfVE7xZgxPns7YiB
 FvUaBmzT59l+T+OMl4Cs4OltcTWToxKavaQ= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hgett44v9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 16:14:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWLRlQrMw//2tRNrbOtHld07SkJQt8BW2edhoWWWR3qbdQ+ZOkW1ilL2nOpOnAvdL/dLK8m4ursswjgyUgNNFutR2Po2N1BON/JHNG/Ow++P4dLPsi21/kh2HeIz/bzZVJWvQJbwvZlNCQqna8PsfHBXuQscSlGNfwVVDlhAdkgUVX+FbMA5rrH3dmTGg5TIMooWYsnWXzb8tCkig2x7vQDy06TsGpWoyxT3jHBvEfkh9KFOsWMFswZhvvS3T4kj5dW4pcTiJKNH9MDZ2+MS2ZzDnyv+sps+8xGRbTkdFEOuw4oVUNY0lw3v94TjiEivV668XLjMg3eEo2sdndSsdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RV3BRcBxZJELN39JSN41i2fnpCc+j8IeGiRNEj4ufc=;
 b=Lecb4GGsTqOP7SmNpANNSEdVRvEmOxBtkmi8NaOSnbelQ1Xr+w2kA0931V6NAWp1MCqhqmbbB0uQpayB2BVElEQqFhr1qXfkKeMvh1N2sZ1Ns5/J8miM2VpaIeo+IKqwhR+3Un1n5HxclbOEiygEh0e9jO4fVmrquSNdIcvfnYo3DiJvQJ8DLjWtrabeEk01MbX+iHBa9L4MLN0JIi/m7tq2txFKGkl5MSp6fAP/uYg5P57PN5GI9iumopHy5PnN7X378RWodLQR9O6QZ3gswwLOJDp/cPKhyhOuJRTzIA2YuOav6L2bLVFtiI3pPt1Ncy4I6Spa2kn/wL5r+WhP0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from PH0PR15MB5262.namprd15.prod.outlook.com (2603:10b6:510:14d::6)
 by CH2PR15MB3559.namprd15.prod.outlook.com (2603:10b6:610:9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Tue, 26 Jul
 2022 23:14:41 +0000
Received: from PH0PR15MB5262.namprd15.prod.outlook.com
 ([fe80::487c:66da:ff78:a6fe]) by PH0PR15MB5262.namprd15.prod.outlook.com
 ([fe80::487c:66da:ff78:a6fe%6]) with mapi id 15.20.5458.020; Tue, 26 Jul 2022
 23:14:40 +0000
From:   Mykola Lysenko <mykolal@fb.com>
To:     =?utf-8?B?RGFuaWVsIE3DvGxsZXI=?= <deso@posteo.net>
CC:     Mykola Lysenko <mykolal@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 0/3] Maintain selftest configuration in-tree
Thread-Topic: [PATCH bpf-next v2 0/3] Maintain selftest configuration in-tree
Thread-Index: AQHYoSvnKzjxzKp5x0WOtpQgJ5A/v62RRc+AgAACzwA=
Date:   Tue, 26 Jul 2022 23:14:40 +0000
Message-ID: <518BDA5D-DA78-4BD0-8C96-536ADCCC37AA@fb.com>
References: <20220726201126.2486635-1-deso@posteo.net>
 <42352041-E158-4440-AF7A-E07CA1E932BD@fb.com>
In-Reply-To: <42352041-E158-4440-AF7A-E07CA1E932BD@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3740a5a3-a2d3-4af9-a92b-08da6f5c9e2e
x-ms-traffictypediagnostic: CH2PR15MB3559:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5h1MuxIDOmRe5WOLUu5NDa25R24+3vzrckX8s9MOlietMTjuBoXu8FkbLCYVPYchmUD+BY/HVFWdmedsXhexF0la2Gv/nXwl+oKjnE5JVokwXBspUilR2hnGwWEc6C5rvgetbY9yYFtir3SD0URVEjtUllaZwr22/xpH9HSOZKN2RQAgtHzLJOvmb8/vS5Yztb0sy0bHKI4nrsl69jjX2Fel3mdo0v4yBBfYmJYPVzhmzvnjjAWsuXMdRNLWwPP4Dr8Ql3KYGLIZwXteossuWk6ZqQNTzAJvx4eeWQRGBXT+p8lvnXBXxwS4+aGRexNNdxAr1opX0OC+WhIljbGPGLbcks7IWDOqjqOGggEHEXnjN06OVFvpNPveltiUP48XOXxHfyP7KL2XnwzDCfOuDlDgCxyFvCegMwwgNmj2mIbnT27JUETaphB+4JLfPe8DVikhzIP79kcTUuBOgD0F9E25RoCiBBKBXC/Yu+U2CdQiqdnlAcpHYXZ/F5c50KywAskQW46hVa9UfOkwB9vthjbxVB7oJ4+UlbXNZp0oXT/RrRhU6q/gSnxrGDdRq4N5KFk8aSr3tOw7UWfGvUCCjehTnbrMoW5XV6BVSHVgvucVMnNMEwcBmLYGpjuis+VErvKrq7DYRaX5IiiLP2lrv7eXWhN3yXbpBFVyeCjztPfYCIQEW+Nu3FxmMH3hr1JCMVKE6FQw2T1Vggg8Ajk7TtOVal73HIW3vU+3AZ47Sv3SdCzjlwa5yt6eYzLtgykjj00j0+KLh+q2GCktwqL/hkdLK2UfpSwziNxoERRrdOnLyvWdETRz1mADb7ic7uBIhVNi2ar24DAc/hXvQ4gMqNJjjbLICMpGuxFuNpwVC3o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5262.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(6512007)(966005)(6506007)(478600001)(316002)(8936002)(33656002)(2616005)(186003)(66574015)(6486002)(5660300002)(53546011)(41300700001)(71200400001)(86362001)(83380400001)(122000001)(38100700002)(2906002)(8676002)(4326008)(66446008)(76116006)(66556008)(6916009)(64756008)(38070700005)(66476007)(54906003)(66946007)(91956017)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzA1S3NsVk95RVRCYlRmN2JHUFdYaEU5enRWL1p4TzczcUNLUmZsb2N0dXJt?=
 =?utf-8?B?dXRkekwxS21wclNMMURqNGkzTEpOVkV3VlJ2Ly9ZN2RpNWxDekNOc3JWRlNM?=
 =?utf-8?B?WnJ3dTNaS2dpaWlUd0haZi9KNm1yQmVqeVVUblZzQ05SV1pDOWZVa0tsM2kx?=
 =?utf-8?B?ZWxHNEJZeWZyWVdJMGhxVGswTCtrajRnMG9HOUd2NjB5bXI1SmsrS2I3SFBM?=
 =?utf-8?B?V2ZuSk8zZU1wVHkwaGZqSmZaem9ZbitpcGVQbkRwQVN4Z1JQellyNFk0emZJ?=
 =?utf-8?B?VzhoeU1UckZjNGkzb0FtUFV3a2hNU2ZXL2Z0cTEyWmRlQTV1eXZFekZuQmtC?=
 =?utf-8?B?Y08rNlVhNXlRZUYyWml2Q2ZJdXk0b21zbXE3T3ArYlZKMEQralVnbUUzY2g5?=
 =?utf-8?B?V2t3RGI4dXZxYzU5Ykpuc2cyYVJ3TFFiWlNnY1dvUUdXQVdCZFJzOEZKekZE?=
 =?utf-8?B?LzF1UkVjekdaNGFKaWZBVXVhdDNqNXczbnFjS0dqU2RoWm9YbXovempiYUk3?=
 =?utf-8?B?aFRZY1N2d0hDNUNUUnlKV1JDSExZQnl2TkFXTmp3YXJNUWpZdHo5aklrV3Rr?=
 =?utf-8?B?YjIweFVQK1poOXVXZWVEU2xueTdCU3JlRkpkRGo0YWgxWktmTm1zazFWaHRi?=
 =?utf-8?B?WTZ6RGVYVlJGMzVuK2gwT2FKUGlVMjhJMFVKNFlWMjhkMVdoL0F5M1hJTHJ2?=
 =?utf-8?B?VGd2WWdYVDd0Z2FZUk8xQkxCQmJudnJDUnd4Qm14Y1BVVjdjUUZhRTJZUXI1?=
 =?utf-8?B?WFlsSWc0MW00TWZiN2p4b1B6RnRxclNCZ2x0UTcrb09ERnBtOFNza295bkZC?=
 =?utf-8?B?ZWpob1lJUGRFZ3VNekNGNHRiODlSYXFPVHk4SldyWWVhekwxcUxtOFVRejdn?=
 =?utf-8?B?cUxaUTMrdHQ3T3k1bVlkbU0vMUw0TkJDUUpwQVhoanBHTEVsUlBvYzNSOVkw?=
 =?utf-8?B?VDhENldlNWl2UzdiU1BXU2FaNmtUalZLOWJwWkRjS2hqcHA4QStIUUVIWEhF?=
 =?utf-8?B?RlVMaXNRZ21OL2l4bWU4VS92TUZmeTV5SkREN3g2alBvZUE2SlFRcVV0Z2Z0?=
 =?utf-8?B?RFZLeEZoeXBNakZ0b1BXejN5V0swSGd4VnU3dTNRSElLejlnK3VCMWRFVWVM?=
 =?utf-8?B?QTljTU5nekZQdjNNaFg3UEZuVmc4QlNjR2M0Yk5NWjhaRWdKY3JjU255VW0v?=
 =?utf-8?B?UWpYMkVOVFRmOU5QN2hvdWkydUMwVUZmd3J1VmhIa2FJbEVVeXFUeW1QdERD?=
 =?utf-8?B?UUt6TmhNRFN4TTlJMzV2Z0szUkZJU3VLKzh3UUM4QUtOaEJEMHJtUnNkb1hW?=
 =?utf-8?B?U0EwbUpWNk1FRHRkQWVLK003TE9RUWZ3R1p2RS9UbC81YjRZbUVmTVpNZkVQ?=
 =?utf-8?B?RHh2M0RQN1d0elQ2S2FZMHdQUXQvaFhFMFo5ZTNodlZhWGdETUVic0I4UHBu?=
 =?utf-8?B?Z1Z0NWpCc1BvSDBGWHJyKy9qSlg0ZEhBOFNXZEpxS3ExVTcrVGk1d21jY2ta?=
 =?utf-8?B?K2E0aWRGT2M3UDk3eU1pakI1MitVWWREUGswTTZlZGdpVk9NRU5wQ0J3RVNE?=
 =?utf-8?B?ZWQ1SldBMFBxSnZRZDVaeUhXKzJGR3NVVENERUFBRWNnRld6QmdIUmtJZzRt?=
 =?utf-8?B?dkJLU3NYNGYrRFZvQ0hXNG8ySVJ4L0c0OEk0UWhCZVdqNDROUXdYTzNiUXAy?=
 =?utf-8?B?Rld0Q0h4c1dQa2xrcnAzL3hvdUx5cmdmMDNMYjRQem1RQnFHemZsNFNUTGhq?=
 =?utf-8?B?VW9mMkdQTzZsMkFBdWNzb2RjYmV2d3k2aVFmVGxrMUlqZmFDVFg4RjhnZW93?=
 =?utf-8?B?Y0NOZExQTjFjSW9nYTdTSEFtN2lQanp1RUd2Q3JRenpwQ2VZMG1GYmV6bGRu?=
 =?utf-8?B?OWRaWkQ4OVdVVTJIQmRzZjBLd1lDeDdGelNpSDZrZGxGeEZKcGFMVmdvV3RW?=
 =?utf-8?B?WW4zOHpHK3RhbW81SklYSVRHVWNRTTllaEF2cVZYSGVJb3BOdFRjc1pweTU0?=
 =?utf-8?B?Q2JDRUZNcC9kbXJDL0tFMTBTQnRhQXUzK3RMZEFMNmloMERoS0RIWFNIK2Ew?=
 =?utf-8?B?cmxNNWV2bHYzY1ROamdLQ29HODNsSCtkOWl2S05SK2RIaHBqWk45ci85R0Ni?=
 =?utf-8?B?TFVZMDdPWWFiM25rc0xMOGJ1eEtUTWEwNm9PQ1ZodnhPY2lKYmtxNEVyL1cv?=
 =?utf-8?Q?eI0ZR5BAEECdGIQ/my32nnChk2LHMXd0bBbtk7Qz/J3m?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5005EFBD19B8D94A82E3C5F1EDF469AB@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5262.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3740a5a3-a2d3-4af9-a92b-08da6f5c9e2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 23:14:40.7566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ITfbYDu7oyWnc9QP8UORzQv6SgGB78OXWRUxtutfxJtMRY4nvrb9C0exQXHzofZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3559
X-Proofpoint-ORIG-GUID: UJCDh4trDWQ7oAUyA-ecQZuOGhk7Lypm
X-Proofpoint-GUID: UJCDh4trDWQ7oAUyA-ecQZuOGhk7Lypm
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SGV5IERhbmllbCwNCg0KV2hpbGUgZWFjaCBwYXRjaCBpbiBzZXJpZXMgc2hvd3MgdjMsIHRoZSBj
b3ZlciBsYXR0ZXIgc3ViamVjdCBzdGlsbCBzaG93cyB2MiwgYWx0aG91Z2ggZGVzY3JpcHRpb24g
c2hvd3MgdjIgLT4gdjMgY2hhbmdlcy4gVGhpcyBhbHNvIGV4cGxhaW5zIHdoeSBDSSBzaG93ZWQg
djIgdmVyc2lvbiBpbiBQUi4gU29tZXRoaW5nIHRvIGNoZWNrIGluIHlvdXIgc2V0dXAuDQoNClJl
Z2FyZHMsDQpNeWtvbGENCg0KPiBPbiBKdWwgMjYsIDIwMjIsIGF0IDQ6MDQgUE0sIE15a29sYSBM
eXNlbmtvIDxteWtvbGFsQGZiLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+PiBPbiBKdWwgMjYs
IDIwMjIsIGF0IDE6MTEgUE0sIERhbmllbCBNw7xsbGVyIDxkZXNvQHBvc3Rlby5uZXQ+IHdyb3Rl
Og0KPj4gDQo+PiBCUEYgc2VsZnRlc3RzIG1hbmRhdGUgY2VydGFpbiBrZXJuZWwgY29uZmlndXJh
dGlvbiBvcHRpb25zIHRvIGJlIHByZXNlbnQgaW4NCj4+IG9yZGVyIHRvIHBhc3MuIEN1cnJlbnRs
eSB0aGUgInJlZmVyZW5jZSIgY29uZmlnIGZpbGVzIGNvbnRhaW5pbmcgdGhlc2Ugb3B0aW9ucw0K
Pj4gYXJlIGhvc3RlZCBpbiBhIHNlcGFyYXRlIHJlcG9zaXRvcnkgWzBdLiBGcm9tIHRoZXJlIHRo
ZXkgYXJlIHBpY2tlZCB1cCBieSB0aGUNCj4+IEJQRiBjb250aW51b3VzIGludGVncmF0aW9uIHN5
c3RlbSBhcyB3ZWxsIGFzIHRoZSBpbi10cmVlIHZtdGVzdC5zaCBoZWxwZXINCj4+IHNjcmlwdCwg
d2hpY2ggYWxsb3dzIGZvciBydW5uaW5nIHRlc3RzIGluIGEgVk0tYmFzZWQgc2V0dXAgbG9jYWxs
eS4NCj4+IA0KPj4gQnV0IGl0IGdldHMgd29yc2UsIGFzICJCUEYgQ0kiIGlzIHJlYWxseSB0d28g
Q0kgc3lzdGVtczogb25lIGZvciBsaWJicGYNCj4+IChtZW50aW9uZWQgYWJvdmUpIGFuZCBvbmUg
Zm9yIHRoZSBicGYtbmV4dCBrZXJuZWwgcmVwb3NpdG9yeSAob3IgbW9yZSBwcmVjaXNlbHk6DQo+
PiBmYW1pbHkgb2YgcmVwb3NpdG9yaWVzLCBhcyBicGYtcmMgaXMgdXNpbmcgdGhlIHN5c3RlbSku
IEFzIHN1Y2gsIHdlIGhhdmUgYW4NCj4+IGFkZGl0aW9uYWwgLS0gYW5kIHNsaWdodGx5IGRpdmVy
Z2VudCAtLSBjb3B5IG9mIHRoZXNlIGNvbmZpZ3VyYXRpb25zLg0KPj4gDQo+PiBUaGlzIHBhdGNo
IHNldCBwcm9wb3NlcyB0aGUgbWVyZ2luZyBvZiBzYWlkIGNvbmZpZ3VyYXRpb25zIGludG8gdGhp
cyByZXBvc2l0b3J5Lg0KPj4gRG9pbmcgc28gcHJvdmlkZXMgc2V2ZXJhbCBiZW5lZml0czoNCj4+
IDEpIHRoZSB2bXRlc3Quc2ggc2NyaXB0IGlzIG5vdyBzZWxmLWNvbnRhaW5lZCwgbm8gbG9uZ2Vy
IHJlcXVpcmluZyB0byBwdWxsDQo+PiAgY29uZmlndXJhdGlvbnMgb3ZlciB0aGUgbmV0d29yaw0K
Pj4gMikgd2UgY2FuIGhhdmUgYSBzaW5nbGUgY29weSBvZiB0aGVzZSBjb25maWd1cmF0aW9ucywg
ZWxpbWluYXRpbmcgdGhlDQo+PiAgbWFpbnRlbmFuY2UgYnVyZGVuIG9mIGtlZXBpbmcgdHdvIHZl
cnNpb25zIGluLXN5bmMNCj4+IDMpIHRoZSBrZXJuZWwgdHJlZSBpcyB0aGUgcGxhY2Ugd2hlcmUg
bW9zdCBkZXZlbG9wbWVudCBoYXBwZW5zLCBzbyBpdCBpcyB0aGUNCj4+ICBtb3N0IG5hdHVyYWwg
dG8gYWRqdXN0IGNvbmZpZ3VyYXRpb25zIGFzIGNoYW5nZXMgYXJlIHByb3Bvc2VkIHRoZXJlLCBh
cw0KPj4gIG9wcG9zZWQgdG8gb3V0LW9mLXRyZWUsIHdoZXJlIHRoZXkgd291bGQgYWx3YXlzIHJl
bWFpbiBhbiBhZnRlcnRob3VnaHQNCj4+IA0KPj4gVGhlIHBhdGNoIHNldCBpcyBzdHJ1Y3R1cmVk
IGluIHN1Y2ggYSB3YXkgdGhhdCB3ZSBmaXJzdCBpbnRlZ3JhdGUgdGhlIGV4dGVybmFsDQo+PiBj
b25maWd1cmF0aW9uIFswXSBhbmQgdGhlbiBhZGp1c3QgdGhlIHZtdGVzdC5zaCBzY3JpcHQgdG8g
cGljayB1cCB0aGUgbG9jYWwNCj4+IGNvbmZpZ3VyYXRpb24gaW5zdGVhZCBvZiByZWFjaGluZyBv
dXQgdG8gR2l0SHViLg0KPj4gDQo+PiBbMF0gaHR0cHM6Ly9naXRodWIuY29tL2xpYmJwZi9saWJi
cGYvdHJlZS8yMGYwMzMwMjM1MGE0MTQzODI1Y2VkY2JkMjEwYzRkNzExMmMxODk4L3RyYXZpcy1j
aS92bXRlc3QvY29uZmlncw0KPj4gDQo+PiAtLS0NCj4+IENoYW5nZWxvZzoNCj4+IHYyIC0+IHYz
Og0KPj4gLSByZW1vdmVkIHNldmVuIG1vcmUgb3B0aW9ucyBmcm9tIHMzOTB4IGNvbmZpZ3VyYXRp
b24gdGhhdCBvdmVybGFwcGVkIHdpdGgNCj4+IHByZS1leGlzdGluZyBjb25maWcNCj4+IHYxIC0+
IHYyOg0KPj4gLSBtaW5pbWl6ZWQgaW1wb3J0ZWQga2VybmVsIGNvbmZpZ3MgYW5kIG1hZGUgdGhl
bSBidWlsZCBvbiB0b3Agb2YgZXhpc3RpbmcNCj4+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Jw
Zi9jb25maWcNCj4+IC0gbW92ZWQgdGhlbSBkaXJlY3RseSBpbnRvIHRvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2JwZi8NCj4+IC0gc29ydGVkIGFuZCBjbGVhbmVkIHVwIHRvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2JwZi9jb25maWcNCj4+IC0gcmVtb3ZlZCAic2VsZnRlc3RzL2JwZjogSW50ZWdyYXRl
IHZtdGVzdCBjb25maWdzIiBmcm9tIHBhdGNoIHNldA0KPj4gLSByZW1vdmVkIDQuOSAmIDUuNSBj
b25maWdzDQo+PiANCj4+IERhbmllbCBNw7xsbGVyICgzKToNCj4+IHNlbGZ0ZXN0cy9icGY6IFNv
cnQgY29uZmlndXJhdGlvbg0KPj4gc2VsZnRlc3RzL2JwZjogQ29weSBvdmVyIGxpYmJwZiBjb25m
aWdzDQo+PiBzZWxmdGVzdHMvYnBmOiBBZGp1c3Qgdm10ZXN0LnNoIHRvIHVzZSBsb2NhbCBrZXJu
ZWwgY29uZmlndXJhdGlvbg0KPj4gDQo+PiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvREVO
WUxJU1QgICAgICAgfCAgIDYgKw0KPj4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL0RFTllM
SVNULnMzOTB4IHwgIDY3ICsrKysrKw0KPj4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL2Nv
bmZpZyAgICAgICAgIHwgMTAxICsrKystLS0tLQ0KPj4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
YnBmL2NvbmZpZy5zMzkweCAgIHwgMTQ3ICsrKysrKysrKysrKw0KPj4gdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvYnBmL2NvbmZpZy54ODZfNjQgIHwgMjUxICsrKysrKysrKysrKysrKysrKysrKw0K
Pj4gdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3ZtdGVzdC5zaCAgICAgIHwgIDUxICsrKy0t
DQo+PiA2IGZpbGVzIGNoYW5nZWQsIDU1NCBpbnNlcnRpb25zKCspLCA2OSBkZWxldGlvbnMoLSkN
Cj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvREVOWUxJ
U1QNCj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvREVO
WUxJU1QuczM5MHgNCj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9icGYvY29uZmlnLnMzOTB4DQo+PiBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvYnBmL2NvbmZpZy54ODZfNjQNCj4+IA0KPj4gLS0gDQo+PiAyLjMwLjINCj4+IA0K
PiANCj4gQWNrZWQtYnk6IE15a29sYSBMeXNlbmtvIDxteWtvbGFsQGZiLmNvbT4NCg0K
