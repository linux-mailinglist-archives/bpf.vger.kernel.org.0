Return-Path: <bpf+bounces-49260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8D6A15E05
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 17:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A1018866F2
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 16:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0A7194C6A;
	Sat, 18 Jan 2025 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dn+HLmx4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F83023CE
	for <bpf@vger.kernel.org>; Sat, 18 Jan 2025 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737217363; cv=none; b=p/hqRuBnWVajGbZQu7sLVgb6G9SzqI0xClp6l0UylEt35huICLwn8Bq21aWOS876O5xGY433xA5DQM4792cPUNjyLuCvwTieN8vEbb38KHOFH+4nQ53IFXuK9ybzwfiqxbVJsudSnNCGwKjHVDNIKTO0/EVyFXTevlCl35vZ7kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737217363; c=relaxed/simple;
	bh=5p4ItbMToZwwYA9GNsDo+BMoWJMduWW0XI6v9wwTwv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=neF8zQiNsElPEsIm+ktFKfQj4/JDyu71kLOEKt4lqv1fArWkMCQRNMv6ae72XetJLFs74hzYsGKvRUjswyxVzmI/Wp/KmLxsFOuSQ9ci7XArnpeEc+JbL7zBglrcWipkIS8g5rDglybHXTZ2ADwsgXIdqLYS5X3A0XzxmFPYEfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dn+HLmx4; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so1737874f8f.0
        for <bpf@vger.kernel.org>; Sat, 18 Jan 2025 08:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737217360; x=1737822160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+SBx6T4Bvo2QyagMGx04/SiZMuQ89l9xxUIYSubLEds=;
        b=dn+HLmx4FC+vSSsSCpWQqiGym7+EVD1Lx+z+bKBVpNV/H0RSc1Fs9SOjeqiZ0nDQ7K
         NnJo65CIBPAYU80DMGauZ36o30y038035x+mO4Gxa+oGmLFmzSFXqtBKdP8N5bP6HAyd
         2/bEKJBDbC7Bofv0960T1qz5w2smfqXcwy8/ZzzcJYVPFYxF9zuJDicVoitK8mJq6EMG
         40N2XDhW+awOcphun1NN5M4sxnqx6NKpAq2m2lsZELVl+Vl7Ek9onapI4L6mtV7IWNKy
         ONWsgaSANiposO/eAvMmiE1zwtl7d1tR7UN9fdBF5WPm6GEhNnThzA1w2LS4mDE4Jhvp
         43JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737217360; x=1737822160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+SBx6T4Bvo2QyagMGx04/SiZMuQ89l9xxUIYSubLEds=;
        b=U/pwuj9N/sYzMjH6XigpXe3XUBM+w6Tm9rDjTd6rQCLNnJFCYWY2Fk83OYZzZzntIP
         oC/vwC7nsTtleLnu37BkC50tpJKZPTCm7cc8pFPzxu6Ls/w3q7pNhniWXc5qF17K2hra
         BeWcJoyDfPkDFDZL1eFgHuW6IZYriTXm9tSIeub2i1+bMow7ietDsimmAw5DCZ/JYQoj
         3tJiCegm6tE/OLZevS9yVPeKOWwp3VINFLa/XTaHkShii01WrArM90g0KEB8O8SJ/dlp
         Rq4o6cJE75AcgZKi5IDJwAcPonhCUtWjZC3t+SvgZS+VADURrtZ25B3TG7nlvexzZtZl
         FzlA==
X-Gm-Message-State: AOJu0YwLfXSr5388Rn5/Hx+3qVGdP58xJUMxE51l90X3jX1CQMQ/oAMN
	O/xSXT+DUqzCdq1prakcRE+uCerWnFP+pPEqNwgZ+dpSDho4sAazFueRuhq08XI=
X-Gm-Gg: ASbGnculFQyQeEpFcOOceiR0JVHGELx/3WkIDR3+b4GRn5bda0CXpI1PDa2fnAEmhoh
	j1t7hf3nXNhNIY7LhxsV5YRfvod6GOiPakV+ckIZT23oa0fj7NbVu7jJXKnWFt9tfRxHt68E7il
	KwMsMxkSNAfpXnCw/DdVtpmyZUkJ3klKGKpJjOf6VScRYSan9j1U8nGJzMACHZIVWqJwlWrHimn
	5Pi/mXRwfExa92Anzsrytx0gp81qvyOjnL3KgNzPzz6rPayn+qcE2aqQj+lU/MY9/52Zh0=
X-Google-Smtp-Source: AGHT+IEKXmxZ/KqaOcASabRIJ4cPrAy8eVMBQAMpG7UOfWf89GfNbGhSQ8I1UG2dX39QDZDzP9NwMg==
X-Received: by 2002:a5d:5f91:0:b0:386:4a16:dadb with SMTP id ffacd0b85a97d-38bec4fb615mr10703044f8f.11.1737217359944;
        Sat, 18 Jan 2025 08:22:39 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:1b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3221a5csm5612744f8f.34.2025.01.18.08.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 08:22:39 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/2] Arena Queued Spin Lock
Date: Sat, 18 Jan 2025 08:22:36 -0800
Message-ID: <20250118162238.2621311-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782; h=from:subject; bh=5p4ItbMToZwwYA9GNsDo+BMoWJMduWW0XI6v9wwTwv4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBni9T7JFXWDC4HtFPScZ4uUcBUl+z0Ulh/Cjds1UhK kRmzHeCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ4vU+wAKCRBM4MiGSL8RyoAQD/ wICK7D9cInNxSdYnC5nNh06//TKpkmzbqVax+57HQxMQ50vV3UsYIvBDjbagzGXB3ZNcCeTviSLP9b EIwRQ95VgET2n7V4ab706hZzXrHNVwZayClSKkpH8Hz7TRnMQFlUL2NHR6n1mwOds4xgKWVGmULVJq wfyUrALEBa55+1JNCnucu+++hH5RZQYNLIOqe/loNd1vw2A8gqDL/Favo3ihODHfsKpFR29jPqCZEw Ok5c3Z3PCcGEOx8xxJsomyS0qmiwJW9KOwQ1X3VtXzRPj1utZ6W28SzZo+EMpaO9x9mxxrntj1Q/f/ Gvni9CD8vXclzpzg2p6tXGkao31ScwpVTDs+3YpTgcGd9OI4lsOoQrZfzIpWqb16A0SnfvFi5pGS6l D0OZc9CjBPmz+GA4RQ5vsTclBZCts44h91hReIu5ZGa57lqdWNzKTQG9eSFO8jri9RDI3o0oa9KZE/ cRH6AxQAliWnJPgS3+9cYmZVKvSfZpxLPBTkYhH53MkzLsEcSC6V/uIU8uJbDGo6AuNlXDe8lz1AcE sWdtNfv6ZdkUrt/7cgv2BDSBXyoey6jjE9JVCv1boLaUKL/sk/YDLtYgVEHIsiOVFbk4Yy2Xn7HWDp F6fYb3XvJsvkW2zujXbWcaNzWkPJ+BxLQ04TV6r+5bwwz/wcg54esle+aTBA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Hello,

This set provides an implementation of queued spin lock for arena.
There is no support for resiliency and recovering from deadlocks yet.

These are split out from the rqspinlock patch set as independent pieces.

The maximum number of supported CPUs is 1024, but this can be increased
in the future if necessary.

The API supports returning an error, so resiliency support can be added
in the future.

I don't return ETIMEDOUT when cond_break fires. First we don't clean up
the queue properly when it fires, so the lock and arena is already
corrupt if a deadlock condition is triggered. Second, it's not trivial
to bubble up the error from xchg_tail and other helpers (like
smp_cond_load_*). It is better to instead implement resilient spin lock
support if we want to support proper unwinding in case of deadlock
errors.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20250117223754.1020174-1-memxor@gmail.com

 * Fix definition of lock in selftest

Kumar Kartikeya Dwivedi (2):
  selftests/bpf: Introduce qspinlock for BPF arena
  selftests/bpf: Add tests for qspinlock in BPF arena

 .../selftests/bpf/bpf_arena_qspinlock.h       | 441 ++++++++++++++++++
 tools/testing/selftests/bpf/bpf_atomic.h      | 121 +++++
 .../bpf/prog_tests/arena_spin_lock.c          |  68 +++
 .../selftests/bpf/progs/arena_spin_lock.c     |  49 ++
 4 files changed, 679 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/bpf_arena_qspinlock.h
 create mode 100644 tools/testing/selftests/bpf/bpf_atomic.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_spin_lock.c


base-commit: 01f3ce5328c405179b2c69ea047c423dad2bfa6d
-- 
2.43.5


