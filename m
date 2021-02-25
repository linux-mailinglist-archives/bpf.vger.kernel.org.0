Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674FE325A29
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 00:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhBYX0C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 18:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhBYX0A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Feb 2021 18:26:00 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7DEC061756
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 15:25:20 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id d9so7157591ybq.1
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 15:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0k7zk/ur15JskICPOe9gb7awt3XaQD0RRyXT+UgrZ8A=;
        b=ElIGvVQkWwHPrvnhygOcUXo+o40XG1v4wIU5kqcBqrPWaghTCUOBt7SgOixV7zf8ml
         SURN1CgWKYrT87VDuvxYXmWrXjsWQ6cXbAsql5hFBymRBYIYxIahRiJvC7//ggyLG24G
         Bo5dkXMhCEvMBVwsG70N83YVxbl0g9QPH5t4E2UlkDyQbbWsJzeNe18+p9AT/SF2Jltj
         b5L2x6fGOro1jEPXfAGui9iZXH4Kn8Mehiy3BIM2qUYuUdphuZGX1jHKoaU1l/eGL9oR
         AUbQ0R44xYCHJ+ETzZ5absp0fRVCSMc/KtWhAQQU2k1UQwvYcimXv5nXcgLZnWwyetwy
         liew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0k7zk/ur15JskICPOe9gb7awt3XaQD0RRyXT+UgrZ8A=;
        b=pt5XtK2hRb7C6V1ZHhYgQnG21m3k2QCrdmte7BF8he2uzVw86xZYXZ+pTMXPt2xX5z
         N0aNENQHYvrzezO66Zoy94WPlKLzXq2NYQhnZH19xWrlpkx91PTAOu8874+zXIXXkuR0
         Y0O730ho/bAmthqb2hyevMhtz/xCGKfw6ycn8u7Xz04aDBPaJrhmqEAJ43RH2G2EoXDx
         pDiQ2SziCfmHAebonZf+fiwHCuzSx12EGD6l+TEctf/+KSMa/Ms1BSF2rFtgkGbZiNSr
         hk1ZxQOggJome3K4ywW95+ezszlWEKRrSCB9dHziChuxvUSpSjVhVlAmZpjZFEqvAJWR
         W7+g==
X-Gm-Message-State: AOAM531MWb1l7eCPdSIJMoIOPbVxtlvphv5tl8dtvk/cYGhltJyq5UXC
        lVChPAWUkNsDNtzNrs/KmNtCfBMGSFc3/ukljzo=
X-Google-Smtp-Source: ABdhPJynEk7Vt67fy/ILAUs3h+moV3nbRmlN/x63yRYYF9SuFQ/sDuJN3Yg+zCAUxiF34p7mFEhn9SEPY8EMhMGJvVQ=
X-Received: by 2002:a25:1e89:: with SMTP id e131mr373890ybe.459.1614295519924;
 Thu, 25 Feb 2021 15:25:19 -0800 (PST)
MIME-Version: 1.0
References: <20210225073309.4119708-1-yhs@fb.com> <20210225073320.4121679-1-yhs@fb.com>
In-Reply-To: <20210225073320.4121679-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Feb 2021 15:25:09 -0800
Message-ID: <CAEf4BzY6ih+UKzjhqyTe9JtgO2wSFjt=kOFC6r1r1hYXdBTNtQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 10/11] selftests/bpf: add hashmap test for
 bpf_for_each_map_elem() helper
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 25, 2021 at 1:35 AM Yonghong Song <yhs@fb.com> wrote:
>
> A test case is added for hashmap and percpu hashmap. The test
> also exercises nested bpf_for_each_map_elem() calls like
>     bpf_prog:
>       bpf_for_each_map_elem(func1)
>     func1:
>       bpf_for_each_map_elem(func2)
>     func2:
>
>   $ ./test_progs -n 45
>   #45/1 hash_map:OK
>   #45 for_each:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

I think I'll just add all the variants of ASSERT_XXX and will enforce
their use :)

For now:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  .../selftests/bpf/prog_tests/for_each.c       | 74 +++++++++++++++
>  .../bpf/progs/for_each_hash_map_elem.c        | 95 +++++++++++++++++++
>  2 files changed, 169 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/for_each.c
>  create mode 100644 tools/testing/selftests/bpf/progs/for_each_hash_map_elem.c
>

[...]

> +
> +       ASSERT_EQ(skel->bss->hashmap_output, 4, "hashmap_output");
> +       ASSERT_EQ(skel->bss->hashmap_elems, max_entries, "hashmap_elems");
> +
> +       key = 1;
> +       err = bpf_map_lookup_elem(hashmap_fd, &key, &val);
> +       ASSERT_ERR(err, "hashmap_lookup");
> +
> +       ASSERT_EQ(skel->bss->percpu_called, 1, "percpu_called");
> +       ASSERT_EQ(skel->bss->cpu < num_cpus, 1, "num_cpus");

well, this is cheating (it will print something like "0 != 1" on
error) :) why didn't you just add ASSERT_LT?

> +       ASSERT_EQ(skel->bss->percpu_map_elems, 1, "percpu_map_elems");
> +       ASSERT_EQ(skel->bss->percpu_key, 1, "percpu_key");
> +       ASSERT_EQ(skel->bss->percpu_val, skel->bss->cpu + 1, "percpu_val");
> +       ASSERT_EQ(skel->bss->percpu_output, 100, "percpu_output");
> +out:
> +       free(percpu_valbuf);
> +       for_each_hash_map_elem__destroy(skel);
> +}
> +
> +void test_for_each(void)
> +{
> +       if (test__start_subtest("hash_map"))
> +               test_hash_map();
> +}

[...]

> +int hashmap_output = 0;
> +int hashmap_elems = 0;
> +int percpu_map_elems = 0;
> +
> +SEC("classifier/")

nit: just "classifier" didn't work?

> +int test_pkt_access(struct __sk_buff *skb)
> +{
> +       struct callback_ctx data;
> +
> +       data.ctx = skb;
> +       data.input = 10;
> +       data.output = 0;
> +       hashmap_elems = bpf_for_each_map_elem(&hashmap, check_hash_elem, &data, 0);
> +       hashmap_output = data.output;
> +
> +       percpu_map_elems = bpf_for_each_map_elem(&percpu_map, check_percpu_elem,
> +                                                (void *)0, 0);
> +       return 0;
> +}
> --
> 2.24.1
>
