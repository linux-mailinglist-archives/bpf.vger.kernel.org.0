Return-Path: <bpf+bounces-63223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B592B04721
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 20:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56DC34A0DE6
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 18:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C6026C3A4;
	Mon, 14 Jul 2025 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="NU0ssmkK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F7826A087
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516570; cv=none; b=j1R306bbIcRYU+kC86wYVgbXopxbZ6VUA00K4NsgLNHEuDzNVLAu1Ga85V31DhJwxsxfQTOqkJpKTT3H4mDZsO8/QA90TWaTB0dhP4G+6C9kUcRbgih1WJEwcsGijSrM7DTQStLyoNm9QNDn2Cop2w/jnbK5Y/JnhXcf1Km5kO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516570; c=relaxed/simple;
	bh=bxxFogUP1oFJd3d2e7LXv1WV66TV2hKEyk3AFHWrq/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=trBcgaNee2I0/uMH8v5jAAYrXI5hqEykZ7RY3iiyBuKGJV+vbqyPJOOAiHLcrEzf9tu5O2vpbPG5jwUTRlc1UEO2W/M6fH9uHfgOrLd2FR/s9DiOiEG950u6MFa3XGNwEHQ4osA49EManHyWqr5le0e9E7yk2do/t/0BuGBI/As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=NU0ssmkK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23de2b47a48so4981695ad.2
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 11:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752516567; x=1753121367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UCIeepe8RfVctcxWkoxn2Xqz4Sfp2ySYQyPBvgJjOjs=;
        b=NU0ssmkKYBbFwRT/7kFXozy/eZUK9eUpLOkxPIpUpu/7JM905uhLuDL0SlR8L+ZJcd
         lHOnAK6UG45gYFGJgdeQr8aoIyQDZ8+44wv6W9Slr9Fq/SzdKfkn1lczZ9cLv8DpIbyK
         IlMMPC5iyDSuTD5v9ORR3P6lmq4C5JxP9Ny8Lrnvw6eUC0qJpccsaO2v7S/yvjvNIh3P
         Hvee9UR6RbqFKBN3+kd3Nxnbd7/rah3Zr0Y3Rnaybfzlke4nDuqjOI18/IJOyNpIv9rG
         VWl3FsxyhBGT5z0XnFspLpeXhFK0YO7OodxMJrY3SXgrQm864Ko5Wgmn/KsLz4a58G5g
         I01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516567; x=1753121367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCIeepe8RfVctcxWkoxn2Xqz4Sfp2ySYQyPBvgJjOjs=;
        b=REc/d0U9kxhzt9neWKqkIk9qdRlHXZ6np/CWWg+05WnZxFjwwP2jdOKColC7xTL4by
         YzXb8AOQJheAdiM+b9cjLaTtUr86mZlk0Qzy9x+Z19+w6304oEOxZQqjIS677FFfcw3c
         MpHCOcr0wHRRM/Uzh/4u/sLxuT9fJxT53h6VbFGybXQhb5lxmBcHSpT9v8RLWOvqueUk
         27ooiZxGWUQD6nOo+4eX4XrZnih+CmxWEOeBSoCb4ajI7hYXhX2bew1Q6D6SJdDrC4Ph
         CArMvB56yp8UvazTtMLrKzVS3dVTVyGolFNpucNNNorMmgcnAsj9mATDAAXg8VAo+fue
         n/VQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+m5oNJtLaXt3awhM2za3j+GioKXW5QX2sjG3WWVBqvbpeO9vlXjXsNNYYjr4BJiM25vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFwo8KGJ2gT290Ho6pPVM8MWr1Pdrhz4o7+/v3zLQL+UOrjTlL
	+/6H+bvjqD8r2Wq8Y+x4A0zcfYEC2vaOOEKNGwAg1oyjBSyczqNUI4tP96JokCMuvho=
X-Gm-Gg: ASbGncvzJz6A25wcM5ZHubvf1It0W+LQUj6y9+XPGN3KCpC9xCxTLhDbpCUnmqe/Ykh
	M8SXq6eC66/dJvyrxeFjpKmYAw2GOSbGjb/eGfjUdx/Z+zNBkSGeYleE8O4G6hbLFeMerPXM/g1
	ZGgwAQRWtob8SGyd0GsxNEDXAMIcsfm8XFHSk/RZODOQAX4JC+2basr46+eyY9Y30p3DafmUtL7
	z3j+UPkprHYtn8DdHObiCkIwZDn1F/FyLUzs8wpvUKPRRno9CmNRhFPPJ9LH0zxrJd3NLXJRnm0
	lyI8OcbTIcnLCbDxT1W88Jka/GU60vW5/rrSJq52Zy5Gvdc9EHUhCTg2ZzpZDN2wEDiCnJjidGB
	EcdFuJ8rnog==
X-Google-Smtp-Source: AGHT+IFzfrE5MqiPgJJWw1On6i9rxwd3VZ8RAZkUcfW6mxZA8sYTKwvf5KmfJzvI9R/s/mBJUFtFww==
X-Received: by 2002:a17:902:c40a:b0:23c:8f17:5e2f with SMTP id d9443c01a7336-23dede497e0mr85368255ad.4.1752516567327;
        Mon, 14 Jul 2025 11:09:27 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:84d3:3b84:b221:e691])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aeadcsm98126405ad.78.2025.07.14.11.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:09:27 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 00/12] bpf: tcp: Exactly-once socket iteration
Date: Mon, 14 Jul 2025 11:09:04 -0700
Message-ID: <20250714180919.127192-1-jordan@jrife.io>
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
v5 -> v6:
* In patch ten ("selftests/bpf: Create established sockets in socket
  iterator tests"), use poll() to choose a socket that has a connection
  ready to be accept()ed. Before, connect_to_server would set the
  O_NONBLOCK flag on all listening sockets so that accept_from_one could
  loop through them all and find the one that connect_to_addr_str
  connected to. However, this is subtly buggy and could potentially lead
  to test flakes, since the 3 way handshake isn't necessarily done when
  connect returns, so it's possible none of the accept() calls succeed.
  Use poll() instead to guarantee that the socket we accept() from is
  ready and eliminate the need for the O_NONBLOCK flag (Martin).

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

 net/ipv4/tcp_ipv4.c                           | 269 +++++++---
 .../bpf/prog_tests/sock_iter_batch.c          | 461 +++++++++++++++++-
 .../selftests/bpf/progs/sock_iter_batch.c     |  36 +-
 3 files changed, 682 insertions(+), 84 deletions(-)

-- 
2.43.0


