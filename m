Return-Path: <bpf+bounces-22232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217E2859787
	for <lists+bpf@lfdr.de>; Sun, 18 Feb 2024 16:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2188A1C20B98
	for <lists+bpf@lfdr.de>; Sun, 18 Feb 2024 15:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EA26BFDB;
	Sun, 18 Feb 2024 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKue6+Ks"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C1F6BFA5
	for <bpf@vger.kernel.org>; Sun, 18 Feb 2024 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708268989; cv=none; b=NgrozmYOBNAymfN/rzvoaJL2ZhZp4FOkrWcpwGdXIiWxpqp/10b6wmOa2g7LtPFxzPDSjNeyDgkJCMvxOqFTPaaTfdb6LXydLIxThHKlrUhDme22kdyp8tEdnbyXK5J7NEO0p6nWix0NqgNGWEXO26zbTgfGClTiM128FSmqjq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708268989; c=relaxed/simple;
	bh=P/XamzW0k9s56aZD49kwH+EPycwY+7egqwFjukjRjaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AITJhG5oB/PgyAuybu3EQ3+5/sSXgH53er2nPQcF/lZ4OdM0LLIwm59R385/YcFisKxxBiqWGVURSt3WfIeOA43MVuzg6rtc3D2wl22ZU+EYNI1DVGOtsl/R6r5ecGbkL2i4KSd3XgobHRfwdUAaB9b6zRSwyd2eDwVmkDl5TRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKue6+Ks; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708268986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bwoL5JJuhSW+kyiPUR3qQ3qzkCkjo9wXmM88MH4kw4I=;
	b=RKue6+KszBQq1Lgkg7b3/rNTxyUDJ7PsvHSoeIA7NMCLqh8pDhtA0nR5c+bzP9msU4GSeI
	4L/06/o4iAUIpwUaZg2uEAdKbiaZu2tcPeLa3UF7HdaXDYJDYZCyfWaMxUk3xs8eSwRWzi
	Oq7SAQ2PONKxZWlUEiWCs64PDAK8Qp0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-sMN0JPSnMtqEqqKB84U07g-1; Sun, 18 Feb 2024 10:09:44 -0500
X-MC-Unique: sMN0JPSnMtqEqqKB84U07g-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5cf35636346so2743823a12.3
        for <bpf@vger.kernel.org>; Sun, 18 Feb 2024 07:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708268983; x=1708873783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bwoL5JJuhSW+kyiPUR3qQ3qzkCkjo9wXmM88MH4kw4I=;
        b=pa99zx4A3jINGD9JYEjfoLjB8Kzwv+RyrB0d2almuLFW2XsPLwElPblw8Ac/wSTZEj
         vIseuR0Wt3Iqgsjl7vGuVIbPANorEHlhxodJq5Kn+Hn06XNyXj3kATGMg92RkvBsPzJs
         Wm8bAUd1J+zmnhmqCWOIVk/wsUwv2fHb8lNjFiti7lx9+w2BYTYTR8l4WCKG85Ekp48B
         XwXuwoLwtOqkRW+qLRhwrlon65J0bwpihcxG9hD3zUSJdQhB2GSi5y+Ze6XUS2ERetZt
         JOFvx4b7vN5w/w4zDYeOBn4HhcCfi48r7DIHOcyCuq42EhfaOV8H1z6M5o7JOvLYsjuC
         o12w==
X-Forwarded-Encrypted: i=1; AJvYcCVZ0tO4IPst1CryEwHVJeqROz5MHKqit3i8O54XS+SwfeqE8Bq26g8xA02f/+MZqAK7LIIhBhSxKPUVVDl1g9E3XdRd
X-Gm-Message-State: AOJu0YzVGM8uJSSdGT0p8ewhu/y9fbnIVlJWtJH+QBnuOrsvhwH5BMo8
	ke3B00eKzQfEKaa1wSwf9CZxFBqIXvd3jj4nGi4jwmjkvucVcvNSMo6dt7GSmwWGxefYIXwFrkB
	qKQuwzkKatNsAR+NIXXv7mjrZJKiIZfACwU4BT1TXbJK9W1BzgQ==
X-Received: by 2002:a17:90a:4dce:b0:299:3f5d:b5e8 with SMTP id r14-20020a17090a4dce00b002993f5db5e8mr3512999pjl.20.1708268983029;
        Sun, 18 Feb 2024 07:09:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWB+1HQKH3/cx4XDOVkxwc253bedsLJk+TmwcSSZJ1ojNUMxpmP+dQC/vu/lwyZiKwv8B7sQ==
X-Received: by 2002:a17:90a:4dce:b0:299:3f5d:b5e8 with SMTP id r14-20020a17090a4dce00b002993f5db5e8mr3512975pjl.20.1708268982585;
        Sun, 18 Feb 2024 07:09:42 -0800 (PST)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:6883:65ff:fe1c:cf69])
        by smtp.gmail.com with ESMTPSA id nb11-20020a17090b35cb00b0029658c7bd53sm3479311pjb.5.2024.02.18.07.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 07:09:42 -0800 (PST)
From: Shigeru Yoshida <syoshida@redhat.com>
To: john.fastabend@gmail.com,
	jakub@cloudflare.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>,
	syzbot+fd7b34375c1c8ce29c93@syzkaller.appspotmail.com
Subject: [PATCH bpf] bpf, sockmap: Fix NULL pointer dereference in sk_psock_verdict_data_ready()
Date: Mon, 19 Feb 2024 00:09:33 +0900
Message-ID: <20240218150933.6004-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported the following NULL pointer dereference issue [1]:

BUG: kernel NULL pointer dereference, address: 0000000000000000
...
RIP: 0010:0x0
...
Call Trace:
 <TASK>
 sk_psock_verdict_data_ready+0x232/0x340 net/core/skmsg.c:1230
 unix_stream_sendmsg+0x9b4/0x1230 net/unix/af_unix.c:2293
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

If sk_psock_verdict_data_ready() and sk_psock_stop_verdict() are called
concurrently, psock->saved_data_ready can be NULL, causing the above issue.

This patch fixes this issue by calling the appropriate data ready function
using the sk_psock_data_ready() helper and protecting it from concurrency
with sk->sk_callback_lock.

Fixes: 6df7f764cd3c ("bpf, sockmap: Wake up polling after data copy")
Reported-and-tested-by: syzbot+fd7b34375c1c8ce29c93@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fd7b34375c1c8ce29c93 [1]
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/core/skmsg.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 93ecfceac1bc..4d75ef9d24bf 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1226,8 +1226,11 @@ static void sk_psock_verdict_data_ready(struct sock *sk)
 
 		rcu_read_lock();
 		psock = sk_psock(sk);
-		if (psock)
-			psock->saved_data_ready(sk);
+		if (psock) {
+			read_lock_bh(&sk->sk_callback_lock);
+			sk_psock_data_ready(sk, psock);
+			read_unlock_bh(&sk->sk_callback_lock);
+		}
 		rcu_read_unlock();
 	}
 }
-- 
2.43.0


