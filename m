Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C482B2482
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 20:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgKMTaH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Nov 2020 14:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgKMTaG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Nov 2020 14:30:06 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691F3C0613D1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2020 11:30:06 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id d17so15591410lfq.10
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2020 11:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kSxNzIRXq2hQf++iAIuMzFXpOxmVx5Tx4jehTl6QJNI=;
        b=ZQII+Ulq7va1iJz0uKz+Z7hnZH8qARd99V8Do3e4eotny4nigLldBALMq6FH4lN4Qn
         kL5Ndq56lqCg+PeXvwgLb5ngyslCFgjPXecUcCCmuHrlQTPYkg3DoLeoBR3C56mr3Dny
         tDGvFHyGHz+YvFUfBrXkbhprIdhyLZ97ngD3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kSxNzIRXq2hQf++iAIuMzFXpOxmVx5Tx4jehTl6QJNI=;
        b=RGl7py8aSZrS8GhuWpF1nDg1WlE3MhEjMpJNgdjmMwLJy0ZT9FuzbTCvuo8RUrWLlk
         x+sJeQ4yTCiPNRbV62OVC96q8ams8HXahCZztH6F5W4GNm+T/YbBYFaNwBpxZXHvnWZC
         CVdrS2eQksrQ9UR8oTkWC63cGNooTKgi8i0lXmOQ+VWvE0Gzq20ZDa8/KIQWWNcFOpE4
         SgIBUcKZWfsBL2FcIxtKab/5ytXXAF7MfL9H++wieNHNpEhaIym7lDJGM4lRFhZKRilp
         B9MH5GQ7KZvrWSzV6c5MOb1KrWQoiiRTdgdJFgj9EGv+ssmI4rBZCvA4WRaO5fW0F870
         BY3A==
X-Gm-Message-State: AOAM53256MLiWR6IYAXOWn3+/Kz+WAPEdBrYJi5AmbOo0B6G+W7vN40I
        H0+yIRpet8RNdxiPQ7TTQdloSDqPvIKtOw==
X-Google-Smtp-Source: ABdhPJxLP/tfP8kUTCmfdYjVkp6l7TLfMgFQiep4H5gT3ENA0eLOK2whvQyxHSqvsbbPrxW/LnDIhA==
X-Received: by 2002:a19:a0c:: with SMTP id 12mr1596029lfk.568.1605295804435;
        Fri, 13 Nov 2020 11:30:04 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id m21sm174178ljh.82.2020.11.13.11.30.02
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 11:30:03 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id z21so15591304lfe.12
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2020 11:30:02 -0800 (PST)
X-Received: by 2002:a19:f243:: with SMTP id d3mr1336702lfk.534.1605295802640;
 Fri, 13 Nov 2020 11:30:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605134506.git.dxu@dxuuu.xyz> <f5eed57b42cc077d24807fc6f2f7b961d65691e5.1605134506.git.dxu@dxuuu.xyz>
 <20201113170338.3uxdgb4yl55dgto5@ast-mbp> <CAHk-=wjNv9z6-VOFhpYbXb_7ePvsfQnjsH5ipUJJ6_KPe1PWVA@mail.gmail.com>
 <20201113191751.rwgv2gyw5dblhe3j@ast-mbp>
In-Reply-To: <20201113191751.rwgv2gyw5dblhe3j@ast-mbp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Nov 2020 11:29:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgbcq6N_vqGqfy3MVv-6D36M9-iCY0634Sz0xN_vnX+Kg@mail.gmail.com>
Message-ID: <CAHk-=wgbcq6N_vqGqfy3MVv-6D36M9-iCY0634Sz0xN_vnX+Kg@mail.gmail.com>
Subject: Re: [PATCH bpf v5 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 13, 2020 at 11:17 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> You misunderstood.
> BPF side does not depend on zero padding.
> The destination buffer was already initialized with zeros before the call.
> What BPF didn't expect is strncpy_from_user() copying extra garbage after NUL byte.

BPF made the wrong expectation.

Those bytes are not defined, and it's faster the way it is written.

Nobody else cares.

BPF needs to fix it's usage. It really is that simple.

strncpy_from_user() is one of the hottest functions in the whole
kernel (under certain not very uncommon loads), and it's been
optimized for performance.

You told it that the destination buffer was some amount of bytes, and
strncpy_from_user() will use up to that maximum number of bytes.
That's the only guarantee you have - it won't write _past_ the buffer
you gave it.

The fact that you then use the string not as a string, but as
something else, that's why *you* need to change your code.

            Linus
