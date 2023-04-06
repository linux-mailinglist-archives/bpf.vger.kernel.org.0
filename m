Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292146DA3AB
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 22:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239885AbjDFUmE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 16:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240009AbjDFUl3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 16:41:29 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB44BB96
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 13:38:06 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5047074939fso2559577a12.1
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 13:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680813485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6hnZAtVCdq/Dv+NTiZYmbdNBHc2XsF9LkjJkvIPdQA=;
        b=cB1rqJ3bE041ICHvwp4WhPEf29gRWqTNQd3dfs4PK0W6Cw7TK41xJ/Yk3QTUoDPWyi
         E2qT/HJvrFk4Lr7RxMn+zW+UE8xuq+LTMbw31SGK9bCVL2b7dJZ+P9dTLjTKLa2UvOb6
         wwN5lS/PuAJIJptW1pxKDlbH/b9PjoKjERgdHlVPtu2HNHJZKfDVjKGC6T0G/cmwVtiu
         qZBGmPGcAU9RAX2mnxejxWgAOwMmJ0pVCldMMiOYd4/YmrNJAWCKrNQmkdmdqQsn4CH6
         7s0M2h385p2DW2ysvZ8Du8zSttx4m+5/IZleYrLRYwYlepMZ6TeKPum6hOCIoLtHERCu
         lRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680813485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6hnZAtVCdq/Dv+NTiZYmbdNBHc2XsF9LkjJkvIPdQA=;
        b=nWZE7XMb+BQ+zr0j8mAxyIGyIOUjnnLoLQF4wq5F+W9hH/ziShEiT69S+VCPELEcKc
         ZYP+IR+z9raRGdJv/j+KWDc/mrWvldjbH2kXaReivW+xv0xe++kVXyumIepgEx8cU9EZ
         mULPNi+NxoMZfHo3rTFD3nPBnaUYo6JTjkfcZbfYNJcvU3tw65GH4e32Lg6icZ5I8xuM
         CSorK1wmfzm0BzS5hHxJZYLEgFGrISl3L/XxsuFtuEXLRR+MR99TMCZPbsDrxwM3no+A
         gGxiFWbmGvIhuBQY6TySr51Cd0glzdCSwwTzx8WqvYUrxyOY/AYjEVlxYHT0int1CT8y
         XXjw==
X-Gm-Message-State: AAQBX9e5Gw8A4RRY27P62w6GfKfoA128IH1wFYrR8n9eEH+4AwPrzxS4
        0Cwu13HeUIPZQ/i/WuCViu2Q41AqDtbHmqM8633n7YQWcN4=
X-Google-Smtp-Source: AKy350afGL009GrAfRiSg0PGIgSm9EiHtMMqvL+Djt5o8kUTF7KxyPlhFrUV3jkZHWq7dQ3VUugt1ypptaqgUwkM4nw=
X-Received: by 2002:a05:6402:2744:b0:502:6e58:c820 with SMTP id
 z4-20020a056402274400b005026e58c820mr4494529edd.1.1680813484958; Thu, 06 Apr
 2023 13:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230406164450.1044952-1-yhs@fb.com> <20230406164500.1045715-1-yhs@fb.com>
In-Reply-To: <20230406164500.1045715-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Apr 2023 13:37:53 -0700
Message-ID: <CAEf4BzbG8LuNupPxinhCFyej7_Y1s4VPcLzJq5KiazVtJ5qU3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: Add tests for non-constant
 cond_op NE/EQ bound deduction
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
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

On Thu, Apr 6, 2023 at 9:47=E2=80=AFAM Yonghong Song <yhs@fb.com> wrote:
>
> Add various tests for code pattern '<non-const> NE/EQ <const>' implemente=
d
> in the previous verifier patch. Without the verifier patch, these new
> tests will fail.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Makes sense.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  .../verifier_bounds_deduction_non_const.c     | 179 ++++++++++++++++++
>  2 files changed, 181 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_bounds_ded=
uction_non_const.c
>

[...]
