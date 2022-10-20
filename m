Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E25F60545A
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 02:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJTAFo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 20:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJTAFm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 20:05:42 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8A31217E1
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 17:05:38 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e15so15937090iof.2
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 17:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o8sI3cDV3OlVSuewZJ5vfcTrNNHXckGA/9W5F/7p9ec=;
        b=jWv4MMstNCa7lIxAISoL7aTa1gtAYT0Iq0j68knPSt3Khg1PjH/crb2gh42pE2xW9a
         f+pZejV02jqc8Ag2xeny7wvcamVv4eJ+mOCxbV9KGnbSZbVCvSdDYu80oHEfyWChjrvp
         ZxZyW8hyEEhhj7kHQbElZx1j7B2Vbm58sOZFSbKTHWENUmpQPr+O2G5+xuhOsrQNySnM
         zslpLcorsGT6bNS1xFkKfPpeiNZfkTpjlyzNn/4Cg9Y64xTWKgqFPb5oDKZUwy+gR40s
         1KG4MCqDlYbOgXRUy8moDjAn6a0EaCrR+YH89g/bYzUFZ5m0qfocjtbjDUsYlvNb88Ub
         GEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8sI3cDV3OlVSuewZJ5vfcTrNNHXckGA/9W5F/7p9ec=;
        b=yEDh681oE5ZHChgu0epF5QGkXxzj6CR9gJzKpaF+CpHivyulBCTr3DEIBH45g+A3XA
         zDi8f681OW+y2ILkWEIpY2NJFvqLEio2VVY8skiGVMG1ueD/QPW0NwqErQGz/M2UX+Sc
         Y3Sx8pAAlf1hNH4nOB262c0/aF6TQc3L3gBhXiBL1M2GpRPDpDGjlf4QzMKclhX8WFLX
         rH4s/hmTiCYrlpWMJsg8kLjkNQ/D5oBDCAv+6PfBWUDn2/VlQIE/rfhnUsBPEKdGFHsI
         aCDfMBMUfQbbgPltPn6xEZIygBsIXe178wZlMWILXSwL8uqicIBrGsq/mV2ktJx4i+ZE
         kubg==
X-Gm-Message-State: ACrzQf3Ej1tDCTmVBcg66vj5auAzd7OjQD7ft/3aKnNRIDT/czydpyEf
        MHTkROhEsYZ55oB0CT5zeWZN6EgE4vTXk6yfcxS9hA==
X-Google-Smtp-Source: AMsMyM6fV8v/YwUGv+f7ZNJyId52sin4U1L+/7fazMQA+XcANBDOOXe/dcuqkVLIh9wiO5jmnpPkuZNhDdl9Coz/aeg=
X-Received: by 2002:a05:6602:3145:b0:6b3:d28a:2f4d with SMTP id
 m5-20020a056602314500b006b3d28a2f4dmr7875664ioy.49.1666224337694; Wed, 19 Oct
 2022 17:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <f04cf27b05047cfb2c90db160383e2e9c2c40b93.camel@fb.com>
 <Y1BWvNdHHwHbPXDk@google.com> <CAADnVQLU3boKnMs4Su13pQ2P0w8qntoNZxRywT6_=LvAAVYtdA@mail.gmail.com>
In-Reply-To: <CAADnVQLU3boKnMs4Su13pQ2P0w8qntoNZxRywT6_=LvAAVYtdA@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 19 Oct 2022 17:05:26 -0700
Message-ID: <CAKH8qBs1MaQhwr8PxQoh2TcfDW_N2HGqABtp3vB+Udn-Fr0yeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix task_local_storage/exit_creds
 rcu usage
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Delyan Kratunov <delyank@meta.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Song Liu <songliubraving@meta.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 19, 2022 at 4:52 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Oct 19, 2022 at 12:57 PM <sdf@google.com> wrote:
> >
> > On 10/19, Delyan Kratunov wrote:
> > > BPF CI has revealed flakiness in the task_local_storage/exit_creds test.
> > > The failure point in CI [1] is that null_ptr_count is equal to 0,
> > > which indicates that the program hasn't run yet. This points to the
> > > kern_sync_rcu (sys_membarrier -> synchronize_rcu underneath) not
> > > waiting sufficiently.
> >
> > > Indeed, synchronize_rcu only waits for read-side sections that started
> > > before the call. If the program execution starts *during* the
> > > synchronize_rcu invocation (due to, say, preemption), the test won't
> > > wait long enough.
> >
> > > As a speculative fix, make the synchornize_rcu calls in a loop until
> > > an explicit run counter has gone up.
> >
> > >    [1]:
> > > https://github.com/kernel-patches/bpf/actions/runs/3268263235/jobs/5374940791
> >
> > > Signed-off-by: Delyan Kratunov <delyank@fb.com>
> > > ---
> > > v1 -> v2:
> > > Explicit loop counter and MAX_SYNC_RCU_CALLS guard.
> >
> > >   .../bpf/prog_tests/task_local_storage.c        | 18 +++++++++++++++---
> > >   .../bpf/progs/task_local_storage_exit_creds.c  |  3 +++
> > >   2 files changed, 18 insertions(+), 3 deletions(-)
> >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> > > b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> > > index 035c263aab1b..99a42a2b6e14 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> > > @@ -39,7 +39,8 @@ static void test_sys_enter_exit(void)
> > >   static void test_exit_creds(void)
> > >   {
> > >       struct task_local_storage_exit_creds *skel;
> > > -     int err;
> > > +     int err, run_count, sync_rcu_calls = 0;
> > > +     const int MAX_SYNC_RCU_CALLS = 1000;
> >
> > >       skel = task_local_storage_exit_creds__open_and_load();
> > >       if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> > > @@ -53,8 +54,19 @@ static void test_exit_creds(void)
> > >       if (CHECK_FAIL(system("ls > /dev/null")))
> > >               goto out;
> >
> > > -     /* sync rcu to make sure exit_creds() is called for "ls" */
> > > -     kern_sync_rcu();
> > > +     /* kern_sync_rcu is not enough on its own as the read section we want
> > > +      * to wait for may start after we enter synchronize_rcu, so our call
> > > +      * won't wait for the section to finish. Loop on the run counter
> > > +      * as well to ensure the program has run.
> > > +      */
> > > +     do {
> > > +             kern_sync_rcu();
> > > +             run_count = __atomic_load_n(&skel->bss->run_count, __ATOMIC_SEQ_CST);
> > > +     } while (run_count == 0 && ++sync_rcu_calls < MAX_SYNC_RCU_CALLS);
> >
> > Acked-by: Stanislav Fomichev <sdf@google.com>
> >
> > Might have been easier to do the following instead?
> >
> > int sync_rcu_calls = 1000;
> > do {
> > } while (run_count == 0 && --sync_rcu_calls);
>
>
> I think it's a preference of the author.
> Both are fine. imo.

Agreed, that's why I acked it, shouldn't really matter.

> I was about to apply, but then noticed Delyan's author line
> and SOB are different. @meta vs @fb :(
> Delyan, please fix.
>
> Fixing SOB is not something maintainers can do while applying.
