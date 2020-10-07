Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB902857E2
	for <lists+bpf@lfdr.de>; Wed,  7 Oct 2020 06:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgJGEoP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Oct 2020 00:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgJGEoP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Oct 2020 00:44:15 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AF1C061755
        for <bpf@vger.kernel.org>; Tue,  6 Oct 2020 21:44:15 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id n142so857558ybf.7
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2020 21:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b22qqHXR5Thl90sJSAq5b7kttFOBr1PY73BaB/Yz4s8=;
        b=DflmCvf/TmbT4rVtUQBShs6bZ9ZGT1EKr/oKpIIBv5Pt/Um1TTa4p3AKD9Q8bprDe8
         kj9/yHxydzi3XT22cDnW6F05nnfHieb17n4UNNp7NudSL8pHXsuRjq3BB7i+JrNgK1JD
         cuO5iwhpLmBbcs7ogv0hHwEMeJTFG+X8Us0gSTFrLJ/IYbErJrU/zEQQ/ojcG0+DzjVA
         ReLmR7fCwyKErADfMqxmy1IYYoxKM8PeZqE3ua/Ftk9imfbp9ZO2nAVy+5kdjXAGuCEJ
         dP2p0lGnWUUHts7t9QMfa+2R4YqC7QSjc4MxjbqDsIJfCxCxflkzCko2ZgOTLvivPI5Z
         d7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b22qqHXR5Thl90sJSAq5b7kttFOBr1PY73BaB/Yz4s8=;
        b=k4gkKgRorWKk1QuG1EYcD+svlgnnS9b0xABW4nDaVOjEM2LQCdXK+KulwHONSlDpBv
         wt4KCHf405HIjaAQMPH3R8+HorQAQVLNm5XfEZYVn2yVf6Hd+wL6pv5SltQpgkf/TxY0
         zH7+C8YmxJX9Gj33mJAaJq28ZlHTp0Im0xtQaN14KwQdOXI6eExVYQ0JV0Ka2Ty5MzDV
         PlbYNNRcmVili/0DVKi3plD7aYM38Gk2H7dZMBvrwWItTBRbP8+HaoQw2teJFtB/JlvF
         0mCYau42Ed7QwotLdUhcgazlaj7c4RSL5euSuRAYU81pIuUm/LRr6DUju2mjkvSgPdVQ
         3Kbg==
X-Gm-Message-State: AOAM531xljL08UBpHDJYMQzAh2MH49KUuJgxhPyKKakea1dP74UA6pmh
        mCHrVc8RXdHxuq1L6mh8eYjILxF/qjVl9K7Cj9o=
X-Google-Smtp-Source: ABdhPJz/VfrJ5t1UsBsGuvx3YJJw1QQmaf8nagKMMHrIHzHih1fojtJhdBq6VyaqzC4Ksv+JT8E46v8Wopw7Qwk71kI=
X-Received: by 2002:a25:6644:: with SMTP id z4mr1955780ybm.347.1602045853065;
 Tue, 06 Oct 2020 21:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <CACYkzJ7AfZ4HMEzt7OV_T4N8RO4SJcFbyEVxCgVrkKS4uiOD=g@mail.gmail.com>
 <CAEf4BzbrF9C27gX5JaAq--Ex7+cJe0yz0QKVo9fov2voiiWwtA@mail.gmail.com> <71e1203f-5864-f86d-e587-67d92183b89b@fb.com>
In-Reply-To: <71e1203f-5864-f86d-e587-67d92183b89b@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 6 Oct 2020 21:44:02 -0700
Message-ID: <CAEf4BzZ5WOwAkfqXpJCujkrcN-8DL2UvtiNpSiELBT7z99h5cg@mail.gmail.com>
Subject: Re: Failure in test_local_storage at bpf-next
To:     Yonghong Song <yhs@fb.com>
Cc:     KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
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
>
> I just put a fix at https://reviews.llvm.org/D88942.
> Hopefully to merge soon.

No worries, thanks for a quick fix!

>
> >
> >> libbpf: prog 'socket_post_create': relo #0: failed to relocate: -22
> >> libbpf: failed to perform CO-RE relocations: -22
> >> libbpf: failed to load object 'local_storage'
> >> libbpf: failed to load BPF skeleton 'local_storage': -22
> >> test_test_local_storage:FAIL:skel_load lsm skeleton failed
> >>
> >> by changing it to use vmlinux.h with:
> >>
> >
> > [...]
> >
> >>
> >> clang --version
> >> clang version 12.0.0 (https://github.com/llvm/llvm-project.git
> >> 6c7d713cf5d9bb188f1e73452a256386f0288bf7)
> >> Target: x86_64-unknown-linux-gnu
> >> Thread model: posix
> >>
> >> pahole --version
> >> v1.18
> >>
> >> This error goes away if I comment out the lsm/socket_post_create or
> >> the lsm/socket_bind which makes me think that something in
> >> bpf_core_apply_relo does not like two programs in the same object
> >> having the same BTF type in its signature (but this just a guess, I
> >> did not investigate more).  I was wondering if anyone has any ideas
> >> what could be going on here.
> >>
> >> PS: While working on task local storage, I noted that some of the
> >> checks in this test were buggy and will send a patch to fix them as
> >> well.
> >>
> >> - KP
