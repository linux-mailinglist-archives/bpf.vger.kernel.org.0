Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B33E29C862
	for <lists+bpf@lfdr.de>; Tue, 27 Oct 2020 20:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829426AbgJ0TJK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Oct 2020 15:09:10 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51824 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762525AbgJ0TJJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Oct 2020 15:09:09 -0400
Received: by mail-pj1-f68.google.com with SMTP id a17so1276966pju.1;
        Tue, 27 Oct 2020 12:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vhFHGlRt/TibQfkAL2EZLq+3HRZ+VxPAD9HYXcgWC/k=;
        b=TDpYEM9j0VTG9y1sK6+P54LMevQ/wxvF5jiUXCKKLZ1FxRRYMYefcVyVQfAc+Om1PS
         ZEe1VRZkmhk0ir6O43G95oBAO2XD+Bq4fVBpHzkVRZw+UriLY30a/R4X0pDFtk1z5MUB
         yLaicL/Mrjl46F0+UFymiiwaSisHRYKw813Q0Kd47cc1WgZhvOJbmIZ6w6cxJxiecpuq
         hwk7hhJezQPq9VDBZdwaoEdHe5L3Ab5JZ4CMwJDp3CVt6wOQRLayWvn4DBgp1j2xyiIA
         Nfr8NKXzTh5ilnJ2tvCD46vw2NdTRtKMK/iutofss4RYEab+Vx7Vu0QT/YxkCzMOQAZw
         APGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vhFHGlRt/TibQfkAL2EZLq+3HRZ+VxPAD9HYXcgWC/k=;
        b=S50P8F9V+chxT2NTgSsOOjn0hbJKehYtwcu38QQlOTafvwPZoOGGRidaMudPB6O4cw
         qe9JVcYA7OJ0oOXyU7vlzOGgWDPCG5PDXzIzWD9wDmVl/v13f1nHl/CJthGJUrB7B949
         CVFp00/xswSfWPB5lktOp3uvm/Mcus/YmdQ7uUDs15u8RyaGg8AlaKGrjgKkTgXCFj3f
         J3VmhTbE9l8cz3WLkoA/SupBAIewbZeco9P9M8AE7oe1Yv+bepDxdU4I4bqyaCRgzVac
         mw1Z6GdGYgdk2jwLXaLXayPrY1IBvecwwMjmWn4s+jYKTKaDwVx4OWCtppadRznKAw2E
         DGug==
X-Gm-Message-State: AOAM531XDIOQlohjO+o5YT2qzSv1m+pf+bOLFEYYZDWaQFYXtsTBdbIO
        e/e8T2koRSw9Bj5PTOUM+WRgU/SfN4z47Pz4Wiw=
X-Google-Smtp-Source: ABdhPJxT3MVZFdXRiktZytixxJYH/g52Rzd4ej1B/B/6AaacDeKHj7pSvVmudEo7lSKi4TSWV3mmIU7KhXAqNfkE9GM=
X-Received: by 2002:a17:902:6803:b029:d2:42a6:312 with SMTP id
 h3-20020a1709026803b02900d242a60312mr3734880plk.24.1603825748736; Tue, 27 Oct
 2020 12:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600951211.git.yifeifz2@illinois.edu> <9ede6ef35c847e58d61e476c6a39540520066613.1600951211.git.yifeifz2@illinois.edu>
 <CAMuHMdXTLKr6pvoE+JAdn_P5kVxL6gx8PJ8mqfXcS+SF+pRbkQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXTLKr6pvoE+JAdn_P5kVxL6gx8PJ8mqfXcS+SF+pRbkQ@mail.gmail.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Tue, 27 Oct 2020 14:08:56 -0500
Message-ID: <CABqSeAQvZNF4ynayT1XjEm4eP2H-ee46zBwmVRRD1-ZpohqG4w@mail.gmail.com>
Subject: Re: [PATCH v2 seccomp 1/6] seccomp: Move config option SECCOMP to arch/Kconfig
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 27, 2020 at 4:52 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Please tell me why SECCOMP is special, and deserves to default to be
> enabled.  Is it really that critical, given only 13.5 (half of sparc
> ;-) out of 24
> architectures implement support for it?

Good point. My thought process is that quite a few system software are
reliant on seccomp for enforcing policies -- systemd, docker, and
other sandboxing tools like browsers and firejail, so when I moved
this to the non-perarch section, it at least has to be default for
x86. Granted, I'm not super familiar with other architectures, so you
are probably right that those that did not have it on by default
should be kept off by default; many of them could be for embedded
devices. What's the best way to do this? Set it as default N in
Kconfig and add CONFIG_SECCOMP=y in each arch's defconfig?

YiFei Zhu
