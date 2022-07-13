Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD6C573EE0
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 23:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbiGMVVo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 17:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237462AbiGMVVY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 17:21:24 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31693DF0C;
        Wed, 13 Jul 2022 14:21:00 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DICbg8008908;
        Wed, 13 Jul 2022 14:21:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=YU4RdAeHTsSmji0ZimLLQgo6PkeRxtogaVWx6NrD1bY=;
 b=bCpf8CsRm2YwYS7zTWa33NdOcRzoGKflz4aS2FJxXeEw5uRZTIiIxKrPmMTE9+R5A5TO
 dCJN1JMLkh7l1+1EyNChuz65CKnP6sG3wdV3ae5fFv+QEN4DO+hiIdlsB3YWVywEC9G9
 pGuW2f1C0UaKA3XPiE5xR01lolH1Hdm5McQ= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h9h5f70p4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 14:20:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXK8NyGupI3DraPK1NLdnD6l34yC0nKC3+LDYtYHaIX1/j5YTasAcTBkgV4JfXX0PV/09OJVstWEAw3hABm4sVeTexiYCR1jqThU/d9pom5RNzxgpKiGWjiOU7KG+MWSZjj8d6lK65umK95ePS3xh+huTkxNs4W/S2LQlZdXSNSxtskgQpwxCTwloL99hy5LTwQM1xuzMRqARNfSZw00T0lGmxVOkzcf2p3ocZnNfvTcuJhcrdCOKyYriTXJU9eV7v7ImlXIkM//BWifUkBhFbjw92AurI7sc8B8z5Yg3FiIxpz/VVi4+sjapXY5tGv3O1Hits2H9bz2jtg/F96kvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YU4RdAeHTsSmji0ZimLLQgo6PkeRxtogaVWx6NrD1bY=;
 b=eQ+tyrpi3c6LXEUZVu8R0bb697iNyqJy2RgmHJq7AgAcQXNUo7BrBh3O4BMe1BvCkXn0GZmIN9lmM9jYUHOTYsS4DDX9cwBwGj55IevjIW4g3Mn/bcTjMjrupOk9jP4U2JIM3C1MgjxLlxBe5crE0SU00I9ulkwLP2Q2xjqewPQGDS0fj7sOqz03CYCrd+ih+TTTenMhNlwX5EBP2ZUKzlf+N7QgxuxPc4ZYDpCIy0ugGMvBD/8xcoQBq3bF0r7SgHcob5bAz5Dx/gBuFKl2TxsXPSOqGYAMrcoOurBCwGH9ros8/oJTsizF5RoHmnhrdc8yMK0bKyDmTl8ObjIkMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BY3PR15MB5011.namprd15.prod.outlook.com (2603:10b6:a03:3ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 21:20:56 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::5de3:3999:66df:42d1]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::5de3:3999:66df:42d1%4]) with mapi id 15.20.5438.012; Wed, 13 Jul 2022
 21:20:56 +0000
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
Thread-Index: AQHYlpK25UY5kW1ND0S/krM8qG//OK18FxyAgABbw4CAAE2vgIAADyyA
Date:   Wed, 13 Jul 2022 21:20:55 +0000
Message-ID: <78A18945-0841-4CCE-8A33-6C09ECBFF7E1@fb.com>
References: <20220713071846.3286727-1-song@kernel.org>
 <20220713071846.3286727-2-song@kernel.org>
 <Ys6cWUMHO8XwyYgr@hirez.programming.kicks-ass.net>
 <7C927986-3665-4BD6-A339-D3FE4A71E3D4@fb.com>
 <Ys8qfRwkTbUYwmKM@worktop.programming.kicks-ass.net>
In-Reply-To: <Ys8qfRwkTbUYwmKM@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a2342e2-2985-4a20-25f7-08da651592f1
x-ms-traffictypediagnostic: BY3PR15MB5011:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fi4jLR4SVQg0bdPQ9YUBNnKO/qpqqqTW6DNnTrnlNwmxgtUOtVLEdkJ2MlU1bgZ4AWtdWi9uQ/cZ/18jJduq82KO/13MT4xF18BxwgV9UHJwxmhGvAdPdsNhi7qVQmfDhmHbp9tmnvtYSv8Ofuf9aRgGisM4o6t7yKidt1ZlT7MiWbYlz9UaMoRWK9b+AnhvD3PnlJHehj07mnm1OAwdmnzQGSiL5vzewj3Jl+qjNnoHRoe5mHUZ8AneVRUPEffH6QcRNRnUhZqKYS5jpcWhD3bXpm0H36kwCBAFJTUJK1gP0SypbfKqn5KaM175MthIm17b3ssjXnUucrjK6z+7eS3FID73XPtHxFT91+4yA5T32LovU+ks1DzXqxXBkSVLJk9IwEmpVbxzTU+J3siwf9/+qUykSdc25ygIdB5zk/qGH3tEg21BfieRJEgravjtpTbUDvnW8N4VGf3nqFqnVaGxPmpfHtrwgGe702KyT+mjlKe1MIqBOYCvPm2ctMVs1hVomHUqYHvDYu2nZ3ezZxMxbWcIRAE8cOKrpZ0DBwjE6dh1klxpKb4V9jZEfd1h6NRk/bT07CAbSwbBIck/cTK0MKi7h/6cCZa56/euzfM9YwbuPvmEklXOw89XLoRvmddxzOItsK6m780UXHA5/f397kwvLxeQiXxGH7T5qGttplf2x3OgfKwyGGHDBZCJW00izqZUSlKgCWl2XuBxC71fMrR3EyKFVo4hfj6KWPvZylXI8nKkh2bOjDBOeQf28jp7L9xRW3V5B1R/GzRgTS5DsJ6reE1gScGRRRYY9JbUMc8t2LyhMHmpkWz++anepwulILAMnVKOgrqRmLbADcPdApOLqtsr8wBLA/hI2xo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(64756008)(76116006)(66556008)(91956017)(66476007)(66446008)(8936002)(66946007)(2906002)(478600001)(4744005)(5660300002)(7416002)(4326008)(36756003)(8676002)(6506007)(54906003)(33656002)(6916009)(71200400001)(41300700001)(186003)(6512007)(86362001)(53546011)(2616005)(122000001)(38100700002)(316002)(6486002)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h8Y6B+axFnz/xxORosmkN7QShWUmKc5VHuPZuJZ2MSVLn/XcEmYFl8RamI/O?=
 =?us-ascii?Q?84IVBjGVLsceKUtCCu7mmytiqjNAdFsN32cypIUOtDA7hw62F+s2V7lCEwVF?=
 =?us-ascii?Q?rGZ8JgMz5TCNdBxz8P4baPXLLYuoxj4cx09culnwPuT35K80LVRdfMrk7bRY?=
 =?us-ascii?Q?kAQ8hIziH7HO3Iy2zpaygElOH2BtFCrL3rofCwkZ9MamfiJIwF/gZr3c4GxK?=
 =?us-ascii?Q?aOM+Dm/ewpk4qYYmmjdDOeeIlrM+iVa+OeK0wykTdgU0SLwSdM7rUn6/tfiY?=
 =?us-ascii?Q?U/3zriPOiu1dpv3Ud9Wd8CAiV1a+mDXT7KtZ6BbWYiXrfaG5FbgJEqxHNa7g?=
 =?us-ascii?Q?pVKtlduDFzDwHV3g6d4X4Mt2ELL/AyICE7lWDtNIewCFycvZRgcRVLsDgznI?=
 =?us-ascii?Q?kKp3YWbqG6bnKiq9J68fGneFWW/5CwJn61wCkZfd2gx2LFiHlW9j4r3876cT?=
 =?us-ascii?Q?86qT3m1SAjj0tI3eIDdFb/hYteoCGSGGwEf9K1jg9wtmOkVt3vTkUKt09qtj?=
 =?us-ascii?Q?WB+CEjvP1aao+vNoeDaUH3BT2Jla/zc98CZysgMr3SN87CoklDJMrtmutBF0?=
 =?us-ascii?Q?VE8gK8NRgLQ9W7Kk75dPCRlZY3bAvjgXgSMZjgN+CITLdLYJrjhunHPzTaaN?=
 =?us-ascii?Q?A6atuFHG0CWGeSLa23qW2XYoWx5j1bi1dra8gY1/V4zM/H3dMVwLjY9AAQG/?=
 =?us-ascii?Q?uyjpYnvaJAfLHreCIbDkjXWR1CYU+NyMetw2PG9QzbltGpJv1BJDjvWV+PZ0?=
 =?us-ascii?Q?xXg1Sn4WOgWy84qdpQYsogbVscwZqoRvRRd1VIZwfQu85z9P/O1CW64ZZE9n?=
 =?us-ascii?Q?RjoDLkeEztW876zRyt+mb54xqHq62qu3h/DVbQAvhcqLS6frVvuZgQAPjKwU?=
 =?us-ascii?Q?7ioYCFSzMHYO2MdBVvNHv4v0i0icaoIUzSyJFOcMlCweUhQlyM3hAfTbixYX?=
 =?us-ascii?Q?3rvFioQMSAQAyZrhwbj1Ei1sUDf8dkBUcr02OzbNARhN2p+Kb1jRY7O2s3Jf?=
 =?us-ascii?Q?uWKD7UC4TILzaEJO6NNQyqIeKngmIwpoumza2KwIxHCaA/nrfQQvIxB6tGYs?=
 =?us-ascii?Q?j8P6RYagNyTmKZEsxa9D2t6wDgcWO9dTpWIVCood3ibi8CQPva1S/ZnVAq4o?=
 =?us-ascii?Q?C+/BGQyrLVcJOo59xMwrej++qJfaadXN98vxoOnFAarBHvjIOjj+4zDRbu0y?=
 =?us-ascii?Q?rCZYkEIlzY6QPS49fdaBiokfISntFIZYviibBNJiuwfsX2LaLH+vugIteO+j?=
 =?us-ascii?Q?TT99owLcJULQSWrO/985HrDgzMb1VMEgKJ6Ewa/hFD2LhL+OA1S3FLnnP8gU?=
 =?us-ascii?Q?rIWGAGFSI9AR0xd7JdxTetSgv4iacU/6+7IpzTeE5AQJ9epacl1ugoai5vJQ?=
 =?us-ascii?Q?+keJOn5mhgseweFJ3FOOxpB8YejrsfKKcB5AepRST0L75lPZyWaRkiHBP4lx?=
 =?us-ascii?Q?Ioas29KxULxQlitMdO4HT9XA/Cqe6qCYW8KUkNdnjq/G2WlD7nCjRz6C7Hv9?=
 =?us-ascii?Q?geiuRwGf5YAgeYwp1vrkRnqweyLUlvfa3cO9b57P4xLJ6GPflxpcT4aGv1f5?=
 =?us-ascii?Q?wWctPkxfDDrvCr2YPw9ESf+hNRh9g0qkP+8eVf8ZsS2hOi1eGcKhpPXhwuZp?=
 =?us-ascii?Q?fyi+YZHykLEdxNHhjWNxtcQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CF74EEC71C01D04EA239ABB2FF4184A0@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2342e2-2985-4a20-25f7-08da651592f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 21:20:56.0186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7IJzOdzqmd/mjsk9nwZ72oXf1r++3h0OeaAfRoYDAs+xrfRIkSfjrwL0XJuS9PWprj327/q2SxZgoouRqxIybQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB5011
X-Proofpoint-ORIG-GUID: ywhtoKhG8kY0PnOBy0fjJRe_sAbR_DkL
X-Proofpoint-GUID: ywhtoKhG8kY0PnOBy0fjJRe_sAbR_DkL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-13_11,2022-07-13_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jul 13, 2022, at 1:26 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Wed, Jul 13, 2022 at 03:48:35PM +0000, Song Liu wrote:
> 
>>> So how about instead we separate them? Then much of the problem goes
>>> away, you don't need to track these 2M chunks at all.
>> 
>> If we manage the memory in < 2MiB granularity, either 4kB or smaller, 
>> we still need some way to track which parts are being used, no? I mean
>> the bitmap.  
> 
> I was thinking the vmalloc vmap_area tree could help out there.

Interesting. vmap_area tree indeed keeps a lot of useful information. 

Currently, powerpc supports CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC, 
which leaves module_alloc just for module text. If this works, we get
separation between RO+X and RW memory. What would it take to enable
CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC for x86_64? 

Thanks,
Song
