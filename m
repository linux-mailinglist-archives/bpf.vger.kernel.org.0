Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A9E476ABD
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 08:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbhLPHCt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 02:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbhLPHCt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 02:02:49 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97B0C061574
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 23:02:48 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 131so61975482ybc.7
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 23:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JFEye+WBxBic+t6/c2O6Rekf/HygzRfj/D8B0ayzUe4=;
        b=l0UdLqQEei3DrzaDYAsxtazcQny3iK4XLfLla1LQYAs/S12ou15tSmxkU2kqxwMhR/
         xgHcO0E6EhmgZNIGKffrMBCEfmqIjrk52FhsP7OonYFeO18AFBLWf01n8kHqQ7PMsRDI
         HOmv+yYCKbx3Y1FKzrRUGUfdyTZvnHbUhT762mEkm5767Gw/Ij+HAdwIeUwLLH57Ac8S
         CnmKW3NbzoxD1gOwi4eWu4knLo3oFvXp9xpg2s3yaSS+OaCmJzw9gd6QkyWGsrEjPAFq
         ZrhBSOqqVfEmtDqkSGrJJ5YpidocBGXN0vegP4j/st6VQiMJ7/WtHfTecSwEgVEYiplU
         Ym2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JFEye+WBxBic+t6/c2O6Rekf/HygzRfj/D8B0ayzUe4=;
        b=l5ooLa27u18oYbQIOVqa7/kAJYmVRTz5kPhrAGoXmvjInRHWh558j4CR7E2TAu6Thg
         71Aihmm/TaFmaIDhcosDfWl2qk0gvCKSu8AitBSL/H/ao2k2E8gTmRxR3dMzTLuJM2PY
         EQb1TGGbiTwkkrEqF1tCxGyihmVp3AOOMOx4RJJ0VX8D+BFQckNLRHxiESzsEMhfGKIK
         2n24nPqhTd++arftkhvgM11drpRWbBaeJCBhG9euV6HByVqtnVZM585xGt3dGlzCoO8O
         GyVMjEmRM2iF9/Uj6A1eW1IyLGyUWfBl+JrfFA0sfTB1GZpSkbugKsKQgAhqD6T1UEdz
         WVbg==
X-Gm-Message-State: AOAM532dj6IXVC10E771pvak8whhCqs7BK3G/3Erc9+sb3NscCSItZKB
        2pd3GlTJIdX0xu6wRtHoGlDzXB56JNAN+QXZHMg=
X-Google-Smtp-Source: ABdhPJwqNFcdqPz7+7HFUrN4wtODBQP3kylhLQ1yb/6NQt2lbC/x0SzUBYfM316YjK37IEu5fD6HDoha3qdQycuT80c=
X-Received: by 2002:a25:e90a:: with SMTP id n10mr10941900ybd.180.1639638168227;
 Wed, 15 Dec 2021 23:02:48 -0800 (PST)
MIME-Version: 1.0
References: <20211215192225.1278237-1-christylee@fb.com> <20211215192225.1278237-4-christylee@fb.com>
In-Reply-To: <20211215192225.1278237-4-christylee@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 15 Dec 2021 23:02:37 -0800
Message-ID: <CAEf4BzY5UFJwHQsuPDYkGxtS67VFnG2kn+_s02yPS=3SJP4++w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/3] Only output backtracking information in
 log level 2
To:     Christy Lee <christylee@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, christyc.y.lee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 15, 2021 at 11:22 AM Christy Lee <christylee@fb.com> wrote:
>
> Backtracking information is very verbose, don't print it in log
> level 1 to improve readability.
>
> Signed-off-by: Christy Lee <christylee@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>  kernel/bpf/verifier.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a8f1426b0367..2cb86972ed35 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2398,7 +2398,7 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx,
>
>         if (insn->code == 0)
>                 return 0;
> -       if (env->log.level & BPF_LOG_LEVEL) {
> +       if (env->log.level & BPF_LOG_LEVEL2) {
>                 verbose(env, "regs=%x stack=%llx before ", *reg_mask, *stack_mask);
>                 verbose(env, "%d: ", idx);
>                 print_bpf_insn(&cbs, insn, env->allow_ptr_leaks);
> @@ -2656,7 +2656,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
>                 DECLARE_BITMAP(mask, 64);
>                 u32 history = st->jmp_history_cnt;
>
> -               if (env->log.level & BPF_LOG_LEVEL)
> +               if (env->log.level & BPF_LOG_LEVEL2)
>                         verbose(env, "last_idx %d first_idx %d\n", last_idx, first_idx);
>                 for (i = last_idx;;) {
>                         if (skip_first) {
> @@ -2743,7 +2743,7 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int regno,
>                                 new_marks = true;
>                         reg->precise = true;
>                 }
> -               if (env->log.level & BPF_LOG_LEVEL) {
> +               if (env->log.level & BPF_LOG_LEVEL2) {
>                         mark_verifier_state_scratched(env);
>                         verbose(env, "parent %s regs=%x stack=%llx marks:",
>                                 new_marks ? "didn't have" : "already had",
> --
> 2.30.2
>
