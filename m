Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4974B6261BF
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 20:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiKKTIQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 14:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKKTIP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 14:08:15 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FBD22BE3
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:08:14 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id r14so8890309edc.7
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 11:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5eMrE+xSIwXoz/4Xb5cFztQjHM1pZry5Cu6Br3bA3VU=;
        b=iYhz8Lrze0rjWe/qdEh7Di2gctdtTyQHZbDceemez+p8Ekjity31IdndzLP815LjJN
         4AuuEPyN+v9n8CiF8BSKnvKioS7sVKG68pfhBo1nDEtpKM42eGBbxt/1lqe7JaroRYDF
         4sUMBrkL2PLP0oO6hkg+aRy9YxQJxf30AgRa/pNBnvZixcPEIXFKLx3NwnparklyorB7
         I8H02a9lASyfwUGYy5uo1zN4yrM5X6D8MphXQAv8iG5m9jicIK5KorJjr22anPMNzeic
         O6GSXB4s9F+/s2+arVYFHKU6HNpgnJNsPzbqAxfPIQMYGTdKqkKTOGbJnDga2jVdoEtw
         2k7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5eMrE+xSIwXoz/4Xb5cFztQjHM1pZry5Cu6Br3bA3VU=;
        b=AjCCcbVT3O10zarAbnzeuwX2e+ksSYF+ARcA9v9o/I+XkO/xkOJm6HrsOtKulT0CpV
         xIiRXsY7S7E6G7Tq9Xy2eBMh5r1Nc0eBObnmSQq5Bp5edX9mEnypmBkBkY79pxW4IXvE
         zy2ZqhOiRfXC4wbQBQ4fu1Nges4dKYFwZGh8LV4TGQlKMXIsxdDjkkko2bHLwV9/qleE
         vjoN8CvgcN3t28TERcC6sbd4bxihb++XRO6YKteGKQKqydVbosnARgTKNeh2OyGC9yxG
         iW2IDCMTyeu2oujPdCiuU6X6hcNU2fox9N3VNuEAHpyGXDBEJcR9HJYK6miws4MEhNT+
         EtsA==
X-Gm-Message-State: ANoB5pldZtLJq8FxqbMH3Cb21wuc9VDToZay2GdmHS95nE8OWk2wODrn
        Sv+UIFxgaX+x7liU84nAYO76J7y9EryDaOeLfo8=
X-Google-Smtp-Source: AA0mqf5Ymj6L1S7Z15piwzdBAkda5GNy6MhtGe7b5EN4TdzXFDEwH9ciEan8l2M9hecJaku2HjBmwPbXuhCDocTG1Ac=
X-Received: by 2002:a05:6402:344f:b0:461:d726:438f with SMTP id
 l15-20020a056402344f00b00461d726438fmr2743249edc.333.1668193692691; Fri, 11
 Nov 2022 11:08:12 -0800 (PST)
MIME-Version: 1.0
References: <20221110144320.1075367-1-eddyz87@gmail.com> <20221110144320.1075367-3-eddyz87@gmail.com>
In-Reply-To: <20221110144320.1075367-3-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 11 Nov 2022 11:07:59 -0800
Message-ID: <CAEf4BzYMqzG9QapRsT11XT3keCkpTkrqMxYsfmQJkGByqcRJdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: Dump data sections as part
 of btf_dump_test_case tests
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
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

On Thu, Nov 10, 2022 at 6:43 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Modify `test_btf_dump_case` to test `btf_dump__dump_type_data`
> alongside `btf_dump__dump_type`.
>
> The `test_btf_dump_case` function provides a convenient way to test
> `btf_dump__dump_type` behavior as test cases are specified in separate
> C files and any differences are reported using `diff` utility. This
> commit extends `test_btf_dump_case` to call `btf_dump__dump_type_data`
> for each `BTF_KIND_DATASEC` object in the test case object file.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

please use ASSERT_xxx() instead of CHECK()

>  .../selftests/bpf/prog_tests/btf_dump.c       | 118 +++++++++++++++---
>  1 file changed, 104 insertions(+), 14 deletions(-)
>

[...]
