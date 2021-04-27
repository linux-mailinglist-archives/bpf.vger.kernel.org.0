Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3099A36CFA8
	for <lists+bpf@lfdr.de>; Wed, 28 Apr 2021 01:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbhD0Xre (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 19:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbhD0Xre (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 19:47:34 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C326C061574;
        Tue, 27 Apr 2021 16:46:50 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id h36so42117635lfv.7;
        Tue, 27 Apr 2021 16:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B4EfuXadedAI5OOJEbOozmGvcL48B3b8Lsu25+BolLQ=;
        b=IBIjrv0b40KrnIR8zJSk8PYHxxPvKDHJfmdH2yFvSMcnBsd4qWi9VCeI+l28sjIZHw
         0l/lbLYXZ/O0oodn+aaLU0hPLAub/RPMfpl55fDpSBtf1ngOKEs1r/Y6hzydPV32woUn
         0jC7BKS+ozHgKIV+ugSJnptJY9tc+O0qhTYRBgQ0+sO1zH9w2tf0xkdhsr6OIKIh2FkX
         Jdw/LQTTPHAkdCvVSWoreCdHPYmCSvDsrcrUopkF+IenrfQRoOzW0q7TSgHapuB6nlWh
         dw+M+zVj0rCmcg7T5nWT4UjiA49M9aWeet4mCfo/ZmR0L2ywiCFy98WhiYV5NzN7tonx
         SELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B4EfuXadedAI5OOJEbOozmGvcL48B3b8Lsu25+BolLQ=;
        b=dwydKLYffRAycH4zCx2aMqF/t5V+D4Bx9HuQv68riYNQgMb6AMyjl/jBzqZMxDCpvb
         4UlqdqGQkMPDdrhkdq2imNSr53gHiWDMvwK5MZUeayFJp+cbWTHvm6goETkllkQSu2iz
         0IsdGVAvaAZaV8tRc24FtXpmx+h8R57aUKuaIenes4nhiwrSajM9z9BfKSC6mD5SjPYK
         Vh/aUrAoQmSKTpLweR2b2NhsjD/m93FEpbiTLd9xI0SoC+nsmaMG4i/mfDEwqlZAkBj2
         i2QWQVkkZwqwnilP8iyyYH/TvCBpT1vQklEFQKlyZ8IN/0oPv5UNPVsvbgHh7d7MhSMv
         Nvlg==
X-Gm-Message-State: AOAM533xYSQ+cVLnvCfbP6LJCpRUXz0E7V1P62oewxGrYj5ciKKYMskJ
        PDGxLikJzaFF84vcRvj8bJ6lUKI44qC7rZf9Ntw=
X-Google-Smtp-Source: ABdhPJxqkpsCVjkxn9UyzNt1BR0ab9wgPdXenUswScfwV+OUsgxaOLQfXPqBcms8IH1teKJ6Wq0WGxFALVWMDy2xFEs=
X-Received: by 2002:a05:6512:3984:: with SMTP id j4mr18858318lfu.38.1619567208718;
 Tue, 27 Apr 2021 16:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210427174313.860948-1-revest@chromium.org> <20210427174313.860948-3-revest@chromium.org>
In-Reply-To: <20210427174313.860948-3-revest@chromium.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 27 Apr 2021 16:46:37 -0700
Message-ID: <CAADnVQLQmt0-D_e=boXoK=FLRoXv9xzkCwM24zpbZERrEexLCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Implement formatted output helpers
 with bstr_printf
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 27, 2021 at 10:43 AM Florent Revest <revest@chromium.org> wrote:
> +                       if (fmt[i + 1] == 'B') {
> +                               if (tmp_buf)  {
> +                                       err = snprintf(tmp_buf,
> +                                                      (tmp_buf_end - tmp_buf),
> +                                                      "%pB",
...
> +                       if ((tmp_buf_end - tmp_buf) < sizeof_cur_ip) {

I removed a few redundant () like above and applied.

>                 if (fmt[i] == 'l') {
> -                       cur_mod = BPF_PRINTF_LONG;
> +                       sizeof_cur_arg = sizeof(long);
>                         i++;
>                 }
>                 if (fmt[i] == 'l') {
> -                       cur_mod = BPF_PRINTF_LONG_LONG;
> +                       sizeof_cur_arg = sizeof(long long);
>                         i++;
>                 }

This bit got me thinking.
I understand that this is how bpf_trace_printk behaved
and the sprintf continued the tradition, but I think it will
surprise bpf users.
The bpf progs are always 64-bit. The sizeof(long) == 8
inside any bpf program. So printf("%ld") matches that long.
The clang could even do type checking to make sure the prog
is passing the right type into printf() if we add
__attribute__ ((format (printf))) to bpf_helper_defs.h
But this sprintf() implementation will trim the value to 32-bit
to satisfy 'fmt' string on 32-bit archs.
So bpf program behavior would be different on 32 and 64-bit archs.
I think that would be confusing, since the rest of bpf prog is
portable. The progs work the same way on all archs
(except endianess, of course).
I'm not sure how to fix it though.
The sprintf cannot just pass 64-bit unconditionally, since
bstr_printf on 32-bit archs will process %ld incorrectly.
The verifier could replace %ld with %Ld.
The fmt string is a read only string for bpf_snprintf,
but for bpf_trace_printk it's not and messing with it at run-time
is not good. Copying the fmt string is not great either.
Messing with internals of bstr_printf is ugly too.
Maybe we just have to live with this quirk ?
Just add a doc to uapi/bpf.h to discourage %ld and be done?
