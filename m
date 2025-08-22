Return-Path: <bpf+bounces-66320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CC6B324F6
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 00:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE21CB06224
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 22:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC642F0C56;
	Fri, 22 Aug 2025 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4yTXJxh4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5840523505F
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 22:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755901137; cv=none; b=ZCiWx0ddY9jkgiO8iGKYK43vtwRxj8Beqf774Tkhojyzd7fmh6e5XmZojnu7BgaeN2zkv5LRknm2+RSETzoDLwuJPHEjJEVgQCzoIg9EFCMnmV80T51ZJUwVbTEaCMvTKF8mryx83gEBDDw5LNwQgNtOqkYUNGrEWTAG/V2Sf98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755901137; c=relaxed/simple;
	bh=WRKfdTf+6dx6menaKtk6L+6QVIcFPTAKy1lGHA2eLgk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sZ3kzOZC9aZYHU2iY+lC9yOGoY4ZyQGKhXV9auJc0pwzIAfAlJZ8q/Elq1TMEQ5l1fOSSeIELX+zFAunn8KaohU0x6wqcccWAJKSu5fxNA8ESxOKP5wcjlkn+QQMQ749gBkBS48isreFBPqx3IgiYM0eKISxOvGOhxfqIfA8h7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4yTXJxh4; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b49c1c40e12so835875a12.3
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 15:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755901135; x=1756505935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jnoE+2KIOrxMmHLE80mPq4ihdeC2ql7TNzCz0bDr1kM=;
        b=4yTXJxh4A/D1uYZmtlFNzn1M26AQKnguhYNPTaaXmgXftoNUX04wamOxD08LnR7WTV
         dPPTjpd2nlfAW7pHnYI7OMPS+7i5YP4yPl1iaMaYPaTmfIsIqhBUnzbhFAK6BoBqtPND
         VhB6stAuwRtiIgoNQExaocqxYlHerkAXLJHF1WJU4VtjI7UMbn682PHLap/jqAR7B8+f
         jdf2i+UfzUCGENHnUWjJ0xXReGmBazSfO6rbJGyJ8VTBZ+qkmBmsTRu8n/KxNjTfAnQ3
         tuZDjM/ny59xIfnQ4d4c449gPCskAyk2PQ8Hwgn1qAEGQ2ztjuJlQeV8eCcUlas/JyYE
         5RHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755901135; x=1756505935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jnoE+2KIOrxMmHLE80mPq4ihdeC2ql7TNzCz0bDr1kM=;
        b=MnGOIXvYUq3Qziy4vVAF19wqgugSakfuOcIKWGOB0Ckz3bkufF2quA/AyZbMg1WjFU
         0CmnDJtKgRhhtlKyDS6nJrXrgXwm09arIVzojlUkRUxWtqX3HhHqm2NQi+NasmkibtMR
         7/HT4t7viTExNm8WhfEeYgdMJCmm72qxVXSz373UBnxAAksZ3WXHHkhLYNmaSYbuPVMw
         +5pLLzJDYp+VyDgQDp+0kOj+5gGCyei4coILwwoCghbfh6+SsOcsJq+kcUaN5VFMcbSn
         s/lwH7IcVz58vOuSIL+BbjKapoNVhySyPFDtZeHlrb0X+H8dHaXtxmyocNynJxts+TYv
         6vcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcKvz9k5pWjygF87PrqLKyJIOs1Roz0XjQ3+15jT0AvgZh+l40CLWBC0qllMHMPh4tU8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkVnqOeiWwvrtI9NUQP8+Yg+a3Q3yTXwq/2xL1+WS/K6BVUDIa
	OMACkuG+H1yLE6GDJW5HS/ZXt3og08g6uoQys99gEY2OCnvBZyWZBYzOnucVcnDLcWYVCQ3yudq
	753XIDQ==
X-Google-Smtp-Source: AGHT+IHb3wu/nQozE1W+K24i5H+qBWvG3lslX8qo3cGFshtCA6AwF/yPMQ2jgjjVbhTSV9sh9oV+yJBDuUM=
X-Received: from pjee11.prod.google.com ([2002:a17:90b:578b:b0:31f:37f:d381])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2585:b0:243:78a:82a3
 with SMTP id adf61e73a8af0-24340e4a4edmr6680164637.60.1755901135658; Fri, 22
 Aug 2025 15:18:55 -0700 (PDT)
Date: Fri, 22 Aug 2025 22:17:59 +0000
In-Reply-To: <20250822221846.744252-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822221846.744252-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822221846.744252-5-kuniyu@google.com>
Subject: [PATCH v1 bpf-next/net 4/8] bpftool: Support BPF_CGROUP_INET_SOCK_ACCEPT.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Let's support the new attach_type for cgroup prog to
hook in __inet_accept().

Now we can specify BPF_CGROUP_INET_SOCK_ACCEPT as
cgroup_inet_sock_accept:

  # bpftool cgroup attach /sys/fs/cgroup/test \
      cgroup_inet_sock_accept pinned /sys/fs/bpf/sk_memcg_accept

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/bpf/bpftool/cgroup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index 944ebe21a216..593dabcf1578 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -48,7 +48,8 @@ static const int cgroup_attach_types[] = {
 	BPF_CGROUP_SYSCTL,
 	BPF_CGROUP_GETSOCKOPT,
 	BPF_CGROUP_SETSOCKOPT,
-	BPF_LSM_CGROUP
+	BPF_LSM_CGROUP,
+	BPF_CGROUP_INET_SOCK_ACCEPT,
 };
 
 #define HELP_SPEC_ATTACH_FLAGS						\
@@ -68,7 +69,8 @@ static const int cgroup_attach_types[] = {
 	"                        cgroup_unix_sendmsg | cgroup_udp4_recvmsg |\n" \
 	"                        cgroup_udp6_recvmsg | cgroup_unix_recvmsg |\n" \
 	"                        cgroup_sysctl | cgroup_getsockopt |\n" \
-	"                        cgroup_setsockopt | cgroup_inet_sock_release }"
+	"                        cgroup_setsockopt | cgroup_inet_sock_release |\n" \
+	"                        cgroup_inet_sock_accept }"
 
 static unsigned int query_flags;
 static struct btf *btf_vmlinux;
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


