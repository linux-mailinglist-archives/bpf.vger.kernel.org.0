Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5870D380F77
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 20:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbhENSQ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 May 2021 14:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhENSQ1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 May 2021 14:16:27 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9BAC061574
        for <bpf@vger.kernel.org>; Fri, 14 May 2021 11:15:16 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 82so182721yby.7
        for <bpf@vger.kernel.org>; Fri, 14 May 2021 11:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vzSfB3CMaDM+uZA4Kr2sJY2wyfeoPPUxS644MTZBSYA=;
        b=NlVFqaX2mZrAMl0YjmywH2N05Nse5WdL2mAIo3q1bx7KO3FK4ZGfAOp7WImfsN0Vxi
         grNwWTTKoK1y9YigWfmbVzVF8q00Udhbl/Pl0kt0GvciIcQ6fgiWWKkTdMSlFmcbhF7q
         UsAlO89a9g6A6ewttZ/6vRUJ00WOi9p2le+JSjTmOCPamCYKZIY3zLGrWwVgmVPakaoY
         VLGoDJIEA5emn2zJaBJlAX8Ee+00UwVX6KWioE8DlmpEqDLJwEFmz/V6WpWeqBVr2VbS
         bFWQOKZXiugk+hxuRPu1Lq7lad2qYSyXxsxCSi52xginOHwb7wh1W/aqs0LL7heIlPea
         zzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzSfB3CMaDM+uZA4Kr2sJY2wyfeoPPUxS644MTZBSYA=;
        b=BrPVrI0rO59caliDvyYdOulogU+cP3fraqnqc7ZUkbOIdwDFdZQqa5tm+LJXicJTwu
         EUjii1H+/j0MIAI/07TAgrNzuTIf6ZxbiiqQdzts91xY6jC+9h/QeOZMg9Kaga1E/XvF
         KoeLYk4tO6zO8rXXHEAifGOS1Eg6oGpO5bA/l0qe7gfQK0P6PWM0Tb+8T3LjB/EEgUOk
         ht9jYSh7F4lTAeFz4o5JWfRzsSR6CcFLU5UBfLpp2ybcuDjI9G//1bUg13pcPam2Fs7g
         8zfGCu7NaPt3kFtFYsunh5DTLTXjrMInxH1oYLJE56Fb+8vUeGQFtDzxqPK92y91CRYN
         7hrw==
X-Gm-Message-State: AOAM531s20xF+UxZWszl0uk5uf4MNI7vlo39pzu1S06F1cHF1AyV4bqp
        //FlAi5TN7bHodW/bmcSGFLfP2po9iIffo/Pr9s=
X-Google-Smtp-Source: ABdhPJwOLMDT1kAz90r0Y4mLil3yCGCdhlhad1uWEsKyAe2+HBnEIL+FcqbRhYM3N0lO4Sz95VJFMGSQPxKs/QPdUaE=
X-Received: by 2002:a25:ba06:: with SMTP id t6mr62833563ybg.459.1621016115586;
 Fri, 14 May 2021 11:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com> <20210514003623.28033-21-alexei.starovoitov@gmail.com>
In-Reply-To: <20210514003623.28033-21-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 14 May 2021 11:15:04 -0700
Message-ID: <CAEf4BzY1CVt=hu0_ehazh=XVMtyijyZsLAoDNFfqQ+XCirRPkQ@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 20/21] selftests/bpf: Convert test printk to
 use rodata.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 13, 2021 at 5:37 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Convert test trace_printk to more aggressively validate and use rodata.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/prog_tests/trace_printk.c | 3 +++
>  tools/testing/selftests/bpf/progs/trace_printk.c      | 6 +++---
>  2 files changed, 6 insertions(+), 3 deletions(-)
>

[...]
