Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB639596B0
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2019 11:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfF1JBi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jun 2019 05:01:38 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34021 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfF1JBi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jun 2019 05:01:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id n5so5284117otk.1
        for <bpf@vger.kernel.org>; Fri, 28 Jun 2019 02:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qUV4kfBHQVUIKfARtG5Yav4Y3FA4sBjhtv6NQ9Qeu8I=;
        b=ivpGvcNMhyqcB3ec1oT53roHxf8bewZ3Phb32ULIMDyniG6NclUbjzZ+a+5XrNDs1b
         SLblk5TVBOPR3Rjk/W0F5n+geCFzDrMLzbT1e9slOxgOjriNHnSCMTmE+dl4TjZUKuh0
         XLHZASHT2NvQWoy5b66tH0j9TEahbD/9GO+J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qUV4kfBHQVUIKfARtG5Yav4Y3FA4sBjhtv6NQ9Qeu8I=;
        b=pv9w3jyjWrmNbhKfWrJeoFDJ4rvf4JuVhmJVmvL2G/jY09k0vbX97QeWnSNQBAEb3n
         6S8j4hEMMVS1UqzZss1s0q+0QXCzdJliem/BnBlYdDA98U5ds+wDhf3oR9wkLeYen53Y
         ZcuJUv3qb8NNItFTldWwpepjtHpb679Q4m57ZgwA0fMVh9LSimDEu6iPOT2cbHRm3adb
         OX4BjoPskMBvXOiPwxv1GPnbV0qz2FKqwmbPsfpcEuWAYiEZnA/OQfxSeG6981H1pH2h
         HSr4QZh3CJ6Y+7ws8J1Ut7hY0cnnTLyvfQjnxWP+rKRt4t1+Lmf/vA4GBiimqc4JDRpW
         NzVg==
X-Gm-Message-State: APjAAAWG1kUa5unmV+IJatPAcz0TQq17RaXZaDcDhAybTSivpO+yD8HO
        y7zxTjsMLJ3JmQBb0WPMl2HfAjT2nvaHHqaO/mc+vw==
X-Google-Smtp-Source: APXvYqyzaKbGnEbZX82tZjeqdRHpKJO2uNGCf/NKctMgnNoP971VgVKcSpcqhzdqJ6FJf2DUKEU5RNJ8x0u4O2p9aIU=
X-Received: by 2002:a05:6830:1485:: with SMTP id s5mr214548otq.132.1561712497511;
 Fri, 28 Jun 2019 02:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190627201923.2589391-1-songliubraving@fb.com> <20190627201923.2589391-2-songliubraving@fb.com>
In-Reply-To: <20190627201923.2589391-2-songliubraving@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 28 Jun 2019 10:01:26 +0100
Message-ID: <CACAyw98RvDc+i3gpgnAtnM0ojAfQ-mHvzRXFRUcgkEPr3K4G-g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: unprivileged BPF access via /dev/bpf
To:     Song Liu <songliubraving@fb.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Jann Horn <jannh@google.com>,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 27 Jun 2019 at 21:19, Song Liu <songliubraving@fb.com> wrote:
>
> This patch introduce unprivileged BPF access. The access control is
> achieved via device /dev/bpf. Users with write access to /dev/bpf are able
> to call sys_bpf().
>
> Two ioctl command are added to /dev/bpf:
>
> The two commands enable/disable permission to call sys_bpf() for current
> task. This permission is noted by bpf_permitted in task_struct. This
> permission is inherited during clone(CLONE_THREAD).

If I understand it correctly, a process would have to open /dev/bpf before
spawning other threads for this to work?

That still wouldn't work for Go I'm afraid. The runtime creates and destroys
threads on an ad-hoc basis, and there is no way to "initialize" in the
first thread.
With the API as is, any Go wrapper wishing to use this would have to do the
following _for every BPF syscall_:

1. Use runtime.LockOSThread() to prevent the scheduler from moving the
    goroutine.
2. Open /dev/bpf to set the bit in current_task
3. Execute the syscall
4. Call runtime.UnlockOSThread()

Note that calling into C code via CGo doesn't change this. Is it not possible to
set the bit on all processes in the current thread group?

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
