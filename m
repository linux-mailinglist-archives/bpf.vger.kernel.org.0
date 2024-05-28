Return-Path: <bpf+bounces-30747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE768D1E08
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 16:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A671F224DB
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 14:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D9716F838;
	Tue, 28 May 2024 14:10:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB57516F834
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905406; cv=none; b=spFcMTAUKTVXvvEXa7E3okv0p8CoPJOuKUtDk2eUoN5iMefi0yS2SqCp1H7MoJb4q3oSkG967xpHNf7EuwN1zsVr96OuxN2aVdoZZXSYFJJ8xziw6vsAbWDuH9BZ3ooa4kDNwiR34ED+SCqRCAfvg8hw2IP+0dzJltges7wDyMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905406; c=relaxed/simple;
	bh=h/gURcyiroXERc30tAsjPBSZVuF3pg0jAqJbgtbiT0k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nt8Y91yabYxZHp5mBzptNoce/APV+FXZBlPhEMK09RCXbIS+rOnQ8EbLuMPCHhx7vVw5joZRfDwvyoGmbPYyM8MHzYcnFe+jjRwreC6FHFHFCfqJE2tWX9WUVt5+rweTTL/DnKA79qHqev2r0AET4L0y6OZButBIRiMcBi6dOYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3746147204eso9297775ab.3
        for <bpf@vger.kernel.org>; Tue, 28 May 2024 07:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716905404; x=1717510204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WelPM0YOgva6j7b8RyCxFfD+qVIUmvNqXXrqPoDhdgY=;
        b=uFkb2H9QgV6aDvUG+RYBTSo438fWyWx1wiu6rgMI9YoGUmisTGLY7PL6LhU0f9M7Yp
         UNPGxpJLBYMEELYBHVN7DGO1n+kjvKZ0mfd+BXaja7TnONZ2G+cDfADzrtJyfSljcoW5
         aLOfPnu344AH5BQgfnPXnVhIjcTUlPfN2q+CPJpxwOO29QYWhaFfqF2WBMPYWIfYqhrS
         og5sNVhNMWVFF3EX1ir8pfptejaRl3itWCKppizkoe7t7i0k2cxUQqYUbbC2arBz9A5j
         TaEiQZ06LtlAVlwibOiviySdewZ2SazCOE40nl9sswoY6EuiZOuvfSU8auszudlhG9Qm
         OvKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaxRAwszrCTx43D1ZtxA5bXy9rKE79PT7H2BYDfH2Kmu49Vp8PZSExYJcyBfS6GYggVfMqyKOpanqZXR6Y3FIBsPRp
X-Gm-Message-State: AOJu0YzL2/KT4m26pT8VnZNmJiGoid/J2H8+z7j5aT/abdQdHPNgLGYa
	Oe25gwcCeXMWR4cDkPra9/3H2b9pJ9Eo3Fe0T+o0N0RX3RlmqdPr214Yj2UbcVS+Y2qttnT13fz
	m+2FJLHvjrIkFK/qubcr1FSl6ocDJ+RmS8Um8bkZmFpE9BKd2b9qBOeE=
X-Google-Smtp-Source: AGHT+IGYxSLRdYdSIj6V1X50DGPsuaMd0GZg6XGsMCIH/LkK6jYr0HVeJzFN9W0DOKbFyaxhbmGnpo9uLKXYNy7mw6IEfD9syljH
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2188:b0:374:491c:654a with SMTP id
 e9e14a558f8ab-374491c6dd3mr3454075ab.1.1716905404172; Tue, 28 May 2024
 07:10:04 -0700 (PDT)
Date: Tue, 28 May 2024 07:10:04 -0700
In-Reply-To: <0000000000004fa7ab061966d1b3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba9d9b06198430d3@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in __lock_task_sighand (3)
From: syzbot <syzbot+f2ed7d5888894fedf676@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	clang-built-linux@googlegroups.com, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kafai@fb.com, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	mingo@redhat.com, nathan@kernel.org, ndesaulniers@google.com, 
	netdev@vger.kernel.org, rostedt@goodmis.org, sdf@google.com, song@kernel.org, 
	songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit fbd94c7afcf99c9f3b1ba1168657ecc428eb2c8d
Author: Alexei Starovoitov <ast@kernel.org>
Date:   Wed Dec 1 18:10:28 2021 +0000

    bpf: Pass a set of bpf_core_relo-s to prog_load command.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149b9a2c980000
start commit:   30a92c9e3d6b openvswitch: Set the skbuff pkt_type for prop..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=169b9a2c980000
console output: https://syzkaller.appspot.com/x/log.txt?x=129b9a2c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17ffd15f654c98ba
dashboard link: https://syzkaller.appspot.com/bug?extid=f2ed7d5888894fedf676
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c203f0980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12046634980000

Reported-by: syzbot+f2ed7d5888894fedf676@syzkaller.appspotmail.com
Fixes: fbd94c7afcf9 ("bpf: Pass a set of bpf_core_relo-s to prog_load command.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

