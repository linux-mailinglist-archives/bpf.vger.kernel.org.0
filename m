Return-Path: <bpf+bounces-49284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536ABA167FA
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 09:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C03E3A1391
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 08:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C1F192B63;
	Mon, 20 Jan 2025 08:14:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4A31922DD
	for <bpf@vger.kernel.org>; Mon, 20 Jan 2025 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737360866; cv=none; b=R2DRjSqr4kDmdnOUQG4nvPyHiGn3vgGgommGgWYA0C5hPKMsmCE50gaKc9JB1KMzwo+eeI9eV6lK1e8vY+C1t3YHOvZv8S6iDHyJvRH4AuWX474zYoyM1r98t/e5uCOBLoEEB6Rv1wgfn+5JPh+Cl+0bTAKJXCzXUmXDpJ2yNcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737360866; c=relaxed/simple;
	bh=rijilFL+ZYNNw/g4mfwzD+YRZETcCV+OeEodGmwKpF4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HhEcySGoifP7iGg2UbAAg30VfvyN5pu49ooS4EJPeHZoA0ysq527Sa0DtXi1NMEzpVZxmLJc49QAosCDuaIEUlD9G2UClQxg7atWvU2ry+GDPUbkxycp9O7JzyQsjcKgTBhSdTTPa2OARFbZO+l5caNkXXKt1L3T5nz+pX2wXwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3cf6ceaccdbso30190215ab.1
        for <bpf@vger.kernel.org>; Mon, 20 Jan 2025 00:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737360864; x=1737965664;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qIUS6aIZNMol8udDe36zbnHvTyIM6OPrn2ah/Bnyz8Q=;
        b=pxQuT0fiDX+zGCfwAFD1zUess9N1Ks/m1QJT9xqd74HW+2r9WOJrn1Oty419x27hpP
         KLU4z0yxTelTT4j1bh9tqsDnhNlwl9ytBaR9zbuCkhAmUum3PM3iV1HoFfp1mdcv4YL9
         dEHGB02cOLt6ouEKFjgrIA8InyH2Xm59SIWGQmcP/N8vWXsYZg16HTqG8e2a7CGhXteB
         z8mi14OZJLflRRYg+k1Juci4ZlQXERerpXP9xJkY7q2RqeaTy5YH9VhNjn+qDwjMy8sd
         bisu37vIOZTESZFHhDdbHw9OWt66xya9TV4edovkezPU8Zyw0oOxU77Fv8enStTyl7g5
         3pnw==
X-Forwarded-Encrypted: i=1; AJvYcCVHNXFgyviEr3DZqCOJMlwN9iMP7KrFJ59dciD3NVa8I00dVI/vuBpxQq0a93fRIz65Rhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7aR1ty1/Sglv/wS2+DAxmWaf6N0B3fyDy4D9etWVKVrszAN9x
	MmoE8ufPhg1+jtpN91h3OoNt6jyMCgmmGmZkuvRNoQDwdT+Yg9QXGmI7Zqcyr62zu+B2gpXMReu
	NL40PG63cc83C03S3I7atSuHZWA44H+znI1xAELK/mw2f2YpT2e+lVyE=
X-Google-Smtp-Source: AGHT+IGy7RtPRgs8a7HeID79cIYvLytuO9yxFqElGrnZXnTU1fBKsrPhnwrhH3FxCs5jymKELqlEg2XeQIQhaGWjZYNYl8tD2u+C
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1989:b0:3ce:7e0b:3639 with SMTP id
 e9e14a558f8ab-3cf744bbcb7mr80802215ab.19.1737360863900; Mon, 20 Jan 2025
 00:14:23 -0800 (PST)
Date: Mon, 20 Jan 2025 00:14:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678e05df.050a0220.303755.006d.GAE@google.com>
Subject: [syzbot] Monthly bpf report (Jan 2025)
From: syzbot <syzbot+list2d8ac09ea19806ba1dec@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 1 new issues were detected and 0 were fixed.
In total, 37 issues are still open and 279 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  21432   Yes   possible deadlock in trie_delete_elem
                   https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
<2>  2116    Yes   WARNING in bpf_map_lookup_percpu_elem
                   https://syzkaller.appspot.com/bug?extid=dce5aae19ae4d6399986
<3>  1747    Yes   possible deadlock in __bpf_ringbuf_reserve
                   https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
<4>  417     Yes   UBSAN: array-index-out-of-bounds in bpf_prog_select_runtime
                   https://syzkaller.appspot.com/bug?extid=d2a2c639d03ac200a4f1
<5>  318     Yes   KMSAN: uninit-value in ___bpf_prog_run (4)
                   https://syzkaller.appspot.com/bug?extid=853242d9c9917165d791
<6>  224     Yes   INFO: rcu detected stall in sys_clone (8)
                   https://syzkaller.appspot.com/bug?extid=c4c6c3dc10cc96bcf723
<7>  169     Yes   possible deadlock in __queue_map_get
                   https://syzkaller.appspot.com/bug?extid=8bdfc2c53fb2b63e1871
<8>  72      Yes   INFO: rcu detected stall in sys_bpf (9)
                   https://syzkaller.appspot.com/bug?extid=4fe86fa6110c580ea1f5
<9>  62      Yes   possible deadlock in queue_stack_map_push_elem
                   https://syzkaller.appspot.com/bug?extid=252bc5c744d0bba917e1
<10> 50      Yes   possible deadlock in __stack_map_get
                   https://syzkaller.appspot.com/bug?extid=dddd99ae26c656485d89

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

