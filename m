Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39F62C2FF5
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 19:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388355AbgKXSaL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 13:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbgKXSaK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 13:30:10 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43A8C0613D6
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 10:30:08 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id t13so20247486ilp.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2020 10:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/AqBW4sAhXGtIMlQOJltBNPTEwqG7wHl5NCen13tto=;
        b=Gl9TWDPX3OhKm2lUrGgdws+BNxYczHqtlN6jFqHtXWobvz5VOOMXXAxINsZA4HM0y1
         ai+Bk8aQAdrvnbqI4hel+UwfAK+5aU7tpfAouW/vkFfdIWgV9YWLJYZymblMsNafzxXY
         VkstOY6wPt4glldZWicFMED+1lKAJeWf/BkNeKVHz6dzIl7+Hj6otkzygFhGkRGqgM6x
         q+q18VYesmsshD6hCuOdvdma7r4axxS2HLGOYDs+qjTBP19CIAXMEmT+UGEUfTdlerQv
         ZsmRnJ38aVcbsvmiodL22a4l4VxAhXrhTlGf1MaczYlnuIBbhLSrNX94xi2FYMCT3Jzs
         GAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/AqBW4sAhXGtIMlQOJltBNPTEwqG7wHl5NCen13tto=;
        b=pAA+pO5FhbWERKOVjykOWc7McNA0zkpnGBlEZ1fTVdElb9/yL2T7/tGH3mq42qsXjU
         OmDmKvL6hm1rSEYRebBcBJv3xaEas9O+hMYaGvOlesyvFw1pbHJqEh5gLTsQg+xrvsH6
         oInk7hNjzaJ6gjCev0tisyxksYTsXNeSgHEZjCcKCpcGLBMiBQpToIhQjkKA3HMFdLwI
         fgwdQ/XDxrKzI1tl+fFDNjjcGpYaxhSPZ/hOULptEOrZnt9wDnZNfRRCXN/i985Szoil
         p3QqMs2GQhwivbeem341bMHG49idYsFQI5LP5paT+tuH3LOIWWxEreYwHpqpURsQRDvL
         Jr2w==
X-Gm-Message-State: AOAM533RNNN0cfD33jXR0NgWUle9qloOu9J0Kiv6vbGo09vxtviZjTk0
        OyEoRzvy1JTY9BY5UDyPYVCuS8hBlcLbR1AXX4N6vc6dxkb7RA==
X-Google-Smtp-Source: ABdhPJwpXL48v1yNkcEom0iU1xBi52Br9DsTKPUo8uSnLwufTAEq3CSuTcTYYHyNbHP0s+KF3gIvC7MvTH5VJO4uOuU=
X-Received: by 2002:a92:7006:: with SMTP id l6mr5363405ilc.157.1606242608083;
 Tue, 24 Nov 2020 10:30:08 -0800 (PST)
MIME-Version: 1.0
References: <20201122022205.57229-1-andreimatei1@gmail.com>
 <20201122022205.57229-2-andreimatei1@gmail.com> <dbb95d56-0700-c8b6-1f6b-d632144075bb@fb.com>
In-Reply-To: <dbb95d56-0700-c8b6-1f6b-d632144075bb@fb.com>
From:   Andrei Matei <andreimatei1@gmail.com>
Date:   Tue, 24 Nov 2020 13:29:57 -0500
Message-ID: <CABWLseujFiAtv5fWDwxjL__+6MSxrcYRp9ejkp6dC4=EM1mNQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftest/bpf: fix rst formatting in readme
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yonghong! Thanks for looking at my patch!
This is my first patch to the Linux kernel / first time using an
email-based patch workflow, so I don't know what I'm doing. I hope to
contribute more to BPF in the future, though.

The patches apply fine to me on bpf-next master (am I supposed to be
targeting a different branch?), and I've asked someone else to confirm
too. I've tested with your exact git version. I have a theory about
what might be going wrong for you, see below.

Here's what I'm doing:

# prove I'm on bpf-next master
$ git show | head -n 5
commit 91b2db27d3ff9ad29e8b3108dfbf1e2f49fe9bd3
Author: Song Liu <songliubraving@fb.com>
Date:   Thu Nov 19 16:28:33 2020 -0800

    bpf: Simplify task_file_seq_get_next()

# Download the patches - these are the "raw" links published by
lore.kernel.org for each of the two emails.
$ curl https://lore.kernel.org/bpf/20201122022205.57229-1-andreimatei1@gmail.com/raw
> p1.patch
$ curl https://lore.kernel.org/bpf/20201122022205.57229-2-andreimatei1@gmail.com/raw
> p2.patch
$ git am p1.patch
Applying: selftest/bpf: fix link in readme
$ git am p2.patch
Applying: selftest/bpf: fix rst formatting in readme

So, it all "works for me". The patches were produced with `git
format-patch` and sent with `git send-email`. Please let me know if I
was supposed to do something else.

With the risk of continuing to not know what I'm talking about, I
perhaps have a guess about why the patches don't apply for you: if you
simply copy-pasted the email into your p2.txt, that might not apply
because a space might be lost from the end of one of the one lines
that I'm deleting. The patch has a line that reads: "-This is due to a
llvm BPF backend bug. The fix ". Notice the space at the end of the
line. At least Gmail doesn't render that space, so if I simply
copy-paste the patch from my browser, I end up with a corrupted line
and so it doesn't apply. Perhaps that's your situation?

Thanks Yonghong, I appreciate your time!

- Andrei

On Mon, Nov 23, 2020 at 2:22 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 11/21/20 6:22 PM, Andrei Matei wrote:
> > A couple of places in the readme had invalid rst formatting causing the
> > rendering to be off. This patch fixes them with minimal edits.
> >
> > Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> > ---
> >   tools/testing/selftests/bpf/README.rst | 28 ++++++++++++++------------
> >   1 file changed, 15 insertions(+), 13 deletions(-)
>
> I cannot apply patch #2 with my current bpf-next branch.
>
> -bash-4.4$ git apply ~/p1.txt
> -bash-4.4$ git apply ~/p2.txt
> /home/yhs/p2.txt:34: trailing whitespace.
> __
> https://reviews.llvm.org/D85570
>
> /home/yhs/p2.txt:52: trailing whitespace.
> __
> https://reviews.llvm.org/D78466
>
> /home/yhs/p2.txt:70: trailing whitespace.
> .. _0:
> https://reviews.llvm.org/D74572
>
> /home/yhs/p2.txt:71: trailing whitespace.
> .. _1:
> https://reviews.llvm.org/D74668
>
> /home/yhs/p2.txt:72: trailing whitespace.
> .. _2:
> https://reviews.llvm.org/D85174
>
> error: patch failed: tools/testing/selftests/bpf/README.rst:33
> error: tools/testing/selftests/bpf/README.rst: patch does not apply
> -bash-4.4$ git --version
> git version 2.24.1
> -bash-4.4$
>
> Could you help check what is the issue? Maybe the links are presented
> differently in the patch vs. in the README.rst?
>
> >
> > diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
> > index 3b8d8885892d..ca064180d4d0 100644
> > --- a/tools/testing/selftests/bpf/README.rst
> > +++ b/tools/testing/selftests/bpf/README.rst
> > @@ -33,11 +33,12 @@ The verifier will reject such code with above error.
> >   At insn 18 the r7 is indeed unbounded. The later insn 19 checks the bounds and
> >   the insn 20 undoes map_value addition. It is currently impossible for the
> >   verifier to understand such speculative pointer arithmetic.
> > -Hence
> > -    https://reviews.llvm.org/D85570
> > -addresses it on the compiler side. It was committed on llvm 12.
> > +Hence `this patch`__ addresses it on the compiler side. It was committed on llvm 12.
> > +
> > +__ https://reviews.llvm.org/D85570
> >
> >   The corresponding C code
> > +
> >   .. code-block:: c
> >
> >     for (int i = 0; i < MAX_CGROUPS_PATH_DEPTH; i++) {
> > @@ -80,10 +81,11 @@ The symptom for ``bpf_iter/netlink`` looks like
> >     17: (7b) *(u64 *)(r7 +0) = r2
> >     only read is supported
> >
> > -This is due to a llvm BPF backend bug. The fix
> > -  https://reviews.llvm.org/D78466
> > +This is due to a llvm BPF backend bug. `The fix`__
> >   has been pushed to llvm 10.x release branch and will be
> > -available in 10.0.1. The fix is available in llvm 11.0.0 trunk.
> > +available in 10.0.1. The patch is available in llvm 11.0.0 trunk.
> > +
> > +__  https://reviews.llvm.org/D78466
> >
> >   BPF CO-RE-based tests and Clang version
> >   =======================================
> > @@ -97,11 +99,11 @@ them to Clang/LLVM. These sub-tests are going to be skipped if Clang is too
> >   old to support them, they shouldn't cause build failures or runtime test
> >   failures:
> >
> > -  - __builtin_btf_type_id() ([0], [1], [2]);
> > -  - __builtin_preserve_type_info(), __builtin_preserve_enum_value() ([3], [4]).
> > +- __builtin_btf_type_id() [0_, 1_, 2_];
> > +- __builtin_preserve_type_info(), __builtin_preserve_enum_value() [3_, 4_].
> >
> > -  [0] https://reviews.llvm.org/D74572
> > -  [1] https://reviews.llvm.org/D74668
> > -  [2] https://reviews.llvm.org/D85174
> > -  [3] https://reviews.llvm.org/D83878
> > -  [4] https://reviews.llvm.org/D83242
> > +.. _0: https://reviews.llvm.org/D74572
> > +.. _1: https://reviews.llvm.org/D74668
> > +.. _2: https://reviews.llvm.org/D85174
> > +.. _3: https://reviews.llvm.org/D83878
> > +.. _4: https://reviews.llvm.org/D83242
> >
