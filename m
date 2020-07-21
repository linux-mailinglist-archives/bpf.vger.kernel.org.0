Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5112287F8
	for <lists+bpf@lfdr.de>; Tue, 21 Jul 2020 20:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgGUSF7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jul 2020 14:05:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54632 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726763AbgGUSF6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Jul 2020 14:05:58 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06LHv2OJ005917;
        Tue, 21 Jul 2020 11:05:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=zuUAdC0BEeBTp/O8VbCNnMGRe0m942XGTTGD15d8DE4=;
 b=EK7FPxIISsMZQot3+HElO3j0aNa+AxBM2wR6enaremt8UByVyps6b5NjVQKsSW7EXj3q
 2K2Fhspb0+ra/tP9VKQalcz5LMxOJI1QYduONtEydF4/qHYvxiJgKGSmEXMwn3jOX9gI
 5q0+PFt9LjLyc2ZVcTHgNQ+BXs1JmYgpI3k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32cgsparqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Jul 2020 11:05:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 21 Jul 2020 11:05:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDJp9/3TSgSnf6ZFHymvKTeTUoDCXKQW1CAVPBCBs5eHBi69JtwV+vGNOENrpJ9Umd8u+JcPfiPeSHzv1TncFw9rm/yFDNgHRmjNkb7mLhN9y1b2IB2KY+LhYo2O8y11awt1nDrJbOHYe4sDcBrpSmBaM47FOopxwZIF6PPvbykGwCJeKhq8no3OHKCNVUirMbbsChfj/KqlycCqw5fGYWVzCG2z6jiN+cPiihHAk6Z1Ssn8v8+kUm3211EW0TYPWH0frShBfACYaqdwozsyZCEnyOyeHYSlLz5jWMdN/IViy9nW7u1dMl9+v9t4T8RnydG+It4zo7kn0yV/6Lk0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuUAdC0BEeBTp/O8VbCNnMGRe0m942XGTTGD15d8DE4=;
 b=h7K4hCEFx1tTt9RJPnXj68ii2XJUREHFgOwl3dw64H79Ocyb6xikTq/iBQiWF9TdRtpxc9WbzyIAX2XSAH4qzPJZMYlHSr18YLpUq4bmaEqnM9JRYUUC6l3B8QknfYB89F1cIDbVkW9iwYzRGUdcK0pk5vFBibKstZ3Bw4e5RVKJB0Mam6/8diFqP50eev4x8oL1NIcPywX+jNELaq6sWsiSvVsE7EGverXfxfNyiCIqxzZrZFo4qSEiHZes8wCSulH9GWJLXkBMOAteBpjrzbSmFDVg+w/us8m0Wz4t5sU4EQQwdKJUj3Plxxio9YnrkYNAB+at3gPGKTZjzhuzCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuUAdC0BEeBTp/O8VbCNnMGRe0m942XGTTGD15d8DE4=;
 b=G/ddWjPmAmjEIjFNYBpElwZ/KUAjpXUegd64cKzrqvDZn9kjcs3yfT3rNR1+PfVKhEe1eNteg1sZGFgXpByXW5M64ouxa5oCOYk+aiaBRcTyjpyvIUOJnb+YdZ7vA5ghTHqd/32hTqDWCZcHGaVOwrwLz8nhmdkCES7xpCD21Zk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BY5PR15MB3668.namprd15.prod.outlook.com (2603:10b6:a03:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Tue, 21 Jul
 2020 18:05:39 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3174.030; Tue, 21 Jul 2020
 18:05:39 +0000
Date:   Tue, 21 Jul 2020 11:05:36 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v4 bpf-next 3/5] bpf: Make cgroup storages shared across
 attaches on the same cgroup
Message-ID: <20200721180536.57kbngehupi4hqra@kafai-mbp>
References: <cover.1595274799.git.zhuyifei@google.com>
 <f56279652110face35e35f2d4182da371cfe937c.1595274799.git.zhuyifei@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f56279652110face35e35f2d4182da371cfe937c.1595274799.git.zhuyifei@google.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BY5PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::25) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:d11e) by BY5PR04CA0015.namprd04.prod.outlook.com (2603:10b6:a03:1d0::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.19 via Frontend Transport; Tue, 21 Jul 2020 18:05:38 +0000
X-Originating-IP: [2620:10d:c090:400::5:d11e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7621510-7ea2-4f84-9164-08d82da0ac78
X-MS-TrafficTypeDiagnostic: BY5PR15MB3668:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB36683B92D6215AB21AF3FB27D5780@BY5PR15MB3668.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRtatkrgFsMUUFE6rJJD0ZYnvolG0tjJk7GNr2DpsW3taCF5IRMsZVJcLrCusgjH4xajC4p+BWAT3A9MsNiE3zOjbh5UuR9BWQnQaSKLMqD2vZKnnPb8iYlXmkCZrj/mXMNrLee0Gk6/8Ia2yrPqVqPX+cn6bf6iBk2tysubi1yz5+JbipBurHDcqzkggalOm1gzzBxllPMjd+KHqBL2t1PwU/jKT3gu0ep4QRVxQqFOMwX/Gr46i+WMqcZ/LAzpXqneZSY1cHCb0R0tS5yRoY4JtymiMRjVoWVmWY+s4cr6OV6KbNpePsmml5cmwW6mAU1hKEQvC0MzmGl5pDRLow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(54906003)(8676002)(52116002)(4326008)(6496006)(8936002)(55016002)(9686003)(1076003)(2906002)(6916009)(5660300002)(186003)(66476007)(66556008)(33716001)(66946007)(86362001)(16526019)(498600001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: mrNZXgcCiidfbwPTp6/aAH2PdX7OklAV69rTYY7W0VQw/PTwAJqrJCwlCVxTNECjYEPkow8YcwbBN/OxTBPTBjwUjLl/3yBOzkfLaridiUKem/GoOvnbErhedOESX7gWXZ0BoLMF+ZKbF32hV51Xgd1X/9JwTCEwIlzJ/4rbAi6H9ZS2WLmm5jCjJBMcRygIhQq9cZqAOYHa98zy7jJnJxkzNXRPQmX0kZfctwMCs+lZBgihEIOlZ5r+JdxwpDm/phs9pl/MwwkMJZwGbIsZvNkr4rKNFfd61oRDsdd+IVZWlCVAK+pn5yORxuxfen5Ww2ZS+JgQxRmU0E8FQuVGf2PVLWoqPDjE+pFI4/y3a49luq8krMyZM2dqJ3w0MSxM9YltxyXIHWyPqLF0KOhBmIdVZhvSZIW48a204og6XDLDaq6bJ/NpM/7HIdKPpDLf/ADbF1sH1jUyahauCp6gFZxB/pkzrBoHUh1acpcSs/coa1U5zxVl9E8plr+RXL5W3P+BIsZLmTNuCOfOUlBV2A==
X-MS-Exchange-CrossTenant-Network-Message-Id: a7621510-7ea2-4f84-9164-08d82da0ac78
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 18:05:38.8422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rlSQL6YP8KwGZHxpaBc3VT1IB3/djGgR1Gql+58H6U9Z/ZAqadU2l65eZ1Fqy1u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3668
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_12:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=770 clxscore=1015 suspectscore=2 priorityscore=1501
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007210121
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 20, 2020 at 02:54:53PM -0500, YiFei Zhu wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> This change comes in several parts:
> 
> One, the restriction that the CGROUP_STORAGE map can only be used
> by one program is removed. This results in the removal of the field
> 'aux' in struct bpf_cgroup_storage_map, and removal of relevant
> code associated with the field, and removal of now-noop functions
> bpf_free_cgroup_storage and bpf_cgroup_storage_release.
> 
> Second, because there could be multiple attach types to the same
> cgroup, the attach type is completely ignored on comparison in
> the map key. Newly added keys have it zeroed. The only value in
> the key that still matters is the cgroup inode. bpftool map dump
> will also show an attach type of zero.
I quickly checked zero is actually BPF_CGROUP_INET_INGRESS instead
of UNSPEC for attach_type.  It will be confusing on the syscall
side. e.g. map dumping with key.attach_type == BPF_CGROUP_INET_INGRESS
while the only cgroup program is actually attaching to BPF_CGROUP_INET_EGRESS.

I don't have a clean way out for this.  Adding a non-zero UNSPEC
to "enum bpf_attach_type" seems wrong also.
One possible way out is to allow the bpf_cgroup_storage_map
to have a smaller key size (i.e. allow both sizeof(cgroup_inode_id)
and the existing sizeof(struct bpf_cgroup_storage_key).  That
will completely remove attach_type from the picture if the user
specified to use sizeof(cgroup_inode_id) as the key_size.
If sizeof(struct bpf_cgroup_storage_key) is specified, the attach_type
is still used in cmp().

The bpf_cgroup_storage_key_cmp() need to do cmp accordingly.
Same changes is needed to lookup_elem, delete_elem, check_btf, map_alloc...etc.

[ ... ]

> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index 51bd5a8cb01b..0b94b4ba99ba 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -9,6 +9,8 @@
>  #include <linux/slab.h>
>  #include <uapi/linux/btf.h>
>  
> +#include "../cgroup/cgroup-internal.h"
Why?

Others LGTM.
