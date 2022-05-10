Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8838B5227B9
	for <lists+bpf@lfdr.de>; Wed, 11 May 2022 01:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236979AbiEJXkO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 19:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbiEJXkN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 19:40:13 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70154A3F1
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 16:40:12 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h85so390307iof.12
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 16:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HXtRybYckISTRpci33G1yAk25EH6RBZLjaPBJIavgKI=;
        b=BF6ma3Yeo0IiWEVCZEN52zLYtPkOdU01JbJ20rm3MEMvlIB5YjFgFXVNYxuYWgRAVs
         i251DHUVZ+8qGxsLovDX3++Z3KNJb1i6qT3GXIHYEP7TGzCqh/D5e2F0AmZgO2Bn2NCX
         OvY5YvDX/z548j/PDLYRJQJmMPhMJ2w1PhdzA6vB1LQ6rPTvi5xgY+2zNj/vZqUiEo/w
         IRi0j7thIPZUStbNgxfY55VHAFa1aAmsIhbK2N+Z8jDiCzt7HljvuBk3RSVJOy6DYhot
         mRwN9IOEEcYNrtiRt17NZQy6LoU61Gqui2cp4hSeI2SRIAFykp0HqdR6uE5EMT9Us2Uv
         477w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HXtRybYckISTRpci33G1yAk25EH6RBZLjaPBJIavgKI=;
        b=G+71cLtFHNuAuF0y9RDNy8gB6X7irP91wWVkTW36mejBb12LAEF4cZHOtVA1V3+Oop
         drbEDnZbODUTq0sSAreDUyTuGZWM4rOy5fHxDEhl5aLtioO1EIz0WqXWpwsU2uaNvfgg
         vZRpiKmHSH/zQsy4bjrZv2qYQCETt3VEI300c4vjv8Gvq15iiHN9wF3ZwyPJ2uPbM3jY
         RTzMIJ3Tzv/6r55s0Zrz24zEfJTwxqkMzZ3Af2sLU1rq79Of7IBHSCay8JJFrlcfFwxN
         lO2sI/5HzYHvzmV8z0zViKAjyRm5Oomv73N5CoHaRzHmQI3jDY4OFR+OoaaO4yiZETUi
         bpWw==
X-Gm-Message-State: AOAM530+qSSCzOgRvUZbjFnPf/UB7nraiBWm0z4lkjbs/Et2aCq4sXzO
        XrtYRUK5gDDEIFbPA+s3bw8XsunQ4og9kTT4btI=
X-Google-Smtp-Source: ABdhPJxpGa4fMdWrJJhUrDhDfGpwKbhV5qdh6Td+Xve89x0xgugNfh6qqUOefN661Ai8JpyjnXsgVSeqpBGdZsiIaLE=
X-Received: by 2002:a02:5d47:0:b0:32b:4387:51c8 with SMTP id
 w68-20020a025d47000000b0032b438751c8mr11139663jaa.103.1652226012133; Tue, 10
 May 2022 16:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220501190002.2576452-1-yhs@fb.com> <20220501190023.2578209-1-yhs@fb.com>
 <CAEf4BzbXuN4YOYqm_ojgTuJMo4a+J_M6WPF=MUX1B9BK8DdmMQ@mail.gmail.com>
 <f9fa3310-0f63-18af-5424-b82df11c4a70@fb.com> <33fb48e5-ed62-cd2d-cedf-71860912143f@fb.com>
In-Reply-To: <33fb48e5-ed62-cd2d-cedf-71860912143f@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 May 2022 16:40:01 -0700
Message-ID: <CAEf4BzYOGkhMHBcX1qXK3fu1JQb68oDvw8=yUjPhiyz-adS6yg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/12] libbpf: Add btf enum64 support
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 10, 2022 at 4:02 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 5/10/22 3:40 PM, Yonghong Song wrote:
> >
> >
> > On 5/9/22 4:25 PM, Andrii Nakryiko wrote:
> >> On Sun, May 1, 2022 at 12:00 PM Yonghong Song <yhs@fb.com> wrote:
> >>>
> >>> Add BTF_KIND_ENUM64 support. Deprecated btf__add_enum() and
> >>> btf__add_enum_value() and introduced the following new APIs
> >>>    btf__add_enum32()
> >>>    btf__add_enum32_value()
> >>>    btf__add_enum64()
> >>>    btf__add_enum64_value()
> >>> due to new kind and introduction of kflag.
> >>>
> >>> To support old kernel with enum64, the sanitization is
> >>> added to replace BTF_KIND_ENUM64 with a bunch of
> >>> pointer-to-void types.
> >>>
> >>> The enum64 value relocation is also supported. The enum64
> >>> forward resolution, with enum type as forward declaration
> >>> and enum64 as the actual definition, is also supported.
> >>>
> >>> Signed-off-by: Yonghong Song <yhs@fb.com>
> >>> ---
> >>>   tools/lib/bpf/btf.c                           | 226 +++++++++++++++++-
> >>>   tools/lib/bpf/btf.h                           |  21 ++
> >>>   tools/lib/bpf/btf_dump.c                      |  94 ++++++--
> >>>   tools/lib/bpf/libbpf.c                        |  64 ++++-
> >>>   tools/lib/bpf/libbpf.map                      |   4 +
> >>>   tools/lib/bpf/libbpf_internal.h               |   2 +
> >>>   tools/lib/bpf/linker.c                        |   2 +
> >>>   tools/lib/bpf/relo_core.c                     |  93 ++++---
> >>>   .../selftests/bpf/prog_tests/btf_dump.c       |  10 +-
> >>>   .../selftests/bpf/prog_tests/btf_write.c      |   6 +-
> >>>   10 files changed, 450 insertions(+), 72 deletions(-)
> >>>
> >>
> [...]
> >>
> >>
> >>> +       t->size = tsize;
> >>> +
> >>> +       return btf_commit_type(btf, sz);
> >>> +}
> >>> +
> >>> +/*
> >>> + * Append new BTF_KIND_ENUM type with:
> >>> + *   - *name* - name of the enum, can be NULL or empty for anonymous
> >>> enums;
> >>> + *   - *is_unsigned* - whether the enum values are unsigned or not;
> >>> + *
> >>> + * Enum initially has no enum values in it (and corresponds to enum
> >>> forward
> >>> + * declaration). Enumerator values can be added by
> >>> btf__add_enum64_value()
> >>> + * immediately after btf__add_enum() succeeds.
> >>> + *
> >>> + * Returns:
> >>> + *   - >0, type ID of newly added BTF type;
> >>> + *   - <0, on error.
> >>> + */
> >>> +int btf__add_enum32(struct btf *btf, const char *name, bool
> >>> is_unsigned)
> >>
> >> given it's still BTF_KIND_ENUM in UAPI, let's keep 32-bit ones as just
> >> btf__add_enum()/btf__add_enum_value() and not deprecate anything.
> >> ENUM64 can be thought about as more of a special case, so I think it's
> >> ok.
> >
> > The current btf__add_enum api:
> > LIBBPF_API int btf__add_enum(struct btf *btf, const char *name, __u32
> > bytes_sz);
> >
> > The issue is it doesn't have signedness parameter. if the user input
> > is
> >     enum { A = -1, B = 0, C = 1 };
> > the actual printout btf format will be
> >     enum { A 4294967295, B = 0, C = 1}
> > does not match the original source.
>
> I think I found a way to keep the current btf__add_enum() API.
> Initially, the signedness will be unsigned. But during
> btf__add_enum_value() api calls, if any negative value
> is found, the signedness will change to signed. I think
> this should work.
>

Oops, didn't see this email when replying. Yeah, I guess this approach
will work for 32-bit enum. For 64-bit one we probably better specify
signedness explicitly and then accept __u64 as the value (which can be
negative value casted to __u64, in practice).

> >
> >>
> >>> +{
> >>> +       return btf_add_enum_common(btf, name, is_unsigned,
> >>> BTF_KIND_ENUM, 4);
> >>> +}
> >>> +
> >>
> >> [...]
> >>
> [...]
