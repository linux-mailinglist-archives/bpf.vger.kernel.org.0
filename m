Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8057A4D83
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2019 05:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfIBDX6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 Sep 2019 23:23:58 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45509 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729229AbfIBDXz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 1 Sep 2019 23:23:55 -0400
Received: by mail-qk1-f193.google.com with SMTP id m2so11341156qki.12
        for <bpf@vger.kernel.org>; Sun, 01 Sep 2019 20:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XPLkdTaS+cWviKWsyXZOkahcwDz4T4iRqzOYOjVp7Io=;
        b=Bjd4dmZKm9ahzyCGqWgK2g+TjcFTBZ1FrTjYxEToos+V4YveECHwHx9p1DkAHT4Xhr
         lpwY9V1q/wMkVg2z/8D56u825hL5LemsxNInEYAKLNu1m3Ubo/MP3i0tUBuFiul4q9HE
         2KV/4MRk3FoYm0Abm4Yy+cLPpa64EpHV4Bg3evz6xas0jmbjo74Val4ikz9hgYgEqBQZ
         yLBnUiKWnpmvSEvnBrCbcUC1yiQH0rulLfLcLYUJkShtVJBRGUG3CRZlvQDOI6O1Xz/M
         TrMKTDHwZwEsA/1IpGibz/2F7lzpq+1noLo8OWrLNR0Nw1xcqHL8P8EhhnhWaS+/MdcP
         O2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XPLkdTaS+cWviKWsyXZOkahcwDz4T4iRqzOYOjVp7Io=;
        b=jvKeT2dm/wfl1kqMDFvG4SWT9UcRcYpbeVJHre3BG/UfaFAJyPOkwl1fv0DB/Z2wLi
         koJApXjOcwVko3FI4XkFr5B2z9Bbjel2pSPatRuSKqJeaWs6J58wmuVNx0HwhqNlUO1l
         XYcEV1jSW2bND/Q9vRwqd/pSr/PHJn1bjdVyACk+3mvzT3q/qRe7OFjIAgVA+k4uaYrw
         vJi2cZsvRJGg06OAqYOHWnzE/at9CQK6lA/WPYykOavhHKsuLKAVUS0s/SVrERuK4ZY0
         ZgaWPq/now68mcc3ODLcYUTWbLihx6j5/E5enLe5el8eL2UX2zVla+3UV7zAsVKGWA1a
         gxMA==
X-Gm-Message-State: APjAAAVs026ZOO4NwIudzdoaASlOJZc6p3ab+Ux1JJyzcRQURBDO8izX
        +4sfj5kEXofBSkpBddp8PvYRYvOWQKw7TlHJXv/E5Q==
X-Google-Smtp-Source: APXvYqwuDxmO6gzEBlMckDuI4tFmeGOrN4ITnig+Q6JQUL8igiXxEEb0zy9iLW8xMBSNL4ZdAZ/FeIsmaj13+7TERTM=
X-Received: by 2002:a37:985:: with SMTP id 127mr26358532qkj.43.1567394633574;
 Sun, 01 Sep 2019 20:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009b3b80058af452ae@google.com> <0000000000000ec274059185a63e@google.com>
In-Reply-To: <0000000000000ec274059185a63e@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 1 Sep 2019 20:23:42 -0700
Message-ID: <CACT4Y+aT5z65OZE6_TQieU5zUYWDvDtAogC45f6ifLkshBK2iw@mail.gmail.com>
Subject: Re: kernel panic: stack is corrupted in __lock_acquire (4)
To:     syzbot <syzbot+83979935eb6304f8cd46@syzkaller.appspotmail.com>,
        bpf <bpf@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 1, 2019 at 3:48 PM syzbot
<syzbot+83979935eb6304f8cd46@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following crash on:
>
> HEAD commit:    38320f69 Merge branch 'Minor-cleanup-in-devlink'
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13d74356600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1bbf70b6300045af
> dashboard link: https://syzkaller.appspot.com/bug?extid=83979935eb6304f8cd46
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1008b232600000

Stack corruption + bpf maps in repro triggers some bells. +bpf mailing list.

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+83979935eb6304f8cd46@syzkaller.appspotmail.com
>
> Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in:
> __lock_acquire+0x36fa/0x4c30 kernel/locking/lockdep.c:3907
> CPU: 0 PID: 8662 Comm: syz-executor.4 Not tainted 5.3.0-rc6+ #153
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000000ec274059185a63e%40google.com.
