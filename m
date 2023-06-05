Return-Path: <bpf+bounces-1802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B750722192
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 10:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513DF28106B
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 08:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AA7134BB;
	Mon,  5 Jun 2023 08:58:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC4B804
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 08:58:00 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51B3F9
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 01:57:55 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-19f6f8c840bso4201871fac.3
        for <bpf@vger.kernel.org>; Mon, 05 Jun 2023 01:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685955474; x=1688547474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yr9w2hx0Rh4MSELa+IlUgqxHDwHcjrmMrU/nMrZgcfc=;
        b=pFBrOWeDZzQ+kZmWeRMpiiCKbYl+NtordZHubS0XSsNSe9qFefUafyCGMNg3vL1Kl9
         8BgE9clD8fyOFGhnYvqMo9RuhJBfhozBV/cZdJ7zUQaSU4w3ai/Jr8KifPFtJwcsfngQ
         81itgdrEyImTYADE4OYaHOmwSWtF/AwWNQkzvBtdA0yQqKmqMyfLJMvl45rq98I8ywFw
         tF8K36X20Zy6yQJFgLQdLzYENrv8VxUc+firN3xH4lKwoySyW7jC2RrYOcvdztwnkSHa
         kHr1hkutybcU6hbww8bcnP4dXkeuTaQbF2J8Zn9p4JhC+etx0qwe4TVHKfqhAeOUQmCM
         HzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685955474; x=1688547474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yr9w2hx0Rh4MSELa+IlUgqxHDwHcjrmMrU/nMrZgcfc=;
        b=ICOOGXbaVQEUvB1Z0EjKtILUkgEk9oz9fszoaIM7dxFf98skqYe4YMweaQqLwLZuZf
         WRmnRcX+cu+5G48QlrBExBf//CkURhSDJY03cucx/nvOU9UNONwVaShM5ATtY1eEX1DK
         swCai0xDt/7TkPUXOKC2amziLz7GeN8ZDTwplcS8sDf7Ui6yCm6XaUMfRu53H4Dgcq7s
         LhHh6EABY1Hal+YQfugrNOKxTtxgWo8vi8SsOXm7zbKPCSkWv+kx/cRHfUpAgDx7c2G5
         XJhklzi1qVfZrUf3nGzQjQWLY2BaatTwwSnpLq+mayndwBOyJLpRCLU8EfU5kqXdG71F
         KX+w==
X-Gm-Message-State: AC+VfDzfEbZ0g/ij4vpX7rKaV9xgQhqsHg/+PF0d7QdhT999QazRgCGv
	lv7cSf0onNopMxTsOX0dKrvYMT7hTsvW3Q==
X-Google-Smtp-Source: ACHHUZ7eWDw+kQC56qD0LHVf5mDqhgeJR/2gAiSFiDj51Ngtg62lwn1dnSddwo9WQFWqwAgtLxUP4g==
X-Received: by 2002:a05:6358:4e86:b0:128:35ec:587c with SMTP id ce6-20020a0563584e8600b0012835ec587cmr2096546rwb.4.1685955474157;
        Mon, 05 Jun 2023 01:57:54 -0700 (PDT)
Received: from localhost.localdomain ([120.26.165.80])
        by smtp.gmail.com with ESMTPSA id mv7-20020a17090b198700b0024dfb8271a4sm5503901pjb.21.2023.06.05.01.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 01:57:53 -0700 (PDT)
From: Yang Bo <yyyeer.bo@gmail.com>
X-Google-Original-From: Yang Bo <yb203166@antfin.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	Yang Bo <bo@hyper.sh>
Subject: [PATCH 1/2] Add api to manipulate global variable
Date: Mon,  5 Jun 2023 16:57:32 +0800
Message-Id: <20230605085733.1833-2-yb203166@antfin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605085733.1833-1-yb203166@antfin.com>
References: <20230605085733.1833-1-yb203166@antfin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yang Bo <bo@hyper.sh>

implement function.
refactor code.

Signed-off-by: Yang Bo <bo@hyper.sh>
---
 tools/lib/bpf/bpf.c      | 808 +++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/bpf.h      |   9 +
 tools/lib/bpf/libbpf.map |   2 +
 3 files changed, 819 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 128ac723c4ea..3b6ff6508712 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -26,10 +26,12 @@
 #include <memory.h>
 #include <unistd.h>
 #include <asm/unistd.h>
+#include <asm/byteorder.h>
 #include <errno.h>
 #include <linux/bpf.h>
 #include <linux/filter.h>
 #include <linux/kernel.h>
+#include <linux/bitops.h>
 #include <limits.h>
 #include <sys/resource.h>
 #include "bpf.h"
@@ -1190,3 +1192,809 @@ int bpf_prog_bind_map(int prog_fd, int map_fd,
 	ret = sys_bpf(BPF_PROG_BIND_MAP, &attr, attr_sz);
 	return libbpf_err_errno(ret);
 }
+
+
+#define BITS_PER_BYTE_MASK (BITS_PER_BYTE - 1)
+#define BITS_PER_BYTE_MASKED(bits) ((bits) & BITS_PER_BYTE_MASK)
+#define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
+#define BITS_ROUNDUP_BYTES(bits) \
+    (BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
+
+static struct btf *bpf_map_get_btf(const struct bpf_map_info *info)
+{
+	struct btf *btf, *btf_vmlinux = NULL;
+
+	if (info->btf_vmlinux_value_type_id) {
+		btf_vmlinux = libbpf_find_kernel_btf();
+		if (!btf_vmlinux) {
+			pr_debug("cannot find kernel btf");
+			return NULL;
+		}
+
+		return btf_vmlinux;
+	}
+
+	if (info->btf_value_type_id) {
+		btf = btf__load_from_kernel_by_id(info->btf_id);
+		if (!btf) {
+			pr_debug("cannot load btf");
+			return NULL;
+		}
+
+		return btf;
+	}
+
+	return NULL;
+}
+
+static void bpf_map_free_btf(struct btf * btf)
+{
+	btf__free(btf);
+}
+
+static struct member *btf_handle_bitfield(__u32 nr_bits, __u8 bit_offset, void * data, bool update, const char *value);
+static struct member *search_key(struct btf *btf, __u32 id, __u8 bit_offset,  void *data, char *keyword, bool update, const char *value, int index);
+
+static struct member *btf_handle_int_bits(__u32 int_type, __u8 bit_offset, void *data, bool update, const char *value) {
+	int nr_bits = BTF_INT_BITS(int_type);
+	int total_bits_offset;
+
+	/* bits_offset is at most 7.
+	 * BTF_INT_OFFSET() cannot exceed 128 bits.
+	 */
+	total_bits_offset = bit_offset + BTF_INT_OFFSET(int_type);
+	data += BITS_ROUNDDOWN_BYTES(total_bits_offset);
+	bit_offset = BITS_PER_BYTE_MASKED(total_bits_offset);
+	return btf_handle_bitfield(nr_bits, bit_offset, data, update, value);
+}
+
+static struct member *btf_handle_int(struct btf *btf, __u32 id, __u8 bit_offset, void *data, char *keyword, bool update, const char *value, int index) {
+	const struct btf_type *t = btf__type_by_id(btf, id);
+	long long v;
+	char *end;
+	bool vv = false, vv1 = false;
+
+	printf("int\n");
+
+	if (index >= 0) {
+		pr_debug("index on primitive type, only on array");
+		errno = EINVAL;
+		return NULL;
+	}
+
+	if (keyword == NULL) {
+		__u32 *int_type;
+		__u32 nr_bits;
+		int encoding;
+		size_t size;
+		struct member *member;
+
+		int_type = (__u32 *)(t + 1);
+		nr_bits = BTF_INT_BITS(*int_type);
+
+		// don't support bits for now
+		if (bit_offset || BTF_INT_OFFSET(*int_type) || BITS_PER_BYTE_MASKED(nr_bits)) {
+			return btf_handle_int_bits(*int_type, bit_offset, data, update, value);
+		}
+
+		encoding = BTF_INT_ENCODING(*int_type);
+		size = BITS_ROUNDUP_BYTES(nr_bits);
+
+		member = malloc(sizeof(struct member));
+		if (!member) {
+			pr_debug("can not alloc member for int");
+			errno = ENOMEM;
+			return NULL;
+		}
+
+		member->data = malloc(size);
+		if (!member->data) {
+			free(member);
+			pr_debug("cannot alloc data field");
+			errno = ENOMEM;
+			return NULL;
+		}
+
+		member->type = BTF_KIND_INT;
+		member->size = nr_bits;
+
+		switch (encoding) {
+			case 0:
+			case BTF_INT_SIGNED:
+				if (nr_bits == 64 || nr_bits == 32 || nr_bits == 16 || nr_bits == 8) {
+					size = nr_bits / 8;
+					memcpy(member->data, data, size);
+				} else {
+					//handle bits
+					free(member->data);
+					free(member);
+					return btf_handle_int_bits(*int_type, bit_offset, data, update, value);
+				}
+
+				// update for non-bits int
+				if (update) {
+					errno = 0;
+					v = strtoll(value, &end, 0);
+					if (errno || value == end) {
+						pr_debug("can not convert to long long");
+						goto free_data;
+					}
+
+					if (*end != '\0') {
+						pr_debug("value contains non-digits");
+					}
+
+#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN : defined(__BIG_ENDIAN)
+					printf("big endian?\n");
+					memcpy(data, (void *)&v + 8 - size, size);
+#else
+					memcpy(data, &v, size);
+#endif
+				}
+
+				return member;
+
+			case BTF_INT_CHAR:
+				memcpy(member->data, data, size);
+				if (update) {
+					if (strlen(value) == 1) {
+						*(char *)data = value[0];
+					} else {
+						pr_debug("invalid char");
+						errno = EINVAL;
+						goto free_data;
+					}
+				}
+				return member;
+
+			case BTF_INT_BOOL:
+				memcpy(member->data, data, size);
+				if (update) {
+					vv = strcasecmp(value, "yes") == 0 || strcasecmp(value, "y") == 0 || strcasecmp(value, "true") == 0 || strcasecmp(value, "1") == 0;
+					vv1 = strcasecmp(value, "no") == 0 || strcasecmp(value, "n") == 0 || strcasecmp(value, "false") == 0 || strcasecmp(value, "0") == 0;
+					if (!vv && !vv1) {
+						pr_debug("invalid bool");
+						errno = EINVAL;
+						goto free_data;
+					}
+
+					*(bool *)data = vv;
+				}
+				return member;
+
+			default:
+				pr_debug("unknown encoding");
+				errno = EINVAL;
+				goto free_data;
+		}
+
+		return member;
+
+	free_data:
+		free(member->data);
+		free(member);
+		return NULL;
+	}
+
+	pr_debug("primitive type found, still remain keyword");
+	errno = EINVAL;
+	return NULL;
+}
+
+static void btf_int128_shift(__u64 *print_num, __u16 left_shift_bits,
+			     __u16 right_shift_bits)
+{
+	__u64 upper_num, lower_num;
+
+#ifdef __BIG_ENDIAN_BITFIELD
+	upper_num = print_num[0];
+	lower_num = print_num[1];
+#else
+	upper_num = print_num[1];
+	lower_num = print_num[0];
+#endif
+
+	/* shake out un-needed bits by shift/or operations */
+	if (left_shift_bits > 0) {
+		if (left_shift_bits >= 64) {
+			upper_num = lower_num << (left_shift_bits - 64);
+			lower_num = 0;
+		} else {
+			upper_num = (upper_num << left_shift_bits) |
+			    (lower_num >> (64 - left_shift_bits));
+			lower_num = lower_num << left_shift_bits;
+		}
+	}
+
+	if (right_shift_bits > 0) {
+		if (right_shift_bits >= 64) {
+			lower_num = upper_num >> (right_shift_bits - 64);
+			upper_num = 0;
+		} else {
+			lower_num = (lower_num >> right_shift_bits) |
+			    (upper_num << (64 - right_shift_bits));
+			upper_num = upper_num >> right_shift_bits;
+		}
+	}
+
+#ifdef __BIG_ENDIAN_BITFIELD
+	print_num[0] = upper_num;
+	print_num[1] = lower_num;
+#else
+	print_num[0] = lower_num;
+	print_num[1] = upper_num;
+#endif
+}
+
+static void update_bitfield_value(void *data, __u64 *mask, __u64 *val, int bytes_to_copy) {
+	__u64 new[2] = {};
+
+	memcpy(new, data, bytes_to_copy);
+
+	printf("mask: %llx, %llx\n", mask[0], mask[1]);
+	printf("val: %llx, %llx\n", val[0], val[1]);
+
+	new[0] &= mask[0];
+	new[1] &= mask[1];
+	printf("old: %llx, %llx\n", new[0], new[1]);
+
+	new[0] |= val[0];
+	new[1] |= val[1];
+	printf("new: %llx, %llx\n", new[0], new[1]);
+
+	memcpy(data, new, bytes_to_copy);
+}
+
+static struct member *btf_handle_bitfield(__u32 nr_bits, __u8 bit_offset, void *data, bool update, const char *value) {
+	int left_shift_bits, right_shift_bits;
+	int left_shift_bits2;
+	__u64 print_num[2] = {};
+	__u64 mask[2] = {0xffffffffffffffff, 0xffffffffffffffff};
+	int bytes_to_copy;
+	int bits_to_copy;
+	struct member *ret;
+
+	bits_to_copy = bit_offset + nr_bits;
+	bytes_to_copy = BITS_ROUNDUP_BYTES(bits_to_copy);
+
+	memcpy(print_num, data, bytes_to_copy);
+
+#if defined(__BIG_ENDIAN_BITFIELD)
+	left_shift_bits = bit_offset;
+	left_shift_bits2 = 128 - bits_to_copy;
+#elif defined(__LITTLE_ENDIAN_BITFIELD)
+	left_shift_bits = 128 - bits_to_copy;
+	left_shift_bits2 = bit_offset;
+#else
+#error neither big nor little endian
+#endif
+	right_shift_bits = 128 - nr_bits;
+
+	printf("left: %d, right: %d, left2: %d\n", left_shift_bits, right_shift_bits, left_shift_bits2);
+
+	btf_int128_shift(print_num, left_shift_bits, right_shift_bits);
+
+	btf_int128_shift(mask, left_shift_bits, right_shift_bits);
+	printf("revert mask: %llx, %llx\n", mask[0], mask[1]);
+	btf_int128_shift(mask, left_shift_bits2, 0);
+	printf("revert mask2: %llx, %llx\n", mask[0], mask[1]);
+	mask[0] = ~mask[0];
+	mask[1] = ~mask[1];
+
+	ret = malloc(sizeof(struct member));
+	if (!ret) {
+		pr_debug("no memory!");
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	ret->data = malloc(bytes_to_copy);
+	if (!ret->data) {
+		pr_debug("no memory!");
+		errno = ENOMEM;
+		return NULL;
+	}
+
+	memcpy(ret->data, print_num, bytes_to_copy);
+	ret->type = BTF_KIND_INT;
+	ret->size = nr_bits; // size in bits
+
+	if (update) {
+		long long val;
+		char *end;
+		__u64 tmp[2] = {};
+
+		errno = 0;
+		val = strtoll(value, &end, 0);
+		if (errno || value == end) {
+			pr_debug("cannot convert string to int!");
+			free(ret->data);
+			free(ret);
+			return NULL;
+		}
+
+		if (*end != '\0') {
+			pr_debug("value has non-digits!");
+		}
+		printf("value in bitfield: %lld\n", val);
+#ifdef __BIG_ENDIAN_BITFIELD
+		tmp[1] = val;
+#else
+		tmp[0] = val;
+#endif
+		//btf_int128_shift(tmp, left_shift_bits, right_shift_bits);
+		btf_int128_shift(tmp, left_shift_bits2, 0);
+		tmp[0] &= ~mask[0];
+		tmp[1] &= ~mask[1];
+
+		update_bitfield_value(data, mask, tmp, bytes_to_copy);
+	}
+
+	return ret;
+}
+
+static struct member *btf_handle_struct_and_union(struct btf *btf, __u32 id, __u8 pre_bit_offset, void *data, char *keyword, bool update, const char *value, char *token, int index) {
+	const struct btf_type *t = btf__type_by_id(btf, id);
+	int kind_flag, vlen, i;
+	struct btf_member *m;
+	const char *name;
+	void *data_off;
+
+	printf("struct\n");
+
+	kind_flag = BTF_INFO_KFLAG(t->info);
+	vlen = BTF_INFO_VLEN(t->info);
+	m = (struct btf_member *)(t + 1);
+
+	for (i = 0; i < vlen; i++) {
+		__u32 bitfield_size = 0;
+		__u8 offset = 0;
+		__u32 bit_offset = m[i].offset;
+
+		if (kind_flag) {
+			bitfield_size = BTF_MEMBER_BITFIELD_SIZE(bit_offset);
+			bit_offset = BTF_MEMBER_BIT_OFFSET(bit_offset);
+		}
+		name = btf__name_by_offset(btf, m[i].name_off);
+		data_off = data + BITS_ROUNDDOWN_BYTES(bit_offset);
+		offset = BITS_PER_BYTE_MASKED(bit_offset);
+
+		printf("name: %s, kind_flag: %d, bitfield_size: %d, m[i].offset: %x\n", name, kind_flag, bitfield_size, m[i].offset);
+
+		if (strcmp(name, token) == 0) {
+			if (bitfield_size) {
+				// already here, calculate and copy bits out
+				if (index >= 0) {
+					pr_debug("index on primitive type, only on array");
+					errno = EINVAL;
+					return NULL;
+				}
+
+				if (keyword) {
+					pr_debug("primitive type found, still remain keyword");
+					errno = EINVAL;
+					return NULL;
+				}
+				return btf_handle_bitfield(bitfield_size, offset, data_off, update, value);
+			} else {
+				return search_key(btf, m[i].type, offset, data_off, keyword, update, value, index);
+			}
+		}
+	}
+
+	return NULL;
+}
+
+static struct member *btf_handle_array(struct btf *btf, __u32 id, __u8 bit_offset, void *data, char *keyword, bool update, const char *value, int index) {
+	// FIXME: implement array
+	const struct btf_type *t;
+	struct btf_array *arr;
+	long long elem_size;
+
+	printf("array\n");
+	if (index < 0) {
+		pr_debug("index array with negative index!");
+		errno = EINVAL;
+		return NULL;
+	}
+
+	t = btf__type_by_id(btf, id);
+	arr = (struct btf_array *)(t + 1);
+	elem_size = btf__resolve_size(btf, arr->type);
+	if (elem_size < 0) {
+		pr_debug("array element size less than 0!");
+		errno = EINVAL;
+		return NULL;
+	}
+
+	if (index >= arr->nelems) {
+		pr_debug("index out of range, max: %d", arr->nelems - 1);
+		errno = EINVAL;
+		return NULL;
+	}
+
+	return search_key(btf, arr->type, bit_offset, data + index * elem_size, keyword, update, value, -1);
+}
+
+static struct member *btf_handle_enum(struct btf *btf, __u32 id, __u8 bit_offset, void *data, char *keyword, bool update, const char *value, int index) {
+	const struct btf_type *t = btf__type_by_id(btf, id);
+	int kind = btf_kind(t);
+
+	// FIXME: byteorder consideration. little endian is ok, but
+	// probably not work for big endian.
+	printf("enum\n");
+	if (index >= 0) {
+		errno = EINVAL;
+		return NULL;
+	}
+
+	if (keyword == NULL) {
+		struct member *member = malloc(sizeof(struct member));
+
+		if (!member) {
+			pr_debug("cannot allocate memory");
+			errno = ENOMEM;
+			return NULL;
+		}
+
+		member->data = malloc(t->size);
+		if (!member->data) {
+			free(member);
+			pr_debug("cannot allocate dat memory");
+			errno = ENOMEM;
+			return NULL;
+		}
+
+		memcpy(member->data, data, t->size);
+		if (kind == BTF_KIND_ENUM) {
+			member->type = BTF_KIND_ENUM;
+		} else {
+			member->type = BTF_KIND_ENUM64;
+		}
+		member->size = t->size * 8; // to bits
+
+		if (update) {
+			char *end;
+			long long v;
+
+			errno = 0;
+			v = strtoll(value, &end, 0);
+
+			if (errno || value == end) {
+				pr_debug("can not convert to number");
+				free(member->data);
+				free(member);
+				return NULL;
+			}
+
+			if (*end != '\0') {
+				pr_debug("value contains non-digits");
+			}
+
+#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN : defined(__BIG_ENDIAN)
+			memcpy(data, (void *)&v + 8 - t->size, t->size);
+#else
+			memcpy(data, &v, t->size);
+#endif
+		}
+
+		return member;
+	}
+
+	pr_debug("primitive type found, still have keyword");
+	errno = EINVAL;
+	return NULL;
+}
+
+static struct member *btf_handle_modifier(struct btf *btf, __u32 id, __u8 bit_offset, void *data, char *keyword, bool update, const char *value, int index) {
+	
+	int actual_type_id;
+	printf("modifier\n");
+
+	actual_type_id = btf__resolve_type(btf, id);
+	if (actual_type_id < 0) {
+		return NULL;
+	}
+
+	return search_key(btf, actual_type_id, bit_offset, data, keyword, update, value, index);
+}
+
+static struct member *btf_handle_var(struct btf *btf, __u32 id, __u8 bit_offset, void *data, char *keyword, bool update, const char *value, char *token, int index) {
+	const struct btf_type *t = btf__type_by_id(btf, id);
+	const char *name = btf__name_by_offset(btf, t->name_off);
+
+	// FIXME: for array, var/struct/union is in the format var[index], need
+	// to handle it here.
+	printf("var\n");
+	printf("name: %s, key: %s\n", name, token);
+
+	if (strcmp(name, token) == 0) {
+		// found the name, continue search
+		return search_key(btf, t->type, bit_offset, data, keyword, update, value, index);
+	}
+
+	return NULL;
+}
+
+static struct member *btf_handle_datasec(struct btf *btf, __u32 id, __u8 bit_offset, void *data, char *keyword, bool update, const char *value, int index) {
+	const struct btf_type *t = btf__type_by_id(btf, id);
+	int vlen, i;
+	const struct btf_var_secinfo *vsi;
+	struct member *ret;
+
+	printf("datasec\n");
+
+	vlen = BTF_INFO_VLEN(t->info);
+	vsi = (const struct btf_var_secinfo *)(t + 1);
+
+	for (i = 0; i < vlen; i++) {
+		ret = search_key(btf, vsi[i].type, 0, data + vsi[i].offset, keyword, update, value, index);
+
+		if (ret) {
+			return ret;
+		}
+	}
+
+	pr_debug("key not found");
+	errno = EINVAL;
+
+	return NULL;
+
+}
+
+static int count = 0;
+
+static struct member *search_key(struct btf *btf, __u32 id, __u8 bit_offset,  void *data, char *keyword, bool update, const char *value, int index)
+{
+	char *token = NULL;
+	char *old, *end;
+	const struct btf_type *t = btf__type_by_id(btf, id);
+	int kind;
+	char *dup = NULL;
+	char *orig_dup = NULL;
+	struct member *ret;
+
+	kind = BTF_INFO_KIND(t->info);
+
+	printf("iteration: %d, key: %s\n", count, keyword);
+
+	if (kind == BTF_KIND_VAR || kind == BTF_KIND_STRUCT || kind == BTF_KIND_UNION) {
+		if (keyword) {
+			dup = strdup(keyword);
+			if (!dup) {
+				pr_debug("no memory!");
+				return NULL;
+			}
+
+			orig_dup = dup;
+		}
+
+		token = strsep(&dup, ".");
+		if (token == NULL) {
+			pr_debug("null token");
+			goto fail;
+		}
+
+		old = token;
+		token = strsep(&old, "[");
+		if (old != NULL) {
+			// have array presentaion, "number]" is the remaining
+			errno = 0;
+			index = strtol(old, &end, 0);
+			if (errno != 0) {
+				pr_debug("strtol error!");
+				printf("convert error!\n");
+				goto fail;
+			}
+			
+			errno = EINVAL;
+			if (old == end) {
+				pr_debug("no digits for index!");
+				goto fail;
+			}
+	
+			// validate representation, remaining must be ']'
+			if (strlen(end) != 1 || *end != ']') {
+				pr_debug("invalid array representation!");
+				goto fail;
+			}
+	
+			if (index < 0) {
+				pr_debug("invalid index!");
+				goto fail;
+			}
+		}
+	}
+
+	printf("iteration: %d, key: %s, token: %s\n", count++, keyword, token ? : "(null)");
+
+	switch (kind) {
+		case BTF_KIND_INT:
+			ret = btf_handle_int(btf, id, bit_offset, data, keyword, update, value, index);
+			goto success;
+
+		case BTF_KIND_STRUCT:
+		case BTF_KIND_UNION:
+			ret = btf_handle_struct_and_union(btf, id, bit_offset, data, dup, update, value, token, index);
+			goto success;
+
+		case BTF_KIND_ARRAY:
+			ret = btf_handle_array(btf, id, bit_offset, data, keyword, update, value, index);
+			goto success;
+
+		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
+			ret = btf_handle_enum(btf, id, bit_offset, data, keyword, update, value, index);
+			goto success;
+
+		case BTF_KIND_PTR:
+			pr_debug("pointer, don't known what to do with it");
+			goto fail;
+
+		case BTF_KIND_UNKN:
+		case BTF_KIND_FWD:
+			pr_debug("unknown type");
+			goto fail;
+
+		case BTF_KIND_TYPEDEF:
+		case BTF_KIND_VOLATILE:
+		case BTF_KIND_CONST:
+		case BTF_KIND_RESTRICT:
+			// modifier, find actual type id
+			ret = btf_handle_modifier(btf, id, bit_offset, data, keyword, update, value, index);
+			goto success;
+
+		case BTF_KIND_VAR:
+			ret = btf_handle_var(btf, id, bit_offset, data, dup, update, value, token, index);
+			goto success;
+
+		case BTF_KIND_DATASEC:
+			ret = btf_handle_datasec(btf, id, bit_offset, data, keyword, update, value, index);
+			goto success;
+
+		default:
+			goto fail;
+	}
+
+success:
+	if (orig_dup) {
+		free(orig_dup);
+	}
+	return ret;
+
+fail:
+	if (orig_dup) {
+		free(orig_dup);
+	}
+	return NULL;
+}
+
+static struct member *bpf_global_query_and_update_key(__u32 id, const char *identifier,  bool update, const char *data)
+{
+	int fd, err;
+	struct bpf_map_info info = {};
+	__u32 len = sizeof(info);
+	struct btf *btf;
+	void *key, *value;
+	__u32 value_id;
+	const struct btf_type *t;
+	__u32 kind;
+	char *keyword, *origin;
+	struct member *member = NULL;
+
+	fd = bpf_map_get_fd_by_id(id);
+	if (fd < 0) {
+		pr_debug("get map by id (%u): %s\n", id, strerror(errno));
+		return NULL;
+	}
+
+	err = bpf_map_get_info_by_fd(fd, &info, &len);
+	if (err) {
+		pr_debug("get map info by fd(%d): %s\n", fd, strerror(errno));
+		return NULL;
+	}
+
+	if (!info.btf_id) {
+		pr_debug("no btf associated with this map");
+		errno = ENOTSUP;
+		return NULL;
+	}
+
+	if (info.type != BPF_MAP_TYPE_ARRAY) {
+		pr_debug("global variables must be in array map");
+		errno = ENOTSUP;
+		return NULL;
+	}
+
+	// lookup the key
+	btf = bpf_map_get_btf(&info);
+	if (!btf) {
+		pr_debug("cannot get btf: %s\n", strerror(errno));
+		return NULL;
+	}
+
+	key = malloc(info.key_size);
+	value = malloc(info.value_size);
+
+	if (!key || !value) {
+		pr_debug("no memory");
+		errno = ENOMEM;
+		goto out_free_btf;
+	}
+
+	memset(key, 0, info.key_size);
+	memset(value, 0, info.value_size);
+
+	if (bpf_map_lookup_elem(fd, key, value)) {
+		pr_debug("cannot find element 0");
+		errno = EINVAL;
+		goto out_free_kv;
+	}
+
+	// found value, parse btf
+	value_id = info.btf_vmlinux_value_type_id ? :
+			info.btf_value_type_id;
+
+	t = btf__type_by_id(btf, value_id);
+	
+	// must be datasec
+	kind = BTF_INFO_KIND(t->info);
+	if (kind != BTF_KIND_DATASEC) {
+		pr_debug("not datasec");
+		errno = EINVAL;
+		goto out_free_kv;
+	}
+
+	keyword = strdup(identifier);
+	origin = keyword;
+
+	member = search_key(btf, value_id, 0, value, keyword, update, data, -1);
+
+	if (update) {
+		err = bpf_map_update_elem(fd, key, value, 0);
+		if (err) {
+			pr_debug("update failed: %s", strerror(errno));
+			free(member->data);
+			free(member);
+			goto out_free_keyword;
+		}
+	}
+
+	free(origin);
+	free(key);
+	free(value);
+	bpf_map_free_btf(btf);
+
+	return member;
+
+out_free_keyword:
+	free(origin);
+
+out_free_kv:
+	free(key);
+	free(value);
+
+out_free_btf:
+	bpf_map_free_btf(btf);
+	return NULL;
+}
+
+struct member *bpf_global_query_key(__u32 id, const char *key)
+{
+	return bpf_global_query_and_update_key(id, key, false, NULL);
+}
+
+int bpf_global_update_key(__u32 id, const char *key, const char *value)
+{
+	struct member *member;
+	int err =0;
+	member = bpf_global_query_and_update_key(id, key, true, value);
+	if (!member) {
+		err = -1;
+	}
+
+	free(member->data);
+	free(member);
+
+	return err;
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index a2c091389b18..ca47b9354b12 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -117,6 +117,12 @@ LIBBPF_API int bpf_prog_load(enum bpf_prog_type prog_type,
 /* Recommended log buffer size */
 #define BPF_LOG_BUF_SIZE (UINT32_MAX >> 8) /* verifier maximum in kernels <= 5.1 */
 
+struct member {
+	void *data;
+	__u32 type;
+	size_t size;
+};
+
 struct bpf_btf_load_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 
@@ -152,6 +158,9 @@ LIBBPF_API int bpf_map_delete_elem_flags(int fd, const void *key, __u64 flags);
 LIBBPF_API int bpf_map_get_next_key(int fd, const void *key, void *next_key);
 LIBBPF_API int bpf_map_freeze(int fd);
 
+LIBBPF_API struct member *bpf_global_query_key(__u32 id, const char *key);
+LIBBPF_API int bpf_global_update_key(__u32 id, const char *key, const char *value);
+
 struct bpf_map_batch_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 	__u64 elem_flags;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index a5aa3a383d69..d056ab0e2ffb 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -390,4 +390,6 @@ LIBBPF_1.2.0 {
 		bpf_link_get_info_by_fd;
 		bpf_map_get_info_by_fd;
 		bpf_prog_get_info_by_fd;
+		bpf_global_query_key;
+		bpf_global_update_key;
 } LIBBPF_1.1.0;
-- 
2.40.0


