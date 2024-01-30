Return-Path: <bpf+bounces-20768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F0E842CFF
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 20:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C410628BB54
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 19:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B6A69DE4;
	Tue, 30 Jan 2024 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcTJXWdG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFE569974
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 19:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643421; cv=none; b=BcXpD92nMx4Hk52JMcfpN7INYs107j8WMJYKQo0lg/Ix34APp2kDjlUzcQWAJpFkZH604Ctt28DwwlPfmvpFKe3mm4PGQnOIUj7gyKSfSXGhrY51/4Ihy3xXGvPgna/UJOoYvQU+qfJLodLP7Jp6IYSC2rM8pxTd762b9XuxQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643421; c=relaxed/simple;
	bh=rftYcHmlmMv34x7ss8O92q4W1IC5dTwHXDosWC6JSvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iAi66N1lf5GJ40sXhZQ1qb1dMl/Pm9QhmZ1xDTgsI/8equ8sSZUnvWDpDHbAHMPR5ZBmhvslgb6CkK+sUR4iQ14KLupNhROMCxV/2dy13cWWix7xo282KrfknGGezPoF0aCcWDleIJl4xGllq6Ktn3r+gIHeqpY7PfinzON2ccg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcTJXWdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0189BC433C7;
	Tue, 30 Jan 2024 19:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706643421;
	bh=rftYcHmlmMv34x7ss8O92q4W1IC5dTwHXDosWC6JSvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LcTJXWdGPWh2NHLwk+L48pnlF3pqserL77e5biKBRRC+HARK05fH73RDPvvQYoC4H
	 cH5fpeAb2e69eOrThkevI3f+pZaxvFc/2YVWnZbqZenzxEnbmuwoQDtxWbonqiFppJ
	 uch9Hiwzp5O7bbI0MF6wGsj4KzycWfFeLioy9++Tlj3jq/awlHUeJiTIP6lw0upZjC
	 0mzMw/qnOAzKNqEQFirdal5k0zDsaQCFRLSASAM8961gC+TQJq6FlzZpUlCmbWtjjv
	 j/PLZjg0vf298y0JZMqO8aZJJz8WNed3aUR2Z4MrL/MJOPFbAQGJyODooZZKvoCTmH
	 OzlHDH3i/BYMA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 3/5] libbpf: add btf__new_split() API that was declared but not implemented
Date: Tue, 30 Jan 2024 11:36:47 -0800
Message-Id: <20240130193649.3753476-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130193649.3753476-1-andrii@kernel.org>
References: <20240130193649.3753476-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Seems like original commit adding split BTF support intended to add
btf__new_split() API, and even declared it in libbpf.map, but never
added (trivial) implementation. Fix this.

Fixes: ba451366bf44 ("libbpf: Implement basic split BTF support")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c      | 5 +++++
 tools/lib/bpf/libbpf.map | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 95db88b36cf3..845034d15420 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1079,6 +1079,11 @@ struct btf *btf__new(const void *data, __u32 size)
 	return libbpf_ptr(btf_new(data, size, NULL));
 }
 
+struct btf *btf__new_split(const void *data, __u32 size, struct btf *base_btf)
+{
+	return libbpf_ptr(btf_new(data, size, base_btf));
+}
+
 static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 				 struct btf_ext **btf_ext)
 {
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index d9e1f57534fa..386964f572a8 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -245,7 +245,6 @@ LIBBPF_0.3.0 {
 		btf__parse_raw_split;
 		btf__parse_split;
 		btf__new_empty_split;
-		btf__new_split;
 		ring_buffer__epoll_fd;
 } LIBBPF_0.2.0;
 
@@ -411,5 +410,7 @@ LIBBPF_1.3.0 {
 } LIBBPF_1.2.0;
 
 LIBBPF_1.4.0 {
+	global:
 		bpf_token_create;
+		btf__new_split;
 } LIBBPF_1.3.0;
-- 
2.34.1


