Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4C857E40B
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 18:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiGVQEn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 12:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiGVQEn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 12:04:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA5D17E3C
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 09:04:42 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bp15so9350455ejb.6
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uGYv6nD5+xV6n149xvOnkBdwL1VCLuI3PMph9iZNKIo=;
        b=G1w2BfW13bFneRRXIc7xb5UE+YRy49t315srt05YKu+W1MHO3AjRJ3WUbKBkgnnsb9
         4xw7rGWwrL7XrfcfrODpH8mEvsI4A1jjOVb+B1ogi3yN9efS5BCEMJePoKG3xIWEJb1Q
         jowPuNvWkzLos0h3II3JiUxJanUarbS0tUxGEDUHmYtTUMvRBVuXpjGpXNE3wJhWz0Oo
         AaEoan4h/8ZOfISc700FqhjHBp60lEjWLSiq8Ooba6IeVkwEzncQQ9aVH/NAgIkhy0Mi
         R6400N9dniJuJx3sqO7O/XbW8BBiShJSSqqrg1OJnAPVWDKHa1lExQKFnmNVoX+wXkkC
         Oyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uGYv6nD5+xV6n149xvOnkBdwL1VCLuI3PMph9iZNKIo=;
        b=SJqHjQ3nxtJZ9YSbsOnySAMsnNyGqeI13IxKZOnx9DcagvKwC96skVwUlX9MMmA0yM
         sML6sISejhSfDma/heOIOE5kn85AFyGGedWzc3gTOfZGYbkdG/znkpj4ttWcJbN+U5FH
         JGO9YmTvwQLO7DwN4s0x7YiUcHPRxCqrhdR1m7+g8wJDXP9696lOP15k4NE4jaE1Pp57
         lmKGqyLYDAldwEE3J/Cn3qqEYmhKC22liKhgPFu8dCDakhtPMf/axlSB1OB9q0HeyX6x
         ZSj+IDq4s9AMt+r7MSuGsTiqjpERqtFpM6Rcn7Xy6PA9T84nfLxSx6uCjQWThVcoj/bx
         hNew==
X-Gm-Message-State: AJIora+Bq/B7VL8CqSsvW2CGw+OZ/qeXOSFVKj9XcCvxIWWrzBfD68pN
        opfpOT+FwLDDmo0CsC0R+0Vp3LfyViO6St0jzJQ=
X-Google-Smtp-Source: AGRyM1sEZglZ7U9lRvXKamGoNJbVJ9lkl9SClPYPq+naTnBuKhGq4j93BQe7SkKDMs5RkCLkKDjO63wJgQbtfWkG9sI=
X-Received: by 2002:a17:906:a089:b0:72f:826b:e084 with SMTP id
 q9-20020a170906a08900b0072f826be084mr486042ejy.708.1658505881040; Fri, 22 Jul
 2022 09:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220722110811.124515-1-jolsa@kernel.org> <20220722072608.17ef543f@rorschach.local.home>
In-Reply-To: <20220722072608.17ef543f@rorschach.local.home>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 22 Jul 2022 09:04:29 -0700
Message-ID: <CAADnVQ+hLnyztCi9aqpptjQk-P+ByAkyj2pjbdD45dsXwpZ0bw@mail.gmail.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 22, 2022 at 4:26 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 22 Jul 2022 13:08:11 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
>
> > hi,
> > we recently hit bug where ftrace update raced with bpf_dispatcher_update
> > that calls directly bpf_arch_text_poke [1].
> >
> > The bpf_dispatcher_update creates special trampoline and attaches it to
> > designated bpf_dispatcher_xdp_func function, which is run for xdp bpf
> > programs from several places.
> >
> > After discussion with Alexei we'd rather keep this code update out of
> > ftrace, because it's already slow and had troubles with CI because of
> > that.
> >
> > This patch is presenting the idea to allow some functions not to be
> > managed by ftrace by marking them with NOFTRACE_SYMBOL macro and
> > such symbols will not be added to ftrace_pages on the kernel start.
>
> NACK on any generic way to hide mcount/fentry functions from ftrace.
>
> There's a lot of infrastructure to see what functions are being
> modified, as the user should know. (See tracefs/enabled_functions).
>
> There's no need for a generic way to hide functions. Once that happens,
> it will grow and then it will be more confusing to why some functions are
> traced while others are not.

Steven,

ftrace must not peek into bpf specific functions.
Currently ftrace is causing the kernel to crash.
What Jiri is proposing is to fix ftrace bug.
And you're saying nack? let ftrace be broken ?

If you don't like Jiri's approach please propose something else.
