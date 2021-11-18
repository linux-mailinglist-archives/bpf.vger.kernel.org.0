Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400CC4563C8
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 20:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhKRT7D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 14:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbhKRT7D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Nov 2021 14:59:03 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95357C061574
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 11:56:02 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id d10so21473164ybe.3
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 11:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N7mylnHNzBXNx2n7cRn91ZXwk3dqGGLg8dfzhlpEQRw=;
        b=OTvua/vsw1mDDyOwp3HI6sKWuHE1gfFqwd/r4BgAdlNXtA9ClyX385g914B05NUnLf
         VPwepxbqOxhGBS6D8tA3bN891jAhBV6MoWtEkletLilSS47wxhJXPoAwCCJw3mKf6Lpm
         N5ujjJbvnDdR35B7N/u1LOCekNhybBdnMi80qAWOP1sLsZaTpRAvdi8hxyu4dllgmYQF
         GUUdnE2WbHdhkC/9fii1HJmCQ2zU2tb5JJi+h7vy14/M3s+Ks35PATJlKFYD5mah20fX
         Izr37IrR412LW+dHzOspl6zK61AU5yCcm0I8ecZJXcKikisdsBbGEPheqPkXa/ocVLyq
         ZYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N7mylnHNzBXNx2n7cRn91ZXwk3dqGGLg8dfzhlpEQRw=;
        b=IXjwAvEKDLFaCK9F2RUFD5ZXX1t+rBF9RFX/pQPmkiqoIQGjw6PWk594L8LdIJW8kG
         Mv3q1Yciij87CmHG4SSugUXJlYjvjPemYo64v2EW/Vj4uE09mNCMTNwlyXLMygzcmhZv
         145Kue/XGv4G9DyGTXvKoth6BpYSSQVPb9NvuLgkI021f6l2TzzwE3E2G22NPFtu1GwR
         uYcDT4ltnH+d5K7NKrsA44eXD2Ryvd5AUUkAR7XQdDMxKxp6jAWEiTuFWmZOWWLSHaf4
         n7BZNYVeFipbhrhnAEcrf7/Xjm0L/KOPNhkFmZgTN7D+rZTjcRt4sk2+iDXWg0aN+bR4
         yaaQ==
X-Gm-Message-State: AOAM533Rp+l9Z77KagxxfmZoISmjmNKh3DLwkaZ0yAU1ulRKaqFJsr2N
        fKxNqe0GpVOU5qSm1xeMJSEBaSw+XQYrdeJwpQw=
X-Google-Smtp-Source: ABdhPJzYCPtP8A6zMNp+jHo43wPHVlhaA+cgKZFNhtaK0I1lTkBxetfXiiBIaDTAsYEK/Xkw9+f6OV2Z1CYiwtpz5v4=
X-Received: by 2002:a25:cec1:: with SMTP id x184mr30826317ybe.455.1637265361852;
 Thu, 18 Nov 2021 11:56:01 -0800 (PST)
MIME-Version: 1.0
References: <20211118010404.2415864-1-joannekoong@fb.com> <20211118010404.2415864-4-joannekoong@fb.com>
 <87r1bdemq4.fsf@toke.dk>
In-Reply-To: <87r1bdemq4.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 18 Nov 2021 11:55:50 -0800
Message-ID: <CAEf4BzZMJfSqx9wLq9ntSK+n4kE82S_ifgFhBVtjYiy0vz4Gyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftest/bpf/benchs: add bpf_for_each benchmark
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 18, 2021 at 3:18 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Joanne Koong <joannekoong@fb.com> writes:
>
> > Add benchmark to measure the overhead of the bpf_for_each call
> > for a specified number of iterations.
> >
> > Testing this on qemu on my dev machine on 1 thread, the data is
> > as follows:
>
> Absolute numbers from some random dev machine are not terribly useful;
> others have no way of replicating your tests. A more meaningful
> benchmark would need a baseline to compare to; in this case I guess that
> would be a regular loop? Do you have any numbers comparing the callback
> to just looping?

Measuring empty for (int i =3D 0; i < N; i++) is meaningless, you should
expect a number in billions of "operations" per second on modern
server CPUs. So that will give you no idea. Those numbers are useful
as a ballpark number of what's the overhead of bpf_for_each() helper
and callbacks. And 12ns per "iteration" is meaningful to have a good
idea of how slow that can be. Depending on your hardware it can be
different by 2x, maybe 3x, but not 100x.

But measuring inc + cmp + jne as a baseline is both unrealistic and
doesn't give much more extra information. But you can assume 2B/s,
give or take.

And you also can run this benchmark on your own on your hardware to
get "real" numbers, as much as you can expect real numbers from
artificial microbenchmark, of course.


I read those numbers as "plenty fast" :)

>
> -Toke
>
