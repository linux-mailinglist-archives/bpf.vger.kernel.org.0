Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337EA453D2B
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 01:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhKQAfl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Nov 2021 19:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhKQAfl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Nov 2021 19:35:41 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA7CC061570
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 16:32:43 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id e71so1936508ybh.10
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 16:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x9A3JN8oGkiyoQfN2NncYgJ0NSfcNUVe3a2xjTzyQMI=;
        b=JTaR8K+5pwOl1QRif6MhCPbxYcZR3KW3k/LAAczv1hiIDtcWoVJ3URosVGohjLzO5B
         ZkuoK0IRAYyP9dXZKErGvImDjjrzFF6EfAd4ladP78fSNoOxV0PFjRaWtKz/x+VD1sKW
         +RuHWhvrN6cwzxrAwzBWiPgmvfk8GBDp38pMZ8gujiaS6WS5TZKbGpRSHPwLy8UwN1fj
         13bK18ab/Afkb3FaDQS0qLImVJNUo8AX5HFSnOdUz7ICvaOkZIUi9qe2dwWOrjsuiRLa
         UlGn6+5J2+bWRbus+tLwkb6Afhqe2Bc8I9IV+1Uw2sBYsoAI55kjw09zu+A10mdrgIsk
         1l3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x9A3JN8oGkiyoQfN2NncYgJ0NSfcNUVe3a2xjTzyQMI=;
        b=7T40SqImnppFApHi8vBbfilBKvKkcXtWsuby9GuYPdN1waK3V7K8+oSPEXvX1nJngk
         kWqygONTC0yd4Gp6iIhITclxLMkDaiAurgah/orLGKJLY5MqN8APnOYajxWx/O/bsalu
         dT/bJ/M1jDjTAJ2376EL+S+DeXP5PuSRu+qy4VyHUmZ4aDwaZKBJdVxNjb9MwHKtTQ57
         tNIQvmYwjq8cKBeq82kye8bndYoShbPHZJnY9MCr3fz/ucz93+L4/GRU7ll5qhOGgbFa
         cDjYDGNe7w2y2DB4l/nRhED0FK5928FrmqCn0gmvcvGbevDcq9XFMraDEdXdjiwGTNne
         oCMA==
X-Gm-Message-State: AOAM531tzqA1TdJO3HdQFNCk+V/r7VOP6SoDO39pXVjXU2jdIejhA6iK
        psoIJCBDP1WaIQJwzVgcENEEgLd8cca6B2onfik=
X-Google-Smtp-Source: ABdhPJygRvJPiDZ+KILvCpgiCYDmxaQni8wyzALGfRB/+p+A8EJIku4oAfcilihuxD2qIyec62HoHFFuYudmpfBUx5M=
X-Received: by 2002:a25:cec1:: with SMTP id x184mr13051478ybe.455.1637109162943;
 Tue, 16 Nov 2021 16:32:42 -0800 (PST)
MIME-Version: 1.0
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com> <20211112050230.85640-2-alexei.starovoitov@gmail.com>
In-Reply-To: <20211112050230.85640-2-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Nov 2021 16:32:31 -0800
Message-ID: <CAEf4BzbTdF3r6wMAdPQTVswrLDJ0uwvrJrXPZwVsDmFra3YiZw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/12] libbpf: s/btf__type_by_id/btf_type_by_id/.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 11, 2021 at 9:02 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> To prepare relo_core.c to be compiled in the kernel and the user space
> replace btf__type_by_id with btf_type_by_id.
>
> In libbpf btf__type_by_id and btf_type_by_id have different behavior.
>
> bpf_core_apply_relo_insn() needs behavior of uapi btf__type_by_id
> vs internal btf_type_by_id, but type_id range check is already done
> in bpf_core_apply_relo(), so it's safe to replace it everywhere.
> The kernel btf_type_by_id() does the check anyway. It doesn't hurt.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---


A bit of obnoxiousness. When applied locally with pw-apply, the
subject of this patch looks like this:

eddb6c529562 libbpf: S/btf__type_by_id/btf_type_by_id/

Quite weird. More human-readable "Replace btf__type_by_id() with
btf_type_by_id()" reads so much better ;)

>  tools/lib/bpf/btf.c             |  2 +-
>  tools/lib/bpf/libbpf_internal.h |  2 +-
>  tools/lib/bpf/relo_core.c       | 16 ++++++++--------
>  3 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index fadf089ae8fe..aa0e0bbde697 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -454,7 +454,7 @@ const struct btf *btf__base_btf(const struct btf *btf)
>  }
>

[...]

>         type_id = spec->root_type_id;
> -       t = btf__type_by_id(spec->btf, type_id);
> +       t = btf_type_by_id(spec->btf, type_id);
>         s = btf__name_by_offset(spec->btf, t->name_off);
>
>         libbpf_print(level, "[%u] %s %s", type_id, btf_kind_str(t), str_is_empty(s) ? "<anon>" : s);
> @@ -1158,7 +1158,7 @@ int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
>         int i, j, err;
>
>         local_id = relo->type_id;
> -       local_type = btf__type_by_id(local_btf, local_id);
> +       local_type = btf_type_by_id(local_btf, local_id);
>         if (!local_type)
>                 return -EINVAL;

Please remove this check, it's meaningless with the use of
btf_type_by_id() and you already justified why it's not necessary.

>
> --
> 2.30.2
>
