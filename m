Return-Path: <bpf+bounces-79134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4358CD27F40
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 20:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D47DD3017399
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7129D2D97AB;
	Thu, 15 Jan 2026 19:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF8K1zMv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DF886250
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768504073; cv=none; b=IJmkoY/jwP6+5P2Jb/I4ykMPD0wqiZQcUTPa8fYEAJaFKr1bfmGQex16FYI++lB+kRMK3AjxW3yIbCWZwnDOWDEgqRFJTKWGl1n8wFm8Ydk4ureDjtMbi2r3yvYJj9xW6idjLmSJtNuj7RZ6zEE3oKcsF8tiTZuNefzf8iWhKKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768504073; c=relaxed/simple;
	bh=DToFpCuHSuhM+DNHpirRAz41A0l+z2tT9QDmqX4hQ4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PW3Jlyy7xAFp0GpKblPUCtfBrMUI8UIl5B6rdArWzOdiz3Qh9LVyPpC8GzogsJbPDBqCnYhuMCdIoTyZ6OIAjVLOe+NojtY7FkpWJ40cEypKspAuZZoiQhUqJqgQyKAssRvPm+YEvH4RB5mMxD1j2fvscFLKGuSzP5d9HLSmE5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EF8K1zMv; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38304020185so11249571fa.2
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 11:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768504069; x=1769108869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZL3nD4Mi+r9SwzljwlE9pccItzJ+U5IHWeQeM/fGf6Q=;
        b=EF8K1zMvNS1ZRvKTPCiVeaY+RW6Mqi47SX5L9u9hDDXq8i3infufxZ4FwTk6vR+TWX
         s/q3puWFrazsVQZRFxXbhaB/N4KIUUQ9yudPH6BxRLZd7yhswgLZ7iRBDUPNHQS+DipK
         Bk2apznqrKjwA5LfCfKgNjyvAIs2teGBj6TMfISGIDUPhNn1AVyX92EZM9mdMvS769Ax
         8qkN7XL4aPUe4p29dusVIgrQi0d47hsZDgpZkj6gh9n9zP9DpSGhMmGtEvMh6ErGOZMO
         iMDkjC/78emN4twvcRgkX0ZSj+b35nbjY/jZzBs3zFt49tWw5X4TLBQyb7ZiR1QkQBkE
         7c9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768504069; x=1769108869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZL3nD4Mi+r9SwzljwlE9pccItzJ+U5IHWeQeM/fGf6Q=;
        b=A/ohtr5uNtsKP47A9qaFIvXuo6YDa3cVn1XgKExh80fY5eVssgeFlLXtsQ/Alnv+j+
         QtwvL9znhvmtJxTQjAg7hLvvTu9pZoWV3tdT3AlbgP5Xd7fec4DpruvM9nUSnIxOLGYp
         PTPWpqKfqglHLNRNICBm7s8n098UHOM2sfOKM7hD39hO49op5ZFAMTEwOV+yzmeXNfvy
         Spe+BQNfRIzu1hZIHp48xwYl/8K+FBI3hbggRoUvusmETCf8aS1qXHyqZEWa3kFhbJAi
         Fg7piUk2b4CUSxPRXSRBpr23aGyC93UAtABM4BbfaBPddoOyXqo3Do/JERTaNb3RmErE
         8L0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrcNOXZWKjO46Kf86jX6BEowEwiYHSWW9S3J4/3KL4hEOmSpDr+Oc4KoZVrSpPcjUXfr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDLOKKZImibr52z8eJbLHijIw1OS9AvTL4G/vJIXyPJdbRz3vG
	pnFqg2/ffHWGeQ61jb7eOfuRzCCLVgNJVi9E0xa5BPSzOX2Unvh6U7LR
X-Gm-Gg: AY/fxX5QB//i+C7kyp6kt48ND5hYB5FOnBsk+TJ+y9+uXM44x4bnExgXE7Vmxm/y+WQ
	3Fh03nPKa7wU0oEXXXlR6uhxWibCr6fZWGVO/4evupLftIYHoVMyNRG5EpsKPol+bHJeumYWZNf
	4XQDssCvwJ3oQjLCVJPH+5e+7enfJQV6EuRvyZZ1MH4FtSoTk9RNaiu1PGSDFbVaCyh8Mue4BFM
	5gRavUq7zqI/lCC6HnlilAMNPJauYlShlS4bsf75xb0yhUmQ3SHq4LJNihHxBoF0lBidq4j0+wY
	TmDrEd0b0F0TxD7fmfRPKnS6LSMohgKz2RSL2fjzCptVNuOd8LMwOIIxFNxq7YW0MRol5PzxWHP
	kztaonr5gyl0WgE+DtkuLFBy4Zsyx8Uk3KEIiKyD/DW9J9Gf8SmK3l+CFcsx3LkCHj4C1vf1FVo
	kwyhX40oLAT3vjZVc28FqdTbJ3uDmmaR2Hbmu9PKih/d4i/bn+keBl7MghpfPITtZSq1g6E2qBa
	WeMuFzBQnuPnuxoYA==
X-Received: by 2002:a05:600c:4e43:b0:47e:d943:ec08 with SMTP id 5b1f17b1804b1-4801e33dc26mr5755305e9.28.1768497142655;
        Thu, 15 Jan 2026 09:12:22 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071a2sm54741645e9.11.2026.01.15.09.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:12:21 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Ankit Garg <nktgrg@google.com>,
	Tim Hostetler <thostet@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	John Fraker <jfraker@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Joe Damato <joe@dama.to>,
	Mina Almasry <almasrymina@google.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Yue Haibing <yuehaibing@huawei.com>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dtatulea@nvidia.com,
	kernel-team@meta.com,
	io-uring@vger.kernel.org
Subject: [PATCH net-next v9 0/9] Add support for providers with large rx buffer
Date: Thu, 15 Jan 2026 17:11:53 +0000
Message-ID: <cover.1768493907.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Note: it's net/ only bits and doesn't include changes, which shoulf be
merged separately and are posted separately. The full branch for
convenience is at [1], and the patch is here:

https://lore.kernel.org/io-uring/7486ab32e99be1f614b3ef8d0e9bc77015b173f7.1764265323.git.asml.silence@gmail.com

Many modern NICs support configurable receive buffer lengths, and zcrx and
memory providers can use buffers larger than 4K to improve performance. When
paired with hw-gro larger rx buffer sizes can drastically reduce the number
of buffers traversing the stack and save a lot of processing time. It also
allows to give to users larger contiguous chunks of data. The idea was first
floated around by Saeed during netdev conf 2024 and was asked about by a few
folks.

Single stream benchmarks showed up to ~30% CPU util improvement.
E.g. comparison for 4K vs 32K buffers using a 200Gbit NIC:

packets=23987040 (MB=2745098), rps=199559 (MB/s=22837)
CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
  0    1.53    0.00   27.78    2.72    1.31   66.45    0.22
packets=24078368 (MB=2755550), rps=200319 (MB/s=22924)
CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
  0    0.69    0.00    8.26   31.65    1.83   57.00    0.57

This series adds net infrastructure for memory providers configuring
the size and implements it for bnxt. It's an opt-in feature for drivers,
they should advertise support for the parameter in the qops and must check
if the hardware supports the given size. It's limited to memory providers
as it drastically simplifies implementation. It doesn't affect the fast
path zcrx uAPI, and the user exposed parameter is defined in zcrx terms,
which allows it to be flexible and adjusted in the future.

A liburing example can be found at [2]

full branch:
[1] https://github.com/isilence/linux.git zcrx/large-buffers-v8
Liburing example:
[2] https://github.com/isilence/liburing.git zcrx/rx-buf-len

---

The following changes since commit 0f61b1860cc3f52aef9036d7235ed1f017632193:

  Linux 6.19-rc5 (2026-01-11 17:03:14 -1000)

are available in the Git repository at:

  https://github.com/isilence/linux.git tags/net-queue-rx-buf-len-v9

for you to fetch changes up to d1de61db1536727c1cad049c09decff22e8b6dd7:

  io_uring/zcrx: document area chunking parameter (2026-01-14 02:13:37 +0000)

v9: - correct nits from Paolo

v8: - Add stripped down qcfg
    - Retain the page size across resets for bnxt

v7: - Add xa_destroy
    - Rebase

v6: - Update docs and add a selftest

v5: https://lore.kernel.org/netdev/cover.1760440268.git.asml.silence@gmail.com/
    - Remove all unnecessary bits like configuration via netlink, and
      multi-stage queue configuration.

v4: https://lore.kernel.org/all/cover.1760364551.git.asml.silence@gmail.com/
    - Update fbnic qops
    - Propagate max buf len for hns3
    - Use configured buf size in __bnxt_alloc_rx_netmem
    - Minor stylistic changes
v3: https://lore.kernel.org/all/cover.1755499375.git.asml.silence@gmail.com/
    - Rebased, excluded zcrx specific patches
    - Set agg_size_fac to 1 on warning
v2: https://lore.kernel.org/all/cover.1754657711.git.asml.silence@gmail.com/
    - Add MAX_PAGE_ORDER check on pp init
    - Applied comments rewording
    - Adjust pp.max_len based on order
    - Patch up mlx5 queue callbacks after rebase
    - Minor ->queue_mgmt_ops refactoring
    - Rebased to account for both fill level and agg_size_fac
    - Pass providers buf length in struct pp_memory_provider_params and
      apply it in __netdev_queue_confi().
    - Use ->supported_ring_params to validate drivers support of set
      qcfg parameters.

Jakub Kicinski (2):
  net: reduce indent of struct netdev_queue_mgmt_ops members
  eth: bnxt: adjust the fill level of agg queues with larger buffers

Pavel Begunkov (7):
  net: memzero mp params when closing a queue
  net: add bare bone queue configs
  net: pass queue rx page size from memory provider
  eth: bnxt: store rx buffer size per queue
  eth: bnxt: support qcfg provided rx page size
  selftests: iou-zcrx: test large chunk sizes
  io_uring/zcrx: document area chunking parameter

 Documentation/networking/iou-zcrx.rst         |  20 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 123 +++++++++++++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |   2 +-
 drivers/net/ethernet/google/gve/gve_main.c    |   9 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  10 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  |   8 +-
 drivers/net/netdevsim/netdev.c                |   7 +-
 include/net/netdev_queues.h                   |  47 +++++--
 include/net/netdev_rx_queue.h                 |   2 +
 include/net/page_pool/types.h                 |   1 +
 net/core/dev.c                                |  17 +++
 net/core/netdev_rx_queue.c                    |  31 +++--
 .../selftests/drivers/net/hw/iou-zcrx.c       |  72 ++++++++--
 .../selftests/drivers/net/hw/iou-zcrx.py      |  39 ++++++
 16 files changed, 317 insertions(+), 79 deletions(-)

-- 
2.52.0


