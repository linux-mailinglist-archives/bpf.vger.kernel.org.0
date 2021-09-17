Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C3540FF90
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 20:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242784AbhIQSof (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 14:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242570AbhIQSof (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 14:44:35 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55C5C061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 11:43:12 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c7so14923328qka.2
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 11:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O5x+4ZLg/xs/sF2VnsN+YZeLH0J4cyFhtbyrMfMRKDk=;
        b=Jc+ovy3XrKtsSaIj5o2aPr6d4Zt2hWo3vo4bJZ7Ghg91OH6ZMSCIPn7UtQ9vWVKo1g
         9rdBvs9b1yqfDPaOccv2ZjWwj+DOMNrxoQwkAhYE9ceYVZfBzt03dhM7W3GPFlpdo5lq
         F9sM5ALNCN6c2Xl4l9iV9PAKDX2jL5dgP/zzR97RI5HQeL9lEyqCi6jw3ZqhFSqGuZ1y
         eYq24lfkKYgH9gm3ilLSgW+HABjUCp39ps45/+bX3yZq3sTgcY5MgTV5yuF6gTqlVS9h
         6uHRVHL3+qQLKpSdDGVLpiHh/Rq4Uemz690PtPVf9xwsm3VUSCssDW76GfuKT2LNYbhC
         MkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O5x+4ZLg/xs/sF2VnsN+YZeLH0J4cyFhtbyrMfMRKDk=;
        b=KxIBjtwN6Z/xiICqstdiDV9ku812TKq2mty65v4MDj80dkihw1RxUp3U7MydjMxM89
         Yexjh5BoWgZsYc48acWqzpPjdNMgnnv+mH+HA3sP412aE0U5LKyY1TuYjfIFkc3KWwwW
         0nFcy+bEyCRfGWCoDSKWCvu0RnM0NlK6/G9BDqvsOuTvLV9D418UfyntcyapK0JTazGJ
         k9KWTW6zehWQkXOcuqRbI4Y2w0vGtqO963E6FOalfu4/OeWkBlY5cSmj7EKQsJsTewHc
         OEQqoJynK7gL4z7zOxhkdFF+AQnrXQJ/eANYWK6RIb56XBOm5xHuEE5BhYL8SaUgq4TG
         DCrw==
X-Gm-Message-State: AOAM530nGXEsud/tUmYQBE8RIgz9kUZ/Lba97icw8A6PHCx7arDiA+Gu
        kDo97RkRu2uOWeNfLP699QUEvaI9q4FtFMerk8U=
X-Google-Smtp-Source: ABdhPJx1nPgw6S4Blh5HnDPfYfEL7XNh6dKSLrAGBIeDtRh4Yt1E/dHrR65hnHO43Zl3tTVe4K454U12h08rgMN+JhI=
X-Received: by 2002:a25:bbc4:: with SMTP id c4mr16170712ybk.114.1631904191767;
 Fri, 17 Sep 2021 11:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210916032641.1413293-1-fallentree@fb.com> <20210916032641.1413293-2-fallentree@fb.com>
In-Reply-To: <20210916032641.1413293-2-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Sep 2021 11:43:00 -0700
Message-ID: <CAEf4Bzaxj-UmE3CB_0EPSJsczqfCh8xtT=5whGUMOY_vGCGe-A@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/3] selftests/bpf: Add parallelism to test_progs
To:     Yucong Sun <fallentree@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 15, 2021 at 8:26 PM Yucong Sun <fallentree@fb.com> wrote:
>
> From: Yucong Sun <sunyucong@gmail.com>
>
> This patch adds "-j" mode to test_progs, executing tests in multiple process.
> "-j" mode is optional, and works with all existing test selection mechanism, as
> well as "-v", "-l" etc.
>
> In "-j" mode, main process use UDS to communicate to each forked worker,
> commanding it to run tests and collect logs. After all tests are
> finished, a summary is printed. main process use multiple competing
> threads to dispatch work to worker, trying to keep them all busy.
>
> The test status will be printed as soon as it is finished, if there are error
> logs, it will be printed after the final summary line.
>
> By specifying "--debug", additional debug information on server/worker
> communication will be printed.
>
> Example output:
>   > ./test_progs -n 15-20 -j
>   [   12.801730] bpf_testmod: loading out-of-tree module taints kernel.
>   Launching 8 workers.
>   #20 btf_split:OK
>   #16 btf_endian:OK
>   #18 btf_module:OK
>   #17 btf_map_in_map:OK
>   #19 btf_skc_cls_ingress:OK
>   #15 btf_dump:OK
>   Summary: 6/20 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> ---

A bit late to review this, sorry. I'm still looking through the code,
but decided to try it out locally first. And here's what I got
immediately running in QEMU:

[vmuser@archvm bpf]$ time sudo ./test_progs -t core
#32 core_autosize:OK
#33 core_extern:OK
#34 core_read_macros:OK
#35 core_reloc:OK
#36 core_retro:OK
Summary: 5/107 PASSED, 0 SKIPPED, 0 FAILED

real    0m0.927s
user    0m0.197s
sys     0m0.103s
[vmuser@archvm bpf]$ time sudo ./test_progs -t core -j
Launching 8 workers.
#34 core_read_macros:OK
#32 core_autosize:OK
#36 core_retro:OK
#33 core_extern:OK
#35 core_reloc:OK
Summary: 5/107 PASSED, 0 SKIPPED, 0 FAILED

real    0m20.048s
user    0m0.194s
sys     0m0.183s


So, first, "Launching 8 workers." should be only displayed with --debug, no?

But most importantly, why does the parallel version take 20 seconds?..
Please take a look, something is not right.

>  tools/testing/selftests/bpf/test_progs.c | 577 +++++++++++++++++++++--
>  tools/testing/selftests/bpf/test_progs.h |  36 +-
>  2 files changed, 581 insertions(+), 32 deletions(-)
>

[...]
