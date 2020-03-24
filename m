Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9325D1903AD
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 03:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgCXCrI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 22:47:08 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:39275 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgCXCrF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Mar 2020 22:47:05 -0400
Received: by mail-io1-f71.google.com with SMTP id v13so11434551iox.6
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2020 19:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=LOv2WyxOQNJMMiel1AjLpQJL3nLG4+bZfZZebAkOi9k=;
        b=n37W6W65g7ZKvxM1CazULg87/vqfm/hf6zLxb6Qar2PTsVAlLQReEPPo/0xf0daJ80
         v+hWZ1Q7sthemeO+H6HxQvcGTTo+0ZnZm0Mkkuu03k4r8j5+E6JbyIK5GnXaB2ltZcfl
         WEr8JS4EU0LiLW/6UahdDb0WU/pQwtC7L9YimbIktG4WhUnD71kRgm9bLzpU6raanFEg
         +GsYk9oWlcrTqwlaVpWFJhuAI8sDILATU3MirUwm5aAMMT/LsNKFvZrhdbXZDSfVhEtI
         r+QuVTLqMofgGc7zygFcmTMk/zPwg459dRqOeDpSaify6Lpf0qBgCOthF7tAywF+9ino
         +m/w==
X-Gm-Message-State: ANhLgQ3Z5oYsvkckEUhsjjeYnYYvo/f2+08+Cc+AmnQdgypI9ZfgoZ+R
        9f3mv5QHJf12t/Wpl4KqWKM5ctzzuwILk0YtxOpwHlMKf5FK
X-Google-Smtp-Source: ADFU+vstiI7NkY8P0sLiaAwA1tlgY+DAUVfkvxxrtQc1GUcIriiMD4ZAGZsTUHBhY7pwHk2p3ulODfmE2r7ZpymGWtd3GqW4WeUB
MIME-Version: 1.0
X-Received: by 2002:a02:6cd5:: with SMTP id w204mr22866930jab.43.1585018023533;
 Mon, 23 Mar 2020 19:47:03 -0700 (PDT)
Date:   Mon, 23 Mar 2020 19:47:03 -0700
In-Reply-To: <000000000000a6f2030598bbe38c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004162e805a190c456@google.com>
Subject: Re: WARNING in wp_page_copy
From:   syzbot <syzbot+9301f2f33873407d5b33@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andriin@fb.com, ast@kernel.org,
        bjorn.topel@intel.com, bpf@vger.kernel.org,
        catalin.marinas@arm.com, daniel@iogearbox.net, davem@davemloft.net,
        hawk@kernel.org, jakub.kicinski@netronome.com, jmoyer@redhat.com,
        john.fastabend@gmail.com, jonathan.lemon@gmail.com,
        justin.he@arm.com, kafai@fb.com, kirill.shutemov@linux.intel.com,
        kirill@shutemov.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, magnus.karlsson@gmail.com,
        magnus.karlsson@intel.com, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit c3e5ea6ee574ae5e845a40ac8198de1fb63bb3ab
Author: Kirill A. Shutemov <kirill@shutemov.name>
Date:   Fri Mar 6 06:28:32 2020 +0000

    mm: avoid data corruption on CoW fault into PFN-mapped VMA

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1170c813e00000
start commit:   e31736d9 Merge tag 'nios2-v5.5-rc2' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=9301f2f33873407d5b33
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10fd9fb1e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: mm: avoid data corruption on CoW fault into PFN-mapped VMA

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
