Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4251A44BA11
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 02:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbhKJBvm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Nov 2021 20:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhKJBvm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Nov 2021 20:51:42 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876D6C061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 17:48:55 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so242297pju.3
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 17:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=93sZVovcNDwmSjAyB0+40v6/g8slA/ul0Jt9gvdxqJU=;
        b=Rh0xSCXxiwrHe9tBifWAwzNnRZj8SMGY/KFA9ITHqMr6GXmDFCiUhS9VcfiXFoK2xf
         fmgWQq25C/A5WmgFvJCV1mVFiSSZdy1g//dpyg4E5aAM76T6o8ljVgaqLwRuFw1JFfr8
         CZsdC9+kLzIMfa/9HjFXfmQGSFDMh8QVKG0tHHvwlJcP8GKZbmbNqv3GmX1TZwCxd9rd
         z2UXSXwqxdxrL8HoOSYKoPrgncELuXaJTwFywggXuRnrqlztsPhMeh4nQvukn7B87SkD
         HEydNtl86zbmvtBFevWujbKa0PYnvvePH2+9yROrgi9lG5DSE+cJ+jvGZKyaklaX5e60
         6nUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=93sZVovcNDwmSjAyB0+40v6/g8slA/ul0Jt9gvdxqJU=;
        b=RDEM4oNwfmqND6KiwvQ1ehE7aV2FVMQixVz9PKtvQAyhNJNJG0Q8C1duEEDI+90B3+
         wZ+ojmo2TefmcpBaf3oirNSh1bQEIv61rESVK6NQ5cu+7xi/SynCukaBgQazaU8BV68u
         Ow/pewpk4t7MyemzrE+cBK0y0YKA62yL5ZEbW5MkL9z+C0geOadL4XDiaHGls/6ddB1F
         dwycyJ6ESS1L0xzrvIeJFq8Z/EXOSktw2fskAso9pLlyqsAO7tRylOjKQoMOCdmTWcBa
         SVoCGsLy4pc+T6GJ4dgrmjUt8OxOnWpeT8D4iQByIUYu1GhUJdUcqY5jXBTV6Ix2mdVP
         JuoA==
X-Gm-Message-State: AOAM5308Zvd5IQs9Dpu5DH2e8O/Xc4SP29thqMRtx6NXtOm5AiyNA8JT
        2XHAhqlpdz5viOfuXzFHyu0VEZ1IjH37G/IkVZo=
X-Google-Smtp-Source: ABdhPJxmI3UTRGzKfPdAFo4BOnqILjgXpbQHhCSutI05pY3dASA/jWPZb6B2uN99kVR2s+xO/xDDqSHPn4GD9+AwooI=
X-Received: by 2002:a17:902:d491:b0:142:892d:a89 with SMTP id
 c17-20020a170902d49100b00142892d0a89mr12024381plg.20.1636508934950; Tue, 09
 Nov 2021 17:48:54 -0800 (PST)
MIME-Version: 1.0
References: <20211103220845.2676888-1-andrii@kernel.org> <20211103220845.2676888-11-andrii@kernel.org>
In-Reply-To: <20211103220845.2676888-11-andrii@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Nov 2021 17:48:44 -0800
Message-ID: <CAADnVQKZf+k0=+Yees92nuWQa4NKxMR_XrfRDvuCOUYUZ3p0dQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 10/12] selftests/bpf: merge test_stub.c into testing_helpers.c
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 3, 2021 at 3:09 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Move testing prog and object load wrappers (bpf_prog_test_load and
> bpf_test_load_program) into testing_helpers.{c,h} and get rid of
> otherwise useless test_stub.c. Make testing_helpers.c available to
> non-test_progs binaries as well.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
...
> -int extra_prog_load_log_flags = 0;
> -
> -int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
> -                      struct bpf_object **pobj, int *prog_fd)
> -{
> -       struct bpf_prog_load_attr attr;
> -
> -       memset(&attr, 0, sizeof(struct bpf_prog_load_attr));
> -       attr.file = file;
> -       attr.prog_type = type;
> -       attr.expected_attach_type = 0;
> -       attr.prog_flags = BPF_F_TEST_RND_HI32;
> -       attr.log_level = extra_prog_load_log_flags;
> -
> -       return bpf_prog_load_xattr(&attr, pobj, prog_fd);
> -}

> +int extra_prog_load_log_flags = 0;
> +
> +int bpf_prog_test_load(const char *file, enum bpf_prog_type type,
> +                      struct bpf_object **pobj, int *prog_fd)
> +{
> +       struct bpf_object *obj;
> +       struct bpf_program *prog;
> +       int err;
> +
> +       obj = bpf_object__open(file);
> +       if (!obj)
> +               return -errno;
> +
> +       prog = bpf_object__next_program(obj, NULL);
> +       if (!prog) {
> +               err = -ENOENT;
> +               goto err_out;
> +       }
> +
> +       if (type != BPF_PROG_TYPE_UNSPEC)
> +               bpf_program__set_type(prog, type);
> +
> +       err = bpf_object__load(obj);
> +       if (err)
> +               goto err_out;
> +
> +       *pobj = obj;
> +       *prog_fd = bpf_program__fd(prog);
> +
> +       return 0;
> +err_out:
> +       bpf_object__close(obj);
> +       return err;
> +}

Andrii,
That part of the commit broke verbose output in the test.
-v and -vv no longer work for tests that use bpf_prog_test_load()
because extra_prog_load_log_flags are ignored.

Please fix.
