Return-Path: <bpf+bounces-40132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E3B97D5E3
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 14:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D7741C21090
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 12:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9409416F8E9;
	Fri, 20 Sep 2024 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U40cPoLM"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90711166F00
	for <bpf@vger.kernel.org>; Fri, 20 Sep 2024 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726837052; cv=none; b=peNdp1fI1a/xHEKcJ7NY+3l/DWaD5slYEL9JU9g2lhRx7TKrzWpvtdBmzYOMIV6FlmN7L+1j/Hhh+Srewubc2gXkwjtUmkdvMJhK1F5eQbdXJaO0VJf9pD2hC6dxxIjRd5FzWXypcpAl1blf4B4CcuXqpnfRIxW+otkWHWrtpCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726837052; c=relaxed/simple;
	bh=xKtYWOatAl4NW6Od9qmSBkopKZrvnS3lX/F7cz3KyHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jlsNLcw2eBxBKs3z3ZXxc6uuPrpiWH0sLH82M7hpG83xIAlBKxbnD7BPDuhHOug3vYHtr1OeIQ6oWOYE0+cpJuNoIHirJeX3rmjDsDfDCMk6vzCCInaCUSZ8Cnk4ixhwz1OTa0+2ytH6wkQNMaZd70AVvW2jRmNkPMEIEntFkAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U40cPoLM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726837049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6i/9M3LbVt71Tb/A7QJ4KQU38DN0T1TDp4hoySNoTi4=;
	b=U40cPoLM0J4QIhrLuabosPkvHFekUO/0861Mn2kkAEju58zCjX/px2+cW0Xd6NSYASrLfs
	USlVOz4m2WPbF6KUTa41C6TftQ1oaEJt61TNYjNsrw5DwRDPcssvQwFF9fHI7kpz7U4sj5
	9iYOQMTJmcJVB69ozqJ8yUbkNUPB+tQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-QeM37dOhMo6LiVpYr5bisw-1; Fri, 20 Sep 2024 08:57:28 -0400
X-MC-Unique: QeM37dOhMo6LiVpYr5bisw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb0b0514bso16332725e9.1
        for <bpf@vger.kernel.org>; Fri, 20 Sep 2024 05:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726837047; x=1727441847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6i/9M3LbVt71Tb/A7QJ4KQU38DN0T1TDp4hoySNoTi4=;
        b=kFkxiyp7w5/dQ7Vwxq+RCmnvz9DYpbg6ntQ6urIbdcran6KWNrGRfrHvPhD1OuRjsc
         x4uIFOErSraq/xtBmSC4Qse6g8uoeawex4fFA/77w2nNTcewPn636RR0Tu6Febp/A58c
         Iard/nu1WxOvdTisAW43s+VHnwIpWUXPYsgqDqZElKdHUje3w6x17MEDN04ANNpjoYzi
         HV2WqCjpG1cognJtqgd5qM17xBJXjyK1g9HDoTdhAVJDYEEDogG4SXrXTQpw1eZ0+G6J
         DIkV5GUUdCba4zclpczJynZNxDXJhNJ6+8GypqwShkmomI0vHMxs12nl4pBr6DuiDz/2
         c98A==
X-Forwarded-Encrypted: i=1; AJvYcCVyPbo6V8NuMOPTR2bSTS2Cq391jIMZKPhHCKNIaeJYSUHRvzZ6ES45ojw0EA1lKzJAjHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx51OsMGIrh/OCXDuYg8ZkDg6YvN8Mt6gldkRfoRO7XopybTRvs
	V+mScXe8uqcd1KVcwwmDpJoE1LJBsKxDNB30SYiqf4TIapE8otv0DwPR+2RKv3e5mEQbqONS4sK
	mLUti4KFwT3OZih0U3TW3xQGpvRbhsv0zHqJES4mXj0zYpHUOFA==
X-Received: by 2002:a05:600c:8718:b0:42c:b4f2:7c30 with SMTP id 5b1f17b1804b1-42e7c1a2e78mr17300425e9.23.1726837046747;
        Fri, 20 Sep 2024 05:57:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI14L31WVOCS238ru+pUtkvSQV/+o+7OZ8oLg0y8OhRSCpRsbneC4YG6z8S4WcNdbsfzoOIg==
X-Received: by 2002:a05:600c:8718:b0:42c:b4f2:7c30 with SMTP id 5b1f17b1804b1-42e7c1a2e78mr17300195e9.23.1726837046243;
        Fri, 20 Sep 2024 05:57:26 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7afa9fffsm22165745e9.19.2024.09.20.05.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:57:25 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8AFB0157F7E6; Fri, 20 Sep 2024 14:57:24 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Make sure internal and UAPI bpf_redirect flags don't overlap
Date: Fri, 20 Sep 2024 14:56:24 +0200
Message-ID: <20240920125625.59465-1-toke@redhat.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The bpf_redirect_info is shared between the SKB and XDP redirect paths,
and the two paths use the same numeric flag values in the ri->flags
field (specifically, BPF_F_BROADCAST == BPF_F_NEXTHOP). This means that
if skb bpf_redirect_neigh() is used with a non-NULL params argument and,
subsequently, an XDP redirect is performed using the same
bpf_redirect_info struct, the XDP path will get confused and end up
crashing, which syzbot managed to trigger.

With the stack-allocated bpf_redirect_info, the structure is no longer
shared between the SKB and XDP paths, so the crash doesn't happen
anymore. However, different code paths using identically-numbered flag
values in the same struct field still seems like a bit of a mess, so
this patch cleans that up by moving the flag definitions together and
redefining the three flags in BPF_F_REDIRECT_INTERNAL to not overlap
with the flags used for XDP. It also adds a BUILD_BUG_ON() check to make
sure the overlap is not re-introduced by mistake.

Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
Reported-by: syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cca39e6e84a367a7e6f6
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/uapi/linux/bpf.h | 14 ++++++--------
 net/core/filter.c        |  8 +++++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c3a5728db115..0c6154272ab3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6047,11 +6047,6 @@ enum {
 	BPF_F_MARK_ENFORCE		= (1ULL << 6),
 };
 
-/* BPF_FUNC_clone_redirect and BPF_FUNC_redirect flags. */
-enum {
-	BPF_F_INGRESS			= (1ULL << 0),
-};
-
 /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key flags. */
 enum {
 	BPF_F_TUNINFO_IPV6		= (1ULL << 0),
@@ -6198,11 +6193,14 @@ enum {
 	BPF_F_BPRM_SECUREEXEC	= (1ULL << 0),
 };
 
-/* Flags for bpf_redirect_map helper */
+/* Flags for bpf_redirect and bpf_redirect_map helpers */
 enum {
-	BPF_F_BROADCAST		= (1ULL << 3),
-	BPF_F_EXCLUDE_INGRESS	= (1ULL << 4),
+	BPF_F_INGRESS		= (1ULL << 0), /* used for skb path */
+	BPF_F_BROADCAST		= (1ULL << 3), /* used for XDP path */
+	BPF_F_EXCLUDE_INGRESS	= (1ULL << 4), /* used for XDP path */
 };
+#define BPF_F_REDIRECT_ALL_FLAGS (BPF_F_INGRESS | BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS)
+
 
 #define __bpf_md_ptr(type, name)	\
 union {					\
diff --git a/net/core/filter.c b/net/core/filter.c
index e4a4454df5f9..db99f2b38e06 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2437,9 +2437,9 @@ static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev,
 
 /* Internal, non-exposed redirect flags. */
 enum {
-	BPF_F_NEIGH	= (1ULL << 1),
-	BPF_F_PEER	= (1ULL << 2),
-	BPF_F_NEXTHOP	= (1ULL << 3),
+	BPF_F_NEIGH	= (1ULL << 16),
+	BPF_F_PEER	= (1ULL << 17),
+	BPF_F_NEXTHOP	= (1ULL << 18),
 #define BPF_F_REDIRECT_INTERNAL	(BPF_F_NEIGH | BPF_F_PEER | BPF_F_NEXTHOP)
 };
 
@@ -2449,6 +2449,8 @@ BPF_CALL_3(bpf_clone_redirect, struct sk_buff *, skb, u32, ifindex, u64, flags)
 	struct sk_buff *clone;
 	int ret;
 
+	BUILD_BUG_ON(BPF_F_REDIRECT_INTERNAL & BPF_F_REDIRECT_ALL_FLAGS);
+
 	if (unlikely(flags & (~(BPF_F_INGRESS) | BPF_F_REDIRECT_INTERNAL)))
 		return -EINVAL;
 
-- 
2.46.1


