Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47D15E684C
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 18:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiIVQVp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 12:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiIVQVo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 12:21:44 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD630E21D0
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 09:21:42 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id z13so3013649ejp.6
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 09:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=svyigr/4pQFgIA5xvhCZ4KlvmSb8/kEuQzuv4/Xh8g0=;
        b=Lk12qa9Q02RI/QER7YXZGzGUUzsXWGg+5CBYkZ4XASADk0loV5OvpxDw21TTt6CScV
         KCFkALPT2xRnbqzIcGiy3s1H3R/cIgAHoCdjoLqUw1XAcOTpLpfeOV7dW95AWY6rxkJk
         KLG0cGP6LY5oXsuS64SVHFollQNKOAx2RNDhSN8fH3zZF/wP3yUOq/DcQB5ZXudyEhE4
         n86CCVbVEwJzlkKsCFcHVQ/L6aO6ETzdEvC4LDfR/2Xt2PeNl4DmmCMo2Ra/HJCxYSjc
         7/NBDlX6W9LXtIN9CcyKSOydK9snUyG2Q5S6czmAPvUuUrz/J4jnXZm1yray9adyZCWS
         gD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=svyigr/4pQFgIA5xvhCZ4KlvmSb8/kEuQzuv4/Xh8g0=;
        b=m52FcVOFLDYu2znhU9a5d0L9/sLfPpcSBxdkjh5mFeykaYt3GVrF0jXr/nkb3joyIM
         satvIOiSVbKwcnsE/i/+QVkDWhLUTuiADmPjbnOWItARGGcMKdKxYTJEwhpOEvpgAopi
         4U9GCSQGPLU/QN0f0IghqjNSS/jVvzB8vHAfFqaFelnb4aXB5IGmUq89/CvrQP97u4Wp
         VyptKAG+WoR79WL05etuQFKw3C/8mgdMDaysSUZBhzzQJkNgghZtQDxpPbCJ8zvWc902
         +UzyiwuBnKyBiJRuH8K+dABsWM+ZYUPHXHe5ur8960DYTgruEwSzGEcyrI2CDeEr9Ehq
         GNwA==
X-Gm-Message-State: ACrzQf0gje6NqQBtCGmeMyZuI44tXge+LgqCSESAiiWm8rOWFuKkLPwF
        YdgZHehsPBbHjbyLA6SnXIwjESzXIUox/9GZ12A=
X-Google-Smtp-Source: AMsMyM6Sn8y305CxzLifCpHl/RbzPRv3i4OGDVsI+GcXZ84saMBSuh4L/eKK4V7euzpr2JvlPzdhh5VMbv77IXXoBGw=
X-Received: by 2002:a17:906:8454:b0:772:7b02:70b5 with SMTP id
 e20-20020a170906845400b007727b0270b5mr3549488ejy.114.1663863701309; Thu, 22
 Sep 2022 09:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220921164254.3630690-1-andrii@kernel.org> <CAADnVQ+ZDFe6brZJ4dPWnEWwxUtZnL=MuXOzoyNNfY7oxXZZ-w@mail.gmail.com>
In-Reply-To: <CAADnVQ+ZDFe6brZJ4dPWnEWwxUtZnL=MuXOzoyNNfY7oxXZZ-w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 22 Sep 2022 09:21:30 -0700
Message-ID: <CAEf4BzZXy6BG1OE6L1tGzeqFMNqe2p=B4x8c0yH-Jo9-XUrGaA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] veristat: CSV output, comparison mode, filtering
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 21, 2022 at 7:52 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Sep 21, 2022 at 9:43 AM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Add three more critical features to veristat tool, which make it sufficient
> > for a practical work on BPF verifier:
>
> Nice tool!

Thanks!

> Few requests:
>
> 1.
> Please fix -v mode, since
> veristat -v loop1.bpf.linked3.o
> hangs forever. Maybe not forever, but I didn't have that much
> time to find out whether it will finish eventually.
>

[vmuser@archvm bpf]$ sudo ./veristat -v loop1.bpf.linked3.o
libbpf: prog 'nested_loops': BPF program load failed: No space left on device
libbpf: prog 'nested_loops': failed to load: -28
libbpf: failed to load object 'loop1.bpf.linked3.o'
...<hangs>...

Yep, some bug if the program fails to validate due to -ENOSPC. I'll fix it.

BTW, I also want to extend this verbose capability to allow specifying
log_level = 2 for BPF verifier, because for successfully validated BPF
programs log_level = 1 is empty (except for stats).

> 2.
> Please add some sort of progress indicator to
> veristat *.linked3.o
> otherwise it's not clear when it will be done and
> -v cannot be used to find out because of bug 1.

just dumping every entry to console would be too verbose, so I was
thinking to overwrite single line with updated progress, if output is
a console. I'll look up how to do it.

>
> 3.
> could you make it ignore non bpf elf files?
> So it can be used just with veristat *.o ?

Yep, I can, will add that as a convenience.

Note that for now you probably want to do '*.bpf.linked3.o'. Daniel
added .bpf.o suffix which helped greatly, but I think we might want to
tweak this a bit more to make sure that what we have as .bpf.linked3.o
is just .bpf.o, and initial .bpf.o (which might require further static
linking to be complete) will be called something else.
