Return-Path: <bpf+bounces-7364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AE3776277
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 16:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A0A281CAB
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 14:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2E619BC5;
	Wed,  9 Aug 2023 14:29:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A596A612D;
	Wed,  9 Aug 2023 14:29:18 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6FF1FF9;
	Wed,  9 Aug 2023 07:29:17 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe3194d21dso15096095e9.1;
        Wed, 09 Aug 2023 07:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691591356; x=1692196156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=73eRUGfwkt25WcurW3rGru/jFR5+pcf7QJ36XKVJi5M=;
        b=CaOG1bmdkZ8k4xGI4MPDimzBWYTgnq86V3QGLKHrNvz6tyed+ICJbx298mQDxgV5nR
         6+EhLtsjYA6m6vG+rFGT0pyQRVLeJbO/5gpbTE1M9eFdKjuH0aO90ikqDVA2FrmvYuYq
         utGUa9VLuIM5escYbabCsxypkzlID83SLSzTA5qbb5GOOxsyIlO06dtjMDmTDLGxioYo
         ccRjwP+E5rpc/pimLEj+/kn5vhm2FS+r181WJLdGqfaS0HwSAIlMkmuHUbyXCDkqJCDY
         oxcJIxhY+QrKcfWEeb9raKZ/zB0ah9ssN718vEYnz34x7Dvox4+caqPjS1iD7mGepfwZ
         oOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691591356; x=1692196156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=73eRUGfwkt25WcurW3rGru/jFR5+pcf7QJ36XKVJi5M=;
        b=fGIhp5AGu+5NuOrWpd2gN7qQJtgKMb/oRg8gqZ74OFnyOtzHNa0PUcHADOD5rR0PrE
         ON9C1KF1tcBqFLymblIHBsDlzgVXT8//sKezgEI/n9CXu23D5yPtuwP0I/W9z34VpvWM
         YXLbvLevjcsKraF4X/bATWct8vk8TyuhTCKZiF3f6iDlY5E++LcYB+Grvy08oSaluBi5
         do7Ikme8DCtxCehRhbr69kAo0RA8djnZbAn/LedOdxMpkQ3j9DDtm/c0Db3xcuBJM5OO
         uxxR9RsajZj7gR48SlTwiappOFTaaZjIl2bSazEOPJ4fntKtOFl5EqVnmZm2wWi4+6U6
         9NnQ==
X-Gm-Message-State: AOJu0YyxTKAFMch3KRugjmBp6azLh2lkWY7UCuJezW22RHQ1zRyzUW2h
	J3H5kvwyYbnYIf0ty0KED7whZtq9TvDZZ8rd
X-Google-Smtp-Source: AGHT+IHRBtrRy0QNoKjpcRvhs6EnXXCrRqQT4AJcfmdlljuHQQykbXzS7Zb182WXS+Ls0u06VnWq7g==
X-Received: by 2002:a05:600c:601b:b0:3f9:bf0e:a312 with SMTP id az27-20020a05600c601b00b003f9bf0ea312mr2454270wmb.1.1691591355511;
        Wed, 09 Aug 2023 07:29:15 -0700 (PDT)
Received: from localhost.localdomain (c-5eea7243-74736162.cust.telenor.se. [94.234.114.67])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c22ce00b003fba2734f1esm2181793wmg.1.2023.08.09.07.29.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Aug 2023 07:29:15 -0700 (PDT)
From: Magnus Karlsson <magnus.karlsson@gmail.com>
To: magnus.karlsson@intel.com,
	bjorn@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	maciej.fijalkowski@intel.com
Cc: jonathan.lemon@gmail.com,
	bpf@vger.kernel.org,
	syzbot+8ada0057e69293a05fd4@syzkaller.appspotmail.com
Subject: [PATCH bpf] xsk: fix refcount underflow in error path
Date: Wed,  9 Aug 2023 16:28:43 +0200
Message-Id: <20230809142843.13944-1-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Magnus Karlsson <magnus.karlsson@intel.com>

Fix a refcount underflow problem reported by syzbot that can happen
when a system is running out of memory. If xp_alloc_tx_descs() fails,
and it can only fail due to not having enough memory, then the error
path is triggered. In this error path, the refcount of the pool is
decremented as it has incremented before. However, the reference to
the pool in the socket was not nulled. This means that when the socket
is closed later, the socket teardown logic will think that there is a
pool attached to the socket and try to decrease the refcount again,
leading to a refcount underflow.

I chose this fix as it involved adding just a single line. Another
option would have been to move xp_get_pool() and the assignment of
xs->pool to after the if-statement and using xs_umem->pool instead of
xs->pool in the whole if-statement resulting in somewhat simpler code,
but this would have led to much more churn in the code base perhaps
making it harder to backport.

Fixes: ba3beec2ec1d ("xsk: Fix possible crash when multiple sockets are created")
Reported-by: syzbot+8ada0057e69293a05fd4@syzkaller.appspotmail.com
Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 net/xdp/xsk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index b89adb52a977..10ea85c03147 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -994,6 +994,7 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 				err = xp_alloc_tx_descs(xs->pool, xs);
 				if (err) {
 					xp_put_pool(xs->pool);
+					xs->pool = NULL;
 					sockfd_put(sock);
 					goto out_unlock;
 				}

base-commit: 999f6631866e9ea81add935b9c6ebaab0579d259
-- 
2.34.1


