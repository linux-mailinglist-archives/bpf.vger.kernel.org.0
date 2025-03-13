Return-Path: <bpf+bounces-54009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CF8A605FD
	for <lists+bpf@lfdr.de>; Fri, 14 Mar 2025 00:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4F018862B5
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 23:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6337C1FDE24;
	Thu, 13 Mar 2025 23:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WawCNW98"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6E11F9F79
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 23:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908980; cv=none; b=OoQGWUtVA6V2pdqV3AgZyJoNVoL144B8pbECICelST4Su3PL2y1cUo3BlOddZh5vyjocS7NNAu84l0lPYfY1j6FsNoALTuDSfTvXvKTHwiA/DGyrnvySjYX7uhhAijqktVT5QZX6MXtV7VAncy3shAgRol2o8HgkBr98ocFI9O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908980; c=relaxed/simple;
	bh=xS3KwElzny9P/4D1l1BeiGcPBm8EB+1tVWV8PbJUwQg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MT8xafKFkoDv4hp3N+WA3S0TCi2fJpBum1Bk95nwzErilV/zmufD1aTmVSFHjvhh+nk3Zd0m+h0XQkKMTevXLkO3T4aflJH9FHJ+tQRHy1L0kowPgeb3wDt27oagyM58dC2F772TVRrLf0VzoAVtVddNrM73vZRz4U6QIB6ift8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WawCNW98; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-300fefb8e05so2503861a91.3
        for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 16:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741908978; x=1742513778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PTt4zbFyi/lWw6EXiC897VD1Joy4OZVjaIf4sel6ss4=;
        b=WawCNW98GgZkCSMI/SC5VDC1a+NLi53mX7Omwrbx6x00vTXD/NzsvGlakgXT8pqdZ6
         wVyssVqhXbMx6xmJUdl0B+shv4o5C092+SBdbie4JniMLmTJucZsRnkcrzYlyNatvLnm
         cl96TEV/KOJT06A3Szyt2+qMfNPDEufiGAvart1zoPPZwqd51u7PpPYrkYA/hlTVB36Q
         NZ3Fk2GXcOX43Zu7Yodmjt3XcpK/HSRc7VVIHMAkNv2DwGUWcpUmCa+c5lPzMxiIolfq
         Pw9GUG6xOesEuptwiL1QpexbhVr3z422f+uJHFqyZ7e8frFCLcOHefQ7U4ci+ezzEVSm
         LrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741908978; x=1742513778;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PTt4zbFyi/lWw6EXiC897VD1Joy4OZVjaIf4sel6ss4=;
        b=GPmIp0u6k0sO5gH0BnPgxxeT76DeTQVbT4Set2Io0CxspUS7VjL/iJxG9zXfGXiAwa
         7UEvOEivM/seHVnkvshLxD/NG+tMBDtK/ZkKePVNYbPYHq1BWo8YBML0AkbsOAFav2h9
         GtDrOdMqiuJChYRfzIfQs+1YumlCtxtvAoiMWXYMSWj0TuunPda14e6scVAGBjjc/nH8
         G9Z3aWH2dBX2QrnkpxPvkrwnfwIUGj3A+WR0umIF4F3OyzF4zm4orQemi/y+BeCzqO4D
         LARvxjnGd758clp921/4hWajfSI6ArzMhs0/mmjvXQ2ezQbLr30BnWmwB5VrXW3rKr2r
         PLFA==
X-Forwarded-Encrypted: i=1; AJvYcCU4EIHjfFj3+zS5KADTP2gYgO/Hrkl+0l4o9Vgl4SBAYU3cJI+Epn4v2zQkx3SqpL0Wrmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnx+iTDsEJ64V63KRXR/CjqNC/ODEjzAXhcQSAtG4oyZTK9EeC
	5XkycRtczDK4OYnepfiAPdUDx1GqSi89P/w3RPhlyWPdYJ0bzUiZULCoanECXrl2J+EnmhlQHA=
	=
X-Google-Smtp-Source: AGHT+IFAWxqWUjLnZMLFc2bzm8kiMY76oEKWGdNUuudXwU7j4QDlLhxXaP3ro1hUsdqTtnhCp83SfQxiLg==
X-Received: from pguc1.prod.google.com ([2002:a65:6741:0:b0:af5:1385:7743])
 (user=jrife job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:394c:b0:1f5:790c:947
 with SMTP id adf61e73a8af0-1f5c11bb371mr793468637.19.1741908978356; Thu, 13
 Mar 2025 16:36:18 -0700 (PDT)
Date: Thu, 13 Mar 2025 23:35:24 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250313233615.2329869-1-jrife@google.com>
Subject: [RFC PATCH bpf-next 0/3] Avoid skipping sockets with socket iterators
From: Jordan Rife <jrife@google.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Aditi Ghag <aditi.ghag@isovalent.com>
Content-Type: text/plain; charset="UTF-8"

I was recently looking into using BPF socket iterators in conjunction
with the bpf_sock_destroy() kfunc as a means to forcefully destroy a
set of UDP sockets connected to a deleted backend [1]. Aditi describes
the scenario in [2], the patch series that introduced bpf_sock_destroy()
for this very purpose:

> This patch set adds the capability to destroy sockets in BPF. We plan
> to use the capability in Cilium to force client sockets to reconnect
> when their remote load-balancing backends are deleted. The other use
> case is on-the-fly policy enforcement where existing socket
> connections prevented by policies need to be terminated.

One would want and expect an iterator to visit every socket that existed
before the iterator was created, if not exactly once, then at least
once, otherwise we could accidentally skip a socket that we intended to
destroy. With the iterator implementation as it exists today, this is
the behavior you would observe in the vast majority of cases.

However, in the process of reviewing [2] and some follow up fixes to
bpf_iter_udp_batch() ([3] [4]) by Martin, it occurred to me that there
are situations where BPF socket iterators may repeat, or worse, skip
sockets altogether even if they existed prior to iterator creation,
making BPF iterators as a mechanism to achieve the goal stated above
possibly buggy.

Admittedly, this is probably an edge case of an edge case, but I had
been pondering a few ways to to close this gap. This RFC highlights
some of these scenarios, extending prog_tests/sock_iter_batch.c to
illustrate conditions under which sockets can be skipped or repeated,
and proposes a possible improvement to iterator progress tracking to
achieve exactly-once semantics even in the face of concurrent changes
to the iterator's current bucket.

THE PROBLEM
===========
Both UDP and TCP socket iterators use iter->offset to track progress
through a bucket, which is a measure of the number of matching sockets
from the current bucket that have been seen or processed by the
iterator. However, iter->offset isn't always an accurate measure of
"things already seen" when the underlying bucket changes between reads.

Scenario 1: Skip A Socket
+------+--------------------+--------------+---------------+
| Time | Event              | Bucket State | Bucket Offset |
+------+--------------------+--------------+---------------+
| 1    | read(iter_fd) -> A | A->B->C->D   | 1             |
| 2    | close(A)           | B->C->D      | 1             |
| 3    | read(iter_fd) -> C | B->C->D      | 2             |
| 4    | read(iter_fd) -> D | B->C->D      | 3             |
| 5    | read(iter_fd) -> 0 | B->C->D      | -             |
+------+--------------------+--------------+---------------+

Iteration sees these buckets: [A, C, D]
B is skipped.

Scenario 2: Repeat A Socket
+------+--------------------+---------------+---------------+
| Time | Event              | Bucket State  | Bucket Offset |
+------+--------------------+---------------+---------------+
| 1    | read(iter_fd) -> A | A->B->C->D    | 1             |
| 2    | connect(E)         | E->A->B->C->D | 1             |
| 3    | read(iter_fd) -> A | E->A->B->C->D | 2             |
| 3    | read(iter_fd) -> B | E->A->B->C->D | 3             |
| 3    | read(iter_fd) -> C | E->A->B->C->D | 4             |
| 4    | read(iter_fd) -> D | E->A->B->C->D | 5             |
| 5    | read(iter_fd) -> 0 | E->A->B->C->D | -             |
+------+--------------------+---------------+---------------+

Iteration sees these buckets: [A, A, B, C, D]
A is repeated.

PROPOSAL
========
If we ignore the possibility of signed 64 bit rollover*, then we can
achieve exactly-once semantics. This series replaces the current
offset-based scheme used for progress tracking with a scheme based on a
monotonically increasing version number. It works as follows:

* Assign index numbers on sockets in the bucket's linked list such that
  they are monotonically increasing as you read from the head to tail.

  * Every time a socket is added to a bucket, increment the hash
    table's version number, ver.
  * If the socket is being added to the head of the bucket's linked
    list, set sk->idx to -1*ver.
  * If the socket is being added to the tail of the bucket's linked
    list, set sk->idx to ver.

  Ex: append_head(C), append_head(B), append_tail(D), append_head(A),
      append_tail(E) results in the following state.
    
      A -> B -> C -> D -> E
     -4   -2   -1    3    5
* As we iterate through a bucket, keep track of the last index number
  we've seen for that bucket, iter->prev_idx.
* On subsequent iterations, skip ahead in the bucket until we see a
  socket whose index, sk->idx, is greater than iter->prev_idx.

Indexes are globally and temporally unique within a table, and
by extension each bucket, and always increase as we iterate from head
to tail. Since the relative order of items within the linked list
doesn't change, and we don't insert new items into the middle, we can
be sure that any socket whose index is greater than iter->prev_idx has
not yet been seen. Any socket whose index is less than or equal to
iter->prev_idx has either been seen+ before or was added to the head of
the bucket's list since we last saw that bucket. In either case, it's
safe to skip them (any new sockets did not exist when we created the
iterator, so skipping them doesn't create an "inconsistent view").

* Practically speaking, I'm not sure if rollover is a very real concern,
  but we could potentially extend the version/index field to 128 bits
  or have some rollover detection built in as well (although this
  introduces the possibility of repeated sockets again) if there are any
  doubts.
+ If you really wanted to, I guess you could even iterate over a sort of
  "consistent snapshot" of the collection by remembering the initial
  ver in the iterator state, iter->ver, and filtering out any items
  where abs(sk->idx) > iter->ver, but this is probably of little
  practical use and more of an interesting side effect.

SOME ALTERNATIVES
=================
1. One alternative I considered was simply counting the number of
   removals that have occurred per bucket, remembering this between
   calls to bpf_iter_(tcp|udp)_batch() as part of the iterator state,
   then using it to detect if it has changed. If any removals have
   occurred, we would need to walk back iter->offset by at least that
   much to avoid skips. This approach is simpler but may repeat sockets.
2. Don't allow partial batches; always make sure we capture all sockets
   in a bucket in one batch. bpf_iter_(tcp|udp)_batch() already has some
   logic to try one time to resize the batch, but still needs to contend
   with the fact that bpf_iter_(tcp|udp)_realloc_batch() may not be able
   grab more memory, and bpf_iter_(tcp|udp)_put_batch() is called
   between reads anyway, making it necessary to seek to the previous
   offset next time around.
3. Error out if a scenario is detected where skips may be possible and
   force the application layer to restart iteration. This doesn't seem
   great.

Anyway, maybe this is already common knowledge, but I thought I'd
highlight the possibility just in case and share this idea; it seemed
like an area that could be improved a bit. I also wonder if a similar
scheme might be useful to create non-skipping iterators for collections
like network namespaces, which I believe is just a big linked list where
concurrent changes would be more likely, but I digress.

-Jordan

[1]: https://github.com/cilium/cilium/issues/37907
[2]: https://lore.kernel.org/bpf/20230519225157.760788-1-aditi.ghag@isovalent.com/
[3]: https://lore.kernel.org/netdev/20240112190530.3751661-1-martin.lau@linux.dev/
[4]: https://lore.kernel.org/netdev/20240112190530.3751661-2-martin.lau@linux.dev/

Jordan Rife (3):
  bpf: udp: Avoid socket skips during iteration
  bpf: tcp: Avoid socket skips during iteration
  selftests/bpf: Add tests for socket skips and repeats

 include/net/inet_hashtables.h                 |   2 +
 include/net/sock.h                            |   2 +
 include/net/tcp.h                             |   3 +-
 include/net/udp.h                             |   1 +
 net/ipv4/inet_hashtables.c                    |  18 +-
 net/ipv4/tcp.c                                |   1 +
 net/ipv4/tcp_ipv4.c                           |  29 +-
 net/ipv4/udp.c                                |  38 ++-
 .../bpf/prog_tests/sock_iter_batch.c          | 293 +++++++++++++++++-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/sock_iter_batch.c     |  24 +-
 11 files changed, 364 insertions(+), 48 deletions(-)

-- 
2.49.0.rc1.451.g8f38331e32-goog


