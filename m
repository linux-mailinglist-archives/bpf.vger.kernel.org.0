Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873BB57E773
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 21:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbiGVTdz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 15:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbiGVTdv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 15:33:51 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DEB75381
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 12:33:50 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id r24so4241774qtx.6
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 12:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w2mZyTvCDRGacenwXwV+XwjnRIrADo4IoYd9o0vwAec=;
        b=gcbTAaq45Y9pDLMnODP8DQTXfIAHsbxczq3If0mxzjUu2YkiioVw1PZzuOgjYWsusI
         qe2Nqm7WW92nmIosGGcbNncPpopRsRiSuCdft+TVnrIfOZt/Ux8zvmpj4Hp6jnHLSJ3y
         7KNHxKq7fEOQXEAivWQWb5qm5NusgWmNxKmzRgM1cuj6T8l8uMb5T8gBVCsZ3Y1+yCC4
         7oLfMdVRCpWg/uYbQZ3DhVLcdNsAzdn0OBx/sC8tLU0U38I59oOWj+UFga7KE2iRFggE
         A4ZOQ6oRMH4LLq4sAWsU0b623mnxc4GRr2ZuFazshiH6tkYxsVzzD1piUyx0prDEci91
         Dr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w2mZyTvCDRGacenwXwV+XwjnRIrADo4IoYd9o0vwAec=;
        b=Vw9bcSbRe3ukfRf5keJBJTqjJXtGM/jRXOCXsPv2G4uA5Hbszdrq5U2wRQguE/+Sdo
         6dX/KxJ2Y2tDTRklKcJTWlms5Jdb96QoU9ZUcQEvK3lMW9JVXLlryuuezWPFbfvmR6R5
         Ot98ZJSe6An6SLlswfwmwb9W7c5zB/5wMboFEYpLwciTi+gRU3au8Udx1PRVMbGWG5Fp
         K1ci4tltzjKIoakdIPZTWcVURm5ic6K2UGe4ARDFo94duljVRtkQc+XNl5PcGIrbBJz5
         7zFPYgHdWqJkqIeZcUZHHUZtt86E2KkFGYuOz02X4o3ESsVUIpuc+XFrRpa3OMMspsLC
         OnTw==
X-Gm-Message-State: AJIora/vybJ+dIyWop/zbg7dRZAL+LjT5wQJzgDtKyrH9f5qOttOSUAx
        BA5XUgHvGyYiKuSNUKlr+1adx0Tn2ttVv1hSnPnlqFIJQfU=
X-Google-Smtp-Source: AGRyM1vaWKdIGvSh3+yFJf1WTCa62Ib6B9+Yv6IOwWov62jmhOXhdgmrSWhxAGNFGDm3eM/WPHNQEOKvfUCwEmC/yRU=
X-Received: by 2002:a05:622a:4e:b0:31e:f84c:bf17 with SMTP id
 y14-20020a05622a004e00b0031ef84cbf17mr1507121qtw.566.1658518429381; Fri, 22
 Jul 2022 12:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220721024821.251231-1-joannelkoong@gmail.com>
 <20220721024821.251231-2-joannelkoong@gmail.com> <CA+khW7haDCVbccKryWDOhejqc-7B1geHK6Htx=Qm6k2oK=e=LA@mail.gmail.com>
 <CAJnrk1YjNrHRh9+vXCJiU9A6UsibJiNAhE5=s==ZM-Uw6xAjVQ@mail.gmail.com> <CA+khW7gwNTzM3puPGwCM7cum4uouyey95JUhg3gamgNYTbhDPA@mail.gmail.com>
In-Reply-To: <CA+khW7gwNTzM3puPGwCM7cum4uouyey95JUhg3gamgNYTbhDPA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 22 Jul 2022 12:33:38 -0700
Message-ID: <CA+khW7hJ1Quy13xidv2zGh3LS7x9sFBLe6asjr_vMexwtk88LQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: add extra test for using
 dynptr data slice after release
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
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

On Fri, Jul 22, 2022 at 12:25 PM Hao Luo <haoluo@google.com> wrote:
>
> On Fri, Jul 22, 2022 at 9:40 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > On Thu, Jul 21, 2022 at 10:28 AM Hao Luo <haoluo@google.com> wrote:
> > >
> > > Hi Joanne,
> > >
> > > On Wed, Jul 20, 2022 at 7:49 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> > > >
> > > > Add an additional test, "data_slice_use_after_release2", for ensuring
> > > > that data slices are correctly invalidated by the verifier after the
> > > > dynptr whose ref obj id they track is released. In particular, this
> > > > tests data slice invalidation for dynptrs located at a non-zero offset
> > > > from the frame pointer.
> > > >
> > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > ---
> > > >  .../testing/selftests/bpf/prog_tests/dynptr.c |  3 +-
> > > >  .../testing/selftests/bpf/progs/dynptr_fail.c | 32 ++++++++++++++++++-
> > > >  2 files changed, 33 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> > > > index 3c7aa82b98e2..bcf80b9f7c27 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> > > > @@ -22,7 +22,8 @@ static struct {
> > > >         {"add_dynptr_to_map2", "invalid indirect read from stack"},
> > > >         {"data_slice_out_of_bounds_ringbuf", "value is outside of the allowed memory range"},
> > > >         {"data_slice_out_of_bounds_map_value", "value is outside of the allowed memory range"},
> > > > -       {"data_slice_use_after_release", "invalid mem access 'scalar'"},
> > > > +       {"data_slice_use_after_release1", "invalid mem access 'scalar'"},
> > > > +       {"data_slice_use_after_release2", "invalid mem access 'scalar'"},
> > > >         {"data_slice_missing_null_check1", "invalid mem access 'mem_or_null'"},
> > > >         {"data_slice_missing_null_check2", "invalid mem access 'mem_or_null'"},
> > > >         {"invalid_helper1", "invalid indirect read from stack"},
> > > > diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > > > index d811cff73597..d8c4ed3ee146 100644
> > > > --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > > > +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > > > @@ -248,7 +248,7 @@ int data_slice_out_of_bounds_map_value(void *ctx)
> > > >
> > > >  /* A data slice can't be used after it has been released */
> > > >  SEC("?raw_tp/sys_nanosleep")
> > > > -int data_slice_use_after_release(void *ctx)
> > > > +int data_slice_use_after_release1(void *ctx)
> > > >  {
> > > >         struct bpf_dynptr ptr;
> > > >         struct sample *sample;
> > > > @@ -272,6 +272,36 @@ int data_slice_use_after_release(void *ctx)
> > > >         return 0;
> > > >  }
> > > >
> > > > +SEC("?raw_tp/sys_nanosleep")
> > > > +int data_slice_use_after_release2(void *ctx)
> > >
> > > Could you put comments explaining the reason for failure, like other test cases?
> > >
> > Hi Hao. The explanation for the data_slice_use_after_release test
> > cases is above the "data_slice_use_after_release1" case, but I can
> > also copy/paste that comment to above "data_slice_use_after_release2"
> > as well to make it easier to spot. I'll do that for v2.
>
> Thanks Joanne, appreciate the comment about the cause of failure! I
> noticed that in other test cases like
>
> ringbuf_missing_release1()
> ringbuf_missing_release2()
>
> There is a general description before the release1, and more details
> inside each function. Maybe following that convention is better? Sorry
> for having many requests from me. :)
>
> > > > +{
> > > > +       struct bpf_dynptr ptr1, ptr2;
> > > > +       struct sample *sample;
> > > > +
> > > > +       bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr1);
> > > > +       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr2);
> > > > +
> > > > +       sample = bpf_dynptr_data(&ptr2, 0, sizeof(*sample));
> > > > +       if (!sample)
> > > > +               goto done;
> > > > +
> > > > +       sample->pid = 23;
> > > > +
> > > > +       bpf_ringbuf_submit_dynptr(&ptr2, 0);
> > > > +
> > > > +       /* this should fail */
> > > > +       sample->pid = 23;
> > > > +
> > > > +       bpf_ringbuf_submit_dynptr(&ptr1, 0);
> > > > +
> > > > +       return 0;
> > > > +
> > > > +done:
> > > > +       bpf_ringbuf_discard_dynptr(&ptr2, 0);
> > > > +       bpf_ringbuf_discard_dynptr(&ptr1, 0);
> > > > +       return 0;
> > > > +}
> > > > +
> > >
> > > Joanne, I haven't been following the effort of dynptr, so I am still
> > > learning dynptr. Is there any use of `ptr1` in this test case?
> >
> > The use of ptr1 is so that ptr2 will be at a non-zero offset from the
> > frame pointer. This bug previously was unspotted because we were only
> > testing invalidated data slices for ptrs that were at a zero offset.
> >
> > I will include a comment about this in the test to make it more clear :)
> >
>
> Sounds good. It would be great if we can fix that bug and spare the
> use of ptr1 here.

Sorry, I don't mean we should do it in this patchset.

>
> Thanks!
>
> > >
> > > >  /* A data slice must be first checked for NULL */
> > > >  SEC("?raw_tp/sys_nanosleep")
> > > >  int data_slice_missing_null_check1(void *ctx)
> > > > --
> > > > 2.30.2
> > > >
