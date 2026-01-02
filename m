Return-Path: <bpf+bounces-77673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAE8CEE4B0
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 12:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DA03300AB37
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 11:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC2D2E8DE3;
	Fri,  2 Jan 2026 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jz9CQj9J"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561842E9730;
	Fri,  2 Jan 2026 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767352461; cv=none; b=nDAAqtfi4mpt79uvppjOA+R8jA8XgV1eO1gcDW2IEKBjh5bKCn30hXWkogVOV+McTs2GReVS5fEY+uT3jSUOaTvU/hGmeqmtO6ecHHyfKM6z+OrL25LUOgIFDOrUXFo90GHiyHCccLOclU4aj1J2pqxaVsq4ouarH45pB10eRSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767352461; c=relaxed/simple;
	bh=TvyR6IzZmQGB2r5ynU4LrgJ6skz6VmacT+UIAwzZ53o=;
	h=From:To:Cc:Subject:Date:Message-Id; b=A6X36F4bAKwnQJ+LY/BQyh7jPyQ3i85jh+ObkgCK4XdF3X/HxQterhU++jRyhd32+39Jn9oGhe4Fc3QO27ApgubyCaRr7dAz578YAL9NWiMRB99IwrEkuwvO+aHYgSOaQhSkHuxgv5igQ6wS4FlpaXBkDKTa7zMyKW0FqpvxdnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jz9CQj9J; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1226)
	id C44082124E39; Fri,  2 Jan 2026 03:14:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C44082124E39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767352454;
	bh=al+4+Z+07wmIj3digVh8zRBExsbVq+4F09K/C1qdV3U=;
	h=From:To:Cc:Subject:Date:From;
	b=jz9CQj9JzFmJfXKXAc4L6pgyhs9kQlyhiV05czYhnZfcn0+Ikes4GLwu87YTXHIm6
	 gQAKBv80P9I2gbOOO/nnF5N8wSOdj6UUkToufVPGkXJjsytiBH7Zlm/FWnUUWL4waF
	 F3Veh5OoYyP6pNY0nrDQLQnLUdRMVIaRJE3eBTak=
From: Hemanth Malla <vmalla@linux.microsoft.com>
To: bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	vmalla@microsoft.com,
	corbet@lwn.net
Subject: [PATCH bpf-next] bpf, docs: Update pahole to 1.28 for selftests
Date: Fri,  2 Jan 2026 03:13:35 -0800
Message-Id: <1767352415-24862-1-git-send-email-vmalla@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

From: Hemanth Malla <vmalla@microsoft.com>

pahole 1.16 doesn't seem to be to sufficient anymore for running bpf
selftests.

Signed-off-by: Hemanth Malla <vmalla@microsoft.com>
---
 Documentation/bpf/bpf_devel_QA.rst | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index 0acb4c9b8d90..3a147b6c780e 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -482,7 +482,7 @@ under test should match the config file fragment in
 tools/testing/selftests/bpf as closely as possible.
 
 Finally to ensure support for latest BPF Type Format features -
-discussed in Documentation/bpf/btf.rst - pahole version 1.16
+discussed in Documentation/bpf/btf.rst - pahole version 1.28
 is required for kernels built with CONFIG_DEBUG_INFO_BTF=y.
 pahole is delivered in the dwarves package or can be built
 from source at
@@ -502,9 +502,6 @@ codes from
 
 https://fedorapeople.org/~acme/dwarves
 
-Some distros have pahole version 1.16 packaged already, e.g.
-Fedora, Gentoo.
-
 Q: Which BPF kernel selftests version should I run my kernel against?
 ---------------------------------------------------------------------
 A: If you run a kernel ``xyz``, then always run the BPF kernel selftests
-- 
2.43.0


