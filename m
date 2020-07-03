Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAF22130C4
	for <lists+bpf@lfdr.de>; Fri,  3 Jul 2020 03:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgGCBAj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jul 2020 21:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgGCBAi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jul 2020 21:00:38 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CF4C08C5DD
        for <bpf@vger.kernel.org>; Thu,  2 Jul 2020 18:00:38 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g20so25747097edm.4
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2020 18:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xhJ/3m0KcF51XQMCDykPvx6FH+Zxv6t6Wm2boNZX4GA=;
        b=HRnc8Z/UWD1VH3SDqiH4lfspf3ok3r+xS7c66s+ynb3ZzlBkN2PSz5kYMKHrzl7TQ4
         fZ8+IFqVBJWm7YWqXIR8IP8nkdyQC3joTYpIj49kaBTa633kHTrhJhFkqzD8TramRmM1
         Yo4ZUFvd4iiBdz/qOIz2C16Di7gBSp0vYJurQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xhJ/3m0KcF51XQMCDykPvx6FH+Zxv6t6Wm2boNZX4GA=;
        b=DEoAD3OpqZODldnotroIR1lFoARSBB6q42iPRn5Yopvb5y40l0NxsEm7ZXdbZecEp7
         1DeGYQc0o9QVmZVb1t3xDQa+kV1bF60U2jaAEkHxes+cDhFQje2slsHdW2tCGYOXgD4L
         hI3WnV9wKHM/5MpUtqsZGhJIvMKTXGmk1LPfN6jCvZs6HmAaqj1aGqKqpBfTK3vyqfy0
         kwZSFW59eMAnX1sAouLwQS8liDo3QJGxdUfd5srF4huWMBbsIoHINJnvTPOe7LTguldQ
         jvUz5bAebH2fY84XG66wqWdR81fRdVMj8nl+3nXgCYJjE0Fl65AR0Bnj8WZsthvT0G40
         DBOA==
X-Gm-Message-State: AOAM531EPcuid3pWmhDy6jP80wmKzMf/S0EXZfYzt3wtmjjlHHVjCh/L
        +lk1J/bDXRiOZpOlq36rBNLaW+Uow+0=
X-Google-Smtp-Source: ABdhPJx3udnva2XlcysEhawyAiRrg4+XzFXARijhnTI/dYMSaFSN5KFF2zcDATo+256dgutXLipycA==
X-Received: by 2002:a05:6402:22f0:: with SMTP id dn16mr38206364edb.83.1593738036738;
        Thu, 02 Jul 2020 18:00:36 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id lj18sm8066188ejb.43.2020.07.02.18.00.35
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 18:00:36 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id y10so32009829eje.1
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2020 18:00:35 -0700 (PDT)
X-Received: by 2002:a2e:9c92:: with SMTP id x18mr12604594lji.70.1593738033657;
 Thu, 02 Jul 2020 18:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200702232638.2946421-1-keescook@chromium.org> <20200702232638.2946421-5-keescook@chromium.org>
In-Reply-To: <20200702232638.2946421-5-keescook@chromium.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jul 2020 18:00:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZi-v8Xgu_B3wV0B4RQYngKyPeONdiXNgrHJFU5jbe1w@mail.gmail.com>
Message-ID: <CAHk-=wiZi-v8Xgu_B3wV0B4RQYngKyPeONdiXNgrHJFU5jbe1w@mail.gmail.com>
Subject: Re: [PATCH 4/5] kprobes: Do not expose probe addresses to non-CAP_SYSLOG
To:     Kees Cook <keescook@chromium.org>
Cc:     Dominik Czarnota <dominik.czarnota@trailofbits.com>,
        stable <stable@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Will Deacon <will@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matteo Croce <mcroce@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Alexander Lobakin <alobakin@dlink.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 2, 2020 at 4:26 PM Kees Cook <keescook@chromium.org> wrote:
>
> The kprobe show() functions were using "current"'s creds instead
> of the file opener's creds for kallsyms visibility. Fix to use
> seq_file->file->f_cred.

Side note: I have a distinct - but despite that possibly quite
incorrect - memory that I've discussed with somebody several years ago
about making "current_cred()" simply warn in any IO context.

IOW, we could have read and write just increment/decrement a
per-thread counter, and have current_cred() do a WARN_ON_ONCE() if
it's called with that counter incremented.

The issue of ioctl's is a bit less obvious - there are reasons to
argue those should also use open-time credentials, but on the other
hand I think it's reasonable to pass a file descriptor to a suid app
in order for that app to do things that the normal user cannot.

But read/write are dangerous because of the "it's so easy to fool suid
apps to read/write stdin/stdout".

So pread/pwrite/ioctl/splice etc are things that suid applications
very much do on purpose to affect a file descriptor. But plain
read/write are things that might be accidental and used by attack
vectors.

If somebody is interested in looking into things like that, it might
be a good idea to have kernel threads with that counter incremented by
default.

Just throwing this idea out in case somebody wants to try it. It's not
just "current_cred", of course. It's all the current_cred_xxx() users
too. But it may be that there are a ton of false positives because
maybe some code on purpose ends up doing things like just *comparing*
current_cred with file->f_cred and then that would warn too.

              Linus
