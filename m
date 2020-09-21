Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DEC273601
	for <lists+bpf@lfdr.de>; Tue, 22 Sep 2020 00:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgIUWvH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 18:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbgIUWvH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 18:51:07 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A65BC061755;
        Mon, 21 Sep 2020 15:51:07 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u3so513310pjr.3;
        Mon, 21 Sep 2020 15:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vGTBAGvWDFjbodpOJVDhuski4CeBWH0Uvr/+Kwfo5Oo=;
        b=QUzlApk96W2T2IaCs5WGQXm3ZTGAUMjBN/NJE6GKiP7ihH3Ebqvf1sHDE9qe4eUNlB
         tcBhVT3a9ZWJQvvKj20pUNmbF66KiPV+zPIn9Dd4lQLRM2xnQDH+SAkD5dugk079Dxdd
         DAsPEvRmAKxUcH/DWv5tqex3OSuRmnqd8/JaS18pmiTNeigKozmXI8D0cTk144lI/9QZ
         WCQCyMawJHanLv7XM+51axli469ZW0hFiWgZHdyfJGksgGrmtJ5rAUkCNGnWCbBzxxQN
         yH4Dm7doaWUhWhrbFqrbPgSS4pe2eiq/nbqCWensqlbCjVNAuzGC3mD6iot+s4WjMKVT
         sY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGTBAGvWDFjbodpOJVDhuski4CeBWH0Uvr/+Kwfo5Oo=;
        b=iCwjd8G/XOXR6fZu6e+R8mJBb1DpfFf5G5tBT1CcBK2r5ZWK834E4z8Cry1/h07Xp1
         T/lbaJF4pw0x66L2TfIqe5NQp6cNNNcVxQLMFuTRhJGbBxC/auHGdpakSYmjaegZSBo1
         LfkLdYwvTTKsc7IRZBfVT1izty9WuX3t6OB2z+8Dy+Cf4QozUKXe5HXbbhjkpc/PsFBB
         49us/ljN5Jyzh1wkCAzUcxKR446u2JQNkjApXfpIe+JaJaRngc2PZd9cDBAuCUpWYaxJ
         +FafbHVBtZNchO83oeZGe///yq56yUDulX7C7lG0LwsJmvNvGXtyNJq/rxRs1rgysVhk
         edow==
X-Gm-Message-State: AOAM531Jc/Y4lXcmOVL3PpxLnOZ4IVtqW5/F4Yjfd5eEq9e72B8Q/MrG
        pxiQd2wn8ZLWr6aIVszyxEJlZ0SE24G4IbVOe75oxzGwsTDLGA==
X-Google-Smtp-Source: ABdhPJwIh4TG2lZRhS3+puFxuT098Mmba2FlJSMwTw8F7EzbCgRWoakQWoggppEyR++U27sLmfWb4dSxPkRHVJRWJEg=
X-Received: by 2002:a17:90b:4b82:: with SMTP id lr2mr1303431pjb.184.1600728666628;
 Mon, 21 Sep 2020 15:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600661418.git.yifeifz2@illinois.edu> <b792335294ee5598d0fb42702a49becbce2f925f.1600661419.git.yifeifz2@illinois.edu>
 <CAG48ez3k0_7Vev_O=uV_WVuUGK6BPA0RyrYXMYSDV4DTMMe26g@mail.gmail.com>
In-Reply-To: <CAG48ez3k0_7Vev_O=uV_WVuUGK6BPA0RyrYXMYSDV4DTMMe26g@mail.gmail.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Mon, 21 Sep 2020 17:50:55 -0500
Message-ID: <CABqSeAROcwq0ZGzWaxyPm+LDHu6T_8CD7_1c-hdhaMikr_ECCA@mail.gmail.com>
Subject: Re: [RFC PATCH seccomp 2/2] seccomp/cache: Cache filter results that
 allow syscalls
To:     Jann Horn <jannh@google.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Valentin Rothberg <vrothber@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 21, 2020 at 1:09 PM Jann Horn <jannh@google.com> wrote:
>
> On Mon, Sep 21, 2020 at 7:35 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> [...]
> > We do this by creating a per-task bitmap of permitted syscalls.
> > If seccomp filter is invoked we check if it is cached and if so
> > directly return allow. Else we call into the cBPF filter, and if
> > the result is an allow then we cache the results.
>
> What? Why? We already have code to statically evaluate the filter for
> all syscall numbers. We should be using the results of that instead of
> re-running the filter and separately caching the results.
>
> > The cache is per-task
>
> Please don't. The static results are per-filter, so the bitmask(s)
> should also be per-filter and immutable.

I do agree that an immutable bitmask is faster and easier to reason
about its correctness. However, I did not find the "code to statically
evaluate the filter for all syscall numbers" while reading seccomp.c.
Would you give me a pointer to that and I will see how to best make
use of it?

YiFei Zhu
