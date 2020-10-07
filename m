Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B538286AA3
	for <lists+bpf@lfdr.de>; Thu,  8 Oct 2020 00:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgJGWEq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Oct 2020 18:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbgJGWEq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Oct 2020 18:04:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100DAC061755
        for <bpf@vger.kernel.org>; Wed,  7 Oct 2020 15:04:46 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z1so4067567wrt.3
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2020 15:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qzKsX49VoG3YhzcjmRNGWiHbb8DBTpj85pJrbDKwLr0=;
        b=IZM9CY72pOKpPM/P0UKNaXlFpL9RjY+y/paWQuT9QrsfUum9/7Ait9IDXXOoRPh9xq
         DqCxv5+sga5qMlWqkKRexfNS0nFVHphrUPvAMhNH8w3GOVrt8VL22Bin4RYjQn2l+ej7
         Kc6vLRDS5psZF4EEbppAG12lqwS4WcNAsR84o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qzKsX49VoG3YhzcjmRNGWiHbb8DBTpj85pJrbDKwLr0=;
        b=ENfyY1XIzLP6Ge7bgdWn19lU50J9tEzAs8NewSar0BMw9zoi5WCD30o9ecHei0T3+W
         hw6Rdi1YUTNNUfNHKQD3FI5UeGXa0Kbfl1+ZiN0q6emAtiq6pLRSzOA0nzU2cnx6UhyK
         sM1Iilj4ML6Zx9Hw26UCtJVgoiHIneaG3itVzaMJ0l/8VkdqirJ8ds7YIQqBPGvaKwhl
         3Dyykv7XC7MR0FcCt+JlUzvj244YGkZR5ZCua3k2tTHXvtgHYR+cZSUE4ogHJvnWz3am
         jutV24Yajg327OCnn+BEb96HVxcfRMmDwWZ/ygc3KUdmIKP/5XplHpXq0wH4t9LSQ0Jf
         uPJg==
X-Gm-Message-State: AOAM532zIeofdzTRCy1D9uOzFTDiD92579mCxKixlo8FnvtauDMhp0By
        9tA+DCgm8wT6oh8qFgTK6jVqlbv2/hBlBEQ1Gt8HUA==
X-Google-Smtp-Source: ABdhPJzcvoOoXXvTVJE1Zo5SsHTeMWCCCb/w1GPrevvF32c4vKYvSLM71DpMtCqvmjtFrMOTGOm9y2aeZGsGzcwrd6M=
X-Received: by 2002:adf:e711:: with SMTP id c17mr5782110wrm.359.1602108283122;
 Wed, 07 Oct 2020 15:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <CACYkzJ7AfZ4HMEzt7OV_T4N8RO4SJcFbyEVxCgVrkKS4uiOD=g@mail.gmail.com>
 <CAEf4BzbrF9C27gX5JaAq--Ex7+cJe0yz0QKVo9fov2voiiWwtA@mail.gmail.com>
 <71e1203f-5864-f86d-e587-67d92183b89b@fb.com> <CAADnVQK1v7vz-AQfw2OcUD4tD1wesSdzaRA1bFvtm2ae3fLwAw@mail.gmail.com>
 <549d23c4-bb83-2116-fb51-293a043e6f21@fb.com>
In-Reply-To: <549d23c4-bb83-2116-fb51-293a043e6f21@fb.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 8 Oct 2020 00:04:32 +0200
Message-ID: <CACYkzJ6XByjNfJi6cFEPUZsfZ=9uHUYHU6cXuBPuzedj66nehA@mail.gmail.com>
Subject: Re: Failure in test_local_storage at bpf-next
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 7, 2020 at 7:33 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 10/6/20 10:18 PM, Alexei Starovoitov wrote:
> > On Tue, Oct 6, 2020 at 9:31 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >>
> >> On 10/6/20 6:23 PM, Andrii Nakryiko wrote:
> >>> On Tue, Oct 6, 2020 at 5:31 PM KP Singh <kpsingh@chromium.org> wrote:
> >>>>
> >>>> I noticed that test_local_storage is broken due to a BTF error at
> >>>> bpf-next [67ed375530e2 ("samples: bpf: Driver interrupt statistics in
> >>>> xdpsock")]
> >>>>
> >>>> ./test_progs -t test_local_storage
> >>>> libbpf: prog 'socket_post_create': relo #0: parsing [28] struct socket + 0:0.1 2
> >>>
> >>> This line is truncated, btw, please make sure you post the entire
> >>> output next time.

I just ran this again and it does not seem like it's truncated:

./test_progs -t test_local_storage
libbpf: prog 'socket_post_create': relo #0: parsing [28] struct socket + 0:0.1 2
libbpf: prog 'socket_post_create': relo #0: failed to relocate: -22
libbpf: failed to perform CO-RE relocations: -22
libbpf: failed to load object 'local_storage'
libbpf: failed to load BPF skeleton 'local_storage': -22
test_test_local_storage:FAIL:skel_load lsm skeleton failed

Am I missing something?

> >>>
> >>> But, this seems like a bug in Clang, it produced invalid access index
> >>> string "0:0.1", there shouldn't be any other separator except ':' in
> >>> those strings.
> >>>
> >>> Yonghong, can you please take a look? This seems to be a very recent
> >>> regression, I had to update to
> >>> 6c7d713cf5d9bb188f1e73452a256386f0288bf7 sha from not-too-outdated
> >>> version to repro this.
> >>
> >> Sorry. This indeed is a llvm regression. The guilty patch is
> >> https://reviews.llvm.org/D88855  which adds NPM (new pass manager)
> >> support for BPF. The patch just merged this morning, thanks for catching
> >> the bug so fast. Since NPM is not used by default and the code
> >> refactoring looks okay, so I did not run selftests. But, yah, it does
> >> change some semantics of the code...
> >
> > but llvm tests were run, of course.
> > Looks like we need to add more of them, so they can gate the landing.
>
> Right, just added two more tests to gate this particular kind of
> failure. Also just pushed a new version which is simpler compared to
> previous version.
>
> >
> >> I just put a fix at https://reviews.llvm.org/D88942 .
> >> Hopefully to merge soon.
> >
> > Thanks for the quick fix!

Thank you so much!

> >
