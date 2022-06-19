Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923D8550D9E
	for <lists+bpf@lfdr.de>; Mon, 20 Jun 2022 01:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiFSXhz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Jun 2022 19:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiFSXhy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Jun 2022 19:37:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0C1317
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 16:37:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y19so17976413ejq.6
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 16:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1jAMmJOUC9nZj5heCzBViozs9wQrTPw9g8rOhXgIZ8A=;
        b=hOz3qbKYlptEDRgNbgJrOz56FCDx0Y/L+UxpbPqGswCUJywZz3hm2DHFjlnKtKS+eK
         Elmq14VdBIfyOfD1LzqV727ZmCaVrBOmq8dBSf4zd2Wb6lfRCdwLBwhwF/VIW2K5pwk6
         LuZ7Xp/k/7LthinhL+FjrJ6Srvf9nhV0ReQ1mcF0Cm9zsuizDllahR+7pxTWjgX/7HTQ
         c6MB3ce1DQ3rGoGHKpIkJiNwS05bs9MmlHZPI7hnfnedzKiP8wJ4LGW/zQOuSD6SjfdU
         yRD6tIWZ9s5DjAhQpDTUQEA9bvmgyMSAmKXzj96RdB6pZntmSk2LLptNDgQNtQeLHnHm
         nR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1jAMmJOUC9nZj5heCzBViozs9wQrTPw9g8rOhXgIZ8A=;
        b=kCXfQ6oYvSoe9JMyZIiTxbez3noBEop0ieg2jm5oEACvZztbSHsDd9+qu0U+oVAE6T
         orbYoj2uVPZrvnZ6LkyTcSZGtRkf+zm7N6Z00GZKG+5/l6Zc8NpOY7Zj4uqFzICGqW+f
         PVWrIXOcxsxLWZklBMCruYezVKDEV/NpcNvnHjRJ9su/oFdPVw5MQuL6kRBFZXHFp5pc
         ydHyOghprR6hY7Zg5AHY69uL65Y6f20xiAItG70inei3vBxDaSMXRefoej9C6lNQYaR+
         O311KHUTJhIN53nf/8P334NIRX+0zcyotq7toIn9ywdCZrHqQJHMpQeIuons/3VmzZtt
         WUFA==
X-Gm-Message-State: AJIora/KzkUMfUzEwu3OBMzlG6e5mMFtC9dfbnOt/FdDRwpKRA75PvIi
        m2TnBNHgsKNG3eU+pPdOgbBAdjX6hrakwA0LG+g=
X-Google-Smtp-Source: AGRyM1s1DipKWzt34XqCldUI067TlUeTUoVrxht9ni6DYIPVqGCLy5xwiGtr0bZ20t42pmPuUIh7/E2xCSYHgh2ghM4=
X-Received: by 2002:a17:906:b816:b0:708:2e56:97d7 with SMTP id
 dv22-20020a170906b81600b007082e5697d7mr18480566ejb.502.1655681871985; Sun, 19
 Jun 2022 16:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220613205008.212724-1-eddyz87@gmail.com> <20220613205008.212724-4-eddyz87@gmail.com>
 <CAADnVQ+rwwCoEPQUg+CS_iXSzqoptrgtW4TpqoM9XkMW9Jj+ag@mail.gmail.com>
 <fb17ffcbdfa6b75813352133c5655f01aefe71ec.camel@gmail.com>
 <20220619211028.tuhgxmtivvwkzo7m@macbook-pro-3.dhcp.thefacebook.com> <b3441513293da1e7e25767446ed5c30592d190e4.camel@gmail.com>
In-Reply-To: <b3441513293da1e7e25767446ed5c30592d190e4.camel@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 19 Jun 2022 16:37:40 -0700
Message-ID: <CAADnVQKz7EFH+QGBtpO2j-MPNAAREta+GjHaKn2cN0LaNQk-1Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 3/5] bpf: Inline calls to bpf_loop when
 callback is known
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Song Liu <song@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
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

On Sun, Jun 19, 2022 at 3:01 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> /* Mark a register as having a completely unknown (scalar) value. */
> static void __mark_reg_unknown(const struct bpf_verifier_env *env,
>                                struct bpf_reg_state *reg)
> {
>         ...
>         reg->precise = env->subprog_cnt > 1 || !env->bpf_capable;

Ahh. Thanks for explaining.
We probably need to fix this conservative logic.
Can you repro the issue when you comment out above ?

Let's skip the test for now. Just add mark_chain_precision
to loop logic, so we don't have to come back to it later
when subprogs>1 is fixed.
