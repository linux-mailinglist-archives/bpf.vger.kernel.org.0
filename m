Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE6720FA21
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 19:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390010AbgF3RGx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 13:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390009AbgF3RGw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 13:06:52 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA49EC061755
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 10:06:52 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id e22so16906744edq.8
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 10:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ep4v7Sgk0x30ZAXgHmmvI+chKVNBUjoHn6j3LyL4OVk=;
        b=bDLuMC1J3ipv5oxg6WsuGLNLBbaQ55mOuGN9gmYd6tux50ZveMInMrUVjkMhagmtQ5
         qLh1w/kcYRGFnMfNjLBP+bjgbKz0yTX5dUcCzabJRir+X9IwGpmmbEP2RWkxzYIDhJt9
         UTsF2pc9EMEECfBDdQEKoYZ3atlchjta3NnSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ep4v7Sgk0x30ZAXgHmmvI+chKVNBUjoHn6j3LyL4OVk=;
        b=HzWzrNzN8gsTog3uXC92mhE/mgSH8szP7FR1SMsChy5vWloKOSapSTSytI+ybx+ZZa
         BSsin1XjjCrgS+6OEaVO7PCRxyeZwBGlJDmHeY0FMjjs3RVwa1Dk0Jdojq1WebczxJwL
         HBaj2H4BX+Wpl3FylwbMFrZcZWZ1i3tpszn8Y0id0xnyqgMpYTqPFgQDtB2IRNgLCamJ
         NIPvD6wUmAZPLK4hA7rmZENR4XgjxOV/YEWcVOC2B/mBWzhkd/SqUWSkQQDYOyCgP0zY
         BfCg+geJa0HWzT9soxIZnyLzwk9zCD7SLgco4wSQlDfviPSWU5E5TMuxs5jtJ+g5UdBr
         R2uw==
X-Gm-Message-State: AOAM532hLABn56/qa/EUgxOKRna0dOJ5hvBK2pbxzaiMMl8P7tV7yhiO
        2Jb1x3TPhEnfV42KbhMgL4kw0xrl1yY=
X-Google-Smtp-Source: ABdhPJzEJdNInpg4AvH0cAXMiR+v0rDkO9iumnGuYgiJqEuWBNrsJuHW+IKJOS9L/zJvUFL747Fxqg==
X-Received: by 2002:a50:83c6:: with SMTP id 64mr24913141edi.41.1593536810956;
        Tue, 30 Jun 2020 10:06:50 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id j89sm3565604edb.20.2020.06.30.10.06.50
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 10:06:50 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id o18so16965585eje.7
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 10:06:50 -0700 (PDT)
X-Received: by 2002:a2e:999a:: with SMTP id w26mr5624686lji.371.1593536343609;
 Tue, 30 Jun 2020 09:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200625095725.GA3303921@kroah.com> <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com> <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org> <87y2oac50p.fsf@x220.int.ebiederm.org>
 <87bll17ili.fsf_-_@x220.int.ebiederm.org> <87imf963s6.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87imf963s6.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Jun 2020 09:58:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihqhksXHkcjuTrYmC-vajeRcNh3s6eeoJNxS7wp77dFQ@mail.gmail.com>
Message-ID: <CAHk-=wihqhksXHkcjuTrYmC-vajeRcNh3s6eeoJNxS7wp77dFQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] umh: Separate the user mode driver and the user
 mode helper support
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 29, 2020 at 1:05 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> This makes it clear which code is part of the core user mode
> helper support and which code is needed to implement user mode
> drivers.
>
>  kernel/umd.c             | 146 +++++++++++++++++++++++++++++++++++++++
>  kernel/umh.c             | 139 -------------------------------------

I certainly don't object to the split, but I hate the name.

We have uml, umd and umh for user mode {linux, drivers, helper}
respectively.And honestly, I don't see the point in using an obscure
and unreadable TLA for something like this.

I really don't think it would hurt to write out even the full name
with "usermode_driver.c" or something like that, would it?

Then "umd" could be continued to be used as a prefix for the helper
functions, by all means, but if we startv renaming files, can we do it
properly?

                   Linus
