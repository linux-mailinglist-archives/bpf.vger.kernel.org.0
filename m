Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097FD3E125C
	for <lists+bpf@lfdr.de>; Thu,  5 Aug 2021 12:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbhHEKN1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Aug 2021 06:13:27 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:49989 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240328AbhHEKN0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Aug 2021 06:13:26 -0400
Received: by mail-io1-f72.google.com with SMTP id k6-20020a6b3c060000b0290568c2302268so3351099iob.16
        for <bpf@vger.kernel.org>; Thu, 05 Aug 2021 03:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mfp3dcRamri2wGmkRJSK01Pfy3daGYI42UfXp0QgTjU=;
        b=LWQBRxQOyr+vuflWwyV6sVZW/X56eC3iqo+uRECFMXMkV4ILfxUEN8S/Qt2oRIe4PI
         v2q1ZtUoh2bSUqV1MdOFsABXkO/IWUIQ159iUKB5RLLeCreUvubYDzXVc7ooz1ntRTe1
         eLiRSE0Xk1DyHiaLin33EiaHiuLcvy2BpTlSm1uPm7oNYfepMtvPR4g01IpYjexXxBqb
         7CoYLWaEHloDwWE2pCZd2axh+toGqosMrzMFeIGW73AVSCe+CM0PIicvNMkeWQdPpA/c
         +5OpdY50lVIV24YvsB2q8U4ousxk3DIFnx2pMG02BN29JcGaGnyHqPRLWaIYsUObyPb6
         mF0A==
X-Gm-Message-State: AOAM5305WDedxtyYNWQ5lzunZsXdGsZiX6xpqhAtNU3FWJhIBnAfJvpM
        K/ih+JQbeZSumdw6mGhwnD3m6Z1qQ1JLOmks6mIQFL470Ias
X-Google-Smtp-Source: ABdhPJzPTZ4ctrrUGavvOHBH4NTS8BJbXcUPvlgq/7QfOSLC+LhG2uxQJN+Qfdv0epwVMqtQzdMZM9CmWaSpH6ty4Vl8Ed/4Bek7
MIME-Version: 1.0
X-Received: by 2002:a6b:28a:: with SMTP id 132mr527433ioc.157.1628158390707;
 Thu, 05 Aug 2021 03:13:10 -0700 (PDT)
Date:   Thu, 05 Aug 2021 03:13:10 -0700
In-Reply-To: <00000000000040b7ba05ae32a94a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000842d2f05c8cd2ac7@google.com>
Subject: Re: [syzbot] possible deadlock in __sock_release
From:   syzbot <syzbot+8e467b009209f1fcf666@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, dave@pr1mo.net, davem@davemloft.net,
        dsahern@kernel.org, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 8fb4792f091e608a0a1d353dfdf07ef55a719db5
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Tue Jul 20 13:08:40 2021 +0000

    ipv6: fix another slab-out-of-bounds in fib6_nh_flush_exceptions

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=113a99f1300000
start commit:   c6c205ed442e Merge branch 'stmmac-ptp'
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=26b64b13fcecb7e1
dashboard link: https://syzkaller.appspot.com/bug?extid=8e467b009209f1fcf666
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152188d2300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d5493c300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ipv6: fix another slab-out-of-bounds in fib6_nh_flush_exceptions

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
