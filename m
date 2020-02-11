Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08E0F159D2A
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2020 00:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgBKX00 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Feb 2020 18:26:26 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44782 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbgBKX00 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Feb 2020 18:26:26 -0500
Received: by mail-lj1-f195.google.com with SMTP id q8so96263ljj.11;
        Tue, 11 Feb 2020 15:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+UnFJdAm9s/f93leG1ycIqg/kGef55fT1Md7EMcfbM=;
        b=kLJeqEt5CYtm8yUjPsFzYb9Z+Y0vuRc0rVpStu4m6kw4CA52xUgmo2SVKD4xLYQwpb
         tRAheeXe9hu0u6CraeycsJ7+itG45yM4VnVBDtbo/IUeWC0LpB7pIU8dzTssDeFwAR7j
         MtOxnPATkeSWcwTKri1i6ZRt/N/Aj23R2ijnr5hagD6F3i1mMp69nf35zwu+xnOOxizG
         NwLxQyjonLIlZwmnM+ZONki0vHWJShUSPHsiZRQqU/psifcRvbDaCmW3YpIm7byLezLX
         YIKBLGgdczORPtgVgwPYXN1Oq4oDncolkZ6Z1y9+gt4TNSM7bjsLOG6k1vqj/+bp78q1
         B/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+UnFJdAm9s/f93leG1ycIqg/kGef55fT1Md7EMcfbM=;
        b=JOqqR0yZqsqTSqhWQoCRjD+yJjEVBtCIKrY9MbntqRXmRvVoeUNy/BFPdIbfn5XxZv
         AEPCVfR0+IEMQZtDglHE6K+GhW3AP1VqxnkraAla5wG2bUos/UjShwMsSjpjYo5xwC/F
         Of7KM433HDarzsU8kwdeFvuI38l+UBZYqfUxzbEJZd1zxJvh5cVXkz6BPRMfkWhKehS6
         YAWuD8uCTE0pfQGAhkaM0kgDPH727mal9rXM8dK8xGrHKIw8xaQac2ZVKRgZTL5EdP84
         ztlsgtHSwXyD27Ma2s5Cx70P4BjzwlNV+bQDZv6kJevgB3fxrezhBt+bDHnlhT2zoTUe
         WGTQ==
X-Gm-Message-State: APjAAAUj9BKdwePx9YOrtSdsTj2MsuFyB6GwLqYPMcKOyEqhiEffOqix
        BmejVLGPS/uVIxIXyMmtsKoHQ3Z/MV11PBgGqao=
X-Google-Smtp-Source: APXvYqwaKatfhBd0fIQTVs5Yimze4i5NNaCnOiThpMyD9BiV7j3UfnGigS0KE40nNkDY0UIiFZWe669eMpM7R9PkmoA=
X-Received: by 2002:a2e:8145:: with SMTP id t5mr5874745ljg.144.1581463584142;
 Tue, 11 Feb 2020 15:26:24 -0800 (PST)
MIME-Version: 1.0
References: <20200123152440.28956-1-kpsingh@chromium.org> <20200123152440.28956-5-kpsingh@chromium.org>
 <20200211031208.e6osrcathampoog7@ast-mbp> <20200211124334.GA96694@google.com>
 <20200211175825.szxaqaepqfbd2wmg@ast-mbp> <CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com>
 <20200211190943.sysdbz2zuz5666nq@ast-mbp> <CAG48ez2gvo1dA4P1L=ASz7TRfbH-cgLZLmOPmr0NweayL-efLw@mail.gmail.com>
 <20200211201039.om6xqoscfle7bguz@ast-mbp> <CAG48ez1qGqF9z7APajFyzjZh82YxFV9sHE64f5kdKBeH9J3YPg@mail.gmail.com>
 <20200211213819.j4ltrjjkuywihpnv@ast-mbp>
In-Reply-To: <20200211213819.j4ltrjjkuywihpnv@ast-mbp>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 11 Feb 2020 15:26:12 -0800
Message-ID: <CAADnVQLsiWgSBXbuxmpkC9TS8d1aQRw2zDHG8J6E=kfcRoXtKQ@mail.gmail.com>
Subject: Re: BPF LSM and fexit [was: [PATCH bpf-next v3 04/10] bpf: lsm: Add
 mutable hooks list for the BPF LSM]
To:     Jann Horn <jannh@google.com>
Cc:     KP Singh <kpsingh@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 11, 2020 at 1:38 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 11, 2020 at 09:33:49PM +0100, Jann Horn wrote:
> > >
> > > Got it. Then let's whitelist them ?
> > > All error injection points are marked with ALLOW_ERROR_INJECTION().
> > > We can do something similar here, but let's do it via BTF and avoid
> > > abusing yet another elf section for this mark.
> > > I think BTF_TYPE_EMIT() should work. Just need to pick explicit enough
> > > name and extensive comment about what is going on.
> >
> > Sounds reasonable to me. :)
>
> awesome :)

Looks like the kernel already provides this whitelisting.
$ bpftool btf dump file /sys/kernel/btf/vmlinux |grep FUNC|grep '\<security_'
gives the list of all LSM hooks that lsm-bpf will be able to attach to.
There are two exceptions there security_add_hooks() and security_init().
Both are '__init'. Too late for lsm-bpf to touch.
So filtering BTF funcs by 'security_' prefix will be enough.
It should be documented though.
The number of attachable funcs depends on kconfig which is
a nice property and further strengthen the point that
lsm-bpf is very much kernel specific.
We probably should blacklist security_bpf*() hooks though.
Otherwise inception fans will have a field day.
Disallowing bpf with bpf :)
