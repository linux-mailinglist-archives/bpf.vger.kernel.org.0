Return-Path: <bpf+bounces-70808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B396BBD55F1
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 19:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4462B4FE09B
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 16:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B92429B200;
	Mon, 13 Oct 2025 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="ej7+QjuB"
X-Original-To: bpf@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1382989B4;
	Mon, 13 Oct 2025 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374308; cv=none; b=UmBbwHsJgz+8MCa3XexdRl7xfYzC/Xr3oy3hddnTKjyH5tIal3IivjYc7yY2q1PX4TSO+oDmO3tg2vwjC7wT0nVqsSx3pC82Cj3b7Qh0txwj+yn30u3YfIaZW/l+/139iAlqwZMIuO5gwYe2xp/ysy2R/XLOZFAGOkoto+zgnxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374308; c=relaxed/simple;
	bh=vdV0+M0c//vveSxiWtYRprv4vOfUbsvwAZSi8SqwOhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSxj0W/U1kdO7dNQAIoXQkdcjftMeBTHObOD1HDfb1K/Pr9Ma0T4zJdlnJf9dMZJzqXVS4qFKjV/wTirjRq+FbeRgE4i1ypjGu9ODw6zbbZb8oCYQsCc0tCpnfLqaMuHhxeBlBTC4Nj/dkGiKTQkxkFIf6mhXkaxqEOHvOOOkRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=ej7+QjuB; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1760374303;
	bh=vdV0+M0c//vveSxiWtYRprv4vOfUbsvwAZSi8SqwOhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ej7+QjuBabrAr8pBomkp6mXGHD9MfgDUK5zH0ddq3D6aZ+1IGEgq8f5JvzVxrUfQw
	 U7hKGPAkKWzsz6PcTv82dcym597OoNOzLZBy58ydcRjx1lSakg8gWsUnpSGxmk8nBT
	 xX0N3oKn23Yc1l2j30Ni2Vi+3DTV6RKNH9bJJFuc6qMGiNhDZhdFgY59ianpLJlrm3
	 NqKU8sQH2AQsdnJds39lxHYMGx2b4sAH5HsU0fKyoBtMOS7KzRA6Zcp2uvQF4Bqs3c
	 XyxOZYZiQl9hpSFFsSu3DTHMcXctrE3JJX+4YY8wZ1CU3nUgrXBAi4fgUAYVvCQ9Z9
	 3CLhW1QNPoxrg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 99E616000C;
	Mon, 13 Oct 2025 16:50:35 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id BFAC1201E75; Mon, 13 Oct 2025 16:50:26 +0000 (UTC)
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
Subject: [PATCH net-next 4/6] tools: ynl-gen: add generic p_wrap() helper
Date: Mon, 13 Oct 2025 16:50:01 +0000
Message-ID: <20251013165005.83659-5-ast@fiberby.net>
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

Previously only write_func_prot() was performing line wrapping.

As the next patch in this series also requires line wrapping,
then this patch introduces a generic line wrapping helper in
CodeWriter called p_wrap(), which can be used in both cases.

This patch causes a change in the generated prototype for
psp_device_get_locked(), as the skb argument actually fits
on the first line, while not exceeding 80 characters.

No functional changes.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 net/psp/psp-nl-gen.h             |  4 +--
 tools/net/ynl/pyynl/ynl_gen_c.py | 42 +++++++++++++++++++-------------
 2 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/net/psp/psp-nl-gen.h b/net/psp/psp-nl-gen.h
index 25268ed11fb56..ac5f59b4f498c 100644
--- a/net/psp/psp-nl-gen.h
+++ b/net/psp/psp-nl-gen.h
@@ -14,8 +14,8 @@
 /* Common nested types */
 extern const struct nla_policy psp_keys_nl_policy[PSP_A_KEYS_SPI + 1];
 
-int psp_device_get_locked(const struct genl_split_ops *ops,
-			  struct sk_buff *skb, struct genl_info *info);
+int psp_device_get_locked(const struct genl_split_ops *ops, struct sk_buff *skb,
+			  struct genl_info *info);
 int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
 				struct sk_buff *skb, struct genl_info *info);
 void
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index b00762721280c..1201c2ac352ea 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1693,6 +1693,27 @@ class CodeWriter:
             ind += add_ind
         self._out.write('\t' * ind + line + '\n')
 
+    def p_wrap(self, prefix, parts):
+        assert(len(parts) > 0)
+        ts = 8
+        pfx_len = len(prefix)
+        pfx_ind_tabs = pfx_len // ts
+        pfx_ind = '\t' * pfx_ind_tabs + ' ' * (pfx_len % ts)
+        max_len = 80 - (self._ind * ts)
+        is_first_line = True
+        buf = f'{prefix}{parts[0]}'
+        for part in parts[1:]:
+            next_buf = f'{buf} {part}'
+            if len(next_buf) <= max_len:
+                buf = next_buf
+            else:
+                self.p(buf)
+                buf = f'{pfx_ind}{part}'
+                if is_first_line:
+                    max_len -= pfx_ind_tabs * (ts-1)
+                    is_first_line = False
+        self.p(buf)
+
     def nl(self):
         self._nl = True
 
@@ -1751,23 +1772,10 @@ class CodeWriter:
             v = ''
         elif qual_ret[-1] != '*':
             v += ' '
-        v += name + '('
-        ind = '\t' * (len(v) // 8) + ' ' * (len(v) % 8)
-        delta_ind = len(v) - len(ind)
-        v += args[0]
-        i = 1
-        while i < len(args):
-            next_len = len(v) + len(args[i])
-            if v[0] == '\t':
-                next_len += delta_ind
-            if next_len > 76:
-                self.p(v + ',')
-                v = ind
-            else:
-                v += ', '
-            v += args[i]
-            i += 1
-        self.p(v + ')' + suffix)
+
+        parts = [f'{arg},' for arg in args[:-1]]
+        parts.append(f'{args[-1]}){suffix}')
+        self.p_wrap(f'{v}{name}(', parts)
 
     def write_func_lvar(self, local_vars):
         if not local_vars:
-- 
2.51.0


