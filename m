Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A345A6AD681
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 05:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjCGEoo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 23:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjCGEof (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 23:44:35 -0500
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5372FCF8;
        Mon,  6 Mar 2023 20:44:07 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5384ff97993so225053077b3.2;
        Mon, 06 Mar 2023 20:44:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678164222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3AJYKJmsuBeQzEHwMVXmiapyZ13/OI8jrm9b5FPop4=;
        b=eDiBUhWOx1y0oASVjUXAi/BJPjfJckPjiza+oPz61GHn9hAW/otBoYAiOGASOZvd6r
         eObxv4eS3ocSf+k0SgGdIfRqZDYLb8KBQNx9V2tpGgi3IW5Z0IXoLNFCRFOJ7x8eGnvT
         JxJrlutMdNBWLNngfdtvsWVc2nrNpivzfQYZQOxqqVKlSIGmkVX+79HsrJoaPRLwc/Yj
         n0/uFcdKAqMd7GAOlnplIBeThQZegXT24GnuySV+szYCBPQW7riwodQ4RF1i7P9M/tgD
         3vuZDT+TgB64lsuu407brCbY8SmABK9B3RQ4tNlQql1VL7oB9VhDD5vyxwvGozjqWbZh
         nqbg==
X-Gm-Message-State: AO0yUKUBYcfvDmf/2KkijeslPI52f9tzF056Iq1uqa2Lz9XcMwRTZbDr
        27P+meZABriyiIDgaU1QZhas7SZBTJXmE0T4IWhJxOYqfVI=
X-Google-Smtp-Source: AK7set/UB9njf4BtCwbMNKJGKl7au48PIvWnWyweDDrTje3FyPZKq/vzFM5IbBHcoDOEBwZVB1Im3Gm2vVNShHq1G9Y=
X-Received: by 2002:a81:b71c:0:b0:536:7529:55b4 with SMTP id
 v28-20020a81b71c000000b00536752955b4mr8352513ywh.3.1678164222242; Mon, 06 Mar
 2023 20:43:42 -0800 (PST)
MIME-Version: 1.0
References: <20230307032117.3461008-1-irogers@google.com>
In-Reply-To: <20230307032117.3461008-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 6 Mar 2023 20:43:30 -0800
Message-ID: <CAM9d7ci6FWx2oYAbqhVW2-tjB4p8ji3w87n-ndwxidMov+kVZw@mail.gmail.com>
Subject: Re: [PATCH] perf lock contention: Fix builtin detection
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Ian,

On Mon, Mar 6, 2023 at 7:21 PM Ian Rogers <irogers@google.com> wrote:
>
> __has_builtin was passed the macro rather than the actual builtin
> feature.

Oh, I missed it's a macro define in tools/lib/bpf/bpf_core_read.h file.

Looking at some BPF test codes, it seems you also need to check the
clang compiler version.  Please take a look at the file below:

  tools/testing/selftests/bpf/progs/test_core_reloc_type_base.c

Thanks,
Namhyung

>
> Fixes: 1bece1351c65 ("perf lock contention: Support old rw_semaphore type")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/bpf_skel/lock_contention.bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index e6007eaeda1a..e422eee0f942 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -182,7 +182,7 @@ static inline struct task_struct *get_lock_owner(__u64 lock, __u32 flags)
>                 struct mutex *mutex = (void *)lock;
>                 owner = BPF_CORE_READ(mutex, owner.counter);
>         } else if (flags == LCB_F_READ || flags == LCB_F_WRITE) {
> -#if __has_builtin(bpf_core_type_matches)
> +#if __has_builtin(__builtin_preserve_type_info)
>                 if (bpf_core_type_matches(struct rw_semaphore___old)) {
>                         struct rw_semaphore___old *rwsem = (void *)lock;
>                         owner = (unsigned long)BPF_CORE_READ(rwsem, owner);
> --
> 2.40.0.rc0.216.gc4246ad0f0-goog
>
