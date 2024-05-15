Return-Path: <bpf+bounces-29774-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEAF8C69BB
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 17:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A162E1C21ADD
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 15:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBA2156985;
	Wed, 15 May 2024 15:29:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C6015622F
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786945; cv=none; b=BSIG/bvvIiUvBSwRryRmc8Xa6T/njaJMJqL8knMiITUM9/kB+GG2yuzQ2RWtjzq1ojI37cEidjF+3ZzdS483ClsChTWvK4Uu+H9hzdRRQ2MoMuB0z7HXrFd+JPiFvdrJ3QSww5ivmuIHM/4lnaUDdD/hgbG6Qeg8xdFNHp9AC8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786945; c=relaxed/simple;
	bh=PqF49Gws6c8IE8QBsjCzrN5yCRLZFu/Gy9G1aU4u6TQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HtJVml2yu4CdiGn4E0uhKCIHfzknPKonlsMu72JG5rrD4kDbZL2HEgLza43diZWvhxlCi8+UNColmX2obAxpGCJm0+IjYJh5+kQg9AeAjGruRF/IZMX8s/NAhsqPf1YIqFTwNqKjdKLdxa6WmLz6y8KK/gr5YQMKxo4eMpzFvqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e1bbace584so654148739f.1
        for <bpf@vger.kernel.org>; Wed, 15 May 2024 08:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715786943; x=1716391743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNhrORouLQq0zE8Q1N3mawbELctD4U2yYjN8CbPX7CM=;
        b=RSt0w530zgQgEH8ITiEQ0VVeT3WXKARbj9aPUIG9xbXV6hkZDVXBWpBP9hJGj9EGTx
         364ioeCkHah0eqD6j3pWdJmoYX7hZ9qNv488nMKGLpavBpzHOQd65+jUcBKgITSm4fIS
         ptQovqyPS6+aCZQigkVUo5ApwKj3qN0/OB1XRGb5tk3OkUvrs2B2IWmocqkH4iTMo/a1
         WMsqHueNgBUfiVVYVlv4dkK/7jKOVKjUOLFVFTp2SXvZYnyysjZoSelkYkafdTmzNlqR
         R2lcMXutGMmpUBciGrUQnfUvF3JgZfRhBRDHlZel8Yr35B0DaTB/jww6iFcS2cPNTCwx
         fd2g==
X-Forwarded-Encrypted: i=1; AJvYcCXZav4mAsepcA0PaiCq0TI71N3CA+qJCDeJUhksti4+UusuWnl7VMdwicaL6Ab2peK1xCJGPz4ShdEkaGeINSsr4YyP
X-Gm-Message-State: AOJu0YwY+46yU9UFh789L3z2owbEZIMGOCY5gb1P4UMvpF1u8d/dNClk
	ox4geGyFi3/s9fLzPflIoQikATV6pON7X7kQ4RoCqoaXOZZugcfe0VBB8GaldDKxbEtqbzOk6fU
	SRUpIodZVQTXX6GqazFJW6w6yKaMDlCcDJ01xRaWC/jpYXwKePaeSp8Y=
X-Google-Smtp-Source: AGHT+IH+Xte0typid77mQsPKT2woVUNNSCR05/igZC6Db/CLD0HuhNNjfiuJzefv2sWGB81JP6W0lDIe2IrKsModHuY5ZxKJgzzk
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8725:b0:488:cdbc:72c0 with SMTP id
 8926c6da1cb9f-489586993ecmr1725942173.2.1715786943579; Wed, 15 May 2024
 08:29:03 -0700 (PDT)
Date: Wed, 15 May 2024 08:29:03 -0700
In-Reply-To: <000000000000b97fba06156dc57b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000485a2d06187fc7a7@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: stack-out-of-bounds Read in hash
From: syzbot <syzbot+9459b5d7fab774cf182f@syzkaller.appspotmail.com>
To: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, houtao@huaweicloud.com, joannekoong@fb.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kafai@fb.com, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, songliubraving@fb.com, 
	syzkaller-bugs@googlegroups.com, yhs@fb.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 9330986c03006ab1d33d243b7cfe598a7a3c1baa
Author: Joanne Koong <joannekoong@fb.com>
Date:   Wed Oct 27 23:45:00 2021 +0000

    bpf: Add bloom filter map implementation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1543bd5c980000
start commit:   443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1743bd5c980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1343bd5c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=9459b5d7fab774cf182f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d86795180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143eff76180000

Reported-by: syzbot+9459b5d7fab774cf182f@syzkaller.appspotmail.com
Fixes: 9330986c0300 ("bpf: Add bloom filter map implementation")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

