Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AE7286AB4
	for <lists+bpf@lfdr.de>; Thu,  8 Oct 2020 00:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgJGWIJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Oct 2020 18:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgJGWIJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Oct 2020 18:08:09 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E94C061755
        for <bpf@vger.kernel.org>; Wed,  7 Oct 2020 15:08:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w5so4067448wrp.8
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2020 15:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4jp/P/BCUKkkHkZcYj87J1R8PJAjXRHADygk6PgcTw4=;
        b=bhnxaBYAvumBlKf9VWS+0c1IMoSaEp9tFBS7TRJGGkR+bbouUK+Bk7YdSrBNXuslJL
         Nl1L7MEMKrlzJaBX+gkvjXZhwqIHDOyp+d/WRUA7Xl2htugBmEzhWayC7qXPT5zQNO3T
         NyYGPNzb6SYY//E6TV/7CCwQFYmSII7142z0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4jp/P/BCUKkkHkZcYj87J1R8PJAjXRHADygk6PgcTw4=;
        b=ZcbeEvMeY6MYiySNh039dRNyMdtskkx51Mn0hqiV9KvwxyX3hW4Zw2CtyQ/uGekkhG
         VbJRqFBqli1auUv7hXl9cH4cLikrd7zcJ9hk2ysNmKBiRCSkfFvfRBy+mMl0fc+aJNBy
         cJ43I4QgppvR9tB0HQsv8DQD5OEJaMkqqK+lzhx+Tgsj2MTQDubswAzIR6KQ5hBOaXf9
         L/+P/QJNYRgtys6ACZGooH3E+OrvU44Z+GaeDoKhAbgcV/HloL1vaLbbCEUp+V1M8Fhp
         OT3z6khuv/3N5YqZ7l1Z3JOcI1AM/zRLQTk4XP4iNZPKJDv8YNskNruosp4uVsQBlilC
         T00w==
X-Gm-Message-State: AOAM533kliCUd3AqCKGWMKjjThHrXxEVdkVzef5CqCinoTxKGiO/Ajde
        PTcT6aj/BtbgSlANC2fM+ewd42YEEHr5RuCK3a5wuA==
X-Google-Smtp-Source: ABdhPJyDBXeokVmgJtzWKLw9c+M/fGyecZGLCxLrLqoEZJgrd0dqq3iE1iL9f7lL+sT8HQYSJZ/TUMee1y2mG9BDS3U=
X-Received: by 2002:adf:fa02:: with SMTP id m2mr5581345wrr.273.1602108486235;
 Wed, 07 Oct 2020 15:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <CACYkzJ7AfZ4HMEzt7OV_T4N8RO4SJcFbyEVxCgVrkKS4uiOD=g@mail.gmail.com>
 <CAEf4BzbrF9C27gX5JaAq--Ex7+cJe0yz0QKVo9fov2voiiWwtA@mail.gmail.com>
 <71e1203f-5864-f86d-e587-67d92183b89b@fb.com> <CAADnVQK1v7vz-AQfw2OcUD4tD1wesSdzaRA1bFvtm2ae3fLwAw@mail.gmail.com>
 <549d23c4-bb83-2116-fb51-293a043e6f21@fb.com> <CACYkzJ6XByjNfJi6cFEPUZsfZ=9uHUYHU6cXuBPuzedj66nehA@mail.gmail.com>
In-Reply-To: <CACYkzJ6XByjNfJi6cFEPUZsfZ=9uHUYHU6cXuBPuzedj66nehA@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 8 Oct 2020 00:07:55 +0200
Message-ID: <CACYkzJ6sWE3mq1sf_m+WO3RYw-rqPd2iYmSfKdq8R-rGhy11+Q@mail.gmail.com>
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

On Thu, Oct 8, 2020 at 12:04 AM KP Singh <kpsingh@chromium.org> wrote:
>
> On Wed, Oct 7, 2020 at 7:33 AM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 10/6/20 10:18 PM, Alexei Starovoitov wrote:
> > > On Tue, Oct 6, 2020 at 9:31 PM Yonghong Song <yhs@fb.com> wrote:
> > >>
> > >>
> > >>
> > >> On 10/6/20 6:23 PM, Andrii Nakryiko wrote:
> > >>> On Tue, Oct 6, 2020 at 5:31 PM KP Singh <kpsingh@chromium.org> wrote:
> > >>>>
> > >>>> I noticed that test_local_storage is broken due to a BTF error at
> > >>>> bpf-next [67ed375530e2 ("samples: bpf: Driver interrupt statistics in
> > >>>> xdpsock")]
> > >>>>
> > >>>> ./test_progs -t test_local_storage
> > >>>> libbpf: prog 'socket_post_create': relo #0: parsing [28] struct socket + 0:0.1 2
> > >>>
> > >>> This line is truncated, btw, please make sure you post the entire
> > >>> output next time.
>
> I just ran this again and it does not seem like it's truncated:
>
> ./test_progs -t test_local_storage
> libbpf: prog 'socket_post_create': relo #0: parsing [28] struct socket + 0:0.1 2
> libbpf: prog 'socket_post_create': relo #0: failed to relocate: -22
> libbpf: failed to perform CO-RE relocations: -22
> libbpf: failed to load object 'local_storage'
> libbpf: failed to load BPF skeleton 'local_storage': -22
> test_test_local_storage:FAIL:skel_load lsm skeleton failed
>
> Am I missing something?

And indeed I am. It was a bug in my script.

For the record this should have been:

root@kpsingh:~# ./test_progs -t test_local_storage
libbpf: prog 'socket_post_create': relo #0: parsing [28] struct socket
+ 0:0.1 failed: -22
libbpf: prog 'socket_post_create': relo #0: failed to relocate: -22
libbpf: failed to perform CO-RE relocations: -22
libbpf: failed to load object 'local_storage'
libbpf: failed to load BPF skeleton 'local_storage': -22
test_test_local_storage:FAIL:skel_load lsm skeleton failed
#106 test_local_storage:FAIL
Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED

Thanks everyone for looking into this and fixing it!

>
> > >>>
> > >>> But, this seems like a bug in Clang, it produced invalid access index
> > >>> string "0:0.1", there shouldn't be any other separator except ':' in
> > >>> those strings.
> > >>>
> > >>> Yonghong, can you please take a look? This seems to be a very recent
> > >>> regression, I had to update to
> > >>> 6c7d713cf5d9bb188f1e73452a256386f0288bf7 sha from not-too-outdated
> > >>> version to repro this.
> > >>
> > >> Sorry. This indeed is a llvm regression. The guilty patch is
> > >> https://reviews.llvm.org/D88855  which adds NPM (new pass manager)
> > >> support for BPF. The patch just merged this morning, thanks for catching
> > >> the bug so fast. Since NPM is not used by default and the code
> > >> refactoring looks okay, so I did not run selftests. But, yah, it does
> > >> change some semantics of the code...
> > >
> > > but llvm tests were run, of course.
> > > Looks like we need to add more of them, so they can gate the landing.
> >
> > Right, just added two more tests to gate this particular kind of
> > failure. Also just pushed a new version which is simpler compared to
> > previous version.
> >
> > >
> > >> I just put a fix at https://reviews.llvm.org/D88942 .
> > >> Hopefully to merge soon.
> > >
> > > Thanks for the quick fix!
>
> Thank you so much!
>
> > >
