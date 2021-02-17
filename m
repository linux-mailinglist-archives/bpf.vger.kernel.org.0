Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BDB31D5F0
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 09:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhBQIAq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 03:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhBQIAp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Feb 2021 03:00:45 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1395BC061574
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 00:00:05 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id d20so10542999ilo.4
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 00:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kp4RmKY6sZzH7ELbsvJbT8zZF++/v9kEMY9S9O5bmkQ=;
        b=O9YZUEiQNLbqUBpEXxMWl/Osyw697DSqLrz+mvKPN4QcQWP7eMEj5JOort4bpwhDWI
         KreK2AfBZPMBAuVVlMq5u7Co/5S/2MkPdV2lFZEjAs8iH1BQ5vyc4qCXfyW+AxyolHeH
         +MJVbSCbUY694YjtTHbnUuVti0NlqQFiw0B8y1j4pcBNYtQq+5U9cq2jNLYC0KRTPM8K
         LbokIdlANeAGYKzVjd7cbpH5TOAyx//a2auKDCKiZkEEyjkA+KUE3c1ZU8uoCUolaBt5
         aTFz7gfL2iQF8Pg4pv0gq3mgfR38rxCKLQ8HXcx0yBFSmG6+p3STcmtAGjme3voezMqa
         9fwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kp4RmKY6sZzH7ELbsvJbT8zZF++/v9kEMY9S9O5bmkQ=;
        b=TND0QZ3QFQRSFBFGo2nUTRnZcDOfTsAtrWiEq7cMPqL47t0SaCIjdVnB2OoBeO/X6G
         cOF1Cp+iD2mbmbLLo008kJl6hpe3/CLpv81APnv71aA78pDqnsoFad82wEJCakTa1nw2
         9Hc27I/Xjpds/mkF47+EgLiCKcJrFgPNxE+NXUSKWQl3MKtgKpW2O49mIaKFIC/SnhyD
         QasF/kr5w1VtSOJ+owOiNcsZ9HAOmNYJF1fImGGQCqjVqXSJnNU2A8ll8y134304hncg
         oQzM/HcSVZ+8wQ0uuCAoICSp+Dw8yL+vvQihSY8iQwPax0uFpYwBYXx2cE+NWVz9YbmB
         Bmow==
X-Gm-Message-State: AOAM5320chbodp6ykmVM6yDJgAvloHRzbRkPHjWsrJmN7scKFVJjk3+s
        2EY0AwncMz4ZXKVjP3ic/paCGZaCSwK9ko9To1TWxg==
X-Google-Smtp-Source: ABdhPJyCvmd6s8QleUsBdI3w7GQYLzizyCOARTfvLACFCigor9edIDG9fZmYOCSAhSfaIRf8x08MICUU7pXkmkvVpsA=
X-Received: by 2002:a92:c24b:: with SMTP id k11mr19935818ilo.276.1613548803703;
 Wed, 17 Feb 2021 00:00:03 -0800 (PST)
MIME-Version: 1.0
References: <20210216141925.1549405-1-jackmanb@google.com> <80228f01-c43c-f121-0b80-bb368b530111@iogearbox.net>
 <CACYkzJ4-QSevoMuPZ_xtYP2WK1_2MKVC1op6Y1+wTtmP_FnOaw@mail.gmail.com>
In-Reply-To: <CACYkzJ4-QSevoMuPZ_xtYP2WK1_2MKVC1op6Y1+wTtmP_FnOaw@mail.gmail.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Wed, 17 Feb 2021 08:59:52 +0100
Message-ID: <CA+i-1C3ZTymNxLor0==orAdnboPXTCwFQWsu-8+K9VtOrprpZg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit cmpxchg
To:     KP Singh <kpsingh@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 17 Feb 2021 at 02:43, KP Singh <kpsingh@kernel.org> wrote:
>
> On Wed, Feb 17, 2021 at 1:50 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >
> > On 2/16/21 3:19 PM, Brendan Jackman wrote:
[...]
> > Looks good overall, one small nit ... is it possible to move this into fixup_bpf_calls()
> > where we walk the prog insns & handle most of the rewrites already?
>
> Ah, so I thought fixup_bpf_calls was for "calls" but now looking at
> the function it does
> more than just fixing up calls. I guess we could also rename it and
> update the comment
> on the function.

Ah yes. Looks like we have:

- Some division-by-zero related stuff
- Implementation of LD_ABS/LD_IND
- Some spectre mitigation
- Tail calls
- Fixups for map and jiffies helper calls

How about I rename this function to do_misc_fixups and add a short
comment to each of the above sections outlining what they're doing?
