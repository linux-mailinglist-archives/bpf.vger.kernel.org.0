Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B00485CF3
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 01:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343507AbiAFAMH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jan 2022 19:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245760AbiAFAMH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jan 2022 19:12:07 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008C5C061245
        for <bpf@vger.kernel.org>; Wed,  5 Jan 2022 16:12:07 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id l3so1099759iol.10
        for <bpf@vger.kernel.org>; Wed, 05 Jan 2022 16:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rNo0P2sjZ0RhpEmBrY9rNzFFCG4VEzv1uJcJe6Qd5Lo=;
        b=X4iFLLJU8FYexRvJmASrv+SiWC7WoFRr9E5qwqiJ1853h/TZsMEZM1DsdGMF0XLnT8
         06dHKU4xqlSMnl2dDy6+Xyi4u9HoHWL0n+pbfxG+AOI52fITit5kZI9U1tdcIMNP5afX
         trHyIwIPjWKQCdUMfvr/y8HB+/M2PJCneIcf7sh5Ma/t16BkQfvudhNWefMvWa+rDR9t
         NVo/ajwATsGKo9ov+T9Ut3ixGqqITuC0z4iG4edfVSoZMdt8D++43RBA02/+seT/vRjX
         5bIkbYmlsMntbyel0OIs6JW8hBa/YFNNbOSN6jjQHGZ2aVKqhwnntg3dHL/tY7RBW6r6
         F0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rNo0P2sjZ0RhpEmBrY9rNzFFCG4VEzv1uJcJe6Qd5Lo=;
        b=2/1EKUN0BTZR5WtHFvTlqP2UXguXNJWF0naUeC5uO5WifNW4W2+15fqrPiWhJVtY5d
         i/HQw1peiuMnY+5vQhAulYIaFitdT7YYhIoB2MJ0YTeXJeBuvxZbqj4qOQogtn9yuGyk
         5sCOTzCPIRIv+K66eH7+6E/QTYmqpi/s53FkvIgUYyXEATRdEXPifFyhFyLo/oUxUBgl
         yMXn6M1YIPJSQYwYEPV96fX9xXH61lmjEmknWpOWqwHgBl9TkBOlGifE7B14DvgGoiml
         24cdKNm/5weQwsgXW5rL/GVHKmwI3fXNh9QE2jChoGfwLQs+I3VOL6Y3HpFvCZQQnzZH
         d1FQ==
X-Gm-Message-State: AOAM531cMQCWBCLjaqzxfxVCFl1gVVbQgpRGG1StTam1+QVOHWpZN01a
        1lbIQPH2tuv0cTkQ/mFrUFXrfsBGdLN0B5Fq7/U=
X-Google-Smtp-Source: ABdhPJzBKSiHl0/IVMaLWWIscTiZczqvWg3/sBjUpU5t1IzyacfuAF9/bAm1aIt0AdNXG2vw3GSbsgup/G1EhYqEbUc=
X-Received: by 2002:a05:6638:1193:: with SMTP id f19mr27014109jas.237.1641427926402;
 Wed, 05 Jan 2022 16:12:06 -0800 (PST)
MIME-Version: 1.0
References: <20220105003120.2222673-1-christylee@fb.com>
In-Reply-To: <20220105003120.2222673-1-christylee@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Jan 2022 16:11:55 -0800
Message-ID: <CAEf4BzZFCQrBb63Dhha9H1ThWd8S+12v54gDdrGkos2iXSa13w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf 1.0: deprecate bpf_object__find_map_by_offset()
 API
To:     Christy Lee <christylee@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Christy Lee <christyc.y.lee@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 4, 2022 at 4:31 PM Christy Lee <christylee@fb.com> wrote:
>
> API created with simplistic assumptions about BPF map definitions.
> It hasn=E2=80=99t worked for a while, deprecate it in preparation for
> libbpf 1.0.
>
> [0] Closes: https://github.com/libbpf/libbpf/issues/302
>
> Signed-off-by: Christy Lee <christylee@fb.com>
> ---
>  tools/lib/bpf/libbpf.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Applied to bpf-next, thanks.

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 85dfef88b3d2..8a86d7e614bc 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -677,7 +677,8 @@ bpf_object__find_map_fd_by_name(const struct bpf_obje=
ct *obj, const char *name);
>   * Get bpf_map through the offset of corresponding struct bpf_map_def
>   * in the BPF object file.
>   */
> -LIBBPF_API struct bpf_map *
> +LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 8, "function has no effect")
> +struct bpf_map *
>  bpf_object__find_map_by_offset(struct bpf_object *obj, size_t offset);
>
>  LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_object__next_map() ins=
tead")
> --
> 2.30.2
>
