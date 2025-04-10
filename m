Return-Path: <bpf+bounces-55658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F42A844B4
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 15:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E821895684
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 13:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE462857FF;
	Thu, 10 Apr 2025 13:22:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D0A2857EB
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291326; cv=none; b=hhm6HOShWDaJbi/azqOHqFPgz/hPYWj7pwWhq2zqow6P6YYFR97EVwIq1fvt8H5jRaGBbsbGVE5jLeoLn2mtGVulsw5zu4WhbxmyZOzvEIw6ZIsxysPMUjLm1ltn81ECNOXBXBDtrjvdj0il/Yy+ciB4w5DPjbgD0c+a+5j26tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291326; c=relaxed/simple;
	bh=TxpinXIVox58balXQ9mjFYVf5poJ3SM1tyO588NrTqc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dKg75qj2x970ww5w+hgAgjl19+0CAyHBmYTu+w2xm6A4O5ggcmb/N4x1rJoAn8xn54zLTFFs3W4CctzuKB/1FGjhp5ZJMAwtHVM5gjjchdL93nZVOaMNwUuxgkNRkJGRD3oodPKAfQkN8kXQkzOPG9YBE3QJtMycI6BMRZ6q7hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d443811f04so7346135ab.1
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 06:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744291323; x=1744896123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b72eM9eMZlRKFXr+o0KTa33dW1ftqcPwLSRLp9ZZfV0=;
        b=swXxDwHP64fJLGz3/S37A4nrMKd1jKLdU+cm3zjRzccHGP9xSeOlb+S7rTwf2ELA/J
         ImYlZ4k0HtTY183MKJb0Svm4rHdW5lMnv5PmxAhlh0k3G8wm8WEh1WCXiClqFZoO0qtH
         8JJzYMa61CJcfZTrDW+Mw2Y0+9o0g6vfpEQg6xdSPuIJB20j50mLCj7XIrw3zGpNVmRm
         ipc2lVSGm7I0x9xKwhawsbSKPvYcVgNOTkgu+n+3MUYKLlt+vV/UTIUX48qNWEG3Kw5p
         KP+O43Svm96OElvT3U5oH9UK2dNLxAtSTOWD7c1N5Doz7xhbUqilQ+R6tT6pJKZauTrU
         6geg==
X-Forwarded-Encrypted: i=1; AJvYcCUFO14KOo7N/bEqgJCkoukKVHb2clZz3VR5Lcp2NN/A7vGIfKrOwwhtOyua/8oHD2mXJWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQslyCnJzi7mngyE8M9YlI1UvVuUsmYXrXSo3ot7SJ3StLiDBe
	dLHSBkK6cAnsILn3JoM6B5v7r/X2qht1O8JGlh8b0rw1JBpt0ct0oJf3HYwn84awauYnBwXtt+J
	QbhhaS9zpVTRn0Ff+Wqqkzl3Kk7jDQ9Y7e962cYSqK5AxEx7XUwFSSog=
X-Google-Smtp-Source: AGHT+IGU1BugYKtYSCi9Fl/9FsIbPPTncwjselRA4wXdisDf7Q5xTu9+qCpgT81N6WVOO6wRNToO1AvfSg+/VmOV+eylCgHxBo7S
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f81:b0:3cf:b87b:8fd4 with SMTP id
 e9e14a558f8ab-3d7e47747a0mr30941585ab.15.1744291323816; Thu, 10 Apr 2025
 06:22:03 -0700 (PDT)
Date: Thu, 10 Apr 2025 06:22:03 -0700
In-Reply-To: <20250410124315.1201290-1-memxor@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f7c5fb.050a0220.355867.0003.GAE@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in __queue_map_get
From: syzbot <syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	netdev@vger.kernel.org, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for batadv0 to become free. Usage count = 3


Tested on:

commit:         e403941b bpf: Convert ringbuf.c to rqspinlock
git tree:       https://github.com/kkdwivedi/linux.git res-lock-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1524f23f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea2b297a0891c87e
dashboard link: https://syzkaller.appspot.com/bug?extid=8bdfc2c53fb2b63e1871
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

