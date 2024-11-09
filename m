Return-Path: <bpf+bounces-44428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5165C9C2E01
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 16:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E7A1F2121E
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 15:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E61E199FC1;
	Sat,  9 Nov 2024 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NN+u/TW8"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890691946A4;
	Sat,  9 Nov 2024 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731164721; cv=none; b=OsNAdbWGMxU/X5At4OslzPXlnHxNLWVweXVTx3tIOVGdnAM1fxRNTZ4IkGAim/bpH9dnyyqGVN5AkY+fR+VK+c+6AWXJBYB3NgmppRuT42ChS+klchuwWC9f6Gr3sNFVfS+12gBHpQ3Jsn1hb22mSDxw+56dS272VnI4+cILAJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731164721; c=relaxed/simple;
	bh=s/HE862Ebjc4x9QSbLryT2tjzrtXi+x51IAifw3w0tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TF2ZYEcm5I35aTVyjVIVlXIf89vZjhiZXMfyjTTVFha54gDW6QjCWnPb2Wevu333FMWrXV16/3YXYezQbxE2SwxKRx6Sbkvp9SdB4CTl6fjS9FKFgjXT3I6RIAGe2TQYVEqLXs9UuTwjJlG61hJKJ3JPI/Ukf2thnipN+qZ0zW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NN+u/TW8; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=0mQMe
	EqbIH1W/gwL+X7sQKXQSByBBidMVZJPmvHc5LI=; b=NN+u/TW8ioIIC5LkpoM8j
	bh7KVHuYGtfHirZboAFQEdVfG20egBLydDKbfd4kFMm6FRBG9NG8vX4xHjw2h4J5
	wP95q5qwPfhbKML8O7an/FvyeYbNxRgKxDfeGV4UTCeNQvJAZ613fOU19+C7WcXM
	rF9hf983qkrro4dsQvqPE0=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBnT4exeS9n3Jk_GA--.36911S3;
	Sat, 09 Nov 2024 23:03:29 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: martin.lau@linux.dev,
	edumazet@google.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	daniel@iogearbox.net
Cc: Jiayuan Chen <mrpre@163.com>,
	Vincent Whitchurch <vincent.whitchurch@datadoghq.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf v2 1/2] bpf: fix recursive lock when verdict program return SK_PASS
Date: Sat,  9 Nov 2024 23:03:04 +0800
Message-ID: <20241109150305.141759-2-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241109150305.141759-1-mrpre@163.com>
References: <20241109150305.141759-1-mrpre@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnT4exeS9n3Jk_GA--.36911S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWkAr1DXF4Duw48JF4fKrg_yoW8Aw1Dpa
	4ku3y5GF9rZr18Z3s3KF97Xr1jgw1vgay2gr1ruw1fZrn0gry5urZ5KFy2vF4YvrsrKF98
	Zr4jqFsrtw17XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piU3vUUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDweSp2cvca9g6AAAsj

When the stream_verdict program returns SK_PASS, it places the received skb
into its own receive queue, but a recursive lock eventually occurs, leading
to an operating system deadlock. This issue has been present since v6.9.

'''
sk_psock_strp_data_ready
    write_lock_bh(&sk->sk_callback_lock)
    strp_data_ready
      strp_read_sock
        read_sock -> tcp_read_sock
          strp_recv
            cb.rcv_msg -> sk_psock_strp_read
              # now stream_verdict return SK_PASS without peer sock assign
              __SK_PASS = sk_psock_map_verd(SK_PASS, NULL)
              sk_psock_verdict_apply
                sk_psock_skb_ingress_self
                  sk_psock_skb_ingress_enqueue
                    sk_psock_data_ready
                      read_lock_bh(&sk->sk_callback_lock) <= dead lock

'''

This topic has been discussed before, but it has not been fixed.
Previous discussion:
https://lore.kernel.org/all/6684a5864ec86_403d20898@john.notmuch

Fixes: 6648e613226e ("bpf, skmsg: Fix NULL pointer dereference in sk_psock_skb_ingress_enqueue")
Reported-by: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Signed-off-by: Jiayuan Chen <mrpre@163.com>
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 net/core/skmsg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index b1dcbd3be89e..e90fbab703b2 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1117,9 +1117,9 @@ static void sk_psock_strp_data_ready(struct sock *sk)
 		if (tls_sw_has_ctx_rx(sk)) {
 			psock->saved_data_ready(sk);
 		} else {
-			write_lock_bh(&sk->sk_callback_lock);
+			read_lock_bh(&sk->sk_callback_lock);
 			strp_data_ready(&psock->strp);
-			write_unlock_bh(&sk->sk_callback_lock);
+			read_unlock_bh(&sk->sk_callback_lock);
 		}
 	}
 	rcu_read_unlock();
-- 
2.43.5


