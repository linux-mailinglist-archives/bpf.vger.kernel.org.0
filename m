Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268D223191F
	for <lists+bpf@lfdr.de>; Wed, 29 Jul 2020 07:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgG2FbF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jul 2020 01:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgG2FbF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jul 2020 01:31:05 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD730C0619D2
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 22:31:03 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id s21so18325288ilk.5
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 22:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Et7Gk+oJKljNUOrUbGAQumTT+x8ql2dWyipgLq8/2GI=;
        b=ALm3rPLhiSqHXloqZe+uPT8y62eQszaZ2XdLNAMrXoynlEZa4GLLYGxOmsgZd/FORj
         fVakKZZcqYuN1kUKzk40aWH5KQmi3dW/N5I9DjqBlP3MYlU1D1qYTlFYt8Ezrurdwx5y
         nO6Z2e1Zde2Lmh+1ygL/CLCYpcUTaAt3a6KhLCkc/SWYujfjHhgUV8KHGUzQATtjINBC
         WrnnyxYP6KWKu4fVlTEfTpIc7yS36CB0WM+2Z2kqk4cRoLgbvmG80dniAvcHhx1zL6Mx
         y+rOUXx40VXtH5w00jZfLDVDM3v8XkY/4j2J3yloJMzineKhH62ZIOGnaKQpxLD7njpD
         6+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Et7Gk+oJKljNUOrUbGAQumTT+x8ql2dWyipgLq8/2GI=;
        b=LDWmTG/XNsskgzgjnZG9Z8QwZV77pnSBiI4iDtkk+S50Z91R5y+WSYL1uLZLzkZCUO
         cLERjUCRwZfw74v+h42D39QE65R6zwZ6fSGRWgNH6jkJowzBPVNuoVP+U0YJwoVfYBaE
         UJ151uLj27vMBsialWAHVPWWh6JQF0OQYGUTMjDtTm8r+FToM/sgVgos9C7UO5s9VLRx
         /TvSrNE+opmluvSzotxd2l/puJSMRFE2DQ3E9XOOXwnjgaQJgaZ+Z4xj8SKNF8DYdt3/
         BYDLyfX6DaNXUOm+lcLEGBrkwPQ25HN9ks61xrGkLZkWA3y6XMUalj+8T19qM6EnUBaR
         jEbA==
X-Gm-Message-State: AOAM533/1Rod2HflTYNOD/7yocIHeKON27VAXRvupHbUH5q14AoDyaOO
        9Np3esC+4Jvjm0w6Y99oeakK7iQP2wWcWoTq/x78kQ==
X-Google-Smtp-Source: ABdhPJxzD8UzjAv+imlR9swtdZ/CebagbB1BILLEeQLk99r2KDclllBXhExc2Ehz9FeeAwbY73tyc2rI6volt1jg38s=
X-Received: by 2002:a05:6e02:eb3:: with SMTP id u19mr33722390ilj.130.1596000662935;
 Tue, 28 Jul 2020 22:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200729045056.3363921-1-andriin@fb.com>
In-Reply-To: <20200729045056.3363921-1-andriin@fb.com>
From:   YiFei Zhu <zhuyifei@google.com>
Date:   Wed, 29 Jul 2020 00:30:52 -0500
Message-ID: <CAA-VZPnQ36VyK-qEhQXhuyNGBkFqpuM4NMSifix3wfm-CpV=tw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: don't destroy failed link
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 28, 2020 at 11:51 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> Check that link is NULL or proper pointer before invoking bpf_link__destroy().
> Not doing this causes crash in test_progs, when cg_storage_multi selftest
> fails.
>
> Cc: YiFei Zhu <zhuyifei@google.com>
> Fixes: 3573f384014f ("selftests/bpf: Test CGROUP_STORAGE behavior on shared egress + ingress")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  .../bpf/prog_tests/cg_storage_multi.c         | 42 ++++++++++++-------
>  1 file changed, 28 insertions(+), 14 deletions(-)
>

Awesome! Thanks for the fix. I did not realize the return was a -errno
rather than NULL like open_and_load.
