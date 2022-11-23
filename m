Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1021636D62
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 23:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiKWWjH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 17:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKWWjF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 17:39:05 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2CA92B5D
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 14:39:04 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id p8-20020a056830130800b0066bb73cf3bcso12109476otq.11
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 14:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GgMLFLts+LrHqYdbPwazLqaNgD7hTCtQViG2uYPV3T4=;
        b=NxA3l6kA4wXiZQlZu192lF0+uYCph3r9zMZolHUD4JSAVcYBFJBTolQaoaaG7wkQsv
         2G7kpHiLJgVGC+E532UlKCtY9TK8kZ8DPZC+Eg3PFL06fVuXmzsC4bM/C6oMxVDSRNBX
         +6QoSUc5GTdfMsVVfgrh4vBUnvB9NrnVlv9IPEkFtvYpreCmZz1W+xj3xHlTkZh7rMF9
         jDWwNO4E/pQQ6nJrj3lklZolqeoBsZzOFAdkuR5MEiybODC+AfLzLIXYBBXxcxZ2bdky
         dEX8RRsFbC9nNBImktR41CHJe3uh57rJfL+acQBg7s2VKc3yt73Nv4c9zcvTRd9uecB4
         qLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgMLFLts+LrHqYdbPwazLqaNgD7hTCtQViG2uYPV3T4=;
        b=fAhMMMDg4v76eIN46/nILs+VHx96irwYk18Rz6wcq/7JsAXMnzPSOupQLTaV0QLJ3R
         odFCF+iL9oZ/TvNxs9p488PeMYMDPKCeSuhxsCzJgUzquHoJy1b2CJjU+IG3eO93e8YE
         xPQ+FFFoJld/nvAevZeOV+b8LZwNwjP7BkbpXx6fuiGK24z3btreBusaaqudz7rNY45/
         s+Wp3bRxYLi4mCIhJGURhBFaZjucfO0E35FCWzIlzOTsUBMPlynbVEs+Z3h5zLmoo99j
         0Te31SzRbmeRnRwtgy/YTSquRsjFyIB6Emrdg5+rZESZaCsy5lImkUzrLtbUP3HOnZbC
         Zmzw==
X-Gm-Message-State: ANoB5plx5Twc9p741Ixg0niiW+EudbdqbRLFQ5/QawBUfpTByKIRFMH7
        kSkYF4YbBOZfTX09NPW0sxadc3EGO+IjxIAKBR7UMw==
X-Google-Smtp-Source: AA0mqf6Uv+B3faegPeGa6GHGMlPbueg5lXVF6MayeuFlMnyocuOxjyt0qpXYVvtQJd1aaJ/N1RqJoufRj22HYQgfI2w=
X-Received: by 2002:a9d:282:0:b0:66c:794e:f8c6 with SMTP id
 2-20020a9d0282000000b0066c794ef8c6mr16071149otl.343.1669243143258; Wed, 23
 Nov 2022 14:39:03 -0800 (PST)
MIME-Version: 1.0
References: <20221123200829.2226254-1-sdf@google.com> <CAADnVQ+dauPf-BhcmM4O7qSqzZFLK2+56N3djzR6zRPB_yawsA@mail.gmail.com>
In-Reply-To: <CAADnVQ+dauPf-BhcmM4O7qSqzZFLK2+56N3djzR6zRPB_yawsA@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 23 Nov 2022 14:38:52 -0800
Message-ID: <CAKH8qBt9Fp2q54=EGeLjpyEz2BeZ9zkEmF0z+e4xohejxxwcBw@mail.gmail.com>
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

On Wed, Nov 23, 2022 at 12:39 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 23, 2022 at 12:08 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > Jiri reports broken test_progs after recent commit 68f8e3d4b916
> > ("selftests/bpf: Make sure zero-len skbs aren't redirectable").
> > Apparently we don't remount debugfs when we switch back networking namespace.
> > Let's explicitly mount /sys/kernel/debug.
> >
> > 0: https://lore.kernel.org/bpf/63b85917-a2ea-8e35-620c-808560910819@meta.com/T/#ma66ca9c92e99eee0a25e40f422489b26ee0171c1
> >
> > Fixes: a30338840fa5 ("selftests/bpf: Move open_netns() and close_netns() into network_helpers.c")
> > Reported-by: Jiri Olsa <olsajiri@gmail.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  tools/testing/selftests/bpf/network_helpers.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> > index bec15558fd93..1f37adff7632 100644
> > --- a/tools/testing/selftests/bpf/network_helpers.c
> > +++ b/tools/testing/selftests/bpf/network_helpers.c
> > @@ -426,6 +426,10 @@ static int setns_by_fd(int nsfd)
> >         if (!ASSERT_OK(err, "mount /sys/fs/bpf"))
> >                 return err;
> >
> > +       err = mount("debugfs", "/sys/kernel/debug", "debugfs", 0, NULL);
> > +       if (!ASSERT_OK(err, "mount /sys/kernel/debug"))
> > +               return err;
> > +
> >         return 0;
> >  }
>
> Thanks.
> It fixes part of it but it's still racy.
> I see:
> do_read:FAIL:open open /sys/fs/bpf/bpf_iter_test1 failed: No such file
> or directory
>
> I suspect it happens when iter tests are running while test_empty_skb
> is cleaning the netns.
>
> So I've added:
> -void test_empty_skb(void)
> +void serial_test_empty_skb(void)
> -void test_xdp_do_redirect(void)
> +void serial_test_xdp_do_redirect(void)
> -void test_xdp_synproxy(void)
> +void serial_test_xdp_synproxy(void)
>
> to stop the bleeding and applied.

Not sure I understand where the race is coming from and no luck
reproducing locally :-(
Looks like we run the tests in the forked workers, so that
unshare(mountns) shouldn't theoretically affect the rest, but
obviously I'm missing something..
