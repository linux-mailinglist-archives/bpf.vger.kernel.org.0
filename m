Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB013424B34
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 02:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239941AbhJGAnY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 20:43:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhJGAnY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 20:43:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BE66611AE
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 00:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633567291;
        bh=2lpIC68QiU3Vlz95LFKwYQBfiMaSICDucj2X6fmcyTw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KYBERzdlUbXIlYgD4sWgUVMiU8Gtx9LcTS6FDR2PnAY5ezFpVwodRPmJphtzFgdkM
         x7gJHZXG+x8C+SZyWfmdjreT7eOVyjaNykDUuFTcz4L60Us6yZRKP40S68n8EWxcux
         OwDGq3n1nitzZetZiGZmJpToJSRpu2RMWPjX96xeMROaznyB+8dLUxvcUWDxvbP4qx
         VfMQJ8evaMOVPmNcTPfJJBcwxhvptVb7toEfMxo05D3WqNznFctssb55vzS5ql5jJ+
         daEkWkZualmJfIF5pTyeQ+ti+TvLuoBgsqRNfq7ym8LOrGH2gvdUSzKyUqGJAlFrgE
         REe4ySzPwlRXQ==
Received: by mail-lf1-f54.google.com with SMTP id x27so17548992lfu.5
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 17:41:31 -0700 (PDT)
X-Gm-Message-State: AOAM532sPxrYUEukyGHxhYgwW/5ZrPRN74DVlp6YC1XoU2ivkuVVK9Dp
        Jo2Zsz7zqu8IzoLHjjgviHZNJR8lIv5lf2qKhxw=
X-Google-Smtp-Source: ABdhPJxOttcePKsRirTeu6qKJWipMHO6yVysEjI8l5gBrcxjH+qqLnYTL6jG9TtD7zb4E5i66irBwFGLIc310O1dhPk=
X-Received: by 2002:a05:6512:3046:: with SMTP id b6mr1177958lfb.650.1633567289578;
 Wed, 06 Oct 2021 17:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633535940.git.zhuyifei@google.com> <a2e569ee61e677ee474b7538adcebb0e1462df69.1633535940.git.zhuyifei@google.com>
In-Reply-To: <a2e569ee61e677ee474b7538adcebb0e1462df69.1633535940.git.zhuyifei@google.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 6 Oct 2021 17:41:18 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4UaidSZXj4-L9t4Ez9TjzoXR6yQvwn_7LC87hYmJbtFw@mail.gmail.com>
Message-ID: <CAPhsuW4UaidSZXj4-L9t4Ez9TjzoXR6yQvwn_7LC87hYmJbtFw@mail.gmail.com>
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

This is pretty complicated, but the logic looks all correct. Thus,

Acked-by: Song Liu <songliubraving@fb.com>

One question, if the program want to retrieve existing errno_val, and
set a different one, it needs to call the helper twice, right? I guess it
is possible to do that in one call with a "swap" logic. Would this work?

Thanks,
Song
