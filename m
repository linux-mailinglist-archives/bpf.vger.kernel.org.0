Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84D2435682
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 01:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhJTXay (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 19:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTXay (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 19:30:54 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9F0C06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 16:28:39 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id o134so14114816ybc.2
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 16:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f0HV6skCzX8lII2RA+BX+ymlEjU4MNy7wSLJiaOhOHA=;
        b=A+U+8LHj/AmkM7E32epWUCNS4v8R6KS8NJ/39uZBKHx+eBzqE0JfkZh+fb9EM6S1IU
         pONz1iGA0UWVOzcqi0pL+zJVLiJrg9JMSwmsY5YARtqunmfjzXh0x2A2w7KV7qy3Oqpd
         YxpvJwfozh7yG+jsVdEDJCmQOnrdiwnQlRTFoZC276u7Lfc7h0BkmlJurqDYK30L4U24
         UB/KdHzEXd6yqL7wOk+qVsQmESiwiAH0v9mNZclkkufsEAEuuzFF5bJhhqRGkWhXX/kU
         mri3Tl6No43ZENy6cZyNCowhx8Kp8bs31vgKeV17YhH/xubk8akYkvpbkwshCKYC8w6P
         YMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0HV6skCzX8lII2RA+BX+ymlEjU4MNy7wSLJiaOhOHA=;
        b=eyOMnBk3Kq0m58V2GysPRdOmmM7dtagauw3WoJsiQTSw4wlXnKtARwFEdBw+BnkSEG
         u/YfPenTZeskMnifDq6rY/jPeopc/3Aq/MFHj89UGLj0OFaPnYXP+HTETnqhbRg1bNSh
         MUG0UnBo0fgqqY0HwPyhIDUCI7acu7vR3U1guWkydOsY6bXHBCUpgGyYHUiP+mCIUMFh
         Pfw+lHxK5YYersh1Laf5XpDVqTberOizYTnbVmldi6IztxMSUzPkKMOydTES0N67oeh8
         GyDiv4h57xkpmwZa2RIwAYSGVGQxsEeD34Qu+DaT3BRltmlZ+1mqG99YF3jlgAxAFtUE
         ACjg==
X-Gm-Message-State: AOAM531uTXtiok36XQPd2jRF22DmU/+wm/zI++aNhZ+IqWW9m5ajGQV1
        /G7MXjLIeN4hnIh9l3LnnPIinfwygB7DAmAdLNhGUxBnZWw=
X-Google-Smtp-Source: ABdhPJzJdJew0iI71g8xC0BmlUH0TRbi4AIYh0iBMlkF+ONbXp1fdbEQw7NPpjGV79QpWuaM18BnLkWEyjF8iC6OBmI=
X-Received: by 2002:a25:afcf:: with SMTP id d15mr2002707ybj.433.1634772518190;
 Wed, 20 Oct 2021 16:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633535940.git.zhuyifei@google.com> <a2e569ee61e677ee474b7538adcebb0e1462df69.1633535940.git.zhuyifei@google.com>
In-Reply-To: <a2e569ee61e677ee474b7538adcebb0e1462df69.1633535940.git.zhuyifei@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 20 Oct 2021 16:28:27 -0700
Message-ID: <CAEf4Bzbj0Bd5bnUrJMr4ozFFAHVE=NvsO1KR1o9=iqBT85=LUw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add cgroup helper bpf_export_errno to
 get/set exported errno value
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 6, 2021 at 9:04 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
>
> From: YiFei Zhu <zhuyifei@google.com>
>
> When passed in a positive errno, it sets the errno and returns 0.
> When passed in 0, it gets the previously set errno. When passed in
> an out of bound number, it returns -EINVAL. This is unambiguous:
> negative return values are error in invoking the helper itself,
> and positive return values are errnos being exported. Errnos once
> set cannot be unset, but can be overridden.
>
> The errno value is stored inside bpf_cg_run_ctx for ease of access
> different prog types with different context structs layouts. The
> helper implementation can simply perform a container_of from
> current->bpf_ctx to retrieve bpf_cg_run_ctx.
>
> For backward compatibility, if a program rejects without calling
> the helper, and the errno has not been set by any prior progs, the
> BPF_PROG_RUN_ARRAY_CG family macros automatically set the errno to
> EPERM. If a prog sets an errno but returns 1 (allow), the outcome
> is considered implementation-defined. This patch treat it the same
> way as if 0 (reject) is returned.
>
> For BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY, the prior behavior is
> that, if the return value is NET_XMIT_DROP, the packet is silently
> dropped. We preserve this behavior for backward compatibility
> reasons, so even if an errno is set, the errno does not return to
> caller.
>
> For getsockopt hooks, they are different in that bpf progs runs
> after kernel processes the getsockopt syscall instead of before.
> There is also a retval in its context struct in which bpf progs
> can unset the retval, and can force an -EPERM by returning 0.
> We preseve the same semantics. Even though there is retval,
> that value can only be unset, while progs can set (and not unset)
> additional errno by using the helper, and that will override
> whatever is in retval.
>
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> Reviewed-by: Stanislav Fomichev <sdf@google.com>
> ---
>  include/linux/bpf.h            | 23 +++++++++++------------
>  include/uapi/linux/bpf.h       | 14 ++++++++++++++
>  kernel/bpf/cgroup.c            | 24 ++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
>  4 files changed, 63 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 938885562d68..5e3f3d2f5871 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1155,6 +1155,7 @@ struct bpf_run_ctx {};
>  struct bpf_cg_run_ctx {
>         struct bpf_run_ctx run_ctx;
>         const struct bpf_prog_array_item *prog_item;
> +       int errno_val;
>  };
>
>  struct bpf_trace_run_ctx {
> @@ -1196,8 +1197,7 @@ BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
>         const struct bpf_prog *prog;
>         const struct bpf_prog_array *array;
>         struct bpf_run_ctx *old_run_ctx;
> -       struct bpf_cg_run_ctx run_ctx;
> -       int ret = 0;
> +       struct bpf_cg_run_ctx run_ctx = {};

you are zero-initializing this struct unnecessarily here. It's a
microoptimization, but it would be a bit cheaper to just
run_ctx.errno_val = 0; before the loop.

>         u32 func_ret;
>
>         migrate_disable();
> @@ -1208,15 +1208,15 @@ BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
>         while ((prog = READ_ONCE(item->prog))) {
>                 run_ctx.prog_item = item;
>                 func_ret = run_prog(prog, ctx);
> -               if (!(func_ret & 1))
> -                       ret = -EPERM;
> +               if (!(func_ret & 1) && !run_ctx.errno_val)
> +                       run_ctx.errno_val = EPERM;
>                 *(ret_flags) |= (func_ret >> 1);
>                 item++;
>         }
>         bpf_reset_run_ctx(old_run_ctx);
>         rcu_read_unlock();
>         migrate_enable();
> -       return ret;
> +       return -run_ctx.errno_val;
>  }
>
>  static __always_inline int
> @@ -1227,8 +1227,7 @@ BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
>         const struct bpf_prog *prog;
>         const struct bpf_prog_array *array;
>         struct bpf_run_ctx *old_run_ctx;
> -       struct bpf_cg_run_ctx run_ctx;
> -       int ret = 0;
> +       struct bpf_cg_run_ctx run_ctx = {};
>
>         migrate_disable();
>         rcu_read_lock();
> @@ -1237,14 +1236,14 @@ BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
>         old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>         while ((prog = READ_ONCE(item->prog))) {
>                 run_ctx.prog_item = item;
> -               if (!run_prog(prog, ctx))
> -                       ret = -EPERM;
> +               if (!run_prog(prog, ctx) && !run_ctx.errno_val)
> +                       run_ctx.errno_val = EPERM;
>                 item++;
>         }
>         bpf_reset_run_ctx(old_run_ctx);
>         rcu_read_unlock();
>         migrate_enable();
> -       return ret;
> +       return -run_ctx.errno_val;
>  }
>
>  static __always_inline u32
> @@ -1297,7 +1296,7 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
>   *   0: NET_XMIT_SUCCESS  skb should be transmitted
>   *   1: NET_XMIT_DROP     skb should be dropped and cn
>   *   2: NET_XMIT_CN       skb should be transmitted and cn
> - *   3: -EPERM            skb should be dropped
> + *   3: -errno            skb should be dropped
>   */
>  #define BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY(array, ctx, func)                \
>         ({                                              \
> @@ -1309,7 +1308,7 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
>                 if (!_ret)                              \
>                         _ret = (_cn ? NET_XMIT_CN : NET_XMIT_SUCCESS);  \
>                 else                                    \
> -                       _ret = (_cn ? NET_XMIT_DROP : -EPERM);          \
> +                       _ret = (_cn ? NET_XMIT_DROP : _ret);            \
>                 _ret;                                   \
>         })
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 6fc59d61937a..d8126f8c0541 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4909,6 +4909,19 @@ union bpf_attr {
>   *     Return
>   *             The number of bytes written to the buffer, or a negative error
>   *             in case of failure.
> + *
> + * int bpf_export_errno(int errno_val)

it's subjective, but "bpf_export_errno" name is quite confusing. What
are we "exporting" and where?

I actually like Song's proposal for two helpers,
bpf_set_err()/bpf_get_err(). It makes the semantics less confusing. I
honestly don't remember the requirement to have one combined helper
from the BPF office hour discussion, but if there was a good reason
for that, please remind us.

> + *     Description
> + *             If *errno_val* is positive, set the syscall's return error code;

This inversion of error code is also confusing. If we are to return
-EXXX, bpf_set_err(EXXX) is quite confusing.

> + *             if *errno_val* is zero, retrieve the previously set code.

Also, are there use cases where zero is the valid "error" (or lack of
it, rather). I.e., wouldn't there be cases where you want to clear a
previous error? We might have discussed this, sorry if I forgot.

But either way, if bpf_set_err() accepted <= 0 and used that as error
value as-is (> 0 should be rejected, probably) that would make for
straightforward logic. Then for getting the current error we can have
a well-paired bpf_get_err()?


BTW, "errno" is very strongly associated with user-space errno, do we
want to have this naming association (this is the reason I used "err"
terminology above).

> + *
> + *             This helper is currently supported by cgroup programs only.
> + *     Return
> + *             Zero if set is successful, or the previously set error code on
> + *             retrieval. Previously set code may be zero if it was never set.
> + *             On error, a negative value.
> + *
> + *             **-EINVAL** if *errno_val* not between zero and MAX_ERRNO inclusive.

[...]
