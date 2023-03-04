Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A38C6AAD7D
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 00:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjCDX3j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Mar 2023 18:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDX3i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Mar 2023 18:29:38 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441C4EB78
        for <bpf@vger.kernel.org>; Sat,  4 Mar 2023 15:29:37 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id k10so482302edk.13
        for <bpf@vger.kernel.org>; Sat, 04 Mar 2023 15:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677972576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kh9Y6LOB6WuJJ+jf9OTHaqlAC/UVzCP3YZD7g4dtSEE=;
        b=NKPYaLbc8E/XeRwG1VRdrRqbarMnWEsn9MUhtfNHe81hzbiRRK/Q51OMuyrodC1mRC
         LPBPy7/sdVL7FIqR/w6FEZ34yLKxTsdgZPlqhknzOqi20CJXQE7+uyOaK2jPi6dEQ82k
         O5+FRf4hS5aDLvK6njTxU/urMS5ArGxkGIomQBlwpKQWJvlpj6vEdrz8649upXQ8Nldb
         Fuf8fsHW4aqU4E7TqhN4GNR/Z++LU0W+GETa3GYkY+n04YaDYyTjlCSl2GahsZWvl1Zj
         AvCbuRqRAC/GI+NgqWqZWPqvMy2/yEodM/oKaTwMFy5XmHz2tXOhV4YAZ3+pUjCEQgEN
         2hLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677972576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kh9Y6LOB6WuJJ+jf9OTHaqlAC/UVzCP3YZD7g4dtSEE=;
        b=lL0IriXkHcqHeOyxiyDQoMrjM6d8Z6sCi/0DJ4P1/uFtAinxo6spdAAO3qBM7JSCgi
         wcrdxuprCM6RXZs+vzC4sBxZ/Pt11m+pUvy4EJPoAVAfM2NxQgTJCytlk8Hmfn3sg4pY
         toB6izwFaX8LhqFHDg7fux3FBBeevcWm2MU/VkeWr6qBKyOeCtJqOv3eb/2PRtv7jSOv
         lOvpYsxzbZhWdPKXGKKE/ZI40FHTTyy76ZtGI9Ld7Sss1M08/LuliPa3XE5DTbAD1E1z
         y/FP0t3KGAbBiG299wG0EXJtvfG/6yHe/hndyyiT9ry2dzZ0M65YYzSgxIobQzVoHmZ1
         cxoA==
X-Gm-Message-State: AO0yUKXEr2jeY1lW2MbVN+BcH/JG6q55mdP8LW0YKVYB/TWRA5ZfP8Cf
        5aDI5EYfkfRyrFsmbtgxKRG9wvx48nmSdq9lCCPzid00
X-Google-Smtp-Source: AK7set/yMsuOK++RslCJClYvqQQADA48vPHcy33MF0gattyWdliVi6ZLBdD3+X9LvnPrGOrYHBx3qtInn8EJ6FkEYN4=
X-Received: by 2002:a17:906:cccf:b0:88d:64e7:a2be with SMTP id
 ot15-20020a170906cccf00b0088d64e7a2bemr2964738ejb.15.1677972575683; Sat, 04
 Mar 2023 15:29:35 -0800 (PST)
MIME-Version: 1.0
References: <20230302235015.2044271-1-andrii@kernel.org> <20230302235015.2044271-17-andrii@kernel.org>
 <20230304203900.2eowyut62ptvgcsq@MacBook-Pro-6.local>
In-Reply-To: <20230304203900.2eowyut62ptvgcsq@MacBook-Pro-6.local>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 4 Mar 2023 15:29:23 -0800
Message-ID: <CAEf4BzbrPGPKZSxen4AKc9WDXM0+mutOSR7xeHOtENsFT7JM4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 16/17] selftests/bpf: add iterators tests
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 4, 2023 at 12:39=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 02, 2023 at 03:50:14PM -0800, Andrii Nakryiko wrote:
> > +
> > +#ifdef REAL_TEST
>
> Looks like REAL_TEST is never set.
>
> and all bpf_printk-s in tests are never executed, because the test are 'l=
oad-only'
> to check the verifier?
>
> It looks like all of them can be run (once printks are removed and conver=
ted to if-s).
> That would nicely complement patch 17 runners.
>

Yes, it's a bit sloppy. I used these also as manual tests during
development. I did have an ad-hoc test that attaches and triggers
these programs. And I just manually looked at printk output in
trace_pipe to confirm it does actually work as expected.

And I felt sorry to drop all that, so just added that REAL_TEST hack
to make program code simpler (no extra states for those pid
conditions), it was simpler to debug verification failures, less
states to consider.

I did try to quickly extend RUN_TESTS with the ability to specify a
callback that will be called on success, but it's not trivial if we
want to preserve skeletons, so I abandoned that effort, trying to save
a bit of time. I still want to have RUN_TESTS with ability to specify
callback in the form of:

static void on_success(struct <my_skeleton_type> *skel, struct
bpf_program *prog) {
    ...
}

but it needs more thought and macro magic (or something else), so I
postponed it and wrote simple number iterator tests in patch #17.

> It can be a follow up, of course.

yep, let's keep bpf_printks, as they currently serve as consumers of
variables, preventing the compiler from optimizing loops too much.
This shouldn't be a problem for verification-only kind of tests. And
then with RUN_TESTS() additions, we can actually start executing this.

>
> Great stuff overall!

Thanks!
