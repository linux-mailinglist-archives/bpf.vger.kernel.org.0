Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E462B542E
	for <lists+bpf@lfdr.de>; Mon, 16 Nov 2020 23:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgKPWQM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 17:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgKPWQM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Nov 2020 17:16:12 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08546C0613D2
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 14:16:12 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id p12so21924597ljc.9
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 14:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iF9pv4yrV71gAZ7pO+xa+oOM736e/dHlJRDoOYN7BR4=;
        b=SAXvYD6FrqsuD5DpNnkQhTSzDKmNP1Sh38hp3dJSoWvquXLZ9X6xzr2FaysmQoh1H8
         Mu8JA5m8dnSCLh5avzm9QMivhW01tjdrEVuwqCzQiDmNKrvCbwE4Gk7Qben/Btt1sMzM
         HeQv91ZaP57NbJZQ1izw2X/HW2YXwDZfu1AO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iF9pv4yrV71gAZ7pO+xa+oOM736e/dHlJRDoOYN7BR4=;
        b=acFqzQ3wAkFdUS21dsrlzyuw1NApp14ZuS67Ejx8hTkqCtAZxO7f666gW0naLDUINs
         jk0OOdBHT+zxGeHhRDGln2q3aw+PSJJThT+6czaTv3QjqQVyH9UTTO9EFyYPPfkV0ZfV
         ijk4D52THEZcrHVMrfqMtA42GvN1W7Mn1+VOnIgGbg1oL/BpzEOUhm0Y/VPeOprZfySR
         gmx8rxiS0TomkbbGoQhWsxI74+6DQ7E+nOhuUMj9ijl6/YwZjdlUrbdjzG+T/LU/fKkJ
         INPeMaNqDE7uXwOsgmA78utQpY8TPAnMTFj2qa8yLKAql+FqymhYDwanmpkl7h59MSbH
         AYqg==
X-Gm-Message-State: AOAM532h5AOVD3B5riMTEnJmUySo2lw+7HW8a4l/Ubh94mxXKd62NC9l
        bW5BsTpiBxoDrmJnV5cKEp0oGt7lA7Mt5w==
X-Google-Smtp-Source: ABdhPJwt03oxOCPqYKEFihGWphMIltfoSDa/rVQu24kxb3BwOOgWhBhz5Z3o50YB4eRY3joQE/9Vxg==
X-Received: by 2002:a2e:a0c2:: with SMTP id f2mr554720ljm.431.1605564969711;
        Mon, 16 Nov 2020 14:16:09 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id p1sm2873642ljn.72.2020.11.16.14.16.08
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 14:16:08 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id x9so21938391ljc.7
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 14:16:08 -0800 (PST)
X-Received: by 2002:a2e:a375:: with SMTP id i21mr498450ljn.421.1605564967930;
 Mon, 16 Nov 2020 14:16:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605560917.git.dxu@dxuuu.xyz> <470ffc3c76414443fc359b884080a5394dcccec3.1605560917.git.dxu@dxuuu.xyz>
In-Reply-To: <470ffc3c76414443fc359b884080a5394dcccec3.1605560917.git.dxu@dxuuu.xyz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Nov 2020 14:15:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wggUw3XYffJ-od8Dbfh-JkXkEuCPjSRR2Z+8HrNUNxJ=g@mail.gmail.com>
Message-ID: <CAHk-=wggUw3XYffJ-od8Dbfh-JkXkEuCPjSRR2Z+8HrNUNxJ=g@mail.gmail.com>
Subject: Re: [PATCH bpf v6 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, andrii.nakryiko@gmail.com,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 16, 2020 at 1:17 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Based on on-list discussion and some off-list discussion with Alexei,
> I'd like to propose the v4-style patch without the `(*out & ~mask)`
> bit.

So I've verified that at least on x86-64, this doesn't really make
code generation any worse, and I'm ok with the patch from that
standpoint.

However, this was not what the discussion actually amended at as far
as I'm concerned.

I mentioned that if BPF cares about the bytes past the end of the
string, I want a *BIG COMMENT* about it. Yes, in strncpy_from_user()
itself, but even more in the place that cares.

And no, that does not mean bpf_probe_read_user_str().  That function
clearly doesn't care at all, and doesn't access anything past the end
of the string. I want a comment in whatever code that accesses past
the end of the string.

And your ABI point is actively misleading:

> We can't really zero out the rest of the buffer due to ABI issues.
> The bpf docs state for bpf_probe_read_user_str():
>
> > In case the string length is smaller than *size*, the target is not
> > padded with further NUL bytes.

This comment is actively wrong and misleading.

The code (after the patch) clearly *does* pad a bit with "further NUL
bytes". It's just that it doesn't pad all the way to the end.

Where is the actual buffer zeroing done?

Because without the buffer zeroing, this whole patch is completely
pointless. Which is why I want that comment, and I want a pointer to
where that zeroing is done.

Really. You have two cases:

 (a) the buffer isn't zeroed before the strncpy_from_user()

 (b) the buffer is guaranteed to be zero before that

and in case (a), this patch is pointless, since the data after the
string is already undefined.

And in case (b), I want to see a comment and a pointer to the code
that actually does the zeroing.

HOWEVER. Look at bpf_probe_read_user_str_common(), and notice how it
ALREADY does the zeroing of the buffer past the end, it's just that it
only does it in the error case.

Why do you send this patch, instead of

 (a) get rid of the pointless pre-zeroing

 (b) change bpf_probe_read_user_str_common() to do

        int ret;
        u32 offset;

        ret = strncpy_from_user_nofault(dst, unsafe_ptr, size);
        offset = ret < 0 ? 0 : ret;
        memset(dst+offset, 0, size-offset);
        return ret;

which seems to be much simpler anyway. The comment you quote about
"target is not padded with further NUL bytes" is clearly wrong anyway,
since that error case *does* pad the target with NUL bytes, and always
has.

So honestly, in this whole discussion, it seems rather clear to me
that the bug has always been in bpf, not in strncpy_from_user(). The
ABI comment you quote is clearly not true, and I can point to that
existing bpf_probe_read_user_str_common() code itself:

        ret = strncpy_from_user_nofault(dst, unsafe_ptr, size);
        if (unlikely(ret < 0))
                memset(dst, 0, size);

as to why that is.

But guys, as mentioned, I'm willing to apply this patch, but only if
you add some actually *correct* comments about the odd bpf use of this
string, and point to where the pre-zeroing is done.

               Linus
