Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BA05627A9
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 02:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiGAAQr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 20:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiGAAQp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 20:16:45 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD36396BA
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 17:16:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c4so813627plc.8
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 17:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J4i+7gveYvxAkhZZJGXWU89NE3aHI+/61Hv4AI+qIZA=;
        b=cClKcuofVl755PDxtd7MsQ2JrS5iHWEbdaOsYa4YyQoMPHc45PvD7Vm7kaPbUl9iSS
         6cyS7hYebyvs7VkShmjFKRYCG2SuORNA4w6jAGExpSraVwmZq0GPJxjsGD79XgdrrhwK
         efQdBw71qxHdvkB58LAzGSA0c/rqz4QFf+13vVnr08snGuXvUZAfHK5qo1y0S7c5yU6Z
         2SvRuBNwdh95bUv4Vs2pauO3vapelVwnSw8iPkIStM0F7CM/dGbJhJfNEJJOcJ3wSawb
         K6/O6Q+S4ZLCTsW6KURJsEiKK/nH0rO2nDY+oI6ukrjW7FkSKLkyqYusyM5OxIdC8F+A
         GQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J4i+7gveYvxAkhZZJGXWU89NE3aHI+/61Hv4AI+qIZA=;
        b=tY9qPc8uNIq45FPKWPX6BweFqme9pEMN1zkMordHPgoiOMC8sYLbG9vS6628GCGgsj
         5ycOvuYwzcH05KZJapn5ulPxXReLOxOuxQNQSG+2mqCLxooh7iU5j2dWyyflcJkJVB3P
         wmdPzJFwjg51mx8zRDvtgdzraBZwKhXalUbIWOtyyw/IXnw25CrP/YPpZxkHzY372eye
         cAev6lrK9pqsMRqtw9HhZJjO7TPujgyBMsOtcqqE6ksCZW//H8iCqnnRWfiikqawqHI+
         3WioRHAMb1GB0B4PPwQR21FgoZ/NKWlJ6jxPNV8HXEuoKTpNJxsmN3gzRQGzK/lHFY6s
         QufQ==
X-Gm-Message-State: AJIora+0ThY3ir9LkuHkm+w+sJtiscUgU8XbT+/1gWsnsawUX9Wtn/ia
        xzTNhTxLAUO2gDZvnJCPalR8BRQ8ADhAYDfFsH+/hg==
X-Google-Smtp-Source: AGRyM1s/1A2XqR8GD3V2ZFGfq/yKCtKnBEDzgeGE6mJRKqO7KmGH8aMQh3+N5MWEbSU7azWHyuFpkOEipiWGpIM5eAU=
X-Received: by 2002:a17:903:1111:b0:16a:acf4:e951 with SMTP id
 n17-20020a170903111100b0016aacf4e951mr18032957plh.72.1656634603462; Thu, 30
 Jun 2022 17:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220630224203.512815-1-sdf@google.com> <CA+khW7ixZWuKPXk0f-8=BNSUUWopKgkKJ8ev+KJ9oJdf8AyUQg@mail.gmail.com>
In-Reply-To: <CA+khW7ixZWuKPXk0f-8=BNSUUWopKgkKJ8ev+KJ9oJdf8AyUQg@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 30 Jun 2022 17:16:32 -0700
Message-ID: <CAKH8qBv=3hMzpTy=K-n5+rObPhkns0gjJibVFHhNgG7ojrrMVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: skip lsm_cgroup when don't have trampolines
To:     Hao Luo <haoluo@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 30, 2022 at 4:48 PM Hao Luo <haoluo@google.com> wrote:
>
> Hi Stan,
>
> On Thu, Jun 30, 2022 at 3:42 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > With arch_prepare_bpf_trampoline removed on x86:
> >
> >  #98/1    lsm_cgroup/functional:SKIP
> >  #98      lsm_cgroup:SKIP
> >  Summary: 1/0 PASSED, 1 SKIPPED, 0 FAILED
> >
> > Fixes: dca85aac8895 ("selftests/bpf: lsm_cgroup functional test")
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> > index d40810a742fa..c542d7e80a5b 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> > @@ -9,6 +9,10 @@
> >  #include "cgroup_helpers.h"
> >  #include "network_helpers.h"
> >
> > +#ifndef ENOTSUPP
> > +#define ENOTSUPP 524
> > +#endif
> > +
> >  static struct btf *btf;
> >
> >  static __u32 query_prog_cnt(int cgroup_fd, const char *attach_func)
> > @@ -100,6 +104,10 @@ static void test_lsm_cgroup_functional(void)
> >         ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_sk_alloc_security"), 0, "prog count");
> >         ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 0, "total prog count");
> >         err = bpf_prog_attach(alloc_prog_fd, cgroup_fd, BPF_LSM_CGROUP, 0);
> > +       if (err == -ENOTSUPP) {
> > +               test__skip();
> > +               goto close_cgroup;
> > +       }
>
> It seems ENOTSUPP is only used in the kernel. I wonder whether we
> should let libbpf map ENOTSUPP to ENOTSUP, which is the errno used in
> userspace and has been used in libbpf.

Yeah, this comes up occasionally, I don't think we've agreed on some
kind of general policy about what to do with these :-(
Thanks for the review!

> Maybe the right thing is having bpf syscall return EOPNOTSUPP.
>
> But, anyway, this fix looks good to me.
>
> Acked-by: Hao Luo <haoluo@google.com>
>
>
>
> >         if (!ASSERT_OK(err, "attach alloc_prog_fd"))
> >                 goto detach_cgroup;
> >         ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_sk_alloc_security"), 1, "prog count");
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
> >
