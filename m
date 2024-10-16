Return-Path: <bpf+bounces-42255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C119C9A1641
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 01:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758FA1F22DE8
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 23:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880C51D54F2;
	Wed, 16 Oct 2024 23:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lB+LwGcb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799B61D26E0
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 23:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729122554; cv=none; b=YldQzIEkkHUqBovQ4gGWpRq6eTlaePeiG4efDyhK5rIp+A42bwiEEmTfW9E6Aj6KkRMM5kS44cDQSDX9x59ckuU+AqVM7ilHchWejkGPNRFdvRsGSXlgkryqipZYHuNRHNO5aMoF/SUaj8J6CNefs01cZ006QxHUZKH0+AZ9Z1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729122554; c=relaxed/simple;
	bh=GJ9jPdsWKc7r3MAedaWsAVxWhbxwE1PJCerGSDO4/SQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YzcNDKHReD5QEg/n79j6I2RtgYF3in7Wj0kU+vFH2kMUGbTvngmdGHx4Z94v4JKAaHgS88qEQ6E7HJCB+BgfDiFXlHuyWx4NRaJNQz9r78tzBcDSLzHq1+ZupmG+zbUrrfx0Oz/Om8cj27yC0H8o7bB9B1COMFPLM3Xa304mprA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lB+LwGcb; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbe68f787dso2071936d6.2
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 16:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729122551; x=1729727351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9ysfQzDmHWqnPDKTHK04Je2pEqto3kdIglB8STzBO4=;
        b=lB+LwGcbR29m6zqoRgrZPti8KyzocqrDlLi5pVOfbwlKacb/xyie6h81Z3XA5TJciy
         hpavyL7OqScPDhopZ6KOzxKGgg+Bl5T0smTVPHORI2+sPkHYYYlhLzOQHM473XGWEQON
         OHhRGBqfOlbGuF1suIWcTc7q/CPQhJesiArbevlgqpNTlJuufRFpIfLxftxZDZeLHgeP
         gc7hsiEu3R8ssyrJev4ZFR5mmZ6BnwyeBXQPe5ZvdOL8B8Y+uXPG26ea8Lu21Uj/3tmJ
         fXlFqyxxmyXfS76m5glMVy8p2fN3skCRqv6nJ1KuGW8gr6aRJQWZTgtIRzAP6O+ztvJa
         /R4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729122551; x=1729727351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9ysfQzDmHWqnPDKTHK04Je2pEqto3kdIglB8STzBO4=;
        b=rlmH/WU37I9zKSUOVmZARM+uFlPPZQehDSgoq7ghyqRA2jmxySUp1w/Nd3ysTeuE4+
         G2Di53EnweA83i6cBouMkIv9T4umwciuEiDWRBiwzAqro8KM6fam1PcQ10ABuh1DuuEI
         WTfjC9N8SCfdW6scvJlQXFn4YFI6zOmNKPzgMwGnXsSN3knG5DFzKKzeW5+qHfN1gkc4
         tB6Z9Uj+l5hbzT+rhhvtmCeodLLRE39A+FS1SJtxjUQyWo2pB9EavLieCx9CqdFpbZsz
         azAEzyWjHiQjqvENFTPPchD8IjV0W+5Ymrirv8suBtD4ZQQZvqz9WHNue1tTQ4WsEynX
         vKvA==
X-Gm-Message-State: AOJu0YztHHKRvvA3/+rxAgPBi9iBoLhOyU5dZJVlnnGMK3gu/Wxm5W8+
	l3//sZP4j8BEe9VubuzcJBFD2g1agtdpnz6Ve/aR65LUJ6EylYMRwSko7RRzpHKrKEzLwh5fT77
	3
X-Google-Smtp-Source: AGHT+IGp+UrAxGyOFO604SkFfn8JvIEDJIgcoOG/K/fYPQnR66UlfX+yujm6k7GP7kfdL7Fz129ZAA==
X-Received: by 2002:a05:6214:3212:b0:6c5:5f04:3665 with SMTP id 6a1803df08f44-6cbf0129cb2mr296579496d6.48.1729122550589;
        Wed, 16 Oct 2024 16:49:10 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.237])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22959ae2sm22909296d6.93.2024.10.16.16.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 16:49:09 -0700 (PDT)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: edumazet@google.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	wangyufen@huawei.com,
	xiyou.wangcong@gmail.com,
	zijianzhang@bytedance.com
Subject: [PATCH bpf 2/2] tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sendmsg
Date: Wed, 16 Oct 2024 23:48:38 +0000
Message-Id: <20241016234838.3167769-3-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241016234838.3167769-1-zijianzhang@bytedance.com>
References: <20241016234838.3167769-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

The current sk memory accounting logic in __SK_REDIRECT is pre-uncharging
tosend bytes, which is either msg->sg.size or a smaller value apply_bytes.
Potential problems with this strategy are as follows:
- If the actual sent bytes are smaller than tosend, we need to charge some
bytes back, as in line 487, which is okay but seems not clean.
- When tosend is set to apply_bytes, as in line 417, and (ret < 0), we may
miss uncharging (msg->sg.size - apply_bytes) bytes.

415 tosend = msg->sg.size;
416 if (psock->apply_bytes && psock->apply_bytes < tosend)
417   tosend = psock->apply_bytes;
...
443 sk_msg_return(sk, msg, tosend);
444 release_sock(sk);
446 origsize = msg->sg.size;
447 ret = tcp_bpf_sendmsg_redir(sk_redir, redir_ingress,
448                             msg, tosend, flags);
449 sent = origsize - msg->sg.size;
...
454 lock_sock(sk);
455 if (unlikely(ret < 0)) {
456   int free = sk_msg_free_nocharge(sk, msg);
458   if (!cork)
459     *copied -= free;
460 }
...
487 if (eval == __SK_REDIRECT)
488   sk_mem_charge(sk, tosend - sent);

When running the selftest test_txmsg_redir_wait_sndmem with txmsg_apply,
the following warning will be reported,
------------[ cut here ]------------
WARNING: CPU: 6 PID: 57 at net/ipv4/af_inet.c:156 inet_sock_destruct+0x190/0x1a0
Modules linked in:
CPU: 6 UID: 0 PID: 57 Comm: kworker/6:0 Not tainted 6.12.0-rc1.bm.1-amd64+ #43
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
Workqueue: events sk_psock_destroy
RIP: 0010:inet_sock_destruct+0x190/0x1a0
RSP: 0018:ffffad0a8021fe08 EFLAGS: 00010206
RAX: 0000000000000011 RBX: ffff9aab4475b900 RCX: ffff9aab481a0800
RDX: 0000000000000303 RSI: 0000000000000011 RDI: ffff9aab4475b900
RBP: ffff9aab4475b990 R08: 0000000000000000 R09: ffff9aab40050ec0
R10: 0000000000000000 R11: ffff9aae6fdb1d01 R12: ffff9aab49c60400
R13: ffff9aab49c60598 R14: ffff9aab49c60598 R15: dead000000000100
FS:  0000000000000000(0000) GS:ffff9aae6fd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffec7e47bd8 CR3: 00000001a1a1c004 CR4: 0000000000770ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
<TASK>
? __warn+0x89/0x130
? inet_sock_destruct+0x190/0x1a0
? report_bug+0xfc/0x1e0
? handle_bug+0x5c/0xa0
? exc_invalid_op+0x17/0x70
? asm_exc_invalid_op+0x1a/0x20
? inet_sock_destruct+0x190/0x1a0
__sk_destruct+0x25/0x220
sk_psock_destroy+0x2b2/0x310
process_scheduled_works+0xa3/0x3e0
worker_thread+0x117/0x240
? __pfx_worker_thread+0x10/0x10
kthread+0xcf/0x100
? __pfx_kthread+0x10/0x10
ret_from_fork+0x31/0x40
? __pfx_kthread+0x10/0x10
ret_from_fork_asm+0x1a/0x30
</TASK>
---[ end trace 0000000000000000 ]---

In __SK_REDIRECT, a more concise way is delaying the uncharging after sent
bytes are finalized, and uncharge this value. When (ret < 0), we shall
invoke sk_msg_free.

Same thing happens in case __SK_DROP, when tosend is set to apply_bytes,
we may miss uncharging (msg->sg.size - apply_bytes) bytes. The same
warning will be reported in selftest.

468 case __SK_DROP:
469 default:
470 sk_msg_free_partial(sk, msg, tosend);
471 sk_msg_apply_bytes(psock, tosend);
472 *copied -= (tosend + delta);
473 return -EACCES;

So instead of sk_msg_free_partial we can do sk_msg_free here.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Fixes: 8ec95b94716a ("bpf, sockmap: Fix the sk->sk_forward_alloc warning of sk_stream_kill_queues")
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 net/ipv4/tcp_bpf.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index e7658c5d6b79..7b49bf0afbac 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -440,7 +440,6 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 			cork = true;
 			psock->cork = NULL;
 		}
-		sk_msg_return(sk, msg, tosend);
 		release_sock(sk);
 
 		origsize = msg->sg.size;
@@ -452,8 +451,9 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 			sock_put(sk_redir);
 
 		lock_sock(sk);
+		sk_mem_uncharge(sk, sent);
 		if (unlikely(ret < 0)) {
-			int free = sk_msg_free_nocharge(sk, msg);
+			int free = sk_msg_free(sk, msg);
 
 			if (!cork)
 				*copied -= free;
@@ -467,7 +467,7 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 		break;
 	case __SK_DROP:
 	default:
-		sk_msg_free_partial(sk, msg, tosend);
+		sk_msg_free(sk, msg);
 		sk_msg_apply_bytes(psock, tosend);
 		*copied -= (tosend + delta);
 		return -EACCES;
@@ -483,11 +483,8 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 		}
 		if (msg &&
 		    msg->sg.data[msg->sg.start].page_link &&
-		    msg->sg.data[msg->sg.start].length) {
-			if (eval == __SK_REDIRECT)
-				sk_mem_charge(sk, tosend - sent);
+		    msg->sg.data[msg->sg.start].length)
 			goto more_data;
-		}
 	}
 	return ret;
 }
-- 
2.20.1


