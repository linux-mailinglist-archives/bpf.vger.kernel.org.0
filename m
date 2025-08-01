Return-Path: <bpf+bounces-64928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3D5B18866
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 22:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0AA3AEADA
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 20:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235D928CF6D;
	Fri,  1 Aug 2025 20:55:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CA01A01C6;
	Fri,  1 Aug 2025 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754081746; cv=none; b=rqEp8MEHTNg9mvefd1QcQKjkejGvlg6EpBcW9s613paSRqb+3B8e17R8RrRANV082YpqaIwu3mp3Vn4VMG9a/kxNr0dMoCwudPYr1tFyqWgIjK5DcAeqyyPXMloax50YyB9aPKt6h3cPJKRjEavSfAKvZGt670y3HOf123Tmg8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754081746; c=relaxed/simple;
	bh=YKoSvIfIZ7AfnVI0xRJuSnbZ0NUlNJsWfV+lTb4X1ME=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=RtCiv1M8Jq3E2f3wdjNUZ7SO12G3El1VhJ5ozsqJhIGF1lS46B/y4w9M4ydR1M6/5+Jd550h4oSHeFbX7uT3eIBO9ihooQsuPzexxmhosUqG11Vf4wiUNFpk0tOu6vqA5b2304jHoYaqs9aTS7b+Uw3JSMPr6YgYq0RwKcyg25U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 52F62C02E9;
	Fri,  1 Aug 2025 20:55:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 455F82000F;
	Fri,  1 Aug 2025 20:55:40 +0000 (UTC)
Date: Fri, 1 Aug 2025 16:56:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, bpf@vger.kernel.org, Douglas Raillard 
 <douglas.raillard@arm.com>, Yonghong Song <yonghong.song@linux.dev>, Martin
 KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH v3] tracing: Have unsigned int function args displayed as
 hexadecimal
Message-ID: <20250801165601.7770d65c@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 455F82000F
X-Stat-Signature: 4rgkmjttq7tus4ozhrsxm3tdjtfistk7
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+toM6PJ9IUUVVrvcyW7KbjTmf3peylLOQ=
X-HE-Tag: 1754081740-584668
X-HE-Meta: U2FsdGVkX19Fm/hcv1qlHgsYskUR6qWw97KTHYFsmgwN52SRvUQc5kPI93X08cMuGbEtEF+3ByRMMXt7Nxc/YgO6of4iMd4wFR5zdfCqzAsmm34El8qxMZfVdJ/GCdGl5cvQkAf285LnVZFTiQDpoTqdl961kG1YXBR1gSezBFe8zfUOrct9E/LLqRxkolXa30B9axNSwGDNJPD6r40GEyvOgs88jMP2zfuRnrHp8GE+eG4clHZMvhPADo9chazNxv6hXEaUQZe6tw3UaKeGiJzbldaxRlu6TFxJ5X7rYji6+1EJPANmi9aRqUTPh/6x7K9KokdNNnIQVM0H8pDNguJ5ZCm+i32Z8WYUQ0tmJ3jwJygQV34jNV+fONAp3j/kDpb3imCWbvvTPsQ8UhfMgQ==

=46rom aff4ac7a3e0bc7e7db72a0fae52f1a8b06e415f0 Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Fri, 1 Aug 2025 11:14:53 -0400
Subject: [PATCH] tracing: Have unsigned int function args displayed as
 hexadecimal

Most function arguments that are passed in as unsigned int or unsigned
long are better displayed as hexadecimal than normal integer. For example,
the functions:

static void __create_object(unsigned long ptr, size_t size,
				int min_count, gfp_t gfp, unsigned int objflags);

static bool stack_access_ok(struct unwind_state *state, unsigned long _addr,
			    size_t len);

void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);

Show up in the trace as:

    __create_object(ptr=3D-131387050520576, size=3D4096, min_count=3D1, gfp=
=3D3264, objflags=3D0) <-kmem_cache_alloc_noprof
    stack_access_ok(state=3D0xffffc9000233fc98, _addr=3D-60473102566256, le=
n=3D8) <-unwind_next_frame
    __local_bh_disable_ip(ip=3D-2127311112, cnt=3D256) <-handle_softirqs

Instead, by displaying unsigned as hexadecimal, they look more like this:

    __create_object(ptr=3D0xffff8881028d2080, size=3D0x280, min_count=3D1, =
gfp=3D0x82820, objflags=3D0x0) <-kmem_cache_alloc_node_noprof
    stack_access_ok(state=3D0xffffc90000003938, _addr=3D0xffffc90000003930,=
 len=3D0x8) <-unwind_next_frame
    __local_bh_disable_ip(ip=3D0xffffffff8133cef8, cnt=3D0x100) <-handle_so=
ftirqs

Which is much easier to understand as most unsigned longs are usually just
pointers. Even the "unsigned int cnt" in __local_bh_disable_ip() looks
better as hexadecimal as a lot of flags are passed as unsigned.

Changes since v2: https://lore.kernel.org/20250801111453.01502861@gandalf.l=
ocal.home

- Use btf_int_encoding() instead of open coding it (Martin KaFai Lau)

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 0b3db02030a7..97db0b0ccf3e 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -701,6 +701,7 @@ void print_function_args(struct trace_seq *s, unsigned =
long *args,
 	struct btf *btf;
 	s32 tid, nr =3D 0;
 	int a, p, x;
+	u16 encode;
=20
 	trace_seq_printf(s, "(");
=20
@@ -744,7 +745,12 @@ void print_function_args(struct trace_seq *s, unsigned=
 long *args,
 			trace_seq_printf(s, "0x%lx", arg);
 			break;
 		case BTF_KIND_INT:
-			trace_seq_printf(s, "%ld", arg);
+			encode =3D btf_int_encoding(t);
+			/* Print unsigned ints as hex */
+			if (encode & BTF_INT_SIGNED)
+				trace_seq_printf(s, "%ld", arg);
+			else
+				trace_seq_printf(s, "0x%lx", arg);
 			break;
 		case BTF_KIND_ENUM:
 			trace_seq_printf(s, "%ld", arg);
--=20
2.47.2


