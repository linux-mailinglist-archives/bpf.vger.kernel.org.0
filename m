Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E91C48E3DB
	for <lists+bpf@lfdr.de>; Fri, 14 Jan 2022 06:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbiANFpB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 14 Jan 2022 00:45:01 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35838 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbiANFpB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Jan 2022 00:45:01 -0500
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JZqxG1QK2zccWc;
        Fri, 14 Jan 2022 13:44:18 +0800 (CST)
Received: from kwepeml500003.china.huawei.com (7.221.188.182) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 14 Jan 2022 13:44:58 +0800
Received: from dggpeml500011.china.huawei.com (7.185.36.84) by
 kwepeml500003.china.huawei.com (7.221.188.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 13:44:58 +0800
Received: from dggpeml500011.china.huawei.com ([7.185.36.84]) by
 dggpeml500011.china.huawei.com ([7.185.36.84]) with mapi id 15.01.2308.020;
 Fri, 14 Jan 2022 13:44:58 +0800
From:   "zhudi (E)" <zhudi2@huawei.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>
CC:     "ast@kernel.org" <ast@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "kafai@fb.com" <kafai@fb.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "yhs@fb.com" <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luzhihao (luzhihao, Euler)" <luzhihao@huawei.com>,
        "Chenxiang (EulerOS)" <rose.chen@huawei.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: support BPF_PROG_QUERY for progs
 attached to sockmap
Thread-Topic: [PATCH bpf-next v5 1/2] bpf: support BPF_PROG_QUERY for progs
 attached to sockmap
Thread-Index: AdgJAVS91cwWMrx3QDm+6rM/XIXS/w==
Date:   Fri, 14 Jan 2022 05:44:57 +0000
Message-ID: <3abe6e9f2e1a408f887b1dd31862f7b1@huawei.com>
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

> On Thu, Jan 13, 2022 at 10:00 AM CET, Di Zhu wrote:
> > Right now there is no way to query whether BPF programs are
> > attached to a sockmap or not.
> >
> > we can use the standard interface in libbpf to query, such as:
> > bpf_prog_query(mapFd, BPF_SK_SKB_STREAM_PARSER, 0, NULL, ...);
> > the mapFd is the fd of sockmap.
> >
> > Signed-off-by: Di Zhu <zhudi2@huawei.com>
> > Acked-by: Yonghong Song <yhs@fb.com>
> > ---
> >  include/linux/bpf.h  |  9 +++++
> >  kernel/bpf/syscall.c |  5 +++
> >  net/core/sock_map.c  | 78
> ++++++++++++++++++++++++++++++++++++++++----
> >  3 files changed, 85 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 6e947cd91152..c4ca14c9f838 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2071,6 +2071,9 @@ int bpf_prog_test_run_syscall(struct bpf_prog
> *prog,
> >  int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog
> *prog);
> >  int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type
> ptype);
> >  int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value,
> u64 flags);


	.......


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
> > +	prog_cnt = !prog ? 0 : 1;
> > +
> > +	if (!attr->query.prog_cnt || !prog_ids || !prog_cnt)
> > +		goto end;
> > +
> > +	id = prog->aux->id;
> 
> ^ This looks like a concurrent read/write.
> 
> Would wrap with READ_ONCE() and corresponding WRITE_ONCE() in
> bpf_prog_free_id(). See [1] for rationale.
> 
> [1]
> https://github.com/google/kernel-sanitizers/blob/master/other/READ_WRITE_O
> NCE.md


Thanks for your advice, I will modify this code.

 
> > +
> > +	/* we do not hold the refcnt, the bpf prog may be released
> > +	 * asynchronously and the id would be set to 0.
> > +	 */
> > +	if (id == 0)
> > +		prog_cnt = 0;
> > +
> > +end:
> > +	rcu_read_unlock();
> > +
> > +	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)) ||
> > +	    (id != 0 && copy_to_user(prog_ids, &id, sizeof(u32))) ||
> > +	    copy_to_user(&uattr->query.prog_cnt, &prog_cnt, sizeof(prog_cnt)))
> > +		ret = -EFAULT;
> > +
> > +	fdput(f);
> > +	return ret;
> > +}
> > +
> >  static void sock_map_unlink(struct sock *sk, struct sk_psock_link *link)
> >  {
> >  	switch (link->map->map_type) {
