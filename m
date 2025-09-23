Return-Path: <bpf+bounces-69479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F02B97700
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 22:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58903B724E
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 20:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB79130AAA9;
	Tue, 23 Sep 2025 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B73wVImF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C5830C34A
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758657655; cv=none; b=YP0gJoNtzpagVkHI+AETonT4oXQblmZRwlm2+KWR4j5PN6echH423YBpVj5t7Bc4x3wTx82a2fOF4+AFTonRBgn1GoJM6uT76jQ8Z66ah6YAlQvO/ozmhnOzoTmtXPTi18GAdYnwupij9EfjpEF2xoXcaOaFaK1IOJr/M39y3pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758657655; c=relaxed/simple;
	bh=C8XXts6akLb11nM2mMQrQ1mX2Cb7JSe8mH+9EyknL/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YoA7SaEVqSmhX6sIWRPedX8fWNFE/QpDzo34qqZNQ/F7Ye4NO9Bsd/QM05+TcOse34o5fVdDnNiSU8WMR2r0VI4ndAEucv7eb46ZSgZZfKzrWONAdG7VVtKida1h7WODFZi3SjK+Jf5A5SN1vLARr4zlG/63XfQ74Xv+uCk5KaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B73wVImF; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b2d0e205ca1so39364366b.0
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 13:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758657652; x=1759262452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFnHRlaDkZFQz8z/nxD9a5/SArA8MCeQHjKgdaq4v7Q=;
        b=B73wVImFx1/+bpOdlPvGQFEHw3yidTfo/uteXEpzUyPoDoqJO5G37eqXhHrdb+eNJ/
         8SburhE9p0/e34iNF29NQVr0H5ziQ2ov5Cqypk2naHOqWHHibdrLLEbB2I6oxaUMDjsC
         p2obl+iQhZCLZ0ZSP4iPXETSCYoj6Gl581BO0L1sG/Q/KAjIGMLB5M6VOOEIWh8hj4e9
         fDVVwTUmI7yFrtg29oXPGlr4HY1V9/xa4weclP5c+lS+bgoo+5buo+LKZ04Qgl/bnCfx
         MEi0A056FjNTGAfltLoSOdXZKBwhqlYQcM80mMoPsB4/sus4bqHQbknvp+Qbnp9mMkv0
         WqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758657652; x=1759262452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFnHRlaDkZFQz8z/nxD9a5/SArA8MCeQHjKgdaq4v7Q=;
        b=hImGrHGjbRu21MBy6r7ODddcTxVsBvmiJammtDrbDd3m3uZRP84aNxmfC62OAI4dh2
         9RZGeVA//AuZmnfu2WkySAkiOYtuRMIWFuvFs6QXR/ouTz8ugHYQmwe0sQRErWgsaahp
         4j67S4taIaeuqgEr87J6O9yg0o05lseP8RGvsUywZnnfRUJMWjgc5pJVZrFJ+V+3880N
         K89jaqGLjSFf575OlAejOO+mAIU1IODVGVkF7k3FVu5ByNJMyF6idDimUjWGzV9cupMl
         tcixsdwVFHpAJjkXv+4u85xUCcrmgl5rQG2JEYLnfpa2M8oW5/GkgPuHCtUNie61M9I1
         43tA==
X-Forwarded-Encrypted: i=1; AJvYcCUZqCirWvkwFSk0M9sUu7TiN7VeNxNXrHhmNxog56sRENBf9lpe2BjYUW8HRULHciaMaYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoon2qnImuGtqz88LnuR0o2bST1QaQzbi0TYcONoywjowiB/qq
	5inO1YYUdaSZmOAPK+qhq2YXTJ7frFPqUyH0eW3tk1/6yd5gkGlTookp
X-Gm-Gg: ASbGncsH47/gm72geKq1ju/kDJkoaZDXhZrirQTKaz5/P1Z/I2q8o3lIYT/0FQzb1fK
	WcI1jotyDs1pDqYPxc+YxxU8H4CJoTrDqMOyzQM0OlXpOvg08CN1Y7aMDLFs6SXQC8mT9YVah13
	sgwtbMk3OkkRoq86oQDvjFxz+YBao9v/0Zbx1aZAfn4y/QfHpuFfxt4hNrYz+cVAkQOiA1WhQ2r
	rsRWdIvLe9UYaHB4ZKvZtUif9UxXLORQJnM8Nm+hD5I2CsNSO+c2psNEpj8SG00ajwMD1teyDpy
	GoZIQhyL6jck5ijDKwC5eYLG8Nbe/Z/YUOHvpWvcobVuQP5O18vWsorooJhkW6y4nHSjNBBwMq3
	KzLknY6ezmJe7mdvnqzjcN9q7
X-Google-Smtp-Source: AGHT+IGhKcZdV0r8YP2ON3pdAtvi9EACajla8mdLJY/F2fjwqzyOEqYb9k1Ezx6pq7ms/ARYTztc8Q==
X-Received: by 2002:a17:907:d8f:b0:b04:2d89:5d3a with SMTP id a640c23a62f3a-b302b80a6femr234862766b.7.1758657651892;
        Tue, 23 Sep 2025 13:00:51 -0700 (PDT)
Received: from bhk ([165.50.1.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2ac72dbe92sm672074066b.111.2025.09.23.13.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:00:51 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	matttbe@kernel.org,
	chuck.lever@oracle.com,
	jdamato@fastly.com,
	skhawaja@google.com,
	dw@davidwei.uk,
	mkarsten@uwaterloo.ca,
	yoong.siang.song@intel.com,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org
Cc: horms@kernel.org,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH RFC 3/4] uapi: netdev: Add XDP RX queue index metadata flags
Date: Tue, 23 Sep 2025 22:00:14 +0100
Message-ID: <20250923210026.3870-4-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added NETDEV_XDP_RX_METADATA_QUEUE_INDEX flag to both netdev.h files
for the bpf_xdp_metadata_rx_queue_index() function.

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 include/uapi/linux/netdev.h       | 3 +++
 tools/include/uapi/linux/netdev.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 48eb49aa03d4..59033a607c16 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -46,11 +46,14 @@ enum netdev_xdp_act {
  *   hash via bpf_xdp_metadata_rx_hash().
  * @NETDEV_XDP_RX_METADATA_VLAN_TAG: Device is capable of exposing receive
  *   packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
+ * @NETDEV_XDP_RX_METADATA_QUEUE_INDEX: Device is capable of exposing receive HW
+ *   queue index via bpf_xdp_metadata_rx_queue_index().
  */
 enum netdev_xdp_rx_metadata {
 	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
 	NETDEV_XDP_RX_METADATA_HASH = 2,
 	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
+	NETDEV_XDP_RX_METADATA_QUEUE_INDEX = 8,
 };
 
 /**
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 48eb49aa03d4..59033a607c16 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -46,11 +46,14 @@ enum netdev_xdp_act {
  *   hash via bpf_xdp_metadata_rx_hash().
  * @NETDEV_XDP_RX_METADATA_VLAN_TAG: Device is capable of exposing receive
  *   packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
+ * @NETDEV_XDP_RX_METADATA_QUEUE_INDEX: Device is capable of exposing receive HW
+ *   queue index via bpf_xdp_metadata_rx_queue_index().
  */
 enum netdev_xdp_rx_metadata {
 	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
 	NETDEV_XDP_RX_METADATA_HASH = 2,
 	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
+	NETDEV_XDP_RX_METADATA_QUEUE_INDEX = 8,
 };
 
 /**
-- 
2.51.0


