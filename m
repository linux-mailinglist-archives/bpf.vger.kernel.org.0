Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178F552AD52
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 23:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241811AbiEQVIY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 17:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbiEQVIX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 17:08:23 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B61D532D3;
        Tue, 17 May 2022 14:08:21 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24HKFIMH015796;
        Tue, 17 May 2022 14:08:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5hDnIfInz1UEK4UCpJQJmO7+5uHV4xxCuhg0tjSBBL0=;
 b=S7Pqb68xPhO5AmplyKEPn7oqdKZL2ACHWq1c/O0MvHdypXqcuh3+wRdEDPCzwfesNYZ4
 nMGt5p/RiBAXtPzJnuarsIkMAcIrTXBrQpJ/qWFqVLPu5RZ6eVMpkpvqWjVqf4q7tlwe
 1hPaoO220Yv+RjOpD6zpKFW5IR7X3ZxYT6c= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g29xxvffv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 14:08:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Os99MhAI1QYr+ayanJUexKDs+Msn4XsAoOJgB9Y5625nYN5b0KyWeP4DfkcubeCiNPDVxqH5ykgyZ4d7TIShLTOv3CPxnvnm2YmReOauVtXHUYKH++jI8RzSQoYXk1flvNbctUsoedrGmTZYB1Q0eIcWfmUWModWXuncIAgW24yqFYSnFLVEQ1oduXx2o9z71dHvBzlFcWFP96XJA68CHttoMHbiUXisstn0ZT1ARTI2OgR5olv9k18gU64I+IbR6AdVwQeSw72RFrfPn81rkFsAxHd+7zfylsxw0QqaXsLPF/OO+8AiCw4O5MasBWxOXC0cHjkw8WI+Pxfu6CJKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hDnIfInz1UEK4UCpJQJmO7+5uHV4xxCuhg0tjSBBL0=;
 b=bASZ/iQm9kbdHBespYejwbxjLJL9ERPTMWUzeqlCNTfeiM966lwsOb5qpvYN5aXfycuyF4oGmLMR492Da9e0eUoc3qYTgDkgXdZqBAfS2CjLCoZ6iR6dLx0/TMFUcZO/PfOnoVQlGqatJSslVxXWUW5Os3NEGATIiQZZnA2zM50o2L8HENgogVwSTInnm4IQsrDwInmBbgP3xUQdhl9Ua2NTo79cqxGDiLW0tsW/5OAQCMBpW+xHz+mDxJb+2CTvO5dhkvxFUhmFInKWfbMJzqwAiXnnKT/Vf41x8T755g90W1/NK5ZO2Aw6DP4nPRGKRrtIcs7IR/TZT/rttryXgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM5PR15MB1643.namprd15.prod.outlook.com (2603:10b6:3:11c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 21:08:17 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3061:40ff:2ad:33aa]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3061:40ff:2ad:33aa%5]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 21:08:16 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "song@kernel.org" <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH bpf-next 5/5] bpf: use module_alloc_huge for bpf_prog_pack
Thread-Topic: [PATCH bpf-next 5/5] bpf: use module_alloc_huge for
 bpf_prog_pack
Thread-Index: AQHYaOeMGoBl3hFoL0eR1OYIkVdnbK0jcwCAgAAfoYA=
Date:   Tue, 17 May 2022 21:08:16 +0000
Message-ID: <68615225-D09D-465A-8EEC-6F81EF074854@fb.com>
References: <20220516054051.114490-1-song@kernel.org>
 <20220516054051.114490-6-song@kernel.org>
 <83a69976cb93e69c5ad7a9511b5e57c402eee19d.camel@intel.com>
In-Reply-To: <83a69976cb93e69c5ad7a9511b5e57c402eee19d.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3054b8ba-55f6-4f76-4fd2-08da38495ce6
x-ms-traffictypediagnostic: DM5PR15MB1643:EE_
x-microsoft-antispam-prvs: <DM5PR15MB164309E84BAB75D27CEAF061B3CE9@DM5PR15MB1643.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r65k7hXFN3+C2XXjDD1UfBUoJGUVrGG+xCRBdKiZ58QUSa+easP4Twv11S6dNmMHTuFaEA5/qHurtn9rDfHsqjw/TZvBq9jdeDv8FcWqGc16wOs7NCKl6zg248yS+ywbMqS4suqw+1GJjhY/lMG/t+o8ErzkFR0cNMvzCGGpwnPpgGRN6ec9QBwxAs6AyjLcAOIIt8Mitzx+0PpODr5YgyEsl95ooW6EBEgDqhNR97DAhCwdh3cKk5Pkb2599HLKGguHD2K8zBp8qSUej/4uoqk/ZYGCKFXGF739szLdlQjtoDejP/0i5g0HJe8cM0gfHkasH5l1CAIMSafLYeIqwze6NBjT216FGrTRbxqEn3M6y3uMG01b9EFyd5O1EORwX0Clct6nfum+FZWAxqjqfgNLv7x8tRiVFvV7ChSKG5wb1oW5uUUmI6k+oWVyAYdJzAoufb8928Bt+zEwwbMHkR1XV/KpXl/1lXm5CUoZpkjscgZsIKcVlckVRsINcN1rnsDQiZy74BdhHyr15kFmrSHcRyISmy1nMEaWUUctrSNjTFkLoVRkx31vLQxfn6PDk+gVT0ReAUImGGiqWWEtt8ub6CYv4Bnd6kwlhvG2+ZjpuQNtZXHwM3HkIOS2Krbep8+odINa7Z1XMERI8Jnj2JGKOZvdmpUCl0Mqv1lrsfdrY5BiJUmBwMgLgAK9LteUYGSRm/gRAaKlzyTtbOqiofD7Ck5XUrxWw7sbQrY8g4LuYuQ+5Nmxb6oAUrDQoLYe4AEdootaT3WF3tzth7VEJx8ktlirzv4pA+dhFRzgNA4d7FWuCRsPzuyLCegGFQzPwFf20+7z2XxkOP67+f9ObDt1mp1zEGyEXBLeFkN8QJ4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(71200400001)(6916009)(186003)(6512007)(2616005)(66946007)(66556008)(91956017)(38100700002)(316002)(36756003)(8936002)(86362001)(38070700005)(966005)(6486002)(33656002)(76116006)(4326008)(5660300002)(8676002)(2906002)(66476007)(64756008)(66446008)(122000001)(6506007)(83380400001)(508600001)(53546011)(14583001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGxWTWw0VVBSdXJVbE82ck12QzdMYlFCTHVjOGhCTWRNQnU2MjBheFFXazN2?=
 =?utf-8?B?WEJsbGxTUklISDVEUHdkekVldFdQSWVBTForc3YvSFlEMStBcmxyWEw4czRr?=
 =?utf-8?B?bGU1RUVkdmhuUHVBV01IYnJNZ25JaTBUMlQrYTd3V0RTekJtREl2QzhpZWgy?=
 =?utf-8?B?ZTAyTHdlQUhPT1lYNEF2Sm1OUW1uWHJyMHJVcjFjQkpMVlkwekFsYVFXYmxo?=
 =?utf-8?B?Q0VuNlBhcFpmamUxdDA1T3RrNVp0WDJNamlrUWZWNk9HWDJneDBnWXE0ZWhq?=
 =?utf-8?B?RVFkYlhOV1VxUVNOSmxtczZxN3Q5YkhBNGNMbUdvTTF6WTUxY3VIbzhIV2N4?=
 =?utf-8?B?WEZ3OGNyYm1teGxGUTZpbnJFSGRtSnplekpJTUFSQ2Q3Y3Fvdzd3Z0VIL0JR?=
 =?utf-8?B?ZVN4RFZzdGh4dkVLRzR5NXBzSkoveHJqb1ZiVDNORnVQbHplSGRrcGNiM3hF?=
 =?utf-8?B?ZlBzYmk1ZytoLzdYa1lXbUZuaWE3REs0RkVCcW00SGZTR1RBUGpyeHlIRURm?=
 =?utf-8?B?Y3ZSY242Qlc1bGRuTllDL3ErbTdtTU5yMkFUZ3RkalJrK2FTenMrSlNFaXBa?=
 =?utf-8?B?cFlKdThZczlZd0swSGVOTTQrcmQ1UE9lNjU1elJyV3BLV3VCR1BmZk5nSjUw?=
 =?utf-8?B?YytVWkwzZllxQml4alMvR1BXSC9BZHdqQzFMZGRCNFlpbFhabU9ZQTVxbDdh?=
 =?utf-8?B?RGZTdlNzQ3ZKM1BMa2lvZHFJNWtmWGVjakdwSm5TeW5NRENwMklEempLSmMv?=
 =?utf-8?B?dmZvMjI3aHkvYVRhQjdmZVBsTmpMN2NSOXpRY2dWdnZFRnY3cnhjV1N4dFU0?=
 =?utf-8?B?cVhNOWJqbkg2SGVjUUovTVJtcGlYakpUTGxTdU5jL3VKanMvYXU5NEx6MG1L?=
 =?utf-8?B?MFhqWVdoREF1bE9lMGY1a1huNTZqQSsxZk9FL01KdTFqa2dmNnRSalNMYktG?=
 =?utf-8?B?UCswR3JrOVBNQkZ2S3FvRHRZZzAraXJaUGdFcG00dGwvZ25vNUlIYzlJQ2JQ?=
 =?utf-8?B?ZE82WHlvbWQxTWRLRk5IeTNUeE9GeW9zOGdFRXpWeE1iWnFhTWdrME8yTnNX?=
 =?utf-8?B?Z1dVYjZwaHcyUE44dFNDdEx0SkhZTzY1dWFKN3hjaFJsL1VGV1BGTlhSSDhF?=
 =?utf-8?B?Q05uZ2hwYytnajVTRC9zWEw0clhNWW9HejU2L1FlQk5tdDVxZiswb2JoalZU?=
 =?utf-8?B?TU5aVGtKOW12dnA5cXZ5UWZzc3RJRjYxeGg1NktRV1JudVcwTVJIbjRGUVRI?=
 =?utf-8?B?S0hPSVFrRE9NL0FnbUdUUFpiUnZmNWg5bTZnY2tlSzJSejhpWmE2NEluaE01?=
 =?utf-8?B?RGw5a1J2MVdidEFXeUVCRlZiRy9JcjhCdGZLVzRoc3BUdWRZTXI0cUd2eHlM?=
 =?utf-8?B?VThLLzYrQzhMYklhMFBhUWdjREFOOVVHQTFjRG84U001RTBhMVpGYzZDcGNI?=
 =?utf-8?B?bjdtVVBBQ0IwVzJ6elYyWDhDdXpWc296TVQ2Qy9lN2lERVRzVTY2M25NaHpF?=
 =?utf-8?B?NmVhSTJYTVMvcHBldGw3WkU3UE9tU3VWZzgwMEpWanpzcUhWWjhSNTNyZW5V?=
 =?utf-8?B?eFBNNTJSM2pEUU9UdHhvTmljWTNyZWhxd2pvM0VUVFpPNkdrZWtXZ1Jod3Rw?=
 =?utf-8?B?RXVEWG1yZTBvYXpld1I1T1orVXAxdmJlc0ZkWC9Xb2NEOWhsZmhKQ1p4elpv?=
 =?utf-8?B?NDhldDBYNDBCUmJsTDlIUFhoVTMyelhudGNEbnYyVktURnA2TlJjYzBqWFVE?=
 =?utf-8?B?aG5RS2VUb0hLM0J2YkNNSm0yWEVEK25RdC9jckhkZXlSZEZHZS94a05RTmdQ?=
 =?utf-8?B?THlyUnZoRDdNQm9SM0sramFGVi9Oc2NwSVFEZFRhUmFyRVFhQTZCL2pWMzZS?=
 =?utf-8?B?M1JMNmYxRHozRHJNdEFnRXNscDZjVFVrcm40YnMvRFE4NjJUd3dkRXh2TzZl?=
 =?utf-8?B?UnlCekdpUFlLM1FSaUVpVWVjTmpsQ2ozODVDd1lENkFmNFZGamdGWjNkUzM2?=
 =?utf-8?B?aUJLZk9EN0RXcHZsSlNjR2hIaEhsMWFZZm1ENE5SbnJpeWJpLy9mR3ZUT3Zm?=
 =?utf-8?B?cW5COG5YZDlsalNPTnVyUXVmWjgxVGxMZEFpUE1XMXVqYm41cERlbldXN1Vy?=
 =?utf-8?B?UEdmOVdUeGQ5NEVaOGFLR1F4YnFjVGl0a2tLYXJmaitDVEQvenFyUFB4R3BE?=
 =?utf-8?B?TUtleHh5d0ZkK2dENlpmUlhGeUdzSTBZclRlMm1sT2UrQ1QxOTF2dDI4MmFl?=
 =?utf-8?B?TFpOUGVjbHJpMTA3elRmTmh2WlJVTy9CdjIrVGNzRXNoT2hoK0tzbnVxNzFH?=
 =?utf-8?B?ZWRsNjh6eUk4ajQydkJYdjhiWmZ2Z0VJRWV1WmdzOUhmSVpySTdGZTZMeVlG?=
 =?utf-8?Q?RxQ9+bieoP51VcAQu2isPLGfEsW5hpC48CtQU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F51F5B9660FD1D4AA31E64A4F6F156B4@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3054b8ba-55f6-4f76-4fd2-08da38495ce6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 21:08:16.8087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xq6hDkFAsGC3GeAvj3R9R+XnuhipO9ohH+Ejd5ibmTPOvL3b6L8vG2DfastQxH/v4nd6UBq0SgBOT1xxmuak7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1643
X-Proofpoint-GUID: hwTLyNCfycvQFykGdKNiTCI6pimiqeGg
X-Proofpoint-ORIG-GUID: hwTLyNCfycvQFykGdKNiTCI6pimiqeGg
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_03,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCj4gT24gTWF5IDE3LCAyMDIyLCBhdCAxMjoxNSBQTSwgRWRnZWNvbWJlLCBSaWNrIFAgPHJp
Y2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIFN1biwgMjAyMi0wNS0x
NSBhdCAyMjo0MCAtMDcwMCwgU29uZyBMaXUgd3JvdGU6DQo+PiBVc2UgbW9kdWxlX2FsbG9jX2h1
Z2UgZm9yIGJwZl9wcm9nX3BhY2sgc28gdGhhdCBCUEYgcHJvZ3JhbXMgc2l0IG9uDQo+PiBQTURf
U0laRSBwYWdlcy4gVGhpcyBiZW5lZml0cyBzeXN0ZW0gcGVyZm9ybWFuY2UgYnkgcmVkdWNpbmcg
aVRMQg0KPj4gbWlzcw0KPj4gcmF0ZS4gQmVuY2htYXJrIG9mIGEgcmVhbCB3ZWIgc2VydmljZSB3
b3JrbG9hZCBzaG93cyB0aGlzIGNoYW5nZQ0KPj4gZ2l2ZXMNCj4+IGFub3RoZXIgfjAuMiUgcGVy
Zm9ybWFuY2UgYm9vc3Qgb24gdG9wIG9mIFBBR0VfU0laRSBicGZfcHJvZ19wYWNrDQo+PiAod2hp
Y2ggaW1wcm92ZSBzeXN0ZW0gdGhyb3VnaHB1dCBieSB+MC41JSkuDQo+IA0KPiAwLjclIHNvdW5k
cyBnb29kIGFzIGEgd2hvbGUuIEhvdyBzdXJlIGFyZSB5b3Ugb2YgdGhhdCArMC4yJT8gV2FzIHRo
aXMgYQ0KPiBiaWcgYXZlcmFnZWQgdGVzdD8NCg0KWWVzLCB0aGlzIHdhcyBhIHRlc3QgYmV0d2Vl
biB0d28gdGllcnMgd2l0aCAxMCsgc2VydmVycyBvbiBlYWNoIHRpZXIuICANCldlIHRvb2sgdGhl
IGF2ZXJhZ2UgcGVyZm9ybWFuY2Ugb3ZlciBhIGZldyBob3VycyBvZiBzaGFkb3cgd29ya2xvYWQu
IA0KDQo+IA0KPj4gDQo+PiBBbHNvLCByZW1vdmUgc2V0X3ZtX2ZsdXNoX3Jlc2V0X3Blcm1zKCkg
ZnJvbSBhbGxvY19uZXdfcGFjaygpIGFuZCB1c2UNCj4+IHNldF9tZW1vcnlfW254fHJ3XSBpbiBi
cGZfcHJvZ19wYWNrX2ZyZWUoKS4gVGhpcyBpcyBiZWNhdXNlDQo+PiBWTV9GTFVTSF9SRVNFVF9Q
RVJNUyBkb2VzIG5vdCB3b3JrIHdpdGggaHVnZSBwYWdlcyB5ZXQuIFsxXQ0KPj4gDQo+PiBbMV0g
DQo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9icGYvYWVlZWFmMGI3ZWM2M2ZkYmE1NWQ0ODM0
ZDJmNTI0ZDhiZjA1YjcxYi5jYW1lbEBpbnRlbC5jb20vDQo+PiBTdWdnZXN0ZWQtYnk6IFJpY2sg
RWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gDQo+IEFzIEkgc2FpZCBi
ZWZvcmUsIEkgdGhpbmsgdGhpcyB3aWxsIHdvcmsgZnVuY3Rpb25hbGx5LiBCdXQgSSBtZWFudCBp
dA0KPiBhcyBhIHF1aWNrIGZpeCB3aGVuIHdlIHdlcmUgdGFsa2luZyBhYm91dCBwYXRjaGluZyB0
aGlzIHVwIHRvIGtlZXAgaXQNCj4gZW5hYmxlZCB1cHN0cmVhbS4NCj4gDQo+IFNvIG5vdywgc2hv
dWxkIHdlIG1ha2UgVk1fRkxVU0hfUkVTRVRfUEVSTVMgd29yayBwcm9wZXJseSB3aXRoIGh1Z2UN
Cj4gcGFnZXM/IFRoZSBtYWluIGJlbmVmaXQgd291bGQgYmUgdG8ga2VlcCB0aGUgdGVhciBkb3du
IG9mIHRoZXNlIHR5cGVzDQo+IG9mIGFsbG9jYXRpb25zIGNvbnNpc3RlbnQgZm9yIGNvcnJlY3Ru
ZXNzIHJlYXNvbnMuIFRoZSBUTEIgZmx1c2gNCj4gbWluaW1pemluZyBkaWZmZXJlbmNlcyBhcmUg
cHJvYmFibHkgbGVzcyBpbXBhY3RmdWwgZ2l2ZW4gdGhlIGNhY2hpbmcNCj4gaW50cm9kdWNlZCBo
ZXJlLiBBdCB0aGUgdmVyeSBsZWFzdCB0aG91Z2gsIHdlIHNob3VsZCBoYXZlIChvciBoYXZlDQo+
IGFscmVhZHkgaGFkKSBzb21lIFdBUk4gaWYgcGVvcGxlIHRyeSB0byB1c2UgaXQgd2l0aCBodWdl
IHBhZ2VzLg0KDQpJIGFtIG5vdCBxdWl0ZSBzdXJlIHRoZSBleGFjdCB3b3JrIG5lZWRlZCBoZXJl
LiBSaWNrLCB3b3VsZCB5b3UgaGF2ZQ0KdGltZSB0byBlbmFibGUgVk1fRkxVU0hfUkVTRVRfUEVS
TVMgZm9yIGh1Z2UgcGFnZXM/IEdpdmVuIHRoZSBtZXJnZSANCndpbmRvdyBpcyBjb21pbmcgc29v
biwgSSBndWVzcyB3ZSBuZWVkIGN1cnJlbnQgd29yayBhcm91bmQgaW4gNS4xOS4gDQoNCj4gDQo+
PiBTaWduZWQtb2ZmLWJ5OiBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPg0KPj4gLS0tDQo+PiBr
ZXJuZWwvYnBmL2NvcmUuYyB8IDEyICsrKysrKystLS0tLQ0KPj4gMSBmaWxlIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2tlcm5l
bC9icGYvY29yZS5jIGIva2VybmVsL2JwZi9jb3JlLmMNCj4+IGluZGV4IGNhY2Q4Njg0YzNjNC4u
YjY0ZDkxZmNiMGJhIDEwMDY0NA0KPj4gLS0tIGEva2VybmVsL2JwZi9jb3JlLmMNCj4+ICsrKyBi
L2tlcm5lbC9icGYvY29yZS5jDQo+PiBAQCAtODU3LDcgKzg1Nyw3IEBAIHN0YXRpYyBzaXplX3Qg
c2VsZWN0X2JwZl9wcm9nX3BhY2tfc2l6ZSh2b2lkKQ0KPj4gCXZvaWQgKnB0cjsNCj4+IA0KPj4g
CXNpemUgPSBCUEZfSFBBR0VfU0laRSAqIG51bV9vbmxpbmVfbm9kZXMoKTsNCj4+IC0JcHRyID0g
bW9kdWxlX2FsbG9jKHNpemUpOw0KPj4gKwlwdHIgPSBtb2R1bGVfYWxsb2NfaHVnZShzaXplKTsN
Cj4gDQo+IFRoaXMgc2VsZWN0X2JwZl9wcm9nX3BhY2tfc2l6ZSgpIGZ1bmN0aW9uIGFsd2F5cyBz
ZWVtZWQgd2VpcmQgLSBkb2luZyBhDQo+IGJpZyBhbGxvY2F0aW9uIGFuZCB0aGVuIGltbWVkaWF0
ZWx5IGZyZWVpbmcuIENhbid0IGl0IGNoZWNrIGEgY29uZmlnDQo+IGZvciB2bWFsbG9jIGh1Z2Ug
cGFnZSBzdXBwb3J0Pw0KDQpZZXMsIGl0IGlzIHdlaXJkLiBDaGVja2luZyBhIGNvbmZpZyBpcyBu
b3QgZW5vdWdoIGhlcmUuIFdlIGFsc28gbmVlZCB0byANCmNoZWNrIHZtYXBfYWxsb3dfaHVnZSwg
d2hpY2ggaXMgY29udHJvbGxlZCBieSBib290IHBhcmFtZXRlciBub2h1Z2Vpb21hcC4gDQpJIGhh
dmVu4oCZdCBnb3QgYSBiZXR0ZXIgc29sdXRpb24gZm9yIHRoaXMuIA0KDQpUaGFua3MsDQpTb25n
DQoNCj4gDQo+PiANCj4+IAkvKiBUZXN0IHdoZXRoZXIgd2UgY2FuIGdldCBodWdlIHBhZ2VzLiBJ
ZiBub3QganVzdCB1c2UNCj4+IFBBR0VfU0laRQ0KPj4gCSAqIHBhY2tzLg0KPj4gQEAgLTg4MSw3
ICs4ODEsNyBAQCBzdGF0aWMgc3RydWN0IGJwZl9wcm9nX3BhY2sNCj4+ICphbGxvY19uZXdfcGFj
ayhicGZfaml0X2ZpbGxfaG9sZV90IGJwZl9maWxsX2lsbF9pbnMNCj4+IAkJICAgICAgIEdGUF9L
RVJORUwpOw0KPj4gCWlmICghcGFjaykNCj4+IAkJcmV0dXJuIE5VTEw7DQo+PiAtCXBhY2stPnB0
ciA9IG1vZHVsZV9hbGxvYyhicGZfcHJvZ19wYWNrX3NpemUpOw0KPj4gKwlwYWNrLT5wdHIgPSBt
b2R1bGVfYWxsb2NfaHVnZShicGZfcHJvZ19wYWNrX3NpemUpOw0KPj4gCWlmICghcGFjay0+cHRy
KSB7DQo+PiAJCWtmcmVlKHBhY2spOw0KPj4gCQlyZXR1cm4gTlVMTDsNCj4+IEBAIC04OTAsNyAr
ODkwLDYgQEAgc3RhdGljIHN0cnVjdCBicGZfcHJvZ19wYWNrDQo+PiAqYWxsb2NfbmV3X3BhY2so
YnBmX2ppdF9maWxsX2hvbGVfdCBicGZfZmlsbF9pbGxfaW5zDQo+PiAJYml0bWFwX3plcm8ocGFj
ay0+Yml0bWFwLCBicGZfcHJvZ19wYWNrX3NpemUgLw0KPj4gQlBGX1BST0dfQ0hVTktfU0laRSk7
DQo+PiAJbGlzdF9hZGRfdGFpbCgmcGFjay0+bGlzdCwgJnBhY2tfbGlzdCk7DQo+PiANCj4+IC0J
c2V0X3ZtX2ZsdXNoX3Jlc2V0X3Blcm1zKHBhY2stPnB0cik7DQo+PiAJc2V0X21lbW9yeV9ybygo
dW5zaWduZWQgbG9uZylwYWNrLT5wdHIsIGJwZl9wcm9nX3BhY2tfc2l6ZSAvDQo+PiBQQUdFX1NJ
WkUpOw0KPj4gCXNldF9tZW1vcnlfeCgodW5zaWduZWQgbG9uZylwYWNrLT5wdHIsIGJwZl9wcm9n
X3BhY2tfc2l6ZSAvDQo+PiBQQUdFX1NJWkUpOw0KPj4gCXJldHVybiBwYWNrOw0KPj4gQEAgLTkw
OSwxMCArOTA4LDkgQEAgc3RhdGljIHZvaWQgKmJwZl9wcm9nX3BhY2tfYWxsb2ModTMyIHNpemUs
DQo+PiBicGZfaml0X2ZpbGxfaG9sZV90IGJwZl9maWxsX2lsbF9pbnNuDQo+PiANCj4+IAlpZiAo
c2l6ZSA+IGJwZl9wcm9nX3BhY2tfc2l6ZSkgew0KPj4gCQlzaXplID0gcm91bmRfdXAoc2l6ZSwg
UEFHRV9TSVpFKTsNCj4+IC0JCXB0ciA9IG1vZHVsZV9hbGxvYyhzaXplKTsNCj4+ICsJCXB0ciA9
IG1vZHVsZV9hbGxvY19odWdlKHNpemUpOw0KPj4gCQlpZiAocHRyKSB7DQo+PiAJCQlicGZfZmls
bF9pbGxfaW5zbnMocHRyLCBzaXplKTsNCj4+IC0JCQlzZXRfdm1fZmx1c2hfcmVzZXRfcGVybXMo
cHRyKTsNCj4+IAkJCXNldF9tZW1vcnlfcm8oKHVuc2lnbmVkIGxvbmcpcHRyLCBzaXplIC8NCj4+
IFBBR0VfU0laRSk7DQo+PiAJCQlzZXRfbWVtb3J5X3goKHVuc2lnbmVkIGxvbmcpcHRyLCBzaXpl
IC8NCj4+IFBBR0VfU0laRSk7DQo+PiAJCX0NCj4+IEBAIC05NDksNiArOTQ3LDggQEAgc3RhdGlj
IHZvaWQgYnBmX3Byb2dfcGFja19mcmVlKHN0cnVjdA0KPj4gYnBmX2JpbmFyeV9oZWFkZXIgKmhk
cikNCj4+IA0KPj4gCW11dGV4X2xvY2soJnBhY2tfbXV0ZXgpOw0KPj4gCWlmIChoZHItPnNpemUg
PiBicGZfcHJvZ19wYWNrX3NpemUpIHsNCj4+ICsJCXNldF9tZW1vcnlfbngoKHVuc2lnbmVkIGxv
bmcpaGRyLCBoZHItPnNpemUgLw0KPj4gUEFHRV9TSVpFKTsNCj4+ICsJCXNldF9tZW1vcnlfcnco
KHVuc2lnbmVkIGxvbmcpaGRyLCBoZHItPnNpemUgLw0KPj4gUEFHRV9TSVpFKTsNCj4+IAkJbW9k
dWxlX21lbWZyZWUoaGRyKTsNCj4+IAkJZ290byBvdXQ7DQo+PiAJfQ0KPj4gQEAgLTk3NSw2ICs5
NzUsOCBAQCBzdGF0aWMgdm9pZCBicGZfcHJvZ19wYWNrX2ZyZWUoc3RydWN0DQo+PiBicGZfYmlu
YXJ5X2hlYWRlciAqaGRyKQ0KPj4gCWlmIChiaXRtYXBfZmluZF9uZXh0X3plcm9fYXJlYShwYWNr
LT5iaXRtYXAsDQo+PiBicGZfcHJvZ19jaHVua19jb3VudCgpLCAwLA0KPj4gCQkJCSAgICAgICBi
cGZfcHJvZ19jaHVua19jb3VudCgpLCAwKSA9PSAwKQ0KPj4gew0KPj4gCQlsaXN0X2RlbCgmcGFj
ay0+bGlzdCk7DQo+PiArCQlzZXRfbWVtb3J5X254KCh1bnNpZ25lZCBsb25nKXBhY2stPnB0ciwN
Cj4+IGJwZl9wcm9nX3BhY2tfc2l6ZSAvIFBBR0VfU0laRSk7DQo+PiArCQlzZXRfbWVtb3J5X3J3
KCh1bnNpZ25lZCBsb25nKXBhY2stPnB0ciwNCj4+IGJwZl9wcm9nX3BhY2tfc2l6ZSAvIFBBR0Vf
U0laRSk7DQo+PiAJCW1vZHVsZV9tZW1mcmVlKHBhY2stPnB0cik7DQo+PiAJCWtmcmVlKHBhY2sp
Ow0KPj4gCX0NCg0K
