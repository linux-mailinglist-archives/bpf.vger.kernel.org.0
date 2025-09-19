Return-Path: <bpf+bounces-68937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ACDB8A3A1
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 17:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC055A0D23
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 15:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC3A3164C1;
	Fri, 19 Sep 2025 15:13:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B6E253B64
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294794; cv=none; b=GU1Z4TtajxG9FUqtTyj9eDllWO8zZ+1GBujCPIP6Utpp6ww4d1CaQfNWDVepqsXwMcXAKVVOXw30o792GnDNzhvbal4xBMt0BW2RPMZI3n2NxZBv+DKFAhdGE7dZzY7fSan9rdBSKzSRJjjKeColGJKd/EeKrefv9zzMbJqlWuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294794; c=relaxed/simple;
	bh=Tt+hRZooDzLpwPZoAJVDMSCHMuIqNfWoy/TUKxU2GfQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Kke2QLslH/ng0ULZQIE+g2MahLMfHKGPY5wODefdexrrPy0FTFbR7aPEw76/Novvws27m8ezObg8S1RrmgI9oJ1KiMAZ8cQaXR/BmrD6xZ0xL6g8cDwxxfGW8YFUWGGeLKl/02sc1FUcDbj93PqkIuirC+YY41m6t7YKvEdHQI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4241c41110eso47690865ab.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 08:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758294792; x=1758899592;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pdVbcA7nmK1fnCSLRQe6g3pMqB2Icbe7/rxf0Y74n4I=;
        b=Q4dIz8duMJpLGEzVXe+lt4XKVd2bVeZkLGAkoiupkUNo5eZWPG4K0Zx6TNa64hiIdw
         mP1EMAPFaoHpqGdFsGglYM18WuPuMKulO5Pmg40XoXMljrsH9ylHpeKO9Kl8jYJUNrFQ
         FI4osuLzOnWd83r2a2RbMG6FCxql9oJA/L1BlZUy54NHuddflHikhZvlVRZRmSOVuqyu
         HBtOw5likv4zc9VvQMNPxNrtLM2LnUR+A9E9TcwOlYBuUaETlt8ESb8VmlT35fyb6z9y
         JiTtVbwuf5E0cegPVUzZqE26qNm7A8NH2ZYYzpk93scYXFIIVkR2hy8/mqBwsbV7ev0F
         LBBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi85XyJvy+TKXy8uXLUr7WQ/EZD3BmBL7VO92unH75H5ry/DqYb8OH5IbH7w0GWQryVPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+xLrADDGIRt+xaaAW1eYYBaEVeXDrFDhshWriq1HmHZd/ydBu
	cX4n+FIV66n4fT4EdV60mwmarTfdR9v0zDqqMC1dL4e7J11JMRVhtVMym8MArDUdebx96lnz8aT
	02WxclVbtsWTWEdTm7NEg+yAh6gTk3Ck3DvMMIqozamZs8VrXGPwEHdheOW8=
X-Google-Smtp-Source: AGHT+IFIiUlKXGs3lu1PngiLaqqMui66INNfwYaJjXTuOGZYLDGxFw6Uuh2OsxLvLi27v0agrmaVGMRQIFpMuFzN864d8ZGPIRLk
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8d:b0:423:fb73:315f with SMTP id
 e9e14a558f8ab-424818f7ff9mr62320655ab.6.1758294784388; Fri, 19 Sep 2025
 08:13:04 -0700 (PDT)
Date: Fri, 19 Sep 2025 08:13:04 -0700
In-Reply-To: <aM1moP0fr7GrlbWZ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cd7300.050a0220.13cd81.0000.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in do_check (2)
From: syzbot <syzbot+e1fa4a4a9361f2f3bbd6@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, paul.chaignon@gmail.com, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e1fa4a4a9361f2f3bbd6@syzkaller.appspotmail.com
Tested-by: syzbot+e1fa4a4a9361f2f3bbd6@syzkaller.appspotmail.com

Tested on:

commit:         a3c73d62 bpf: dont report verifier bug for missing bpf..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13928d04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=e1fa4a4a9361f2f3bbd6
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

