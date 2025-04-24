Return-Path: <bpf+bounces-56601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C098A9AE5F
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 15:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67B871B80941
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 13:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38635284B4C;
	Thu, 24 Apr 2025 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="etTn8cU0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oYsGUKUR"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A99284667;
	Thu, 24 Apr 2025 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499799; cv=none; b=MOrHZZ8KoTPNhhnGyHhP79I3ht4GHsM057yVnmge/oYj68DrzqRt0eQAd8hj5Verf8K5eyEcDtP/9aDpLz2f6ptkj2P5WCsHWh8po/pwKpkUlB6X/oB5ftGzQ3b65Qv3NbWAkO6VcoO3FhWU+rtLVDuSfqpd53avLETmtVTt0Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499799; c=relaxed/simple;
	bh=+jxdHN9w6058fmKwsIbAeD1FE5biFmWbN0xy0yZYaKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpBCPpGZnqm4/hjlQUY8KuyHrK+j4/hahDtZfTQRChJRcCE4Up/V9DSYt8DoJd11c8kYNHPPSLwj3k7Nx7WvOpLw44VNkFBBnYqPrDiVS0sJGmDQsCj0E1WhEi4TcW8dqX9sVjKgb5BPrMFKhuUN8D3eHmU2CWJlNcfdtRmCUg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=etTn8cU0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oYsGUKUR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 24 Apr 2025 15:03:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745499796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BqK7PllKhCIzrgYgkhlhTeeMaCbSdmEmMtce1oOfVcE=;
	b=etTn8cU0pXTwMIbc6N0lS1VOiHDVydPDuaSgWUq6awaGiNO/yl7Pw5ulB8wmyfUImk52+1
	CTBEGy98oJ96NDnuTo6TgZHAx/rF3KxZsHP/hUlGFGpn7Cz6pS1fPneKaLNwXANSoZW69l
	4EHIQyoeh+4wWENg4k/d0exsFqU6nINR8pcIK9MDFpGS6KjPcHXCCf3Flp0VEA3To0syAX
	4HXWq7LZ2qTRNjkoBKP3FXVp+n8SQ0q21aaOZFPwP2RJUvM0Ol1ep2SBB7suw5coUTTBgM
	AoTNkpOlfu/nxqQ7Ex8EJeaF6hRL6/VBqWcE22Ld0MyfQsLkv7dBZF5LjGKjLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745499796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BqK7PllKhCIzrgYgkhlhTeeMaCbSdmEmMtce1oOfVcE=;
	b=oYsGUKURg1lz0s5P+B+D2mqt24fc4sIA1ugmvZLeeeC0BpVOdrxJ09HhsVcQMqa++oGx3e
	S6tkw7DKDRPzksBw==
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
Subject: [PATCH stable v6.1 v5.15] xdp: Reset bpf_redirect_info before
 running a xdp's BPF prog.
Message-ID: <20250424130314.C9jOS1c5@linutronix.de>
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
backport: function moved to filter.h from xdp.h

 include/linux/filter.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 01f97956572ce..f3ef1a8965bb2 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -775,7 +775,14 @@ static __always_inline u32 bpf_prog_run_xdp(const stru=
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


