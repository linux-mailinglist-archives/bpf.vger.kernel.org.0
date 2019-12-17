Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8177D1236D9
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2019 21:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfLQUQF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Dec 2019 15:16:05 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:40270 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfLQUQE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Dec 2019 15:16:04 -0500
Received: by mail-il1-f197.google.com with SMTP id 138so1799148ilb.7
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2019 12:16:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Zl7jDCng4WsJS3fDlSVM0kBHR2q0XfgZ7N4MzVpx9q0=;
        b=MkBbmw73mdXDvZyaiCP17U2pG1o7FI8eUTBpU5pyHcVBu3Kr5XZ2pYIsuHueVIHdk3
         est8RhIAW333EYPzCN/PKwjrKrK/a26XIKWKWGg6CFTl6tDWTMTtGEnedPqkd8wKgwoL
         T59P97ZwzahknIHmV6xSzkhk/UphyomobtiSeBEUhtbIr1ocXuDmfbccvN6W1+fe8ipS
         lfz7uHw6K2VWHDF1oE6yq7ibunsRdSVR/cI1vmtu92qznwxPLFOvxHhQTNvMl9ndcBao
         dXPa4w3e+Uraqjnc5JYMBr2IMwm/h8J50c4ae/+sGk2Tw77fLqbbPYNV10EHctqqhUpb
         Idww==
X-Gm-Message-State: APjAAAUQ49z1Pt+VoXRfZ9JCmu4+z3n+9hdfR3ZHc0EsC/0gPT44Oosb
        gQoY40xbIbX2RaeOKQZGz+UybYHL63B0PeNm5fMJ+gXJmpdF
X-Google-Smtp-Source: APXvYqzICrG8Yo/ALydErrhDqX93YfSSAQ85FdUg4jalGroBJiT3BB12c6HUe2ZyNSlzlRnSA4l2+EVqSg+tk5rH2iwmoObAicm0
MIME-Version: 1.0
X-Received: by 2002:a05:6602:25cb:: with SMTP id d11mr3095867iop.263.1576613761732;
 Tue, 17 Dec 2019 12:16:01 -0800 (PST)
Date:   Tue, 17 Dec 2019 12:16:01 -0800
In-Reply-To: <000000000000a6f2030598bbe38c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037571c0599ebff87@google.com>
Subject: Re: WARNING in wp_page_copy
From:   syzbot <syzbot+9301f2f33873407d5b33@syzkaller.appspotmail.com>
To:     andriin@fb.com, ast@kernel.org, bjorn.topel@intel.com,
        bpf@vger.kernel.org, catalin.marinas@arm.com, daniel@iogearbox.net,
        davem@davemloft.net, hawk@kernel.org, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com, jonathan.lemon@gmail.com,
        justin.he@arm.com, kafai@fb.com, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        magnus.karlsson@gmail.com, magnus.karlsson@intel.com,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this bug to:

commit 83d116c53058d505ddef051e90ab27f57015b025
Author: Jia He <justin.he@arm.com>
Date:   Fri Oct 11 14:09:39 2019 +0000

     mm: fix double page fault on arm64 if PTE_AF is cleared

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1378f5b6e00000
start commit:   e31736d9 Merge tag 'nios2-v5.5-rc2' of git://git.kernel.or..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10f8f5b6e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1778f5b6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=9301f2f33873407d5b33
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10fd9fb1e00000

Reported-by: syzbot+9301f2f33873407d5b33@syzkaller.appspotmail.com
Fixes: 83d116c53058 ("mm: fix double page fault on arm64 if PTE_AF is  
cleared")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
