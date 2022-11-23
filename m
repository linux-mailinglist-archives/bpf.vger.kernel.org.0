Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AAF636E68
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 00:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiKWXb3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 18:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiKWXbX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 18:31:23 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C4A11E71C
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 15:31:21 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z63so401289ede.1
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 15:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gjjaBBX9lCEejNaXy8gQOxPCUm887Yu2GwGBhBaL1y8=;
        b=iy6y67oxjlsTZOiefoILf8KEXJPelyPz6yOwVZVjNPQk64ioRY4GbzxLHnFrfoFq8I
         f1ygB0CPmRjtHwBNu+bjpZZxF9T5u5JxrylnshcnKCaEbG94CmHQ1YzYqv6w8iSDw0Z2
         Zc0a9usJqgDDWXD53ssyooai840D4Un4qg2AoXnFIzI+YJK2NAk2g8VB7R5sOvY5Ug6F
         aeYCVRgVDhJe+33hKEnegEUfhwe/EE0m+ng3IDRhgsNwAhw8clF3Rrx1XZJNv2+N08A6
         lqfOPeD2AkrAV0SKNjdaiOv3kEHnH490UQbROQe4oiw0ShpwxHoSy5Gcq43fPdh45LtF
         tQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjjaBBX9lCEejNaXy8gQOxPCUm887Yu2GwGBhBaL1y8=;
        b=0AOEf055WWawvLqTQcIeHwYKsuSMa2X3b8ZKe1Ztz8hybWTPPeIwOh+FhvqKM1hFeE
         rYcRbAQnpFSHQPMfQQGZOX5sMLPy2bfuzQRqWuCbdkBFQI60sPg43vZAKFv8doZj/HSg
         y7/UsfgOmfZlnqLVfzuZoOPeQPu2h/Zm3atx40bCuYhj3+Sz4jfUeMdUXywU8Qziim+s
         mdBOUoTJNTmJ26bq4hxLeB9unFDpfqw0QkvJ/tDJGTaYDHJcaPRIi+45bY3geAtxA6NU
         udizVCUaab/nKdOuE7x5k4rF5MrygfKzYE7hlEZIsItiImPexYfxdOkKD/eLk00y4+8v
         OZag==
X-Gm-Message-State: ANoB5pm75lC6d7g8x3QerTB0f+poy+sZc1qrHwLnp7uG/eZTTH8YKMeh
        BDJCD73RQuUbNgWt/7gmEFQt+Bxf/tHc3XV3+Ro=
X-Google-Smtp-Source: AA0mqf5Q6dpnJibXoWHaFcBBzttJp0vmPw28OksM72rKW8vIioL8fBdaElqZk16qtU6mKdFOg+LSDJnhW6YuIIiMvkU=
X-Received: by 2002:aa7:cb4d:0:b0:469:e00a:a297 with SMTP id
 w13-20020aa7cb4d000000b00469e00aa297mr10079194edt.333.1669246279536; Wed, 23
 Nov 2022 15:31:19 -0800 (PST)
MIME-Version: 1.0
References: <20221123200829.2226254-1-sdf@google.com> <CAADnVQ+dauPf-BhcmM4O7qSqzZFLK2+56N3djzR6zRPB_yawsA@mail.gmail.com>
 <CAKH8qBt9Fp2q54=EGeLjpyEz2BeZ9zkEmF0z+e4xohejxxwcBw@mail.gmail.com>
In-Reply-To: <CAKH8qBt9Fp2q54=EGeLjpyEz2BeZ9zkEmF0z+e4xohejxxwcBw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 23 Nov 2022 15:31:08 -0800
Message-ID: <CAADnVQKeYPT1MaLAOX+3RLPaV=NYcqdDij+k42xSpOvOFftj=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Mount debugfs in setns_by_fd
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Jiri Olsa <olsajiri@gmail.com>
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

On Wed, Nov 23, 2022 at 2:39 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Wed, Nov 23, 2022 at 12:39 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Nov 23, 2022 at 12:08 PM Stanislav Fomichev <sdf@google.com> wrote:
> > >
> > > Jiri reports broken test_progs after recent commit 68f8e3d4b916
> > > ("selftests/bpf: Make sure zero-len skbs aren't redirectable").
> > > Apparently we don't remount debugfs when we switch back networking namespace.
> > > Let's explicitly mount /sys/kernel/debug.
> > >
> > > 0: https://lore.kernel.org/bpf/63b85917-a2ea-8e35-620c-808560910819@meta.com/T/#ma66ca9c92e99eee0a25e40f422489b26ee0171c1
> > >
> > > Fixes: a30338840fa5 ("selftests/bpf: Move open_netns() and close_netns() into network_helpers.c")
> > > Reported-by: Jiri Olsa <olsajiri@gmail.com>
> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > ---
> > >  tools/testing/selftests/bpf/network_helpers.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> > > index bec15558fd93..1f37adff7632 100644
> > > --- a/tools/testing/selftests/bpf/network_helpers.c
> > > +++ b/tools/testing/selftests/bpf/network_helpers.c
> > > @@ -426,6 +426,10 @@ static int setns_by_fd(int nsfd)
> > >         if (!ASSERT_OK(err, "mount /sys/fs/bpf"))
> > >                 return err;
> > >
> > > +       err = mount("debugfs", "/sys/kernel/debug", "debugfs", 0, NULL);
> > > +       if (!ASSERT_OK(err, "mount /sys/kernel/debug"))
> > > +               return err;
> > > +
> > >         return 0;
> > >  }
> >
> > Thanks.
> > It fixes part of it but it's still racy.
> > I see:
> > do_read:FAIL:open open /sys/fs/bpf/bpf_iter_test1 failed: No such file
> > or directory
> >
> > I suspect it happens when iter tests are running while test_empty_skb
> > is cleaning the netns.
> >
> > So I've added:
> > -void test_empty_skb(void)
> > +void serial_test_empty_skb(void)
> > -void test_xdp_do_redirect(void)
> > +void serial_test_xdp_do_redirect(void)
> > -void test_xdp_synproxy(void)
> > +void serial_test_xdp_synproxy(void)
> >
> > to stop the bleeding and applied.
>
> Not sure I understand where the race is coming from and no luck
> reproducing locally :-(
> Looks like we run the tests in the forked workers, so that
> unshare(mountns) shouldn't theoretically affect the rest, but
> obviously I'm missing something..

I'm equally confused.
If what you're describing was the case than the bug of
not mounting debugfs wouldn't have caused issues in parallel run.
That close_netns is somehow messing with other forked processes.
