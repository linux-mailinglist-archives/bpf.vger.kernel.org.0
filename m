Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7421650AB01
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 23:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387986AbiDUVzI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 17:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiDUVzI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 17:55:08 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E944DF58;
        Thu, 21 Apr 2022 14:52:17 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 23LK2r5C001162;
        Thu, 21 Apr 2022 14:52:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=sxAwOv7Dw+7Hq5IrFc5wq6tJ/sKJ4NotYwAyHuMv7LU=;
 b=dqhVpfxXBcElHZfhAzs0WUhqntFvxpGLNi6xscU/zViVUeaU2xSIuq8HqkslRNn2wkn9
 Emsh4ihPcpmKMS97l0sIYRH6BL4fRBSi7sPHOZ/RE3NcDdQmtDMJx5hP8CxT8AvBCNq+
 y6xffFV/14+e8a5G1Lu0+TFx5U2uNW4SF4Y= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by m0089730.ppops.net (PPS) with ESMTPS id 3fjvsvxm44-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 14:52:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ojmnd9xNu4buEnRBpsN2kRgsX6k4ybTIfhvpchXYh34/SMY5IK5SPLzCzOsQpr5vrzRgAgOV7JNZsVEH77dXC3IqiwCZsyAb2OMYTjI0CKIvLsBHw1spEsjzrm6OH5nsCNmKm4ECLLXLUEGAhkSDIyF5vGJD1CHVZm9SY2/bS+wkS4TmUPT1gEcsA96pWObCENwIdy7cdrnjhSus+e5k1TX8SVFF9saLl7ZyEeBI2rpW4A/sL0IUBWXcNS4mAPjFjwsEnKfzIacvxykDwjgLeZl3mwRIN8NSlTzX9/G6wjLb2O/h3tUzruEmyuo+ftajzMAtDkvadclWKKXSGOEqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxAwOv7Dw+7Hq5IrFc5wq6tJ/sKJ4NotYwAyHuMv7LU=;
 b=C+fmgW3pnVsP/aNl2PascoHvdN/pBbIJJfGucbaekutw+mTOa+6u+AC18JUUwnhoAMkF9Dt/eOIFuum10ao4JVAUCSY2IqEILdDnsN9qVR38qkg7/svNWaikm0hiDZX5pKi/GsTwhR/65GjO7R0V+gmRTL62ZADbpdi+5MoOlWJe6t5D0D1bSKjBk4bVMcTfalTTxVAAdCMZHBY0VrgwHGyLFUWA1BpWhwl6qwgQ1hu26OKmTrVoEU/ts9UoDplH2s1T6I2/q7BjQjB3d3K0bgarVFzJpjP+Kdw8nIp44jGPVZqTAM0YoXuhXEU6WrBsbq3hZ5qwtrsD9DAWZN/hSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SJ0PR15MB4743.namprd15.prod.outlook.com (2603:10b6:a03:37c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 21:52:13 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::20d2:26a2:6cb1:3c4b]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::20d2:26a2:6cb1:3c4b%7]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 21:52:13 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Song Liu <song@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf] bpf: invalidate unused part of bpf_prog_pack
Thread-Topic: [PATCH bpf] bpf: invalidate unused part of bpf_prog_pack
Thread-Index: AQHYVVFO5makbPGsXEqvzLt6DCKkwaz6mnqAgAAexN2AAAuPAIAAHgIAgAAGqwA=
Date:   Thu, 21 Apr 2022 21:52:13 +0000
Message-ID: <1A4FF473-0988-48BE-9993-0F5E9F0AAC95@fb.com>
References: <20220421072212.608884-1-song@kernel.org>
 <CAHk-=wi3eu8mdKmXOCSPeTxABVbstbDg1q5Fkak+A9kVwF+fVw@mail.gmail.com>
 <CAADnVQKyDwXUMCfmdabbVE0vSGxdpqmWAwHRBqbPLW=LdCnHBQ@mail.gmail.com>
 <CAHk-=whFeBezdSrPy31iYv-UZNnNavymrhqrwCptE4uW8aeaHw@mail.gmail.com>
 <CAPhsuW7M6exGD3C1cPBGjhU0Y5efxtJ3=0BWNnbuH87TgQMzdg@mail.gmail.com>
 <CAHk-=wh1mO5HdrOMTq68WHM51-=jdmQS=KipVYxS+5u3uRc5rg@mail.gmail.com>
In-Reply-To: <CAHk-=wh1mO5HdrOMTq68WHM51-=jdmQS=KipVYxS+5u3uRc5rg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c93c7ec7-ae27-4f44-fe4d-08da23e131c1
x-ms-traffictypediagnostic: SJ0PR15MB4743:EE_
x-microsoft-antispam-prvs: <SJ0PR15MB4743325C05D302699F083FF2B3F49@SJ0PR15MB4743.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zm3w7BAd6+D1hXkskXfUrTNgO3VAR0gtCMuErS2QRNjlvPzcynunTQ2sPD5asolZZHf14FDWxK1O25YgYJsUa9TsTBfo+6/FDlpgHezLvfL657QH6bbkJdkyo/vH0XX9557WjSpmEAwMRqnj/9Y/eeC9vQHbSxCjta1GGsUh57YsrrRnBvSHuLkEOOfko2fT3zCwwu011azifTA35+Yg5CwdpuUF+Vcg6iNA4yI2gQWn37qwdZY/2qWXXldyJ0jPMcYnp9w2o+pl6ay7OkBmWZO7wlEyk5OFqAY4Zj4vgbajN8mVyzJ61uKlI2C+2OrjCk+Y2CFGPVxauAXxhANIYz+yhATkGwpQxdXCq2Nus7aluBVdZfnG0HQmv2JqhqGXaVo9yRlFRuYeSK8DbNSNsUTvEiQbtvhfZvd5tHDgDvReAN09Y10f73hCJkBXtC5GsnLJIXR/ysB6OBaLejdXZvV36HEXlJCh9hJFzWwJ2AciOUUAIcc6fYFZm9OlwOaGLd8+vGCmoUropVO3Dhim66xWRzYWD3na8gx8KV9Ee4HOxCxGByiqAUwIBSXgOo8gm8oVd0zefEKTjW2IT45CdprtRmTnUk0+SFX3Ge2MbVO6f8nQ0fdE+i7ZP1cy4gWodm+Jb427Jj7DolJgHo8roS6saswW+tsYy3uX0SvKOoBtgWv0aB3ZTL/y4/QyYg3XvDqccCX2TZsowuetnkle/N9Yw15MCHwJWp+isel6zuUx/9nvB55GeUNkJjwsg/5U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(66946007)(38100700002)(4326008)(2906002)(5660300002)(508600001)(33656002)(6512007)(66476007)(8936002)(2616005)(186003)(38070700005)(36756003)(71200400001)(7416002)(66556008)(6486002)(8676002)(64756008)(91956017)(66446008)(6506007)(76116006)(53546011)(6916009)(86362001)(316002)(54906003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OElCRG9RMHBINFgrSy9pblBQNHdJcjFBZWFHL0M1L1dMMy9PaURMN2RDWStF?=
 =?utf-8?B?c21uNGNpN2hxUlJ0QTVPM1RFWHQ2QXkxMEtBUkpHY1A3cjZtdEhYdFIrejBW?=
 =?utf-8?B?S3dnMzhwb3laL3RKck1EeDdROTR0ZHJtN2pRbjVjV1hJcnI5aWVMNXI1Y1d2?=
 =?utf-8?B?YkEyNUdqSjJJUm0zZ3kwMmp0bVdYdG9kUE1PdmNkT2d5amIrRU5MTXBLQTdu?=
 =?utf-8?B?ZDhGUTN3UDJKc2tXZXczdW9xdzkwUHNmV2V3aWVKajdFQmpVc2k0eXp3c1RI?=
 =?utf-8?B?LzRXdXJTWTFHY0FQUGtFb0VKT3VXbkZZRGFmWlhXbU43dVdUZkV4UnAvZ2Vq?=
 =?utf-8?B?VERGdUdqTlkxdEhXMEZSMVNIU2U5QVRCcFJpSG8rditRTlhCZDBra1Z3djFR?=
 =?utf-8?B?ejJNdzBrbTRTdk9ocWt5aGFnSW1kUEF3bGNkV2tqQW9nbGZSN1Q1Q2R2ZE9v?=
 =?utf-8?B?VU9LdUhXV3NRTkR3ZW5RaUNJTUlOaTgvbWVrZDgwcXdFUm54bmtrOHpSKzBq?=
 =?utf-8?B?ZHFiNTJpeUJLbWJoeWJ1cGgxaEVoT1F1dDhtb2JNTzdDbGRFRUw0RDUxVFJ2?=
 =?utf-8?B?NUJJRlF2WlBacWRlYng2RGVnNjN0RTZsK2VkNGdwTkVoMzkxZ0dKM01oQkxq?=
 =?utf-8?B?NDZ6U0ovck4ySlJuNldsUk5vV1BGMG1tb2FuSm43c2ZrSUJqUERweWNVWVh5?=
 =?utf-8?B?NlNheHZTLy9CVW52cnJDZjBoZ2dpdkxhYzhRK1JWMVRUdkhoYmI0clh4MHhp?=
 =?utf-8?B?M2MrTEd0aFh2OXZMSUY2SlJmTHZFT1ByVGNiVzZRZndYNlJUd20rMUdSQlcr?=
 =?utf-8?B?SGt3RDA2OXJjVUFCeE1aRlVFZzNxakZkSjE5TFp4bDZkU1FzR0haTDF3RVBN?=
 =?utf-8?B?OGNFbm5lY1VtemE5ZVo4RUFZWkFzWFVic1gwRFh2d2ZLdGhGbTBFYmZWdEYr?=
 =?utf-8?B?dzVrTnBMNXdQY0xadTFJeWx0eGpQeVRDVGlOWnhWRlJPNTl5UC9IVEY5S2Zx?=
 =?utf-8?B?Sjh1SU15bWtLWHdXOTFKRkVDNzhINTZzUmtQRElodjBGTWFoV1ZoL0dJYTgr?=
 =?utf-8?B?N1I1YzVGQ3hNUks2YzFlKzh5UlpOUUJXMTZPWDMyV0pGYjZLZExzd0wwcXU2?=
 =?utf-8?B?Uy9SWC9LaTdSMkErMEF0ZjJyQlR1V2RxT3dZeCtjWEJ6WHoyOFhvZG12NFhl?=
 =?utf-8?B?YWpZM2s2V0xBYnczL3lZN0NTaEtyWFVac2tHT3ZvYWpXUDdvWGl2b2habGFU?=
 =?utf-8?B?bHZ1dDdWbzB0VlN3YThTM0RVcGFqaTVWTzh1OE9hSnB1eGZ4MXNoWis4a0ZZ?=
 =?utf-8?B?K3BmRFhIQi8wZ2pKYWkyZ3pLQS9VTW1tNXpRempyR3UzYnZCeGYxekVoaXVI?=
 =?utf-8?B?aVUxOTZ5RDV5VXhYRXE5TFNSRkw3d2FCSCtjcEZSbXpHVmo4N1hBVEZ3RGta?=
 =?utf-8?B?bzU3VzROT041ZjBNdnBTaDVDUDc3T2NFWWxPeG5udDkwTUZiRVF4SFZGNk11?=
 =?utf-8?B?dmpRYWR2K1ZUOU5sSjI2d1VKcVdhL0N4YVFoMHhzbk9jQ1dzMFQ4azhsdzlM?=
 =?utf-8?B?eS95WThvb2RrMWZyK01weUUvM2c0UCtVNUZNSFJqcHNQS2hDUjBldmhuanYz?=
 =?utf-8?B?MG5TVzZLVkxwQWpUNG5tSDVWVGZZT2dhMmJmQlBlQW9wbGVVdkpLVkVrTnZE?=
 =?utf-8?B?Mm1zNktaVFA2VUYzUzlHMXZna0F5aFhUSnU0Zzg5ZGdNSktJbzNGbXlaK2Vj?=
 =?utf-8?B?bUFPa3lqZzFQdkR2WW4vYjFDVDd5VFpBZGxkendXY0VOQ2xKQnlWZWlTSXRa?=
 =?utf-8?B?S2o1TExteDFHWVRueGlGWU1IRmFnbkhOMm83WHF3ZWlNaEhoNDFmakIzbHJh?=
 =?utf-8?B?U3ZKL3N5Rm8xaDdrTUVsM1dxaU45QTNjTE0zU3E1VDRTbVFWMWdzWnNsNnVi?=
 =?utf-8?B?WGE1bllVMlF5Y1h6OWlzVUdCZ0FweU5QWUltbEk2SERpUU9lbm5jN3ZpSGFH?=
 =?utf-8?B?eUFZSUthSkRpVUJjWjAreStPRW9jRVBzUWFsbnpGT3lVSDVaYWtOSnJ1UUV0?=
 =?utf-8?B?SC9PdjgxVnhUdnQzRFhyUkd5UnZRU09acHlkb1FpeWtjOU1HVmtTY3FYVHN4?=
 =?utf-8?B?YkluUG0yaEtTVjJPbzhKZllNUXRCcVJmM09YU0c2eDJ6WkpzNTFsdGc4S1BV?=
 =?utf-8?B?bnZTQ01SeGRRNmpHWG9Ua3lRdGl0SjFzbjNsaS9Pei9PUm5PS3grR0lPR1VN?=
 =?utf-8?B?WDAyaWZObEVHWnk0RDUrYjF6ZloreEZLWGpMV2tsaTZINDdURVNVdng0ZFBk?=
 =?utf-8?B?YUJPVGRUZVJUUmRSVGdsMGJCc3FFaFhLaVJQZ1NuVWNoQmFCWUZKZVRHdkg3?=
 =?utf-8?Q?xr22Y1TU0eUgXi1Pl0gsU5EsMy4Sswr+rlNqA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <755B8E6D5477364494EDA55C28C82D50@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93c7ec7-ae27-4f44-fe4d-08da23e131c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 21:52:13.5132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PaK/eIQOlp+nxRy3+IL+UHanVZEafotYfkKpMB20T1NwNKHMjMiI9aTH9/xhYqKAfMz3fNiI0Bt50t8jHWvr4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4743
X-Proofpoint-GUID: -MPta_MaHcXm3kKnrwzqBEeCsy8tukUG
X-Proofpoint-ORIG-GUID: -MPta_MaHcXm3kKnrwzqBEeCsy8tukUG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-21_05,2022-04-21_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SGkgTGludXMsIA0KDQo+IE9uIEFwciAyMSwgMjAyMiwgYXQgMjoyOCBQTSwgTGludXMgVG9ydmFs
ZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwg
QXByIDIxLCAyMDIyIGF0IDEyOjQxIFBNIFNvbmcgTGl1IDxzb25nQGtlcm5lbC5vcmc+IHdyb3Rl
Og0KPj4gDQo+PiBUaGUgZXh0cmEgbG9naWMgSSBoYWQgaW4gdGhlIG9yaWdpbmFsIHBhdGNoIHdh
cyB0byBlcmFzZSB0aGUgbWVtb3J5DQo+PiB3aGVuIGEgQlBGIHByb2dyYW0gaXMgZnJlZWQuIElu
IHRoaXMgY2FzZSwgdGhlIG1lbW9yeSB3aWxsIGJlDQo+PiByZXR1cm5lZCB0byB0aGUgYnBmX3By
b2dfcGFjaywgYW5kIHN0YXlzIGFzIFJPK1guIEFjdHVhbGx5LCBJDQo+PiBhbSBub3QgcXVpdGUg
c3VyZSB3aGV0aGVyIHdlIG5lZWQgdGhpcyBsb2dpYy4gSWYgbm90LCB3ZSBvbmx5IG5lZWQNCj4+
IHRoZSBtdWNoIHNpbXBsZXIgdmVyc2lvbi4NCj4gDQo+IE9oLCBJIHRoaW5rIGl0IHdvdWxkIGJl
IGdvb2QgdG8gZG8gYXQgZnJlZSB0aW1lIHRvby4NCj4gDQo+IEkganVzdCB3b3VsZCB3YW50IHRo
YXQgdG8gdXNlIHRoZSBzYW1lIGZ1bmN0aW9uIHdlIGFscmVhZHkgaGF2ZSBmb3INCj4gdGhlIGFs
bG9jYXRpb24tdGltZSB0aGluZywgaW5zdGVhZCBvZiBpbnRyb2R1Y2luZyBjb21wbGV0ZWx5IG5l
dw0KPiBpbmZyYXN0cnVjdHVyZS4gVGhhdCB3YXMgd2hhdCBsb29rZWQgdmVyeSBvZGQgdG8gbWUu
DQo+IA0KPiBOb3csIHRoZSBfc21hbGxlc3RfIHBhdGNoIHdvdWxkIGxpa2VseSBiZSB0byBqdXN0
IHNhdmUgYXdheSB0aGF0DQo+ICdicGZfZmlsbF9pbGxfaW5zbnMnIGZ1bmN0aW9uIHBvaW50ZXIg
aW4gdGhlICdzdHJ1Y3QgYnBmX3Byb2dfcGFjaycNCj4gdGhpbmcuDQoNClsuLi5dDQo+IA0KPiBX
aHkgbm90IGp1c3QgYWdyZWUgb24gYSBuYW1lIC0gSSBzdWdnZXN0ICdicGZfaml0X2ZpbGxfaG9s
ZSgpJyAtIGFuZA0KPiBqdXN0IGdldCByaWQgb2YgdGhhdCBzdHVwaWQgJ2JwZl9qaXRfZmlsbF9o
b2xlX3QnIHR5cGUgbmFtZSB0aGF0IG9ubHkNCj4gZXhpc3RzIGJlY2F1c2Ugb2YgdGhpcyB0aGlu
Zz8NCg0KTGFzdCBuaWdodCwgSSBoYWQgYSB2ZXJzaW9uIHdoaWNoIGlzIGFib3V0IDkwJSBzYW1l
IGFzIHRoaXMgaWRlYS4NCg0KSG93ZXZlciwgd2UgY2Fubm90IHJlYWxseSB1c2UgdGhlIHNhbWUg
ZnVuY3Rpb24gYXQgZnJlZSB0aW1lLiBUaGUNCmh1Z2UgcGFnZSBpcyBSTytYIGF0IGZyZWUgdGlt
ZSwgYnV0IHdlIGFyZSBvbmx5IHplcm9pbmcgb3V0IGEgY2h1bmsgDQpvZiBpdC4gU28gcmVndWxh
ciBtZW1zZXQvbWVtY3B5IHdvbuKAmXQgd29yay4gSW5zdGVhZCwgd2Ugd2lsbCBuZWVkIA0Kc29t
ZXRoaW5nIGxpa2UgYnBmX2FyY2hfdGV4dF9jb3B5KCkuIA0KIA0KVGhhbmtzLA0KU29uZw0KDQo=
