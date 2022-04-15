Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099B4502E63
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 19:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244769AbiDORqU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 13:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244573AbiDORqT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 13:46:19 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29E3B7C56;
        Fri, 15 Apr 2022 10:43:50 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 23FHbGiw024517;
        Fri, 15 Apr 2022 10:43:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=BkCv1jb9e7zzOgyDNKc6ANn7vi/p2t+usKDmpF3/TAQ=;
 b=SFN/2em+lqE30tU9AbFt8+0r5XRBObqZuhRzzJdxBUB8ghFdojQy2Mbg4A4qkxovxOlo
 k/xBMMfxLeAzlIKz/02nzLmkxOTCICzstv7zEHfzvD9NM3vyZDp7/lr8MDcU9O2WR0er
 dw62bEO/C9oLlLUU78v5enYCoEoP6ag8l3k= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by m0089730.ppops.net (PPS) with ESMTPS id 3fewgqc6n8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Apr 2022 10:43:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwbwAECJcRT4xR4E0+d7OFDX4GowCyxBD397K4YvF2YUXOYrmRe3tivIuJ5j2u0MFvwL3bYfOXz2i3zq0SyOeyLhYLlc1QorXZsnebP1FeN5QOJIdk5u/IJn76irh7LRwJy9H1RN4lLW1nnuAbZDvxVQ163xs1+/03F4ME73R85XWGtjuhO54XSR+xqgy4UNEUuqsVtKxoIG4H5nmbUrcyNzq9ctHlzm5KCBd6glq0/8p+HoKE5eA4wSL1RmgnUJPsdKd1Ix14YBV+qxiPD76FStMElaM3tnstqb7ytk/rEuc9gQRtzta16WblNM1+hBJvKgh2VigL8q9EckM2Gc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkCv1jb9e7zzOgyDNKc6ANn7vi/p2t+usKDmpF3/TAQ=;
 b=ixBIaGM20rGtZ4bpS1eBBqksnzuwW4sDsuslwWEbu1i7G0rX2LZeHoAAlcBsUh0xC5H3WnbVhevjqTLQjJxf50TlrpzcTgDGggMvVOy5bTrbbrhj6KXNz0Dd3ErWMWIxi0fiJg8ySvtYcDv9gl30kdzfKJ40hm20MBZPYEkLD/Lk3caoA6Mz47UQLdlWOSEIDEmuDDcnTYZ4z+lkklVLtq8cHyfS7Fcb9LWcL6qifpiLgbU0qAOIfntJ2YVqKHDapVjk2P3PDmf2zcWVRxyRhl32FOerxnw6IJHZLXQqilOSPP9ZtMDZFPAeu8SZoOXGfGppcwtiNYGMoMExjqkDeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CO1PR15MB4969.namprd15.prod.outlook.com (2603:10b6:303:e4::23)
 by DM5PR15MB1706.namprd15.prod.outlook.com (2603:10b6:4:59::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 17:43:44 +0000
Received: from CO1PR15MB4969.namprd15.prod.outlook.com
 ([fe80::8120:700f:26f8:b29e]) by CO1PR15MB4969.namprd15.prod.outlook.com
 ([fe80::8120:700f:26f8:b29e%7]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 17:43:44 +0000
From:   Rik van Riel <riel@fb.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "song@kernel.org" <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "hch@lst.de" <hch@lst.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "hch@infradead.org" <hch@infradead.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v4 bpf 2/4] page_alloc: use vmalloc_huge for large system
 hash
Thread-Topic: [PATCH v4 bpf 2/4] page_alloc: use vmalloc_huge for large system
 hash
Thread-Index: AQHYUOlZtVqcyre6jkeQP4tXYjuws6zxPt4A
Date:   Fri, 15 Apr 2022 17:43:44 +0000
Message-ID: <5e5e4759efef83250f9511d4ab0e1ba34f987ce5.camel@fb.com>
References: <20220415164413.2727220-1-song@kernel.org>
         <20220415164413.2727220-3-song@kernel.org>
In-Reply-To: <20220415164413.2727220-3-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11411500-3beb-4363-da15-08da1f077c90
x-ms-traffictypediagnostic: DM5PR15MB1706:EE_
x-microsoft-antispam-prvs: <DM5PR15MB17063B69BF9E95546EA2F44EA3EE9@DM5PR15MB1706.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WGUzQ1iJ+YEXSCUJuaWUhUMgLYoseMIRR/chalEiRWcV6DABc7cw7pyRlpOkPd6qrnFxcANG5j3BFG90fSbu21f/eDQ3v2mYHvzhQbS4exeA6HJ6gI6GD8RAXegINwGKtZwYU4fU+nCwl95++v6f+h4KIV5C3QN/mEx5oTqyfB4DkJRtETgwRSvJi3avjKcypjUOuNoEppJHo020J8opHRU5ShjoMGWEs4X+Wnqw3aWGeqlluwQ2Q/8OkrBVKOzM/DerATBSvXoO6YRRtyqr7DXnPGtOcstXYUdaWpH23CsbB+sBRKq2VxM8twEwc86lQ1Kf0ixqqGK5s/ZFIxZB6BG+GoxGwOh2TrhxNlilm/Khif2FtrMUKib0fUTknGXGrhLmAGWIahLULxMPSNSAUOEPO5Fd128KsQG+uGYsxArZ4t146bhwaAQWHTaXzoeMJ1X+JyO6V3yvOe4PGKhJwS/RwzoX3aMm9j/DUelNMiUvOYmPSs6iXpgtmBUp40mFQ4TqTNuGpRQXtigaFT01PTl2i0V62a4L+UI4BMsaxEBJnAnBXUhpaAlr9Nf8NqiVEshw2VyWDCvP4Osn9f8Ncr7NW1nR5Lzdn1B3V8vAgad1witbIbVf3zIWkzbwruvE28BQVYf3F7xfmjy4kqMVPXI7BtDGvgvc9tAO7jG5xPGAaRB2XZPQa/DTungOYm1zFUqReA9yiXwfMOeyqnM4ZfAqcgjK+tSFlxw565PCpho=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR15MB4969.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(66446008)(54906003)(38070700005)(110136005)(76116006)(66946007)(2616005)(6506007)(6512007)(122000001)(186003)(8936002)(7416002)(6486002)(91956017)(2906002)(5660300002)(71200400001)(316002)(4326008)(86362001)(4744005)(508600001)(66476007)(8676002)(66556008)(36756003)(64756008)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkI0WjljVzR5VXNXRGRFK2cvc3o1b0c4Ri9Eczl3Ukhmd3VkSWQ4dXk2cVpK?=
 =?utf-8?B?YW9hbEplNHB6Rm1nVHBodTVEbUpvdEN4THhFUzV5NlZMOTNSejJSd2lkbmZX?=
 =?utf-8?B?b0xLSENBcXR3SzI1Y0xZcXV5MkMwajh2cmZXNTVubjJxYllWS2swTDA3c3F6?=
 =?utf-8?B?OFNKeEc1RXlkOUE2bGNiL25BQ3ZQZTgzUXJWOGFqcU5LZXdoTDc2N0xkcTJ0?=
 =?utf-8?B?T1h1SXZjTUJudktlU3RxOTZPUkZIZDMySGJvWDkyR29sc1NyL2ZvV2ZpdEN5?=
 =?utf-8?B?bHZjQWhOS28vUW5OaDNLZm9PWCtSU3RYRTB1S3djK2Y2UGhNL1p3OVVHR2hq?=
 =?utf-8?B?SUNldVBHeUdCdnBIWmZPd1N2bUdtSXR2RFpUQ0VKZmFWU3VsWFd4aTBlVi9p?=
 =?utf-8?B?VXBsZ0VxNGRuMnNCb2ZsZU5wNkE1eFlVVmFDUm1sSnRoajVXK0FzTWoyRm9a?=
 =?utf-8?B?K25tcXZDNGtHWjVxRkpKUkFJK0JEUlhrcGw4ZVY5czRPT2M0elFQMWJVcFJa?=
 =?utf-8?B?NWlBWkEvdlJhbWRmZWV4NUVGY0V1U25mczV2dHJ3VS9GVlc0b3Q3T0thNHVO?=
 =?utf-8?B?c2tLUW5CNy9oTHZkYnR0S1U1b3NOalI2Q0VtK1pXdmVVZVZ0VVc3bnZZVmZi?=
 =?utf-8?B?ODRjSVhWOE1Oa0FyUG5mSCs4NlFpdGNTMEh4TmM2Z0trSlZybDZ3Qy9yR3h6?=
 =?utf-8?B?Snk0N1QwbmxvZ3JqV3F2aEtIK2tWV3pzQklXSTVmZVFkSDV3b3Q4Wm0yZGZH?=
 =?utf-8?B?Zk5JRE5TZmFhSERPNnJ6SzY1TGlhVVhtUWoyZ1F5SVdiWlYwUzBYYkF2ZDlp?=
 =?utf-8?B?aTJtRzc2UXFUYmY2Y3JJRGVFM2NkcHpUSzJOd1BRSW8xUy9ONlhrUUtqZEl1?=
 =?utf-8?B?VE9wSVB1TGFidm1uNi9oMThVampuaFBzNjhlazUvVDZncmJxRmtwd1RpR0xh?=
 =?utf-8?B?UzVNYTlCU1A2ekh0c011dzh4ejFBL3hlYXFCN2lqM0R6eGMzRUNxclJ6MWNx?=
 =?utf-8?B?RTVERmFYTmJYL1Z4RXRiTGdDU29GbDNqU09JcTM3VnNwQXJPaE9QYm0xaFZT?=
 =?utf-8?B?amMyTzhTcmFrMVh1cWtlYitaMmh3bEJIZXVDclV0anpGck9YTmVUVitkd1Jx?=
 =?utf-8?B?VDJlRVBOWXhXaGdjdHpFQkNhd0JYaHQySkg4dzhQU2FZRmlyYVUrTFlxUk9K?=
 =?utf-8?B?N2tJK0xXY2pBU3BHb1Vsem9FcHllbVd1VmF2dUpNamUvK2JjLzFQU3NpMGw0?=
 =?utf-8?B?QlVjdmRUeHVzZmp4UVN5Yk0wZFNJaVlFSjB3aUl6RWJDb3RYR3pVNTBibEla?=
 =?utf-8?B?MHJUUGRsTjJZbEFiT3FUWm0wYndaY0xWN3M2MEFVSk1wS1QwREhZbVNrRHdz?=
 =?utf-8?B?Y0RNbTA4NHFyNDV5OWw2MkF1QTZBWE91VjRQa0J4OStFUmJTb0NzRnFWbS9N?=
 =?utf-8?B?MzBLTmdKYnNlZ2lLb04rQU44MUk3R1A1WGIrL0JFdzhDaElNbXJuS0xSbEtz?=
 =?utf-8?B?VVdkYVlZY1ZDeitXVlJ3eFNvdElmcjN2dVh5b2IvdXFTUjFjUWxya2xabjll?=
 =?utf-8?B?NkpUZ1pSYUdYR05oV0NMb2hzSDFNN1krYzNqZDlEZG5XSHhIL0FMQlhWZUgv?=
 =?utf-8?B?OEVPSWdHMFlNaWkrSG1VcGVCMkw3dURBZi9sNnFRbDZVZFRXeWRwVUN1NzZk?=
 =?utf-8?B?ZExUM1lBVFh0cWRIRGxDdVhnSWdIVEFEOThtTjFaa05SbG1MT3pxWi94eDhi?=
 =?utf-8?B?bWJGeWRMKzlRcVo4L0g3RnFwRHZXZXVBTWZoaDVjb0RxOWFjN0VqOU1zT1RO?=
 =?utf-8?B?RGFsRFdiaVhYait2aGZTYVNlbHlmVTFFbysxTzUvdjBHTHdHZHE4bWV3aW9Z?=
 =?utf-8?B?ZmhxZjdkRTFrTG8rQnp4Ni9oMXpKaFJZOC8xWlJXV3oxR3RBOWx5VldjS2dM?=
 =?utf-8?B?NHVTcmxzMHExSzA2OGFUL2EwcFV2N1NFUkY2dFdLOGkwOWlYTWFtK1l5cllN?=
 =?utf-8?B?enBxU2oxd0Y1dFYzZ3JVS0JhRlF2L0J0cUgyUmsrSzROeTU0VSt3QzUzbkl5?=
 =?utf-8?B?cmZYL0ZNQnFqVFJlWGRQaUUwQ3J3Wk5uYkZwWmpQY3VUMVdHL1NHQUljR1hm?=
 =?utf-8?B?VTI5UTV0TU1ERElLTzZwZTJqZDJuU1hYQ3JJOXR3N2pFbkhyTjVaQTFqRmZl?=
 =?utf-8?B?SjhadkIxME4zY1pHaGZMY3hJaUdvbDJxT2lOQ0VKQ3lVTzkwS3RLajU3Y3Zu?=
 =?utf-8?B?Wk9rczBKT2JreEcydURhTDliWTZ4Tjh4U25TM1I1MklHdEhiQXNWWGNLOVQr?=
 =?utf-8?B?aDd0Z0NIWTBqRnNHUmpzTkZUUFNtb0JUbHVNM1dQeHdLZkladWNDRElxNlIx?=
 =?utf-8?Q?oWBJzaxPF58GIads=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AE497C0F99BCA4FA78ACDBE2C9C7CA4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR15MB4969.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11411500-3beb-4363-da15-08da1f077c90
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 17:43:44.0665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b6rSSKzNw35EeBKS2jtFCfVm4axeuRvZbwlEfh5gBb/GFsMt4yobw6LFXOcdfMXI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1706
X-Proofpoint-GUID: gA18Js8ouIIiRBtj1vM3p6jSiL-oHKfO
X-Proofpoint-ORIG-GUID: gA18Js8ouIIiRBtj1vM3p6jSiL-oHKfO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-15_06,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gRnJpLCAyMDIyLTA0LTE1IGF0IDA5OjQ0IC0wNzAwLCBTb25nIExpdSB3cm90ZToNCj4gVXNl
IHZtYWxsb2NfaHVnZSgpIGluIGFsbG9jX2xhcmdlX3N5c3RlbV9oYXNoKCkgc28gdGhhdCBsYXJn
ZSBzeXN0ZW0NCj4gaGFzaA0KPiAoPj0gUE1EX1NJWkUpIGNvdWxkIGJlbmVmaXQgZnJvbSBodWdl
IHBhZ2VzLiBOb3RlIHRoYXQgdm1hbGxvY19odWdlDQo+IG9ubHkNCj4gYWxsb2NhdGVzIGh1Z2Ug
cGFnZXMgZm9yIHN5c3RlbXMgd2l0aCBIQVZFX0FSQ0hfSFVHRV9WTUFMTE9DLg0KPiANCj4gUmV2
aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBTaWduZWQtb2ZmLWJ5
OiBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPg0KDQpSZXZpZXdlZC1ieTogUmlrIHZhbiBSaWVs
IDxyaWVsQHN1cnJpZWwuY29tPg0K
