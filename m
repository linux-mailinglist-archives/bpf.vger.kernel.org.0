Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671A3605438
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 01:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJSXwS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 19:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJSXwR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 19:52:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F336170DF2
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 16:52:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a26so43226397ejc.4
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 16:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y62nwkjGCOSwJ7irxK9JjeD1/H61vfdL1LmJBbnTCWY=;
        b=TMYY6PeQsG98o7LUCJdjnjxj27rKMjF4r9dMxfO7W4Fe/Os4qedWr5Yl7+Lr6dCaQg
         JxwKPx6p6b018sNwr3nTkPTbwHzKzxv0GJ7fAYWiFPVDalaobVhoNGWoT66Ud9lgpSts
         g81/jA7CIZDtoc5QS7DlQxh+Mem0/ITVM0u2PTnGzsemz4ehiyWU9nDn+wy5RYgugH4X
         XVkFdKYt+LNU2haD7DhOtgofoyA7uezL1IKW86azYAb6Cn3gP0YvYKS++Z/JPMIfNZO8
         84Y9dw0QrejHiHnx9i7jdYl6a9GHcQmATd0u27hGPmF2q8r5kdodxCGfffBJxM1T5s7F
         Ymrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y62nwkjGCOSwJ7irxK9JjeD1/H61vfdL1LmJBbnTCWY=;
        b=uB3wuvW8zv2IJNToh3mjYB9LgiwQKuWAPpma0iBbGML8OAglaA9j742Fd63btQFwbZ
         I0AajJxV3IkCEjShN7r11Hh5l7mn5KLC5nYbSGYnw9hZxFu0WRn5tJhA5fzXhLttWm8T
         MO0hLIqntqlO9hhuezGG+9EGd3VLfGIQJsKAHxPzIyT6oZMzEAuIa6IXX74BrdV+1BoA
         ML6epP2L6loY9eLanAhg/XgjK7oR6r83SEtQaIiE+e/kd5rfesQ1qzvYbPTSyhNW53gZ
         M8oN/JZClIqQ5THDAzdqkGuUvbxRmQ15RL2eWrpKNK2eDQSX5gQzMIyZICTAC0ef8XGI
         0Ztg==
X-Gm-Message-State: ACrzQf3cfYxDtnhmyW/ybYYRHixgqOT2p5tptsFVb1xNLmdvyZBmOScQ
        bgNXSplQuz9JnWNfkW2skTHnb41S9mgyWID2Bzg=
X-Google-Smtp-Source: AMsMyM6D47pAYKi+3ubxiEDc0VtArVgWkMbz4SYN8+LpB58t076yZqaKm5KWaY1J0lauy9OMladiIwvOpfAPYweSicE=
X-Received: by 2002:a17:907:6e93:b0:78d:dff1:71e3 with SMTP id
 sh19-20020a1709076e9300b0078ddff171e3mr8344199ejc.94.1666223535383; Wed, 19
 Oct 2022 16:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <f04cf27b05047cfb2c90db160383e2e9c2c40b93.camel@fb.com> <Y1BWvNdHHwHbPXDk@google.com>
In-Reply-To: <Y1BWvNdHHwHbPXDk@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 19 Oct 2022 16:52:04 -0700
Message-ID: <CAADnVQLU3boKnMs4Su13pQ2P0w8qntoNZxRywT6_=LvAAVYtdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix task_local_storage/exit_creds
 rcu usage
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Delyan Kratunov <delyank@meta.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Song Liu <songliubraving@meta.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 19, 2022 at 12:57 PM <sdf@google.com> wrote:
>
> On 10/19, Delyan Kratunov wrote:
> > BPF CI has revealed flakiness in the task_local_storage/exit_creds test.
> > The failure point in CI [1] is that null_ptr_count is equal to 0,
> > which indicates that the program hasn't run yet. This points to the
> > kern_sync_rcu (sys_membarrier -> synchronize_rcu underneath) not
> > waiting sufficiently.
>
> > Indeed, synchronize_rcu only waits for read-side sections that started
> > before the call. If the program execution starts *during* the
> > synchronize_rcu invocation (due to, say, preemption), the test won't
> > wait long enough.
>
> > As a speculative fix, make the synchornize_rcu calls in a loop until
> > an explicit run counter has gone up.
>
> >    [1]:
> > https://github.com/kernel-patches/bpf/actions/runs/3268263235/jobs/5374940791
>
> > Signed-off-by: Delyan Kratunov <delyank@fb.com>
> > ---
> > v1 -> v2:
> > Explicit loop counter and MAX_SYNC_RCU_CALLS guard.
>
> >   .../bpf/prog_tests/task_local_storage.c        | 18 +++++++++++++++---
> >   .../bpf/progs/task_local_storage_exit_creds.c  |  3 +++
> >   2 files changed, 18 insertions(+), 3 deletions(-)
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> > b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> > index 035c263aab1b..99a42a2b6e14 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> > @@ -39,7 +39,8 @@ static void test_sys_enter_exit(void)
> >   static void test_exit_creds(void)
> >   {
> >       struct task_local_storage_exit_creds *skel;
> > -     int err;
> > +     int err, run_count, sync_rcu_calls = 0;
> > +     const int MAX_SYNC_RCU_CALLS = 1000;
>
> >       skel = task_local_storage_exit_creds__open_and_load();
> >       if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> > @@ -53,8 +54,19 @@ static void test_exit_creds(void)
> >       if (CHECK_FAIL(system("ls > /dev/null")))
> >               goto out;
>
> > -     /* sync rcu to make sure exit_creds() is called for "ls" */
> > -     kern_sync_rcu();
> > +     /* kern_sync_rcu is not enough on its own as the read section we want
> > +      * to wait for may start after we enter synchronize_rcu, so our call
> > +      * won't wait for the section to finish. Loop on the run counter
> > +      * as well to ensure the program has run.
> > +      */
> > +     do {
> > +             kern_sync_rcu();
> > +             run_count = __atomic_load_n(&skel->bss->run_count, __ATOMIC_SEQ_CST);
> > +     } while (run_count == 0 && ++sync_rcu_calls < MAX_SYNC_RCU_CALLS);
>
> Acked-by: Stanislav Fomichev <sdf@google.com>
>
> Might have been easier to do the following instead?
>
> int sync_rcu_calls = 1000;
> do {
> } while (run_count == 0 && --sync_rcu_calls);


I think it's a preference of the author.
Both are fine. imo.

I was about to apply, but then noticed Delyan's author line
and SOB are different. @meta vs @fb :(
Delyan, please fix.

Fixing SOB is not something maintainers can do while applying.
