Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C331785F4
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 23:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgCCWwK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 17:52:10 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:40584 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgCCWwK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 17:52:10 -0500
Received: by mail-qv1-f65.google.com with SMTP id ea1so128231qvb.7;
        Tue, 03 Mar 2020 14:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F2T/hdztknZaZB9rKuLdx0utKPRLSLq4Mg2YsdbGcC0=;
        b=XEwASVUmB4oaP3s0oDkZzi6JsecN7KwtiIEl3P5ngtN8cSWwtI2Adetpf0WAeqRkdk
         3hR1tsFjYwh8mOamu8kyt/UwOgwATvv9Ew47X7/4ruist9pf59WYmIlo19LY85ZjCBQT
         vcqbfmN9p6VG1DuDk92PIauxQHgr3b/TPScuRl0Mg1EcCsFi0w0qQBp3lnCKsAt1rwFI
         8qAAi2wfauEfpuGYZTv2RoxwlW+G39s5ZsawHsw/QZ5oTVvUTM2Uz33fH6Hmj/3kJbZq
         LO1uLnJAyewWR6ZRaqkvzJnAcCuUvUWmtVv3jI9/BxKLzyD7hnulU3SenJkCY3a+aDK0
         paaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F2T/hdztknZaZB9rKuLdx0utKPRLSLq4Mg2YsdbGcC0=;
        b=cxWQ75H8vN7ZDMbfMUH+heVQMM2QYZJYsOxsESpBlfuvjdyQsTrPUKRcr5OJNDQUSX
         gI+EOFrXCPQYta8FNQQ/TPOoV7CJoTnN+Vrj28MzFb0RshUOiMKnWITXjSe2YjGpp+eE
         BVSblQY9H54GvtkQJJP0Z5rKAMRPuRdhSZR5XjpKPH+5GBZvnakCa27eRf2lO/zPygvE
         yyEaAk2cVEzjvJeyj2TN2Bx9yyR/5oEiAdtEdkDolloiF4qhwxcUTkhRjjm4EXd+kwqP
         9vfCPZiO4fOi1MhkvNgmOfdtU5Gk3aAczZVgZCFPRdz3xey4xCvv1fbBHk/pZq8HzZsA
         teqA==
X-Gm-Message-State: ANhLgQ3kfMBHDsz2cByURGsv3GFPcGjOBEu9ItNmirE14xZKg/ToUwp5
        2ip3SpJ+9XVA5rqmYmOl/dN7eNDvNL0+xjyA0LQ=
X-Google-Smtp-Source: ADFU+vufaQrsAOt5svrMYrq8s5hJnkB7lLd51fX+/EzVRn+ZH4nbFzFMVE0C0T2aD4qpXwjabYn/4DjUfwV4hfdqwj4=
X-Received: by 2002:a05:6214:8cb:: with SMTP id da11mr5745752qvb.228.1583275928811;
 Tue, 03 Mar 2020 14:52:08 -0800 (PST)
MIME-Version: 1.0
References: <20200303140950.6355-1-kpsingh@chromium.org> <20200303140950.6355-7-kpsingh@chromium.org>
In-Reply-To: <20200303140950.6355-7-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 3 Mar 2020 14:51:57 -0800
Message-ID: <CAEf4BzZwazh1DnGJKBgFgrp4m5B_3AwjsxkJVBh6cxQceiLcBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] bpf: Add test ops for BPF_PROG_TYPE_TRACING
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 3, 2020 at 6:12 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> The current fexit and fentry tests rely on a different program to
> exercise the functions they attach to. Instead of doing this, implement
> the test operations for tracing which will also be used for
> BPF_OVERRIDE_RETURN in a subsequent patch.

typo: BPF_OVERRIDE_RETURN -> BPF_MODIFY_RETURN?

>
> Also, clean up the fexit test to use the generated skeleton.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---

Nice clean up for fexit_test, thank you!

>  include/linux/bpf.h                           | 10 +++
>  kernel/trace/bpf_trace.c                      |  1 +
>  net/bpf/test_run.c                            | 38 +++++++---
>  .../selftests/bpf/prog_tests/fentry_fexit.c   | 12 +---
>  .../selftests/bpf/prog_tests/fentry_test.c    | 14 ++--
>  .../selftests/bpf/prog_tests/fexit_test.c     | 69 ++++++-------------
>  6 files changed, 68 insertions(+), 76 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3cfdc216a2f4..c00919025532 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1156,6 +1156,9 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
>                           union bpf_attr __user *uattr);
>  int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>                           union bpf_attr __user *uattr);
> +int bpf_prog_test_run_tracing(struct bpf_prog *prog,
> +                             const union bpf_attr *kattr,
> +                             union bpf_attr __user *uattr);
>  int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
>                                      const union bpf_attr *kattr,
>                                      union bpf_attr __user *uattr);
> @@ -1313,6 +1316,13 @@ static inline int bpf_prog_test_run_skb(struct bpf_prog *prog,
>         return -ENOTSUPP;
>  }
>
> +static inline int bpf_prog_test_run_tracing(struct bpf_prog *prog,
> +                                           const union bpf_attr *kattr,
> +                                           union bpf_attr __user *uattr)
> +{
> +       return -ENOTSUPP;
> +}
> +
>  static inline int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
>                                                    const union bpf_attr *kattr,
>                                                    union bpf_attr __user *uattr)
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 07764c761073..363e0a2c75cf 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1266,6 +1266,7 @@ const struct bpf_verifier_ops tracing_verifier_ops = {
>  };
>
>  const struct bpf_prog_ops tracing_prog_ops = {
> +       .test_run = bpf_prog_test_run_tracing,
>  };
>
>  static bool raw_tp_writable_prog_is_valid_access(int off, int size,
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 562443f94133..fb54b45285b4 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -160,18 +160,38 @@ static void *bpf_test_init(const union bpf_attr *kattr, u32 size,
>                 kfree(data);
>                 return ERR_PTR(-EFAULT);
>         }
> -       if (bpf_fentry_test1(1) != 2 ||
> -           bpf_fentry_test2(2, 3) != 5 ||
> -           bpf_fentry_test3(4, 5, 6) != 15 ||
> -           bpf_fentry_test4((void *)7, 8, 9, 10) != 34 ||
> -           bpf_fentry_test5(11, (void *)12, 13, 14, 15) != 65 ||
> -           bpf_fentry_test6(16, (void *)17, 18, 19, (void *)20, 21) != 111) {
> -               kfree(data);
> -               return ERR_PTR(-EFAULT);
> -       }
> +
>         return data;
>  }
>
> +int bpf_prog_test_run_tracing(struct bpf_prog *prog,
> +                             const union bpf_attr *kattr,
> +                             union bpf_attr __user *uattr)
> +{
> +       int err = -EFAULT;
> +
> +       switch (prog->expected_attach_type) {
> +       case BPF_TRACE_FENTRY:
> +       case BPF_TRACE_FEXIT:
> +               if (bpf_fentry_test1(1) != 2 ||
> +                   bpf_fentry_test2(2, 3) != 5 ||
> +                   bpf_fentry_test3(4, 5, 6) != 15 ||
> +                   bpf_fentry_test4((void *)7, 8, 9, 10) != 34 ||
> +                   bpf_fentry_test5(11, (void *)12, 13, 14, 15) != 65 ||
> +                   bpf_fentry_test6(16, (void *)17, 18, 19, (void *)20, 21) != 111)
> +                       goto out;
> +               break;
> +       default:
> +               goto out;
> +       }

No trace_bpf_test_finish here?

> +
> +       return 0;
> +
> +out:
> +       trace_bpf_test_finish(&err);
> +       return err;
> +}
> +
>  static void *bpf_ctx_init(const union bpf_attr *kattr, u32 max_size)
>  {
>         void __user *data_in = u64_to_user_ptr(kattr->test.ctx_in);

[...]
