Return-Path: <bpf+bounces-26294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C9689DD79
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 17:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C90B1F21ABB
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 15:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C2A1304AB;
	Tue,  9 Apr 2024 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wCxTkCOw"
X-Original-To: bpf@vger.kernel.org
Received: from out203-205-221-247.mail.qq.com (out203-205-221-247.mail.qq.com [203.205.221.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847412D210;
	Tue,  9 Apr 2024 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674829; cv=none; b=j+HDub4TSI38HKwcPtqwseT9Z4kD8XWK0MNyqUfiBjkoq4D3WoQ+acS6eQXgPtTasu0bS8OvsbVYHadh00Dw3EtMWRaLjyktWzabmVaVxCRGgwQAQwAFo74CqvIVhfAqM43BfUYVeUrhDVgDuHqi1DC4IEY0HBxrsskHA17v11Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674829; c=relaxed/simple;
	bh=YB//Tq6wM/z9gKF0PBPXJVyM/iHmWsiSPKvVappUl5c=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=aG3psfr0x7G3He1Rqo7TXYQ9BG2Q+EPP0L5A23a9OIp1/y7VeAamwi1JbsstIZMng2yFoEP7hjIvbeJZw2C2aHsargshOc1KvIRXeOoN4Gv5O6h2a6V5pFpE4idFUWx/320HLJg67ig5G57m45W7h6YaU++xKH+/KyY24gipEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=wCxTkCOw; arc=none smtp.client-ip=203.205.221.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712674823; bh=vEWu+zKNuvca7K9GIraXbCpF0vuCLymzA/DWW38bFQc=;
	h=From:To:Cc:Subject:Date;
	b=wCxTkCOwTt7hpXDKLSjwpmoOyaIq7OfYo/mu0YyeTAxfDxb6DYmTSXDOSnzIpiItd
	 35lhOFUpiG7jUIUuvZAOSralpNLb5y90o/Nwcz0bE73ephW8WPjKo0CgZY81dRlct+
	 o0SIwZNjCEfzHT5IGRuXA7JSpE3N8DO8Hql11uxE=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 138A83D; Tue, 09 Apr 2024 23:00:19 +0800
X-QQ-mid: xmsmtpt1712674819tuzuqrsdf
Message-ID: <tencent_2325B98DEC12765D8CDDF9996BCFD78DAA07@qq.com>
X-QQ-XMAILINFO: MvM61XSVXCtDdv1SITtT8hAktV/o6o2zYsSdURuOE1QbOLls3zYWW1azlMUrm2
	 SqLKHU0ww4xFUuH7y9UNa2sJtXJlV/YJ6hs/eVJgCqJnUihW8D39DqxU4WCWQmJmw5g4XrJc30Qv
	 9miTMG27sSxjF3kFGwx4lUk7r8Phua5oHSZaaam6j/M5aabDT3nJ8tFj0REloDSYgXqFWjHCjR09
	 70FvzDMCxX8gRdd2DY64GRzm6U1VzTD9m5rfuSLl0IB6uKTsAuyTxfiV1OC4cz9kO1Yy7dJkLj/a
	 O5IWDxVVhylIJAeZSbhAcjN9jP6yyOMhJDNAa+/bH7+GKgcqeX1QHdFzO4z4CSh45AP0T/ZQSnGt
	 CGUIxE0LvRDKVs+ljw2NsqR/GqugI6PyufvFYV3liKzG02X8nuCaw3jSCFMwE5R9WLtmXQp7jInX
	 63tR1W6WkDq2G55xSPsuDaqW2urIQX6Ozish561B+SD9c7H1BWK4Qs78cg9Zan3bdq4nMfdvjk5r
	 FO8kT0SPM7Pgl/rbvL7AQU90fK+2yCzN41JIUpUtUnTiJH4V4Nh+0FFsyCZIaQdxmJqkKKc7nxVN
	 LULCYL8pa2nil/pCDii0cnIB73hYCZgU1THK5cYXl+I6WvJu+9viw/quMsrvOE1losG9G52rplyK
	 vjJvJru5kJOCiy8Z2kR08OvvHf2OjbH1RSsLW95TzoQdy7wXj6eZjPm656grWUO5qVi3K1BjTwUP
	 YuSnVl1ZuxxNtPGODJvndKfr20nPbWIEnTn31M0pDVWnrqzA+J+wnMyYb+InmmzRslzHmGlz1W/Y
	 5F7OxN8nAkcqHEzIOj+fGkxZ4v7xLFtQLW4jdoYsNT41VahDhOmDQY8unI4PBfy51oQCxNaIvQIi
	 jczRKa8OA5Y6rtD8hdjyoqUwwl+bnYtWm3OpRd6QN6BVy0MeSom8BzOrjEcxV2MYyX026hqh8MKG
	 aV4R5lWXuPYd3GEVJs0w==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: netdev@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@google.com,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: [PATCH] netfilter: x_tables: fix incorrect parameter length before call copy_from_sockptr
Date: Tue,  9 Apr 2024 23:00:20 +0800
X-OQ-MSGID: <20240409150019.95430-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If len < sizeof(tmp) it will trigger oob, so take the min of them.

Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/ipv4/netfilter/arp_tables.c | 4 ++--
 net/ipv4/netfilter/ip_tables.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index 2407066b0fec..dc9166b48069 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -956,7 +956,7 @@ static int do_replace(struct net *net, sockptr_t arg, unsigned int len)
 	void *loc_cpu_entry;
 	struct arpt_entry *iter;
 
-	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) != 0)
+	if (copy_from_sockptr(&tmp, arg, min_t(unsigned int, sizeof(tmp), len)) != 0)
 		return -EFAULT;
 
 	/* overflow check */
@@ -1254,7 +1254,7 @@ static int compat_do_replace(struct net *net, sockptr_t arg, unsigned int len)
 	void *loc_cpu_entry;
 	struct arpt_entry *iter;
 
-	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) != 0)
+	if (copy_from_sockptr(&tmp, arg, min_t(unsigned int, sizeof(tmp), len)) != 0)
 		return -EFAULT;
 
 	/* overflow check */
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index 7da1df4997d0..94a0afd8f94f 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -1108,7 +1108,7 @@ do_replace(struct net *net, sockptr_t arg, unsigned int len)
 	void *loc_cpu_entry;
 	struct ipt_entry *iter;
 
-	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) != 0)
+	if (copy_from_sockptr(&tmp, arg, min_t(unsigned int, sizeof(tmp), len)) != 0)
 		return -EFAULT;
 
 	/* overflow check */
@@ -1492,7 +1492,7 @@ compat_do_replace(struct net *net, sockptr_t arg, unsigned int len)
 	void *loc_cpu_entry;
 	struct ipt_entry *iter;
 
-	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) != 0)
+	if (copy_from_sockptr(&tmp, arg, min_t(unsigned int, sizeof(tmp), len)) != 0)
 		return -EFAULT;
 
 	/* overflow check */
-- 
2.43.0


