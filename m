Return-Path: <bpf+bounces-46169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE819E5D50
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 18:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C164162F7B
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 17:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C985227B81;
	Thu,  5 Dec 2024 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="N3aE/who"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E619622576B;
	Thu,  5 Dec 2024 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420142; cv=none; b=cAMYePGS4KflR7oG2rAA1EZSwxZ9uzxQcje1cbdmVl0HCNVF0T58Ck0dw3sw+59HJgBXW0lQjKr/u/uW12mx8TvhBN3oNJp4+Zl20D0pniBn0X8JTUyxdZJHaFlfbadKmpebCY7kjggvDJtPZU5TNGbJRwZeWXSDcwi1kEB2O8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420142; c=relaxed/simple;
	bh=5LgMscy8fNMxkSnBk89bFZtOweO+ubs1BjcR/pPmVkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z7rM1xUWHSVsqX/iK4iqrbGpXolqDy4kJlKN7X2G5KCLhY0lgsqLrMZobya5cTpbvu5HS3b6GbUS25mxk/4zuDVTPPgunUmTfZe1T3v/kzte7bJEiAGUp7eTP44G+N0iwe4ESJL/oQv1FUjed5JQA7rpqUodLjKq8YC+HIq57qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=N3aE/who; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733420137;
	bh=5LgMscy8fNMxkSnBk89bFZtOweO+ubs1BjcR/pPmVkk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N3aE/whoh0KniNiOdttnlBkPGxTSvIZRmCSS4tM8MAPBalxnpZjR3OoaUI3/xXTIo
	 fNNtedHUR+sbdbMnShhmacrx6v0eWcsU3TYdFPa16wzAGR6XJ7jGXiDVl6/n1HjBz+
	 JSalKw3c9i0jJhAAfKdCvzOzYA+mk+CgGniZjEaI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 05 Dec 2024 18:35:14 +0100
Subject: [PATCH 2/4] platform/x86: wmi-bmof: Switch to
 sysfs_bin_attr_simple_read()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-sysfs-const-bin_attr-simple-v1-2-4a4e4ced71e3@weissschuh.net>
References: <20241205-sysfs-const-bin_attr-simple-v1-0-4a4e4ced71e3@weissschuh.net>
In-Reply-To: <20241205-sysfs-const-bin_attr-simple-v1-0-4a4e4ced71e3@weissschuh.net>
To: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 bpf@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733420137; l=1583;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=5LgMscy8fNMxkSnBk89bFZtOweO+ubs1BjcR/pPmVkk=;
 b=FFE0LC+lWyL41OWKcLih/cJP43TX/qUmNdEXnIWxYkdVLt0K7dsR35ynGht17m6UhezsKb9iC
 ql1zd1NvQ0BAvkF0dWD1XVGmm/v8XCf3L6eiabSOtHoMnaMvizVK/An
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The generic function from the sysfs core can replace the custom one.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/x86/wmi-bmof.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/wmi-bmof.c
index df6f0ae6e6c7904f97c125297a21166f56d0b1f0..e6c217d70086a2896dc70cf8ac1c27dafb501a95 100644
--- a/drivers/platform/x86/wmi-bmof.c
+++ b/drivers/platform/x86/wmi-bmof.c
@@ -25,15 +25,6 @@ struct bmof_priv {
 	struct bin_attribute bmof_bin_attr;
 };
 
-static ssize_t read_bmof(struct file *filp, struct kobject *kobj, struct bin_attribute *attr,
-			 char *buf, loff_t off, size_t count)
-{
-	struct bmof_priv *priv = container_of(attr, struct bmof_priv, bmof_bin_attr);
-
-	return memory_read_from_buffer(buf, count, &off, priv->bmofdata->buffer.pointer,
-				       priv->bmofdata->buffer.length);
-}
-
 static int wmi_bmof_probe(struct wmi_device *wdev, const void *context)
 {
 	struct bmof_priv *priv;
@@ -60,7 +51,8 @@ static int wmi_bmof_probe(struct wmi_device *wdev, const void *context)
 	sysfs_bin_attr_init(&priv->bmof_bin_attr);
 	priv->bmof_bin_attr.attr.name = "bmof";
 	priv->bmof_bin_attr.attr.mode = 0400;
-	priv->bmof_bin_attr.read = read_bmof;
+	priv->bmof_bin_attr.read_new = sysfs_bin_attr_simple_read;
+	priv->bmof_bin_attr.private = priv->bmofdata->buffer.pointer;
 	priv->bmof_bin_attr.size = priv->bmofdata->buffer.length;
 
 	ret = device_create_bin_file(&wdev->dev, &priv->bmof_bin_attr);

-- 
2.47.1


