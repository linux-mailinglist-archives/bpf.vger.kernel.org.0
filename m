Return-Path: <bpf+bounces-42520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6429A5396
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 13:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537241F2283C
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 11:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5915F15B0F2;
	Sun, 20 Oct 2024 11:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JZuV1lWh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9503D1C6B8
	for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729422256; cv=none; b=eNzm8kX0qh6JRO+qZMHwMy8L/7OIFep22lbLZDA7iwqh6H9UndEflXvcA431J/DCb/8HU4VwxO8qgsAyUF61QISn3JJee6UYJaT68jpfKy8HDQ8JDINwDMqbPjaDUeOAvqDuxv8u3+I0r3SaxcZoiqyGAKTwWvN//2ZRrac35jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729422256; c=relaxed/simple;
	bh=iREghhpJE4+DtMds/6XctW4ssStqfdu/Omy+ZDLWcVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hd7xkW4PjN3scJcf2JPEv2VzrIOQcUCmM0P0Zioz35OOZw2WoLD5SD1iymj6EZhbQhk91hSEzlNo2+ikKMfUuQ8OopkJQxVkmHPO/T3o6G8KyYqh3PV1+zSwokU5AOAXnWCDXHSrl6jMKW85dEOHbYkfrCs/XnKYs5fNljSl/4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JZuV1lWh; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cbce9e4598so21856286d6.2
        for <bpf@vger.kernel.org>; Sun, 20 Oct 2024 04:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729422253; x=1730027053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TT3/6lwJzJQiWH62RMbn4eAA8oCkVQnYLdFA8bYxFq8=;
        b=JZuV1lWh/QKOaMkgQukIoUy+OIEsJGBYzpR8tFXVJSeEoQjS2Ux709HAyF3nSuo2V6
         T5QJIlQ5QcGg+WM3pa/BYB0r2kOPBXMQH595h/baTKq+p97o/uJqUUvuNvFXoUK0mUu3
         psuCAAT2sKXq/0IEtUd9qBujlQMvVeYnGnjcxAJDMC9YnHUd1tIT5deNfVT/qX0cFVxf
         ZmX+xxvb4wLheuhW7gbGZhpbbcZ3hb6064qw+EFrTnyXZNodiQWz5S9pmbibEN6bLpGQ
         e3/fmRviRo/7u2PgV5NlvPNP9N0TED1YC4QnNKijxfuTAYnP57z7+FlQGykGuC0hoVlb
         hEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729422253; x=1730027053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TT3/6lwJzJQiWH62RMbn4eAA8oCkVQnYLdFA8bYxFq8=;
        b=j8sUqvj2SldvC0nQpYJmGrQmNsxKVZY4x1iPP3oeqSAgBARsbUxg3mhSXGwjq7lh57
         iZrzHw7RlkP4S3eA/jKDI0yCo6v4iB2PBx6kDK3otfwt4qppB4Mn65F8pUA+u/7Ke8ZY
         gnoDS2lAf1KuTAdzZ1p+lg1hZ3JIO9crYUCyhOfq6VV2L5YjVk01T1Nfp1hwAitK9OlY
         hMy4L46N0cmWwm8BQwUTH+e+CjREXY4tqOJr7cxW7261U5ajIdGm2/EFSqmAYV9KVmNq
         Bh3QalJ55z26M4WcTbZDD6ep2jCXuGQKTOaGfMayVV+FPnaplHHzy6z7WJcXmdorU6or
         zmnQ==
X-Gm-Message-State: AOJu0Yz7a2e5NJefdtHTO2+mHO6yShisqZb+YFG44dpqrxs5Ijy1Pc+M
	RzVhnj1vIAfS3TxvaJXRxMp21As8XAfNKG8T37BkPRotB+cP0YtsUVdWQSCAnRNGPvbzLB9Iooo
	r
X-Google-Smtp-Source: AGHT+IE9+JobCzvwRnoa4dEN3KzSvPbR8qfU4CDYIj/vmqPqphZHmauq6dyaEp4gx6RTfGhwmbWO1w==
X-Received: by 2002:a05:6214:3bc9:b0:6cc:70e:3fcd with SMTP id 6a1803df08f44-6cde165c351mr135686156d6.42.1729422252644;
        Sun, 20 Oct 2024 04:04:12 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce00700c0csm6715216d6.0.2024.10.20.04.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 04:04:11 -0700 (PDT)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	jakub@cloudflare.com,
	liujian56@huawei.com,
	zijianzhang@bytedance.com,
	cong.wang@bytedance.com
Subject: [PATCH bpf 0/8] Fixes to bpf_msg_push/pop_data and test_sockmap
Date: Sun, 20 Oct 2024 11:03:37 +0000
Message-Id: <20241020110345.1468595-1-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

Several fixes to test_sockmap and added push/pop logic for msg_verify_data
Before the fixes, some of the tests in test_sockmap are problematic,
resulting in pseudo-correct result.

1. txmsg_pass is not set in some tests, as a result, no eBPF program is
attached to the sockmap.
2. In SENDPAGE, a wrong iov_length in test_send_large may result in some
test skippings and failures.
3. The calculation of total_bytes in msg_loop_rx is wrong, which may cause
msg_loop_rx end early and skip some data tests.

Besides, for msg_verify_data, I added push/pop checking logic to function
msg_verify_data and added more tests for different cases.

After that, I found that there are some bugs in bpf_msg_push_data,
bpf_msg_pop_data and sk_msg_reset_curr, and fix them. I guess the reason
why they have not been exposed is that because of the above problems, they
will not be triggered.

With the fixes, we can pass the sockmap test with data integrity test now.
However, the fixes to test_sockmap expose more problems in sockhash test
with SENDPAGE and ktls with SENDPAGE.

The problem I observed,
1. In sockhash test, a NULL pointer kernel BUG will be reported for nearly
every cork test. More inspections are needed for splice_to_socket.

BUG: kernel NULL pointer dereference, address: 0000000000000008
PGD 0 P4D 0 
Oops: Oops: 0000 [#3] PREEMPT SMP PTI
CPU: 3 UID: 0 PID: 2122 Comm: test_sockmap 6.12.0-rc2.bm.1-amd64+ #98
Tainted: [D]=DIE
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
RIP: 0010:splice_to_socket+0x34a/0x480
Call Trace:
 <TASK>
 ? __die_body+0x1e/0x60
 ? page_fault_oops+0x159/0x4d0
 ? exc_page_fault+0x7e/0x180
 ? asm_exc_page_fault+0x26/0x30
 ? splice_to_socket+0x34a/0x480
? __memcg_slab_post_alloc_hook+0x205/0x3c0
? alloc_pipe_info+0xd6/0x1f0
? __kmalloc_noprof+0x37f/0x3b0
direct_splice_actor+0x40/0x100
splice_direct_to_actor+0xfd/0x290
? __pfx_direct_splice_actor+0x10/0x10
do_splice_direct_actor+0x82/0xb0
? __pfx_direct_file_splice_eof+0x10/0x10
do_splice_direct+0x13/0x20
? __pfx_direct_splice_actor+0x10/0x10
do_sendfile+0x33c/0x3f0
__x64_sys_sendfile64+0xa7/0xc0
do_syscall_64+0x62/0x170
entry_SYSCALL_64_after_hwframe+0x76/0x7e
 </TASK>
Modules linked in:
CR2: 0000000000000008
---[ end trace 0000000000000000 ]---

2. txmsg_pass are not set before, and some tests are skipped. Now after
the fixes, we have some failure cases now. More fixes are needed either
for the selftest or the ktls kernel code.

1/ 6 sockhash:ktls:txmsg test passthrough:OK
2/ 6 sockhash:ktls:txmsg test redirect:OK
3/ 1 sockhash:ktls:txmsg test redirect wait send mem:OK
4/ 6 sockhash:ktls:txmsg test drop:OK
5/ 6 sockhash:ktls:txmsg test ingress redirect:OK
6/ 7 sockhash:ktls:txmsg test skb:OK
7/12 sockhash:ktls:txmsg test apply:OK
8/12 sockhash:ktls:txmsg test cork:OK
9/ 3 sockhash:ktls:txmsg test hanging corks:OK
detected data corruption @iov[0]:0 17 != 00, 03 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
detected data corruption @iov[0]:0 17 != 00, 03 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
10/11 sockhash:ktls:txmsg test push_data:FAIL
detected data corruption @iov[0]:0 17 != 00, 00 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
detected data corruption @iov[0]:0 17 != 00, 00 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
detected data corruption @iov[0]:0 17 != 00, 03 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
detected data corruption @iov[0]:0 17 != 00, 03 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
detected data corruption @iov[0]:0 17 != 00, 03 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
detected data corruption @iov[0]:0 17 != 00, 03 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
detected data corruption @iov[0]:0 17 != 00, 03 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
detected data corruption @iov[0]:0 17 != 00, 03 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
11/17 sockhash:ktls:txmsg test pull-data:FAIL
recv failed(): Invalid argument
rx thread exited with err 1.
recv failed(): Invalid argument
rx thread exited with err 1.
recv failed(): Bad message
rx thread exited with err 1.
detected data corruption @iov[0]:0 17 != 00, 03 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
detected data corruption @iov[0]:0 17 != 00, 03 ?= 01
data verify msg failed: Unknown error -2001
rx thread exited with err 1.
12/ 9 sockhash:ktls:txmsg test pop-data:FAIL
recv failed(): Bad message
rx thread exited with err 1.
recv failed(): Bad message
rx thread exited with err 1.
13/ 6 sockhash:ktls:txmsg test push/pop data:FAIL
14/ 1 sockhash:ktls:txmsg test ingress parser:OK
15/ 0 sockhash:ktls:txmsg test ingress parser2:OK
Pass: 11 Fail: 17

Zijian Zhang (8):
  selftests/bpf: Add txmsg_pass to pull/push/pop in test_sockmap
  selftests/bpf: Fix SENDPAGE data logic in test_sockmap
  selftests/bpf: Fix total_bytes in msg_loop_rx in test_sockmap
  selftests/bpf: Add push/pop checking for msg_verify_data in
    test_sockmap
  selftests/bpf: Add more tests for test_txmsg_push_pop in test_sockmap
  bpf, sockmap: Several fixes to bpf_msg_push_data
  bpf, sockmap: Several fixes to bpf_msg_pop_data
  bpf, sockmap: Fix sk_msg_reset_curr

 net/core/filter.c                          |  89 +++++-----
 tools/testing/selftests/bpf/test_sockmap.c | 180 +++++++++++++++++++--
 2 files changed, 215 insertions(+), 54 deletions(-)

-- 
2.20.1


