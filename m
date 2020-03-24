Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 691E219134A
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 15:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgCXOeJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Mar 2020 10:34:09 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45333 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgCXOeJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Mar 2020 10:34:09 -0400
Received: by mail-ot1-f66.google.com with SMTP id c9so7018395otl.12;
        Tue, 24 Mar 2020 07:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V3bCztDeWL/Cm70pLIsnhEmjai7N2DWW/RXznGW8NR0=;
        b=f6BbAEo/pvipL9yVIKB3lQlaLTcxHYenVT99NwpzEFRjPD1WWdbVha7jrN4aBdqK/X
         6n++cQrUvNAEQV6r/Nw2mKtxgyFV5YXU1KG3GPoqe7iiiNtDqf6gh5P5KJpZw8oJOIXy
         29oBZSwoQ4QyVy0k/DEEtLrpDnasj6FxtRcc4O8B0TmBkTJ4+AeUO/Dw3vEX5g5nLOKH
         yEoD+1+VHmkAKFSdaknNS2y9gINj8OVS+v3A+ubcqLBu/c0/4xC5PwWlktJB4e0pi6R1
         +OHnTgYJhvyuOv9RyMIg61+F2w6Wh0R3Rrolfpk6fVh9OSOxw2yCl93A/uOUm92g6dKr
         Fw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V3bCztDeWL/Cm70pLIsnhEmjai7N2DWW/RXznGW8NR0=;
        b=doBuqw1ilVRQHm4UID6qqYxdmng6OT5QRFyqwq4uBAc6X+vwEp7ZzwxsNTxuiEQns0
         LI7Oi1qwGbI2+w5Jh/4Cif+JsFSYFcBnCiU16YdSqGWudyoQqyIo8lK4QnGvB5DthKl2
         aqgwalgGp61iLk5hSNyOTyPJekxO5IizGDYzGfaG5E0gaDVF078kei0ABghoCyBSdDx3
         76cfnR7saygp09PdQ8/e6cfaZeERNE1IYuiz8hbyKverSG15OfoEahwtCiGPu+Baxui+
         WSR10WLinaMcuK3VKyRS05K1QtqEA5xLyOHrbgZmye6ttvcb9cNN//PoXEK2RmEGepBq
         NjSg==
X-Gm-Message-State: ANhLgQ1Bpdy/b5uifqBtL+XQCAyP7kmx4NR8MaiIACQ3AIHLR/IxKXfn
        zWRL5edopiMt59kKTnRYChc5LIwz5izj1z5Z7BY=
X-Google-Smtp-Source: ADFU+vsNpb9KZt+QNv+56/OsWx42rl6MFpi6JRLMhP6ybGeZ5h5PA5DQBbzLbvjEFqINPzu0TEVwA8NF7AtEY94OYuo=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr22614344otl.162.1585060447978;
 Tue, 24 Mar 2020 07:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200323164415.12943-1-kpsingh@chromium.org> <20200323164415.12943-5-kpsingh@chromium.org>
In-Reply-To: <20200323164415.12943-5-kpsingh@chromium.org>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 24 Mar 2020 10:35:16 -0400
Message-ID: <CAEjxPJ4MukexdmAD=py0r7vkE6vnn6T1LVcybP_GSJYsAdRuxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/7] bpf: lsm: Implement attach, detach and execution
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 23, 2020 at 12:46 PM KP Singh <kpsingh@chromium.org> wrote:
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

> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 530d137f7a84..2a8131b640b8 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -9,6 +9,9 @@
>  #include <linux/btf.h>
>  #include <linux/lsm_hooks.h>
>  #include <linux/bpf_lsm.h>
> +#include <linux/jump_label.h>
> +#include <linux/kallsyms.h>
> +#include <linux/bpf_verifier.h>
>
>  /* For every LSM hook  that allows attachment of BPF programs, declare a NOP
>   * function where a BPF program can be attached as an fexit trampoline.
> @@ -27,6 +30,32 @@ noinline __weak void bpf_lsm_##NAME(__VA_ARGS__) {}
>  #include <linux/lsm_hook_names.h>
>  #undef LSM_HOOK
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

I had asked before, and will ask again: please provide an explicit LSM
hook for mediating whether one can make changes to the LSM hooks.
Neither CAP_MAC_ADMIN nor CAP_SYS_ADMIN suffices to check this for SELinux.
