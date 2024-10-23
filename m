Return-Path: <bpf+bounces-42866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 695669ABCF2
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 06:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA6F1C222E3
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 04:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083CE73451;
	Wed, 23 Oct 2024 04:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YICRrAhE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9BA5672
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 04:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729658350; cv=none; b=szm28ntbYxunC7PptPu752ket0GaJHYTopcdoKLhHY3xB5U+29JY9ic5+aWfQClnyeRXj+FXBbuc/vvSEYhhod/MJPtugFGDolaACIXxIVzrVOIN16F6Jzas5XZLVzZpmndND38pVe4wRWm5KgGX6B19Ra6AXfa64Wure6I4/vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729658350; c=relaxed/simple;
	bh=AfpJNFadodE7r+prBz77He+SZV9OGn9yaoMs79SE0cM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CymoS5l3ZedQ3/NM0OVkjUKsaYcJw147SpHkyxoQ0DULM5eLE9t5/SeSsGz1PlXwgPsbn27ur3zypRGjel3rGFtOu6ASxU9NUwdN+1qgsgT6sc9+3WnItgPkR54q78D+f3ySOJXX+i0r77mcQ3cuddReyuHr11h1PQr6L8A+57Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YICRrAhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD50BC4CEC6;
	Wed, 23 Oct 2024 04:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729658350;
	bh=AfpJNFadodE7r+prBz77He+SZV9OGn9yaoMs79SE0cM=;
	h=From:To:Cc:Subject:Date:From;
	b=YICRrAhEj5aA52QJWcPXTYQ95kGQoh1d8vMt6LQB0+oPXOpdzCx4RpgSkc2Q1v88K
	 ZUR44CiwVf9w4eaauBLrCpJxwXM9ZrFr4r0eQMr2HZCVrzUKWHdjXZPahMd/rx2aHt
	 TG2eDCwHOzPBwTd9CD5OQUsgsr1BJvGMUKhKlDnowayZ1mazzsW8VyEe0X4Yh8tZYC
	 Upa+HIqTQSsB7OAV61a0aU4nD7rNBW1BpP6sY6F6WpQZcETGQkX+CQW4BQSRNdzvs/
	 44WOdDIrpR/rU+n+zJhabEz94eooNkpM+8AFbl5eBUPhc/VfYq0POa620i8R2QMVBY
	 9FJI/PfUtErzg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 0/3] Fix libbpf's bpf_object and BPF subskel interoperability
Date: Tue, 22 Oct 2024 21:39:05 -0700
Message-ID: <20241023043908.3834423-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix libbpf's global data map mmap()'ing logic to make BPF objects loaded
through generic bpf_object__load() API interoperable with BPF subskeleton
instantiated from such BPF object. The issue is in re-mmap()'ing of global
data maps after BPF object is loaded into kernel, which is currently done in
BPF skeleton-specific code, and should instead be done in generic and common
bpf_object_load() logic.

See patch #2 for the fix, patch #3 for the selftests.  Patch #1 is preliminary
fix for existing spin_lock selftests which currently works by accident.

Andrii Nakryiko (3):
  selftests/bpf: fix test_spin_lock_fail.c's global vars usage
  libbpf: move global data mmap()'ing into bpf_object__load()
  selftests/bpf: validate generic bpf_object and subskel APIs work
    together

 tools/lib/bpf/libbpf.c                        | 83 +++++++++----------
 .../selftests/bpf/prog_tests/subskeleton.c    | 76 ++++++++++++++++-
 .../selftests/bpf/progs/test_spin_lock_fail.c |  4 +-
 3 files changed, 117 insertions(+), 46 deletions(-)

-- 
2.43.5


