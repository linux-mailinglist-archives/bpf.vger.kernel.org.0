Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27F331A697
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 22:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhBLVNB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 16:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhBLVM7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Feb 2021 16:12:59 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40221C0613D6
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 13:12:19 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id y128so761003ybf.10
        for <bpf@vger.kernel.org>; Fri, 12 Feb 2021 13:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B/RmsJFHHYAYVim6DhSGp3u1F15sA1VLLlFl+rVluV4=;
        b=DQ5o7njBYKi1kOEaF7cwtpNwf46or2pL9rKfxe6FlwmQXXrNYPGySDeVX/zSAbObxJ
         AYZ04AZzfP/waSaDaCYo0XOrFlVWPHmJ7GpVuPRNAS8/vmJQKrCMZ8Stb686yOlLkETV
         6RKia5T6KUfrYaKp9KeTPthji8LdVTJMnkQ/Xzc5/NgtQoXX/ily72u+WyRNpX9oQXWN
         3cdIWCcpHjKJuAXv7B1TDj2DbzzWKg/6qtAS7U1Eu+ngr2qwXRKN89GO4LiJtS5BtOKk
         xpEMHODPVKAwbIrHR3fuess3TdASO0rbbWQw//LUeF8qXs7UuMMnYWLRa07iBKKtzLy/
         Jjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B/RmsJFHHYAYVim6DhSGp3u1F15sA1VLLlFl+rVluV4=;
        b=Z1wvRv6qSDYRlHNtOGmKP8k6dcaSO1dZRS3+yFQ30fEpASKOW8XavtT+SpslN2EdVq
         7yoFFAOHzwEf1w3CZwWuiAkVjqQRtNVSxnuVA3JtSr1eqxq6Haunj7glLKMeQ6GDs94b
         g2ahYTEUrF+8wDfrM+7sai0i5qI9VKx2qZHiA1bx/vS3VDBbIRhlVqbzf9yWDJQKgsh9
         bZpAPG70B+ddpwYsQvYtxMzAfj0cIQJsgMHxyiPyNbW76s3kxXg+0hhNxJM8Kp5K3J5B
         bvjdGO+QAW4rwIIALgNUFdxm+J7FQNbTjaYHUapoa7kO4kTI8b1GpjdChXr791Ls6unz
         rFxQ==
X-Gm-Message-State: AOAM531LsSDXJ9woYUucidIWaOkabV+VGRY8/iUXizS6EboqH+TyirVx
        b2KDTNjBU9GFSSBTerzr153PtRp4dHoKrgcZkgc=
X-Google-Smtp-Source: ABdhPJygYBkPKq4hPImPOch4eDsYMTtdXZ9DPC1VtLjphyLL0NJ/fj46/7+gF5wlsFTOMqWZXI91xkgiyxfL9DXSt+0=
X-Received: by 2002:a25:a183:: with SMTP id a3mr6584541ybi.459.1613164338586;
 Fri, 12 Feb 2021 13:12:18 -0800 (PST)
MIME-Version: 1.0
References: <20210212205642.620788-1-me@ubique.spb.ru> <20210212205642.620788-3-me@ubique.spb.ru>
In-Reply-To: <20210212205642.620788-3-me@ubique.spb.ru>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 12 Feb 2021 13:12:07 -0800
Message-ID: <CAEf4Bzb0_aTVxZ6+RVLNOO4tiFar+rjR104WH_Uhe-N4oajxcw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/4] bpf: Extract nullable reg type conversion
 into a helper function
To:     Dmitrii Banshchikov <me@ubique.spb.ru>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 12, 2021 at 12:57 PM Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
>
> Extract conversion from a register's nullable type to a type with a
> value. The helper will be used in mark_ptr_not_null_reg().
>
> Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/verifier.c | 83 +++++++++++++++++++++++++++----------------
>  1 file changed, 52 insertions(+), 31 deletions(-)
>

[...]
