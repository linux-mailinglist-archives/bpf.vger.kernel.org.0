Return-Path: <bpf+bounces-60962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7253FADF28E
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 18:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B783BB619
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 16:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400CE2F0C52;
	Wed, 18 Jun 2025 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="Gz77tB45"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0D11C861F
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263951; cv=none; b=ruQA7f5JbSSgUAsWLjG99GUqoKBkYH0apl/wFwLxRgrGNPrIkzrgK+cYOWyTUkP+EXlSl+80DMDQByxUyVfqK9xIl3683a+GODeCdAKstl1YZ16EoNwGqe9eWlntK3QJsSDEEhgMxIrRAPMksxu1dbnwRWcw5yoDn+Xqbq+a188=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263951; c=relaxed/simple;
	bh=Xt7U1x3SkNTaDSR5L1DVqg/uyQUndXVGHRE3Zd14eVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MILM0YUm8KEG7h5Q0d2hD8kOCNHCC1/+bjWNj3kIm0edQ6IsDRweIFaFowqsw8HDn8tyNtzAN34YQpHjA9/WnIJwTcZ9H5rqlmhbzugIm97FyRVCWPLzZtin98v0z2w3yPX46hPmyLFdzgg/VM7+A55FfqOdc5Q3w08yLwRzCeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=Gz77tB45; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-313fab41fd5so907691a91.1
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 09:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1750263949; x=1750868749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=81pEAwXmixuxAF0u6MPMjW9qRqViI6uiK6RzRIZYnIg=;
        b=Gz77tB45qW8OyP/4AtWTEBommtgPvGbimohXVdYUrOqdOKcuE75Fpciyy0ED653+7K
         8ez+roM5+v71PtjCpk57TemK64zMcDgkwGOKflM2qL+e8POUEkhvW5y0Omj1vv4zJlHn
         3mGTo1L4f6vewU8UNr7JUMMbVFzrFcEVHtJX943uj4zUVJcADEhA3sdZTxzXtQtm8cIW
         IXDg2Y/qOjVXlzHKSO34xAo3eodwEU1F1vO2VFfzAGKmBq0hRaTBM3t+XMZr9hplolj8
         D0DvRki5JukMSyJgEm879QgTZ9SKRtN6toHNQ+s4aCHHYW4pm9TJ6a16a3JtWJ8t1o83
         LnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750263949; x=1750868749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81pEAwXmixuxAF0u6MPMjW9qRqViI6uiK6RzRIZYnIg=;
        b=i3PZMHB2520H+2/RC2skT9RtOteL76TCK52P+A0ng2ia+vd0RxuQ+z8lSBMIFjl2EW
         qr4Ei/H+OkLBn0sk274iJ1oA3eL2H7OTAnvn95elblWoGoZux3q+BgGeSMJXTWRKF8QC
         WIdfbg1L4scN7xSbstca6Zn8IbGit2DSR+hVw5kRCX5+8p58E8hstO+K1q8SVaSs5+rt
         gNZ6kLe8ZRWB/IG4CapyH+tBVq+DDHVcp/DLTacE3LD1/KKa4L+9/0GNCptIboAiM5Z2
         f0mOBpCKzdhpSiYEqJPWeQqYtz+MB7WLhTzmgRQ0Q61hRpJNsrvC43XKkOKFh9ip1Er3
         cM8w==
X-Forwarded-Encrypted: i=1; AJvYcCWZZWYQ1nO9ue9oqus3N0K/uy7NrPWhJnaA/TR72LzVC7nGqPxBO1dRvcWJIx2bTLpLoxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+fY2DwRy/fSGqf9iEfEYD0Y3gBCXBopUkaxMm6Wxjgi/wk5ne
	7GygZmAZzuU+TKK7+vgokTW599UMhdpQ94ax1KhJnp2CDrWPNMMjzwc8v3m+WKG3tRU=
X-Gm-Gg: ASbGncvL36Rw8qGN2gTxQZ7MeFA5FLrC2EDOGixVh+3Nugod1eYbt/eYjWt2qCjHYTV
	r78xN05UxsLL2+N6shdf6KrDJmMn0o61sYfgXfdyWXv13AaAsmLkr6fWnu4sBrpvlEXiJ9XcG2L
	zMMANEVrKUZ/g/oDTUrFPTo2IwvjjwttCOPqxK+Rt7wtVDBZBzNEVoGtXvi1qd2p1GF6L9Bqiub
	2YspSp79J0pykgsqYRB475TnAIIGNz11+V47twzTeb+Sbhy48Gkd2abH5L4kOvERkeruAtBpomg
	w1EIPucWHX6rc/FBdCCl42Mz1wEkcvNkfRsrEjkDnD04b6QeEDU=
X-Google-Smtp-Source: AGHT+IELPUoe/0lbZ51Ep3CRUjBzFoOI7DQHZMtTAMEPeIerj8Ci4FOU7fjbN+PdNVV9TUydT51TQQ==
X-Received: by 2002:a17:90a:e7c3:b0:311:b0ec:135e with SMTP id 98e67ed59e1d1-313f1befc7dmr10086256a91.2.1750263949142;
        Wed, 18 Jun 2025 09:25:49 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d683:8e90:dec5:4c47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2768c6sm137475a91.44.2025.06.18.09.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:25:48 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RESEND PATCH v2 bpf-next 00/12] bpf: tcp: Exactly-once socket iteration
Date: Wed, 18 Jun 2025 09:25:31 -0700
Message-ID: <20250618162545.15633-1-jordan@jrife.io>
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


