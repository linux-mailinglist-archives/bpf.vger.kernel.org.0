Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8EC2B2528
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 21:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgKMULS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Nov 2020 15:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgKMULS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Nov 2020 15:11:18 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CA8C0617A6
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2020 12:11:17 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id u19so9565540lfr.7
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2020 12:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bt9Ua8vaHCsnEec5qJVZpjsiJsbIoJubKs0EkxVSvXM=;
        b=UH4Ns0j3oz/U0Q/AWcISzh4FonO68SG6sdYoa7oIq9ACsV0mNmUawKpbctSaNQiYBc
         zpxN3i5S8qCvA7QJJmm87ul6PZNM7hr/C/GB3bjcMVBipYLYZfPaPVHizyldBazkY/67
         U5jlKI/ZFc9jk0znAMbqDY1ctQ8bMnKCvR9sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bt9Ua8vaHCsnEec5qJVZpjsiJsbIoJubKs0EkxVSvXM=;
        b=jvtTvlQ/HbKehhDo3zPphUpD5jnVoC0tvqx6ECRDEPDNtfH3tPMo4zy9ZhbriM+cNz
         hPy5SteJGNek1DamW9tUUPi41nkAJIfhKBeQ4fPKngFb9oR1Y1fEA4YyzS4T5+ySs2Zg
         4c4kcmB/9fd+XBJ5kMR1BH1iMzarGQr5lKmvGKRNXUDFQTGd4XsXjiWEOazrZzWc2kgl
         BvYiJnGsHBkLXL6+zbSIa2DeJX12VIW/s3wkiqdhj3kYUnqy6rtvodEwN4o04StS9vJm
         raqtsHe+SrGu+wx918DTd3BGat0QjVt6+0BANdJWMCTEQ3I+hiKfmLG/CWvKXXARd8eH
         nmyg==
X-Gm-Message-State: AOAM531660zFW61ffAkAX/n5+tzCYYWKfpDm5xnnQBpF1noNkDt84q0z
        uT38wDrmTQ4ErDnMhF7C32169nZTASRUWg==
X-Google-Smtp-Source: ABdhPJwtrIHgymIUyBPjXg06/UyHw0wyOYXEJh7XYYYEMwUGqBHtxS6jZa7hiUiKE+AMyny9yQQMWA==
X-Received: by 2002:a19:c1c5:: with SMTP id r188mr1701178lff.354.1605298275386;
        Fri, 13 Nov 2020 12:11:15 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id w28sm1759549ljd.48.2020.11.13.12.11.14
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 12:11:14 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id 74so15812007lfo.5
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2020 12:11:14 -0800 (PST)
X-Received: by 2002:a19:8544:: with SMTP id h65mr1589302lfd.344.1605298273562;
 Fri, 13 Nov 2020 12:11:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605134506.git.dxu@dxuuu.xyz> <f5eed57b42cc077d24807fc6f2f7b961d65691e5.1605134506.git.dxu@dxuuu.xyz>
 <20201113170338.3uxdgb4yl55dgto5@ast-mbp> <CAHk-=wjNv9z6-VOFhpYbXb_7ePvsfQnjsH5ipUJJ6_KPe1PWVA@mail.gmail.com>
 <20201113191751.rwgv2gyw5dblhe3j@ast-mbp>
In-Reply-To: <20201113191751.rwgv2gyw5dblhe3j@ast-mbp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Nov 2020 12:10:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=whpsK0s8x51rE8fUSfr4r783j09BSqXqi95uHc0WKG7ig@mail.gmail.com>
Message-ID: <CAHk-=whpsK0s8x51rE8fUSfr4r783j09BSqXqi95uHc0WKG7ig@mail.gmail.com>
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
> The v4 approach preserves performance. It wasn't switching to byte_at_a_time:

That v4 looks better, but still pointless.

But it might be acceptable, with that final

        *out = (*out & ~mask) | (c & mask);

just replaced with

        *out = c & mask;

which still writes past the end, but now it only writes zeroes.

But the only reason for that to be done is if you have exposed the
destination buffer to another thread before (and you zeroed it before
exposing it), and you want to make sure that any concurrent reader can
never see anything past the end of the string.

Again - the *only* case that could possibly matter is when you
pre-zeroed the buffer, because if you didn't, then a concurrent reader
would see random garbage *anyway*, particularly since there is no SMP
memory ordering imposed with the strncpy. So nothing but "pre-zeroed"
makes any possible sense, which means that the whole "(*out & ~mask)"
in that v4 patch is completely and utterly meaningless. There's
absolutely zero reason to try to preserve any old data.

In other words, you have two cases:

 (a) no threaded and unlocked accesses to the resulting string

 (b) you _do_ have concurrent threaded accesses to the string and no
locking (really? That's seriously questionable),

If you have case (a), then the only correct thing to do is to
explicitly pad afterwards. It's optimal, and doesn't make any
assumptions about implementation of strncpy_from_user().

If you really have that case (b), and you absolutely require that the
filling be done without exposing any temporary garbage, and thus the
"pad afterwards" doesn't work, then you are doing something seriously
odd.

But in that seriously odd (b) case, the _only_ possibly valid thing
you can do is to pre-zero the buffer, since strncpy_from_user()
doesn't even imply any memory ordering in its accesses, so any
concurrent reader by definition will see a randomly ordered partial
string being copied. That strikes me as completely insane, but at
least a careful reader could see a valid partial string being possibly
in the process of being built up. But again, that use-case is only
possible if the buffer is pre-zeroed, so doing that "(*out & ~mask)"
cannot be relevant or sane.

If you really do have that (b) case, then I'd accept that modified v4
patch, together with an absolutely *huge* comment both in
strncpy_from_user() and very much at the call-site, talking about that
non-locked concurrent access to the destination buffer.

            Linus
