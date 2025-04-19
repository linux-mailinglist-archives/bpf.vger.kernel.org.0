Return-Path: <bpf+bounces-56275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D01A94449
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 17:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF4D3B70BE
	for <lists+bpf@lfdr.de>; Sat, 19 Apr 2025 15:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C511DE4EF;
	Sat, 19 Apr 2025 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="YqYCReDj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE41312CD88
	for <bpf@vger.kernel.org>; Sat, 19 Apr 2025 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745078290; cv=none; b=goveC7/SHjqXOSpXapId5OK304a+hUW+fR+L2oYfgT3HzgRGxlBl5SP7n4AVnpzyZDJn5ZqpftwSGxPQ7y8QvVAsj5qPz22f/L/rhrkYnvmCPBMXDdDAFsiUxqgJTELCTNMmVT6EgJ+gpoqqMG+sBVjbyuM83/hKhR9TCEi7sAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745078290; c=relaxed/simple;
	bh=nvlqyikZJ/U4ImbX/bBoQtmgzj4BJ67DyemEaSa0Ru4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bGbTn3amBnLiZMHM3Su4+nMRDPnE+FNEOcfq2LXymWHymRdXP34c9X6VIyU6yGbd0ySzuILPtCPqGFvQUvImsrBtV3QrEwYyodNRBoZkGuH3TSrjgQYlCdco07NBYJEF51q/wSTbCW6/FC6k2e/iuogLvpmX7AiGQTwq+gS/kP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=YqYCReDj; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b01d8d976faso132048a12.0
        for <bpf@vger.kernel.org>; Sat, 19 Apr 2025 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745078288; x=1745683088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6fKfB3XJd64b+N65P0pXj0X+UdOKktGfoMcY+HXcf/g=;
        b=YqYCReDjUUAyuuKm6/tLrf131Gk8lby7kQhHoUYUTH77OniTO8xzNVr6vxlHzsesQ6
         l3oXbxddqx7zMfi2JCiI6mYtw3QiBKqKlSUYd5owLgyxQE20oLwKEJghkU+8nSvW+wuN
         TQSMT/v4di7gn+3QxeaP7JsOrZwqKIH0zoj879+l8dnQWPZCJBsfZp5CHPD1zmSFUwed
         EuUYz2OUFLBT0hm3DP86cTfb6Px10hCxnTzXRJcsaaIzaHCLQ7ojmyzPCkRx9fd4pX7Y
         nk6g4jSeqc7XaxtUXBqVkBtaiWfBZX7WTwDqrZG8o3Sm3oGjYhZzab5EMl3R8VYgHRQ0
         2EcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745078288; x=1745683088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6fKfB3XJd64b+N65P0pXj0X+UdOKktGfoMcY+HXcf/g=;
        b=l30q6DTTyeiJFIlWUMW/Tz1qpghxjGDCTpNqUqkxxIyf0K2AyITVeD1FNeStE5urus
         T+3/UW/HdTxphN/ytqpP/FiDhtZSKqlueCTccR0y49gz5ffQLF2XQaSQZuk0aVo3fGK8
         9mIywYrhSs5mF8vXV1Z0R0+haJKMAhzl60uC99eWhOHsUoktZfC2FU/yFU7A6zn662te
         X6XvcUZhFrqvjjY+1n7LEanxE7U2bbrYtGD1wl4KbmMqRpBOrfWSOnGIPq70gS2GAwf5
         kTvTCqYojuZ0YA/PCB7E/YN6sQxGD+xcth+75VciwA53/bZ4uGm2K5seUufANpHgRjpg
         LqAg==
X-Forwarded-Encrypted: i=1; AJvYcCV08qd/nfjVloAmIQSGw7P538hli69jh0xkph81v29tWlckscZ3yeUDvSSLoy9Z/T2TOAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKUGqQ7wzsCvETExsHKfJmfovYx5CfHjkTUVAa5NH8OMMDf6O4
	bdMzb3bfd1Fgji7xtsfbLZmU9q05m1AnLbJFauwp6ig4glcbmnWIpGG6GwrODYOffiBdUwGnAtn
	aFaQ=
X-Gm-Gg: ASbGncv2gkKu/xhATsrclprfA6b4/OXhcgnT1KNdr7LZu6mP1jZfOpvvocd8TTI+VJm
	IYfjxBwobWu2xNNgiNitzfXrjaUIukTQboIr72Ihdf/z72IKH+sRIwmUskugvlJ2UFfqYMy2wn1
	huCgv+7gIKDcnnuCl55c57qd/nIzptqxuNuDxbGD5Q+DIdt55a036PDcWIzUUHrv8ve/qQ5+m0G
	40br898/N9htVom30IrVkdUYkyZhScuBndsQIWsfQRenjl1tjoD7ZKByz8/SoUSeyRvuGE++Vlu
	pFRWTyON16Pa4OqAPLHETRsGKr/dAhgNKfax9Q/i
X-Google-Smtp-Source: AGHT+IHwCUXYRQfzbuMq7NhJLdnfmV6RLTeTxvI/RcU7jl4JTyY0HR2ZfN7IDu/zAV26z55a6ugeaw==
X-Received: by 2002:a05:6a00:3a15:b0:732:18b2:948 with SMTP id d2e1a72fcca58-73dc1411326mr3126536b3a.1.1745078287810;
        Sat, 19 Apr 2025 08:58:07 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:1195:fa96:2874:6b2c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8be876sm3464157b3a.36.2025.04.19.08.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 08:58:07 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v4 bpf-next 0/6] bpf: udp: Exactly-once socket iteration
Date: Sat, 19 Apr 2025 08:57:57 -0700
Message-ID: <20250419155804.2337261-1-jordan@jrife.io>
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
iteration. This series focuses on UDP socket iterators, but a later
series will apply a similar approach to TCP socket iterators.

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
v3 -> v4:
* Explicitly assign sk = NULL on !iter->end_sk exit condition
  (Kuniyuki).
* Reword the commit message of patch two ("bpf: udp: Make sure
  iter->batch always contains a full bucket snapshot") to make the
  reasoning for GFP_ATOMIC more clear.

v2 -> v3:
* Guarantee that iter->batch is always a full snapshot of a bucket to
  prevent socket repeat scenarios [3]. This supercedes the patch from v2
  that simply propagated ENOMEM up from bpf_iter_udp_batch and covers
  the scenario where the batch size is still too small after a realloc.
* Fix up self tests (Martin)
  * ASSERT_EQ(nread, sizeof(out), "nread") instead of
    ASSERT_GE(nread, 1, "nread) in read_n.
  * Use ASSERT_OK and ASSERT_OK_FD in several places.
  * Add missing free(counts) to do_resume_test.
  * Move int local_port declaration to the top of do_resume_test.
  * Remove unnecessary guards before close and free.

v1 -> v2:
* Drop WARN_ON_ONCE from bpf_iter_udp_realloc_batch (Kuniyuki).
* Fixed memcpy size parameter in bpf_iter_udp_realloc_batch; before it
  was missing sizeof(elem) * (Kuniyuki).
* Move "bpf: udp: Propagate ENOMEM up from bpf_iter_udp_batch" to patch
  two in the series (Kuniyuki).

rfc [1] -> v1:
* Use hlist_entry_safe directly to retrieve the first socket in the
  current bucket's linked list instead of immediately breaking from
  udp_portaddr_for_each_entry (Martin).
* Cancel iteration if bpf_iter_udp_realloc_batch() can't grab enough
  memory to contain a full snapshot of the current bucket to prevent
  unwanted skips or repeats [2].

[1]: https://lore.kernel.org/bpf/20250404220221.1665428-1-jordan@jrife.io/
[2]: https://lore.kernel.org/bpf/CABi4-ogUtMrH8-NVB6W8Xg_F_KDLq=yy-yu-tKr2udXE2Mu1Lg@mail.gmail.com/
[3]: https://lore.kernel.org/bpf/d323d417-3e8b-48af-ae94-bc28469ac0c1@linux.dev/

Jordan Rife (6):
  bpf: udp: Make mem flags configurable through
    bpf_iter_udp_realloc_batch
  bpf: udp: Make sure iter->batch always contains a full bucket snapshot
  bpf: udp: Use bpf_udp_iter_batch_item for bpf_udp_iter_state batch
    items
  bpf: udp: Avoid socket skips and repeats during iteration
  selftests/bpf: Return socket cookies from sock_iter_batch progs
  selftests/bpf: Add tests for bucket resume logic in UDP socket
    iterators

 include/linux/udp.h                           |   3 +
 net/ipv4/udp.c                                | 159 +++++--
 .../bpf/prog_tests/sock_iter_batch.c          | 447 +++++++++++++++++-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/sock_iter_batch.c     |  24 +-
 5 files changed, 577 insertions(+), 57 deletions(-)

-- 
2.43.0


