Return-Path: <bpf+bounces-5765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C9076015E
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 23:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F64828142B
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 21:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B09B11C99;
	Mon, 24 Jul 2023 21:41:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC83A11C86
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 21:41:40 +0000 (UTC)
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690501736
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 14:41:37 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1bb445ef8d7so3998640fac.3
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 14:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690234896; x=1690839696;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=di6kLt4kiOi9HIX9Zl3sHUse4426YeJyuKx98IZXml0=;
        b=NYRkFGYDo7cA4wcC5b3PjpzGhwV1l8CG6nUNjEOWn9otRsWjKEj+QGFwwubq2cZN7s
         qwA1kmW44522QO6aw4FFhI9e+rbBopvnYMhGBO4uW1gg/bprB0USRNn0rZHI7ZRmUIVN
         vDnTw7KoVKwqYh76mPdQyPDOiB25zdg8HhrwSDtiFU37uM0EqPzajWHWNhJTb4ruwYTy
         EYc1ttEZs1W+pD6DxJkzRRvIkCabdJlXBzxHI983UMoop0brILLL/ShHsHLgUuVgc6zh
         7Dm3DcA4SUk+GFmtNmcWa4pr6+vUjj+tW8uKQmGN4f5/ROf5objR1xgBxRG8i6gXuTUT
         GyIg==
X-Gm-Message-State: ABy/qLZfVzK75J25M/TalLEZ0mOgdbyhje7IGBAegfUNIfRCDhh7A1Pz
	SnaGZbu4D28iPMGP7wtS8C/W4TRpk73ApeFlcv8qPSnjWI7X9gM=
X-Google-Smtp-Source: APBJJlEHgKxbiRqzAo1p5ExJxSaFpMdx4xL8bTDt7lWT7iVoKpAvcWJPdTYgcDdzSeBNd2JY6Wg309G2oeLjLyHxKN+KQCnnhWMe
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c7af:b0:1bb:470c:901c with SMTP id
 dy47-20020a056870c7af00b001bb470c901cmr7990684oab.7.1690234896203; Mon, 24
 Jul 2023 14:41:36 -0700 (PDT)
Date: Mon, 24 Jul 2023 14:41:36 -0700
In-Reply-To: <ZL7fogwmV+JJcrVN@bombadil.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009347d50601427a92@google.com>
Subject: Re: [syzbot] [modules?] general protection fault in sys_finit_module
From: syzbot <syzbot+9e4e94a2689427009d35@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, chris@chrisdown.name, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, llvm@lists.linux.dev, mcgrof@kernel.org, 
	nathan@kernel.org, ndesaulniers@google.com, syzkaller-bugs@googlegroups.com, 
	trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9e4e94a2689427009d35@syzkaller.appspotmail.com

Tested on:

commit:         910e230d samples/hw_breakpoint: Fix kernel BUG 'invali..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=156bed06a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d182f762168e165e
dashboard link: https://syzkaller.appspot.com/bug?extid=9e4e94a2689427009d35
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

