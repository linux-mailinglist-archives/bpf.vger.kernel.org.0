Return-Path: <bpf+bounces-62847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86650AFF51D
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 01:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6108248786B
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 23:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4093E238C25;
	Wed,  9 Jul 2025 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="TgViNMRs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AEB1E9B3D
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 23:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102220; cv=none; b=QKjuVZBvK+NHvgc2ky2BdZ30Qj+rPEE8bd/mmfxId2V28y0P60TLTaCgsuMvRkVCzqXwwOaxtduVm2PSE1xbGo7qYNLdjfJNCCWKXiRTKGRSQeMgeIqF8LQL4WRx6kIVimJnLtbaNXh11i5LA+FpQh0kwx80aUVFNcxQMlor1rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102220; c=relaxed/simple;
	bh=G4l0U8v6qtxX2a5Cv67gQ62BBvPc0uOfHuT7rjhuE3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XCeljZKCMtUjCsNgICY2R9jGWzHm2f/PJlZOHQWdYxiKQETYF6alirt5gmJEC1/31NyNCrTIWxcJvfHFA2kNz8Lb6/Nt2+aNREhGiHKpqvwC+r/NjuJHHOhtHcI3Danzi4roG/56OvZTtmjj1r7JKB/uIKLrgzOSOqk86COupuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=TgViNMRs; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313067339e9so66498a91.2
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 16:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752102218; x=1752707018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2sq61u4s3i6R9XZ54TUym9J43VKll7/XUlJYVOqxzKg=;
        b=TgViNMRscb9vAlxt2+pvWheWBvdnnIwk+o4awc03P5LKLgp8OdEfC6Qp+22MweBE8t
         p+vPuoQ/A1kEz3xkhvK/VnEP0CUjdKTfOEHni8Cd7h58XMltFUhgZt5YK0SWg1MY+gyf
         Jdp1N2eUyGDmJojeshHOBcxyx8TW/fHCdSj6HFta9AFBf9ygjM0VrgDf/q3iqzSaIw8H
         pNy/cWZ69Eb/Cf47VL3VczXHAAuKo7/pthX7ng41+VwcaVV7wTPunaFkWI2RyPJPnkpH
         Ux674aEg1FfDPCIZyldeAJ9I2dcrud9J4O3S/3YwIBDn9ca471t74VZ/zuKDh3QmWE+6
         5Img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752102218; x=1752707018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2sq61u4s3i6R9XZ54TUym9J43VKll7/XUlJYVOqxzKg=;
        b=dL3b4fohyHrIZBQxgHi1B1dZWzg9uKI3vWQkcz2MCiP1mx3Ser5xZmAkyGbwJOtKwx
         qtRtkZKkGX7kNucDgpwZkyQPHWPZVQHspT+mpJh/A17UWwRcAwr9GMfYHgYq8aHfxO4X
         AMIlAlACrvVbPqKU3UK3dyuZz+M/p7/9POo6kYcWxiz09S09ubGYskkbgqjPXxid8czj
         IMcRK7M4ww+LZliTTw+e34jV3s63hZGVb7jHKxEJ9oZUYVb7elj7y7adEbJ7vhjl5H96
         Midq7nt3OQH1TWjBXnRfNWeD1QvjBwZWAi3878Ytv81XTM8+0oe+uHFzjqiw5t+pG6+e
         rP7A==
X-Forwarded-Encrypted: i=1; AJvYcCWvJ4Onv7gOsIuvhjtN3Nyok6gMBrvYSwlTAckYe3mNSbyn80hL6gbsTAbaC4GbjQ3ulrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW0oyfIAQ1JPIlYWQ6dH8IyQa4CfPima32/F9Tnmj/tX066F77
	OjaPDwzZFRf8lBKU8pnLG9Ey5LuRt+fbMD5bq8doCzEZ19zbveWAW8dy7TRpCrJgEc0=
X-Gm-Gg: ASbGncucZaw8Qpep4DDmroZN+sAV5EpkP/mOFDp0ZLrkYZg1YtJOLKt1zrsXrA/SQwq
	rilcUfvlpLNOkt62WkX2UR9kI2YVHSxcAWIjOOakNuRhd1A2PhPH9tI2zEhHQYZ7Dsh8MtQnnAT
	Fkvhy8Kfam21OZhIyXtV9QxkuNAboJBat+il7wSUo8U23miXq5RJTaBqNXkgB/Nxfu0oQzcjiQt
	LIca0fD+WY192hW69K8mYWXHEigmsIpdJJyILiAUjfehRR+7bs/qU78aKSl343Z/Z9Ri5XVikUl
	8tuSsRykDr8Tm5eoX7L0YOdGqO0KBKd3xqctb5FU/SM35lZGtbD+qIARlrB3Bw==
X-Google-Smtp-Source: AGHT+IFmHXoB3Ip2CYkHzoQba1frxutSZauyCNbFz6O0zRGhCMs4xjVFfuEHYlOG1qTdToIk4vXeqg==
X-Received: by 2002:a17:90b:5848:b0:311:b0ec:135e with SMTP id 98e67ed59e1d1-31c2fcc49c0mr2503233a91.2.1752102217932;
        Wed, 09 Jul 2025 16:03:37 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d121:1d56:91c1:bbff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad212sm2679015ad.80.2025.07.09.16.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 16:03:37 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH v5 bpf-next 00/12] bpf: tcp: Exactly-once socket iteration
Date: Wed,  9 Jul 2025 16:03:20 -0700
Message-ID: <20250709230333.926222-1-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TCP socket iterators use iter->offset to track progress through a
bucket, which is a measure of the number of matching sockets from the
current bucket that have been seen or processed by the iterator. On
subsequent iterations, if the current bucket has unprocessed items, we
skip at least iter->offset matching items in the bucket before adding
any remaining items to the next batch. However, iter->offset isn't
always an accurate measure of "things already seen" when the underlying
bucket changes between reads, which can lead to repeated or skipped
sockets. Instead, this series remembers the cookies of the sockets we
haven't seen yet in the current bucket and resumes from the first cookie
in that list that we can find on the next iteration.

This is a continuation of the work started in [1]. This series largely
replicates the patterns applied to UDP socket iterators, applying them
instead to TCP socket iterators.

CHANGES
=======
v4 -> v5:
* Move WARN_ON_ONCE before the `done` label in patch two ("bpf: tcp:
  Make sure iter->batch always contains a full bucket snapshot"")
  (Martin).
* Remove unnecessary kfunc declaration in patch eleven ("selftests/bpf:
  Create iter_tcp_destroy test program") (Martin).
* Make sure to close the socket fd at the end of `destroy` in patch
  twelve ("selftests/bpf: Add tests for bucket resume logic in
  established sockets") (Martin).

v3 -> v4:
* Drop braces around sk_nulls_for_each_from in patch five ("bpf: tcp:
  Avoid socket skips and repeats during iteration") (Stanislav).
* Add a break after the TCP_SEQ_STATE_ESTABLISHED case in patch five
  (Stanislav).
* Add an `if (sock_type == SOCK_STREAM)` check before assigning
  TCP_LISTEN to skel->rodata->ss in patch eight ("selftests/bpf: Allow
  for iteration over multiple states") to more clearly express the
  intent that the option is only consumed for SOCK_STREAM tests
  (Stanislav).
* Move the `i = 0` assignment into the for loop in patch ten
  ("selftests/bpf: Create established sockets in socket iterator
  tests") (Stanislav).

v2 -> v3:
* Unroll the loop inside bpf_iter_tcp_batch to make the logic easier to
  follow in patch two ("bpf: tcp: Make sure iter->batch always contains
  a full bucket snapshot"). This gets rid of the `resizes` variable from
  v2 and eliminates the extra conditional that checks how many batch
  resize attempts have occurred so far (Stanislav).
    Note: This changes the behavior slightly. Before, in the case that
    the second call to tcp_seek_last_pos (and later bpf_iter_tcp_resume)
    advances to a new bucket, which may happen if the current bucket is
    emptied after releasing its lock, the `resizes` "budget" would be
    reset, the net effect being that we would try a batch resize with
    GFP_USER at most once per bucket. Now, we try to resize the batch
    with GFP_USER at most once per call, so it makes it slightly more
    likely that we hit the GFP_NOWAIT scenario. However, this edge case
    should be rare in practice anyway, and the new behavior is more or
    less consistent with the original retry logic, so avoid the loop and
    prefer code clarity.
* Move the call to bpf_iter_tcp_put_batch out of
  bpf_iter_tcp_realloc_batch and call it directly before invoking
  bpf_iter_tcp_realloc_batch with GFP_USER inside bpf_iter_tcp_batch.
  /Don't/ call it before invoking bpf_iter_tcp_realloc_batch the second
  time while we hold the lock with GFP_NOWAIT. This avoids a conditional
  inside bpf_iter_tcp_realloc_batch from v2 that only calls
  bpf_iter_tcp_put_batch if flags != GFP_NOWAIT and is a bit more
  explicit (Stanislav).
* Adjust patch five ("bpf: tcp: Avoid socket skips and repeats during
  iteration") to fit with the new logic in patch two.

v1 -> v2:
* In patch five ("bpf: tcp: Avoid socket skips and repeats during
  iteration"), remove unnecessary bucket bounds checks in
  bpf_iter_tcp_resume. In either case, if st->bucket is outside the
  current table's range then bpf_iter_tcp_resume_* calls *_get_first
  which immediately returns NULL anyway and the logic will fall through.
  (Martin)
* Add a check at the top of bpf_iter_tcp_resume_listening and
  bpf_iter_tcp_resume_established to see if we're done with the current
  bucket and advance it immediately instead of wasting time finding the
  first matching socket in that bucket with
  (listening|established)_get_first. In v1, we originally discussed
  adding logic to advance the bucket in bpf_iter_tcp_seq_next and
  bpf_iter_tcp_seq_stop, but after trying this the logic seemed harder
  to track. Overall, keeping everything inside bpf_iter_tcp_resume_*
  seemed a bit clearer. (Martin)
* Instead of using a timeout in the last patch ("selftests/bpf: Add
  tests for bucket resume logic in established sockets") to wait for
  sockets to leave the ehash table after calling close(), use
  bpf_sock_destroy to deterministically destroy and remove them. This
  introduces one more patch ("selftests/bpf: Create iter_tcp_destroy
  test program") to create the iterator program that destroys a selected
  socket. Drive this through a destroy() function in the last patch
  which, just like close(), accepts a socket file descriptor. (Martin)
* Introduce one more patch ("selftests/bpf: Allow for iteration over
  multiple states") to fix a latent bug in iter_tcp_soreuse where the
  sk->sk_state != TCP_LISTEN check was ignored. Add the "ss" variable to
  allow test code to configure which socket states to allow.

[1]: https://lore.kernel.org/bpf/20250502161528.264630-1-jordan@jrife.io/

Jordan Rife (12):
  bpf: tcp: Make mem flags configurable through
    bpf_iter_tcp_realloc_batch
  bpf: tcp: Make sure iter->batch always contains a full bucket snapshot
  bpf: tcp: Get rid of st_bucket_done
  bpf: tcp: Use bpf_tcp_iter_batch_item for bpf_tcp_iter_state batch
    items
  bpf: tcp: Avoid socket skips and repeats during iteration
  selftests/bpf: Add tests for bucket resume logic in listening sockets
  selftests/bpf: Allow for iteration over multiple ports
  selftests/bpf: Allow for iteration over multiple states
  selftests/bpf: Make ehash buckets configurable in socket iterator
    tests
  selftests/bpf: Create established sockets in socket iterator tests
  selftests/bpf: Create iter_tcp_destroy test program
  selftests/bpf: Add tests for bucket resume logic in established
    sockets

 net/ipv4/tcp_ipv4.c                           | 269 ++++++++---
 .../bpf/prog_tests/sock_iter_batch.c          | 452 +++++++++++++++++-
 .../selftests/bpf/progs/sock_iter_batch.c     |  36 +-
 3 files changed, 673 insertions(+), 84 deletions(-)

-- 
2.43.0


