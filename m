Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26168F3027
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 14:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389105AbfKGNmw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 08:42:52 -0500
Received: from mail-qk1-f200.google.com ([209.85.222.200]:43830 "EHLO
        mail-qk1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389136AbfKGNmJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:09 -0500
Received: by mail-qk1-f200.google.com with SMTP id a16so2293110qka.10
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 05:42:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vnRsz0/rOqX31qWVqa+jCcqeQTYMdPmUZHcF8We9FRA=;
        b=BsWntnigamaNqWZ7mBDr5KPNc5BFjJJD1VNAOp+z5ZKpQsB6t3Bzwftg/TE+W7Hso7
         4bLPwDkFGJvE3nm/BkNXVLZTe6X+GK5mL2UikqoF0ashQ5QlbS/Rn8LeAPKkyEPGuFsf
         /zoxX/70Q+9Y//PSiLh5QDRUgwiTZo4KCok1qVjHR+6tVP92S8YgZ2mZYo2UK+sP8YHL
         Z8WC04/5rIaEr+7DSGlR9gvoatFCi2lJo8slpnmJngoU3SQrwYvqzB5ObXVyi4B7cAbU
         UgtHq+ErQqYljbhH331B0JcsLVbBiU/3jkabd3CudDW5BtWywMot31IoxAIUC6WssxsG
         vLsA==
X-Gm-Message-State: APjAAAW7OzVNLbjS1EqeVK2KVw1tzII0DnoT2qqrwKfJAbUaQcVG+nDR
        qIugB95umIevNoswxIqSZ4Ah6uaBvA5Eie6BL/K9NXKGXsG1
X-Google-Smtp-Source: APXvYqxag6ODkk8Wbv8Wdp6mU+iNDO/+EsH5xk9k1x/wiqR1dAXliax/9/yHrkDCGJ9jCF/t7qMAyUhTeT+GGlYdhmUlfnYJ7pvc
MIME-Version: 1.0
X-Received: by 2002:a6b:8b02:: with SMTP id n2mr3600626iod.66.1573134126640;
 Thu, 07 Nov 2019 05:42:06 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:06 -0800
In-Reply-To: <0000000000008d5a360575368e31@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd76fb0596c1d41c@google.com>
Subject: Re: KASAN: use-after-free Read in _decode_session6
From:   syzbot <syzbot+e8c1d30881266e47eb33@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, dsahern@gmail.com,
        herbert@gondor.apana.org.au, johannes.berg@intel.com, kafai@fb.com,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, posk@google.com, songliubraving@fb.com,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, willemb@google.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit e7c87bd6cc4ec7b0ac1ed0a88a58f8206c577488
Author: Willem de Bruijn <willemb@google.com>
Date:   Wed Jan 16 01:19:22 2019 +0000

     bpf: in __bpf_redirect_no_mac pull mac only if present

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1736f974600000
start commit:   b36fdc68 Merge tag 'gpio-v4.19-2' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c7e83258d6e0156
dashboard link: https://syzkaller.appspot.com/bug?extid=e8c1d30881266e47eb33
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d42021400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d09f1e400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: bpf: in __bpf_redirect_no_mac pull mac only if present

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
