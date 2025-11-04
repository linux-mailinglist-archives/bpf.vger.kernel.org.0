Return-Path: <bpf+bounces-73398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1278C2E963
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 01:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4543A7C57
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 00:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFC7205E26;
	Tue,  4 Nov 2025 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/VWKjlb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848761A3160;
	Tue,  4 Nov 2025 00:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762215978; cv=none; b=qO/f0UpxlU4g32vh1ovEoIAPdXd15ZQtwf+shc3Lbgdx7sLQCz8GgXLrQa+TEckVLAgvhpp4glUZ/obMuwkdqFLOSD+Gohh7tOn5/SnvYKCBmc+GkIbXGVETaoLhGYiBwL7PpZv0+QL2YkDumB6NSXQXIF8yjMnvdhvsfffezlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762215978; c=relaxed/simple;
	bh=sqYz4VBz1fLsusCb6FNXdFkrhZs/PCBhyQIODzam6pY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TUr1ka9b7Q2QsExAmrvtxgRNmgNeAjI9c8JtKCTUXbRK+4z+iNayVXEsmINYyzYsKbG3D9xY3M0INwVcovJoFgxZAdQ9SUxbq0SubFk+rPVsJ7ODNfUxPL8iNQRzYkHJkBB/dCWytCxMK4Z/P20CXF9QmLx8QOy12fsZ2fzhNfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/VWKjlb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23402C4CEE7;
	Tue,  4 Nov 2025 00:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762215978;
	bh=sqYz4VBz1fLsusCb6FNXdFkrhZs/PCBhyQIODzam6pY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t/VWKjlbXhlZ34kG8/snOsM5FytcamiYc6LOFxQrX6y1ABv7khTjfKn75cT9b/BdR
	 iN84igxGEH8jq3ginMJ1fsfFhmkKk5qiy004UahVj27nbAR+NOs4h+zdJynTfznL03
	 P91D6PIhswq4dqz0sjtpZZicXZCzSywHBr2vIxhUK3uFvgtLSa6r9TkJu1IGYPBvI3
	 z3s3ZScYe5MmaPxSjnqArAsRMsaFoaHuvf9N7L7BKFCEArH4vXfCLWYwc+oKFs140I
	 C9vsJ2L9Y/L1owSU0LdHtSJVODoKueCZwh8kgPzmp4xlTsrXOmegI1qm+Mwvq/ji/+
	 tlTElwR7TfoHA==
From: Kees Cook <kees@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v5 1/8] net: Add struct sockaddr_unsized for sockaddr of unknown length
Date: Mon,  3 Nov 2025 16:26:09 -0800
Message-Id: <20251104002617.2752303-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104002608.do.383-kees@kernel.org>
References: <20251104002608.do.383-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1781; i=kees@kernel.org; h=from:subject; bh=sqYz4VBz1fLsusCb6FNXdFkrhZs/PCBhyQIODzam6pY=; b=owGbwMvMwCVmps19z/KJym7G02pJDJmcHqprirolqn8bdmm+YnyW/4v95aWQrVyeLErWvjvW6 Z4XO63QUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJHO+YwMv9abSgjejL733f/C maOT/z4y+tpnz7IiX7LQP0/rFJNPF8NfIQkemSjlnn/MXL/YFvo13end/+Rsxnn1tNvKorbxf9+ xAQA=
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

struct sockaddr_unsized {
	u16 sa_data_len;
	u16 sa_family;
	u8  sa_data[] __counted_by(sa_data_len);
};

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/socket.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 3b262487ec06..7b1a01be29da 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -40,6 +40,23 @@ struct sockaddr {
 	};
 };
 
+/**
+ * struct sockaddr_unsized - Unspecified size sockaddr for callbacks
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
+struct sockaddr_unsized {
+	__kernel_sa_family_t	sa_family;	/* address family, AF_xxx */
+	char			sa_data[];	/* flexible address data */
+};
+
 struct linger {
 	int		l_onoff;	/* Linger active		*/
 	int		l_linger;	/* How long to linger for	*/
-- 
2.34.1


