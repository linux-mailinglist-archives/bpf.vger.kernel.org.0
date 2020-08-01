Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8832234F97
	for <lists+bpf@lfdr.de>; Sat,  1 Aug 2020 05:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgHADbH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Jul 2020 23:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgHADbH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Jul 2020 23:31:07 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA30C06174A
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2020 20:31:07 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id v89so3007853ybi.8
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2020 20:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c8KFLwv4kg2qOsU30eoExxSviGJ3nzSMGSix3q3SeOo=;
        b=g1FMgQBizdWVIZUpCETtP00zIalSZCpAShJTyx/OBed8CNfDSFHx9mF+a3mc9cDu2C
         l78GCER7tfI77I46MKqyqyXkyjFhn3HvyXpFjTe2Irt5DCOms+UhTPuHP6w04WLhCzdY
         zzHT32FMsksjfCm7YaQWF7G8CxqtOEHUmrgtL84KIFGudjQ6XqReryUzHyfjYSknjXqZ
         0MfE+4nVKw777FfaZdIzc9Rmkm5fdkqDljX58wPWjNKnPQ0h1F3hQFTX70s/6lJKdKQv
         A0N4KCLaFnMvqLu097CxquBf00zeHPS7c4fY8qKvKzn803s5JfOK5XjbY5Xj8Oq0QMTz
         ap8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c8KFLwv4kg2qOsU30eoExxSviGJ3nzSMGSix3q3SeOo=;
        b=OK6tr1xI6oZMwnU20ORVPfkiEWPPnOXVujX8JBRtwhZ9nwXWD4N8SWZ7UsQVAxlUSl
         eygbdbtg0UQJG6xebpkI3GUcedxFytPFaqhu2u+bUT+vYop8jdWE/4sNyOzdakSckS/j
         mWHsLI4Vi8O7b/+tRoZzeSS5wiJ3xx6atljNDJ6JDaNmDCP7Ge1FzwoWkza+8lfwYv7m
         sjtyXqHS9r1gecHZnS9mj95LTs8Rj8cGyAScdm8gHxFDFCbKBrIb3NDrw311YjZKJajZ
         x36x0GL4IWFHUq51KF4y1FIL12OtMCugsZlebem09m+8HrzrqiFV+yIhQUXIyf7mUpfW
         W1Aw==
X-Gm-Message-State: AOAM531JI6sfp5H3rVE5G44K1Mw4zEKjzAu21H8liDR5VI5VZFQ7rRSm
        R+hCzMGG65FHBJAT6Zb7BCV5e//g4r0pR+WyxiRoDg==
X-Google-Smtp-Source: ABdhPJx/EKdnKodozs/oFIOZiiuTPmKu6g+CEVzP890zb6UZrF9ayciLhimJGZkVqVDP9Dtlrx8xv0qRomXzE4RW+qQ=
X-Received: by 2002:a25:84cd:: with SMTP id x13mr10932312ybm.425.1596252666555;
 Fri, 31 Jul 2020 20:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <159623491781.20514.14371382768486033310.stgit@john-XPS-13-9370>
In-Reply-To: <159623491781.20514.14371382768486033310.stgit@john-XPS-13-9370>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 31 Jul 2020 20:30:55 -0700
Message-ID: <CAEf4BzZ9=av=EvbyzhoyCg0ZvTOA2GBPgq5vyb1SaoNmqwL6XQ@mail.gmail.com>
Subject: Re: [bpf-next PATCH] bpf: Add comment in bpf verifier to note
 PTR_TO_BTF_ID can be null
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 31, 2020 at 3:36 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> The verifier contains both types PTR_TO_BTF_ID and PTR_TO_BTF_ID_OR_NULL.
> For all other type pairs PTR_TO_foo and PTR_TO_foo_OR_NULL we follow the
> convention to use PTR_TO_foo_OR_NULL for pointers that may be null and
> PTR_TO_foo when the ptr value has been checked to ensure it is _not_ NULL.
>
> For PTR_TO_BTF_ID this is not the case though. It may be still be NULL
> even though we have the PTR_TO_BTF_ID type.

_OR_NULL means that the verifier enforces an explicit NULL check,
before allowing the BPF program to dereference corresponding
registers. That's not the case for PTR_TO_BTF_ID, though. The BPF
program is allowed to assume valid pointer and proceed without checks.

You are right that NULLs are still possible (as well as just invalid
pointers), but BPF JITs handle that by installing exception handlers
and zeroing out destination registers if it happens to be a NULL or
invalid pointer. This mimics bpf_probe_read() behavior, btw.

So I think the way it's described and named in the verifier makes
sense, at least from the verifier's implementation point of view.

>
> Improve the comment here to reflect the current state and change the reg
> type string to indicate it may be null.  We should try to avoid this in
> future types, but its too much code churn to unwind at this point.
>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  include/linux/bpf.h   |    2 +-
>  kernel/bpf/verifier.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 40c5e206ecf2..b9c192fe0d0f 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -352,7 +352,7 @@ enum bpf_reg_type {
>         PTR_TO_TCP_SOCK_OR_NULL, /* reg points to struct tcp_sock or NULL */
>         PTR_TO_TP_BUFFER,        /* reg points to a writable raw tp's buffer */
>         PTR_TO_XDP_SOCK,         /* reg points to struct xdp_sock */
> -       PTR_TO_BTF_ID,           /* reg points to kernel struct */
> +       PTR_TO_BTF_ID,           /* reg points to kernel struct or NULL */
>         PTR_TO_BTF_ID_OR_NULL,   /* reg points to kernel struct or NULL */
>         PTR_TO_MEM,              /* reg points to valid memory region */
>         PTR_TO_MEM_OR_NULL,      /* reg points to valid memory region or NULL */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b6ccfce3bf4c..d657efcad47b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -501,7 +501,7 @@ static const char * const reg_type_str[] = {
>         [PTR_TO_TCP_SOCK_OR_NULL] = "tcp_sock_or_null",
>         [PTR_TO_TP_BUFFER]      = "tp_buffer",
>         [PTR_TO_XDP_SOCK]       = "xdp_sock",
> -       [PTR_TO_BTF_ID]         = "ptr_",
> +       [PTR_TO_BTF_ID]         = "ptr_or_null_",
>         [PTR_TO_BTF_ID_OR_NULL] = "ptr_or_null_",
>         [PTR_TO_MEM]            = "mem",
>         [PTR_TO_MEM_OR_NULL]    = "mem_or_null",
>
