Return-Path: <bpf+bounces-70807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9524FBD551F
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 19:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE9834FF9C6
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 16:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B83129ACF7;
	Mon, 13 Oct 2025 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="CeNDYgRo"
X-Original-To: bpf@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A9B2989A2;
	Mon, 13 Oct 2025 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374308; cv=none; b=UHtcMB2bfyGFuxtO3lteBid+IzvbjGJ51FUpbcx8gXAi5QOBxlPv6v2vJFzAScltKUgH+HtTLKp/P3UeSF0Wbq4E1mDBgU3oVdbJva4i+Qq+gupeOIHSrWzMOBUnXGI8Tn0AYJhFq+26BBwUT0MDgQWKLTt0V3lvzjKD2JYRPYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374308; c=relaxed/simple;
	bh=p8sDry/r93YpiCyDay4HUdBBvRo6dP4j8o/JiZT6IY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQ3ReubT4ew3p/2t/VgfkkEm73HH6dIKqN8lg0UfzNTTfG1yYpQy00bypU+/f7pYvNRuYdXkF2uFljJNVYTzQYOimojH0JRkYkBbtPjjDQbDquhPisM6q5tr6Z7zO7ehRp4qg9cIyDZe298OQLWOHB9tFJ7qE+PveYdKpdJ9Vmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=CeNDYgRo; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1760374303;
	bh=p8sDry/r93YpiCyDay4HUdBBvRo6dP4j8o/JiZT6IY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CeNDYgRoOc4ApNqJSBJ07rEsBATyNRNTkiJiU0Kh7gdHykA5KL+rnwLWrddp7WK/a
	 ewjf8NVUWd1Xo6p+R69jpNuMDIaYZu/u3dbuEexISIUVaUzcGdP41UWMa9MAD+nOzq
	 Tub9QkJ1QqdUelLYVhjOO9CsDhIZJK7jokWz/w8SivaPzHkzqpOYIe5E5T5pWwJaX4
	 QGokedRi54mxcJnsjUOydDqOqnRKo31+baL77whKoNTqcjXVx9O4/nWzbC4ZMPz7pW
	 ZrO7Qry/cU6RkwVN1ZsTP+Sf2N8WxQpkjy6ivnRFLWRxw5IY35LUif+S9yWHskdd5a
	 il7lwTXJDtmvQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id A105A600C1;
	Mon, 13 Oct 2025 16:50:35 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 83C60201F40; Mon, 13 Oct 2025 16:50:27 +0000 (UTC)
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
Subject: [PATCH net-next 5/6] tools: ynl-gen: construct bitflag masks in generated headers
Date: Mon, 13 Oct 2025 16:50:02 +0000
Message-ID: <20251013165005.83659-6-ast@fiberby.net>
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

Instead of pre-computing the bitflag mask within the code generator,
then generate the code to combine all the flags in the generated code.

This patch uses the new p_wrap() method to wrap long lines.

This IMHO makes the generated code read more like handwritten code.

No functional changes.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/uapi/linux/netdev.h       | 6 +++++-
 tools/include/uapi/linux/netdev.h | 6 +++++-
 tools/net/ynl/pyynl/ynl_gen_c.py  | 7 +++++--
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index db0526cb6672d..337f444178bbb 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -35,7 +35,11 @@ enum netdev_xdp_act {
 	NETDEV_XDP_ACT_NDO_XMIT_SG = 1U << 6,
 
 	/* private: */
-	NETDEV_XDP_ACT_MASK = 127,
+	NETDEV_XDP_ACT_MASK = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			      NETDEV_XDP_ACT_NDO_XMIT |
+			      NETDEV_XDP_ACT_XSK_ZEROCOPY |
+			      NETDEV_XDP_ACT_HW_OFFLOAD | NETDEV_XDP_ACT_RX_SG |
+			      NETDEV_XDP_ACT_NDO_XMIT_SG,
 };
 
 /**
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index db0526cb6672d..337f444178bbb 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -35,7 +35,11 @@ enum netdev_xdp_act {
 	NETDEV_XDP_ACT_NDO_XMIT_SG = 1U << 6,
 
 	/* private: */
-	NETDEV_XDP_ACT_MASK = 127,
+	NETDEV_XDP_ACT_MASK = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			      NETDEV_XDP_ACT_NDO_XMIT |
+			      NETDEV_XDP_ACT_XSK_ZEROCOPY |
+			      NETDEV_XDP_ACT_HW_OFFLOAD | NETDEV_XDP_ACT_RX_SG |
+			      NETDEV_XDP_ACT_NDO_XMIT_SG,
 };
 
 /**
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 1201c2ac352ea..5e1c702143d86 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -3232,12 +3232,15 @@ def render_uapi(family, cw):
                 cw.p('/* private: */')
                 max_name = c_upper(enum.enum_max_name)
                 if const['type'] == 'flags':
-                    max_val = f'{enum.get_mask()},'
+                    values = list(enum.entries.values())
+                    parts = [f'{val.c_name} |' for val in values[:-1]]
+                    parts.append(f'{values[-1].c_name},')
+                    cw.p_wrap(f'{max_name} = ', parts)
                 else:
                     cnt_name = c_upper(enum.enum_cnt_name)
                     cw.p(f'{cnt_name},')
                     max_val = f'({cnt_name} - 1)'
-                cw.p(f'{max_name} = {max_val}')
+                    cw.p(f'{max_name} = {max_val}')
             cw.block_end(line=';')
             cw.nl()
         elif const['type'] == 'const':
-- 
2.51.0


