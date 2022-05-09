Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9345A520992
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 01:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiEIXrw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 19:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiEIXrQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 19:47:16 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899DC25F7B0
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 16:39:10 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id z18so16990229iob.5
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 16:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uWKJn8DHkZVw+edUk9BtXDRC9Lic4cQCQSdWRvgJWqQ=;
        b=IKoH+ZAEbw/jmLAae049xyMyrX83Ua5VZXuit3UPLbhi9IZ8Ap6a/kbHJoTSKK9zdy
         WYSNiDNXmeeLadufM7A8/rCEOCqMLGmbYaiGyuR8zoTyB9hfmGgVqGW+Cw3gelhlSaa8
         fuFrj/YKxI+tN5SEbLzxeaneWBKQ0IMZxxmuMvP+Y5AozHGfdue6DLl95dMIvxzdYJ5a
         /bzXC8mSc+mYe8Kf/87GYZD4eXvyDPmzo4GVTkdnW7riFJwPX5M61OA4t01NszpW8V1j
         VqNVkrqR6rsW4pxFj6IVG0tgGcdWNE0jotKmvmrq414psdC++Dv5grv7SWD6KVZDndgV
         jYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uWKJn8DHkZVw+edUk9BtXDRC9Lic4cQCQSdWRvgJWqQ=;
        b=jRTejz3Oqw3aqYHAr4G2CGRJI3mmPjf/ZkaH4JZ5CPflbEF878K+1UfB2WYAXJ5ONC
         6Q17ty1OuPP+gVtStscBDj/1a0uxZSzR07u5IrcJc0SoCDue+8wB8EU1AxAvpapSML4o
         HuweFNQUkZFr/ccGqTJBGJLOKQtMoKUGOyB95XMAusy8iIyRRATNqNAO5EUb1rhN1BeD
         qz4NDFu7zGU5i/sNliRntMuO3fmZpU71YbGYRJxxc7eV5saHeqqmjjqJU5hfWyOhNs2u
         lGh5dXHoJJ+oHp7Nm6AbWEhcwTWu0dRwqRH4+L64PTHC6/JVAr8eAuv4UiFPj+GHSN+n
         Ac/Q==
X-Gm-Message-State: AOAM532hnO0gA2eIQEhVX7KFD4hEXNXiEIwWTp3JfVp+iedqmA+gIXke
        xkrNYKwuV94wJAu2QjJFMI+OBKlCuwpLQWK3e64=
X-Google-Smtp-Source: ABdhPJxRjDmw5mtlq4iv/eVwaw1QrSngVkkGOMMCc9SGEaT9LR/8SEQLh2Z1BwAAoO455nuYGdJPfRqnVrQbBNMN4xc=
X-Received: by 2002:a05:6602:2acd:b0:65a:9f9d:23dc with SMTP id
 m13-20020a0566022acd00b0065a9f9d23dcmr7350846iov.154.1652139549972; Mon, 09
 May 2022 16:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220501190002.2576452-1-yhs@fb.com> <20220501190054.2580458-1-yhs@fb.com>
In-Reply-To: <20220501190054.2580458-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 16:38:59 -0700
Message-ID: <CAEf4BzbiuoCOh0MFvh5CSPV1W+tVM6u0og6twNZ4wqpvSdWL7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 10/12] selftests/bpf: add a test for enum64 value relocation
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Sun, May 1, 2022 at 12:01 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add a test for enum64 value relocations.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Looks good, but can you also add some signed enums for testing?

>  .../selftests/bpf/prog_tests/core_reloc.c     | 43 +++++++++++++++
>  .../bpf/progs/btf__core_reloc_enum64val.c     |  3 ++
>  .../progs/btf__core_reloc_enum64val___diff.c  |  3 ++
>  .../btf__core_reloc_enum64val___err_missing.c |  3 ++
>  ...btf__core_reloc_enum64val___val3_missing.c |  3 ++
>  .../selftests/bpf/progs/core_reloc_types.h    | 47 ++++++++++++++++
>  .../bpf/progs/test_core_reloc_enum64val.c     | 53 +++++++++++++++++++
>  7 files changed, 155 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val.c
>  create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val___diff.c
>  create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val___err_missing.c
>  create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val___val3_missing.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_core_reloc_enum64val.c
>

[...]
