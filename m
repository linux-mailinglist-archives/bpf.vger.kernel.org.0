Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B094A5080AA
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 07:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237844AbiDTFiD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 01:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245452AbiDTFh4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 01:37:56 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95348616B
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 22:35:11 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id n134so747861iod.5
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 22:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FyRCA6HIqHvZovrjJ71IxbcEzHY6DeD/LF+l2+VQe1s=;
        b=CatV7hXwdhJKJYkdCyBhzHRcAfCeAZQ1CtDNpHdQXIQRIBOsgygh62ogHRFRAHuftO
         CPG4HkPhOTNfoYpGWSvXtRq/AJGVIYmrOouDEBTTeqQqc1qWVT3uzQ1qp03PgoYeXK+H
         wJjnPAdB9DcODWwBFZMHBoohoG4lpXVVN7heBsHDyGcHD2qKA5v2vF24b4Wwg/mJzS9L
         5PHAWld7HUjrn4tGSIQh2KsiT8cbeo5O5dwv2NEsajtrXWkRDyl34AkL0ypgYJUJyqsu
         qQdIFKPrKDfXDywrYimS9t1/ie6ANerhen1rok+aSSSWPNh8ZGZ/jK2pgw1mAcWPxoHf
         YW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FyRCA6HIqHvZovrjJ71IxbcEzHY6DeD/LF+l2+VQe1s=;
        b=me/fXaJ+YoBwNpeo18DIEI2+APTd6o1EySaaIKlN/ihNu2X6Enf+t8Jh31pVkfaRRT
         3gTx4ws3B98Uf53frtS5L5nmr0PLY35tTY615WJO5GQzzTbO8HqAdLxI8U9uH35k61bV
         1WaxRhqy0nVhj/6+rvfZ5DxnhB1k35rO+LSVT74K7YJR4HjT+uT2a7cVuT8rOOgcofYf
         RAWcfpWRh7EtKHSbBl9U+Vpv7bqlb/4mrPHlSyQBxkPjw4TrTOPSw6RYuiik4VAxPDBK
         rLL7ekwBZKfKaHD2EzUTfd9HP+Avf7u3+4kKFF1DVIyWYkJEbFvNvMEudHa6Lj5J4Ztp
         axLw==
X-Gm-Message-State: AOAM5325pBQS+5LqZv2fIAi71558XdO/nXmzWi6/rwACGjljdmhDHR4S
        HN96fNQkNjugnEE1eXjIKVSh5hi84oETEGXxV/w=
X-Google-Smtp-Source: ABdhPJyxCz1Sl8zSpfpXISg7bWBJkIr9DcnKj02n4wYhmAoTCryjKC9vsIcqDFaSKHak7ogRbcMOoHaQHVoEkJn8J3U=
X-Received: by 2002:a05:6638:338e:b0:328:807a:e187 with SMTP id
 h14-20020a056638338e00b00328807ae187mr6885340jav.93.1650432910939; Tue, 19
 Apr 2022 22:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220419160346.35633-1-grantseltzer@gmail.com> <20220419160346.35633-2-grantseltzer@gmail.com>
In-Reply-To: <20220419160346.35633-2-grantseltzer@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 19 Apr 2022 22:35:00 -0700
Message-ID: <CAEf4BzYLOq4FAGycAERgORJ6-DatLb0cfnLxS-dxqxCm773eMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] Update API functions usage to check error
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>
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

On Tue, Apr 19, 2022 at 9:04 AM grantseltzer <grantseltzer@gmail.com> wrote:
>
> From: Grant Seltzer <grantseltzer@gmail.com>
>
> This updates usage of the following API functions within
> libbpf so their newly added error return is checked:
>
> - bpf_program__set_expected_attach_type()
> - bpf_program__set_type()
>
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0ed1a8c9c398..7635c50a05c6 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -7005,9 +7005,19 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
>                         continue;
>                 }
>
> -               bpf_program__set_type(prog, prog->sec_def->prog_type);
> -               bpf_program__set_expected_attach_type(prog, prog->sec_def->expected_attach_type);
> +               err = bpf_program__set_type(prog, prog->sec_def->prog_type);
> +               if (err) {
> +                       pr_warn("prog '%s': failed to initialize: %d, could not set program type\n",
> +                               prog->name, err);
> +                       return err;
> +               }
>
> +               err = bpf_program__set_expected_attach_type(prog, prog->sec_def->expected_attach_type);
> +               if (err) {
> +                       pr_warn("prog '%s': failed to initialize: %d, could not set expected attach type\n",
> +                               prog->name, err);
> +                       return err;
> +               }

this is too paranoid, we know that this will succeed. We can just do:

prog->type = prog->sec_def->prog_type;
prog->expected_attach_type = prog->sec_def->expected_attach_type;

to make this very clear

>  #pragma GCC diagnostic push
>  #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
>                 if (prog->sec_def->prog_type == BPF_PROG_TYPE_TRACING ||
> @@ -8570,8 +8580,7 @@ int bpf_program__set_##NAME(struct bpf_program *prog)             \
>  {                                                              \
>         if (!prog)                                              \
>                 return libbpf_err(-EINVAL);                     \
> -       bpf_program__set_type(prog, TYPE);                      \
> -       return 0;                                               \
> +       return bpf_program__set_type(prog, TYPE);                       \
>  }                                                              \
>                                                                 \
>  bool bpf_program__is_##NAME(const struct bpf_program *prog)    \
> @@ -9678,9 +9687,17 @@ static int bpf_prog_load_xattr2(const struct bpf_prog_load_attr *attr,
>                  * bpf_object__open guessed
>                  */
>                 if (attr->prog_type != BPF_PROG_TYPE_UNSPEC) {
> -                       bpf_program__set_type(prog, attr->prog_type);
> -                       bpf_program__set_expected_attach_type(prog,
> +                       err = bpf_program__set_type(prog, attr->prog_type);
> +                       if (err) {
> +                               pr_warn("could not set program type\n");
> +                               return libbpf_err(err);
> +                       }
> +                       err = bpf_program__set_expected_attach_type(prog,
>                                                               attach_type);
> +                       if (err) {
> +                               pr_warn("could not set expected attach type\n");
> +                               return libbpf_err(err);
> +                       }

same as above, no need to add unnecessary checks and pr_warns


>                 }
>                 if (bpf_program__type(prog) == BPF_PROG_TYPE_UNSPEC) {
>                         /*
> --
> 2.34.1
>
