Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597892CDEA9
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 20:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgLCTTE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 14:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgLCTTE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 14:19:04 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7960AC061A4E
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 11:18:24 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id 2so3029743ybc.12
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 11:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Po9ihbuzHQYSGk6otUQcBtukFjW8BcR4dGnpKg/6h3s=;
        b=PvN3WlsFtFscq0uVFpYo1xKloTjedqUQ9riu+GD4zpaMubQVWKm6czgXB12rnBZUPe
         B4EuGTHm/8DYuBDtjOp7va0y4rwVqS3Y2OFqew53Mten8jo3sbJ2xxR9gCw7sWmNID2x
         +6eLg/GkIJsRBUhKakmn4ovIQcOgXJHIrZ2cLGLGKypuAyPb7e+GGCgU9s5qXGosfv9f
         qC/nScQtXWtLkI01UGeRYIv45HFHHQXvIdJfK+NNtVRkJ57jIqFNnyUjoYhYhYDgr9qa
         ELC7QYlQa95swH13ODDPNOufXcLA/gC7lpACCwBzy9hDPgUSm1aIvpWYCiTm/bxT1W77
         yqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Po9ihbuzHQYSGk6otUQcBtukFjW8BcR4dGnpKg/6h3s=;
        b=DPctV2cv3137o6B7ZzrilBWuRzoR7y6I/sMFsIGpwNUROKTErh+gaC9CraGqQ62bYB
         4Ri9lpa+BadFaVsiMgV+iE9aV64z3FBxIHBHYuN4He/WB/L4EChL2USoxDk5OhADzq/A
         peenxYxGqr6elIFXw5oEmLHVkXNUBNSc21NsGwmyae/pdRkUr9gC2LhskBOiorZwVyPX
         nKRWHdGWoriP/3DdDrSFd4UeB74P2jFhL2D2IfBec6cXJoeRkSqKCBxYsF3y6D/chVrk
         ahrRjK/ZKkGukSgVvotCAT6tPCPnB1CJcHFWa4dSCloB4vAQqgksifBtQlgmHCLxbJAh
         SpUQ==
X-Gm-Message-State: AOAM533KPWbsVe2KLI5/HmKwFjtUQ0cu04vJ9OU1MGhg8aL3+45yMBd+
        +RpWAIT8vcV0k0M01mvd7hlNn5vl9rO6YaXQASb06yY4nZ4=
X-Google-Smtp-Source: ABdhPJwLL5uz4R/XvSuxkVjyNr4vUkQYOuGBzADP9dVw7q5Jvwl4rimr/yrnLE1972I/NN4rcHoRHdK81pQWLXqIE+E=
X-Received: by 2002:a25:df8e:: with SMTP id w136mr879344ybg.230.1607023103747;
 Thu, 03 Dec 2020 11:18:23 -0800 (PST)
MIME-Version: 1.0
References: <20201203005807.486320-1-kpsingh@chromium.org> <20201203005807.486320-2-kpsingh@chromium.org>
 <CAEf4BzZPNWVzTMuFeTZzBkgj+5Q0vxFM0+vY+60s0Eqb7_pcCQ@mail.gmail.com> <CACYkzJ6BfPoVq3HYjuB7_0Z-7+aQisD-AWm-91hW3eQFAT3Jqw@mail.gmail.com>
In-Reply-To: <CACYkzJ6BfPoVq3HYjuB7_0Z-7+aQisD-AWm-91hW3eQFAT3Jqw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 3 Dec 2020 11:18:12 -0800
Message-ID: <CAEf4BzYNrWv_BqUvK1=kvPtPqH-uu-fGOjwBdBOFx6zHJZfy-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] selftests/bpf: Update ima_setup.sh for busybox
To:     KP Singh <kpsingh@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 3, 2020 at 3:00 AM KP Singh <kpsingh@chromium.org> wrote:
>
> On Thu, Dec 3, 2020 at 6:52 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Dec 2, 2020 at 4:58 PM KP Singh <kpsingh@chromium.org> wrote:
> > >
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > * losetup on busybox does not output the name of loop device on using
> > >   -f with --show. It also dosn't support -j to find the loop devices
> >
> > typo: doesn't
>
> Fixed.
>
> >
> > >   for a given backing file. losetup is updated to use "-a" which is
> > >   available on busybox.
> > > * blkid does not support options (-s and -o) to only display the uuid.
> >
> > ... so parse it from full blkid output.
>
> Done.
>
> >
> > > * Not all environments have mkfs.ext4, the test requires a loop device
> > >   with a backing image file which could formatted with any filesystem.
> > >   Update to using mkfs.ext2 which is available on busybox.
> >
> > This one is great. It explains the problem, and what solution was
> > implemented, from the high-level. I'd just drop the " *" marks, it
> > makes it more pleasant to read as if it was written for humans, not
> > machines.
>
> I tend to use "* " for bullet points from the markdown syntax
> (as we use it heavily internally) I can avoid if you prefer / don't like it.

A list of bullet points don't read as a coherent text. It's not the
end of the world, but it's also not a common style here either.

>
>
> >
> > > Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
> > > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: KP Singh <kpsingh@google.com>
> > > ---
> > >  tools/testing/selftests/bpf/ima_setup.sh | 12 ++++++++----
> > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > >
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > > diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
> > > index 15490ccc5e55..137f2d32598f 100755
> > > --- a/tools/testing/selftests/bpf/ima_setup.sh
> > > +++ b/tools/testing/selftests/bpf/ima_setup.sh
> > > @@ -3,6 +3,7 @@
> > >
> >
> > [...]
