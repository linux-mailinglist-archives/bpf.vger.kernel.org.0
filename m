Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5154210033
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 00:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgF3Ws5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 18:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgF3Ws4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 18:48:56 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38713C03E97A
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 15:48:56 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e22so17799538edq.8
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 15:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3xaSnjPwOz/gfRv2/K99Xg/qf7pM+PnO4Lm4xuaoC0=;
        b=ASbXZJLtG8XUPSKV+h/SVuJS8yIbMCdkYnwmz9GVGBHSAM+DAluDsY/UItNHh5PPjN
         ojeIFIQdrQrB5TO+YJ4T17S3IX4uNxtZRu3ECARMr+8G3RfHGY0MFD8NQQoegMH9WYgw
         DplT/XHY6xm7t+KEUlRVK5cBeygKp2aVxTDa84GvXZysfxGk/Hd43n9zJJmazHKD3iF7
         MSte5VrVqWlbM/EjzGkN8q90OIsCct0GzstiUZJV+IHJlsi4kupmFdqViSPPqCacYpia
         CJDgVFsqebVGLJTdh2JQ2zFzHI2FGtHwawNpHLQReD555gWw11/dCwr4oRXqFYgLWD0/
         0J0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3xaSnjPwOz/gfRv2/K99Xg/qf7pM+PnO4Lm4xuaoC0=;
        b=VRRllrjT5d9JxURoOjbN82KnRgL/Sa5PCz8Qtc0tRYPVL9wan/VOa9Dp1Pq4YkL+ZW
         Y3a56WSMvpiAzINr5aLc47S/ytEkY85IvwU4mEQrJ5YArMsTDAZqCGgWUsoYEwnj6tzq
         cTRc+5Fgu+ZJILujgbPQot7iWTtMDonXgoKcM6bFTBBDwqJdmz+1gbkvYszlGRh7qxXP
         sx3W+8m4IVi0J1si5ycjDKly0nSKL8iQf0YqPn6sGo3xsbT8RLv4M4jjr1h+29ta9bnz
         H7xF7HaJd9J+uYVc0m/qRVJGDEgQnu/SECESjRnq5LCtY+kutbFkaDmbtkbz14K2bDAN
         wr3Q==
X-Gm-Message-State: AOAM532lUDH0LCfzIAHUfKFoDKuWMBt8bmWY80dDCDQa9nsXAXATs+kH
        BqQoUrklU2ZlfGB4u8UHxMLY+Zpjv1Q4QdS+IfJgyQ==
X-Google-Smtp-Source: ABdhPJwdBVIhV+aZ5jKNHZ7ssWSX+SueBydRHGEF9sWtuWG2VuYiEFyUS9TQX3p7Jbl+uP6IBTsIxp0Q6Z8QAuI+cho=
X-Received: by 2002:aa7:d5cd:: with SMTP id d13mr691466eds.370.1593557334562;
 Tue, 30 Jun 2020 15:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200630184922.455439-1-haoluo@google.com> <49df8306-ecc7-b979-d887-b023275e4842@fb.com>
In-Reply-To: <49df8306-ecc7-b979-d887-b023275e4842@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 30 Jun 2020 15:48:43 -0700
Message-ID: <CA+khW7iJu2tzcz36XzL6gBq4poq+5Qt0vbrmPRdYuvC-c5U4_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Switch test_vmlinux to use hrtimer_range_start_ns.
To:     Yonghong Song <yhs@fb.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Stanislav Fomichev <sdf@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 30, 2020 at 1:37 PM Yonghong Song <yhs@fb.com> wrote:
>
> On 6/30/20 11:49 AM, Hao Luo wrote:
> > The test_vmlinux test uses hrtimer_nanosleep as hook to test tracing
> > programs. But it seems Clang may have done an aggressive optimization,
> > causing fentry and kprobe to not hook on this function properly on a
> > Clang build kernel.
>
> Could you explain why it does not on clang built kernel? How did you
> build the kernel? Did you use [thin]lto?
>
> hrtimer_nanosleep is a global function who is called in several
> different files. I am curious how clang optimization can make
> function disappear, or make its function signature change, or
> rename the function?
>

Yonghong,

We didn't enable LTO. It also puzzled me. But I can confirm those
fentry/kprobe test failures via many different experiments I've done.
After talking to my colleague on kernel compiling tools (Bill, cc'ed),
we suspected this could be because of clang's aggressive inlining. We
also noticed that all the callsites of hrtimer_nanosleep() are tail
calls.

For a better explanation, I can reach out to the people who are more
familiar to clang in the compiler team to see if they have any
insights. This may not be of high priority for them though.

Hao
