Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E8D543FBC
	for <lists+bpf@lfdr.de>; Thu,  9 Jun 2022 01:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiFHXCt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jun 2022 19:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiFHXCs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jun 2022 19:02:48 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7294A3EA
        for <bpf@vger.kernel.org>; Wed,  8 Jun 2022 16:02:45 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 258MtsmS020296;
        Wed, 8 Jun 2022 16:02:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=facebook;
 bh=c+aUyVRVnQmKjNtr84oBprxEGBk2CwoOeZN0oiRyFnY=;
 b=NPaDUZ9BPTY0Mk0x6uhXAdpKadZpxB6x3+guwbcaBa5SC3C3Vna5RsE02ybn693IMLWm
 i+b3mJbxZWB7eKtjZAc6397MWUdFsSpwG9+0segOFCuds+WxwTrzJaH9oC3YYUZT17ZD
 sl4q2kE9Y69yQGiUL/5GCXaMULYU0g0uOpk= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gjr0jd0sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 16:02:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQspfNzlepK+Y1oKaUIF/NdROL30XnJoTEH1VrcKaRJ+3eHCEnsjuhqpPF2PC2w21x5IkcfQWr4Ja2/vrTAqXx3Rt7R4Pe9/x/TLsyiPJQ4TdtBfrKkOrZ8ViBh1ObjMKTNZE+VSlQXZd82SgBSyV8HMH8Zxut/2Wepz2zgKR4XEMbZ4DWyAFUqck9lk5O3QgOhL4y7H0zN4GR9b9aGAU+zKuLpBmkMG/KnOFdx7c9qIIafnk7z2gqcpexWdFGA3cyfe9HOFVm39V0gieOMR/cEr8Kcav5GnbIJ62BI8ykc/T9qAJR2jyHU5vg7VV4xP0xLkR7DnqnDnaX5TB+xHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpNO9gPgPO7xJGYvVcVvbcxEv8L+oKl3pqK0fFlLo0A=;
 b=LBF5vE1WGs/oEONEy/cygP5InMp+Q7Gnmp5imp4TaZCTQhzbrkyUShIvVvEw5OTAoFHoxWkFJu6wFG0X68HApqPNgJEjniN79Rnq6fn8HjFvd2rw7X9WEP8mPhRV0TFb+ga0ypX380On7XgZsOnpEglpMgf7eO9nOD8/i+wUwKidNcQuU5VXyWuRC5aFrtaQCo51On3YIS4na1Fyx04VZ48z83qA91OJvrgzsLDQfyWNG9WDSeNWVSV9Sxz6nnssX+EdQE3ViNOzS6+0d7EzApJ2IjFsCEc309HEfF80uiafisB4BkvZEmk6696WJEIDxVAi53gmKodKl23Bj/rdjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by BN7PR15MB2339.namprd15.prod.outlook.com (2603:10b6:406:86::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Wed, 8 Jun
 2022 23:02:28 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::a09e:da84:3316:6eb0]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::a09e:da84:3316:6eb0%9]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 23:02:28 +0000
Date:   Wed, 8 Jun 2022 16:02:26 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v5 bpf-next] selftests/bpf: Add benchmark for
 local_storage get
Message-ID: <20220608230226.jywist5cdgu3ntss@kafai-mbp>
References: <20220604222006.3006708-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20220604222006.3006708-1-davemarchevsky@fb.com>
X-ClientProxiedBy: BYAPR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::21) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20a2b738-837f-4545-c210-08da49a2f5b7
X-MS-TrafficTypeDiagnostic: BN7PR15MB2339:EE_
X-Microsoft-Antispam-PRVS: <BN7PR15MB2339331E34ED5DA8D8687956D5A49@BN7PR15MB2339.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C9rnV7SObmgEUpqtO3udqbsc9fsqVnsQ11FlC55WRdL1+Bkt1T3B+/755kgWgdZhJcMBmM5ydnxLL8YgUkZi+xhuY+9O6/Tyz58DxeKw0fdYgUw/oEkHpGJDeBPQ24JDmXhtmJD5sLmAk7H7s16OZBt0dIjYuzZeQLeddqby7RItpGfWtqEYPXOUDhE57el2c96ahJMTNfK3qdp6DP5U/+j7i8ggzH2qIQ2OE6SwdjayRYgFYVbq3vZScgY5L3o0OyhUNoI0Zxzcvlefj0A9bOE7vrGA4rEv7NqGWh1ts+mWhm/e0OkkwF9+VpWHpVn+hFJfbujfBRuSiQShPhfffPbazt36sAWQedGg+t/YBycQwHBAl5Y3TUIiimAw4XnzOq1qh4d6+k0slTUt4YfjTJiH3ht0cZvApeuFJpyHzSbf2RNnB+x8rYu3NQsbuJLdMweWAGHO7ry/O/9sKYRWUa7B+SnMDqOv2xIRqB+7Y2dFPKZrvhzXiHs7lDr9kZczI4eurReoQuGPd63JUZRKl/+TbC1/LibbQ+L/vNgL0xdiR08+YCTAsPL4hOIA9pWyF/viMrBXMZCV+q5ysvgoOsuQlgS/61sj45nremUSgePjSaIFInvsfbOHmQ4djOQrYljckxXpxhj4V21MRZUvw3rvMTVj/Bdp7iBShMYFxJw4OQw2lkli4/dWRcggABYSkdp3ZmCWcqmhC2trXX4r0JryBaMNvMVzd5p9yD/ZSJou+Bs19IfNEgLDT9gKI8QSIXYzbsMaa3tSAdr6v9mceg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6862004)(6486002)(52116002)(83380400001)(186003)(86362001)(8936002)(9686003)(6636002)(316002)(6512007)(33716001)(508600001)(2906002)(966005)(38100700002)(54906003)(30864003)(6506007)(1076003)(5660300002)(8676002)(4326008)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wCDE4j5Li7Wp9Lk2fG+TtH/+8SeOTiEo3c1G/j+POIhYvzT/CL9ZVwgMK8?=
 =?iso-8859-1?Q?w8E6AQpVCRt6yi8Ern8xTC2eoYqlZlgbRhvIHqKwnQZrXbHf559aX2+/y5?=
 =?iso-8859-1?Q?Ea0dfZDLCxJX8Zp8huaAMOu5yx4xc+Mi9a5HqcubS9rp60snM44G4KrRM+?=
 =?iso-8859-1?Q?e/kKzwBbW9hc9/gIa73GgPvNjNasDoBE+XTlOBnWIg68ES+Z6eKkUeU++h?=
 =?iso-8859-1?Q?DxcI2gFw7FFKJwquOtTuekivCPNIN1WOG5/tb4l2p79sEcoXoaeeaA4X5V?=
 =?iso-8859-1?Q?vo7GjSuls8HOxwBgqWASzvzSIUKzKpDvDjuRzKnPQhmMuoGJTK/yI26G87?=
 =?iso-8859-1?Q?LjhRJARAJ/yRQNvcQPn3ixqY+ZnWzhHsYiVhYMQn5v9HVPsCnr9aghSL3S?=
 =?iso-8859-1?Q?w4xaijpPuPPhK7Lw06z7L3NcDqPlzt+JdH8S1D5OVr0QiWoQcbP/NsM7cc?=
 =?iso-8859-1?Q?68tc1lAjFc7mY0VJ+QnzITJy9d6JloGEZobFwuncw9os6+XLxafRUuFJJI?=
 =?iso-8859-1?Q?SVNBko7SxAahO83sHJ6ldXNKqKQixZbhbOC1+iMRVdXbdZ/Afci7kM4xFq?=
 =?iso-8859-1?Q?oxcaYz50gXhBaYFGFzs/xQ70mdlHuYHKPWsM++99FLq+1X+yh5ABFyV+2H?=
 =?iso-8859-1?Q?Yp6/aJuG43koXaOm0YZjKoIH2ZYbmYYbBGJTuCP3ULdbD6Tc3x9QhLJlrH?=
 =?iso-8859-1?Q?pQvAUD2lDhxAp4wePMYqOSvLBJ4ZlC5z1x216Ppp2mGRPENqjfmk/TjpiT?=
 =?iso-8859-1?Q?QuZR7rV1W0jORYrvjKgbYwdDzI/ylheZhMaNdWnUwlVw9cH8tleS9JAzsb?=
 =?iso-8859-1?Q?nkyUfTuFVUM8BsfyDzU28vCnFlSaMCaFX3mudnxVh1hMQUxfjSw1ekmS9w?=
 =?iso-8859-1?Q?Pauq5REgusqQcqBzspKSxyRI47dNAVEiNcTmtprusVks285LldcmScYJoV?=
 =?iso-8859-1?Q?b/KTXfpEhTihwb97JhgXqnBMYuWTS4xP8LPOs9+6QduenXHujbJ7tRJRYt?=
 =?iso-8859-1?Q?3fUbOF1njPeO0pTNY43pCzh10D7z+7Jt75A3uYSidcv/gwD2MjK9ZP6/jK?=
 =?iso-8859-1?Q?yt3eeHMKFX2rtxzjxfaXOS1/tiLIrfyw/lfkHSrYLxAu02l4Iy2om9cvIs?=
 =?iso-8859-1?Q?m1w37SC8+aq3ubVos8M5c2VyyPVhyWEbnNKOAt37TCr6byYhP8tgtugoen?=
 =?iso-8859-1?Q?azKHkfs1SwYrWf6PxeM8/hJO5utbuxc46/AwDtvY1evSx2mvwoPItv3dy1?=
 =?iso-8859-1?Q?89QpYelHs5AP8A0ne6zxjZLO70jQKsxyg+2kSL65LAuJRLqNFLERv0zJXP?=
 =?iso-8859-1?Q?lYCShsR1ZWTvX2CvWIqNKIAMlZnEYhBnM79smtaCTp+AaMs1klKAbga3kB?=
 =?iso-8859-1?Q?inDqT7CvKN7WBhhrO9jFWtdEhlOfalwYpSQNOduvavGlLwngQk5gEa3Z8i?=
 =?iso-8859-1?Q?wZgEBLUTAgYqI7HTK8Sy9hJCAdW7us7kHajTbhbuhSZ7JmTVWJdWzIke6t?=
 =?iso-8859-1?Q?xqNX+KtPyKEkUZv9b9vQVnFprLuSbBqVM/fFZ+q4LCrRBcQttDLuACD4Ep?=
 =?iso-8859-1?Q?nuO8TeRMo4m6x1va2g75MBrG7IhQpim4CSGIbsCJCiW8bkjFJ0w5iLB9wA?=
 =?iso-8859-1?Q?Yt4lrmQ421cgIVp7S5zH3muNl8TtBxPYg3qVZRUnUOOtFaRTnvw1ujGJJ6?=
 =?iso-8859-1?Q?CulU7ML8KmfKuA5sw0UBgv2LP/HV1dztJDPECUT4Qn1QNTEiVRgkh6NiRk?=
 =?iso-8859-1?Q?HG86pOhDJ788kNzwJikPj3uh+XpI/84y11xi/qUsW3KRzUVXJZhc90ZE8T?=
 =?iso-8859-1?Q?SXl3VThnkyo+zHTN+AnclYlz71YSaas=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a2b738-837f-4545-c210-08da49a2f5b7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 23:02:28.4523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ot+YX1wPiXlTs3canajC9FnlLlisTCsoZBdpx+ldyFQhW3qFBQMyd0f6/gseQv4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2339
X-Proofpoint-ORIG-GUID: Bkj-hBQ0fs3UpkharLaiNsF7oATmXOkk
X-Proofpoint-GUID: Bkj-hBQ0fs3UpkharLaiNsF7oATmXOkk
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_05,2022-06-07_02,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 04, 2022 at 03:20:06PM -0700, Dave Marchevsky wrote:
> Add a benchmarks to demonstrate the performance cliff for local_storage
> get as the number of local_storage maps increases beyond current
> local_storage implementation's cache size.
Thanks for working on this.  Have some high level comments and questions.

> "sequential get" and "interleaved get" benchmarks are added, both of
> which do many bpf_task_storage_get calls on sets of task local_storage
> maps of various counts, while considering a single specific map to be
> 'important' and counting task_storage_gets to the important map
> separately in addition to normal 'hits' count of all gets. Goal here is
> to mimic scenario where a particular program using one map - the
> important one - is running on a system where many other local_storage
> maps exist and are accessed often.
> 
> While "sequential get" benchmark does bpf_task_storage_get for map 0, 1,
> ..., {9, 99, 999} in order, "interleaved" benchmark interleaves 4
> bpf_task_storage_gets for the important map for every 10 map gets. This
> is meant to highlight performance differences when important map is
> accessed far more frequently than non-important maps.
> 
> A "hashmap control" benchmark is also included for easy comparison of
> standard bpf hashmap lookup vs local_storage get. The benchmark is
> similar to "sequential get", but creates and uses BPF_MAP_TYPE_HASH
> instead of local storage. Only one inner map is created - a hashmap
> meant to hold tid -> data mapping for all tasks. Size of the hashmap is
> hardcoded to my system's PID_MAX_LIMIT (4,194,304). The number of these
> keys which are actually fetched as part of the benchmark is
> configurable.
Note that the key size of the hashmap in the socket use case could make
a different also.  It usually uses the four tuples(src/dst ip6/port).
Not necessarily something need to be configurable now but would be
nice thing to do later.

> 
> Addition of this benchmark is inspired by conversation with Alexei in a
> previous patchset's thread [0], which highlighted the need for such a
> benchmark to motivate and validate improvements to local_storage
> implementation. My approach in that series focused on improving
> performance for explicitly-marked 'important' maps and was rejected
> with feedback to make more generally-applicable improvements while
> avoiding explicitly marking maps as important. Thus the benchmark
> reports both general and important-map-focused metrics, so effect of
> future work on both is clear.
> 
> Regarding the benchmark results. On a powerful system (Skylake, 20
> cores, 256gb ram):
> 
> Hashmap Control
> ===============
>         num keys: 10
> hashmap (control) sequential    get:  hits throughput: 33.748 ± 0.700 M ops/s, hits latency: 29.631 ns/op, important_hits throughput: 33.748 ± 0.700 M ops/s
> 
>         num keys: 1000
> hashmap (control) sequential    get:  hits throughput: 29.997 ± 0.953 M ops/s, hits latency: 33.337 ns/op, important_hits throughput: 29.997 ± 0.953 M ops/s
> 
>         num keys: 10000
> hashmap (control) sequential    get:  hits throughput: 22.828 ± 1.114 M ops/s, hits latency: 43.805 ns/op, important_hits throughput: 22.828 ± 1.114 M ops/s
> 
>         num keys: 100000
> hashmap (control) sequential    get:  hits throughput: 17.595 ± 0.225 M ops/s, hits latency: 56.834 ns/op, important_hits throughput: 17.595 ± 0.225 M ops/s
> 
>         num keys: 4194304
> hashmap (control) sequential    get:  hits throughput: 7.098 ± 0.757 M ops/s, hits latency: 140.878 ns/op, important_hits throughput: 7.098 ± 0.757 M ops/s
> 
> Local Storage
> =============
>         num_maps: 1
> local_storage cache sequential  get:  hits throughput: 47.298 ± 0.180 M ops/s, hits latency: 21.142 ns/op, important_hits throughput: 47.298 ± 0.180 M ops/s
> local_storage cache interleaved get:  hits throughput: 55.277 ± 0.888 M ops/s, hits latency: 18.091 ns/op, important_hits throughput: 55.277 ± 0.888 M ops/s
> 
>         num_maps: 10
> local_storage cache sequential  get:  hits throughput: 40.240 ± 0.802 M ops/s, hits latency: 24.851 ns/op, important_hits throughput: 4.024 ± 0.080 M ops/s
> local_storage cache interleaved get:  hits throughput: 48.701 ± 0.722 M ops/s, hits latency: 20.533 ns/op, important_hits throughput: 17.393 ± 0.258 M ops/s
iiuc, important_hits is only useful for the 'interleaved get' test?

and the important_hits is always a certain fraction of the total get.
For num_maps:10 here, 4 extra for every 10 get,
so 4/14 ~ 28% of the total get?

> 
>         num_maps: 16
> local_storage cache sequential  get:  hits throughput: 44.515 ± 0.708 M ops/s, hits latency: 22.464 ns/op, important_hits throughput: 2.782 ± 0.044 M ops/s
> local_storage cache interleaved get:  hits throughput: 49.553 ± 2.260 M ops/s, hits latency: 20.181 ns/op, important_hits throughput: 15.767 ± 0.719 M ops/s
> 
>         num_maps: 17
> local_storage cache sequential  get:  hits throughput: 38.778 ± 0.302 M ops/s, hits latency: 25.788 ns/op, important_hits throughput: 2.284 ± 0.018 M ops/s
> local_storage cache interleaved get:  hits throughput: 43.848 ± 1.023 M ops/s, hits latency: 22.806 ns/op, important_hits throughput: 13.349 ± 0.311 M ops/s
> 
>         num_maps: 24
> local_storage cache sequential  get:  hits throughput: 19.317 ± 0.568 M ops/s, hits latency: 51.769 ns/op, important_hits throughput: 0.806 ± 0.024 M ops/s
> local_storage cache interleaved get:  hits throughput: 24.397 ± 0.272 M ops/s, hits latency: 40.989 ns/op, important_hits throughput: 6.863 ± 0.077 M ops/s
> 
>         num_maps: 32
> local_storage cache sequential  get:  hits throughput: 13.333 ± 0.135 M ops/s, hits latency: 75.000 ns/op, important_hits throughput: 0.417 ± 0.004 M ops/s
> local_storage cache interleaved get:  hits throughput: 16.898 ± 0.383 M ops/s, hits latency: 59.178 ns/op, important_hits throughput: 4.717 ± 0.107 M ops/s
> 
>         num_maps: 100
> local_storage cache sequential  get:  hits throughput: 6.360 ± 0.107 M ops/s, hits latency: 157.233 ns/op, important_hits throughput: 0.064 ± 0.001 M ops/s
> local_storage cache interleaved get:  hits throughput: 7.303 ± 0.362 M ops/s, hits latency: 136.930 ns/op, important_hits throughput: 1.907 ± 0.094 M ops/s
> 
>         num_maps: 1000
> local_storage cache sequential  get:  hits throughput: 0.452 ± 0.010 M ops/s, hits latency: 2214.022 ns/op, important_hits throughput: 0.000 ± 0.000 M ops/s
> local_storage cache interleaved get:  hits throughput: 0.542 ± 0.007 M ops/s, hits latency: 1843.341 ns/op, important_hits throughput: 0.136 ± 0.002 M ops/s
> 
> Looking at the "sequential get" results, it's clear that as the
> number of task local_storage maps grows beyond the current cache size
> (16), there's a significant reduction in hits throughput. Note that
> current local_storage implementation assigns a cache_idx to maps as they
> are created. Since "sequential get" is creating maps 0..n in order and
> then doing bpf_task_storage_get calls in the same order, the benchmark
> is effectively ensuring that a map will not be in cache when the program
> tries to access it.
> 
> For "interleaved get" results, important-map hits throughput is greatly
> increased as the important map is more likely to be in cache by virtue
> of being accessed far more frequently. Throughput still reduces as #
> maps increases, though.
> 
> To get a sense of the overhead of the benchmark program, I
> commented out bpf_task_storage_get/bpf_map_lookup_elem in
> local_storage_bench.c and ran the benchmark on the same host as the
> 'real' run. Results:
> Hashmap Control
> ===============
>         num keys: 10
> hashmap (control) sequential    get:  hits throughput: 54.288 ± 0.655 M ops/s, hits latency: 18.420 ns/op, important_hits throughput: 54.288 ± 0.655 M ops/s
> 
>         num keys: 1000
> hashmap (control) sequential    get:  hits throughput: 52.913 ± 0.519 M ops/s, hits latency: 18.899 ns/op, important_hits throughput: 52.913 ± 0.519 M ops/s
> 
>         num keys: 10000
> hashmap (control) sequential    get:  hits throughput: 53.480 ± 1.235 M ops/s, hits latency: 18.699 ns/op, important_hits throughput: 53.480 ± 1.235 M ops/s
> 
>         num keys: 100000
> hashmap (control) sequential    get:  hits throughput: 54.982 ± 1.902 M ops/s, hits latency: 18.188 ns/op, important_hits throughput: 54.982 ± 1.902 M ops/s
> 
>         num keys: 4194304
> hashmap (control) sequential    get:  hits throughput: 50.858 ± 0.707 M ops/s, hits latency: 19.662 ns/op, important_hits throughput: 50.858 ± 0.707 M ops/s
> 
> Local Storage
> =============
>         num_maps: 1
> local_storage cache sequential  get:  hits throughput: 110.990 ± 4.828 M ops/s, hits latency: 9.010 ns/op, important_hits throughput: 110.990 ± 4.828 M ops/s
> local_storage cache interleaved get:  hits throughput: 161.057 ± 4.090 M ops/s, hits latency: 6.209 ns/op, important_hits throughput: 161.057 ± 4.090 M ops/s
> 
>         num_maps: 10
> local_storage cache sequential  get:  hits throughput: 112.930 ± 1.079 M ops/s, hits latency: 8.855 ns/op, important_hits throughput: 11.293 ± 0.108 M ops/s
> local_storage cache interleaved get:  hits throughput: 115.841 ± 2.088 M ops/s, hits latency: 8.633 ns/op, important_hits throughput: 41.372 ± 0.746 M ops/s
> 
>         num_maps: 16
> local_storage cache sequential  get:  hits throughput: 115.653 ± 0.416 M ops/s, hits latency: 8.647 ns/op, important_hits throughput: 7.228 ± 0.026 M ops/s
> local_storage cache interleaved get:  hits throughput: 138.717 ± 1.649 M ops/s, hits latency: 7.209 ns/op, important_hits throughput: 44.137 ± 0.525 M ops/s
> 
>         num_maps: 17
> local_storage cache sequential  get:  hits throughput: 112.020 ± 1.649 M ops/s, hits latency: 8.927 ns/op, important_hits throughput: 6.598 ± 0.097 M ops/s
> local_storage cache interleaved get:  hits throughput: 128.089 ± 1.960 M ops/s, hits latency: 7.807 ns/op, important_hits throughput: 38.995 ± 0.597 M ops/s
> 
>         num_maps: 24
> local_storage cache sequential  get:  hits throughput: 92.447 ± 5.170 M ops/s, hits latency: 10.817 ns/op, important_hits throughput: 3.855 ± 0.216 M ops/s
> local_storage cache interleaved get:  hits throughput: 128.844 ± 2.808 M ops/s, hits latency: 7.761 ns/op, important_hits throughput: 36.245 ± 0.790 M ops/s
> 
>         num_maps: 32
> local_storage cache sequential  get:  hits throughput: 102.042 ± 1.462 M ops/s, hits latency: 9.800 ns/op, important_hits throughput: 3.194 ± 0.046 M ops/s
> local_storage cache interleaved get:  hits throughput: 126.577 ± 1.818 M ops/s, hits latency: 7.900 ns/op, important_hits throughput: 35.332 ± 0.507 M ops/s
> 
>         num_maps: 100
> local_storage cache sequential  get:  hits throughput: 111.327 ± 1.401 M ops/s, hits latency: 8.983 ns/op, important_hits throughput: 1.113 ± 0.014 M ops/s
> local_storage cache interleaved get:  hits throughput: 131.327 ± 1.339 M ops/s, hits latency: 7.615 ns/op, important_hits throughput: 34.302 ± 0.350 M ops/s
> 
>         num_maps: 1000
> local_storage cache sequential  get:  hits throughput: 101.978 ± 0.563 M ops/s, hits latency: 9.806 ns/op, important_hits throughput: 0.102 ± 0.001 M ops/s
> local_storage cache interleaved get:  hits throughput: 141.084 ± 1.098 M ops/s, hits latency: 7.088 ns/op, important_hits throughput: 35.430 ± 0.276 M ops/s
> 
> Adjusting for overhead, latency numbers for "hashmap control" and
> "sequential get" are:
> 
> hashmap_control_1k:   ~14.4ns
> hashmap_control_10k:  ~25.1ns
> hashmap_control_100k: ~38.6ns
> sequential_get_1:     ~12.1ns
> sequential_get_10:    ~16.0ns
> sequential_get_16:    ~13.8ns
> sequential_get_17:    ~16.8ns
> sequential_get_24:    ~40.9ns
> sequential_get_32:    ~65.2ns
> sequential_get_100:   ~148.2ns
> sequential_get_1000:  ~2204ns
> 
> Clearly demonstrating a cliff.
> 
> In the discussion for v1 of this patchset, Alexei noted that
> local_storage was 2.5x faster than a large hashmap [1]. The benchmark
> results confirm that this is still the case: a long-running BPF
> application putting some pid-specific info into a hashmap for each pid
> it sees will probably see on the order of 10-100k pids. Bench numbers
> for hashmaps of this size are ~2.5x slower than sequential_get_16, but
> as the number of local_storage maps grows past local_storage cache size
> performance advantage reverses.
iiuc, the test on the local_storage get is done on the same task ?

> 
> When running the benchmarks it may be necessary to bump 'open files'
> ulimit for a successful run.
> 
>   [0]: https://lore.kernel.org/all/20220420002143.1096548-1-davemarchevsky@fb.com
>   [1]: https://lore.kernel.org/bpf/20220511173305.ftldpn23m4ski3d3@MBP-98dd607d3435.dhcp.thefacebook.com/
> 

[ ... ]

> +static int do_lookup(unsigned int elem, struct loop_ctx *lctx)
> +{
> +	void *map, *inner_map;
> +	int idx = 0;
> +
> +	if (use_hashmap)
> +		map = &array_of_hash_maps;
> +	else
> +		map = &array_of_local_storage_maps;
> +
> +	inner_map = bpf_map_lookup_elem(map, &elem);
> +	if (!inner_map)
> +		return -1;
> +
> +	if (use_hashmap) {
> +		idx = bpf_get_prandom_u32() % hashmap_num_keys;
> +		bpf_map_lookup_elem(inner_map, &idx);
Is the hashmap populated ?

> +	} else {
> +		bpf_task_storage_get(inner_map, lctx->task, &idx,
> +				     BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	}
> +
> +	lctx->loop_hits++;
> +	if (!elem)
> +		lctx->loop_important_hits++;
> +	return 0;
> +}
> +
> +static long loop(u32 index, void *ctx)
> +{
> +	struct loop_ctx *lctx = (struct loop_ctx *)ctx;
> +	unsigned int map_idx = index % num_maps;
> +
> +	do_lookup(map_idx, lctx);
> +	if (interleave && map_idx % 3 == 0)
> +		do_lookup(0, lctx);
> +	return 0;
> +}
> +
> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
> +int get_local(void *ctx)
> +{
> +	struct loop_ctx lctx;
> +
> +	lctx.task = bpf_get_current_task_btf();
> +	lctx.loop_hits = 0;
> +	lctx.loop_important_hits = 0;
> +	bpf_loop(10000, &loop, &lctx, 0);
> +	__sync_add_and_fetch(&hits, lctx.loop_hits);
> +	__sync_add_and_fetch(&important_hits, lctx.loop_important_hits);
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> -- 
> 2.30.2
> 
