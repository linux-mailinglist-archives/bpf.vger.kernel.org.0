Return-Path: <bpf+bounces-71458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794ACBF3BEA
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 23:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86A6422E65
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 21:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B657633769C;
	Mon, 20 Oct 2025 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hF3CE5nW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06775336EC8;
	Mon, 20 Oct 2025 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995601; cv=none; b=iczr654zt5eSmN7mAO9JL/QD5Q0Sxvmz2A3AtCrp/KJMysZwTkeWAngErHQS/ARzKM+J2nvQxeQhLVPQEZfKNUVJstZLtixUPbYeW/zXrAa/aOTnDSOFAmWOm8OgiiCoEMpBAbHpV/aRYE5CK/eA2dPhpQo63zz+nu9QYh4BxBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995601; c=relaxed/simple;
	bh=K0bJEw3/KpjdRCjklJV0e1g5vGr5mwAyNOusvS64278=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q2HN6ymyvaUPDPhP5Adi/oEgcv0Vit9KG8U5gWNxTQG3eJenoJM3yifW/4iZ+KpEN33vLls/h27uu7ZwObTzwJbrLbDQg4ZTxXUgDo9TQVyTdrSDtFbO2yA62h+AzsTUdJK4wotS9d02XvQz/dAzoGiNxoqcUGgckQ9J7DK0wCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hF3CE5nW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17A4C19424;
	Mon, 20 Oct 2025 21:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760995600;
	bh=K0bJEw3/KpjdRCjklJV0e1g5vGr5mwAyNOusvS64278=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hF3CE5nWO/waKgHAtLsSuPMW56Y1ClrDHD4lLz2/vCP2MF9MvM6psKWiyamycOmLJ
	 ZzvUp45fnEfHpjz9+aoz6Bdn0san5UFuGKekG+1n3C26CQoROqbea5kHk/6ZtCq136
	 r2TooDJQj+U0/PB04YpM3K60lfFJ1MwBYTJ4nTBZGOYuavRanTBx5LkF13UaH23QTI
	 GVOpRiUi3Jdl1h0jXSCoqBWNm9qfQOVna+RbITvkkL/pcShR0V7qmXpbEnScoV2m9j
	 W4X6C7uBsat8MdINvYK2KNXduZz+ud5KkFNaH0tBOYSp1HwMEoMLYpCd5wXr4gv0dE
	 0CAeh/DZyXtww==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 1/9] net: Add struct sockaddr_unspec for sockaddr of unknown length
Date: Mon, 20 Oct 2025 14:26:30 -0700
Message-Id: <20251020212639.1223484-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020212125.make.115-kees@kernel.org>
References: <20251020212125.make.115-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=kees@kernel.org; h=from:subject; bh=K0bJEw3/KpjdRCjklJV0e1g5vGr5mwAyNOusvS64278=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnfVnLF+Kw6dOX/n+rs/1KP1wZKXZVLmH5uX86JzQG7P bgyDYPedJSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAExkkwbD/9D3Bq48wdPXeehz vLpyQJiJ647CNwOhhXe/Vv7jkBI1Xsnwz6Ca/UL2wtA5M2Nn3pzNxCx3e3/x1zuCRtqt26feFuJ zYwMA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Add flexible sockaddr structure to support addresses longer than the
traditional 14-byte struct sockaddr::sa_data limitation without
requiring the full 128-byte sa_data of struct sockaddr_storage. This
allows the network APIs to pass around a pointer to an object that
isn't lying to the compiler about how big it is, but must be accompanied
by its actual size as an additional parameter.

It's possible we may way to migrate to including the size with the
struct in the future, e.g.:

struct sockaddr_unspec {
	u16 sa_data_len;
	u16 sa_family;
	u8  sa_data[] __counted_by(sa_data_len);
};

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/socket.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 3b262487ec06..27f57c7ee02a 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -40,6 +40,23 @@ struct sockaddr {
 	};
 };
 
+/**
+ * struct sockaddr_unspec - Unspecified size sockaddr for callbacks
+ * @sa_family: Address family (AF_UNIX, AF_INET, AF_INET6, etc.)
+ * @sa_data: Flexible array for address data
+ *
+ * This structure is designed for callback interfaces where the
+ * total size is known via the sockaddr_len parameter. Unlike struct
+ * sockaddr which has a fixed 14-byte sa_data limit or struct
+ * sockaddr_storage which has a fixed 128-byte sa_data limit, this
+ * structure can accommodate addresses of any size, but must be used
+ * carefully.
+ */
+struct sockaddr_unspec {
+	__kernel_sa_family_t	sa_family;	/* address family, AF_xxx */
+	char			sa_data[];	/* flexible address data */
+};
+
 struct linger {
 	int		l_onoff;	/* Linger active		*/
 	int		l_linger;	/* How long to linger for	*/
-- 
2.34.1


