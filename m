Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADD72AEF76
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 12:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgKKLUA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 06:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgKKLT5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 06:19:57 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D85C0613D1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2020 03:19:57 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id x13so674332qvk.8
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2020 03:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HL+P6C+e6EWuUkq6BT22AnRS/x2R8zWC5SF2fuIvWTY=;
        b=G7eBLWOQu/jKzydXH77LVk341vLoFf2aVMsmRzA51ZaqsLZw8reU4eMnbvGOcSaAZq
         0b3xp/oFtihhxA67Tz22LyI/Yore49lROWLIym1ViOFCxrPRQcgwHAw/NWFVF7JRvSKm
         KzNfdc/KedyImofcF1Gl6HzW0SvPt2kJolBtt/fSQNWKnHsxpXz70c+sUIfX747qok7N
         LZQVuNAH2Al9XhPCPYpPID5PU37KLRoO/v5VdbkK2DlYc3cSUs33actL4xTT8i0Zr2rw
         P3hJJL1bXlkdtS2TKLIUGe+PuhLraTqcRbvnRhYjqqBT/EF+M86YL/YhjOos1psD1mQE
         nl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HL+P6C+e6EWuUkq6BT22AnRS/x2R8zWC5SF2fuIvWTY=;
        b=UNw1vM9HbkjYGTera09guGdGjOTclIVAMkTmvFtX7SEA1TBCI9s5qgeftmkYtZywMc
         IIFrCPNMlUqLvjwaRgkV0+PIpd+iJGK4s2chJyOoUT6geSRrdB7odsTbx4exyr8hQJqU
         weU2QkyjUBEiRdltdIzAu8ph3qeuwR/c3c7gG4mGG8v4/Y8dZ+Gmy0pT+1PdBrvEc4df
         dPAVQjLbqpBq5AYBcjQwxosTNL0j3AtZG/weMzCAtKRt97MESbWLrxK6dUQTlMxcWUNH
         bEi6eoxPpdboCSAejHL4FqCPEweV8lfjCZiF/bTiavr+EqV2D0Er38rC/vNy3+FIaQQP
         6UiQ==
X-Gm-Message-State: AOAM530AoTTjNCMuKeMxXZNFD8kYXJfFmdBJVtEjgLC/bHwQpSQi508+
        Tn7mOiDefAFFh59floaVDfMM9DgPA8dkx4hxdrITxw==
X-Google-Smtp-Source: ABdhPJxSKANgqKyIaFyKJJvDKEIsAq50ZDYIvoYkWBLdIn0dbZYFOsej/MN69Kzg8OORqQgkUJcdv3y6TbWf2QePsTM=
X-Received: by 2002:a0c:8d8b:: with SMTP id t11mr24811025qvb.13.1605093596081;
 Wed, 11 Nov 2020 03:19:56 -0800 (PST)
MIME-Version: 1.0
References: <0000000000008fddd805adc8c56f@google.com> <000000000000abcd5505b0a06d96@google.com>
In-Reply-To: <000000000000abcd5505b0a06d96@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Nov 2020 12:19:45 +0100
Message-ID: <CACT4Y+bpDs82p-+vV2fki3STcdZaGcrmOqO1qh-agE7couKBHw@mail.gmail.com>
Subject: Re: general protection fault in rt6_fill_node
To:     syzbot <syzbot+81af6e9b3c4b8bc874f8@syzkaller.appspotmail.com>
Cc:     John.Linn@xilinx.com, a@unstable.cc,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>, anirudh@xilinx.com,
        Alexei Starovoitov <ast@kernel.org>,
        b.a.t.m.a.n@lists.open-mesh.org, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>, hancock@sedsystems.ca,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, mareklindner@neomailbox.ch,
        michal.simek@xilinx.com, netdev <netdev@vger.kernel.org>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Song Liu <songliubraving@fb.com>, sw@simonwunderlich.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yonghong Song <yhs@fb.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 1, 2020 at 8:46 PM syzbot
<syzbot+81af6e9b3c4b8bc874f8@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit eeaac3634ee0e3f35548be35275efeca888e9b23
> Author: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Date:   Sat Aug 22 12:06:36 2020 +0000
>
>     net: nexthop: don't allow empty NHA_GROUP
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12beed5b900000
> start commit:   c3d8f220 Merge tag 'kbuild-fixes-v5.9' of git://git.kernel..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a0437fdd630bee11
> dashboard link: https://syzkaller.appspot.com/bug?extid=81af6e9b3c4b8bc874f8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ff8539900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143f3a96900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: net: nexthop: don't allow empty NHA_GROUP
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: net: nexthop: don't allow empty NHA_GROUP
