Return-Path: <bpf+bounces-70931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9319BDBAD5
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 00:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27D734FCD62
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 22:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A9D30E0D9;
	Tue, 14 Oct 2025 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xg9Ak2By"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35EA2EBBAB;
	Tue, 14 Oct 2025 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481814; cv=none; b=Jx/NPdNgsRhPGym3SSPlfZ0t4M1WRPcmjxass+hIygAhBOs5nSupqjkhO8XTmLtKK33J6TNxIDBxhezTglA+URIpu2uZRiXAofbqPZtq+qQ79yhVh6BAHlf/57gp29nNl14m75jqjZmTvkegtw9k24D4ChrxDE4Par0Tx+m6HfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481814; c=relaxed/simple;
	bh=K0bJEw3/KpjdRCjklJV0e1g5vGr5mwAyNOusvS64278=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4vd1p7XemEoFzjXNmeIfZkapv2ETMXO9l66Wyt9F0D6mJMQGbQqSKTRhQx7ARG2jfWUGtvhHREDwIciFCnEdwmrxL7qvR34cKcM1eKj8sIhH0nAgNWSHaIuXGK9nUMSvn9KuBajwitDe9yb6Z7Lg9ZD+3O8nYB+Ap6hYab86xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xg9Ak2By; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73264C4CEE7;
	Tue, 14 Oct 2025 22:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760481814;
	bh=K0bJEw3/KpjdRCjklJV0e1g5vGr5mwAyNOusvS64278=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xg9Ak2ByifC6q44iPRotgDvZRt2IImjgwUhkcV8cnchnLzClVvzjD8o+3lHMNAqjN
	 kijVBl9PKSa6NgR/+CryLHUEgoD/lXB2pdlkBf3m4B4TLxhiF5CjCpcnzaF8x/gYqw
	 bSyQibx8wK+MtXeR80TIk98+I9VGcMX0XQEjpeo/IjufuWUuX7mrH4BhKEpOhTtVQE
	 o3P434po+XoKB5LcsCU8UKMARwXjVNZaAN8dzh1dVnN+z3/ySMUCTN0nsqyL3hMWqn
	 0cxubD6/tJTfhdEIUotlQWxR+nOLTsJ6btxZxs/HwzovWg+uoAUiFCPmAnpTdwmUJd
	 efobiys0JluCw==
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
Subject: [PATCH v2 01/10] net: Add struct sockaddr_unspec for sockaddr of unknown length
Date: Tue, 14 Oct 2025 15:43:23 -0700
Message-Id: <20251014224334.2344521-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014223349.it.173-kees@kernel.org>
References: <20251014223349.it.173-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=kees@kernel.org; h=from:subject; bh=K0bJEw3/KpjdRCjklJV0e1g5vGr5mwAyNOusvS64278=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnvLgnE+Kw6dOX/n+rs/1KP1wZKXZVLmH5uX86JzQG7P bgyDYPedJSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEwkagrDPzvR6ON7lTt8F3w3 KCtqW5bvdmx/sXrxzrqnc7yeHck7e5iRYXKrxccq1mUr5dj+vzp9qcEp+eMBq5qIKONf7SKPJ6v fYwAA
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


