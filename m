Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13349636EBA
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 01:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiKXAJH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 19:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKXAJG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 19:09:06 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6920C3123E
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 16:09:05 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id v82so59640oib.4
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 16:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I1yCLM4PqzlCbMMiPi6+90V7LYJo/IlOg03joW6Hjic=;
        b=BVR1rVZKYrEqpJhg0FaYDCH50Xx32Jx2FMa+WqH67ShSSy0yCTJmYiv/qrQdDV4IAa
         G+optvdjyk/3KAUS91rfiElD9O8thnUlvoJOvFejvud5WafE2bJIivfpeLD3noKDnmlP
         HtSf/gRW6pC1uC10NDEJ5oOAYt8RGKb5J3YtC/hc9i4xvmNyuQDiCmfOhQYUccOw5Ysx
         9j5Az6BKQa++I2HT1NTEecD7rHvFYBoZxmcg2sUFqpaRbXPT5mfc8pkNMnaGpJQ2dtfK
         bfqc5YUsodqK4R8UHG/N+EYBbejfHD/gJwaQO5faaWphAA6q1b4ZIiYOulzog3/KTjSE
         3NUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1yCLM4PqzlCbMMiPi6+90V7LYJo/IlOg03joW6Hjic=;
        b=Plqf5e6HbbbfW+TdQmx6Fr8PuEXO548OvYHpxmYPP78xdnPPRi3BLUC9Yeqb9kpmoE
         SdVXrCCwU9U4l2w1o9r6o7cY/bgqzOH6SjiD7qz7J4MEl72WDwJ8jd+3pnyTt7+rdMjs
         YVPx2EY/qykoBMKpDkMq0mrHnTzAVnkuQskPTdfK9HafK7WHD57C/5DaLnfzN9CPZWqV
         j6DX3Uw+Ri2cHF50o1bpkk+TC0VLXQ18qpv2AmcPNwLe547MgikIxUhQzM8ZPDYHebJl
         m8YjXBtW4LQJuLzEiX6nf7mJWpuE8wtWu90wYRrNcsa491Ml3y9mfeanc/yvPYYji5jv
         GBXQ==
X-Gm-Message-State: ANoB5pk5kp04bqO5+3sRldiNcpJ6ujwtQxj5SVfvA6nxhnq79gVwjsYz
        fYKKeoLwKeRVBU8oy+4CPE6fnQmtLtG4Nk8NZJiKZQ==
X-Google-Smtp-Source: AA0mqf511P9416VZ0HRajUDZmPHc5tXUmipHlo8UokSXGj6g5pj/pr6CALdeR+bh6sL3Uh1+bLu1zSBYNNN57pk9Oe8=
X-Received: by 2002:aca:674c:0:b0:35b:79ca:2990 with SMTP id
 b12-20020aca674c000000b0035b79ca2990mr2388160oiy.125.1669248544531; Wed, 23
 Nov 2022 16:09:04 -0800 (PST)
MIME-Version: 1.0
References: <20221123200829.2226254-1-sdf@google.com> <CAADnVQ+dauPf-BhcmM4O7qSqzZFLK2+56N3djzR6zRPB_yawsA@mail.gmail.com>
 <CAKH8qBt9Fp2q54=EGeLjpyEz2BeZ9zkEmF0z+e4xohejxxwcBw@mail.gmail.com> <CAADnVQKeYPT1MaLAOX+3RLPaV=NYcqdDij+k42xSpOvOFftj=A@mail.gmail.com>
In-Reply-To: <CAADnVQKeYPT1MaLAOX+3RLPaV=NYcqdDij+k42xSpOvOFftj=A@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 23 Nov 2022 16:08:52 -0800
Message-ID: <CAKH8qBtjTyf20cMSW7TNRq2Eg=mVXWm2cCp=ZipsaU8m_i64vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Mount debugfs in setns_by_fd
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 23, 2022 at 3:31 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 23, 2022 at 2:39 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > On Wed, Nov 23, 2022 at 12:39 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Nov 23, 2022 at 12:08 PM Stanislav Fomichev <sdf@google.com> wrote:
> > > >
> > > > Jiri reports broken test_progs after recent commit 68f8e3d4b916
> > > > ("selftests/bpf: Make sure zero-len skbs aren't redirectable").
> > > > Apparently we don't remount debugfs when we switch back networking namespace.
> > > > Let's explicitly mount /sys/kernel/debug.
> > > >
> > > > 0: https://lore.kernel.org/bpf/63b85917-a2ea-8e35-620c-808560910819@meta.com/T/#ma66ca9c92e99eee0a25e40f422489b26ee0171c1
> > > >
> > > > Fixes: a30338840fa5 ("selftests/bpf: Move open_netns() and close_netns() into network_helpers.c")
> > > > Reported-by: Jiri Olsa <olsajiri@gmail.com>
> > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > > ---
> > > >  tools/testing/selftests/bpf/network_helpers.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> > > > index bec15558fd93..1f37adff7632 100644
> > > > --- a/tools/testing/selftests/bpf/network_helpers.c
> > > > +++ b/tools/testing/selftests/bpf/network_helpers.c
> > > > @@ -426,6 +426,10 @@ static int setns_by_fd(int nsfd)
> > > >         if (!ASSERT_OK(err, "mount /sys/fs/bpf"))
> > > >                 return err;
> > > >
> > > > +       err = mount("debugfs", "/sys/kernel/debug", "debugfs", 0, NULL);
> > > > +       if (!ASSERT_OK(err, "mount /sys/kernel/debug"))
> > > > +               return err;
> > > > +
> > > >         return 0;
> > > >  }
> > >
> > > Thanks.
> > > It fixes part of it but it's still racy.
> > > I see:
> > > do_read:FAIL:open open /sys/fs/bpf/bpf_iter_test1 failed: No such file
> > > or directory
> > >
> > > I suspect it happens when iter tests are running while test_empty_skb
> > > is cleaning the netns.
> > >
> > > So I've added:
> > > -void test_empty_skb(void)
> > > +void serial_test_empty_skb(void)
> > > -void test_xdp_do_redirect(void)
> > > +void serial_test_xdp_do_redirect(void)
> > > -void test_xdp_synproxy(void)
> > > +void serial_test_xdp_synproxy(void)
> > >
> > > to stop the bleeding and applied.
> >
> > Not sure I understand where the race is coming from and no luck
> > reproducing locally :-(
> > Looks like we run the tests in the forked workers, so that
> > unshare(mountns) shouldn't theoretically affect the rest, but
> > obviously I'm missing something..
>
> I'm equally confused.

[..]

> If what you're describing was the case than the bug of
> not mounting debugfs wouldn't have caused issues in parallel run.

The workers are reused and aren't respawned for every test.
If some of them runs empty_skb test, its debugfs is not mounted
anymore and any other test that requires debugfs (and lands on this
worker) will be broken.

> That close_netns is somehow messing with other forked processes.
Yeah, agreed, looks like /sys/fs/bpf disappears while bpf_iter test is running.
I can try to stick open/close_netns in a bunch of places in test_progs
to see if I can trigger the issue. (or maybe have a test in parallel
that does while(1) {openns(); closens(); }
