Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79B22CD426
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 12:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgLCLBw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 06:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgLCLBw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 06:01:52 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0415C061A4D
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 03:01:05 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id s30so2095727lfc.4
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 03:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t+eE9aWxl9DC6BeOTq5gz+fyVY8oHctDFz4ZZqdfk6g=;
        b=WNSLZsxQymJL8gf5VlHIYPkb8QVz1sD/pR6jfNDlWMnwjHVydFa+lt5C4qrTyw4doJ
         HCVO3SjydUYzVzcIrFhHPr9vBIir8vLWJo9r5wuLhLFtVUoOW1Caoc61v5UQvEBb4HVd
         uFFPD1miaIYcX4DYBfyCGWFw1qpEVi/xjT0qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+eE9aWxl9DC6BeOTq5gz+fyVY8oHctDFz4ZZqdfk6g=;
        b=lNieGwQRCu6HRVqCbMdvBeXSACuWpZbaIORskpYhjiA4WWw0aU8s+v6oBWYct1aLbd
         BHj6++1Yr9BKEjW16sg2fTOcLxITvxNwXZ9yiWRVJ4HPQ7mglW3y0C5U2Bu23dZTNboP
         z2IlwR3kRCU+iPitX96dlJ20mlDSvZDQOgbZLraX6/BzyjcUu8KlTLiGaH9C9NnqU8R6
         IvZjgxVurH829g4ZErMR6fgLLbPAo+6JzNWHd2LYKewlMlH/joV6ur8PL2fyi+mMnnwd
         o+x18l9f+iTZyDw2ABzIyINTf99JqKRdeHRWfyOVqLJfiO3JFMZAe1hutIK1k1mqKUQv
         ndcQ==
X-Gm-Message-State: AOAM532mE9Vp6IjJBWJts3DZogvDGP2GQLZUFN+1owe981asbQglybpr
        7QDZu8+EiinCal76RxK7hbt4D0cOrKrDoRM8UvEqVg==
X-Google-Smtp-Source: ABdhPJwhjNznQHE9x6LdqnxOhqCTuaB9qu0uXzV1TOA3PbaPr7XmvTuveKXprYe/r87X4OvYoktlfWXqKXQi67BVSfg=
X-Received: by 2002:ac2:5475:: with SMTP id e21mr1133234lfn.153.1606993264127;
 Thu, 03 Dec 2020 03:01:04 -0800 (PST)
MIME-Version: 1.0
References: <20201203005807.486320-1-kpsingh@chromium.org> <CAEf4BzZd8PYW1SxAVmYA7XBOGhfj4RWPndvKcUJsvSiRquFG+g@mail.gmail.com>
In-Reply-To: <CAEf4BzZd8PYW1SxAVmYA7XBOGhfj4RWPndvKcUJsvSiRquFG+g@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 3 Dec 2020 12:00:53 +0100
Message-ID: <CACYkzJ4ewmvxtoFkdjpW8HwxJ7Fu4hR=sBPtpv06cpA0pCRS6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] Fixes for ima selftest
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 3, 2020 at 6:44 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Dec 2, 2020 at 4:58 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > # v2 -> v3
> >
> > * Added missing tags.
> > * Indentation fixes + some other fixes suggested by Andrii.
> > * Re-indent file to tabs.
> >
> > # What?
> >
> > * Fixes to work in busybox shell (tested on the one used by BPF CI).
> > * Ensure that securityfs is mounted before updating the ima policy
> > * Add missing config deps.
> >
>
> KP, please take a look at other cover letters to get a better idea of
> how they usually look like. It has to be a human-readable overview of
> why the patch set was posted and what problem it is solving. List of
> action items without any context is not the best format.

Sure, I thought the individual commit messages were sufficient context
but I can add a better one here.

>
> >
> > KP Singh (4):
> >   selftests/bpf: Update ima_setup.sh for busybox
> >   selftests/bpf: Ensure securityfs mount before writing ima policy
> >   selftests/bpf: Add config dependency on BLK_DEV_LOOP
> >   selftests/bpf: Indent ima_setup.sh with tabs.
> >
> >  tools/testing/selftests/bpf/config       |   1 +
> >  tools/testing/selftests/bpf/ima_setup.sh | 107 +++++++++++++----------
> >  2 files changed, 64 insertions(+), 44 deletions(-)
> >
> > --
> > 2.29.2.576.ga3fc446d84-goog
> >
