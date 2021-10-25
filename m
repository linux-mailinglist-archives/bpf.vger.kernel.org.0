Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D4143A492
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 22:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbhJYU1D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 16:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbhJYU06 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 16:26:58 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091A2C069659
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 13:13:14 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id y10so12918160qkp.9
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 13:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+biiFamx6+RAbaSzzgMJ3jI/Ac7Q3sMmnWv/gfxMpNA=;
        b=lTmMfJG9sYNmRuE/t6qP2sPRvUCqXoIsYTW1tHtnCI+4SRFqnNCAX7k0QgquIOp8Z4
         ETVj/iBcfNFdieYZC4Is92g3XyiOmYPkHNiGuYy+ACT0KHCln/Ymk7EYKWT4ucyXNzNm
         FWIOPtq2WVPuoavmXujmM84u0Hpcoz7zffxjlCIGXW4ay6arLKwc9l1ow8t200tYow9D
         ebrLQvzeaOL2ItO7q3d9T4z/FqeAliTWozAndJCIgHMEgsVyrCA2dPYibKdwGvckBbO5
         FrI+sHshyLb3xTSTiGE0jsdeX236m4//0Bo0P9SgYDAnfHePYrb1MeSMIMuYLNNyb2wp
         uOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+biiFamx6+RAbaSzzgMJ3jI/Ac7Q3sMmnWv/gfxMpNA=;
        b=rPiXVSKVGmGW7SVzfVHwme76i5Cv2hv04++7z5ydrDWQw9Lw/vTHue7MssBxBnJpQe
         3bcdTEo+snrcUlWrWrzPf4c9GxAmU9W7uUEPmMOcPaEXwxrLtdeVed2iFYkC8viqBVW4
         d/7KZ1yelF8Q95IHzdqxf+OiRqr3ZtqILBaUyoH71bdORyPadNwpGp8xsidqpyN5eZUL
         sgsfCRCBGjZFZi6ZseYPepsbeKquIZR/69DT5wIDE8gcIs3XNyZzN1SM/e+Feaspk069
         4VcOLN1DY/3w7zkGAexTrOBTj3HIov3HQWCCtp9o5ewArcnrfqRmNFL64f0QgqOkzMJ+
         Kxhg==
X-Gm-Message-State: AOAM532uh+OxxhutZIA+W18ADk3YNCQLRQzD+DZr/GuLcZQZ71ShrRmP
        PE4TazFLYycfvS8/hJiKgz3ISH8wyKLBrLKNdY86vMpFFQc=
X-Google-Smtp-Source: ABdhPJwy0y46LEySyvT0hbjcxNBfUTuKG6TujwoQnpn2i7CLlufP+d/2A+YwWB1XxIKXO+I/9V1kfQIXtlaqYoIjKuQ=
X-Received: by 2002:a05:620a:2909:: with SMTP id m9mr7624026qkp.496.1635192793008;
 Mon, 25 Oct 2021 13:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211022223228.99920-1-andrii@kernel.org> <20211022223228.99920-3-andrii@kernel.org>
In-Reply-To: <20211022223228.99920-3-andrii@kernel.org>
From:   "sunyucong@gmail.com" <sunyucong@gmail.com>
Date:   Mon, 25 Oct 2021 13:12:47 -0700
Message-ID: <CAJygYd1qr5yi0i0wfPuz4yBj61TjcXqBRWKoLUa=XkUp+7g1Vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: support multiple tests per file
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 22, 2021 at 3:33 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Revamp how test discovery works for test_progs and allow multiple test
> entries per file. Any global void function with no arguments and
> serial_test_ or test_ prefix is considered a test.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 498222543c37..ac47cf9760fc 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -421,10 +421,9 @@ ifeq ($($(TRUNNER_TESTS_DIR)-tests-hdr),)
>  $(TRUNNER_TESTS_DIR)-tests-hdr := y
>  $(TRUNNER_TESTS_HDR): $(TRUNNER_TESTS_DIR)/*.c
>         $$(call msg,TEST-HDR,$(TRUNNER_BINARY),$$@)
> -       $$(shell ( cd $(TRUNNER_TESTS_DIR);                             \
> -                 echo '/* Generated header, do not edit */';           \
> -                 ls *.c 2> /dev/null |                                 \
> -                       sed -e 's@\([^\.]*\)\.c@DEFINE_TEST(\1)@';      \
> +       $$(shell (echo '/* Generated header, do not edit */';                                   \
> +                 sed -n -E 's/^void (serial_)?test_([a-zA-Z0-9_]+)\((void)?\).*/DEFINE_TEST(\2)/p'     \

probably not that important :  allow \s* before void and after void.
Or,  maybe we can just  (?!static)  instead of anchoring to line
start.

> +                       $(TRUNNER_TESTS_DIR)/*.c | sort ;       \

to be super safe : maybe add a check here to ensure each file contains
at least one test function.

>                  ) > $$@)
>  endif
>
> --
> 2.30.2
>
