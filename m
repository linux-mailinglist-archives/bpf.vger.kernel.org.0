Return-Path: <bpf+bounces-7250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF5B773EE6
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 18:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4851C20B7F
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 16:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168E61643E;
	Tue,  8 Aug 2023 16:37:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48CB15AF8;
	Tue,  8 Aug 2023 16:37:49 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED031458D;
	Tue,  8 Aug 2023 09:37:36 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3fe12baec61so49809545e9.2;
        Tue, 08 Aug 2023 09:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512617; x=1692117417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=poXIN1qcm1mBgNPqEzhboKC2+bYbXxru4TDBolh6FdE=;
        b=GUsMOGemXr5xK1uso6LK91nkUDP0bg339cyAUktGmrr+UOR/4bWHSV7ZztR+rboZXs
         pT04BqZPDtHcJUrD0/TbcFaWxevzQsS1X5xuNk8m6CERBF2ME/ylns06NyfRxvaICxcu
         OqWtv+l8EROL6yQAFVBH3i1LRfrlGpKIOC/E0IZh+Ka9BFKirt/IPcwDA8oZHL4ohSRQ
         BvJMWi2EseNpceI/JI8QRSGQG6eO7vJhUFUjEggDekyh62YwkEOvNjyGtf7wA8BTGZdN
         TpEXdpJERZOkhHZKusY8T7y5HIBBnrgyRVq30Ap4uWWNkiGbqGyDGqbdjNQ0axoFBLDn
         74vQ==
X-Gm-Message-State: AOJu0YysYYBNy/qpUs7CzqmTRp5rzwQIlhNdUtssVYv5R5uBLfyxAtem
	1i7ijAJfGjW7F5cHCMgKlQhiaammt0g=
X-Google-Smtp-Source: AGHT+IEhtROCWEOran/dhDokRbAF7S3YnYi+PrNq/rKwkr1ke/zSZrffti0r8XOG/549ipMIkjst3w==
X-Received: by 2002:a50:ec99:0:b0:523:7b1:3720 with SMTP id e25-20020a50ec99000000b0052307b13720mr9558535edr.15.1691502068043;
        Tue, 08 Aug 2023 06:41:08 -0700 (PDT)
Received: from localhost (fwdproxy-cln-118.fbsv.net. [2a03:2880:31ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id v18-20020aa7d652000000b005233885d0c6sm2734886edr.41.2023.08.08.06.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 06:41:07 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: sdf@google.com,
	axboe@kernel.dk,
	asml.silence@gmail.com,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	io-uring@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH v2 4/8] io_uring/cmd: Extend support beyond SOL_SOCKET
Date: Tue,  8 Aug 2023 06:40:44 -0700
Message-Id: <20230808134049.1407498-5-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808134049.1407498-1-leitao@debian.org>
References: <20230808134049.1407498-1-leitao@debian.org>
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

Add generic support for SOCKET_URING_OP_SETSOCKOPT, expanding the
current case, that just execute if level is SOL_SOCKET.

This implementation basically calls sock->ops->setsockopt() with a
kernel allocated optval;

Since the callback for ops->setsockopt() is already using sockptr_t,
then the callbacks are leveraged to be called directly, similarly to
__sys_setsockopt().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 io_uring/uring_cmd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 5404b788ca14..dbba005a7290 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -205,10 +205,14 @@ static inline int io_uring_cmd_setsockopt(struct socket *sock,
 	if (err)
 		return err;
 
-	err = -EOPNOTSUPP;
 	if (level == SOL_SOCKET && !sock_use_custom_sol_socket(sock))
 		err = sock_setsockopt(sock, level, optname,
 				      USER_SOCKPTR(optval), optlen);
+	else if (unlikely(!sock->ops->setsockopt))
+		err = -EOPNOTSUPP;
+	else
+		err = sock->ops->setsockopt(sock, level, optname,
+					    USER_SOCKPTR(koptval), optlen);
 
 	return err;
 }
-- 
2.34.1


