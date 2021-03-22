Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1CE34399A
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 07:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhCVGkD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 02:40:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26714 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229613AbhCVGjy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Mar 2021 02:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616395193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+8IdJoevmZWZkG/xLGUFXkRYS+Hb9spepADHELKX9Y4=;
        b=AMDxt6rl7jncpO0Z2t5j8cTg8JXGdJ6UdVyH8McHP4wi/bBi4wavi6PAjeaZIQaHk1fLxu
        zjXejB5fe7l6Tts9pxqGOcTZy6YwWclKTBWnYKNFQCQjZONBESEqRr7En9sC9zY7ajWZWj
        2fxRTZy2ZKA3/dK4uIFsy6kr7NZnQv0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-xTgY-9tOOiS_dvN7WEO70Q-1; Mon, 22 Mar 2021 02:39:51 -0400
X-MC-Unique: xTgY-9tOOiS_dvN7WEO70Q-1
Received: by mail-wr1-f71.google.com with SMTP id y5so25500644wrp.2
        for <bpf@vger.kernel.org>; Sun, 21 Mar 2021 23:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+8IdJoevmZWZkG/xLGUFXkRYS+Hb9spepADHELKX9Y4=;
        b=FEXWSjE3Ge0txHdniBV9pJ+voNiKBbsj9GRlJDjMdW2ei064VdtLSbAL+yL+FMw5Uu
         JrG1e2vPA1+TjL1eHbiMGLG7G80QNSAiatMkA1JwPPi7rLX4algrrA8qDCYRSZps8xzB
         641B3SVtlynKdYJ90y+PT759CLFGDeqHHY6ML5R/thzXmyfQuest8B3hnJLjU4ro9++j
         AJ344SUEAI4c5uTNbcm9oPBdZ0PCXd1yEMilXH8Y6Kw7cdkP3gS1RxYAOyOOxi2DjYzH
         nXnFOuohmz6xczm1hGpqmjoF+zTHrF4KHdXyDpri1jceJYOzY/esFfPGi6mMnjphrNz1
         x98Q==
X-Gm-Message-State: AOAM532Wsu3d0lQZH8k99bIGYeW1M8X9BU+l3sb+Ed7QGlJF1nDd5b3o
        oNpDWYBwvv7OX07KgGHhHjOUWmIFFk/kZbP20c1FTIsSlLDmPUbYZJzsqoSXiNXGL9Gdc4JR/Or
        L5JJaEg/0rpuA9CKY9IGkYcwksAaS
X-Received: by 2002:a5d:538d:: with SMTP id d13mr16678121wrv.92.1616395190093;
        Sun, 21 Mar 2021 23:39:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygnULs6gPuCcPzqFMrRaHkwnKJYoC4WCJjzIHHRivv+fBRfyqKdQqeRbqjfG1Slpanjds7JbTo4EdRD3Sw55o=
X-Received: by 2002:a5d:538d:: with SMTP id d13mr16678113wrv.92.1616395189972;
 Sun, 21 Mar 2021 23:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210320000001.915366-1-sdf@google.com>
In-Reply-To: <20210320000001.915366-1-sdf@google.com>
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
Date:   Mon, 22 Mar 2021 08:39:34 +0200
Message-ID: <CANoWswkz33qw4_QOcdbVg4=DjM9SHQwgvj5ef+UGdMUxt4MgNg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: use NOP_ATOMIC5 instead of emit_nops(&prog, 5)
 for BPF_TRAMP_F_CALL_ORIG
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 20, 2021 at 2:01 AM Stanislav Fomichev <sdf@google.com> wrote:
>
> __bpf_arch_text_poke does rewrite only for atomic nop5, emit_nops(xxx, 5)
> emits non-atomic one which breaks fentry/fexit with k8 atomics:
>
> P6_NOP5 == P6_NOP5_ATOMIC (0f1f440000 == 0f1f440000)
> K8_NOP5 != K8_NOP5_ATOMIC (6666906690 != 6666666690)
>
> Can be reproduced by doing "ideal_nops = k8_nops" in "arch_init_ideal_nops()
> and running fexit_bpf2bpf selftest.
>
> Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Could you mention x86 in the subject?

> ---
>  arch/x86/net/bpf_jit_comp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 72b5a57e9e31..b35fc8023884 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2012,7 +2012,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>                 /* remember return value in a stack for bpf prog to access */
>                 emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
>                 im->ip_after_call = prog;
> -               emit_nops(&prog, 5);
> +               memcpy(prog, ideal_nops[NOP_ATOMIC5], X86_PATCH_SIZE);
> +               prog += X86_PATCH_SIZE;
>         }
>
>         if (fmod_ret->nr_progs) {
> --
> 2.31.0.rc2.261.g7f71774620-goog
>


-- 
WBR, Yauheni

