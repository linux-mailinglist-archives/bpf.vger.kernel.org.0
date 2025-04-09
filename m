Return-Path: <bpf+bounces-55565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6055A82E88
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 20:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADF78841CD
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 18:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE7F277802;
	Wed,  9 Apr 2025 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="wBW8r3ko"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4176027703E
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 18:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744222967; cv=none; b=pzbJpJBqG6fqp3z6RbfAdYzdk0SFFo0e+LeD8WAmfdGG4jHFoD8apUseQxpKtuHofFVdDRCQAdR/fDvq2u3eg6icNblLQF7F8TBMn4N0TbODQluKGWdAIgNYAXFajQ1Vk4ue/7+ffgnLebMFol1JW1ytSyyadaA7pZL7m6kWKRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744222967; c=relaxed/simple;
	bh=asV59gizBv28GYBxQFhVdeBj72VUNG4eA59XM+R9eGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qkt48mnvSmZB2bTF0CaCLEpsqdPAIADV+4P062VXTITbV+e9FFu/WzqTBrLu/cFx0Pwigrcsm+OPmxNjNT9vIBj1ZiB1Rq3pgjSGYtQ5N+lqcQQ5K1XMcsgeIe0NQp1TOFPJ4X2c+4hdke3d5LkqgQjXda8NA5jRVXosMiZAwKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=wBW8r3ko; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7376e00c0a2so1024005b3a.3
        for <bpf@vger.kernel.org>; Wed, 09 Apr 2025 11:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744222963; x=1744827763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=llAd+HuXJY4PF9PO8i7LUmSbuK/5+LgxQcJzR0u8KiU=;
        b=wBW8r3koDjklPDPQBPacdyqRnFUviHjc6cKtvWbT9Z29fv7wH1iWnIAbmqOLlil4F+
         n629TUB9rraWG6ECgKWBpMSiFQaODevv7umuxzdN7/lXxpOvJ5HaSIaFjY3D2G1uHYZl
         KAtEPVNL702A8sTIKbYvWnEacZuRuf8TYy26kpedrmwp3/I32O3CBBayMh0HJWcZIRqN
         O4XH6kyMXGNv/sKk2M3HFH9lSfIczJ2oiBx3uROxoSsbCVUY4yi6ghAi26J4pGURBUMR
         5hghDqimwrdbDa/wHZXiZ3L0Mt6vF7sfdaBgpCWM/OuM67ruBpb0vYpg18IHmtNRyW4I
         oLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744222963; x=1744827763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=llAd+HuXJY4PF9PO8i7LUmSbuK/5+LgxQcJzR0u8KiU=;
        b=XZ1wvG9OPiTlWBMITq/0zSKPEzsnUyaZe2yuj7Ah2wDBjF9CCkgeEVjYeiW8A6tRMp
         UIsoRr2B08FiYrUqN9wZrpPw2P6dz/hz6jEsEJfOXvjqrQ34MqQvliQVzVbvOEEtx/bg
         uLhC1qnISRxD1LmqyDok3AbSMQ2SDSAxcVImnNijVHsel0X45erv2E6FktInjldi2JZa
         QSxxgYdMFrt/ixeoMrnIxLOBittcoInE+RU+FXRPDPWH9+mIuuGU5d0YmNSL3oP8xMH0
         WIF8RCiZkgSmfUpPGvmaAZOiavvcBlpxl/dfGFO/T6J5WqtDQxLTtuCD/ks+2HoqE5Ni
         2Liw==
X-Forwarded-Encrypted: i=1; AJvYcCVCbnalVQD90t8cRvXyiOue/wfJxv07KSq04ZYgw49Oqsk2ifc71+0hgacOuEBD7icvdcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvLE7lR04cGTdklFgHL/Vn9NLhx3vq/wji9pq6eY6gp7VSEQ4A
	KxHdqdmqR4o8fWAIvImazfdPDHjO2fc06gE1FuqLHYAbT3wVQt5WeSOVfsntCA0=
X-Gm-Gg: ASbGnctEzGtrzVFM77OW6hgSv7tCUJeYUPBozVUqdjZDcenUIyTWbMurvSikQ/LSKP5
	0C7J7fE8/4GNqHg4cqQ7IIbX2R1gy8P1CJM5lE5ordN4f+qbXodwkuPRBpN8zuKKsO6rZk9apgX
	9igmqZr7wdw4eSchqFiWWzvMuH5Y0oCYL5uDtK93wjcYqJj+uGaPZ9tEjzG7Ht6OBZKwMXtemsq
	z9SGdRRBiB8h4f6ZA0f40bBfgrG/c4OaTAuUIrgDHVFXpyRxUJsiZV/ElVD392KKJVwElGOQ2S8
	x3zyn3h5VxnetJTFm5P3eEozbkgKjg==
X-Google-Smtp-Source: AGHT+IGY4bFfOWbz1dmRXNq0KDY1qv1phdze5+/tT5DlyUhOCoI9gZGA/5f4fb86PmoqVSYT5LEDZQ==
X-Received: by 2002:a05:6a00:1309:b0:736:355b:5df6 with SMTP id d2e1a72fcca58-73bafd6d4aemr1415641b3a.6.1744222962340;
        Wed, 09 Apr 2025 11:22:42 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:2f6b:1a9a:d8b7:a414])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d2ae5fsm1673021b3a.20.2025.04.09.11.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:22:42 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v1 bpf-next 0/5] Exactly-once UDP socket iteration
Date: Wed,  9 Apr 2025 11:22:29 -0700
Message-ID: <20250409182237.441532-1-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both UDP and TCP socket iterators use iter->offset to track progress
through a bucket, which is a measure of the number of matching sockets
from the current bucket that have been seen or processed by the
iterator. On subsequent iterations, if the current bucket has
unprocessed items, we skip at least iter->offset matching items in the
bucket before adding any remaining items to the next batch. However,
iter->offset isn't always an accurate measure of "things already seen"
when the underlying bucket changes between reads which can lead to
repeated or skipped sockets. Instead, this series remembers the cookies
of the sockets we haven't seen yet in the current bucket and resumes
from the first cookie in that list that we can find on the next
iteration.

To be more specific, this series replaces struct sock **batch inside
struct bpf_udp_iter_state with union bpf_udp_iter_batch_item *batch,
where union bpf_udp_iter_batch_item can contain either a pointer to a
socket or a socket cookie. During reads, batch contains pointers to all
sockets in the current batch while between reads batch contains all the
cookies of the sockets in the current bucket that have yet to be
processed. On subsequent reads, when iteration resumes,
bpf_iter_udp_batch finds the first saved cookie that matches a socket in
the bucket's socket list and picks up from there to construct the next
batch. On average, assuming it's rare that the next socket disappears
before the next read occurs, we should only need to scan as much as we
did with the offset-based approach to find the starting point. In the
case that the next socket is no longer there, we keep scanning through
the saved cookies list until we find a match. The worst case is when
none of the sockets from last time exist anymore, but again, this should
be rare.

CHANGES
=======
rfc [1] -> v1:
* Use hlist_entry_safe directly to retrieve the first socket in the
  current bucket's linked list instead of immediately breaking from
  udp_portaddr_for_each_entry (Martin).
* Cancel iteration if bpf_iter_udp_realloc_batch() can't grab enough
  memory to contain a full snapshot of the current bucket to prevent
  unwanted skips or repeats [2].

[1]: https://lore.kernel.org/bpf/20250404220221.1665428-1-jordan@jrife.io/
[2]: https://lore.kernel.org/bpf/CABi4-ogUtMrH8-NVB6W8Xg_F_KDLq=yy-yu-tKr2udXE2Mu1Lg@mail.gmail.com/

Jordan Rife (5):
  bpf: udp: Use bpf_udp_iter_batch_item for bpf_udp_iter_state batch
    items
  bpf: udp: Avoid socket skips and repeats during iteration
  bpf: udp: Propagate ENOMEM up from bpf_iter_udp_batch
  selftests/bpf: Return socket cookies from sock_iter_batch progs
  selftests/bpf: Add tests for bucket resume logic in UDP socket
    iterators

 include/linux/udp.h                           |   3 +
 net/ipv4/udp.c                                | 101 +++-
 .../bpf/prog_tests/sock_iter_batch.c          | 451 +++++++++++++++++-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/sock_iter_batch.c     |  24 +-
 5 files changed, 538 insertions(+), 42 deletions(-)

-- 
2.43.0


