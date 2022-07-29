Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E095584A55
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 05:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbiG2Dvn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 23:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbiG2Dvk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 23:51:40 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8553C4AD4B
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 20:51:39 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id y9so2555693qtv.5
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 20:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VVLENy3LPh95mhi2xJgnxH73SWwfWDHHc6Zw1S4ewWk=;
        b=F7bVwxDS/4ZPprmVkY+83whgQIzky9i9rpHH2Fi6UWwicsVJeUJHzAEpCMTkObQOQO
         I9NbyePISPve9zoHOGKUCklWyFSlPlDNbiiSki7jK+UdCJnmS4d540SvWxp8DTSMe/Yj
         81Q4UV9XTArpjEswH+iVJEKrhc6IGnoI6C0SiefLECVrX8XGwHz2sCTfenjrHOcioxj2
         qTzMrVHdsbXN49m3HCO/NcSYHUIWuy4txYJLrWTas38jnEZDVBfXBpzD+Scjuw5ifVTi
         2XqqLav+8ekiN07l7AsAjqjgpSI57GZnNr8iSnUaobaVVh8dPSMDOf5O0/t4T8WCrpHS
         Y47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVLENy3LPh95mhi2xJgnxH73SWwfWDHHc6Zw1S4ewWk=;
        b=wCP/nx4Nk0GzPQp6pZVNLxr/GIa+SGI7hVVFWZCMtrsax2hF2JaO1L8VQbntm4s4Bn
         8TcizPVkdJV9xYe1OnEq/nVVhz2WgAW+DOuAguMnGwQ9QDLBJX3pKPyYdalQWNl/SWWA
         wVqQud5XKmX/dqqO1tO5UlVN43v2Bfrl+D6qihNWdkSPBBLwEgnJbVyMY4TvGNU0N5AM
         5lOeQrB/4GBU8fbEQuvFjx9/LA6RZzqyH6mc1cThpNG87DiMj7Q1KvNvWT4XiNqMyaNL
         2oMuOUCcLDceAPSHzCyjg0OQDDTivmCSsVI9Da53V/0MGbS67vLDA7mAVoz/L67Rw50Z
         vhYw==
X-Gm-Message-State: AJIora/Bt+aYN7ez7+BNb+2u3kFD0HCaKv7yNW5MzsgetT7Wi3YjyJy2
        gbLRBC0u+lZ4VHwuENV1w6Fdtn2MKUCWMuYq4cF4lQ==
X-Google-Smtp-Source: AGRyM1tyWsBKFwm7MLq/p6gIvRY/SWoM7rjgG997eKwFx2E6u2vlATwbax3QGVPc9I7M0AyJc9BJQDz2APoVErrJ/vA=
X-Received: by 2002:ac8:5793:0:b0:31f:4aa:81dd with SMTP id
 v19-20020ac85793000000b0031f04aa81ddmr1808965qta.299.1659066698566; Thu, 28
 Jul 2022 20:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220729033033.3022-1-liulin063@gmail.com>
In-Reply-To: <20220729033033.3022-1-liulin063@gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 28 Jul 2022 20:51:27 -0700
Message-ID: <CA+khW7hVwRQwXshymZCotPZyHmWXj7gjZvJO1_NnjnBSNjYj+A@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Do more tight ALU bounds tracking
To:     Kuee K1r0a <liulin063@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On Thu, Jul 28, 2022 at 8:31 PM Kuee K1r0a <liulin063@gmail.com> wrote:
>
> 32bit bounds and 64bit bounds are updated separately in
> adjust_scalar_min_max_vals() currently, let them learn from each other to
> get more tight bounds tracking. Similar operation can be found in
> reg_set_min_max().
>
> Before:
>
>     func#0 @0
>     0: R1=ctx(off=0,imm=0) R10=fp0
>     0: (b7) r0 = 0                        ; R0_w=0
>     1: (b7) r1 = 0                        ; R1_w=0
>     2: (87) r1 = -r1                      ; R1_w=scalar()
>     3: (87) r1 = -r1                      ; R1_w=scalar()
>     4: (c7) r1 s>>= 63                    ; R1_w=scalar(smin=-1,smax=0)
>     5: (07) r1 += 2                       ; R1_w=scalar(umin=1,umax=2,var_off=(0x0; 0xffffffff))  <--- [*]
>     6: (95) exit
>
> It can be seen that even if the 64bit bounds is clear here, the 32bit
> bounds is still in the state of 'UNKNOWN'.
>
> After:
>
>     func#0 @0
>     0: R1=ctx(off=0,imm=0) R10=fp0
>     0: (b7) r0 = 0                        ; R0_w=0
>     1: (b7) r1 = 0                        ; R1_w=0
>     2: (87) r1 = -r1                      ; R1_w=scalar()
>     3: (87) r1 = -r1                      ; R1_w=scalar()
>     4: (c7) r1 s>>= 63                    ; R1_w=scalar(smin=-1,smax=0)
>     5: (07) r1 += 2                       ; R1_w=scalar(umin=1,umax=2,var_off=(0x0; 0x3))  <--- [*]
>     6: (95) exit
>
> Fixes: 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking")
> Signed-off-by: Kuee K1r0a <liulin063@gmail.com>

Please sign with your real name. Thanks.


> ---
>  kernel/bpf/verifier.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0efbac0fd126..888aa50fbdc0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8934,10 +8934,13 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
>                 break;
>         }
>
> -       /* ALU32 ops are zero extended into 64bit register */
> -       if (alu32)
> +       if (alu32) {
> +               /* ALU32 ops are zero extended into 64bit register */
>                 zext_32_to_64(dst_reg);
> -       reg_bounds_sync(dst_reg);
> +               __reg_combine_32_into_64(dst_reg);
> +       } else {
> +               __reg_combine_64_into_32(dst_reg);
> +       }
>         return 0;
>  }
>
> --
> 2.25.1
>
