Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA2A316FDF
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 20:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbhBJTPz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 14:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbhBJTPt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 14:15:49 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387A0C06174A
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 11:15:09 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id s18so4327953ljg.7
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 11:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=anARlAHL2JoBr5TcGWTFVudAx76YPckhtErsSdISoJA=;
        b=hqMoV0uQfeSm4o0fNe3eWJJ99DR8byhwL5mS97paEQqXshYyUxGfi4oHK3j9K0sR8+
         Egom2O12EgGmAlvVMpyMltiS3je44juNMLIGy6gcfNFAlXZ0tQVxK9Mq403nzh77c54c
         E/Fix8JieeLlAPSbuQ5gj1ttBcajBSGm50XSv81bwAu6Tkr/iNFmI9gWVZaH4cvJ5PL7
         NYmdOKRvrdZJKdk5czZR6UlDXOzOkNRF1Djz/ZeQjAAxYV1qWhl/vsEcDeOTz54e3ZfQ
         dWF2it7M4+0HdL6oakMjRYNt+kmNq5rDwDjQ302Zxt8Jzp81Kg7nS3YzDovOZP81cQ80
         SLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=anARlAHL2JoBr5TcGWTFVudAx76YPckhtErsSdISoJA=;
        b=ZsnsFEGxRwY09zWzQrgJAtX9tdwFIVlWRWdFNk9vFKPU2iJ1JbZcBmiTUUl6EvcFJw
         f2tmFfxl5wpaOD0aMc6qRiD7lXcwEHM8zWtIAVyK7FtzMHyyE5j8m5ZY5EWQ0nQ/PYvT
         /oRCNwd3GeYfhb4+hb3/mGWF34O2hQIRx9/nLzKfeR5CL7aZShgy1g7MG8oGMURI/yjE
         JPMin58JN7k59bS9N4WsvNcSMNHm4CLo/ROFg3MgghWwFrPP8mrPFvnDtlEcJfmVp/aY
         i0i0LuagrJVgLT2v4YLJxMvIQSdsr19PQ53V0DvfVb8G0PHUzNHbSQRJhsi9HecAk5qZ
         QlGQ==
X-Gm-Message-State: AOAM531ATJyhTnjOWU0ODCD9hp1GgfR+y5fyKzpDRAHTUua6qDDuJVs7
        GHnCLxH+ck0uzYzBGurkgM6oZAZoohb2tpfapCY=
X-Google-Smtp-Source: ABdhPJyMVzi60h82l5NYEKIfbLrHpCwOW1WlY4/C/4FbLFosmULxMkPlV/PX2naGoXyrMQLzv0e+/qSi8FxD8i9s5Tk=
X-Received: by 2002:a2e:596:: with SMTP id 144mr2889994ljf.258.1612984507627;
 Wed, 10 Feb 2021 11:15:07 -0800 (PST)
MIME-Version: 1.0
References: <20210207011027.676572-1-andreimatei1@gmail.com>
In-Reply-To: <20210207011027.676572-1-andreimatei1@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 10 Feb 2021 11:14:56 -0800
Message-ID: <CAADnVQLf95h8Wv2tv+e6o9sD25U5skS6RJ=48P+eEyQKamhMkw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] allow variable-offset stack acces
To:     Andrei Matei <andreimatei1@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 6, 2021 at 5:11 PM Andrei Matei <andreimatei1@gmail.com> wrote:
>
> Before this patch, variable offset access to the stack was dissalowed
> for regular instructions, but was allowed for "indirect" accesses (i.e.
> helpers). This patch removes the restriction, allowing reading and
> writing to the stack through stack pointers with variable offsets. This
> makes stack-allocated buffers more usable in programs, and brings stack
> pointers closer to other types of pointers.
>
> The motivation is being able to use stack-allocated buffers for data
> manipulation. When the stack size limit is sufficient, allocating
> buffers on the stack is simpler than per-cpu arrays, or other
> alternatives.
>
> V2 -> V3
>
> - var-offset writes mark all the stack slots in range as initialized, so
>   that future reads are not rejected.
> - rewrote the C test to not use uprobes, as per Andrii's suggestion.
> - addressed other review comments from Alexei.

I've fixed up Andrii's nits in patch 4,
then moved skel__attach after test_pid init and applied to bpf-next.

I've played with a few other ways to do var stack access in C and all
looked good.
Thanks a lot for making the verifier smarter.
