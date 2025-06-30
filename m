Return-Path: <bpf+bounces-61861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97434AEE578
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 19:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57B93B7E75
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 17:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBDC29344F;
	Mon, 30 Jun 2025 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="2wTH/+7g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF8828DB5E
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303850; cv=none; b=foynWtoixor5B4zhkKND5h05K+aGOFXKbf5ljxLdTWY0Crd9IUEvhTgCcP3vWYQlhrjxSw1o9G15tVz/JPEfKzV1F/1qGDtgHPn/kcrhppm6H6dB9cMLRRDpk/ZmhTwpMuJknwmtK/pR7zcXnu/LMoNYYs8A772p8nv2LVzHBBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303850; c=relaxed/simple;
	bh=0V9/Wy9V1PBoeqDc+eYGtxxOQzc3Yi1C1BMEgN04Dcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R48I4MxFV4YoyF64vcwQff5U7b4HxS9hDb9/s5PJkfmxpbFROuSlM+HhXF/JbiNHl+jFbBeZwL/PEHyxNjQIgb7YLJpZCBCTL7FZjfmOXDO7UMLGzNYVHrE5ySfPcxzSVRtarkW6jjIrak4uYzTGoFRk/KzOHlgePx2bZObYaCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=2wTH/+7g; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74ae78fbb8fso408760b3a.2
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751303848; x=1751908648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hU+OEqHDQSCVzx+Nj7vxPurpCRjZ8fafcjXyz7/7EGQ=;
        b=2wTH/+7gkw4WPe7qHF7jlCzQTXGVqfhbIr9mnu1k9WsblqroLTu8ofKmUTvpgAPRaR
         GR9ARgVwcjqIgEJkkqzbcLV1Msrdf26yp24oBnYMjtYItYtIk5DUxEShxYNdB6Y9Hd5c
         ohZcIdM8VgRzK7vmrcaK7igvOyISfjsQre36/idcJJgdgy8hqRUJwrX/1cZW67ewhAyb
         AFx5rn4snxAOuxFvYNxok6SV131yj99EzlPmCzGCH/B+CzhNO0b7f1taS34zV9FizPKC
         wbVW6iQAEV7jGUYi63m40xR5eSG3+HLhaInPPjdffPBg+A7+QGzIybHW1HIbHVcBwkUP
         XzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303848; x=1751908648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hU+OEqHDQSCVzx+Nj7vxPurpCRjZ8fafcjXyz7/7EGQ=;
        b=FKB9hHD4+jS1Vozdj+tWkwKwGL659FRI5Fq62w3dFwL7svMvsvtaSxFxiLUXnfE2sx
         aEvrPbSDOCLTzgea1MPWZc0ohgL9Z3Vlhvto8DX6JBrozi+Fw56+EGUBS3ZSq9WDzZXV
         RGFVlmZgju2DNSoKXtj68DLQMu8UBQ9HAANul3YZ4i/drKJrn44Z400Jv2yGEgir8onV
         X9ilWBVQFaGcGASdDk/XIyzErwSesdXVm7xKlMDkDkNRHsSbBuwzibCpT5dx+mbSsXLl
         7/IR+tLYDr+457RxpFdA1UI8xGwtuzBzwcp9TFwvVV5aVK9ZLtowQ6kstcyOx/hXpGgN
         X3dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUID7JGaZnY0jgHHhPBfemjmE9nAujRNi+ofgj5SNOMISUpTQfdEfAdCQ3YGA4PRcSpTBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDtnTRqaeKRdHd7vlf24TwZwI/24pIOHvlzi71NtCZLTeYqegW
	bb1kAvSWrN6U8E3Z/cSdBlqUxQPvPomN+4zSNlci+dY8COB3UipV55KYST7KahC9E+M=
X-Gm-Gg: ASbGncu/IWFUqXEh4NHNxlqaFar2xKfL69T/rWjc9fA11eWr+Uarz6wfE7YI03zOYA0
	lEmdF/qebNr/LjotXgEbpL7OzO4WWtdzYGl7xPtNZxoi/zvV3RDQtClauI05Us/au+MphLDEG8A
	w9GZyPCEbXJa1lOTeUw9WTrOvykiSr+MsihVah15I0lDlP/gjtgXUTM1+Gti3XVsHlYxJ9YrpKT
	+1xVEUvTNRWZ0YuQr7f/XRccw9G3W4wOZ/qjPtA7vm39+PagbhENrrl/S9A4sYL7mDizGbGsYQ/
	m1Kp7L/Pzc/pr16HeKXEPasBzpzTGZ6RzsfRFL3DttNLs0dOwQ==
X-Google-Smtp-Source: AGHT+IFscHlz0QS5fCs941fk5qk51h+qNURvUtDSfTGEOFPa2p+ltX23z4PHJVE4uVl7546QFtwyrw==
X-Received: by 2002:a05:6a00:2455:b0:740:275:d533 with SMTP id d2e1a72fcca58-74b0a66f70fmr3705851b3a.6.1751303847616;
        Mon, 30 Jun 2025 10:17:27 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:9ab8:319d:a54b:9f64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540a846sm9229232b3a.31.2025.06.30.10.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:17:27 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 00/12] bpf: tcp: Exactly-once socket iteration
Date: Mon, 30 Jun 2025 10:16:53 -0700
Message-ID: <20250630171709.113813-1-jordan@jrife.io>
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
 .../bpf/prog_tests/sock_iter_batch.c          | 450 +++++++++++++++++-
 .../selftests/bpf/progs/sock_iter_batch.c     |  37 +-
 3 files changed, 672 insertions(+), 84 deletions(-)

-- 
2.43.0


