Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92856D516E
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 21:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjDCTfs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 15:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjDCTfr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 15:35:47 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A881FD5
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 12:35:42 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r11so121730304edd.5
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 12:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680550541; x=1683142541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVtc+y9c9MrbK7pLVHKWMDvppBI6sQFyE6Iy0Z+P+OA=;
        b=oCTJ4c44LlwhBD8L862Q4/pnnbb0PUnZfxLsnIoF8ba+hZkB7vQfikMr0sIKJw7hor
         aCHSpd4Xfoc3+5y5nfHad5RN5fHTOOhf7o8eEikdKCr3a90kFAqAjAzvqJ6emZChxwKZ
         XEPz9fwEIOPOfoJOShK+Lbi4SGWcd1oPR5g+aZ5sSV53hgZ96Z80jo/9DPrs6eRRVogD
         VX5oLFaRb90wk0CM2PW4hJO3GJSSJY32/BgZ5Nq8DvQ0C5ZCcGgGpQI0cW37U8q+mT/E
         sWFZfoLCbaqZnjYhP0koz7S0QqPvmAiwPWSMfEivo8+pS5kHV2N85uhE7mCxbc7ysKSK
         /6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680550541; x=1683142541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVtc+y9c9MrbK7pLVHKWMDvppBI6sQFyE6Iy0Z+P+OA=;
        b=PJHeGy7+gzXnfG7WHJTBgJch4scwpXjSUGcAXfOkLbvy5IIW2a6CVDsOaJ8aXPK1/1
         //cNhZIzpFZRUzF0Md00c56EFYrPm5+5Mbvm+5S6Oj61XfjsCzztvVIxOHEs+17l9+/i
         Ki0YtBN7yrDEq2s4qryvbJygg33wdpN1fS2EHbDCw8aABOF1myrxT7v6fv3nUqdvTmsJ
         kXXZ/6UDIN4KwM7izHSMyrJoPAAUlJMZUhVvRDdK9HmNgUyCcLC2JRlyHKmIh1RgZYRA
         hF+7JYKIaRRSbRBB6vUPDiGpaLq4td6kZJuoQW8FECoY6qooCf7L9D3TAHTSRyWZCRJS
         io5w==
X-Gm-Message-State: AAQBX9dAMrevCBw9Eh4TFRERmY0TFcBu648hvgPePaEVoJ+ec9MSgq6o
        FEWNYA5c/jdkzNGuaWb5hh0jR/5S/AhpEuv/SVOMNtul
X-Google-Smtp-Source: AKy350ag8E3rDwYb9U8Lul1zoEvciaOjiS9EarlYPf0MfwfYF9226hC0J9QxF85etRPjC1ZHqoeYQLUqHltt4Wj102c=
X-Received: by 2002:a50:d089:0:b0:4fb:7ccf:337a with SMTP id
 v9-20020a50d089000000b004fb7ccf337amr100372edd.3.1680550541002; Mon, 03 Apr
 2023 12:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230403173125.1056883-1-davemarchevsky@fb.com>
In-Reply-To: <20230403173125.1056883-1-davemarchevsky@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 3 Apr 2023 12:35:29 -0700
Message-ID: <CAADnVQKG1RuWpqpp5jA7bz2xJpbZfiurK3DvwJLNLB3Gxq8u9w@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix struct_meta lookup for bpf_obj_free_fields
 kfunc call
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 3, 2023 at 10:31=E2=80=AFAM Dave Marchevsky <davemarchevsky@fb.=
com> wrote:
>
> bpf_obj_drop_impl has a void return type. In check_kfunc_call, the "else
> if" which sets kptr_struct_meta for bpf_obj_drop_impl is
> surrounded by a larger if statement which checks btf_type_is_ptr. As a
> result:
>
>   * The bpf_obj_drop_impl-specific code will never execute
>   * The btf_struct_meta input to bpf_obj_drop is always NULL
>   * bpf_obj_drop_impl will always see a NULL btf_record when called
>     from BPF program, and won't call bpf_obj_free_fields
>   * program-allocated kptrs which have fields that should be cleaned up
>     by bpf_obj_free_fields may instead leak resources
>
> This patch adds a btf_type_is_void branch to the larger if and moves
> special handling for bpf_obj_drop_impl there, fixing the issue.
>
> Fixes: ac9f06050a35 ("bpf: Introduce bpf_obj_drop")
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
> I can send a version of this patch which applies on bpf-next as well,
> but think this makes sense in bpf as the issue exists there too.

I'd like to avoid the merge conflict in this tricky area of the verifier.
Let's get it through bpf-next first and then we can backport it to stable
after bpf-next gets pulled during the merge window.
