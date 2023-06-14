Return-Path: <bpf+bounces-2564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A08E72F0E6
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 02:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E38A28129E
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 00:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139AB37C;
	Wed, 14 Jun 2023 00:20:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C70191
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 00:20:26 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622C3CE
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 17:20:25 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3406661e649so13661365ab.1
        for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 17:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686702024; x=1689294024;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPZJuew65UVR5FFQsxCbQqGDSX7P8C2GTOs6C/LbA5k=;
        b=dFfjvRw6n3bQIyfZqO451J2H5WB830ZJkhuQSctZwt2YIwUbg4v/uFavtIYlfELAgH
         0p50x8/DqAQ6nRCyFlIGeYi3S4xBVMOMME3fbP81xGDnuwmGgDufp8vde1Q+fut3Y/6+
         rkHWHheggIpsBWQOCk5xVCgaft3TE2WpEIrBokBMcpvkAGfyzzRUBytvPR7vwbK7IP5D
         1u2+MEMit3mg12D7JhMIrqGFu19hNaHJ1PV+mNzQKpcwx+33BgsqX2qn2Ucwgy//Whv7
         tXnnmoUVHRvDyZujwXwub62Gmmn831YdvSt0huyil+Cb87GrfCdlw5TcRjvUtFxigr1Y
         OS/w==
X-Gm-Message-State: AC+VfDzymtuQw3rZzp7pDy+ky/0QNxq/CS5G8ZvwsFThghbWVnBmXLax
	mUXsbnmYuyeOgtTJG/1+psoHighoCb9fgrOg/CjBuyd7cMpooVo=
X-Google-Smtp-Source: ACHHUZ5vfao69TzkXMKSqLdZVZkQjhmYJLPV9X2girde6yyBqzjp7nQ2/UjzqGlW9LrxZhB3uLFSTTG2d/SigJlwdS0tZP7hRA/U
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c98f:0:b0:33b:1445:e9cc with SMTP id
 y15-20020a92c98f000000b0033b1445e9ccmr6377594iln.1.1686702024743; Tue, 13 Jun
 2023 17:20:24 -0700 (PDT)
Date: Tue, 13 Jun 2023 17:20:24 -0700
In-Reply-To: <1394611.1686700788@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006e58b05fe0beb6c@google.com>
Subject: Re: [syzbot] [net?] KASAN: stack-out-of-bounds Read in skb_splice_from_iter
From: syzbot <syzbot+d8486855ef44506fd675@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, davem@davemloft.net, dhowells@redhat.com, 
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d8486855ef44506fd675@syzkaller.appspotmail.com

Tested on:

commit:         a9c47697 Merge branch 'tools-ynl-gen-improvements-for-..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=145cfc8b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=526f919910d4a671
dashboard link: https://syzkaller.appspot.com/bug?extid=d8486855ef44506fd675
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14ed8d2d280000

Note: testing is done by a robot and is best-effort only.

