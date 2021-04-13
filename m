Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE9835E999
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 01:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347992AbhDMXSf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 19:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhDMXSf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 19:18:35 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C0AC061574;
        Tue, 13 Apr 2021 16:18:14 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 82so20034686yby.7;
        Tue, 13 Apr 2021 16:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xoZuauWdKG6wQbThFxJJq+ycUIdgRef2r4Hhu31DdiE=;
        b=WyL7wmq2k2qpj04p7+7N8guSbbHZmOGwHRmk+HH4YpRoRws+6OHbBpcTh7vpGoj0gi
         cXyIKcdWYvPs7gSDTrz3xxxHbHMRVf8VZxnMjr6/KqkjaHskH3xQ1GgTVSzxQgRExWXL
         H2FyKFHfIJGdlxTyDsYVeuNt/1OdL7jetkH7lH1vMq0NATY/omoyHQg32pi2lXhRLDCz
         2gVyyrcSNzEDYNfltdlRXTd43m+EQU9sjnqE6oWC8iezwVFFOu5NrJvZHSYnVLRxtS5o
         UfgplGlehH66Ej1NBstVDeOVooMbAsJYrPf53w4jk310sN6WoA8sAyVhtjJlRz383FWM
         tMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xoZuauWdKG6wQbThFxJJq+ycUIdgRef2r4Hhu31DdiE=;
        b=r0EjRUXDMsvakhCALAkoW6RZyc9+wJLkHvSRqBmg8YyjHtGFrvty+el9kxtKFNydz0
         ZU+tWRRxLSXpNXbfyh37jw5vBI5mICj9J9qJiW29mO+0kp/TgFdvbJCXhr/DREZnIxRF
         ln7OZhH5p8RkFLPbrGOdSEsNLygIcwfykJXOWVZaFS7Zgi7gQSZvqguPqS6MBB+Wf/Dg
         0ZWJoX7iDdOBRCAJTYZ8/q9HvewmlrpuIVQyKP2NqebuCxqR8qtn06gsc5SoK4EKNgH5
         9PEVI8P3UjUl+64BtW4LxgC1SEM+z/jea5R6tPTvN1+KrxwLhkhcNO247P2lAgFgnkL8
         0Hmg==
X-Gm-Message-State: AOAM530OIZP3UtgMocnwT+kzGHYTszdEdUgobEMYs6cCFlwDPgEBua7u
        MFPbU4GgtSU2VcRB4GXOo4oYk+wHpLtPlLFOjTceV64TIcs=
X-Google-Smtp-Source: ABdhPJwsg1JzChbTCIdI1AXAM2WQ3OCbBxrMWKNFcavgk2xDaSrNrHaF+LKcAM/Fvk6gViCzp2Omvu2yF2WDlkxS0Y8=
X-Received: by 2002:a25:d70f:: with SMTP id o15mr36679045ybg.403.1618355894254;
 Tue, 13 Apr 2021 16:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210412153754.235500-1-revest@chromium.org> <20210412153754.235500-5-revest@chromium.org>
In-Reply-To: <20210412153754.235500-5-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 13 Apr 2021 16:18:03 -0700
Message-ID: <CAEf4BzbYBs2FZEMGPrRZ7oLtkY0TO6yaGJBzm+0NBJO=qQYc3Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/6] libbpf: Initialize the bpf_seq_printf
 parameters array field by field
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 12, 2021 at 8:38 AM Florent Revest <revest@chromium.org> wrote:
>
> When initializing the __param array with a one liner, if all args are
> const, the initial array value will be placed in the rodata section but
> because libbpf does not support relocation in the rodata section, any
> pointer in this array will stay NULL.
>
> Fixes: c09add2fbc5a ("tools/libbpf: Add bpf_iter support")
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---

Looks good!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/bpf_tracing.h | 40 +++++++++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 11 deletions(-)
>

[...]
