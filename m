Return-Path: <bpf+bounces-18689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94FD81EDF3
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 11:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4611C2176C
	for <lists+bpf@lfdr.de>; Wed, 27 Dec 2023 10:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6277C2940A;
	Wed, 27 Dec 2023 10:01:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5569628E10
	for <bpf@vger.kernel.org>; Wed, 27 Dec 2023 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VzKnOfc_1703671290;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0VzKnOfc_1703671290)
          by smtp.aliyun-inc.com;
          Wed, 27 Dec 2023 18:01:31 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	joannelkoong@gmail.com,
	laoar.shao@gmail.com,
	kuifeng@meta.com,
	houtao@huaweicloud.com,
	shung-hsi.yu@suse.com,
	xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com,
	hengqi@linux.alibaba.com
Subject: [PATCH bpf-next v1 0/3] bpf: introduce BPF_MAP_TYPE_RELAY
Date: Wed, 27 Dec 2023 18:01:27 +0800
Message-Id: <20231227100130.84501-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch set introduce a new type of map, BPF_MAP_TYPE_RELAY, based on
relay interface [0]. It provides a way for persistent and overwritable data
transfer.

As stated in [0], relay is a efficient method for log and data transfer.
And the interface is simple enough so that we can implement and use this
type of map with current map interfaces. Besides we need a kfunc
bpf_relay_output to output data to user, similar with bpf_ringbuf_output.

We need this map because currently neither ringbuf nor perfbuf satisfies
the requirements of relatively long-term consistent tracing, where the bpf
program keeps writing into the buffer without any bundled reader, and the
buffer supports overwriting. For users, they just run the bpf program to
collect data, and are able to read as need. The detailed discussion can be
found at [1].

The buffer is exposed to users as per-cpu files in debugfs, supporting read
and mmap, and it is up to users how to formulate and read it, either
through a program with mmap or just `cat`. Specifically, the files are
created as "/sys/kerenl/debug/<dirname>/<mapname>#cpu", where the <dirname>
is defined with map_update_elem (Note that we do not need to implement
actual elem operators for relay_map).

In addition, it's possible to implement relay interface with kfuncs, which
can be used with kptrs to "simulate" a new type of map. I'll try it if
necessary.

This patch set depends on a bugfix patch for relay [2]. I'm working on it
to make sure relay map works well. Currently, the selftests could fail
without that patch, but it doesn't affect how we use relay map.

[0]
https://github.com/torvalds/linux/blob/master/Documentation/filesystems/relay.rst
[1]
https://lore.kernel.org/bpf/20231219122850.433be151@gandalf.local.home/T/
[2]
https://lore.kernel.org/all/20231220074725.23211-1-lulie@linux.alibaba.com/

Change logs:
v1:
- change bpf_relay_output into kfunc instead of helper
- refactor relay_map_update_elem to avoid race
- add attr->map_extra check in map_alloc
- add selftests
- other minor bug fixs

Philo Lu (3):
  bpf: implement relay map basis
  bpf: add bpf_relay_output kfunc
  selftests/bpf: add bpf relay map selftests

 include/linux/bpf_types.h                     |   3 +
 include/uapi/linux/bpf.h                      |   7 +
 kernel/bpf/Makefile                           |   3 +
 kernel/bpf/helpers.c                          |   3 +
 kernel/bpf/relaymap.c                         | 221 ++++++++++++++++++
 kernel/bpf/syscall.c                          |   2 +
 tools/include/uapi/linux/bpf.h                |   7 +
 tools/testing/selftests/bpf/Makefile          |   2 +-
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/relay_map.c      | 197 ++++++++++++++++
 .../selftests/bpf/progs/test_relay_map.c      |  69 ++++++
 11 files changed, 514 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/relaymap.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/relay_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_relay_map.c

--
2.32.0.3.g01195cf9f


