Return-Path: <bpf+bounces-59377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEF8AC970B
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 23:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E0FA432DB
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 21:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0707211A27;
	Fri, 30 May 2025 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="iYnByFLp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F497207A20
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640678; cv=none; b=u+lHeh8e29eWNRl8/Cs/BbrmlZi4zBw9iUz8s0Kluv3diCWXluH8M2dtXRvF88spsuGjrKBCiWxthYhbTDwnR/Ys/GCt/L1Ga3+wY47t3GwvNvn7C27Z5Q8I8XK+0g/ALd8X68BKiijdvNyV9w6GrRrCXYEVIN49CCtlx/kwcXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640678; c=relaxed/simple;
	bh=Xt7U1x3SkNTaDSR5L1DVqg/uyQUndXVGHRE3Zd14eVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kaPKP6YtLzBUZrteOPfRbZH4EzALLWezbGawKDXMilQiZ164JiHCJu6EdzagIrNqgLyMs+jrBE1goAnjnHY7hQs7e8J5Sm1IPKKxKfEh/FuxgPXnRqhviik5h89lwjR2DN2O/PXmmjihQiXtv8axdGLPHL/q0vVzCvBS+LWkbgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=iYnByFLp; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b2ed1bc24fcso131971a12.0
        for <bpf@vger.kernel.org>; Fri, 30 May 2025 14:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1748640674; x=1749245474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=81pEAwXmixuxAF0u6MPMjW9qRqViI6uiK6RzRIZYnIg=;
        b=iYnByFLpQ2unbJPdd+hbFJY48Jsm9x5z7mAgEAvr9e/BN+D5vAE41rPIQv1a3lyeK7
         KtDenp5sBOnH7P2n0nN7WjKZbDsGnwDCIRoAUdrQj+I9iO6G6HPgz567wa/IEb1p4+SW
         ENZe0m31OrNtVZ2zAa0VZtMMzpxp4cIHEZsCgO8wIPhIejyOPRCiIqJ4LvPdfFVn5IK5
         CK7CycN/FCowU75GCoatFJAT3/kqOg1RTMFBcKrPmSfXzplS1EXq8NGcdOcDtpgj1WP9
         gb818z1L1/7fH29ftWUv8wfui/uN0euMCahFf/slemETdAFegf/2G0t/AWNamJQ2sv6h
         jgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748640674; x=1749245474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81pEAwXmixuxAF0u6MPMjW9qRqViI6uiK6RzRIZYnIg=;
        b=kYW+R1y6dSJBrakU1m7QYMHoP+ZfiCh6TZFudFKfv/wSqcEB54fNGKR4MnCzws9W0c
         HJ5aLUx/Vccqkwi3fm6iypGKlQ7FRBu9TqYverbddRXeLtJmi85ldeg6UG/vz6q2+nZF
         R7OqCiBXF1dy+dXd8r72qMztT9vj7xvadrLSw7RD+cHYM/JAG8+9AjGaOCuqwa1eVKTf
         KUBGKiA/eGwWs475bO+oKQI2br1gMz4huoFzGTJEnND3/2Cxa+t1rcLTb9eBtshOVjNZ
         E/I+LtKtzkBMBHwrUUXHHOd+Mwk/ZJGcRRYUEPilMu8ypHkieOgp0xG468Wmm+sJymP9
         kY2g==
X-Forwarded-Encrypted: i=1; AJvYcCVPzv12xGYta9/YoS04IaNqnn02ylXEHnJYJhAeyHCMV5s8izHcrZooCCyTwjP+FkW/qq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTQKgzQM+a9yByQteg/3riKRMXskecObMH4EYxcoZAvESVetF8
	R3ZR1Sex29btejVlufpa9DOL6+an+peYeUMZ7OrSUtrB4INUmIRU2P2i+a6yq9Swa1Y=
X-Gm-Gg: ASbGncsaXn8KXQxJ1QkKnYvhwR7JYvd64Xg4o7EEZfpN9Eo35QD35bWBXkwq/xXdE63
	4K2HWLIfWptA0qXufHQceIlhuQPNv7n6gcKRO0okjIpIbxNzdN5y3UXlKDcBh4SlRipHiBj5FL8
	m/Pvr7uDa+f/4QfA9Xibn1qRaI6RsZkKll3QNIYePRX7rO+Paa8Nfs+0pcp51x5odNDfLM9F2O+
	USW1f36PTFJ5VSgGfWHnxhVfDd5O8mDYIZOSr+erX4vo3UVhHHJvydwxfYCUlbc1WQ5FLwF+m79
	VOATItck0albLauz/Mx6ClXAkU42g1levZSaRywG
X-Google-Smtp-Source: AGHT+IGInKghMC3FVP3+MvP9tl2QdYAbj0QI/SPMlxBeXh7/RCRQhPksSTBDIon4fv0NeHdAXgzyGw==
X-Received: by 2002:a05:6a20:12c4:b0:1ee:e1a4:2b4a with SMTP id adf61e73a8af0-21adea18fddmr2143955637.2.1748640674106;
        Fri, 30 May 2025 14:31:14 -0700 (PDT)
Received: from t14.. ([2607:fb91:20c7:44b2:2a24:2057:271e:f269])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed4399sm3496763b3a.77.2025.05.30.14.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 14:31:13 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v2 bpf-next 00/12] bpf: tcp: Exactly-once socket iteration
Date: Fri, 30 May 2025 14:30:42 -0700
Message-ID: <20250530213059.3156216-1-jordan@jrife.io>
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
bucket changes between reads which can lead to repeated or skipped
sockets. Instead, this series remembers the cookies of the sockets we
haven't seen yet in the current bucket and resumes from the first cookie
in that list that we can find on the next iteration.

This is a continuation of the work started in [1]. This series largely
replicates the patterns applied to UDP socket iterators, applying them
instead to TCP socket iterators.

CHANGES
=======
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

 net/ipv4/tcp_ipv4.c                           | 263 +++++++---
 .../bpf/prog_tests/sock_iter_batch.c          | 450 +++++++++++++++++-
 .../selftests/bpf/progs/sock_iter_batch.c     |  37 +-
 3 files changed, 668 insertions(+), 82 deletions(-)

-- 
2.43.0


