Return-Path: <bpf+bounces-37628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9289586F7
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 14:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE028B2473D
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 12:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0167518FDBF;
	Tue, 20 Aug 2024 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="U2AfiCQR"
X-Original-To: bpf@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD8E18FC91;
	Tue, 20 Aug 2024 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724157068; cv=none; b=uGBWOaO4gqTMVg5zFE+hPBH0rihvoTxUmb13Qha4SeVu6TGCZaXTFYB9A4tcfw7+YYj+KqZSaL1yfjZHIeDqvJXLGZsF5hQIhzC+U25rkaf0q7KGg7k2LzeIZfkg+Tljfp0+icmPu2nqa1i/+DRpEOZsmbiz36g+hhUq4S6kQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724157068; c=relaxed/simple;
	bh=VNGZm/Y9nzpHBaSJkE68s13lRIy0Yo2t9xKIN1haLdo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=gNnU8BXKWG+voAU6WLo+CvbkrXSCJGFxKPjTjYV/XUl+vd/GkreYXJijyofTtm5VVLzFIxcmcFkOlkPuRezjfVHxewfJZA1zUnyh2hsu1h/+zj8fBsIgHYsNeB2T+YqZ55IZEgVjqqUOv5YH2P/FUQGL0os8CWupsmFjhIdjIcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=U2AfiCQR; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724157061; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=ZrT+fy9lw+TuSgvQ4oTTpgJLrT891hS+06O54T6VFP8=;
	b=U2AfiCQR7/QTKOTy3U1LVdZiNDmyriMrQGRG/VSYlgEosvrEsdSWKZbXsSktlXT7YtN5xI1q2NCwn8NzqPAvfVCJ+BUvpRK7X0oaVRDP33DY4/Q0k7sYyiWtefzFDpyiiNKIR5JmwMJAhnOTj2vlb4APUWUqBRdEW4ZQyrmXFy4=
Received: from 30.221.128.114(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WDId3QU_1724157060)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 20:31:01 +0800
Message-ID: <6e239bb7-b7f9-4a40-bd1d-a522d4b9529c@linux.alibaba.com>
Date: Tue, 20 Aug 2024 20:31:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Philo Lu <lulie@linux.alibaba.com>
Subject: Question: Move BPF_SK_LOOKUP ahead of connected UDP sk lookup?
To: bpf <bpf@vger.kernel.org>
Cc: netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, jakub@cloudflare.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all, I wonder if it is feasible to move BPF_SK_LOOKUP ahead of 
connected UDP sk lookup?

That is something like:
(i.e., move connected udp socket lookup behind bpf sk lookup prog)
```
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ddb86baaea6c8..9a1408775bcb1 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -493,13 +493,6 @@ struct sock *__udp4_lib_lookup(const struct net 
*net, __be32 saddr,
         slot2 = hash2 & udptable->mask;
         hslot2 = &udptable->hash2[slot2];

-       /* Lookup connected or non-wildcard socket */
-       result = udp4_lib_lookup2(net, saddr, sport,
-                                 daddr, hnum, dif, sdif,
-                                 hslot2, skb);
-       if (!IS_ERR_OR_NULL(result) && result->sk_state == TCP_ESTABLISHED)
-               goto done;
-
         /* Lookup redirect from BPF */
         if (static_branch_unlikely(&bpf_sk_lookup_enabled) &&
             udptable == net->ipv4.udp_table) {
@@ -512,6 +505,13 @@ struct sock *__udp4_lib_lookup(const struct net 
*net, __be32 saddr,
                 }
         }

+       /* Lookup connected or non-wildcard socket */
+       result = udp4_lib_lookup2(net, saddr, sport,
+                                 daddr, hnum, dif, sdif,
+                                 hslot2, skb);
+       if (!IS_ERR_OR_NULL(result) && result->sk_state == TCP_ESTABLISHED)
+               goto done;
+
         /* Got non-wildcard socket or error on first lookup */
         if (result)
                 goto done;
```

This will be useful, e.g., if there are many concurrent udp sockets of a 
same ip:port, where udp4_lib_lookup2() may induce high softirq overhead, 
because it computes score for all sockets of the ip:port. With bpf 
sk_lookup prog, we can implement 4-tuple hash for udp socket lookup to 
solve the problem (if bpf prog runs before udp4_lib_lookup2).

Currently, in udp, bpf sk lookup runs after connected socket lookup. 
IIUC, this is because the early version of SK_LOOKUP[0] modified 
local_ip/local_port to redirect socket. This may interact wrongly with 
udp lookup because udp uses score to select socket, and setting 
local_ip/local_port cannot guarantee the result socket selected. 
However, now we get socket directly from map in bpf sk_lookup prog, so 
the above problem no longer exists.

So is there any other problem on it？Or I'll try to work on it and commit 
patches later.

[0]https://lore.kernel.org/bpf/20190618130050.8344-1-jakub@cloudflare.com/

Thank you for your time.
-- 
Philo


