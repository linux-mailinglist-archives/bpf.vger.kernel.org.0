Return-Path: <bpf+bounces-65122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E73CEB1C617
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 14:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D8D162DF8
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 12:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D745028B7F9;
	Wed,  6 Aug 2025 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="pQ8Xqu4v";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="i5l+IAAh"
X-Original-To: bpf@vger.kernel.org
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AF924DCEC
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484050; cv=none; b=mFY6KS+6WY2LYg/2p3eziubwdysio6O2K1MdkE5IUPGF8KhqnqK/qpn6hEVZntNDexWgSKQP+a/RvG7M7l+ezdL+K8sZcwmGQ/tGCERDt5Iw+f2gDluqAALiy8cf58aemjfoydZHf2TuxpinvaeAwYJfQrC2ozZziPu3R/shYaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484050; c=relaxed/simple;
	bh=TOpPlTtS9gCy1fQQ1FgNK/Z+oOAScsjKFxLBYZ+wx5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NUuRpnXDD4MiZlntcCaKeaQKKQS2ubaKQssexDghVy4xD/kUUm7k7/0Bpz+209ANU78usx+KiDzuA/JiviAP0vUmHwDtWVL22DyCDe+BU1+5SiTqxIihfwKtbriUNx++MvhSLyDBrhGRWqXr8KRaJN6uSCWyPZqiArdgePM4tR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=pQ8Xqu4v; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=i5l+IAAh; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1754484040; x=1755088840;
	d=konsulko.se; s=rsa1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=6NZAtsRQPRLEOnALjiUrPTbK1Ko1TPX/qvuOItNudmY=;
	b=pQ8Xqu4vQVoFuzRNfkx8tDpO9pXYsqUSAgtU/nEVx76yuwztxDEQDHPe7PTlK3eczmunaTtBIgpb2
	 pnRpl2zV8im/earTDa/GqC0MFxxTPCWVKCJMWjhquroMMjyVWq7KRFmkHc2YdAce3WQbHnnnBHNnYG
	 Nx8LNmBp36TG7IMkzvfiPeL+6Bmaw0ql+FvaGgxQ2ajlNDeR5NYLuE1/2k2KkJA717U0yExEP9D3j3
	 9PPtJX67h2Tx9r1TZyh6A7pcU6/qmqauLjoKt23Lw3pimQfEwyr0uchl4Gjd2+LdWKsBURXlduGEmJ
	 mpA6bgGdm3WIBXQQuuI0G9YKpU3tdRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1754484040; x=1755088840;
	d=konsulko.se; s=ed1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=6NZAtsRQPRLEOnALjiUrPTbK1Ko1TPX/qvuOItNudmY=;
	b=i5l+IAAhCBevKEaEodC3AD/f5I2d0OS/oDuz/impr33Mg4QpfgQxw4yjoWNf7OQ+owvdOld3NLwVb
	 QBDDwOLCw==
X-HalOne-ID: 8e99376d-72c2-11f0-ab00-85eb291bc831
Received: from localhost.localdomain (c188-150-224-8.bredband.tele2.se [188.150.224.8])
	by mailrelay5.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 8e99376d-72c2-11f0-ab00-85eb291bc831;
	Wed, 06 Aug 2025 12:40:39 +0000 (UTC)
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
Subject: [PATCH v15 0/4] support large align and nid in Rust allocators
Date: Wed,  6 Aug 2025 14:40:34 +0200
Message-Id: <20250806124034.1724515-1-vitaly.wool@konsulko.se>
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
v14 -> v15:
* fixed allocator_test.rs changes added at the previous iteration
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


