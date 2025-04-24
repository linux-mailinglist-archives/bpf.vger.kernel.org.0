Return-Path: <bpf+bounces-56603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F43A9AE81
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 15:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8802E1B81827
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 13:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95402820B6;
	Thu, 24 Apr 2025 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hpEgylZT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ls3SMCCc"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8F327CB1F;
	Thu, 24 Apr 2025 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499933; cv=none; b=rjpiE6r/ySlekDwUrk3nOstT+U2kMFJTv2pXyLqhXxnTqj7jvTk4QiGVh0Cxuryinm1paUNvWmmFYOTzT7M0VjTRr2W6wBvHEW73xJZBY5S5vRS0h1o2gQpVTAvQTiZzgDhcJsCN1ynnmFAg0mZdGYiW8y2tycrGTYpovrZj5Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499933; c=relaxed/simple;
	bh=JW+B9orkrkPq3ZxeeYF3Job/w/Xzm9zim/HEsbvADVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvhGxEMI21jcu1Cut3FlmPjaZdtarEJDKL0QdRE/NLJqcGxGGFb1CXxnerPBohouU/jofaleL1/RTYijDgl77zRzGobrhqmePz3/waLQ83vBs4JZqVZ6NmODl7gb9ZNBYljN13aFFTkPgyAKsPNjLN403e1vJa7lWcXegqytEvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hpEgylZT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ls3SMCCc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 24 Apr 2025 15:05:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745499929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TI9W1W5y1kgt0mckRA0mlz2D453GZ7Cs5k0nlq9/3o=;
	b=hpEgylZTj+yM6okV0vpry1YsAcPYHsqcqzLItcGgstT4NA0IrXAfpIDSDB3Zukvl7Tcgav
	jBMkIBt+CVIJqSntdcQe00Lidf/FbRjF/aLNVNNYUMz/r0xwSzJ6bN+0QZVMQvyAW2YB2h
	n7JDbbsoX1yU6cCjp35xxO+KJPzoI/TZro5q8bBzw6OSDnIWPU7yMWZ0M3wu7O0ktiD7DF
	rXeNVzMJppDeC8Zyglx7ZGuKJrjK0LPx1wYVD1/8/SXHPyUkrXC4vCnczd/1+4XetOLQJ2
	Yfw0gmBYMRanX10D4F2d077PKg/vlCCM8jWchZG3a2DbNylc19CelPH+BLo4Zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745499929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TI9W1W5y1kgt0mckRA0mlz2D453GZ7Cs5k0nlq9/3o=;
	b=Ls3SMCCcqY9X9ARMVpflAaQhzE4KHN9ctiCjZ3A1Xd5R04r8pXED15CdPYDCxy0qCgLb+J
	Ga2TlRkvg/qBbXBQ==
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
Subject: [PATCH stable v5.4] xdp: Reset bpf_redirect_info before running a
 xdp's BPF prog.
Message-ID: <20250424130528._4Gap8TB@linutronix.de>
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
index 0bec300b2e516..502b02f531d3f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -721,6 +721,10 @@ static __always_inline u32 bpf_prog_run_xdp(const stru=
ct bpf_prog *prog,
 	 * already takes rcu_read_lock() when fetching the program, so
 	 * it's not necessary here anymore.
 	 */
+	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+
+	if (ri->map)
+		ri->map =3D NULL;
 	return BPF_PROG_RUN(prog, xdp);
 }
=20
--=20
2.49.0


