Return-Path: <bpf+bounces-33992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1C49293D1
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 15:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41B11F21F27
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 13:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8981304A2;
	Sat,  6 Jul 2024 13:38:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4120926AC2
	for <bpf@vger.kernel.org>; Sat,  6 Jul 2024 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720273084; cv=none; b=ohG73JQKpp0MNMDixeEByrZt0E5lOvORBdkSiMB2halUfRZ4k6okAZrETf6I21EYfl/sI2f79xiHyONHvMkgvVKzytiiYkI5YbWsB13NnW+m/Rs7zRi5wm2GP2LT8VApTtpkuvVvmjq1nTf5mulJP3iG/Ry/fFEfvopCKhCkiTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720273084; c=relaxed/simple;
	bh=zWaW7v6PJhOBV43NT3fE4HnLKL+0G6JoD8gx4YTscdU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SyymE3rTsHAgdLYTQiJ4XbhwF3c/zrxEW4GzeVg1/Yd7b8RfKw9CrEG9Tgx6xLK2R0j640CJoCIVL+lkXZ2T/2NtvuNEHH0weAmdPQO/J92lUKtukHH7zwAiXABReX2N2DJaBMQ16TmfR10y0r/Ql1JlU9uRPy4a7UkTKWbter8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f3ccfec801so284396639f.3
        for <bpf@vger.kernel.org>; Sat, 06 Jul 2024 06:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720273082; x=1720877882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrvwA9+kz/VdMLLWXSyRN3pFrHfsHxWlAply6NHrwzg=;
        b=hVVL2GpRYDl9sCzgfr12dbpsqfMZ3CwhKB+xcOOW8Jfc4v/IDI7DUxq7zmnZTXearB
         yBvnScrnsMqMna6JW6HgWztD5QhTCNvIL03kbSfaDmp3g/j7LZEMfP9Y1u/4H1i1L3Vs
         hEkSx1mNSZCW+Ky/iE2EhsjyGrbhm+5a+POhy/6ovgPx2T4qgoRcv9vwYDOYqQ4WKLTf
         J7J8XaeL+sYHCmW8EvNY9vEpK04I8rPVPwkE/Usoo/Daj7N7dcTXJind/bEfjCotvnUg
         PMxpnpyIYKrwQPJbYjrjzZDBqzmNtlriNRfKmpq76Vsxy9ybAPqXkVGjPisU90TjTJOJ
         Ul+g==
X-Forwarded-Encrypted: i=1; AJvYcCXeDHxl1JqR3dd3L0RFu/UpJnW4qeEiHuXmq8xXc14pe19JgGAfhCG3us+KU2WaGdln35OwskswrVgVsQxwUQTaPBFH
X-Gm-Message-State: AOJu0YyowvI5xaedhLisorZW1L1sUUHCcGHTmXjNROTRmc468pL1YbHk
	3SffYRluDzscIEsSxRygSaZS8GXvM2un9fwPjQxiqooxYIdOoGdK1ncuyqnAJ0o3f3415PslisH
	jZR+tn9ZIZy0kWR//cXoml8W3UbpSGSBRrqHjLUGTSrMsKlIisXL5xB0=
X-Google-Smtp-Source: AGHT+IHCSx2+VbzZCCozhjDVuSHJ5tQ1gic4b9jAHvFVi10Tecnep7tLHfjFLuZpWjQmZJs8YvMggPuufjgt+z+fOZLhmQgFhl/w
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:144d:b0:4b7:c9b5:675c with SMTP id
 8926c6da1cb9f-4bf63c2f6efmr1014361173.6.1720273082401; Sat, 06 Jul 2024
 06:38:02 -0700 (PDT)
Date: Sat, 06 Jul 2024 06:38:02 -0700
In-Reply-To: <20240706131317.Vx3MriDC@linutronix.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe576c061c944907@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_redirect
From: syzbot <syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bigeasy@linutronix.de, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, patchwork-bot@kernel.org, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com

Tested on:

commit:         2f5e6395 Merge branch 'net-pse-pd-add-new-pse-c33-feat..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=12f8b8a5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db697e01efa9d1d7
dashboard link: https://syzkaller.appspot.com/bug?extid=08811615f0e17bc6708b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

