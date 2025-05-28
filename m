Return-Path: <bpf+bounces-59196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE378AC72F9
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 23:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F953B65C6
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 21:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4006B22172B;
	Wed, 28 May 2025 21:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lETjtr8y"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3148B221268;
	Wed, 28 May 2025 21:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748469053; cv=none; b=bUWifxK3ctBYmQec0bprgdH/kWUNt8V6vCybeSh2YHdNlKhZQxKjsPCFl/ibmmOn8w96HBH2hn3b81Mfi0WoPHPb1Qxe/XFLqYz22JUishTjV1WfXYnrLfPMrkcDTQB2PK+vb4HmoGyAyX397QvJ2iHwrxfPZRPQuFdx2eZj9fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748469053; c=relaxed/simple;
	bh=rDkEcxMkbT0DuRk/YrqYeaewibwN4ZOIrRLRLt+cS3M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgKxYV49JR/O7p7L7lYi9HYTEGnSIgS+a65MQJzeHMjfb+AUbtkAKAj9CKvsl5z8P6fIxU51yMNkzGtjB7DH9crrhLStWlGYW3c2kLm5qTovw14uzcFHS8Qva6wzznqYz8BQ6Sq2ziHrJsbtgN9NiYqnnjNeUE6b6uZ0MtfktxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lETjtr8y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8E43A2068337;
	Wed, 28 May 2025 14:50:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8E43A2068337
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748469051;
	bh=T5/5RHou0NeTf3Q95/w/eEbUSGteDobbOkyPaHO3kaU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lETjtr8y/qfQwCdFbafxuIwVDkxAcafRHrh2HZYGD2Su4s6eVafBnwoZPoQKVFdFN
	 rsvPdte1aQ83hOKiG8y4YR5M09U3jS8V2o0AOaU05zQWtTvRuCJYCiHWwmZz6yLAp7
	 gzHeS2r7yfalR2WgLjlOjdKG8nrKj+7v+t9qYlCE=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Paul Moore <paul@paul-moore.com>,
	bboscaccy@linux.microsoft.com,
	jarkko@kernel.org,
	zeffron@riotgames.com,
	xiyou.wangcong@gmail.com,
	kysrinivasan@gmail.com,
	code@tyhicks.com,
	linux-security-module@vger.kernel.org,
	roberto.sassu@huawei.com,
	James.Bottomley@hansenpartnership.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Quentin Monnet <qmo@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	Jordan Rome <linux@jordanrome.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Matteo Croce <teknoraver@meta.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH 1/3] bpf: Add bpf_check_signature
Date: Wed, 28 May 2025 14:49:03 -0700
Message-ID: <20250528215037.2081066-2-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>
References: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This introduces signature verification for eBPF programs inside of the
bpf subsystem. Two signature validation schemes are included, one that
only checks the instruction buffer, and another that checks over a
hash chain constructed from the program and a list of maps. The
alternative algorithm is designed to provide support to scenarios
where having self-aborting light-skeletons or signature checking
living outside the kernel-proper is insufficient or undesirable.

An abstract hash method is introduced to allow calculating the hash of
maps, only arrays are implemented at this time.

A simple UAPI is introduced to provide passing signature information.

The signature check is performed before the call to
security_bpf_prog_load. This allows the LSM subsystem to be clued into
the result of the signature check, whilst granting knowledge of the
method and apparatus which was employed.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 include/linux/bpf.h            |   2 +
 include/linux/verification.h   |   1 +
 include/uapi/linux/bpf.h       |   4 ++
 kernel/bpf/arraymap.c          |  11 ++-
 kernel/bpf/syscall.c           | 123 ++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |   4 ++
 6 files changed, 143 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3f0cc89c0622..298e0db34c28 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -109,6 +109,7 @@ struct bpf_map_ops {
 	long (*map_pop_elem)(struct bpf_map *map, void *value);
 	long (*map_peek_elem)(struct bpf_map *map, void *value);
 	void *(*map_lookup_percpu_elem)(struct bpf_map *map, void *key, u32 cpu);
+	int (*map_get_hash)(struct bpf_map *map, u8 *out);
 
 	/* funcs called by prog_array and perf_event_array map */
 	void *(*map_fd_get_ptr)(struct bpf_map *map, struct file *map_file,
@@ -1592,6 +1593,7 @@ struct bpf_prog_aux {
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
+	bool signature_verified;
 	struct bpf_token *token;
 	struct bpf_prog_offload *offload;
 	struct btf *btf;
diff --git a/include/linux/verification.h b/include/linux/verification.h
index 4f3022d081c3..812be8ad5f74 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -35,6 +35,7 @@ enum key_being_used_for {
 	VERIFYING_KEXEC_PE_SIGNATURE,
 	VERIFYING_KEY_SIGNATURE,
 	VERIFYING_KEY_SELF_SIGNATURE,
+	VERIFYING_EBPF_SIGNATURE,
 	VERIFYING_UNSPECIFIED_SIGNATURE,
 	NR__KEY_BEING_USED_FOR
 };
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fd404729b115..f79af999c480 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1587,6 +1587,10 @@ union bpf_attr {
 		 * continuous.
 		 */
 		__u32		fd_array_cnt;
+		__aligned_u64	signature;	/* program signature */
+		__u32		signature_size;	/* size of program signature */
+		__aligned_u64	signature_maps;	/* maps used in signature */
+		__u32		signature_maps_size;	/* size of maps used in signature */
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index eb28c0f219ee..5459ab6bf6e2 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -12,6 +12,7 @@
 #include <uapi/linux/btf.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/btf_ids.h>
+#include <crypto/sha2.h>
 
 #include "map_in_map.h"
 
@@ -426,6 +427,14 @@ static long array_map_delete_elem(struct bpf_map *map, void *key)
 	return -EINVAL;
 }
 
+static int array_map_get_hash(struct bpf_map *map, u8 *out)
+{
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
+
+	sha256(array->value, array->elem_size * array->map.max_entries, out);
+	return 0;
+}
+
 static void *array_map_vmalloc_addr(struct bpf_array *array)
 {
 	return (void *)round_down((unsigned long)array, PAGE_SIZE);
@@ -792,6 +801,7 @@ const struct bpf_map_ops array_map_ops = {
 	.map_lookup_elem = array_map_lookup_elem,
 	.map_update_elem = array_map_update_elem,
 	.map_delete_elem = array_map_delete_elem,
+	.map_get_hash = array_map_get_hash,
 	.map_gen_lookup = array_map_gen_lookup,
 	.map_direct_value_addr = array_map_direct_value_addr,
 	.map_direct_value_meta = array_map_direct_value_meta,
@@ -940,7 +950,6 @@ static long fd_array_map_delete_elem(struct bpf_map *map, void *key)
 {
 	return __fd_array_map_delete_elem(map, key, true);
 }
-
 static void *prog_fd_array_get_ptr(struct bpf_map *map,
 				   struct file *map_file, int fd)
 {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 64c3393e8270..7dc35681d3f8 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -36,6 +36,8 @@
 #include <linux/memcontrol.h>
 #include <linux/trace_events.h>
 #include <linux/tracepoint.h>
+#include <crypto/pkcs7.h>
+#include <crypto/sha2.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 #include <net/netkit.h>
@@ -2216,6 +2218,15 @@ static int map_freeze(const union bpf_attr *attr)
 	return err;
 }
 
+static int __map_get_hash(struct bpf_map *map, u8 *out)
+{
+	if (map->ops->map_get_hash) {
+		map->ops->map_get_hash(map, out);
+		return 0;
+	}
+	return -EINVAL;
+}
+
 static const struct bpf_prog_ops * const bpf_prog_types[] = {
 #define BPF_PROG_TYPE(_id, _name, prog_ctx_type, kern_ctx_type) \
 	[_id] = & _name ## _prog_ops,
@@ -2753,8 +2764,113 @@ static bool is_perfmon_prog_type(enum bpf_prog_type prog_type)
 	}
 }
 
+static int bpf_check_signature(struct bpf_prog *prog, union bpf_attr *attr, bpfptr_t uattr,
+			       __u32 uattr_size)
+{
+	u64 hash[4];
+	u64 buffer[8];
+	int err;
+	char *signature;
+	int *used_maps;
+	int n;
+	int map_fd;
+	struct bpf_map *map;
+
+	if (!attr->signature)
+		return 0;
+
+	signature = kmalloc(attr->signature_size, GFP_KERNEL);
+	if (!signature) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	if (copy_from_bpfptr(signature,
+			     make_bpfptr(attr->signature, uattr.is_kernel),
+			     attr->signature_size) != 0) {
+		err = -EINVAL;
+		goto free_sig;
+	}
+
+	if (!attr->signature_maps_size) {
+		sha256((u8 *)prog->insnsi, prog->len * sizeof(struct bpf_insn), (u8 *)&hash);
+		err = verify_pkcs7_signature(hash, sizeof(hash), signature, attr->signature_size,
+				     VERIFY_USE_SECONDARY_KEYRING,
+				     VERIFYING_EBPF_SIGNATURE,
+				     NULL, NULL);
+	} else {
+		used_maps = kmalloc_array(attr->signature_maps_size,
+					  sizeof(*used_maps), GFP_KERNEL);
+		if (!used_maps) {
+			err = -ENOMEM;
+			goto free_sig;
+		}
+		n = attr->signature_maps_size;
+		n--;
+
+		err = copy_from_bpfptr_offset(&map_fd, make_bpfptr(attr->fd_array, uattr.is_kernel),
+					      used_maps[n] * sizeof(map_fd),
+					      sizeof(map_fd));
+		if (err < 0)
+			goto free_maps;
+
+		/* calculate the terminal hash */
+		CLASS(fd, f)(map_fd);
+		map = __bpf_map_get(f);
+		if (IS_ERR(map)) {
+			err = PTR_ERR(map);
+			goto free_maps;
+		}
+		if (__map_get_hash(map, (u8 *)hash)) {
+			err = -EINVAL;
+			goto free_maps;
+		}
+
+		n--;
+		/* calculate a link in the hash chain */
+		while (n >= 0) {
+			memcpy(buffer, hash, sizeof(hash));
+			err = copy_from_bpfptr_offset(&map_fd,
+						      make_bpfptr(attr->fd_array, uattr.is_kernel),
+						      used_maps[n] * sizeof(map_fd),
+						      sizeof(map_fd));
+			if (err < 0)
+				goto free_maps;
+
+			CLASS(fd, f)(map_fd);
+			map = __bpf_map_get(f);
+			if (!map) {
+				err = -EINVAL;
+				goto free_maps;
+			}
+			if (__map_get_hash(map, (u8 *)buffer+4)) {
+				err = -EINVAL;
+				goto free_maps;
+			}
+			sha256((u8 *)buffer, sizeof(buffer), (u8 *)&hash);
+			n--;
+		}
+		/* calculate the root hash and verify it's signature */
+		sha256((u8 *)prog->insnsi, prog->len * sizeof(struct bpf_insn), (u8 *)&buffer);
+		memcpy(buffer+4, hash, sizeof(hash));
+		sha256((u8 *)buffer, sizeof(buffer), (u8 *)&hash);
+		err = verify_pkcs7_signature(hash, sizeof(hash), signature, attr->signature_size,
+				     VERIFY_USE_SECONDARY_KEYRING,
+				     VERIFYING_EBPF_SIGNATURE,
+				     NULL, NULL);
+free_maps:
+		kfree(used_maps);
+	}
+
+free_sig:
+	kfree(signature);
+out:
+	prog->aux->signature_verified = !err;
+	return err;
+}
+
 /* last field in 'union bpf_attr' used by this command */
-#define BPF_PROG_LOAD_LAST_FIELD fd_array_cnt
+#define BPF_PROG_LOAD_LAST_FIELD signature_maps_size
 
 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 {
@@ -2963,6 +3079,11 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (err < 0)
 		goto free_prog;
 
+	/* run eBPF signature verifier */
+	err = bpf_check_signature(prog, attr, uattr, uattr_size);
+	if (err < 0)
+		goto free_prog;
+
 	err = security_bpf_prog_load(prog, attr, token, uattr.is_kernel);
 	if (err)
 		goto free_prog_sec;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index fd404729b115..f79af999c480 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1587,6 +1587,10 @@ union bpf_attr {
 		 * continuous.
 		 */
 		__u32		fd_array_cnt;
+		__aligned_u64	signature;	/* program signature */
+		__u32		signature_size;	/* size of program signature */
+		__aligned_u64	signature_maps;	/* maps used in signature */
+		__u32		signature_maps_size;	/* size of maps used in signature */
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
-- 
2.48.1


