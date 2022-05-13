Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DB9526C1F
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 23:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357529AbiEMVLS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 17:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343722AbiEMVLP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 17:11:15 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DFF1010
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 14:11:14 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id j12so6528421ila.12
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 14:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9U1jGv7lvv6SaC9wGp9+37ISJBQZwLsb7m9Ryb9vIWA=;
        b=o4eTuBJ7/98J+9gIe2wqe7kfJAOf9kLZ3UrJ9LHRzg31sWuE9GWwrmdfTF0qorbHF0
         ofQ7qTcBpShoOUhA/ymaXwkVwFCKzDntEu2sgbT0DPdeLumEtmqTuYEvClVTmAxmhRSz
         ZfGNiLyMGfnO6USkvxPo9GLqzjQA0bohsMA4vJG0YfhVdXQri14hRkcOLs6VuG4Kdt7y
         LCQ5Vc2Pt8qqt2dyYdz5PV/qg+UlBpJ6HrbJabIs6lThGlppGqABuzRma710ZK7+pUpG
         yUsiNZI8kDsNtxSKflWiXeUBWla6mEQQVzBcZqSeDcW6lnlA/5g94bYihbhztDDOq0rj
         5jKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9U1jGv7lvv6SaC9wGp9+37ISJBQZwLsb7m9Ryb9vIWA=;
        b=S5IDqzQrbSDABL0O/BodvJhXb+O+c/nEnGWE07tAroEJKOhiKpavb13zcqBjihW0IO
         z2w2m0+Mm1R9XmpKYo+SLuuKU0flBq8HGWb/4JG+BFzmaXAjzrAlUsC8y1WqMXpEK/5H
         U8j89kD8Mrht9XzEjWHiGxpDQdECTdAEzxizSxTw2b6EJAw0CTuK1pUlEivF8JUFFTpH
         hISwqP/tVXxY7Zde+8suU93kf/bv+sLuEV8xaD4lluZmNEBEF2rHx0UIgPelYJDuG8Ak
         U/MVnViV6kNcwRrcUM/SuoQOy7+G4TMGFUotmpeACFIsHbelOuItbk68+X2ZzmoDE3Df
         Wjuw==
X-Gm-Message-State: AOAM53271BdHP2vClXF+YthgUis104hLGaReqRIYXw/mnDCqsA/6qyfd
        VWRasZjUeKO+BZ3O1kSzk/5pKTi8q6B+0CvGkjs=
X-Google-Smtp-Source: ABdhPJzsEszeZF0xgvZ3I2rnTZ+D0vktHfeBquIoYqIT8euLu6gPdU6s4t74d3z4Dy1kU246H1wHrdvMRcjN0fQJcEk=
X-Received: by 2002:a92:d250:0:b0:2d0:f240:d5f5 with SMTP id
 v16-20020a92d250000000b002d0f240d5f5mr3154015ilg.252.1652476273551; Fri, 13
 May 2022 14:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220509224257.3222614-1-joannelkoong@gmail.com> <20220509224257.3222614-6-joannelkoong@gmail.com>
In-Reply-To: <20220509224257.3222614-6-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 May 2022 14:11:02 -0700
Message-ID: <CAEf4BzZ6qTe8di+Wmu-Syffo8ULK_uA1hdki7fbpxw4y8WRsog@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 5/6] bpf: Add dynptr data slices
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Mon, May 9, 2022 at 3:44 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> This patch adds a new helper function
>
> void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len);
>
> which returns a pointer to the underlying data of a dynptr. *len*
> must be a statically known value. The bpf program may access the returned
> data slice as a normal buffer (eg can do direct reads and writes), since
> the verifier associates the length with the returned pointer, and
> enforces that no out of bounds accesses occur.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---

Minor nit below.

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>  include/linux/bpf.h            |  4 ++
>  include/uapi/linux/bpf.h       | 12 ++++++
>  kernel/bpf/helpers.c           | 28 ++++++++++++++
>  kernel/bpf/verifier.c          | 67 +++++++++++++++++++++++++++++++---
>  tools/include/uapi/linux/bpf.h | 12 ++++++
>  5 files changed, 117 insertions(+), 6 deletions(-)
>

[...]

> @@ -797,6 +806,20 @@ static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_re
>         return state->stack[spi].spilled_ptr.dynptr.type == arg_to_dynptr_type(arg_type);
>  }
>
> +static bool is_ref_obj_id_dynptr(struct bpf_func_state *state, u32 id)
> +{
> +       int allocated_slots = state->allocated_stack / BPF_REG_SIZE;
> +       int i;
> +
> +       for (i = 0; i < allocated_slots; i++) {
> +               if (state->stack[i].slot_type[0] == STACK_DYNPTR &&
> +                   state->stack[i].spilled_ptr.id == id)
> +                       return true;

there is probably no harm, but strictly speaking we should check only
stack slot that corresponds to the start of dynptr, right?

> +       }
> +
> +       return false;
> +}
> +
>  /* The reg state of a pointer or a bounded scalar was saved when
>   * it was spilled to the stack.
>   */

[...]
