Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30EC654A6B
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 02:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbiLWBLj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 20:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbiLWBLQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 20:11:16 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7532A51A;
        Thu, 22 Dec 2022 17:10:00 -0800 (PST)
Received: from dggpeml500010.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NdTZz4Bc3zRq4g;
        Fri, 23 Dec 2022 09:08:43 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 23 Dec
 2022 09:09:56 +0800
From:   Xin Liu <liuxin350@huawei.com>
To:     <andrii.nakryiko@gmail.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <haoluo@google.com>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>,
        <kongweibin2@huawei.com>, <kpsingh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <liuxin350@huawei.com>,
        <martin.lau@linux.dev>, <sdf@google.com>, <song@kernel.org>,
        <wuchangye@huawei.com>, <xiesongyang@huawei.com>,
        <yanan@huawei.com>, <yhs@fb.com>, <zhangmingyi5@huawei.com>
Subject: Re: [PATCH] libbpf: fix crash when input null program point in USDT API
Date:   Fri, 23 Dec 2022 09:09:48 +0800
Message-ID: <20221223010948.9121-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CAEf4BzYFrXRp+b9j7vsqhVDpWSrA3mP73GLT3c7JMd6k3nKAPg@mail.gmail.com>
References: <CAEf4BzYFrXRp+b9j7vsqhVDpWSrA3mP73GLT3c7JMd6k3nKAPg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 20 Dec 2022 15:53:18 -0800 Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> On Mon, Dec 19, 2022 at 5:57 PM Xin Liu <liuxin350@huawei.com> wrote:
> >
> > On Tue, 20 Dec 2022 2:50:18 +0800 sdf<sdf@google.com> wrote:
> > > On 12/19, Xin Liu wrote:
> > > > The API functions bpf_program__attach_perf_event_opts and
> > > > bpf_program_attach_usdt can be invoked by users. However, when the
> > > > input prog parameter is null, the API uses name and obj without
> > > > check. This will cause program to crash directly.
> > >
> > > Why do we care about these only? We have a lot of functions invoked
> > > by the users which don't check the arguments. Can the caller ensure
> > > the prog is valid/consistent before calling these?
> > >
> >
> > Thanks to sdf for this suggestions.
> >
> > But I don't think it's a good idea to let the user guarantee:
> > 1.We can't require all users to verify parameters before transferring
> >   parameters. Some parameters may be omitted. If the user forgets to check
> >   the program pointer and it happens to be NULL, the program will crash
> >   without any last words, and the user can only use the debugging tool to
> >   collect relevant clues, which is a disaster for the user.
> > 2.Code changes are required for completed user programs and places where
> >   the API is invoked. For users, the cost of ensuring that each parameter
> >   check result is correct is high, which is much higher than that of
> >   directly verifying the parameter in libbpf.
> >
> > So I think we should do some validation at the API entrance, whick is a
> > big benefit at the minimum cost, and in fact we do that, for example,
> > OPTS_VALID validation, right?
> >
> 
> I agree with Stanislav. There is no reason for user to assume that
> passing NULL works as a general rule. We do not check for NULL
> everywhere. If user doesn't follow API contract, yes, they will get
> crashes or confusing behavior, unfortunately.
> 
> For APIs that explicitly allow passing NULL for strings, documentation
> clearly states that. And if not, we should improve documentation.
> 
> > > > Signed-off-by: Xin Liu <liuxin350@huawei.com>
> > > > ---
> > > >   tools/lib/bpf/libbpf.c | 13 ++++++++++++-
> > > >   1 file changed, 12 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > index 2a82f49ce16f..0d21de4f7d5c 100644
> > > > --- a/tools/lib/bpf/libbpf.c
> > > > +++ b/tools/lib/bpf/libbpf.c
> > > > @@ -9764,6 +9764,11 @@ struct bpf_link
> > > > *bpf_program__attach_perf_event_opts(const struct bpf_program *p
> > > >     if (!OPTS_VALID(opts, bpf_perf_event_opts))
> > > >             return libbpf_err_ptr(-EINVAL);
> > > >
> > > > +   if (!prog || !prog->name) {
> > > > +           pr_warn("prog: invalid prog\n");
> > > > +           return libbpf_err_ptr(-EINVAL);
> > > > +   }
> > > > +
> > > >     if (pfd < 0) {
> > > >             pr_warn("prog '%s': invalid perf event FD %d\n",
> > > >                     prog->name, pfd);
> > > > @@ -10967,7 +10972,7 @@ struct bpf_link *bpf_program__attach_usdt(const
> > > > struct bpf_program *prog,
> > > >                                       const struct bpf_usdt_opts *opts)
> > > >   {
> > > >     char resolved_path[512];
> > > > -   struct bpf_object *obj = prog->obj;
> > > > +   struct bpf_object *obj;
> > > >     struct bpf_link *link;
> > > >     __u64 usdt_cookie;
> > > >     int err;
> > > > @@ -10975,6 +10980,11 @@ struct bpf_link *bpf_program__attach_usdt(const
> > > > struct bpf_program *prog,
> > > >     if (!OPTS_VALID(opts, bpf_uprobe_opts))
> > > >             return libbpf_err_ptr(-EINVAL);
> > > >
> > > > +   if (!prog || !prog->name || !prog->obj) {
> > > > +           pr_warn("prog: invalid prog\n");
> > > > +           return libbpf_err_ptr(-EINVAL);
> > > > +   }
> > > > +
> > > >     if (bpf_program__fd(prog) < 0) {
> > > >             pr_warn("prog '%s': can't attach BPF program w/o FD (did you load
> > > > it?)\n",
> > > >                     prog->name);
> > > > @@ -10997,6 +11007,7 @@ struct bpf_link *bpf_program__attach_usdt(const
> > > > struct bpf_program *prog,
> > > >     /* USDT manager is instantiated lazily on first USDT attach. It will
> > > >      * be destroyed together with BPF object in bpf_object__close().
> > > >      */
> > > > +   obj = prog->obj;
> > > >     if (IS_ERR(obj->usdt_man))
> > > >             return libbpf_ptr(obj->usdt_man);
> > > >     if (!obj->usdt_man) {
> > > > --
> > > > 2.33.0

Thanks to Andrii and sdf.
I will resubmit a patch to update the API documentation.
