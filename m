Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C5858A596
	for <lists+bpf@lfdr.de>; Fri,  5 Aug 2022 07:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiHEF36 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 01:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiHEF35 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 01:29:57 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881026E2D7;
        Thu,  4 Aug 2022 22:29:55 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 274MOCUs030800;
        Thu, 4 Aug 2022 22:29:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=tcw0iKQ+LULZHMxNxXemHJ434FM7qOFD78/RQdhsHlM=;
 b=C7VmWaVebc6MSXs/BT3RvyM/en6p3GyVsszRsQrjGZeRjAnrP9rqVIklVwS7MjEi11wx
 VxuHQ+M0LU/E0t/UMWfTmX3OI0yvubV3vwqfjkR2xFof4xf9DseM6QQRtMkMP0umlkMX
 vCJLF6X8N9e+ClDdpyv3qg/8hnYSVJua59U= 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hrb6nek89-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Aug 2022 22:29:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1TTWDVyaVm06aNgUwIiSTt3RaZeMps9qpbsOLS3JLkv5S6lsOcr2QaVgwI0nOaNmsJ48QBHdwOxKxUjlc8zPJZxzPONo5z6oNCAJG5PdAZ56+IFhcglKGpXPSiENcxNo9oYSc4SFZpYnTphVGY0iR7nvyU9CYeAeK6XGFK062mqzKaL06LaEHQM77kB1NglqrOxJTwkCG1mhIyM+1bgETB0n/FcpOQFNaO1zrVnUu7LcP6JErsWYz4zpFtqx4hsh1ovxJ3arKsRWrO5arUJH4Z9XUjXw2Hi9U0YZNTXWUV5ZPYHzZwlnbXIqoAbsHWtcUelXjVxIWcjo2oNkQT+NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcw0iKQ+LULZHMxNxXemHJ434FM7qOFD78/RQdhsHlM=;
 b=PXJEvaf9acbT7KX1rt+GboJ12rMk72S7udmiFS/pdr2C55oY/j0LVmhuNioBHtpgHWSi26GB5U7gFVtc+vCU1h9he2hOZQ24vyq+pqcWjQ7GobZBGHOCZf9fdQCE8mPYoqgQyUBZAFkVKq1Nt9QC1fXAe6KeT6pW/pU0yiNIvroXqWO9CHyOAzicnx/hDj6Vni7VnBI4ztpAveIW3q55U7XD6Ug8MBfZnFFsE8mWkahN9u/uIg1IhwkkY12jc4gMZ09z9eOWFYvqaGvopHA/nmmiCmnv3WT4F/gstvlJlIJEcgWZjv9TkFPMLWB+quV/X3jJ6FdeOOZTYHDfoudaQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM6PR15MB4056.namprd15.prod.outlook.com (2603:10b6:5:2b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 05:29:51 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da%9]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 05:29:51 +0000
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
Message-ID: <14D6DBA0-0572-44FB-A566-464B1FF541E0@fb.com>
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
x-ms-office365-filtering-correlation-id: 9e8beff1-706b-450e-3c27-08da76a38528
x-ms-traffictypediagnostic: DM6PR15MB4056:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: blaEldDfVk+UMaZEMV8Z44eHI9xEf7heabKji/7dgSP/JgJnoSI41yn0XZv6jmt7QNlaP58c5/S7s3QaqoBYsav8oHoTUq3xjhrtjH7zsyrQhTPqYJrLu3H0suzLsO338t9VTfqMwnzV377X9YqenRMU8icpsOYkqT8rw5+TEPS3tfEb/s99L9fuwU0FqSYNpFEhwSdDm9r9MDhv2DLDHOWmkz2hDbDtuy81XY65md3RUSWqqJfuBOwg0Wtfh6XUHtfnAouaeEebkaI1uz2iznrAXnkaunNeb5cf2/laiNSD4noeakiOGUjKs9CaM1gTj6CrKSL9gw6LnMh7aG5jAkmR/5Jtr54adUgfJh68iKJ6GjEQ6i7YnFXYYHMEmSYCh56dDjUQoEoK4ee+XwmdF5U8YCB2WSwwCiKX3OvimNTxMVE2ahs4D4LJnQ7DGc1cnAncMtpRcrSBUAbpgP3XMWH7Jm9KxEl+ihny4riKXIyTDxLl4ZkCuKdhazYb5Ys4b4UGEEb2xrS0tjrGkoSySCBcwp5oRIl7wPZs+2HcvtqjHONx/IpiRlGNr6riI9munS0mWIZxHBLLjk3orCj66zNH+XO642uRwCU7VKRwEnIHHDNt3Ozea+ZNwaS/Lx1T6jR4DaJfsB/ngrcXY+TwUJgJ8NYiYLjSZ32vn+XJIW838FuzkBqPH3esyQN6NNDn5LXLAlvB0owXsLvtSc2Ij23QhvrJO527Oxu+eBVxXCCxTCGMLQFMVQLTFv3QNJO320+DtF+30v2DdIokDbVUPKVQN5hMOf7RbPu20IlBh24Q4vdGhtjVfI9HK+J8CJ60SIYHlWEQ4bMVC9Dl1w+2Uw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(6506007)(2906002)(6512007)(41300700001)(53546011)(478600001)(36756003)(7416002)(6486002)(38070700005)(8936002)(33656002)(122000001)(316002)(6916009)(4326008)(8676002)(2616005)(38100700002)(186003)(5660300002)(86362001)(64756008)(66556008)(66476007)(66446008)(71200400001)(66946007)(54906003)(91956017)(76116006)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sv1e07CyyKYLOqxEzMpR2cCC0AljLAbvHMJXWIbnZq3ASl8ciTSirYJTy6ju?=
 =?us-ascii?Q?KZMnDcttJbczCQomg0BJaC93eISI3WP1tzhevY5Xnm7RH2DP6B89VqCxtB3l?=
 =?us-ascii?Q?+KIsxFK8CKv746aFZ71IKk2TbO1XmdbsfCvSH2Yz6gqpSR4n7ZQt96FIiFoy?=
 =?us-ascii?Q?XQdSKRtxJL/dHUpXOG5xHasIxHOEWEaPoig1Vi9lm6augRWCu5sDg8TKrAoR?=
 =?us-ascii?Q?dESy0ATzwjcti06BriPIIbGGaETLbHZ4hkLzx44lJca1C478X/F4AXulPE09?=
 =?us-ascii?Q?cnrTWELDuvliUwyDmdirNbdPo8h7uViDavuCTArZBAuYyewMmjKNlqsQ7U+M?=
 =?us-ascii?Q?ub0v0385s/4s4xoBOP5yr1TfOgM2NhLzYaDvEwH02Nu+pdXwtSDVG5P3sGZo?=
 =?us-ascii?Q?LEFg+Hq6tNY9pPHRSvohdv+lFB1NkJZDaB5m4vNQIxz0By+Vf8GrIplUu3u/?=
 =?us-ascii?Q?OAMyCRfNGhYLaAeskG5YKov30ZCDEUyBb5ly5AmY/jjj0I6m6/vRV/DzheMz?=
 =?us-ascii?Q?iVU+XzMGELX3BldbALJhpc3xV2+shZhamAGouBJVStLBPIawcMMRgHm1P348?=
 =?us-ascii?Q?TN9PfGYiI1mmtYYRh9eNGaenw8As+jQWg3tjaU40LhUq4yZWQBoWa7a8vi9H?=
 =?us-ascii?Q?ZWOKjHVCLC+JNf0LK2hwYGaOb4TWUWdVcqiEjPmOcS1qmj12IQ+bNDafv4Ap?=
 =?us-ascii?Q?BMpo/jCUFZAkYF1Oi9bKIG3aFLN7fGJsUBKsul3joo36EBZinvPWYNwBf7q5?=
 =?us-ascii?Q?Ogw1ndH/ctuPm2pY6pkOKQoDyTWmpJ7LiOE393X+ntF3aZKHVI1bETZKImtY?=
 =?us-ascii?Q?T87qMyR3OjYhXQM+WbP26rIxNxi3CHFwigx722+CTxYi7+hRMtPuyHWDPO0U?=
 =?us-ascii?Q?vGqT9wGoJbWXyJqMf/rTPmiaE82bIh47ms4PvH4M37AAKAgP1jxJa3zvARHx?=
 =?us-ascii?Q?jNHhD5mn82ve87gF+4v7V7vL8ejFqo4F0wAWYAZPC5H/ITnwG78qCz4/7wYv?=
 =?us-ascii?Q?ZP5QpAHASYv2Qv/uuhRwG8AHAuPzdV1BzqhFue6AwF9qOtCpgnsVu8pVKDZZ?=
 =?us-ascii?Q?qCKegko61Q0ccbKpmGBWILYTANzVvIq7HSaNF/ML0js0rr8gLOOuxjEe4B++?=
 =?us-ascii?Q?qLZ4q0DJaXtSQ7emGGo7Xyfq+R96aSoxG3tazPubQRSTTcA6sLrEK19SzUW2?=
 =?us-ascii?Q?mMjaDDS8jLT6eYY2qPfxqzwBvg/GlpMaVrn8EjCU/G2gYoCpGZQXrqepxTcG?=
 =?us-ascii?Q?xViUGbfk74xDEaCYSz2Bo4aoH1wH9cnyWq/UWtAqP2g72BSELkdY/WrXrhTq?=
 =?us-ascii?Q?qsSLNRvYKizdZv2lpbG0g6aslBVYPVO2D0X5WmMADBOhqTYVC/y/SMpYy72y?=
 =?us-ascii?Q?5nKySY42l8v6zAeQjgnVR51VljXE1FI4HaAmPI/TA5Fd1zX38IhflZ1hOomV?=
 =?us-ascii?Q?H97puqXb+pet2loyxwRuVOgBG5G5OSVt9NGnGuTmP7s8k+fJoGphQ1vWdcu0?=
 =?us-ascii?Q?CXFiRnxFiVkHRL6b4GOQ6gs7R0CLC/m1I57MabUOgJFz6SpncYW3o616YXKB?=
 =?us-ascii?Q?AeVnSlgobSsZimz867xoiQSrqPcEv/wKRuyjv2UhMPz334VwJ11tq58gmXVF?=
 =?us-ascii?Q?Mrp6Xow1GNhrfJxivCfaOKo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ECECF3FB1B796A48BD63D2AE2B3B6FB5@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8beff1-706b-450e-3c27-08da76a38528
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 05:29:51.1787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/Fjl/U7gjFiPJzJMuIUCwavS3yJVvtzQbbSvN577LJicw5huuVxiuKAVT8oQ4Sjd16RcIGIdannJPZCLGUdeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4056
X-Proofpoint-ORIG-GUID: quOIp4Kurz8vOSovoShN41zN0ffaJA7-
X-Proofpoint-GUID: quOIp4Kurz8vOSovoShN41zN0ffaJA7-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_06,2022-08-04_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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


