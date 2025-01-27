Return-Path: <bpf+bounces-49861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 107BCA1D981
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 16:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E911165F9D
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 15:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FB413D24D;
	Mon, 27 Jan 2025 15:31:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37656747F
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737991865; cv=none; b=H2nNLvQOM6ivd0MFChRmp0fKHr474bqrO7kE4cP+d8kyJgdrpuVCrJ0QVlwbjAIfj4ISml8ra7BbyFygWcQ4sY5MSh8d7oIQtcnuTNhkfjCXz9ZNOLOMLa+BvTdNNvhGNdYvXrIdZvr9ZcV3rdC0yZXtAULhsZFe+XlQrC06etU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737991865; c=relaxed/simple;
	bh=pk0falugNVXW9YaSYAKN1kLbELC3pSSmtTENQHaRLYc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DePmig7xWYQzwZPD12p3r8K8sbYfROzBehVDJm8eUhN3qMW6BRHcoNPAODiUx4NBB46NyF+sxfkQtiAXQNiYUqTw281w8XD8kmWbvao5/i7k0PcPEBqIMzuwi5l6SWqFyTYuEd1lfuhvY1M6Db6p3LzQ/2m8lTF17XWlZv98370=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-844dadd9bdcso695299339f.2
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 07:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737991863; x=1738596663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTNYafEybL4lXeY2S2Qmsrv13OQGCeTdEc6zMRGI760=;
        b=ECwpxA05B/HOsW0J/qQvm7Yt7+brZ0/c7hdfCGpJLGLfmTGBAzYHf2/A9WE9TUd/qD
         gbWYuwl+fsY4DJqtRC2takbw15y5nV4Nv0ZEMLJahk3Sr61bcDnoInwj11sw5NRpEY8B
         ZIGj+TReQKSRbYGSv58fhoKabEKnmHIzZmb+TelJyjp3k/wxeXVlBXf8U1feyxpH33BJ
         SLJ0RRNIUnZ08aXkGnWQKIW1yxBz0Lh8/a5D/MQKgzHq6rKmJpyUOEFQP+AamdsKrIq4
         GlAkL7JiO+/oMZlmjESQLLCmyFPCEtEx0pTseGQt1Xx+EhCw0YDwBfPHyHcpzyyDdxrt
         5TQg==
X-Forwarded-Encrypted: i=1; AJvYcCVjCeK86AcSAj9BfjBqjYDjdgQxzulgGTBRimQXO12fu4FebuDpkeG8uWLFeXA7QTw1icw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4JmEf1ycgxyLiFRsxERmWYBQtwRpANfm1x+X4SpkyeKD1mz4z
	okhlf3eC+THRyM72HIsIC8id+AF4r4670tvtZidVM/ncWSlupFkRtXCngBU3/hwXot0fhMC4OGq
	xvGQDK5REflydyJOq7IwHmGzcrWBa1uHzmVttq46ZHH7IAd6LI6jLvQc=
X-Google-Smtp-Source: AGHT+IF0k5Aqucvj2ffNiCSgdgQE4Eik8GYb/V1Y57DZpMfTifsnu9wpqZCJNhjDBi3HTM+7rzOrPAIeuRSdWD4dQZM8q6G+xIjV
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4c:b0:3a7:e86a:e803 with SMTP id
 e9e14a558f8ab-3cf743f8834mr360037455ab.8.1737991863199; Mon, 27 Jan 2025
 07:31:03 -0800 (PST)
Date: Mon, 27 Jan 2025 07:31:03 -0800
In-Reply-To: <67555b72.050a0220.2477f.0026.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6797a6b7.050a0220.ac840.01cd.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_umount (3)
From: syzbot <syzbot+1ec0f904ba50d06110b1@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bigeasy@linutronix.de, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, edumazet@google.com, haoluo@google.com, jiri@resnulli.us, 
	john.fastabend@gmail.com, jolsa@kernel.org, kerneljasonxing@gmail.com, 
	kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d15121be7485655129101f3960ae6add40204463
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Mon May 8 06:17:44 2023 +0000

    Revert "softirq: Let ksoftirqd do its job"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1066f9f8580000
start commit:   feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1266f9f8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1466f9f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=1ec0f904ba50d06110b1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c060f8580000

Reported-by: syzbot+1ec0f904ba50d06110b1@syzkaller.appspotmail.com
Fixes: d15121be7485 ("Revert "softirq: Let ksoftirqd do its job"")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

