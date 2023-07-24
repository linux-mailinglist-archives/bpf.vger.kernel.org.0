Return-Path: <bpf+bounces-5746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DF575FFFC
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 21:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67B21C20C48
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 19:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3081107A7;
	Mon, 24 Jul 2023 19:47:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAC010788
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 19:47:37 +0000 (UTC)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DC4173E
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 12:47:35 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a5aa4a8fd6so4358857b6e.1
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 12:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690228054; x=1690832854;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TpU/pq4NcXq5eoCMak+87h/qMFbXrT3YYZv+5M6Z810=;
        b=L6Bs33gidE92gCLG2Zd4Zr395bbuWFzu5iIcvtLC2CqLYEBbJP3kg6gwuxr9kaGfdy
         581ZMMwzn6+lq3FNS0hraU9wxP/wyUm48461v1rkfHoYONdgFIuQmnLsf3jDzjhbW7aC
         HgBLEAKggrM6+S86ZgO0Fo9GriGcLW6F9RIAvAPsyazWluwqlyNV4oVqfrh74YMa7eAB
         MJgcjwGBtGRGLvJ3UchAoFWBpbyFTpwusd9kne0scfhBQVvuxr8N7ZuXNGs8CC7Yoysr
         TFKbaWd8diL70c6hubswL3gvyK+pzhDo49Q3IWHCAHD2w55dla2KjuuTIBY0EX8jyghN
         2D4g==
X-Gm-Message-State: ABy/qLZq7bQI+eTzgZSdPyAKeJdA+Ain6L7waIbEJjoVvIxwcHQVb8Xx
	J0ginoZZFstEzyQg3pJH5A5ZK0228jPhJZIclz2y1KOpvmqTM9I=
X-Google-Smtp-Source: APBJJlFhOkXgA1GDXy6ZXZyeXWFwikYSsd/PZ9QEgWnWucvf96IBK7XT0JXjTa9x+AGx3ADzu3aYiG7whxxn3I6COqeIsSFrzEVO
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1211:b0:38d:ca0a:8e18 with SMTP id
 a17-20020a056808121100b0038dca0a8e18mr20908707oil.2.1690228054801; Mon, 24
 Jul 2023 12:47:34 -0700 (PDT)
Date: Mon, 24 Jul 2023 12:47:34 -0700
In-Reply-To: <ZL7UedKQUDAUThHM@bombadil.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cbc360060140e291@google.com>
Subject: Re: [syzbot] [modules?] WARNING in init_module_from_file
From: syzbot <syzbot+9c2bdc9d24e4a7abe741@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, chris@chrisdown.name, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, llvm@lists.linux.dev, mcgrof@kernel.org, 
	nathan@kernel.org, ndesaulniers@google.com, syzkaller-bugs@googlegroups.com, 
	trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git on commit 910e230d5f1bb72c54532e94fbb1705095c7bab6: failed to run ["git" "checkout" "910e230d5f1bb72c54532e94fbb1705095c7bab6"]: exit status 128
fatal: reference is not a tree: 910e230d5f1bb72c54532e94fbb1705095c7bab6



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 910e230d5f1bb72c54532e94fbb1705095c7bab6
dashboard link: https://syzkaller.appspot.com/bug?extid=9c2bdc9d24e4a7abe741
compiler:       
userspace arch: arm64

Note: no patches were applied.

