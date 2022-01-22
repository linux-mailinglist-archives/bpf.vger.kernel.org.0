Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2486B496B95
	for <lists+bpf@lfdr.de>; Sat, 22 Jan 2022 10:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiAVJ6P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 Jan 2022 04:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiAVJ6M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 Jan 2022 04:58:12 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E74FC06173B
        for <bpf@vger.kernel.org>; Sat, 22 Jan 2022 01:58:12 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id p1so21279689uap.9
        for <bpf@vger.kernel.org>; Sat, 22 Jan 2022 01:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lu/zIOfEdkENIGU4eW+IpZQWkxTjt7kZCgepCHmgDwc=;
        b=g1IPPhBrj8E8f0Hh/cPZQEPRRnW5iA2WkcmwhhPBP4YZ/ZZvQeCz9m2R++LtvM3JS0
         rg0V2Lw6tXD41Br+A2mmjQyp+s9HEJsi/NjHRPdtRzP/4ehJ8RefF7DoNxZvnH0rU7z2
         b6COPuue5x4KoL86mGsaLioTwqMhR50x8/NURN1KuCMOs4urSTbbaUnNsB50TJVcjffj
         J81zdSx41/vXc3CtozQjoz1WSICGh3H2MbkxKGEnZxLFkjZ+V/YpekFj8m1wxzMDuO8/
         Q5r6YCzD5rnqmqn6nGMtdEXvpxJb2y7vIo4PsB6gspmoq+yi68hdt4iWx6HZ8qXYD5hj
         4x5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lu/zIOfEdkENIGU4eW+IpZQWkxTjt7kZCgepCHmgDwc=;
        b=plTg415noRlUlB9ED+qyIOFRpJPrgPNFFYpNvaVisp5jlIJoZjnbaFjFyjq7wZQY3g
         EefxjBTKbitZ+cNNQnT+rAV78YjG4Mr+zqILBH5tiSxGhdO9tOnjf4zjfN3uFARz4z0c
         3KG3BFkuL3+Yfrn46cgrp3hTFwoFIe3D+5/v4yVxlyPSnGsTRZwdh1Xg2K8iUwm9gaGo
         Bfs38YuLnofQPoYS5yoeVJrqY9Y823JNatInDOvI6ucpfUQ10fJv3RPkElc+VyprxdGW
         65pl4KYlyMZFZORv5lJXAYl3n0Lqi72gjtpH/W7JS3s2YMp3ejZS+F3afTXRTdGW1ptA
         SjUA==
X-Gm-Message-State: AOAM533WhVRtQui7cv6QUx0v+UleAECl8v9dVFiO51pUnhhMh/bFgcK1
        nDsUVGosVdtp7fptrPDfB4HkyBbHfQcAgccpNQTpwdacnq8CO1Is
X-Google-Smtp-Source: ABdhPJx99YCAhZiuuWtfLWKt9WIOt4q9gEgtMfc1sIeTp1OAuZUx9tMZVwMusA4z8z+0jQoDC1PiGpgvIplkjzcw8Qg=
X-Received: by 2002:a9f:2d95:: with SMTP id v21mr3236641uaj.106.1642845491714;
 Sat, 22 Jan 2022 01:58:11 -0800 (PST)
MIME-Version: 1.0
References: <20220113233158.1582743-1-kennyyu@fb.com> <20220121193047.3225019-1-kennyyu@fb.com>
 <20220121193047.3225019-2-kennyyu@fb.com> <CAEf4BzYfQ4EbSa+c1-G0x_Zh4L6=TbutmH3qndTmv7wb2dAf1w@mail.gmail.com>
In-Reply-To: <CAEf4BzYfQ4EbSa+c1-G0x_Zh4L6=TbutmH3qndTmv7wb2dAf1w@mail.gmail.com>
From:   Gabriele <phoenix1987@gmail.com>
Date:   Sat, 22 Jan 2022 09:58:02 +0000
Message-ID: <CAGnuNNseH=oLjYSUCfxyyxcGmJ3Na0NnTXCBQP21YqTX1GhYPg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 1/3] bpf: Add bpf_copy_from_user_task() helper
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kenny Yu <kennyyu@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 21 Jan 2022 at 19:53, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> "On error dst buffer is zeroed out."? This is an explicit guarantee.
>

I appreciate that existing helpers already do this and it's good to
follow suit for consistency, but what is the rationale behind zeroing
memory on failure? Can't this step be skipped for performance and
leave it up to the callee to perform if they need it?
