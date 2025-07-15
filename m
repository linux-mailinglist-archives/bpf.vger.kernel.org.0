Return-Path: <bpf+bounces-63302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE28B053DE
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 09:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7263BDC6E
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 07:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EEC272E7F;
	Tue, 15 Jul 2025 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxJW6iWY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EC6262FD2;
	Tue, 15 Jul 2025 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752566293; cv=none; b=P3ZyX4+wFCwNAydGxvJL6JDN8otLXVtWxxsdeE8fOMsoCv7NhYNxgShVAv3RuXFbGxv75QyuL8CC3BgJWVvXytHVQeySHf6XNZc7qsvR/5FZ9OE42+6lt9BE8Sq0zZD/sbi1FS73XZrXAdnUpG+fM00Zt+MRCxVRL2YluvVqaqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752566293; c=relaxed/simple;
	bh=FJzNQx/PfEYrXvefUo7trGqMuioZ9428uG9BUnZUMaw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pp9TMpWZz8/zjv59VVypiCuvJeuU7iOERZNmGbQWl7ThXA96rDijLviDBGnIhQKONZvTN/6I4/X05YsZuA4aL1ORJ8zNH2kzsm9X5hErVzJQLEaQgqaFrg+vKtuXyWAUzBVRy4untc8NgrWD0Y9vCKnv03H3BXrknphLtpLOE/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxJW6iWY; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-748e81d37a7so3083268b3a.1;
        Tue, 15 Jul 2025 00:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752566291; x=1753171091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jIxv/EnwjEjq2Jpcv/lH1TRbWc7C3rgHmzItEdMwwZk=;
        b=KxJW6iWYWe2x8kqog7jLgpl2sS1kxgjuUBpMEyMFtoqvT3zUn/WH16dCWwaQERNjgZ
         P6ilGJi+qxoLbhqgsXNFORU3c2UMibvcc68KahEsoqT3NtDXBXmP1Z2RSjO0pZ3C26Sp
         Vo9WmHqHzvUs7rbWlUuHoXsSIyNvPW16nXFK8Ff4yrItWNtpVZWgMjk97DFh/9nCg+TS
         +zJEWSzvr7GXkXZuXHifVVwsOjlu++PIVdAhYx2SPOKqTurmsthfxJZ3e1VwXF/SoTku
         OQbDNMbqgZzWMr+ombYXwIPjkFvLj2raAHfSx8IGEeT7XwJR/UtO/fCn6YD30SavE/PL
         Nxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752566291; x=1753171091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jIxv/EnwjEjq2Jpcv/lH1TRbWc7C3rgHmzItEdMwwZk=;
        b=uDBtDG/yWG8sokOJcB5VB9SaxZFpwltvDzeAML2L+30g/z5/ss7ztmo1rHZj4ncynX
         vh1Ataie8BH3kPGKJ1iUQ0+oieuRDvPPylNOg2f+ZfBDjbDjFeXk/qCbaio0ncyR2Ztj
         ADov6sjbWTKLAps1sGokC+DWjAvwjem1DnmaSYwSgMDFDuckT3einND7gp0+0gl4lv2i
         yiV758xS2F3/ivWOqrhmLjH/xD04vZ9ZKJg8elxgqyx/KVDzPKpj/i0x3gtexxZ6G9qZ
         h0shBcxi9QzSqJDYiAo+WXhZgsrhizuWMudIpcKISwV4ksX3zVbtpqAlhUso8/RHqk7a
         rJ5A==
X-Forwarded-Encrypted: i=1; AJvYcCWBmWp6QgWEWPFWxGhoZl/MJj7uLtFy4S7qwcRvMlZgr9WqnuIM/Bf9JjlhIM3NQnwAIGupIf9lu3A7kNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyEadji8u9WpzKOOjt9JJu+Xr7Si4pRBEOfCj0YFzENYiAW/YD
	nzFl0F0w7ejqxOKB7ObgEMjb7MhXSCq+XPCLvVg8T2jRdvqZj7NLK/Eo2nwAW963
X-Gm-Gg: ASbGncs1sIA4gjmYGzmjkuGItXvxh2JPQ3OmYv06bezMJVGfpGAooQfKbI4j7gl3tbt
	KqFDHbUmWfI0r5i6o0x6rxEJB4WHxInOcl8GS4ezOl16ntMEMI+opTcJJr/jth02eHQJSQpibIa
	c+cLU/OUFS4rLsgcrw98ESFJT2G2ATLGNk7H8JCSKm7poZNsteIttgnwGl0Cg5m/B9ZNEAOsNp7
	N7/3DkTGlBbQ9kLvZlTTEqAcmpg7714RBWW7GoI0Fw3JuDxD+t2q2KUigi1Rg7OHxSoeYq3KZfA
	lVnvG+8LJoQn0foafG+MpiCtEokQy3sKgTzbDY+V4g1w0t6xZNm05SKs2sXPhPYRuFOBJN+iEge
	Sv74+ky63n76jUG/GmczlfrKSsMD/w92qt0dqj/lXAw==
X-Google-Smtp-Source: AGHT+IGy7rmN2/mlNm71HEquJe8mUQLan4jD9pEbCd1RurIVv3DqVTi67WBvQBfUN6aBqTbjonFJow==
X-Received: by 2002:a05:6a00:2394:b0:736:50d1:fc84 with SMTP id d2e1a72fcca58-74ee3728e72mr20913259b3a.21.1752566291264;
        Tue, 15 Jul 2025 00:58:11 -0700 (PDT)
Received: from shankari-IdeaPad.. ([2409:4080:410:5eb2:ca2d:5448:aece:73e1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1d337sm11264953b3a.73.2025.07.15.00.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 00:58:10 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
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
	Shankari Anand <shankari.ak0208@gmail.com>,
	syzbot+ad4661d6ca888ce7fe11@syzkaller.appspotmail.com
Subject: [PATCH] bpf: restrict verifier access to bpf_lru_node.ref
Date: Tue, 15 Jul 2025 13:27:55 +0530
Message-Id: <20250715075755.114339-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a data race on the `ref` field of `struct bpf_lru_node`:
https://syzkaller.appspot.com/bug?extid=ad4661d6ca888ce7fe11

This race arises when user programs read the `.ref` field from a BPF map
that uses LRU logic, potentially exposing unprotected state.

Accesses to `ref` are already wrapped with READ_ONCE() and WRITE_ONCE().
However, the BPF verifier currently allows unprivileged programs to
read this field via BTF-enabled pointer, bypassing internal assumptions.

To mitigate this, the verifier is updated to disallow access
to the `.ref` field in `struct bpf_lru_node`.
This is done by checking both the base type and field name
in `check_ptr_to_btf_access()` and returning -EACCES if matched.

Reported-by: syzbot+ad4661d6ca888ce7fe11@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6847e661.a70a0220.27c366.005d.GAE@google.com/T/
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
 kernel/bpf/verifier.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 169845710c7e..775ce454268c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7159,6 +7159,19 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		}
 
 		ret = btf_struct_access(&env->log, reg, off, size, atype, &btf_id, &flag, &field_name);
+
+		/* Block access to sensitive kernel-internal fields */
+		if (field_name && reg->btf && btf_is_kernel(reg->btf)) {
+			const struct btf_type *base_type = btf_type_by_id(reg->btf, reg->btf_id);
+			const char *type_name = btf_name_by_offset(reg->btf, base_type->name_off);
+
+			if (strcmp(type_name, "bpf_lru_node") == 0 &&
+				strcmp(field_name, "ref") == 0) {
+				verbose(env,
+					"access to field 'ref' in struct bpf_lru_node is not allowed\n");
+				return -EACCES;
+			}
+		}
 	}
 
 	if (ret < 0)

base-commit: 155a3c003e555a7300d156a5252c004c392ec6b0
-- 
2.34.1


