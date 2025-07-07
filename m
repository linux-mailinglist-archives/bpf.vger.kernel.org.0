Return-Path: <bpf+bounces-62522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A23AFB7EC
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 17:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9AE1896BA7
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 15:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2995C213245;
	Mon,  7 Jul 2025 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="OaCq2/T4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FB8202F93
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903470; cv=none; b=qPZvUkogsNICluqoJEfUVh26JP/e5n02zSUhmCEcojoF21rL3HpEKInfUiJxqt27ngQpGD3tKBRpj5hEYtp9MckByKllqoKSGAIorWxnMZfHOIlbi4jKV4LqAC7PHIGQ9kVapWaDxlO1Lv8LgnF+rpzrLp6Ja2mOSa9vvzEeRv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903470; c=relaxed/simple;
	bh=VVVX0l/wLhMBdJXjwvBvhwp4QVtRT3glhvwXyYbEs9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e9d1IsP94/boZNs+5Qe8wU26LHU9LUsUDFCLpcZpMYscuUU6qb6MgDdsYmLoo5/nsSPpkEhtQUAGR4DWYWCUCmE2LIovRtPHpu4cOknOhzMoSjAhMbYqwEKFAdND9Mia+AZ+UCpaEgUbaYn1ZJry6vdmBumtZITlPkX5lV5q/OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=OaCq2/T4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2369da67bacso3507745ad.3
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 08:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751903468; x=1752508268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bX8nuaSudf4HTlD7nl8OQzT6HPtIGxyDdNBJy0yDRpI=;
        b=OaCq2/T4TYLCfZSMAwJxCWZ0PJ1nzYS/CmM1ydNlwT0bRodtZ1NTg76HgE8R/T979q
         zABxx2KrQ7DbUm7W9jqqNeA3VqnoW+OW77gchJht6hG4pQ3n1kyIw4wnAtqgfryPCfbS
         lVSfX/ELR5hu3Z5N6PPCAW4VlBpT4IoKKcFJEDq29/wAFLQFdqqc+4kJgh5OVmmprgHS
         ZwPCja59Cm1p76Tg532prM3jAxGU3+RplTjHFfhuVa4udWkEvegUL2Og1C/UijMN5Cmi
         EChV5305UjcEFhrm+ky6vRDOSG6Yym430pj7ob66qb8LgD/gVPjs/1qzxH56BkoO496O
         6ybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903468; x=1752508268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bX8nuaSudf4HTlD7nl8OQzT6HPtIGxyDdNBJy0yDRpI=;
        b=dQcCpBNm6pe1cDSugrBu9LACaRwoOnx2Vs1pq2VL6+5EXNSoQEkfRKDNi5EsHt5KdC
         RGxuglhn9SAb5gfCQmvp9weNDAVcE4l7SIP9iB8SQX2Mg7HSkaRKrRSG8/N1ZN7pOHmZ
         F9hy2L8Gd8Ms1vhNdV3XCMrSRKryiFwujlavtGzwYgBAF+EFW42rtS+pGVc25+hog3Mi
         M+DfNjy6fDOb71TX++SlN5RhvI9f2+4ubODFvpvsrDDXAiOXoAntJydNZPjfiIRVkzpf
         qS+UoMKP8hStHCOLSKXCj66lk2iex7rO/viMsAlQT8+S/CHA3+TPkLfJDxWA2K4ElTu/
         T04w==
X-Forwarded-Encrypted: i=1; AJvYcCVvsNBHS1xiqx8j0+TiR8KrCKJ2fLDsdiGW+MpgkTBHk4rsbgWWHMulT7tur8RKzv9Kp6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUlYVz9Tk/Zj+SrDWQ6Ins8eCseIlVZkuFTHp0Q636APbwUL4Q
	iVYx+zcVAFkdj5DiMobYSVhq4jlGw167qt1dAUpcN/dwpBXDvbA72upF9szwFq/b3/0=
X-Gm-Gg: ASbGncsta08cYWSUX9+Lpo/0rfE4xzLqShwFRteL4bQ4cXNDQdkfPZTxF0yH8FL0ph1
	Vfz2M1sRr0ROwJ52GpcQ2z2lDxDQUXGf8wEfexz/pQRFuugsOBkkgu6NaO1ArgNwvH9j/+nOgqu
	5gobPe5i62Cjx5/Xzrd2pNlaS2jNQ4MrtUZPTeiUV81+H+2B1rS9tWjMa15e9xN+lRLgo2yqnBx
	0ZerU3GQ5dR8dAq25D6cdo9sneojZPJpIofbGkb0kosoDxhan5C6PCqvOkdQLDc66q8Uk3uiZrg
	Ag7+vE3374AEOjaLYUUqLwiDtz7b8eNQFjtuCa1Lp0uPYtMCSJ7pAaIvlxJseQ==
X-Google-Smtp-Source: AGHT+IHnSiIxsn/3ZSz6Us8rp0zLkpStznUVMmfHJN6y4AGWM02wY7zbQHjfn6DT4U45/DMg1XRP9Q==
X-Received: by 2002:a17:903:2347:b0:234:e170:88f3 with SMTP id d9443c01a7336-23c87282944mr80494485ad.8.1751903467847;
        Mon, 07 Jul 2025 08:51:07 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:e505:eb21:1277:21f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455eb3bsm95772065ad.115.2025.07.07.08.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:51:07 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 00/12] bpf: tcp: Exactly-once socket iteration
Date: Mon,  7 Jul 2025 08:50:48 -0700
Message-ID: <20250707155102.672692-1-jordan@jrife.io>
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
 .../bpf/prog_tests/sock_iter_batch.c          | 451 +++++++++++++++++-
 .../selftests/bpf/progs/sock_iter_batch.c     |  37 +-
 3 files changed, 673 insertions(+), 84 deletions(-)

-- 
2.43.0


