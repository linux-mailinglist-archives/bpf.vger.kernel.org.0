Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17514474A23
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 18:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbhLNR5K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 12:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbhLNR5F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Dec 2021 12:57:05 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60131C061574
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 09:57:05 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso21826089otf.0
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 09:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/H7rX83HhVfXFvq1heK100p2q6fw7H+xxgOW7PvMyko=;
        b=Aktbnj7mjAJP1MHWOzJ25kUD9Mh2ep/OfmcCIE8BxEenkMXYs27EbwYE8zrcsjhe8U
         MSm85rH2WWgDxPWLUjaJe1JUwK0IxnIYKPtUxgHo7GLaOoUT659BFebFXrcz3pkI/jb8
         VlOnjzTtCVTj+4OvTLnY+e3ITHz7DMCd0yMfVg7a/1r7S4zRaIJ3izM+XBvkPZ340MeU
         q+SACwTyrTEmo4nVeYe4woeygAfDe4PUagcKAGYD0Ot/S2CIAIjfGGcbVUBK8V8lRoLS
         kxPqcNK+I8ST3wT/OEscw0uiqfO3mmCo4sYy2Q9rIXgkuUcq7eXZrjx9UDK+DppnZE+T
         6t0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/H7rX83HhVfXFvq1heK100p2q6fw7H+xxgOW7PvMyko=;
        b=Vn4rg+AhN5LisovkPS0JI7aqiykW/DdPWlCwx8cNiRQwk7756trXCtTm9ZjOVyCgm0
         kq3h3JK66zQy0FG3RwoVMXJKfKDHJodSBmU6bkn6EDbiEWL4WeBac+0siCCS3B82V9bp
         2vd5U6UmebkahcZ6Cpg1WXp2EEsTUjzaX65gdqz5s/Gfg9TrXBt8k3Mj+ZltZqIof3tx
         VNKoeQ/as+8+sIRl5EY7NnI7227f3HWTbT908cyuVjAVqnddm8gVSyuFOeWd2ua8R1ls
         yeFpWLUHM3aw/VJxeBVmSOZrvRLLm3l3NJ9H81sL7NnnnkB8YLthjfKwxZhI5OmT+eet
         I2xQ==
X-Gm-Message-State: AOAM5300PchhloOjKSqE+Esi2XczG9Ywk70Tl7O7vr42H0jLMd4d6gLX
        k7aYRV7ZpMFPNzUstIqGhcsbpl/bFMWu+C0oFg2gOQ==
X-Google-Smtp-Source: ABdhPJxBM3VWKaTJZcCayvxWwcLTYZ1GEYJE9ZsUHd6Q1M9Jw5ZUfs5BTGrjSyGxRoRSlVPVob+OXiYG1PPrWwGIiAA=
X-Received: by 2002:a9d:4f0e:: with SMTP id d14mr5500879otl.137.1639504624541;
 Tue, 14 Dec 2021 09:57:04 -0800 (PST)
MIME-Version: 1.0
References: <0000000000005639cd05ce3a6d4d@google.com> <0000000000004e75ca05d316779f@google.com>
In-Reply-To: <0000000000004e75ca05d316779f@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 14 Dec 2021 18:56:53 +0100
Message-ID: <CACT4Y+bhSEMPO4wi+eS75G3FKBR-USF9a9EniLHFmg8rynBV3w@mail.gmail.com>
Subject: Re: [syzbot] BUG: corrupted list in netif_napi_add
To:     syzbot <syzbot+62e474dd92a35e3060d8@syzkaller.appspotmail.com>
Cc:     alexandr.lobakin@intel.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        edumazet@google.com, hawk@kernel.org, hdanton@sina.com,
        jesse.brandeburg@intel.com, joamaki@gmail.com,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org, maximmi@nvidia.com,
        netdev@vger.kernel.org, pabeni@redhat.com, saeedm@nvidia.com,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        toke@toke.dk, vladbu@nvidia.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 14 Dec 2021 at 08:52, syzbot
<syzbot+62e474dd92a35e3060d8@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 0315a075f1343966ea2d9a085666a88a69ea6a3d
> Author: Alexander Lobakin <alexandr.lobakin@intel.com>
> Date:   Wed Nov 10 19:56:05 2021 +0000
>
>     net: fix premature exit from NAPI state polling in napi_disable()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=138dffbeb00000
> start commit:   911e3a46fb38 net: phy: Fix unsigned comparison with less t..
> git tree:       net-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d36d2402e8523638
> dashboard link: https://syzkaller.appspot.com/bug?extid=62e474dd92a35e3060d8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141592f2b00000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: net: fix premature exit from NAPI state polling in napi_disable()
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection


Looks reasonable based on the subsystem:

#syz fix: net: fix premature exit from NAPI state polling in napi_disable()
