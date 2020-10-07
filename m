Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55C8285818
	for <lists+bpf@lfdr.de>; Wed,  7 Oct 2020 07:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgJGFTL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Oct 2020 01:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgJGFTL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Oct 2020 01:19:11 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FCDC061755
        for <bpf@vger.kernel.org>; Tue,  6 Oct 2020 22:19:10 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id b12so803450lfp.9
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2020 22:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEFBpRoirAUUmKMmda+VZYr77QUaTmTWxBlIjuiqc80=;
        b=k08vpvfRpDlv96go03T2CoYkFTntBSX2H0zeObUxvo/SRgl39VgzMZH7yrB0DTz5L3
         DZc1EAPl+H4sDQN71y2CWTP8epr5+9pX9dJoEb6t2N0KFo8I+AorBs2eVLT+Azn0mBRj
         rYZH2i8ei4/gXunRLNKrbdBDF1LtLc3sEJXTyyzk/T1Kr6XGByqYM/qlZ6d5Ddq2BCb0
         uaUK7wr58kE3qzdUpQqkLl1EOKGarEAmJt29QwyeHrucENOYnNiius7G9ocV7/aJ0UxU
         Z45p2KLrsKDrkq9x3QmtlTuIYUSnMlcZtGxXct6HmuZRJFe74mY9APfpWXqDiaDHylOq
         GiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEFBpRoirAUUmKMmda+VZYr77QUaTmTWxBlIjuiqc80=;
        b=iEmPSAev8FQeGtPB44aN4pP9e2mxc+w1wJ7YsfgOQYcuoKEdtps2MmYPXM8fb55Ka6
         4EbYqWUbdfJXUYcMSMJye6+3TZJFUyMM1HlKNkLESUmBijrfIly8c6qsasJGK0o+3v4m
         urS5tuYcaOXO4bxHC811xwQhdYwwT6I4ZCsublHPM8f3d9UkoZzQRn8e9Rytg59S1+SP
         B+qJLAR5UsEu6R7BKOrNcC/y49QZ40fuoOVtsB9Ub1DnmhsBhvZlPtG9SCqfcJRb82bm
         5wV7ZXCQQaLgGPPUGQ8aef8oAG23nXovy5zFj1qyKcHuSJmNDGsJCy2fMHcm8jAhyQym
         pTeg==
X-Gm-Message-State: AOAM532y/B07av5S4SR7LsJb9ASUfRg7rnR+JiItnnIQGxGBGRuwtwB0
        g+d8VpLPD2EgWJMeaVO2A6imxfhAMOLuc6bso2o=
X-Google-Smtp-Source: ABdhPJxDN43EB/UpayA+BxvDRl6qgo74bon55D6FuMnEXAL7XqMLbIWyaR4vm45NGKBKvqG0ImBPxE/PJ3+VwAJMZwA=
X-Received: by 2002:a19:8089:: with SMTP id b131mr353644lfd.390.1602047949086;
 Tue, 06 Oct 2020 22:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <CACYkzJ7AfZ4HMEzt7OV_T4N8RO4SJcFbyEVxCgVrkKS4uiOD=g@mail.gmail.com>
 <CAEf4BzbrF9C27gX5JaAq--Ex7+cJe0yz0QKVo9fov2voiiWwtA@mail.gmail.com> <71e1203f-5864-f86d-e587-67d92183b89b@fb.com>
In-Reply-To: <71e1203f-5864-f86d-e587-67d92183b89b@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 6 Oct 2020 22:18:57 -0700
Message-ID: <CAADnVQK1v7vz-AQfw2OcUD4tD1wesSdzaRA1bFvtm2ae3fLwAw@mail.gmail.com>
Subject: Re: Failure in test_local_storage at bpf-next
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 6, 2020 at 9:31 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 10/6/20 6:23 PM, Andrii Nakryiko wrote:
> > On Tue, Oct 6, 2020 at 5:31 PM KP Singh <kpsingh@chromium.org> wrote:
> >>
> >> I noticed that test_local_storage is broken due to a BTF error at
> >> bpf-next [67ed375530e2 ("samples: bpf: Driver interrupt statistics in
> >> xdpsock")]
> >>
> >> ./test_progs -t test_local_storage
> >> libbpf: prog 'socket_post_create': relo #0: parsing [28] struct socket + 0:0.1 2
> >
> > This line is truncated, btw, please make sure you post the entire
> > output next time.
> >
> > But, this seems like a bug in Clang, it produced invalid access index
> > string "0:0.1", there shouldn't be any other separator except ':' in
> > those strings.
> >
> > Yonghong, can you please take a look? This seems to be a very recent
> > regression, I had to update to
> > 6c7d713cf5d9bb188f1e73452a256386f0288bf7 sha from not-too-outdated
> > version to repro this.
>
> Sorry. This indeed is a llvm regression. The guilty patch is
> https://reviews.llvm.org/D88855 which adds NPM (new pass manager)
> support for BPF. The patch just merged this morning, thanks for catching
> the bug so fast. Since NPM is not used by default and the code
> refactoring looks okay, so I did not run selftests. But, yah, it does
> change some semantics of the code...

but llvm tests were run, of course.
Looks like we need to add more of them, so they can gate the landing.

> I just put a fix at https://reviews.llvm.org/D88942.
> Hopefully to merge soon.

Thanks for the quick fix!
