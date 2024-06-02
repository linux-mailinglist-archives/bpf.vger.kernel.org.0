Return-Path: <bpf+bounces-31173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 200408D7936
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 01:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5187D1C21481
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 23:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D47823C3;
	Sun,  2 Jun 2024 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="f6G29Vwl"
X-Original-To: bpf@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6333C7F48E;
	Sun,  2 Jun 2024 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717371703; cv=none; b=bsxcJJRpc0Er0EADfTpDSSBFi5979mboeNh0XLBkSeLPhD4bNNVTNfz36dTvj6NfHXyDkxkDFja40W+6EzASWZ5rivLb1UURfz6PheTceS8d8fMRyhNVSF/+lZz0UDe0t4AHDsrWqqoF4LvgJcORfYQfq6mk/wwD3aRaHh8EIuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717371703; c=relaxed/simple;
	bh=lTt0hR7LrlfS0w20RIwK96pw0np9sANpdXGv9S0898U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnCYS4YAl5sov49Biqx8N8CdvyJ773itH83v+t9JqFez0kOzqsFUMWuB8nNMh7j4VxNzHFqKkf8IdJqyG+JEy6h7WyJV//o3id09EHm0V75g2YyZHVItogb1m2/Iat8KAtcp8XKtzGBBRf1+d+BPes07IqcxuglerWI6aEBqf5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=f6G29Vwl; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=0vSHaCER5RNLud6CSJnQ270WRt2oGu/Uj4sYe/neMus=; b=f6G29VwlfzCoz9aJ
	rWiwIH77dURfoo9YYoSiWZvDhLzI1CPFhYZOl/qcrZbQ7ErT7AbBwffm3LmF4dpFnJ9NEhjyokBVi
	1llp5VRNGK6dzyMlCD11XTDcf6o8v4rxAOK1w32A+aKNtezK5RE4randFUn2DYh3gR3D+bYhenxCy
	rEvefHBf6MiQ/BBimwxrRzy9jEHOjpNbuhVNttKQGMETBgQni9HQsxv6B+4lvJMMA95aBu2VOjzzh
	bwJ3YxqODkpsCdwDTctaNqCIEEspE28fDJq4DiRMYeGqC++BlZTIakeeK3G9Hx9rb9C/IeKy8XJVf
	Hgrh5HEjhLcOw59ynA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sDupV-003r31-0b;
	Sun, 02 Jun 2024 23:41:37 +0000
From: linux@treblig.org
To: andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	kpsingh@kernel.org,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 3/3] selftests/bpf: remove unused struct 'libcap'
Date: Mon,  3 Jun 2024 00:41:12 +0100
Message-ID: <20240602234112.225107-4-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240602234112.225107-1-linux@treblig.org>
References: <20240602234112.225107-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'libcap' is unused since
commit b1c2768a82b9 ("bpf: selftests: Remove libcap usage from
test_verifier").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 tools/testing/selftests/bpf/test_verifier.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index df04bda1c927..610392dfc4fb 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1237,11 +1237,6 @@ static void do_test_fixup(struct bpf_test *test, enum bpf_prog_type prog_type,
 	fixup_prog_kfuncs(prog, fd_array, test->fixup_kfunc_btf_id);
 }
 
-struct libcap {
-	struct __user_cap_header_struct hdr;
-	struct __user_cap_data_struct data[2];
-};
-
 static int set_admin(bool admin)
 {
 	int err;
-- 
2.45.1


