Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607372737A8
	for <lists+bpf@lfdr.de>; Tue, 22 Sep 2020 02:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgIVArw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Sep 2020 20:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgIVArw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 20:47:52 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8293FC061755;
        Mon, 21 Sep 2020 17:47:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id bw23so657226pjb.2;
        Mon, 21 Sep 2020 17:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dk2JCJ2SZ6GpJYMoGzni/oIIYiDZY1ODRMoXVmzNZcQ=;
        b=QoYPjLe/QzifVjP9iVSdsQqMOwCPQDJnLzm84s1PK7djJkuJAlInR+whcSRHmf8dtl
         9u3rTD9YqtwOjBYxtogsR84NYmTolHxp6V0DXGlbx4YVs6YeAxLgL8pYjJXjgJT6WbYP
         wi7jruk4eCPvjBvyClbVUiA/k14PGgvpgzqzlfmEiGLKukwWeIWs6f+tDOYGD95ep2bn
         gK6I/+JnpJ17J+YNgIEcUvg97LbTqa1ab0d2l7WXSM4IGbtbchGeVg6l/RaO2HBD7NCn
         vbZ8CUXi81QTMQ190hHaShg3CCkcpRFaUoVlKxbDK9n4FL9pKT4fwqLJTtOeE8l9cfRP
         uvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dk2JCJ2SZ6GpJYMoGzni/oIIYiDZY1ODRMoXVmzNZcQ=;
        b=n19XVuJizgoGnPOqGmvro1FFn6AyUaQnniBNYfjp9h6VkYwFOpmws7dh8Fc0JjSelI
         IcaH8t4/kUBAQsLhU91NEYcEVYlsdzC3kVUsHd7247OzLjEMnIeXWMnnDDQdkkUl8V4p
         NCNjXSzPYGQNv2/8sH7pVV9bPHlMU5gGMyhQx6MIPHpiqPtyIbJmsZ9e8RIVw6dgPgnL
         waFzW37DNImwgCHGHb8cG9IToml3CCSmmk27yvGy5CWgbtUbk5dilCUchkxf+ne6slfJ
         TJ+uNyDIhcYbcCh44wHTqUsoBxSbBmWqG8OLf0tjo6qq7VS8Xv8uxhxBCk/8FVedlzle
         mTdw==
X-Gm-Message-State: AOAM530yByyZXgoTpsCwuiyfsKXsKnjnvou7Dxp+3SpwX/MauPdmIDpu
        MlGD33Ck9UUPW/BNw69EnWPKsM/3vw/Foo5uJo3BdbA+51OaWg==
X-Google-Smtp-Source: ABdhPJzLzwKoj33tYKE3Itz57p2WN73YOZdlgQ5pGlnh8VT2soITudx2eqBBtaTpt0lLo1CaOlFiuWyfu2copHBeHcQ=
X-Received: by 2002:a17:90b:3252:: with SMTP id jy18mr1563061pjb.1.1600735671956;
 Mon, 21 Sep 2020 17:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600661418.git.yifeifz2@illinois.edu> <6af89348c08a4820039e614a090d35aa1583acff.1600661419.git.yifeifz2@illinois.edu>
 <CAG48ez0OqZavgm0BkGjCAJUr5UfRgbeCbmLOZFJ=Rj46COcN3Q@mail.gmail.com>
 <CABqSeAQhVFeG1Frvu60XfUnRQ78YRS2Uaw1EsBobKVku-vVoDQ@mail.gmail.com> <CAG48ez1YWz9cnp08UZgeieYRhHdqh-ch7aNwc4JRBnGyrmgfMg@mail.gmail.com>
In-Reply-To: <CAG48ez1YWz9cnp08UZgeieYRhHdqh-ch7aNwc4JRBnGyrmgfMg@mail.gmail.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Mon, 21 Sep 2020 19:47:40 -0500
Message-ID: <CABqSeARpj-wRzS_bbfeD8=6LOQ64mdQR6DS5O2fSmCDTduFLGg@mail.gmail.com>
Subject: Re: [RFC PATCH seccomp 1/2] seccomp/cache: Add "emulator" to check if
 filter is arg-dependent
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
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

On Mon, Sep 21, 2020 at 7:26 PM Jann Horn <jannh@google.com> wrote:
> > In the initial RFC patch I only added to x86. I could add it to any
> > arch that has seccomp filters. Though, I'm wondering, why is SECCOMP
> > in the arch-specific Kconfigs?
>
> Ugh, yeah, the existing code is already bad... as far as I can tell,
> SECCOMP shouldn't be there, and instead the arch-specific Kconfig
> should define something like HAVE_ARCH_SECCOMP and then arch/Kconfig
> would define SECCOMP and let it depend on HAVE_ARCH_SECCOMP. It's
> really gross how the SECCOMP config description has been copypasted
> into a dozen different Kconfig files; and looking around a bit, you
> can actually see that e.g. s390 has an utterly outdated help text
> which still claims that seccomp is controlled via the ancient
> "/proc/<pid>/seccomp". I guess this very nicely illustrates why
> putting such options into arch-specific Kconfig is a bad idea. :P

Ah, time to fix this then.

YiFei Zhu
