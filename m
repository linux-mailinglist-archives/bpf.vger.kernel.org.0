Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D56158A598
	for <lists+bpf@lfdr.de>; Fri,  5 Aug 2022 07:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiHEF36 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 01:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiHEF35 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 01:29:57 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62006E2EF;
        Thu,  4 Aug 2022 22:29:56 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 274MOCUu030800;
        Thu, 4 Aug 2022 22:29:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=tcw0iKQ+LULZHMxNxXemHJ434FM7qOFD78/RQdhsHlM=;
 b=mcjs7CZbEXyV/fAS1PF1sx3uSbuTeEOiDX2U1eZug4LcAM2RILqbOjr0MLT3fpEuVpBo
 t0KmF/9zMKULI+ZAMxEQl6sKHRFEDjPLZdVEPhZRYNdslzE2inaLoBQoAyzMr0h4VMlk
 Cc0ac4JffVH3dNyLLBh8OMqPmZ3zpa5xV+Y= 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hrb6nek89-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Aug 2022 22:29:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzQic7ue9W8JPQDvvq2Nr7CTEJ5dPGKlVzZbVi28cFpu2ykvTWzM3laCXvAktT6ssbQXHnz6hUugUl4xWOkX3MjQvzyTkGaUvjmYzhCF56+YbDt2sUxxl6cQKDtayVQkIpXqpap/w7Rf8c0bIklpazVX3imb9vpYYpeerDSUZhK1akaceZTkK3I4lyhwUnCywzddtaRexTy+rBLEjqLUg2Jkm0UbUviPRe1lQBg/X1CkZ44biv7BuKgxnCuyk6c9lzf++OnD00oHWaAhSmtty+HAO5vl/AZHVM3oBJzrHfSGzt4z2AlteWZ58rscKc76g/qRVsaBpFOQA5J0wDuoGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcw0iKQ+LULZHMxNxXemHJ434FM7qOFD78/RQdhsHlM=;
 b=i5I4Zcnp6NdUJIHZG1siQgxai8eoMKh9u9/OOiwGDyvWfIT2LC2BwoqxVgvYfuZGlP/urdJD1l6lxOyR+5xieUKhSj8yav0vKxXSkxOc95P9N3He/hFUTNGhA75dyN7lXhEUopSOUKZEdCcQ9kfxv/jtnAxmE4MORYStyOKiYiEnpKyS3gPkmQ8kWp5gZtrKmR6en8TxJbzOw0pmHO55WyMrlzIsHR1zl6xgysK7SppsqhgwO0QT3ZxRv7vkeEl0JR5ix51trOpUqSmlrCydzfXwBl60vuX57luELlV9QtwGyq4KhXg7T31ewkrzZIh7V8Yh4tPAeJcHael3tUzF2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM6PR15MB4056.namprd15.prod.outlook.com (2603:10b6:5:2b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 05:29:52 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da%9]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 05:29:52 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "anil.s.keshavamurthy@intel.com" <anil.s.keshavamurthy@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next 1/3] mm/vmalloc: introduce vmalloc_exec which
 allocates RO+X memory
Thread-Topic: [PATCH bpf-next 1/3] mm/vmalloc: introduce vmalloc_exec which
 allocates RO+X memory
Thread-Index: AQHYlpK25UY5kW1ND0S/krM8qG//OK18FxyAgCPUggA=
Date:   Fri, 5 Aug 2022 05:29:51 +0000
Message-ID: <DC201D0D-E51B-42D7-9B3F-194D929A5E9C@fb.com>
References: <20220713071846.3286727-1-song@kernel.org>
 <20220713071846.3286727-2-song@kernel.org>
 <Ys6cWUMHO8XwyYgr@hirez.programming.kicks-ass.net>
In-Reply-To: <Ys6cWUMHO8XwyYgr@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5037842a-90ff-4a2a-1b64-08da76a385b0
x-ms-traffictypediagnostic: DM6PR15MB4056:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aSwgknjNTHk1q2uYLEC7bHwjrCWS2m19szRf+B8yTXCWGGayTeXmYnvx/V7CIx6vXZilcgzwwCPUGCwXV0DNNmGkcdIrtbd/ZsTfgAjPmQXoGJrIkA0cQlP7eTIT6qExsgb/AmjTYClWwk+iSUYyv9Hvhvu1l6KZHC8J4SgeT43iz1xtBApeMosAvil4xJHMX9hAZTV92IlWOute8pGTgimRIoBOqJqhY/8IPv8211Cab6kijUXdAGlvi3O5IIrRdOk0xRBTJ720h7tWbMt3oHUX8Id9lQ3mB8+G3XtwKav1MgYQV2/coou4E6yvD3vKskL08M4gXwaWAZR8HwarJD+p+dTLx3J+8WGg/5XJaZYxXFVZIbWNu4Oe48z0TYeWHUEpst04FvPNX4hKndn7wpcXYqeCQDoghY25LKNAIIfGOerTyTjmRpTlU9F0JlZGbH+oXOdEvS09Mas1zcwE/smkFwavmMoQViHy0CdTU8SztstMink57rjdBnR+tATcoI5+0Kpj061Y/bjlIjaDekeqm7YeJchxr9RTjh2Per3z5hMrxSFiPDxmVnoRNg2vK7i1JjB4FBhKjePb7kqkST+MIiagpJoUv78/2d2L0WOWO3p4awdw8cy4Ria4zL1dEqExk3BXRGxB6uRr6SQQ+4VZL9t7lxdh3UnHeohTbmF+/AUMkpWS+yuBBoICW1da2wsD9MTfe31HOEqsXKUEvK+WFdzZrvAlWA5Og85V6lpKk5zYwEnxdEB5P/FAG/h+LkdKfZ4YNlGx5g+Ccj60tF5KVjbgVh68iDJKYxnTOF7cHlulAD6EG9Rb2AfrW5LnnQsysLdGoEQ3PHMynx0X+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(6506007)(2906002)(6512007)(41300700001)(53546011)(478600001)(36756003)(7416002)(6486002)(38070700005)(8936002)(33656002)(122000001)(316002)(6916009)(4326008)(8676002)(2616005)(38100700002)(186003)(5660300002)(86362001)(64756008)(66556008)(66476007)(66446008)(71200400001)(66946007)(54906003)(91956017)(76116006)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lDKduxP+vvJGgaFUpFRvxmFlFvFrW3QKoC/A/BAWI/0WXnKcEBN68k6qqMMe?=
 =?us-ascii?Q?J7lD+vSNBivXAektDn+bufftpcbKaI5oAWBEbO5VUsGNo/KmP63nGbnmtjUn?=
 =?us-ascii?Q?KN6Ikre06lIMjpuJXOyG6LN35wF2QkAFm5McIg6IdsnBIIINDhSaEoZDS1FV?=
 =?us-ascii?Q?M/ytbue6kaH/wkpPmhpV9RiLo2pGb/qy/T2a9k21aYr5lcai1orRLtDpdO1f?=
 =?us-ascii?Q?bT9p74VXtZIt/sk4Nuqq5w3q9ewWg6rEcQIfL+t5o0wSLiB8IatwIvSUYZzW?=
 =?us-ascii?Q?sBFtpaWmshHpkLvhEiq7dIlKvkAwuGe6eZ63YzScewHgjGXDTRY6sq6iBB6P?=
 =?us-ascii?Q?GdrBJxanHg2l7lKEn8e+Oc3HHglsFa4ZJNFHFOXvQmQnZl9Kos3ZN64Y0ZUe?=
 =?us-ascii?Q?9j04MqmdauGubs8feml1uGCUrVLI2NqpcibrwEFbABYAlpHJx/DE+G7lwA4k?=
 =?us-ascii?Q?Sk/YzUjtjZI7GrV5Rbi+5oaFNHbgr0/d9snIS9GE/F3Y60h5hDJ6aICgVk4m?=
 =?us-ascii?Q?hDLI5+maWDO8FpdiENRwvLaCftx4zo/naD5SiVHXnnPeSgJ7h0FR+pZGYNnN?=
 =?us-ascii?Q?DNPfZgRVZJZ0rPS29d+k8vKN4LvIEOU27rBsdugAASgM6ZbbLD996V9pWWJa?=
 =?us-ascii?Q?mgZmAYcNjjFeDMM3OMbqpQCPZNoHOCRu5MP038vSRhbise1xwztL2TcwqQ6h?=
 =?us-ascii?Q?G9QnSiUVJJwGylk8rybdLmTtTky6A2IgNwWXpilvolbO6v+dXExKYKXA6ccL?=
 =?us-ascii?Q?scoWehROgWnn0A0lelC+sr1hp/RmtI+ZwCf2+/vx8TfYGsS5/kNYr/COzyqE?=
 =?us-ascii?Q?QauU/CbOp2UPCRrv72jkIhY2Q6uh9yWCGxVyGeaVxwCn5lfLwvf4O1IXEe3i?=
 =?us-ascii?Q?nTrKZKkIKoKfRXXMLdud9xd2Qw4Dmh9VJk6q8iDnZENmDR2HMOpgVU9v0aUI?=
 =?us-ascii?Q?2nIxq/LmObNqAgpPUZP6enAKF9xuco6ddE6dnI5dBS1tWeCDIezL9vXLimuV?=
 =?us-ascii?Q?rrs/Ts+C95EhLuIb2PqRezEUJl2i2zH0ckMcZ4HrILvvtB9NC4hhpelEWODQ?=
 =?us-ascii?Q?gBj61NVOczy0u1OSOnfPyVzHA7FKTWJw3dlNzVavdQQZ1YLi58uYRpq/OaVm?=
 =?us-ascii?Q?k5rrgfcEgYY+xPtx76FsrVdGRwv+NpUGeSKK4uoI9dSmSGe+4FLcxT9sf86F?=
 =?us-ascii?Q?ISKk73nm1BtBntSrjWV1fr0hizceUBwTlku3B6qz/3qEx8tVJRl0kx1LA4OI?=
 =?us-ascii?Q?bd8JuRwAi06U3JiyCxv91aV0O4+zpNISdB909nYDwk4eSbR6awgaSGEiFz0O?=
 =?us-ascii?Q?mUrm7ZQUfECstuTN99+Dz+g2JE7rZmS7qxHMIMAPlbLfrcYfXC0Or2Yh/hWa?=
 =?us-ascii?Q?6DRnD+CrmroNg2mAkLvwNxN3HSQpEZGbzX1n4kvxP0PDVoxqW8F+sKfvJ8Vi?=
 =?us-ascii?Q?YkC9p8uV5ZHPCLv+1rFISTJBJ+gR5Ea9jVukbVlXInJ8Rerue1QA763pi6B4?=
 =?us-ascii?Q?zSV/DT7efnRIcoZu3Kq2UtOGeZ8Q0emAU7cfZSTb0VR0fkozkNkGem2lOtEQ?=
 =?us-ascii?Q?LwOeCqhHzIWkOu4Ih6cBGQI8QXDMCQ9i+ALKHd6tN/EtYW/8uvnXoM5J9HOe?=
 =?us-ascii?Q?7SlXnlmk1lUUiJ2y2K+AoyI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2A718FF731656141B0DA383C714CD85C@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5037842a-90ff-4a2a-1b64-08da76a385b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 05:29:51.6786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wNpUAYDCfQYNa06Lq7FwsFJaGBFYgbiLe/xCSRJXPysBksSMW2IANEsIwF/KNVQwzA1ZoWnvihw1RQ4ppUFqFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4056
X-Proofpoint-ORIG-GUID: iz_Y62ONZSD0FfmCBquEMNwmfNA-Zgc_
X-Proofpoint-GUID: iz_Y62ONZSD0FfmCBquEMNwmfNA-Zgc_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_06,2022-08-04_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Peter,

> On Jul 13, 2022, at 3:20 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 

[...]

> 
> So how about instead we separate them? Then much of the problem goes
> away, you don't need to track these 2M chunks at all.
> 
> Start by adding VM_TOPDOWN_VMAP, which instead of returning the lowest
> (leftmost) vmap_area that fits, picks the higests (rightmost).
> 
> Then add module_alloc_data() that uses VM_TOPDOWN_VMAP and make
> ARCH_WANTS_MODULE_DATA_IN_VMALLOC use that instead of vmalloc (with a
> weak function doing the vmalloc).
> 
> This gets you bottom of module range is RO+X only, top is shattered
> between different !X types.
> 
> Then track the boundary between X and !X and ensure module_alloc_data()
> and module_alloc() never cross over and stay strictly separated.
> 
> Then change all module_alloc() users to expect RO+X memory, instead of
> RW.
> 
> Then make sure any extention of the X range is 2M aligned.
> 
> And presto, *everybody* always uses 2M TLB for text, modules, bpf,
> ftrace, the lot and nobody is tracking chunks.
> 
> Maybe migration can be eased by instead providing module_alloc_text()
> and ARCH_WANTS_MODULE_ALLOC_TEXT.

I finally got some time to look into the code. A few questions:

1. AFAICT, vmap_area tree only works with PAGE_SIZE aligned addresses. 
   For the sharing to be more efficient, I think we need to go with
   smaller granularity. Will this work? Shall we pick a smaller 
   granularity, say 64 bytes? Or shall we go all the way to 1 byte?

2. I think we will need multiple vmap_area's sharing the same vm_struct. 
   Do we need to add refcount to vm_struct?

Thanks,
Song


