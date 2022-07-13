Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA86572AF6
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 03:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbiGMBj3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 21:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbiGMBjI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 21:39:08 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E807DD217D
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 18:39:06 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id j27so308292qtv.4
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 18:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9tGIdYlpVxnM8b3rWqBQlHbDLwVsAz+2826iRXvItdE=;
        b=qQVsKajbOccdFVYFE5rOsCTPl0xY7YYjsJ5LYlaeAKjgUBhc7DhuRgCeLw0JE2RMl+
         kTzZ1pK2XIVj2vsxLxXRTU2SGi15GZX0USX4AEeUOrqVrLTU0hxlmShrHd7EOFA6o4Kg
         fClxu1mEuHjpgZRLqilXsSzhLYxFN5bP61RjxJ57MVwGSB2L8f6SUqhDnP4gnLBfIM7l
         pZ2m2n/CB6Vl1cxe90Q3F73ymOmIYfZxSZtDO7LhnEeaCwnD3SjQ0mOj1tj8v3IBYX2G
         r0A6wz5babietLjHOv6Zr/K/M9OZ4nXqeLV9tieQktipdwcZMcNjhWDmPWFNviV/yMKD
         dO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9tGIdYlpVxnM8b3rWqBQlHbDLwVsAz+2826iRXvItdE=;
        b=h8p7Cjrh48qfKo7fjB5ORpQ65kB9e24YCIUerptyXPoMaFSaZmSMTQwkaK45ZagRL/
         bDWMMAx3yKKj024mcyPlgHMPRq/qoo58a99t8A+SVmP8Ab1K1iTCgwbuRnlekpXF5blM
         gfpqiGQXjkm7aJj70xqq1/wCHnGbMdiEJUTErU+dp6joOzsbELUw8elo+hzCXKffUbXw
         Ol7BpWJ0CUAngIqehVUUNpnQT+FQho5t3D8EayFTBVhU0yyu/OOwhewuioxt7WfymiGn
         RxCpVW3Hsirqf+QVV7fCrxpaX1Vt35JhgG3CwL9FL0w98oJxzTgEx+oohp8fPdMSaaMz
         5WoQ==
X-Gm-Message-State: AJIora+RhyIS5Ywu2J8wJrvxpEOWugAAE0ZGhzqgBZR7OBhO7wKXddO7
        RlrVJH7glZVBwbcWYxofd6OFQnTbQAFH0gmr1WMznw==
X-Google-Smtp-Source: AGRyM1tuuo5OAYPhQf2exQxCw07+wFaHPBUNDpQkRh6/rK4aiMmARjQXV+wU7IVlqv7Z7kk0nGYjqdM5U0A1fwz9NeA=
X-Received: by 2002:a05:622a:1901:b0:31e:bb55:dc44 with SMTP id
 w1-20020a05622a190100b0031ebb55dc44mr894628qtc.168.1657676345969; Tue, 12 Jul
 2022 18:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220712210603.123791-1-joannelkoong@gmail.com>
 <Ys35McCz+TZEdorp@google.com> <CAJnrk1bVEBXUUjp71+VFaYrRqsDharKRfpvb1theJQ-fP5+EKQ@mail.gmail.com>
 <CA+khW7jL+ajYEBXO_ge5gTHZ9ga+pAAzpvHSjyh+NtK=GL3RXg@mail.gmail.com> <CAADnVQKD54uwr0H8od60BAiBDMEoNcOi3fmxYUiDp6G9dzLQNA@mail.gmail.com>
In-Reply-To: <CAADnVQKD54uwr0H8od60BAiBDMEoNcOi3fmxYUiDp6G9dzLQNA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 12 Jul 2022 18:38:54 -0700
Message-ID: <CA+khW7jXs3vUQeRnzikg23Bd37XoZbGxwJswbq9CtNQhjZaejA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Tidy up verifier check_func_arg()
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
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

On Tue, Jul 12, 2022 at 6:26 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jul 12, 2022 at 6:20 PM Hao Luo <haoluo@google.com> wrote:
> >
> > On Tue, Jul 12, 2022 at 6:10 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> > >
> > > On Tue, Jul 12, 2022 at 3:44 PM <sdf@google.com> wrote:
> > > >
> > > > On 07/12, Joanne Koong wrote:
> > > > > This patch does two things:
> > > >
> > > > > 1. For matching against the arg type, the match should be against the
> > > > > base type of the arg type, since the arg type can have different
> > > > > bpf_type_flags set on it.
> > > >
> > > > Does this need a fixes tag? Something around the following maybe:
> > > >
> > > > Fixes: d639b9d13a39 ("bpf: Introduce composable reg, ret and arg types.")
> > > >
> > > > ?
> > > I will add that tag. Thanks!
> >
> > Joanne and Stan, IMO this is not necessary. I think this change is a
> > cleanup rather than a fix.
>
> I don't see the bug easier.
> The helper types that are compared directly as arg_type
> instead of base_type(arg_type) were all without flags so far.
> So I don't think the patch changes behavior or fixes anything today.
> It looks like a good future proofing change though.
> Am I missing something?

Agree, I mean adding a fixes tag isn't necessary and the patch is
toward a good direction. As long as the selftests pass on this patch,
it looks good to me.

Acked-by: Hao Luo <haoluo@google.com>
