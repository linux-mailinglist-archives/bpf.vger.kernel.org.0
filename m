Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01B640FFA1
	for <lists+bpf@lfdr.de>; Fri, 17 Sep 2021 20:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhIQS4R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 14:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhIQS4Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Sep 2021 14:56:16 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B53BC061574
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 11:54:47 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id m21so20435738qkm.13
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 11:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=waCbCF6Dkm7kkaFLmFuJ45gyckvcLjKVVVSeLo1/7BY=;
        b=V+Q8sdBVOQ4UGalrK7BN1sK53gXzF2AmpecwXDSuQEeTRZmHRvYVSfCjbdEJUTDoJP
         5kSTRSLHysjvAYeOxPxeSxjVOp4t9tmXoEdb/Nfcld6Nqdv9slqf/5nQWtDghgyQBtUx
         +qcI0wJGfvuy2cjY5MLLdzK8kwQtxRxjkzDPWLGtOGuiGxhHSlcayzuvkrwBKlfm+RRo
         kKqYueUM1LzqRwOvOowkntEn/mBhfgT0+FpCvb3NBM/PjtLubHqLh7sU0uF8/Gmk55KS
         YxzqIkVDS2RTF6omhxfRwhjxSzot0z5nLNROpLUJwcDarDIJKXKlE2JXZ/1bRhxTUK/i
         h32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=waCbCF6Dkm7kkaFLmFuJ45gyckvcLjKVVVSeLo1/7BY=;
        b=U00dlk1KFiLvy9L97q9EcWReL+RNXKAslB0JmSH2uO81eXouogFVZVlZrGifVUSatN
         uqc9E48xRt3IMIJJiCoPpZRrQqQXatUqKnAUGXCkrKBP17hGiIaPhZfBLIbPJpWM3PP5
         dtBRF4aeqxy9fC3SrismYMZx6/00sFk2WF9iTQbltSTFj6y6HkAcmHsHhU0SgiL0Jd1T
         7uPImdPvRNeZ5eevJh54QKi5ec+IiqgZY8yWz/oIXRt9sBGB4Y8Xb9ek4pwFOVl8m6qJ
         5pyArh0tlD2dsRd45nAC2f+FZo/QBv2PSWxUKjbVdQhdM6LXNjquiwMzxB5pqN8aeNOe
         UJrg==
X-Gm-Message-State: AOAM532wtyZisD7eEBdAAF3ApxxO3kTEPkrPMezk6352dVvjn9ZMF23/
        ywrIyguPUGUt1zzjlFnpdeMMH9tpnf+JY5h4mrk=
X-Google-Smtp-Source: ABdhPJz05+nzR6aoLDepyFy8sdLL80G3xX4LkfEhKaqitkIqhEjBPzUG5bp2d5/ajBhKxw2wav2/2mfd750WRA01c3w=
X-Received: by 2002:a25:1bc5:: with SMTP id b188mr15155075ybb.267.1631904886536;
 Fri, 17 Sep 2021 11:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210916032641.1413293-1-fallentree@fb.com> <20210916032641.1413293-2-fallentree@fb.com>
 <CAEf4Bzaxj-UmE3CB_0EPSJsczqfCh8xtT=5whGUMOY_vGCGe-A@mail.gmail.com>
In-Reply-To: <CAEf4Bzaxj-UmE3CB_0EPSJsczqfCh8xtT=5whGUMOY_vGCGe-A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 17 Sep 2021 11:54:35 -0700
Message-ID: <CAEf4BzZAzOuPQHLDbOK5KegiivUstOrDKgF3hqHG6V91oRN5GQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/3] selftests/bpf: Add parallelism to test_progs
To:     Yucong Sun <fallentree@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 17, 2021 at 11:43 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Sep 15, 2021 at 8:26 PM Yucong Sun <fallentree@fb.com> wrote:
> >
> > From: Yucong Sun <sunyucong@gmail.com>
> >
> > This patch adds "-j" mode to test_progs, executing tests in multiple process.
> > "-j" mode is optional, and works with all existing test selection mechanism, as
> > well as "-v", "-l" etc.
> >
> > In "-j" mode, main process use UDS to communicate to each forked worker,
> > commanding it to run tests and collect logs. After all tests are
> > finished, a summary is printed. main process use multiple competing
> > threads to dispatch work to worker, trying to keep them all busy.
> >
> > The test status will be printed as soon as it is finished, if there are error
> > logs, it will be printed after the final summary line.
> >
> > By specifying "--debug", additional debug information on server/worker
> > communication will be printed.
> >
> > Example output:
> >   > ./test_progs -n 15-20 -j
> >   [   12.801730] bpf_testmod: loading out-of-tree module taints kernel.
> >   Launching 8 workers.
> >   #20 btf_split:OK
> >   #16 btf_endian:OK
> >   #18 btf_module:OK
> >   #17 btf_map_in_map:OK
> >   #19 btf_skc_cls_ingress:OK
> >   #15 btf_dump:OK
> >   Summary: 6/20 PASSED, 0 SKIPPED, 0 FAILED
> >
> > Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> > ---
>
> A bit late to review this, sorry. I'm still looking through the code,
> but decided to try it out locally first. And here's what I got
> immediately running in QEMU:
>
> [vmuser@archvm bpf]$ time sudo ./test_progs -t core
> #32 core_autosize:OK
> #33 core_extern:OK
> #34 core_read_macros:OK
> #35 core_reloc:OK
> #36 core_retro:OK
> Summary: 5/107 PASSED, 0 SKIPPED, 0 FAILED
>
> real    0m0.927s
> user    0m0.197s
> sys     0m0.103s
> [vmuser@archvm bpf]$ time sudo ./test_progs -t core -j
> Launching 8 workers.
> #34 core_read_macros:OK
> #32 core_autosize:OK
> #36 core_retro:OK
> #33 core_extern:OK
> #35 core_reloc:OK
> Summary: 5/107 PASSED, 0 SKIPPED, 0 FAILED
>
> real    0m20.048s
> user    0m0.194s
> sys     0m0.183s
>
>
> So, first, "Launching 8 workers." should be only displayed with --debug, no?
>
> But most importantly, why does the parallel version take 20 seconds?..
> Please take a look, something is not right.

Running full run:

Summary: 176/972 PASSED, 4 SKIPPED, 2 FAILED

All error logs:
test_cg_storage_multi:PASS:cg-create-parent 0 nsec
test_cg_storage_multi:PASS:cg-create-child 0 nsec
test_egress_only:PASS:skel-load 0 nsec
test_egress_only:PASS:parent-cg-attach 0 nsec
test_egress_only:PASS:first-connect-send 0 nsec
test_egress_only:PASS:first-invoke 0 nsec
assert_storage:PASS:map-lookup 0 nsec
assert_storage:PASS:assert-storage 0 nsec
assert_storage_noexist:PASS:map-lookup 0 nsec
assert_storage_noexist:PASS:map-lookup 0 nsec
test_egress_only:PASS:child-cg-attach 0 nsec
test_egress_only:PASS:second-connect-send 0 nsec
test_egress_only:PASS:second-invoke 0 nsec
assert_storage:PASS:map-lookup 0 nsec
assert_storage:PASS:assert-storage 0 nsec
assert_storage:PASS:map-lookup 0 nsec
assert_storage:PASS:assert-storage 0 nsec
#28/1 cg_storage_multi/egress_only:OK
test_isolated:PASS:skel-load 0 nsec
test_isolated:PASS:parent-egress1-cg-attach 0 nsec
test_isolated:PASS:parent-egress2-cg-attach 0 nsec
test_isolated:PASS:parent-ingress-cg-attach 0 nsec
test_isolated:PASS:first-connect-send 0 nsec
test_isolated:FAIL:first-invoke invocations=2#28/2
cg_storage_multi/isolated:FAIL
test_shared:PASS:skel-load 0 nsec
test_shared:PASS:parent-egress1-cg-attach 0 nsec
test_shared:PASS:parent-egress2-cg-attach 0 nsec
test_shared:PASS:parent-ingress-cg-attach 0 nsec
test_shared:PASS:first-connect-send 0 nsec
test_shared:PASS:first-invoke 0 nsec
assert_storage:PASS:map-lookup 0 nsec
assert_storage:PASS:assert-storage 0 nsec
assert_storage_noexist:PASS:map-lookup 0 nsec
assert_storage_noexist:PASS:map-lookup 0 nsec
test_shared:PASS:child-egress1-cg-attach 0 nsec
test_shared:PASS:child-egress2-cg-attach 0 nsec
test_shared:PASS:child-ingress-cg-attach 0 nsec
test_shared:PASS:second-connect-send 0 nsec
test_shared:PASS:second-invoke 0 nsec
assert_storage:PASS:map-lookup 0 nsec
assert_storage:PASS:assert-storage 0 nsec
assert_storage:PASS:map-lookup 0 nsec
assert_storage:PASS:assert-storage 0 nsec
#28/3 cg_storage_multi/shared:OK
#28 cg_storage_multi:FAIL

real    1m0.057s
user    0m4.167s
sys     0m40.824s


Running in sequential mode, I got this timing:

real    1m10.007s
user    0m3.910s
sys     0m37.004s

So not much speed up, unfortunately. I assumed it's bpf_verif_scale
test (which we will break up to parallelize it better). So I re-ran
with it blacklisted, let's see how it did:

Summary: 175/949 PASSED, 4 SKIPPED, 1 FAILED

All error logs:
libbpf: elf: skipping unrecognized data section(7) .rodata.str1.1
test_snprintf_btf:PASS:skel_open 0 nsec
test_snprintf_btf:PASS:skel_load 0 nsec
test_snprintf_btf:PASS:skel_attach 0 nsec
test_snprintf_btf:PASS:system 0 nsec
test_snprintf_btf:PASS:bpf_snprintf_ret 0 nsec
test_snprintf_btf:PASS:check if subtests ran 0 nsec
test_snprintf_btf:FAIL:check all subtests ran only ran 1535 of 1431 tests
#116 snprintf_btf:FAIL

real    0m40.041s
user    0m4.212s
sys     0m7.966s

Note how cg_storage_multi didn't fail this time, but snprintf_btf did.
I think we'll need to audit selftests some more to see which ones are
not filtering by pid and make some system-wide modifications, those
would need to be adapted or marked as serial. We probably don't need
to do it in this first patch set, but definitely would have to do it
before we can start using this parallel mode for real both for local
development and in CI. For now let's concentrate on runner's
correctness (e.g., those 20 seconds don't seem right at all).

But getting back to my comparison, running all but bpf_verif_scale
test sequentially:

Summary: 176/949 PASSED, 5 SKIPPED, 0 FAILED

real    0m39.343s
user    0m3.857s
sys     0m6.509s

It is actually faster to run sequentially... Any idea what might be
going on here?

>
> >  tools/testing/selftests/bpf/test_progs.c | 577 +++++++++++++++++++++--
> >  tools/testing/selftests/bpf/test_progs.h |  36 +-
> >  2 files changed, 581 insertions(+), 32 deletions(-)
> >
>
> [...]
