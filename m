Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B45325918
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 22:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbhBYV4s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 16:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbhBYVzK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Feb 2021 16:55:10 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45389C061574
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 13:54:26 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id b10so6956460ybn.3
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 13:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8QEVbYS96RYxhXuJjlz/g+AZyvGqKE19N04vY9FI4iI=;
        b=tEgqmChn0LjESjfncyOKZzlZJRV555EXX7GqKiEDZQc6daY/cLED8bOoWF7kTFdiTD
         8/04f6q35SWk3XpV04nAPAUhRnGTBV+pgGLOJfYblg1Icyl3KhURuARl1syPqAznheoN
         XLbLtjBQ2llaDZDS8/G6l9TvhUhPm5DFLjQlRVVt39s6bEnPVbHfewFdqEgyKV5asgDP
         VU9FSosH6kYwxAnpUgjAKFBxcdtb/HE24DcKf6ORWfaOGSLPk8wLbHlnU4ZD5R4PhGHT
         JPP2/uG/yQ2Y0x7uGIKvKzeApfWPSwzKhZhRnTXmInBqeYMN8Dz+WWhpLyGvAKXRr/px
         K5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8QEVbYS96RYxhXuJjlz/g+AZyvGqKE19N04vY9FI4iI=;
        b=jo+CAjJ5+8b7MASPGAaFD8BKCqqj0Kp/VgcdW7I4GDguxx9lMyd2XalDR9NzwdDPzQ
         LulFqhGVXAIfFSW0bUf8RgDpQSBODYjOlmxh/Ba9ZQ5JhBTSTMJSNAUtsG8thnhz7Jaz
         umQXRYZFamiCfvkQ9GEt4Uf7CZPyngcNqqIPBltlCIxLqTIPqjogintJhec+tPjQQGDe
         +6LdRF6qeoJUw9dIfm9L948lRLCaDLbwhaoRZDk6COfKwe/Q2VPfZ75MKhyjmJh3vitQ
         fWH1K983fwiY9bxh6W0xEbMLIAExkurDoABeonkzw5XvBnTC1zTaxKkBgtfuvkZTZHs7
         +q6Q==
X-Gm-Message-State: AOAM532wsWyT4U8nXEuKxbGjuYpl9Tef3CvPLU6AcJdCjU5PKkZjcJpj
        qmZqxk3WWWnbfqWAQP+X/njNmDvVz5ihgKTvV90=
X-Google-Smtp-Source: ABdhPJxjPH6q/+SnpLUsW1vaGEofX+fd1IENWEAss5YlIM2tTc0h1fDdyf8p18KxHzUw26XMYz88UxU7lZrjuX8AB5Q=
X-Received: by 2002:a25:f40e:: with SMTP id q14mr7179256ybd.230.1614290065567;
 Thu, 25 Feb 2021 13:54:25 -0800 (PST)
MIME-Version: 1.0
References: <20210225073309.4119708-1-yhs@fb.com> <20210225073309.4119838-1-yhs@fb.com>
In-Reply-To: <20210225073309.4119838-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Feb 2021 13:54:14 -0800
Message-ID: <CAEf4BzYfN6Rbp+Xph3Z4=YpUfikHrgXBSrhXvYRzg7SyqpUcBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 01/11] bpf: factor out visit_func_call_insn()
 in check_cfg()
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 25, 2021 at 1:35 AM Yonghong Song <yhs@fb.com> wrote:
>
> During verifier check_cfg(), all instructions are
> visited to ensure verifier can handle program control flows.
> This patch factored out function visit_func_call_insn()
> so it can be reused in later patch to visit callback function
> calls. There is no functionality change for this patch.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/bpf/verifier.c | 35 +++++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1dda9d81f12c..9cb182e91162 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8592,6 +8592,27 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env,
>         return DONE_EXPLORING;
>  }
>
> +static int visit_func_call_insn(int t, int insn_cnt,
> +                               struct bpf_insn *insns,

both insns and insn_cnt seem to be derivatives of env
(env->prog->insnsi and env->prog->len), so it shouldn't be necessary
to pass them in.

> +                               struct bpf_verifier_env *env,
> +                               bool visit_callee)
> +{
> +       int ret;
> +
> +       ret = push_insn(t, t + 1, FALLTHROUGH, env, false);
> +       if (ret)
> +               return ret;
> +
> +       if (t + 1 < insn_cnt)
> +               init_explored_state(env, t + 1);
> +       if (visit_callee) {
> +               init_explored_state(env, t);
> +               ret = push_insn(t, t + insns[t].imm + 1, BRANCH,
> +                               env, false);
> +       }
> +       return ret;
> +}
> +
>  /* Visits the instruction at index t and returns one of the following:
>   *  < 0 - an error occurred
>   *  DONE_EXPLORING - the instruction was fully explored
> @@ -8612,18 +8633,8 @@ static int visit_insn(int t, int insn_cnt, struct bpf_verifier_env *env)

similarly for visit_insn, insn_cnt is just env->prog->len, so it's
signature could be simplified as well


>                 return DONE_EXPLORING;
>
>         case BPF_CALL:
> -               ret = push_insn(t, t + 1, FALLTHROUGH, env, false);
> -               if (ret)
> -                       return ret;
> -
> -               if (t + 1 < insn_cnt)
> -                       init_explored_state(env, t + 1);
> -               if (insns[t].src_reg == BPF_PSEUDO_CALL) {
> -                       init_explored_state(env, t);
> -                       ret = push_insn(t, t + insns[t].imm + 1, BRANCH,
> -                                       env, false);
> -               }
> -               return ret;
> +               return visit_func_call_insn(t, insn_cnt, insns, env,
> +                                           insns[t].src_reg == BPF_PSEUDO_CALL);
>
>         case BPF_JA:
>                 if (BPF_SRC(insns[t].code) != BPF_K)
> --
> 2.24.1
>
