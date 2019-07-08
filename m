Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC4262B4E
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2019 00:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404806AbfGHWDC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jul 2019 18:03:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:39027 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405429AbfGHWDC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jul 2019 18:03:02 -0400
Received: by mail-io1-f69.google.com with SMTP id y13so20563839iol.6
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2019 15:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=z6cwq6PdOuRGao2HTmJRcdKeNfyuLdRgf/WtADemwus=;
        b=cxxZeBUT8jEkDtH827re64KUdmfEIqL8MreBt0mvmTg4Yuu70tSpuEFBZBdoIB3ytA
         FGlyNJsa/nf4K+4Hli3rYg/DeO1OV3Q/xo6jaJlJ15KZ8hQdOzDTbr+BG9jELMBnKOzY
         0xk+UL9chVBsJahgLpihEJqrjdFx8rCDDo5jG//lr7sodCSI+N1eXtyV3RLxH648eB+s
         rIjazGu2mA445BvPJYICNU+3pQzGJMIfADZc/J8NzSZ5yHBSK5nrIfV1yDuGs1Kw94vq
         vno1/25nH3kQCSJqrgX6Hli558xNy5cpXPkyq8HTpUKrZFlNREEGiPqd8NLPzNoy1CV2
         NA0Q==
X-Gm-Message-State: APjAAAUmAlvZLnOQsYS2+MZWRz6WsQ/kv4NvbSzRkX3XSmIyvZwiqh2W
        +k4LIvFBek5sE7ecjCWbeZF24srhaepRODABBdYGvHPY0Rxp
X-Google-Smtp-Source: APXvYqy4sReXWU5IIbQAJc6iyOim2vvJNjJ/YlULz5+YklC4nQ+DcwMW68/p8jMVJRSzZru+nJffT8mahNqxZKHIrjoxXFVte2t5
MIME-Version: 1.0
X-Received: by 2002:a05:6602:c7:: with SMTP id z7mr2108074ioe.130.1562623381127;
 Mon, 08 Jul 2019 15:03:01 -0700 (PDT)
Date:   Mon, 08 Jul 2019 15:03:01 -0700
In-Reply-To: <5d236d7dc1db6_75f52af7c83505bcc3@john-XPS-13-9370.notmuch>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ccb1a058d329b72@google.com>
Subject: Re: WARNING in mark_lock
From:   syzbot <syzbot+a861f52659ae2596492b@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, ebiggers@kernel.org, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+a861f52659ae2596492b@syzkaller.appspotmail.com

Tested on:

commit:         17b3f125 tls: working code
git tree:       git://github.com/cilium/linux fix-unhash
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd16b8dc9d0d210c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
