Return-Path: <bpf+bounces-37991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A42995D933
	for <lists+bpf@lfdr.de>; Sat, 24 Aug 2024 00:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B021F22810
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 22:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DD91C871D;
	Fri, 23 Aug 2024 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Mw96kH/O"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6071925AF
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 22:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724451651; cv=none; b=Tk69zd8PRgXYKt2Xz66QkME+C1PJrMTwjgM/691HbwkLF0j4nteNAPoYf5yrfQO0Na/8UAFP3JgBmPiCggPRtmjyGgJaO+EQLpq5q9rt3azj74P7MQYQ25CTfr3AkxlHw+w9c270WUHm2wMYIijjNPifSsbW98k5sBzLGE54jmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724451651; c=relaxed/simple;
	bh=g8clmXtu1A+OjsGICv10Jfz40Y++IxPCMFlutFN4/pY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SAuLvQhhx9xVvtbB1K+JQ27QlKom4PqIkkcWvCdzX9acaHRUYT1TrgW2VlBDL/A0QPvLIPFiH7NH1wuuyu/h+XnUi4RP2wUUclX9pxuNM8cOJQcNO+FDvR7gFTVufFsM19WAk5Z3ean723dYDfTciMYpyGYNR6cEV+EIYKAhsyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Mw96kH/O; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=QPqcBH63vTx5Qv60Uav2OublP18UzLcW5khhwtJMKiA=; b=Mw96kH/OwwnCIxmmhLG5HU0YRr
	AHDVVPS6oOjeE5NkV476J7quRigL5FPsytmrE5A1nIb+KSScY31350dFCEHRkQHvJ/K+IiGHAQfyx
	IlU1xoRDer0UZngb0hxdKg15bNYs6qT0mkj1DDje0HiWT6ASUjFDjXXtYSRAPGfBh8J1YTcH3kLgM
	3iBLXQqhP7lFSjW0qVkHo5BIttVq+VctdHPH5g8azHUwzcSsFcp/5gP+FHskG3qsJn/SyFJ0f2n2V
	Q6INwDiRRQRzzZCkgCACHn/n9uwyQdqMMBPZ2KpV+hxl4hVHIiSUu1Ll/TEdt5VNTgq3WwIi2COlE
	pB8zb74A==;
Received: from 23.248.197.178.dynamic.cust.swisscom.net ([178.197.248.23] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1shceF-000Fqk-19; Sat, 24 Aug 2024 00:20:46 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: kongln9170@gmail.com,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 2/4] bpf: Zero ARG_PTR_TO_{LONG,INT} | MEM_UNINIT args in case of error
Date: Sat, 24 Aug 2024 00:20:31 +0200
Message-Id: <20240823222033.31006-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240823222033.31006-1-daniel@iogearbox.net>
References: <20240823222033.31006-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27376/Fri Aug 23 10:47:45 2024)

For all non-tracing helpers which have ARG_PTR_TO_{LONG,INT} | MEM_UNINIT
input arguments, zero the value for the case of an error as otherwise it
could leak memory. For tracing, it is not needed given CAP_PERFMON can
already read all kernel memory anyway.

Fixes: 8a67f2de9b1d ("bpf: expose bpf_strtol and bpf_strtoul to all program types")
Fixes: d7a4cb9b6705 ("bpf: Introduce bpf_strtol and bpf_strtoul helpers")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/helpers.c | 2 ++
 kernel/bpf/syscall.c | 1 +
 net/core/filter.c    | 4 ++++
 3 files changed, 7 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 356a58aeb79b..20f6a2b7e708 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -522,6 +522,7 @@ BPF_CALL_4(bpf_strtol, const char *, buf, size_t, buf_len, u64, flags,
 	long long _res;
 	int err;
 
+	*res = 0;
 	err = __bpf_strtoll(buf, buf_len, flags, &_res);
 	if (err < 0)
 		return err;
@@ -548,6 +549,7 @@ BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
 	bool is_negative;
 	int err;
 
+	*res = 0;
 	err = __bpf_strtoull(buf, buf_len, flags, &_res, &is_negative);
 	if (err < 0)
 		return err;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6d5942a6f41f..f799179fd6c7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5932,6 +5932,7 @@ static const struct bpf_func_proto bpf_sys_close_proto = {
 
 BPF_CALL_4(bpf_kallsyms_lookup_name, const char *, name, int, name_sz, int, flags, u64 *, res)
 {
+	*res = 0;
 	if (flags)
 		return -EINVAL;
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 2ff210cb068c..a25c32da3d6c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6264,6 +6264,8 @@ BPF_CALL_5(bpf_skb_check_mtu, struct sk_buff *, skb,
 	int skb_len, dev_len;
 	int mtu;
 
+	*mtu_len = 0;
+
 	if (unlikely(flags & ~(BPF_MTU_CHK_SEGS)))
 		return -EINVAL;
 
@@ -6313,6 +6315,8 @@ BPF_CALL_5(bpf_xdp_check_mtu, struct xdp_buff *, xdp,
 	int ret = BPF_MTU_CHK_RET_SUCCESS;
 	int mtu, dev_len;
 
+	*mtu_len = 0;
+
 	/* XDP variant doesn't support multi-buffer segment check (yet) */
 	if (unlikely(flags))
 		return -EINVAL;
-- 
2.43.0


