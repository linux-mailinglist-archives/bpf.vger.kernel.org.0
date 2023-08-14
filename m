Return-Path: <bpf+bounces-7709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD7077B83B
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 14:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65ED1C20A95
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 12:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA45CBE48;
	Mon, 14 Aug 2023 12:08:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D9323D0
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 12:08:38 +0000 (UTC)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C1D1718
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 05:08:27 -0700 (PDT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1bbdced15f3so85050585ad.2
        for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 05:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692014907; x=1692619707;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJNRfP8cUatIsJc6YU7EUPAo/O9QZ6sb5iejP2DNk7g=;
        b=dcyvFkO/XkjFhjd+nUjuzmkbFjRVgE6zIN4Tuy5Vf23Tv2w1IPhv1klRlE03YYMSWF
         uJG2k4lX1YXssPIWRsfxVpW76iNUnnuZ32nejthiAvcKcHMw8I4iwJg+7b3G5n5034eu
         j6H9F3a9rxko1Sy8tZAVTXc5sTACt2MzK/fXcdeZUnYfLNlg9Iu6z3wfmwjEIiykgPme
         niRpR694jfOthLqMbWGFp2SgHc4N8pFxyCXpOU2eywCD1FHmJhZRdMXliV/QV8MTq8BO
         4tAZEbY7W7YoVQHt4vWGcBsgdYpmpWJXajO6Gh2BhxVWFHzVIkzgyS2qCDqH7uh6CTCC
         9Uhg==
X-Gm-Message-State: AOJu0YzNprCDjU58yBtSNYe99sOmdrIDTqmpjxUg841eAFZOSzJvJVNG
	d7J9QrEeJ8x6sB2HzJP7JX2ptQuxcgEgNRobK0oy/ZzfKRFEapc=
X-Google-Smtp-Source: AGHT+IGfcIkUiHrqX6S1IiQDnpfA7pI0z5lomwAUYnqquL64y/gfrx5YhhnnQ+4btgQR6c0hoTwQIEUozbHJHcQ6cTPptARUW4Gu
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:902:c94b:b0:1b8:97ed:a437 with SMTP id
 i11-20020a170902c94b00b001b897eda437mr4164664pla.4.1692014907452; Mon, 14 Aug
 2023 05:08:27 -0700 (PDT)
Date: Mon, 14 Aug 2023 05:08:27 -0700
In-Reply-To: <0000000000000e4cc105ff68937b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083735b0602e0eb7d@google.com>
Subject: Re: [syzbot] [modules?] KASAN: invalid-access Read in init_module_from_file
From: syzbot <syzbot+e3705186451a87fd93b8@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, chris@chrisdown.name, linan122@huawei.com, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	llvm@lists.linux.dev, mcgrof@kernel.org, nathan@kernel.org, 
	ndesaulniers@google.com, nogikh@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org, 
	trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17c80763a80000
start commit:   995b406c7e97 Merge tag 'csky-for-linus-6.5' of https://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f27fb02fc20d955
dashboard link: https://syzkaller.appspot.com/bug?extid=e3705186451a87fd93b8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12219fbf280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1278c8a4a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: module: fix init_module_from_file() error handling

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

