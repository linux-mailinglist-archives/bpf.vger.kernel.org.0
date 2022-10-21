Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20E16081F7
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 01:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiJUXEh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 19:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJUXEg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 19:04:36 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E607D3B453
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 16:04:30 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r14so11195664edc.7
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 16:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s0hd3JzEqY7xTp1xxhuoDGOclH3Sm82QZR/DRm/tQJ0=;
        b=UuBuvAUpZ3ivokfE4sCE8ud/auC+2WP00665EefAdXR9DDgSzSMC16BgayPNc8n1bf
         TBhFyikzcAzZMiYYdurBd/6JyxjYt8UyE85RXPU6RnVTdAiJWjhtzeQsR5n+wR8P7D+C
         rOJsiIg1KClvfyxX+lfWvzZrMWtOaxkc96FRaqlR4gYs6kUEN9Pbc5tgIDrFzWzUKX08
         qO49bu3v2OaC58MOro63iAjt12N6hYJLUMf/UO28sMhwZ5P4fMeXshYekT5D5gOmOUBt
         n3kj5YPc4l6r0V9UXoWjbwNcbBzKPDpecaGTzMTcfaXmaAfU5GmNr+15cDbJ4QuVHnCG
         GUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0hd3JzEqY7xTp1xxhuoDGOclH3Sm82QZR/DRm/tQJ0=;
        b=XhRRa425UlFRiT3By6ySChfB3tK3gea92aGIRXJJUK4U2R+ltKEutNus5hm8H8+nMY
         2vJbxyM5M9tR22LyVbOuBGHAbh/VPKkOv/3OX8LAOXvGbr215ju3Vus6pZB2MfRcI1mX
         +9VyKZcSum1JDyMTG7VJgdfvBgLrMKvM9EdksqDbK3Ow2QwdpqrK76X9N/GZHSR27u5G
         BntUkdTgpcKp4GeZv7/9EVtGeQlvtf6qwzCQiGbRVddb/pIb2XWqmY+J33tKqdKECewS
         dkEjXADrQPLPiFry6mfMhXp08Mwj3wx95rCc6NcOa9DWETRfxkK1SqNEUJd6J1tadSjc
         mMyg==
X-Gm-Message-State: ACrzQf1FxcWlC2UZd24VywjMMk190rsbbhcQrfsun3vEvPMo8V71k97f
        ExOIt2/Qh//nOgWCZLa6Hp3Q1LfBYudFnBVaYa8=
X-Google-Smtp-Source: AMsMyM7W5aun7B4EGKnFqo6EGAhalDDxFYM+kiJ3CNTEFNz40Ew3Cl98WhbFfP2zcMrw+c47XiPekx/H+PzHM9ECFB8=
X-Received: by 2002:a17:907:2d0b:b0:78e:674:6b32 with SMTP id
 gs11-20020a1709072d0b00b0078e06746b32mr17450667ejc.226.1666393468799; Fri, 21
 Oct 2022 16:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221020160721.4030492-1-davemarchevsky@fb.com>
In-Reply-To: <20221020160721.4030492-1-davemarchevsky@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Oct 2022 16:04:16 -0700
Message-ID: <CAEf4BzarV0hPAXZzmDuR5_XX6LfLwWTPAXxDAd2wWJRRKEDaTA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/4] bpf: Allow ringbuf memory to be used as
 map key
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
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

On Thu, Oct 20, 2022 at 9:07 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> This patch adds support for the following pattern:
>
>   struct some_data *data = bpf_ringbuf_reserve(&ringbuf, sizeof(struct some_data, 0));
>   if (!data)
>     return;
>   bpf_map_lookup_elem(&another_map, &data->some_field);
>   bpf_ringbuf_submit(data);
>
> Currently the verifier does not consider bpf_ringbuf_reserve's
> PTR_TO_MEM | MEM_ALLOC ret type a valid key input to bpf_map_lookup_elem.
> Since PTR_TO_MEM is by definition a valid region of memory, it is safe
> to use it as a key for lookups.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> v2->v3: lore.kernel.org/bpf/20220914123600.927632-1-davemarchevsky@fb.com
>
>   * Add Yonghong ack, rebase
>
> v1->v2: lore.kernel.org/bpf/20220912101106.2765921-1-davemarchevsky@fb.com
>
>   * Move test changes into separate patch - patch 2 in this series.
>     (Kumar, Yonghong). That patch's changelog enumerates specific
>     changes from v1
>   * Remove PTR_TO_MEM addition from this patch - patch 1 (Yonghong)
>     * I don't have a usecase for PTR_TO_MEM w/o MEM_ALLOC
>   * Add "if (!data)" error check to example pattern in this patch
>     (Yonghong)
>   * Remove patch 2 from v1's series, which removed map_key_value_types
>     as it was more-or-less duplicate of mem_types
>     * Now that PTR_TO_MEM isn't added here, more differences between
>       map_key_value_types and mem_types, and no usecase for PTR_TO_BUF,
>       so drop for now.
>
>  kernel/bpf/verifier.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6f6d2d511c06..97351ae3e7a7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5641,6 +5641,7 @@ static const struct bpf_reg_types map_key_value_types = {
>                 PTR_TO_PACKET_META,
>                 PTR_TO_MAP_KEY,
>                 PTR_TO_MAP_VALUE,
> +               PTR_TO_MEM | MEM_ALLOC,
>         },
>  };
>
> --
> 2.30.2
>
