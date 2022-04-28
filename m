Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EF7513BB9
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 20:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351187AbiD1SoA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 14:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351200AbiD1Sn5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 14:43:57 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C215D5DF
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 11:40:41 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id z21so4694011pgj.1
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 11:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+GNcNFpTwAQvsQhTKvtDsMdHPiU3SKX33HP5I9HGVm8=;
        b=eywFPbeNUOs8uLKFgohKrGb95VliiVx0Q/1SxULkcufXTv6CXqVNAkSW2QMyC5WGwU
         lQxWQOgoitUIZ7OsnJCTdOIUWKkxcHw+wBS0wSxKM3M/5CPoS97U+RGabINdfdotvpGx
         R5iqE1S4LZyJBSEpfT1I1JNioEqLpfRobd9snaaUY2Ta/chSdeME5LjgFSMYT71lRP0J
         C/8fWbzUE8ZsDShxQ72nmryq93DNhhuHxI9uL2mjOanFc61130WTJ5YmLmlGF0hOG27L
         idP4oXmHLDPk49L6wzcYLnI9Sd+eix/G9AUlZa0VaqY0nz2VrxZChzHe190pPxVX6ND3
         H/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+GNcNFpTwAQvsQhTKvtDsMdHPiU3SKX33HP5I9HGVm8=;
        b=REKX6eIM+ajIZ8zNA+ewpL7T2vSFRrXfzDj/97leFQVueMH2kKEWGlxCoZGmIWVXEn
         sM3AZUUcJRmozLSaKoYmdT401Wk7FOcPv6B9UMKPpOL60LpdBJYKt+oFmfNkyIzBmjvf
         NTql6x8rZqBqfjtJz3BmDYor/iS+o+SoReMliYxZ2YT3OaVdhLf0XuSGtZkUrUQe3PuQ
         9ApHNOkq9QB+Ook/3f+kwULcLT9C4oOYBKLhR+KiDq+PmJerYrB72ihJkXtChr6EjnOQ
         Oj0mMndvuFTGyirX+3VntMfPAzdIbBOo93deb7RaC34JXzpOLPmx+Ek1CUKTuddseNAk
         R7FA==
X-Gm-Message-State: AOAM533uFfjO9SXB8jmEQSrPvLhcG3zLevRvb/JiZhWDMq3KF9+Wx0br
        vTEtfMNyGnXAUuykb6pxs0c63mdHW3AN/sHhSuY=
X-Google-Smtp-Source: ABdhPJy17WFCX2/ziR3i8/EnAlZRZCxEzed8k88MtgyWFPpfikW/DoGpC4R5VvUFHbFJmpqB17TOW+A0xWOv5s1bJgk=
X-Received: by 2002:a63:5163:0:b0:3a9:4e90:6d3d with SMTP id
 r35-20020a635163000000b003a94e906d3dmr29467041pgl.48.1651171241237; Thu, 28
 Apr 2022 11:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651103126.git.delyank@fb.com> <9bae67335d76cfffadf9777be79c32c0f1deb897.1651103126.git.delyank@fb.com>
 <CAEf4BzZb5t5L4MuTxfm0QK0z9c_PmeBrYsj4qByZCWq0v8378A@mail.gmail.com>
In-Reply-To: <CAEf4BzZb5t5L4MuTxfm0QK0z9c_PmeBrYsj4qByZCWq0v8378A@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 28 Apr 2022 11:40:29 -0700
Message-ID: <CAADnVQK8Cm24dhb6QftrUwYN3ROJr_GO+YdXsmfoQxKtV-3N-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] bpf: allow sleepable uprobe programs to attach
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Delyan Kratunov <delyank@fb.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
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

On Thu, Apr 28, 2022 at 11:22 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 28, 2022 at 9:54 AM Delyan Kratunov <delyank@fb.com> wrote:
> >
> > uprobe and kprobe programs have the same program type, KPROBE, which is
> > currently not allowed to load sleepable programs.
> >
> > To avoid adding a new UPROBE type, we instead allow sleepable KPROBE
> > programs to load and defer the is-it-actually-a-uprobe-program check
> > to attachment time, where we're already validating the corresponding
> > perf_event.
> >
> > A corollary of this patch is that you can now load a sleepable kprobe
> > program but cannot attach it.
> >
> > Signed-off-by: Delyan Kratunov <delyank@fb.com>
> > ---
> >  kernel/bpf/syscall.c  | 8 ++++++++
> >  kernel/bpf/verifier.c | 4 ++--
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index e9e3e49c0eb7..3ce923f489d7 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3009,6 +3009,14 @@ static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *pro
> >         }
> >
> >         event = perf_file->private_data;
> > +       if (prog->aux->sleepable) {
> > +               if (!event->tp_event || (event->tp_event->flags & TRACE_EVENT_FL_UPROBE) == 0) {
>
> so far TRACE_EVENT_FL_UPROBE was contained to within kernel/trace so
> far, maybe it's better to instead expose a helper function to check if
> perf_event represents uprobe?

or we can move prog->aux->sleepable check down into
perf_event_set_bpf_prog().
Which is probably cleaner.
We check other prog flags there.
