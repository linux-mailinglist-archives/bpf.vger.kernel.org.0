Return-Path: <bpf+bounces-78317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA7ED0A630
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 14:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36A9B304D4A9
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 13:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0692F35CB72;
	Fri,  9 Jan 2026 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsCaxs+C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC9635C182
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963620; cv=none; b=fRPSZP7y6po+6hjQw+0diSPA+hxY/772r1qhI6efjLthzulSWuvCoE0BPxxVx+FjHuausS4FON6Cyr05PEdo3n5DBSFoQ/br1WKWz+4D0sQzmUKlvBu1wi4AM7jhgYjdqRagHF3FtX/c7dZCuYdhFn4E5aIbIBrgWzXy2S4ZoW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963620; c=relaxed/simple;
	bh=V2vGk2Zy5fJHvJb6bZZNfPor1jIBJ/nlZMkVKHTwBMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gdJ1dRMfZuCghdXowJEQ+mLWa+0m7NPetyuwFu5ow5Xat0IyDpnITzdvxQ1LEly2B3/MsFXGFvO5KAuQhlJI9gE7OFwGK42gguqXpaGTwesrgWR5dciydHCSZaGhpKm44FPUCnUDHb+jsypW9SZv/gpvNG5GQRpEQoUVvSKaWXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsCaxs+C; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0834769f0so31983795ad.2
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 05:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767963618; x=1768568418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bty2Mx4T9JTfidtdE5tI1SEQacGBSMSmT3cGtlsXrrQ=;
        b=VsCaxs+CfVbmGdcKD/KsIsSHsIHhEbdPJ2xBz/wcAu3q9M9ZzCzedQsXkprzF+au/u
         bLFD/pmIPJ+ADs45oYzVMP87NmDd/n5+nAPRspAX4nLiq2TwNBaeUgMVwcLWcOSa7buo
         +bdhrEeqKijbV55MzgTq/y2UQaxBmL+9a1FymHZFXkbVfUTuWcovilk8bs5bMoWq0qvz
         CQt2pLXeFFBpJZkEUPs8eifhxF7uqTL9RXu2qhpGaWFxwSM7ndkQLR69VUSZwxR0aYVP
         m3C13bSNXydgNXbS2ZSkPDbvLHM75IPRAgqAmYtXSZnT9o4toHKqCRq5hxm+bpdmp//m
         CWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963618; x=1768568418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bty2Mx4T9JTfidtdE5tI1SEQacGBSMSmT3cGtlsXrrQ=;
        b=o87vewkeICThw78XZ5Wo4mn6xfcCpGhHCdkKThvf77jh5wv7kNNO9LTqR6sp8BsrBE
         YPXXqq2Y9O25bjakGNceb1CpoIoDoq9B43oxL2vDK64l89Au3gtP31B9aD3ADexWNfEC
         KOv1dgEu44kP7jUVhrLyGHYbmiumNHx9U++M8wJ+h8L3G//F346QSJL7P9vmAIW4XfEv
         yfVSjaaBoBBSWB3x/IXNLgywWeY8DBzDfi2Fdb/cwsfAtZUFFZB2QgEgHLZ+F+rvmvvN
         wf+eMV+m3uUXfstilBlsfLQBosaXsuAtiMkzvrzhM0+ANZ5+cvKModVpEoxlF0iVtZlB
         HYUA==
X-Forwarded-Encrypted: i=1; AJvYcCUp1w5d4dBBegNxeOC0v0IibQqfolYi1EALEzNQsbKQYO1XVRkrSmOsvRXyz7nkhS6NctQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOIO+waZRl78bC+HrpFAW5bMUhgD2q8znn7wxQH4Lr/RPfFX3O
	6+duULHSwuR+uvvDyeh8281HVBjW8fiH74NdJlWUCYlsiX3+0hp6x72a
X-Gm-Gg: AY/fxX4EQ4HVX9Yp59YYGwESmJFhvTd1SmJOCP/Bhe6PtJeButtlRBAHdZzGZgUSIWX
	5g7IcLy8rRkSlOZZA94TKAqVreYsPWaZuxPW331VaX+aoJvBZcX8ZYam+GSbUaqzfgUZHiYIuDa
	5qunfBJ58Fst8B0vyxmZel1ugcoE4Gv0rHvUOUDEyzIyX9lev2WC+s7+y6C/ek+7vudwHYcCibn
	iMh5Jq8bRorNvKKCubp7mtH3BlWpNxhtFQ7KWspydPRpXewYzZ+mxU6fmAsPXVuhJjYTDi03aQ1
	FphJayds1oHS8SM/iCtVjy+d/QJIE+3UCgqzYqWblDHJXgozIo59NiBzTRPuYPmgqCCy32YS95g
	Dw8a7x9vg4Y6QfSZvKiWEIouQBaYykkp5UzpoB1rQ7RaF7be1jTNV74pNtrzPcdHE76XrTdpfvi
	v3Z3tvB65ati7xY/0kPdWmD/PcZlkmTrfJNXOMdw==
X-Google-Smtp-Source: AGHT+IECF92w8fh+lHt+04+liud+q7g2I2MsZIwzGHh6/4mZ0MC6VCsv+IyzdIp0hp/XC8DnU71DOA==
X-Received: by 2002:a17:902:fb04:b0:2a1:325d:8219 with SMTP id d9443c01a7336-2a3ee49010amr62629655ad.38.1767963618237;
        Fri, 09 Jan 2026 05:00:18 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a328sm104927325ad.4.2026.01.09.05.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:00:17 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v12 03/11] tools/resolve_btfids: Support BTF sorting feature
Date: Fri,  9 Jan 2026 20:59:55 +0800
Message-Id: <20260109130003.3313716-4-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109130003.3313716-1-dolinux.peng@gmail.com>
References: <20260109130003.3313716-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

This introduces a new BTF sorting phase that specifically sorts
BTF types by name in ascending order, so that the binary search
can be used to look up types.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/bpf/resolve_btfids/main.c | 64 +++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index df39982f51df..343d08050116 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -850,6 +850,67 @@ static int dump_raw_btf(struct btf *btf, const char *out_path)
 	return 0;
 }
 
+/*
+ * Sort types by name in ascending order resulting in all
+ * anonymous types being placed before named types.
+ */
+static int cmp_type_names(const void *a, const void *b, void *priv)
+{
+	struct btf *btf = (struct btf *)priv;
+	const struct btf_type *ta = btf__type_by_id(btf, *(__u32 *)a);
+	const struct btf_type *tb = btf__type_by_id(btf, *(__u32 *)b);
+	const char *na, *nb;
+
+	na = btf__str_by_offset(btf, ta->name_off);
+	nb = btf__str_by_offset(btf, tb->name_off);
+	return strcmp(na, nb);
+}
+
+static int sort_btf_by_name(struct btf *btf)
+{
+	__u32 *permute_ids = NULL, *id_map = NULL;
+	int nr_types, i, err = 0;
+	__u32 start_id = 0, start_offs = 1, id;
+
+	if (btf__base_btf(btf)) {
+		start_id = btf__type_cnt(btf__base_btf(btf));
+		start_offs = 0;
+	}
+	nr_types = btf__type_cnt(btf) - start_id;
+
+	permute_ids = calloc(nr_types, sizeof(*permute_ids));
+	if (!permute_ids) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	id_map = calloc(nr_types, sizeof(*id_map));
+	if (!id_map) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0, id = start_id; i < nr_types; i++, id++)
+		permute_ids[i] = id;
+
+	qsort_r(permute_ids + start_offs, nr_types - start_offs,
+		sizeof(*permute_ids), cmp_type_names, btf);
+
+	for (i = 0; i < nr_types; i++) {
+		id = permute_ids[i] - start_id;
+		id_map[id] = i + start_id;
+	}
+
+	err = btf__permute(btf, id_map, nr_types, NULL);
+	if (err)
+		pr_err("FAILED: btf permute: %s\n", strerror(-err));
+
+out:
+	free(permute_ids);
+	free(id_map);
+	return err;
+}
+
 static inline int make_out_path(char *buf, u32 buf_sz, const char *in_path, const char *suffix)
 {
 	int len = snprintf(buf, buf_sz, "%s%s", in_path, suffix);
@@ -1025,6 +1086,9 @@ int main(int argc, const char **argv)
 	if (load_btf(&obj))
 		goto out;
 
+	if (sort_btf_by_name(obj.btf))
+		goto out;
+
 	if (elf_collect(&obj))
 		goto out;
 
-- 
2.34.1


