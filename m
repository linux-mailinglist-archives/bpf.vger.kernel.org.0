Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E185A58A6
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 02:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiH3A5G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 20:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiH3A46 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 20:56:58 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F55D870B1
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 17:56:56 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TMpOFn008637
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 17:56:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=XJ42ehC9Qptwo+YlkjlijqDluOFFyRvz+6PKrus40jA=;
 b=eUqZhG5RzHIr9n21wyzymYqo4FH0WhWv/jB65CiBpUBXE1xYbXH01DSwDqT0+6+oaEIi
 fa2gsz/t1Cl0FSozCSn9kDS8ORrtynk+5Q40WM6qqrUFaHJPA9uDoQDbMcfboorvLNRG
 Dy0M2ChYeMagMKDVkKd+8bTXA62RYER0XE4= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j7gt05c1a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 17:56:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0y60nM1hPtCiiSjG8ugt8SQt7bVG9tVC+izylnr7V5tfuzUnmXccmNVd8bDKFudqF1XXFtutsl07C+l59BCVXEDP3yb6r7AC/8x5Ik5NRDkbLuVPkgws6QUFgwW87SqvEtTjSCQnh05MtJueciPh5jZ97KBKAwDbEspPs21FNMjLF/Q5tU3MSN0x0JZdAus2MYfmANof3rJUSfUtZQ4sdklGjCj/95r0w04Clgx4Zqdx0yEDRxa5MHkFTAGk7DE8fN0HfVEOYuXm64WvCsn5yoe8oLYgaL+6q4tviPvPjRZv0Up4h0SWDfzjNB7RYQtuFhWRFOr8yHwhbalkNcfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJ42ehC9Qptwo+YlkjlijqDluOFFyRvz+6PKrus40jA=;
 b=gwECon10COy4L7cV+8t+AFux5DTwvD8WLk6zpRzMQSxQjWsNspLOyLPYCVXvCommLG8tbdZxdgk6hRoiQ/I2u3LDWTgnSM9H9s1HeRwPrYXj5CHjAWyCZ5VUfe88DOsvKGclp6mynA/RHFpuFEcf3x7yIzw9cakyvqpIjr8wD3akAxrNnAb8vx8c+J/wzTSWIfK5gLn+T0wLJGabSHWuY6xoY9k17FH9xlyzOFMMid6ePDraF50VwxCoZ0AdOQ8FF1711XACFWx2igAswsV82gLnJgNQgBZC2cqnzyJa/qB2rz6gOSWkZI8adR7hImoGK2sVcW3jGSpJlfQyScxVhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by DM6PR15MB2281.namprd15.prod.outlook.com (2603:10b6:5:8d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 00:56:53 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f%6]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 00:56:53 +0000
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
Thread-Index: AQHYu9zclRlYWowWNEGMnR+ZA6AMha3Gnw4A
Date:   Tue, 30 Aug 2022 00:56:53 +0000
Message-ID: <b6f3a06da330640382ca7885ec2500621eae9d80.camel@fb.com>
References: <20220829192317.486946-1-kuifeng@fb.com>
         <20220829192317.486946-4-kuifeng@fb.com>
In-Reply-To: <20220829192317.486946-4-kuifeng@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 054d17d0-280b-4cf5-d500-08da8a22879d
x-ms-traffictypediagnostic: DM6PR15MB2281:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sCVxouguQUsizjrrAqJItGS0MrlwnxrN33izkLUjdHGm/eyCooHMMF00bhcNYfvgtO0Ot9Umi0Lm7IQU9lrz+lORXKArEqiekgBKfKw/UP2uSPzWkbL6A5PBK8nHRNmu4m7DNe2z8/5wrOu/y5WA0Tb4Ibua9Rzd22DmVG6jkv5DWzX8UpmEW9hVjm7MYuL+ViRf7A/4H5s89yvMNXAFmizzRGQ1vbqwG2EJdz8BkuPwHBdq34BLOe2NK4/kCq43wAzvq+NLcTfjW8sb25HbmpG7qDc6dTDlDlc0hAmSb9NVQfc06+V71KglVushsfGGr/LWTn6Friu8OBLU9lYegigQ9gwWFyX/oIiG32PFLNemLvffmzcz9Km9PeypSYbJHWGiNjrFinuaBnEl7m6fyWGdLfDeLf1Mt/Bis2AeoI6OY6XHBNXbPaUSNVMmn316rG++MY+YhvIQFRLUbcq36DCZxCcf149Joc2LX8cpECX4Qy/FRMnU3h6ES8lEskF34u5qkK+ofqkAaYNa9W+rdfXlwyzoICLBnFlBkSMCUu5mJYtnsy+X1odQgZi/xWE9obHYl72rT0vAzTEJvS0F0D2AOz4BGaqvGQ6jEBkUR30bugLJA0zi26k72vw/O9k16JkvSa+GUdgWXGHdnaEXjbx+GCUAtTmP7D2eq8dWcTai7BT3hnPURnrOKNBeS2cQcdkgmZPJgoQx5OWfhHGXSIDGBPJpIEQaWNguwi1YrWixR6Fmdz3qa85vcZWwsI2EtKXtw2IrGF5p5xiq7foWrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(6512007)(86362001)(71200400001)(478600001)(6486002)(6506007)(41300700001)(186003)(38100700002)(122000001)(38070700005)(83380400001)(2616005)(66446008)(110136005)(66946007)(66556008)(5660300002)(66476007)(8676002)(8936002)(64756008)(36756003)(316002)(2906002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dk1idzVTMHdrQlhhSjVXTmhPOXZ3UFBmWlhHOUNXMjhEaGx1R1hkNnhrWFo0?=
 =?utf-8?B?K2M5VERScG9tb29hb01ZWGl3Z01sNEZXTElrTGpwN3NDT3k0ZDU3dFFBZXRt?=
 =?utf-8?B?b3ZJSVVnQzZwOXNkaHlEelhreVFpZDNlemZWVWxtL3doektJL2tSRk9uRERm?=
 =?utf-8?B?Nm8vN0xIK0FYM2tBaUdnUk8vLzNETE82TENTRExUSVZkeis2UG80V3pLSmho?=
 =?utf-8?B?K2tPNUw2bHVxbWg0aXhuZUZwV1RVNkJqTVBicEp2dE9aVmpLbkNJN1M2dVlD?=
 =?utf-8?B?UjJEeEhMMkFVMXV2WXRQS3dFTzhtTEFkalN2N0pNY1Y3R2ErUk84QmkyMmZN?=
 =?utf-8?B?cmcwUWpGYzRmOHU5cFc1TFVsLzVtaFlLc3JOeEVvOFJXUGhUZ3p6R1dZdm9Z?=
 =?utf-8?B?cG9YeTZxYjFTQzdxbFQ3eEhqWmlFMUQyWnhZWU5rR0NpWndHMnNUZjZFN3Ny?=
 =?utf-8?B?Q1lFWFVvK1h4YWJyZVpZa3lTZmJYVGNuSlVvSExpZUltcjBVclJvQ0lUVWIy?=
 =?utf-8?B?TVlnVFJOb0tCTkZBcHJqQUcrVm1LSGp1Y1M3UzJwamtqQ0hxS3NyOWRyZzNm?=
 =?utf-8?B?UTBsQ2ZJQ0VVQzVFNmF4dlkrQ0FWb2h5K0hxSEVJcTJuMEMyRXhzR1RMQXAv?=
 =?utf-8?B?Tkd4U0d0T3UxVzYvTFNZUzVqSUNOS3FwZlB2K2ZIeWl6WFU1aGhIZldQOGdu?=
 =?utf-8?B?NllLN1dvVDRWL2c1bmFHdkZ2RGF2RDVjZnFQM1h5V29LMFpEZGoydzFJeTQ5?=
 =?utf-8?B?Z2JOV0hJaE1LYTJDZ081WXp6OFptZWlJRkx5dTAvTkhaVCt0OGR6TnZ2Rkg3?=
 =?utf-8?B?SzZMb1p2bXpRcTVTQytxQk5WaW1rZCtrMnZjOTF5TDVzMHFzby9Zc1pKYXd5?=
 =?utf-8?B?N2pSb3JrY1lXMXd2SHpJSld3clRuTjRXTC94NEpCQXh1UjJmeHRzdG44SHJq?=
 =?utf-8?B?UTlaOFpxUHJIZGlud1pFdUNQZ1RRa0pMTFJiNjB0Qk4wSmo4ZWZzaStUeFhJ?=
 =?utf-8?B?MCtDUjZsdVM3UHJqc09WVk84K3FwblpsdXFkMjBiK29xVitGdy9kSG1EelJa?=
 =?utf-8?B?R1JnZDZVRjZxdEVHTWFrWWpQb3ExSjdGbDNFV2hiQ1F1SFBxajQwWUdiVFdv?=
 =?utf-8?B?WXFuZWI2amk3czlHR3E0OXMvNklHYXN4ZitxWU9QRU5xK3JDUmEza0EwSVNS?=
 =?utf-8?B?OUE0MFZRUEtJbzdDblVhVU5GclFFbllmNUtQSTFPcVdPZGgrcmsyRi90djMr?=
 =?utf-8?B?K0dTTGxJK0k5OGF4d1ZkSENJT1ZFZ0ttT0Ryd0RTMlVnckN3S1FFZjJURE1W?=
 =?utf-8?B?YTdDMGdublNiR2ZROTZPOXEzdWJBdG1MY255UWtzZjFWN2lyRmgvWHVpUDNB?=
 =?utf-8?B?YlJ4K3lQam02cWZieHFtTDdrVHRSbFJtVlZrWjlONGFmbWNjOWRWNTY1Um9F?=
 =?utf-8?B?MTVMaXJTbmlxRUoxNEhYTE16TE5kZXZyTFk1S3JVRTBHdlI2MVhpTSt5Tkll?=
 =?utf-8?B?OEt5L0djNmx4M0dYL2pPOFZCcWw5SGRzcGpTbzArblVUYVFxYTFIUEJoajhM?=
 =?utf-8?B?WDZVMU92eDZOMlNTTUZFWENaK01iV081Z2VYdHVpL00vTFJIRmswYzdNYUVx?=
 =?utf-8?B?bmNuOXY5alNFQjcyT0dpd05SSkFJYmsyQzhMcG9tMVRXOHJnWlo3a29mNEpz?=
 =?utf-8?B?a3k4QkxEczJlQ1NuTjlRQldwbnNUMmNnSGdMOGpnOXkrbUxJN0RFNS92OVcr?=
 =?utf-8?B?NzlKTno4WS9GUEYrakdJdnJITTZmZlpJeDkzRWg2MkE4T1RReHdZa3c1bkRx?=
 =?utf-8?B?VHV4cmVaZjJTVFBDQzJ4akFNMld6YzczTS9pWHArZXZzSHhqT2svWXRYQU00?=
 =?utf-8?B?SHF1TkRybnJyMnl2NzZPR25udWhVOVpta1JKd0pPSENFb1dnRTlDbXRjUWtj?=
 =?utf-8?B?MFNxVzhvQXJJTUp5WFFaWnhMb2RUSnh6aS9OeDJJQ2JKMWVsbmVRdXRxa1l5?=
 =?utf-8?B?YnJ1bG1LRUFpM0pvTXNJbFJFNm9YaFBTQ0YrVTNWM2Q4TVZzTFo0Q1JUT0xM?=
 =?utf-8?B?SjduWUlBeDMrZnJDQ1psR3FGN2J2akJ3L3JRRjJDSFVvTzl5YkQrTmhRcHJH?=
 =?utf-8?B?QTVZaTJwUHhKWHJPSkdFZ3VvckxnTlNwOW85ODhMZnZ1TW9aZlplL2Q2R0hH?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27A576419D4DCD4B9BBCA84A1010500A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 054d17d0-280b-4cf5-d500-08da8a22879d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 00:56:53.4666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +TnJSco/7bO+++yVQXMj0DoMN4v7JUP2mgNR4dRhL+GDfGpZE6hBCGZKl5qoSWKg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2281
X-Proofpoint-ORIG-GUID: 6rW7br1rfhVZQDjbNoQePM28VhelbN9q
X-Proofpoint-GUID: 6rW7br1rfhVZQDjbNoQePM28VhelbN9q
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

U2hvdyBpbmZvcm1hdGlvbiBvZiBpdGVyYXRvcnMgaW4gdGhlIHJlc3BlY3RpdmUgZmlsZXMgdW5k
ZXINCi9wcm9jLzxwaWQ+L2ZkaW5mby8uDQoNCkZvciBleGFtcGxlLCBmb3IgYSB0YXNrIGZpbGUg
aXRlcmF0b3Igd2l0aCAxNzIzIGFzIHRoZSB2YWx1ZSBvZiB0aWQNCnBhcmFtZXRlciwgaXRzIGZk
aW5mbyB3b3VsZCBsb29rIGxpa2UgdGhlIGZvbGxvd2luZyBsaW5lcy4NCg0KICAgIHBvczogICAg
MA0KICAgIGZsYWdzOiAgMDIwMDAwMDANCiAgICBtbnRfaWQ6IDE0DQogICAgaW5vOiAgICAzOA0K
ICAgIGxpbmtfdHlwZTogICAgICBpdGVyDQogICAgbGlua19pZDogICAgICAgIDUxDQogICAgcHJv
Z190YWc6ICAgICAgIGE1OTBhYzk2ZGIyMmI4MjUNCiAgICBwcm9nX2lkOiAgICAgICAgMjk5DQog
ICAgdGFyZ2V0X25hbWU6ICAgIHRhc2tfZmlsZQ0KICAgIHRhc2tfdHlwZTogICAgICBUSUQNCiAg
ICB0aWQ6IDE3MjMNCg0KVGhpcyBwYXRjaCBhZGQgdGhlIGxhc3QgdGhyZWUgZmllbGRzLiAgdGFz
a190eXBlIGlzIHRoZSB0eXBlIG9mIHRoZQ0KdGFzayBwYXJhbWV0ZXIuICBUSUQgbWVhbnMgdGhl
IGl0ZXJhdG9yIHZpc2l0IG9ubHkgdGhlIHRocmVhZA0Kc3BlY2lmaWVkIGJ5IHRpZC4gIFRoZSB2
YWx1ZSBvZiB0aWQgaW4gdGhlIGFib3ZlIGV4YW1wbGUgaXMgMTcyMy4gIEZvcg0KdGhlIGNhc2Ug
b2YgUElEIHRhc2tfdHlwZSwgaXQgbWVhbnMgdGhlIGl0ZXJhdG9yIHZpc2l0cyBvbmx5IHRocmVh
ZHMNCm9mIGEgcHJvY2VzcyBhbmQgd2lsbCBzaG93IHRoZSBwaWQgdmFsdWUgb2YgdGhlIHByb2Nl
c3MgaW5zdGVhZCBvZiBhDQp0aWQuDQoNClNpZ25lZC1vZmYtYnk6IEt1aS1GZW5nIExlZSA8a3Vp
ZmVuZ0BmYi5jb20+DQpBY2tlZC1ieTogWW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNvbT4NCi0tLQ0K
IGtlcm5lbC9icGYvdGFza19pdGVyLmMgfCAxOCArKysrKysrKysrKysrKysrKysNCiAxIGZpbGUg
Y2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEva2VybmVsL2JwZi90YXNr
X2l0ZXIuYyBiL2tlcm5lbC9icGYvdGFza19pdGVyLmMNCmluZGV4IDUxNDAxMTc0NDdlNS4uYzEw
YWVlZmZlMWQ2IDEwMDY0NA0KLS0tIGEva2VybmVsL2JwZi90YXNrX2l0ZXIuYw0KKysrIGIva2Vy
bmVsL2JwZi90YXNrX2l0ZXIuYw0KQEAgLTEwLDYgKzEwLDEyIEBADQogI2luY2x1ZGUgPGxpbnV4
L2J0Zl9pZHMuaD4NCiAjaW5jbHVkZSAibW1hcF91bmxvY2tfd29yay5oIg0KIA0KK3N0YXRpYyBj
b25zdCBjaGFyICogY29uc3QgaXRlcl90YXNrX3R5cGVfbmFtZXNbXSA9IHsNCisJIkFMTCIsDQor
CSJUSUQiLA0KKwkiUElEIiwNCit9Ow0KKw0KIHN0cnVjdCBicGZfaXRlcl9zZXFfdGFza19jb21t
b24gew0KIAlzdHJ1Y3QgcGlkX25hbWVzcGFjZSAqbnM7DQogCWVudW0gYnBmX2l0ZXJfdGFza190
eXBlCXR5cGU7DQpAQCAtNjgzLDYgKzY4OSwxNSBAQCBzdGF0aWMgaW50IGJwZl9pdGVyX2ZpbGxf
bGlua19pbmZvKGNvbnN0IHN0cnVjdA0KYnBmX2l0ZXJfYXV4X2luZm8gKmF1eCwgc3RydWN0IGIN
CiAJcmV0dXJuIDA7DQogfQ0KIA0KK3N0YXRpYyB2b2lkIGJwZl9pdGVyX3Rhc2tfc2hvd19mZGlu
Zm8oY29uc3Qgc3RydWN0IGJwZl9pdGVyX2F1eF9pbmZvDQoqYXV4LCBzdHJ1Y3Qgc2VxX2ZpbGUg
KnNlcSkNCit7DQorCXNlcV9wcmludGYoc2VxLCAidGFza190eXBlOlx0JXNcbiIsIGl0ZXJfdGFz
a190eXBlX25hbWVzW2F1eC0NCj50YXNrLnR5cGVdKTsNCisJaWYgKGF1eC0+dGFzay50eXBlID09
IEJQRl9UQVNLX0lURVJfVElEKQ0KKwkJc2VxX3ByaW50ZihzZXEsICJ0aWQ6XHQlZFxuIiwgYXV4
LT50YXNrLnBpZCk7DQorCWVsc2UgaWYgKGF1eC0+dGFzay50eXBlID09IEJQRl9UQVNLX0lURVJf
VEdJRCkNCisJCXNlcV9wcmludGYoc2VxLCAicGlkOlx0JWRcbiIsIGF1eC0+dGFzay5waWQpOw0K
K30NCisNCiBzdGF0aWMgc3RydWN0IGJwZl9pdGVyX3JlZyB0YXNrX3JlZ19pbmZvID0gew0KIAku
dGFyZ2V0CQkJPSAidGFzayIsDQogCS5hdHRhY2hfdGFyZ2V0CQk9IGJwZl9pdGVyX2F0dGFjaF90
YXNrLA0KQEAgLTY5NCw2ICs3MDksNyBAQCBzdGF0aWMgc3RydWN0IGJwZl9pdGVyX3JlZyB0YXNr
X3JlZ19pbmZvID0gew0KIAl9LA0KIAkuc2VxX2luZm8JCT0gJnRhc2tfc2VxX2luZm8sDQogCS5m
aWxsX2xpbmtfaW5mbwkJPSBicGZfaXRlcl9maWxsX2xpbmtfaW5mbywNCisJLnNob3dfZmRpbmZv
CQk9IGJwZl9pdGVyX3Rhc2tfc2hvd19mZGluZm8sDQogfTsNCiANCiBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGJwZl9pdGVyX3NlcV9pbmZvIHRhc2tfZmlsZV9zZXFfaW5mbyA9IHsNCkBAIC03MTYsNiAr
NzMyLDcgQEAgc3RhdGljIHN0cnVjdCBicGZfaXRlcl9yZWcgdGFza19maWxlX3JlZ19pbmZvID0g
ew0KIAl9LA0KIAkuc2VxX2luZm8JCT0gJnRhc2tfZmlsZV9zZXFfaW5mbywNCiAJLmZpbGxfbGlu
a19pbmZvCQk9IGJwZl9pdGVyX2ZpbGxfbGlua19pbmZvLA0KKwkuc2hvd19mZGluZm8JCT0gYnBm
X2l0ZXJfdGFza19zaG93X2ZkaW5mbywNCiB9Ow0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYnBm
X2l0ZXJfc2VxX2luZm8gdGFza192bWFfc2VxX2luZm8gPSB7DQpAQCAtNzM4LDYgKzc1NSw3IEBA
IHN0YXRpYyBzdHJ1Y3QgYnBmX2l0ZXJfcmVnIHRhc2tfdm1hX3JlZ19pbmZvID0gew0KIAl9LA0K
IAkuc2VxX2luZm8JCT0gJnRhc2tfdm1hX3NlcV9pbmZvLA0KIAkuZmlsbF9saW5rX2luZm8JCT0g
YnBmX2l0ZXJfZmlsbF9saW5rX2luZm8sDQorCS5zaG93X2ZkaW5mbwkJPSBicGZfaXRlcl90YXNr
X3Nob3dfZmRpbmZvLA0KIH07DQogDQogQlBGX0NBTExfNShicGZfZmluZF92bWEsIHN0cnVjdCB0
YXNrX3N0cnVjdCAqLCB0YXNrLCB1NjQsIHN0YXJ0LA0KLS0gDQoyLjMwLjINCg0KDQo=
