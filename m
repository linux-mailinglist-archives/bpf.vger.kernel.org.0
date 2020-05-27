Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606131E4595
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 16:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbgE0OR5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 May 2020 10:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387755AbgE0OR5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 May 2020 10:17:57 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3758C08C5C2
        for <bpf@vger.kernel.org>; Wed, 27 May 2020 07:17:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f5so3200903wmh.2
        for <bpf@vger.kernel.org>; Wed, 27 May 2020 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YH1v8wKe1VUKWAjGTwnWnKdT9B4ah56ml0/ndiIz5io=;
        b=jBKa01d6epycwm2tJPgKP5MJmpfECW/858iC9R+HX+08ZSdRe1VOune12GU5FSK6jL
         9ch+4WqcdFqtQm1Uw+0hpM8lDcfTvLDZZoF4N/Nxuz5BB5rrZjHqDr6pE2iuPToiG2h7
         Z5zDJ2TE/ReBM6Aoi/RDfJTpsoxuPWS1pwkhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YH1v8wKe1VUKWAjGTwnWnKdT9B4ah56ml0/ndiIz5io=;
        b=Gt7dKry3z0xMkEkuReTrXwZgMjLIJgCkjrB97cFEyDnWXgmmZlAdqsWJUdN0id1BHg
         HHYMnNQQsfNP55PsbyWhPAau6iJ5lrIDvth8Ap89zzybomM+2n1gWoFiq7i6onsG7jLP
         GWPqp/J93n5ao7jYa8p1fRix8QJVqL3pGsdQeNHgsR/L9kQfcTyd0yQFz/IrC0G/1WFV
         4dZVfuvhBGk50Qm3eHTRpMSXk65VdVd20s3C9sdeOGpCRdpdC5rjEfWV+tBRcCCKG7X4
         +UoFzj/+q8eXIT6KlpP5owkpQrczNpK8zzAXq6/znN3PgzW5+KU3oYzU9GnaL6gJ8C6e
         V5+Q==
X-Gm-Message-State: AOAM533qTdS7JhYfoH+JO4ZiNVO/mRpKWYqRoU6K1ZI7yGN6HUbZamVF
        PMWQsU+vyAIGZjJaJbnSVsSY9Q==
X-Google-Smtp-Source: ABdhPJwWguHm0Lnqvgwm14E6sIExIuStJrZLuVvOVvX+cd+cFq+0BnVHHJ+F5pSSo7Tq7jwp6YH5nA==
X-Received: by 2002:a05:600c:2256:: with SMTP id a22mr4092817wmm.18.1590589075512;
        Wed, 27 May 2020 07:17:55 -0700 (PDT)
Received: from kpsingh.zrh.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id o15sm3026908wrv.48.2020.05.27.07.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 07:17:55 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Brendan Jackman <jackmanb@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] fs: Add an explicit might_sleep() to iput
Date:   Wed, 27 May 2020 16:17:53 +0200
Message-Id: <20200527141753.101163-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

It is currently mentioned in the comments to the function that iput
might sleep when the inode is destroyed. Have it call might_sleep, as
dput already does.

Adding an explicity might_sleep() would help in quickly realizing that
iput is called from a place where sleeping is not allowed when
CONFIG_DEBUG_ATOMIC_SLEEP is enabled as noticed in the dicussion:

  https://lore.kernel.org/bpf/20200527021111.GA197666@google.com/

Signed-off-by: KP Singh <kpsingh@google.com>
Reviewed-by: Brendan Jackman <jackmanb@chromium.org>
---
 fs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/inode.c b/fs/inode.c
index cc6e701b7e5d..f55e72e76266 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1583,6 +1583,7 @@ static void iput_final(struct inode *inode)
  */
 void iput(struct inode *inode)
 {
+	might_sleep();
 	if (!inode)
 		return;
 	BUG_ON(inode->i_state & I_CLEAR);
-- 
2.27.0.rc0.183.gde8f92d652-goog

