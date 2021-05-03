Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802F3371FBB
	for <lists+bpf@lfdr.de>; Mon,  3 May 2021 20:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhECSdX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 May 2021 14:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhECSdX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 May 2021 14:33:23 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F549C06174A
        for <bpf@vger.kernel.org>; Mon,  3 May 2021 11:32:30 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id c21so3428444vso.11
        for <bpf@vger.kernel.org>; Mon, 03 May 2021 11:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mZsVH8c1ULmh9A6fIZSk90445YhCsqKHAHjLolpcKs4=;
        b=sFMhdBMu4R09OuhTJtZfnkaivbmZA9321E+Lg72Wlaavq+ONw5kgEBtXWoIVSESS0o
         DDA8nJwdGzJjc0vOWeMKnG9sc3xhPDEGBVWN1GXErkz6jwsifAUA64TT/u7KJ04sRRu7
         B7EoH2NwFWNhZAE1TNmBFZNnxhQUDh7nosMrW0od0TiLPC6sNEPoL9w4JzHb5mkAatLz
         OmqFn2L79e5ncnrDM7qLDRq25lzxFSqQGTH6e5bNMFP3meoNCrc1t0j1NPiW6ZvEj2rR
         JqgLpV1bpsmlYOl87GHrQdGcMUbBF9khGklInnar4aAo8hYT51IP7Y10o/0vGGt6200m
         aE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZsVH8c1ULmh9A6fIZSk90445YhCsqKHAHjLolpcKs4=;
        b=Lxczi+D/jD8F7V8Nj0SRGPIlddd2n3I8gO4FDnRIZ4HoibY44SQ/m/hxoWzBjmK74S
         j+/qAECWgsfWN6GJvfRR2QjvHqfii5kCmQC2jzefdgc+iWOOk/Pxjq3mD0Z3RkMvmO8z
         704nDAryL9PogVRmxoYlrdAr/yP9ugnjsLQxVICI8z4c63pNjeKhzQXAYgtaI8Clcx3u
         uuKYiK99eELMDw5qoxSWDVDekVs4Vi8oaKdSpUBU9ZhBaS+r1VxfeUNJ3/C+XWEaKw7Q
         dlFn9ILB+Vbb6GgirrM3rGnXEHzJHowU9Mk3iN02uwWMCzNDjXf1XvPaPvqQQfka//qA
         jIlA==
X-Gm-Message-State: AOAM533Qm/XPOWsqxvIQpXtLDgMP4LQBjSEN2qEbazr1ZzB56dtU8t8Z
        ourX6QrbwmdmobyXY+cU2DFo+zy+GXNnbU5Xkli9uaTwXzsPow==
X-Google-Smtp-Source: ABdhPJwxN0lUpo4XH1zxkT7hpYc8nb7/29yitsswkxn+heDvKYXUmQ+0phny1j1pOp01S+vwPqempnsxLf75W2L+NKI=
X-Received: by 2002:a05:6102:507:: with SMTP id l7mr3523149vsa.25.1620066749264;
 Mon, 03 May 2021 11:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAO658oV9AAcMMbVhjkoq5PtpvbVf41Cd_TBLCORTcf3trtwHfw@mail.gmail.com>
 <CAEf4Bzayxgt3P+kz36t6C8jp-MUTuwuKvwHWWsd2qrCs3-RHXA@mail.gmail.com>
In-Reply-To: <CAEf4Bzayxgt3P+kz36t6C8jp-MUTuwuKvwHWWsd2qrCs3-RHXA@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Mon, 3 May 2021 14:32:18 -0400
Message-ID: <CAO658oUpqOHmSAif+6zor1XTruDqHeTzAQHrCXOSPRo6oTp5vg@mail.gmail.com>
Subject: Re: Typical way to handle missing macros in vmlinux.h
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 28, 2021 at 5:15 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 28, 2021 at 1:53 PM Grant Seltzer Richman
> <grantseltzer@gmail.com> wrote:
> >
> > Hi all,
> >
> > I'm working on enabling CO:RE in a project I work on, tracee, and am
> > running into the dilemma of missing macros that we previously were
> > able to import from their various header files. I understand that
> > macros don't make their way into BTF and therefore the generated
> > vmlinux.h won't have them. However I can't import the various header
> > files because of multiple-definition issues.
>
> Sadly, copy/pasting has been the only way so far.
>
> >
> > Do people typically redefine each of these macros for their project?
> > If so is there anything I should be careful of, such as architectural
> > differences. Does anyone have creative ideas, even if not developed
> > fully yet that I can possibly contribute to libbpf?
>
> We've discussed adding Clang built-in to detect if a specific type is
> already defined and doing something like this in vmlinux.h:
>
> #if !__builtin_is_type_defined(struct task_struct)
> struct task_struct {
>      ...
> }
> #endif
>
> And just do that for every struct, union, typedef. That would allow
> vmlinux.h to co-exist (somewhat) with other types.
>
> Another alternative is to not use vmlinux.h and use just linux
> headers, but mark necessary types with
> __attribute__((preserve_access_index)) to make them CO-RE relocatable.
> You can add that to existing types with the same pragma that vmlinux.h
> uses.

I'm attempting to try doing the above. I'm just replacing
bpf_probe_read with bpf_core_read and not importing vmlinux.h, just
all the kernel headers I need.

When you say "Add that to existing types with the same pragma that
vmlinux.h uses", Should I be able to add the following to my bpf
source file before importing my headers?

ifndef BPF_NO_PRESERVE_ACCESS_INDEX
#pragma clang attribute push (__attribute__((preserve_access_index)),
apply_to = record)
#endif

and then pop the attribute at the bottom of the file, or after the
header includes.

I've tried this and get a whole bunch of 'unknown attribute' warnings,
leading me to believe that I either have something installed
incorrectly or don't understand how to use clang attributes. Do I need
to edit the types in the actual header files?

Thank you very very much for the help!
- Grant
>
> >
> > Thanks so much,
> > Grant Seltzer
