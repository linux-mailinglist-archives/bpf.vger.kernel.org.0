Return-Path: <bpf+bounces-54065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62CCA619C5
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 19:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C03F3AAD12
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 18:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EE0204C32;
	Fri, 14 Mar 2025 18:47:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83503204C1B
	for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 18:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741978027; cv=none; b=mVdTJWNq8JrrpAFVyeGI674BhSFvbGpCs5QoOlx2smTJM124hhEUX0SQwoKJu2ipZZMOOt46tkK0Jb8I64H8R3cVD6Hv4+hHSZXtMggQn1yHrqLEC7wFWTDl3Q/37JzWDrIaqcJDkthLe2ptwIJ04ciibnV3lQknm5AtUNZAEWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741978027; c=relaxed/simple;
	bh=lP+WWwLeJcNl+xjynrFw4AUeIaxg2oLzPxAdObxBxnM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gGIjtaAGRV+Ai11jYTRISHcabLHrmGJG5USh5uIz5bq+plmcXLCWHr3mjIId6BhBrMgqJ6FJmph1BRlc9cftsE0Unw2UW1cljAmWNWXCwWbgR79EqbBAB2yFw8MJDXLUryPxwrDQcPDoqp+G10UFximw5rD22wijuHl/gx7sesE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d43b460962so48787315ab.2
        for <bpf@vger.kernel.org>; Fri, 14 Mar 2025 11:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741978024; x=1742582824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NxkXkYDWiW2oVyldkemU8ucECoqqgSoeCvPEsiTtUu0=;
        b=aPpCUYLYvnxLDOaRtKZ5gdrcFxduB1L+E5x6MfldMjXcocRBtZGE863CDan+wuYqiE
         VRqP+1A1kN5ZidFaaMsNoqOePC/8TmwpGNvjYl//KtRzFXqCqKVF/h7zNoiqRBbg7nCg
         CEnlPIIksIaAFBS0WmZyONBUXng+FB8ihLKoWHzlF1S88MmQMtXKHmzXBFZY08+GBj/U
         twWfmmozhyZLEuWiDl36BVclByKIdbWN2Wo1zDm54c8nnSXsBAmxBJcEk1OdMn5YL4KI
         qSE/3CqYfxI2OB6Rt3ZdYwYQS/yAeSYMF5e7oOkAkB8g7dFh5HoePTaf+QCN7i2eiQ2V
         qsWw==
X-Forwarded-Encrypted: i=1; AJvYcCVvkmAPHLXrQfMVElos7/2FKkz6sLVIfdUEbunp/xLUZ+VOz9Xlx5HGeE7ogQhYbxkahRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWjrHTFErC7yL3EvqDxEiCAEXYRfKdeZJqOgcOxsvmF1Xv3GSi
	Wo/n+cmOkFR+TLmgnKNkxaNGR+8rSmjCDwiIzMpb0rj2d+GKpnXtEScF99g9HEBkqtbb0GXNMR/
	0ZjIP9qkU3Lx7+FrgXbTd3W2VNWAeIDxCL7HLUUc7UMWTuCFXo1oa54A=
X-Google-Smtp-Source: AGHT+IF2NJDjExuIXbMXWH2xKdFFik4mQ2Cbteg2XeWs+t07tMq6LOwOI/VHD7UEdRzJmzYoxxADQlr9bGDqb7kO3gZfuHYRjCMG
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3b88:b0:3d4:337f:121b with SMTP id
 e9e14a558f8ab-3d483a0afbbmr35023375ab.8.1741978024613; Fri, 14 Mar 2025
 11:47:04 -0700 (PDT)
Date: Fri, 14 Mar 2025 11:47:04 -0700
In-Reply-To: <20250314181925.69459-1-enjuk@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d479a8.050a0220.1939a6.004e.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Read in atomic_ptr_type_ok
From: syzbot <syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, enjuk@amazon.com, haoluo@google.com, 
	iii@linux.ibm.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yepeilin@google.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com
Tested-by: syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com

Tested on:

commit:         2d7597d6 selftests/bpf: Fix sockopt selftest failure o..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=126c419b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=a5964227adc0f904549c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10ecb874580000

Note: testing is done by a robot and is best-effort only.

