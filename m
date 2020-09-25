Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E623F277E6B
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 05:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgIYDL3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 23:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgIYDL3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 23:11:29 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600FBC0613CE;
        Thu, 24 Sep 2020 20:11:29 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d6so1797767pfn.9;
        Thu, 24 Sep 2020 20:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ySqE1hRmF9Ut683kpqXH3+Ug8FaOyeb/lR8F0Fj7WM=;
        b=eOBo1Dk5p71aOus/dqAJ5VrtH0vlEUxqA/HX/NYAH316KAy2KiDxLZ+RHBbSiGGOLC
         fK0M41WRXhGjY9h1joZWds6hPj2ODt92H9A8vGV6qTyOXSrttaLuU3Ca0rT+hQXa2Hc8
         RnEVYQ20u5JFb6w/sofhSYAz7Y19aoL1sD4YMVwoe9yWPr31Csn0MzMhDauTqPYuuWow
         ZFIOuwU5e+R5uY49sI3IFKYCR+vUEDrF7oVauM/7vMjbn99qllOZWnoJfn0sPR+blKv+
         hvOId1dlpBj+QvDV9av1m4Ktj1oGIee23S8yDcbQEEc7uhKSOV5LcWqviLoQ0bsA7pOh
         YC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ySqE1hRmF9Ut683kpqXH3+Ug8FaOyeb/lR8F0Fj7WM=;
        b=YhqBX8tIWgOCM0/8FRX/63dAbcbovQ1GNErUrFSuM2ysuz50HJ+wvizcjFAGZDcKb9
         u/MvYWnDD0l02awUqDXlN5aV7+61pzb1uhbEqOI6NTEXXksC2gijfQAE+cKwjKHCZUsl
         aSvnUFehuxn7DFzDuVYlloCG31sQF/l95BerDML5hSOMQCIcjoStP9CucW3X8vzfEnvG
         i2A5d9zavd/U2tDTG6fqczY/+8t076F747g6p7Y4fDV9IjIp0Le47Yj4ukK4NhZqoO+6
         oWXhCXFXdRyPy0GnghC87nTulNw2vYLnz0wasBUVR0L+BgQaI7Kvtg07vfr585RUqC8H
         x21w==
X-Gm-Message-State: AOAM532O8PirBCyL05NoeUsun7ep9RMcFfU5LSV+OmEehHyqzMFLCaGL
        bwU8NX1w7spt5GzsOz8UIuM8Ha7d6C8vLhv7lO0=
X-Google-Smtp-Source: ABdhPJzW6eDnzhk2FnjrkoXEDFOI42OK+sDY3QodTZzLs9uOSntOF7enBAOqFgHMxIhE8UdI3EgqLjF9FLBZICuokXM=
X-Received: by 2002:aa7:8d4c:0:b029:150:f692:4129 with SMTP id
 s12-20020aa78d4c0000b0290150f6924129mr2179043pfe.11.1601003488655; Thu, 24
 Sep 2020 20:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600951211.git.yifeifz2@illinois.edu> <b11ebe533838af7829a5e7381a7914bca27cb621.1600951211.git.yifeifz2@illinois.edu>
 <202009241647.2239747F0@keescook>
In-Reply-To: <202009241647.2239747F0@keescook>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 24 Sep 2020 22:11:17 -0500
Message-ID: <CABqSeASrwXwSHHAsVwjG6vCLbfXpkp+42HWW27MUK2zgMnAu8w@mail.gmail.com>
Subject: Re: [PATCH v2 seccomp 6/6] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 6:56 PM Kees Cook <keescook@chromium.org> wrote:
> > This file is guarded by CONFIG_PROC_SECCOMP_CACHE with a default
> The question of permissions is my central concern here: who should see
> this? Some contained processes have been intentionally blocked from
> self-introspection so even the "standard" high bar of "ptrace attach
> allowed?" can't always be sufficient.
>
> My compromise about filter visibility in the past was saying that
> CAP_SYS_ADMIN was required (see seccomp_get_filter()). I'm nervous to
> weaken this. (There is some work that hasn't been sent upstream yet that
> is looking to expose the filter _contents_ via /proc that has been
> nervous too.)
>
> Now full contents vs "allow"/"filter" are certainly different things,
> but I don't feel like I've got enough evidence to show that this
> introspection would help debugging enough to justify the partially
> imagined safety of not exposing it to potential attackers.

Agreed. I'm inclined to make it CONFIG_DEBUG_SECCOMP_CACHE and guarded
by a CAP just to make it "debug only".

> I suspect it _is_ the right thing to do (just look at my own RFC's
> "debug" patch), but I'd like this to be well justified in the commit
> log.
>
> And yes, while it does hide behind a CONFIG, I'd still want it justified,
> especially since distros have a tendency to just turn everything on
> anyway. ;)

Is there something to stop a config from being enabled in an
allyesconfig? I remember seeing something like that. Else if someone
is manually selecting we can add a help text with a big banner...

> But behavior-wise, yeah, I like it; I'm fine with human-readable and
> full AUDIT_ARCH values. (Though, as devil's advocate again, to repeat
> Jann's own words back: do we want to add this only to have a new UAPI to
> support going forward?)

Is this something we want to keep stable?

YiFei Zhu
