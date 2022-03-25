Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABD34E7E02
	for <lists+bpf@lfdr.de>; Sat, 26 Mar 2022 01:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbiCYW5A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 18:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbiCYW47 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 18:56:59 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F785FFA
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 15:55:24 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id x4so10583621iop.7
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 15:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=508f9B1RyTLA+vU3WBDgzQhkOpmJdao0cbRNLEd1fKw=;
        b=OnY/WMds29JMwzeQzoguPmvY2VyylRQjF1DLBqz5QyIqepY8OIRLm69MkAzXVUp6CD
         J7Y77GxUf6wQK9sONzXWYXj0xWYw9W7d8n6imQXV+ozACwrfLI5jdCfdN2gzNnDu/7ak
         yEewz46/EqQiVdVjVTqpOu7Reex4FDZEL2SAqgg45zexwE/84kR8BRyYsMPelsCjRqHW
         tb2LlXmSEJbv686oEH7Iuox97R/wuiVpOHczfByoZURVV5TyTFA8VoKrhX5nVgjgMCua
         KnpnO1Qr3F503u5keCulcnrxq8VRX16xL7Wgrbkrf5YWg2fgQoezt0/YTXetKFz8Nra4
         Oo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=508f9B1RyTLA+vU3WBDgzQhkOpmJdao0cbRNLEd1fKw=;
        b=zEw3e0bBuo5qeXgNqi3Ew8w5JWGFfsHobcoeg3MZLYdzCLTQ6aR0ZBR1Hz9kJFupFh
         RxjyJ27VVh/R0psTFM/2eD2Ql0LWq9UkmsdInMRhMW7iLuD8lVl7IBeoerviJ6sEPv3e
         T2mUDwpuiQLzKYoYETiznmDLRjlGZbRB5Mm7UAynWIsgB8EHFbsNBFpNHIBFncF8yv6A
         YrmG1SmU6s6zZhU8/TBsB1ELWu20O4cA4rf7BAw9gcJPhIGHnk7/pig423VW0kbfRA0o
         0H6cbeVK6NJUzvhSO0BbQD4EH+XjpwL4UTnknSONGkKBppCaQKTFyD+D8oiyWN5FKzbS
         89Uw==
X-Gm-Message-State: AOAM530ekmNr2VN/53QsOvIW0fX8KrSgf6MPsANtb56nXqRtMnGXrFSv
        AvqqApPvYIJbQXjbP26sFSgELAHKBIF3+3blKn09e4Go
X-Google-Smtp-Source: ABdhPJwzFJf1nK6x8AbbHNv8W7VJ/EP8HbltxZr4nVYBfWn7I2RbMz6CJU0eH56o23UtXqW1B/vM9IQkji+780HZG9w=
X-Received: by 2002:a02:c00e:0:b0:317:c548:97c with SMTP id
 y14-20020a02c00e000000b00317c548097cmr7390211jai.234.1648248923681; Fri, 25
 Mar 2022 15:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220325222314.3838278-1-andrii@kernel.org> <5b9269d7-b5bc-ecd6-093e-a9e8e770b95b@fb.com>
In-Reply-To: <5b9269d7-b5bc-ecd6-093e-a9e8e770b95b@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 25 Mar 2022 15:55:12 -0700
Message-ID: <CAEf4BzY1Xe7rOSgVBh7cC8ESYNMqm5Fn33EqO=aiTpooGsH0zQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix selftest after
 random:urandom_read tracepoint removal
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Fri, Mar 25, 2022 at 3:44 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 3/25/22 3:23 PM, Andrii Nakryiko wrote:
> > 14c174633f34 ("random: remove unused tracepoints") removed all the
> > tracepoints from drivers/char/random.c, one of which,
> > random:urandom_read, was used by stacktrace_build_id selftest to trigger
> > stack trace capture from two different kernel code paths.
> >
> > Fix breakage by switching to kprobing chacha_block_generic() function which
> > is also called in both code paths that selftest uses for triggering.
> >
> > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >   tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c b/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c
> > index 36a707e7c7a7..698fef6d90bc 100644
> > --- a/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c
> > +++ b/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c
> > @@ -47,7 +47,7 @@ struct random_urandom_args {
> >       int input_left;
> >   };
> >
> > -SEC("tracepoint/random/urandom_read")
> > +SEC("kprobe/chacha_block_generic")
>
> I tried this and it doesn't work in my environment. But changing to
>     SEC("kprobe/urandom_read")
> works.
>

I noticed flakiness locally as well. Switching to kprobe/urandom_read
seems to work well, thanks!

> Also, if using kprobe, maybe rename 'struct random_urandom_args'
> to 'struct pt_regs'? Also, the struct random_urandom_args definition
> can be removed.
>

yep, missed the need to clean this up. I'll send v2 shortly.



>
> >   int oncpu(struct random_urandom_args *args)
> >   {
> >       __u32 max_len = sizeof(struct bpf_stack_build_id)
