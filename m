Return-Path: <bpf+bounces-79434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D347ED3A2AF
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 10:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0FE230550D1
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 09:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B2B352953;
	Mon, 19 Jan 2026 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+8dSBwM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF69354AED
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814196; cv=none; b=fwrlofguGoMrqE3/J5eFWIARzz/MGFym50vG2lEESS98nYGLCwNsVv1sbC8B6pnk9fbd5zhiUIwC8RcoLK/HP36lffnuDx6IAOKt4M9T6Y6w0AZwlFohDZfLYQQOD9/HyT/HBrpjtvdxEOtLUY9bIegIVAYJ4CF4lN2a8RRRejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814196; c=relaxed/simple;
	bh=q23gHidx8498gkMO0yerRKpzSoSAJw6ifeIuU1lw1IA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NnwggKJuU0v6vjH7eHzSjm/m7A1drQo4RYoLdC81Ikwz4DzQzRif+WdxvlhVcNQfp/wcA8+jH3vKuL3gbcagLqiUbvbFIopR//o+tyMbIKV/QQWDgXNPwquk/hgwCHd358QKCtg3PRRMS6ysIDBpWqgTnIj3Zc5nFcTCtWtwXx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+8dSBwM; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1233bc1117fso2549716c88.0
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768814194; x=1769418994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uIo8Sy0N2c9CqC2cXQ6iQPPYdQiGFGtp7sbsHVq8k5c=;
        b=P+8dSBwM1TRHVF4dPEWQ1x2i9wRqLgau5eb8doAJRcbFaANnLVUowArPtN+t5cnxFT
         Zca2U6Ru3UkCLqrrcbQXCSQU+SJeYH47y70IRTMFtBbcMVyRoDvMN5aL1HXoK/UwZb21
         icc1jgLRtNeZYQDonilf036vPc2bHLV6VlildpPUn/65r6TLqRWCEZjJaqvRI2sXjibP
         AqYjrCbLRMcAH5q1Im65ywRv63On0sgIpnKkTC8f5BNb3sJY+gX4e6XERZDkIsgXWZGe
         nCF4De1DRtU2RVTsVz4j/8l4p+HoiObklic0pmgR7aCbSPosNVaKHcHBE/ysM8iSdhpl
         x9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768814194; x=1769418994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIo8Sy0N2c9CqC2cXQ6iQPPYdQiGFGtp7sbsHVq8k5c=;
        b=gtmAjlPO8Uk8myclgrdcDLe67IrkA3SqnxzYYyE0gSPm0w8tglnqo6w/imgFdvshDw
         0YYgUnE+wEyNLKLj8XqY2sFrexCkCP/kRe5X1MmWDYUMy9nKvKEJwPp7/E/u2RAXQZzf
         zRIVjsFZbNogTJP1l3jqV+2gqDL1Dnv9Xf1bi8tXnELrxsexnzAsocUEZ5VsIatqQBco
         7mVFIEwVi3e4J9rhgTReIz3K5HBmUt8b+iX/uPSHyMev9P+0rINUSMTetU4uNkYnuPik
         vexa5nEiSeQ4s1bbGzbVdNqLICxv5uXPh1Nnu1s+g8mPsYfz0p0e3+cqtp3lCFnM2NQF
         JzMA==
X-Forwarded-Encrypted: i=1; AJvYcCVNAJUy+uSs8F3wINf02Tlt+ca4KKVEj5yoF6cDPUpmQUvNBSEa7I3zLGSflGpOxatQKRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSJgpt5CXqDC0aRY74m60vtdfw7DP+sFNPTMfWR6B71awo12ux
	GtrneJ2cKsUwAkc4Rnqak/oXG4KgMhM68x6I5SNrL9o9EcqLxc0dXDJO
X-Gm-Gg: AY/fxX5v2f8BAzwicMb38hA1Bh4O8F6BEnG3m7MPw4OGYTBvFhk7NtmhpbZO9WGJX2x
	pxNNGoVa3uqX201r2pmq1wzrLQDn5op+h64b/NBwwBvkym1Mduy1vCOTin2mET+3K3fG7/GsfCQ
	BXYslLASfTNBSsJ6DzAhM7NVmT/5Ablx1LrwLpEK42lEs1QmhqQwHAh06ane+/zkPP9Lq7Iucki
	oQVpnPbXC1megpUjYXsKlX581FDY18OmZTrt/dIOqoLbNd0extYWbsMd894y0Y+dLUbfL0RLAuI
	qn/qT40Pyy0xG4LPABuyRlCrtVWDLKlIr98iO2l3A4EMS5LoIgv2ptwqEvrUbisdnyqNlq+FgJX
	YAHbtoVHKBh0ZC2m6dpmdnLBXi6afxBS8xtzgUj4Sk0vKxeUs7jYY9vvnob8THFq+pfVyBkPbmC
	CvxlTzZJ+yuL9Q5hdujY0FXSfOnF7OP8fDLHfULtPPLkSCAdpyNM3qnQ+A3Kn6JHppafn4ce6vE
	vpKoz00Pw==
X-Received: by 2002:a05:7022:e98d:b0:11b:3eb7:f9d7 with SMTP id a92af1059eb24-1233d0adc11mr11817904c88.14.1768814193959;
        Mon, 19 Jan 2026 01:16:33 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefa7c5sm15578577c88.10.2026.01.19.01.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:16:33 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: fw@strlen.de
Cc: pablo@netfilter.org,
	phil@nwl.cc,
	daniel@iogearbox.net,
	ast@kernel.org,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH] netfilter: nf_flow_table_bpf: add prototype for bpf_xdp_flow_lookup()
Date: Mon, 19 Jan 2026 17:16:15 +0800
Message-ID: <20260119091615.1880992-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sparse reports:

  netfilter/nf_flow_table_bpf.c:58:45:
    symbol 'bpf_xdp_flow_lookup' was not declared. Should it be static?

bpf_xdp_flow_lookup() is exported as a __bpf_kfunc and must remain
non-static. Add a forward declaration to provide an explicit prototype
, only to silence the sparse warning.

No functional change intended.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 net/netfilter/nf_flow_table_bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_flow_table_bpf.c b/net/netfilter/nf_flow_table_bpf.c
index 4a5f5195f2d2..a129e0ee5e81 100644
--- a/net/netfilter/nf_flow_table_bpf.c
+++ b/net/netfilter/nf_flow_table_bpf.c
@@ -31,6 +31,9 @@ __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in nf_flow_table BTF");
 
 __bpf_kfunc_start_defs();
+__bpf_kfunc struct flow_offload_tuple_rhash *
+bpf_xdp_flow_lookup(struct xdp_md *ctx, struct bpf_fib_lookup *fib_tuple,
+		    struct bpf_flowtable_opts *opts, u32 opts_len);
 
 static struct flow_offload_tuple_rhash *
 bpf_xdp_flow_tuple_lookup(struct net_device *dev,
-- 
2.43.0


