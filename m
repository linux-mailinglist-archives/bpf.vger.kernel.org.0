Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907BB57E3D6
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 17:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbiGVPi2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 11:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiGVPi1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 11:38:27 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8218CEAB
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 08:38:25 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id u10-20020a6be30a000000b0067bcbb8a637so1903354ioc.3
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 08:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lMppGUEb50hZIYPAtBTOe3qW0mUd/jMUvfj5uTqx23M=;
        b=FZ3itqxcVZzIjjZtFPnkYWwrgQ4Rmc7uiSqaNQFwKRoNAqHO0k5/JNkKGQKxl/+FAv
         85LFpBkFROYbbdiLvMhBhqKcKRRLGAwP1QisMnJe1Hx4hNmMdlr+OFYcWULMPO/3H32F
         pWxJPqZsDP/Ko0xRj8HYlTyCfAqrvS8WbufSt2lCqMdS0OjfslmtyoVEGVj5hDr32xlu
         2Bt7TNUBwEesJcLb2Fl6TJv64xexCM9F/XSdQjRzbnlhR/W1BAZ9Yu2Us+LS0GlIU4Ne
         f7tW6bROi3cNIVNokRMLTqb9h4NENgyKJyxZPa7NPBauEN028e7NuBUt8MzGrUSgm3Rs
         zbzg==
X-Gm-Message-State: AJIora8SJSyGI/+UHENI8G++eNIBrFrPq8TNM8iDCIM+vvtg7CgPzBmX
        POcvUyWsr0qqEeYrq4Ah7dE8ANYglYBLMCClHWlk42NO4Jyc
X-Google-Smtp-Source: AGRyM1vHa1s1m+S9zIZfCosD7S3la9xNWKcVIxZzZeJRwvqQNLp9hrFyXXohQ34KCeuI2dmBot+eu8V5xXEvGSxuclgUwKdryj6B
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d13:b0:33f:5203:5ab7 with SMTP id
 q19-20020a0566380d1300b0033f52035ab7mr318471jaj.72.1658504305278; Fri, 22 Jul
 2022 08:38:25 -0700 (PDT)
Date:   Fri, 22 Jul 2022 08:38:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9821705e4669f6b@google.com>
Subject: [syzbot] bpf-next build error (4)
From:   syzbot <syzbot+ea8ff4e064cd21861ec7@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
        haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev,
        netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com,
        song@kernel.org, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ac7ac432a67e Merge branch 'New nf_conntrack kfuncs for ins..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=164443d6080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=386b986585586629
dashboard link: https://syzkaller.appspot.com/bug?extid=ea8ff4e064cd21861ec7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea8ff4e064cd21861ec7@syzkaller.appspotmail.com

net/bpf/test_run.c:703:40: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
net/bpf/test_run.c:704:40: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
net/bpf/test_run.c:703:1: error: unknown type name 'BTF_ID_FLAGS'
net/bpf/test_run.c:705:40: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
net/bpf/test_run.c:705:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'BTF_ID_FLAGS'
net/bpf/test_run.c:712:48: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
net/bpf/test_run.c:705:1: error: unknown type name 'BTF_ID_FLAGS'
net/bpf/test_run.c:713:45: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
net/bpf/test_run.c:714:45: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
net/bpf/test_run.c:715:45: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
net/bpf/test_run.c:716:45: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
net/bpf/test_run.c:717:45: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
net/bpf/test_run.c:718:53: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
net/bpf/test_run.c:719:53: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given
net/bpf/test_run.c:720:53: error: macro "BTF_ID_FLAGS" requires 3 arguments, but only 2 given

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
