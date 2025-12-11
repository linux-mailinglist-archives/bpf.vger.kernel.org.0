Return-Path: <bpf+bounces-76454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8090DCB48B8
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 03:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FABF307DC74
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 02:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB112BDC3D;
	Thu, 11 Dec 2025 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UEIQOWkT"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702B92DC344;
	Thu, 11 Dec 2025 02:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765419206; cv=none; b=UfOWSSk3s+jQU5PF32+VWftVf+0VMIdr+evYOtpuFsVBwm+7PVC7pDTY0KlRb9fV50xYcK/c8fprOuUjO7bix3V7+Sh/NS9CAzKRndr4iy5oWin8AD1YUn1j8Btiu+aoH90vjBV5/+mr2gDNbE0kpszk2LtvADnoC5jxfVwPKbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765419206; c=relaxed/simple;
	bh=CehVMLMVOtMTVSUA/JBtH7AE4p3IR62dXJGkDE5/0FE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h46RHX7SU9NkPhg33jxkW9QceNLUoOsinGxKQ9/nzsTKObDoWe9uk0h8ePle8Q7vCu7YKodHUqjQ4kBO/9tWVIvnhjw42H77QDq0P2zWRq9Tsj1CR5tyA2JzQudlAxHgYL7ykZEEmmgQvxCZGkVcm4cBKnM8rGw6c7M5esRb2iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UEIQOWkT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [40.78.12.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2BF722116046;
	Wed, 10 Dec 2025 18:13:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2BF722116046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765419203;
	bh=omIdCqj9WPGrAIza0WzV1LRPwOQHUmhJe7PUs8a/Dmw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UEIQOWkTT98PC0r5IjMGzlBBi511MrEsSYV/5bkH22HWDdza+pxMByhj5OpNsqtJZ
	 z/8iMa0AbU2Yr/yMB9xgwKYNm1w5lFnHlbw3TwHx25T4zvMn+0phUZsSAzFK7nAYrW
	 sqHsJc7lPp7wOJC+ParRg3I3dDF2Y1fwPG2VRKng=
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
Subject: [RFC 08/11] security: Hornet LSM
Date: Wed, 10 Dec 2025 18:12:03 -0800
Message-ID: <20251211021257.1208712-9-bboscaccy@linux.microsoft.com>
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

This adds the Hornet Linux Security Module which provides enhanced
signature verification and data validation for eBPF programs. This
allows users to continue to maintain an invariant that all code
running inside of the kernel has actually been signed and verified, by
the kernel.

This effort builds upon the currently excepted upstream solution. It
further hardens it by providing deterministic, in-kernel checking of
map hashes to solidify auditing along with preventing TOCTOU attacks
against lskel map hashes.

Target map hashes are passed in via PKCS#7 signed attributes. Hornet
determines the extent which the eBFP program is signed and defers to
other LSMs for policy decisions.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 Documentation/admin-guide/LSM/Hornet.rst |  38 +++++
 Documentation/admin-guide/LSM/index.rst  |   1 +
 MAINTAINERS                              |   9 +
 include/linux/oid_registry.h             |   3 +
 include/uapi/linux/lsm.h                 |   1 +
 security/Kconfig                         |   3 +-
 security/Makefile                        |   1 +
 security/hornet/Kconfig                  |  11 ++
 security/hornet/Makefile                 |   7 +
 security/hornet/hornet.asn1              |  13 ++
 security/hornet/hornet_lsm.c             | 201 +++++++++++++++++++++++
 11 files changed, 287 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/LSM/Hornet.rst
 create mode 100644 security/hornet/Kconfig
 create mode 100644 security/hornet/Makefile
 create mode 100644 security/hornet/hornet.asn1
 create mode 100644 security/hornet/hornet_lsm.c

diff --git a/Documentation/admin-guide/LSM/Hornet.rst b/Documentation/admin-guide/LSM/Hornet.rst
new file mode 100644
index 0000000000000..0fb5920e9b68f
--- /dev/null
+++ b/Documentation/admin-guide/LSM/Hornet.rst
@@ -0,0 +1,38 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======
+Hornet
+======
+
+Hornet is a Linux Security Module that provides extensible signature
+verification for eBPF programs. This is selectable at build-time with
+``CONFIG_SECURITY_HORNET``.
+
+Overview
+========
+
+Hornet addresses concerns from users who require strict audit
+trails and verification guarantees, especially in security-sensitive
+environments. Map hashes for extended verification are passed in via
+the existing PKCS#7 uapi and verifified by the crypto
+subsystem. Hornet then calculates the verification state of the
+program (full, partial, bad, etc) and then invokes a new downstream
+LSM hook to delegate policy decisions.
+
+Tooling
+=======
+
+Some tooling is provided to aid with the development of signed eBPF
+light-skeletons.
+
+extract-skel.sh
+---------------
+
+This shell script extracts the instructions and map data used by the
+light skeleton from the autogenerated header file created by bpftool.
+
+gen_sig
+---------
+
+gen_sig creates a pkcs#7 signature of a data payload. Additionally it
+appends a signed attribute containing a set of hashes.
diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
index b44ef68f6e4da..57f6e9fbe5fd1 100644
--- a/Documentation/admin-guide/LSM/index.rst
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -49,3 +49,4 @@ subdirectories.
    SafeSetID
    ipe
    landlock
+   Hornet
diff --git a/MAINTAINERS b/MAINTAINERS
index 3da2c26a796b8..64c9aaff6a219 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11399,6 +11399,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
 F:	drivers/iio/pressure/mprls0025pa*
 
+HORNET SECURITY MODULE
+M:	Blaise Boscaccy <bboscaccy@linux.microsoft.com>
+L:	linux-security-module@vger.kernel.org
+S:	Supported
+T:	git https://github.com/blaiseboscaccy/hornet.git
+F:	Documentation/admin-guide/LSM/Hornet.rst
+F:	scripts/hornet/
+F:	security/hornet/
+
 HP BIOSCFG DRIVER
 M:	Jorge Lopez <jorge.lopez2@hp.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index 6de479ebbe5da..94e7c1a3fc639 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -145,6 +145,9 @@ enum OID {
 	OID_id_rsassa_pkcs1_v1_5_with_sha3_384, /* 2.16.840.1.101.3.4.3.15 */
 	OID_id_rsassa_pkcs1_v1_5_with_sha3_512, /* 2.16.840.1.101.3.4.3.16 */
 
+	/* Hornet LSM */
+	OID_hornet_data,	  /* 2.25.316487325684022475439036912669789383960 */
+
 	OID__NR
 };
 
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 938593dfd5daf..2ff9bcdd551e2 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -65,6 +65,7 @@ struct lsm_ctx {
 #define LSM_ID_IMA		111
 #define LSM_ID_EVM		112
 #define LSM_ID_IPE		113
+#define LSM_ID_HORNET		114
 
 /*
  * LSM_ATTR_XXX definitions identify different LSM attributes
diff --git a/security/Kconfig b/security/Kconfig
index 285f284dfcac4..8cbe314fd9238 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -230,6 +230,7 @@ source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"
 source "security/landlock/Kconfig"
 source "security/ipe/Kconfig"
+source "security/hornet/Kconfig"
 
 source "security/integrity/Kconfig"
 
@@ -274,7 +275,7 @@ config LSM
 	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,ipe,bpf" if DEFAULT_SECURITY_APPARMOR
 	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,ipe,bpf" if DEFAULT_SECURITY_TOMOYO
 	default "landlock,lockdown,yama,loadpin,safesetid,ipe,bpf" if DEFAULT_SECURITY_DAC
-	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,ipe,bpf"
+	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,ipe,hornet,bpf"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list, except for those with order
diff --git a/security/Makefile b/security/Makefile
index 22ff4c8bd8cec..e24bccd951f88 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
 obj-$(CONFIG_SECURITY_IPE)		+= ipe/
+obj-$(CONFIG_SECURITY_HORNET)		+= hornet/
 
 # Object integrity file lists
 obj-$(CONFIG_INTEGRITY)			+= integrity/
diff --git a/security/hornet/Kconfig b/security/hornet/Kconfig
new file mode 100644
index 0000000000000..19406aa237ac6
--- /dev/null
+++ b/security/hornet/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config SECURITY_HORNET
+	bool "Hornet support"
+	depends on SECURITY
+	default n
+	help
+	  This selects Hornet.
+	  Further information can be found in
+	  Documentation/admin-guide/LSM/Hornet.rst.
+
+	  If you are unsure how to answer this question, answer N.
diff --git a/security/hornet/Makefile b/security/hornet/Makefile
new file mode 100644
index 0000000000000..342142c5ff8a4
--- /dev/null
+++ b/security/hornet/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SECURITY_HORNET) := hornet.o
+
+hornet-y := hornet_lsm.o \
+	hornet.asn1.o
+
+$(obj)/hornet.asn1.o: $(obj)/hornet.asn1.c $(obj)/hornet.asn1.h
diff --git a/security/hornet/hornet.asn1 b/security/hornet/hornet.asn1
new file mode 100644
index 0000000000000..c8d47b16b65d7
--- /dev/null
+++ b/security/hornet/hornet.asn1
@@ -0,0 +1,13 @@
+-- SPDX-License-Identifier: BSD-3-Clause
+--
+-- Copyright (C) 2009 IETF Trust and the persons identified as authors
+-- of the code
+--
+-- https://www.rfc-editor.org/rfc/rfc5652#section-3
+
+HornetData ::= SET OF Map
+
+Map ::= SEQUENCE {
+	index			INTEGER ({ hornet_map_index }),
+	sha			OCTET STRING ({ hornet_map_hash })
+} ({ hornet_next_map })
diff --git a/security/hornet/hornet_lsm.c b/security/hornet/hornet_lsm.c
new file mode 100644
index 0000000000000..a8499ee108ad3
--- /dev/null
+++ b/security/hornet/hornet_lsm.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Hornet Linux Security Module
+ *
+ * Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
+ *
+ * Copyright (C) 2025 Microsoft Corporation
+ */
+
+#include <linux/lsm_hooks.h>
+#include <uapi/linux/lsm.h>
+#include <linux/bpf.h>
+#include <linux/verification.h>
+#include <crypto/public_key.h>
+#include <linux/module_signature.h>
+#include <crypto/pkcs7.h>
+#include <linux/sort.h>
+#include <linux/asn1_decoder.h>
+#include <linux/oid_registry.h>
+#include "hornet.asn1.h"
+
+#define MAX_USED_MAPS 64
+
+struct hornet_maps {
+	bpfptr_t fd_array;
+};
+
+struct hornet_parse_context {
+	size_t indexes[MAX_USED_MAPS];
+	bool skips[MAX_USED_MAPS];
+	unsigned char hashes[SHA256_DIGEST_SIZE * MAX_USED_MAPS];
+	int hash_count;
+};
+
+static int hornet_verify_hashes(struct hornet_maps *maps,
+				struct hornet_parse_context *ctx)
+{
+	int map_fd;
+	u32 i;
+	struct bpf_map *map;
+	int err = 0;
+	unsigned char hash[SHA256_DIGEST_SIZE];
+
+	for (i = 0; i < ctx->hash_count; i++) {
+		if (ctx->skips[i])
+			continue;
+
+		err = copy_from_bpfptr_offset(&map_fd, maps->fd_array,
+					      ctx->indexes[i] * sizeof(map_fd),
+					      sizeof(map_fd));
+		if (err < 0)
+			return LSM_INT_VERDICT_BADSIG;
+
+		CLASS(fd, f)(map_fd);
+		if (fd_empty(f))
+			return LSM_INT_VERDICT_BADSIG;
+		if (unlikely(fd_file(f)->f_op != &bpf_map_fops))
+			return LSM_INT_VERDICT_BADSIG;
+
+		if (!map->frozen)
+			return LSM_INT_VERDICT_BADSIG;
+
+		map = fd_file(f)->private_data;
+		map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, hash);
+
+		err = (memcmp(hash, &ctx->hashes[ctx->indexes[i] * SHA256_DIGEST_SIZE],
+			      SHA256_DIGEST_SIZE));
+		if (!err)
+			return LSM_INT_VERDICT_BADSIG;
+	}
+	return LSM_INT_VERDICT_OK;
+}
+
+int hornet_next_map(void *context, size_t hdrlen,
+		     unsigned char tag,
+		     const void *value, size_t vlen)
+{
+	struct hornet_parse_context *ctx = (struct hornet_parse_context *)value;
+
+	ctx->hash_count++;
+	return 0;
+}
+
+
+int hornet_map_index(void *context, size_t hdrlen,
+		     unsigned char tag,
+		     const void *value, size_t vlen)
+{
+	struct hornet_parse_context *ctx = (struct hornet_parse_context *)value;
+
+	ctx->hashes[ctx->hash_count] = *(int *)value;
+	return 0;
+}
+
+int hornet_map_hash(void *context, size_t hdrlen,
+		    unsigned char tag,
+		    const void *value, size_t vlen)
+
+{
+	struct hornet_parse_context *ctx = (struct hornet_parse_context *)value;
+
+	if (vlen != SHA256_DIGEST_SIZE && vlen != 0)
+		return -EINVAL;
+
+	if (vlen != 0) {
+		ctx->skips[ctx->hash_count] = false;
+		memcpy(&ctx->hashes[ctx->hash_count * SHA256_DIGEST_SIZE], value, vlen);
+	} else
+		ctx->skips[ctx->hash_count] = true;
+
+	return 0;
+}
+
+static int hornet_check_program(struct bpf_prog *prog, union bpf_attr *attr,
+				struct bpf_token *token, bool is_kernel)
+{
+	struct hornet_maps maps = {0};
+	bpfptr_t usig = make_bpfptr(attr->signature, is_kernel);
+	struct pkcs7_message *msg;
+	struct hornet_parse_context *ctx;
+	void *sig;
+	int err;
+	const void *authattrs;
+	size_t authattrs_len;
+
+	if (!attr->signature)
+		return LSM_INT_VERDICT_UNSIGNED;
+
+	ctx = kzalloc(sizeof(struct hornet_parse_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	maps.fd_array = make_bpfptr(attr->fd_array, is_kernel);
+	sig = kzalloc(attr->signature_size, GFP_KERNEL);
+	if (!sig) {
+		err = -ENOMEM;
+		goto out;
+	}
+	err = copy_from_bpfptr(sig, usig, attr->signature_size);
+	if (err != 0)
+		goto out;
+
+	msg = pkcs7_parse_message(sig, attr->signature_size);
+	if (IS_ERR(msg)) {
+		err = LSM_INT_VERDICT_BADSIG;
+		goto out;
+	}
+
+	if (validate_pkcs7_trust(msg, VERIFY_USE_SECONDARY_KEYRING)) {
+		err = LSM_INT_VERDICT_PARTIALSIG;
+		goto out;
+	}
+	if (pkcs7_get_authattr(msg, OID_hornet_data,
+			       &authattrs, &authattrs_len) == -ENODATA) {
+		err = LSM_INT_VERDICT_PARTIALSIG;
+		goto out;
+	}
+
+	err = asn1_ber_decoder(&hornet_decoder, ctx, authattrs, authattrs_len);
+	if (err < 0 || authattrs == NULL) {
+		err = LSM_INT_VERDICT_PARTIALSIG;
+		goto out;
+	}
+	err = hornet_verify_hashes(&maps, ctx);
+out:
+	kfree(ctx);
+	return err;
+}
+
+static const struct lsm_id hornet_lsmid = {
+	.name = "hornet",
+	.id = LSM_ID_HORNET,
+};
+
+static int hornet_bpf_prog_load_integrity(struct bpf_prog *prog, union bpf_attr *attr,
+					  struct bpf_token *token, bool is_kernel)
+{
+	int result = hornet_check_program(prog, attr, token, is_kernel);
+
+	if (result < 0)
+		return result;
+
+	return security_bpf_prog_load_post_integrity(prog, attr, token, is_kernel,
+						     &hornet_lsmid, result);
+}
+
+static struct security_hook_list hornet_hooks[] __ro_after_init = {
+	LSM_HOOK_INIT(bpf_prog_load_integrity, hornet_bpf_prog_load_integrity),
+};
+
+static int __init hornet_init(void)
+{
+	pr_info("Hornet: eBPF signature verification enabled\n");
+	security_add_hooks(hornet_hooks, ARRAY_SIZE(hornet_hooks), &hornet_lsmid);
+	return 0;
+}
+
+DEFINE_LSM(hornet) = {
+	.name = "hornet",
+	.init = hornet_init,
+};
-- 
2.52.0


