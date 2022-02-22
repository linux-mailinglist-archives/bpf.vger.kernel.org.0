Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A784C02B1
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 21:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiBVUBD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 15:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbiBVUAc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 15:00:32 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75523EAC7D
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 12:00:06 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21MJd4eT010758
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 12:00:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=/4AC6fjghqW65k1fc/4i8OfNr6A/CEj8TDUel3ETsKE=;
 b=OLQ8K7ZICkAAdweYumTsZoTcRKxlHSbqzdvspzg8E/dsnyJCve5ijlfCmVW0f6MxjEH+
 kAiEK9tt1XwGaNbH9S8KlIfp6g57ZqFV859JNPs0di4jy2pR2QpdVG/IQk92FNQEppqj
 RKDrlvU8h5yYkoFRlFp2rQnVRpPKEA2gLn4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ecbjy0ur8-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 12:00:05 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 12:00:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqlMCE9jUWb1vjfLm4yO+p8GCFxEmEtvpeCZWpxWsNlpSCOnwiJNSYwIZrJseexqVLofE8/E6qcoD0MpeakYIpPgZ/caKmYstNnzxdWkvxRvWLrytVbczKEc1t161IbT0GpFxPjgPV6nCVp/PFXKbywsjVUmzUktVUMtb9SeD4wy451IhNmI4EpTGQKE6RTLbYgmqkaaz8qKZdt+MAT8JJKiZkUzh1bA7gNGkpPIZa4N11LSledDv+wiyrW77Z/r0cqBRa8SlmwlTgbMNeYHOQb4OnQrlEOd7dB7pkd3Mwpgkq5dNSDg6RlryPH9gP50f0hts8VUw5S2EfI07zZwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4AC6fjghqW65k1fc/4i8OfNr6A/CEj8TDUel3ETsKE=;
 b=COFpdu3saRz/WaxUdgHbWRVi2GtsFMZCOzLhOnXP98qpUwsJSWeQaWSDy9JQNzdAlgtDQmflX3v8rAVHX5e2hHgwQT9uN1kEGIfpMjj3huGI6XXU4uP12wnSqp6uXQftAna+0GOj7isAmU78hVJ+LMCWSkegTJcaCqxmpwcMO3wmrc7uL46waCK52WkjzO5S8fjubhrIvtAyzbtXgC/ndnKNtcVlVKNY8URO/1o6X0DamxIvPS0Voa0ooaIGayGFnRJAHbhyHrE9cJe55cvTi+TS2jqpHpKU1vOyJTrDOhX2KqdgqBIfDMUmKERpgNo+rCDInvIHoFmN76bmJ7jUSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MW4PR15MB4732.namprd15.prod.outlook.com (2603:10b6:303:10d::15)
 by SA0PR15MB4014.namprd15.prod.outlook.com (2603:10b6:806:8e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 22 Feb
 2022 20:00:02 +0000
Received: from MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::79fb:4741:b90a:e871]) by MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::79fb:4741:b90a:e871%7]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 20:00:02 +0000
From:   Mykola Lysenko <mykolal@fb.com>
To:     Song Liu <song@kernel.org>
CC:     Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next] Improve BPF test stability (related to perf
 events and scheduling)
Thread-Topic: [PATCH bpf-next] Improve BPF test stability (related to perf
 events and scheduling)
Thread-Index: AQHYJSfioyDZvWe6RkC/s6CQJwCsIqyaGxaAgAXoJ4A=
Date:   Tue, 22 Feb 2022 20:00:02 +0000
Message-ID: <37AA27EB-70A6-484C-9D24-641DFA13D185@fb.com>
References: <20220219003004.1085072-1-mykolal@fb.com>
 <CAPhsuW4Rz_9bzXK-X-i2uc3aeQdCbY+b3QfRFvTN9HrraCs0ZQ@mail.gmail.com>
In-Reply-To: <CAPhsuW4Rz_9bzXK-X-i2uc3aeQdCbY+b3QfRFvTN9HrraCs0ZQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ee11e58-d454-4b91-a21e-08d9f63de99f
x-ms-traffictypediagnostic: SA0PR15MB4014:EE_
x-microsoft-antispam-prvs: <SA0PR15MB40145210FB5F8223DCA61C1FC03B9@SA0PR15MB4014.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZOTFX/Ds8s/8J8WS6stI/U7M8OCQLLxOV5EYbuiQcMvgu636BQGUDSo6lQEtcprSEF2mtrjxq/o22WR/Xsp5oR/l2mbHWcxLkme7IV946wUp0ZMRjUv4NXrmEfq9RvT1X17+02lvaO7unupuWQ/vQ7lY98+ae2mPVmhB+Im5PJ1jnG4nbou066NJtGlE5VpeCSqzW46A5UdCXoXgQlWlStquqWyarhj7nPyHBnJagqKk4XNGYkhsAcaJt0BTiO2vifetBhUCehBi0QxKiloLN898r/VhgQ0zoz3s8ifmAr56k2u2qtMezlj6l2k2gNSSH5NBmATBpxmMQpn1Qb08t92NvpPkjStskQjfkBJQtRYro/ougoS3EmcJFejbTqt96a0cAAdPkNcWqqebUMsSxTPV4vTw57HKvB2dpuL3PyH5eONW7kRKg13GyAnvIshF/vad2Q8+wKs94qvjfpda7l18jMS023lt52R7AsAx/SM4yTiSPgPY05jxhMbpkd1Bbzx1qFtlS1a8CMOlWNB39Ma5AFmMH+CkADIWEvhORldO+t/e0pgsIIrZhEWVNhbP2LZXbudknWGM7menxmQ6W0qS/2qQuaiG6ONGqkZC51ZPkA8Jqv++8HnDYn5LpOoFMOHWkrTdlww0ALACURdsEj7QJ4UHVSX30XN8aXrynTICA6H9JM6qXsndGi4R3UDYn4NcciUYlw4tw3lw2OKjufUkeQIEA7NsxEY/0sOiaSdWLldynwqNmEm3bFPXAUha
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4732.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(2906002)(66946007)(66476007)(83380400001)(64756008)(6512007)(6916009)(316002)(54906003)(76116006)(6486002)(6506007)(122000001)(508600001)(8676002)(36756003)(66556008)(2616005)(186003)(53546011)(66446008)(38100700002)(5660300002)(71200400001)(8936002)(38070700005)(4326008)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2RxbkxZWkJib3Fxd2ZYeEh4V3U2NVFUMEpST3Fmc2FodWNQMzJORk9XWWFw?=
 =?utf-8?B?dm5LcGNROUMzTmMvdjVybUxhZmZWK3FNOUIxUEJXSFhaS0plRGl2QkhESFEz?=
 =?utf-8?B?M2pHdFp4dXBUVDJpc3BGYmpLNWw3OXF3c2Ryb3BsbmJ0b2VDZTRZOGVyMjZF?=
 =?utf-8?B?aHRXZEppOUNEWE5YYmRObVlydmNxRHp6VWN3Skczb1Q0Tys4WmcrWjhxb0Qv?=
 =?utf-8?B?MnZpT2hJYlZlQm1VVVRJek9Cck1rWFc0eE1IMGF6VkgvdkRBbFdlSkQ0YlpT?=
 =?utf-8?B?Nk10M1FJZ1FMM2RpZm9xUTRHSG1xb3F1L0FQSzlqYlZob2ljUnhyZzRCMGNE?=
 =?utf-8?B?dWpvK3lyU3l5QWx3SzRCMmhjUzZSWkNlbEthOU5vVWltVlFaVE56MmZkcFky?=
 =?utf-8?B?VzFwZVRMdFF4TE1KbTR6WGlROWl6cGNpWk85ckpoVTdITjBSMzNCd1Y4bTda?=
 =?utf-8?B?d2tRdWVKUjVMc2hLRFEyVUFybi96Y2M1U3BMWmhBSlJWZGNLOWhaVEYrUDdR?=
 =?utf-8?B?T2ZoaVZ5TzFaeWZ6WVFMWlRSTjVRRWRCaGVzbnE0b3puZzBCNHh1d1Bwc0p5?=
 =?utf-8?B?M0NJdy9YYU9OV3EwWDV1bXJXNFU4MnJ5T2hmK05pY1U1QjdsQWVIR1NsWFBp?=
 =?utf-8?B?eDcraWZpZEszc1J1aVV6cytIemNPcTdNUWdkQ1BBRDluays1M1J3TC9PbzJ5?=
 =?utf-8?B?TzhFWUNLWkFya0syeXFEMTVod2pkblMzVGVNRWlLaEs0TlR5TDd5ME14ZVJw?=
 =?utf-8?B?dlZzS1ordUVMTGQyb3lXeW00ZWIybUp3Szk2dlVQaGxLTFZqbDIycWRHaDJi?=
 =?utf-8?B?cFR1M3BsQUQyeUcrb3VTellwYjZkbFR1b3hoY21nQVJ0bVhOeERnLzVobG9K?=
 =?utf-8?B?ZVQrVFZpWmEydEpVcGNoVDdWdU1kWS81S1dPTk41KzNYcVVCbitXTVMrNC9H?=
 =?utf-8?B?ZndmZy9QN3J6ak1uSW94ZVZOakJtaDJkSi9KcWRhN2wyYTFlbUROMXRVTTZr?=
 =?utf-8?B?VDJRdUxYTXdGVlNOYTVsUGR5R2RBbGpVT0tlTFp4SjExQnlEbWYwRGhtSlVV?=
 =?utf-8?B?M3ZpY1p0WE5RUGZzbGlCQXBqcU5QTFRra2ZQVzlwMHdYalkvb3NOTTR4UXd3?=
 =?utf-8?B?SzBNOHFpbWhmalhJbWdkN3lDNndjSXNKaDVrVWd0Ri94ZzhFNnBzWDh3dTNj?=
 =?utf-8?B?SG4xOC9BeFFadEhIYlRESlRjTlpJODFrOEFMd1EwRWIrby9hb1MyQ1FxTkZh?=
 =?utf-8?B?aGVlZ1ZXNnJHQzNnMnYzbHlvTi9VRWowaCs3dE1lVXJwcHJXc3RYUXJ5Q3RE?=
 =?utf-8?B?VXFCbTYwVXJGamR4TEFLL2J5NUNzOXAwbTJWclE5WmlDRFZyYVlGNWI4NUFX?=
 =?utf-8?B?MVVsS1VIcWV5MjIzOUdPNFFnamtjUEhCTUVOOXptZW5mODFxM00zdE4xN2JC?=
 =?utf-8?B?QTJ2MndmaVlUU25XbU1TeG8rU3NVcGo5M1k1ejU0TWpESXpZZzdIdWY2aDI2?=
 =?utf-8?B?N0dRUnVWOCtwMkpwcU1QL3N2cW5lUzk5K08xdFI5dmo2eXcyZ0dFRlhyQ0l1?=
 =?utf-8?B?ODMrb1dCY2ZDekxUaE5nZks4RXp0ellFTHB5bVZPK1h6MU1uQWFOeVFjYktl?=
 =?utf-8?B?VjVTZ2pTcTZFSC92bnZBM05HTFJOUVVZTTkzWDFSSVdnZU15eXNTWHJYclR0?=
 =?utf-8?B?M0ZTdDIxOXlENnE0a25RcTcrUDNMcnpkYThTSEdlVVlTZW4wMUk2NnlUQTJm?=
 =?utf-8?B?Uk9xRDRWSnp4a2NMMHR2MVJydlRrR3o0SHBpcHA3NHNuVVhuMThYUStZd2xI?=
 =?utf-8?B?M0VsS21xcXZJbVZaTkhQak9raXZRdkRiaVNuMzNaMXZBdXExSTNJOXJrcHR4?=
 =?utf-8?B?L2RRMnNaMC9yaWdxbDVHT2xPSUFpcHhNL2w0bGV3WE5pSWNvTEg4SzlDWTN6?=
 =?utf-8?B?NXFsYWRCUmZaSVNtUkJuRkd2a0N6cWhQVU1EdmNXOVk2SnF2cjFjUWxvQ2pp?=
 =?utf-8?B?ZXJQSlY2RDR0aWYrTVNNMGlqT0FVNFRsSWZsYlcyTGIxUHBxczg5N0VEb2xq?=
 =?utf-8?B?U2FBRlVqMjZVNWptdENqTmE5YmJOTE9qSUpCV2xHOXNyM3dxVHdCZXVvU3B0?=
 =?utf-8?B?Z1U4emhXbk9wZnM2eWxtWkllbkhYRWMyM21KdWdOcGlRRDFGUzluYk9jMGkz?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBE9706F2D71D1499CCC76A46BD501C5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4732.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee11e58-d454-4b91-a21e-08d9f63de99f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 20:00:02.1845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BxACTf9uBqNAKe/2wFlzKh2wM7QR5FPo5Y8WXhmDnz9R404UD/7/jBuLSCnXRIOk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4014
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: OsMRyI8iur5Hup8GowBA0liY8jf9G4T1
X-Proofpoint-ORIG-GUID: OsMRyI8iur5Hup8GowBA0liY8jf9G4T1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_07,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220123
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIFNvbmchDQoNCg0KPiBPbiBGZWIgMTgsIDIwMjIsIGF0
IDU6NDcgUE0sIFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJp
LCBGZWIgMTgsIDIwMjIgYXQgNDozMCBQTSBNeWtvbGEgTHlzZW5rbyA8bXlrb2xhbEBmYi5jb20+
IHdyb3RlOg0KPj4gDQo+PiBJbiBzZW5kX3NpZ25hbCwgcmVwbGFjZSBzbGVlcCB3aXRoIGR1bW15
IGNwdSBpbnRlbnNpdmUgY29tcHV0YXRpb24NCj4+IHRvIGluY3JlYXNlIHByb2JhYmlsaXR5IG9m
IGNoaWxkIHByb2Nlc3MgYmVpbmcgc2NoZWR1bGVkLiBBZGQgZmV3DQo+PiBtb3JlIGFzc2VydHMu
DQo+IA0KPiBIb3cgb2Z0ZW4gZG8gd2Ugc2VlIHRoZSB0ZXN0IGZhaWwgYmVjYXVzZSB0aGUgY2hp
bGQgcHJvY2VzcyBpcyBub3QNCj4gc2NoZWR1bGVkPw0KDQpJIGp1c3QgcmFuIHRoaXMgdGVzdCwg
bm9uLW1vZGlmaWVkLCAxMDAgdGltZXMgaW4gYSBsb29wIGFuZCBnb3QgOTQgZmFpbHVyZXMuIEhv
d2V2ZXIsIGl0IGlzIG9uIG15IHNldHVwIHdoZW4gdXNpbmcgcWVtdSBmb3IgdGVzdGluZy4NCg0K
PiANCj4gWy4uLl0NCj4gDQo+PiBzdGF0aWMgdm9pZCBzaWd1c3IxX2hhbmRsZXIoaW50IHNpZ251
bSkNCj4+IHsNCj4+IC0gICAgICAgc2lndXNyMV9yZWNlaXZlZCsrOw0KPj4gKyAgICAgICBzaWd1
c3IxX3JlY2VpdmVkID0gMTsNCj4+IH0NCj4+IA0KPj4gc3RhdGljIHZvaWQgdGVzdF9zZW5kX3Np
Z25hbF9jb21tb24oc3RydWN0IHBlcmZfZXZlbnRfYXR0ciAqYXR0ciwNCj4+IEBAIC00Miw3ICs0
Myw5IEBAIHN0YXRpYyB2b2lkIHRlc3Rfc2VuZF9zaWduYWxfY29tbW9uKHN0cnVjdCBwZXJmX2V2
ZW50X2F0dHIgKmF0dHIsDQo+PiAgICAgICAgICAgICAgICBpbnQgb2xkX3ByaW87DQo+PiANCj4+
ICAgICAgICAgICAgICAgIC8qIGluc3RhbGwgc2lnbmFsIGhhbmRsZXIgYW5kIG5vdGlmeSBwYXJl
bnQgKi8NCj4+ICsgICAgICAgICAgICAgICBlcnJubyA9IDA7DQo+PiAgICAgICAgICAgICAgICBz
aWduYWwoU0lHVVNSMSwgc2lndXNyMV9oYW5kbGVyKTsNCj4+ICsgICAgICAgICAgICAgICBBU1NF
UlRfT0soZXJybm8sICJzaWduYWwiKTsNCj4+IA0KPj4gICAgICAgICAgICAgICAgY2xvc2UocGlw
ZV9jMnBbMF0pOyAvKiBjbG9zZSByZWFkICovDQo+PiAgICAgICAgICAgICAgICBjbG9zZShwaXBl
X3AyY1sxXSk7IC8qIGNsb3NlIHdyaXRlICovDQo+PiBAQCAtNjMsOSArNjYsMTIgQEAgc3RhdGlj
IHZvaWQgdGVzdF9zZW5kX3NpZ25hbF9jb21tb24oc3RydWN0IHBlcmZfZXZlbnRfYXR0ciAqYXR0
ciwNCj4+ICAgICAgICAgICAgICAgIEFTU0VSVF9FUShyZWFkKHBpcGVfcDJjWzBdLCBidWYsIDEp
LCAxLCAicGlwZV9yZWFkIik7DQo+PiANCj4+ICAgICAgICAgICAgICAgIC8qIHdhaXQgYSBsaXR0
bGUgZm9yIHNpZ25hbCBoYW5kbGVyICovDQo+PiAtICAgICAgICAgICAgICAgc2xlZXAoMSk7DQo+
PiArICAgICAgICAgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCAxMDAwMDAwMDAwOyBpKyspDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICB2b2xhdGlsZV92YXJpYWJsZSsrOw0KPj4gDQo+PiAg
ICAgICAgICAgICAgICBidWZbMF0gPSBzaWd1c3IxX3JlY2VpdmVkID8gJzInIDogJzAnOw0KPiAN
Cj4gXl5eXiB0aGlzICI/IDoiIHNlZW1zIHVzZWxlc3MgYXMgd2UgYXNzZXJ0IHNpZ3VzcjFfcmVj
ZWl2ZWQgPT0gMS4gTGV0J3MgZml4IGl0Lg0KDQpJbiB0aGlzIGJyYW5jaCAodHJ1ZSBmb3IgInBp
ZCA9PSAw4oCdIGNvbmRpdGlvbiksIHdlIGV4ZWN1dGUgaW4gdGhlIGNoaWxkIHByb2Nlc3MuIEp1
c3QgYXNzZXJ0aW5nIGhlcmUgd291bGQgbm90IGZhaWwgdGhlIHRlc3QgdW5mb3J0dW5hdGVseS4g
Q2hpbGQgcHJvY2VzcyB3aWxsIGRpZSAoYWZ0ZXIgZXhpdCgwKSkgYW5kIHRlc3Qgd2lsbCBzdWNj
ZWVkLiBIb3dldmVyLCB5b3UgdGhlbiBtYXkgYXNrIHdoeSBkbyB3ZSBuZWVkIGFzc2VydCBhdCBh
bGwuIEl0IGlzIHVzZWZ1bCBpZiB3ZSB3YW50IHRvIGRlYnVnIHdoYXQgaGFwcGVucyBpbiB0aGUg
Y2hpbGQgcHJvY2Vzcy4gUmlnaHQgbm93LCBjaGlsZCBwcm9jZXNzIGRvZXMgbm90IHByaW50IGFu
eXRoaW5nIGFuZCBJIHdpbGwgZml4IGl0IGluIHRoZSBzZWNvbmQgdmVyc2lvbiBvZiB0aGlzIHBh
dGNoIGJ5IHN1YnN0aXR1dGluZyBleGl0KDApIHdpdGggcmV0dXJuOyANCg0KPiANCj4+ICsgICAg
ICAgICAgICAgICBBU1NFUlRfRVEoc2lndXNyMV9yZWNlaXZlZCwgMSwgInNpZ3VzcjFfcmVjZWl2
ZWQiKTsNCj4+ICsNCj4+ICAgICAgICAgICAgICAgIEFTU0VSVF9FUSh3cml0ZShwaXBlX2MycFsx
XSwgYnVmLCAxKSwgMSwgInBpcGVfd3JpdGUiKTsNCj4+IA0KPj4gICAgICAgICAgICAgICAgLyog
d2FpdCBmb3IgcGFyZW50IG5vdGlmaWNhdGlvbiBhbmQgZXhpdCAqLw0KPj4gQEAgLTExMCw5ICsx
MTYsOSBAQCBzdGF0aWMgdm9pZCB0ZXN0X3NlbmRfc2lnbmFsX2NvbW1vbihzdHJ1Y3QgcGVyZl9l
dmVudF9hdHRyICphdHRyLA0KPj4gICAgICAgIEFTU0VSVF9FUShyZWFkKHBpcGVfYzJwWzBdLCBi
dWYsIDEpLCAxLCAicGlwZV9yZWFkIik7DQo+PiANCj4+ICAgICAgICAvKiB0cmlnZ2VyIHRoZSBi
cGYgc2VuZF9zaWduYWwgKi8NCj4+ICsgICAgICAgc2tlbC0+YnNzLT5zaWduYWxfdGhyZWFkID0g
c2lnbmFsX3RocmVhZDsNCj4+ICAgICAgICBza2VsLT5ic3MtPnBpZCA9IHBpZDsNCj4+ICAgICAg
ICBza2VsLT5ic3MtPnNpZyA9IFNJR1VTUjE7DQo+PiAtICAgICAgIHNrZWwtPmJzcy0+c2lnbmFs
X3RocmVhZCA9IHNpZ25hbF90aHJlYWQ7DQo+IA0KPiBEb2VzIHRoZSBvcmRlciBtYXR0ZXIgaGVy
ZT8NCg0KVW5mb3J0dW5hdGVseSwgeWVzLiBUaGUgYnBmIGxvZ2ljIHdpbGwgc3RhcnQgZXhlY3V0
aW5nIGFmdGVyIHNpZyBvciBwaWQgYmVjYW1lIG5vbi16ZXJvIChzZWUgL2QvdS9tL2wvdC90L3Mv
Yi9wL3Rlc3Rfc2VuZF9zaWduYWxfa2Vybi5jLCBsaW5lIDEzKS4gSSBhbSB0cnlpbmcgdG8gcmVt
b3ZlIGFtYmlndWl0eSBoZXJlIHdpdGggdGhpcyBzbWFsbCBjaGFuZ2UuIEFsdGhvdWdoLCBwaWQg
YW5kIHNpZyBzdGlsbCBtYXkgY29uZmxpY3QuIExldCBtZSB0aGluayBpZiBpdCB3aWxsIGJlIGJl
dHRlciB0byBmaXggdGhlIGJwZiBjb2RlIGl0c2VsZi4NCg0K
