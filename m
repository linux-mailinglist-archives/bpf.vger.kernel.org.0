Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B82B651892
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 02:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiLTB46 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 20:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiLTB4y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 20:56:54 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FDA104;
        Mon, 19 Dec 2022 17:56:53 -0800 (PST)
Received: from dggpeml500010.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Nbfhr0QnKzqT7C;
        Tue, 20 Dec 2022 09:52:28 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Dec
 2022 09:56:50 +0800
From:   Xin Liu <liuxin350@huawei.com>
To:     <sdf@google.com>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <haoluo@google.com>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>,
        <kongweibin2@huawei.com>, <kpsingh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <liuxin350@huawei.com>,
        <martin.lau@linux.dev>, <song@kernel.org>, <wuchangye@huawei.com>,
        <xiesongyang@huawei.com>, <yanan@huawei.com>, <yhs@fb.com>,
        <zhangmingyi5@huawei.com>
Subject: Re: [PATCH] libbpf: fix crash when input null program point in USDT API
Date:   Tue, 20 Dec 2022 09:56:35 +0800
Message-ID: <20221220015635.4394-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <Y6CyatoFytXToO/g@google.com>
References: <Y6CyatoFytXToO/g@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 20 Dec 2022 2:50:18 +0800 sdf<sdf@google.com> wrote:
> On 12/19, Xin Liu wrote:
> > The API functions bpf_program__attach_perf_event_opts and
> > bpf_program_attach_usdt can be invoked by users. However, when the
> > input prog parameter is null, the API uses name and obj without
> > check. This will cause program to crash directly.
>
> Why do we care about these only? We have a lot of functions invoked
> by the users which don't check the arguments. Can the caller ensure
> the prog is valid/consistent before calling these?
>

Thanks to sdf for this suggestions.

But I don't think it's a good idea to let the user guarantee:
1.We can't require all users to verify parameters before transferring
  parameters. Some parameters may be omitted. If the user forgets to check
  the program pointer and it happens to be NULL, the program will crash
  without any last words, and the user can only use the debugging tool to
  collect relevant clues, which is a disaster for the user.
2.Code changes are required for completed user programs and places where
  the API is invoked. For users, the cost of ensuring that each parameter
  check result is correct is high, which is much higher than that of
  directly verifying the parameter in libbpf.

So I think we should do some validation at the API entrance, whick is a
big benefit at the minimum cost, and in fact we do that, for example,
OPTS_VALID validation, right?

> > Signed-off-by: Xin Liu <liuxin350@huawei.com>
> > ---
> >   tools/lib/bpf/libbpf.c | 13 ++++++++++++-
> >   1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 2a82f49ce16f..0d21de4f7d5c 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -9764,6 +9764,11 @@ struct bpf_link  
> > *bpf_program__attach_perf_event_opts(const struct bpf_program *p
> >   	if (!OPTS_VALID(opts, bpf_perf_event_opts))
> >   		return libbpf_err_ptr(-EINVAL);
> >
> > +	if (!prog || !prog->name) {
> > +		pr_warn("prog: invalid prog\n");
> > +		return libbpf_err_ptr(-EINVAL);
> > +	}
> > +
> >   	if (pfd < 0) {
> >   		pr_warn("prog '%s': invalid perf event FD %d\n",
> >   			prog->name, pfd);
> > @@ -10967,7 +10972,7 @@ struct bpf_link *bpf_program__attach_usdt(const  
> > struct bpf_program *prog,
> >   					  const struct bpf_usdt_opts *opts)
> >   {
> >   	char resolved_path[512];
> > -	struct bpf_object *obj = prog->obj;
> > +	struct bpf_object *obj;
> >   	struct bpf_link *link;
> >   	__u64 usdt_cookie;
> >   	int err;
> > @@ -10975,6 +10980,11 @@ struct bpf_link *bpf_program__attach_usdt(const  
> > struct bpf_program *prog,
> >   	if (!OPTS_VALID(opts, bpf_uprobe_opts))
> >   		return libbpf_err_ptr(-EINVAL);
> >
> > +	if (!prog || !prog->name || !prog->obj) {
> > +		pr_warn("prog: invalid prog\n");
> > +		return libbpf_err_ptr(-EINVAL);
> > +	}
> > +
> >   	if (bpf_program__fd(prog) < 0) {
> >   		pr_warn("prog '%s': can't attach BPF program w/o FD (did you load  
> > it?)\n",
> >   			prog->name);
> > @@ -10997,6 +11007,7 @@ struct bpf_link *bpf_program__attach_usdt(const  
> > struct bpf_program *prog,
> >   	/* USDT manager is instantiated lazily on first USDT attach. It will
> >   	 * be destroyed together with BPF object in bpf_object__close().
> >   	 */
> > +	obj = prog->obj;
> >   	if (IS_ERR(obj->usdt_man))
> >   		return libbpf_ptr(obj->usdt_man);
> >   	if (!obj->usdt_man) {
> > --
> > 2.33.0
