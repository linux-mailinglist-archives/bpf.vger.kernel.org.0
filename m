Return-Path: <bpf+bounces-64744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B3CB166CA
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 21:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA1D621125
	for <lists+bpf@lfdr.de>; Wed, 30 Jul 2025 19:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BB82E2F1E;
	Wed, 30 Jul 2025 19:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="S6px7Vmo";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="9Rruzgnb"
X-Original-To: bpf@vger.kernel.org
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776962DEA8F
	for <bpf@vger.kernel.org>; Wed, 30 Jul 2025 19:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903176; cv=none; b=qj9xK297e4vsaYl4c6dp/c7ug2HSUAfWuoGZGM9tcLsYdPUyClwZWBjy/LTsVHN8TTJAV3Y/GN7PfuQSd7TECaeR6bggZX617peR4dA30vC62Gp6cocYIxw9Alx9ayItGmeAobo6JlFU+LdjwAdz4Qps4KmqfFfLUxHl4LjjzvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903176; c=relaxed/simple;
	bh=bqHrYkDZXe0uA+hcCyctVCBg+AK99DMSQV4HhWKLw4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oHl35Uz0IavO4a9zPl+QiNB5xuMJ0JKNFsdYvHXhMBApznn8K0urzE9GU6DhvWYSxUR/sNw2/V0LgP3zDsi0paantxYhcPeDjwyF0mFbqi9Wx8w3Lr2pCTopZs3DwakX0+tYUu4KRHbHsJ+EqmiiIw21OjfalS2xP5D8VZQaLFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=S6px7Vmo; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=9Rruzgnb; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1753903170; x=1754507970;
	d=konsulko.se; s=rsa1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=QmEEM2pn7Tus3BjInJV0eWX/l4iVKVBIqgB63o1NBvg=;
	b=S6px7Vmo1VB8ZlA7+0wJXegbsPHY+z4XjjHyKTMbPRjXtLETGlaMl/mQ6C0xVVFvqcuuKWTRlnND/
	 30e7qqyYxtMS4O4ZeF0xbpIDPMp+rpcfb1wRycvzTpPI9p1TtJvCp4wK69fddukMhk9maAFOJ63YkK
	 cQm9qvsMm4mJPBHO43wX3hhl+rb0XJI76vDFIptpnad4T5O2alVi49jc1PF+qN19/tSVO6EadaElBK
	 48SKqlA0aKZwMP5+reLBJeAIOL1hYCGkkxUsgpnZWW0AfVMUJotfC2dbMo7OkVHFIMnZDaANqcK1hM
	 hkgzMY2/2H1J5uSu4cL7P5tTirjTOrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1753903170; x=1754507970;
	d=konsulko.se; s=ed1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=QmEEM2pn7Tus3BjInJV0eWX/l4iVKVBIqgB63o1NBvg=;
	b=9RruzgnbAMugNfJmZEDTAoSVd5s12KCa3JKJ6AJiUKzoFR2TUrGXIM3x3cKEBHcJoy8l/dXCpFDLV
	 jTnVBjuAA==
X-HalOne-ID: 1c955182-6d7a-11f0-aff3-632fe8569f3f
Received: from slottsdator.home (host-90-238-19-233.mobileonline.telia.com [90.238.19.233])
	by mailrelay2.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 1c955182-6d7a-11f0-aff3-632fe8569f3f;
	Wed, 30 Jul 2025 19:19:30 +0000 (UTC)
From: Vitaly Wool <vitaly.wool@konsulko.se>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	rust-for-linux@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org,
	bpf@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Vitaly Wool <vitaly.wool@konsulko.se>
Subject: [PATCH v14 0/4] support large align and nid in Rust allocators
Date: Wed, 30 Jul 2025 21:19:21 +0200
Message-Id: <20250730191921.352591-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The coming patches provide the ability for Rust allocators to set
NUMA node and large alignment.

Changelog:
v2 -> v3:
* fixed the build breakage for non-MMU configs
v3 -> v4:
* added NUMA node support for k[v]realloc (patch #2)
* removed extra logic in Rust helpers
* patch for Rust allocators split into 2 (align: patch #3 and
  NUMA ids: patch #4)
v4 -> v5:
* reworked NUMA node support for k[v]realloc for all 3 <alloc>_node
  functions to have the same signature
* all 3 <alloc>_node slab/vmalloc functions now support alignment
  specification
* Rust helpers are extended with new functions, the old ones are left
  intact
* Rust support for NUMA nodes comes first now (as patch #3)
v5 -> v6:
* added <alloc>_node_align functions to keep the existing interfaces
  intact
* clearer separation for Rust support of MUNA ids and large alignments
v6 -> v7:
* NUMA identifier as a new Rust type (NumaNode)
* better documentation for changed and new functions and constants
v7 -> v8:
* removed NumaError
* small cleanups per reviewers' comments
v8 -> v9:
* realloc functions can now reallocate memory for a different NUMA
  node
* better comments/explanations in the Rust part
v9 -> v10:
* refined behavior when memory is being reallocated for a different
  NUMA node, comments added
* cleanups in the Rust part, rustfmt ran
* typos corrected
v10 -> v11:
* added documentation for the NO_NODE constant
* added node parameter to Allocator's alloc/realloc instead of adding
  separate alloc_node resp. realloc_node functions, modified users of
  alloc/realloc in accordance with that
v11 -> v12:
* some redundant _noprof functions removed in patch 2/4
* c'n'p error fixed in patch 2/4 (vmalloc_to_page -> virt_to_page)
* some typo corrections and documentation updates, primarily in patch
  3/4
v12 -> v13:
* fixed wording in comments (patches 1, 3)
* fixed bigger alignment handling in krealloc (patch 2)
* removed pr_warn import (patch 4)
v13 -> v14:
* addressed Vlastimil's comments for the slub allocator's alignment
  handling
* added cnages to allocator_test.rs to match the new API
Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
--
 fs/bcachefs/darray.c                |    2 -
 fs/bcachefs/util.h                  |    2 -
 include/linux/bpfptr.h              |    2 -
 include/linux/slab.h                |   39 +++++++++++++++++++++++--------------
 include/linux/vmalloc.h             |   12 ++++++++---
 lib/rhashtable.c                    |    4 +--
 mm/nommu.c                          |    3 +-
 mm/slub.c                           |   59 +++++++++++++++++++++++++++++++++++++++++++--------------
 mm/vmalloc.c                        |   29 +++++++++++++++++++++++-----
 rust/helpers/slab.c                 |   10 +++++----
 rust/helpers/vmalloc.c              |    5 ++--
 rust/kernel/alloc.rs                |   54 +++++++++++++++++++++++++++++++++++++++++++++++-----
 rust/kernel/alloc/allocator.rs      |   49 ++++++++++++++++++++++-------------------------
 rust/kernel/alloc/allocator_test.rs |    1 
 rust/kernel/alloc/kbox.rs           |    4 +--
 rust/kernel/alloc/kvec.rs           |   11 ++++++++--
 16 files changed, 202 insertions(+), 84 deletions(-)


