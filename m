Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C8C4E1AC6
	for <lists+bpf@lfdr.de>; Sun, 20 Mar 2022 09:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbiCTIpK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Mar 2022 04:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239450AbiCTIpJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Mar 2022 04:45:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E067419AF
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 01:43:46 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 22K79XLN012008
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 01:43:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=JrQk1sizRYGHEIHZ5rOOdTZ4/xya0fqN11X+TznVNGA=;
 b=YxGZn+/Zn6mnAwUgDI5O+uhpYC3OSYqhrM5g1cEe3tpemsL10HbJvKu/qyWgkwp+T+1V
 UkVHW3bQzqTz2eKrrL+a/THQJzCfyGLUleO/K0PZVM06sZ86E15DORkIcZfmgny6S6th
 zVEgwM4JTlOS25yCcp/qSNyWX4RMLh0mXH8= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by m0001303.ppops.net (PPS) with ESMTPS id 3ewauv4039-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 20 Mar 2022 01:43:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=na7UDKqQKJfga0JdLRmVm2ZX0mWQKBOVv+wJPPGF4WJPiWzuZdq+XgUN0YK3/VqoLmdu2mRJsS8V4cPHfWGHagHjrKEI/qXyyKaEXkzntAIui+uHiaN+/sEmFw9ZugPFyldxv0YqPpoF60L/HTirCsi9dZTsvkWs1kdYaDKpWsmN5DYOLy1qCDAMJakCV3qo5JIRQE/rvtFBqdXlkmtBvXmUbOZgUa1a1+k6i1Dv4vZNntJhwyy8IPNjEibsFH+H7HKtpf3eYhLY6NxBJRrOLbh/NYCGV/XBGdvY+paaGgE3l5hYWbi+vAJKOHSUVBAoQ6yHnz0MoeI6/rOldzdOrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrQk1sizRYGHEIHZ5rOOdTZ4/xya0fqN11X+TznVNGA=;
 b=PhTfr4VKdj4Yj40py5dBeG5JMVY2GtN3j2e3py282+WtRUBDGW7dx4Fn272hM44ZgwRy7yKTDef7195a+Nltde8e259La2ZTp2aw/8jDTLCC7NllhVe9x6OmmiXgZOblTxSM0r5RDjzjnJVF4fJP75fzQOsw0lOIR1k3E1lKJQxAiRUL/m2OYLC4dpU3w2yajPUZaGNHE/FBBUbRNSzJ9G1OtP4xsrM+SEvMichYC/J8mQpLHScG7CruvfZsubMQDscHAUkPXb8nr1HCeY2F2LMf/RwY21+I5SUto00ISoBUx4rYV9n7ZGJXPuk38Y/vyA5/8VxN+FTA62fr7BXcIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by SN6PR15MB2272.namprd15.prod.outlook.com (2603:10b6:805:26::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Sun, 20 Mar
 2022 08:43:43 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::20d5:ab50:fdf7:2a9a%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 08:43:43 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 4/4] selftest/bpf: The test cses of BPF cookie
 for fentry/fexit/fmod_ret.
Thread-Topic: [PATCH bpf-next v2 4/4] selftest/bpf: The test cses of BPF
 cookie for fentry/fexit/fmod_ret.
Thread-Index: AQHYOM8OpJQnsOVPvkOPwXHx8l28DqzFiQwAgAJyigA=
Date:   Sun, 20 Mar 2022 08:43:43 +0000
Message-ID: <6443c7fc6801f57d485d61d846bafda69f7cde73.camel@fb.com>
References: <20220316004231.1103318-1-kuifeng@fb.com>
         <20220316004231.1103318-5-kuifeng@fb.com>
         <20220318192114.pacmegfl3uglju6l@ast-mbp>
In-Reply-To: <20220318192114.pacmegfl3uglju6l@ast-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 171ff258-c280-4c67-bd70-08da0a4dbd56
x-ms-traffictypediagnostic: SN6PR15MB2272:EE_
x-microsoft-antispam-prvs: <SN6PR15MB22726C267615C7ABB23BDC76CC159@SN6PR15MB2272.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sBJ34+orxgolpM2u75LdLKvJgg6W1UCdxMUg4SBarLC4pu9IJJ5JWfkwAbZUBMt8WGIslIAxqpkR4kSfdO4Ij87v0IA85jECWQyAXsr6+6ZV2k8V5cQsc46gLcEzQkqzQq+/2ZsHrZCtyUw+gNmjden/4xW7AHh1eAPsQZvFKHF+ZHGT3jPwvJ7B5q66qmpD5amhk4mM82AjuWuJmcPsZe8obSLaVrT7ZNgcXILviCKfNA0B5g3cMTxlaPZs79TOvFphltZuD9PE4/DZUTpnq32tw4qE6QM2x3vH24fxnN3P3oSK06ZLc3LUeGKScqZ5w9MTEHdcRntkW5NIN/UpDq/y7dBDdYB+TvMr0tnChzwdJgHnm8GTIdJx492uFQkV2S+FGfE6AvdYc9zPkJUSZkYomIxxUomrHnpexT3IPTqGg0Ea6gJTm7ILJ75R0aqp3uZh01vnErv8qDcWQqFaborRFFNpH4i+7WRZ/tuyq5SxoEucUQcQtJbgrP2pXWAwTSeD1zpT4eiFeTCHCnn8Sx28Z4Rq6PbAH+n+N3AL2EcJYE6JzkBmFiVVfyUjMCd2OG88TCV3mtSLaTMf1M1oyZh8aQGX0MRyTYFzR1aP2jn6vORATK6vOmooLGUG69xJbuyGy65JBqCUrTULjhLVRDCXvL/TrIGguxf8L2DCFxxecJjPzviULkoJn9Jw5QeJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(4744005)(71200400001)(6916009)(36756003)(508600001)(38070700005)(6486002)(86362001)(122000001)(316002)(76116006)(66946007)(186003)(2906002)(38100700002)(64756008)(66446008)(8676002)(66476007)(4326008)(2616005)(54906003)(5660300002)(6512007)(66556008)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDVKTkFsTG44b2RYQ1dpTXYva1pYdmFjbGZVRmhWS0U4N0VITXoxTXUxdXVY?=
 =?utf-8?B?NjlLeFBrTm03NmZYODZ5Y28xMWhZSEVFdkxZZFhZUEJQdG53OGN0YWFsSkEx?=
 =?utf-8?B?RDNhOS9jeVlVNjBXUzhYSk9lTGVmR1JVWjNtdXVwMVhiQTh4WDIxWTRmRCta?=
 =?utf-8?B?UVBLbDJlUFBVRUZvTmk4bHhjUHFNUlI0bTJjMVZRUld1aGNVOVFMbnNWemU0?=
 =?utf-8?B?RjhraTkreWNjV1pvN1YrWWE4V1UyVFlOS01tdkFGOURMT010OERGc2Roclhp?=
 =?utf-8?B?T052eHF4bVhrNllQWDA0QzZtMFVxWTZVY2NGQzNad2J5WVdXVmgvMkk2a2ZB?=
 =?utf-8?B?eUh1Vk5IWWU3aFYxZS8rdE11TUpFWDBVZ1lLMWk1QUZSTVZkS3F0NVJzOFBG?=
 =?utf-8?B?aWsrMzFkODhYM0JtdHFHSnhLMFk5dzBLbjdwTXpMazZUSHFOZElXVFhqQzJT?=
 =?utf-8?B?UEZBQ05KeFZwV3ZYcU1jMXZhK1ovQUtrbnZncElvNzhHV0FKSVk1MmJ6UGYw?=
 =?utf-8?B?bC9IVWd3VTJ3RnBObGFEb2N3eHVrOGs1N0IrQ2dvWFU3bnR2VXEzMlRqRG5V?=
 =?utf-8?B?UGFzZUY3VlIxcm5kVEZKemVENzJZcDNJWTZwSTNkRm51c0VxMDJXcklUcWFy?=
 =?utf-8?B?V2hMNkRGRXdGdlBVdG9OaHhicFdXS0RBQUxDTTJFTjlvWmtROFI5UWlCK3kw?=
 =?utf-8?B?RzI4T2llYjFEMVJFdW5rSTdpcjdkbHMzdTl5S0lQZXZoRmUxcXZ1cGIyVWV4?=
 =?utf-8?B?OHVHRlNWREh3S1IvTHpUNkRDMHNMY3ZYTWZOMGFKV1A4bC9JOWw0ek9vYUQ0?=
 =?utf-8?B?czBCZE1TZ2wvNW0xaDhWTGgzZjliVjZRTG1scm00SVdaS0pNQXZJUWt6SjJ0?=
 =?utf-8?B?Mzk5OEh6cTJNRUk2eGNFK1lLc09ZdUJyYUcyVWxscW9XVEMxUWwyUThRK3pW?=
 =?utf-8?B?azRIWjFKckVhTWdQbG9XVnhJWnQ2N1I5bCtGZE1wZlVlZUUxbFZGaFNNMDdI?=
 =?utf-8?B?R3lqQ3prMENBd3RldjE1azdyREpsZmg3cldvbTZ5YVpxMUd0bDlpdmdnY3dC?=
 =?utf-8?B?OEphdHM5OU9LVGpyRFZxMTZEV01SMlJCeEtEK1oyaTJ4a0pJY1NPL0pTeDNs?=
 =?utf-8?B?SUhZcVAyTmlOZk4vRGJuZDQwb0ZCRG15NzFocTFVTVJlckxxek9yMGc0VTlJ?=
 =?utf-8?B?T0FqdlpKaXIzNTZJa28zcVowV2orNEV6S3lhUW9QdmZOQ3gvYnhNWnhNMGRK?=
 =?utf-8?B?ZGcwc01JZHFIZ3UvM2pXRnNXOWdmcHU3SDkvcExoRUNnSTdTSTd2Y1oxa0RH?=
 =?utf-8?B?SzdXUTk5UDBMd01TYVRSV0k4Q0xXU0tLSFdvNW5sS29jS05TeTM3Z0Jvclla?=
 =?utf-8?B?ZlFJOGdhdGVIVm5wSmFyNmlFeE5kWE9xRjF1N0dRcEJjZVpjWUpLWVVPaVcy?=
 =?utf-8?B?WC9NamVtYklKSFlkUDh2b243ZGZBL3NJcUpQQkRJL0JnT0h6UUxqbnZHWkdh?=
 =?utf-8?B?WW1oazNIdDJaSDRONXh0VzJUVUZ0aHJQK3htQmVrK2JHcUptK0k3NVF1RFRJ?=
 =?utf-8?B?OHBFaEZWUkNBY0VnT29wTG5BT0RzUGVvU210Z0JRSlZiZHdlZk9OZHdFZy8v?=
 =?utf-8?B?Z1hLckxtR09vaW5XN3RHSmFmdUxFTmtjWkl2T2VmdVZpRSswT1pFT3N2OXBG?=
 =?utf-8?B?dmtORWVtN0ZtS3JVOGFKTzNtRW1Fd1Bwa2VwbExTL2FQWTZuTFhxZU5zdDZq?=
 =?utf-8?B?RkthU1UwZGI3VjduNHRCeHBsZXZHRUowYnZ1K01TREszQlNlNDB2RFoyZXVp?=
 =?utf-8?B?ZXkvRUpwUi81RXJ1dHhXb0RETXBsWUFBQTNnQmcvekQ2WVQxUzFSZDRCaUZo?=
 =?utf-8?B?bDVXYTFkWE1IRklEeGtzMFh3L1FKSHhjc3pNTHg1TXBqMkpkdTZpdC9OQmVw?=
 =?utf-8?B?S1ZtSmE4QnZJNFhBS3RNZFp5UEhlSnEzYm9iS2s2RUxpOGpsQlBQMmdKZjF0?=
 =?utf-8?B?QWg1QUZWU0lRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <113E022F61654C4BA6C5982A50C9209B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171ff258-c280-4c67-bd70-08da0a4dbd56
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2022 08:43:43.0903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1leBDHxrds5dRjcvpf2X8RDlLwHLb2X5yth8KnKI7scxZZfQB0Hk8U1hOkmBIOjR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2272
X-Proofpoint-ORIG-GUID: Wn2ld6-VT7-5SbMzTKBnE-plCP3nb-lQ
X-Proofpoint-GUID: Wn2ld6-VT7-5SbMzTKBnE-plCP3nb-lQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-20_03,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gRnJpLCAyMDIyLTAzLTE4IGF0IDEyOjIxIC0wNzAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6DQo+IE9uIFR1ZSwgTWFyIDE1LCAyMDIyIGF0IDA1OjQyOjMxUE0gLTA3MDAsIEt1aS1GZW5n
IExlZSB3cm90ZToNCj4gPiDCoA0KPiA+ICtTRUMoImZlbnRyeS9icGZfZmVudHJ5X3Rlc3QxIikN
Cj4gDQo+IERpZCB3ZSBkaXNjdXNzIHdoZXRoZXIgaXQgbWFrZXMgc2Vuc2UgdG8gc3BlY2lmeSBj
b29raWUgaW4gdGhlIFNFQygpDQo+ID8NCj4gDQo+IFByb2JhYmx5IG5vIG9uZSB3aWxsIGJlIHVz
aW5nIGNvb2tpZSB3aGVuIHByb2cgaXMgYXR0YWNoZWQgdG8gYQ0KPiBzcGVjaWZpYw0KPiBmdW5j
dGlvbiwgYnV0IHdpdGggc3VwcG9ydCBmb3IgcG9vciBtYW4gcmVnZXggaW4gU0VDIHRoZSBjb29r
aWUNCj4gbWlnaHQgYmUgdXNlZnVsPw0KPiBXb3VsZCB3ZSBuZWVkIGEgd2F5IHRvIHNwZWNpZnkg
YSBzZXQgb2YgY29va2llcyBpbiBTRUMoKT8NCj4gT3Igc3BlY2lmeSBhIHNldCBvZiBwYWlycyBv
ZiBrZXJuZWxfZnVuYytjb29raWU/DQo+IE5vbmUgb2YgaXQgbWlnaHQgYmUgd29ydGggaXQuDQoN
Ckl0IG1ha2VzIHNlbnNlIHRvIG1lIHRvIHByb3ZpZGUgYSB3YXkgdG8gc3BlY2lmeSBjb29raWVz
IGluIHRoZSBzb3VyY2UNCmNvZGUgb2YgYSBCUEYgcHJvZ3JhbS4NCkhvd2V2ZXIsIGl0IGNvdWxk
IGJlIGEgdmVyeSBjb21wbGljYXRlZCBzeW50YXggYW5kL29yIGRpZmZpY3VsdCB0bw0KcmVhZC4N
Cktlcm5lbF9mdW5jK2Nvb2tpZSwgZXZlbiBLZXJuZWxfZnVuY19wYXR0ZXJuK2Nvb2tpZSwgcGFp
cnMgYXJlIGVhc3kgdG8NCnVuZGVyc3RhbmQuDQpGb3IgbW9yZSBjb21wbGljYXRlZCBjYXNlcywg
Z2l2aW5nIGNvb2tpZXMgYXQgdXNlciBzcGFjZSBwcm9ncmFtcyB3b3VsZA0KYmUgYSBiZXR0ZXIg
Y2hvaWNlLg0KDQo=
