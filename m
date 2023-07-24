Return-Path: <bpf+bounces-5748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2AB760021
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 21:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67FDE281416
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 19:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414611094E;
	Mon, 24 Jul 2023 19:56:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABAA101F7
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 19:56:35 +0000 (UTC)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6A7171E
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 12:56:34 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6b9c744df27so7447393a34.2
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 12:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690228593; x=1690833393;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bqy++k90y41wMJfzlow3b+lCJ8ynuiD7DIqIylcfRDo=;
        b=JgoydNUEWYAo+vtvXbUuos4QMB5S85hUksPbvdEK4sbga+Tv16hlZZKpl2/nToj9cu
         o0362pFCv3IxiEffvjU8rzfBGUUwM46BJjP4uP8S89P2CMyvHw9kOk/Iyxgj6fBb6iD9
         lWZXtIm+CwwLMNlMVM1otK/3f8yie3TX2ZB5zNvpqP3BH3sQlwwyE4cTEBytpwnu/NH5
         0bVj+I0gaE8VHQlXbhSubTNW+qFm2kaBgcFMDyhupYeVASqdnj3nn3aBQSTPanHQPcX0
         d29AzTOWBtDZmhCrHbd3Oy9zZemkklLhbgMe+JIVEH7SY40RaBteZ8QYzJKm1dqRPsO3
         OHxw==
X-Gm-Message-State: ABy/qLZBCgR863V0+ZbQqBzhvRoJB0E3yJl1J4bi3ctIAp34ZLeiBUTG
	5mK4ZC7DwfoG8o63FyrMaCZrvnLNtYjxtAcSf0KyDz9auACFrS0=
X-Google-Smtp-Source: APBJJlHlWs+LFB7k3NIuMhWUm8QZfovlY8FvMe8cw31aYRNPGdP4kGfjP2cedYFiR+mvcbKKTWKUqWkzzDN0Hlb3tS+kAExpxT+o
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:76b3:b0:1bb:4279:4be9 with SMTP id
 dx51-20020a05687076b300b001bb42794be9mr7995398oab.3.1690228593707; Mon, 24
 Jul 2023 12:56:33 -0700 (PDT)
Date: Mon, 24 Jul 2023 12:56:33 -0700
In-Reply-To: <ZL7U/V3SFaJndkhW@bombadil.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ead1d006014102dc@google.com>
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

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git on commit 910e230d5f1bb72c54532e94fbb1705095c7bab6: failed to run ["git" "checkout" "910e230d5f1bb72c54532e94fbb1705095c7bab6"]: exit status 128
fatal: reference is not a tree: 910e230d5f1bb72c54532e94fbb1705095c7bab6



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 910e230d5f1bb72c54532e94fbb1705095c7bab6
dashboard link: https://syzkaller.appspot.com/bug?extid=9e4e94a2689427009d35
compiler:       

Note: no patches were applied.

