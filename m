Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6551D22BAC0
	for <lists+bpf@lfdr.de>; Fri, 24 Jul 2020 02:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgGXAGR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jul 2020 20:06:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5618 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727778AbgGXAGR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jul 2020 20:06:17 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 06O02ksa030045;
        Thu, 23 Jul 2020 17:06:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=kBlsdemLngBTKZfseu+sop9GSagtSTXcJiPrI+qxK+0=;
 b=nF9do9FG6eCKidCg44okS4O7tUIGr73TAJ1H95MwI2eoqC08EBh2bQ0FwwL3xFFeJqRS
 +HNrBj0peR44XmAJEd8DE5gLdMdJ7FjkY59K/t0Fy2oaYO7pwlyBuEUuxyyrOtMH/HBA
 EFXlbr9JryyCzDvqtfT7gYlHuXSY2xkBwB0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 32er2ffsts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jul 2020 17:06:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 17:05:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSiBNc+NQXacd8ghHtXlR5HCBZ1LmRWITszCYfX7QUx/Q8uVmM4dhVkRW87a5Ei9JhTsjsC/cjm6eWO9wKvdAX4sAFVFKyaXcjB9yoaFvp3J0V5BquScqenOPbEylQP9GZ1/4T6PSoeKLlluYC0X92TYtbPv5tAe6CUpMxctpBqVhid18hRRmBTc+n4hPXryGncmU7uBYCPyKOhoE7j5vSjD/lwE87XVF6wOhTiNv91gSbYZg/O1RWRFRjoEVjVZmJ7/X6Siqf/y2TD7zNDicajyL8mXSu7Kcuf3es7lf5HZ9wvDycCJvNEg5UDMSXLyQJp5C5o4ggyjkpxYQpCWcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBlsdemLngBTKZfseu+sop9GSagtSTXcJiPrI+qxK+0=;
 b=AzYQNh63Iij5wXZ8+ebkoAr1dwKvCOcKCCW6EczW1ZUefC1eNofWlJYRBrDG0lBwBMknLKYthVg9rCoxC7R/PsesFLeDbt6X9Ocdr6xci5f70ficxNSMR8/acmOsI4JjubUaIL37IWSpM8rur5xU1o6q3jnnKuO4ufDZwNP29n0z8adabsJTmLGJ+zF+aTHbYFd2gz3SWJGk5JxdaDGMY2nV1S553NUPNVs2Gej8pVGKmXepl8Fu4Tusuy3YO7+n2WpC3oMZ2pBoLdr5Xr8m+P2Ywyi//m/Q3VHA6gRQnrB4n2iCUSlwMvlU2w+NZJVfDW/8pQE7nVCNFN/aIhxzqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBlsdemLngBTKZfseu+sop9GSagtSTXcJiPrI+qxK+0=;
 b=LmUZYHv4li8Auh424H9ILveZhJvD5C9Srj7OBk4a0G1yqbnV9J+ZpyUSlKmyChWsfYUQ6blMJhS7iG785U7X9LqG/qbHXFnZyEBi+4ZWOEuBztIsCiun/g4SgD9Sf8+Z9eOem6azZStiHxYSJmuQDjHyOviOXou8ocC6ehGdxFM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2822.namprd15.prod.outlook.com (2603:10b6:a03:15b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Fri, 24 Jul
 2020 00:05:53 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 00:05:53 +0000
Date:   Thu, 23 Jul 2020 17:05:51 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] Make BPF CGROUP_STORAGE map usable by
 different programs at once
Message-ID: <20200724000551.qi4y2isxtgdtcgzc@kafai-mbp>
References: <cover.1595489786.git.zhuyifei@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1595489786.git.zhuyifei@google.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR01CA0057.prod.exchangelabs.com (2603:10b6:a03:94::34)
 To BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:ea06) by BYAPR01CA0057.prod.exchangelabs.com (2603:10b6:a03:94::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 00:05:53 +0000
X-Originating-IP: [2620:10d:c090:400::5:ea06]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12da3d1f-e86e-4144-2840-08d82f6554b9
X-MS-TrafficTypeDiagnostic: BYAPR15MB2822:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB28227808BC07031C8F407DF5D5770@BYAPR15MB2822.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CI7/dWBzaKd8l5RNvA5VLkTMP1ZKlD+vWThixbWLT07mp/CXzbPBFdmGmYQ1COTkKUBPAB+PEgk95/GZcmxRv11UzckYhoCoIo1uTs5XPIrYKRrHXsWutWtm3ioXiGL/lDs8NwyftNLPiiwaBFY5AWqU4nhNjnKNw23xi97PYVwX+OJm8j41eJynE0Daz+Tt/He5pTz0ce9amEW66wfQAjzrsVsVrQeBLPQNKImmZn9oYadbLD9y4RmJ3Nq04ubudDQzjzNcAoipIED+PladNW1Jdip8y+jLjLTC8nXRJPNIwhcN27OCpISXmoiE6tGDxmtPvGBQy10otM0HD8kIcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(136003)(396003)(366004)(376002)(83380400001)(478600001)(4326008)(8676002)(33716001)(316002)(5660300002)(9686003)(86362001)(66556008)(66476007)(66946007)(8936002)(2906002)(54906003)(55016002)(186003)(1076003)(16526019)(6496006)(52116002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: QaBk0ztvG4/iuhGnEsnERjlFhmpqDJltw5bnweDQoLTRPsfnpsff8SaaltxI51fzE/kx2+T6Ym5ZE4Jdk+iIimyTpGjGPeMrlZL1hxxeUDFhU3un0/mPopQsQeDhDHiRsdcXrEV76FDGv0Puwybs8LWZA/A70gsAgJx38XW8IjpNqXts8QYO3pu3lV2aw+X4boPvIWz9WevWP9CxMY2Y6GxB59jIHNv4GG3++7oixYk5en0LWPr6DEcZrCc1zHQc2Zn2UAEk5vvdClRyyHbEWUji6ZueWHABVVX3HvvNS+O8FKGwZD80y2V27MoYAzt1o8yELFLNbEjUwgTcYxPFuKQYTTNsyV/LMLh61x5JV3ZU44rQTG7ajS9a4e1hEwPtyASeBKIIR5EsBYErEemaMXyFx8/rkyd6erQyA+6KcKe1iaT/o3IShCay/kSfS0t9pgBfXc0KbRqQI7TaM584TA8STBfKUhwAHL2iCEOkXhk8JeY8DvBsos/tQKcKNtebt4j89yzb5dq6x5Hk60urkQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 12da3d1f-e86e-4144-2840-08d82f6554b9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 00:05:53.4856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfMfJG1Ox2ukX4Qasuxp/PQ0uRNwUnEneZW0nApi/bkac3s5hdQIejikftSaQ00T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2822
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_09:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230169
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 23, 2020 at 02:40:53AM -0500, YiFei Zhu wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> To access the storage in a CGROUP_STORAGE map, one uses
> bpf_get_local_storage helper, which is extremely fast due to its
> use of per-CPU variables. However, its whole code is built on
> the assumption that one map can only be used by one program at any
> time, and this prohibits any sharing of data between multiple
> programs using these maps, eliminating a lot of use cases, such
> as some per-cgroup configuration storage, written to by a
> setsockopt program and read by a cg_sock_addr program.
> 
> Why not use other map types? The great part of CGROUP_STORAGE map
> is that it is isolated by different cgroups its attached to. When
> one program uses bpf_get_local_storage, even on the same map, it
> gets different storages if it were run as a result of attaching
> to different cgroups. The kernel manages the storages, simplifying
> BPF program or userspace. In theory, one could probably use other
> maps like array or hash to do the same thing, but it would be a
> major overhead / complexity. Userspace needs to know when a cgroup
> is being freed in order to free up a space in the replacement map.
> 
> This patch set introduces a significant change to the semantics of
> CGROUP_STORAGE map type. Instead of each storage being tied to one
> single attachment, it is shared across different attachments to
> the same cgroup, and persists until either the map or the cgroup
> attached to is being freed.
> 
> User may use u64 as the key to the map, and the result would be
> that the attach type become ignored during key comparison, and
> programs of different attach types will share the same storage if
> the cgroups they are attached to are the same.
> 
> How could this break existing users?
> * Users that uses detach & reattach / program replacement as a
>   shortcut to zeroing the storage. Since we need sharing between
>   programs, we cannot zero the storage. Users that expect this
>   behavior should either attach a program with a new map, or
>   explicitly zero the map with a syscall.
> This case is dependent on undocumented implementation details, 
> so the impact should be very minimal.
> 
> Patch 1 introduces a test on the old expected behavior of the map
> type.
> 
> Patch 2 introduces a test showing how two programs cannot share
> one such map.
> 
> Patch 3 implements the change of semantics to the map.
> 
> Patch 4 amends the new test such that it yields the behavior we
> expect from the change.
> 
> Patch 5 documents the map type.
> 
> Changes since RFC:
> * Clarify commit message in patch 3 such that it says the lifetime
>   of the storage is ended at the freeing of the cgroup_bpf, rather
>   than the cgroup itself.
> * Restored an -ENOMEM check in __cgroup_bpf_attach.
> * Update selftests for recent change in network_helpers API.
> 
> Changes since v1:
> * s/CHECK_FAIL/CHECK/
> * s/bpf_prog_attach/bpf_program__attach_cgroup/
> * Moved test__start_subtest to test_cg_storage_multi.
> * Removed some redundant CHECK_FAIL where they are already CHECK-ed.
> 
> Changes since v2:
> * Lock cgroup_mutex during map_free.
> * Publish new storages only if attach is successful, by tracking
>   exactly which storages are reused in an array of bools.
> * Mention bpftool map dump showing a value of zero for attach_type
>   in patch 3 commit message.
> 
> Changes since v3:
> * Use a much simpler lookup and allocate-if-not-exist from the fact
>   that cgroup_mutex is locked during attach.
> * Removed an unnecessary spinlock hold.
> 
> Changes since v4:
> * Changed semantics so that if the key type is struct
>   bpf_cgroup_storage_key the map retains isolation between different
>   attach types. Sharing between different attach types only occur
>   when key type is u64.
> * Adapted tests and docs for the above change.
Thank for the v5.  Overall looks good. I left some nit comments
for the code changes.  The doc needs some more details.  With
that,

Acked-by: Martin KaFai Lau <kafai@fb.com>
