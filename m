Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6EC4FFDD9
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 20:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbiDMSc5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Apr 2022 14:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbiDMScc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Apr 2022 14:32:32 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1E353A5A
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 11:30:10 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23DHTTVe012743
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 11:30:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=37V2eo98me2IRTQ4kuFs3oYnEpcFVCwKEZuZSGPjTjc=;
 b=P13PRDIVJEx815q5ZAvxbhFZaZ+9jBo2JMgTtYu7cyK9Z+2EvWiuFbptIEJJzr39JfUO
 ePb7ww60la0FTBbEDyNbEOq95uD9YK64fthH8IpFVbMuRzeJMOnpehN0SXzHxQmPeq8b
 DTBBoibRel/Uv4MFEP2Bn8iimjWkE8cOdNM= 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fdd5uggbb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 11:30:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gonDqvsLPngbf1ferea5CRatpLfh3l5P+y+jLS/tZ1h6UQxc76Y5YzE/32DBYmQWCIvhLBNJQfojshZASaKXKT19s/rvVoNqhDC3FCW7ZcN/pXduWlwoJarKowYdTiOw6tgLp+mnUSU0ldQlAVVuDODjAURHrPOHX7IZVD12VxDcH8d3e3gZSN+689B8v221m5REwWuUUYADFI/b1Kl2xBRE0PFFBbcG1Wh1e0aCKSjfKT/ZXIL1uIdXBdqB3mKGjVeLynaCehGWrWfW0nxBrThnduoGu/MjE6y3ZyzoMr6jbNndCg/e0iHXzqyjswsXcrWOFhyDsBl1R61yrA2NLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37V2eo98me2IRTQ4kuFs3oYnEpcFVCwKEZuZSGPjTjc=;
 b=TXsdk8eeDA+KrU+7iZ2q6N/S0lCn1FxKel3jw/lIvmT7Tsagk/v5u1HtK37x1153FJ70eYYy53jLny1BGiDrP1gp7/m3enrVFQcd80NapRnu1sfnoKiLLNg4QaCDs+usvBaDAbk23QCbyD9Mjm/h5EjpJhFHBUSCSORb4DnYaB7+zTQGnfbQ8G2Z5MVgon0+S17FEqKIuUUnjWl5zpmz4UyvN4Pqgr62Bk+Lvs1ZRr05F1ZZqhUku3ckaJJkmDnCJtVDqoKJ8J/09a30uZDpPn3u8tVcHcymGYTrvR0BrSlRu6xA+PlUhsQseQ2SRhDJaiN/HGvWhl6mLXcHdiVScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by MN2PR15MB3455.namprd15.prod.outlook.com (2603:10b6:208:3c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 18:30:06 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a%6]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 18:30:06 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 5/5] selftest/bpf: The test cses of BPF cookie
 for fentry/fexit/fmod_ret.
Thread-Topic: [PATCH bpf-next v5 5/5] selftest/bpf: The test cses of BPF
 cookie for fentry/fexit/fmod_ret.
Thread-Index: AQHYTo5QoM2oBjX/UEGhCSU/o0xut6ztLOoAgAD+9oA=
Date:   Wed, 13 Apr 2022 18:30:06 +0000
Message-ID: <50350c2071e3cb8e72a49a8ab46e37a250c573d1.camel@fb.com>
References: <20220412165555.4146407-1-kuifeng@fb.com>
         <20220412165555.4146407-6-kuifeng@fb.com>
         <CAEf4Bzbq+rcUJuXtBDb__M97xNAWH_5CbJAYrxCrDKytX_dJvw@mail.gmail.com>
In-Reply-To: <CAEf4Bzbq+rcUJuXtBDb__M97xNAWH_5CbJAYrxCrDKytX_dJvw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e67e230-bb32-423f-c65b-08da1d7ba1ff
x-ms-traffictypediagnostic: MN2PR15MB3455:EE_
x-microsoft-antispam-prvs: <MN2PR15MB34557DADF36A620C2742D116CCEC9@MN2PR15MB3455.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ye6/WSa9Qq/F7hT/B1kfVdsQ3WgI29lY1I3drHF3td8pEiEB39KFeRf7XTk3fGHFrz6gxgMsMQKQHeTUqebo9lRp0DQHOpXqXsSpat8iyZP9upG4ZSsGebHHVp+MJQcQlA9aIlfSTu4yXs27BUqG0idYZnKBubrnqWR3GFrHkqI3+p+rndAOZ0DKOUNSS6MEnh66JRvqjiQZ23sGXrKvMem6nmTtezFyLFcAE9GubQpoA5iQRJO/2TUC3oy/dXnoBPl0382faOjf0GyBWbN4oCAf6y8u1vT/1GlUq4Ak6M7VYiOnTRNO8qE7smULSAIa6X9bbsb3Gpk9XA92qzn9GiM6+FZo+eAa3pnGtrLf1DmxuWiurokuupD84dGw5T4m99HLDdZoBfK2w+E5wTvFxL2Jw2mjAJ4rUEqvX5NhQJEquh6ornorC3mi+2HIdOUjJvNWAdjcmwSA10sU0koIH/dAWOXIdoZn4QsyJOyOb9sQFPgssF5apn/NGmREZOQSNCTjhinR5pG9hQIi2WOOc1iVy7DUFhAgt2qI5SDrRWOjiW8iEAP+S/+cBvfB6ylqI7utjxkt7IC0g0nNTUvSLaf49CX4umw1as1JAdTeyjbjMDImJlqB3Il1PmkwMN4Y7+/kN9FC9197kGFaX06D469uL/wH4ujE0f851QH9hEevOb6H+JGU0oKdTwl10qI+ldd18iaSVdH4afNPfhKD/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(2906002)(6486002)(38070700005)(5660300002)(71200400001)(8936002)(36756003)(6512007)(6506007)(53546011)(316002)(186003)(2616005)(66446008)(76116006)(4326008)(66946007)(38100700002)(122000001)(66476007)(64756008)(66556008)(54906003)(6916009)(8676002)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UytqZkgwMTlLM1pmbVZsd1dBbXVNdnlQM25HZXhUMFlXdVZVQVFkSUVubG9W?=
 =?utf-8?B?Z21IRlI1ZEpRWGRablpSQmowT2JQYjFWWVJuNXU2dUZscXNhV1lvdnpiYmt5?=
 =?utf-8?B?MzhYeUJyN01iNW9ham1iajV5TS81cy8wSWNFdFRKeTY1c3l3OVY4cC9CWVA3?=
 =?utf-8?B?eU1RUzB2MXVPWDJFNHVKWWM1Zit0OW5tekl5WFd0R0dXcU9lWkpMQXgrRFZV?=
 =?utf-8?B?UC9CUVJ3WUFRRDNvb0lLcys3T0MyQTUxR3QrRkJuQVNZREFLNXcxSmlwaTFU?=
 =?utf-8?B?djBvRGNvaVgyT2NxNkFNbmpmMmRQcDlvL0RjS2hDY0lTdnhhMm5iczl1ZUFs?=
 =?utf-8?B?ZGYzVW5vaktWZ2dvZVlkRzBsQWg2cTB0UnV3bG13cDN3WkU4UlNwVkJEbExU?=
 =?utf-8?B?U2V2SnNYL3N1OTR4VTlNUTFVTmtSd1pxMGlZTktoOFJKYzJjVUZYNjlBSWk0?=
 =?utf-8?B?YkFOc0lrVWYzWGtEZlFUT1U1SVFHZmt2Y2Y5ZEFpRU5EOC9jUkltRHBSbGNs?=
 =?utf-8?B?dUpUVW90djhVbVJKVW92bnBvaG9hVVh3SmZUY0NINkp2R1RDamtmUWRpWmFM?=
 =?utf-8?B?T0dpWVlWVnJ1MVZmY1U4NnBpK3dBM2JVRUo3eEVuNHcvVnByRmRzZXQ1UHZU?=
 =?utf-8?B?NGF6TTRwWDVtRzJQQkN0UTV6RGVLdVVhTisyZE4yMXcrSUwwRmc0Nmk0UlB6?=
 =?utf-8?B?WXFCV0ZRWXExL3h1RmxsY1JHVDlhOTNsQWhNcjYxOWZ0bVdYK3c2UWlyaUNy?=
 =?utf-8?B?YmVDdXdaNWlSWVY4ZGRGQWoyQ3FDMUFWZjhJNEdteGVsRXQ4djBWUWtUVDNy?=
 =?utf-8?B?R2JJYktHdmFJQmU3dHRhMFFJSEV6bU9qMDg0ZmtDd1VvcmNEK2FqWmVPdEtj?=
 =?utf-8?B?OE1pcFpvWmdwSXNYbm1hM1VCdnZVb2U1RHdQcy9mMkNXV3dWVHNHNGptSlZs?=
 =?utf-8?B?TUdVKzgrNzh0ZDlaeEUvYlJhR2ZkbmFoZG5OY3RNMmt6M1lpWmcyK1JOQjVJ?=
 =?utf-8?B?ZkxzbkM3c1VtazdQaEpxUFhRdWxKa2h1SmRSdUdaL0YrK3BSNTN5QXlCTlVL?=
 =?utf-8?B?K1dqSkhaQmV5bC80YVZJV2xIZlZKOFN5R1NhVHQ2TUNNNkh0YmM5N2Jkb3NF?=
 =?utf-8?B?SEd1QWNtL1lFakc2SnhYdmttTFhDanBnLzBMVHZhbHpvQy9LcEJTbUdadHA2?=
 =?utf-8?B?d3FGb2JZLzlMQ0ZwWFVucVFkbW1tTkh3Y0ZyVFJPSDNCQ3FMTzBKbktJdXlQ?=
 =?utf-8?B?bGdhQkFxeWxkb1FsenQwbCtROXdUUkRYWnpRcUFBZ1pVVVQxK1BnTSt0RG9S?=
 =?utf-8?B?bHI0ZGd5QVFCL2R3YVFoN3Y4YXdVbzVNOHZKMlpmWjRDNEpCelgxR0Rwc09B?=
 =?utf-8?B?cFVHWkxmWVArVWFBeXY2WVg5ajRZOVBSYXBCMGVBdHVHMXpxTERDQ1Q5QXNs?=
 =?utf-8?B?YlpxM3Y1UmJZV1YyWnBVc1F4dUErSGlPT3Mvc0NxbkFvSC9YR2tINlVNZUNj?=
 =?utf-8?B?Si9QRENyYkNKa1FCUXJ1aVRlZk5ETVVkZXFEZ2kvMGpueVRtN0Yvb0l1a2VP?=
 =?utf-8?B?dGkvbWxvOFo3a2dLYUo3dnpFYzB1dXFiWnRMOWRaaHErdnQvTW1Oc3dMQUU4?=
 =?utf-8?B?SmVDdmhJV21OdWlqb2lxS3hRd0pUV0dCTHNudzlybHVJUU5KdjE5YUNyQVpD?=
 =?utf-8?B?SndLb2M5UGtycDZzQzNMRm0xcGVOMWluSllqU1RJNnhkUGhtd0dIVmpWNk1Z?=
 =?utf-8?B?N0hVcFhlVDAvb2JwSmQrdU5hVGhvc1RmWGhWeGhMRVNFN2Z4WCtmeENGNGk0?=
 =?utf-8?B?Rk5MVGptZ3k3WEtXN1FBUk9TN3BLdm9wUnBCb3piVG44R3VPajNwQjByMVZP?=
 =?utf-8?B?NWtnSVU3OUFhU05uWWsvL0JPZ1RqMGRLVnZGb3ROREJ4Sk03VStrdnFmUU5E?=
 =?utf-8?B?d3ZxYXlaSW4zRlZycjVYcVFTVExUREk4a3Z6N1ZLNkVzMXllVWJIOVA4bTcr?=
 =?utf-8?B?QzQxamdnOEt3bXJTZjRKMXF0WVZubUxzSER0MVh2OXZWTGFNNjM2L1BUaGtu?=
 =?utf-8?B?NS9KQW5na1B2Nmk0MlU0VER2R1dDRUtYdG1QcUgzakhxMGNTYWQwSlh6NU9V?=
 =?utf-8?B?S21UcXcybUJwdjJpcUxsaHVDNzJDTlpwbnhVUFpINllzZVVla2tuVkp0Y281?=
 =?utf-8?B?TXhQNXBJbXlZbjVMMTVWRzBQZWdQRE9aSEp5VG1mR2hmdVUvdWkyOVFld3pn?=
 =?utf-8?B?bDhSajVteUYwK0oxcktxNlFmQkVPa1VzTjllbStsR0FsRWFxNTAwMHZsRjhT?=
 =?utf-8?B?U21CbHNMNzdLODRrUVR2dnZVbk9HZnNpdkJ6QitmQ0Zsb2tVMmxKN0VYd0h3?=
 =?utf-8?Q?O59e5a4dgVqPFS+W87UU953Jpejku/9T0gm1b?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <633FAF0533598C45901B83EB0517CBC5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e67e230-bb32-423f-c65b-08da1d7ba1ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 18:30:06.1329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24Jxj7ktNwMS00eV4gGHATpsKwoevRLCd0mtM811z67+yUP3zRJjb8gPVZwcKlTB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3455
X-Proofpoint-ORIG-GUID: kukOYxt9WUPKYDyLEtCuZ_z24ityEYd8
X-Proofpoint-GUID: kukOYxt9WUPKYDyLEtCuZ_z24ityEYd8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-13_03,2022-04-13_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTA0LTEyIGF0IDIwOjE3IC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQo+IE9uIFR1ZSwgQXByIDEyLCAyMDIyIGF0IDk6NTYgQU0gS3VpLUZlbmcgTGVlIDxrdWlmZW5n
QGZiLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gTWFrZSBzdXJlIEJQRiBjb29raWVzIGFyZSBjb3Jy
ZWN0IGZvciBmZW50cnkvZmV4aXQvZm1vZF9yZXQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
S3VpLUZlbmcgTGVlIDxrdWlmZW5nQGZiLmNvbT4NCj4gPiAtLS0NCj4gPiDCoC4uLi9zZWxmdGVz
dHMvYnBmL3Byb2dfdGVzdHMvYnBmX2Nvb2tpZS5jwqDCoMKgwqAgfCA1Mg0KPiA+ICsrKysrKysr
KysrKysrKysrKysNCj4gPiDCoC4uLi9zZWxmdGVzdHMvYnBmL3Byb2dzL3Rlc3RfYnBmX2Nvb2tp
ZS5jwqDCoMKgwqAgfCAyNCArKysrKysrKysNCj4gPiDCoDIgZmlsZXMgY2hhbmdlZCwgNzYgaW5z
ZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0
cy9icGYvcHJvZ190ZXN0cy9icGZfY29va2llLmMNCj4gPiBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2JwZi9wcm9nX3Rlc3RzL2JwZl9jb29raWUuYw0KPiA+IGluZGV4IDkyM2E2MTM5YjJkOC4u
N2YwNTA1NmM2NmQ0IDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Jw
Zi9wcm9nX3Rlc3RzL2JwZl9jb29raWUuYw0KPiA+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2JwZi9wcm9nX3Rlc3RzL2JwZl9jb29raWUuYw0KPiA+IEBAIC00MTAsNiArNDEwLDU2IEBA
IHN0YXRpYyB2b2lkIHBlX3N1YnRlc3Qoc3RydWN0IHRlc3RfYnBmX2Nvb2tpZQ0KPiA+ICpza2Vs
KQ0KPiA+IMKgwqDCoMKgwqDCoMKgIGJwZl9saW5rX19kZXN0cm95KGxpbmspOw0KPiA+IMKgfQ0K
PiA+IA0KPiA+ICtzdGF0aWMgdm9pZCB0cmFjaW5nX3N1YnRlc3Qoc3RydWN0IHRlc3RfYnBmX2Nv
b2tpZSAqc2tlbCkNCj4gPiArew0KPiA+ICvCoMKgwqDCoMKgwqAgX191NjQgY29va2llOw0KPiA+
ICvCoMKgwqDCoMKgwqAgaW50IHByb2dfZmQ7DQo+ID4gK8KgwqDCoMKgwqDCoCBpbnQgZmVudHJ5
X2ZkID0gLTEsIGZleGl0X2ZkID0gLTEsIGZtb2RfcmV0X2ZkID0gLTE7DQo+ID4gKw0KPiANCj4g
dW5uZWNlc3NhcnkgZW1wdHkgbGluZQ0KDQpHb3QgaXQhDQoNCj4gDQo+ID4gK8KgwqDCoMKgwqDC
oCBMSUJCUEZfT1BUUyhicGZfdGVzdF9ydW5fb3B0cywgb3B0cywgLnJlcGVhdCA9IDEpOw0KPiAN
Cj4gLnJlcGVhdCA9IDEgaXMgbm90IG5lY2Vzc2FyeSwgSSB0aGluaywgLnJlcGVhdCA9IDAgaXMg
ZXF1aXZhbGVudCB0bw0KPiB0aGF0DQoNCkkgd2lsbCB0ZXN0IGl0Lg0KDQo+IA0KPiA+ICvCoMKg
wqDCoMKgwqAgTElCQlBGX09QVFMoYnBmX2xpbmtfY3JlYXRlX29wdHMsIGxpbmtfb3B0cyk7DQo+
ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqAgc2tlbC0+YnNzLT5mZW50cnlfcmVzID0gMDsNCj4gPiAr
wqDCoMKgwqDCoMKgIHNrZWwtPmJzcy0+ZmV4aXRfcmVzID0gMDsNCj4gPiArDQo+ID4gK8KgwqDC
oMKgwqDCoCBjb29raWUgPSAweDEwMDAwMDsNCj4gDQo+IG5pdDogbWFrZSB0aGlzIHZhbHVlIGJp
Z2dlciB0byBtYWtlIHN1cmUgaGlnaGVyIDMyIGJpdHMgb2YgdTY0IGFyZQ0KPiBwcmVzZXJ2ZWQg
cHJvcGVybHkuIE1heWJlIDB4MTAwMDAwMDAxMDAwMDAwMCAoYW5kIHNpbWlsYXJseSB3aXRoIDIN
Cj4gYW5kDQo+IDMpDQoNCk9rIQ0KDQo+IA0KPiA+ICvCoMKgwqDCoMKgwqAgcHJvZ19mZCA9IGJw
Zl9wcm9ncmFtX19mZChza2VsLT5wcm9ncy5mZW50cnlfdGVzdDEpOw0KPiA+ICvCoMKgwqDCoMKg
wqAgbGlua19vcHRzLnRyYWNpbmcuYnBmX2Nvb2tpZSA9IGNvb2tpZTsNCj4gPiArwqDCoMKgwqDC
oMKgIGZlbnRyeV9mZCA9IGJwZl9saW5rX2NyZWF0ZShwcm9nX2ZkLCAwLCBCUEZfVFJBQ0VfRkVO
VFJZLA0KPiA+ICZsaW5rX29wdHMpOw0KPiA+ICsNCj4gDQo+IEFTU0VSVF9HRT8NCg0Kc3VyZSEN
Cg0KPiANCj4gPiArwqDCoMKgwqDCoMKgIGNvb2tpZSA9IDB4MjAwMDAwOw0KPiA+ICvCoMKgwqDC
oMKgwqAgcHJvZ19mZCA9IGJwZl9wcm9ncmFtX19mZChza2VsLT5wcm9ncy5mZXhpdF90ZXN0MSk7
DQo+ID4gK8KgwqDCoMKgwqDCoCBsaW5rX29wdHMudHJhY2luZy5icGZfY29va2llID0gY29va2ll
Ow0KPiA+ICvCoMKgwqDCoMKgwqAgZmV4aXRfZmQgPSBicGZfbGlua19jcmVhdGUocHJvZ19mZCwg
MCwgQlBGX1RSQUNFX0ZFWElULA0KPiA+ICZsaW5rX29wdHMpOw0KPiA+ICvCoMKgwqDCoMKgwqAg
aWYgKCFBU1NFUlRfR0UoZmV4aXRfZmQsIDAsICJmZXhpdC5vcGVuIikpDQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBjbGVhbnVwOw0KPiA+ICsNCj4gDQo+IFsuLi5dDQoN
Cg==
