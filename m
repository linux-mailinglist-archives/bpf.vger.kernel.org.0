Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8000731327A
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 13:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhBHMhD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 07:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbhBHMfA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 07:35:00 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8BBC061786
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 04:34:19 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id d6so12542578ilo.6
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 04:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=liATDNgOLjcQYOYplIfD8sA0QWnd3m+cTXERSjw+MGs=;
        b=VVCchqmqAm0RYjP4IRkoXAghfoHZjkHKp91LbX+5HJZP3UNpTWIrpa4F+H1PjcjZaf
         TDIyVXVlQfRH0OxKiZ+M/1i6F/VFfr/7dfcgNyP8LB7aTvErz3u8YHZyw1QLNtIsF+xX
         gjF7HBE4dQpVO29oPpbXDZCdDWmj4OuyOLept74sxboTG9GDhgjLJtHk32GmExTzymA6
         A7sa0H1Um92+ven83wysLK9VFbS2QyM494CTuvoxN9B2TrRs3BsOJi9r+d7kFpuz37io
         hYZO5IFerqRoozG7Lm3ZJpjnyAHkc8YADQTkPg2chjz69o2rVsR85zBawnxfRIKjJ52f
         4KrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=liATDNgOLjcQYOYplIfD8sA0QWnd3m+cTXERSjw+MGs=;
        b=JGA8lfUyrer8fpj485k2SJ0z5VzCVDiemTDDpjZzaj7oQKcXiYrXpGxSAB7z2lfO/B
         ZlMu1yRO4rbc4NyNPsPiCgZBBEjs+vH0zkRLm1jEPIy1rlPtm+R++j8A0NEfxHuQ/cXi
         vUmdYBUkoDRFp31zb4fiRa20S2bw0seT7Cw9MCE+u6uuRdFkLz0u9E5UmfCSlQXbtUqh
         /Fx6Ss/sBeR4Q5/+B327J3+eriPx4nzdae16h3IC2e+GWJ5f/wCfqulFVoZeWlEAjdjf
         MR7/W7cM84VKseXiuF10Bd2l06QKU3hDfmzl+zg5yZUsOwFjSLLWgXGXS2wbsVxwu90q
         wzZg==
X-Gm-Message-State: AOAM533o2T9caSwNIw6BlcNYANVGcBlFMrqQZw4WkuT5PEy8v0Cbv9C4
        2mH7CL5YiJtPoi8HjSrh9eDvUdHCENfvzPfCPJJQct8+EyT2Kw==
X-Google-Smtp-Source: ABdhPJz+3kPmXAWo6QjpXqjuswcGIfqAIqq+grnhW1RRNYc7vilebt3qauavmtOQ/YHJydu8FqtN5D1ucZOSS2W3bBs=
X-Received: by 2002:a92:c24b:: with SMTP id k11mr15527720ilo.276.1612787658828;
 Mon, 08 Feb 2021 04:34:18 -0800 (PST)
MIME-Version: 1.0
References: <20210208123122.956545-1-jackmanb@google.com>
In-Reply-To: <20210208123122.956545-1-jackmanb@google.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Mon, 8 Feb 2021 13:34:07 +0100
Message-ID: <CA+i-1C10Pn01x5SfxsM14e_-7o0Ot3tj70-3JR7m4uUDdmr8QA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add missing cleanup in
 atomic_bounds test
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sorry this is garbage, I edited one tree and then built/tested a
different one. Please ignore, v2 incoming.

On Mon, 8 Feb 2021 at 13:31, Brendan Jackman <jackmanb@google.com> wrote:
>
> Add missing skeleton destroy call.
>
> Reported-by: Yonghong Song <yhs@fb.com>
> Fixes: 37086bfdc737 ("bpf: Propagate stack bounds to registers in atomics w/ BPF_FETCH")
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/atomic_bounds.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c b/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
> index addf127068e4..290506fa1c38 100644
> --- a/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
> +++ b/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
> @@ -12,4 +12,6 @@ void test_atomic_bounds(void)
>         skel = atomic_bounds__open_and_load();
>         if (CHECK(!skel, "skel_load", "couldn't load program\n"))
>                 return;
> +
> +       atomic_bounds__destroy()
>  }
>
> base-commit: 23a2d70c7a2f28eb1a8f6bc19d68d23968cad0ce
> --
> 2.30.0.478.g8a0d178c01-goog
>
