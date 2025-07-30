Return-Path: <bpf+bounces-64756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4349B16975
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 01:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD10018C7720
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 23:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A107A23C4FB;
	Wed, 30 Jul 2025 23:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="MCS6Mgj8"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23A823A993
	for <bpf@vger.kernel.org>; Wed, 30 Jul 2025 23:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753919265; cv=none; b=NgVafnYswQIv2Ig3HE3xLV5XXOAtc70d3ZFZiY1o2VL/kAyQaWBRYEprT/YpfTatZt6dDBfHqkSaXBT/XV0O6qU7V3AtBi+DzAhSiq4Nawp5hrEWJUi/BXgzOd2RoAS0iD1uppbESlnp1ZXdS3+T282g6VWUKkQ6iPOHaYhu5gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753919265; c=relaxed/simple;
	bh=QkYo5w2FDAhqeGytZ3n57e5O1HJcdaXWxi4YhWWsSfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pa6i04v36ng9SAgDuEXoqB4ODzn2ZY2Sm1VvKQkUDXcGjN8T3G0mw9+6QOHruKOFadNJEQI+tTsb7WKwL0Dc5ra7VWJlEzH2qYTpGch3A5m1DBT0yGFmV3FnCOS3H7dCy1psbRfPBK9YpgY75itYlQi4dgBeDetdespZPKU6CpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=MCS6Mgj8; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=jJyCnqLxuYt2NpMzZxCc65Zf0RIZLZaobXIPZzcBBkg=; b=MCS6Mgj8StaJ7B5MkvGJNy9pSC
	AeU0xpDtlAPditQrfRTCbzv+IRyKQlbxN8A/CMk5axm0XFldt/l8GxI+1awvJr0y73JkwSlpkBIn9
	vd1NCbMkyE4R8tVBuooedBALc9QuTkI2yuYJ0eXKLn3IYcgBXdAVewxjEa/ruLQB5AjNSswevpn/q
	d27MlHf1g9zJwepVOrnLOzWCG9UdlEkIZ6WKQmLx6bPdpnWY+csk057Xp8gi01UQKH4IL6RZCw65k
	5YiHd9iEc7rtXgn4EfLzmYTv5bpsOHwWrOqemMR06clOaOyYijG2lzDu8xnxdB08mm56UHbeUux7U
	dUgvWWVw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uhGWF-0008QU-1t;
	Thu, 31 Jul 2025 01:47:35 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf v2 3/4] bpf: Move cgroup iterator helpers to bpf.h
Date: Thu, 31 Jul 2025 01:47:32 +0200
Message-ID: <20250730234733.530041-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730234733.530041-1-daniel@iogearbox.net>
References: <20250730234733.530041-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27717/Wed Jul 30 18:34:37 2025)

Move them into bpf.h given we also need them in core code.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v1 -> v2:
  - Fixed kbuild bot for !CONFIG_CGROUP_BPF. Removing the
    defione for_each_cgroup_storage_type for this case I
    left for a future series.
  - Removed for_each_cgroup_storage_type_cond

 include/linux/bpf-cgroup.h |  5 -----
 include/linux/bpf.h        | 22 ++++++++++++++--------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 082ccd8ad96b..aedf573bdb42 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -77,9 +77,6 @@ to_cgroup_bpf_attach_type(enum bpf_attach_type attach_type)
 extern struct static_key_false cgroup_bpf_enabled_key[MAX_CGROUP_BPF_ATTACH_TYPE];
 #define cgroup_bpf_enabled(atype) static_branch_unlikely(&cgroup_bpf_enabled_key[atype])
 
-#define for_each_cgroup_storage_type(stype) \
-	for (stype = 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
-
 struct bpf_cgroup_storage_map;
 
 struct bpf_storage_buffer {
@@ -510,8 +507,6 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
 #define BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock, level, optname, optval, optlen, \
 				       kernel_optval) ({ 0; })
 
-#define for_each_cgroup_storage_type(stype) for (; false; )
-
 #endif /* CONFIG_CGROUP_BPF */
 
 #endif /* _BPF_CGROUP_H */
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a87646cc5398..02aa41e301a5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -208,6 +208,20 @@ enum btf_field_type {
 	BPF_RES_SPIN_LOCK = (1 << 12),
 };
 
+enum bpf_cgroup_storage_type {
+	BPF_CGROUP_STORAGE_SHARED,
+	BPF_CGROUP_STORAGE_PERCPU,
+	__BPF_CGROUP_STORAGE_MAX
+#define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
+};
+
+#ifdef CONFIG_CGROUP_BPF
+# define for_each_cgroup_storage_type(stype) \
+	for (stype = 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
+#else
+# define for_each_cgroup_storage_type(stype) for (; false; )
+#endif /* CONFIG_CGROUP_BPF */
+
 typedef void (*btf_dtor_kfunc_t)(void *);
 
 struct btf_field_kptr {
@@ -1085,14 +1099,6 @@ struct bpf_prog_offload {
 	u32			jited_len;
 };
 
-enum bpf_cgroup_storage_type {
-	BPF_CGROUP_STORAGE_SHARED,
-	BPF_CGROUP_STORAGE_PERCPU,
-	__BPF_CGROUP_STORAGE_MAX
-};
-
-#define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
-
 /* The longest tracepoint has 12 args.
  * See include/trace/bpf_probe.h
  */
-- 
2.43.0


