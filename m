Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE5D64C168
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 01:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237996AbiLNAic (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 19:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237953AbiLNAiJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 19:38:09 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A1326ABB
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 16:35:19 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id u19so22410388ejm.8
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 16:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s4LH1FZFjsPe3OfvesgUR8LU3jzydAntnRyS1B3vMug=;
        b=YeLxT8dW6OSND3rW+oFDrXcJmcPekzXIaJRPLGTEJs2QXnYrSahud8YogG+ovMdh4k
         XwDbwLG4B0dDlOLCMZv3xyEV5Ft6IHkT2aS2Vmqr+BCl92NkCwawYB3bOxb5zUpDXH0H
         lMwclmp1un0b9070cAVSmUHvZfARr98gHCAn4YUPQKc9hoN6IFMHVxCID+LUdiaJHKbH
         3cyZLgKQnxchloD0WCH/5UEsezmbe/geFQJtrVjtM7iZEE8U1utqCqBX05XKwOjyRkYH
         N6fcstxjl3MxGn69CiKOdQcJ0KXPgNzVd5nti9N6eVNYeiEjWyQiC5SW++FrZxy+SwNI
         +g/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4LH1FZFjsPe3OfvesgUR8LU3jzydAntnRyS1B3vMug=;
        b=5U/sRXA82YZL9bBiqre9I0dJzYfKetVUzyhuoqJFJsZV2UnTMnTAe0cM46282Jbqjp
         xsVqu5LiBUHUcUR3TmjpWsxT1JLL8rwsFRcXHa2LwmQLJOw4m/9V/tROdbbyOP/Ru8yt
         YM8CyU9bKPRzW8k2BXOYDbBJ1qnvgn5VsVGrzMx1BSGeNIduLAS/UnZpCi8+4Xyp0li7
         XEKBGS+Cbk+sc/co/y5iwKzZkejZCfLx07LhFJ+c80+ltgX+VmlIfrVioAjFEs3vsmu/
         Bpf8qCZLycFXUdk7i0q68qQzbh/kDflmh1gGxodREtQAzQQ3+WWRy5/jxhXdn8Qd+pXk
         NW3A==
X-Gm-Message-State: ANoB5pnSd+Nb6ecZJ1HO9D1JeaStuM+m13YTWBjLEfTUetJ+BvL/scLw
        KxXyBksdVrva/HNzA4Y610dQZXWghZQtMo5wxH3JVm9K
X-Google-Smtp-Source: AA0mqf5358K0qDORDG0ahXnYoYvOQubZ9z3Cvi6OKvr0LbVhUQ4Uh4qsLfCBdxomxfKR6WPFOlY+IXo3rwc1yTqykxo=
X-Received: by 2002:a17:906:7116:b0:7c1:8450:f964 with SMTP id
 x22-20020a170906711600b007c18450f964mr681849ejj.176.1670978116923; Tue, 13
 Dec 2022 16:35:16 -0800 (PST)
MIME-Version: 1.0
References: <20221209135733.28851-1-eddyz87@gmail.com> <20221209135733.28851-2-eddyz87@gmail.com>
In-Reply-To: <20221209135733.28851-2-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 13 Dec 2022 16:35:04 -0800
Message-ID: <CAEf4BzbPBeAUzueQ7mxcmSovY2Nqr37RFZnb5B1pwSDqNhyZ6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: regsafe() must not skip check_ids()
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
> The verifier.c:regsafe() has the following shortcut:
>
>         equal = memcmp(rold, rcur, offsetof(struct bpf_reg_state, parent)) == 0;
>         ...
>         if (equal)
>                 return true;
>
> Which is executed regardless old register type. This is incorrect for
> register types that might have an ID checked by check_ids(), namely:
>  - PTR_TO_MAP_KEY
>  - PTR_TO_MAP_VALUE
>  - PTR_TO_PACKET_META
>  - PTR_TO_PACKET
>
> The following pattern could be used to exploit this:
>
>   0: r9 = map_lookup_elem(...)  ; Returns PTR_TO_MAP_VALUE_OR_NULL id=1.
>   1: r8 = map_lookup_elem(...)  ; Returns PTR_TO_MAP_VALUE_OR_NULL id=2.
>   2: r7 = ktime_get_ns()        ; Unbound SCALAR_VALUE.
>   3: r6 = ktime_get_ns()        ; Unbound SCALAR_VALUE.
>   4: if r6 > r7 goto +1         ; No new information about the state
>                                 ; is derived from this check, thus
>                                 ; produced verifier states differ only
>                                 ; in 'insn_idx'.
>   5: r9 = r8                    ; Optionally make r9.id == r8.id.
>   --- checkpoint ---            ; Assume is_state_visisted() creates a
>                                 ; checkpoint here.
>   6: if r9 == 0 goto <exit>     ; Nullness info is propagated to all
>                                 ; registers with matching ID.
>   7: r1 = *(u64 *) r8           ; Not always safe.
>
> Verifier first visits path 1-7 where r8 is verified to be not null
> at (6). Later the jump from 4 to 6 is examined. The checkpoint for (6)
> looks as follows:
>   R8_rD=map_value_or_null(id=2,off=0,ks=4,vs=8,imm=0)
>   R9_rwD=map_value_or_null(id=2,off=0,ks=4,vs=8,imm=0)
>   R10=fp0
>
> The current state is:
>   R0=... R6=... R7=... fp-8=...
>   R8=map_value_or_null(id=2,off=0,ks=4,vs=8,imm=0)
>   R9=map_value_or_null(id=1,off=0,ks=4,vs=8,imm=0)
>   R10=fp0
>
> Note that R8 states are byte-to-byte identical, so regsafe() would
> exit early and skip call to check_ids(), thus ID mapping 2->2 will not
> be added to 'idmap'. Next, states for R9 are compared: these are not
> identical and check_ids() is executed, but 'idmap' is empty, so
> check_ids() adds mapping 2->1 to 'idmap' and returns success.
>
> This commit pushes the 'equal' down to register types that don't need
> check_ids().
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/verifier.c | 29 ++++++++---------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 3194e9d9e4e4..d05c5d0344c6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12926,15 +12926,6 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>
>         equal = memcmp(rold, rcur, offsetof(struct bpf_reg_state, parent)) == 0;
>
> -       if (rold->type == PTR_TO_STACK)
> -               /* two stack pointers are equal only if they're pointing to
> -                * the same stack frame, since fp-8 in foo != fp-8 in bar
> -                */
> -               return equal && rold->frameno == rcur->frameno;
> -
> -       if (equal)
> -               return true;
> -
>         if (rold->type == NOT_INIT)
>                 /* explored state can't have used this */
>                 return true;
> @@ -12942,6 +12933,8 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>                 return false;
>         switch (base_type(rold->type)) {
>         case SCALAR_VALUE:
> +               if (equal)
> +                       return true;
>                 if (env->explore_alu_limits)
>                         return false;
>                 if (rcur->type == SCALAR_VALUE) {
> @@ -13012,20 +13005,14 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>                 /* new val must satisfy old val knowledge */
>                 return range_within(rold, rcur) &&
>                        tnum_in(rold->var_off, rcur->var_off);
> -       case PTR_TO_CTX:
> -       case CONST_PTR_TO_MAP:
> -       case PTR_TO_PACKET_END:
> -       case PTR_TO_FLOW_KEYS:
> -       case PTR_TO_SOCKET:
> -       case PTR_TO_SOCK_COMMON:
> -       case PTR_TO_TCP_SOCK:
> -       case PTR_TO_XDP_SOCK:
> -               /* Only valid matches are exact, which memcmp() above
> -                * would have accepted
> +       case PTR_TO_STACK:
> +               /* two stack pointers are equal only if they're pointing to
> +                * the same stack frame, since fp-8 in foo != fp-8 in bar
>                  */
> +               return equal && rold->frameno == rcur->frameno;
>         default:
> -               /* Don't know what's going on, just say it's not safe */
> -               return false;
> +               /* Only valid matches are exact, which memcmp() */
> +               return equal;

Is it safe to assume this for any possible register type? Wouldn't
register types that use id and/or ref_obj_id need extra checks here? I
think preexisting default was a safer approach, in which if we forgot
to explicitly add support for some new or updated register type, the
worst thing is that for that *new* register we'd have suboptimal
verification performance, but not safety concerns.


>         }
>
>         /* Shouldn't get here; if we do, say it's not safe */
> --
> 2.34.1
>
