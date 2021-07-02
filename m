Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D973B9E7A
	for <lists+bpf@lfdr.de>; Fri,  2 Jul 2021 11:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhGBJqu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Jul 2021 05:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhGBJqt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Jul 2021 05:46:49 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF940C061764
        for <bpf@vger.kernel.org>; Fri,  2 Jul 2021 02:44:17 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id d9so10930226ioo.2
        for <bpf@vger.kernel.org>; Fri, 02 Jul 2021 02:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qqO0BGnrypD/wVeYBOQgNTRPS2etKNdrYj2ZSsBXYfg=;
        b=dNhb3bIORfzreK4J0xC93Os9lEr36Ys/zZxwnbDpW+94sRto0b1L1BP4jqSQegNECG
         W5FXEB5t6LG9AkhADWKUeyLjMIyKJdoJG3TLiKk2ODuPwuZuky8NTOCXLUMpie0wzVNe
         aS8FNLJbKBbRsZfrycDrnyLPCBEFYs887jqsEs+aDX+/axvZyNHnWNJapBfMqBbs6nzC
         fMwWNIJ3EMfTKHQ7y67qFEezLXk55fV8cyjFFu4rcrzdL93M7upuvv3VIxfx2gbPmBfw
         R/2/8uDJjeIBJRP5lwmoUW14zRx27Gos0QyI1ykpIeJzEDPNzDbazZKD6iFGT8AVzY3g
         lFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqO0BGnrypD/wVeYBOQgNTRPS2etKNdrYj2ZSsBXYfg=;
        b=jrYmHG+CNWJraCWq7EV8KbcZkxRsL5S250dEW5HLCzZfG2sra407P+CJ7xL6M/2O2U
         U9lJ4xjOgtoCF+v1IR/ZNwERLdYiQlRWUn1vvTZoXyIMeK+cz+3b0IwADVo4kCP0ELRw
         UaXuEW25x7pmNHri6hYdKGEq6V6TpatvAv7p1Gc1RyHOlPuJMabYMyz8SOlawEC04fPL
         wlgUrhh3E+iu/ej/MCAKY/VeC+0+aiveyTz0ZjLFj14/Zl0NYOcYiNGtd5BauT7awya9
         ed/h/Wqni+CE1FeeHdBorAYGogTt0eZPwS155avbh7mdg0lwLXbl/3zzO2KGO2eltkzg
         cT9w==
X-Gm-Message-State: AOAM533rtzA0HyyjPEwqRyKAncmBxlUoi0f3DXZ5Y/nYAFIfar5MM9wv
        s2LjuXlEH2CLB9a85HnKUXWLQon+6t39cuM8CYQkDSavB2Q8Ig==
X-Google-Smtp-Source: ABdhPJwHsnB+KUW2qlnPzouDX1gMa0JrdWnV6BCavasMQWHFkVVfnhqZJGcVIHzxeSzpC+HnTrBKT3EvhZ/CeR39Hd8=
X-Received: by 2002:a02:3506:: with SMTP id k6mr3586781jaa.39.1625219057101;
 Fri, 02 Jul 2021 02:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+i-1C0DAr5ecAOV06_fqeCooic4AF=71ur63HJ6ddbj9ceDpQ@mail.gmail.com>
 <YNspwB8ejUeRIVxt@krava> <YNtEcjYvSvk8uknO@krava> <CA+i-1C3RDT1Y=A7rAitfbrUUDXxCJeXJLw1oABBCpBubm5De6A@mail.gmail.com>
 <YNtNMSSZh3LTp2we@krava> <YNuL442y2yn5RRdc@krava> <CA+i-1C1-7O5EYHZcDtgQaDVrRW+gEQ1WOtiNDZ19NKXUQ_ZLtw@mail.gmail.com>
 <YNxmwZGtnqiXGnF0@krava> <CA+i-1C2-MGe0BziQc8t4ry3mj45W0ULVrGsU+uQw9952tFZ1nA@mail.gmail.com>
 <1625133383.8r6ttp782l.naveen@linux.ibm.com> <YN3OEbjzxPgCWN0v@krava>
In-Reply-To: <YN3OEbjzxPgCWN0v@krava>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Fri, 2 Jul 2021 11:44:06 +0200
Message-ID: <CA+i-1C0NADVWC+0tiRTMACqupGpGzK-QZ3sciZq=AYUJL802og@mail.gmail.com>
Subject: Re: [BUG soft lockup] Re: [PATCH bpf-next v3] bpf: Propagate stack
 bounds to registers in atomics w/ BPF_FETCH
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 1 Jul 2021 at 16:15, Jiri Olsa <jolsa@redhat.com> wrote:
> On Thu, Jul 01, 2021 at 04:32:03PM +0530, Naveen N. Rao wrote:
> > Yes, I think I just found the issue. We aren't looking at the correct BPF
> > instruction when checking the IMM value.
>
> great, nice catch! :-) that fixes it for me..

Ahh, nice. +1 thanks for taking a look!
