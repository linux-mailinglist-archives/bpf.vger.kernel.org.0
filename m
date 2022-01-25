Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5F649AC6E
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 07:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345779AbiAYGbt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 01:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345218AbiAYGZ6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 01:25:58 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD8CC047CC3;
        Mon, 24 Jan 2022 20:48:49 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id c188so68522iof.6;
        Mon, 24 Jan 2022 20:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CBXxuSiymF11Oejvoafc+U1afHIzhOmTlChuJG8NJDk=;
        b=ke/EMXQAr0L4htTJP1sMgQvOC0xJCivMVUIe95wgnMwClNHxsztILYVXJECmupWANT
         8L9qhs9VOEwWxLj3efkH87Cd3pNJvUVkw/JyKY5hitA1ZplcKpGYduaqoqhiiOJMvdtI
         1Aoq6UbbquWTsh8ymTo0n2Xbc3pRuuAU/5HO3pNJcPAIrHIvcOvyKKJpHeC0ZL2vbv6l
         rn1mpKaQ0T4ygzYLdcgJ3ePtJ8aU1JITJz0vzKlpOi7wPfIOiBT4F4HRbubNIPLc9fgf
         17XHo17zfUIAwqYlliXbNf2dCBaK0IkCifcASAArQFjZU5V1DB0UtgxtyJSyrBphUE3u
         6yWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CBXxuSiymF11Oejvoafc+U1afHIzhOmTlChuJG8NJDk=;
        b=RZXvtADJjYQcm8WDlHiZEOpt65kHuFreRvOwU3zrBspzbAQwBdeuWJD8+dmv2L8JpA
         UjrIrA1+/jpz2kqYND6V1Bq3Tn4lpmuh/ai0AxpOtQy4lj6HtRsPj51l163sYAGz2VDF
         2uU11pKll4ZjvJYL8eJSyYV6sTd6hsm4Q8UW1yXBTSs09npA+eAYcSjtm6LUl9YSszVw
         EyRbUX30NHShdVjG2LLR/AcpJziNYHdzGAPkMGY6TUg21j96knimIFYZ2YJBr4EB36Cy
         9u0EyQ15frnpyEAWHcg+h8qkhlSs9PIo5CdlRtblEXUh8D5z3vNrcm/AM3eAaBuGIOhp
         ALJw==
X-Gm-Message-State: AOAM532c+bANuFsbNkoEpouU8Qr4TFNVmDvJVLmZzxqcxrbf4NYowsQm
        63PfiPuWIs4NzX77eYS06SfMSyjCgvjpicmSG7M=
X-Google-Smtp-Source: ABdhPJxV3zGz/f+boIeO5w0PRZCNSuIevCY8xLZhyEQzL0Y+R0TDVfsoskkbktR1m/Qfjx0FtB/rpSBjAXY36lbsDog=
X-Received: by 2002:a02:818a:: with SMTP id n10mr7735884jag.145.1643086128578;
 Mon, 24 Jan 2022 20:48:48 -0800 (PST)
MIME-Version: 1.0
References: <20220125005923.418339-1-christylee@fb.com> <20220125005923.418339-3-christylee@fb.com>
In-Reply-To: <20220125005923.418339-3-christylee@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 Jan 2022 20:48:37 -0800
Message-ID: <CAEf4BzaTiTQNNL7aKz2MbdYZ1UG9A94bVgi=v96VgGA4dGMKog@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] perf: stop using bpf_object__open_buffer() API
To:     Christy Lee <christylee@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Christy Lee <christyc.y.lee@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 24, 2022 at 4:59 PM Christy Lee <christylee@fb.com> wrote:
>
> bpf_object__open_buffer() API is deprecated, use the unified opts
> bpf_object__open_mem() API in perf instead. This requires at least
> libbpf 6.0.

Not 6.0, but 0.0.6 (not even v0.6). So it's a very old API. I removed
the __weak stub because it should be there anyways.

Fixed up commit message and applied the series to bpf-next, thanks.

>
> Signed-off-by: Christy Lee <christylee@fb.com>
> ---
>  tools/perf/tests/llvm.c      |  2 +-
>  tools/perf/util/bpf-event.c  | 10 ++++++++++
>  tools/perf/util/bpf-loader.c | 10 ++++++++--
>  3 files changed, 19 insertions(+), 3 deletions(-)
>

[...]
