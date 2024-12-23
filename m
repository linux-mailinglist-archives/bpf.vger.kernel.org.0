Return-Path: <bpf+bounces-47568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7093D9FB766
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 23:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9653F1884EC0
	for <lists+bpf@lfdr.de>; Mon, 23 Dec 2024 22:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E8A1CDA04;
	Mon, 23 Dec 2024 22:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Chh+nUs5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AE81A8F9A
	for <bpf@vger.kernel.org>; Mon, 23 Dec 2024 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734994685; cv=none; b=nZ56CSyACKkETbwAIxIxeCIu5JoxxGHyDTLlylKkrm7PgUTaQ8uviC1xPEep6hwjH2C6b4/jBzDxJXm7EMehQ2uQHrCNv1MM2LYG0qh2ehsEUthLwzJFvgk3jRh/p0353CivCwox7E3zb9Kh32WYF0MN05ikLu8kCopVUj9va/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734994685; c=relaxed/simple;
	bh=sAZ0YUjc6jamRKbpGciKU8X+GJNwFarDllWNuBPDxFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F2l/HoSD7CCnIc93vViq7xwzY6FZVRnQvPe24Swx2ZOxswxx4OpNSzxvft4MIPDLZvKxWB62yL2T4+KLXQztQtIkYrXPhYJjcNWXKKQcsevwY5a1neLJg9Ue/NqW+VXY494pjzYXtzusC8Olc4VPX21EeVFEDkJTqacpu9Vtv+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Chh+nUs5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aab9e281bc0so844030466b.3
        for <bpf@vger.kernel.org>; Mon, 23 Dec 2024 14:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1734994682; x=1735599482; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/HlRGNK6BDpk8IKLQRCM0aiZ8YKbDBCcvDCdCiTV2KI=;
        b=Chh+nUs5lTiKpcVM26SazndfVbJFaLfbw6tvh4/VrVDTSNKNJgW8/RsnpgVClteLwg
         4IJ18tvUPbBV7woGwtLjFRYLelaE7DqiR1rhxBIR+BfsEvtwQYIu6TEOWhDcw52rKZ8C
         XRvK1rxk1xEHcOBTEC9GxJLEFsOfeP09yO1n5StnynB7thwFsd+pYIGPRSn4d915R7Pf
         jOe3eqqLLEjQl5UIbB561Esj6j28OM65WenbFs2s3GeFswjBgkhZt7X01ba84NYmqXJz
         tg3EFK1bW+U9ebTAS5azKzTOKcBpVa2Jjpwyp+1FedvFJfkKz7cuVolkubIQOA2SX96p
         v6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734994682; x=1735599482;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HlRGNK6BDpk8IKLQRCM0aiZ8YKbDBCcvDCdCiTV2KI=;
        b=xTYq8OdPeS7j8HagbWltYYR7mrhSlb5mcMre9UViVdm6n41Ldj/7vE3rSqfNV+jFJd
         iCHPrcjxh8fdaIjpfIOWcPDnScaDFYYSnCCAIZABBhZacf8dVy/kdCdgP/azjsjVlz6W
         lQLFEmuYD9UaB4KsztmS0Md7NXEyNXseU9SfWeZrca1gEvMozlnnAWdlGlBb/rZyqdnH
         X3MoXB68Vzb2k4vrdg6/uYJCZwVMCmLpkVH1UJwkb1nUwlCDk9RPoQKzTMkB2V9rvx7o
         kKLXIN+/rOZ5p0GC23G3BhJ2wovKF1B+nMKcSYZ3ETwG+QG0clKguo7MGwabnWKpJtOf
         5U3g==
X-Gm-Message-State: AOJu0YzwMnc6Vfwr2KpaIhqymU7IqZKIZcIqaVVNLvyR4iWI2TdN+4to
	EuNoq7L8kq1B/YiS7ZLdt7chLsAoqMUcBZk/ZsJjPVVP843j1G/JMfbMBo3qIgY=
X-Gm-Gg: ASbGncs5BMkKRw+9wSOJPRVESsVItNai5ssIJn5RvfLHmwdre0vkR+Le3OUWLpZGpgx
	x0Hg0C1MUNBmpWagOGxEE69GRa6QwGjgW0blNL3ZOthEu5q9ADHESL/EwlVyRhQoEw2DsdwB7OI
	hpuxwf61B7gwH3Z/vWODAN/zU4sNNRfrfmwUtJyzAk5489QKs5f0u5hHRAMKUU8m5sePc0stued
	tfEbAZItHtBH8T/7CWWgkAauULCexgDqozTqkV99JMoeMw=
X-Google-Smtp-Source: AGHT+IECMDkX8joJ+AoQR4H0jC/t5FET6mb6m6+PGZeH6KaDhpTjbvZj8dwgFdrJZ3DzsotdphlQAA==
X-Received: by 2002:a17:907:6e92:b0:aa5:b1b9:5d6a with SMTP id a640c23a62f3a-aac336592f2mr1150654966b.54.1734994681696;
        Mon, 23 Dec 2024 14:58:01 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:507b:2dc::49:e4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f0170f6sm568114066b.167.2024.12.23.14.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 14:57:59 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>, John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org,  martin.lau@linux.dev,  ast@kernel.org,
  edumazet@google.com,  davem@davemloft.net,  dsahern@kernel.org,
  kuba@kernel.org,  pabeni@redhat.com,  linux-kernel@vger.kernel.org,
  song@kernel.org,  andrii@kernel.org,  mhal@rbox.co,
  yonghong.song@linux.dev,  daniel@iogearbox.net,
  xiyou.wangcong@gmail.com,  horms@kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf: fix wrong copied_seq calculation
In-Reply-To: <87h66ujex9.fsf@cloudflare.com> (Jakub Sitnicki's message of
	"Mon, 23 Dec 2024 21:57:22 +0100")
References: <20241218053408.437295-1-mrpre@163.com>
	<20241218053408.437295-2-mrpre@163.com>
	<87jzbxvw9y.fsf@cloudflare.com>
	<ojwjcubviyjxpucryc3ypi4b77h5f5g6ouv7ovaljah5harfyj@jue7hqit2t5n>
	<87h66ujex9.fsf@cloudflare.com>
Date: Mon, 23 Dec 2024 23:57:58 +0100
Message-ID: <87msgmuhvt.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Dec 23, 2024 at 09:57 PM +01, Jakub Sitnicki wrote:
> On Thu, Dec 19, 2024 at 05:30 PM +08, Jiayuan Chen wrote:
>> Currently, not all modules using strparser have issues with
>> copied_seq miscalculation. The issue exists mainly with
>> bpf::sockmap + strparser because bpf::sockmap implements a
>> proprietary read interface for user-land: tcp_bpf_recvmsg_parser().
>>
>> Both this and strp_recv->tcp_read_sock update copied_seq, leading
>> to errors.
>>
>> This is why I rewrote the tcp_read_sock() interface specifically for
>> bpf::sockmap.
>
> All right. Looks like reusing read_skb is not going to pan out.
>
> But I think we should not give up just yet. It's easy to add new code.
>
> We can try to break up and parametrize tcp_read_sock - if other
> maintainers are not against it. Does something like this work for you?
>
>   https://github.com/jsitnicki/linux/commits/review/stp-copied_seq/idea-2/

Actually it reads better if we just add early bailout to tcp_read_sock:

  https://github.com/jsitnicki/linux/commits/review/stp-copied_seq/idea-2.1/

---8<---
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 6a07d98017f7..6564ea3b6cd4 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1565,12 +1565,13 @@ EXPORT_SYMBOL(tcp_recv_skb);
  *	  or for 'peeking' the socket using this routine
  *	  (although both would be easy to implement).
  */
-int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
-		  sk_read_actor_t recv_actor)
+static inline int __tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+				  sk_read_actor_t recv_actor, bool noack,
+				  u32 *copied_seq)
 {
 	struct sk_buff *skb;
 	struct tcp_sock *tp = tcp_sk(sk);
-	u32 seq = tp->copied_seq;
+	u32 seq = *copied_seq;
 	u32 offset;
 	int copied = 0;
 
@@ -1624,9 +1625,12 @@ int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		tcp_eat_recv_skb(sk, skb);
 		if (!desc->count)
 			break;
-		WRITE_ONCE(tp->copied_seq, seq);
+		WRITE_ONCE(*copied_seq, seq);
 	}
-	WRITE_ONCE(tp->copied_seq, seq);
+	WRITE_ONCE(*copied_seq, seq);
+
+	if (noack)
+		goto out;
 
 	tcp_rcv_space_adjust(sk);
 
@@ -1635,10 +1639,25 @@ int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 		tcp_recv_skb(sk, seq, &offset);
 		tcp_cleanup_rbuf(sk, copied);
 	}
+out:
 	return copied;
 }
+
+int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
+		  sk_read_actor_t recv_actor)
+{
+	return __tcp_read_sock(sk, desc, recv_actor, false,
+			       &tcp_sk(sk)->copied_seq);
+}
 EXPORT_SYMBOL(tcp_read_sock);
 
+int tcp_read_sock_noack(struct sock *sk, read_descriptor_t *desc,
+			sk_read_actor_t recv_actor, u32 *copied_seq)
+{
+	return __tcp_read_sock(sk, desc, recv_actor, true, copied_seq);
+}
+EXPORT_SYMBOL(tcp_read_sock_noack);
+
 int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 {
 	struct sk_buff *skb;

