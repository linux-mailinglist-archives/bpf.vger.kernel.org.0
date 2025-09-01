Return-Path: <bpf+bounces-67131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB1BB3F0D4
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 00:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDA3480D63
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 22:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644F327E1C6;
	Mon,  1 Sep 2025 22:10:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF69273D77
	for <bpf@vger.kernel.org>; Mon,  1 Sep 2025 22:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756764607; cv=none; b=PJuHPxT7Bq0kW6jzoIdbHNUzNfzByPGKGLMM6d828w38OF5LZ1xSiNmPFV+eoZZ4SJ0uzSCEogAsjjjXQdaiA94QIJqVcBcuc5IlEYwkyepDEoHQ3fk8Fjchvxov4+pz8k/Dw0qVs0mvba63KfYavU8K4FuRW+ypZsVmlXwi3Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756764607; c=relaxed/simple;
	bh=p0kMM4y7F6N7P9lmCZgTWs3ZjOeXgQCDCsLCsQtEfe0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=scxoo9wDQsEcL6mk1BAhgkwF8a9p9FL320q2B+/pu/+nP+Bl7mMx5ikYwRps/c0L7xGHuzuMJ8nnAwrXHuHD0jJ6s1I+Bqz60A5wFZ2ftUJiujntMRJH/gG4XEiKBslqa5kYw/OQ3Oar7KIzg0J2tUCpKd8muq79sgD1hD9TqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8870219dce3so434957739f.0
        for <bpf@vger.kernel.org>; Mon, 01 Sep 2025 15:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756764605; x=1757369405;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rONquuup1tA/FntPWjZbG/timt5LNSvQmqhWL+HMBzU=;
        b=IOVHjCeMCK+1aHR2zwwFhkismTZQdKIITx4SYKpFKzkezn5wNnbOnWsNe/uzUnojZI
         aXIqTSh69CGzazCqo2BrYwADVem3Ym6wo7Y+KMVhHw+y1EDQ1cluYnuYYfbNwU2Z1Mgq
         AmIeih8aDKRrDuizl9ozOub58UCO68r3JpCr5CVlgeIxxJIyWorkm4AJsDiwtUbfQf6i
         xe2rmdzke/9swoQEk7x7CX0qJ2Iyht19ORPICVwf6zhV85DzRcYKVYmDCSuPtQKswXY1
         rWW83WIzIhfziRBcI41GDjTFxAssOOA9F7dv2X+fy+CLvFMplk3CRH19kKGXoF26DZOb
         8KLA==
X-Forwarded-Encrypted: i=1; AJvYcCW+zOA890gV0msa+JWgGdPG1zk1whQrc324Wl6phqVcPSDVdxJxLFlnZLhVwqPqQb5bx60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbG4wx3z+wmb6gVTmEnEyCF29YnKJhKNnDBD0UIC2jWLlKyY/e
	ie5+VHpGn02jRCY26/9jAeAZypkg3dZub78sVvKjQZenzatelEsjknqcEROZjWcm3uTl+I6jc1S
	1LYUFhJOkiZXoSUthUoE4Yd9UuFZitxu+uglVAwoE7ScrXtNZpCFcBsIXi/w=
X-Google-Smtp-Source: AGHT+IEwWIM0KR32k0CrIYVm5MqXLqvHyE40n+Jbcb7UVXKXi5zhmdRI/WfQizUkVs9bev2AbFsAxIgzU7Q7sbXwGYhdaNj7lYwg
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa2:b0:3f0:78c3:8fc5 with SMTP id
 e9e14a558f8ab-3f400097882mr176361265ab.5.1756764604779; Mon, 01 Sep 2025
 15:10:04 -0700 (PDT)
Date: Mon, 01 Sep 2025 15:10:04 -0700
In-Reply-To: <68ac9fd3.050a0220.37038e.0096.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b619bc.050a0220.3db4df.01c5.GAE@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in __bpf_ringbuf_reserve (2)
From: syzbot <syzbot+fa5c2814795b5adca240@syzkaller.appspotmail.com>
To: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, hffilwlqm@gmail.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 27861fc720be2c39b861d8bdfb68287f54de6855
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu Aug 21 16:26:00 2025 +0000

    bpf: Drop rqspinlock usage in ringbuf

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=167eee34580000
start commit:   dd9de524183a xsk: Fix immature cq descriptor production
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=157eee34580000
console output: https://syzkaller.appspot.com/x/log.txt?x=117eee34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c321f33e4545e2a1
dashboard link: https://syzkaller.appspot.com/bug?extid=fa5c2814795b5adca240
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142da862580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1588aef0580000

Reported-by: syzbot+fa5c2814795b5adca240@syzkaller.appspotmail.com
Fixes: 27861fc720be ("bpf: Drop rqspinlock usage in ringbuf")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

