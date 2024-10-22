Return-Path: <bpf+bounces-42788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E89819AB20D
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 17:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A371F253D2
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 15:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2E31A3BC0;
	Tue, 22 Oct 2024 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b4Tv1609"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4D5139CE2
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610959; cv=none; b=o+ZfpWlBLqW2TW7fuaG0FzYT+42S1TeEv1Ze5zMeWhZhCVXzFjoBsNSTtjv5s+ChMTLhaADM5jwkqfCldo517uE2xIQDOL0lUV8eQSyDS6D66xuA6ML6TrDQCXuONeQlKLd/lyqpBiWsxK0gaulRwl2Qncmj40WTZKCwzpFBhqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610959; c=relaxed/simple;
	bh=AVHQdyjmODZpdCOtuBHcLgFbP4dCsqQ3defZwhN46S8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m4I052y14siXQXKbZj45s3yYzOPdkJ62yy2xcR0pGQNMviaoqYRjFFoFtCo7NXcgmbrINU3YuyiTIqF0e180EjDmdDDutbMZKrlVB3+44gLAe9tFWQITyOjQzdHnGurjUcEs2Z90YZlgRTtehm8VWcQRQ86qri00lFCLwqSVZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b4Tv1609; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e2c6a5fc86so5416407a91.2
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 08:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729610957; x=1730215757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JzVIdkphVy6VCB+khzDa62+1PBT7rr/AZQaCe6/5n3s=;
        b=b4Tv1609VoZZFWF/+MDnGRNI9bGuKO6zL9cdsTz5pAbk4O9Egdxa9rc9VNPcm6xkzk
         ei8ibDafakyjQJjkVGtDIjlojQoNK+T4kolohR3SUFuoytfvFRQvZ8/oLA4P5UZnYuWd
         ted1RS084uFy+2Tp5xBm/ikMSU60vmr7a271eyYtXJNlnerq+kdjBYp4WLrUGb4OAkB7
         sFuQcGnsFYdkzlYxUKKPdI1yPESzdikd+QuumLBY6bc/wiBoJGdhynNcGrd4W37XaLZQ
         xi4p4jjQIEeW8cDsgfwzu+sdow+4GR3yIFgN10DG+bG0/aObATwDNh745BFeDbb9x7SB
         8K5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729610957; x=1730215757;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JzVIdkphVy6VCB+khzDa62+1PBT7rr/AZQaCe6/5n3s=;
        b=OHTPfwkA94Wy7t7/EWTGj5E47X2J0onGos6Mw2LylieWa7aFA5q/x/0oHfdzxLv61N
         yNmlTSwXWXW+YE9YAH+QoEzLQjsBMwCrG0R2WR57UoRrEphG/BLtpM4vEYQq2SaBz+hR
         FJ4UalGtyGdVaTqelcCSbd67utFI+Re9AIOwxTX7mO92PE1mlxjIslZv/5UIAKOnp/cC
         fWRnzZqqOuYlFTPP7maQG1JFJbqvwjbz+kkS+NiRg1KuW0r7BSkMye7FnkgJZzgx8wm5
         IWPpRy42Q8jZmTZqtcSm44/PHmjwbUKy8AIz3vKXFTB7RRF+a6V/cff7hg3R5nTgypd/
         y24w==
X-Gm-Message-State: AOJu0YzIpbaxMrmTEsH2hIPOHmkcETVkLG74UGFEvdWwE0+e7kaJJhcA
	LW/nBqXeCTXaZFs3p2qQSr6VmFeDKplKt1zDdHt8R6Xgx8C8O/XlL0LFSr9OD4UKlEQukimI67r
	6r0ibfSqu7VkC8f8s4YghRfs66mWhePLD/kJigAO1T0ReGCKc64UiDxbfgs+ii423qitFTaUNJf
	gt3uu8xSaiG0hY6ONqZMphSZw=
X-Google-Smtp-Source: AGHT+IGwcz/pUSBYuldFca3TxUcJHChZIavks6kQTWuGxmKjTJGzCxMUOarWkF1lSgYb4PLig7p/EQIuqg==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:a17:90a:fb46:b0:2e2:af52:a7b4 with SMTP id
 98e67ed59e1d1-2e561a55cf1mr28674a91.8.1729610955483; Tue, 22 Oct 2024
 08:29:15 -0700 (PDT)
Date: Tue, 22 Oct 2024 15:29:00 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241022152913.574836-1-jrife@google.com>
Subject: [PATCH bpf-next v2 0/4] Retire test_sock.c
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Daniel T. Lee" <danieltimlee@gmail.com>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series migrates test cases out of test_sock.c to
prog_tests-style tests. It moves all BPF_CGROUP_INET4_POST_BIND and
BPF_CGROUP_INET6_POST_BIND test cases into a new prog_test,
sock_post_bind.c, while reimplementing all LOAD_REJECT test cases as
verifier tests in progs/verifier_sock.c. Finally, it moves remaining
BPF_CGROUP_INET_SOCK_CREATE test coverage into prog_tests/sock_create.c
before retiring test_sock.c completely.

Changes
=======
v1->v2:
- Remove superfluous verbose bool from the top of sock_post_bind.c.
- Use ASSERT_OK_FD instead of ASSERT_GE to test cgroup_fd validity.
- Run sock_post_bind tests in their own namespace, "sock_post_bind".

Jordan Rife (4):
  selftests/bpf: Migrate *_POST_BIND test cases to prog_tests
  selftests/bpf: Migrate LOAD_REJECT test cases to prog_tests
  selftests/bpf: Migrate BPF_CGROUP_INET_SOCK_CREATE test cases to
    prog_tests
  selftests/bpf: Retire test_sock.c

 tools/testing/selftests/bpf/.gitignore        |   1 -
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/prog_tests/sock_create.c    |  35 ++-
 .../sock_post_bind.c}                         | 256 +++++-------------
 .../selftests/bpf/progs/verifier_sock.c       |  60 ++++
 5 files changed, 150 insertions(+), 205 deletions(-)
 rename tools/testing/selftests/bpf/{test_sock.c => prog_tests/sock_post_bind.c} (64%)

-- 
2.47.0.105.g07ac214952-goog


