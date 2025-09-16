Return-Path: <bpf+bounces-68488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 373C1B59346
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 12:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 298357A197E
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 10:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B3B3019BE;
	Tue, 16 Sep 2025 10:20:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD1225334B
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018005; cv=none; b=BnRSKqUi4SD1wyLZebvVK8IjMTM9b9GlO+WFfn4gmuniUMQxKtvkPzSamYT3oL9xtbppN174KGtsKyxANPkMP+bJP6PQOi78fsVmH6pkHlvP1X2ID6N4ESxe49LYZNVDz5xfmIE6Bx5iMxAEEfB4N6voO2dEK8sV8zGkZUGAKSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018005; c=relaxed/simple;
	bh=9wep2Xa4yem/ncItvnA6XXzOYC3HhI5y4ziWijFwdgU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RoiOjQbzErQfzJUNYPBPvIvXRu/GgNdmhcKahaXaRI6V1n4PS6+GbVzmaFOACkH13sA05y5CE3csFSLa+SrtbtBmReMf5AxHQdhxs/45H5ByjRC+GPy7oLcTKEzx/cfSxZ5mnW+mXfe4vOCxfu0Fa842WAwRoIvKGO6cB3F1NVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42351e83862so99760725ab.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 03:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758018003; x=1758622803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7c8JkY/GUid1YMVZeWpRbyf0waDEIgonB/zzS7yfMNw=;
        b=fSdFpoHtNz6UilddSNTcocytEksNtGOZV5/T6Eo9TQk7Op5P9DCxcOWDHsPsoXDl8/
         4i1Gv0vmnzC7lmE1YNFyhMGEoCiEuUhSlqSyCl2v0foAipu6AXX3Mw8VzuOhpz6qOV41
         qZAXTJO1ei+mJGcT5TvjB8CnhkppOZWU97d1PuInU4bTXevWes56GvdRIJh0EnOK00Vx
         pqQ/9AK/McsAjz+RmpTI0P+pcGFWj/lqOxtPAQGc7FiCuWW0TqJZhGWW48Z+IRS2QkT7
         7i3cIpI0s+QcSPUztJRVDwb8MU7jws47WMZb1CafRHGN1gAQ+YKAqtXhnWDWHe82ifDn
         fd8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsinZDX3EJOATy21tWYBPfVXLV+Ym07BpzcFE6E0GRqMovZKh5GsRPDZMJiuMsjQxQhOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3NpK6ro+02e3T80a6+aIc+6m6BveQOC0z+NsacL5JbjvzILUL
	pfyq0h7k7ET/oovghuMP/bOXf4YoK1LwVcQTZ7dl8NMElkoPJ2tWlQ/u6YSDFbnqVVg26h6Svh4
	0l681kDEvrdkPDkHq0m5KZIftroU3MsDI4FdR9sUvDTsCpmVdTdbHmFf19VU=
X-Google-Smtp-Source: AGHT+IHPb9dEa2aqys8zPKvutWnrsQsrWSVi/yzmuvFOPlooaZ1Ez4wiwgVNLuay0xMubCLH4nZZGpwr6y9njmTYwk3bpmgPVIbY
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c6:b0:424:30f:8e7c with SMTP id
 e9e14a558f8ab-424030f912amr81143825ab.10.1758018003674; Tue, 16 Sep 2025
 03:20:03 -0700 (PDT)
Date: Tue, 16 Sep 2025 03:20:03 -0700
In-Reply-To: <68c85acd.050a0220.2ff435.03a4.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c939d3.050a0220.2ff435.03c1.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in maybe_exit_scc
From: syzbot <syzbot+3afc814e8df1af64b653@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	henriette.herzog@rub.de, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, luis.gerhorst@fau.de, 
	martin.lau@linux.dev, memxor@gmail.com, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d6f1c85f22534d2d9fea9b32645da19c91ebe7d2
Author: Luis Gerhorst <luis.gerhorst@fau.de>
Date:   Tue Jun 3 21:24:28 2025 +0000

    bpf: Fall back to nospec for Spectre v1

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17753762580000
start commit:   f83ec76bf285 Linux 6.17-rc6
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14f53762580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10f53762580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=3afc814e8df1af64b653
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104a947c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14467b62580000

Reported-by: syzbot+3afc814e8df1af64b653@syzkaller.appspotmail.com
Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

