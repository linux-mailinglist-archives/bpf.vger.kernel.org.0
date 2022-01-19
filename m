Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F0C49414F
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 20:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242341AbiASTvb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 14:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357215AbiASTul (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 14:50:41 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B3AC06161C
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 11:50:35 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id e8so3195604plh.8
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 11:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dcsAB2wK4p9szFGNdYthwv4DN6AW2YgBuq2fRnEFwtU=;
        b=fRuBafzk3Ix5ubucoyAzh0ruDmAMQD7iBURlpfYcLq8dfgg21BQQ3a5eEfyhcroKp0
         /iJGIbBAOZc+DR1jhFvCfaCPCMbWBfZyF52FKPQx+aP672yIjEdHo3NhP/a7dWn/rEJF
         E6VLFp1l++D7oUhqspqpHZ8J7fkk1/CB6aPOisa6qJ02HpbIADs/V+YDAvcvleCr8cc9
         /bgtLzX47iaiPzIElafEpxeXutAUbjGGFg1YTa89Vf3AHYv+XDJ+AJtQCv13I8NBGd+t
         wFlLoAdW3Kcto7mmX8ZshsoU7veft/MqFa658uXYHNIWcQASafoC5yLfppgltrgJxpH9
         BjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dcsAB2wK4p9szFGNdYthwv4DN6AW2YgBuq2fRnEFwtU=;
        b=Itt1B0ymF5vQ4Yx7hi+AVyiD0ytytuTiyRJxCU5vw9ZOs6CyJJqMszSMXuL27L/ZDs
         kk4xu1LB3fMn/7WtfejW24FiPUDgYlunwMzqYNC4tXYNvhafK9xmDYKyxeXr/wqKKWL+
         vTrKtLqXIowQXLOmZzc6qI1RRj3mzkkURF8gG4Z/pp+Q/8hj5fBkTbdrSvvMgCu+zqIi
         ZXqHFFf2UCEPVqD16+de3mLBrBBPlin4eU8VxQlGEAzNV4H8VakbzkMhnI6zxB3h/kTG
         q5k56YGZWPdZZ0prxKAjsD/OmhPiXyxlUrPnhu2Rj/klNceMzO0Y9af0sLGUwRddD/G5
         F0OA==
X-Gm-Message-State: AOAM530pYRDYlE+aqCzJAvphQMByTMDiJyl/WhQ+7gDsLKTR9gHgM4WW
        Q4DczxA8apmdytmTE847YCqyDEQJLC6R4Xu2YXw=
X-Google-Smtp-Source: ABdhPJxj4kpox8JdMXSfiDEsruWXmtbFLZ+hRg10DKmYfzJT1zYGABCnokGoTN64RTGkYQLCr4Ulk/ZzuXAIJXsQfwY=
X-Received: by 2002:a17:902:860c:b0:149:1017:25f0 with SMTP id
 f12-20020a170902860c00b00149101725f0mr33776972plo.116.1642621835127; Wed, 19
 Jan 2022 11:50:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641316155.git.zhuyifei@google.com> <833b122afaeaba4485942c563ef16a64fa997fe6.1641316155.git.zhuyifei@google.com>
In-Reply-To: <833b122afaeaba4485942c563ef16a64fa997fe6.1641316155.git.zhuyifei@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 19 Jan 2022 11:50:24 -0800
Message-ID: <CAADnVQLCw+zyC6q=-HSURO4SpkAmSR1bwz8YLwL3nonUkeJ9Xg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 3/4] bpf: Add cgroup helpers
 bpf_{get,set}_retval to get/set syscall return value
To:     YiFei Zhu <zhuyifei@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 4, 2022 at 9:15 AM YiFei Zhu <zhuyifei@google.com> wrote:
>
> The helpers continue to use int for retval because all the hooks
> are int-returning rather than long-returning. The return value of
> bpf_set_retval is int for future-proofing, in case in the future
> there may be errors trying to set the retval.
>
> After the previous patch, if a program rejects a syscall by
> returning 0, an -EPERM will be generated no matter if the retval
> is already set to -err. This patch change it being forced only if
> retval is not -err. This is because we want to support, for
> example, invoking bpf_set_retval(-EINVAL) and return 0, and have
> the syscall return value be -EINVAL not -EPERM.
>
> This change is reflected in the sockopt_sk test which has been
> updated to assert the errno is EINVAL instead of the EPERM.
> The eBPF prog has to explicitly bpf_set_retval(-EPERM) if EPERM
> is wanted. I also removed the explicit mentions of EPERM in the
> comments in the prog.
>
> For BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY, the prior behavior is
> that, if the return value is NET_XMIT_DROP, the packet is silently
> dropped. We preserve this behavior for backward compatibility
> reasons, so even if an errno is set, the errno does not return to
> caller. However, setting a non-err to retval cannot propagate so
> this is not allowed and we return a -EFAULT in that case.
>
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> Reviewed-by: Stanislav Fomichev <sdf@google.com>
> ---
>  include/linux/bpf.h                           | 10 +++--
>  include/uapi/linux/bpf.h                      | 18 +++++++++
>  kernel/bpf/cgroup.c                           | 38 ++++++++++++++++++-
>  tools/include/uapi/linux/bpf.h                | 18 +++++++++
>  .../selftests/bpf/prog_tests/sockopt_sk.c     |  2 +-
>  .../testing/selftests/bpf/progs/sockopt_sk.c  | 32 ++++++++--------
>  6 files changed, 96 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 88f6891e2b53..300df48fa0e0 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1300,7 +1300,7 @@ BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
>         while ((prog = READ_ONCE(item->prog))) {
>                 run_ctx.prog_item = item;
>                 func_ret = run_prog(prog, ctx);
> -               if (!(func_ret & 1))
> +               if (!(func_ret & 1) && !IS_ERR_VALUE((long)run_ctx.retval))
>                         run_ctx.retval = -EPERM;
>                 *(ret_flags) |= (func_ret >> 1);
>                 item++;
> @@ -1330,7 +1330,7 @@ BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
>         old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>         while ((prog = READ_ONCE(item->prog))) {
>                 run_ctx.prog_item = item;
> -               if (!run_prog(prog, ctx))
> +               if (!run_prog(prog, ctx) && !IS_ERR_VALUE((long)run_ctx.retval))
>                         run_ctx.retval = -EPERM;
>                 item++;
>         }
> @@ -1390,7 +1390,7 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
>   *   0: NET_XMIT_SUCCESS  skb should be transmitted
>   *   1: NET_XMIT_DROP     skb should be dropped and cn
>   *   2: NET_XMIT_CN       skb should be transmitted and cn
> - *   3: -EPERM            skb should be dropped
> + *   3: -err              skb should be dropped
>   */
>  #define BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY(array, ctx, func)                \
>         ({                                              \
> @@ -1399,10 +1399,12 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
>                 u32 _ret;                               \
>                 _ret = BPF_PROG_RUN_ARRAY_CG_FLAGS(array, ctx, func, 0, &_flags); \
>                 _cn = _flags & BPF_RET_SET_CN;          \
> +               if (_ret && !IS_ERR_VALUE((long)_ret))  \
> +                       _ret = -EFAULT;                 \
>                 if (!_ret)                              \
>                         _ret = (_cn ? NET_XMIT_CN : NET_XMIT_SUCCESS);  \
>                 else                                    \
> -                       _ret = (_cn ? NET_XMIT_DROP : -EPERM);          \
> +                       _ret = (_cn ? NET_XMIT_DROP : _ret);            \

Sorry for the long delay in reviewing.
Overall it looks very good.
Few questions:

Why change this behavior for BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY ?
It's for an inet_egress hook only. In other words ip_output.
What kind of different error codes do you want to pass to
the stack from there?

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> index 4b937e5dbaca..164aa5020bf1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
> @@ -177,7 +177,7 @@ static int getsetsockopt(void)
>         optlen = sizeof(buf.zc);
>         errno = 0;
>         err = getsockopt(fd, SOL_TCP, TCP_ZEROCOPY_RECEIVE, &buf, &optlen);
> -       if (errno != EPERM) {
> +       if (errno != EINVAL) {

Could you explain which part of this patch caused this change
in user visible behavior?
I understand the desire to do bpf_set_retval(-EINVAL) and return 0,
but progs/sockopt_sk.c is not doing it.
Where does EINVAL come from?
