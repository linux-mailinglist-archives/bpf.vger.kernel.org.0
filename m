Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4ED2B25FF
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 21:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgKMU5u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Nov 2020 15:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgKMU5u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Nov 2020 15:57:50 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF9DC0613D1;
        Fri, 13 Nov 2020 12:57:50 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f27so8086113pgl.1;
        Fri, 13 Nov 2020 12:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FgWxfNiEokEKcqiZexiTUyWqEBjXLDpHDhFaTerpeLM=;
        b=L7iDid+ml1x6JuRpMAJ0opv4OYgSpDSo04+w5K3Oo9fVhIWrDEnC5jdfD6Ha2Ifnh3
         Fr+opMUb2Z5GMu39jk14FaHiJAz+wD3sHK0Csd/GlDXLW1jU16F6wwt5evx99aFcFB71
         nPU+ojgVOd94FZM6499zxp7ly0ICwAG0elDVt7QxpzwKkK6pk31Mm7Dst4HcI7QRNvoE
         KWAAr7PeDCBfki3tVEH+iY1pQrmbg2TJolSUC9coXF3iauXvMzRbY5zA0YktHIOxiYdY
         0W6zQof01Q0orY80AjOV39BwMCFUZ6SZsOtJnT5PedIc65tsDr0MfaYt6fqCpmYWW15Y
         s3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FgWxfNiEokEKcqiZexiTUyWqEBjXLDpHDhFaTerpeLM=;
        b=JsDKKJ6/rDT1rJvEkfyerVU6f8b86sL+XW0UmpL9SKr4uUHnKXW+72r/eZDSBPOehE
         cKYd2sW30dw53cmOnDtVqXlh7lEsXeEgxEQ6TyEqd9YBlu93jhljozzZ3d/7kue+nifp
         jOL8o9JL5ZcJ3KOjVe7HDgIUdLNTpOXazp8XH9gTMhmdoeZpCDgBp3G721yO07q5MbHm
         6h01mQK9DR3CyqNqMnOdl4aruyKvygjHIJiJDKcQhsEHF1Zdm21gnDlGr18+CegR0JQl
         q/ex0SlJrsOr9NDChs194rXGGYqrxNiZuaww3N+mPn8eFRvkXzP7PYc3biGSIgq/j+Zg
         RqNg==
X-Gm-Message-State: AOAM533GVLNci6MFf8gmUBYWGGewq/RMCbIQ9FTrBACmXbPjNk4idyix
        qdlY+JIDzDUybRMPxeBE2qc=
X-Google-Smtp-Source: ABdhPJyDZ8tVJOdwlyzl0+arxSRYLknTUJFnk6OpCGx4ILbmzm4vZDubbTCPx09gjARu0PbXtA9PvQ==
X-Received: by 2002:a17:90a:62c4:: with SMTP id k4mr4972437pjs.32.1605301069878;
        Fri, 13 Nov 2020 12:57:49 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:b8c0])
        by smtp.gmail.com with ESMTPSA id s6sm11205666pfh.9.2020.11.13.12.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 12:57:49 -0800 (PST)
Date:   Fri, 13 Nov 2020 12:57:46 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf v5 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
Message-ID: <20201113205746.htvdzudtqrw6h7oa@ast-mbp>
References: <cover.1605134506.git.dxu@dxuuu.xyz>
 <f5eed57b42cc077d24807fc6f2f7b961d65691e5.1605134506.git.dxu@dxuuu.xyz>
 <20201113170338.3uxdgb4yl55dgto5@ast-mbp>
 <CAHk-=wjNv9z6-VOFhpYbXb_7ePvsfQnjsH5ipUJJ6_KPe1PWVA@mail.gmail.com>
 <20201113191751.rwgv2gyw5dblhe3j@ast-mbp>
 <CAHk-=whpsK0s8x51rE8fUSfr4r783j09BSqXqi95uHc0WKG7ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whpsK0s8x51rE8fUSfr4r783j09BSqXqi95uHc0WKG7ig@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 13, 2020 at 12:10:57PM -0800, Linus Torvalds wrote:
> On Fri, Nov 13, 2020 at 11:17 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > The v4 approach preserves performance. It wasn't switching to byte_at_a_time:
> 
> That v4 looks better, but still pointless.
> 
> But it might be acceptable, with that final
> 
>         *out = (*out & ~mask) | (c & mask);
> 
> just replaced with
> 
>         *out = c & mask;
> 
> which still writes past the end, but now it only writes zeroes.
> 
> But the only reason for that to be done is if you have exposed the
> destination buffer to another thread before (and you zeroed it before
> exposing it), and you want to make sure that any concurrent reader can
> never see anything past the end of the string.
> 
> Again - the *only* case that could possibly matter is when you
> pre-zeroed the buffer, because if you didn't, then a concurrent reader
> would see random garbage *anyway*, particularly since there is no SMP
> memory ordering imposed with the strncpy. So nothing but "pre-zeroed"
> makes any possible sense, which means that the whole "(*out & ~mask)"
> in that v4 patch is completely and utterly meaningless. There's
> absolutely zero reason to try to preserve any old data.
> 
> In other words, you have two cases:
> 
>  (a) no threaded and unlocked accesses to the resulting string
> 
>  (b) you _do_ have concurrent threaded accesses to the string and no
> locking (really? That's seriously questionable),
> 
> If you have case (a), then the only correct thing to do is to
> explicitly pad afterwards. It's optimal, and doesn't make any
> assumptions about implementation of strncpy_from_user().

(a) is the only case.
There is no concurrent access to dest.
Theoretically it's possible for two bpf progs on different cpus
to write into the same dest, but it's completely racy and buggy
for other reasons.

I've looked through most of the kernel code where strncpy_from_user()
is used and couldn't find a case where dest is not used as a string.
In particular I was worried about the code like:

struct foo {
  ...
  char name[64];
  ...
} *f;

f = kcalloc();
...
ret = strncpy_from_user(f->name, user_addr, sizeof(f->name));
if (ret <= 0)
   goto ...;
f->name[ret] = 0;

and then the whole *f would be passed to a hash function
that will go over the sizeof(struct foo) assuming
that strncpy_from_user() didn't add the garbage.
The extra zeroing:
f->name[ret] = 0;
didn't save it from the garbage in the "name".

I can convince myself that your new definition of strncpy_from_user:
"
You told it that the destination buffer was some amount of bytes, and
strncpy_from_user() will use up to that maximum number of bytes.
That's the only guarantee you have - it won't write _past_ the buffer
you gave it.
"
makes sense from the performance point of view.

But I think if glibc's strncpy() did something like this it would
probably caused a lot of pain for user space.

The hash element example above is typical bpf usage.
One real bpf prog was converted as a test:
tools/testing/selftests/bpf/progs/pyperf.h
There it's populating:
typedef struct {
        char name[FUNCTION_NAME_LEN];
        char file[FILE_NAME_LEN];
} Symbol;
with two calls:
bpf_probe_read_user_str(&symbol->name, sizeof(symbol->name),
                        frame->co_name + pidData->offsets.String_data);
These are the function name inside python interpreter.
The 'len' result is ignored by bpf prog.
And later the whole 'Symbol' is passed into a hash map.

The kernel code doesn't seem to be doing anything like this, so
it's fine to adopt your definition of strncpy_from_user().

The garbage copying part can be cleared on bpf side.
It's easy enough to do in bpf_probe_read_user_str().
We can just zero up to sizeof(long) bytes there.
