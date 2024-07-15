Return-Path: <bpf+bounces-34818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CE7931336
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 13:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3451C21887
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 11:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEA518C180;
	Mon, 15 Jul 2024 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8IP+JyD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2294018C16F;
	Mon, 15 Jul 2024 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043440; cv=none; b=S362yTkKHz6+OyLHhx9fNnewnVu7MMlyaDH3dInPsQSVtpeWjU7llxginWCCwfZHZKvAp1+dLZ5uP46dFzLBksBeG9tL9LejD3c8jBflY6JE7FWzvrDJJzEKOhXmdcHXLeO2O75VsJkDIYtmGy+7Elr5GE0J5d/EnKRDa0UYGTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043440; c=relaxed/simple;
	bh=o/a/Ba7rsdITDgqm6HVWWmOT55dq8eAXkBjCNAe4fRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WoXOnANGrGVZwmpfuhIn0CY1+QKtFK4b6kH0f47iqX6/TVjHiaBKdjs8FPh9CxMJqopZmJNxiuyjITohEve4KNFjJZSf9v5kVvw222hOT2fOFwQDflFP+QNA7T1h9scqkMj+/63+uLNUHaV0nrbeOR2lHwSG3+g/l6Ggf6bAQYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8IP+JyD; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7669d62b5bfso2392027a12.1;
        Mon, 15 Jul 2024 04:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721043438; x=1721648238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lONwT0616zEWl9r58neBroQQGwP8PqCEA9oNIHLUavQ=;
        b=S8IP+JyDL15WoycWGivoQLqyOq0veM03pkWf1hT80nNs4xOcRHiZgW5Df9cBJC3BiY
         19rFhOAdQpBeMAT/b3hfh5Mh7yah30Mdcsrk3IDJOAy5gmzqCjsynzSv19tGl7l5zz/j
         HFlvodLWw6mN+KOZm6xQu2JEv2ja1UGXjGqZJkQc0oTtPorXFNR8L1NcpT7YtNnMkaJa
         4pzlY9u96aqZ5+vFGX1I6Y0IWB2tProet0eb7PYo43Gvh+59CQN9CYafn7j7OSjE9LH9
         LFHS9A7Mp0LJwymu2koLW0Y96W6bNNjeX1DPbGvlH6z1nhtnbioXy0ngnWJ7cZ1h+Qy4
         q0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721043438; x=1721648238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lONwT0616zEWl9r58neBroQQGwP8PqCEA9oNIHLUavQ=;
        b=Ll8RZQQZ5pTlbXjEzlr+Kj74CqX/6Gp0UPdul+Sqo+ZLcVKIgJ0ww5VW4M76Ai3e3t
         1OMym6L/Ks2DfzUYiMNT9hi1qijFDg9L8O1F9sAhA497Son9aS0IAdk5BNO38TjccX3e
         5nJqI8fzhfzqvneszTTEDcJpREvnuayITiYtwzusRxpyBNAGrKUjx+0NKJeRPoYsP4hA
         3eXC5DoppHttrqgREd0USQElmgZwEnlQ8bv4VmSLBW5kZUH2Jk6mQjRtjmgN4YOpkgIo
         kk1AuPCNloaPMxAJq+R7wtKk8K6PU2TOE2komdRn/b9IWxBXDaVLp6Hg7YNHYIa8+OTJ
         Ro7g==
X-Forwarded-Encrypted: i=1; AJvYcCX1gIfixh+DzUu+yu2sC85TQCZtkYzJpVQFD9W6tdf6on/W24IxQ7qGpTydahL3nJaOIDdlhlK/M/27b5YYPt06+3ghOF8+6AUzGHKpkq16Tc8MNWU5P7Jf1BbK4/qxEMqB
X-Gm-Message-State: AOJu0YxK1XiHEeQRhEyRX6skx5KH99KEvT+sFp3eBUx6cqVVBjVQg0bo
	Syhpcm8muVDIDYlBLUaQ4CLSKs7UPqh1IVerEfkMyPt6jYA8vt3ILubgz2EgE+U=
X-Google-Smtp-Source: AGHT+IH1+D8DGIRAl5UGSJFZW8yfU32kY9CstdGZGksq3G5+Uhc9zJoAgHARABp5lIDmfm0RAxodEg==
X-Received: by 2002:a05:6a20:9191:b0:1bd:207a:da31 with SMTP id adf61e73a8af0-1c2982285femr19750597637.23.1721043438069;
        Mon, 15 Jul 2024 04:37:18 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc5f7c0sm38877995ad.307.2024.07.15.04.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 04:37:17 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	chen.dylane@gmail.com
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 3/3] bpftool: add document for net attach/detach on tcx subcommand
Date: Mon, 15 Jul 2024 19:37:04 +0800
Message-Id: <20240715113704.1279881-4-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715113704.1279881-1-chen.dylane@gmail.com>
References: <20240715113704.1279881-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds sample output for net attach/detach on
tcx subcommand.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 .../bpf/bpftool/Documentation/bpftool-net.rst | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-net.rst b/tools/bpf/bpftool/Documentation/bpftool-net.rst
index 348812881297..64de7a33f176 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-net.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-net.rst
@@ -29,7 +29,7 @@ NET COMMANDS
 | **bpftool** **net help**
 |
 | *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
-| *ATTACH_TYPE* := { **xdp** | **xdpgeneric** | **xdpdrv** | **xdpoffload** }
+| *ATTACH_TYPE* := { **xdp** | **xdpgeneric** | **xdpdrv** | **xdpoffload** | **tcxingress** | **tcxegress** }
 
 DESCRIPTION
 ===========
@@ -69,6 +69,8 @@ bpftool net attach *ATTACH_TYPE* *PROG* dev *NAME* [ overwrite ]
     **xdpgeneric** - Generic XDP. runs at generic XDP hook when packet already enters receive path as skb;
     **xdpdrv** - Native XDP. runs earliest point in driver's receive path;
     **xdpoffload** - Offload XDP. runs directly on NIC on each packet reception;
+    **tcxingress** - Ingress TC. runs on ingress net traffic;
+    **tcxegress** - Egress TC. runs on egress net traffic;
 
 bpftool net detach *ATTACH_TYPE* dev *NAME*
     Detach bpf program attached to network interface *NAME* with type specified
@@ -178,3 +180,21 @@ EXAMPLES
 ::
 
       xdp:
+
+|
+| **# bpf net attach tcxingress name tc_prog dev lo**
+| **# bpf net**
+|
+
+::
+      tc:
+      lo(1) tcx/ingress tc_prog prog_id 29
+
+|
+| **# bpf net attach tcxingress name tc_prog dev lo**
+| **# bpf net detach tcxingress dev lo**
+| **# bpf net**
+|
+
+::
+      tc:
-- 
2.34.1


