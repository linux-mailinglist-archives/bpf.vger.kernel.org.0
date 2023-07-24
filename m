Return-Path: <bpf+bounces-5763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DD1760105
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 23:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D808A1C20C68
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 21:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA52A1097E;
	Mon, 24 Jul 2023 21:18:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46FFDDC8
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 21:18:26 +0000 (UTC)
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABACA171F
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 14:18:23 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b9efedaeebso9377099a34.2
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 14:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690233503; x=1690838303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fISgzzCd91Gj2U/gkz81qNRRRlc1K+b9y/Uqzybe3fQ=;
        b=a367F84Jsw3s6y/aZ6gDnJYZHBXux91yI9M01bUNsfiNiiwyfMA/qAru62nJCp+qPx
         UGyr97aHIMctFuHQRN0D9EeXz4Q4MxmRfrQqfCDcZLLIpIXoQ0q5XtSMS20hw+5ik45B
         pmWNsJUARkTwgfxu3t47kBo2v6YHsXONPthuK2NJZLur9e/cN61F6gU2oq+JZZvwUs0A
         jQ8p/H5nEbrA72fCpqQNk2d5IFs7juJbP1I5QwRKAzvsF4g7WqvW7o/0C4Ak+Dj2K8KI
         rAgUe7c4w0CWRVXkQFa9vS5Eg7wLNe8VzoUn+0vqTbBADV/8BmDDfckVaC0Ol9SeytaM
         ttKw==
X-Gm-Message-State: ABy/qLYMXjYfoot31XyjFCuSK8HBPuYAaROqoHYABLg6ARlYPqiBbQrs
	rN7mtrUbO0W+SfaImu/5EPPr7FFeS8/8NtBKrclvwMJemglNx/U=
X-Google-Smtp-Source: APBJJlHk6oTqxAMI0w9v9Q+HPlsKWKA/HtbUSkECk0SsualRSe5kQSUlByEONDF4yteCaaof/kh7pLqOuhIdzPmNrCyk5HqO1DGU
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a9d:7488:0:b0:6b9:f343:acfd with SMTP id
 t8-20020a9d7488000000b006b9f343acfdmr9566732otk.5.1690233503160; Mon, 24 Jul
 2023 14:18:23 -0700 (PDT)
Date: Mon, 24 Jul 2023 14:18:23 -0700
In-Reply-To: <ZL7fllo9Td1gJmHo@bombadil.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b1f3e06014227e6@google.com>
Subject: Re: [syzbot] [modules?] KASAN: invalid-access Read in init_module_from_file
From: syzbot <syzbot+e3705186451a87fd93b8@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+e3705186451a87fd93b8@syzkaller.appspotmail.com

Tested on:

commit:         910e230d samples/hw_breakpoint: Fix kernel BUG 'invali..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11e83081a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=34364e75687fa9c3
dashboard link: https://syzkaller.appspot.com/bug?extid=e3705186451a87fd93b8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

