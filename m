Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209194EB572
	for <lists+bpf@lfdr.de>; Tue, 29 Mar 2022 23:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiC2Vrn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Mar 2022 17:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbiC2Vrm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Mar 2022 17:47:42 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097C0A777A;
        Tue, 29 Mar 2022 14:45:58 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22TJTRWT013569;
        Tue, 29 Mar 2022 14:45:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=O51XBozAx58rcxiqCvd23Fhl0HkY6OiimPtJ36X1bYI=;
 b=jqAgzsRLWK7//99y8IsSeV0jwCp24ueO5CoRi5AMVBxVtIpVOwicGMrftQhdiwfQYQDW
 Ihwz2ErFWOIOp0WY4gskZU92Mg35J7lDhbDE3xpD9XXJtXWjrE7CqMaLtuvekfKj3bTO
 FOMrI/aXYIOFqod8S+qxSdVh3E8InHilHl4= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f3tak6bey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 14:45:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QW+HCnRfCCpPUcqVQkn0D1tjPxfq/5KZqur5YPMrPuE4icMS4G3whkpaF8c4kAaK37h5tClrpMHoERRONV/3izwB3oP8jUqhOHYLCoJkGq1/nofiIV8anU+1IYZBCIFRZZx5MZ0nWrdJjXudUC3zfB496RWUQV2oyp4cB4Ei1idQOyTO9mvb0iS77NguIcxSRdyZmcgCBmjjlqGKfvsE2hYXe3xdKtXd5EmFkfBp5XQlWRhymK++UZa7gMeN5E9rXrUrttnVa4qw7eCUZGsg69C9eYfSd6F4OG08CG3vq9pfLA7A4DT5TCf9qOHFDQvZCmLOC2L5ZzZAXgb/zMHVeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O51XBozAx58rcxiqCvd23Fhl0HkY6OiimPtJ36X1bYI=;
 b=TwEmFHgkjpnCKgd3WzYfYYdLSMdXtZ9pvll9QN8MtfddR78dHeq6zRj969kSYey9eG5ecoK6CwuYbHFqGse0LDXVxH7ZVEU39OdW3a2ZXWyQfQQJCpUwyjP4Qj7rFF4BTX9EH3IS/e0aj+fp3XEVGXZsxfwmDMjFkVy1SCN9GRrmdQ4drh/OikXRoN4HulbuOOAhNpoOAhJ90zZYmEVQK6BYNXX2xXY/CB/moBMcpvYXF3G6JRZIeiI5/7ICB76A4xZOviqymDQ20N/UEGp0ervczkq5M6p4Jr7n9vxWxg0RV2qb6el9D7AdNAmoYwkn/mnuXcAOM+G7xJElK1ivaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by DM6PR15MB2635.namprd15.prod.outlook.com (2603:10b6:5:1a0::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.18; Tue, 29 Mar
 2022 21:45:39 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca%3]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 21:45:39 +0000
Date:   Tue, 29 Mar 2022 14:45:36 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Hao Luo <haoluo@google.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next 0/2] Mmapable task local storage.
Message-ID: <20220329214536.etivluwqqxxxphp2@kafai-mbp.dhcp.thefacebook.com>
References: <20220324234123.1608337-1-haoluo@google.com>
 <9cdf860d-8370-95b5-1688-af03265cc874@fb.com>
 <CA+khW7g3hy61qnvtqUizaW+qB6wk=Y9cjivhORshOk=ZzTXJ-A@mail.gmail.com>
 <CA+khW7iq+UKsfQxdT3QpSqPUFN8gQWWDLoQ9zxB=uWTs63AZEA@mail.gmail.com>
 <20220329093753.26wc3noelqrwlrcj@apollo.legion>
 <CA+khW7jW47SALTfxMKfQoA0Qwqd22GC0z4S5juFTbxLfTSbFEQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+khW7jW47SALTfxMKfQoA0Qwqd22GC0z4S5juFTbxLfTSbFEQ@mail.gmail.com>
X-ClientProxiedBy: BYAPR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::41) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7aeba967-3dba-4d90-6399-08da11cd76fb
X-MS-TrafficTypeDiagnostic: DM6PR15MB2635:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB2635601BE0881E70D1267C72D51E9@DM6PR15MB2635.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DYerqNQOQ7Ny90bgNMxj5arwEe9QTDYlpUL7LiDTd+Yk3RLvsoteSHPraO/i5nqFqndQyEKC5NJDwyrY3vFNF1bHgCiW0jlekTwNQ8WKRgeIa8JlbIOc6H+mcxuyqXj2Hce+7IWf9+z3OxxoFrFF2Z68kmj2mhWzkG9tEgOY83N7OWd+hced0OfMO4xAJn4aW+RqVQnfKGvy+AQjasIGV6vu1KyCAP6/p00obEaZZ331iTHh9EydBq5CcX40ysmw9krdkz6AatfWmQdtyw1vSegvm3u1PLaJNOhIlwawpfXO9AI/2/xRuTOQI+ot2pIPJx5JdyZnOSHO+JlUPI21mT4qgOM9Zo37EY0ASZSMvVspixwPVPEgFm4uiob8OSQaCmm1SvbF5meRvClCOx8yDJ4IPuHSOaYK7r/R+MdTNDWiAkZPm/PHPTS9bIx2+bTl+nG+bWX8GLTX6oXeRCdWptvrCJIAy2eyA/aX0Y2oX379BukG6nVKOQIwAL4IG5D9w1maQeIbQ3Pq/A2yBZ1Sz5sAsD9uwp1RoJjn4ymT0nO+LVWKSFhJLwxzxj2d2PKg0SdFkiZl9c7bYlX8xmhREAzyQGBE9kPYPXmiSfAM/PB4Ixty3Il14LQF+ycc/NM1dnt/xY5ErYTUABTzPEgBbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(2906002)(186003)(38100700002)(1076003)(53546011)(52116002)(8936002)(6486002)(9686003)(6512007)(86362001)(6506007)(6666004)(508600001)(54906003)(6916009)(8676002)(316002)(4326008)(66476007)(83380400001)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xOlYsZqLowugxZRlOj7yDDPQ5UNTcqJ0ICNcjnr0WsICOG+wc5NIW1JKtCY/?=
 =?us-ascii?Q?3mZgsrj9X7voLxRKxl0Fhl+GKa+qA13JJWqWBjlQkfPUU1pIzFjvNLxnQAG+?=
 =?us-ascii?Q?x+qfcfoQBl/8tOjMQLCobgvA8eN3eqNILqgG82pZ6j/tpIrhNb93MmSOXu42?=
 =?us-ascii?Q?u8oTPc0g0jwflDC6gS5EmfCcu1/ceE+o6au8XAtS21v+e5D+KtJH7u5Pd+vg?=
 =?us-ascii?Q?fJaPLz4ClRC2YEuNr5XRFt35+uaf1ETGm4BdyhUUFj8K2NIu45wQ9NVpGi9U?=
 =?us-ascii?Q?ajsDoOr+ZxvP1YPVR33a4KFVbeCmzwt36axrJaWaKLOAFHhgA9MkeQ5ynlhG?=
 =?us-ascii?Q?1Gq3Q886TvkJEZUzWzN5kELS0HgPfsFShWUta4J2ztnHTYUzMwltAe7W8ysq?=
 =?us-ascii?Q?hZ4Us5zlvYnN/ayUZhgQ16qUyAnRuOuR3T9s+nwJqH2wrPvzkaNrzZE7TX3E?=
 =?us-ascii?Q?N79bsD+6I0qD7cQ9jYpYYJ2O4wdkurLChlVwW4vMOMlbQqEiIQ3xgUR2PXNj?=
 =?us-ascii?Q?N+IMf3dE15FXVKtwz6XXWnWdudiSXB+lxmFfQrS0/H0lP6x0sfizMzTw9M0y?=
 =?us-ascii?Q?38jmj4agrBOaHAgtSKm5RFzJyrBvvA5O12vJB9pQmLi7SpNolF37S5e6exAa?=
 =?us-ascii?Q?C+qKbyQFMQhviWxbQVLkYWjUGUYnVYZGDwt4SoDZJb03TuFsgJomMjiCwjcl?=
 =?us-ascii?Q?XdHmIUIjCNzfzZsvAv9e9mmMRaOXQQ64SXu1pRvLQKKfazaCTTRNw3FDQ5aA?=
 =?us-ascii?Q?q/r60GfSCXKESnxAR0cj6TxFQolOGS+3BQ1awGNtqoiRefwXJNzekirjSIFy?=
 =?us-ascii?Q?Z1j5914dPb4/s6vKhBJBwGOG/Yz4xlmBY2lqjRP0S6QtwlnZP0psPKCJ9S/p?=
 =?us-ascii?Q?YLxHn7zZXlHJO2rDmjKdipXgrR59ZjABO2VTjD9se8ON1oj9nJtnIgMG9YF+?=
 =?us-ascii?Q?HCSm6BcOLuVyUDcGCO00xCT/stBT+bpuv88vWnuQ+WYfK5WUxgOzawonBNWI?=
 =?us-ascii?Q?rg579hZ8UOwBskUCsHwwtNAHUek4/eUFjtI8VxDfAnlsLgpr7/R3EJbsVIJm?=
 =?us-ascii?Q?fElg9H2Y+0N4xQ6uycB061EHsUTKBgI6WTqdXjfRqwdM7CSIuBhL/tSmjQZV?=
 =?us-ascii?Q?4BY8uapSacevIIammO71KTlbAABOGkU9h8twtla+qHDe4ZXtnwM2nRhVZam0?=
 =?us-ascii?Q?f9dHZJSBnwLhTsQnNXZp+1S1YfulgKrBxqypAX7xYH6L2B72eh3YIIOA8Tdi?=
 =?us-ascii?Q?cTCrF41bAmuNligj+Cy8jYqt0X0aQfpdmp6CfCA1ovl0GuoVnG7MRdxAAWR6?=
 =?us-ascii?Q?gQGZ4fTxZos9RYlik+M6lY83PyYzMHpXOyc65Dj43Up/drLRLbJJD2Y2Jr4O?=
 =?us-ascii?Q?QQrOGWUVm55ScDTpzeGNTO6iRiBGyoQGuNU4wrKGferOCxT9BpR/l9RKpS7N?=
 =?us-ascii?Q?i7Vyy/61TyRByawRL8d3rpA/LTiSFi+GWOPkWPjNl68dpvU/06YUSXAbXSBq?=
 =?us-ascii?Q?t9hR/ngfThpn0itwqMuUv8t+9/AIhtmKkWu1dtfBypKONFEhHpr+UJVR/wrF?=
 =?us-ascii?Q?KMpUdfSm30tIDnUb6cirKrLTC32+SmHRhqMZUzALGMDyRcr9j/pa6wphVpa4?=
 =?us-ascii?Q?3cbPVIwV0Z4LCuct8p4N325jR43HqGuVbQEoSUBv4rKkigQ8o1O3zj47ICup?=
 =?us-ascii?Q?EE8RMgpz3kS/tqQau8sJYs45NP9Ca6kq+in2TIjCwmaOgU6MEw7u4raaV9eG?=
 =?us-ascii?Q?BUkud21yxmsCdfc4EM0SRREQQWfA35M=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aeba967-3dba-4d90-6399-08da11cd76fb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 21:45:39.0531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrZtzfwSoDBwuY59IMWm/LNEEFzqXOn1NFokO3FJMSJzwKnJ8zRwUCV8ESMYtwcz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2635
X-Proofpoint-GUID: v2s7oPHFH8fcj8dqRfTs59P-4xCfaUt7
X-Proofpoint-ORIG-GUID: v2s7oPHFH8fcj8dqRfTs59P-4xCfaUt7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-29_09,2022-03-29_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 29, 2022 at 10:43:42AM -0700, Hao Luo wrote:
> On Tue, Mar 29, 2022 at 2:37 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Mon, Mar 28, 2022 at 11:16:15PM IST, Hao Luo wrote:
> > > On Mon, Mar 28, 2022 at 10:39 AM Hao Luo <haoluo@google.com> wrote:
> > > >
> > > > Hi Yonghong,
> > > >
> > > > On Fri, Mar 25, 2022 at 12:16 PM Yonghong Song <yhs@fb.com> wrote:
> > > > >
> > > > > On 3/24/22 4:41 PM, Hao Luo wrote:
> > > > > > Some map types support mmap operation, which allows userspace to
> > > > > > communicate with BPF programs directly. Currently only arraymap
> > > > > > and ringbuf have mmap implemented.
> > > > > >
> > > > > > However, in some use cases, when multiple program instances can
> > > > > > run concurrently, global mmapable memory can cause race. In that
> > > > > > case, userspace needs to provide necessary synchronizations to
> > > > > > coordinate the usage of mapped global data. This can be a source
> > > > > > of bottleneck.
> > > > >
> > > > > I can see your use case here. Each calling process can get the
> > > > > corresponding bpf program task local storage data through
> > > > > mmap interface. As you mentioned, there is a tradeoff
> > > > > between more memory vs. non-global synchronization.
> > > > >
> > > > > I am thinking that another bpf_iter approach can retrieve
> > > > > the similar result. We could implement a bpf_iter
> > > > > for task local storage map, optionally it can provide
> > > > > a tid to retrieve the data for that particular tid.
> > > > > This way, user space needs an explicit syscall, but
> > > > > does not need to allocate more memory than necessary.
> > > > >
> > > > > WDYT?
> > > > >
> > > >
> > > > Thanks for the suggestion. I have two thoughts about bpf_iter + tid and mmap:
> > > >
> > > > - mmap prevents the calling task from reading other task's value.
> > > > Using bpf_iter, one can pass other task's tid to get their values. I
> > > > assume there are two potential ways of passing tid to bpf_iter: one is
> > > > to use global data in bpf prog, the other is adding tid parameterized
> > > > iter_link. For the first, it's not easy for unpriv tasks to use. For
> > > > the second, we need to create one iter_link object for each interested
> > > > tid. It may not be easy to use either.
> > > >
> > > > - Regarding adding an explicit syscall. I thought about adding
> > > > write/read syscalls for task local storage maps, just like reading
> > > > values from iter_link. Writing or reading task local storage map
> > > > updates/reads the current task's value. I think this could achieve the
> > > > same effect as mmap.
> > > >
> > >
> > > Actually, my use case of using mmap on task local storage is to allow
> > > userspace to pass FDs into bpf prog. Some of the helpers I want to add
> > > need to take an FD as parameter and the bpf progs can run
> > > concurrently, thus using global data is racy. Mmapable task local
> > > storage is the best solution I can find for this purpose.
Some more details is needed about the use case.  As long as there is
storage local to an individual task, racing within this one task's
specific storage is a non issue?

The patch 2 example is doable with the current api and is pretty far from
the above use case description.  The existing bpf_map_update_elem() and
bpf_map_lookup_elem() can not solve your use case?

or the current bpf_map_{update,lookup}_elem() works but
prefer a direct data read/write interface?

btw, how delete is going to look like ?

and do you see the mmap could be used with sk and inode storage instead
of the 'current' task?

> > >
> > > Song also mentioned to me offline, that mmapable task local storage
> > > may be useful for his use case.
> > >
> > > I am actually open to other proposals.
If the arraymap is local to an individual task, does it solve
your use case?  Have you thought about storing an arraymap (which is mmap-able)
in the local storage?  That could then be used to store ringbuf map and
other bpf maps in local storage.  It is logically similar to map-in-map.
The outer map is the pseudo local storage map here.

> > >
> >
> > You could also use a syscall prog, and use bpf_prog_test_run to update local
> > storage for current. Data can be passed for that specific prog invocation using
> > ctx. You might have to enable bpf_task_storage helpers in it though, since they
> > are not allowed to be called right now.
> >
> 
> The loading process needs CAP_BPF to load bpf_prog_test_run. I'm
> thinking of allowing any thread including unpriv ones to be able to
> pass data to the prog and update their own storage.
