Return-Path: <bpf+bounces-76456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C79DCB48CD
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 03:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03CC23014AEF
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 02:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E932C0F92;
	Thu, 11 Dec 2025 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fEC9TIho"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637002BE029;
	Thu, 11 Dec 2025 02:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765419210; cv=none; b=o3CKuCey3NBPpWHYZJ8sKckGXwfevaqhHotmv/TV8ejc5zTZZ6dCK8xUbXfK5IhZgE0demwTzkN+zUKVE6rV7X/4JtK3PQLonInCUxeXZ81UtNunVTX4ZaD3KJB5jecCgkpvD89KXtc7sGPRRwZPW5WlwPavFHyJWMd/QLNsLmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765419210; c=relaxed/simple;
	bh=mkroXq3OFkMoZGRn8gju20th14fJo2uSmvtnN/OMTwg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tN4WOkfZqGAWIjX/lDYrHXZDIzkrLoTnhv5gRDVz+dVDOy466w91RW9NcT9PAjrLFi0TmIh9nvJFSRj0iqt1+ROSYbCNLXMtavjjMQ+/UYDqfKADy5knbkjpTjBexMN9rNhCPx3tjSaH4OYEPp0TugmsYmTtmEtUEW4Qaf0Ca+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fEC9TIho; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [40.78.12.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id ABDCF2116048;
	Wed, 10 Dec 2025 18:13:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ABDCF2116048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765419207;
	bh=f6AZcn65ci1H3rxNkKRrHYwj60rHswJG0EWtgmSUxiY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fEC9TIho8RERKhtTSYrejeDP+WaxV5liGpYNiCrp3JRIPFy0CwaeO1C3YW2m0751n
	 Z4cWuFpSsHywjghSY6XSRWh8JFSR4qAOgPyLLsDqnAKVJuNYABvYxf7IbdiYQjVcHB
	 tFE9PKy8m5AlCUSpj9WhosXQgHb6kPhs93GECtfg=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James.Bottomley@HansenPartnership.com,
	dhowells@redhat.com,
	linux-security-module@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RFC 10/11] hornet: Add a light skeleton data extractor scripts
Date: Wed, 10 Dec 2025 18:12:05 -0800
Message-ID: <20251211021257.1208712-11-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251211021257.1208712-1-bboscaccy@linux.microsoft.com>
References: <20251211021257.1208712-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These script eases light skeleton development against Hornet by
generating a data payloads which can be used for signing a light
skeleton binary using gen_sig.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 scripts/hornet/extract-insn.sh | 27 +++++++++++++++++++++++++++
 scripts/hornet/extract-map.sh  | 27 +++++++++++++++++++++++++++
 scripts/hornet/extract-skel.sh | 27 +++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100755 scripts/hornet/extract-insn.sh
 create mode 100755 scripts/hornet/extract-map.sh
 create mode 100755 scripts/hornet/extract-skel.sh

diff --git a/scripts/hornet/extract-insn.sh b/scripts/hornet/extract-insn.sh
new file mode 100755
index 0000000000000..399b9ca500e3f
--- /dev/null
+++ b/scripts/hornet/extract-insn.sh
@@ -0,0 +1,27 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2025 Microsoft Corporation
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of version 2 of the GNU General Public
+# License as published by the Free Software Foundation.
+
+function usage() {
+    echo "Sample script for extracting instructions"
+    echo "autogenerated eBPF lskel headers"
+    echo ""
+    echo "USAGE: header_file"
+    exit
+}
+
+ARGC=$#
+
+EXPECTED_ARGS=1
+
+if [ $ARGC -ne $EXPECTED_ARGS ] ; then
+    usage
+else
+    printf $(gcc -E $1 | grep "opts\.insns =" | \
+		 awk -F")" '{print $2}' | sed 's/;\+$//' | sed 's/\"//g')
+fi
diff --git a/scripts/hornet/extract-map.sh b/scripts/hornet/extract-map.sh
new file mode 100755
index 0000000000000..ca5d912dc5654
--- /dev/null
+++ b/scripts/hornet/extract-map.sh
@@ -0,0 +1,27 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2025 Microsoft Corporation
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of version 2 of the GNU General Public
+# License as published by the Free Software Foundation.
+
+function usage() {
+    echo "Sample script for extracting instructions"
+    echo "autogenerated eBPF lskel headers"
+    echo ""
+    echo "USAGE: header_file"
+    exit
+}
+
+ARGC=$#
+
+EXPECTED_ARGS=1
+
+if [ $ARGC -ne $EXPECTED_ARGS ] ; then
+    usage
+else
+    printf $(gcc -E $1 | grep "opts\.data =" | \
+		 awk -F")" '{print $2}' | sed 's/;\+$//' | sed 's/\"//g')
+fi
diff --git a/scripts/hornet/extract-skel.sh b/scripts/hornet/extract-skel.sh
new file mode 100755
index 0000000000000..6550a86b89917
--- /dev/null
+++ b/scripts/hornet/extract-skel.sh
@@ -0,0 +1,27 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2025 Microsoft Corporation
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of version 2 of the GNU General Public
+# License as published by the Free Software Foundation.
+
+function usage() {
+    echo "Sample script for extracting instructions and map data out of"
+    echo "autogenerated eBPF lskel headers"
+    echo ""
+    echo "USAGE: header_file field"
+    exit
+}
+
+ARGC=$#
+
+EXPECTED_ARGS=2
+
+if [ $ARGC -ne $EXPECTED_ARGS ] ; then
+    usage
+else
+    printf $(gcc -E $1 | grep "static const char opts_$2" | \
+		 awk -F"=" '{print $2}' | sed 's/;\+$//' | sed 's/\"//g')
+fi
-- 
2.52.0


