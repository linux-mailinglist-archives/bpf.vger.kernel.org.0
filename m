Return-Path: <bpf+bounces-56074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEB2A90FAB
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 01:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9C53BAC3C
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 23:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786BB248166;
	Wed, 16 Apr 2025 23:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="hEQPI6d3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D97233718
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 23:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744846598; cv=none; b=o4YO3sLinzoP3WQiFV6whpgJol5A360Hlz+200BD8OKtWKPLCegvEfCFz15cX1t/hZROygwtmoLm/T3FD7wzQNIQ4VS/JLWIx8TvQMM/TMQVK12Gle2tJwuT9dE/cy5xunocUVtW5zq4suvF4k0w6ADGo4726ZsrZM4LIUsUi2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744846598; c=relaxed/simple;
	bh=goHA5Hw2gXw6Y2RSKrNb7wu/YBcdpijTX0bsVEk0kN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FsGH7lKu38Ejq94fanOr7uwUhsW9f7VZBO8E21gHod59t3if+uiB/S84dDQQ8YgVZBDmCI5LxaIPU+qAxRsx53mfWj+fzQ5P4XG/OOet35AsgOMRrY35e2Rqp8u33sinrN+g65ITarPndgETydfOFaCIwCaraY22cwlTZj9bqC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=hEQPI6d3; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-301317939a0so12659a91.2
        for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 16:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1744846595; x=1745451395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8N3A0q/+TwAtfTTu90d94V275Qbq8ozT4Nb2NOn0atQ=;
        b=hEQPI6d3oVT4rFoiNkbuOKUg2QlXPLZmvmTHtlm+t19WX2PfBppDvfCB9HYdLhgMwN
         BdkNZQHleezBPVSxrmulzN8Uhs3zdiXZQJi+8nvWIxgZZb2wb53DEbSq11hyrebPvvw9
         hnGBNFBce41lEYDuaSBGJxAAiNkodZsZ+qrduiegDD5e8/ajzr3ZkpiFhcnlkG1E+oLR
         MU8FXIfoOWqtDIoOvm2aAs9OwVdXl9TjQgXHK41PNC4sHB5JJFRfIomXXuI/x1feunFp
         ysSvw7cJSk9AGBQXF94n8JJckVQGHthH2OGI5D/nDGPOafEkheW79w/I6JP6q+6yyKg0
         vsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744846595; x=1745451395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8N3A0q/+TwAtfTTu90d94V275Qbq8ozT4Nb2NOn0atQ=;
        b=IoDrM3cVUfYEUkMvXLaRT3MhYlydgclty82nYR5XQCGmAkGAJdZo6awQ1tgSQ2ylbd
         4llVtion/YHDNIEQCQDIDfdxF4WDSkWbG+lJctJ9OMzwWcp9TrAGRKm6GK6u+cdw7Sj1
         8JNokGJMsHswRnSBOrvJr00qM2I0PlatfKpS1ZTGcvbVSCNXuBF7V1+GkFZJeR6NSfSt
         KbBxDwCQuUlo0YSZwk6pnCLyh3O1XlLUn0DI8TaMBOPt0MzqC/aHHvkdCM16xoXFARqy
         8wUang/9bE1G1wB5LL+KV/3Y6oRaa0Rc5w5yekjYBU9KTEBIIfSj3a35e4KipOn1pY04
         AAvA==
X-Forwarded-Encrypted: i=1; AJvYcCVQh2tckSyU9ZyyQdcKQyqAXLfqu0kIBBh0pAnbNKsspZ08jvK9zqoBHO0QszvkJvA+9Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY3z591xdssM0ihRhu4EWJC6TIs3qfWMiUTd9ba/dMiHPUZxPy
	fGTsX4SnWnx7DGOWSsw578wxnJjgQEAvWG7Za+misZM4RhArk0caHsZSb215Seg=
X-Gm-Gg: ASbGncs/HKkISYNDH7ryZlqfdUwtgR9arobXMoBG0GKPGiqc9rnZdkS++XVhcivYgPI
	STwYmIwhQt9K3zN8Z9ugoYUmfeoLpvzlF8OaY/osPsJkriTjb+tfdUMsSzLHU8e5g4hmS630VsL
	8htpwHSIEi5wrXcq1KetQRcr/GeVmQhO3bnE9Tjd9MVHrwT36C5+cZYyXLH0QZYVfPpo2nmFKoy
	xDrQw6c/Kfkw7eEhknuWXvTtbbyLlav3Ugk0tOu/4/SFXyrNa2ei8FYOB2PQGe5IXc8cMQMIQ/L
	BanDWoCwRhQ/z0W5J8qGkqIkSWsA7g==
X-Google-Smtp-Source: AGHT+IFFGZ0EFt6Kk0d5M4/MDQt+C5jk/mCuPE8+QTNqltLuNSCyt314nZjD5TiKjENJf5or7wIndA==
X-Received: by 2002:a17:90b:1b0d:b0:2fe:b972:a2c3 with SMTP id 98e67ed59e1d1-3086d25732bmr942284a91.0.1744846595198;
        Wed, 16 Apr 2025 16:36:35 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:b7fc:bdc8:4289:858f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308611d6166sm2269251a91.7.2025.04.16.16.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 16:36:34 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Aditi Ghag <aditi.ghag@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH v3 bpf-next 0/6] bpf: udp: Exactly-once socket iteration
Date: Wed, 16 Apr 2025 16:36:15 -0700
Message-ID: <20250416233622.1212256-1-jordan@jrife.io>
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
 net/ipv4/udp.c                                | 155 ++++--
 .../bpf/prog_tests/sock_iter_batch.c          | 447 +++++++++++++++++-
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/sock_iter_batch.c     |  24 +-
 5 files changed, 574 insertions(+), 56 deletions(-)

-- 
2.43.0


