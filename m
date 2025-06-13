Return-Path: <bpf+bounces-60575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E2AAD823C
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 07:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D38517FA1A
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 05:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BD4222575;
	Fri, 13 Jun 2025 05:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTNHyLUl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD6323A9AC
	for <bpf@vger.kernel.org>; Fri, 13 Jun 2025 05:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749790807; cv=none; b=DgoLOTdlG6kjZrgerW/JtBfr5LnmjE4fYmNMvJyVjhFUAIoMD0pFborNEz+WDtja5IB6mA1U+4taEr5SdOQoPb2/sW3lRSVa2/3iVTUi0Vk0p709aeq3pOVM4sRjT8PHwVo0nhIQuGoidwZ+qKlSIfl7xLuxJkG+dL4svDRJFGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749790807; c=relaxed/simple;
	bh=2+peTGz6QaZq2a26zD3VOgeJp9UM/KS/tgvqaMSniwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JCAyNRa6mrmqU2r5O5oTAYlab3sSjyE3WqgQJG6ksS8r4NANwdIvts80IsDMXGAp4roJcyBb/ap2uUs6BQ5cehmCEbkKXhLUivnp3AumO2jfEb7L12KjFP9rVIm/ttKTORmlJl3ECFTAMQfG6p5xHfq4pLbHMwxPw0x3AxDx7Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTNHyLUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A38C4CEE3;
	Fri, 13 Jun 2025 05:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749790807;
	bh=2+peTGz6QaZq2a26zD3VOgeJp9UM/KS/tgvqaMSniwI=;
	h=From:To:Cc:Subject:Date:From;
	b=PTNHyLUlGV+BSuwBqzTi9davEQA0d5XsR/9SDT5HLpirr6r5xT03MBEIN4UBh0++d
	 jDO3vK1HllkIIWUh+YY38QuVyp7XL2qYLRzMWfSoEHXf8IU38w8qy9+1vZjYdRxDC4
	 7qnfkJ8b2n9g/sKyDcXKudIkQX+zzDPNkSdfRlzd9sZoxlukGr1iujsJPNj2VtwYEU
	 H/C6IOkSvpvlETwdJQtEVC0HUsENFPY6uJNp/uymTpf2AVGc5Sr2vTR1oG5S/6WA9o
	 lWlJVD0Xq6xfVkFA7AIB+uXlb6oyJbtETej5tR8tSuBATpAvgPJEo1fGwdKUkHZ7yP
	 qsRFhS9xWkOsw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next] bpf/veristat: Fix veristat for map type BPF_MAP_TYPE_CGRP_STORAGE
Date: Thu, 12 Jun 2025 22:00:01 -0700
Message-ID: <20250613050001.1058733-1-song@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF_MAP_TYPE_CGRP_STORAGE doesn't allow non-zero max_entries. So veristat
should not set it to 1.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index b2bb20b00952..70cdabd88c50 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1182,6 +1182,7 @@ static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog, const ch
 		case BPF_MAP_TYPE_TASK_STORAGE:
 		case BPF_MAP_TYPE_INODE_STORAGE:
 		case BPF_MAP_TYPE_CGROUP_STORAGE:
+		case BPF_MAP_TYPE_CGRP_STORAGE:
 			break;
 		case BPF_MAP_TYPE_STRUCT_OPS:
 			mask_unrelated_struct_ops_progs(obj, map, prog);
-- 
2.47.1


