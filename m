Return-Path: <bpf+bounces-66319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1D6B324F5
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 00:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84490B060FD
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 22:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D563D2737E6;
	Fri, 22 Aug 2025 22:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zvxnjKIA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0E2E1746
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755901136; cv=none; b=ibQWUqr7l0o19azCCoJD2fglOOW8ZRwIqoyPYGDMMypXxQCbvE5287DRyzUB0m90EtDceN1sPBvwSdkdIKYJs6yRlFALGsCANTIgosYTpoJHF2E7KY7guLTZMubcrd5CDEmTjWF7ASUigzcah/f/4JXgFNpIfYDTpXgj5Ii0x8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755901136; c=relaxed/simple;
	bh=vwqzxXb6W4+3iqCH4HEXSm2pR+SuIJSyFYqxWwsLeGk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T9ORqqsXyYlsGq3pQea02xc+YMCbkS5GrAL5Bj7osNWPW9soxNbpKsynEjh3vOLv8izU5lrTY34DZX/IUyWMjFHlDZm0UaS+r65vGX3szrfoGmklB0CxqsecUJF0f829OHKtm1kSkhE7n48/GvWjq6vFY93oIZX5luIHZHGbrgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zvxnjKIA; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2e614e73so2378751b3a.0
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 15:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755901134; x=1756505934; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YdqNho3WZWy1o9u7F3Bg+dpDZy13SHvOwk7OwFTgz+A=;
        b=zvxnjKIAhZjTZaeBMds2f2xkhnt+6v8RFEP3cwJEzJ/pPr9yAIV2N5GXajyyuGYDMn
         NhoExe+aJoYQekiUpGFKq0GzhvmSJZR5UC8PCwfJswldgVbiA/yNrhxlPWpkMBYQ8KsW
         Zoxs3U7qeFWDIOuBEhy6VR7jH5d0jRun+2PDZReJmoTTcLtLvnRgLohoUwewhLv7G39X
         ZOrlj5uIwEMPutJen95xZUb0g3ezLC017jQQyVvi9mMsoBUgWDwazNkybh+o8EjU5Sxb
         8nzgqkPs7rDYQ+4VsBWfdnnuCa94vcBFUDlGtVhBZKeD4GwhoCloDRnS+N/e/SGQOd+f
         gaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755901134; x=1756505934;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YdqNho3WZWy1o9u7F3Bg+dpDZy13SHvOwk7OwFTgz+A=;
        b=fS/b4oqhoCeVGd6jVytN/zUJxNWaBZP3765c5Kl4LwpS2oe3dCH8N1E5J57rmMSRTL
         hYyt9no18USBYBRkMqv2PrGBeq0AhUo65AoG0nYL0PHJiY5vNAcLIj3HmowkzuVyes1Q
         1ld45eQ43mRijY3eS6YUKpigJ+mYpi/UqQnvCcbrBJPu+AQncvOrzNBwU9Ku7tnmbNWA
         uqqrgAPYXIpSMSvv1f+AhnEMK/9Txxr812ndszc3Sc1MxvvnhU9OvPIWbLE7FA7L40cX
         l8p0m/C7ST7qlx1QZnKJvyWgj1XdMWnG5eNB4IzihWZ9RfsgaRAjuGso2d5HZmqLW07T
         XaLw==
X-Forwarded-Encrypted: i=1; AJvYcCU336MXEUXO+wryQ+3qgNnNLrolPsJsUknEHhv24PHUZf1iAxwoTgwl26tuHadt0fzAgkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCc/O4Crvd7NTUZn2KHWE3az8jVfdPtMjJC4EU8USvOlxp+tIG
	zLps8rsdIMHCAihVp2Z0T0e0VDSDcc3qja+WtIp5bbFbgvy08RQtwm1UQbI/PR1nQ/4zZGnJyfy
	Qr6V9gw==
X-Google-Smtp-Source: AGHT+IGjLcQea0Xozb/2Oek3QT5JPG9SBjjfjDiJrxogJhh+9VOCkCa4FmkHN/HmvxPBOAC5e+OJlA0YJxE=
X-Received: from pfbkx5.prod.google.com ([2002:a05:6a00:6f05:b0:76e:6c25:8d0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9a5:b0:74c:efae:fd8f
 with SMTP id d2e1a72fcca58-7702fab4322mr6295424b3a.15.1755901134156; Fri, 22
 Aug 2025 15:18:54 -0700 (PDT)
Date: Fri, 22 Aug 2025 22:17:58 +0000
In-Reply-To: <20250822221846.744252-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822221846.744252-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822221846.744252-4-kuniyu@google.com>
Subject: [PATCH v1 bpf-next/net 3/8] libbpf: Support BPF_CGROUP_INET_SOCK_ACCEPT.
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

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/lib/bpf/libbpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8f5a81b672e1..c1b28a3e6d6f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -81,6 +81,7 @@ static const char * const attach_type_name[] = {
 	[BPF_CGROUP_INET_INGRESS]	= "cgroup_inet_ingress",
 	[BPF_CGROUP_INET_EGRESS]	= "cgroup_inet_egress",
 	[BPF_CGROUP_INET_SOCK_CREATE]	= "cgroup_inet_sock_create",
+	[BPF_CGROUP_INET_SOCK_ACCEPT]	= "cgroup_inet_sock_accept",
 	[BPF_CGROUP_INET_SOCK_RELEASE]	= "cgroup_inet_sock_release",
 	[BPF_CGROUP_SOCK_OPS]		= "cgroup_sock_ops",
 	[BPF_CGROUP_DEVICE]		= "cgroup_device",
@@ -9584,6 +9585,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("cgroup_skb/egress",	CGROUP_SKB, BPF_CGROUP_INET_EGRESS, SEC_ATTACHABLE_OPT),
 	SEC_DEF("cgroup/skb",		CGROUP_SKB, 0, SEC_NONE),
 	SEC_DEF("cgroup/sock_create",	CGROUP_SOCK, BPF_CGROUP_INET_SOCK_CREATE, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/sock_accept",	CGROUP_SOCK, BPF_CGROUP_INET_SOCK_ACCEPT, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/sock_release",	CGROUP_SOCK, BPF_CGROUP_INET_SOCK_RELEASE, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/sock",		CGROUP_SOCK, BPF_CGROUP_INET_SOCK_CREATE, SEC_ATTACHABLE_OPT),
 	SEC_DEF("cgroup/post_bind4",	CGROUP_SOCK, BPF_CGROUP_INET4_POST_BIND, SEC_ATTACHABLE),
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


