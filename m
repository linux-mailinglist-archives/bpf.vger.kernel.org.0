Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E14E575C9B
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 09:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiGOHpX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 03:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiGOHpS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 03:45:18 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EBD7CB5F
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 00:45:15 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r18so5223601edb.9
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 00:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s479rfn8r+iS45aYFt3XsNQEOWAyLV8nj0/Su6Velpc=;
        b=l/+Af98pi6WFH8cWpEHEaWbiDeC5GiS9JlOsvQVPfuDXu0aFoIV6WeMXtSFKQzaxNt
         cPok7fAMjgEmchV3M9/MBiEpdk4CQgvWE6ifYV8+RNXjGM2uPQiOTgO1ZhpysdjxVvF5
         JFoYt9B/uQR14sgJWW3WcYDiO6fAP9NH8uvHMXLXONK6PmHzjC8uw13C6t2Z5WPQ6hd9
         rlbv2U0k3gmXpPwu4M7h5wctFJVMN6wA6jnwTKzxyAH4fgdARoWtvY96+MjiehJCPQgI
         64pZ3A89egMx99lahN3ww/8L0jZOF6xsOZq9poGcSrgSEoFLK3t5ZOPKEYMuwx2YksHS
         92Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s479rfn8r+iS45aYFt3XsNQEOWAyLV8nj0/Su6Velpc=;
        b=XiH/sl+OPBV6WrlHrEp9Dl2wqQ/TscgLS1l1bbzqCt138Nozg56xCipgfo271GLE5p
         J/3KBTC9PW+2zeUQxGF33Hg61L0AqZOrz2AQzbNkwqTDhcvd6y/gOcRBa+XLqymy6+1g
         kzaPcVHgSaVn5QfEVdDkBpyLMLPGsiMCCMxuCOZXDEVHSRzXsVg9UXCWBZ7VOwNwFQFw
         XS/P2lx4BtnFbh3odmi1YtE45owJ8aC1JYuHw3uqk6eqVLC5u900EBHOMPnxuc1L4Jlg
         Yx4qGwCBWSDVHn2EPw230u/jCtxKwiGzlbRevhxXMWlZu3vfu1aurGE006k2vtfWgR6G
         p/SA==
X-Gm-Message-State: AJIora8mcXJH8fPOatmWB/s6GiTkftfL8jLzNXGRDywI9Vu64gHm/H9O
        WN4sKG853lLGt1dOSN8wcZQ=
X-Google-Smtp-Source: AGRyM1tkrQnv/WSh+9I6vI8SCMxxJUn53NXlPwS+Jfn9Ez7BWVEyctfKXJ9CmmI6yBsRehCi9Bjg8Q==
X-Received: by 2002:aa7:c0c7:0:b0:43a:79b9:5cd1 with SMTP id j7-20020aa7c0c7000000b0043a79b95cd1mr16698955edp.282.1657871114378;
        Fri, 15 Jul 2022 00:45:14 -0700 (PDT)
Received: from krava (net-37-179-156-241.cust.vodafonedsl.it. [37.179.156.241])
        by smtp.gmail.com with ESMTPSA id zb5-20020a17090687c500b006fec4ee28d0sm1680837ejb.189.2022.07.15.00.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 00:45:13 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 15 Jul 2022 09:45:10 +0200
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] selftests/bpf: Do not attach kprobe_multi bench to
 bpf_dispatcher_xdp_func
Message-ID: <YtEbBkwdwgZr5d7/@krava>
References: <20220714082316.479181-1-jolsa@kernel.org>
 <444b10eb-506a-583f-82f1-9c8ca4539542@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444b10eb-506a-583f-82f1-9c8ca4539542@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 14, 2022 at 01:01:30PM -0700, Yonghong Song wrote:
> 
> 
> On 7/14/22 1:23 AM, Jiri Olsa wrote:
> > Alexei reported crash by running test_progs -j on system
> > with 32 cpus.
> > 
> > It turned out the kprobe_multi bench test that attaches all
> > ftrace-able functions will race with bpf_dispatcher_update,
> > that calls bpf_arch_text_poke on bpf_dispatcher_xdp_func,
> > which is ftrace-able function.
> > 
> > Ftrace is not aware of this update so this will cause
> > ftrace_bug with:
> > 
> >    WARNING: CPU: 6 PID: 1985 at
> >    arch/x86/kernel/ftrace.c:94 ftrace_verify_code+0x27/0x50
> >    ...
> >    ftrace_replace_code+0xa3/0x170
> >    ftrace_modify_all_code+0xbd/0x150
> >    ftrace_startup_enable+0x3f/0x50
> >    ftrace_startup+0x98/0xf0
> >    register_ftrace_function+0x20/0x60
> >    register_fprobe_ips+0xbb/0xd0
> >    bpf_kprobe_multi_link_attach+0x179/0x430
> >    __sys_bpf+0x18a1/0x2440
> >    ...
> >    ------------[ ftrace bug ]------------
> >    ftrace failed to modify
> >    [<ffffffff818d9380>] bpf_dispatcher_xdp_func+0x0/0x10
> >     actual:   ffffffe9:7b:ffffff9c:77:1e
> >    Setting ftrace call site to call ftrace function
> > 
> > It looks like we need some way to way to hide some functions
> 
> need some way to hide some functions ...

ugh, right

> 
> > from ftrace, but meanwhile we workaround this by skipping
> > bpf_dispatcher_xdp_func from kprobe_multi bench test.
> > 
> > Reported-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> I tried with 32cpus on my local qemu/vm but cannot reproduce the crash.
> But look at the code, your should seem okay as bpf_dispatcher_xdp_func
> indeed could be poked and simplified. So with a few nits,
> 
> Acked-by: Yonghong Song <yhs@fb.com>
> 
> > ---
> >   tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > index 5b93d5d0bd93..8c442051f312 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > @@ -364,6 +364,8 @@ static int get_syms(char ***symsp, size_t *cntp)
> >   			continue;
> >   		if (!strncmp(name, "rcu_", 4))
> >   			continue;
> > +		if (!strncmp(name, "bpf_dispatcher_xdp_func", 23))
> 
> ffffffff81b17a90 T bpf_dispatcher_xdp_func
> 
> bpf_dispatcher_xdp_func is a full name, you can just use strcmp here.
> Further,
> 
> linux/bpf.h:#define BPF_DISPATCHER_FUNC(name) bpf_dispatcher_##name##_func
> 
> Currently, bpf_dispatcher_xdp_func is the ONLY BPF_DISPATCHER_FUNC.
> So comparing bpf_dispatcher_xdp_func is enough. It would be good
> to add a comment to explain why not comparing to bpf_dispatcher_*_func.

ok

thanks,
jirka
