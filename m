Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF5C2A6384
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 12:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbgKDLlF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 06:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729630AbgKDLlF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 06:41:05 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58DDC0613D3;
        Wed,  4 Nov 2020 03:41:03 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c20so17061459pfr.8;
        Wed, 04 Nov 2020 03:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LrTKUro/EAfrSfquqr6fzY3elZ7+MZodt7l7Rb7VaMA=;
        b=TA/upDzkSlqE8bbPerc9M1oYcPB/SCguB/fv6tsU0qNJEICokPJOWWbzUO1heqjx1X
         3MJkKQbgC+mF0e9Skbu2tODntCXpim0YAGDgj8FN7sDDIYQ3LWENybyqXCZl/be+XIV7
         WkLl+XHEOUOo5pQruyx0qVAlxfInjmoyHlqVQGeveukro3khLO1jYepKUOZHrwFZ9ajK
         qadPobf/QXXP57jlIZ1IuZ5JjtLZc2rA7A6Suqtp3Kq9x2PAu07ziUDnyQuTlnoexYBH
         aFgJjI+kgZNHMfPu8OpcuPuLOyBtB9ucJUa6Vc1pIoNedcqDe7XyKvzwxbAnHqPdVC/8
         3d2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrTKUro/EAfrSfquqr6fzY3elZ7+MZodt7l7Rb7VaMA=;
        b=gXzrw5l7wvDRlPFIygshd7oftKBYo3pjLMzFSgvRdP/Kd/+AIWv5BsuWtj2GY9cfvH
         TtRT4rvAkVNmmcrxkIK3WoWWWY3Hu3WjhJ3LmyA3zbJckbKQarJryi4pRvH3Xq0NbQjg
         E24fsDwwacaRwU0t0CUKx97Vv26fBRieT8m397lRWYKzl1cR8g0cLI6hI29LsUewI57r
         6kki9Q/5+0BJZzoaKuS4cOH9mWgBkkaIxo7qTT6FJV8PDMH2ROBjjDRxtcRYPxBejZq/
         yzJm8PF79kPku3HmbksQY7LGBzXqQ9D3E8cqxpk6KtccAduKI50aCZfhCLipuUgO6DwT
         jcag==
X-Gm-Message-State: AOAM533IEE09U06Ifvqfuk5QAR3ImE0oCXXZE1FP9b3F/AXlfQ12LFix
        O/435oEcidkH/aTdWev8u4J/C6Tu1GbuU1GBlyw=
X-Google-Smtp-Source: ABdhPJxXrmLrL+mP1OQCNUcSRgpIRR5lxJCHjx9kumQZ9Rb2jjUaKiD5ojjTiFRpWH3+G31Xb1/FBX1ZKkxWCv735h0=
X-Received: by 2002:a63:f445:: with SMTP id p5mr20807325pgk.293.1604490063419;
 Wed, 04 Nov 2020 03:41:03 -0800 (PST)
MIME-Version: 1.0
References: <202010091613.B671C86@keescook> <CABqSeARZWBQrLkzd3ozF16ghkADQqcN4rUoJS2MKkd=73g4nVA@mail.gmail.com>
 <202010121556.1110776B83@keescook> <CABqSeAT2-vNVUrXSWiGp=cXCvz8LbOrTBo1GbSZP2Z+CKdegJA@mail.gmail.com>
 <CABqSeASc-3n_LXpYhb+PYkeAOsfSjih4qLMZ5t=q5yckv3w0nQ@mail.gmail.com>
 <202010221520.44C5A7833E@keescook> <CABqSeAT4L65_uS=45uxPZALKaDSDocMviMginLOV2N0h-e1AzA@mail.gmail.com>
 <202010231945.90FA4A4AA@keescook> <CABqSeAQ4cCwiPuXEeaGdErMmLDCGxJ-RgweAbUqdrdm+XJXxeg@mail.gmail.com>
 <CABqSeATiV0sQvqpvCuqkOXNbjetY=1=6ry_SciMVmo63W9A88A@mail.gmail.com> <202011031612.6AA505157@keescook>
In-Reply-To: <202011031612.6AA505157@keescook>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Wed, 4 Nov 2020 05:40:51 -0600
Message-ID: <CABqSeASFkTFn8ix8-5D0vdZ_FR9bR1PpU3j5eQPYOMshK6FuNA@mail.gmail.com>
Subject: Re: [PATCH v4 seccomp 5/5] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 3, 2020 at 6:29 PM Kees Cook <keescook@chromium.org> wrote:
> Yeah, this is very interesting. That there is anything measurably _slower_
> with the cache is surprising. Though with only 4 runs, I wonder if it's
> still noisy? What happens at 10 runs -- more importantly what is the
> standard deviation?

I could do that. it just takes such a long time. Each run takes about
20 minutes so with 10 runs per environment, 3 environments (native + 2
docker) per boot, and 4 boots (2 bootparam * 2 compile config), it's
27 hours of compilation. I should probably script it at that point.

> I assume this is from Indirect Branch Prediction Barrier (IBPB) and
> Single Threaded Indirect Branch Prediction (STIBP) (which get enabled
> for threads under seccomp by default).
>
> Try booting with "spectre_v2_user=prctl"

Hmm, to make sure, boot with just "spectre_v2_user=prctl" on the
command line and test the performance of that?

YiFei Zhu
