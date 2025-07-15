Return-Path: <bpf+bounces-63322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C0AB0603E
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 16:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858E45037D0
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 14:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABE62EF641;
	Tue, 15 Jul 2025 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="DinSq7vC";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="mS9lXsTQ"
X-Original-To: bpf@vger.kernel.org
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB972EF2AF
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587821; cv=none; b=uYkXQ00532XGcyJytNNDGwoTsaNKX/vOVBmJQ/IrTyRrcDQa+eCMwbBGDoWXjnBhQrlX7WoEhVqPzmh7LkzvOLNA74oalxawHZlHpu/gKMEpEDYz5e7bppzBOPjtjwyv5mg09QNgri6IL4NX1KDpJEqJ7LJ3981E4jI9qzmg6nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587821; c=relaxed/simple;
	bh=2SUEHRJ69Z2HmP4/9Xtfk6X7RiIJOF+5FTo9wOtE6yw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bTxLXVsbyMadYWfhV1yXgz6bKHBmoKEW5TGH0tWHTlld6aKQgYi3gma6xwEd3nmIcpsh1PZji36OMbL6iWrJ1REn1AYz7bfPstmRqoj+YbwG5lCDTUm0PLk/XHFHwGmV2/zDgQ1MIqLTUIh8t6QhlbVAN1wYSlL76x8fuW6upZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=DinSq7vC; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=mS9lXsTQ; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1752587816; x=1753192616;
	d=konsulko.se; s=rsa1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=FZ3JHSKCAp61LgEDvUcR1KnuzzUfFsyQiR8khxy1tAQ=;
	b=DinSq7vCV9C/C9FpUNRVuJURAMXMn3XkqMfkqI44nxC41B3bkeuWYSyjya03kyOc2nBTc4CzlmK/v
	 XZBcOgyq9rTgmZBoESKcEI7lDuuKL3LO6PHH+rHQ9KRQdc6EGfzNHLk9d1GFdK7ohLc6oLV8bxEMCm
	 Fq03cVQw9pKxycNcQwUnhjINI/7GA8KHHLPQEh+6lDkeweHgx2Wc+XHd097QY+FK1ku/Uy475TtyWz
	 tqVU8L3gzh4nWcYeXnq0qSkFYzLxfZbWtIiwCOjYniXyGO5HYPcJkLa3PNOjWS2LaWMlCY59aBcAbw
	 /0ddspZ5CvVWwza/samsVMDnMnTVlPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1752587816; x=1753192616;
	d=konsulko.se; s=ed1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=FZ3JHSKCAp61LgEDvUcR1KnuzzUfFsyQiR8khxy1tAQ=;
	b=mS9lXsTQiKfFsm0bDu7xIyhiQH7dtER94VVDAh0BOQhcSju2SVtHFXb9isz7p5aiBKYiydg0Tm6KG
	 VzbvISBDg==
X-HalOne-ID: 9096aaa2-6183-11f0-8921-e90f2b8e16ca
Received: from slottsdator.home (host-90-238-19-233.mobileonline.telia.com [90.238.19.233])
	by mailrelay2.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 9096aaa2-6183-11f0-8921-e90f2b8e16ca;
	Tue, 15 Jul 2025 13:56:55 +0000 (UTC)
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
Subject: [PATCH v13 0/4] support large align and nid in Rust allocators
Date: Tue, 15 Jul 2025 15:56:45 +0200
Message-Id: <20250715135645.2230065-1-vitaly.wool@konsulko.se>
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

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
--
 fs/bcachefs/darray.c           |    2 -
 fs/bcachefs/util.h             |    2 -
 include/linux/bpfptr.h         |    2 -
 include/linux/slab.h           |   39 ++++++++++++++++++++++---------------
 include/linux/vmalloc.h        |   12 ++++++++---
 lib/rhashtable.c               |    4 +--
 mm/nommu.c                     |    3 +-
 mm/slub.c                      |   64 +++++++++++++++++++++++++++++++++++++++++--------------------
 mm/vmalloc.c                   |   29 ++++++++++++++++++++++-----
 rust/helpers/slab.c            |   10 +++++----
 rust/helpers/vmalloc.c         |    5 ++--
 rust/kernel/alloc.rs           |   54 ++++++++++++++++++++++++++++++++++++++++++++++-----
 rust/kernel/alloc/allocator.rs |   49 +++++++++++++++++++++-------------------------
 rust/kernel/alloc/kbox.rs      |    4 +--
 rust/kernel/alloc/kvec.rs      |   11 ++++++++--
 15 files changed, 200 insertions(+), 90 deletions(-)


