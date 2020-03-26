Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1C2194738
	for <lists+bpf@lfdr.de>; Thu, 26 Mar 2020 20:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgCZTMd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Mar 2020 15:12:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42788 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZTMd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Mar 2020 15:12:33 -0400
Received: by mail-qt1-f193.google.com with SMTP id t9so6433479qto.9;
        Thu, 26 Mar 2020 12:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHsOC/D03h0XLJc3jn+ovK0zIf17NyvwgvW1/olri/I=;
        b=bf6kiiHYYEmy+3+jGQVmaoWewfjr+65/fJMxT3+fBDJDAhrQDTAQ0SmQTR7BCn8CRK
         vZkl+MrEgKTW+TDY2kVcx7MunV5Ah0JzeuoqBPr+QMczC2o/j6nQfbR28g9bguH5Zp0B
         qnpFSiL9IwOWsGibJm5lBiUzGWZ6GTsw8DCvBhkdB8SjgyaDSjwg+0zMYT1NfGBK+h7n
         Flx86kVsOZLHxbajZdP5eRt04jWA3o4WqtrqHkLBGmfYrQNyXp2vtZsuS+LCLZD5BBIR
         C76i1mZKyXw0rj3w+NqtLoQfQqQzdC2I+2FIrFEuQvSMBqlwhaj956AkTW7N0p2URmKG
         lLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHsOC/D03h0XLJc3jn+ovK0zIf17NyvwgvW1/olri/I=;
        b=gmw1xzwJTAc9p5z5rXbjx3QyRTPInNGPre2z3AOTtuoHM3XaYbbmY492iizHr4HJy9
         la+qjNVMv7Vn1aclWiUO+33Dv8jYjoS8EeI48PREQJ6GoNIXLSNohx9YxGs/BJSUbvmo
         gVObJOZbvLp28n3SNyNU4PyJbEtN+fxhSKodRH45idfAKBLHEIQS1Xg8HZyBPr/wzNx1
         eOvsVTooGDLutY1UgSKmiWi/5tEfWGIfRSlDqThprBP5uiIbYn1WYXClEoSyMtuEmXNW
         THvOnGz77AgQANGu35svMB1nbl3HTxktJJTfNuPFfsjQt/IcHFha07WVsWTmZsAw/OBk
         6mFA==
X-Gm-Message-State: ANhLgQ35mkFv3S2loU+Ocl+aIZ7wglwc5TysWsBh2dSCRiHCVurOjpbf
        AVbYfnEgL70quJWG0Z0eidhfWqlbIuCAmMHFen4=
X-Google-Smtp-Source: ADFU+vuGpdr6jRNAReDB+x/B5xU92+TkGFdR4WoigAiJV5uSEeF2uvz6dQHx2HBTxi6NSUjJPpXxEE6SZe4f6P7KjgA=
X-Received: by 2002:ac8:3f62:: with SMTP id w31mr9934413qtk.171.1585249951604;
 Thu, 26 Mar 2020 12:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200326142823.26277-1-kpsingh@chromium.org> <20200326142823.26277-5-kpsingh@chromium.org>
In-Reply-To: <20200326142823.26277-5-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 26 Mar 2020 12:12:20 -0700
Message-ID: <CAEf4BzaS8xLLrbaWgWbWSEVfc3YBPURQhZxe=zR06B021jH5BA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 4/8] bpf: lsm: Implement attach, detach and execution
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 26, 2020 at 7:29 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> JITed BPF programs are dynamically attached to the LSM hooks
> using BPF trampolines. The trampoline prologue generates code to handle
> conversion of the signature of the hook to the appropriate BPF context.
>
> The allocated trampoline programs are attached to the nop functions
> initialized as LSM hooks.
>
> BPF_PROG_TYPE_LSM programs must have a GPL compatible license and
> and need CAP_SYS_ADMIN (required for loading eBPF programs).
>
> Upon attachment:
>
> * A BPF fexit trampoline is used for LSM hooks with a void return type.
> * A BPF fmod_ret trampoline is used for LSM hooks which return an
>   int. The attached programs can override the return value of the
>   bpf LSM hook to indicate a MAC Policy decision.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>


>  include/linux/bpf_lsm.h | 11 ++++++++
>  kernel/bpf/bpf_lsm.c    | 28 ++++++++++++++++++++
>  kernel/bpf/btf.c        |  9 ++++++-
>  kernel/bpf/syscall.c    | 57 ++++++++++++++++++++++++++++-------------
>  kernel/bpf/trampoline.c | 17 +++++++++---
>  kernel/bpf/verifier.c   | 19 +++++++++++---
>  6 files changed, 114 insertions(+), 27 deletions(-)
>

[...]

> @@ -2479,6 +2496,10 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
>                 }
>                 buf[sizeof(buf) - 1] = 0;
>                 tp_name = buf;
> +               break;
> +       default:
> +                       err = -EINVAL;
> +                       goto out_put_prog;
>         }

is indentation off here or it's my email client?

[...]
