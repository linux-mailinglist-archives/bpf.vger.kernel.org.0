Return-Path: <bpf+bounces-37233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E8E95277A
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 03:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46AE1F225DC
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 01:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A95C6FBF;
	Thu, 15 Aug 2024 01:21:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED81317C9
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 01:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723684877; cv=none; b=TtAQQb8LV4dKxTGx+IwnMLXNMmbNL6YDfqFJNb8Zydcme8tstcHd3MYmLn3vj1aO7uWSN0JcDFX0ryJf9siuB4ukxIlGa0LIpFUErChwvfWdLFsqQFNbHSpObl0EK4zgsMLx1WFuk42P20WGLIUJ6mLQI0LpmCxMJbq6VnJe0DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723684877; c=relaxed/simple;
	bh=Hb3X4riTxNkNCGjBLuPrCPRcXoa2jIrWSholPAoh3Io=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YtBd2BNGp9oLtih5X9d3sn4wRv8tPpzD0rrQ/cFcMS71zte0VjSK8wUoT/dYaKvmQrKmHq2+WW1B5QxG8OK2eLYVOeaUKY8k8F9hvq9MY3WnqJWvzclll2WW4VW83ASlCUP21NH5QUViH/imMPea3oukiW6/o2+V8YFo0GwRmCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39b15a6bb6dso4614765ab.0
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 18:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723684874; x=1724289674;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hb3X4riTxNkNCGjBLuPrCPRcXoa2jIrWSholPAoh3Io=;
        b=vLqiUJFB+fpOR7LbX8GFG79ufExZ+1zuNFjLQ/VhzJdywCqNCvpdvQ8uMtmP8dVFgJ
         1g8Gdn1cwVtEzlwSsK7AJfNb52Fu5FYva/MjiszxmiwVtt1j8K2FhgcOQcTWEXooUBb2
         pNKck+r41+iepCxS6wZKnRaq2Ff0OBGEIlQEePmC9/lO9+feFmGh6fCp0Yrd72QM1Nzx
         bjDP6a1KJ1RJxSeqBCFfzI3nS/q8qT4SEygsQhDhki7RP/MQiFe57tom+8R2WOGfn29P
         RCSqZmX49t9jdnc4kKTI1j5ZtfixHWRSlPFjCUEiq04SaOsOzFn5fnRU4LTWL5/7dNbx
         1OSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLN1FeZbR3ijzz9pIze0J0xDzVdkj3bl9yRj7OfbX3E6ywGi4gC/7QL4WDLw7OXB3QEUT72dR2XseSSc+9kDxE6fW/
X-Gm-Message-State: AOJu0YzL+zTvdhNQFaGkhGC2QN/bxA+maJuq2CUNsAD6U77fRMrK2W4P
	KgQ7/vyn1LsiV8+NCEGLByATEDlPz0L8eDXALkX0VlbyFZMV9dIGjjIdQHJ3cQtjwslmH/UwMHg
	vy2h/AkTjABMnPCKC+O7BnoYinpoMZYmQpanMux2J2iRMCTmrDLaPBtU=
X-Google-Smtp-Source: AGHT+IE1L+cIMMAFHcc0Wx8kcH60VX5XGrnjTgUDbjMF+9tGU9/HcW1WoLcbwHPNqV8SKgFyweHjql3dcF+ilk3XSi+FpZYWPhcz
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2181:b0:39b:c00:85aa with SMTP id
 e9e14a558f8ab-39d1bd3bb90mr881145ab.0.1723684873954; Wed, 14 Aug 2024
 18:21:13 -0700 (PDT)
Date: Wed, 14 Aug 2024 18:21:13 -0700
In-Reply-To: <000000000000ac237d06179e3237@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009df8df061faea836@google.com>
Subject: Re: [syzbot] KASAN: slab-use-after-free Read in htab_map_alloc (2)
From: syzbot <syzbot+061f58eec3bde7ee8ffa@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	houtao@huaweicloud.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
net/sched: unregister lockdep keys in qdisc_create/qdisc_alloc

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=061f58eec3bde7ee8ffa

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos

