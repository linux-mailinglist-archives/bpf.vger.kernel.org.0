Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CE35E85A5
	for <lists+bpf@lfdr.de>; Sat, 24 Sep 2022 00:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiIWWOS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 18:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiIWWOR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 18:14:17 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD6F115A77
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:14:16 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z13so1897220edb.13
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 15:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=usRcIh7kBKC8VCCor3m8Pw49lz/tKKZrVix/e5fniJQ=;
        b=e/XZKzbHIt2XsdXtbdws6+66VFnkXUgfj2wcpGSj30hgiQVk+38geFm4LHebmSjXWU
         MJ5vLWbnlEU8Pu/zhdYWwbMUhvJGku12l4orjbafBegc+nXqA0Ri7d2BctAKKrE8pBKF
         mSwv94YsOoLyKx0Ztg76mALveQP5kbORtFWhyxco0RXKK6O1q4WWEMtufgzczU+P7+Uv
         WMgaiSGoOnpcW061Lz5yTqOHuqz5a9AYC6eo14rb3Ijb8lc7hIR2Pz/lWcf/304FOKjL
         pDTynBiuz4d4fBrmnToiqdObK4Toi4OotTVfyTKcysXB4/0clw4Cv9yc93WMXZknYBrK
         L+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=usRcIh7kBKC8VCCor3m8Pw49lz/tKKZrVix/e5fniJQ=;
        b=6W2m+fldQ4x3RwraIQejEdXlZHNNu+yOlzsgufaT6loSgQi29r4lOFmLYHYsNR/qcj
         7R7vOcEJWo2qkOVTFf+qdj93+D66Rb+wTAP1aT1wFPGFR8okuKj/3jPqARW3BqbRHy4x
         PJvJg4N5GXucn/VT5Kc+6CMz4YkINfOgIsVoYtQ3Do9SGrLcke7bNA/IF0SXuZwgxT4B
         bAGGx+aKxYe2qysFVu+Ewov20g73GiY3o+vDJeJVHpx2dwyPjd27nYKuFC3IHHRFay4v
         XLhViUITbPTajCEs24EYWcpoSr4WrZUrqbIDTI0hTgJomcd3G9LxPJhmVMBZpOvgJE2f
         CT9A==
X-Gm-Message-State: ACrzQf2irdTU94kgaGcEL3X6LL1K5hRUSZAIMVFkHeOlRRdVRauAO02d
        RKiZXfYmLeeWL4p2KkXUImJZ35602IRkOChPwjzgl3AMVpo=
X-Google-Smtp-Source: AMsMyM4UAlQa7kksG+BfVO5fTuD1Q9/9VojJ1RRmKAPcaR3PYsKBj4L2zuYxpra8EiuW2vN6nFA6vgoSNRvHH6PLvlU=
X-Received: by 2002:a05:6402:1a35:b0:455:32da:551b with SMTP id
 be21-20020a0564021a3500b0045532da551bmr8988242edb.14.1663971254589; Fri, 23
 Sep 2022 15:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220923060614.4025371-1-davemarchevsky@fb.com>
In-Reply-To: <20220923060614.4025371-1-davemarchevsky@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 23 Sep 2022 15:14:02 -0700
Message-ID: <CAEf4BzY9Ta5aiw6n2AHTYxENpYTAdYbVdN=ZiW8dimdM9QqbyQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: Allow ringbuf memory to be used as
 map key
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@fb.com>
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

On Thu, Sep 22, 2022 at 11:06 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
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

are there any differences between mem_types and map_key_value_types?
If not, should we just drop map_key_value_types? mem_types also alloc
any PTR_TO_MEM (not just ringbuf's MEM_ALLOC) and PTR_TO_BUF
(tracepoint context structs, I think?)

>         },
>  };
>
> --
> 2.30.2
>
