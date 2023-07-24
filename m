Return-Path: <bpf+bounces-5747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1D676001F
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 21:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E1C1C20BA9
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 19:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F292A10945;
	Mon, 24 Jul 2023 19:56:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39D2101F7
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 19:56:35 +0000 (UTC)
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299B510F8
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 12:56:34 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b9cf208fb5so9264127a34.3
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 12:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690228593; x=1690833393;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0HbIfON9h7OtlOqGplVgAJ/Ron1dfOFrue7VmqDYzg=;
        b=gAcnle+RRbmV+mqRncOqXS3w7Z9rgnZt1S8E0I87EH3VEYbhN2h4PTcaYZKdkaA9dD
         iaZnAGxVEC7QQtDcCWalR2S+4Lgu3GTyMfsKX+SkzActO/A97ulrU7qJqXCWTgU9SBA0
         GBfdseLaeujS4vup74tDgKRVbgYh76yOHmdEgRZD6/dlVZt0ohzQDIO9mEzUJwWCRxy8
         goB4a7FNo9GVYmkwTRAC+B8QVytTWt49e2BFtihyJFqimlo5eFN1FLdqgIAEbaPHHcab
         gacsi2cozD/Z5G3rjL825v32KiR6N8SnXed23CHmiQvKTXcqp+zEPapEDyyVWFgOj7GS
         9CCQ==
X-Gm-Message-State: ABy/qLZOGoFcgTQIe+DEtJ/PCf1S7jvRjG2Nex5pNpb2LCJbMabPn9ZH
	am7KLAvufUdlxd+P8FLegcbgZbjquuZupIifzxg7xIRQqgglo4o=
X-Google-Smtp-Source: APBJJlGy8FHZDVrssAfEDgGHScfjKPZjYZWznrOxt65Wocsqqyr5rTphmuoPNIEOMBE7bKR1W0V4AWAMQMX5N468FTXqgMvgSHHN
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:955e:b0:1bb:51ab:a7bc with SMTP id
 v30-20020a056870955e00b001bb51aba7bcmr7056676oal.1.1690228593534; Mon, 24 Jul
 2023 12:56:33 -0700 (PDT)
Date: Mon, 24 Jul 2023 12:56:33 -0700
In-Reply-To: <ZL7Una9vhJpX+dkb@bombadil.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e82d5806014102a7@google.com>
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

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git on commit 910e230d5f1bb72c54532e94fbb1705095c7bab6: failed to run ["git" "checkout" "910e230d5f1bb72c54532e94fbb1705095c7bab6"]: exit status 128
fatal: reference is not a tree: 910e230d5f1bb72c54532e94fbb1705095c7bab6



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 910e230d5f1bb72c54532e94fbb1705095c7bab6
dashboard link: https://syzkaller.appspot.com/bug?extid=e3705186451a87fd93b8
compiler:       

Note: no patches were applied.

