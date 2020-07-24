Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DA622BD97
	for <lists+bpf@lfdr.de>; Fri, 24 Jul 2020 07:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgGXFkP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jul 2020 01:40:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24468 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726277AbgGXFkP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Jul 2020 01:40:15 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06O5akrg029197;
        Thu, 23 Jul 2020 22:39:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Kx/y8/oWSr5ZgG8WSB8cLSAgsvQyzSBNSo9LfGROuy4=;
 b=LQ4HmcRbM5E5fDASKiWzhIWbmFpK4w7L5+su46el39HCKrAEC+pKI8Eski6BOM23KNAF
 SubTOKYsBUwzXoktMTJqpRQANn/dNKNUmhvLm0lOl5eyPS220c6D1ZV6Ij4ugdIOzEp9
 DImOpoQ0M8mHEBe9UgyvVryeGiKtBPmG1Bc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32etmwg1k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jul 2020 22:39:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 22:39:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNZA6/blHUjAyzdlTY5SpmRNG+U7uTtYJj3qrG2sbNyuCw3e/WEM9gidJYbSB8pfcJ5eLKWESxOxo3NYy08rJT6Ynvu9r/dTIuzaTujqAnMx4inPD39jDb1dxBOmYPdFAOnQTefaVILtyvXceeZjWyk/d5gxJ+zdzdi/H6+L3HOb8OOP7tdBhOlmJITKdIv8DsjElWK6mLVEoy/Cwi3BO2wNq9RAlQA8AWkyrTAgzvj7N/vUGVtfxuaPrQeFQntme7+XEsmR9IDmB0oamgPBlFejbcI8g6soGAD8r9IKa1VlLH3zlfCLB8Y5c1QYmY2g4Q1OVDM2k8MHIymHO9kTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx/y8/oWSr5ZgG8WSB8cLSAgsvQyzSBNSo9LfGROuy4=;
 b=Ix+BTbeFyRWXvKBt/3QdkRsSePMNdj2qoE19GAvY1EwTolZ13F/aE51wkaFvyv1WrGX0kn4nkVEw6fChl38GsuFz3loUQMgy75J1Ze5agc4OaIW/dY4s+8QuUmvsz+0vBAbPFXaL91vuAmYYyv7LTQ+qlVZDGOO5N5jQ51NojTNR/0PplQi/DqvBXMKyzIBllFM2GJBMct3Ju474cfAov2XU1rFp9IHe0SzXM5tfVKFL3qmq+pXphBbmytUuhW3BI8Ov3at6/9CTv+KApYolCm3gdltUTnUETCRShZzq19FbYbKusnkiJ6A7mMBysz9va5QE+q2ZKXA+/cRedNnGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx/y8/oWSr5ZgG8WSB8cLSAgsvQyzSBNSo9LfGROuy4=;
 b=IOfF9B7CZGv6v9jNhj7aMyAlKAENEvlIiVufsZfFMm4HW0eQBTMYMaaMKxSTNoY1ICq19toYHgUipvl7cIJ0Quh8uxWmp3MdznXf9VALQcYZaRn24IjMXvrwdc17iqHy5w1OD0wVLPYImwj0klLc0Y53LseSECEsH7oR+rU2708=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2199.namprd15.prod.outlook.com (2603:10b6:a02:83::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 05:39:56 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 05:39:56 +0000
Date:   Thu, 23 Jul 2020 22:39:54 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v6 bpf-next 0/5] Make BPF CGROUP_STORAGE map usable by
 different programs at once
Message-ID: <20200724053954.kck6gkrwrmeiactu@kafai-mbp>
References: <cover.1595565795.git.zhuyifei@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1595565795.git.zhuyifei@google.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR11CA0090.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::31) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:e4fd) by BYAPR11CA0090.namprd11.prod.outlook.com (2603:10b6:a03:f4::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 05:39:55 +0000
X-Originating-IP: [2620:10d:c090:400::5:e4fd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72d09561-3d0d-4326-17c0-08d82f93ff09
X-MS-TrafficTypeDiagnostic: BYAPR15MB2199:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2199F04F0FDFB6376B1AD104D5770@BYAPR15MB2199.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fwtg50TFVr9bDfcKGu7e+tA1RuSQKZvtrdGJl5/H0ns1UbMBq/W3qAZq+Y4wk+L+wXuh8jfMsm/x78ENykSzDGZChLJXnO7Ok69N1sUlRHHv2RgYBiaq5wG+Hftv6b7Icy/rE8GcOqaKm7wdlTTJsXGaDhSnDZdJX29wfdGsttapuuP8DvofUiDE2wWbW4skBdxJR0cMMZholrLJb0cHnfbEjn1ZCLO23iuwdhURlQElJRzsL97OlZiREsY2xFkVxSStePNMPy7IXAjSYTyoSo5mzdooLtarAnKDvirVaxRrEdbzRSaFl4xDyt9vRVnMebcrUvN2XqMetRK07VdQYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(376002)(39860400002)(136003)(366004)(6916009)(54906003)(316002)(83380400001)(33716001)(1076003)(66556008)(2906002)(8676002)(4326008)(6496006)(16526019)(5660300002)(86362001)(8936002)(478600001)(186003)(55016002)(9686003)(66946007)(66476007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: XtwkJCU0dFIhqRqmdGk06qlgy/rrH2hvpCjiun+IYFD+COogmf7KfvSKUTIHxK9IdtsN5sJKKICcPgdp1xKLfxwxgeel+AM1KwAOY/ekXa9QW35VTXBL/r74H8oNSEL7oKRhF//f+K4Xu+WvKJ8yZkQCvvJiUGbULGVVsEWPorhcQCsvxDbBEnNWdFIewqk5FUCw1bnSRDcpqmTGka61bLVR+mv1GtiH/4TAzurAFohUJQqTRu7I1mrMRs3ImHeb3nn9kQ5WPKyjJ6KHtObYTLs6vcRfEP9zAJp8rUmq8DlL3ijvU+z/OUItt1qcya6PyvHI23L4JQOoNKjoCx2ZXnUEDJk1bkk4Xyw6Qg397zpKWVPm8i2a7h1KbaMzLC73E2rySXaUTHWlBP+Rgpyd85DOmSH3OIKauPk7n5+UDaLqDcrj29sopI5AAhtNaZfoQSPpMcifre6nSmVlayQCPaF6vo9gF94fkEFsEVpYjJmkdfWgwVu42lVc9dWN5wFZnMvqh0VLDxqZVvhKfs81TA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d09561-3d0d-4326-17c0-08d82f93ff09
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 05:39:56.1027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cE5GZyh3de6cxMbcmTuWXl/mKfjwusJo9Dvq/TCUlT1LT5e8BYj64esH50BipYDM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2199
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_01:2020-07-24,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=2 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007240042
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 23, 2020 at 11:47:40PM -0500, YiFei Zhu wrote:
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
> 
> Changes since v5:
> * Removed redundant NULL check before bpf_link__destroy.
> * Free BPF object explicitly, after asserting that object failed to
>   load, in the event that the object did not fail to load.
> * Rename variable in bpf_cgroup_storage_key_cmp for clarity.
> * Added a lot of information to Documentation, more or less copied
>   from what Martin KaFai Lau wrote.
> 
> YiFei Zhu (5):
>   selftests/bpf: Add test for CGROUP_STORAGE map on multiple attaches
>   selftests/bpf: Test CGROUP_STORAGE map can't be used by multiple progs
>   bpf: Make cgroup storages shared between programs on the same cgroup
>   selftests/bpf: Test CGROUP_STORAGE behavior on shared egress + ingress
>   Documentation/bpf: Document CGROUP_STORAGE map type
Acked-by: Martin KaFai Lau <kafai@fb.com>
