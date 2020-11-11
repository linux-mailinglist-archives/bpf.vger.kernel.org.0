Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EC42AE7B7
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 06:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgKKFE3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 00:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKKFE3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 00:04:29 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF9DC0613D1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 21:04:29 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id v92so787127ybi.4
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 21:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z81c+4AEu4uMBWSvBVF9NEwB4mFVhyrDqz2rFzjXmTU=;
        b=E6vQW3QrCvEFPgv6DAvOJDgxkI5wSOlj6TGkc857qw1JbHCsOEOdSk9ppLuVEp1Q90
         N2ZfGLtw15PV1mGj6auA8G/FCVjMoFAy59ep/CghHXyGDu6I92kUXyWC/wTV9YY0B/Cy
         7PdyAUgvY8EscNZJ0khSm3yKrLSthqmtvufAaS9qhsAcquKayC/JohbfRxKoRyp+69dq
         AV7InwFuwecBwWrYQwGPY+ndJVV1nKlt34VrqPHEIe73q1UVLTb+VVTBQX2IGPTbnE2T
         uVuFjkbHv61Af0UVDPH+yAl+2WWXZw1tHzDuQrpyIwbPz8m1yU725U+gGdMJYyhkKKSn
         VDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z81c+4AEu4uMBWSvBVF9NEwB4mFVhyrDqz2rFzjXmTU=;
        b=EXozDCiRplST61jN8ZnL/eYej+nEpSf0RN88lysp1LXL7m29hUVAPq7KxbzaZ8bOYV
         qDgR0F/qKgplLeQ3BHgqrA0UWwWzS6UKgcvwGSbs6gnR3AQP8UZFdrOl7ANAd8LShcQp
         9TtEOVm76/Bn/ObJOVhTYYISNnyi9UJgtkOhSyHRnSXuOykCrYL4up7ZfaTJN28Hu2zJ
         yTd/5JdsjLWwcFIwZHXJDoIqAJPiKfB/5p1GjG2UYQaZqiNQLbIDrFRkgncQ+0242cY0
         xbAQrNjT0nuYKVEQ5S4nAYT3s95QYQBbeIaGUjIzIciNazNqqLUESqiTgvDmmZAhHSRD
         /v7Q==
X-Gm-Message-State: AOAM533KyrHs9pQsFIks7S7qLI7Jn4SaDOaeJmnlUcyWfzXxVZPM263p
        AdCwiKpNZrTgPXm+sIE48DC4jWd0h91k0qegeAs=
X-Google-Smtp-Source: ABdhPJzk7PiOkou3kYIKLtxjD9znrLjTUolychJUH7ZX2s6V6gji22jGKq37P4XkbV1eKmTsmdl3Ae/Z6YL9wXEOX8E=
X-Received: by 2002:a25:c7c6:: with SMTP id w189mr31875882ybe.403.1605071068455;
 Tue, 10 Nov 2020 21:04:28 -0800 (PST)
MIME-Version: 1.0
References: <20201110164310.2600671-1-jean-philippe@linaro.org> <20201110164310.2600671-4-jean-philippe@linaro.org>
In-Reply-To: <20201110164310.2600671-4-jean-philippe@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 10 Nov 2020 21:04:17 -0800
Message-ID: <CAEf4Bza8Q_xaT9-xehH=GxfDLjDE_RZ5SSo9i_Ho4979qCWkrg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/7] tools/bpftool: Fix cross-build
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 10, 2020 at 8:44 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> The bpftool build first creates an intermediate binary, executed on the
> host, to generate skeletons required by the final build. When
> cross-building bpftool for an architecture different from the host, the
> intermediate binary should be built using the host compiler (gcc) and
> the final bpftool using the cross compiler (e.g. aarch64-linux-gnu-gcc).
>
> Generate the intermediate objects into the bootstrap/ directory using
> the host toolchain.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v3: Always set LIBBPF_OUTPUT. Tidy the clean recipe.
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/bpf/bpftool/Makefile | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
>

[...]
