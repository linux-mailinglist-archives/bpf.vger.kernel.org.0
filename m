Return-Path: <bpf+bounces-56602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18309A9AE5D
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 15:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B9D7A65AA
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 13:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9955927FD53;
	Thu, 24 Apr 2025 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xeXzT0Bq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LH2yWFUy"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FE727F755;
	Thu, 24 Apr 2025 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499850; cv=none; b=fmYyIJPZudAfwQY/6MW99CisnoK0Pgr9qO9ZUP2NEBiIs98X9KdlBe+X+DaG5QfiAQINT+33xGuODAFCcgOQ0ZRYUbquKrkilwkDGM4BOzpzPwPXGj/AdwVyU7wxVJwKDDmVVY8P2HXbBnFvb+FY4zMF9/JzooL015JpfISFW64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499850; c=relaxed/simple;
	bh=drF2vzm9wcYfPdR0vfKGjWsPx0rqOEfX6MeVFhWdasU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLW9iKvBJi0mCv64+CKLXLYJDs7K9IhVMJtXhMpjxfshWjtAV+vwCrc6LPJuTWvlSNdAUhx2ICC2oeQpvoSWYb07v2rKHZ6eBBMlt8EKw4NIlrAGVL3+rmMI4PeTfYrfwqS1hyHF6Dx/uFei0uD5Opd3sbmiugY3rz5Pfi6Gt0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xeXzT0Bq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LH2yWFUy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 24 Apr 2025 15:04:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745499846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xt1SVfhG/duIUXQQDAMcUQEfArjPXwXCRLURGs5zZX0=;
	b=xeXzT0BqmOPqSunHq1Amc/7V5txefJTzrqI5cRSa2eceSjSo6OX1s9zj8NYACkvlK9oI66
	PSvOSQXBqyxq5B+8zXKCNdFu8Ho74Z8+HDss/DrY7BIn+AI8ieLMPP/0JH6XiueSlbVWA7
	gE6/B5AAR14EDy7z0Bv4+hj//6oVRqVepfTcL1pTn9eDy95tVOjyWIr2pvRFkBp8KyyIcS
	BRtlj3G4DAxzhGrLSGLUjlY83+Le7YglPlwcYNyHfU4h3Q5piRyYgLB4UP6HsufBuIiLMa
	M9Z6lUL5Jnsi9+OzSgLZ0LL+LmWfa1pwz4WS1eBoso8dg1UBumnWk/DSxw9N1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745499846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xt1SVfhG/duIUXQQDAMcUQEfArjPXwXCRLURGs5zZX0=;
	b=LH2yWFUyXBr77zNPV/OV8NFcoH30GdtPZ+Mq2pqicc52UgOtw08bDZ2js4OckYJ4VOi3Y5
	4iWmmTkQ0J7mZvDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
Subject: [PATCH stable v5.10] xdp: Reset bpf_redirect_info before running a
 xdp's BPF prog.
Message-ID: <20250424130405.xenRxobI@linutronix.de>
References: <20250414162120.U-UFSLv8@linutronix.de>
 <2025042223-departed-aids-add9@gregkh>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2025042223-departed-aids-add9@gregkh>

Ricardo reported a KASAN discovered use after free in v6.6-stable.

The syzbot starts a BPF program via xdp_test_run_batch() which assigns
ri->tgt_value via dev_hash_map_redirect() and the return code isn't
XDP_REDIRECT it looks like nonsense. So the output in
bpf_warn_invalid_xdp_action() appears once.
Then the TUN driver runs another BPF program (on the same CPU) which
returns XDP_REDIRECT without setting ri->tgt_value first. It invokes
bpf_trace_printk() to print four characters and obtain the required
return value. This is enough to get xdp_do_redirect() invoked which
then accesses the pointer in tgt_value which might have been already
deallocated.

This problem does not affect upstream because since commit
	401cb7dae8130 ("net: Reference bpf_redirect_info via task_struct on PREEMP=
T_RT.")

the per-CPU variable is referenced via task's task_struct and exists on
the stack during NAPI callback. Therefore it is cleared once before the
first invocation and remains valid within the RCU section of the NAPI
callback.

Instead of performing the huge backport of the commit (plus its fix ups)
here is an alternative version which only resets the variable in
question prior invoking the BPF program.

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>
Reported-by: Ricardo Ca=C3=B1uelo Navarro <rcn@igalia.com>
Closes: https://lore.kernel.org/all/20250226-20250204-kasan-slab-use-after-=
free-read-in-dev_map_enqueue__submit-v3-0-360efec441ba@igalia.com/
Fixes: 97f91a7cf04ff ("bpf: add bpf_redirect_map helper routine")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
backport: moved to filter.h, replaced map_id and map_type with map

 include/linux/filter.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 840b2a05c1b9f..e3aca0dc7d9c6 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -758,6 +758,10 @@ static __always_inline u32 bpf_prog_run_xdp(const stru=
ct bpf_prog *prog,
 	 * already takes rcu_read_lock() when fetching the program, so
 	 * it's not necessary here anymore.
 	 */
+	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+
+	if (ri->map)
+		ri->map =3D NULL;
 	return __BPF_PROG_RUN(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
 }
=20
--=20
2.49.0


