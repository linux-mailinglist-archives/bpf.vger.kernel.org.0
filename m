Return-Path: <bpf+bounces-47682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8489B9FD987
	for <lists+bpf@lfdr.de>; Sat, 28 Dec 2024 09:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E623A2A02
	for <lists+bpf@lfdr.de>; Sat, 28 Dec 2024 08:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8DA86345;
	Sat, 28 Dec 2024 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="UV3WCIbX"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD564594D;
	Sat, 28 Dec 2024 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735375432; cv=none; b=FAS05+jYOycmOcBEKmUyOKRFDovYWODzmfrivNOWXmgU+J2S9cZtw70FlTXpaKAGW67EE3K7LjUEIkudFYdwZBRHihZicOTi2dVzdQ1togiM6fAa0jnVkpqWiKCyYPGy6PgCAGxxvLssFLc4LJTr2+qtcM/NBIw9s0MtQXNG+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735375432; c=relaxed/simple;
	bh=gRcd/2NnDUW8yE3a+tTaSfJ/jeKT2kVSJOjTrjbv+S8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SsYCLiinAPH/TEywiljAROf0m1Q60c9xcbwsb2wSL8uLh/58XghkU9CCMt6gsd5UwWUw9BYNn6NvM/qeRJtciBQuADb3NG0s7R0KCnwnd8NI04memCiNjL+Rx6m86HVIGR25CHD3IVjqenjjiC5ZJHkWssWaICCl8e/8rZzHL60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=UV3WCIbX; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735375425;
	bh=gRcd/2NnDUW8yE3a+tTaSfJ/jeKT2kVSJOjTrjbv+S8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UV3WCIbXhRbiALujdvDUk9ZM4zB7tpO9VebFbFOuccYusBQaf2J4ELPByd8UBEHA3
	 ENHNVPI+Hno0yud7S2HBR0WLgifRsdeWQzo6yND8RR7s3fGtyMxxyZ76hfkDSuD7nD
	 at7FpoeAxFV5lZ/1eaQDMaVvupeXIQWbCe8qdYT8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 28 Dec 2024 09:43:42 +0100
Subject: [PATCH v2 2/3] btf: Switch vmlinux BTF attribute to
 sysfs_bin_attr_simple_read()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241228-sysfs-const-bin_attr-simple-v2-2-7c6f3f1767a3@weissschuh.net>
References: <20241228-sysfs-const-bin_attr-simple-v2-0-7c6f3f1767a3@weissschuh.net>
In-Reply-To: <20241228-sysfs-const-bin_attr-simple-v2-0-7c6f3f1767a3@weissschuh.net>
To: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735375424; l=1428;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=gRcd/2NnDUW8yE3a+tTaSfJ/jeKT2kVSJOjTrjbv+S8=;
 b=BtXqo6i8vCr5QAYdIlXIl+3WSU3SgWVu5TpzrjNOkwFjCUERadq3za52tID68UV/JrxVcA6mQ
 nYt2NtudzxaB/Fis+COvXhk+ruHL01vQdXTR33R/DCv7MQA+RCsxCop
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The generic function from the sysfs core can replace the custom one.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
This is a replacement for [0], as Alexei was not happy about BIN_ATTR_SIMPLE_RO()

[0] https://lore.kernel.org/lkml/20241122-sysfs-const-bin_attr-bpf-v1-1-823aea399b53@weissschuh.net/
---
 kernel/bpf/sysfs_btf.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
index fedb54c94cdb830a4890d33677dcc5a6e236c13f..81d6cf90584a7157929c50f62a5c6862e7a3d081 100644
--- a/kernel/bpf/sysfs_btf.c
+++ b/kernel/bpf/sysfs_btf.c
@@ -12,24 +12,16 @@
 extern char __start_BTF[];
 extern char __stop_BTF[];
 
-static ssize_t
-btf_vmlinux_read(struct file *file, struct kobject *kobj,
-		 struct bin_attribute *bin_attr,
-		 char *buf, loff_t off, size_t len)
-{
-	memcpy(buf, __start_BTF + off, len);
-	return len;
-}
-
 static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init = {
 	.attr = { .name = "vmlinux", .mode = 0444, },
-	.read = btf_vmlinux_read,
+	.read_new = sysfs_bin_attr_simple_read,
 };
 
 struct kobject *btf_kobj;
 
 static int __init btf_vmlinux_init(void)
 {
+	bin_attr_btf_vmlinux.private = __start_BTF;
 	bin_attr_btf_vmlinux.size = __stop_BTF - __start_BTF;
 
 	if (bin_attr_btf_vmlinux.size == 0)

-- 
2.47.1


