Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821134CD994
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 17:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiCDQ6V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 11:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240835AbiCDQ6U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 11:58:20 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BF1B871
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 08:57:31 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id v28so11793853ljv.9
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 08:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJeswyDgEuB2EBaCK38+eu1nYzUuD0xM7vQHWolmfTw=;
        b=Q6Q+rjDcJdRe6wOZg7xmsLNK5rhLNqEbtDEDTjXCqNlDZ/YKQzxXv0xMaDPfWJkm2L
         9f0G+xvqMn1NzmLcnO8CInLR7XdYZ9p+IvsvhRKZ4G22RIwSeeM5jZRamVoXp4fE5Rbg
         5ZfeOji6UQvnV+9OXmTwkIgppRyZNiV/LxJ0Lk3Q5QPVISVEfYhf2qNcQ3C19hzDqEng
         yGeE6Lm9J91cOGNFwgGiNEWF7oRnGohf/FcZtdSx3lzg/svFVhnz8CpAHx24QWWi+Ni0
         6QD6CchhIPV46BOKW9vTSfL0mcC90CCFEh7bquDk7I5QBuG61i3sdC+0IrM3cpioeuhn
         MOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJeswyDgEuB2EBaCK38+eu1nYzUuD0xM7vQHWolmfTw=;
        b=WLKQQcEr0GaJMfxqotoET9FZHblCJSIxZtG60HVhczp2cgnNCSlhAIG60/O9/kZMSP
         EwlNh9i1xf5dReGUBABW2l+/dE0RLwUn7B53asJdlxO48HEBUl9dmNhi6mzkF53t+pmt
         U7lOE46bezFGSpLi349ckc+e7EjuOxDxzOWVa324bq3aBSdGjbbHE9EJwyhJqid7UFZV
         w2fhXDw47hW3rOPexF6QXJeVipie+uPz/hHlJgWAxKo/JmyglMqg5GuV5R2DYvUtnhRH
         QQ4sh99WbtqaNbkHFOY++IAAEoZxv6HRnB9lFxAFUWuZ4y6UVlbJnXAGtace5fYWljOc
         bTbw==
X-Gm-Message-State: AOAM530NsXwfvKP365/t26JZBUTOnzFWAuwV0xjfM8Vf/b1HlzFFpjjW
        JVlEFQwX5P4ZwiVrzGj5r/QgU5B7iQBjKsz5Ei3yS5NV1WQ=
X-Google-Smtp-Source: ABdhPJxPhBDt1RccusrtoEkBb7VXL5Mka1qza/Aw5416fjxtZ3vGLgGHrUIeM2yQn+RNIwALaOGOOAmukmtzhkDaFG8=
X-Received: by 2002:a05:651c:198d:b0:246:89bc:c7bb with SMTP id
 bx13-20020a05651c198d00b0024689bcc7bbmr16495165ljb.143.1646413046529; Fri, 04
 Mar 2022 08:57:26 -0800 (PST)
MIME-Version: 1.0
References: <20220304150402.729127-1-kpsingh@kernel.org>
In-Reply-To: <20220304150402.729127-1-kpsingh@kernel.org>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Fri, 4 Mar 2022 08:57:00 -0800
Message-ID: <CAJygYd1uwX05w3-+avZfz9d2a=8OD7VTMEv8Uo9AHLHrnu=k+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf/selftests: Allow vmtest.sh to build
 statically linked test_progs.
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, "Geyslan G. Bem" <geyslan@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
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

On Fri, Mar 4, 2022 at 8:48 AM KP Singh <kpsingh@kernel.org> wrote:
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

In the commit message you mentioned we are not making it default for
everyone, Yet here making it default?
Also, do we need to add a new TRUNNER_LDFLAGS ? Why not just LDFLAGS,
we also use CFLAGS.  Thinking ahead if we want add ASAN support later,
maybe add a switch to vmtest.sh for choosing flavor to run would be
better.


>
>         # Mount the image and copy the selftests to the image.
>         mount_image
> --
> 2.35.1.616.g0bdcbb4464-goog
>
