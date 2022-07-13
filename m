Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE503573A7E
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 17:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbiGMPs6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 11:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbiGMPsp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 11:48:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FDC62DB;
        Wed, 13 Jul 2022 08:48:41 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DEBUcs018107;
        Wed, 13 Jul 2022 08:48:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=axQ2zGoFT/7wLND5m5O9a1QwfCcLT0dXk7WkBSflrL0=;
 b=BhZIwuszFp1+wL7DfYs2jW5stcqi0Iguu6HFSOOZnXqJfrG8flPgve7n0aGVro5ESSQs
 TpLErsu81X0Ou3o8dHnANBAqkJ0bxYR+Ldxf02tjDum1FtHtZ+h3Kk9oLu/QIf6l6n0k
 6LrU+xXJTcP1VBVg8ogAvC4ym0zJ/tc7gE4= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h9h5f4qe0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 08:48:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTBZdE7XYI0yNMzA28OUc5TDdEr6uglnjp9ERRMIEoX+UBQKE8Vk4g0TucHgZa8btdMszY38ltTrttZgVOAR8ygrocc761iCG1sNwVQjSjxYXwrAsiMMvX6Y//Q9O5zHshhTk8jVXB8GIhhPzYUplZk9QUx/IaR4b2KaHvqMofh3LRUr12vjey7oOihMSxIttSlBGfYV7R1Hn4FoxNSFvd0m5fib6uqwM0EKuM3bB1XuwDo2M9gILTiFCskNSG4OR3c7pIdMONdXRZFN5nf7ewsetsktuR2ycN+GL6J6+y3RLP6nxdkGsxOwSh5io9LdIjOBIEUMh4MORIuJgj/U3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axQ2zGoFT/7wLND5m5O9a1QwfCcLT0dXk7WkBSflrL0=;
 b=A8VMOVgQHSS7YX3vS9jTU9aSfQ/IuMNPs4B2mqH/IHK9ZUpuejavZIef5c2l4P5qeXINR1jTYE2+VNWjoCG7USHlWXG6INV/DpZECrzYGMpppY+exYZBoIEOSXODaRjI37ZsLjnKAIi7kUO1IPAUfO0lmmpQ9eXEDTD06eImZY6czwJ4JznslqIW6vR12HPQ1T9FdmIuGokKKN2kil00xgLCAGJAxJQDzvhMQfM9H7uuKWMKI4wRFX4XQgaGmItOZTDm4xn19QzypJI8JHdpF2/eNbhRoozP3sPMIWOD/0fW02S8YnqDkhU8tKj5lDjp4gxGa6RZjOCoGSAKl2ntYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM6PR15MB4297.namprd15.prod.outlook.com (2603:10b6:5:1f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 15:48:36 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::5de3:3999:66df:42d1]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::5de3:3999:66df:42d1%4]) with mapi id 15.20.5438.012; Wed, 13 Jul 2022
 15:48:35 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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
Thread-Index: AQHYlpK25UY5kW1ND0S/krM8qG//OK18FxyAgABbw4A=
Date:   Wed, 13 Jul 2022 15:48:35 +0000
Message-ID: <7C927986-3665-4BD6-A339-D3FE4A71E3D4@fb.com>
References: <20220713071846.3286727-1-song@kernel.org>
 <20220713071846.3286727-2-song@kernel.org>
 <Ys6cWUMHO8XwyYgr@hirez.programming.kicks-ass.net>
In-Reply-To: <Ys6cWUMHO8XwyYgr@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4be26d81-0d70-4119-dd52-08da64e725b2
x-ms-traffictypediagnostic: DM6PR15MB4297:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JS59S/QtiBCf/0ZVy0LvILoooMqsPAIq0t7VGPiA9ER+4meWF22VuQD8VEyWt5063xbHTgQ0PnbKx/UcYVBXdDC0YJaEoyL6KbZ0m/Lb9u76QXqK/wsPu8PSUgT+dLTuCvQtc3afpe02zup6zjvrjYoR8GfSYqYvfp3HFDzBA3pPbbSEo/2ncmBLjPlbE56o2r+JSniTStE8VSZHU7i1XKBXJN3pZRzr/9f9XNpdFzo8JYtd68B7WifRwVKzWn0CJ1Awg5voxug9ueCbvTVoaWKMWFZd20mB4Sn24aBRW4T49Dv+KBn6s7zyDgp4Z5LorMpETd39ouiV5KIqmx34rgfNRZux8jbkvMqXQsMUd8UXlr5vZZkQdAL4SlsXWlqa1maILmYexMKbvnHbnR8g2OO6oochoC00azDCON8oG/l65Tk4oCPfKBlWhmCAqPmvu/uRirNiKpud/Kwnotbh7e6L/jgjLBxFRooEtTymT+mK48OXSTnHV+1HD26wRrwllLsjvXloe2BGmM08MDfGYltCZZytegS2Pru7Ycw5GoMdZ8jmKgr8FRmjffkJsJkmuhcn7k7gHfSS+EDOVe5vDQACJExE56ZTV7olF97ncBJ6mF/ucu2DrpnekdtKOa/Sc+zpbOhKcl/IMNwlmIsALyRqa3P8YWfFYSQUf2vNEgSnfma8Q4zUxYlTwLW1jtDmrXsyCFBXGe5wv6I4VqtKiJ/YjI930y3jsraA1L6poPo+J1/UICASPULn+B0tOyT9NDT5lQI+jF6Grv+NPcKSrRVKnXm4/FfA9SNqmT2xfwEodulIvC2xwItuYLtr4d16uPwuTzhWhnSIcX5OOdDjxagKZoxrzGjwpdfRB/SuNLI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(478600001)(86362001)(122000001)(38070700005)(54906003)(6486002)(2616005)(36756003)(71200400001)(53546011)(316002)(41300700001)(6506007)(64756008)(76116006)(6512007)(66556008)(91956017)(33656002)(66476007)(6916009)(66446008)(8676002)(8936002)(2906002)(7416002)(4326008)(186003)(66946007)(5660300002)(38100700002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2CMULXxOgKEYNi698WQ6S2TeeDXfBlWvNbUp0Snx57YBXL/eDZJF31zJMfOT?=
 =?us-ascii?Q?D8qy77cpZIjmK2yVDNCbFLTJGoxHqtiJKYtl93cI3lva3EznCpFtwGRvM4Ry?=
 =?us-ascii?Q?CDgTJSlr0byrXOtZCyJyHSo6tTNZZm+aiKSOQ5l877lvz3lSeftnXEjWG7SU?=
 =?us-ascii?Q?pUyq0s5wPBQrUkKMy9W5zdxQuNlNAFON7q6cXbVSiK9U9C5kaMpIkP0YPUyw?=
 =?us-ascii?Q?2zUyWH9rClUaPL/6O6oRwU6bqo9mT5tnYQN9eUeDlrg98X9E9dWDkt6PvQ4g?=
 =?us-ascii?Q?bWnyxHZ9ola2fYhUSMLX7KWkGsGhxJlFthbZW51cy8pcDC7oMnPyk6E3yH2K?=
 =?us-ascii?Q?4gYBYakTmApI1JL/n2zfYZDgKFXBx5pc0rgTABYqlJhMkvc+xn6CPFBzosB9?=
 =?us-ascii?Q?Tm6KcesOU02TFhipqFk9fuUApzR/hYkB9ZlPzwj/abAvcoKKoUUjF5nkhev7?=
 =?us-ascii?Q?8KCjjMJtdqieSHrDcf4srrmZRf0IRupQjsrzeLRMqn31DlEOmjkuIE99xlQX?=
 =?us-ascii?Q?7tT5BlqZF/lSntuFovHp7d5NmlftqHRPYiW73P1l2QJ4Q1ve3rgaaPfvWYe7?=
 =?us-ascii?Q?4z+cGf6ziu97fxms3VSX0yyGTuWqJecJtJzXLZgDQo2uSXL9OO8ZrKtZ1h8r?=
 =?us-ascii?Q?zzDhIo70DAbc4VLT6hXXI7o2UYfnK49sKzSv3EjmC1smZyiBAPO3fNfzxLLF?=
 =?us-ascii?Q?VicOd/GZNrTJxs/2oBOu4JBWbaGslbyHKD+zbbVt5lZZXCMgZ+mXqLLgLanp?=
 =?us-ascii?Q?hexRgTIkd4Wefc5InwBMIY/L4RO/GLTy0f9HvxQNdCBgWZv5IoaVRYaJg5KZ?=
 =?us-ascii?Q?/NOTKPfzEZwNMzaSRBjqxR7hFPMsl7E5nKLy/JEArWnKv7mw4pAr9ClFBtAd?=
 =?us-ascii?Q?EcyFK7bAIGj6GxPllalbPwmfnAdyhRVxkryAbL7D18QG+LoOuwGnM2NCAM96?=
 =?us-ascii?Q?yXg+VDq5hEd2WOe5adC5FHMo1mTiMQjPei1I9EypPSli8HG1zntKwd1+BGSL?=
 =?us-ascii?Q?W2dncr27SPrfaNNKbr9ms3OUGqgSPeAIAKWlYlWf01cqC71UNUgensRTXndf?=
 =?us-ascii?Q?Y58nk0j5twIDfF4q+rjavYWyGKQrsiZk7Bnn9M6ZC8cOfMeBsB3C9AejQWOf?=
 =?us-ascii?Q?sLZ9DTjr+m5CiO7oiwT+YEqkpKbHbkZINRJgEvp0sfOMHlPAExNG8TwAgWyJ?=
 =?us-ascii?Q?IyEDnl2a8zfO4ehSKebJVQGE2qO60O9XspnEDvZ++8EsoSj97xEI826ArNYL?=
 =?us-ascii?Q?MZOQVKM0c9vGtF34o5Kz7er4v/YCzeJqxFZR+MTFabnqoch1az2ETZhep9q2?=
 =?us-ascii?Q?6M330K3zfMHpoabZYs/UkNQbPrWFBJkmLHG/e1/wDvggFIBE2JydcqfXJPfr?=
 =?us-ascii?Q?aew+pJRUf9TkW/sQywCBTdsHku2u0PSBdAuyWkgzxz5oSSwOIPWniZERGlb2?=
 =?us-ascii?Q?H3HCIR4yUL5oGu4zo9Gdv+zpnvB3QZIAgxhQKadO0g28pmM5gIu4JOKnjcGU?=
 =?us-ascii?Q?AOjREoYKZVr6CTewcsO+PthkCtBmxCad2ALfEx/F0F3C9ZW4H8SNwXMPa/He?=
 =?us-ascii?Q?ISF7A9Szw0OZ6EzEihST/BvJBdqqwUQlWN24PvckvgwnoxeCL3+TTgs/Op68?=
 =?us-ascii?Q?96SWZcZiwSN5K+OlFp0zrFU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F385C12D76F4DE45A924897DEE4C9110@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be26d81-0d70-4119-dd52-08da64e725b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 15:48:35.8892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sWMNyqKuWHgHtpkb6vPPq4fVEhpf3gLo7OEIggAJLkWUO8nGXlEzMH0GY06fVBQ00z65jAkFHqKs4BGn52wWKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4297
X-Proofpoint-ORIG-GUID: n2YKRCvW-1Jk1Bei-v-9dcVEzGlaHmyi
X-Proofpoint-GUID: n2YKRCvW-1Jk1Bei-v-9dcVEzGlaHmyi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-13_05,2022-07-13_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jul 13, 2022, at 3:20 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Wed, Jul 13, 2022 at 12:18:44AM -0700, Song Liu wrote:
>> Dynamically allocated kernel texts, such as module texts, bpf programs,
>> and ftrace trampolines, are used in more and more scenarios. Currently,
>> these users allocate meory with module_alloc, fill the memory with text,
>> and then use set_memory_[ro|x] to protect the memory.
>> 
>> This approach has two issues:
>> 1) each of these user occupies one or more RO+X page, and thus one or
>>    more entry in the page table and the iTLB;
>> 2) frequent allocate/free of RO+X pages causes fragmentation of kernel
>>    direct map [1].
>> 
>> BPF prog pack [2] addresses this from the BPF side. Now, make the same
>> logic available to other users of dynamic kernel text.
>> 
>> The new API is like:
>> 
>>  void *vmalloc_exec(size_t size);
>>  void vfree_exec(void *addr, size_t size);
>> 
>> vmalloc_exec has different handling for small and big allocations
>> (> PMD_SIZE * num_possible_nodes). bigger allocations have dedicated
>> vmalloc allocation; while small allocations share a vmalloc_exec_pack
>> with other allocations.
>> 
>> Once allocated, the vmalloc_exec_pack is filled with invalid instructions
> 
> *sigh*, again, INT3 is a *VALID* instruction.

I am fully aware "invalid" or "illegal" is not accurate, but I am not 
sure what to use. Shall we call them "safe" instructions?

> 
>> and protected with RO+X. Some text_poke feature is required to make
>> changes to the vmalloc_exec_pack. Therefore, vmalloc_exec requires changes
>> from the arch (to provide text_poke family APIs), and the user (to use
>> text poke APIs to make any changes to the memory).
> 
> I hate the naming; this isn't just vmalloc, this is a whole different
> allocator build on top of things.
> 
> I'm also not convinced this is the right way to go about doing this;
> much of the design here is because of how the module range is mixing
> text and data and working around that.

Hmm.. I am not sure mixed data/text is the only problem here. 

> 
> So how about instead we separate them? Then much of the problem goes
> away, you don't need to track these 2M chunks at all.

If we manage the memory in < 2MiB granularity, either 4kB or smaller, 
we still need some way to track which parts are being used, no? I mean
the bitmap.  

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

If we have the text/data separation, can we just put text after _etext? 

Right now, we allocate huge pages for _stext to round_down(_etext, 2MB),
and 4kB pages for round_down(_etext, 2MB) to round_up(_etext, 4kB). To 
make this more efficient, we can allocate huge pages for _stext to 
round_up(_etext, 2MB), and use _etext to round_up(_etext, 2MB) as the
first pool of memory for module_alloc_text(). Once we used all the 
memory there, we allocate more huge pages after round_up(_etext, 2MB).

I am not sure how to make this work, but I guess this is similar to 
the idea you are describing here? However, we will need some bitmap 
to track the usage of these memory pools, right?

Thanks,
Song
