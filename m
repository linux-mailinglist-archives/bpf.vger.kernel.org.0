Return-Path: <bpf+bounces-70812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B085BD540D
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 18:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E430518A685E
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 16:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE96C2BE03B;
	Mon, 13 Oct 2025 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="BX85OMhy"
X-Original-To: bpf@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FD8296BDB;
	Mon, 13 Oct 2025 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374310; cv=none; b=Gs8VgjOXzyKzgtsEq+iLvuHdk3UzjbvYJPLknIsNPcNX68Ru35OwFv45PIpkwt8euyfHbAHzpNxNglCguiCkbpfro7slJsDWTq18g5ypUe8O2cxEPivlvwneYR1rWFNQBE6Zci8/2b0VaUowNqyZTGFkLIzA73Urwgrll0+qV08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374310; c=relaxed/simple;
	bh=wSnDcOPEm541S8uM2djsmmEa/KIIVZc/LcMVAQsHwEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0yj6KHktbDTe00ayZLmP+UkwPICFdtc+v86NFFQmf59rRC3byBXELP+LIpU/y7JxuDgE4MxG5cxslnYqpeGuCvjEoAI/D9Cglz7Vd5RYvGu5q9BeqdaomWakYxCCWttqvMx1dO+CJGZVM7S/1dkXGPPxDyJcSEkddIsMaoGmdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=BX85OMhy; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1760374306;
	bh=wSnDcOPEm541S8uM2djsmmEa/KIIVZc/LcMVAQsHwEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BX85OMhygxa8BP3Jy0gIzXmuu/VsQ491ny9dxfwzMNrTGUto2OHnNAb1gZU40S2ZD
	 4cNEpHiq8WV6zYZHSWZcnb0CqyvuJJ8fEK49eXLXPCGhn9S+F91qxkVvn+HweVEO1g
	 fl2ph/SxNKoXfSdA3t5nVICqPz4oAJyE8027woqQx0Qv6OswFD0RIJeMwFmLEgxc24
	 i+L/XY6syAbkEJBzRKrkK9gqTnAadZbUZJY8W+YdolYUhz4/dEs26cQjE7VZcetgnL
	 ZjS6I2nTXek8t5oJ6BQqWfakEwvnAEzSyScV+TNOy6gCWcnEmW5wFZEgRQ2etF09jx
	 Fe9j+EQsbYptg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 685BB60107;
	Mon, 13 Oct 2025 16:51:43 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id C62DB201CE5; Mon, 13 Oct 2025 16:50:25 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Joe Damato <jdamato@fastly.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/6] tools: ynl-gen: use uapi mask definition in NLA_POLICY_MASK
Date: Mon, 13 Oct 2025 16:50:00 +0000
Message-ID: <20251013165005.83659-4-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013165005.83659-1-ast@fiberby.net>
References: <20251013165005.83659-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently when generating policies using NLA_POLICY_MASK(), then
we emit a pre-computed decimal mask.

When render-max is set, then we can re-use the mask definition,
that has been generated in the uapi header.

This IMHO makes the generated code read more like handwritten code.

This patch assumes that "kernel source" is only generated, when
"uapi header" is also generated through ynl-gen, when render-max is
set in the spec. AFAICT this is fine, as render-max is pointless
when uapi is not generated by ynl-gen.

Currently no generated policies are changed by this, as there are
no specs which are used for generation, which also has render-max.
In the future this might be used for code generation by wireguard.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 2666cc54d09c0..b00762721280c 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -418,12 +418,18 @@ class TypeScalar(Type):
         if 'flags-mask' in self.checks or self.is_bitfield:
             if self.is_bitfield:
                 enum = self.family.consts[self.attr['enum']]
-                mask = enum.get_mask(as_flags=True)
+                if enum.get('render-max', False):
+                    mask = c_upper(enum.enum_max_name)
+                else:
+                    mask = enum.get_mask(as_flags=True)
             else:
                 flags = self.family.consts[self.checks['flags-mask']]
                 flag_cnt = len(flags['entries'])
                 mask = (1 << flag_cnt) - 1
-            return f"NLA_POLICY_MASK({policy}, 0x{mask:x})"
+
+            if isinstance(mask, int):
+                mask = f'0x{mask:x}'
+            return f"NLA_POLICY_MASK({policy}, {mask})"
         elif 'full-range' in self.checks:
             return f"NLA_POLICY_FULL_RANGE({policy}, &{c_lower(self.enum_name)}_range)"
         elif 'range' in self.checks:
-- 
2.51.0


