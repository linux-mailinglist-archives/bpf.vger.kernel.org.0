Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9F430B391
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 00:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhBAX3d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Feb 2021 18:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhBAX3a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Feb 2021 18:29:30 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD48C0613D6
        for <bpf@vger.kernel.org>; Mon,  1 Feb 2021 15:28:50 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id l9so27086098ejx.3
        for <bpf@vger.kernel.org>; Mon, 01 Feb 2021 15:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VDDDMGeZgeGfLKxau3myPioWv4n074pF5HEIiOPCr8k=;
        b=1j7hdNeAkSiyAdmcvrt/9HHMNuyxg1M3xl28O0g55cofOmJ+q+yVaf8UFrFb26bldY
         tj+UeQHttsgWBKK6G1FatDZvsRmThV3sYGDvyr5803f4SapTpAHd3tV1SZgAwSX2HZ8E
         zUzfHrS2AZOPebslNLxECEnv4pRH9zUFmTNhIOvn62xA+PmzlsFoxRqY0umZHKMU8+R6
         FYVtr8c5pdmDKTId5/DT2Ji5JW6yngV4HnUPNViSGySw1MXn2bhOdiN/U+WYD/xoV4it
         A2nkCLsS9Ed9c1g/bpUjuK3E4RDx2BP+fh2rZdM9Jqx2Ei+vkHf09UzmW40gfuyMKgj5
         ALqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VDDDMGeZgeGfLKxau3myPioWv4n074pF5HEIiOPCr8k=;
        b=WCEPN2ID9UBu/QE1fmbtMAFLh9UVJVPH/QXjtgOzaACFJGD22wVoLLg8++/MOProUk
         48QX0I75r/ShpGcfc2+DUeImjn6GAAK6y+kum08rcQBJIGrBBDBwoVkeodZQOi5EWhNj
         lzlMt2+mbWEkwuG1umBIJ0jOY9oNQk7IDDr+CaxX3rR2t8YUlxW7KMZ+DW5qcOSs4Wmj
         2ueP8+9NV16zrXWbcbOyjvae84HueF3bK5i6BLtlsywBB00oFyqrp13UlaPx3C0HNmuL
         nUZTO0/WsuttCxXUt87P5zrxGGtn5ErvVBXJUc/WTyxP3eiEliVLmGHrxx/f4+Eh8VQh
         ntpQ==
X-Gm-Message-State: AOAM530H/UK80zzDycQlFmob5lpb0w45pMWmX9uXWkQftoDoBvkl9Gsq
        Pqdx9bGxgIaoynCxHWjtjCBFFbN8hHncvDmM0Aav
X-Google-Smtp-Source: ABdhPJxLFutPtdd5HQOynfaFTyLVOpKzvY9yvWT+YQNUX1BQMYX5y1P00/41qsvOL0dkbLmCIJnX+NO7+lHhn967eaU=
X-Received: by 2002:a17:906:35d9:: with SMTP id p25mr7917656ejb.398.1612222128711;
 Mon, 01 Feb 2021 15:28:48 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhQgy959hkpU8fwZnrTqGphVSA+ONF99Yy4ZQFyjQ_030A@mail.gmail.com>
 <CAADnVQJaJ0i2L2k-dM+neeT61q+pwEd+F6ASGh4Xbi-ogj0hfQ@mail.gmail.com>
 <CAHC9VhSTJ=009hsXm=8jtQ_ZL-n=+tzKPbWj2Cnoa5w3iVNuew@mail.gmail.com>
 <CAADnVQKbku+Mv++h2TKYZfFN7NjPgaeLHJsw0oFNUhjUZ6ehSQ@mail.gmail.com>
 <YBXGChWt/E2UDgZc@krava> <YBci6Y8bNZd6KRdw@krava> <20210201122532.GE794568@kernel.org>
 <YBgVLqNxL++zVkdK@krava> <YBhjOaoV2NqW3jFI@krava> <CAFqZXNsjzQ-2x4-szW5pBg77bzSK-RmwPvQSN+UaxJXqqZ_2qA@mail.gmail.com>
In-Reply-To: <CAFqZXNsjzQ-2x4-szW5pBg77bzSK-RmwPvQSN+UaxJXqqZ_2qA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 1 Feb 2021 18:28:37 -0500
Message-ID: <CAHC9VhQbt+fQAhnSaf3+wVVK8gy26dTbcvvA8Q=vOUepVd0+tQ@mail.gmail.com>
Subject: Re: selftest/bpf/test_verifier_log fails on v5.11-rc5
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 1, 2021 at 5:43 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Mon, Feb 1, 2021 at 9:23 PM Jiri Olsa <jolsa@redhat.com> wrote:

...

> > Paul, Ondrej,
> >
> > I put all the recent fixes and made a scratch build:
> >   https://koji.fedoraproject.org/koji/taskinfo?taskID=61049457
> >
> > if you have a chance to test and check your issue was resolved,
> > that'd be great
>
> I just built the current master branch of dwarves (d783117162c0, which
> includes Jirka's patch) [1] in COPR [2] and then rebuilt the kernel
> with it [3]. With the new dwarves, the issue seems to be fixed -
> /sys/kernel/btf/vmlinux is back to ~4MB and the selinux-testsuite BPF
> subtest passes.
>
> Thanks everyone for getting to the bottom of this! Hoping to see an
> updated dwarves in rawhide soon ;)

Yes, thanks!

I've updated my test systems and I'm building a x86_64 and aarch64
kernel now to test; based on Ondrej's reports I'm sure it will work
just fine, but I'll report back if I run into any issues.

-- 
paul moore
www.paul-moore.com
