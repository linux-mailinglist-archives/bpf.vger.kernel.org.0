Return-Path: <bpf+bounces-54193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CD8A65164
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 14:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892CB1885061
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 13:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1137823ED6C;
	Mon, 17 Mar 2025 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vh7Tdpq3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eSPwY0xJ"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CA3233D85;
	Mon, 17 Mar 2025 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218698; cv=none; b=bn34h/vvAZxyqrpUtgQPqxc76UNTvbz4BcgR2zf7L0s2i/y4FJjmBF3X+mMpv4D+h1IA53vc9fdaysJAOBtgSJXyzJ3K7qcclL4+AbI/IGHjI6YNgwbNk8sDttAWyyW2aeuRCt7STY6P1qcSMxafIBjcRDwZ0ZWloep3ejT5JqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218698; c=relaxed/simple;
	bh=e2io7ptcxFmW5Qs9opGBcmI7o/vPG4j3jsWs2RY9WNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PxBC8WwOG/aXiSHl1BQ8rJnUSXzqI8W4lp6al4TOmAOfY06Bx+F7l2RRxULv2Sua8DL9JsIpvEP/Bgbr9QHwcX6SkzuRUeYm95IJs06fi5pWxQInzUzJN6nkH4juL3euNsCKikT542iyyD4a7VG8c/6eNEzJwRsUm7ZrLV4xplI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vh7Tdpq3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eSPwY0xJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 14:38:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742218695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9mYhKCKkQeh1xoUUrBNONZMgksp7fouadlY++sz6VII=;
	b=vh7Tdpq3LF2SENd45P4mHeEemLVrbJO3jZwRU5g+6rfpj7UfKsNJ1KHiYepNg6MgmG4GWV
	4ADtIZzdbIGOSyOyN847YKo62/T16228Z7P6qgBi1mzanhzzYUTlHxFcjQ2qa8HwHl6/2b
	4v95vygFRrpodZFuUyS22jRYv8KCyOhiDOSUy72+mTyL7E+Z9bWfqb4JX5Dp6moyOtvX7R
	2KLv6tV85pGyHJgf0pG4hrLSvATZ/H5+X7Q38BLllJH6S/HamMUgVdWiSwMp7Q46Be0ZqO
	mSpdGQbBgyHo+GwGSRqVv8wRBgS6G3BUAsc7jc3PZ9szqaT+u4q/0h3vyfxorQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742218695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9mYhKCKkQeh1xoUUrBNONZMgksp7fouadlY++sz6VII=;
	b=eSPwY0xJHP75CCWVgIVOqdwFfGzcA3WHypDMp4vDPqurwv4hmpJxBpnm00P6VEOazDRO4Q
	y5/sisJAvxmuxDDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
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
Message-ID: <20250317133813.OwHVKUKe@linutronix.de>
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
problem which is v4.14-rc1. The code is a bit different there it seems
to work similar.

Greg, feel free to decide if this is worth a CVE.

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

