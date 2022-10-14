Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129EA5FEC8B
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 12:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiJNKZ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 06:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJNKZ5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 06:25:57 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1C6163387
        for <bpf@vger.kernel.org>; Fri, 14 Oct 2022 03:25:56 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n9so2806543wms.1
        for <bpf@vger.kernel.org>; Fri, 14 Oct 2022 03:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SoTyaVdN4YDPw4VNM1RKmwvTFdrbAkNM7P03WetLK0o=;
        b=BMUaclSO+B7NsxV9qgqy51H/IVlzBUtsd2IG/9tXmU63tA14UqmIqUbYPrA59fMywZ
         0E7h2tpChqBA/tGLTJouWM/3eJYo9giNpEUpsXJkMBhHDFZH6sXOkHOFQZiRQpOLrY43
         ROQ+5XGn1+jaIoblg7rS4pnvOSi6JiKIycB1PK4/HXMctKiksk0Dno+kpPuOMlNe/oh2
         oazvQeeFqD/Ynu7M5HhxbAIDPlf9RI9U29XAn6pkWIhnlrRztU4pDTrRKHuTH4u3u7Of
         /PazdyCidSVkhMFVtl0IHJY8jSGnflewfLjwLhLrknSjSLdhEs05h+U/vaizNuaDfrRO
         uKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoTyaVdN4YDPw4VNM1RKmwvTFdrbAkNM7P03WetLK0o=;
        b=CEytc6ePajcTE80vSBqr1PMLhAISXxjOoc8p0gMsiRD9hjvvlaDqJ3hthVWWPy45Uu
         RUJFW0QBg5jLqmSIC7r++qX/gsu1P/YqIXg1pNSGRFHZsh1RdRXfbGlgDM+p+TCUA3PJ
         /YnqoMD++b8kJp4f7TzcHFP6qOeTXqWb/rRPd4L0RyHbZsSQ1OgdkX2YM5xaYbRNTJ+f
         0UF98kEEg2LoXSyI3BxCbLHzLxZ5s7ScfMxajGHY8bd0wqn+DQoIeMU7yxBdQdImerOR
         GGEdqid+al/Ugce4UjfOPdeCQ+gUlFvbyuotSsHMOjETC8y8g2j3Tzp1NxhCfhavRz7A
         Jjgg==
X-Gm-Message-State: ACrzQf0SDgHzntfP5dMtOHl4XejoMdU5jMysABwMrblNNdOyGWkHjWRA
        I2S4FL7a95RjHCQEBO1IvuM=
X-Google-Smtp-Source: AMsMyM6359UTIsBg+jHOtGvysinf7lg5HrwaP06W3+dRhhn6Uwf3GZIX0PTNXNG0m20jD5IlIOGQTQ==
X-Received: by 2002:a05:600c:4194:b0:3c3:d0ed:2d44 with SMTP id p20-20020a05600c419400b003c3d0ed2d44mr10014211wmh.151.1665743154448;
        Fri, 14 Oct 2022 03:25:54 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d6105000000b0022afbd02c69sm1595237wrt.56.2022.10.14.03.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 03:25:54 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 14 Oct 2022 12:25:52 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
Message-ID: <Y0k5MM5cOjqYgXZR@krava>
References: <20221009215926.970164-1-jolsa@kernel.org>
 <20221009215926.970164-8-jolsa@kernel.org>
 <CAEf4BzbX5G3LXNJAdRA0kkO=7V1pheN6fUHAHUcPjdpbFQSEuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbX5G3LXNJAdRA0kkO=7V1pheN6fUHAHUcPjdpbFQSEuA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 13, 2022 at 12:06:06PM -0700, Andrii Nakryiko wrote:

SNIP

> > +static void test_testmod_link_api(struct bpf_link_create_opts *opts)
> > +{
> > +       int prog_fd, link1_fd = -1, link2_fd = -1;
> > +       struct kprobe_multi *skel = NULL;
> > +
> > +       skel = kprobe_multi__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "fentry_raw_skel_load"))
> > +               goto cleanup;
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
> 
> any reason to not use bpf_program__attach_kprobe_multi_ops() and
> instead use low-level bpf_link_create?
> 
> > +       ASSERT_OK(trigger_module_test_read(1), "trigger_read");
> > +       kprobe_multi_testmod_check(skel);
> > +
> > +cleanup:
> > +       if (link1_fd != -1)
> > +               close(link1_fd);
> > +       if (link2_fd != -1)
> > +               close(link2_fd);
> 
> you don't need to even do this if you stick to high-level attach APIs

ok, I guess we can use bpf_program__attach_kprobe_multi_opts here

> 
> > +       kprobe_multi__destroy(skel);
> > +}
> > +
> > +#define GET_ADDR(__sym, __addr) ({                                     \
> > +       __addr = ksym_get_addr(__sym);                                  \
> > +       if (!ASSERT_NEQ(__addr, 0, "kallsyms load failed for " #__sym)) \
> > +               return;                                                 \
> > +})
> 
> macro for this? why? just make understanding the code and debugging
> it, if necessary, harder. You don't even need that return, just lookup
> and ASSERT_NEQ(). Go to symbol #2 and do the same. If something goes
> wrong you'll have three failed ASSERT_NEQs, which is totally fine.

sure

SNIP

> > diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi.c b/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > index 98c3399e15c0..b3c54ec13a45 100644
> > --- a/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > +++ b/tools/testing/selftests/bpf/progs/kprobe_multi.c
> > @@ -110,3 +110,54 @@ int test_kretprobe_manual(struct pt_regs *ctx)
> >         kprobe_multi_check(ctx, true);
> >         return 0;
> >  }
> > +
> > +extern const void bpf_testmod_fentry_test1 __ksym;
> > +extern const void bpf_testmod_fentry_test2 __ksym;
> > +extern const void bpf_testmod_fentry_test3 __ksym;
> > +
> > +__u64 kprobe_testmod_test1_result = 0;
> > +__u64 kprobe_testmod_test2_result = 0;
> > +__u64 kprobe_testmod_test3_result = 0;
> > +
> > +__u64 kretprobe_testmod_test1_result = 0;
> > +__u64 kretprobe_testmod_test2_result = 0;
> > +__u64 kretprobe_testmod_test3_result = 0;
> > +
> > +static void kprobe_multi_testmod_check(void *ctx, bool is_return)
> > +{
> > +       if (bpf_get_current_pid_tgid() >> 32 != pid)
> > +               return;
> > +
> > +       __u64 addr = bpf_get_func_ip(ctx);
> > +
> > +#define SET(__var, __addr) ({                          \
> > +       if ((const void *) addr == __addr)              \
> > +               __var = 1;                              \
> > +})
> > +
> 
> same feedback, why macro for this? There is nothing repetitive done in it at all

ok, will change

thanks,
jirka
