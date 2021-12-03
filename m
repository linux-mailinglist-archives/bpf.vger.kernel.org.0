Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056E8466EE7
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 02:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347671AbhLCBEP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Dec 2021 20:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344077AbhLCBEP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Dec 2021 20:04:15 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65A0C06174A
        for <bpf@vger.kernel.org>; Thu,  2 Dec 2021 17:00:51 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id v64so4529522ybi.5
        for <bpf@vger.kernel.org>; Thu, 02 Dec 2021 17:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfcxlzSzsV5GKbjPHqlVGs/FcWInLUY/J3DBJW7pb+4=;
        b=bo4UrkIkBgdaS+KwXPI9zuGle7UtgkdaFqmix45iz4g7ZRO2TknM9NGTVF7Q8eJamJ
         iuNSA3mTa1waDyI6rxJ/kMn1DJdmxVJrNE0GgGZgOD25dXjbZwHW6ytiD/YDpCw7ap0c
         xX9Ut6gzBaGh78B88y5hsYMHmfbUIQWHtzu9AqHKt77dL2CwvEb+fcEMlH0s4aHkfQdR
         rdqGKGBbL8q2JDD31fktlGWHMVcxgUMkWa80TxH4N2mN1wzFnx8OIXB/FS0BBv70KfM0
         C7GQnteiDh4IdyXuP8xbr5j6iKP6shLM5lP4ZICrStl9aqgt+pmUSJC61A3D+IVthd5X
         CcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfcxlzSzsV5GKbjPHqlVGs/FcWInLUY/J3DBJW7pb+4=;
        b=LAsZddO8nGmBJfrnc/QRilBqUOIzZWRWrs15PsGmB8/zrW51tDPxdEHpqNT5s4aBO7
         dFHh5yvLSAoFXBzehi+i9qk37k9k2Kto7+HUAd57nkpBborITAMPZOJy9zwpcn9MP3yd
         1q/KkcA8jw6PJvsmmJU2sbwTZ6UUhjGI4u3rxat1VPH9REodsCdQ/coEh7TvH05MZ7G/
         Y5QAs/tctz+0Dyceeg4SLoR4Edjt/ASJ5MLuGFXoobdJFvpbmu+WWc0s38e2w7R+c0Q2
         YH90NA+f+bJ6ogRLs8tDL4kFafY7Y9Bmw5yt/qxtHiK9CeHm2mxdcpBqT5RJ8J37oB71
         xc+Q==
X-Gm-Message-State: AOAM5316qumuWE8/H6v4CyVbGZyU29sMcXmUL5zgnKLnr1Y7oZK9VwUO
        IickTRKamUoIZlmsqyiJ1Y/snM4Yn3xDrKnsrVfVrYEzZl/jLg==
X-Google-Smtp-Source: ABdhPJyMsXwiavgkTYR8Zxx6ZatxdVmdaG8DH/e3/2Z5TmbsM2PARFFo/yXBalzNWs/CHGlOzYt8vfzXh5dXvFLNQE8=
X-Received: by 2002:a25:2c92:: with SMTP id s140mr18446409ybs.308.1638493251186;
 Thu, 02 Dec 2021 17:00:51 -0800 (PST)
MIME-Version: 1.0
References: <20211203004640.2455717-1-andrii@kernel.org>
In-Reply-To: <20211203004640.2455717-1-andrii@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 2 Dec 2021 17:00:40 -0800
Message-ID: <CAEf4BzZe7bc6cRopJG4L6Et8OjCiGym8XzJPx_8NpyScwg_i=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] perf: mute libbpf API deprecations temporarily
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 2, 2021 at 4:46 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Libbpf development version was bumped to 0.7 in c93faaaf2f67
> ("libbpf: Deprecate bpf_prog_load_xattr() API"), activating a bunch of
> previously scheduled deprecations. Most APIs are pretty straightforward
> to replace with newer APIs, but perf has a complicated mixed setup with
> libbpf used both as static and shared configurations, which makes it
> non-trivial to migrate the APIs.
>
> Further, bpf_program__set_prep() needs more involved refactoring, which
> will require help from Arnaldo and/or Jiri.
>
> So for now, mute deprecation warnings and work on migrating perf off of
> deprecated APIs separately with the input from owners of the perf tool.
>
> Fixes: c93faaaf2f67 ("libbpf: Deprecate bpf_prog_load_xattr() API")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Stephen,

This patch (when applied to bpf-next) should fix the build failure you
reported in your recent "linux-next: build failure after merge of the
bpf-next tree" email (that I didn't get directly, but thankfully
Alexei forwarded to me). Can you please also cc bpf@vger.kernel.orgfor
future bpf-next tree issues, as that's a more directly related mailing
list (ideally also cc me at andrii@kernel.org directly so that we
don't rely on Gmail not dropping the email, I've, unfortunately, had
multiple problems with this recently). Thanks for understanding!

Arnaldo, Jiri,

Getting rid of most deprecations is pretty trivial, if not for the
hybrid static/dynamic setup. Please advise on the path forward. Do I
do __weak re-definitions of new APIs and switch the source code to new
variants?

As for bpf_program__set_prep(), assuming it's used to do program
cloning, bpf_program__insns() is a more straightforward and cleaner
way to do it now. But the logic seems to be more involved, so I'd like
you guys to do this conversion, if that's not too much trouble.

Regardless, let's work together to clean up perf's use of deprecated
APIs. Thanks!

>  tools/perf/tests/bpf.c       | 4 ++++
>  tools/perf/util/bpf-loader.c | 3 +++
>  2 files changed, 7 insertions(+)
>
> diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> index 2bf146e49ce8..c52bf10f746e 100644
> --- a/tools/perf/tests/bpf.c
> +++ b/tools/perf/tests/bpf.c
> @@ -312,9 +312,13 @@ static int check_env(void)
>                 return err;
>         }
>
> +/* temporarily disable libbpf deprecation warnings */
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
>         err = bpf_load_program(BPF_PROG_TYPE_KPROBE, insns,
>                                sizeof(insns) / sizeof(insns[0]),
>                                license, kver_int, NULL, 0);
> +#pragma GCC diagnostic pop
>         if (err < 0) {
>                 pr_err("Missing basic BPF support, skip this test: %s\n",
>                        strerror(errno));
> diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> index fbb3c4057c30..528aeb0ab79d 100644
> --- a/tools/perf/util/bpf-loader.c
> +++ b/tools/perf/util/bpf-loader.c
> @@ -29,6 +29,9 @@
>
>  #include <internal/xyarray.h>
>
> +/* temporarily disable libbpf deprecation warnings */
> +#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> +
>  static int libbpf_perf_print(enum libbpf_print_level level __attribute__((unused)),
>                               const char *fmt, va_list args)
>  {
> --
> 2.30.2
>
