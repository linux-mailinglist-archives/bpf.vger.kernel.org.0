Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9029757B44
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2019 07:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfF0FYB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jun 2019 01:24:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:39291 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF0FYB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jun 2019 01:24:01 -0400
Received: by mail-io1-f71.google.com with SMTP id y13so1283746iol.6
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2019 22:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=KTLmlahqBmrHOIj7RbeMjFFVBD1WODkDi1wf0mxjsj4=;
        b=X8UlsMjEQ2IXjh90PsyeEch98TV2QAe/9DWuIElRGskg8d8RStzlkAD71rGELTyOwh
         a4PFkebn5AD77t4NCZCcSPQZpQp1PCFOoGJHqoPp+bhsoFEgu5YUayyCd3ekCOsEnwYi
         Jp5VHhkrfLu9gUyUMjGjqe1JUopDZouCpgzTYXafTt1fWo8Clu/0eqthsCCXLH52h35Y
         r/l/y1tsrjrGMtCiCyi/GOl6+CizOQNXkvWXo+LK0ItDjgR/mxQXsO59OloVOLJYnWGR
         wPT0LxrmWG/9MMhwu9tLr+59u/wt7tFg8tydPchhDG49Z0HP3/rQg0cIvIm7Vee0vrqI
         B8aQ==
X-Gm-Message-State: APjAAAU/XfQgZHHfIMMO+vmjq7ZIU/DT9jXWU+k4n9ns5WiCgc/FEgOk
        i8qTHdLA8U34pnMU0btBNOqVc90+pDy3AUcc0ynJUtMlKD9D
X-Google-Smtp-Source: APXvYqwLxdaO1aqZn3NAO+28gDuNAkuDRNZ+nL2ivt8eHB6WZ7wyMTxoDYSySR2w00lCL6SEaEgSn6JyDAFAnddEBIqaHiFZN5Vh
MIME-Version: 1.0
X-Received: by 2002:a02:7121:: with SMTP id n33mr2217019jac.19.1561613040861;
 Wed, 26 Jun 2019 22:24:00 -0700 (PDT)
Date:   Wed, 26 Jun 2019 22:24:00 -0700
In-Reply-To: <000000000000d7bcbb058c3758a1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093c88d058c475e46@google.com>
Subject: Re: BUG: unable to handle kernel paging request in tls_prots
From:   syzbot <syzbot+4207c7f3a443366d8aa2@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, edumazet@google.com, john.fastabend@gmail.com,
        kafai@fb.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this bug to:

commit e9db4ef6bf4ca9894bb324c76e01b8f1a16b2650
Author: John Fastabend <john.fastabend@gmail.com>
Date:   Sat Jun 30 13:17:47 2018 +0000

     bpf: sockhash fix omitted bucket lock in sock_close

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=148e8665a00000
start commit:   904d88d7 qmi_wwan: Fix out-of-bounds read
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=168e8665a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=128e8665a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=137ec2016ea3870d
dashboard link: https://syzkaller.appspot.com/bug?extid=4207c7f3a443366d8aa2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15576c71a00000

Reported-by: syzbot+4207c7f3a443366d8aa2@syzkaller.appspotmail.com
Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
