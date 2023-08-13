Return-Path: <bpf+bounces-7675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD7877A690
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 15:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A49280F1B
	for <lists+bpf@lfdr.de>; Sun, 13 Aug 2023 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BF56FA3;
	Sun, 13 Aug 2023 13:38:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BEC2C9D
	for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 13:38:31 +0000 (UTC)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2291718
	for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 06:38:30 -0700 (PDT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-686db2bb3eeso4387862b3a.2
        for <bpf@vger.kernel.org>; Sun, 13 Aug 2023 06:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691933909; x=1692538709;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=neJnpZX6yQ9QkvvT9QAkP8Ws3ecBujJ1QULkPMiV29E=;
        b=RY7yf8UEGDOVSFqErFfbSs16Xhx9iAD8irih3r57Tn3MzRv2qOZBaZlJBoMVE5d4DG
         MA4lLLoDVDpcgExfcSYkHhkg78BzZcKSyA9HVCG07aZ0+8J/CbjFzEbk7AY5TKkOOiKN
         4aoVe+g0G6wI6rfjTa+hawEVSfX3VZXQpy7VwSGuOCEOSp+kTXOf3bEX5ic5RM41Fk68
         /W6qxyA9TP2xLFlmaifo/wMJzGLJwjrLAm35SyD19oCJ8/CnG1iNIgxNQVAhadu5LJdY
         lTyCT9kiCOZAr//JZ7DSokcGrC5OGDnWvLbr85yFsGNuMg+SrgwmxWO20hzDPp6ubKOX
         lwBA==
X-Gm-Message-State: AOJu0YxIel2Yp2ziyf22t83CGEvJkc0OlJPLSXiYH4wu49o4qAJKZTDE
	H2PLiSLPfLmPW5vBsqHK82VSjCPHI4ivKY4fTrJZhIhrbEdhMuE=
X-Google-Smtp-Source: AGHT+IFvUtqXr76zu2wT3itQvPjtzRoxdBW7cC6qINSUywu2YLhPJ1DCvGf+u/vcRaSITgKK9wNgpHfjYiUe7vo70HM9pGod+tZJ
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:d4c4:b0:1bb:a78c:7a3e with SMTP id
 o4-20020a170902d4c400b001bba78c7a3emr2668812plg.3.1691933909651; Sun, 13 Aug
 2023 06:38:29 -0700 (PDT)
Date: Sun, 13 Aug 2023 06:38:29 -0700
In-Reply-To: <00000000000094ac8b05ffae2bf2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab16cf0602ce0f9d@google.com>
Subject: Re: [syzbot] [modules?] general protection fault in sys_finit_module
From: syzbot <syzbot+9e4e94a2689427009d35@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, chris@chrisdown.name, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, llvm@lists.linux.dev, mcgrof@kernel.org, 
	nathan@kernel.org, ndesaulniers@google.com, syzkaller-bugs@googlegroups.com, 
	torvalds@linux-foundation.org, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot suspects this issue was fixed by commit:

commit f1962207150c8b602e980616f04b37ea4e64bb9f
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Jul 4 13:37:32 2023 +0000

    module: fix init_module_from_file() error handling

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=148a0a03a80000
start commit:   995b406c7e97 Merge tag 'csky-for-linus-6.5' of https://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=71a52faf60231bc7
dashboard link: https://syzkaller.appspot.com/bug?extid=9e4e94a2689427009d35
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d6670ca80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103be50b280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: module: fix init_module_from_file() error handling

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

