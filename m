Return-Path: <bpf+bounces-58011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D57D4AB3908
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 15:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04F1460D89
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 13:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A52295D8A;
	Mon, 12 May 2025 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vAK4o9wV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U9Lx9qat"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07042951AF
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056420; cv=none; b=AdbwK/PAC/IfqaXuONcmuSt9nDWgg9dKSHUSX7U7L3xyjgK4QFkdWe/JDBJfGMbfboxcNIHwvzqDge32YBqJTBeDCetxUh09kjOFp5dVT4pxjqdzgZ76oC3ztNsTI50Sp4BeJfl5OFQgPVQc4cEAHO0p09bOuVV568Cqtdx+58I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056420; c=relaxed/simple;
	bh=qJ+ESp6yzKSAEhjlZAkvoiJgX7BR2ezH0omRAGox/T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVXiE6gSgYrGOQ727EN9R8No/W85rAlgYyEJ1aLqpXT6z9pqEIlLOSrlaeyzpwEYx4QkOW3tRqWMORwPvQyO9K+O3TxPnkwTdfqMXv3h6ow600Bov86KsapzHJBCkvfb/LxI8iRS0eQBwJmC5vNTfYg9Jlz9e4LtfvBQ3HZhUZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vAK4o9wV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U9Lx9qat; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 May 2025 15:26:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747056416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ESouIH1VzX3pFWx0h3EYHpp3AVWU6u5q17izZyAGV8=;
	b=vAK4o9wVl+t8yLmoRRPtXaYkjV6oE+0Hue7nXgoJ0+x402EIU9oH5QPfrhQTYGFa0+K0hs
	4Pqf4Kr74O/Mp8Uc1aOmehGDdnYqrbr/w1ELZFDO183GdWx4u4BbXn1ofu2/nRB0fpfF3c
	eSWg9zyXHTaxFLb03r1Db1wMByRzOmL1V6sPRr5tn8ZKmz5Do5b69HK1r/KivSXOloomdD
	z5epWuVT6H+zyO9MNihvKIZZHFTVeSrQ2jS0/XaWriqfDPsSP2UqJvJ4x3CdZn2OAvxNE9
	Lp+6mEe/9WRo8Y6JT0Lx2kpENdADCn2bsD8h1okMQ+JSU6oLQjKQqPFvZomM6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747056416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ESouIH1VzX3pFWx0h3EYHpp3AVWU6u5q17izZyAGV8=;
	b=U9Lx9qat7BPqzbUApnc9bniQAXg+xAE6tp13x+xziAH1ABJVbN6FUjf0NKdJWfduSAHIWv
	StxE7tTZNKyl+bBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
	harry.yoo@oracle.com, shakeel.butt@linux.dev, mhocko@suse.com,
	andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
	peterz@infradead.org, rostedt@goodmis.org, hannes@cmpxchg.org,
	willy@infradead.org
Subject: Re: [PATCH 2/6] locking/local_lock: Expose dep_map in
 local_trylock_t.
Message-ID: <20250512132654.4MCqyeG6@linutronix.de>
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-3-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250501032718.65476-3-alexei.starovoitov@gmail.com>

On 2025-04-30 20:27:14 [-0700], Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> lockdep_is_held() macro assumes that "struct lockdep_map dep_map;"
> is a top level field of any lock that participates in LOCKDEP.
> Make it so for local_trylock_t.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/local_lock_internal.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lo=
ck_internal.h
> index bf2bf40d7b18..29df45f95843 100644
> --- a/include/linux/local_lock_internal.h
> +++ b/include/linux/local_lock_internal.h
> @@ -17,7 +17,10 @@ typedef struct {
> =20
>  /* local_trylock() and local_trylock_irqsave() only work with local_tryl=
ock_t */
>  typedef struct {
> -	local_lock_t	llock;
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	struct lockdep_map	dep_map;
> +	struct task_struct	*owner;
> +#endif
>  	u8		acquired;
>  } local_trylock_t;

So this trick should make it work. I am not sure it is worth it. It
would avoid the cast down the road=E2=80=A6

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock=
_internal.h
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -17,10 +17,17 @@ typedef struct {
=20
 /* local_trylock() and local_trylock_irqsave() only work with local_tryloc=
k_t */
 typedef struct {
+	union	{
+		local_lock_t		llock;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map	dep_map;
-	struct task_struct	*owner;
+# define LOCK_PAD_SIZE (offsetof(local_lock_t, dep_map))
+		struct {
+			u8 __padding[LOCK_PAD_SIZE];
+			struct lockdep_map	dep_map;
+		};
+#undef LOCK_PAD_SIZE
 #endif
+	};
 	u8		acquired;
 } local_trylock_t;
=20
@@ -34,7 +41,7 @@ typedef struct {
 	.owner =3D NULL,
=20
 # define LOCAL_TRYLOCK_DEBUG_INIT(lockname)		\
-	LOCAL_LOCK_DEBUG_INIT(lockname)
+	.llock	=3D { LOCAL_LOCK_DEBUG_INIT(llock.lockname) }
=20
 static inline void local_lock_acquire(local_lock_t *l)
 {


Sebastian

