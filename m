Return-Path: <bpf+bounces-47957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2007A02895
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 15:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 851FB1606C8
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 14:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B63D13B59A;
	Mon,  6 Jan 2025 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmJh4Uvc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C71F433CB
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736175248; cv=none; b=M3t4NFe3Eus/wW+Zt19jHF40Tw8oK7CsBhM9Kyn2eDNR+Uvf415xFd0UanbcqL2/trvYgLTAYvhQo/IBv/7cti3ABKtZotHbGtXmalgeMlcciSO6h0+EpWrGRL8HFhkOVh+0jDH8J46ssJw4xTKhJS3emolgnUIkafJicmG55yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736175248; c=relaxed/simple;
	bh=EwDzzphZzFhtltBbEjKn6ELpV9oQi7pVRaV5OiC8PVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgzHqwLujLq46X9o07mM6DIAcnMsKf0rBu4wLvFAWkMfzexnewUXPfvk6JNK09an2KnqOit2NBsXT3YaDu91zz9MqcikOcmRbqr10UrwiS/aCBHOig96rbWGyUCFGQV/mak62IMH8hHzj6R0xmUVN4lSMJ04FdOxvrmKnjU7UwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmJh4Uvc; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385d7f19f20so6348962f8f.1
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 06:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736175244; x=1736780044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfxLq/k3pa/bVimMye2S+vaiQlpIj+CsmbaBLY7XhHw=;
        b=FmJh4UvcvTxVtXJNFl0BDq59717emnd4wEckGT02prwMqzSGr/EWsD9bk7HRhqawFb
         eEDWC9HxGzCfqBgfX7m19iDHnrgzRh9YD1uJKm78EkXz+lRa/wUbtlxArV0tQDf2KepW
         i4RmKgiDwVjt4ADd6jymd9R8iNu7XiAO3xStepXvEt2HO+yQhT3xLcLnBG0G0WCH9QfN
         6YkSo2L6qE4fXBQlI/wNV8IBC5aeHrK3PK8cE0TqGfDDz62BBe08JHi6baBZrB9bE9Bn
         EWHMJOBJwgPKdZ0ourg0mu9B0L6tZ/QpkDv69qXBaN9sYTpIM0/4vgog/t4RmB92CvoH
         ERLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736175244; x=1736780044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfxLq/k3pa/bVimMye2S+vaiQlpIj+CsmbaBLY7XhHw=;
        b=SpXQrGeqoyz507gdcy3XXmDLG9m+G0H1ZSHTA6BHmu3YMvSfNd1shuKRzpoLCaAo9L
         9PBAdK0+a06K5MdceVpeQwOk9IZhhwpXd1ccVciYFTUvJIBbXQFjBcBP0TQL6GnxaEL9
         S3dzymCr3qLm6a8L+5aGUe+6kWTvz6OKuQwtdh975NW/VL8HAx6waAh9avJTOlUYd/Wb
         GF3/vaC/opNVCkLvHA1Uy1Rfzyt+LALEO6+FCMNsIPCHqYFz9m1nNT6QY530lb9HdRb8
         lXQRPepEUlJGJBOoxKKQnNo3PIOUhYUp55QdG42NAQP7rs3dyDIDX0/JJB3JD27nXJUR
         qdxw==
X-Gm-Message-State: AOJu0Yxwe2PueVCsX/pnTM+YIVeS04IO48GBJPcd0Pu2H4OK2/xHju6/
	rQCLSKzJhXoltxeYNRtq995qWV+YN5FqDeRQljNwLDkj7ppbIozeovIS5pEJUEE6VA==
X-Gm-Gg: ASbGnctNtCZBbKDU7/RDm3BgLjKN1n4p7gKjNeY6xqDky0a4FR7iv+7gtW1fd9QnkBK
	huuYjBTlGCXPT3vfn8VYG06KgLP2yKkf5YcjScplFTdPLiI7V0oRbO0uWRcwgbaACfpbIymKZnl
	ri1eo63L7s91xebl6xI0yQNJ209uHpdSAjCu4aMR4pFXHkZabbHj727YQBFhm5oK2Fm1LUgtgdS
	VSx2ub57nm8IEsf7ucxN/4bLpx0yGdZirMzcikYv+GnnxECJa8NkVUUEPTQjnhAhAHrEOe0a0k=
X-Google-Smtp-Source: AGHT+IGpDIIY/UlEA1BTnSqFKkJY+bKo67rTJNDCHK8rsE19keHWhr8o6QC/8+kJD/KFTfSzTiyxNQ==
X-Received: by 2002:a05:6000:1fa9:b0:385:f38e:c0c3 with SMTP id ffacd0b85a97d-38a221f1391mr43705446f8f.6.1736175242481;
        Mon, 06 Jan 2025 06:54:02 -0800 (PST)
Received: from babis.. ([2a02:3033:700:3ba2:3837:7343:334:7680])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832e74sm47389982f8f.30.2025.01.06.06.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 06:54:02 -0800 (PST)
From: Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>
Subject: [PATCH bpf-next 2/4] bpf: Add bpf command to get number of map entries
Date: Mon,  6 Jan 2025 15:53:26 +0100
Message-ID: <20250106145328.399610-3-charalampos.stylianopoulos@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250106145328.399610-1-charalampos.stylianopoulos@gmail.com>
References: <20250106145328.399610-1-charalampos.stylianopoulos@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduces a new command to the main bpf syscall to return the number
of entries in a map. Returns EOPNOTSUPP if the relevant map operation
is not implemented.

Co-developed-by: Nick Zavaritsky <mejedi@gmail.com>
Signed-off-by: Nick Zavaritsky <mejedi@gmail.com>
Signed-off-by: Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>
---
 include/uapi/linux/bpf.h | 17 +++++++++++++++++
 kernel/bpf/syscall.c     | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2acf9b336371..f5c7adea1387 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -903,6 +903,17 @@ union bpf_iter_link_info {
  *		A new file descriptor (a nonnegative integer), or -1 if an
  *		error occurred (in which case, *errno* is set appropriately).
  *
+ * BPF_MAP_GET_NUM_ENTRIES
+ *	Description
+ *		Get the number of entries currently present in the map.
+ *
+ *		This operation is supported only for a subset of maps. If the
+ *		map is not supported, the operation returns **EOPNOTSUPP**.
+ *
+ *	Return
+ *		Returns zero on success. On error, -1 is returned and *errno*
+ *		is set appropriately.
+ *
  * NOTES
  *	eBPF objects (maps and programs) can be shared between processes.
  *
@@ -958,6 +969,7 @@ enum bpf_cmd {
 	BPF_LINK_DETACH,
 	BPF_PROG_BIND_MAP,
 	BPF_TOKEN_CREATE,
+	BPF_MAP_GET_NUM_ENTRIES,
 	__MAX_BPF_CMD,
 };
 
@@ -1837,6 +1849,11 @@ union bpf_attr {
 		__u32		bpffs_fd;
 	} token_create;
 
+	struct { /* struct used by BPF_MAP_GET_NUM_ENTRIES command*/
+		__u32 map_fd;
+		__u32 num_entries;
+	} map_get_num_entries;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4e88797fdbeb..a31a63a4aa5d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5748,6 +5748,35 @@ static int token_create(union bpf_attr *attr)
 	return bpf_token_create(attr);
 }
 
+#define BPF_MAP_GET_NUM_ENTRIES_LAST_FIELD map_get_num_entries.num_entries
+
+static int bpf_get_num_entries(union bpf_attr *attr, union bpf_attr __user *uattr)
+{
+	__u32 num_entries = 0;
+	struct bpf_map *map;
+
+	if (CHECK_ATTR(BPF_MAP_GET_NUM_ENTRIES))
+		return -EINVAL;
+
+
+	CLASS(fd, f)(attr->map_fd);
+	map = __bpf_map_get(f);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	if (!map->ops->map_num_entries)
+		return -EOPNOTSUPP;
+
+	num_entries = map->ops->map_num_entries(map);
+	if (num_entries < 0)
+		return num_entries;
+
+	if (put_user(num_entries, &uattr->map_get_num_entries.num_entries))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 {
 	union bpf_attr attr;
@@ -5884,6 +5913,9 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 	case BPF_TOKEN_CREATE:
 		err = token_create(&attr);
 		break;
+	case BPF_MAP_GET_NUM_ENTRIES:
+		err = bpf_get_num_entries(&attr, uattr.user);
+		break;
 	default:
 		err = -EINVAL;
 		break;
-- 
2.43.0


