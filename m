Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BE76EFB17
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 21:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239359AbjDZT1r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 15:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbjDZT1q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 15:27:46 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AA31FE6
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:27:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-507bdc5ca2aso13319270a12.3
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 12:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682537264; x=1685129264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvTcalYaj21YYy9Kv0V+9yTDYudEE1Vl77K0LtelASc=;
        b=Zvt4wq1uQunLp3WngUSwpZ7tgS8bpzyNwYLRSmNUbLyyij5czco1uufQYgEgAo81S2
         W1yKs9je3lO3eGodXmfOY8BlCxmmUKTLFOq0zO9NZphmH+VUp3/cESuSKSnMSjZN8/B+
         3OMhwHiry4bm5LVoIN4HKQkjbmWKKa3LV81EXq/0jJi4faE+yNU4b41aQrBQjlf735rq
         4VefQqgbFrBw8O54OiJbr8OF4gd5DFYbO7CjQqLV76NnyXCqKmX78zw/rLVBtSCZQtoS
         Fa2uPbZav2NqzRqZUKdNKE4FE0AIIRld4IAnTgp/R/VEZkKcG0+TnCVJLdDjnuRil6if
         QISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682537264; x=1685129264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvTcalYaj21YYy9Kv0V+9yTDYudEE1Vl77K0LtelASc=;
        b=OnAvJvT766tnu06zQ98z9LkOS/AnsS1lNoXRLo8+i63qiAwirxYkrASFff+UGXQgcM
         0D61d0W93pA7zo1icXoMCwdk8V9JvKTRONuMjeg3huEjKWbuUmrZGpBjvVAUUdnQREzT
         MQo2NDq8QJADsj7FYMkLTLqcIfK3jWaKuwXwScYtVJlgpfAZ8pebUWqZY72IMFSqI287
         MQw2baBOBSrtJo0CuBubbbgxDjdrnkXKBOrE7M+9QkY58AcycuXxOLh192C3gcRNt3bf
         oEgKztp2i5/UXBuRwWERjVsvUVuPD6Q63J1hlJ9J1SfgKRyiLDcJ74rUvC26bc13h/wA
         LX6Q==
X-Gm-Message-State: AAQBX9dSIawtLGYdaX30nKamC1IlhLzazBooQJWsuNGileRTQ28dA6Am
        bV45tdtHtbVpgsP0bYOeOAKceIhwSd2EnhCFsZhT8DKv
X-Google-Smtp-Source: AKy350bDcZatDv7OBVazk5y523JCr/GgZJxG0PB3mLOQxFF17ihMttmS6i5PXjktlTO7etKK2LWYULyZJEHCc60Xy7g=
X-Received: by 2002:aa7:d897:0:b0:506:87cb:149f with SMTP id
 u23-20020aa7d897000000b0050687cb149fmr17931678edq.39.1682537263576; Wed, 26
 Apr 2023 12:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230424160447.2005755-1-jolsa@kernel.org> <20230424160447.2005755-7-jolsa@kernel.org>
In-Reply-To: <20230424160447.2005755-7-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Apr 2023 12:27:31 -0700
Message-ID: <CAEf4Bza8L7YKbVvNAsRn_RDKx8PuHYZpO7HSWuZuubioEsEmbQ@mail.gmail.com>
Subject: Re: [RFC/PATCH bpf-next 06/20] libbpf: Factor elf_for_each_symbol function
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 24, 2023 at 9:05=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Currently we have elf_find_func_offset function that looks up
> symbol in the binary and returns its offset to be used for uprobe
> attachment.
>
> For attaching multiple uprobes we will need interface that allows
> us to get offsets for multiple symbols specified either by name or
> regular expression.
>
> Factoring out elf_for_each_symbol helper function that iterates
> all symbols in binary and calls following callbacks:
>
>   fn_match - on each symbol
>              if it returns error < 0, we bail out with that error
>   fn_done  - when we finish iterating symbol section,
>              if it returns true, we don't iterate next section
>
> It will be used in following changes to lookup multiple symbols
> and their offsets.
>
> Changing elf_find_func_offset to use elf_for_each_symbol with
> single_match callback that's looking to match single function.
>

Given we have multiple uses for this for_each_elf_symbol, would it
make sense to implement it as an iterator (following essentially the
same pattern that BPF open-coded iterator is doing, where state is in
a small struct, and then we call next() until we get back NULL?)

This will lead to cleaner code overall, I think. And it does seem func
to implement it this (composable) way.

Also, I think we are at the point where libbpf.c is becoming pretty
bloated, so we should try to split out coherent subsets of
functionality into separate files. ELF helpers seem like a good group
of functionality  to move to a separate file? Maybe as a separate
patch set and/or follow up, but think about whether you can do part of
that during refactoring?

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 185 +++++++++++++++++++++++++----------------
>  1 file changed, 114 insertions(+), 71 deletions(-)
>

[...]
