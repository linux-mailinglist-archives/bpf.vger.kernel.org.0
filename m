Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEC7567D08
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 06:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiGFEUD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 00:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiGFEUC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 00:20:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D728272C;
        Tue,  5 Jul 2022 21:20:01 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id d2so24983533ejy.1;
        Tue, 05 Jul 2022 21:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yNb3MBEJDM+YoION0QcdxpOPKNemiXs4iO3pQn6MzQM=;
        b=mqdDLIqZNq8O5XMh1SkSUNqZkt8rYFkbj2NwjpRAT1eHJvZS8NF1NZrjjOxxeJOWD4
         q6wai0C0/1SfSDK3AQHv0EoGikLQ7DU6CF8caQkv+ujCtu8Nc36GzFJLGqRXb8mW717u
         eS4ZtvqqvKaD7jTlk3+9w1QXKD+u47LZv/KpxNHYaftBge5fgsrBrFVcO1fEkno51mvh
         SKydOocQEeVZUvg+bCWG81H2/mUr72iv2J7jra/CtzIU3dz8sTe5xtXlTNLbANzfZNAH
         zbWp/CHzYQ3o4YEsMy8xNjkuNcVFsrFpqFV++ACD1RQuB9kEmPglzkG4uovJHm3f1kcq
         yQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNb3MBEJDM+YoION0QcdxpOPKNemiXs4iO3pQn6MzQM=;
        b=7F97EyiGT88fwd/+VASSHeOoI3hUSe477BOrBRerhdLcKEX5DwFLbGgvWlpiRxU49n
         stdD2eBzenLb+5qOoTfzhCSn1tJVGfHam+LJowtJHa6PXmAXKiDFQfCm3jr7UOs0aqdV
         q+sryrOoUgbx+b5oLsj3PMfiUWegF8TZju8A954rz/Y1vpumev2FoAu/wSgy+1CcGESn
         FLsgot3UNGhtF7m7jcJBj+gartbcoo+8qsNGvWleXVj6X4ZlPJqIvmR67Z27U8yISVBk
         H9WBr4jPirZeFB8WEY/CuS2wkP+yVvdckUuff2F3e8Q6asFIt0PmiFnWTUCsprU94lPD
         i0LQ==
X-Gm-Message-State: AJIora+1n16ky+/GtgQPtYDmll3GuJF9TVaGeL+U3dlyLGEWs5d/6lPy
        abBpxdrp6rfO2+mR2qE+0IBV3wWWTaMtG8lFRAw=
X-Google-Smtp-Source: AGRyM1vjDTlznqXjiZlszFP8R+w8AdQijRclYDvT2Z6fJAJ0IiRRS4sA8K1PG8AG45Xi5j1d/YMOrie03FI2Tc+A/PY=
X-Received: by 2002:a17:906:5189:b0:722:dc81:222a with SMTP id
 y9-20020a170906518900b00722dc81222amr37207026ejk.502.1657081200020; Tue, 05
 Jul 2022 21:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <1656942916-13491-1-git-send-email-alan.maguire@oracle.com> <1656942916-13491-2-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1656942916-13491-2-git-send-email-alan.maguire@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 5 Jul 2022 21:19:48 -0700
Message-ID: <CAADnVQKvtoBkCEBNcwKp1dp9_OPy9CtLD=QqscMQQJdoUf7OkQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: add a ksym BPF iterator
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Vernet <void@manifault.com>, swboyd@chromium.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Kenny Yu <kennyyu@fb.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 4, 2022 at 6:55 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>  static inline int kallsyms_for_perf(void)
>  {
>  #ifdef CONFIG_PERF_EVENTS
> @@ -885,6 +967,18 @@ const char *kdb_walk_kallsyms(loff_t *pos)
>  static int __init kallsyms_init(void)
>  {
>         proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
> +#if defined(CONFIG_BPF_SYSCALL)
> +       {
> +               int ret;
> +
> +               ksym_iter_reg_info.ctx_arg_info[0].btf_id = *btf_ksym_iter_id;
> +               ret = bpf_iter_reg_target(&ksym_iter_reg_info);
> +               if (ret) {
> +                       pr_warn("Warning: could not register bpf ksym iterator: %d\n", ret);
> +                       return ret;
> +               }
> +       }
> +#endif

The ifdef-s inside the function body are not pretty.
I feel the v2 version was cleaner.
static void __init bpf_ksym_iter_register()
were only missing late_initcall(bpf_ksym_iter_register);
to make it single #ifdef CONFIG_BPF_SYSCALL for everything.
wdyt?
