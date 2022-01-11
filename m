Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFC448B91A
	for <lists+bpf@lfdr.de>; Tue, 11 Jan 2022 21:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbiAKU7F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Jan 2022 15:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbiAKU7F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jan 2022 15:59:05 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8B7C06173F
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 12:59:05 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id o1so322260ilo.6
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 12:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VNYsj7R6UaHjshkfMG4hEuVOw2MmWp/HXwgpECk2/fg=;
        b=DKEUHlMP/JBr7OUaApY2wNI8b9MIQKhDRsKtY28XGLA9mzIc0L+4UX4VC22h3AhErC
         QTiRldxA4yTPUrgORs98Z4kXe1eZO0u/Zx5CXxOfCTbBLYfwasgUZyz5RecAC+quwbf+
         W2pbcE5uCsWJFDzzMab44ZbtZuwltJrk5CMLdjujMQ0r72DrrsWS0NTdaKpmw9ZiTPUt
         939P/aEFhVWSjN9uImd3qyn6qIpRbwfsU4KRpUotWjsXt8CDp8lZIGAvHpy1m8cO/nDV
         NIKLqyx+QPBlfSMf4FDcj+sxdzlaNlYwGi2F8TWvIJH68Plj6MySV4ulfZLQ9ZdiDcZB
         kp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VNYsj7R6UaHjshkfMG4hEuVOw2MmWp/HXwgpECk2/fg=;
        b=uFH6j61+MjWgxi5X3CTtg8yxNvYpWqy7cfdI9+YSxqc/IS9+Zqo+D9KLGWytuTHAK2
         0+rnb/xejSdgFogwnOVNdkMnHJu0Cqr+dkbT4lIRzeuBbZ2Nx4kslHI/ulnliyfWmC/a
         AtsrgBLbi62cDXqUJ7fje2rrOngXBIAkCFcqZ/VDlvLWPlcdbwLBoCXT3b4DW4P4yoGg
         zHnAps0+swv8gBSVg98UwFW4sn2t0Nw4IiQKtr6gKOuqbXc4M32lzk4/f+GJZ3w3hv5R
         Y+lKYnDGyBPTiYSKtIoH7PePe9R3vEKAx7SyKe3HT71g3cyM8Ow4bhVNWath7W5/6Bhk
         mk0A==
X-Gm-Message-State: AOAM530vLsj4EWLfDDuBYrQjjCy3hLYUbr0DbXINIjkzqhxqAqanxR8q
        WLbC/dgb+GIC5Bfqx8+bwfPQsdC3I4OioLeo8QVOh7iq
X-Google-Smtp-Source: ABdhPJxzRGbUzG/ctEa//oyEaAfrvH+4RIUnyayJwKg57OQJoegFpyfQ4X1LIiNnVBrb23twgFP81w3lBV1CNfMxkjI=
X-Received: by 2002:a05:6e02:1749:: with SMTP id y9mr1385082ill.252.1641934744680;
 Tue, 11 Jan 2022 12:59:04 -0800 (PST)
MIME-Version: 1.0
References: <CAMy7=ZXqyoaw0mOk2Z8ADxUSs95B=SRgvTua3vRJ00nS5qTFgQ@mail.gmail.com>
In-Reply-To: <CAMy7=ZXqyoaw0mOk2Z8ADxUSs95B=SRgvTua3vRJ00nS5qTFgQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 Jan 2022 12:58:53 -0800
Message-ID: <CAEf4BzY-H7ySLukPn+aUm55DhDxfO07e45J4V1q1bLqpDZ98_Q@mail.gmail.com>
Subject: Re: libbpf API: dynamically load(/unload/attach/detach) bpf programs question
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, michael.tcherniack@aquasec.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 11, 2022 at 4:33 AM Yaniv Agman <yanivagman@gmail.com> wrote:
>
> Hello!
>
> I noticed that the bpf_program__load() API was deprecated since libbpf
> 0.6 saying that bpf_object__load() should be used instead.
> This, however, doesn't seem to fit our use case of loading multiple
> bpf programs (that also share the same maps) from one bpf object (elf
> file), then unloading and loading them dynamically according to some
> given needs.

What's the use case for loading, then unloading, and then loading again?

> I'm not sure it is possible to load one specific program from the bpf
> object using bpf_object__load() API - is it?

It is possible. You can disable loading BPF program by calling
bpf_program__set_autoload(prog, false) after bpf_object__open() and
before bpf_object__load().

I've thought about adding a convention to SEC() to disable
auto-loading declaratively (e.g., SEC('!kprobe/whatever') won't
auto-load unless autoload is set to true through
bpf_program__set_autoload()), but we haven't implemented that yet.

>
> Another question with the same context -
> If I understand correctly, the purpose of detach is to "prevent
> execution of a previously attached program from any future events"
> (https://facebookmicrosites.github.io/bpf/blog/2018/08/31/object-lifetime.html),
> which seems like something that I would want to do if I just wanted to
> temporarily stop an event from triggering the program. But then I ask
> myself - what is the meaning of detaching a link (and not
> bpf_link__destroy() it) if there is no way to attach it back (without

you mean bpf_link__detach()? this is a special "admin-only" operation
of force-detaching the link, even if there are still link FDs open.
Normally you shouldn't do it. Use bpf_link__destroy() to detach (and
make sure no one dup()'ed extra FDs)

> re-creating the link object)? I don't see any function named
> bpf_link__attach() that would do such a thing, or any other function
> in libbpf API that can do something similar, am I right?

Right, links are created with bpf_program__attach*() APIs.

> Also, It seems that using bpf_link__detach() does not fit all link
> types. For example, when attaching a (non legacy) kprobe, detaching it
> should probably happen using PERF_EVENT_IOC_DISABLE and not through
> sys_bpf(BPF_LINK_DETACH), shouldn't it?
>
> And one last question:
> When using bpf_program__unload() on a program that is already
> attached, should we first call bpf_link__detach() or does the kernel
> already take care of this?

Keep in mind that bpf_program__unload() is also deprecated. The idea
is that if you are working with high-level libbpf APIs that are
centered around struct bpf_object, bpf_program, and bpf_map, the
entire collection of programs and maps is functioning as a single
bundle. If that abstraction doesn't work, you'll have to drop to
low-level APIs (defined in bpf/bpf.h) and manipulate everything
through FDs.

As for detaching (destroying in libbpf lingo, though) the link, yes,
you need to destroy links before unloading the program. Otherwise
links themselves will keep programs loaded in the kernel. Some legacy
links (legacy kprobe/uprobe) won't auto-detach even on process exit
because the kernel doesn't support this.

>
> Thanks,
> Yaniv
