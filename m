Return-Path: <bpf+bounces-78224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5F7D03566
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 15:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B29B93133AE2
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 13:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45C6289367;
	Thu,  8 Jan 2026 12:37:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C0025F96D;
	Thu,  8 Jan 2026 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875837; cv=none; b=jziZZe7fEX7xhteIZdCWQs2IjdN3xGW1cGFFcaUeoJ7UGF/M214yUSSUlB88ksVDNpgsWdOe/T0yl64U435i47xeQFjaZSSrvJs9fisODQuPg08LZ6GYkwhqwhmZIjUMNDIskzmMiTzbXabUMA4SZXAq2La/i+kcyYfHw8kt3y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875837; c=relaxed/simple;
	bh=wpKLk8BQH1V2xzo/cRXxx/KORapCsDPw2V9PiZlnX8Q=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=tM6Zx7hGcWf37ZNvdfwyI7dUlNy7XJx+LC264vbVHTkxvB/4tmdhWhCAw7P8xuA7jXPezY6lSc0LkIfFJWiyGIXQ5YFmAgGt8zUgmTkzgM7WIm9WZfvi4bRvxWtKTDO5g/3PFp+e4ah8iJcQMi5JqUeMWePDfyNwOeyiom6+yuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 608Callq002465;
	Thu, 8 Jan 2026 21:36:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 608CalOZ002460
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 8 Jan 2026 21:36:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <af090e53-9d9b-4412-8acb-957733b3975c@I-love.SAKURA.ne.jp>
Date: Thu, 8 Jan 2026 21:36:48 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Toke Hoiland-Jorgensen <toke@redhat.com>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] bpf: fix reference count leak in bpf_prog_test_run_xdp()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav105.rs.sakura.ne.jp
X-Virus-Status: clean

syzbot is reporting

  unregister_netdevice: waiting for sit0 to become free. Usage count = 2

problem. A debug printk() patch found that a refcount is obtained at
xdp_convert_md_to_buff() from bpf_prog_test_run_xdp().

According to commit ec94670fcb3b ("bpf: Support specifying ingress via
xdp_md context in BPF_PROG_TEST_RUN"), the refcount obtained by
xdp_convert_md_to_buff() will be released by xdp_convert_buff_to_md().

Therefore, we can consider that the error handling path introduced by
commit 1c1949982524 ("bpf: introduce frags support to
bpf_prog_test_run_xdp()") forgot to call xdp_convert_buff_to_md().

Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
Fixes: 1c1949982524 ("bpf: introduce frags support to bpf_prog_test_run_xdp()")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Since syzbot has no reproducer for this problem, I can't test this patch.

 net/bpf/test_run.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 655efac6f133..9a16293ba14b 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1355,13 +1355,13 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 
 			if (sinfo->nr_frags == MAX_SKB_FRAGS) {
 				ret = -ENOMEM;
-				goto out;
+				goto out_put_dev;
 			}
 
 			page = alloc_page(GFP_KERNEL);
 			if (!page) {
 				ret = -ENOMEM;
-				goto out;
+				goto out_put_dev;
 			}
 
 			frag = &sinfo->frags[sinfo->nr_frags++];
@@ -1373,7 +1373,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 			if (copy_from_user(page_address(page), data_in + size,
 					   data_len)) {
 				ret = -EFAULT;
-				goto out;
+				goto out_put_dev;
 			}
 			sinfo->xdp_frags_size += data_len;
 			size += data_len;
@@ -1388,6 +1388,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 		ret = bpf_test_run_xdp_live(prog, &xdp, repeat, batch_size, &duration);
 	else
 		ret = bpf_test_run(prog, &xdp, repeat, &retval, &duration, true);
+out_put_dev:
 	/* We convert the xdp_buff back to an xdp_md before checking the return
 	 * code so the reference count of any held netdevice will be decremented
 	 * even if the test run failed.
-- 
2.47.3


