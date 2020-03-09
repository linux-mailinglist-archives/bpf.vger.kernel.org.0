Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFD017D978
	for <lists+bpf@lfdr.de>; Mon,  9 Mar 2020 07:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgCIG6D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Mar 2020 02:58:03 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:49275 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgCIG6D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Mar 2020 02:58:03 -0400
Received: by mail-il1-f197.google.com with SMTP id b72so6751887ilg.16
        for <bpf@vger.kernel.org>; Sun, 08 Mar 2020 23:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=3vbHTdYQ67mib1pqhw7RfSE7n4B7fPNmRK2m1Cb8iPU=;
        b=KVvxHOv2XO+ZvWeaRU9gMy110OHVbklaNy1an+J1GCRNTFHDtQLHnn/k5vM4c3CNfa
         eSg4LsAYNu3BoQwAB8swVVqgYJv19l9zVOFLhvPK/MdxpkOAoQP6J2n6QAt/k/MRmPFq
         MXkXp9v8ZXO0Eqp9f9iSpJQ2bpDOX4m9mIKSbKX8UFu3n1qXN96dPIkRM5KeFDxGzeq5
         NgvaaEHUuAPuws5m//O2qp+ygPHqrL/YIuGUUcGTaryKGdZAmudq3/S7UByPQitCsTH8
         8JNhTT96e4GDP5jhNtUTbsf45dTOE5YIqUlCQkoSx/57cye18tbwR3ov/Rd0A3TXK11k
         8TyQ==
X-Gm-Message-State: ANhLgQ2uc8aWoNumRgTtGxR8cGyRk5yMkv70DyqVO5CbHbWeD6iiQYr2
        vo4P2cGZATt3lQYfeEMNHNoG42Sh5HmfNS7mghkZTm1aRypz
X-Google-Smtp-Source: ADFU+vtRpURm6U4wUgm5w3Q/LMCwhNNEMjTRsTn2XqAL2qLJHVJT0lEdDhwiPvd5cYSVN+QMhS0AUF7kTWiMSzfA+d9Rg3PvE9EA
MIME-Version: 1.0
X-Received: by 2002:a5d:9bc8:: with SMTP id d8mr12563436ion.142.1583737083027;
 Sun, 08 Mar 2020 23:58:03 -0700 (PDT)
Date:   Sun, 08 Mar 2020 23:58:03 -0700
In-Reply-To: <000000000000161ee805a039a49e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000406a7f05a066861d@google.com>
Subject: Re: possible deadlock in siw_create_listen
From:   syzbot <syzbot+3fbea977bd382a4e6140@syzkaller.appspotmail.com>
To:     ast@kernel.org, bmt@zurich.ibm.com, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dledford@redhat.com,
        dsahern@gmail.com, hawk@kernel.org, jakub.kicinski@netronome.com,
        jgg@ziepe.ca, jiri@mellanox.com, johannes.berg@intel.com,
        john.fastabend@gmail.com, kafai@fb.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        mkubecek@suse.cz, netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this bug to:

commit bfcccfe78b361f5f6ef48554aed5bcd30c72f67f
Author: Jakub Kicinski <jakub.kicinski@netronome.com>
Date:   Tue Nov 5 21:26:11 2019 +0000

    netdevsim: drop code duplicated by a merge

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=166d11c3e00000
start commit:   425c075d Merge branch 'tun-debug'
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=156d11c3e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=116d11c3e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=598678fc6e800071
dashboard link: https://syzkaller.appspot.com/bug?extid=3fbea977bd382a4e6140
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e3df31e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163d0439e00000

Reported-by: syzbot+3fbea977bd382a4e6140@syzkaller.appspotmail.com
Fixes: bfcccfe78b36 ("netdevsim: drop code duplicated by a merge")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
