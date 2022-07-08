Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B078C56AFEF
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 03:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbiGHBgr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 21:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236812AbiGHBgn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 21:36:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B4272EFB;
        Thu,  7 Jul 2022 18:36:42 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267LPV9K001608;
        Thu, 7 Jul 2022 18:36:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=8aXbjVjccTswwh9qsED8+63/7Q/vI+t77jwUHnXwxx0=;
 b=X5ZzMOhhjjxl9C8CDSqerrdKHVXMdODK9BLArnIu8qghvQa4eLsTa+sSTfJ3ti4rnUcz
 BGinBZCbPmE/dsJdBkaNKdaCk2cjGiVGuvdtIz1x/IYVStL/+ozTXt0nOc3oKv6LeL+y
 sw06lOvuzhF2jDSEijIua6K9aixPACYivus= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h67d21ahu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 18:36:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfzcLSrcO1BuUJxizyjZTqhzYBFCDQRebRkx8l3d6TPHRE3/SD0ZLKpnDdOtsvwV60qiEUlPgKB/dsFfNQWe76jYzd3yl06RK+EmfnMmxBfMtHZZY0A/HC8PWdgbyA4SHSDU2lqBvqeV0ebz2xiRgWIeg75qlyelKHANB3fleTiJ9u1fXOG08tmr4GplzimRooz82JWTZqO1/MTt36CB8ckhWXgXTIG8ySIH8CdeM94PTD1MY+FTo2fkfWMAzcrKy5uaGKx5H1czlfzYqnVEjSa/G0N5Aqb69XAn5jYizfSmfmwwy/F2pjj+YKgNWIPI3xz6tGQ25EIBK0HgXV5JPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aXbjVjccTswwh9qsED8+63/7Q/vI+t77jwUHnXwxx0=;
 b=Btn6+MhrVp9y0265RDo3Vzvb61iyyTC+9+Yt3RnHEVAGBrE3RcfZTjqs5vpnihHcHS9d1mJK6JMv/nFPtLfV7InUGTbY0IWQDMLD/+DJp2bsA46A6ZH3IhkaZJiHSoEFA3/n7WSJ2VvXOtXvaNjnTmnd5EreA6H3C+Yf8/aAqJ/4XkqSRkI4/HW0kQ+KVAbr1Gr1JueaSvnzTt0sKfwRu8oMRRz/5Pph1oIx3P+l8e3VsTJ7eVA++zttteaXZfVkXOGZeJOHDK/0+an7jKca0IeqxTcFaWphRf8ZvSmFk8epsXdfOIHf1kDr40FGhbCryCfvS3exsI2tsf8eT4JWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MN2PR15MB2541.namprd15.prod.outlook.com (2603:10b6:208:122::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17; Fri, 8 Jul
 2022 01:36:25 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e8cd:89e9:95b6:e19a]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e8cd:89e9:95b6:e19a%7]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 01:36:25 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v6 bpf-next 0/5] bpf_prog_pack followup
Thread-Topic: [PATCH v6 bpf-next 0/5] bpf_prog_pack followup
Thread-Index: AQHYklIC37qezjyxh0moueFgoO/pNa1zhdgAgAAO4YCAABD0AIAAC/MA
Date:   Fri, 8 Jul 2022 01:36:25 +0000
Message-ID: <C96F5607-6FFE-4B45-9A9D-B89E3F67A79A@fb.com>
References: <20220707223546.4124919-1-song@kernel.org>
 <YsdlXjpRrlE9Z+Jq@bombadil.infradead.org>
 <F000FF60-CF95-4E6B-85BD-45FC668AAE0A@fb.com>
 <YseAEsjE49AZDp8c@bombadil.infradead.org>
In-Reply-To: <YseAEsjE49AZDp8c@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53ac25da-d2fe-4923-3818-08da60824578
x-ms-traffictypediagnostic: MN2PR15MB2541:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DHgV4lcEZM6J3GjfDhbq0ZgDDc8Q6WJ6egMZ+ANEDQHaUtYvsdnCu/99Xd0Ir8a14MR3jIBlDE+gbDY/irwxB8OMqGrz8Ec+d35JvZIERiO+MS0ZfCXxgauDuTO9OvL6mrBRuVm7/dBn/ip6LuYjrFUDdvxuSzrLuNDErpJKLK4eXcpO+ahEOmUfRxf4VBUnyD8L9rBYgwDx0VGoJmHsl77RxvIodFjln0OXjmWyVSK/Y3H8FWSR5o8k0OhBxum/3QHqO/arlc4DgYiMmjnk9nsZIV3R06dPey4v6gduq2NkhD7f1lawb3dAHcPWhmPb1to2fTp/2vIpZHhzmh/NE4Jd3Ks+15wcUZf41K8upWhIukc6dm5Z/Dvr1MK9/CS/nAGXkaH1ZrTa3AfAfNEC75vsPSWX/MS1hdps4d9l9BA6nEwOmpDAim9UuhmEJLikbu7fnU5ta1kjsG/lYvcdQ6VYU6521oEq4He+kJbtNTQYjjfeXKo4a2VsdDyrZH9OXjWi1mwptvD9UAxZFHI8kkQKfjzjrSXL7v5fbpTKWrwWz+AfEWJ7qX5MRBTWADdWDm/uSCw4JgjCDWzuNTvyvuuTBRKeGij+QICpCDzQdXdaqJdUDAFx+VkpI+wEMqNHLSx9uLJfPSzF+BddkGoujatzNcIpF5k/G00llOuUyvreK9T3U7Sx0trTcs7vUoH/rLhn9lZDCPjE3jyxJ1QLVREftBoQr+XBVVMpGlrK8MJooah1AYVp7DQUrAi9DRjse14GUNFVaZTW0gdT5+zvEBN7tmsYt9vq6cHoKm2+5HKz4b3tA+1tnalAPddx/Sq9nlyw0t71VOvpgh8xGaq4QA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(91956017)(4326008)(6916009)(54906003)(86362001)(8676002)(66476007)(66556008)(66946007)(36756003)(66446008)(38070700005)(64756008)(6486002)(76116006)(478600001)(122000001)(8936002)(316002)(5660300002)(38100700002)(2906002)(33656002)(53546011)(41300700001)(6506007)(83380400001)(71200400001)(6512007)(186003)(2616005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WqczCwWMdGBn2wN8dmrlcH9rBMPC0u01q/Vkv5QItfaNA2eIiFfnQ7cTcQYL?=
 =?us-ascii?Q?i+xuteVARGzMEzXWactQ75OG4wdQyKx0ZBZskYXC5HBPy1oy20djRogCXAYb?=
 =?us-ascii?Q?RIu8E8QulQL7fXn/HWGN1haMd/vBf0TKhFsalKRwsGTabtZzDjrID7Sdsf/6?=
 =?us-ascii?Q?r8OCLcu4jCa16y2WBuauH3lO0eO2g9t82Bvhy0lpw/Qjk8FHRzq44fBc3sPv?=
 =?us-ascii?Q?1jEFmicInTv+dSgv6U7vgEz1FJFPnVn0JjWMYGg7gDqEYkxz1s30OxMFj+pj?=
 =?us-ascii?Q?lA3WW6BDX+O+Uk6UvxmkBoEOBxI6G6J0vICnRB2p11h7A3Y2KC9wEQgdZveB?=
 =?us-ascii?Q?kSdeF64IHnyfqldB7kpu7F5mEOsZ6rOhrn09oYGw47c8gQVGCrpzTBuIsbP2?=
 =?us-ascii?Q?6hTfEhP2DPIEfipXdMilRR4ZAFj0XyeFYUXaTKWId5NwiTPtj6YuL0IDGLdH?=
 =?us-ascii?Q?EMIKgDEdLERriBRNrNup6S5+LZF2T5dFeLQYtboO2LUeCmZbV+WYtryt4IJn?=
 =?us-ascii?Q?sj3LnNuEcsZN4pR6DfNdsANCrmY76hm736bXM9M4vHz5oLYKYO+7X+Ks9UzX?=
 =?us-ascii?Q?pj2zUT/48lLyd2GmKd1mWtu62UKFUBlPKHbDqYC9mlbsSgUex389ReYIPalL?=
 =?us-ascii?Q?kXm7Xds8nfSNdl1pVXdKngCh7kP3PiEbYm7JfSWh3k8Wxs5IqZLsJpN8Aa4V?=
 =?us-ascii?Q?DV88lmbF7G9vNmH+Y6rN1OSXNoULIXqfipt1VIGAmmxMAD7GR6ZYe0Xsn68W?=
 =?us-ascii?Q?ey4+Kxkmb1mBiEwlV0YZ3dC8g6piFgXKz4xHlWh4LQoqK0bBLxobo1b8/8td?=
 =?us-ascii?Q?O4/BorrAVbcLFtExiF2hnx0/NR40LD5DxbVO5xeZWwz54NVHyE3vExsbNPMv?=
 =?us-ascii?Q?8i/JBw04FwF83l9uQ3Y1iHQALvPqdU1JcUz2+KJOUPZVccf7OMMj5fXWQb1s?=
 =?us-ascii?Q?SG4Ycih6aUp8fTpu4RnOzc53SaOULy11VWNUc3+2vYe3X9ISN84STTfD+TBg?=
 =?us-ascii?Q?DWnfW3Ja/CaoLpTejvyh0kJkEgX+dxJs3240nTVH//D2pdUx2J08VCS26whn?=
 =?us-ascii?Q?RHAO3+AF6nE05z8HgOPhzJLkUJyHAmTCDPklkpSK6edMqN7UOq+f1tC2y2jY?=
 =?us-ascii?Q?RSQlwbujTbkwhqpXHmB6KO5JzPvZvI5qtf+/7w/3fIYXKm+vA3NoPjj8DN1C?=
 =?us-ascii?Q?5lCax/ZABM6FdhWXplqSindwWYEMlqg4Vm1aF2sPlU+MLjcGNEIN6q8OvFWR?=
 =?us-ascii?Q?8UPCDA6qRAIl7ZyLXhrvJMyhdBQCWImbsfc7DuG+IoNzNWFQ+eB8Wwp6c83x?=
 =?us-ascii?Q?oGBFNryGuxdPzwMGbN4mxDVtWG6TBNhQeoeEFKX8u1urUhk6m5SkLNiejUkV?=
 =?us-ascii?Q?G625i5Qa7c0RQUQu/TifaINsv9wPp9yqy79sUTV22cm8rDtSywPuEESrUV88?=
 =?us-ascii?Q?tSD8f1WP8v7uXJ95yM/NTl/tmL0oEg2JbPEQ5LoGXtNgLUr2OB4wPWOjOgib?=
 =?us-ascii?Q?qjxuvUnXV/dJdQWkcKH4zsSCFOFVCagfS5jnG4bH/YAtRhItLv2+fZ6ZwvNW?=
 =?us-ascii?Q?DsGGn22uap4LPEkUblpAOVZQ32nh1AMrLIKJ5WhNr5zht6tR4OFrZOX1nepF?=
 =?us-ascii?Q?h2nB9hMHMne6R8yb8tPmM0U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5DC89D8DCE80EF4FB28322F5DEA72D65@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ac25da-d2fe-4923-3818-08da60824578
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 01:36:25.3712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ei6sgvpxp/w+RB/55jpOcPrKg1lZbHbpcc1oFd7cvbyXyNS0PHQ5XZWIbQDBDSI1VaSuhQBNvW6xteFMXJn9mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2541
X-Proofpoint-GUID: 1HRP-4Em_2Fu0U02aDdJb_v9q5AJdDAr
X-Proofpoint-ORIG-GUID: 1HRP-4Em_2Fu0U02aDdJb_v9q5AJdDAr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_19,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jul 7, 2022, at 5:53 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> On Thu, Jul 07, 2022 at 11:52:58PM +0000, Song Liu wrote:
>>> On Jul 7, 2022, at 3:59 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
>>> 
>>> On Thu, Jul 07, 2022 at 03:35:41PM -0700, Song Liu wrote:
>>>> This set is the second half of v4 [1].
>>>> 
>>>> Changes v5 => v6:
>>>> 1. Rebase and extend CC list.
>>> 
>>> Why post a new iteration so soon without completing the discussion we
>>> had? It seems like we were at least going somewhere. If it's just
>>> to include mm as I requested, sure, that's fine, but this does not
>>> provide context as to what we last were talking about.
>> 
>> Sorry for sending v6 too soon. The primary reason was to extend the CC
>> list and add it back to patchwork (v5 somehow got archived). 
>> 
>> Also, I think vmalloc_exec_ work would be a separate project, while this 
>> set is the followup work of bpf_prog_pack. Does this make sense? 
>> 
>> Btw, vmalloc_exec_ work could be a good topic for LPC. It will be much
>> more efficient to discuss this in person. 
> 
> What we need is input from mm / arch folks. What is not done here is
> what that stuff we're talking about is and so mm folks can't guess. My
> preference is to address that.
> 
> I don't think in person discussion is needed if the only folks
> discussing this topic so far is just you and me.

How about we start a thread with mm / arch folks for the vmalloc_exec_*
topic? I will summarize previous discussions and include pointers to 
these discussions. If necessary, we can continue the discussion at LPC.

OTOH, I guess the outcome of that discussion should not change this set? 
If we have concern about module_alloc_huge(), maybe we can have bpf code 
call vmalloc directly (until we have vmalloc_exec_)? 

What do you think about this plan?

Thanks,
Song
