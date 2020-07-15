Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0489E221840
	for <lists+bpf@lfdr.de>; Thu, 16 Jul 2020 01:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgGOXKg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jul 2020 19:10:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26350 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726776AbgGOXKf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Jul 2020 19:10:35 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FNAFU1011815;
        Wed, 15 Jul 2020 16:10:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=4vViccH5d7beNVlkeJg58cnQVEC2Hx4zxbhpim5jDHo=;
 b=fCf94psOk0Ct8F84sBbsM7TGw9oAy7Q6gSn8P/9iIzCkjpjHrL5PwjJ3ZCv3iX/TZdHd
 ER68NTfzR+MxzuWCbfl54HVIlKzIvBWaa734k9FNg2+WP3ImhWd+I+10DtC8M+hkc9gK
 /OUnUhinimi3mNZAXq83/JiopFi6IjXATfQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32a7fps2kv-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Jul 2020 16:10:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 15 Jul 2020 16:09:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5xQwNc7LI6/MNU8vnHDlFrsga/SKseOAqqNKzBFUfWp5PW+O6nE7CoUmgHQexWPUudJv5L+/E7ScGf91PN0A6+mduwwLJAkDqDc6RFWwfnbJzv0dowuCbMqwKYNL3fPhvHef45BMnS9UxSgOYI3XvRu/YJzUZ/X+xuDXxolZSHqrNJfnWKr+Y5UrQVf4O4DsSI+P00EyRAb5lRaRSRhpfoA+Wwoc1nwn4ulpKR1IBWGdOS2pW8CcrCLxTh+RHByyj0OlLIWdWZCyP/lcAlfW8shfVVtAxwfZvgedgArwU0UpwaUdN6UXBG6WTiAQdiH5emxeMgMviCYeEHvfkzPrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vViccH5d7beNVlkeJg58cnQVEC2Hx4zxbhpim5jDHo=;
 b=EiCzx+KU2mMVqGb4ANcCm7oQDQVKK8C990WVptcY9iyWtKBrweRcM0ExDkIe5WmMbhWzGOZKlk0CgWOtMzF26rtmjWsUqeQTZhhRerqbKu5zCEQQGZMriWCeqWdGSOXYDCN/oI2lNFONBiK1rKodhIkYRJd+Xi3miXUPPzkQi+S4cSP/IIBbjsvf7WEOiiqwBSRQldSuEeK0G5e+77pkNJhGuIKKstzdkn5J5iSLWlKobt+iE+3i7Pi+7iCKXKj0Fx1egSuCQ2Yc3zWoZ+JsJ2ZXx5RD0uUan9c+YzdyUNPyOlefa4Fq4xS0YCaHcAu+DfGLpRbDntEoBjmwK+bN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vViccH5d7beNVlkeJg58cnQVEC2Hx4zxbhpim5jDHo=;
 b=JNSpWT5+mAZcLPuo2Lqwq5nFTQNpJbK87r542QOy6VsU1jlzirDjXUh2EQTQIHTEiET01c1OLs1SIUjU1dtexP6jomFzrJ3bqkaM80qMjZYYrMcCEd3hobKTvnU+A3uBO0IPWjVwgoVSRHUxeIjC70q2ge4+5a/cX3ccLUKKVgU=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2823.namprd15.prod.outlook.com (2603:10b6:a03:15a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Wed, 15 Jul
 2020 23:09:51 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3174.026; Wed, 15 Jul 2020
 23:09:51 +0000
Date:   Wed, 15 Jul 2020 16:09:49 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     YiFei Zhu <zhuyifei@google.com>
CC:     YiFei Zhu <zhuyifei1999@gmail.com>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/5] bpf: Make cgroup storages shared across
 attaches on the same cgroup
Message-ID: <20200715230949.md3hd3hy5hhawnji@kafai-mbp>
References: <cover.1594333800.git.zhuyifei@google.com>
 <6c368691a54345cfeba099b42e69c84814afdae1.1594333800.git.zhuyifei@google.com>
 <20200714235344.jl7cqxxvy5knxbnu@kafai-mbp>
 <CAA-VZPn0QB2_Wg3szW75hMvUnc2ZUHGzgb2csRKszcLT62siJg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA-VZPn0QB2_Wg3szW75hMvUnc2ZUHGzgb2csRKszcLT62siJg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::20) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:5ec) by BYAPR07CA0007.namprd07.prod.outlook.com (2603:10b6:a02:bc::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Wed, 15 Jul 2020 23:09:50 +0000
X-Originating-IP: [2620:10d:c090:400::5:5ec]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a24d6af-6c40-432a-4688-08d829142d23
X-MS-TrafficTypeDiagnostic: BYAPR15MB2823:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB282329CBE818097879A4D30DD57E0@BYAPR15MB2823.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8aWKLtuWE9ad8XDM+zA9JqTPDaGG9s4FqsfxKDIfU5iB7HahHegvPe2cI8HNfmYih6NIu6f7mVBgrFFxvcWZMHVsiKTPRf21XMRwh4nM6TYXH81wLWpM3OQz6Uv19gA2cbh1kuvEVQbFtM1vQlwjgZtubM0eS/kCmNom6LfpDk3XuX6n909EgE12MznmXZSJHAVuXs2WzFZnG2i7noLB7jQlNfvrXMvgJMh8aLzPvsaYuM7cFvB2scbRvHy3Df3Yn12wZNPPF93RB8xao/YI6Ue3CBuCNfYXtWntPj4vw5Jb/bajvPi9DZee7BPt2R182Dnd8e3SMEk1g72LK3BYxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(396003)(376002)(366004)(39860400002)(6916009)(5660300002)(83380400001)(66946007)(33716001)(16526019)(186003)(66476007)(8676002)(66556008)(8936002)(1076003)(2906002)(316002)(55016002)(478600001)(52116002)(9686003)(86362001)(54906003)(6496006)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: cBJN93CQpUMrhTgnTedrGrIKLX9cKc+TP6jdCusS3L40H3GBo9MmXsI1ztkDD+bEQwbC6CHXDoeVAxEvMA2b/hCXJlrT/tUh9nnVc7XX3LpyLKQs/Vxk+AogIcgWejMPJ6ME8BQr2sm4G+aleexUKL3dlfGgddcl4pE1io+xcPCmgRwo9+pcLLhdczR+XKkicLpuIsqIL7HRYw4Atupv0StDVldWiHudTgYi/5GTs+ptl5715zs9dfJ+fHGdjtsZUp4lNG50O/2hdToh7RKTQum/xTBGm0pdY1FWTdJdtRNltaeNngabndB4yUcVGtZMvBzxmRKSvwH7OlD4w5FFTZ3ZBfrUqQNAC/epCXFhHlb9yuCD6dB2uYZJn4ahQum3QOgTMrnYiDbPh5AmLtBFiKqt84/rvRC+3yEU//Cy+nBRMWCRtOi3mOJWWZrHz298STXGrv92K8wOISbINbKKdGX6V8KNlMonKBKzR+nrYjCFPBW1XOxPrjy/TwTRsayADmDU1J7HKI5TQNxSkN7VKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a24d6af-6c40-432a-4688-08d829142d23
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 23:09:50.8984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+NjGy1m/olo9QhTq3Y47kFd52HIaLxjjaVFLBtqVNcrFaf0MHBQLXA81DUGg1BM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2823
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=2 clxscore=1015 priorityscore=1501
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150172
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 15, 2020 at 04:06:45PM -0500, YiFei Zhu wrote:
> > > +     list_for_each_entry_safe(storage, stmp, storages, list_cg) {
> > > +             bpf_cgroup_storage_unlink(storage);
> > > +             bpf_cgroup_storage_free(storage);
> > cgroup_storage_map_free() is also doing unlink and free.
> > It is not clear to me what prevent cgroup_bpf_release()
> > and cgroup_storage_map_free() from doing unlink and free at the same time.
> >
> > A few words comment here would be useful if it is fine.
> 
> Good catch. This can happen. Considering that this section is guarded
> by cgroup_mutex, and that cgroup_storage_map_free is called in
> sleepable context (either workqueue or map_create) I think the most
> straightforward way is to also hold the cgroup_mutex in
> cgroup_storage_map_free. Will fix in v3.
> 
> > > @@ -458,10 +457,10 @@ int __cgroup_bpf_attach(struct cgroup *cgrp,
> > >       if (bpf_cgroup_storages_alloc(storage, prog ? : link->link.prog))
> > >               return -ENOMEM;
> > >
> > > +     bpf_cgroup_storages_link(storage, cgrp);
> > here. After the new change in bpf_cgroup_storage_link(),
> > the storage could be an old/existing storage that is
> > being used by other bpf progs.
> 
> Right, I will swap storages_alloc to below this kmalloc and goto
> cleanup if storages_alloc fails.
> 
> > > -     bpf_cgroup_storages_free(old_storage);
> > >       if (old_prog)
> > >               bpf_prog_put(old_prog);
> > >       else
> > >               static_branch_inc(&cgroup_bpf_enabled_key);
> > > -     bpf_cgroup_storages_link(pl->storage, cgrp, type);
> > Another side effect is, the "new" storage is still published to
> > the map even the attach has failed.  I think this may be ok.
> 
> Correct. To really fix this we would need to keep track of exactly
> which storages are new and which are old, and I don't think that doing
> so has any significant benefits given that the lifetime of the
> storages are still bounded. If userspace receives the error they are
> probably going to either exit or retry. Exit will cause the storages
> to be freed along with the map, and retry, if successful, needs the
> storage be published anyways. That is the reasoning for thinking it is
> okay.
It should not be hard.  Stay with the existing approach.

lookup old, found=>reuse, not-found=>alloc.

Only publish the new storage after the attach has succeeded.

> 
> 
> > > -     next->attach_type = storage->key.attach_type;
> > The map dump (e.g. bpftool map dump) will also show attach_type zero
> > in the key now.  Please also mention that in the commit message.
> 
> Will fix in v3.
> 
> > This patch allows a cgroup-storage to be shared among different bpf-progs
> > which is in the right direction that makes bpf_cgroup_storage_map behaves
> > more like other bpf-maps do.  However, each bpf-prog can still only allow
> > one "bpf_cgroup_storage_map" to be used (excluding the difference in the
> > SHARED/PERCPU bpf_cgroup_storage_type).
> > i.e. each bpf-prog can only access one type of cgroup-storage.
> > e.g. prog-A stores storage-A.  If prog-B wants to store storage-B and
> > also read storage-A, it is not possible if I read it correctly.
> 
> You are correct. It is still bound by the per-cpu variable, and
> because the per-cpu variable is an array of storages, one for each
> type, it still does not support more than one storage per type.
> 
> > While I think this patch is a fine extension to the existing
> > bpf_cgroup_storage_map and a good step forward to make bpf_cgroup_storage_map
> > sharable like other bpf maps do.  Have you looked at bpf_sk_storage.c which
> > also defines a local storage for a sk but a bpf prog can define multiple
> > storages to be stored in a sk.  It is doing similar thing of this
> > patch (e.g. a link to the storage, another link to the map, the life
> > time of the storage is tied to the map and the sk...etc.).  KP Singh is
> > generalizing it such that bpf-prog can store data in potentially any
> > kernel object other than sk [1].  His use case is to store data in inode.
> > I think it can be used for the cgroup also.  The only thing missing there
> > is the "PERCPU" type.  It was not there because there is no such need for sk
> > but should be something quite doable.
> 
> I think this is a good idea, but it will be a much bigger project. I
> would prefer to fix this problem of cgroup_storage not being shareable
> first, and when KP's patches land I'll take a look at how to reuse
> their code. And, as you said, it would be more involved due to needing
> to add "PERCPU" support.
I am not against this patch considering it is a feature extension to the
existing bpf_cgroup_storage_map.  The bpf_local_storge is in-progress, so
the timing may not align also.

However, it is not very complicated to create storage for another kernel
object either.  You should take a look at KP Singh's bpf_inode_storage.c
which is pretty straight forward to create storage for inode.  The
locking/racing issues discussed in this thread have already
been considered in the bpf_(sk|local)_storage.

Also, if the generalized bpf_local_storage is used, using a completely
separate new map will be cleaner (i.e. completely separate from
bpf_cgroup_storage_map and not much of it will be reused).
e.g. Unlike bpf_cgroup_storage_map,  there is no need to create
storage at the attach time.  The storage will be created at
runtime when the very first bpf-prog accessing it.  
