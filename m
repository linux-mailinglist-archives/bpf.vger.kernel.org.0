Return-Path: <bpf+bounces-60370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 367E6AD5F8C
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 21:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F301BC2333
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 19:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2ED2BD5B4;
	Wed, 11 Jun 2025 19:56:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D027228853E;
	Wed, 11 Jun 2025 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749671789; cv=none; b=HZdaUxlgsbAhHPzuq1IFN30fXDubVhivpDAPhyYEnkL425I5LP6HTGgNSRhT7Px2U8csjhh4vOhufqvrnGzjaSk0sYa0d0mDOdFb6XrxeIGxRK7SjZNUZKnbA/ht4S/BcvUg7CnKfJm72VAkgywMkdi43rRBvBaC8YawIIhsZF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749671789; c=relaxed/simple;
	bh=Cu3nmlEkWuwjxDNV/0+pvJpDjndzyTJCZaXYdMngeh4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZrXULkYUwg47/3OM+UGzMHhbaCfhFfbz2p9JTVPHa18GtfvcsXkAsXW0nuhsvTUppVMZCMqvgvGovssOMBVdTAh2GWszAjU+MlnIfamblKxA82mXLk6XOJQjPzoSeHQuHtJom7mMtUoioPZbJR7R5Vsh3qGaM1tC3C0y2d1biSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 11AE0C153C;
	Wed, 11 Jun 2025 19:56:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id CABC320019;
	Wed, 11 Jun 2025 19:56:22 +0000 (UTC)
Date: Wed, 11 Jun 2025 15:56:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH] xdp: Remove unused events xdp_redirect_map and
 xdp_redirect_map_err
Message-ID: <20250611155615.0c2cf61c@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: pdykq43w8igi8jwatgzsxdq8xngwqecd
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: CABC320019
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+idN4t/5BvaMxfbcOBfj6t8p+kzKNs5J8=
X-HE-Tag: 1749671782-645701
X-HE-Meta: U2FsdGVkX19UAxdIQXcHLtYE1Q9eBHt1EaP924LY6qY76d5BTDjx02G6DZrigR7mDjc0ng9bCuiDNdSMtowH8DN69rz3KxE1xQN+MXhHx+RNDSGwMqsPKAAXi9R3+M6rOotPxvTalbe9r/DOIWqnHmueKKqY113ottk4HG9LSxRqmlglnH9EG2xloQ5DjBD6dZPd1fz3nEHKQjx2fKOh5N8vp+30XAb9nHQTmE85V7OmRz1wT7lo74xXxgd3XMXGdXhcuz2aPmC+4nPWy5zHTaPQQLfI/Nu5mL67YT6KrACV/D3Nc0xzmxvcZWExr0Fi1Gy3370SIDYbwPuWLIGbQPWzxbIb3S67bxiDAmM1NOUUHc2SuDM6enMEP3NU2FvC

From: Steven Rostedt <rostedt@goodmis.org>

Each TRACE_EVENT() defined can take up around 5K of text and meta data
regardless if they are used or not. New code is being developed that will
warn when a tracepoint is defined but not used.

The trace events xdp_redirect_map and xdp_redirect_map_err are defined but
not used, but there's also a comment that states these are kept around for
backward compatibility. Which is interesting because since they are not
used, any old BPF program that expects them to exist will get incorrect
data (no data) when they use them. It's worse than not working, it's
silently failing.

Remove them as they will soon cause warnings, or if they really need to
stick around, then code needs to be added to use them.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/xdp.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/include/trace/events/xdp.h b/include/trace/events/xdp.h
index d3ef86c97ae3..0fe0893c2567 100644
--- a/include/trace/events/xdp.h
+++ b/include/trace/events/xdp.h
@@ -168,25 +168,6 @@ DEFINE_EVENT(xdp_redirect_template, xdp_redirect_err,
 #define _trace_xdp_redirect_map_err(dev, xdp, to, map_type, map_id, index, err) \
 	 trace_xdp_redirect_err(dev, xdp, to, err, map_type, map_id, index)
 
-/* not used anymore, but kept around so as not to break old programs */
-DEFINE_EVENT(xdp_redirect_template, xdp_redirect_map,
-	TP_PROTO(const struct net_device *dev,
-		 const struct bpf_prog *xdp,
-		 const void *tgt, int err,
-		 enum bpf_map_type map_type,
-		 u32 map_id, u32 index),
-	TP_ARGS(dev, xdp, tgt, err, map_type, map_id, index)
-);
-
-DEFINE_EVENT(xdp_redirect_template, xdp_redirect_map_err,
-	TP_PROTO(const struct net_device *dev,
-		 const struct bpf_prog *xdp,
-		 const void *tgt, int err,
-		 enum bpf_map_type map_type,
-		 u32 map_id, u32 index),
-	TP_ARGS(dev, xdp, tgt, err, map_type, map_id, index)
-);
-
 TRACE_EVENT(xdp_cpumap_kthread,
 
 	TP_PROTO(int map_id, unsigned int processed,  unsigned int drops,
-- 
2.47.2


