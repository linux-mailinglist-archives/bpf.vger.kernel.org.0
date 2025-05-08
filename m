Return-Path: <bpf+bounces-57785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1D7AB027E
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 20:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 862EE7A561A
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 18:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C455215778;
	Thu,  8 May 2025 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GH6P/gdQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF33522A
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746728440; cv=none; b=bEk4aALjEmKpLiIA2291ps71JHDGBFNctvMUdhtEjB2sEdTlSCa7S8gFnbmI2qI2vzvmLyYpeNFZfH1ZboSno9un7HAAKIV9fTEfo4nxo5pyxd1KALLJYr5oG4EfSqb+0CFhJ9Y9yq3vNQQXe5kJZI/VVy85F+dx5PoJzuREIKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746728440; c=relaxed/simple;
	bh=AFojxG9aPrDK+YfWSqvqEl4BPFnRhOZEHrJHlhsV/As=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BQkPDF01RrBRva4oiuf0CfnRj4xwSOM0TDMpLpMmlR0uD17wkwRZUkWN2kk8r6HC3+56SOzWmKZD3PPO2GXo3z6kZDFFv8u2ktt1DKgdGxJDZOBkbLep0GWz1ZVLJ4QtGYh4TNwo/c04HpD3c6KvDWlVKEbqMMG3vQAZQ3p+ioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GH6P/gdQ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30a0a8ddcc4so1566742a91.3
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 11:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746728438; x=1747333238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P9TcbK/nWa/YXXDAxnZVOVArGjAtkdTEqGETT2oQJ+Q=;
        b=GH6P/gdQbCfyiNTZTvQY/Q1sXpBQiShC91YBtntu0G6FBjsKcfLYry2gIDK5NhwfIx
         H6tdhflGOiVY4s6HhEG73a/vzQbr1AMo9Is7rik6unTbMtoQ7pxDdYibA9+5VesIoIjq
         DyBwbyKOgAPVAVIIl+l0dQbTPR2QS+Qqzt14Tf+cjlW/2kNYqv4GVdr28Is5YemtGplV
         ALCbSc3FRijAd0igRqPpgAyvXKbNqWOvsHMMtgOwKIVdhViic5oss50JOlGqVACLRiHX
         KBExDt2iVVKQIXMNYD+5E92dh1qqcCghFRaANVxhd87a2RjOzuzHccRbjLlAumMk26Mi
         Gn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746728438; x=1747333238;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9TcbK/nWa/YXXDAxnZVOVArGjAtkdTEqGETT2oQJ+Q=;
        b=SXl17F4wvfC9vuN+R9s/P+F0bPdymCT7GHDtAYR4Pe9MW+Q7mktchs7IrCVOre72z+
         MH8EuA3DUnNecVR4KcS9TQvsYOef+o5SSo6ikFjfh0gTx4FKg0arUFcyp9pL9tDQIgfB
         iJ5CsWc1g9XMIJgKL0c0TfEORhvm9N67aooJF45pdVoLnDEvdPcR80LXEtH/x1wjGbig
         CuurRm3cZIDI2N89NHihKb0TkOqfKKhORU17znJ4XdotwtjbzUHiA7pHoHnX/R1Q5iuk
         LUygnAzI5rS9mUfvAMlMuEbR+/A0IzPPG3cF8Sufm33XcOVmEjuuXxx7gQITKtxKzLfd
         hqWw==
X-Forwarded-Encrypted: i=1; AJvYcCUPT3bW3qF7vmEvShSCBM185dNJtLD+iF7iFKs7+s0VqpCmafXOj3kK6iITI2ZRHQc2IJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvkZqW/ZLZ4Qta/ZDNUJK3MPvDJ5nJJHQutSwOeFxqgeu6818e
	QYGAt4hhUQ1/kb4j41+2wrjyS3v+OBfuCHwNuq45n1HAYO3X0ity2RJ0+sVDgA0P5vWaUaJOE8Q
	1jfWT9xiNYi+09A==
X-Google-Smtp-Source: AGHT+IFhx3d+8kkrdtF5uHVOpa/4HuyLlmn9NJKawhhnSvvJ/pAtFwroXUkydqUIaRt0a+bCKTAGt+Mq8FzXwso=
X-Received: from pjtd8.prod.google.com ([2002:a17:90b:48:b0:2ee:4a90:3d06])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:268a:b0:2fe:8282:cb9d with SMTP id 98e67ed59e1d1-30c3d6467cbmr760151a91.28.1746728437874;
 Thu, 08 May 2025 11:20:37 -0700 (PDT)
Date: Thu,  8 May 2025 18:20:19 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250508182025.2961555-1-tjmercier@google.com>
Subject: [PATCH bpf-next v4 0/5] Replace CONFIG_DMABUF_SYSFS_STATS with BPF
From: "T.J. Mercier" <tjmercier@google.com>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org, song@kernel.org, 
	"T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Until CONFIG_DMABUF_SYSFS_STATS was added [1] it was only possible to
perform per-buffer accounting with debugfs which is not suitable for
production environments. Eventually we discovered the overhead with
per-buffer sysfs file creation/removal was significantly impacting
allocation and free times, and exacerbated kernfs lock contention. [2]
dma_buf_stats_setup() is responsible for 39% of single-page buffer
creation duration, or 74% of single-page dma_buf_export() duration when
stressing dmabuf allocations and frees.

I prototyped a change from per-buffer to per-exporter statistics with a
RCU protected list of exporter allocations that accommodates most (but
not all) of our use-cases and avoids almost all of the sysfs overhead.
While that adds less overhead than per-buffer sysfs, and less even than
the maintenance of the dmabuf debugfs_list, it's still *additional*
overhead on top of the debugfs_list and doesn't give us per-buffer info.

This series uses the existing dmabuf debugfs_list to implement a BPF
dmabuf iterator, which adds no overhead to buffer allocation/free and
provides per-buffer info. The list has been moved outside of
CONFIG_DEBUG_FS scope so that it is always populated. The BPF program
loaded by userspace that extracts per-buffer information gets to define
its own interface which avoids the lack of ABI stability with debugfs.

This will allow us to replace our use of CONFIG_DMABUF_SYSFS_STATS, and
the plan is to remove it from the kernel after the next longterm stable
release.

[1] https://lore.kernel.org/linux-media/20201210044400.1080308-1-hridya@goo=
gle.com
[2] https://lore.kernel.org/all/20220516171315.2400578-1-tjmercier@google.c=
om

v1: https://lore.kernel.org/all/20250414225227.3642618-1-tjmercier@google.c=
om
v1 -> v2:
Make the DMA buffer list independent of CONFIG_DEBUG_FS per Christian K=C3=
=B6nig
Add CONFIG_DMA_SHARED_BUFFER check to kernel/bpf/Makefile per kernel test r=
obot
Use BTF_ID_LIST_SINGLE instead of BTF_ID_LIST_GLOBAL_SINGLE per Song Liu
Fixup comment style, mixing code/declarations, and use ASSERT_OK_FD in self=
test per Song Liu
Add BPF_ITER_RESCHED feature to bpf_dmabuf_reg_info per Alexei Starovoitov
Add open-coded iterator and selftest per Alexei Starovoitov
Add a second test buffer from the system dmabuf heap to selftests
Use the BPF program we'll use in production for selftest per Alexei Starovo=
itov
  https://r.android.com/c/platform/system/bpfprogs/+/3616123/2/dmabufIter.c
  https://r.android.com/c/platform/system/memory/libmeminfo/+/3614259/1/lib=
dmabufinfo/dmabuf_bpf_stats.cpp
v2: https://lore.kernel.org/all/20250504224149.1033867-1-tjmercier@google.c=
om
v2 -> v3:
Rebase onto bpf-next/master
Move get_next_dmabuf() into drivers/dma-buf/dma-buf.c, along with the
  new get_first_dmabuf(). This avoids having to expose the dmabuf list
  and mutex to the rest of the kernel, and keeps the dmabuf mutex
  operations near each other in the same file. (Christian K=C3=B6nig)
Add Christian's RB to dma-buf: Rename debugfs symbols
Drop RFC: dma-buf: Remove DMA-BUF statistics
v3: https://lore.kernel.org/all/20250507001036.2278781-1-tjmercier@google.c=
om
v3 -> v4:
Fix selftest BPF program comment style (not kdoc) per Alexei Starovoitov
Fix dma-buf.c kdoc comment style per Alexei Starovoitov
Rename get_first_dmabuf / get_next_dmabuf to dma_buf_iter_begin /
  dma_buf_iter_next per Christian K=C3=B6nig
Add Christian's RB to bpf: Add dmabuf iterator

T.J. Mercier (5):
  dma-buf: Rename debugfs symbols
  bpf: Add dmabuf iterator
  bpf: Add open coded dmabuf iterator
  selftests/bpf: Add test for dmabuf_iter
  selftests/bpf: Add test for open coded dmabuf_iter

 drivers/dma-buf/dma-buf.c                     |  98 +++++--
 include/linux/dma-buf.h                       |   4 +-
 kernel/bpf/Makefile                           |   3 +
 kernel/bpf/dmabuf_iter.c                      | 149 ++++++++++
 kernel/bpf/helpers.c                          |   5 +
 .../testing/selftests/bpf/bpf_experimental.h  |   5 +
 tools/testing/selftests/bpf/config            |   3 +
 .../selftests/bpf/prog_tests/dmabuf_iter.c    | 258 ++++++++++++++++++
 .../testing/selftests/bpf/progs/dmabuf_iter.c |  91 ++++++
 9 files changed, 594 insertions(+), 22 deletions(-)
 create mode 100644 kernel/bpf/dmabuf_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/dmabuf_iter.c


base-commit: 43745d11bfd9683abdf08ad7a5cc403d6a9ffd15
--=20
2.49.0.1015.ga840276032-goog


