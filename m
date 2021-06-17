Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E583ABD3F
	for <lists+bpf@lfdr.de>; Thu, 17 Jun 2021 22:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhFQUCc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 16:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbhFQUCb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 16:02:31 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0236FC061574;
        Thu, 17 Jun 2021 13:00:23 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id d196so5151455qkg.12;
        Thu, 17 Jun 2021 13:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ITrdxf5N7vcXlH4g+nMgEuP5FxDcdjj5jZiX8P67nAw=;
        b=qxnaZxYsxl6sA6hF3gzcu8JQRNAHnroSOTP4DLxl8EW60mgjT2vhLuQb8mJdOc/RIH
         cCE/GGPZoJC2AUOkC4KhssDNsYFtEY7Gh9A6cLWC6SC+aBKj4UZxTbmtqcgIpnVqDveb
         cgTKMWd7pKNV32cJ8hhQXVnmMc3HHpX3QWCYj8aSR7pnhOYb4Bfl3QqVnatHoVpwqwwC
         egUIXLE9qHg+EKCGraPlueXlQ4YvNI8cOvH9gf4JXwT8vOZu+U3GUGNt11T6X+B4Y0Lw
         c04Q9abrJf5GTVU68GUuTl7F00fnEcw3hEjUsRx6DNoyDL5odNAoD7o8veESBKMxbE+O
         4OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ITrdxf5N7vcXlH4g+nMgEuP5FxDcdjj5jZiX8P67nAw=;
        b=kdhl3ThBLxej68WhaFSFBDvTHdqIsxPu1B/Ru7Ma8/YywcRrPi0lKqfC9s14H69nBl
         /t+M2qs05UeICbAS8lRwQ8OmNMDkYHbAr4IBwd0knSVnNDJimwqeyPMqjdOa0BhrDvCA
         zm/VR1ARkjHgEPObe5lVgMxes1e9156CMNUUFazbFoPDI+s7v1FgRUxKPJ1qPBGeKgNn
         CMU+iXK31hzWUDI7GHBJJsGnWEnphQWtWKWWQVE1KMGRer9uzsfpiN453X3uqOLynXkn
         bwinkoIJFTJNyXnhXr/04WKV+gl7Y2U4FzNWo4SHJBBsUEx6PvxYijUebdbOkHAk9gr0
         yn9w==
X-Gm-Message-State: AOAM5300h/ydsBapA9jMgvQBVB2xee+TGcT8v5AyStc7YOh49GsFxySg
        XJ73vpfciyhASYDC1/U7BqRE+HoOce49HEC86ic=
X-Google-Smtp-Source: ABdhPJwZr7MKnUlJ42hju0DrOQGluuE90Pp5hMDDLuVM8CZS6Hfw/O1PaWSU1vce9586ziC98F26R5JYzplDF0iC9IY=
X-Received: by 2002:a25:6612:: with SMTP id a18mr8858968ybc.347.1623960022189;
 Thu, 17 Jun 2021 13:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzZnZN2mt4+5F-00ggO9YHWrL3Jru_u3Qt2JJ+SMkHwg+w@mail.gmail.com>
 <YMoRBvTdD0qzjYf4@kernel.org> <YMopYxHgmoNVd3Yl@kernel.org>
 <YMph3VeKA1Met65X@kernel.org> <CAEf4BzZmBbkU1WWLEsZG1yVMdt7CDcuHhRF8uoLqeamhef3bVQ@mail.gmail.com>
 <YMtgz+hcE/7iO7Ux@kernel.org>
In-Reply-To: <YMtgz+hcE/7iO7Ux@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Jun 2021 13:00:11 -0700
Message-ID: <CAEf4BzbK4jN7c8aa05xGyLm_FJKgywW8Ju8dA11VAJ9Nx8drVQ@mail.gmail.com>
Subject: Re: latest pahole breaks libbpf CI and let's talk about staging
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        dwarves@vger.kernel.org, siudin@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 17, 2021 at 7:48 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Jun 16, 2021 at 03:36:54PM -0700, Andrii Nakryiko escreveu:
> > On Wed, Jun 16, 2021 at 1:41 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > > And if I use pahole's BTF loader I find the info about that function:
> > >
> > > [acme@seventh linux]$ strace -e openat -o /tmp/bla pfunct -F btf tcp_cong_avoid_ai  ; grep vmlinux /tmp/bla
> > > void tcp_cong_avoid_ai(struct tcp_sock * tp, u32 w, u32 acked);
> > > openat(AT_FDCWD, "/sys/kernel/btf/vmlinux", O_RDONLY) = 3
> > >
> > > So this should be unrelated to the breakage you noticed in the CI.
> > >
> > > I'm trying to to reproduce the CI breakage by building the kernel and
> > > running selftests after a reboot.
> > >
> > > I suspect I'm missing something, can you see what it is?
> >
> > Oh, I didn't realize initially what it is. This is not kernel-related,
> > you are right. You just need newer Clang. Can you please use nightly
> > version or build from sources? Basically, your Clang is too old and it
> > doesn't generate BTF information for extern functions in BPF code.
>
> Oh well, I thought that that clang was new enough, the system being
> Fedora rawhide:
>
> [acme@seventh ~]$ clang -v |& head -1
> clang version 12.0.0 (https://github.com/llvm/llvm-project 87369c626114ae17f4c637635c119e6de0856a9a)
>
> I'm now building the single-repo main...
>
> Would you consider a patch for libbpf that would turn this:
>
> > > > libbpf: failed to find BTF for extern 'tcp_cong_avoid_ai' [27] section: -2
> > > > Error: failed to open BPF object file: No such file or directory
> > > > make: *** [Makefile:460: /mnt/linux/tools/testing/selftests/bpf/bpf_cubic.skel.h] Error 255
> > > > make: *** Deleting file '/mnt/linux/tools/testing/selftests/bpf/bpf_cubic.skel.h'
> > > > make: Leaving directory '/mnt/linux/tools/testing/selftests/bpf'
>
> Into:
>
> libbpf: failed to find BTF for extern 'tcp_cong_avoid_ai' [27] section: -2
> HINT: Please update your clang/llvm toolchain to at least cset abcdef123456
> HINT: That is where clang started generating BTF information for extern functions in BPF code.
>
> ?
>
> :-)

I'd rather not :)

>
> - Arnaldo
