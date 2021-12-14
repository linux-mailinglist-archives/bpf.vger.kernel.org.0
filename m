Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C864748DF
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 18:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbhLNRH5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 12:07:57 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59430 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231544AbhLNRH5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Dec 2021 12:07:57 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BE939r7013233
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 09:07:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=b++oo81g25hAwTotjVfnlKqWMD6cKfPbjPTrFh9xEB4=;
 b=cmJ3YfjTXD3dpJ8MvwAqIzqycgXBObyooDhrYtyse9F2ITDto86Kuf5agQ8xGO+17r/h
 CiFeCQpQTNBaNh+wjRSmCF3ECF+Uce89GgLdUqAU1ODOaWBF0M/jnZfeV92NG7PcLMay
 XqyL77bPeFUukLFx7JS4O2NcrbjHWNlQd2E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3cxra0kb21-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 09:07:55 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 14 Dec 2021 09:07:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y18Nibhw5gq1K4pv7Eg8ERO7XuV9JRZmUhXq0u1m6JSnCMU2vjHddvmX2yzTzc9+KHpvbHviaCdl7PNtZGSE+jcLEQElpu0Vw+YgdTKByp5fq/gZPVLSchMIBV1erXuPDabax8/GCMtyQZv5p05OS3y/yetLtGb0wFy0+PJ0w/iS9uOBpxna2E72F8luo1BGsFVP5rpVrJada+HVK5xITB9jgs9ikC+Z6lHQKFIun1VgPyHBWSX5hUK6JlQT3lHQGW7oNzduIjS8bOEHG3Xjh5u+0kfEEMLL+MN6i7jAM9muv0V9HXvoZ++y0Jhcs18WFQ0G+71hL/r0FAJxCrSndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b++oo81g25hAwTotjVfnlKqWMD6cKfPbjPTrFh9xEB4=;
 b=evSTwa4c623bC7o4ixRHjz15WecV8we4a/oGKTQ6SZxOe58BIPxRE2RZc9+B4CuQ5JbQjvt/SRxt80jTxsdTg1xhhILlZM1z/IzcmMGzg3fZWunM1HzL8AJ0x4flO8EcEJhf6qpVtF6ZXLEqSP1zxlzD3l06CbrG3mopXkI08RMkDQ3jrEB8iWdtNEgRPNgcYAjprvTxzHcnNypQnRtLCp85LfjhlC5R31uto1N12JUGE+OToANWMy/kxsaUVY1gWacYVyMXQD08zEheUlIGmZa21ZuV4U4MsvmG5uId/8FzXvD7C56F+CpFAGiw94+hAkf9UzisFAGk5SGeUzD4+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB4595.namprd15.prod.outlook.com (2603:10b6:806:19e::18)
 by SN6PR1501MB2013.namprd15.prod.outlook.com (2603:10b6:805:5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 17:07:52 +0000
Received: from SA1PR15MB4595.namprd15.prod.outlook.com
 ([fe80::7d6b:57db:7dd0:184a]) by SA1PR15MB4595.namprd15.prod.outlook.com
 ([fe80::7d6b:57db:7dd0:184a%6]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 17:07:52 +0000
From:   "Christy Lee-Eusman (PL&R)" <christylee@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 2/3] Right align verifier states in verifier logs
Thread-Topic: [PATCH bpf-next 2/3] Right align verifier states in verifier
 logs
Thread-Index: AQHX8E5Jc+u83nNwZkuAh1hLKn/wxqwxLsCAgAEK5IA=
Date:   Tue, 14 Dec 2021 17:07:52 +0000
Message-ID: <1936327A-395E-4A4B-9AD4-C22F49DF0B07@fb.com>
References: <20211213182117.682461-1-christylee@fb.com>
 <20211213182117.682461-3-christylee@fb.com>
 <CAEf4BzZNc6RuhX278OTL4y6VDE16A-TtFXfOyo9tVJ=6hCrcsA@mail.gmail.com>
In-Reply-To: <CAEf4BzZNc6RuhX278OTL4y6VDE16A-TtFXfOyo9tVJ=6hCrcsA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fbd3770-62ca-4fa2-62b0-08d9bf244388
x-ms-traffictypediagnostic: SN6PR1501MB2013:EE_
x-microsoft-antispam-prvs: <SN6PR1501MB20130E559DC87F6CEFE222A2B3759@SN6PR1501MB2013.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HktWVA0Ug8nrNbR2m1IwNm6PHFbKNdKSJc5L6XLppEp0bSKP3VIOxpR7nuTMv5cYdrdFiZNtm6t8cFxZkogtcNq9qXOo3/9bEEkMeQU9YtAoi9x6ZPl0c6M9BBH1U+QCi+Jdrf+D/gXRK9eQimRa1Fu5s/lBHPrgzidcHba4W5YCjTQhxappxNjn7JoH2v8jGwPtrbfW/fazF7AnzSgOj1Amf+ugnJ1I4djUqHfsBXeT4K/9dTcJJkwBEA34jHPRykqmUqNCRL7YSukm7nSvxiavO5oetlaeQPdbM2Yd1CmtKaG48eh++RRNKJVgkg1ptHdq5T7jfmR5WRZwD/YMELeiBDdhXHczwM0iRDk3QRfAlAxHEKzRJ2uOTC+XJK/PXhZ/02hcRksxyaOrs6XnvlDAxgS7aNi+Wvyla5aokEirHJ/QK9MYPu6hRXGF1A31Dz7TQu79OswT2UyyXFl0Cd9lFMIspTagu97GYI/BNzBVrx2Ku1a8/WqALMTspxgQhsOz5PCSTMf3RC9bEh+OLEc1Wek6cy6sgy4lIaBWqjO0bw8cajveD5HHAqt/7HQ0MW5U6cy+HenO5n+Yn5d4JaySKzxVoc5DP7zz8wSQ0l8J3IO7ZV7y49LgPUtvB+Q59P8PCM0WgiYmzTTvwkDCWE+PhfVACJjx/yvN7wnrm6ZZBG8HHPoqvrdSGjW4u5NR0586ejqmsbZLkRgsvrfYSgb3i0V8cND59wrpKseS7CxiNZ6oKQAYpGuGARzqCupnj7IiYL0vx8kwA4QTaKlnVYuv81vzdeXesuN5IpO/wPacDHkS2yzCzGObb9nEkEhdQ5ATGRRicZzlTCB13L5Yaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4595.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(4326008)(86362001)(36756003)(33656002)(316002)(54906003)(966005)(508600001)(186003)(6486002)(71200400001)(53546011)(2906002)(6512007)(6506007)(66446008)(6916009)(76116006)(2616005)(66476007)(66556008)(64756008)(66946007)(91956017)(38070700005)(122000001)(83380400001)(8676002)(8936002)(38100700002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UU9vUTJ5aXRSM1FwUi9BSHN3K0VtN2hlRStoMXkyWEdiSHRtZEFlZUNSSGRm?=
 =?utf-8?B?WWJ5TVE3VjA1TTkwYThGRU53cUFlaWxON2htYVZScVhOMms5Z2kwWVhMZFNv?=
 =?utf-8?B?K0RYSmY3L3ZPMXBuQVQwOHM1NEMxdGYzOWJtYVdRNGsweGxuWnBhSXE2WU9F?=
 =?utf-8?B?YW14UXdDM2JWZzhkWTYzNEFNSGpiVC9CQkxMWUExQm0xaWtmbElYa25YMEtM?=
 =?utf-8?B?M3NFR09IRm9NdXdGRUdnc0tyT3ArZ0d0dk5EOW5WSVJyNXdYcGxUbDlLc202?=
 =?utf-8?B?WWxCYlpxMTZVT2ZuV3pKU3NudTltbHMwSmZyUXNIdVBCbjNCUXczdDFXVU40?=
 =?utf-8?B?OHRndVdDYllqa3RaQ1FqbjJRYUFWZkNKbDBsbzY3TEFIanplRTczUkRPWWdW?=
 =?utf-8?B?RHQyRXUvL1l6QitRbnpnU2F3am5tYnlIckVvU2s2SEZTOU5pMk0rampPMFhn?=
 =?utf-8?B?NFpybUloWVdrbXZRbDIya05CNUFoSDY2YXBvQUVWcGhDOEp1aFVSUGJSMmZM?=
 =?utf-8?B?dFJVak5ydjBkbDZRM2FGbXBSWHJCMmJUL0xyaWhwSEhhSkkzQnBGYlV0Zmxv?=
 =?utf-8?B?bFB1SmpWNFk5MXZwRHlvQmpoei9OeTFJVkZXa3ErUndhMHZrZUd6OU9CQlNQ?=
 =?utf-8?B?UFZZM2xlNEFNdkE4VU16Yk5LR1lZdG1TL3pJQVlORkdoRWwwS0hnYkQ0Yldi?=
 =?utf-8?B?M2VBdllTejU2cHllSnpLQVRDMmFrcHFQQUJmOGo5a3U3WjIxZ2k3c0xrK2pp?=
 =?utf-8?B?c01uOGtVd2lIN21VQi9MWUh0MlI0empYVnJLR2ZUdHNPNHFzc0Y1UWdJTXFQ?=
 =?utf-8?B?dUUzcFZFeVdPajBNblA0d0NIT1FSZzNmc3Rtd1lCN1o0WE1UZ1FMcnlJbWVU?=
 =?utf-8?B?UTJ3dkhoOWVHZjlITUp6YlMzZDh0L0FCY1pCay9CVGIxM1dhQ2I0bUlBeEl1?=
 =?utf-8?B?K2IrWGhtMUtORUlIM3hZZEkrcTNxSkdxSXhnSzJsckVpdU5JSzMrUHhVU2g3?=
 =?utf-8?B?R3dKcm5lTWRhcXhqMGZUaXBwOVVrT0gyY2dmU1RMdXg5VjhoSk1GV05ITjRB?=
 =?utf-8?B?UEw0YktEYzVxcm1ZQzFTUHFxRW5kRERCV3NjV1ZyY3A4TUE3V3lRL3FoZGtB?=
 =?utf-8?B?dlBLdDZKTHhua2NjRGhJcEhLaDhZek5Pdm5EdnZnT1FrNTJETm52K0xGaVdh?=
 =?utf-8?B?QURiZXMyMGZ6R01xc3c2QzlReFdKR0gybVNUY1BuSUxXdGJHSElXVVBiVmZ1?=
 =?utf-8?B?d2pmNC9mWXJrMlFpRXVSMU1mUVZmeFhGcDJlOTR2UGZEUHJ0akhnbmdUaXph?=
 =?utf-8?B?NEdCMDlTTTVYNjNua2t2L0ttZ0szWEZFYjBGMGllZ29Odk81SWFZRm9keGZw?=
 =?utf-8?B?SDJ0SU9SL2xubG5XT216VXgxQ1gzQ0ZaUHVUVURXZGt6QUFYSEppMm5OUDFP?=
 =?utf-8?B?eFR4UnpySi8ybkxNQjNDTWwxTk9OQUs1cDI3ZHN3T1NiTmkySlFhaXVMN2dB?=
 =?utf-8?B?OFNHc1pvTCtpNDlJYmVtZWZJeWxzRzFBNWJFYnR4UFRpSVFJMVpHRm1RTzBU?=
 =?utf-8?B?NWtITDZ3NG9RSFJlUVU1cGxIVU5WQTJqNDVmMGZLUExZVlgwdHBSRmpqMGVT?=
 =?utf-8?B?a2s4Z2JMVk9tYXRBMUlPVndNSC84b2NWMlBtNysrMHkzSjBrbFkwRVR0bEVn?=
 =?utf-8?B?cWt4STMwRGROQjkweUVOUmJrM3hzSFpRS3UyTCtDTGUvZWJqNTlabGhrYTNw?=
 =?utf-8?B?YXIwUUZFY0Z0ckVvaFdBV0VYQWRNaFhGRXo5YmpJMGU2US9nVWI3bFVvYjJ2?=
 =?utf-8?B?OGVLVStoQ0k5cmdwTThPWEwrVWVkdFpKWXZ6eEJQWlFjbVFQejN6MENjVzRO?=
 =?utf-8?B?RVpyVkNleUlZRlpLeUp3ZldXd2FMMStMcndETzl3eW9ROER6VnVxd0VkSGNB?=
 =?utf-8?B?dytHVGtxbG5uQUhHUGlWWi9UNjN5K1FHNE1ZbGQ5dnE5LzNjZlVGQWQ1eXk4?=
 =?utf-8?B?a1BzODdMSjZBTHFzV205NDFSQzMrMDRpQmxMTmdLNWZEeTVibUMzL3U1QWdp?=
 =?utf-8?B?QThhN0xvUmNMZ2J0TUZmaUd0SDF0a00yTURUcWVIaUxPWSsvNWZ6VmVzc0Q2?=
 =?utf-8?B?NVB5a2hvNURVSU4xL3hBRVdVcEc5cU1vYkp6aXdJSk43dzl3Y2huWUwvN2lF?=
 =?utf-8?B?b0JCQnB4ZVZhRlk2K3BUTnVFa0RZWFRxNVlTclUxZDRvRWo0WW5udEJwVFlB?=
 =?utf-8?B?aDIydFBRSlRyS0FDZ0hDbmlvMi9nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E84F6083F4E014CA4490EDD50C23BB9@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4595.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbd3770-62ca-4fa2-62b0-08d9bf244388
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 17:07:52.1438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m6VgRoz+9lAMIeThpuW9XvfOnxz1OvbIiLJpR5Hap3EBWtw1I2zNoPitazv5OS33qYBTrWPk+b48O2ndu7KC8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2013
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Jw0_MbgPI1tQOuJjiiU61xcVSimAm5AR
X-Proofpoint-GUID: Jw0_MbgPI1tQOuJjiiU61xcVSimAm5AR
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_07,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140094
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCj4gT24gRGVjIDEzLCAyMDIxLCBhdCA1OjEyIFBNLCBBbmRyaWkgTmFrcnlpa28gPGFuZHJp
aS5uYWtyeWlrb0BnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBEZWMgMTMsIDIwMjEg
YXQgMTA6MjEgQU0gQ2hyaXN0eSBMZWUgPGNocmlzdHlsZWVAZmIuY29tPiB3cm90ZToNCj4+IA0K
Pj4gTWFrZSB0aGUgdmVyaWZpZXIgbG9ncyBtb3JlIHJlYWRhYmxlLCBwcmludCB0aGUgdmVyaWZp
ZXIgc3RhdGVzDQo+PiBvbiB0aGUgY29ycmVzcG9uZGluZyBpbnN0cnVjdGlvbiBsaW5lLiBJZiB0
aGUgcHJldmlvdXMgbGluZSB3YXMNCj4+IG5vdCBhIGJwZiBpbnN0cnVjdGlvbiwgdGhlbiBwcmlu
dCB0aGUgdmVyaWZpZXIgc3RhdGVzIG9uIGl0cyBvd24NCj4+IGxpbmUuDQo+PiANCj4+IEJlZm9y
ZToNCj4+IA0KPj4gVmFsaWRhdGluZyB0ZXN0X3BrdF9hY2Nlc3Nfc3VicHJvZzMoKSBmdW5jIzMu
Li4NCj4+IDg2OiBSMT1pbnZQKGlkPTApIFIyPWN0eChpZD0wLG9mZj0wLGltbT0wKSBSMTA9ZnAw
DQo+PiA7IGludCB0ZXN0X3BrdF9hY2Nlc3Nfc3VicHJvZzMoaW50IHZhbCwgc3RydWN0IF9fc2tf
YnVmZiAqc2tiKQ0KPj4gODY6IChiZikgcjYgPSByMg0KPj4gODc6IFIyPWN0eChpZD0wLG9mZj0w
LGltbT0wKSBSNl93PWN0eChpZD0wLG9mZj0wLGltbT0wKQ0KPj4gODc6IChiYykgdzcgPSB3MQ0K
Pj4gODg6IFIxPWludlAoaWQ9MCkgUjdfdz1pbnZQKGlkPTAsdW1heF92YWx1ZT00Mjk0OTY3Mjk1
LHZhcl9vZmY9KDB4MDsgMHhmZmZmZmZmZikpDQo+PiA7IHJldHVybiBnZXRfc2tiX2xlbihza2Ip
ICogZ2V0X3NrYl9pZmluZGV4KHZhbCwgc2tiLCBnZXRfY29uc3RhbnQoMTIzKSk7DQo+PiA4ODog
KGJmKSByMSA9IHI2DQo+PiA4OTogUjFfdz1jdHgoaWQ9MCxvZmY9MCxpbW09MCkgUjZfdz1jdHgo
aWQ9MCxvZmY9MCxpbW09MCkNCj4+IDg5OiAoODUpIGNhbGwgcGMrOQ0KPj4gRnVuYyM0IGlzIGds
b2JhbCBhbmQgdmFsaWQuIFNraXBwaW5nLg0KPj4gOTA6IFIwX3c9aW52UChpZD0wKQ0KPj4gOTA6
IChiYykgdzggPSB3MA0KPj4gOTE6IFIwX3c9aW52UChpZD0wKSBSOF93PWludlAoaWQ9MCx1bWF4
X3ZhbHVlPTQyOTQ5NjcyOTUsdmFyX29mZj0oMHgwOyAweGZmZmZmZmZmKSkNCj4+IDsgcmV0dXJu
IGdldF9za2JfbGVuKHNrYikgKiBnZXRfc2tiX2lmaW5kZXgodmFsLCBza2IsIGdldF9jb25zdGFu
dCgxMjMpKTsNCj4+IDkxOiAoYjcpIHIxID0gMTIzDQo+PiA5MjogUjFfdz1pbnZQMTIzDQo+PiA5
MjogKDg1KSBjYWxsIHBjKzY1DQo+PiBGdW5jIzUgaXMgZ2xvYmFsIGFuZCB2YWxpZC4gU2tpcHBp
bmcuDQo+PiA5MzogUjA9aW52UChpZD0wKQ0KPj4gDQo+PiBBZnRlcjoNCj4+IA0KPj4gVmFsaWRh
dGluZyB0ZXN0X3BrdF9hY2Nlc3Nfc3VicHJvZzMoKSBmdW5jIzMuLi4NCj4+IDg2OiBSMT1pbnZQ
KGlkPTApIFIyPWN0eChpZD0wLG9mZj0wLGltbT0wKSBSMTA9ZnAwDQo+PiA7IGludCB0ZXN0X3Br
dF9hY2Nlc3Nfc3VicHJvZzMoaW50IHZhbCwgc3RydWN0IF9fc2tfYnVmZiAqc2tiKQ0KPj4gODY6
IChiZikgcjYgPSByMiAgICAgICAgICAgICAgIDsgUjI9Y3R4KGlkPTAsb2ZmPTAsaW1tPTApIFI2
X3c9Y3R4KGlkPTAsb2ZmPTAsaW1tPTApDQo+PiA4NzogKGJjKSB3NyA9IHcxICAgICAgICAgICAg
ICAgOyBSMT1pbnZQKGlkPTApIFI3X3c9aW52UChpZD0wLHVtYXhfdmFsdWU9NDI5NDk2NzI5NSx2
YXJfb2ZmPSgweDA7IDB4ZmZmZmZmZmYpKQ0KPj4gOyByZXR1cm4gZ2V0X3NrYl9sZW4oc2tiKSAq
IGdldF9za2JfaWZpbmRleCh2YWwsIHNrYiwgZ2V0X2NvbnN0YW50KDEyMykpOw0KPj4gODg6IChi
ZikgcjEgPSByNiAgICAgICAgICAgICAgIDsgUjFfdz1jdHgoaWQ9MCxvZmY9MCxpbW09MCkgUjZf
dz1jdHgoaWQ9MCxvZmY9MCxpbW09MCkNCj4+IDg5OiAoODUpIGNhbGwgcGMrOQ0KPj4gRnVuYyM0
IGlzIGdsb2JhbCBhbmQgdmFsaWQuIFNraXBwaW5nLg0KPj4gOTA6IFIwX3c9aW52UChpZD0wKQ0K
Pj4gOTA6IChiYykgdzggPSB3MCAgICAgICAgICAgICAgIDsgUjBfdz1pbnZQKGlkPTApIFI4X3c9
aW52UChpZD0wLHVtYXhfdmFsdWU9NDI5NDk2NzI5NSx2YXJfb2ZmPSgweDA7IDB4ZmZmZmZmZmYp
KQ0KPj4gOyByZXR1cm4gZ2V0X3NrYl9sZW4oc2tiKSAqIGdldF9za2JfaWZpbmRleCh2YWwsIHNr
YiwgZ2V0X2NvbnN0YW50KDEyMykpOw0KPj4gOTE6IChiNykgcjEgPSAxMjMgICAgICAgICAgICAg
IDsgUjFfdz1pbnZQMTIzDQo+PiA5MjogKDg1KSBjYWxsIHBjKzY1DQo+PiBGdW5jIzUgaXMgZ2xv
YmFsIGFuZCB2YWxpZC4gU2tpcHBpbmcuDQo+PiA5MzogUjA9aW52UChpZD0wKQ0KPiANCj4gVGhp
cyBpcyBhIGh1Z2UgaW1wcm92ZW1lbnQsIG1ha2VzIHRoZSBsb2cgc28gbXVjaCBtb3JlIHVzZWZ1
bC4gQnV0IGlmDQo+IGl0J3Mgbm90IGF2YWlsYWJsZSBpbiBsb2dfbGV2ZWwgPSAxIG1vc3QgcGVv
cGxlIHdpbGwgbmV2ZXIgZ2V0IHRvDQo+IGVuam95IHRoZSBiZW5lZml0cy4gSSB0aGluayB3ZSBz
aG91bGQgYWJzb2x1dGVseSBkbyB0aGlzIGZvciBhbGwNCj4gbG9nX2xldmVscy4gSXQgbWlnaHQg
aW5jcmVhc2UgdGhlIHNpemUgb2YgdGhlIGxvZyBmb3IgbG9nX2xldmVsIGluDQo+IHRlcm1zIG9m
IG51bWJlciBvZiBieXRlcyBlbWl0dGVkIGludG8gdGhlIGxvZywgYnV0IHRoZSBjbGFyaXR5IG9m
DQo+IHdoYXQncyBnb2luZyBvbiBpcyB0b3RhbGx5IHdvcnRoIGl0Lg0KPiANCj4gQnV0IEknbSBh
bHNvIGNvbmZ1c2VkIHdoeSBpdCdzIG5vdCBhdmFpbGFibGUgd2l0aCBsb2dfbGV2ZWwgPSAyIGZv
cg0KPiBzdWNjZXNzZnVsbHkgdmVyaWZpZWQgcHJvZ3JhbXMuIERvIHlvdSBoYXZlIGFueSBpZGVh
LiBSdW5uaW5nIHN1ZG8NCj4gLi90ZXN0X3Byb2dzIC10IGxvZ19idWYgLXYsIEkgZ2V0IHRoaXMg
Zm9yICJHT09EX1BST0ciIGNhc2UgKHdoaWNoDQo+IHVzZXMgbG9nX2xldmVsIDIpOg0KPiANCj4g
PT09PT09PT09PT09PT09PT0NCj4gR09PRF9QUk9HIExPRzoNCj4gPT09PT09PT09PT09PT09PT0N
Cj4gZnVuYyMwIEAwDQo+IGFyZyMwIHJlZmVyZW5jZSB0eXBlKCdVTktOT1dOICcpIHNpemUgY2Fu
bm90IGJlIGRldGVybWluZWQ6IC0yMg0KPiAwOiBSMT1jdHgoaWQ9MCxvZmY9MCxpbW09MCkgUjEw
PWZwMA0KPiA7IGFbMF0gPSAoaW50KShsb25nKWN0eDsNCj4gMDogKDE4KSByMiA9IDB4ZmZmZmM5
MDAwMDU3MjAwMA0KPiAyOiBSMl93PW1hcF92YWx1ZShpZD0wLG9mZj0wLGtzPTQsdnM9MTYsaW1t
PTApDQoNCkZvciBjb3JyZWN0bmVzcyByZWFzb25zLCB3aGVuIHdlIHByaW50IHZlcmlmaWVyIHN0
YXRlLCBJIGNoZWNrIHRoYXQgdGhlIGN1cnJlbnQNCmluc3RydWN0aW9uIGluZGV4IGlzIHByZXZp
b3VzIGluc3RydWN0aW9uIEluZGV4ICsgMS4gSW4gdGhpcyBjYXNlLCB0aGUgbG9ncyBza2lwcGVk
DQpQcmludGluZyBvdXQgaW5zdHJ1Y3Rpb24gaW5kZXggMSwgc28gdGhlIHN0YXRlIGF0IDIgaXMg
bm90IGFsaWduZWQgdG8gaW5zdHJ1Y3Rpb24gMC4NCg0KPiAyOiAoNjMpICoodTMyICopKHIyICsw
KSA9IHIxDQo+IFIxPWN0eChpZD0wLG9mZj0wLGltbT0wKSBSMl93PW1hcF92YWx1ZShpZD0wLG9m
Zj0wLGtzPTQsdnM9MTYsaW1tPTApDQoNCkluIHRoaXMgY2FzZSB0aGUgdmVyaWZpZXIgc3RhdGUg
aXMgcHJpbnRlZCDigJxvdXQtb2YtYmFuZOKAnSBmcm9tIGluc3RydWN0aW9uIGluZGV4LCBzbyBJ
DQpkaWRuJ3QgYWxpZ24gaXQuIE5vdyB0aGF0IEkgdGhpbmsgYWJvdXQgaXQgdGhvdWdoLCBJIGNh
biBkbyBhbiBhZGRpdGlvbmFsIGNoZWNrIHRvDQpzZWUgaWYgdGhlIGxpbmUgcHJpbnRlZCBiZWZv
cmUgdGhlIHZlcmlmaWVyIHN0YXRlIGlzIGFuIGluc3RydWN0aW9uIGxpbmUgYW5kIGFsaWduIGl0
DQpjb3JyZXNwb25kaW5nbHkuDQoNCj4gZnJvbSAyIHRvIDM6DQo+IDsgcmV0dXJuIGFbMV07DQo+
IDM6ICg2MSkgcjAgPSAqKHUzMiAqKShyMiArNCkNCj4gUjJfdz1tYXBfdmFsdWUoaWQ9MCxvZmY9
MCxrcz00LHZzPTE2LGltbT0wKQ0KPiANCj4gZnJvbSAzIHRvIDQ6DQo+IDsgcmV0dXJuIGFbMV07
DQo+IDQ6ICg5NSkgZXhpdA0KPiBwcm9jZXNzZWQgNCBpbnNucyAobGltaXQgMTAwMDAwMCkgbWF4
X3N0YXRlc19wZXJfaW5zbiAwIHRvdGFsX3N0YXRlcyAwDQo+IHBlYWtfc3RhdGVzIDAgbWFya19y
ZWFkIDANCj4gDQo+IA0KPiBObyByaWdodCBhbGlnbm1lbnQgOiggV2hhdCBhbSBJIG1pc3Npbmc/
DQo+IA0KPiANCj4gQWxzbywgeW91ciBjaGFuZ2VzIGJyb2tlIGxvdHMgb2YgdGVzdF9wcm9ncywg
cGxlYXNlIHNlZSBbMF0gYW5kIGZpeA0KPiB0aGVtLiBUaGFua3MuDQo+IA0KPiAgWzBdIGh0dHBz
Oi8vZ2l0aHViLmNvbS9rZXJuZWwtcGF0Y2hlcy9icGYvcnVucy80NTEzNDc0NzAzP2NoZWNrX3N1
aXRlX2ZvY3VzPXRydWUNCg0KVGhhbmtzIGZvciBwb2ludGluZyBpdCBvdXQhIExvb2tzIGxpa2Ug
dGhlIGxhdGVzdCByZWJhc2UgYnJva2UgdGhpcywgSeKAmWxsIGZpeCB0aGlzIHJpZ2h0IGF3YXkh
DQo+IA0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3R5IExlZSA8Y2hyaXN0eWxlZUBmYi5j
b20+DQo+PiAtLS0NCj4+IGluY2x1ZGUvbGludXgvYnBmX3ZlcmlmaWVyLmggICAgICAgICAgICAg
ICAgICB8ICAgMiArDQo+PiBrZXJuZWwvYnBmL3ZlcmlmaWVyLmMgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMjYgKystDQo+PiAuLi4vdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMv
YWxpZ24uYyAgfCAxOTYgKysrKysrKysrKy0tLS0tLS0tDQo+PiAzIGZpbGVzIGNoYW5nZWQsIDEz
MSBpbnNlcnRpb25zKCspLCA5MyBkZWxldGlvbnMoLSkNCj4+IA0KPiANCj4gWy4uLl0NCg0K
