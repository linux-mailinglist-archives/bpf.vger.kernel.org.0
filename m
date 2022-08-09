Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D208358E094
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 22:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345621AbiHIUEc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 16:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345723AbiHIUEb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 16:04:31 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D4D1403C
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 13:04:29 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id o2so10484296iof.8
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 13:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=fooLQJXN+rJ2DyZbLJrLfyJpExa+eNPxP6CAViEUZ/I=;
        b=M7NsL/PUpvlaG6JRyTrLT9vamd1KO/CWGOLTmqpX0UWGmZ76uKbLk9c7C/EuV/Rsm9
         h6QMjGmbrprGayP2hi/ofxttT7yuf0BptTRq54nrmk6J/CKPnJEGBkSd8mgvFaYuY1HY
         T341e0lAEhdyWYUREWcwwDs3vi976J/1nKbqLr6z6k5meMv9s94+dUDUyb1puu9QiF7T
         hYXRszTfk06BNz/lFBkAZny3B2IYA6cJ70gCEJu9TsWqD3KpgtwlDhn9FhU7fGIu8H2r
         uW8nbG3ydKZT+OLkbmQ6k7BgsyBlfTqMKh6hMSUlv/QfcD5SwnojkthqXIZxHXHH0tdJ
         Oz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=fooLQJXN+rJ2DyZbLJrLfyJpExa+eNPxP6CAViEUZ/I=;
        b=nulP4ERb1QHQ42ug0ed0V0Pkc16OCOm7TIsAe7pDwiXjMBMlfZpeZwzCTjGovtYk6h
         APh51nUEJb6A2X3cnuywx0gPhfAeD3pok9Pz8+e48cgfEY9Qb5eC+OnEoSv82sAvEbBL
         btsEUnRsK3HGz5x5AV1lUuPmTCjd91/5wGhTp8krbOsMlsFmm7dMbMGjDeZXR1sF7Dii
         TQ76n0Y65GjLKpH/ptwaI2ksRpXN9uMuwwna0Eajw2uaYoPSUq+CrdkEMqY0jwaIDtKk
         idmj7jKh7IPUQYVs0JCquu4Ebi5KtOMTF0Rpmy1IgzUsizCAtWH3rXAv1lwpAqO+hpJf
         wnoA==
X-Gm-Message-State: ACgBeo0vxTiPdRlIMXdyMjDPGeh5Mzpl2EH0VAxFA/yNI82AIubmz2s9
        f5CHJ5iVOoUM8yTlbbqwcUW7s8/tpa2yuwhcj8tqZHgO
X-Google-Smtp-Source: AA6agR4oMz9jWGS/umm5rFsGd1eqx52d1twUPlO/QElYKKPQyMDcv3dzuFJa2+P/uEUXImVA5UenO+iBx0ZVxoUDdMA=
X-Received: by 2002:a6b:c582:0:b0:67c:b3dc:54bd with SMTP id
 v124-20020a6bc582000000b0067cb3dc54bdmr9535793iof.62.1660075468486; Tue, 09
 Aug 2022 13:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220809140615.21231-1-memxor@gmail.com> <20220809140615.21231-4-memxor@gmail.com>
 <47cc7999-bfff-bd34-6c46-6ff5cd09f8e1@fb.com>
In-Reply-To: <47cc7999-bfff-bd34-6c46-6ff5cd09f8e1@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 9 Aug 2022 22:03:50 +0200
Message-ID: <CAP01T747iZdi4wRAi6PB7GY7JzxAY3vF84m0Ata2nF3rpY4EfQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 3/3] selftests/bpf: Add test for prealloc_lru_pop bug
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 9 Aug 2022 at 18:01, Yonghong Song <yhs@fb.com> wrote:
> On 8/9/22 7:06 AM, Kumar Kartikeya Dwivedi wrote:
> > Add a regression test to check against invalid check_and_init_map_value
> > call inside prealloc_lru_pop.
> >
> > To actually observe a kind of problem this can cause, set debug to 1
> > when running the test locally without the fix. Then, just observe the
> > refcount which keeps increasing on each run of the test. With timers or
> > spin locks, it would cause unpredictable results when racing.
> >
> > ...
> >
> > bash-5.1# ./test_progs -t lru_bug
> >        test_progs-192     [000] d..21   354.838821: bpf_trace_printk: ref: 4
> >        test_progs-192     [000] d..21   354.842824: bpf_trace_printk: ref: 5
> > bash-5.1# ./test_progs -t lru_bug
> >        test_progs-193     [000] d..21   356.722813: bpf_trace_printk: ref: 5
> >        test_progs-193     [000] d..21   356.727071: bpf_trace_printk: ref: 6
> >
> > ... and so on.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> Ack with a minor nit below.
>
> Acked-by: Yonghong Song <yhs@fb.com>
>
> > ---
> >   .../selftests/bpf/prog_tests/lru_bug.c        | 19 ++++++
> >   tools/testing/selftests/bpf/progs/lru_bug.c   | 67 +++++++++++++++++++
> >   2 files changed, 86 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/lru_bug.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/lru_bug.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/lru_bug.c b/tools/testing/selftests/bpf/prog_tests/lru_bug.c
> > new file mode 100644
> > index 000000000000..3bcb5bc62d5a
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/lru_bug.c
> > @@ -0,0 +1,19 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <test_progs.h>
> > +
> > +#include "lru_bug.skel.h"
> > +
> > +void serial_test_lru_bug(void)
> > +{
> > +     struct lru_bug *skel;
> > +     int ret;
> > +
> > +     skel = lru_bug__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "lru_bug__open_and_load"))
> > +             return;
> > +     ret = lru_bug__attach(skel);
> > +     if (!ASSERT_OK(ret, "lru_bug__attach"))
> > +             return;
>
> If not ASSERT_OK, should go to lru_bug__destroy(skel).
>
> > +     usleep(1);
> > +     ASSERT_OK(skel->data->result, "prealloc_lru_pop doesn't call check_and_init_map_value");
>
> Missing
>         lru_bug__destroy(skel);

Oops, thanks for catching, will fix.

> .
>
> > +}
> [...]
