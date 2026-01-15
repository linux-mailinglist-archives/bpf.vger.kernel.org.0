Return-Path: <bpf+bounces-79099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77228D26C62
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5100530C7C58
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE992D7DED;
	Thu, 15 Jan 2026 17:39:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from esa1.cc.uec.ac.jp (mx.uec.ac.jp [130.153.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D7127B340
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.153.8.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498772; cv=none; b=IrCVXf7IlaS7aqu9FCTev9z+a0x+VxtWdwsi7KS7KlpHBLURKNS6MsBCghUkOj34KEMgclecXqNb3wpwD7UZRDMdjgkVF/wnx8WKPphjOsQhKmHqt0CjVO6hPdGpQFwtynvDT2SfD7SkaLuUTPIujCXsEtt8IZO707UzQaYLwsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498772; c=relaxed/simple;
	bh=k0z6mOMj5GtWwbLc6GOYwbxY7BYeNlqZN7nWgzjCzik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mkqG6dz2QUpnl8sPqInRYp2EWlaVeTYjUKtw2qzVKrBvA9LyuKArUJkvbk7Q1YnLvy0BPzsu7EDQAu1EpgqS/Qp7PqwRL4Qya+FaV4ug4HPhGAEBtLWGgUs/nyquKCtG7k3BEPCWafZty+xgcLwngvf7EkeCm1XoEjIgr/T2y9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp; arc=none smtp.client-ip=130.153.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp
X-CSE-ConnectionGUID: JluXyON8TcmlWKfme2nN5g==
X-CSE-MsgGUID: oVbIUo+xTKyI1ngw1bZ7wg==
X-IPAS-Result: =?us-ascii?q?A2EtBQCdJWlp/zYImYJaglkCuhmBfwYJAQEBAQEBAQEBW?=
 =?us-ascii?q?gQBAYUHjHgnNQgOAQIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBAQUBAQEBAQEGA?=
 =?us-ascii?q?wEBAgKBHYYJU0kBEAGGQAFGUIQCgnSyBoEB3XotVIEyFYE4jVJxhTqCDYR9h?=
 =?us-ascii?q?Bp2hXcEgxwUlBZIgR4DWSwBE0ITDQoLBwVqYQIZAzUSKhVuCBEZHYEZCj4Xg?=
 =?us-ascii?q?QobBwWBUgaCFoZmD4kygUsDCxgNSBEsNxQbQm4HkgwHgQ8qUJBBB5cGoRGEJ?=
 =?us-ascii?q?oRRH5xoTYNxpnoumFikWYZSA4IRTTiDI1EZD9MAgSUCBwsBAQMJhn6KbIF/A?=
 =?us-ascii?q?QE?=
IronPort-Data: A9a23:rXqayqI1hB8jgd6fFE+RfZQlxSXFcZb7ZxGr2PjKsXjdYENSgTMEn
 zRLXTrSOPjZYTbwL9l3bIrjoBxUsJ/XnYJjHARorCE8RH9jl5H5CIXCJC8cHc8zwu4v7q5Dx
 59DAjUVBJlsFhcwnj/0bP656yI6jf3ULlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgX8s9JIGjhMsfzb8Uoy5K6aVA4w5zTSW9ga5DcyqFFIVPrzFYnpR1PkT49dGPKNR
 uqr5NmR4mPD8h4xPcium7D9f1diaua60d+m0yc+twCK23CulwRqukoJHKN0hXR/0l1lq+tMJ
 OBl7vRcf+uJ0prkw4zxWzEAe8130DYvFLXveRBTuuTKp6HKnueFL1yDwyjaMKVBktubD12i+
 tQ6LC09fzel1969xbaEaedpi54lCpTkadZ3VnFIlVk1DN4jUdXPTqHL+9JCzXEti8sIFP2YZ
 dJxhThHNU+YJUQSYRFHTs9i9AurriCXnzlwqUmVpLs+5mH7zBR6lrn2dsfYcZqDToNXhi50o
 0qfpzqnWU9CbIb3JTyt9Uymp9LI3jPHe5MzTbu36adgsgKMyTlGYPERfQHi+6bm0x/Wt8hkA
 00P+is/pK073EyzRZ/8RFulrXXCtxVaWcI4LgEhwASdj6bZ5weHC3IVF3hcZddgvcRwRyRCO
 kK1c83BJzhygKyybyKh/bKQkhC8PCVPK0lfanpRJeca2OUPtr3fmTrtdr5e/EOdi82wFTz0w
 i6HtjlnwagehogC3OO55TgrYg5ARLCUE2bZBS2OAApJCz+Vgqb/OOREDnCCvJ59wH6xFAXpg
 ZT9s5H2ASBnJcjleNaxrBox8EGBva/fb2KF0DaD7rE99znl5niiY41K+zBiNQ9uPI4JfTLif
 FXU/AhW4ZpOOnqhZLN2ZISqY/kXIGmJPYqNa804mfIUOcAsLlLfonkxDaNStki0+HURfWgEE
 c/zWa6R4bwyUMyLEBLeqz8h7IIW
IronPort-HdrOrdr: A9a23:5FsMmKoHHdpOjrtG/E/sXToaV5oweYIsimQD101hICG9vPb1qy
 nIpoV46faaslgssR0b8+xoW5PwIk80l6QV3WB5B97LNzUO01HGEGgN1+bfKkXbexHDyg==
X-Talos-CUID: 9a23:DUFWmWDbd+BPmdb6Ewtj6X4FPeZ1TnbYyEjzLUq1U2BPFbLAHA==
X-Talos-MUID: 9a23:OFbnKwTeoCmr47AVRXTrujtDCcAr85iNGWFUl5oZ4sO2ajN/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,228,1763391600"; 
   d="scan'208";a="106636003"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Received: from mx-delivery1.uec.ac.jp (HELO mx-delivery.uec.ac.jp) ([130.153.8.54])
  by esa1.cc.uec.ac.jp with ESMTP; 16 Jan 2026 02:38:19 +0900
Received: from labpc.. (unknown [172.21.208.155])
	by mx-delivery.uec.ac.jp (Postfix) with ESMTPSA id D0B5E183E386;
	Fri, 16 Jan 2026 02:38:18 +0900 (JST)
From: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Subject: [PATCH bpf-next 0/2] bpf: Add kfunc bpf_strncasecmp()
Date: Fri, 16 Jan 2026 02:37:14 +0900
Message-ID: <20260115173717.2060746-1-ishiyama@hpc.is.uec.ac.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset introduces bpf_strncasecmp to allow case-insensitive and
limited-length string comparison. This is useful for parsing protocol
headers like HTTP.

Yuzuki Ishiyama (2):
  bpf: add bpf_strncasecmp kfunc
  selftests/bpf: Test kfunc bpf_strncasecmp

 kernel/bpf/helpers.c                          | 31 +++++++++++++++++--
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  1 +
 .../bpf/progs/string_kfuncs_failure1.c        |  6 ++++
 .../bpf/progs/string_kfuncs_failure2.c        |  1 +
 .../bpf/progs/string_kfuncs_success.c         |  7 +++++
 5 files changed, 43 insertions(+), 3 deletions(-)

-- 
2.43.0


