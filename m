Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47938F3019
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 14:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389374AbfKGNma (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 08:42:30 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:33319 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389191AbfKGNmK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:10 -0500
Received: by mail-io1-f70.google.com with SMTP id p19so1880384iog.0
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 05:42:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lYXHu1+8CxUYZrtgD2bXy/E8sjSme0LaouR97ajask0=;
        b=YYBpDcfONJUAPiT46emn6h/trc29SZyo6FY4gsck5hy7ggCvt+JLkVNefDrSPk3z1W
         FXMFaEXaiO0JgXfJNCBuE3tyDIustcxsF4swM+SZsuZ1Q0lcHs51kc/n3NGix33nRHHX
         JZion0duVIizCgPfRDvrNuwIjw9eQKjbR02rh6uQrFJRQlm0WJAun18u/pSFPz3qscNE
         ooRbwim5qZfgdIpSkxDUMtD61XQ7DvIWhcLDNYq5WqjkgnA1iwzWzhgFVn6fbngFXSnB
         EgnHGjACavTBv1Qn2iDgSVJUx+ehDzLuQ22NnAeYsudALZ/nMS11CysslwWcvgmFtG13
         YEAQ==
X-Gm-Message-State: APjAAAU6h8GgId6O8r08OiR+G8L2seSBJp/2bf5sMMy06HlATwibHs24
        Al6TjhRJHW5bODYi+vvrnuY1YfbpU1lXhpCpbJC6IWrAQUJS
X-Google-Smtp-Source: APXvYqyCn5PnsReBzzn0eMeMMCw+qkOz5YAQ4Lrcbdu5KR2Dy7fnX7Bn1RK2uLQWMUldMvI5RwDNhljITPEXD6xZrL9jqRFluc7a
MIME-Version: 1.0
X-Received: by 2002:a5d:9756:: with SMTP id c22mr3662214ioo.233.1573134128190;
 Thu, 07 Nov 2019 05:42:08 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:08 -0800
In-Reply-To: <000000000000f68d660570dcddd8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e51d450596c1d472@google.com>
Subject: Re: kernel BUG at net/ipv4/ip_output.c:LINE!
From:   syzbot <syzbot+90d5ec0c05e708f3b66d@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, dsahern@gmail.com, johannes.berg@intel.com,
        kafai@fb.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, posk@google.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        willemb@google.com, yhs@fb.com, yoshfuji@linux-ipv6.org
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14175486600000
start commit:   112cbae2 Merge branch 'linus' of git://git.kernel.org/pub/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=152cb8ccd35b1f70
dashboard link: https://syzkaller.appspot.com/bug?extid=90d5ec0c05e708f3b66d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153ed6e2400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1539038c400000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: bpf: in __bpf_redirect_no_mac pull mac only if present

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
