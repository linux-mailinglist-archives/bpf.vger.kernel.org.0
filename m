Return-Path: <bpf+bounces-56853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A21FA9F7D8
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 20:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40B31A83697
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 18:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2CD294A18;
	Mon, 28 Apr 2025 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="m7UQ8s+h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3AE1A5BA3
	for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863248; cv=none; b=BcutpF7AW+xVFSs8oYFyt/3SJoZNza/PnQPSWDl+o2NRIPv7hLevxSsz7C6h41qzeCQfCtMNYFjQcjhRSgjQTkwAVmbsDtl6iSjYRCVY3e7S/JA356iI5peXX3Dj9ZTCFlEekY25m7FN0iI4WT0ip7myfE+FNvatDJ2DLRd/Czk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863248; c=relaxed/simple;
	bh=1ivyw4Y9y3TODmgYoOOZHusZCOWtntzgFTbNSjnUM68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S9UCiw4nOU2i1Ux6xf2kXsfl5rBef8vAcDD/69Puen8p9IlhFQoMBOAknb6U2Rr1WCFmhln6GEoXHkpPDeyVPVIMXbEMRudwm1OUHNLZ1EGPfWGOlTOkD9EBFuq7I9oCuW+585FWMBcmG0yW/mwTCXfgnvH5nzxcLjtP56mbthU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=m7UQ8s+h; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2240b4de10eso10779835ad.1
        for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 11:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1745863245; x=1746468045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TfzYGNdsbq2kEtlPXMGG5yPjkzXAaMFdnpD1Df27WIg=;
        b=m7UQ8s+hzcWjSeuD42/Re62kP1M+0o/YplbYkUDMm+pmjPXIDoBggYqAhWOXqXGCPb
         NoFZLm445hnNkH2U5T1sL4Ah9/WW44D5nObPXd9d2BBijuDfafjVWpawpR6HED9OHt1X
         6x54WQ4aFwqIDsFeZ1/wnlcB/6V8CCr6KIV6/pRxUb5cI6ULUqWGK3o8DcROxOkI11T6
         OIvXZAJTP2mziuLOYWOh3fzx0GRaOynR1iPF0Hugkc5/hbXjUFHpYchz8XrB3LZg7acH
         yxHPax9ZEQZNdHKEaUlPueAZRpJcLnsS+aySTUl1NK0f0wtbKJf+fpfXQo3IoYYESzUW
         a95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745863245; x=1746468045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TfzYGNdsbq2kEtlPXMGG5yPjkzXAaMFdnpD1Df27WIg=;
        b=wTFVviAj9PDTIWaYR9fs+EXsGuQgLh9DCIopcLtqlOSGwrzdaihuOinCXCCQuv5Qta
         HL9TUmm/KGd4fLvT0UwmH02M5HZ4tpi81rCLadvCUFzTBeZqdUmDx1zBizbP2zEiOz8W
         O6ZarRrKAxlgibWk3Pe2zOtQV8h+A0f7KOgg21I1awWGaTGNrxnrfcAfLYE04DBEhq9b
         QW2U8SLPcEuuLaAt2r+jV5AEYeswgWs2OFBo1IrkFm91hK2CpceS5MyHvIsiSjIK8Y9m
         76DrJRTQuyqUHlkBss7n/5NrR1JHxw9qJtSD2a76vs/tzOawygzTDAaqDJl9yf+SoWYh
         /snA==
X-Forwarded-Encrypted: i=1; AJvYcCWweTH5b4Sv57SOrBcqgh0nw71Uc+IJC+lBbuQnRFC89W0fO+P6zzj6Of9lj15mQ97q8AU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqh1TyqBMhdPENeJTPzz8zTtyjBpgvf5DrGVDIRqKx/El1BN2e
	ASHp9RRinBJ7pASLb2Ki/shryWqvTlylpwEClLf9nHv40piOZBDu8sgCCeA4mx8=
X-Gm-Gg: ASbGncu00cE3Wdz6b9DqDNxgomn3cwf/kICwLlZE1ThuDQaAEhtF6+8hYCX0dpEm8Az
	Ic1sDTnk91pJsaTVo53mp08EjJZxIhTqOS2GX4B9rMUg/YbxINnk2LvERHD7MZClh7O4exTNyqc
	6crw2HSZcw9aGpowBQYKHE7nolG1WrViVPfGeikOYBdgtPeWnGfad2eE+jOmeKaJKUzNah3+Pgb
	79jssoFi31ygoYkCLAckwLXrXrnOliRybNJpPLwNBMYM76S+FgGpHr+/dvZhqiH75nOcks2Mv5U
	5wfT11Q5xXyAvcf9180Z61wRwg==
X-Google-Smtp-Source: AGHT+IGq/Z3LeqQ8rNrO46K/kgwUUASqNmVangsSjWOSntmpjzlW1XIPvg5M0x46IJcivxIed/IDeQ==
X-Received: by 2002:a17:903:198d:b0:221:751f:dab9 with SMTP id d9443c01a7336-22de6f21c2amr122155ad.14.1745863245138;
        Mon, 28 Apr 2025 11:00:45 -0700 (PDT)
Received: from t14.. ([104.133.9.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52214ebsm86204235ad.246.2025.04.28.11.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 11:00:44 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v6 bpf-next 0/7] bpf: udp: Exactly-once socket iteration
Date: Mon, 28 Apr 2025 11:00:24 -0700
Message-ID: <20250428180036.369192-1-jordan@jrife.io>
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
v5 -> v6:
* Rework the logic in patch two ("bpf: udp: Make sure iter->batch
  always contains a full bucket snapshot") again to simplify it:
  * Only try realloc with GFP_USER one time instead of two (Alexei).
  * v5 introduced a second call to bpf_iter_udp_realloc_batch inside the
    loop to handle the GFP_ATOMIC case. In v6, move the GFP_USER case
    inside the loop as well, so it's all in once place. This, I feel,
    makes it a bit easier to understand the control flow. Consequently,
    it also simplifies the logic outside the loop.
* Use GFP_NOWAIT instead of GFP_ATOMIC to avoid depleting memory
  reserves, since iterators are not critical operation (Alexei). Alexei
  suggested using __GFP_NOWARN as well with GFP_NOWAIT, but this is
  already set inside bpf_iter_udp_realloc_batch, so no change was needed
  there.
* Introduce patch three ("bpf: udp: Get rid of st_bucket_done") to
  simplify things further, since with patch two, st_bucket_done == true
  is equivalent to iter->cur_sk == iter->end_sk.
* In patch five ("bpf: udp: Avoid socket skips and repeats during
  iteration"), initialize iter->state.bucket to -1 so that on the first
  call to bpf_iter_udp_batch, the resume_bucket condition is not hit.
  This avoids adding a special case to the condition around
  bpf_iter_udp_resume for bucket zero.

v4 -> v5:
* Rework the logic from patch two ("bpf: udp: Make sure iter->batch
  always contains a full bucket snapshot") to move the handling of the
  GFP_ATOMIC case inside the main loop and get rid of the extra lock
  variable. This makes the logic clearer and makes it clearer that the
  bucket lock is always released (Martin).
* Introduce udp_portaddr_for_each_entry_from in patch two instead of
  patch four ("bpf: udp: Avoid socket skips and repeats during
  iteration"), since patch two now needs to be able to resume list
  iteration from an arbitrary point in the GFP_ATOMIC case.
* Similarly, introduce the memcpy inside bpf_iter_udp_realloc_batch in
  patch two instead of patch four, since in the GFP_ATOMIC case the new
  batch needs to remember the sockets from the old batch.
* Use sock_gen_cookie instead of __sock_gen_cookie inside
  bpf_iter_udp_put_batch, since it can be called from a preemptible
  context (Martin).

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

Jordan Rife (7):
  bpf: udp: Make mem flags configurable through
    bpf_iter_udp_realloc_batch
  bpf: udp: Make sure iter->batch always contains a full bucket snapshot
  bpf: udp: Get rid of st_bucket_done
  bpf: udp: Use bpf_udp_iter_batch_item for bpf_udp_iter_state batch
    items
  bpf: udp: Avoid socket skips and repeats during iteration
  selftests/bpf: Return socket cookies from sock_iter_batch progs
  selftests/bpf: Add tests for bucket resume logic in UDP socket
    iterators

 include/linux/udp.h                           |   3 +
 net/ipv4/udp.c                                | 173 ++++---
 .../bpf/prog_tests/sock_iter_batch.c          | 447 +++++++++++++++++-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/sock_iter_batch.c     |  24 +-
 5 files changed, 575 insertions(+), 73 deletions(-)

-- 
2.43.0


