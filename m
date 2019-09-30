Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1C3CC1F8E
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2019 12:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbfI3KxC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Sep 2019 06:53:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:44152 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbfI3KxB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Sep 2019 06:53:01 -0400
Received: by mail-io1-f70.google.com with SMTP id k13so21034681ioc.11
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2019 03:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hI5UiabcxF02JCdIXhKz7T8NGcvRDQ9zry7wX/9b2Wg=;
        b=XYuF8ahIzlQF+njuBGKEoCxrOQ1VqnE+zm6AxnmK4F5tECDovMDid6vdtTTbuHhTqC
         /e037HeVlfnt60tRN7v4F+3K61jL2pro3m9I6e44q+zVLwAhQeHME2bUZU0OIU8UgBWr
         3sNVntEONm+QIshcRu408azdWXeig/QjyAJ+gBlwvd652J1blVu+VK0awImibV+02Nnd
         7rBOEcQm3W+T3DQGrd96V5CGlh1kTvOcoa5q6P0cj2iYayG5k3w5i9uXK71qCDjYcTIo
         w1eaKpz2jwD5Po0Lk+iK0TW5xnEgmhHPIOrVHKU0KF+TLnSuVoKZJuGBbEp+4rl4U/6Q
         D7bQ==
X-Gm-Message-State: APjAAAWTHg0YwlmtTztgmckCfniiKZa8jfz1wSBYCmeI6YEh+oFiCHZ7
        cOgRfMDSShNECFdebyxoXoD2+dv5dVtFgfzFo9OFZKSQbVUE
X-Google-Smtp-Source: APXvYqxRYokbmnvyKs8m43W2eYhxiwwUbwWy13gugzMDjSun9tKIic+MOKtsA0/QDSj4eyEqMzAj3mnJOFEjdYOCIauwyEoJD8+B
MIME-Version: 1.0
X-Received: by 2002:a92:c0d2:: with SMTP id t18mr20022479ilf.239.1569840781088;
 Mon, 30 Sep 2019 03:53:01 -0700 (PDT)
Date:   Mon, 30 Sep 2019 03:53:01 -0700
In-Reply-To: <00000000000084fb070593bff0fb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c5e810593c30a8c@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in xsk_poll
From:   syzbot <syzbot+a5765ed8cdb1cca4d249@syzkaller.appspotmail.com>
To:     ast@kernel.org, bjorn.topel@intel.com, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        jakub.kicinski@netronome.com, john.fastabend@gmail.com,
        jonathan.lemon@gmail.com, kafai@fb.com,
        linux-kernel@vger.kernel.org, magnus.karlsson@gmail.com,
        magnus.karlsson@intel.com, maximmi@mellanox.com,
        netdev@vger.kernel.org, saeedm@mellanox.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tariqt@mellanox.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this bug to:

commit 77cd0d7b3f257fd0e3096b4fdcff1a7d38e99e10
Author: Magnus Karlsson <magnus.karlsson@intel.com>
Date:   Wed Aug 14 07:27:17 2019 +0000

     xsk: add support for need_wakeup flag in AF_XDP rings

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17848acd600000
start commit:   a3c0e7b1 Merge tag 'libnvdimm-fixes-5.4-rc1' of git://git...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14448acd600000
console output: https://syzkaller.appspot.com/x/log.txt?x=10448acd600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ffbfa7e4a36190f
dashboard link: https://syzkaller.appspot.com/bug?extid=a5765ed8cdb1cca4d249
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1096d835600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129f15f3600000

Reported-by: syzbot+a5765ed8cdb1cca4d249@syzkaller.appspotmail.com
Fixes: 77cd0d7b3f25 ("xsk: add support for need_wakeup flag in AF_XDP  
rings")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
