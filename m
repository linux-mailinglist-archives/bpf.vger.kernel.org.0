Return-Path: <bpf+bounces-60537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C627AD7E57
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 00:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96DE31895E30
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 22:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC832DECC9;
	Thu, 12 Jun 2025 22:20:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2912C325E;
	Thu, 12 Jun 2025 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749766833; cv=none; b=jO9H4+Z+usVp9C9ad40okEwn7W6QMmrHZ8Hx54LaZgU0qDqTJX7Jjf1aIj+1CzWWs9LnJzKYZTCngmpqWU+iWc8Zzzdl+7Xbeah6u4VHkRuk4SiRSRXCPxJWm/IMGQPGACo9dMU3Zx0KfnKQ7MnLAW6iJiebeVOZG5vICKlg5O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749766833; c=relaxed/simple;
	bh=Na0ynebOU4CGKRpm0PtJxXz/2VI6J9NPn54Ne2U51XI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jfoG7+fwpf7LdX/yAsahYfwTz6AiAjB6MGWo1imhR4GLakHp0vpgP+Z2F4g040Nbo+naGH5cD659umqRQbjDqTBWcmtrhMfNCBn6CEDqRCqEJ/94aGr8lRmJRy2zdjLgfYUKHpJrzXH9e308J4AzdY7LogIGeUgaXS53JfIuA+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 60929B855C;
	Thu, 12 Jun 2025 22:20:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 2B15E2F;
	Thu, 12 Jun 2025 22:20:25 +0000 (UTC)
Date: Thu, 12 Jun 2025 18:20:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH v2] xdp: tracing: Hide some xdp events under
 CONFIG_BPF_SYSCALL
Message-ID: <20250612182023.78397b76@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ibcxz78suoa7uyk3qcq4ktqe9wzr7oh1
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 2B15E2F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18R80o1UHg+tmXsmtWNCHay9SdMG4FMWfA=
X-HE-Tag: 1749766825-585844
X-HE-Meta: U2FsdGVkX19V5+HsQqXb1Ps0IuyK+X/e6sLUQV+6WB+74mgly877LaBAqXAATsnGSaCG5bJ6lDznqIJBeQqBP2WAo+ZbYd1tf3YTfeV6OOtlKXgthBkuBzGLNgXy7QZ3WY9FDoWn54uCHjmSFt2WQv5OQD8DomXO0H6VXqdAUncXb037JPfca0+QVkXG+vse92X5LDJqpuiJltQEaII3xocSPwPTcda31eL2J+quhadYpC3RtUyS2tgiXbiGSKhGDeHPE5+5XgBf/KWlKpoP2JwOSWuluisbBYX1r92AtYOBbWntOe5pQa+b8gdylB0hgXUqFGEDP2TL4gtGgxPcyjyc4TwEa/IqMkf7Lfox0baNTg4kXqgFRFWnYpKYLwRblurljrrf/LoFLdZUTOqWPQ==

From: Steven Rostedt <rostedt@goodmis.org>

The events xdp_cpumap_kthread, xdp_cpumap_enqueue and xdp_devmap_xmit are
only called when CONFIG_BPF_SYSCALL is defined.  As each event can take up
to 5K regardless if they are used or not, it's best not to define them
when they are not used. Add #ifdef around these events when they are not
used.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20250612101612.3d4509cc@batman.local.home

- Rebased on top of bpf-next

 include/trace/events/xdp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/trace/events/xdp.h b/include/trace/events/xdp.h
index d3ef86c97ae3..746a9e95a52a 100644
--- a/include/trace/events/xdp.h
+++ b/include/trace/events/xdp.h
@@ -187,6 +187,7 @@ DEFINE_EVENT(xdp_redirect_template, xdp_redirect_map_err,
 	TP_ARGS(dev, xdp, tgt, err, map_type, map_id, index)
 );
 
+#ifdef CONFIG_BPF_SYSCALL
 TRACE_EVENT(xdp_cpumap_kthread,
 
 	TP_PROTO(int map_id, unsigned int processed,  unsigned int drops,
@@ -300,6 +301,7 @@ TRACE_EVENT(xdp_devmap_xmit,
 		  __entry->sent, __entry->drops,
 		  __entry->err)
 );
+#endif /* CONFIG_BPF_SYSCALL */
 
 /* Expect users already include <net/xdp.h>, but not xdp_priv.h */
 #include <net/xdp_priv.h>
-- 
2.47.2


