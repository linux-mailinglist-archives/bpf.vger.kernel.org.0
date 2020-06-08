Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5A11F1E61
	for <lists+bpf@lfdr.de>; Mon,  8 Jun 2020 19:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgFHRca (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jun 2020 13:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgFHRc3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 13:32:29 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D42C08C5C2;
        Mon,  8 Jun 2020 10:32:28 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id n11so18071330qkn.8;
        Mon, 08 Jun 2020 10:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wiyYnmTzYSUjW1pI9XvsoK8vnffjXKMIWRhj22x93qs=;
        b=b2exqroGLJlKAiaFUB2ayaR382R7eYydqlnzQ3J8KOhtVI+eCiT6ow6HhiuRmKrFxe
         A/roIyJagDiFHrSCNYv3d2Ne1RDCywJiVAMlJSblHpyxM5w9LoxUD3gBDmr6k1JI64S6
         mCY/VfNsW5JeIlU0+VffIKg8OFUhV3hcLdRQfm9QwedkklNCWWt2/HPWV+lpuSSkK9Yo
         FqPKBfxxPpRlJ/UVrIcCqM3zsoqhzWF5/RMC8jgD9zWVTQvJvKj7UfrI1maibEIzcpi5
         Ru7wbKiFTlweCkKeZA3MEsegm9xKPQGXwpsFOiKl58mGoeGdy27fRVDdZsxuu0ZKp7zQ
         tXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wiyYnmTzYSUjW1pI9XvsoK8vnffjXKMIWRhj22x93qs=;
        b=C6T19w4XkHfEIfDAyP6fIATwhiIaA4cRUWvkLpr+M6CJxQhaPYm9ti2VUXxBAGLvEd
         t3p1z7oS6eU3mOKgwEk4p3KuXuV2Sfsf+RHI9MakHrZlvlbknEtusInlD39AuOn4HiLw
         hCbyWYb7Q8vnK/vl/ZeiVJlJO0La4qcCUzAAydFSwCTRTmmroNsHFN+wyyjQ7PQif8VZ
         9GAcpN19AosPG4VzwHZI53O1Hm+IEzreSquZ8bzaY5JD2omWGFleqTy9kWg4HMltXNmf
         Aoi6nSysVGL74po1niYfbAiKB1vHHpSXWeQxA667ZCBtqX7Je9pE/C3X3aYmN+Jc+F+B
         YvBA==
X-Gm-Message-State: AOAM531rbTJaHQBMIHQL0HTUepNFPNKDQJT4X6wXGXxIcXDck9Bist+t
        /bQ2mEXW43Kk2gLFl366p93h68jIYVin2DujyWQ=
X-Google-Smtp-Source: ABdhPJxRA8BbenfYxtHxRI4JRkin2d7mG5O5bq5gnYS6ILL2A+WZIOC5fFk25VSq99xAbRWYSrTHHmhgaavstmXh/pk=
X-Received: by 2002:a37:a89:: with SMTP id 131mr23050145qkk.92.1591637547514;
 Mon, 08 Jun 2020 10:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200608161150.GA3073@kernel.org>
In-Reply-To: <20200608161150.GA3073@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Jun 2020 10:32:16 -0700
Message-ID: <CAEf4BzbEcV6YaezP4yY8J=kYSBhh0cRHCvgCUe9xvB12mF08qg@mail.gmail.com>
Subject: Re: libbpf's hashmap use of __WORDSIZE
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Irina Tirdea <irina.tirdea@intel.com>,
        bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 8, 2020 at 9:11 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Hi Andrii,
>
>         We've got that hashmap.[ch] copy from libbpf so that we can
> build perf in systems where libbpf isn't available, and to make it build
> in all the containers I regularly test build perf I had to add the patch
> below, I test build with many versions of both gcc and clang and
> multiple libcs.
>
>   https://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html
>
> The way that tools/include/linux/bitops.h has been doing since 2012 is
> explained in:
>
>   http://git.kernel.org/torvalds/c/3f34f6c0233ae055b5
>
> Please take a look and see if you find it acceptable,
>
> Thanks,
>
> - Arnaldo
>
>   Warning: Kernel ABI header at 'tools/perf/util/hashmap.h' differs from latest version at 'tools/lib/bpf/hashmap.h'
>   diff -u tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h
>
> $ diff -u tools/lib/bpf/hashmap.h tools/perf/util/hashmap.h
> --- tools/lib/bpf/hashmap.h     2020-06-05 13:25:27.822079838 -0300
> +++ tools/perf/util/hashmap.h   2020-06-05 13:25:27.838079794 -0300
> @@ -10,10 +10,9 @@
>
>  #include <stdbool.h>
>  #include <stddef.h>
> -#ifdef __GLIBC__
> -#include <bits/wordsize.h>
> -#else
> -#include <bits/reg.h>
> +#include <limits.h>
> +#ifndef __WORDSIZE
> +#define __WORDSIZE (__SIZEOF_LONG__ * 8)
>  #endif

This looks fine, I also build-tested it in Travis CI, so all good.
There is actually __SIZEOF_SIZE_T__, which is more directly what
hash_bits work with, but I don't think it matters for any reasonable
system in use :)

So yeah,

Acked-by: Andrii Nakryiko <andriin@fb.com>

Are you going to do this change for libbpf's variant, or should I
submit a separate patch?

>
>  static inline size_t hash_bits(size_t h, int bits)
