Return-Path: <bpf+bounces-70811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 497F7BD55D8
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 19:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20A242671B
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 16:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D6C29DB86;
	Mon, 13 Oct 2025 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="KoYqNapt"
X-Original-To: bpf@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED38923C4F3;
	Mon, 13 Oct 2025 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374309; cv=none; b=Nm8TLclGjO6UjsUSAtgfOhBDaDEtQhXKJLHVJEs7yPEbpZ4PAb59d+KnpxVht5AR8Qc492VpcUnbD7d9Sfeo+6dHB0R+6ULNYPJv1Id7/irHz5Q6NBe5rCQU1lxgrWAqHGbrhl0/jt5z9A35WZNhjamODzc6Tb8PlbUZKPwLcOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374309; c=relaxed/simple;
	bh=/oDiaZBlXUBR5cGDBcQM/4+6/ZJeCVisVjvE+Vycvp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rg/M+HDlVTtSGeiGfZY8rSe7tvO6/DN/hoPMJhqSkWUryibcUZu5S0g0xmhz78DgSleS7nw6jv/n57BS82N9MmY2l4xoG8Vosf4Z8QXjpY2MV5HkJwCYEhqQ9GEsqYRTtUR52TGV12CsdxlOWyM1YfGhgVsGlpvi9+Ky2kfTAqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=KoYqNapt; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1760374303;
	bh=/oDiaZBlXUBR5cGDBcQM/4+6/ZJeCVisVjvE+Vycvp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KoYqNaptWl5rUjJBbmXczrhDhy+iVD+oTskezAzXO/V5IxhZryHvmm7+//IT4ZvMh
	 zJrTL0lmUUqbYdcvQE//dS60pwprwrACjekSPC3Pi1LR60N8qCeuybLsv/byqvgZMT
	 K2/8oJHD0zo35dVwhRI+aTsd/KivsOrfQMk/Zzps/Xv8z+W04/PHH5/YL/s/ME1mr6
	 cVJmHNlSsvm3ltmqz1Zko/qswJAa+ZslHZ6ks41wKD4pPxFVhMHIFmC+9c/jpgF5pZ
	 /69Vi73IilhPAI5ml9/xGWJwMiPxjxjPqJ85uR9Eml4R9gcRW7J7lYG33sKnAbwkXm
	 J/wTrYNY4LPOg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id B6A0F600FF;
	Mon, 13 Oct 2025 16:50:35 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 4C663202AE6; Mon, 13 Oct 2025 16:50:28 +0000 (UTC)
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
Subject: [PATCH net-next 6/6] tools: ynl-gen: allow custom naming of render-max definitions
Date: Mon, 13 Oct 2025 16:50:03 +0000
Message-ID: <20251013165005.83659-7-ast@fiberby.net>
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

When `render-max` is set for an enum, then it generates either
(`__$pfx-MAX` and `$pfx-MAX`) or (`$pfx-MASK` for flags).

The count definition `__$pfx-MAX` can already be overridden via
`enum-cnt-name` in the spec.

This patch adds a new `enum-max-name` attribute which can be used
to override the names for either `$pfx-MAX` or `$pfx-MASK`.

The existing `enum-cnt-name` is only described for the genetlink-c
and genetlink-legacy protocols, so I have only added `enum-max-name`
for those protocols.

This doesn't change the generated output.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---

Alternatively `enum-max-name` should be added to all protocols, so
that genetlink families can also choose to eg. have these private
variables prefixed with "__". As NETDEV_XDP_ACT_MASK leaked into
xdp-tools [v1.4.0..v1.5.7], then if we want to change the default
names[1], then we would still need to be able to use an override
to keep the current NETDEV_XDP_ACT_MASK name in the netdev family.

[1] https://lore.kernel.org/netdev/20230614211715.01940bbd@kernel.org/
---
 Documentation/netlink/genetlink-c.yaml             | 3 +++
 Documentation/netlink/genetlink-legacy.yaml        | 3 +++
 Documentation/userspace-api/netlink/c-code-gen.rst | 7 +++++--
 tools/net/ynl/pyynl/ynl_gen_c.py                   | 6 ++++--
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 5a234e9b5fa2e..755b24fb0c319 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -110,6 +110,9 @@ properties:
         enum-cnt-name:
           description: Name of the render-max counter enum entry.
           type: string
+        enum-max-name:
+          description: Name of the render-max max or mask enum entry.
+          type: string
         # End genetlink-c
 
   attribute-sets:
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 66fb8653a3442..ad4d69be6294e 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -124,6 +124,9 @@ properties:
         enum-cnt-name:
           description: Name of the render-max counter enum entry.
           type: string
+        enum-max-name:
+          description: Name of the render-max max or mask enum entry.
+          type: string
         # End genetlink-c
         # Start genetlink-legacy
         members:
diff --git a/Documentation/userspace-api/netlink/c-code-gen.rst b/Documentation/userspace-api/netlink/c-code-gen.rst
index 46415e6d646d2..413a56424012a 100644
--- a/Documentation/userspace-api/netlink/c-code-gen.rst
+++ b/Documentation/userspace-api/netlink/c-code-gen.rst
@@ -57,8 +57,11 @@ portion of the entry name.
 
 Boolean ``render-max`` controls creation of the max values
 (which are enabled by default for attribute enums). These max
-values are named ``__$pfx-MAX`` and ``$pfx-MAX``. The name
-of the first value can be overridden via ``enum-cnt-name`` property.
+values are named ``__$pfx-MAX`` and ``$pfx-MAX``, and can be
+overwritten via the properties ``enum-cnt-name`` and
+``enum-max-name`` respectively.
+For flags ``render-max`` will generate a mask with all flags set,
+which by default will be named ``$pfx-MASK``.
 
 Attributes
 ==========
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 5e1c702143d86..a1a0b559b431b 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1067,8 +1067,10 @@ class EnumSet(SpecEnumSet):
         self.value_pfx = yaml.get('name-prefix', f"{family.ident_name}-{yaml['name']}-")
         self.header = yaml.get('header', None)
         self.enum_cnt_name = yaml.get('enum-cnt-name', f'--{self.value_pfx}max')
-        suffix = yaml['type'] == 'flags' and 'mask' or 'max'
-        self.enum_max_name = f'{self.value_pfx}{suffix}'
+        self.enum_max_name = yaml.get('enum-max-name', None)
+        if not self.enum_max_name:
+            suffix = yaml['type'] == 'flags' and 'mask' or 'max'
+            self.enum_max_name = f'{self.value_pfx}{suffix}'
 
         super().__init__(family, yaml)
 
-- 
2.51.0


