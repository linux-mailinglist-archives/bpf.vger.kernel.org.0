Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC9357E492
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 18:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbiGVQk1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 12:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbiGVQkZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 12:40:25 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998D911A2F
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 09:40:23 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x91so6534570ede.1
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 09:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DrGYYevMfHn57iXyvG11bVG0emRMWC1xcOX2K2v1YYk=;
        b=bpABX3fya8Uhv22CB5k9Y+pp27qxVpilcZHMLBfCtvTbtflQOGd/9kqzZANsfCTsfG
         kpKT5NGaOPrvPje9NemfSU6qo4X5R5gfTmd5pQ5meSX0Zs8H9cYdB7nT76/aURzzDQfy
         nn3/lC10/Y+fnaHfCdQDitIxiFZ1YuUTM4/UtfSSy28w5GoYCWEGA9q8P7LQ+59pRDYa
         K8+OgpBymahXaEzIC36N9SZkjhOLKCQDU/V8Y6YHQv1/XTUVfmPjYxHdfgJc1XqYjftT
         fE3+mSoDclMIbW4oSUx8J9aGRa2Po/p9u2SEmlkcVCxRmrRvi3mAkgengPI9B9e8DwZc
         p7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DrGYYevMfHn57iXyvG11bVG0emRMWC1xcOX2K2v1YYk=;
        b=IpBO9AHnn++WPDiW5WeEJ08iBfnXkxVWRWV/vx79kGAR+t9mUJnFS6hgXbi/e0C+NL
         FWpn37NWM207g0KHbLrAmb1ToeX0SEeXxL6/y219mrYhMHD10vDAargWaaqQ6Sf3N7l6
         TWRet9+gpWpZj2dz1W5T15i3O6pPyV4FQfd6EeoWtF9ZVFcHz72TglOKP6m90aYATE6T
         UvwZ2dVW5HkZP+E05QIBnmsQy20+Bv5JHf43Pj1PtdWUPsFAxP+IFVyb+D/P/+s7z/zJ
         42M9DH3uXlzH3PcY1SGRNprUekSRFGzz7VDEofqjQiMLKtpkpLDi2S2bE8UEhWxqojZD
         ULpw==
X-Gm-Message-State: AJIora8YdKIypgvaTXHxAuKz3RllOHPJz0J4hB+9mB56IDO+ZUBjQkqA
        2atW7WonD5/BOlpOlkLHo/OTQh7csNvh2I4fyH4=
X-Google-Smtp-Source: AGRyM1uOEI4LWZ0iMUJPFpsAkzUYmgAo29c2QtNf3VipW2jTHm71mL5LVYXfILQcnJqfnA2Fyl3LG44KWMSYGG7BJGY=
X-Received: by 2002:a05:6402:28c4:b0:43a:cdde:e047 with SMTP id
 ef4-20020a05640228c400b0043acddee047mr740662edb.368.1658508022024; Fri, 22
 Jul 2022 09:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220721024821.251231-1-joannelkoong@gmail.com>
 <20220721024821.251231-2-joannelkoong@gmail.com> <CA+khW7haDCVbccKryWDOhejqc-7B1geHK6Htx=Qm6k2oK=e=LA@mail.gmail.com>
In-Reply-To: <CA+khW7haDCVbccKryWDOhejqc-7B1geHK6Htx=Qm6k2oK=e=LA@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 22 Jul 2022 09:40:09 -0700
Message-ID: <CAJnrk1YjNrHRh9+vXCJiU9A6UsibJiNAhE5=s==ZM-Uw6xAjVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: add extra test for using
 dynptr data slice after release
To:     Hao Luo <haoluo@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
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

On Thu, Jul 21, 2022 at 10:28 AM Hao Luo <haoluo@google.com> wrote:
>
> Hi Joanne,
>
> On Wed, Jul 20, 2022 at 7:49 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > Add an additional test, "data_slice_use_after_release2", for ensuring
> > that data slices are correctly invalidated by the verifier after the
> > dynptr whose ref obj id they track is released. In particular, this
> > tests data slice invalidation for dynptrs located at a non-zero offset
> > from the frame pointer.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  .../testing/selftests/bpf/prog_tests/dynptr.c |  3 +-
> >  .../testing/selftests/bpf/progs/dynptr_fail.c | 32 ++++++++++++++++++-
> >  2 files changed, 33 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> > index 3c7aa82b98e2..bcf80b9f7c27 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> > @@ -22,7 +22,8 @@ static struct {
> >         {"add_dynptr_to_map2", "invalid indirect read from stack"},
> >         {"data_slice_out_of_bounds_ringbuf", "value is outside of the allowed memory range"},
> >         {"data_slice_out_of_bounds_map_value", "value is outside of the allowed memory range"},
> > -       {"data_slice_use_after_release", "invalid mem access 'scalar'"},
> > +       {"data_slice_use_after_release1", "invalid mem access 'scalar'"},
> > +       {"data_slice_use_after_release2", "invalid mem access 'scalar'"},
> >         {"data_slice_missing_null_check1", "invalid mem access 'mem_or_null'"},
> >         {"data_slice_missing_null_check2", "invalid mem access 'mem_or_null'"},
> >         {"invalid_helper1", "invalid indirect read from stack"},
> > diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > index d811cff73597..d8c4ed3ee146 100644
> > --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > @@ -248,7 +248,7 @@ int data_slice_out_of_bounds_map_value(void *ctx)
> >
> >  /* A data slice can't be used after it has been released */
> >  SEC("?raw_tp/sys_nanosleep")
> > -int data_slice_use_after_release(void *ctx)
> > +int data_slice_use_after_release1(void *ctx)
> >  {
> >         struct bpf_dynptr ptr;
> >         struct sample *sample;
> > @@ -272,6 +272,36 @@ int data_slice_use_after_release(void *ctx)
> >         return 0;
> >  }
> >
> > +SEC("?raw_tp/sys_nanosleep")
> > +int data_slice_use_after_release2(void *ctx)
>
> Could you put comments explaining the reason for failure, like other test cases?
>
Hi Hao. The explanation for the data_slice_use_after_release test
cases is above the "data_slice_use_after_release1" case, but I can
also copy/paste that comment to above "data_slice_use_after_release2"
as well to make it easier to spot. I'll do that for v2.
> > +{
> > +       struct bpf_dynptr ptr1, ptr2;
> > +       struct sample *sample;
> > +
> > +       bpf_ringbuf_reserve_dynptr(&ringbuf, 64, 0, &ptr1);
> > +       bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(*sample), 0, &ptr2);
> > +
> > +       sample = bpf_dynptr_data(&ptr2, 0, sizeof(*sample));
> > +       if (!sample)
> > +               goto done;
> > +
> > +       sample->pid = 23;
> > +
> > +       bpf_ringbuf_submit_dynptr(&ptr2, 0);
> > +
> > +       /* this should fail */
> > +       sample->pid = 23;
> > +
> > +       bpf_ringbuf_submit_dynptr(&ptr1, 0);
> > +
> > +       return 0;
> > +
> > +done:
> > +       bpf_ringbuf_discard_dynptr(&ptr2, 0);
> > +       bpf_ringbuf_discard_dynptr(&ptr1, 0);
> > +       return 0;
> > +}
> > +
>
> Joanne, I haven't been following the effort of dynptr, so I am still
> learning dynptr. Is there any use of `ptr1` in this test case?

The use of ptr1 is so that ptr2 will be at a non-zero offset from the
frame pointer. This bug previously was unspotted because we were only
testing invalidated data slices for ptrs that were at a zero offset.

I will include a comment about this in the test to make it more clear :)

>
> >  /* A data slice must be first checked for NULL */
> >  SEC("?raw_tp/sys_nanosleep")
> >  int data_slice_missing_null_check1(void *ctx)
> > --
> > 2.30.2
> >
