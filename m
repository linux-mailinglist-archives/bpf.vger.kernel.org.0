Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22D41E327C
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 00:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389889AbgEZW3U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 May 2020 18:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389638AbgEZW3U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 May 2020 18:29:20 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E2EC061A0F
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 15:29:15 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k22so2858341qtm.6
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 15:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XwZsEve4/tahtRy3xNl+sD2PgVdDaA1PqoVKPTEc/mk=;
        b=D7ldIPDwawgmvUk9HK1lUP0Sf0Mimrbj8BqIoOk+lTydDLSwYNA3a9L3aMaws7XnGd
         U/vQmvq5Lg9nNgzKjs96wynEabM7wGxwwJMe6Yfk+nDaG8XfcDgbQQc03rnmrIi+/x/Y
         /JmLBQH6Enm4AaFf19mhFmABO6ybS547EUNg4LkTcQkwKmwQy+yHdBvH0GibDGzSUwRZ
         J8WRZ/O+idoB+x9/3G+uiamII8RTR+yKtro8U9HR7xqtw3QOjYRUpSJPNkzgBiqYboRr
         D+cS+211FILxE/bRzat706+6kuSeQ537KcCMh+a9mV/lSzOkVN/upTS9ieROz3jl+9Xv
         VG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XwZsEve4/tahtRy3xNl+sD2PgVdDaA1PqoVKPTEc/mk=;
        b=lNggFPYR3oWeNxkQmhjEV4D1AS6y3+wF6njCV/VWDsDUkolvCX5Ff9Z6YKOvJoClIP
         cMjarHGuFseHbjxeMHsoHOo8slJPnmKEgbOxbxqJNf3y4I184FqbaT677TFSfXrJt2UH
         3/b+wdPdJHUl2Y1EjRK2RIZIUx5yH44fmguK/2XPTP/9EeY8zK0HsUYAddv6EIVO/ycW
         Ne0f69ChdNhoRMOY9Bw6NFdXPlehSGykhHqRsn1F8jHExiJ6R3iQlI6Z6HM+YsygxDcL
         iu3v/2oB4An+MUI+QrMnY7so4qTrbjatjCcheIOhBTduJf1kxqEiMFKU/zPNSRMnHOc7
         9R6A==
X-Gm-Message-State: AOAM530bSLwOqkKgVKvW/HlBZ37n1gZfQCzvg2NxU2CBwrieGiGhCv/T
        hvlr07IjJtuZpfcMko/YXG35QGBHo73bex61ldI=
X-Google-Smtp-Source: ABdhPJz83/Rr95tzXJPwsokEhoRQO41fhDx6YsXA9Qc+eXSRIqbnbhpiV8+L3uRoSGjgfqvrXOTt5sneEHsIMt+VKw0=
X-Received: by 2002:ac8:2dc3:: with SMTP id q3mr1110930qta.141.1590532155051;
 Tue, 26 May 2020 15:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com> <20200522041310.233185-9-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200522041310.233185-9-yauheni.kaliuta@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 May 2020 15:29:04 -0700
Message-ID: <CAEf4BzYoXB8OmnAu59L5Xr6=CpAcxxSJQrEfkuWgg0XT-EeP4w@mail.gmail.com>
Subject: Re: [PATCH 8/8] selftests/bpf: factor out MKDIR rule
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 21, 2020 at 9:14 PM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Do not repeat youself, move common mkdir code (message and action)
> to a variable.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index bade24e29a1a..26497d8869ea 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -252,6 +252,11 @@ define COMPILE_C_RULE
>         $(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
>  endef
>
> +define MKDIR_RULE
> +       $(call msg,MKDIR,,$@)
> +       mkdir -p $@
> +endef

I don't think you save much with this, especially by combining dir
creation rules together. Let's not do this, just adds extra level of
"rule nestedness", if I may say so...

> +
>  SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
>
>  # Set up extra TRUNNER_XXX "temporary" variables in the environment (relies on
> @@ -294,8 +299,7 @@ define DEFINE_TEST_RUNNER_RULES
>  ifeq ($($(TRUNNER_OUTPUT)-dir),)
>  $(TRUNNER_OUTPUT)-dir := y
>  $(TRUNNER_OUTPUT):
> -       $$(call msg,MKDIR,,$$@)
> -       mkdir -p $$@
> +       $$(MKDIR_RULE)
>
>  ifneq ($2,)
>  EXTRA_CLEAN +=$(TRUNNER_OUTPUT)
> @@ -337,8 +341,7 @@ $(TRUNNER_TESTS_HDR): $(TRUNNER_TESTS_DIR)/*.c | $(dir $(TRUNNER_TESTS_HDR))
>  EXTRA_CLEAN += $(TRUNNER_TESTS_HDR)
>
>  $(dir $(TRUNNER_TESTS_HDR)):

combine this rule with $(TRUNNER_OUTPUT) above?

> -       $$(call msg,MKDIR,,$$@)
> -       mkdir -p $$@
> +       $$(MKDIR_RULE)
>  endif
>
>  # compile individual test files
> @@ -425,8 +428,7 @@ $(OUTPUT)/verifier/tests.h: verifier/*.c | $(OUTPUT)/verifier
>  EXTRA_CLEAN += $(OUTPUT)/verifier/tests.h
>
>  $(OUTPUT)/verifier:
> -       $(call msg,MKDIR,,$@)
> -       mkdir -p $@
> +       $(MKDIR_RULE)

This should go together with libbpf, bpftool and $(INCLUDE_DIR) rule
at line 176.

>
>  $(OUTPUT)/test_verifier: CFLAGS += -I$(abspath verifier)
>  $(OUTPUT)/test_verifier: test_verifier.c $(OUTPUT)/verifier/tests.h $(BPFOBJ) \
> --
> 2.26.2
>
