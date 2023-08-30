Return-Path: <bpf+bounces-8991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D3A78D6E3
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 17:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC661C208C4
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 15:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7714E7465;
	Wed, 30 Aug 2023 15:17:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3C06FD5;
	Wed, 30 Aug 2023 15:17:36 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8401A2;
	Wed, 30 Aug 2023 08:17:35 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401ef656465so1858085e9.1;
        Wed, 30 Aug 2023 08:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693408653; x=1694013453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PeStNgIFyhYkU5cmLWBgd4BV9abdD1hSxAhShc4Rniw=;
        b=a8XCeYMc3Un1JNT/RIWo7+7u1LzId6h2HH6LrSEbNDWfhTJqGCFkw9c2+qd47fhju4
         HWV6xJsx9TRMflIeT31NaaMKm1z1/KLVcuX8jZj0YRBX6/YFyuQ1dkMbRdcwd8fc9W3t
         4jQO8q5JN59e97d/kConO++lKr1Wheu9yTRx7RREsIsXaLFKy0K4UMYqeuLYXA36hB8P
         NHsDjDYdTP2F/XdmBZFUpGF3vFlVEWvUOoBvcx6/gKICqqb8huJzFZr8lLOmYZyv8FWL
         QfignBo+Kz6l0yY6JHnk3OiiGyv6tVqYjbUmWV0lAItcLSKoGZYuTBTIQvHhvBtUyn5d
         Ikuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693408653; x=1694013453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PeStNgIFyhYkU5cmLWBgd4BV9abdD1hSxAhShc4Rniw=;
        b=HD+CYhL/tBW3VSWWD9OjUS5JPW1hzzYopTV9Szb2dvI67sJjPQDJ97T4aznBNYqMG/
         gmy6krR6MRLxHTPaz1XedtQp3VYvEZNz3dWZbI7Og+zAWjEZRsoC8mn7T1BsG4SoclkU
         cUx07MJyqaZ+5vpV5MGADHA9V24u8bVua3yTv78WG1wVRj7+ltCu4Aez4AAljp3ppp/b
         p8o7rB6HbuBQeEvV2A91FU3UZOOM863IfCgZvKg4cq9dgFsj/W8ob5ntlEvt+Np+bTPG
         XpLJVnnIhJEYcGh0PlARH0QpaKXlqaRCwewxkJfmMzTi8p3aKEyvY6gIPmd/X73ZIH30
         PDTQ==
X-Gm-Message-State: AOJu0Yz1BlBApygasKe7Y+63REQnv9NlSqGQfBfPtr/u+VSpc9uHnBAU
	dg4mdYww3tAIYQKz6rorA10=
X-Google-Smtp-Source: AGHT+IHGprUSVMZhj6MIp3VxMSV5tq1dagJ2Ilu7ATS68B26J+0S0NPcz835UxBmvHI0Sj0UZfA1cA==
X-Received: by 2002:a05:600c:3b8c:b0:401:b0f8:c26a with SMTP id n12-20020a05600c3b8c00b00401b0f8c26amr2117752wms.4.1693408653156;
        Wed, 30 Aug 2023 08:17:33 -0700 (PDT)
Received: from localhost.localdomain (h-176-10-144-222.NA.cust.bahnhof.se. [176.10.144.222])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c299300b003fe539b83f2sm2546562wmd.42.2023.08.30.08.17.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Aug 2023 08:17:32 -0700 (PDT)
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
Subject: [PATCH bpf] xsk: fix xsk_diag use-after-free error during socket cleanup
Date: Wed, 30 Aug 2023 17:17:03 +0200
Message-ID: <20230830151704.14855-1-magnus.karlsson@gmail.com>
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
is used at the same time as the socket is being closed. In the early
days of AF_XDP, the way we tested that a socket was not bound or being
closed was to simply check if the netdevice pointer in the xsk socket
structure was NULL. Later, a better system was introduced by having an
explicit state variable in the xsk socket struct. For example, the
state of a socket that is going down is XSK_UNBOUND.

The commit in the Fixes tag below deleted the old way of signalling
that a socket is going down, setting dev to NULL. This in the belief
that all code using the old way had been exterminated. That was
unfortunately not true as the xsk diagnostics code was still using the
old way and thus does not work as intended when a socket is going
down. Fix this by introducing a test against the state variable. If
the socket is going down, simply abort the diagnostic's netlink
operation.

Fixes: 18b1ab7aa76b ("xsk: Fix race at socket teardown")
Reported-by: syzbot+822d1359297e2694f873@syzkaller.appspotmail.com
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 net/xdp/xsk_diag.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
index c014217f5fa7..da3100bfa1c5 100644
--- a/net/xdp/xsk_diag.c
+++ b/net/xdp/xsk_diag.c
@@ -111,6 +111,9 @@ static int xsk_diag_fill(struct sock *sk, struct sk_buff *nlskb,
 	sock_diag_save_cookie(sk, msg->xdiag_cookie);
 
 	mutex_lock(&xs->mutex);
+	if (xs->state == XSK_UNBOUND)
+		goto out_nlmsg_trim;
+
 	if ((req->xdiag_show & XDP_SHOW_INFO) && xsk_diag_put_info(xs, nlskb))
 		goto out_nlmsg_trim;
 

base-commit: 35d2b7ffffc1d9b3dc6c761010aa3338da49165b
-- 
2.42.0


