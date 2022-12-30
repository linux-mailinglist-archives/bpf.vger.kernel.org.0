Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E636593FD
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 02:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiL3BNX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Dec 2022 20:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbiL3BNW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Dec 2022 20:13:22 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B6D1705F
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 17:13:21 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i15so28803781edf.2
        for <bpf@vger.kernel.org>; Thu, 29 Dec 2022 17:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7IHo/RuteVpHkPeUi0Qlj5z8AamXszhPYyvjpZgDqWw=;
        b=o1AKb3UMMZeyIt1KnkBzEqWGowtjt9Q8LkGpuSnGYdizeFvR11VBM+Pk0F8Kgrp74z
         EwAwOYOuhMjzX5qDNTeC+QNL7zRxnPsRfbso5m8/OYnxRea4o+LX46NRIQC3dHE8SKkK
         eD4XdofblQi/mhpRd2cbpmdnAVTeyrG2mURE97pUNx0YynjusitkEjhJPIwvemxnknc6
         tKysCZoInTL68ODnwU4hYRrZ6wNH8bkv92NqNha6hn0tMfosEnYsKfC1EhjZZlBU4ubI
         eckWPTjKeRjAZi9trVuxf/G7gj7fm41jHCjCfphDX1MsppsD7fSjLjZgBIfJ7Am35LNj
         cYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7IHo/RuteVpHkPeUi0Qlj5z8AamXszhPYyvjpZgDqWw=;
        b=Lg1FX9tGtY5ENrMSvQ8WLYqSVXLKL28II9Bq5qOdGf0RlDJ9bH+wnWekOBjrt22iYe
         bZ12D0h+E30eBgR8xVywV14aZW6ZVmE998Jdfqdxu8faKqK/Hs52snO6JRvVWKLZ1w1C
         ZSbA46ESSBDdAcSianVsHNFFYiQ/ITL5WZVGOUFfFWn81JH+kx9lTAtbgOeOVvUhqOh/
         IcGRJWssc0DLM6EViMqDRF7LqOh434n8030hVdfC/O/Dxpy9wy6OoRf962rS83NSkMfL
         HktnL4uiOFyJZxcwIcTBDq5KtnvPapwONx0m5Vj+VW4HpvY5x7886YVEaehApfFy87mk
         u3Dw==
X-Gm-Message-State: AFqh2koIiEY4MAwSTSyzXhwJ27HiaK4+w92sUVrbg4+xkXa/GeWdh7M/
        2zXPRvrUXnj7f88pzstRnEDc/gbhCPRf6F5P+zY=
X-Google-Smtp-Source: AMrXdXtuX74riJ4yrwlQpanteAqX1JoMivAtzzTfsfYq2SLfJevJVgsOBW+CGN/3j5MFgWUGuhRLnTybZDTcPZxANqM=
X-Received: by 2002:a05:6402:50d:b0:46a:a12a:4dcd with SMTP id
 m13-20020a056402050d00b0046aa12a4dcdmr3648658edv.338.1672362800355; Thu, 29
 Dec 2022 17:13:20 -0800 (PST)
MIME-Version: 1.0
References: <20221230010738.45277-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20221230010738.45277-1-alexei.starovoitov@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 29 Dec 2022 17:13:09 -0800
Message-ID: <CAADnVQ+Ur_Z2j9SEP73BZdYPQrMxzjOWa-45z-cw9zvtANTmCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Migrate release_on_unlock logic to
 non-owning ref semantics
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
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

On Thu, Dec 29, 2022 at 5:07 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> @@ -11959,7 +11956,10 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
>                 dst_reg->type = PTR_TO_MAP_VALUE;
>                 dst_reg->off = aux->map_off;
>                 WARN_ON_ONCE(map->max_entries != 1);
> -               /* We want reg->id to be same (0) as map_value is not distinct */
> +               /* map->id is positive s32. Negative map->id will not collide with env->id_gen.
> +                * This lets us track active_lock state as single u32 instead of pair { map|btf, id }
> +                */
> +               dst_reg->id = -map->id;

Here is what I meant in my earlier reply to Dave's patches 1 and 2.
imo this is a simpler implementation of the same logic.
The only tricky part is above bit that is necessary
to use a single u32 in bpf_reg_state to track active_lock.
We can follow up with clean up of active_lock comparison
in other places of the verifier.
Instead of:
                if (map)
                        cur->active_lock.ptr = map;
                else
                        cur->active_lock.ptr = btf;
                cur->active_lock.id = reg->id;
it will be:
  cur->active_lock_id = reg->id;

Another cleanup is needed to compare active_lock_id properly
in regsafe().

Thoughts?
