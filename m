Return-Path: <bpf+bounces-71264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBFBBEBF60
	for <lists+bpf@lfdr.de>; Sat, 18 Oct 2025 00:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BEEC408028
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 22:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49633128C6;
	Fri, 17 Oct 2025 22:57:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF44F3126B8
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 22:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760741827; cv=none; b=X9hnOHISExyXZlm5yG2hWHUqiaP3cG2UdQFFoVyMYOUpzA6qLd+exWkL6XS6M2zqe36GUFaNGAN3WleIYD+KFWPMAZsLou1x9ecnWKghQbq7hLgF4KgyUutC7LBxeJe6abG362/b660Oe4YrDpUWBbMehpKeZtY7Ge39PF/SE7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760741827; c=relaxed/simple;
	bh=f7KvCyEDTyzOxXZjve5/fBxv3fhXq88Wg/v716HQCy4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Kpubr3KnoNV0wccoRqArJLWl8j2RNZfQjOyLqPpNpN/w0SDZIM8t8b8MxL5P8IunvIXDvKVvqolvjhPGuQZVU7Ede5wGQ4jM3lvlhbKOceMftdsNnLUSZDJybaR2XaFB1Qf0VWjD7mvHh3uhvv8iKhdbyqoUESdilTjRn1KlV9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430cf6c6e20so8622905ab.2
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 15:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760741824; x=1761346624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJpgDBAxLccAhUteGLabQLlE9rHnlPNcTGhEEI8GY10=;
        b=sxtizGm9pD/rDvA11F74R7YKyDfYn5Tzca0MoCTU59VIsQymFKm3kkzJ9FU1nou3ff
         YWyqaPXS+hoVm8G6JYCkZ9YDUgTgPDbR+NoozwatFyp0pR+GPV8bkskg2zMLWSxxGZO6
         tj4DHMHEkV7gRh6WsG+V3yOX7e+i+2hfSKZW5qJNA1s//OoOTOlGiiJwywNCY28Ldf7F
         71SV/VeWeHRkcXUlLKfoOirdaTils83CboYDCdgNk+Jn8nLpCfArEeVWZquiPMyetiQL
         a+YfsnmXAkrOtHz7mIhRGBFaHajGvI2WSlasyYTPuLfqISOOOv5c1XrfMlrc7bHDNaKK
         J8eA==
X-Forwarded-Encrypted: i=1; AJvYcCVVj0YDqdT5X6fAmY6CAJTwX/MQJ1L69qlunCAC39T3pMaE/cxJHPFDN2jFTssE33O0Jzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMfGjjKMk4gYSqbU43u0rvsCBdrpfUOc+BhHG8KI8yEJ6Jt7GQ
	fs+8T8zr8IiHxEc8smaICnTFrhHshMhpCTTeQomhIN+BdzRQ8t3rB14+1vwn/M4VSbvNUiIUCjJ
	tJA6GaYSSI6nxyZ15Ks90il2Olwj8bXzlBzHVBa2bm8jOD9hfvwo456NzGtE=
X-Google-Smtp-Source: AGHT+IF+DUySWarTjVDbax0WipWnWUmr3IAi8Ismsyh5rLjk7lt5iY6vnww0yV3GZ+Fljwql2QmO8PvAs1Uull9sCzlzd2U19Y0H
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:0:b0:3f3:4562:ca92 with SMTP id
 e9e14a558f8ab-430c525f51dmr87920195ab.10.1760741823800; Fri, 17 Oct 2025
 15:57:03 -0700 (PDT)
Date: Fri, 17 Oct 2025 15:57:03 -0700
In-Reply-To: <000000000000ae5aca05e68a7748@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f2c9bf.050a0220.1186a4.051b.GAE@google.com>
Subject: Re: [syzbot] [bpf?] INFO: rcu detected stall in watchdog
From: syzbot <syzbot+0bab26cf3949891fb534@syzkaller.appspotmail.com>
To: andrii@kernel.org, anna-maria@linutronix.de, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, frederic@kernel.org, 
	gregkh@linuxfoundation.org, hdanton@sina.com, hverkuil+cisco@kernel.org, 
	linux-kernel@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp, 
	penguin-kernel@i-love.sakura.ne.jp, rafael@kernel.org, sean@mess.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit eecd203ada43a4693ce6fdd3a58ae10c7819252c
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Thu Jul 17 14:21:55 2025 +0000

    media: imon: make send_packet() more robust

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154d6734580000
start commit:   e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=286b31f2cf1c36b5
dashboard link: https://syzkaller.appspot.com/bug?extid=0bab26cf3949891fb534
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11646580580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: media: imon: make send_packet() more robust

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

