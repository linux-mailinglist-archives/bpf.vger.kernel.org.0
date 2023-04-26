Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843636EF9EC
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 20:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239353AbjDZSRi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 14:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239340AbjDZSRh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 14:17:37 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C36283D4
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 11:17:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5067736607fso12973576a12.0
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 11:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682533054; x=1685125054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdQeKWXlxni4iD1fxvriLlvMwyXevXPK3SN0RPtPBiE=;
        b=Np6460R2bIyowGX5FG99vUL/IvCvtYrOX+1L540eYc3eadBkVrk2qeUc4edw88QUe/
         cCOCkX/J72EgtSRQE81RwUPuugBNxBfgEtH+1pbpZvDDhD99Q92/FaUGP98KtP1mFWKc
         h7S+x1ZZTeTgDm/wxlUEZBFAeMEIZucNYbnD5nHstNLwnha7dWO/wQCvm87LfDi+IRZe
         3xksrnj7E/N8N8hd7c5i+DXXgg0zt6L1th9Q9FHcn5K9v85AZRQWn/GJHQ+uhi8LZz4i
         M8LjUZIQT1+iD1jakt0Voj0j+dZeF70rHueUWiIHC6SElvfB6BhnftvjJhkApjqqjCT/
         xHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682533054; x=1685125054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdQeKWXlxni4iD1fxvriLlvMwyXevXPK3SN0RPtPBiE=;
        b=CH2cvF9r9N7EdGvTRY2sfrR94jlkjdDXZs5+RXWcBXCh2ot9l7aGtsH2d78p/WIaKJ
         ZwXIi8LEosHmAbTR7ptu888Tn9qoAGNrSf9f3jfuILkQ8tQvJomCfSw25NgkbjmYn3T2
         xLGVPanI5lbQY1kpm949ImqBvBHXI3c3Qe/78Rve3PCnmRJxMYULNFssEu0HyI0pCyab
         122NHrWQmTK8KGZ2Q50hWd1lGabBMSpf1sBWG47nS8Dtlj9ztt/XK0s8Um0VXXji47sn
         gV/Q2YRv/PFxqFzxegVJzPQdyibxVZ8zj+4+fKWOrpFU1v1FpFO/YX7nJ2i+Pb0W8bzu
         nZog==
X-Gm-Message-State: AC+VfDxPSGPfW6Vr012PY/MZlDob8FPowTKQlMyYyzcs3k6fRql2ei2U
        zhJ5HbCb+33jbQsJGSLbK4dA/ZxiFJPsXo20M6EXMBEQ
X-Google-Smtp-Source: ACHHUZ5J6FON58dzgg9Qi0dUqDQZ3SdhmiaOdPn3OFQQxHmMbLDu+a7Ez8Ec5VjfG/NqLsEgplqW9Vx4n3jDgS2MeJU=
X-Received: by 2002:a05:6402:c7:b0:509:f31f:b570 with SMTP id
 i7-20020a05640200c700b00509f31fb570mr5597315edu.23.1682533054479; Wed, 26 Apr
 2023 11:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230420071414.570108-1-joannelkoong@gmail.com> <20230420071414.570108-6-joannelkoong@gmail.com>
In-Reply-To: <20230420071414.570108-6-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Apr 2023 11:17:22 -0700
Message-ID: <CAEf4BzZxzXG1j+xj+e6oDKQH94jwQohZzTirnm9Sq5O8rsrRpA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 5/5] selftests/bpf: add tests for dynptr
 convenience helpers
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 20, 2023 at 12:15=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> Add various tests for the added dynptr convenience helpers.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  tools/testing/selftests/bpf/bpf_kfuncs.h      |   6 +
>  .../testing/selftests/bpf/prog_tests/dynptr.c |   6 +
>  .../testing/selftests/bpf/progs/dynptr_fail.c | 287 +++++++++++++++++
>  .../selftests/bpf/progs/dynptr_success.c      | 298 ++++++++++++++++++
>  4 files changed, 597 insertions(+)
>

Very nice and thorough set of tests, thanks a lot! I left a comment
below, please follow up with requested improvement.

Applied the patch set to bpf-next. Let's continue discussion about
TRUSTED_ARGS and PTR_TO_BTF_ID for dynptr and do necessary follow ups
separately.

[...]

> +/* Invalidating a dynptr should invalidate any data slices
> + * of its clones
> + */
> +SEC("?raw_tp")
> +__failure __msg("invalid mem access 'scalar'")
> +int clone_invalidate4(void *ctx)
> +{
> +       struct bpf_dynptr ptr;
> +       struct bpf_dynptr clone;
> +       int *data;
> +
> +       bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
> +
> +       bpf_dynptr_clone(&ptr, &clone);
> +       data =3D bpf_dynptr_data(&clone, 0, sizeof(val));
> +       if (!data)

you'd need bpf_ringbuf_discard_dynptr() here to make sure that
compiler code generation changes don't suddenly start failing due to
missing dynptr release operation. Please send a small follow up making
this more robust.

> +               return 0;
> +
> +       bpf_ringbuf_submit_dynptr(&ptr, 0);
> +
> +       /* this should fail */
> +       *data =3D 123;
> +
> +       return 0;
> +}
> +
> +/* Invalidating a dynptr should invalidate any data slices
> + * of its parent
> + */
> +SEC("?raw_tp")
> +__failure __msg("invalid mem access 'scalar'")
> +int clone_invalidate5(void *ctx)
> +{
> +       struct bpf_dynptr ptr;
> +       struct bpf_dynptr clone;
> +       int *data;
> +
> +       bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
> +       data =3D bpf_dynptr_data(&ptr, 0, sizeof(val));
> +       if (!data)

ditto, we need to make sure we violate only one rule (using
invalidated slices), not the overall dynptr usage pattern

> +               return 0;
> +
> +       bpf_dynptr_clone(&ptr, &clone);
> +
> +       bpf_ringbuf_submit_dynptr(&clone, 0);
> +
> +       /* this should fail */
> +       *data =3D 123;
> +
> +       return 0;
> +}
> +

[...]
