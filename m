Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCEB20FCCE
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 21:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgF3TfG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 15:35:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:61858 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727883AbgF3TfF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Jun 2020 15:35:05 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05UJUT4F028402;
        Tue, 30 Jun 2020 12:34:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=KamV2sw+Um0SxNVy6baSzu8Y6jBGcJw33Qc9IZW6LZE=;
 b=SgizJEDYR/gTKj2lDEcQOQjJenTirtpVl5EMeG7qjYbNWIMFvk4aAqQPEtSQid0ua2oh
 kj0k/7pGtnms0n+UlQxoDSb4zW/o2AJf/Cnr/32XIjShW8TMwP1SpLXmkVSu4CCd1Bma
 NvRZOhlOHjKUUAsdgxIh/rfgDJ/Ema/A9bw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 320bcdr2uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Jun 2020 12:34:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 30 Jun 2020 12:34:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpbfJjJpIxq8W0fMP6Lo+tZNOFHdYyxqo7C1Q3eqSlZP2nlZ5hBX/PfYVngUnFxR6xOa+C10BK6DnUh+/vKW1QU5t4VyiRQyxV3amy3XHUbEdAd0hJPOI5QNGS47L6ibv8jGUr36aWBAPbvN5RCTOO/4LaIQz1zFmbNhe3SPMN+AhC5HP23R44alo4emO2nL/jQdDQQSxgnB2ZWImqiZdAWX1buPCu3eJwM0mKz4ljqcnPv5FuJo65q2jUE1O7BJLKGJaZHeJqhgyO2OnR9sfsSaYGbuoWx0Y6tCX2FdLcmXtOjkn4zyrr5b53EWCR27lyVmFuVgHTdnBsvYvBABVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KamV2sw+Um0SxNVy6baSzu8Y6jBGcJw33Qc9IZW6LZE=;
 b=PZr1zT5JY8dCg8n2U7hY5bzX7Wou4LNxzF4eUzgf0XNxRabvoyY/kYUDYghgRbCa0QCkmtwXpO+En+GxsaL/xDLNF/rl7OnwnpmiBx30aLsCwNEBXciM/RWfyAleQge9NuMsyW58a7tKgdl7i5sAPY8Jyc52JpqX+TaWG2IuS6wj0rXgErqH0+FMex+zm/cWxUnkd4zy0FLSmbh23CHhr/xumwfpPJGbumWLcY+qlH2uVl9JIAyAdUybjwlNgrOqUj3VItUcl2bxtir3fE1XoEyaUHk5d89dyErzdZorltRW6zzwWPAucqyb0YEO8uGzKYKbzg2rgCwRtKX2XQe4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KamV2sw+Um0SxNVy6baSzu8Y6jBGcJw33Qc9IZW6LZE=;
 b=Qs80NpcUOMfbtP4vXxlEiz8rIJF0N4iVMFr6vecf9d2xjBebzi7IcD2clXX6Zbuy9+JzcYO8c8eDRykPdOsFLRPfM/5gdbaoprppk656krsnZ1q1WZ0qIxHc8K0zPsV1V1Xp/mhLmo5p6p5hnhiWR5MhuxU4j4qHC7OfVzRaRwA=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from CH2PR15MB3573.namprd15.prod.outlook.com (2603:10b6:610:e::28)
 by CH2PR15MB3589.namprd15.prod.outlook.com (2603:10b6:610:4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 19:34:44 +0000
Received: from CH2PR15MB3573.namprd15.prod.outlook.com
 ([fe80::b0ab:989:1165:107]) by CH2PR15MB3573.namprd15.prod.outlook.com
 ([fe80::b0ab:989:1165:107%5]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 19:34:44 +0000
Date:   Tue, 30 Jun 2020 12:34:41 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Generalize bpf_sk_storage
Message-ID: <20200630193441.kdwnkestulg5erii@kafai-mbp.dhcp.thefacebook.com>
References: <20200617202941.3034-1-kpsingh@chromium.org>
 <20200617202941.3034-2-kpsingh@chromium.org>
 <20200619064332.fycpxuegmmkbfe54@kafai-mbp.dhcp.thefacebook.com>
 <20200629160100.GA171259@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629160100.GA171259@google.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR06CA0038.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::15) To CH2PR15MB3573.namprd15.prod.outlook.com
 (2603:10b6:610:e::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:31b2) by BYAPR06CA0038.namprd06.prod.outlook.com (2603:10b6:a03:14b::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend Transport; Tue, 30 Jun 2020 19:34:43 +0000
X-Originating-IP: [2620:10d:c090:400::5:31b2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f81a8da-716b-4ac0-acf1-08d81d2ca3f7
X-MS-TrafficTypeDiagnostic: CH2PR15MB3589:
X-Microsoft-Antispam-PRVS: <CH2PR15MB358998DFBE0DE4B5B0FE2AF7D56F0@CH2PR15MB3589.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rvxpdxgMxziE6gP2tfVlGi/fH93+dxjLtUqM6bReJcBXYOY80DwSSIzQMh6dHgLFRPipZgKJ7VsAWNGZAi3m2OYi7HwqrA2AJNIUzAUw66mAafJ93TSPK27mbP8S3D4sl6hPmqOQPT1kr7tzo2ykjImb8H0UWwZzU5q9qNaaTxLQVcwdBH4LwdzdEwndFvnpYL+nGnGFDrrAyQZxJFL3SnSYYpCTfJQlN2MXfZ6AKmUyskx5EJJJ0iFp83mmv6rob7vGEowNOMiyhaNMHTt9aNi/lWazqbjf5FZwbq8lcgAwRin9wXnIUk69jeYoFi9k/P5w231MegzR1fCoud4xcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR15MB3573.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(376002)(39860400002)(396003)(346002)(16526019)(1076003)(478600001)(55016002)(9686003)(86362001)(186003)(8936002)(8676002)(6506007)(7696005)(2906002)(52116002)(4326008)(66946007)(66556008)(54906003)(6916009)(5660300002)(66476007)(83380400001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: JjUJRbjcuBLc0Y2EsZyoCWLOF/oIxvfaNZbqQYkfS5MJKmZHZ4jir/R8uF0ptsi+NDO0SeFbio9OPjQHmTGQUitrnDSqZr9BpLEuBM0PKr2ju3rja7ODWsL/awtXIT8mUsKKc8dv3/sblZH6zn9hJtISE3N6P/vc5GIepPy0TkB8hmBkHHRBi+wCjOo/EuMHN9kdp3lCOv/iV++doqP0MbuCD9XNBhO4l6nk1d4pS/yHExv/1ZF6HDWCB2k6A1hxRYZJC0Ni53vucAA5mA0c7J9igqJO5dKisanIujrZVa4uzHQpYgb5Dj+we0Uuh5dDKdSP2RBIbTWN0LOlZJu5fTtX/SrfgN5Sz94yUakD0kmddO7YsvSIU10vA//KxzrMN1zZsx9/SeqKz3jdiMJmF6hJYvC4HGsKr+hXPDVWFKCht1PPl4akBmFhEL7d6+syi23KKlC+esyWczvRE5+GA5mioZHgEjPDS9j/CXU+QgdsTLsh04DnxQm0t3oEkhXnj4HwaumhkiW+4gPYwzro3g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f81a8da-716b-4ac0-acf1-08d81d2ca3f7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR15MB3573.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 19:34:44.2887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXYXcRrrvTojfX0bKh80f+eLux+5+yFt8kczna+6rpMJwwU8hBvpVsg81XlL5/kc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3589
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_06:2020-06-30,2020-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 cotscore=-2147483648 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300132
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 29, 2020 at 06:01:00PM +0200, KP Singh wrote:
> Thanks for your feedback! Apologies it took some time for me
> to incorporate this into another revision.
> 
> On 18-Jun 23:43, Martin KaFai Lau wrote:
> > On Wed, Jun 17, 2020 at 10:29:38PM +0200, KP Singh wrote:
> > > From: KP Singh <kpsingh@google.com>
> > > 
> > > Refactor the functionality in bpf_sk_storage.c so that concept of
> > > storage linked to kernel objects can be extended to other objects like
> > > inode, task_struct etc.
> > > 
> > > bpf_sk_storage is updated to be bpf_local_storage with a union that
> > > contains a pointer to the owner object. The type of the
> > > bpf_local_storage can be determined using the newly added
> > > bpf_local_storage_type enum.
> > > 
> > > Each new local storage will still be a separate map and provide its own
> > > set of helpers. This allows for future object specific extensions and
> > > still share a lot of the underlying implementation.
> > Thanks for taking up this effort to refactor sk_local_storage.
> > 
> > I took a quick look.  I have some comments and would like to explore
> > some thoughts.
> > 
> > > --- a/net/core/bpf_sk_storage.c
> > > +++ b/kernel/bpf/bpf_local_storage.c
> > > @@ -1,19 +1,22 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  /* Copyright (c) 2019 Facebook  */
> > > +#include "linux/bpf.h"
> > > +#include "asm-generic/bug.h"
> > > +#include "linux/err.h"
> > "<" ">"
> > 
> > >  #include <linux/rculist.h>
> > >  #include <linux/list.h>
> > >  #include <linux/hash.h>
> > >  #include <linux/types.h>
> > >  #include <linux/spinlock.h>
> > >  #include <linux/bpf.h>
> > > -#include <net/bpf_sk_storage.h>
> > > +#include <linux/bpf_local_storage.h>
> > >  #include <net/sock.h>
> > >  #include <uapi/linux/sock_diag.h>
> > >  #include <uapi/linux/btf.h>
> > >  
> > >  static atomic_t cache_idx;
> > inode local storage and sk local storage probably need a separate
> > cache_idx.  An improvement on picking cache_idx has just been
> > landed also.
> 
> I see, thanks! I rebased and I now see that cache_idx is now a:
> 
>   static u64 cache_idx_usage_counts[BPF_STORAGE_CACHE_SIZE];
> 
> which tracks the free cache slots rather than using a single atomic
> cache_idx. I guess all types of local storage can share this now
> right?
I believe they have to be separated.  A sk-storage will not be cached/stored
in inode.  Caching a sk-storage at idx=0 of a sk should not stop
an inode-storage to be cached at the same idx of a inode.

> 
> > 
> > [ ... ]
> > 
> > > +struct bpf_local_storage {
> > > +	struct bpf_local_storage_data __rcu *cache[BPF_STORAGE_CACHE_SIZE];
> > >  	return NULL;
> 
> [...]
> 
> > >  }
> > >  
> > > -/* sk_storage->lock must be held and selem->sk_storage == sk_storage.
> > > +static void __unlink_local_storage(struct bpf_local_storage *local_storage,
> > > +				   bool uncharge_omem)
> > Nit. indent is off.  There are a few more cases like this.
> 
> Thanks, will fix this. (note to self: don't trust the editor's
> clang-format blindly).
> 
> > 
> > > +{
> > > +	struct sock *sk;
> > > +
> > > +	switch (local_storage->stype) {
> > Does it need a new bpf_local_storage_type?  Is map_type as good?
> > 
> > Instead of adding any new member (e.g. stype) to
> > "struct bpf_local_storage",  can the smap pointer be directly used
> > here instead?
> > 
> > For example in __unlink_local_storage() here, it should
> > have a hold to the selem which then has a hold to smap.
> 
> Good point, Updated to using the map->map_type.
> 
> > 
> > > +	case BPF_LOCAL_STORAGE_SK:
> > > +		sk = local_storage->sk;
> > > +		if (uncharge_omem)
> > > +			atomic_sub(sizeof(struct bpf_local_storage),
> > > +				   &sk->sk_omem_alloc);
> > > +
> > > +		/* After this RCU_INIT, sk may be freed and cannot be used */
> > > +		RCU_INIT_POINTER(sk->sk_bpf_storage, NULL);
> > > +		local_storage->sk = NULL;
> > > +		break;
> > > +	}
> > Another thought on the stype switch cases.
> > 
> > Instead of having multiple switches on stype in bpf_local_storage.c which may
> > not be scalable soon if we are planning to support a few more kernel objects,
> > have you considered putting them into its own "ops".  May be a few new
> > ops can be added to bpf_map_ops to do local storage unlink/update/alloc...etc.
> 
> Good idea, I was able to refactor this with the following ops:
> 
>         /* Functions called by bpf_local_storage maps */
> 	void (*map_local_storage_unlink)(struct bpf_local_storage *local_storage,
>                                          bool uncharge_omem);
> 	struct bpf_local_storage_elem *(*map_selem_alloc)(
> 		struct bpf_local_storage_map *smap, void *owner, void *value,
> 		bool charge_omem);
> 	struct bpf_local_storage_data *(*map_local_storage_update)(
> 		void  *owner, struct bpf_map *map, void *value, u64 flags);
> 	int (*map_local_storage_alloc)(void *owner,
> 				       struct bpf_local_storage_map *smap,
> 				       struct bpf_local_storage_elem *elem);
> 
> Let me know if you have any particular thoughts/suggestions about
> this.
Make sense to me.

It seems the fast-path's lookup can all be done within __local_storage_lookup().
No indirect call is needed, so should be good.

> 
> > 
> > > +}
> > > +
> > > +/* local_storage->lock must be held and selem->local_storage == local_storage.
> > >   * The caller must ensure selem->smap is still valid to be
> > >   * dereferenced for its smap->elem_size and smap->cache_idx.
> > > + *
> > > + * uncharge_omem is only relevant when:
> 
> [...]
> 
> > > +	/* bpf_local_storage_map is currently limited to CAP_SYS_ADMIN as
> > >  	 * the map_alloc_check() side also does.
> > >  	 */
> > >  	if (!bpf_capable())
> > > @@ -1025,10 +1127,10 @@ bpf_sk_storage_diag_alloc(const struct nlattr *nla_stgs)
> > >  }
> > >  EXPORT_SYMBOL_GPL(bpf_sk_storage_diag_alloc);
> > Would it be cleaner to leave bpf_sk specific function, map_ops, and func_proto
> > in net/core/bpf_sk_storage.c?
> 
> Sure, I can also keep the sk_clone code their as well for now.
Just came to my mind.  For easier review purpose, may be
first do the refactoring/renaming within bpf_sk_storage.c first and
then create another patch to move the common parts to a new
file bpf_local_storage.c.

Not sure if it will be indeed easier to read the diff in practice.
I probably should be able to follow it either way.

> 
> > 
> > There is a test in map_tests/sk_storage_map.c, in case you may not notice.
> 
> I will try to make it generic as a part of this series. If it takes
> too much time, I will send a separate patch for testing
> inode_storage_map and till then we have some assurance with
> test_local_storage in test_progs.
Sure. no problem.  It is mostly for you to test sk_storage to ensure things ;)
Also give some ideas on what racing conditions have
been considered in the sk_storage test and may be the inode storage
test want to stress similar code path.
