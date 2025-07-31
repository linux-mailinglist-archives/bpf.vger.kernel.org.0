Return-Path: <bpf+bounces-64811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3556EB17240
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 15:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28DE03ACDF9
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 13:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3AC2D0C60;
	Thu, 31 Jul 2025 13:43:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C3116419
	for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969387; cv=none; b=hZ2aYYhimeqiM6/X/cZx0KiGPiWs9RhOu9zFSADd0GVRJKvUkYDZev/6zRPLuxafO3cidLjmNqQ4Pbmem8UksfMPhOeADMcfMqaqDXtifMKR/Pd3HoLrSo9fh1b9yy9M3heZsHhbBMX4GGyjEz3+WKct3LmO5M2k3dcx+3CRU/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969387; c=relaxed/simple;
	bh=kx5UBa/rUKpCxax1gh5Ps5wlCy/DVnwNhn9buNehuFE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q5BLI9f7BjyBLKX2npRNXS2ldvf0o/zZck8qFzKSa4MzCAEW0NcUD5nhff1RzjTWu0K3I1FGRtbcQmB1g2aCfCLtu7mkur0BanGOQ4KSeiC0Ac4siIE1HvyWrV4ZlqsHWgnPrdK02y9jAt2qkxQrPOYOsGohfwfBup81CLHSXWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-87c73fe3121so81633239f.3
        for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 06:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753969385; x=1754574185;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndZt07l6ODlNg9Eyb1VPeXSebetlFLG+Q/xDsuh5QtU=;
        b=XHoLDwl3SSzS9fs3ToCr/QAz2kOcyBSETxZx7rVFbqFv5mDWXcltFAt+5HfVQF9Jm2
         l+3bqDiCftYwa3wKRgWwsDT5yqKNikF/kqw7e8JRBs3HRbrGwd8P22ZrB8SbIK/d4+85
         b3H0+lIm6pVti48fva4ODc2OImSg1D0fhloX/M8/aiVYOPV95VjIo4+oNfZFABtt7Z5S
         RIriQ8mOSmrL8UcfkxdRYvxC/3r9XKZJt2t3+fBR1uq2ms8nr8W1NJw/5/32bLJ81kpW
         BgkQ3CRiOKoUK/02NCQ4n2NBWW/bx51TOKZxB4LmICNKxq3EDw20g0Zt+4yoMHcV7U4R
         EFtA==
X-Forwarded-Encrypted: i=1; AJvYcCVCBLaq7vcREApxvqiup149OSG04LqAkYnOkXijrFyQKOeCFzPRklFse6QGNzNVX2XSOC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrmGZf3tRCvAR+eEu39iFClq+lImfXVnY9PcSCr89jlO1Q4I8h
	WNhEUHFKgk8nxcNocZxf3obFgEhqXATqS4CzGYUtxEY4z7zOIPJHfoZhT3fLljuz+gEmkOu7uvT
	6ZCVXbp3lwEEVsnCC0nLEt24XnRWyGVdDn4SpKZZrF/E7HNwmxCdqVPs8OHI=
X-Google-Smtp-Source: AGHT+IG7a22P54eB4UEoXzr0FAh4e0qa0CWa28Cd5Dwml2c1EWeCPmY9UJ+C086GKeXQ53ArF6VNZiT4F/nuHaB62ulyeCkYa1lo
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b13:b0:86c:cf7e:d85d with SMTP id
 ca18e2360f4ac-88138c1bed6mr1356042439f.12.1753969385155; Thu, 31 Jul 2025
 06:43:05 -0700 (PDT)
Date: Thu, 31 Jul 2025 06:43:05 -0700
In-Reply-To: <688ae0bf.050a0220.5d226.0011.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688b72e9.050a0220.5d226.0018.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in convert_ctx_accesses
From: syzbot <syzbot+ccac90e482b2a81d74aa@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, paul.chaignon@gmail.com, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 0df1a55afa832f463f9ad68ddc5de92230f1bc8a
Author: Paul Chaignon <paul.chaignon@gmail.com>
Date:   Tue Jul 1 18:36:15 2025 +0000

    bpf: Warn on internal verifier errors

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17d6aca2580000
start commit:   e8d780dcd957 Merge tag 'slab-for-6.17' of git://git.kernel..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1436aca2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1036aca2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d32de89be62206c8
dashboard link: https://syzkaller.appspot.com/bug?extid=ccac90e482b2a81d74aa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131049bc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11cc2cf0580000

Reported-by: syzbot+ccac90e482b2a81d74aa@syzkaller.appspotmail.com
Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

