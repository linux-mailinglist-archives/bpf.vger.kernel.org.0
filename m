Return-Path: <bpf+bounces-78925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A8CD1FA28
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 16:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23D3330C5C9C
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 15:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5632D2D661C;
	Wed, 14 Jan 2026 15:06:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC8C3043DC
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768403169; cv=none; b=DJDI3ihPmdRrGRM5cr+SoPFMYGCbxPiqZQkfxXtKA45AWVEZNdURezbEITR5M5ipK8HHWF/yaLbI37PTKSuElXQIvNptEvJ/TkypRqN42x8ezdmCpga5bx4+61KFxNESUj4iyOJCzYEO363CIQAp6zEhDt00jHpd7TG9R4pPxrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768403169; c=relaxed/simple;
	bh=2sYsLTjY8UlCSBPDwENuCkzbU8UFYUoZD+Fn10iJNUg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s9AYCHTr5JsfiN7wCOwekyrxJ1ZO5yG+54qvpZe2Fc/nRguDFJsbwZ6jdC6c3EwY5JwNQC+iv1l1Gjn8VSo3Mf8WtJ3svDO8IwAFsU4Br8xAR99I4Lww9/H/7o5Fl2fYr2+0tuKFZx01irXu4aDoY6nsWA1G/V2MwRRJcrQIfQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7ce5218a735so26863033a34.3
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 07:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768403162; x=1769007962;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OMy1y+B9WdDKj6nr6FkI9x1yhWM1Ih1Ofb/HIEBve50=;
        b=I5SSE+adSycc+vOePEn4jdpkbT+P9mJJl9GYMrlqJwVsb/jXN8K76tIfwtiP+uaNYc
         4fpgJS2Yol3r/0EYnCuxn/6tCpUKrt1uE6U31rz6L2kuS7YpDVMC1zTR/mEsn26HCVxg
         WWATvg7J1IsAx1TV0I8V86FFKJU+bVnprpd3zhCAmo8AxfhYu8ZqSy3THMNG6krhxiNt
         BncLKycc57wcHT2SJkiuQX9+MQ6kXCWksfq5C1Nd5Dvc1Gthkd/SOXDAIbfUAXOncOs9
         X/ivn0SXvhHNXy5U6WlZpTCQKNA7OJ061hMPCrqDeugNBiGVIyNSwbmJ94ID5tVHKNJr
         ywHg==
X-Forwarded-Encrypted: i=1; AJvYcCVXau6tycgeC4NymOsb0aXZtXtL7VyxWrl3DQn8Wq+t8jIz2yiEt8n27g50fmvobXhRGCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/bauBSeixn1WIr5/m81jwBwSo1rOa3ifTmUyX4ZaTXs1POh5/
	4tC2ua5kbNM9ewvEegQSjA9MpIXb7JFwc8fV/fBjEJj3QwlLQktDLoMRYLkkMfIJ4m4eSqtZpeG
	IajcP9YvPO0lIyO1B42ol3Xu0+oA7+4sI6N7L30Ptc/VT1xFSat8g6TOCju0=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1508:b0:659:9a49:9081 with SMTP id
 006d021491bc7-6610097d19fmr2203064eaf.76.1768403162431; Wed, 14 Jan 2026
 07:06:02 -0800 (PST)
Date: Wed, 14 Jan 2026 07:06:02 -0800
In-Reply-To: <20260114135643.17484-1-sohammetha01@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6967b0da.050a0220.150504.0003.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in bpf_prog_test_run_skb
From: syzbot <syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, sdf@fomichev.me, shuah@kernel.org, 
	sohammetha01@gmail.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Tested-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com

Tested on:

commit:         c537e12d Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12188522580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46b5f80a6e7aaa5c
dashboard link: https://syzkaller.appspot.com/bug?extid=619b9ef527f510a57cfc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15f21d9a580000

Note: testing is done by a robot and is best-effort only.

