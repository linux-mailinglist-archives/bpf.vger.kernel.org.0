Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE04763164F
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 21:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiKTUQV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 15:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKTUQT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 15:16:19 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9D712092
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 12:16:17 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ud5so24390796ejc.4
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 12:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jnzFQrxoyceIbScrTKdd4o19W60/hsaKzMsKCUpT7SE=;
        b=h9D0CiO7sJCSYQMqdsaUXuHWPC+qJqTyiwWMIIrvJJMe17oJk0Ea1vrulGhpxU/5EU
         9wX/6wgNRbB0fnjeQJh7yh7z2GTo9TwSwPOZg2u7x1GGmx9gjcIBpARz8RVgOC9MuUbY
         Yy0lqkY7Vdu+BvKKCFTm5cBgrZn+9aiXCOYNgYp0lr1l1eTrpOdZk7ZoSINC+jumG5jn
         onmh90IdX8ZyvwqBeXXLm1yXQ9qP4zBSc35cczDWnfiM5bU0qiyL5RnxtXgrg/HXCeAW
         ZTHE4VZW5yXBCeEVudpirk9dP17W3VTCtzKS2oSawzDELvZpbMupP7yVyBv4c+Ge0C+d
         hPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnzFQrxoyceIbScrTKdd4o19W60/hsaKzMsKCUpT7SE=;
        b=uDh7jKA1Z0OJ1OUu5X57bMz3v+7k7K3JNvtElMqNGqEyZnXMWBz+Hl+Pe4ItZmv8vr
         dPxJDfWon9ZIaG1Fcr75kLdZhi52GIOsrE8fLZ1VKX+x+SbWMHaO7dX/crfe9V2iTsEe
         g+ETxzI6UbbJ7MxEqC96/+7tlJAf2bdC2E1Ooe0I7x3Y8DOcdvHbiLKuV/z0UEAU1Rbm
         zW8T4yO+BN18DHkj1RvweJA8aU4TIv0iM6VbImLu14QwWPBlxgMADg7BJ2bEYIB3doBb
         zSwluFyEh8vgsjQS4URHzByio0p4f1RxN9ulYYTVE8kBwk/TMDVcVuXxC/iiI+7V3V8a
         TxGQ==
X-Gm-Message-State: ANoB5pn+6p3sdZZcXNTRQWkPMxpkzHVGAAzDfPc51BDGFmst6htpKXCE
        ReyG9q8UiGexLSjxEJcvzIwa+NL1cOh+EZ28uTE=
X-Google-Smtp-Source: AA0mqf5AlDZH7FYpeKZgAOrqENm69Cviray6sF8Tx5gN1+NmSTHAnupwa4YgTa0Jj3foKqGFL+lVXMAWGZ5CaLNkmew=
X-Received: by 2002:a17:906:2ac3:b0:7ad:f2f9:2b49 with SMTP id
 m3-20020a1709062ac300b007adf2f92b49mr2112838eje.94.1668975375430; Sun, 20 Nov
 2022 12:16:15 -0800 (PST)
MIME-Version: 1.0
References: <20221120195421.3112414-1-yhs@fb.com> <20221120195437.3114585-1-yhs@fb.com>
In-Reply-To: <20221120195437.3114585-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 20 Nov 2022 12:16:04 -0800
Message-ID: <CAADnVQ+92vwqUB=J-QJYtrW0Yqvx2HAJJBREkXPJtW0+gyS1mQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Add a kfunc for generic type cast
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 20, 2022 at 11:57 AM Yonghong Song <yhs@fb.com> wrote:
>
> @@ -8938,6 +8941,24 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>                                 regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_TRUSTED;
>                                 regs[BPF_REG_0].btf = desc_btf;
>                                 regs[BPF_REG_0].btf_id = meta.ret_btf_id;
> +                       } else if (meta.func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
> +                               if (!capable(CAP_PERFMON)) {
> +                                       verbose(env,
> +                                               "kfunc bpf_rdonly_cast requires CAP_PERFMON capability\n");
> +                                       return -EACCES;
> +                               }

Just realized that bpf_cast_to_kern_ctx() has to be
gated by cap_perfmon as well.

Also the direct capable(CAP_PERFMON) is not quite correct.
It should at least be perfmon_capable().
But even better to use env->allow_ptr_leaks here.
