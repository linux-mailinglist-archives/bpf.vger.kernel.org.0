Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFFC4CB373
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 01:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiCCAU5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 19:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiCCAU4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 19:20:56 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A69139CDD
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 16:20:12 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 222JMls5004979
        for <bpf@vger.kernel.org>; Wed, 2 Mar 2022 16:20:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=4PYOJKypI894TF1u8thIv9cm1CJ0PAHlH/mZN8STgRg=;
 b=HVR0C0iqpICNDVXDkGEYa/aOC/vdVazhWOfI749dHAAom15Gzn+7tT4W9DGsly3ihbAO
 NsyjWN3UFYkdlFxO+CKs8zApZdA2XumPkz60H9QvkagO+j33UE89URBIz0Vg3M3DoaOj
 RlxhQpTM1+pVNzPw+tar/y7jNsjcl3+DwLc= 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ejdmmtfm7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 16:20:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+CL05S1YzXl7hCDnF9eXg9e+F+vt9Q2tnHkILqDnyqDYjuxdvZm2DC5buKLfK8avGAYufPuifHTXTvvooJAYuFK6ugYa1g5hTP3avAuGCLMjMcRQu4X0M49R9HBJMjZQ5wI71t3N0ARK544+zSd1pJkDEC1smBetMbJBU6g90gfcPYD3WpqxcQOu3CmTZZ1WN6V9eiz3lUtsT06d10lOhveaoifgNcrdAJAHiZG3nU69Stb+nEddFRZ4+W1Pr7MOzDeoCqJ849lGzG31e0PmL3BdtuEGkog5nTHRX4/qzENIURhnRbffaswH491VJxZ+RcvYHk9xxrKfFX0VDniPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PYOJKypI894TF1u8thIv9cm1CJ0PAHlH/mZN8STgRg=;
 b=ivxv3YLFb26AAg2gZUTmM+BXJZ722diIHLN+ehTq2Yo/knr90jxfQVQ9tDa5ZuOBfqdgmEV2nxQXh8TTqIYt4cet6sm607LkYseiQcDgkT/UDAXcfxv6Wtv9e1zt250bKzbGeeRal7uo0e+1LD4QzNV1/eN6qRrVBqFEy4/dT+CkMcnchjs7s/W4XuV2D/6chJ9pVAsYT/a+I3WLGcbu0nbcuApfSdGYMXiRBVLbYEQptUhOTKRW6UfhI+Xn/H6BjDfiBvlYMyOGlE5jngFMllgQIsGIQohdxGh4MoP2nSpf0TylrDBLX2sspr9MZGwZ4/PofKj52pYwJxemwckfPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 3 Mar
 2022 00:20:10 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%5]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 00:20:10 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 3/4] libbpf: add subskeleton scaffolding
Thread-Topic: [PATCH bpf-next 3/4] libbpf: add subskeleton scaffolding
Thread-Index: AQHYLeAK9g0hdIS9FkG6uKp/LdoqtaysoVSAgAAqZ4A=
Date:   Thu, 3 Mar 2022 00:20:10 +0000
Message-ID: <06118a1998138424c0aace9cb94d67b31b720a0d.camel@fb.com>
References: <cover.1646188795.git.delyank@fb.com>
         <13cba9e1c39e999e7bfb14f1f986b76d13e150b3.1646188795.git.delyank@fb.com>
         <364c8325-ea90-f8f6-d95b-09c9b0b4589e@iogearbox.net>
In-Reply-To: <364c8325-ea90-f8f6-d95b-09c9b0b4589e@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2b7ef94-a104-43da-b0d5-08d9fcab93ff
x-ms-traffictypediagnostic: BYAPR15MB2999:EE_
x-microsoft-antispam-prvs: <BYAPR15MB2999012E5AEC6DBADC9B89C4C1049@BYAPR15MB2999.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R/vmX2g1CzYp+xrsUep2A2mpQavOs/Iaw5M7zWvKiRfm4HhNTtAHMUgLbGfrWGnDlxz/9sLxjRVEO0QV+pQFELnyX/wZLOQAjO88AVki90EvtV3F7NnomhC3gnfjQiEPswFwam19h3fIQozWm5XtSw703PY+t9t68iE4I/R1JDC8CQafY6uDRq+Q7jzqekpjbugV/V10Z0PT+cbK2a4Jhb29/HV+zqnWnJ8lYAqfAqbrYrTqvKEPJLPy5LY9jiLvxH1Gzi6of/A+dlIVzI4d/gpMyxL4rJo7QYAiHZE4oR52Ac/AkUBieKPUHcVg/kghwDJs2UkTLCI72I/0yGZNrhh2J0EGknsE2+aD1ahAkSc9zONcZYTFvyefmBkIQGvbo80PRyDqSemo1B07halYpnSSJA8yRPdL6nahn/tchxBYRLSEivTncvnMdoEKfQ1rC6P9HbjovN/g7xYMIBlqRb62W8TfSGjU4wIr2lwgpvXF0mRC7iwPs9hJFAX8lgXjFaUvg9SQVMqBtfAKvp5rKHTv/mrCUukHSJ/bttxye/btmoJiH6H5H33gKMRbHVEffDdyUldbhJfk50rKTlpTNvKosPwQjWws1q17mrCdrOPDdW61VIgq7jG3Z9FEYnFco06XDKFYIJeRFO9E/MrajTJ8A3AJdPGo1Ogyd53weyTHs9O6bm9670Qdy0May+NLyM5puNnHRKQe8m6QjQwICA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(186003)(6506007)(8676002)(86362001)(91956017)(64756008)(66476007)(66556008)(66946007)(76116006)(66446008)(8936002)(122000001)(316002)(2906002)(110136005)(38070700005)(38100700002)(6486002)(36756003)(6512007)(2616005)(508600001)(71200400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WS9KZ3luRWVxRkQwNHVEcGNJVjZsQU1DSHptS3FEOWl6VGFpb016TjdFYmkz?=
 =?utf-8?B?WTlqU0YxdHdnQnB4bitpeXFjNnh3OFh3Vk8ya3V3aWo2bXdxZWdBdUl4MGJl?=
 =?utf-8?B?N1Q4WFBQTmlTN1RMcDNDekJxZ3U1ZThiMDZOcHhaVkZiMkJ1MGJNQzN5WG8x?=
 =?utf-8?B?ejQ2ZmJQMVBxTC8wRTFMWWNDNUo5cmFGakVlMXhxRTJLZmMreWI4R2RVUTd4?=
 =?utf-8?B?eTBUYkhGMFIyK3ZPc0RDZlV3Ym1WbGNPaVdkcUMySWdaR0JrWVJrU1gvOE1V?=
 =?utf-8?B?Ry9FaS9rMmUyTWdPNGlyN2h6d2xxUDFiejNsY29wK2lmWk5mT2RXTUtXTVE1?=
 =?utf-8?B?VTI1MjczWjltVC9NR3RjVlZzTkF0dTZhbHNLcE9tVmxicm4zZlE0RERzQXZK?=
 =?utf-8?B?NG1lOFVLVVkzZWtHRUlnb1dwYy9Fc0VmVkU1Q24yZWZhb28vbjFtM2ZsYVJU?=
 =?utf-8?B?ekZiQWlMWnpQY0Z5TElib0FMeEpIaXpLMjVSaEVVbFo1YXdmR3FNZTA4cVhD?=
 =?utf-8?B?STVlSHVIV3UvanJSMnZrdnJOdHpTS285Z0pveGRnd1h6dzlNUXpmeHhzbERB?=
 =?utf-8?B?RFdmZTZKb2VNSkpyRjlaTHVZWHVvb2txNGM5TFUyclJEdWQzOVFLNDVjaVNo?=
 =?utf-8?B?SGZXQllIcXA0d2xzaVpaZXFsT3pNYXlDSlozQ3VzY0lpQTVQM3Z1Z2tSV0Zi?=
 =?utf-8?B?MkZvZDBXZnNjU3d4N1puWDJ0VVJ5SnNNeWRKa3AyaUkvTUoyZ0U4NHhISGdi?=
 =?utf-8?B?VE53UUdmak5lRGFDeEh4T2psbmU1dlRvdnU0Ti9EbUs2dnBqWldqWENhRXcx?=
 =?utf-8?B?Z0hVQ1RDWm5wbGNQSCtlTWh6K3dHSFc1alVXK3ZGc21nUThFUnJNdGV4YnlZ?=
 =?utf-8?B?YUZUZU02T3VOTDY5UkcyZ1RLUldIcHNUVy83Nys1bmRaNlpGeDQzL3JuUDVs?=
 =?utf-8?B?YXpPUU5IMkkvNnJYTzU5TnZDVFFVMXYwOG5wZVZGUFVNRGJhOEhVU3dWbXJN?=
 =?utf-8?B?ZGRBY3JIdHhnL1VTeWlMVUxqRmxJTzFjTjNhRm5IYXpzY1dsTUlqSG9BYjlB?=
 =?utf-8?B?QTV2OWIrV1B2Y0s3bEIvKzA4dWVSRUFiakpmTTNlREo2WWxFVHZTTUhUYnRP?=
 =?utf-8?B?V2pwcFBManFidlNkNnBJYUF0ejFESU5KVTdsZ1pFWURCMngzN3BxQmRhYjVT?=
 =?utf-8?B?cFZsQk1sQzdGTnFOVEcyN1pDTUJCNW0rUHlmT3UxYXdnaDRvSEt6ODlwQTls?=
 =?utf-8?B?YWl1RDdtMU8rTHFSN3Qvd1FhVXdSMS9vei8wMXlFWmNmNWQ0QmRNRXFsUXhI?=
 =?utf-8?B?R3F4YU02THI3aWpaMzBWMEtDeWh0cnVLdE1CUmE1QzJFeHBRbmpCd3ZiWG1G?=
 =?utf-8?B?Vm45bmRxNCtRQzJTS0NPdWcvRnpYVmZFNU9oVU1DNmM4VHB3dkZqdXZPSjRB?=
 =?utf-8?B?WnkwUXNtT1dVQzJJNi9sbGlVWFgwMDV4RGxOQnpOeVFYdHpjb1RzRE94bWEy?=
 =?utf-8?B?c09PVEt2QmlCaldqTUo4T0ZON3paVGZQRVFmcDdYeWZLdmlsOUdFRDRDWGcz?=
 =?utf-8?B?dVdHck5OaG92RGZZci9IK2RRcVlFckNVaVU4Mk03T1J2QlBnU0ovTW9KQjZQ?=
 =?utf-8?B?Q3VkeVVJQ3NjUEVYOEpFREhMY3J0cVg1cmhGckRyRHhmTmhGaFZsMVpWaS9T?=
 =?utf-8?B?WmdLNU5vQkNBT2lvY1N2NXEwWWM2N1NuclArS3NnT21lR291K3E1OEQ1QVdO?=
 =?utf-8?B?RE83Z0ZhNFVVbTFDeE4rNzd1bVJOT2k1eEtWYnk1WTBzRWVOYnlUSUpJY0VY?=
 =?utf-8?B?WWRjaFYrRlVRaFJTdUE1ajhKZWRSc1RoMXFLNHduTm5BNC9zQ0JDcnJUT1pn?=
 =?utf-8?B?QkVTQzlieDRISHNmQVJQaENGY3ZHVHNCaWMwRzNPVjNTcndGSmlVUVpvZ24w?=
 =?utf-8?B?dkhCb1p0N2NsWlVkRkxQNVYwVmhzUzB2UkxPWUE2V2ZiUkFjSlJwMDdiWVZG?=
 =?utf-8?B?M0E0TmkzSU9YMCtpc1RSSGpERVFrNmxJdlJEa1EzZTFPT0M4RVZNZXMybFVi?=
 =?utf-8?B?RTcrOEJJK0RaL2pWWDV3c1IwRDEwQzB3SW1tWUp4Rm5XT1JnUnB1WkNBd2xx?=
 =?utf-8?B?ZmRzR2NLS1ZKbkwrMkltNzc1RGxpT1ZGV1lDWW0rZFo3dXpZellhMDRVOEZw?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C266C2F053C24945B817C77C25F4C7F5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b7ef94-a104-43da-b0d5-08d9fcab93ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 00:20:10.1625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1gwFvIm15zSmRYviwDKrBKg13qLCjslDe+eCpxaaSnIVrI1fOVz7ZB893J8K3cEV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2999
X-Proofpoint-GUID: e6srIFysI8u6Q-FjeUIdc6vXxSDB_ja6
X-Proofpoint-ORIG-GUID: e6srIFysI8u6Q-FjeUIdc6vXxSDB_ja6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0
 bulkscore=0 phishscore=0 mlxlogscore=720 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2203030000
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

T24gV2VkLCAyMDIyLTAzLTAyIGF0IDIyOjQzICswMTAwLCBEYW5pZWwgQm9ya21hbm4gd3JvdGU6
DQo+IA0KPiBUcmlnZ2VycyBDSSBmYWlsdXJlIHdpdGg6DQo+IA0KPiAgPiBidWlsZF9rZXJuZWwg
LSBCdWlsZGluZyBrZXJuZWwNCj4gDQo+ICAgIGxpYmJwZi5jOiBJbiBmdW5jdGlvbiDigJhicGZf
b2JqZWN0X19vcGVuX3N1YnNrZWxldG9u4oCZOg0KPiAgICBsaWJicGYuYzoxMTc3OToyNzogZXJy
b3I6IOKAmGnigJkgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFst
V2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdDQo+ICAgIDExNzc5IHwgICAgICBzeW0tPnNlY3Rp
b24sIHMtPnN5bXNbaV0ubmFtZSk7DQo+ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgICBeDQo+ICAgIGNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzDQo+
ICAgIG1ha2VbNV06ICoqKiBbL3RtcC9ydW5uZXIvd29yay9icGYvYnBmL3Rvb2xzL2J1aWxkL01h
a2VmaWxlLmJ1aWxkOjk2OiAvdG1wL3J1bm5lci93b3JrL2JwZi9icGYvdG9vbHMvYnBmL3Jlc29s
dmVfYnRmaWRzL2xpYmJwZi9zdGF0aWNvYmpzL2xpYmJwZi5vXSBFcnJvciAxDQo+ICAgIG1ha2Vb
NF06ICoqKiBbTWFrZWZpbGU6MTU3OiAvdG1wL3J1bm5lci93b3JrL2JwZi9icGYvdG9vbHMvYnBm
L3Jlc29sdmVfYnRmaWRzL2xpYmJwZi9zdGF0aWNvYmpzL2xpYmJwZi1pbi5vXSBFcnJvciAyDQo+
ICAgIG1ha2VbM106ICoqKiBbTWFrZWZpbGU6NTU6IC90bXAvcnVubmVyL3dvcmsvYnBmL2JwZi90
b29scy9icGYvcmVzb2x2ZV9idGZpZHMvL2xpYmJwZi9saWJicGYuYV0gRXJyb3IgMg0KPiAgICBt
YWtlWzNdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLg0KPiAgICBtYWtlWzJd
OiAqKiogW01ha2VmaWxlOjcyOiBicGYvcmVzb2x2ZV9idGZpZHNdIEVycm9yIDINCj4gICAgbWFr
ZVsxXTogKioqIFtNYWtlZmlsZToxMzM0OiB0b29scy9icGYvcmVzb2x2ZV9idGZpZHNdIEVycm9y
IDINCj4gICAgbWFrZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4NCj4g
ICAgbWFrZTogKioqIFtNYWtlZmlsZTozNTA6IF9fYnVpbGRfb25lX2J5X29uZV0gRXJyb3IgMg0K
PiAgICBFcnJvcjogUHJvY2VzcyBjb21wbGV0ZWQgd2l0aCBleGl0IGNvZGUgMi4NCj4gDQo+IFRo
YW5rcywNCj4gRGFuaWVsDQoNCkFyZ2gsIHNvcnJ5IGFib3V0IHRoYXQsIHNlbmRpbmcgcmVyb2xs
IGluIGEgZmV3Lg0K
