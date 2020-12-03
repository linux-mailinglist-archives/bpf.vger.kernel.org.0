Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D162CCB40
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 01:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgLCAwU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 19:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgLCAwT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 19:52:19 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DD2C0613D6
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 16:51:39 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id s9so545658ljo.11
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 16:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d+6R3ZBJrp5qSpF0aa6Mkh6cOokCizexgW/CdcNmHTY=;
        b=ASNjaIRtl95OE1GspYHfBEp/sNsaIl15ojatD2bz0euFwGJ8bCR16/qp856FQMydoP
         oJM8ybE+t50VFTKtKIkTQf8R/xzNg9UKmBy4llqFMHq2vnOB8eep8c5KzqTSGj7pzeS2
         AU36R+f9dg1Q3vPoR70rk8L7U9CXqPOrsHXyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d+6R3ZBJrp5qSpF0aa6Mkh6cOokCizexgW/CdcNmHTY=;
        b=XxAgb3OhUBvX9bJmc3SlCADRsq3jP9lFVTQE7G4iKGscjiiF3jC6/SuXkgJMXyshXh
         54psv6S1rE6oejvlyMB+aePQqyLcWau0FepxlagZnbA4NoI6EKsojwXUSky0n61xTBwi
         GsKiCqNu1dWk+clL8NNQ6xqh7UIvvgEVZ7Gmi/HvrOcPZnsIX6KI3HnlaLWWuZI9sYG2
         tbUEKm+JmYC2YdDqNRAzECoon4150MyV5EXVRcrl7teGVzh5tJCN1dF2oUq7ggVAnCgq
         sujzzYnOG0jinSt83UxwyzbPMnvOzbr6EJE5PCLXaYgwZnSHzis1SrdjAH+H0+Och+wa
         aDXw==
X-Gm-Message-State: AOAM532D2PMB80+O7jraTZjw6Z35Ah6E2mfZ6cCy2ziPl8b17apMPQu7
        /8WC3pviqDFIVACndoroCDi3X17W4eQqQPVlY6WGcjBAiFrDOg==
X-Google-Smtp-Source: ABdhPJyR+0O2bJpIpL8ivQNY3B03OB6uKlxI6phEkOgo6hOXUUtcD80Mjs0gLIIc5II0ANgK4QV9sYjoBleDLazpcXg=
X-Received: by 2002:a2e:80c6:: with SMTP id r6mr193952ljg.83.1606956697885;
 Wed, 02 Dec 2020 16:51:37 -0800 (PST)
MIME-Version: 1.0
References: <20201202223944.456903-1-kpsingh@chromium.org> <CAEf4BzaijbvqoajZGT+Gar57ACbCdNJcmBtYbfO2DdOhDevhNw@mail.gmail.com>
In-Reply-To: <CAEf4BzaijbvqoajZGT+Gar57ACbCdNJcmBtYbfO2DdOhDevhNw@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 3 Dec 2020 01:51:27 +0100
Message-ID: <CACYkzJ5peyXw3tk2K5nAKBdjg4okPEdfvEutU0xp1g4G91MxuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] selftests/bpf: Update ima_setup.sh for busybox
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 3, 2020 at 12:13 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Dec 2, 2020 at 2:39 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > * losetup on busybox does not output the name of loop device on using
> >   -f with --show. It also dosn't support -j to find the loop devices
> >   for a given backing file. losetup is updated to use "-a" which is
> >   available on busybox.
> > * blkid does not support options (-s and -o) to only display the uuid.
> > * Not all environments have mkfs.ext4, the test requires a loop device
> >   with a backing image file which could formatted with any filesystem.
> >   Update to using mkfs.ext2 which is available on busybox.
> >
> > Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
> > Reported-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
>
> Thanks for the fixes!
>
> You have three related patches, please add a cover letter to the patch
> set as well.

Will do.

>
> >  tools/testing/selftests/bpf/ima_setup.sh | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
> > index 15490ccc5e55..d864c62c1207 100755
> > --- a/tools/testing/selftests/bpf/ima_setup.sh
> > +++ b/tools/testing/selftests/bpf/ima_setup.sh
> > @@ -3,6 +3,7 @@
> >
> >  set -e
> >  set -u
> > +set -o pipefail
> >
> >  IMA_POLICY_FILE="/sys/kernel/security/ima/policy"
> >  TEST_BINARY="/bin/true"
> > @@ -23,13 +24,15 @@ setup()
> >
> >          dd if=/dev/zero of="${mount_img}" bs=1M count=10
> >
> > -        local loop_device="$(losetup --find --show ${mount_img})"
> > +        losetup -f "${mount_img}"
> > +        local loop_device=$(losetup -a | grep ${mount_img:?} | cut -d ":" -f1)
> >
> > -        mkfs.ext4 "${loop_device}"
> > +        mkfs.ext2 "${loop_device:?}"
> >          mount "${loop_device}" "${mount_dir}"
> >
> >          cp "${TEST_BINARY}" "${mount_dir}"
> > -        local mount_uuid="$(blkid -s UUID -o value ${loop_device})"
> > +       local mount_uuid="$(blkid ${loop_device} | sed 's/.*UUID="\([^"]*\)".*/\1/')"
>
> tabs/spaces mix up here?

Yeah, it seems like the whole file is formatted with spaces and I
added tabs here. Added a patch
at the end of the series which reindents this. I have not added the
"Fixes" tag since it's not
a fix, do feel free to add it, if you think that's the norm for these
kinds of indentation fixes.

>
> > +
> >          echo "measure func=BPRM_CHECK fsuuid=${mount_uuid}" > ${IMA_POLICY_FILE}
> >  }
> >
> > @@ -38,7 +41,8 @@ cleanup() {
> >          local mount_img="${tmp_dir}/test.img"
> >          local mount_dir="${tmp_dir}/mnt"
> >
> > -        local loop_devices=$(losetup -j ${mount_img} -O NAME --noheadings)
> > +        local loop_devices=$(losetup -a | grep ${mount_img:?} | cut -d ":" -f1)
>
> didn't know about :?, fancy

Thanks :) It has helped me in rm -rf ${dir:?}/${file:?}

>
>
> > +
> >          for loop_dev in "${loop_devices}"; do
> >                  losetup -d $loop_dev
> >          done
> > --
> > 2.29.2.576.ga3fc446d84-goog
> >
