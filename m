Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF782CCB3C
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 01:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgLCAut (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 19:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbgLCAut (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 19:50:49 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87F3C0613D6
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 16:50:08 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id t6so175471lfl.13
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 16:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QRul32lEVlm6jQl9riNW/TMmmhejhdbJ1PwfBI52veI=;
        b=lMSA8FuQxxkT5a//pRpb2gzXgfotuR1VePw+veV1A/Snw0FVOEWyoxrZ4ALLSnGBlB
         hC8roqqp6uQILZL8PSIcvj72dZMsiNBp3cRgqLpbT/seOTgqerMaCZOnpXRI81odVw8H
         xrRGQ39py5beUaFKgow3C5aUapuOij1Xpx+NE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRul32lEVlm6jQl9riNW/TMmmhejhdbJ1PwfBI52veI=;
        b=IFsXDDLBTqFi9BHEqR3hhOmcSpaM7ZM8zbTa6kNgT+LQ/K/qalSA+TG0EDamVaNocy
         JBBQOV7ZyChd5SjFhXCS6WRxZ8cO28x7bpKShUD6hjNDIq9d/uOFfGM5Qz1RvHTX/h5t
         9np2fienZ/wWOliq8gXbFGrSxd+2HWhLbE+fvNWKCwiKetbXFU0eLdAqo8PzWzc0n0Ee
         O69tLUZRNrEiUDzVWs03G/eYEg9ZBrqpkL+s3xugKqEqpXIn4IbzY2guKZ5Nxo4WusSi
         rJuGnYskEaTeX4XXMEb75qkxmvvGz9NlsZjAEDoJC6ZqqC59kL5mLnyf3xdNkc2+Yqyr
         sMaw==
X-Gm-Message-State: AOAM532DsPIx5ncMPAU8SUhXgM/5A2zjmvuLDhOyrr1CNb9oy/Bo9HWz
        BbF7b7XsCRkn0SwKDKvCwPioMNqUhfFbmVHkkmLgzg==
X-Google-Smtp-Source: ABdhPJyKr3M0Z36uobRcJA1r3xI4LRYKIpzsaA1SKyswH+o4RqVQ5QEl3YbPcpB14v7L+axesuomWur+pNniF8jAwWE=
X-Received: by 2002:ac2:5591:: with SMTP id v17mr298226lfg.562.1606956607332;
 Wed, 02 Dec 2020 16:50:07 -0800 (PST)
MIME-Version: 1.0
References: <20201202223944.456903-1-kpsingh@chromium.org> <20201202223944.456903-2-kpsingh@chromium.org>
 <CAEf4BzYUwP59SNhTFVFQ1PdVg6hfvTeKtHDqPSxoi6HMW+Q-pg@mail.gmail.com>
In-Reply-To: <CAEf4BzYUwP59SNhTFVFQ1PdVg6hfvTeKtHDqPSxoi6HMW+Q-pg@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 3 Dec 2020 01:49:56 +0100
Message-ID: <CACYkzJ47pa7L22ne+=V_jcyezRiF3jP+48gtRUH4zua4dLYf=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: Ensure securityfs mount
 before writing ima policy
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
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
> > SecurityFS may not be mounted even if it is enabled in the kernel
> > config.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
>
> please add those tags in v2 :)

Done.

>
> >  tools/testing/selftests/bpf/ima_setup.sh | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
> > index d864c62c1207..1da2d97a0e72 100755
> > --- a/tools/testing/selftests/bpf/ima_setup.sh
> > +++ b/tools/testing/selftests/bpf/ima_setup.sh
> > @@ -14,6 +14,20 @@ usage()
> >          exit 1
> >  }
> >
> > +ensure_mount_securityfs()
> > +{
> > +        local securityfs_dir=$(grep "securityfs" /proc/mounts | awk '{print $2}')
> > +
> > +        if [ -z "${securityfs_dir}" ]; then
> > +               securityfs_dir=/sys/kernel/security
> > +               mount -t securityfs security "${securityfs_dir}"
> > +       fi
>
> again, something is off with indentation here

Yeah, changed it to spaces and added a patch at the end which changes
it to tabs.
Checkpatch did not catch it, maybe it ignores shell scripts :(

>
> > +
> > +       if [ ! -d "${securityfs_dir}" ]; then
> > +               echo "${securityfs_dir} :securityfs is not mounted" && exit 1
>
> nit: " :" => ": " or it was intended this way?

Fixes. Thanks.

>
>
> > +       fi
> > +}
> > +
> >  setup()
> >  {
> >          local tmp_dir="$1"
> > @@ -33,6 +47,7 @@ setup()
> >          cp "${TEST_BINARY}" "${mount_dir}"
> >         local mount_uuid="$(blkid ${loop_device} | sed 's/.*UUID="\([^"]*\)".*/\1/')"
> >
> > +        ensure_mount_securityfs
> >          echo "measure func=BPRM_CHECK fsuuid=${mount_uuid}" > ${IMA_POLICY_FILE}
> >  }
> >
> > --
> > 2.29.2.576.ga3fc446d84-goog
> >
