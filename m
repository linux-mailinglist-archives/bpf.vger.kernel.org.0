Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A93236E0D9
	for <lists+bpf@lfdr.de>; Wed, 28 Apr 2021 23:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhD1VQQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Apr 2021 17:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhD1VQP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Apr 2021 17:16:15 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7626BC06138A
        for <bpf@vger.kernel.org>; Wed, 28 Apr 2021 14:15:30 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id j6so8032073ybh.11
        for <bpf@vger.kernel.org>; Wed, 28 Apr 2021 14:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bIyO61YISM11+b/ct8CD54XRnrE2EiAcB3X911CPmqk=;
        b=qz0ZFOu1yFMgGEs/KL/T+VGfZvVwcZgYe3/GVAGkIVPrjvJPninWWkWyU9qQ8l6JdJ
         4/MNhh0/+09D81yDMvUtv5Za4YFUedKxqMP0LZ4FEmFk2a1ho/83VxQmbmganOhhajrM
         WtfgsEvbJ/Xde1HClGijkhoXDx7vkYjXAcFroS9uEg4e1XIEe1HOKsDA+ZO8f5eduzCC
         mUi4XB3AN7V7TezYqYW589O6BTNkeGy8HK+kRf0BJ3oVJFy0GYERp1uTOPThiDhfcEc/
         bQnlegjUHj5NPUMZNgxaAdLdDsZybdXXzXzEvVZihNJXR9N7JtfxnvfjkHp+U5vkgLfb
         IbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bIyO61YISM11+b/ct8CD54XRnrE2EiAcB3X911CPmqk=;
        b=KAl0Mw/duCi7QTl22rpoj1Ip55LRPJrK32aH7pToB6QKj0e8SBd3RUZ/a12BHMwOVh
         qygNNYSJESgXSUqmy8QsMPiMGFYyQ7Dd/Ksh+jNQjN1IxBMBwVqtwEPnyP6W639w6WMK
         S67genTnN0BZCVXGqgZpwefiSz63Xnw0cEt2riEOkqLBsDcXGCPAvIzl/ROzsdyngwWL
         l9yKZYwBqJ3qnIYPGtlPbxKxm8dSiBOJVxCWwGub6sXCQMSDgyPat04fi/mu0Z9eqaV4
         LJbYnRTh6XVNwzmeSIKkqyOTN2JQkZSYgtZe08RrmAFKONirwJI6/A5/f/JaNMAs6hG9
         vmTw==
X-Gm-Message-State: AOAM532iDIxwWZWjstsgmX3iROqe/Xwrd1iK1np+OmYmZGvSUI9mnJ9g
        0UeDJ6P9qXYOXhHntTUH3QghaQKp593J3+nZxg4=
X-Google-Smtp-Source: ABdhPJw+LVl5lB3vljTEwjamtKwPdnPuPL+MfSsFHU0K7Hfk0eJlzl8y4Co+WIlxrCFudpBTRUAttyNfV0289EjBuy4=
X-Received: by 2002:a25:9942:: with SMTP id n2mr43704786ybo.230.1619644529732;
 Wed, 28 Apr 2021 14:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAO658oV9AAcMMbVhjkoq5PtpvbVf41Cd_TBLCORTcf3trtwHfw@mail.gmail.com>
In-Reply-To: <CAO658oV9AAcMMbVhjkoq5PtpvbVf41Cd_TBLCORTcf3trtwHfw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 28 Apr 2021 14:15:18 -0700
Message-ID: <CAEf4Bzayxgt3P+kz36t6C8jp-MUTuwuKvwHWWsd2qrCs3-RHXA@mail.gmail.com>
Subject: Re: Typical way to handle missing macros in vmlinux.h
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 28, 2021 at 1:53 PM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> Hi all,
>
> I'm working on enabling CO:RE in a project I work on, tracee, and am
> running into the dilemma of missing macros that we previously were
> able to import from their various header files. I understand that
> macros don't make their way into BTF and therefore the generated
> vmlinux.h won't have them. However I can't import the various header
> files because of multiple-definition issues.

Sadly, copy/pasting has been the only way so far.

>
> Do people typically redefine each of these macros for their project?
> If so is there anything I should be careful of, such as architectural
> differences. Does anyone have creative ideas, even if not developed
> fully yet that I can possibly contribute to libbpf?

We've discussed adding Clang built-in to detect if a specific type is
already defined and doing something like this in vmlinux.h:

#if !__builtin_is_type_defined(struct task_struct)
struct task_struct {
     ...
}
#endif

And just do that for every struct, union, typedef. That would allow
vmlinux.h to co-exist (somewhat) with other types.

Another alternative is to not use vmlinux.h and use just linux
headers, but mark necessary types with
__attribute__((preserve_access_index)) to make them CO-RE relocatable.
You can add that to existing types with the same pragma that vmlinux.h
uses.

>
> Thanks so much,
> Grant Seltzer
