Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268C564C169
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 01:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237955AbiLNAif (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 19:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbiLNAiN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 19:38:13 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8922E26ADE
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 16:35:24 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id kw15so40865887ejc.10
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 16:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CZEtV6xyvzKglDHqCG2fgpPcFC6xyU67NyIV30Im0V4=;
        b=YhJZ+t1tDHMHauPECxSJEPrcCyAii4VMhUag/AaE8Yzw9izA1vYTjmXhf+fo9cbzZc
         EwmgSaXtErvEHvVRujGSSTdpUPsf7/8gCQRYGKcaHpJA1R3LEPyzGcwp12eAdDVFw7H/
         oKHzMSqUIgIhgdF76TeLGFZnMKfsYqzanVWTqufLD/QuWlZvCo48Oq4p/YTinMYGbgqB
         0sVW8ksEs+liz5gcbStgyQA8NKFmTCsn4tWVxzV6sRlelmZElnhTGmjWcwKv7NBGj3y8
         j9SAg0/8m+DyejtNI645b1LQPco95xPNRmSgbVJc0VvuvdtbfSPLq5Qz8CvIrVB97qR+
         Uumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZEtV6xyvzKglDHqCG2fgpPcFC6xyU67NyIV30Im0V4=;
        b=I8QIE/XAKf9Hkf/BWj/7KVd7BEIFKITrprEAoSwxzOTluNexjt9VNDlYgS9KJzMXbo
         feFFTOL7aMDIauXOXw7asRNIjf8ESxKGGfVcf4fGo8yRQTtPzfoHtMagawH8qij9MlLQ
         KvngJSMa4B8DI9CrBwqlVS5V6F0ur+s4J422nYqPGITSyRIt7QyhJABIqZuIclJi7J+Y
         EhfW1CyyqKUhszh9/m4OvPMQyol9vHi26gFm6wJnr3wygj35Iuu46FmEBrSxCV6NjJvL
         FOp3ivvBSgtxRiMB0oBtpIhuEawFddr/GcJcw/IEIQgLgNM19P4eE2sIdZRPNXL0hS31
         ViUw==
X-Gm-Message-State: ANoB5pk0cwKfIDiS4qXNqY4V4ZK6RL0qs0NWNrvLGbDuZ1vRY57JIopz
        cUVbc++bC5RLwmKyIGdiIuuHMGejqYQ4NpcA+Zc=
X-Google-Smtp-Source: AA0mqf4BfQGJmbiEhMuPvTkXITKpck3/WUEwITZ4DJfYbAiiknADdgfsPA5jV8bbH9svDpZV0NbQhxyI7gOWftubKt4=
X-Received: by 2002:a17:906:6403:b0:7b2:9667:241e with SMTP id
 d3-20020a170906640300b007b29667241emr81990731ejm.115.1670978119441; Tue, 13
 Dec 2022 16:35:19 -0800 (PST)
MIME-Version: 1.0
References: <20221209135733.28851-1-eddyz87@gmail.com> <20221209135733.28851-4-eddyz87@gmail.com>
In-Reply-To: <20221209135733.28851-4-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 13 Dec 2022 16:35:07 -0800
Message-ID: <CAEf4BzZRx8XaD4fvSA04U2iRDnmWiYzbAGTiB_MDS1RqWXztBQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: states_equal() must build idmap for all
 function frames
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        memxor@gmail.com, ecree.xilinx@gmail.com
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

On Fri, Dec 9, 2022 at 5:58 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> verifier.c:states_equal() must maintain register ID mapping across all
> function frames. Otherwise the following example might be erroneously
> marked as safe:
>
> main:
>     fp[-24] = map_lookup_elem(...)  ; frame[0].fp[-24].id == 1
>     fp[-32] = map_lookup_elem(...)  ; frame[0].fp[-32].id == 2
>     r1 = &fp[-24]
>     r2 = &fp[-32]
>     call foo()
>     r0 = 0
>     exit
>
> foo:
>   0: r9 = r1
>   1: r8 = r2
>   2: r7 = ktime_get_ns()
>   3: r6 = ktime_get_ns()
>   4: if (r6 > r7) goto skip_assign
>   5: r9 = r8
>
> skip_assign:                ; <--- checkpoint
>   6: r9 = *r9               ; (a) frame[1].r9.id == 2
>                             ; (b) frame[1].r9.id == 1
>
>   7: if r9 == 0 goto exit:  ; mark_ptr_or_null_regs() transfers != 0 info
>                             ; for all regs sharing ID:
>                             ;   (a) r9 != 0 => &frame[0].fp[-32] != 0
>                             ;   (b) r9 != 0 => &frame[0].fp[-24] != 0
>
>   8: r8 = *r8               ; (a) r8 == &frame[0].fp[-32]
>                             ; (b) r8 == &frame[0].fp[-32]
>   9: r0 = *r8               ; (a) safe
>                             ; (b) unsafe
>
> exit:
>  10: exit
>
> While processing call to foo() verifier considers the following
> execution paths:
>
> (a) 0-10
> (b) 0-4,6-10
> (There is also path 0-7,10 but it is not interesting for the issue at
>  hand. (a) is verified first.)
>
> Suppose that checkpoint is created at (6) when path (a) is verified,
> next path (b) is verified and (6) is reached.
>
> If states_equal() maintains separate 'idmap' for each frame the
> mapping at (6) for frame[1] would be empty and
> regsafe(r9)::check_ids() would add a pair 2->1 and return true,
> which is an error.
>
> If states_equal() maintains single 'idmap' for all frames the mapping
> at (6) would be { 1->1, 2->2 } and regsafe(r9)::check_ids() would
> return false when trying to add a pair 2->1.
>
> This issue was suggested in the following discussion:
> https://lore.kernel.org/bpf/CAEf4BzbFB5g4oUfyxk9rHy-PJSLQ3h8q9mV=rVoXfr_JVm8+1Q@mail.gmail.com/
>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/bpf_verifier.h | 4 ++--
>  kernel/bpf/verifier.c        | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 70d06a99f0b8..c1f769515beb 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -273,9 +273,9 @@ struct bpf_id_pair {
>         u32 cur;
>  };
>
> -/* Maximum number of register states that can exist at once */
> -#define BPF_ID_MAP_SIZE (MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE)
>  #define MAX_CALL_FRAMES 8
> +/* Maximum number of register states that can exist at once */
> +#define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE) * MAX_CALL_FRAMES)

this is overly pessimistic, the total number of stack slots doesn't
change no matter how many call frames we have, it would be better to
define this as:

#define BPF_ID_MAP_SIZE (MAX_BPF_REG * MAX_CALL_FRAMES + MAX_BPF_STACK
/ BPF_REG_SIZE)

Unless I missed something.



>  struct bpf_verifier_state {
>         /* call stack tracking */
>         struct bpf_func_state *frame[MAX_CALL_FRAMES];
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d05c5d0344c6..9188370a7ebe 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13122,7 +13122,6 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
>  {
>         int i;
>
> -       memset(env->idmap_scratch, 0, sizeof(env->idmap_scratch));
>         for (i = 0; i < MAX_BPF_REG; i++)
>                 if (!regsafe(env, &old->regs[i], &cur->regs[i],
>                              env->idmap_scratch))
> @@ -13146,6 +13145,8 @@ static bool states_equal(struct bpf_verifier_env *env,
>         if (old->curframe != cur->curframe)
>                 return false;
>
> +       memset(env->idmap_scratch, 0, sizeof(env->idmap_scratch));
> +
>         /* Verification state from speculative execution simulation
>          * must never prune a non-speculative execution one.
>          */
> --
> 2.34.1
>
