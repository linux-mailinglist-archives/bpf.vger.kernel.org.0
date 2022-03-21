Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D21B4E3456
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 00:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiCUXbe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 19:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiCUXbc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 19:31:32 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8A03696D6
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:30:04 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id k25so18460818iok.8
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WdCZ5QhYxzqFF/9Pjw1sMTWxZ3HXKlswKjhIEVciUsg=;
        b=fYk6iwJbCMv0IeB/NHRLHOg29pwtrEGl6Ry1XlGhjj0pNLeNFOet9arpKjiAyNY086
         rgH8cEnIQJ1xvLcgJFj2eJCWcoonx5lIY/V66suJH1CH92iCSivkPsU4Wj4+zWdDFuYG
         tzld7mxiWVwH39s7q638fhLVji3wPGWa69+TMOdfgvybD/YVtVf9GZDA2DVjaq0WjzgR
         62wbotm941STdYRx1BoKPDj6JEp+lsljfJEwGFMulkZaZRJGF27BFBGSvf0PBTRzRcuD
         sevtH9KDujUaVN0YAC3y2UVQJgSh/8krKekDbOjq8+QSMW/1sj25hZ3J5DZgtc746hxt
         mPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WdCZ5QhYxzqFF/9Pjw1sMTWxZ3HXKlswKjhIEVciUsg=;
        b=wJJvCKQXLLBqlPFYgTwNIKs1e72bYZyq8Mng/79deaDP6gnesCWiYEVDA80Xfb1D0I
         hdazdUjMZST/z8QOLeyhJcbnIV/a4kPJyY4xZkW7x3zJ9eAesjvlirbi7/iRR5YuQhzO
         Z6j0BYjN0DQeg9nC6NcKQthfw0VEOxwml++jF3o31yGcyk27Hy/DKQGb88yjyhLu51z/
         JWSHrVIQrI590Z9jkYVebQCy6eMEadic1YC9O/rQqlMHbsbMczVNq4MUUqMouyAcD3zS
         RP+5i81wRjmnW9s+xvCL3JtgX4NFOJ2kgqMA717CjMmEipYZX8EoeVKgF6MSJfWo/J4P
         9eWw==
X-Gm-Message-State: AOAM530/nKTEKp8AtysAkhFHPT5V8hp3L+KBA86fwkGnV//5DFJ2bjHu
        SAxTs9e1PML4rodMIHCIjL8N/VeQsmIchQ3mahw=
X-Google-Smtp-Source: ABdhPJxD15t8LvCZkeqIaCD43taf5NlqJUZ3C9KeRlWDQih3WQSVko7fsVa/lJlLFRgcbhTnmu4B++GZ4+I/+nAIyoQ=
X-Received: by 2002:a05:6638:772:b0:319:e4eb:adb with SMTP id
 y18-20020a056638077200b00319e4eb0adbmr12081274jad.237.1647905403137; Mon, 21
 Mar 2022 16:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220316004231.1103318-1-kuifeng@fb.com> <20220316004231.1103318-5-kuifeng@fb.com>
 <20220318192114.pacmegfl3uglju6l@ast-mbp> <6443c7fc6801f57d485d61d846bafda69f7cde73.camel@fb.com>
In-Reply-To: <6443c7fc6801f57d485d61d846bafda69f7cde73.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 21 Mar 2022 16:29:52 -0700
Message-ID: <CAEf4BzY9oqfkG4J7SmQaosVmccq_cFn8qboa8dfwg9tfmDVwkg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] selftest/bpf: The test cses of BPF cookie
 for fentry/fexit/fmod_ret.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Sun, Mar 20, 2022 at 1:44 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> On Fri, 2022-03-18 at 12:21 -0700, Alexei Starovoitov wrote:
> > On Tue, Mar 15, 2022 at 05:42:31PM -0700, Kui-Feng Lee wrote:
> > >
> > > +SEC("fentry/bpf_fentry_test1")
> >
> > Did we discuss whether it makes sense to specify cookie in the SEC()
> > ?
> >
> > Probably no one will be using cookie when prog is attached to a
> > specific
> > function, but with support for poor man regex in SEC the cookie
> > might be useful?
> > Would we need a way to specify a set of cookies in SEC()?
> > Or specify a set of pairs of kernel_func+cookie?
> > None of it might be worth it.
>
> It makes sense to me to provide a way to specify cookies in the source
> code of a BPF program.

I think it's not worth it. Think about this, if you have two fentry
programs with the same logic and you are able to *statically* define
two different cookies at compile time, the easy way to do this is:

static int my_logic(__u64 cookie) { /* do something smart that depends
on cookie value */ }

SEC("fentry/func1")
int BPF_PROG(handle_func1, ...) { return my_logic(123); }

SEC("fentry/func2")
int BPF_PROG(handle_func2, ...) {return my_logic(456); }

BPF cookie was added specifically for cases when this value is *only
known at runtime* and it's impractical/impossible to somehow embed it
into BPF program code. Let's not overcomplicate this, at least until
there is a strong use case for this.

> However, it could be a very complicated syntax and/or difficult to
> read.
> Kernel_func+cookie, even Kernel_func_pattern+cookie, pairs are easy to
> understand.
> For more complicated cases, giving cookies at user space programs would
> be a better choice.
>
