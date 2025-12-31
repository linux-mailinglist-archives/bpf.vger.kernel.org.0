Return-Path: <bpf+bounces-77564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A20B5CEB33E
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 04:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE6E3301CC52
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 03:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792632E0417;
	Wed, 31 Dec 2025 03:42:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F61126C17
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 03:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767152526; cv=none; b=NRRRnGuAqf9GnYXIudIedfd4HPXubLhxPTM9uiX/UXi5KZcOC9oQrEf71vfT9Wj6bJfl8aKgQZu9ngBumaTMuGVvXk9IO5j3aKPEGcJnPOZr38Ncp2r0/xv6Q/3CeabRsdCMYD6HUMbIOkq6qQKVdrQnXNOF4L+mVGMNbt7X1TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767152526; c=relaxed/simple;
	bh=NPVuhxc71mMAK0ZfiBcYrYIc2f5F5gAF0HHLv1cKtxM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=g9pg0imACpuDeYIilr07+cnRyjWkyj16RzgwFopFYaG3KgKTg0Qh2foz5fTn6M+moUeCm/n6N8CImz/FuNQfv72V/pmCMHK2avEOmUXtElSE+SeFDBmDe5ZE4zFIWBxDbgYLxtGzL28iXB+XeWyEBgHgwkM4ve1HsQw8Hv0ab4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-65eccb3f95cso10668932eaf.3
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 19:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767152523; x=1767757323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+NqgdUFC6zt8/ZKRTbDsOUzjmW3BwgcxR7/XfLrJs88=;
        b=eYHi1hQt/2/C2IjKlh8H6txadAK9Z7imBgj4Te1tgDdgH+VxnuZJiCQcf+nwBZ/RT9
         /1ikf4Qqk+AJbXMrbAZzwqJgHrzj/CmhlFhFE4cbw6BeLa30sHswME1+iDww7VX1w25S
         UMXufYoP1LHPl7acoQ6XItZZFTulV+QtkoCA6U0uPmAuAlN51DNRXf3l7Fkk/YN74r27
         DA+q9VEdNWdEPFSfI1ZWOAyqz9S4ROLE0imZax990QTnrdF0Z4QIUPk1AkFHivi0ubrk
         G2nkZNn8ekHHYt7wmAczadqgl6mk/rTpSwfMaf67LJSQoUCvCpHlibWOeNAjQbl+t9HA
         54XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcIOtkpgjbqg32pWn3NaienE2yi/adGtQOWR6tPECl/F4Mg2ucdmVTKH07eML/C+7gi/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5oOSq3qfcLqN+AykVh2Ph16Eu3D8BM7AF8/MBgHMxZ4nVFxVN
	v+Ij7kPxxpdMa+Bg8vV61J0DMMoAEKxNbPDrvYMn3xHCmNj39wOP8PROlyRZ3b92WPDpUEhlOzL
	m2bYc7zeERiK7d+FwvVc9b1SLtIp6IEy1vspXbvaYvBdEgUg8DKlO7r9hA3U=
X-Google-Smtp-Source: AGHT+IFHCJ/LIhkQS0FltES+g/WfqzR9dIrN7A+aJSX9xaYvbn494aSHjtP7u9K5fSCGwv6aRnmQ1fBDcu6FTRb0cCRTk9bcdd/K
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2212:b0:65d:23b:4b9 with SMTP id
 006d021491bc7-65d0eb6ed4cmr17614316eaf.55.1767152522823; Tue, 30 Dec 2025
 19:42:02 -0800 (PST)
Date: Tue, 30 Dec 2025 19:42:02 -0800
In-Reply-To: <20251231031754.299998-1-buaajxlj@163.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69549b8a.050a0220.a1b6.030b.GAE@google.com>
Subject: Re: [syzbot] [bpf?] general protection fault in bpf_get_local_storage (2)
From: syzbot <syzbot+4fe468a3f7fac86ea2c9@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, buaajxlj@163.com, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	liangjie@lixiang.com, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4fe468a3f7fac86ea2c9@syzkaller.appspotmail.com
Tested-by: syzbot+4fe468a3f7fac86ea2c9@syzkaller.appspotmail.com

Tested on:

commit:         3f0e9c8c Merge tag 'block-6.19-20251226' of git://git...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13bb9792580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=513255d80ab78f2b
dashboard link: https://syzkaller.appspot.com/bug?extid=4fe468a3f7fac86ea2c9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10fca422580000

Note: testing is done by a robot and is best-effort only.

