Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6562CD420
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 12:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgLCLAs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 06:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgLCLAr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 06:00:47 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AC9C061A4D
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 03:00:01 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id t6so2044255lfl.13
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 03:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1437M8M+BKOn4z3M82llzygtKCxqufkAO8QfVnhJsvs=;
        b=P61LT3ip560+qzgPz2ccz/SMsf++m2W0WEhLiN/iWN+ZHG+bliNSj3i79drWb36U62
         xVtk+rKYl1ENo4S1CfKdTKOUw0NOQpW4WQtPxEaZpadtje4stJab9csqQ6Pzmx6ERYYn
         A5qRLVgEcnGx1IFNEUHclLNOrq20m3nIBvSuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1437M8M+BKOn4z3M82llzygtKCxqufkAO8QfVnhJsvs=;
        b=X5r9q0KfC6WEr8bb1kxW2CP2S6hECkF3fzB+SE2AMEbKlWZfZQtV9CJrUMsyw3jWW8
         zI4A1KuKvRvnKnLcFulmkvEzEIc0dNchKDjDM5ftNESjB2jluu9flAZKUg8IpnHNT7fq
         OTaIZbSHgxPtO7BEWgKidiOYZ3cHmN81V5HQCdSgCSsaBIe3ATt7HyGYbkd6/sw/TVYW
         odeaXd2YzEj81xQd6H66vMNLxTdKvkzpzigwddTVeJc8CNE7sVEePwgC2YgV/vkEGqjk
         KAoKSKlJUq1w+/GUemrPLtd2SH8dnCdKowSaAOblB9XI8lxWU28zHJAK5itWP7UxMlZp
         wf5w==
X-Gm-Message-State: AOAM533P7Qr2coP/O2/wcATehqvgK7EsVArIdVX4e5hYdBPBPC/TKanM
        fNXcheKdsib/lMdyUkuosz0ZRiHCS0Qk/F4IeOfxmA==
X-Google-Smtp-Source: ABdhPJy6+PCnIQ34xrKkbtDmzyRJ6odmIpXMEKXuqIrXehMszjyPiH6NOCdw0BOkuNks9NnYI7D0fr+3+0PPQW7UBnU=
X-Received: by 2002:a05:6512:110a:: with SMTP id l10mr1062413lfg.167.1606993199705;
 Thu, 03 Dec 2020 02:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20201203005807.486320-1-kpsingh@chromium.org> <20201203005807.486320-2-kpsingh@chromium.org>
 <CAEf4BzZPNWVzTMuFeTZzBkgj+5Q0vxFM0+vY+60s0Eqb7_pcCQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZPNWVzTMuFeTZzBkgj+5Q0vxFM0+vY+60s0Eqb7_pcCQ@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 3 Dec 2020 11:59:49 +0100
Message-ID: <CACYkzJ6BfPoVq3HYjuB7_0Z-7+aQisD-AWm-91hW3eQFAT3Jqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] selftests/bpf: Update ima_setup.sh for busybox
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 3, 2020 at 6:52 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Dec 2, 2020 at 4:58 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > * losetup on busybox does not output the name of loop device on using
> >   -f with --show. It also dosn't support -j to find the loop devices
>
> typo: doesn't

Fixed.

>
> >   for a given backing file. losetup is updated to use "-a" which is
> >   available on busybox.
> > * blkid does not support options (-s and -o) to only display the uuid.
>
> ... so parse it from full blkid output.

Done.

>
> > * Not all environments have mkfs.ext4, the test requires a loop device
> >   with a backing image file which could formatted with any filesystem.
> >   Update to using mkfs.ext2 which is available on busybox.
>
> This one is great. It explains the problem, and what solution was
> implemented, from the high-level. I'd just drop the " *" marks, it
> makes it more pleasant to read as if it was written for humans, not
> machines.

I tend to use "* " for bullet points from the markdown syntax
(as we use it heavily internally) I can avoid if you prefer / don't like it.


>
> > Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
> > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  tools/testing/selftests/bpf/ima_setup.sh | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> > diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
> > index 15490ccc5e55..137f2d32598f 100755
> > --- a/tools/testing/selftests/bpf/ima_setup.sh
> > +++ b/tools/testing/selftests/bpf/ima_setup.sh
> > @@ -3,6 +3,7 @@
> >
>
> [...]
