Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913824CD718
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 16:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbiCDPHZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 10:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiCDPHY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 10:07:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E701BE132
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 07:06:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D37C561A02
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 15:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42925C340F4
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 15:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646406395;
        bh=GaPNTPRP9rKEbsrR4+rKcSiCaf98RJqiSFk9JN9vI38=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c3DRtFIJqU+tRnQmnE7G1/zZsVPh7e5YFNKlxvoshTQVzh2gJ2UoObts/08f9oMrq
         g9DBkdxM3vUGVELO6cXI8bUtQn2Xi3skFPBCgjQkivDgWr2ZPo8OzSnnF8qXRarIe8
         4qJMn7ZYxhuXGwfyiL6DUS47+/RpRHWT89jEGQQVxTbGTIqMNNkWB8gATe5DkkCKKk
         yV7ViLyx81+xrd+majlBk4PSlhmpKojoKSFMshOuiHaWIgmDQLFzb2YrwTnGWCESlk
         t9xu/hV6ds5r+FJOJ84z1uxNu8Ho07UWSRVIT28y0lAllqLb37emaIKqpxFHO9F3E3
         X+uIk5yaq+Vwg==
Received: by mail-ej1-f42.google.com with SMTP id dr20so18056649ejc.6
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 07:06:35 -0800 (PST)
X-Gm-Message-State: AOAM533XwO7Dy9jEWBDpEkEJQUfStl4A4REtMnrT49Z2BS2SzWRMmtiq
        bdWs7msX3QHuK95j+O8SoM5ynSN4rvBzZ+6ZA8+a9Q==
X-Google-Smtp-Source: ABdhPJzoF5fhBe+bI3Qdd8B2PmkKkthm7aOftLD/S3hRm/NlpCtsrxgmEuWV6ZZrcXqNZlODUxHyG3wiUBbdWx7DN8I=
X-Received: by 2002:a17:906:4c4b:b0:6da:a5d9:7af9 with SMTP id
 d11-20020a1709064c4b00b006daa5d97af9mr4747674ejw.336.1646406393406; Fri, 04
 Mar 2022 07:06:33 -0800 (PST)
MIME-Version: 1.0
References: <20220304150402.729127-1-kpsingh@kernel.org>
In-Reply-To: <20220304150402.729127-1-kpsingh@kernel.org>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 4 Mar 2022 16:06:22 +0100
X-Gmail-Original-Message-ID: <CACYkzJ55T_q8pYH9d=b7Lmn_qFU9XtcU-91xKRnK7-p7Sa3qhA@mail.gmail.com>
Message-ID: <CACYkzJ55T_q8pYH9d=b7Lmn_qFU9XtcU-91xKRnK7-p7Sa3qhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf/selftests: Allow vmtest.sh to build
 statically linked test_progs.
To:     bpf@vger.kernel.org
Cc:     "Geyslan G. Bem" <geyslan@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 4, 2022 at 4:04 PM KP Singh <kpsingh@kernel.org> wrote:
>
> Dynamic linking when compiling on the host can cause issues when the
> libc version does not match the one in the VM image.
> Allow the user to use static compilation when this issue arises:
>
> Before:
>   ./vmtest.sh -- ./test_progs -t test_ima
>   ./test_progs: /usr/lib/libc.so.6: version `GLIBC_2.33' not found (required by ./test_progs)
>
> After:
>
>   TRUNNER_LDFLAGS=-static ./vmtest.sh -- ./test_progs -t test_ima
>   test_ima:OK
>   Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>
> Not using static as the default as some distros may not have dependent
> static libraries.
>
> Reported-by: "Geyslan G. Bem" <geyslan@gmail.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile  | 4 ++--
>  tools/testing/selftests/bpf/vmtest.sh | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index fe12b4f5fe20..2473c9b0cb2e 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -162,7 +162,7 @@ $(MAKE_DIRS):
>
>  $(OUTPUT)/%.o: %.c
>         $(call msg,CC,,$@)
> -       $(Q)$(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
> +       $(Q)$(CC) $(CFLAGS) $(TRUNNER_LDFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
>
>  $(OUTPUT)/%:%.c
>         $(call msg,BINARY,,$@)
> @@ -468,7 +468,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)                   \
>                              $(RESOLVE_BTFIDS)                          \
>                              | $(TRUNNER_BINARY)-extras
>         $$(call msg,BINARY,,$$@)
> -       $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
> +       $(Q)$$(CC) $$(CFLAGS) $(TRUNNER_LDFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
>         $(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.o $$@
>         $(Q)ln -sf $(if $2,..,.)/tools/build/bpftool/bootstrap/bpftool $(if $2,$2/)bpftool
>
> diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
> index e0bb04a97e10..a8bf6ceb3d06 100755
> --- a/tools/testing/selftests/bpf/vmtest.sh
> +++ b/tools/testing/selftests/bpf/vmtest.sh
> @@ -155,7 +155,7 @@ update_selftests()
>         local selftests_dir="${kernel_checkout}/tools/testing/selftests/bpf"
>
>         cd "${selftests_dir}"
> -       ${make_command}
> +       ${make_command} TRUNNER_LDFLAGS=-static

This is not what you want to do KP, amend your commit so that
-static is not the default.

Okay, resending.

>
>         # Mount the image and copy the selftests to the image.
>         mount_image
> --
> 2.35.1.616.g0bdcbb4464-goog
>
