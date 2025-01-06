Return-Path: <bpf+bounces-47955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0C0A02893
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 15:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83BB91882C7D
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 14:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB568634D;
	Mon,  6 Jan 2025 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EY/MGXz8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD618634A
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736175231; cv=none; b=WxRzTPZrOEt1YQs3LuCl6Lgx6nnCD1fxjUi+w4b7yE6JyTQl4fTOq4k0Y2j1Of6JbR+Yiudpad5IknbhbavY1iFnuMpLHIO1U8OxKsnlp7ZjwhDejs9lIqSz6iTEmLK/I+DxI53dYqISvulwrbTjBulGvOlAmHR6tXY4ZaLm1SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736175231; c=relaxed/simple;
	bh=NJSG2k34/beKvJdLeIGtTC55lt6AVapwO3K23Muyvy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUs3GxxJtOkl0cIJtS4wVKdvhJY824gMJVKvGpqzOx8tXELZ/CL+Zgs15PeN3lXqJptGUs0ddGhxs49U8x0JDryE7+jyaliylZPz8p2Tn9x80DggaYMPBVKgusEu9vLq7otx1HHm5ELYFwhpD/lJONHFnuE9vnZW5jxUEYRo4ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EY/MGXz8; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3862d6d5765so8483687f8f.3
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 06:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736175228; x=1736780028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Cm5BHzkLMiGmJECEJ3DZxDN9rXYzkgE7TWnIYfzD6A=;
        b=EY/MGXz8wG1ZmJtJR+YnFYliiJ2+o3JLBFqCwMrSSi8ToBEje4fc62+rMYQ25f7kz6
         o8hnZAvcyACVvQtnEIJKhCFtMY1LquBFt6iG4a0h4eUF2UZNOSDx8uQTrGhyfqFdACNP
         QqcK6IpUjnva/bI6AHEM0RdofRHXT3yz3cPEdI1gAHp1TAlg2x/6unZ8Z3Ow83nwq8v1
         g81EfqDteZYWfQ/J+K+uYZ/RE7KLJrYxTVBLdpTcdLgo2aRtwcoTarj/a9vyBwqq9zZA
         yZ2Sp1LOxROmKumm/L9uuPvrFvThX2j/YOJbQ/ikL3JLqFEOvJv7KcjNMV1t9em2ES6D
         3G/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736175228; x=1736780028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Cm5BHzkLMiGmJECEJ3DZxDN9rXYzkgE7TWnIYfzD6A=;
        b=BXjDlbiet9Zm1yp+VnDpV/bhUoscxAKt/MiyBChP+6+QaCCA/v5MWUerFns1lBUBCG
         jLp195j9soIiS+9qPvtuhb803S0FWsQ5E6TQ7T4KxzS0gqPQzb1/adYDy3MPmwDNRWg/
         KMFi7gMJkg2d3Ow/t3Q/lHxtHe7JBzymb3VNxIkjqFTpjMZOaYpy0dK6pcWKNIsV16b0
         Ly5+NTtvAuhADsTTitLjpmf7G3pAOWfTwpYrhf15Fn7O1pHjqMVqN3hlEu1RIhQqlllH
         yvB3sr9MkXdJefCq6t8rM+b48u7FcIQdWndLuE4rlG9QY8GvZQdEzEVFc06G18O7i7R8
         Fikg==
X-Gm-Message-State: AOJu0YzYjUtpxNHYOBqnT2vu79Cyd8cfOh2FuVcd+hBd1Ssuh2VJfXoM
	Zb2VPi1khn5EIdBHYaHLGcYhe4QiVmQAF2lg+CxpmPtBHcGSet3ZRbyoSzYaR+ly88hF
X-Gm-Gg: ASbGncsji6RAuQA4YzVuTIjXf7sTROJUXW/p8KoOrO0JkdLCRexJqaV86nwSzbcYarB
	MffZq4yEp8FJQ0OG0lv0LaOikpLXiB2j85q1NhGtgH9/PAdZ6T0t6Gsl3ZUiVG8GKfMUZR23yLe
	Vx0oK54qJp8KrmdQyxqUK3KdBEhZDr1BzgEVcaK2BOGs8Vqo94oL0k85bcM45JqSdQlNsKQRJ5A
	65kqjefynLJ01R71kJ1qnfa0YKrXcP5HJmEQh1GthlLWAPm4q7QibaKTBVu5RYro5rHsTgJRas=
X-Google-Smtp-Source: AGHT+IG+uRI20fCi0uyRbwjUlbwVvjlKSWVT/BHfQ+CrEe6mRL9xXME8HKQ+xEE/5/1cx79l/ep6Hg==
X-Received: by 2002:a5d:584e:0:b0:385:ee59:44f1 with SMTP id ffacd0b85a97d-38a221fad17mr51468506f8f.20.1736175227941;
        Mon, 06 Jan 2025 06:53:47 -0800 (PST)
Received: from babis.. ([2a02:3033:700:3ba2:3837:7343:334:7680])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832e74sm47389982f8f.30.2025.01.06.06.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 06:53:47 -0800 (PST)
From: Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>
Subject: [PATCH bpf-next 0/4] expose number of map entries to userspace
Date: Mon,  6 Jan 2025 15:53:24 +0100
Message-ID: <20250106145328.399610-1-charalampos.stylianopoulos@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series provides an easy way for userspace applications to
query the number of entries currently present in a map.

Currently, the number of entries in a map is accessible only from kernel space
and eBPF programs. A userspace program that wants to track map utilization has to
create and attach an eBPF program solely for that purpose.

This series makes the number of entries in a map easily accessible, by extending the
main bpf syscall with a new command. The command supports only maps that already
track utilization, namely hash maps, LPM maps and queue/stack maps.

Charalampos Stylianopoulos (4):
  bpf: Add map_num_entries map op
  bpf: Add bpf command to get number of map entries
  libbpf: Add support for MAP_GET_NUM_ENTRIES command
  selftests/bpf: Add tests for bpf_map_get_num_entries

 include/linux/bpf.h                           |  3 ++
 include/linux/bpf_local_storage.h             |  1 +
 include/uapi/linux/bpf.h                      | 17 +++++++++
 kernel/bpf/devmap.c                           | 14 ++++++++
 kernel/bpf/hashtab.c                          | 10 ++++++
 kernel/bpf/lpm_trie.c                         |  8 +++++
 kernel/bpf/queue_stack_maps.c                 | 11 +++++-
 kernel/bpf/syscall.c                          | 32 +++++++++++++++++
 tools/include/uapi/linux/bpf.h                | 17 +++++++++
 tools/lib/bpf/bpf.c                           | 16 +++++++++
 tools/lib/bpf/bpf.h                           |  2 ++
 tools/lib/bpf/libbpf.map                      |  1 +
 .../bpf/map_tests/lpm_trie_map_basic_ops.c    |  5 +++
 tools/testing/selftests/bpf/test_maps.c       | 35 +++++++++++++++++++
 14 files changed, 171 insertions(+), 1 deletion(-)

-- 
2.43.0


