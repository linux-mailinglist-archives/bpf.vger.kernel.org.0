Return-Path: <bpf+bounces-34996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7796934AD4
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 11:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F6D1C2177E
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 09:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D04A81ADA;
	Thu, 18 Jul 2024 09:25:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DDE78C7E
	for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721294705; cv=none; b=J9JhnzkMkaI3DDL06VdbpTnJxeHycnGcVJ8Z4ZgNZEfTSBoF0ZDWkudYgYlrteQIx8P1ubMApT8Az/K+vqdQVvlCzeGGxgRjh00Z7MDyR2Eu4I617YXQhVsV4VYj6r1zRgwLrHXjmYlMtw8UMF4AASA2+QvKjfF2hUpX4Qsl+6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721294705; c=relaxed/simple;
	bh=EAUinRQviMvDujUv3R7ipwJOCnMA9iLRBAFx+AvKvtg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NKIF0GpxepEW111tI8VHp/2bSovxQWMZQpF56rwgBxVAA3VfBLWoxtURWWlkWeTEHDbW8ykneRfiOWa1Vfaq5k+dZ5jZHeLdKv7ldAG/Ctkh915mM7c/271I25qhS+rUsamXz5q3W0CpnjBIzjKrsjaqXM2Q6aYT68NwfXLAxJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-396c41de481so7318675ab.3
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 02:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721294703; x=1721899503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rGyXWRLrvwl7ym9gYBnNhfugsOfnDeqOLsViPL9q/g=;
        b=EX17dvuQXheFpNj0Xgwvzk2bnjOzh87Ob1/pBEp4uNN69n+7pckeqiTLrY2hFfwug5
         MR3e1B3Ii1JmQSfpUefaW1a/T+O/Uq++WC7S/r3j/lSH8j29+0uXHbq5PkHadtO8kqI4
         7Qofd91pZgyMjhJRaOuAikIK6r5Qul/HA0i41LffC7yuALpbj8unIfIxuYeO68zahQgK
         2LCI2/Fz/CVVxAbBqhyaCTEWdwaAvka4eFbqU5Uz5pVLjXj39oI+ZsUfJ4Dgd03i05vR
         bnPUpvnx29JQoAz8hlv8NQsyLvGD7m8VDcijkTVlrWueTlV+mVgvvnw/Oh7F2nh/YRr/
         orvw==
X-Forwarded-Encrypted: i=1; AJvYcCUpEV4ySKymNwd/8d62AmAHiweTqL87PXT2hVp4USO3N/yuvFyNeYPsStTKIROOd01jMU1O3ws3I3xm7oTvQBHr9hPb
X-Gm-Message-State: AOJu0YywK2i9aH888n6k2yk47OqkyYWD7M90c9r1/p9KZTtUDmXj6iIB
	ipvm5fB/DApu24sadrUXjA3iTKylSzth1fwYSubBiNOqnb1NNj5l3P8g/0sw83awBfH9ZPvpr2s
	b7UH7YBNdoP2vhJ7vHRQ/rcd8AxtaSpsdszxVSuo7NkkoPymPXQxeUT4=
X-Google-Smtp-Source: AGHT+IGz25YUIa6vXqL1eZi/FObkUR9B/7QK8k4uQaFLAqvDLyFpspVztyFv/qtJeUG6Z3FXvnmr+ma8VvHFLQjQ3qYbN6/6uMgQ
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a46:b0:374:9a34:a0a with SMTP id
 e9e14a558f8ab-395594e4481mr3546915ab.6.1721294702813; Thu, 18 Jul 2024
 02:25:02 -0700 (PDT)
Date: Thu, 18 Jul 2024 02:25:02 -0700
In-Reply-To: <000000000000233ab00613f17f99@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050b78b061d822720@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in sock_map_delete_elem
From: syzbot <syzbot+4ac2fe2b496abca8fa4b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 98e948fb60d41447fd8d2d0c3b8637fc6b6dc26d
Author: Jakub Sitnicki <jakub@cloudflare.com>
Date:   Mon May 27 11:20:07 2024 +0000

    bpf: Allow delete from sockmap/sockhash only if update is allowed

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15df62b5980000
start commit:   4c639b6a7b9d selftests: net: move amt to socat for better ..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d14c12b661fb43
dashboard link: https://syzkaller.appspot.com/bug?extid=4ac2fe2b496abca8fa4b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153e3f70980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174ac5d4980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: Allow delete from sockmap/sockhash only if update is allowed

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

