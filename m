Return-Path: <bpf+bounces-55884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF11FA8887D
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 18:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D397B167FD2
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 16:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C30284675;
	Mon, 14 Apr 2025 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="INWn65hJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I7pBzCM8"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408E627F73B;
	Mon, 14 Apr 2025 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647684; cv=none; b=OW+kflmsTiWv1gZI10/IIU5D1ljqXEwEHxVZWR/mftU2/WXKQbGqE5upTtfU6tKC1LFwCiNw3eL5FdKZh/URwhc/YlWe5eyOqaq2Hr0cHbSRAi6fwuxkgEsujy0Jn6DfwzNKAWP4IWSB4s70b5QvOKnPbFf1ltqR+4mFhR8gaYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647684; c=relaxed/simple;
	bh=qRF+pfwYj6kETHQRodo3O/1RpBYbS5HpUN20HQPLn78=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GpgkA7obgKZ8gFjV+BwPTvt/ifEm03liLZNuRD9cpDcDpoVWsvYFo7G+wf/d/Fv5cDMMcQBAQFm313jyAqAD2Xzbbrwm8HRaNzHi/C09IKAzI8zYlqrLEdaNg2lgLaUKM2TTODcL5KQVeW1wf5kcYejj8b1zLemEUotHysfkn/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=INWn65hJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I7pBzCM8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 18:21:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744647681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s5XmoymLjfpV+yjct381cZITXuVhuoSqQggfPGZ/6EA=;
	b=INWn65hJIypRHFv4doRTwj/lJ0oA/T/caDKhQWHhr2y0GsAKIeR95NmatAHqklKrXP8E3o
	e1IAGdn3LInnzHDYSk90Hsfc8UP+bIdf/BPr552/hX0w60r7kM/2+UtLse6sCBoJVht5KD
	Llw7KAtuw9AItRO0qLKFqutv7RXkJYXU1BrcaA4WxIiEYFm+ep8QJAUVWXxNDNEtg2cHjR
	POFcyeaSbvbuNg8Ce/NULIKYNkD7l+GSRn38WKkGKxKkuwjeFhv2NUQl7gUhvXch+lMgpj
	3J5XM9nXtTbCJwtmoGWYWNfH9UtZoUwE2VWbGqB5Vdh3oAmJxMDzb6uPWe3Y0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744647681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s5XmoymLjfpV+yjct381cZITXuVhuoSqQggfPGZ/6EA=;
	b=I7pBzCM8/RuiD0W5wNL+1VdJ+299PeNdQfc3FdiNaMEEoOjYfyHOEsxGK0hRoaEQ0sfyAa
	evg/FkLuns7/D0CA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: stable@vger.kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
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
Subject: [PATCH stable] xdp: Reset bpf_redirect_info before running a xdp's
 BPF prog.
Message-ID: <20250414162120.U-UFSLv8@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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

I discussed this with Toke, thread starts at
	https://lore.kernel.org/all/20250313183911.SPAmGLyw@linutronix.de/

The commit, which this by accident, is part of v6.11-rc1.
I added the commit introducing map redirects as the origin of the
problem which is v4.14-rc1. The code is a bit different there but it
seems to work similar.
Affected kernels would be from v4.14 to v6.10.

 include/net/xdp.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index de08c8e0d1348..b39ac83618a55 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -486,7 +486,14 @@ static __always_inline u32 bpf_prog_run_xdp(const stru=
ct bpf_prog *prog,
 	 * under local_bh_disable(), which provides the needed RCU protection
 	 * for accessing map entries.
 	 */
-	u32 act =3D __bpf_prog_run(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
+	struct bpf_redirect_info *ri =3D this_cpu_ptr(&bpf_redirect_info);
+	u32 act;
+
+	if (ri->map_id || ri->map_type) {
+		ri->map_id =3D 0;
+		ri->map_type =3D BPF_MAP_TYPE_UNSPEC;
+	}
+	act =3D __bpf_prog_run(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
=20
 	if (static_branch_unlikely(&bpf_master_redirect_enabled_key)) {
 		if (act =3D=3D XDP_TX && netif_is_bond_slave(xdp->rxq->dev))
--=20
2.49.0


