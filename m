Return-Path: <bpf+bounces-43083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59399AF35C
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 22:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542311F2314F
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 20:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C9C1F5831;
	Thu, 24 Oct 2024 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KjKTHrSL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C35822B642
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 20:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729800800; cv=none; b=dh3UYMrlSPkzMpiHYCeYBThSHq81wYU2K84elaQpameElTBAJRebB2yfvIhdeha2NtWBB3NqbTK/6enntJJ+wc6QEVrup4klH2EpAjyz1GOi57brA7rlViBsdKg99xf2YDqJCqbQzrlobde63aVC3RamnkBjN8GFvme4LyzeSxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729800800; c=relaxed/simple;
	bh=aBzaZtXf4mNWyE2ff91L3zjcJqxmizoaLTC7A66Td/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e+/Jmy0F0srI3QcY3nLSjGuWbJxuekkuRQyjXF2TEH+NpCe6F1kCYiR9Ogw53gZVJMxiCDp27dp1bmcuvubJKrK9rV7kOgrsN2vtsIGosnNAq/O1Kozp42lcmpa05vim4xgag537s/UeR6WByctTyMpPISfsqUSNjt+9PT1GKgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KjKTHrSL; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b152a23e9aso93054785a.0
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 13:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729800796; x=1730405596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eyj1ZNcgRwOXsluqNrXT26K+za/Sz/ZFq8b64jlwILI=;
        b=KjKTHrSLFeVTTZLRio8u+y/qEPpl5VF3oQ5gpghl4JjHDeJOvL8bLYZqjQQBamY8h3
         Yi8pJov86JHXUJWdaEHQMTxrfp8uqkKuIZpUla6ZNLbHtZORfWYbMmnRoxk/sRbcXEQj
         USDWklk/qOx0DwgADRvXEAs16tEqoO16clnbfI3snu6YY9FHCw1dca1SabOn4TuWnwig
         W/+2supu6mfltxdOzgZXvN/1i682N/8qgUplAzrj8SWsf4s11Gv2Mlnxs+x4RanIp0Wo
         I+CbOXarLIMpxaz923A07jmaMACns14yxdWdXGouA/F7kdlxh0PWROBwlpu73NCtC06K
         PzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729800796; x=1730405596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyj1ZNcgRwOXsluqNrXT26K+za/Sz/ZFq8b64jlwILI=;
        b=C1VyYLcWrmF7oej/Zmz+59xfHHQwlbARLdZd7a/YXKxHFrSLO8bXw3U3DSQ42I2LeF
         ucEPqGyIaj3H7qBTfchiPQDeFnDjSQeLmh/lb2GLySUx1mCYNhZUFN/VerObq+pYxodN
         uydxFB9vvtBywxnfWuBUDNEGXc9EHvicXii54bhaNjNu37i6h+9fR5lLZ+3FDKe7oZo+
         3Kg8KJ/2yLevVKCIo+wnSIDlBtUZgBvQDdaCQcybprTY9ohvgFPq9fLD+cOG2f58Qn6c
         TwBdoJhEW6frCndeA1RMP7R+4f9KVshCmogMRGnzJP9SJzkcvznr1MDOzb6aIn6gBWiy
         J4xg==
X-Gm-Message-State: AOJu0YzUNPOnfMERCe0xWal624B0TTusJHJ4Ku4cmUml6Fku+NmDOSn9
	XFohPhugB8AUa8dIW07PcDunL3cTfwFfFZhdFX0XF6pXzJLpjeLedhO+MN8BXkZp2if406dzOP1
	6
X-Google-Smtp-Source: AGHT+IFLLlNQuJZKOjDHhkfo4j7SyLSaE6KmwASHL3jWKou3QWUBqrcBFD9w0BwR5yQPz2W0T/IoYw==
X-Received: by 2002:a05:620a:44d4:b0:7b1:4ad5:571c with SMTP id af79cd13be357-7b186cc3a57mr377410385a.38.1729800796439;
        Thu, 24 Oct 2024 13:13:16 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.111])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a037fbsm518952785a.60.2024.10.24.13.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:13:15 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next/net 0/8] Fixes to bpf_msg_push/pop_data and test_sockmap
Date: Thu, 24 Oct 2024 20:12:58 +0000
Message-Id: <20241024201306.3429177-1-zijianzhang@bytedance.com>
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

v1 -> v2:
  - Rebased to the latest bpf-next net branch.

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

 net/core/filter.c                          |  88 +++++-----
 tools/testing/selftests/bpf/test_sockmap.c | 180 +++++++++++++++++++--
 2 files changed, 214 insertions(+), 54 deletions(-)

-- 
2.20.1


