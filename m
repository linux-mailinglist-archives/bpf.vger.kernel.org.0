Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5005FB034
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 12:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJKKKr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 06:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJKKKO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 06:10:14 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B91B233A6
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 03:09:57 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n16-20020a05600c4f9000b003c17bf8ddecso725667wmq.0
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 03:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m5R3vcrMfEIbZG5TaeZgZK3CV3LasEin3DYclgkZ6Jk=;
        b=TaTugqE/u2Q+XxVJ62/ra2IDlD1Yh1Y3MaqZ2hqkjw0GzADvZyh+qZOeQ4L0kOkZ0u
         wRZB7vEIAq4qv/JiOxjDs5P4/YWCWRdxmxLYqWqUBG0uu4msa/RhapK5jWj7yQf2tb7f
         1xb3Kkp1yGV9PYg5z5R8xUEkXchQkRHpaRnieFXl4VPuAXi6FDwLEkcvnqzTqrbVrbvz
         SPtkMAyBaewkwt7giK5p/zN7MwxcvPYLaiuBtJKBOMQhkMaDVDYzlWr4LZIXdxohA+1r
         f/u7PsGYs76Cw+Bs51gnV5+yLAtAetwiNY7Ug7U00X5aNAEx/eD8QfSXNHtjkXcEPB+q
         Y0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5R3vcrMfEIbZG5TaeZgZK3CV3LasEin3DYclgkZ6Jk=;
        b=tuJ0rrqjub+30E0zZe5Y+r3tbwC4QFjC7ijZCaPmD5nPB/P+wyVOLX+F861LDOhpgx
         lDUkqt3yHiLjuzBqrgMd1BJGvMpkE+R/cMQLJkfpBngP9ah4sMi7foZ7RLWllcry36fo
         AuWy5QfmqA4b+hlJL8Gums5cxqDNzjrBEpp+ijK/BWQ1kZoveLUul3jTpA4DLvMNumvV
         YXP1d4QgVPyKwjlVZ8lPSQAsmESKPH/8pj+ZU+40OOZ6DC45Kk/uMJSEY2h1lpEWrf4o
         STMJxgeIKPT9sYlXmReeyZhV+q5I3PtIcEqSyHGmr/7JGVINiUo2ERY6cmV4OGIHdRGH
         d3GQ==
X-Gm-Message-State: ACrzQf3gXLgD+h+Iy/Dhj1V8FsxyuufZcTFlNhtZ/v6hXvo8qX+MS3Ey
        A3EUqc5IXWF1rYLo1iAXYQI=
X-Google-Smtp-Source: AMsMyM59WI/cd+alLq1PLxY/F3os9HZiBizT5hYfYgWvydcpWBJFNnYsYSh7tfBt1ogI0thyWRUxZQ==
X-Received: by 2002:a05:600c:88a:b0:3c5:c9e3:15cc with SMTP id l10-20020a05600c088a00b003c5c9e315ccmr8508632wmp.67.1665482995487;
        Tue, 11 Oct 2022 03:09:55 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id k24-20020a05600c1c9800b003c6c182bef9sm3044175wms.36.2022.10.11.03.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 03:09:55 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 11 Oct 2022 12:09:53 +0200
To:     Song Liu <song@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
Subject: Re: [PATCH bpf-next 7/8] selftests/bpf: Add kprobe_multi kmod link
 api tests
Message-ID: <Y0VA8epnsoQFJTod@krava>
References: <20221009215926.970164-1-jolsa@kernel.org>
 <20221009215926.970164-8-jolsa@kernel.org>
 <CAPhsuW6r+=nzTozfzQzk+2qKr_3rmiY55TPDfnUgOZriWWWaYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW6r+=nzTozfzQzk+2qKr_3rmiY55TPDfnUgOZriWWWaYg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 11, 2022 at 12:27:12AM -0700, Song Liu wrote:
> On Sun, Oct 9, 2022 at 3:01 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding kprobe_multi kmod link api tests that attach bpf_testmod
> > functions via kprobe_multi link API.
> >
> > Running it as serial test, because we don't want other tests to
> > reload bpf_testmod while it's running.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../prog_tests/kprobe_multi_testmod_test.c    | 94 +++++++++++++++++++
> >  .../selftests/bpf/progs/kprobe_multi.c        | 51 ++++++++++
> >  2 files changed, 145 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
> > new file mode 100644
> > index 000000000000..5fe02572650a
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_testmod_test.c
> > @@ -0,0 +1,94 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <test_progs.h>
> > +#include "kprobe_multi.skel.h"
> > +#include "trace_helpers.h"
> > +#include "bpf/libbpf_internal.h"
> > +
> > +static void kprobe_multi_testmod_check(struct kprobe_multi *skel)
> > +{
> > +       ASSERT_EQ(skel->bss->kprobe_testmod_test1_result, 1, "kprobe_test1_result");
> > +       ASSERT_EQ(skel->bss->kprobe_testmod_test2_result, 1, "kprobe_test2_result");
> > +       ASSERT_EQ(skel->bss->kprobe_testmod_test3_result, 1, "kprobe_test3_result");
> > +
> > +       ASSERT_EQ(skel->bss->kretprobe_testmod_test1_result, 1, "kretprobe_test1_result");
> > +       ASSERT_EQ(skel->bss->kretprobe_testmod_test2_result, 1, "kretprobe_test2_result");
> > +       ASSERT_EQ(skel->bss->kretprobe_testmod_test3_result, 1, "kretprobe_test3_result");
> > +}
> > +
> > +static void test_testmod_link_api(struct bpf_link_create_opts *opts)
> > +{
> > +       int prog_fd, link1_fd = -1, link2_fd = -1;
> > +       struct kprobe_multi *skel = NULL;
> > +
> > +       skel = kprobe_multi__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "fentry_raw_skel_load"))
> > +               goto cleanup;
> 
> nit: we can just return here.

right, will change

thanks,
jirka

> 
> Other than this:
> 
> Acked-by: Song Liu <song@kernel.org>
> 
> > +
> > +       skel->bss->pid = getpid();
> > +       prog_fd = bpf_program__fd(skel->progs.test_kprobe_testmod);
> > +       link1_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_KPROBE_MULTI, opts);
> > +       if (!ASSERT_GE(link1_fd, 0, "link_fd1"))
> > +               goto cleanup;
> > +
> > +       opts->kprobe_multi.flags = BPF_F_KPROBE_MULTI_RETURN;
> > +       prog_fd = bpf_program__fd(skel->progs.test_kretprobe_testmod);
> > +       link2_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_KPROBE_MULTI, opts);
> > +       if (!ASSERT_GE(link2_fd, 0, "link_fd2"))
> > +               goto cleanup;
> > +
> > +       ASSERT_OK(trigger_module_test_read(1), "trigger_read");
> > +       kprobe_multi_testmod_check(skel);
> > +
> > +cleanup:
> > +       if (link1_fd != -1)
> > +               close(link1_fd);
> > +       if (link2_fd != -1)
> > +               close(link2_fd);
> > +       kprobe_multi__destroy(skel);
> > +}
> >
