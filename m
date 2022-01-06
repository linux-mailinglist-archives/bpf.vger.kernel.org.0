Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B33548610E
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 08:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbiAFHgA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 02:36:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234484AbiAFHgA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 02:36:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641454559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AEFQlVA9J+Qx8w96jEaYfkIxheVg9gvGPPb9iwESRbQ=;
        b=HzZze9WnKdm8FICovaUmZTZ/4b7LyKYod9rzIsL4KHjSSN4wCvCPpmorruriVH4mj2dFQg
        hb0TI1zaM4Wuj2SOmWA4A39mDH/bBqIBSrfdMaaRYv22bVBYiMZn3GUutPIeh7QewGmeZK
        ujAkfPJ6VqVp9sHk6Z5sudWqU7CTAzc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-AuUWn4W9OrK-zlvLAQ5CcA-1; Thu, 06 Jan 2022 02:35:22 -0500
X-MC-Unique: AuUWn4W9OrK-zlvLAQ5CcA-1
Received: by mail-ed1-f69.google.com with SMTP id w6-20020a05640234c600b003f916e1b615so1284500edc.17
        for <bpf@vger.kernel.org>; Wed, 05 Jan 2022 23:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AEFQlVA9J+Qx8w96jEaYfkIxheVg9gvGPPb9iwESRbQ=;
        b=H5VAhVwH9cCT038znJ0lyUIThS6YEbzCa1jAiU3vCarzzuyru1Su4I5CNo0S9kNeaz
         R/lbk5PbAvM/aiAO5tlZfyfnDOSldhY2h0C5ncuWxNgmgTg7s5wafcjfoN11O7vVsqpT
         BCDzOMCnpkOlrKtrbhumQcdTi3F0PCgnF4WZTi3ANW/jyZ/4IPV302GFVVgJKim3Y+BC
         FjJ3D+93OvVinn0UeQKdv7Ra5fwZcrT0dtToScsh2UsWj+RLaqMY7ggj6iXJO4Ft2S4A
         8G0ikHtE9y9Dx2pjBOY3giMocRF0euf+AdQHpY+hGO/H6Lnu40rTzpsRPOzYxpwsGOB4
         ggQA==
X-Gm-Message-State: AOAM530k/YhxNo/vH/bQIbvvZooDgwx/k8QplB00yf1f6x4lFW0ACYt6
        A+aR0E5x8KFPzfE/iPkgRcsN+safnjmuD7LXxOjxwtB1DeuiTpalADcMTRG7xahMMmOncOOSOHv
        CBqRildGJ2Dgm
X-Received: by 2002:a05:6402:510f:: with SMTP id m15mr50933624edd.190.1641454521041;
        Wed, 05 Jan 2022 23:35:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwU+iHiapmdEBhccnm8V1VumFUZEjWXLND9fcjVL+7obg0MWbalTfKXtb8LsrUQpQKjmfvjaQ==
X-Received: by 2002:a05:6402:510f:: with SMTP id m15mr50933604edd.190.1641454520855;
        Wed, 05 Jan 2022 23:35:20 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id n25sm431773eds.9.2022.01.05.23.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 23:35:20 -0800 (PST)
Date:   Thu, 6 Jan 2022 08:35:18 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jussi Maki <joamaki@gmail.com>, Hangbin Liu <haliu@redhat.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH] bpf/selftests: Fix namespace mount setup in tc_redirect
Message-ID: <Ydabtmk+BmzIxKwJ@krava>
References: <20220104121030.138216-1-jolsa@kernel.org>
 <CAEf4BzZK1=zdy1_ZdwWXK7Ryk+uWQeSApcpxFT9yMp4bRNanDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZK1=zdy1_ZdwWXK7Ryk+uWQeSApcpxFT9yMp4bRNanDQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 05, 2022 at 12:40:34PM -0800, Andrii Nakryiko wrote:
> On Tue, Jan 4, 2022 at 4:10 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > The tc_redirect umounts /sys in the new namespace, which can be
> > mounted as shared and cause global umount. The lazy umount also
> > takes down mounted trees under /sys like debugfs, which won't be
> > available after sysfs mounts again and could cause fails in other
> > tests.
> >
> >   # cat /proc/self/mountinfo | grep debugfs
> >   34 23 0:7 / /sys/kernel/debug rw,nosuid,nodev,noexec,relatime shared:14 - debugfs debugfs rw
> >   # cat /proc/self/mountinfo | grep sysfs
> >   23 86 0:22 / /sys rw,nosuid,nodev,noexec,relatime shared:2 - sysfs sysfs rw
> >   # mount | grep debugfs
> >   debugfs on /sys/kernel/debug type debugfs (rw,nosuid,nodev,noexec,relatime)
> >
> >   # ./test_progs -t tc_redirect
> >   #164 tc_redirect:OK
> >   Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED
> >
> >   # mount | grep debugfs
> >   # cat /proc/self/mountinfo | grep debugfs
> >   # cat /proc/self/mountinfo | grep sysfs
> >   25 86 0:22 / /sys rw,relatime shared:2 - sysfs sysfs rw
> >
> > Making the sysfs private under the new namespace so the umount won't
> > trigger the global sysfs umount.
> 
> Hey Jiri,
> 
> Thanks for the fix. Did you try making tc_redirect non-serial again
> (s/serial_test_tc_redirect/test_tc_redirect/) and doing parallelized
> test_progs run (./test_progs -j) in a tight loop for a while? I
> suspect this might have been an issue forcing us to make this test
> serial in the first place, so now that it's fixed, we can make
> parallel test_progs a bit faster.

hi,
right, will try

jirka

> 
> >
> > Cc: Jussi Maki <joamaki@gmail.com>
> > Reported-by: Hangbin Liu <haliu@redhat.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/tc_redirect.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> > index 4b18b73df10b..c2426df58e17 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
> > @@ -105,6 +105,13 @@ static int setns_by_fd(int nsfd)
> >         if (!ASSERT_OK(err, "unshare"))
> >                 return err;
> >
> > +       /* Make our /sys mount private, so the following umount won't
> > +        * trigger the global umount in case it's shared.
> > +        */
> > +       err = mount("none", "/sys", NULL, MS_PRIVATE, NULL);
> > +       if (!ASSERT_OK(err, "remount private /sys"))
> > +               return err;
> > +
> >         err = umount2("/sys", MNT_DETACH);
> >         if (!ASSERT_OK(err, "umount2 /sys"))
> >                 return err;
> > --
> > 2.33.1
> >
> 

