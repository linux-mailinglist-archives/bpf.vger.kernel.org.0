Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC486835C9
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 19:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjAaSz7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 13:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjAaSzq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 13:55:46 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF48564AD
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:55:33 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id m2so44032778ejb.8
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 10:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=imrlHh4xYDxl5EUeaaSKiONuQYGr6BPeaRlABY98Zzw=;
        b=eoY8z5tfoqpvQhbwIPXu2Neca6uR0/jGJvxTwMegQb9lJbMD6tMSMG1eY9ivWVnb0e
         oTqrFI5kyrdpH84cdOb0MmK/e6TmIxksKOKE0D41qjGUTdHmt0wMvYxRmb9IMmG1Z7Su
         d/sU9NWZIfMQkWSI1DcY+xeMwt2ygbkl7abjohGSyVFHIuYUdt+5hVzvAjER48Z4PUhJ
         7ZIChRX44CxcOikmLC6vSabLYQWAlxu3se9Rn7Ct5p1qXsX1VGhu57jrs6/0y7AQSXTE
         8WSVO4//Fp0Q/0wD9yTv1l/yt2l0SX/7WQJZaNrCrRn8R4/UZOeSIVjfGdWzmKnLg6Y4
         pWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imrlHh4xYDxl5EUeaaSKiONuQYGr6BPeaRlABY98Zzw=;
        b=SRVkNtgbaTcQgJzxMnr9ySSXpxpHSxOqJmT7MVfU4KaGbFHVXx48kmVCI5A29Iy6Dz
         JWU4wXL5f+64JYJpg+UmI+yWJ90QLlR9Dwagn1CEAxY5PqJegEJsq5Iel8SN8Fz8rVSk
         2qr9aK/9HBrnfNr2VrNj4A6R+jdydMbKeAXaJLRLeFKVj0iaPZa2/QM1x/rCgOtHSppQ
         0xdz0gUDG7QtCkiwmFvTMJOGZ9JKxTQk3IUaBYV/ob786Mf169lEliWXROR/Qw4Bovk+
         GLSdU9tNl/85aaRr9In9rp0iA9Rmv2zTRjE7a/tcjjIMJYDShahDDgT2hFEFmkldG8mL
         Mnjw==
X-Gm-Message-State: AO0yUKXomOx8wLG5xkyitI6AgX4fNwWA1cXUkW+tEY50aNGBmyzyKH/U
        XFwwp5VDY6y7liFONqKc4H5n8zci5i410zxwMzU=
X-Google-Smtp-Source: AK7set/dxzFWvjOaHeCi21JhnBltUpVnMx2sS/zmoYrxAUbCS9+pLcBE9/EGhDqNkbKfxRF2xU1CgsqZgu9sOlh9f9I=
X-Received: by 2002:a17:906:46d3:b0:888:1f21:4424 with SMTP id
 k19-20020a17090646d300b008881f214424mr2818201ejs.141.1675191331356; Tue, 31
 Jan 2023 10:55:31 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzYoB8Ut7UM62dw6TquHfBMAzjbKR=aG_c74XaCgYYyikg@mail.gmail.com>
 <e64e8dbea359c1e02b7c38724be72f354257c2f6.camel@gmail.com>
 <CAEf4BzY3e+ZuC6HUa8dCiUovQRg2SzEk7M-dSkqNZyn=xEmnPA@mail.gmail.com>
 <b836c36a68b670df8f649db621bb3ec74e03ef9b.camel@gmail.com>
 <CAEf4Bza8q2P1mqN4LYwiYqssBiQDorjkFaZDsudOQFCb2825Vw@mail.gmail.com>
 <CAEf4BzY9ikdrT5WN__QJgaYhWJ=h0Do8T7YkiYLpT9VftqecVg@mail.gmail.com>
 <CAADnVQKs2i1iuZ5SUGuJtxWVfGYR9kDgYKhq3rNV+kBLQCu7rA@mail.gmail.com>
 <CAADnVQLybn06cYYV3uf3FeAGMjOiL5riRzhV6f9fuFOHr9bL=g@mail.gmail.com>
 <dd76a0254d08b25d83ad30d6f07acef36e6223e1.camel@gmail.com>
 <CAEf4BzYsVOiQLXu8tH75FA0Zvey2b7-0TR3aW2Wuqi+fKEtwgA@mail.gmail.com>
 <20230131024248.lw7flczsqhi3llt2@macbook-pro-6.dhcp.thefacebook.com> <082fd8451321a832f334882a1872b5cee240d811.camel@gmail.com>
In-Reply-To: <082fd8451321a832f334882a1872b5cee240d811.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 31 Jan 2023 10:55:19 -0800
Message-ID: <CAEf4BzYdHQ8V6MK3SOzQamZPgTdVGXiyUmch2nHEwnLDMg71Jw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix to preserve reg parent/live
 fields when copying range info
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 31, 2023 at 12:29 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Mon, 2023-01-30 at 18:42 -0800, Alexei Starovoitov wrote:
> [...]
> > > >
> > > > Hi Alexei, Andrii,
> > > >
> > > > Please note that the patch
> > > > "bpf: Fix to preserve reg parent/live fields when copying range info"
> > > > that started this conversation was applied to `bpf` tree, not `bpf-next`,
> > > > so I'll wait until it gets its way to `bpf-next` before submitting formal
> > > > patches, as it changes the performance numbers collected by veristat.
> > > > I did all my experiments with this patch applied on top of `bpf-next`.
> > > >
> > > > I adapted the patch suggested by Alexei and put it to my github for
> > > > now [1]. The performance gains are indeed significant:
> > > >
> > > > $ ./veristat -e file,states -C -f 'states_pct<-30' master.log uninit-reads.log
> > > > File                        States (A)  States (B)  States    (DIFF)
> > > > --------------------------  ----------  ----------  ----------------
> > > > bpf_host.o                         349         244    -105 (-30.09%)
> > > > bpf_host.o                        1320         895    -425 (-32.20%)
> > > > bpf_lxc.o                         1320         895    -425 (-32.20%)
> > > > bpf_sock.o                          70          48     -22 (-31.43%)
> > > > bpf_sock.o                          68          46     -22 (-32.35%)
> > > > bpf_xdp.o                         1554         803    -751 (-48.33%)
> > > > bpf_xdp.o                         6457        2473   -3984 (-61.70%)
> > > > bpf_xdp.o                         7249        3908   -3341 (-46.09%)
> > > > pyperf600_bpf_loop.bpf.o           287         145    -142 (-49.48%)
> > > > strobemeta.bpf.o                 15879        4790  -11089 (-69.83%)
> > > > strobemeta_nounroll2.bpf.o       20505        3931  -16574 (-80.83%)
> > > > xdp_synproxy_kern.bpf.o          22564        7009  -15555 (-68.94%)
> > > > xdp_synproxy_kern.bpf.o          24206        6941  -17265 (-71.33%)
> > > > --------------------------  ----------  ----------  ----------------
> > > >
> > > > However, this comes at a cost of allowing reads from uninitialized
> > > > stack locations. As far as I understand access to uninitialized local
> > > > variable is one of the most common errors when programming in C
> > > > (although citation is needed).
> > >
> > > Yeah, a citation is really needed :) I don't see this often in
> > > practice, tbh. What I do see in practice is that people are
> > > unnecessarily __builtint_memset(0) struct and initialize all fields
> > > with field-by-field initialization, instead of just using a nice C
> > > syntax:
> > >
> > > struct my_struct s = {
> > >    .field_a = 123,
> > >    .field_b = 234,
> > > };
> > >
> > >
> > > And all that just because there is some padding between field_a and
> > > field_b which the compiler won't zero-initialize.
>
> Andrii, do you have such example somewhere? If the use case is to pass
> 's' to some helper function it should already work if function
> argument type is 'ARG_PTR_TO_UNINIT_MEM'. Handled by the following
> code in the verifier.c:check_stack_range_initialized():
>
>         ...
>         if (meta && meta->raw_mode) {
>                 ...
>                 meta->access_size = access_size;
>                 meta->regno = regno;
>                 return 0;
>         }
>
> But only for fixed stack offsets. I'm asking because it might point to
> some bug.

I don't have specifics at hand, but there were at least few different
internal cases where this popped up. And just grepping code base, we
have tons of

__builtin_memset(&event, 0, sizeof(event));

in our code base, even if struct initialization would be more convenient.

I don't remember how exactly that struct was used, but one of the use
cases was passing it to bpf_perf_event_output(), which expects
initialized memory.

>
> > >
> > > >
> > > > Also more tests are failing after register parentage chains patch is
> > > > applied than in Alexei's initial try: 10 verifier tests and 1 progs
> > > > test (test_global_func10.c, I have not modified it yet, it should wait
> > > > for my changes for unprivileged execution mode support in
> > > > test_loader.c). I don't really like how I had to fix those tests.
> > > >
> > > > I took a detailed look at the difference in verifier behavior between
> > > > master and the branch [1] for pyperf600_bpf_loop.bpf.o and identified
> > > > that the difference is caused by the fact that helper functions do not
> > > > mark the stack they access as REG_LIVE_WRITTEN, the details are in the
> > > > commit message [3], but TLDR is the following example:
> > > >
> > > >         1: bpf_probe_read_user(&foo, ...);
> > > >         2: if (*foo) ...
> > > >
> > > > Here `*foo` will not get REG_LIVE_WRITTEN mark when (1) is verified,
> > > > thus `*foo` read at (2) might lead to excessive REG_LIVE_READ marks
> > > > and thus more verification states.
> > >
> > > This is a good fix in its own right, of course, we should definitely do this!
> >
> > +1
> >
> > > >
> > > > I prepared a patch that changes helper calls verification to apply
> > > > REG_LIVE_WRITTEN when write size and alignment allow this, again
> > > > currently on my github [2]. This patch has less dramatic performance
> > > > impact, but nonetheless significant:
> > > >
> > > > $ veristat -e file,states -C -f 'states_pct<-30' master.log helpers-written.log
> > > > File                        States (A)  States (B)  States    (DIFF)
> > > > --------------------------  ----------  ----------  ----------------
> > > > pyperf600_bpf_loop.bpf.o           287         156    -131 (-45.64%)
> > > > strobemeta.bpf.o                 15879        4772  -11107 (-69.95%)
> > > > strobemeta_nounroll1.bpf.o        2065        1337    -728 (-35.25%)
> > > > strobemeta_nounroll2.bpf.o       20505        3788  -16717 (-81.53%)
> > > > test_cls_redirect.bpf.o           8129        4799   -3330 (-40.96%)
> > > > --------------------------  ----------  ----------  ----------------
> > > >
> > > > I suggest that instead of dropping a useful safety check I can further
> > > > investigate difference in behavior between "uninit-reads.log" and
> > > > "helpers-written.log" and maybe figure out other improvements.
> > > > Unfortunately the comparison process is extremely time consuming.
> > > >
> > > > wdyt?
> > >
> > > I think reading uninitialized stack slot concerns are overblown in
> > > practice (in terms of their good implications for programmer's
> > > productivity), I'd still do it if only in the name of improving user
> > > experience.
> >
> > +1
> > Let's do both (REG_LIVE_WRITTEN for helpers and allow uninit).
> >
> > Uninit access should be caught by the compiler.
> > The verifier is repeating the check for historical reasons when we
> > tried to make it work for unpriv.
> > Allow uninit won't increase the number of errors in bpf progs.
>
> Thank you for the feedback. I'll submit both patches when
> "bpf: Fix to preserve reg parent/live fields when copying range info"
> will get to bpf-next.
>
> Thanks,
> Eduard.
