Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8614573D95
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 22:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiGMUJV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 16:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiGMUJV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 16:09:21 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABFB29CB2
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 13:09:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x91so15538705ede.1
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 13:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b2VeVdcU4uEzY/0GiTyVOLtgvIRRKP3HVi+g8lhOkwU=;
        b=Nij1ydUt8p6qFg6hI4TN4AoM3B+k3ou8v1dEMciMtaYKZc1RWno8PagF5cyHxH7OQh
         YoW46v4gNAa74OnPplFXHYfbUnteB9BILHs0V0faeaeRE9lJwRNlczd3ZzxNe8T20x/t
         fG3U6Hl0dMSzM/G2HUIGux7Z141WV0kvWAI6RA2Glxf3GNCCwmGj/3bc7RNhvWK4LzA2
         U6EY9J6RPlb3xrCtgInuf3tR6pdvNO88EqqcvINITSV3mkgDjVuA5utANEf2hBTEi0+N
         axnlQqiI8chc0ZpG1ZKdFUGzV+fP4QoRNIlIMq/E7ZTkdf4wYa1HeHms23eFnZm/8XTN
         1CIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b2VeVdcU4uEzY/0GiTyVOLtgvIRRKP3HVi+g8lhOkwU=;
        b=2QvEfIeJM8KUv+IWbTbQOv5oFyszbZF7+vsBjAEse6QUy/hFa43rYQYSM6UHc66BaS
         GHYMGODmzeKueDyjJZ7XE4/nkbndvetyAHanqgUkrODqN+rcGKe+YAue8cqQYKd13m2A
         LmYoKdf+W/VE038r49VX9WwZ++tED2zjLsZv2eaBkJTnU8rNFnCRRizpuFO0YouTaYfv
         OuaVdCuXTHrFEVkMDiF3ggzv6cZoXvBOOUp6d1btbsLwhQ4I0lP5NPkIFaKiq26dDjeD
         oZmZZ3n7c0FuyXl7p28wd8VNisfjSBYLSHjsKlN/wZEbqQJ7oPhYTVNm/6mVqjBU2HmK
         fZzQ==
X-Gm-Message-State: AJIora9J4pGo0iqjJlP93f7O4sVbITEfuaac43cbBzRAu0HYRSdhq4Ys
        cK3/gPRwfKHJFH8ukVm3PI242EqBwqOvFWUvFf0=
X-Google-Smtp-Source: AGRyM1sQl+fh+MzXPbufVUlCQdyVc0UXrAtn4ttsgLx5xYoF+e+IBPGjw1RtaYEX5wgCQL60NmON2rLuWHklhkeH/Q0=
X-Received: by 2002:a05:6402:201:b0:431:665f:11f1 with SMTP id
 t1-20020a056402020100b00431665f11f1mr7288271edv.378.1657742958615; Wed, 13
 Jul 2022 13:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220712210603.123791-1-joannelkoong@gmail.com>
 <Ys35McCz+TZEdorp@google.com> <CAJnrk1bVEBXUUjp71+VFaYrRqsDharKRfpvb1theJQ-fP5+EKQ@mail.gmail.com>
 <CA+khW7jL+ajYEBXO_ge5gTHZ9ga+pAAzpvHSjyh+NtK=GL3RXg@mail.gmail.com>
 <CAADnVQKD54uwr0H8od60BAiBDMEoNcOi3fmxYUiDp6G9dzLQNA@mail.gmail.com>
 <CA+khW7jXs3vUQeRnzikg23Bd37XoZbGxwJswbq9CtNQhjZaejA@mail.gmail.com> <CAKH8qBtZb_u=_kicHkKrsK99HPePzQ0gn4kNfb8YGK8rXOhkzg@mail.gmail.com>
In-Reply-To: <CAKH8qBtZb_u=_kicHkKrsK99HPePzQ0gn4kNfb8YGK8rXOhkzg@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Wed, 13 Jul 2022 13:09:07 -0700
Message-ID: <CAJnrk1abjJXcrmpX5h88TjGUCUx5nwKL8dkNEpKUJLu1eDG-GQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Tidy up verifier check_func_arg()
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 7:10 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Tue, Jul 12, 2022 at 6:39 PM Hao Luo <haoluo@google.com> wrote:
> >
> > On Tue, Jul 12, 2022 at 6:26 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Jul 12, 2022 at 6:20 PM Hao Luo <haoluo@google.com> wrote:
> > > >
> > > > On Tue, Jul 12, 2022 at 6:10 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> > > > >
> > > > > On Tue, Jul 12, 2022 at 3:44 PM <sdf@google.com> wrote:
> > > > > >
> > > > > > On 07/12, Joanne Koong wrote:
> > > > > > > This patch does two things:
> > > > > >
> > > > > > > 1. For matching against the arg type, the match should be against the
> > > > > > > base type of the arg type, since the arg type can have different
> > > > > > > bpf_type_flags set on it.
> > > > > >
> > > > > > Does this need a fixes tag? Something around the following maybe:
> > > > > >
> > > > > > Fixes: d639b9d13a39 ("bpf: Introduce composable reg, ret and arg types.")
> > > > > >
> > > > > > ?
> > > > > I will add that tag. Thanks!
> > > >
> > > > Joanne and Stan, IMO this is not necessary. I think this change is a
> > > > cleanup rather than a fix.
> > >
> > > I don't see the bug easier.
> > > The helper types that are compared directly as arg_type
> > > instead of base_type(arg_type) were all without flags so far.
> > > So I don't think the patch changes behavior or fixes anything today.
> > > It looks like a good future proofing change though.
> > > Am I missing something?
> >
> > Agree, I mean adding a fixes tag isn't necessary and the patch is
> > toward a good direction. As long as the selftests pass on this patch,
> > it looks good to me.
> >
> > Acked-by: Hao Luo <haoluo@google.com>
>
> Perfect, thanks for clarifying! It wasn't clear from the description
> so I started looking for where that base_type() came from.
Great, I will leave it as is then. Thanks for the feedback.
