Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24F04FED7D
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 05:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiDMD0P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 23:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiDMD0O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 23:26:14 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A664434A0
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 20:23:55 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id 125so503625iov.10
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 20:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HHcoJlAi0yAUlpt8atl5LqZ5nqQTkIWErhY/s38PhDY=;
        b=Oeaqu1L8UH6PsapMGFVS7RDo/CasfDikvV5+Vbf39uFeb1+5fYZUH1stwS8aPIHthR
         ISd5RVqWn+O+1J6kkIk1M6FJE80SKa7BeYU117T+RuXczgCQYTp0Grcmn07v5paM9tgY
         zm4xAzoRRdl90fezqu2q2wXZQAFmr3ypRr8Zp1kIdYArNPazMyDsp6ZaQGqE2qhQtO4a
         tVTeESvnxRhkJVsbYZW9Vy5kzxbYU+yVed2jP3WlVEEcNPs+kUP7jATFv0/SFRf0mOCq
         bIye8lDM4sz8qkgkAfKmY59cK/1ZWbYuqIhlm5Q7/vg54nCVbn59bPYX2VF/MkOdFiI5
         EFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHcoJlAi0yAUlpt8atl5LqZ5nqQTkIWErhY/s38PhDY=;
        b=1NAVMJHcaIaYbTARZ0rjVgd2I3HBM4cjtUHeCXmrnx243t3vpN5gUoMJlpbjyILePH
         +gvYfjfN5/17L03OPh1QQPUcRIqZDim/VFALLdCNP0TH3JgioZhAwEK0PgXCTnDrLkyH
         uUPyqhWBf3+9f5i1hIzqdaGDUSEdn0JIm+tmnaI1WIdushqUFQetRdymk/R6aEAzuHTv
         jVx/a8xTZcjnHPxzp0CYPBTEoTF7OZeA5VPUWTVcy7MibWgmFZFzeqaRB6lNWRgKqoHM
         p+UAT2pv1Uox+8PgL6NuaDN5oUSh+ppahtbovmvOc/ycCfOXVe4Y+tU1coVx52oMFnj4
         hQEg==
X-Gm-Message-State: AOAM532RZeHAIH4iZpcdLLQVcIJuk5Xabvk1l6UJlCRc4uuyO70pjsp9
        2hyCEv5F/1/0LR7cz0znUKE/TbrAC6z3G/c5gKzdlov7
X-Google-Smtp-Source: ABdhPJxlIXNDDnrsqY9hefNzi0CvDe7rF8+EKl/yLWJkAtXKPf6ChjSZr6JIANyPlbH1n624jBl8jveKY6EH+GADWzg=
X-Received: by 2002:a05:6638:2642:b0:323:756f:42a7 with SMTP id
 n2-20020a056638264200b00323756f42a7mr19950932jat.145.1649820234850; Tue, 12
 Apr 2022 20:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220406004121.282699-1-memxor@gmail.com>
In-Reply-To: <20220406004121.282699-1-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 Apr 2022 20:23:44 -0700
Message-ID: <CAEf4BzbUnyZcNU8SuQMTFSbsye05hgcTOq7CFZGvhF3PqA_GAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/2] Ensure type tags are always ordered first
 in BTF
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Tue, Apr 5, 2022 at 5:41 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> When iterating over modifiers, ensure that type tags can only occur at head of
> the chain, and don't occur later, such that checking for them once in the start
> tells us there are no more type tags in later modifiers. Clang already ensures
> to emit such BTF, but user can craft their own BTF which violates such
> assumptions if relied upon in the kernel.
>
> Kumar Kartikeya Dwivedi (2):
>   bpf: Ensure type tags precede modifiers in BTF
>   selftests/bpf: Add tests for type tag order validation
>
>  kernel/bpf/btf.c                             | 51 +++++++++++++
>  tools/testing/selftests/bpf/prog_tests/btf.c | 77 ++++++++++++++++++++
>  2 files changed, 128 insertions(+)
>
> --
> 2.35.1
>

Yonghong, can you please take a look?
