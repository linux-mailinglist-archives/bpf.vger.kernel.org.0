Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99751470D5E
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 23:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344999AbhLJWXS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 17:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344878AbhLJWXE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Dec 2021 17:23:04 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DE6C061A32
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 14:19:28 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id d10so24544161ybe.3
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 14:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gC+ee2uBjsaLUSw8Jm0mRzM69pq82tl34SeFgJSJJHs=;
        b=p5rVTh86/r2QWTuwttsFJ+AKuTPAX7pyDhe0TcHJhdBYZDW4E82HgVqrZo1ZUeVCbm
         Dw+RaVW3Q5bvJyTebUtVWTogtRKPRprMSNpQja2Pxy4DnAKSLR9oKydsLOv4J74OKehX
         z4CeZTQU7hyVBBN4g1snb0GLdNpV/yZ++iW1b1RUHckwKB7z3fuECc1kZ7pHaRQWgeYD
         8Mgwggq9I4E5rZduivcmSd/3xll2NTUB0Tr/4twcaFAUXKd6o97w2btRHtAFMqSfc5di
         f2q2FFb+dCYwR4dtz+8S6QpX+N7c9d7vhuaE42POeLLkk0oQYwl3spL8QCosav+9BZ94
         69jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gC+ee2uBjsaLUSw8Jm0mRzM69pq82tl34SeFgJSJJHs=;
        b=kbd/VbQgVdCWjGV9diYAC9R/ZxFEafeRmZOxpX9dmFhHeURidZ3joLp5R7deLxVBLg
         DeUWi3JZ2UUTzT+dZYTTe/KzaP8R6Q4cTKa+il/jFsC1+bUF+GCIGj5UwLvioTEQd87x
         8yKDgiXxB/XAtehQfAg7TZSrsNhgeCWD49aJKDiGvSjMHXVx1IBpcqQYy54fTtjg+4LM
         dFS2rwCDE6n8LvyMFevE2n6JNid3RTbP8b1C906X/LeEB2o8iam1G6UAi57Gt+JRIsTC
         vFfqaZWxxgmTquoi5bhfH9UsIipng5084iq6Sign1fEQ96wWVKpfWn7qpiqCaZUN389F
         C5cQ==
X-Gm-Message-State: AOAM530KvtNxSeMLfq65Umm6bFXuhy2l8uN+PMPuaTC4Jc+2uNUNtN6K
        KmxO5bdFTzUgfZ5xkguaAFRQlX5pr1OqQyFyOsY=
X-Google-Smtp-Source: ABdhPJz8cVIAF/Jv/WY+xP8Km5uhrnUzJH8g0WuF8hcpyj5P3SmJj2//Nh8PJbuZ4qSL2CRG2xv6CdYTncEUDYOiRlU=
X-Received: by 2002:a25:3c9:: with SMTP id 192mr18020879ybd.766.1639174767794;
 Fri, 10 Dec 2021 14:19:27 -0800 (PST)
MIME-Version: 1.0
References: <20211210190855.1369060-1-kuifeng@fb.com> <20211210190855.1369060-4-kuifeng@fb.com>
In-Reply-To: <20211210190855.1369060-4-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 10 Dec 2021 14:19:16 -0800
Message-ID: <CAEf4BzaRWVa4qD6kmu-UND1qCQ_Lyng4wWo412ETtGiL3ZX-Zw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] tools/perf: Stop using bpf_object__find_program_by_title
 API.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 10, 2021 at 11:10 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> bpf_obj__find_program_by_title() in libbpf is going to be deprecated.
> Call bpf_object_for_each_program to find a program in the section with
> a given name instead.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  tools/perf/builtin-trace.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 624ea12ce5ca..082ecf2b31bf 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3253,10 +3253,22 @@ static void trace__set_bpf_map_syscalls(struct trace *trace)
>
>  static struct bpf_program *trace__find_bpf_program_by_title(struct trace *trace, const char *name)
>  {
> +       struct bpf_program *prog = NULL;
> +       struct bpf_program *pos;

nothing wrong with this, but in similar situations I usually prefer

struct bpf_program *pos, *prog = NULL;

It's shorter. There were few other places like this in previous patches.


> +       const char *sec_name;
> +
>         if (trace->bpf_obj == NULL)
>                 return NULL;
>
> -       return bpf_object__find_program_by_title(trace->bpf_obj, name);
> +       bpf_object__for_each_program(pos, trace->bpf_obj) {
> +               sec_name = bpf_program__section_name(pos);
> +               if (sec_name && !strcmp(sec_name, name)) {
> +                       prog = pos;
> +                       break;
> +               }
> +       }
> +
> +       return prog;
>  }
>
>  static struct bpf_program *trace__find_syscall_bpf_prog(struct trace *trace, struct syscall *sc,
> --
> 2.30.2
>
