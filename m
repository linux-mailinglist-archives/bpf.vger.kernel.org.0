Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72F82782C2
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 10:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgIYIaf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Sep 2020 04:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgIYIaf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Sep 2020 04:30:35 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA8AC0613D3
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 01:30:35 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g96so1532918otb.12
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 01:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mWmwa9JC5bZp7G/kgbECrSTfUQDJvz8S5GELdlzNqG8=;
        b=SJTY7cKFjFnDstEGRA7+1nutbYzdN/53kOGHbt071fqg1h+zBsA82DVT/z8GcqzEqi
         ZcQBRb9IYMgTvuO6oIZkHJYd0SpNpNCfsp3R8JZmZ6mhSuKKE8zpcDE7JjyFE3EvlK27
         RMtLnjnGb/lIAILaz2w/VPROgPHqg4RZjKOs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mWmwa9JC5bZp7G/kgbECrSTfUQDJvz8S5GELdlzNqG8=;
        b=FbD0Jf8ToOlR1IoMCyOzn/K/O3ygWJEQ+Wd/S/xyUnv+aiEcerwPIs9nkf/+OURUgt
         aTVN2l5/PYDr8rSlsQa4PwhRFhjzjGDuOj0+tinB9wz73sdcDXBw2YXFn1MUrUyiR4ac
         KHL0b8BzAWi+n9SU+nNe7+FEP8Lfy/WZhdnXL0oa+gw/mfJQhv+TgXFFsaNpJgdAQ41K
         UgVK34KTRqP4dM/h9NoqMnYdvf2ApJObAh9pQBgyo9ZzlcUAf+v771XMqQUhvsF/Vy7H
         dqCojY/iPlXkNKDe2WEaSLzwg02Lwlaw1Vf71cXwXVWx/djUa3B7Kqe/S1qzrfO8VE5O
         +QZw==
X-Gm-Message-State: AOAM533uBsyb7Oh3u9zFQR3GPj+4jGmEZwVIyU571xv4lHI3EfhlWH8x
        4SnKbFSNhA1Dw/AGvx9eZ3C+0F3biWSPERE+gPWrrQ==
X-Google-Smtp-Source: ABdhPJzWLv5w/+dellM+oA+SDTjFHm9ZmoIHrJ2ZWkj52Azr8kuBpholAt9KovcrBTTVeNHAq2N88FPPQBqPw9tW1m4=
X-Received: by 2002:a05:6830:12c7:: with SMTP id a7mr2238981otq.334.1601022634761;
 Fri, 25 Sep 2020 01:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200925000337.3853598-1-kafai@fb.com> <20200925000421.3857616-1-kafai@fb.com>
In-Reply-To: <20200925000421.3857616-1-kafai@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 25 Sep 2020 09:30:23 +0100
Message-ID: <CACAyw99gZoQFErqL73sD9rvY4OPK6fDyE7ED5U0wHE7TGe-8Ug@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 07/13] bpf: selftest: Add ref_tracking
 verifier test for bpf_skc casting
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 25 Sep 2020 at 01:04, Martin KaFai Lau <kafai@fb.com> wrote:
>
> The patch tests for:
> 1. bpf_sk_release() can be called on a tcp_sock btf_id ptr.
>
> 2. Ensure the tcp_sock btf_id pointer cannot be used
>    after bpf_sk_release().
>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>

Acked-by: Lorenz Bauer <lmb@cloudflare.com>

> ---
>  .../selftests/bpf/verifier/ref_tracking.c     | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/verifier/ref_tracking.c b/tools/testing/selftests/bpf/verifier/ref_tracking.c
> index 056e0273bf12..006b5bd99c08 100644
> --- a/tools/testing/selftests/bpf/verifier/ref_tracking.c
> +++ b/tools/testing/selftests/bpf/verifier/ref_tracking.c
> @@ -854,3 +854,50 @@
>         .errstr = "Unreleased reference",
>         .result = REJECT,
>  },
> +{
> +       "reference tracking: bpf_sk_release(btf_tcp_sock)",
> +       .insns = {
> +       BPF_SK_LOOKUP(sk_lookup_tcp),
> +       BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
> +       BPF_EXIT_INSN(),
> +       BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
> +       BPF_EMIT_CALL(BPF_FUNC_skc_to_tcp_sock),
> +       BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
> +       BPF_EMIT_CALL(BPF_FUNC_sk_release),
> +       BPF_EXIT_INSN(),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
> +       BPF_EMIT_CALL(BPF_FUNC_sk_release),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_SCHED_CLS,
> +       .result = ACCEPT,
> +       .result_unpriv = REJECT,
> +       .errstr_unpriv = "unknown func",
> +},
> +{
> +       "reference tracking: use ptr from bpf_skc_to_tcp_sock() after release",
> +       .insns = {
> +       BPF_SK_LOOKUP(sk_lookup_tcp),
> +       BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
> +       BPF_EXIT_INSN(),
> +       BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
> +       BPF_EMIT_CALL(BPF_FUNC_skc_to_tcp_sock),
> +       BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 3),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
> +       BPF_EMIT_CALL(BPF_FUNC_sk_release),
> +       BPF_EXIT_INSN(),
> +       BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
> +       BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
> +       BPF_EMIT_CALL(BPF_FUNC_sk_release),
> +       BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_7, 0),
> +       BPF_EXIT_INSN(),
> +       },
> +       .prog_type = BPF_PROG_TYPE_SCHED_CLS,
> +       .result = REJECT,
> +       .errstr = "invalid mem access",
> +       .result_unpriv = REJECT,
> +       .errstr_unpriv = "unknown func",
> +},
> --
> 2.24.1
>


-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
