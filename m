Return-Path: <bpf+bounces-70813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D80BD541D
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 18:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B525318A5D4D
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 16:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDD22BE638;
	Mon, 13 Oct 2025 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="XdRfc3ch"
X-Original-To: bpf@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35052298CC4;
	Mon, 13 Oct 2025 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374310; cv=none; b=lKB7aof4dmbPnWP8HqrfWwRPDGBdcMyBQ4kpyWE48vIm8jTHhJvlhmXENTiMWgLclgGKIeVRjHdnZUGDK9Niguh/PXQhUnentY38r7TDak59T2vRJlufRb8Nq9mpTYB9pzPsclcwhrq3m6ioijeGwcenWmBnIcl2Y6941fv/NTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374310; c=relaxed/simple;
	bh=3LWAW2XwKFRP8Oeuhh8xoOoHiwBJYBgYAYJw8UV+2mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjsmOZR3ZJcm3qdkLPZRkLiNeVYeS1Vn8ILLmpgQZAqGMoabzlV7IB+IMbPtSpBWS1/MWdh1g6kWkexDkllJnBJ1LZB7GK5rv2fwvv1Th3S3Vd9P3QplPuz9xV8engMuyNnLUpGMRRdZAlP7NkWZ+RZpbA6OFsqgTcj+IPjSRCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=XdRfc3ch; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1760374306;
	bh=3LWAW2XwKFRP8Oeuhh8xoOoHiwBJYBgYAYJw8UV+2mY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XdRfc3chi3xMDJ+gqELGqztdKoTXSd4IcD5LtHULkDk5ABFs16ftxSCnlCZVp/WTv
	 nQu5MwFImVTQNes6aQAf+2F5cMcgxm+YC4jrF3rXn6T4LCcf3UQW9WVG6jhMqg/8AN
	 Ua8LnPSH6032G76IaT/fcYIagXXI4gRc5rn8uOS7hpukihOVfENhdI4bjO5XO6na6e
	 hbfrThy+lwGqNm83DtNYTTgpq3NIEfJeD72QTan6WKfb9kjOr0J/0qaJ2SjCGRoYJ3
	 tKMtEKR7YEibfpw81f8GDeHPLeZGr6/Ebdr7EdEC9e36jIXR2wu8J+D+m6+W88IHHH
	 0e7fU2GMH/MzA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 685DC60109;
	Mon, 13 Oct 2025 16:51:43 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id C155420199A; Mon, 13 Oct 2025 16:50:24 +0000 (UTC)
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
Subject: [PATCH net-next 2/6] tools: ynl-gen: refactor render-max enum generation
Date: Mon, 13 Oct 2025 16:49:59 +0000
Message-ID: <20251013165005.83659-3-ast@fiberby.net>
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

This patch refactors the generation of the three render-max
private enum members: (__$pfx-MAX and $pfx-MAX) or $pfx-MASK.

The names, default or not, are now resolved in the EnumSet class.

This makes enum.enum_max_name re-usable for NLA_POLICY_MASK() in
the next patch in this series, so we don't have to re-define it.

This doesn't change the generated output.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index e6df0e2b63a8c..2666cc54d09c0 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1060,7 +1060,9 @@ class EnumSet(SpecEnumSet):
 
         self.value_pfx = yaml.get('name-prefix', f"{family.ident_name}-{yaml['name']}-")
         self.header = yaml.get('header', None)
-        self.enum_cnt_name = yaml.get('enum-cnt-name', None)
+        self.enum_cnt_name = yaml.get('enum-cnt-name', f'--{self.value_pfx}max')
+        suffix = yaml['type'] == 'flags' and 'mask' or 'max'
+        self.enum_max_name = f'{self.value_pfx}{suffix}'
 
         super().__init__(family, yaml)
 
@@ -3205,7 +3207,6 @@ def render_uapi(family, cw):
                 cw.p(' */')
 
             uapi_enum_start(family, cw, const, 'name')
-            name_pfx = const.get('name-prefix', f"{family.ident_name}-{const['name']}-")
             for entry in enum.entries.values():
                 suffix = ','
                 if entry.value_change:
@@ -3215,17 +3216,14 @@ def render_uapi(family, cw):
             if const.get('render-max', False):
                 cw.nl()
                 cw.p('/* private: */')
+                max_name = c_upper(enum.enum_max_name)
                 if const['type'] == 'flags':
-                    max_name = c_upper(name_pfx + 'mask')
-                    max_val = f' = {enum.get_mask()},'
-                    cw.p(max_name + max_val)
+                    max_val = f'{enum.get_mask()},'
                 else:
-                    cnt_name = enum.enum_cnt_name
-                    max_name = c_upper(name_pfx + 'max')
-                    if not cnt_name:
-                        cnt_name = '__' + name_pfx + 'max'
-                    cw.p(c_upper(cnt_name) + ',')
-                    cw.p(max_name + ' = (' + c_upper(cnt_name) + ' - 1)')
+                    cnt_name = c_upper(enum.enum_cnt_name)
+                    cw.p(f'{cnt_name},')
+                    max_val = f'({cnt_name} - 1)'
+                cw.p(f'{max_name} = {max_val}')
             cw.block_end(line=';')
             cw.nl()
         elif const['type'] == 'const':
-- 
2.51.0


