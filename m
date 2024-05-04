Return-Path: <bpf+bounces-28579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C808BBD8A
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 20:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 215D8B21732
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 18:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF246BB30;
	Sat,  4 May 2024 18:03:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05803B29D
	for <bpf@vger.kernel.org>; Sat,  4 May 2024 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714845784; cv=none; b=Wk2kaGmbVVoVqYMtsQzI5+J6c4S+2CNWSXEOl4b9/zjmZh87KlnPcEfYIhp0zGmDUwFpsi4C+zWk+bULGuUoJW9qM9y9+gtewUC9jHwMKrBk/KwjPKdXMmSCvKeap1BNGJe92ZyuuL5TYidkML9ozjwmKcSuLl44F3jucDW6w+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714845784; c=relaxed/simple;
	bh=TGOyrg0sf81JB2aKmDNGGn/8jsML6d2k85Lh7p/VWc0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vAyqlZCmiJtBrp7uekv5CSn7BOv5Sv3ZBBg48ARPUrBthREP1cV5CDe+OGHDbMIRxw9K2Gz/QNVPtfGLbwG+dO446Aic4UXNK8d54ShvFEa0D6LdhJu2Ykw33UYBuaqhERJbhoVO35hrV0Hj/RPzLDwLPVYQ+VHC1OATbPZrFPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dece1fa472so66198139f.0
        for <bpf@vger.kernel.org>; Sat, 04 May 2024 11:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714845782; x=1715450582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUPcGyTMIX5rtLi/ARCE2IxHHhgwhiuh+5Rloinf3xA=;
        b=Y71vEcNb4UKJ7DilMYyZFVTxPohPnrE99yeNy81Qj7ZWuc2+s/Mge5L06hPti+UBaj
         7BCviSoxO/08q+SHNib8o7aLmYp4Yu9vgFCPBJAt5v4/mYP6yUW0wP18CUQQJCVqq5l2
         Kfdw9Tbe6RuFir1UYxz/Pc5yj6crC5RjODjOPHbp+78lc+3UsuE+d7jgItvtv5tqwxhN
         /AfrU+j4NVS4xNcApIE0s/F8ic7fHA3ef1cyIQiien/Ix9dg8qv6ZPIgsj3T++18qicF
         xXTNz37iu7Nm3k+eGKY5uefendhei+HhYOiV+MPRgGw4TyZlJSeZC7UH+SUf2OS/QARb
         d6FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKjyo6bPjEL3rJDSVIyhSbGX29M4mY4NbvRh15ogiaQvFbddluuFzLDnXnvdnCMYeTfszqYEnMvPruQ2IV9lK2JpaZ
X-Gm-Message-State: AOJu0Ywc8WYODMNmPOHiHaIPvMK9E5DlPv9G8ACMyjgaSr2iUxDhrhMZ
	8EpW0U/914QTH7M95/nbTHcZ7kNqBoFMFdBM5YUu3mksHvvyH1wxtJBlN3crKg1ceGAHCduWB/O
	iwA0uTrBdG3HsuQR+VeY9FTTFd9puXytHQZjz7Qtr4klvQszKyLHBgMI=
X-Google-Smtp-Source: AGHT+IHexZQjdMJ0UcNQiKItATZihzTrma90QUok5tG6gn9gMnSrxE72OaHcLmP4TLDaWgpBh6OjwcQtZdjnOXhshwTFiadLwhWr
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2489:b0:488:75e3:f3ce with SMTP id
 x9-20020a056638248900b0048875e3f3cemr9923jat.0.1714845781990; Sat, 04 May
 2024 11:03:01 -0700 (PDT)
Date: Sat, 04 May 2024 11:03:01 -0700
In-Reply-To: <0000000000004cc3030616474b1e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae301f0617a4a52c@google.com>
Subject: Re: [syzbot] [bpf?] [net?] WARNING in __xdp_reg_mem_model
From: syzbot <syzbot+f534bd500d914e34b59e@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	hawk@kernel.org, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, lorenzo@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 2b0cfa6e49566c8fa6759734cf821aa6e8271a9e
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Mon Feb 12 09:50:54 2024 +0000

    net: add generic percpu page_pool allocator

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=151860d4980000
start commit:   f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=171860d4980000
console output: https://syzkaller.appspot.com/x/log.txt?x=131860d4980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=f534bd500d914e34b59e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ac600b180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1144b797180000

Reported-by: syzbot+f534bd500d914e34b59e@syzkaller.appspotmail.com
Fixes: 2b0cfa6e4956 ("net: add generic percpu page_pool allocator")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

