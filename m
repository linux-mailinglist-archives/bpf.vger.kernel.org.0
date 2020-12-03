Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96ED22CCEC5
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 06:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgLCFor (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 00:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgLCFor (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 00:44:47 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F45FC061A4E
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 21:44:07 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id r127so940243yba.10
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 21:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/WdVpiyRnHOoNEXreSa41Wxs7aji4Z/L/kLnKrQiPc=;
        b=rmIWPo96LkoyxSHSVADU5P4KndQgbnUNiAU+jG/Q3m7rahukU65VGn5Tc05FqLcSuP
         lD4j5z3u+GNu8GzNhbf1mp0eJNhIDDopFN7JSRe1bV1LDZuqRD/ihoSxC7ojuvDn5q1H
         KQBnGWTyMepnYnqd3SkFmaeKNUfzaCBBrBDlubGZC5bWHzHZnT3ULuAheFuleGiBq9jw
         uzby6bfdJVskEWdr4MILo/p7QqfYt8iu5fuwb2hDc99bMbTUMD7tMTERS6PBI35hhYrm
         SrpRySdRBCvY01BClbHAX1UEKrSBivYDNcKihZQJmpIqCpzUB6NRGlxZRS6A2byCXc2U
         AKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/WdVpiyRnHOoNEXreSa41Wxs7aji4Z/L/kLnKrQiPc=;
        b=IC3VH3O1clvfue0c+I8RcD3i3MOzFNpUE84k0JQuUQtENP9wZdYTWUkE/w11qKr6r7
         ex6d5ULDsQuh0dHJm6QjiBzGfZbzF0iHr9+p2kZmXAaW4wzxVDpXXNrgpFhrY3TfpZQg
         jJPhzo4M3XBwvZx3dQGuE50Bb282pEvP0jYm3roqzSn8xLvubwwxb3fEdU4eaQZEgnUL
         lVWmoXBTXs0HwMqyrKDMDP49UrEcLIvu3aBdWUY4dueYyJQ004vukSRMfzIm7B9cYiH5
         5GjVJYDzundKu31tKRRqUEwOnpRifWVZ8wIbsMxnNaUi0dR2u4p71XHATWijchehqFCV
         +w3w==
X-Gm-Message-State: AOAM530LAWLL5CqKH1bHiNF2iIHoLgz1GH2ZffmwboeyPQu3wx1lEEgC
        qvnzOgid0eYIutNIW3h/UBgC96wE+4jTDMZOTvAcF+x8AuM=
X-Google-Smtp-Source: ABdhPJyvWX3u+M9W8GFg4EQE4FlnFSjTc1v3VN7Rxw0EdlD7dJnLegASgPTW7Mt9IX3NZNH3GznBoM2fhpcuLWQwK9Q=
X-Received: by 2002:a25:c7c6:: with SMTP id w189mr2248144ybe.403.1606974246436;
 Wed, 02 Dec 2020 21:44:06 -0800 (PST)
MIME-Version: 1.0
References: <20201203005807.486320-1-kpsingh@chromium.org>
In-Reply-To: <20201203005807.486320-1-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Dec 2020 21:43:55 -0800
Message-ID: <CAEf4BzZd8PYW1SxAVmYA7XBOGhfj4RWPndvKcUJsvSiRquFG+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] Fixes for ima selftest
To:     KP Singh <kpsingh@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 2, 2020 at 4:58 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> # v2 -> v3
>
> * Added missing tags.
> * Indentation fixes + some other fixes suggested by Andrii.
> * Re-indent file to tabs.
>
> # What?
>
> * Fixes to work in busybox shell (tested on the one used by BPF CI).
> * Ensure that securityfs is mounted before updating the ima policy
> * Add missing config deps.
>

KP, please take a look at other cover letters to get a better idea of
how they usually look like. It has to be a human-readable overview of
why the patch set was posted and what problem it is solving. List of
action items without any context is not the best format.

>
> KP Singh (4):
>   selftests/bpf: Update ima_setup.sh for busybox
>   selftests/bpf: Ensure securityfs mount before writing ima policy
>   selftests/bpf: Add config dependency on BLK_DEV_LOOP
>   selftests/bpf: Indent ima_setup.sh with tabs.
>
>  tools/testing/selftests/bpf/config       |   1 +
>  tools/testing/selftests/bpf/ima_setup.sh | 107 +++++++++++++----------
>  2 files changed, 64 insertions(+), 44 deletions(-)
>
> --
> 2.29.2.576.ga3fc446d84-goog
>
