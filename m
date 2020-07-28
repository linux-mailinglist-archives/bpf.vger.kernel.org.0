Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B30230190
	for <lists+bpf@lfdr.de>; Tue, 28 Jul 2020 07:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgG1FPY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 01:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgG1FPY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jul 2020 01:15:24 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5D5C061794
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2020 22:15:24 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l64so10787150qkb.8
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2020 22:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+9MHK95XvFIIi5VsSDsCTxDbAbcs6bPPGtZ11sgwh0=;
        b=fv37iyIDuz3Ris3M9HRmXV+mVN+IChEFzap0B0cJUKB3CH6xtblxkTmCUHKk1r2rBK
         LU0YxoulAtg72s3dR/2MxCga1pvftWUe73vtm0Uzme8bdhvWh/UG3Sws/gcR4lHDYJQt
         GNX+l/XP7PxBajLKKIToic1HNsXdMYEaiux+Rz5hfaaE/KUKY1uzS9oyf7sGUkWmGsu+
         eprR68tffq/n0izcIN0Jbo8Zs4oZjL/jBPlNFfxXqtmOjXdtfc6rTOD6vOdV5ElRJhIm
         STg4+KXi02gVDjvNy3XlraTH4J0cupFlpiFlPbknZPFpDH3wQNrjZ3FrNL3HXEf6jkoB
         24RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+9MHK95XvFIIi5VsSDsCTxDbAbcs6bPPGtZ11sgwh0=;
        b=ovj9PS3JaZSWh/gMi3DG8DfeeLlxtoSW8hXnhPJJSXpLzQd3W3BnMSFjqaogKnPIyx
         ieiKs9qxAvSJf5h2K1A1qU330M38glPB16CYtfdz0gTOieB86KlSRwdkmf2j3qcTWz0x
         JjAUTW3S3qmriao6vkHm8qzOYqT3eqb136LPpaGm5M63/ybkpquomcFKiQo7Fcm3oaF3
         KPC0hf26CSko1aYaCEY6O+0ajktOSqA1D7YiGTIcU8sZi8a+wML6K/D0kg615OdDats9
         YRcfsU/5CbgkrwWuQl/0M6KSokjTsHSbFkYfdaU4TWFEGT4vlpwJamJ1o1FYvWTy8UqC
         Dq/w==
X-Gm-Message-State: AOAM531sh0huwnE/kPF91T4ccESth2rqvLu+VS78A39dwkfj3ytblxs2
        MoyUozGFJ7OUslcdncFiimR9m1xfTKRJN1IcEp8=
X-Google-Smtp-Source: ABdhPJyqFCMtRIVuery6DBh3jy73yN13X3zIlac1N8LcQfozc9GJCzOz7aHytHNRJt74uaB45YdbR/BQazE1VrjS3dA=
X-Received: by 2002:a05:620a:4c:: with SMTP id t12mr513794qkt.449.1595913323290;
 Mon, 27 Jul 2020 22:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <xunyft9i1olx.fsf@redhat.com>
In-Reply-To: <xunyft9i1olx.fsf@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Jul 2020 22:15:12 -0700
Message-ID: <CAEf4BzZGUB5oqmFnV8Xmw+hXGr3fxRno0nkOuG+f5b9vNhbEHQ@mail.gmail.com>
Subject: Re: selftests: bpf: mmap question
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Jiri Olsa <jolsa@redhat.com>, Jiri Benc <jbenc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 23, 2020 at 4:02 AM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> Hi!
>
> I have a question about the part of the test:
>

[...]

>
> In my configuration the first mapping
>
>         /* map all but last page: pages 1-3 mapped */
>         tmp1 = mmap(NULL, 3 * page_size, PROT_READ, MAP_SHARED,
>                           data_map_fd, 0);
>
>
> maps the area to the 3 pages right before the TLS page.
> I find it's pretty ok.

Hm... I never ran into this problem. The point here is to be able to
re-mmap partial ranges. One way would be to re-write all those
manipulations to start with a full range map, and then do partial
un-mmaps/re-mmaps, eventually just re-mmaping everything back. I think
that would work, right, as long as we never unmmap the last page? Do
you mind trying to fix the test in such a fashion?

>
> But then the 4 page mapping
>
>         /* re-map all 4 pages */
>         tmp2 = mmap(tmp1, 4 * page_size, PROT_READ, MAP_SHARED | MAP_FIXED,
>                     data_map_fd, 0);
>
>
> since it has MAP_FIXED flag, unmaps TLS and maps the former TLS
> address BPF map.
>
> Which is again exactly the behaviour of MAP_FIXED, but it breaks
> the test.
>
> Using MAP_FIXED_NOREPLACE fails the check:
>
> CHECK(tmp1 != tmp2, "adv_mmap6", "tmp1: %p, tmp2: %p\n", tmp1, tmp2);
>
> as expected.
>
>
> Should the test be modified to be a bit more relaxed? Since the
> kernel behaviour looks correct or I'm missing something?
>
>
> PS: BTW, the previous data_map mapping left unmmaped. Is it expected?

Not intentional, the idea is that each test exits with a clean state.

>
> --
> WBR,
> Yauheni Kaliuta
>
