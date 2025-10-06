Return-Path: <bpf+bounces-70427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D57CBBED0D
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 19:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4812C189AD53
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 17:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E33B242D6F;
	Mon,  6 Oct 2025 17:29:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D86323DEB6
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771770; cv=none; b=BvAiCnwZkr2l6bWG/sJUZfMcra3A83iYKTr09H3NfBD1NaNWWgZQW1vmNheu16zguuy7vS4eo1bm5Nw3yicNdjlCVWsXFlfAq/YD1Qrkk5O6y6rPgxFFREu+ajSfZ+3CGrYe9xeLfIE7YRh35ioekiK9M8+/5zkZYYx86L9XO/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771770; c=relaxed/simple;
	bh=zfF5Y1cuSPI/0dS88HshIX312NnBKI+qL/5DV/5Zbvk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=a8JGPNIUV4c8/8xCzyXA+CzClaBZ08YcAoMTtK5GYYAjmoNMR6rtLUv0f67JLVT+T5fAHUkGc+9cHDlml5Bq2asDwt0L2fzaj3CwbaWceiaGO9UeFcEwIUISJ0XqGip0BgBlCuqjejh13F9LfXHPRKTQL0UxjDRFN1/6A0RG+ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-937ce715b90so829532939f.0
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 10:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759771768; x=1760376568;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JtZ7l+4G5TqwPduOga1v8+pfIPQWKka/VP/HuA+PbFs=;
        b=LL0FeDp/naCEm+MB6I2ryQQhtYLcmmXYEKmOl4855bxq0E2EVmypNqQq7UojF4Yu7H
         BLArPiUzQhLEkcpzneo5otDtuY1TbDecYSNiEucQPLR4YEeIZnmLZnWcTn5yvE5YsCXF
         0vsQAfo3x/A0o8X51CNS7DI4VRtd1Y7Vl4BXvc2FqLpT7MBbvBexw3WUqXx3RezgHp2F
         WTNl5s0zowEtwXmufN8Y+bWXdTXdvrnx4UnSde/vQ7CKAYZ6cOqC+4oBwVH7SCmANHEh
         fQEmGAOzfMog3URUQyoIvl8GjJIQJZ2iR2FqWL5oXHkU8ufsq8ohWHsxUad3ED/r5QKO
         lWMA==
X-Forwarded-Encrypted: i=1; AJvYcCWTHb+LGmg1/P5nzCcnKLSmQHZ3CfNkvTUqa/R8c1tG0Y0YC90p3v8aKImWcFtoXCXioEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1UzIK1L8cb61Rk9X8R4fPwhATuAIHxckNBXHxtNzq7deIfFtJ
	As9ipd3W28O+2FTsdFru8ztessgDgPdyLQiIVk51jItBwKeyCrPQsURfvIy22AzUSjpY+HBESay
	GZVwE5AMP4rtuNFmEPO0Mj/8e8EOgRNicnpoDZe7lMW3DYJDhyncf4LDcATg=
X-Google-Smtp-Source: AGHT+IGAUYXGlB/TJLXmXsOvvgpl1iMQ0LxAQP1Mdzz0SQFccF2KS1hFKnDWC5b6DL3Ki4KdA/HwXgqDwIDr9/RrTAbR4IzWQWYy
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b46:b0:425:7788:871 with SMTP id
 e9e14a558f8ab-42f7c3b2589mr5433545ab.12.1759771767780; Mon, 06 Oct 2025
 10:29:27 -0700 (PDT)
Date: Mon, 06 Oct 2025 10:29:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e3fc77.a70a0220.160221.0005.GAE@google.com>
Subject: [syzbot] Monthly bpf report (Oct 2025)
From: syzbot <syzbot+listbab5e5abece11c828361@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 2 new issues were detected and 3 were fixed.
In total, 23 issues are still open and 309 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3880    Yes   WARNING in reg_bounds_sanity_check (2)
                  https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
<2> 984     Yes   WARNING in trace_suspend_resume
                  https://syzkaller.appspot.com/bug?extid=99d4fec338b62b703891
<3> 94      No    INFO: task hung in dev_map_free (3)
                  https://syzkaller.appspot.com/bug?extid=9bb2e1829da8582dcffa
<4> 45      Yes   BUG: sleeping function called from invalid context in sock_map_delete_elem
                  https://syzkaller.appspot.com/bug?extid=1f1fbecb9413cdbfbef8
<5> 36      Yes   general protection fault in __pcpu_freelist_pop
                  https://syzkaller.appspot.com/bug?extid=331f5bebb641724ff1f0
<6> 18      No    KCSAN: data-race in __htab_map_lookup_elem / bpf_lru_pop_free
                  https://syzkaller.appspot.com/bug?extid=ad4661d6ca888ce7fe11
<7> 4       No    WARNING in sock_hash_delete_elem (2)
                  https://syzkaller.appspot.com/bug?extid=ca62aaf39105978cd946
<8> 2       No    possible deadlock in xdp_umem_pin_pages
                  https://syzkaller.appspot.com/bug?extid=1b607ee7794bdba65be7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

