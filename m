Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1F72F70EC
	for <lists+bpf@lfdr.de>; Fri, 15 Jan 2021 04:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbhAODYZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jan 2021 22:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbhAODYZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jan 2021 22:24:25 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE59BC061575;
        Thu, 14 Jan 2021 19:23:44 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o17so11192810lfg.4;
        Thu, 14 Jan 2021 19:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8bof/9UT0KgyjHC36RQ3/jNqdyR1Op8Ft0YEcB0dzb8=;
        b=saGWmQcv7f4npbnhTNj89g/8kMaCmow5jNC6kG6vY7q0X7VjkQ28fjpeAQF+xjL8cK
         XqPetTGA44jcNTZMTA58sxbVMYQO20r2RZmGTb58yE1zF33Soz3is0FT8Vz+TPzUyBeZ
         aAWI/8qgRoOqCP0aJqhtjFVrl2EhiW4erVYlH9LoywQOabwaHrmaJHWzI/Judp0LEUCO
         T5FAMuD/Mm+GsjJ0XlkRcvU80I+e/WTzhFyaOLbn2GKEMTq7xhBqFDt0AEneyuSFvYDB
         g8SlKsRwbrgEjfBxnHZcU3OjmG7l5nM3s6oZfRrpByux6xGIa7Y+Zdxu383NSet8efnZ
         Wrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bof/9UT0KgyjHC36RQ3/jNqdyR1Op8Ft0YEcB0dzb8=;
        b=h24OkO7Obj0gfPoik3CpN12fD+Ei3QSMspS+SVOzCu7cqyQaI1oqgSMU7aC04sD5k6
         ZOwOULwqxK5Vgx8gaKdjeAxxohNibUvF9Jq9e5gtok+gJ6oiq0zuOtrshmONo3EOuypE
         wh7hihJ02OFcLNpeLmwNAC8hi4BanbNmoXK0467qaKke/cUkV+JR/2wUbVdmI6dOVnOm
         cjljU7YSidDbagswgghpZjPzHiFqnJo+h+oaA6P4sNxY0LLZZpk2g0D/MtkiW/hoPXSU
         mYfApH0KwjU4ibou6iSSWTegkZrCCxVetrCdfnlsiy0yPc06OPVidLgZx0w8SsxFH5e2
         lEng==
X-Gm-Message-State: AOAM530BvPGFqeeW4DchNx0dLEQXSq08YjuB2U7CaVuLI0BwLNcxNdUW
        kj/1f8Iho9sim+34j78bgwizkNw0sREHlF7txpg=
X-Google-Smtp-Source: ABdhPJwLtb8FK71GrQRyVoDSXloI3NLRe5oRlaoEK+WgSH5AKXF2H9nzJfX70g53mufw/iNddSvd9VJsnStxB5c1evw=
X-Received: by 2002:ac2:5b1e:: with SMTP id v30mr5088387lfn.540.1610681023413;
 Thu, 14 Jan 2021 19:23:43 -0800 (PST)
MIME-Version: 1.0
References: <20210114181751.768687-1-jackmanb@google.com>
In-Reply-To: <20210114181751.768687-1-jackmanb@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 14 Jan 2021 19:23:32 -0800
Message-ID: <CAADnVQJVvwoZsE1K+6qRxzF7+6CvZNzygnoBW9tZNWJELk5c=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 00/11] Atomics for eBPF
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 14, 2021 at 10:18 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> There's still one unresolved review comment from John[3] which I
> will resolve with a followup patch.
>
> Differences from v6->v7 [1]:
>
> * Fixed riscv build error detected by 0-day robot.

Applied.
Thanks a lot.

Please address John's request in a followup and these few issues:

- rst doesn't look correct. Example:
rst2man Documentation/networking/filter.rst >/dev/null
Documentation/networking/filter.rst:1053: (WARNING/2) Inline emphasis
start-string without end-string.

> Except ``BPF_ADD`` _without_ ``BPF_FETCH`` (for legacy reasons), all 4 byte
> atomic operations require alu32 mode. Clang enables this mode by default in
> architecture v3 (``-mcpu=v3``). For older versions it can be enabled with
> ``-Xclang -target-feature -Xclang +alu32``.

It reads confusing to me.
I would rephrase 'clang enables this mode by default' into
'clang can generate new atomic instruction when -mcpu=v3 is enabled'.

'For older versions...'
This part I didn't get. The users need clang 12 that is capable to
emit these insns.
What 'older versions' you're talking about?
