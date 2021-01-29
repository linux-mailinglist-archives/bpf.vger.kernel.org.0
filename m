Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1AA308FEF
	for <lists+bpf@lfdr.de>; Fri, 29 Jan 2021 23:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbhA2WQU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jan 2021 17:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbhA2WQR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jan 2021 17:16:17 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F62CC061573
        for <bpf@vger.kernel.org>; Fri, 29 Jan 2021 14:15:36 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hs11so15155237ejc.1
        for <bpf@vger.kernel.org>; Fri, 29 Jan 2021 14:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mq4ASsjX+kVkhvdmQEYh8nWrR6ns9uJZ4+cZaSYQ7VI=;
        b=WW+uQKJTGenAPj7XJfIOgN0MEmdrH/V+a/c3b5p1/JLw4fkiEFJndNBaB7S0otyrYq
         p6Wde4HTQEHFEgUMqANyXNhEKlAB89X3CL15jZOvfC56HPrrI/EE47Il8guN33OLUZdC
         dVCKRw7eOJdAx6Viu3GBgNdzfSpuBsmiVS+izGzKzcJVcAtTJAosgqD8BoWkx6C4w306
         Dlyf0x7n5ar0kb/6JyRWwWQf/Wul6DE9YgY/eZViMvwNS+aHb1MJP55FfPQh5bltYqxR
         gLXy/ZbFClipGyrrnrWJp05cVvMyxzrLsBHFbfFdlYtXV8nTYTzfss9wvVT/7/C14EwK
         k5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mq4ASsjX+kVkhvdmQEYh8nWrR6ns9uJZ4+cZaSYQ7VI=;
        b=sEmR5kKWaOLxw/TAHrFDQ/4Fd1JvkwaSGhDYmkqQTPYkjan9hOlH3WBM2I+x7dHyNx
         upaIE80poUAS476suvkdsRoFIOCH6+HifxS7+rhGRA6hz3zqdT305ZGCTbV1uZ1jqKlI
         mIGsJOUGFMr9fyDzptdh+twHZrl2JIRs7JkhqfD85+wA47zshJ4QlLz05ppPNy+KDjQI
         iY41vmLJR7eXGLS1W5P1ABnYJRViQ1FN5BpsZLFkHlPaS3MqStQXauNS7tZkCMf+AxlB
         520M+4i3dmVi8RwerIbotcOVfLPWcKqPfzc8+Ml/oNnJ1+uFYyqMU7wNr9lmyPaeQhAV
         qw+w==
X-Gm-Message-State: AOAM531BzlVlusJECAqj9tVZPnDrSCv3DyetVPYueqT/mKFIS50r5A/4
        qouXjZKTD59IUJT5w5P1exRrPjKsUWttjBhKqqwB
X-Google-Smtp-Source: ABdhPJxR2hVwmKDUZcFOxVE2rUwfoZn7+pqG+iMjKeX3xHEUK4BA8KsFPruinRNREUP9JBOMW765Jjlif/dmcp1szjs=
X-Received: by 2002:a17:906:48c:: with SMTP id f12mr6519721eja.431.1611958533901;
 Fri, 29 Jan 2021 14:15:33 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhQgy959hkpU8fwZnrTqGphVSA+ONF99Yy4ZQFyjQ_030A@mail.gmail.com>
 <CAADnVQJaJ0i2L2k-dM+neeT61q+pwEd+F6ASGh4Xbi-ogj0hfQ@mail.gmail.com>
In-Reply-To: <CAADnVQJaJ0i2L2k-dM+neeT61q+pwEd+F6ASGh4Xbi-ogj0hfQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 29 Jan 2021 17:15:22 -0500
Message-ID: <CAHC9VhSTJ=009hsXm=8jtQ_ZL-n=+tzKPbWj2Cnoa5w3iVNuew@mail.gmail.com>
Subject: Re: selftest/bpf/test_verifier_log fails on v5.11-rc5
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 25, 2021 at 5:42 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Mon, Jan 25, 2021 at 12:54 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > Hello all,
> >
> > My apologies if this has already been reported, but I didn't see
> > anything obvious with a quick search through the archives.  I have a
> > test program that behaves very similar to the existing
> > selftest/bpf/test_verifier_log test that has started failing this week
> > with v5.11-rc5; it ran without problem last week on v5.11-rc4.  Is
> > this a known problem with a fix already, or is this something new?
> >
> > % uname -r
> > 5.11.0-0.rc5.134.fc34.x86_64
> > % pwd
> > /.../linux/tools/testing/selftests/bpf
> > % git log --oneline | head -n 1
> > 6ee1d745b7c9 Linux 5.11-rc5
> > % make test_verifier_log
> >   ...
> >   BINARY   test_verifier_log
> > % ./test_verifier_log
> > Test log_level 0...
> > Test log_size < 128...
> > Test log_buff = NULL...
> > Test oversized buffer...
> > ERROR: Program load returned: ret:-1/errno:22, expected ret:-1/errno:13
>
> Thanks for reporting.
> bpf and bpf-next don't have this issue. Not sure what changed.

I haven't had a chance to look into this any further, but Ondrej
Mosnacek (CC'd) found the following today:

"So I was trying to debug this further and I think I've identified what
triggers the problem. It seems that the BTF debuginfo generation
became broken with CONFIG_DEBUG_INFO_DWARF4=n somewhere between -rc4
and -rc5. It also seems to depend on a recent (Fedora Rawhide) version
of some component of the build system (GCC, probably), because the
problem disappeared when I tried to build the "bad" kernel in F33
buildroot instead of Rawhide."

-- 
paul moore
www.paul-moore.com
