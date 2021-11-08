Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4908544786D
	for <lists+bpf@lfdr.de>; Mon,  8 Nov 2021 03:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbhKHCQF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 7 Nov 2021 21:16:05 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:27185 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbhKHCQF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Nov 2021 21:16:05 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HnZNx31zyz8vDs;
        Mon,  8 Nov 2021 10:11:45 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 8 Nov 2021 10:13:19 +0800
Received: from dggpeml500011.china.huawei.com (7.185.36.84) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 8 Nov 2021 10:13:19 +0800
Received: from dggpeml500011.china.huawei.com ([7.185.36.84]) by
 dggpeml500011.china.huawei.com ([7.185.36.84]) with mapi id 15.01.2308.015;
 Mon, 8 Nov 2021 10:13:19 +0800
From:   "zhudi (E)" <zhudi2@huawei.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "kafai@fb.com" <kafai@fb.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "yhs@fb.com" <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "jakub@cloudflare.com" <jakub@cloudflare.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: support BPF_PROG_QUERY for progs
 attached to sockmap
Thread-Topic: [PATCH bpf-next v5 1/2] bpf: support BPF_PROG_QUERY for progs
 attached to sockmap
Thread-Index: AdfUP22Rs+dr/NosTwybTqKx42X04A==
Date:   Mon, 8 Nov 2021 02:13:19 +0000
Message-ID: <97595753e3b445df82ce5e3d604207b2@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.136.114.155]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Thu, Nov 04, 2021 at 09:07:44AM +0800, Di Zhu wrote:
> > +int sock_map_bpf_prog_query(const union bpf_attr *attr,
> > +			    union bpf_attr __user *uattr)
> > +{
> > +	__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
> > +	u32 prog_cnt = 0, flags = 0, ufd = attr->target_fd;
> > +	struct bpf_prog **pprog;
> > +	struct bpf_prog *prog;
> > +	struct bpf_map *map;
> > +	struct fd f;
> > +	u32 id = 0;
> > +	int ret;
> > +
> > +	if (attr->query.query_flags)
> > +		return -EINVAL;
> > +
> > +	f = fdget(ufd);
> > +	map = __bpf_map_get(f);
> > +	if (IS_ERR(map))
> > +		return PTR_ERR(map);
> > +
> > +	rcu_read_lock();
> > +
> > +	ret = sock_map_prog_lookup(map, &pprog, attr->query.attach_type);
> > +	if (ret)
> > +		goto end;
> > +
> > +	prog = *pprog;
> > +	prog_cnt = (!prog) ? 0 : 1;
> > +
> > +	if (!attr->query.prog_cnt || !prog_ids || !prog_cnt)
> > +		goto end;
> 

> This sanity check (except prog_cnt) can be moved before RCU read lock?

I think we should call sock_map_prog_lookup() in any case. Because we can
just return query results(such as -EOPNOTSUPP) which may not care about
the prog_ids.

So this sanity check should right behind this call and must be in rcu critical zone.

> > +
> > +	id = prog->aux->id;
> > +	if (id == 0)
> > +		prog_cnt = 0;
> 
> The id seems generic, so why not handle it in bpf_prog_query() for all progs?

The prog id is a generic, but different progs have different organizational forms, 
so they can only be handled differently at present...

> > +
> > +end:
> > +	rcu_read_unlock();
> > +
> > +	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)) ||
> 
> 'flags' is always 0 here, right? So this is not needed as uattr has been already
> cleared in __sys_bpf().

 I recheck the code, it seems that __sys_bpf() does not do this clear things.

 
> Thanks.
