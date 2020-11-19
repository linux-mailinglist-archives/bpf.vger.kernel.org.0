Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9F02B9AB4
	for <lists+bpf@lfdr.de>; Thu, 19 Nov 2020 19:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgKSSeB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Nov 2020 13:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbgKSSeB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Nov 2020 13:34:01 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69FEC0613CF;
        Thu, 19 Nov 2020 10:34:00 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id 142so7312921ljj.10;
        Thu, 19 Nov 2020 10:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6XPAPovJjOhnCtfgRxnpE0FMv7liqyqCr2wo1n3AgI=;
        b=R8A3RusrHG2cPbUBPZ6bwWjmdjCI5va/W1UmoIFdahHe/Vh8N6ixeDPfljO4h2/jpA
         S2PeO1opQPtYcDcX5rppzjlwFr4ovAFcMjNvz1A0LsTcubnwjlOgdFH041S74YwOS18b
         CWI4+ubhFA0zBZtMGtyVyO/YG0UKmg5e3U6/P/no8BsjMmOZXZ8TiDDX5raBGp1jmB43
         RP/6dbjmqpAdiRBRxxfwfnC0pG9jc9WIU8i7PnwXFFEfxPBf6RL8wFbx3XMpswkbzGup
         bVlMjyaajEVq9mmHDiDF6V0FRXYVb2j3xZheWxZFGy+a44rEdR6qLCeS/6/3sEk4MaRf
         t0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6XPAPovJjOhnCtfgRxnpE0FMv7liqyqCr2wo1n3AgI=;
        b=fvWBGbgSAxD2mPGuXGsASb3b5Rw4giEfuHzbr97QgRRlqD8dq7Q/9QPT4WuGmExA2W
         JqSzCDcBvD1S0SPbI59dihIM2cNaJAOQAgjYhzpoTl3gsD2w7/ykpn//oqiG5x7RM6jh
         fjc9Zniz4ZoWin/QLcNgfjPVw1K6FNbeUCzvsajS7VGQ50gMm9UAX7Ic56/jEuqX7P6V
         Ke3aeU0mw/laVbxwbUgl2H/3Eqsvpm0X54MiArk/T4Ko9CJmdIL8VwbMp4W0RD3ooTTK
         NPcV3KZLXykEWTGDlJcPcEPmndmCY+6pLvpRAi0Fbr9Ec1E8ZwZEU/t1NwIFVwtkbInf
         yYyw==
X-Gm-Message-State: AOAM530UUPTrzjMg34QkrqgdGCFXA5azz6NBRXLAPvLGBcMK375VbNmB
        JwqgbmTR9OvJNp+AyX7iwPvsc3n9p8YquhhmnP0=
X-Google-Smtp-Source: ABdhPJxjVnhMHjpk8KQLMXEU6F4pEASA7ZPuykIZtAsfdRpC07/qsqUhcPlddoC/Zj9oJAMpWcvG7GNJl69XTJg7enQ=
X-Received: by 2002:a2e:86c5:: with SMTP id n5mr6612120ljj.450.1605810839436;
 Thu, 19 Nov 2020 10:33:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605642949.git.dxu@dxuuu.xyz> <21efc982b3e9f2f7b0379eed642294caaa0c27a7.1605642949.git.dxu@dxuuu.xyz>
 <CAADnVQ+0=59xkFcpQMdqmZ7CcsTiXx2PDp1T6Hi2hnhj+otnhA@mail.gmail.com>
In-Reply-To: <CAADnVQ+0=59xkFcpQMdqmZ7CcsTiXx2PDp1T6Hi2hnhj+otnhA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 19 Nov 2020 10:33:46 -0800
Message-ID: <CAADnVQLi6sS36fqV+xuaz0W5ircU5U=ictnj=mF4KWEFUDSqPQ@mail.gmail.com>
Subject: Re: [PATCH bpf v7 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 17, 2020 at 12:14 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 17, 2020 at 12:05 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > This commit uses the proper word-at-a-time APIs to avoid overcopying.
>
> that part of the commit log is no longer correct. I can fix it up while applying
> if Linus doesn't have an issue with the rest.

Linus,
ping.
