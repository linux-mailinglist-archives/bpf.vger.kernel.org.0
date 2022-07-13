Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B1F572B34
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 04:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiGMCKr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 22:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGMCKr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 22:10:47 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B859C748C
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 19:10:46 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 64so17028662ybt.12
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 19:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hKYCOz1erP7YfA3/mb7alNX0KDoyiCbvWc8+lxp/fPQ=;
        b=MMj6TExZU7IzexSMKkfnM8TodynOOsQsi3PmMr7y6hHGPn6sYkf4KEG4o6cKzvFqtL
         9WR7bs0WZ6Ad3a0fWi42it7JqRo+76DGO5EiTv86Lf3tZtKAcLh4zzNikHUaVJcKGZAJ
         0ZI/1UdPgYZsvq97pp/kfEMS+p03tZ93z9GqctIccLRXPuWMGNjUUswefUtznv7iFCCF
         QnF6w5thsMGdA1t3Bl1VDkitwCraEos5saRnTPc+XjYtbaMq1SFYY+xU5eDdTCUXeMZB
         Sh0ltuFggqURRW42cmN4vvUXZLSLOQmiaVRb1Kvrq3W2WPOGoLe+N+62kaCbRCJPXnHH
         EorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hKYCOz1erP7YfA3/mb7alNX0KDoyiCbvWc8+lxp/fPQ=;
        b=tRe8tmYXMb62wF0tsmyt6f4HrvGWKIui1P80kf9k407gGu+YbQ7yvuO4tgh4Z4aK6B
         qfLSN4cFLrJTo90NRXF1ivk1PAUzfcxWo7xx3Qu12MKh2w10w56blK/4mIvGnWUpigHM
         f4HeMmJFJK22Alg9nyH08rCUpJ28ebUKOQsGXV8tVHItRDZz/jsXm6evuO2K0WkY1taZ
         Ioqz/0acIfBVfx+cF5k18PkAApMnKLeiwJxbHqYX/SIfud+Xm87y2lX/g82QmA1sjbvr
         0T9lg5uhT0wAUo4mgouIgT/+tgUCcG9G0Fzza/GLAUD37qKRex93ShJbNnIHUO+LRC9Q
         A7VQ==
X-Gm-Message-State: AJIora+9ovSuDo9osj8dupP3/KKoIZY8Re9ryN0HDGphQgxCOH0MNWU8
        5zeLl2FsqY2SnUYhr2Fvk3C7IXyRFPF6RX0lfoThWWn5j0U=
X-Google-Smtp-Source: AGRyM1u69jS2+3BlhjamsN45XiQuYzZR88/EF3cvamMvKUTLdJVZ4CWrbdvxeCwpjq3VJqzAfpRAPhAij7KHY23kX4I=
X-Received: by 2002:a25:d96:0:b0:66e:2d0b:1d45 with SMTP id
 144-20020a250d96000000b0066e2d0b1d45mr1423341ybn.163.1657678245358; Tue, 12
 Jul 2022 19:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220712210603.123791-1-joannelkoong@gmail.com>
 <Ys35McCz+TZEdorp@google.com> <CAJnrk1bVEBXUUjp71+VFaYrRqsDharKRfpvb1theJQ-fP5+EKQ@mail.gmail.com>
 <CA+khW7jL+ajYEBXO_ge5gTHZ9ga+pAAzpvHSjyh+NtK=GL3RXg@mail.gmail.com>
 <CAADnVQKD54uwr0H8od60BAiBDMEoNcOi3fmxYUiDp6G9dzLQNA@mail.gmail.com> <CA+khW7jXs3vUQeRnzikg23Bd37XoZbGxwJswbq9CtNQhjZaejA@mail.gmail.com>
In-Reply-To: <CA+khW7jXs3vUQeRnzikg23Bd37XoZbGxwJswbq9CtNQhjZaejA@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 12 Jul 2022 19:10:34 -0700
Message-ID: <CAKH8qBtZb_u=_kicHkKrsK99HPePzQ0gn4kNfb8YGK8rXOhkzg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Tidy up verifier check_func_arg()
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
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

On Tue, Jul 12, 2022 at 6:39 PM Hao Luo <haoluo@google.com> wrote:
>
> On Tue, Jul 12, 2022 at 6:26 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Jul 12, 2022 at 6:20 PM Hao Luo <haoluo@google.com> wrote:
> > >
> > > On Tue, Jul 12, 2022 at 6:10 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> > > >
> > > > On Tue, Jul 12, 2022 at 3:44 PM <sdf@google.com> wrote:
> > > > >
> > > > > On 07/12, Joanne Koong wrote:
> > > > > > This patch does two things:
> > > > >
> > > > > > 1. For matching against the arg type, the match should be against the
> > > > > > base type of the arg type, since the arg type can have different
> > > > > > bpf_type_flags set on it.
> > > > >
> > > > > Does this need a fixes tag? Something around the following maybe:
> > > > >
> > > > > Fixes: d639b9d13a39 ("bpf: Introduce composable reg, ret and arg types.")
> > > > >
> > > > > ?
> > > > I will add that tag. Thanks!
> > >
> > > Joanne and Stan, IMO this is not necessary. I think this change is a
> > > cleanup rather than a fix.
> >
> > I don't see the bug easier.
> > The helper types that are compared directly as arg_type
> > instead of base_type(arg_type) were all without flags so far.
> > So I don't think the patch changes behavior or fixes anything today.
> > It looks like a good future proofing change though.
> > Am I missing something?
>
> Agree, I mean adding a fixes tag isn't necessary and the patch is
> toward a good direction. As long as the selftests pass on this patch,
> it looks good to me.
>
> Acked-by: Hao Luo <haoluo@google.com>

Perfect, thanks for clarifying! It wasn't clear from the description
so I started looking for where that base_type() came from.
