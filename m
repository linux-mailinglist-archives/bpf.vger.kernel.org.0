Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5111A2F09E4
	for <lists+bpf@lfdr.de>; Sun, 10 Jan 2021 22:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbhAJVer (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Jan 2021 16:34:47 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:33023 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbhAJVeq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Jan 2021 16:34:46 -0500
Received: by mail-il1-f199.google.com with SMTP id k5so3867439ilu.0
        for <bpf@vger.kernel.org>; Sun, 10 Jan 2021 13:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4LoZGTCd2t0PplwDQfQEE+U/aUfHCI0fmScR3fZ7eks=;
        b=jIGnFKNW1GmClUF6MHMylxt7pmYN8ZwYDX9H5fsY1OkAOrG7Lf+hqB1wrI6quNY4Vx
         DBd2o++nz4mD63u+CiPJIGvUBT/dun9hxBDKXBaEp5zGJj4kE7malaNUDl3ZHKN64DcX
         isC6UA/6YmfNKi8Gtqu2zl2pr4I+0Djw05o+8eSJO9NKdElxr8G3z46ZtzOMusoTcjr1
         5lPWi2kg7B2nfjS1RZiSp+qj/1OQlXpw77fwOuZTMcFd2f0E6ea85TqRLjefjDCP+qcP
         QjfHJDDUKoJik84cnRlBEQ2wtuQvlPH91p2e/CXKw98dXoK5O9CVKvbq78AtMGJjEju6
         R2wQ==
X-Gm-Message-State: AOAM530hGZtAMKAUqa6/Dn3nnCy0PjRHEvmRYxRRKv8XOJhWJyfXDmF4
        CSg1awPsquTM/K9LOzrkhTLW47omJfo/lyasbU+/SyNpsQi+
X-Google-Smtp-Source: ABdhPJx67Ra1fKhg2km05vdN/7nOfGovy2vCeemD7oaDvO+wU2FWsRqdlpTPosKZn2Kc7GVpOHOHrDRZ6reF4GfhUVz3wBglI2w6
MIME-Version: 1.0
X-Received: by 2002:a92:ad05:: with SMTP id w5mr12555250ilh.226.1610314445966;
 Sun, 10 Jan 2021 13:34:05 -0800 (PST)
Date:   Sun, 10 Jan 2021 13:34:05 -0800
In-Reply-To: <000000000000588c2c05aa156b2b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087569605b8928ce3@google.com>
Subject: Re: kernel BUG at mm/vmalloc.c:LINE! (2)
From:   syzbot <syzbot+5f326d255ca648131f87@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org,
        bjorn.topel@intel.com, bp@alien8.de, bpf@vger.kernel.org,
        daniel@iogearbox.net, dave.hansen@linux.intel.com,
        davem@davemloft.net, hawk@kernel.org, hpa@zytor.com,
        john.fastabend@gmail.com, jonathan.lemon@gmail.com, kafai@fb.com,
        kpsingh@chromium.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        magnus.karlsson@intel.com, marekx.majtyka@intel.com,
        mingo@kernel.org, mingo@redhat.com, netdev@vger.kernel.org,
        peterz@infradead.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        x86@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 537cf4e3cc2f6cc9088dcd6162de573f603adc29
Author: Magnus Karlsson <magnus.karlsson@intel.com>
Date:   Fri Nov 20 11:53:39 2020 +0000

    xsk: Fix umem cleanup bug at socket destruct

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=139f3dfb500000
start commit:   e87d24fc Merge branch 'net-iucv-fixes-2020-11-09'
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=61033507391c77ff
dashboard link: https://syzkaller.appspot.com/bug?extid=5f326d255ca648131f87
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d10006500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126c9eaa500000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: xsk: Fix umem cleanup bug at socket destruct

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
