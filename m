Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627552CF4F9
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 20:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbgLDTo0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 14:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbgLDTo0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Dec 2020 14:44:26 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED998C0613D1
        for <bpf@vger.kernel.org>; Fri,  4 Dec 2020 11:43:45 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id v92so6490728ybi.4
        for <bpf@vger.kernel.org>; Fri, 04 Dec 2020 11:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0q49kOIYqWmgjfxTEVUMHPJoXYD2mfcuJLvvVnPmLJU=;
        b=Z/dZg6xuI4mY4VouM8qZEv0kBErfO09wdP6rTpuea8SdUvmaWrq/iS1EXkvHMD0yXY
         A4NfTdac5m//G0QaTk0EJmHfDFSOzkANNbHWib3c+yr0mblUSYqxoCz+/MeROUo6gpAw
         ilrzVZdWweB7giANd06r2wdhSjGClVQq5di65wAFqPLGhrGB3lRECVlSuTWcQjLAYR3e
         S37gShxLvjnYsMMrAML/5t7mhQ9G556DT2UgSwSin3v7TY732Kqq0rIGFTuu93PHaxji
         n0NS6F0c8/cuAKMfITjY/MXUF3KcwxXRfnihpyW7+xE8QyevBNY8PgSW+XfmpucaA720
         ZhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0q49kOIYqWmgjfxTEVUMHPJoXYD2mfcuJLvvVnPmLJU=;
        b=JLHnSqb5WspRwa16tu+9verIe0CjkDjk/6oDM9CgAnB7AH2QdKvchYZCFU6yqOjjIr
         BSGzMnj67yDq3kzG7acJ+q586jJ5sx7AaovvUl60WY1pWvkgXnKWCcCPOteu+0P+/4Vg
         L/7+S29ATGwgIULWmeKrIVhuhRw7KKQfKU1pKqFRHF3JafBmsU4uSwVALS51ZU2kZclQ
         URwwNGfK4crnDXxDMa3z0WxKjgMiEArQmR4EhVFyGtDkHJPpLQA6rcsOutKBEn1Oq5XR
         jlsmjnZEleodDoFL8ALpryXMhHWVLZChkTxlDnStlw1kPXxYZ4N4u6dfhBy/uj0fhOj3
         HSyA==
X-Gm-Message-State: AOAM532HkRdDtId/VlU//cvcmoL1VIuxeEuyYGcRJxNzA6leR0LD9GpA
        9dexZFj1vTt6+YfILZ6JNeTpPxWAyAU0+vAdVuQ=
X-Google-Smtp-Source: ABdhPJzz6TJW7MEIXLfwXDfl5gQgAGpSthzQR0LR0UY6/BEBKTVv0qzmNY73X9BrxIG1b/y6bPKRzMORU/Rphv6e54A=
X-Received: by 2002:a25:3d7:: with SMTP id 206mr7795854ybd.27.1607111025228;
 Fri, 04 Dec 2020 11:43:45 -0800 (PST)
MIME-Version: 1.0
References: <20201204152554.955599-1-kpsingh@chromium.org>
In-Reply-To: <20201204152554.955599-1-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Dec 2020 11:43:34 -0800
Message-ID: <CAEf4Bzb8i9i6YqYwiczeDZoT_PVpHZqPoJETdwDz+40__u5+vw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add verbosity to ima_setup.sh
To:     KP Singh <kpsingh@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 4, 2020 at 7:25 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> Currently, ima_setup.sh spews outputs from commands like mkfs and dd
> on the terminal without taking into account the verbosity level of
> the test framework. Add an option to specify the verbosity for the
> shell script and only print output when verbosity > VERBOSE_NONE.
>
> Since the command line parsing got complicated with the addition of
> verbosity, switched "action" (-a, --action) and "directory" (-d, --dir)
> to command line switches as well.
>
> Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  tools/testing/selftests/bpf/ima_setup.sh      | 36 ++++++++++++++++---
>  .../selftests/bpf/prog_tests/test_ima.c       | 11 ++++--
>  2 files changed, 40 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
> index 2bfc646bc230..d8d063fa7781 100755
> --- a/tools/testing/selftests/bpf/ima_setup.sh
> +++ b/tools/testing/selftests/bpf/ima_setup.sh
> @@ -10,7 +10,7 @@ TEST_BINARY="/bin/true"
>
>  usage()
>  {
> -       echo "Usage: $0 <setup|cleanup|run> <existing_tmp_dir>"
> +       echo "Usage: $0 -a <setup|cleanup|run> -d <existing_tmp_dir> -v <yes|no>"

why -v <yes|no> vs common -v for verbose, and lack of -v for
non-verbose? Seems much cleaner? Yes, C code will need to deal with it
in a bit different way than you implemented it currently.

But honestly, even just setting envvar would do. This script is for
selftests only, so test_progs could have a convention of
SELFTESTS_VERBOSE=1 for verbose mode or something. No arguments
needed.

>         exit 1
>  }
>

[...]
