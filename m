Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2BF361F02
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 13:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243007AbhDPLno (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Apr 2021 07:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243050AbhDPLnk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Apr 2021 07:43:40 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7369C061761
        for <bpf@vger.kernel.org>; Fri, 16 Apr 2021 04:43:15 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id 6so22819733ilt.9
        for <bpf@vger.kernel.org>; Fri, 16 Apr 2021 04:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=68NMAA2B4Awwhyw+whUFCT5VDNXIb8+KoAK85427Mt8=;
        b=O8yl1blR6AjwJ5hVDkk4duXLgNFwdzAF82yw4VcaNtfuSp+ZqgZheTkQyGkwyFSt1v
         gN2NDnsHmURMhcIXsgs7ikXRH8VuoGPDBdEGtqOOzc1XNqPQb23e4c2mvHoxPEvF/8vO
         078RJXpDYy7Q4lOwTFVEhfluIMW18lafUAPc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=68NMAA2B4Awwhyw+whUFCT5VDNXIb8+KoAK85427Mt8=;
        b=LW4nNEJey5pnIxw9gILpY224fXIdDWKr9tCQZi72iN3GV/hbgTkLXulmV/H9y2Hfcv
         jVile/yVQdqcfRHnf51M2WNZ5NJlq4WgRoXsJ/xVujSdFYRKVteGfNYog9fTUScOJpRH
         IivKwfkaP2OAvW6TZcm0isli6J+RNeMRnFwmT92K5dPAxScZKWRIWRW/6dM2RdsgaQyA
         z0yP2Xw3f5btKOclnkOYYEqATc/iSIXIF8r97S0rk/eSCbNXwMWdxszHz/CzBoxY/FSU
         NxY0hvdRU+HxCwV8MPGT5tU4Hipi7QU4CsmlprodIEe6qMsKf700LvXdcYfjRC9C8ifY
         4EpA==
X-Gm-Message-State: AOAM533YrjVMWPMTolkz78cePWvIfxi28inAp6aiJ46PKZL7EDFGTXJH
        ORvXakE+s4MP/PgubBdohnOEbsDEBk+axmOfB7/ZLg==
X-Google-Smtp-Source: ABdhPJxiHu7B+35/59i/lpg0Mpcnb2GOQbekTnQ2xxWa22S8mjDn84umuvIYpxVUrADlxGU8lvBWhfgKNDfwhTFqR3g=
X-Received: by 2002:a05:6e02:1caf:: with SMTP id x15mr6807843ill.89.1618573395313;
 Fri, 16 Apr 2021 04:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210414185406.917890-1-revest@chromium.org> <20210414185406.917890-7-revest@chromium.org>
 <CAEf4BzYtOOwDLOGmfQ+pF5t-muDXQB_StFB7SQS6Ap78P5FjQQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYtOOwDLOGmfQ+pF5t-muDXQB_StFB7SQS6Ap78P5FjQQ@mail.gmail.com>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 16 Apr 2021 13:43:04 +0200
Message-ID: <CABRcYm+6TYKhbGZY4y=vdeoG15EVfAPcV-8bo7ugomoNZ6F1tA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 6/6] selftests/bpf: Add a series of tests for bpf_snprintf
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 16, 2021 at 1:20 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 14, 2021 at 11:54 AM Florent Revest <revest@chromium.org> wrote:
> > +/* Loads an eBPF object calling bpf_snprintf with up to 10 characters of fmt */
> > +static int load_single_snprintf(char *fmt)
> > +{
> > +       struct test_snprintf_single *skel;
> > +       int ret;
> > +
> > +       skel = test_snprintf_single__open();
> > +       if (!skel)
> > +               return -EINVAL;
> > +
> > +       memcpy(skel->rodata->fmt, fmt, min(strlen(fmt) + 1, 10));
> > +
> > +       ret = test_snprintf_single__load(skel);
> > +       if (!ret)
> > +               test_snprintf_single__destroy(skel);
>
> destroy unconditionally?

sweet!

> > +void test_snprintf_negative(void)
> > +{
> > +       ASSERT_OK(load_single_snprintf("valid %d"), "valid usage");
> > +
> > +       ASSERT_ERR(load_single_snprintf("0123456789"), "no terminating zero");
> > +       ASSERT_ERR(load_single_snprintf("%d %d"), "too many specifiers");
> > +       ASSERT_ERR(load_single_snprintf("%pi5"), "invalid specifier 1");
> > +       ASSERT_ERR(load_single_snprintf("%a"), "invalid specifier 2");
> > +       ASSERT_ERR(load_single_snprintf("%"), "invalid specifier 3");
> > +       ASSERT_ERR(load_single_snprintf("\x80"), "non ascii character");
> > +       ASSERT_ERR(load_single_snprintf("\x1"), "non printable character");
>
> Some more cases that came up in my mind:
>
> 1. %123987129387192387 -- long and unterminated specified
> 2. similarly %------- or something like that
>
> Do you think they are worth checking?

well, it doesn't hurt :) and it's very easy to add so no problem

> > +++ b/tools/testing/selftests/bpf/progs/test_snprintf_single.c
> > @@ -0,0 +1,20 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2021 Google LLC. */
> > +
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +
> > +// The format string is filled from the userspace side such that loading fails
>
> C++ style format

Oopsie
