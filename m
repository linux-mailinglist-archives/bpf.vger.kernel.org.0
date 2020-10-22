Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03B92967B1
	for <lists+bpf@lfdr.de>; Fri, 23 Oct 2020 01:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373440AbgJVXkU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Oct 2020 19:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373402AbgJVXkT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Oct 2020 19:40:19 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C7CC0613CE;
        Thu, 22 Oct 2020 16:40:19 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t14so2031134pgg.1;
        Thu, 22 Oct 2020 16:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rfUKMVhWjeKZKSXLZk5xBVJ8e0dc1yuWDXn4EN8WMMU=;
        b=ud7rmALAARbu3oqKs/0tzFST86D3Pnf0VohdjqbSUsNO3zlhE5AP/MrJ47b4kSvX2Y
         xyngFQZLQtUAslg59RtfMY2ljTToPi+/zvwpwNgbZqE4O2YsEghEf/pkMxMevIvn3FLl
         L4Uh8kmJyAXgM8cgqPGV6hDCgIpv9vqoDWV+7+xXJRSXWABMP2QdX32A+iNGZQtNMBIO
         Zq/vZhwrllluWPBwA4TvP4dCjf9AShkcwFIEzO91Nm00LTrASqifV1h0VY+ltJOBhpId
         prFvLAf7kc3bcq/cUG3ObocpG7NyplLaNZi+DrDYv4+lagdRedtMgntT3E6x5C1qGqCV
         dHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rfUKMVhWjeKZKSXLZk5xBVJ8e0dc1yuWDXn4EN8WMMU=;
        b=Lhm7C2UGR5rN0/FclKwSyFS6rqoMIdRdkAqQcEqxdFSQL+55m8C3rw5ZSJQ19RYznx
         M7Bstz050mCO3zX53KcOuuspwmJPJ9VIqC06ZD1CVfGNhGLc9ueSy63uvB/aZd7T44Mg
         4jkOOrJXU7J7iFN+JrtdQQLlbdhlYxsiBTgM8cyQdMvFMswMYFWLcvVJ550ny9U/mx6V
         nhy02sGupva7JMqGqf5FfNmSnxSc8+CvdMx1huXxdpavqeCgB4Ef6OaZBkZDDKNQxlH6
         XnForeIlUasxE2hNVHYEj2w6qbe1YmFXI3Bku7oNcbMJeUzT9mhIj6+RbdVWQR88sfvE
         NTbQ==
X-Gm-Message-State: AOAM532pNILSD75qoNV4/QRYwdBxvgPxRvrt0Wxiengx37NXUa884WeJ
        XI/5qTzYW8W/gVykQO+W7FwqOSgRzGQQOpBKzUY=
X-Google-Smtp-Source: ABdhPJykfsSN5dzMGjSyvmeb7kY08iyuowCm7UjuXfZLsjz2nFbvRBAd/WNQYohVqj2bEWN0ASrE45/fY7d/UdH6dPY=
X-Received: by 2002:a17:90a:4313:: with SMTP id q19mr4588300pjg.184.1603410019174;
 Thu, 22 Oct 2020 16:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602263422.git.yifeifz2@illinois.edu> <c2077b8a86c6d82d611007d81ce81d32f718ec59.1602263422.git.yifeifz2@illinois.edu>
 <202010091613.B671C86@keescook> <CABqSeARZWBQrLkzd3ozF16ghkADQqcN4rUoJS2MKkd=73g4nVA@mail.gmail.com>
 <202010121556.1110776B83@keescook> <CABqSeAT2-vNVUrXSWiGp=cXCvz8LbOrTBo1GbSZP2Z+CKdegJA@mail.gmail.com>
 <CABqSeASc-3n_LXpYhb+PYkeAOsfSjih4qLMZ5t=q5yckv3w0nQ@mail.gmail.com> <202010221520.44C5A7833E@keescook>
In-Reply-To: <202010221520.44C5A7833E@keescook>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 22 Oct 2020 18:40:08 -0500
Message-ID: <CABqSeAT4L65_uS=45uxPZALKaDSDocMviMginLOV2N0h-e1AzA@mail.gmail.com>
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

On Thu, Oct 22, 2020 at 5:32 PM Kees Cook <keescook@chromium.org> wrote:
> I've been going back and forth on this, and I think what I've settled
> on is I'd like to avoid new CONFIG dependencies just for this feature.
> Instead, how about we just fill in SECCOMP_NATIVE and SECCOMP_COMPAT
> for all the HAVE_ARCH_SECCOMP_FILTER architectures, and then the
> cache reporting can be cleanly tied to CONFIG_SECCOMP_FILTER? It
> should be relatively simple to extract those details and make
> SECCOMP_ARCH_{NATIVE,COMPAT}_NAME part of the per-arch enabling patches?

Hmm. So I could enable the cache logic to every architecture (one
patch per arch) that does not have the sparse syscall numbers, and
then have the proc reporting after the arch patches? I could do that.
I don't have test machines to run anything other than x86_64 or ia32,
so they will need a closer look by people more familiar with those
arches.

> I'd still like to get more specific workload performance numbers too.
> The microbenchmark is nice, but getting things like build times under
> docker's default seccomp filter, etc would be lovely. I've almost gotten
> there, but my benchmarks are still really noisy and CPU isolation
> continues to frustrate me. :)

Ok, let me know if I can help.

YiFei Zhu
