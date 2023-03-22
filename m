Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B096C5006
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 17:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjCVQHB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 12:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCVQHA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 12:07:00 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E183019A
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 09:06:59 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h8so75019217ede.8
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 09:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679501217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaDXkeAcuqyRYJoDFHhI1cNlf7+Yuz2yFyF+ucXfMT4=;
        b=RS6Vw+EHV8ZlT5s8m8IIFLi/VzsUv2C9g+gYpNsvG4ofi8sVlYNW6sAoQpdT7WtV/x
         bPyRrzd9oYJtlQIqp41/GovNGE3fNqLePTbnG/lsbOaCzHZxOTf2hvUmg/A0cV89Wx67
         p0Nv0ucW4FL90XebnUbPm4VS2tZaY9ZV3YDPt4+7pSZrPWt+8P7DaKKV9ERSsPFG61tT
         7Ej/5A3yEvp8jKv27p3svfo+nl9KEDAkbpB/yKDnT83xeqYvCnD8yJqHejCJ54zdWlU8
         98YVte7b4laLcL0dGuiQmuCCKy/XjoU852QDWJqIzKEyBXWdeJdRphHtFM1lWw7gApsQ
         xmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679501217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaDXkeAcuqyRYJoDFHhI1cNlf7+Yuz2yFyF+ucXfMT4=;
        b=Kwccazj4rnKO9lVjxbbbosPugAf4oNPGRPExYBcCWLbyOjgVzCSTFSl5SdZQKe2qUS
         oM9NeOiTPlsdpr1oQfxLZt17VGNPkXnM+0vj5KYnO843ZLkYZCrcvUvuDUcqqm9mhHzX
         riSYu/G0+UL1KNOzfAZslVTYsDVaDZb8eABTEw9HhL3snJ7bm1DBhDyM/bRnCR7NrhBq
         NtzMc6d8qmnmco+zEN+APqKzSNXtyxVW+ljwgMn1sWjunpR3kssyJ21TuhaYBjtm3E0F
         OXcYpw1CJJagOcUdNEmerUQiSkT4BEpGPI0uLAFuYoqusx7LYRLKtq+2xDU+C0E2vWat
         I2vQ==
X-Gm-Message-State: AO0yUKXqNh5S6UIEZQXZzXCCymIT3TnrCXmluGMev4P1CKFc8sXkx+1Y
        ixxO+cyqzi10GGuMXI7uCNZSkH+FTjcQlH1sP7VGOnX7zfQ=
X-Google-Smtp-Source: AK7set8QSVwh51acny/la+pnV/XqTpxJ8Hfh6OpjLs9d7ltU2gqH7OmMVmx2WoF3l0UGxMIEriwAVAIrn55pMARDvMQ=
X-Received: by 2002:a50:c3cf:0:b0:4fb:2593:846 with SMTP id
 i15-20020a50c3cf000000b004fb25930846mr3668540edf.3.1679501217426; Wed, 22 Mar
 2023 09:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAMAi7A7+b6crWHyn9AQ+itsSh8vZ8D5=WEKatAaHj-V_4mjw-g@mail.gmail.com>
 <ZBo164Lc2eL3HUvN@krava> <CAMAi7A7Y=m=i-yEOuh-sO-5R5zEGQuo1VwOLKsgvFcv4RRhbhQ@mail.gmail.com>
 <ZBr7Jt9+yr0PHk6K@krava>
In-Reply-To: <ZBr7Jt9+yr0PHk6K@krava>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Mar 2023 09:06:46 -0700
Message-ID: <CAADnVQLCSMBhHzOgB1iYMpWVTYsKerMUJ_8MX1W+7BNveF+0tQ@mail.gmail.com>
Subject: Re: bpf: missed fentry/fexit invocations due to implicit recursion
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Davide Miola <davide.miola99@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 22, 2023 at 6:10=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Mar 22, 2023 at 08:33:18AM +0100, Davide Miola wrote:
> > > seems correct to me, can you see see recursion_misses counter in
> > > bpftool prog output for the entry tracing program?
> >
> > Indeed I can. The problem here is that the recursion is not triggered
> > by my programs; from my point of view any miss is basically a random
> > event, and the fact that entry and exit progs can miss independently
> > means that, at any point, I can count two exits for one entry or
> > (worse) just one exit for two entries, making the whole mechanism
> > wildly unreliable.
> >
> > Would using kprobes/kretprobes instead of fentry/fexit here be my
> > best compromise? It is my understanding (please correct me if I'm
> > wrong) that kprobes' recursion prevention is per-cpu rather than
> > per-program, so in this case there would be no imbalance in the
> > number of misses between the entry and exit probes.
>
> kprobes are guarded with perf-cpu bpf_prog_active variable, which will
> block nested kprobe calls while kprobe program is running, so you will
> get balanced counts but likely miss some executions
>
> there was discussion about this some time ago:
>   https://lore.kernel.org/bpf/CAEf4BzZ-xe-zSjbBpKLHfQKPnTRTBMA2Eg382+_4kQ=
oTLnj4eQ@mail.gmail.com/
>
> seems the 'active' problem andrii described fits to your case as well
>
> also retsnoop is probably using some custom per-cpu logic in each program
> to prevent this issue, you check it in here:
>   git@github.com:anakryiko/retsnoop.git

I suspect per-cpu recursion counter will miss more events in this case,
since _any_ kprobe on that cpu will be blocked.
If missing events is not an issue you probably want a per-cpu counter
that is specific to your single ip_queue_xmit attach point.

But I'd explore proper networking hooks first that don't have such counter.
There are quite a few in TC and cgroup-bpf layer that can be attached to.
netfilter-bpf hooks are wip.
