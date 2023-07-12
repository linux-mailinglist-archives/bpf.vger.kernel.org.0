Return-Path: <bpf+bounces-4869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7940C7510CC
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 20:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34214281A33
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 18:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F69920FBD;
	Wed, 12 Jul 2023 18:54:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8C620FB8
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 18:54:35 +0000 (UTC)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3E21BFA
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 11:54:34 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6b86d2075f0so8425328a34.0
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 11:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689188073; x=1691780073;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZMH+f/qQs35ft7PcSxeJWZ8yv3i3Olk8Bn6x6Aux/0=;
        b=iGSta4XHyNw7oiebyZYL+t3ynCPEHtw0b8ZcLevXDeowSBKKypMSzG5+JUFVqJHHC/
         eAm9y0+gyp6xdPwNxlzj/t+3L0oLqpBqj4UgHYJpuwnP/Toh0k0tGFJexHsKMEEySmDx
         QwENSOIsOkNpFPGTpDjkRvuEWGeEcC4IkFgBYzrApDLz/q3jYNyr9MwfbhU6JATcPX+E
         zUm5nSgmKplBgt1mLs3FZfA+3Ra9SmdsQhgHunW1EBiiyb24DvvX77QGvxKf3DdeJeVg
         lsNwMWhjPCF3xYv4Pf1lbTdzPepx18+Nx+ThWIzAttOXoYzx56FWDAjzmsfDHz5+hn69
         sc5Q==
X-Gm-Message-State: ABy/qLbpf3t7k7JIFGNyUNdrT755wcC610gTjZbmatKPyThvukefUzx5
	u4GYBm05NQRDqyH/IJARUuT/F4ASbstpY+f1auqfITY+62+p0Pw=
X-Google-Smtp-Source: APBJJlFsJIcb0rdx4JjgRS1wq5NhoTjU9MPmFzmv1EP3Vle1AIKr62xgl7dheKEiVE6GkXdOnIQBkcJkfp2R0puLgy6N5pzwWkeT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:2056:b0:6af:a3de:5d26 with SMTP id
 f22-20020a056830205600b006afa3de5d26mr6113119otp.7.1689188073476; Wed, 12 Jul
 2023 11:54:33 -0700 (PDT)
Date: Wed, 12 Jul 2023 11:54:33 -0700
In-Reply-To: <000000000000881d0606004541d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001416bb06004ebf53@google.com>
Subject: Re: [syzbot] [fs?] INFO: task hung in pipe_release (4)
From: syzbot <syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net, 
	dhowells@redhat.com, dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot has bisected this issue to:

commit 7ac7c987850c3ec617c778f7bd871804dc1c648d
Author: David Howells <dhowells@redhat.com>
Date:   Mon May 22 12:11:22 2023 +0000

    udp: Convert udp_sendpage() to use MSG_SPLICE_PAGES

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15853bcaa80000
start commit:   3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17853bcaa80000
console output: https://syzkaller.appspot.com/x/log.txt?x=13853bcaa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=150188feee7071a7
dashboard link: https://syzkaller.appspot.com/bug?extid=f527b971b4bdc8e79f9e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a86682a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1520ab6ca80000

Reported-by: syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com
Fixes: 7ac7c987850c ("udp: Convert udp_sendpage() to use MSG_SPLICE_PAGES")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

