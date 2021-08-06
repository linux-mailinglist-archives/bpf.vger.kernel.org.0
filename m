Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6AD3E31A4
	for <lists+bpf@lfdr.de>; Sat,  7 Aug 2021 00:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245503AbhHFWUX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 6 Aug 2021 18:20:23 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:40828 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239089AbhHFWUX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Aug 2021 18:20:23 -0400
Received: by mail-io1-f70.google.com with SMTP id d70-20020a6bb4490000b029057da994a827so7049678iof.7
        for <bpf@vger.kernel.org>; Fri, 06 Aug 2021 15:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=TjZwUUDBCQTtiiphMf5lNNvkaUWGIfnKKUGZRCHod4s=;
        b=Wic/XVpo0FYmmgPGOoXc+O8D0nhXeD1JNeCHhqUirNZ6802ZommCKJUbtfFb2EFFW/
         Xzi9unIja2dZHAYfWU4qLkHUfQNnAEuXrNX5MCUtccXjozy9XTmSV46PwpkIhP89IRlZ
         l0OPd2CJElIChXqSfOrq6PAdy6PY83WK1oST9RkVGjG2KNJFu8oIr2nXySK6RUrPmyzL
         hAKFycH0AcA7UZi6kCHgFcqrUjmQP+lc9yXe19LMY5//jiw5kqH4qEoaj8TiJsPZ7tCQ
         U+Wpga4dK6lfsRH6NwX41tjuiPdxEHtNCGXN5vnZMflyIX3QafLIvxWiavYT8ufreX0m
         9tLA==
X-Gm-Message-State: AOAM530YEpe4W8DaXspD1SIWM1QKAED9RD9pYNnuklIK3qwHeOJBI2j6
        ueqv3RS9pF8VhUTCwby3NViNK4OrjQat1BXdUG2nrkYOmS70
X-Google-Smtp-Source: ABdhPJzpIVDaCuynJVK3t71sYw7TX40yeX/4nyImc7KlRSQjfeTEFmrDpDfvonESvtNNCm06n335BFZZQFgOc40sQxqK3J4I4gE0
MIME-Version: 1.0
X-Received: by 2002:a92:c266:: with SMTP id h6mr517881ild.273.1628288406528;
 Fri, 06 Aug 2021 15:20:06 -0700 (PDT)
Date:   Fri, 06 Aug 2021 15:20:06 -0700
In-Reply-To: <000000000000b8a3e905c69535e3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000102b9305c8eb70da@google.com>
Subject: Re: [syzbot] kernel BUG in __tlb_remove_page_size
From:   syzbot <syzbot+2f816ba9b71ca9a8e6b0@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andrii@kernel.org,
        aneesh.kumar@linux.ibm.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com, kafai@fb.com,
        kpsingh@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, npiggin@gmail.com, peterz@infradead.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        toke@redhat.com, will@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit af0efa050caa66e8f304c42c94c76cb6c480cb7e
Author: Toke Høiland-Jørgensen <toke@redhat.com>
Date:   Tue Jul 6 12:23:55 2021 +0000

    libbpf: Restore errno return for functions that were already returning it

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13b872fa300000
start commit:   3dbdb38e2869 Merge branch 'for-5.14' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1fcf15a09815757
dashboard link: https://syzkaller.appspot.com/bug?extid=2f816ba9b71ca9a8e6b0
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151ee572300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: libbpf: Restore errno return for functions that were already returning it

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
