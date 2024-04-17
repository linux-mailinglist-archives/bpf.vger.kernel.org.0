Return-Path: <bpf+bounces-27054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F3F8A86A5
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 16:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4950F1F212FD
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78950142E9C;
	Wed, 17 Apr 2024 14:49:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1B0142E70
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365346; cv=none; b=ho8DNILmyD9+YF8Co65xVh5avweu6mBpWGCqLKFcapnM09wlol76upgp7cz2pjKCtdzOeV1NtgfsFdJ7zwJ/d80huf2Jn90TmhdYSkbVJQE1eH4ybc0RT5E7/q0wjP6j7arA12AWa59xNNmnaEDOefxe27UGS6hYDvowyQWlDRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365346; c=relaxed/simple;
	bh=arYAiaCB5bQDcWyY6Fg5A6dpdQ7egLODjHN2gDiOR4c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H8vVjiiCJhu61JxxIcFmCyRsuV3FYxZafzpm+znXUT67ZT3dylvFPPO8IJQMBJ+mfhr5GMPY48s6Chm3q4BbcXW5Kt6FgDVxYjzDdKANMIkNlDPh+pE4TIbzGwhH011Kfcl9X9QhS9VOq14vbkJ3RU9P0djAijiY+2ZfPN1VkCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc7a6a043bso766276539f.0
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 07:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713365344; x=1713970144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9iLXNunqSNr8QRXcPEHq58jPUvBUNMYnjkVj+0AeDws=;
        b=nZHEJmn0QJRlhHeeYzoekgw9y3plnJTyqaJP74A7u7oUN6D0WlXBk4cUXn+O4k0QEI
         lFlW7vgjBjCWRb/fP4OYlpQk0+wDlslnOtO/7wkimdseHTTW3Pl9n2k+wQQU6ZPmRa4y
         bfHgLD2Owc48UUJw/AhF3OXH5rbG7a7Ga0nFUguhYtIT7SCZ+8K5Qnq/bbrvIlgCpThX
         0ZAC394ym78WwegGwNX2KCfWefpwyBvMrr+weM/ZtrGntirXOvy5Q+CUT/5NqKMZmMNN
         +hgyARNjQUy0IKoxqnuYwp/s+alPK4J+/qKyOgmi/eHbpvDBPLWWNJgP3+7Sec/U7ZBx
         WDtw==
X-Forwarded-Encrypted: i=1; AJvYcCXJe86z/UgJgQip95o5GMlJN3WrTkia8MorZz5LRGuWTqcntRnGIVmfmVdRrqKNKeOxkR5VSEPDSc8ZTEoDt3qOjAC8
X-Gm-Message-State: AOJu0Yz1DHGWkz3IhG3I7xFVW5mmljKOcYfJMtVo3x4SvM016FLMUzP+
	x6cLVUt1IGINCTj8whCe2l/XGV1stgpXZgGpIcYh0ENkakXemLRHDEf3NeESEEx0Yww2P12jhNM
	gUxh5EQtDkvE9WXPxwytWEYViWSzO9ibX1UmyjL8KTv0Lq/ERGweSjs4=
X-Google-Smtp-Source: AGHT+IG5KPWeJ6k7l1iEickd9TA7War8sUCpO4E/yTKozoCtWTn4mh1KzRpVsk6ZYxw9Y0eF2w0SQnmEkVvYFKet3EqQL+vJRrjo
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8529:b0:482:c2c6:65b with SMTP id
 is41-20020a056638852900b00482c2c6065bmr1093800jab.1.1713365343174; Wed, 17
 Apr 2024 07:49:03 -0700 (PDT)
Date: Wed, 17 Apr 2024 07:49:03 -0700
In-Reply-To: <87il0huixn.fsf@toke.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a693f106164bf4c7@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_enqueue
From: syzbot <syzbot+af9492708df9797198d6@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eadavis@qq.com, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	toke@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com

Tested on:

commit:         443574b0 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
console output: https://syzkaller.appspot.com/x/log.txt?x=125ea0e3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=af9492708df9797198d6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=156227cd180000

Note: testing is done by a robot and is best-effort only.

