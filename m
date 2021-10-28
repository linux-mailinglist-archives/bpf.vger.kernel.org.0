Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B51B43E819
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 20:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhJ1SS0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 14:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ1SSZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Oct 2021 14:18:25 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8389EC061570
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 11:15:58 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id y3so6437050ybf.2
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 11:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ZLJHg27Wt6LhgyeU+QEZdroihx+F7OP+pzCANmkDlE=;
        b=GfTKQnZLwsv+AVW1TYL1TWepYPdcCeiuboECo31FjkD12IpKufVtdIJOP/IxumUgja
         fLhmhLPIGyLKuN5nsreHotTQnE5l6xosQRc0VGtpj+iEZeYpYwauc5tWcCdEuU9Qft7L
         zwvBrkSe1bTf8OY21LgjmhDg7/y8Sn3FUL2+Nvn6auh8sFTczHN1h1KDrMMJsuMwRmLk
         YT8s4qD6uGYTOoLfzfXsX69hNiqDliinQkYKdhDCyO5j3VPLKc+J8WXr91O0433FF1hN
         vycdMzYu8Z1ma30sRGPDAQ/ggy1aATBtEvxU/I7XL3DRxOc7j4cXCpwuxOwLyBdHr7nX
         CFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZLJHg27Wt6LhgyeU+QEZdroihx+F7OP+pzCANmkDlE=;
        b=FXqfrVFkNO3iMXDWnWveTBg4+cfUZzdNnHOV4PQaLIVHOhfMVdyQu1/V7Kix7RQJpt
         NG3Y3BQkbLALt0DC6a9A+pG3hKCEFlTwTrjJGcJ7ntNMlL4BvYYx2CfrIar+5h2ySdFu
         LOhMaHI0xp+YGEwqwlxqDiWNQhTvurbOefxGOuYd1jGEz48aRH9H3C2SZQdZ+mSzeyu7
         iFOydmI+YjSTLMRTgUQAa3ZTbXD3ezxc0OscGYSl6uPc1DKPk1i0flt/89ODi0pLSV7F
         B99HuBZMjqo/M3uXUWPxzaptBRyd5tSnFoOkc/hHRDX0yxrAhVoIWK9P8Nm+0afZllf6
         ptQw==
X-Gm-Message-State: AOAM53260ja2I6jeewR5he1ZbDvapMOeL729mDUfdc3P3/vK760mWYh7
        8f60+6KlU/OS3g3sg+wfiITkW1Vcr2ogU3aZTt2Kad8qWj2lXg==
X-Google-Smtp-Source: ABdhPJyxGo6jworhEK9gV+3yBQIX4NYpePXbOBIjoKXh2/cw0EnNsuEjYddJUuSsVtx+OiisOSyNQbfj9entVOtkyfU=
X-Received: by 2002:a25:b19b:: with SMTP id h27mr6750255ybj.225.1635444957704;
 Thu, 28 Oct 2021 11:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211027234504.30744-1-joannekoong@fb.com> <20211027234504.30744-2-joannekoong@fb.com>
In-Reply-To: <20211027234504.30744-2-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Oct 2021 11:15:46 -0700
Message-ID: <CAEf4Bza5SJgYABaM2s-s3cdYEEvrbkgp2MOqQiDgX8dCsJ_Y+g@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 1/5] bpf: Add bloom filter map implementation
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 27, 2021 at 4:45 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> This patch adds the kernel-side changes for the implementation of
> a bpf bloom filter map.
>
> The bloom filter map supports peek (determining whether an element
> is present in the map) and push (adding an element to the map)
> operations.These operations are exposed to userspace applications
> through the already existing syscalls in the following way:
>
> BPF_MAP_LOOKUP_ELEM -> peek
> BPF_MAP_UPDATE_ELEM -> push
>
> The bloom filter map does not have keys, only values. In light of
> this, the bloom filter map's API matches that of queue stack maps:
> user applications use BPF_MAP_LOOKUP_ELEM/BPF_MAP_UPDATE_ELEM
> which correspond internally to bpf_map_peek_elem/bpf_map_push_elem,
> and bpf programs must use the bpf_map_peek_elem and bpf_map_push_elem
> APIs to query or add an element to the bloom filter map. When the
> bloom filter map is created, it must be created with a key_size of 0.
>
> For updates, the user will pass in the element to add to the map
> as the value, with a NULL key. For lookups, the user will pass in the
> element to query in the map as the value, with a NULL key. In the
> verifier layer, this requires us to modify the argument type of
> a bloom filter's BPF_FUNC_map_peek_elem call to ARG_PTR_TO_MAP_VALUE;
> as well, in the syscall layer, we need to copy over the user value
> so that in bpf_map_peek_elem, we know which specific value to query.
>
> A few things to please take note of:
>  * If there are any concurrent lookups + updates, the user is
> responsible for synchronizing this to ensure no false negative lookups
> occur.
>  * The number of hashes to use for the bloom filter is configurable from
> userspace. If no number is specified, the default used will be 5 hash
> functions. The benchmarks later in this patchset can help compare the
> performance of using different number of hashes on different entry
> sizes. In general, using more hashes decreases both the false positive
> rate and the speed of a lookup.
>  * Deleting an element in the bloom filter map is not supported.
>  * The bloom filter map may be used as an inner map.
>  * The "max_entries" size that is specified at map creation time is used
> to approximate a reasonable bitmap size for the bloom filter, and is not
> otherwise strictly enforced. If the user wishes to insert more entries
> into the bloom filter than "max_entries", they may do so but they should
> be aware that this may lead to a higher false positive rate.
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---

Don't forget to keep received Acks between revisions.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpf.h            |   1 +
>  include/linux/bpf_types.h      |   1 +
>  include/uapi/linux/bpf.h       |   9 ++
>  kernel/bpf/Makefile            |   2 +-
>  kernel/bpf/bloom_filter.c      | 195 +++++++++++++++++++++++++++++++++
>  kernel/bpf/syscall.c           |  24 +++-
>  kernel/bpf/verifier.c          |  19 +++-
>  tools/include/uapi/linux/bpf.h |   9 ++
>  8 files changed, 253 insertions(+), 7 deletions(-)
>  create mode 100644 kernel/bpf/bloom_filter.c

[...]
