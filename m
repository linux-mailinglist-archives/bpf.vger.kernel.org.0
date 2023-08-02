Return-Path: <bpf+bounces-6731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7895E76D408
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 18:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93FF1C212F4
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 16:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063DCDDB6;
	Wed,  2 Aug 2023 16:48:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABE2DDAF
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 16:48:33 +0000 (UTC)
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5AD2718
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 09:48:31 -0700 (PDT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-56c7adba6afso8791650eaf.3
        for <bpf@vger.kernel.org>; Wed, 02 Aug 2023 09:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690994910; x=1691599710;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYKi8o9F6eiWCa6W4LKamwGGGyahz7HtNFcm3VxSBwM=;
        b=hJrz2YS3HEZI7TFNBEMPfO0wOTaZG4AsOdCGzuaKLfmanaM4W5rirANdD0rVqZTGUt
         nTeIErEyvGy6idiasXhOVjuJ2s5Y7h27sFzQuY/82WQHKGUOog/9I7Mi+bKZtJuSjfEj
         dGhUhkp0yNADjJRf1NIoq8kJn/8kyk7hbWK5AjRuxGHwY20nn3uuJXI9zYmvE6x1FgJs
         /JWcXulVO9psTMslsGvHwrxLAY+i9rNKbQDrY63StZber6IED88bMJngBR73uepU35/e
         788UE2sgX5yBbsg3z5gjuvuYuPGEnx8rJgckwc76TQzBloLiWhf97FnFkdjIWjOhidmh
         LjUA==
X-Gm-Message-State: ABy/qLahsle8syMPMmkoI/cEghaXCOMMhzG7xQY8yZIGCHnNuAemWVvt
	kmv5aSOfSTZAkwQXndvgvMZZjRJ0DIGvyaYZpJibbYoC4pPQlVg=
X-Google-Smtp-Source: APBJJlGJmB7c8epxLUHVlcd5q9o6JmFyZq+1fc1su7ZzZrNN0BVgY079DaI9kO8K9tDJb1lVZUP9D8ESC8PRbct7dF2zSmc0Pgtv
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a888:b0:1bb:4d41:e929 with SMTP id
 eb8-20020a056870a88800b001bb4d41e929mr18010511oab.3.1690994910687; Wed, 02
 Aug 2023 09:48:30 -0700 (PDT)
Date: Wed, 02 Aug 2023 09:48:30 -0700
In-Reply-To: <1796030.1690982494@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7f8fc0601f36e4c@google.com>
Subject: Re: [syzbot] [fs?] INFO: task hung in pipe_release (4)
From: syzbot <syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com>
To: bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net, 
	dhowells@redhat.com, dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com

Tested on:

commit:         5d0c230f Linux 6.5-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a8b5d5a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df103238a07f256e
dashboard link: https://syzkaller.appspot.com/bug?extid=f527b971b4bdc8e79f9e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17e285dea80000

Note: testing is done by a robot and is best-effort only.

