Return-Path: <bpf+bounces-52639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1ADA460B0
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 14:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A7B17A01B
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 13:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B3F221F39;
	Wed, 26 Feb 2025 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MF1PRG5Q"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D242206B3
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576200; cv=none; b=iFMSOnSqv5Ux8pIcr3OZ0Gula3ln/tlVOqj1kOpUOfUNHziT09PN7Vpkgzt0T+L6Lwpqzu5wEmbxpGyGR9zIyTt75GfeTNo6GMBkdfCnkxuiIqdmxGKRjN8IMe5FoWUPrWZgrGB97fITss7w1P9H+Mh/4YDWCEytK8qRWqRBTCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576200; c=relaxed/simple;
	bh=BNBjN9eojJuckvSPmE2E6Krsv7VXfHHr3UGTTgvNq2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pDUQaYSqfyNXRg+n+Wsqk4sQUgUX8fkKdN8Whp9VCKvN95Edn2kzQyY6MEGZDEsC8XX8fn0DhAGyTC6GO+8w93MiTQXy5NgEI3okVQYY0j+Po3FJTd8Qg8jVUAt8/dJ6zKDY0Gl1YDiyXrx4M78e6NwIrTyevbg9TAjf9Am78ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MF1PRG5Q; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740576186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LIrVE00T1J3Jz4vdwi9do6q1hDo8nGa1bNYBlY2fo8E=;
	b=MF1PRG5QQ1Lqq7wFZG6q8r8CMol2naHU/jSKSQcnkINwj7weVztyp1WqNvpg3VINv/Eagu
	UQJz/MQx3uCsrKpXXyVmU+KtzlQ4AXW1YfmXE0s9Tuz3zDBtPXfEZ4vaH44dG5/ZLgL+t0
	FzDdjq2JIzguGZDV3fxP8WfDZtVwvis=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: cong.wang@bytedance.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	mhal@rbox.co,
	jiayuan.chen@linux.dev,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mrpre@163.com
Subject: [PATCH bpf-next v1 0/3] bpf: Fix use-after-free of sockmap
Date: Wed, 26 Feb 2025 21:22:39 +0800
Message-ID: <20250226132242.52663-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

1. Issue
Syzkaller reported this issue [1].

2. Reproduce

We can reproduce this issue by using the test_sockmap_with_close_on_write()
test I provided in selftest, also you need to apply the following patch to
ensure 100% reproducibility (sleep after checking sock):

'''
static void sk_psock_verdict_data_ready(struct sock *sk)
{
        .......
        if (unlikely(!sock))
                return;
+       if (!strcmp("test_progs", current->comm)) {
+               printk("sleep 2s to wait socket freed\n");
+               mdelay(2000);
+               printk("sleep end\n");
+       }
        ops = READ_ONCE(sock->ops);
        if (!ops || !ops->read_skb)
                return;
}
'''

Then running './test_progs -v sockmap_basic', and if the kernel has KASAN
enabled [2], you will see the following warning:

'''
BUG: KASAN: slab-use-after-free in sk_psock_verdict_data_ready+0x29b/0x2d0
Read of size 8 at addr ffff88813a777020 by task test_progs/47055

Tainted: [O]=OOT_MODULE
Call Trace:
 <TASK>
 dump_stack_lvl+0x53/0x70
 print_address_description.constprop.0+0x30/0x420
 ? sk_psock_verdict_data_ready+0x29b/0x2d0
 print_report+0xb7/0x270
 ? sk_psock_verdict_data_ready+0x29b/0x2d0
 ? kasan_addr_to_slab+0xd/0xa0
 ? sk_psock_verdict_data_ready+0x29b/0x2d0
 kasan_report+0xca/0x100
 ? sk_psock_verdict_data_ready+0x29b/0x2d0
 sk_psock_verdict_data_ready+0x29b/0x2d0
 unix_stream_sendmsg+0x4a6/0xa40
 ? __pfx_unix_stream_sendmsg+0x10/0x10
 ? fdget+0x2c1/0x3a0
 __sys_sendto+0x39c/0x410
'''

3. Reason
'''
CPU0                                             CPU1
unix_stream_sendmsg(sk):
  other = unix_peer(sk)
  other->sk_data_ready(other):
    socket *sock = sk->sk_socket
    if (unlikely(!sock))
        return;
                                                 close(other):
                                                   ...
                                                   other->close()
                                                   free(socket)
    READ_ONCE(sock->ops)
    ^
    use 'sock' after free
'''

For TCP, UDP, or other protocols, we have already performed
rcu_read_lock() when the network stack receives packets in ip_input.c:
'''
ip_local_deliver_finish():
    rcu_read_lock()
    ip_protocol_deliver_rcu()
        xxx_rcv
    rcu_read_unlock()
'''

However, for Unix sockets, sk_data_ready is called directly from the
process context without rcu_read_lock() protection.

4. Solution
Based on the fact that the 'struct socket' is released using call_rcu(),
We add rcu_read_{un}lock() at the entrance and exit of our sk_data_ready.
It will not increase performance overhead, at least for TCP and UDP, they
are already in a relatively large critical section.

Of course, we can also add a custom callback for Unix sockets and call
rcu_read_lock() before calling _verdict_data_ready like this:
'''
if (sk_is_unix(sk))
    sk->sk_data_ready = sk_psock_verdict_data_ready_rcu;
else
    sk->sk_data_ready = sk_psock_verdict_data_ready;

sk_psock_verdict_data_ready_rcu():
    rcu_read_lock()
    sk_psock_verdict_data_ready()
    rcu_read_unlock()
'''
However, this will cause too many branches, and it's not suitable to
distinguish network protocols in skmsg.c.

[1] https://syzkaller.appspot.com/bug?extid=dd90a702f518e0eac072
[2] https://syzkaller.appspot.com/text?tag=KernelConfig&x=1362a5aee630ff34

Jiayuan Chen (3):
  bpf, sockmap: avoid using sk_socket after free
  selftests/bpf: Add socketpair to create_pair to support unix socket
  selftests/bpf: Add edge case tests for sockmap

 net/core/skmsg.c                              | 18 ++++--
 .../selftests/bpf/prog_tests/socket_helpers.h | 13 ++++-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 57 +++++++++++++++++++
 3 files changed, 82 insertions(+), 6 deletions(-)

-- 
2.47.1


