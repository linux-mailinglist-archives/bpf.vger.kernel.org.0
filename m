Return-Path: <bpf+bounces-79260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB68D32979
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 246A230087B0
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33E5336EFE;
	Fri, 16 Jan 2026 14:25:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from esa1.cc.uec.ac.jp (mx.uec.ac.jp [130.153.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099043358D4
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.153.8.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573512; cv=none; b=gvbGwPD24Jv4aGueNs+NN75LT/U77jlVU1SDjVYUDMHmfxs1eVZbbvmf9YYKDOMj4uKSrL1FdWYlpHuSqweWmQ5w3dRXu0HhOmyZqfTCDafqhiauaIuQsrRXakq0d5zPz2b3bhZHfrum7xaUA+uaqZ1QTBBHkmrvO7RTQ54VVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573512; c=relaxed/simple;
	bh=WuzZj/ouOjS05C2N7uasbs3SVbVCCoe6Wq+nntlbWvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DLBXF78xmOv096tfAg89Oy/Qu0Ba00aNbOL95Vb3NEiO2qjpmsuru7z68yyAkJpqhrDRmcu/EqIPwtuDZGBo9TUG5F2rnQaJPy2bhezy3uSzHQNC/vZWXDQZATRlFJYaCm2WrWK7EJqENVU9YG212XdylfyG3ovbodTn8vjdkN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp; arc=none smtp.client-ip=130.153.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp
X-CSE-ConnectionGUID: RczujbiTTSW4YSiJGrDx7Q==
X-CSE-MsgGUID: 4t0XrbLQSJmoKoBu+7bcFg==
X-IPAS-Result: =?us-ascii?q?A2GOBQC2SWpp/zYImYJaglkCm3yeHYF/BgkBAQEBAQEBA?=
 =?us-ascii?q?QFaBAEBhQeMeic2Bw4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEBBQEBAQEBA?=
 =?us-ascii?q?QYDAQECAoEdhglTSQEQAYZAAUaEUoJ0tBKBAd16LVSBMhWBOI1ScYU6gg2Ef?=
 =?us-ascii?q?YQadoV3BIINFXoUlCRIgR4DWSwBE0ITDQoLBwVqYQIZAzUSKhVuCBEZHYEZC?=
 =?us-ascii?q?j4XgQobBwWBUAaCFYZpD4kygVwDCxgNSBEsNxQbQm4HkhoHAWIsKlCBLo8TB?=
 =?us-ascii?q?4d3jw+hEYQmhFEfnGhNqmsumFikWYZXBYIKTTiDI1EZD9NvgSUCBwsBAQMJh?=
 =?us-ascii?q?n6KbIF/AQE?=
IronPort-Data: A9a23:51rfE6LdI19l4L2BFE+RfZQlxSXFcZb7ZxGr2PjKsXjdYENS3zcEx
 mJMXDrQaazfNmqjc95wb4rjpxlX6MfQx9JhTAZorCE8RH9jl5H5CIXCJC8cHc8zwu4v7q5Dx
 59DAjUVBJlsFhcwnj/0bP656yI6jf3ULlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgX8s9JIGjhMsfzb8Uox5K6aVA4w5zTSW9ga5DcyqFFIVPrzFYnpR1PkT49dGPKNR
 uqr5NmR4mPD8h4xPcium7D9f1diaua60d+m0yc+twCK23CulwRqukoJHKN0hXR/0l1lq+tMJ
 OBl7vRcf+uJ0prkw4zxWzEAe8130DYvFLXveRBTuuTKp6HKnueFL1yDwyjaMKVBktubD12i+
 tQiIyIQbBqCu96N/+6KcehOqd4PPJbSadZ3VnFIlVk1DN4jUdXPTqHL+9JCzXEti8sIFP2YZ
 dJxhThHNU+YJUQSYRFHTs9i9AurriCXnzlwqUmVpLs+5mH7zBR6lrn2dsfYcZqDToNXhi50o
 0qfpzqmW0hEa4z3JTytrm70tvXFuRrAeocVN7qS6701ila9yTlGYPERfQHi+6bm0x/Wt8hkA
 00P+is/pK073EyzRZ/8RFulrXXCtxVaWcI4LgEhwASdj6bZ5weHC3IVF3hcZddgvcRwRyRCO
 kK1c83BPzd9rb+fSE6hzYjInAizGwcPAX9dXHpRJeca2OUPtr3fmTrtdr5e/EOdi82wFTz0w
 i6HtjlnwagehogC3OO55TgrYg5ARLCUE2bZBS2OAApJCz+Vgqb/OOREDnCCvJ59wH6xFAXpg
 ZT9s5H2ASBnJcjleNaxrBox8EGBva/fb2KF0DaD7rE99znl5niiY41K+zBiNQ9uPI4JfTLif
 FXU/AhW4ZpOOnqhZLN2ZISqY/kXIGmJPYqNa804mfIVM8cuJVXarXswDaNStki0+HURfWgEE
 c/zWa6R4bwyUMyLEBLeqz8h7IIW
IronPort-HdrOrdr: A9a23:uUZh06svd1JPS/G23/L7KW477skDT9V00zEX/kB9WHVpm62j5q
 eTdZsguyMc5AxxZJhCo6HlBEDjewK+yXcd2+B4VotKOjOHhILCFu1fBOXZrgHIKmnX8fNc6q
 d6b7IWMrfN5CBB/KTHCV6DYrMdKA/uys+Vuds=
X-Talos-CUID: 9a23:Zbmmr2FMF9nLqPqjqmJd/1wJGMokTkHm8yvhGE6aJnxFWOKsHAo=
X-Talos-MUID: 9a23:NMGj0wQp7sEUoBuiRXSwmGlSLs1M2p+MDUculr8b+JaOPgJ/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,231,1763391600"; 
   d="scan'208";a="106711679"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Received: from mx-delivery1.uec.ac.jp (HELO mx-delivery.uec.ac.jp) ([130.153.8.54])
  by esa1.cc.uec.ac.jp with ESMTP; 16 Jan 2026 23:25:08 +0900
Received: from labpc (unknown [172.21.208.155])
	by mx-delivery.uec.ac.jp (Postfix) with ESMTPSA id 63EA5183E386;
	Fri, 16 Jan 2026 23:25:08 +0900 (JST)
From: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	mykyta.yatsenko5@gmail.com,
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Subject: [PATCH bpf-next v2 0/2] bpf: Add kfunc bpf_strncasecmp()
Date: Fri, 16 Jan 2026 23:24:53 +0900
Message-ID: <20260116142455.3526150-1-ishiyama@hpc.is.uec.ac.jp>
X-Mailer: git-send-email 2.52.0
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

---
 
Changes in v2:
- Compute max_sz upfront and remove len check from the loop body
- Document that @len is limited by XATTR_SIZE_MAX

Yuzuki Ishiyama (2):
  bpf: add bpf_strncasecmp kfunc
  selftests/bpf: Test kfunc bpf_strncasecmp

 kernel/bpf/helpers.c                          | 37 ++++++++++++++++---
 .../selftests/bpf/prog_tests/string_kfuncs.c  |  1 +
 .../bpf/progs/string_kfuncs_failure1.c        |  6 +++
 .../bpf/progs/string_kfuncs_failure2.c        |  1 +
 .../bpf/progs/string_kfuncs_success.c         |  7 ++++
 5 files changed, 47 insertions(+), 5 deletions(-)

-- 
2.52.0


