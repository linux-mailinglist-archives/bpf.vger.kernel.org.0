Return-Path: <bpf+bounces-62197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C31AF64CB
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 00:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03FA81C40835
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 22:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5C4243371;
	Wed,  2 Jul 2025 22:04:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137DD22FAC3
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 22:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751493845; cv=none; b=lJnoAFdBAWinx63nEjeRgq9R3rYTcpMo7oAobMUrk+g3KiuJT/8G3Ey71qOwgX5mSbKm3DTtUfUoVLlatc/HwlsOPsxStXOjZSrObyKUuVVxjaP8YOmpt9jqdyyo7PHIhnpp7tKsYTDQHNwZjXvPi8YoqphSbX++obrYOGGayaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751493845; c=relaxed/simple;
	bh=SsfceBP+qhOoMo7OoM5UWUZ1eymVxtTJuiLiM1pfvGI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RpqP9lDrEJ8If7X3jfwzSdKUmqszPt2lgp5bD5roAdxc9sQehVabs5K8vdJaLZoJm9l9dD8RsDv5gUOWC7mhw2t24jycYXILHObREPJ0p9EGP+71xzuckChKdk+2aXUhuI1KlI56jZe9rPqXxlJfWdT/d5lQA9TDsS1aImNy5ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86a5def8869so773622939f.0
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 15:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751493843; x=1752098643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/J03lRbzuvB4PtTp7I4ZDRquz2XgnWn7PW50AxA3/A=;
        b=hSuP8uAlsZCeKweZkqi8GbQbs7TPLICHQokmeXkBODL3xnUCMHXze8zTfpsUdF6ORP
         c6pkmC2IA6C3AtdonP08DaCHXH7reqTf2ZYXvD9lgjOPp7P0SaQUyY1dqv+jNLS/ToLA
         7HUhgG2hj5qokpQZPwLdd2www1YXzFI8Nv3fYfm2RIrgnQorHrHGMhD7UJ7hc/Y9Qpk3
         CtQ3Wd9ZDIp8iu93mpU5FoHO+1iXeyKH1Ba2ZqFhkl3C0AerzRkjt0Dl20W1P5ZckW4a
         T7TOMUoBkoXNk4EKjJ8oWjEJLARNYgRu1cgwI+RLYLa1HDf0WnhM0e96JnMdlPFk+Zz2
         lzQg==
X-Forwarded-Encrypted: i=1; AJvYcCUFIPHJW6CJZYgKnve9gEGz4Pjkw6YhDJTgAUrTTAYCzJH0VPwyNUb+1rmtMW1BdUSaXVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJrmoIgPeHNn+yvoonho5yi0FgfglpeG1avE5v1OQNBV3HvieZ
	Yct4FtjMq9w8gQlaWU+k45ToExxhmPSqFb5Bm5TIgz192Afx0fWgDbVJc9kJDsh6lZs8RPtSVri
	6BWuqu/rR3AnH+ItAwnbpMIACj0z29g0eKgkiAVEirUOKcANQAcidecT61ZY=
X-Google-Smtp-Source: AGHT+IEw/ZHDnLHRk/xRKLu4Ya2e0GjrHeyDhj/YYErj5HvA2TZDeohNuR8anf7y3BU+aQdE712Xkz53vyUBKu1Q4hNP8ysjci3Y
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0c:b0:3df:5314:1b88 with SMTP id
 e9e14a558f8ab-3e05c324012mr16573595ab.15.1751493843172; Wed, 02 Jul 2025
 15:04:03 -0700 (PDT)
Date: Wed, 02 Jul 2025 15:04:03 -0700
In-Reply-To: <686491d6.a70a0220.3b7e22.20ea.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6865acd3.a70a0220.2b31f5.0005.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in check_helper_call
From: syzbot <syzbot+69014a227f8edad4d8c6@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	paul.chaignon@gmail.com, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 0df1a55afa832f463f9ad68ddc5de92230f1bc8a
Author: Paul Chaignon <paul.chaignon@gmail.com>
Date:   Tue Jul 1 18:36:15 2025 +0000

    bpf: Warn on internal verifier errors

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155a848c580000
start commit:   cce3fee729ee selftests/bpf: Enable dynptr/test_probe_read_..
git tree:       bpf-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=175a848c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=135a848c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
dashboard link: https://syzkaller.appspot.com/bug?extid=69014a227f8edad4d8c6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144053d4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d45770580000

Reported-by: syzbot+69014a227f8edad4d8c6@syzkaller.appspotmail.com
Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

