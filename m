Return-Path: <bpf+bounces-9038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE55F78E9DC
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 12:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77622281489
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 10:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6BD8F47;
	Thu, 31 Aug 2023 10:01:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324AE79F8;
	Thu, 31 Aug 2023 10:01:56 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA3ACED;
	Thu, 31 Aug 2023 03:01:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401e6ce2d9fso1967685e9.1;
        Thu, 31 Aug 2023 03:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693476114; x=1694080914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jf6tZ7D0c+M0qI7hvLDPOPzPZwynaJptNs7Uyj1gb8Q=;
        b=AtXagKEMO6VcXa1HNZ7pfmnczL18yHg4leuvodkw+4HU+urfNDM0mZ4E74Gx3N4wmL
         WH2fBZywE1OJvHuzHvIxPlmOQUdybuFPV7qw3Fkm8EewDGgdv1D5TEE9MLxibbpojhTB
         mL09kZtKxFX6vyrTGE5Enbld+Qz2ZH51zfT5OPYbE/5rISGr7/g/hQfUKohhwKcXERW0
         2X3WWRAyx0WOGH7icQ29QqgsSWZfdsqQ7Xh/NhBdlVbzz6oBIJB3E8uAVDtcvLNeBpUT
         TFBKFJiNiOdRuyGqNfaGk6kpmCECSIR61ddKkbXZM30CieG52953BLLc8hzS+srqZtvp
         rebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693476114; x=1694080914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jf6tZ7D0c+M0qI7hvLDPOPzPZwynaJptNs7Uyj1gb8Q=;
        b=cTv5xwEAaFbDAXDEvfTZzVWvCdEGLWPrB5beYyDJwkiz7RGo7RGORtBRte+KCzB85k
         E8Ophn4m5kFhlhaIN8SGbr4BXgfVjVvxkiMvQxDXb3mgIVuEjEg10dgSugCDWY1LaTvQ
         lcVE7BxeVHdVp9yVbmz4mUmxsw7Razwtd9j1BB5HRtPBIQZcG3bQZYzfkEG0qytz2ris
         yf98f0RwfAPdgJjOQCOtJdso3jxnGLTpXVa5yzLQjvIsUugris28QvuZfqOylvidFDnV
         rkAitMHqYlwRb9wNw5LXEcK4cotFzk5EIhQ4BNyiPLv83VDtmd2uxbsuiUQ+yLAkUKBC
         V9ng==
X-Gm-Message-State: AOJu0Yyj2X/PbcTTUYbG6by2K50PYgj1dMzPw77mcHrbYuD5bX96ojSr
	Rhlsxhe10pLkNIP8Z6SJ9qA=
X-Google-Smtp-Source: AGHT+IHJBNarGEnAVttlcOVTsuzNYCs8aNYRRrByvC7hNX2cBCsObNoUbRhwX8rEdcVJSl6T1eey8A==
X-Received: by 2002:a5d:4b0d:0:b0:317:5f08:32a3 with SMTP id v13-20020a5d4b0d000000b003175f0832a3mr3385722wrq.6.1693476113471;
        Thu, 31 Aug 2023 03:01:53 -0700 (PDT)
Received: from localhost.localdomain (h-176-10-144-222.NA.cust.bahnhof.se. [176.10.144.222])
        by smtp.gmail.com with ESMTPSA id d15-20020adffd8f000000b00317ab75748bsm1664751wrr.49.2023.08.31.03.01.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Aug 2023 03:01:52 -0700 (PDT)
From: Magnus Karlsson <magnus.karlsson@gmail.com>
To: magnus.karlsson@intel.com,
	bjorn@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	maciej.fijalkowski@intel.com
Cc: jonathan.lemon@gmail.com,
	bpf@vger.kernel.org,
	syzbot+822d1359297e2694f873@syzkaller.appspotmail.com
Subject: [PATCH bpf v2] xsk: fix xsk_diag use-after-free error during socket cleanup
Date: Thu, 31 Aug 2023 12:01:17 +0200
Message-ID: <20230831100119.17408-1-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Magnus Karlsson <magnus.karlsson@intel.com>

Fix a use-after-free error that is possible if the xsk_diag interface
is used after the socket has been unbound from the device. This can
happen either due to the socket being closed or the device
disappearing. In the early days of AF_XDP, the way we tested that a
socket was not bound to a device was to simply check if the netdevice
pointer in the xsk socket structure was NULL. Later, a better system
was introduced by having an explicit state variable in the xsk socket
struct. For example, the state of a socket that is on the way to being
closed and has been unbound from the device is XSK_UNBOUND.

The commit in the Fixes tag below deleted the old way of signalling
that a socket is unbound, setting dev to NULL. This in the belief that
all code using the old way had been exterminated. That was
unfortunately not true as the xsk diagnostics code was still using the
old way and thus does not work as intended when a socket is going
down. Fix this by introducing a test against the state variable. If
the socket is in the state XSK_UNBOUND, simply abort the diagnostic's
netlink operation.

Fixes: 18b1ab7aa76b ("xsk: Fix race at socket teardown")
Reported-and-tested-by: syzbot+822d1359297e2694f873@syzkaller.appspotmail.com
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
v1 -> v2:
  * Added READ_ONCE for the state variable [Magnus]
  * Improved commit message [Maciej]

 net/xdp/xsk_diag.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
index c014217f5fa7..22b36c8143cf 100644
--- a/net/xdp/xsk_diag.c
+++ b/net/xdp/xsk_diag.c
@@ -111,6 +111,9 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
 	sock_diag_save_cookie(sk, msg->xdiag_cookie);

 	mutex_lock(&xs->mutex);
+	if (READ_ONCE(xs->state) == XSK_UNBOUND)
+		goto out_nlmsg_trim;
+
 	if ((req->xdiag_show & XDP_SHOW_INFO) && xsk_diag_put_info(xs, nlskb))
 		goto out_nlmsg_trim;


base-commit: 7d35eb1a184a3f0759ad9e9cde4669b5c55b2063
--
2.42.0

