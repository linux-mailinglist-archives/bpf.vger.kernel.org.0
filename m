Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C00513DB3
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 23:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbiD1VjI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 17:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbiD1VjH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 17:39:07 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CADC0D22
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 14:35:51 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SLRtp5016596
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 14:35:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=RzjGN4GGx0ixILFVRUni1wEGTNrOa3oQF42f9YKulAk=;
 b=Rxutki9I/PVTsjVVVRZf5GxW2N5a/hSUemNXqV/BLxLRZJqCPgLFS4sarOG13lt2mXA3
 nDvkOUW4ChJzokJ/B3TI3HX/FX+9tt3O1QKMUekLYuCVZPISPhbZcL8FnOquErv+aQAa
 ++5aeqP8h2HvL9yvhNhoD2cX4zI/zh2DYGA= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fqvxxu77e-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 14:35:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TikTw0of77kwelMtbja3QwMv/05T5jkOSjemPpjowVD1S/Bg0whVuJGUCMrDH4K78U0saMNK4besP9jYoJs5Yvrgwu9NK6D0NhGq4wYM2SaPeo/hKvbfhKllvWQFF+SzoHJsF7yaIbouIK+RRoNVv2/rOBFv0LZNKgIbJfnetUZQAcoOFZtpbGE2f6XdItikFyrGuYk4yqPmawhpxThvOAS9OWc4ZK+HHP4TlrZSuFsFw8dOEcbchP7AWEunreJmEKxVCIN3ZWhM/fyA8G+imBwWDkBq4EAdozqYbZnF9eRbFiulbiOkZlnR0m61XMxyALiTsfOsNw+01Xaft89DnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzjGN4GGx0ixILFVRUni1wEGTNrOa3oQF42f9YKulAk=;
 b=kYuPH3m+6Y7vYfsEklwQguq5IoKArhbPosoitjRnWv70TP54UeF5Jkg84Ph4/SdSW/3T0d3ObHU2pUi2OSPebLLatfY0iN3u02Bf/bUqSxLrMqXPjvN88iSpTBZtRX+rKCefFVU/xhmkfvAs1ESix4salkJ8EmW+LWvLiLqDmwuTqPOUczY469vx6INMam4/vr+vres+EkFFN7a7U3Gm+jJtzt0OeU6oGZr4jovgB6B5sSI6Nx19SL04d9UyrhSMNkKUwfGXAkt5PNVFDC+Z7BIdzr+c1Rl+4XasBlHqKSrMpH3pCHOIKV4tBHiUfUky3QwSjrH4235Ur/viO/C2/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM5PR15MB1867.namprd15.prod.outlook.com (2603:10b6:4:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Thu, 28 Apr
 2022 21:35:47 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%4]) with mapi id 15.20.5186.020; Thu, 28 Apr 2022
 21:35:47 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/5] bpf: implement sleepable uprobes by chaining
 tasks and normal rcu
Thread-Topic: [PATCH bpf-next 2/5] bpf: implement sleepable uprobes by
 chaining tasks and normal rcu
Thread-Index: AQHYWyCPxeAlzkBqGUmwvbIxciSxYq0Fop2AgAAOPgCAAB5ZgIAACPuA
Date:   Thu, 28 Apr 2022 21:35:46 +0000
Message-ID: <cfa1255715f0fb86d699d54300b36083a68d66a5.camel@fb.com>
References: <cover.1651103126.git.delyank@fb.com>
         <972caeb1e9338721bb719b118e0e40705f860f50.1651103126.git.delyank@fb.com>
         <CAEf4BzYBFFtHLerimNF5ZKXa6keyb6=NfPq-5YSoPymmrc820g@mail.gmail.com>
         <c9a7e3566dc9f7e8439ab8404830847e8a960a84.camel@fb.com>
         <CAADnVQ+9axVKfyx-cCJW1NsVTcEp8BEUoAsXYiegEOsG3jmEww@mail.gmail.com>
In-Reply-To: <CAADnVQ+9axVKfyx-cCJW1NsVTcEp8BEUoAsXYiegEOsG3jmEww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dac74d3a-f693-413a-eed8-08da295f0ea1
x-ms-traffictypediagnostic: DM5PR15MB1867:EE_
x-microsoft-antispam-prvs: <DM5PR15MB18673FBD8DC2EF58BC7E62BFC1FD9@DM5PR15MB1867.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xp8A4x0umVeHgwcgtcI04q1gWxyWRZBW1E2Sp7bienlv/542zmxJ2MWcElFsyJpdxLdz+I4927Be97W4c+Fy4me4QHS99BBSJW+QbdX1JUL3Gtx8FdXtRh7slfE0FOt7bJ6B39efUOGu91GE6ONudA+UQf0xHWP8FCAZkxPEAvrFjjPUu/3wBbksqHZOQ2J4cz4WSqMU3B/gugKQj5TuACoeHuFJPviDVF6D2rtGplKi9XzCpE5LN+GjnEQa9qCj9B3Jj5B0QxKc8pFZHcXFCTtnXV0zqkmdJlrx+K4wEZHj+vi4d5VmHXZ9uG/26ungBwXeiJqCALzTBfJ9qhTmCza1AUN6SV/b0HBRLqhBK82egy/gnXNV+j8cUkrESTSn+jfOAloP3ht4WvB7zd+5ZS9hg/uLqeXXBsdZil+5G3xcBJHsF+4YIkvYpgEk9bvW5eLPL9bCHFfyD0vDvfepxUM5xqLpEvY9nf+YYRdoSXj3R7Uvt+M3iCAcOPh12T3jAelIwp9Dm1EOgWboXvQhCNlAH9VCsWhiKPON3Rod9nP1oIJZ00Snzx7lCa7jenJJm6SYU7DyYZlsWqTNEDSbZFI4PETF/GL95hlNgb0oQLCvB7n11oqGCQe6pEpyw+xFq2oajbRvnL6urghw5zEJn2HV8VyQHaH/RTTciHNQeCsln35TTQOZvrgy26i91lQszRlvs6ThkMyDTA5BGOOQlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(508600001)(316002)(36756003)(5660300002)(8936002)(54906003)(76116006)(6916009)(186003)(6512007)(86362001)(8676002)(66476007)(66556008)(4326008)(66446008)(38100700002)(38070700005)(71200400001)(2616005)(122000001)(6486002)(2906002)(83380400001)(6506007)(53546011)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ymg0QkpMSmJoZzVSUWZsTHN0bjBGUDRnN3k3bHdiUzlUSjBWZmZjN045bkxo?=
 =?utf-8?B?NlhyL2ZFQnNlV1kvRkg0WFJUQ2RXa2hSZysyOHZwSU9MZDRhTjViMmw2TXZF?=
 =?utf-8?B?QVdSNStubkd4WFdGZFk2SjV6WHYzcERMZXNFMXhtK3dVNnpQb1ZYVjVLR3hQ?=
 =?utf-8?B?dExrRkRlcFNRTWhsK1hEb3V1a2JET2lWNXZvYnk3RHZQV2JCUXVVTGF4THVs?=
 =?utf-8?B?V2lxRmxCSWZwRC9mMlp4S0x1UjhOYWhaL1ZxL2RyWHQ4dHY4dVRDenlGVEVN?=
 =?utf-8?B?OGhRbUU3eFIxRHVXdjhGMzc4ZE1UV0h3b1RodjBNblgzemNrU1hQeU1LbDVn?=
 =?utf-8?B?T0ZoU0hxWFVqbThiOW10dFZUZytyUkNsaE5mcjlZN0doYWNIMVB4VHdGOW9u?=
 =?utf-8?B?eU1DU1BYODlzb09RZWxvT0UxS0pHK1plb2d0SHdzWHVCeGFFNjBRd0JlWEE1?=
 =?utf-8?B?UjkwakZMRTNYM0h2TUs4VHFyeTRaamp1RjlUMUQ1bm5lM3lyUXRkWWFaK04y?=
 =?utf-8?B?UmxkYlVYekFIczlXU2hidVhEeGJHbGZlNzBXbUpYSGpaeEhRMFkzK1JmV1Fx?=
 =?utf-8?B?b3dhazdEajFOdGVoUEJhUytDWFVOR3Q4QVZ6OFB3VmxRUHZZNFQ1RXB5Tlcr?=
 =?utf-8?B?cC9RQklITlBjWUNrOExDOHQwVzlRUjNMVmtweVdNbzc0RmJCY0E4aWlQL3cw?=
 =?utf-8?B?V0tHV1ZvN1NUckx6Q0E4U0VKaGtKZTJvNnhRSFFxZW8wQU1sUGdIMFFQTHR2?=
 =?utf-8?B?WHRoUXduc05CWFB2NHR5OUlFNlhMdjIzeEJJQjZLSUhYbGRVN25jZjdIQUNx?=
 =?utf-8?B?RVFmdVAyOFNVSXJHeXFhSVVXWnhpSzhtcDA3T3lkZ0tRSm1tZmNnVUpjNkNJ?=
 =?utf-8?B?S3Rtb3BoR3ZOWmZMcDhsMGZEVzRPK1FDRE9zR1ZyMFJuYUMwSzFnTmdhRExB?=
 =?utf-8?B?OGk3NkEwTTg4YUErMmhOdy82U3pLUW4yQ0FtN0hhR2cxdDBNUm5CVE9Odi9t?=
 =?utf-8?B?RXQ1NCs0eHlZUzFZd0lHL1N3ektjZk5PWURKM3I1R2pnV0JnVjNXTzVsS2ZV?=
 =?utf-8?B?VzNoZ01DRjRKdXEzVkdzd1FaOFZVM1FKREdobmJEWTYwTFZSVUlQNEhxTCs3?=
 =?utf-8?B?bGhOaVVla1JVaVVQTmhTUWduT2FRMUFoVUs1RHRWM1luQkRrbjRybnZxVStj?=
 =?utf-8?B?WFV0TGdjc0FESThMQ2hUWThqUFRvSmdCRWs2bFhnOVlYZFBwNFJOVk4yVmJT?=
 =?utf-8?B?S3BsbHVMb29qV1UyL1ZDbVZ1QTBGWkNnQ01jNzNUVkRCb3loNDFCSUtZS3dh?=
 =?utf-8?B?SEY0bWlZcGlTbVBrRVR4L3RGVGV4SWlkdEhPcHpwcFRrN3VmYWJNbExOS0U0?=
 =?utf-8?B?YzZ3ZG5XclVSUkVUeUZWL2FJM1dRWGl5Z1czaUZwVlpwcGVOekJqb2UrdjFC?=
 =?utf-8?B?bm9VNGwyb3A5ZUJtaG5KQk1la2ZHTVkyWXZOcDJJL21GV3hyclNIZEFVdVVw?=
 =?utf-8?B?cTBXeVZyUjhTNFYyaUl1RkFJM2gxVjBDU1hBL3RiR3BlS3l0Z1YxeE1WRGpl?=
 =?utf-8?B?aVVsNUJwQUdIUDJOUmJQU2w0MzRPRXdiTkJOYkw4RkIvTFJPSWw0TlNRZ05o?=
 =?utf-8?B?OGY5d3UrWUUyQThmNC91ZjFkaVhXckMwc0NPYWh2NndaZUtuUC8vdURTRzNJ?=
 =?utf-8?B?b1daS2hIZlp0WW4xSXZ3bElVZjhrYWZPNnpFekt4dUJURzdJc2JYMHFyQ1Ay?=
 =?utf-8?B?REQ2VVBRN1NWZFlVM0pKT01LekIwVjRkQjBPWVZnOW0xS2VYT1V0TEx1d0FO?=
 =?utf-8?B?NTBwYmVrd3N6cmN5VXNrY2ZwZTVKT0RrZkNpaitra1ZvcVRIWldNVloxL2F0?=
 =?utf-8?B?NDBqOWpkK1RIUUw4MkRaajdVOWpZckZNemRkVnc2NzZCZHZnT0srM2Z4U2g0?=
 =?utf-8?B?OVBUdzJuSFZvTTAwM0FkeTFlWVhqbHBZTHBzVEFOWWZLOWduazF3OVZMYlM2?=
 =?utf-8?B?cWE5TFdLNDFMbGx5Znlma2xMQUx3NmZhRnR2a1VsbE5OTm9XOFQwZEtKd3Z0?=
 =?utf-8?B?OGxZRmtBYTRWRGNBNUdYMW9ocjZBWDJUQzVHTFA1UkJvRSsrUlhhdXB6UzJS?=
 =?utf-8?B?a2JYZE5remRHMWNqak5BZFVacGtJSTlHOXoxTkxTM3JCSTZIcHBkSC9CbkI4?=
 =?utf-8?B?eEVIZGdtUkdTalQ3N1lSTU9LbWwvZlRCeGczdGpYVUxTa1d6cXkvc0xRUERN?=
 =?utf-8?B?a3ZGRTlBODI0NVJJY0Nob2pncGkxaE9tQW1JVzRkcmordkd3QWJKVnc4d0dM?=
 =?utf-8?B?ZDVXcklYQTh4RG05SEpqbXVNczJqalpYOHNQNHByTVp3cE5NSFU3WHlGenNz?=
 =?utf-8?Q?4r2n8Lok4c2VqkMkcLvXICdpkM/ZlCUuI5Hrf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F38843A32D0E494A85A47C0C75D3286E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac74d3a-f693-413a-eed8-08da295f0ea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 21:35:47.0003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJHCcg5+6whJgJL0B9lY6VHawePVNosL2iDDQ8Mti+KnS1T8YaZ0ySl+WacOQBz6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1867
X-Proofpoint-GUID: GxovhU8vhnTgbB6a4aOefAJl5b4ryN5r
X-Proofpoint-ORIG-GUID: GxovhU8vhnTgbB6a4aOefAJl5b4ryN5r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-28_04,2022-04-28_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1LCAyMDIyLTA0LTI4IGF0IDEzOjU4IC0wNzAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6DQo+IE9uIFRodSwgQXByIDI4LCAyMDIyIGF0IDEyOjE1IFBNIERlbHlhbiBLcmF0dW5vdiA8
ZGVseWFua0BmYi5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFRodSwgMjAyMi0wNC0yOCBhdCAx
MToxOSAtMDcwMCwgQW5kcmlpIE5ha3J5aWtvIHdyb3RlOg0KPiA+ID4gT24gVGh1LCBBcHIgMjgs
IDIwMjIgYXQgOTo1NCBBTSBEZWx5YW4gS3JhdHVub3YgPGRlbHlhbmtAZmIuY29tPiB3cm90ZToN
Cj4gPiA+ID4gDQo+ID4gPiA+IHVwcm9iZXMgd29yayBieSByYWlzaW5nIGEgdHJhcCwgc2V0dGlu
ZyBhIHRhc2sgZmxhZyBmcm9tIHdpdGhpbiB0aGUNCj4gPiA+ID4gaW50ZXJydXB0IGhhbmRsZXIs
IGFuZCBwcm9jZXNzaW5nIHRoZSBhY3R1YWwgd29yayBmb3IgdGhlIHVwcm9iZSBvbiB0aGUNCj4g
PiA+ID4gd2F5IGJhY2sgdG8gdXNlcnNwYWNlLiBBcyBhIHJlc3VsdCwgdXByb2JlIGhhbmRsZXJz
IGFscmVhZHkgZXhlY3V0ZSBpbiBhDQo+ID4gPiA+IHVzZXIgY29udGV4dC4gVGhlIHByaW1hcnkg
b2JzdGFjbGUgdG8gc2xlZXBhYmxlIGJwZiB1cHJvYmUgcHJvZ3JhbXMgaXMNCj4gPiA+ID4gdGhl
cmVmb3JlIG9uIHRoZSBicGYgc2lkZS4NCj4gPiA+ID4gDQo+ID4gPiA+IE5hbWVseSwgdGhlIGJw
Zl9wcm9nX2FycmF5IGF0dGFjaGVkIHRvIHRoZSB1cHJvYmUgaXMgcHJvdGVjdGVkIGJ5IG5vcm1h
bA0KPiA+ID4gPiByY3UgYW5kIHJ1bnMgd2l0aCBkaXNhYmxlZCBwcmVlbXB0aW9uLiBJbiBvcmRl
ciBmb3IgdXByb2JlIGJwZiBwcm9ncmFtcw0KPiA+ID4gPiB0byBiZWNvbWUgYWN0dWFsbHkgc2xl
ZXBhYmxlLCB3ZSBuZWVkIGl0IHRvIGJlIHByb3RlY3RlZCBieSB0aGUgdGFza3NfdHJhY2UNCj4g
PiA+ID4gcmN1IGZsYXZvciBpbnN0ZWFkIChhbmQga2ZyZWUoKSBjYWxsZWQgYWZ0ZXIgYSBjb3Jy
ZXNwb25kaW5nIGdyYWNlIHBlcmlvZCkuDQo+ID4gPiA+IA0KPiA+ID4gPiBPbmUgd2F5IHRvIGFj
aGlldmUgdGhpcyBpcyBieSB0cmFja2luZyBhbiBhcnJheS1oYXMtY29udGFpbmVkLXNsZWVwYWJs
ZS1wcm9nDQo+ID4gPiA+IGZsYWcgaW4gYnBmX3Byb2dfYXJyYXkgYW5kIHN3aXRjaGluZyByY3Ug
Zmxhdm9ycyBiYXNlZCBvbiBpdC4gSG93ZXZlciwgdGhpcw0KPiA+ID4gPiBpcyBkZWVtZWQgc29t
ZXdoYXQgdW53aWVsZGx5IGFuZCB0aGUgcmN1IGZsYXZvciB0cmFuc2l0aW9uIHdvdWxkIGJlIGhh
cmQNCj4gPiA+ID4gdG8gcmVhc29uIGFib3V0Lg0KPiA+ID4gPiANCj4gPiA+ID4gSW5zdGVhZCwg
YmFzZWQgb24gQWxleGVpJ3MgcHJvcG9zYWwsIHdlIGNoYW5nZSB0aGUgZnJlZSBwYXRoIGZvcg0K
PiA+ID4gPiBicGZfcHJvZ19hcnJheSB0byBjaGFpbiBhIHRhc2tzX3RyYWNlIGFuZCBub3JtYWwg
Z3JhY2UgcGVyaW9kcw0KPiA+ID4gPiBvbmUgYWZ0ZXIgdGhlIG90aGVyLiBVc2VycyB3aG8gaXRl
cmF0ZSB1bmRlciB0YXNrc190cmFjZSByZWFkIHNlY3Rpb24gd291bGQNCj4gPiA+ID4gYmUgc2Fm
ZSwgYXMgd291bGQgdXNlcnMgd2hvIGl0ZXJhdGUgdW5kZXIgbm9ybWFsIHJlYWQgc2VjdGlvbnMg
KGZyb20NCj4gPiA+ID4gbm9uLXNsZWVwYWJsZSBsb2NhdGlvbnMpLiBUaGUgZG93bnNpZGUgaXMg
dGhhdCB3ZSB0YWtlIHRoZSB0YXNrc190cmFjZSBsYXRlbmN5DQo+ID4gPiA+IHVuY29uZGl0aW9u
YWxseSBidXQgdGhhdCdzIGRlZW1lZCBhY2NlcHRhYmxlIHVuZGVyIGV4cGVjdGVkIHdvcmtsb2Fk
cy4NCj4gPiA+IA0KPiA+ID4gT25lIGV4YW1wbGUgd2hlcmUgdGhpcyBhY3R1YWxseSBjYW4gYmVj
b21lIGEgcHJvYmxlbSBpcyBjZ3JvdXAgQlBGDQo+ID4gPiBwcm9ncmFtcy4gVGhlcmUgeW91IGNh
biBtYWtlIHNpbmdsZSBhdHRhY2htZW50IHRvIHJvb3QgY2dyb3VwLCBidXQgaXQNCj4gPiA+IHdp
bGwgY3JlYXRlIG9uZSAiZWZmZWN0aXZlIiBwcm9nX2FycmF5IGZvciBlYWNoIGRlc2NlbmRhbnQg
KGFuZCB3aWxsDQo+ID4gPiBrZWVwIGRlc3Ryb3lpbmcgYW5kIGNyZWF0aW5nIHRoZW0gYXMgY2hp
bGQgY2dyb3VwcyBhcmUgY3JlYXRlZCkuIFNvDQo+ID4gPiB0aGVyZSBpcyB0aGlzIGludmlzaWJs
ZSBtdWx0aXBsaWVyIHdoaWNoIHdlIGNhbid0IHJlYWxseSBjb250cm9sLg0KPiA+ID4gDQo+ID4g
PiBTbyBwYXlpbmcgdGhlIChob3dldmVyIHNtYWxsLCBidXQpIHByaWNlIG9mIGNhbGxfcmN1X3Rh
c2tzX3RyYWNlKCkgaW4NCj4gPiA+IGJwZl9wcm9nX2FycmF5X2ZyZWUoKSB3aGljaCBpcyB1c2Vk
IGZvciBwdXJlbHkgbm9uLXNsZWVwYWJsZSBjYXNlcw0KPiA+ID4gc2VlbXMgdW5mb3J0dW5hdGUu
IEJ1dCBJIHRoaW5rIGFuIGFsdGVybmF0aXZlIHRvIHRyYWNraW5nIHRoaXMgImhhcw0KPiA+ID4g
c2xlZXBhYmxlIiBiaXQgb24gYSBwZXIgYnBmX3Byb2dfYXJyYXkgY2FzZSBpcyB0byBoYXZlDQo+
ID4gPiBicGZfcHJvZ19hcnJheV9mcmVlX3NsZWVwYWJsZSgpIGltcGxlbWVudGF0aW9uIGluZGVw
ZW5kZW50IG9mDQo+ID4gPiBicGZfcHJvZ19hcnJheV9mcmVlKCkgaXRzZWxmIGFuZCBjYWxsIHRo
YXQgc2xlZXBhYmxlIHZhcmlhbnQgZnJvbQ0KPiA+ID4gdXByb2JlIGRldGFjaCBoYW5kbGVyLCBs
aW1pdGluZyB0aGUgaW1wYWN0IHRvIHRoaW5ncyB0aGF0IGFjdHVhbGx5DQo+ID4gPiBtaWdodCBi
ZSBydW5uaW5nIGFzIHNsZWVwYWJsZSBhbmQgd2hpY2ggbW9zdCBsaWtlbHkgd29uJ3QgY2h1cm4N
Cj4gPiA+IHRocm91Z2ggYSBodWdlIGFtb3VudCBvZiBhcnJheXMuIFdEWVQ/DQo+ID4gDQo+ID4g
SG9uZXN0bHksIEkgZG9uJ3QgbGlrZSB0aGUgaWRlYSBvZiBoYXZpbmcgdHdvIGRpZmZlcmVudCBB
UElzLCB3aGVyZSBpZiB5b3UgdXNlIHRoZQ0KPiA+IHdyb25nIG9uZSwgdGhlIHByb2dyYW0gd291
bGQgb25seSBmYWlsIGluIHJhcmUgYW5kIHVuZGVidWdnYWJsZSBjaXJjdW1zdGFuY2VzLg0KPiA+
IA0KPiA+IElmIHdlIG5lZWQgc3BlY2lhbGl6YXRpb24gKGFuZCBJJ20gbm90IGNvbnZpbmNlZCB3
ZSBkbyAtIHdoYXQncyB0aGUgcmF0ZSBvZiBjZ3JvdXANCj4gPiBjcmVhdGlvbiB0aGF0IHdlIGNh
biBzdXN0YWluPyksIHdlIHNob3VsZCB0cmFjayB0aGF0IGluIHRoZSBicGZfcHJvZ19hcnJheSBp
dHNlbGYuIFdlDQo+ID4gY2FuIGhhdmUgdGhlIGFsbG9jYXRpb24gcGF0aCBzZXQgYSBmbGFnIGFu
ZCBicmFuY2ggb24gaXQgaW4gZnJlZSgpIHRvIGRldGVybWluZSB0aGUNCj4gPiBuZWNlc3Nhcnkg
Z3JhY2UgcGVyaW9kcy4NCj4gDQo+IEkgdGhpbmsgd2hhdCBBbmRyaWkgaXMgcHJvcG9zaW5nIGlz
IHRvIGxlYXZlIGJwZl9wcm9nX2FycmF5X2ZyZWUoKSBhcy1pcw0KPiBhbmQgaW50cm9kdWNlIG5l
dyBicGZfcHJvZ19hcnJheV9mcmVlX3NsZWVwYWJsZSgpICh0aGUgd2F5IGl0IGlzIGluDQo+IHRo
aXMgcGF0Y2gpIGFuZCBjYWxsIGl0IGZyb20gMiBwbGFjZXMgaW4ga2VybmVsL3RyYWNlL2JwZl90
cmFjZS5jIG9ubHkuDQo+IFRoaXMgd2F5IGNncm91cCB3b24ndCBiZSBhZmZlY3RlZC4NCj4gDQo+
IFRoZSByY3VfdHJhY2UgcHJvdGVjdGlvbiBoZXJlIGFwcGxpZXMgdG8gcHJvZ19hcnJheSBpdHNl
bGYuDQo+IE5vcm1hbCBwcm9ncyBhcmUgc3RpbGwgcmN1LCBzbGVlcGFibGUgcHJvZ3MgYXJlIHJj
dV90cmFjZS4NCj4gUmVnYXJkbGVzcyB3aGV0aGVyIHRoZXkncmUgY2FsbGVkIHZpYSB0cmFtcG9s
aW5lIG9yIHRoaXMgbmV3IHByb2dfYXJyYXkuDQoNClJpZ2h0LCBJIHVuZGVyc3RhbmQgdGhlIHBy
b3Bvc2FsLiBNeSBvYmplY3Rpb24gaXMgdGhhdCBpZiB0b21vcnJvdyBzb21lb25lIG1pc3Rha2Vu
bHkNCmtlZXBzIHVzaW5nIGJwZl9wcm9nX2FycmF5X2ZyZWUgd2hlbiB0aGV5IGFjdHVhbGx5IG5l
ZWQNCmJwZl9wcm9nX2FycmF5X2ZyZWVfc2xlZXBhYmxlLCB0aGUgcmVzdWx0aW5nIGJ1ZyBpcyBy
ZWFsbHkgZGlmZmljdWx0IHRvIGZpbmQgYW5kDQpyZWFzb24gYWJvdXQuIEkgY2FuIG1ha2UgaXQg
Y29ycmVjdCBpbiB0aGlzIHBhdGNoIHNlcmllcyBidXQgKmtlZXBpbmcqIHRoaW5ncyBjb3JyZWN0
DQpnb2luZyBmb3J3YXJkIHdpbGwgYmUgaGFyZGVyIHdoZW4gdGhlcmUncyB0d28gZnJlZSB2YXJp
YW50cy4NCg0KSW5zdGVhZCwgd2UgY2FuIGhhdmUgYSBBUlJBWV9VU0VfVFJBQ0VfUkNVIGZsYWcg
d2hpY2ggYXV0b21hdGljYWxseSBjaGFpbnMgdGhlIGdyYWNlDQpwZXJpb2RzIGluc2lkZSBicGZf
cHJvZ19hcnJheV9mcmVlLiBUaGF0IHdheSB3ZSBlbGltaW5hdGUgcG90ZW50aWFsIGZ1dHVyZSBj
b25mdXNpb24NCmFuZCBpbnN0ZWFkIG9mIGludHJvZHVjaW5nIHN1YnRsZSByY3UgYnVncywgYXQg
d29yc3QgeW91IGNhbiBpbmN1ciBhIHBlcmZvcm1hbmNlDQpwZW5hbHR5IGJ5IHVzaW5nIHRoZSBm
bGFnIHdoZXJlIHlvdSBkb24ndCBuZWVkIGl0LiBJZiB3ZSBzcGVuZCB0aGUgdGltZSB0byBvbmUt
d2F5DQpmbGlwIHRoZSBmbGFnIG9ubHkgd2hlbiB5b3UgYWN0dWFsbHkgaW5zZXJ0IGEgc2xlZXBh
YmxlIHByb2dyYW0gaW50byB0aGUgYXJyYXksIGV2ZW4NCnRoYXQgcGVuYWx0eSBpcyBlbGltaW5h
dGVkLsKgDQoNClRoZSBjb3N0IG9mIHRoaXMgdHJhZGVvZmYgaW4gbWFpbnRhaW5hYmlsaXR5IGlz
IDQgYnl0ZXMgbW9yZSBwZXIgYXJyYXkgb2JqZWN0IChsZXNzDQppZiB3ZSBwYWNrIGl0IGJ1dCB0
aGF0J3MgYSB3b3JzZSBpZGVhIHBlcmZvcm1hbmNlLXdpc2UpLiBHaXZlbiBob3cgbXVjaCB3ZSBh
bHJlYWR5DQphbGxvY2F0ZSwgSSB0aGluayB0aGF0J3MgZmFpciBidXQgSSdtIGhhcHB5IHRvIGRp
c2N1c3Mgb3RoZXIgbGVzcyBmb290LWd1bi15IGlkZWFzIGlmDQp0aGUgbWVtb3J5IHVzYWdlIGlz
IGEgY29uc3RyYWludC4NCg==
