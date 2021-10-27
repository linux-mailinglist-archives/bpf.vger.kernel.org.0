Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83F043D188
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 21:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhJ0TVD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 15:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbhJ0TVD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 15:21:03 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D09C061570
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 12:18:37 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 67so8976822yba.6
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 12:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uETzpBA8PZoLei1fQ7oi05fN3pocnVw68btTzvkglCQ=;
        b=KnA8XflOicYjP3zpIza6VHtJl+Da3vFwz42GiFmf3I3+muvdL1HSonzTZmzuvWfwLb
         bGSz7R3v4BjjtxhOxp0Fwp8G4XkHN59r6KQ6lfMR0Qhv9tc3pr5SllEzoiXvUwEJv6E9
         ZK+CaNaOKwxk6t5sEPtq5SIRdqeh4pH7NEhqGx3ww0KssOfXpxHPaDtQ1DwaIfil1noo
         5NuGo95nOkc3dROizQyzv8p7gf6Z8MvspuR/Fs7ngtUOHDGWimcHJjZ9qDEVO8otnnQX
         Z+55KgbC0CpsQzFgUk64VHwkUDQ7wvqhT8TjPraWMKqbNe3FQkodQdU/6leRjL09AUsg
         SL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uETzpBA8PZoLei1fQ7oi05fN3pocnVw68btTzvkglCQ=;
        b=a738xL+9p4S3zfqvYmQvcTYn0jqhFBZpylN9BqY27sDPjUx2kVZjF2hmDCn3o5x1zj
         +sOfaf8RVay7J4Tn5Bo+AaHKbF8rp9YKBYUx7nThmwbywOm/oBEYEFBc5iWOPjn0lZbR
         8xfpbyasQMDJ0QXyJkTvwAaPPtemS72BqKmzxgwd0w6iLsSH8nB+Z2Y3t3DKcViamPj5
         DXaYtEyJ8rEAPyhGzaLzwaKqhDt3v2UMA0UxnV5rCl9fnSgOZ4vrRy667GsbeQnZg6Z/
         4PtDGs+v21swYRgpr++2qe8PUVOEHjzKkltONznE5vXjBj6IId66QSuIWgIyq2pKwluo
         U8sQ==
X-Gm-Message-State: AOAM533mJEL6Vt+Ts/THl0TZRwVYPvTNpYOspJXYbZGoA4MQtAac1yNg
        gL+lhEskaPkbo3oCaugnxJBNn2kOSXsTno8bAFWah9eEcm4=
X-Google-Smtp-Source: ABdhPJxSBLPEJHZWo/+XAVaiNjqTPhyou/qb3ySlEahRa6SbTAMXgu0FeE7d6Ou0eF5qR6dmEQ5TSsNzfsSCy1EUvJo=
X-Received: by 2002:a25:e7d7:: with SMTP id e206mr30643212ybh.267.1635362316797;
 Wed, 27 Oct 2021 12:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211025223345.2136168-1-fallentree@fb.com>
In-Reply-To: <20211025223345.2136168-1-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 27 Oct 2021 12:18:25 -0700
Message-ID: <CAEf4BzYVKYsSszWO56CTww-ZPsrsaVHwkS+4idiOpDek57RjYQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: parallel mode improvement
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 3:33 PM Yucong Sun <fallentree@fb.com> wrote:
>
> Several patches to improve parallel execution mode, including printing
> subtest status line, updating vmtest.sh and fixed two previously dropped
> patch according to feedback.
>

I've dropped the second patch and applied all the rest. I can run
`sudo ./test_progs -j` pretty reliably with no failures now and get
30-35 second saving on average. Thanks.

Let's keep discussing the subtest support separately.

>
> Yucong Sun (4):
>   selfetests/bpf: Update vmtest.sh defaults
>   selftests/bpf: print subtest status line
>   selftests/bpf: fix attach_probe in parallel mode
>   selftests/bpf: adding a namespace reset for tc_redirect
>
>  .../selftests/bpf/prog_tests/attach_probe.c   |  9 ++-
>  .../selftests/bpf/prog_tests/tc_redirect.c    | 14 +++++
>  tools/testing/selftests/bpf/test_progs.c      | 56 +++++++++++++++----
>  tools/testing/selftests/bpf/test_progs.h      |  4 ++
>  tools/testing/selftests/bpf/vmtest.sh         |  6 +-
>  5 files changed, 74 insertions(+), 15 deletions(-)
>
> --
> 2.30.2
>
