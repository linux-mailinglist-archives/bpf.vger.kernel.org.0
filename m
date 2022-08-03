Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F251589129
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 19:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbiHCRTw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 13:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbiHCRTv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 13:19:51 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA80053D25
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 10:19:49 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273EwLHc025716;
        Wed, 3 Aug 2022 10:19:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ihOUK0cMWqe2SBG99XXqSvkZrpoDKeazfysaAq2Eskw=;
 b=XmiF1PCyD8iYhVVlbKOYCoACaVDelKca7+9aZJGXIYXjCXJknM20iKsTSi+zNa7WW0Wd
 lusaFD9bQJ64JSJ0on14KkPiy52CQuVZOCZR8uxB1oKNWAnMMwlkQ+c/LcqDDaYkPlhr
 IcSZl1S6QGQQt/xSJ9Or0sYFkS7sTg4+ZYU= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hpy32kb0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Aug 2022 10:19:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HymOntppmvO0FggHAd9m68umgxYQhJUzmOU9NoH7nQL5OBjl2UOsRMZWRQIHJGtPfq0FS1OQZvkughk6W0YwkBGhp8gs6xl6XH3bQrOVK86qDPCBq/PZ3Q9bIycZaEzmd1uuvABlEjvAZT+MsUax/BYw8r62WOlDQWc5GfPkpkff7JD/ahPg2jJNy9myD5x4bd9WAHDzcFU8SAl/mhjfWJnWBiXPVFna5o15GaPr0dWHEcQcw5h9edQyHeRZPjdXYbWKfTF+i86t4bZHnJN8X1LPmWfY4Vn83pb/nsWlgnQzr7NhA1OfmFqbGa3KBcAe2MRAWuc1zT0BDZBOH3dttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihOUK0cMWqe2SBG99XXqSvkZrpoDKeazfysaAq2Eskw=;
 b=F5OSb6RpokHzOP+rR/w6AtVKHFnpbBKHzltJNTQHRxMztrDF/Wzi5JUey/zzvfRvrcEiU9qkdaKWNEwqqbvPtyKf/K3lvAOFgKQ5kscdk1JblzyX/92DZRkHY/U7ygN7jRp953FVcIJ3MMQyKgGe/5VOUi7FPgQGpAbVo+xkl/O2Tk4VD/5dUjl4w4QHkr4URI084h0OaWiH4hapSCMEvzM0kxlbPAx/EvU37YYbHl6+2OuhRTh5vlWDhjxqebZmt7Yp9rQHMgBseGt8XLyhoiyBKzuP/8fjKUEek/h1utyG8xcdls7fpItN9NuOKNh81kk9JpRTkKbLDgD0N1FfwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by DM5PR15MB1244.namprd15.prod.outlook.com (2603:10b6:3:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 17:19:06 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 17:19:06 +0000
Date:   Wed, 3 Aug 2022 10:19:04 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Excercise
 bpf_obj_get_info_by_fd for bpf2bpf
Message-ID: <20220803171904.m2gqrd3rf4td6l4p@kafai-mbp.dhcp.thefacebook.com>
References: <20220803163223.3747004-1-sdf@google.com>
 <20220803163223.3747004-2-sdf@google.com>
 <20220803165142.jp7xesq4ejxhwtl7@kafai-mbp.dhcp.thefacebook.com>
 <CAKH8qBsAotiMp8zj_MgM73mrOEVmvrX7UEuBB63ViHee4Z37WA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKH8qBsAotiMp8zj_MgM73mrOEVmvrX7UEuBB63ViHee4Z37WA@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::33) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53722543-79a1-4fce-4228-08da7574451b
X-MS-TrafficTypeDiagnostic: DM5PR15MB1244:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DZdQCyu6lHDj4+XyFT2Sut67+k1MJFAdwPebr5fGBMIHi0djvihPjYmFmYQze2y+o7Q+LulsU56aA98BFUOUQE0P6QHAblSDJPZxhx2ffhcIlpeTUk6SBFdI9huJRCYRfi8cGWkTKip2V5Y5ONkO33RAVT6+H5omc9o87tqqsloXdyqyQlmSOFL8BiBuR/zcxecT1PLbaQ8Jisw+QnVRTzEGNEF9/V3r/6VtqRiaWoqzKL5rCIcGIpnvSNDcD074wcUy8oZNBPkLLgDTHg9h0DCGbulguaCGME6BAcKznzohyqnC47NT6totccB5Fo77mN0DF+JJeFRIAVyWI0wBWrSGbWnzfltMppfNEfvU/3bWWESJCsFcBEUt9VYChbJZd/1pS0f50YDH810KUu8V/cehSbefMyqAhHKqzh3pPvcNeoArKQmXN4vZ3zIlwMx9eoaarI05u5lnf4kqMAQroo/qBb0YSEAr36Qcbv8K7xzu9FJrbpqJwLPq3CaHigQxcKXE9cXZ1W47lEq9Adk9xdkgXlrBVNg7DB2zc/aRq8USDS6h5MMkIszJvj6nbpLsCM9oEwW3e7RhOf3GohuK7x6w4wufrtlKwQkhxB/b28b2RCKxwWxzfG5jLtHMXkkGvHD1L/fdnQ+wt6d/zHVAjwJuLx7zcUloHbpdPRrSpc/5BvVTxM3IVftVr1Uwuy5PyN1DdpgZvm9kCNUithNon8c96KJXh+PEeoy1ZekpvNIZz3LSqwtEQduQ9/u7ORVx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(38100700002)(8936002)(4326008)(8676002)(66476007)(66946007)(86362001)(66556008)(6916009)(316002)(53546011)(6512007)(9686003)(52116002)(6506007)(1076003)(186003)(478600001)(5660300002)(6486002)(7416002)(2906002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R9t/scGtiQbGg2UYf5Bt7ZXaKxGNNpVWfz+DLlJxFnJpgV+ZyYBdmMxu/QL1?=
 =?us-ascii?Q?tlM2A4bi5gsiHtqKsfuj4EXSolNb+bXDbbmDujxUcTriz4U4MpnN//rrYfKR?=
 =?us-ascii?Q?1gdkUut8lSiHFPoO6HzqKC3bGvyKiZKX6J/IqH5DV6DxgunmaqntI4XBA4r0?=
 =?us-ascii?Q?0vDFmMU6tWSUQrdAt9E3JTyZF1aUv/BaANhp5e/Y0HyV54Gr+eNIKSygmMpa?=
 =?us-ascii?Q?Z8afpVcM8AE6tdPPak0AGflJutj7b3lN6kL9JnNV65ZQ06IMRX1rmJFuhqnh?=
 =?us-ascii?Q?1BnHv8UXRZqv3cmcb8VYDfuWzgEjqbOz5LI/R0zpMBWSD54SChJPJHqzlv7n?=
 =?us-ascii?Q?QR46WeMEUNG7yC7Yc7tynBw5j1d3TOm2nayekgR4X+W4XqlYLkSJyJLo93ld?=
 =?us-ascii?Q?MSieaIU9GO77OxLGLBYxpd6byxaEjgyVX4y2lU6IWct19jZY7PwHUlOhy3Nl?=
 =?us-ascii?Q?NVTq9Y2NyD1yxkTZMOrelOVhnq365MeekEcrPExHhVFaEa+BjpNfIQwS0tLb?=
 =?us-ascii?Q?/BR4lgMUGt4loAwtdMEBM6FGe2s1YzKqHS9bUdx9xiaSn9dBMbzwQJL/vq9X?=
 =?us-ascii?Q?M/aEdj7S7NmlSC6TFytL8N+8VfiRCEbCqRIuxHH1Hy7uWkkIlx57LB2cxKic?=
 =?us-ascii?Q?EE3QVBGX/vtCh9tNaHf6POFcjrQzEIRDIakVZSFInm20dP2LVrsNRb2mmwg8?=
 =?us-ascii?Q?UoGHUNSxhy+NTBYah7686X7NTQSb+WVg/Bj07pCNcpHGSoVLUfZFJM0ISX9I?=
 =?us-ascii?Q?qzy1T8Ly5PgC9YpA6Q+3RtG4FsGrLJ1FbwRl7rTU5r2Pad271aABMi4K/go+?=
 =?us-ascii?Q?4UUhEFl8XT5Y8aAib8iDwt42ZY20X+NfGmHkyIYDej+dmDB090uIgYgfJtDx?=
 =?us-ascii?Q?Fuyv2+vTiScZNEKC4XKrk+c0C9LoUsTZFAHn8IAROOkIoY/kk9VUWdx8uPpM?=
 =?us-ascii?Q?cr1ZLx5asi2ViG5pMZELnakxpdSVh+hbFCeCmcTlM6NYDdCdZHbJO0v9XZjB?=
 =?us-ascii?Q?2YFMfmqgMP27TnsXoJ9mSojFq+Z8DOKdU5a1D/Ra8KFrmVC00r6oS7y1bUdo?=
 =?us-ascii?Q?/+/86vkg6l4zIRfkRrG2nQy4Cdoxn9IW8bHqhR85J3CVjDPh+AVehwh+Vaq6?=
 =?us-ascii?Q?pQ39IoqktUd/mZGH0hSLvXMzSHU6whaRrdUTTGLt84jnb0XYN0bgCboIAayc?=
 =?us-ascii?Q?y6UymwIJUJEqmz9dsrAF+NUZ9Qd0PASz4X59ZLvm1d4dP3/O6/uhv3w3bdn8?=
 =?us-ascii?Q?Z2KPGl/jZVncgRI0/ctB+zf0owXYacUdOvNkwKRTsc1o6YMzqPFiTHjiVnPQ?=
 =?us-ascii?Q?88yUgbekvbOVHXXMuCI06kQtcWxTR25Q1yB4pM7drW0m+a7nq4lqQAwtO1Dv?=
 =?us-ascii?Q?svt2EC11cZFDvwBO8nI1zbPb6iuC/XUWM1avrcnYM26fUAvtMCRJGeLKK4yR?=
 =?us-ascii?Q?z2s3BfnE3Wd0QfMBUGySvhiR5vroedG35XM8Rdc/apjdNICBHWwlfJoN9scz?=
 =?us-ascii?Q?ffsj7mWd89kk8SJVfiZTavz6O4+IRgS6rtTqKv0oq637EBhsBXkUsBNCnAjW?=
 =?us-ascii?Q?WRr2fvVxlWCphs3L1ayHnoaxE1AXDOCKjsuOjkrFhikLruk7xZugmV/WlRHu?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53722543-79a1-4fce-4228-08da7574451b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 17:19:06.3666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VlyllWE11RCzlYiNdcYbV0OpzX4lwoVcI9zkgJpYPp1fLGOe9p7V7udxtT01pqnC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1244
X-Proofpoint-ORIG-GUID: _AjXeKm1i509Dn2f3wCB-WWKPUZ8hCLD
X-Proofpoint-GUID: _AjXeKm1i509Dn2f3wCB-WWKPUZ8hCLD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_04,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 03, 2022 at 10:10:33AM -0700, Stanislav Fomichev wrote:
> On Wed, Aug 3, 2022 at 9:51 AM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Wed, Aug 03, 2022 at 09:32:23AM -0700, Stanislav Fomichev wrote:
> > > +static void test_fentry_to_cgroup_bpf(void)
> > > +{
> > > +     struct bind4_prog *skel = NULL;
> > > +     struct bpf_prog_info info = {};
> > > +     __u32 info_len = sizeof(info);
> > > +     int cgroup_fd = -1;
> > > +     int fentry_fd = -1;
> > > +     int btf_id;
> > > +
> > > +     cgroup_fd = test__join_cgroup("/fentry_to_cgroup_bpf");
> > > +     if (!ASSERT_GE(cgroup_fd, 0, "cgroup_fd"))
> > > +             return;
> > > +
> > > +     skel = bind4_prog__open_and_load();
> > > +     if (!ASSERT_OK_PTR(skel, "skel"))
> > > +             goto cleanup;
> > > +
> > > +     skel->links.bind_v4_prog = bpf_program__attach_cgroup(skel->progs.bind_v4_prog, cgroup_fd);
> > > +     if (!ASSERT_OK_PTR(skel->links.bind_v4_prog, "bpf_program__attach_cgroup"))
> > > +             goto cleanup;
> > > +
> > > +     btf_id = find_prog_btf_id("bind_v4_prog", bpf_program__fd(skel->progs.bind_v4_prog));
> > > +     if (!ASSERT_GE(btf_id, 0, "find_prog_btf_id"))
> > > +             goto cleanup;
> > > +
> > > +     fentry_fd = load_fentry(bpf_program__fd(skel->progs.bind_v4_prog), btf_id);
> > > +     if (!ASSERT_GE(fentry_fd, 0, "load_fentry"))
> > > +             goto cleanup;
> > > +
> > > +     /* Make sure bpf_obj_get_info_by_fd works correctly when attaching
> > > +      * to another BPF program.
> > > +      */
> > > +
> > > +     ASSERT_OK(bpf_obj_get_info_by_fd(fentry_fd, &info, &info_len),
> > > +               "bpf_obj_get_info_by_fd");
> > > +
> > > +     ASSERT_EQ(info.btf_id, 0, "info.btf_id");
> > > +     ASSERT_GT(info.attach_btf_id, 0, "info.attach_btf_id");
> > > +     ASSERT_GT(info.attach_btf_obj_id, 0, "info.attach_btf_obj_id");
> > nit. This can check against btf_id.
> 
> As in ASSERT_NEQ(info.attach_btf_obj_id, info.btf_id,
> "info.attach_btf_obj_id") ?
Ah, my bad on one line off.  I meant the previous line.

ASSERT_NEQ(info.attach_btf_id, btf_id, "info.attach_btf_id");

The bind_v4_prog's btf_obj_id is lost.  Otherwise, it could also do
ASSERT_NEQ(info.attach_btf_obj_id, bind_v4_prog_btf_id, "info.attach_btf_obj_id");
