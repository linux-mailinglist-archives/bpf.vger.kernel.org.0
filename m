Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DED2062F25
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2019 06:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbfGIEIB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Jul 2019 00:08:01 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:44112 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfGIEIB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Jul 2019 00:08:01 -0400
Received: by mail-io1-f72.google.com with SMTP id s9so18345489iob.11
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2019 21:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Tojd49K4TWJ2ahCpfLjRNApjFre4XIEC+uxSBIyo+38=;
        b=XxO3enggT8j8yiU5VTfrvikR24qs1jPgendUG8/Limh4+b+5p0XFFUHF/X6PufNGpU
         15pUXG2c+ng7TXIu2M2P+2hgVl/T9t3mgd2gqTWXFkziSle6qqGvDBqaGA76jlhbWx3Q
         UkK3AkLZQIcqLAE1MmNvTc2ht2pWld3QOZmiiqPN0QEHq52PR5/ubdYepv9kkMyfgabi
         016HJ5CD8pi5jWY1wq57hFmpQgGZi/t/NtYy6+14Sa8jsPXuckW3CN/v2868y6RcVjSk
         a8Ik4aHDHFmJiRzyIDl3d/kqyFqyM2prDhzNIteg2ExYNkajATS4vQASsVxOO/LI0AV9
         u/4w==
X-Gm-Message-State: APjAAAVJZxyH3Rd39i/bg+RI+AfkiOtTHnZroKms5jlQzje/90wrwhjV
        H7Z7hNmsBOmKlueJHddipy+X5PH8nV5VRVg3pFpuL5b/u4cl
X-Google-Smtp-Source: APXvYqxm/mXCoJ5Hk6y8vR6v2IS4oj/n6X0W9JquEY5V/Gz6bIh3qzQKuPRQYew4ljT/GIOxZ10ZAdEqTPIVIKbtLtZFlys15uqe
MIME-Version: 1.0
X-Received: by 2002:a6b:cf17:: with SMTP id o23mr791127ioa.176.1562645280222;
 Mon, 08 Jul 2019 21:08:00 -0700 (PDT)
Date:   Mon, 08 Jul 2019 21:08:00 -0700
In-Reply-To: <CAEf4BzZfqnFZRbDVo1-=Vph=NpOm1g=wGuV_O5Cniuxj9f9CsQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d676f2058d37b4a9@google.com>
Subject: Re: WARNING in __mark_chain_precision
From:   syzbot <syzbot+4da3ff23081bafe74fc2@syzkaller.appspotmail.com>
To:     andrii.nakryiko@gmail.com, ast@kernel.org, bcrl@kvack.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        hawk@kernel.org, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com, kafai@fb.com, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, xdp-newbies@vger.kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+4da3ff23081bafe74fc2@syzkaller.appspotmail.com

Tested on:

commit:         b9321614 bpf: fix precision bit propagation for BPF_ST ins..
git tree:       https://github.com/anakryiko/linux bpf-fix-precise-bpf_st
kernel config:  https://syzkaller.appspot.com/x/.config?x=6bb3e6e7997c14f9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
