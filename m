Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF40C652A09
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 00:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbiLTXxi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 18:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiLTXxh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 18:53:37 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3102018D;
        Tue, 20 Dec 2022 15:53:32 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id t17so33090360eju.1;
        Tue, 20 Dec 2022 15:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cXG4ipWOzV3qnuOL8kIDVZtwHABa7RGkv0p2OaiKEGY=;
        b=QNE/TtVmkQFkp2Sui6Nq1j4kR9fj336ofXGWqO/OQ0maXdPISEgTuTD45ETIekPY0W
         iSpJD8LDEkCRtMYFO4BdEMzCIiGA4ltrxfFfqEgvmqpBHg/9RxfDFb9weKayyV83sfUU
         fXKoJ+R2R089iep7IiNkeQIEbTlHJWd3wNiymVlVgVQQcN1iaXiLEw5Ev1a+G0MSUmXj
         O2la1sS5vXGvizb9az2YWDT1cEf8ywK3JLLYSwFd0hDmD9QNvL5YFlw3Ef6G3NKjXGng
         UysOb79dmnx1h9g0PEke0lTaRJfTOv/aeBLkCknuJOUD/35rv6xu87Mj18igTUgX9Kyj
         xExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXG4ipWOzV3qnuOL8kIDVZtwHABa7RGkv0p2OaiKEGY=;
        b=DRS90qYT1q+9sr5hB+ro4p5PFyxoLfEvdwAcOpXnTjwetmHZ2WutAHPe9G1GWrb630
         /xkVW+rgQhDtfe2Vp1sZcrXbRO4BqF/voxq5pkHAnjauq1tPZ009roTKiJdKzPqoJRib
         ukRMYe57ViAEx83VIJRfvsR2yoESxXLzNMAuig0nNdVxXrb6K1akADzWPRDY+X7wWmqe
         xhGqRFOceSXbPun7EHeAgqwlYJLu6uDcvRkkpVD+MU+gRy+LG58EOmW18ReEqUNgx4aU
         is9JOpeihWukLBKEXw36VXjQmhLhKbIVtggqi22YuImu3swd6MNgQ7DifvzhVFGtA/TO
         6bIw==
X-Gm-Message-State: AFqh2koFVcK0dGhXV81A+4MP1FzLr9lkBIvZhFfr4oJEbwjuLbmOGJPC
        fgCUse49zE6CFEXQvJt66kDVCcRFndvLxqg7IOE=
X-Google-Smtp-Source: AMrXdXviZyBghq3LZaqtV9KLIgNRs1EC4Zd2CZKEq3hUKJepXOaeG9eG9Lug01R1sD6EJudUjbjOQwmXGGs1/3l3eyA=
X-Received: by 2002:a17:906:f153:b0:83d:2544:a11 with SMTP id
 gw19-20020a170906f15300b0083d25440a11mr22976ejb.226.1671580411054; Tue, 20
 Dec 2022 15:53:31 -0800 (PST)
MIME-Version: 1.0
References: <Y6CyatoFytXToO/g@google.com> <20221220015635.4394-1-liuxin350@huawei.com>
In-Reply-To: <20221220015635.4394-1-liuxin350@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Dec 2022 15:53:18 -0800
Message-ID: <CAEf4BzYFrXRp+b9j7vsqhVDpWSrA3mP73GLT3c7JMd6k3nKAPg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: fix crash when input null program point in USDT API
To:     Xin Liu <liuxin350@huawei.com>
Cc:     sdf@google.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kongweibin2@huawei.com,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, song@kernel.org, wuchangye@huawei.com,
        xiesongyang@huawei.com, yanan@huawei.com, yhs@fb.com,
        zhangmingyi5@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 19, 2022 at 5:57 PM Xin Liu <liuxin350@huawei.com> wrote:
>
> On Tue, 20 Dec 2022 2:50:18 +0800 sdf<sdf@google.com> wrote:
> > On 12/19, Xin Liu wrote:
> > > The API functions bpf_program__attach_perf_event_opts and
> > > bpf_program_attach_usdt can be invoked by users. However, when the
> > > input prog parameter is null, the API uses name and obj without
> > > check. This will cause program to crash directly.
> >
> > Why do we care about these only? We have a lot of functions invoked
> > by the users which don't check the arguments. Can the caller ensure
> > the prog is valid/consistent before calling these?
> >
>
> Thanks to sdf for this suggestions.
>
> But I don't think it's a good idea to let the user guarantee:
> 1.We can't require all users to verify parameters before transferring
>   parameters. Some parameters may be omitted. If the user forgets to check
>   the program pointer and it happens to be NULL, the program will crash
>   without any last words, and the user can only use the debugging tool to
>   collect relevant clues, which is a disaster for the user.
> 2.Code changes are required for completed user programs and places where
>   the API is invoked. For users, the cost of ensuring that each parameter
>   check result is correct is high, which is much higher than that of
>   directly verifying the parameter in libbpf.
>
> So I think we should do some validation at the API entrance, whick is a
> big benefit at the minimum cost, and in fact we do that, for example,
> OPTS_VALID validation, right?
>

I agree with Stanislav. There is no reason for user to assume that
passing NULL works as a general rule. We do not check for NULL
everywhere. If user doesn't follow API contract, yes, they will get
crashes or confusing behavior, unfortunately.

For APIs that explicitly allow passing NULL for strings, documentation
clearly states that. And if not, we should improve documentation.

> > > Signed-off-by: Xin Liu <liuxin350@huawei.com>
> > > ---
> > >   tools/lib/bpf/libbpf.c | 13 ++++++++++++-
> > >   1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 2a82f49ce16f..0d21de4f7d5c 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -9764,6 +9764,11 @@ struct bpf_link
> > > *bpf_program__attach_perf_event_opts(const struct bpf_program *p
> > >     if (!OPTS_VALID(opts, bpf_perf_event_opts))
> > >             return libbpf_err_ptr(-EINVAL);
> > >
> > > +   if (!prog || !prog->name) {
> > > +           pr_warn("prog: invalid prog\n");
> > > +           return libbpf_err_ptr(-EINVAL);
> > > +   }
> > > +
> > >     if (pfd < 0) {
> > >             pr_warn("prog '%s': invalid perf event FD %d\n",
> > >                     prog->name, pfd);
> > > @@ -10967,7 +10972,7 @@ struct bpf_link *bpf_program__attach_usdt(const
> > > struct bpf_program *prog,
> > >                                       const struct bpf_usdt_opts *opts)
> > >   {
> > >     char resolved_path[512];
> > > -   struct bpf_object *obj = prog->obj;
> > > +   struct bpf_object *obj;
> > >     struct bpf_link *link;
> > >     __u64 usdt_cookie;
> > >     int err;
> > > @@ -10975,6 +10980,11 @@ struct bpf_link *bpf_program__attach_usdt(const
> > > struct bpf_program *prog,
> > >     if (!OPTS_VALID(opts, bpf_uprobe_opts))
> > >             return libbpf_err_ptr(-EINVAL);
> > >
> > > +   if (!prog || !prog->name || !prog->obj) {
> > > +           pr_warn("prog: invalid prog\n");
> > > +           return libbpf_err_ptr(-EINVAL);
> > > +   }
> > > +
> > >     if (bpf_program__fd(prog) < 0) {
> > >             pr_warn("prog '%s': can't attach BPF program w/o FD (did you load
> > > it?)\n",
> > >                     prog->name);
> > > @@ -10997,6 +11007,7 @@ struct bpf_link *bpf_program__attach_usdt(const
> > > struct bpf_program *prog,
> > >     /* USDT manager is instantiated lazily on first USDT attach. It will
> > >      * be destroyed together with BPF object in bpf_object__close().
> > >      */
> > > +   obj = prog->obj;
> > >     if (IS_ERR(obj->usdt_man))
> > >             return libbpf_ptr(obj->usdt_man);
> > >     if (!obj->usdt_man) {
> > > --
> > > 2.33.0
