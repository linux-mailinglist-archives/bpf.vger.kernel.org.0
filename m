Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E444A7393
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 15:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345111AbiBBOtw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 09:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244118AbiBBOtv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Feb 2022 09:49:51 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E3CC06173B
        for <bpf@vger.kernel.org>; Wed,  2 Feb 2022 06:49:51 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id u13so23908327oie.5
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 06:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RqpgNSQqEtvHDhtnLQpmx4vhCkM9OOPAYGCYwN/UpUA=;
        b=ABpJD8ClxeKSd60j9HNanNhLdkhkcGR6JgMCxv9C9NF9SyXyOofNQr1kSDq2TBfkDz
         9BzwLvHlk0StPgaF7r5NYoVEg0/vgjoQZIA+zkhvgAcv4gxqER9nDaYjx37jFV8/dFBf
         zLC880EnBvtuSeH7MuN4QD8Bi5xHD7c3UKO0pNYoycyTJBRNU3NLxzPmk2zexOizaWus
         XP42NQJzMffcO62LtfYx017tx+hN31+VDJkdYDz9b85+iqTcsc2XXNBcwHrDx+OweCdW
         lGKajBieBwDhgx5WYARzW0WogpCcFSx+HByAUq5idX+pl3r+5aUTijvEdkk1h1WWYoPR
         xKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RqpgNSQqEtvHDhtnLQpmx4vhCkM9OOPAYGCYwN/UpUA=;
        b=SVCzZvJX39L5o9enySxwoVBrfEOmskfVKB79bMoHunh7gidb7P4E6jpKYcIgeE3+EK
         fZKYMcddPSVmSNW7nCDzB/xbqy2G6rr+RPfBsO03i8MySrzrNgg+cRa0OI6FQdiWwuyU
         FxHvtbnj2vzwyXhbnzROkx0KJAz3j7ezKFG2sHcDImudSXOVVVmqbGnmdRtGN14LCnwa
         OihDAje2InsUhyCGORyCZZp9fEX8veCdesIOc6yI7qU0mIp9jbSaJiu4U71UmID3u0FN
         9i1JykQz5qje4ZXH1ofrdiP92wwIcYoAhlst2zR0v8sw9wuLP/LKSli6CnGpKjO8t0Xn
         5HtA==
X-Gm-Message-State: AOAM532uVBEig3XJ4UUYs7pmbsc9h4OiCzpobjm83Hrt9fv/bwRbaZXY
        QHAZeVMzF+MDhRufXCrn2AFK4UHk0U2A2IoJa/kWHA==
X-Google-Smtp-Source: ABdhPJxfI3zeLQ82ebGntwsMBQogioG4IwPuBvXRXbKc9toTzCugtUBpEDYfxQYd62QKGYxc6fRtiLhzvugCS3v4GvY=
X-Received: by 2002:a05:6808:1901:: with SMTP id bf1mr4642177oib.197.1643813390322;
 Wed, 02 Feb 2022 06:49:50 -0800 (PST)
MIME-Version: 1.0
References: <0000000000000a9b7d05d6ee565f@google.com> <0000000000004cc7f905d709f0f6@google.com>
In-Reply-To: <0000000000004cc7f905d709f0f6@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 2 Feb 2022 15:49:38 +0100
Message-ID: <CANpmjNPL-12uWHk+EDPdz=6rs2+n2zJWX1zMAbsfUm=dbZJ4qQ@mail.gmail.com>
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Write in ringbuf_map_alloc
To:     syzbot <syzbot+5ad567a418794b9b5983@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, andreyknvl@google.com,
        andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, glider@google.com,
        hotforest@gmail.com, houtao1@huawei.com, john.fastabend@gmail.com,
        kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sfr@canb.auug.org.au, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2 Feb 2022 at 15:36, syzbot
<syzbot+5ad567a418794b9b5983@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit c34cdf846c1298de1c0f7fbe04820fe96c45068c
> Author: Andrey Konovalov <andreyknvl@google.com>
> Date:   Wed Feb 2 01:04:27 2022 +0000
>
>     kasan, vmalloc: unpoison VM_ALLOC pages after mapping

Is this a case of a new bug surfacing due to KASAN improvements? But
it's not quite clear to me why this commit.

Andrey, any thoughts?

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=128cb900700000
> start commit:   6abab1b81b65 Add linux-next specific files for 20220202
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=118cb900700000
> console output: https://syzkaller.appspot.com/x/log.txt?x=168cb900700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b8d8750556896349
> dashboard link: https://syzkaller.appspot.com/bug?extid=5ad567a418794b9b5983
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1450d9f0700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130ef35bb00000
>
> Reported-by: syzbot+5ad567a418794b9b5983@syzkaller.appspotmail.com
> Fixes: c34cdf846c12 ("kasan, vmalloc: unpoison VM_ALLOC pages after mapping")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
