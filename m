Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D39494FF0
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 15:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345492AbiATORO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 09:17:14 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:49816 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345465AbiATORO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 09:17:14 -0500
Received: by mail-io1-f71.google.com with SMTP id g16-20020a05660203d000b005f7b3b0642eso3983872iov.16
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 06:17:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5zUthvSwK0sqk11Dn7VG8wBClAg34bmNSNa9m/oeNxU=;
        b=S/oHbCb2jaHQ9vciZpn++rRC0zJw6es9fOrdgThqH5hVtKleuUrNTaxEGozD+M+QRf
         uruEki7BV40CMwQ+zjoPzy+5v0gVtUX/FXq99tfVf/I4aiVH493ekqkBRo1TAq17BHKt
         8p/CRoQ6eup3VhCIyvZwBfjL0/MhJfAWXMOiccJkVwK/Sb9aIZQOL7ybd5ZShdyl/y8E
         lsgLegg3ym7PGJJQiVvzyHVt3f4S5zxrR/KhrCluLRy+0uiFbY52qgwQ123ztUp3whki
         y1TbE/TkPJ7y+En+w30OUGinvzVaKmmYc6lkURIbp08bPNBl6iYujoqLERpZfvsMND5r
         nSQw==
X-Gm-Message-State: AOAM533QF9LTtQPBnFyGxbQSpbfXrIbFzh1lt74RY3CdR8iF8DlxTqOW
        z+roBK9KuqdrHegqz6IouFY9rZWDE20PgiZOQveaYLN33oin
X-Google-Smtp-Source: ABdhPJxLhJKGSJhhtuBSTLp+T6IQLDGp9xYUNTxc0c5dFIq3tLXSHuDkiL8uVtJqcGcnBkgFRhIy7ytGHDQRXl/OI55E4rZe9mVH
MIME-Version: 1.0
X-Received: by 2002:a05:6638:770:: with SMTP id y16mr16875982jad.242.1642688233317;
 Thu, 20 Jan 2022 06:17:13 -0800 (PST)
Date:   Thu, 20 Jan 2022 06:17:13 -0800
In-Reply-To: <000000000000367c2205d2549cb9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fa8ee05d60428f1@google.com>
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Read in __bpf_prog_put
From:   syzbot <syzbot+5027de09e0964fd78ce1@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, fgheet255t@gmail.com,
        hawk@kernel.org, jakub@cloudflare.com, john.fastabend@gmail.com,
        kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, lmb@cloudflare.com,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 218d747a4142f281a256687bb513a135c905867b
Author: John Fastabend <john.fastabend@gmail.com>
Date:   Tue Jan 4 21:46:45 2022 +0000

    bpf, sockmap: Fix double bpf_prog_put on error case in map_link

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12919c37b00000
start commit:   662f11d55ffd docs: networking: dpaa2: Fix DPNI header
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa556098924b78f0
dashboard link: https://syzkaller.appspot.com/bug?extid=5027de09e0964fd78ce1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fccadbb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1598d9ebb00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf, sockmap: Fix double bpf_prog_put on error case in map_link

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
