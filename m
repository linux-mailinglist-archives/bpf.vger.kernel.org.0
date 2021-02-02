Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0104030B7D2
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 07:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhBBG0n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Feb 2021 01:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhBBG0l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Feb 2021 01:26:41 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87F7C061756
        for <bpf@vger.kernel.org>; Mon,  1 Feb 2021 22:26:00 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id c3so8962675ybi.3
        for <bpf@vger.kernel.org>; Mon, 01 Feb 2021 22:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I3Yw0q6rShogHXkQ6x+20wn6D3paWyFSKy3nm54uBlk=;
        b=tGW1Uq4TeWq24ApfFB4/vX9RPTZjVvLE7ARtJm44jKsEGUXYmn1jDWo2NMGQBFuRiV
         q8gr13MeOTWh+MDl20k/58fctSKxp5E7WYMJ6bY2F/1oF7fos+NYd2S18HU4y3Ho7sH7
         s+DGEWBFKplix5j8IUa30HoZQYhCTxYlOld7uHufxR/5xYooULME2i2NEmWrU2/n7FNM
         dGx4dwASq/SMHFR7GpsuVL4yXQsaZZoeb0anCjBOqiMU1qq7cM7lr9w9hCXP6R1+cm7C
         ZaC6NZqRpePfcNIjwd6n1AQNkayiBt9mPXjepLwQzFjFAdLSxMQe8UYOzVD/Qq4GDffX
         NLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I3Yw0q6rShogHXkQ6x+20wn6D3paWyFSKy3nm54uBlk=;
        b=qW/2Kfs+sqRzp1CHQVwYRdBO+RKjZzTi5Li9UPsLeFl8bGLlihL7bt/oiWl9dgnmJZ
         CWaviwfp2qGMcwnlZSJSInUCyLpSs/ogqD8ERvo2WTXYbaTAdQv6BnB+BDEjk3iubn47
         2+sGjPFtppxetLqefP1J/+UC35M5wmthdhGJpJ8WZTnNZ/oqU7/t1BPBfwhYJk831mnv
         zWqSg3+O9GFoRFJlwzjDHDlJs450z0WGuVTZd6nbgo33yWXbcwxwFRFXOXPMvEzHPHjU
         mq/ixB6Cb3boPoTkxK/YdogU7987huZbI1ORqM7Egv6iCaZkGhXkrlFDS8Jvuifum5Z8
         8oOQ==
X-Gm-Message-State: AOAM533FVnXBtkcRxa1iBrda7lVsPo868qFMTHcapM4pqVMnB6BsmYgP
        tPBnHi4xYug/xjK5fzCdY8HkbyXJ+hghnTsfqLypY4oWwtbcZw==
X-Google-Smtp-Source: ABdhPJyJnnApaw0v58OGNEjRSmdQTLn4ItEEOPw91de+fNuIYN+NUuO2v1X3Wq8BEwiW0h3URWwgyHD8up6gbxLrsRk=
X-Received: by 2002:a25:9882:: with SMTP id l2mr29443853ybo.425.1612247160029;
 Mon, 01 Feb 2021 22:26:00 -0800 (PST)
MIME-Version: 1.0
References: <20210123004445.299149-1-kpsingh@kernel.org> <20210123004445.299149-2-kpsingh@kernel.org>
 <CAEf4BzbvEcE=9uXpz2SHKfw8oTxt7V8cSjUYQpJroP5MyxkA0w@mail.gmail.com> <CACYkzJ7nqXyqBv9px1e4pANyNyYmqt18Dx=cL90otKK1oPYU-g@mail.gmail.com>
In-Reply-To: <CACYkzJ7nqXyqBv9px1e4pANyNyYmqt18Dx=cL90otKK1oPYU-g@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Feb 2021 22:25:49 -0800
Message-ID: <CAEf4BzagU3B2yWKAw6p9cu_J+StW1DoFhX2JyvFMt3tZ2_1wpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Helper script for running BPF
 presubmit tests
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 31, 2021 at 4:22 PM KP Singh <kpsingh@kernel.org> wrote:
>
> On Tue, Jan 26, 2021 at 3:10 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Jan 22, 2021 at 4:44 PM KP Singh <kpsingh@kernel.org> wrote:
> > >
> > > The script runs the BPF selftests locally on the same kernel image
> > > as they would run post submit in the BPF continuous integration
> > > framework.
> > >
> > > The goal of the script is to allow contributors to run selftests locally
> > > in the same environment to check if their changes would end up breaking
> > > the BPF CI and reduce the back-and-forth between the maintainers and the
> > > developers.
> > >
> > > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > > ---
> >
> > This is great, thanks a lot for working on this! This is great
> > especially for ad-hoc contributors who don't have qemu workflow setup.
> > Below are some comments for the extra polish :)
> >
> > 1. There is this long list output at the beginning:
> >
> > https://libbpf-vmtest.s3-us-west-1.amazonaws.com/x86_64/vmlinux-5.5.0.zst
> > https://libbpf-vmtest....
> >
> > Can we omit that?
>
> Sure.
>
> >
> > 2. Then something is re-downloaded every single time:
> >
> >   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
> >                                  Dload  Upload   Total   Spent    Left  Speed
> > 100 77713  100 77713    0     0   509k      0 --:--:-- --:--:-- --:--:--  512k
> >
> > Unless it's to check if something newer appeared in S3, would be nice
> > to skip that step.
>
> This is the kernel config. I wonder how we could check if there is something
> new without downloading it, the file is called "latest.config".
>
> Maybe this is something we can add to the URL index as well in format similar
>  to the image. But since it's just a config file I am not sure
> it's worth the extra effort.

Curl supports the following option. Given we have a local cache in
.bpf_selftests, check if it already has .config and pass it as -z
'.bpf_selftests/.config'? Would be nice, if it works out. If not, I
agree, config is small enough to not go to great lengths to avoid
downloading it.

-z/--time-cond <date expression>

(HTTP/FTP) Request a file that has been modified later than the given
time and date, or one that has been modified before that time. The
date expression can be all sorts of date strings or if it doesn't
match any internal ones, it tries to get the time from a given file
name instead.


>
> >
> > 3. Every single time I run the script it actually rebuilds kernel.
> > Somehow Linux Makefile's logic to do nothing if nothing changed in
> > Linux source code doesn't kick in, I wonder why? It's quite annoying
> > and time-consuming for frequent selftest reruns. What's weird is that
> > individual .o's are not re-built, but kernel is still re-linked and
> > BTF is re-generated, which is the slow part :(
>
> I changed this from not compiling the kernel by default, to compiling it and you
> can "keep your old kernel" with -k. This is because users may run the script,
> not compile the kernel and run into issues with the image not being able to
> mount as the kernel does not have the right config.
>
> The -k is for people who know what they are doing :)
>
> so you can always run
>
>  ./bpf_presubmit.sh -k
>
> after you have the kernel built once.

That's not what I'm saying. When running `make` to build Linux, if
won't do much at all if nothing changed. That's a good property that
saves tons of time. I'm saying your script somehow precludes that
behavior and make does tons of unnecessary work. It might be because
of always re-downloaded config, which might make the above (not
redownloading it if it didn't change) more important.

Sure -k might be used this way, but it's expected to happen
automatically. I'm just pointing out that something is not wired
optimally to allow make do its job properly.

>
> >
> > 4. Selftests are re-built from scratch every single time, even if
> > nothing changed. Again, strange because they won't do it normally. And
> > given there is a fixed re-usable .bpf_selftests "cache directory", we
> > should be able to set everything up so that no extra compilation is
> > performed, no?
> >

And this won't be solved with '-k' alone, probably?

> > 5. Before VM is started there is:
> >
> >
> > #!/bin/bash
> >
> > {
> >
> >         cd /root/bpf
> >         echo ./test_progs
> >         ./test_progs
> > } 2>&1 | tee /root/bpf_selftests.2021-01-25_17-56-11.log
> > poweroff -f
> >
> >
> > Which is probably useful in rare cases for debugging purposes, but is
> > just distracting in common case. Would it be able to have verbose flag
> > for your script that would omit output like this by default?
>
> Sure. I can omit it for now and submit a subsequent patch that adds verbosity.

Great.

>
> >
> > 6. Was too lazy to check, but once VM boots and before specified
> > command is run, there is a bunch of verbose script echoing:
> >
> > + for path in /etc/rcS.d/S*
> >
> > If that's part of libbpf CI's image, let's fix it there. If not, let's
> > fix it in your script?
>
> Nope, this is not from my script so probably something from one of the
> CI init scripts.
>

Ok, I'll take a look and see if we can remove this noise.

> >
> > 7. Is it just me, or when ./test_progs is run inside VM, it's output
> > is somehow heavily buffered and delayed? I get no output for a while,
> > and then a whole bunch of lines with already passed tests.  Curious if
> > anyone else noticed that as well. When I run the same image locally
> > and manually (not through your script), I don't have this issue.
>
> I saw this as well but sort of ignored it as it was random for me, but I did
> some digging and found that this could be related to buffering within
> test_progs, so I changed the buffering to per-line and now it does not
> get stuck and dump its output as you and Jiri noticed.
>
> --- a/tools/testing/selftests/bpf/run_in_vm.sh
> +++ b/tools/testing/selftests/bpf/run_in_vm.sh
> @@ -165,7 +165,7 @@ EOF
>
>         cd /root/bpf
>         echo ${command}
> -       ${command}
> +       stdbuf -oL -eL ${command}

makes sense, thanks!

>  } 2>&1 | tee /root/${log_file}
>
> >
> > 8. I noticed that even if the command succeeds (e.g., ./test_progs in
> > my case), the script exits with non-zero error code (32 in my case).
> > That's suboptimal, because you can't use that script to detect test
> > failures.
>
> I found this was because if the unmount command
> in the cleanup block fails
> (when the directory was not mounted or already unmounted)
> we would never get to the exit command.
>
> The snippet below fixes this.
>

awesome, makes this script useful for scripting :)

> @@ -343,8 +343,10 @@ main()
>  catch()
>  {
>         local exit_code=$1
> -
> -       unmount_image
> +       # This is just a cleanup and the directory may
> +       # have already been unmounted. So, don't let this
> +       # clobber the error code we intend to return.
> +       unmount_image || true
>         exit ${exit_code}
>  }
>
> >
> > But again, it's the polish feedback, great work!
>
> Thanks! :)
>
>
>
> >

[...]
