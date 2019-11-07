Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C346DF3535
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 17:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfKGQ7V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 11:59:21 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40968 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKGQ7U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Nov 2019 11:59:20 -0500
Received: by mail-yb1-f195.google.com with SMTP id d95so718994ybi.8
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 08:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OY3mL3SJty7WONSqI9Sp3mmm9hhK0YCgUyTwKH16DyM=;
        b=NNUuOmM7CKWjGHRTbNqGdtPWTCVZ0EOBnHBVZa3Du0rkbJ7FuAdoM+5baW/0stuk3E
         gCiivLgsL72BauezxIjWfOW69541tetppjNLpG2D95N8+F/Wn/SGBAKFTqnLiB7KU6Lx
         CX3qq1gGt+ByA9Y561UNZy9VW7qUxNA/RFLeIB6YzUt5jxNcSAniQlhV5waLfLIYwRmI
         CNEAmi7iXeMVT9AdY2V3t1FWvhKfmU8ccDR4oOIJ+vrikdE91d1U2H6AutP4iBv4Leoj
         +HqRPkKjWHec2HWsuDwlAK0V8pdoaeVsGF3xzqc4YUKmwU5Ea5BiwNPzJA4399Kyj9sf
         hYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OY3mL3SJty7WONSqI9Sp3mmm9hhK0YCgUyTwKH16DyM=;
        b=c5BpRNH0hmsYgL8OpdSziGkP13DSCbUcxk1y/o2V32+cQ7poKHnCMRLtDaeNpaU0QK
         vH3Us5guD3Yh2IaztFFLNYR76ngdWII9uitsLB54B/Qy+jyeN+gRrwzmjEs3xkrDOehq
         uwiojmrxS8g2nm9WoxMieygHo1wxNBJVYwNBUxwQNDJ3MyRtLYK1L0aC3XMijE5V6Yvb
         mzaSAUODWIG8liDIUUyKjLrtIDFzqXrw5TljMNq6RYNPr1iy5Y1g7pFF0OeL53t50U/6
         LPYUkJeDj8pWwg4K5xNL2xVTRfbkz4uIUO+Cfm7NpIlyplBk3uWxr+0Je59U6XIoYlax
         UJSg==
X-Gm-Message-State: APjAAAWaA2u8OxHUXdSTWurHp6BHRX2bKGoAnkkHuwpN5w03E3b6Eq5t
        rI/gWiOe19NMwDq9nIo8Yy/Fn8vq
X-Google-Smtp-Source: APXvYqykc5wYt5hOgelNraYjh0B3LuFYBOKVqhAf5FpVSDF5IBys8PXwGAPgO7pyLCcOPaMuIGEpzw==
X-Received: by 2002:a25:2ac5:: with SMTP id q188mr4223239ybq.413.1573145959183;
        Thu, 07 Nov 2019 08:59:19 -0800 (PST)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id q127sm2991447ywc.43.2019.11.07.08.59.17
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 08:59:18 -0800 (PST)
Received: by mail-yw1-f42.google.com with SMTP id y18so833816ywk.1
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 08:59:17 -0800 (PST)
X-Received: by 2002:a0d:fe06:: with SMTP id o6mr1541900ywf.424.1573145957443;
 Thu, 07 Nov 2019 08:59:17 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f68d660570dcddd8@google.com> <000000000000e51d450596c1d472@google.com>
In-Reply-To: <000000000000e51d450596c1d472@google.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 7 Nov 2019 11:58:41 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdz-+Hj2itAiC5uiP0X7aHP4YPG1+1k_bbE+OCBK+P0Rg@mail.gmail.com>
Message-ID: <CA+FuTSdz-+Hj2itAiC5uiP0X7aHP4YPG1+1k_bbE+OCBK+P0Rg@mail.gmail.com>
Subject: Re: kernel BUG at net/ipv4/ip_output.c:LINE!
To:     syzbot <syzbot+90d5ec0c05e708f3b66d@syzkaller.appspotmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>, johannes.berg@intel.com,
        Martin Lau <kafai@fb.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        Yonghong Song <yhs@fb.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 7, 2019 at 8:42 AM syzbot
<syzbot+90d5ec0c05e708f3b66d@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this bug was fixed by commit:
>
> commit e7c87bd6cc4ec7b0ac1ed0a88a58f8206c577488
> Author: Willem de Bruijn <willemb@google.com>
> Date:   Wed Jan 16 01:19:22 2019 +0000
>
>      bpf: in __bpf_redirect_no_mac pull mac only if present
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14175486600000
> start commit:   112cbae2 Merge branch 'linus' of git://git.kernel.org/pub/..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=152cb8ccd35b1f70
> dashboard link: https://syzkaller.appspot.com/bug?extid=90d5ec0c05e708f3b66d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153ed6e2400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1539038c400000
>
> If the result looks correct, please mark the bug fixed by replying with:
>
> #syz fix: bpf: in __bpf_redirect_no_mac pull mac only if present

#syz fix: bpf: in __bpf_redirect_no_mac pull mac only if present
