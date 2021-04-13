Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3C635D62A
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 05:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241937AbhDMDwL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Apr 2021 23:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241484AbhDMDwL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Apr 2021 23:52:11 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D96C061574
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 20:51:52 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id x8so11495292ybx.2
        for <bpf@vger.kernel.org>; Mon, 12 Apr 2021 20:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qxqat+6A/u/5IvVcDBWQIdodCT9C8M8TgZ9YzgMHVic=;
        b=NrNUSfjYorVQEjcBOXGkN05FkHxtZsloYRoTSc+V/Bgm0mM1L1pCTwfZFFR7IA/fF7
         l9WwNwmPzVaH6VIVjAC2mtaWrB+kO/Y+5SFej6w+VUayGP+IwwxBY5lneSfavwR6v8IB
         LB1JMG6cMlKrMEBfJSs0g/bayV5hLLP8TjbxIjExTfsCvSI+Q6bkWjP372ADmz3VuJ9c
         hBZJXqv3Ar3DWnNz828NOrNM1OvY0Ex/Ji8c18Ey4w1F+mpW2eqGD6qvvKyNvqYqqmVf
         Ryxa6lLGuOeNkha5111mYT+vo321aIS8hPf2NAeWd3aGtPPm1hdo296Nbtgiqaz5HNtl
         Q7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qxqat+6A/u/5IvVcDBWQIdodCT9C8M8TgZ9YzgMHVic=;
        b=GtxxfxTFlgIQTtlxtJBxtnf8opSISQdN/IpaVEeUkOja/hT5GjZatZTOp1eI47OB37
         yUWuyb1g9amOgeMfnbqp0RFe8TjRj46QddNbrFeIDeOIKS37UR865PfTnII6ZGE+dh7x
         fsRIqdHKRrB7VRn7ewDXnuocXuJOssi/Z/fECG+3ji8WXpexkVO/zgG3MYLWHNeKGftr
         AIw7rL6I0Q3tSA7gVUquNf8dUojUVXuhklkdrIGcCy58AC7MrDs9f8abMb7Ka5Ak329w
         AK7Cx/uUY7DIfTejTav7k4WgqvuAoJqsmhjD8T9X6V/gbIZOp0IHIpYu7kASPFTp2fZS
         dWPg==
X-Gm-Message-State: AOAM531N5JM9afaS/DKAhGDI2nIZTrltk/J5YN+OIE56xSLYzynIiqUH
        salZsENUAUWO8xG7xlMjJOlhUnhZhO1xFxF/br8=
X-Google-Smtp-Source: ABdhPJyMAWMoyJz3lCpRBFwivY5WMqVld6G9iF1CV7Xn/FHP/Jw3D6IbtINGOIn5YhdRxj19Zs0SsdnNgj1jMqKC5Ds=
X-Received: by 2002:a25:5b55:: with SMTP id p82mr40585420ybb.510.1618285911249;
 Mon, 12 Apr 2021 20:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210410175601.831013-1-joe@cilium.io>
In-Reply-To: <20210410175601.831013-1-joe@cilium.io>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 12 Apr 2021 20:51:40 -0700
Message-ID: <CAEf4BzYKVR78gug7UYNb53jvgJ-xvxccjpiTWEgWjccQyUay6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Make docs tests fail more reliably
To:     Joe Stringer <joe@cilium.io>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 10, 2021 at 10:57 AM Joe Stringer <joe@cilium.io> wrote:
>
> Previously, if rst2man caught errors, then these would be ignored and
> the output file would be written anyway. This would allow developers to
> introduce regressions in the docs comments in the BPF headers.
>
> Additionally, even if you instruct rst2man to fail out, it will still
> write out to the destination target file, so if you ran the tests twice
> in a row it would always pass. Use a temporary file for the initial run
> to ensure that if rst2man fails out under "--strict" mode, subsequent
> runs will not automatically pass.
>
> Tested via ./tools/testing/selftests/bpf/test_doc_build.sh
>
> Signed-off-by: Joe Stringer <joe@cilium.io>
> ---
>  tools/testing/selftests/bpf/Makefile.docs     | 3 ++-
>  tools/testing/selftests/bpf/test_doc_build.sh | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile.docs b/tools/testing/selftests/bpf/Makefile.docs
> index ccf260021e83..a918790c8f9c 100644
> --- a/tools/testing/selftests/bpf/Makefile.docs
> +++ b/tools/testing/selftests/bpf/Makefile.docs
> @@ -52,7 +52,8 @@ $(OUTPUT)%.$2: $(OUTPUT)%.rst
>  ifndef RST2MAN_DEP
>         $$(error "rst2man not found, but required to generate man pages")
>  endif
> -       $$(QUIET_GEN)rst2man $$< > $$@
> +       $$(QUIET_GEN)rst2man --strict $$< > $$@.tmp
> +       $$(QUIET_GEN)mv $$@.tmp $$@

if something goes wrong this .tmp file will be laying around, so we
should at least add it to .gitignore?

>
>  docs-clean-$1:
>         $$(call QUIET_CLEAN, eBPF_$1-manpage)
> diff --git a/tools/testing/selftests/bpf/test_doc_build.sh b/tools/testing/selftests/bpf/test_doc_build.sh
> index 7eb940a7b2eb..ed12111cd2f0 100755
> --- a/tools/testing/selftests/bpf/test_doc_build.sh
> +++ b/tools/testing/selftests/bpf/test_doc_build.sh
> @@ -1,5 +1,6 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +set -e
>
>  # Assume script is located under tools/testing/selftests/bpf/. We want to start
>  # build attempts from the top of kernel repository.
> --
> 2.27.0
>
