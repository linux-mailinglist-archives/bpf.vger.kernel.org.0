Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC5F718FEA2
	for <lists+bpf@lfdr.de>; Mon, 23 Mar 2020 21:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCWUTH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 16:19:07 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33236 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgCWUTH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Mar 2020 16:19:07 -0400
Received: by mail-qk1-f195.google.com with SMTP id v7so7269900qkc.0;
        Mon, 23 Mar 2020 13:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZ+ZwfTMYYsGD6syPZhmYKv+gyxadYlXHYerkec/Prc=;
        b=MuGyBhSE7OGl8aZJaCuWgDEd5sIIQ085S1F5HqBLnJoCv13/Zxds8/CWAFZYTt8/9J
         S840MrwKl0aeLkDA8pfk7R5jAyjYojOp6foFlae/XPQZf5nLwd/5/q5iHYxyAEFUKWeZ
         /je1mmdRsTf0C2Ype/Ht09cqC9bE3WSU9+MS/GjSn8uYJVF6PvDEsem6wh7+W9EPTH0i
         fbqQ97VnVOYnp0XQ9JUq6P72J+8z2r7IDsoNvUj2edBPIIzcVVItedYbKP/GoatZxyag
         olGaneNwEWpjfjuk46k39KmpbnhieLBIA2xrZRFhDLcKiu7nLamj7QtNpYXHIqbodcXa
         rX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZ+ZwfTMYYsGD6syPZhmYKv+gyxadYlXHYerkec/Prc=;
        b=IrgZVHZaQ90htltCOkZ2lhTQkLVp6e0H/mL6kbtEga+BmHCagvSv/AZgjRLqq+hcAn
         ruTBPAKoirHAH7nU6AGcFLoTwNVjR3Vt0AnOjIOx6Y5k4D8RAM1LTFEgMeordsEmekX7
         PxwIhkZraSfDfg49BP3EnYYBZo5vrQ6QtOKAI0znwVV0PYKNqrAf9gj9vDdWLkNYxYNE
         qKDzpJmF0bcaAKKScHBvx+tQpPVTmYRw8eQb1VoyEwQLvYbKI7NjwUz8bijZU2esiODJ
         ptDsoXYEWze5/DE5gnsBYy5xc4ECjrEvXi1Ye0GNNhSUEms+EfhO18UzdWvMWkxR3shw
         g4IA==
X-Gm-Message-State: ANhLgQ0ps0HKX6jROyTCyD5i3H09Td1eiyds/LzNcHcvC7+kDd2npzkj
        e3tEwSUERNK8e7d3Wj2ghTevwxE1BNYCZvVWYSo=
X-Google-Smtp-Source: ADFU+vsHBUxL6es42p14wjLjJwEUAXo+ilHYJpl09AVNoQ6QYphYryIlVRToeHqmy7Gxz1bQ/1tZVVgMcOW5Vfq5RYo=
X-Received: by 2002:a37:e40d:: with SMTP id y13mr22599759qkf.39.1584994744820;
 Mon, 23 Mar 2020 13:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200323164415.12943-1-kpsingh@chromium.org> <20200323164415.12943-5-kpsingh@chromium.org>
In-Reply-To: <20200323164415.12943-5-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 Mar 2020 13:18:54 -0700
Message-ID: <CAEf4BzaceUCEw+-s9EM3rvz+KbLrvBbUfa5e0CSbtkOytF+RsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/7] bpf: lsm: Implement attach, detach and execution
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

On Mon, Mar 23, 2020 at 9:45 AM KP Singh <kpsingh@chromium.org> wrote:
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
>  include/linux/bpf.h     |  4 ++++
>  include/linux/bpf_lsm.h | 11 +++++++++++
>  kernel/bpf/bpf_lsm.c    | 29 +++++++++++++++++++++++++++++
>  kernel/bpf/btf.c        |  9 ++++++++-
>  kernel/bpf/syscall.c    | 26 ++++++++++++++++++++++----
>  kernel/bpf/trampoline.c | 17 +++++++++++++----
>  kernel/bpf/verifier.c   | 19 +++++++++++++++----
>  7 files changed, 102 insertions(+), 13 deletions(-)
>

[...]

>
> +#define BPF_LSM_SYM_PREFX  "bpf_lsm_"
> +
> +int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> +                       const struct bpf_prog *prog)
> +{
> +       /* Only CAP_MAC_ADMIN users are allowed to make changes to LSM hooks
> +        */
> +       if (!capable(CAP_MAC_ADMIN))
> +               return -EPERM;
> +
> +       if (!prog->gpl_compatible) {
> +               bpf_log(vlog,
> +                       "LSM programs must have a GPL compatible license\n");
> +               return -EINVAL;
> +       }
> +
> +       if (strncmp(BPF_LSM_SYM_PREFX, prog->aux->attach_func_name,
> +                   strlen(BPF_LSM_SYM_PREFX))) {

sizeof(BPF_LSM_SYM_PREFIX) - 1?

> +               bpf_log(vlog, "attach_btf_id %u points to wrong type name %s\n",
> +                       prog->aux->attach_btf_id, prog->aux->attach_func_name);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +

[...]

> @@ -2367,10 +2369,24 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog)
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

It looks like an omission that we don't enforce expected_attach_type
to be 0 here. Should we fix it until it's too late?

> +               break;
> +       case BPF_PROG_TYPE_LSM:
> +               if (prog->expected_attach_type != BPF_LSM_MAC) {
> +                       err = -EINVAL;
> +                       goto out_put_prog;
> +               }
> +               break;
> +       default:
>                 err = -EINVAL;
>                 goto out_put_prog;
>         }
> @@ -2452,12 +2468,14 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
>         if (prog->type != BPF_PROG_TYPE_RAW_TRACEPOINT &&
>             prog->type != BPF_PROG_TYPE_TRACING &&
>             prog->type != BPF_PROG_TYPE_EXT &&
> +           prog->type != BPF_PROG_TYPE_LSM &&
>             prog->type != BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE) {
>                 err = -EINVAL;
>                 goto out_put_prog;
>         }
>
>         if (prog->type == BPF_PROG_TYPE_TRACING ||
> +           prog->type == BPF_PROG_TYPE_LSM ||
>             prog->type == BPF_PROG_TYPE_EXT) {


can you please refactor this into a nicer explicit switch instead of
combination of if/elses?

>                 if (attr->raw_tracepoint.name) {
>                         /* The attach point for this category of programs
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index f30bca2a4d01..9be85aa4ec5f 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -6,6 +6,7 @@
>  #include <linux/ftrace.h>
>  #include <linux/rbtree_latch.h>
>  #include <linux/perf_event.h>
> +#include <linux/btf.h>
>

[...]
