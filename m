Return-Path: <bpf+bounces-9631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 602B479A74A
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 12:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E5F1C20836
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 10:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA02CF9F8;
	Mon, 11 Sep 2023 10:34:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BFCF9E7;
	Mon, 11 Sep 2023 10:34:42 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C7EE5F;
	Mon, 11 Sep 2023 03:34:41 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so72589331fa.2;
        Mon, 11 Sep 2023 03:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694428479; x=1695033279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCQEu/ILqoq7skisc09M8SCm5EUq/HC3ZQfY+FZ+QRY=;
        b=RIZHRvPIMnqDZyF2bfa2HpIYt0H0q6LPJd8I+nY4iE9CSsGeMSxO159HycFDPerDn8
         3Nna0KTL1tNnxfJMekW77jMDey9z4p2Zvy2864q2e/1yFqm2wKwb1eHVwxqy0KFZomlZ
         XqAqGrgdfA6MOeo2zUeiXeXDOmDGeofHsH6geQ+awE1Hbfi10b7tggi0vXQ6ZkjE2b8O
         qxGxjOdcwTlrzh+eat4zl1uCC90+mSsmEKLx2gyN5DFa1llrj6ySogjo36C2XJjXgyBQ
         1wKTz0qI7WmHQ40QMooa61FTyvBRVYo7JdtsqGBWpAxO6P0FM2lMKPgI3+7EaqRusXQF
         tz3A==
X-Gm-Message-State: AOJu0Yxrii0gFRZxsDQu/Jy2rkM60zBroGy5Azk+Ij/+ZMxBELyLNiDJ
	bQ36Q8i9pXctD21QJuG84Mo=
X-Google-Smtp-Source: AGHT+IHPAvnfK5eQx9WB+bvBZJYtdCmswy86l78DIKlKeO7/AZnaLfuCWxfsNFuKxjPBO26b8HWvgw==
X-Received: by 2002:a2e:3609:0:b0:2bc:d993:bdaa with SMTP id d9-20020a2e3609000000b002bcd993bdaamr8173814lja.18.1694428479114;
        Mon, 11 Sep 2023 03:34:39 -0700 (PDT)
Received: from localhost (fwdproxy-cln-011.fbsv.net. [2a03:2880:31ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090611c600b0099cf9bf4c98sm5192137eja.8.2023.09.11.03.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 03:34:38 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: sdf@google.com,
	axboe@kernel.dk,
	asml.silence@gmail.com,
	willemdebruijn.kernel@gmail.com,
	kuba@kernel.org,
	martin.lau@linux.dev,
	krisman@suse.de
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	io-uring@vger.kernel.org,
	pabeni@redhat.com
Subject: [PATCH v5 5/8] io_uring/cmd: return -EOPNOTSUPP if net is disabled
Date: Mon, 11 Sep 2023 03:34:04 -0700
Message-Id: <20230911103407.1393149-6-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911103407.1393149-1-leitao@debian.org>
References: <20230911103407.1393149-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Protect io_uring_cmd_sock() to be called if CONFIG_NET is not set. If
network is not enabled, but io_uring is, then we want to return
-EOPNOTSUPP for any possible socket operation.

This is helpful because io_uring_cmd_sock() can now call functions that
only exits if CONFIG_NET is enabled without having #ifdef CONFIG_NET
inside the function itself.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 io_uring/uring_cmd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 60f843a357e0..a7d6a7d112b7 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -167,6 +167,7 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
 
+#if defined(CONFIG_NET)
 int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
 	struct socket *sock = cmd->file->private_data;
@@ -193,3 +194,10 @@ int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	}
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_sock);
+#else
+int io_uring_cmd_sock(struct io_uring_cmd *cmd, unsigned int issue_flags)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
-- 
2.34.1


