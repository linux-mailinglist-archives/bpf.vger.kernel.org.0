Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07068F317E
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 15:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfKGOcE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 09:32:04 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42031 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfKGOcE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Nov 2019 09:32:04 -0500
Received: by mail-yb1-f193.google.com with SMTP id a11so698960ybc.9
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 06:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yRYqa1o2NdhEBRGJeqYIB6zt6VJ6WLQd957CNIrLVtU=;
        b=V31+97gEuKcwS9OaNqcWuLxaf6Dk9IUdRwjbv1EpOWaTkrPxYHB2EW3c7/ri43Q6k7
         bwFNF/T9wGxfriCODN4BuqYv6VwhvwZPWBTV4Pn0+HUEPmow694LOsl9dm08jzg4mhod
         Lu5WoqEIQ7TCMvBtSirFujYbjNVn9mXg+n7ZwkwkNz2gJVMUk7E5ofu+1hUzGuG8liRX
         cTx09BiykjRuupe9Q5PDg6qJXwNkBE1dU1vBm8WzSLfnmHE/Bij8LTKZTUJJAYRdDGd2
         rbHLjCvp9ZGLmy3aZAkHGBw48R5p5w24mgg3G/2oeRwyxZGzAvUAI9fJkGYLmrWNlsea
         E+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRYqa1o2NdhEBRGJeqYIB6zt6VJ6WLQd957CNIrLVtU=;
        b=MsfD66+e0cByfvfPYU58lvs4NfbDNAV+Am4p+Ky0Cm2uadIyQUCTtNwePuvpTBGI70
         /++qOJz+08Ed4Z9pZpikmsGM4RwdHzqQWpJ87S7M3PdQ8RqSCa4uwuf8Q2yvki3d61kh
         cNMhspC7vBA6Cc9lNJs+/GCPWaIbi2OxsfnyQw2CMig6k5BRAVihpq1RcLLtTcAvyusb
         3eiOfV1pqmtvOQ982phJC6Qu3Of07UTzZ6RamLIFz5o4WiB3X8Ka1blPahHIFqnC/U1f
         p9tSiJ8XR7NXoK2o4ZHFL8PLeWSQUAZMkWSrhVP3L5ugzDCP7Grr46Cc9U11+D5FSkl0
         vgRA==
X-Gm-Message-State: APjAAAVdBqyQK3sFpEfTMuqn2ATgTY/1AYjwWqFBdJZtFLJMNOMIXp76
        e7lmqeU0hOBinQgDjC2rQbEJzUpM
X-Google-Smtp-Source: APXvYqyPYvoo/y9en2xyW9cVZqC/GUD5RJpMcXcN6CGck0WF8AvA5bUXDRRtVPiiTH06V3uBThzGXw==
X-Received: by 2002:a25:7ec4:: with SMTP id z187mr735954ybc.153.1573137122349;
        Thu, 07 Nov 2019 06:32:02 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id n11sm1533866ywd.79.2019.11.07.06.32.00
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 06:32:01 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id f6so1006974ybp.1
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 06:32:00 -0800 (PST)
X-Received: by 2002:a25:cf55:: with SMTP id f82mr3672759ybg.203.1573137120264;
 Thu, 07 Nov 2019 06:32:00 -0800 (PST)
MIME-Version: 1.0
References: <0000000000008d5a360575368e31@google.com> <000000000000cd76fb0596c1d41c@google.com>
In-Reply-To: <000000000000cd76fb0596c1d41c@google.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 7 Nov 2019 09:31:24 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfVgPM4DZcvaRjDinoyg7cA+Pj4oCO-13+7PsFGrhuC+w@mail.gmail.com>
Message-ID: <CA+FuTSfVgPM4DZcvaRjDinoyg7cA+Pj4oCO-13+7PsFGrhuC+w@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in _decode_session6
To:     syzbot <syzbot+e8c1d30881266e47eb33@syzkaller.appspotmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        johannes.berg@intel.com, Martin Lau <kafai@fb.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>, songliubraving@fb.com,
        Steffen Klassert <steffen.klassert@secunet.com>,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        Yonghong Song <yhs@fb.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 7, 2019 at 8:42 AM syzbot
<syzbot+e8c1d30881266e47eb33@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this bug was fixed by commit:
>
> commit e7c87bd6cc4ec7b0ac1ed0a88a58f8206c577488
> Author: Willem de Bruijn <willemb@google.com>
> Date:   Wed Jan 16 01:19:22 2019 +0000
>
>      bpf: in __bpf_redirect_no_mac pull mac only if present
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1736f974600000
> start commit:   b36fdc68 Merge tag 'gpio-v4.19-2' of git://git.kernel.org/..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4c7e83258d6e0156
> dashboard link: https://syzkaller.appspot.com/bug?extid=e8c1d30881266e47eb33
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d42021400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d09f1e400000
>
> If the result looks correct, please mark the bug fixed by replying with:
>
> #syz fix: bpf: in __bpf_redirect_no_mac pull mac only if present

#syz fix: bpf: in __bpf_redirect_no_mac pull mac only if present

indeed manually reproduced at e7c87bd6cc4e~1, failed to reproduce at
e7c87bd6cc4e. Also seems plausible given the stack trace.
