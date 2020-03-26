Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB638193565
	for <lists+bpf@lfdr.de>; Thu, 26 Mar 2020 02:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCZBtW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Mar 2020 21:49:22 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41475 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgCZBtV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Mar 2020 21:49:21 -0400
Received: by mail-qt1-f194.google.com with SMTP id i3so4042331qtv.8;
        Wed, 25 Mar 2020 18:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mRLGHfszhMu2H9fDuncZog2vRyEHxBc99RbT/Vq7PW8=;
        b=PFjPprIUPwCIol8hbzv8mrSyzKT0f9TMgTEtVE8XCoOh+ffNffW36O0ulxZ0enPXZR
         oAVRSmUpo6AZKZ3/+KdJp+fV4HXGejxHJt0iCblT/jv1YnRSDyg/+TiagxJgiYlQVHqu
         mQBmAEU2QW+IVSA5u40aM4nLwC4IqlNhiGMno5i+jzmyNjl3kKtgYKIH3F0+BAymQ8Qz
         pjeGuZbtZCUipN/QJDT1qFfLJgKGHANuFB2OPfCUwecsj0iI6PQ30GsB+f0WtULw5ze6
         VAPJelIT44aQC5S42ZarMfz0KGCkXcngtPRwQwAzAa3TrxiNcOeWDcmvze0JMBpjnSzI
         /GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mRLGHfszhMu2H9fDuncZog2vRyEHxBc99RbT/Vq7PW8=;
        b=eyKqnvVCTZE+n3xi+MwI/yF7KN2q3oBWmDMdoaz+G+aNCfZO7rHihA+B0Rz0635zho
         sPVExBEtZsq8rUPaJ57ecSSaGgHYp6O4i4MBL4g7dtScKP2lxflpOgZvtdOpwrvhpzhx
         ohs4cWdtWnYBFJxnQUPLbHm54ylMVlrTwMzPr9QrA8qoRhabCdjgmBNRyES2LP/Fgp9h
         Qw7BrjfrvsRYH8UTCsuPDX4+FcRCHTK+Fsq7FDynxpclhNXeL5/u07AKNwG98qlKkfy/
         jFK6R4QHz6/dTHA1OypQFcBlKEbA080/hcSG41bEAjX+2MbevuKR3TCSHBOyEozJWELK
         wDwQ==
X-Gm-Message-State: ANhLgQ2aJj81X7kWCPZta0LGSC5U8Yw0PsTcmjMVJh+IbaBnrQIWC0WQ
        TjYI5SX+vbP6boVeYnczEUCTEw83gN//AMaKIL0=
X-Google-Smtp-Source: ADFU+vt3Y8r0cvEDUOl2zSnNbGj7ycQvuBbKZKqpCB5JYtit1lUfaGb6YvS3pYYXmU+n+Hj6FgT6I4ELFB4cOpNM8DY=
X-Received: by 2002:ac8:7cb0:: with SMTP id z16mr5839557qtv.59.1585187359951;
 Wed, 25 Mar 2020 18:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200325152629.6904-1-kpsingh@chromium.org> <20200325152629.6904-5-kpsingh@chromium.org>
In-Reply-To: <20200325152629.6904-5-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 25 Mar 2020 18:49:09 -0700
Message-ID: <CAEf4BzbZ0Y+BXezgbdzN2T1cH9osREJUNQQoQJ5rJ0EYyD-Udg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 4/8] bpf: lsm: Implement attach, detach and execution
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

On Wed, Mar 25, 2020 at 8:27 AM KP Singh <kpsingh@chromium.org> wrote:
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
>  include/linux/bpf_lsm.h | 11 ++++++++
>  kernel/bpf/bpf_lsm.c    | 28 +++++++++++++++++++++
>  kernel/bpf/btf.c        |  9 ++++++-
>  kernel/bpf/syscall.c    | 56 ++++++++++++++++++++++++++++-------------
>  kernel/bpf/trampoline.c | 17 ++++++++++---
>  kernel/bpf/verifier.c   | 19 +++++++++++---
>  6 files changed, 113 insertions(+), 27 deletions(-)
>

[...]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 85567a6ea5f9..3ba30fd6101e 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -25,6 +25,7 @@
>  #include <linux/nospec.h>
>  #include <linux/audit.h>
>  #include <uapi/linux/btf.h>
> +#include <linux/bpf_lsm.h>
>
>  #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
>                           (map)->map_type == BPF_MAP_TYPE_CGROUP_ARRAY || \
> @@ -1935,6 +1936,7 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
>
>                 switch (prog_type) {
>                 case BPF_PROG_TYPE_TRACING:
> +               case BPF_PROG_TYPE_LSM:
>                 case BPF_PROG_TYPE_STRUCT_OPS:
>                 case BPF_PROG_TYPE_EXT:
>                         break;
> @@ -2367,10 +2369,28 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog)
>         struct file *link_file;
>         int link_fd, err;
>
> -       if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
> -           prog->expected_attach_type != BPF_TRACE_FEXIT &&
> -           prog->expected_attach_type != BPF_MODIFY_RETURN &&
> -           prog->type != BPF_PROG_TYPE_EXT) {
> +       switch (prog->type) {
> +       case BPF_PROG_TYPE_TRACING:
> +               if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
> +                   prog->expected_attach_type != BPF_TRACE_FEXIT &&
> +                   prog->expected_attach_type != BPF_MODIFY_RETURN) {
> +                       err = -EINVAL;
> +                       goto out_put_prog;
> +               }
> +               break;
> +       case BPF_PROG_TYPE_EXT:
> +               if (prog->expected_attach_type != 0) {
> +                       err = -EINVAL;
> +                       goto out_put_prog;
> +               }
> +               break;
> +       case BPF_PROG_TYPE_LSM:
> +               if (prog->expected_attach_type != BPF_LSM_MAC) {
> +                       err = -EINVAL;
> +                       goto out_put_prog;
> +               }
> +               break;
> +       default:

thanks, this is much more "scalable" in terms of maintenance!

>                 err = -EINVAL;
>                 goto out_put_prog;
>         }
> @@ -2449,16 +2469,10 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
>         if (IS_ERR(prog))
>                 return PTR_ERR(prog);
>
> -       if (prog->type != BPF_PROG_TYPE_RAW_TRACEPOINT &&
> -           prog->type != BPF_PROG_TYPE_TRACING &&
> -           prog->type != BPF_PROG_TYPE_EXT &&
> -           prog->type != BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE) {
> -               err = -EINVAL;
> -               goto out_put_prog;
> -       }
> -
> -       if (prog->type == BPF_PROG_TYPE_TRACING ||
> -           prog->type == BPF_PROG_TYPE_EXT) {
> +       switch (prog->type) {
> +       case BPF_PROG_TYPE_TRACING:
> +       case BPF_PROG_TYPE_EXT:
> +       case BPF_PROG_TYPE_LSM:
>                 if (attr->raw_tracepoint.name) {
>                         /* The attach point for this category of programs
>                          * should be specified via btf_id during program load.
> @@ -2466,11 +2480,13 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
>                         err = -EINVAL;
>                         goto out_put_prog;
>                 }
> -               if (prog->expected_attach_type == BPF_TRACE_RAW_TP)
> +               if (prog->expected_attach_type == BPF_TRACE_RAW_TP) {

this should probably also ensure prog->type == BPF_PROG_TYPE_TRACING ?
Otherwise you can trick kernel with BPF_PROG_TYPE_LSM and
expected_attach_type == BPF_TRACE_RAW_TP, no?

>                         tp_name = prog->aux->attach_func_name;
> -               else
> -                       return bpf_tracing_prog_attach(prog);
> -       } else {
> +                       break;
> +               }
> +               return bpf_tracing_prog_attach(prog);
> +       case BPF_PROG_TYPE_RAW_TRACEPOINT:
> +       case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
>                 if (strncpy_from_user(buf,
>                                       u64_to_user_ptr(attr->raw_tracepoint.name),
>                                       sizeof(buf) - 1) < 0) {
> @@ -2479,6 +2495,10 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
>                }

[...]
