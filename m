Return-Path: <bpf+bounces-19756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268C0830EE8
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 22:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89A16B2227F
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 21:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF9528E08;
	Wed, 17 Jan 2024 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8dUzz8h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83FF28DBC;
	Wed, 17 Jan 2024 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528593; cv=none; b=KNHheJuTawvwJju3h5PFw1Dkbg9mvUxyzkTI/htAvpscRjNuell8oE9KkMF/DYvsoCBUcoPsmLJSWFNqN8imgYnw/+87KoSOz64FRuKxbmCneiDA5DEH8+GdJ4HqUakkd8yKZTpVBPMVEBn0QKIIrJvbQUA+AYloDe0oWZoQq/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528593; c=relaxed/simple;
	bh=KvEeiMTRQ8nPj5vMXR+aJYvdZbcqYraXQckJ/aCdrmI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=OEU0thofckOsb+BmptKyeZIlxW8vkEruXxd36peMoj6uXswcZkA0Q9fTCroTLAUI0nS/xvsdLoUxabwrF0iEa8BAybmCn0pAwQyZYjiWJM2P2YpplpiAxLNRJoiXwnW+LMbNMTg4rNechEBOT6AI+tYjNQg0b/CARZfQ1+HumQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8dUzz8h; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bd884146e9so1690601b6e.0;
        Wed, 17 Jan 2024 13:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705528591; x=1706133391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/np8Zmn2uDY1EaXBes4tB+ptV29sKPAVxcQTxxgtFYI=;
        b=Y8dUzz8h5Qrbst4i3Sx8ZjUgrTrESvjEi7Uygo9XGdtKA2kKj3/v5CpB6TrLJBfpIB
         vt4TSRyIjvjmlLu5gfNQpKFNwqJ87z5Gka0VAfvEVKvO9flG4kj6H6nir5lQnZ7NjFNy
         rxC7AMM4selFNJhNPibXhMq766Jb3XxyD83Y5ettJOCma8MAzZKwGBNU/rUXhU1/9a20
         WAqaA1hria18O5n0ln7bolgzoeUYvTTCpRtgDB/wp1t9FdDt9Br32bKQg/iv7RFZUAtH
         /awpNuc/dfpWlZLDMg3pdguFXke4rh9sjoCM7iQqHZTndHUsX/ZIZax72OsLQYn9SrsM
         WBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705528591; x=1706133391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/np8Zmn2uDY1EaXBes4tB+ptV29sKPAVxcQTxxgtFYI=;
        b=c5yDYTEBl/p74r6hvW8K4Taa6q47P9RfTfjiip6mr7QiWz3vw8XGyaD8CLAQ1GWryb
         x1CFSfv7GILyl+AGv++sM1+pXRcamqr4QjeIyqjrOAK3H/dJEDBoe2xzmDamn106HCoU
         E9FFjpTIrtzwAWIXVpxDC2y0cXH8aJL6TWqeeyBOOPuOaqylsV9uR+26mouWxeEpoC+M
         DtsMrpgOabjvMpLA4LZIMwg/WQAGadFlBAzPQmb7H/avHysPwblJFY+IlUH54X+gF2Xb
         EOxPFGEnVGkQEEBtyddu3Jd79vDffCoyoXc6aJZywAwRMB+w+af4c8zh7OpqjTKLFSNx
         xm0g==
X-Gm-Message-State: AOJu0YwEXqBunIN+tmYv8pVSY40n5V7TBl5Q+Sj8ZQd9Sqo3q6R2idQJ
	myyByD3pk5pisOx6EQ96i6TEUhLysCo=
X-Google-Smtp-Source: AGHT+IGFtbIK4ffShR13uiwOGVAxd90fNCsYKN6HzE93RWiy4ExZjjJljjkPRshBgrKwUu6UCs9ITw==
X-Received: by 2002:a05:6808:d4e:b0:3bd:8ed9:580a with SMTP id w14-20020a0568080d4e00b003bd8ed9580amr3506613oik.78.1705528590848;
        Wed, 17 Jan 2024 13:56:30 -0800 (PST)
Received: from n36-183-057.byted.org ([147.160.184.91])
        by smtp.gmail.com with ESMTPSA id hj11-20020a05622a620b00b00428346b88bfsm6105263qtb.65.2024.01.17.13.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 13:56:30 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	yangpeihao@sjtu.edu.cn,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	sdf@google.com,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com
Subject: [RFC PATCH v7 6/8] tools/libbpf: Add support for BPF_PROG_TYPE_QDISC
Date: Wed, 17 Jan 2024 21:56:22 +0000
Message-Id: <813b2de18b94389f4df53f21b8a328e1c2fdda13.1705432850.git.amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1705432850.git.amery.hung@bytedance.com>
References: <cover.1705432850.git.amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While eBPF qdisc uses NETLINK for attachment, expected_attach_type is
required at load time to verify context access from different programs.
This patch adds the section definition for this.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 tools/lib/bpf/libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e067be95da3c..0541f85b4ce6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8991,6 +8991,10 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("struct_ops.s+",	STRUCT_OPS, 0, SEC_SLEEPABLE),
 	SEC_DEF("sk_lookup",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE),
 	SEC_DEF("netfilter",		NETFILTER, BPF_NETFILTER, SEC_NONE),
+	SEC_DEF("qdisc/enqueue",	QDISC, BPF_QDISC_ENQUEUE, SEC_ATTACHABLE_OPT),
+	SEC_DEF("qdisc/dequeue",	QDISC, BPF_QDISC_DEQUEUE, SEC_ATTACHABLE_OPT),
+	SEC_DEF("qdisc/reset",		QDISC, BPF_QDISC_RESET, SEC_ATTACHABLE_OPT),
+	SEC_DEF("qdisc/init",		QDISC, BPF_QDISC_INIT, SEC_ATTACHABLE_OPT),
 };
 
 int libbpf_register_prog_handler(const char *sec,
-- 
2.20.1


