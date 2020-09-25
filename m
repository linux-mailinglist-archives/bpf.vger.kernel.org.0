Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC2D27920F
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 22:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgIYUdP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Sep 2020 16:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbgIYU2n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Sep 2020 16:28:43 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74901C0613B6
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 12:51:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o20so4202771pfp.11
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2020 12:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=aYpiTmID4xsc+ZXtbTi7xqB4g/9TSoL/gRDfcYQ3WKY=;
        b=TlNuh8jKztqtHSgOPSYIlkOX1FTDl+cnTYUAwpxIptGVTCsGY4WRbLjD2aDt03E2Wn
         nHvfTgO7vJqjtFAK1e26mA66Ozrw1EGrYkDalDgsBN48SudGkQINpwB/Lt8hFyCgCYqq
         Vb9AHgPIttAdVZTC8H1da8kayPqB2UnS1M7k+nbWdQcJ7pzUlQ7vBeP5Qh63nYns4Mad
         4x1WvEMAkUyiyh6C9/2KAahWn3gjb2qRtMoqeg1qE6nv++BYJ4lHiq8FM/cX9yc/29+C
         vOp6cvtfp74HcMOfX2HHqeVem6JqdQ75pShl05yR3iblYG0Y/fmM/ga0WRqblniaLdGo
         UWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=aYpiTmID4xsc+ZXtbTi7xqB4g/9TSoL/gRDfcYQ3WKY=;
        b=svM/POB09xZuhCTNfQqaNL3NzIM0yUyHWskz3+LB7MgobLN4qVIiwVOqMC5utgkSWQ
         ub29H6jMzzufuUmHu1SdLNk2nhDrn9sKb1FHrYXzc2UqO6Ya8YicyLQZickG4tlKOZ8f
         1E8DTr09y6ij1Ti26VVpMezqLMgWIUVpZKoDY7UfLMyqsRCoUHl9NfZFfGMu00HMXCps
         T0wqX5yhbyUa+UHjbhBWa3q1mYdCh63eUtn+BuaIaXYlrYHgiR3SJCMcelniYIyxCh1Y
         yb9AkQG1SN3Y0mekZNffMKEjE6wfz7hJGmuO8gCZy2kiR1on3InwetL2IXgMEsqMgtKA
         9Adg==
X-Gm-Message-State: AOAM531yklzEOKdgCAhPtTRZnWRlyt+2EnBrjH1zsJZ3J+4gtA5wZ3ge
        2S7Hj2iP/8hyXQCRujBMcU24Mg==
X-Google-Smtp-Source: ABdhPJykXwy5rOFCXbWLe1OsALxqFcpr3ferzywXG9nW2p19GlogMjQ7EdTLxEQAGEIYAT2NGp+mkQ==
X-Received: by 2002:a63:3ec9:: with SMTP id l192mr478784pga.316.1601063484980;
        Fri, 25 Sep 2020 12:51:24 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:c200:1ef2:54:c5e4:89e0:b741])
        by smtp.gmail.com with ESMTPSA id k2sm3291458pfi.169.2020.09.25.12.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 12:51:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 seccomp 3/6] seccomp/cache: Add "emulator" to check if filter is arg-dependent
Date:   Fri, 25 Sep 2020 12:51:20 -0700
Message-Id: <2FA23A2E-16B0-4E08-96D5-6D6FE45BBCF6@amacapital.net>
References: <202009251223.8E46C831E2@keescook>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
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
In-Reply-To: <202009251223.8E46C831E2@keescook>
To:     Kees Cook <keescook@chromium.org>
X-Mailer: iPhone Mail (18A373)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 25, 2020, at 12:42 PM, Kees Cook <keescook@chromium.org> wrote:
>=20
> =EF=BB=BFOn Fri, Sep 25, 2020 at 11:45:05AM -0500, YiFei Zhu wrote:
>> On Thu, Sep 24, 2020 at 10:04 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote=
:
>>>> Why do the prepare here instead of during attach? (And note that it
>>>> should not be written to fail.)
>>>=20
>>> Right.
>>=20
>> During attach a spinlock (current->sighand->siglock) is held. Do we
>> really want to put the emulator in the "atomic section"?
>=20
> It's a good point, but I had some other ideas around it that lead to me
> a different conclusion. Here's what I've got in my head:
>=20
> I don't view filter attach (nor the siglock) as fastpath: the lock is
> rarely contested and the "long time" will only be during filter attach.
>=20
> When performing filter emulation, all the syscalls that are already
> marked as "must run filter" on the previous filter can be skipped for
> the new filter, since it cannot change the outcome, which makes the
> emulation step faster.
>=20
> The previous filter's bitmap isn't "stable" until siglock is held.
>=20
> If we do the emulation step before siglock, we have to always do full
> evaluation of all syscalls, and then merge the bitmap during attach.
> That means all filters ever attached will take maximal time to perform
> emulation.
>=20
> I prefer the idea of the emulation step taking advantage of the bitmap
> optimization, since the kernel spends less time doing work over the life
> of the process tree. It's certainly marginal, but it also lets all the
> bitmap manipulation stay in one place (as opposed to being split between
> "prepare" and "attach").
>=20
> What do you think?
>=20
>=20

I=E2=80=99m wondering if we should be much much lazier. We could potentially=
 wait until someone actually tries to do a given syscall before we try to ev=
aluate whether the result is fixed.=
